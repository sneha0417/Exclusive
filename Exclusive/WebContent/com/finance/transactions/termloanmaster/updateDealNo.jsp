
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>
 
<%@page import="com.common.*"%>
<%@page import="java.sql.Statement"%>

<%
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

 String dealno=request.getParameter("dealno");
 String doc=request.getParameter("masterdoc");

 Connection conn=null;
 	String tempstatus="";

 	try{
	 	conn=ClsConnection.getMyConnection();
		Statement stmt=conn.createStatement();
		
		String masterupdate="update gl_termloandetm set dealno='"+dealno+"' WHERE rdocno='"+doc+"'";
		stmt.executeUpdate(masterupdate);
		
		int val2=stmt.executeUpdate(masterupdate);
		if(val2>0){
		tempstatus="1";
		}
		stmt.close();
		conn.close();
		
 	}catch(Exception e){	
		 e.printStackTrace();
		 conn.close();
		
	} 

	
//	String tempstatus="1";
	response.getWriter().write(tempstatus); 
	
  %>