<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon"%>

<%	

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;
	
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		java.sql.Date sqlDeprDate=null;
		
		String employeeId=request.getParameter("empid")==""?"0":request.getParameter("empid");
		String date=request.getParameter("date");
		
		if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
        {
			sqlDeprDate = ClsCommon.changeStringtoSqlDate(date);
        }
		
		String employeeCategoryId="",leavesalaryeligibledays="",leavesalaryposted="",travelsposted="",daysWorked="",leaveSalaryToBePostedDays="",allowanceID="",leaveSalaryAmount="",leaveSalaryTobePostedAmount="";
		int totalterminalleave=0,days=0,years=0;
		
		String strSqls = "select pay_catid from hr_empm where status=3 and active=1 and doc_no="+employeeId+"";
		ResultSet rss = stmt.executeQuery(strSqls);
		
		while(rss.next()) {
			employeeCategoryId=rss.getString("pay_catid");
		}
		
		/* String strSql = "select (select coalesce(sum(leavesalary_eligible_days),0) leavesalary_eligible_days from hr_emptran where dtype!='LTD' and empid="+employeeId+") leavesalaryeligibledays,"
				+ "sum(a.leavesalarytobeposted) leavesalaryposted,sum(a.travelstobeposted) travelsposted from ("
				+ "select coalesce(leavesalary_tobeposted,0) leavesalarytobeposted,coalesce(travels_tobeposted,0) travelstobeposted "
				+ "from hr_emptran where empid="+employeeId+") a"; */
				
		String strSql = "select sum(a.leavesalaryeligibledays) leavesalaryeligibledays,sum(a.leavesalarytobeposted) leavesalaryposted,sum(a.travelstobeposted) travelsposted from ("
				+ "select coalesce(leavesalary_eligible_days,0) leavesalaryeligibledays,coalesce(leavesalary_tobeposted,0) leavesalarytobeposted,coalesce(travels_tobeposted,0) travelstobeposted "
				+ "from hr_emptran where empid="+employeeId+") a";
		ResultSet rs = stmt.executeQuery(strSql);
		
		while(rs.next()) {
					leavesalaryeligibledays=rs.getString("leavesalaryeligibledays");
					leavesalaryposted=rs.getString("leavesalaryposted");
					travelsposted=rs.getString("travelsposted");
		} 
		
        /* String sqls="select CONCAT('t.tot_leave',coalesce(doc_no,1)) leavestype from hr_setleave where status=3 and terminal_leavid=1";
        ResultSet resultSets = stmt.executeQuery(sqls);
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
        } */
        
		String sqls="select doc_no leavestype,1 startday,DAY('"+sqlDeprDate+"') endday from hr_setleave where status=3 and terminal_leavid=1";
        ResultSet resultSets = stmt.executeQuery(sqls);
        int terminalleave=0,startday=0,endday=0;
        while(resultSets.next()){
        	terminalleave+=resultSets.getInt("leavestype");
        	startday=resultSets.getInt("startday");
        	endday=resultSets.getInt("endday");
        }
        
        if(terminalleave>0){
        	
        	for(int i=startday;i<=endday;i++){
        		
		        String sqlTotalLeaves="select count(*) leavetaken from hr_timesheet where payroll_processed!=0 and payroll_confirmed!=0 and empid="+employeeId+" and month=MONTH('"+sqlDeprDate+"') and year=YEAR('"+sqlDeprDate+"') and date"+i+" in (select refno from hr_timesheetset where refno not in (1,2) and reftype!='NIL' and doc_no in (select doc_no from hr_setleave where status=3 and terminal_leavid=1))";
		        ResultSet resultSetTotalLeaves = stmt.executeQuery(sqlTotalLeaves);
		        
		        while(resultSetTotalLeaves.next()){
		        	totalterminalleave+=resultSetTotalLeaves.getInt("leavetaken");
		        }
		        
        	}
	        
        } else if(terminalleave==0){
        	
        	String sqlLeaveSalaryTypeAll="select 1 startday,DAY('"+sqlDeprDate+"') endday";
			ResultSet resultSetLeaveSalaryAll = stmt.executeQuery(sqlLeaveSalaryTypeAll);
	        while(resultSetLeaveSalaryAll.next()){
	        	startday=resultSetLeaveSalaryAll.getInt("startday");
	        	endday=resultSetLeaveSalaryAll.getInt("endday");
	        }
	        
        	for(int i=startday;i<=endday;i++){
        		
		        String sqlTotalLeaves="select count(*) leavetaken from hr_timesheet where payroll_processed!=0 and payroll_confirmed!=0 and empid="+employeeId+" and month=MONTH('"+sqlDeprDate+"') and year=YEAR('"+sqlDeprDate+"') and date"+i+" in (select refno from hr_timesheetset where refno not in (1,2) and reftype!='NIL' and doc_no in (select doc_no from hr_setleave where status=3))";
		        ResultSet resultSetTotalLeaves = stmt.executeQuery(sqlTotalLeaves);
		        
		        while(resultSetTotalLeaves.next()){
		        	totalterminalleave+=resultSetTotalLeaves.getInt("leavetaken");
		        }
		        
        	}
	        
        }
        
		String strSql1 = "select m.doc_no employeedocno,m.codeno employeeid,m.name employeename,m.dtjoin joiningdate,m.desc_id,m.pay_catid,m.terminal_benefits,if(MONTH(m.dtjoin)=MONTH('"+sqlDeprDate+"') && year(m.dtjoin)=year('"+sqlDeprDate+"'),round((DATEDIFF('"+sqlDeprDate+"',m.dtjoin)+1)-("+totalterminalleave+"),1),"
				+ "round(DAY('"+sqlDeprDate+"')-("+totalterminalleave+"),1)) daysworked from hr_empm m inner join hr_timesheet t on (m.doc_no=t.empid and t.year=YEAR('"+sqlDeprDate+"') and t.month=MONTH('"+sqlDeprDate+"')) where m.status=3 and m.active=1 and m.doc_no="+employeeId+""; 
		
		System.out.println( "days worked "+strSql1); 
		
		ResultSet rs1 = stmt.executeQuery(strSql1);

		while(rs1.next()) {
			daysWorked=rs1.getString("daysWorked");
		} 
		
		String sqlLeaveSalaryToBePostedDays = "select m.aelg days,m.awdays years from hr_paycode m where m.status=3 and m.catid="+employeeCategoryId+"";
		ResultSet resultSetLeaveSalaryToBePostedDays = stmt.executeQuery(sqlLeaveSalaryToBePostedDays);
		
		while(resultSetLeaveSalaryToBePostedDays.next()) {
				days=resultSetLeaveSalaryToBePostedDays.getInt("days");
				years=resultSetLeaveSalaryToBePostedDays.getInt("years");
		}

		/* 	No of days worked - Up to deprdate how many days worked without taking leave
		 					  *  [  ]
			[ (No of days worked / No of days in cur month) ] * [(30/365) * (No of days in cur month) ]
		
	    */
		
		String sqlLeaveSalaryToBePostedDays1 = "select round((("+daysWorked+"/DAY('"+sqlDeprDate+"'))*("+days+"/"+years+")*DAY('"+sqlDeprDate+"')),1) tobeprocesseddays";
		
		System.out.println("tobe posted qry"+sqlLeaveSalaryToBePostedDays1);
		ResultSet resultSetLeaveSalaryToBePostedDays1 = stmt.executeQuery(sqlLeaveSalaryToBePostedDays1);		
		
		while(resultSetLeaveSalaryToBePostedDays1.next()){
			leaveSalaryToBePostedDays=resultSetLeaveSalaryToBePostedDays1.getString("tobeprocesseddays");
		}
		
		String sqlTerminationBenefitLeaveSalary = "select d.alwid from hr_paycode m left join hr_payleaved d on m.doc_no=d.rdocno where d.status=3 and d.levid=m.annual_id and d.rdocno=(select MAX(doc_no) docno from hr_paycode where catid="+employeeCategoryId+")";
		ResultSet resultSetTerminationBenefitLeaveSalary = stmt.executeQuery(sqlTerminationBenefitLeaveSalary);
		
		int k=0;
		while(resultSetTerminationBenefitLeaveSalary.next()) {
			if(k==0) {
				allowanceID+=resultSetTerminationBenefitLeaveSalary.getString("alwid");
				k=1;
			}else {
				allowanceID+=","+resultSetTerminationBenefitLeaveSalary.getString("alwid");
			}
		}
		
		if(!(allowanceID.equalsIgnoreCase(""))) {
			
			String sqlTerminationBenefitLeaveSalary1 = "select round(sum(amount),0) amount from ( select * from ( select t.empid,id.rdocno,id.awlid,(id.revadd-id.revded) amount from hr_timesheet t left join hr_incrm im on t.empid=im.empid left join hr_incrd id on im.doc_no=id.rdocno where "  
				   + "im.doc_no=(select max(doc_no) from hr_incrm where t.empid=empid) and id.refdtype!='STD' and t.empid="+employeeId+" union all select 0 empid,0 rdocno,hrs.doc_no awlid,0 amount from hr_setallowance hrs where hrs.status=3 and hrs.doc_no not in (select id.awlid "
				   + "from hr_timesheet t left join hr_incrm im on t.empid=im.empid left join hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) from hr_incrm where t.empid=empid) and id.refdtype!='STD' and t.empid="+employeeId+")) as a where a.awlid in ("+allowanceID+") "
				   + "group by empid,awlid order by awlid) as b";
			ResultSet resultSetTerminationBenefitLeaveSalary1 = stmt.executeQuery(sqlTerminationBenefitLeaveSalary1);		
			
			while(resultSetTerminationBenefitLeaveSalary1.next()){
				leaveSalaryAmount=resultSetTerminationBenefitLeaveSalary1.getString("amount");
			}
			
		}
		
		/* String sqlLeaveSalaryTobePosted = "select (round((("+leaveSalaryToBePostedDays+"+"+leavesalaryeligibledays+")*("+leaveSalaryAmount+"/30)),2)) + (select round(coalesce(sum(leavesalary_tobeposted),0),2) leavesalarygiven from hr_emptran where dtype='LTD' and empid="+employeeId+") tobeposted"; */
		
		String sqlLeaveSalaryTobePosted = "select (round((("+leaveSalaryToBePostedDays+"+"+leavesalaryeligibledays+")*("+leaveSalaryAmount+"/30)),2)) tobeposted";
		ResultSet resultSetLeaveSalaryTobePosted = stmt.executeQuery(sqlLeaveSalaryTobePosted);
		
		while(resultSetLeaveSalaryTobePosted.next()) {
			leaveSalaryTobePostedAmount=resultSetLeaveSalaryTobePosted.getString("tobeposted");
		}
			
		response.getWriter().write(leavesalaryeligibledays+"####"+leavesalaryposted+"####"+leaveSalaryToBePostedDays+"####"+leaveSalaryTobePostedAmount+"####"+travelsposted);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  