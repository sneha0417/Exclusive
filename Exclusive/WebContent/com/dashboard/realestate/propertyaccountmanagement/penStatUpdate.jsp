<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %> 
<%              
String remark=request.getParameter("remarks")==null?"":request.getParameter("remarks");   
String crtuser=request.getParameter("crtuser")==null?"0":request.getParameter("crtuser");
String userid=request.getParameter("userid")==null?"0":request.getParameter("userid");
String status=request.getParameter("status")==null?"0":request.getParameter("status");
String oldstatus=request.getParameter("oldstatus")==null?"0":request.getParameter("oldstatus");   
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno"); 
String asgnuser=request.getParameter("asgnuser")==null?"":request.getParameter("asgnuser");  
String oldassuser=request.getParameter("oldassuser")==null?"0":request.getParameter("oldassuser");
int val=0;   
Connection conn=null;
try{          
	ClsConnection objconn=new ClsConnection();  
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement(); 
	String strsql="";
	if(!(status.equalsIgnoreCase("Close") || status.equalsIgnoreCase("Completed"))){                  
		if(!asgnuser.equalsIgnoreCase("")){              
			strsql="update an_taskcreation set ass_user='"+asgnuser+"',act_status='"+status+"' where doc_no='"+docno+"' and utype!='app'";	
			val=stmt.executeUpdate(strsql);
		}else{  
			strsql="update an_taskcreation set ass_user='"+oldassuser+"',act_status='"+status+"' where doc_no='"+docno+"' and utype!='app'";
			val=stmt.executeUpdate(strsql);
		}      
	}else if(status.equalsIgnoreCase("Completed")){          
			strsql="update an_taskcreation set ass_user='"+crtuser+"',act_status='"+status+"' where doc_no='"+docno+"' and utype!='app'";	
			val=stmt.executeUpdate(strsql);
	}else{
		  strsql="update an_taskcreation set act_status='"+status+"',close_status=1 where doc_no='"+docno+"' and act_status='Completed' and utype!='app'";
		  val=stmt.executeUpdate(strsql);
		  
		 if(!oldstatus.equalsIgnoreCase("Completed")){       
	    	 val=-888;          
	     }else{}
	}
	if(val>0){  
		String flwsql="insert into an_taskcreationdets(rdocno,ass_date,userid,assnfrom_user,action_status,remarks) values('"+docno+"',now(),'"+asgnuser+"','"+session.getAttribute("USERID")+"','"+status+"','"+remark+"')";
		int val2=stmt.executeUpdate(flwsql);          
	}
	System.out.println(val+"---->>>"+strsql);  
}   
catch(Exception e){  
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(val+"");   

%>