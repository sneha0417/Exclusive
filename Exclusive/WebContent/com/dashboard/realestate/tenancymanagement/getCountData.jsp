<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String result="";
int errorstatus=0;
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();     
	conn=objconn.getMyConnection();                   
	Statement stmt=conn.createStatement();
	 
	String sql2="select count(ass_user) ass_user from an_taskcreation where ass_user='"+session.getAttribute("USERID")+"' and close_status=0";     
	// System.out.println("--------assgnuser----------"+sql2);
	ResultSet rs12=stmt.executeQuery(sql2);      
	while(rs12.next()){
    	result=rs12.getString("ass_user");     
    }
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(result);
%>