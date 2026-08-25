package com.dashboard.humanresource.monthlypayrollposting;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.finance.transactions.journalvouchers.ClsJournalVouchersDAO;

public class ClsMonthlyPayrollPostingDAO {
	  
	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	
	public int insert(String mainbranch, Date payrollPostedDate, double txtdrtotal, String txtremarks, String txtselectedemployees, Date upToDate, ArrayList<String> postingarray, HttpSession session, HttpServletRequest request, String mode) throws SQLException {
		 Connection conn  = null;
		 int docno = 0,docNo=0;
	     int trno = 0;
	     ClsJournalVouchersDAO jvt = new ClsJournalVouchersDAO();
	     
			try{
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtBPO = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
		        /*Inserting into my_jvma and my_jvtran*/
				docno=jvt.insert(payrollPostedDate,"JVT".concat("-8"), "BMPP", "Payroll posted for Emp #"+txtselectedemployees+"# as JVT on "+payrollPostedDate ,txtdrtotal, txtdrtotal, postingarray, session, request);
			    trno=Integer.parseInt(request.getAttribute("tranno").toString());
			    /*Inserting my_jvma and my_jvtran Ends*/
				if(docno>0){

					String[] empIDs=txtselectedemployees.split(",");
					int employeeIDsLength=empIDs.length;
						
			       /*Updating hr_payrolld*/
					for (int i = 0; i < employeeIDsLength; i++) {
						String employees=empIDs[i];	
						
						if(!(employees.equalsIgnoreCase(""))){
							 String sql1="";
								 sql1="update hr_payroll p,hr_payrolld d set d.posted="+trno+" where (p.doc_no=d.rdocno) and d.posted=0 and MONTH(p.date)=MONTH('"+upToDate+"') and YEAR(p.date)=YEAR('"+upToDate+"')  and d.empid="+empIDs[i]+"";
								 int data= stmtBPO.executeUpdate(sql1);
								 if(data<=0){
								    stmtBPO.close();
									conn.close();
									return 0;
								}
							}
					}
					/*Updating hr_payrolld Ends*/
					
				    String sql="select coalesce(max(doc_no)+1,1) doc_no from hr_bmpp";
			        ResultSet resultSet = stmtBPO.executeQuery(sql);
			  
			        while (resultSet.next()) {
					   docNo=resultSet.getInt("doc_no");
			        }
			        
			        /*Inserting hr_bmpp*/
				     String sql2="insert into hr_bmpp(doc_no, date, postedtrno, postedtype, postedno, postedemp, postingDate, brhid, userid) values("+docNo+", '"+payrollPostedDate+"', '"+trno+"','JVT' , "+docno+", '"+txtselectedemployees+"', LAST_DAY(DATE_SUB('"+upToDate+"', INTERVAL 1 DAY)), '"+branch+"', '"+userid+"')";
				     System.out.println("-------------- "+sql2);
				     int data1= stmtBPO.executeUpdate(sql2);
					 if(data1<=0){
						
						    stmtBPO.close();
							conn.close();
							return 0;
						}
					 /*Inserting hr_bmpp Ends*/
					 
					 String sqls="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+branch+"','BMPP',now(),'"+userid+"','A')";
					 int datas= stmtBPO.executeUpdate(sqls);
					 if(datas<=0){
						    stmtBPO.close();
						    conn.close();
							return 0;
						}
					conn.commit();
					stmtBPO.close();
					conn.close();
					return docno;
				}else{
					
				}
			stmtBPO.close();
			conn.close();	
		 } catch(Exception e){
			    jvt.delete(docno, "JVT".concat("-8"), trno, session);
			 	e.printStackTrace();	
			 	conn.close();
			 	return 0;
		 } finally{
			 conn.close();
		 }
		return 0;
	}
	
	public JSONArray monthlyPayrollcategoryTotalGridLoading(String branch,String uptodate,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
	       
		       conn = connDAO.getMyConnection();
		       Statement stmtBPO = conn.createStatement();
		        
	           if(check.equalsIgnoreCase("1")){
	        	
	        	java.sql.Date sqlUpToDate=null;
	        	   
		        if(!(uptodate.equalsIgnoreCase("undefined"))&&!(uptodate.equalsIgnoreCase(""))&&!(uptodate.equalsIgnoreCase("0"))) {
		        	sqlUpToDate = commonDAO.changeStringtoSqlDate(uptodate);
		        }
		           
		        String sql="";
		       
		        if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		        	if(!((branch.equalsIgnoreCase("")))){
		        	  sql+=" and p.brhid="+branch+"";
		        	}
	    		}
		        
		       sql = "select * from ( select  m.pay_catid,c.desc1 category,round(sum(d.netsalary),0) amount from hr_payroll p left join hr_payrolld d on p.doc_no=d.rdocno "
		    	   + "left join hr_empm m on d.empid=m.doc_no left join hr_timesheet t on (t.empid=d.empid and t.year=YEAR('"+sqlUpToDate+"') and t.month=MONTH('"+sqlUpToDate+"')) left join hr_setpaycat c on m.pay_catid=c.doc_no where p.status=3 and d.status=3 and d.posted=0 and "
		    	   + "t.payroll_processed=1 and t.payroll_confirmed=1 and MONTH(p.date)=MONTH('"+sqlUpToDate+"') and YEAR(p.date)=YEAR('"+sqlUpToDate+"')"+sql+" group by m.pay_catid union all select 0 pay_catid,'ALL' category,"
		    	   + "round(sum(d.netsalary),0) amount from hr_payroll p left join hr_payrolld d on p.doc_no=d.rdocno left join hr_timesheet t on (t.empid=d.empid and t.year=YEAR('"+sqlUpToDate+"') and t.month=MONTH('"+sqlUpToDate+"')) where p.status=3 and d.status=3 and d.posted=0 and "
		    	   + "t.payroll_processed=1 and t.payroll_confirmed=1 and MONTH(p.date)=MONTH('"+sqlUpToDate+"') and YEAR(p.date)=YEAR('"+sqlUpToDate+"')"+sql+") a order by a.pay_catid";
		       
		       ResultSet resultSet = stmtBPO.executeQuery(sql);
		       RESULTDATA=commonDAO.convertToJSON(resultSet);
	           
		       stmtBPO.close();
		       conn.close();
		       }
	           stmtBPO.close();
			  conn.close();   
	     } catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     } finally{
				conn.close();
			}
	       return RESULTDATA;
	  }  
	
	public JSONArray monthlyPayrollPostingGridLoading(String branch,String uptodate,String category,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
	       
		       conn = connDAO.getMyConnection();
		       Statement stmtBPO = conn.createStatement();
		        
	           if(check.equalsIgnoreCase("1")){
	        	
	        	java.sql.Date sqlUpToDate=null;
	        	   
		        if(!(uptodate.equalsIgnoreCase("undefined"))&&!(uptodate.equalsIgnoreCase(""))&&!(uptodate.equalsIgnoreCase("0"))) {
		        	sqlUpToDate = commonDAO.changeStringtoSqlDate(uptodate);
		        }
		           
		        String sql="";
		       
		        if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		        	if(!((branch.equalsIgnoreCase("")))){
		        	  sql+=" and p.brhid="+branch+"";
		        	}
	    		}
		        
		        if(!(category.equalsIgnoreCase("0")) && !(category.equalsIgnoreCase(""))){
		        	sql+=" and m.pay_catid='"+category+"'";
			    }
		        
		       sql = "select DATE_FORMAT(p.date,'%b %Y') dates,d.daystopay,round(d.earnedbasic,0) basicsalary,round(d.earnedtotalsalary-d.earnedbasic,0) totalsalary,round(d.overtime,0) overtime,"
		    	   + "round(d.grosssalary,0) grosssalary,round(d.additions,0) additions,round(d.deductions,0) deductions,round(d.loan,0) loan,round(d.netsalary,0) netsalary,d.remarks,d.rdocno,"
		    	   + "d.empId employeedocno,m.codeno employeeid,m.name employeename,m.pay_catid empcatid from hr_payroll p left join hr_payrolld d on p.doc_no=d.rdocno left join hr_empm m on "
		    	   + "d.empid=m.doc_no left join hr_timesheet t on (t.empid=d.empid and t.year=YEAR('"+sqlUpToDate+"') and t.month=MONTH('"+sqlUpToDate+"')) where p.status=3 and d.status=3 and d.posted=0 and t.payroll_processed=1 and t.payroll_confirmed=1 and "
		    	   + "MONTH(p.date)=MONTH('"+sqlUpToDate+"') and YEAR(p.date)=YEAR('"+sqlUpToDate+"')"+sql+"";
		       
		       ResultSet resultSet = stmtBPO.executeQuery(sql);
		       RESULTDATA=commonDAO.convertToJSON(resultSet);
	           
		       stmtBPO.close();
		       conn.close();
		       }
	           stmtBPO.close();
			  conn.close();   
	     } catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     } finally{
				conn.close();
			}
	       return RESULTDATA;
	  }  
	
	public JSONArray monthlyPayrollPostingJVGridLoading(String branch,String uptodate,String category,String employees,String postDate,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
	       
		       conn = connDAO.getMyConnection();
		       Statement stmtBPO = conn.createStatement();
		        
	           if(check.equalsIgnoreCase("1")){
	        	
	        	java.sql.Date sqlUpToDate=null;
	        	   
		        if(!(uptodate.equalsIgnoreCase("undefined"))&&!(uptodate.equalsIgnoreCase(""))&&!(uptodate.equalsIgnoreCase("0"))) {
		        	sqlUpToDate = commonDAO.changeStringtoSqlDate(uptodate);
		        }
		        
		        ArrayList analysisrowarray= new ArrayList();
		        ArrayList<ArrayList<String>> employeeAccountsJVProcessed= new ArrayList<ArrayList<String>>();
		        
		       double roundOffValues=0.00,roundOffValues1=0.00,roundOffValuesDiff=0.00;
		      
			   String sql = "";
		       
			   /* Taking Basic & Allowances*/
		       sql = "select a.alwid,sum(a.allowanceamount) allowanceamount,a.acno allowanceacno,a.atype allowancetype,a.account allowanceaccount,a.description allowanceaccountname,a.currencytype allowancecurrencytype,"
		    		+ "a.curid allowancecurrencyid,a.rate allowancerate,a.costtype,a.costcode from (select ac.alwid,ac.costtype,ac.costcode,case when ac.alwid=-2 then round(d.overtime,0) when ac.alwid=0 then " 
		       		+ "round((d.earnedbasic),0) when ac.alwid=1 then round(d.earnedallowance1,0) when ac.alwid=2 then round(d.earnedallowance2,0) when ac.alwid=3 then round(d.earnedallowance3,0) when ac.alwid=4 then "
		    		+ "round(d.earnedallowance4,0) when ac.alwid=5 then round(d.earnedallowance5,0) when ac.alwid=6 then round(d.earnedallowance6,0) when ac.alwid=7 then round(d.earnedallowance7,0) when ac.alwid=8 "
		       		+ "then round(d.earnedallowance8,0) when ac.alwid=9 then round(d.earnedallowance9,0) when ac.alwid=10 then round(d.earnedallowance10,0) else round(0.00,0) end as allowanceamount,ac.acno,"
		    		+ "h.atype,h.account,h.description,h.curid,h.rate,c.type currencytype,d.empId from hr_payroll p left join hr_payrolld d on p.doc_no=d.rdocno left join hr_empm m on d.empid=m.doc_no left join "
		       		+ "hr_timesheet t on (t.empid=d.empid and t.year=YEAR('"+sqlUpToDate+"') and t.month=MONTH('"+sqlUpToDate+"')) left join (select max(doc_no) docno,catid from hr_paycode where revdate<='"+sqlUpToDate+"' group by catid) a on a.catid=m.pay_catid left join hr_paycodeac ac "
		       		+ "on a.docno=ac.rdocno left join my_head h on ac.acno=h.doc_no left join my_curr c on h.curid=c.doc_no where p.status=3 and d.status=3 and d.posted=0 and t.payroll_processed=1 and t.payroll_confirmed=1 "
		       		+ "and MONTH(p.date)=MONTH('"+sqlUpToDate+"') and YEAR(p.date)=YEAR('"+sqlUpToDate+"') and d.empid in ("+employees+") order by m.doc_no,ac.alwid,m.pay_catid ) as a group by a.acno,a.alwid having allowanceamount!=0";
		       System.out.println("===== "+sql);
		        ResultSet resultSet = stmtBPO.executeQuery(sql);
				
				while(resultSet.next()){
					ArrayList<String> temp=new ArrayList<String>();

					temp.add(resultSet.getString("allowanceacno"));temp.add(resultSet.getString("allowancetype"));temp.add(resultSet.getString("allowanceaccount"));temp.add(resultSet.getString("allowanceaccountname"));
					temp.add(resultSet.getString("allowanceamount"));temp.add("0.00");temp.add(String.valueOf(resultSet.getDouble("allowanceamount")*resultSet.getDouble("allowancerate")));temp.add("PAYROLL POSTING OF BASIC AND ALLOWANCES ON "+postDate);
					temp.add(resultSet.getString("allowancecurrencyid"));temp.add(resultSet.getString("allowancecurrencytype"));temp.add(resultSet.getString("allowancerate"));temp.add("1");temp.add(resultSet.getString("costtype"));
					temp.add(resultSet.getString("costcode"));
					
					roundOffValues+=resultSet.getDouble("allowanceamount");
					
					employeeAccountsJVProcessed.add(temp);
				}
				/* Taking Basic & Allowances Ends*/
				
				String sql1="";
				
				/* Taking Additions & Deductions*/
				sql1 = "select d.empid,round(sum(ad.addition),0) addition,round(sum(ad.deduction),0) deduction,ad.acno,ad.costtype,ad.costcode,h.atype,h.account,h.description accountname,h.curid,h.rate,"  
					 + "c.type currencytype from hr_payroll p left join hr_payrolld d on p.doc_no=d.rdocno left join hr_adddedd ad on d.empid=ad.empid left join hr_adddedm am on ad.rdocno=am.doc_no left join "
					 + "hr_timesheet t on (t.empid=d.empid and t.year=YEAR('"+sqlUpToDate+"') and t.month=MONTH('"+sqlUpToDate+"')) left join my_head h on ad.acno=h.doc_no left join my_curr c on h.curid=c.doc_no where p.status=3 and d.status=3 and d.posted=0 and t.payroll_processed=1 "
					 + "and t.payroll_confirmed=1 and am.status=3 and ad.posted=0 and am.month=MONTH('"+sqlUpToDate+"') and am.year=YEAR('"+sqlUpToDate+"') and MONTH(p.date)=MONTH('"+sqlUpToDate+"') and "
					 + "YEAR(p.date)=YEAR('"+sqlUpToDate+"') and d.empid in ("+employees+") group by ad.acno";
				System.out.println("===== "+sql1);
		        ResultSet resultSet1 = stmtBPO.executeQuery(sql1);
		        
		        while(resultSet1.next()){
					ArrayList<String> temp1=new ArrayList<String>();
					ArrayList<String> temp2=new ArrayList<String>();

					if(resultSet1.getDouble("addition")>0.00 && resultSet1.getDouble("deduction")>0.00) {
						temp1.add(resultSet1.getString("acno"));temp1.add(resultSet1.getString("atype"));temp1.add(resultSet1.getString("account"));temp1.add(resultSet1.getString("accountname"));
						temp1.add(resultSet1.getString("addition"));temp1.add("0.00");temp1.add(String.valueOf(resultSet1.getDouble("addition")*resultSet1.getDouble("rate")));temp1.add("PAYROLL POSTING OF ADDITION ON "+postDate);
						temp1.add(resultSet1.getString("curid"));temp1.add(resultSet1.getString("currencytype"));temp1.add(resultSet1.getString("rate"));temp1.add("1");temp1.add(resultSet1.getString("costtype"));
						temp1.add(resultSet1.getString("costcode"));
						roundOffValues+=resultSet1.getDouble("addition");
						employeeAccountsJVProcessed.add(temp1);
						
						temp2.add(resultSet1.getString("acno"));temp2.add(resultSet1.getString("atype"));temp2.add(resultSet1.getString("account"));temp2.add(resultSet1.getString("accountname"));
						temp2.add("0.00");temp2.add(resultSet1.getString("deduction"));temp2.add(String.valueOf(resultSet1.getDouble("deduction")*resultSet1.getDouble("rate")));temp2.add("PAYROLL POSTING OF DEDUCTION ON "+postDate);
						temp2.add(resultSet1.getString("curid"));temp2.add(resultSet1.getString("currencytype"));temp2.add(resultSet1.getString("rate"));temp2.add("-1");temp2.add(resultSet1.getString("costtype"));
						temp2.add(resultSet1.getString("costcode"));
						roundOffValues1+=resultSet1.getDouble("deduction");
						employeeAccountsJVProcessed.add(temp2);
						
					}

					if(resultSet1.getDouble("addition")>0.00 && resultSet1.getDouble("deduction")==0.00) {
						temp1.add(resultSet1.getString("acno"));temp1.add(resultSet1.getString("atype"));temp1.add(resultSet1.getString("account"));temp1.add(resultSet1.getString("accountname"));
						temp1.add(resultSet1.getString("addition"));temp1.add("0.00");temp1.add(String.valueOf(resultSet1.getDouble("addition")*resultSet1.getDouble("rate")));temp1.add("PAYROLL POSTING OF ADDITION ON "+postDate);
						temp1.add(resultSet1.getString("curid"));temp1.add(resultSet1.getString("currencytype"));temp1.add(resultSet1.getString("rate"));temp1.add("1");temp1.add(resultSet1.getString("costtype"));
						temp1.add(resultSet1.getString("costcode"));
						roundOffValues+=resultSet1.getDouble("addition");
						employeeAccountsJVProcessed.add(temp1);
					}
					
					if(resultSet1.getDouble("addition")==0.00 && resultSet1.getDouble("deduction")>0.00) {
						temp1.add(resultSet1.getString("acno"));temp1.add(resultSet1.getString("atype"));temp1.add(resultSet1.getString("account"));temp1.add(resultSet1.getString("accountname"));
						temp1.add("0.00");temp1.add(resultSet1.getString("deduction"));temp1.add(String.valueOf(resultSet1.getDouble("deduction")*resultSet1.getDouble("rate")));temp1.add("PAYROLL POSTING OF DEDUCTION ON "+postDate);
						temp1.add(resultSet1.getString("curid"));temp1.add(resultSet1.getString("currencytype"));temp1.add(resultSet1.getString("rate"));temp1.add("-1");temp1.add(resultSet1.getString("costtype"));
						temp1.add(resultSet1.getString("costcode"));
						roundOffValues1+=resultSet1.getDouble("deduction");
						employeeAccountsJVProcessed.add(temp1);
					}
				}
		        /* Taking Additions & Deductions Ends*/
		        
		        /* Checking Config whether Net Amount should be credited to Common/Employee Account*/
		        String method="";
		        String sqls ="select method from gl_config where field_nme='HRMonthlyPayrollNetCommonAccount'";
		        ResultSet resultSets = stmtBPO.executeQuery(sqls);
		        
		        while(resultSets.next()){
		        	method=resultSets.getString("method");
		        }
		        /* Checking Config whether Net Amount should be credited to Common/Employee Account Ends*/
		        
		        if(method.equalsIgnoreCase("0")) {
		        	
		        String sql2 ="";
		        
		       sql2 = "select d.empid,round(d.loan,0) loan,round(d.netsalary,0) netsalary,m.acno,h.atype,h.account,h.description accountname,h.curid,h.rate,c.type currencytype,'0' costtype,'0' costcode from hr_payroll p left join "
		    		 + "hr_payrolld d on p.doc_no=d.rdocno left join hr_empm m on d.empid=m.doc_no left join hr_timesheet t on (t.empid=d.empid and t.year=YEAR('"+sqlUpToDate+"') and t.month=MONTH('"+sqlUpToDate+"')) left join my_head h on m.acno=h.doc_no left join my_curr c on h.curid=c.doc_no where "
		    		 + "p.status=3 and d.status=3 and d.posted=0 and t.payroll_processed=1 and t.payroll_confirmed=1 and MONTH(p.date)=MONTH('"+sqlUpToDate+"') and YEAR(p.date)=YEAR('"+sqlUpToDate+"') and d.empid in ("+employees+") ";
		       System.out.println("===== "+sql2);
		        ResultSet resultSet2 = stmtBPO.executeQuery(sql2);
		        
		        while(resultSet2.next()){
					ArrayList<String> temp3=new ArrayList<String>();
					ArrayList<String> temp4=new ArrayList<String>();
					
					/*Taking Loan & Employee Net-Salary*/
					if(resultSet2.getDouble("loan")>0.00 && resultSet2.getDouble("netsalary")>0.00) {
						temp3.add(resultSet2.getString("acno"));temp3.add(resultSet2.getString("atype"));temp3.add(resultSet2.getString("account"));temp3.add(resultSet2.getString("accountname"));
						temp3.add("0.00");temp3.add(resultSet2.getString("loan"));temp3.add(String.valueOf(resultSet2.getDouble("loan")*resultSet2.getDouble("rate")));temp3.add("PAYROLL POSTING OF LOAN ON "+postDate);
						temp3.add(resultSet2.getString("curid"));temp3.add(resultSet2.getString("currencytype"));temp3.add(resultSet2.getString("rate"));temp3.add("-1");temp3.add(resultSet2.getString("costtype"));
						temp3.add(resultSet2.getString("costcode"));
						roundOffValues1+=resultSet2.getDouble("loan");
						employeeAccountsJVProcessed.add(temp3);
						
						temp4.add(resultSet2.getString("acno"));temp4.add(resultSet2.getString("atype"));temp4.add(resultSet2.getString("account"));temp4.add(resultSet2.getString("accountname"));
						temp4.add("0.00");temp4.add(resultSet2.getString("netsalary"));temp4.add(String.valueOf(resultSet2.getDouble("netsalary")*resultSet2.getDouble("rate")));temp4.add("PAYROLL POSTING OF NET-SALARY ON "+postDate);
						temp4.add(resultSet2.getString("curid"));temp4.add(resultSet2.getString("currencytype"));temp4.add(resultSet2.getString("rate"));temp4.add("-1");temp4.add(resultSet2.getString("costtype"));
						temp4.add(resultSet2.getString("costcode"));
						roundOffValues1+=resultSet2.getDouble("netsalary");
						employeeAccountsJVProcessed.add(temp4);
						
					}

					if(resultSet2.getDouble("loan")==0.00 && resultSet2.getDouble("netsalary")>0.00) {
						temp4.add(resultSet2.getString("acno"));temp4.add(resultSet2.getString("atype"));temp4.add(resultSet2.getString("account"));temp4.add(resultSet2.getString("accountname"));
						temp4.add("0.00");temp4.add(resultSet2.getString("netsalary"));temp4.add(String.valueOf(resultSet2.getDouble("netsalary")*resultSet2.getDouble("rate")));temp4.add("PAYROLL POSTING OF NET-SALARY ON "+postDate);
						temp4.add(resultSet2.getString("curid"));temp4.add(resultSet2.getString("currencytype"));temp4.add(resultSet2.getString("rate"));temp4.add("-1");temp4.add(resultSet2.getString("costtype"));
						temp4.add(resultSet2.getString("costcode"));
						roundOffValues1+=resultSet2.getDouble("netsalary");
						employeeAccountsJVProcessed.add(temp4);
					}
		        }
		        
		        /*Taking Loan & Employee Net-Salary Ends*/
		        
		        } else if(method.equalsIgnoreCase("1")) {
		        	
		        	String sql3 = "";
		        	/*Taking Loan & Common Account Net-Salary*/
		        	sql3 = "select d.empid,round(d.loan,0) loan,round(d.netsalary,0) netsalary,m.acno,h.atype,h.account,h.description accountname,h.curid,h.rate,c.type currencytype,'0' costtype,'0' costcode from hr_payroll p left join hr_payrolld d "
		        			 + "on p.doc_no=d.rdocno left join hr_empm m on d.empid=m.doc_no left join hr_timesheet t on (t.empid=d.empid and t.year=YEAR('"+sqlUpToDate+"') and t.month=MONTH('"+sqlUpToDate+"')) left join my_head h on m.acno=h.doc_no left join my_curr c on h.curid=c.doc_no where p.status=3 and d.status=3 "
		        			 + "and d.posted=0 and t.payroll_processed=1 and t.payroll_confirmed=1 and MONTH(p.date)=MONTH('"+sqlUpToDate+"') and YEAR(p.date)=YEAR('"+sqlUpToDate+"') and d.empid in ("+employees+") ";
		        	System.out.println("sql3===== "+sql3);	
				    ResultSet resultSet3 = stmtBPO.executeQuery(sql3);
				    Double netSalary=0.00;
				    while(resultSet3.next()){
					    ArrayList<String> temp5=new ArrayList<String>();
						
						if(resultSet3.getDouble("loan")>0.00) {
							temp5.add(resultSet3.getString("acno"));temp5.add(resultSet3.getString("atype"));temp5.add(resultSet3.getString("account"));temp5.add(resultSet3.getString("accountname"));
							temp5.add("0.00");temp5.add(resultSet3.getString("loan"));temp5.add(String.valueOf(resultSet3.getDouble("loan")*resultSet3.getDouble("rate")));temp5.add("PAYROLL POSTING OF LOAN ON "+postDate);
							temp5.add(resultSet3.getString("curid"));temp5.add(resultSet3.getString("currencytype"));temp5.add(resultSet3.getString("rate"));temp5.add("-1");temp5.add(resultSet3.getString("costtype"));
							temp5.add(resultSet3.getString("costcode"));
							roundOffValues1+=resultSet3.getDouble("loan");
							employeeAccountsJVProcessed.add(temp5);
						}
						netSalary = netSalary + resultSet3.getDouble("netsalary");						
				    }
		        	
		        	String sql4 = "";
				    
				    sql4 = "select m.codeno,m.acno,h.account,h.description,h.atype,h.curid,round(cb.rate,2) rate,c.type currencytype,m.costtype,m.costcode from my_account m left join my_head h on m.acno=h.doc_no "
				    	 + "left join my_curr c on h.curid=c.doc_no left join my_curbook cb on h.curid=cb.curid inner join ( select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr where "
				    	 + "coalesce(toDate,curdate())>='"+sqlUpToDate+"' and frmDate<='"+sqlUpToDate+"' group by cr.curid) as bo on (cb.doc_no=bo.doc_no and cb.curid=bo.curid) where m.codeno='HRMonthlyPayrollNetCommonAccount'";
				    System.out.println("sql4===== "+sql4);
				    ResultSet resultSet4 = stmtBPO.executeQuery(sql4);

				    while(resultSet4.next()){
					    ArrayList<String> temp6=new ArrayList<String>();
					    
					    temp6.add(resultSet4.getString("acno"));temp6.add(resultSet4.getString("atype"));temp6.add(resultSet4.getString("account"));temp6.add(resultSet4.getString("description"));
						temp6.add("0.00");temp6.add(String.valueOf(netSalary));temp6.add(String.valueOf(netSalary*resultSet4.getDouble("rate")));temp6.add("PAYROLL POSTING OF NET-SALARY ON "+postDate);
						temp6.add(resultSet4.getString("curid"));temp6.add(resultSet4.getString("currencytype"));temp6.add(resultSet4.getString("rate"));temp6.add("-1");temp6.add(resultSet4.getString("costtype"));
						temp6.add(resultSet4.getString("costcode"));
						roundOffValues1+=netSalary;
						employeeAccountsJVProcessed.add(temp6);
						
				    }
				    /*Taking Loan & Common Account Net-Salary Ends*/ 
		        }
		        
		        roundOffValuesDiff=roundOffValues-roundOffValues1;
		        
		        /* Inserting a Rounding Value Array */
		        if(roundOffValuesDiff>0) {
			        String sqlRoundOff = "select m.codeno,m.acno,h.account,h.description,h.atype,h.curid,round(cb.rate,2) rate,c.type currencytype,m.costtype,m.costcode from my_account m left join my_head h on m.acno=h.doc_no "
					    	 + "left join my_curr c on h.curid=c.doc_no left join my_curbook cb on h.curid=cb.curid inner join ( select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr where "
			        		 + "coalesce(toDate,curdate())>='"+sqlUpToDate+"' and frmDate<='"+sqlUpToDate+"' group by cr.curid) as bo on (cb.doc_no=bo.doc_no and cb.curid=bo.curid) where m.codeno='HRSALARYROUNDACCOUNT'";
			        System.out.println("sqlRoundOff===== "+sqlRoundOff);
			        ResultSet resultSetRoundOff = stmtBPO.executeQuery(sqlRoundOff);
	
				    while(resultSetRoundOff.next()){
				    	ArrayList<String> temp7=new ArrayList<String>();
					    
					    temp7.add(resultSetRoundOff.getString("acno"));temp7.add(resultSetRoundOff.getString("atype"));temp7.add(resultSetRoundOff.getString("account"));temp7.add(resultSetRoundOff.getString("description"));
						temp7.add("0.00");temp7.add(String.valueOf((roundOffValuesDiff<0?roundOffValuesDiff*-1:roundOffValuesDiff)));
						temp7.add(String.valueOf(((roundOffValuesDiff<0?roundOffValuesDiff*-1:roundOffValuesDiff))*resultSetRoundOff.getDouble("rate")));temp7.add("PAYROLL POSTING OF SALARY ROUND-OFF ON "+postDate);
						temp7.add(resultSetRoundOff.getString("curid"));temp7.add(resultSetRoundOff.getString("currencytype"));temp7.add(resultSetRoundOff.getString("rate"));temp7.add("-1");temp7.add(resultSetRoundOff.getString("costtype"));
						temp7.add(resultSetRoundOff.getString("costcode"));
						
						employeeAccountsJVProcessed.add(temp7);
				    }
		        } else if(roundOffValuesDiff<0) {
		        	String sqlRoundOff = "select m.codeno,m.acno,h.account,h.description,h.atype,h.curid,round(cb.rate,2) rate,c.type currencytype,m.costtype,m.costcode from my_account m left join my_head h on m.acno=h.doc_no "
					    	 + "left join my_curr c on h.curid=c.doc_no left join my_curbook cb on h.curid=cb.curid inner join ( select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr where "
			        		 + "coalesce(toDate,curdate())>='"+sqlUpToDate+"' and frmDate<='"+sqlUpToDate+"' group by cr.curid) as bo on (cb.doc_no=bo.doc_no and cb.curid=bo.curid) where m.codeno='HRSALARYROUNDACCOUNT'";

			        ResultSet resultSetRoundOff = stmtBPO.executeQuery(sqlRoundOff);
	
				    while(resultSetRoundOff.next()){
				    	ArrayList<String> temp7=new ArrayList<String>();
					    
					    temp7.add(resultSetRoundOff.getString("acno"));temp7.add(resultSetRoundOff.getString("atype"));temp7.add(resultSetRoundOff.getString("account"));temp7.add(resultSetRoundOff.getString("description"));
						temp7.add(String.valueOf((roundOffValuesDiff<0?roundOffValuesDiff*-1:roundOffValuesDiff)));temp7.add("0.00");
						temp7.add(String.valueOf(((roundOffValuesDiff<0?roundOffValuesDiff*-1:roundOffValuesDiff))*resultSetRoundOff.getDouble("rate")));temp7.add("PAYROLL POSTING OF SALARY ROUND-OFF ON "+postDate);
						temp7.add(resultSetRoundOff.getString("curid"));temp7.add(resultSetRoundOff.getString("currencytype"));temp7.add(resultSetRoundOff.getString("rate"));temp7.add("-1");temp7.add(resultSetRoundOff.getString("costtype"));
						temp7.add(resultSetRoundOff.getString("costcode"));
						
						employeeAccountsJVProcessed.add(temp7);
				    }
		        }
		        /* Inserting a Rounding Value Array Ends*/
		        
				analysisrowarray.addAll(employeeAccountsJVProcessed);
				RESULTDATA=convertRowAnalysisArrayToJSON(analysisrowarray);
				
		       stmtBPO.close();
		       conn.close();
		       }
	           stmtBPO.close();
			  conn.close();   
	     } catch(Exception e) {
		      e.printStackTrace();
		      conn.close();
	     } finally {
				conn.close();
			}
	       return RESULTDATA;
	  }
	
	public JSONArray convertRowAnalysisArrayToJSON(ArrayList rowsAnalysisList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		
		for (int i = 0; i < rowsAnalysisList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			String rows=rowsAnalysisList.get(i).toString();
			rows=rows.replace("[", "").replace("]", "").trim();
			String[] rowsValue=rows.split(",");
			
			obj.put("docno",rowsValue[0]);
			obj.put("type",rowsValue[1]);
			obj.put("account",rowsValue[2]);
			obj.put("accountname",rowsValue[3]);
			obj.put("debit",rowsValue[4]);
			obj.put("credit",rowsValue[5]);
			obj.put("baseamount",rowsValue[6]);
			obj.put("description",rowsValue[7]);
			obj.put("currencyid",rowsValue[8]);
			obj.put("currencytype",rowsValue[9]);
			obj.put("rate",rowsValue[10]);
			obj.put("id",rowsValue[11]);
			obj.put("costtype",rowsValue[12]);
			obj.put("costcode",rowsValue[13]);
			
			jsonArray.add(obj);

		}
		return jsonArray;
		}
}
