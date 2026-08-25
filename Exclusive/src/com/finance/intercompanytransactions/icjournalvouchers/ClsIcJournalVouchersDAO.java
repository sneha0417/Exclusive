package com.finance.intercompanytransactions.icjournalvouchers;

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
import net.sf.json.JSONObject;

import com.common.ClsAmountToWords;
import com.common.ClsApplyDelete;
import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsIcJournalVouchersDAO {
	
	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsIcJournalVouchersBean icJournalVouchersBean = new ClsIcJournalVouchersBean();
	
	public int insert(Date icjournalvouchersDate, String formdetailcode1, String txtrefno, String txtdescription, double txtdrtotal, double txtcrtotal,
			ArrayList<String> icjournalvouchersarray, HttpSession session,HttpServletRequest request) throws SQLException {
		
		Connection conn = null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);

			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString();
			String company=session.getAttribute("COMPANYID").toString();
			int total = 0;String formdetailcode ="",referenceId="";
			
			if(formdetailcode1.contains("-")){
				String[] parts = formdetailcode1.split("-");
				formdetailcode = parts[0]; 
				referenceId = parts[1];
			}else{
				formdetailcode=formdetailcode1;
				referenceId="0";
			}
			
			if(txtdrtotal<0){
				txtdrtotal=txtdrtotal*-1;
			}
			
			if(txtcrtotal<0){
				txtcrtotal=txtcrtotal*-1;
			}
			
			CallableStatement stmtICJV = conn.prepareCall("{CALL icJvmaDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtICJV.registerOutParameter(11, java.sql.Types.INTEGER);
			stmtICJV.registerOutParameter(12, java.sql.Types.INTEGER);
			
			stmtICJV.setDate(1,icjournalvouchersDate); //Date
			stmtICJV.setString(2,txtrefno); //Ref No
			stmtICJV.setString(3,txtdescription); //Description
			stmtICJV.setDouble(4,txtdrtotal); //Dr Total
			stmtICJV.setDouble(5,txtcrtotal); //Cr Total
			stmtICJV.setString(6,formdetailcode);
			stmtICJV.setString(7,company);
			stmtICJV.setString(8,branch);
			stmtICJV.setString(9,userid);
			stmtICJV.setString(10,referenceId);//Distinguishing Reference Id
			stmtICJV.setString(13,"A");
			int datas=stmtICJV.executeUpdate();
			if(datas<=0){
				stmtICJV.close();
				conn.close();
				return 0;
			}
			int docno=stmtICJV.getInt("docNo");
			int trno=stmtICJV.getInt("itranNo");
			request.setAttribute("tranno", trno);
			icJournalVouchersBean.setTxticjournalvouchersdocno(docno);
			if (docno > 0) {

				Statement stmtICJV1 = conn.createStatement();
				
				/*IC Journal Voucher Grid Saving*/
				for(int i=0;i< icjournalvouchersarray.size();i++){
				String[] icjournalvoucher=icjournalvouchersarray.get(i).split("::");
				
				 if(!icjournalvoucher[0].equalsIgnoreCase("undefined") && !icjournalvoucher[0].equalsIgnoreCase("NaN")){
				 int intrCmpid=0,accountDocNo=0,icldocno=0,ilapply=0,trid=0,checkloop=0;
				 
				 String sql="SELECT doc_no FROM intercompany.my_intrcomp WHERE cmpid='"+company+"' and brhid='"+branch+"'";
				 ResultSet resultSet = stmtICJV.executeQuery(sql);
				 while (resultSet.next()) {
					 intrCmpid = resultSet.getInt("doc_no");
				 }
				 
				 String sql1="Select h.doc_no as accountDocNo from my_head h INNER JOIN intercompany.my_intrcmp c ON (c.doc_no=h.doc_no) left JOIN intercompany.my_intrcomp co ON (co.doc_no= c.cmp2) "  
							+ "left JOIN intercompany.my_intrcomp co1 ON (co1.doc_no= c.cmp1) where h.doc_no=c.doc_no and ((c.cmp1="+intrCmpid+" and  "
							+ "c.cmp2="+(icjournalvoucher[12].trim().equalsIgnoreCase("undefined") || icjournalvoucher[12].trim().equalsIgnoreCase("NaN") || icjournalvoucher[12].trim().equalsIgnoreCase("") || icjournalvoucher[12].trim().equalsIgnoreCase("0") || icjournalvoucher[12].trim().isEmpty()?"1":icjournalvoucher[12].trim()).toString()+") or "
							+ "(c.cmp1="+(icjournalvoucher[12].trim().equalsIgnoreCase("undefined") || icjournalvoucher[12].trim().equalsIgnoreCase("NaN") || icjournalvoucher[12].trim().equalsIgnoreCase("") || icjournalvoucher[12].trim().equalsIgnoreCase("0") || icjournalvoucher[12].trim().isEmpty()?"1":icjournalvoucher[12].trim()).toString()+" and  "
							+ "c.cmp2="+intrCmpid+"))";
				 ResultSet resultSet1 = stmtICJV.executeQuery(sql1);
					    
				 while (resultSet1.next()) {
						accountDocNo = resultSet1.getInt("accountDocNo");
				 }
				
				 String sql2=("select cldocno,lapply from my_head where doc_no="+(icjournalvoucher[0].equalsIgnoreCase("undefined") || icjournalvoucher[0].isEmpty()?0:icjournalvoucher[0]));
				 ResultSet resultSet2 = stmtICJV.executeQuery(sql2);
				 
				 while (resultSet2.next()) {
					 icldocno=resultSet2.getInt("cldocno");
					 ilapply=resultSet2.getInt("lapply");
				 }
				 
				if(accountDocNo>0){
					
					String sql5="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,trtype,ref_row,LAGE,cldocno,lbrrate,id,costtype,costcode,"
							+ "dTYPE,brhId,intrcmpid,tr_no,STATUS)VALUES('"+icjournalvouchersDate+"','"+txtrefno+"','"+docno+"','"+accountDocNo+"',"
							+ "'"+(icjournalvoucher[1].trim().equalsIgnoreCase("undefined") || icjournalvoucher[1].trim().equalsIgnoreCase("NaN") || icjournalvoucher[1].trim().isEmpty()?0:icjournalvoucher[1].trim())+"',"
							+ "'"+(icjournalvoucher[2].trim().equalsIgnoreCase("undefined") || icjournalvoucher[2].trim().equalsIgnoreCase("NaN") || icjournalvoucher[2].trim().isEmpty()?0:icjournalvoucher[2].trim())+"',"
						    + "'"+(icjournalvoucher[3].trim().equalsIgnoreCase("undefined") || icjournalvoucher[3].trim().equalsIgnoreCase("NaN") || icjournalvoucher[2].trim().equals(0) || icjournalvoucher[3].trim().isEmpty()?1:icjournalvoucher[3].trim()).toString()+"',"
						    + "'"+(icjournalvoucher[4].trim().equalsIgnoreCase("undefined") || icjournalvoucher[4].trim().equalsIgnoreCase("NaN") || icjournalvoucher[4].trim().isEmpty()?"0":icjournalvoucher[4].trim())+"',"
						    + "'"+(icjournalvoucher[5].trim().equalsIgnoreCase("undefined") || icjournalvoucher[5].trim().equalsIgnoreCase("NaN") || icjournalvoucher[5].trim().isEmpty()?"0":icjournalvoucher[5].trim())+"',0,"
						    + "4,"+(i+2)+",0,0,"
						    + "'"+(icjournalvoucher[3].trim().equalsIgnoreCase("undefined") || icjournalvoucher[3].trim().equalsIgnoreCase("NaN") || icjournalvoucher[3].trim().isEmpty()?0:icjournalvoucher[3].trim())+"',"
						    + "'"+(icjournalvoucher[7].trim().equalsIgnoreCase("undefined") || icjournalvoucher[7].trim().equalsIgnoreCase("NaN") || icjournalvoucher[7].trim().isEmpty()?"0":icjournalvoucher[7].trim())+"',"
						    + "'"+(icjournalvoucher[8].trim().equalsIgnoreCase("undefined") || icjournalvoucher[8].trim().equalsIgnoreCase("NaN") || icjournalvoucher[8].trim().equalsIgnoreCase("") || icjournalvoucher[8].trim().isEmpty()?0:icjournalvoucher[8].trim())+"',"
						    + "'"+(icjournalvoucher[9].trim().equalsIgnoreCase("undefined") || icjournalvoucher[9].trim().equalsIgnoreCase("NaN") || icjournalvoucher[9].trim().equalsIgnoreCase("") || icjournalvoucher[9].trim().isEmpty()?0:icjournalvoucher[9].trim())+"',"
						    + "'"+formdetailcode+"',"
						    + "'"+branch+"',"
						    + "'"+(icjournalvoucher[12].trim().equalsIgnoreCase("undefined") || icjournalvoucher[12].trim().equalsIgnoreCase("NaN") || icjournalvoucher[12].trim().equalsIgnoreCase("") || icjournalvoucher[12].trim().isEmpty()?0:icjournalvoucher[12].trim())+"',"
						    + "'"+trno+"',3)";
					int data2 = stmtICJV1.executeUpdate(sql5);
					if(data2<=0){
						stmtICJV.close();
						conn.close();
						return 0;
					}
					
					// int itranNo=0;
					int itranNo=0,idocNo=0,icmpId=0;
					 
					 String sql6="select ic.tr_no,ic.doc_no,ic.cmpid  from intercompany.my_intrcmptrno ic left join intercompany.my_intrcomp cp on ic.cmpid=cp.doc_no where "
							 + "cp.dbname='"+(icjournalvoucher[10].trim().equalsIgnoreCase("undefined") || icjournalvoucher[10].trim().equalsIgnoreCase("NaN") || icjournalvoucher[10].trim().equalsIgnoreCase("") || icjournalvoucher[10].trim().equalsIgnoreCase("0") || icjournalvoucher[10].trim().isEmpty()?" ":icjournalvoucher[10].trim()).toString()+"' "
							 + "and cp.cmpid=(select cmpid from intercompany.my_intrcomp where doc_no='"+(icjournalvoucher[12].trim().equalsIgnoreCase("undefined") || icjournalvoucher[12].trim().equalsIgnoreCase("NaN") || icjournalvoucher[12].trim().equalsIgnoreCase("") || icjournalvoucher[12].trim().equalsIgnoreCase("0") || icjournalvoucher[12].trim().isEmpty()?"1":icjournalvoucher[12].trim()).toString()+"') "
							 + "and ic.dtype='ICJV' and ic.doc_no="+docno+"";
					 ResultSet resultSet6 = stmtICJV1.executeQuery(sql6);
					    
					 while (resultSet6.next()) {
						itranNo = resultSet6.getInt("tr_no");
						idocNo = resultSet6.getInt("doc_no");
						icmpId = resultSet6.getInt("cmpid");
					 }
					 
					 if(itranNo==0) {
						 
						 String sql7="select coalesce((max(trno)+1),1) as itranNo from "+(icjournalvoucher[10].trim().equalsIgnoreCase("undefined") || icjournalvoucher[10].trim().equalsIgnoreCase("NaN") || icjournalvoucher[10].trim().equalsIgnoreCase("") || icjournalvoucher[10].trim().equalsIgnoreCase("0") || icjournalvoucher[10].trim().isEmpty()?" ":icjournalvoucher[10].trim()).toString()+".my_trno";
						 ResultSet resultSet7 = stmtICJV1.executeQuery(sql7);
						    
						 while (resultSet7.next()) {
							itranNo = resultSet7.getInt("itranNo");
						 }
						 
						 String sql8="insert into "+(icjournalvoucher[10].trim().equalsIgnoreCase("undefined") || icjournalvoucher[10].trim().equalsIgnoreCase("NaN") || icjournalvoucher[10].trim().equalsIgnoreCase("") || icjournalvoucher[10].trim().equalsIgnoreCase("0") || icjournalvoucher[10].trim().isEmpty()?" ":icjournalvoucher[10].trim()).toString()+".my_trno(edate,trtype,brhId,USERNO,trno) values('"+icjournalvouchersDate+"',4,'"+(icjournalvoucher[12].trim().equalsIgnoreCase("undefined") || icjournalvoucher[12].trim().equalsIgnoreCase("NaN") || icjournalvoucher[12].trim().equalsIgnoreCase("") || icjournalvoucher[12].trim().equalsIgnoreCase("0") || icjournalvoucher[12].trim().isEmpty()?"1":icjournalvoucher[12].trim()).toString()+"','"+userid+"',"+itranNo+")";
						 int data3 = stmtICJV1.executeUpdate(sql8);
						 if(data3<=0){
							   stmtICJV1.close();
							   conn.close();
							   return 0;
						 }
						 
						 checkloop=1;
					 
					 }
					 
					 if(idocNo!=docno && icmpId!=Integer.parseInt(icjournalvoucher[12].trim())){
						 String sql9="insert into intercompany.my_intrcmptrno(doc_no, dtype, cmpid, tr_no) values('"+docno+"', 'ICJV', '"+(icjournalvoucher[12].trim().equalsIgnoreCase("undefined") || icjournalvoucher[12].trim().equalsIgnoreCase("NaN") || icjournalvoucher[12].trim().equalsIgnoreCase("") || icjournalvoucher[12].trim().equalsIgnoreCase("0") || icjournalvoucher[12].trim().isEmpty()?"1":icjournalvoucher[12].trim()).toString()+"', "+itranNo+")";								 
						 int data6 = stmtICJV1.executeUpdate(sql9);
						 if(data6<=0){
							   stmtICJV1.close();
							   conn.close();
							   return 0;
						 }
					 }
					 String sql10="insert into "+(icjournalvoucher[10].trim().equalsIgnoreCase("undefined") || icjournalvoucher[10].trim().equalsIgnoreCase("NaN") || icjournalvoucher[10].trim().equalsIgnoreCase("") || icjournalvoucher[10].trim().equalsIgnoreCase("0") || icjournalvoucher[10].trim().isEmpty()?" ":icjournalvoucher[10].trim()).toString()+".my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,trtype,ref_row,LAGE,cldocno,lbrrate,id,costtype,costcode,"
								+ "dTYPE,brhId,intrcmpid,tr_no,STATUS)VALUES('"+icjournalvouchersDate+"','"+txtrefno+"','"+docno+"',"
								+ "'"+(icjournalvoucher[0].trim().equalsIgnoreCase("undefined") || icjournalvoucher[0].trim().equalsIgnoreCase("NaN") || icjournalvoucher[0].trim().isEmpty()?0:icjournalvoucher[0].trim())+"',"
								+ "'"+(icjournalvoucher[1].trim().equalsIgnoreCase("undefined") || icjournalvoucher[1].trim().equalsIgnoreCase("NaN") || icjournalvoucher[1].trim().isEmpty()?0:icjournalvoucher[1].trim())+"',"
								+ "'"+(icjournalvoucher[2].trim().equalsIgnoreCase("undefined") || icjournalvoucher[2].trim().equalsIgnoreCase("NaN") || icjournalvoucher[2].trim().isEmpty()?0:icjournalvoucher[2].trim())+"',"
							    + "'"+(icjournalvoucher[3].trim().equalsIgnoreCase("undefined") || icjournalvoucher[3].trim().equalsIgnoreCase("NaN") || icjournalvoucher[2].trim().equals(0) || icjournalvoucher[3].trim().isEmpty()?1:icjournalvoucher[3].trim()).toString()+"',"
							    + "'"+(icjournalvoucher[4].trim().equalsIgnoreCase("undefined") || icjournalvoucher[4].trim().equalsIgnoreCase("NaN") || icjournalvoucher[4].trim().isEmpty()?0:icjournalvoucher[4].trim())+"',"
							    + "'"+(icjournalvoucher[5].trim().equalsIgnoreCase("undefined") || icjournalvoucher[5].trim().equalsIgnoreCase("NaN") || icjournalvoucher[5].trim().isEmpty()?0:icjournalvoucher[5].trim())+"',0,"
							    + "4,"+(i+1)+",'"+ilapply+"','"+icldocno+"',"
							    + "'"+(icjournalvoucher[3].trim().equalsIgnoreCase("undefined") || icjournalvoucher[3].trim().equalsIgnoreCase("NaN") || icjournalvoucher[3].trim().isEmpty()?0:icjournalvoucher[3].trim())+"',"
							    + "'"+(icjournalvoucher[7].trim().equalsIgnoreCase("undefined") || icjournalvoucher[7].trim().equalsIgnoreCase("NaN") || icjournalvoucher[7].trim().isEmpty()?0:icjournalvoucher[7].trim())+"',"
							    + "'"+(icjournalvoucher[8].trim().equalsIgnoreCase("undefined") || icjournalvoucher[8].trim().equalsIgnoreCase("NaN") || icjournalvoucher[8].trim().equalsIgnoreCase("") || icjournalvoucher[8].trim().isEmpty()?0:icjournalvoucher[8].trim())+"',"
							    + "'"+(icjournalvoucher[9].trim().equalsIgnoreCase("undefined") || icjournalvoucher[9].trim().equalsIgnoreCase("NaN") || icjournalvoucher[9].trim().equalsIgnoreCase("") || icjournalvoucher[9].trim().isEmpty()?0:icjournalvoucher[9].trim())+"',"
							    + "'"+formdetailcode+"','"+(icjournalvoucher[11].trim().equalsIgnoreCase("undefined") || icjournalvoucher[11].trim().equalsIgnoreCase("NaN") || icjournalvoucher[11].trim().equalsIgnoreCase("") || icjournalvoucher[11].trim().equalsIgnoreCase("0") || icjournalvoucher[11].trim().isEmpty()?"0":icjournalvoucher[11].trim()).toString()+"',"
							    + "'"+(icjournalvoucher[12].trim().equalsIgnoreCase("undefined") || icjournalvoucher[12].trim().equalsIgnoreCase("NaN") || icjournalvoucher[12].trim().equalsIgnoreCase("") || icjournalvoucher[12].trim().equalsIgnoreCase("0") || icjournalvoucher[12].trim().isEmpty()?"0":icjournalvoucher[12].trim()).toString()+"','"+itranNo+"',3)";
					 int data7 = stmtICJV1.executeUpdate(sql10);
					 if(data7<=0){
						   stmtICJV1.close();
						   conn.close();
						   return 0;
					 }
					 
					 String sql11="insert into "+(icjournalvoucher[10].trim().equalsIgnoreCase("undefined") || icjournalvoucher[10].trim().equalsIgnoreCase("NaN") || icjournalvoucher[10].trim().equalsIgnoreCase("") || icjournalvoucher[10].trim().equalsIgnoreCase("0") || icjournalvoucher[10].trim().isEmpty()?" ":icjournalvoucher[10].trim()).toString()+".my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,trtype,ref_row,LAGE,cldocno,lbrrate,id,costtype,costcode,"
								+ "dTYPE,brhId,intrcmpid,tr_no,STATUS)VALUES('"+icjournalvouchersDate+"','"+txtrefno+"','"+docno+"','"+accountDocNo+"',"
								+ "'"+(icjournalvoucher[1].trim().equalsIgnoreCase("undefined") || icjournalvoucher[1].trim().equalsIgnoreCase("NaN") || icjournalvoucher[1].trim().isEmpty()?0:icjournalvoucher[1].trim())+"',"
								+ "'"+(icjournalvoucher[2].trim().equalsIgnoreCase("undefined") || icjournalvoucher[2].trim().equalsIgnoreCase("NaN") || icjournalvoucher[2].trim().isEmpty()?0:icjournalvoucher[2].trim())+"',"
							    + "'"+(icjournalvoucher[3].trim().equalsIgnoreCase("undefined") || icjournalvoucher[3].trim().equalsIgnoreCase("NaN") || icjournalvoucher[2].trim().equals(0) || icjournalvoucher[3].trim().isEmpty()?1:icjournalvoucher[3].trim()).toString()+"',"
							    + "'"+Double.parseDouble(icjournalvoucher[4].trim().equalsIgnoreCase("undefined") || icjournalvoucher[4].trim().equalsIgnoreCase("NaN") || icjournalvoucher[4].trim().isEmpty()?"0":icjournalvoucher[4].trim())*-1+"',"
							    + "'"+Double.parseDouble(icjournalvoucher[5].trim().equalsIgnoreCase("undefined") || icjournalvoucher[5].trim().equalsIgnoreCase("NaN") || icjournalvoucher[5].trim().isEmpty()?"0":icjournalvoucher[5].trim())*-1+"',0,"
							    + "4,"+(i+2)+",0,0,"
							    + "'"+(icjournalvoucher[3].trim().equalsIgnoreCase("undefined") || icjournalvoucher[3].trim().equalsIgnoreCase("NaN") || icjournalvoucher[3].trim().isEmpty()?0:icjournalvoucher[3].trim())+"',"
							    + ""+Double.parseDouble(icjournalvoucher[7].trim().equalsIgnoreCase("undefined") || icjournalvoucher[7].trim().equalsIgnoreCase("NaN") || icjournalvoucher[7].trim().isEmpty()?"0":icjournalvoucher[7].trim())*-1+","
							    + "'"+(icjournalvoucher[8].trim().equalsIgnoreCase("undefined") || icjournalvoucher[8].trim().equalsIgnoreCase("NaN") || icjournalvoucher[8].trim().equalsIgnoreCase("") || icjournalvoucher[8].trim().isEmpty()?0:icjournalvoucher[8].trim())+"',"
							    + "'"+(icjournalvoucher[9].trim().equalsIgnoreCase("undefined") || icjournalvoucher[9].trim().equalsIgnoreCase("NaN") || icjournalvoucher[9].trim().equalsIgnoreCase("") || icjournalvoucher[9].trim().isEmpty()?0:icjournalvoucher[9].trim())+"',"
							    + "'"+formdetailcode+"','"+(icjournalvoucher[11].trim().equalsIgnoreCase("undefined") || icjournalvoucher[11].trim().equalsIgnoreCase("NaN") || icjournalvoucher[11].trim().equalsIgnoreCase("") || icjournalvoucher[11].trim().equalsIgnoreCase("0") || icjournalvoucher[11].trim().isEmpty()?"0":icjournalvoucher[11].trim()).toString()+"',"
							    + "'"+intrCmpid+"','"+itranNo+"',3)";
					 int data8 = stmtICJV1.executeUpdate(sql11);
					 if(data8<=0){
						   stmtICJV1.close();
						   conn.close();
						   return 0;
					 }
					 
				} else {
					
					if(checkloop==0){
						
						int checkstranNo=0;
						 
						 String sql12="select ic.tr_no from intercompany.my_intrcmptrno ic left join intercompany.my_intrcomp cp on ic.cmpid=cp.doc_no where "
								 + "cp.dbname='"+(icjournalvoucher[10].trim().equalsIgnoreCase("undefined") || icjournalvoucher[10].trim().equalsIgnoreCase("NaN") || icjournalvoucher[10].trim().equalsIgnoreCase("") || icjournalvoucher[10].trim().equalsIgnoreCase("0") || icjournalvoucher[10].trim().isEmpty()?" ":icjournalvoucher[10].trim()).toString()+"' "
								 + "and cp.cmpid=(select cmpid from intercompany.my_intrcomp where doc_no='"+(icjournalvoucher[12].trim().equalsIgnoreCase("undefined") || icjournalvoucher[12].trim().equalsIgnoreCase("NaN") || icjournalvoucher[12].trim().equalsIgnoreCase("") || icjournalvoucher[12].trim().equalsIgnoreCase("0") || icjournalvoucher[12].trim().isEmpty()?"1":icjournalvoucher[12].trim()).toString()+"') "
								 + "and ic.dtype='ICJV' and ic.doc_no="+docno+"";
						 ResultSet resultSet12 = stmtICJV1.executeQuery(sql12);
						    
						 while (resultSet12.next()) {
							 checkstranNo = resultSet12.getInt("tr_no");
						 }
						 
						 if(checkstranNo==0) {
							 
							 String sql13="insert into intercompany.my_intrcmptrno(doc_no, dtype, cmpid, tr_no) values('"+docno+"', 'ICJV', '"+(icjournalvoucher[12].trim().equalsIgnoreCase("undefined") || icjournalvoucher[12].trim().equalsIgnoreCase("NaN") || icjournalvoucher[12].trim().equalsIgnoreCase("") || icjournalvoucher[12].trim().equalsIgnoreCase("0") || icjournalvoucher[12].trim().isEmpty()?"1":icjournalvoucher[12].trim()).toString()+"', "+trno+")";
							 int data = stmtICJV.executeUpdate(sql13);
							 if(data<=0){
								 stmtICJV.close();
								 conn.close();
								 return 0;
							 } 
						 
						 }
						 
					 }
					
					String sql4="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,trtype,ref_row,LAGE,cldocno,lbrrate,id,costtype,costcode,"
							+ "dTYPE,brhId,intrcmpid,tr_no,STATUS)VALUES('"+icjournalvouchersDate+"','"+txtrefno+"','"+docno+"',"
							+ "'"+(icjournalvoucher[0].trim().equalsIgnoreCase("undefined") || icjournalvoucher[0].trim().equalsIgnoreCase("NaN") || icjournalvoucher[0].trim().isEmpty()?0:icjournalvoucher[0].trim())+"',"
							+ "'"+(icjournalvoucher[1].trim().equalsIgnoreCase("undefined") || icjournalvoucher[1].trim().equalsIgnoreCase("NaN") || icjournalvoucher[1].trim().isEmpty()?0:icjournalvoucher[1].trim())+"',"
							+ "'"+(icjournalvoucher[2].trim().equalsIgnoreCase("undefined") || icjournalvoucher[2].trim().equalsIgnoreCase("NaN") || icjournalvoucher[2].trim().isEmpty()?0:icjournalvoucher[2].trim())+"',"
						    + "'"+(icjournalvoucher[3].trim().equalsIgnoreCase("undefined") || icjournalvoucher[3].trim().equalsIgnoreCase("NaN") || icjournalvoucher[2].trim().equals(0) || icjournalvoucher[3].trim().isEmpty()?1:icjournalvoucher[3].trim()).toString()+"',"
						    + "'"+(icjournalvoucher[4].trim().equalsIgnoreCase("undefined") || icjournalvoucher[4].trim().equalsIgnoreCase("NaN") || icjournalvoucher[4].trim().isEmpty()?0:icjournalvoucher[4].trim())+"',"
						    + "'"+(icjournalvoucher[5].trim().equalsIgnoreCase("undefined") || icjournalvoucher[5].trim().equalsIgnoreCase("NaN") || icjournalvoucher[5].trim().isEmpty()?0:icjournalvoucher[5].trim())+"',0,"
						    + "4,"+(i+1)+",'"+ilapply+"','"+icldocno+"',"
						    + "'"+(icjournalvoucher[3].trim().equalsIgnoreCase("undefined") || icjournalvoucher[3].trim().equalsIgnoreCase("NaN") || icjournalvoucher[3].trim().isEmpty()?0:icjournalvoucher[3].trim())+"',"
						    + "'"+(icjournalvoucher[7].trim().equalsIgnoreCase("undefined") || icjournalvoucher[7].trim().equalsIgnoreCase("NaN") || icjournalvoucher[7].trim().isEmpty()?0:icjournalvoucher[7].trim())+"',"
						    + "'"+(icjournalvoucher[8].trim().equalsIgnoreCase("undefined") || icjournalvoucher[8].trim().equalsIgnoreCase("NaN") || icjournalvoucher[8].trim().equalsIgnoreCase("") || icjournalvoucher[8].trim().isEmpty()?0:icjournalvoucher[8].trim())+"',"
						    + "'"+(icjournalvoucher[9].trim().equalsIgnoreCase("undefined") || icjournalvoucher[9].trim().equalsIgnoreCase("NaN") || icjournalvoucher[9].trim().equalsIgnoreCase("") || icjournalvoucher[9].trim().isEmpty()?0:icjournalvoucher[9].trim())+"',"
						    + "'"+formdetailcode+"',"
						    + "'"+(icjournalvoucher[11].trim().equalsIgnoreCase("undefined") || icjournalvoucher[11].trim().equalsIgnoreCase("NaN") || icjournalvoucher[11].trim().equalsIgnoreCase("") || icjournalvoucher[11].trim().isEmpty()?0:icjournalvoucher[11].trim())+"',"
						    + "'"+(icjournalvoucher[12].trim().equalsIgnoreCase("undefined") || icjournalvoucher[12].trim().equalsIgnoreCase("NaN") || icjournalvoucher[12].trim().equalsIgnoreCase("") || icjournalvoucher[12].trim().isEmpty()?0:icjournalvoucher[12].trim())+"',"
						    + "'"+trno+"',3)";		
					int data1 = stmtICJV.executeUpdate(sql4);
					if(data1<=0){
						stmtICJV.close();
						conn.close();
						return 0;
					}
				}
				
				 String sql12="SELECT TRANID FROM my_jvtran where TR_NO="+trno+" and acno="+(icjournalvoucher[0].trim().equalsIgnoreCase("undefined") || icjournalvoucher[0].trim().equalsIgnoreCase("NaN") || icjournalvoucher[0].trim().isEmpty()?0:icjournalvoucher[0].trim());
				 ResultSet resultSet12 = stmtICJV.executeQuery(sql12);
				    
				 while (resultSet12.next()) {
					 trid = resultSet12.getInt("TRANID");
				 }
				
				 if(!icjournalvoucher[8].equalsIgnoreCase("undefined") && !icjournalvoucher[8].trim().equalsIgnoreCase("") && !icjournalvoucher[8].trim().equalsIgnoreCase("0")){
				 String sql13="insert into my_costtran(acno,costtype,amount,sr_no,jobid,tranid,tr_no) values("+(icjournalvoucher[0].trim().equalsIgnoreCase("undefined") || icjournalvoucher[0].trim().equalsIgnoreCase("NaN") || icjournalvoucher[0].trim().isEmpty()?0:icjournalvoucher[0].trim())+","
				 		+ ""+(icjournalvoucher[8].trim().equalsIgnoreCase("undefined") || icjournalvoucher[8].trim().equalsIgnoreCase("NaN") || icjournalvoucher[8].trim().equalsIgnoreCase("") || icjournalvoucher[8].trim().isEmpty()?0:icjournalvoucher[8].trim())+","
				 	    + ""+(icjournalvoucher[5].trim().equalsIgnoreCase("undefined") || icjournalvoucher[5].trim().equalsIgnoreCase("NaN") || icjournalvoucher[5].trim().isEmpty()?0:icjournalvoucher[5].trim())+","+(i+1)+","
				 	    + ""+(icjournalvoucher[9].trim().equalsIgnoreCase("undefined") || icjournalvoucher[9].trim().equalsIgnoreCase("NaN") || icjournalvoucher[9].trim().isEmpty()?0:icjournalvoucher[9].trim())+","+trid+","+trno+")";
				 int data9 = stmtICJV.executeUpdate(sql13);
				 if(data9<=0){
					    stmtICJV.close();
						conn.close();
						return 0;
					  }
				 	}
				 }
			}
				String sql14="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
				ResultSet resultSet14 = stmtICJV.executeQuery(sql14);
			    
				 while (resultSet14.next()) {
					 total=resultSet14.getInt("jvtotal");
				 }
				 
				 if(total == 0){
					conn.commit();
					stmtICJV.close();
					conn.close();
					return docno;
				 }else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
					    stmtICJV.close();
					    return 0;
				    }
			}
			
			stmtICJV.close();
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
	
	public boolean edit(int txticjournalvouchersdocno, String formdetailcode, Date icjournalvouchersDate,String txtrefno, String txtdescription, int txttrno, double txtdrtotal,
			double txtcrtotal, ArrayList<String> icjournalvouchersarray,HttpSession session) throws SQLException {
		
		 Connection conn = null;
		System.out.println("===== "+icjournalvouchersarray);
		 try{
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtICJV = conn.createStatement();
				Statement stmtICJV1 = conn.createStatement();
				
				int trno = txttrno,total = 0,applydelete=0,icjvno=txticjournalvouchersdocno;
			    
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String company=session.getAttribute("COMPANYID").toString().trim();
				
				/*Updating my_jvma*/
                String sql=("UPDATE my_jvma set date='"+icjournalvouchersDate+"',refNo='"+txtrefno+"',description='"+txtdescription+"',drtot='"+txtdrtotal+"',crtot='"+txtcrtotal+"',YearId=0,dtype='"+formdetailcode+"',cmpid='"+company+"',xentbr='"+branch+"',brhId='"+branch+"' where TR_NO="+trno+" and doc_no="+txticjournalvouchersdocno);
                
                System.out.println("jvma update==="+sql);
                int data = stmtICJV.executeUpdate(sql);
				if(data<=0){
					stmtICJV.close();
					conn.close();
					return false;
				}
				/*Updating my_jvma Ends*/
				
				/*Inserting into datalog*/
				String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txticjournalvouchersdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
				System.out.println("datalog insert===="+sqls);
				
				int datas = stmtICJV.executeUpdate(sqls);
				/*Inserting into datalog Ends*/
						 
				    int docno=txticjournalvouchersdocno;
					icJournalVouchersBean.setTxticjournalvouchersdocno(docno);
					if (docno > 0) {
						
						ClsApplyDelete applyDelete = new ClsApplyDelete();
						applydelete=applyDelete.getFinanceApplyDelete(conn, trno);
					    if(applydelete<0){
					    	System.out.println("*** ERROR IN APPLY DELETE ***");
					        stmtICJV.close();
					        conn.close();
					        return false;
				        }
						
					    
					    String sql3="select ic.tr_no,cp.dbname from intercompany.my_intrcmptrno ic left join intercompany.my_intrcomp cp on ic.cmpid=cp.doc_no where ic.dtype='ICJV' and ic.doc_no="+txticjournalvouchersdocno+"";
					    
					    System.out.println("database select===="+sql3);
					    
					    ResultSet resultSet3 = stmtICJV.executeQuery(sql3);
					    
						 while (resultSet3.next()) {
							String dbname=resultSet3.getString("dbname");
							int transno=resultSet3.getInt("tr_no");
							
							//System.out.println("transno==="+transno);
							
							//System.out.println("dbname==="+dbname);
							
							/*String sqlupdte="update intercompany.my_intrcmptrno set status=7 where tr_no="+transno+"";
							
							System.out.println("intrcmp update===="+sqlupdte);
							
							int data3= stmtICJV1.executeUpdate(sqlupdte);*/
							
						    String sql4=("DELETE FROM "+dbname+".my_jvtran WHERE TR_NO="+transno+"");
						    
						    System.out.println("jvtran delete===="+sql4);
						    
						    int data4 = stmtICJV1.executeUpdate(sql4);
						    
						    String sql5=("DELETE FROM "+dbname+".my_costtran WHERE TR_NO="+transno+"");
						    
						    System.out.println("costtran delete===="+sql5);
						    
						    int data5 = stmtICJV1.executeUpdate(sql5);
						    
						    
						    
						    
						    
						 }
						 
						  
						/*IC Journal Voucher Grid Saving*/
						 for(int i=0;i< icjournalvouchersarray.size();i++){
							String[] icjournalvoucher=icjournalvouchersarray.get(i).split("::");
							
							 if(!icjournalvoucher[0].equalsIgnoreCase("undefined") && !icjournalvoucher[0].equalsIgnoreCase("NaN")){
							 int intrCmpid=0,accountDocNo=0,icldocno=0,ilapply=0,trid=0,checkloop=0;
							 
							 String sql6="SELECT doc_no FROM intercompany.my_intrcomp WHERE cmpid='"+company+"' and brhid='"+branch+"'";
							 
							 System.out.println("company select==="+sql6);
							 
							 ResultSet resultSet6 = stmtICJV.executeQuery(sql6);
							 while (resultSet6.next()) {
								 intrCmpid = resultSet6.getInt("doc_no");
							 }
							 
							 String sql7="Select h.doc_no as accountDocNo from my_head h INNER JOIN intercompany.my_intrcmp c ON (c.doc_no=h.doc_no) left JOIN intercompany.my_intrcomp co ON (co.doc_no= c.cmp2) "  
										+ "left JOIN intercompany.my_intrcomp co1 ON (co1.doc_no= c.cmp1) where h.doc_no=c.doc_no and ((c.cmp1="+intrCmpid+" and  "
										+ "c.cmp2="+(icjournalvoucher[12].trim().equalsIgnoreCase("undefined") || icjournalvoucher[12].trim().equalsIgnoreCase("NaN") || icjournalvoucher[12].trim().equalsIgnoreCase("") || icjournalvoucher[12].trim().equalsIgnoreCase("0") || icjournalvoucher[12].trim().isEmpty()?"1":icjournalvoucher[12].trim()).toString()+") or "
										+ "(c.cmp1="+(icjournalvoucher[12].trim().equalsIgnoreCase("undefined") || icjournalvoucher[12].trim().equalsIgnoreCase("NaN") || icjournalvoucher[12].trim().equalsIgnoreCase("") || icjournalvoucher[12].trim().equalsIgnoreCase("0") || icjournalvoucher[12].trim().isEmpty()?"1":icjournalvoucher[12].trim()).toString()+" and  "
										+ "c.cmp2="+intrCmpid+"))";
							 
							 System.out.println("account from my_head===="+sql7);
							 
							 ResultSet resultSet7 = stmtICJV.executeQuery(sql7);
								    
							 while (resultSet7.next()) {
									accountDocNo = resultSet7.getInt("accountDocNo");
							 }
							 
							 String sql8=("select cldocno,lapply from my_head where doc_no="+(icjournalvoucher[0].equalsIgnoreCase("undefined") || icjournalvoucher[0].isEmpty()?0:icjournalvoucher[0]));
							 
							 System.out.println("cldocno from my_head==="+sql8);
							 
							 ResultSet resultSet8 = stmtICJV.executeQuery(sql8);
							 
							 while (resultSet8.next()) {
								 icldocno=resultSet8.getInt("cldocno");
								 ilapply=resultSet8.getInt("lapply");
							 }
							 
							if(accountDocNo>0){
								
								String sql10="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,trtype,ref_row,LAGE,cldocno,lbrrate,id,costtype,costcode,"
										+ "dTYPE,brhId,intrcmpid,tr_no,STATUS)VALUES('"+icjournalvouchersDate+"','"+txtrefno+"','"+docno+"','"+accountDocNo+"',"
										+ "'"+(icjournalvoucher[1].trim().equalsIgnoreCase("undefined") || icjournalvoucher[1].trim().equalsIgnoreCase("NaN") || icjournalvoucher[1].trim().isEmpty()?0:icjournalvoucher[1].trim())+"',"
										+ "'"+(icjournalvoucher[2].trim().equalsIgnoreCase("undefined") || icjournalvoucher[2].trim().equalsIgnoreCase("NaN") || icjournalvoucher[2].trim().isEmpty()?0:icjournalvoucher[2].trim())+"',"
									    + "'"+(icjournalvoucher[3].trim().equalsIgnoreCase("undefined") || icjournalvoucher[3].trim().equalsIgnoreCase("NaN") || icjournalvoucher[2].trim().equals(0) || icjournalvoucher[3].trim().isEmpty()?1:icjournalvoucher[3].trim()).toString()+"',"
									    + "'"+(icjournalvoucher[4].trim().equalsIgnoreCase("undefined") || icjournalvoucher[4].trim().equalsIgnoreCase("NaN") || icjournalvoucher[4].trim().isEmpty()?"0":icjournalvoucher[4].trim())+"',"
									    + "'"+(icjournalvoucher[5].trim().equalsIgnoreCase("undefined") || icjournalvoucher[5].trim().equalsIgnoreCase("NaN") || icjournalvoucher[5].trim().isEmpty()?"0":icjournalvoucher[5].trim())+"',0,"
									    + "4,"+(i+2)+",0,0,"
									    + "'"+(icjournalvoucher[3].trim().equalsIgnoreCase("undefined") || icjournalvoucher[3].trim().equalsIgnoreCase("NaN") || icjournalvoucher[3].trim().isEmpty()?0:icjournalvoucher[3].trim())+"',"
									    + "'"+(icjournalvoucher[7].trim().equalsIgnoreCase("undefined") || icjournalvoucher[7].trim().equalsIgnoreCase("NaN") || icjournalvoucher[7].trim().isEmpty()?"0":icjournalvoucher[7].trim())+"',"
									    + "'"+(icjournalvoucher[8].trim().equalsIgnoreCase("undefined") || icjournalvoucher[8].trim().equalsIgnoreCase("NaN") || icjournalvoucher[8].trim().equalsIgnoreCase("") || icjournalvoucher[8].trim().isEmpty()?0:icjournalvoucher[8].trim())+"',"
									    + "'"+(icjournalvoucher[9].trim().equalsIgnoreCase("undefined") || icjournalvoucher[9].trim().equalsIgnoreCase("NaN") || icjournalvoucher[9].trim().equalsIgnoreCase("") || icjournalvoucher[9].trim().isEmpty()?0:icjournalvoucher[9].trim())+"',"
									    + "'"+formdetailcode+"',"
									    + "'"+branch+"',"
									    + "'"+(icjournalvoucher[12].trim().equalsIgnoreCase("undefined") || icjournalvoucher[12].trim().equalsIgnoreCase("NaN") || icjournalvoucher[12].trim().equalsIgnoreCase("") || icjournalvoucher[12].trim().isEmpty()?0:icjournalvoucher[12].trim())+"',"
									    + "'"+trno+"',3)";
								
								System.out.println("jvtran insert==="+sql10);
								
								int data10 = stmtICJV1.executeUpdate(sql10);
								if(data10<=0){
									stmtICJV.close();
									conn.close();
									return false;
								}
								
								int itranNo=0,idocNo=0,icmpId=0;
								 
								 String sql11="select ic.tr_no,ic.doc_no,ic.cmpid from intercompany.my_intrcmptrno ic left join intercompany.my_intrcomp cp on ic.cmpid=cp.doc_no where "
										 + "cp.dbname='"+(icjournalvoucher[10].trim().equalsIgnoreCase("undefined") || icjournalvoucher[10].trim().equalsIgnoreCase("NaN") || icjournalvoucher[10].trim().equalsIgnoreCase("") || icjournalvoucher[10].trim().equalsIgnoreCase("0") || icjournalvoucher[10].trim().isEmpty()?" ":icjournalvoucher[10].trim()).toString()+"' "
										 + "and cp.cmpid=(select cmpid from intercompany.my_intrcomp where doc_no='"+(icjournalvoucher[12].trim().equalsIgnoreCase("undefined") || icjournalvoucher[12].trim().equalsIgnoreCase("NaN") || icjournalvoucher[12].trim().equalsIgnoreCase("") || icjournalvoucher[12].trim().equalsIgnoreCase("0") || icjournalvoucher[12].trim().isEmpty()?"1":icjournalvoucher[12].trim()).toString()+"') "
										 + "and ic.dtype='ICJV' and ic.doc_no="+docno+"";
								 
								 System.out.println("intercompany select==="+sql11);
								 
								 ResultSet resultSet11 = stmtICJV1.executeQuery(sql11);
								    
								 while (resultSet11.next()) {
									itranNo = resultSet11.getInt("tr_no");
									idocNo = resultSet11.getInt("doc_no");
									icmpId = resultSet11.getInt("cmpid");
								 }
								 
								 if(itranNo==0) {
									 
									 String sql12="select coalesce((max(trno)+1),1) as itranNo from "+(icjournalvoucher[10].trim().equalsIgnoreCase("undefined") || icjournalvoucher[10].trim().equalsIgnoreCase("NaN") || icjournalvoucher[10].trim().equalsIgnoreCase("") || icjournalvoucher[10].trim().equalsIgnoreCase("0") || icjournalvoucher[10].trim().isEmpty()?" ":icjournalvoucher[10].trim()).toString()+".my_trno";
									 
									 System.out.println("itranno==="+sql12);
									 
									 ResultSet resultSet12 = stmtICJV1.executeQuery(sql12);
									    
									 while (resultSet12.next()) {
										itranNo = resultSet12.getInt("itranNo");
									 }
									 
									 String sql13="insert into "+(icjournalvoucher[10].trim().equalsIgnoreCase("undefined") || icjournalvoucher[10].trim().equalsIgnoreCase("NaN") || icjournalvoucher[10].trim().equalsIgnoreCase("") || icjournalvoucher[10].trim().equalsIgnoreCase("0") || icjournalvoucher[10].trim().isEmpty()?" ":icjournalvoucher[10].trim()).toString()+".my_trno(edate,trtype,brhId,USERNO,trno) values('"+icjournalvouchersDate+"',4,'"+(icjournalvoucher[12].trim().equalsIgnoreCase("undefined") || icjournalvoucher[12].trim().equalsIgnoreCase("NaN") || icjournalvoucher[12].trim().equalsIgnoreCase("") || icjournalvoucher[12].trim().equalsIgnoreCase("0") || icjournalvoucher[12].trim().isEmpty()?"1":icjournalvoucher[12].trim()).toString()+"','"+userid+"',"+itranNo+")";
									 int data13 = stmtICJV1.executeUpdate(sql13);
									 if(data13<=0){
										   stmtICJV1.close();
										   conn.close();
										   return false;
									 }
									 
									 checkloop=1;
								 
								 }
								 
								 
								 
								 
								 
								 if(idocNo!=docno && icmpId!=Integer.parseInt(icjournalvoucher[12].trim())){
									 String sql14="insert into intercompany.my_intrcmptrno(doc_no, dtype, cmpid, tr_no) values('"+docno+"', 'ICJV', '"+(icjournalvoucher[12].trim().equalsIgnoreCase("undefined") || icjournalvoucher[12].trim().equalsIgnoreCase("NaN") || icjournalvoucher[12].trim().equalsIgnoreCase("") || icjournalvoucher[12].trim().equalsIgnoreCase("0") || icjournalvoucher[12].trim().isEmpty()?"1":icjournalvoucher[12].trim()).toString()+"', "+itranNo+")";								 
									 
									 System.out.println("intrcompany insert==="+sql14);
									 
									 int data14 = stmtICJV1.executeUpdate(sql14);
									 if(data14<=0){
										   stmtICJV1.close();
										   conn.close();
										   return false;
									 }
								 }
								 
								 String sql15="insert into "+(icjournalvoucher[10].trim().equalsIgnoreCase("undefined") || icjournalvoucher[10].trim().equalsIgnoreCase("NaN") || icjournalvoucher[10].trim().equalsIgnoreCase("") || icjournalvoucher[10].trim().equalsIgnoreCase("0") || icjournalvoucher[10].trim().isEmpty()?" ":icjournalvoucher[10].trim()).toString()+".my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,trtype,ref_row,LAGE,cldocno,lbrrate,id,costtype,costcode,"
											+ "dTYPE,brhId,intrcmpid,tr_no,STATUS)VALUES('"+icjournalvouchersDate+"','"+txtrefno+"','"+docno+"',"
											+ "'"+(icjournalvoucher[0].trim().equalsIgnoreCase("undefined") || icjournalvoucher[0].trim().equalsIgnoreCase("NaN") || icjournalvoucher[0].trim().isEmpty()?0:icjournalvoucher[0].trim())+"',"
											+ "'"+(icjournalvoucher[1].trim().equalsIgnoreCase("undefined") || icjournalvoucher[1].trim().equalsIgnoreCase("NaN") || icjournalvoucher[1].trim().isEmpty()?0:icjournalvoucher[1].trim())+"',"
											+ "'"+(icjournalvoucher[2].trim().equalsIgnoreCase("undefined") || icjournalvoucher[2].trim().equalsIgnoreCase("NaN") || icjournalvoucher[2].trim().isEmpty()?0:icjournalvoucher[2].trim())+"',"
										    + "'"+(icjournalvoucher[3].trim().equalsIgnoreCase("undefined") || icjournalvoucher[3].trim().equalsIgnoreCase("NaN") || icjournalvoucher[2].trim().equals(0) || icjournalvoucher[3].trim().isEmpty()?1:icjournalvoucher[3].trim()).toString()+"',"
										    + "'"+(icjournalvoucher[4].trim().equalsIgnoreCase("undefined") || icjournalvoucher[4].trim().equalsIgnoreCase("NaN") || icjournalvoucher[4].trim().isEmpty()?0:icjournalvoucher[4].trim())+"',"
										    + "'"+(icjournalvoucher[5].trim().equalsIgnoreCase("undefined") || icjournalvoucher[5].trim().equalsIgnoreCase("NaN") || icjournalvoucher[5].trim().isEmpty()?0:icjournalvoucher[5].trim())+"',0,"
										    + "4,"+(i+1)+",'"+ilapply+"','"+icldocno+"',"
										    + "'"+(icjournalvoucher[3].trim().equalsIgnoreCase("undefined") || icjournalvoucher[3].trim().equalsIgnoreCase("NaN") || icjournalvoucher[3].trim().isEmpty()?0:icjournalvoucher[3].trim())+"',"
										    + "'"+(icjournalvoucher[7].trim().equalsIgnoreCase("undefined") || icjournalvoucher[7].trim().equalsIgnoreCase("NaN") || icjournalvoucher[7].trim().isEmpty()?0:icjournalvoucher[7].trim())+"',"
										    + "'"+(icjournalvoucher[8].trim().equalsIgnoreCase("undefined") || icjournalvoucher[8].trim().equalsIgnoreCase("NaN") || icjournalvoucher[8].trim().equalsIgnoreCase("") || icjournalvoucher[8].trim().isEmpty()?0:icjournalvoucher[8].trim())+"',"
										    + "'"+(icjournalvoucher[9].trim().equalsIgnoreCase("undefined") || icjournalvoucher[9].trim().equalsIgnoreCase("NaN") || icjournalvoucher[9].trim().equalsIgnoreCase("") || icjournalvoucher[9].trim().isEmpty()?0:icjournalvoucher[9].trim())+"',"
										    + "'"+formdetailcode+"','"+(icjournalvoucher[11].trim().equalsIgnoreCase("undefined") || icjournalvoucher[11].trim().equalsIgnoreCase("NaN") || icjournalvoucher[11].trim().equalsIgnoreCase("") || icjournalvoucher[11].trim().equalsIgnoreCase("0") || icjournalvoucher[11].trim().isEmpty()?" ":icjournalvoucher[11].trim()).toString()+"',"
										    + "'"+(icjournalvoucher[12].trim().equalsIgnoreCase("undefined") || icjournalvoucher[12].trim().equalsIgnoreCase("NaN") || icjournalvoucher[12].trim().equalsIgnoreCase("") || icjournalvoucher[12].trim().isEmpty()?0:icjournalvoucher[12].trim())+"',"
										    + "'"+itranNo+"',3)";
								 
								 System.out.println("insert 2==="+sql15);
								 
								 int data15 = stmtICJV1.executeUpdate(sql15);
								 if(data15<=0){
									   stmtICJV1.close();
									   conn.close();
									   return false;
								 }
								 
								 String sql16="insert into "+(icjournalvoucher[10].trim().equalsIgnoreCase("undefined") || icjournalvoucher[10].trim().equalsIgnoreCase("NaN") || icjournalvoucher[10].trim().equalsIgnoreCase("") || icjournalvoucher[10].trim().equalsIgnoreCase("0") || icjournalvoucher[10].trim().isEmpty()?" ":icjournalvoucher[10].trim()).toString()+".my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,trtype,ref_row,LAGE,cldocno,lbrrate,id,costtype,costcode,"
											+ "dTYPE,brhId,intrcmpid,tr_no,STATUS)VALUES('"+icjournalvouchersDate+"','"+txtrefno+"','"+docno+"','"+accountDocNo+"',"
											+ "'"+(icjournalvoucher[1].trim().equalsIgnoreCase("undefined") || icjournalvoucher[1].trim().equalsIgnoreCase("NaN") || icjournalvoucher[1].trim().isEmpty()?0:icjournalvoucher[1].trim())+"',"
											+ "'"+(icjournalvoucher[2].trim().equalsIgnoreCase("undefined") || icjournalvoucher[2].trim().equalsIgnoreCase("NaN") || icjournalvoucher[2].trim().isEmpty()?0:icjournalvoucher[2].trim())+"',"
										    + "'"+(icjournalvoucher[3].trim().equalsIgnoreCase("undefined") || icjournalvoucher[3].trim().equalsIgnoreCase("NaN") || icjournalvoucher[2].trim().equals(0) || icjournalvoucher[3].trim().isEmpty()?1:icjournalvoucher[3].trim()).toString()+"',"
										    + "'"+Double.parseDouble(icjournalvoucher[4].trim().equalsIgnoreCase("undefined") || icjournalvoucher[4].trim().equalsIgnoreCase("NaN") || icjournalvoucher[4].trim().isEmpty()?"0":icjournalvoucher[4].trim())*-1+"',"
										    + "'"+Double.parseDouble(icjournalvoucher[5].trim().equalsIgnoreCase("undefined") || icjournalvoucher[5].trim().equalsIgnoreCase("NaN") || icjournalvoucher[5].trim().isEmpty()?"0":icjournalvoucher[5].trim())*-1+"',0,"
										    + "4,"+(i+2)+",0,0,"
										    + "'"+(icjournalvoucher[3].trim().equalsIgnoreCase("undefined") || icjournalvoucher[3].trim().equalsIgnoreCase("NaN") || icjournalvoucher[3].trim().isEmpty()?0:icjournalvoucher[3].trim())+"',"
										    + ""+Double.parseDouble(icjournalvoucher[7].trim().equalsIgnoreCase("undefined") || icjournalvoucher[7].trim().equalsIgnoreCase("NaN") || icjournalvoucher[7].trim().isEmpty()?"0":icjournalvoucher[7].trim())*-1+","
										    + "'"+(icjournalvoucher[8].trim().equalsIgnoreCase("undefined") || icjournalvoucher[8].trim().equalsIgnoreCase("NaN") || icjournalvoucher[8].trim().equalsIgnoreCase("") || icjournalvoucher[8].trim().isEmpty()?0:icjournalvoucher[8].trim())+"',"
										    + "'"+(icjournalvoucher[9].trim().equalsIgnoreCase("undefined") || icjournalvoucher[9].trim().equalsIgnoreCase("NaN") || icjournalvoucher[9].trim().equalsIgnoreCase("") || icjournalvoucher[9].trim().isEmpty()?0:icjournalvoucher[9].trim())+"',"
										    + "'"+formdetailcode+"','"+(icjournalvoucher[11].trim().equalsIgnoreCase("undefined") || icjournalvoucher[11].trim().equalsIgnoreCase("NaN") || icjournalvoucher[11].trim().equalsIgnoreCase("") || icjournalvoucher[11].trim().equalsIgnoreCase("0") || icjournalvoucher[11].trim().isEmpty()?" ":icjournalvoucher[11].trim()).toString()+"',"
										    + "'"+intrCmpid+"','"+itranNo+"',3)";
								 
								 System.out.println("insert 3==="+sql16);
								 
								 int data16 = stmtICJV1.executeUpdate(sql16);
								 if(data16<=0){
									   stmtICJV1.close();
									   conn.close();
									   return false;
								 }
								 
							} else {
								
								if(checkloop==0){
									
									int checkstranNo=0;
									 
									 String sql17="select ic.tr_no from intercompany.my_intrcmptrno ic left join intercompany.my_intrcomp cp on ic.cmpid=cp.doc_no where "
											 + "cp.dbname='"+(icjournalvoucher[10].trim().equalsIgnoreCase("undefined") || icjournalvoucher[10].trim().equalsIgnoreCase("NaN") || icjournalvoucher[10].trim().equalsIgnoreCase("") || icjournalvoucher[10].trim().equalsIgnoreCase("0") || icjournalvoucher[10].trim().isEmpty()?" ":icjournalvoucher[10].trim()).toString()+"' "
											 + "and cp.cmpid=(select cmpid from intercompany.my_intrcomp where doc_no='"+(icjournalvoucher[12].trim().equalsIgnoreCase("undefined") || icjournalvoucher[12].trim().equalsIgnoreCase("NaN") || icjournalvoucher[12].trim().equalsIgnoreCase("") || icjournalvoucher[12].trim().equalsIgnoreCase("0") || icjournalvoucher[12].trim().isEmpty()?"1":icjournalvoucher[12].trim()).toString()+"') "
											 + "and ic.dtype='ICJV' and ic.doc_no="+docno+"";
									
									 System.out.println("intrcmp select===="+sql17);
									 
									 ResultSet resultSet17 = stmtICJV1.executeQuery(sql17);
									    
									 while (resultSet17.next()) {
										 checkstranNo = resultSet17.getInt("tr_no");
									 }
									 
									 if(checkstranNo==0) {
										 
										 String sql18="insert into intercompany.my_intrcmptrno(doc_no, dtype, cmpid, tr_no) values('"+docno+"', 'ICJV', '"+(icjournalvoucher[12].trim().equalsIgnoreCase("undefined") || icjournalvoucher[12].trim().equalsIgnoreCase("NaN") || icjournalvoucher[12].trim().equalsIgnoreCase("") || icjournalvoucher[12].trim().equalsIgnoreCase("0") || icjournalvoucher[12].trim().isEmpty()?"1":icjournalvoucher[12].trim()).toString()+"', "+trno+")";
										 
										 System.out.println("intrcmpinsert===="+sql18);
										 
										 int data18 = stmtICJV.executeUpdate(sql18);
										 if(data18<=0){
											 stmtICJV.close();
											 conn.close();
											 return false;
										 } 
									 
									 }
									 
								 }
								
								String sql19="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,trtype,ref_row,LAGE,cldocno,lbrrate,id,costtype,costcode,"
										+ "dTYPE,brhId,intrcmpid,tr_no,STATUS)VALUES('"+icjournalvouchersDate+"','"+txtrefno+"','"+docno+"',"
										+ "'"+(icjournalvoucher[0].trim().equalsIgnoreCase("undefined") || icjournalvoucher[0].trim().equalsIgnoreCase("NaN") || icjournalvoucher[0].trim().isEmpty()?0:icjournalvoucher[0].trim())+"',"
										+ "'"+(icjournalvoucher[1].trim().equalsIgnoreCase("undefined") || icjournalvoucher[1].trim().equalsIgnoreCase("NaN") || icjournalvoucher[1].trim().isEmpty()?0:icjournalvoucher[1].trim())+"',"
										+ "'"+(icjournalvoucher[2].trim().equalsIgnoreCase("undefined") || icjournalvoucher[2].trim().equalsIgnoreCase("NaN") || icjournalvoucher[2].trim().isEmpty()?0:icjournalvoucher[2].trim())+"',"
									    + "'"+(icjournalvoucher[3].trim().equalsIgnoreCase("undefined") || icjournalvoucher[3].trim().equalsIgnoreCase("NaN") || icjournalvoucher[2].trim().equals(0) || icjournalvoucher[3].trim().isEmpty()?1:icjournalvoucher[3].trim()).toString()+"',"
									    + "'"+(icjournalvoucher[4].trim().equalsIgnoreCase("undefined") || icjournalvoucher[4].trim().equalsIgnoreCase("NaN") || icjournalvoucher[4].trim().isEmpty()?0:icjournalvoucher[4].trim())+"',"
									    + "'"+(icjournalvoucher[5].trim().equalsIgnoreCase("undefined") || icjournalvoucher[5].trim().equalsIgnoreCase("NaN") || icjournalvoucher[5].trim().isEmpty()?0:icjournalvoucher[5].trim())+"',0,"
									    + "4,"+(i+1)+",'"+ilapply+"','"+icldocno+"',"
									    + "'"+(icjournalvoucher[3].trim().equalsIgnoreCase("undefined") || icjournalvoucher[3].trim().equalsIgnoreCase("NaN") || icjournalvoucher[3].trim().isEmpty()?0:icjournalvoucher[3].trim())+"',"
									    + "'"+(icjournalvoucher[7].trim().equalsIgnoreCase("undefined") || icjournalvoucher[7].trim().equalsIgnoreCase("NaN") || icjournalvoucher[7].trim().isEmpty()?0:icjournalvoucher[7].trim())+"',"
									    + "'"+(icjournalvoucher[8].trim().equalsIgnoreCase("undefined") || icjournalvoucher[8].trim().equalsIgnoreCase("NaN") || icjournalvoucher[8].trim().equalsIgnoreCase("") || icjournalvoucher[8].trim().isEmpty()?0:icjournalvoucher[8].trim())+"',"
									    + "'"+(icjournalvoucher[9].trim().equalsIgnoreCase("undefined") || icjournalvoucher[9].trim().equalsIgnoreCase("NaN") || icjournalvoucher[9].trim().equalsIgnoreCase("") || icjournalvoucher[9].trim().isEmpty()?0:icjournalvoucher[9].trim())+"',"
									    + "'"+formdetailcode+"',"
									    + "'"+(icjournalvoucher[11].trim().equalsIgnoreCase("undefined") || icjournalvoucher[11].trim().equalsIgnoreCase("NaN") || icjournalvoucher[11].trim().equalsIgnoreCase("") || icjournalvoucher[11].trim().isEmpty()?0:icjournalvoucher[11].trim())+"',"
									    + "'"+(icjournalvoucher[12].trim().equalsIgnoreCase("undefined") || icjournalvoucher[12].trim().equalsIgnoreCase("NaN") || icjournalvoucher[12].trim().equalsIgnoreCase("") || icjournalvoucher[12].trim().isEmpty()?0:icjournalvoucher[12].trim())+"',"		
									    + "'"+trno+"',3)";
								
								System.out.println("jv insert=="+sql19);
								
								int data19 = stmtICJV.executeUpdate(sql19);
								if(data19<=0){
									stmtICJV.close();
									conn.close();
									return false;
								}
							}
							
							 String sql20="SELECT TRANID FROM my_jvtran where TR_NO="+trno+" and acno="+(icjournalvoucher[0].trim().equalsIgnoreCase("undefined") || icjournalvoucher[0].trim().equalsIgnoreCase("NaN") || icjournalvoucher[0].trim().isEmpty()?0:icjournalvoucher[0].trim());
							 
							 
							 System.out.println("tranid select==="+sql20);
							 
							 ResultSet resultSet20 = stmtICJV.executeQuery(sql20);
							    
							 while (resultSet20.next()) {
								 trid = resultSet20.getInt("TRANID");
							 }
							
							 if(!icjournalvoucher[8].equalsIgnoreCase("undefined") && !icjournalvoucher[8].trim().equalsIgnoreCase("") && !icjournalvoucher[8].trim().equalsIgnoreCase("0")){
							 String sql21="insert into my_costtran(acno,costtype,amount,sr_no,jobid,tranid,tr_no) values("+(icjournalvoucher[0].trim().equalsIgnoreCase("undefined") || icjournalvoucher[0].trim().equalsIgnoreCase("NaN") || icjournalvoucher[0].trim().isEmpty()?0:icjournalvoucher[0].trim())+","
							 		+ ""+(icjournalvoucher[8].trim().equalsIgnoreCase("undefined") || icjournalvoucher[8].trim().equalsIgnoreCase("NaN") || icjournalvoucher[8].trim().equalsIgnoreCase("") || icjournalvoucher[8].trim().isEmpty()?0:icjournalvoucher[8].trim())+","
							 	    + ""+(icjournalvoucher[5].trim().equalsIgnoreCase("undefined") || icjournalvoucher[5].trim().equalsIgnoreCase("NaN") || icjournalvoucher[5].trim().isEmpty()?0:icjournalvoucher[5].trim())+","+(i+1)+","
							 	    + ""+(icjournalvoucher[9].trim().equalsIgnoreCase("undefined") || icjournalvoucher[9].trim().equalsIgnoreCase("NaN") || icjournalvoucher[9].trim().isEmpty()?0:icjournalvoucher[9].trim())+","+trid+","+trno+")";
							 
							 int data21 = stmtICJV.executeUpdate(sql21);
							 if(data21<=0){
								    stmtICJV.close();
									conn.close();
									return false;
								  }
					 		 	}
							 }
						}
						 
					//update IC company table status=7
					
						 
						 String sqlupdte1="update intercompany.my_intrcmptrno set status=7 where doc_no="+icjvno+" and dtype='ICJV'";
						 
						 System.out.println("intercomp update first===="+sqlupdte1);
						 
						 int data26 = stmtICJV.executeUpdate(sqlupdte1);
						 
						 
						String strcomp="(";
						
						for(int i=0;i<icjournalvouchersarray.size();i++){
							
						if(i==0){
							
							strcomp+=icjournalvouchersarray.get(i).split("::")[12];
								
						}
						
						else{
							
							strcomp+=","+icjournalvouchersarray.get(i).split("::")[12];
							
							
						}

						}
						
						strcomp+=")";
		 
					String sqlupdte2="update intercompany.my_intrcmptrno set status=3 where cmpid in "+strcomp+" ";
					
					System.out.println("intercomp update second=="+sqlupdte2);
					
					 int data27 = stmtICJV.executeUpdate(sqlupdte2);
					  
						 
						 String sql22="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno;
						
						System.out.println("jv total=="+sql22);
						
						ResultSet resultSet22 = stmtICJV.executeQuery(sql22);
					    
						 while (resultSet22.next()) {
						 total=resultSet22.getInt("jvtotal");
						 }
						 
						 if(total == 0){
							conn.commit();
							stmtICJV.close();
							conn.close();
							return true;
						 }else{
							System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
							stmtICJV.close();
							return false;
						}
					}
					
					stmtICJV.close();
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

	public boolean editMaster(int txtjournalvouchersdocno,String formdetailcode,Date journalVouchersDate, String txtrefno, String txtdescription,
			int txttrno,double txtdrtotal, double txtcrtotal, HttpSession session) throws SQLException {
		
		Connection conn = null;
		
		try{
		    conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtICJV = conn.createStatement();
			
			int trno = txttrno;
		
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			
			/*Updating my_jvma*/
            String sql=("UPDATE my_jvma set date='"+journalVouchersDate+"',refNo='"+txtrefno+"',description='"+txtdescription+"',drtot='"+txtdrtotal+"',crtot='"+txtcrtotal+"',YearId=0,dtype='"+formdetailcode+"',cmpid='"+company+"',xentbr='"+branch+"',brhId='"+branch+"' where TR_NO="+trno+" and doc_no="+txtjournalvouchersdocno);
			int data = stmtICJV.executeUpdate(sql);
			if(data<=0){
				conn.close();
				return false;
			}
			/*Updating my_jvma Ends*/
			
			/*Inserting into datalog*/
			String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtjournalvouchersdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
			int datas = stmtICJV.executeUpdate(sqls);
			/*Inserting into datalog Ends*/
			
			conn.commit();
			stmtICJV.close();
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

	public boolean delete(int txticjournalvouchersdocno, String formdetailcode, int txttrno, HttpSession session) throws SQLException {
		
		Connection conn = null;
		
		try{
		    conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtICJV = conn.createStatement();
			Statement stmtICJV1 = conn.createStatement();
			Statement stmtICJV2 = conn.createStatement();
		
			int trno = txttrno,applydelete=0;
		    String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			
			ClsApplyDelete applyDelete = new ClsApplyDelete();
			applydelete=applyDelete.getFinanceApplyDelete(conn, trno);
			if(applydelete<0){
				System.out.println("*** ERROR IN APPLY DELETE ***");
			    stmtICJV.close();
			    conn.close();
			    return false;
			}
						
			/*Updating my_jvma*/
            String sql=("update my_jvma set status=7 where tr_no="+trno+" and doc_no="+txticjournalvouchersdocno+"");
			int data = stmtICJV.executeUpdate(sql);
			if(data<=0){
				conn.close();
				return false;
			}
			/*Updating my_jvma Ends*/
			
			/*Inserting into datalog*/
			String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txticjournalvouchersdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','D')");
			int datas = stmtICJV.executeUpdate(sqls);
			/*Inserting into datalog Ends*/
			
			/*IC Journal Voucher Grid Updating*/
			String sql1="select ic.tr_no,cp.dbname from intercompany.my_intrcmptrno ic left join intercompany.my_intrcomp cp on ic.cmpid=cp.doc_no where ic.dtype='ICJV' and ic.doc_no="+txticjournalvouchersdocno+"";
			 ResultSet resultSet1 = stmtICJV.executeQuery(sql1);
			    
			 while (resultSet1.next()) {
				String dbname=resultSet1.getString("dbname");
				int transno=resultSet1.getInt("tr_no");
				
				/*Status change in my_jvtran*/
			    String sql2=("update "+dbname+".my_jvtran set STATUS=7,out_amount=0 where doc_no="+txticjournalvouchersdocno+" and dtype='ICJV'");
				int data2 = stmtICJV1.executeUpdate(sql2);
				/*Status change in my_jvtran Ends*/
				
				/*Status change in my_intrcmptrno*/
				 String sql3=("update intercompany.my_intrcmptrno set STATUS=7 where dtype='ICJV' and doc_no="+txticjournalvouchersdocno+" and TR_NO="+transno+"");
				 int data3 = stmtICJV2.executeUpdate(sql3);
				/*Status change in my_intrcmptrno Ends*/
			    
			 }
		   /*IC Journal Voucher Grid Updating Ends*/
			
			conn.commit();
			stmtICJV.close();
			stmtICJV1.close();
			stmtICJV2.close();
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
	
	public JSONArray journalVoucherGridReloading(HttpSession session,String docNo,String check) throws SQLException {
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
				Statement stmtICJV = conn.createStatement();
				Statement stmtICJV1 = conn.createStatement();
				
				String sql = "SELECT it.cmpid,ic.dbname FROM intercompany.my_intrcmptrno it left join intercompany.my_intrcomp ic on ic.doc_no=it.cmpid WHERE it.dtype='ICJV' and it.doc_no="+docNo+"";				
				ResultSet resultSet = stmtICJV.executeQuery (sql);
				
				ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<ArrayList<String>>();
				while(resultSet.next()){
					String dbname=resultSet.getString("dbname");
					String intrcmpid=resultSet.getString("cmpid");
					
					String sql1="SELECT j.acno docno,j.description,j.curId currencyid,round(j.rate,2) rate,if(j.dramount>0,round(j.dramount*j.id,2),0) debit,if(j.dramount<0,round(j.dramount*j.id,2),0) credit,"
							+ "round(j.ldramount*j.id,2) baseamount,j.ref_row sr_no,j.costtype,j.costcode,c.costgroup,t.atype type,t.account accounts,t.description accountname1,t.gr_type grtype,cr.type currencytype," 
							+ "CONCAT(cm.compname,' / ',cm.branchname) compbranch,cm.doc_no intrcompid,cm.dbname,j.brhid intrbrhid FROM "+dbname+".my_jvtran j left join "+dbname+".my_head t on j.acno=t.doc_no "
							+ "left join intercompany.my_intrcmp ic on j.acno=ic.doc_no left join intercompany.my_intrcomp cm on (j.brhid=cm.brhid and j.intrcmpid=cm.doc_no and cm.dbname='"+dbname+"') left join "+dbname+".my_costunit c on j.costtype=c.costtype "
							+ "left join "+dbname+".my_curr cr on cr.doc_no=j.curId WHERE j.status<>7 and ic.doc_no is null and j.dtype='ICJV' and j.intrcmpid='"+intrcmpid+"' and j.doc_no='"+docNo+"'";
					ResultSet resultSet1 = stmtICJV1.executeQuery(sql1);
					
					while(resultSet1.next()){
						ArrayList<String> temp=new ArrayList<String>();
						
						temp.add(resultSet1.getString("docno"));
						temp.add(resultSet1.getString("compbranch"));
						temp.add(resultSet1.getString("intrcompid"));
						temp.add(resultSet1.getString("type"));
						temp.add(resultSet1.getString("accounts"));
						temp.add(resultSet1.getString("accountname1"));
						temp.add(resultSet1.getString("costtype"));
						temp.add(resultSet1.getString("costgroup"));
						temp.add(resultSet1.getString("costcode"));
						temp.add(resultSet1.getString("debit"));
						temp.add(resultSet1.getString("credit"));
						temp.add(resultSet1.getString("baseamount"));
						temp.add(resultSet1.getString("description"));
						temp.add(resultSet1.getString("currencyid"));
						temp.add(resultSet1.getString("currencytype"));
						temp.add(resultSet1.getString("rate"));
						temp.add(resultSet1.getString("grtype"));
						temp.add(resultSet1.getString("sr_no"));
						temp.add(resultSet1.getString("intrbrhid"));
						temp.add(resultSet1.getString("dbname"));
						
						analysisrowarray.add(temp);
					}
					
		        }

				RESULTDATA=convertRowArrayToJSON(analysisrowarray);
				
				stmtICJV.close();
				stmtICJV1.close();
				conn.close();

		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
		return RESULTDATA;
    }
	
	public JSONArray icJournalVoucherGridSearch(String type,String database,String accountno,String accountname,String currency,String date,String check) throws SQLException {
	        
			JSONArray RESULTDATA=new JSONArray();
	        
			if(!(check.equalsIgnoreCase("1"))) {
	        	return RESULTDATA;
	        }
			
	        Connection conn = null; 
	       
		     try {
			       conn = connDAO.getMyConnection();
			       Statement stmtICJV = conn.createStatement();
		
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
			        
		           sql="select t.doc_no,t.account,t.description,t.gr_type,c.code curr,c.doc_no curid,c.type,round(cb.rate,2) c_rate from "+database+".my_head t left join "+database+".my_curr c "
						+ "on t.curid=c.doc_no left join "+database+".my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,"
						+ "cr.frmDate from "+database+".my_curbook cr where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo "
						+ "on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where t.atype='"+type+"' and t.m_s=0"+sqltest;
			        
			       ResultSet resultSet = stmtICJV.executeQuery(sql);
			       RESULTDATA=commonDAO.convertToJSON(resultSet);
		           
			    stmtICJV.close();
				conn.close();
		     } catch(Exception e){
			      e.printStackTrace();
			      conn.close();
		     } finally{
				 conn.close();
			 }
		       return RESULTDATA;
		  }
	
	public JSONArray interCompanyBranchSearch() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		
        try {
				conn = connDAO.getMyConnection();
				Statement stmtICJV = conn.createStatement();

				String sql="select CONCAT(compname,' / ',branchname) intercompname,compname,branchname,dbname,brhid,cmpid,doc_no from intercompany.my_intrcomp where status=3 order by cmpid";
				
				ResultSet resultSet = stmtICJV.executeQuery(sql);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtICJV.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			 conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray costTypeSearch(String database) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();
	    
		try {
				Connection conn = connDAO.getMyConnection();
				Statement stmtICJV = conn.createStatement ();
				
				ResultSet resultSet = stmtICJV.executeQuery ("select costtype,costgroup from "+database+".my_costunit where status=1");
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtICJV.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
		}
	    return RESULTDATA;
	}
	
	
	public  JSONArray costCodeSearch(String type,String database) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();
	    ClsCommon ClsCommon=new ClsCommon();
	  
		try {
				Connection conn = connDAO.getMyConnection();
				Statement stmtICJV = conn.createStatement ();
			
				/* Cost Center */
	        	if(type.equalsIgnoreCase("1"))
	        	{
	        		String sql="select c1.costcode code,c1.doc_no doc_no,c1.description name,coalesce(c2.description,c1.description) namedet,c1.grpno,c2.grpno from "+database+".my_ccentre c1 left join "+database+".my_ccentre c2 on(c1.doc_no=c2.grpno) where c1.m_s=0";
	        		ResultSet resultSet = stmtICJV.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
	        		stmtICJV.close();
					conn.close();
	        	}
	        	/* AMC & SJOB */
	        	else if(type.equalsIgnoreCase("3") || type.equalsIgnoreCase("4"))
	        	{
	        		String dtype="";
	        		if(type.equalsIgnoreCase("3")) {
	        			dtype="AMC";
	        		} else if(type.equalsIgnoreCase("4")) {
	        			dtype="SJOB";
	        		}
	        		
	        		String sql="select m.doc_no,m.doc_no code,a.refname name from "+database+".cm_srvcontrm m left join "+database+".my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM' where m.status=3 and a.status=3 and m.dtype='"+dtype+"'";
	        		ResultSet resultSet = stmtICJV.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
	        		stmtICJV.close();
					conn.close();
	        	}
	        	/* Call Register */
	        	else if(type.equalsIgnoreCase("5"))
	        	{
	        		String sql="select m.doc_no,m.doc_no code,a.refname name from "+database+".cm_cuscallm m left join "+database+".my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM' where m.status=3 and a.status=3 and m.dtype='CREG'";
	        		ResultSet resultSet = stmtICJV.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
	        		stmtICJV.close();
					conn.close();
	        	}
	        	/* Fleet */
	        	else if(type.equalsIgnoreCase("6"))
	        	{
	        		String sql="select doc_no,fleet_no code,flname name,reg_no from "+database+".gl_vehmaster where cost=0";
	        		ResultSet resultSet = stmtICJV.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
	        		stmtICJV.close();
					conn.close();
	        	}
	        	/* IJCE */
	        	else if(type.equalsIgnoreCase("7"))
	        	{
	        		String sql="select m.doc_no,m.doc_no code,a.refname name,m.jobno,p.proj_name project from "+database+".is_jobmaster m left join "+database+".my_acbook a on m.client_id=a.doc_no and a.dtype='CRM' left join "+database+".is_jprjname p on m.project_id=p.tr_no where m.status=3 and a.status=3 and p.status=3 and m.dtype='IJCE'";
	        		ResultSet resultSet = stmtICJV.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
	        		stmtICJV.close();
					conn.close();
	        	}
		}
		catch(Exception e){
			e.printStackTrace();
		}
	    return RESULTDATA;
	}
	
	public JSONArray icjvMainSearch(HttpSession session,String docNo,String dates,String descriptions,String refNo,String amounts,String check) throws SQLException {
	   	   
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

	        java.sql.Date sqlStartDate=null;
	    	
			try {
					conn = connDAO.getMyConnection();
					Statement stmtICJV = conn.createStatement();
            
					dates.trim();
			    	if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0")))
			    	{
			    	sqlStartDate = commonDAO.changeStringtoSqlDate(dates);
			    	}
			    	
			    	String sqltest="";
			    	
			    	if(!(docNo.equalsIgnoreCase(""))){
			    		sqltest=sqltest+" and m.doc_no like '%"+docNo+"%'";
			    	}
			    	 if(!(sqlStartDate==null)){
				    		sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
				    } 
			    	if(!(descriptions.equalsIgnoreCase(""))){
			    		sqltest=sqltest+" and m.description like '%"+descriptions+"%'";
			    	}
			    	if(!(refNo.equalsIgnoreCase(""))){
			    		sqltest=sqltest+" and m.refNo like '%"+refNo+"%'";
			    	}
			    	if(!(amounts.equalsIgnoreCase(""))){
			    		sqltest=sqltest+" and m.drtot like '%"+amounts+"%'";
			    	}
			    	
					String sql5 = "SELECT m.doc_no,m.date,m.description,m.refno,m.drtot,m.tr_no,j.costtype,if(d.menu_name is null,' ',if(m.refid=1,' ',concat('AUTO POSTED : ',d.menu_name))) menu_name FROM my_jvma m left join my_jvtran j on m.tr_no=j.tr_no left join my_jvidentifyingid d on m.refid=d.jvid "
							+ "where m.dtype='ICJV' and m.status<>7 and m.brhId="+branch+"" +sqltest+" group by m.tr_no";
					
					ResultSet resultSet = stmtICJV.executeQuery(sql5);
					RESULTDATA=commonDAO.convertToJSON(resultSet);
						
					stmtICJV.close();
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
	
	public  JSONArray convertRowArrayToJSON(ArrayList<ArrayList<String>> rowsAnalysisList) throws Exception {
		  JSONArray jsonArray = new JSONArray();
		  
		  for (int i = 0; i < rowsAnalysisList.size(); i++) {
		   
		   JSONObject obj = new JSONObject();
		   ArrayList<String> analysisRowArray=rowsAnalysisList.get(i);
		   
		   obj.put("docno",analysisRowArray.get(0));
		   obj.put("compbranch",analysisRowArray.get(1));
		   obj.put("intrcompid",analysisRowArray.get(2));
		   obj.put("type",analysisRowArray.get(3));
		   obj.put("accounts",analysisRowArray.get(4));
		   obj.put("accountname1",analysisRowArray.get(5));
		   obj.put("costtype",analysisRowArray.get(6));
		   obj.put("costgroup",analysisRowArray.get(7));
		   obj.put("costcode",analysisRowArray.get(8));
		   obj.put("debit",analysisRowArray.get(9));
		   obj.put("credit",analysisRowArray.get(10));
		   obj.put("baseamount",analysisRowArray.get(11));
		   obj.put("description",analysisRowArray.get(12));
		   obj.put("currencyid",analysisRowArray.get(13));
		   obj.put("currencytype",analysisRowArray.get(14));
		   obj.put("rate",analysisRowArray.get(15));
		   obj.put("grtype",analysisRowArray.get(16));
		   obj.put("sr_no",analysisRowArray.get(17));
		   obj.put("intrbrhid",analysisRowArray.get(18));
		   obj.put("dbname",analysisRowArray.get(19));

		   jsonArray.add(obj);
		  }
		  return jsonArray;
		  }
	
	public ClsIcJournalVouchersBean getViewDetails(String branch,int docNo) throws SQLException {
		
		ClsIcJournalVouchersBean icJournalVouchersBean = new ClsIcJournalVouchersBean();
		
		Connection conn = null;
		
		try {
		
			conn = connDAO.getMyConnection();
			Statement stmtICJV = conn.createStatement();
		
			ResultSet resultSet = stmtICJV.executeQuery ("SELECT m.doc_no,m.date,m.description,m.refno,m.drtot,m.crtot,m.tr_no,if(d.menu_name is null,' ',if(m.refid=1,' ',concat('AUTO POSTED : ',d.menu_name))) menu_name "  
					+ "FROM my_jvma m left join my_jvtran j on m.tr_no=j.tr_no left join my_jvidentifyingid d on m.refid=d.jvid where m.dtype='ICJV' and m.status<>7 and m.brhId="+branch+" and m.doc_no="+docNo+" group by doc_no");
				
		while (resultSet.next()) {
				icJournalVouchersBean.setTxticjournalvouchersdocno(docNo);
				icJournalVouchersBean.setIcJournalVouchersDate(resultSet.getDate("date").toString());
				icJournalVouchersBean.setTxtrefno(resultSet.getString("refno"));
				icJournalVouchersBean.setTxtdescription(resultSet.getString("description"));
				icJournalVouchersBean.setTxttrno(resultSet.getInt("tr_no"));
				icJournalVouchersBean.setTxtdrtotal(resultSet.getDouble("drtot"));
				icJournalVouchersBean.setTxtcrtotal(resultSet.getDouble("crtot"));
				icJournalVouchersBean.setMaindate(resultSet.getDate("date").toString());
				icJournalVouchersBean.setLblformposted(resultSet.getString("menu_name"));
		    }
		  stmtICJV.close();
		  conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
			return icJournalVouchersBean;
		}

	public ClsIcJournalVouchersBean getPrint(HttpServletRequest request,int docNo,int branch,int header) throws SQLException {
		 ClsIcJournalVouchersBean bean = new ClsIcJournalVouchersBean();
		 Connection conn = null;
		 
		try {
			conn = connDAO.getMyConnection();
			Statement stmtICJV = conn.createStatement();
			
			String headersql="select if(m.dtype='ICJV','IC Journal Voucher','  ') vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
					+ "b.cstno from my_jvma m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='ICJV' "
					+ "and m.brhid="+branch+" and m.doc_no="+docNo+"";

				ResultSet resultSetHead = stmtICJV.executeQuery(headersql);
				
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
			
			String sqls="select m.doc_no,DATE_FORMAT(m.date ,'%d-%m-%Y') date,m.description,m.refNo,round(m.drtot,2) netAmount,u.user_name from my_jvma m left join "
				+ "my_user u on m.userid=u.doc_no where m.dtype='ICJV' and m.brhid="+branch+" and m.doc_no="+docNo+"";
	
			ResultSet resultSets = stmtICJV.executeQuery(sqls);
			
			ClsAmountToWords c = new ClsAmountToWords();
			
			while(resultSets.next()){
				
				bean.setLbldate(resultSets.getString("date"));
				bean.setLblvoucherno(resultSets.getString("doc_no"));
				bean.setLblrefno(resultSets.getString("refNo"));
				bean.setLbldescription(resultSets.getString("description"));

				bean.setLblnetamount(resultSets.getString("netAmount"));
				bean.setLblnetamountwords(c.convertAmountToWords(resultSets.getString("netAmount")));
				
				bean.setLbldebittotal(resultSets.getString("netAmount"));
				bean.setLblcredittotal(resultSets.getString("netAmount"));
				
				bean.setLblpreparedby(resultSets.getString("user_name"));
			}
			
			bean.setTxtheader(header);

			String sql1 = "";
		
			sql1="SELECT t.account,t.description accountname,j.description,c.code currency,if(j.dramount>0,round((j.dramount*1),2),'  ') debit,if(j.dramount<0,round((j.dramount*-1),2),'  ') credit, "
			  + "CONVERT(if(j.costtype=0,' ',coalesce(co.costgroup,' ')),CHAR(100)) costtype,CONVERT(if(j.costcode=0,' ',coalesce(j.costcode,' ')),CHAR(100)) costcode FROM my_jvma m left join my_jvtran j on m.tr_no=j.tr_no "
			  + "left join my_head t on j.acno=t.doc_no left join my_curr c on c.doc_no=j.curId left join my_costunit co on j.costtype=co.costtype WHERE m.dtype='ICJV' and m.brhid="+branch+" "
			  + "and m.doc_no="+docNo+" order by j.dramount desc";
			
			ResultSet resultSet1 = stmtICJV.executeQuery(sql1);
			
			ArrayList<String> printarray= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setFirstarray(1); 
				String temp="";
				
				temp=resultSet1.getString("account")+"::"+resultSet1.getString("accountname")+"::"+resultSet1.getString("description")+"::"+resultSet1.getString("currency")+"::"+resultSet1.getString("debit")+"::"+resultSet1.getString("credit");

				printarray.add(temp);
			}
			
			request.setAttribute("printingarray", printarray);
			
			String sql2 = "select min(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,min(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from my_jvma m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='ICJV' and m.brhid="+branch+" and m.doc_no="+docNo+"";
			ResultSet resultSet2 = stmtICJV.executeQuery(sql2);
			
			while(resultSet2.next()){
				bean.setLblpreparedon(resultSet2.getString("preparedon"));
				bean.setLblpreparedat(resultSet2.getString("preparedat"));
			}
		
			stmtICJV.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
		return bean;
	}


}
