package com.controlcentre.audit.yearendclose;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsYearEndCloseDAO {
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsYearEndCloseBean yearEndCloseBean = new ClsYearEndCloseBean();
	
	ClsCommon ClsCommon=new ClsCommon();
	
	public int insert(Date yearEndCloseDate, String formdetailcode, Date yearToCloseFromDate, Date yearToCloseToDate, Date nextAccountingYearFromDate, Date nextAccountingYearToDate,
			double txtnettotal,ArrayList<String> yearendclosearray, ArrayList<String> yearendclosegrouparray, HttpSession session, HttpServletRequest request, String mode) throws SQLException {
		
		Connection conn = null;
		
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString();
			int total = 0;
			
			CallableStatement stmtYRC = conn.prepareCall("{CALL yearEndClosemDML(?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtYRC.registerOutParameter(9, java.sql.Types.INTEGER);
			stmtYRC.registerOutParameter(10, java.sql.Types.INTEGER);
			
			stmtYRC.setDate(1,yearEndCloseDate);
			stmtYRC.setDate(2,nextAccountingYearFromDate);
			stmtYRC.setDate(3,nextAccountingYearToDate);
			stmtYRC.setDate(4,yearToCloseFromDate);
			stmtYRC.setDate(5,yearToCloseToDate);
			stmtYRC.setString(6,formdetailcode);
			stmtYRC.setString(7,branch);
			stmtYRC.setString(8,userid);
			stmtYRC.setString(11,mode);
			int datas=stmtYRC.executeUpdate();
						if(datas<=0){
				stmtYRC.close();
				conn.close();
				return 0;
			}
			int docno=stmtYRC.getInt("docNo");
			int trno=stmtYRC.getInt("itranNo");
			request.setAttribute("tranno", trno);
			yearEndCloseBean.setTxtyearendclosedocno(docno);
			if (docno > 0) {

				int JvDocNo=0;
				if(yearendclosearray.size()>0){
					
					String sqls = "select Coalesce((max(doc_no)+1),1) as docNo from my_jvma where dtype='JVT' and brhId="+branch+"";
					ResultSet resultSets = stmtYRC.executeQuery(sqls);
				    
					 while (resultSets.next()) {
						 JvDocNo=resultSets.getInt("docNo");
					 }
					
					String sql="insert into my_jvma(date, description,  drtot, crtot, trtype,  refNo, xentbr, YearId, refId, brhId,cmpid, userid, dtype,doc_no, tr_no,status) "
							+ "VALUES('"+yearEndCloseDate+"', 'YEAR END CLOSED ON "+yearEndCloseDate+"',  "+txtnettotal+", "+txtnettotal+", 4,  'YRC - "+docno+"',"+branch+","
							+ "1, 10, "+branch+","+company+", "+userid+", 'JVT',"+JvDocNo+", "+trno+",3)";
					int data = stmtYRC.executeUpdate(sql);
					if(data<=0){
						stmtYRC.close();
						conn.close();
						return 0;
					}
					
					/*Insertion to my_jvtran*/
					int insertData=insertion(conn, JvDocNo, trno, formdetailcode, yearEndCloseDate, yearendclosearray, yearendclosegrouparray, session,mode);
					if(insertData<=0){
						stmtYRC.close();
						conn.close();
						return 0;
					}
					/*Insertion to my_jvtran Ends*/
				}
				
				String sql1="update my_year set CL_STAT=1 where CL_STAT=0 and ACCYR_F='"+nextAccountingYearFromDate+"'";
				int data1 = stmtYRC.executeUpdate(sql1);
				if(data1<=0){
					stmtYRC.close();
					conn.close();
					return 0;
				}
				
				String sql2="insert into my_year(COMP_ID, ACCYR_F, ACCYR_T, CL_STAT, CMPID, BRHID) values(0"+company+", '"+yearToCloseFromDate+"', '"+yearToCloseToDate+"', 0, "+company+", "+branch+")";
				int data2 = stmtYRC.executeUpdate(sql2);
				if(data2<=0){
					stmtYRC.close();
					conn.close();
					return 0;
				}
				
				
				String sql3="update my_brch set ACCYEAR_F='"+yearToCloseFromDate+"',ACCYEAR_T='"+yearToCloseToDate+"' where CMPID="+company+"";
				int data3 = stmtYRC.executeUpdate(sql3);
				if(data3<=0){
					stmtYRC.close();
					conn.close();
					return 0;
				}
				
				String sql4="update my_comp set ACCYEAR_F='"+yearToCloseFromDate+"',ACCYEAR_T='"+yearToCloseToDate+"' where DOC_NO="+company+"";
				int data4 = stmtYRC.executeUpdate(sql4);
				if(data4<=0){
					stmtYRC.close();
					conn.close();
					return 0;
				}
				
				String sql5="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
				ResultSet resultSet = stmtYRC.executeQuery(sql5);
			    
				 while (resultSet.next()) {
					 total=resultSet.getInt("jvtotal");
				 }
				
				 if(total == 0){
					conn.commit();
					stmtYRC.close();
					conn.close();
					return docno;
				 }else{
					System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
					stmtYRC.close();
					return 0;
				 }
			}
			
			stmtYRC.close();
			conn.close();
	 }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }finally{
		 conn.close();
	 }
		return 0;
	}

	public boolean edit(int txtyearendclosedocno, String formdetailcode, Date yearEndCloseDate, Date yearToCloseFromDate, Date yearToCloseToDate, Date nextAccountingYearFromDate,
			Date nextAccountingYearToDate, int txttrno, ArrayList<String> yearendclosearray, ArrayList<String> yearendclosegrouparray, HttpSession session, String mode)  throws SQLException {
		
		Connection conn = null;
	 	
		 try{
			    conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
			
				Statement stmtYRC1 = conn.createStatement();
				int trno = txttrno,total=0;
			    
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				CallableStatement stmtYRC = conn.prepareCall("{CALL yearEndClosemDML(?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtYRC.registerOutParameter(9, java.sql.Types.INTEGER);
				stmtYRC.registerOutParameter(10, java.sql.Types.INTEGER);
				
				stmtYRC.setDate(1,yearEndCloseDate);
				stmtYRC.setDate(2,nextAccountingYearFromDate);
				stmtYRC.setDate(3,nextAccountingYearToDate);
				stmtYRC.setDate(4,yearToCloseFromDate);
				stmtYRC.setDate(5,yearToCloseToDate);
				stmtYRC.setString(6,formdetailcode);
				stmtYRC.setString(7,branch);
				stmtYRC.setString(8,userid);
				stmtYRC.setString(11,mode);
				int datas=stmtYRC.executeUpdate();
				if(datas<=0){
					stmtYRC.close();
					conn.close();
					return false;
				}
				 
				 String sql=("DELETE FROM my_jvtran WHERE TR_NO="+trno+"");
				 int data = stmtYRC1.executeUpdate(sql);
			    
			    int docno=txtyearendclosedocno;
			    yearEndCloseBean.setTxtyearendclosedocno(docno);
				if (docno > 0) {
				
					/*Insertion to my_jvtran*/
					int insertData=insertion(conn, docno, trno, formdetailcode, yearEndCloseDate, yearendclosearray, yearendclosegrouparray, session,mode);
					if(insertData<=0){
						stmtYRC1.close();
						conn.close();
						return false;
					}
					/*Insertion to my_jvtran Ends*/
					
					String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
					ResultSet resultSet = stmtYRC1.executeQuery(sql1);
				    
					 while (resultSet.next()) {
					 total=resultSet.getInt("jvtotal");
					 }
					 
					 if(total == 0){
						conn.commit();
						stmtYRC1.close();
						conn.close();
						return true;
					 }else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
				        stmtYRC1.close();
					    return false;
				    }
				}
				stmtYRC1.close();
			    conn.close();
		 }catch(Exception e){
			 	e.printStackTrace();
			 	conn.close();
			 	return false;
		 }finally{
			 conn.close();
		 }
			return false;
	}

	public boolean delete(int docno, String formdetailcode, HttpSession session, String mode) throws SQLException {

		Connection conn=null;

		 try{
			    conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
			
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				CallableStatement stmtYRC = conn.prepareCall("{CALL yearEndClosemDML(?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtYRC.registerOutParameter(9, java.sql.Types.INTEGER);
				stmtYRC.registerOutParameter(10, java.sql.Types.INTEGER);
				
				stmtYRC.setDate(1,null);
				stmtYRC.setDate(2,null);
				stmtYRC.setDate(3,null);
				stmtYRC.setDate(4,null);
				stmtYRC.setDate(5,null);
				stmtYRC.setString(6,formdetailcode);
				stmtYRC.setString(7,branch);
				stmtYRC.setString(8,userid);
				stmtYRC.setString(11,mode);
				int datas=stmtYRC.executeUpdate();
				if(datas<=0){
					stmtYRC.close();
					conn.close();
					return false;
				}
			
				conn.commit();
				stmtYRC.close();
			    conn.close();
				return true;
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		
		return false;
	}
		

	public JSONArray yearEndCloseGridLoading(String accountingYearFrom,String ycloseDateFrom,String yearEndDate) throws SQLException {
    	JSONArray RESULTDATA=new JSONArray();

	    Connection conn=null;
  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtYRC  = conn.createStatement(); 
            	
				java.sql.Date sqlAccountingYearFrom=null;
				java.sql.Date sqlYcloseDateFrom=null;
				java.sql.Date sqlyearEndDate=null;
				
				accountingYearFrom.trim();
	            if(!(accountingYearFrom.equalsIgnoreCase("undefined"))&&!(accountingYearFrom.equalsIgnoreCase(""))&&!(accountingYearFrom.equalsIgnoreCase("0"))) {
	        	   sqlAccountingYearFrom = ClsCommon.changeStringtoSqlDate(accountingYearFrom);
	            }
			         
	           ycloseDateFrom.trim();
	           if(!(ycloseDateFrom.equalsIgnoreCase("undefined"))&&!(ycloseDateFrom.equalsIgnoreCase(""))&&!(ycloseDateFrom.equalsIgnoreCase("0"))) {
	        	   sqlYcloseDateFrom = ClsCommon.changeStringtoSqlDate(ycloseDateFrom);
	           }
	           
	           yearEndDate.trim();
	           if(!(yearEndDate.equalsIgnoreCase("undefined"))&&!(yearEndDate.equalsIgnoreCase(""))&&!(yearEndDate.equalsIgnoreCase("0"))) {
	        	   sqlyearEndDate = ClsCommon.changeStringtoSqlDate(yearEndDate);
	           }
		           
				String sql="select j.brhid,j.acno docno,h.account,h.description accountname,sum(j.ldramount) amount,'YEAR END CLOSED ON "+yearEndDate+"' description,j.curid currencyid,j.rate " + 
						"from (select date,brhid,curid,rate,acno,ldramount from my_jvtran where status=3 and coalesce(date,'"+sqlyearEndDate+"')>='"+sqlAccountingYearFrom+"' " + 
						"and date<='"+sqlyearEndDate+"') j left join my_head h on j.acno=h.doc_no where h.gr_type in (4,5) group by j.brhid,j.acno having sum(j.ldramount)!=0 order by h.den,h.alevel ";
				 System.out.println("===== "+sql);
				ResultSet resultSet = stmtYRC.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
//				System.out.println("===== "+RESULTDATA);
				stmtYRC.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray yearEndCloseProYearGridLoading(String accountingYearFrom,String ycloseDateFrom,String yearEndDate) throws SQLException {
    	JSONArray RESULTDATA=new JSONArray();

	    Connection conn=null;
  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtYRC  = conn.createStatement(); 
            	
				java.sql.Date sqlAccountingYearFrom=null;
				java.sql.Date sqlYcloseDateFrom=null;
				java.sql.Date sqlyearEndDate=null;
				
				accountingYearFrom.trim();
	            if(!(accountingYearFrom.equalsIgnoreCase("undefined"))&&!(accountingYearFrom.equalsIgnoreCase(""))&&!(accountingYearFrom.equalsIgnoreCase("0"))) {
	        	   sqlAccountingYearFrom = ClsCommon.changeStringtoSqlDate(accountingYearFrom);
	            }
			         
	           ycloseDateFrom.trim();
	           if(!(ycloseDateFrom.equalsIgnoreCase("undefined"))&&!(ycloseDateFrom.equalsIgnoreCase(""))&&!(ycloseDateFrom.equalsIgnoreCase("0"))) {
	        	   sqlYcloseDateFrom = ClsCommon.changeStringtoSqlDate(ycloseDateFrom);
	           }
	           
	           yearEndDate.trim();
	           if(!(yearEndDate.equalsIgnoreCase("undefined"))&&!(yearEndDate.equalsIgnoreCase(""))&&!(yearEndDate.equalsIgnoreCase("0"))) {
	        	   sqlyearEndDate = ClsCommon.changeStringtoSqlDate(yearEndDate);
	           }
	          
				/*String sql="select (select m.acno from my_account m left join my_head h on m.acno=h.doc_no where m.codeno='PRO_YEAR') docno,j.brhid,h.account,h.description accountname,"
						+ "sum(j.ldramount) amount,'YEAR END CLOSED ON "+yearEndDate+"' description,j.curid currencyid,j.rate from (select date,brhid,curid,rate,acno,ldramount from my_jvtran where status=3 and "
						+ "coalesce(date,'"+sqlyearEndDate+"')>='"+sqlAccountingYearFrom+"' and date<='"+sqlYcloseDateFrom+"') j left join my_head h on (select m.acno from "
						+ "my_account m left join my_head h on m.acno=h.doc_no where m.codeno='PRO_YEAR')=h.doc_no where h.gr_type in (4,5) group by j.brhid having sum(j.ldramount)!=0 order by h.den,h.alevel";*/
						
				 String sql="select a.brhid,(select m.acno from my_account m left join my_head h on m.acno=h.doc_no where m.codeno='PRO_YEAR') docno,h1.account,h1.description accountname,a.amount,a.description,"
	        		   + "h1.curid currencyid,h1.rate from (select j.brhid,sum(j.ldramount) amount,'YEAR END CLOSED ON "+yearEndDate+"' description,j.curid currencyid,j.rate from (select date,brhid,curid,rate,"
	        		   + "acno,ldramount from my_jvtran where status=3 and coalesce(date,'"+sqlyearEndDate+"')>='"+sqlAccountingYearFrom+"' and date<='"+sqlyearEndDate+"') j left join my_head h on j.acno=h.doc_no "
	        		   + "where h.gr_type in (4,5) group by j.brhid having sum(j.ldramount)!=0 order by h.den,h.alevel) a left join my_head h1 on (select m.acno from my_account m left join my_head h on m.acno=h.doc_no "
	        		   + "where m.codeno='PRO_YEAR')=h1.doc_no order by h1.den,h1.alevel";		
//System.out.println("===="+sql);				
				ResultSet resultSet = stmtYRC.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);

				stmtYRC.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray yearEndCloseGridReloading(String trno) throws SQLException {
    	JSONArray RESULTDATA=new JSONArray();

	    Connection conn=null;
  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtYRC  = conn.createStatement(); 
            	
				String sql="select j.brhid,j.acno docno,h.account,h.description accountname,j.dramount amount,j.description,j.curid currencyid,j.rate from " 
						+ "my_jvtran j left join my_head h on j.acno=h.doc_no where j.status=3 and j.acno!=(select acno from my_account where codeno='PRO_YEAR') "  
						+ "and j.tr_no="+trno+" order by h.den,h.alevel";
				
				ResultSet resultSet = stmtYRC.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);

				stmtYRC.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray yearEndCloseProYearGridReloading(String trno) throws SQLException {
    	JSONArray RESULTDATA=new JSONArray();

	    Connection conn=null;
  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtYRC  = conn.createStatement(); 
            	
				String sql="select j.brhid,j.acno docno,h.account,h.description accountname,j.dramount amount,j.description,j.curid currencyid,j.rate from " 
						+ "my_jvtran j left join my_head h on j.acno=h.doc_no where j.status=3 and j.acno=(select acno from my_account where codeno='PRO_YEAR') "  
						+ "and j.tr_no="+trno+" order by h.den,h.alevel";
				
				ResultSet resultSet = stmtYRC.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);

				stmtYRC.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public  JSONArray yrcMainSearch(HttpSession session,String docNo,String date,String yrcAccFrmDate,String yrcAccToDate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
           
        Enumeration<String> Enumeration = session.getAttributeNames();
           int a=0;
           while(Enumeration.hasMoreElements()){
            if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
             a=1;
            }
           }
           if(a==0){
         return RESULTDATA;
            }
        
         String branch=session.getAttribute("BRANCHID").toString();
       
        java.sql.Date sqlYearCloseDate=null;
        java.sql.Date sqlAccountingFromDate=null;
        java.sql.Date sqlAccountingToDate=null;
        
        date.trim();
        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))) {
        	sqlYearCloseDate = ClsCommon.changeStringtoSqlDate(date);
        }
        
        yrcAccFrmDate.trim();
        if(!(yrcAccFrmDate.equalsIgnoreCase("undefined"))&&!(yrcAccFrmDate.equalsIgnoreCase(""))&&!(yrcAccFrmDate.equalsIgnoreCase("0"))) {
        	sqlAccountingFromDate = ClsCommon.changeStringtoSqlDate(yrcAccFrmDate);
        }
        
        yrcAccToDate.trim();
        if(!(yrcAccToDate.equalsIgnoreCase("undefined"))&&!(yrcAccToDate.equalsIgnoreCase(""))&&!(yrcAccToDate.equalsIgnoreCase("0"))) {
        	sqlAccountingToDate = ClsCommon.changeStringtoSqlDate(yrcAccToDate);
        }

        String sqltest="";
        
        if(!(docNo.equalsIgnoreCase(""))){
            sqltest=sqltest+" and doc_no like '%"+docNo+"%'";
        }
        if(!(sqlYearCloseDate==null)){
	         sqltest=sqltest+" and date='"+sqlYearCloseDate+"'";
	    }
        if(!(sqlAccountingFromDate==null)){
	         sqltest=sqltest+" and yearclose_from='"+sqlAccountingFromDate+"'";
	    }
        if(!(sqlAccountingToDate==null)){
	         sqltest=sqltest+" and yearclose_to='"+sqlAccountingToDate+"'";
	    } 
           
     try {
	       conn = ClsConnection.getMyConnection();
	       Statement stmtYRC = conn.createStatement();
	       
	       ResultSet resultSet = stmtYRC.executeQuery("select date,doc_no,yearclose_from,yearclose_to, nextyear_from, nextyear_to, tr_no from my_yearendclose where status=3" +sqltest);
	
	       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	       
	       stmtYRC.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
 		conn.close();
 	}
       return RESULTDATA;
   }
 	
   public int insertion(Connection conn,int docno,int trno,String formdetailcode,Date yearEndCloseDate, ArrayList<String> yearendclosearray,ArrayList<String> yearendclosegrouparray,
			 HttpSession session,String mode) throws SQLException{
		     
		  try{
				CallableStatement stmtYRC;
				Statement stmtYRC1 = conn.createStatement();
				
//				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				/*Year End Close Grid and Details Saving*/
				for(int i=0;i< yearendclosearray.size();i++){
					String[] yearendclose=yearendclosearray.get(i).split("::");
					if(!yearendclose[0].trim().equalsIgnoreCase("undefined") && !yearendclose[0].trim().equalsIgnoreCase("NaN")){
					
					int cash = 0;
					if(yearendclose[3].trim().equalsIgnoreCase("1")){
						cash=0;
					}
					else if(yearendclose[3].trim().equalsIgnoreCase("-1")){
						cash=1;
					}
					
					stmtYRC = conn.prepareCall("{CALL yearEndClosedDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					/*Insertion to my_jvtran*/
					stmtYRC.setInt(15,trno); 
					stmtYRC.setInt(16,docno);
					stmtYRC.setString(1,(yearendclose[0].trim().equalsIgnoreCase("undefined") || yearendclose[0].trim().equalsIgnoreCase("NaN") || yearendclose[0].trim().isEmpty()?0:yearendclose[0].trim()).toString());  //doc_no of my_head
					stmtYRC.setString(2,(yearendclose[1].trim().equalsIgnoreCase("undefined") || yearendclose[1].trim().equalsIgnoreCase("NaN") || yearendclose[1].trim().isEmpty()?0:yearendclose[1].trim()).toString()); //curId
					stmtYRC.setString(3,(yearendclose[2].trim().equalsIgnoreCase("undefined") || yearendclose[2].trim().equalsIgnoreCase("NaN") || yearendclose[2].trim().equals(0) || yearendclose[2].trim().isEmpty()?1:yearendclose[2].trim()).toString()); //rate 
					stmtYRC.setString(4,(yearendclose[3].trim().equalsIgnoreCase("undefined") || yearendclose[3].trim().equalsIgnoreCase("NaN") || yearendclose[3].trim().isEmpty()?0:yearendclose[3].trim()).toString()); //#credit -1 / debit 1 
					stmtYRC.setString(5,(yearendclose[4].trim().equalsIgnoreCase("undefined") || yearendclose[4].trim().equalsIgnoreCase("NaN") || yearendclose[4].trim().isEmpty()?0:yearendclose[4].trim()).toString()); //amount
					stmtYRC.setString(6,(yearendclose[5].trim().equalsIgnoreCase("undefined") || yearendclose[5].trim().equalsIgnoreCase("NaN") || yearendclose[5].trim().isEmpty()?0:yearendclose[5].trim()).toString()); //description
					stmtYRC.setString(7,(yearendclose[6].trim().equalsIgnoreCase("undefined") || yearendclose[6].trim().equalsIgnoreCase("NaN") || yearendclose[6].trim().isEmpty()?0:yearendclose[6].trim()).toString()); //baseamount
					stmtYRC.setInt(8,cash); //For cash = 0/ party = 1
					
					stmtYRC.setDate(9,yearEndCloseDate);
					stmtYRC.setString(10,"YRC - "+docno);
					stmtYRC.setString(11,(yearendclose[3].trim().equalsIgnoreCase("undefined") || yearendclose[3].trim().equalsIgnoreCase("NaN") || yearendclose[3].trim().isEmpty()?0:yearendclose[3].trim()).toString());  //id
					/*my_jvtran Ends*/
					
					stmtYRC.setString(12,formdetailcode);
					stmtYRC.setString(13,(yearendclose[7].trim().equalsIgnoreCase("undefined") || yearendclose[7].trim().equalsIgnoreCase("NaN") || yearendclose[7].trim().isEmpty()?0:yearendclose[7].trim()).toString());
					stmtYRC.setString(14,userid);
					stmtYRC.setString(17,mode);
					int detail=stmtYRC.executeUpdate();
						if(detail<=0){
							stmtYRC.close();
							conn.close();
							return 0;
						}
     				  }
				    }
				    /*Year End Close Grid and Details Saving Ends*/
				
				/*Year End Close Group Grid and Details Saving*/
				for(int i=0;i< yearendclosegrouparray.size();i++){
					String[] yearendclose=yearendclosegrouparray.get(i).split("::");
					if(!yearendclose[0].trim().equalsIgnoreCase("undefined") && !yearendclose[0].trim().equalsIgnoreCase("NaN")){
					
					int cash = 0;
					if(yearendclose[3].trim().equalsIgnoreCase("1")){
						cash=0;
					}
					else if(yearendclose[3].trim().equalsIgnoreCase("-1")){
						cash=1;
					}
					
					stmtYRC = conn.prepareCall("{CALL yearEndClosedDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					/*Insertion to my_jvtran*/
					stmtYRC.setInt(15,trno); 
					stmtYRC.setInt(16,docno);
					stmtYRC.setString(1,(yearendclose[0].trim().equalsIgnoreCase("undefined") || yearendclose[0].trim().equalsIgnoreCase("NaN") || yearendclose[0].trim().isEmpty()?0:yearendclose[0].trim()).toString());  //doc_no of my_head
					stmtYRC.setString(2,(yearendclose[1].trim().equalsIgnoreCase("undefined") || yearendclose[1].trim().equalsIgnoreCase("NaN") || yearendclose[1].trim().isEmpty()?0:yearendclose[1].trim()).toString()); //curId
					stmtYRC.setString(3,(yearendclose[2].trim().equalsIgnoreCase("undefined") || yearendclose[2].trim().equalsIgnoreCase("NaN") || yearendclose[2].trim().equals(0) || yearendclose[2].trim().isEmpty()?1:yearendclose[2].trim()).toString()); //rate 
					stmtYRC.setString(4,(yearendclose[3].trim().equalsIgnoreCase("undefined") || yearendclose[3].trim().equalsIgnoreCase("NaN") || yearendclose[3].trim().isEmpty()?0:yearendclose[3].trim()).toString()); //#credit -1 / debit 1 
					stmtYRC.setString(5,(yearendclose[4].trim().equalsIgnoreCase("undefined") || yearendclose[4].trim().equalsIgnoreCase("NaN") || yearendclose[4].trim().isEmpty()?0:yearendclose[4].trim()).toString()); //amount
					stmtYRC.setString(6,(yearendclose[5].trim().equalsIgnoreCase("undefined") || yearendclose[5].trim().equalsIgnoreCase("NaN") || yearendclose[5].trim().isEmpty()?0:yearendclose[5].trim()).toString()); //description
					stmtYRC.setString(7,(yearendclose[4].trim().equalsIgnoreCase("undefined") || yearendclose[4].trim().equalsIgnoreCase("NaN") || yearendclose[4].trim().isEmpty()?0:yearendclose[4].trim()).toString()); //baseamount
					stmtYRC.setInt(8,cash); //For cash = 0/ party = 1
					
					stmtYRC.setDate(9,yearEndCloseDate);
					stmtYRC.setString(10,"YRC - "+docno);
					stmtYRC.setString(11,(yearendclose[3].trim().equalsIgnoreCase("undefined") || yearendclose[3].trim().equalsIgnoreCase("NaN") || yearendclose[3].trim().isEmpty()?0:yearendclose[3].trim()).toString());  //id
					/*my_jvtran Ends*/
					
					stmtYRC.setString(12,formdetailcode);
					stmtYRC.setString(13,(yearendclose[7].trim().equalsIgnoreCase("undefined") || yearendclose[7].trim().equalsIgnoreCase("NaN") || yearendclose[7].trim().isEmpty()?0:yearendclose[7].trim()).toString());
					stmtYRC.setString(14,userid);
					stmtYRC.setString(17,mode);
					int detail1=stmtYRC.executeUpdate();
						if(detail1<=0){
							stmtYRC.close();
							conn.close();
							return 0;
						}
						
						
     				  }
				    }
				    /*Year End Close Group Grid and Details Saving Ends*/
				
				/*Deleting account & amount of value zero*/
				String sql=("DELETE FROM my_jvtran where TR_NO="+trno+" and acno=0");
				int data = stmtYRC1.executeUpdate(sql);
			     
			    String sql1=("DELETE FROM my_jvtran where TR_NO="+trno+" and dramount=0");
			    int data1 = stmtYRC1.executeUpdate(sql1);
			    /*Deleting account & amount  of value zero ends*/
			    
	   } catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}


}
