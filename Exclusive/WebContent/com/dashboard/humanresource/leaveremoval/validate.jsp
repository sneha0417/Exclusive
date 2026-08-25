<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>   
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%@page import="java.util.Date"%>
<%@page import="com.ibm.icu.text.SimpleDateFormat" %>  
<%	
String todate=request.getParameter("todate");       
String empdocno=request.getParameter("empdocno");
String fromdate=request.getParameter("fromdate");
String branchid=request.getParameter("branchid").equalsIgnoreCase("a")?"1":request.getParameter("branchid");
Connection conn=null;           
try{
	ClsConnection ClsConnection =new ClsConnection();
	ClsCommon commonDAO=new ClsCommon();

	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();  
	  
	int aaa= 0;
	java.sql.Date sqlFromDate=null;
    java.sql.Date sqlToDate=null;
    
    fromdate.trim();
    if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))) {
    	sqlFromDate = commonDAO.changeStringtoSqlDate(fromdate);
    }
    
    todate.trim();
    if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))) {
    	sqlToDate = commonDAO.changeStringtoSqlDate(todate);
    }
    SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy"); 
    Date startDate = sqlFromDate;       
	Date enDate = sqlToDate;     
	Date endDate = new Date(enDate. getTime() + (1000 * 60 * 60 * 24));    
	Calendar start = Calendar.getInstance();
	start.setTime(startDate);
	Calendar end = Calendar.getInstance();         
	end.setTime(endDate);
	for (Date date = start.getTime(); start.before(end); start.add(Calendar.MONTH, 1), date = start.getTime()) {
	     String sql2="select payroll_confirmed from hr_timesheet where brhid='"+branchid+"' and empid='"+empdocno+"' and year=year('"+commonDAO.changeStringtoSqlDate(formatter.format(date))+"') and month=month('"+commonDAO.changeStringtoSqlDate(formatter.format(date))+"')";    
		  //System.out.println("sql2--->>>"+sql2); 
		ResultSet rs = stmt.executeQuery(sql2);	       
		while(rs.next()){
			if(rs.getInt("payroll_confirmed")>0){    
				aaa=1;     
			}     
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