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

	Connection conn = null; 
	
	try{

		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String formdetail=request.getParameter("formdetail");
		String docno=request.getParameter("docno");
		
		String strSql = "select field_nme,method from gl_config where field_nme in('email','sms','support','approve','msngr','passchange','user') ";
		ResultSet rs = stmt.executeQuery(strSql);

		int email=0;
		int sms=0;
		int support=0;
		int approval=0;
		int msngr=0;
		int passchange=0;
		int user=0;
		int i=0;
		while(rs.next()) {
			if(i==0)
			email=rs.getInt("method");
			if(i==1)
				sms=rs.getInt("method");
			if(i==2)
				support=rs.getInt("method");
			if(i==3)
				approval=rs.getInt("method");
			if(i==4)
				msngr=rs.getInt("method");
			if(i==5)
				passchange=rs.getInt("method");
			if(i==6)
				user=rs.getInt("method");
			
				
			i++;
				} 
		
		System.out.println(email+"##"+sms+"##"+support+"##"+approval+"##"+msngr+"##"+passchange+"##"+user);
		
		response.getWriter().write(email+"##"+sms+"##"+support+"##"+approval+"##"+msngr+"##"+passchange+"##"+user);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  