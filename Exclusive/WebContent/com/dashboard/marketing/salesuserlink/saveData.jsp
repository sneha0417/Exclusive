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
		
		String salesmanid=request.getParameter("salesmanid");
		String userdocno=request.getParameter("userdocno");
		String rpttype=request.getParameter("rpttype");
	    
		String sql=null;
		int val=0;
	
		 /*Linking Salesman with User */
		 if(rpttype.equalsIgnoreCase("1")) {
    	 	sql="update my_salm set salesuserlink="+userdocno+" where status<>7 and doc_no="+salesmanid+"";
     	 	val= stmt.executeUpdate(sql);
     	 	
     	 	sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+salesmanid+"','"+session.getAttribute("BRANCHID").toString()+"','BSUL',now(),'"+session.getAttribute("USERID").toString()+"','A')";
   	 	    int data= stmt.executeUpdate(sql);
		 }
		 /*Linking Salesman with User Ends*/
		 
		 /*Remove Linking Salesman with User */
		 if(rpttype.equalsIgnoreCase("2")) {
    	 	sql="update my_salm set salesuserlink=null where status<>7 and doc_no="+salesmanid+"";
     	 	val= stmt.executeUpdate(sql);
     	 	
     	 	sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+salesmanid+"','"+session.getAttribute("BRANCHID").toString()+"','BSUL',now(),'"+session.getAttribute("USERID").toString()+"','D')";
   	 	    int data= stmt.executeUpdate(sql);
		 }
		 /*Remove Linking Salesman with User Ends*/
		 				
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
