<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
	Connection conn = null;

	try{
		
		ClsConnection connDAO=new ClsConnection();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();

		java.sql.Date sqlPayrollPostDate=null;
	    String message = "";
	    
	    /* Date to be Posted*/
	    String sql = "select LAST_DAY(DATE_ADD(min(date),INTERVAL 1 DAY)) tobepostdate,Coalesce(CONCAT('Done till ',DATE_FORMAT(min(date),'%b %Y')),'') message from hr_payrolld where posted=0";
		ResultSet rs = stmt.executeQuery(sql);
		
		while(rs.next()) {
			sqlPayrollPostDate= rs.getDate("tobepostdate");
			message= rs.getString("message");
		} 
		/* Date to be Posted Ends*/
		
		response.getWriter().write(sqlPayrollPostDate+"***"+message);
		
		stmt.close();
		conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	} finally{
		conn.close();
	}
  %>
  