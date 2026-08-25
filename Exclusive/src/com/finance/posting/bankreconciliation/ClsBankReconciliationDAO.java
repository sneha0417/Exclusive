package com.finance.posting.bankreconciliation;

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

public class ClsBankReconciliationDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsBankReconciliationBean bankReconciliationBean = new ClsBankReconciliationBean();
	
	public int insert(Date bankReconciliationDate, String txtdescription,String cmbbranch, String cmbcurrency, int txtdocno,double txtunclrreceipts, double txtunclrpayments,
			double txtbookbalance, double txtbankbalance, String formdetailcode, ArrayList<String> bankreconciliationarray, ArrayList<String> bankreconcilearray, HttpSession session, HttpServletRequest request) throws SQLException {
		  
		Connection conn= null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			
			CallableStatement stmtBRCN = conn.prepareCall("{CALL breconmDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtBRCN.registerOutParameter(13, java.sql.Types.INTEGER);
			stmtBRCN.registerOutParameter(14, java.sql.Types.INTEGER);
			stmtBRCN.setDate(1,bankReconciliationDate);
			stmtBRCN.setString(2,txtdescription);
			stmtBRCN.setInt(3,txtdocno);
			stmtBRCN.setString(4,cmbcurrency);
			stmtBRCN.setDouble(5,txtunclrreceipts);
			stmtBRCN.setDouble(6,txtunclrpayments);
			stmtBRCN.setDouble(7,txtbookbalance);
			stmtBRCN.setDouble(8,txtbankbalance);
			stmtBRCN.setString(9,formdetailcode);
			stmtBRCN.setString(10,company);
			stmtBRCN.setString(11,branch);
			stmtBRCN.setString(12,userid);
			stmtBRCN.setString(15,"A");
			stmtBRCN.executeQuery();
			int docno=stmtBRCN.getInt("docNo");
			int trno=stmtBRCN.getInt("itranNo");
			
			request.setAttribute("tranno", trno);
			
			bankReconciliationBean.setTxtbankreconciliationdocno(docno);
			if (docno > 0) {
				  /*Applying Grid Updating*/
					for(int i=0;i< bankreconciliationarray.size();i++){
					CallableStatement stmtBRCN1=null;	
					String[] applyupdate=bankreconciliationarray.get(i).split("::");
	                 
					if(!applyupdate[2].trim().equalsIgnoreCase("undefined") && !applyupdate[2].trim().equalsIgnoreCase("NaN")){
					
					java.sql.Date clearedDate=(applyupdate[1].trim().equalsIgnoreCase("undefined") || applyupdate[1].trim().equalsIgnoreCase("NaN") || applyupdate[1].trim().equalsIgnoreCase("") ||  applyupdate[1].trim().isEmpty()?null:commonDAO.changetstmptoSqlDate(applyupdate[1].trim()));
						
					stmtBRCN1 = conn.prepareCall("update my_jvtran set clearedon=?,bankreconcile=? where tranid=?");
					
					stmtBRCN1.setDate(1,clearedDate); //clearedon
					stmtBRCN1.setInt(2,docno); //bankreconciledocno
					stmtBRCN1.setString(3,(applyupdate[2].trim().equalsIgnoreCase("undefined") || applyupdate[2].trim().equalsIgnoreCase("NaN") || applyupdate[2].trim().equalsIgnoreCase("") ||applyupdate[2].trim().isEmpty()?0:applyupdate[2].trim()).toString()); //tranid
					int data = stmtBRCN1.executeUpdate();
						if(data<=0){
							stmtBRCN1.close();
							conn.close();
							return 0;
						}
					  }
					
					}
					/*Applying Grid Updating Ends*/
					
					/*Applying Grid Inserting*/
					for(int i=0;i< bankreconcilearray.size();i++){
					CallableStatement stmtBRCN2=null;
					String[] apply=bankreconcilearray.get(i).split("::");
	                 
					if(!apply[2].trim().equalsIgnoreCase("undefined") && !apply[2].trim().equalsIgnoreCase("NaN")){
						
					java.sql.Date clearedDate=(apply[1].trim().equalsIgnoreCase("undefined") || apply[1].trim().equalsIgnoreCase("NaN") || apply[1].trim().equalsIgnoreCase("") ||  apply[1].trim().isEmpty()?null:commonDAO.changetstmptoSqlDate(apply[1].trim()));
					java.sql.Date dates=(apply[4].trim().equalsIgnoreCase("undefined") || apply[4].trim().equalsIgnoreCase("NaN") || apply[4].trim().equalsIgnoreCase("") ||  apply[4].trim().isEmpty()?null:commonDAO.changetstmptoSqlDate(apply[4].trim()));
					java.sql.Date chequeDate=(apply[8].trim().equalsIgnoreCase("undefined") || apply[8].trim().equalsIgnoreCase("NaN") || apply[8].trim().equalsIgnoreCase("") ||  apply[8].trim().isEmpty()?null:commonDAO.changetstmptoSqlDate(apply[8].trim()));	
					
					stmtBRCN2 = conn.prepareCall("INSERT INTO my_brecond(tr_no, tranId, c_date, sr_no, netAmount, doc_no, dtype, date, chk, chqno, chqdt, debit, credit, ref_detail, description, party_name, rdocno) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
					
					stmtBRCN2.setInt(1,trno); //trNo
					stmtBRCN2.setString(2,(apply[3].trim().equalsIgnoreCase("undefined") || apply[3].trim().equalsIgnoreCase("NaN") || apply[3].trim().equalsIgnoreCase("") ||apply[3].trim().isEmpty()?0:apply[3].trim()).toString()); //tranid
					stmtBRCN2.setDate(3,clearedDate); //clearedon
					stmtBRCN2.setInt(4,(i+1)); //srNo
					stmtBRCN2.setDouble(5, (apply[2].trim().equalsIgnoreCase("undefined") || apply[2].trim().equalsIgnoreCase("NaN") || apply[2].trim().equalsIgnoreCase("") || apply[2].trim().isEmpty()?0.0:Double.parseDouble(apply[2].trim()))); //netAmount
					stmtBRCN2.setString(6,(apply[5].trim().equalsIgnoreCase("undefined") || apply[5].trim().equalsIgnoreCase("NaN") || apply[5].trim().equalsIgnoreCase("") ||apply[5].trim().isEmpty()?0:apply[5].trim()).toString()); //doc_no
					stmtBRCN2.setString(7,(apply[6].trim().equalsIgnoreCase("undefined") || apply[6].trim().equalsIgnoreCase("NaN") || apply[6].trim().equalsIgnoreCase("") ||apply[6].trim().isEmpty()?0:apply[6].trim()).toString()); //dtype
					stmtBRCN2.setDate(8,dates); //Date
					stmtBRCN2.setString(9,(apply[0].trim().equalsIgnoreCase("undefined") || apply[0].trim().equalsIgnoreCase("NaN") || apply[0].trim().equalsIgnoreCase("") ||apply[0].trim().isEmpty()?0:apply[0].trim()).toString()); //chk
					stmtBRCN2.setString(10,(apply[7].trim().equalsIgnoreCase("undefined") || apply[7].trim().equalsIgnoreCase("NaN") || apply[7].trim().equalsIgnoreCase("") ||apply[7].trim().isEmpty()?0:apply[7].trim()).toString()); //Cheque No
					stmtBRCN2.setDate(11,chequeDate); //Cheque Date
					stmtBRCN2.setDouble(12, (apply[9].trim().equalsIgnoreCase("undefined") || apply[9].trim().equalsIgnoreCase("NaN") || apply[9].trim().equalsIgnoreCase("") || apply[9].trim().isEmpty()?0.0:Double.parseDouble(apply[9].trim()))); //debit
					stmtBRCN2.setDouble(13, (apply[10].trim().equalsIgnoreCase("undefined") || apply[10].trim().equalsIgnoreCase("NaN") || apply[10].trim().equalsIgnoreCase("") || apply[10].trim().isEmpty()?0.0:Double.parseDouble(apply[10].trim()))); //credit
					stmtBRCN2.setString(14,(apply[11].trim().equalsIgnoreCase("undefined") || apply[11].trim().equalsIgnoreCase("NaN") || apply[11].trim().equalsIgnoreCase("") ||apply[11].trim().isEmpty()?0:apply[11].trim()).toString()); //ref_detail
					stmtBRCN2.setString(15,(apply[12].trim().equalsIgnoreCase("undefined") || apply[12].trim().equalsIgnoreCase("NaN") || apply[12].trim().equalsIgnoreCase("") ||apply[12].trim().isEmpty()?0:apply[12].trim()).toString()); //description
					stmtBRCN2.setString(16,(apply[13].trim().equalsIgnoreCase("undefined") || apply[13].trim().equalsIgnoreCase("NaN") || apply[13].trim().equalsIgnoreCase("") ||apply[13].trim().isEmpty()?0:apply[13].trim()).toString()); //party
					stmtBRCN2.setInt(17,docno); //docno
					int data2 = stmtBRCN2.executeUpdate();
						if(data2<=0){
							stmtBRCN2.close();
							conn.close();
							return 0;
						}
					  }
					}
					/*Applying Grid Inserting Ends*/
					
					conn.commit();
					stmtBRCN.close();
					conn.close();
				    return docno;
			}
	 } catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 } finally{
		 conn.close();
	 }
		return 0;
	}
	
	public boolean edit(Date bankReconciliationDate, int docno, int trno, String txtdescription, String cmbbranch, String cmbcurrency, int txtdocno, double txtunclrreceipts, double txtunclrpayments,
			double txtbookbalance, double txtbankbalance, String formdetailcode, ArrayList<String> bankreconciliationarray, ArrayList<String> bankreconcilearray, HttpSession session, HttpServletRequest request) throws SQLException {
		 
			Connection conn = null;
		 
			try{
					conn=connDAO.getMyConnection();
					conn.setAutoCommit(false);
					Statement stmtBRCN = conn.createStatement();
					
				    String branch=session.getAttribute("BRANCHID").toString().trim();
					String userid=session.getAttribute("USERID").toString().trim();
					
					/*Selecting Tran-Id*/
					 ArrayList<String> tranidarray=new ArrayList<>();
					 String sql=("SELECT TRANID FROM my_jvtran where bankreconcile="+docno);
					 ResultSet resultSet = stmtBRCN.executeQuery(sql);
					    
					 while (resultSet.next()) {
						 tranidarray.add(resultSet.getString("tranid"));
					 }
					 
					 /*Selecting Tran-Id Ends*/
					  
					  if(tranidarray.size()>0){
						  int tranid=0;
						  for(int i=0;i<tranidarray.size();i++){
							  /*Updating bankreconcile*/
							  tranid=Integer.parseInt(tranidarray.get(i).split("::")[0]);
							  
							  String sql1="update my_jvtran set bankreconcile=0 where tranid="+tranid+"";
							  int data1=stmtBRCN.executeUpdate(sql1);
							  if(data1<=0){
								    stmtBRCN.close();
									conn.close();
									return false;
							  }
							  /*Updating bankreconcile Ends*/
						  }
					  }  
					
					/*Updating my_breconm*/
	                String sql2=("update my_breconm set date='"+bankReconciliationDate+"', acno='"+txtdocno+"', description='"+txtdescription+"', bookBal="+txtbookbalance+", bankBal="+txtbankbalance+", rvBal="+txtunclrreceipts+", pvBal="+txtunclrpayments+", curId="+cmbcurrency+", brhId="+branch+" where doc_no="+docno);
	                int data2 = stmtBRCN.executeUpdate(sql2);
	                if(data2<=0){
	                	stmtBRCN.close();
						conn.close();
						return false;
					}
					/*Updating my_breconm Ends*/
					
					/*Inserting into datalog*/
					String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
					int datas = stmtBRCN.executeUpdate(sqls);
					/*Inserting into datalog Ends*/
					
					String sql3=("DELETE FROM my_brecond WHERE rdocno="+docno);
				    int data3 = stmtBRCN.executeUpdate(sql3);
				    
					bankReconciliationBean.setTxtbankreconciliationdocno(docno);
					if (docno > 0) {
						  /*Applying Grid Updating*/
							for(int i=0;i< bankreconciliationarray.size();i++){
							CallableStatement stmtBRCN1=null;	
							String[] applyupdate=bankreconciliationarray.get(i).split("::");
			                 
							if(!applyupdate[2].trim().equalsIgnoreCase("undefined") && !applyupdate[2].trim().equalsIgnoreCase("NaN")){
							
							java.sql.Date clearedDate=(applyupdate[1].trim().equalsIgnoreCase("undefined") || applyupdate[1].trim().equalsIgnoreCase("NaN") || applyupdate[1].trim().equalsIgnoreCase("") ||  applyupdate[1].trim().isEmpty()?null:commonDAO.changetstmptoSqlDate(applyupdate[1].trim()));
								
							stmtBRCN1 = conn.prepareCall("update my_jvtran set clearedon=?,bankreconcile=? where tranid=?");
							
							stmtBRCN1.setDate(1,clearedDate); //clearedon
							stmtBRCN1.setInt(2,docno); //bankreconciledocno
							stmtBRCN1.setString(3,(applyupdate[2].trim().equalsIgnoreCase("undefined") || applyupdate[2].trim().equalsIgnoreCase("NaN") || applyupdate[2].trim().equalsIgnoreCase("") ||applyupdate[2].trim().isEmpty()?0:applyupdate[2].trim()).toString()); //tranid
							int data4 = stmtBRCN1.executeUpdate();
								if(data4<=0){
									stmtBRCN1.close();
									conn.close();
									return false;
								}
							  }
							
							}
							/*Applying Grid Updating Ends*/
							
							/*Applying Grid Inserting*/
							for(int i=0;i< bankreconcilearray.size();i++){
							CallableStatement stmtBRCN2=null;
							String[] apply=bankreconcilearray.get(i).split("::");
			                 
							if(!apply[2].trim().equalsIgnoreCase("undefined") && !apply[2].trim().equalsIgnoreCase("NaN")){
								
							java.sql.Date clearedDate=(apply[1].trim().equalsIgnoreCase("undefined") || apply[1].trim().equalsIgnoreCase("NaN") || apply[1].trim().equalsIgnoreCase("") ||  apply[1].trim().isEmpty()?null:commonDAO.changetstmptoSqlDate(apply[1].trim()));
							java.sql.Date dates=(apply[4].trim().equalsIgnoreCase("undefined") || apply[4].trim().equalsIgnoreCase("NaN") || apply[4].trim().equalsIgnoreCase("") ||  apply[4].trim().isEmpty()?null:commonDAO.changetstmptoSqlDate(apply[4].trim()));
							java.sql.Date chequeDate=(apply[8].trim().equalsIgnoreCase("undefined") || apply[8].trim().equalsIgnoreCase("NaN") || apply[8].trim().equalsIgnoreCase("") ||  apply[8].trim().isEmpty()?null:commonDAO.changetstmptoSqlDate(apply[8].trim()));	
							
							stmtBRCN2 = conn.prepareCall("INSERT INTO my_brecond(tr_no, tranId, c_date, sr_no, netAmount, doc_no, dtype, date, chk, chqno, chqdt, debit, credit, ref_detail, description, party_name, rdocno) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
							
							stmtBRCN2.setInt(1,trno); //trNo
							stmtBRCN2.setString(2,(apply[3].trim().equalsIgnoreCase("undefined") || apply[3].trim().equalsIgnoreCase("NaN") || apply[3].trim().equalsIgnoreCase("") ||apply[3].trim().isEmpty()?0:apply[3].trim()).toString()); //tranid
							stmtBRCN2.setDate(3,clearedDate); //clearedon
							stmtBRCN2.setInt(4,(i+1)); //srNo
							stmtBRCN2.setDouble(5, (apply[2].trim().equalsIgnoreCase("undefined") || apply[2].trim().equalsIgnoreCase("NaN") || apply[2].trim().equalsIgnoreCase("") || apply[2].trim().isEmpty()?0.0:Double.parseDouble(apply[2].trim()))); //netAmount
							stmtBRCN2.setString(6,(apply[5].trim().equalsIgnoreCase("undefined") || apply[5].trim().equalsIgnoreCase("NaN") || apply[5].trim().equalsIgnoreCase("") ||apply[5].trim().isEmpty()?0:apply[5].trim()).toString()); //doc_no
							stmtBRCN2.setString(7,(apply[6].trim().equalsIgnoreCase("undefined") || apply[6].trim().equalsIgnoreCase("NaN") || apply[6].trim().equalsIgnoreCase("") ||apply[6].trim().isEmpty()?0:apply[6].trim()).toString()); //dtype
							stmtBRCN2.setDate(8,dates); //Date
							stmtBRCN2.setString(9,(apply[0].trim().equalsIgnoreCase("undefined") || apply[0].trim().equalsIgnoreCase("NaN") || apply[0].trim().equalsIgnoreCase("") ||apply[0].trim().isEmpty()?0:apply[0].trim()).toString()); //chk
							stmtBRCN2.setString(10,(apply[7].trim().equalsIgnoreCase("undefined") || apply[7].trim().equalsIgnoreCase("NaN") || apply[7].trim().equalsIgnoreCase("") ||apply[7].trim().isEmpty()?0:apply[7].trim()).toString()); //Cheque No
							stmtBRCN2.setDate(11,chequeDate); //Cheque Date
							stmtBRCN2.setDouble(12, (apply[9].trim().equalsIgnoreCase("undefined") || apply[9].trim().equalsIgnoreCase("NaN") || apply[9].trim().equalsIgnoreCase("") || apply[9].trim().isEmpty()?0.0:Double.parseDouble(apply[9].trim()))); //debit
							stmtBRCN2.setDouble(13, (apply[10].trim().equalsIgnoreCase("undefined") || apply[10].trim().equalsIgnoreCase("NaN") || apply[10].trim().equalsIgnoreCase("") || apply[10].trim().isEmpty()?0.0:Double.parseDouble(apply[10].trim()))); //credit
							stmtBRCN2.setString(14,(apply[11].trim().equalsIgnoreCase("undefined") || apply[11].trim().equalsIgnoreCase("NaN") || apply[11].trim().equalsIgnoreCase("") ||apply[11].trim().isEmpty()?0:apply[11].trim()).toString()); //ref_detail
							stmtBRCN2.setString(15,(apply[12].trim().equalsIgnoreCase("undefined") || apply[12].trim().equalsIgnoreCase("NaN") || apply[12].trim().equalsIgnoreCase("") ||apply[12].trim().isEmpty()?0:apply[12].trim()).toString()); //description
							stmtBRCN2.setString(16,(apply[13].trim().equalsIgnoreCase("undefined") || apply[13].trim().equalsIgnoreCase("NaN") || apply[13].trim().equalsIgnoreCase("") ||apply[13].trim().isEmpty()?0:apply[13].trim()).toString()); //party
							stmtBRCN2.setInt(17,docno); //docno
							int data5 = stmtBRCN2.executeUpdate();
								if(data5<=0){
									stmtBRCN2.close();
									conn.close();
									return false;
								}
							  }
							}
							/*Applying Grid Inserting Ends*/
							
							conn.commit();
							stmtBRCN.close();
							conn.close();
						    return true;
					}
				stmtBRCN.close();
				conn.close();
			 } catch(Exception e){	
				 	e.printStackTrace();
				 	conn.close();
				 	return false;
			 } finally{
					conn.close();
				}
		return false;
	}
	
	public JSONArray accountsDetails(HttpSession session) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		
        try {
				conn = connDAO.getMyConnection();
				Statement stmtBRCN = conn.createStatement();
        
				 String branch = session.getAttribute("BRANCHID").toString();
				 String company = session.getAttribute("COMPANYID").toString();
				    
				ResultSet resultSet = stmtBRCN.executeQuery ("select t.doc_no,t.account,t.description,c.code curr from my_head t,"
          			+ "(select curId from my_brch where doc_no=  '"+branch+"') h,my_curr c,(select (@i:=0)) a where t.m_s=0 and t.atype='GL' "
          			+ "and c.doc_no=if(t.lApply,h.curId,t.curId) and t.cmpid in(0,'"+company+"') and t.brhid in(0,'"+branch+"') and den='305'");

				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtBRCN.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray bankReconciliationGridLoading(HttpSession session,String accountno,String date,String check , String docno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
        Connection conn = null;
        
        Enumeration<String> Enumeration = session.getAttributeNames();
        int a=0;
        while(Enumeration.hasMoreElements()){
        	String newelement=Enumeration.nextElement();
        	if(newelement.equalsIgnoreCase("BRANCHID")){
        		a=a+1;
        	}
        	if(newelement.equalsIgnoreCase("CURRENCYID")){
        		a=a+1;
        	}
        }
        if(a<2){
    		return RESULTDATA;
        	}
        String branch = session.getAttribute("BRANCHID").toString();
        String currency = session.getAttribute("CURRENCYID").toString();
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtBRCN = conn.createStatement();
				
				if(check.equalsIgnoreCase("1")){
					
					java.sql.Date sqlBankReconciliationDate=null;
					
					if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))) {
						sqlBankReconciliationDate=commonDAO.changeStringtoSqlDate(date);
					}
				           
					String sql = "",sqltest="";
					if(!(docno.trim().equalsIgnoreCase(""))){
						
						sql= "select date,dtype,doc_no,chqno,chqdt,round(credit,2) cr,round(debit,2) dr,chk,c_date,description,party_name party,ref_detail,tranId from my_brecond where rdocno="+docno+" order by sr_no";
						
					} else {
						
						 if(!(sqlBankReconciliationDate==null)){
					         sqltest=sqltest+" and t.date<='"+sqlBankReconciliationDate+"'";
					      } 
						 
					/*	sql = "select 0 chk,t.clearedon c_date,@xdr:=(round(if(t.dramount<0,t.dramount*t.id,0),2)) dr,@xcr:=(round(if(t.dramount>0,t.dramount*t.id,0),2)) cr,"
							+ "round((@xdr-@xcr),2) netAmount,0 status,t.doc_no,t.dtype,t.date,t.tranid,t.description,t.ref_detail,q.chqno,q.chqdt,(select max(tranid) "
							+ "from my_jvtran where doc_no=t.doc_no and dtype=t.dtype) maxtrid,(select acno from my_jvtran where doc_no=t.doc_no and dtype=t.dtype "
							+ "and tranid=maxtrid) ac,(select description from my_head where doc_no=ac) party from my_jvtran t inner join my_brch b on t.brhId=b.doc_no "
							+ "left join my_chqbd d on t.tr_no=d.tr_no and d.rowno=t.ref_row left join my_chqdet q on d.rowno=q.rowno and t.brhid="+branch+" where "
							+ " t.status=3 and t.bankreconcile=0 and t.yrid=0 and t.acno="+accountno+""+sqltest+"";
            	*/     
						 /*Query changed due to loading time pblm removed direct select and joined*/
						 sql = "select 0 chk,t.clearedon c_date,@xdr:=(round(if(t.dramount<0,t.dramount*t.id,0),2)) dr,@xcr:=(round(if(t.dramount>0,t.dramount*t.id,0),2)) cr,"
									+ " round((@xdr-@xcr),2) netAmount,0 status,t.doc_no,t.dtype,t.date,t.tranid,t.description,t.ref_detail,q.chqno,q.chqdt,h.description party "
									+ " from my_jvtran t inner join my_brch b on t.brhId=b.doc_no "
									+ " left join my_chqbd d on t.tr_no=d.tr_no and d.rowno=t.ref_row left join my_chqdet q on d.rowno=q.rowno  "
									+ " left join (select max(tranid) maxtrid,doc_no,dtype,brhid from my_jvtran group by doc_no,dtype,brhid) mx on mx.brhid=t.brhid and mx.doc_no=t.doc_no and mx.dtype=t.dtype left join my_jvtran j1 on j1.tranid=mx.maxtrid left join my_head h on h.doc_no=j1.acno where "
									+ " t.status=3 and t.bankreconcile=0 and t.yrid=0 and t.acno="+accountno+""+sqltest+"";
						        
						System.out.println("=bank rec----->>>"+sql);
					}
					/*and t.brhid="+branch+"*/
					ResultSet resultSet = stmtBRCN.executeQuery(sql);
					RESULTDATA=commonDAO.convertToJSON(resultSet);
					}
				
				stmtBRCN.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	
	public JSONArray bankReconciliationGridLoadingExcel(HttpSession session,String accountno,String date,String check , String docno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
        Connection conn = null;
        
        Enumeration<String> Enumeration = session.getAttributeNames();
        int a=0;
        while(Enumeration.hasMoreElements()){
        	String newelement=Enumeration.nextElement();
        	if(newelement.equalsIgnoreCase("BRANCHID")){
        		a=a+1;
        	}
        	if(newelement.equalsIgnoreCase("CURRENCYID")){
        		a=a+1;
        	}
        }
        if(a<2){
    		return RESULTDATA;
        	}
        String branch = session.getAttribute("BRANCHID").toString();
        String currency = session.getAttribute("CURRENCYID").toString();
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtBRCN = conn.createStatement();
				
				if(check.equalsIgnoreCase("1")){
					
					java.sql.Date sqlBankReconciliationDate=null;
					
					if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))) {
						sqlBankReconciliationDate=commonDAO.changeStringtoSqlDate(date);
					}
				           
					String sql = "",sqltest="";
					if(!(docno.trim().equalsIgnoreCase(""))){
						
						sql= "select m.date 'Date',m.dtype 'Doc Type',m.doc_no 'Doc No.',m.chqno 'Cheque No.',m.chqdt  'Cheque Date',round(m.credit,2)  'Receipts',round(m.debit,2) 'Payments',m.c_date  'Posted Date',m.description 'Description',m.party_name 'Party Name',m.ref_detail 'Reference' from my_brecond m where m.rdocno="+docno+" order by sr_no";
						
					} else {
						
						 if(!(sqlBankReconciliationDate==null)){
					         sqltest=sqltest+" and t.date<='"+sqlBankReconciliationDate+"'";
					      } 
						 
					/*	sql = "select t.date 'Date',t.dtype 'Doc Type',t.doc_no 'Doc No.',q.chqno 'Cheque No.',q.chqdt 'Cheque Date',@xcr:=(round(if(t.dramount>0,t.dramount*t.id,0),2)) 'Receipts',@xdr:=(round(if(t.dramount<0,t.dramount*t.id,0),2)) 'Payments',"
							+ "t.clearedon 'Posted Date',round((@xdr-@xcr),2) netAmount,0 status,t.description 'Description',t.ref_detail 'Reference',(select max(tranid) "
							+ "from my_jvtran where doc_no=t.doc_no and dtype=t.dtype) maxtrid,(select acno from my_jvtran where doc_no=t.doc_no and dtype=t.dtype "
							+ "and tranid=maxtrid) ac,(select description from my_head where doc_no=ac) 'Party Name' from my_jvtran t inner join my_brch b on t.brhId=b.doc_no "
							+ "left join my_chqbd d on t.tr_no=d.tr_no and d.rowno=t.ref_row left join my_chqdet q on d.rowno=q.rowno and t.brhid="+branch+" where "
							+ " t.status=3 and t.bankreconcile=0 and t.yrid=0 and t.acno="+accountno+""+sqltest+"";
							 and t.brhid="+branch+"
            	*/
						 /*Query changed due to loading time pblm, removed direct select and joined*/
						 sql = "select t.date 'Date',t.dtype 'Doc Type',t.doc_no 'Doc No.',q.chqno 'Cheque No.',q.chqdt 'Cheque Date',@xcr:=(round(if(t.dramount>0,t.dramount*t.id,0),2)) 'Receipts',@xdr:=(round(if(t.dramount<0,t.dramount*t.id,0),2)) 'Payments',"
									+ " t.clearedon 'Posted Date',round((@xdr-@xcr),2) netAmount,0 status,t.description 'Description',t.ref_detail 'Reference',h.description 'Party Name' from my_jvtran t inner join my_brch b on t.brhId=b.doc_no "
									+ " left join my_chqbd d on t.tr_no=d.tr_no and d.rowno=t.ref_row left join my_chqdet q on d.rowno=q.rowno "
									+ " left join (select max(tranid) maxtrid,doc_no,dtype,brhid from my_jvtran group by doc_no,dtype,brhid) mx on mx.brhid=t.brhid and mx.doc_no=t.doc_no and mx.dtype=t.dtype left join my_jvtran j1 on j1.tranid=mx.maxtrid left join my_head h on h.doc_no=j1.acno where "
									+ " t.status=3 and t.bankreconcile=0 and t.yrid=0 and t.acno="+accountno+""+sqltest+"";
		            	
						 
					}
					System.out.println("=bank reco=="+sql);

					ResultSet resultSet = stmtBRCN.executeQuery(sql);
					RESULTDATA=commonDAO.convertToEXCEL(resultSet);
					}
				
				stmtBRCN.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray bankReconciliationEditGridLoading(HttpSession session,String docno,String mode,String check) throws SQLException {
	      JSONArray RESULTDATA=new JSONArray();
	      
	      Connection conn = null;
			
	      try {
					conn = connDAO.getMyConnection();
					Statement stmtBRCN = conn.createStatement();
					
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
					
					if(check.equalsIgnoreCase("1") && mode.equalsIgnoreCase("E")){
						/*and j.brhid="+branch+"*/
						String sql = "select j.date,j.dtype,j.doc_no,q.chqno,q.chqdt,round(if(j.dramount>0,j.dramount*j.id,0),2) cr,round(if(j.dramount<0,j.dramount*j.id,0),2) dr,1 chk,j.clearedon c_date,j.description,"  
								 + "h.description party,j.ref_detail,j.tranid from my_jvtran j left join my_chqbd d on j.tr_no=d.tr_no and d.rowno=j.ref_row left join my_chqdet q on d.rowno=q.rowno  left join "
								 + "my_head h on j.acno=h.doc_no where j.yrid=0 and j.bankreconcile="+docno+" UNION ALL select date,dtype,doc_no,chqno,chqdt,round(credit,2) cr,round(debit,2) dr,chk,c_date,description,party_name party,"
								 + "ref_detail,tranId from my_brecond where rdocno="+docno+"";
					
						ResultSet resultSet = stmtBRCN.executeQuery(sql);
						RESULTDATA=commonDAO.convertToJSON(resultSet);

						stmtBRCN.close();
						conn.close();
					}
					stmtBRCN.close();
					conn.close();
			} catch(Exception e){
				e.printStackTrace();
				conn.close();
			} finally{
				conn.close();
			}
	      return RESULTDATA;
	  }
	
	
	public double bookBalance(HttpSession session,String accountno,String date,String check , String docno) throws SQLException {
        Connection conn = null;
        
        Enumeration<String> Enumeration = session.getAttributeNames();
        int a=0;
        while(Enumeration.hasMoreElements()){
        	String newelement=Enumeration.nextElement();
        	if(newelement.equalsIgnoreCase("BRANCHID")){
        		a=a+1;
        	}
        	if(newelement.equalsIgnoreCase("CURRENCYID")){
        		a=a+1;
        	}
        }
        if(a<2){
    		return 0;
        	}
        
        String branch = session.getAttribute("BRANCHID").toString();
        String currency = session.getAttribute("CURRENCYID").toString();
        double bookbalance=0.0;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtBRCN = conn.createStatement();
				if(check.equalsIgnoreCase("1")){
					java.sql.Date sqlBankReconciliationDate=null;
					if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
						sqlBankReconciliationDate=commonDAO.changeStringtoSqlDate(date);
					}
						 
						String sql = "",sqltest="";
						if(!(docno.trim().equalsIgnoreCase(""))){
							sql = " select bookbal dr from my_breconm where doc_no= "+docno;
						}
						else{
							
							if(!(sqlBankReconciliationDate==null)){
						         sqltest=sqltest+" and t.date<='"+sqlBankReconciliationDate+"'";
						     }
							
							sql="select ifnull(sum(if(t.curId="+currency+",dramount, if(b.curId="+currency+",t.ldramount,0))),0) Dr from my_jvtran t  inner join my_brch b on "
									+ "t.brhId=b.doc_no  where T.STATUS=3 AND t.acno="+accountno+" and (t.curId="+currency+" or b.curId="+currency+") "+sqltest+"";
						}
					// System.out.println("====== "+sql);
					ResultSet resultSet = stmtBRCN.executeQuery(sql);
					while(resultSet.next()){
						bookbalance=resultSet.getDouble("dr");
					  }
				   } 
				
				stmtBRCN.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return bookbalance;
    }
	
	
	
	
	public JSONArray brcnMainSearch(String account,String docNo,String currency,String description,String reconcileDt,String check) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
        Connection conn = null;

        java.sql.Date sqlReconcileDate=null;
           
     try {
	       conn = connDAO.getMyConnection();
	       Statement stmtBRCN = conn.createStatement();
	       
	        reconcileDt.trim();
	        if(!(reconcileDt.equalsIgnoreCase("undefined"))&&!(reconcileDt.equalsIgnoreCase(""))&&!(reconcileDt.equalsIgnoreCase("0")))
	        {
	          sqlReconcileDate = commonDAO.changeStringtoSqlDate(reconcileDt);
	        }

	        String sqltest="";
	        
	        if(!(docNo.equalsIgnoreCase(""))){
	            sqltest=sqltest+" and m.doc_no like '%"+docNo+"%'";
	        }
	        if(!(account.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and t.description like '%"+account+"%'";
	        }
	        if(!(currency.equalsIgnoreCase(""))){
	            sqltest=sqltest+" and c.code like '%"+currency+"%'";
	        }
	        if(!(description.equalsIgnoreCase(""))){
	            sqltest=sqltest+" and m.description like '%"+description+"%'";
	           }
	        if(!(sqlReconcileDate==null)){
		         sqltest=sqltest+" and m.date='"+sqlReconcileDate+"'";
		        } 
	        
	       ResultSet resultSet = stmtBRCN.executeQuery("select m.doc_no,m.date,m.description,t.description account,c.code from my_breconm m left join my_head t on m.acno=t.doc_no left join my_curr c on m.curId=c.doc_no where m.status <> 7" +sqltest);
	
	       RESULTDATA=commonDAO.convertToJSON(resultSet);
	       
	       stmtBRCN.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
		 conn.close();
	 }
         return RESULTDATA;
    }
	
	 public ClsBankReconciliationBean getViewDetails(HttpSession session,int docNo) throws SQLException {
		ClsBankReconciliationBean bankReconciliationBean = new ClsBankReconciliationBean();
		
		Connection conn = null;
		
		try {
			conn = connDAO.getMyConnection();
			Statement stmtBRCN = conn.createStatement();
			
			ResultSet resultSet = stmtBRCN.executeQuery ("select m.date,m.acno,m.description,m.rvBal,m.pvBal,m.bookBal,m.bankBal,m.curId,m.brhId,m.tr_no,t.description accountname,t.account,"
					+ "if(m.doc_no!=(SELECT max(doc_no) docno FROM my_breconm where status<>7 and acno=m.acno),'.',' ') editing from my_breconm m left join my_head t on m.acno=t.doc_no where m.doc_no="+docNo+"");
	
			while (resultSet.next()) {
				bankReconciliationBean.setTxtbankreconciliationdocno(docNo);
				bankReconciliationBean.setJqxBankReconciliationDate(resultSet.getDate("date").toString());
				bankReconciliationBean.setHidcmbbranch(resultSet.getString("brhId"));
				bankReconciliationBean.setHidcmbcurrency(resultSet.getString("curId"));
				
				bankReconciliationBean.setTxtdocno(resultSet.getInt("acno"));
				bankReconciliationBean.setTxtaccid(resultSet.getString("account"));
				bankReconciliationBean.setTxtaccname(resultSet.getString("accountname"));
				bankReconciliationBean.setTxtdescription(resultSet.getString("description"));
	
				bankReconciliationBean.setTxtunclrreceipts(resultSet.getDouble("rvBal"));
				bankReconciliationBean.setTxtunclrpayments(resultSet.getDouble("pvBal"));
				bankReconciliationBean.setTxtbookbalance(resultSet.getDouble("bookBal"));
				bankReconciliationBean.setTxtbankbalance(resultSet.getDouble("bankBal"));
				
				bankReconciliationBean.setTxttrno(resultSet.getInt("tr_no"));
				bankReconciliationBean.setLblformposted(resultSet.getString("editing"));
			    }
			stmtBRCN.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
		return bankReconciliationBean;
		}

	 public ClsBankReconciliationBean getPrint(HttpServletRequest request,int docNo,int branch,int header) throws SQLException {
		 ClsBankReconciliationBean bean = new ClsBankReconciliationBean();
		 Connection conn = null;
		 
		try {
			conn = connDAO.getMyConnection();
			Statement stmtBRCN = conn.createStatement();
			
			String headersql="select if(m.dtype='BRCN','Bank Reconciliation','  ') vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
					+ "b.cstno from my_breconm m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='BRCN' "
					+ "and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSetHead = stmtBRCN.executeQuery(headersql);
			
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
			
			String sqls="select m.doc_no,DATE_FORMAT(m.date,'%d-%b-%Y') date,round(m.bookBal,2) bookBal,round(m.bankBal,2) bankBal,round(m.rvBal,2) rvBal,round(m.pvBal,2) pvBal,"
					+ "CONCAT(h.account,' - ',h.description) account,c.code currency,u.user_name from my_breconm m left join my_head h on m.acno=h.doc_no left join my_curr c on "
					+ "m.curId=c.doc_no left join my_user u on m.userid=u.doc_no where m.status=3 and m.dtype='BRCN' and m.brhid="+branch+" and m.doc_no="+docNo+"";
				
			ResultSet resultSets = stmtBRCN.executeQuery(sqls);
			
			while(resultSets.next()){
				
				bean.setLblvoucherno(resultSets.getString("doc_no"));
				bean.setLblaccountname(resultSets.getString("account"));
				bean.setLblcurrency(resultSets.getString("currency"));
				bean.setLbldate(resultSets.getString("date"));
		        bean.setLblunclearedreceipttotal(resultSets.getString("rvBal"));
		        bean.setLblunclearedpaymenttotal(resultSets.getString("pvBal"));
		        bean.setLblbookbalance(resultSets.getString("bookBal"));
		        bean.setLblunclearedpayments(resultSets.getString("pvBal"));
		        bean.setLblunclearedreceipts(resultSets.getString("rvBal"));
		        bean.setLblbankstatements(resultSets.getString("bankBal"));
				bean.setLblpreparedby(resultSets.getString("user_name"));
			}
			
			bean.setTxtheader(header);
			
			String sql = "";
			
			sql="select DATE_FORMAT(date,'%d-%b-%Y') date,dtype,doc_no,if(chqno=0,' ',chqno) chqno,if(credit=0,' ',round(credit,2)) receipts,if(debit=0,' ',round(debit,2)) payments from my_brecond where rdocno="+docNo+"  order by sr_no";
			
			ResultSet resultSet = stmtBRCN.executeQuery(sql);
			
			ArrayList<String> printarray= new ArrayList<String>();
			
			while(resultSet.next()){
				bean.setFirstarray(1); 
				String temp="";
				temp=resultSet.getString("date")+"::"+resultSet.getString("dtype")+"::"+resultSet.getString("doc_no")+"::"+resultSet.getString("chqno")+"::"+resultSet.getString("receipts")+"::"+resultSet.getString("payments");
			    printarray.add(temp);
			}

			request.setAttribute("printreconcilations", printarray);
			
			String sql2 = "";
		
			sql2="select DATE_FORMAT(date,'%d-%b-%Y') date,dtype,doc_no,if(chqno=0,' ',chqno) chqno,if(credit=0,' ',round(credit,2)) receipts from my_brecond where rdocno="+docNo+" and dtype='BRV' order by sr_no";
			
			ResultSet resultSet2 = stmtBRCN.executeQuery(sql2);
			
			ArrayList<String> printarray1= new ArrayList<String>();
			
			while(resultSet2.next()){
				bean.setFirstarray(1); 
				String temp="";
				temp=resultSet2.getString("date")+"::"+resultSet2.getString("dtype")+"::"+resultSet2.getString("doc_no")+"::"+resultSet2.getString("chqno")+"::"+resultSet2.getString("receipts");
				printarray1.add(temp);
			}

			request.setAttribute("printarrays", printarray1);
			
			String sql1 = "";
			
			sql1="select DATE_FORMAT(date,'%d-%b-%Y') date,dtype,doc_no,if(chqno=0,' ',chqno) chqno,if(debit=0,' ',round(debit,2)) payments from my_brecond where rdocno="+docNo+" and dtype='BPV' order by sr_no";
			
			System.out.println("sql1"+ sql1);
			
			ResultSet resultSet1 = stmtBRCN.executeQuery(sql1);
			
			ArrayList<String> printsecarray= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setSecarray(2); 
				String temp="";
				temp=resultSet1.getString("date")+"::"+resultSet1.getString("dtype")+"::"+resultSet1.getString("doc_no")+"::"+resultSet1.getString("chqno")+"::"+resultSet1.getString("payments");
				printsecarray.add(temp);
			}
			request.setAttribute("printingarray", printsecarray);
			
			String sql3 = "select max(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,max(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from my_breconm m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='BRCN' and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSet3 = stmtBRCN.executeQuery(sql3);
			
			while(resultSet3.next()){
				bean.setLblpreparedon(resultSet3.getString("preparedon"));
				bean.setLblpreparedat(resultSet3.getString("preparedat"));
			}
		
			stmtBRCN.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return bean;
	}

}
