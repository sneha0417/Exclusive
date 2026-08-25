<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
	Connection conn=null;
try{
	
 	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	//System.out.println("conn:"+conn);
	String strSql = "select doc_no,company from my_comp where status<>7;";
	ResultSet rs = stmt.executeQuery(strSql);
	//System.out.println(strSql);
	String comp="";
	String compid="";
	while(rs.next()) {
		comp+=rs.getString("company")+",";		
		compid+=rs.getString("doc_no")+",";
		System.out.println(comp);
		
				
  		}
	if(comp.length()>0){
	comp=comp.substring(0, comp.length()-1);
	}
	stmt.close();
	conn.close();

	response.getWriter().write(comp+"***"+compid);
	System.out.println("COMPID==="+compid);
	/* response.getWriter().write(auth.toArray()); */
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
	%>