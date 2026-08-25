<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
 	Connection conn = ClsConnection.getMyConnection();
try{
	
Statement stmt = conn.createStatement ();
	String strSql = "select gname,doc_no from gl_vehgroup where status <> 7 order by gname;";
	ResultSet rs = stmt.executeQuery(strSql);
	//System.out.println(strSql);
	String group="";
	String groupid="";

	while(rs.next()) {
		group+=rs.getString("gname")+",";		
		groupid+=rs.getString("doc_no")+",";

  		} 
	if(group.length()>0){
		group=group.substring(0, group.length()-1);	
	}
	
	response.getWriter().write(group+"####"+groupid);
	stmt.close();
	conn.close();
 
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>
  
