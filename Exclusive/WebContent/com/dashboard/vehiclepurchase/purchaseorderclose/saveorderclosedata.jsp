
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


	String radocno=request.getParameter("radocno");
	String branchval=request.getParameter("branchval");
	String rowno=request.getParameter("srno");
	
	 String upsql=null;
	 int val=0;
	 int result=-1;
		Connection conn=null;

	 try{
 	 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();

	
	upsql="update  gl_vpod  set clstatus=1 where rdocno='"+radocno+"' and rowno='"+rowno+"' ";
	//System.out.println("--1---upsql------"+upsql);
	
	 val= stmt.executeUpdate(upsql);
	 
	 
	 String selectsql="select count(rdocno) result from gl_vpod where clstatus=0 and rdocno='"+radocno+"' " ;
	// System.out.println("---2--selectsql------"+selectsql); 
	 ResultSet rs =stmt.executeQuery(selectsql);
	 if(rs.next())
	 {
		 result=rs.getInt("result");
		 
	 }
	
	 
	if(result==0)
	{
	
	String	upsql1="update  gl_vpom  set status=6 where doc_no='"+radocno+"' ";
	// System.out.println("---upsql1------"+upsql1); 
		 val= stmt.executeUpdate(upsql1);
		 
	}
		 
		
		 upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+radocno+",'"+branchval+"','BPOC',now(),'"+session.getAttribute("USERID").toString()+"','A')";
		 
		 int aaa= stmt.executeUpdate(upsql);

	
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
