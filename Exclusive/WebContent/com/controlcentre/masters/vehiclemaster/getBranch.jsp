<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
 	Connection conn = null;
try{
	conn=ClsConnection.getMyConnection();
Statement stmt = conn.createStatement ();
	String strSql = "select branchname,doc_no from my_brch where cmpid='"+session.getAttribute("COMPANYID")+"'";
	ResultSet rs = stmt.executeQuery(strSql);
	/* System.out.println(strSql); */
	String brnch="",brnchId="";
	while(rs.next()) {
				brnch+=rs.getString("branchname")+",";
				brnchId+=rs.getString("doc_no")+",";
  		} 
	if(brnch.length()>0){
		brnch=brnch.substring(0, brnch.length()-1);	
	}
	
	/* response.getWriter().write(brch.toString()); */ 
	stmt.close();
	conn.close();
	response.getWriter().write(brnchId+"####"+brnch);
	

}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
	%>
  
