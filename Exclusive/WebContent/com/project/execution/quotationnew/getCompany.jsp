<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
	Connection conn = null;
	
	try{
		ClsConnection connDAO = new ClsConnection();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		
		/* String strSql = "select company from my_comp";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String company="";
		while(rs.next()) {
			company=rs.getString("company");
				} 
 */
 

	
	String strSql = "select method from gl_config where field_nme='fire7print'"; //method=1:print fpr fire7 company,otherwise load normal print
	ResultSet rs = stmt.executeQuery(strSql);
	
	String company="";
	while(rs.next()) {
		company=rs.getString("method");
			} 

		response.getWriter().write(company);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  