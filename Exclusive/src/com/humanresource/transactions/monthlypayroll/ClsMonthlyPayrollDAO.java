package com.humanresource.transactions.monthlypayroll;

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

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.common.ClsCommonHR;
import com.connection.ClsConnection;

public class ClsMonthlyPayrollDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	ClsMonthlyPayrollBean monthlyPayrollBean = new ClsMonthlyPayrollBean();
		
	public int insert(String formdetailcode, Date monthlyPayrollDate, ArrayList<String> monthlypayrollarray, HttpSession session, HttpServletRequest request, String mode) throws SQLException {
		
		Connection conn = null;
//		System.out.println("in...................INSERT");
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			String employeeId="";

			for(int i=0;i<monthlypayrollarray.size();i++){
				String temp=monthlypayrollarray.get(i).split("::")[0];
				if(i==0){
					employeeId=temp;
				}
				else{
					employeeId=employeeId+","+temp;
				}
			}
			
			CallableStatement stmtHMSP = conn.prepareCall("{CALL HR_payrollmDML(?,?,?,?,?,?,?,?,?)}");
			
			stmtHMSP.registerOutParameter(8, java.sql.Types.INTEGER);
			
			stmtHMSP.setDate(1,monthlyPayrollDate);
			stmtHMSP.setString(2,employeeId);
			stmtHMSP.setString(3,"PAYROLL PROCESSED ON "+monthlyPayrollDate);
			stmtHMSP.setString(4,formdetailcode);
			stmtHMSP.setString(5,company);
			stmtHMSP.setString(6,branch);
			stmtHMSP.setString(7,userid);
			stmtHMSP.setString(9,mode);
			int datas=stmtHMSP.executeUpdate();
			if(datas<=0){
				stmtHMSP.close();
				conn.close();
				return 0;
			}
			int docno=stmtHMSP.getInt("docNo");
			monthlyPayrollBean.setTxtmonthlypayrolldocno(docno);
			if (docno > 0) {
				
				/*Insertion to hr_payrolld*/
				int insertData=insertion(conn, docno, monthlyPayrollDate, monthlypayrollarray, session, mode);
				if(insertData<=0){
					stmtHMSP.close();
					conn.close();
					return 0;
				}
				/*Insertion to hr_payrolld Ends*/
				
				conn.commit();
				stmtHMSP.close();
				conn.close();
				return docno;
		      }
				
			stmtHMSP.close();
			conn.close();
	 } catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 } finally{
		 conn.close();
	 }
		return 0;
	}
	
	public boolean edit(int txtmonthlypayrolldocno, String formdetailcode, Date monthlyPayrollDate, ArrayList<String> monthlypayrollarray, HttpSession session, HttpServletRequest request, String mode) throws SQLException {
//		System.out.println("=========in edit dao==========");
		Connection conn = null;
	 	
		 try{
			    conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
			
				Statement stmtHMSP = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String company=session.getAttribute("COMPANYID").toString().trim();
				String employeeId="";

				for(int i=0;i<monthlypayrollarray.size();i++){
					String temp=monthlypayrollarray.get(i).split("::")[0];
					if(i==0){
						employeeId=temp;
					}
					else{
						employeeId=employeeId+","+temp;
					}
				}
				
				/*Updating hr_payroll*/
               String sql=("update hr_payroll set date='"+monthlyPayrollDate+"', empId='"+employeeId+"', remarks='PAYROLL PROCESSED ON "+monthlyPayrollDate+"', brhId='"+branch+"', cmpId='"+company+"' where doc_no="+txtmonthlypayrolldocno+"");
               int data = stmtHMSP.executeUpdate(sql);
               	if(data<=0){
					conn.close();
					return false;
				}
				/*Updating hr_payroll Ends*/
				
				/*Inserting into datalog*/
				String sql1=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtmonthlypayrolldocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
				stmtHMSP.executeUpdate(sql1);
				/*Inserting into datalog Ends*/
			    
			   /* String sql2=("DELETE FROM hr_payrolld WHERE rdocno="+txtmonthlypayrolldocno);
			    stmtHMSP.executeUpdate(sql2);*/
			    
			    int docno=txtmonthlypayrolldocno;
			    monthlyPayrollBean.setTxtmonthlypayrolldocno(docno);
				if (docno > 0) {
			     	
					/*Insertion to hr_payrolld*/
					int insertData=insertion(conn, docno, monthlyPayrollDate, monthlypayrollarray, session, mode);
					if(insertData<=0){
						stmtHMSP.close();
						conn.close();
						return false;
					}
					/*Insertion to hr_payrolld Ends*/
						
						conn.commit();
						stmtHMSP.close();
						conn.close();
						return true;
				}
				stmtHMSP.close();
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
	
	public boolean confirmPayroll(int txtmonthlypayrolldocno, String formdetailcode, Date monthlyPayrollDate, ArrayList<String> monthlypayrollarray, HttpSession session, HttpServletRequest request, String mode)  throws SQLException {
		Connection conn = null;
	 	
		 try{
			    conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtHMSP = conn.createStatement();
				
			    String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
//				System.out.println("monthlypayrollarray ="+monthlypayrollarray);
				
				for(int i=0;i< monthlypayrollarray.size();i++){
					
					String[] monthlypayroll=monthlypayrollarray.get(i).split("::");
					if(!monthlypayroll[0].equalsIgnoreCase("undefined") && !monthlypayroll[0].equalsIgnoreCase("NaN")){
				    
//						System.out.println("empid ="+monthlypayroll[0]);
						
						/*Updating hr_tmesheet*/
						String sql=("update hr_timesheet set payroll_processed=1, payroll_confirmed=1 where payroll_confirmed=0 and month=MONTH('"+monthlyPayrollDate+"') and year=YEAR('"+monthlyPayrollDate+"') and empid='"+(monthlypayroll[0].trim().equalsIgnoreCase("undefined") || monthlypayroll[0].trim().equalsIgnoreCase("NaN") || monthlypayroll[0].trim().equalsIgnoreCase("") ||monthlypayroll[0].trim().isEmpty()?0:monthlypayroll[0].trim()).toString()+"'");
//						System.out.println("sql ="+sql);
						int data = stmtHMSP.executeUpdate(sql);
//						System.out.println("data ="+data);
						if(data<=0){
							stmtHMSP.close();
							conn.close();
							return false;
						}
						/*Updating hr_tmesheet Ends*/
					}
				 }
				
				/*Inserting into datalog*/
				String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtmonthlypayrolldocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
//				System.out.println("sqls ="+sqls);
				int data1 = stmtHMSP.executeUpdate(sqls);
				/*Inserting into datalog Ends*/
				
				conn.commit();
				stmtHMSP.close();
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
	
	/*public boolean delete(int txtmonthlypayrolldocno, String formdetailcode, HttpSession session, String mode) throws SQLException {
		
		Connection conn = null; 
		
		try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtHMSP = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				 Status change in hr_payroll
				 String sql=("update hr_payroll set STATUS=7 where doc_no="+txtmonthlypayrolldocno+"");
				 stmtHMSP.executeUpdate(sql);
				Status change in hr_payroll Ends
				 
				 Status change in hr_payrolld
				 String sql1=("update hr_payrolld set STATUS=7 where rdocno="+txtmonthlypayrolldocno+"");
				 stmtHMSP.executeUpdate(sql1);
				Status change in hr_payrolld Ends
				 
				 Inserting into datalog
				 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtmonthlypayrolldocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','D')");
				 stmtHMSP.executeUpdate(sqls);
				 Inserting into datalog Ends
				 
				 int docno=txtmonthlypayrolldocno;
				 monthlyPayrollBean.setTxtmonthlypayrolldocno(docno);
				 
				if (docno > 0) {
					conn.commit();
					stmtHMSP.close();
				    conn.close();
					return true;
				}	
				stmtHMSP.close();
			    conn.close();
		 } catch(Exception e){	
			 	e.printStackTrace();
			 	conn.close();
			 	return false;
		 } finally{
			 conn.close();
		 }
		return false;
	}*/
	
	public JSONArray monthlyPayrollGridLoading(String date,String category,String empId,String docno,String mode) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
        
		try {
			System.out.println("inside grid load   =====   "+mode);
				conn = ClsConnection.getMyConnection();
				java.sql.Date sqlDate=null;

				date.trim();
		        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))) {
		        	sqlDate = ClsCommon.changeStringtoSqlDate(date);
		        }
		        
		        if(mode.equalsIgnoreCase("A")){
		        	
		        	Statement stmtHMSP = conn.createStatement();
					Statement stmtHMSP1 = conn.createStatement();
					Statement stmtHMSP2 = conn.createStatement();
					Statement stmtHMSP3 = conn.createStatement();
					Statement stmtHMSP4 = conn.createStatement();
					Statement stmtHMSP5 = conn.createStatement();
					
					int totleaves=0,totallowance=0;
					String dailyRateFormula="",xsql="";
					ClsCommonHR hrCalc = new ClsCommonHR();
					ArrayList<String> additionsDeductionsAmount = new ArrayList<String>();
					
					String sql="select count(doc_no) totleaves from hr_timesheetset where reftype='L'";
					ResultSet resultSet = stmtHMSP.executeQuery(sql);
					while(resultSet.next()){
						totleaves=resultSet.getInt("totleaves");
					}
					
					String sql1 = "select count(doc_no) totallowances from hr_setallowance where status=3 and doc_no>0";
					ResultSet resultSet1 = stmtHMSP1.executeQuery(sql1);
					
					while(resultSet1.next()) {
						totallowance=resultSet1.getInt("totallowances");
				  	}
					
					if(!(category.equalsIgnoreCase("0")) && !(category.equalsIgnoreCase(""))){
			            xsql=xsql+" and m.pay_catid = '"+category+"'";
			        }
					
					if(!(empId.equalsIgnoreCase("0")) && !(empId.equalsIgnoreCase(""))){
						
			            xsql=xsql+" and m.doc_no = '"+empId+"'";
			            
			        }
					
					String sql2="select m.doc_no employeedocno,m.codeno employeeid,m.name employeename,m.salary_paid dates,DATEDIFF('"+sqlDate+"',m.salary_paid) totaldays,if(mod(round(sum(t.tot_leave1),1),1)=0,"
							+ "round(sum(t.tot_leave1),1),round(sum(t.tot_leave1),1)) leave1,if(mod(round(sum(t.tot_leave2),1),1)=0,round(sum(t.tot_leave2),1),round(sum(t.tot_leave2),1)) leave2,"
							+ "if(mod(round(sum(t.tot_leave3),1),1)=0,round(sum(t.tot_leave3),1),round(sum(t.tot_leave3),1)) leave3,if(mod(round(sum(t.tot_leave4),1),1)=0,round(sum(t.tot_leave4),1),"
							+ "round(sum(t.tot_leave4),1)) leave4,if(mod(round(sum(t.tot_leave5),1),1)=0,round(sum(t.tot_leave5),1),round(sum(t.tot_leave5),1)) leave5,if(mod(round(sum(t.tot_leave6),1),1)=0,"
							+ "round(sum(t.tot_leave6),1),round(sum(t.tot_leave6),1)) leave6,CONVERT(if(round(t.tot_ot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(t.tot_ot*60))=8,SUBSTRING(SEC_TO_TIME(t.tot_ot*60),1,5),SUBSTRING(SEC_TO_TIME(t.tot_ot*60),1,6))),CHAR(100)) ot,"
							+ "CONVERT(if(round(t.tot_hot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(t.tot_hot*60))=8,SUBSTRING(SEC_TO_TIME(t.tot_hot*60),1,5),SUBSTRING(SEC_TO_TIME(t.tot_hot*60),1,6))),CHAR(100)) hot,"
							+ "t.payroll_processed payrollprocessed from hr_timesheet t left join hr_empm m on t.empid=m.doc_no where m.active=1 and m.status=3"+xsql+" "
							+ "and t.year=YEAR('"+sqlDate+"') and t.month=MONTH('"+sqlDate+"') group by t.empid";
					
					System.out.println("====== "+sql2);
					
					
					ResultSet resultSet2 = stmtHMSP2.executeQuery(sql2);
	                
					ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<ArrayList<String>>();
					
					String oldempid="",newempid="",empCategoryID="0",daysToPay="0";
					
					while(resultSet2.next()){
						ArrayList<String> temp=new ArrayList<String>();
	
						newempid=resultSet2.getString("employeedocno");
						
						if(oldempid!=newempid){
							temp.add(newempid);
							temp.add(resultSet2.getString("employeeid"));
							temp.add(resultSet2.getString("employeename"));
							temp.add(resultSet2.getString("dates"));
							daysToPay=resultSet2.getString("totaldays");
							temp.add(daysToPay);
							temp.add(resultSet2.getString("ot"));
							temp.add(resultSet2.getString("hot"));
							temp.add(resultSet2.getString("payrollprocessed"));
							
							for (int l = 1; l <= totleaves; l++) {
								temp.add(resultSet2.getString("leave"+l+""));
	 						 }
	
							String sql4 = "select pay_catid from hr_empm where doc_no="+newempid+"";
							ResultSet resultSet4 = stmtHMSP4.executeQuery(sql4);		
							
							while(resultSet4.next()){
								empCategoryID=resultSet4.getString("pay_catid");
							}
							
							String sql5 = "select dailyRate from hr_paycode where catid="+empCategoryID+" and doc_no=(select max(doc_no) from hr_paycode where catid="+empCategoryID+" and revdate<='"+sqlDate+"')";
							ResultSet resultSet5 = stmtHMSP4.executeQuery(sql5);		
							
							while(resultSet5.next()){
								dailyRateFormula=resultSet5.getString("dailyRate");
							}
							
							String sql3="select * from ( "  
									+ "select t.empid,id.rdocno,id.awlid,id.refdtype,id.addition,id.deduction,id.statutorydeduction,id.revadd,id.revded,id.revstatded from "
									+ "hr_timesheet t left join hr_incrm im on t.empid=im.empid left join hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) "
									+ "from hr_incrm where t.empid=empid) and id.refdtype!='STD' and t.empid="+newempid+" union all "
									+ "select 0 empid,0 rdocno,hrs.doc_no awlid,'ALC' refdtype,0 addition,0 deduction,0 statutorydeduction,0 revadd,0 revded,0 revstatded from "
									+ "hr_setallowance hrs where hrs.status=3 and hrs.doc_no not in (select id.awlid from hr_timesheet t left join hr_incrm im on t.empid=im.empid left join "
									+ "hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) from hr_incrm where t.empid=empid) and id.refdtype!='STD' and "
									+ "t.empid="+newempid+")) as a where a.awlid>=0 group by empid,awlid,refdtype order by refdtype,awlid";
					
							ResultSet resultSet3 = stmtHMSP3.executeQuery(sql3);		
							
							double totalsalary=0.00,otAmount=0.00,hotAmount=0.00,overTimeAmount=0.00,grossSalaryAmount=0.00,additionAmount=0.00,deductionAmount=0.00,loanAmount=0.00,netSalaryAmount=0.00;
							while(resultSet3.next()){
								double basicsalary=0.00,basicSalaryAmount=0.00,allowance=0.00,allowanceAmount=0.00,statutorydeduction=0.00;
								
								if(resultSet3.getString("awlid").equalsIgnoreCase("0") && resultSet3.getString("refdtype").equalsIgnoreCase("0")){
									basicsalary=basicsalary+resultSet3.getDouble("revadd");
									basicsalary=basicsalary-resultSet3.getDouble("revded");
									
									/*BASIC Calculation */
									//basicSalaryAmount= Double.parseDouble(hrCalc.getHRBASIC(conn,newempid,empCategoryID,sqlDate,basicsalary,daysToPay));
									//basicsalary=basicSalaryAmount;
									/*BASIC Calculation Ends */
									
									temp.add(String.valueOf(basicsalary));
									totalsalary=totalsalary+basicsalary;
									
								}
								
								if(resultSet3.getString("refdtype").equalsIgnoreCase("ALC")){
									allowance=allowance+resultSet3.getDouble("revadd");
									allowance=allowance-resultSet3.getDouble("revded");
									
									if(dailyRateFormula.contains("GROSS")){
										
										/*Allowance Calculation */
										//allowanceAmount= Double.parseDouble(hrCalc.getHRALLOWANCES(conn,newempid,empCategoryID,sqlDate,allowance,daysToPay));
										//allowance=allowanceAmount;
										/*Allowance Calculation Ends */
										
										totalsalary=totalsalary+allowance;
									} else{
										totalsalary=totalsalary+allowance;
									}
									
									temp.add(String.valueOf(allowance));
								}
								
								if(resultSet3.getString("refdtype").equalsIgnoreCase("STD")){
									statutorydeduction=statutorydeduction-resultSet3.getDouble("revstatded");
									totalsalary=totalsalary-statutorydeduction;
								}
							}
							
							/*Total Salary Calculation */
							temp.add(String.valueOf(totalsalary));
							/*Total Salary Calculation Ends */
							
							String sql6="select * from ( "  
									+ "select t.empid,id.rdocno,id.awlid,id.refdtype,id.addition,id.deduction,id.statutorydeduction,id.revadd,id.revded,id.revstatded from "
									+ "hr_timesheet t left join hr_incrm im on t.empid=im.empid left join hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) "
									+ "from hr_incrm where t.empid=empid) and id.refdtype!='STD' and t.empid="+newempid+" union all "
									+ "select 0 empid,0 rdocno,hrs.doc_no awlid,'ALC' refdtype,0 addition,0 deduction,0 statutorydeduction,0 revadd,0 revded,0 revstatded from "
									+ "hr_setallowance hrs where hrs.status=3 and hrs.doc_no not in (select id.awlid from hr_timesheet t left join hr_incrm im on t.empid=im.empid left join "
									+ "hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) from hr_incrm where t.empid=empid) and id.refdtype!='STD' and "
									+ "t.empid="+newempid+")) as a where a.awlid>=0 group by empid,awlid,refdtype order by refdtype,awlid";
//							System.out.println("sql6 ==== "+sql6);
							ResultSet resultSet6 = stmtHMSP3.executeQuery(sql6);		
							
							double earnedtotalsalary=0.00;
							while(resultSet6.next()){
								double earnedbasicsalary=0.00,earnedbasicSalaryAmount=0.00,earnedallowance=0.00,earnedallowanceAmount=0.00,earnedstatutorydeduction=0.00;
								
								if(resultSet6.getString("awlid").equalsIgnoreCase("0") && resultSet6.getString("refdtype").equalsIgnoreCase("0")){
									earnedbasicsalary=earnedbasicsalary+resultSet6.getDouble("revadd");
									earnedbasicsalary=earnedbasicsalary-resultSet6.getDouble("revded");
									
									/*Earned BASIC Calculation */
									earnedbasicSalaryAmount= Double.parseDouble(hrCalc.getHREARNEDBASIC(conn,newempid,empCategoryID,sqlDate,earnedbasicsalary,daysToPay));
									earnedbasicsalary=earnedbasicSalaryAmount;
									/*Earned BASIC Calculation Ends */
									
									temp.add(String.valueOf(earnedbasicsalary));
									earnedtotalsalary=earnedtotalsalary+earnedbasicsalary;
									
								}
								
								if(resultSet6.getString("refdtype").equalsIgnoreCase("ALC")){
									earnedallowance=earnedallowance+resultSet6.getDouble("revadd");
									earnedallowance=earnedallowance-resultSet6.getDouble("revded");
									
									if(dailyRateFormula.contains("GROSS")){
										
										/*Earned Allowance Calculation */
										earnedallowanceAmount= Double.parseDouble(hrCalc.getHREARNEDALLOWANCES(conn,newempid,empCategoryID,sqlDate,earnedallowance,daysToPay,resultSet6.getString("awlid")));
										earnedallowance=earnedallowanceAmount;
										/*Earned Allowance Calculation Ends */
										
										earnedtotalsalary = earnedtotalsalary+earnedallowance;
									} else{
										earnedtotalsalary = earnedtotalsalary+earnedallowance;
									}
									
									temp.add(String.valueOf(earnedallowance));
								}
								
								if(resultSet6.getString("refdtype").equalsIgnoreCase("STD")){
									earnedstatutorydeduction=earnedstatutorydeduction-resultSet6.getDouble("revstatded");
									earnedtotalsalary=earnedtotalsalary-earnedstatutorydeduction;
								}
							}
							
							/*Earned Total Salary Calculation */
							temp.add(String.valueOf(Math.round(earnedtotalsalary)));
							/*Earned Total Salary Calculation Ends */
							
							/*OT Calculation */
							otAmount= Double.parseDouble(hrCalc.getHROT(conn,newempid,empCategoryID,sqlDate));
							/*OT Calculation Ends */
	
							/*HOT Calculation */
							hotAmount= Double.parseDouble(hrCalc.getHRHOT(conn,newempid,empCategoryID,sqlDate));
							/*HOT Calculation Ends */
							
							/*Over Time Calculation */
							overTimeAmount=otAmount+hotAmount;
							temp.add(String.valueOf(overTimeAmount));
							/*Holiday Over Time Calculation Ends */
							
							/*Leave Deductions Calculation */
							//leaveDeductionsAmount=Double.parseDouble(hrCalc.getHRLeaveDeductions(conn,newempid,empCategoryID,sqlDate));
							//temp.add(String.valueOf(leaveDeductionsAmount));
							/*Leave Deductions Calculation Ends */
	
							/*Gross Salary Calculation */
							grossSalaryAmount=Math.round(earnedtotalsalary+overTimeAmount);
							temp.add(String.valueOf(grossSalaryAmount));
							/*Gross Salary Calculation Ends */
							
							/*Additions and Deductions Calculation */
							additionsDeductionsAmount=hrCalc.getHRAdditionsDeductions(conn,newempid,sqlDate);
							if(additionsDeductionsAmount.size()>0){
								String[] additionsDeductions=additionsDeductionsAmount.get(0).split("::");
								additionAmount = ((additionsDeductions[0].isEmpty()?0.0:Double.parseDouble(additionsDeductions[0])));
								deductionAmount = ((additionsDeductions[1].isEmpty()?0.0:Double.parseDouble(additionsDeductions[1])));
								temp.add(String.valueOf(additionAmount));
								temp.add(String.valueOf(deductionAmount));
							} 
							/*Additions and Deductions Calculation Ends */
							
							/*Loan Amount Calculation*/
							loanAmount= Double.parseDouble(hrCalc.getHRLoanAmount(conn,newempid,sqlDate));
							temp.add(String.valueOf(loanAmount));
							/*Loan Amount Calculation Ends*/
							
							/*Net Salary Amount Calculation */
							netSalaryAmount=(((grossSalaryAmount+additionAmount)-(deductionAmount))-(loanAmount));
							temp.add(String.valueOf(netSalaryAmount));
							/*Net Salary Amount Calculation Ends*/
							
							temp.add("Payroll Processed on "+date+"");
						
							oldempid=newempid;
						}
						
						analysisrowarray.add(temp);
						
					}
			
					ArrayList<String> employeeIDTerminatedToBeProcessed = new ArrayList<String>();
					String sql7="";
					
					if(!(category.equalsIgnoreCase("0")) && !(category.equalsIgnoreCase(""))){
						sql7=sql7+" and m.pay_catid = '"+category+"'";
			        }
					
					sql7 = "select t.empid from hr_timesheet t left join hr_empm m on (t.empid=m.doc_no and t.year=YEAR('"+sqlDate+"') and t.month=MONTH('"+sqlDate+"')) where m.status=7 and m.active=0 and t.payroll_processed=0 and t.payroll_confirmed=0 and t.month=MONTH('"+sqlDate+"') and t.year=YEAR('"+sqlDate+"') and MONTH(m.terminated_date)=MONTH('"+sqlDate+"') and YEAR(m.terminated_date)=YEAR('"+sqlDate+"')"+sql7+"";
					System.out.println("===== "+sql7);
					ResultSet resultSet7 = stmtHMSP3.executeQuery(sql7);
					
					while(resultSet7.next()){
						employeeIDTerminatedToBeProcessed.add(resultSet7.getString("empid"));
					}
					
					/*Terminated Salary processing*/
					if(employeeIDTerminatedToBeProcessed.size()>0){
						
						Statement stmtHMSP9 = conn.createStatement();
						Statement stmtHMSP10 = conn.createStatement();
						Statement stmtHMSP11 = conn.createStatement();
						Statement stmtHMSP12 = conn.createStatement();
						Statement stmtHMSP13 = conn.createStatement();
						
						
						String terminatedDailyRateFormula="",xsql1="";
						ArrayList<String> terminatedAdditionsDeductionsAmount = new ArrayList<String>();
						
						for(int j=0;j< employeeIDTerminatedToBeProcessed.size();j++){
							
							if(!(category.equalsIgnoreCase("0")) && !(category.equalsIgnoreCase(""))){
								xsql1=xsql1+" and m.pay_catid = '"+category+"'";
					        }
							if(!(empId.equalsIgnoreCase("0")) && !(empId.equalsIgnoreCase(""))){
					            xsql1=xsql1+" and m.doc_no = '"+empId+"'";
					        }
							String sql9="select m.doc_no employeedocno,m.codeno employeeid,m.name employeename,m.salary_paid dates,DATEDIFF(m.terminated_date,m.salary_paid) totaldays,if(mod(round(sum(t.tot_leave1),1),1)=0,"
									+ "round(sum(t.tot_leave1),1),round(sum(t.tot_leave1),1)) leave1,if(mod(round(sum(t.tot_leave2),1),1)=0,round(sum(t.tot_leave2),1),round(sum(t.tot_leave2),1)) leave2,"
									+ "if(mod(round(sum(t.tot_leave3),1),1)=0,round(sum(t.tot_leave3),1),round(sum(t.tot_leave3),1)) leave3,if(mod(round(sum(t.tot_leave4),1),1)=0,round(sum(t.tot_leave4),1),"
									+ "round(sum(t.tot_leave4),1)) leave4,if(mod(round(sum(t.tot_leave5),1),1)=0,round(sum(t.tot_leave5),1),round(sum(t.tot_leave5),1)) leave5,if(mod(round(sum(t.tot_leave6),1),1)=0,"
									+ "round(sum(t.tot_leave6),1),round(sum(t.tot_leave6),1)) leave6,CONVERT(if(round(t.tot_ot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(t.tot_ot*60))=8,SUBSTRING(SEC_TO_TIME(t.tot_ot*60),1,5),SUBSTRING(SEC_TO_TIME(t.tot_ot*60),1,6))),CHAR(100)) ot," 
									+ "CONVERT(if(round(t.tot_hot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(t.tot_hot*60))=8,SUBSTRING(SEC_TO_TIME(t.tot_hot*60),1,5),SUBSTRING(SEC_TO_TIME(t.tot_hot*60),1,6))),CHAR(100)) hot,"
									+ "t.payroll_processed payrollprocessed from hr_timesheet t left join hr_empm m on t.empid=m.doc_no where m.active=0 and m.status=7"+xsql1+" "
									+ "and t.year=YEAR('"+sqlDate+"') and t.month=MONTH('"+sqlDate+"') and t.empid="+employeeIDTerminatedToBeProcessed.get(j).trim()+" group by t.empid";
							System.out.println("sql9  ===== "+sql9);
							ResultSet resultSet9 = stmtHMSP9.executeQuery(sql9);
							
							String terminatedoldempid="",terminatednewempid="",terminatedempCategoryID="0",terminateddaysToPay="0";
							
							while(resultSet9.next()){
								ArrayList<String> terminatedtemp=new ArrayList<String>();
			
								terminatednewempid=resultSet9.getString("employeedocno");
								
								if(terminatedoldempid!=terminatednewempid){
									
									terminatedtemp.add(terminatednewempid);
									terminatedtemp.add(resultSet9.getString("employeeid"));
									terminatedtemp.add(resultSet9.getString("employeename"));
									terminatedtemp.add(resultSet9.getString("dates"));
									terminateddaysToPay=resultSet9.getString("totaldays");
									terminatedtemp.add(terminateddaysToPay);
									terminatedtemp.add(resultSet9.getString("ot"));
									terminatedtemp.add(resultSet9.getString("hot"));
									terminatedtemp.add(resultSet9.getString("payrollprocessed"));
									
									for (int l = 1; l <= totleaves; l++) {
										terminatedtemp.add(resultSet9.getString("leave"+l+""));
			 						 }
			
									String sql10 = "select pay_catid from hr_empm where doc_no="+terminatednewempid+"";
									ResultSet resultSet10 = stmtHMSP10.executeQuery(sql10);		
									
									while(resultSet10.next()){
										terminatedempCategoryID=resultSet10.getString("pay_catid");
									}
									
									String sql11 = "select dailyRate from hr_paycode where catid="+terminatedempCategoryID+" and doc_no=(select max(doc_no) from hr_paycode where catid="+terminatedempCategoryID+" and revdate<='"+sqlDate+"')";
									ResultSet resultSet11 = stmtHMSP11.executeQuery(sql11);		
									
									while(resultSet11.next()){
										terminatedDailyRateFormula=resultSet11.getString("dailyRate");
									}
									
									String sql12="select * from ( "  
											+ "select t.empid,id.rdocno,id.awlid,id.refdtype,id.addition,id.deduction,id.statutorydeduction,id.revadd,id.revded,id.revstatded from "
											+ "hr_timesheet t left join hr_incrm im on t.empid=im.empid left join hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) "
											+ "from hr_incrm where t.empid=empid) and id.refdtype!='STD' and t.empid="+terminatednewempid+" union all "
											+ "select 0 empid,0 rdocno,hrs.doc_no awlid,'ALC' refdtype,0 addition,0 deduction,0 statutorydeduction,0 revadd,0 revded,0 revstatded from "
											+ "hr_setallowance hrs where hrs.status=3 and hrs.doc_no not in (select id.awlid from hr_timesheet t left join hr_incrm im on t.empid=im.empid left join "
											+ "hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) from hr_incrm where t.empid=empid) and id.refdtype!='STD' and "
											+ "t.empid="+terminatednewempid+")) as a where a.awlid>=0 group by empid,awlid,refdtype order by refdtype,awlid";
									
									ResultSet resultSet12 = stmtHMSP12.executeQuery(sql12);		
									
									double totalsalary=0.00,otAmount=0.00,hotAmount=0.00,overTimeAmount=0.00,leaveDeductionsAmount=0.00,grossSalaryAmount=0.00,additionAmount=0.00,deductionAmount=0.00,loanAmount=0.00,netSalaryAmount=0.00;
									while(resultSet12.next()){
										double basicsalary=0.00,basicSalaryAmount=0.00,allowance=0.00,allowanceAmount=0.00,statutorydeduction=0.00;
										
										if(resultSet12.getString("awlid").equalsIgnoreCase("0") && resultSet12.getString("refdtype").equalsIgnoreCase("0")){
											basicsalary=basicsalary+resultSet12.getDouble("revadd");
											basicsalary=basicsalary-resultSet12.getDouble("revded");
											
											/*BASIC Calculation */
											//basicSalaryAmount= Double.parseDouble(hrCalc.getHRBASIC(conn,newempid,empCategoryID,sqlDate,basicsalary,daysToPay));
											//basicsalary=basicSalaryAmount;
											/*BASIC Calculation Ends */
											
											terminatedtemp.add(String.valueOf(basicsalary));
											totalsalary=totalsalary+basicsalary;
										}
										
										if(resultSet12.getString("refdtype").equalsIgnoreCase("ALC")){
											allowance=allowance+resultSet12.getDouble("revadd");
											allowance=allowance-resultSet12.getDouble("revded");
											
											if(terminatedDailyRateFormula.contains("GROSS")){
												
												/*Allowance Calculation */
												//allowanceAmount= Double.parseDouble(hrCalc.getHRALLOWANCES(conn,newempid,empCategoryID,sqlDate,allowance,daysToPay));
												//allowance=allowanceAmount;
												/*Allowance Calculation Ends */
												
												totalsalary=totalsalary+allowance;
											} else{
												totalsalary=totalsalary+allowance;
											}
											
											terminatedtemp.add(String.valueOf(allowance));
										}
										
										if(resultSet12.getString("refdtype").equalsIgnoreCase("STD")){
											statutorydeduction=statutorydeduction-resultSet12.getDouble("revstatded");
											totalsalary=totalsalary-statutorydeduction;
										}
									}
									
									/*Total Salary Calculation */
									terminatedtemp.add(String.valueOf(totalsalary));
									/*Total Salary Calculation Ends */
									
									String sql13="select * from ( "  
											+ "select t.empid,id.rdocno,id.awlid,id.refdtype,id.addition,id.deduction,id.statutorydeduction,id.revadd,id.revded,id.revstatded from "
											+ "hr_timesheet t left join hr_incrm im on t.empid=im.empid left join hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) "
											+ "from hr_incrm where t.empid=empid) and id.refdtype!='STD' and t.empid="+terminatednewempid+" union all "
											+ "select 0 empid,0 rdocno,hrs.doc_no awlid,'ALC' refdtype,0 addition,0 deduction,0 statutorydeduction,0 revadd,0 revded,0 revstatded from "
											+ "hr_setallowance hrs where hrs.status=3 and hrs.doc_no not in (select id.awlid from hr_timesheet t left join hr_incrm im on t.empid=im.empid left join "
											+ "hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) from hr_incrm where t.empid=empid) and id.refdtype!='STD' and "
											+ "t.empid="+terminatednewempid+")) as a where a.awlid>=0 group by empid,awlid,refdtype order by refdtype,awlid";
//									System.out.println("earned basic============"+sql13);
									ResultSet resultSet13 = stmtHMSP13.executeQuery(sql13);		
									
									double earnedtotalsalary=0.00;
									while(resultSet13.next()){
										double earnedbasicsalary=0.00,earnedbasicSalaryAmount=0.00,earnedallowance=0.00,earnedallowanceAmount=0.00,earnedstatutorydeduction=0.00;
										
										if(resultSet13.getString("awlid").equalsIgnoreCase("0") && resultSet13.getString("refdtype").equalsIgnoreCase("0")){
//											System.out.println(earnedbasicsalary+"===="+resultSet13.getDouble("revadd")+"====="+resultSet13.getDouble("revded"));
											earnedbasicsalary=earnedbasicsalary+resultSet13.getDouble("revadd");
											earnedbasicsalary=earnedbasicsalary-resultSet13.getDouble("revded");
											
											/*Terminated Earned BASIC Calculation */
											earnedbasicSalaryAmount= Double.parseDouble(hrCalc.getHRTerminatedEARNEDBASIC(conn,terminatednewempid,terminatedempCategoryID,sqlDate,earnedbasicsalary,terminateddaysToPay));
											earnedbasicsalary=earnedbasicSalaryAmount;
											/*Terminated Earned BASIC Calculation Ends */
											
											terminatedtemp.add(String.valueOf(earnedbasicsalary));
											earnedtotalsalary=earnedtotalsalary+earnedbasicsalary;
										}
										
										if(resultSet13.getString("refdtype").equalsIgnoreCase("ALC")){
											earnedallowance=earnedallowance+resultSet13.getDouble("revadd");
											earnedallowance=earnedallowance-resultSet13.getDouble("revded");
											
											if(terminatedDailyRateFormula.contains("GROSS")){
												
												/*Terminated Earned Allowance Calculation */
												earnedallowanceAmount= Double.parseDouble(hrCalc.getHRTerminatedEARNEDALLOWANCES(conn,terminatednewempid,terminatedempCategoryID,sqlDate,earnedallowance,terminateddaysToPay,resultSet13.getString("awlid")));
												earnedallowance=earnedallowanceAmount;
												/*Terminated Earned Allowance Calculation Ends */
												
												earnedtotalsalary=earnedtotalsalary+earnedallowance;
											} else{
												earnedtotalsalary=earnedtotalsalary+earnedallowance;
											}
											
											terminatedtemp.add(String.valueOf(earnedallowance));
										}
										
										if(resultSet13.getString("refdtype").equalsIgnoreCase("STD")){
											earnedstatutorydeduction=earnedstatutorydeduction-resultSet13.getDouble("revstatded");
											earnedtotalsalary=earnedtotalsalary-earnedstatutorydeduction;
										}
									}
									
									/*Terminated Earned Total Salary Calculation */
									terminatedtemp.add(String.valueOf(Math.round(earnedtotalsalary)));
									/*Terminated Earned Total Salary Calculation Ends */
									
									/*OT Calculation */
									otAmount= Double.parseDouble(hrCalc.getHROT(conn,terminatednewempid,terminatedempCategoryID,sqlDate));
									/*OT Calculation Ends */
			
									/*HOT Calculation */
									hotAmount= Double.parseDouble(hrCalc.getHRHOT(conn,terminatednewempid,terminatedempCategoryID,sqlDate));
									/*HOT Calculation Ends */
									
									/*Over Time Calculation */
									overTimeAmount=otAmount+hotAmount;
									terminatedtemp.add(String.valueOf(overTimeAmount));
									/*Holiday Over Time Calculation Ends */
									
									/*Leave Deductions Calculation */
									//leaveDeductionsAmount=Double.parseDouble(hrCalc.getHRLeaveDeductions(conn,newempid,empCategoryID,sqlDate));
									//temp.add(String.valueOf(leaveDeductionsAmount));
									/*Leave Deductions Calculation Ends */
			
									/*Gross Salary Calculation */
									grossSalaryAmount=Math.round(earnedtotalsalary+overTimeAmount);
									terminatedtemp.add(String.valueOf(grossSalaryAmount));
									/*Gross Salary Calculation Ends */
									
									/*Additions and Deductions Calculation */
									terminatedAdditionsDeductionsAmount=hrCalc.getHRAdditionsDeductions(conn,terminatednewempid,sqlDate);
									if(terminatedAdditionsDeductionsAmount.size()>0){
										String[] additionsDeductions=terminatedAdditionsDeductionsAmount.get(0).split("::");
										additionAmount = ((additionsDeductions[0].isEmpty()?0.0:Double.parseDouble(additionsDeductions[0])));
										deductionAmount = ((additionsDeductions[1].isEmpty()?0.0:Double.parseDouble(additionsDeductions[1])));
										terminatedtemp.add(String.valueOf(additionAmount));
										terminatedtemp.add(String.valueOf(deductionAmount));
									} 
									/*Additions and Deductions Calculation Ends */
									
									/*Loan Amount Calculation*/
									loanAmount= Double.parseDouble(hrCalc.getHRLoanAmount(conn,terminatednewempid,sqlDate));
									terminatedtemp.add(String.valueOf(loanAmount));
									/*Loan Amount Calculation Ends*/
									
									/*Net Salary Amount Calculation */
									netSalaryAmount=(((grossSalaryAmount+additionAmount)-(deductionAmount))-(loanAmount));
									terminatedtemp.add(String.valueOf(netSalaryAmount));
									/*Net Salary Amount Calculation Ends*/
									
									terminatedtemp.add("Termianted Employee Payroll Processed on "+date+"");
									
									terminatedoldempid=terminatednewempid;
									
								}
								
								analysisrowarray.add(terminatedtemp);
								
							}
							
							
					    }
						
						stmtHMSP9.close();
						stmtHMSP10.close();
						stmtHMSP11.close();
						stmtHMSP12.close();
						stmtHMSP13.close();
					}
					
					RESULTDATA=convertRowAnalysisArrayToJSON(analysisrowarray,totleaves,totallowance);
					
					stmtHMSP.close();
			        stmtHMSP1.close();
					stmtHMSP2.close();
					stmtHMSP3.close();
					stmtHMSP4.close();
					stmtHMSP5.close();
					
		} else {
			
			Statement stmtHMSP = conn.createStatement();
			Statement stmtHMSP1 = conn.createStatement();
			Statement stmtHMSP2 = conn.createStatement();
			Statement stmtHMSP3 = conn.createStatement();
			
			ArrayList<String> employeeIDToBeProcessed = new ArrayList<String>();
			ArrayList<String> employeeIDTerminatedToBeProcessed = new ArrayList<String>();
			ArrayList<ArrayList<String>> employeeToBeProcessed= new ArrayList<ArrayList<String>>();
			ArrayList<ArrayList<String>> employeeProcessed= new ArrayList<ArrayList<String>>();
			ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<ArrayList<String>>();
			int totleaves=0,totallowance=0;

			String sql="select count(doc_no) totleaves from hr_timesheetset where reftype='L'";
			ResultSet resultSet = stmtHMSP.executeQuery(sql);
			
			while(resultSet.next()){
				totleaves=resultSet.getInt("totleaves");
			}
			
			String sql1 = "select count(doc_no) totallowances from hr_setallowance where status=3 and doc_no>0";
			ResultSet resultSet1 = stmtHMSP1.executeQuery(sql1);
			
			while(resultSet1.next()) {
				totallowance=resultSet1.getInt("totallowances");
		  	}
			
			String sql2 = "",sql3 = "";
			
			if(!(category.equalsIgnoreCase("0")) && !(category.equalsIgnoreCase(""))){
				sql2=sql2+" and m.pay_catid = '"+category+"'";
	        }
			
			if(!(empId.equalsIgnoreCase("0")) && !(empId.equalsIgnoreCase(""))){
				sql2=sql2+" and m.doc_no = '"+empId+"'";
	        }
			
			sql2 = "select t.empid from hr_timesheet t left join hr_empm m on (t.empid=m.doc_no and t.year=YEAR('"+sqlDate+"') and t.month=MONTH('"+sqlDate+"')) where m.status=3 and m.active=1 and t.payroll_processed=0 and t.payroll_confirmed=0 and month=MONTH('"+sqlDate+"') and t.year=YEAR('"+sqlDate+"')"+sql2+"";			
			ResultSet resultSet2 = stmtHMSP3.executeQuery(sql2);
			
			while(resultSet2.next()){
				employeeIDToBeProcessed.add(resultSet2.getString("empid"));
			}
			
			if(!(category.equalsIgnoreCase("0")) && !(category.equalsIgnoreCase(""))){
				sql3=sql3+" and m.pay_catid = '"+category+"'";
	        }
			
			sql3 = "select t.empid from hr_timesheet t left join hr_empm m on (t.empid=m.doc_no and t.year=YEAR('"+sqlDate+"') and t.month=MONTH('"+sqlDate+"')) where m.status=7 and m.active=0 and t.payroll_processed=0 and t.payroll_confirmed=0 and t.month=MONTH('"+sqlDate+"') and t.year=YEAR('"+sqlDate+"') and MONTH(m.terminated_date)=MONTH('"+sqlDate+"') and YEAR(m.terminated_date)=YEAR('"+sqlDate+"')"+sql3+"";
			ResultSet resultSet3 = stmtHMSP3.executeQuery(sql3);
			
			while(resultSet3.next()){
				employeeIDTerminatedToBeProcessed.add(resultSet3.getString("empid"));
			}
			
			if(employeeIDToBeProcessed.size()>0){
				
				Statement stmtHMSP4 = conn.createStatement();
				Statement stmtHMSP5 = conn.createStatement();
				Statement stmtHMSP6 = conn.createStatement();
				Statement stmtHMSP7 = conn.createStatement();
				Statement stmtHMSP8 = conn.createStatement();
				
				
				String dailyRateFormula="",xsql="";
				ClsCommonHR hrCalc = new ClsCommonHR();
				ArrayList<String> additionsDeductionsAmount = new ArrayList<String>();
				
				for(int i=0;i< employeeIDToBeProcessed.size();i++){
					
					if(!(category.equalsIgnoreCase("0")) && !(category.equalsIgnoreCase(""))){
			            xsql=xsql+" and m.pay_catid = '"+category+"'";
			        }
					
					if(!(empId.equalsIgnoreCase("0")) && !(empId.equalsIgnoreCase(""))){
			            xsql=xsql+" and m.doc_no = '"+empId+"'";
			        }
					
					String sql4="select m.doc_no employeedocno,m.codeno employeeid,m.name employeename,m.salary_paid dates,DATEDIFF('"+sqlDate+"',m.salary_paid) totaldays,if(mod(round(sum(t.tot_leave1),1),1)=0,"
							+ "round(sum(t.tot_leave1),0),round(sum(t.tot_leave1),1)) leave1,if(mod(round(sum(t.tot_leave2),1),1)=0,round(sum(t.tot_leave2),0),round(sum(t.tot_leave2),1)) leave2,"
							+ "if(mod(round(sum(t.tot_leave3),1),1)=0,round(sum(t.tot_leave3),0),round(sum(t.tot_leave3),1)) leave3,if(mod(round(sum(t.tot_leave4),1),1)=0,round(sum(t.tot_leave4),0),"
							+ "round(sum(t.tot_leave4),1)) leave4,if(mod(round(sum(t.tot_leave5),1),1)=0,round(sum(t.tot_leave5),0),round(sum(t.tot_leave5),1)) leave5,if(mod(round(sum(t.tot_leave6),1),1)=0,"
							+ "round(sum(t.tot_leave6),0),round(sum(t.tot_leave6),1)) leave6,CONVERT(if(round(t.tot_ot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(t.tot_ot*60))=8,SUBSTRING(SEC_TO_TIME(t.tot_ot*60),1,5),SUBSTRING(SEC_TO_TIME(t.tot_ot*60),1,6))),CHAR(100)) ot," 
							+ "CONVERT(if(round(t.tot_hot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(t.tot_hot*60))=8,SUBSTRING(SEC_TO_TIME(t.tot_hot*60),1,5),SUBSTRING(SEC_TO_TIME(t.tot_hot*60),1,6))),CHAR(100)) hot,"
							+ "t.payroll_processed payrollprocessed from hr_timesheet t left join hr_empm m on t.empid=m.doc_no where m.active=1 and m.status=3"+xsql+" "
							+ "and t.year=YEAR('"+sqlDate+"') and t.month=MONTH('"+sqlDate+"') and t.empid="+employeeIDToBeProcessed.get(i).trim()+" group by t.empid";
					
					ResultSet resultSet4 = stmtHMSP4.executeQuery(sql4);
					
					String oldempid="",newempid="",empCategoryID="0",daysToPay="0";
					
					while(resultSet4.next()){
						ArrayList<String> temp=new ArrayList<String>();
	
						newempid=resultSet4.getString("employeedocno");
						
						if(oldempid!=newempid){
							
							temp.add(newempid);
							temp.add(resultSet4.getString("employeeid"));
							temp.add(resultSet4.getString("employeename"));
							temp.add(resultSet4.getString("dates"));
							daysToPay=resultSet4.getString("totaldays");
							temp.add(daysToPay);
							temp.add(resultSet4.getString("ot"));
							temp.add(resultSet4.getString("hot"));
							temp.add(resultSet4.getString("payrollprocessed"));
							
							for (int l = 1; l <= totleaves; l++) {
								temp.add(String.valueOf(resultSet4.getInt("leave"+l+"")));
	 						 }
	
							String sql5 = "select pay_catid from hr_empm where doc_no="+newempid+"";
							ResultSet resultSet5 = stmtHMSP5.executeQuery(sql5);		
							
							while(resultSet5.next()){
								empCategoryID=resultSet5.getString("pay_catid");
							}
							
							String sql6 = "select dailyRate from hr_paycode where catid="+empCategoryID+" and doc_no=(select max(doc_no) from hr_paycode where catid="+empCategoryID+" and revdate<='"+sqlDate+"')";
							ResultSet resultSet6 = stmtHMSP6.executeQuery(sql6);		
							
							while(resultSet6.next()){
								dailyRateFormula=resultSet6.getString("dailyRate");
							}
							
							String sql7="select * from ( "  
									+ "select t.empid,id.rdocno,id.awlid,id.refdtype,id.addition,id.deduction,id.statutorydeduction,id.revadd,id.revded,id.revstatded from "
									+ "hr_timesheet t left join hr_incrm im on t.empid=im.empid left join hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) "
									+ "from hr_incrm where t.empid=empid) and id.refdtype!='STD' and t.empid="+newempid+" union all "
									+ "select 0 empid,0 rdocno,hrs.doc_no awlid,'ALC' refdtype,0 addition,0 deduction,0 statutorydeduction,0 revadd,0 revded,0 revstatded from "
									+ "hr_setallowance hrs where hrs.status=3 and hrs.doc_no not in (select id.awlid from hr_timesheet t left join hr_incrm im on t.empid=im.empid left join "
									+ "hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) from hr_incrm where t.empid=empid) and id.refdtype!='STD' and "
									+ "t.empid="+newempid+")) as a where a.awlid>=0 group by empid,awlid,refdtype order by refdtype,awlid";
							
							ResultSet resultSet7 = stmtHMSP7.executeQuery(sql7);		
							
							double totalsalary=0.00,otAmount=0.00,hotAmount=0.00,overTimeAmount=0.00,leaveDeductionsAmount=0.00,grossSalaryAmount=0.00,additionAmount=0.00,deductionAmount=0.00,loanAmount=0.00,netSalaryAmount=0.00;
							while(resultSet7.next()){
								double basicsalary=0.00,basicSalaryAmount=0.00,allowance=0.00,allowanceAmount=0.00,statutorydeduction=0.00;
								
								if(resultSet7.getString("awlid").equalsIgnoreCase("0") && resultSet7.getString("refdtype").equalsIgnoreCase("0")){
									basicsalary=basicsalary+resultSet7.getDouble("revadd");
									basicsalary=basicsalary-resultSet7.getDouble("revded");
									
									/*BASIC Calculation */
									//basicSalaryAmount= Double.parseDouble(hrCalc.getHRBASIC(conn,newempid,empCategoryID,sqlDate,basicsalary,daysToPay));
									//basicsalary=basicSalaryAmount;
									/*BASIC Calculation Ends */
									
									temp.add(String.valueOf(basicsalary));
									totalsalary=totalsalary+basicsalary;
								}
								
								if(resultSet7.getString("refdtype").equalsIgnoreCase("ALC")){
									allowance=allowance+resultSet7.getDouble("revadd");
									allowance=allowance-resultSet7.getDouble("revded");
									
									if(dailyRateFormula.contains("GROSS")){
										
										/*Allowance Calculation */
										//allowanceAmount= Double.parseDouble(hrCalc.getHRALLOWANCES(conn,newempid,empCategoryID,sqlDate,allowance,daysToPay));
										//allowance=allowanceAmount;
										/*Allowance Calculation Ends */
										
										totalsalary=totalsalary+allowance;
									} else{
										totalsalary=totalsalary+allowance;
									}
									
									temp.add(String.valueOf(allowance));
								}
								
								if(resultSet7.getString("refdtype").equalsIgnoreCase("STD")){
									statutorydeduction=statutorydeduction-resultSet7.getDouble("revstatded");
									totalsalary=totalsalary-statutorydeduction;
								}
							}
							
							/*Total Salary Calculation */
							temp.add(String.valueOf(totalsalary));
							/*Total Salary Calculation Ends */
							
							String sql8="select * from ( "  
									+ "select t.empid,id.rdocno,id.awlid,id.refdtype,id.addition,id.deduction,id.statutorydeduction,id.revadd,id.revded,id.revstatded from "
									+ "hr_timesheet t left join hr_incrm im on t.empid=im.empid left join hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) "
									+ "from hr_incrm where t.empid=empid) and id.refdtype!='STD' and t.empid="+newempid+" union all "
									+ "select 0 empid,0 rdocno,hrs.doc_no awlid,'ALC' refdtype,0 addition,0 deduction,0 statutorydeduction,0 revadd,0 revded,0 revstatded from "
									+ "hr_setallowance hrs where hrs.status=3 and hrs.doc_no not in (select id.awlid from hr_timesheet t left join hr_incrm im on t.empid=im.empid left join "
									+ "hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) from hr_incrm where t.empid=empid) and id.refdtype!='STD' and "
									+ "t.empid="+newempid+")) as a where a.awlid>=0 group by empid,awlid,refdtype order by refdtype,awlid";
							
							ResultSet resultSet8 = stmtHMSP8.executeQuery(sql8);		
							
							double earnedtotalsalary=0.00;
							while(resultSet8.next()){
								double earnedbasicsalary=0.00,earnedbasicSalaryAmount=0.00,earnedallowance=0.00,earnedallowanceAmount=0.00,earnedstatutorydeduction=0.00;
								
								if(resultSet8.getString("awlid").equalsIgnoreCase("0") && resultSet8.getString("refdtype").equalsIgnoreCase("0")){
									earnedbasicsalary=earnedbasicsalary+resultSet8.getDouble("revadd");
									earnedbasicsalary=earnedbasicsalary-resultSet8.getDouble("revded");
									
									/*BASIC Calculation */
									earnedbasicSalaryAmount= Double.parseDouble(hrCalc.getHREARNEDBASIC(conn,newempid,empCategoryID,sqlDate,earnedbasicsalary,daysToPay));
									earnedbasicsalary=earnedbasicSalaryAmount;
									/*BASIC Calculation Ends */
									
									temp.add(String.valueOf(earnedbasicsalary));
									earnedtotalsalary=earnedtotalsalary+earnedbasicsalary;
								}
								
								if(resultSet8.getString("refdtype").equalsIgnoreCase("ALC")){
									earnedallowance=earnedallowance+resultSet8.getDouble("revadd");
									earnedallowance=earnedallowance-resultSet8.getDouble("revded");
									
									if(dailyRateFormula.contains("GROSS")){
										
										/*Allowance Calculation */
										earnedallowanceAmount= Double.parseDouble(hrCalc.getHREARNEDALLOWANCES(conn,newempid,empCategoryID,sqlDate,earnedallowance,daysToPay,resultSet8.getString("awlid")));
										earnedallowance=earnedallowanceAmount;
										/*Allowance Calculation Ends */
										
										earnedtotalsalary=earnedtotalsalary+earnedallowance;
									} else{
										earnedtotalsalary=earnedtotalsalary+earnedallowance;
									}
									
									temp.add(String.valueOf(earnedallowance));
								}
								
								if(resultSet8.getString("refdtype").equalsIgnoreCase("STD")){
									earnedstatutorydeduction=earnedstatutorydeduction-resultSet8.getDouble("revstatded");
									earnedtotalsalary=earnedtotalsalary-earnedstatutorydeduction;
								}
							}
							
							/*Earned Total Salary Calculation */
							temp.add(String.valueOf(Math.round(earnedtotalsalary)));
							/*Earned Total Salary Calculation Ends */
							
							/*OT Calculation */
							otAmount= Double.parseDouble(hrCalc.getHROT(conn,newempid,empCategoryID,sqlDate));
							/*OT Calculation Ends */
	
							/*HOT Calculation */
							hotAmount= Double.parseDouble(hrCalc.getHRHOT(conn,newempid,empCategoryID,sqlDate));
							/*HOT Calculation Ends */
							
							/*Over Time Calculation */
							overTimeAmount=otAmount+hotAmount;
							temp.add(String.valueOf(overTimeAmount));
							/*Holiday Over Time Calculation Ends */
							
							/*Leave Deductions Calculation */
							//leaveDeductionsAmount=Double.parseDouble(hrCalc.getHRLeaveDeductions(conn,newempid,empCategoryID,sqlDate));
							//temp.add(String.valueOf(leaveDeductionsAmount));
							/*Leave Deductions Calculation Ends */
	
							/*Gross Salary Calculation */
							grossSalaryAmount=Math.round(earnedtotalsalary+overTimeAmount);
							temp.add(String.valueOf(grossSalaryAmount));
							/*Gross Salary Calculation Ends */
							
							/*Additions and Deductions Calculation */
							additionsDeductionsAmount=hrCalc.getHRAdditionsDeductions(conn,newempid,sqlDate);
							if(additionsDeductionsAmount.size()>0){
								String[] additionsDeductions=additionsDeductionsAmount.get(0).split("::");
								additionAmount = ((additionsDeductions[0].isEmpty()?0.0:Double.parseDouble(additionsDeductions[0])));
								deductionAmount = ((additionsDeductions[1].isEmpty()?0.0:Double.parseDouble(additionsDeductions[1])));
								temp.add(String.valueOf(additionAmount));
								temp.add(String.valueOf(deductionAmount));
							}
							/*Additions and Deductions Calculation Ends */
							
							/*Loan Amount Calculation*/
							loanAmount= Double.parseDouble(hrCalc.getHRLoanAmount(conn,newempid,sqlDate));
							temp.add(String.valueOf(loanAmount));
							/*Loan Amount Calculation Ends*/
							
							/*Net Salary Amount Calculation */
							netSalaryAmount=(((grossSalaryAmount+additionAmount)-(deductionAmount))-(loanAmount));
							temp.add(String.valueOf(netSalaryAmount));
							/*Net Salary Amount Calculation Ends*/
							
							temp.add("Payroll Processed on "+date+"");
							
							oldempid=newempid;
							
						}
						
						employeeToBeProcessed.add(temp);
						
					}
					
					
			    }
				
				stmtHMSP4.close();
				stmtHMSP5.close();
				stmtHMSP6.close();
				stmtHMSP7.close();
				stmtHMSP8.close();
			}
			
			/*Terminated Salary processing*/
			if(employeeIDTerminatedToBeProcessed.size()>0){
				
				Statement stmtHMSP9 = conn.createStatement();
				Statement stmtHMSP10 = conn.createStatement();
				Statement stmtHMSP11 = conn.createStatement();
				Statement stmtHMSP12 = conn.createStatement();
				Statement stmtHMSP13 = conn.createStatement();
				
				
				String dailyRateFormula="",xsql="";
				ClsCommonHR hrCalc = new ClsCommonHR();
				ArrayList<String> additionsDeductionsAmount = new ArrayList<String>();
				
				for(int j=0;j< employeeIDTerminatedToBeProcessed.size();j++){
					
					if(!(category.equalsIgnoreCase("0")) && !(category.equalsIgnoreCase(""))){
			            xsql=xsql+" and m.pay_catid = '"+category+"'";
			        }
					if(!(empId.equalsIgnoreCase("0")) && !(empId.equalsIgnoreCase(""))){
			            xsql=xsql+" and m.doc_no = '"+empId+"'";
			        }
					String sql9="select m.doc_no employeedocno,m.codeno employeeid,m.name employeename,m.salary_paid dates,DATEDIFF(m.terminated_date,m.salary_paid) totaldays,if(mod(round(sum(t.tot_leave1),1),1)=0,"
							+ "round(sum(t.tot_leave1),0),round(sum(t.tot_leave1),1)) leave1,if(mod(round(sum(t.tot_leave2),1),1)=0,round(sum(t.tot_leave2),0),round(sum(t.tot_leave2),1)) leave2,"
							+ "if(mod(round(sum(t.tot_leave3),1),1)=0,round(sum(t.tot_leave3),0),round(sum(t.tot_leave3),1)) leave3,if(mod(round(sum(t.tot_leave4),1),1)=0,round(sum(t.tot_leave4),0),"
							+ "round(sum(t.tot_leave4),1)) leave4,if(mod(round(sum(t.tot_leave5),1),1)=0,round(sum(t.tot_leave5),0),round(sum(t.tot_leave5),1)) leave5,if(mod(round(sum(t.tot_leave6),1),1)=0,"
							+ "round(sum(t.tot_leave6),0),round(sum(t.tot_leave6),1)) leave6,CONVERT(if(round(t.tot_ot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(t.tot_ot*60))=8,SUBSTRING(SEC_TO_TIME(t.tot_ot*60),1,5),SUBSTRING(SEC_TO_TIME(t.tot_ot*60),1,6))),CHAR(100)) ot,"  
							+ "CONVERT(if(round(t.tot_hot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(t.tot_hot*60))=8,SUBSTRING(SEC_TO_TIME(t.tot_hot*60),1,5),SUBSTRING(SEC_TO_TIME(t.tot_hot*60),1,6))),CHAR(100)) hot,"
							+ "t.payroll_processed payrollprocessed from hr_timesheet t left join hr_empm m on t.empid=m.doc_no where m.active=0 and m.status=7"+xsql+" "
							+ "and t.year=YEAR('"+sqlDate+"') and t.month=MONTH('"+sqlDate+"') and t.empid="+employeeIDTerminatedToBeProcessed.get(j).trim()+" group by t.empid";
					
					ResultSet resultSet9 = stmtHMSP9.executeQuery(sql9);
					
					String oldempid="",newempid="",empCategoryID="0",daysToPay="0";
					
					while(resultSet9.next()){
						ArrayList<String> terminatedtemp=new ArrayList<String>();
	
						newempid=resultSet9.getString("employeedocno");
						
						if(oldempid!=newempid){
							
							terminatedtemp.add(newempid);
							terminatedtemp.add(resultSet9.getString("employeeid"));
							terminatedtemp.add(resultSet9.getString("employeename"));
							terminatedtemp.add(resultSet9.getString("dates"));
							daysToPay=resultSet9.getString("totaldays");
							terminatedtemp.add(daysToPay);
							terminatedtemp.add(resultSet9.getString("ot"));
							terminatedtemp.add(resultSet9.getString("hot"));
							terminatedtemp.add(resultSet9.getString("payrollprocessed"));
							
							for (int l = 1; l <= totleaves; l++) {
								terminatedtemp.add(String.valueOf(resultSet9.getInt("leave"+l+"")));
	 						 }
	
							String sql10 = "select pay_catid from hr_empm where doc_no="+newempid+"";
							ResultSet resultSet10 = stmtHMSP10.executeQuery(sql10);		
							
							while(resultSet10.next()){
								empCategoryID=resultSet10.getString("pay_catid");
							}
							
							String sql11 = "select dailyRate from hr_paycode where catid="+empCategoryID+" and doc_no=(select max(doc_no) from hr_paycode where catid="+empCategoryID+" and revdate<='"+sqlDate+"')";
							ResultSet resultSet11 = stmtHMSP11.executeQuery(sql11);		
							
							while(resultSet11.next()){
								dailyRateFormula=resultSet11.getString("dailyRate");
							}
							
							String sql12="select * from ( "  
									+ "select t.empid,id.rdocno,id.awlid,id.refdtype,id.addition,id.deduction,id.statutorydeduction,id.revadd,id.revded,id.revstatded from "
									+ "hr_timesheet t left join hr_incrm im on t.empid=im.empid left join hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) "
									+ "from hr_incrm where t.empid=empid) and id.refdtype!='STD' and t.empid="+newempid+" union all "
									+ "select 0 empid,0 rdocno,hrs.doc_no awlid,'ALC' refdtype,0 addition,0 deduction,0 statutorydeduction,0 revadd,0 revded,0 revstatded from "
									+ "hr_setallowance hrs where hrs.status=3 and hrs.doc_no not in (select id.awlid from hr_timesheet t left join hr_incrm im on t.empid=im.empid left join "
									+ "hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) from hr_incrm where t.empid=empid) and id.refdtype!='STD' and "
									+ "t.empid="+newempid+")) as a where a.awlid>=0 group by empid,awlid,refdtype order by refdtype,awlid";
							
							ResultSet resultSet12 = stmtHMSP12.executeQuery(sql12);		
							
							double totalsalary=0.00,otAmount=0.00,hotAmount=0.00,overTimeAmount=0.00,leaveDeductionsAmount=0.00,grossSalaryAmount=0.00,additionAmount=0.00,deductionAmount=0.00,loanAmount=0.00,netSalaryAmount=0.00;
							while(resultSet12.next()){
								double basicsalary=0.00,basicSalaryAmount=0.00,allowance=0.00,allowanceAmount=0.00,statutorydeduction=0.00;
								
								if(resultSet12.getString("awlid").equalsIgnoreCase("0") && resultSet12.getString("refdtype").equalsIgnoreCase("0")){
									basicsalary=basicsalary+resultSet12.getDouble("revadd");
									basicsalary=basicsalary-resultSet12.getDouble("revded");
									
									/*BASIC Calculation */
									//basicSalaryAmount= Double.parseDouble(hrCalc.getHRBASIC(conn,newempid,empCategoryID,sqlDate,basicsalary,daysToPay));
									//basicsalary=basicSalaryAmount;
									/*BASIC Calculation Ends */
									
									terminatedtemp.add(String.valueOf(basicsalary));
									totalsalary=totalsalary+basicsalary;
								}
								
								if(resultSet12.getString("refdtype").equalsIgnoreCase("ALC")){
									allowance=allowance+resultSet12.getDouble("revadd");
									allowance=allowance-resultSet12.getDouble("revded");
									
									if(dailyRateFormula.contains("GROSS")){
										
										/*Allowance Calculation */
										//allowanceAmount= Double.parseDouble(hrCalc.getHRALLOWANCES(conn,newempid,empCategoryID,sqlDate,allowance,daysToPay));
										//allowance=allowanceAmount;
										/*Allowance Calculation Ends */
										
										totalsalary=totalsalary+allowance;
									} else{
										totalsalary=totalsalary+allowance;
									}
									
									terminatedtemp.add(String.valueOf(allowance));
								}
								
								if(resultSet12.getString("refdtype").equalsIgnoreCase("STD")){
									statutorydeduction=statutorydeduction-resultSet12.getDouble("revstatded");
									totalsalary=totalsalary-statutorydeduction;
								}
							}
							
							/*Total Salary Calculation */
							terminatedtemp.add(String.valueOf(totalsalary));
							/*Total Salary Calculation Ends */
							
							String sql13="select * from ( "  
									+ "select t.empid,id.rdocno,id.awlid,id.refdtype,id.addition,id.deduction,id.statutorydeduction,id.revadd,id.revded,id.revstatded from "
									+ "hr_timesheet t left join hr_incrm im on t.empid=im.empid left join hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) "
									+ "from hr_incrm where t.empid=empid) and id.refdtype!='STD' and t.empid="+newempid+" union all "
									+ "select 0 empid,0 rdocno,hrs.doc_no awlid,'ALC' refdtype,0 addition,0 deduction,0 statutorydeduction,0 revadd,0 revded,0 revstatded from "
									+ "hr_setallowance hrs where hrs.status=3 and hrs.doc_no not in (select id.awlid from hr_timesheet t left join hr_incrm im on t.empid=im.empid left join "
									+ "hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) from hr_incrm where t.empid=empid) and id.refdtype!='STD' and "
									+ "t.empid="+newempid+")) as a where a.awlid>=0 group by empid,awlid,refdtype order by refdtype,awlid";
//							System.out.println("sql13======>>"+sql13);
							ResultSet resultSet13 = stmtHMSP13.executeQuery(sql13);		
							
							double earnedtotalsalary=0.00;
							while(resultSet13.next()){
								double earnedbasicsalary=0.00,earnedbasicSalaryAmount=0.00,earnedallowance=0.00,earnedallowanceAmount=0.00,earnedstatutorydeduction=0.00;
								
								if(resultSet13.getString("awlid").equalsIgnoreCase("0") && resultSet13.getString("refdtype").equalsIgnoreCase("0")){
									earnedbasicsalary=earnedbasicsalary+resultSet13.getDouble("revadd");
									earnedbasicsalary=earnedbasicsalary-resultSet13.getDouble("revded");
									
									/*Terminated Earned BASIC Calculation */
									earnedbasicSalaryAmount= Double.parseDouble(hrCalc.getHRTerminatedEARNEDBASIC(conn,newempid,empCategoryID,sqlDate,earnedbasicsalary,daysToPay));
									earnedbasicsalary=earnedbasicSalaryAmount;
									/*Terminated Earned BASIC Calculation Ends */
									
									terminatedtemp.add(String.valueOf(earnedbasicsalary));
									earnedtotalsalary=earnedtotalsalary+earnedbasicsalary;
								}
								
								if(resultSet13.getString("refdtype").equalsIgnoreCase("ALC")){
									earnedallowance=earnedallowance+resultSet13.getDouble("revadd");
									earnedallowance=earnedallowance-resultSet13.getDouble("revded");
									
									if(dailyRateFormula.contains("GROSS")){
										
										/*Terminated Earned Allowance Calculation */
										earnedallowanceAmount= Double.parseDouble(hrCalc.getHRTerminatedEARNEDALLOWANCES(conn,newempid,empCategoryID,sqlDate,earnedallowance,daysToPay,resultSet13.getString("awlid")));
										earnedallowance=earnedallowanceAmount;
										/*Terminated Earned Allowance Calculation Ends */
										
										earnedtotalsalary=earnedtotalsalary+earnedallowance;
									} else{
										earnedtotalsalary=earnedtotalsalary+earnedallowance;
									}
									
									terminatedtemp.add(String.valueOf(earnedallowance));
								}
								
								if(resultSet13.getString("refdtype").equalsIgnoreCase("STD")){
									earnedstatutorydeduction=earnedstatutorydeduction-resultSet13.getDouble("revstatded");
									earnedtotalsalary=earnedtotalsalary-earnedstatutorydeduction;
								}
							}
							
							/*Terminated Earned Total Salary Calculation */
							terminatedtemp.add(String.valueOf(Math.round(earnedtotalsalary)));
							/*Terminated Earned Total Salary Calculation Ends */
							
							/*OT Calculation */
							otAmount= Double.parseDouble(hrCalc.getHROT(conn,newempid,empCategoryID,sqlDate));
							/*OT Calculation Ends */
	
							/*HOT Calculation */
							hotAmount= Double.parseDouble(hrCalc.getHRHOT(conn,newempid,empCategoryID,sqlDate));
							/*HOT Calculation Ends */
							
							/*Over Time Calculation */
							overTimeAmount=otAmount+hotAmount;
							terminatedtemp.add(String.valueOf(overTimeAmount));
							/*Holiday Over Time Calculation Ends */
							
							/*Leave Deductions Calculation */
							//leaveDeductionsAmount=Double.parseDouble(hrCalc.getHRLeaveDeductions(conn,newempid,empCategoryID,sqlDate));
							//temp.add(String.valueOf(leaveDeductionsAmount));
							/*Leave Deductions Calculation Ends */
	
							/*Gross Salary Calculation */
							grossSalaryAmount=Math.round(earnedtotalsalary+overTimeAmount);
							terminatedtemp.add(String.valueOf(grossSalaryAmount));
							/*Gross Salary Calculation Ends */
							
							/*Additions and Deductions Calculation */
							additionsDeductionsAmount=hrCalc.getHRAdditionsDeductions(conn,newempid,sqlDate);
							if(additionsDeductionsAmount.size()>0){
								String[] additionsDeductions=additionsDeductionsAmount.get(0).split("::");
								additionAmount = ((additionsDeductions[0].isEmpty()?0.0:Double.parseDouble(additionsDeductions[0])));
								deductionAmount = ((additionsDeductions[1].isEmpty()?0.0:Double.parseDouble(additionsDeductions[1])));
								terminatedtemp.add(String.valueOf(additionAmount));
								terminatedtemp.add(String.valueOf(deductionAmount));
							}
							/*Additions and Deductions Calculation Ends */
							
							/*Loan Amount Calculation*/
							loanAmount= Double.parseDouble(hrCalc.getHRLoanAmount(conn,newempid,sqlDate));
							terminatedtemp.add(String.valueOf(loanAmount));
							/*Loan Amount Calculation Ends*/
							
							/*Net Salary Amount Calculation */
							netSalaryAmount=(((grossSalaryAmount+additionAmount)-(deductionAmount))-(loanAmount));
							terminatedtemp.add(String.valueOf(netSalaryAmount));
							/*Net Salary Amount Calculation Ends*/
							
							terminatedtemp.add("Termianted Employee Payroll Processed on "+date+"");
							
							oldempid=newempid;
							
						}
						
						employeeToBeProcessed.add(terminatedtemp);
						
					}
					
					
			    }
				
				stmtHMSP9.close();
				stmtHMSP10.close();
				stmtHMSP11.close();
				stmtHMSP12.close();
				stmtHMSP13.close();
			}
			
			String sql14="";
			
			if(!(category.equalsIgnoreCase("0")) && !(category.equalsIgnoreCase(""))){
	            sql14=sql14+" and m.pay_catid = '"+category+"'";
	        }
			
			if(!(empId.equalsIgnoreCase("0")) && !(empId.equalsIgnoreCase(""))){
				sql14=sql14+" and m.doc_no = '"+empId+"'";
	        }
			
			String sql15="select p.rowno,m.codeno employeeid,m.name employeename,p.date dates,p.daystopay totaldays,p.leave1,p.leave2,p.leave3,p.leave4,p.leave5,p.leave6,p.leave7,p.leave8,p.leave9,p.leave10,p.basic,p.allowance1,p.allowance2,"
				 + "p.allowance3,p.allowance4,p.allowance5,p.allowance6,p.allowance7,p.allowance8,p.allowance9,p.allowance10,p.totalsalary,p.earnedbasic earnbasic,p.earnedallowance1 earnallowance1,p.earnedallowance2 earnallowance2,"
				 + "p.earnedallowance3 earnallowance3,p.earnedallowance4 earnallowance4,p.earnedallowance5 earnallowance5,p.earnedallowance6 earnallowance6,p.earnedallowance7 earnallowance7,p.earnedallowance8 earnallowance8,"
				 + "p.earnedallowance9 earnallowance9,p.earnedallowance10 earnallowance10,p.earnedtotalsalary totalearnedsalary,CONVERT(if(round(p.tot_ot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(p.tot_ot*60))=8,SUBSTRING(SEC_TO_TIME(p.tot_ot*60),1,5),SUBSTRING(SEC_TO_TIME(p.tot_ot*60),1,6))),CHAR(100)) ot,"  
				 + "CONVERT(if(round(p.tot_hot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(p.tot_hot*60))=8,SUBSTRING(SEC_TO_TIME(p.tot_hot*60),1,5),SUBSTRING(SEC_TO_TIME(p.tot_hot*60),1,6))),CHAR(100)) hot,"
				 + "p.overtime,p.grosssalary,p.additions,p.deductions,p.loan,p.netsalary,p.remarks,p.empId employeedocno from hr_payroll mp left join hr_payrolld p on mp.doc_no=p.rdocno "
				 + "left join hr_empm m on p.empId=m.doc_no where mp.status=3 and p.status=3 and p.posted=0 and YEAR(mp.date)=YEAR('"+sqlDate+"') and MONTH(mp.date)=MONTH('"+sqlDate+"')"+sql14+"";
//            System.out.println("reload------------------>>>>>>"+sql15);       
			ResultSet resultSet15 = stmtHMSP3.executeQuery(sql15);
			
			while(resultSet15.next()){
				ArrayList<String> temp1=new ArrayList<String>();
				
				temp1.add(resultSet15.getString("employeedocno"));temp1.add(resultSet15.getString("employeeid"));temp1.add(resultSet15.getString("employeename"));temp1.add(resultSet15.getString("dates"));temp1.add(resultSet15.getString("totaldays"));
				temp1.add(resultSet15.getString("ot"));temp1.add(resultSet15.getString("hot"));temp1.add("1");for (int l = 1; l <= totleaves; l++) {temp1.add(String.valueOf(resultSet15.getInt("leave"+l+"")));}temp1.add(String.valueOf(resultSet15.getDouble("basic")));
				for (int m = 1; m <= totallowance; m++) {temp1.add(String.valueOf(resultSet15.getDouble("allowance"+m+"")));}temp1.add(String.valueOf(resultSet15.getDouble("totalsalary")));temp1.add(String.valueOf(resultSet15.getDouble("earnbasic")));
				for (int n = 1; n <= totallowance; n++) {temp1.add(String.valueOf(resultSet15.getDouble("earnallowance"+n+"")));}temp1.add(String.valueOf(resultSet15.getDouble("totalearnedsalary")));temp1.add(String.valueOf(resultSet15.getDouble("overtime")));
				temp1.add(String.valueOf(resultSet15.getDouble("grosssalary")));temp1.add(String.valueOf(resultSet15.getDouble("additions")));temp1.add(String.valueOf(resultSet15.getDouble("deductions")));temp1.add(String.valueOf(resultSet15.getDouble("loan")));
				temp1.add(String.valueOf(resultSet15.getDouble("netsalary")));temp1.add(resultSet15.getString("remarks"));
				
				employeeProcessed.add(temp1);
			}
//			System.out.println("analysisrowarray====>>>>"+analysisrowarray);
//			System.out.println("employeeProcessed====>>>>>"+employeeProcessed);
//			System.out.println("employeeToBeProcessed=====>>>>"+employeeToBeProcessed);
			if(employeeToBeProcessed.size()>0){
				analysisrowarray.addAll(employeeProcessed);
				analysisrowarray.addAll(employeeToBeProcessed);	
			} else {
				analysisrowarray=employeeProcessed;
			}
			
			RESULTDATA=convertRowAnalysisArrayToJSON(analysisrowarray,totleaves,totallowance);
			
			stmtHMSP.close();
			stmtHMSP1.close();
			stmtHMSP2.close();
			stmtHMSP3.close();
	        
		}
		        System.out.println(RESULTDATA);
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return RESULTDATA;
    }
	
	public JSONArray monthlyPayrollGridReloading(HttpSession session,String date) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        /*Enumeration<String> Enumeration = session.getAttributeNames();
        int a=0;
        while(Enumeration.hasMoreElements()){
        	if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
        		a=1;
        	}
        }
        if(a==0){
    		return RESULTDATA;
        	}
        String branch = session.getAttribute("BRANCHID").toString();*/
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtHMSP = conn.createStatement();
			     
				java.sql.Date sqlDate=null;
				
				date.trim();
		        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))) {
		        	sqlDate = ClsCommon.changeStringtoSqlDate(date);
		        }
		        
				String sql="select p.rowno rowno,m.codeno employeeid,m.name employeename,p.date dates,p.daystopay totaldays,p.leave1,p.leave2,p.leave3,p.leave4,p.leave5,p.leave6,p.leave7,p.leave8,p.leave9,p.leave10,p.basic,p.allowance1,p.allowance2,"
						 + "p.allowance3,p.allowance4,p.allowance5,p.allowance6,p.allowance7,p.allowance8,p.allowance9,p.allowance10,p.totalsalary,p.earnedbasic earnbasic,p.earnedallowance1 earnallowance1,p.earnedallowance2 earnallowance2,"
						 + "p.earnedallowance3 earnallowance3,p.earnedallowance4 earnallowance4,p.earnedallowance5 earnallowance5,p.earnedallowance6 earnallowance6,p.earnedallowance7 earnallowance7,p.earnedallowance8 earnallowance8,"
						 + "p.earnedallowance9 earnallowance9,p.earnedallowance10 earnallowance10,p.earnedtotalsalary totalearnedsalary,CONVERT(if(round(p.tot_ot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(p.tot_ot*60))=8,SUBSTRING(SEC_TO_TIME(p.tot_ot*60),1,5),SUBSTRING(SEC_TO_TIME(p.tot_ot*60),1,6))),CHAR(100)) ot,"
						 + "CONVERT(if(round(p.tot_hot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(p.tot_hot*60))=8,SUBSTRING(SEC_TO_TIME(p.tot_hot*60),1,5),SUBSTRING(SEC_TO_TIME(p.tot_hot*60),1,6))),CHAR(100)) hot,p.overtime,p.grosssalary,p.additions,p.deductions,p.loan,p.netsalary,p.remarks,p.empId employeedocno,"
						 + "'1' payrollprocessed from hr_payroll mp left join hr_payrolld p on mp.doc_no=p.rdocno left join hr_empm m on p.empId=m.doc_no where mp.status=3 and p.status=3 and p.posted=0 and YEAR(mp.date)=YEAR('"+sqlDate+"') "
						 + "and MONTH(mp.date)=MONTH('"+sqlDate+"')";
			
//				System.out.println("LOAD CASE----------->>>>>>>>>>>"+sql);  
				ResultSet resultSet = stmtHMSP.executeQuery(sql);
                
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtHMSP.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return RESULTDATA;
    }
	
	public JSONArray monthlyPayrollPrintGridLoading(String date,String category,String empId,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        /*Enumeration<String> Enumeration = session.getAttributeNames();
        int a=0;
        while(Enumeration.hasMoreElements()){
        	if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
        		a=1;
        	}
        }
        if(a==0){
    		return RESULTDATA;
        	}
        String branch = session.getAttribute("BRANCHID").toString();*/
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtHMSP = conn.createStatement();
			
				java.sql.Date sqlDate=null;

				if(check.equalsIgnoreCase("1")){
					
					date.trim();
			        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))) {
			        	sqlDate = ClsCommon.changeStringtoSqlDate(date);
			        }
			        
			        String sql="";
			        
			        if(!(category.equalsIgnoreCase("0")) && !(category.equalsIgnoreCase(""))){
			            sql=sql+" and m.pay_catid = '"+category+"'";
			        }
					
					if(!(empId.equalsIgnoreCase("0")) && !(empId.equalsIgnoreCase(""))){
			            sql=sql+" and m.doc_no = '"+empId+"'";
			        }
					
						sql="select m.codeno employeeid,m.name employeename,p.date dates,p.daystopay totaldays,p.leave1,p.leave2,p.leave3,p.leave4,p.leave5,p.leave6,p.leave7,p.leave8,p.leave9,p.leave10,p.earnedbasic basic,"
							 + "p.earnedallowance1 allowance1,p.earnedallowance2 allowance2,p.earnedallowance3 allowance3,p.earnedallowance4 allowance4,p.earnedallowance5 allowance5,p.earnedallowance6 allowance6,p.earnedallowance7 allowance7,"
							 + "p.earnedallowance8 allowance8,p.earnedallowance9 allowance9,p.earnedallowance10 allowance10,p.earnedtotalsalary totalsalary,CONVERT(if(round(p.tot_ot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(p.tot_ot*60))=8,SUBSTRING(SEC_TO_TIME(p.tot_ot*60),1,5),SUBSTRING(SEC_TO_TIME(p.tot_ot*60),1,6))),CHAR(100)) ot,"  
							 + "CONVERT(if(round(p.tot_hot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(p.tot_hot*60))=8,SUBSTRING(SEC_TO_TIME(p.tot_hot*60),1,5),SUBSTRING(SEC_TO_TIME(p.tot_hot*60),1,6))),CHAR(100)) hot,p.overtime,p.grosssalary,p.additions,"
							 + "p.deductions,p.loan,p.netsalary,p.remarks,p.empId employeedocno,'1' payrollprocessed from hr_payroll mp left join hr_payrolld p on mp.doc_no=p.rdocno left join hr_empm m on p.empId=m.doc_no where mp.status=3 and mp.date='"+sqlDate+"'"+sql+"";
					
						ResultSet resultSet = stmtHMSP.executeQuery(sql);
	                
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				}
				
				stmtHMSP.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return RESULTDATA;
    }
	
	public  JSONArray convertRowAnalysisArrayToJSON(ArrayList<ArrayList<String>> rowsAnalysisList,int leavelength,int allowancelength) throws Exception {
		JSONArray jsonArray = new JSONArray();
		
		for (int i = 0; i < rowsAnalysisList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			ArrayList<String> analysisRowArray=rowsAnalysisList.get(i);
			int length = analysisRowArray.size();
			int j,k=0,n,p;
			
			obj.put("employeedocno",analysisRowArray.get(0));
			obj.put("employeeid",analysisRowArray.get(1));
			obj.put("employeename",analysisRowArray.get(2));
			obj.put("dates",analysisRowArray.get(3));
			obj.put("totaldays",analysisRowArray.get(4));
			obj.put("ot",analysisRowArray.get(5));
			obj.put("hot",analysisRowArray.get(6));
			obj.put("payrollprocessed",analysisRowArray.get(7));
			
			for (j = 8,k=1; j < (leavelength+8); j++,k++) {
				if(!(analysisRowArray.get(j).trim().equalsIgnoreCase(""))){
					obj.put("leave"+k,analysisRowArray.get(j));
				}
			}
			
			obj.put("basic",analysisRowArray.get(j));
			
			for (int l = (j+1),m=1; l < (allowancelength+(j+1)); l++,m++) {
				if(!(analysisRowArray.get(l).trim().equalsIgnoreCase(""))){
					obj.put("allowance"+m,analysisRowArray.get(l));
				}
			}
			
			obj.put("totalsalary",analysisRowArray.get((allowancelength+(j+1))));
			obj.put("earnbasic",analysisRowArray.get((allowancelength+(j+1)+1)));
			
			for (n = (allowancelength+(j+1)+2),p=1; n < (allowancelength+((j+1)+2)+allowancelength); n++,p++) {
				if(!(analysisRowArray.get(n).trim().equalsIgnoreCase(""))){
					obj.put("earnallowance"+p,analysisRowArray.get(n));
				}
			}
			
			obj.put("totalearnedsalary",analysisRowArray.get(n));
			obj.put("overtime",analysisRowArray.get((n+1)));
			//obj.put("leavedeductions",analysisRowArray.get((allowancelength+(j+1)+2)));
			obj.put("grosssalary",analysisRowArray.get((n+1)+1));
			obj.put("additions",analysisRowArray.get((n+1)+2));
			obj.put("deductions",analysisRowArray.get((n+1)+3));
			obj.put("loan",analysisRowArray.get((n+1)+4));
			obj.put("netsalary",analysisRowArray.get((n+1)+5));
			obj.put("remarks",analysisRowArray.get((n+1)+6));
			
			jsonArray.add(obj);
			
		}
		return jsonArray;
		}
	
	public JSONArray employeeDetailsSearch(String empid,String employeename,String contact) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtHMSP = conn.createStatement();
			
	    	    String sql = "";
				
	    	    if(!(empid.equalsIgnoreCase(""))){
	                sql=sql+" and codeno like '%"+empid+"%'";
	            }
	            if(!(employeename.equalsIgnoreCase(""))){
	             sql=sql+" and name like '%"+employeename+"%'";
	            }
	            if(!(contact.equalsIgnoreCase(""))){
	                sql=sql+" and pmmob like '%"+contact+"%'";
	            }
	            
				sql = "select doc_no,codeno,UPPER(name) name,pmmob from hr_empm where  1=1 "+sql;
				
				ResultSet resultSet1 = stmtHMSP.executeQuery(sql);
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtHMSP.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public JSONArray dscMainSearch(HttpSession session,String empname,String docNo,String date,String amount) throws SQLException {

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
        
         String branch=session.getAttribute("BRANCHID").toString();
       
        java.sql.Date sqlDate=null;
        
        date.trim();
        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
        {
        sqlDate = ClsCommon.changeStringtoSqlDate(date);
        }

        String sqltest="";
        
        if(!(docNo.equalsIgnoreCase(""))){
            sqltest=sqltest+" and m.doc_no like '%"+docNo+"%'";
        }
        if(!(empname.equalsIgnoreCase(""))){
        	sqltest=sqltest+" and e.name like '%"+empname+"%'";
        }
        if(!(amount.equalsIgnoreCase(""))){
        	sqltest=sqltest+" and m.amount like '%"+amount+"%'";
        }
        if(!(sqlDate==null)){
        	sqltest=sqltest+" and m.date='"+sqlDate+"'";
	    } 
           
     try {
	       conn = ClsConnection.getMyConnection();
	       Statement stmtHMSP = conn.createStatement();
	       
	       ResultSet resultSet = stmtHMSP.executeQuery("select m.date,m.doc_no,m.amount,e.name from hr_addschm m left join hr_empm e on m.empid=e.doc_no where m.brhid="+branch+" and m.dtype='DSC' "  
	       	+ "and m.status<>7" +sqltest);
	
	       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	       
	       stmtHMSP.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
 		conn.close();
 	}
       return RESULTDATA;
   }
	
	 public ClsMonthlyPayrollBean getViewDetails(HttpSession session,int docNo) throws SQLException {
		    ClsMonthlyPayrollBean monthlyPayrollBean = new ClsMonthlyPayrollBean();
			
			Connection conn = null;
			
			try {
				conn = ClsConnection.getMyConnection();
				Statement stmtHMSP = conn.createStatement();
			
				String branch = session.getAttribute("BRANCHID").toString();
				
				ResultSet resultSet = stmtHMSP.executeQuery ("select m.date,m.refno,round(m.amount,2) amount,m.instno,m.stdate,m.description,e.doc_no empdocno,convert(concat(' Employee : ',"
					+ "coalesce(e.emp_id),' - ',coalesce(e.name), '   ','Mobile  : ',coalesce(if(e.prmob is null,e.pmmob,if(e.prmob=' ',e.pmmob,e.prmob))),'   ',"
					+ "'Designation : ' ,coalesce(dg.desc1),'   ','Department : ', coalesce(dp.desc1)),char(1000)) empinfo from hr_addschm m left join hr_empm e "
					+ "on m.empid=e.doc_no left join hr_setdesig dg on e.desc_id=dg.doc_no left join hr_setdept dp on e.dept_id=dp.doc_no where m.dtype='DSC' and "
					+ "m.status<>7 and m.brhId='"+branch+"' and m.doc_no="+docNo);
				
				while (resultSet.next()) {
						monthlyPayrollBean.setTxtmonthlypayrolldocno(docNo);
						monthlyPayrollBean.setPayrollDate(resultSet.getDate("date").toString());

				}
			  stmtHMSP.close();
			  conn.close();
			} catch(Exception e){
				e.printStackTrace();
				conn.close();
			} finally{
				conn.close();
			}
			return monthlyPayrollBean;
			}
	 
	 public ClsMonthlyPayrollBean getPrint(HttpServletRequest request,String docNo,int branch,int header) throws SQLException {
		 ClsMonthlyPayrollBean bean = new ClsMonthlyPayrollBean();
		 Connection conn = null;
		 
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtHMSP = conn.createStatement();
			
			String headersql="select if(m.dtype='HMSP','Monthly Payroll','  ') vouchername,DATE_FORMAT(m.date,'%M  %Y ') vouchername1,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
					+ "b.cstno from hr_payroll m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='HMSP' "
					+ "and m.brhid="+branch+" and m.doc_no="+docNo+"";
				ResultSet resultSetHead = stmtHMSP.executeQuery(headersql);
				
				while(resultSetHead.next()){
					
					bean.setLblcompname(resultSetHead.getString("company"));
					bean.setLblcompaddress(resultSetHead.getString("address"));
					bean.setLblprintname(resultSetHead.getString("vouchername"));
					bean.setLblprintname1(resultSetHead.getString("vouchername1"));
					bean.setLblcomptel(resultSetHead.getString("tel"));
					bean.setLblcompfax(resultSetHead.getString("fax"));
					bean.setLblbranch(resultSetHead.getString("branchname"));
					bean.setLbllocation(resultSetHead.getString("location"));
					bean.setLblcstno(resultSetHead.getString("cstno"));
					bean.setLblpan(resultSetHead.getString("pbno"));
					bean.setLblservicetax(resultSetHead.getString("stcno"));
					bean.setLblpobox(resultSetHead.getString("pbno"));
				}
			
			String sqls="select u.user_name preparedby,COALESCE(u1.user_name,'') verifiedappr,COALESCE(u2.user_name,'') approved from hr_payroll m left join my_exdet ext on (m.doc_no=ext.doc_no and m.dtype=ext.dtype and ext.apprstatus=2) "
					+ "left join my_exdet ext1 on (m.doc_no=ext1.doc_no and m.dtype=ext1.dtype and ext1.apprstatus=3) left join my_user u on m.userid=u.doc_no left join my_user u1 on ext.userid=u1.doc_no left join "
					+ "my_user u2 on ext1.userid=u2.doc_no where m.status<>7 and m.brhid="+branch+" and m.doc_no="+docNo+"";
			ResultSet resultSets = stmtHMSP.executeQuery(sqls);
			
			while(resultSets.next()){
				bean.setLblpreparedby(resultSets.getString("preparedby"));
				bean.setLblverifiedby(resultSets.getString("verifiedappr"));
				bean.setLblapprovedby(resultSets.getString("approved"));
			}
		
			ArrayList<String> printmonthlypayroll= new ArrayList<String>();
//			System.out.println("======= "+ClsCommon.getPrintPath("HMSP").contains("Progress") +"============"+ClsCommon.getPrintPath("HMSP"));
			if(ClsCommon.getPrintPath("HMSP").contains("Progress")){
				
				String sql1="select m.codeno employeeid,m.name employeename,DATE_FORMAT(p1.date,'%d-%m-%Y') date,round(p.daystopay,1) days,(p.leave1+p.leave2+p.leave3+p.leave4+p.leave5+p.leave6+p.leave7+p.leave8+p.leave9+p.leave10) totleaves,round(p.earnedbasic,2) basic,"
						 + "if(round((p.earnedtotalsalary-p.earnedbasic),2)=0,'',round((p.earnedtotalsalary-p.earnedbasic),2)) totallowances,CONVERT(if(round(p.tot_ot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(p.tot_ot*60))=8,SUBSTRING(SEC_TO_TIME(p.tot_ot*60),1,5),SUBSTRING(SEC_TO_TIME(p.tot_ot*60),1,6))),CHAR(100)) ot," 
						 + "CONVERT(if(round(p.tot_hot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(p.tot_hot*60))=8,SUBSTRING(SEC_TO_TIME(p.tot_hot*60),1,5),SUBSTRING(SEC_TO_TIME(p.tot_hot*60),1,6))),CHAR(100)) hot,if(round(p.overtime,2)=0,'',round(p.overtime,2)) overtime,if(round(p.grosssalary,2)=0,'',round(p.grosssalary,2)) grosssalary,"
						 + "if(round(p.additions,2)=0,'',round(p.additions,2)) additions,if(round(p.deductions,2)=0,'',round(p.deductions,2)) deductions,if(round(p.loan,2)=0,'',round(p.loan,2)) loan,if(round(p.netsalary,2)=0,'',round(p.netsalary,2)) netsalary from hr_payroll p1 left join hr_payrolld p on p1.doc_no=p.rdocno "
						 + "left join hr_empm m on p.empId=m.doc_no where p.status=3 and p.rdocno="+docNo+"";
			
//				System.out.println("if____________________"+sql1);
				ResultSet resultSet1 = stmtHMSP.executeQuery(sql1);
				
				while(resultSet1.next()){
					String temp="";
					temp=resultSet1.getString("employeeid")+":: "+resultSet1.getString("employeename")+":: "+resultSet1.getString("date")+":: "+resultSet1.getString("days")+":: "+resultSet1.getString("totleaves")+":: "+resultSet1.getString("basic")+":: "+resultSet1.getString("totallowances")+":: "+resultSet1.getString("ot")+":: "+resultSet1.getString("hot")+":: "+resultSet1.getString("overtime")+":: "+resultSet1.getString("grosssalary")+":: "+resultSet1.getString("additions")+":: "+resultSet1.getString("deductions")+":: "+resultSet1.getString("loan")+":: "+resultSet1.getString("netsalary");
					printmonthlypayroll.add(temp);
				}
				
			}
			else {
			String sql1="select group_concat(coalesce(ad.remarks,' ')) remarks,p1.remarks remarksold,m.codeno employeeid,m.name employeename,DATE_FORMAT(p1.date,'%d-%m-%Y') date,round(p.daystopay,1) days,(p.leave1+p.leave2+p.leave3+p.leave4+p.leave5+p.leave6+p.leave7+p.leave8+p.leave9+p.leave10) totleaves,round(p.earnedbasic,2) basic,"
					 + "if(round((p.earnedtotalsalary-p.earnedbasic),2)=0,'',round((p.earnedtotalsalary-p.earnedbasic),2)) totallowances,CONVERT(if(round(p.tot_ot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(p.tot_ot*60))=8,SUBSTRING(SEC_TO_TIME(p.tot_ot*60),1,5),SUBSTRING(SEC_TO_TIME(p.tot_ot*60),1,6))),CHAR(100)) ot," 
					 + "CONVERT(if(round(p.tot_hot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(p.tot_hot*60))=8,SUBSTRING(SEC_TO_TIME(p.tot_hot*60),1,5),SUBSTRING(SEC_TO_TIME(p.tot_hot*60),1,6))),CHAR(100)) hot,if(round(p.overtime,2)=0,'',round(p.overtime,2)) overtime,if(round(p.grosssalary,2)=0,'',round(p.grosssalary,2)) grosssalary,"
					 + "if(round(p.additions,2)=0,'',round(p.additions,2)) additions,if(round(p.deductions,2)=0,'',round(p.deductions,2)) deductions,if(round(p.loan,2)=0,'',round(p.loan,2)) loan,if(round(p.netsalary,2)=0,'',round(p.netsalary,2)) netsalary from hr_payroll p1 left join hr_payrolld p on p1.doc_no=p.rdocno "
					 + "left join hr_empm m on p.empId=m.doc_no "
					 + "left join (select d.remarks,concat(year,'-',if(month>=10,month,concat('0',month))) dates,d.empid,year,month from hr_adddedm m left join hr_adddedd d on m.doc_no=d.rdocno and m.status=3 group by year,month,empid) ad on ( p.empid=ad.empid and month(p1.date)=ad.month and year(p1.date)=ad.year) "
					 + "where p.status=3 and p.rdocno="+docNo+" group by p.empid";
		    
//			System.out.println("else____________________"+sql1);
			ResultSet resultSet1 = stmtHMSP.executeQuery(sql1);
			
		
			
			while(resultSet1.next()){
				String temp="";
				temp=resultSet1.getString("employeeid")+":: "+resultSet1.getString("employeename")+":: "+resultSet1.getString("days")+":: "+resultSet1.getString("totleaves")+":: "+resultSet1.getString("basic")+":: "+resultSet1.getString("totallowances")+":: "+resultSet1.getString("ot")+":: "+resultSet1.getString("hot")+":: "+resultSet1.getString("overtime")+":: "+resultSet1.getString("grosssalary")+":: "+resultSet1.getString("additions")+":: "+resultSet1.getString("deductions")+":: "+resultSet1.getString("loan")+":: "+resultSet1.getString("netsalary")+":: "+resultSet1.getString("remarks");
				printmonthlypayroll.add(temp);
			}
			}
			request.setAttribute("printpayroll", printmonthlypayroll);
			
			bean.setTxtheader(header);
			
			String sql2="select round(sum(p.grosssalary),2) totgrosssalary,round(sum(p.additions),2) totadditions,round(sum(p.deductions),2) totdeductions,round(sum(p.loan),2) totloan,round(sum(p.netsalary),2) totnetsalary from hr_payrolld p left join hr_empm m on p.empId=m.doc_no where p.status=3 and p.rdocno="+docNo+"";
				
			ResultSet resultSet2 = stmtHMSP.executeQuery(sql2);
			
			while(resultSet2.next()){
				bean.setLblgrosstotal(resultSet2.getString("totgrosssalary"));
				bean.setLbladditiontotal(resultSet2.getString("totadditions"));
				bean.setLbldeductiontotal(resultSet2.getString("totdeductions"));
				bean.setLblloantotal(resultSet2.getString("totloan"));
				bean.setLblnetsalarytotal(resultSet2.getString("totnetsalary"));
			}
			
			String sql3 = "select max(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,max(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from hr_payroll m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='HMSP' and m.brhid="+branch+" and m.doc_no="+docNo+"";
			ResultSet resultSet3 = stmtHMSP.executeQuery(sql3);
			
			while(resultSet3.next()){
				bean.setLblpreparedon(resultSet3.getString("preparedon"));
				bean.setLblpreparedat(resultSet3.getString("preparedat"));
			}
		
			stmtHMSP.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			 conn.close();
		}
		return bean;
	}

	 public ClsMonthlyPayrollBean getPaySlipPrint(String employeedocno,String date, int branch,int allowancecount,String docno) throws SQLException {
		 ClsMonthlyPayrollBean bean = new ClsMonthlyPayrollBean();
		 Connection conn = null;
		 
			try {
				conn = ClsConnection.getMyConnection();
				Statement stmtHMSP = conn.createStatement();
				HttpServletRequest request=ServletActionContext.getRequest();
				ArrayList<ClsMonthlyPayrollAction> employeesPaySlip = new ArrayList();
				 
			    java.sql.Date sqlDate=null;
		        
		        date.trim();
		        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))) {
		        	sqlDate = ClsCommon.changeStringtoSqlDate(date);
		        }

			    String headersql="select CONCAT('Pay Slip for the period of ',DATE_FORMAT(m.date,'%M  %Y ')) vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
					+ "b.cstno from hr_payroll m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='HMSP' "
					+ "and m.brhid="+branch+" and m.doc_no="+docno+"";
				ResultSet resultSetHead = stmtHMSP.executeQuery(headersql);
				
				while(resultSetHead.next()){
					
					bean.setLblcompname(resultSetHead.getString("company"));
					bean.setLblcompaddress(resultSetHead.getString("address"));
					bean.setLblcomptel(resultSetHead.getString("tel"));
					bean.setLblcompfax(resultSetHead.getString("fax"));
					bean.setLblbranch(resultSetHead.getString("branchname"));
					bean.setLbllocation(resultSetHead.getString("location"));
					bean.setLblprintname(resultSetHead.getString("vouchername"));
				}
				
				String sqls = "select doc_no allowanceid,UPPER(desc1) allowance from hr_setallowance where status=3 and doc_no>=0";
				ResultSet resultSets = stmtHMSP.executeQuery(sqls);
				
				while(resultSets.next()){
					if(resultSets.getString("allowanceid").equalsIgnoreCase("0")){ bean.setLblearningbasic(resultSets.getString("allowance")); }
					if(resultSets.getString("allowanceid").equalsIgnoreCase("1")){ bean.setLblearningallowance0(resultSets.getString("allowance")); }
					if(resultSets.getString("allowanceid").equalsIgnoreCase("2")){ bean.setLblearningallowance1(resultSets.getString("allowance")); }
					if(resultSets.getString("allowanceid").equalsIgnoreCase("3")){ bean.setLblearningallowance2(resultSets.getString("allowance")); }
					if(resultSets.getString("allowanceid").equalsIgnoreCase("4")){ bean.setLblearningallowance3(resultSets.getString("allowance")); }
					if(resultSets.getString("allowanceid").equalsIgnoreCase("5")){ bean.setLblearningallowance4(resultSets.getString("allowance")); }
					if(resultSets.getString("allowanceid").equalsIgnoreCase("6")){ bean.setLblearningallowance5(resultSets.getString("allowance")); }
					if(resultSets.getString("allowanceid").equalsIgnoreCase("7")){ bean.setLblearningallowance6(resultSets.getString("allowance")); }
					if(resultSets.getString("allowanceid").equalsIgnoreCase("8")){ bean.setLblearningallowance7(resultSets.getString("allowance")); }
					if(resultSets.getString("allowanceid").equalsIgnoreCase("9")){ bean.setLblearningallowance8(resultSets.getString("allowance")); }
					if(resultSets.getString("allowanceid").equalsIgnoreCase("10")){ bean.setLblearningallowance9(resultSets.getString("allowance")); }
				}	
		
				bean.setLblearningovertime("OVERTIME");
				bean.setLblearningaddition("ADDITION");
				bean.setLbldeductionsleavedeductions("LEAVE DEDUCTIONS");
				bean.setLbldeductionsloan("LOAN");
				bean.setLbldeductionsdeduction("DEDUCTION");
				
			    String sql = "select round(d.daystopay-(d.leave1+d.leave2+d.leave3+d.leave4+d.leave5+d.leave6+d.leave7+d.leave8+d.leave9+d.leave10),1) daysworked,FORMAT(round(d.earnedbasic,2),2) basicSalary,FORMAT(round(d.earnedallowance1,2),2) allowance1,FORMAT(round(d.earnedallowance2,2),2) allowance2,"
			    		+ "FORMAT(round(d.earnedallowance3,2),2) allowance3,FORMAT(round(d.earnedallowance4,2),2) allowance4,FORMAT(round(d.earnedallowance5,2),2) allowance5,FORMAT(round(d.earnedallowance6,2),2) allowance6,FORMAT(round(d.earnedallowance7,2),2) allowance7,FORMAT(round(d.earnedallowance8,2),2) allowance8," 
			    		+ "FORMAT(round(d.earnedallowance9,2),2) allowance9,FORMAT(round(d.earnedallowance10,2),2) allowance10,FORMAT(round(d.overtime,2),2) overtime,FORMAT(round(d.additions,2),2) additions,FORMAT(round(d.leavedeductions,2),2) leavedeductions,FORMAT(round(d.loan,2),2) loan,FORMAT(round(d.deductions,2),2) deductions,"  
			    		+ "FORMAT((round(d.earnedbasic,2)+round(d.earnedallowance1,2)+round(d.earnedallowance2,2)+round(d.earnedallowance3,2)+round(d.earnedallowance4,2)+round(d.earnedallowance5,2)+round(d.earnedallowance6,2)+round(d.earnedallowance7,2)+round(d.earnedallowance8,2)+round(d.earnedallowance9,2)+round(d.earnedallowance10,2)+" 
			    		+ "round(d.overtime,2)+round(d.additions,2)),2) grosssalaryadd,FORMAT((round(d.leavedeductions,2)+round(d.loan,2)+round(d.deductions,2)),2) grosssalaryded,FORMAT(round(d.netsalary,2),2) netsalary,e.doc_no,e.codeno empid,UPPER(e.name) empname,DATE_FORMAT(e.dtjoin,'%d.%m.%Y') joindate,UPPER(dp.desc1) department,"
			    		+ "UPPER(ds.desc1) designation from hr_payroll m left join hr_payrolld d on m.doc_no=d.rdocno left join hr_empm e on d.empid=e.doc_no left join hr_setdept dp on e.dept_id=dp.doc_no left join hr_setdesig ds on e.desc_id=ds.doc_no where d.status=3  and MONTH(m.date)=MONTH('"+sqlDate+"') and YEAR(m.date)=YEAR('"+sqlDate+"') "
			    		+ "and m.doc_no="+docno+" and d.empid in ("+employeedocno+")";
			    
			    ResultSet resultSet = stmtHMSP.executeQuery(sql);

				while(resultSet.next()){
					
					bean.setLblemployeeid(resultSet.getString("empid"));
					bean.setLblemployeename(resultSet.getString("empname"));
					bean.setLblempdateofjoining(resultSet.getString("joindate"));
					bean.setLblempdepartment(resultSet.getString("department"));
					bean.setLblempdaysworked(resultSet.getString("daysworked"));
					bean.setLblempdesignation(resultSet.getString("designation"));
					
					bean.setLblearningbasicvalue(resultSet.getString("basicSalary"));
					bean.setLblearningallowance0value(resultSet.getString("allowance1"));
					bean.setLblearningallowance1value(resultSet.getString("allowance2"));
					bean.setLblearningallowance2value(resultSet.getString("allowance3"));
					bean.setLblearningallowance3value(resultSet.getString("allowance4"));
					bean.setLblearningallowance4value(resultSet.getString("allowance5"));
					bean.setLblearningallowance5value(resultSet.getString("allowance6"));
					bean.setLblearningallowance6value(resultSet.getString("allowance7"));
					bean.setLblearningallowance7value(resultSet.getString("allowance8"));
					bean.setLblearningallowance8value(resultSet.getString("allowance9"));
					bean.setLblearningallowance9value(resultSet.getString("allowance10"));
					bean.setLblearningovertimevalue(resultSet.getString("overtime"));
					bean.setLblearningadditionvalue(resultSet.getString("additions"));
					bean.setLbltotalearning(resultSet.getString("grosssalaryadd"));
					bean.setLbldeductionsleavedeductionsvalue(resultSet.getString("leavedeductions"));
					bean.setLbldeductionsloanvalue(resultSet.getString("loan"));
					bean.setLbldeductionsdeductionvalue(resultSet.getString("deductions"));
					bean.setLbltotaldeduction(resultSet.getString("grosssalaryded"));
					bean.setLblgrosssalary(resultSet.getString("grosssalaryadd"));
					bean.setLblgrossdeduction(resultSet.getString("grosssalaryded"));
					bean.setLblnetsalary(resultSet.getString("netsalary"));
					
					employeesPaySlip.add(new ClsMonthlyPayrollAction(bean.getLblcompname(),bean.getLblcompaddress(),bean.getLblcomptel(),bean.getLblcompfax(),bean.getLblbranch(),
					bean.getLbllocation(),bean.getLblprintname(),resultSet.getString("empid"),resultSet.getString("empname"),resultSet.getString("joindate"),resultSet.getString("department"), 
					resultSet.getString("daysworked"),resultSet.getString("designation"),bean.getLblearningbasic(),resultSet.getString("basicSalary"),bean.getLblearningallowance0(),
					resultSet.getString("allowance1"),bean.getLblearningallowance1(),resultSet.getString("allowance2"),bean.getLblearningallowance2(),resultSet.getString("allowance3"), 
					bean.getLblearningallowance3(),resultSet.getString("allowance4"),bean.getLblearningallowance4(),resultSet.getString("allowance5"),bean.getLblearningallowance5(),
					resultSet.getString("allowance6"),bean.getLblearningallowance6(),resultSet.getString("allowance7"),bean.getLblearningallowance7(),resultSet.getString("allowance8"),
					bean.getLblearningallowance8(),resultSet.getString("allowance9"),bean.getLblearningallowance9(),resultSet.getString("allowance10"),bean.getLblearningovertime(),
					resultSet.getString("overtime"),bean.getLblearningaddition(),resultSet.getString("additions"),resultSet.getString("grosssalaryadd"),bean.getLbldeductionsleavedeductions(),
					resultSet.getString("leavedeductions"),bean.getLbldeductionsloan(),resultSet.getString("loan"),bean.getLbldeductionsdeduction(),resultSet.getString("deductions"),
					resultSet.getString("grosssalaryded"),resultSet.getString("grosssalaryadd"),resultSet.getString("grosssalaryded"),resultSet.getString("netsalary"),allowancecount));
				
				}
				
				request.setAttribute("PAYSLIP", employeesPaySlip);
				
			stmtHMSP.close();
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
	 
	 public int insertion(Connection conn,int docno,Date monthlyPayrollDate,ArrayList<String> monthlypayrollarray,HttpSession session,String mode) throws SQLException{
		 JSONArray RESULTDATA=new JSONArray();
		 
		  try{
			    
			  /*Monthly Payroll Grid Saving*/
			    
			    int data=0;
			    int rowno=0; 
			    
			    
			    for(int i=0;i< monthlypayrollarray.size();i++){
			    	int rdoc=0;
				//System.out.println("docno=========="+docno);
			    	
			    	CallableStatement stmtHMSP1=null;
					Statement stmtHMSP2 = conn.createStatement();
					Statement stmtHMSP3 = conn.createStatement();
//					System.out.println("in...............insertion...."+monthlypayrollarray.size());
					String[] monthlypayroll=monthlypayrollarray.get(i).split("::");
					String empdoc=(monthlypayroll[0].trim().equalsIgnoreCase("undefined") || monthlypayroll[0].trim().equalsIgnoreCase("NaN") || monthlypayroll[0].trim().equalsIgnoreCase("") ||monthlypayroll[0].trim().isEmpty()?0:monthlypayroll[0].trim()).toString();
					 int emp=Integer.parseInt(empdoc);
					String sqlchk = "select rdocno from hr_payrolld where empid='"+empdoc+"' and rdocno="+docno+"";
					
//						System.out.println("sqlchk==========="+sqlchk);
						ResultSet resultSet1 = stmtHMSP2.executeQuery(sqlchk);
						
						
						while(resultSet1.next()){
							rdoc=resultSet1.getInt("rdocno");
//							System.out.println("rdocno==========="+rdoc);
						}
                        
				        
				
				java.sql.Date lastPayrollDate=(monthlypayroll[1].trim().equalsIgnoreCase("undefined") || monthlypayroll[1].trim().equalsIgnoreCase("NaN") || monthlypayroll[1].trim().equalsIgnoreCase("") ||  monthlypayroll[1].trim().isEmpty()?null:ClsCommon.changetstmptoSqlDate(monthlypayroll[1].trim()));
				//rowno=monthlypayroll[47].trim().equalsIgnoreCase("undefined") || monthlypayroll[47].trim().equalsIgnoreCase("NaN")|| monthlypayroll[47].trim().equalsIgnoreCase("")|| monthlypayroll[47].isEmpty()?0:Integer.parseInt(monthlypayroll[47].trim());
				//System.out.println("rowno=========="+rowno);
				 
				 if(rdoc>0){   
					 
//					 System.out.println("IN........................UPDATE");
					 stmtHMSP1 = conn.prepareCall("update hr_payrolld set sr_no=?,empid=?,date=?,daystopay=?,leave1=?,leave2=?,leave3=?,leave4=?,leave5=?,leave6=?,leave7=?,leave8=?,leave9=?,leave10=?,basic=?,allowance1=?,allowance2=?,allowance3=?,allowance4=?,allowance5=?,allowance6=?,allowance7=?,allowance8=?,allowance9=?,allowance10=?,totalsalary=?,overtime=?,tot_hot=?,tot_ot=?,leavedeductions=?,grosssalary=?,additions=?,deductions=?,loan=?,netsalary=?,remarks=?,earnedbasic=?,earnedallowance1=?,earnedallowance2=?,earnedallowance3=?,earnedallowance4=?,earnedallowance5=?,earnedallowance6=?,earnedallowance7=?,earnedallowance8=?,earnedallowance9=?,earnedallowance10=?,earnedtotalsalary=?,rdocno=?,status=? where rdocno='"+rdoc+"' and empid="+emp+"");  
					/*stmtHMSP1.setInt(50, java.sql.Types.INTEGER); //RowNo
*/					 stmtHMSP1.setInt(1,(i+1));//srno
						stmtHMSP1.setString(2,(monthlypayroll[0].trim().equalsIgnoreCase("undefined") || monthlypayroll[0].trim().equalsIgnoreCase("NaN") || monthlypayroll[0].trim().equalsIgnoreCase("") ||monthlypayroll[0].trim().isEmpty()?0:monthlypayroll[0].trim()).toString());//empId
						stmtHMSP1.setDate(3,lastPayrollDate);//Date
						stmtHMSP1.setDouble(4,(monthlypayroll[2].trim().equalsIgnoreCase("undefined") || monthlypayroll[2].trim().equalsIgnoreCase("NaN") || monthlypayroll[2].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[2].trim())));//Days to Pay
						stmtHMSP1.setString(5,(monthlypayroll[3].trim().equalsIgnoreCase("undefined") || monthlypayroll[3].trim().equalsIgnoreCase("NaN") || monthlypayroll[3].trim().equalsIgnoreCase("") ||monthlypayroll[3].trim().isEmpty()?"0":monthlypayroll[3].trim()).toString()); //Leave 1
						stmtHMSP1.setString(6,(monthlypayroll[4].trim().equalsIgnoreCase("undefined") || monthlypayroll[4].trim().equalsIgnoreCase("NaN") || monthlypayroll[4].trim().equalsIgnoreCase("") ||monthlypayroll[4].trim().isEmpty()?"0":monthlypayroll[4].trim()).toString());//Leave 2
						stmtHMSP1.setString(7,(monthlypayroll[5].trim().equalsIgnoreCase("undefined") || monthlypayroll[5].trim().equalsIgnoreCase("NaN") || monthlypayroll[5].trim().equalsIgnoreCase("") ||monthlypayroll[5].trim().isEmpty()?"0":monthlypayroll[5].trim()).toString());//Leave 3
						stmtHMSP1.setString(8,(monthlypayroll[6].trim().equalsIgnoreCase("undefined") || monthlypayroll[6].trim().equalsIgnoreCase("NaN") || monthlypayroll[6].trim().equalsIgnoreCase("") ||monthlypayroll[6].trim().isEmpty()?"0":monthlypayroll[6].trim()).toString());//Leave 4
						stmtHMSP1.setString(9,(monthlypayroll[7].trim().equalsIgnoreCase("undefined") || monthlypayroll[7].trim().equalsIgnoreCase("NaN") || monthlypayroll[7].trim().equalsIgnoreCase("") ||monthlypayroll[7].trim().isEmpty()?"0":monthlypayroll[7].trim()).toString());//Leave 5
						stmtHMSP1.setString(10,(monthlypayroll[8].trim().equalsIgnoreCase("undefined") || monthlypayroll[8].trim().equalsIgnoreCase("NaN") || monthlypayroll[8].trim().equalsIgnoreCase("") ||monthlypayroll[8].trim().isEmpty()?"0":monthlypayroll[8].trim()).toString());//Leave 6
						stmtHMSP1.setString(11,(monthlypayroll[9].trim().equalsIgnoreCase("undefined") || monthlypayroll[9].trim().equalsIgnoreCase("NaN") || monthlypayroll[9].trim().equalsIgnoreCase("") ||monthlypayroll[9].trim().isEmpty()?"0":monthlypayroll[9].trim()).toString());//Leave 7
						stmtHMSP1.setString(12,(monthlypayroll[10].trim().equalsIgnoreCase("undefined") || monthlypayroll[10].trim().equalsIgnoreCase("NaN") || monthlypayroll[10].trim().equalsIgnoreCase("") ||monthlypayroll[10].trim().isEmpty()?"0":monthlypayroll[10].trim()).toString());//Leave 8
						stmtHMSP1.setString(13,(monthlypayroll[11].trim().equalsIgnoreCase("undefined") || monthlypayroll[11].trim().equalsIgnoreCase("NaN") || monthlypayroll[11].trim().equalsIgnoreCase("") ||monthlypayroll[11].trim().isEmpty()?"0":monthlypayroll[11].trim()).toString());//Leave 9
						stmtHMSP1.setString(14,(monthlypayroll[12].trim().equalsIgnoreCase("undefined") || monthlypayroll[12].trim().equalsIgnoreCase("NaN") || monthlypayroll[12].trim().equalsIgnoreCase("") ||monthlypayroll[12].trim().isEmpty()?"0":monthlypayroll[12].trim()).toString());//Leave 10
						stmtHMSP1.setDouble(15,(monthlypayroll[13].trim().equalsIgnoreCase("undefined") || monthlypayroll[13].trim().equalsIgnoreCase("NaN") || monthlypayroll[13].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[13].trim())));//Basic Salary
						stmtHMSP1.setDouble(16,(monthlypayroll[14].trim().equalsIgnoreCase("undefined") || monthlypayroll[14].trim().equalsIgnoreCase("NaN") || monthlypayroll[14].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[14].trim())));//Allowance 1
						stmtHMSP1.setDouble(17,(monthlypayroll[15].trim().equalsIgnoreCase("undefined") || monthlypayroll[15].trim().equalsIgnoreCase("NaN") || monthlypayroll[15].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[15].trim())));//Allowance 2
						stmtHMSP1.setDouble(18,(monthlypayroll[16].trim().equalsIgnoreCase("undefined") || monthlypayroll[16].trim().equalsIgnoreCase("NaN") || monthlypayroll[16].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[16].trim())));//Allowance 3
						stmtHMSP1.setDouble(19,(monthlypayroll[17].trim().equalsIgnoreCase("undefined") || monthlypayroll[17].trim().equalsIgnoreCase("NaN") || monthlypayroll[17].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[17].trim())));//Allowance 4
						stmtHMSP1.setDouble(20,(monthlypayroll[18].trim().equalsIgnoreCase("undefined") || monthlypayroll[18].trim().equalsIgnoreCase("NaN") || monthlypayroll[18].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[18].trim())));//Allowance 5
						stmtHMSP1.setDouble(21,(monthlypayroll[19].trim().equalsIgnoreCase("undefined") || monthlypayroll[19].trim().equalsIgnoreCase("NaN") || monthlypayroll[19].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[19].trim())));//Allowance 6
						stmtHMSP1.setDouble(22,(monthlypayroll[20].trim().equalsIgnoreCase("undefined") || monthlypayroll[20].trim().equalsIgnoreCase("NaN") || monthlypayroll[20].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[20].trim())));//Allowance 7
						stmtHMSP1.setDouble(23,(monthlypayroll[21].trim().equalsIgnoreCase("undefined") || monthlypayroll[21].trim().equalsIgnoreCase("NaN") || monthlypayroll[21].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[21].trim())));//Allowance 8
						stmtHMSP1.setDouble(24,(monthlypayroll[22].trim().equalsIgnoreCase("undefined") || monthlypayroll[22].trim().equalsIgnoreCase("NaN") || monthlypayroll[22].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[22].trim())));//Allowance 9
						stmtHMSP1.setDouble(25,(monthlypayroll[23].trim().equalsIgnoreCase("undefined") || monthlypayroll[23].trim().equalsIgnoreCase("NaN") || monthlypayroll[23].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[23].trim())));//Allowance 10
						stmtHMSP1.setDouble(26,(monthlypayroll[24].trim().equalsIgnoreCase("undefined") || monthlypayroll[24].trim().equalsIgnoreCase("NaN") || monthlypayroll[24].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[24].trim())));//Total Salary
						stmtHMSP1.setString(27,(monthlypayroll[25].trim().equalsIgnoreCase("undefined") || monthlypayroll[25].trim().equalsIgnoreCase("NaN") || monthlypayroll[25].trim().equalsIgnoreCase("") ||monthlypayroll[25].trim().isEmpty()?"":monthlypayroll[25].trim()).toString());//Over Time
						stmtHMSP1.setString(28,(monthlypayroll[26].trim().equalsIgnoreCase("undefined") || monthlypayroll[26].trim().equalsIgnoreCase("NaN") || monthlypayroll[26].trim().equalsIgnoreCase("") ||monthlypayroll[26].trim().isEmpty()?"":monthlypayroll[26].trim()).toString());//Holiday Over Time
						stmtHMSP1.setString(29,(monthlypayroll[27].trim().equalsIgnoreCase("undefined") || monthlypayroll[27].trim().equalsIgnoreCase("NaN") || monthlypayroll[27].trim().equalsIgnoreCase("") ||monthlypayroll[27].trim().isEmpty()?"":monthlypayroll[27].trim()).toString());//Total Over Time
						stmtHMSP1.setDouble(30,(monthlypayroll[28].trim().equalsIgnoreCase("undefined") || monthlypayroll[28].trim().equalsIgnoreCase("NaN") || monthlypayroll[28].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[28].trim())));//Leave Deductions
						stmtHMSP1.setDouble(31,(monthlypayroll[29].trim().equalsIgnoreCase("undefined") || monthlypayroll[29].trim().equalsIgnoreCase("NaN") || monthlypayroll[29].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[29].trim())));//Gross Salary
						stmtHMSP1.setDouble(32,(monthlypayroll[30].trim().equalsIgnoreCase("undefined") || monthlypayroll[30].trim().equalsIgnoreCase("NaN") || monthlypayroll[30].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[30].trim())));//Additions
						stmtHMSP1.setDouble(33,(monthlypayroll[31].trim().equalsIgnoreCase("undefined") || monthlypayroll[31].trim().equalsIgnoreCase("NaN") || monthlypayroll[31].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[31].trim())));//Deductions
						stmtHMSP1.setDouble(34,(monthlypayroll[32].trim().equalsIgnoreCase("undefined") || monthlypayroll[32].trim().equalsIgnoreCase("NaN") || monthlypayroll[32].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[32].trim())));//Loan
						stmtHMSP1.setDouble(35,(monthlypayroll[33].trim().equalsIgnoreCase("undefined") || monthlypayroll[33].trim().equalsIgnoreCase("NaN") || monthlypayroll[33].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[33].trim())));//Net Salary
						stmtHMSP1.setString(36,(monthlypayroll[34].trim().equalsIgnoreCase("undefined") || monthlypayroll[34].trim().equalsIgnoreCase("NaN") || monthlypayroll[34].trim().equalsIgnoreCase("") ||monthlypayroll[34].trim().isEmpty()?"":monthlypayroll[34].trim()).toString());//Description
						
						stmtHMSP1.setDouble(37,(monthlypayroll[35].trim().equalsIgnoreCase("undefined") || monthlypayroll[35].trim().equalsIgnoreCase("NaN") || monthlypayroll[35].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[35].trim())));//Earned Basic Salary
						stmtHMSP1.setDouble(38,(monthlypayroll[36].trim().equalsIgnoreCase("undefined") || monthlypayroll[36].trim().equalsIgnoreCase("NaN") || monthlypayroll[36].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[36].trim())));//Earned Allowance 1
						stmtHMSP1.setDouble(39,(monthlypayroll[37].trim().equalsIgnoreCase("undefined") || monthlypayroll[37].trim().equalsIgnoreCase("NaN") || monthlypayroll[37].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[37].trim())));//Earned Allowance 2
						stmtHMSP1.setDouble(40,(monthlypayroll[38].trim().equalsIgnoreCase("undefined") || monthlypayroll[38].trim().equalsIgnoreCase("NaN") || monthlypayroll[38].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[38].trim())));//Earned Allowance 3
						stmtHMSP1.setDouble(41,(monthlypayroll[39].trim().equalsIgnoreCase("undefined") || monthlypayroll[39].trim().equalsIgnoreCase("NaN") || monthlypayroll[39].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[39].trim())));//Earned Allowance 4
						stmtHMSP1.setDouble(42,(monthlypayroll[40].trim().equalsIgnoreCase("undefined") || monthlypayroll[40].trim().equalsIgnoreCase("NaN") || monthlypayroll[40].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[40].trim())));//Earned Allowance 5
						stmtHMSP1.setDouble(43,(monthlypayroll[41].trim().equalsIgnoreCase("undefined") || monthlypayroll[41].trim().equalsIgnoreCase("NaN") || monthlypayroll[41].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[41].trim())));//Earned Allowance 6
						stmtHMSP1.setDouble(44,(monthlypayroll[42].trim().equalsIgnoreCase("undefined") || monthlypayroll[42].trim().equalsIgnoreCase("NaN") || monthlypayroll[42].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[42].trim())));//Earned Allowance 7
						stmtHMSP1.setDouble(45,(monthlypayroll[43].trim().equalsIgnoreCase("undefined") || monthlypayroll[43].trim().equalsIgnoreCase("NaN") || monthlypayroll[43].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[43].trim())));//Earned Allowance 8
						stmtHMSP1.setDouble(46,(monthlypayroll[44].trim().equalsIgnoreCase("undefined") || monthlypayroll[44].trim().equalsIgnoreCase("NaN") || monthlypayroll[44].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[44].trim())));//Earned Allowance 9
						stmtHMSP1.setDouble(47,(monthlypayroll[45].trim().equalsIgnoreCase("undefined") || monthlypayroll[45].trim().equalsIgnoreCase("NaN") || monthlypayroll[45].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[45].trim())));//Earned Allowance 10
						stmtHMSP1.setDouble(48,(monthlypayroll[46].trim().equalsIgnoreCase("undefined") || monthlypayroll[46].trim().equalsIgnoreCase("NaN") || monthlypayroll[46].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[46].trim())));//Earned Total Salary
						
						stmtHMSP1.setInt(49,docno);//rdocno
						stmtHMSP1.setInt(50,3);//status
						//System.out.println("data update============="+stmtHMSP1);
						data = stmtHMSP1.executeUpdate();
						
				 }else{  
					    
//					 System.out.println("IN........................INSERT");
						stmtHMSP1 = conn.prepareCall("{CALL HR_payrolldDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						
						stmtHMSP1.registerOutParameter(50, java.sql.Types.INTEGER); //RowNo
						stmtHMSP1.setInt(1,(i+1));//srno       
						stmtHMSP1.setString(2,(monthlypayroll[0].trim().equalsIgnoreCase("undefined") || monthlypayroll[0].trim().equalsIgnoreCase("NaN") || monthlypayroll[0].trim().equalsIgnoreCase("") ||monthlypayroll[0].trim().isEmpty()?0:monthlypayroll[0].trim()).toString());//empId
						stmtHMSP1.setDate(3,lastPayrollDate);//Date
						stmtHMSP1.setDouble(4,(monthlypayroll[2].trim().equalsIgnoreCase("undefined") || monthlypayroll[2].trim().equalsIgnoreCase("NaN") || monthlypayroll[2].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[2].trim())));//Days to Pay
						stmtHMSP1.setString(5,(monthlypayroll[3].trim().equalsIgnoreCase("undefined") || monthlypayroll[3].trim().equalsIgnoreCase("NaN") || monthlypayroll[3].trim().equalsIgnoreCase("") ||monthlypayroll[3].trim().isEmpty()?"0":monthlypayroll[3].trim()).toString()); //Leave 1
						stmtHMSP1.setString(6,(monthlypayroll[4].trim().equalsIgnoreCase("undefined") || monthlypayroll[4].trim().equalsIgnoreCase("NaN") || monthlypayroll[4].trim().equalsIgnoreCase("") ||monthlypayroll[4].trim().isEmpty()?"0":monthlypayroll[4].trim()).toString());//Leave 2
						stmtHMSP1.setString(7,(monthlypayroll[5].trim().equalsIgnoreCase("undefined") || monthlypayroll[5].trim().equalsIgnoreCase("NaN") || monthlypayroll[5].trim().equalsIgnoreCase("") ||monthlypayroll[5].trim().isEmpty()?"0":monthlypayroll[5].trim()).toString());//Leave 3
						stmtHMSP1.setString(8,(monthlypayroll[6].trim().equalsIgnoreCase("undefined") || monthlypayroll[6].trim().equalsIgnoreCase("NaN") || monthlypayroll[6].trim().equalsIgnoreCase("") ||monthlypayroll[6].trim().isEmpty()?"0":monthlypayroll[6].trim()).toString());//Leave 4
						stmtHMSP1.setString(9,(monthlypayroll[7].trim().equalsIgnoreCase("undefined") || monthlypayroll[7].trim().equalsIgnoreCase("NaN") || monthlypayroll[7].trim().equalsIgnoreCase("") ||monthlypayroll[7].trim().isEmpty()?"0":monthlypayroll[7].trim()).toString());//Leave 5
						stmtHMSP1.setString(10,(monthlypayroll[8].trim().equalsIgnoreCase("undefined") || monthlypayroll[8].trim().equalsIgnoreCase("NaN") || monthlypayroll[8].trim().equalsIgnoreCase("") ||monthlypayroll[8].trim().isEmpty()?"0":monthlypayroll[8].trim()).toString());//Leave 6
						stmtHMSP1.setString(11,(monthlypayroll[9].trim().equalsIgnoreCase("undefined") || monthlypayroll[9].trim().equalsIgnoreCase("NaN") || monthlypayroll[9].trim().equalsIgnoreCase("") ||monthlypayroll[9].trim().isEmpty()?"0":monthlypayroll[9].trim()).toString());//Leave 7
						stmtHMSP1.setString(12,(monthlypayroll[10].trim().equalsIgnoreCase("undefined") || monthlypayroll[10].trim().equalsIgnoreCase("NaN") || monthlypayroll[10].trim().equalsIgnoreCase("") ||monthlypayroll[10].trim().isEmpty()?"0":monthlypayroll[10].trim()).toString());//Leave 8
						stmtHMSP1.setString(13,(monthlypayroll[11].trim().equalsIgnoreCase("undefined") || monthlypayroll[11].trim().equalsIgnoreCase("NaN") || monthlypayroll[11].trim().equalsIgnoreCase("") ||monthlypayroll[11].trim().isEmpty()?"0":monthlypayroll[11].trim()).toString());//Leave 9
						stmtHMSP1.setString(14,(monthlypayroll[12].trim().equalsIgnoreCase("undefined") || monthlypayroll[12].trim().equalsIgnoreCase("NaN") || monthlypayroll[12].trim().equalsIgnoreCase("") ||monthlypayroll[12].trim().isEmpty()?"0":monthlypayroll[12].trim()).toString());//Leave 10
						stmtHMSP1.setDouble(15,(monthlypayroll[13].trim().equalsIgnoreCase("undefined") || monthlypayroll[13].trim().equalsIgnoreCase("NaN") || monthlypayroll[13].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[13].trim())));//Basic Salary
						stmtHMSP1.setDouble(16,(monthlypayroll[14].trim().equalsIgnoreCase("undefined") || monthlypayroll[14].trim().equalsIgnoreCase("NaN") || monthlypayroll[14].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[14].trim())));//Allowance 1
						stmtHMSP1.setDouble(17,(monthlypayroll[15].trim().equalsIgnoreCase("undefined") || monthlypayroll[15].trim().equalsIgnoreCase("NaN") || monthlypayroll[15].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[15].trim())));//Allowance 2
						stmtHMSP1.setDouble(18,(monthlypayroll[16].trim().equalsIgnoreCase("undefined") || monthlypayroll[16].trim().equalsIgnoreCase("NaN") || monthlypayroll[16].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[16].trim())));//Allowance 3
						stmtHMSP1.setDouble(19,(monthlypayroll[17].trim().equalsIgnoreCase("undefined") || monthlypayroll[17].trim().equalsIgnoreCase("NaN") || monthlypayroll[17].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[17].trim())));//Allowance 4
						stmtHMSP1.setDouble(20,(monthlypayroll[18].trim().equalsIgnoreCase("undefined") || monthlypayroll[18].trim().equalsIgnoreCase("NaN") || monthlypayroll[18].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[18].trim())));//Allowance 5
						stmtHMSP1.setDouble(21,(monthlypayroll[19].trim().equalsIgnoreCase("undefined") || monthlypayroll[19].trim().equalsIgnoreCase("NaN") || monthlypayroll[19].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[19].trim())));//Allowance 6
						stmtHMSP1.setDouble(22,(monthlypayroll[20].trim().equalsIgnoreCase("undefined") || monthlypayroll[20].trim().equalsIgnoreCase("NaN") || monthlypayroll[20].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[20].trim())));//Allowance 7
						stmtHMSP1.setDouble(23,(monthlypayroll[21].trim().equalsIgnoreCase("undefined") || monthlypayroll[21].trim().equalsIgnoreCase("NaN") || monthlypayroll[21].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[21].trim())));//Allowance 8
						stmtHMSP1.setDouble(24,(monthlypayroll[22].trim().equalsIgnoreCase("undefined") || monthlypayroll[22].trim().equalsIgnoreCase("NaN") || monthlypayroll[22].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[22].trim())));//Allowance 9
						stmtHMSP1.setDouble(25,(monthlypayroll[23].trim().equalsIgnoreCase("undefined") || monthlypayroll[23].trim().equalsIgnoreCase("NaN") || monthlypayroll[23].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[23].trim())));//Allowance 10
						stmtHMSP1.setDouble(26,(monthlypayroll[24].trim().equalsIgnoreCase("undefined") || monthlypayroll[24].trim().equalsIgnoreCase("NaN") || monthlypayroll[24].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[24].trim())));//Total Salary
						stmtHMSP1.setString(27,(monthlypayroll[25].trim().equalsIgnoreCase("undefined") || monthlypayroll[25].trim().equalsIgnoreCase("NaN") || monthlypayroll[25].trim().equalsIgnoreCase("") ||monthlypayroll[25].trim().isEmpty()?"00:00":monthlypayroll[25].trim()).toString());//Over Time
						stmtHMSP1.setString(28,(monthlypayroll[26].trim().equalsIgnoreCase("undefined") || monthlypayroll[26].trim().equalsIgnoreCase("NaN") || monthlypayroll[26].trim().equalsIgnoreCase("") ||monthlypayroll[26].trim().isEmpty()?"00:00":monthlypayroll[26].trim()).toString());//Holiday Over Time
						stmtHMSP1.setDouble(29,(monthlypayroll[27].trim().equalsIgnoreCase("undefined") || monthlypayroll[27].trim().equalsIgnoreCase("NaN") || monthlypayroll[27].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[27].trim())));//Total Over Time
						stmtHMSP1.setDouble(30,(monthlypayroll[28].trim().equalsIgnoreCase("undefined") || monthlypayroll[28].trim().equalsIgnoreCase("NaN") || monthlypayroll[28].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[28].trim())));//Leave Deductions
						stmtHMSP1.setDouble(31,(monthlypayroll[29].trim().equalsIgnoreCase("undefined") || monthlypayroll[29].trim().equalsIgnoreCase("NaN") || monthlypayroll[29].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[29].trim())));//Gross Salary
						stmtHMSP1.setDouble(32,(monthlypayroll[30].trim().equalsIgnoreCase("undefined") || monthlypayroll[30].trim().equalsIgnoreCase("NaN") || monthlypayroll[30].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[30].trim())));//Additions
						stmtHMSP1.setDouble(33,(monthlypayroll[31].trim().equalsIgnoreCase("undefined") || monthlypayroll[31].trim().equalsIgnoreCase("NaN") || monthlypayroll[31].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[31].trim())));//Deductions
						stmtHMSP1.setDouble(34,(monthlypayroll[32].trim().equalsIgnoreCase("undefined") || monthlypayroll[32].trim().equalsIgnoreCase("NaN") || monthlypayroll[32].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[32].trim())));//Loan
						stmtHMSP1.setDouble(35,(monthlypayroll[33].trim().equalsIgnoreCase("undefined") || monthlypayroll[33].trim().equalsIgnoreCase("NaN") || monthlypayroll[33].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[33].trim())));//Net Salary
						stmtHMSP1.setString(36,(monthlypayroll[34].trim().equalsIgnoreCase("undefined") || monthlypayroll[34].trim().equalsIgnoreCase("NaN") || monthlypayroll[34].trim().equalsIgnoreCase("") ||monthlypayroll[34].trim().isEmpty()?"":monthlypayroll[34].trim()).toString());//Description
						
						stmtHMSP1.setDouble(37,(monthlypayroll[35].trim().equalsIgnoreCase("undefined") || monthlypayroll[35].trim().equalsIgnoreCase("NaN") || monthlypayroll[35].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[35].trim())));//Earned Basic Salary
						stmtHMSP1.setDouble(38,(monthlypayroll[36].trim().equalsIgnoreCase("undefined") || monthlypayroll[36].trim().equalsIgnoreCase("NaN") || monthlypayroll[36].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[36].trim())));//Earned Allowance 1
						stmtHMSP1.setDouble(39,(monthlypayroll[37].trim().equalsIgnoreCase("undefined") || monthlypayroll[37].trim().equalsIgnoreCase("NaN") || monthlypayroll[37].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[37].trim())));//Earned Allowance 2
						stmtHMSP1.setDouble(40,(monthlypayroll[38].trim().equalsIgnoreCase("undefined") || monthlypayroll[38].trim().equalsIgnoreCase("NaN") || monthlypayroll[38].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[38].trim())));//Earned Allowance 3
						stmtHMSP1.setDouble(41,(monthlypayroll[39].trim().equalsIgnoreCase("undefined") || monthlypayroll[39].trim().equalsIgnoreCase("NaN") || monthlypayroll[39].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[39].trim())));//Earned Allowance 4
						stmtHMSP1.setDouble(42,(monthlypayroll[40].trim().equalsIgnoreCase("undefined") || monthlypayroll[40].trim().equalsIgnoreCase("NaN") || monthlypayroll[40].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[40].trim())));//Earned Allowance 5
						stmtHMSP1.setDouble(43,(monthlypayroll[41].trim().equalsIgnoreCase("undefined") || monthlypayroll[41].trim().equalsIgnoreCase("NaN") || monthlypayroll[41].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[41].trim())));//Earned Allowance 6
						stmtHMSP1.setDouble(44,(monthlypayroll[42].trim().equalsIgnoreCase("undefined") || monthlypayroll[42].trim().equalsIgnoreCase("NaN") || monthlypayroll[42].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[42].trim())));//Earned Allowance 7
						stmtHMSP1.setDouble(45,(monthlypayroll[43].trim().equalsIgnoreCase("undefined") || monthlypayroll[43].trim().equalsIgnoreCase("NaN") || monthlypayroll[43].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[43].trim())));//Earned Allowance 8
						stmtHMSP1.setDouble(46,(monthlypayroll[44].trim().equalsIgnoreCase("undefined") || monthlypayroll[44].trim().equalsIgnoreCase("NaN") || monthlypayroll[44].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[44].trim())));//Earned Allowance 9
						stmtHMSP1.setDouble(47,(monthlypayroll[45].trim().equalsIgnoreCase("undefined") || monthlypayroll[45].trim().equalsIgnoreCase("NaN") || monthlypayroll[45].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[45].trim())));//Earned Allowance 10
						stmtHMSP1.setDouble(48,(monthlypayroll[46].trim().equalsIgnoreCase("undefined") || monthlypayroll[46].trim().equalsIgnoreCase("NaN") || monthlypayroll[46].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[46].trim())));//Earned Total Salary
						stmtHMSP1.setInt(49,docno);
						stmtHMSP1.setString(51,mode);
//					    System.out.println("avail data===== "+stmtHMSP1);
						data = stmtHMSP1.executeUpdate();
//						System.out.println("data===== "+data);
				 }
				
				
				
				/*if(!monthlypayroll[0].equalsIgnoreCase("undefined") && !monthlypayroll[0].equalsIgnoreCase("NaN")){
					
					java.sql.Date lastPayrollDate=(monthlypayroll[1].trim().equalsIgnoreCase("undefined") || monthlypayroll[1].trim().equalsIgnoreCase("NaN") || monthlypayroll[1].trim().equalsIgnoreCase("") ||  monthlypayroll[1].trim().isEmpty()?null:ClsCommon.changetstmptoSqlDate(monthlypayroll[1].trim()));
					
					stmtHMSP1 = conn.prepareCall("{CALL HR_payrolldDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					stmtHMSP1.registerOutParameter(50, java.sql.Types.INTEGER); //RowNo
					
					stmtHMSP1.setInt(1,(i+1));//srno
					stmtHMSP1.setString(2,(monthlypayroll[0].trim().equalsIgnoreCase("undefined") || monthlypayroll[0].trim().equalsIgnoreCase("NaN") || monthlypayroll[0].trim().equalsIgnoreCase("") ||monthlypayroll[0].trim().isEmpty()?0:monthlypayroll[0].trim()).toString());//empId
					stmtHMSP1.setDate(3,lastPayrollDate);//Date
					stmtHMSP1.setDouble(4,(monthlypayroll[2].trim().equalsIgnoreCase("undefined") || monthlypayroll[2].trim().equalsIgnoreCase("NaN") || monthlypayroll[2].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[2].trim())));//Days to Pay
					stmtHMSP1.setString(5,(monthlypayroll[3].trim().equalsIgnoreCase("undefined") || monthlypayroll[3].trim().equalsIgnoreCase("NaN") || monthlypayroll[3].trim().equalsIgnoreCase("") ||monthlypayroll[3].trim().isEmpty()?"0":monthlypayroll[3].trim()).toString()); //Leave 1
					stmtHMSP1.setString(6,(monthlypayroll[4].trim().equalsIgnoreCase("undefined") || monthlypayroll[4].trim().equalsIgnoreCase("NaN") || monthlypayroll[4].trim().equalsIgnoreCase("") ||monthlypayroll[4].trim().isEmpty()?"0":monthlypayroll[4].trim()).toString());//Leave 2
					stmtHMSP1.setString(7,(monthlypayroll[5].trim().equalsIgnoreCase("undefined") || monthlypayroll[5].trim().equalsIgnoreCase("NaN") || monthlypayroll[5].trim().equalsIgnoreCase("") ||monthlypayroll[5].trim().isEmpty()?"0":monthlypayroll[5].trim()).toString());//Leave 3
					stmtHMSP1.setString(8,(monthlypayroll[6].trim().equalsIgnoreCase("undefined") || monthlypayroll[6].trim().equalsIgnoreCase("NaN") || monthlypayroll[6].trim().equalsIgnoreCase("") ||monthlypayroll[6].trim().isEmpty()?"0":monthlypayroll[6].trim()).toString());//Leave 4
					stmtHMSP1.setString(9,(monthlypayroll[7].trim().equalsIgnoreCase("undefined") || monthlypayroll[7].trim().equalsIgnoreCase("NaN") || monthlypayroll[7].trim().equalsIgnoreCase("") ||monthlypayroll[7].trim().isEmpty()?"0":monthlypayroll[7].trim()).toString());//Leave 5
					stmtHMSP1.setString(10,(monthlypayroll[8].trim().equalsIgnoreCase("undefined") || monthlypayroll[8].trim().equalsIgnoreCase("NaN") || monthlypayroll[8].trim().equalsIgnoreCase("") ||monthlypayroll[8].trim().isEmpty()?"0":monthlypayroll[8].trim()).toString());//Leave 6
					stmtHMSP1.setString(11,(monthlypayroll[9].trim().equalsIgnoreCase("undefined") || monthlypayroll[9].trim().equalsIgnoreCase("NaN") || monthlypayroll[9].trim().equalsIgnoreCase("") ||monthlypayroll[9].trim().isEmpty()?"0":monthlypayroll[9].trim()).toString());//Leave 7
					stmtHMSP1.setString(12,(monthlypayroll[10].trim().equalsIgnoreCase("undefined") || monthlypayroll[10].trim().equalsIgnoreCase("NaN") || monthlypayroll[10].trim().equalsIgnoreCase("") ||monthlypayroll[10].trim().isEmpty()?"0":monthlypayroll[10].trim()).toString());//Leave 8
					stmtHMSP1.setString(13,(monthlypayroll[11].trim().equalsIgnoreCase("undefined") || monthlypayroll[11].trim().equalsIgnoreCase("NaN") || monthlypayroll[11].trim().equalsIgnoreCase("") ||monthlypayroll[11].trim().isEmpty()?"0":monthlypayroll[11].trim()).toString());//Leave 9
					stmtHMSP1.setString(14,(monthlypayroll[12].trim().equalsIgnoreCase("undefined") || monthlypayroll[12].trim().equalsIgnoreCase("NaN") || monthlypayroll[12].trim().equalsIgnoreCase("") ||monthlypayroll[12].trim().isEmpty()?"0":monthlypayroll[12].trim()).toString());//Leave 10
					stmtHMSP1.setDouble(15,(monthlypayroll[13].trim().equalsIgnoreCase("undefined") || monthlypayroll[13].trim().equalsIgnoreCase("NaN") || monthlypayroll[13].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[13].trim())));//Basic Salary
					stmtHMSP1.setDouble(16,(monthlypayroll[14].trim().equalsIgnoreCase("undefined") || monthlypayroll[14].trim().equalsIgnoreCase("NaN") || monthlypayroll[14].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[14].trim())));//Allowance 1
					stmtHMSP1.setDouble(17,(monthlypayroll[15].trim().equalsIgnoreCase("undefined") || monthlypayroll[15].trim().equalsIgnoreCase("NaN") || monthlypayroll[15].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[15].trim())));//Allowance 2
					stmtHMSP1.setDouble(18,(monthlypayroll[16].trim().equalsIgnoreCase("undefined") || monthlypayroll[16].trim().equalsIgnoreCase("NaN") || monthlypayroll[16].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[16].trim())));//Allowance 3
					stmtHMSP1.setDouble(19,(monthlypayroll[17].trim().equalsIgnoreCase("undefined") || monthlypayroll[17].trim().equalsIgnoreCase("NaN") || monthlypayroll[17].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[17].trim())));//Allowance 4
					stmtHMSP1.setDouble(20,(monthlypayroll[18].trim().equalsIgnoreCase("undefined") || monthlypayroll[18].trim().equalsIgnoreCase("NaN") || monthlypayroll[18].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[18].trim())));//Allowance 5
					stmtHMSP1.setDouble(21,(monthlypayroll[19].trim().equalsIgnoreCase("undefined") || monthlypayroll[19].trim().equalsIgnoreCase("NaN") || monthlypayroll[19].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[19].trim())));//Allowance 6
					stmtHMSP1.setDouble(22,(monthlypayroll[20].trim().equalsIgnoreCase("undefined") || monthlypayroll[20].trim().equalsIgnoreCase("NaN") || monthlypayroll[20].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[20].trim())));//Allowance 7
					stmtHMSP1.setDouble(23,(monthlypayroll[21].trim().equalsIgnoreCase("undefined") || monthlypayroll[21].trim().equalsIgnoreCase("NaN") || monthlypayroll[21].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[21].trim())));//Allowance 8
					stmtHMSP1.setDouble(24,(monthlypayroll[22].trim().equalsIgnoreCase("undefined") || monthlypayroll[22].trim().equalsIgnoreCase("NaN") || monthlypayroll[22].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[22].trim())));//Allowance 9
					stmtHMSP1.setDouble(25,(monthlypayroll[23].trim().equalsIgnoreCase("undefined") || monthlypayroll[23].trim().equalsIgnoreCase("NaN") || monthlypayroll[23].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[23].trim())));//Allowance 10
					stmtHMSP1.setDouble(26,(monthlypayroll[24].trim().equalsIgnoreCase("undefined") || monthlypayroll[24].trim().equalsIgnoreCase("NaN") || monthlypayroll[24].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[24].trim())));//Total Salary
					stmtHMSP1.setString(27,(monthlypayroll[25].trim().equalsIgnoreCase("undefined") || monthlypayroll[25].trim().equalsIgnoreCase("NaN") || monthlypayroll[25].trim().equalsIgnoreCase("") ||monthlypayroll[25].trim().isEmpty()?"00:00":monthlypayroll[25].trim()).toString());//Over Time
					stmtHMSP1.setString(28,(monthlypayroll[26].trim().equalsIgnoreCase("undefined") || monthlypayroll[26].trim().equalsIgnoreCase("NaN") || monthlypayroll[26].trim().equalsIgnoreCase("") ||monthlypayroll[26].trim().isEmpty()?"00:00":monthlypayroll[26].trim()).toString());//Holiday Over Time
					stmtHMSP1.setDouble(29,(monthlypayroll[27].trim().equalsIgnoreCase("undefined") || monthlypayroll[27].trim().equalsIgnoreCase("NaN") || monthlypayroll[27].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[27].trim())));//Total Over Time
					stmtHMSP1.setDouble(30,(monthlypayroll[28].trim().equalsIgnoreCase("undefined") || monthlypayroll[28].trim().equalsIgnoreCase("NaN") || monthlypayroll[28].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[28].trim())));//Leave Deductions
					stmtHMSP1.setDouble(31,(monthlypayroll[29].trim().equalsIgnoreCase("undefined") || monthlypayroll[29].trim().equalsIgnoreCase("NaN") || monthlypayroll[29].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[29].trim())));//Gross Salary
					stmtHMSP1.setDouble(32,(monthlypayroll[30].trim().equalsIgnoreCase("undefined") || monthlypayroll[30].trim().equalsIgnoreCase("NaN") || monthlypayroll[30].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[30].trim())));//Additions
					stmtHMSP1.setDouble(33,(monthlypayroll[31].trim().equalsIgnoreCase("undefined") || monthlypayroll[31].trim().equalsIgnoreCase("NaN") || monthlypayroll[31].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[31].trim())));//Deductions
					stmtHMSP1.setDouble(34,(monthlypayroll[32].trim().equalsIgnoreCase("undefined") || monthlypayroll[32].trim().equalsIgnoreCase("NaN") || monthlypayroll[32].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[32].trim())));//Loan
					stmtHMSP1.setDouble(35,(monthlypayroll[33].trim().equalsIgnoreCase("undefined") || monthlypayroll[33].trim().equalsIgnoreCase("NaN") || monthlypayroll[33].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[33].trim())));//Net Salary
					stmtHMSP1.setString(36,(monthlypayroll[34].trim().equalsIgnoreCase("undefined") || monthlypayroll[34].trim().equalsIgnoreCase("NaN") || monthlypayroll[34].trim().equalsIgnoreCase("") ||monthlypayroll[34].trim().isEmpty()?"":monthlypayroll[34].trim()).toString());//Description
					
					stmtHMSP1.setDouble(37,(monthlypayroll[35].trim().equalsIgnoreCase("undefined") || monthlypayroll[35].trim().equalsIgnoreCase("NaN") || monthlypayroll[35].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[35].trim())));//Earned Basic Salary
					stmtHMSP1.setDouble(38,(monthlypayroll[36].trim().equalsIgnoreCase("undefined") || monthlypayroll[36].trim().equalsIgnoreCase("NaN") || monthlypayroll[36].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[36].trim())));//Earned Allowance 1
					stmtHMSP1.setDouble(39,(monthlypayroll[37].trim().equalsIgnoreCase("undefined") || monthlypayroll[37].trim().equalsIgnoreCase("NaN") || monthlypayroll[37].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[37].trim())));//Earned Allowance 2
					stmtHMSP1.setDouble(40,(monthlypayroll[38].trim().equalsIgnoreCase("undefined") || monthlypayroll[38].trim().equalsIgnoreCase("NaN") || monthlypayroll[38].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[38].trim())));//Earned Allowance 3
					stmtHMSP1.setDouble(41,(monthlypayroll[39].trim().equalsIgnoreCase("undefined") || monthlypayroll[39].trim().equalsIgnoreCase("NaN") || monthlypayroll[39].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[39].trim())));//Earned Allowance 4
					stmtHMSP1.setDouble(42,(monthlypayroll[40].trim().equalsIgnoreCase("undefined") || monthlypayroll[40].trim().equalsIgnoreCase("NaN") || monthlypayroll[40].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[40].trim())));//Earned Allowance 5
					stmtHMSP1.setDouble(43,(monthlypayroll[41].trim().equalsIgnoreCase("undefined") || monthlypayroll[41].trim().equalsIgnoreCase("NaN") || monthlypayroll[41].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[41].trim())));//Earned Allowance 6
					stmtHMSP1.setDouble(44,(monthlypayroll[42].trim().equalsIgnoreCase("undefined") || monthlypayroll[42].trim().equalsIgnoreCase("NaN") || monthlypayroll[42].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[42].trim())));//Earned Allowance 7
					stmtHMSP1.setDouble(45,(monthlypayroll[43].trim().equalsIgnoreCase("undefined") || monthlypayroll[43].trim().equalsIgnoreCase("NaN") || monthlypayroll[43].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[43].trim())));//Earned Allowance 8
					stmtHMSP1.setDouble(46,(monthlypayroll[44].trim().equalsIgnoreCase("undefined") || monthlypayroll[44].trim().equalsIgnoreCase("NaN") || monthlypayroll[44].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[44].trim())));//Earned Allowance 9
					stmtHMSP1.setDouble(47,(monthlypayroll[45].trim().equalsIgnoreCase("undefined") || monthlypayroll[45].trim().equalsIgnoreCase("NaN") || monthlypayroll[45].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[45].trim())));//Earned Allowance 10
					stmtHMSP1.setDouble(48,(monthlypayroll[46].trim().equalsIgnoreCase("undefined") || monthlypayroll[46].trim().equalsIgnoreCase("NaN") || monthlypayroll[46].trim().isEmpty()?0.0:Double.parseDouble(monthlypayroll[46].trim())));//Earned Total Salary
					
					stmtHMSP1.setInt(49,docno);
					stmtHMSP1.setString(51,mode);
					
				    System.out.println("===== "+stmtHMSP1);
					data = stmtHMSP1.executeUpdate();
				 }*/
				if(data<=0){
					stmtHMSP1.close();
					conn.close();
					return 0;
				}
				
				/*Updating hr_empm*/
				String sql=("update hr_empm set salary_paid='"+monthlyPayrollDate+"' where doc_no='"+(monthlypayroll[0].trim().equalsIgnoreCase("undefined") || monthlypayroll[0].trim().equalsIgnoreCase("NaN") || monthlypayroll[0].trim().equalsIgnoreCase("") ||monthlypayroll[0].trim().isEmpty()?0:monthlypayroll[0].trim()).toString()+"'");
//				System.out.println("sql===== "+sql);
				int data1 = stmtHMSP2.executeUpdate(sql);
//				System.out.println("data1===== "+data1);
				if(data1<=0){
					stmtHMSP2.close();
					conn.close();
					return 0;
				}
				/*Updating hr_empm Ends*/
				
				/*Updating hr_tmesheet*/
				String sql1=("update hr_timesheet set payroll_processed=1, payroll_confirmed=0 where  payroll_confirmed=0 and month=MONTH('"+monthlyPayrollDate+"') and year=YEAR('"+monthlyPayrollDate+"') and empid='"+(monthlypayroll[0].trim().equalsIgnoreCase("undefined") || monthlypayroll[0].trim().equalsIgnoreCase("NaN") || monthlypayroll[0].trim().equalsIgnoreCase("") ||monthlypayroll[0].trim().isEmpty()?0:monthlypayroll[0].trim()).toString()+"'");
//				System.out.println("sql1===== "+sql1);
				int data2 = stmtHMSP3.executeUpdate(sql1);
//				System.out.println("data2===== "+data2);
				if(data2<=0){
					stmtHMSP3.close();
					conn.close();
					return 0;
				}
				/*Updating hr_tmesheet Ends*/
				
				stmtHMSP1.close();
				stmtHMSP2.close();
				stmtHMSP3.close();
				}
				/*Monthly Payroll Grid Saving Ends*/
				
	   } catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}
 public ClsMonthlyPayrollBean getPrint2(HttpServletRequest request,String docNo,int branch,int header,String mode,String date,String category,String empid,String check) throws SQLException {
		 ClsMonthlyPayrollBean bean = new ClsMonthlyPayrollBean();           
		 Connection conn = null;
		 //System.out.println("IN print Dao");
		try { 
			conn = ClsConnection.getMyConnection();
			Statement stmtss = conn.createStatement();
			java.sql.Date sqlDate=null;
			String docno="0",empId="0";
			docno=docNo;
			empId=empid;  
			date.trim();
	        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))) {
	        	sqlDate = ClsCommon.changeStringtoSqlDate(date);
	        }
	        String headersql="select 'Monthly Payroll' vouchername,DATE_FORMAT('"+sqlDate+"','%M  %Y ') vouchername1,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
					+ "b.cstno from my_brch b inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where b.doc_no="+branch+"";
	            //System.out.println("headersql====="+headersql);       
				ResultSet resultSetHead = stmtss.executeQuery(headersql);
				
				while(resultSetHead.next()){   
					
					bean.setLblcompname(resultSetHead.getString("company"));
					bean.setLblcompaddress(resultSetHead.getString("address"));
					bean.setLblprintname(resultSetHead.getString("vouchername"));
					bean.setLblprintname1(resultSetHead.getString("vouchername1"));
					bean.setLblcomptel(resultSetHead.getString("tel"));
					bean.setLblcompfax(resultSetHead.getString("fax"));
					bean.setLblbranch(resultSetHead.getString("branchname"));
					bean.setLbllocation(resultSetHead.getString("location"));
					bean.setLblcstno(resultSetHead.getString("cstno"));
					bean.setLblpan(resultSetHead.getString("pbno"));
					bean.setLblservicetax(resultSetHead.getString("stcno"));
					bean.setLblpobox(resultSetHead.getString("pbno"));
				}
			
			String sqls="select u.user_name preparedby,COALESCE(u1.user_name,'') verifiedappr,COALESCE(u2.user_name,'') approved from hr_payroll m left join my_exdet ext on (m.doc_no=ext.doc_no and m.dtype=ext.dtype and ext.apprstatus=2) "
					+ "left join my_exdet ext1 on (m.doc_no=ext1.doc_no and m.dtype=ext1.dtype and ext1.apprstatus=3) left join my_user u on m.userid=u.doc_no left join my_user u1 on ext.userid=u1.doc_no left join "
					+ "my_user u2 on ext1.userid=u2.doc_no where m.status<>7 and m.brhid="+branch+" and m.doc_no="+docNo+"";
			//System.out.println("sqls====="+sqls);
			ResultSet resultSets = stmtss.executeQuery(sqls);
			
			while(resultSets.next()){
				bean.setLblpreparedby(resultSets.getString("preparedby"));
				bean.setLblverifiedby(resultSets.getString("verifiedappr"));
				bean.setLblapprovedby(resultSets.getString("approved"));
			}
			
	    HttpServletRequest request2=ServletActionContext.getRequest();
		ArrayList<String> printmonthlypayroll2= new ArrayList<String>();
	   // System.out.println("mode====="+mode);	
		if(mode.equalsIgnoreCase("A")){
	        	
	        	Statement stmtHMSP = conn.createStatement();
				Statement stmtHMSP1 = conn.createStatement();
				Statement stmtHMSP2 = conn.createStatement();  
				Statement stmtHMSP3 = conn.createStatement();
				Statement stmtHMSP4 = conn.createStatement();
				Statement stmtHMSP5 = conn.createStatement();  
				
				int totleaves=0,totallowance=0;
				String dailyRateFormula="",xsql="";
				ClsCommonHR hrCalc = new ClsCommonHR();
				ArrayList<String> additionsDeductionsAmount = new ArrayList<String>();
				
				String sql="select count(doc_no) totleaves from hr_timesheetset where reftype='L'";
				ResultSet resultSet = stmtHMSP.executeQuery(sql);
				
				while(resultSet.next()){
					totleaves=resultSet.getInt("totleaves");
				}
				
				String sql1 = "select count(doc_no) totallowances from hr_setallowance where status=3 and doc_no>0";
				ResultSet resultSet1 = stmtHMSP1.executeQuery(sql1);
				
				while(resultSet1.next()) {
					totallowance=resultSet1.getInt("totallowances");
			  	}
				
				if(!(category.equalsIgnoreCase("0")) && !(category.equalsIgnoreCase(""))){
		            xsql=xsql+" and m.pay_catid = '"+category+"'";
		        }
				
				if(!(empId.equalsIgnoreCase("0")) && !(empId.equalsIgnoreCase(""))){
					
		            xsql=xsql+" and m.doc_no = '"+empId+"'";
		            
		        }
				
				String sql2="select m.doc_no employeedocno,m.codeno employeeid,m.name employeename,m.salary_paid dates,DATEDIFF('"+sqlDate+"',m.salary_paid) totaldays,if(mod(round(sum(t.tot_leave1),1),1)=0,"
						+ "round(sum(t.tot_leave1),1),round(sum(t.tot_leave1),1)) leave1,if(mod(round(sum(t.tot_leave2),1),1)=0,round(sum(t.tot_leave2),1),round(sum(t.tot_leave2),1)) leave2,"
						+ "if(mod(round(sum(t.tot_leave3),1),1)=0,round(sum(t.tot_leave3),1),round(sum(t.tot_leave3),1)) leave3,if(mod(round(sum(t.tot_leave4),1),1)=0,round(sum(t.tot_leave4),1),"
						+ "round(sum(t.tot_leave4),1)) leave4,if(mod(round(sum(t.tot_leave5),1),1)=0,round(sum(t.tot_leave5),1),round(sum(t.tot_leave5),1)) leave5,if(mod(round(sum(t.tot_leave6),1),1)=0,"
						+ "round(sum(t.tot_leave6),1),round(sum(t.tot_leave6),1)) leave6,CONVERT(if(round(t.tot_ot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(t.tot_ot*60))=8,SUBSTRING(SEC_TO_TIME(t.tot_ot*60),1,5),SUBSTRING(SEC_TO_TIME(t.tot_ot*60),1,6))),CHAR(100)) ot,"
						+ "CONVERT(if(round(t.tot_hot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(t.tot_hot*60))=8,SUBSTRING(SEC_TO_TIME(t.tot_hot*60),1,5),SUBSTRING(SEC_TO_TIME(t.tot_hot*60),1,6))),CHAR(100)) hot,"
						+ "t.payroll_processed payrollprocessed from hr_timesheet t left join hr_empm m on t.empid=m.doc_no where m.active=1 and m.status=3"+xsql+" "
						+ "and t.year=YEAR('"+sqlDate+"') and t.month=MONTH('"+sqlDate+"') group by t.empid";
				
				//System.out.println("====== "+sql2);
				
				
				ResultSet resultSet2 = stmtHMSP2.executeQuery(sql2);
                
				ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<ArrayList<String>>();
				
				String oldempid="",newempid="",empCategoryID="0",daysToPay="0";
				
				while(resultSet2.next()){
					double tlev=0.0;
					ArrayList<String> temp=new ArrayList<String>();

					newempid=resultSet2.getString("employeedocno");
					
					if(oldempid!=newempid){
						temp.add(resultSet2.getString("employeeid"));
						temp.add(resultSet2.getString("employeename"));
						daysToPay=resultSet2.getString("totaldays");
						temp.add(daysToPay);
						temp.add(resultSet2.getString("ot"));
						temp.add(resultSet2.getString("hot"));
						
						for (int l = 1; l <= totleaves; l++) {
							tlev+=resultSet2.getDouble("leave"+l);     
 						 }
						temp.add(tlev+"");	   
						String sql4 = "select pay_catid from hr_empm where doc_no="+newempid+"";
						ResultSet resultSet4 = stmtHMSP4.executeQuery(sql4);		
						
						while(resultSet4.next()){
							empCategoryID=resultSet4.getString("pay_catid");
						}
						
						String sql5 = "select dailyRate from hr_paycode where catid="+empCategoryID+" and doc_no=(select max(doc_no) from hr_paycode where catid="+empCategoryID+" and revdate<='"+sqlDate+"')";
						ResultSet resultSet5 = stmtHMSP4.executeQuery(sql5);		
						
						while(resultSet5.next()){
							dailyRateFormula=resultSet5.getString("dailyRate");
						}
						
						String sql3="select * from ( "  
								+ "select t.empid,id.rdocno,id.awlid,id.refdtype,id.addition,id.deduction,id.statutorydeduction,id.revadd,id.revded,id.revstatded from "
								+ "hr_timesheet t left join hr_incrm im on t.empid=im.empid left join hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) "
								+ "from hr_incrm where t.empid=empid) and id.refdtype!='STD' and t.empid="+newempid+" union all "
								+ "select 0 empid,0 rdocno,hrs.doc_no awlid,'ALC' refdtype,0 addition,0 deduction,0 statutorydeduction,0 revadd,0 revded,0 revstatded from "
								+ "hr_setallowance hrs where hrs.status=3 and hrs.doc_no not in (select id.awlid from hr_timesheet t left join hr_incrm im on t.empid=im.empid left join "
								+ "hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) from hr_incrm where t.empid=empid) and id.refdtype!='STD' and "
								+ "t.empid="+newempid+")) as a where a.awlid>=0 group by empid,awlid,refdtype order by refdtype,awlid";
				
						ResultSet resultSet3 = stmtHMSP3.executeQuery(sql3);		
						
						double totalsalary=0.00,otAmount=0.00,hotAmount=0.00,overTimeAmount=0.00,grossSalaryAmount=0.00,additionAmount=0.00,deductionAmount=0.00,loanAmount=0.00,netSalaryAmount=0.00;
						//System.out.println("==1=="+temp);
						double basicsalary=0.00,basicSalaryAmount=0.00,allowance=0.00,allowanceAmount=0.00,statutorydeduction=0.00;
						while(resultSet3.next()){
							//double basicsalary=0.00,basicSalaryAmount=0.00,allowance=0.00,allowanceAmount=0.00,statutorydeduction=0.00;
							
							if(resultSet3.getString("awlid").equalsIgnoreCase("0") && resultSet3.getString("refdtype").equalsIgnoreCase("0")){
								basicsalary=basicsalary+resultSet3.getDouble("revadd");
								basicsalary=basicsalary-resultSet3.getDouble("revded");
								
								//BASIC Calculation 
								//basicSalaryAmount= Double.parseDouble(hrCalc.getHRBASIC(conn,newempid,empCategoryID,sqlDate,basicsalary,daysToPay));
								//basicsalary=basicSalaryAmount;
								//BASIC Calculation Ends 
								
								//temp.add(String.valueOf(basicsalary));
								totalsalary=totalsalary+basicsalary;
								
							}
							//System.out.println("==2=="+temp);
							
							if(resultSet3.getString("refdtype").equalsIgnoreCase("ALC")){
								allowance=allowance+resultSet3.getDouble("revadd");
								allowance=allowance-resultSet3.getDouble("revded");
								
								if(dailyRateFormula.contains("GROSS")){
									
									//Allowance Calculation 
									//allowanceAmount= Double.parseDouble(hrCalc.getHRALLOWANCES(conn,newempid,empCategoryID,sqlDate,allowance,daysToPay));
									//allowance=allowanceAmount;
									//Allowance Calculation Ends 
									
									totalsalary=totalsalary+allowance;
								} else{
									totalsalary=totalsalary+allowance;
								}
								
								//temp.add(String.valueOf(allowance));
							}
							//System.out.println("==3=="+temp);  
							if(resultSet3.getString("refdtype").equalsIgnoreCase("STD")){
								statutorydeduction=statutorydeduction-resultSet3.getDouble("revstatded");
								totalsalary=totalsalary-statutorydeduction;
							}
						}
						temp.add(String.valueOf(basicsalary));
						temp.add(String.valueOf(allowance));              
						//Total Salary Calculation 
						//Total Salary Calculation Ends 
						
						String sql6="select * from ( "  
								+ "select t.empid,id.rdocno,id.awlid,id.refdtype,id.addition,id.deduction,id.statutorydeduction,id.revadd,id.revded,id.revstatded from "
								+ "hr_timesheet t left join hr_incrm im on t.empid=im.empid left join hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) "
								+ "from hr_incrm where t.empid=empid) and id.refdtype!='STD' and t.empid="+newempid+" union all "
								+ "select 0 empid,0 rdocno,hrs.doc_no awlid,'ALC' refdtype,0 addition,0 deduction,0 statutorydeduction,0 revadd,0 revded,0 revstatded from "
								+ "hr_setallowance hrs where hrs.status=3 and hrs.doc_no not in (select id.awlid from hr_timesheet t left join hr_incrm im on t.empid=im.empid left join "
								+ "hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) from hr_incrm where t.empid=empid) and id.refdtype!='STD' and "
								+ "t.empid="+newempid+")) as a where a.awlid>=0 group by empid,awlid,refdtype order by refdtype,awlid";
						//System.out.println("sql6 ==== "+sql6);
						ResultSet resultSet6 = stmtHMSP3.executeQuery(sql6);		
						
						double earnedtotalsalary=0.00;
						while(resultSet6.next()){
							double earnedbasicsalary=0.00,earnedbasicSalaryAmount=0.00,earnedallowance=0.00,earnedallowanceAmount=0.00,earnedstatutorydeduction=0.00;
							
							if(resultSet6.getString("awlid").equalsIgnoreCase("0") && resultSet6.getString("refdtype").equalsIgnoreCase("0")){
								earnedbasicsalary=earnedbasicsalary+resultSet6.getDouble("revadd");
								earnedbasicsalary=earnedbasicsalary-resultSet6.getDouble("revded");
								
								/*Earned BASIC Calculation */
								earnedbasicSalaryAmount= Double.parseDouble(hrCalc.getHREARNEDBASIC(conn,newempid,empCategoryID,sqlDate,earnedbasicsalary,daysToPay));
								earnedbasicsalary=earnedbasicSalaryAmount;
								/*Earned BASIC Calculation Ends */
								
								//temp.add(String.valueOf(earnedbasicsalary));
								earnedtotalsalary=earnedtotalsalary+earnedbasicsalary;
								
							}
							
							if(resultSet6.getString("refdtype").equalsIgnoreCase("ALC")){
								earnedallowance=earnedallowance+resultSet6.getDouble("revadd");
								earnedallowance=earnedallowance-resultSet6.getDouble("revded");
								
								if(dailyRateFormula.contains("GROSS")){
									
									/*Earned Allowance Calculation */
									earnedallowanceAmount= Double.parseDouble(hrCalc.getHREARNEDALLOWANCES(conn,newempid,empCategoryID,sqlDate,earnedallowance,daysToPay,resultSet6.getString("awlid")));
									earnedallowance=earnedallowanceAmount;
									/*Earned Allowance Calculation Ends */
									
									earnedtotalsalary = earnedtotalsalary+earnedallowance;
								} else{
									earnedtotalsalary = earnedtotalsalary+earnedallowance;
								}
								  
								//temp.add(String.valueOf(earnedallowance));
							}
							
							if(resultSet6.getString("refdtype").equalsIgnoreCase("STD")){
								earnedstatutorydeduction=earnedstatutorydeduction-resultSet6.getDouble("revstatded");
								earnedtotalsalary=earnedtotalsalary-earnedstatutorydeduction;
							}
						}
						//Earned Total Salary Calculation 
						//Earned Total Salary Calculation Ends 
						
						//OT Calculation 
						otAmount= Double.parseDouble(hrCalc.getHROT(conn,newempid,empCategoryID,sqlDate));
						//OT Calculation Ends 

						//HOT Calculation 
						hotAmount= Double.parseDouble(hrCalc.getHRHOT(conn,newempid,empCategoryID,sqlDate));
						//HOT Calculation Ends 
						
						//Over Time Calculation 
						overTimeAmount=otAmount+hotAmount;
						temp.add(String.valueOf(overTimeAmount));
						//Holiday Over Time Calculation Ends 
						
						//Leave Deductions Calculation 
						//leaveDeductionsAmount=Double.parseDouble(hrCalc.getHRLeaveDeductions(conn,newempid,empCategoryID,sqlDate));
						//Leave Deductions Calculation Ends 

						//Gross Salary Calculation 
						//System.out.println("in===1==="+earnedtotalsalary+"===0v=="+overTimeAmount);
						grossSalaryAmount=Math.round(earnedtotalsalary+overTimeAmount);
						temp.add(String.valueOf(grossSalaryAmount));
						//Gross Salary Calculation Ends 
						
						//Additions and Deductions Calculation 
						additionsDeductionsAmount=hrCalc.getHRAdditionsDeductions(conn,newempid,sqlDate);
						if(additionsDeductionsAmount.size()>0){
							String[] additionsDeductions=additionsDeductionsAmount.get(0).split("::");
							additionAmount = ((additionsDeductions[0].isEmpty()?0.0:Double.parseDouble(additionsDeductions[0])));
							deductionAmount = ((additionsDeductions[1].isEmpty()?0.0:Double.parseDouble(additionsDeductions[1])));
							temp.add(String.valueOf(additionAmount));
							temp.add(String.valueOf(deductionAmount));
						} 
						//Additions and Deductions Calculation Ends 
						
						//Loan Amount Calculation
						loanAmount= Double.parseDouble(hrCalc.getHRLoanAmount(conn,newempid,sqlDate));
						temp.add(String.valueOf(loanAmount));
						//Loan Amount Calculation Ends
						
						//Net Salary Amount Calculation 
						netSalaryAmount=(((grossSalaryAmount+additionAmount)-(deductionAmount))-(loanAmount));
						temp.add(String.valueOf(netSalaryAmount));
						//Net Salary Amount Calculation Ends
						
						temp.add("Payroll Processed on "+date+"");
					
						oldempid=newempid;
					}
					
					analysisrowarray.add(temp);  
					
				}
		
				ArrayList<String> employeeIDTerminatedToBeProcessed = new ArrayList<String>();
				String sql7="";
				
				if(!(category.equalsIgnoreCase("0")) && !(category.equalsIgnoreCase(""))){
					sql7=sql7+" and m.pay_catid = '"+category+"'";
		        }
				
				sql7 = "select t.empid from hr_timesheet t left join hr_empm m on (t.empid=m.doc_no and t.year=YEAR('"+sqlDate+"') and t.month=MONTH('"+sqlDate+"')) where m.status=7 and m.active=0 and t.payroll_processed=0 and t.payroll_confirmed=0 and t.month=MONTH('"+sqlDate+"') and t.year=YEAR('"+sqlDate+"') and MONTH(m.terminated_date)=MONTH('"+sqlDate+"') and YEAR(m.terminated_date)=YEAR('"+sqlDate+"')"+sql7+"";
				ResultSet resultSet7 = stmtHMSP3.executeQuery(sql7);
				
				while(resultSet7.next()){
					employeeIDTerminatedToBeProcessed.add(resultSet7.getString("empid"));
				}
				
				//Terminated Salary processing
				if(employeeIDTerminatedToBeProcessed.size()>0){
					
					Statement stmtHMSP9 = conn.createStatement();
					Statement stmtHMSP10 = conn.createStatement();
					Statement stmtHMSP11 = conn.createStatement();
					Statement stmtHMSP12 = conn.createStatement();
					Statement stmtHMSP13 = conn.createStatement();
					
					
					String terminatedDailyRateFormula="",xsql1="";
					ArrayList<String> terminatedAdditionsDeductionsAmount = new ArrayList<String>();
					
					for(int j=0;j< employeeIDTerminatedToBeProcessed.size();j++){
						
						if(!(category.equalsIgnoreCase("0")) && !(category.equalsIgnoreCase(""))){
							xsql1=xsql1+" and m.pay_catid = '"+category+"'";
				        }
						if(!(empId.equalsIgnoreCase("0")) && !(empId.equalsIgnoreCase(""))){
				            xsql1=xsql1+" and m.doc_no = '"+empId+"'";
				        }
						String sql9="select m.doc_no employeedocno,m.codeno employeeid,m.name employeename,m.salary_paid dates,DATEDIFF(m.terminated_date,m.salary_paid) totaldays,if(mod(round(sum(t.tot_leave1),1),1)=0,"
								+ "round(sum(t.tot_leave1),1),round(sum(t.tot_leave1),1)) leave1,if(mod(round(sum(t.tot_leave2),1),1)=0,round(sum(t.tot_leave2),1),round(sum(t.tot_leave2),1)) leave2,"
								+ "if(mod(round(sum(t.tot_leave3),1),1)=0,round(sum(t.tot_leave3),1),round(sum(t.tot_leave3),1)) leave3,if(mod(round(sum(t.tot_leave4),1),1)=0,round(sum(t.tot_leave4),1),"
								+ "round(sum(t.tot_leave4),1)) leave4,if(mod(round(sum(t.tot_leave5),1),1)=0,round(sum(t.tot_leave5),1),round(sum(t.tot_leave5),1)) leave5,if(mod(round(sum(t.tot_leave6),1),1)=0,"
								+ "round(sum(t.tot_leave6),1),round(sum(t.tot_leave6),1)) leave6,CONVERT(if(round(t.tot_ot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(t.tot_ot*60))=8,SUBSTRING(SEC_TO_TIME(t.tot_ot*60),1,5),SUBSTRING(SEC_TO_TIME(t.tot_ot*60),1,6))),CHAR(100)) ot," 
								+ "CONVERT(if(round(t.tot_hot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(t.tot_hot*60))=8,SUBSTRING(SEC_TO_TIME(t.tot_hot*60),1,5),SUBSTRING(SEC_TO_TIME(t.tot_hot*60),1,6))),CHAR(100)) hot,"
								+ "t.payroll_processed payrollprocessed from hr_timesheet t left join hr_empm m on t.empid=m.doc_no where m.active=0 and m.status=7"+xsql1+" "
								+ "and t.year=YEAR('"+sqlDate+"') and t.month=MONTH('"+sqlDate+"') and t.empid="+employeeIDTerminatedToBeProcessed.get(j).trim()+" group by t.empid";
						
//						System.out.println("sql9===="+sql9);
						ResultSet resultSet9 = stmtHMSP9.executeQuery(sql9);
						String terminatedoldempid="",terminatednewempid="",terminatedempCategoryID="0",terminateddaysToPay="0";  
						while(resultSet9.next()){
							Double tlev=0.0;
							ArrayList<String> terminatedtemp=new ArrayList<String>();
		
							terminatednewempid=resultSet9.getString("employeedocno");
							//System.out.println("sql9===="+terminatednewempid);
							if(terminatedoldempid!=terminatednewempid){
								
								//terminatedtemp.add(terminatednewempid);
								terminatedtemp.add(resultSet9.getString("employeeid"));
								terminatedtemp.add(resultSet9.getString("employeename"));
								//terminatedtemp.add(resultSet9.getString("dates"));
								terminateddaysToPay=resultSet9.getString("totaldays");
								terminatedtemp.add(terminateddaysToPay);
								terminatedtemp.add(resultSet9.getString("ot"));
								terminatedtemp.add(resultSet9.getString("hot"));
								//terminatedtemp.add(resultSet9.getString("payrollprocessed"));
								
								for (int l = 1; l <= totleaves; l++) {
									tlev+=resultSet9.getDouble("leave"+l);   
		 						 }
								terminatedtemp.add(tlev+"");   
								String sql10 = "select pay_catid from hr_empm where doc_no="+terminatednewempid+"";
								ResultSet resultSet10 = stmtHMSP10.executeQuery(sql10);		
								
								while(resultSet10.next()){
									terminatedempCategoryID=resultSet10.getString("pay_catid");
								}
								
								String sql11 = "select dailyRate from hr_paycode where catid="+terminatedempCategoryID+" and doc_no=(select max(doc_no) from hr_paycode where catid="+terminatedempCategoryID+" and revdate<='"+sqlDate+"')";
								ResultSet resultSet11 = stmtHMSP11.executeQuery(sql11);		
								
								while(resultSet11.next()){
									terminatedDailyRateFormula=resultSet11.getString("dailyRate");
								}
								
								String sql12="select * from ( "  
										+ "select t.empid,id.rdocno,id.awlid,id.refdtype,id.addition,id.deduction,id.statutorydeduction,id.revadd,id.revded,id.revstatded from "
										+ "hr_timesheet t left join hr_incrm im on t.empid=im.empid left join hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) "
										+ "from hr_incrm where t.empid=empid) and id.refdtype!='STD' and t.empid="+terminatednewempid+" union all "
										+ "select 0 empid,0 rdocno,hrs.doc_no awlid,'ALC' refdtype,0 addition,0 deduction,0 statutorydeduction,0 revadd,0 revded,0 revstatded from "
										+ "hr_setallowance hrs where hrs.status=3 and hrs.doc_no not in (select id.awlid from hr_timesheet t left join hr_incrm im on t.empid=im.empid left join "
										+ "hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) from hr_incrm where t.empid=empid) and id.refdtype!='STD' and "
										+ "t.empid="+terminatednewempid+")) as a where a.awlid>=0 group by empid,awlid,refdtype order by refdtype,awlid";
								
								ResultSet resultSet12 = stmtHMSP12.executeQuery(sql12);		
								
								double totalsalary=0.00,otAmount=0.00,hotAmount=0.00,overTimeAmount=0.00,leaveDeductionsAmount=0.00,grossSalaryAmount=0.00,additionAmount=0.00,deductionAmount=0.00,loanAmount=0.00,netSalaryAmount=0.00;
								double basicsalary=0.00,basicSalaryAmount=0.00,allowance=0.00,allowanceAmount=0.00,statutorydeduction=0.00;
								while(resultSet12.next()){
									if(resultSet12.getString("awlid").equalsIgnoreCase("0") && resultSet12.getString("refdtype").equalsIgnoreCase("0")){
										basicsalary=basicsalary+resultSet12.getDouble("revadd");
										basicsalary=basicsalary-resultSet12.getDouble("revded");
										
										//BASIC Calculation 
										//basicSalaryAmount= Double.parseDouble(hrCalc.getHRBASIC(conn,newempid,empCategoryID,sqlDate,basicsalary,daysToPay));
										//basicsalary=basicSalaryAmount;
										//BASIC Calculation Ends 
										
										//terminatedtemp.add(String.valueOf(basicsalary));
										totalsalary=totalsalary+basicsalary;
									}
									
									if(resultSet12.getString("refdtype").equalsIgnoreCase("ALC")){
										allowance=allowance+resultSet12.getDouble("revadd");
										allowance=allowance-resultSet12.getDouble("revded");
										
										if(terminatedDailyRateFormula.contains("GROSS")){
											
											//Allowance Calculation 
											//allowanceAmount= Double.parseDouble(hrCalc.getHRALLOWANCES(conn,newempid,empCategoryID,sqlDate,allowance,daysToPay));
											//allowance=allowanceAmount;
											//Allowance Calculation Ends 
											
											totalsalary=totalsalary+allowance;
										} else{
											totalsalary=totalsalary+allowance;
										}
										
										//terminatedtemp.add(String.valueOf(allowance));
									}
									
									if(resultSet12.getString("refdtype").equalsIgnoreCase("STD")){
										statutorydeduction=statutorydeduction-resultSet12.getDouble("revstatded");
										totalsalary=totalsalary-statutorydeduction;
									}
								}
								terminatedtemp.add(String.valueOf(basicsalary));
								terminatedtemp.add(String.valueOf(allowance));
								//Total Salary Calculation 
								//terminatedtemp.add(String.valueOf(totalsalary));
								//Total Salary Calculation Ends 
								
								String sql13="select * from ( "  
										+ "select t.empid,id.rdocno,id.awlid,id.refdtype,id.addition,id.deduction,id.statutorydeduction,id.revadd,id.revded,id.revstatded from "
										+ "hr_timesheet t left join hr_incrm im on t.empid=im.empid left join hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) "
										+ "from hr_incrm where t.empid=empid) and id.refdtype!='STD' and t.empid="+terminatednewempid+" union all "
										+ "select 0 empid,0 rdocno,hrs.doc_no awlid,'ALC' refdtype,0 addition,0 deduction,0 statutorydeduction,0 revadd,0 revded,0 revstatded from "
										+ "hr_setallowance hrs where hrs.status=3 and hrs.doc_no not in (select id.awlid from hr_timesheet t left join hr_incrm im on t.empid=im.empid left join "
										+ "hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) from hr_incrm where t.empid=empid) and id.refdtype!='STD' and "
										+ "t.empid="+terminatednewempid+")) as a where a.awlid>=0 group by empid,awlid,refdtype order by refdtype,awlid";
								//System.out.println("sql13======"+sql13);
								ResultSet resultSet13 = stmtHMSP13.executeQuery(sql13);		
								
								double earnedtotalsalary=0.00;  
								while(resultSet13.next()){
									double earnedbasicsalary=0.00,earnedbasicSalaryAmount=0.00,earnedallowance=0.00,earnedallowanceAmount=0.00,earnedstatutorydeduction=0.00;
									if(resultSet13.getString("awlid").equalsIgnoreCase("0") && resultSet13.getString("refdtype").equalsIgnoreCase("0")){
										earnedbasicsalary=earnedbasicsalary+resultSet13.getDouble("revadd");
										earnedbasicsalary=earnedbasicsalary-resultSet13.getDouble("revded");
										
										/*Terminated Earned BASIC Calculation */
										earnedbasicSalaryAmount= Double.parseDouble(hrCalc.getHRTerminatedEARNEDBASIC(conn,terminatednewempid,terminatedempCategoryID,sqlDate,earnedbasicsalary,terminateddaysToPay));
										earnedbasicsalary=earnedbasicSalaryAmount;
										/*Terminated Earned BASIC Calculation Ends */
										
										//terminatedtemp.add(String.valueOf(earnedbasicsalary));
										earnedtotalsalary=earnedtotalsalary+earnedbasicsalary;
									}
									
									if(resultSet13.getString("refdtype").equalsIgnoreCase("ALC")){
										earnedallowance=earnedallowance+resultSet13.getDouble("revadd");
										earnedallowance=earnedallowance-resultSet13.getDouble("revded");
										
										if(terminatedDailyRateFormula.contains("GROSS")){
											
											/*Terminated Earned Allowance Calculation */
											earnedallowanceAmount= Double.parseDouble(hrCalc.getHRTerminatedEARNEDALLOWANCES(conn,terminatednewempid,terminatedempCategoryID,sqlDate,earnedallowance,terminateddaysToPay,resultSet13.getString("awlid")));
											earnedallowance=earnedallowanceAmount;
											/*Terminated Earned Allowance Calculation Ends */
											
											earnedtotalsalary=earnedtotalsalary+earnedallowance;
										} else{
											earnedtotalsalary=earnedtotalsalary+earnedallowance;
										}
										
										//terminatedtemp.add(String.valueOf(earnedallowance));
									}
									
									if(resultSet13.getString("refdtype").equalsIgnoreCase("STD")){
										earnedstatutorydeduction=earnedstatutorydeduction-resultSet13.getDouble("revstatded");
										earnedtotalsalary=earnedtotalsalary-earnedstatutorydeduction;
									}
								}
								
								//terminatedtemp.add(String.valueOf(earnedbasicsalary));           
								//terminatedtemp.add(String.valueOf(earnedallowance));
								//Terminated Earned Total Salary Calculation 
								//terminatedtemp.add(String.valueOf(Math.round(earnedtotalsalary)));
								//Terminated Earned Total Salary Calculation Ends 
								
								//OT Calculation 
								otAmount= Double.parseDouble(hrCalc.getHROT(conn,terminatednewempid,terminatedempCategoryID,sqlDate));
								//OT Calculation Ends 
		
								//HOT Calculation 
								hotAmount= Double.parseDouble(hrCalc.getHRHOT(conn,terminatednewempid,terminatedempCategoryID,sqlDate));
								//HOT Calculation Ends 
								
								//Over Time Calculation 
								overTimeAmount=otAmount+hotAmount;
								terminatedtemp.add(String.valueOf(overTimeAmount));
								//Holiday Over Time Calculation Ends 
								
								//Leave Deductions Calculation 
								//leaveDeductionsAmount=Double.parseDouble(hrCalc.getHRLeaveDeductions(conn,newempid,empCategoryID,sqlDate));
								//temp.add(String.valueOf(leaveDeductionsAmount));
								//Leave Deductions Calculation Ends 
		
								//Gross Salary Calculation 
								//System.out.println("in===2==="+earnedtotalsalary+"===0v=="+overTimeAmount);
								grossSalaryAmount=Math.round(earnedtotalsalary+overTimeAmount);
								terminatedtemp.add(String.valueOf(grossSalaryAmount));
								//Gross Salary Calculation Ends 
								
								//Additions and Deductions Calculation 
								terminatedAdditionsDeductionsAmount=hrCalc.getHRAdditionsDeductions(conn,terminatednewempid,sqlDate);
								if(terminatedAdditionsDeductionsAmount.size()>0){
									String[] additionsDeductions=terminatedAdditionsDeductionsAmount.get(0).split("::");
									additionAmount = ((additionsDeductions[0].isEmpty()?0.0:Double.parseDouble(additionsDeductions[0])));
									deductionAmount = ((additionsDeductions[1].isEmpty()?0.0:Double.parseDouble(additionsDeductions[1])));
									terminatedtemp.add(String.valueOf(additionAmount));
									terminatedtemp.add(String.valueOf(deductionAmount));
								} 
								//Additions and Deductions Calculation Ends 
								
								//Loan Amount Calculation
								loanAmount= Double.parseDouble(hrCalc.getHRLoanAmount(conn,terminatednewempid,sqlDate));
								terminatedtemp.add(String.valueOf(loanAmount));
								//Loan Amount Calculation Ends
								
								//Net Salary Amount Calculation 
								netSalaryAmount=(((grossSalaryAmount+additionAmount)-(deductionAmount))-(loanAmount));
								terminatedtemp.add(String.valueOf(netSalaryAmount));
								//Net Salary Amount Calculation Ends
								
								terminatedtemp.add("Termianted Employee Payroll Processed on "+date+"");
								
								terminatedoldempid=terminatednewempid;
								
							}
							
							analysisrowarray.add(terminatedtemp);
							
						}
						
						
				    }
					
					stmtHMSP9.close();
					stmtHMSP10.close();
					stmtHMSP11.close();
					stmtHMSP12.close();
					stmtHMSP13.close();         
				}  
				//System.out.println("****analysisrowarray==="+analysisrowarray);           
				printmonthlypayroll2=convertRowPrintArrayToJSON(request2,analysisrowarray,totleaves,totallowance);
				
				stmtHMSP.close();
		        stmtHMSP1.close();
				stmtHMSP2.close();
				stmtHMSP3.close();
				stmtHMSP4.close();
				stmtHMSP5.close();
				
	} else {    
		
		Statement stmtHMSP = conn.createStatement();
		Statement stmtHMSP1 = conn.createStatement();
		Statement stmtHMSP2 = conn.createStatement();
		Statement stmtHMSP3 = conn.createStatement();
		
		ArrayList<String> employeeIDToBeProcessed = new ArrayList<String>();
		ArrayList<String> employeeIDTerminatedToBeProcessed = new ArrayList<String>();
		ArrayList<ArrayList<String>> employeeToBeProcessed= new ArrayList<ArrayList<String>>();
		ArrayList<ArrayList<String>> employeeProcessed= new ArrayList<ArrayList<String>>();
		ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<ArrayList<String>>();
		int totleaves=0,totallowance=0;

		String sql="select count(doc_no) totleaves from hr_timesheetset where reftype='L'";
		ResultSet resultSet = stmtHMSP.executeQuery(sql);
		
		while(resultSet.next()){
			totleaves=resultSet.getInt("totleaves");
		}
		
		String sql1 = "select count(doc_no) totallowances from hr_setallowance where status=3 and doc_no>0";
		ResultSet resultSet1 = stmtHMSP1.executeQuery(sql1);
		
		while(resultSet1.next()) {
			totallowance=resultSet1.getInt("totallowances");
	  	}
		
		String sql2 = "",sql3 = "";
		
		if(!(category.equalsIgnoreCase("0")) && !(category.equalsIgnoreCase(""))){
			sql2=sql2+" and m.pay_catid = '"+category+"'";
        }
		
		if(!(empId.equalsIgnoreCase("0")) && !(empId.equalsIgnoreCase(""))){
			sql2=sql2+" and m.doc_no = '"+empId+"'";
        }
		
		sql2 = "select t.empid from hr_timesheet t left join hr_empm m on (t.empid=m.doc_no and t.year=YEAR('"+sqlDate+"') and t.month=MONTH('"+sqlDate+"')) where m.status=3 and m.active=1 and t.payroll_processed=0 and t.payroll_confirmed=0 and month=MONTH('"+sqlDate+"') and t.year=YEAR('"+sqlDate+"')"+sql2+"";			
		ResultSet resultSet2 = stmtHMSP3.executeQuery(sql2);
		
		while(resultSet2.next()){
			employeeIDToBeProcessed.add(resultSet2.getString("empid"));
		}
		
		if(!(category.equalsIgnoreCase("0")) && !(category.equalsIgnoreCase(""))){
			sql3=sql3+" and m.pay_catid = '"+category+"'";
        }
		
		sql3 = "select t.empid from hr_timesheet t left join hr_empm m on (t.empid=m.doc_no and t.year=YEAR('"+sqlDate+"') and t.month=MONTH('"+sqlDate+"')) where m.status=7 and m.active=0 and t.payroll_processed=0 and t.payroll_confirmed=0 and t.month=MONTH('"+sqlDate+"') and t.year=YEAR('"+sqlDate+"') and MONTH(m.terminated_date)=MONTH('"+sqlDate+"') and YEAR(m.terminated_date)=YEAR('"+sqlDate+"')"+sql3+"";
		ResultSet resultSet3 = stmtHMSP3.executeQuery(sql3);
		
		while(resultSet3.next()){
			employeeIDTerminatedToBeProcessed.add(resultSet3.getString("empid"));
		}
		
		if(employeeIDToBeProcessed.size()>0){
			
			Statement stmtHMSP4 = conn.createStatement();
			Statement stmtHMSP5 = conn.createStatement();
			Statement stmtHMSP6 = conn.createStatement();
			Statement stmtHMSP7 = conn.createStatement();
			Statement stmtHMSP8 = conn.createStatement();
			
			
			String dailyRateFormula="",xsql="";
			ClsCommonHR hrCalc = new ClsCommonHR();
			ArrayList<String> additionsDeductionsAmount = new ArrayList<String>();
			
			for(int i=0;i< employeeIDToBeProcessed.size();i++){
				
				if(!(category.equalsIgnoreCase("0")) && !(category.equalsIgnoreCase(""))){
		            xsql=xsql+" and m.pay_catid = '"+category+"'";
		        }
				
				if(!(empId.equalsIgnoreCase("0")) && !(empId.equalsIgnoreCase(""))){
		            xsql=xsql+" and m.doc_no = '"+empId+"'";
		        }
				
				String sql4="select m.doc_no employeedocno,m.codeno employeeid,m.name employeename,m.salary_paid dates,DATEDIFF('"+sqlDate+"',m.salary_paid) totaldays,if(mod(round(sum(t.tot_leave1),1),1)=0,"
						+ "round(sum(t.tot_leave1),0),round(sum(t.tot_leave1),1)) leave1,if(mod(round(sum(t.tot_leave2),1),1)=0,round(sum(t.tot_leave2),0),round(sum(t.tot_leave2),1)) leave2,"
						+ "if(mod(round(sum(t.tot_leave3),1),1)=0,round(sum(t.tot_leave3),0),round(sum(t.tot_leave3),1)) leave3,if(mod(round(sum(t.tot_leave4),1),1)=0,round(sum(t.tot_leave4),0),"
						+ "round(sum(t.tot_leave4),1)) leave4,if(mod(round(sum(t.tot_leave5),1),1)=0,round(sum(t.tot_leave5),0),round(sum(t.tot_leave5),1)) leave5,if(mod(round(sum(t.tot_leave6),1),1)=0,"
						+ "round(sum(t.tot_leave6),0),round(sum(t.tot_leave6),1)) leave6,CONVERT(if(round(t.tot_ot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(t.tot_ot*60))=8,SUBSTRING(SEC_TO_TIME(t.tot_ot*60),1,5),SUBSTRING(SEC_TO_TIME(t.tot_ot*60),1,6))),CHAR(100)) ot," 
						+ "CONVERT(if(round(t.tot_hot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(t.tot_hot*60))=8,SUBSTRING(SEC_TO_TIME(t.tot_hot*60),1,5),SUBSTRING(SEC_TO_TIME(t.tot_hot*60),1,6))),CHAR(100)) hot,"
						+ "t.payroll_processed payrollprocessed from hr_timesheet t left join hr_empm m on t.empid=m.doc_no where m.active=1 and m.status=3"+xsql+" "
						+ "and t.year=YEAR('"+sqlDate+"') and t.month=MONTH('"+sqlDate+"') and t.empid="+employeeIDToBeProcessed.get(i).trim()+" group by t.empid";
				
				ResultSet resultSet4 = stmtHMSP4.executeQuery(sql4);
				
				String oldempid="",newempid="",empCategoryID="0",daysToPay="0";
				
				while(resultSet4.next()){
					Double tlev=0.0;
					ArrayList<String> temp=new ArrayList<String>();

					newempid=resultSet4.getString("employeedocno");
					
					if(oldempid!=newempid){
						
						//temp.add(newempid);  
						temp.add(resultSet4.getString("employeeid"));
						temp.add(resultSet4.getString("employeename"));
						//temp.add(resultSet4.getString("dates"));
						daysToPay=resultSet4.getString("totaldays");
						temp.add(daysToPay);
						temp.add(resultSet4.getString("ot"));
						temp.add(resultSet4.getString("hot"));
						//temp.add(resultSet4.getString("payrollprocessed"));
						
						for (int l = 1; l <= totleaves; l++) {
							tlev+=resultSet4.getDouble("leave"+l);
 						 }
						temp.add(tlev+"");  
						String sql5 = "select pay_catid from hr_empm where doc_no="+newempid+"";
						ResultSet resultSet5 = stmtHMSP5.executeQuery(sql5);		
						
						while(resultSet5.next()){
							empCategoryID=resultSet5.getString("pay_catid");
						}
						
						String sql6 = "select dailyRate from hr_paycode where catid="+empCategoryID+" and doc_no=(select max(doc_no) from hr_paycode where catid="+empCategoryID+" and revdate<='"+sqlDate+"')";
						ResultSet resultSet6 = stmtHMSP6.executeQuery(sql6);		
						
						while(resultSet6.next()){
							dailyRateFormula=resultSet6.getString("dailyRate");
						}
						
						String sql7="select * from ( "  
								+ "select t.empid,id.rdocno,id.awlid,id.refdtype,id.addition,id.deduction,id.statutorydeduction,id.revadd,id.revded,id.revstatded from "
								+ "hr_timesheet t left join hr_incrm im on t.empid=im.empid left join hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) "
								+ "from hr_incrm where t.empid=empid) and id.refdtype!='STD' and t.empid="+newempid+" union all "
								+ "select 0 empid,0 rdocno,hrs.doc_no awlid,'ALC' refdtype,0 addition,0 deduction,0 statutorydeduction,0 revadd,0 revded,0 revstatded from "
								+ "hr_setallowance hrs where hrs.status=3 and hrs.doc_no not in (select id.awlid from hr_timesheet t left join hr_incrm im on t.empid=im.empid left join "
								+ "hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) from hr_incrm where t.empid=empid) and id.refdtype!='STD' and "
								+ "t.empid="+newempid+")) as a where a.awlid>=0 group by empid,awlid,refdtype order by refdtype,awlid";
						
						ResultSet resultSet7 = stmtHMSP7.executeQuery(sql7);		
						
						double totalsalary=0.00,otAmount=0.00,hotAmount=0.00,overTimeAmount=0.00,leaveDeductionsAmount=0.00,grossSalaryAmount=0.00,additionAmount=0.00,deductionAmount=0.00,loanAmount=0.00,netSalaryAmount=0.00;
						double basicsalary=0.00,basicSalaryAmount=0.00,allowance=0.00,allowanceAmount=0.00,statutorydeduction=0.00;
						while(resultSet7.next()){
							
							
							if(resultSet7.getString("awlid").equalsIgnoreCase("0") && resultSet7.getString("refdtype").equalsIgnoreCase("0")){
								basicsalary=basicsalary+resultSet7.getDouble("revadd");
								basicsalary=basicsalary-resultSet7.getDouble("revded");
								
								//BASIC Calculation 
								//basicSalaryAmount= Double.parseDouble(hrCalc.getHRBASIC(conn,newempid,empCategoryID,sqlDate,basicsalary,daysToPay));
								//basicsalary=basicSalaryAmount;
								//BASIC Calculation Ends 
								
								//temp.add(String.valueOf(basicsalary));
								totalsalary=totalsalary+basicsalary;
							}
							
							if(resultSet7.getString("refdtype").equalsIgnoreCase("ALC")){
								allowance=allowance+resultSet7.getDouble("revadd");
								allowance=allowance-resultSet7.getDouble("revded");
								
								if(dailyRateFormula.contains("GROSS")){
									
									//Allowance Calculation 
									//allowanceAmount= Double.parseDouble(hrCalc.getHRALLOWANCES(conn,newempid,empCategoryID,sqlDate,allowance,daysToPay));
									//allowance=allowanceAmount;
									//Allowance Calculation Ends 
									
									totalsalary=totalsalary+allowance;
								} else{
									totalsalary=totalsalary+allowance;
								}
								
								//temp.add(String.valueOf(allowance));
							}
							
							if(resultSet7.getString("refdtype").equalsIgnoreCase("STD")){
								statutorydeduction=statutorydeduction-resultSet7.getDouble("revstatded");
								totalsalary=totalsalary-statutorydeduction;
							}
						}
						temp.add(String.valueOf(basicsalary));
						temp.add(String.valueOf(allowance));
						//Total Salary Calculation 
						//temp.add(String.valueOf(totalsalary));
						//Total Salary Calculation Ends 
						
						String sql8="select * from ( "  
								+ "select t.empid,id.rdocno,id.awlid,id.refdtype,id.addition,id.deduction,id.statutorydeduction,id.revadd,id.revded,id.revstatded from "
								+ "hr_timesheet t left join hr_incrm im on t.empid=im.empid left join hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) "
								+ "from hr_incrm where t.empid=empid) and id.refdtype!='STD' and t.empid="+newempid+" union all "
								+ "select 0 empid,0 rdocno,hrs.doc_no awlid,'ALC' refdtype,0 addition,0 deduction,0 statutorydeduction,0 revadd,0 revded,0 revstatded from "
								+ "hr_setallowance hrs where hrs.status=3 and hrs.doc_no not in (select id.awlid from hr_timesheet t left join hr_incrm im on t.empid=im.empid left join "
								+ "hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) from hr_incrm where t.empid=empid) and id.refdtype!='STD' and "
								+ "t.empid="+newempid+")) as a where a.awlid>=0 group by empid,awlid,refdtype order by refdtype,awlid";
						
						ResultSet resultSet8 = stmtHMSP8.executeQuery(sql8);		
						
						double earnedtotalsalary=0.00;
						while(resultSet8.next()){
							double earnedbasicsalary=0.00,earnedbasicSalaryAmount=0.00,earnedallowance=0.00,earnedallowanceAmount=0.00,earnedstatutorydeduction=0.00;
							
							if(resultSet8.getString("awlid").equalsIgnoreCase("0") && resultSet8.getString("refdtype").equalsIgnoreCase("0")){
								earnedbasicsalary=earnedbasicsalary+resultSet8.getDouble("revadd");
								earnedbasicsalary=earnedbasicsalary-resultSet8.getDouble("revded");
								
								//BASIC Calculation 
								earnedbasicSalaryAmount= Double.parseDouble(hrCalc.getHREARNEDBASIC(conn,newempid,empCategoryID,sqlDate,earnedbasicsalary,daysToPay));
								earnedbasicsalary=earnedbasicSalaryAmount;
								//BASIC Calculation Ends 
								
								//temp.add(String.valueOf(earnedbasicsalary));
								earnedtotalsalary=earnedtotalsalary+earnedbasicsalary;
							}
							
							if(resultSet8.getString("refdtype").equalsIgnoreCase("ALC")){
								earnedallowance=earnedallowance+resultSet8.getDouble("revadd");
								earnedallowance=earnedallowance-resultSet8.getDouble("revded");
								
								if(dailyRateFormula.contains("GROSS")){
									
									//Allowance Calculation 
									earnedallowanceAmount= Double.parseDouble(hrCalc.getHREARNEDALLOWANCES(conn,newempid,empCategoryID,sqlDate,earnedallowance,daysToPay,resultSet8.getString("awlid")));
									earnedallowance=earnedallowanceAmount;
									//Allowance Calculation Ends 
									
									earnedtotalsalary=earnedtotalsalary+earnedallowance;
								} else{
									earnedtotalsalary=earnedtotalsalary+earnedallowance;
								}
								
								//temp.add(String.valueOf(earnedallowance));
							}
							
							if(resultSet8.getString("refdtype").equalsIgnoreCase("STD")){
								earnedstatutorydeduction=earnedstatutorydeduction-resultSet8.getDouble("revstatded");
								earnedtotalsalary=earnedtotalsalary-earnedstatutorydeduction;
							}
						}
						
						//Earned Total Salary Calculation 
						//temp.add(String.valueOf(Math.round(earnedtotalsalary)));
						//Earned Total Salary Calculation Ends 
						
						//OT Calculation 
						otAmount= Double.parseDouble(hrCalc.getHROT(conn,newempid,empCategoryID,sqlDate));
						//OT Calculation Ends 

						//HOT Calculation 
						hotAmount= Double.parseDouble(hrCalc.getHRHOT(conn,newempid,empCategoryID,sqlDate));
						//HOT Calculation Ends 
						
						//Over Time Calculation 
						overTimeAmount=otAmount+hotAmount;
						temp.add(String.valueOf(overTimeAmount));
						//Holiday Over Time Calculation Ends 
						
						//Leave Deductions Calculation 
						//leaveDeductionsAmount=Double.parseDouble(hrCalc.getHRLeaveDeductions(conn,newempid,empCategoryID,sqlDate));
						//temp.add(String.valueOf(leaveDeductionsAmount));
						//Leave Deductions Calculation Ends 

						//Gross Salary Calculation 
						//System.out.println("in===3==="+earnedtotalsalary+"===0v=="+overTimeAmount);
						grossSalaryAmount=Math.round(earnedtotalsalary+overTimeAmount);
						temp.add(String.valueOf(grossSalaryAmount));
						//Gross Salary Calculation Ends 
						
						//Additions and Deductions Calculation 
						additionsDeductionsAmount=hrCalc.getHRAdditionsDeductions(conn,newempid,sqlDate);
						if(additionsDeductionsAmount.size()>0){
							String[] additionsDeductions=additionsDeductionsAmount.get(0).split("::");
							additionAmount = ((additionsDeductions[0].isEmpty()?0.0:Double.parseDouble(additionsDeductions[0])));
							deductionAmount = ((additionsDeductions[1].isEmpty()?0.0:Double.parseDouble(additionsDeductions[1])));
							temp.add(String.valueOf(additionAmount));
							temp.add(String.valueOf(deductionAmount));
						}
						//Additions and Deductions Calculation Ends 
						
						//Loan Amount Calculation
						loanAmount= Double.parseDouble(hrCalc.getHRLoanAmount(conn,newempid,sqlDate));
						temp.add(String.valueOf(loanAmount));
						//Loan Amount Calculation Ends
						
						//Net Salary Amount Calculation 
						netSalaryAmount=(((grossSalaryAmount+additionAmount)-(deductionAmount))-(loanAmount));
						temp.add(String.valueOf(netSalaryAmount));
						//Net Salary Amount Calculation Ends
						
						temp.add("Payroll Processed on "+date+"");
						
						oldempid=newempid;
						
					}
					
					employeeToBeProcessed.add(temp);
					
				}
				
				
		    }
			
			stmtHMSP4.close();
			stmtHMSP5.close();
			stmtHMSP6.close();
			stmtHMSP7.close();
			stmtHMSP8.close();
		}
		
		//Terminated Salary processing
		if(employeeIDTerminatedToBeProcessed.size()>0){
			
			Statement stmtHMSP9 = conn.createStatement();
			Statement stmtHMSP10 = conn.createStatement();
			Statement stmtHMSP11 = conn.createStatement();
			Statement stmtHMSP12 = conn.createStatement();
			Statement stmtHMSP13 = conn.createStatement();
			
			
			String dailyRateFormula="",xsql="";
			ClsCommonHR hrCalc = new ClsCommonHR();
			ArrayList<String> additionsDeductionsAmount = new ArrayList<String>();
			
			for(int j=0;j< employeeIDTerminatedToBeProcessed.size();j++){
				
				if(!(category.equalsIgnoreCase("0")) && !(category.equalsIgnoreCase(""))){
		            xsql=xsql+" and m.pay_catid = '"+category+"'";
		        }
				if(!(empId.equalsIgnoreCase("0")) && !(empId.equalsIgnoreCase(""))){
		            xsql=xsql+" and m.doc_no = '"+empId+"'";
		        }
				String sql9="select m.doc_no employeedocno,m.codeno employeeid,m.name employeename,m.salary_paid dates,DATEDIFF(m.terminated_date,m.salary_paid) totaldays,if(mod(round(sum(t.tot_leave1),1),1)=0,"
						+ "round(sum(t.tot_leave1),0),round(sum(t.tot_leave1),1)) leave1,if(mod(round(sum(t.tot_leave2),1),1)=0,round(sum(t.tot_leave2),0),round(sum(t.tot_leave2),1)) leave2,"
						+ "if(mod(round(sum(t.tot_leave3),1),1)=0,round(sum(t.tot_leave3),0),round(sum(t.tot_leave3),1)) leave3,if(mod(round(sum(t.tot_leave4),1),1)=0,round(sum(t.tot_leave4),0),"
						+ "round(sum(t.tot_leave4),1)) leave4,if(mod(round(sum(t.tot_leave5),1),1)=0,round(sum(t.tot_leave5),0),round(sum(t.tot_leave5),1)) leave5,if(mod(round(sum(t.tot_leave6),1),1)=0,"
						+ "round(sum(t.tot_leave6),0),round(sum(t.tot_leave6),1)) leave6,CONVERT(if(round(t.tot_ot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(t.tot_ot*60))=8,SUBSTRING(SEC_TO_TIME(t.tot_ot*60),1,5),SUBSTRING(SEC_TO_TIME(t.tot_ot*60),1,6))),CHAR(100)) ot,"  
						+ "CONVERT(if(round(t.tot_hot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(t.tot_hot*60))=8,SUBSTRING(SEC_TO_TIME(t.tot_hot*60),1,5),SUBSTRING(SEC_TO_TIME(t.tot_hot*60),1,6))),CHAR(100)) hot,"
						+ "t.payroll_processed payrollprocessed from hr_timesheet t left join hr_empm m on t.empid=m.doc_no where m.active=0 and m.status=7"+xsql+" "
						+ "and t.year=YEAR('"+sqlDate+"') and t.month=MONTH('"+sqlDate+"') and t.empid="+employeeIDTerminatedToBeProcessed.get(j).trim()+" group by t.empid";
				
				ResultSet resultSet9 = stmtHMSP9.executeQuery(sql9);
				
				String oldempid="",newempid="",empCategoryID="0",daysToPay="0";
				
				while(resultSet9.next()){
					Double tlev=0.0;
					ArrayList<String> terminatedtemp=new ArrayList<String>();

					newempid=resultSet9.getString("employeedocno");
					
					if(oldempid!=newempid){
						
						//terminatedtemp.add(newempid);
						terminatedtemp.add(resultSet9.getString("employeeid"));
						terminatedtemp.add(resultSet9.getString("employeename"));
						//terminatedtemp.add(resultSet9.getString("dates"));
						daysToPay=resultSet9.getString("totaldays");
						terminatedtemp.add(daysToPay);
						terminatedtemp.add(resultSet9.getString("ot"));
						terminatedtemp.add(resultSet9.getString("hot"));
						//terminatedtemp.add(resultSet9.getString("payrollprocessed"));
						
						for (int l = 1; l <= totleaves; l++) {
							tlev+=resultSet9.getDouble("leave"+l);   
 						 }
						terminatedtemp.add(tlev+""); 

						String sql10 = "select pay_catid from hr_empm where doc_no="+newempid+"";
						ResultSet resultSet10 = stmtHMSP10.executeQuery(sql10);		
						
						while(resultSet10.next()){
							empCategoryID=resultSet10.getString("pay_catid");
						}
						
						String sql11 = "select dailyRate from hr_paycode where catid="+empCategoryID+" and doc_no=(select max(doc_no) from hr_paycode where catid="+empCategoryID+" and revdate<='"+sqlDate+"')";
						ResultSet resultSet11 = stmtHMSP11.executeQuery(sql11);		
						
						while(resultSet11.next()){
							dailyRateFormula=resultSet11.getString("dailyRate");
						}
						
						String sql12="select * from ( "  
								+ "select t.empid,id.rdocno,id.awlid,id.refdtype,id.addition,id.deduction,id.statutorydeduction,id.revadd,id.revded,id.revstatded from "
								+ "hr_timesheet t left join hr_incrm im on t.empid=im.empid left join hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) "
								+ "from hr_incrm where t.empid=empid) and id.refdtype!='STD' and t.empid="+newempid+" union all "
								+ "select 0 empid,0 rdocno,hrs.doc_no awlid,'ALC' refdtype,0 addition,0 deduction,0 statutorydeduction,0 revadd,0 revded,0 revstatded from "
								+ "hr_setallowance hrs where hrs.status=3 and hrs.doc_no not in (select id.awlid from hr_timesheet t left join hr_incrm im on t.empid=im.empid left join "
								+ "hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) from hr_incrm where t.empid=empid) and id.refdtype!='STD' and "
								+ "t.empid="+newempid+")) as a where a.awlid>=0 group by empid,awlid,refdtype order by refdtype,awlid";
						
						ResultSet resultSet12 = stmtHMSP12.executeQuery(sql12);		
						
						double totalsalary=0.00,otAmount=0.00,hotAmount=0.00,overTimeAmount=0.00,leaveDeductionsAmount=0.00,grossSalaryAmount=0.00,additionAmount=0.00,deductionAmount=0.00,loanAmount=0.00,netSalaryAmount=0.00;
						double basicsalary=0.00,basicSalaryAmount=0.00,allowance=0.00,allowanceAmount=0.00,statutorydeduction=0.00;
						while(resultSet12.next()){
							
							if(resultSet12.getString("awlid").equalsIgnoreCase("0") && resultSet12.getString("refdtype").equalsIgnoreCase("0")){
								basicsalary=basicsalary+resultSet12.getDouble("revadd");
								basicsalary=basicsalary-resultSet12.getDouble("revded");
								
								//BASIC Calculation 
								//basicSalaryAmount= Double.parseDouble(hrCalc.getHRBASIC(conn,newempid,empCategoryID,sqlDate,basicsalary,daysToPay));
								//basicsalary=basicSalaryAmount;
								//BASIC Calculation Ends 
								
								//terminatedtemp.add(String.valueOf(basicsalary));
								totalsalary=totalsalary+basicsalary;
							}
							
							if(resultSet12.getString("refdtype").equalsIgnoreCase("ALC")){
								allowance=allowance+resultSet12.getDouble("revadd");
								allowance=allowance-resultSet12.getDouble("revded");
								
								if(dailyRateFormula.contains("GROSS")){
									
									//Allowance Calculation 
									//allowanceAmount= Double.parseDouble(hrCalc.getHRALLOWANCES(conn,newempid,empCategoryID,sqlDate,allowance,daysToPay));
									//allowance=allowanceAmount;
									//Allowance Calculation Ends 
									
									totalsalary=totalsalary+allowance;
								} else{
									totalsalary=totalsalary+allowance;
								}
								
								//terminatedtemp.add(String.valueOf(allowance));   
							}
							
							if(resultSet12.getString("refdtype").equalsIgnoreCase("STD")){
								statutorydeduction=statutorydeduction-resultSet12.getDouble("revstatded");
								totalsalary=totalsalary-statutorydeduction;
							}
						}
						terminatedtemp.add(String.valueOf(basicsalary));
						terminatedtemp.add(String.valueOf(allowance));
						//Total Salary Calculation 
						//terminatedtemp.add(String.valueOf(totalsalary));
						//Total Salary Calculation Ends 
						
						String sql13="select * from ( "  
								+ "select t.empid,id.rdocno,id.awlid,id.refdtype,id.addition,id.deduction,id.statutorydeduction,id.revadd,id.revded,id.revstatded from "
								+ "hr_timesheet t left join hr_incrm im on t.empid=im.empid left join hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) "
								+ "from hr_incrm where t.empid=empid) and id.refdtype!='STD' and t.empid="+newempid+" union all "
								+ "select 0 empid,0 rdocno,hrs.doc_no awlid,'ALC' refdtype,0 addition,0 deduction,0 statutorydeduction,0 revadd,0 revded,0 revstatded from "
								+ "hr_setallowance hrs where hrs.status=3 and hrs.doc_no not in (select id.awlid from hr_timesheet t left join hr_incrm im on t.empid=im.empid left join "
								+ "hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) from hr_incrm where t.empid=empid) and id.refdtype!='STD' and "
								+ "t.empid="+newempid+")) as a where a.awlid>=0 group by empid,awlid,refdtype order by refdtype,awlid";
						//System.out.println("sql13======>>"+sql13);
						ResultSet resultSet13 = stmtHMSP13.executeQuery(sql13);		
						
						double earnedtotalsalary=0.00;
						while(resultSet13.next()){
							double earnedbasicsalary=0.00,earnedbasicSalaryAmount=0.00,earnedallowance=0.00,earnedallowanceAmount=0.00,earnedstatutorydeduction=0.00;
							
							if(resultSet13.getString("awlid").equalsIgnoreCase("0") && resultSet13.getString("refdtype").equalsIgnoreCase("0")){
								earnedbasicsalary=earnedbasicsalary+resultSet13.getDouble("revadd");
								earnedbasicsalary=earnedbasicsalary-resultSet13.getDouble("revded");
								
								//Terminated Earned BASIC Calculation 
								earnedbasicSalaryAmount= Double.parseDouble(hrCalc.getHRTerminatedEARNEDBASIC(conn,newempid,empCategoryID,sqlDate,earnedbasicsalary,daysToPay));
								earnedbasicsalary=earnedbasicSalaryAmount;
								//Terminated Earned BASIC Calculation Ends 
								
								//terminatedtemp.add(String.valueOf(earnedbasicsalary));
								earnedtotalsalary=earnedtotalsalary+earnedbasicsalary;
							}
							
							if(resultSet13.getString("refdtype").equalsIgnoreCase("ALC")){
								earnedallowance=earnedallowance+resultSet13.getDouble("revadd");
								earnedallowance=earnedallowance-resultSet13.getDouble("revded");
								
								if(dailyRateFormula.contains("GROSS")){
									
									//Terminated Earned Allowance Calculation 
									earnedallowanceAmount= Double.parseDouble(hrCalc.getHRTerminatedEARNEDALLOWANCES(conn,newempid,empCategoryID,sqlDate,earnedallowance,daysToPay,resultSet13.getString("awlid")));
									earnedallowance=earnedallowanceAmount;
									//Terminated Earned Allowance Calculation Ends 
									
									earnedtotalsalary=earnedtotalsalary+earnedallowance;
								} else{
									earnedtotalsalary=earnedtotalsalary+earnedallowance;
								}
								
								//terminatedtemp.add(String.valueOf(earnedallowance));
							}
							
							if(resultSet13.getString("refdtype").equalsIgnoreCase("STD")){
								earnedstatutorydeduction=earnedstatutorydeduction-resultSet13.getDouble("revstatded");
								earnedtotalsalary=earnedtotalsalary-earnedstatutorydeduction;
							}
						}
						
						//Terminated Earned Total Salary Calculation 
						//terminatedtemp.add(String.valueOf(Math.round(earnedtotalsalary)));
					//	Terminated Earned Total Salary Calculation Ends 
						
						//OT Calculation 
						otAmount= Double.parseDouble(hrCalc.getHROT(conn,newempid,empCategoryID,sqlDate));
						//OT Calculation Ends 

						//HOT Calculation 
						hotAmount= Double.parseDouble(hrCalc.getHRHOT(conn,newempid,empCategoryID,sqlDate));
						//HOT Calculation Ends 
						
						//Over Time Calculation 
						overTimeAmount=otAmount+hotAmount;
						terminatedtemp.add(String.valueOf(overTimeAmount));
						//Holiday Over Time Calculation Ends 
						
						//Leave Deductions Calculation 
						//leaveDeductionsAmount=Double.parseDouble(hrCalc.getHRLeaveDeductions(conn,newempid,empCategoryID,sqlDate));
						//temp.add(String.valueOf(leaveDeductionsAmount));
						//Leave Deductions Calculation Ends 

						//Gross Salary Calculation 
						//System.out.println("in===4==="+earnedtotalsalary+"===0v=="+overTimeAmount);
						grossSalaryAmount=Math.round(earnedtotalsalary+overTimeAmount);
						terminatedtemp.add(String.valueOf(grossSalaryAmount));
						//Gross Salary Calculation Ends 
						
						//Additions and Deductions Calculation 
						additionsDeductionsAmount=hrCalc.getHRAdditionsDeductions(conn,newempid,sqlDate);
						if(additionsDeductionsAmount.size()>0){
							String[] additionsDeductions=additionsDeductionsAmount.get(0).split("::");
							additionAmount = ((additionsDeductions[0].isEmpty()?0.0:Double.parseDouble(additionsDeductions[0])));
							deductionAmount = ((additionsDeductions[1].isEmpty()?0.0:Double.parseDouble(additionsDeductions[1])));
							terminatedtemp.add(String.valueOf(additionAmount));
							terminatedtemp.add(String.valueOf(deductionAmount));
						}
						//Additions and Deductions Calculation Ends 
						
						//Loan Amount Calculation
						loanAmount= Double.parseDouble(hrCalc.getHRLoanAmount(conn,newempid,sqlDate));
						terminatedtemp.add(String.valueOf(loanAmount));
						//Loan Amount Calculation Ends
						
						//Net Salary Amount Calculation 
						netSalaryAmount=(((grossSalaryAmount+additionAmount)-(deductionAmount))-(loanAmount));
						terminatedtemp.add(String.valueOf(netSalaryAmount));
						//Net Salary Amount Calculation Ends
						
						terminatedtemp.add("Termianted Employee Payroll Processed on "+date+"");
						
						oldempid=newempid;
						
					}
					
					employeeToBeProcessed.add(terminatedtemp);
					
				}
				
				
		    }
			
			stmtHMSP9.close();
			stmtHMSP10.close();
			stmtHMSP11.close();
			stmtHMSP12.close();
			stmtHMSP13.close();
		}
		
		String sql14="";
		
		if(!(category.equalsIgnoreCase("0")) && !(category.equalsIgnoreCase(""))){
            sql14=sql14+" and m.pay_catid = '"+category+"'";
        }
		
		if(!(empId.equalsIgnoreCase("0")) && !(empId.equalsIgnoreCase(""))){
			sql14=sql14+" and m.doc_no = '"+empId+"'";
        }
		
		String sql15="select p.rowno,m.codeno employeeid,m.name employeename,p.date dates,p.daystopay totaldays,p.leave1,p.leave2,p.leave3,p.leave4,p.leave5,p.leave6,p.leave7,p.leave8,p.leave9,p.leave10,p.basic,p.allowance1,p.allowance2,"
			 + "p.allowance3,p.allowance4,p.allowance5,p.allowance6,p.allowance7,p.allowance8,p.allowance9,p.allowance10,p.totalsalary,p.earnedbasic earnbasic,p.earnedallowance1 earnallowance1,p.earnedallowance2 earnallowance2,"
			 + "p.earnedallowance3 earnallowance3,p.earnedallowance4 earnallowance4,p.earnedallowance5 earnallowance5,p.earnedallowance6 earnallowance6,p.earnedallowance7 earnallowance7,p.earnedallowance8 earnallowance8,"
			 + "p.earnedallowance9 earnallowance9,p.earnedallowance10 earnallowance10,p.earnedtotalsalary totalearnedsalary,CONVERT(if(round(p.tot_ot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(p.tot_ot*60))=8,SUBSTRING(SEC_TO_TIME(p.tot_ot*60),1,5),SUBSTRING(SEC_TO_TIME(p.tot_ot*60),1,6))),CHAR(100)) ot,"  
			 + "CONVERT(if(round(p.tot_hot*60,2)=0,' ',if(LENGTH(SEC_TO_TIME(p.tot_hot*60))=8,SUBSTRING(SEC_TO_TIME(p.tot_hot*60),1,5),SUBSTRING(SEC_TO_TIME(p.tot_hot*60),1,6))),CHAR(100)) hot,"
			 + "p.overtime,p.grosssalary,p.additions,p.deductions,p.loan,p.netsalary,p.remarks,p.empId employeedocno from hr_payroll mp left join hr_payrolld p on mp.doc_no=p.rdocno "
			 + "left join hr_empm m on p.empId=m.doc_no where mp.status=3 and p.status=3 and p.posted=0 and YEAR(mp.date)=YEAR('"+sqlDate+"') and MONTH(mp.date)=MONTH('"+sqlDate+"')"+sql14+"";
        //System.out.println("reload------------------>>>>>>"+sql15);       
		ResultSet resultSet15 = stmtHMSP3.executeQuery(sql15);
		
		while(resultSet15.next()){
			Double tlev=0.0,tallwn=0.0;
			ArrayList<String> temp1=new ArrayList<String>();
			
			temp1.add(resultSet15.getString("employeeid"));
			temp1.add(resultSet15.getString("employeename"));
			temp1.add(resultSet15.getString("totaldays"));
			temp1.add(resultSet15.getString("ot"));
			temp1.add(resultSet15.getString("hot"));
			for (int l = 1; l <= totleaves; l++) {   
				tlev+=resultSet15.getDouble("leave"+l);   
			}
			temp1.add(tlev+"");   
			temp1.add(String.valueOf(resultSet15.getDouble("basic")));
			for (int m = 1; m <= totallowance; m++) {
				tallwn+=resultSet15.getDouble("allowance"+m);    
				}
			temp1.add(tallwn+"");           
			temp1.add(String.valueOf(resultSet15.getDouble("overtime")));
			temp1.add(String.valueOf(resultSet15.getDouble("grosssalary")));
			temp1.add(String.valueOf(resultSet15.getDouble("additions")));
			temp1.add(String.valueOf(resultSet15.getDouble("deductions")));
			temp1.add(String.valueOf(resultSet15.getDouble("loan")));
			temp1.add(String.valueOf(resultSet15.getDouble("netsalary")));
			temp1.add(resultSet15.getString("remarks"));      
			
			employeeProcessed.add(temp1);
		}
		//System.out.println("analysisrowarray====>>>>"+analysisrowarray);
		//System.out.println("employeeProcessed====>>>>>"+employeeProcessed);
		//System.out.println("employeeToBeProcessed=====>>>>"+employeeToBeProcessed);  
		if(employeeToBeProcessed.size()>0){
			analysisrowarray.addAll(employeeProcessed);
			analysisrowarray.addAll(employeeToBeProcessed);	
		} else {
			analysisrowarray=employeeProcessed;
		}
		//System.out.println("analysisrowarray====>>>>"+analysisrowarray);
		printmonthlypayroll2=convertRowPrintArrayToJSON(request2,analysisrowarray,totleaves,totallowance);
		
		stmtHMSP.close();
		stmtHMSP1.close();
		stmtHMSP2.close();
		stmtHMSP3.close();
        
	}
			request.setAttribute("printpayroll", printmonthlypayroll2);      
			bean.setTxtheader(header);            
			//String gross=String.valueOf(request.getAttribute("gross"));     
			//System.out.println("gross========"+gross);  
				bean.setLblgrosstotal(String.valueOf(request.getAttribute("gross")));
				bean.setLbladditiontotal(String.valueOf(request.getAttribute("addn")));
				bean.setLbldeductiontotal(String.valueOf(request.getAttribute("dedn")));
				bean.setLblloantotal(String.valueOf(request.getAttribute("loan")));
				bean.setLblnetsalarytotal(String.valueOf(request.getAttribute("netsal")));
			
			String sql3 = "select max(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,max(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from hr_payroll m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='HMSP' and m.brhid="+branch+" and m.doc_no="+docNo+"";
			//System.out.println("sql3========"+sql3);                              
			ResultSet resultSet3 = stmtss.executeQuery(sql3);
			  
			while(resultSet3.next()){
				bean.setLblpreparedon(resultSet3.getString("preparedon"));
				bean.setLblpreparedat(resultSet3.getString("preparedat"));
			}
		
			stmtss.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			 conn.close();
		}
		return bean;
	}  
	   public  ArrayList<String> convertRowPrintArrayToJSON(HttpServletRequest request,ArrayList<ArrayList<String>> rowsAnalysisList,int leavelength,int allowancelength) throws Exception {
			
				ArrayList<String> printmonthlypayroll= new ArrayList<String>();
				Double netsal=0.0,dedn=0.0,gross=0.0,addn=0.0,loan=0.0;
				for (int i = 0; i < rowsAnalysisList.size(); i++) {
					
					ArrayList<String> analysisRowArray=rowsAnalysisList.get(i);
					String temp="";
					
					temp=analysisRowArray.get(0)+":: "+analysisRowArray.get(1)+":: "+analysisRowArray.get(2)+":: "+analysisRowArray.get(5)+":: "+analysisRowArray.get(6)+":: "+analysisRowArray.get(7)+":: "+analysisRowArray.get(3)+":: "+analysisRowArray.get(4)+":: "+analysisRowArray.get(8)+":: "+analysisRowArray.get(9)+":: "+analysisRowArray.get(10)+":: "+analysisRowArray.get(11)+":: "+analysisRowArray.get(12)+":: "+analysisRowArray.get(13)+":: "+analysisRowArray.get(14);
					 netsal+=Double.parseDouble(analysisRowArray.get(13));
					 dedn+=Double.parseDouble(analysisRowArray.get(11));
					 gross+=Double.parseDouble(analysisRowArray.get(9));
					 addn+=Double.parseDouble(analysisRowArray.get(10));
					 loan+=Double.parseDouble(analysisRowArray.get(12));  
					printmonthlypayroll.add(temp);
					
				}
				request.setAttribute("gross", gross);  
				request.setAttribute("netsal", netsal); 
				request.setAttribute("dedn", dedn); 
				request.setAttribute("addn", addn); 
				request.setAttribute("loan", loan); 
				return printmonthlypayroll;
		}      
	 
}
