<%@page import="java.util.ArrayList"%> 
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*" %>
<%@page import="com.connection.*" %>
<%
ClsConnection ClsConnection=new ClsConnection();
 Connection conn = null;
 try{
	 
	 conn=ClsConnection.getMyConnection();
	 Statement stmt=conn.createStatement();
	 String strSql="select dtype,menu_name from my_apprmaster a left join my_menu m on a.dtype=m.doc_type";
	 //System.out.println("----sql-----" +strSql);
 
 
	 ResultSet rs = stmt.executeQuery(strSql);
		
		String dtype="",menu_name="";
		while(rs.next()) {
					menu_name+=rs.getString("menu_name")+",";
					dtype+=rs.getString("dtype")+",";
				} 
		
		String mnu_nme[]=menu_name.split(",");
		String dtpe[]=dtype.split(",");
		
		menu_name=menu_name.substring(0, menu_name.length()-1);
		dtype=dtype.substring(0, dtype.length()-1);
		//System.out.println("----sql-----"+dtype+"####"+menu_name );	
		response.getWriter().write(dtype+"####"+menu_name);
		// session.setAttribute("DTYPE", dtpe[0]);
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
%>

 
