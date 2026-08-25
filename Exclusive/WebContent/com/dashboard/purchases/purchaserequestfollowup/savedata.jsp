 
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
	String docno=request.getParameter("docno");
	String branchids=request.getParameter("branchids");
	String remarks=request.getParameter("remarks");
	String cmbinfo=request.getParameter("cmbinfo");
	String folldate=request.getParameter("folldate");
 
	 Connection conn=null;
	 try{
		 ClsConnection ClsConnection =new ClsConnection();
		 ClsCommon ClsCommon=new ClsCommon();
		 java.sql.Date sqlprocessdate=null;

	 String upsql=null;
	 int val=0;
 	conn = ClsConnection.getMyConnection();
 	conn.setAutoCommit(false);
 	
	Statement stmt = conn.createStatement ();
	int docval=0;
	
 
	
	 
		   if(!(folldate.equalsIgnoreCase("undefined"))&&!(folldate.equalsIgnoreCase(""))&&!(folldate.equalsIgnoreCase("0")))
			{
			sqlprocessdate=ClsCommon.changeStringtoSqlDate(folldate);
				
			}
			else{

			}
		   int ddocno=0;
		   String sqls=" select   rowno from gl_bibp where bibdid=(select doc_no from gl_bibd where dtype='BRQF') and srno='"+cmbinfo+"' ";
		   ResultSet rsss=stmt.executeQuery(sqls);
		   
			   if(rsss.next())
			   {
				   ddocno= rsss.getInt("rowno");
			   }
		       upsql="select coalesce(max(doc_no)+1,1) doc_no from my_bprf";
			   ResultSet resultSet = stmt.executeQuery(upsql);
			   
			    if (resultSet.next()) {
			    	docval=resultSet.getInt("doc_no");
			    }	 
		     upsql="insert into my_bprf (doc_no,date, rdocno, bibpid, fdate, remarks, userid, status,refrowno)values('"+docval+"',now(),'"+docno+"','"+ddocno+"','"+sqlprocessdate+"','"+remarks+"','"+session.getAttribute("USERID").toString()+"',3,0) ";
		  // System.out.println("====4====="+upsql);
			 val= stmt.executeUpdate(upsql);
			 upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docval+"','"+branchids+"','BRQF',now(),'"+session.getAttribute("USERID").toString()+"','A')";
			 
			 int aaa= stmt.executeUpdate(upsql);
			 
			  
	   if(val>0)
		 {//
          conn.commit();
           conn.close();
		 }			
		response.getWriter().print(val);
	 	stmt.close();
	 	conn.close();
	 	  
	 }

	 catch(Exception e){
		 response.getWriter().print(0);
	 	 conn.close();
	 	 e.printStackTrace();
	 		}
	
	%>
