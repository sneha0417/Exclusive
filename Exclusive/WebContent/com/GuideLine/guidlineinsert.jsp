<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	

	Connection conn = null;
	
	try{
		ClsConnection ClsConnection=new ClsConnection();

		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		int mandatory=0;
		String jobtype=request.getParameter("jobtype").trim();
		String jobstatus=request.getParameter("jobstatus").trim();
		int statusid=Integer.parseInt(request.getParameter("statusid").trim());
		String description=request.getParameter("description").trim();
		
		if(request.getParameter("mandatory").trim()==""){
		    mandatory=0;
		}else{
			mandatory=Integer.parseInt(request.getParameter("mandatory").trim());
		}
		
		int result=0;
		int typeId=0;
		
		if(jobtype.equalsIgnoreCase("IENQ")){
			typeId=1;
		}else if(jobtype.equalsIgnoreCase("IJCE")){
			typeId=2;
		}
		
		String strSql = "insert into is_pgline(status_id,type_id,description,mandatory,date,status) values("+statusid+","+typeId+",'"+description+"',"+mandatory+",now(),3)";
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
  
