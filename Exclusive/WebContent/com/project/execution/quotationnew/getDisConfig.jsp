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
		
		
		String sql=null;
		String val="0";
	
		 
    	 	sql="select method from gl_config where field_nme like 'Quotation Discount'";
     	 	ResultSet resultset= stmt.executeQuery(sql);
     	 	
     	 	if (resultset.next()){
     	 		
     	 		val=resultset.getString("method");
     	 		System.out.println("method=========="+val);
     	 	}
     	 	
     	 	
		 				
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
