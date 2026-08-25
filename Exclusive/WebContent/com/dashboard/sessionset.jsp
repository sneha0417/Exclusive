<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
ClsConnection ClsConnection=new ClsConnection();
     
	Connection conn = null;

	try{
 	        conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
	
			String sessionbrch=request.getParameter("sessionbrch");
			
			// System.out.println("==sessionbrch====");
            
            if(sessionbrch.equalsIgnoreCase("a")){

            	String sql = "select doc_no from my_brch where mainbranch=1";
        		ResultSet rs = stmt.executeQuery(sql);
        		
        		while(rs.next()){
        			sessionbrch = rs.getString("doc_no");
        		}
        		
            }
    		
			session.setAttribute("BRANCHID",sessionbrch);
			//System.out.println("====== "+session.getAttribute("BRANCHID"));
 			//response.getWriter().write(1);
			Object COMPANYID=session.getAttribute("COMPANYID");
			Object BRANCHID=session.getAttribute("BRANCHID");
			Object USERID=session.getAttribute("USERID");
		 
			
			
			//System.out.println("=====COMPANYID===="+COMPANYID);
 			
			if(COMPANYID==null ||  USERID==null || COMPANYID==""  || USERID=="")
			{
				response.getWriter().print(0);

			}
			else
			{
				response.getWriter().print(1);

			}
			
			 

 			stmt.close();
 			conn.close();
 		}catch(Exception e){
 		 	e.printStackTrace();
 		 	conn.close();
 		}finally{
 			conn.close();
 		}
%>
  
 