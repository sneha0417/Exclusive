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
		
		String frequency=request.getParameter("frequency");
		String startdate=request.getParameter("startdate");
		String enddate=request.getParameter("enddate");
        
        sqlStartDate =(startdate.equalsIgnoreCase("undefined") || startdate.equalsIgnoreCase("NaN") || startdate.equalsIgnoreCase("") || startdate.equalsIgnoreCase("0") ||  startdate.isEmpty()?null:commonDAO.changeStringtoSqlDate(startdate));
        sqlEndDate =(enddate.equalsIgnoreCase("undefined") || enddate.equalsIgnoreCase("NaN") || enddate.equalsIgnoreCase("") || enddate.equalsIgnoreCase("0") ||  enddate.isEmpty()?null:commonDAO.changeStringtoSqlDate(enddate));
        
        if(frequency.equalsIgnoreCase("2")){
        	frequency="MONTH";
        } else if(frequency.equalsIgnoreCase("3")){
        	frequency="YEAR";
        } else {
        	frequency="DAY";
        }
        
		String strSql = "SELECT (TIMESTAMPDIFF("+frequency+", coalesce('"+sqlStartDate+"',null), coalesce('"+sqlEndDate+"',null))+1) installments";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String installments="0";
		while(rs.next()) {
			installments=rs.getString("installments");
		} 
		
		response.getWriter().write(installments);
		
		stmt.close();
		conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	} finally{
		conn.close();
	}
  %>
  