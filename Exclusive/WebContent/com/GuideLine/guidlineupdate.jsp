<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		int statusid=Integer.parseInt(request.getParameter("statusid").trim());
		int srno=Integer.parseInt(request.getParameter("srno").trim());
		String description=request.getParameter("description").trim();
		int mandatory=0;
		
		if(request.getParameter("mandatory").trim()==""){
		 mandatory=0;
		}else{
			mandatory=Integer.parseInt(request.getParameter("mandatory").trim());
		}
		int result=0;
		
		String strSql = "update is_pgline set description="+description+",mandatory="+mandatory+" where status_id="+statusid+" and srno="+srno+"";
		int rs = stmt.executeUpdate(strSql);
		
		response.getWriter().print(rs);
	
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}  
  %>
  
