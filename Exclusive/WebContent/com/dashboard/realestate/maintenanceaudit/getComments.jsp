<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String vocno=request.getParameter("vocno")==null?"":request.getParameter("vocno");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
ClsConnection objconn=new ClsConnection();       
Connection conn=null;         
String msg="";
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();          
	String strgetmsg="select usr.user_name,job.msg,date_format(job.msgdate,'%d.%m.%Y %H:%i') msgdate from rl_comments job left join my_user usr on job.userid=usr.doc_no where job.status=3 and job.dtype='MAD' and job.voc_no='"+vocno+"' and job.brhid='"+brhid+"'";
	//System.out.println("strSql===="+strgetmsg);                       
	ResultSet rs=stmt.executeQuery(strgetmsg);       
	int i=0;
	while(rs.next()){
		if(i==0){
			msg=rs.getString("msg")+"::"+rs.getString("msgdate")+"::"+rs.getString("user_name");
		}
		else{
			msg+=","+rs.getString("msg")+"::"+rs.getString("msgdate")+"::"+rs.getString("user_name");
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
response.getWriter().write(msg);
%>