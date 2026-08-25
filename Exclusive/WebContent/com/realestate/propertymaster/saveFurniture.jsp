<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%
String[] gridarray=request.getParameter("gridarray").split(",");
String pdocno=request.getParameter("pdocno")==null || request.getParameter("pdocno")==""?"":request.getParameter("pdocno"); 
String mode=request.getParameter("mode")==null || request.getParameter("mode")==""?"":request.getParameter("mode"); 
String rdocno=request.getParameter("rdocno")==null || request.getParameter("rdocno")==""?"":request.getParameter("rdocno"); 

System.out.println("grid array =" +gridarray );
System.out.println("pdocno =" + pdocno);
System.out.println("mode=" + mode);

Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();
   
   boolean msg=false;  
   int val=0;
   int pfdocno, v1=0,v2=0;		
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		 
			String sql1="delete from re_proomfurnfix where pdoc_no="+pdocno +" and rdoc_no="+rdocno;
			v1=stmt.executeUpdate(sql1);  
			System.out.println("array count= " +gridarray.length);
			for(int i=0;i<gridarray.length ;i++){
				
				String temp=gridarray[i];
				
				if(!temp.trim().equalsIgnoreCase("undefined") && !temp.trim().equalsIgnoreCase("NaN") && !temp.trim().equalsIgnoreCase(""))
				{
					
				temp=temp.replace('"', ' ').replace('[', ' ').replace(']', ' ');
					 
				 pfdocno = temp.trim().equalsIgnoreCase("undefined") || temp.trim().equalsIgnoreCase("NaN") || temp.trim().equalsIgnoreCase("") || temp.trim().isEmpty()?0:Integer.parseInt(temp.trim().toString());
				 
				 System.out.println("pfdocno=" + pfdocno);
				 
				 String sql2="insert into re_proomfurnfix(pdoc_no,rdoc_no,furnfixdoc_no) values("+pdocno+","+rdocno+","+pfdocno+")";
				 v2=stmt.executeUpdate(sql2);  
				   
				}   	
			}
			if (v2 <= 0) {                                                                                                                                                                                                                                       
				stmt.close();
				msg=false;					 
			}
			else
			{
				stmt.close();					 
				msg=true;					
			} 
			response.getWriter().print(msg);  
			conn.close();
		stmt.close();
		
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>