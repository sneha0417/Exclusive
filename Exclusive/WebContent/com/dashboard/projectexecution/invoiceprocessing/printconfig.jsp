<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% 
		 
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();


	try{
		
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
	int conval=0;
	String conf="0";
		String consql="select method from gl_config where field_nme='invoiceprint'";
		ResultSet rsconfg = stmt.executeQuery(consql);

		while (rsconfg.next()) {
			conval=rsconfg.getInt("method");
			System.out.println("conval=="+conval);
		}
		if(conval>0){
			
			conf="1";	
		}
	
		
		response.getWriter().write(conf);

		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  