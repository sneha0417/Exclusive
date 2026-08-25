package com.humanresource.transactions.termination;

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
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.common.ClsCommonHR;
import com.connection.ClsConnection;

public class ClsTerminationDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	ClsTerminationBean terminationBean = new ClsTerminationBean();
	
	public int insert(String formdetailcode, String brchName, Date terminationsDate, int txtemployeedocno, Date notifyingDate, Date joinedDate, Date lastAppraisalDate, double txtdrtotal,
			ArrayList<String> employeedetailsarray, ArrayList<String> accountsarray, ArrayList<String> journalvouchersarray, String cmbtype, HttpSession session, HttpServletRequest request, String mode) throws SQLException {
	
		Connection conn = null;
		
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			int total = 0;
			
			CallableStatement stmtHTRE = conn.prepareCall("{CALL HR_TerminationmDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtHTRE.registerOutParameter(11, java.sql.Types.INTEGER);
			stmtHTRE.registerOutParameter(12, java.sql.Types.INTEGER);
			
			stmtHTRE.setDate(1,terminationsDate);
			stmtHTRE.setInt(2,txtemployeedocno);
			stmtHTRE.setDate(3,notifyingDate);
			stmtHTRE.setDate(4,joinedDate);
			stmtHTRE.setDate(5,lastAppraisalDate);
			stmtHTRE.setDouble(6,txtdrtotal);
			stmtHTRE.setString(7,formdetailcode);
			stmtHTRE.setString(8,company);
			stmtHTRE.setString(9,brchName);
			stmtHTRE.setString(10,userid);
			stmtHTRE.setString(13,mode);
			stmtHTRE.setString(14,cmbtype);
			int datas=stmtHTRE.executeUpdate();
			if(datas<=0){
				stmtHTRE.close();
				conn.close();
				return 0;
			}
			int docno=stmtHTRE.getInt("docNo");
			int trno=stmtHTRE.getInt("itranNo");
			request.setAttribute("tranno", trno);
			terminationBean.setTxtterminationdocno(docno);
			
			if (docno > 0) {
				
				/*Insertion to hr_terminationd,hr_terminationaccountd,hr_emptran,my_jvtran*/
				int insertData=insertion(conn, docno, trno, terminationsDate, notifyingDate, brchName, txtemployeedocno, formdetailcode, employeedetailsarray, accountsarray, journalvouchersarray, session,mode);
				if(insertData<=0){
					stmtHTRE.close();
					conn.close();
					return 0;
				}
				/*Insertion to hr_terminationd,hr_terminationaccountd,hr_emptran,my_jvtran Ends*/
				
				String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
				ResultSet resultSet = stmtHTRE.executeQuery(sql1);
			    
				 while (resultSet.next()) {
					 total=resultSet.getInt("jvtotal");
				 }
				
				 if(total == 0) {
					conn.commit();
					stmtHTRE.close();
					conn.close();
					return docno;
				 } else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
				        stmtHTRE.close();
					    return 0;
				 }
		      }
				
			stmtHTRE.close();
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
	
	public JSONArray terminationDetailsProcessing(String branch,String deprDate,String empid,String check,String type) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))) {
        	return RESULTDATA;
        }
        
        Connection conn = null;
        
        try {
    				conn = ClsConnection.getMyConnection();
    				Statement stmtHTRE = conn.createStatement();
    				
    				/*Statement stmtTerminationResignationConfig=conn.createStatement();
    				int trconfig=0;
    				String configTR="select method from gl_config where field_nme='HRTerminationResignationCalc'";
    				ResultSet resultSetTR = stmtTerminationResignationConfig.executeQuery(configTR);
    		        while(resultSetTR.next()){
    		        trconfig=resultSetTR.getInt("method");
    		        }*/
    		
    				java.sql.Date sqlDeprDate = null;
    		        
    		        if(!(deprDate.equalsIgnoreCase("undefined")) && !(deprDate.equalsIgnoreCase("")) && !(deprDate.equalsIgnoreCase("0"))){
    		        	sqlDeprDate = ClsCommon.changeStringtoSqlDate(deprDate);
    		        }
    			    
    		        String totalterminalleave="";
    		        String sqls="select CONCAT('t.tot_leave',coalesce(doc_no,1)) leavestype from hr_setleave where status=3 and terminal_leavid=1";
    		        ResultSet resultSets = stmtHTRE.executeQuery(sqls);
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
    		        
    				String sql = "select m.doc_no employeedocno,a.terminals t,a.terminaltype,if(a.terminals=1,'Salary/Value for Calculation',if(a.terminals=2,'Eligible Days',if(a.terminals=3,'Total Provision Till Date',"
    						+ "if(a.terminals=4,'Already Provided',if(a.terminals=5,'To be Provided',if(a.terminals=6,'Deduction','Net Pay')))))) terminals,coalesce(round(a.terminalbenefitsalreadyposted,2),0) " 
    						+ "terminalbenefitsalreadyposted,coalesce(round(a.leavesalaryalreadyposted,2),0) leavesalaryalreadyposted,coalesce(round(a.travelsalreadyposted,2),0) travelsalreadyposted," 
    						+ "coalesce(round(a.terminalbenefitseligibledays,2),0) terminalbenefitseligibledays,coalesce(round(a.leavesalaryeligibledays,2),0) leavesalaryeligibledays,"
    						+ "coalesce(round(a.travelseligibledays,2),0) travelseligibledays,m.terminal_benefits,round(m.travels,2) travels,DAY(LAST_DAY('"+sqlDeprDate+"')) traveltobeposteddays,"
    						+ "m.dtjoin joiningdate,m.pay_catid,round(DATEDIFF('"+sqlDeprDate+"',m.dtjoin)/365,2) years,round(DAY('"+sqlDeprDate+"')-("+totalterminalleave+"),1) daysworked from hr_empm m "
    						+ "left join hr_timesheet t on (m.doc_no=t.empid and t.year=YEAR('"+sqlDeprDate+"') and t.month=MONTH('"+sqlDeprDate+"')) left join hr_setdesig ds on ds.doc_no=m.desc_id left join " 
    						+ "hr_setpaycat cat on m.pay_catid=cat.doc_no left join ( select 1 terminals,'CALC' terminaltype,0 terminalbenefitsalreadyposted,0 leavesalaryalreadyposted, 0 travelsalreadyposted," 
    						+ "0 terminalbenefitseligibledays, 0 leavesalaryeligibledays, 0 travelseligibledays,"+empid+" empid UNION ALL " 
    						+ "select el.terminals,el.terminaltype,el.terminalbenefitsalreadyposted,el.leavesalaryalreadyposted,el.travelsalreadyposted,coalesce(sum(el.terminalbenefitseligibledays),0) terminalbenefitseligibledays," 
    						+ "coalesce(sum(el.leavesalaryeligibledays),0) leavesalaryeligibledays,coalesce(sum(el.travelseligibledays),0) travelseligibledays,el.empid from ( "
    						+ "select 2 terminals,'ELG' terminaltype,0 terminalbenefitsalreadyposted,0 leavesalaryalreadyposted,0 travelsalreadyposted,coalesce(terminalbenefits_eligible_days,0) terminalbenefitseligibledays," 
    						+ "coalesce(leavesalary_eligible_days,0) leavesalaryeligibledays,coalesce(travels_eligible_days,0) travelseligibledays,empid from hr_emptran where empid="+empid+") el group by el.empid UNION ALL " 
    						+ "select 3 terminals,'CPR' terminaltype,0 terminalbenefitsalreadyposted,0 leavesalaryalreadyposted, 0 travelsalreadyposted,0 terminalbenefitseligibledays, 0 leavesalaryeligibledays, 0 travelseligibledays,"+empid+" empid UNION ALL " 
    						+ "select tb.terminals,tb.terminaltype,coalesce(sum(tb.terminalbenefitsalreadyposted),0) terminalbenefitsalreadyposted,coalesce(sum(tb.leavesalaryalreadyposted),0) leavesalaryalreadyposted,coalesce(sum(tb.travelsalreadyposted),0) " 
    						+ "travelsalreadyposted,terminalbenefitseligibledays,leavesalaryeligibledays,travelseligibledays,tb.empid from ( select 4 terminals,'BPR' terminaltype,coalesce(terminalbenefits_tobeposted,0) terminalbenefitsalreadyposted," 
    						+ "coalesce(leavesalary_tobeposted,0) leavesalaryalreadyposted,coalesce(travels_tobeposted,0) travelsalreadyposted,0 terminalbenefitseligibledays, 0 leavesalaryeligibledays,0 travelseligibledays,empid from hr_emptran where "
    						+ "empid="+empid+") tb group by tb.empid UNION ALL " 
    						+ "select 5 terminals,'TBD' terminaltype,0 terminalbenefitsalreadyposted,0 leavesalaryalreadyposted, 0 travelsalreadyposted, 0 terminalbenefitseligibledays, 0 leavesalaryeligibledays, 0 travelseligibledays,"+empid+" empid UNION ALL " 
    						+ "select 6 terminals,'DED' terminaltype,0 terminalbenefitsalreadyposted,0 leavesalaryalreadyposted, 0 travelsalreadyposted, 0 terminalbenefitseligibledays, 0 leavesalaryeligibledays, 0 travelseligibledays,"+empid+" empid UNION ALL " 
    						+ "select 7 terminals,'NET' terminaltype,0 terminalbenefitsalreadyposted, 0 leavesalaryalreadyposted, 0 travelsalreadyposted,0 terminalbenefitseligibledays, 0 leavesalaryeligibledays, 0 travelseligibledays,"+empid+" empid) a "
    						+ "on a.empid=m.doc_no where m.status=3 and m.active=1 and m.doc_no="+empid+" and m.terminal_benefits<'"+sqlDeprDate+"' order by t";
    					
    				System.out.println("SQL ="+sql);
    				ResultSet resultSet = stmtHTRE.executeQuery(sql);

    				ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<ArrayList<String>>();
    				ClsCommonHR hrCalc = new ClsCommonHR();
    				String employeeId="",empCategoryID="";
    				String terminalBenefitsSalaryAmount="0.00",leaveSalaryAmount="0.00",terminalbenefitstobeposteddays="0.00",leavesalarytobeposteddays="0.00",traveltobepostedtotaldays="0.00",
    					   terminalBenefitCurrentProvisionAmount="0.00",leaveSalaryCurrentProvisionAmount="0.00",traveltobepostedyears="0.00",travelCurrentProvisionAmount="0.00";
    				double terminalbenefitsalreadyposted=0.00,leavesalaryalreadyposted=0.00,travelsalreadyposted=0.00;
    				
    				while(resultSet.next()){
    					ArrayList<String> temp=new ArrayList<String>();
    					
    					   employeeId=resultSet.getString("employeedocno");
    					   empCategoryID=resultSet.getString("pay_catid");
    					   
    					   temp.add(resultSet.getString("terminals"));
    					   
    					   if(resultSet.getString("terminaltype").equalsIgnoreCase("CALC")) {
    						   
	    					   /*Terminal Benefits Salary Calculation */
	    					   terminalBenefitsSalaryAmount= hrCalc.getHRTerminationBenefitSalary(conn,employeeId,empCategoryID);
	   						   temp.add(terminalBenefitsSalaryAmount);
	   						   /*Terminal Benefits Salary Calculation Ends */
	   						   
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
		   						  leaveSalaryAmount= hrCalc.getHRTerminationBenefitSalary(conn,employeeId,empCategoryID);
		   						}
		   						else{
		   							leaveSalaryAmount= hrCalc.getHRTerminationBenefitLeaveSalary(conn,employeeId,empCategoryID);
		   						}
		   						
		   						temp.add(leaveSalaryAmount);

		   						/*Leave Salary Calculation Ends */
	   						
		   						/*Travels To be Posted Calculation */
		   						temp.add(resultSet.getString("travels"));
								/*Travels To be Posted Calculation Ends */
							
    					   } if(resultSet.getString("terminaltype").equalsIgnoreCase("ELG")) {
    						   
    						   /*Terminal Benefits To be Posted Days*/
    						   if(type.equalsIgnoreCase("RES")){
    								/*Resignation Details used for calculation*/
    								terminalbenefitstobeposteddays= hrCalc.getHRTerminationBenefitToBePostedDaysForResignation(conn,empCategoryID,resultSet.getDouble("years"));
    								temp.add(terminalbenefitstobeposteddays);
    							}else if(type.equalsIgnoreCase("TER")){
    								/*Termination Details used for calculation*/
    								terminalbenefitstobeposteddays= hrCalc.getHRTerminationBenefitToBePostedDays(conn,empCategoryID,resultSet.getDouble("years"));
    								temp.add(terminalbenefitstobeposteddays);
    							}
    						   /*Terminal Benefits To be Posted Days Ends*/
	   						   
    						   /*Leave Salary To be Posted Days*/
    							leavesalarytobeposteddays= hrCalc.getHRLeaveSalaryToBePostedDays(conn,employeeId,empCategoryID,sqlDeprDate);
    							leavesalarytobeposteddays=String.valueOf(resultSet.getDouble("leavesalaryeligibledays")+Double.parseDouble(leavesalarytobeposteddays));
    							temp.add(leavesalarytobeposteddays);
    							/*Leave Salary To be Posted Days Ends*/
	   						
		   						/*Travels To be Posted Days */
    							traveltobepostedtotaldays=String.valueOf(resultSet.getDouble("travelseligibledays")+resultSet.getDouble("daysworked"));
    							temp.add(traveltobepostedtotaldays);
								/*Travels To be Posted Days Ends */
							
    					   } if(resultSet.getString("terminaltype").equalsIgnoreCase("CPR")) {
    						   
    						   /*Terminal Benefit Current Provision Calculation */
    							terminalBenefitCurrentProvisionAmount= hrCalc.getHRTerminalBenefitCurrentProvision(conn,terminalbenefitstobeposteddays,terminalBenefitsSalaryAmount);
    							temp.add(String.valueOf(Math.round(Double.parseDouble(terminalBenefitCurrentProvisionAmount))));
    							/*Terminal Benefit Current Provision Calculation Ends */
    							
    							/*Leave Salary Current Provision Calculation */
    							leaveSalaryCurrentProvisionAmount= hrCalc.getHRLeaveSalaryTobePosted(conn,leavesalarytobeposteddays,leaveSalaryAmount);
    							temp.add(String.valueOf(Math.round(Double.parseDouble(leaveSalaryCurrentProvisionAmount))));
    							/*Leave Salary Current Provision Calculation Ends */
    							
    							/*Travels To be Posted Calculation */
    							traveltobepostedyears= hrCalc.getHRTravelsToBePostedYears(conn,empCategoryID,sqlDeprDate);
    							travelCurrentProvisionAmount= hrCalc.getHRTravelsTobePosted(conn,traveltobepostedtotaldays,traveltobepostedyears,resultSet.getString("travels"));
    							temp.add(String.valueOf(Math.round(Double.parseDouble(travelCurrentProvisionAmount))));
    							/*Travels To be Posted Calculation Ends */
    						
    					   } if(resultSet.getString("terminaltype").equalsIgnoreCase("BPR")) {
    						   
    						   /*Terminal Benefit Already Done */
    						   terminalbenefitsalreadyposted=resultSet.getDouble("terminalbenefitsalreadyposted");
    						   temp.add(String.valueOf(terminalbenefitsalreadyposted));
    						   /*Terminal Benefit Already Done Ends*/
    						   
    						   /*Leave Salary Already Done */
    						   leavesalaryalreadyposted=resultSet.getDouble("leavesalaryalreadyposted");
    						   temp.add(String.valueOf(leavesalaryalreadyposted));
    						   /*Leave Salary Already Done Ends*/
    						   
    						   /*Travels Already Done */
    						   travelsalreadyposted=resultSet.getDouble("travelsalreadyposted");
    						   temp.add(String.valueOf(travelsalreadyposted));
    						   /*Travels Already Done Ends*/
    						   
    					   } if(resultSet.getString("terminaltype").equalsIgnoreCase("TBD")) {
    						   
    						   /*Terminal Benefit To be Provided */
    						   temp.add(String.valueOf(Math.round(Double.parseDouble(terminalBenefitCurrentProvisionAmount))-terminalbenefitsalreadyposted));
    						   /*Terminal Benefit To be Provided Ends*/
    						   
    						   /*Leave Salary To be Provided */
    						   temp.add(String.valueOf(Math.round(Double.parseDouble(leaveSalaryCurrentProvisionAmount))-leavesalaryalreadyposted));
    						   /*Leave Salary To be Provided Ends*/
    						   
    						   /*Travels To be Provided */
    						   temp.add(String.valueOf(Math.round(Double.parseDouble(travelCurrentProvisionAmount))-travelsalreadyposted));
    						   /*Travels To be Provided Ends*/
    						   
    					   } if(resultSet.getString("terminaltype").equalsIgnoreCase("NET")) {
    						   
    						   /*Terminal Benefit Net Pay */
    						   temp.add(String.valueOf(Math.round(Double.parseDouble(terminalBenefitCurrentProvisionAmount))));
    						   /*Terminal Benefit Net Pay Ends*/
    						   
    						   /*Leave Salary Net Pay */
    						   temp.add(String.valueOf(Math.round(Double.parseDouble(leaveSalaryCurrentProvisionAmount))));
    						   /*Leave Salary Net Pay Ends*/
    						   
    						   /*Travels Net Pay */
    						   temp.add(String.valueOf(Math.round(Double.parseDouble(travelCurrentProvisionAmount))));
    						   /*Travels Net Pay Ends*/
    						   
    					   } else {
    						   temp.add("0.00");
    						   temp.add("0.00");
    						   temp.add("0.00");
    					   }
    					
    					analysisrowarray.add(temp);
    				}
    				
    				RESULTDATA=convertRowAnalysisArrayToJSON(analysisrowarray);
    				
    				stmtHTRE.close();
    				conn.close();
    		} catch(Exception e){
    			e.printStackTrace();
    			conn.close();
    		} finally{
    			 conn.close();
    		 }
      return RESULTDATA;
    }
	
	public JSONArray accountDetailsGridLoading(String empid,String check) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("2"))){
        	return RESULTDATA;
        }
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtHTRE = conn.createStatement();
				
				String sql = "select m.acno,h.account,CONCAT(h.description,' ','(GRATUITY)') codeno from hr_empm m left join my_head h on m.acno=h.doc_no where m.status=3 and m.active=1 and m.doc_no="+empid+" UNION ALL " 
						+ "select h.doc_no acno,h.account,CONCAT(h.description,' ','(GRATUITY)') codeno from my_account a left join my_head h on a.acno=h.doc_no where a.codeno IN ('HREXPENSE1TERMINATIONEXPENSE','HRPROVISION1TERMINATIONBENEFIT') UNION ALL " 
						+ "select m.acno,h.account,CONCAT(h.description,' ','(LEAVE SALARY)') codeno from hr_empm m left join my_head h on m.acno=h.doc_no where m.status=3 and m.active=1 and m.doc_no="+empid+" UNION ALL " 
						+ "select h.doc_no acno,h.account,CONCAT(h.description,' ','(LEAVE SALARY)') codeno from my_account a left join my_head h on a.acno=h.doc_no where a.codeno IN ('HREXPENSE2LEAVESALARYEXPENSEACCOUNT','HRPROVISION2LEAVESALARYBENEFITACCOUNT') UNION ALL " 
						+ "select m.acno,h.account,CONCAT(h.description,' ','(TRAVEL)') codeno from hr_empm m left join my_head h on m.acno=h.doc_no where m.status=3 and m.active=1 and m.doc_no="+empid+" UNION ALL " 
						+ "select h.doc_no acno,h.account,CONCAT(h.description,' ','(TRAVEL)') codeno from my_account a left join my_head h on a.acno=h.doc_no where a.codeno IN ('HREXPENSE3TRAVELEXPENSEACCOUNT','HRPROVISION3TRAVELBENEFITACCOUNT')";
		        
				ResultSet resultSet = stmtHTRE.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtHTRE.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray terminationDetailsReloading(String empId, String trNo, String docNo) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtHTRE = conn.createStatement();
			
				String sql="select description terminations,round(gratuity,2) gratuity,round(leavesalary,2) leavesalary,round(travels,2) travel from hr_terminationd where empid="+empId+" and tr_no="+trNo+" and rdocno="+docNo+"";
				ResultSet resultSet = stmtHTRE.executeQuery(sql);
                
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtHTRE.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA;
    }
	
	public JSONArray accountDetailsReloading(String empId, String trNo, String docNo) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtHTRE = conn.createStatement();
			
				String sql="select a.acno,if(a.debit>0,0,a.debit) debit,if(a.credit<0,0,a.credit) credit,t.account,t.description codeno from hr_terminationaccountd a left join my_head t on a.acno=t.doc_no where a.empid="+empId+" and a.tr_no="+trNo+" and a.rdocno="+docNo+"";
				ResultSet resultSet = stmtHTRE.executeQuery(sql);
                
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtHTRE.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA;
    }

	public JSONArray employeeDetailsSearch(HttpSession session,String empname,String mob,String employeedesignation,String employeedepartment,String empid,String doj,String check) throws SQLException {

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
             
           String brid=session.getAttribute("BRANCHID").toString();
       
           java.sql.Date sqlDateofJoin=null;
           
     try {
    	   conn = ClsConnection.getMyConnection();
    	   Statement stmtHTRE = conn.createStatement();
       
    	   doj.trim();
           if(!(doj.equalsIgnoreCase("undefined"))&&!(doj.equalsIgnoreCase(""))&&!(doj.equalsIgnoreCase("0")))
           {
           	sqlDateofJoin = ClsCommon.changeStringtoSqlDate(doj);
           }
           
           String sqltest="";
           
           if(!(empname.equalsIgnoreCase(""))){
               sqltest=sqltest+" and m.name like '%"+empname+"%'";
           }
           if(!(mob.equalsIgnoreCase(""))){
           	sqltest=sqltest+" and if(m.prmob is null,m.pmmob,if(m.prmob=' ',m.pmmob,m.prmob)) like '%"+mob+"%'";
           }
           if(!(employeedesignation.equalsIgnoreCase(""))){
           	sqltest=sqltest+" and m.desc_id like '%"+employeedesignation+"%'";
           }
           if(!(employeedepartment.equalsIgnoreCase(""))){
           	sqltest=sqltest+" and m.dept_id like '%"+employeedepartment+"%'";
           }
           if(!(empid.equalsIgnoreCase(""))){
           	sqltest=sqltest+" and m.codeno like '%"+empid+"%'";
           }
           if(!(sqlDateofJoin==null)){
           	sqltest=sqltest+" and m.dtjoin='"+sqlDateofJoin+"'";
           } 
           
	       ResultSet resultSet = stmtHTRE.executeQuery("select m.name,m.codeno empid,if(m.prmob is null,m.pmmob,if(m.prmob=' ',m.pmmob,m.prmob)) mob,dg.desc1 designation,dp.desc1 department,"  
	       	  + "ct.desc1 category,m.dtjoin,m.doc_no,max(ap.date) appriasal from hr_empm m left join hr_setdesig dg on m.desc_id=dg.doc_no left join hr_setdept dp on m.dept_id=dp.doc_no "
	    	  + "left join hr_setpaycat ct on m.pay_catid=ct.doc_no left join hr_incrm ap on m.doc_no=ap.empid where m.status=3 and m.active=1 and m.dtype='EMP'" +sqltest+" group by m.doc_no");
	
	       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	       
	       stmtHTRE.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
    	 conn.close();
     }
       return RESULTDATA;
   }
	
	public JSONArray htreMainSearch(HttpSession session,String empname,String docNo,String date,String totalAmount) throws SQLException {

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
           
     try {
	       conn = ClsConnection.getMyConnection();
	       Statement stmtHTRE = conn.createStatement();
	       
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
	       if(!(totalAmount.equalsIgnoreCase(""))){
	        	sqltest=sqltest+" and m.totalAmount like '%"+totalAmount+"%'";
	       }
	       if(!(sqlDate==null)){
	        	sqltest=sqltest+" and m.date='"+sqlDate+"'";
		   } 
	        
	       ResultSet resultSet = stmtHTRE.executeQuery("select m.doc_no,m.date,m.totalAmount amount,e.name FROM hr_terminationm m left join hr_empm e on (m.empid=e.doc_no and e.dtype='EMP') where m.brhid="+branch+" "  
	       	+ "and m.status<>7" +sqltest);
	
	       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	       
	       stmtHTRE.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
 		conn.close();
 	}
       return RESULTDATA;
   }
	
	 public  ClsTerminationBean getViewDetails(HttpSession session,int docNo) throws SQLException {
		    ClsTerminationBean terminationBean = new ClsTerminationBean();
			
			Connection conn = null;
			
			try {
				conn = ClsConnection.getMyConnection();
				Statement stmtHTRE = conn.createStatement();
			
				String branch = session.getAttribute("BRANCHID").toString();
				
				ResultSet resultSet = stmtHTRE.executeQuery ("select m.date,m.tr_no,m.empid,m.notify,m.dtjoin,m.appraisal,m.totalAmount,m.ctype,e.codeno,e.name,dg.desc1 designation,"
						+ "dp.desc1 department,ct.desc1 category FROM hr_terminationm m left join hr_empm e on (m.empid=e.doc_no and e.dtype='EMP') left join hr_setdesig dg "
						+ "on e.desc_id=dg.doc_no left join hr_setdept dp on e.dept_id=dp.doc_no left join hr_setpaycat ct on e.pay_catid=ct.doc_no where m.status<>7 and "
						+ "m.brhid='"+branch+"' and m.doc_no="+docNo);
				
				while (resultSet.next()) {
					    terminationBean.setTxtterminationdocno(docNo);
					    terminationBean.setTerminationDate(resultSet.getDate("date").toString());
					    terminationBean.setTxtemployeedocno(resultSet.getInt("empid"));
					    terminationBean.setTxtemployeeid(resultSet.getString("codeno"));
					    terminationBean.setTxtemployeename(resultSet.getString("name"));
					    terminationBean.setTxtemployeedesignation(resultSet.getString("designation"));
					    terminationBean.setTxtemployeedepartment(resultSet.getString("department"));
					    terminationBean.setTxtemployeecategory(resultSet.getString("category"));
					    terminationBean.setNotifyDate(resultSet.getDate("notify").toString());
					    terminationBean.setJoiningDate(resultSet.getDate("dtjoin").toString());
					    terminationBean.setAppraisalDate(resultSet.getDate("appraisal").toString());
					    terminationBean.setTxtdrtotal(resultSet.getDouble("totalAmount"));
					    terminationBean.setTxtcrtotal(resultSet.getDouble("totalAmount"));
					    terminationBean.setTxttrno(resultSet.getInt("tr_no"));
					    terminationBean.setCmbtype(resultSet.getString("ctype"));
				}
			  stmtHTRE.close();
			  conn.close();
			} catch(Exception e){
				e.printStackTrace();
				conn.close();
			} finally{
				conn.close();
			}
			return terminationBean;
			}
	 
	 public  JSONArray convertRowAnalysisArrayToJSON(ArrayList<ArrayList<String>> rowsAnalysisList) throws Exception {
			JSONArray jsonArray = new JSONArray();
			
			for (int i = 0; i < rowsAnalysisList.size(); i++) {
				
				JSONObject obj = new JSONObject();
				ArrayList<String> analysisRowArray=rowsAnalysisList.get(i);
				
				obj.put("terminations",analysisRowArray.get(0));
				obj.put("gratuity",analysisRowArray.get(1));
				obj.put("leavesalary",analysisRowArray.get(2));
				obj.put("travel",analysisRowArray.get(3));
				
				jsonArray.add(obj);
			}
			return jsonArray;
			}
	 
	 public ClsTerminationBean getPrint(HttpServletRequest request,int docNo,int branch,int header) throws SQLException {
		 ClsTerminationBean bean = new ClsTerminationBean();
		 Connection conn = null;
		 
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtHTRE = conn.createStatement();
			
			int trno=0,empid=0;
			
			String headersql="select if(m.dtype='HTRE','Termination','  ') vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
					+ "b.cstno from hr_terminationm m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='HTRE' "
					+ "and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSetHead = stmtHTRE.executeQuery(headersql);
			
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

			String sqls="select m.doc_no,DATE_FORMAT(m.date ,'%d-%m-%Y') date,e.codeno,e.name,dg.desc1 designation,dp.desc1 department,ct.desc1 category,DATE_FORMAT(m.dtjoin ,'%d-%m-%Y') dtjoin,DATE_FORMAT(m.appraisal ,'%d-%m-%Y') appraisal,"  
					+ "DATE_FORMAT(m.notify ,'%d-%m-%Y') notify,m.totalAmount,m.tr_no,m.empid,u.user_name FROM hr_terminationm m left join hr_empm e on (m.empid=e.doc_no and e.dtype='EMP') left join hr_setdesig dg on e.desc_id=dg.doc_no left join hr_setdept dp on "
					+ "e.dept_id=dp.doc_no left join hr_setpaycat ct on e.pay_catid=ct.doc_no left join my_user u on m.userid=u.doc_no where m.status<>7 and m.brhid="+branch+" and m.doc_no="+docNo+"";
				
			ResultSet resultSets = stmtHTRE.executeQuery(sqls);
			
			while(resultSets.next()){
				
				bean.setLblvoucherno(resultSets.getString("doc_no"));
				bean.setLbldate(resultSets.getString("date"));
				bean.setLblemployeeid(resultSets.getString("codeno"));
				bean.setLblemployeename(resultSets.getString("name"));
				bean.setLbldesignation(resultSets.getString("designation"));
				bean.setLbldepartment(resultSets.getString("department"));
				bean.setLblcategory(resultSets.getString("category"));
				bean.setLbldateofjoin(resultSets.getString("dtjoin"));
				bean.setLblappraisaldt(resultSets.getString("appraisal"));
				bean.setLblnotifydate(resultSets.getString("notify"));
				bean.setLbldebittotal(resultSets.getString("totalAmount"));
				bean.setLblcredittotal(resultSets.getString("totalAmount"));
				bean.setLblpreparedby(resultSets.getString("user_name"));
				trno=resultSets.getInt("tr_no");
				empid=resultSets.getInt("empid");
			}
			
			bean.setTxtheader(header);
			
			String sql1 = "";

			sql1 = "select a.acno,if(a.debit=0,'  ',round(a.debit,2)) debit,if(a.credit=0,'  ',round(a.credit,2)) credit,t.account,t.description codeno from hr_terminationaccountd a left join my_head t "
				    + "on a.acno=t.doc_no where a.empid="+empid+" and a.tr_no="+trno+" and a.rdocno="+docNo+"";
			
			ResultSet resultSet1 = stmtHTRE.executeQuery(sql1);
			
			ArrayList<String> printaccounting= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setFirstarray(1);
				String temp="";
				temp=resultSet1.getString("account")+"::"+resultSet1.getString("codeno")+"::"+resultSet1.getString("debit")+"::"+resultSet1.getString("credit");
				printaccounting.add(temp);
			}
			
			request.setAttribute("printaccounting", printaccounting);

			String sql2 = "";
			 
			sql2 = "select description terminations,round(gratuity,2) gratuity,round(leavesalary,2) leavesalary,round(travels,2) travel from hr_terminationd where empid="+empid+" and tr_no="+trno+" and rdocno="+docNo+"";
				 
			ResultSet resultSet2 = stmtHTRE.executeQuery(sql2);
			
			ArrayList<String> printarray= new ArrayList<String>();
			
			while(resultSet2.next()){
				bean.setSecarray(2); 
				String temp="";
				temp=resultSet2.getString("terminations")+"::"+resultSet2.getString("gratuity")+"::"+resultSet2.getString("leavesalary")+"::"+resultSet2.getString("travel");
			    printarray.add(temp);
			}

			request.setAttribute("printingarray", printarray);
			
			String sql3 = "select max(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,max(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from hr_terminationm m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='HTRE' and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSet3 = stmtHTRE.executeQuery(sql3);
			
			while(resultSet3.next()){
				bean.setLblpreparedon(resultSet3.getString("preparedon"));
				bean.setLblpreparedat(resultSet3.getString("preparedat"));
			}
		
			stmtHTRE.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return bean;
	}
	 
	 public int insertion(Connection conn,int docno, int trno,  Date terminationsDate, Date notifyingDate, String branch, int txtemployeedocno, String formdetailcode, ArrayList<String> employeedetailsarray,  ArrayList<String> accountsarray, ArrayList<String> journalvouchersarray, HttpSession session,String mode) throws SQLException{
	     
		  try{
			    conn.setAutoCommit(false);
				CallableStatement stmtHTRE;
				CallableStatement stmtHTRE1;
				CallableStatement stmtHTRE2;
				CallableStatement stmtHTRE3;
				Statement stmtHTRE4 = conn.createStatement();
				
				String userid=session.getAttribute("USERID").toString().trim();
				
				/*Termination Grid Details Saving*/
				for(int i=0;i< employeedetailsarray.size();i++){
					String[] terminationsdetail=employeedetailsarray.get(i).split("::");
					if(!terminationsdetail[0].trim().equalsIgnoreCase("undefined") && !terminationsdetail[0].trim().equalsIgnoreCase("NaN")){
					 
					stmtHTRE = conn.prepareCall("{CALL HR_TerminationdDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					/*Insertion to hr_terminationd*/
					stmtHTRE.registerOutParameter(11, java.sql.Types.INTEGER);
					
					stmtHTRE.setInt(1,(i+1)); //srno
					stmtHTRE.setInt(2,txtemployeedocno); //Employee ID
					stmtHTRE.setString(3,(terminationsdetail[0].trim().equalsIgnoreCase("undefined") || terminationsdetail[0].trim().equalsIgnoreCase("NaN") || terminationsdetail[0].trim().isEmpty()?0:terminationsdetail[0].trim()).toString()); //Description
					stmtHTRE.setString(4,(terminationsdetail[1].trim().equalsIgnoreCase("undefined") || terminationsdetail[1].trim().equalsIgnoreCase("NaN") || terminationsdetail[1].trim().isEmpty()?0:terminationsdetail[1].trim()).toString()); //Gratuity
					stmtHTRE.setString(5,(terminationsdetail[2].trim().equalsIgnoreCase("undefined") || terminationsdetail[2].trim().equalsIgnoreCase("NaN") || terminationsdetail[2].trim().isEmpty()?0:terminationsdetail[2].trim()).toString()); //Leave Salary
					stmtHTRE.setString(6,(terminationsdetail[3].trim().equalsIgnoreCase("undefined") || terminationsdetail[3].trim().equalsIgnoreCase("NaN") || terminationsdetail[3].trim().isEmpty()?0:terminationsdetail[3].trim()).toString()); //Travels 
					stmtHTRE.setString(7,formdetailcode);
					stmtHTRE.setString(8,branch);
					stmtHTRE.setInt(9,trno); 
					stmtHTRE.setInt(10,docno);
					stmtHTRE.setString(12,mode);
					int detail=stmtHTRE.executeUpdate();
						if(detail<=0){
							stmtHTRE.close();
							conn.close();
							return 0;
						}
  				    }
				 }
				 /*Termination Grid Details Saving Ends*/
				
				/*Account Details Grid Saving*/
				for(int i=0;i< accountsarray.size();i++){
				String[] account=accountsarray.get(i).split("::");
				if(!account[0].trim().equalsIgnoreCase("undefined") && !account[0].trim().equalsIgnoreCase("NaN")){
				
				stmtHTRE1 = conn.prepareCall("{CALL HR_TerminationAccountdDML(?,?,?,?,?,?,?,?,?)}");
				
				/*Insertion to hr_terminationaccountd*/
				stmtHTRE1.setInt(6,trno);
				stmtHTRE1.setInt(7,docno);
				stmtHTRE1.registerOutParameter(8, java.sql.Types.INTEGER);
				
				stmtHTRE1.setInt(1,txtemployeedocno); //Employee ID
				stmtHTRE1.setString(2,(account[0].trim().equalsIgnoreCase("undefined") || account[0].trim().equalsIgnoreCase("NaN") || account[0].trim().isEmpty()?0:account[0].trim()).toString());  //doc_no of my_head
				stmtHTRE1.setString(3,(account[1].trim().equalsIgnoreCase("undefined") || account[1].trim().equalsIgnoreCase("NaN") || account[1].trim().isEmpty()?0:account[1].trim()).toString()); //debit
				stmtHTRE1.setString(4,(account[2].trim().equalsIgnoreCase("undefined") || account[2].trim().equalsIgnoreCase("NaN") || account[2].trim().isEmpty()?0:account[2].trim()).toString()); //credit
				stmtHTRE1.setString(5,formdetailcode);
				stmtHTRE1.setString(9,mode);
				stmtHTRE1.execute();
				if(stmtHTRE1.getInt("iRowNo")<=0){
					stmtHTRE1.close();
					conn.close();
					return 0;
				}
				/*hr_terminationaccountd Grid Saving Ends*/
					
				 stmtHTRE1.close();
				 }
				}
				/*Account Details Grid Saving*/
				
				/*Terminal Benefits Details Grid and Details Saving*/
				double tbEligibleDays=0.00,lsEligibleDays=0.00,tEligibleDays=0.00,tbNetPay=0.00,lsNetPay=0.00,tNetPay=0.00;
				for(int i=0;i< employeedetailsarray.size();i++){
					String[] terminationbenefitsdetail=employeedetailsarray.get(i).split("::");
					if(!terminationbenefitsdetail[0].trim().equalsIgnoreCase("undefined") && !terminationbenefitsdetail[0].trim().equalsIgnoreCase("NaN")){
						 if(i==1) {
							 tbEligibleDays = ((terminationbenefitsdetail[1].equalsIgnoreCase("undefined") || terminationbenefitsdetail[1].equalsIgnoreCase("NaN") || terminationbenefitsdetail[1].isEmpty()?0.0:Double.parseDouble(terminationbenefitsdetail[1])));
							 lsEligibleDays = ((terminationbenefitsdetail[2].equalsIgnoreCase("undefined") || terminationbenefitsdetail[2].equalsIgnoreCase("NaN") || terminationbenefitsdetail[2].isEmpty()?0.0:Double.parseDouble(terminationbenefitsdetail[2])));
							 tEligibleDays = ((terminationbenefitsdetail[3].equalsIgnoreCase("undefined") || terminationbenefitsdetail[3].equalsIgnoreCase("NaN") || terminationbenefitsdetail[3].isEmpty()?0.0:Double.parseDouble(terminationbenefitsdetail[3])));
						 } else if(i==6){
							 tbNetPay = ((terminationbenefitsdetail[1].equalsIgnoreCase("undefined") || terminationbenefitsdetail[1].equalsIgnoreCase("NaN") || terminationbenefitsdetail[1].isEmpty()?0.0:Double.parseDouble(terminationbenefitsdetail[1])));
							 lsNetPay = ((terminationbenefitsdetail[2].equalsIgnoreCase("undefined") || terminationbenefitsdetail[2].equalsIgnoreCase("NaN") || terminationbenefitsdetail[2].isEmpty()?0.0:Double.parseDouble(terminationbenefitsdetail[2])));
							 tNetPay = ((terminationbenefitsdetail[3].equalsIgnoreCase("undefined") || terminationbenefitsdetail[3].equalsIgnoreCase("NaN") || terminationbenefitsdetail[3].isEmpty()?0.0:Double.parseDouble(terminationbenefitsdetail[3])));
						 }
    				  }
				    }
				
				stmtHTRE2 = conn.prepareCall("{CALL HR_TerminationBenefitsdDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				/*Insertion to hr_emptran*/
				stmtHTRE2.setInt(11,trno); 
				stmtHTRE2.setInt(12,docno);
				stmtHTRE2.registerOutParameter(13, java.sql.Types.INTEGER);
				
				stmtHTRE2.setDate(1,notifyingDate); //Date
				stmtHTRE2.setInt(2,txtemployeedocno); //Employee ID
				stmtHTRE2.setDouble(3,tbEligibleDays); //Terminal Benefits Eligible Days 
				stmtHTRE2.setDouble(4,lsEligibleDays); //Leave Salary Eligible Days
				stmtHTRE2.setDouble(5,tEligibleDays); //Travels Eligible Days	
				stmtHTRE2.setDouble(6,tbNetPay); //Terminal Benefits Net Pay
				stmtHTRE2.setDouble(7,lsNetPay); //Leave Salary Net Pay
				stmtHTRE2.setDouble(8,tNetPay); //Travels Net Pay
				stmtHTRE2.setString(9,formdetailcode);
				stmtHTRE2.setString(10,branch);
				stmtHTRE2.setString(14,mode);
				int detail1=stmtHTRE2.executeUpdate();
				if(detail1<=0){
					stmtHTRE2.close();
					conn.close();
					return 0;
				}
					
				stmtHTRE2.close();
				/*Terminal Benefits Details Grid and Details Saving Ends*/
				
				for(int i=0;i< journalvouchersarray.size();i++){
				String[] journal=journalvouchersarray.get(i).split("::");
				if(!journal[0].trim().equalsIgnoreCase("undefined") && !journal[0].trim().equalsIgnoreCase("NaN")){
				
				stmtHTRE3 = conn.prepareCall("{CALL HR_TerminationJournaldDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				/*Insertion to my_jvtran*/
				stmtHTRE3.setInt(10,docno);
				stmtHTRE3.setInt(11,trno);
				
				stmtHTRE3.setDate(1,terminationsDate); //Date
				stmtHTRE3.setString(2,"HTRE - "+docno);
				stmtHTRE3.setInt(3,(i+1)); //SR_No
				stmtHTRE3.setString(4,(journal[0].trim().equalsIgnoreCase("undefined") || journal[0].trim().equalsIgnoreCase("NaN") || journal[0].trim().isEmpty()?0:journal[0].trim()).toString());  //doc_no of my_head
				stmtHTRE3.setString(5,(journal[1].trim().equalsIgnoreCase("undefined") || journal[1].trim().equalsIgnoreCase("NaN") || journal[1].trim().isEmpty()?0:journal[1].trim()).toString()); //amount
				stmtHTRE3.setString(6,(journal[2].trim().equalsIgnoreCase("undefined") || journal[2].trim().equalsIgnoreCase("NaN") || journal[2].trim().isEmpty()?0:journal[2].trim()).toString()); //credit -1 & debit 1
				stmtHTRE3.setString(7,formdetailcode);
				stmtHTRE3.setString(8,branch);
				stmtHTRE3.setString(9,userid);
				stmtHTRE3.setString(12,mode);
				stmtHTRE3.execute();
				if(stmtHTRE3.getInt("docNo")<=0){
					stmtHTRE3.close();
					conn.close();
					return 0;
				}
				/*my_jvtran Grid Saving Ends*/
					
				 stmtHTRE3.close();
				 }
				}	
					
				/*Deleting amount of value zero*/
				String sql2=("DELETE FROM hr_emptran where TR_NO="+trno+" and terminalbenefits_tobeposted=0 and leavesalary_tobeposted=0 and travels_tobeposted=0");
			    int data = stmtHTRE4.executeUpdate(sql2);
			    /*Deleting amount of value zero ends*/
			    
			    /*Deleting account of value zero*/
				String sql3=("DELETE FROM my_jvtran where TR_NO="+trno+" and acno=0");
				int data1 = stmtHTRE4.executeUpdate(sql3);
				/*Deleting account of value zero ends*/
				
				/*Deleting amount of value zero*/
				String sql4=("DELETE FROM my_jvtran where TR_NO="+trno+" and dramount=0");
				int data3 = stmtHTRE4.executeUpdate(sql4);
				/*Deleting amount of value zero ends*/
			    
			    stmtHTRE4.close();
				
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}

}
