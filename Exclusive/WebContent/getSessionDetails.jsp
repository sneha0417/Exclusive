<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
		 Date acdate=new Date(session.getLastAccessedTime());
		 Date creDate= new Date(session.getCreationTime());
		
		 long activetime=(acdate.getTime()/ 1000) - (creDate.getTime()/ 1000) ;
		
		 long maxtime= new Date(session.getMaxInactiveInterval()).getTime() ;
		
		
		String result="0";
		if(activetime  > maxtime){
			result="1";
			session.invalidate(); 
		}
		
		response.getWriter().write(result);
		
  %>
  

  