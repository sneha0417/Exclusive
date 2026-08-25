<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>  
<% int vocno =request.getParameter("vocno")==null || request.getParameter("vocno")==""?0:Integer.parseInt(request.getParameter("vocno"));
   int brhid =request.getParameter("brhid")==null || request.getParameter("brhid")==""?0:Integer.parseInt(request.getParameter("brhid"));
   String type =request.getParameter("type")==null || request.getParameter("type")==""?"":request.getParameter("type");     
%>  
<%
String result="",strcountdata="";        
int errorstatus=0; 
Connection conn=null;  
try{
	ClsConnection objconn=new ClsConnection(); 
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();  
	if(type.equalsIgnoreCase("AP")){
		strcountdata="select coalesce(p.acno) acno  from re_mreq m left join rl_propertymaster p on p.doc_no=m.pdoc_no where m.voc_no='"+vocno+"' and m.branch='"+brhid+"'";
	}else{
		strcountdata="select coalesce(p.mrf_acno) acno  from re_mreq m left join rl_propertymaster p on p.doc_no=m.pdoc_no where m.voc_no='"+vocno+"' and m.branch='"+brhid+"'";
	}
	System.out.println("=========="+strcountdata);  
	ResultSet rs=stmt.executeQuery(strcountdata);
	while(rs.next()){       
		result=rs.getString("acno");   
	}         
	response.getWriter().print(result);     
	stmt.close();
	conn.close();
}
catch(Exception e){    
	e.printStackTrace();
}
finally{
	conn.close();   
}

%>