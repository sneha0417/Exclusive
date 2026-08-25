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

       
System.out.println("-----list-------"+list);
     
    String branch=request.getParameter("branch")==null?"0":request.getParameter("branch");
    String location=request.getParameter("location")==null?"0":request.getParameter("location");
    String mode=request.getParameter("mode")==null?"0":request.getParameter("mode");
     String aa[]=list.split(",");

 	ArrayList<String> mainarray= new ArrayList<String>();
 	 
 for(int i=0;i<aa.length;i++){
 	 
 	 String bb[]=aa[i].split("::");
 
 	 String temp="";
 	 for(int j=0;j<bb.length;j++){ 
 		 temp=temp+bb[j]+"::";
 		 
 	}
 	System.out.println("-----temp-------"+temp);
 	 
 	 mainarray.add(temp);
 	 
 } 
    Connection conn=null;
    String sql="";
    
    String temp1="";
    String temp2="";
    double acqty=0;
    try
    {
   	
    conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	
	int calcu=0;
	
	for(int k=0;k<mainarray.size();k++)
	{
	
	      
	  
	  String[] serarray=mainarray.get(k).split("::");  
		System.out.println("----serarray[0]--------"+serarray[0]);
	     
	     String  prdids=""+(serarray[0].trim().equalsIgnoreCase("undefined") || serarray[0].trim().equalsIgnoreCase("NaN")|| serarray[0].trim().equalsIgnoreCase("")|| serarray[0].isEmpty()?0:serarray[0].trim())+"";
	        
	//  String prdids=""+serarray[0].equalsIgnoreCase("undefined") || serarray[0].equalsIgnoreCase("") || serarray[0].trim().equalsIgnoreCase("NaN")|| serarray[0].isEmpty()+"";						 
	  String specnos=""+(serarray[1].equalsIgnoreCase("undefined") || serarray[1].equalsIgnoreCase("") || serarray[1].trim().equalsIgnoreCase("NaN")|| serarray[1].isEmpty()?0:serarray[1].trim())+"";
	  String qtys=""+(serarray[2].equalsIgnoreCase("undefined") || serarray[2].equalsIgnoreCase("") || serarray[2].trim().equalsIgnoreCase("NaN")|| serarray[2].isEmpty()?0:serarray[2].trim())+"";
	  String oldqty=""+(serarray[3].equalsIgnoreCase("undefined") || serarray[3].equalsIgnoreCase("") || serarray[3].trim().equalsIgnoreCase("NaN")|| serarray[3].isEmpty()?0:serarray[3].trim())+"";
	   
		System.out.println("----prdids--------"+prdids);	
		System.out.println("----specnos--------"+specnos);
		System.out.println("----qtys--------"+qtys);
	 int prdid=Integer.parseInt(prdids);
	 int specno=Integer.parseInt(specnos);
	 double qty=Double.parseDouble(qtys);
	 
	 
	 if(mode.equalsIgnoreCase("A"))
	 {
		 sql="select (sum(op_qty)-sum(out_qty+rsv_qty+del_qty)) acqty from my_prddin where brhid='"+branch+"' and locid='"+location+"' and specno='"+specno+"' and prdid='"+prdid+"'  "; 
	 }
	 else
	 {
		 sql="select (sum(op_qty)-sum(out_qty+rsv_qty+del_qty))+"+oldqty+" acqty from my_prddin where brhid='"+branch+"' and locid='"+location+"' and specno='"+specno+"' and prdid='"+prdid+"'  ";
	 }
	          
	        
	           System.out.println("----sql--------"+sql);  
	           
	           ResultSet rss=  stmt.executeQuery(sql); 
	        	if(rss.next())
	        	{
	        		acqty=rss.getDouble("acqty");	
	        		calcu=calcu+1; // array size chk 
	        	}
	            System.out.println("----acqty--------"+acqty);  
	        	if(qty>acqty)
	        	{
	        		temp1=temp1+prdid+",";
	        		temp2=temp2+acqty+",";		
	        		
	        	}
	        	 
	        	
	        		 
		
      }
	 stmt.close();
	 response.getWriter().write(temp1+"###"+temp2);
		conn.close();
    	
    }
    catch(Exception e)
    {
    	e.printStackTrace();
    	conn.close();
    }
	 	
	 	
	 	
%>
