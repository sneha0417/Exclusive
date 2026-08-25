<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		java.sql.Date sqlDate=null;
		String dateDiff="0";
		
		String date=request.getParameter("fromDate");
		
	    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(date);
		}
	    
		String strSql = "select MIN(ACCYR_F) ACCYR_F from my_year";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String accountfrom="";
		while(rs.next()) {
			accountfrom=rs.getString("ACCYR_F");
		} 
		
		String sql = "select DATEDIFF('"+sqlDate+"','"+accountfrom+"') diff";
		ResultSet rs1 = stmt.executeQuery(sql);
		
		while(rs1.next()) {
			dateDiff=rs1.getString("diff");
		} 
		
		response.getWriter().write(dateDiff);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  