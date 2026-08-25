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
		
		String availability=request.getParameter("availability").equalsIgnoreCase("")?"0":request.getParameter("availability");
	    
		String sql=null;
		int val=0;
	
		 /*Availability */
    	 sql="update gw_empavailability set availability='"+availability+"' where status=3 and userid='"+session.getAttribute("USERID").toString()+"'";
     	 val= stmt.executeUpdate(sql);
	 	 
		response.getWriter().print(val+"####"+availability);

	 	stmt.close();
	 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
	
%>
