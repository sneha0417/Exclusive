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
String gridarray=request.getParameter("gridarray")==null?"":request.getParameter("gridarray");     
String vocno=request.getParameter("vocno")==null || request.getParameter("vocno")==""?"0":request.getParameter("vocno");  
String brhid=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid");                
    
ClsConnection objconn=new ClsConnection();              
ClsCommon ClsCommon=new ClsCommon();
Connection conn=null;  
String msg="";  
int val=0;      
System.out.println("=============="+gridarray);           
try{
	conn=objconn.getMyConnection();
	
	    Statement stmt=conn.createStatement();  
	    ArrayList<String> newarray=new ArrayList();   
		String temparray[]=gridarray.split(",");
		for(int i=0;i<temparray.length;i++){
			newarray.add(temparray[i]);
		}
		for(int i=0;i<newarray.size();i++){
			
			String temp[]=newarray.get(i).split("::");
			
			if(!temp[5].trim().equalsIgnoreCase("undefined") && !temp[5].trim().equalsIgnoreCase("NaN") && !temp[5].trim().equalsIgnoreCase("")){
				String pay = temp[0].trim().equalsIgnoreCase("undefined") || temp[0].trim().equalsIgnoreCase("NaN") || temp[0].trim().equalsIgnoreCase("") || temp[0].trim().isEmpty()?"":temp[0].trim().toString();
				String est_cost = temp[1].trim().equalsIgnoreCase("undefined") || temp[1].trim().equalsIgnoreCase("NaN") || temp[1].trim().equalsIgnoreCase("") || temp[1].trim().isEmpty()?"0.0":temp[1].trim().toString();
				String margin = temp[2].trim().equalsIgnoreCase("undefined") || temp[2].trim().equalsIgnoreCase("NaN") || temp[2].trim().equalsIgnoreCase("") || temp[2].trim().isEmpty()?"0.0":temp[2].trim().toString();
				String total = temp[3].trim().equalsIgnoreCase("undefined") || temp[3].trim().equalsIgnoreCase("NaN") || temp[3].trim().equalsIgnoreCase("") || temp[3].trim().isEmpty()?"0.0":temp[3].trim().toString();
				String description = temp[4].trim().equalsIgnoreCase("undefined") || temp[4].trim().equalsIgnoreCase("NaN") || temp[4].trim().equalsIgnoreCase("") || temp[4].trim().isEmpty()?"":temp[4].trim().toString();
				int rowsno= temp[5].trim().equalsIgnoreCase("undefined") || temp[5].trim().equalsIgnoreCase("NaN") || temp[5].trim().equalsIgnoreCase("") || temp[5].trim().isEmpty()?0:Integer.parseInt(temp[5].trim().toString());
				            
				if(rowsno>0){                                                            
					String sql="update re_mreqmgmt set paytype='"+pay+"', estval="+est_cost+", margin="+margin+", total="+total+",description='"+description+"' where rowno="+rowsno+"";   
					System.out.println(sql);           
					val=stmt.executeUpdate(sql);        
				}      
		}
	} 
	if(val>0){
		String sql2="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,description) values("+vocno+",'"+brhid+"','MAPT',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','Estimation values edit')";   
		System.out.println(sql2);                 
		val=stmt.executeUpdate(sql2);    
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