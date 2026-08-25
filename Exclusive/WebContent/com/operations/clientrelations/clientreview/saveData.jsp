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
	Connection conn = null;

	try{
		ClsConnection connDAO = new ClsConnection();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String description=request.getParameter("description");
		String cldocno=request.getParameter("cldocno");
		String mode=request.getParameter("mode");
	    
		String sql=null;
		int val=0;
	
		 /*Insert into my_acbook */
    	 sql="update  my_acbook set spcl_notes='"+description+"' where dtype='CRM' and doc_no='"+cldocno+"'";
		 val= stmt.executeUpdate(sql);
	 	 
     	 sql="insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+cldocno+"','"+session.getAttribute("BRANCHID").toString()+"','CRW',now(),'"+session.getAttribute("USERID").toString()+"','"+mode+"')";
	 	 int data= stmt.executeUpdate(sql);
		
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
