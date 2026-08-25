<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
Connection conn = null;
try{
	//String name=request.getParameter("name");
 	 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select costType,costgroup from my_costunit where master=1 ";
	ResultSet rs = stmt.executeQuery(strSql);
	String costType="",costgroup="";
	while(rs.next()) {
		costgroup+=rs.getString("costgroup")+",";
		costType+=rs.getString("costType")+",";
		
  		} 
	costgroup=costgroup.substring(0, costgroup.length());
	costType=costType.substring(0, costType.length());
		response.getWriter().write(costgroup+"####"+costType);
	session.setAttribute("head",costgroup);
	stmt.close();
	conn.close();
	
}
catch(Exception e){

	e.printStackTrace();
	conn.close();

}
  %>
  
