package com.humanresource.transactions.terminationbenefits;

import java.sql.CallableStatement;
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

import com.common.ClsAmountToWords;
import com.common.ClsCommonHR;
import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsTerminationBenefitsDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsTerminationBenefitsBean terminationBenefitsPostingBean = new ClsTerminationBenefitsBean();
	
	public int insert(String formdetailcode, String branch,Date terminationBenfitDate, double txtterminalbenefitstotal, double txtleavesalarytotal, double txttravelstotal, ArrayList<String> employeedetailsarray, ArrayList<String> journalvouchersarray, 
			HttpSession session,HttpServletRequest request,String mode) throws SQLException {
		Connection conn = null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			int total = 0;
			
			CallableStatement stmtTEB = conn.prepareCall("{CALL HRTerminalBenefitsmDML(?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtTEB.registerOutParameter(9, java.sql.Types.INTEGER);
			stmtTEB.registerOutParameter(10, java.sql.Types.INTEGER);
			
			stmtTEB.setDate(1,terminationBenfitDate);
			stmtTEB.setDouble(2,txtterminalbenefitstotal);
			stmtTEB.setDouble(3,txtleavesalarytotal);
			stmtTEB.setDouble(4,txttravelstotal);
			stmtTEB.setString(5,formdetailcode);
			stmtTEB.setString(6,company);
			stmtTEB.setString(7,branch);
			stmtTEB.setString(8,userid);
			stmtTEB.setString(11,mode);
			int datas=stmtTEB.executeUpdate();
			if(datas<=0){
				stmtTEB.close();
				conn.close();
				return 0;
			}
			int docno=stmtTEB.getInt("docNo");
			int trno=stmtTEB.getInt("itranNo");
			request.setAttribute("tranno", trno);
			terminationBenefitsPostingBean.setTxtjvno(docno);
			if (docno > 0) {
				/*Insertion to hr_emptran,my_jvtran*/
				int insertData=insertion(conn, docno, branch, trno, formdetailcode, terminationBenfitDate, employeedetailsarray, journalvouchersarray, session,mode);
				if(insertData<=0){
					stmtTEB.close();
					conn.close();
					return 0;
				}
				/*Insertion to hr_emptran,my_jvtran Ends*/
					
				String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
				ResultSet resultSet = stmtTEB.executeQuery(sql1);
			    
				 while (resultSet.next()) {
					 total=resultSet.getInt("jvtotal");
				 }
				 
				 if(total == 0) {
					conn.commit();
					stmtTEB.close();
					conn.close();
					return docno;
				 } else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
				        stmtTEB.close();
					    return 0;
				    }
			}
			
			stmtTEB.close();
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

	
	public JSONArray terminationDetailsProcessing(String branch,String deprDate) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		
        try {
				conn = connDAO.getMyConnection();
				Statement stmtTEB = conn.createStatement();
				
				Statement stmtTerminationResignationConfig=conn.createStatement();
				
				int trconfig=0;
				String configTR="select method from gl_config where field_nme='HRTerminationResignationCalc'";
				ResultSet resultSetTR = stmtTerminationResignationConfig.executeQuery(configTR);
		        while(resultSetTR.next()){
		        	trconfig=resultSetTR.getInt("method");
		        }
		
				java.sql.Date sqlDeprDate = null;
		        
		        if(!(deprDate.equalsIgnoreCase("undefined")) && !(deprDate.equalsIgnoreCase("")) && !(deprDate.equalsIgnoreCase("0"))){
		        	sqlDeprDate = commonDAO.changeStringtoSqlDate(deprDate);
		        }
			    
		        String totalterminalleave="";
		        String sqls="select CONCAT('t.tot_leave',coalesce(doc_no,1)) leavestype from hr_setleave where status=3 and terminal_leavid=1";
		        ResultSet resultSets = stmtTEB.executeQuery(sqls);
		        int i=0,j=0;
		        while(resultSets.next()){
		        	
		        	if(i==0){
		        		totalterminalleave+=resultSets.getString("leavestype");
		        	} else {
		        		totalterminalleave+="+"+resultSets.getString("leavestype");
		        	}
		        	
		        	i++;
		        	j=1;
		        }
		        
		        if(j==0){
		        	totalterminalleave+="t.tot_leave1";
		        }
		        
				String sql = "select m.doc_no employeedocno,m.codeno employeeid,m.name employeename,m.dtjoin joiningdate,m.desc_id,m.pay_catid,m.terminal_benefits,round(m.travels,2) travels,ds.desc1 designation,cat.desc1 category,round(DATEDIFF('"+sqlDeprDate+"',m.dtjoin)/365,2) years, "
						   + "if((MONTH(m.dtjoin)=MONTH('"+sqlDeprDate+"') and YEAR(m.dtjoin)=YEAR('"+sqlDeprDate+"')),round((DATEDIFF('"+sqlDeprDate+"',m.dtjoin)+1)-("+totalterminalleave+"),1),round(DAY(LAST_DAY('"+sqlDeprDate+"'))-("+totalterminalleave+"),1)) daysworked from hr_empm m left join hr_timesheet t on "
						   + "(m.doc_no=t.empid and t.year=YEAR('"+sqlDeprDate+"') and t.month=MONTH('"+sqlDeprDate+"')) left join hr_setdesig ds on ds.doc_no=m.desc_id left join hr_setpaycat cat on m.pay_catid=cat.doc_no where m.status=3 and m.active=1 and t.payroll_processed!=0 and "
						   + "t.payroll_confirmed!=0 and m.terminal_benefits<'"+sqlDeprDate+"'";
				
				ResultSet resultSet = stmtTEB.executeQuery(sql);

				ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<ArrayList<String>>();
				ClsCommonHR hrCalc = new ClsCommonHR();
				String oldempid="",newempid="",empCategoryID="";
				
				while(resultSet.next()){
					ArrayList<String> temp=new ArrayList<String>();
					String terminalbenefitstobeposteddays="0",salaryAmount="0.00",leaveSalaryAmount="0.00",leavesalarytobeposteddays="0";
					
					newempid=resultSet.getString("employeedocno");
					empCategoryID=resultSet.getString("pay_catid");
					
					if(oldempid!=newempid){
						temp.add(newempid);
						temp.add(resultSet.getString("employeeid"));
						temp.add(resultSet.getString("employeename"));
						temp.add(resultSet.getString("designation"));
						temp.add(resultSet.getString("category"));
						temp.add(resultSet.getString("joiningdate"));
						temp.add(resultSet.getString("years"));
						
						/*Terminal Benefits To be Posted Days*/
						if(trconfig==1){
							/*Resignation Details used for calculation*/
							terminalbenefitstobeposteddays= hrCalc.getHRTerminationBenefitToBePostedDaysForResignation(conn,empCategoryID,resultSet.getDouble("years"));
							temp.add(terminalbenefitstobeposteddays);
						}else{
							terminalbenefitstobeposteddays= hrCalc.getHRTerminationBenefitToBePostedDays(conn,empCategoryID,resultSet.getDouble("years"));
							temp.add(terminalbenefitstobeposteddays);
						}
						/*Terminal Benefits To be Posted Days Ends*/
						
						/*Salary Calculation */
						salaryAmount= hrCalc.getHRTerminationBenefitSalary(conn,newempid,empCategoryID);
						temp.add(salaryAmount);
						/*Salary Calculation Ends */
						
						/*Terminal Benefits Amount*/
						temp.add("");
						temp.add("");
						temp.add("");
						/*Terminal Benefits Amount Ends*/
						
						/*Leave Salary Calculation */
						/**
						 * config add on 2018-12-17 for leave salary amount to be same as termination salary
						 */
						String configleavesalary="0";
						String sqlleavesalary="select method from gl_config where field_nme='terleavesalary'";
						Statement stmleavesalary=conn.createStatement();
						ResultSet rsleavesalary=stmleavesalary.executeQuery(sqlleavesalary);
						while(rsleavesalary.next()){
							configleavesalary=rsleavesalary.getString("method");
						}
						if(configleavesalary.equalsIgnoreCase("1")){
						  leaveSalaryAmount= hrCalc.getHRTerminationBenefitSalary(conn,newempid,empCategoryID);
						}
						else{
							leaveSalaryAmount= hrCalc.getHRTerminationBenefitLeaveSalary(conn,newempid,empCategoryID);
						}
						
						temp.add(leaveSalaryAmount);
						/*Leave Salary Calculation Ends */
						
						/*Leave Salary To be Posted Days*/
						leavesalarytobeposteddays= hrCalc.getHRLeaveSalaryToBePostedDays(conn,newempid,empCategoryID,sqlDeprDate);
						temp.add(leavesalarytobeposteddays);
						/*Leave Salary To be Posted Days Ends*/
						
						/*Leave Salary Amount*/
						temp.add("");
						temp.add("");
						temp.add("");
						temp.add("");
						/*Leave Salary Amount Ends*/
						
						/*Travel Total/Year*/
						temp.add(resultSet.getString("travels"));
						/*Travel Total/Year Ends*/
						
						/*Travels Amount*/
						temp.add("");
						temp.add("");
						temp.add("");
						temp.add("");
						temp.add("");
						/*Travels Amount Ends*/
						
						oldempid=newempid;
					}
					
					analysisrowarray.add(temp);
				}
				
				RESULTDATA=convertRowAnalysisArrayToJSON(analysisrowarray);
				
				stmtTEB.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray terminationDetailsCalculating(String branch,String deprDate) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		
        try {
				conn = connDAO.getMyConnection();
				Statement stmtTEB = conn.createStatement();
				Statement stmtTerminationResignationConfig = conn.createStatement();
				
				int trconfig=0;
				String configTR="select method from gl_config where field_nme='HRTerminationResignationCalc'";
				ResultSet resultSetTR = stmtTerminationResignationConfig.executeQuery(configTR);
		        while(resultSetTR.next()){
		        	trconfig=resultSetTR.getInt("method");
		        	System.out.println("config--:"+trconfig);
		        }
				
				java.sql.Date sqlDeprDate = null;
		        
		        if(!(deprDate.equalsIgnoreCase("undefined")) && !(deprDate.equalsIgnoreCase("")) && !(deprDate.equalsIgnoreCase("0"))){
		        	sqlDeprDate = commonDAO.changeStringtoSqlDate(deprDate);
		        }
		        
		        String totalterminalleave="";
		        String sqls="select CONCAT('t.tot_leave',coalesce(doc_no,1)) leavestype from hr_setleave where status=3 and terminal_leavid=1";
		        ResultSet resultSets = stmtTEB.executeQuery(sqls);
		        int i=0,j=0;
		        while(resultSets.next()){
		        	
		        	if(i==0){
		        		totalterminalleave+=resultSets.getString("leavestype");
		        	} else {
		        		totalterminalleave+="+"+resultSets.getString("leavestype");
		        	}
		        	
		        	i++;
		        	j=1;
		        }
		        
		        if(j==0){
		        	totalterminalleave+="t.tot_leave1";
		        }
		        
				String sql = "select m.doc_no employeedocno,m.codeno employeeid,m.name employeename,m.dtjoin joiningdate,m.desc_id,m.pay_catid,m.terminal_benefits,round(m.travels,2) travels,ds.desc1 designation,cat.desc1 category,round(DATEDIFF('"+sqlDeprDate+"',m.dtjoin)/365,2) years,coalesce(round(a.terminalbenefitsalreadyposted,2),0) terminalbenefitsalreadyposted,"
						+ "coalesce(round(a.leavesalaryalreadyposted,2),0) leavesalaryalreadyposted,coalesce(round(a.travelsalreadyposted,2),0) travelsalreadyposted,coalesce(round(a.leavesalaryeligibledays,2),0) totalleavesalaryeligibledays,coalesce(round(a.travelseligibledays,2),0) totaltravelseligibledays,DAY(LAST_DAY('"+sqlDeprDate+"')) traveltobeposteddays,"
						+ "if((MONTH(m.dtjoin)=MONTH('"+sqlDeprDate+"') and YEAR(m.dtjoin)=YEAR('"+sqlDeprDate+"')),round((DATEDIFF('"+sqlDeprDate+"',m.dtjoin)+1)-("+totalterminalleave+"),1),round(DAY(LAST_DAY('"+sqlDeprDate+"'))-("+totalterminalleave+"),1)) daysworked from hr_empm m left join hr_timesheet t on (m.doc_no=t.empid and t.year=YEAR('"+sqlDeprDate+"') and t.month=MONTH('"+sqlDeprDate+"')) "
						+ "left join hr_setdesig ds on ds.doc_no=m.desc_id left join hr_setpaycat cat on m.pay_catid=cat.doc_no left join ( "
						+ "select coalesce(sum(tb.terminalbenefitsalreadyposted),0) terminalbenefitsalreadyposted,coalesce(sum(tb.leavesalaryalreadyposted),0) leavesalaryalreadyposted,coalesce(sum(tb.travelsalreadyposted),0) travelsalreadyposted,coalesce(sum(tb.leavesalaryeligibledays),0) leavesalaryeligibledays,coalesce(sum(tb.travelseligibledays),0) travelseligibledays,"
						+ "tb.empid from (select (coalesce(terminalbenefits_tobeposted,0)) terminalbenefitsalreadyposted,(coalesce(leavesalary_tobeposted,0)) leavesalaryalreadyposted,(coalesce(travels_tobeposted,0)) travelsalreadyposted,leavesalary_eligible_days leavesalaryeligibledays,"
						+ "travels_eligible_days travelseligibledays,empid from hr_emptran) tb group by tb.empid) a on a.empid=m.doc_no where m.status=3 and m.active=1 and t.payroll_processed!=0 and t.payroll_confirmed!=0 and m.terminal_benefits<'"+sqlDeprDate+"'";					
				ResultSet resultSet = stmtTEB.executeQuery(sql);

				ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<ArrayList<String>>();
				ClsCommonHR hrCalc = new ClsCommonHR();
				String oldempid="",newempid="",empCategoryID="";
				
				while(resultSet.next()){
					ArrayList<String> temp=new ArrayList<String>();
					String tobeposteddays="0",salaryAmount="0.00",leaveSalaryAmount="0.00",terminalBenefitCurrentProvisionAmount="0.00",leavesalarytobeposteddays="0",leavesalarytobepostedtotaldays="0",leaveSalaryCurrentProvisionAmount="0.00",traveltobepostedtotaldays="0",traveltobepostedyears="0",travelCurrentProvisionAmount="0.00";
					
					newempid=resultSet.getString("employeedocno");
					empCategoryID=resultSet.getString("pay_catid");
					
					if(oldempid!=newempid){
						temp.add(newempid);
						temp.add(resultSet.getString("employeeid"));
						temp.add(resultSet.getString("employeename"));
						temp.add(resultSet.getString("designation"));
						temp.add(resultSet.getString("category"));
						temp.add(resultSet.getString("joiningdate"));
						temp.add(resultSet.getString("years"));
						
						/*To be Posted Days*/
						if(trconfig==1){
							/*Resignation Details used for calculation*/
							tobeposteddays= hrCalc.getHRTerminationBenefitToBePostedDaysForResignation(conn,empCategoryID,resultSet.getDouble("years"));
							temp.add(tobeposteddays);
						}else{
							tobeposteddays= hrCalc.getHRTerminationBenefitToBePostedDays(conn,empCategoryID,resultSet.getDouble("years"));
							temp.add(tobeposteddays);
						}
						/*To be Posted Days Ends*/
						
						/*Salary Calculation */
						salaryAmount= hrCalc.getHRTerminationBenefitSalary(conn,newempid,empCategoryID);
						temp.add(salaryAmount);
						/*Salary Calculation Ends */
						
						/*Terminal Benefit Current Provision Calculation */
						terminalBenefitCurrentProvisionAmount= hrCalc.getHRTerminalBenefitCurrentProvision(conn,tobeposteddays,salaryAmount);
						temp.add(terminalBenefitCurrentProvisionAmount);
						/*Terminal Benefit Current Provision Calculation Ends */
						
						temp.add(resultSet.getString("terminalbenefitsalreadyposted"));
						temp.add(String.valueOf(Math.round(Double.parseDouble(terminalBenefitCurrentProvisionAmount)-resultSet.getDouble("terminalbenefitsalreadyposted"))));
						
						/*Leave Salary Calculation */
						/*Leave Salary Calculation */
						/**
						 * config add on 2018-12-17 for leave salary amount to be same as termination salary
						 */
						String configleavesalary="0";
						String sqlleavesalary="select method from gl_config where field_nme='terleavesalary'";
						Statement stmleavesalary=conn.createStatement();
						ResultSet rsleavesalary=stmleavesalary.executeQuery(sqlleavesalary);
						while(rsleavesalary.next()){
							configleavesalary=rsleavesalary.getString("method");
						}
						if(configleavesalary.equalsIgnoreCase("1")){
						  leaveSalaryAmount= hrCalc.getHRTerminationBenefitSalary(conn,newempid,empCategoryID);
						}
						else{
							leaveSalaryAmount= hrCalc.getHRTerminationBenefitLeaveSalary(conn,newempid,empCategoryID);
						}
						
						temp.add(leaveSalaryAmount);
						/*Leave Salary Calculation Ends */
						
						/*Leave Salary To be Posted Days*/
						leavesalarytobeposteddays= hrCalc.getHRLeaveSalaryToBePostedDays(conn,newempid,empCategoryID,sqlDeprDate);
						temp.add(leavesalarytobeposteddays);
						leavesalarytobepostedtotaldays=String.valueOf(resultSet.getDouble("totalleavesalaryeligibledays")+Double.parseDouble(leavesalarytobeposteddays));
						temp.add(leavesalarytobepostedtotaldays);
						/*Leave Salary To be Posted Days Ends*/
						
						/*Leave Salary Current Provision Calculation */
						leaveSalaryCurrentProvisionAmount= hrCalc.getHRLeaveSalaryTobePosted(conn,leavesalarytobepostedtotaldays,leaveSalaryAmount);
						temp.add(leaveSalaryCurrentProvisionAmount);
						/*Leave Salary Current Provision Calculation Ends */
						
						temp.add(resultSet.getString("leavesalaryalreadyposted"));
						temp.add(String.valueOf(Math.round(Double.parseDouble(leaveSalaryCurrentProvisionAmount)-resultSet.getDouble("leavesalaryalreadyposted"))));
						
						/*Travel To be Posted Days*/
						temp.add(resultSet.getString("travels"));
						traveltobepostedyears= hrCalc.getHRTravelsToBePostedYears(conn,empCategoryID,sqlDeprDate);
						/*Travel To be Posted Days Ends*/
						
						temp.add(resultSet.getString("daysworked"));
						traveltobepostedtotaldays=String.valueOf(resultSet.getDouble("totaltravelseligibledays")+resultSet.getDouble("daysworked"));
						temp.add(traveltobepostedtotaldays);
						
						/*Travels To be Posted Calculation */
						travelCurrentProvisionAmount= hrCalc.getHRTravelsTobePosted(conn,traveltobepostedtotaldays,traveltobepostedyears,resultSet.getString("travels"));
						temp.add(travelCurrentProvisionAmount);
						/*Travels To be Posted Calculation Ends */
						
						temp.add(resultSet.getString("travelsalreadyposted"));
						temp.add(String.valueOf(Math.round(Double.parseDouble(travelCurrentProvisionAmount)-resultSet.getDouble("travelsalreadyposted"))));
						
						
						oldempid=newempid;
					}
					
					analysisrowarray.add(temp);
				}
				
				RESULTDATA=convertRowAnalysisArrayToJSON(analysisrowarray);
				
				stmtTEB.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray terminationBenefitsReloading(String docno,String trno) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtTEB = conn.createStatement();
				
				String sql = "select d.empid employeedocno,round(d.salary,2) salary,d.terminalbenefits_worked_yrs terminalbenefitsyears,d.terminalbenefits_eligible_days terminalbenefitsdaystobeposted,"
					  + "round(d.terminalbenefits_currentprovision,2) terminalbenefitscurrentprovision,round(d.terminalbenefits_alreadyposted,2) terminalbenefitsalreadyposted,"
					  + "round(d.terminalbenefits_tobeposted,2) terminalbenefitstobeposted,round(d.leavesalary,2) leavesalary,round(d.leavesalary_eligible_days,1) leavesalarydaystobeposted," 
					  + "round(d.leavesalary_total_eligibledays,1) leavesalarytotaldaysposted,round(d.leavesalary_currentprovision,2) leavesalarycurrentprovision,round(d.leavesalary_alreadyposted,2) leavesalaryalreadyposted,"
					  + "round(d.leavesalary_tobeposted,2) leavesalarytobeposted,round(d.travels_totalperyear,2) travelstotalperyear,round(d.travels_eligible_days,1) travelsdaystobeposted," 
					  + "round(d.travels_total_eligibledays,1) travelstotaldaysposted,round(d.travels_total,2) travelstotal,round(d.travels_alreadyposted,2) travelsalreadyposted,round(d.travels_tobeposted,2) travelstobeposted,"
					  + "m.codeno employeeid, m.name employeename,m.dtjoin joiningdate,ds.desc1 designation,cat.desc1 category from hr_emptran d left join hr_empm m on d.empid=m.doc_no left join hr_setdesig ds on ds.doc_no=m.desc_id "
					  + "left join hr_setpaycat cat on m.pay_catid=cat.doc_no where d.dtype='TEB' and d.tr_no="+trno+" and d.doc_no="+docno+"";
		        
				ResultSet resultSet = stmtTEB.executeQuery(sql);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtTEB.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray terminationBenefitsExcelExport(String docno,String trno) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtTEB = conn.createStatement();
				
				String sql = "select m.codeno 'Emp. ID', m.name 'Emp. Name',ds.desc1 'Designation',cat.desc1 'Category',m.dtjoin 'Date of Joining',round(d.salary,2) 'Salary to be Calculated',d.terminalbenefits_worked_yrs 'Worked(Yrs)',"
					  + "d.terminalbenefits_eligible_days 'Eligible Days',round(d.terminalbenefits_currentprovision,2) 'Terminal Benefits Current Provision',round(d.terminalbenefits_alreadyposted,2) 'Terminal Benefits Already Posted',"
					  + "round(d.terminalbenefits_tobeposted,2) 'Terminal Benefits To be Posted',round(d.leavesalary,2) 'Leave Salary to be Calculated',round(d.leavesalary_eligible_days,1) 'Leave Salary  Current Eligible Days'," 
					  + "round(d.leavesalary_total_eligibledays,1) 'Leave Salary Eligible Days',round(d.leavesalary_currentprovision,2) 'Leave Salary Current Provision',round(d.leavesalary_alreadyposted,2) 'Leave Salary Already Posted',"
					  + "round(d.leavesalary_tobeposted,2) 'Leave Salary To be Posted',round(d.travels_totalperyear,2) 'Travels Total/Year',round(d.travels_total_eligibledays,1) 'Travels Eligible Days',round(d.travels_total,2) 'Travels Total',"
					  + "round(d.travels_alreadyposted,2) 'Travels Already Posted',round(d.travels_tobeposted,2) 'Travels To be Posted' from hr_emptran d left join hr_empm m on d.empid=m.doc_no left join hr_setdesig ds on ds.doc_no=m.desc_id "
					  + "left join hr_setpaycat cat on m.pay_catid=cat.doc_no where d.dtype='TEB' and d.tr_no="+trno+" and d.doc_no="+docno+"";
		        
				ResultSet resultSet = stmtTEB.executeQuery(sql);
				
				RESULTDATA=commonDAO.convertToEXCEL(resultSet);
				
				stmtTEB.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }

	public JSONArray accountDetailsGridLoading() throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtTEB = conn.createStatement();
				
				String sql = "select h.doc_no acno,h.account,h.description codeno from my_account a left join my_head h on a.acno=h.doc_no where a.codeno IN ('HREXPENSE1TERMINATIONEXPENSE','HREXPENSE2LEAVESALARYEXPENSEACCOUNT','HREXPENSE3TRAVELEXPENSEACCOUNT','HRPROVISION1TERMINATIONBENEFIT','HRPROVISION2LEAVESALARYBENEFITACCOUNT','HRPROVISION3TRAVELBENEFITACCOUNT') order by a.codeno";
		        
				ResultSet resultSet = stmtTEB.executeQuery(sql);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtTEB.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray accountDetailsGridReloading(String trno) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtTEB = conn.createStatement();
            	
				String sql = "select j.acno,if(j.dramount>0,j.dramount*j.id,0) debit ,if(j.dramount<0,j.dramount*j.id,0) credit,t.account,t.description codeno "
						+ "from my_jvtran j left join my_head t on j.acno=t.doc_no WHERE j.dtype='TEB' and j.tr_no="+trno+"";
            	
				ResultSet resultSet = stmtTEB.executeQuery(sql);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtTEB.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray tebMainSearch(String branch,String partyname,String docNo,String date,String tbamount, String lsamount, String travelamount) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
           
        java.sql.Date sqlDepriciationDate=null;
           
     try {
	       conn = connDAO.getMyConnection();
	       Statement stmtTEB = conn.createStatement();
	       
	       date.trim();
	        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	        {
	        	sqlDepriciationDate = commonDAO.changeStringtoSqlDate(date);
	        }

	        String sqltest="";
	        
	        if(!(docNo.equalsIgnoreCase(""))){
	            sqltest=sqltest+" and m.doc_no like '%"+docNo+"%'";
	        }
	        if(!(partyname.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and u.user_name like '%"+partyname+"%'";
	        }
	        if(!(tbamount.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and m.terminalbenefits_total like '%"+tbamount+"%'";
	        }
	        if(!(lsamount.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and m.leavesalary_total like '%"+lsamount+"%'";
		    }
	        if(!(travelamount.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and m.travels_total like '%"+travelamount+"%'";
		    }
	        if(!(sqlDepriciationDate==null)){
		         sqltest=sqltest+" and m.date='"+sqlDepriciationDate+"'";
		    } 
	        
	       ResultSet resultSet = stmtTEB.executeQuery("select m.date,m.doc_no,m.terminalbenefits_total,m.leavesalary_total,m.travels_total,m.tr_no,u.user_name from hr_terminalbenefitsm m left join my_user u on m.userid=u.doc_no where m.brhid='"+branch+"' and m.status=3" +sqltest);
	
	       RESULTDATA=commonDAO.convertToJSON(resultSet);
	       
	       stmtTEB.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
 		conn.close();
 	}
       return RESULTDATA;
   }
	
	public ClsTerminationBenefitsBean getPrint(HttpServletRequest request,int docNo,int branch,int header) throws SQLException {
		 ClsTerminationBenefitsBean bean = new ClsTerminationBenefitsBean();
		 Connection conn = null;
		 
		try {
			conn = connDAO.getMyConnection();
			Statement stmtTEB = conn.createStatement();
			
			int trno=0;
			
			String headersql="select if(m.dtype='TEB','Terminal Benefits','  ') vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
					+ "b.cstno from hr_terminalbenefitsm m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='TEB' "
					+ "and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSetHead = stmtTEB.executeQuery(headersql);
			
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

			ClsAmountToWords c = new ClsAmountToWords();
			
			String sqls="select m.doc_no,DATE_FORMAT(m.date ,'%d-%m-%Y') date,round(m.terminalbenefits_total+m.leavesalary_total+m.travels_total,2) deprtotal,round(m.terminalbenefits_total,2) terminalbenefitstotal,round(m.leavesalary_total,2) leavesalarytotal,round(m.travels_total,2) travelstotal,"
					+ "m.tr_no,u.user_name from hr_terminalbenefitsm m left join my_user u on m.userid=u.doc_no where m.dtype='TEB' and m.brhid="+branch+" and m.doc_no="+docNo+"";
				
			ResultSet resultSets = stmtTEB.executeQuery(sqls);
			
			while(resultSets.next()){
				
				bean.setLblvoucherno(resultSets.getString("doc_no"));
				bean.setLbldate(resultSets.getString("date"));
				bean.setLbldepreciationtotal(resultSets.getString("deprtotal"));
				bean.setLbldebittotal(resultSets.getString("deprtotal"));
				bean.setLblcredittotal(resultSets.getString("deprtotal"));
				bean.setLblterminalbenefits(resultSets.getString("terminalbenefitstotal"));
				bean.setLblleavesalary(resultSets.getString("leavesalarytotal"));
				bean.setLbltravel(resultSets.getString("travelstotal"));
				bean.setLblnetamount(resultSets.getString("deprtotal"));
				bean.setLblnetamountwords(c.convertAmountToWords(resultSets.getString("deprtotal")));
				bean.setLblpreparedby(resultSets.getString("user_name"));
				trno=resultSets.getInt("tr_no");
			}
			
			bean.setTxtheader(header);
			
			String sql1 = "";

			sql1 = "select j.acno,if(j.dramount>0,round(j.dramount*j.id,2),'  ') debit ,if(j.dramount<0,round(j.dramount*j.id,2),'  ') credit,t.account,t.description codeno "
					+ "from my_jvtran j left join my_head t on j.acno=t.doc_no WHERE j.dtype='TEB' and j.tr_no="+trno+"";
				
			ResultSet resultSet1 = stmtTEB.executeQuery(sql1);
			
			ArrayList<String> printaccounting= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setFirstarray(1);
				String temp="";
				temp=resultSet1.getString("account")+"::"+resultSet1.getString("codeno")+"::"+resultSet1.getString("debit")+"::"+resultSet1.getString("credit");
				printaccounting.add(temp);
			}
			
			request.setAttribute("printaccounting", printaccounting);

			String sql2 = "";
			
			/* sql2 = "select d.empid employeedocno, round(d.terminalbenefits_eligible_days,1) daystobeposted, round(d.terminalbenefits_currentprovision,2) currentdepr,round(d.terminalbenefits_alreadyposted,2) alreadydepr,round(d.terminalbenefits_tobeposted,2) posteddepr,m.codeno employeeid, m.name employeename, DATE_FORMAT(m.dtjoin,'%d-%m-%Y') joiningdate from hr_emptran d left join hr_empm m on "
				  + "d.empid=m.doc_no where d.tr_no="+trno+" and d.doc_no="+docNo+"";
			 */
			 sql2 = "select d.empid employeedocno, round(d.terminalbenefits_eligible_days,1) daystobeposted, round(d.terminalbenefits_currentprovision,2) currentdepr,round(d.terminalbenefits_alreadyposted,2) alreadydepr,round(d.terminalbenefits_tobeposted,2) posteddepr,m.codeno employeeid, m.name employeename, DATE_FORMAT(m.dtjoin,'%d-%m-%Y') joiningdate from hr_emptran d left join hr_empm m on "
					  + "d.empid=m.doc_no where d.tr_no=0 and d.doc_no=0";
				 
			ResultSet resultSet2 = stmtTEB.executeQuery(sql2);
			
			ArrayList<String> printarray= new ArrayList<String>();
			
			while(resultSet2.next()){
				bean.setSecarray(2); 
				String temp="";
				temp=resultSet2.getString("employeeid")+"::"+resultSet2.getString("employeename")+"::"+resultSet2.getString("joiningdate")+"::"+resultSet2.getString("daystobeposted")+"::"+resultSet2.getString("currentdepr")+"::"+resultSet2.getString("alreadydepr")+"::"+resultSet2.getString("posteddepr");
			    printarray.add(temp);
			}

			request.setAttribute("printingarray", printarray);
			
			String sql3 = "select max(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,max(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from hr_terminalbenefitsm m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='TEB' and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSet3 = stmtTEB.executeQuery(sql3);
			
			while(resultSet3.next()){
				bean.setLblpreparedon(resultSet3.getString("preparedon"));
				bean.setLblpreparedat(resultSet3.getString("preparedat"));
			}
		
			stmtTEB.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return bean;
	}
	
	public int insertion(Connection conn,int docno,String branch,int trno,String formdetailcode,Date terminationBenfitDate, ArrayList<String> employeedetailsarray,ArrayList<String> journalvouchersarray,
			 HttpSession session,String mode) throws SQLException{
		
		  try{
				conn.setAutoCommit(false);
				CallableStatement stmtTEB;
				Statement stmtTEB1 = conn.createStatement();
				
				String userid=session.getAttribute("USERID").toString().trim();
				
				/*Terminal Benefits Details Grid and Details Saving*/
				for(int i=0;i< employeedetailsarray.size();i++){
					String[] terminationbenefitsdetail=employeedetailsarray.get(i).split("::");
					if(!terminationbenefitsdetail[0].trim().equalsIgnoreCase("undefined") && !terminationbenefitsdetail[0].trim().equalsIgnoreCase("NaN")){
					
					int terminalBenefitAccountNo=0,leaveSalaryAccountNo=0,travelsAccountNo=0;
					/*Selecting account no.*/
					String sqls=("select @i:=@i+1 id,a.acno from (select acno,codeno from my_account where codeno IN ('HRPROVISION1TERMINATIONBENEFIT','HRPROVISION2LEAVESALARYBENEFITACCOUNT','HRPROVISION3TRAVELBENEFITACCOUNT') order by codeno) a,(SELECT @i:= 0) as i");
					ResultSet resultSets = stmtTEB1.executeQuery(sqls);
					    
					 while (resultSets.next()) {
						 if(resultSets.getInt("id")==1) {
							 terminalBenefitAccountNo=resultSets.getInt("acno");
						 } else if(resultSets.getInt("id")==2) {
							 leaveSalaryAccountNo=resultSets.getInt("acno");
						 } else if(resultSets.getInt("id")==3) {
							 travelsAccountNo=resultSets.getInt("acno");
						 }
					 }
					 /*Selecting account no. Ends*/
					 
					stmtTEB = conn.prepareCall("{CALL HRTerminalBenefitsdDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					/*Insertion to hr_emptran*/
					stmtTEB.setInt(26,trno); 
					stmtTEB.setInt(27,docno);
					stmtTEB.registerOutParameter(28, java.sql.Types.INTEGER);
					
					stmtTEB.setDate(1,terminationBenfitDate); //Date
					
					stmtTEB.setString(2,(terminationbenefitsdetail[0].trim().equalsIgnoreCase("undefined") || terminationbenefitsdetail[0].trim().equalsIgnoreCase("NaN") || terminationbenefitsdetail[0].trim().isEmpty()?0:terminationbenefitsdetail[0].trim()).toString()); //Employee ID
					stmtTEB.setString(3,(terminationbenefitsdetail[1].trim().equalsIgnoreCase("undefined") || terminationbenefitsdetail[1].trim().equalsIgnoreCase("NaN") || terminationbenefitsdetail[1].trim().isEmpty()?0:terminationbenefitsdetail[1].trim()).toString()); //Salary To be processed Amount
					
					stmtTEB.setInt(4,terminalBenefitAccountNo);  //terminal benefit doc_no of my_head
					stmtTEB.setInt(5,leaveSalaryAccountNo);  //leave salary doc_no of my_head
					stmtTEB.setInt(6,travelsAccountNo);  //travels doc_no of my_head
					stmtTEB.setString(7,(terminationbenefitsdetail[2].trim().equalsIgnoreCase("undefined") || terminationbenefitsdetail[2].trim().equalsIgnoreCase("NaN") || terminationbenefitsdetail[2].trim().isEmpty()?0:terminationbenefitsdetail[2].trim()).toString()); //Terminal Benefits Worked Years
					stmtTEB.setString(8,(terminationbenefitsdetail[3].trim().equalsIgnoreCase("undefined") || terminationbenefitsdetail[3].trim().equalsIgnoreCase("NaN") || terminationbenefitsdetail[3].trim().isEmpty()?0:terminationbenefitsdetail[3].trim()).toString()); //Terminal Benefits Eligible Days 
					stmtTEB.setString(9,(terminationbenefitsdetail[4].trim().equalsIgnoreCase("undefined") || terminationbenefitsdetail[4].trim().equalsIgnoreCase("NaN") || terminationbenefitsdetail[4].trim().isEmpty()?0:terminationbenefitsdetail[4].trim()).toString()); //Terminal Benefits Current Provision Amount
					stmtTEB.setString(10,(terminationbenefitsdetail[5].trim().equalsIgnoreCase("undefined") || terminationbenefitsdetail[5].trim().equalsIgnoreCase("NaN") || terminationbenefitsdetail[5].trim().isEmpty()?0:terminationbenefitsdetail[5].trim()).toString()); //Terminal Benefits Already Posted Amount
					stmtTEB.setString(11,(terminationbenefitsdetail[6].trim().equalsIgnoreCase("undefined") || terminationbenefitsdetail[6].trim().equalsIgnoreCase("NaN") || terminationbenefitsdetail[6].trim().isEmpty()?0:terminationbenefitsdetail[6].trim()).toString()); //Terminal Benefits To be Posted Amount
					
					stmtTEB.setString(12,(terminationbenefitsdetail[7].trim().equalsIgnoreCase("undefined") || terminationbenefitsdetail[7].trim().equalsIgnoreCase("NaN") || terminationbenefitsdetail[7].trim().isEmpty()?0:terminationbenefitsdetail[7].trim()).toString()); //Leave Salary To be processed Amount
					stmtTEB.setString(13,(terminationbenefitsdetail[8].trim().equalsIgnoreCase("undefined") || terminationbenefitsdetail[8].trim().equalsIgnoreCase("NaN") || terminationbenefitsdetail[8].trim().isEmpty()?0:terminationbenefitsdetail[8].trim()).toString()); //Leave Salary Eligible Days
					stmtTEB.setString(14,(terminationbenefitsdetail[9].trim().equalsIgnoreCase("undefined") || terminationbenefitsdetail[9].trim().equalsIgnoreCase("NaN") || terminationbenefitsdetail[9].trim().isEmpty()?0:terminationbenefitsdetail[9].trim()).toString()); //Leave Salary Total Eligible Days 
					stmtTEB.setString(15,(terminationbenefitsdetail[10].trim().equalsIgnoreCase("undefined") || terminationbenefitsdetail[10].trim().equalsIgnoreCase("NaN") || terminationbenefitsdetail[10].trim().isEmpty()?0:terminationbenefitsdetail[10].trim()).toString()); //Leave Salary Current Provision Amount
					stmtTEB.setString(16,(terminationbenefitsdetail[11].trim().equalsIgnoreCase("undefined") || terminationbenefitsdetail[11].trim().equalsIgnoreCase("NaN") || terminationbenefitsdetail[11].trim().isEmpty()?0:terminationbenefitsdetail[11].trim()).toString()); //Leave Salary Already Posted Amount
					stmtTEB.setString(17,(terminationbenefitsdetail[12].trim().equalsIgnoreCase("undefined") || terminationbenefitsdetail[12].trim().equalsIgnoreCase("NaN") || terminationbenefitsdetail[12].trim().isEmpty()?0:terminationbenefitsdetail[12].trim()).toString()); //Leave Salary To be Posted Amount
					
					stmtTEB.setString(18,(terminationbenefitsdetail[13].trim().equalsIgnoreCase("undefined") || terminationbenefitsdetail[13].trim().equalsIgnoreCase("NaN") || terminationbenefitsdetail[13].trim().isEmpty()?0:terminationbenefitsdetail[13].trim()).toString()); //Travels Total/Year
					stmtTEB.setString(19,(terminationbenefitsdetail[14].trim().equalsIgnoreCase("undefined") || terminationbenefitsdetail[14].trim().equalsIgnoreCase("NaN") || terminationbenefitsdetail[14].trim().isEmpty()?0:terminationbenefitsdetail[14].trim()).toString()); //Travels Eligible Days
					stmtTEB.setString(20,(terminationbenefitsdetail[15].trim().equalsIgnoreCase("undefined") || terminationbenefitsdetail[15].trim().equalsIgnoreCase("NaN") || terminationbenefitsdetail[15].trim().isEmpty()?0:terminationbenefitsdetail[15].trim()).toString()); //Travels Total Eligible Days 
					stmtTEB.setString(21,(terminationbenefitsdetail[16].trim().equalsIgnoreCase("undefined") || terminationbenefitsdetail[16].trim().equalsIgnoreCase("NaN") || terminationbenefitsdetail[16].trim().isEmpty()?0:terminationbenefitsdetail[16].trim()).toString()); //Travels Current Provision Amount
					stmtTEB.setString(22,(terminationbenefitsdetail[17].trim().equalsIgnoreCase("undefined") || terminationbenefitsdetail[17].trim().equalsIgnoreCase("NaN") || terminationbenefitsdetail[17].trim().isEmpty()?0:terminationbenefitsdetail[17].trim()).toString()); //Travels Already Posted Amount
					stmtTEB.setString(23,(terminationbenefitsdetail[18].trim().equalsIgnoreCase("undefined") || terminationbenefitsdetail[18].trim().equalsIgnoreCase("NaN") || terminationbenefitsdetail[18].trim().isEmpty()?0:terminationbenefitsdetail[18].trim()).toString()); //Travels To be Posted Amount
					
					stmtTEB.setString(24,formdetailcode);
					stmtTEB.setString(25,branch);
					stmtTEB.setString(29,mode);
					int detail=stmtTEB.executeUpdate();
						if(detail<=0){
							stmtTEB.close();
							conn.close();
							return 0;
						}
     				  }
				    }
				    /*Terminal Benefits Details Grid and Details Saving Ends*/
				
					/*Journal Voucher Grid Saving*/
					for(int i=0;i< journalvouchersarray.size();i++){
					String[] journal=journalvouchersarray.get(i).split("::");
					if(!journal[0].trim().equalsIgnoreCase("undefined") && !journal[0].trim().equalsIgnoreCase("NaN")){
					
					stmtTEB = conn.prepareCall("{CALL HRTerminalBenefitsJournaldDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					/*Insertion to my_jvtran*/
					stmtTEB.setInt(10,docno);
					stmtTEB.setInt(11,trno);
					stmtTEB.setDate(1,terminationBenfitDate); //Date
					stmtTEB.setString(2,"TEB - "+docno);
					stmtTEB.setInt(3,(i+1)); //SR_No
					stmtTEB.setString(4,(journal[0].trim().equalsIgnoreCase("undefined") || journal[0].trim().equalsIgnoreCase("NaN") || journal[0].trim().isEmpty()?0:journal[0].trim()).toString());  //doc_no of my_head
					stmtTEB.setString(5,(journal[1].trim().equalsIgnoreCase("undefined") || journal[1].trim().equalsIgnoreCase("NaN") || journal[1].trim().isEmpty()?0:journal[1].trim()).toString()); //amount
					stmtTEB.setString(6,(journal[2].trim().equalsIgnoreCase("undefined") || journal[2].trim().equalsIgnoreCase("NaN") || journal[2].trim().isEmpty()?0:journal[2].trim()).toString()); //credit -1 & debit 1
					stmtTEB.setString(7,formdetailcode);
					stmtTEB.setString(8,branch);
					stmtTEB.setString(9,userid);
					stmtTEB.setString(12,mode);
					stmtTEB.execute();
						
					if(stmtTEB.getInt("docNo")<=0){
						stmtTEB.close();
						conn.close();
						return 0;
					}
					/*my_jvtran Grid Saving Ends*/
						
					 stmtTEB.close();
					 }
				}	
					
				/*Deleting amount of value zero*/
				String sql2=("DELETE FROM hr_emptran where TR_NO="+trno+" and terminalbenefits_tobeposted=0 and leavesalary_tobeposted=0 and travels_tobeposted=0");
			    int data = stmtTEB1.executeUpdate(sql2);
			    /*Deleting amount of value zero ends*/
			    
			    stmtTEB1.close();
	   } catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}
	
	public  JSONArray convertRowAnalysisArrayToJSON(ArrayList<ArrayList<String>> rowsAnalysisList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		
		for (int i = 0; i < rowsAnalysisList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			ArrayList<String> analysisRowArray=rowsAnalysisList.get(i);
			
			obj.put("employeedocno",analysisRowArray.get(0));
			obj.put("employeeid",analysisRowArray.get(1));
			obj.put("employeename",analysisRowArray.get(2));
			obj.put("designation",analysisRowArray.get(3));
			obj.put("category",analysisRowArray.get(4));
			obj.put("joiningdate",analysisRowArray.get(5));
			obj.put("terminalbenefitsyears",analysisRowArray.get(6));
			obj.put("terminalbenefitsdaystobeposted",analysisRowArray.get(7));
			obj.put("salary",analysisRowArray.get(8));
			obj.put("terminalbenefitscurrentprovision",analysisRowArray.get(9));
			obj.put("terminalbenefitsalreadyposted",analysisRowArray.get(10));
			obj.put("terminalbenefitstobeposted",analysisRowArray.get(11));
			obj.put("leavesalary",analysisRowArray.get(12));
			obj.put("leavesalarydaystobeposted",analysisRowArray.get(13));
			obj.put("leavesalarytotaldaysposted",analysisRowArray.get(14));
			obj.put("leavesalarycurrentprovision",analysisRowArray.get(15));
			obj.put("leavesalaryalreadyposted",analysisRowArray.get(16));
			obj.put("leavesalarytobeposted",analysisRowArray.get(17));
			obj.put("travelstotalperyear",analysisRowArray.get(18));
			obj.put("travelsdaystobeposted",analysisRowArray.get(19));
			obj.put("travelstotaldaysposted",analysisRowArray.get(20));
			obj.put("travelstotal",analysisRowArray.get(21));
			obj.put("travelsalreadyposted",analysisRowArray.get(22));
			obj.put("travelstobeposted",analysisRowArray.get(23));
			
			jsonArray.add(obj);
		}
		return jsonArray;
		}
}
