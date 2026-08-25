
 <%@page import="com.opensymphony.xwork2.util.TextParseUtil.ParsedValueEvaluator"%>
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
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

Connection conn=null;

try{

	String clientid=request.getParameter("clientid");
	String type=request.getParameter("type");
	String exdate=request.getParameter("exdate");
	String renval=request.getParameter("renval");
	String rdocno=request.getParameter("rdocno");
	String pytdoc=request.getParameter("pytdoc");
	String action=request.getParameter("action");

	 String branchid=request.getParameter("branchid");
	
	
	
	
	
String ta="";

if(type.equalsIgnoreCase("rental"))
{
ta="r";

}
else
{
	ta="l";	

}
	

java.sql.Date sqlexdate=null;



	 
	 exdate.trim();
	 
	
	 
 	if(!(exdate.equalsIgnoreCase("undefined"))&&!(exdate.equalsIgnoreCase(""))&&!(exdate.equalsIgnoreCase("0")))
 	{
 		 sqlexdate=ClsCommon.changeStringtoSqlDate(exdate);
 		
 	}
 	else{
 
 	}


	 String upsql=null;

	 int val=0;
	 int docval=0;
	 
	

	 
    conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();


	if(action.equalsIgnoreCase("Extended"))
	{
	  upsql="update gl_"+ta+"pyt set reldate='"+sqlexdate+"' where rdocno='"+rdocno+"' and doc_no='"+pytdoc+"' ";
	    stmt.executeUpdate(upsql); 
	}
	else
	{
		  upsql="update gl_"+ta+"pyt set relstatus=1 where rdocno='"+rdocno+"' and doc_no='"+pytdoc+"' ";
		    stmt.executeUpdate(upsql); 
	}

		  if(action.equalsIgnoreCase("Extended"))
			{
			  
			  upsql="select coalesce(max(doc_no)+1,1) doc_no from gl_bcbf";
			   ResultSet resultSet = stmt.executeQuery(upsql);
			   
			    if (resultSet.next()) {
			    	docval=resultSet.getInt("doc_no");
			    }
			  
			  
			  
		upsql="insert into gl_bcbf (doc_no,rtype, rdocno, pytno, action, extdt, remarks)values('"+docval+"','"+type+"','"+rdocno+"','"+pytdoc+"', '"+action+"','"+sqlexdate+"','"+renval+"')";
		
		    val= stmt.executeUpdate(upsql); 
		    
			 upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+docval+",'"+branchid+"','BCBF',now(),'"+session.getAttribute("USERID").toString()+"','A')";
			 int aaa= stmt.executeUpdate(upsql);
			}
		  else{
			  
			  upsql="select coalesce(max(doc_no)+1,1) doc_no from gl_bcbf";
			   ResultSet resultSet = stmt.executeQuery(upsql);
			   
			    if (resultSet.next()) {
			    	docval=resultSet.getInt("doc_no");
			    }
			  
			  upsql="insert into gl_bcbf (doc_no,rtype, rdocno, pytno, action,remarks,cldocno)values('"+docval+"','"+type+"','"+rdocno+"','"+pytdoc+"', '"+action+"','"+renval+"','"+clientid+"')";
			
				 val= stmt.executeUpdate(upsql);  
				 upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+docval+",'"+branchid+"','BCBF',now(),'"+session.getAttribute("USERID").toString()+"','A')";
				 int aaa= stmt.executeUpdate(upsql);
		     }
		
		 

		 

	
		 response.getWriter().print(val);
	 
	 
	 	stmt.close();
	 	conn.close();
	 	  
	 }

	 catch(Exception e){

	 			conn.close();
	 			e.printStackTrace();
	 		}
	
	%>
