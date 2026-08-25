<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
ClsConnection ClsConnection=new ClsConnection();

	String saltype=request.getParameter("saltype");
 	Connection conn = null;
	
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
				
		String strSql = "select coalesce(max(CAST(sal_code AS UNSIGNED)),1)+1 code from my_salesman where sal_type='"+saltype+"';";
		ResultSet rs = stmt.executeQuery(strSql);
	
		Integer code=1;
		while(rs.next()) {
			code=rs.getInt("code");		
	  	} 
		
		response.getWriter().write(code.toString());
		
		stmt.close();
	 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();	
	 	conn.close();
   }finally{
	   conn.close();
   }
  %>
  
