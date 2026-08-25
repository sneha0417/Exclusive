<%@page import="com.common.ClsCommon"%>
<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*"%>

<%
Connection conn=null;
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
try{
	conn=objconn.getMyConnection();
	
	Statement stmt=conn.createStatement();
	String strsql="";

	String str="select name,designation,gender,availability from gw_empavailability where status=3";
	ResultSet rs=stmt.executeQuery(str);
	int i=0;
	String temp="";
	
	while(rs.next()){
		
		if(i==0){
			temp+=rs.getString("name")+"::"+rs.getString("designation")+"::"+rs.getString("gender")+"::"+rs.getString("availability");
		}
		else{
			temp+=","+rs.getString("name")+"::"+rs.getString("designation")+"::"+rs.getString("gender")+"::"+rs.getString("availability");
		}
		i++;
	}
	stmt.close();
	response.getWriter().write(temp);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
%>
