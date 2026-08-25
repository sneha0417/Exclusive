 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
 	Connection conn = null;
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn=ClsConnection.getMyConnection();
Statement stmt = conn.createStatement ();
int method=0;

	String chk="select method  from gl_prdconfig where field_nme='pricemgt'";
	ResultSet rs=stmt.executeQuery(chk); 
	if(rs.next())
		{
			method=rs.getInt("method");
	    }
		
 
	stmt.close();
	conn.close();
	response.getWriter().print(method);
	
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
%>
  
 