<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
	Connection conn = null;

	try{
		ClsCommon commonDAO = new ClsCommon();
		ClsConnection connDAO = new ClsConnection();
		
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		
		java.sql.Date sqlDate=null;
		String deprDate="0",dateDiff="0",salaryPaid="0",dates="",dated="",deprDates="",deprDated="",lastDeprDates="";
		int days=0,dateCheck=0,noofdays=0;
		
		String date=request.getParameter("date");
		String branch=request.getParameter("branch");
		
	    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		     sqlDate=commonDAO.changeStringtoSqlDate(date);
		}
	    
		String sql = "select DATEDIFF(LAST_DAY('"+sqlDate+"'),'"+sqlDate+"') diff";
		ResultSet rs1 = stmt.executeQuery(sql);
		
		while(rs1.next()) {
			dateDiff=rs1.getString("diff");
		} 
		
		String sqls = "select DATE_FORMAT(min(m.terminal_benefits),'%d-%m-%Y') deprdates from hr_empm m left join hr_paycode pc on m.pay_catid=pc.catid left join hr_payeost pt "
				+ "on pc.doc_no=pt.rdocno where m.status=3 and m.active=1 and pc.catid is not null order by m.terminal_benefits";
		
		ResultSet rs2 = stmt.executeQuery(sqls);
		
		while(rs2.next()) {
			deprDates=rs2.getString("deprdates");
		}
		
		if(dateDiff.equalsIgnoreCase("0")){

		   String strSql = "select m.doc_no,m.terminal_benefits deprdate,DATEDIFF(last_day('"+sqlDate+"'),min(m.terminal_benefits)) deprDiff,(DATEDIFF(last_day('"+sqlDate+"'),min(m.terminal_benefits))) dateDiff,"
				   + "DAY(LAST_DAY('"+sqlDate+"')) noofdays from hr_empm m left join hr_paycode pc on m.pay_catid=pc.catid left join hr_payeost pt on pc.doc_no=pt.rdocno where m.status=3 and m.active=1 "
				   + "and pc.catid is not null and m.terminal_benefits is not null group by m.doc_no order by m.terminal_benefits";
		   
			ResultSet rs = stmt.executeQuery(strSql);
			
			while(rs.next()) {
				deprDated=rs.getString("deprDiff");
				dates=rs.getString("deprdate");
				dateCheck=rs.getInt("dateDiff");
				noofdays=rs.getInt("noofdays");
				
				if(dateCheck>noofdays){
					deprDate="0";
					dateDiff="0";
					break;					
				}
				
				if(dateCheck>0 && dateCheck<=noofdays){
					deprDate="1";
					dateDiff="0";
					break;
				}
				
				if(dateCheck<=0 && !(deprDate=="1") && !(dateDiff=="0")){
					deprDate="2";
					dateDiff="0";
				}
			}	
		} else{
		        dateDiff="2";
	    }
		
		String sqlSalaryPaid = "select count(*) salaryPaid from hr_empm where active=1 and status=3 and dtjoin<='"+sqlDate+"' and salary_paid<'"+sqlDate+"'";
		ResultSet rsSalaryPaid = stmt.executeQuery(sqlSalaryPaid);
		
		while(rsSalaryPaid.next()) {
			salaryPaid=rsSalaryPaid.getString("salaryPaid");
		} 
		response.getWriter().write(deprDate+"***"+dateDiff+"***"+deprDates+"***"+salaryPaid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  