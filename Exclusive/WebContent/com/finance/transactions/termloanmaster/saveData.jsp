<%@page import="com.common.ClsCommon"%>
 <%@page import="com.finance.transactions.termloanmaster.ClsloanExcelImport"%> 
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>

<%
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();


	try{ 
	 	conn = ClsConnection.getMyConnection();
	 	String docNo=request.getParameter("docNo");
	 	
	 	ClsloanExcelImport jvt = new ClsloanExcelImport();
		
		int val=jvt.ExcelImport(docNo);  
	    
	  response.getWriter().print(val);
 
	 	 conn.close(); 
	}catch(Exception e){
	 	e.printStackTrace();	
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
  
