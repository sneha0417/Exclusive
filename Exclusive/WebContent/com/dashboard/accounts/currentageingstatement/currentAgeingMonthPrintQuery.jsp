<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%
	System.out.println("welcome");
	ClsConnection  ClsConnection=new ClsConnection();
	ClsEncrypt objencrypt=new ClsEncrypt();
	
	Connection conn=null;
	
	String value="";
	
	String printpath="";
	
	try
	{
		conn=ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String str="select round(coalesce(value,0),0) value,printpath from gl_bibd where dtype='BACA';";
		System.out.println("strrrr....."+str);
		ResultSet rs=stmt.executeQuery(str);
		while(rs.next())
		{
			 value=rs.getString("value");
			 
			 printpath=rs.getString("printpath");
					
		
		}
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	finally
	{
		conn.close();
	}


	response.getWriter().write(value+"::"+printpath);
%>