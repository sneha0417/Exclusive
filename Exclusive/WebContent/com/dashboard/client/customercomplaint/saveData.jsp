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
		
		String process=request.getParameter("process");
		String processname=request.getParameter("processname");
		String date=request.getParameter("date");
		String docno=request.getParameter("docno");
		String remarks=request.getParameter("remarks");
		String rdocno=request.getParameter("rdocno");
       //System.out.println("d==========================="+date);
		java.sql.Date sqlDate=null;

	    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(date);
		}

		String sql=null;
		int val=0,docNo=0;
		
        sql="select coalesce(max(doc_no)+1,1) doc_no from gl_bcuc";
        ResultSet resultSet = stmt.executeQuery(sql);
  
        while (resultSet.next()) {
		   docNo=resultSet.getInt("doc_no");
        }
        //System.out.println("pn========"+processname);
        if(processname.equalsIgnoreCase("Follow-Up")){
        	
		 /*Follow-Up */
	     sql="insert into gl_bcuc(doc_no, date, rdocno, fdate, remarks, userid) values("+docNo+", now(), '"+rdocno+"', '"+sqlDate+"', '"+remarks+"','"+session.getAttribute("USERID").toString()+"');";
		// System.out.println("bcuc=================="+sql);
	     val= stmt.executeUpdate(sql);
		 sql="insert into gl_biblog (doc_no, dtype, edate, userId, ENTRY) values ('"+docNo+"','CUC',now(),'"+session.getAttribute("USERID").toString()+"','A')";
		// System.out.println("biblog=================="+sql);
		 int data= stmt.executeUpdate(sql);
		 
        }
        
        else if(processname.equalsIgnoreCase("Confirm")){
	    
        /*Confirm */
		int followuprowno=0;
		sql="select rowno from gl_bibp where process='Follow-Up' and bibdid=(select doc_no from gl_bibd where description='Customer Complaint')";
		ResultSet resultSet1 = stmt.executeQuery(sql);		    
		while (resultSet1.next()) {
			followuprowno=resultSet1.getInt("rowno");
		}
		
        sql="update rl_guestregd set complete=1 where rowno='"+rdocno+"'";
    	val= stmt.executeUpdate(sql);
    	 sql="insert into gl_bcuc(doc_no, date, rdocno,fdate, remarks, userid) values("+docNo+", now(), '"+rdocno+"','"+sqlDate+"', 'Confirmed - "+remarks+"', '"+session.getAttribute("USERID").toString()+"');";
		 val= stmt.executeUpdate(sql); 
    	sql="insert into gl_biblog (doc_no, dtype, edate, userId, ENTRY) values ('"+docNo+"','CUC',now(),'"+session.getAttribute("USERID").toString()+"','D')";
    	int data= stmt.executeUpdate(sql);
    	
        }
        
		response.getWriter().print(val);

 	stmt.close();
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
