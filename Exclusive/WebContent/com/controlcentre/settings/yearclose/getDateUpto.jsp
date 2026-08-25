<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>


<%
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();


 	Connection conn = null;
	String year=request.getParameter("year")==null?"0":request.getParameter("year").toString();
	
	
try{
	
	java.sql.Date sqlexdate=null;

	if(!(year.equalsIgnoreCase("undefined"))&&!(year.equalsIgnoreCase(""))&&!(year.equalsIgnoreCase("0")))
		{
		String years=year.replaceAll("-", ".");
		//System.out.println("----year--"+years);
			 sqlexdate=ClsCommon.changeStringtoSqlDate(years);
			
		}
		else{

		}
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select DATE_ADD('"+sqlexdate+"',INTERVAL 1 day) yclose";
	//System.out.println(strSql);
	ResultSet rs = stmt.executeQuery(strSql);
	java.sql.Date mclosedate=null;
	while(rs.next()){
		mclosedate=rs.getDate("yclose");
	}
	stmt.close();
	conn.close();

	response.getWriter().write(mclosedate+"");
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
	%>