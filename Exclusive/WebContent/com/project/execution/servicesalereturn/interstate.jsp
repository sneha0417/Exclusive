
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


	



java.sql.Date sqlexdate=null;



	 String upsql=null;

	 int val=0;
	 int docval=0;
	 Connection conn=null;

	 try{
 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	Statement stmt1 = conn.createStatement ();
	
		   
		
				   upsql="select method from gl_config where field_nme = 'tax'";
				   ResultSet resultSet = stmt.executeQuery(upsql);
				    
				    if (resultSet.next()) {
				    	docval=resultSet.getInt("method");
				    }		  
			 if(docval==0){
		  			
				 upsql="select method from gl_prdconfig where field_nme = 'tax'";
				   ResultSet resultSet1 = stmt1.executeQuery(upsql);
				   
				    if (resultSet1.next()) {
				    	docval=resultSet1.getInt("method");
				    }			
		 
			 }
	 
			 response.getWriter().print(docval);
	 	stmt.close();
	 	stmt1.close();
	 	conn.close();
	 }
	 catch(Exception e){

			conn.close();
			e.printStackTrace();
		}
	    
	
	%>
