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
		
 int branchid=1;
		String docnos=request.getParameter("docnos")==null?"0":request.getParameter("docnos");
		
		System.out.println("=======docnos====="+docnos);
	    
		String sql=null;
		int val=0;
		
		String sql9s="select brhid from my_invm where doc_no='"+docnos+"'";
		ResultSet rst=stmt.executeQuery(sql9s);
		if(rst.first())
		{
			branchid=rst.getInt("brhid");
		}
	
		 /*Audit */
    	 sql="update  my_invm set audit=1 where   doc_no='"+docnos+"'";
     	 val= stmt.executeUpdate(sql);
	 	 
     	 sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docnos+"','"+branchid+"','SINA',now(),'"+session.getAttribute("USERID").toString()+"','A')";
	 	 int data= stmt.executeUpdate(sql);
		 				
		response.getWriter().print(1);

	 	stmt.close();
	 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	response.getWriter().print(0);
	 	conn.close();
   }finally{
	   conn.close();
   }
	
%>
