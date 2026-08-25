package com.finance.transactions.taxdbtnote;

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
import com.finance.transactions.debitnote.ClsDebitNoteBean;

public class ClsTaxDebitNoteDAO {
	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsTaxDebitNoteBean debitNoteBean = new ClsTaxDebitNoteBean();
	
	  public int insert(Date debitNoteDate, String formdetailcode, String txtrefno,double txtrate,String txtdescription, int txtdocno, String cmbcurrency, double txtamount, 
			 double txtdrtotal, String rtype, int rdocno, ArrayList<String> debitnotearray,HttpSession session,HttpServletRequest request,String mode) throws SQLException {
		 
		Connection conn = null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			int total = 0;

			CallableStatement stmtDNO = conn.prepareCall("{CALL taxcnotmDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtDNO.registerOutParameter(15, java.sql.Types.INTEGER);
			stmtDNO.registerOutParameter(16, java.sql.Types.INTEGER);
			
			stmtDNO.setDate(1,debitNoteDate);
			stmtDNO.setString(2,txtrefno);
			stmtDNO.setString(3,txtdescription);
			stmtDNO.setInt(4,txtdocno);  //accDocNo
			stmtDNO.setString(5,cmbcurrency);   //curId
			stmtDNO.setDouble(6,txtrate);  //rate
			stmtDNO.setDouble(7,txtamount); //amount
			stmtDNO.setDouble(8,txtdrtotal); //netAmount
			stmtDNO.setString(9,rtype); //rtype
			stmtDNO.setInt(10,rdocno); //rdocno
			
			stmtDNO.setString(11,formdetailcode);
			stmtDNO.setString(12,company);
			stmtDNO.setString(13,branch);
			stmtDNO.setString(14,userid);
			stmtDNO.setString(17,mode);
			int datas=stmtDNO.executeUpdate();
			if(datas<=0){
				stmtDNO.close();
				conn.close();
				return 0;
			}
			int docno=stmtDNO.getInt("docNo");
			int trno=stmtDNO.getInt("itranNo");
			request.setAttribute("tranno", trno);
			
			double nettotal=txtdrtotal;
			debitNoteBean.setTxtdebitnotedocno(docno);
			if (docno > 0) {
				/*Insertion to my_cnotd,my_jvtran*/
				int insertData=insertion(conn, docno, trno,formdetailcode,nettotal,debitNoteDate, txtrefno, txtrate, txtdescription, txtdrtotal, rtype, rdocno, debitnotearray, session, mode);
				if(insertData<=0){
					stmtDNO.close();
					conn.close();
					return 0;
				}
				/*Insertion to my_cnotd,my_jvtran Ends*/
				/*Insertion to my_cnotd,my_jvtran,my_outd Ends*/
				String sql2="select ldramount as jvtotal from my_jvtran where tr_no="+trno+"";
				ResultSet resultSet2 = stmtDNO.executeQuery(sql2);
			    
				 while (resultSet2.next()) {
				 System.out.println("asd"+resultSet2.getDouble("jvtotal"));
				 }	
				String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
				ResultSet resultSet = stmtDNO.executeQuery(sql1);
			    
				 while (resultSet.next()) {
				 total=resultSet.getInt("jvtotal");
				 }
				 
				 if(total == 0){
					conn.commit();
					stmtDNO.close();
					conn.close();
					return docno;
				 }else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*="+total);
					    stmtDNO.close();
					    return 0;
				    }
			}
	 }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 0;
	}
			
	
	public boolean edit(int txtdebitnotedocno, String formdetailcode, Date debitNoteDate,String txtrefno, String txtdescription, String cmbCurrency,double txtamount, double txtbaseamount,
			double txtrate, double txtdrtotal, int txtdocno,int txttrno,double nettotal, String rtype, int rdocno, ArrayList<String> debitnotearray, HttpSession session, String mode) throws SQLException {
		
		Connection conn = null;
		
		try{
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtDNO = conn.createStatement();
		
				if(mode.equalsIgnoreCase("EDIT")){
					mode="E";
				}
				
				int trno = txttrno,icldocno = 0,ilapply = 0,total = 0,creditlimit = 0,applydelete=0;
				java.sql.Date sqlDueDate=null;
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String company=session.getAttribute("COMPANYID").toString().trim();
				
				/*Updating my_cnot*/
	            String sql=("update my_cnot set date='"+debitNoteDate+"',lstmodify=now(),refNo='"+txtrefno+"',description='"+txtdescription+"',acno="+txtdocno+",curId="+cmbCurrency+",rate="+txtrate+",amount="+txtamount+",netAmount="+txtdrtotal+",dtype='"+formdetailcode+"',brhid="+branch+",cmpid="+company+" where tr_no="+trno+" and doc_no="+txtdebitnotedocno+"");
				int data = stmtDNO.executeUpdate(sql);
				if(data<=0){
					stmtDNO.close();
					conn.close();
					return false;
				}
				/*Updating my_cnot Ends*/
				
				/*Selecting credit(Max)*/
				String sql1=("select a.period2 from my_cnot m left join my_head t on m.acno=t.doc_no left join my_acbook a on t.cldocno=a.cldocno and a.dtype='CRM' where m.tr_no="+trno+"");
				ResultSet resultSet = stmtDNO.executeQuery(sql1);
				    
				 while (resultSet.next()) {
					creditlimit=resultSet.getInt("period2");
				 }
				 /*Selecting credit(Max) Ends*/
				 
				 /*Selecting duedate*/
				String sql2=("select DATE_ADD('"+debitNoteDate+"', INTERVAL "+creditlimit+" DAY) AS duedate");
				ResultSet resultSet1 = stmtDNO.executeQuery(sql2);
				    
				 while (resultSet1.next()) {
					 sqlDueDate=resultSet1.getDate("duedate");
				 }
				/*Selecting duedate Ends*/
				
				/*Inserting into datalog*/
				String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtdebitnotedocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
				int datas = stmtDNO.executeUpdate(sqls);
				/*Inserting into datalog Ends*/
				
				ClsApplyDelete applyDelete = new ClsApplyDelete();
				applydelete=applyDelete.getFinanceApplyDelete(conn, trno);
				if(applydelete<0){
					System.out.println("*** ERROR IN APPLY DELETE ***");
					stmtDNO.close();
					conn.close();
					return false;
				}
			    
			    String sql7=("DELETE FROM my_cnotd WHERE TR_NO="+trno);
			    int data4 = stmtDNO.executeUpdate(sql7);
				 
				 String sql8=("DELETE FROM my_jvtran WHERE TR_NO="+trno);
				 int data5 = stmtDNO.executeUpdate(sql8);
				 
				 String sql9=("DELETE FROM my_costtran WHERE TR_NO="+trno);
				 int data6 = stmtDNO.executeUpdate(sql9);
			    
				 String sql10=("select cldocno,lapply from my_head where doc_no="+txtdebitnotedocno);
				 ResultSet resultSet3 = stmtDNO.executeQuery(sql10);
				 
				 while(resultSet3.next()){
					 icldocno=resultSet3.getInt("cldocno");
					 ilapply=resultSet3.getInt("lapply");
				 }
					 
				 String sql11=("insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS) values('"+debitNoteDate+"','"+txtrefno+"',"+txtdebitnotedocno+","+txtdocno+",'"+txtdescription+"',"+cmbCurrency+","+txtrate+","+txtamount+","+txtbaseamount+",0,1,7,0,"+ilapply+","+icldocno+","+txtrate+",'"+formdetailcode+"',"+branch+","+trno+",3)");
				 int data7 = stmtDNO.executeUpdate(sql11);
				 if(data7<=0){
						stmtDNO.close();
						conn.close();
						return false;
					}
				 
			    int docno=txtdebitnotedocno;
				debitNoteBean.setTxtdebitnotedocno(docno);
				if (docno > 0) {
				
					/*Insertion to my_cnotd,my_jvtran*/
					int insertData=insertion(conn, docno, trno, formdetailcode, nettotal, debitNoteDate, txtrefno, txtrate, txtdescription, txtdrtotal, rtype, rdocno, debitnotearray, session, mode);
					if(insertData<=0){
						stmtDNO.close();
						conn.close();
						return false;
					}
					/*Insertion to my_cnotd,my_jvtran Ends*/
					
					/*Updating duedate*/
		            String sqldue=("update my_jvtran set duedate='"+sqlDueDate+"',out_amount=0 where acno="+txtdocno+" and tr_no="+trno+"");
		            int datadue = stmtDNO.executeUpdate(sqldue);
					if(datadue<=0){
						stmtDNO.close();
						conn.close();
						return false;
					}
					/*Updating duedate Ends*/
					
					String sql12="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
					ResultSet resultSet5 = stmtDNO.executeQuery(sql12);
				    
					 while (resultSet5.next()) {
					 total=resultSet5.getInt("jvtotal");
					 }
					 
					 if(total == 0){
						conn.commit();
						stmtDNO.close();
						conn.close();
						return true;
					 }else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
					    stmtDNO.close();
					    return false;
				    }
				}
			stmtDNO.close();
			conn.close();
		 }catch(Exception e){
			 	e.printStackTrace();
			 	conn.close();
			 	return false;
		 }
			return false;
	}
	  
	public boolean editMaster(int txtcreditnotedocno, String formdetailcode, Date debitNoteDate,String txtrefno, String txtdescription, double txtrate,
			double txtdrtotal, int txtdocno,int txttrno, HttpSession session) throws SQLException {
		
		Connection conn = null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtDNO = conn.createStatement();
		
			int trno = txttrno,creditlimit = 0;
			java.sql.Date sqlDueDate=null;
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			
			/*Updating my_cnot*/
            String sql=("update my_cnot set date='"+debitNoteDate+"',lstmodify=now(),refNo='"+txtrefno+"',description='"+txtdescription+"',dtype='"+formdetailcode+"',brhid="+branch+",cmpid="+company+" where tr_no="+trno+" and doc_no="+txtcreditnotedocno+"");
			int data = stmtDNO.executeUpdate(sql);
			if(data<=0){
				stmtDNO.close();
				conn.close();
				return false;
			}
			/*Updating my_cnot Ends*/
			
			/*Selecting credit(Max)*/
			String sql1=("select a.period2 from my_cnot m left join my_head t on m.acno=t.doc_no left join my_acbook a on t.cldocno=a.cldocno and a.dtype='CRM' where m.tr_no="+trno+"");
			ResultSet resultSet = stmtDNO.executeQuery(sql1);
			    
			 while (resultSet.next()) {
				creditlimit=resultSet.getInt("period2");
			 }
			 /*Selecting credit(Max) Ends*/
			 
			 /*Selecting duedate*/
			String sql2=("select DATE_ADD('"+debitNoteDate+"', INTERVAL "+creditlimit+" DAY) AS duedate");
			ResultSet resultSet1 = stmtDNO.executeQuery(sql2);
			    
			 while (resultSet1.next()) {
				 sqlDueDate=resultSet1.getDate("duedate");
			 }
			/*Selecting duedate Ends*/
				
			 /*Updating duedate*/
	            String sql3=("update my_jvtran set duedate='"+sqlDueDate+"' where acno="+txtdocno+" and tr_no="+trno+"");
	            int data1 = stmtDNO.executeUpdate(sql3);
				if(data1<=0){
					stmtDNO.close();
					conn.close();
					return false;
				}
				/*Updating duedate Ends*/
			
			/*Inserting into datalog*/
			String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtcreditnotedocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
			int datas = stmtDNO.executeUpdate(sqls);
			/*Inserting into datalog Ends*/
			
			conn.commit();
			stmtDNO.close();
		    conn.close();
			return true;			
      }catch(Exception e){
	 	  e.printStackTrace();
	 	  conn.close();
	 	  return false;
      }
	}


	public boolean delete(int txtcreditnotedocno,int txtdocno,String formdetailcode, int txttrno, HttpSession session) throws SQLException {
		
		Connection conn = null;
		
		try{
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtDNO = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				int trno = txttrno,applydelete=0;
				
				ClsApplyDelete applyDelete = new ClsApplyDelete();
				applydelete=applyDelete.getFinanceApplyDelete(conn, trno);
				if(applydelete<0){
					System.out.println("*** ERROR IN APPLY DELETE ***");
					stmtDNO.close();
					conn.close();
					return false;
				}
				  
				/*Status change in my_cnot*/
				 String sql=("update my_cnot set STATUS=7 where doc_no="+txtcreditnotedocno+" and TR_NO="+trno+"");
				 int data = stmtDNO.executeUpdate(sql);
				 if(data<=0){
						stmtDNO.close();
						conn.close();
						return false;
					}
				/*Status change in my_cnot Ends*/
				 
				 /*Inserting into datalog*/
				 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtcreditnotedocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','D')");
				 int datas = stmtDNO.executeUpdate(sqls);
				 /*Inserting into datalog Ends*/
				
				/*Status change in my_jvtran*/
				 String sql1=("update my_jvtran set STATUS=7,out_amount=0 where doc_no="+txtcreditnotedocno+" and TR_NO="+trno+"");
				 int data1 = stmtDNO.executeUpdate(sql1);
				 if(data1<=0){
						stmtDNO.close();
						conn.close();
						return false;
					}
				/*Status change in my_jvtran Ends*/
				
				int docno=txtcreditnotedocno;
				debitNoteBean.setTxtdebitnotedocno(docno);
				if (docno > 0) {
					conn.commit();
					stmtDNO.close();
				    conn.close();
					return true;
				}	
			stmtDNO.close();
			conn.close();
		 }catch(Exception e){
			 	e.printStackTrace();
			 	conn.close();
			 	return false;
		 }
				return false;
	    }
	
	public JSONArray accountsDetails(HttpSession session,String dtype) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		
        try {
				conn = connDAO.getMyConnection();
				Statement stmtDNO = conn.createStatement();
		
				String branch = session.getAttribute("BRANCHID").toString();
			    String company = session.getAttribute("COMPANYID").toString();
			    
				String code= "";
				if(dtype.equalsIgnoreCase("AP")){
					code="VND";
				}
				else if(dtype.equalsIgnoreCase("AR")){
					code="CRM";
				}
				
				ResultSet resultSet = stmtDNO.executeQuery ("select (@i:=@i+1) recno,t.doc_no,t.account,t.description,t.curid,c.code currency,c.c_rate rate from my_head t,my_acbook a1, "
						+ "my_curr c,(select curId from my_brch where doc_no= "+branch+") h, (select (@i:=0)) a where  a1.active=1 and t.m_s=0 and c.doc_no=t.curId "
						+ "and t.cldocno=a1.cldocno and a1.dtype='"+code+"' and t.atype='"+dtype+"' and c.doc_no=if(a1.brhId=0 and a1.curId=0,h.curId,if(a1.curId=0,h.curId,a1.curid)) and "
						+ "a1.cmpid in(0,"+company+") and a1.brhid in(0,"+branch+")");

				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtDNO.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	
	public JSONArray debitNoteGridReloading(HttpSession session,String docNo,String check) throws SQLException {
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
				Statement stmtDNO = conn.createStatement();  
			
				String sqlnew=("SELECT d.taxper tax,round((d.taxamount*d.dr),2) taxamount,round(d.nettot,2) nettotal,t.doc_no docno,t.atype type,t.account accounts,t.description accountname1,t.gr_type grtype,c.code currency,c.type currencytype,"
						+ "d.curId currencyid,d.rate rate,if(d.dr<0,true,false)  dr,(d.amount*d.dr) amount1,(d.amount*d.rate*d.dr) baseamount1,d.description,d.SR_NO sr_no,"
						+ "d.costtype,d.costcode,f.costgroup FROM my_cnot m left join my_cnotd d on m.tr_no=d.tr_no left join my_costunit f on d.costtype=f.costtype left join my_head t on d.acno=t.doc_no left join my_curr c on c.doc_no=d.curId "
						+ "WHERE m.dtype='TDN' and m.brhId="+branch+" and m.doc_no="+docNo+" and d.SR_NO>0");
				System.out.println("debit grid load======="+sqlnew);
				ResultSet resultSet = stmtDNO.executeQuery (sqlnew);
                
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtDNO.close();
				conn.close();

		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA;
    }
	
	public JSONArray debitNoteGridSearch(String type,String accountno,String accountname,String currency,String date,String check,String cdate) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
		if(!(check.equalsIgnoreCase("1"))) {
        	return RESULTDATA;
        }
		
        Connection conn = null; 
       
	     try {
		       conn = connDAO.getMyConnection();
		       Statement stmtDNO = conn.createStatement();
	
		        String sqltest="";
		        String sql="";
		        java.sql.Date sqlDate=null;
		        java.sql.Date sqlcDate=null;
		         
		           date.trim();
		           cdate.trim();
		           if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
		           {
		        	   sqlDate = commonDAO.changeStringtoSqlDate(date);
		           }
		           if(!(cdate.equalsIgnoreCase("undefined"))&&!(cdate.equalsIgnoreCase(""))&&!(cdate.equalsIgnoreCase("0")))
		           {
		        	   sqlcDate = commonDAO.changeStringtoSqlDate(cdate);
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
		        
	        	sql="select coalesce((select gt.per per from gl_taxmaster gt where gt.status=3 and gt.type=1 and '"+sqlcDate+"'>=gt.fromdate and '"+sqlcDate+"'<=gt.todate  and gt.per!=0 ),0)tax,coalesce((select gt.acno per from gl_taxmaster gt left join my_head h on h.doc_no=gt.acno where gt.status=3 and gt.type=1 and '"+sqlcDate+"'>=gt.fromdate and '"+sqlcDate+"'<=gt.todate  and gt.per!=0 ),0)taxaccnt,t.doc_no,t.account,t.description,t.gr_type,c.code curr,c.doc_no curid,c.type,round(cb.rate,2) c_rate from my_head t left join my_curr c "
						+ "on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,"
						+ "cr.frmDate from my_curbook cr where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo "
						+ "on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where t.atype='"+type+"' and t.m_s=0"+sqltest;
		        System.out.println("debitnotesearch========="+sql);
		       ResultSet resultSet = stmtDNO.executeQuery(sql);
		       RESULTDATA=commonDAO.convertToJSON(resultSet);
	           
		       stmtDNO.close();
			   conn.close();
	     }catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     }finally{
				conn.close();
			}
	       return RESULTDATA;
	  }
	
	public JSONArray dnoMainSearch(HttpSession session,String docNo,String date,String accId,String accName,String amount,String description,String check) throws SQLException {

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
       
           java.sql.Date sqlDebitNoteDate=null;
           
     try {
	       conn = connDAO.getMyConnection();
	       Statement stmtDNO = conn.createStatement();
	       
	        date.trim();
	        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	        {
	        	sqlDebitNoteDate = commonDAO.changeStringtoSqlDate(date);
	        }

	        String sqltest="";
	        
	        if(!(docNo.equalsIgnoreCase("") || docNo.equalsIgnoreCase("0"))){
	            sqltest=sqltest+" and m.doc_no like '%"+docNo+"%'";
	        }
	        if(!(sqlDebitNoteDate==null)){
		         sqltest=sqltest+" and m.date='"+sqlDebitNoteDate+"'";
		    }
	        if(!(accId.equalsIgnoreCase("") || accId.equalsIgnoreCase("0"))){
	            sqltest=sqltest+" and h.doc_no like '%"+accId+"%'";
	        }
	        if(!(accName.equalsIgnoreCase("") || accName.equalsIgnoreCase("0"))){
	         sqltest=sqltest+" and h.description like '%"+accName+"%'";
	        }
	        if(!(amount.equalsIgnoreCase("") || amount.equalsIgnoreCase("0"))){
	         sqltest=sqltest+" and m.amount like '%"+amount+"%'";
	        }
	        if(!(description.equalsIgnoreCase("") || description.equalsIgnoreCase("0"))){
	            sqltest=sqltest+" and m.description like '%"+description+"%'";
	        }
	        
	       if(!(docNo.equalsIgnoreCase("0") && date.equalsIgnoreCase("0") && accId.equalsIgnoreCase("0") && accName.equalsIgnoreCase("0") && amount.equalsIgnoreCase("0") && description.equalsIgnoreCase("0"))){
	    	   
	       String sql="Select m.date,m.doc_no,m.amount amounts,m.description,h.doc_no accountno,h.description accountname,d.costtype from my_cnot m inner join my_cnotd d on m.tr_no=d.tr_no inner join my_head h "
	         		+ "on m.acno=h.doc_no inner join my_brch b on m.brhid=b.doc_no where m.brhid="+branch+" and m.dtype='TDN' and m.status <> 7" +sqltest+" group by m.tr_no";
	       System.out.println("search==========="+sql);
	       ResultSet resultSet = stmtDNO.executeQuery(sql);
	       RESULTDATA=commonDAO.convertToJSON(resultSet);
	       
	       }
	       
	       stmtDNO.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	 public ClsTaxDebitNoteBean getViewDetails(HttpSession session,int docNo) throws SQLException {
		
		 ClsTaxDebitNoteBean debitNoteBean = new ClsTaxDebitNoteBean();
		
		Connection conn = null;
		
		try {
			conn = connDAO.getMyConnection();
			Statement stmtDNO = conn.createStatement();

			String branch = session.getAttribute("BRANCHID").toString();
			
			ResultSet resultSet = stmtDNO.executeQuery ("SELECT m.date,m.refNo,round(m.amount,2) amount,m.description,m.curId,round(m.rate,2) rate,m.acno,m.netamount,"
				+ "m.tr_no,round(j.ldramount,2) baseamount,t.atype,t.account,t.description accountname,c.type from my_cnot m left join my_jvtran j on (m.tr_no=j.tr_no and m.acno=j.acno) "
				+ "left join my_head t on m.acno=t.doc_no left join my_curr c on m.curId=c.doc_no where m.dtype='TDN' and m.status<>7 and m.brhId='"+branch+"' and m.doc_no="+docNo+" "
				+ "group by tr_no");
	
			while (resultSet.next()) {
				debitNoteBean.setTxtdebitnotedocno(docNo);
				debitNoteBean.setJqxDebitNoteDate(resultSet.getDate("date").toString());
				debitNoteBean.setTxtrefno(resultSet.getString("refNo"));
				
				debitNoteBean.setTxtdocno(resultSet.getInt("acno"));
				debitNoteBean.setTxttrno(resultSet.getInt("tr_no"));
				debitNoteBean.setCmbtype(resultSet.getString("atype"));
				debitNoteBean.setTxtaccid(resultSet.getString("account"));
				debitNoteBean.setTxtaccname(resultSet.getString("accountname"));
				debitNoteBean.setHidcmbcurrency(resultSet.getString("curId"));
				debitNoteBean.setHidcurrencytype(resultSet.getString("type"));
				debitNoteBean.setTxtrate(resultSet.getDouble("rate"));
				debitNoteBean.setTxtamount(resultSet.getDouble("amount"));
				debitNoteBean.setTxtbaseamount(resultSet.getDouble("baseamount"));
				debitNoteBean.setTxtdescription(resultSet.getString("description"));
				
				debitNoteBean.setTxtdrtotal(resultSet.getDouble("netamount"));
				debitNoteBean.setTxtcrtotal(resultSet.getDouble("netamount"));
		    }
			String sql="select coalesce((select gt.acno per from gl_taxmaster gt left join my_head h on h.doc_no=gt.acno where gt.status=3 and gt.type=1 and curdate()>=gt.fromdate and curdate()<=gt.todate  and gt.per!=0 ),0) taxaccnt " ;
	        System.out.println("debitnotesearch========="+sql);
	       ResultSet resultSettax = stmtDNO.executeQuery(sql);
	       while(resultSettax.next()){
	    	   debitNoteBean.setTaxaccount(resultSettax.getString("taxaccnt"));
	       }
			stmtDNO.close();
		    conn.close();
		}catch(Exception e){
		        e.printStackTrace();
		        conn.close();
		}finally{
			conn.close();
		}
		return debitNoteBean;
     }
	 
	 public ClsTaxDebitNoteBean getPrint(HttpServletRequest request,int docNo,int branch,int header) throws SQLException {
		 ClsTaxDebitNoteBean bean = new ClsTaxDebitNoteBean();
		 Connection conn = null;
		 System.out.println("printttt");
		try {
				conn = connDAO.getMyConnection();
				Statement stmtDNO = conn.createStatement();
				
				String headersql="select if(m.dtype='TDN',' Tax Debit Note','  ') vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
						+ "b.cstno,b.tinno from my_cnot m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
						+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='TDN' "
						+ "and m.brhid="+branch+" and m.doc_no="+docNo+"";
					
					ResultSet resultSetHead = stmtDNO.executeQuery(headersql);
					
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
					
					String sql="select m.refNo,m.doc_no,DATE_FORMAT(m.date,'%d-%m-%Y') date,m.description,round(m.netAmount,2) netAmount,t.description accountname,ac.trnnumber,u.user_name,ac.address,ac.codeno,ac.per_mob,ac.per_tel from my_cnot m left join my_head t on "
							+ "m.acno=t.doc_no left join my_acbook ac on ac.acno=m.acno left join my_user u on m.userid=u.doc_no where m.dtype='TDN' and m.brhid="+branch+" and m.doc_no="+docNo+"";
					System.out.println("query===="+sql);
				ResultSet resultSet = stmtDNO.executeQuery(sql);
				
				ClsAmountToWords c = new ClsAmountToWords();
				
				while(resultSet.next()){
					bean.setLblclienttrno(resultSet.getString("trnnumber"));
					bean.setLbldocumentno(resultSet.getString("doc_no"));
					bean.setLbldate(resultSet.getString("date"));
					bean.setLblaccountname(resultSet.getString("accountname"));
					bean.setLbldescription(resultSet.getString("description"));
					bean.setLbldebittotal(resultSet.getString("netAmount"));
					bean.setLblcredittotal(resultSet.getString("netAmount"));
					bean.setLblnetamount(resultSet.getString("netAmount"));
					bean.setLblnetamountwords(c.convertAmountToWords(resultSet.getString("netAmount")));
					bean.setLblpreparedby(resultSet.getString("user_name"));
					bean.setLblcustaddress(resultSet.getString("address"));
					bean.setLblcustcodeno(resultSet.getString("codeno"));
					System.out.println("code----"+resultSet.getString("codeno")+"...."+resultSet.getString("per_mob"));
					bean.setLblcustmobno(resultSet.getString("per_mob"));
					bean.setLblcustphno(resultSet.getString("per_tel"));
					bean.setTxtrefno(resultSet.getString("refNo"));
				}
				
				bean.setTxtheader(header);
	
				String sql1 = "";
			
				sql1="SELECT t.account,t.description accountname,c.code currency,j.description,if(j.dramount>0,round((j.dramount*1),2),'  ') debit,if(j.dramount<0,round((j.dramount*-1),2),' ') credit "
				  + "FROM my_jvtran j left join my_head t on j.acno=t.doc_no left join my_curr c on c.doc_no=j.curId WHERE j.dtype='TDN' and j.brhid="+branch+" and j.doc_no="+docNo+"  order by j.dramount desc";
				
				ResultSet resultSet1 = stmtDNO.executeQuery(sql1);
				System.out.println("gridqryyyyyyyyyyyy"+sql1);
				ArrayList<String> printarray= new ArrayList<String>();
				
				while(resultSet1.next()){
					bean.setFirstarray(1); 
					String temp="";
					temp=resultSet1.getString("account")+"::"+resultSet1.getString("accountname")+"::"+resultSet1.getString("description")+"::"+resultSet1.getString("currency")+"::"+resultSet1.getString("debit")+"::"+resultSet1.getString("credit");
				    printarray.add(temp);
				}
	
				request.setAttribute("printingarray", printarray);
				
				
				String taxsql="";
				taxsql="SELECT J.SR_NO,if(t.description in ('VAT INPUT','VAT OUTPUT'), 'VAT 5%',t.description) accountname,if(j.amount<0,round((j.amount*-1),2),' ') amount FROM my_cnot c left join my_cnotd j "
						+"on c.tr_no=j.tr_no "
						+"left join my_head t on j.acno=t.doc_no WHERE c.dtype='TDN' and c.brhid="+branch+" and c.doc_no="+docNo+"";
						System.out.println("gridqry====="+taxsql);
						ResultSet resultSettaxqry = stmtDNO.executeQuery(taxsql);
						
				
                ArrayList<String> printarray1= new ArrayList<String>();
				
				while(resultSettaxqry.next()){
					bean.setSecarray(1); 
					String temp1="";
					temp1=resultSettaxqry.getString("accountname")+"::"+resultSettaxqry.getString("amount");
				    printarray1.add(temp1);
				}
	
				request.setAttribute("printingarray1", printarray1);
				
				
				String sql2 = "select min(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,min(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from my_cnot m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='TDN' and m.brhid="+branch+" and m.doc_no="+docNo+"";
				
				ResultSet resultSet2 = stmtDNO.executeQuery(sql2);
				
				while(resultSet2.next()){
					bean.setLblpreparedon(resultSet2.getString("preparedon"));
					bean.setLblpreparedat(resultSet2.getString("preparedat"));
				}
			
				
				String sqldate="SELECT DATE_FORMAT(CURDATE(),'%d-%m-%Y')currentdate" ;
				
			ResultSet rs=stmtDNO.executeQuery(sqldate);
			
			while(rs.next()){
				bean.setCurrentdate(rs.getString("currentdate"));
				System.out.println("sssssssss"+rs.getString("currentdate"));
			}
			
			stmtDNO.close();
			conn.close();
			
				
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return bean;
	}
	 
	 public int insertion(Connection conn, int docno, int trno, String formdetailcode, double nettotal, Date debitNoteDate, String txtrefno, double txtrate, String txtdescription, double txtdrtotal, 
			 String rtype, int rdocno,ArrayList<String> debitnotearray,HttpSession session,String mode) throws SQLException{
			
			  try{
					//conn.setAutoCommit(false);
					CallableStatement stmtDNO=null;
					String branch=session.getAttribute("BRANCHID").toString().trim();

					/*Debit-Note Grid and Details Saving*/
					for(int i=0;i < debitnotearray.size();i++){
						String[] debit=debitnotearray.get(i).split("::");
						if(!debit[0].trim().equalsIgnoreCase("undefined") && !debit[0].trim().equalsIgnoreCase("NaN")){
							
							int id = 0;
							if(debit[3].trim().equalsIgnoreCase("true")){
								id=-1;
							}
							else if(debit[3].trim().equalsIgnoreCase("false")){
								id=1;
							}
							
							stmtDNO = conn.prepareCall("{CALL taxcnotdDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
							
							/*Insertion to my_cnotd*/
							stmtDNO.setInt(19,trno); 
							stmtDNO.setInt(20,docno);
							stmtDNO.registerOutParameter(21, java.sql.Types.INTEGER);
							stmtDNO.setInt(1,(i+1)); //SR_NO
							stmtDNO.setString(2,(debit[0].trim().equalsIgnoreCase("undefined") || debit[0].trim().equalsIgnoreCase("NaN") || debit[0].trim().isEmpty()?0:debit[0].trim()).toString());  //doc_no of my_head
							stmtDNO.setString(3,(debit[1].trim().equalsIgnoreCase("undefined") || debit[1].trim().equalsIgnoreCase("NaN") || debit[1].trim().isEmpty()?0:debit[1].trim()).toString()); //curId
							stmtDNO.setString(4,(debit[2].trim().equalsIgnoreCase("undefined") || debit[2].equalsIgnoreCase("NaN") || debit[2].trim().equals(0) || debit[2].trim().isEmpty()?1:debit[2].trim()).toString()); //rate 
							stmtDNO.setInt(5,id); //#debit 1 / debit -1 
							stmtDNO.setString(6,(debit[4].trim().equalsIgnoreCase("undefined") || debit[4].trim().equalsIgnoreCase("NaN") || debit[4].trim().isEmpty()?0:debit[4].trim()).toString()); //amount
							stmtDNO.setString(7,(debit[5].trim().equalsIgnoreCase("undefined") || debit[5].trim().equalsIgnoreCase("NaN") || debit[5].trim().isEmpty()?0:debit[5].trim()).toString()); //description
							stmtDNO.setDouble(8,nettotal); //netTotal 
							stmtDNO.setString(9,(debit[7].trim().equalsIgnoreCase("undefined") || debit[7].trim().equalsIgnoreCase("NaN") || debit[7].trim().equalsIgnoreCase("") || debit[7].trim().equalsIgnoreCase("0") || debit[7].trim().isEmpty()?0:debit[7].trim()).toString());  //Cost Type
							stmtDNO.setString(10,(debit[8].trim().equalsIgnoreCase("undefined") || debit[8].trim().equalsIgnoreCase("NaN") || debit[8].trim().equalsIgnoreCase("") || debit[8].trim().equalsIgnoreCase("0") || debit[8].trim().isEmpty()?0:debit[8].trim()).toString());  //Cost Code
							stmtDNO.setString(11,rtype); //rtype
							stmtDNO.setInt(12,rdocno); //rdocno
							/*my_cnotd Ends*/
							
							/*Insertion to my_jvtran*/
							stmtDNO.setDate(13,debitNoteDate);
							stmtDNO.setString(14,txtrefno);
							stmtDNO.setInt(15,id);  //id
							stmtDNO.setString(16,(debit[6].trim().equalsIgnoreCase("undefined") || debit[6].equalsIgnoreCase("NaN") || debit[6].isEmpty()?0:debit[6].trim()).toString());  //base-amount
							//stmtDNO.setString(13,(debit[7].trim().equalsIgnoreCase("undefined") || debit[7].trim().equalsIgnoreCase("NaN") || debit[7].trim().isEmpty()?0:debit[7].trim()).toString());  //out-amount
							/*my_jvtran Ends*/
							
							stmtDNO.setString(17,formdetailcode);
							stmtDNO.setString(18,branch);
							stmtDNO.setString(22,mode);
							stmtDNO.setDouble(23,(debit[9].trim().equalsIgnoreCase("undefined") || debit[9].trim().equalsIgnoreCase("NaN") || debit[9].trim().equalsIgnoreCase("") || debit[9].trim().equalsIgnoreCase("0") || debit[9].trim().isEmpty()?0.0:Double.parseDouble(debit[9].trim())));
							stmtDNO.setDouble(24,(debit[10].trim().equalsIgnoreCase("undefined") || debit[10].trim().equalsIgnoreCase("NaN") || debit[10].trim().equalsIgnoreCase("") || debit[10].trim().equalsIgnoreCase("0") || debit[10].trim().isEmpty()?0.0:Double.parseDouble(debit[10].trim())));
							stmtDNO.setDouble(25,(debit[11].trim().equalsIgnoreCase("undefined") || debit[11].trim().equalsIgnoreCase("NaN") || debit[11].trim().equalsIgnoreCase("") || debit[11].trim().equalsIgnoreCase("0") || debit[11].trim().isEmpty()?0.0:Double.parseDouble(debit[11].trim())));
							stmtDNO.setString(26,(debit[12].trim().equalsIgnoreCase("undefined") || debit[12].trim().equalsIgnoreCase("NaN") || debit[12].trim().equalsIgnoreCase("") || debit[12].trim().equalsIgnoreCase("0") || debit[12].trim().isEmpty()?0:debit[12].trim()).toString());
							stmtDNO.setDouble(27,(debit[13].trim().equalsIgnoreCase("undefined") || debit[13].trim().equalsIgnoreCase("NaN") || debit[13].trim().equalsIgnoreCase("") || debit[13].trim().equalsIgnoreCase("0") || debit[13].trim().isEmpty()?0.0:Double.parseDouble(debit[13].trim())));
							stmtDNO.execute();
							if(stmtDNO.getInt("irowsNo")<=0){
								stmtDNO.close();
								conn.close();
								return 0;
							}
						    }
						    /*Debit-Note Grid and Details Saving Ends*/
						}
						stmtDNO.close();
			   }catch(Exception e){	
				 	e.printStackTrace();
				 	conn.close();
				 	return 0;
			 }
			return 1;
		}
}
