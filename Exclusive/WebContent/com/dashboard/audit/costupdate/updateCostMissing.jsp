<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
System.out.println("Inside AJAX");
Connection conn=null;
ClsConnection objconn=new ClsConnection();
String trno=request.getParameter("trno")==null?"0":request.getParameter("trno");
String costtype=request.getParameter("costtype")==null?"0":request.getParameter("costtype");
String costcode=request.getParameter("costcode")==null?"0":request.getParameter("costcode");
String status="0";
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	if(!trno.equalsIgnoreCase("0")){
		conn.setAutoCommit(false);
		String strsql="update my_jvtran set costcode="+costcode+",costtype="+costtype+" where tr_no in ("+trno+")";
		//System.out.println(strsql);
		int updateval=stmt.executeUpdate(strsql);
		//System.out.println("Updateval:"+updateval);
		if(updateval>0){
			conn.commit();
			status="1";
		}
		else{
			status="0";
		}
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(status);
%>