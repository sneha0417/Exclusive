package com.finance.transactions.fuelcardreimbursement;

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
import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsFuelCardReimbursementDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsFuelCardReimbursementBean fuelCardReimbursementBean = new ClsFuelCardReimbursementBean();
	
	  public int insert(Date fuelCardReimbursementDate,String formdetailcode,String txtrefno,int txtdocno,String cmbcurrency,double txtrate,double txtamount,String txtdescription, 
			  double txtbaseamount,ArrayList<String> fuelcardreimbursementsarray,HttpSession session,HttpServletRequest request,String mode) throws SQLException {
		  	
		  	Connection conn = null;
		  	
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtFCR2 = conn.createStatement();
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			int total = 0;
			
			String strSql = "select m.acno,h.curid,round(cb.rate,2) rate from my_account m left join my_head h on m.acno=h.doc_no "
					+ "left join my_curr c on h.curid=c.doc_no left join my_curbook cb on h.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,"
					+ "cr.frmDate from my_curbook cr where coalesce(toDate,curdate())>='"+fuelCardReimbursementDate+"' and frmDate<='"+fuelCardReimbursementDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no "
					+ "and cb.curid=bo.curid) where m.codeno='FUEL CHARGE ACCOUNT'";
			
			ResultSet rs = stmtFCR2.executeQuery(strSql);
			
			String fuelchargedocno="",fuelchargecurid="",fuelchargerate="";
			while(rs.next()) {
					fuelchargedocno=rs.getString("acno");
					fuelchargecurid=rs.getString("curid");
					fuelchargerate=rs.getString("rate");
			 }
			
			ArrayList<String> fuelcardreimbursementarray=new ArrayList<String>();
			
			fuelcardreimbursementarray.add(txtdocno+"::"+cmbcurrency+"::"+txtrate+"::false::"+txtamount*-1+"::"+txtdescription+"::"+txtbaseamount*-1+"::0::0::0");
			
			for(int i=0;i<fuelcardreimbursementsarray.size();i++){
				String temp="";
				
				String costtype = fuelcardreimbursementsarray.get(i).split("::")[0];
				String costcode = fuelcardreimbursementsarray.get(i).split("::")[1];
				String amount = fuelcardreimbursementsarray.get(i).split("::")[2];
				String baseamount = fuelcardreimbursementsarray.get(i).split("::")[3];
				String description = fuelcardreimbursementsarray.get(i).split("::")[4];
				
				temp=fuelchargedocno+"::"+fuelchargecurid+"::"+fuelchargerate+"::true::"+amount+"::"+description+"::"+baseamount+"::0::"+costtype+"::"+costcode;
				
				fuelcardreimbursementarray.add(temp);
			}

			CallableStatement stmtFCR = conn.prepareCall("{CALL fuelcardreimbursementbmDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtFCR.registerOutParameter(10, java.sql.Types.INTEGER);
			stmtFCR.registerOutParameter(11, java.sql.Types.INTEGER);
			
			stmtFCR.setDate(1,fuelCardReimbursementDate);
			stmtFCR.setString(2,txtrefno);
			stmtFCR.setString(3,txtdescription);
			stmtFCR.setDouble(4,txtamount);
			stmtFCR.setDouble(5,txtrate);
			stmtFCR.setString(6,formdetailcode);
			stmtFCR.setString(7,company);
			stmtFCR.setString(8,branch);
			stmtFCR.setString(9,userid);
			stmtFCR.setString(12,mode);
			int datas=stmtFCR.executeUpdate();
			if(datas<=0){
				stmtFCR.close();
				conn.close();
				return 0;
			}
			int docno=stmtFCR.getInt("docNo");
			int trno=stmtFCR.getInt("itranNo");
			request.setAttribute("tranno", trno);
			fuelCardReimbursementBean.setTxtfuelcardreimbursementdocno(docno);
			if (docno > 0) {
				/*Insertion to my_fuelcardbd,my_jvtran,my_costtran*/
				int insertData=insertion(conn, docno, trno, formdetailcode, fuelCardReimbursementDate, txtrefno, txtrate, txtdescription, txtamount, fuelcardreimbursementarray, session,mode);
				if(insertData<=0){
					stmtFCR.close();
					conn.close();
					return 0;
				}
				/*Insertion to my_fuelcardbd,my_jvtran,my_costtran Ends*/
					
				String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
				ResultSet resultSet = stmtFCR.executeQuery(sql1);
			    
				 while (resultSet.next()) {
				 total=resultSet.getInt("jvtotal");
				 }

				 if(total == 0){
					conn.commit();
					stmtFCR.close();
					conn.close();
					return docno;
				 }else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
					    stmtFCR.close();
					    return 0;
				    }
			}
			
			stmtFCR.close();
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
			
	public boolean edit(int txtfuelcardreimbursementdocno, String formdetailcode, Date fuelCardReimbursementDate, String txtrefno, int txtdocno, String cmbcurrency, double txtrate, 
			double txtamount,String txtdescription, double txtbaseamount, int txttrno, ArrayList<String> fuelcardreimbursementsarray, HttpSession session,String mode) throws SQLException {
		
		 	Connection conn = null;
		 	
		 try{
			    conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtFCR = conn.createStatement();

				if(mode.equalsIgnoreCase("EDIT")){
					mode="E";
				}
				
				int trno = txttrno,total=0;
			    
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String company=session.getAttribute("COMPANYID").toString().trim();
				
				/*Updating my_fuelcardbm*/
                String sql=("update my_fuelcardbm set date='"+fuelCardReimbursementDate+"',RefNo='"+txtrefno+"',DESC1='"+txtdescription+"',mrate='"+txtrate+"',trMode=2,totalAmount='"+txtamount+"',DTYPE='"+formdetailcode+"',cmpId='"+company+"',brhId='"+branch+"' where TR_NO='"+trno+"' and doc_no="+txtfuelcardreimbursementdocno);
                int data = stmtFCR.executeUpdate(sql);
				if(data<=0){
					conn.close();
					return false;
				}
				/*Updating my_fuelcardbm Ends*/
				
				/*Inserting into datalog*/
				String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtfuelcardreimbursementdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
				int datas = stmtFCR.executeUpdate(sqls);
				/*Inserting into datalog Ends*/
			    
			    String sql3=("DELETE FROM my_fuelcardbd WHERE TR_NO="+trno+"");
			    int data3 = stmtFCR.executeUpdate(sql3);
			    	 
				 String sql4=("DELETE FROM my_jvtran WHERE TR_NO="+trno+"");
				 int data4 = stmtFCR.executeUpdate(sql4);
				 
				 String sql6=("DELETE FROM my_costtran WHERE TR_NO="+trno+"");
				 int data6 = stmtFCR.executeUpdate(sql6);
			    			    
				 String strSql = "select m.acno,h.curid,round(cb.rate,2) rate from my_account m left join my_head h on m.acno=h.doc_no "
							+ "left join my_curr c on h.curid=c.doc_no left join my_curbook cb on h.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,"
							+ "cr.frmDate from my_curbook cr where coalesce(toDate,curdate())>='"+fuelCardReimbursementDate+"' and frmDate<='"+fuelCardReimbursementDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no "
							+ "and cb.curid=bo.curid) where m.codeno='FUEL CHARGE ACCOUNT'";
					
					ResultSet rs = stmtFCR.executeQuery(strSql);
					
					String fuelchargedocno="",fuelchargecurid="",fuelchargerate="";
					while(rs.next()) {
							fuelchargedocno=rs.getString("acno");
							fuelchargecurid=rs.getString("curid");
							fuelchargerate=rs.getString("rate");
					 }
					
					ArrayList<String> fuelcardreimbursementarray=new ArrayList<String>();
					
					fuelcardreimbursementarray.add(txtdocno+"::"+cmbcurrency+"::"+txtrate+"::false::"+txtamount*-1+"::"+txtdescription+"::"+txtbaseamount*-1+"::0::0::0");
					
					for(int i=0;i<fuelcardreimbursementsarray.size();i++){
						String temp="";
						
						String costtype = fuelcardreimbursementsarray.get(i).split("::")[0];
						String costcode = fuelcardreimbursementsarray.get(i).split("::")[1];
						String amount = fuelcardreimbursementsarray.get(i).split("::")[2];
						String baseamount = fuelcardreimbursementsarray.get(i).split("::")[3];
						String description = fuelcardreimbursementsarray.get(i).split("::")[4];
						
						temp=fuelchargedocno+"::"+fuelchargecurid+"::"+fuelchargerate+"::true::"+amount+"::"+description+"::"+baseamount+"::0::"+costtype+"::"+costcode;
						
						fuelcardreimbursementarray.add(temp);
				   }
					
			    int docno=txtfuelcardreimbursementdocno;
			    fuelCardReimbursementBean.setTxtfuelcardreimbursementdocno(docno);
				if (docno > 0) {
				
					/*Insertion to my_fuelcardbd,my_jvtran*/
					int insertData=insertion(conn, docno, trno, formdetailcode, fuelCardReimbursementDate, txtrefno, txtrate, txtdescription, txtamount, fuelcardreimbursementarray, session,mode);
					if(insertData<=0){
						stmtFCR.close();
						conn.close();
						return false;
					}
					/*Insertion to my_fuelcardbd,my_jvtran Ends*/
					
					String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
					ResultSet resultSet = stmtFCR.executeQuery(sql1);
				    
					 while (resultSet.next()) {
					 total=resultSet.getInt("jvtotal");
					 }

					 if(total == 0){
						conn.commit();
						stmtFCR.close();
						conn.close();
						return true;
					 }else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
					    stmtFCR.close();
					    return false;
				    }
				}
				stmtFCR.close();
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
	
	public boolean editMaster(int txtfuelcardreimbursementdocno,  String formdetailcode, Date fuelcardreimbursementDate,String txtrefno, String txtdescription, double txtrate, double txtamount, 
			int txtdocno, int txttrno, HttpSession session) throws SQLException {
		 	
		Connection conn = null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtFCR = conn.createStatement();

			int trno = txttrno;
		
		    String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			
			/*Updating my_fuelcardbm*/
            String sql=("update my_fuelcardbm set date='"+fuelcardreimbursementDate+"',RefNo='"+txtrefno+"',DESC1='"+txtdescription+"',mrate='"+txtrate+"',trMode=2,totalAmount='"+txtamount+"',DTYPE='"+formdetailcode+"',cmpId='"+company+"',brhId='"+branch+"' where TR_NO='"+trno+"' and doc_no="+txtfuelcardreimbursementdocno);
			int data = stmtFCR.executeUpdate(sql);
			if(data<=0){
				conn.close();
				return false;
			}
			/*Updating my_fuelcardbm Ends*/
			
			/*Inserting into datalog*/
			String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtfuelcardreimbursementdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
			int data1 = stmtFCR.executeUpdate(sqls);
			/*Inserting into datalog Ends*/
			
			conn.commit();
			stmtFCR.close();
		    conn.close();
			return true;			
      }catch(Exception e){	
	 	e.printStackTrace();
	 	conn.close();
	 	return false;
       }finally{
  		 conn.close();
  	 }
	}


	public boolean delete(int txtfuelcardreimbursementdocno, int txttrno, String formdetailcode,HttpSession session) throws SQLException {
		 
		Connection conn = null; 
		
		try{
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtFCR = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				int trno = txttrno;
								 
				 /*Status change in my_fuelcardbm*/
				 String sql=("update my_fuelcardbm set STATUS=7 where doc_no="+txtfuelcardreimbursementdocno+" and TR_NO="+trno+"");
				 int data = stmtFCR.executeUpdate(sql);
				/*Status change in my_fuelcardbm Ends*/
				 
				 /*Inserting into datalog*/
				 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtfuelcardreimbursementdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','D')");
				 int datas = stmtFCR.executeUpdate(sqls);
				 /*Inserting into datalog Ends*/
				
				/*Status change in my_jvtran*/
				 String sql1=("update my_jvtran set STATUS=7 where doc_no="+txtfuelcardreimbursementdocno+" and TR_NO="+trno+"");
				 int data1 = stmtFCR.executeUpdate(sql1);
				/*Status change in my_jvtran Ends*/
				 
				int docno=txtfuelcardreimbursementdocno;
				fuelCardReimbursementBean.setTxtfuelcardreimbursementdocno(docno);
				if (docno > 0) {
					conn.commit();
					stmtFCR.close();
				    conn.close();
					return true;
				}	
				stmtFCR.close();
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
	
	public JSONArray accountsDetails(HttpSession session,String accountno,String accountname,String currency,String date,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();

		if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
		
        Connection conn = null; 
       
	     try {
	       
		       conn = connDAO.getMyConnection();
		       Statement stmt = conn.createStatement();
	           
	           java.sql.Date sqlDate=null;
		       
	           date.trim();
	           if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	           {
	        	   sqlDate = commonDAO.changeStringtoSqlDate(date);
	           }
	            
		        String sqltest="";
		        String sql="";
		        
		        if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and t.account like '%"+accountno+"%'";
		        }
		        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and t.description like '%"+accountname+"%'";
		        }
		        if(!(currency.equalsIgnoreCase("0")) && !(currency.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and c.code like '%"+currency+"%'";
			    }
	        	
	        	sql = "select t.doc_no,t.account,t.description,t.curid,c.code currency,cb.rate,c.type from my_head t left join my_curr c on t.curid=c.doc_no "
	        	 + "left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
	        	 + "where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
	        	 + "where t.atype='GL' and t.grpno=(select acno from my_account where codeno='FUEL CARD')"+sqltest;
		        
		       ResultSet resultSet = stmt.executeQuery(sql);
		       RESULTDATA=commonDAO.convertToJSON(resultSet);
	           
		      stmt.close();
			  conn.close();   
	     } catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     } finally{
				conn.close();
		 }
	       return RESULTDATA;
	  }
	
	public JSONArray fuelcardreimbursementGridReloading(HttpSession session,String docNo,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))){
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
				Statement stmtFCR = conn.createStatement();
			
				String sqlnew=("SELECT m.date,m.RefNo,t.doc_no docno,t.atype type,t.account accounts,t.description accountname1,t.gr_type grtype,c.code currency,c.type currencytype,d.curId currencyid,"
						+ "d.rate rate,(d.AMOUNT*d.dr) amount1,(d.lamount*d.dr) baseamount1,d.description,d.SR_NO sr_no,d.costtype,d.costcode,f.costgroup,v.reg_no FROM my_fuelcardbm m left join my_fuelcardbd d "
						+ "on m.tr_no=d.tr_no left join my_costunit f on d.costtype=f.costtype left join gl_vehmaster v on d.costcode=v.fleet_no left join my_head t on "
						+ "d.acno=t.doc_no left join my_curr c on c.doc_no=d.curId WHERE m.dtype='FCR' and m.brhId="+branch+" and m.doc_no="+docNo+" and d.SR_NO>0");
				
				ResultSet resultSet = stmtFCR.executeQuery (sqlnew);
                
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtFCR.close();
				conn.close();

		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
		return RESULTDATA;
    }
	
	public JSONArray fcrMainSearch(HttpSession session,String partyname,String docNo,String date,String amount,String check) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))){
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
           
     try {
	       conn = connDAO.getMyConnection();
	       Statement stmtFCR = conn.createStatement();
	       
	       java.sql.Date sqlFuelCardReimbursementDate=null;
	        
	        date.trim();
	        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	        {
	        	sqlFuelCardReimbursementDate = commonDAO.changeStringtoSqlDate(date);
	        }

	        String sqltest="";
	        
	        if(!(docNo.equalsIgnoreCase(""))){
	            sqltest=sqltest+" and m.doc_no like '%"+docNo+"%'";
	        }
	        
	        if(!(partyname.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and h.description like '%"+partyname+"%'";
	        }
	        
	        if(!(amount.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and m.totalAmount like '%"+amount+"%'";
	        }
	        
	        if(!(sqlFuelCardReimbursementDate==null)){
		         sqltest=sqltest+" and m.date='"+sqlFuelCardReimbursementDate+"'";
		    } 
	        
	       ResultSet resultSet = stmtFCR.executeQuery("select m.date,m.doc_no,m.totalAmount amount,if(h.description is null,' ',h.description) description from  my_fuelcardbm m "
	       		+ "left join my_fuelcardbd d on m.tr_no=d.tr_no and d.sr_no=0 left join my_head h on d.acno=h.doc_no left join my_brch b on m.brhid=b.doc_no where  m.brhid="+branch+" "
	       		+ "and m.dtype='FCR' and m.status <> 7" +sqltest);
	
	       RESULTDATA=commonDAO.convertToJSON(resultSet);
	       stmtFCR.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
		 conn.close();
	 }
         return RESULTDATA;
    }
	
	 public ClsFuelCardReimbursementBean getViewDetails(HttpSession session,int docNo) throws SQLException {
		ClsFuelCardReimbursementBean fuelCardReimbursementBean = new ClsFuelCardReimbursementBean();
		
		Connection conn = null;
		
		try {
		
			conn = connDAO.getMyConnection();
			Statement stmtFCR = conn.createStatement();
		
			String branch = session.getAttribute("BRANCHID").toString();
			
			ResultSet resultSet = stmtFCR.executeQuery ("SELECT m.date,m.RefNo,t.account,t.description,t.doc_no accno,d.curId,d.rate,(d.AMOUNT*d.dr) amount,(d.lamount*d.dr) lamount,"
				+ "m.DESC1,d.SR_NO,d.TR_NO,j.tranid,c.type FROM my_fuelcardbm m left join my_fuelcardbd d on m.tr_no=d.tr_no left join my_jvtran j on d.tr_no=j.tr_no left join my_head t on "
				+ "d.acno=t.doc_no left join my_curr c on d.curId=c.doc_no WHERE m.dtype='FCR' and d.sr_no=0 and m.status<>7 and m.brhId='"+branch+"' and m.doc_no="+docNo+" group by account");

			while (resultSet.next()) {
				fuelCardReimbursementBean.setTxtfuelcardreimbursementdocno(docNo);
				fuelCardReimbursementBean.setJqxFuelCardReimbursementDate(resultSet.getDate("date").toString());
				fuelCardReimbursementBean.setTxtrefno(resultSet.getString("RefNo"));
				fuelCardReimbursementBean.setTxttranid(resultSet.getInt("tranid"));
				fuelCardReimbursementBean.setTxttrno(resultSet.getInt("TR_NO"));
				
				fuelCardReimbursementBean.setTxtdocno(resultSet.getInt("accno"));
				fuelCardReimbursementBean.setTxtaccid(resultSet.getString("account"));
				fuelCardReimbursementBean.setTxtaccname(resultSet.getString("description"));
				fuelCardReimbursementBean.setHidcmbcurrency(resultSet.getString("curId"));
				fuelCardReimbursementBean.setHidcurrencytype(resultSet.getString("type"));
				fuelCardReimbursementBean.setTxtrate(resultSet.getDouble("rate"));
				fuelCardReimbursementBean.setTxtamount(resultSet.getDouble("amount"));
				fuelCardReimbursementBean.setTxtbaseamount(resultSet.getDouble("lamount"));
				fuelCardReimbursementBean.setTxtdescription(resultSet.getString("DESC1"));
				fuelCardReimbursementBean.setMaindate(resultSet.getDate("date").toString());
		    }
		 stmtFCR.close();
		 conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
		return fuelCardReimbursementBean;
		}

	 public ClsFuelCardReimbursementBean getPrint(HttpServletRequest request,int docNo,int branch,int header) throws SQLException {
		 ClsFuelCardReimbursementBean bean = new ClsFuelCardReimbursementBean();
		 Connection conn = null;
		 
		try {
			
			conn = connDAO.getMyConnection();
			Statement stmtFCR = conn.createStatement();
			
			String headersql="select if(m.dtype='FCR','Fuel Card Reimbursement','  ') vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
					+ "b.cstno from my_fuelcardbm m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='FCR' "
					+ "and m.brhid="+branch+" and m.doc_no="+docNo+"";
				
				ResultSet resultSetHead = stmtFCR.executeQuery(headersql);
				
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
				}
			
				String sqls="select m.doc_no,DATE_FORMAT(m.date ,'%d-%m-%Y') date,m.refno,m.desc1,round(m.totalAmount,2) netAmount,u.user_name from my_fuelcardbm m left join my_user u on "
						+ "m.userid=u.doc_no where m.dtype='FCR' and m.brhid="+branch+" and m.doc_no="+docNo+"";
				
			ResultSet resultSets = stmtFCR.executeQuery(sqls);
			
			while(resultSets.next()){
				
				bean.setLblvoucherno(resultSets.getString("doc_no"));
				bean.setLbldescription(resultSets.getString("desc1"));
				bean.setLbldate(resultSets.getString("date"));
				bean.setLblrefno(resultSets.getString("refno"));
				bean.setLbldebittotal(resultSets.getString("netAmount"));
				bean.setLblcredittotal(resultSets.getString("netAmount"));
				
				bean.setLblpreparedby(resultSets.getString("user_name"));
			}
			
			bean.setTxtheader(header);
			
			String sql="select round(m.totalAmount,2) netAmount,h.description from my_fuelcardbm m left join my_fuelcardbd d on m.tr_no=d.tr_no left join my_head h on "
				+ "d.acno=h.doc_no where m.dtype='FCR' and d.sr_no=0 and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSet = stmtFCR.executeQuery(sql);
			
			ClsAmountToWords c = new ClsAmountToWords();
			
			while(resultSet.next()){
				
				bean.setLblname(resultSet.getString("description"));
				bean.setLblnetamount(resultSet.getString("netAmount"));
				bean.setLblnetamountwords(c.convertAmountToWords(resultSet.getString("netAmount")));
			}

			String sql1 = "";
		
			sql1="SELECT if(d.costcode='0','NIL',d.costcode) fleet_no,if(v.reg_no is null,'NIL',v.reg_no) reg_no,d.description,c.code currency,if(d.amount>0,round((d.amount*1),2),'  ') debit,if(d.amount<0,round((d.amount*-1),2),' ') credit "
				+ "FROM my_fuelcardbm m left join my_fuelcardbd d on m.tr_no=d.tr_no left join gl_vehmaster v on d.costcode=v.fleet_no left join my_curr c on c.doc_no=d.curId WHERE "
				+ "m.dtype='FCR' and m.brhid="+branch+" and m.doc_no="+docNo+" order by d.amount desc";
			
			ResultSet resultSet1 = stmtFCR.executeQuery(sql1);
			
			ArrayList<String> printarray= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setFirstarray(1); 
				String temp="";
				temp=resultSet1.getString("fleet_no")+"::"+resultSet1.getString("reg_no")+"::"+resultSet1.getString("description")+"::"+resultSet1.getString("currency")+"::"+resultSet1.getString("debit")+"::"+resultSet1.getString("credit");
			    printarray.add(temp);
			}

			request.setAttribute("printingarray", printarray);
			
			String sql2 = "select min(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,min(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from my_fuelcardbm m inner join datalog d on "
					+ "(m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='FCR' and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSet2 = stmtFCR.executeQuery(sql2);
			
			while(resultSet2.next()){
				bean.setLblpreparedon(resultSet2.getString("preparedon"));
				bean.setLblpreparedat(resultSet2.getString("preparedat"));
			}
		
			stmtFCR.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
		return bean;
	}
	 
	 public int insertion(Connection conn,int docno,int trno,String formdetailcode,Date fuelcardreimbursementDate, String txtrefno, double txtrate, 
			 String txtdescription, double txtamount, ArrayList<String> fuelcardreimbursementarray, HttpSession session,String mode) throws SQLException{
		
		  try{
				conn.setAutoCommit(false);
				CallableStatement stmtFCR;
				Statement stmtFCR1 = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				/*Fuel Card Reimbursement Grid and Details Saving*/
				for(int i=0;i< fuelcardreimbursementarray.size();i++){
					String[] fuelcardreimbursement=fuelcardreimbursementarray.get(i).split("::");
					if(!fuelcardreimbursement[0].trim().equalsIgnoreCase("undefined") && !fuelcardreimbursement[0].trim().equalsIgnoreCase("NaN")){
					
					int cash = 0,trid = 0;
					int id = 0;
					if(fuelcardreimbursement[3].trim().equalsIgnoreCase("true")){
						cash=0;
						id=1;
					}
					else if(fuelcardreimbursement[3].trim().equalsIgnoreCase("false")){
						cash=1;
						id=-1;
					}
					
					stmtFCR = conn.prepareCall("{CALL fuelcardreimbursementbdDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					/*Insertion to my_fuelcardbd*/
					stmtFCR.setInt(19,trno); 
					stmtFCR.setInt(20,docno);
					stmtFCR.registerOutParameter(21, java.sql.Types.INTEGER);
					stmtFCR.setInt(1,i); //SR_NO
					stmtFCR.setString(2,(fuelcardreimbursement[0].trim().equalsIgnoreCase("undefined") || fuelcardreimbursement[0].trim().equalsIgnoreCase("NaN") || fuelcardreimbursement[0].trim().isEmpty()?0:fuelcardreimbursement[0].trim()).toString());  //doc_no of my_head
					stmtFCR.setString(3,(fuelcardreimbursement[1].trim().equalsIgnoreCase("undefined") || fuelcardreimbursement[1].trim().equalsIgnoreCase("NaN") || fuelcardreimbursement[1].trim().isEmpty()?0:fuelcardreimbursement[1].trim()).toString()); //curId
					stmtFCR.setString(4,(fuelcardreimbursement[2].trim().equalsIgnoreCase("undefined") || fuelcardreimbursement[2].trim().equalsIgnoreCase("NaN") || fuelcardreimbursement[2].trim().equals(0) || fuelcardreimbursement[2].trim().isEmpty()?1:fuelcardreimbursement[2].trim()).toString()); //rate 
					stmtFCR.setInt(5,id); //#credit -1 / debit 1 
					stmtFCR.setString(6,(fuelcardreimbursement[4].trim().equalsIgnoreCase("undefined") || fuelcardreimbursement[4].trim().equalsIgnoreCase("NaN") || fuelcardreimbursement[4].trim().isEmpty()?0:fuelcardreimbursement[4].trim()).toString()); //amount
					stmtFCR.setString(7,(fuelcardreimbursement[5].trim().equalsIgnoreCase("undefined") || fuelcardreimbursement[5].trim().equalsIgnoreCase("NaN") || fuelcardreimbursement[5].trim().isEmpty()?0:fuelcardreimbursement[5].trim()).toString()); //description
					stmtFCR.setString(8,(fuelcardreimbursement[6].trim().equalsIgnoreCase("undefined") || fuelcardreimbursement[6].trim().equalsIgnoreCase("NaN") || fuelcardreimbursement[6].trim().isEmpty()?0:fuelcardreimbursement[6].trim()).toString()); //baseamount
					stmtFCR.setInt(9,cash); //For cash = 0/ party = 1
					stmtFCR.setString(10,(fuelcardreimbursement[8].trim().equalsIgnoreCase("undefined") || fuelcardreimbursement[8].trim().equalsIgnoreCase("NaN") || fuelcardreimbursement[8].trim().equalsIgnoreCase("") || fuelcardreimbursement[8].trim().equalsIgnoreCase("0") || fuelcardreimbursement[8].trim().isEmpty()?0:fuelcardreimbursement[8].trim()).toString()); //Cost type
					stmtFCR.setString(11,(fuelcardreimbursement[9].trim().equalsIgnoreCase("undefined") || fuelcardreimbursement[9].trim().equalsIgnoreCase("NaN") || fuelcardreimbursement[9].trim().equalsIgnoreCase("") || fuelcardreimbursement[9].trim().equalsIgnoreCase("0") || fuelcardreimbursement[9].trim().isEmpty()?0:fuelcardreimbursement[9].trim()).toString()); //Cost Code
					/*my_fuelcardbd Ends*/
					
					/*Insertion to my_jvtran*/
					stmtFCR.setDate(12,fuelcardreimbursementDate);
					stmtFCR.setString(13,txtrefno);
					stmtFCR.setInt(14,id);  //id
					stmtFCR.setString(15,(fuelcardreimbursement[7].trim().equalsIgnoreCase("undefined") || fuelcardreimbursement[7].trim().equalsIgnoreCase("NaN") || fuelcardreimbursement[7].trim().isEmpty()?0:fuelcardreimbursement[7].trim()).toString());  //out-amount
					/*my_jvtran Ends*/
					
					stmtFCR.setString(16,formdetailcode);
					stmtFCR.setString(17,branch);
					stmtFCR.setString(18,userid);
					stmtFCR.setString(22,mode);
					int detail=stmtFCR.executeUpdate();
						if(detail<=0){
							stmtFCR.close();
							conn.close();
							return 0;
						}
						
				 String sql3="SELECT TRANID FROM my_jvtran where TR_NO="+trno+" and acno="+(fuelcardreimbursement[0].trim().equalsIgnoreCase("undefined") || fuelcardreimbursement[0].trim().equalsIgnoreCase("NaN") || fuelcardreimbursement[0].trim().isEmpty()?0:fuelcardreimbursement[0].trim());
				 ResultSet resultSet2 = stmtFCR1.executeQuery(sql3);
				    
				 while (resultSet2.next()) {
					 trid = resultSet2.getInt("TRANID");
				 }

				 if(!fuelcardreimbursement[8].equalsIgnoreCase("0") && !fuelcardreimbursement[8].trim().equalsIgnoreCase("")){
				 
					 String sql4="insert into my_costtran(acno,costtype,amount,sr_no,jobid,tranid,tr_no) values("+(fuelcardreimbursement[0].trim().equalsIgnoreCase("undefined") || fuelcardreimbursement[0].trim().equalsIgnoreCase("NaN") || fuelcardreimbursement[0].trim().isEmpty()?0:fuelcardreimbursement[0].trim())+","
				 		+ ""+(fuelcardreimbursement[8].trim().equalsIgnoreCase("undefined") || fuelcardreimbursement[8].trim().equalsIgnoreCase("NaN") || fuelcardreimbursement[8].trim().equalsIgnoreCase("") || fuelcardreimbursement[8].trim().isEmpty()?0:fuelcardreimbursement[8].trim())+","
				 	    + ""+(fuelcardreimbursement[6].trim().equalsIgnoreCase("undefined") || fuelcardreimbursement[6].trim().equalsIgnoreCase("NaN") || fuelcardreimbursement[6].trim().isEmpty()?0:fuelcardreimbursement[6].trim())+","+i+","
				 	    + ""+(fuelcardreimbursement[9].trim().equalsIgnoreCase("undefined") || fuelcardreimbursement[9].trim().equalsIgnoreCase("NaN") || fuelcardreimbursement[9].trim().isEmpty()?0:fuelcardreimbursement[9].trim())+","+trid+","+trno+")";

				 int data2 = stmtFCR1.executeUpdate(sql4);
				 if(data2<=0){
					    stmtFCR1.close();
						conn.close();
						return 0;
					  }
				 
				 String sql5="update my_jvtran set costtype="+(fuelcardreimbursement[8].trim().equalsIgnoreCase("undefined") || fuelcardreimbursement[8].trim().equalsIgnoreCase("NaN") || fuelcardreimbursement[8].trim().equalsIgnoreCase("") || fuelcardreimbursement[8].trim().isEmpty()?0:fuelcardreimbursement[8].trim())+","
				 		+ "costcode="+(fuelcardreimbursement[9].trim().equalsIgnoreCase("undefined") || fuelcardreimbursement[9].trim().equalsIgnoreCase("NaN") || fuelcardreimbursement[9].trim().isEmpty()?0:fuelcardreimbursement[9].trim())+" where tranid="+trid+"";

				 int data3 = stmtFCR1.executeUpdate(sql5);
				 if(data3<=0){
					    stmtFCR1.close();
						conn.close();
						return 0;
					  }
				 	}	
  				  }
			    }
			    /*Fuel Card Reimbursement Grid and Details Saving Ends*/
				
				/*Deleting account of value zero*/
				String sql2=("DELETE FROM my_jvtran where TR_NO="+trno+" and acno=0");
			    int data = stmtFCR1.executeUpdate(sql2);
			     
			    String sql4=("DELETE FROM my_fuelcardbd where TR_NO="+trno+" and acno=0");
			    int data1 = stmtFCR1.executeUpdate(sql4);
			    /*Deleting account of value zero ends*/
			    
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}

}
