 
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
   System.out.println("docno=="+docno);
	 Connection conn=null;

	 try{
		 ClsConnection ClsConnection =new ClsConnection();
		 ClsCommon ClsCommon=new ClsCommon();
	 
 	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
    String sql="update my_srvm m set m.audit=1 where doc_no="+docno+";";	
    int aaa= stmt.executeUpdate(sql);
	response.getWriter().print(aaa);
	 	//System.out.println("aaaaaa"+accode);
	 	stmt.close();
	 	conn.close();
	 	  
	 }

	 catch(Exception e){
		 response.getWriter().print(0);
	 			conn.close();
	 			e.printStackTrace();
	 		}
	
	%>
