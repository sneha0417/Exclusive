<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%	
	Connection conn = null;

	try{
		ClsConnection connDAO = new ClsConnection();
		ClsCommon commonDAO = new ClsCommon();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		java.sql.Date sqlStartDate=null;
		java.sql.Date sqlEndDate=null;
		
		String halfday=request.getParameter("halfday");
		String startdate=request.getParameter("startdate");
		String enddate=request.getParameter("enddate");
        
        sqlStartDate =(startdate.equalsIgnoreCase("undefined") || startdate.equalsIgnoreCase("NaN") || startdate.equalsIgnoreCase("") || startdate.equalsIgnoreCase("0") ||  startdate.isEmpty()?null:commonDAO.changeStringtoSqlDate(startdate));
        sqlEndDate =(enddate.equalsIgnoreCase("undefined") || enddate.equalsIgnoreCase("NaN") || enddate.equalsIgnoreCase("") || enddate.equalsIgnoreCase("0") ||  enddate.isEmpty()?null:commonDAO.changeStringtoSqlDate(enddate));
        
        Double noofdays=0.00;
		String strSql = "SELECT (TIMESTAMPDIFF(DAY, coalesce('"+sqlStartDate+"',null), coalesce('"+sqlEndDate+"',null))) noofdays";
		ResultSet rs = stmt.executeQuery(strSql);
		
		
		while(rs.next()) {
			noofdays=rs.getDouble("noofdays")==0.00?1:rs.getDouble("noofdays")+1;
		} 
        
		if(halfday.equalsIgnoreCase("1")) {
			noofdays = noofdays - 0.5;
		}
		
		response.getWriter().print(noofdays);
		
		stmt.close();
		conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	} finally{
		conn.close();
	}
  %>
  