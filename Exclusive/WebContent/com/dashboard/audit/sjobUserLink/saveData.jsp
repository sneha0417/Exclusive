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

	Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
 int branchid=1;
		String jobtype=request.getParameter("jobtype")==null?"0":request.getParameter("jobtype");
		String username=request.getParameter("username")==null?"0":request.getParameter("username");
		String userrole=request.getParameter("userrole")==null?"0":request.getParameter("userrole");
		String jobtypeid=request.getParameter("jobtypeid")==null?"0":request.getParameter("jobtypeid");
		
		System.out.println("=======jobtype in savedata====="+jobtype);
	    
		 String sql=null;
		 String sqlupdate=null;
		 
		int val=0;
		
		int userid=0;
		
		//int jobtypeid=0;
		
		int usercount=0;
		
		 String sql9s="select doc_no  from my_user where user_name='"+username+"'";
		 
		 System.out.println("userid=="+sql9s);
		 
		ResultSet rst=stmt.executeQuery(sql9s);
		if(rst.first())
		{
			userid=rst.getInt("doc_no");
		}
		
		
		
		
 	   String sql11s="select count(*) count from cm_sjobuserlink where userid='"+userid+"'";
		 
		 System.out.println("count=="+sql11s);
		 
		ResultSet rst2=stmt.executeQuery(sql11s);
		if(rst2.first())
		{
			usercount=rst2.getInt("count");
		}
		
		
	
		
		/* String sql10s="select rowno  from cm_sjobtype where process='"+jobtype+"'";
		
		System.out.println("jobtypeid=="+sql10s);
		
		ResultSet rst1=stmt.executeQuery(sql10s);
		if(rst1.first())
		{
			jobtypeid=rst1.getInt("rowno");
		} */
	
		 /*Audit */
    	// sql="update  my_invm set audit=1 where   doc_no='"+docnos+"'";
     	// val= stmt.executeUpdate(sql); 
	 	 if(usercount==0)
	 	 {
     	 sql="insert into cm_sjobuserlink (username, userid, userrole, jobtype,jtype) values ('"+username+"','"+userid+"','"+userrole+"','"+jobtypeid+"','"+jobtype+"')";
     	 
     	System.out.println("insertion=="+sql);
     	 
	 	 int data= stmt.executeUpdate(sql);
	 	 
	 	if(data>0){
	 		val=1;
	 	}
	
	 	 }
	 	 else{
	 		 
	 		sqlupdate="update cm_sjobuserlink set jobtype='"+jobtypeid+"',jtype='"+jobtype+"' where userid='"+userid+"'";
	     	 
	     	System.out.println("update=="+sqlupdate);
	     	 
		 	 int data1= stmt.executeUpdate(sqlupdate);
	 		 
	 		 if(data1>0){
	 			 val=1;
	 		 }
	 		 
	 	 }
	 	 
	 	 
	 	 
	 	 
		 	
		response.getWriter().print(val);

	 	stmt.close();
	 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	response.getWriter().print(0);
	 	conn.close();
   }finally{
	   conn.close();
   }
	
%>
