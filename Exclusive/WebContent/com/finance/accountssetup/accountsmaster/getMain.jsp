<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
Connection conn = null;
try{
	ClsConnection connDAO=new ClsConnection();
	//String name=request.getParameter("name");
 	 conn = connDAO.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select fi_id,head from my_agrp where fi_id>10 order by head ";
	ResultSet rs = stmt.executeQuery(strSql);
	String fi_id="",head="";
	while(rs.next()) {
		head+=rs.getString("head")+",";
		fi_id+=rs.getString("fi_id")+",";
		
  		} 
	head=head.substring(0, head.length());
	fi_id=fi_id.substring(0, fi_id.length());
		response.getWriter().write(head+"####"+fi_id);
	session.setAttribute("head",head);
	stmt.close();
	conn.close();
	}
	catch(Exception e){

		e.printStackTrace();
		conn.close();

	}
  %>
  
