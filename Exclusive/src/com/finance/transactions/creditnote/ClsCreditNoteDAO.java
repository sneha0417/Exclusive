package com.finance.transactions.creditnote;

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

import com.common.ClsAmountToWords;
import com.common.ClsApplyDelete;
import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsCreditNoteDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsCreditNoteBean creditNoteBean = new ClsCreditNoteBean();
	
	  public int insert(Connection conn,Date creditNoteDate, String formdetailcode, String txtrefno,double txtrate,String txtdescription, int txtdocno, String cmbcurrency, double txtamount, 
			 double txtdrtotal, String rtype, int rdocno, ArrayList<String> creditnotearray,HttpSession session,HttpServletRequest request,String mode) throws SQLException {
		  
		try{
			Statement stmtCNO1 = conn.createStatement();
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			int total = 0;
			
			if(rtype.equalsIgnoreCase("RAG") || rtype.equalsIgnoreCase("rag")){
				String sqlbrch="select brhid from gl_ragmt where doc_no="+rdocno+"";
				ResultSet resultSets = stmtCNO1.executeQuery(sqlbrch);
				
				while (resultSets.next()) {
					 branch=resultSets.getString("brhid");
				}
			}else if(rtype.equalsIgnoreCase("LAG") || rtype.equalsIgnoreCase("lag")){
				String sqlbrch="select brhid from gl_lagmt where doc_no="+rdocno+"";
				ResultSet resultSets = stmtCNO1.executeQuery(sqlbrch);
				
				while (resultSets.next()) {
					 branch=resultSets.getString("brhid");
				}
			}
			
			CallableStatement stmtCNO = conn.prepareCall("{CALL cnotmDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtCNO.registerOutParameter(15, java.sql.Types.INTEGER);
			stmtCNO.registerOutParameter(16, java.sql.Types.INTEGER);
			
			stmtCNO.setDate(1,creditNoteDate);
			stmtCNO.setString(2,txtrefno);
			stmtCNO.setString(3,txtdescription);
			stmtCNO.setInt(4,txtdocno);  //accDocNo
			stmtCNO.setString(5,cmbcurrency);   //curId
			stmtCNO.setDouble(6,txtrate);  //rate
			stmtCNO.setDouble(7,(txtamount)*-1); //amount
			stmtCNO.setDouble(8,txtdrtotal); //netAmount
			stmtCNO.setString(9,rtype); //rtype
			stmtCNO.setInt(10,rdocno); //rdocno
			
			stmtCNO.setString(11,formdetailcode);
			stmtCNO.setString(12,company);
			stmtCNO.setString(13,branch);
			stmtCNO.setString(14,userid);
			stmtCNO.setString(17,mode);
			int datas=stmtCNO.executeUpdate();
			if(datas<=0){
				stmtCNO.close();
				conn.close();
				return 0;
			}
			int docno=stmtCNO.getInt("docNo");
			int trno=stmtCNO.getInt("itranNo");
			request.setAttribute("tranno", trno);
			double nettotal=txtdrtotal;
			creditNoteBean.setTxtcreditnotedocno(docno);
			if (docno > 0) {
				/*Insertion to my_cnotd,my_jvtran,my_outd*/
				int insertData=insertion(conn, docno, trno, formdetailcode,nettotal,creditNoteDate, txtrefno, txtrate, txtdescription, txtdrtotal, rtype, rdocno, creditnotearray, session, mode);
				if(insertData<=0){
					stmtCNO.close();
					conn.close();
					return 0;
				}
				/*Insertion to my_cnotd,my_jvtran,my_outd Ends*/
				String sql2="select ldramount as jvtotal from my_jvtran where tr_no="+trno+"";
				ResultSet resultSet2 = stmtCNO.executeQuery(sql2);
			    
				 while (resultSet2.next()) {
				 System.out.println("asd"+resultSet2.getInt("jvtotal"));
				 }	
				String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
				ResultSet resultSet = stmtCNO.executeQuery(sql1);
			    
				 while (resultSet.next()) {
				 total=resultSet.getInt("jvtotal");
				 }
				 if(total == 0){
					stmtCNO.close();
					return docno;
				 }else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
					    stmtCNO.close();
					    return 0;
				    }
			}
		stmtCNO.close();
	 }catch(Exception e){
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 0;
	}
			
	
	public boolean edit(Connection conn, int txtcreditnotedocno, String formdetailcode, Date creditNoteDate,String txtrefno, String txtdescription, String cmbCurrency, double txtamount, double txtbaseamount,
			double txtrate, double txtdrtotal, int txtdocno,int txttrno,double nettotal, String rtype, int rdocno, ArrayList<String> creditnotearray, HttpSession session,String mode) throws SQLException {
		
		try{
				
				Statement stmtCNO = conn.createStatement();
				if(mode.equalsIgnoreCase("EDIT")){
					mode="E";
				}
				
				int trno = txttrno,icldocno = 0,ilapply = 0,total = 0,creditlimit=0,applydelete=0;
				java.sql.Date sqlDueDate=null;
			    String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String company=session.getAttribute("COMPANYID").toString().trim();
				
				/*Updating my_cnot*/
	            String sql=("update my_cnot set date='"+creditNoteDate+"',lstmodify=now(),refNo='"+txtrefno+"',description='"+txtdescription+"',acno="+txtdocno+",curId="+cmbCurrency+",rate="+txtrate+",amount="+(txtamount*-1)+",netAmount="+txtdrtotal+",dtype='"+formdetailcode+"',brhid="+branch+",cmpid="+company+" where tr_no="+trno+" and doc_no="+txtcreditnotedocno+"");
	            int data = stmtCNO.executeUpdate(sql);
				if(data<=0){
					stmtCNO.close();
					conn.close();
					return false;
				}
				/*Updating my_cnot Ends*/
				
				/*Selecting credit(Max)*/
				String sql1=("select a.period2 from my_cnot m left join my_head t on m.acno=t.doc_no left join my_acbook a on t.cldocno=a.cldocno and a.dtype='CRM' where m.tr_no="+trno+"");
				ResultSet resultSet = stmtCNO.executeQuery(sql1);
				    
				 while (resultSet.next()) {
					creditlimit=resultSet.getInt("period2");
				 }
				 /*Selecting credit(Max) Ends*/
				 
				 /*Selecting duedate*/
				String sql2=("select DATE_ADD('"+creditNoteDate+"', INTERVAL "+creditlimit+" DAY) AS duedate");
				ResultSet resultSet1 = stmtCNO.executeQuery(sql2);
				    
				 while (resultSet1.next()) {
					 sqlDueDate=resultSet1.getDate("duedate");
				 }
				/*Selecting duedate Ends*/
				
				/*Inserting into datalog*/
				String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtcreditnotedocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
				int datas = stmtCNO.executeUpdate(sqls);
				/*Inserting into datalog Ends*/
			    
				ClsApplyDelete applyDelete = new ClsApplyDelete();
				applydelete=applyDelete.getFinanceApplyDelete(conn, trno);
				if(applydelete<0){
					System.out.println("*** ERROR IN APPLY DELETE ***");
					stmtCNO.close();
					conn.close();
					return false;
				}
				  
			    String sql7=("DELETE FROM my_cnotd WHERE TR_NO="+trno);
			    int data4 = stmtCNO.executeUpdate(sql7);
				 
				 String sql8=("DELETE FROM my_jvtran WHERE TR_NO="+trno);
				 int data5 = stmtCNO.executeUpdate(sql8);
				 
				 String sql9=("DELETE FROM my_costtran WHERE TR_NO="+trno);
				 int data6 = stmtCNO.executeUpdate(sql9);
			    
				 String sql10=("select cldocno,lapply from my_head where doc_no="+txtcreditnotedocno);
				 ResultSet resultSet3 = stmtCNO.executeQuery(sql10);
				 
				 while(resultSet3.next()){
					 icldocno=resultSet3.getInt("cldocno");
					 ilapply=resultSet3.getInt("lapply");
				 }
					 
				 String sql11=("insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS) values('"+creditNoteDate+"','"+txtrefno+"',"+txtcreditnotedocno+","+txtdocno+",'"+txtdescription+"',"+cmbCurrency+","+txtrate+","+(txtamount*-1)+","+(txtbaseamount*-1)+",0,-1,6,0,"+ilapply+","+icldocno+","+txtrate+",0,0,'"+formdetailcode+"',"+branch+","+trno+",3)");
				 int data7 = stmtCNO.executeUpdate(sql11);
				 if(data7<=0){
						stmtCNO.close();
						conn.close();
						return false;
					}
				 
			    int docno=txtcreditnotedocno;
				creditNoteBean.setTxtcreditnotedocno(docno);
				if (docno > 0) {
				
					/*Insertion to my_cnotd,my_jvtran,my_outd*/
					int insertData=insertion(conn, docno, trno,formdetailcode,nettotal,creditNoteDate, txtrefno, txtrate, txtdescription, txtdrtotal, rtype, rdocno, creditnotearray, session,mode);
					if(insertData<=0){
						stmtCNO.close();
						conn.close();
						return false;
					}
					/*Insertion to my_cnotd,my_jvtran,my_outd Ends*/
					
					/*Updating duedate*/
		            String sqldue=("update my_jvtran set duedate='"+sqlDueDate+"',out_amount=0 where acno="+txtdocno+" and tr_no="+trno+"");
		            int datadue = stmtCNO.executeUpdate(sqldue);
					if(datadue<=0){
						stmtCNO.close();
						conn.close();
						return false;
					}
					/*Updating duedate Ends*/
					
					String sql12="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno;
					ResultSet resultSet5 = stmtCNO.executeQuery(sql12);
				    
					 while (resultSet5.next()) {
						 total=resultSet5.getInt("jvtotal");
					 }
					 
					 if(total == 0){
						stmtCNO.close();
						return true;
					 }else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
					    stmtCNO.close();
					    return false;
				    }
				}
			stmtCNO.close();
		 }catch(Exception e){
			 	e.printStackTrace();
			 	conn.close();
			 	return false;
		 }
			return false;
	}
	  
	public boolean editMaster(Connection conn,int txtcreditnotedocno, String formdetailcode, Date creditNoteDate,String txtrefno, String txtdescription, double txtrate,
			double txtdrtotal, int txtdocno,int txttrno, HttpSession session) throws SQLException {
		
		try{
			
			Statement stmtCNO = conn.createStatement();
			
			int trno = txttrno,creditlimit=0;
			java.sql.Date sqlDueDate=null;
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			
			/*Updating my_cnot*/
            String sql=("update my_cnot set date='"+creditNoteDate+"',lstmodify=now(),refNo='"+txtrefno+"',description='"+txtdescription+"',dtype='"+formdetailcode+"',brhid="+branch+",cmpid="+company+" where tr_no="+trno+" and doc_no="+txtcreditnotedocno+"");
            int data = stmtCNO.executeUpdate(sql);
			if(data<=0){
				stmtCNO.close();
				conn.close();
				return false;
			}
			/*Updating my_cnot Ends*/
			
			/*Selecting credit(Max)*/
			String sql1=("select a.period2 from my_cnot m left join my_head t on m.acno=t.doc_no left join my_acbook a on t.cldocno=a.cldocno and a.dtype='CRM' where m.tr_no="+trno+"");
			ResultSet resultSet = stmtCNO.executeQuery(sql1);
			    
			 while (resultSet.next()) {
				creditlimit=resultSet.getInt("period2");
			 }
			 /*Selecting credit(Max) Ends*/
			 
			 /*Selecting duedate*/
				String sql2=("select DATE_ADD('"+creditNoteDate+"', INTERVAL "+creditlimit+" DAY) AS duedate");
				ResultSet resultSet1 = stmtCNO.executeQuery(sql2);
				    
				 while (resultSet1.next()) {
					 sqlDueDate=resultSet1.getDate("duedate");
				 }
			/*Selecting duedate Ends*/
				
			 /*Updating duedate*/
	            String sql3=("update my_jvtran set duedate='"+sqlDueDate+"' where acno="+txtdocno+" and tr_no="+trno+"");
	            int data1 = stmtCNO.executeUpdate(sql3);
				if(data1<=0){
					stmtCNO.close();
					conn.close();
					return false;
				}
				/*Updating duedate Ends*/
			
			/*Inserting into datalog*/
			String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtcreditnotedocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
			int datas = stmtCNO.executeUpdate(sqls);
			/*Inserting into datalog Ends*/
			
			stmtCNO.close();
			return true;			
      }catch(Exception e){
    	  e.printStackTrace();
    	  conn.close();
    	  return false;
      }
	}


	public boolean delete(Connection conn,int txtcreditnotedocno, int txtdocno, String formdetailcode, int txttrno, HttpSession session) throws SQLException {
		 
		try{
				Statement stmtCNO = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				int trno = txttrno,applydelete=0;
				
				ClsApplyDelete applyDelete = new ClsApplyDelete();
				applydelete=applyDelete.getFinanceApplyDelete(conn, trno);
				if(applydelete<0){
					System.out.println("*** ERROR IN APPLY DELETE ***");
					stmtCNO.close();
					conn.close();
					return false;
				}
				
				/*Status change in my_cnot*/
				 String sql=("update my_cnot set STATUS=7 where doc_no="+txtcreditnotedocno+" and TR_NO="+trno);
				 int data = stmtCNO.executeUpdate(sql);
				 if(data<=0){
						stmtCNO.close();
						conn.close();
						return false;
					}
				/*Status change in my_cnot Ends*/
				 
				 /*Inserting into datalog*/
				 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtcreditnotedocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','D')");
				 int datas = stmtCNO.executeUpdate(sqls);
				 /*Inserting into datalog Ends*/
				
				/*Status change in my_jvtran*/
				 String sql1=("update my_jvtran set STATUS=7,out_amount=0 where doc_no="+txtcreditnotedocno+" and TR_NO="+trno);
				 int data1 = stmtCNO.executeUpdate(sql1);
				 if(data1<=0){
						stmtCNO.close();
						conn.close();
						return false;
					}
				/*Status change in my_jvtran Ends*/
				
				int docno=txtcreditnotedocno;
				creditNoteBean.setTxtcreditnotedocno(docno);
				if (docno > 0) {
					stmtCNO.close();
					return true;
				}		
		 }catch(Exception e){
			 	e.printStackTrace();
			 	conn.close();
			 	return false;
		 }
				return false;
	    }
	
	public JSONArray creditNoteGridReloading(HttpSession session,String docNo,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))) {
        	return RESULTDATA;
        }
        
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
        String branch = session.getAttribute("BRANCHID").toString();
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtCNO = conn.createStatement();
			
				String sqlnew=("SELECT t.doc_no docno,t.atype type,t.account accounts,t.description accountname1,t.gr_type grtype,c.code currency,c.type currencytype,d.curId currencyid,"
						+ "d.rate rate,if(d.dr>0,true,false) dr,(d.amount*d.dr) amount1,(j.ldramount*j.id) baseamount1,d.description,d.SR_NO sr_no,d.costtype,d.costcode,f.costgroup FROM my_cnot m "
						+ "left join my_cnotd d on m.tr_no=d.tr_no left join my_jvtran j on d.rowno=j.ref_row and d.tr_no=j.tr_no left join my_costunit f on d.costtype=f.costtype left join my_head t "
						+ "on d.acno=t.doc_no left join my_curr c on c.doc_no=d.curId WHERE m.dtype='CNO' and m.brhId="+branch+" and m.doc_no="+docNo+" and d.SR_NO>0");
				
				ResultSet resultSet = stmtCNO.executeQuery(sqlnew);
                
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtCNO.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA;
    }
	
	public JSONArray creditNoteGridSearch(String type,String accountno,String accountname,String currency,String date,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
		       conn = connDAO.getMyConnection();
		       Statement stmtCOT = conn.createStatement();
	
		        String sqltest="";
		        String sql="";
		        java.sql.Date sqlDate=null;
		         
	           date.trim();
	           if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	           {
	        	   sqlDate = commonDAO.changeStringtoSqlDate(date);
	           }
		           
		        if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and t.account like '%"+accountno+"%'";
		        }
		        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and t.description like '%"+accountname+"%'";
		        }
		        if(!(currency.equalsIgnoreCase("0")) && !(currency.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and c.code like '%"+currency+"%'";
			    }
		        
	        	sql="select t.doc_no,t.account,t.description,t.gr_type,c.code curr,c.doc_no curid,c.type,round(cb.rate,2) c_rate from my_head t left join my_curr c "
						+ "on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,"
						+ "cr.frmDate from my_curbook cr where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo "
						+ "on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where t.atype='"+type+"' and t.m_s=0"+sqltest;
		        
		       ResultSet resultSet = stmtCOT.executeQuery(sql);
		       RESULTDATA=commonDAO.convertToJSON(resultSet);
	           
		       stmtCOT.close();
			   conn.close();
	     }
	     catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     }finally{
				conn.close();
			}
	       return RESULTDATA;
	  }
	
	public JSONArray cnoMainSearch(HttpSession session,String docNo,String date,String accId,String accName,String amount,String description,String check) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))) {
        	return RESULTDATA;
        }
        
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
       
        java.sql.Date sqlCreditNoteDate=null;
       
       
     try {
	       conn = connDAO.getMyConnection();
	       Statement stmtCNO = conn.createStatement();
	       
	        date.trim();
	        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	        {
	        	sqlCreditNoteDate = commonDAO.changeStringtoSqlDate(date);
	        }

	        String sqltest="";
	        
	        if(!(docNo.equalsIgnoreCase(""))){
	            sqltest=sqltest+" and m.doc_no like '%"+docNo+"%'";
	        }
	        if(!(sqlCreditNoteDate==null)){
		         sqltest=sqltest+" and m.date='"+sqlCreditNoteDate+"'";
		    }
	        if(!(accId.equalsIgnoreCase(""))){
	            sqltest=sqltest+" and h.doc_no like '%"+accId+"%'";
	        }
	        if(!(accName.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and h.description like '%"+accName+"%'";
	        }
	        if(!(amount.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and m.amount like '%"+amount+"%'";
	        }
	        if(!(description.equalsIgnoreCase(""))){
	            sqltest=sqltest+" and m.description like '%"+description+"%'";
	        }
	        
	       String sql = "Select m.date,m.doc_no,(m.amount*-1) amount,m.description,h.doc_no accountno,h.description accountname from my_cnot m inner join my_cnotd d on m.tr_no=d.tr_no "
	       		+ "inner join my_head h on m.acno=h.doc_no inner join my_brch b on m.brhid=b.doc_no where m.brhid="+branch+" and m.dtype='CNO' and m.status <> 7" +sqltest+" group by m.tr_no";
	       
	       ResultSet resultSet = stmtCNO.executeQuery(sql);
	       RESULTDATA=commonDAO.convertToJSON(resultSet);
	       
	       stmtCNO.close();
	       conn.close();
     } catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     } finally{
			conn.close();
	 }
           return RESULTDATA;
       }
	
	 public ClsCreditNoteBean getViewDetails(HttpSession session,int docNo) throws SQLException {
		
		ClsCreditNoteBean creditNoteBean = new ClsCreditNoteBean();
		
		Connection conn = null;
		
		try {
		
			conn = connDAO.getMyConnection();
			Statement stmtCNO = conn.createStatement();
		
			String branch = session.getAttribute("BRANCHID").toString();
			
			ResultSet resultSet = stmtCNO.executeQuery ("SELECT m.date,m.refNo,round((m.amount*-1),2) amount,m.description,m.curId,round(m.rate,2) rate,m.acno,m.netamount,m.tr_no,round((j.ldramount*-1),2) baseamount,t.atype,t.account,t.description accountname,c.type from my_cnot m "
					+ "left join my_jvtran j on (m.tr_no=j.tr_no and m.acno=j.acno) left join my_head t on m.acno=t.doc_no left join my_curr c on m.curId=c.doc_no where m.dtype='CNO' and m.status<> 7 and m.brhid="+branch+" and m.doc_no="+docNo+" group by tr_no");
	
			while (resultSet.next()) {
				creditNoteBean.setTxtcreditnotedocno(docNo);
				creditNoteBean.setJqxCreditNoteDate(resultSet.getDate("date").toString());
				creditNoteBean.setTxtrefno(resultSet.getString("refNo"));
				
				creditNoteBean.setTxtdocno(resultSet.getInt("acno"));
				creditNoteBean.setTxttrno(resultSet.getInt("tr_no"));
				creditNoteBean.setCmbtype(resultSet.getString("atype"));
				creditNoteBean.setTxtaccid(resultSet.getString("account"));
				creditNoteBean.setTxtaccname(resultSet.getString("accountname"));
				creditNoteBean.setHidcmbcurrency(resultSet.getString("curId"));
				creditNoteBean.setHidcurrencytype(resultSet.getString("type"));
				creditNoteBean.setTxtrate(resultSet.getDouble("rate"));
				creditNoteBean.setTxtamount(resultSet.getDouble("amount"));
				creditNoteBean.setTxtbaseamount(resultSet.getDouble("baseamount"));
				creditNoteBean.setTxtdescription(resultSet.getString("description"));
				
				creditNoteBean.setTxtdrtotal(resultSet.getDouble("netamount"));
				creditNoteBean.setTxtcrtotal(resultSet.getDouble("netamount"));
			 }
				stmtCNO.close();
				conn.close();
		}catch(Exception e){
				e.printStackTrace();
				conn.close();
		}finally{
			conn.close();
		}
		return creditNoteBean;
     }
	 
	 public ClsCreditNoteBean getPrint(HttpServletRequest request,int docNo,int branch,int header) throws SQLException {
		 ClsCreditNoteBean bean = new ClsCreditNoteBean();
		 Connection conn = null;
		 
		try {
			conn = connDAO.getMyConnection();
			Statement stmtCNO = conn.createStatement();
			
			String headersql="select if(m.dtype='CNO',' Tax Credit Note','  ') vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
					+ "b.cstno,b.tinno from my_cnot m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='CNO' "
					+ "and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			System.out.println("cno print======="+headersql);
				
				ResultSet resultSetHead = stmtCNO.executeQuery(headersql);
				
				while(resultSetHead.next()){
					
					bean.setLblcompname(resultSetHead.getString("company"));
					bean.setLblcompaddress(resultSetHead.getString("address"));
					bean.setLblprintname(resultSetHead.getString("vouchername"));
					bean.setLblcomptel(resultSetHead.getString("tel"));
					bean.setLblcompfax(resultSetHead.getString("fax"));
					bean.setLblbranch(resultSetHead.getString("branchname"));
					bean.setLbllocation(resultSetHead.getString("location"));
					bean.setLblcstno(resultSetHead.getString("cstno"));
					bean.setLblpan(resultSetHead.getString("pbno"));
					bean.setLblservicetax(resultSetHead.getString("stcno"));
					bean.setLblpobox(resultSetHead.getString("pbno"));
					bean.setLblcomptrn(resultSetHead.getString("tinno"));
				}
				
			String sql="select ac.address,m.doc_no,DATE_FORMAT(m.date,'%d-%m-%Y') date,m.description,round(m.netAmount,2) netAmount,t.description accountname,ac.trnnumber,u.user_name,m.refNo from my_cnot m left join my_head t on "
					+ "m.acno=t.doc_no left join my_acbook ac on ac.acno=m.acno left join my_user u on m.userid=u.doc_no where m.dtype='CNO' and m.brhid="+branch+" and m.doc_no="+docNo+"";
				
			ResultSet resultSet = stmtCNO.executeQuery(sql);
			
			ClsAmountToWords c = new ClsAmountToWords();
			
			while(resultSet.next()){
				bean.setLblclienttrno(resultSet.getString("trnnumber"));
				System.out.println("trnooooo"+resultSet.getString("trnnumber"));
				bean.setLbldocumentno(resultSet.getString("doc_no"));
				bean.setLbldate(resultSet.getString("date"));
				bean.setLblaccountname(resultSet.getString("accountname"));
				bean.setLbldescription(resultSet.getString("description"));
				bean.setLbldebittotal(resultSet.getString("netAmount"));
				bean.setLblcredittotal(resultSet.getString("netAmount"));
				bean.setLblnetamount(resultSet.getString("netAmount"));
				bean.setLblnetamountwords(c.convertAmountToWords(resultSet.getString("netAmount")));
				bean.setLblpreparedby(resultSet.getString("user_name"));
				bean.setRefno(resultSet.getString("refNo"));
				bean.setLblcustaddress(resultSet.getString("address"));
			}
			
			bean.setTxtheader(header);
			
			String InvNoPrintCreditNote="0";
			String sqlConfig="select method from gl_config where field_nme='InvNoPrintCreditNote'";
			ResultSet resultSetConfig = stmtCNO.executeQuery(sqlConfig);
			
			while(resultSetConfig.next()){
				InvNoPrintCreditNote=resultSetConfig.getString("method");
			}
			
			if(InvNoPrintCreditNote.equalsIgnoreCase("1")){
				
				/*String sqls="select max(voc_no) invno from my_cnot c left join my_cnotd d on (c.tr_no=d.tr_no and d.sr_no=1) left join gl_rcalc rc  on c.tr_no=rc.trno left join "
						+ "gl_lcalc lc on c.tr_no=lc.trno left join gl_invm i on ((rc.rdocno=i.rano and i.ratype='RAG') or (lc.rdocno=i.rano and i.ratype='LAG')) inner join gl_invd id on "
						+ "(i.doc_no=id.rdocno and id.acno=d.acno) where c.dtype='CNO' and c.brhid="+branch+" and c.doc_no="+docNo+"";
				*/
				String sqls="select mm.voc_no invno from gl_invm mm left join my_cnot m on m.invno=mm.doc_no where m.dtype='CNO' and m.brhid="+branch+" and m.doc_no="+docNo+" and m.invno!=0";   
				ResultSet resultSets = stmtCNO.executeQuery(sqls);   
				   
				while(resultSets.next()){
					bean.setLblinvoiceno(resultSets.getString("invno"));
				}
				
			}
			
			String sql1 = "";
		
			sql1="SELECT t.account,t.description accountname,c.code currency,j.description,if(j.dramount>0,round((j.dramount*1),2),'  ') debit,if(j.dramount<0,round((j.dramount*-1),2),' ') credit "
			  + "FROM my_jvtran j left join my_head t on j.acno=t.doc_no left join my_curr c on c.doc_no=j.curId WHERE j.dtype='CNO' and j.brhid="+branch+" and j.doc_no="+docNo+" order by j.dramount desc";
			
			ResultSet resultSet1 = stmtCNO.executeQuery(sql1);
			
			ArrayList<String> printarray= new ArrayList<String>();
			while(resultSet1.next()){
				bean.setFirstarray(1); 
				String temp="";
				temp=resultSet1.getString("account")+"::"+resultSet1.getString("accountname")+"::"+resultSet1.getString("description")+"::"+resultSet1.getString("currency")+"::"+resultSet1.getString("debit")+"::"+resultSet1.getString("credit");
			    printarray.add(temp);
			}
			
			request.setAttribute("printingarray", printarray);
			
			String sql2="SELECT t.account,t.description accountname,c.code currency,j.description,if(j.dramount>0,round((j.dramount*1),2),'  ') debit,if(j.dramount<0,round((j.dramount*-1),2),' ') credit,"
					  + "CASE WHEN j.rtype is null THEN ' ' WHEN j.rtype='0' THEN ' ' WHEN j.rtype='' THEN ' ' ELSE CONCAT(j.rtype,' - ',if(j.rtype='RAG',rag.voc_no,lag.voc_no)) END AS 'agmt',"
					  + "if(j.costtype='6',CONCAT('Fleet :',j.costcode,' ',v.flname,' Reg No :',v.reg_no,' ',p.code_name,' ',a.authname),' ') vehinfo FROM my_jvtran j left join my_head t on j.acno=t.doc_no "
					  + "left join my_curr c on c.doc_no=j.curId left join gl_ragmt rag on (j.rdocno=rag.doc_no and j.rtype='RAG') left join gl_lagmt lag on (j.rdocno=lag.doc_no and j.rtype='LAG') "
					  + "left join gl_vehmaster v on j.costcode=v.fleet_no left join gl_vehplate p on v.pltid=p.doc_no left join gl_vehauth a on v.authid=a.doc_no WHERE j.dtype='CNO' and j.brhid="+branch+" "
					  + "and j.doc_no="+docNo+" order by j.dramount";
					
			ResultSet resultSet2 = stmtCNO.executeQuery(sql2);

			String vehicle="",agreement="";
			while(resultSet2.next()){
				 vehicle=resultSet2.getString("vehinfo");
				 agreement=resultSet2.getString("agmt");
			}
			
			if(agreement.trim().equalsIgnoreCase("")){
				bean.setLblagreement("0");	
			}else {
				bean.setLblagreement(agreement);
			}

			bean.setLblvehicleinfo(vehicle);
			
			String sql3 = "select min(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,min(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from my_cnot m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='CNO' "
					+ "and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSet3 = stmtCNO.executeQuery(sql3);
			
			while(resultSet3.next()){
				bean.setLblpreparedon(resultSet3.getString("preparedon"));
				bean.setLblpreparedat(resultSet3.getString("preparedat"));
			}
		
			stmtCNO.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return bean;
	}
	 
	 public int insertion(Connection conn, int docno, int trno, String formdetailcode, double nettotal, Date creditNoteDate, String txtrefno, double txtrate, String txtdescription, double txtdrtotal, 
				String rtype,int rdocno, ArrayList<String> creditnotearray,HttpSession session,String mode) throws SQLException{
			
			  try{
					conn.setAutoCommit(false);
					CallableStatement stmtCNO=null;
					Statement stmtCNO1 = conn.createStatement();
					
					String branch=session.getAttribute("BRANCHID").toString().trim();
					 
					if(rtype.equalsIgnoreCase("RAG") || rtype.equalsIgnoreCase("rag")){
						String sqlbrch="select brhid from gl_ragmt where doc_no="+rdocno+"";
						ResultSet resultSets = stmtCNO1.executeQuery(sqlbrch);
						
						while (resultSets.next()) {
							 branch=resultSets.getString("brhid");
						}
					}else if(rtype.equalsIgnoreCase("LAG") || rtype.equalsIgnoreCase("lag")){
						String sqlbrch="select brhid from gl_lagmt where doc_no="+rdocno+"";
						ResultSet resultSets = stmtCNO1.executeQuery(sqlbrch);
						
						while (resultSets.next()) {
							 branch=resultSets.getString("brhid");
						}
					}
					
					/*Credit-Note Grid and Details Saving*/
					for(int i=0;i < creditnotearray.size();i++){
						String[] credit=creditnotearray.get(i).split("::");
						if(!credit[0].trim().equalsIgnoreCase("undefined") && !credit[0].trim().equalsIgnoreCase("NaN")){
						
						int id = 0;
						if(credit[3].trim().equalsIgnoreCase("true")){
							id=1;
						}
						else if(credit[3].trim().equalsIgnoreCase("false")){
							id=-1;
						}
						
						stmtCNO = conn.prepareCall("{CALL cnotdDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						
						/*Insertion to my_cnotd*/
						stmtCNO.setInt(19,trno); 
						stmtCNO.setInt(20,docno);
						stmtCNO.registerOutParameter(21, java.sql.Types.INTEGER);
						stmtCNO.setInt(1,(i+1)); //SR_NO
						stmtCNO.setString(2,(credit[0].trim().equalsIgnoreCase("undefined") || credit[0].trim().equalsIgnoreCase("NaN") || credit[0].trim().isEmpty()?0:credit[0].trim()).toString());  //doc_no of my_head
						stmtCNO.setString(3,(credit[1].trim().equalsIgnoreCase("undefined") || credit[1].trim().equalsIgnoreCase("NaN") || credit[1].trim().isEmpty()?0:credit[1].trim()).toString()); //curId
						stmtCNO.setString(4,(credit[2].trim().equalsIgnoreCase("undefined") || credit[2].equalsIgnoreCase("NaN") || credit[2].trim().equals(0) || credit[2].trim().isEmpty()?1:credit[2].trim()).toString()); //rate 
						stmtCNO.setInt(5,id); //#credit 1 / debit -1 
						stmtCNO.setString(6,(credit[4].trim().equalsIgnoreCase("undefined") || credit[4].trim().equalsIgnoreCase("NaN") || credit[4].trim().isEmpty()?0:credit[4].trim()).toString()); //amount
						stmtCNO.setString(7,(credit[5].trim().equalsIgnoreCase("undefined") || credit[5].trim().equalsIgnoreCase("NaN") || credit[5].trim().isEmpty()?0:credit[5].trim()).toString()); //description
						stmtCNO.setDouble(8,nettotal); //netTotal 
						stmtCNO.setString(9,(credit[7].trim().equalsIgnoreCase("undefined") || credit[7].trim().equalsIgnoreCase("NaN") || credit[7].trim().equalsIgnoreCase("") || credit[7].trim().equalsIgnoreCase("0") || credit[7].trim().isEmpty()?0:credit[7].trim()).toString());  //Cost Type
						stmtCNO.setString(10,(credit[8].trim().equalsIgnoreCase("undefined") || credit[8].trim().equalsIgnoreCase("NaN") || credit[8].trim().equalsIgnoreCase("") || credit[8].trim().equalsIgnoreCase("0") || credit[8].trim().isEmpty()?0:credit[8].trim()).toString());  //Cost Code
						stmtCNO.setString(11,rtype); //rtype
						stmtCNO.setInt(12,rdocno); //rdocno
						/*my_cnotd Ends*/
						
						/*Insertion to my_jvtran*/
						stmtCNO.setDate(13,creditNoteDate);
						stmtCNO.setString(14,txtrefno);
						stmtCNO.setInt(15,id);  //id
						stmtCNO.setString(16,(credit[6].trim().equalsIgnoreCase("undefined") || credit[6].equalsIgnoreCase("NaN") || credit[6].isEmpty()?0:credit[6].trim()).toString());  //base-amount
						/*my_jvtran Ends*/
						
						stmtCNO.setString(17,formdetailcode);
						stmtCNO.setString(18,branch);
						stmtCNO.setString(22,mode);
						stmtCNO.execute();
						if(stmtCNO.getInt("irowsNo")<=0){
							stmtCNO.close();
							conn.close();
							return 0;
						}
					    }
					    /*Credit-Note Grid and Details Saving Ends*/
						stmtCNO.close();
					}
					
		   }catch(Exception e){	
			 	e.printStackTrace();
			 	conn.close();
			 	return 0;
		 }
			return 1;
		}
}
