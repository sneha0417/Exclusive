<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	



Connection conn = null;
try{
	
	ClsConnection connDAO = new ClsConnection();
	//String name=request.getParameter("name");
 	 conn = connDAO.getMyConnection();
	Statement stmt = conn.createStatement ();
	/* String strSql = "select h.description mainac,h.brhid, h.den,trim(h.doc_no) doc_no from my_head h where h.m_s=1  order by mainac"; */
	String strSql = "select h.description mainac,h.brhid, h.den,trim(h.doc_no) doc_no from my_head h where h.m_s=1  and den<>255 and den<>340 order by mainac";
	//System.out.println("-------strSql-------"+strSql);
	
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
  
