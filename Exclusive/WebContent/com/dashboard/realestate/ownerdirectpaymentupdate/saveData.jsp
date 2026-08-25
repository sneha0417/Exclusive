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
String docnoarray=request.getParameter("gridarray")==null?"":request.getParameter("gridarray");     
    
ClsConnection objconn=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
Connection conn=null;  
int val=0;      
System.out.println("=============="+docnoarray);        
try{
	    conn=objconn.getMyConnection();
	    Statement stmt=conn.createStatement();  

	    String sql="update rl_tncpayment set dpupdate=1 where doc_no in("+docnoarray+")";             
		System.out.println(sql);           
		val=stmt.executeUpdate(sql);      
}    
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(val);   

%>