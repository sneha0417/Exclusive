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
		 int val=0,docNo=0,brhid=0;
		 
			     sql="update my_jvtran set rdocno=0 where status=3 and tranid='"+tranid+"'";
	     
	     System.out.println("jvtran rdocno remove="+sql);
	     
	     val= stmt.executeUpdate(sql);
	     
	     
	     String sqls="select doc_no,brhid from gl_bpar where tranid='"+tranid+"'";
	     
	     System.out.println("gl_bpar doc_no,brhid select="+sqls);
	     
	     ResultSet resultSet = stmt.executeQuery(sqls);
	 	     
	 	     
	 	     
	 	    while (resultSet.next()) {
				   docNo=resultSet.getInt("doc_no");
				   
				   brhid=resultSet.getInt("brhid");
		     }
	     	
	     
	    
     	 sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+brhid+"','BPAR',now(),'"+session.getAttribute("USERID").toString()+"','D')";
     	 
     	System.out.println("gl_biblog entry update ="+sql);
     	 
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
