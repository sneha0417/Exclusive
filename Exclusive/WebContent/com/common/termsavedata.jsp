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

String chk=request.getParameter("chk")==null?"NA":request.getParameter("chk");


String docno=request.getParameter("docno").toString();

String formcode=request.getParameter("dtype").toString();

String brhid=request.getParameter("brhid").toString();

 

 
ArrayList<String> termslist= new ArrayList<String>();
String aa[]=list.split(",");
 
System.out.println("===list=============================================="+list);
for(int i=0;i<aa.length;i++){
	//  System.out.println("----------"+aa[i]);
	 String bb[]=aa[i].split("::");
	  
	 String temp="";
	 for(int j=0;j<bb.length;j++){ 
	   //System.out.println("----------"+bb[j]);
		 temp=temp+bb[j]+"::";
		 
	}
	 termslist.add(temp);
	 
} 
 
	  Connection conn=null;
	    String sql="";
	    try
	    {
	   	
	    conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		//  System.out.println("----chk------"+chk);
		  
 	  if(chk.equalsIgnoreCase("0"))
		  {

				String termsql="delete from my_trterms where rdocno='"+docno+"' and brhid='"+brhid+"' and dtype='"+formcode+"'";
				
		System.out.println("===termsql===="+termsql);
				Statement stnmt1=conn.createStatement(); 
				stnmt1.executeUpdate (termsql);
		  }
		  
	 
		 for(int i=0;i<termslist.size();i++){


				String[] terms=((String) termslist.get(i)).split("::");

				if(!((terms[0].equalsIgnoreCase("0"))||(terms[0].equalsIgnoreCase("undefined")))){


					String termsql="insert into my_trterms(rdocno, termsid, conditions,priorno, status,brhid, dtype)VALUES"
							+ " ('"+docno+"',"
							+ "'"+(terms[0].equalsIgnoreCase("undefined") || terms[0].equalsIgnoreCase("") || terms[0].trim().equalsIgnoreCase("NaN")|| terms[0].isEmpty()?0:terms[0].trim())+"',"
							+ "'"+(terms[2].equalsIgnoreCase("undefined") || terms[2].equalsIgnoreCase("") || terms[2].trim().equalsIgnoreCase("NaN")|| terms[2].isEmpty()?0:terms[2].trim())+"',"
							+ "'"+(terms[3].equalsIgnoreCase("undefined") || terms[3].equalsIgnoreCase("") || terms[3].trim().equalsIgnoreCase("NaN")|| terms[3].isEmpty()?0:terms[3].trim())+"',"
							+ "'3',"
							+ "'"+brhid+"',"
							+ "'"+formcode+"')";

					Statement stnmt=conn.createStatement(); 

					System.out.println("termsdet--->>>>Sql"+termsql);
					
					int resultSet3 = stnmt.executeUpdate (termsql);
					
					
				 

					 
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



 