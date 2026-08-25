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
<%
String docnoarray=request.getParameter("gridarray")==null?"":request.getParameter("gridarray");     
String pdocno=request.getParameter("pdocno")==null || request.getParameter("pdocno")==""?"":request.getParameter("pdocno"); 
String mode=request.getParameter("mode")==null || request.getParameter("mode")==""?"":request.getParameter("mode"); 
String rdocno=request.getParameter("rdocno")==null || request.getParameter("rdocno")==""?"":request.getParameter("rdocno"); 
   
ClsConnection objconn=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
Connection conn=null;  
String msg="";  
int val=0,val1=0;      
System.out.println("=============="+docnoarray);              
try{
	    conn=objconn.getMyConnection();
	    Statement stmt=conn.createStatement(); 
        ArrayList<String> newarray=new ArrayList();
		
		String temparray[]=docnoarray.split(",");
		for(int i=0;i<temparray.length;i++){
			newarray.add(temparray[i]);
		}
	    String sql1="delete from re_proomfurnfix where pdoc_no="+pdocno +" and rdoc_no="+rdocno;
		val1=stmt.executeUpdate(sql1);
		
			for(int i=0;i<newarray.size();i++){
			String temp[]=newarray.get(i).split("::");
			
			if(!temp[0].trim().equalsIgnoreCase("undefined") && !temp[0].trim().equalsIgnoreCase("NaN") && !temp[0].trim().equalsIgnoreCase("")){
				String rowno = (temp[0].trim().equalsIgnoreCase("undefined") || temp[0].trim().equalsIgnoreCase("NaN") || temp[0].trim().equalsIgnoreCase("") || temp[0].trim().isEmpty()?"0":temp[0].trim()).toString();    
        
			    String sqlsss="insert into re_proomfurnfix(pdoc_no,rdoc_no,furnfixdoc_no) values('"+pdocno+"','"+rdocno+"','"+rowno+"')";    
			    System.out.println("=============="+sqlsss);      
				val=stmt.executeUpdate(sqlsss);  
			}
	    }	
     
}    
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(val);   
%>