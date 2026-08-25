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
	String strSql = "select h.description mainac,h.doc_no,h.costtype from my_ccentre h where h.m_s=1 order by mainac";
	ResultSet rs = stmt.executeQuery(strSql);
	String den="",mainac="";
	while(rs.next()) {
		mainac+=rs.getString("mainac")+",";
		den+=rs.getString("doc_no")+",";
		
  		} 
	mainac=mainac.substring(0,mainac.length());
	den=den.substring(0, den.length());
	
		response.getWriter().write(mainac+"####"+den.trim());
	session.setAttribute("mainac",mainac);
	stmt.close();
	conn.close();
	
}
catch(Exception e){

	e.printStackTrace();
	conn.close();

}
	
  %>
  
