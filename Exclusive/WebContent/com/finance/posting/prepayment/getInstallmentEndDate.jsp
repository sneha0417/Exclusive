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
		String installno=request.getParameter("installno")==null || (request.getParameter("installno")).equalsIgnoreCase("")?"0":request.getParameter("installno");
		String startdate=request.getParameter("startdate");
				
        sqlStartDate =(startdate.equalsIgnoreCase("undefined") || startdate.equalsIgnoreCase("NaN") || startdate.equalsIgnoreCase("") || startdate.equalsIgnoreCase("0") ||  startdate.isEmpty()?null:commonDAO.changeStringtoSqlDate(startdate));
        
        if(frequency.equalsIgnoreCase("2")){
        	frequency="MONTH";
        } else if(frequency.equalsIgnoreCase("3")){
        	frequency="YEAR";
        } else {
        	frequency="DAY";
        }
        
		String strSql = "SELECT DATE_ADD(coalesce('"+sqlStartDate+"',null),INTERVAL if("+installno+"=0,0,("+installno+"-1)) "+frequency+") installenddate";
		ResultSet rs = stmt.executeQuery(strSql);
		
		while(rs.next()) {
			sqlEndDate=rs.getDate("installenddate");
		} 
		
		response.getWriter().print(sqlEndDate);
		
		stmt.close();
		conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	} finally{
		conn.close();
	}
  %>
  