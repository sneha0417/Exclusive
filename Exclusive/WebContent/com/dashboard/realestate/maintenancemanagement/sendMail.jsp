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
		String vocno=request.getParameter("vocno")==null || request.getParameter("vocno").trim().equalsIgnoreCase("")?"0":request.getParameter("vocno");
		String brhid=request.getParameter("brhid")==null || request.getParameter("brhid").trim().equalsIgnoreCase("")?"0":request.getParameter("brhid");
		String cldocno="0",email="",property="",msg="",job="",vendor="",estamount="",refdetails="";
		Statement stmt2 = conn.createStatement();
		String strSql2 = "select coalesce(mc.cldocno,0) cldocno,coalesce(h.description,'') vendor, pm.address1 as address, coalesce(group_concat(j.job_desc),'') job,coalesce(mc.refname,'') as owner,mc.mail1 email,sum(coalesce(r.total,0)) amount,pm.doc_no as pdocno ,mr.tdoc_no,mr.voc_no,mr.doc_no from re_mreq mr left join re_mreqmgmt r on r.rdocno=mr.doc_no left join rl_propertymaster pm on pm.doc_no=mr.pdoc_no	left join rl_jobmaster j on j.doc_no=mr.job_docno	left  join my_acbook mc on mc.cldocno=pm.owid and mc.dtype='CRM' left join my_head h on (h.doc_no=mr.jbprov and h.atype='ap')"
				+ "where  mr.voc_no='"+vocno+"' and mr.branch='"+brhid+"'  group by mr.voc_no";   
		System.out.println("emailsql===="+strSql2);  
		ResultSet rs2 = stmt2.executeQuery(strSql2);    
		  while(rs2.next ()) {
			  property=rs2.getString("address");
			  job=rs2.getString("job");
			  email=rs2.getString("email");
			  vendor=rs2.getString("vendor");  
			  estamount=rs2.getString("amount");
			  
		  } 
		  //String receiptdate=request.getParameter("receiptdate");   
		  //String docno=request.getParameter("docno");
		  String userid=session.getAttribute("USERID").toString();
		  msg="<html>"              
				  +" <body>"
				  +" <p>Dear Sir / Madam,</p><br/>"
				  +" <p>The estimation details of the maintenance work in <<property>> are as follows</p>" 
				  +" <p>Job  :<<job>></p>"
				  +" <p>Vendor    :<<vendor>></p>"
				  +" <p>Estimated Price  :<<estamount>></p>"
				  +" <p>As soon as you give your authorization, our team will immediately proceed to start the agreed repairs and have the work completed within one week of receiving your approval.</p>"  
				  +" <p>Please give us your further instructions.</p>"
				  +" <p>Thank you</p>"  
				  +" <h2>Exclusive Link.</h2>"     
				  +" <p>Please dont print e-mails unless you really need</p>"
				  +" </p>"
				  +" </body>"
				  +" </html>"; 
		  msg = msg.replace("<<property>>",property);        
		  msg = msg.replace("<<job>>",job);  
		  msg = msg.replace("<<vendor>>",vendor);  
		  msg = msg.replace("<<estamount>>",estamount);  
		  String formdetailcode="MMT",refid="",result="";//BI event reminder
		  result=msg+"::"+email+"::"+cldocno;         
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