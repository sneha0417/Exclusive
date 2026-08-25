<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String result="";
String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();    
int errorstatus=0;
Connection conn=null;
java.sql.Date sqltodate=null;
java.sql.Date sqlfromdate=null;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon cmn=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
		 sqlfromdate=cmn.changeStringtoSqlDate(fromdate);
		}
	 if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
		 sqltodate=cmn.changeStringtoSqlDate(todate);      
		}          
	 String strcountdata="select count(*) count from (select * from re_mreq r where status=3 and confirm=0 and r.edate between '"+sqlfromdate+"' and '"+sqltodate+"' and statusid=4 and DATEDIFF(now(),owapvldate)>3 group by voc_no)a";
	//System.out.println("getcount=="+strcountdata);
	ResultSet rs=stmt.executeQuery(strcountdata);   
	while(rs.next()){       
		result=rs.getString("count");         
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(result);      
%>