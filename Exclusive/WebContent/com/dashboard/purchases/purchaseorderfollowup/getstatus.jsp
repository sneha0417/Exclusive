<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	

Connection conn=null;

try{ ClsConnection ClsConnection=new ClsConnection();
	 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select doc_no,name from my_statuslist where status=3 and dtype='PO'";
	ResultSet rs = stmt.executeQuery(strSql);
	String pro="",sr="";
	while(rs.next()) {
				pro+=rs.getString("name")+",";
				sr+=rs.getString("doc_no")+",";
			} 
	String procc[]=pro.split(",");
	String brnId[]=sr.split(",");
	pro=pro.substring(0, pro.length()-1);
	sr=sr.substring(0, sr.length()-1);
	
	response.getWriter().write(sr+"####"+pro);
	stmt.close();
	conn.close();
	
}
catch(Exception e){

		conn.close();
		e.printStackTrace();
	}
	
	
	
	
  %>
  