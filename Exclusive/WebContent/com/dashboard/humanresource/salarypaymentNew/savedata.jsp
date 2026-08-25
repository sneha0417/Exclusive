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
String selectedempdocno=request.getParameter("txtselectedempdocno");    
String selectednetsal=request.getParameter("txtselectednetsal");
String selectedpaid=request.getParameter("txtselectedpaid");
String selectedbalnce=request.getParameter("txtselectedbalnce");
String selectedtbpaid=request.getParameter("txtselectedtbpaid");
String year=request.getParameter("year");
String month=request.getParameter("month");        
System.out.println("selectedempdocno ="+selectedempdocno+"selectednetsal ="+selectednetsal+"selectedpaid ="+selectedpaid);
Connection conn=null;  
try{
	ClsConnection ClsConnection =new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String[] tranarray1 = selectedempdocno.split(",");
	String[] tranarray2 = selectednetsal.split(",");
	String[] tranarray3 = selectedpaid.split(",");
	String[] tranarray4 = selectedbalnce.split(",");
	String[] tranarray5 = selectedtbpaid.split(",");   
	int aaa= 0;
	for (int i = 0; i < tranarray1.length; i++) {  
	String empdocno=tranarray1[i];	
	String netsal=tranarray2[i];	
	String paid=tranarray3[i];	
	String balnce=tranarray4[i];	
	String tbpaid=tranarray5[i];    	        

	if(!(empdocno.equalsIgnoreCase(""))){
		
	String sql2="delete from hi_payrolldet where empid='"+empdocno+"' and year='"+year+"' and month='"+month+"'";    
	stmt.executeUpdate(sql2);	
		
	String sql="insert into hi_payrolldet(empid, year, month, netsalary, paid, balance, tbpaid) values('"+empdocno+"','"+year+"','"+month+"','"+netsal+"','"+paid+"','"+balnce+"','"+tbpaid+"')";  
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