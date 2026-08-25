 
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


	String docno=request.getParameter("doc_no");
    String sdocno=request.getParameter("sdocno");

   System.out.println("doc_no=="+docno);
   System.out.println("sdoc_no=="+sdocno);
	 Connection conn=null;

	 try{
		 ClsConnection ClsConnection =new ClsConnection();
		 ClsCommon ClsCommon=new ClsCommon();
	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int aaa=0;
	if(sdocno.equalsIgnoreCase("99"))
	{

	    String sql="update cr_qotd  set pstatus=1, cur_status="+sdocno+" where doc_no="+docno+";";
		 System.out.println("aaaaaa---"+sql);
		 
		      aaa= stmt.executeUpdate(sql);
	    
	}
	else
	{
		String sql="update cr_qotd  set  cur_status="+sdocno+" where doc_no="+docno+";";
		 System.out.println("aaaaaa---"+sql);
		 
		      aaa= stmt.executeUpdate(sql);
	}
	
    
    

	System.out.println("aaaaaa---"+aaa);
	response.getWriter().print(aaa);
	 	//System.out.println("aaaaaa"+accode);
	 	stmt.close();
	 	conn.close();
	 	  
	 }

	 catch(Exception e){
		 response.getWriter().print(0);
	 			conn.close();
	 			e.printStackTrace();
	 		}
	
	%>
