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
		 
		 String docno=request.getParameter("docno")==null || request.getParameter("docno").trim().equalsIgnoreCase("")?"0":request.getParameter("docno").trim();
		 String dtype=request.getParameter("dtype")==null || request.getParameter("dtype").trim().equalsIgnoreCase("")?"0":request.getParameter("dtype").trim();
		 String acno=request.getParameter("acno")==null || request.getParameter("acno").trim().equalsIgnoreCase("")?"0":request.getParameter("acno").trim();
		 String tranid=request.getParameter("tranid")==null || request.getParameter("tranid").trim().equalsIgnoreCase("")?"0":request.getParameter("tranid").trim();
		 String jobno=request.getParameter("jobno")==null || request.getParameter("jobno").trim().equalsIgnoreCase("")?"0":request.getParameter("jobno").trim();
		
		 String sql=null;
		 int val=0,docNo=0;
		 
		 String sqls="select coalesce(max(doc_no)+1,1) doc_no from gl_bpar";
	     ResultSet resultSet = stmt.executeQuery(sqls);
	  
	     while (resultSet.next()) {
			   docNo=resultSet.getInt("doc_no");
	     }
	 
	     sql="update my_jvtran set rdocno='"+jobno+"' where status=3 and tranid='"+tranid+"'";
	     val= stmt.executeUpdate(sql);
	     
	     sql="insert into gl_bpar(doc_no, date, jobno, tranid, acno, rdocno, rdtype, brhid, userid, status) values('"+docNo+"', now(), '"+jobno+"', '"+tranid+"', '"+acno+"', '"+docno+"', '"+dtype+"', '"+session.getAttribute("BRANCHID").toString()+"', '"+session.getAttribute("USERID").toString()+"', 3)";
	     val= stmt.executeUpdate(sql);
	     	
		 
     	 sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+session.getAttribute("BRANCHID").toString()+"','BPAR',now(),'"+session.getAttribute("USERID").toString()+"','E')";
	 	 int data= stmt.executeUpdate(sql);
		 				
		response.getWriter().print(val);

	 	stmt.close();
	 	conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   } finally{
	   conn.close();
   }
	
%>
