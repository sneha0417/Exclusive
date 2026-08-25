<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
Connection conn = null;

try{
 	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();

	String file=request.getParameter("filename").trim();
	String docno=request.getParameter("docno");

	int result=0;

	String strSql = "update my_fileattach set status=7 where filename='"+file+"'";
	int rs1 = stmt.executeUpdate(strSql);
	
	String strSqls = "update gl_drattachdet set status=7 where doc_no='"+docno+"'";
	int rs = stmt.executeUpdate(strSqls);
	
	response.getWriter().print(rs);
	
	stmt.close();
	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}
  %>
  
