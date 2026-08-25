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

<%ClsConnection ClsConnection=new ClsConnection();
 	String list=request.getParameter("list")==null?"0":request.getParameter("list");
String doc=request.getParameter("doc");
 
//System.out.println("---list----"+list);	
 ArrayList<String> mainarray= new ArrayList<String>();
 
 String aa[]=list.split(",");
 
  
 for(int i=0;i<aa.length;i++){
	 //System.out.println("----aa-----"+aa[i]);
	 String bb[]=aa[i].split("::");
	
	 String temp="";
	 for(int j=0;j<bb.length;j++){
		// System.out.println("----bb[j]-----"+bb[j]);	
		
		 temp=temp+bb[j]+"::";
		 
	}
	 
	 
	 mainarray.add(temp);
	 
 } 
 
	 
		 Connection conn=null;
		    String sql="";
		    try
		    {
		   	
		    conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			int resultSet4 =0;
	for(int k=0;k<mainarray.size();k++)
	{
	
		
 
		
	
			 
			if(k==0)
			{
				 String sqls="update my_prfqm set pstatus=1 where doc_no='"+doc+"' ";
		   	    stmt.executeUpdate(sqls); 
		 	   
		  
		   	 
		   	
				
			}
			// unitprice total  discper discount discount
			// amount, total, disper, discount, nettotal 
			
			     String[] serarray=mainarray.get(k).split("::");  
			    
			     String sql2=" update  my_prfqd set  amount ='"+(serarray[0].trim().equalsIgnoreCase("undefined") || serarray[0].trim().equalsIgnoreCase("null") || serarray[0].trim().equalsIgnoreCase("NaN")||serarray[0].trim().equalsIgnoreCase("")|| serarray[0].isEmpty()?0:serarray[0].trim())+"' "
					       + " ,total='"+(serarray[1].trim().equalsIgnoreCase("undefined") || serarray[1].trim().equalsIgnoreCase("null") || serarray[1].trim().equalsIgnoreCase("NaN")||serarray[1].trim().equalsIgnoreCase("")|| serarray[1].isEmpty()?0:serarray[1].trim())+"' "
					       + " ,disper='"+(serarray[2].trim().equalsIgnoreCase("undefined") || serarray[2].trim().equalsIgnoreCase("null")|| serarray[2].trim().equalsIgnoreCase("NaN")||serarray[2].trim().equalsIgnoreCase("")|| serarray[2].isEmpty()?0:serarray[2].trim())+"' "
					       + " ,discount='"+(serarray[3].trim().equalsIgnoreCase("undefined") || serarray[3].trim().equalsIgnoreCase("null")|| serarray[3].trim().equalsIgnoreCase("NaN")||serarray[3].trim().equalsIgnoreCase("")|| serarray[3].isEmpty()?0:serarray[3].trim())+"' "
					       + " ,nettotal='"+(serarray[4].trim().equalsIgnoreCase("undefined") || serarray[4].trim().equalsIgnoreCase("null")|| serarray[4].trim().equalsIgnoreCase("NaN")||serarray[4].trim().equalsIgnoreCase("")|| serarray[4].isEmpty()?0:serarray[4].trim())+"' where "
					       + " rowno= '"+(serarray[5].trim().equalsIgnoreCase("undefined") || serarray[5].trim().equalsIgnoreCase("null")|| serarray[5].trim().equalsIgnoreCase("NaN")||serarray[5].trim().equalsIgnoreCase("")|| serarray[5].isEmpty()?0:serarray[5].trim())+"' ";
	 
			     
			     System.out.println("----sql2--"+sql2);
			       resultSet4 = stmt.executeUpdate(sql2);
			     if(resultSet4<=0)
                 {
			    	 
                      
                    }
			 
			  
				 //stmt.executeUpdate(sql);
			 
				 
				
				 
				
			
			
		    }
	
	System.out.println("----resultSet4----"+resultSet4);
	
	response.getWriter().print(resultSet4);
	 stmt.close();
	 
		conn.close();
		    
		    }	
		    
		    catch(Exception e)
		    {
		    	response.getWriter().print(0);
		    	e.printStackTrace();
		    	conn.close();
		    } 
		
		
		
		
		
		
		
		
		
 
	 	
%>




