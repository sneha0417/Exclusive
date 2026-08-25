<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
	Connection conn=null;
try{
	
 	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	//System.out.println("conn:"+conn);
	String strSql = "select count(*) as count from my_brch where status<>7;";
	ResultSet rs = stmt.executeQuery(strSql);
	int count=0;
	while(rs.next()) {
		count=rs.getInt("count");		
		
				
  		}
	stmt.close();
	conn.close();

	response.getWriter().write(count+"***"+count);
	//System.out.println("COMPID==="+count);
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