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
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon= new ClsCommon();
String list=request.getParameter("list")==null?"0":request.getParameter("list");
 
 
String cldocno=request.getParameter("clientid")==null?"0":request.getParameter("clientid");


String fromdate=request.getParameter("fromdate1")==null?"0":request.getParameter("fromdate1");
String todate=request.getParameter("todate1")==null?"0":request.getParameter("todate1");
 
ArrayList<String> pmgntarray= new ArrayList<String>();
String aa[]=list.split(",");
 
	 
for(int i=0;i<aa.length;i++){
	// System.out.println("----------"+aa[i]);
	 String bb[]=aa[i].split("::");
	  
	 String temp="";
	 for(int j=0;j<bb.length;j++){ 
		 
		//  System.out.println("----------"+bb[j]);
		 temp=temp+bb[j]+"::";
		 
	}
	 pmgntarray.add(temp);
	 
} 
 
	  Connection conn=null;
	    String sql="";
	    try
	    {
	   	
	    conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		
		  java.sql.Date sqlfromdate =ClsCommon.changeStringtoSqlDate(fromdate);
		  
		  java.sql.Date sqltodate =ClsCommon.changeStringtoSqlDate(todate);
	     		
		
		for(int k=0;k<pmgntarray.size();k++)
		{
		
 
		 
	 
		String[] pmgntarr=((String) pmgntarray.get(k)).split("::"); 
 
		String psrno=""+(pmgntarr[0].trim().equalsIgnoreCase("undefined") || pmgntarr[0].trim().equalsIgnoreCase("NaN")|| pmgntarr[0].trim().equalsIgnoreCase("")|| pmgntarr[0].isEmpty()?0:pmgntarr[0].trim())+"";
		
		String  price=""+(pmgntarr[1].trim().equalsIgnoreCase("undefined") || pmgntarr[1].trim().equalsIgnoreCase("NaN")|| pmgntarr[1].trim().equalsIgnoreCase("")|| pmgntarr[1].isEmpty()?0:pmgntarr[1].trim())+"";
/* 		int getval=0;
		String sqlss="select * from my_clientoffer where psrno="+pdocno+" and cldocno="+cldocno+" and frmdate='"+sqlfromdate+"' and todate='"+sqltodate+"' ";
		
	//	System.out.println("sqlss="+sqlss);
		ResultSet rss=stmt.executeQuery(sqlss);
		while(rss.next())
		{
			getval=1;	
		}
		
		if(getval==1)
		{
			
	 
			
			String updatesqls=" update my_clientoffer set price="+price+" where psrno="+pdocno+" and cldocno="+cldocno+" and frmdate='"+sqlfromdate+"' and todate='"+sqltodate+"' ";
			
			//System.out.println("updatesqls="+updatesqls);
			
					stmt.executeUpdate(updatesqls);
		}
		else
		{
			
		 
	  */
	  String sqlss="delete from my_clientoffer where psrno="+psrno+" and cldocno="+cldocno+" ";
	  System.out.println("sqlss="+sqlss);
	  stmt.executeUpdate(sqlss);
	  
	      sql="INSERT INTO my_clientoffer(sr_no,psrno,ofrprice,cldocno,frmdate,todate)VALUES"
			       + " ("+(k+1)+","
			       + "'"+(pmgntarr[0].trim().equalsIgnoreCase("undefined") || pmgntarr[0].trim().equalsIgnoreCase("NaN")|| pmgntarr[0].trim().equalsIgnoreCase("")|| pmgntarr[0].isEmpty()?0:pmgntarr[0].trim())+"',"
			       + "'"+(pmgntarr[1].trim().equalsIgnoreCase("undefined") || pmgntarr[1].trim().equalsIgnoreCase("NaN")|| pmgntarr[1].trim().equalsIgnoreCase("")|| pmgntarr[1].isEmpty()?0:pmgntarr[1].trim())+"'," 
			       + "'"+cldocno+"','"+sqlfromdate+"','"+sqltodate+"')";
	    
	    System.out.println("sql="+sql);
	     int resultSet2 = stmt.executeUpdate(sql);
		     if(resultSet2<=0)
				{
					conn.close();
				 
					
				}
 
		     /*}*/
		      
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



 