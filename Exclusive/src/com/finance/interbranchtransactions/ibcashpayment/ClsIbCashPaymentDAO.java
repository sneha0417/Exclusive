package com.finance.interbranchtransactions.ibcashpayment;

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

public class ClsIbCashPaymentDAO {
    
	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsIbCashPaymentBean ibCashPaymentBean = new ClsIbCashPaymentBean();
	
	  public int insert(Date ibCashPaymentDate, String formdetailcode, String txtrefno,double txtfromrate,String txtdescription, double txtdrtotal,double txtapplyinvoiceapply, 
			  ArrayList<String> ibcashpaymentarray,ArrayList<String> applyibinvoicearray, HttpSession session,HttpServletRequest request,String mode) 
			  throws SQLException {
		  
		  Connection conn = null;
		  
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			int total = 0;
			
			CallableStatement stmtICPV = conn.prepareCall("{CALL cashbmDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtICPV.registerOutParameter(10, java.sql.Types.INTEGER);
			stmtICPV.registerOutParameter(11, java.sql.Types.INTEGER);
			stmtICPV.setDate(1,ibCashPaymentDate);
			stmtICPV.setString(2,txtrefno);
			stmtICPV.setString(3,txtdescription);
			stmtICPV.setDouble(4,txtdrtotal);
			stmtICPV.setDouble(5,txtfromrate);
			stmtICPV.setString(6,formdetailcode);
			stmtICPV.setString(7,company);
			stmtICPV.setString(8,branch);
			stmtICPV.setString(9,userid);
			stmtICPV.setString(12,mode);
			int datas=stmtICPV.executeUpdate();
			if(datas<=0){
				stmtICPV.close();
				conn.close();
				return 0;
			}
			int docno=stmtICPV.getInt("docNo");
			int trno=stmtICPV.getInt("itranNo");
			request.setAttribute("tranno", trno);
			ibCashPaymentBean.setTxtibcashpaydocno(docno);
			if (docno > 0) {
				/*Insertion to my_cashbd,my_jvtran,my_outd*/
				int insertData=insertion(conn, docno, trno, formdetailcode, ibCashPaymentDate, txtrefno, txtfromrate, txtdescription, txtdrtotal, txtapplyinvoiceapply,ibcashpaymentarray, applyibinvoicearray, session, mode);
				if(insertData<=0){
					stmtICPV.close();
					conn.close();
					return 0;
				}
				/*Insertion to my_cashbd,my_jvtran,my_outd Ends*/
				
				String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
				ResultSet resultSet = stmtICPV.executeQuery(sql1);
			    
				 while (resultSet.next()) {
				 total=resultSet.getInt("jvtotal");
				 }

				 if(total == 0){
					conn.commit();
					stmtICPV.close();
					conn.close();
					return docno;
				 }else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
					    stmtICPV.close();
					    return 0;
				    }
			}
		 stmtICPV.close();
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
			
	
	public boolean edit(int txtibcashpaydocno, String formdetailcode, Date ibCashPaymentDate,String txtrefno, String txtdescription, double txtfromrate, double txtdrtotal,
			int txttodocno, int txttotrno, double txtapplyinvoiceapply, ArrayList<String> ibcashpaymentarray, ArrayList<String> applyibinvoicearray,ArrayList<String> applyinvoiceibupdatearray, 
			HttpSession session,String mode) throws SQLException {
		
		 Connection conn = null;
		 
		 try{
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtICPV = conn.createStatement ();
				
				if(mode.equalsIgnoreCase("EDIT")){
					mode="E";
				}
				
				int trno = txttotrno,trid = 0,total = 0;
			    String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String company=session.getAttribute("COMPANYID").toString().trim();
				
				/*Updating my_cashbm*/
                String sql=("update my_cashbm set date='"+ibCashPaymentDate+"',RefNo='"+txtrefno+"',DESC1='"+txtdescription+"',mrate='"+txtfromrate+"',trMode=2,totalAmount='"+txtdrtotal+"',DTYPE='"+formdetailcode+"',cmpId='"+company+"',brhId='"+branch+"' where TR_NO='"+trno+"' and doc_no="+txtibcashpaydocno);
                int data = stmtICPV.executeUpdate(sql);
				if(data<=0){
					stmtICPV.close();
					conn.close();
					return false;
				}
				/*Updating my_cashbm Ends*/
				
				/*Inserting into datalog*/
				String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtibcashpaydocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
				int datas = stmtICPV.executeUpdate(sqls);
				/*Inserting into datalog Ends*/
			    
			    String sql1=("DELETE FROM my_cashbd WHERE TR_NO="+trno);
			    int data1 = stmtICPV.executeUpdate(sql1);
			    
				 String sql2=("SELECT TRANID FROM my_jvtran where TR_NO="+trno+" and acno="+txttodocno);
				 ResultSet resultSet2 = stmtICPV.executeQuery(sql2);
				    
				 while (resultSet2.next()) {
				 trid=resultSet2.getInt("TRANID");
				 }
				    
				 String sql3=("DELETE FROM my_outd WHERE TRANID="+trid);
				 int data3 = stmtICPV.executeUpdate(sql3);
				 
				 String sql4=("DELETE FROM my_jvtran WHERE TR_NO="+trno);
				 int data4 = stmtICPV.executeUpdate(sql4);
				 
				 String sql5=("DELETE FROM my_costtran WHERE TR_NO="+trno);
				 int data5 = stmtICPV.executeUpdate(sql5);
			    
			    /*Apply-Invoicing Grid Updating*/
				for(int i=0;i< applyinvoiceibupdatearray.size();i++){
				String[] applyupdate=applyinvoiceibupdatearray.get(i).split("::");
                 
				if(!applyupdate[0].trim().equalsIgnoreCase("undefined") && !applyupdate[0].trim().equalsIgnoreCase("NaN")){
					String sql6="update my_jvtran set out_amount='"+(applyupdate[0].trim().equalsIgnoreCase("undefined") || applyupdate[0].trim().equalsIgnoreCase("NaN") || applyupdate[0].trim().isEmpty()?0:applyupdate[0].trim())+"' where TRANID='"+(applyupdate[1].trim().equalsIgnoreCase("undefined") || applyupdate[1].trim().equalsIgnoreCase("NaN") || applyupdate[1].trim().isEmpty()?0:applyupdate[1].trim())+"'";
					int data6 = stmtICPV.executeUpdate(sql6);
						if(data6<=0){
							stmtICPV.close();
							conn.close();
							return false;
						}
				   }
				}
				/*Apply-Invoicing Grid Updating Ends*/
			    
			    int docno=txtibcashpaydocno;
			    ibCashPaymentBean.setTxtibcashpaydocno(docno);
				if (docno > 0) {
				
					/*Insertion to my_cashbd,my_jvtran,my_outd*/
					int insertData=insertion(conn, docno, trno, formdetailcode, ibCashPaymentDate, txtrefno, txtfromrate, txtdescription, txtdrtotal, txtapplyinvoiceapply, ibcashpaymentarray, applyibinvoicearray, session, mode);
					if(insertData<=0){
						stmtICPV.close();
						conn.close();
						return false;
					}
					/*Insertion to my_cashbd,my_jvtran,my_outd Ends*/
					
					String sql8="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno;
					ResultSet resultSet1 = stmtICPV.executeQuery(sql8);
				    
					 while (resultSet1.next()) {
					 total=resultSet1.getInt("jvtotal");
					 }
					 
					if(total == 0){
						conn.commit();
						stmtICPV.close();
						conn.close();
						return true;
					}else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
					    stmtICPV.close();
					    return false;
				    }
				}
			stmtICPV.close();
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
	
	public boolean editMaster(int txtibcashpaydocno, String formdetailcode, Date ibCashPaymentDate,String txtrefno, String txtdescription, double txtfromrate,
			double txtdrtotal, int txttodocno, int txttotrno, HttpSession session) throws SQLException {
		
		Connection conn = null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtICPV = conn.createStatement();
		
			int trno = txttotrno,trid = 0;
		    
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			
			/*Updating my_cashbm*/
            String sql=("update my_cashbm set date='"+ibCashPaymentDate+"',RefNo='"+txtrefno+"',DESC1='"+txtdescription+"',mrate='"+txtfromrate+"',trMode=2,totalAmount='"+txtdrtotal+"',DTYPE='"+formdetailcode+"',cmpId='"+company+"',brhId='"+branch+"' where TR_NO='"+trno+"' and doc_no="+txtibcashpaydocno);
			int data = stmtICPV.executeUpdate(sql);
			if(data<=0){
				stmtICPV.close();
    			conn.close();
    			return false;
            }
			/*Updating my_cashbm Ends*/
			
			/*Inserting into datalog*/
			String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtibcashpaydocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
			int datas = stmtICPV.executeUpdate(sqls);
			/*Inserting into datalog Ends*/
			
			conn.commit();
			stmtICPV.close();
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


	public boolean delete(int txtibcashpaydocno, String formdetailcode, int txttotrno, int txttodocno, HttpSession session) throws SQLException {
		
		Connection conn = null;
		
		try{
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtICPV = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				int trno = txttotrno,ap_trid=0;
				double amount=0.00,outamount=0.00;
		        String checkingApplying="0";
				
				  String sqlApply = "SELECT * FROM my_jvtran where out_amount!=0 and TR_NO="+trno+"";
				  ResultSet resultSetsApply=stmtICPV.executeQuery(sqlApply);
				  
				  while(resultSetsApply.next()){
					  checkingApplying="1";
				  }
				  
				  if(checkingApplying.equalsIgnoreCase("1")) {
				  
				 /*Selecting Tran-Id*/
				  ArrayList<String> tranidarray=new ArrayList<>();
				  String sql1="SELECT TRANID FROM my_jvtran where TR_NO="+trno+" and acno="+txttodocno+"";
				  ResultSet resultSet=stmtICPV.executeQuery(sql1);
				  
				  while(resultSet.next()){
				   tranidarray.add(resultSet.getString("tranid"));
				  }
				  /*Selecting Tran-Id Ends*/
				  
				  /*Selecting Ap_Tran-Id*/
				  ArrayList<String> outamtarray=new ArrayList<>();

				  for(int i=0;i<tranidarray.size();i++){
				   String sql2="select ap_trid,amount from my_outd where tranid="+tranidarray.get(i);
				   ResultSet resultSet1=stmtICPV.executeQuery(sql2);
				   
				   while(resultSet1.next()){
				    outamtarray.add(resultSet1.getInt("ap_trid")+"::"+resultSet1.getDouble("amount"));
				   } 

				  }
				  /*Selecting Ap_Tran-Id*/

				  for(int i=0;i<outamtarray.size();i++){
				   
				   ap_trid=Integer.parseInt(outamtarray.get(i).split("::")[0]);
				   amount=Double.parseDouble(outamtarray.get(i).split("::")[1]);

				   String sql4="update my_jvtran set out_amount=out_amount-("+amount+"*id) where tranid="+ap_trid+"";
				   int data1=stmtICPV.executeUpdate(sql4);
				   
				  }
				/*Apply-Invoicing Grid Updating Ends*/
				  
			    /*Selecting outamount*/
			     String sql5="select sum(amount) outamount from my_outd where tranid="+tranidarray.get(0)+"";
			     ResultSet resultSet2=stmtICPV.executeQuery(sql5);
			   
			     while(resultSet2.next()){
				   outamount= resultSet2.getDouble("outamount");
			     }
			    /*Selecting outamount Ends*/
			   
			     String sql4="update my_jvtran set out_amount=out_amount-("+outamount+"*id) where tranid="+tranidarray.get(0)+"";
			     int data3=stmtICPV.executeUpdate(sql4);
				   
				 /*Deleting from my_outd*/
				  String sql3="delete from my_outd where tranid="+tranidarray.get(0)+"";
				  int data2=stmtICPV.executeUpdate(sql3);
				 /*Deleting from my_outd Ends*/
				 
				 }
				 
				 /*Status change in my_cashbm*/
				 String sql6=("update my_cashbm set STATUS=7 where doc_no="+txtibcashpaydocno+" and TR_NO="+trno+" and dtype='"+formdetailcode+"'");
				 int data4 = stmtICPV.executeUpdate(sql6);
				 if(data4<=0){
					 stmtICPV.close();
		    			conn.close();
		    			return false;
		            }
				/*Status change in my_cashbm Ends*/

				 /*Status change in my_jvtran*/
				 String sql7=("update my_jvtran set STATUS=7 where doc_no="+txtibcashpaydocno+" and TR_NO="+trno+" and dtype='"+formdetailcode+"'");
				 int data5 = stmtICPV.executeUpdate(sql7);
				 if(data5<=0){
					    stmtICPV.close();
		    			conn.close();
		    			return false;
		            }
				/*Status change in my_jvtran Ends*/
				 
				 /*Inserting into datalog*/
				 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtibcashpaydocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','D')");
				 int datas = stmtICPV.executeUpdate(sqls);
				 /*Inserting into datalog Ends*/
				
				 int docno=txtibcashpaydocno;
				ibCashPaymentBean.setTxtibcashpaydocno(docno);
				if (docno > 0) {
					conn.commit();
					stmtICPV.close();
				    conn.close();
					return true;
				}
			stmtICPV.close();
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
	
	public JSONArray branchlist(HttpSession session) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		
        try {
				conn = connDAO.getMyConnection();
				Statement stmtICPV = conn.createStatement();

				String company = session.getAttribute("COMPANYID").toString();
				
				String sql="select branchname,doc_no from my_brch where cmpid="+company;
				
				ResultSet resultSet = stmtICPV.executeQuery(sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtICPV.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray applyIbInvoicingGrid(String accountno,String atype,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtICPV = conn.createStatement();
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
            	
				ResultSet resultSet = stmtICPV.executeQuery(sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtICPV.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray applyIbInvoicingGridReloading(String trno,String accountno,String check) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
        Connection conn = null;
		
        try {
				conn = connDAO.getMyConnection();
				Statement stmtICPV = conn.createStatement();
				String joins="",casestatement="";
				
				if(!(trno.trim().equalsIgnoreCase("0")||trno.trim().equalsIgnoreCase("") && accountno.trim().equalsIgnoreCase("0")||accountno.trim().equalsIgnoreCase(""))){
            	
				joins=commonDAO.getFinanceVocTablesJoins(conn);
        		casestatement=commonDAO.getFinanceVocTablesCase(conn);
				
				String sql="Select "+casestatement+"a.transType, a.description, a.date, a.tramt, a.applying, a.balance, a.out_amount, a.tranid, a.acno, a.currency from ("
						+ "select t.doc_no transno,t.dtype transType,t.description description,t.date date,((t.dramount*t.id)-(t.out_amount*t.id)+d.amount) tramt,"
						+ "d.amount applying,((t.dramount*t.id)-(t.out_amount*t.id)) balance,t.out_amount,t.tranid,t.acno,t.curId currency,t.brhid from my_outd d left join my_jvtran t on "
						+ "d.ap_trid=t.tranid where d.tranid=(SELECT tranid FROM my_jvtran where TR_NO='"+trno+"' and acno='"+accountno+"')) a"+joins+"";
				
				ResultSet resultSet = stmtICPV.executeQuery(sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);

				stmtICPV.close();
				conn.close();
				}
			stmtICPV.close();
			conn.close();	
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	
	public JSONArray ibCashPaymentGridReloading(HttpSession session,String docNo,String check) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
        Connection conn = null;
        
        Enumeration<String> Enumeration = session.getAttributeNames();
        int a=0;
        while(Enumeration.hasMoreElements()){
        	if(Enumeration.nextElement().equalsIgnoreCase("COMPANYID")){
        		a=1;
        	}
        }
        if(a==0){
    		return RESULTDATA;
        	}
        String company = session.getAttribute("COMPANYID").toString();
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtICPV = conn.createStatement();
			
				String sql=("SELECT t.doc_no docno,d.brhid,b.branchname branch,t.atype type,t.account accounts,t.description accountname1,t.gr_type grtype,c.code currency,c.type currencytype,d.curId currencyid,d.rate rate,"
						+ "if(d.dr>0,true,false)  dr,(d.AMOUNT*d.dr) amount1,(d.lamount*d.dr) baseamount1,d.description,d.SR_NO sr_no,d.costtype,d.costcode,f.costgroup FROM my_cashbm m left join my_cashbd d "
						+ "on m.tr_no=d.tr_no left join my_costunit f on d.costtype=f.costtype left join my_head t on d.acno=t.doc_no left join my_curr c on c.doc_no=d.curId left join my_brch b on d.brhid=b.doc_no WHERE "
						+ "m.dtype='ICPV' and m.cmpid="+company+" and m.doc_no="+docNo+" and d.SR_NO>1");
				
				ResultSet resultSet = stmtICPV.executeQuery (sql);
                
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtICPV.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA;
    }
	
	public JSONArray ibCashPaymentGridSearch(String type,String accountno,String accountname,String currency,String date,String check) throws SQLException {
	        
			JSONArray RESULTDATA=new JSONArray();

			 if(!(check.equalsIgnoreCase("1"))){
		        	return RESULTDATA;
		     }
			 
	        Connection conn = null; 
	       
		     try {
			       conn = connDAO.getMyConnection();
			       Statement stmtICPV = conn.createStatement();
		
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
			        
			       ResultSet resultSet = stmtICPV.executeQuery(sql);
			       RESULTDATA=commonDAO.convertToJSON(resultSet);
		           
			      stmtICPV.close();
				  conn.close();
		     }catch(Exception e){
			      e.printStackTrace();
			      conn.close();
		     }finally{
		    	 conn.close();
		     }
		       return RESULTDATA;
		  }
	
	public JSONArray icpvMainSearch(HttpSession session,String partyname,String docNo,String date,String amount,String check) throws SQLException {

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
           
       
        java.sql.Date sqlIbPaymentDate=null;
           
     try {
	       conn = connDAO.getMyConnection();
	       Statement stmtICPV = conn.createStatement();

	        date.trim();
	        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	        {
	         sqlIbPaymentDate = commonDAO.changeStringtoSqlDate(date);
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
	        if(!(sqlIbPaymentDate==null)){
		         sqltest=sqltest+" and m.date='"+sqlIbPaymentDate+"'";
		        } 
	        
	       ResultSet resultSet = stmtICPV.executeQuery("select m.date,m.doc_no,m.totalAmount amount,if(h.description is null,h1.description,h.description) description from  my_cashbm m "
	       		+ "left join my_cashbd d on m.tr_no=d.tr_no and d.sr_no=1 left join my_cashbd d1 on m.tr_no=d1.tr_no and d1.sr_no=2 left join my_head h on d.acno=h.doc_no left join my_head h1 on d1.acno=h1.doc_no left join my_brch b on m.brhid=b.doc_no where  m.brhid="+branch+" "
	       		+ "and m.dtype='ICPV' and m.status <> 7" +sqltest);
	
	       RESULTDATA=commonDAO.convertToJSON(resultSet);
	       
	       stmtICPV.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
    	 conn.close();
     }
        return RESULTDATA;
    }
	
	 public ClsIbCashPaymentBean getViewDetails(String branch,int docNo) throws SQLException {
		ClsIbCashPaymentBean ibCashPaymentBean = new ClsIbCashPaymentBean();
		
		Connection conn = null;
		
		try {
			conn = connDAO.getMyConnection();
			Statement stmtICPV = conn.createStatement();
			
			ResultSet resultSet = stmtICPV.executeQuery ("SELECT m.date,m.RefNo,m.totalAmount,t.atype,t.account,t.description,t.doc_no accno,d.brhid,d.curId,d.rate,d.dr,(d.AMOUNT*d.dr) AMOUNT,"
					+ "(d.lamount*d.dr) lamount,m.DESC1,sum(o.AMOUNT) appliedamount,d.SR_NO,d.TR_NO,j.tranid,c.type,b.branchname branch FROM my_cashbm m left join my_cashbd d on "
					+ "m.tr_no=d.tr_no left join my_jvtran j on d.tr_no=j.tr_no  left join my_outd o on o.tranid=j.tranid left join my_head t on d.acno=t.doc_no left join  my_brch b on "
					+ "d.brhid=b.doc_no left join my_curr c on d.curId=c.doc_no WHERE m.status<>7 and m.dtype='ICPV' and m.brhid="+branch+" and m.doc_no="+docNo+" group by account");
	
			while (resultSet.next()) {
				ibCashPaymentBean.setTxtibcashpaydocno(docNo);
				ibCashPaymentBean.setJqxIBCashPaymentDate(resultSet.getDate("date").toString());
				ibCashPaymentBean.setTxtrefno(resultSet.getString("RefNo"));
				ibCashPaymentBean.setTxttotranid(resultSet.getInt("tranid"));
				ibCashPaymentBean.setTxttotrno(resultSet.getInt("TR_NO"));
				
				if(resultSet.getString("SR_NO").trim().equalsIgnoreCase("0")){
				ibCashPaymentBean.setTxtfromdocno(resultSet.getInt("accno"));
				ibCashPaymentBean.setTxtfromaccid(resultSet.getString("account"));
				ibCashPaymentBean.setTxtfromaccname(resultSet.getString("description"));
				ibCashPaymentBean.setHidcmbfromcurrency(resultSet.getString("curId"));
				ibCashPaymentBean.setHidfromcurrencytype(resultSet.getString("type"));
				ibCashPaymentBean.setTxtfromrate(resultSet.getDouble("rate"));
				ibCashPaymentBean.setTxtfromamount(resultSet.getDouble("AMOUNT"));
				ibCashPaymentBean.setTxtfrombaseamount(resultSet.getDouble("lamount"));
				ibCashPaymentBean.setTxtdescription(resultSet.getString("DESC1"));
				}
				
				else if(resultSet.getString("SR_NO").trim().equalsIgnoreCase("1")){
				ibCashPaymentBean.setTxttodocno(resultSet.getInt("accno"));
				ibCashPaymentBean.setHidcmbtobranch(resultSet.getString("brhid"));
				ibCashPaymentBean.setHidcmbtotype(resultSet.getString("atype"));
				ibCashPaymentBean.setTxttoaccid(resultSet.getString("account"));
				ibCashPaymentBean.setTxttoaccname(resultSet.getString("description"));
				ibCashPaymentBean.setHidcmbtocurrency(resultSet.getString("curId"));
				ibCashPaymentBean.setHidtocurrencytype(resultSet.getString("type"));
				ibCashPaymentBean.setTxttorate(resultSet.getDouble("rate"));
				ibCashPaymentBean.setTxttoamount(resultSet.getDouble("AMOUNT"));
				ibCashPaymentBean.setTxttobaseamount(resultSet.getDouble("lamount"));
				
				ibCashPaymentBean.setTxtapplyinvoiceamt(resultSet.getDouble("AMOUNT"));
				ibCashPaymentBean.setTxtapplyinvoiceapply(resultSet.getDouble("appliedamount"));
				ibCashPaymentBean.setTxtapplyinvoicebalance(resultSet.getDouble("AMOUNT")-resultSet.getDouble("appliedamount"));
				}
				ibCashPaymentBean.setTxtdrtotal(resultSet.getDouble("totalAmount"));
				ibCashPaymentBean.setTxtcrtotal(resultSet.getDouble("totalAmount"));
				ibCashPaymentBean.setMaindate(resultSet.getDate("date").toString());
		    }
		stmtICPV.close();
		conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
	    	 conn.close();
	     }
		return ibCashPaymentBean;
		}

	 public ClsIbCashPaymentBean getPrint(HttpServletRequest request,int docNo,int branch,int header) throws SQLException {
		 ClsIbCashPaymentBean bean = new ClsIbCashPaymentBean();
		 Connection conn = null;
		 
		try {
			
			conn = connDAO.getMyConnection();
			Statement stmtICPV = conn.createStatement();
			
			int trno=0;
			int acno=0;
			int srno=0;
			
			String headersql="select if(m.dtype='ICPV','IB-Cash Payment','  ') vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
					+ "b.cstno from my_cashbm m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='ICPV' "
					+ "and m.brhid="+branch+" and m.doc_no="+docNo+"";
				
				ResultSet resultSetHead = stmtICPV.executeQuery(headersql);
				
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
			
				String sqls="select m.doc_no,DATE_FORMAT(m.date ,'%d-%m-%Y') date,m.desc1,round(m.totalAmount,2) netAmount,u.user_name from my_cashbm m left join my_user u on "
						+ "m.userid=u.doc_no where m.dtype='ICPV' and m.brhid="+branch+" and m.doc_no="+docNo+"";
							
				ResultSet resultSets = stmtICPV.executeQuery(sqls);
				
				while(resultSets.next()){
					
					bean.setLblvoucherno(resultSets.getString("doc_no"));
					bean.setLbldescription(resultSets.getString("desc1"));
					bean.setLbldate(resultSets.getString("date"));
					bean.setLbldebittotal(resultSets.getString("netAmount"));
					bean.setLblcredittotal(resultSets.getString("netAmount"));
					
					bean.setLblpreparedby(resultSets.getString("user_name"));
				}
				
					bean.setTxtheader(header);
				
				String sql="select round(m.totalAmount,2) netAmount,h.description,d.acno,m.tr_no from my_cashbm m left join my_cashbd d on m.tr_no=d.tr_no left join "
				   + "my_head h on d.acno=h.doc_no where m.dtype='ICPV' and d.sr_no=1  and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
				ResultSet resultSet = stmtICPV.executeQuery(sql);
				
				ClsAmountToWords c = new ClsAmountToWords();
				
				while(resultSet.next()){
					srno=1;
					
					trno=resultSet.getInt("tr_no");
					acno=resultSet.getInt("acno");
					
					bean.setLblname(resultSet.getString("description"));
					bean.setLblnetamount(resultSet.getString("netAmount"));
					bean.setLblnetamountwords(c.convertAmountToWords(resultSet.getString("netAmount")));
				}
				
				if(srno==0){
					String sqld="select round(m.totalAmount,2) netAmount,h.description,d.acno,m.tr_no from my_cashbm m left join my_cashbd d on m.tr_no=d.tr_no left join "
							   + "my_head h on d.acno=h.doc_no where m.dtype='ICPV' and d.sr_no=2  and m.brhid="+branch+" and m.doc_no="+docNo+"";
						
					ResultSet resultSet1 = stmtICPV.executeQuery(sqld);
							
							while(resultSet1.next()){
								trno=resultSet1.getInt("tr_no");
								acno=resultSet1.getInt("acno");
								
								bean.setLblname(resultSet1.getString("description"));
								bean.setLblnetamount(resultSet1.getString("netAmount"));
								bean.setLblnetamountwords(c.convertAmountToWords(resultSet1.getString("netAmount")));
							}
			}
			
			if(srno==1){
			
			String sql2 = "",joins="",casestatement="";

			joins=commonDAO.getFinanceVocTablesJoins(conn);
        	casestatement=commonDAO.getFinanceVocTablesCase(conn);
	
			sql2="Select "+casestatement+"a.transtype, a.description, a.date, a.tramt, a.applying, a.balance from ("
					+ "select t.doc_no transno,t.dtype transType,t.description description,DATE_FORMAT(t.date,'%d-%m-%Y') date,round(((t.dramount*t.id)-(t.out_amount*t.id)+d.amount),2) tramt,"
					+ "round(d.amount,2) applying,round(((t.dramount*t.id)-(t.out_amount*t.id)),2) balance,t.out_amount,t.tranid,t.acno,t.curId currency,t.brhid from my_outd d left join my_jvtran t on "
					+ "d.ap_trid=t.tranid where d.tranid=(SELECT tranid FROM my_jvtran where TR_NO='"+trno+"' and acno='"+acno+"')) a"+joins+"";
				
			ResultSet resultSet2 = stmtICPV.executeQuery(sql2);
			
			ArrayList<String> printapply= new ArrayList<String>();
			
			while(resultSet2.next()){
				bean.setFirstarray(1);
				String temp="";
				temp=resultSet2.getString("transno")+"::"+resultSet2.getString("transtype")+"::"+resultSet2.getString("date")+"::"+resultSet2.getString("description")+"::"+resultSet2.getString("tramt")+"::"+resultSet2.getString("applying")+"::"+resultSet2.getString("balance");
				printapply.add(temp);
			}
			
			request.setAttribute("printapplying", printapply);

			}
			
			String sql1 = "";
		
			sql1="SELECT t.account,t.description accountname,c.code currency,d.description,if(d.amount>0,round((d.amount*1),2),'  ') debit,if(d.amount<0,round((d.amount*-1),2),' ') credit,"
					+ "b.branchname FROM my_cashbm m left join my_cashbd d on m.tr_no=d.tr_no left join my_head t on d.acno=t.doc_no left join my_brch b on d.brhid=b.doc_no left join my_curr c "
					+ "on c.doc_no=d.curId WHERE m.dtype='ICPV' and m.brhid="+branch+" and m.doc_no="+docNo+" order by d.amount desc";
			
			ResultSet resultSet1 = stmtICPV.executeQuery(sql1);
			
			ArrayList<String> printarray= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setSecarray(2); 
				String temp="";
				temp=resultSet1.getString("branchname")+"::"+resultSet1.getString("account")+"::"+resultSet1.getString("accountname")+"::"+resultSet1.getString("description")+"::"+resultSet1.getString("currency")+"::"+resultSet1.getString("debit")+"::"+resultSet1.getString("credit");
			    printarray.add(temp);
			}

			request.setAttribute("printingarray", printarray);
			
			String sql3 = "select min(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,min(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from my_cashbm m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='ICPV' and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSet3 = stmtICPV.executeQuery(sql3);
			
			while(resultSet3.next()){
				bean.setLblpreparedon(resultSet3.getString("preparedon"));
				bean.setLblpreparedat(resultSet3.getString("preparedat"));
			}
		
			stmtICPV.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
	    	 conn.close();
	     }
		return bean;
	}
	 
	 public int insertion(Connection conn,int docno,int trno,String formdetailcode, Date ibCashPaymentDate, String txtrefno, double txtfromrate, 
			 String txtdescription, double txtdrtotal, double txtapplyinvoiceapply, ArrayList<String> ibcashpaymentarray,ArrayList<String> applyibinvoicearray,
			 HttpSession session,String mode) throws SQLException{

		 try{
				conn.setAutoCommit(false);
				CallableStatement stmtICPV;
				Statement stmtICPV1 = conn.createStatement();
				
				String userid=session.getAttribute("USERID").toString().trim();
				System.out.println("===="+ibcashpaymentarray);
				/*Cash Payment Grid and Details Saving*/
				for(int i=0;i< ibcashpaymentarray.size();i++){
					String[] cashpay=ibcashpaymentarray.get(i).split("::");
					if(!cashpay[0].trim().equalsIgnoreCase("undefined") && !cashpay[0].trim().equalsIgnoreCase("NaN")){
					
					int cash = 0;
					int id = 0;
					if(cashpay[3].trim().equalsIgnoreCase("true")){
						cash=0;
						id=1;
					}
					else if(cashpay[3].trim().equalsIgnoreCase("false")){
						cash=1;
						id=-1;
					}
					else{}
					
					stmtICPV = conn.prepareCall("{CALL ibCashbdDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					/*Insertion to my_cashbd*/
					stmtICPV.setInt(20,trno); 
					stmtICPV.setInt(21,docno);
					stmtICPV.registerOutParameter(22, java.sql.Types.INTEGER);
					stmtICPV.setInt(1,i); //SR_NO
					stmtICPV.setString(2,(cashpay[0].trim().equalsIgnoreCase("undefined") || cashpay[0].trim().equalsIgnoreCase("NaN") || cashpay[0].trim().isEmpty()?0:cashpay[0].trim()).toString());  //doc_no of my_head
					stmtICPV.setString(3,(cashpay[1].trim().equalsIgnoreCase("undefined") || cashpay[1].trim().equalsIgnoreCase("NaN") || cashpay[1].trim().isEmpty()?0:cashpay[1].trim()).toString()); //curId
					stmtICPV.setString(4,(cashpay[2].trim().equalsIgnoreCase("undefined") || cashpay[2].trim().equalsIgnoreCase("NaN") || cashpay[2].trim().equals(0) || cashpay[2].trim().isEmpty()?1:cashpay[2]).toString()); //rate 
					stmtICPV.setInt(5,id); //#credit -1 / debit 1 
					stmtICPV.setString(6,(cashpay[4].trim().equalsIgnoreCase("undefined") || cashpay[4].trim().equalsIgnoreCase("NaN") || cashpay[4].trim().isEmpty()?0:cashpay[4].trim()).toString()); //amount
					stmtICPV.setString(7,(cashpay[5].trim().equalsIgnoreCase("undefined") || cashpay[5].trim().equalsIgnoreCase("NaN") || cashpay[5].trim().isEmpty()?0:cashpay[5].trim()).toString()); //description
					stmtICPV.setString(8,(cashpay[6].trim().equalsIgnoreCase("undefined") || cashpay[6].trim().equalsIgnoreCase("NaN") || cashpay[6].trim().isEmpty()?0:cashpay[6].trim()).toString()); //baseamount
					stmtICPV.setInt(9,cash); //For cash = 0/ party = 1
					stmtICPV.setString(10,(cashpay[8].trim().equalsIgnoreCase("undefined") || cashpay[8].trim().equalsIgnoreCase("NaN") || cashpay[8].trim().equalsIgnoreCase("") || cashpay[8].trim().equalsIgnoreCase("0") || cashpay[8].trim().isEmpty()?0:cashpay[8].trim()).toString());  //Cost Type
					stmtICPV.setString(11,(cashpay[9].trim().equalsIgnoreCase("undefined") || cashpay[9].trim().equalsIgnoreCase("NaN") || cashpay[9].trim().equalsIgnoreCase("") || cashpay[9].trim().equalsIgnoreCase("0") || cashpay[9].trim().isEmpty()?0:cashpay[9].trim()).toString()); //Cost Code
					/*my_cashbd Ends*/
					
					/*Insertion to my_jvtran*/
					stmtICPV.setDate(12,ibCashPaymentDate);
					stmtICPV.setString(13,txtrefno);
					stmtICPV.setInt(14,id);  //id
					stmtICPV.setString(15,(cashpay[7].equalsIgnoreCase("undefined") || cashpay[7].trim().equalsIgnoreCase("NaN") || cashpay[7].trim().isEmpty()?0:cashpay[7].trim()).toString());  //out-amount
					/*my_jvtran Ends*/
					
					stmtICPV.setString(16,formdetailcode);
					stmtICPV.setString(17,(cashpay[10].trim().equalsIgnoreCase("undefined") || cashpay[10].trim().equalsIgnoreCase("NaN") || cashpay[10].trim().isEmpty()?0:cashpay[10].trim()).toString());  //branch
					stmtICPV.setString(18,(cashpay[11].trim().equalsIgnoreCase("undefined") || cashpay[11].trim().equalsIgnoreCase("NaN") || cashpay[11].trim().isEmpty()?0:cashpay[11].trim()).toString()); //Main Branch
					stmtICPV.setString(19,userid);
					stmtICPV.setString(23,mode);
					stmtICPV.execute();
						if(stmtICPV.getInt("irowsNo")<=0){
							stmtICPV.close();
							conn.close();
							return 0;
						}
      				  }
				    }
				    /*Cash Payment Grid and Details Saving Ends*/
				
					/*Apply-Invoicing Grid Saving*/
					for(int i=0;i<applyibinvoicearray.size();i++){
					String[] apply=applyibinvoicearray.get(i).split("::");
					if(!apply[0].trim().equalsIgnoreCase("undefined") && !apply[0].trim().equalsIgnoreCase("NaN")){
					
					stmtICPV = conn.prepareCall("{CALL applyInvoicingDML(?,?,?,?,?,?,?)}");
					/*Insertion to my_outd*/
					stmtICPV.setString(1,(apply[1].trim().equalsIgnoreCase("undefined") || apply[1].trim().equalsIgnoreCase("NaN") || apply[1].trim().isEmpty()?0:apply[1].trim()).toString()); //Out amount
					stmtICPV.setString(2,(apply[0].trim().equalsIgnoreCase("undefined") || apply[0].trim().equalsIgnoreCase("NaN") || apply[0].trim().isEmpty()?0:apply[0].trim()).toString()); //Applied amount
					stmtICPV.setString(3,(apply[2].trim().equalsIgnoreCase("undefined") || apply[2].trim().equalsIgnoreCase("NaN") || apply[2].trim().isEmpty()?0:apply[2].trim()).toString()); //Currency
					stmtICPV.setInt(4,trno);  //tr_no
					stmtICPV.setString(5,(apply[3].trim().equalsIgnoreCase("undefined") || apply[3].trim().equalsIgnoreCase("NaN") || apply[3].trim().isEmpty()?0:apply[3].trim()).toString()); //tranid
					stmtICPV.setString(6,(apply[4].trim().equalsIgnoreCase("undefined") || apply[4].trim().equalsIgnoreCase("NaN") || apply[4].trim().isEmpty()?0:apply[4].trim()).toString()); //account
					stmtICPV.setString(7,mode);	
					int applypaymentcheck=stmtICPV.executeUpdate();
						if(applypaymentcheck<=0){
							stmtICPV.close();
							return 0;
						}
						/*Apply-Invoicing Grid Saving Ends*/
						stmtICPV.close();
					 }
				}
					
				int trid=0,id = 0;
				/*Selecting Tran-Id & Id*/
				String sqls=("select j.TRANID,j.ID from my_jvtran j inner join my_cashbd d on (d.acno =j.acno and d.tr_no =j.tr_no and d.sr_no=1) where j.tr_no="+trno);
				ResultSet resultSets = stmtICPV1.executeQuery(sqls);
				    
				 while (resultSets.next()) {
					 trid=resultSets.getInt("TRANID");
				     id=resultSets.getInt("ID");
				 }
				 /*Selecting Tran-Id & Id Ends*/
				
				/*Updating my_jvtran*/
				String sql3=("update my_jvtran set out_amount="+(txtapplyinvoiceapply)*id+" where tranid="+trid);
				int data3 = stmtICPV1.executeUpdate(sql3);
				if(data3<=0){
					stmtICPV1.close();
					conn.close();
					return 0;
				}
				/*Updating my_jvtran Ends*/
				
				/*Deleting account of value zero*/
				String sql2=("DELETE FROM my_jvtran where TR_NO="+trno+" and acno=0");
			    int data = stmtICPV1.executeUpdate(sql2);
			     
			    String sql4=("DELETE FROM my_cashbd where TR_NO="+trno+" and acno=0");
			    int data1 = stmtICPV1.executeUpdate(sql4);
			    /*Deleting account of value zero ends*/
					
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}

}
