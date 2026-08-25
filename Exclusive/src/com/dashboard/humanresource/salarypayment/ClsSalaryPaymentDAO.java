package com.dashboard.humanresource.salarypayment;

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
import com.finance.transactions.journalvouchers.ClsJournalVouchersDAO;

public class ClsSalaryPaymentDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	public int insert(String mainbranch, String year, String month, String payableaccount, double txtdrtotal, double txtcrtotal, String txtselectedemployees, Date paymentDate,
			String[] employeearray,ArrayList<String> paymentarray, HttpSession session,HttpServletRequest request,String mode) throws SQLException {
		 
		Connection conn  = null;
		  
			try{
				
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtBSP = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
		        
				/*Inserting into my_jvma and my_jvtran*/
				int docno=0,trno=0,docNo=0;
	        	ClsJournalVouchersDAO jvt = new ClsJournalVouchersDAO();
				docno=jvt.insert(paymentDate,"JVT".concat("-12"), "BSP", "Salary Payment on "+paymentDate ,txtdrtotal, txtcrtotal, paymentarray, session, request);
			    trno=Integer.parseInt(request.getAttribute("tranno").toString());
			    /*Inserting my_jvma and my_jvtran Ends*/
				 
				if(docno>0){
					
					 String sql="update hr_payroll p,hr_payrolld d set d.salary_payment="+trno+" where (p.doc_no=d.rdocno) and d.posted>0 and YEAR(p.date)=YEAR('"+year+"-"+month+"-01') "
							   + "and MONTH(p.date)=MONTH('"+year+"-"+month+"-01') and d.empid in ("+txtselectedemployees+")";
					 int data= stmtBSP.executeUpdate(sql);
					 if(data<=0){
						 stmtBSP.close();
						 conn.close();
						 return 0;
					 }
					 
					 String sql1="select coalesce(max(doc_no)+1,1) doc_no from hr_bsp";
				     ResultSet resultSet = stmtBSP.executeQuery(sql1);
				  
				     while (resultSet.next()) {
						   docNo=resultSet.getInt("doc_no");
				     }
				        
			        /*Inserting hr_bsp*/
				     String sql2="insert into hr_bsp(doc_no, date, tr_no, employeeIds, brhid, userid) values("+docNo+",'"+paymentDate+"',"+trno+",'"+txtselectedemployees+"',"+branch+","+userid+")";
				     int data1= stmtBSP.executeUpdate(sql2);
					 if(data1<=0){
						 	stmtBSP.close();
							conn.close();
							return 0;
						}
					 /*Inserting hr_bsp Ends*/
					 
					 String sqls="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+branch+"','BSP',now(),'"+userid+"','A')";
					 int datas= stmtBSP.executeUpdate(sqls);
					 if(datas<=0){
						 	stmtBSP.close();
						    conn.close();
							return 0;
						}
					conn.commit();
					stmtBSP.close();
					conn.close();
					return docno;
				}
			stmtBSP.close();
			conn.close();	
		 } catch(Exception e){	
			 	conn.close();
			 	e.printStackTrace();	
			 	return 0;
		 } finally{
			 conn.close();
		 }
		return 0;
	}
	
	public JSONArray salaryPaymentGridLoading(String branch, String year, String month, String category, String agent, String statusID, String establishmentcode, String check) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtBSP = conn.createStatement();
		        
		        if(check.equalsIgnoreCase("1")) {
		       
	    	    String sql = "";
				
	    	    if(!(year.equalsIgnoreCase("")) && !(year.equalsIgnoreCase("0")) && !(year.equalsIgnoreCase("null"))){
	            	sql=sql+" and YEAR(p.date)="+year;
	            }
	    	    if(!(month.equalsIgnoreCase("")) && !(month.equalsIgnoreCase("0")) && !(month.equalsIgnoreCase("null"))){
	            	sql=sql+" and MONTH(p.date)="+month;
	            }
	    	    if(!(category.equalsIgnoreCase("")) && !(category.equalsIgnoreCase("0")) && !(category.equalsIgnoreCase("null"))){
	                sql=sql+" and m.pay_catid='"+category+"'";
	            }
	            if(!(agent.equalsIgnoreCase("")) && !(agent.equalsIgnoreCase("0")) && !(agent.equalsIgnoreCase("null"))){
	            	sql=sql+" and m.agent_id='"+agent+"'";
	            }
	            if(!(establishmentcode.equalsIgnoreCase("")) && !(establishmentcode.equalsIgnoreCase("0")) && !(establishmentcode.equalsIgnoreCase("null"))){
	            	sql=sql+" and m.est_code='"+establishmentcode+"'";
	            }
	            if(!(statusID.equalsIgnoreCase(""))){
	            	if(statusID.equalsIgnoreCase("1")) {
	            		sql=sql+" and d.salary_payment=0";
	            	} else {
	            		sql=sql+" and d.salary_payment>0";
	            	}
	            }

				sql = "select m.doc_no empdocno,m.codeno empid,m.name empname,m.emp_id bankempid,m.bnk_acc_no bankaccount,m.brchname bankbranch,m.ifsccode bankifsc,"
					+ "round(d.netsalary,0) netsalary,a.desc1 agent from hr_payroll p left join hr_payrolld d on p.doc_no=d.rdocno left join hr_empm m on (d.empid=m.doc_no "
					+ "and m.dtype='EMP') left join hr_setagent a on (m.agent_id=a.doc_no and a.status=3) where p.status=3 and d.status=3 and  d.posted>0"+sql+" order by m.name";
				System.out.println("grid=="+sql);
				ResultSet resultSet1 = stmtBSP.executeQuery(sql);
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
		        
		        }
		        
		        stmtBSP.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	  
	public JSONArray salaryPaymentGridLoadingexcel(String branch, String year, String month, String category, String agent, String statusID, String establishmentcode, String check) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtBSP = conn.createStatement();
		        
		        if(check.equalsIgnoreCase("1")) {
		       
	    	    String sql = "";
				
	    	    if(!(year.equalsIgnoreCase("")) && !(year.equalsIgnoreCase("0")) && !(year.equalsIgnoreCase("null"))){
	            	sql=sql+" and YEAR(p.date)="+year;
	            }
	    	    if(!(month.equalsIgnoreCase("")) && !(month.equalsIgnoreCase("0")) && !(month.equalsIgnoreCase("null"))){
	            	sql=sql+" and MONTH(p.date)="+month;
	            }
	    	    if(!(category.equalsIgnoreCase("")) && !(category.equalsIgnoreCase("0")) && !(category.equalsIgnoreCase("null"))){
	                sql=sql+" and m.pay_catid='"+category+"'";
	            }
	            if(!(agent.equalsIgnoreCase("")) && !(agent.equalsIgnoreCase("0")) && !(agent.equalsIgnoreCase("null"))){
	            	sql=sql+" and m.agent_id='"+agent+"'";
	            }
	            if(!(establishmentcode.equalsIgnoreCase("")) && !(establishmentcode.equalsIgnoreCase("0")) && !(establishmentcode.equalsIgnoreCase("null"))){
	            	sql=sql+" and m.est_code='"+establishmentcode+"'";
	            }
	            if(!(statusID.equalsIgnoreCase(""))){
	            	if(statusID.equalsIgnoreCase("1")) {
	            		sql=sql+" and d.salary_payment=0";
	            	} else {
	            		sql=sql+" and d.salary_payment>0";
	            	}
	            }

				sql = "select m.codeno EmpId,m.name Employee_Name,'E' Employee_Type,round(d.netsalary,0) Salary,"
					+ " '' Variable_Pay,m.bnk_acc_no AccountNo,m.ifsccode AGENT_BANK_RTN_CODE,m.emp_id MOL_PERSONID,"
					+ " month(date_add(d.date , interval 1 day)) sal_month,year(date_add(d.date , interval 1 day)) sal_year,"
					+ " date_add(d.date , interval 1 day ) FromDate , last_day(date_add(d.date , interval 1 day )) ToDate,"
					+ "(d.leave1+d.leave2+d.leave3+d.leave4+d.leave5+d.leave6+d.leave7+d.leave8+d.leave9+d.leave10) Total_Leave "
					+ "from hr_payroll p left join hr_payrolld d on p.doc_no=d.rdocno left join hr_empm m on "
					+ "(d.empid=m.doc_no and m.dtype='EMP') left join hr_setagent a on (m.agent_id=a.doc_no and a.status=3) "
					+ "where p.status=3 and d.status=3 and  d.posted>0"+sql+" order by m.name ";
				//
				
				
				System.out.println("gridexcel=="+sql);
				ResultSet resultSet1 = stmtBSP.executeQuery(sql);
				
				RESULTDATA1=ClsCommon.convertToEXCEL(resultSet1);
		        
		        }
		        
		        stmtBSP.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	  
	
	
	public JSONArray salaryPaymentGridSifExport(String branch, String year, String month, String category, String agent, String statusID, String establishmentCode, String bankName, String bankAccount, String paymentdate, String check) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtBSP = conn.createStatement();
		        
		        if(check.equalsIgnoreCase("1")) {
		       
		        java.sql.Date sqlPaymentDate=null;
		        	
		        paymentdate.trim();
	            if(!(paymentdate.equalsIgnoreCase("undefined"))&&!(paymentdate.equalsIgnoreCase(""))&&!(paymentdate.equalsIgnoreCase("0")))
	            {
	        	   sqlPaymentDate = ClsCommon.changeStringtoSqlDate(paymentdate);
	            }
			           
	    	    String sql = "";
				
	    	    if(!(year.equalsIgnoreCase("")) && !(year.equalsIgnoreCase("0")) && !(year.equalsIgnoreCase("null"))){
	            	sql=sql+" and YEAR(p.date)="+year;
	            }
	    	    if(!(month.equalsIgnoreCase("")) && !(month.equalsIgnoreCase("0")) && !(month.equalsIgnoreCase("null"))){
	            	sql=sql+" and MONTH(p.date)="+month;
	            }
	    	    if(!(category.equalsIgnoreCase("")) && !(category.equalsIgnoreCase("0")) && !(category.equalsIgnoreCase("null"))){
	                sql=sql+" and m.pay_catid='"+category+"'";
	            }
	            if(!(agent.equalsIgnoreCase("")) && !(agent.equalsIgnoreCase("0")) && !(agent.equalsIgnoreCase("null"))){
	            	sql=sql+" and m.agent_id='"+agent+"'";
	            }
	            if(!(establishmentCode.equalsIgnoreCase("")) && !(establishmentCode.equalsIgnoreCase("0")) && !(establishmentCode.equalsIgnoreCase("null"))){
	            	sql=sql+" and m.est_code='"+establishmentCode+"'";
	            }
	            if(!(statusID.equalsIgnoreCase(""))){
	            	if(statusID.equalsIgnoreCase("1")) {
	            		sql=sql+" and d.salary_payment=0";
	            	} else {
	            		sql=sql+" and d.salary_payment>0";
	            	}
	            }

				sql = "select 'EDR' emptype,m.emp_id empid,CONVERT(coalesce(m.ifsccode,''),CHAR(100)) ifsccode,CONVERT(coalesce(m.bnk_acc_no,''),CHAR(100)) ibanno,CONVERT(DATE_ADD(LAST_DAY(DATE_ADD(p.date,INTERVAL -1 MONTH)),INTERVAL 1 DAY),CHAR(50)) fromdate,CONVERT(LAST_DAY(p.date),CHAR(50)) todate,"
					+ "round((d.daystopay)-(d.leave1+d.leave2+d.leave3+d.leave4+d.leave5+d.leave6+d.leave7+d.leave8+d.leave9+d.leave10),0) days,CONVERT(round(d.netsalary,0),CHAR(50)) netsalary,CONVERT(LEFT(RIGHT(round(d.netsalary,2),2),1),CHAR(50)) netsalarydecimal1,CONVERT(RIGHT(round(d.netsalary,2),1),CHAR(50)) netsalarydecimal2 "
					+ "from hr_payroll p left join hr_payrolld d on p.doc_no=d.rdocno left join hr_empm m on (d.empid=m.doc_no and m.dtype='EMP') where p.status=3 and d.status=3 and  d.posted>0"+sql+" UNION ALL "
					+ "select 'SCR' emptype,REPLACE('"+establishmentCode+"','SCR,','') empid,CONVERT(coalesce(m.ifsccode,''),CHAR(100)) ifsccode,CONVERT('"+sqlPaymentDate+"',CHAR(100)) paiddate,CONVERT(DATE_FORMAT(now(),'%H%i'),CHAR(100)) times,CONCAT(if(LENGTH(MONTH(p.date))=1,CONCAT('0',MONTH(p.date)),MONTH(p.date)),YEAR(p.date)) salarymonth,"
					+ "count(*) empcount,CONVERT(round(sum(d.netsalary),2),CHAR(50)) netsalary,'AED' currencycode,CONCAT('for ','"+bankName+"') bankname from hr_payroll p left join hr_payrolld d on p.doc_no=d.rdocno left join hr_empm m on "
					+ "(d.empid=m.doc_no and m.dtype='EMP') where p.status=3 and d.status=3 and  d.posted>0"+sql+" ";
				/*order by m.name*/
				//System.out.println("===== "+sql);
				ResultSet resultSet1 = stmtBSP.executeQuery(sql);
				
				RESULTDATA1=ClsCommon.convertToSIF(resultSet1);
		        
		        }
		        
		        stmtBSP.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public JSONArray postedSalaryGridLoading(String branch, String year, String month, String category, String agent, String establishmentcode,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
	       
		       conn = ClsConnection.getMyConnection();
		       Statement stmtBSP = conn.createStatement();
		        
	           if(check.equalsIgnoreCase("1")){
		           
		        String sql="";
		       
		        if(!(category.equalsIgnoreCase("")) && !(category.equalsIgnoreCase("0")) && !(category.equalsIgnoreCase("null"))){
	                sql=sql+" and m.pay_catid='"+category+"'";
	            }
	            if(!(agent.equalsIgnoreCase("")) && !(agent.equalsIgnoreCase("0")) && !(agent.equalsIgnoreCase("null"))){
	            	sql=sql+" and m.agent_id='"+agent+"'";
	            }
	            if(!(establishmentcode.equalsIgnoreCase("")) && !(establishmentcode.equalsIgnoreCase("0")) && !(establishmentcode.equalsIgnoreCase("null"))){
	            	sql=sql+" and m.est_code='"+establishmentcode+"'";
	            }
	            
		        sql = "select * from (select 'To Be Paid' status,CONVERT(count(*),CHAR(50)) total,'1' statusid from hr_payroll p left join hr_payrolld d on p.doc_no=d.rdocno left join "
						+ "hr_empm m on (d.empid=m.doc_no and m.dtype='EMP') where p.status=3 and d.status=3  and d.posted>0 and d.salary_payment=0 and month(p.date)="+month+" and year(p.date)="+year+" "+sql+" UNION ALL " 
						+ "select 'Paid' status,CONVERT(count(*),CHAR(50)) total,'0' statusid from hr_payroll p left join hr_payrolld d on p.doc_no=d.rdocno left join "
						+ "hr_empm m on (d.empid=m.doc_no and m.dtype='EMP') where p.status=3 and d.status=3 and d.posted>0 and d.salary_payment>0  and month(p.date)="+month+" and year(p.date)="+year+" "+sql+" UNION ALL "
						+ "select 'ALL' status,'' total,'' statusid) a";
System.out.println("=== "+sql);
		       ResultSet resultSet = stmtBSP.executeQuery(sql);
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	           
		       stmtBSP.close();
		       conn.close();
		       }
	           stmtBSP.close();
			   conn.close();   
	     } catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     } finally{
				conn.close();
			}
	       return RESULTDATA;
	  }  

	public JSONArray salaryPaymentJVGridLoading(String year,String month,String bankaccount,String employees,String paymentPostingDate,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        Connection conn = null;
		
        try {
				conn = ClsConnection.getMyConnection();
				Statement stmtBSP = conn.createStatement();
			        
				String sql="select m.acno docno,h.atype type,h.account,h.description accountname,h.curid currencyid,c.code currency,c.type currencytype,round(cb.rate,2) rate,"
						+ "round(d.netsalary,0) debit,0 credit,(round(d.netsalary,0)*round(cb.rate,2)) baseamount,'1' id,CONCAT('Salary Payment of Emp Id #',m.codeno,'# Dated #',"
						+ "DATE_FORMAT('"+year+"-"+month+"-01','%b %Y'),'# on ','"+paymentPostingDate+"') description,(@totalnetsalary:=@totalnetsalary+(round(d.netsalary,0))) totalnetsalary from hr_empm m "
						+ "left join hr_payrolld d on (m.doc_no=d.empid and m.dtype='EMP') left join hr_payroll p on p.doc_no=d.rdocno left join my_head h on (m.acno=h.doc_no and h.atype='HR' and h.m_s=0) "
						+ "left join my_curr c on h.curid=c.doc_no left join my_curbook cb on h.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
						+ "where coalesce(toDate,curdate())>='"+year+"-"+month+"-01' and frmDate<='"+year+"-"+month+"-01' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid),"
						+ "(SELECT @totalnetsalary:= 0) as totalnetsalary where YEAR(p.date)=YEAR('"+year+"-"+month+"-01') and MONTH(p.date)=MONTH('"+year+"-"+month+"-01') and d.posted>0 and m.doc_no in ("+employees+") UNION ALL "  
						+ "select h.doc_no,h.atype type,h.account,h.description accountname,h.curid currencyid,c.code currency,c.type currencytype,round(cb.rate,2) rate,0 debit,@totalnetsalary credit,"
						+ "(@totalnetsalary*round(cb.rate,2)) baseamount,'-1' id,CONCAT('Salary Payment of Month #',DATE_FORMAT('"+year+"-"+month+"-01','%b %Y'),'# on ','"+paymentPostingDate+"') description,@totalnetsalary totalnetsalary "
						+ "from my_head h left join my_curr c on h.curid=c.doc_no left join my_curbook cb on h.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
						+ "where coalesce(toDate,curdate())>='"+year+"-01-01' and frmDate<='"+year+"-01-01' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where h.atype='GL' and h.m_s=0 "
						+ "and h.doc_no="+bankaccount+"";
				
				ResultSet resultSet = stmtBSP.executeQuery(sql);
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtBSP.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray accountsDetails(HttpSession session,String accountno,String accountname,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
	       
		       conn = ClsConnection.getMyConnection();
		       Statement stmtBSP = conn.createStatement();
	
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
	           
	           if(check.equalsIgnoreCase("1")) {
	        	   
		        String sqltest="";
		        String sql="";
		        
		        if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and t.account like '%"+accountno+"%'";
		        }
		        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		           sqltest=sqltest+" and t.description like '%"+accountname+"%'";
		        }
		        	
		        sql="select t.doc_no,t.account,t.description,t.atype,t.curid,c.code currency,round(cb.rate,2) rate,c.type from my_head t left join my_curr c on t.curid=c.doc_no "
			        	  + "left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
			        	  + "where coalesce(toDate,curdate())>=curdate() and frmDate<=curdate() group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
			        	  + "where t.atype='GL' and t.m_s=0 "+sqltest;
		        
		       ResultSet resultSet = stmtBSP.executeQuery(sql);
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	           
		       stmtBSP.close();
		       conn.close();
	           }
	           stmtBSP.close();
		       conn.close();
	     } catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     } finally{
				conn.close();
			}
	       return RESULTDATA;
	  }
	
	public JSONArray bankAccountsDetails(HttpSession session,String accountno,String accountname,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
	       
		       conn = ClsConnection.getMyConnection();
		       Statement stmtBSP = conn.createStatement();
	
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
	           
	           if(check.equalsIgnoreCase("1")) {
	        	   
		        String sqltest="";
		        String sql="";
		        
		        if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and t.account like '%"+accountno+"%'";
		        }
		        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		           sqltest=sqltest+" and t.description like '%"+accountname+"%'";
		        }
		        	
		        sql="select t.doc_no,t.account,t.description,t.atype,t.curid,c.code currency,round(cb.rate,2) rate,c.type from my_head t left join my_curr c on t.curid=c.doc_no "
			        	  + "left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
			        	  + "where coalesce(toDate,curdate())>=curdate() and frmDate<=curdate() group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
			        	  + "where t.atype='GL' and t.m_s=0 and t.den='305'"+sqltest;
		        
		       ResultSet resultSet = stmtBSP.executeQuery(sql);
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	           
		       stmtBSP.close();
		       conn.close();
	           }
	           stmtBSP.close();
		       conn.close();
	     } catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     } finally{
				conn.close();
			}
	       return RESULTDATA;
	  }
	
	public JSONArray establishmentCodeDetails(String establishmentcode,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
	       
		       conn = ClsConnection.getMyConnection();
		       Statement stmtBSP = conn.createStatement();
	
	           if(check.equalsIgnoreCase("1")) {
	        	   
		        String sqltest="";
		        String sql="";
		        
		        if(!(establishmentcode.equalsIgnoreCase("0")) && !(establishmentcode.equalsIgnoreCase(""))){
		           sqltest=sqltest+" and est_code like '%"+establishmentcode+"%'";
		        }
		        	
		        sql="select distinct est_code from hr_empm where status=3 and active=1"+sqltest;
		        
		       ResultSet resultSet = stmtBSP.executeQuery(sql);
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	           
		       stmtBSP.close();
		       conn.close();
	           }
	           stmtBSP.close();
		       conn.close();
	     } catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     } finally{
				conn.close();
			}
	       return RESULTDATA;
	  }

}
