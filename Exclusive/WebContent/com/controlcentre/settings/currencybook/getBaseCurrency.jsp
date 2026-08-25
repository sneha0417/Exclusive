<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select c.doc_no,c.code from my_brch b left join my_curr c on b.curid=c.doc_no where b.cmpid='"+session.getAttribute("COMPANYID")+"' and b.mainbranch=1";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String curid="";
		String curcode="";
		while(rs.next()) {
			curid+=rs.getInt("doc_no");
			curcode+=rs.getString("code");
		} 
		
		response.getWriter().write(curid+"####"+curcode);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  