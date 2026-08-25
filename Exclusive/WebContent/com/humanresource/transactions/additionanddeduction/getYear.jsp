<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

	
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select year(curdate()) year";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String year="";
		String yearid="";
		String endyear="";
		while(rs.next()) {
			endyear=rs.getString("year");	
	  	}
		
		for(int i=Integer.parseInt(endyear);i>=1900;i--){
			year+=i+",";
			yearid+=i+",";
		}
		
		year=year.substring(0, year.length()>0?year.length()-1:0);
		
		response.getWriter().write(year+"####"+yearid);
		
		stmt.close();
		conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	} finally{
		conn.close();
	}
  
%>
  
