<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String branchid=request.getParameter("branchid");
		String cldocno=request.getParameter("cldocno");
	    
		String sql=null;
		int val=0;
	
		 /*Audit */
    	 sql="update  my_acbook set audit=1 where dtype='CRM' and doc_no='"+cldocno+"'";
     	 val= stmt.executeUpdate(sql);
	 	 
     	 sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+cldocno+"','"+branchid+"','BCA',now(),'"+session.getAttribute("USERID").toString()+"','A')";
	 	 int data= stmt.executeUpdate(sql);
		 				
		response.getWriter().print(val);

	 	stmt.close();
	 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
	
%>
