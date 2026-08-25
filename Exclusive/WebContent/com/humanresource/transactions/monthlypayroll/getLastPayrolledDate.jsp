<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();

		java.sql.Date sqlPayrollDate=null;
		
		String payrolldate=request.getParameter("payrolldate");
		
	    if(!(payrolldate.equalsIgnoreCase("undefined"))&&!(payrolldate.equalsIgnoreCase(""))&&!(payrolldate.equalsIgnoreCase("0"))){
		     sqlPayrollDate=ClsCommon.changeStringtoSqlDate(payrolldate);
		}
	    
	    String lastSalaryPaids = "";
	    int days=0,payrollProcess=3;
	    
	    /* Attendance of Month*/
	    String sqls = "SELECT * FROM hr_timesheet WHERE month=MONTH('"+sqlPayrollDate+"') and year=YEAR('"+sqlPayrollDate+"')";
		ResultSet rss = stmt.executeQuery(sqls);
		
		while(rss.next()) {
			payrollProcess=0;
		} 
		/* Attendance of Month Ends*/
		
		if(payrollProcess==0){
			
		String sql = "SELECT min(salary_paid) lastSalaryPaid,DATE_FORMAT(min(salary_paid),'%d-%m-%Y') lastSalaryPaids,DATEDIFF(LAST_DAY(DATE_ADD(min(salary_paid),INTERVAL 1 DAY)),'"+sqlPayrollDate+"') "
				+ "ProcessingDateDiff FROM hr_empm WHERE active=1 and status=3";
		ResultSet rs = stmt.executeQuery(sql);
		
		while(rs.next()) {
			sqlPayrollDate=rs.getDate("lastSalaryPaid");
			lastSalaryPaids=rs.getString("lastSalaryPaids");
			days=rs.getInt("ProcessingDateDiff");
		} 
		
		/*Payroll Process*/
		if(days==0){
			payrollProcess=1;
		}
		/*Payroll Process Ends*/
		
		/*Payroll Process Pending*/
		if(days<0){
			payrollProcess=0;
		}
		/*Payroll Process Pending Ends*/
		
		/*Payroll Process Already Done*/
		if(days>0){
			
			payrollProcess=2;
			
			String sql2 = "select * from hr_timesheet where payroll_processed=1 and payroll_confirmed=1 and month=MONTH('"+sqlPayrollDate+"') and year=YEAR('"+sqlPayrollDate+"')";
			ResultSet rs2 = stmt.executeQuery(sql2);
			
			while(rs2.next()) {
				payrollProcess=5;
			} 
			
			String sql1 = "select * from hr_timesheet where payroll_confirmed=0 and month=MONTH('"+sqlPayrollDate+"') and year=YEAR('"+sqlPayrollDate+"')";
			ResultSet rs1 = stmt.executeQuery(sql1);
			
			while(rs1.next()) {
				payrollProcess=4;
			} 
		}
		/*Payroll Process Already Done Ends*/
		
		}
		
		response.getWriter().write(payrollProcess+"***"+lastSalaryPaids);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  