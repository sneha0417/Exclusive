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
		String sqltest=" union all select doc_type dtype,menu_name menu from my_menu where pmenu in (560000) and gate='E' and doc_type='PRIV' union all select doc_type dtype,menu_name menu from my_menu where pmenu in (204000) and gate='E' and doc_type='CPU' ";
		String strSql = "select doc_type dtype,menu_name menu from my_menu where pmenu in (201000 ,201100) and gate='E' "+sqltest;
		//System.out.println("dtypeload======"+strSql);    
		ResultSet rs = stmt.executeQuery(strSql);
		
		String dtype="";
		String menu="";
		while(rs.next()) {
			dtype+=rs.getString("dtype")+",";	
			menu+=rs.getString("menu")+",";
	  		} 
		
		menu=menu.substring(0, menu.length()>0?menu.length()-1:0);
		
		response.getWriter().write(dtype+"####"+menu);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>