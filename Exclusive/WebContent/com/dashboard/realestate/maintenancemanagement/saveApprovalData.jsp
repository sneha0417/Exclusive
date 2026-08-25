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
String vocno=request.getParameter("vocno")==null || request.getParameter("vocno")==""?"0":request.getParameter("vocno");
String brhid=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid");     
    
ClsConnection objconn=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
Connection conn=null;  
String msg="";  
int val=0;      
//System.out.println("=============="+docnoarray);        
try{
	    conn=objconn.getMyConnection();
	    Statement stmt=conn.createStatement();  

	    String sql="update re_mreq set statusid=4,mstatus=2,owapvldate=now() where doc_no in("+docnoarray+")";                           
		System.out.println(sql);           
		val=stmt.executeUpdate(sql);   
		if(val>0){
			String sqllog="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,description) values("+vocno+",'"+brhid+"','MMT',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','Owner Approved')";            
			System.out.println(sqllog);                       
			int val1=stmt.executeUpdate(sqllog); 
		}
}    
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(val);   
%>