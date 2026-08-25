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
	String venddocno=request.getParameter("venddocno")==null?"0":request.getParameter("venddocno");
	ArrayList<String> proday= new ArrayList<String>();
	String aa[]=list.split(",");
		for(int i=0;i<aa.length;i++){
			 String bb[]=aa[i].split("::");
			 String temp="";
			 for(int j=0;j<bb.length;j++){ 
				 temp=temp+bb[j]+"::";
			}
			 proday.add(temp);
		  } 
	  Connection conn=null;
	    String sql="";
	    try
	    {
	    conn = ClsConnection.getMyConnection();
	    conn.setAutoCommit(false);
		Statement stmt = conn.createStatement();
	 
		Statement stmt1 = conn.createStatement();
		ArrayList<String> masterarray= new ArrayList<String>();
		
		 int maxdocno=1;
		    String sqlss="select coalesce(max(doc_no)+1,1) docno from my_ordsrvtemp";
		    ResultSet rs1=stmt.executeQuery(sqlss);
		    if(rs1.first())
		    {
		    	maxdocno=rs1.getInt("docno");
		    }
		
			for(int k=0;k<proday.size();k++)
			{
				String[] prod=((String) proday.get(k)).split("::"); 
				String psrno=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
				String qty=""+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].trim().equalsIgnoreCase("")|| prod[1].isEmpty()?0:prod[1].trim())+"";
				
			/* 	String foc=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
				String extfoc=""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].trim().equalsIgnoreCase("")|| prod[3].isEmpty()?0:prod[3].trim())+"";
				String price=""+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[4].trim())+"";
			 */	int prdid=Integer.parseInt(psrno);
   
				
				
				
				
					String updatesqls=" insert into my_ordsrvtemp(doc_no, psrno, acno, qty) value  "
									 +" ('"+maxdocno+"','"+psrno+"','"+venddocno+"','"+qty+"') ";
					
					
				 	//System.out.println("--------updatesqls-------"+updatesqls);
					stmt.executeUpdate(updatesqls);
				 
			}
		
 
				
				response.getWriter().print(maxdocno);
				 conn.commit();
				conn.close();
	    }
	    catch(Exception e)
	    {
	    	e.printStackTrace();
	    	conn.close();
	    	response.getWriter().print(0);
	    }
	 	
	 	
%>



 