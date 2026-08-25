<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();


	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		int AlreadyExists=0;
		String sql ="";
		
		String employeename=request.getParameter("employeename");
		String docno=request.getParameter("docno");
		String mode=request.getParameter("mode");
		
		String strSql = "select method from gl_config where field_nme='empAlreadyExists'";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String method="";
		while(rs.next()) {
			method=rs.getString("method");
		} 
	    
		if(method.equalsIgnoreCase("1")){
			
			if(mode.equalsIgnoreCase("A") && docno.equalsIgnoreCase("")){
				sql = "select * from hr_empm where status<>7 and dtype='EMP' and name=trim('"+employeename+"')";
			}else if(mode.equalsIgnoreCase("E") && !(docno.equalsIgnoreCase(""))){
				sql = "select * from hr_empm where status<>7 and dtype='EMP' and name=trim('"+employeename+"') and doc_no!="+docno+"";
			}
		
			ResultSet rs1 = stmt.executeQuery(sql);
			
			while(rs1.next()) {
				AlreadyExists=1;
			}
		} 
		
		response.getWriter().print(AlreadyExists);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  