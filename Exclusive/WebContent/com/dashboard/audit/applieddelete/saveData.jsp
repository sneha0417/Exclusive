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
		
		String trno=request.getParameter("trno");
		String accountno=request.getParameter("accountno");
		String outamounts=request.getParameter("outamount");
		String dtype=request.getParameter("dtype");
		
		String branchid=request.getParameter("branchid");
		String date=request.getParameter("date");
		String reason=request.getParameter("reason");
		
		int ap_trid=0;
		double outamount = Double.parseDouble(outamounts);
		double amount=0.00;
		
		java.sql.Date sqlDate=null;

	    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(date);
		}

		String sql=null;
		int val=0,docNo=0;
		
        sql="select coalesce(max(doc_no)+1,1) doc_no from gl_bad";
        ResultSet resultSet = stmt.executeQuery(sql);
  
        while (resultSet.next()) {
		   docNo=resultSet.getInt("doc_no");
        }
  
        /*Selecting Tran-Id*/
		  ArrayList<String> tranidarray=new ArrayList<String>();
		  String sql1="SELECT TRANID FROM my_jvtran where TR_NO="+trno+" and acno="+accountno+"";
		  ResultSet resultSet1=stmt.executeQuery(sql1);
		  
		  while(resultSet1.next()){
		   tranidarray.add(resultSet1.getString("tranid"));
		  }
		  /*Selecting Tran-Id Ends*/
		  
		 /*Master Insertion */
	     sql="insert into gl_bad(doc_no, date, reason, acno, tranid, brhid, userid) values("+docNo+", '"+sqlDate+"', '"+reason+"', "+accountno+", "+tranidarray.get(0)+", '"+branchid+"', '"+session.getAttribute("USERID").toString()+"')";
	     val= stmt.executeUpdate(sql);
	     /*Master Insertion Ends*/
	     
		  /*Selecting Ap_Tran-Id*/
		  ArrayList<String> outamtarray=new ArrayList<String>();

		  for(int i=0;i<tranidarray.size();i++){
		   String sql2="select ap_trid,amount from my_outd where tranid="+tranidarray.get(i);
		   ResultSet resultSet2=stmt.executeQuery(sql2);
		   
		   while(resultSet2.next()){
		    outamtarray.add(resultSet2.getInt("ap_trid")+"::"+resultSet2.getDouble("amount"));
		   } 

		  }
		  /*Selecting Ap_Tran-Id*/

		  for(int i=0;i<outamtarray.size();i++){
		   
		   ap_trid=Integer.parseInt(outamtarray.get(i).split("::")[0]);
		   amount=Double.parseDouble(outamtarray.get(i).split("::")[1]);

		   String sql4="update my_jvtran set out_amount=out_amount-("+amount+"*id) where tranid="+ap_trid+"";
		   int data1=stmt.executeUpdate(sql4);
		   
		  }
		/*Apply-Invoicing Grid Updating Ends*/
		  
	    /*Selecting outamount*/
	     String sql5="select sum(amount) outamount from my_outd where tranid="+tranidarray.get(0);
		 ResultSet resultSet3=stmt.executeQuery(sql5);
	   
	     while(resultSet3.next()){
		   outamount= resultSet3.getDouble("outamount");
	     }
	    /*Selecting outamount Ends*/
	   
	     String sql4="update my_jvtran set out_amount=out_amount-("+outamount+"*id) where tranid="+tranidarray.get(0)+"";
	     int data3=stmt.executeUpdate(sql4);
		   
		 /*Deleting from my_outd*/
		  String sql3="delete from my_outd where tranid="+tranidarray.get(0)+"";
		  int data2=stmt.executeUpdate(sql3);
		 /*Deleting from my_outd Ends*/
		 
		 sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+branchid+"','BAD',now(),'"+session.getAttribute("USERID").toString()+"','A')";
		 int data= stmt.executeUpdate(sql);
		 
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
