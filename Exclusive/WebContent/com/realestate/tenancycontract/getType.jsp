<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
	Connection conn = null;

	try{
		
		ClsConnection connDAO = new ClsConnection();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		String sql = "",result="",sqltst="";
		int AlreadyExists=0;

		String chequeno=request.getParameter("chequeno");
		String bankacno=request.getParameter("bankacno");
		String docno=request.getParameter("docno");
		String mode=request.getParameter("mode");
	    
		
	        sql = "select method from gl_config where field_nme like'tenancycontracttype'";
		
	    ResultSet rs = stmt.executeQuery(sql);
		
		while(rs.next()) {
			result=rs.getString("method");
		} 
		
		if(result.equalsIgnoreCase("1")){
			sqltst="select 1 docno,'Residence' type union all select 2 docno,'Commercial' type union all select 3 docno,'Sub Lease' type ";
		}
		else{
			sqltst="select 1 docno,'Residence' type union all select 2 docno,'Commercial' type";
		}
		 ResultSet rsnw = stmt.executeQuery(sqltst);
		String type="",typeId="";
		while(rsnw.next()) {
			type+=rsnw.getString("type")+":";
			typeId+=rsnw.getString("docno")+":";
				} 
		
		response.getWriter().print(type+"####"+typeId);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  