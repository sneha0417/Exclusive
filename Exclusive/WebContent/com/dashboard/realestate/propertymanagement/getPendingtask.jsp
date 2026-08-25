<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%

String userid=request.getParameter("userid");

System.out.println(userid);

ClsConnection  ClsConnection=new ClsConnection();
Connection conn=null;
int i=0;
String value="";

try
{
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	
	String str="select doc_no,task,strt_date,strt_time,description from an_taskcreation t left join an_taskcreationdets a on t.doc_no=a.rdocno where t.clstatus=0 and a.userid='"+userid+"'";
	
	System.out.println("an_assign--->>>"+str);
	
	ResultSet rs=stmt.executeQuery(str);
	
	while(rs.next())
	{
		if(i==0){
			value+=rs.getString("doc_no")+"::"+rs.getString("task")+"::"+rs.getString("strt_date")+"::"+rs.getString("strt_time")+"::"+rs.getString("description");	
		}
		else{
			value+=","+rs.getString("doc_no")+"::"+rs.getString("task")+"::"+rs.getString("strt_date")+"::"+rs.getString("strt_time")+"::"+rs.getString("description");
		}
		i++;
		
	}
	System.out.println("create:"+value);
   
}
catch(Exception e)
{
	e.printStackTrace();

}
finally
{
	conn.close();
}

response.getWriter().write(value);
%>