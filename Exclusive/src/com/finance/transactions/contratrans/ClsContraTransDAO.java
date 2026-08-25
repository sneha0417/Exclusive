package com.finance.transactions.contratrans;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.finance.interbranchtransactions.ibbankpayment.ClsIbBankPaymentDAO;
import com.finance.interbranchtransactions.ibcashpayment.ClsIbCashPaymentDAO;
import com.finance.transactions.bankpayment.ClsBankPaymentDAO;
import com.finance.transactions.cashpayment.ClsCashPaymentDAO;

public class ClsContraTransDAO {
	
	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsContraTransBean contraTransBean = new ClsContraTransBean();
	
	public int insert(Date contraTransDate, String formdetailcode,String txtrefno, String cmbtype, int txtfromdocno,String cmbfromcurrency, double txtfromrate,
			int hidchckpdc,int txtpdcacno, String txtchequeno, Date chequeDate,double txtfromamount, double txtfrombaseamount,String txtdescription,int hidchckib, 
			String cmbbranch,String cmbtotype, int txttodocno, String cmbtocurrency,double txttorate, double txttoamount, double txttobaseamount,
			ArrayList<String> cashpaymentarray, ArrayList<String> ibcashpaymentarray, ArrayList<String> bankpaymentarray, ArrayList<String> ibbankpaymentarray,
			HttpSession session, HttpServletRequest request, String mode) throws SQLException {
		
		Connection conn = null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			int total = 0;
	        
			if(cmbbranch==null){
				cmbbranch="";
			}
			
			String chequeStatus="";
					
			if(txtrefno.contains("BPO")){
				chequeStatus="P"; 
			}else{
				chequeStatus="E";
			}
			
			CallableStatement stmtCOT = conn.prepareCall("{CALL contraTransDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtCOT.registerOutParameter(25, java.sql.Types.INTEGER);
			stmtCOT.registerOutParameter(26, java.sql.Types.INTEGER);
			
			stmtCOT.setDate(1,contraTransDate); //Date
			stmtCOT.setString(2,txtrefno); //Ref No
			stmtCOT.setString(3,txtdescription); //Description
			stmtCOT.setString(4,cmbtype); //Type
			stmtCOT.setInt(5,txtfromdocno); //acno
			stmtCOT.setString(6,cmbfromcurrency); //curid
			stmtCOT.setDouble(7,txtfromrate); //Rate
			stmtCOT.setInt(8,hidchckpdc); //pdc
			stmtCOT.setString(9,txtchequeno); //Cheque No
			stmtCOT.setDate(10,chequeDate); //Cheque Date
			stmtCOT.setDouble(11,txtfromamount); //Amount
			stmtCOT.setDouble(12,txtfrombaseamount); //Base Amount
			stmtCOT.setInt(13,hidchckib); //Inter-branch
			stmtCOT.setString(14,cmbbranch.equalsIgnoreCase("")?"0":cmbbranch); //branch
			stmtCOT.setString(15,cmbtotype); //Type To
			stmtCOT.setInt(16,txttodocno); //acno
			stmtCOT.setString(17,cmbtocurrency); //curid
			stmtCOT.setDouble(18,txttorate); //Rate
			stmtCOT.setDouble(19,txttoamount); //Amount
			stmtCOT.setDouble(20,txttobaseamount); //Base Amount
			stmtCOT.setString(21,formdetailcode);
			stmtCOT.setString(22,company);
			stmtCOT.setString(23,branch);
			stmtCOT.setString(24,userid);
			stmtCOT.setString(27,"A");
			int datas=stmtCOT.executeUpdate();
			if(datas<=0){
				stmtCOT.close();
				conn.close();
				return 0;
			}
			int docno=stmtCOT.getInt("docNo");
			int trno=stmtCOT.getInt("itranNo");
			request.setAttribute("tranno", trno);
			contraTransBean.setTxtcontratransdocno(docno);
			if (docno > 0) {
				 Statement stmtCOT1 = conn.createStatement ();
				 ArrayList<String> blankarray= new ArrayList<String>();
				 int insertData = 0,count=0,approvalStatus=3;
				 
				 String sqls="select count(*) as icount from my_apprmaster where status=3 and dtype='"+formdetailcode+"'";
				 ResultSet resultSets = stmtCOT.executeQuery(sqls);
				 
				 while (resultSets.next()) {
					 count=resultSets.getInt("icount");
				 }
				 
				 if(count==0){
					 approvalStatus=3;
				 } else if(count>0) {
					 approvalStatus=0;
				 } 
				 
				if(hidchckib==0 && (cmbtype.equalsIgnoreCase("CASH"))){
					String sql = "insert into my_cashbm(date,RefNo,DESC1,mrate,trMode,trtype,totalAmount,DTYPE,cmpId,brhId,userId,TR_NO,doc_no,STATUS) values"
							+ "('"+contraTransDate+"','"+txtrefno+"','"+txtdescription+"','"+txtfromrate+"',8,8,'"+txttoamount+"','"+formdetailcode+"','"+company+"','"+branch+"',"
							+ "'"+userid+"','"+trno+"','"+docno+"',"+approvalStatus+")";
					int data = stmtCOT1.executeUpdate(sql);
					if(data<=0){
						stmtCOT1.close();
						conn.close();
						return 0;
					}
					ClsCashPaymentDAO cpv = new ClsCashPaymentDAO();
					insertData = cpv.insertion(conn, docno, trno, formdetailcode, contraTransDate, txtrefno, txtfromrate, txtdescription, txttoamount, 0, cashpaymentarray, blankarray, session, mode);
				}
				
				
				if(hidchckib==1 && (cmbtype.equalsIgnoreCase("CASH"))){
					String sql = "insert into my_cashbm(date,RefNo,DESC1,mrate,trMode,trtype,totalAmount,DTYPE,cmpId,brhId,userId,TR_NO,doc_no,STATUS) values"
							+ "('"+contraTransDate+"','"+txtrefno+"','"+txtdescription+"','"+txtfromrate+"',8,8,'"+txttoamount+"','"+formdetailcode+"','"+company+"','"+branch+"',"
							+ "'"+userid+"','"+trno+"','"+docno+"',"+approvalStatus+")";
					int data = stmtCOT1.executeUpdate(sql);
					if(data<=0){
						stmtCOT1.close();
						conn.close();
						return 0;
					}
					ClsIbCashPaymentDAO icpv = new ClsIbCashPaymentDAO();
					insertData = icpv.insertion(conn, docno, trno, formdetailcode, contraTransDate, txtrefno, txtfromrate, txtdescription, txttoamount, 0, ibcashpaymentarray, blankarray, session, mode);
				}
				
				if(hidchckib==0 && (cmbtype.equalsIgnoreCase("BANK"))){
					String sql = "insert into my_chqbm(date,RefNo,DESC1,mrate,chqno,chqdt,trMode,trtype,totalAmount,DTYPE,cmpId,brhId,userId,TR_NO,doc_no,STATUS) values"
							+ "('"+contraTransDate+"','"+txtrefno+"','"+txtdescription+"','"+txtfromrate+"','"+txtchequeno+"','"+chequeDate+"',8,8,'"+txttoamount+"','"+formdetailcode+"',"
						    + "'"+company+"','"+branch+"','"+userid+"','"+trno+"','"+docno+"',"+approvalStatus+")";
					int data = stmtCOT1.executeUpdate(sql);
					if(data<=0){
						stmtCOT1.close();
						conn.close();
						return 0;
					}
					/*Insertion to my_chqdet*/
					if(!(txtrefno.contains("BPO"))){
						
					String sql1=("insert into my_chqdet(chqno,chqdt,opsacno,pdc,Status,postno,tr_no,brhId) values('"+txtchequeno+"','"+chequeDate+"',"+txttodocno+",'"+hidchckpdc+"','"+chequeStatus+"',0,'"+trno+"','"+branch+"')");
					int data1 = stmtCOT1.executeUpdate(sql1);
					if(data1<=0){
						stmtCOT1.close();
						conn.close();
						return 0;
					}
					}
					/*my_chqdet Ends*/
					ClsBankPaymentDAO bpv = new ClsBankPaymentDAO();
					insertData = bpv.insertion(conn, docno, trno, formdetailcode, contraTransDate, txtrefno, txtfromrate, chequeDate, txtchequeno, hidchckpdc, txtdescription, txttoamount, 0, bankpaymentarray, blankarray, session, mode);
				}
				
				
				if(hidchckib==1 && (cmbtype.equalsIgnoreCase("BANK"))){
					String sql = "insert into my_chqbm(date,RefNo,DESC1,mrate,chqno,chqdt,trMode,trtype,totalAmount,DTYPE,cmpId,brhId,userId,TR_NO,doc_no,STATUS) values"
							+ "('"+contraTransDate+"','"+txtrefno+"','"+txtdescription+"','"+txtfromrate+"','"+txtchequeno+"','"+chequeDate+"',8,8,'"+txttoamount+"','"+formdetailcode+"',"
						    + "'"+company+"','"+branch+"','"+userid+"','"+trno+"','"+docno+"',"+approvalStatus+")";
					int data = stmtCOT1.executeUpdate(sql);
					if(data<=0){
						stmtCOT1.close();
						conn.close();
						return 0;
					}
					/*Insertion to my_chqdet*/
					if(!(txtrefno.contains("BPO"))){
						
					String sql1=("insert into my_chqdet(chqno,chqdt,opsacno,pdc,Status,postno,tr_no,brhId) values('"+txtchequeno+"','"+chequeDate+"',"+txttodocno+",'"+hidchckpdc+"','"+chequeStatus+"',0,'"+trno+"','"+branch+"')");
					int data1 = stmtCOT1.executeUpdate(sql1);
					if(data1<=0){
						stmtCOT1.close();
						conn.close();
						return 0;
					}
					}
					/*my_chqdet Ends*/
					ClsIbBankPaymentDAO ibp = new ClsIbBankPaymentDAO();
					insertData = ibp.insertion(conn, docno, trno, formdetailcode, contraTransDate, txtrefno, txtfromrate, chequeDate, txtchequeno, hidchckpdc, txtdescription, txttoamount, 0, ibbankpaymentarray, blankarray, session, mode);
				}
				
				if(insertData<=0){
					stmtCOT.close();
					conn.close();
					return 0;
				}
				/*Insertion to my_cashbd,my_jvtran,my_outd Ends*/
				
				String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
				ResultSet resultSet = stmtCOT.executeQuery(sql1);
			    
				 while (resultSet.next()) {
				 total=resultSet.getInt("jvtotal");
				 }
				 
				if(total == 0){
					conn.commit();
					stmtCOT.close();
					conn.close();
					return docno;
				 }else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
					    stmtCOT.close();
					    return 0;
				    }
			}
			stmtCOT.close();
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
	
	public boolean edit(int txtcontratransdocno, Date contraTransDate,String formdetailcode, String txtrefno, String cmbtype,int txtfromdocno, String cmbfromcurrency, 
			double txtfromrate,int hidchckpdc, int txtpdcacno, String txtchequeno,Date chequeDate, double txtfromamount, double txtfrombaseamount,String txtdescription, 
			int hidchckib, String cmbbranch,String cmbtotype, int txttodocno, String cmbtocurrency,double txttorate, double txttoamount, double txttobaseamount,int txttotrno,
			ArrayList<String> cashpaymentarray, ArrayList<String> ibcashpaymentarray,ArrayList<String> bankpaymentarray, ArrayList<String> ibbankpaymentarray,HttpSession session, 
			HttpServletRequest request, String mode) throws SQLException {
		
		 Connection conn = null;
		
		 try{
			    conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtCOT = conn.createStatement();
				
				if(mode.equalsIgnoreCase("EDIT")){
					mode="E";
				}
				
				int total = 0;
				int trno = txttotrno;
				int docno = txtcontratransdocno;
			    
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String company=session.getAttribute("COMPANYID").toString().trim();
				
				if(cmbbranch==null){cmbbranch="0";}
				if(cmbbranch.equalsIgnoreCase("")){cmbbranch="0";}
				
				/*Updating my_contratrans*/
	            String sql=("update my_contratrans set date='"+contraTransDate+"',ref_no='"+txtrefno+"',description='"+txtdescription+"',type='"+cmbtype+"',acno='"+txtfromdocno+"',"
	            		+ "curId='"+cmbfromcurrency+"',rate='"+txtfromrate+"',pdc='"+hidchckpdc+"',chqno='"+txtchequeno+"',chqdt='"+chequeDate+"',dramount='"+txtfromamount+"',"
	            		+ "lamount='"+txtfrombaseamount+"',ib='"+hidchckib+"',ibbrhid='"+cmbbranch+"',type_to='"+cmbtotype+"',acno_to='"+txttodocno+"',curId_to='"+cmbtocurrency+"',"
	            		+ "rate_to='"+txttorate+"',dramount_to='"+txttoamount+"',lamount_to='"+txttobaseamount+"',brhid='"+branch+"',cmpid='"+company+"' where doc_no='"+txtcontratransdocno+"'");
	            
	            int data = stmtCOT.executeUpdate(sql);   
	            String logsql="insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtcontratransdocno+"','"+branch+"','"+formdetailcode+"','"+contraTransDate+"','"+userid+"','"+mode+"')";
	            stmtCOT.executeUpdate(logsql);      
	            if(data<=0){
					stmtCOT.close();
					conn.close();
					return false;
				}
				/*Updating my_contratrans Ends*/
				
				contraTransBean.setTxtcontratransdocno(docno);
				if (docno > 0) {
					Statement stmtCOT1 = conn.createStatement ();
					 ArrayList<String> blankarray= new ArrayList<String>();
					 int insertData = 0;
					 
					if(hidchckib==0 && (cmbtype.equalsIgnoreCase("CASH"))){
						String sql1 = "update my_cashbm set date='"+contraTransDate+"',RefNo='"+txtrefno+"',DESC1='"+txtdescription+"',mrate='"+txtfromrate+"',trMode=8,"
								+ "totalAmount='"+txttoamount+"',DTYPE='"+formdetailcode+"',cmpId='"+company+"',brhId='"+branch+"' where TR_NO='"+trno+"' and doc_no='"+docno+"'";
						
						int data1 = stmtCOT1.executeUpdate(sql1);
						if(data1<=0){
							stmtCOT1.close();
							conn.close();
							return false;
						}
						/*Deletion from my_cashbd,my_jvtran*/
						int deleteData=cashDeletion(conn, trno);
						if(deleteData<=0){
							stmtCOT1.close();
							conn.close();
							return false;
						}
						/*Deletion from my_cashbd,my_jvtran*/
						ClsCashPaymentDAO cpv = new ClsCashPaymentDAO();
						insertData = cpv.insertion(conn, docno, trno, formdetailcode, contraTransDate, txtrefno, txtfromrate, txtdescription, txttoamount, 0, cashpaymentarray, blankarray, session, mode);
					}
					
					
					if(hidchckib==1 && (cmbtype.equalsIgnoreCase("CASH"))){
						String sql1 = "update my_cashbm set date='"+contraTransDate+"',RefNo='"+txtrefno+"',DESC1='"+txtdescription+"',mrate='"+txtfromrate+"',trMode=8,"
								+ "totalAmount='"+txttoamount+"',DTYPE='"+formdetailcode+"',cmpId='"+company+"',brhId='"+branch+"' where TR_NO='"+trno+"' and doc_no='"+docno+"'";
						int data1 = stmtCOT1.executeUpdate(sql1);
						if(data1<=0){
							stmtCOT1.close();
							conn.close();
							return false;
						}
						/*Deletion from my_cashbd,my_jvtran*/
						int deleteData=cashDeletion(conn, trno);
						if(deleteData<=0){
							stmtCOT1.close();
							conn.close();
							return false;
						}
						/*Deletion from my_cashbd,my_jvtran*/
						ClsIbCashPaymentDAO icpv = new ClsIbCashPaymentDAO();
						insertData = icpv.insertion(conn, docno, trno, formdetailcode, contraTransDate, txtrefno, txtfromrate, txtdescription, txttoamount, 0, ibcashpaymentarray, blankarray, session, mode);
					}
					
					if(hidchckib==0 && (cmbtype.equalsIgnoreCase("BANK"))){
						String sql1 = "update my_chqbm set date='"+contraTransDate+"',RefNo='"+txtrefno+"',DESC1='"+txtdescription+"',mrate="+txtfromrate+",chqno='"+txtchequeno+"',chqdt='"+chequeDate+"',"
								+ "trMode=8,totalAmount="+txttoamount+",DTYPE='"+formdetailcode+"',cmpId="+company+",brhId="+branch+" where TR_NO="+trno+" and doc_no='"+docno+"'";
						int data1 = stmtCOT1.executeUpdate(sql1);
						if(data1<=0){
							stmtCOT1.close();
							conn.close();
							return false;
						}
						/*Updating my_chqdet*/
						String sql2=("update my_chqdet set chqno='"+txtchequeno+"',chqdt='"+chequeDate+"',opsacno="+txttodocno+",pdc='"+hidchckpdc+"',Status='E',postno=0,brhId='"+branch+"' where tr_no="+trno);
						int data2 = stmtCOT1.executeUpdate(sql2);
						if(data2<=0){
							stmtCOT1.close();
							conn.close();
							return false;
						}
						/*my_chqdet Ends*/
						/*Deletion from my_chqbd,my_jvtran*/
						int deleteData=bankDeletion(conn, trno);
						if(deleteData<=0){
							stmtCOT1.close();
							conn.close();
							return false;
						}
						/*Deletion from my_chqbd,my_jvtran*/
						ClsBankPaymentDAO bpv = new ClsBankPaymentDAO();
						insertData = bpv.insertion(conn, docno, trno, formdetailcode, contraTransDate, txtrefno, txtfromrate, chequeDate, txtchequeno, hidchckpdc, txtdescription, txttoamount, 0, bankpaymentarray, blankarray, session, mode);
					}
					
					
					if(hidchckib==1 && (cmbtype.equalsIgnoreCase("BANK"))){
						String sql1 = "update my_chqbm set date='"+contraTransDate+"',RefNo='"+txtrefno+"',DESC1='"+txtdescription+"',mrate="+txtfromrate+",chqno='"+txtchequeno+"',chqdt='"+chequeDate+"',trMode=8,"
								+ "totalAmount="+txttoamount+",DTYPE='"+formdetailcode+"',cmpId="+company+",brhId="+branch+" where TR_NO="+trno+" and doc_no='"+docno+"'";
						int data1 = stmtCOT1.executeUpdate(sql1);
						if(data1<=0){
							stmtCOT1.close();
							conn.close();
							return false;
						}
						/*Updating my_chqdet*/
						String sql2=("update my_chqdet set chqno='"+txtchequeno+"',chqdt='"+chequeDate+"',opsacno="+txttodocno+",pdc='"+hidchckpdc+"',Status='E',postno=0,brhId='"+branch+"' where tr_no="+trno);
						int data2 = stmtCOT1.executeUpdate(sql2);
						if(data2<=0){
							stmtCOT1.close();
							conn.close();
							return false;
						}
						/*my_chqdet Ends*/
						/*Deletion from my_chqbd,my_jvtran*/
						int deleteData=bankDeletion(conn, trno);
						if(deleteData<=0){
							stmtCOT1.close();
							conn.close();
							return false;
						}
						/*Deletion from my_chqbd,my_jvtran*/
						ClsIbBankPaymentDAO ibp = new ClsIbBankPaymentDAO();
						insertData = ibp.insertion(conn, docno, trno, formdetailcode, contraTransDate, txtrefno, txtfromrate, chequeDate, txtchequeno, hidchckpdc, txtdescription, txttoamount, 0, ibbankpaymentarray, blankarray, session, mode);
					}
					
					if(insertData<=0){
						stmtCOT.close();
						conn.close();
						return false;
					}
					/*Insertion to my_cashbd,my_jvtran,my_outd Ends*/
					
					String sql3="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
					ResultSet resultSet = stmtCOT.executeQuery(sql3);
				    
					 while (resultSet.next()) {
					 total=resultSet.getInt("jvtotal");
					 }
					if(total == 0){
						conn.commit();
						stmtCOT.close();
						conn.close();
						return true;
					 }else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
					    stmtCOT.close();
					    return false;
				    }
				}
				stmtCOT.close();
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

	public boolean editMaster(int txtcontratransdocno, String formdetailcode,Date contraTransDate, String txtrefno, String cmbtype, String txtdescription,int txttotrno, 
			HttpSession session, String mode) throws SQLException {
		
		Connection conn = null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtCOT = conn.createStatement();
			
			int trno = txttotrno;
			int docno = txtcontratransdocno;
		    String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			
			/*Updating my_contratrans*/
            String sql=("update my_contratrans set date='"+contraTransDate+"',ref_no='"+txtrefno+"',description='"+txtdescription+"' where doc_no='"+txtcontratransdocno+"'");
            int data = stmtCOT.executeUpdate(sql);
			if(data<=0){
				stmtCOT.close();
				conn.close();
				return false;
			}
			/*Updating my_contratrans Ends*/
			
			contraTransBean.setTxtcontratransdocno(docno);
			if (docno > 0) {
				 Statement stmtCOT1 = conn.createStatement();
				 
				if(cmbtype.equalsIgnoreCase("CASH")){
					String sql1=("update my_cashbm set date='"+contraTransDate+"',RefNo='"+txtrefno+"',DESC1='"+txtdescription+"',trMode=8,DTYPE='"+formdetailcode+"',cmpId='"+company+"',brhId='"+branch+"' where TR_NO='"+trno+"' and doc_no="+txtcontratransdocno);
					int data1 = stmtCOT1.executeUpdate(sql1);
					if(data1<=0){
						stmtCOT1.close();
						conn.close();
						return false;
					}
				}
				
				if(cmbtype.equalsIgnoreCase("BANK")){
					String sql1=("update my_chqbm set date='"+contraTransDate+"',RefNo='"+txtrefno+"',DESC1='"+txtdescription+"',trMode=8,DTYPE='"+formdetailcode+"',cmpId='"+company+"',brhId='"+branch+"' where TR_NO='"+trno+"' and doc_no="+txtcontratransdocno);
					int data1 = stmtCOT1.executeUpdate(sql1);
					if(data1<=0){
						stmtCOT1.close();
						conn.close();
						return false;
					}
				}

				/*Inserting into datalog*/
				String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtcontratransdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
				int datas = stmtCOT.executeUpdate(sqls);
				/*Inserting into datalog Ends*/
				
				conn.commit();
				stmtCOT.close();
				stmtCOT1.close();
				conn.close();
				return true;
			}
			stmtCOT.close();
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

	public boolean delete(int txtcontratransdocno, String cmbtype, String formdetailcode,int txttotrno, HttpSession session, String mode) throws SQLException {
		
		Connection conn = null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtCOT = conn.createStatement();
			
			int trno = txttotrno;
			int docno = txtcontratransdocno;
		    String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			
			/*Updating my_contratrans*/
            String sql=("update my_contratrans set status=7 where doc_no='"+docno+"'");
            int data = stmtCOT.executeUpdate(sql);
			/*Updating my_contratrans Ends*/
				 
			if(cmbtype.equalsIgnoreCase("CASH")){
				String sql1=("update my_cashbm set status=7 where TR_NO='"+trno+"' and doc_no="+docno+"");
				int data1 = stmtCOT.executeUpdate(sql1);
			}
				
			if(cmbtype.equalsIgnoreCase("BANK")){
				String sql1=("update my_chqbm set status=7 where TR_NO='"+trno+"' and doc_no="+docno+"");
				int data1 = stmtCOT.executeUpdate(sql1);
			}
			
			String sql2=("update my_jvtran set status=7 where TR_NO='"+trno+"' and doc_no="+docno+"");
			int data2 = stmtCOT.executeUpdate(sql2);

			/*Inserting into datalog*/
			String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
			int datas = stmtCOT.executeUpdate(sqls);
			/*Inserting into datalog Ends*/
			
			conn.commit();
			stmtCOT.close();
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
	
	public JSONArray contraTransGridReloading(HttpSession session,String docNo) throws SQLException {
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
        String branch = session.getAttribute("BRANCHID").toString();
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtCOT = conn.createStatement();
			
				ResultSet resultSet = stmtCOT.executeQuery ("SELECT j.acno docno,j.description,j.curId currencyid,j.rate,if(j.dramount>0,0,j.dramount*j.id)debit ,if(j.dramount<0,0,j.dramount*j.id) credit,"
						+ "j.ref_row sr_no,j.costtype,j.costcode,c.costgroup,t.atype type,t.account accounts,t.description accountname1,t.gr_type grtype FROM my_jvtran j left join my_costunit c on j.costtype=c.costtype "
						+ "left join my_head t on j.acno=t.doc_no WHERE j.dtype='JVT' and j.brhId='"+branch+"' and j.doc_no='"+docNo+"'");
                
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtCOT.close();
				conn.close();

		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return RESULTDATA;
    }
	
	public JSONArray accountsDetails(HttpSession session,String atype,String accountno,String accountname,String currency,String date,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
	       
		       conn = connDAO.getMyConnection();
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
	           String den= "";
	           
	           java.sql.Date sqlDate=null;
		         
	           date.trim();
	           if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	           {
	        	   sqlDate = commonDAO.changeStringtoSqlDate(date);
	           }
	           
	           if(atype.equalsIgnoreCase("CASH")){
					den="604";
				}
				else if(atype.equalsIgnoreCase("BANK")){
					den="305";
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
		        
		        if(check.equalsIgnoreCase("1")){
		        	
		        /*sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,c.c_rate rate,c.type from my_head t,"
            		+ "(select curId from my_brch where doc_no=  '"+branch+"') h,my_curr c,(select (@i:=0)) a where t.m_s=0 and t.atype='GL' "
            		+ "and c.doc_no=if(t.lApply,h.curId,t.curId) and t.cmpid in(0,'"+company+"') and t.brhid in(0,'"+branch+"') and den='"+den+"'"+sqltest;*/
		        	
		        	sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,cb.rate,c.type from my_head t left join my_curr c on t.curid=c.doc_no "
		  	        	  + "left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
		  	        	  + "where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
		  	        	  + "where t.atype='GL' and t.m_s=0 and t.den='"+den+"'"+sqltest;
		        
		       ResultSet resultSet = stmt.executeQuery(sql);
		       RESULTDATA=commonDAO.convertToJSON(resultSet);
	           
		       stmt.close();
		       conn.close();
		       }
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
	
	public ClsContraTransBean getViewDetails(HttpSession session,int docNo) throws SQLException {
		
	    ClsContraTransBean contraTransBean = new ClsContraTransBean();
		
		Connection conn = null;
		
		try {
		
			conn = connDAO.getMyConnection();
			Statement stmtCOT = conn.createStatement();
	
			String branch = session.getAttribute("BRANCHID").toString();
			
			ResultSet resultSet = stmtCOT.executeQuery ("select m.tr_no,m.date,m.ref_no,m.description desc1,m.type,m.acno,m.curId,m.rate,m.pdc,m.chqno,m.chqdt,m.dramount,"
				+ "m.lamount,m.ib,m.ibbrhid,m.type_to,m.acno_to,m.curId_to,m.rate_to,m.dramount_to,m.lamount_to,j.tranid,h.description,h.account,h1.description accountname,"
				+ "h1.account accounts,(select acno from my_account where codeno='PDCPV') pdcacno,(select type from my_curr where doc_no=m.curId) typefrm,(select type from "
				+ "my_curr where doc_no=m.curId_to) typeto from my_contratrans m left join my_jvtran j on m.tr_no=j.tr_no left join my_head h on m.acno=h.doc_no left join "
				+ "my_head h1 on m.acno_to=h1.doc_no left join my_brch b on m.brhid=b.doc_no where m.brhid='"+branch+"' and m.status <> 7 and m.doc_no="+docNo+" group by h.account");
	
			while (resultSet.next()) {
				contraTransBean.setTxtcontratransdocno(docNo);
				contraTransBean.setJqxContraTransDate(resultSet.getDate("date").toString());
				contraTransBean.setTxtrefno(resultSet.getString("ref_no"));
				contraTransBean.setTxttotranid(resultSet.getInt("tranid"));
				contraTransBean.setTxttotrno(resultSet.getInt("tr_no"));
				
				contraTransBean.setHidcmbtype(resultSet.getString("type"));
				contraTransBean.setTxtfromdocno(resultSet.getInt("acno"));
				contraTransBean.setTxtfromaccid(resultSet.getInt("account"));
				contraTransBean.setTxtfromaccname(resultSet.getString("description"));
				contraTransBean.setHidcmbfromcurrency(resultSet.getString("curId"));
				contraTransBean.setHidfromcurrencytype(resultSet.getString("typefrm"));
				
				contraTransBean.setChckpdc(resultSet.getInt("pdc"));
				contraTransBean.setTxtpdcacno(resultSet.getInt("pdcacno"));
				contraTransBean.setTxtchequeno(resultSet.getString("chqno"));
				contraTransBean.setJqxChequeDate(resultSet.getDate("chqdt").toString());
				
				contraTransBean.setTxtfromrate(resultSet.getDouble("rate"));
				contraTransBean.setTxtfromamount(resultSet.getDouble("dramount"));
				contraTransBean.setTxtfrombaseamount(resultSet.getDouble("lamount"));
				contraTransBean.setTxtdescription(resultSet.getString("desc1"));
				contraTransBean.setHidchckib(resultSet.getInt("ib"));
				contraTransBean.setHidcmbbranch(resultSet.getString("ibbrhid"));
				contraTransBean.setTxttodocno(resultSet.getInt("acno_to"));
				contraTransBean.setHidcmbtotype(resultSet.getString("type_to"));
				contraTransBean.setTxttoaccid(resultSet.getInt("accounts"));
				contraTransBean.setTxttoaccname(resultSet.getString("accountname"));
				contraTransBean.setHidcmbtocurrency(resultSet.getString("curId_to"));
				contraTransBean.setHidtocurrencytype(resultSet.getString("typeto"));
				contraTransBean.setTxttorate(resultSet.getDouble("rate_to"));
				contraTransBean.setTxttoamount(resultSet.getDouble("dramount_to"));
				contraTransBean.setTxttobaseamount(resultSet.getDouble("lamount_to"));
	
				contraTransBean.setMaindate(resultSet.getDate("date").toString());
			    }
			stmtCOT.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		   return contraTransBean;
		}

		public ClsContraTransBean getPrint(HttpServletRequest request,int docNo,int branch,int header) throws SQLException {
			 ClsContraTransBean bean = new ClsContraTransBean();
			 Connection conn = null;
			 
			try {
				conn = connDAO.getMyConnection();
				Statement stmtCOT = conn.createStatement();
				
				String headersql="select c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from my_contratrans m inner join my_brch b on m.brhid=b.doc_no "
						+ "inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) "
						+ "as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.brhid="+branch+" and m.doc_no="+docNo+"";
					
					ResultSet resultSetHead = stmtCOT.executeQuery(headersql);
					
					while(resultSetHead.next()){
						
						bean.setLblcompname(resultSetHead.getString("company"));
						bean.setLblcompaddress(resultSetHead.getString("address"));
						bean.setLblcomptel(resultSetHead.getString("tel"));
						bean.setLblcompfax(resultSetHead.getString("fax"));
						bean.setLblbranch(resultSetHead.getString("branchname"));
						bean.setLbllocation(resultSetHead.getString("location"));
						bean.setLblcstno(resultSetHead.getString("cstno"));
						bean.setLblpan(resultSetHead.getString("pbno"));
						bean.setLblservicetax(resultSetHead.getString("stcno"));
						
					}
					
				ClsAmountToWords c = new ClsAmountToWords();
				
				String type="";	
				String sqls="select m.doc_no,m.type,DATE_FORMAT(m.date ,'%d-%m-%Y') date,m.description,round(m.dramount,2) netAmount,m.ibbrhid,concat(m.chqno,' ',if(m.pdc=1,'(PDC)','')) chqno,"
						+ "if(m.chqno=' ',' ',DATE_FORMAT(m.chqdt ,'%d-%m-%Y')) chqdt,h.description receivedfrom,h1.description paidto,b.branchname interbranch,u.user_name,u1.user_name usersname from my_contratrans m "
						+ "left join my_cashbm d on m.tr_no=d.tr_no left join my_chqbm bc on m.tr_no=bc.tr_no left join my_head h on m.acno=h.doc_no left join my_head h1 on m.acno_to=h1.doc_no left join "
						+ "my_brch b on m.ibbrhid=b.doc_no left join my_user u on d.userid=u.doc_no left join my_user u1 on bc.userid=u1.doc_no where m.brhid="+branch+" and m.doc_no="+docNo+"";
				
				ResultSet resultSets = stmtCOT.executeQuery(sqls);
				
				while(resultSets.next()){
					
					bean.setLblvoucherno(resultSets.getString("doc_no"));
					bean.setLbldate(resultSets.getString("date"));
					bean.setLblnetamount(resultSets.getString("netAmount"));
					bean.setLblnetamountwords(c.convertAmountToWords(resultSets.getString("netAmount")));
					bean.setLbldescription(resultSets.getString("description"));
					
					bean.setLblchqno(resultSets.getString("chqno"));
					bean.setLblchqdate(resultSets.getString("chqdt"));
					
					bean.setLblpaidtoname(resultSets.getString("paidto"));
					bean.setLblreceivedname(resultSets.getString("receivedfrom"));
					
					if(resultSets.getString("ibbrhid").equalsIgnoreCase("0")){
						bean.setFirstarray("1");
					}
					else{
						bean.setLblinterbranch(resultSets.getString("interbranch"));
					}
					
					type=resultSets.getString("type");
					
					if(type.equalsIgnoreCase("CASH")){
						bean.setLblpreparedby(resultSets.getString("user_name"));
					}else if(type.equalsIgnoreCase("BANK")){
						bean.setLblpreparedby(resultSets.getString("usersname"));
					}
					
				}
				
				bean.setTxtheader(header);
				
				String table="";
				if(type.equalsIgnoreCase("CASH")){
					table="my_cashbm";
				}else if(type.equalsIgnoreCase("BANK")){
					table="my_chqbm";
				}
				
				String sql = "select min(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,min(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from "+table+" m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='COT' and m.brhid="+branch+" and m.doc_no="+docNo+"";
				ResultSet resultSet = stmtCOT.executeQuery(sql);
				
				while(resultSet.next()){
					bean.setLblpreparedon(resultSet.getString("preparedon"));
					bean.setLblpreparedat(resultSet.getString("preparedat"));
				}
			
				stmtCOT.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
			return bean;
		}
	
	 public JSONArray cotMainSearch(HttpSession session,String partyname,String docNo,String date,String amount,String chequeNo,String chequeDt,String check) throws SQLException {

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
	       
	        java.sql.Date sqlContraDate=null;
	        java.sql.Date sqlChequeDate=null;
	        
	        date.trim();
	        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	        {
	        	sqlContraDate = commonDAO.changeStringtoSqlDate(date);
	        }
	        
	        chequeDt.trim();
	        if(!(chequeDt.equalsIgnoreCase("undefined"))&&!(chequeDt.equalsIgnoreCase(""))&&!(chequeDt.equalsIgnoreCase("0")))
	        {
	        sqlChequeDate = commonDAO.changeStringtoSqlDate(chequeDt);
	        }
	        
	        String sqltest="";
	        
	        if(!(docNo.equalsIgnoreCase(""))){
	            sqltest=sqltest+" and m.doc_no like '%"+docNo+"%'";
	        }
	        if(!(partyname.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and h.description like '%"+partyname+"%'";
	        }
	        if(!(amount.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and m.dramount_to like '%"+amount+"%'";
	        }
	        if(!(chequeNo.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and m.chqno like '%"+chequeNo+"%'";
	        }
	        if(!(sqlContraDate==null)){
		         sqltest=sqltest+" and m.date='"+sqlContraDate+"'";
		        } 
	         if(!(sqlChequeDate==null)){
	         sqltest=sqltest+" and m.chqdt='"+sqlChequeDate+"'";
	        } 
	           
	     try {
		       conn = connDAO.getMyConnection();
		       Statement stmtCOT = conn.createStatement();
		       
		       String sql =  "select m.doc_no,m.date,m.chqno,m.chqdt,m.dramount_to amount,if(h.description is null,' ',h.description) description "
			       		+ "from my_contratrans m left join my_head h on m.acno_to=h.doc_no where m.brhid='"+branch+"' and m.status <> 7" +sqltest;
		       
		       ResultSet resultSet = stmtCOT.executeQuery(sql);
	
		       RESULTDATA=commonDAO.convertToJSON(resultSet);
		       stmtCOT.close();
		       conn.close();
	     } catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     } finally{
				conn.close();
		 }
           return RESULTDATA;
       }
	 
	 public int cashDeletion(Connection conn,int trno) throws SQLException{
		
		  try{
				Statement stmtCOT2 = conn.createStatement();
				
				String sql=("DELETE FROM my_cashbd WHERE TR_NO="+trno+"");
			    int data = stmtCOT2.executeUpdate(sql);
				 
				String sql1=("DELETE FROM my_jvtran WHERE TR_NO="+trno+"");
				int data1 = stmtCOT2.executeUpdate(sql1);
					
	   } catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}
	 
	 public int bankDeletion(Connection conn,int trno) throws SQLException{
			
		  try{
				Statement stmtCOT2 = conn.createStatement();
				
				String sql=("DELETE FROM my_chqbd WHERE TR_NO="+trno);
			    int data = stmtCOT2.executeUpdate(sql);
				 
				String sql1=("DELETE FROM my_jvtran WHERE TR_NO="+trno);
				int data1 = stmtCOT2.executeUpdate(sql1);
					
	   } catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}

}
