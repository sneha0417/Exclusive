
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

ClsCommon ClsCommon=new ClsCommon();
  
  String docno = request.getParameter("docno");  
  String authname = request.getParameter("authname");
  String codeno = request.getParameter("codeno");
 
 String list=request.getParameter("list")==null?"0":request.getParameter("list");
   
  ArrayList<String> psrnoarray= new ArrayList<String>();
	String aa[]=list.split(",");
		 
	for(int i=0;i<aa.length;i++){
		// System.out.println("----------"+aa[i]);
		 String bb[]=aa[i].split("::");
		// System.out.println("Col Len----------"+bb.length);
		 String temp="";
		 for(int j=0;j<bb.length;j++){ 
			
			 temp=temp+bb[j]+"::";
		
		}
		 psrnoarray.add(temp);
		 
	} 
		Connection conn=null;

		 try{
	 	 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int valup=0;
	int valins=0;
	
	for(int k=0;k<psrnoarray.size();k++)
	{
		
		String[] pmgntarr=((String) psrnoarray.get(k)).split("::"); 
		
		 String nalias = ""+(pmgntarr[0].trim().equalsIgnoreCase("undefined") || pmgntarr[0].trim().equalsIgnoreCase("NaN")|| pmgntarr[0].trim().equalsIgnoreCase("")|| pmgntarr[0].isEmpty()?"":pmgntarr[0].trim())+"";
		 String naliasdocno = ""+(pmgntarr[1].trim().equalsIgnoreCase("undefined") || pmgntarr[1].trim().equalsIgnoreCase("NaN")|| pmgntarr[1].trim().equalsIgnoreCase("")|| pmgntarr[1].isEmpty()?0:pmgntarr[1].trim())+"";
		 if(Integer.parseInt(naliasdocno)>0)
			{
			System.out.println("doc");
		 String sqlappra="update gl_webcat set nalias='"+nalias+"' where doc_no='"+naliasdocno+"'";
			valup=stmt.executeUpdate(sqlappra); 
			
			}
			else
			{
				
			String sqlsave="insert into gl_webcat(codeno,nalias,type,itemno,adhno,emirate) values('"+codeno+"','"+nalias+"','P','"+docno+"','"+docno+"','"+authname+"')";
			valins=stmt.executeUpdate(sqlsave);  
			
			}
		 	
	}
			
		 	if(valup>0 || valins>0)
		 	{
		 		 response.getWriter().print(1);
		 		stmt.close();
			 	conn.close();
		 	} 
		 	else
		 	{
		 		 response.getWriter().print(2);
			 		stmt.close();
				 	conn.close();
		 	}

	 }

	 catch(Exception e){

	 			conn.close();
	 			e.printStackTrace();
	 			response.getWriter().print(2);
	 		}
	
	%>