package com.finance.transactions.bankpayment;

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
import com.common.ClsChequeAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsBankPaymentDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsBankPaymentBean bankPaymentBean = new ClsBankPaymentBean();
	
	  public int insert(Connection conn,Date bankPaymentDate, String formdetailcode, String txtrefno, double txtfromrate, Date chequeDate, String txtchequeno, String txtchequename, 
			 int chckpdc, String txtdescription, double txtdrtotal, int txttodocno, double txtapplyinvoiceapply, ArrayList<String> bankpaymentarray,
			 ArrayList<String> applyinvoicearray, HttpSession session,HttpServletRequest request,String mode) throws SQLException {
		
		try{
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			int total = 0;
			
			if(txtdescription.contains(" CHQNO -")){
				String[] descriptionsplited = txtdescription.split(" CHQNO -");
				txtdescription = descriptionsplited[0]+"  CHQNO -"+txtchequeno+" CHQ DATE -"+chequeDate.toString();
			} else {
				txtdescription=(txtdescription+"  CHQNO -"+txtchequeno+" CHQ DATE -"+chequeDate.toString());
			}
			
			CallableStatement stmtBPV = conn.prepareCall("{CALL chqbmDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtBPV.registerOutParameter(13, java.sql.Types.INTEGER);
			stmtBPV.registerOutParameter(14, java.sql.Types.INTEGER);
			stmtBPV.setDate(1,bankPaymentDate);
			stmtBPV.setString(2,txtrefno);
			stmtBPV.setString(3,txtdescription);
			stmtBPV.setString(4,txtchequeno);
			stmtBPV.setDate(5,chequeDate);
			stmtBPV.setString(6,txtchequename);
			stmtBPV.setDouble(7,txtdrtotal);
			stmtBPV.setDouble(8,txtfromrate);
			stmtBPV.setString(9,formdetailcode);
			stmtBPV.setString(10,company);  
			stmtBPV.setString(11,branch);
			stmtBPV.setString(12,userid);
			stmtBPV.setString(15,mode);
			int datas=stmtBPV.executeUpdate();
			if(datas<=0){
				stmtBPV.close();
				conn.close();
				return 0;
			}
			int docno=stmtBPV.getInt("docNo");
			int trno=stmtBPV.getInt("itranNo");
			request.setAttribute("tranno", trno);
			bankPaymentBean.setTxtbankpaydocno(docno);
			if (docno > 0) {
				/*Insertion to my_chqdet*/
				String sql=("insert into my_chqdet(chqno,chqdt,opsacno,pdc,Status,postno,tr_no,brhId) values('"+txtchequeno+"','"+chequeDate+"',"+txttodocno+",'"+chckpdc+"','E',0,'"+trno+"','"+branch+"')");
				int data = stmtBPV.executeUpdate(sql);
				if(data<=0){
					stmtBPV.close();
					conn.close();
					return 0;
				}
				/*my_chqdet Ends*/
				
				/*Insertion to my_chqbd,my_jvtran,my_outd*/
				int insertData=insertion(conn, docno, trno, formdetailcode, bankPaymentDate, txtrefno, txtfromrate, chequeDate, txtchequeno, chckpdc, txtdescription, txtdrtotal, txtapplyinvoiceapply, bankpaymentarray, applyinvoicearray, session, mode);
				if(insertData<=0){
					stmtBPV.close();
					conn.close();
					return 0;
				}
				/*Insertion to my_chqbd,my_jvtran,my_outd Ends*/
				
				String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno;
				ResultSet resultSet = stmtBPV.executeQuery(sql1);
			    
				 while (resultSet.next()) {
				 total=resultSet.getInt("jvtotal");
				 }

				 if(total == 0){
					stmtBPV.close();
					return docno;
				 }else{
				     System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
					 stmtBPV.close();
					 return 0;
				 }
			}
		stmtBPV.close();
	 }catch(Exception e){
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 0;
	}
			
	
	public boolean edit(int txtbankpaydocno, String formdetailcode, Date bankPaymentDate,String txtrefno, String txtdescription, double txtfromrate, double txtdrtotal, int txttodocno, 
			int txttotrno,Date chequeDate, String txtchequeno, String txtchequename, int chckpdc, double txtapplyinvoiceapply, ArrayList<String> bankpaymentarray, ArrayList<String> applyinvoicearray,
			ArrayList<String> applyinvoiceupdatearray, HttpSession session, String mode) throws SQLException {
		
		Connection conn = null;
		
		try{
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtBPV = conn.createStatement();
				
				if(mode.equalsIgnoreCase("EDIT")){
					mode="E";
				}
				
				int trno = txttotrno;
			    int trid = 0,applydelete=0;
			    int total = 0;
			    String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String company=session.getAttribute("COMPANYID").toString().trim();
				
				if(txtdescription.contains(" CHQNO -")){
					String[] descriptionsplited = txtdescription.split(" CHQNO -");
					txtdescription = descriptionsplited[0]+"  CHQNO -"+txtchequeno+" CHQ DATE -"+chequeDate.toString();
				} else {
					txtdescription=(txtdescription+"  CHQNO -"+txtchequeno+" CHQ DATE -"+chequeDate.toString());
				}
				
				/*Updating my_chqbm*/
                String sql=("update my_chqbm set date='"+bankPaymentDate+"',RefNo='"+txtrefno+"',DESC1='"+txtdescription+"',mrate="+txtfromrate+",chqno='"+txtchequeno+"',chqdt='"+chequeDate+"',chqname='"+txtchequename+"',trMode=3,totalAmount="+txtdrtotal+",DTYPE='"+formdetailcode+"',cmpId="+company+",brhId="+branch+" where TR_NO="+trno+" and doc_no="+txtbankpaydocno);
				int data = stmtBPV.executeUpdate(sql);
				if(data<=0){
					stmtBPV.close();
					conn.close();
					return false;
				}
				/*Updating my_chqbm Ends*/
				
				/*Inserting into datalog*/
				String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtbankpaydocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
				int datas = stmtBPV.executeUpdate(sqls);
				/*Inserting into datalog Ends*/
			    
			    String sql3=("DELETE FROM my_chqbd WHERE TR_NO="+trno);
			    int data1 = stmtBPV.executeUpdate(sql3);
			    
				 /*String sql2=("SELECT TRANID FROM my_jvtran where TR_NO="+trno+" and acno="+txttodocno);
				 ResultSet resultSet2 = stmtBPV.executeQuery(sql2);
				    
				 while (resultSet2.next()) {
				 trid=resultSet2.getInt("TRANID");
				 }
				    
				 String sql5=("DELETE FROM my_outd WHERE TRANID="+trid);
				 int data2 = stmtBPV.executeUpdate(sql5);*/
			    
			    ClsApplyDelete applyDelete = new ClsApplyDelete();
				applydelete=applyDelete.getFinanceApplyDelete(conn, trno);
				if(applydelete<0){
					System.out.println("*** ERROR IN APPLY DELETE ***");
					stmtBPV.close();
					conn.close();
					return false;
				}
				 
				 String sql4=("DELETE FROM my_jvtran WHERE TR_NO="+trno);
				 int data3 = stmtBPV.executeUpdate(sql4);
				 
				 String sql6=("DELETE FROM my_costtran WHERE TR_NO="+trno);
				 int data6 = stmtBPV.executeUpdate(sql6);
			    
			    /*Apply-Invoicing Grid Updating
				for(int i=0;i< applyinvoiceupdatearray.size();i++){
				String[] applyupdate=applyinvoiceupdatearray.get(i).split("::");

				if(!applyupdate[0].trim().equalsIgnoreCase("undefined") && !applyupdate[0].trim().equalsIgnoreCase("NaN")){
				String sql1="update my_jvtran set out_amount='"+(applyupdate[0].equalsIgnoreCase("undefined") || applyupdate[0].equalsIgnoreCase("NaN") || applyupdate[0].isEmpty()?0:applyupdate[0])+"' where TRANID='"+(applyupdate[1].equalsIgnoreCase("undefined") || applyupdate[1].equalsIgnoreCase("NaN") || applyupdate[1].isEmpty()?0:applyupdate[1])+"'";
				int data4 = stmtBPV.executeUpdate(sql1);
					if(data4<=0){
						stmtBPV.close();
						conn.close();
						return false;
					}
				 }
				}
				Apply-Invoicing Grid Updating Ends*/
				
				 /*Updating my_chqdet*/
	              String sql7=("update my_chqdet set chqno='"+txtchequeno+"',chqdt='"+chequeDate+"',opsacno="+txttodocno+",pdc='"+chckpdc+"',Status='E',postno=0,brhId='"+branch+"' where tr_no="+trno);
	              int data5 = stmtBPV.executeUpdate(sql7);
				  if(data5<=0){
				    stmtBPV.close();
					conn.close();
					return false;
				  }
				/*Updating my_chqdet Ends*/
			    
			    int docno=txtbankpaydocno;
				bankPaymentBean.setTxtbankpaydocno(docno);
				if (docno > 0) {
				
					/*Insertion to my_chqbd,my_jvtran,my_outd*/
					int insertData=insertion(conn,docno, trno, formdetailcode, bankPaymentDate, txtrefno, txtfromrate, chequeDate, txtchequeno, chckpdc, txtdescription, txtdrtotal, txtapplyinvoiceapply, bankpaymentarray, applyinvoicearray, session, mode);
					if(insertData<=0){
						stmtBPV.close();
						conn.close();
						return false;
					}
					/*Insertion to my_chqbd,my_jvtran,my_outd Ends*/
				
					String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno;
					ResultSet resultSet = stmtBPV.executeQuery(sql1);
				    
					 while (resultSet.next()) {
					 total=resultSet.getInt("jvtotal");
					 }
					 
					if(total == 0){
						conn.commit();
						stmtBPV.close();
						conn.close();
						return true;
					 }else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
					    stmtBPV.close();
					    return false;
				    }
				}
			stmtBPV.close();
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
	
	public boolean editMaster(int txtbankpaydocno, String formdetailcode, Date bankPaymentDate,String txtrefno, String txtdescription, double txtfromrate,
			double txtdrtotal, int txttodocno, int txttotrno, HttpSession session) throws SQLException {
		
		Connection conn = null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtBPV = conn.createStatement();
			
			int trno = txttotrno;
		    String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			
			/*Updating my_chqbm*/
            String sql=("update my_chqbm set date='"+bankPaymentDate+"',RefNo='"+txtrefno+"',DESC1='"+txtdescription+"',mrate='"+txtfromrate+"',trMode=3,totalAmount='"+txtdrtotal+"',DTYPE='"+formdetailcode+"',cmpId='"+company+"',brhId='"+branch+"' where TR_NO='"+trno+"' and doc_no="+txtbankpaydocno);
            int data = stmtBPV.executeUpdate(sql);
			if(data<=0){
				stmtBPV.close();
				conn.close();
				return false;
			}
			/*Updating my_chqbm Ends*/
			
			/*Inserting into datalog*/
			String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtbankpaydocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
			int datas = stmtBPV.executeUpdate(sqls);
			/*Inserting into datalog Ends*/
			
			conn.commit();
			stmtBPV.close();
			conn.close();
			return true;			
    } catch(Exception e){	
	 	e.printStackTrace();
	 	conn.close();
	 	return false;
     } finally{
			conn.close();
		}
	}


	public boolean delete(int txtbankpaydocno,  String formdetailcode, int txttodocno, int txttotrno, HttpSession session) throws SQLException {
		
		Connection conn = null;
		
		try{
			    conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtBPV = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				int trno = txttotrno,applydelete=0;
				
				/*int ap_trid=0;
				  double amount=0.00,outamount=0.00;
				  String checkingApplying="0";
				
				  String sqlApply = "SELECT * FROM my_jvtran where out_amount!=0 and TR_NO="+trno+"";
				  ResultSet resultSetsApply=stmtBPV.executeQuery(sqlApply);
				  
				  while(resultSetsApply.next()){
					  checkingApplying="1";
				  }
				  
				  if(checkingApplying.equalsIgnoreCase("1")) {
				  
				 Selecting Tran-Id
				  ArrayList<String> tranidarray=new ArrayList<>();
				  String sql1="SELECT TRANID FROM my_jvtran where TR_NO="+trno+" and acno="+txttodocno+"";
				  ResultSet resultSet=stmtBPV.executeQuery(sql1);
				  
				  while(resultSet.next()){
				   tranidarray.add(resultSet.getString("tranid"));
				  }
				  Selecting Tran-Id Ends
				  
				  Selecting Ap_Tran-Id
				  ArrayList<String> outamtarray=new ArrayList<>();

				  for(int i=0;i<tranidarray.size();i++){
				   String sql2="select ap_trid,amount from my_outd where tranid="+tranidarray.get(i);
				   ResultSet resultSet1=stmtBPV.executeQuery(sql2);
				   
				   while(resultSet1.next()){
				    outamtarray.add(resultSet1.getInt("ap_trid")+"::"+resultSet1.getDouble("amount"));
				   } 

				  }
				  Selecting Ap_Tran-Id

				  for(int i=0;i<outamtarray.size();i++){
				   
				   ap_trid=Integer.parseInt(outamtarray.get(i).split("::")[0]);
				   amount=Double.parseDouble(outamtarray.get(i).split("::")[1]);

				   String sql4="update my_jvtran set out_amount=out_amount-("+amount+"*id) where tranid="+ap_trid+"";
				   int data1=stmtBPV.executeUpdate(sql4);
				   
				  }
				Apply-Invoicing Grid Updating Ends
				  
			    Selecting outamount
			     String sql5="select sum(amount) outamount from my_outd where tranid="+tranidarray.get(0)+"";
			     ResultSet resultSet2=stmtBPV.executeQuery(sql5);
			   
			     while(resultSet2.next()){
				   outamount= resultSet2.getDouble("outamount");
			     }
			    Selecting outamount Ends
			   
			     String sql4="update my_jvtran set out_amount=out_amount-("+outamount+"*id) where tranid="+tranidarray.get(0)+"";
			     int data3=stmtBPV.executeUpdate(sql4);
				   
				 Deleting from my_outd
				  String sql3="delete from my_outd where tranid="+tranidarray.get(0)+"";
				  int data2=stmtBPV.executeUpdate(sql3);
				 Deleting from my_outd Ends
				 
				 }*/
				  
				  ClsApplyDelete applyDelete = new ClsApplyDelete();
					applydelete=applyDelete.getFinanceApplyDelete(conn, trno);
					if(applydelete<0){
						System.out.println("*** ERROR IN APPLY DELETE ***");
						stmtBPV.close();
						conn.close();
						return false;
					}
				 
				 /*Deleting from my_chqdet*/
				 String sql6=("DELETE FROM my_chqdet WHERE tr_no="+trno+"");
				 int data4 = stmtBPV.executeUpdate(sql6);
				 /*Deleting from my_chqdet Ends*/
				 
				/*Status change in my_chqbm*/
				 String sql7=("update my_chqbm set STATUS=7 where tr_no="+trno+" and doc_no="+txtbankpaydocno+"");
				 int data5 = stmtBPV.executeUpdate(sql7);
				 if(data5<=0){
				    stmtBPV.close();
					conn.close();
					return false;
				 }
				/*Status change in my_chqbm Ends*/

				 /*Status change in my_jvtran*/
				 String sql8=("update my_jvtran set STATUS=7 where doc_no="+txtbankpaydocno+" and TR_NO="+trno+"");
				 int data6 = stmtBPV.executeUpdate(sql8);
				 if(data6<=0){
				    stmtBPV.close();
					conn.close();
					return false;
				 }
				/*Status change in my_jvtran Ends*/
				 
				 /*Inserting into datalog*/
				 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtbankpaydocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','D')");
				 int datas = stmtBPV.executeUpdate(sqls);
				/*Inserting into datalog Ends*/
				
				int docno=txtbankpaydocno;
				bankPaymentBean.setTxtbankpaydocno(docno);
				if (docno > 0) {
					
					conn.commit();
					stmtBPV.close();
					conn.close();
					return true;
				}	
				stmtBPV.close();
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
	
	public JSONArray applyBankInvoicingGrid(String accountno,String atype,String check) throws SQLException {
      JSONArray RESULTDATA=new JSONArray();
      System.out.println("accountno====="+accountno+"atype====="+atype);
      if(!(check.equalsIgnoreCase("1"))){
      	return RESULTDATA;
      }
      
      Connection conn = null;
      
		try {
				conn = connDAO.getMyConnection();
				Statement stmtBPV = conn.createStatement();
		
				String condition="",sql="",joins="",casestatement="",sql1="";
            	
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
					
				sql = "Select "+casestatement+"a.transType, a.description, a.date, a.tramt, a.out_amount, a.tranid, a.acno, a.currency from (Select t1.doc_no transno,t1.acno,t1.tranid,t1.date,t1.out_amount,t1.dtype transType,t1.curid currency,"
            		+ "t1.description,(t1.dramount- t1.out_amount)*id tramt,t1.brhid from my_jvtran t1 inner join my_brch b on t1.brhId=b.doc_no inner join my_head h on "
            		+ "t1.acno=h.doc_no where t1.status=3 and t1.acno="+accountno+" "+condition+" and "
					+ "(t1.dramount - out_amount) != 0 group by t1.tranid) a"+joins+"";
			  
				ResultSet resultSet = stmtBPV.executeQuery(sql);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtBPV.close();
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
	
	public JSONArray applyBankInvoicingGridReloading(String trno,String accountno,String check) throws SQLException {
      JSONArray RESULTDATA=new JSONArray();
      System.out.println("accountno====="+accountno+"trno====="+trno);
      if(!(check.equalsIgnoreCase("1"))){
      	return RESULTDATA;
      }
      
      Connection conn = null;
		
      try {
				conn = connDAO.getMyConnection();
				Statement stmtBPV = conn.createStatement();
				String joins="",casestatement="",sql1="";
				
				if(!(trno.trim().equalsIgnoreCase("0")||trno.trim().equalsIgnoreCase("") && accountno.trim().equalsIgnoreCase("0")||accountno.trim().equalsIgnoreCase(""))){
          	
				joins=commonDAO.getFinanceVocTablesJoins(conn);
        		casestatement=commonDAO.getFinanceVocTablesCase(conn);
				
				String sql="Select "+casestatement+"a.transType, a.description, a.date, a.tramt, a.applying, a.balance, a.out_amount, a.tranid, a.acno, a.currency from (select t.doc_no transno,t.dtype transType,t.description description,t.date date,((t.dramount*t.id)-(t.out_amount*t.id)+d.amount) tramt,"
						+ "d.amount applying,((t.dramount*t.id)-(t.out_amount*t.id)) balance,t.out_amount,t.tranid,t.acno,t.curId currency,t.brhid from my_outd d left join my_jvtran t on "
						+ "d.ap_trid=t.tranid where d.tranid=(SELECT tranid FROM my_jvtran where TR_NO='"+trno+"' and acno='"+accountno+"')) a"+joins+"";
				
				      
				ResultSet resultSet = stmtBPV.executeQuery(sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtBPV.close();
				conn.close();
				}
			stmtBPV.close();
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
	
	public JSONArray bankPaymentGridReloading(HttpSession session,String docNo,String check) throws SQLException {
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
				Statement stmtBPV = conn.createStatement();
			
				ResultSet resultSet = stmtBPV.executeQuery ("SELECT m.date,m.RefNo,t.doc_no docno,t.atype type,t.account accounts,t.description accountname1,t.gr_type grtype,"
						+ "c.code currency,c.type currencytype,d.curId currencyid,d.rate rate,if(d.dr>0,true,false) dr,(d.AMOUNT*d.dr) amount1,(d.lamount*d.dr) baseamount1,"
						+ "d.description,d.SR_NO sr_no,d.costtype,d.costcode,f.costgroup FROM my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no left join my_costunit f "
						+ "on d.costtype=f.costtype left join my_head t on d.acno=t.doc_no left join my_curr c on c.doc_no=d.curId WHERE m.dtype='BPV' and m.brhId="+branch+" "
						+ "and m.doc_no="+docNo+" and d.SR_NO>1");
              
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtBPV.close();
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
	
	public JSONArray bankPaymentGridSearch(String type,String accountno,String accountname,String currency,String date,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
		if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
		
        Connection conn = null; 
       
	     try {
		       conn = connDAO.getMyConnection();
		       Statement stmtBPV = conn.createStatement();
	
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
		        
		       ResultSet resultSet = stmtBPV.executeQuery(sql);
		       RESULTDATA=commonDAO.convertToJSON(resultSet);
	           
		       stmtBPV.close();
			   conn.close();
	     } catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     }finally{
				conn.close();
			}
	       return RESULTDATA;
	  }
	
	 public ClsBankPaymentBean getViewDetails(HttpSession session,int docNo) throws SQLException {
		
		ClsBankPaymentBean bankPaymentBean = new ClsBankPaymentBean();
		
		Connection conn = null;
		
		try {
		
			conn = connDAO.getMyConnection();
			Statement stmtBPV = conn.createStatement();
	
			String branch = session.getAttribute("BRANCHID").toString();
			
			String sql="SELECT m.date,m.RefNo,m.totalAmount,m.chqname,t.atype,t.account,t.description,t.doc_no accno,d.curId,d.rate,d.dr,(d.AMOUNT*d.dr) AMOUNT,"
					+ "(d.lamount*d.dr) lamount,m.DESC1,sum(o.AMOUNT) appliedamount,d.SR_NO,d.TR_NO,j.tranid,c.chqno,c.chqdt,c.pdc,coalesce(c.pdcposttrno,0) pdcposttrno,cr.type,(select acno from my_account where codeno='PDCPV') pdcacno "
					+ "FROM my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no left join my_jvtran j on d.tr_no=j.tr_no  left join my_outd o on o.tranid=j.tranid left join my_chqdet c on c.tr_no=d.tr_no "
					+ "left join my_head t on d.acno=t.doc_no left join my_curr cr on d.curId=cr.doc_no WHERE m.dtype='BPV' and m.status<>7 and m.brhId='"+branch+"' and m.doc_no="+docNo+" group by account";
			
			ResultSet resultSet = stmtBPV.executeQuery (sql);
	
			
			while (resultSet.next()) {
					bankPaymentBean.setTxtbankpaydocno(docNo);
					bankPaymentBean.setJqxBankPaymentDate(resultSet.getDate("date").toString());
					bankPaymentBean.setTxtrefno(resultSet.getString("RefNo"));
					bankPaymentBean.setTxttotranid(resultSet.getInt("tranid"));
					bankPaymentBean.setTxttotrno(resultSet.getInt("TR_NO"));
				
				if(resultSet.getString("SR_NO").trim().equalsIgnoreCase("0")){
					bankPaymentBean.setTxtfromdocno(resultSet.getInt("accno"));
					bankPaymentBean.setTxtfromaccid(resultSet.getString("account"));
					bankPaymentBean.setTxtfromaccname(resultSet.getString("description"));
					bankPaymentBean.setHidcmbfromcurrency(resultSet.getString("curId"));
					bankPaymentBean.setHidfromcurrencytype(resultSet.getString("type"));
					bankPaymentBean.setChckpdc(resultSet.getInt("pdc"));
					bankPaymentBean.setTxtpdcacno(resultSet.getInt("pdcacno"));
					bankPaymentBean.setTxtchequeno(resultSet.getString("chqno"));
					bankPaymentBean.setJqxChequeDate(resultSet.getDate("chqdt").toString());
					bankPaymentBean.setTxtchequename(resultSet.getString("chqname"));
					bankPaymentBean.setPdcposttrno(resultSet.getInt("pdcposttrno"));
					
					bankPaymentBean.setTxtfromrate(resultSet.getDouble("rate"));
					bankPaymentBean.setTxtfromamount(resultSet.getDouble("AMOUNT"));
					bankPaymentBean.setTxtfrombaseamount(resultSet.getDouble("lamount"));
					bankPaymentBean.setTxtdescription(resultSet.getString("DESC1"));
				}
				
				else if(resultSet.getString("SR_NO").trim().equalsIgnoreCase("1")){
					bankPaymentBean.setTxttodocno(resultSet.getInt("accno"));
					bankPaymentBean.setHidcmbtotype(resultSet.getString("atype"));
					bankPaymentBean.setTxttoaccid(resultSet.getString("account"));
					bankPaymentBean.setTxttoaccname(resultSet.getString("description"));
					bankPaymentBean.setHidcmbtocurrency(resultSet.getString("curId"));
					bankPaymentBean.setHidtocurrencytype(resultSet.getString("type"));
					bankPaymentBean.setTxttorate(resultSet.getDouble("rate"));
					bankPaymentBean.setTxttoamount(resultSet.getDouble("AMOUNT"));
					bankPaymentBean.setTxttobaseamount(resultSet.getDouble("lamount"));
					
					bankPaymentBean.setTxtapplyinvoiceamt(resultSet.getDouble("AMOUNT"));
					bankPaymentBean.setTxtapplyinvoiceapply(resultSet.getDouble("appliedamount"));
					bankPaymentBean.setTxtapplyinvoicebalance(resultSet.getDouble("AMOUNT")-resultSet.getDouble("appliedamount"));
				}
					bankPaymentBean.setTxtdrtotal(resultSet.getDouble("totalAmount"));
					bankPaymentBean.setTxtcrtotal(resultSet.getDouble("totalAmount"));
					bankPaymentBean.setMaindate(resultSet.getDate("date").toString());
	
			    }
			stmtBPV.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return bankPaymentBean;
		}
	 
	public ClsBankPaymentBean getPrint(HttpServletRequest request,int docNo,int branch,int header) throws SQLException {
		 ClsBankPaymentBean bean = new ClsBankPaymentBean();
		 Connection conn = null;
		 
		try {
			
				conn = connDAO.getMyConnection();
				Statement stmtBPV = conn.createStatement();
				
				int trno=0;
				int acno=0;
				int srno=0;
				
				String headersql="select if(m.dtype='BPV','Bank Payment','  ') vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.tinno,m.ref_no refno, "
					+ "b.cstno from my_chqbm m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='BPV' "
					+ "and m.brhid="+branch+" and m.doc_no="+docNo+"";
					
					ResultSet resultSetHead = stmtBPV.executeQuery(headersql);
					
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
						bean.setLblrefno(resultSetHead.getString("refno"));
						bean.setPrintquery(bean.getPrintquery());
					}
				
				String sqls="select m.doc_no,DATE_FORMAT(m.date ,'%d-%m-%Y') date,m.desc1,concat(m.chqno,' ',if(chq.pdc=1,'(PDC)','')) chqno,DATE_FORMAT(m.chqdt ,'%d-%m-%Y') chqdt,"
						+ "format(round(m.totalAmount,2),2) netAmount,u.user_name from my_chqbm m left join my_chqdet chq on  chq.tr_no=m.tr_no left join my_user u on m.userid=u.doc_no where "
						+ "m.dtype='BPV' and m.brhid="+branch+" and m.doc_no="+docNo+"";
						
					ResultSet resultSets = stmtBPV.executeQuery(sqls);
					
					while(resultSets.next()){
						
						bean.setLblvoucherno(resultSets.getString("doc_no"));
						bean.setLbldescription(resultSets.getString("desc1"));
						bean.setLbldate(resultSets.getString("date"));
						bean.setLbldebittotal(resultSets.getString("netAmount"));
						bean.setLblcredittotal(resultSets.getString("netAmount"));
						
						bean.setLblchqno(resultSets.getString("chqno"));
						bean.setLblchqdate(resultSets.getString("chqdt"));
						
						bean.setLblpreparedby(resultSets.getString("user_name"));
					}
					
						bean.setTxtheader(header);
				
				String sql="select  h.description paidto,format(round(m.totalAmount,2),2) netAmount,round(m.totalAmount,2) netAmountWords,CASE WHEN m.chqname is null THEN h.description WHEN m.chqname='' THEN h.description "  
				   + "Else m.chqname END as 'description',d.acno,m.tr_no from my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no left join my_head h on "
				   + "d.acno=h.doc_no  where m.dtype='BPV' and d.sr_no=1 and m.brhid="+branch+" and m.doc_no="+docNo+"";
				ResultSet resultSet = stmtBPV.executeQuery(sql);
				
				ClsAmountToWords c = new ClsAmountToWords();
				
				while(resultSet.next()){
					srno=1;
					
					trno=resultSet.getInt("tr_no");
					acno=resultSet.getInt("acno");
					
					bean.setLblacno(resultSet.getString("acno"));
					bean.setPaidTo(resultSet.getString("paidto"));
					bean.setLblname(resultSet.getString("description"));
					//bean.setLblnetamount(resultSet.getString("netAmount"));
					//bean.setLblnetamountwords(c.convertAmountToWords(resultSet.getString("netAmountWords")));
					bean.setLblnetapplied("0.00");
				}
				
				
					String amtsql="select format(round(d.amount*d.dr,2),2) netAmount,round(d.amount*d.dr,2) netAmountWords from my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no where m.dtype='BPV' and d.sr_no=0 and m.brhid="+branch+" and m.doc_no="+docNo;
					ResultSet resultSet4 = stmtBPV.executeQuery(amtsql);
			     	while(resultSet4.next()){
						bean.setLblnetamount(resultSet4.getString("netAmount"));
						bean.setLblnetamountwords(c.convertAmountToWords(resultSet4.getString("netAmountWords")));
					}
				
				if(srno==0){
					String sqld="select format(round(m.totalAmount,2),2) netAmount,round(m.totalAmount,2) netAmountWords,CASE WHEN m.chqname is null THEN h.description WHEN m.chqname='' THEN h.description "  
							   + "Else m.chqname END as 'description',d.acno,m.tr_no from my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no left join my_head h on "
							   + "d.acno=h.doc_no  where m.dtype='BPV' and d.sr_no=2 and m.brhid="+branch+" and m.doc_no="+docNo+"";
						
							ResultSet resultSet1 = stmtBPV.executeQuery(sqld);
							
							while(resultSet1.next()){
								trno=resultSet1.getInt("tr_no");
								acno=resultSet1.getInt("acno");
								
								bean.setLblname(resultSet1.getString("description"));
								//bean.setLblnetamount(resultSet1.getString("netAmount"));
								//bean.setLblnetamountwords(c.convertAmountToWords(resultSet1.getString("netAmountWords")));
								
							}
				}
				
				if(srno==1){
				
				String sql2 = "",joins="",casestatement="",sql3="";
	
				joins=commonDAO.getFinanceVocTablesJoins(conn);
        		casestatement=commonDAO.getFinanceVocTablesCase(conn);
	
				sql2="Select @i:=@i+1 srno,"+casestatement+"a.transType, a.description, a.date, a.ref_detail, format(a.tramt,2) tramt, format(a.applying,2) applying, format(a.balance,2) balance, a.out_amount, a.tranid, a.acno, a.currency, a.brhid,round(@j:=@j+a.applying,2) netapplied from ( "
						+ "select t.doc_no transno,t.dtype transType,t.ref_detail,t.description description,DATE_FORMAT(t.date,'%d-%m-%Y') date,round(((t.dramount*t.id)-(t.out_amount*t.id)+d.amount),2) tramt,"
						+ "round(d.amount,2) applying,round(((t.dramount*t.id)-(t.out_amount*t.id)),2) balance,t.out_amount,t.tranid,t.acno,t.curId currency,t.brhid from my_outd d left join my_jvtran t on "
						+ "d.ap_trid=t.tranid where d.tranid=(SELECT tranid FROM my_jvtran where TR_NO='"+trno+"' and acno='"+acno+"')) a"+joins+",(select @i:=0) as i,(select @j:=0) as j";
				
				sql3="Select @i:=@i+1 srno,"+casestatement+" a.description,a.date,date_format(date_add(a.ddate,interval (select period from my_acbook where acno='"+acno+"') day),'%d-%m-%Y') duedate,a.tramt amount,a.tramt amount1 from ( "
						+ "select t.doc_no transno,t.dtype transType,t.ref_detail,t.description description,DATE_FORMAT(t.date,'%d-%m-%Y') date,t.date ddate,round(((t.dramount*t.id)-(t.out_amount*t.id)+d.amount),2) tramt,"
						+ "round(d.amount,2) applying,round(((t.dramount*t.id)-(t.out_amount*t.id)),2) balance,t.out_amount,t.tranid,t.acno,t.curId currency,t.brhid from my_outd d left join my_jvtran t on "
						+ "d.ap_trid=t.tranid where d.tranid=(SELECT tranid FROM my_jvtran where TR_NO='"+trno+"' and acno='"+acno+"')) a"+joins+",(select @i:=0) as i,(select @j:=0) as j";
				System.out.println("pymntprintqry======"+sql3);
				ResultSet resultSet2 = stmtBPV.executeQuery(sql2);
				
				ArrayList<String> printapply= new ArrayList<String>();
				
				while(resultSet2.next()){
					bean.setFirstarray(1);
					bean.setLblnetapplied(resultSet2.getString("netapplied"));
					String temp="";
					temp=resultSet2.getString("transno")+"::"+resultSet2.getString("transtype")+"::"+resultSet2.getString("date")+"::"+resultSet2.getString("description")+"::"+resultSet2.getString("tramt")+"::"+resultSet2.getString("applying")+"::"+resultSet2.getString("balance");
					printapply.add(temp);
				}

				bean.setApplyquery(sql2);				
				bean.setPrintquery(sql3);
				request.setAttribute("printapplying", printapply);
			
				}
				
				
				String sqlbank = "select h.description bank,CASE WHEN m.chqname is null THEN h.description WHEN m.chqname='' THEN h.description Else m.chqname END as 'description' from my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no left join my_head h on d.acno=h.doc_no where m.dtype='BPV' and d.sr_no=0 and m.brhid="+branch+" and m.doc_no="+docNo+"";

				ResultSet resultSetbank = stmtBPV.executeQuery(sqlbank);
				
				while(resultSetbank.next()){
					bean.setBank(resultSetbank.getString("bank"));
					bean.setPaidto(resultSetbank.getString("description"));
					
				}
				
				String sql1 = "";
	
				sql1="SELECT t.account,t.description accountname,c.code currency,d.description,if(d.amount>0,format(round((d.amount*1),2),2),'  ') debit,if(d.amount<0,format(round((d.amount*-1),2),2),' ') credit FROM my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no "
					 + "left join my_head t on d.acno=t.doc_no left join my_curr c on c.doc_no=d.curId WHERE m.dtype='BPV' and m.brhid="+branch+" and m.doc_no="+docNo+" order by d.amount desc";
				
				ResultSet resultSet1 = stmtBPV.executeQuery(sql1);
				
				ArrayList<String> printarray= new ArrayList<String>();
				
				while(resultSet1.next()){
					bean.setSecarray(2); 
					String temp="";
					temp=resultSet1.getString("account")+"::"+resultSet1.getString("accountname")+"::"+resultSet1.getString("description")+"::"+resultSet1.getString("currency")+"::"+resultSet1.getString("debit")+"::"+resultSet1.getString("credit");
				    printarray.add(temp);
				}
				request.setAttribute("printingarray", printarray);
				
				String sql3 = "select min(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,min(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat,  "
						+ " coalesce(u2.user_name, u1.user_name)  verifiedappr"
						+ " ,date_format(coalesce(ext1.apprdate,ext.apprdate),'%d-%m-%Y') verifybydt, date_format(coalesce(ext1.apprdate,ext.apprdate),'%H:%i:%s') verifybyat,coalesce(u3.user_name,'') approved ,"
						+ " date_format(ext2.apprdate,'%d-%m-%Y') approvedt, date_format(ext2.apprdate,'%H:%i:%s') approveat from my_chqbm m "
						+ " inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) "
						+ " left join my_exdet ext on (m.doc_no=ext.doc_no and m.dtype=ext.dtype and ext.apprLEVEL=1)"
						+ " left join my_exdet ext1 on (m.doc_no=ext1.doc_no and m.dtype=ext1.dtype   and ext1.apprLEVEL=2)"
						+ " left join my_exdet ext2 on (m.doc_no=ext2.doc_no and m.dtype=ext2.dtype   and ext2.apprLEVEL=3)"
						+ " left join my_user u on m.userid=u.doc_no left join my_user u1 on ext.userid=u1.doc_no"
						+ " left join my_user u2 on ext1.userid=u2.doc_no "
						+ " left join my_user u3 on ext2.userid=u3.doc_no "
						+ " where m.dtype='BPV' and m.brhid="+branch+" and m.doc_no="+docNo+"";
				System.out.println("==================="+sql3);
				ResultSet resultSet3 = stmtBPV.executeQuery(sql3);
				
				while(resultSet3.next()){
					bean.setLblpreparedon(resultSet3.getString("preparedon"));
					bean.setLblpreparedat(resultSet3.getString("preparedat"));
					
					
					bean.setVerifiedappr(resultSet3.getString("verifiedappr"));
					bean.setVerifybydt(resultSet3.getString("verifybydt"));
					bean.setVerifybyat(resultSet3.getString("verifybyat"));
					bean.setApproved(resultSet3.getString("approved"));
					bean.setApprovedt(resultSet3.getString("approvedt"));
					bean.setApproveat(resultSet3.getString("approveat"));
					
				}
		
				
				stmtBPV.close();
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
	 
	 public ClsBankPaymentBean getChequePrint(int docno,int branch) throws SQLException {
		 ClsBankPaymentBean bean = new ClsBankPaymentBean();
		 Connection conn = null;
			
		try {
			conn = connDAO.getMyConnection();
			Statement stmtBPV = conn.createStatement();
			String amountwordslength="";
			int accountno=0;
			
			String sqls="select d.acno from my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no where d.sr_no=0 and m.dtype='BPV' and m.brhid="+branch+" and "
					+ "m.doc_no="+docno+"";
			
			ResultSet resultSets = stmtBPV.executeQuery(sqls);
			
			while(resultSets.next()){
				accountno=resultSets.getInt("acno");
			}
			
			/* 1 pixel = 0.02645833333333 centimeter ## 1 centimeter = 37.79527559055 pixel */
			
			String sql="select printpath,round((chqheight*0.3937007874016),2) chqheightin,round((chqwidth*0.3937007874016),2) chqwidthin,round((chqheight*37.79527559055),2) chqheight,"
				+ "round((chqwidth*37.79527559055),2) chqwidth,round((paytover*37.79527559055),2) paytover,round(((3+paytohor)*37.79527559055),2) paytohor,"
				+ "round((paytolen*37.79527559055),2) paytolen,round(((chqdate_x-3)*37.79527559055),2) chqdate_x,round((accountpay_x*37.79527559055),2) accountpay_x,"
				+ "round((accountpay_y*37.79527559055),2) accountpay_y,round((chqdate_y*37.79527559055),2) chqdate_y,round((amtver*37.79527559055),2) amtver,"
				+ "round(((3+amthor)*37.79527559055),2) amthor,round((amtlen*37.79527559055),2) amtlen,round((amt1ver*37.79527559055),2) amt1ver,"
				+ "round(((3+amt1hor)*37.79527559055),2) amt1hor,round((amt1len*37.79527559055),2) amt1len,round(((amount_x-3)*37.79527559055),2) amount_x,"
				+ "round((amount_y*37.79527559055),2) amount_y  from my_chqsetup where status=3 and bankdocno="+accountno+"";
            System.out.println("cheque print===="+sql);
			ResultSet resultSet = stmtBPV.executeQuery(sql);
			
			while(resultSet.next()){
				
				bean.setPrinturl(resultSet.getString("printpath"));
				bean.setLblpagesheight(resultSet.getString("chqheightin"));
				bean.setLblpageswidth(resultSet.getString("chqwidthin"));
				bean.setLblpageheight(resultSet.getString("chqheight"));
				bean.setLblpagewidth(resultSet.getString("chqwidth"));
				bean.setLblpaytovertical(resultSet.getString("paytover"));
				bean.setLblpaytohorizontal(resultSet.getString("paytohor"));
				bean.setLblpaytolength(resultSet.getString("paytolen"));
				bean.setLbldatex(resultSet.getString("chqdate_x"));
				bean.setLbldatey(resultSet.getString("chqdate_y"));
				
				bean.setLblaccountpayingx(resultSet.getString("accountpay_x"));
				bean.setLblaccountpayingy(resultSet.getString("accountpay_y"));
				bean.setLblamtwordsvertical(resultSet.getString("amtver"));
				bean.setLblamtwordshorizontal(resultSet.getString("amthor"));
				bean.setLblamtwordslength(resultSet.getString("amtlen"));
				bean.setLblamountx(resultSet.getString("amount_x"));
				bean.setLblamounty(resultSet.getString("amount_y"));
				bean.setLblamtwords1vertical(resultSet.getString("amt1ver"));
				bean.setLblamtwords1horizontal(resultSet.getString("amt1hor"));
				bean.setLblamtwords1length(resultSet.getString("amt1len"));
				
				amountwordslength=resultSet.getString("amtlen");
			}
			
			String sql1="select c.chqno,m.doc_no docno,DATE_FORMAT(m.date,'%d-%m-%Y') docdate,DATE_FORMAT(c.chqdt,'%d-%m-%Y') chqdt,CASE WHEN m.chqname is null THEN t.description WHEN m.chqname='' THEN "  
					+ "t.description Else m.chqname END as 'description',(select format(round(if(d.amount<0,d.amount*-1,d.amount),2),2) amount from my_chqbm m "  
					+ "left join my_chqbd d on m.tr_no=d.tr_no where d.sr_no=0 and m.dtype='BPV' and m.brhid="+branch+" and m.doc_no="+docno+") amount,"
					+ "(select round(if(d.amount<0,d.amount*-1,d.amount),2) amountinwords from my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no "
					+ "where d.sr_no=0 and m.dtype='BPV' and m.brhid="+branch+" and m.doc_no="+docno+") amountinwords from my_chqbm m left join my_chqbd d "
					+ "on m.tr_no=d.tr_no left join my_chqdet c on d.tr_no=c.tr_no left join my_head t on c.opsacno=t.doc_no where m.dtype='BPV' and m.status<>7 "
					+ "and m.brhid="+branch+" and m.doc_no="+docno+" group by m.tr_no";
			
				ResultSet resultSet1 = stmtBPV.executeQuery(sql1);
				
				while(resultSet1.next()){

					/* 1 character = 0.2116666666667 centimeter ## 1 centimeter = 4.724409448819 character
					   1 character = 8 pixel ## 1 pixel = 0.125 character */
					bean.setLblchqno(resultSet1.getString("chqno"));
					bean.setLblchequedate(resultSet1.getString("chqdt"));
					bean.setLblpaidto(resultSet1.getString("description"));
					bean.setLblamount(resultSet1.getString("amount"));
					bean.setLbldate(resultSet1.getString("docdate"));
					bean.setLblvoucherno(resultSet1.getString("docno"));
					
					ClsChequeAmountToWords c = new ClsChequeAmountToWords();
					
					double chequelength = Double.parseDouble(amountwordslength)*0.125;
					
					String amountwords = c.convertChequeAmountToWords(resultSet1.getString("amountinwords"));
					
					if(amountwords.length()>chequelength){
						
						String breakedstring = commonDAO.addLinebreaks(amountwords, chequelength);
						
						if(breakedstring.contains("::")){
							String[] breakedstringarray = breakedstring.split("::");
						
							String amountinwords1 = breakedstringarray[0]; 
							String amountinwords2 = breakedstringarray[1];
						
							bean.setLblamountwords(amountinwords1);
							bean.setLblamountwords1(amountinwords2);
						}else{
							bean.setLblamountwords(breakedstring);
						}
					}else{
						bean.setLblamountwords(amountwords);
					}
				}
				
				stmtBPV.close();
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
	 
	 public ClsBankPaymentBean getPaymentPrint(int docno,int branch) throws SQLException {
		 ClsBankPaymentBean bean = new ClsBankPaymentBean();
		 Connection conn = null;
			
		try {
			conn = connDAO.getMyConnection();
			Statement stmtBPV = conn.createStatement();
			String amountwordslength="";
			int accountno=0;
			
			String sqls="select d.acno from my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no where d.sr_no=0 and m.dtype='BPV' and m.brhid="+branch+" and "
					+ "m.doc_no="+docno+"";
			
			ResultSet resultSets = stmtBPV.executeQuery(sqls);
			
			while(resultSets.next()){
				accountno=resultSets.getInt("acno");
			}
			
			/* 1 pixel = 0.02645833333333 centimeter ## 1 centimeter = 37.79527559055 pixel */
			
			String sql="select printpath,round((chqheight*0.3937007874016),2) chqheightin,round((chqwidth*0.3937007874016),2) chqwidthin,round((chqheight*37.79527559055),2) chqheight,"
				+ "round((chqwidth*37.79527559055),2) chqwidth,round((paytover*37.79527559055),2) paytover,round(((3+paytohor)*37.79527559055),2) paytohor,"
				+ "round((paytolen*37.79527559055),2) paytolen,round(((chqdate_x-3)*37.79527559055),2) chqdate_x,round((accountpay_x*37.79527559055),2) accountpay_x,"
				+ "round((accountpay_y*37.79527559055),2) accountpay_y,round((chqdate_y*37.79527559055),2) chqdate_y,round((amtver*37.79527559055),2) amtver,"
				+ "round(((3+amthor)*37.79527559055),2) amthor,round((amtlen*37.79527559055),2) amtlen,round((amt1ver*37.79527559055),2) amt1ver,"
				+ "round(((3+amt1hor)*37.79527559055),2) amt1hor,round((amt1len*37.79527559055),2) amt1len,round(((amount_x-3)*37.79527559055),2) amount_x,"
				+ "round((amount_y*37.79527559055),2) amount_y  from my_chqsetup where status=3 and bankdocno="+accountno+"";

			ResultSet resultSet = stmtBPV.executeQuery(sql);
			
			while(resultSet.next()){
				
				bean.setPrinturl(resultSet.getString("printpath"));
				bean.setLblpagesheight(resultSet.getString("chqheightin"));
				bean.setLblpageswidth(resultSet.getString("chqwidthin"));
				bean.setLblpageheight(resultSet.getString("chqheight"));
				bean.setLblpagewidth(resultSet.getString("chqwidth"));
				bean.setLblpaytovertical(resultSet.getString("paytover"));
				bean.setLblpaytohorizontal(resultSet.getString("paytohor"));
				bean.setLblpaytolength(resultSet.getString("paytolen"));
				bean.setLbldatex(resultSet.getString("chqdate_x"));
				bean.setLbldatey(resultSet.getString("chqdate_y"));
				
				bean.setLblaccountpayingx(resultSet.getString("accountpay_x"));
				bean.setLblaccountpayingy(resultSet.getString("accountpay_y"));
				bean.setLblamtwordsvertical(resultSet.getString("amtver"));
				bean.setLblamtwordshorizontal(resultSet.getString("amthor"));
				bean.setLblamtwordslength(resultSet.getString("amtlen"));
				bean.setLblamountx(resultSet.getString("amount_x"));
				bean.setLblamounty(resultSet.getString("amount_y"));
				bean.setLblamtwords1vertical(resultSet.getString("amt1ver"));
				bean.setLblamtwords1horizontal(resultSet.getString("amt1hor"));
				bean.setLblamtwords1length(resultSet.getString("amt1len"));
				
				amountwordslength=resultSet.getString("amtlen");
			}
			
			String sql1="select c.chqno,DATE_FORMAT(c.chqdt,'%d-%m-%Y') chqdt,CASE WHEN m.chqname is null THEN t.description WHEN m.chqname='' THEN "  
					+ "t.description Else m.chqname END as 'description',(select format(round(if(d.amount<0,d.amount*-1,d.amount),2),2) amount from my_chqbm m "  
					+ "left join my_chqbd d on m.tr_no=d.tr_no where d.sr_no=0 and m.dtype='BPV' and m.brhid="+branch+" and m.doc_no="+docno+") amount,"
					+ "(select round(if(d.amount<0,d.amount*-1,d.amount),2) amountinwords from my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no "
					+ "where d.sr_no=0 and m.dtype='BPV' and m.brhid="+branch+" and m.doc_no="+docno+") amountinwords from my_chqbm m left join my_chqbd d "
					+ "on m.tr_no=d.tr_no left join my_chqdet c on d.tr_no=c.tr_no left join my_head t on c.opsacno=t.doc_no where m.dtype='BPV' and m.status<>7 "
					+ "and m.brhid="+branch+" and m.doc_no="+docno+" group by m.tr_no";
			
				ResultSet resultSet1 = stmtBPV.executeQuery(sql1);
				
				while(resultSet1.next()){

					/* 1 character = 0.2116666666667 centimeter ## 1 centimeter = 4.724409448819 character
					   1 character = 8 pixel ## 1 pixel = 0.125 character */
					
					bean.setLblchequedate(resultSet1.getString("chqdt"));
					bean.setLblpaidto(resultSet1.getString("description"));
					bean.setLblamount(resultSet1.getString("amount"));
					
					ClsChequeAmountToWords c = new ClsChequeAmountToWords();
					
					double chequelength = Double.parseDouble(amountwordslength)*0.125;
					
					String amountwords = c.convertChequeAmountToWords(resultSet1.getString("amountinwords"));
					
					if(amountwords.length()>chequelength){
						
						String breakedstring = commonDAO.addLinebreaks(amountwords, chequelength);
						
						if(breakedstring.contains("::")){
							String[] breakedstringarray = breakedstring.split("::");
						
							String amountinwords1 = breakedstringarray[0]; 
							String amountinwords2 = breakedstringarray[1];
						
							bean.setLblamountwords(amountinwords1);
							bean.setLblamountwords1(amountinwords2);
						}else{
							bean.setLblamountwords(breakedstring);
						}
					}else{
						bean.setLblamountwords(amountwords);
					}
				}
				
				stmtBPV.close();
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
	 
	 public JSONArray bpvMainSearch(HttpSession session,String partyname,String docNo,String date,String amount,String chequeNo,String chequeDt,String check,String chequename) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	        if(!(check.equalsIgnoreCase("1"))){
	        	return RESULTDATA;
	        }
	        System.out.println("IN");
	        Connection conn = null;
	           String branch=session.getAttribute("BRANCHID").toString();     
	       
	        java.sql.Date sqlBankDate=null;
	        java.sql.Date sqlChequeDate=null;
	           
	     try {
		       conn = connDAO.getMyConnection();
		       Statement stmtBPV = conn.createStatement();
		       
		       date.trim();
		        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
		        {
		        sqlBankDate = commonDAO.changeStringtoSqlDate(date);
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
//		         sqltest=sqltest+" and if(h.description is null,h1.description,h.description) like '%"+partyname+"%'";
		         sqltest=sqltest+" and (h.description like '%"+partyname+"%' or h1.description  like '%"+partyname+"%' )" ;
		        }
		        if(!(amount.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and d0.amount*d0.dr like '%"+amount+"%'";       
		        }
		        if(!(chequeNo.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and m.chqno like '%"+chequeNo+"%'";
		        }
		        if(!(sqlBankDate==null)){
			         sqltest=sqltest+" and m.date='"+sqlBankDate+"'";
			        } 
		         if(!(sqlChequeDate==null)){
		         sqltest=sqltest+" and m.chqdt='"+sqlChequeDate+"'";
		        } 
		         if(!(chequename.equalsIgnoreCase(""))){          
			         sqltest=sqltest+" and m.chqname like '%"+chequename+"%'" ;  
			        }
		      String sql="select m.chqname,m.date,m.doc_no,m.totalAmount amount0,if(h.description is null,h1.description,h.description) description,m.chqno,m.chqdt,d0.amount*d0.dr amount from my_chqbm m left join my_chqbd d0 on m.tr_no=d0.tr_no and d0.sr_no=0 "
			       		+ "left join my_chqbd d on m.tr_no=d.tr_no and d.sr_no=1 left join my_chqbd d1 on m.tr_no=d1.tr_no and d1.sr_no=2 left join my_chqdet c on c.tr_no=d.tr_no left join my_head h on d.acno=h.doc_no left join my_head h1 on d1.acno=h1.doc_no "
			       		+ "left join my_brch b on m.brhid=b.doc_no where m.brhid="+branch+" and m.dtype='BPV' and m.status <> 7" +sqltest;
		        
		      System.out.println();
		      ResultSet resultSet = stmtBPV.executeQuery(sql);
		         
		       RESULTDATA=commonDAO.convertToJSON(resultSet);
		       
		       stmtBPV.close();
		       conn.close();
	     }
	     catch(Exception e){
	    	 	e.printStackTrace();
	    	 	conn.close();
	     }
           return RESULTDATA;
       }
	 
	 public int insertion(Connection conn,int docno,int trno,String formdetailcode,Date bankPaymentDate, String txtrefno, double txtfromrate, Date chequeDate, String txtchequeno, 
			 int chckpdc, String txtdescription, double txtdrtotal, double txtapplyinvoiceapply, ArrayList<String> bankpaymentarray,ArrayList<String> applyinvoicearray,
			 HttpSession session,String mode) throws SQLException{
		
		  try{
				conn.setAutoCommit(false);
				CallableStatement stmtBPV;
				Statement stmtBPV1 = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				/*Bank Payment Grid and Details Saving*/
				for(int i=0;i< bankpaymentarray.size();i++){
					String[] bankpay=bankpaymentarray.get(i).split("::");
					if(!bankpay[0].trim().equalsIgnoreCase("undefined") && !bankpay[0].trim().equalsIgnoreCase("NaN")){
					
					int cash = 0;
					int id = 0;
					if(bankpay[3].trim().equalsIgnoreCase("true")){
						cash=0;
						id=1;
					}
					else if(bankpay[3].trim().equalsIgnoreCase("false")){
						cash=1;
						id=-1;
					}
					
					String description=(bankpay[5].trim().equalsIgnoreCase("undefined") || bankpay[5].trim().equalsIgnoreCase("NaN") || bankpay[5].trim().isEmpty()?0:bankpay[5].trim()).toString();
					
					if(description.contains(" CHQNO -")){
						String[] descriptionsplited = description.split(" CHQNO -");
						description = descriptionsplited[0]+"  CHQNO -"+txtchequeno+" CHQ DATE -"+chequeDate.toString();
					} else {
						description=(description+"  CHQNO -"+txtchequeno+" CHQ DATE -"+chequeDate.toString());
					}
					
					stmtBPV = conn.prepareCall("{CALL chqbdDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					/*Insertion to my_chqbd*/
					stmtBPV.setInt(21,trno); 
					stmtBPV.setInt(22,docno);
					stmtBPV.registerOutParameter(23, java.sql.Types.INTEGER);
					stmtBPV.setInt(1,i); //SR_NO
					stmtBPV.setString(2,(bankpay[0].trim().equalsIgnoreCase("undefined") || bankpay[0].trim().equalsIgnoreCase("NaN") || bankpay[0].trim().isEmpty()?0:bankpay[0].trim()).toString());  //doc_no of my_head
					stmtBPV.setString(3,(bankpay[1].trim().equalsIgnoreCase("undefined") || bankpay[1].trim().equalsIgnoreCase("NaN") || bankpay[1].trim().isEmpty()?0:bankpay[1].trim()).toString()); //curId
					stmtBPV.setString(4,(bankpay[2].trim().equalsIgnoreCase("undefined") || bankpay[2].trim().equalsIgnoreCase("NaN") || bankpay[2].trim().equals(0) || bankpay[2].isEmpty()?1:bankpay[2].trim()).toString()); //rate 
					stmtBPV.setInt(5,id); //#credit -1 / debit 1 
					stmtBPV.setString(6,(bankpay[4].trim().equalsIgnoreCase("undefined") || bankpay[4].trim().equalsIgnoreCase("NaN") || bankpay[4].trim().isEmpty()?0:bankpay[4].trim()).toString()); //amount
					stmtBPV.setString(7,description); //description
					stmtBPV.setString(8,(bankpay[6].trim().equalsIgnoreCase("undefined") || bankpay[6].trim().equalsIgnoreCase("NaN") || bankpay[6].trim().isEmpty()?0:bankpay[6].trim()).toString()); //baseamount
					stmtBPV.setInt(9,cash); //For cash = 0/ party = 1
					stmtBPV.setString(10,(bankpay[8].trim().equalsIgnoreCase("undefined") || bankpay[8].trim().equalsIgnoreCase("NaN") || bankpay[8].trim().equalsIgnoreCase("") || bankpay[8].trim().equalsIgnoreCase("0") || bankpay[8].trim().isEmpty()?"0":bankpay[8].trim()).toString()); //Cost type
					stmtBPV.setString(11,(bankpay[9].trim().equalsIgnoreCase("undefined") || bankpay[9].trim().equalsIgnoreCase("NaN") || bankpay[9].trim().equalsIgnoreCase("") || bankpay[9].trim().equalsIgnoreCase("0") || bankpay[9].trim().isEmpty()?"0":bankpay[9].trim()).toString()); //Cost Code
					/*my_chqbd Ends*/
					
					/*Insertion to my_jvtran*/
					stmtBPV.setDate(12,bankPaymentDate);
					stmtBPV.setString(13,(bankpay[10].trim().equalsIgnoreCase("undefined") || bankpay[10].trim().equalsIgnoreCase("NaN") || bankpay[10].trim().isEmpty()?0:bankpay[10].trim()).toString()); //pdc
					stmtBPV.setString(14,(bankpay[11].trim().equalsIgnoreCase("undefined") || bankpay[11].trim().equalsIgnoreCase("NaN") || bankpay[11].trim().isEmpty()?0:bankpay[11].trim()).toString()); //pdc account no
					stmtBPV.setString(15,txtrefno);
					stmtBPV.setInt(16,id);  //id
					stmtBPV.setString(17,(bankpay[7].trim().equalsIgnoreCase("undefined") || bankpay[7].trim().equalsIgnoreCase("NaN") || bankpay[7].trim().isEmpty()?0:bankpay[7].trim()).toString());  //out-amount
					/*my_jvtran Ends*/
					
					stmtBPV.setString(18,formdetailcode);
					stmtBPV.setString(19,branch);
					stmtBPV.setString(20,userid);
					stmtBPV.setString(24,mode);
					stmtBPV.execute();
					if(stmtBPV.getInt("irowsNo")<=0){
						stmtBPV.close();
						conn.close();
						return 0;
					}
					}
				    }
				    /*Bank Payment Grid and Details Saving Ends*/
				
					/*Apply-Bank Invoicing Grid Saving*/
					for(int j=0;j< applyinvoicearray.size();j++){
					String[] apply=applyinvoicearray.get(j).split("::");
					if(!apply[0].trim().equalsIgnoreCase("undefined") && !apply[0].trim().equalsIgnoreCase("NaN")){
					
					stmtBPV = conn.prepareCall("{CALL applyBankInvoicingDML(?,?,?,?,?,?,?)}");
					/*Insertion to my_outd*/
					stmtBPV.setString(1,(apply[1].trim().equalsIgnoreCase("undefined") || apply[1].trim().equalsIgnoreCase("NaN") || apply[1].trim().isEmpty()?0:apply[1].trim()).toString()); //Out amount
					stmtBPV.setString(2,(apply[0].trim().equalsIgnoreCase("undefined") || apply[0].trim().equalsIgnoreCase("NaN") || apply[0].trim().isEmpty()?0:apply[0].trim()).toString()); //Applied Amount
					stmtBPV.setString(3,(apply[2].trim().equalsIgnoreCase("undefined") || apply[2].trim().equalsIgnoreCase("NaN") || apply[2].trim().isEmpty()?0:apply[2].trim()).toString()); //Currency
					stmtBPV.setInt(4,trno);  //tr_no
					stmtBPV.setInt(5,Integer.parseInt((apply[3].trim().equalsIgnoreCase("undefined") || apply[3].trim().equalsIgnoreCase("NaN") || apply[3].trim().isEmpty()?0:apply[3].trim()).toString())); //tranid
					stmtBPV.setInt(6,Integer.parseInt((apply[4].trim().equalsIgnoreCase("undefined") || apply[4].trim().equalsIgnoreCase("NaN") || apply[4].trim().isEmpty()?0:apply[4].trim()).toString())); //account
					stmtBPV.setString(7,mode);	
					int applybankcheck=stmtBPV.executeUpdate();
					if(applybankcheck<=0){
							stmtBPV.close();
							conn.close();
							return 0;
						}
						stmtBPV.close();
					 }
					
				}
				/*Apply-Bank Invoicing Grid Saving Ends*/
					
				int trid=0,id = 0;
				/*Selecting Tran-Id & Id*/
				String sqls=("select j.TRANID,j.ID from my_jvtran j inner join my_chqbd d on (d.acno =j.acno and d.tr_no =j.tr_no and d.sr_no=1) where j.tr_no="+trno);
				ResultSet resultSets = stmtBPV1.executeQuery(sqls);
				    
				 while (resultSets.next()) {
					 trid=resultSets.getInt("TRANID");
				     id=resultSets.getInt("ID");
				 }
				 /*Selecting Tran-Id & Id Ends*/
				
				/*Updating my_jvtran*/
				String sql3=("update my_jvtran set out_amount="+(txtapplyinvoiceapply)*id+" where tranid="+trid);
				int data3 = stmtBPV1.executeUpdate(sql3);
				if(data3<=0){
					stmtBPV1.close();
					conn.close();
					return 0;
				}
				/*Updating my_jvtran Ends*/
				
				/*Deleting account of value zero*/
				String sql2=("DELETE FROM my_jvtran where TR_NO="+trno+" and acno=0");
			    int data = stmtBPV1.executeUpdate(sql2);
			     
			    String sql4=("DELETE FROM my_chqbd where TR_NO="+trno+" and acno=0");
			    int data1 = stmtBPV1.executeUpdate(sql4);
			     /*Deleting account of value zero ends*/
					
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}
	 
}
