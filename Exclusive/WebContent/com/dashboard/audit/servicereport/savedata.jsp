<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%	
String srvdetmtrno=request.getParameter("srvdetmtrno");
System.out.println("srvdetmtrno ="+srvdetmtrno);
Connection conn=null;
try{
	ClsConnection ClsConnection =new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String[] tranarray = srvdetmtrno.split(",");
	
	/* String sql="update cm_srvdetm m set m.audit=1 where tr_no="+srvdetmtrno;	
	int aaa= stmt.executeUpdate(sql); */
	
	int aaa= 0;
	for (int i = 0; i < tranarray.length; i++) {
		String tranno=tranarray[i];	
		
		if(!(tranno.equalsIgnoreCase(""))){
			String sql="update cm_srvdetm m set m.audit=1 where tr_no="+tranno+"";
			aaa= stmt.executeUpdate(sql);
		}
	}
	
	response.getWriter().print(aaa);
	
	stmt.close();
	conn.close();
}
catch(Exception e){
	response.getWriter().print(0);
	conn.close();
	e.printStackTrace();
}
%>
