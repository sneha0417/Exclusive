 
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
 

<%
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();


String jqxStartDate=request.getParameter("jqxStartDate");
String ival=request.getParameter("ival")==null?"0":request.getParameter("ival");
String chk=request.getParameter("chk")==null?"0":request.getParameter("chk");

String install=request.getParameter("install")==null?"0":request.getParameter("install");


		java.sql.Date sqloutdate=null;

	 
		 String status="";
 
	if(!(jqxStartDate.equalsIgnoreCase("undefined"))&&!(jqxStartDate.equalsIgnoreCase(""))&&!(jqxStartDate.equalsIgnoreCase("0")))
	{
	sqloutdate=ClsCommon.changeStringtoSqlDate(jqxStartDate);
		
	}
	else{

	}
	
	String descarray= "";;
		 	Connection conn = null;
		 	try{
		 		conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();  
			
			for(int i=1;i<=Integer.parseInt(install);i++)
				
			{
			String strSql = " SELECT DATE_FORMAT(DATE_ADD('"+sqloutdate+"',INTERVAL "+i+" month),'%d.%m.%Y')  months ";
		//	System.out.println("----------"+strSql);
			ResultSet rs = stmt.executeQuery(strSql);


			//String id="";
			if(rs.next()) {
				descarray=descarray+rs.getString("months")+"::";
							
		  		} 
		    
			}
			//System.out.println("descarray"+descarray);
			stmt.close();
			conn.close();
			response.getWriter().write(descarray);
		 	}
			catch(Exception e){
				
					conn.close();
					
				} 


 







	 %>
	