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
 
	String refno=request.getParameter("refno");
	String leaveid=request.getParameter("leaveid");
	
	String upsql=null;
	int val=0;
	Connection conn=null;
	ClsConnection ClsConnection=new ClsConnection();


	try{
 	 	 conn = ClsConnection.getMyConnection();
		 Statement stmt = conn.createStatement ();
	
		 upsql="update  hr_payleavem  set status=7 where rdocno='"+refno+"' and levid='"+leaveid+"'  ";
		 val= stmt.executeUpdate(upsql);
		 
		 upsql="update  hr_payleaved  set status=7 where rdocno='"+refno+"' and levid='"+leaveid+"'  ";
		 val= stmt.executeUpdate(upsql);
	
		 response.getWriter().print(val);
	 
	 	stmt.close();
	 	conn.close();
	   } catch(Exception e){
			e.printStackTrace();
			conn.close();
	   }
	
%>
