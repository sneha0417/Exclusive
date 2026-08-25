package com.finance.transactions.cashreceipt;

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

public class ClsCashReceiptDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsCashReceiptBean cashReceiptBean = new ClsCashReceiptBean();
	
	  public int insert(Date cashReceiptDate, String formdetailcode, String txtrefno,double txtfromrate,String txtdescription, double txtdrtotal,double txtapplyinvoiceapply,
			  ArrayList<String> cashreceiptarray,ArrayList<String> applyinvoicearray, HttpSession session,HttpServletRequest request,String mode) throws SQLException {
		  
		  	Connection conn = null;
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			int total = 0;
			
			CallableStatement stmtCRV = conn.prepareCall("{CALL cashbmDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtCRV.registerOutParameter(10, java.sql.Types.INTEGER);
			stmtCRV.registerOutParameter(11, java.sql.Types.INTEGER);
			
			stmtCRV.setDate(1,cashReceiptDate);
			stmtCRV.setString(2,txtrefno);
			stmtCRV.setString(3,txtdescription);
			stmtCRV.setDouble(4,txtdrtotal);
			stmtCRV.setDouble(5,txtfromrate);
			stmtCRV.setString(6,formdetailcode);
			stmtCRV.setString(7,company);
			stmtCRV.setString(8,branch);
			stmtCRV.setString(9,userid);
			stmtCRV.setString(12,mode);
			int datas=stmtCRV.executeUpdate();
			if(datas<=0){
				stmtCRV.close();
				conn.close();
				return 0;
			}
			int docno=stmtCRV.getInt("docNo");
			int trno=stmtCRV.getInt("itranNo");
			request.setAttribute("tranno", trno);
			cashReceiptBean.setTxtcashreceiptdocno(docno);
			if (docno > 0) {
					/*Insertion to my_cashbd,my_jvtran,my_outd*/
					int insertData=insertion(conn, docno, trno, formdetailcode, cashReceiptDate, txtrefno, txtfromrate, txtdescription, txtdrtotal, txtapplyinvoiceapply, cashreceiptarray, applyinvoicearray, session,mode);
					if(insertData<=0){
						stmtCRV.close();
						conn.close();
						return 0;
					}
					/*Insertion to my_cashbd,my_jvtran,my_outd Ends*/
					
					String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno;
					ResultSet resultSet = stmtCRV.executeQuery(sql1);
					 while (resultSet.next()) {
					 total=resultSet.getInt("jvtotal");
					 }

					 if(total == 0){
						conn.commit();
						stmtCRV.close();
						conn.close();
						return docno;
					 }else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
					    stmtCRV.close();
					    return 0;
				    }
			}
			stmtCRV.close();
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
			
	
	public boolean edit(int txtcashreceiptdocno, String formdetailcode, Date cashReceiptDate,String txtrefno, String txtdescription, double txtfromrate, double txtdrtotal, int txttodocno, 
			int txttotrno, double txtapplyinvoiceapply, ArrayList<String> cashreceiptarray, ArrayList<String> applyinvoicearray,ArrayList<String> applyinvoiceupdatearray, HttpSession session,String mode) throws SQLException {
		 
			Connection conn = null;
			
		try{
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtCRV = conn.createStatement();
				
				if(mode.equalsIgnoreCase("EDIT")){
					mode="E";
				}
				int trno = txttotrno;
			    int trid = 0,total = 0,applydelete=0;
			    String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String company=session.getAttribute("COMPANYID").toString().trim();
				
				/*Updating my_cashbm*/
                String sql=("update my_cashbm set date='"+cashReceiptDate+"',RefNo='"+txtrefno+"',DESC1='"+txtdescription+"',mrate='"+txtfromrate+"',trMode=2,totalAmount='"+txtdrtotal+"',DTYPE='"+formdetailcode+"',cmpId='"+company+"',brhId='"+branch+"' where TR_NO='"+trno+"' and doc_no="+txtcashreceiptdocno);
                int data = stmtCRV.executeUpdate(sql);
				if(data<=0){
					conn.close();
					stmtCRV.close();
					return false;
				}
				/*Updating my_cashbm Ends*/
				
				/*Inserting into datalog*/
				String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtcashreceiptdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
				int datas = stmtCRV.executeUpdate(sqls);
				/*Inserting into datalog Ends*/
			    
			    String sql3=("DELETE FROM my_cashbd WHERE TR_NO="+trno);
			    int data3 = stmtCRV.executeUpdate(sql3);
			    
				 /*String sql2=("SELECT TRANID FROM my_jvtran where TR_NO="+trno+" and acno="+txttodocno+"");
				 ResultSet resultSet2 = stmtCRV.executeQuery(sql2);
				    
				 while (resultSet2.next()) {
				 trid=resultSet2.getInt("TRANID");
				 }
				 
				 String sql5=("DELETE FROM my_outd WHERE TRANID="+trid+"");
				 int data5 = stmtCRV.executeUpdate(sql5);*/
				 
			    ClsApplyDelete applyDelete = new ClsApplyDelete();
				applydelete=applyDelete.getFinanceApplyDelete(conn, trno);
				if(applydelete<0){
					System.out.println("*** ERROR IN APPLY DELETE ***");
					stmtCRV.close();
					conn.close();
					return false;
				}
				
				 String sql4=("DELETE FROM my_jvtran WHERE TR_NO="+trno+"");
				 int data4 = stmtCRV.executeUpdate(sql4);
				 
				 String sql6=("DELETE FROM my_costtran WHERE TR_NO="+trno+"");
				 int data6 = stmtCRV.executeUpdate(sql6);
				 
			    /*Apply-Invoicing Grid Updating
				for(int i=0;i< applyinvoiceupdatearray.size();i++){
				String[] applyupdate=applyinvoiceupdatearray.get(i).split("::");
                 
				if(!applyupdate[0].trim().equalsIgnoreCase("undefined") && !applyupdate[0].trim().equalsIgnoreCase("NaN")){
				String sql1="update my_jvtran set out_amount='"+(applyupdate[0].trim().equalsIgnoreCase("undefined") || applyupdate[0].trim().equalsIgnoreCase("NaN") || applyupdate[0].trim().isEmpty()?0:applyupdate[0].trim())+"' where TRANID='"+(applyupdate[1].trim().equalsIgnoreCase("undefined") || applyupdate[1].trim().equalsIgnoreCase("NaN") || applyupdate[1].trim().isEmpty()?0:applyupdate[1].trim())+"'";
				int data1 = stmtCRV.executeUpdate(sql1);
					if(data1<=0){
						stmtCRV.close();
						conn.close();
						return false;
					}
				 }
				}
				Apply-Invoicing Grid Updating Ends*/
			    
			    int docno=txtcashreceiptdocno;
				cashReceiptBean.setTxtcashreceiptdocno(docno);
				if (docno > 0) {
					/*Insertion to my_cashbd,my_jvtran,my_outd*/
					int insertData=insertion(conn, docno, trno, formdetailcode, cashReceiptDate, txtrefno, txtfromrate, txtdescription, txtdrtotal, txtapplyinvoiceapply, cashreceiptarray, applyinvoicearray, session,mode);
					if(insertData<=0){
						stmtCRV.close();
						conn.close();
						return false;
					}
					/*Insertion to my_cashbd,my_jvtran,my_outd Ends*/
					
					String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
					ResultSet resultSet = stmtCRV.executeQuery(sql1);
				    
					 while (resultSet.next()) {
					 total=resultSet.getInt("jvtotal");
					 }
					 
					 if(total == 0){
						conn.commit();
						stmtCRV.close();
						conn.close();
						return true;
					 }else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
					    stmtCRV.close();
					    return false;
				    }
				}
			stmtCRV.close();
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
	
	public boolean editMaster(int txtcashreceiptdocno, String formdetailcode, Date cashReceiptDate,String txtrefno, String txtdescription, double txtfromrate,
			double txtdrtotal, int txttodocno, int txttotrno, HttpSession session) throws SQLException {
			
		Connection conn = null;
			
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtCRV = conn.createStatement();
			
			int trno = txttotrno;
		    
		    String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			
			/*Updating my_cashbm*/
            String sql=("update my_cashbm set date='"+cashReceiptDate+"',RefNo='"+txtrefno+"',DESC1='"+txtdescription+"',mrate='"+txtfromrate+"',trMode=2,totalAmount='"+txtdrtotal+"',DTYPE='"+formdetailcode+"',cmpId='"+company+"',brhId='"+branch+"' where TR_NO='"+trno+"' and doc_no="+txtcashreceiptdocno+"");
			int data = stmtCRV.executeUpdate(sql);
			if(data<=0){
				stmtCRV.close();
				conn.close();
				return false;
			}
			/*Updating my_cashbm Ends*/
			
			/*Inserting into datalog*/
			String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtcashreceiptdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
			int resultSets = stmtCRV.executeUpdate(sqls);
			/*Inserting into datalog Ends*/
			
			conn.commit();
			stmtCRV.close();
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


	public boolean delete(int txtcashreceiptdocno, String formdetailcode, int txttotrno, int txttodocno, HttpSession session) throws SQLException {
		
		Connection conn = null; 
		try{
			    conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtCRV = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				int trno = txttotrno,applydelete=0;
				
				/*int ap_trid=0;
				double amount=0.00,outamount=0.00;
				String checkingApplying="0";
				
				  String sqlApply = "SELECT * FROM my_jvtran where out_amount!=0 and TR_NO="+trno+"";
				  ResultSet resultSetsApply=stmtCRV.executeQuery(sqlApply);
				  
				  while(resultSetsApply.next()){
					  checkingApplying="1";
				  }
				  
				  if(checkingApplying.equalsIgnoreCase("1")) {
				  
				 Selecting Tran-Id
				  ArrayList<String> tranidarray=new ArrayList<>();
				  String sql1="SELECT TRANID FROM my_jvtran where TR_NO="+trno+" and acno="+txttodocno+"";
				  ResultSet resultSet=stmtCRV.executeQuery(sql1);
				  
				  while(resultSet.next()){
				   tranidarray.add(resultSet.getString("tranid"));
				  }
				  Selecting Tran-Id Ends
				  
				  Selecting Ap_Tran-Id
				  ArrayList<String> outamtarray=new ArrayList<>();

				  for(int i=0;i<tranidarray.size();i++){
				   String sql2="select ap_trid,amount from my_outd where tranid="+tranidarray.get(i)+"";
				   ResultSet resultSet1=stmtCRV.executeQuery(sql2);
				   
				   while(resultSet1.next()){
				    outamtarray.add(resultSet1.getInt("ap_trid")+"::"+resultSet1.getDouble("amount"));
				   } 

				  }
				  Selecting Ap_Tran-Id

				  for(int i=0;i<outamtarray.size();i++){
				   
				   ap_trid=Integer.parseInt(outamtarray.get(i).split("::")[0]);
				   amount=Double.parseDouble(outamtarray.get(i).split("::")[1]);

				   String sql4="update my_jvtran set out_amount=out_amount-("+amount+"*id) where tranid="+ap_trid+"";
				   int data1=stmtCRV.executeUpdate(sql4);
				   
				  }
				Apply-Invoicing Grid Updating Ends
				  
			    Selecting outamount
			     String sql5="select sum(amount) outamount from my_outd where tranid="+tranidarray.get(0)+"";
			     ResultSet resultSet2=stmtCRV.executeQuery(sql5);
			   
			     while(resultSet2.next()){
				   outamount= resultSet2.getDouble("outamount");
			     }
			    Selecting outamount Ends
			   
			     String sql4="update my_jvtran set out_amount=out_amount-("+outamount+"*id) where tranid="+tranidarray.get(0)+"";
			     int data3=stmtCRV.executeUpdate(sql4);
				   
				 Deleting from my_outd
				  String sql3="delete from my_outd where tranid="+tranidarray.get(0)+"";
				  int data2=stmtCRV.executeUpdate(sql3);
				 Deleting from my_outd Ends
				 
				 }*/
				
				ClsApplyDelete applyDelete = new ClsApplyDelete();
				applydelete=applyDelete.getFinanceApplyDelete(conn, trno);
				if(applydelete<0){
					System.out.println("*** ERROR IN APPLY DELETE ***");
					stmtCRV.close();
					conn.close();
					return false;
				}
				 
				/*Status change in my_cashbm*/
				 String sql6=("update my_cashbm set STATUS=7 where doc_no="+txtcashreceiptdocno+" and TR_NO="+trno+"");
				 int data4 = stmtCRV.executeUpdate(sql6);
				 if(data4<=0){
						stmtCRV.close();
						conn.close();
						return false;
					  }
				/*Status change in my_cashbm Ends*/

				 /*Status change in my_jvtran*/
				 String sql7=("update my_jvtran set STATUS=7 where doc_no="+txtcashreceiptdocno+" and TR_NO="+trno+"");
				 int data5 = stmtCRV.executeUpdate(sql7);
				 if(data5<=0){
						stmtCRV.close();
						conn.close();
						return false;
					  }
				/*Status change in my_jvtran Ends*/
				 
				 /*Inserting into datalog*/
				 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtcashreceiptdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','D')");
				 int datas = stmtCRV.executeUpdate(sqls);
				 /*Inserting into datalog Ends*/
				
				 int docno=txtcashreceiptdocno;
				 cashReceiptBean.setTxtcashreceiptdocno(docno);
				 if (docno > 0) {
					conn.commit();
					stmtCRV.close();
				    conn.close();
					return true;
				}	
			stmtCRV.close();
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
	
	public JSONArray applyInvoicingGrid(String accountno,String atype,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtCRV = conn.createStatement();
				
				String condition="",sql="",joins="",casestatement="";
            	
				if(!(atype==null || atype.equalsIgnoreCase(""))){
					if(atype.equalsIgnoreCase("AR")){
						condition="and t1.dramount > 0";
					}
					else if(atype.equalsIgnoreCase("AP")){
						condition="and t1.dramount < 0";
					}
				}
				
				joins=commonDAO.getFinanceVocTablesJoins(conn);
        		casestatement=commonDAO.getFinanceVocTablesCase(conn);
				
				sql = "Select "+casestatement+"a.transType, a.description, a.date, a.tramt, a.out_amount, a.tranid, a.acno, a.currency from ("
					+ "Select t1.doc_no transno,t1.acno,t1.tranid,t1.date,t1.out_amount,t1.dtype transType,t1.curid currency,t1.description,"
            		+ "(t1.dramount- t1.out_amount)*id tramt,t1.brhid from my_jvtran t1 inner join my_brch b on t1.brhId=b.doc_no inner join my_head h on "
            		+ "t1.acno=h.doc_no where t1.status=3 and t1.acno="+accountno+" "+condition+" and (t1.dramount - out_amount) != 0 group by t1.tranid) a"+joins+"";
						
				ResultSet resultSet = stmtCRV.executeQuery(sql);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtCRV.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray applyInvoicingGridReloading(String trno,String accountno,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
        Connection conn = null;
		
        try {
				conn = connDAO.getMyConnection();
				Statement stmtCRV = conn.createStatement();
				
				String joins="",casestatement="";
				
				if(!(trno.trim().equalsIgnoreCase("0")||trno.trim().equalsIgnoreCase("") && accountno.trim().equalsIgnoreCase("0")||accountno.trim().equalsIgnoreCase(""))){
            	
				joins=commonDAO.getFinanceVocTablesJoins(conn);
        		casestatement=commonDAO.getFinanceVocTablesCase(conn);
				
				String sql="Select "+casestatement+"a.transType, a.description, a.date, a.tramt, a.applying, a.balance, a.out_amount, a.tranid, a.acno, a.currency from ("
						+ "select t.doc_no transno,t.dtype transType,t.description description,t.date date,((t.dramount*t.id)-(t.out_amount*t.id)+d.amount) tramt,"
						+ "d.amount applying,((t.dramount*t.id)-(t.out_amount*t.id)) balance,t.out_amount,t.tranid,t.acno,t.curId currency,t.brhid from my_outd d left join my_jvtran t on "
						+ "d.ap_trid=t.tranid where d.tranid=(SELECT tranid FROM my_jvtran where TR_NO='"+trno+"' and acno='"+accountno+"')) a"+joins+"";
				
				ResultSet resultSet = stmtCRV.executeQuery(sql);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				}
					
				stmtCRV.close();
				conn.close();	
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	
	public JSONArray cashReceiptGridReloading(HttpSession session,String docNo,String check) throws SQLException {
        
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
				Statement stmtCRV = conn.createStatement();
			
				String sqlnew=("SELECT m.date,m.RefNo,t.doc_no docno,t.atype type,t.account accounts,t.description accountname1,t.gr_type grtype,c.code currency,c.type currencytype,"
						+ "d.curId currencyid,d.rate rate,if(d.dr<0,true,false)  dr,(d.AMOUNT*d.dr) amount1,(d.lamount*d.dr) baseamount1,d.description,d.SR_NO sr_no,"
						+ "d.costtype,d.costcode,f.costgroup FROM my_cashbm m left join my_cashbd d on m.tr_no=d.tr_no left join my_costunit f on d.costtype=f.costtype "
						+ "left join my_head t on d.acno=t.doc_no left join my_curr c on c.doc_no=d.curId WHERE m.dtype='CRV' and m.brhId="+branch+" and m.doc_no="+docNo+" "
						+ "and d.SR_NO>1");
				
				ResultSet resultSet = stmtCRV.executeQuery(sqlnew);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtCRV.close();
				conn.close();

		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return RESULTDATA;
    }
	
	public JSONArray cashReceiptGridSearch(String type,String accountno,String accountname,String currency,String date,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
		if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
		
        Connection conn = null; 
       
	     try {
		       conn = connDAO.getMyConnection();
		       Statement stmtCRV = conn.createStatement();
	
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
		        
		        sql="select t.doc_no,t.account,t.description,t.gr_type,c.code curr,c.doc_no curid,c.type,cb.rate c_rate from my_head t left join my_curr c "
							+ "on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,"
							+ "cr.frmDate from my_curbook cr where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo "
							+ "on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where t.atype='"+type+"' and t.m_s=0"+sqltest;
		        
		       ResultSet resultSet = stmtCRV.executeQuery(sql);
		       RESULTDATA=commonDAO.convertToJSON(resultSet);
	           
		        stmtCRV.close();
			    conn.close();
	     } catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     } finally{
				conn.close();
		 }
	       return RESULTDATA;
	  }
	
	 public JSONArray crvMainSearch(HttpSession session,String partyname,String docNo,String date,String amount,String check) throws SQLException {

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
		        Statement stmtCRV = conn.createStatement();
		        	
		        java.sql.Date sqlReceiptDate=null;
		        
		        date.trim();
		        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
		        {
		        sqlReceiptDate = commonDAO.changeStringtoSqlDate(date);
		        }

		        String sqltest="";
		        
		        if(!(docNo.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and m.doc_no like '%"+docNo+"%'";
		        }
		        
		        if(!(partyname.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and if(h.description is null,h1.description,h.description) like '%"+partyname+"%'";
		        }
		        
		        if(!(amount.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and m.totalAmount like '%"+amount+"%'";
		        }
		        
		        if(!(sqlReceiptDate==null)){
			         sqltest=sqltest+" and m.date='"+sqlReceiptDate+"'";
			    } 
		        
		       String sql= "select m.date,m.doc_no,m.totalAmount amount,if(h.description is null,h1.description,h.description) description from  my_cashbm m "
	       		+ "left join my_cashbd d on m.tr_no=d.tr_no and d.sr_no=1 left join my_cashbd d1 on m.tr_no=d1.tr_no and d1.sr_no=2 left join my_head h on d.acno=h.doc_no left join my_head h1 on d1.acno=h1.doc_no left join my_brch b on m.brhid=b.doc_no where "
	       		+ "m.brhid="+branch+" and m.dtype='CRV' and m.status <> 7"+sqltest;
		       
		       ResultSet resultSet = stmtCRV.executeQuery(sql);
		       RESULTDATA=commonDAO.convertToJSON(resultSet);
		       
		       stmtCRV.close();
		       conn.close();
	     } catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     } finally{
				conn.close();
			}
	        return RESULTDATA;
	  }
	
	 public ClsCashReceiptBean getViewDetails(HttpSession session,int docNo) throws SQLException {
		
		ClsCashReceiptBean cashReceiptBean = new ClsCashReceiptBean();
		
		Connection conn = null;
		
		try {
		
			conn = connDAO.getMyConnection();
			Statement stmtCRV = conn.createStatement();
			
			String branch = session.getAttribute("BRANCHID").toString();
			
			ResultSet resultSet = stmtCRV.executeQuery("SELECT m.date,m.RefNo,m.totalAmount,t.atype,t.account,t.description,t.doc_no accno,d.curId,d.rate,d.dr,(d.AMOUNT*d.dr) AMOUNT,"
				+ "(d.lamount*d.dr) lamount,m.DESC1,sum(o.AMOUNT) appliedamount,round(((d.AMOUNT*d.dr)-sum(o.AMOUNT)),2) appliedbalanceamount,d.SR_NO,d.TR_NO,j.tranid,c.type FROM my_cashbm m left join my_cashbd d on m.tr_no=d.tr_no left join my_jvtran j "
				+ "on d.tr_no=j.tr_no  left join my_outd o on o.tranid=j.tranid left join my_head t on d.acno=t.doc_no left join my_curr c on d.curId=c.doc_no WHERE m.dtype='CRV' and m.status<>7 and "
				+ "m.brhId='"+branch+"' and m.doc_no="+docNo+" group by account");
	
			while (resultSet.next()) {
					cashReceiptBean.setTxtcashreceiptdocno(docNo);
					cashReceiptBean.setJqxCashReceiptDate(resultSet.getDate("date").toString());
					cashReceiptBean.setTxtrefno(resultSet.getString("RefNo"));
					cashReceiptBean.setTxttotranid(resultSet.getInt("tranid"));
					cashReceiptBean.setTxttotrno(resultSet.getInt("TR_NO"));
				
				if(resultSet.getString("SR_NO").trim().equalsIgnoreCase("0")){
					cashReceiptBean.setTxtfromdocno(resultSet.getInt("accno"));
					cashReceiptBean.setTxtfromaccid(resultSet.getString("account"));
					cashReceiptBean.setTxtfromaccname(resultSet.getString("description"));
					cashReceiptBean.setHidcmbfromcurrency(resultSet.getString("curId"));
					cashReceiptBean.setHidfromcurrencytype(resultSet.getString("type"));
					cashReceiptBean.setTxtfromrate(resultSet.getDouble("rate"));
					cashReceiptBean.setTxtfromamount(resultSet.getDouble("AMOUNT"));
					cashReceiptBean.setTxtfrombaseamount(resultSet.getDouble("lamount"));
					cashReceiptBean.setTxtdescription(resultSet.getString("DESC1"));
				}
				
				else if(resultSet.getString("SR_NO").trim().equalsIgnoreCase("1")){
					cashReceiptBean.setTxttodocno(resultSet.getInt("accno"));
					cashReceiptBean.setHidcmbtotype(resultSet.getString("atype"));
					cashReceiptBean.setTxttoaccid(resultSet.getString("account"));
					cashReceiptBean.setTxttoaccname(resultSet.getString("description"));
					cashReceiptBean.setHidcmbtocurrency(resultSet.getString("curId"));
					cashReceiptBean.setHidtocurrencytype(resultSet.getString("type"));
					cashReceiptBean.setTxttorate(resultSet.getDouble("rate"));
					cashReceiptBean.setTxttoamount(resultSet.getDouble("AMOUNT"));
					cashReceiptBean.setTxttobaseamount(resultSet.getDouble("lamount"));
					
					cashReceiptBean.setTxtapplyinvoiceamt(resultSet.getDouble("AMOUNT"));
					cashReceiptBean.setTxtapplyinvoiceapply(resultSet.getDouble("appliedamount"));
					cashReceiptBean.setTxtapplyinvoicebalance(resultSet.getDouble("appliedbalanceamount"));
				}
					cashReceiptBean.setTxtdrtotal(resultSet.getDouble("totalAmount"));
					cashReceiptBean.setTxtcrtotal(resultSet.getDouble("totalAmount"));
					cashReceiptBean.setMaindate(resultSet.getDate("date").toString());
		    }
		stmtCRV.close();
		conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return cashReceiptBean;
		}
	 
	public ClsCashReceiptBean getPrint(HttpServletRequest request,int docNo,int branch,int header) throws SQLException {
		 ClsCashReceiptBean bean = new ClsCashReceiptBean();
		 Connection conn = null;
		 
		try {
			
			conn = connDAO.getMyConnection();
			Statement stmtCRV = conn.createStatement();
			
			int trno=0;
			int acno=0;
			int srno=0;
			
			String headersql="select if(m.dtype='CRV','Cash Receipt','  ') vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.tinno,b.stcno,"
					+ "b.cstno from my_cashbm m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='CRV' "
					+ "and m.brhid="+branch+" and m.doc_no="+docNo+"";
				
				ResultSet resultSetHead = stmtCRV.executeQuery(headersql);
				
				while(resultSetHead.next()){
					bean.setLblcomptrn(resultSetHead.getString("tinno"));
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
			
				String sqls="select m.doc_no,DATE_FORMAT(m.date ,'%d-%m-%Y') date,m.desc1,format(round(m.totalAmount,2),2) netAmount,u.user_name from my_cashbm m left join my_user u on "
						+ "m.userid=u.doc_no where m.dtype='CRV' and m.brhid="+branch+" and m.doc_no="+docNo+"";
					
				ResultSet resultSets = stmtCRV.executeQuery(sqls);
				
				while(resultSets.next()){
					
					bean.setLblvoucherno(resultSets.getString("doc_no"));
					bean.setLbldescription(resultSets.getString("desc1"));
					bean.setLbldate(resultSets.getString("date"));
					bean.setLbldebittotal(resultSets.getString("netAmount"));
					bean.setLblcredittotal(resultSets.getString("netAmount"));
					bean.setLblpreparedby(resultSets.getString("user_name"));
				}
				
				bean.setTxtheader(header);
			
			String sql="select format(round(m.totalAmount,2),2) netAmount,round(m.totalAmount,2) netAmountWords,h.description,d.acno,m.tr_no from my_cashbm m left join my_cashbd d on m.tr_no=d.tr_no left join my_head h on "
				+ "d.acno=h.doc_no where m.dtype='CRV' and d.sr_no=1 and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSet = stmtCRV.executeQuery(sql);
			
			ClsAmountToWords c = new ClsAmountToWords();
			
			while(resultSet.next()){
				srno=1;
				
				trno=resultSet.getInt("tr_no");
				acno=resultSet.getInt("acno");
				
				bean.setLblname(resultSet.getString("description"));
				bean.setLblnetamount(resultSet.getString("netAmount"));
				bean.setLblnetamountwords(c.convertAmountToWords(resultSet.getString("netAmountWords")));
			}
			
			if(srno==0){
				String sqld="select format(round(m.totalAmount,2),2) netAmount,round(m.totalAmount,2) netAmountWords,h.description,d.acno,m.tr_no from my_cashbm m left join my_cashbd d on m.tr_no=d.tr_no left join my_head h on "
						+ "d.acno=h.doc_no where m.dtype='CRV' and d.sr_no=2 and m.brhid="+branch+" and m.doc_no="+docNo+"";
					
						ResultSet resultSet1 = stmtCRV.executeQuery(sqld);
						
						while(resultSet1.next()){
							trno=resultSet1.getInt("tr_no");
							acno=resultSet1.getInt("acno");
							
							bean.setLblname(resultSet1.getString("description"));
							bean.setLblnetamount(resultSet1.getString("netAmount"));
							bean.setLblnetamountwords(c.convertAmountToWords(resultSet1.getString("netAmountWords")));
							
						}
			}
			
			if(srno==1){
			
			String sql2 = "",joins="",casestatement="";

			joins=commonDAO.getFinanceVocTablesJoins(conn);
        	casestatement=commonDAO.getFinanceVocTablesCase(conn);
	
			sql2="Select "+casestatement+"a.transtype, a.description, a.date, format(a.tramt,2) tramt, format(a.applying,2) applying, format(a.balance,2) balance from (select t.doc_no transno,t.dtype transType,t.description description,DATE_FORMAT(t.date,'%d-%m-%Y') date,round(((t.dramount*t.id)-(t.out_amount*t.id)+d.amount),2) tramt,"
				+ "round(d.amount,2) applying,round(((t.dramount*t.id)-(t.out_amount*t.id)),2) balance,t.out_amount,t.tranid,t.acno,t.curId currency,t.brhid from my_outd d left join my_jvtran t on "
				+ "d.ap_trid=t.tranid where d.tranid=(SELECT tranid FROM my_jvtran where TR_NO='"+trno+"' and acno='"+acno+"')) a"+joins+"";
				
			ResultSet resultSet2 = stmtCRV.executeQuery(sql2);
			
			ArrayList<String> printapply= new ArrayList<String>();
			
			while(resultSet2.next()){
				bean.setFirstarray(1);

				String temp="";
				temp=resultSet2.getString("transno")+"::"+resultSet2.getString("transtype")+"::"+resultSet2.getString("date")+"::"+resultSet2.getString("description")+"::"+resultSet2.getString("tramt")+"::"+resultSet2.getString("applying")+"::"+resultSet2.getString("balance");
				printapply.add(temp);
			}
			bean.setApplyquery(sql2);
			request.setAttribute("printapplying", printapply);
			System.out.println("sql2---"+sql2);
			}
			
			String sql1 = "";

			sql1="SELECT t.account,t.description accountname,if(d.description='0','  ',d.description) description,c.code currency,if(d.amount>0,format(round((d.amount*1),2),2),'  ') debit,if(d.amount<0,format(round((d.amount*-1),2),2),' ') credit FROM my_cashbm m left join my_cashbd d on m.tr_no=d.tr_no "
						+ "left join my_head t on d.acno=t.doc_no left join my_curr c on c.doc_no=d.curId WHERE m.dtype='CRV' and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSet1 = stmtCRV.executeQuery(sql1);
			
			ArrayList<String> printarray= new ArrayList<String>();
			
			while(resultSet1.next()){

				bean.setSecarray(2); 
				String temp="";
				temp=resultSet1.getString("account")+"::"+resultSet1.getString("accountname")+"::"+resultSet1.getString("description")+"::"+resultSet1.getString("currency")+"::"+resultSet1.getString("debit")+"::"+resultSet1.getString("credit");
			    printarray.add(temp);
			}
			request.setAttribute("printingarray", printarray);
			
			String sql3 = "select min(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,min(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from my_cashbm m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='CRV' and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSet3 = stmtCRV.executeQuery(sql3);
			
			while(resultSet3.next()){
				bean.setLblpreparedon(resultSet3.getString("preparedon"));
				bean.setLblpreparedat(resultSet3.getString("preparedat"));
			}
			
			stmtCRV.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return bean;
	}
	 
	 public int insertion(Connection conn,int docno,int trno,String formdetailcode,Date cashReceiptDate, String txtrefno, double txtfromrate, 
			 String txtdescription, double txtdrtotal, double txtapplyinvoiceapply,ArrayList<String> cashreceiptarray,ArrayList<String> applyinvoicearray,
			 HttpSession session,String mode) throws SQLException{

		  try{
				conn.setAutoCommit(false);
				CallableStatement stmtCRV;
				Statement stmtCRV1 = conn.createStatement();

				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				/*Cash Receipt Grid and Details Saving*/
				for(int i=0;i< cashreceiptarray.size();i++){
					String[] cashreceipt=cashreceiptarray.get(i).split("::");
					if(!cashreceipt[0].trim().equalsIgnoreCase("undefined") && !cashreceipt[0].trim().equalsIgnoreCase("NaN")){
					
					int cash = 0;
					int id = 0;
					if(cashreceipt[3].trim().equalsIgnoreCase("true")){
						cash=0;
						id=-1;
					}
					else if(cashreceipt[3].trim().equalsIgnoreCase("false")){
						cash=1;
						id=1;
					}
					
					stmtCRV = conn.prepareCall("{CALL cashbdDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					/*Insertion to my_cashbd*/
					stmtCRV.setInt(19,trno); 
					stmtCRV.setInt(20,docno);
					stmtCRV.registerOutParameter(21, java.sql.Types.INTEGER);
					stmtCRV.setInt(1,i); //SR_NO
					stmtCRV.setString(2,(cashreceipt[0].trim().equalsIgnoreCase("undefined") || cashreceipt[0].trim().equalsIgnoreCase("NaN") || cashreceipt[0].trim().isEmpty()?0:cashreceipt[0].trim()).toString());  //doc_no of my_head
					stmtCRV.setString(3,(cashreceipt[1].trim().equalsIgnoreCase("undefined") || cashreceipt[1].trim().equalsIgnoreCase("NaN") || cashreceipt[1].trim().isEmpty()?0:cashreceipt[1].trim()).toString()); //curId
					stmtCRV.setString(4,(cashreceipt[2].trim().equalsIgnoreCase("undefined") || cashreceipt[2].trim().equalsIgnoreCase("NaN") || cashreceipt[2].trim().equals(0) || cashreceipt[2].trim().isEmpty()?1:cashreceipt[2].trim()).toString()); //rate 
					stmtCRV.setInt(5,id); //#credit -1 / debit 1 
					stmtCRV.setString(6,(cashreceipt[4].trim().equalsIgnoreCase("undefined") || cashreceipt[4].trim().equalsIgnoreCase("NaN") || cashreceipt[4].trim().isEmpty()?0:cashreceipt[4].trim()).toString()); //amount
					stmtCRV.setString(7,(cashreceipt[5].trim().equalsIgnoreCase("undefined") || cashreceipt[5].trim().equalsIgnoreCase("NaN") || cashreceipt[5].trim().isEmpty()?0:cashreceipt[5].trim()).toString()); //description
					stmtCRV.setString(8,(cashreceipt[6].trim().equalsIgnoreCase("undefined") || cashreceipt[6].trim().equalsIgnoreCase("NaN") || cashreceipt[6].trim().isEmpty()?0:cashreceipt[6].trim()).toString()); //baseamount
					stmtCRV.setInt(9,cash); //For cash = 0/ party = 1
					stmtCRV.setString(10,(cashreceipt[8].trim().equalsIgnoreCase("undefined") || cashreceipt[8].trim().equalsIgnoreCase("NaN") || cashreceipt[8].trim().equalsIgnoreCase("") || cashreceipt[8].trim().equalsIgnoreCase("0") || cashreceipt[8].trim().isEmpty()?"0":cashreceipt[8].trim()).toString()); //Cost type
					stmtCRV.setString(11,(cashreceipt[9].trim().equalsIgnoreCase("undefined") || cashreceipt[9].trim().equalsIgnoreCase("NaN") || cashreceipt[9].trim().equalsIgnoreCase("") || cashreceipt[9].trim().equalsIgnoreCase("0")|| cashreceipt[9].trim().isEmpty()?"0":cashreceipt[9].trim()).toString()); //Cost Code
					/*my_cashbd Ends*/
					
					/*Insertion to my_jvtran*/
					stmtCRV.setDate(12,cashReceiptDate);
					stmtCRV.setString(13,txtrefno);
					stmtCRV.setInt(14,id);  //id
					stmtCRV.setString(15,(cashreceipt[7].trim().equalsIgnoreCase("undefined") || cashreceipt[7].trim().equalsIgnoreCase("NaN") || cashreceipt[7].trim().isEmpty()?0:cashreceipt[7].trim()).toString());  //out-amount
					/*my_jvtran Ends*/
					
					stmtCRV.setString(16,formdetailcode);
					stmtCRV.setString(17,branch);
					stmtCRV.setString(18,userid);
					stmtCRV.setString(22,mode);
					int detail=stmtCRV.executeUpdate();
						if(detail<=0){
							stmtCRV.close();
							conn.close();
							return 0;
						}
	  				  }
				    }
				    /*Cash Receipt Grid and Details Saving Ends*/
				
					/*Apply-Invoicing Grid Saving*/
					for(int i=0;i< applyinvoicearray.size();i++){
					String[] apply=applyinvoicearray.get(i).split("::");
					if(!apply[0].trim().equalsIgnoreCase("undefined") && !apply[0].trim().equalsIgnoreCase("NaN")){
					
					stmtCRV = conn.prepareCall("{CALL applyInvoicingDML(?,?,?,?,?,?,?)}");
					/*Insertion to my_outd*/
					stmtCRV.setString(1,(apply[1].trim().equalsIgnoreCase("undefined") || apply[1].trim().equalsIgnoreCase("NaN") || apply[1].trim().isEmpty()?0:apply[1].trim()).toString()); //Out amount
					stmtCRV.setString(2,(apply[0].trim().equalsIgnoreCase("undefined") || apply[0].trim().equalsIgnoreCase("NaN") || apply[0].trim().isEmpty()?0:apply[0].trim()).toString()); //Applied amount
					stmtCRV.setString(3,(apply[2].trim().equalsIgnoreCase("undefined") || apply[2].trim().equalsIgnoreCase("NaN") || apply[2].trim().isEmpty()?0:apply[2].trim()).toString()); //Currency
					stmtCRV.setInt(4,trno);  //tr_no
					stmtCRV.setInt(5,Integer.parseInt((apply[3].trim().equalsIgnoreCase("undefined") || apply[3].trim().equalsIgnoreCase("NaN") || apply[3].trim().isEmpty()?0:apply[3].trim()).toString())); //tranid
					stmtCRV.setInt(6,Integer.parseInt((apply[4].trim().equalsIgnoreCase("undefined") || apply[4].trim().equalsIgnoreCase("NaN") || apply[4].trim().isEmpty()?0:apply[4].trim()).toString())); //account
					stmtCRV.setString(7,mode);	
					/*Apply-Invoicing Grid Saving Ends*/
					int applyreceiptcheck=stmtCRV.executeUpdate();
						if(applyreceiptcheck<=0){
							stmtCRV.close();
							return 0;
						}
						stmtCRV.close();
					 }
				}	
				
					int trid=0,id = 0;
					/*Selecting Tran-Id & Id*/
					String sqls=("select j.TRANID,j.ID from my_jvtran j inner join my_cashbd d on (d.acno =j.acno and d.tr_no =j.tr_no and d.sr_no=1) where j.tr_no="+trno);
					ResultSet resultSets = stmtCRV1.executeQuery(sqls);
					    
					 while (resultSets.next()) {
						 trid=resultSets.getInt("TRANID");
					     id=resultSets.getInt("ID");
					 }
					 /*Selecting Tran-Id & Id Ends*/
					
					/*Updating my_jvtran*/
					String sql3=("update my_jvtran set out_amount="+(txtapplyinvoiceapply)*id+" where tranid="+trid);
					int data3 = stmtCRV1.executeUpdate(sql3);
					if(data3<=0){
						stmtCRV1.close();
						conn.close();
						return 0;
					}
					/*Updating my_jvtran Ends*/
					
					/*Deleting account of value zero*/
					String sql2=("DELETE FROM my_jvtran where TR_NO="+trno+" and acno=0");
				    int data = stmtCRV1.executeUpdate(sql2);
				     
				    String sql4=("DELETE FROM my_cashbd where TR_NO="+trno+" and acno=0");
				    int data1 = stmtCRV1.executeUpdate(sql4);
				     /*Deleting account of value zero ends*/
					
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}

}
