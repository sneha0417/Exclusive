 
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
	String docno=request.getParameter("docno");
	String brhid=request.getParameter("brhid");
	String description=request.getParameter("description");
	 Connection conn=null;
	 try{
		 ClsConnection ClsConnection =new ClsConnection();
		 ClsCommon ClsCommon=new ClsCommon();
		 String upsql="",logsql="";
		 conn = ClsConnection.getMyConnection();
		 conn.setAutoCommit(false);
		 Statement stmt = conn.createStatement ();

		 upsql="insert into gl_contrexp(rdocno,brhid, description, date, userId) values ('"+docno+"','"+brhid+"','"+description+"',now(),'"+session.getAttribute("USERID").toString()+"' )";
		 System.out.println("==upsql="+upsql);
		 int bbb= stmt.executeUpdate(upsql);	
		 
		 logsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+brhid+"','BTCE',now(),'"+session.getAttribute("USERID").toString()+"','A')";
		 System.out.println("==logsql="+logsql);
		 int aaa= stmt.executeUpdate(logsql);	
		 
		 if(bbb>0&&aaa>0){
			 conn.commit();
			 stmt.close();
			 conn.close();
			 response.getWriter().print(1);
		 }
		 else{
			 stmt.close();
			 conn.close();
			 response.getWriter().print(0);
		 }
	 }

	 catch(Exception e){
		 response.getWriter().print(0);
		 conn.close();
		 e.printStackTrace();
	 }
%>