<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>
<%@page import="java.io.*" %>
<%@page import="org.apache.struts2.ServletActionContext" %>
<%
	Connection conn = null;

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt=conn.createStatement();
		//SendEmailAction sendmail=new SendEmailAction();
		String docno=request.getParameter("docno")==null || request.getParameter("docno").trim().equalsIgnoreCase("")?"0":request.getParameter("docno");
		String brhid=request.getParameter("brhid")==null || request.getParameter("brhid").trim().equalsIgnoreCase("")?"0":request.getParameter("brhid");
		String insdate=request.getParameter("insdate")==null || request.getParameter("insdate").trim().equalsIgnoreCase("")?"0":request.getParameter("insdate");
		
		
		String cldocno="0",email="",property="",msg="",job="",vendor="",estamount="",refdetails="";
		Statement stmt2 = conn.createStatement();
		String strSql2 = "select address1 from rl_propertymaster "
				+ "where  doc_no="+docno+""; 
		
		System.out.println(strSql2);
		ResultSet rs2 = stmt2.executeQuery(strSql2);
		  while(rs2.next ()) {
			  property=rs2.getString("address1"); 
		  } 
		  //String receiptdate=request.getParameter("receiptdate");   
		  //String docno=request.getParameter("docno");
		  String userid=session.getAttribute("USERID").toString();
		  msg="<html>"              
				  +" <body>"
				  +" <p>Dear Sir / Madam,</p><br/>"
				  +" <p>The inspection  in <b><<property>></b> will be conduct on <b> <<date>> </b>.</p>"  
				  +" <p>As soon as you give your authorization, our team will come fr inspection on the mentioned date.</p>"  
				  +" <p>Please give us your further instructions.</p>"
				  +" <p>Thank you</p>"  
				  +" <h2>Exclusive Link.</h2>"     
				  +" <p>Please dont print e-mails unless you really need</p>"
				  +" </p>"
				  +" </body>"
				  +" </html>"; 
		  msg = msg.replace("<<property>>",property);        
		  msg = msg.replace("<<date>>",insdate);   
		  
		  String formdetailcode="IMT",refid="",result="";//BI event reminder
		  result=msg;         
		  System.out.println("insend mail"+result);             
	      response.getWriter().print(result);         
	 
	 	 stmt.close();
	 	 conn.close(); 
	}catch(Exception e){
	 	e.printStackTrace();	
	 	conn.close();
   }finally{
	   conn.close();
   }
%>