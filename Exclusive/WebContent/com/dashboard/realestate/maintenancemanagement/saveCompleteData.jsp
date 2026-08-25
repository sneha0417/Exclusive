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
String descarray=request.getParameter("descarray")==null?"":request.getParameter("descarray");   
String vocno=request.getParameter("vocno")==null || request.getParameter("vocno")==""?"0":request.getParameter("vocno");
String brhid=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid");     

ClsConnection objconn=new ClsConnection();  
ClsCommon ClsCommon=new ClsCommon();
Connection conn=null;  
String msg="";  
int val=0;      
System.out.println(descarray+"=============="+docnoarray);                  
try{
		conn=objconn.getMyConnection();
	    Statement stmt=conn.createStatement();  
	    ArrayList<String> newarray=new ArrayList();
		
		String temparray[]=descarray.split(",");
		for(int i=0;i<temparray.length;i++){
			newarray.add(temparray[i]);
		}
		
	    String sql="update re_mreq set statusid=5,mstatus=3,wdate=now() where doc_no in("+docnoarray+")";            
		System.out.println(sql);           
		val=stmt.executeUpdate(sql); 
        if(val>0){
				for(int i=0;i<newarray.size();i++){
				String temp[]=newarray.get(i).split("::");
				
				if(!temp[0].trim().equalsIgnoreCase("undefined") && !temp[0].trim().equalsIgnoreCase("NaN") && !temp[0].trim().equalsIgnoreCase("")){
					String rowno = (temp[0].trim().equalsIgnoreCase("undefined") || temp[0].trim().equalsIgnoreCase("NaN") || temp[0].trim().equalsIgnoreCase("") || temp[0].trim().isEmpty()?"0":temp[0].trim()).toString();    
					String descptn = temp[1].trim().equalsIgnoreCase("undefined") || temp[1].trim().equalsIgnoreCase("NaN") || temp[1].trim().equalsIgnoreCase("") || temp[1].trim().isEmpty()?"":temp[1].trim().toString();
	        
				    String sqlsss="update re_mreqmgmt set description='"+descptn+"' where rowno='"+rowno+"'";    
				    System.out.println("=============="+sqlsss);      
					val=stmt.executeUpdate(sqlsss);  
				}
		    }	
        }
        if(val>0){
			String sqllog="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,description) values("+vocno+",'"+brhid+"','MMT',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','Work Completed')";            
			System.out.println(sqllog);                       
			int val1=stmt.executeUpdate(sqllog); 
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