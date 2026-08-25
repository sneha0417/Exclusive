<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
	String name=request.getParameter("name");
	Connection conn=null ;
	try{
		
	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select company,branchname from my_comp c inner join my_brch b on(c.doc_no=b.cmpid) order by company";
	ResultSet rs = stmt.executeQuery(strSql);
	String comp="";
	String brch= "";
	while(rs.next()) {
		if(comp.contains(rs.getString("company"))){
			brch+=rs.getString("branchname")+",";
		}
		else{
		comp+=rs.getString("company")+",";
		brch+=rs.getString("branchname")+",";
		}
  		}
	brch=brch.substring(0, brch.length()-1);
	comp=comp.substring(0, comp.length()-1);
	response.getWriter().write(comp+"####"+brch);
/* 	session.setAttribute("TreeList", tree); */
	stmt.close();
	conn.close();
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}  
  %>
  
