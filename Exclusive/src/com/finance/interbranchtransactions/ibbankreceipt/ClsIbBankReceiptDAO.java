package com.finance.interbranchtransactions.ibbankreceipt;

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
import com.common.ClsChequeAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsIbBankReceiptDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsIbBankReceiptBean ibBankReceiptBean = new ClsIbBankReceiptBean();
	
	  public int insert(Date ibBankReceiptDate, String formdetailcode, String txtrefno,double txtfromrate,Date chequeDate, String txtchequeno, String txttoaccname, int chckpdc,String txtdescription, 
			double txtdrtotal, int txttodocno, double txtapplyinvoiceapply, ArrayList<String> ibbankreceiptarray, ArrayList<String> applyibinvoicearray, HttpSession session,HttpServletRequest request,String mode) throws SQLException {
		  
		  Connection conn = null;
		  
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			int total = 0;
			
			CallableStatement stmtIBR = conn.prepareCall("{CALL chqbmDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtIBR.registerOutParameter(13, java.sql.Types.INTEGER);
			stmtIBR.registerOutParameter(14, java.sql.Types.INTEGER);
			stmtIBR.setDate(1,ibBankReceiptDate);
			stmtIBR.setString(2,txtrefno);
			stmtIBR.setString(3,txtdescription);
			stmtIBR.setString(4,txtchequeno);
			stmtIBR.setDate(5,chequeDate);
			stmtIBR.setString(6,txttoaccname);
			stmtIBR.setDouble(7,txtdrtotal);
			stmtIBR.setDouble(8,txtfromrate);
			stmtIBR.setString(9,formdetailcode);
			stmtIBR.setString(10,company);
			stmtIBR.setString(11,branch);
			stmtIBR.setString(12,userid);
			stmtIBR.setString(15,mode);
			int datas=stmtIBR.executeUpdate();
			if(datas<=0){
				stmtIBR.close();
				conn.close();
				return 0;
			}
			int docno=stmtIBR.getInt("docNo");
			int trno=stmtIBR.getInt("itranNo");
			request.setAttribute("tranno", trno);
			ibBankReceiptBean.setTxtibbankreceiptdocno(docno);
			if (docno > 0) {
				
				/*Insertion to my_chqdet*/
				String sql=("insert into my_chqdet(chqno,chqdt,opsacno,pdc,Status,postno,tr_no,brhId) values('"+txtchequeno+"','"+chequeDate+"',"+txttodocno+",'"+chckpdc+"','E',0,'"+trno+"','"+branch+"')");
				int data = stmtIBR.executeUpdate(sql);
				if(data<=0){
					stmtIBR.close();
					conn.close();
					return 0;
				}
				/*my_chqdet Ends*/
				
				/*Insertion to my_chqbd,my_jvtran,my_outd*/
				int insertData=insertion(conn, docno, trno, formdetailcode, ibBankReceiptDate, txtrefno, txtfromrate, chequeDate, txtchequeno, chckpdc, txtdescription, txtdrtotal, txtapplyinvoiceapply, ibbankreceiptarray, applyibinvoicearray, session, mode);
				if(insertData<=0){
					stmtIBR.close();
					conn.close();
					return 0;
				}
				/*Insertion to my_chqbd,my_jvtran,my_outd Ends*/
				
				String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
				ResultSet resultSet = stmtIBR.executeQuery(sql1);
			    
				 while (resultSet.next()) {
				 total=resultSet.getInt("jvtotal");
				 }

				 if(total == 0){
					conn.commit();
					stmtIBR.close();
					conn.close();
					return docno;
				 }else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
					    stmtIBR.close();
					    return 0;
				    }
			}
		 stmtIBR.close();
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
			
	
	public boolean edit(int txtibbankreceiptdocno, String formdetailcode, Date ibBankReceiptDate,String txtrefno, String txtdescription, double txtfromrate, double txtdrtotal, int txttodocno, 
			int txttotrno,Date chequeDate, String txtchequeno, String txttoaccname, int chckpdc, double txtapplyinvoiceapply, ArrayList<String> ibbankreceiptarray, ArrayList<String> applyibinvoicearray,ArrayList<String> applyinvoiceibupdatearray, 
			HttpSession session,String mode) throws SQLException {
		
		Connection conn = null;
		
		 try{
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtIBR = conn.createStatement();
				
				if(mode.equalsIgnoreCase("EDIT")){
					mode="E";
				}
				
				int trno = txttotrno,trid = 0,total = 0;
			    String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String company=session.getAttribute("COMPANYID").toString().trim();
				
				/*Updating my_chqbm*/
                String sql=("update my_chqbm set date='"+ibBankReceiptDate+"',RefNo='"+txtrefno+"',DESC1='"+txtdescription+"',mrate="+txtfromrate+",chqno='"+txtchequeno+"',chqdt='"+chequeDate+"',chqname='"+txttoaccname+"',trMode=3,totalAmount="+txtdrtotal+",DTYPE='"+formdetailcode+"',cmpId="+company+",brhId="+branch+" where TR_NO="+trno+" and doc_no="+txtibbankreceiptdocno);
                int data = stmtIBR.executeUpdate(sql);
				if(data<=0){
					stmtIBR.close();
					conn.close();
					return false;
				}
				/*Updating my_chqbm Ends*/
				
				/*Inserting into datalog*/
				String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtibbankreceiptdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
				int datas = stmtIBR.executeUpdate(sqls);
				/*Inserting into datalog Ends*/
			    
			    String sql1=("DELETE FROM my_chqbd WHERE TR_NO="+trno);
			    int data1 = stmtIBR.executeUpdate(sql1);
			    
				 String sql2=("SELECT TRANID FROM my_jvtran where TR_NO="+trno+" and acno="+txttodocno);
				 ResultSet resultSet = stmtIBR.executeQuery(sql2);
				    
				 while (resultSet.next()) {
				 trid=resultSet.getInt("TRANID");
				 }
				    
				 String sql3=("DELETE FROM my_outd WHERE TRANID="+trid);
				 int data3 = stmtIBR.executeUpdate(sql3);
				 
				 String sql4=("DELETE FROM my_jvtran WHERE TR_NO="+trno);
				 int data4 = stmtIBR.executeUpdate(sql4);
				 
				 String sql5=("DELETE FROM my_costtran WHERE TR_NO="+trno);
				 int data5 = stmtIBR.executeUpdate(sql5);
			    
			    /*Apply-Invoicing Grid Updating*/
				for(int i=0;i< applyinvoiceibupdatearray.size();i++){
				String[] applyupdate=applyinvoiceibupdatearray.get(i).split("::");
                 
				if(!applyupdate[0].trim().equalsIgnoreCase("undefined") && !applyupdate[0].trim().equalsIgnoreCase("NaN")){
					String sql6="update my_jvtran set out_amount='"+(applyupdate[0].trim().equalsIgnoreCase("undefined") || applyupdate[0].trim().equalsIgnoreCase("NaN") || applyupdate[0].trim().isEmpty()?0:applyupdate[0].trim())+"' where TRANID='"+(applyupdate[1].trim().equalsIgnoreCase("undefined") || applyupdate[1].trim().equalsIgnoreCase("NaN") || applyupdate[1].trim().isEmpty()?0:applyupdate[1].trim())+"'";
					int data6 = stmtIBR.executeUpdate(sql6);
						if(data6<=0){
							stmtIBR.close();
							conn.close();
							return false;
						}
				    }
				}
				/*Apply-Invoicing Grid Updating Ends*/
				
				/*Updating my_chqdet*/
	              String sql7=("update my_chqdet set chqno='"+txtchequeno+"',chqdt='"+chequeDate+"',opsacno="+txttodocno+",pdc='"+chckpdc+"',Status='E',postno=0,brhId='"+branch+"' where tr_no="+trno);
				  int data7 = stmtIBR.executeUpdate(sql7);
				  if(data7<=0){
						stmtIBR.close();
						conn.close();
						return false;
					}
				/*Updating my_chqdet Ends*/
			    
			    int docno=txtibbankreceiptdocno;
			    ibBankReceiptBean.setTxtibbankreceiptdocno(docno);
				if (docno > 0) {
				
					/*Insertion to my_chqbd,my_jvtran,my_outd*/
					int insertData=insertion(conn, docno, trno, formdetailcode, ibBankReceiptDate, txtrefno, txtfromrate, chequeDate, txtchequeno, chckpdc, txtdescription, txtdrtotal, txtapplyinvoiceapply, ibbankreceiptarray, applyibinvoicearray, session, mode);
					if(insertData<=0){
						stmtIBR.close();
						conn.close();
						return false;
					}
					/*Insertion to my_chqbd,my_jvtran,my_outd Ends*/
					
					String sql8="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno;
					ResultSet resultSet1 = stmtIBR.executeQuery(sql8);
				    
					 while (resultSet1.next()) {
					 total=resultSet1.getInt("jvtotal");
					 }
					 
					if(total == 0){
						conn.commit();
						stmtIBR.close();
						conn.close();
						return true;
					}else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
					    stmtIBR.close();
					    return false;
				    }
				}
			stmtIBR.close();
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
	
	public boolean editMaster(int txtibbankreceiptdocno, String formdetailcode, Date ibBankReceiptDate,String txtrefno, String txtdescription, double txtfromrate,
			double txtdrtotal, int txttodocno, int txttotrno, HttpSession session) throws SQLException {
		
		Connection conn = null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtIBR = conn.createStatement();
			int trno = txttotrno,trid = 0;
		    String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			
			/*Updating my_chqbm*/
            String sql=("update my_chqbm set date='"+ibBankReceiptDate+"',RefNo='"+txtrefno+"',DESC1='"+txtdescription+"',mrate='"+txtfromrate+"',trMode=3,totalAmount='"+txtdrtotal+"',DTYPE='"+formdetailcode+"',cmpId='"+company+"',brhId='"+branch+"' where TR_NO='"+trno+"' and doc_no="+txtibbankreceiptdocno);
			int data = stmtIBR.executeUpdate(sql);
			if(data<=0){
            	stmtIBR.close();
    			conn.close();
    			return false;
            }
			/*Updating my_chqbm Ends*/
			
			/*Inserting into datalog*/
			String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtibbankreceiptdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
			int datas = stmtIBR.executeUpdate(sqls);
			/*Inserting into datalog Ends*/
			
			conn.commit();
			stmtIBR.close();
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


	public boolean delete(int txtibbankreceiptdocno, String formdetailcode, int txttotrno, int txttodocno, HttpSession session) throws SQLException {
		 
		Connection conn = null;
		
		try{
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtIBR = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				int trno = txttotrno,ap_trid=0;
				double amount=0.00,outamount=0.00;
		        String checkingApplying="0";
				
				  String sqlApply = "SELECT * FROM my_jvtran where out_amount!=0 and TR_NO="+trno+"";
				  ResultSet resultSetsApply=stmtIBR.executeQuery(sqlApply);
				  
				  while(resultSetsApply.next()){
					  checkingApplying="1";
				  }
				  
				  if(checkingApplying.equalsIgnoreCase("1")) {
				  
				 /*Selecting Tran-Id*/
				  ArrayList<String> tranidarray=new ArrayList<>();
				  String sql1="SELECT TRANID FROM my_jvtran where TR_NO="+trno+" and acno="+txttodocno+"";
				  ResultSet resultSet=stmtIBR.executeQuery(sql1);
				  
				  while(resultSet.next()){
				   tranidarray.add(resultSet.getString("tranid"));
				  }
				  /*Selecting Tran-Id Ends*/
				  
				  /*Selecting Ap_Tran-Id*/
				  ArrayList<String> outamtarray=new ArrayList<>();

				  for(int i=0;i<tranidarray.size();i++){
				   String sql2="select ap_trid,amount from my_outd where tranid="+tranidarray.get(i);
				   ResultSet resultSet1=stmtIBR.executeQuery(sql2);
				   
				   while(resultSet1.next()){
				    outamtarray.add(resultSet1.getInt("ap_trid")+"::"+resultSet1.getDouble("amount"));
				   } 

				  }
				  /*Selecting Ap_Tran-Id*/

				  for(int i=0;i<outamtarray.size();i++){
				   
				   ap_trid=Integer.parseInt(outamtarray.get(i).split("::")[0]);
				   amount=Double.parseDouble(outamtarray.get(i).split("::")[1]);

				   String sql4="update my_jvtran set out_amount=out_amount-("+amount+"*id) where tranid="+ap_trid+"";
				   int data1=stmtIBR.executeUpdate(sql4);
				   
				  }
				/*Apply-Invoicing Grid Updating Ends*/
				  
			    /*Selecting outamount*/
			     String sql5="select sum(amount) outamount from my_outd where tranid="+tranidarray.get(0)+"";
			     ResultSet resultSet2=stmtIBR.executeQuery(sql5);
			   
			     while(resultSet2.next()){
				   outamount= resultSet2.getDouble("outamount");
			     }
			    /*Selecting outamount Ends*/
			   
			     String sql4="update my_jvtran set out_amount=out_amount-("+outamount+"*id) where tranid="+tranidarray.get(0)+"";
			     int data3=stmtIBR.executeUpdate(sql4);
				   
				 /*Deleting from my_outd*/
				  String sql3="delete from my_outd where tranid="+tranidarray.get(0)+"";
				  int data2=stmtIBR.executeUpdate(sql3);
				 /*Deleting from my_outd Ends*/
				  
				  }
				  
			     /*Deleting from my_chqdet*/
				 String sql6=("DELETE FROM my_chqdet WHERE tr_no="+trno+"");
				 int data4 = stmtIBR.executeUpdate(sql6);
				 /*Deleting from my_chqdet Ends*/
				 
				 /*Status change in my_chqbm*/
				 String sql7=("update my_chqbm set STATUS=7 where doc_no="+txtibbankreceiptdocno+" and TR_NO="+trno+" and dtype='"+formdetailcode+"'");
				 int data5 = stmtIBR.executeUpdate(sql7);
				 if(data5<=0){
		            	stmtIBR.close();
		    			conn.close();
		    			return false;
		            }
				/*Status change in my_chqbm Ends*/

				 /*Status change in my_jvtran*/
				 String sql8=("update my_jvtran set STATUS=7 where doc_no="+txtibbankreceiptdocno+" and TR_NO="+trno+" and dtype='"+formdetailcode+"'");
				 int data6 = stmtIBR.executeUpdate(sql8);
				 if(data6<=0){
		            	stmtIBR.close();
		    			conn.close();
		    			return false;
		            }
				/*Status change in my_jvtran Ends*/
				 
				 /*Inserting into datalog*/
				 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtibbankreceiptdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','D')");
				 int datas = stmtIBR.executeUpdate(sqls);
				 /*Inserting into datalog Ends*/
				
				int docno=txtibbankreceiptdocno;
				ibBankReceiptBean.setTxtibbankreceiptdocno(docno);
				if (docno > 0) {
					conn.commit();
					stmtIBR.close();
				    conn.close();
					return true;
				}
			stmtIBR.close();
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
				Statement stmtIBR = conn.createStatement();

				String company = session.getAttribute("COMPANYID").toString();
				
				String sql="select branchname,doc_no from my_brch where cmpid="+company;
				
				ResultSet resultSet = stmtIBR.executeQuery(sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtIBR.close();
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
				Statement stmtIBR = conn.createStatement();
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
            	
				ResultSet resultSet = stmtIBR.executeQuery(sql);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtIBR.close();
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
				Statement stmtIBR = conn.createStatement();
		        String joins="",casestatement="";
				
				if(!(trno.trim().equalsIgnoreCase("0")||trno.trim().equalsIgnoreCase("") && accountno.trim().equalsIgnoreCase("0")||accountno.trim().equalsIgnoreCase(""))){
            	
				joins=commonDAO.getFinanceVocTablesJoins(conn);
        		casestatement=commonDAO.getFinanceVocTablesCase(conn);
				
				String sql="Select "+casestatement+"a.transType, a.description, a.date, a.tramt, a.applying, a.balance, a.out_amount, a.tranid, a.acno, a.currency from ("
						+ "select t.doc_no transno,t.dtype transType,t.description description,t.date date,((t.dramount*t.id)-(t.out_amount*t.id)+d.amount) tramt,"
						+ "d.amount applying,((t.dramount*t.id)-(t.out_amount*t.id)) balance,t.out_amount,t.tranid,t.acno,t.curId currency,t.brhid from my_outd d left join my_jvtran t on "
						+ "d.ap_trid=t.tranid where d.tranid=(SELECT tranid FROM my_jvtran where TR_NO='"+trno+"' and acno='"+accountno+"')) a"+joins+"";
				
				ResultSet resultSet = stmtIBR.executeQuery(sql);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtIBR.close();
				conn.close();
				}
			stmtIBR.close();
			conn.close();	
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	
	public JSONArray ibBankReceiptGridReloading(HttpSession session,String docNo,String check) throws SQLException {
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
				Statement stmtIBR = conn.createStatement();
			
				String sql=("SELECT t.doc_no docno,d.brhid,b.branchname branch,t.atype type,t.account accounts,t.description accountname1,t.gr_type grtype,c.code currency,c.type currencytype,d.curId currencyid,d.rate rate,"
						+ "if(d.dr<0,true,false)  dr,(d.AMOUNT*d.dr) amount1,(d.lamount*d.dr) baseamount1,d.description,d.SR_NO sr_no,d.costtype,d.costcode,f.costgroup FROM my_chqbm m left join my_chqbd d "
						+ "on m.tr_no=d.tr_no left join my_costunit f on d.costtype=f.costtype left join my_head t on d.acno=t.doc_no left join my_curr c on c.doc_no=d.curId left join my_brch b on d.brhid=b.doc_no WHERE "
						+ "m.dtype='IBR' and m.cmpid="+company+" and m.doc_no="+docNo+" and d.SR_NO>1");
				
				ResultSet resultSet = stmtIBR.executeQuery(sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtIBR.close();
				conn.close();

		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
		return RESULTDATA;
    }
	
	public JSONArray ibBankReceiptGridSearch(String type,String accountno,String accountname,String currency,String date,String check) throws SQLException {
	        
			JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn = null; 
	       
		     try {
			       conn = connDAO.getMyConnection();
			       Statement stmtIBR = conn.createStatement();
		
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
			        
			        if(check.equalsIgnoreCase("1")){
			        	
		        	sql="select t.doc_no,t.account,t.description,t.gr_type,c.code curr,c.doc_no curid,c.type,cb.rate c_rate from my_head t left join my_curr c "
							+ "on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,"
							+ "cr.frmDate from my_curbook cr where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo "
							+ "on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where t.atype='"+type+"' and t.m_s=0"+sqltest;
			        
			       ResultSet resultSet = stmtIBR.executeQuery(sql);
			       RESULTDATA=commonDAO.convertToJSON(resultSet);
		           
			       stmtIBR.close();
			       conn.close();
			       }
			       stmtIBR.close();
				   conn.close();
		     }catch(Exception e){
			      e.printStackTrace();
			      conn.close();
		     }finally{
				 conn.close();
			 }
		     return RESULTDATA;
		  }
	
	 public JSONArray ibrMainSearch(HttpSession session,String partyname,String docNo,String date,String amount,String chequeNo,String chequeDt,String check) throws SQLException {

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
	       
	        java.sql.Date sqlBankDate=null;
	        java.sql.Date sqlChequeDate=null;
	        
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
	         sqltest=sqltest+" and if(h.description is null,h1.description,h.description) like '%"+partyname+"%'";
	        }
	        if(!(amount.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and m.totalAmount like '%"+amount+"%'";
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
	           
	     try {
		       conn = connDAO.getMyConnection();
		       Statement stmtIBR = conn.createStatement();
		       
		       ResultSet resultSet = stmtIBR.executeQuery("select m.date,m.doc_no,m.totalAmount amount,if(h.description is null,h1.description,h.description) description,m.chqno,m.chqdt from  my_chqbm m "
			       		+ "left join my_chqbd d on m.tr_no=d.tr_no and d.sr_no=1 left join my_chqbd d1 on m.tr_no=d1.tr_no and d1.sr_no=2 left join my_chqdet c on c.tr_no=d.tr_no left join my_head h on d.acno=h.doc_no left join my_head h1 on d1.acno=h1.doc_no "
			       		+ "left join my_brch b on m.brhid=b.doc_no where m.brhid="+branch+" and m.dtype='IBR' and m.status <> 7" +sqltest);
	
		       RESULTDATA=commonDAO.convertToJSON(resultSet);
		       stmtIBR.close();
		       conn.close();
	     }catch(Exception e){
	    	 e.printStackTrace();
	    	 conn.close();
	     }finally{
			 conn.close();
		 }
	        return RESULTDATA;
	   }
	
	 public ClsIbBankReceiptBean getViewDetails(String branch,int docNo) throws SQLException {
		
		ClsIbBankReceiptBean ibBankReceiptBean = new ClsIbBankReceiptBean();
		
		Connection conn = null;
		
		try {
			conn = connDAO.getMyConnection();
			Statement stmtIBR = conn.createStatement();
			
			ResultSet resultSet = stmtIBR.executeQuery ("SELECT m.date,m.RefNo,m.totalAmount,t.atype,t.account,t.description,t.doc_no accno,d.brhid,d.curId,d.rate,d.dr,(d.AMOUNT*d.dr) AMOUNT,"
					+ "(d.lamount*d.dr) lamount,m.DESC1,sum(o.AMOUNT) appliedamount,d.SR_NO,d.TR_NO,j.tranid,c.chqno,c.chqdt,c.pdc,coalesce(c.pdcposttrno,0) pdcposttrno,cr.type,(select acno from my_account where codeno='PDCRV') pdcacno FROM "
					+ "my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no left join my_jvtran j on d.tr_no=j.tr_no  left join my_outd o on o.tranid=j.tranid left join my_chqdet c on c.tr_no=j.tr_no "
					+ "left join my_head t on d.acno=t.doc_no left join my_curr cr on d.curId=cr.doc_no WHERE m.status<>7 and m.dtype='IBR' and m.brhid="+branch+" and m.doc_no="+docNo+" group by account");
	
			while (resultSet.next()) {
					ibBankReceiptBean.setTxtibbankreceiptdocno(docNo);
					ibBankReceiptBean.setJqxIbBankReceiptDate(resultSet.getDate("date").toString());
					ibBankReceiptBean.setTxtrefno(resultSet.getString("RefNo"));
					ibBankReceiptBean.setTxttotranid(resultSet.getInt("tranid"));
					ibBankReceiptBean.setTxttotrno(resultSet.getInt("TR_NO"));
				
				if(resultSet.getString("SR_NO").trim().equalsIgnoreCase("0")){
					ibBankReceiptBean.setTxtfromdocno(resultSet.getInt("accno"));
					ibBankReceiptBean.setTxtfromaccid(resultSet.getString("account"));
					ibBankReceiptBean.setTxtfromaccname(resultSet.getString("description"));
					ibBankReceiptBean.setHidcmbfromcurrency(resultSet.getString("curId"));
					ibBankReceiptBean.setHidfromcurrencytype(resultSet.getString("type"));
					ibBankReceiptBean.setTxtfromrate(resultSet.getDouble("rate"));
					ibBankReceiptBean.setChckpdc(resultSet.getInt("pdc"));
					ibBankReceiptBean.setTxtpdcacno(resultSet.getInt("pdcacno"));
					ibBankReceiptBean.setTxtchequeno(resultSet.getString("chqno"));
					ibBankReceiptBean.setJqxChequeDate(resultSet.getDate("chqdt").toString());
					ibBankReceiptBean.setTxtfromamount(resultSet.getDouble("AMOUNT"));
					ibBankReceiptBean.setTxtfrombaseamount(resultSet.getDouble("lamount"));
					ibBankReceiptBean.setTxtdescription(resultSet.getString("DESC1"));
					ibBankReceiptBean.setPdcposttrno(resultSet.getInt("pdcposttrno"));
				}
				
				else if(resultSet.getString("SR_NO").trim().equalsIgnoreCase("1")){
					ibBankReceiptBean.setTxttodocno(resultSet.getInt("accno"));
					ibBankReceiptBean.setHidcmbtobranch(resultSet.getString("brhid"));
					ibBankReceiptBean.setHidcmbtotype(resultSet.getString("atype"));
					ibBankReceiptBean.setTxttoaccid(resultSet.getString("account"));
					ibBankReceiptBean.setTxttoaccname(resultSet.getString("description"));
					ibBankReceiptBean.setHidcmbtocurrency(resultSet.getString("curId"));
					ibBankReceiptBean.setHidtocurrencytype(resultSet.getString("type"));
					ibBankReceiptBean.setTxttorate(resultSet.getDouble("rate"));
					ibBankReceiptBean.setTxttoamount(resultSet.getDouble("AMOUNT"));
					ibBankReceiptBean.setTxttobaseamount(resultSet.getDouble("lamount"));
					
					ibBankReceiptBean.setTxtapplyinvoiceamt(resultSet.getDouble("AMOUNT"));
					ibBankReceiptBean.setTxtapplyinvoiceapply(resultSet.getDouble("appliedamount"));
					ibBankReceiptBean.setTxtapplyinvoicebalance(resultSet.getDouble("AMOUNT")-resultSet.getDouble("appliedamount"));
				   }
					ibBankReceiptBean.setTxtdrtotal(resultSet.getDouble("totalAmount"));
					ibBankReceiptBean.setTxtcrtotal(resultSet.getDouble("totalAmount"));
					ibBankReceiptBean.setMaindate(resultSet.getDate("date").toString());
			    }
		stmtIBR.close();
		conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
		  return ibBankReceiptBean;
		}
	 
	public ClsIbBankReceiptBean getPrint(HttpServletRequest request,int docNo,int branch,int header) throws SQLException {
		 ClsIbBankReceiptBean bean = new ClsIbBankReceiptBean();
			
		 Connection conn = null;
		 
		try {
			conn = connDAO.getMyConnection();
			Statement stmtIBR = conn.createStatement();
			
			int trno=0;
			int acno=0;
			int srno=0;
			
			String headersql="select if(m.dtype='IBR','IB-Bank Receipt','  ') vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
					+ "b.cstno from my_chqbm m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='IBR' "
					+ "and m.brhid="+branch+" and m.doc_no="+docNo+"";
				
				ResultSet resultSetHead = stmtIBR.executeQuery(headersql);
				
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
			
				String sqls="select m.doc_no,DATE_FORMAT(m.date ,'%d-%m-%Y') date,m.desc1,concat(m.chqno,' ',if(chq.pdc=1,'(PDC)','')) chqno,DATE_FORMAT(m.chqdt ,'%d-%m-%Y') chqdt,"
						+ "round(m.totalAmount,2) netAmount,u.user_name from my_chqbm m left join my_chqdet chq on  chq.tr_no=m.tr_no left join my_user u on m.userid=u.doc_no where "
						+ "m.dtype='IBR' and m.brhid="+branch+" and m.doc_no="+docNo+"";
					
				ResultSet resultSets = stmtIBR.executeQuery(sqls);
				
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
			
			String sql="select round(m.totalAmount,2) netAmount,CASE WHEN m.chqname is null THEN h.description WHEN m.chqname='' THEN h.description "  
					   + "Else m.chqname END as 'description',d.acno,m.tr_no from my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no left join my_head h on "
					   + "d.acno=h.doc_no  where m.dtype='IBR' and d.sr_no=1 and m.brhid="+branch+" and m.doc_no="+docNo+"";
		
			ResultSet resultSet = stmtIBR.executeQuery(sql);
			
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
					String sqld="select round(m.totalAmount,2) netAmount,CASE WHEN m.chqname is null THEN h.description WHEN m.chqname='' THEN h.description "  
							   + "Else m.chqname END as 'description',d.acno,m.tr_no from my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no left join my_head h on "
							   + "d.acno=h.doc_no  where m.dtype='IBR' and d.sr_no=2 and m.brhid="+branch+" and m.doc_no="+docNo+"";
						
							ResultSet resultSet1 = stmtIBR.executeQuery(sqld);
							
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
	
			sql2="Select "+casestatement+"a.transtype, a.description, a.date, a.tramt, a.applying, a.balance from (select t.doc_no transno,t.dtype transType,t.description description,"
					+ "DATE_FORMAT(t.date,'%d-%m-%Y') date,round(((t.dramount*t.id)-(t.out_amount*t.id)+d.amount),2) tramt,round(d.amount,2) applying,round(((t.dramount*t.id)-(t.out_amount*t.id)),2) balance,"
					+ "t.out_amount,t.tranid,t.acno,t.curId currency,t.brhid from my_outd d left join my_jvtran t on d.ap_trid=t.tranid where d.tranid=(SELECT tranid FROM my_jvtran where TR_NO='"+trno+"' and acno='"+acno+"')) a"+joins+"";
			
			ResultSet resultSet2 = stmtIBR.executeQuery(sql2);
			
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
					+ "b.branchname FROM my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no left join my_head t on d.acno=t.doc_no left join my_brch b on d.brhid=b.doc_no left join my_curr c "
					+ "on c.doc_no=d.curId WHERE m.dtype='IBR' and m.brhid="+branch+" and m.doc_no="+docNo+" order by d.amount desc";
			
			ResultSet resultSet1 = stmtIBR.executeQuery(sql1);
			
			ArrayList<String> printarray= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setSecarray(2); 
				String temp="";
				temp=resultSet1.getString("branchname")+"::"+resultSet1.getString("account")+"::"+resultSet1.getString("accountname")+"::"+resultSet1.getString("description")+"::"+resultSet1.getString("currency")+"::"+resultSet1.getString("debit")+"::"+resultSet1.getString("credit");
			    printarray.add(temp);
			}
			request.setAttribute("printingarray", printarray);
			
			String sql3 = "select min(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,min(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from my_chqbm m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='IBR' and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSet3 = stmtIBR.executeQuery(sql3);
			
			while(resultSet3.next()){
				bean.setLblpreparedon(resultSet3.getString("preparedon"));
				bean.setLblpreparedat(resultSet3.getString("preparedat"));
			}
			
			stmtIBR.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
		return bean;
	}
	 
	public ClsIbBankReceiptBean getChequePrint(int docno,int branch) throws SQLException {
		 ClsIbBankReceiptBean bean = new ClsIbBankReceiptBean();
		 Connection conn = null;
			
		try {
			conn = connDAO.getMyConnection();
			Statement stmtIBR = conn.createStatement();
			String amountwordslength="";
			int accountno=0;
			
			String sqls="select d.acno from my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no where d.sr_no=0 and m.dtype='IBR' and m.brhid="+branch+" and "
					+ "m.doc_no="+docno+"";
			
			ResultSet resultSets = stmtIBR.executeQuery(sqls);
			
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
			
			ResultSet resultSet = stmtIBR.executeQuery(sql);
			
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
			}
		
			String sql1="select c.chqno,DATE_FORMAT(c.chqdt,'%d-%m-%Y') chqdt,CASE WHEN m.chqname is null THEN t.description WHEN m.chqname='' THEN "  
					+ "t.description Else m.chqname END as 'description',(select format(round(if(d.amount<0,d.amount*-1,d.amount),2),2) amount from my_chqbm m "  
					+ "left join my_chqbd d on m.tr_no=d.tr_no where d.sr_no=0 and m.dtype='IBR' and m.brhid="+branch+" and m.doc_no="+docno+") amount,"
					+ "(select round(if(d.amount<0,d.amount*-1,d.amount),2) amountinwords from my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no "
					+ "where d.sr_no=0 and m.dtype='IBR' and m.brhid="+branch+" and m.doc_no="+docno+") amountinwords from my_chqbm m left join my_chqbd d "
					+ "on m.tr_no=d.tr_no left join my_chqdet c on d.tr_no=c.tr_no left join my_head t on c.opsacno=t.doc_no where "
					+ "m.dtype='IBR' and m.status=3 and m.brhid="+branch+" and m.doc_no="+docno+" group by m.tr_no";
				
				ResultSet resultSet1 = stmtIBR.executeQuery(sql1);
				
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
				
			stmtIBR.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
		return bean;
	}

	 public int insertion(Connection conn,int docno,int trno,String formdetailcode,Date ibBankReceiptDate, String txtrefno, double txtfromrate,Date chequeDate, String txtchequeno, 
			 int chckpdc, String txtdescription, double txtdrtotal, double txtapplyinvoiceapply, ArrayList<String> ibbankreceiptarray,ArrayList<String> applyibinvoicearray,
			 HttpSession session,String mode) throws SQLException{

		 try{
				conn.setAutoCommit(false);
				CallableStatement stmtIBR;
				Statement stmtIBR1 = conn.createStatement();
				
				String userid=session.getAttribute("USERID").toString().trim();
				
				/*Bank Receipt Grid and Details Saving*/
				for(int i=0;i< ibbankreceiptarray.size();i++){
					String[] bankreceipt=ibbankreceiptarray.get(i).split("::");
					if(!bankreceipt[0].trim().equalsIgnoreCase("undefined") && !bankreceipt[0].trim().equalsIgnoreCase("NaN")){
					
					int cash = 0;
					int id = 0;
					if(bankreceipt[3].trim().equalsIgnoreCase("true")){
						cash=0;
						id=-1;
					}
					else if(bankreceipt[3].trim().equalsIgnoreCase("false")){
						cash=1;
						id=1;
					}
					
					stmtIBR = conn.prepareCall("{CALL ibChqbdDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					/*Insertion to my_chqbd*/
					stmtIBR.setInt(22,trno); 
					stmtIBR.setInt(23,docno);
					stmtIBR.registerOutParameter(24, java.sql.Types.INTEGER);
					stmtIBR.setInt(1,i); //SR_NO
					stmtIBR.setString(2,(bankreceipt[0].trim().equalsIgnoreCase("undefined") || bankreceipt[0].trim().equalsIgnoreCase("NaN") || bankreceipt[0].trim().isEmpty()?0:bankreceipt[0].trim()).toString());  //doc_no of my_head
					stmtIBR.setString(3,(bankreceipt[1].trim().equalsIgnoreCase("undefined") || bankreceipt[1].trim().equalsIgnoreCase("NaN") || bankreceipt[1].trim().isEmpty()?0:bankreceipt[1].trim()).toString()); //curId
					stmtIBR.setString(4,(bankreceipt[2].trim().equalsIgnoreCase("undefined") || bankreceipt[2].trim().equalsIgnoreCase("NaN") || bankreceipt[2].trim().equals(0) || bankreceipt[2].trim().isEmpty()?1:bankreceipt[2].trim()).toString()); //rate 
					stmtIBR.setInt(5,id); //#credit -1 / debit 1 
					stmtIBR.setString(6,(bankreceipt[4].trim().equalsIgnoreCase("undefined") || bankreceipt[4].trim().equalsIgnoreCase("NaN") || bankreceipt[4].trim().isEmpty()?0:bankreceipt[4].trim()).toString()); //amount
					stmtIBR.setString(7,(bankreceipt[5].trim().equalsIgnoreCase("undefined") || bankreceipt[5].trim().equalsIgnoreCase("NaN") || bankreceipt[5].trim().isEmpty()?0:bankreceipt[5].trim()).toString()); //description
					stmtIBR.setString(8,(bankreceipt[6].trim().equalsIgnoreCase("undefined") || bankreceipt[6].trim().equalsIgnoreCase("NaN") || bankreceipt[6].trim().isEmpty()?0:bankreceipt[6].trim()).toString()); //baseamount
					stmtIBR.setInt(9,cash); //For cash = 0/ party = 1
					stmtIBR.setString(10,(bankreceipt[8].trim().equalsIgnoreCase("undefined") || bankreceipt[8].trim().equalsIgnoreCase("NaN") || bankreceipt[8].trim().equalsIgnoreCase("") || bankreceipt[8].trim().equalsIgnoreCase("0") || bankreceipt[8].trim().isEmpty()?0:bankreceipt[8].trim()).toString()); //Cost Type
					stmtIBR.setString(11,(bankreceipt[9].trim().equalsIgnoreCase("undefined") || bankreceipt[9].trim().equalsIgnoreCase("NaN") || bankreceipt[9].trim().equalsIgnoreCase("") || bankreceipt[9].trim().equalsIgnoreCase("0") || bankreceipt[9].trim().isEmpty()?0:bankreceipt[9].trim()).toString()); //Cost Code
					/*my_chqbd Ends*/
					
					/*Insertion to my_jvtran*/
					stmtIBR.setDate(12,ibBankReceiptDate);
					stmtIBR.setString(13,(bankreceipt[12].trim().equalsIgnoreCase("undefined") || bankreceipt[12].trim().equalsIgnoreCase("NaN") || bankreceipt[12].trim().isEmpty()?0:bankreceipt[12].trim()).toString()); //pdc
					stmtIBR.setString(14,(bankreceipt[13].trim().equalsIgnoreCase("undefined") || bankreceipt[13].trim().equalsIgnoreCase("NaN") || bankreceipt[13].trim().isEmpty()?0:bankreceipt[13].trim()).toString()); //pdc account no
					stmtIBR.setString(15,txtrefno);
					stmtIBR.setInt(16,id);  //id
					stmtIBR.setString(17,(bankreceipt[7].trim().equalsIgnoreCase("undefined") || bankreceipt[7].trim().equalsIgnoreCase("NaN") || bankreceipt[7].trim().isEmpty()?0:bankreceipt[7].trim()).toString());  //out-amount
					/*my_jvtran Ends*/
					
					stmtIBR.setString(18,formdetailcode);
					stmtIBR.setString(19,(bankreceipt[10].trim().equalsIgnoreCase("undefined") || bankreceipt[10].trim().equalsIgnoreCase("NaN") || bankreceipt[10].trim().isEmpty()?0:bankreceipt[10].trim()).toString());  //branch
					stmtIBR.setString(20,(bankreceipt[11].trim().equalsIgnoreCase("undefined") || bankreceipt[11].trim().equalsIgnoreCase("NaN") || bankreceipt[11].trim().isEmpty()?0:bankreceipt[11].trim()).toString()); //Main Branch
					stmtIBR.setString(21,userid);
					stmtIBR.setString(25,mode);
					stmtIBR.execute();
						if(stmtIBR.getInt("irowsNo")<=0){
							stmtIBR.close();
							conn.close();
							return 0;
						}
      				  }
				    }
				    /*Bank Receipt Grid and Details Saving Ends*/
				
					/*Apply-Invoicing Grid Saving*/
					for(int i=0;i< applyibinvoicearray.size();i++){
					String[] apply=applyibinvoicearray.get(i).split("::");
					if(!apply[0].trim().equalsIgnoreCase("undefined") && !apply[0].trim().equalsIgnoreCase("NaN")){
					
					stmtIBR = conn.prepareCall("{CALL applyBankInvoicingDML(?,?,?,?,?,?,?)}");
					/*Insertion to my_outd*/
					stmtIBR.setString(1,(apply[1].trim().equalsIgnoreCase("undefined") || apply[1].trim().equalsIgnoreCase("NaN") || apply[1].trim().isEmpty()?0:apply[1].trim()).toString()); //Out amount
					stmtIBR.setString(2,(apply[0].trim().equalsIgnoreCase("undefined") || apply[0].trim().equalsIgnoreCase("NaN") || apply[0].trim().isEmpty()?0:apply[0].trim()).toString()); //Applied amount
					stmtIBR.setString(3,(apply[2].trim().equalsIgnoreCase("undefined") || apply[2].trim().equalsIgnoreCase("NaN") || apply[2].trim().isEmpty()?0:apply[2].trim()).toString()); //Currency
					stmtIBR.setInt(4,trno);  //tr_no
					stmtIBR.setString(5,(apply[3].trim().equalsIgnoreCase("undefined") || apply[3].trim().equalsIgnoreCase("NaN") || apply[3].trim().isEmpty()?0:apply[3].trim()).toString()); //tranid
					stmtIBR.setString(6,(apply[4].trim().equalsIgnoreCase("undefined") || apply[4].trim().equalsIgnoreCase("NaN") || apply[4].trim().isEmpty()?0:apply[4].trim()).toString()); //account
					stmtIBR.setString(7,mode);	
					int applypaymentcheck=stmtIBR.executeUpdate();
						if(applypaymentcheck<=0){
							stmtIBR.close();
							conn.close();
							return 0;
						}
						/*Apply-Invoicing Grid Saving Ends*/
						stmtIBR.close();
					 }
				}
					
				int trid=0,id = 0;
				/*Selecting Tran-Id & Id*/
				String sqls=("select j.TRANID,j.ID from my_jvtran j inner join my_chqbd d on (d.acno =j.acno and d.tr_no =j.tr_no and d.sr_no=1) where j.tr_no="+trno);
				ResultSet resultSets = stmtIBR1.executeQuery(sqls);
				    
				 while (resultSets.next()) {
					 trid=resultSets.getInt("TRANID");
				     id=resultSets.getInt("ID");
				 }
				 /*Selecting Tran-Id & Id Ends*/
				
				/*Updating my_jvtran*/
				String sql3=("update my_jvtran set out_amount="+(txtapplyinvoiceapply)*id+" where tranid="+trid+"");
				int data3 = stmtIBR1.executeUpdate(sql3);
				if(data3<=0){
					stmtIBR1.close();
					conn.close();
					return 0;
				}
				/*Updating my_jvtran Ends*/
				
				/*Deleting account of value zero*/
				String sql2=("DELETE FROM my_jvtran where TR_NO="+trno+" and acno=0");
			    int data = stmtIBR1.executeUpdate(sql2);
			     
			    String sql4=("DELETE FROM my_chqbd where TR_NO="+trno+" and acno=0");
			    int data1 = stmtIBR1.executeUpdate(sql4);
			    /*Deleting account of value zero ends*/
			    
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}
}
