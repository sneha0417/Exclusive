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
String list=request.getParameter("list")==null?"0":request.getParameter("list");
 
 
String pdocno=request.getParameter("psrno");
 
String std_cost=request.getParameter("std_cost")==null||request.getParameter("std_cost")==""?"0":request.getParameter("std_cost");
String fixing=request.getParameter("fixing")==null||request.getParameter("fixing")==""?"0":request.getParameter("fixing");

String labourcharge=request.getParameter("labourcharge")==null||request.getParameter("labourcharge")==""?"0":request.getParameter("labourcharge");

 
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
		
		for(int k=0;k<pmgntarray.size();k++)
		{
		
 
		 
	 
		String[] pmgntarr=((String) pmgntarray.get(k)).split("::"); 
 
		String scpid=""+(pmgntarr[0].trim().equalsIgnoreCase("undefined") || pmgntarr[0].trim().equalsIgnoreCase("NaN")|| pmgntarr[0].trim().equalsIgnoreCase("")|| pmgntarr[0].isEmpty()?0:pmgntarr[0].trim())+"";
		
		String  stdprice=""+(pmgntarr[1].trim().equalsIgnoreCase("undefined") || pmgntarr[1].trim().equalsIgnoreCase("NaN")|| pmgntarr[1].trim().equalsIgnoreCase("")|| pmgntarr[1].isEmpty()?0:pmgntarr[1].trim())+"";
		
		String  margin=""+(pmgntarr[2].trim().equalsIgnoreCase("undefined") || pmgntarr[2].trim().equalsIgnoreCase("NaN")|| pmgntarr[2].trim().equalsIgnoreCase("")|| pmgntarr[2].isEmpty()?0:pmgntarr[2].trim())+"";
		
		String  fprice=""+(pmgntarr[3].trim().equalsIgnoreCase("undefined") || pmgntarr[3].trim().equalsIgnoreCase("NaN")|| pmgntarr[3].trim().equalsIgnoreCase("")|| pmgntarr[3].isEmpty()?0:pmgntarr[3].trim())+"";
		
	 
		int getval=0;
		String sqlss="select * from my_scopepr where psrno="+pdocno+" and scpid="+scpid+"";
		
	//	System.out.println("sqlss="+sqlss);
		ResultSet rss=stmt.executeQuery(sqlss);
		while(rss.next())
		{
			getval=1;	
		}
		
		
		if(getval==1)
		{
			
			
			String updatesqls1=" update my_main set stdprice="+std_cost+",fixingprice="+fixing+",lbrchg="+labourcharge+"  where psrno="+pdocno+" ";
			
		//	System.out.println("updatesqls1====1====="+updatesqls1);
			
					stmt.executeUpdate(updatesqls1);
			
			
			String updatesqls=" update my_scopepr set  stdcost="+stdprice+", margin="+margin+", fprice="+fprice+" where psrno="+pdocno+" and scpid="+scpid+""; 
			
			//System.out.println("updatesqls="+updatesqls);
			
					stmt.executeUpdate(updatesqls);
		}
		else
		{
			
			
			String updatesqls1=" update my_main set stdprice="+std_cost+",fixingprice="+fixing+",lbrchg="+labourcharge+" where psrno="+pdocno+" ";
			
			System.out.println("updatesqls1===2===="+updatesqls1);
			
					stmt.executeUpdate(updatesqls1);
					 
	      sql="INSERT INTO my_scopepr(sr_no,psrno, scpid, stdcost, margin, fprice)VALUES"
			       + " ("+(k+1)+","
			       + " '"+pdocno+"',"
 			       + "'"+(pmgntarr[0].trim().equalsIgnoreCase("undefined") || pmgntarr[0].trim().equalsIgnoreCase("NaN")|| pmgntarr[0].trim().equalsIgnoreCase("")|| pmgntarr[0].isEmpty()?0:pmgntarr[0].trim())+"',"
			       + "'"+(pmgntarr[1].trim().equalsIgnoreCase("undefined") || pmgntarr[1].trim().equalsIgnoreCase("NaN")|| pmgntarr[1].trim().equalsIgnoreCase("")|| pmgntarr[1].isEmpty()?0:pmgntarr[1].trim())+"',"
			       + "'"+(pmgntarr[2].trim().equalsIgnoreCase("undefined") || pmgntarr[2].trim().equalsIgnoreCase("NaN")|| pmgntarr[2].trim().equalsIgnoreCase("")|| pmgntarr[2].isEmpty()?0:pmgntarr[2].trim())+"',"
			       + "'"+(pmgntarr[3].trim().equalsIgnoreCase("undefined") || pmgntarr[3].trim().equalsIgnoreCase("NaN")|| pmgntarr[3].trim().equalsIgnoreCase("")|| pmgntarr[3].isEmpty()?0:pmgntarr[3].trim())+"' )";
	    
	   //   System.out.println("sql="+sql);
	     int resultSet2 = stmt.executeUpdate(sql);
		     if(resultSet2<=0)
				{
					conn.close();
				 
					
				}
 
		}
		      
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



 