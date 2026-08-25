


<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
int method=0;	ClsConnection ClsConnection=new ClsConnection();

Connection conn = null;

try
{

  conn = ClsConnection.getMyConnection();

Statement stmt=conn.createStatement();

String chk="select method  from gl_prdconfig where field_nme in ('foc','kg')";

//System.out.println("===chk==="+chk);

ResultSet rs=stmt.executeQuery(chk); 
int foc=0;
int kg=0;
int i=0;
while(rs.next())
{
	
	if(i==0)
		foc=rs.getInt("method");
		if(i==1)
			kg=rs.getInt("method");
		
		i++;
}

 //  System.out.println("--xxxxxxx---foc----"+foc+"---kg---"+kg);
	response.getWriter().print(foc+"##"+kg);
	stmt.close();
	conn.close();
}
catch(Exception e)
{
	conn.close();
}

  %>
  













					