<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		int Availability=0;

		String bankacno=request.getParameter("bankacno");
		
		String sql = "select * from my_chqsetup where status=3 and bankdocno="+bankacno+"";
		ResultSet rs = stmt.executeQuery(sql);
			
		while(rs.next()) {
			Availability=1;
		} 
		
		response.getWriter().print(Availability);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  