<%@page import="com.common.ClsCommon"%>
<%@page import="com.finance.interbranchtransactions.ibjournalvouchers.ClsIJVExcelImport"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>

<%
	Connection conn = null;

	try{
		ClsConnection connDAO = new ClsConnection();
		conn = connDAO.getMyConnection();
	 	String docNo=request.getParameter("docNo");
	 	
	 	ClsIJVExcelImport ijv = new ClsIJVExcelImport();
		
		int val=ijv.ExcelImport(docNo);
	    
		response.getWriter().print(val);

	 	 conn.close(); 
	} catch(Exception e){
	 	e.printStackTrace();	
	 	conn.close();
   } finally{
	   conn.close();
   }
%>
  
