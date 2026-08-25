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
		int AlreadyExists=1,val=0;
		String sql ="";
		ResultSet rs =null;
		
	
		String docno= request.getParameter("docno")==null ||  request.getParameter("docno")==""?"0":request.getParameter("docno");
		String mode=request.getParameter("mode"); 
			
		if(mode.equalsIgnoreCase("view")  && !(docno.equalsIgnoreCase(""))){
		
			sql = "select posted from my_mcpbm where doc_no="+docno+"";
			rs= stmt.executeQuery(sql);
		}
		while(rs.next()) {
			AlreadyExists=rs.getInt("posted");
		} 
		if(AlreadyExists==0){
				val=1;	
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
  