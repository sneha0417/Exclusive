<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>


<%	
ClsConnection ClsConnection=new ClsConnection();
Connection conn = null;

 	try{
 		conn=ClsConnection.getMyConnection();
 		String temp=request.getParameter("brand1");
	Statement stmt = conn.createStatement ();
	String strSql = "select brand_name from gl_vehbrand where status<>7 and brand_name='"+temp+"'";
	System.out.println(strSql);
	ResultSet rs = stmt.executeQuery(strSql);
	
	String brand="";
	if(rs.next()) {
		brand=rs.getString("brand_name");
  		} 
	else{
		brand="undefine";
	}
	stmt.close();
	conn.close();
	response.getWriter().write(brand);
	System.out.println("Brand:"+brand);
	/* response.getWriter().write(auth.toArray()); */
	
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
 	finally{
 		conn.close();
 	}
  %>