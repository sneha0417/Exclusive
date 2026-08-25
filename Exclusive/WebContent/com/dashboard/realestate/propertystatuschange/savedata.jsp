 
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


	String docno=request.getParameter("doc_no");
   System.out.println("doc_no=="+docno);
	 Connection conn=null;

	 try{
		 ClsConnection ClsConnection =new ClsConnection();
		 ClsCommon ClsCommon=new ClsCommon();
	 
 	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
    String sql="update rl_propertymaster m set m.active=0 where doc_no="+docno+";";	
	 System.out.println("aaaaaa---"+sql);

    int aaa= stmt.executeUpdate(sql);
	 System.out.println("aaaaaa---"+aaa);

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
