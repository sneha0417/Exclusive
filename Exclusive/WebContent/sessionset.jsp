  
 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	

			String formCode=request.getParameter("formCode1");
			String sessionbrch=request.getParameter("sessionbrch");
			session.setAttribute("BRANCHID",sessionbrch);
			session.setAttribute("Code",formCode);
			//System.out.println(formCode+"============ "+session.getAttribute("Code")+"========="+sessionbrch);
 			
			Object COMPANYID=session.getAttribute("COMPANYID");
			Object BRANCHID=session.getAttribute("BRANCHID");
			Object USERID=session.getAttribute("USERID");
		 
			
			
		//	System.out.println(formCode+"============ "+session.getAttribute("Code")+"=====COMPANYID===="+COMPANYID);
 			
			
			if(COMPANYID==null || USERID==null || COMPANYID=="" || USERID=="")
			{
				response.getWriter().print(0);

			}
			else
			{
				response.getWriter().print(1);

			}
			
			 


  %>
  
 