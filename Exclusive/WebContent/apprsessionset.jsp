  
 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	

		
			String sessionbrch=request.getParameter("sessionbrch");
			session.setAttribute("BRANCHID",sessionbrch);
		//	System.out.println("===sessionbranch======"+sessionbrch);
 			response.getWriter().write(1);


  %>
  
 