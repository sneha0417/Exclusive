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
		String deprDate="0",dateDiff="0",salaryPaid="0",dates="",dated="",deprDates="",terminaldate="",deprDated="",lastDeprDates="";
		int days=0,dateCheck=0,noofdays=0;
		
		String date=request.getParameter("date");
		String branch=request.getParameter("branch");
		String empid=request.getParameter("empid");
		
	    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		     sqlDate=commonDAO.changeStringtoSqlDate(date);
		}
	    
	    String sql = "select DATEDIFF(LAST_DAY('"+sqlDate+"'),'"+sqlDate+"') diff";
		ResultSet rs1 = stmt.executeQuery(sql);
		
		while(rs1.next()) {
			dateDiff=rs1.getString("diff");
		} 
	    
		String sqls = "select DATE_FORMAT(min(m.terminal_benefits),'%d-%m-%Y') deprdates,min(m.terminal_benefits) terminaldate from hr_empm m left join hr_paycode pc on m.pay_catid=pc.catid left join hr_payeost pt "
				+ "on pc.doc_no=pt.rdocno where m.status=3 and m.active=1 and pc.catid is not null and m.doc_no="+empid+" order by m.terminal_benefits";
		
		
		ResultSet rs2 = stmt.executeQuery(sqls);
		
		while(rs2.next()) {
			deprDates=rs2.getString("deprdates");
			terminaldate=rs2.getString("terminaldate");
		}
		
	    String strSql = "select m.doc_no,m.terminal_benefits deprdate,DATEDIFF(last_day('"+sqlDate+"'),min(m.terminal_benefits)) deprDiff,(DATEDIFF(last_day('"+sqlDate+"'),min(m.terminal_benefits))) dateDiff,"
			   + "DAY(LAST_DAY('"+sqlDate+"')) noofdays from hr_empm m left join hr_paycode pc on m.pay_catid=pc.catid left join hr_payeost pt on pc.doc_no=pt.rdocno where m.status=3 and m.active=1 "
			   + "and pc.catid is not null and m.terminal_benefits is not null and m.doc_no="+empid+" group by m.doc_no order by m.terminal_benefits";
	   
	    
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
		
		response.getWriter().write(deprDate+"***"+dateDiff+"***"+deprDates+"***"+salaryPaid+"***"+terminaldate);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  