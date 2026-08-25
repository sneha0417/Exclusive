<%--    <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
 
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
ClsCommon ClsCommon=new ClsCommon();
ClsConnection ClsConnection=new ClsConnection();
String clearprice=request.getParameter("clearprice")==null?"0":request.getParameter("clearprice");
String fromdate=request.getParameter("fromdate1")==null?"0":request.getParameter("fromdate1");
String todate=request.getParameter("todate1")==null?"0":request.getParameter("todate1");
 
 java.sql.Date sqlfromdate = null;
	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	{
		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
		
	}
	else{

	}

 java.sql.Date sqltodate = null;
	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	{
		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
		
	}
	else{ 

	}
String pdocno=request.getParameter("psrno");
 
 
 
	  Connection conn=null;
	    String sql="";
	    try
	    {
	   	
	    conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String updatesqls1=" update my_main set clrprice="+clearprice+",clrfromdate='"+sqlfromdate+"',clrtodate='"+sqltodate+"' where psrno="+pdocno+" ";
		
		//System.out.println("updatesqls1="+updatesqls1);
		
				stmt.executeUpdate(updatesqls1);
		 
		      
		 
 stmt.close();
		 
	conn.close();
	 response.getWriter().print(1);
    	
    }
    catch(Exception e)
    {
    	e.printStackTrace();
    	
    	
    	conn.close();
    	 response.getWriter().print(2);
    }
	 	
	 	
	 	
%> --%>
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
 
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
ClsCommon ClsCommon=new ClsCommon();
ClsConnection ClsConnection=new ClsConnection();
String cat=request.getParameter("cat")==null?"0":request.getParameter("cat");
String fromdate=request.getParameter("fromdate1")==null?"0":request.getParameter("fromdate1");
String todate=request.getParameter("todate1")==null?"0":request.getParameter("todate1");
String list=request.getParameter("list")==null?"0":request.getParameter("list");
 
 java.sql.Date sqlfromdate = null;
	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	{
		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
		
	}
	else{

	}

 java.sql.Date sqltodate = null;
	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	{
		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
		
	}
	else{ 

	}
	
	ArrayList<String> psrnoarray= new ArrayList<String>();
	String aa[]=list.split(",");
	 
		 
	for(int i=0;i<aa.length;i++){
		// System.out.println("----------"+aa[i]);
		 String bb[]=aa[i].split("::");
		  
		 String temp="";
		 for(int j=0;j<bb.length;j++){ 
			 
			//  System.out.println("----------"+bb[j]);
			 temp=temp+bb[j]+"::";
			 
		}
		 psrnoarray.add(temp);
		 
	} 
	 
	
 

 
	Connection conn=null;
    String sql="";
    try
    {
   	
    conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	
	for(int k=0;k<psrnoarray.size();k++)
	{
	

	 
 
	String[] pmgntarr=((String) psrnoarray.get(k)).split("::"); 

	String psrid=""+(pmgntarr[0].trim().equalsIgnoreCase("undefined") || pmgntarr[0].trim().equalsIgnoreCase("NaN")|| pmgntarr[0].trim().equalsIgnoreCase("")|| pmgntarr[0].isEmpty()?0:pmgntarr[0].trim())+"";
	
	String  clearprice=""+(pmgntarr[1].trim().equalsIgnoreCase("undefined") || pmgntarr[1].trim().equalsIgnoreCase("NaN")|| pmgntarr[1].trim().equalsIgnoreCase("")|| pmgntarr[1].isEmpty()?0:pmgntarr[1].trim())+"";
	
				 
		
		
	String updatesqls1=" update my_main set clrprice="+clearprice+",clrfromdate='"+sqlfromdate+"',clrtodate='"+sqltodate+"' where psrno="+psrid+" ";
	
	//System.out.println("updatesqls1="+updatesqls1);
	
	stmt.executeUpdate(updatesqls1);
	 
	}
			 
		 
		 
		      
		 
 stmt.close();
		 
	conn.close();
	 response.getWriter().print(1);
    	
    }
    catch(Exception e)
    {
    	e.printStackTrace();
    	
    	
    	conn.close();
    	 response.getWriter().print(2);
    }
	 	
	 	
	 	
%>




 