<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%    
ClsConnection objconn=new ClsConnection();          
Connection conn=null;         
int value=0,method=0;       
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strgetmsg="select round(value,0) value,method from gl_config where field_nme='ExclusiveVendor'";
	System.out.println("strSql===="+strgetmsg);               
	ResultSet rs=stmt.executeQuery(strgetmsg);       
	while(rs.next()){
		value=rs.getInt("value");
		method=rs.getInt("method");     
	}
	if(method==0){
		value=0;   
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(value);      
%>