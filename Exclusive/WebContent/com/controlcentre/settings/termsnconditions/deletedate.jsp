
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


Connection conn=null;

try{
	 ClsConnection ClsConnection=new ClsConnection();
	String radocno=request.getParameter("radocno");
	String type=request.getParameter("type");
	
	 String upsql=null;

	 int val=0;
	
 	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	   if(type.equalsIgnoreCase("header"))
	   {
		upsql="update  my_termsm  set status=7 where voc_no='"+radocno+"' ";
		
		 val= stmt.executeUpdate(upsql);
	   }
	   else if(type.equalsIgnoreCase("footer"))
	   {
		   
		   upsql="update  my_termsd  set status=7 where doc_no='"+radocno+"' ";
			
			 val= stmt.executeUpdate(upsql);
	   }
		 
		 response.getWriter().print(val);
	 
	 	//System.out.println("aaaaaa"+accode);
	 	stmt.close();
	 	conn.close();
	 	  
	 }

	 catch(Exception e){

	 			conn.close();
	 			e.printStackTrace();
	 		}
	
	%>
