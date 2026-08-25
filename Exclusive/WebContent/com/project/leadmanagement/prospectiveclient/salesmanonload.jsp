<%@page import="com.itextpdf.text.log.SysoCounter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% 
		 
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

	try{
		
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
	String salesman="0";
	int salid=0;
	
		String consql="select sal_name,doc_no from my_salm where status=3 and salesuserlink="+session.getAttribute("USERID")+"";
		ResultSet rsconfg = stmt.executeQuery(consql);
System.out.println("consql=="+consql);
		while (rsconfg.next()) {
			
			salesman=rsconfg.getString("sal_name");
			salid=rsconfg.getInt("doc_no");
		}
			
		response.getWriter().write(salesman+"::"+salid);
		

		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  