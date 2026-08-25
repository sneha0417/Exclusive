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
		
		String strSql = "select t.doc_type dtype,t.menu_name menu from my_menu t left join my_powr p on p.mno=t.mno left join my_user u on u.role_id=p.roleid where t.pmenu in (201300) "
				+ "and t.GATE!='N' and (p.add1<>0 or p.edit<>0 or p.del<>0 or p.print<>0 or p.attach<>0 or p.excel<>0) and u.doc_no='"+session.getAttribute("USERID").toString()+"' order by t.mno";
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