package com.controlcentre.legacydata.accountsopening;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsApplyDelete;
import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAccountsOpeningDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	ClsApplyDelete ClsApplyDelete=new ClsApplyDelete();

	ClsAccountsOpeningBean accountsOpeningBean = new ClsAccountsOpeningBean();
	Connection conn;
	
	 
	public int insert(String formdetailcode, String cmbacctype,int txtdocno, double txtamount,String cmbaccountcurrency, double txtrate,double txtbaseamount, 
			double txtdebittotal, double txtcredittotal, double txtnettotal,ArrayList<String> accountsopeningarray, HttpSession session,HttpServletRequest request,String mode) 
			throws SQLException {
		  
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtOPN1 = conn.createStatement();
			
			int docno=0,trno=0,applydelete=0;
			String dcurdate=null;
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			
			String sqls = "select now() as dcurdate";
			ResultSet resultSet1 = stmtOPN1.executeQuery(sqls);
			
			while (resultSet1.next()) {
				dcurdate=resultSet1.getString("dcurdate");
			}
			
			String[] accountsopening=accountsopeningarray.get(0).split("::");

			if(!(accountsopening[6]).trim().equalsIgnoreCase("undefined")){
				trno = Integer.parseInt(accountsopening[6].toString().trim());
				String sql=("DELETE FROM my_opnbal WHERE TR_NO="+trno+"");
			    int data = stmtOPN1.executeUpdate(sql);
			    
			    applydelete=ClsApplyDelete.getFinanceApplyDelete(conn, trno);
				if(applydelete<0){
					System.out.println("*** ERROR IN APPLY DELETE ***");
					stmtOPN1.close();
					conn.close();
					return 0;
				}
				
				/*Selecting Tran Id
				String sql1=("SELECT TRANID FROM my_jvtran where TR_NO="+trno+" and acno="+txtdocno+"");
				ResultSet resultSet = stmtOPN1.executeQuery(sql1);
				    
				 String tranid="";
				 while(resultSet.next()) {
					tranid+=resultSet.getString("TRANID")+",";
				 } 
				 Selecting Tran Id Ends
				 String tranids[]=tranid.split(",");
				 
					 Deleting from my_outd
					 for(int i=0;i< tranids.length;i++){
						 Deleting from my_outd
						 if(!(tranids[i].toString().equalsIgnoreCase(""))){
							 
							 Selecting Applied Amount & Ap_Trid
							 String sql2=("select tranid,amount from my_outd where ap_trid="+tranids[i]+"");
							 ResultSet resultSet2 = stmtOPN1.executeQuery(sql2);
								    
							 String aptranid="",appliedAmount="";
							 while(resultSet2.next()) {
								 aptranid+=resultSet2.getString("tranid")+",";
								 appliedAmount+=resultSet2.getString("amount")+",";
							 } 
							 
							 String aptranids[]=aptranid.split(",");
							 String appliedAmounts[]=appliedAmount.split(",");
							 Selecting Applied Amount & Ap_Trid Ends
							
							 for(int j=0;j< aptranids.length;j++){
								 Deleting from my_outd
								 if(!(aptranids[j].toString().equalsIgnoreCase(""))){
									 
									 Selecting Out-Amount
									 String sql3=("select out_amount from my_jvtran where tranid='"+aptranids[j]+"'");
									 ResultSet resultSet3 = stmtOPN1.executeQuery(sql3);
										    
									 Double outAmount=0.00;
									 while(resultSet3.next()) {
										 outAmount=resultSet3.getDouble("out_amount");
									 } 
									 Selecting Applied Amount & Ap_Trid Ends

									 if(outAmount<0){
										 outAmount=outAmount*-1;
									 }
									 
									 String sql4="update my_jvtran set out_amount=('"+outAmount+"'-'"+appliedAmounts[j]+"') where TRANID='"+aptranids[j]+"'";
									 int data2 = stmtOPN1.executeUpdate(sql4);
											if(data2<=0){
												stmtOPN1.close();
												conn.close();
												return 0;
											}
								 }
							 }
							 
							 String sql5=("DELETE FROM my_outd WHERE AP_TRID="+tranids[i]);
							 int data3 = stmtOPN1.executeUpdate(sql5);
						 }
						 Deleting from my_outd Ends
					 }*/
				 
				 String sql6=("DELETE FROM my_jvtran WHERE TR_NO="+trno+"");
				 int data4 = stmtOPN1.executeUpdate(sql6);
			}
			
			else{
				/*Inserting into my_trno*/
				String sql = "select (max(trno)+1) as trno from my_trno";
				ResultSet resultSet = stmtOPN1.executeQuery(sql);
				
				while (resultSet.next()) {
					trno=resultSet.getInt("trno");
				}
			     
			    String sql2 = "insert into my_trno(edate,trtype,brhId,USERNO,trno) values('"+dcurdate+"',1,"+branch+","+userid+","+trno+")";
				int data = stmtOPN1.executeUpdate(sql2);
				if(data<=0){
					stmtOPN1.close();
					conn.close();
					return 0;
				}
			}
			
			/*Insertion to my_jvtran,my_opnbal*/
			int insertData=insertion(conn, docno, trno, formdetailcode, cmbacctype, txtdocno, txtamount, cmbaccountcurrency, txtrate, txtbaseamount, txtdebittotal, txtcredittotal, txtnettotal, accountsopeningarray, session, request, mode);
			if(insertData<=0){
				conn.close();
				return 0;
			}
			/*Insertion to my_jvtran,my_opnbal Ends*/
			
			if (insertData > 0) {
				
				String sql3 = "insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+trno+","+branch+",'OPN','"+dcurdate+"',"+userid+",'A')";
				int datas = stmtOPN1.executeUpdate(sql3);
				
				conn.commit();
				stmtOPN1.close();
				conn.close();
				return insertData;
			}
		 
			stmtOPN1.close();
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

	public boolean edit(String formdetailcode,String cmbacctype, int txtdocno, int txttrno, double txtamount,String cmbaccountcurrency, double txtrate, 
			double txtbaseamount,double txtdebittotal, double txtcredittotal, double txtnettotal,ArrayList accountsopeningarray, HttpSession session,
			HttpServletRequest request, String mode) throws SQLException {
		try{
		    conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtOPN1 = conn.createStatement();
			
			int trno = txttrno,docno=0,trid = 0,applydelete=0;
		    String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
		    
		    String sql=("DELETE FROM my_opnbal WHERE TR_NO="+trno);
		    int data = stmtOPN1.executeUpdate(sql);
		    
		    applydelete=ClsApplyDelete.getFinanceApplyDelete(conn, trno);
			if(applydelete<0){
				System.out.println("*** ERROR IN APPLY DELETE ***");
				stmtOPN1.close();
				conn.close();
				return false;
			}
			
		   /* Selecting Tran Id
			String sql1=("SELECT TRANID FROM my_jvtran where TR_NO="+trno+" and acno="+txtdocno+"");
			ResultSet resultSet = stmtOPN1.executeQuery(sql1);
			    
			 String tranid="";
			 while(resultSet.next()) {
				tranid+=resultSet.getString("TRANID")+",";
			 } 
			 Selecting Tran Id Ends
			 String tranids[]=tranid.split(",");
			 
			 for(int i=0;i< tranids.length;i++){
				 Deleting from my_outd
				 if(!(tranids[i].toString().equalsIgnoreCase(""))){
					 
					 Selecting Applied Amount & Ap_Trid
					 String sql2=("select tranid,amount from my_outd where ap_trid="+tranids[i]+"");
					 ResultSet resultSet2 = stmtOPN1.executeQuery(sql2);
						    
					 String aptranid="",appliedAmount="";
					 while(resultSet2.next()) {
						 aptranid+=resultSet2.getString("tranid")+",";
						 appliedAmount+=resultSet2.getString("amount")+",";
					 } 
					 
					 String aptranids[]=aptranid.split(",");
					 String appliedAmounts[]=appliedAmount.split(",");
					 Selecting Applied Amount & Ap_Trid Ends
					
					 for(int j=0;j< aptranids.length;j++){
						 Deleting from my_outd
						 if(!(aptranids[j].toString().equalsIgnoreCase(""))){
							 
							 Selecting Out-Amount
							 String sql3=("select out_amount from my_jvtran where tranid='"+aptranids[j]+"'");
							 ResultSet resultSet3 = stmtOPN1.executeQuery(sql3);
								    
							 Double outAmount=0.00;
							 while(resultSet3.next()) {
								 outAmount=resultSet3.getDouble("out_amount");
							 } 
							 Selecting Applied Amount & Ap_Trid Ends

							 if(outAmount<0){
								 outAmount=outAmount*-1;
							 }
							 
							 String sql4="update my_jvtran set out_amount=('"+outAmount+"'-'"+appliedAmounts[j]+"') where TRANID='"+aptranids[j]+"'";
							 int data2 = stmtOPN1.executeUpdate(sql4);
									if(data2<=0){
										stmtOPN1.close();
										conn.close();
										return false;
									}
						 }
					 }
					 
					 String sql5=("DELETE FROM my_outd WHERE AP_TRID="+tranids[i]);
					 int data1 = stmtOPN1.executeUpdate(sql5);
				 }
				 Deleting from my_outd Ends
			 }*/
			 
			 String sql3=("DELETE FROM my_jvtran WHERE TR_NO="+trno+"");
			 int data2 = stmtOPN1.executeUpdate(sql3);
			 
			if (trno > 0) {
			
				/*Insertion to my_jvtran,my_opnbal*/
				int insertData=insertion(conn, docno, trno, formdetailcode, cmbacctype, txtdocno, txtamount, cmbaccountcurrency, txtrate, txtbaseamount, txtdebittotal, txtcredittotal, txtnettotal, accountsopeningarray, session, request, mode);
				if(insertData<=0){
					conn.close();
					return false;
				}
				/*Insertion to my_jvtran,my_opnbal Ends*/
				
				/*Inserting into datalog*/
				String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txttrno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
				int datas = stmtOPN1.executeUpdate(sqls);
				/*Inserting into datalog Ends*/
				
				conn.commit();
				stmtOPN1.close();
				conn.close();
				return true;
			}
			stmtOPN1.close();
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
	
	public boolean delete(int txttrno, int txtdocno, String formdetailcode,HttpSession session) throws SQLException {
		
		try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtOPN = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				int trno = txttrno,applydelete=0;
				 
				applydelete=ClsApplyDelete.getFinanceApplyDelete(conn, trno);
				if(applydelete<0){
					System.out.println("*** ERROR IN APPLY DELETE ***");
					stmtOPN.close();
					conn.close();
					return false;
				}
				
				 /*Status change in my_opnbal*/
				 String sql3=("update my_opnbal set STATUS=7 where TR_NO="+trno+"");
				 int data = stmtOPN.executeUpdate(sql3);
				 if(data<=0){
					   stmtOPN.close();
		    			conn.close();
		    			return false;
		            }
				/*Status change in my_opnbal Ends*/
				 
				 /*Inserting into datalog*/
				 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+trno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','D')");
				 int datas = stmtOPN.executeUpdate(sqls);
				 /*Inserting into datalog Ends*/
				
				/*Status change in my_jvtran*/
				 String sql4=("update my_jvtran set STATUS=7 where TR_NO="+trno+"");
				 int data1 = stmtOPN.executeUpdate(sql4);
				 if(data1<=0){
					    stmtOPN.close();
		    			conn.close();
		    			return false;
		            }
				/*Status change in my_jvtran Ends*/
				 
				if (trno > 0) {
					conn.commit();
					stmtOPN.close();
				    conn.close();
					return true;
				}	
				stmtOPN.close();
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
	  
	public  JSONArray clientAccountsDetails(HttpSession session,String atype,String date,String accountno,String accountname,String mobile,String currency,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
		       conn = ClsConnection.getMyConnection();
		       Statement stmt = conn.createStatement();
	
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
	           String company = session.getAttribute("COMPANYID").toString();
	           
		        String sqltest="";
		        String sql="";
		        
		        String code= "";String den="";
				
		        java.sql.Date sqlDate=null;
		        
		        if(check.equalsIgnoreCase("1")){

		        date.trim();
	            if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	            {
	        	   sqlDate = ClsCommon.changeStringtoSqlDate(date);
	            }
	            
		        if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and t.account like '%"+accountno+"%'";
		        }
		        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and t.description like '%"+accountname+"%'";
		        }
		        if(!(mobile.equalsIgnoreCase("0")) && !(mobile.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and a.per_mob like '%"+mobile+"%'";
		        }
		        if(!(currency.equalsIgnoreCase("0")) && !(currency.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and c.code like '%"+currency+"%'";
			    }
		        	
		        
		        if(atype.equalsIgnoreCase("AP") || atype.equalsIgnoreCase("AR")){
						
						if(atype.equalsIgnoreCase("AP")){
							code="VND";
						}
						else if(atype.equalsIgnoreCase("AR")){
							code="CRM";
						}

						sql= "select t.doc_no,t.account,t.description,t.curid,c.code currency,a.cldocno,c.type,round(cb.rate,2) c_rate,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_head t inner join my_acbook a on t.cldocno=a.cldocno and "
				        		+ "a.dtype='"+code+"' and t.atype='"+atype+"' left join my_curr c on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
				        		+ "from my_curbook cr where  coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where a.active=1 and t.m_s=0"+sqltest;

						}
				
						if(atype.equalsIgnoreCase("GL")){
							den=" and t.den!=305";
						}
						else if(atype.equalsIgnoreCase("BANK")){
							den="  and t.den=305";
						}
						
						if(atype.equalsIgnoreCase("GL") || atype.equalsIgnoreCase("BANK")){
							
							sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,cb.rate c_rate,c.type from my_head t left join my_curr c on t.curid=c.doc_no "
						        	  + "left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
						        	  + "where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
						        	  + "where t.atype='GL' and t.m_s=0 "+den+""+sqltest;
							
						}
						
						if(atype.equalsIgnoreCase("HR")){
						    
						    sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,c.type,round(cb.rate,2) c_rate from my_head t left join my_curr c "
									+ "on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,"
									+ "cr.frmDate from my_curbook cr where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo "
									+ "on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where t.atype='"+atype+"' and t.m_s=0"+sqltest;
						}
		System.out.println("=== "+sql);       
		       ResultSet resultSet = stmt.executeQuery(sql);
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	           
		       stmt.close();
		       conn.close();
		       }
		        stmt.close();
			    conn.close();
	     }catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     }finally{
	    	 conn.close();
	     }
	       return RESULTDATA;
	  }
	
	public  JSONArray applyInvoiceGridReloading(String trNo) throws SQLException {
        List<ClsAccountsOpeningBean> applyInvoiceGridReloadingBean = new ArrayList<ClsAccountsOpeningBean>();

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        		
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtOPN = conn.createStatement();
				
				ResultSet resultSet = stmtOPN.executeQuery ("select o.date,o.doc_no,if(o.amount>0,o.amount*1,0) debit,if(o.amount<0,o.amount*-1,0) credit,"
					+ "if(o.baseamount<0,round(o.baseamount*-1,2),round(o.baseamount,2)) baseamount,o.description,o.tr_no,c.c_rate rate,c.type from my_opnbal o left join my_curr c on o.curid=c.doc_no where o.status<>7 and "
					+ "o.tr_no="+trNo+"");

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtOPN.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public  JSONArray applyInvoiceGridLoading(HttpSession session,String accNo) throws SQLException {
        List<ClsAccountsOpeningBean> applyInvoiceGridReloadingBean = new ArrayList<ClsAccountsOpeningBean>();

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        		
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtOPN = conn.createStatement();
				String branch=session.getAttribute("BRANCHID").toString();
				
				ResultSet resultSet = stmtOPN.executeQuery ("select o.date,o.doc_no,if(o.amount>0,o.amount*1,0) debit,if(o.amount<0,o.amount*-1,0) credit,"
					+ "if(o.baseamount<0,round(o.baseamount*-1,2),round(o.baseamount,2)) baseamount,o.description,o.tr_no,c.type from my_opnbal o left join my_curr c on o.curid=c.doc_no where o.status<>7 and "
					+ "o.brhid="+branch+" and o.acno="+accNo+"");
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtOPN.close();
				conn.close();
		}catch(Exception e){
			conn.close();
			e.printStackTrace();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public  JSONArray opnMainSearch(HttpSession session,String accountNo,String accountName,String total) throws SQLException {
	   	   JSONArray RESULTDATA=new JSONArray();
	    	
	   	Connection conn = null;
	   	
			try {
					conn = ClsConnection.getMyConnection();
					Statement stmtOPN = conn.createStatement();
					
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
					
					String sqltest="";
			    	
			    	if(!(accountNo.equalsIgnoreCase(""))){
			    		sqltest=sqltest+" and t.account like '%"+accountNo+"%'";
			    	}
			    	if(!(accountName.equalsIgnoreCase(""))){
			    		sqltest=sqltest+" and t.description like '%"+accountName+"%'";
			    	}
			    	if(!(total.equalsIgnoreCase(""))){
			    		sqltest=sqltest+" and o.total like '%"+total+"%'";
			    	}
                 
					String sql=("select o.total,o.tr_no,t.account,t.description from my_opnbal o left join my_head t on o.acno=t.doc_no where o.brhid="+branch+" and o.status <> 7 "+sqltest+" group by account");
					
					ResultSet resultSet = stmtOPN.executeQuery(sql);

					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtOPN.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
			return RESULTDATA;
	    }
	
	public  ClsAccountsOpeningBean getViewDetails(int trNo) throws SQLException {
		//String branch = session.getAttribute("BRANCHID").toString();
		ClsAccountsOpeningBean accountsOpeningBean = new ClsAccountsOpeningBean();
		
		Connection conn = null;
		
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtOPN = conn.createStatement();
			
			ResultSet resultSet = stmtOPN.executeQuery ("select o.acno,o.total,o.curid,o.rate,o.atype,o.debittotal,o.credittotal,o.baseTotal,t.account,t.description,c.code currency,c.type from "
					+ "my_opnbal o left join my_head t on o.acno=t.doc_no left join my_curr c on t.curid=c.doc_no where o.status <> 7 and o.tr_no="+trNo+" group by account");
	
			while (resultSet.next()) {
				accountsOpeningBean.setTxttrno(trNo);
				//accountsOpeningBean.setJqxAccountOpeningDate(resultSet.getDate("date").toString());
				accountsOpeningBean.setHidcmbacctype(resultSet.getString("atype"));
				accountsOpeningBean.setTxtdocno(resultSet.getInt("acno"));
				accountsOpeningBean.setTxtaccid(resultSet.getString("account"));
				accountsOpeningBean.setTxtaccname(resultSet.getString("description"));
				accountsOpeningBean.setTxtaccountcurrencyid(resultSet.getString("curid"));
				accountsOpeningBean.setTxtaccountcurrency(resultSet.getString("currency"));
				accountsOpeningBean.setHidcurrencytype(resultSet.getString("type"));
				accountsOpeningBean.setTxtrate(resultSet.getDouble("rate"));
				accountsOpeningBean.setTxtdebittotal(resultSet.getDouble("debittotal"));
				accountsOpeningBean.setTxtcredittotal(resultSet.getDouble("credittotal"));
				accountsOpeningBean.setTxtnettotal(resultSet.getDouble("total"));
				accountsOpeningBean.setTxtbaseamount(resultSet.getDouble("baseTotal"));
			    }
			stmtOPN.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return accountsOpeningBean;
		}
	
	public int insertion(Connection conn,int docno,int trno,String formdetailcode,String cmbacctype,int txtdocno, double txtamount,String cmbaccountcurrency, double txtrate,double txtbaseamount, 
			double txtdebittotal, double txtcredittotal, double txtnettotal,ArrayList<String> accountsopeningarray, HttpSession session,HttpServletRequest request,String mode) throws SQLException{
		
		try{
			conn.setAutoCommit(false);
			CallableStatement stmtOPN=null;
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			
			/*Accounts Invoice Grid and Details Saving*/
			for(int i=0;i< accountsopeningarray.size();i++){
				String[] accountsopening=accountsopeningarray.get(i).split("::");
				if(!accountsopening[0].equalsIgnoreCase("undefined") && !accountsopening[0].equalsIgnoreCase("NaN")){
				
				double amount = Double.parseDouble(accountsopening[3].toString());
				java.sql.Date accDate=null;

				if((accountsopening[1].toString()) != null){
				  accDate = ClsCommon.changetstmptoSqlDate((accountsopening[1].equalsIgnoreCase("undefined") || accountsopening[1].equalsIgnoreCase("NaN") || accountsopening[1].isEmpty()?0:accountsopening[1]).toString());
				}
				
				stmtOPN = conn.prepareCall("{CALL accountsOpeningDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtOPN.registerOutParameter(20, java.sql.Types.INTEGER);
				
				stmtOPN.setInt(1,i);
				stmtOPN.setString(2, cmbacctype); //Type
				stmtOPN.setInt(3,txtdocno); //Doc no of my_head
				stmtOPN.setString(4,cmbaccountcurrency); //account currency
				stmtOPN.setDouble(5,txtrate); //currency rate
				stmtOPN.setDouble(6,amount);//amount
				stmtOPN.setString(7,(accountsopening[2].trim().equalsIgnoreCase("undefined") || accountsopening[2].trim().equalsIgnoreCase("NaN") || accountsopening[2].trim().isEmpty()?"":accountsopening[2].trim()).toString()); //description
				stmtOPN.setString(8,(accountsopening[4].equalsIgnoreCase("undefined") || accountsopening[4].equalsIgnoreCase("NaN") || accountsopening[0].isEmpty()?0:accountsopening[4]).toString()); //baseamount
				stmtOPN.setDouble(9,txtnettotal); //total amount
				stmtOPN.setDouble(10,txtdebittotal); //debit total
				stmtOPN.setDouble(11,txtcredittotal); //credit total
				stmtOPN.setDouble(12,txtbaseamount); //total base amount
				stmtOPN.setDate(13,accDate); //Date
				stmtOPN.setString(14,(accountsopening[0].equalsIgnoreCase("undefined") || accountsopening[0].equalsIgnoreCase("NaN") || accountsopening[0].isEmpty()?0:accountsopening[0]).toString()); //doc_no
				stmtOPN.setString(15,(accountsopening[5].equalsIgnoreCase("undefined") || accountsopening[5].equalsIgnoreCase("NaN") || accountsopening[5].isEmpty()?0:accountsopening[5]).toString()); //id
				stmtOPN.setString(16,formdetailcode);
				stmtOPN.setString(17,branch);
				stmtOPN.setString(18,userid);
				stmtOPN.setInt(19, trno);
				stmtOPN.setString(21,mode);
				int data2=stmtOPN.executeUpdate();
				if(data2<=0){
					stmtOPN.close();
					conn.close();
					return 0;
				}
				docno=stmtOPN.getInt("docNo");
				trno=stmtOPN.getInt("itranNo");
				request.setAttribute("tranno", trno);
				accountsOpeningBean.setTxtaccountopeningdocno(docno);
				 }
			}
			stmtOPN.close();						
   }catch(Exception e){	
	 	e.printStackTrace();
	 	conn.close();
	 	return 0;
 }
	return 1;
}

}
