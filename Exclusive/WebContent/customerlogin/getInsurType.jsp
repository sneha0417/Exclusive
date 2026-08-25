<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
ClsConnection objconn=new ClsConnection();
Connection conn=null;
String data="";
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select doc_no,name from in_insurtype where status=3";
	ResultSet rs=stmt.executeQuery(strsql);
	int i=0;
	while(rs.next()){
		if(i==0){
			data+=rs.getString("doc_no")+"::"+rs.getString("name");	
		}
		else{
			data+=","+rs.getString("doc_no")+"::"+rs.getString("name");
		}
		i++;
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(data);
%>