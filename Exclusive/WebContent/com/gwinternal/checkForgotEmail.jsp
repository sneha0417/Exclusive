<%@page import="com.mailwithpdf.*"%>
<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%
String email=request.getParameter("email")==null?"":request.getParameter("email");
Connection conn=null;
int emailstatus=0;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsEncrypt objencrypt=new ClsEncrypt();
	SendEmailAction objemail=new SendEmailAction();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String userid="",password="",port="",host="",mailpassword="",user="",mail="";
	String stremail="select mail,user_name,user_id,pass,email,coalesce(if(email='"+email+"',1,0),0) emailstatus,mailpass,smtpServer,smtpHostport from my_user where email='"+email+"' and status=3";
	
	System.out.println(stremail);
	ResultSet rsemail=stmt.executeQuery(stremail);
	while(rsemail.next()){
		mail=rsemail.getString("mail");
		emailstatus=rsemail.getInt("emailstatus");
		userid=rsemail.getString("user_id");
		password=rsemail.getString("pass");
		port=rsemail.getString("smtpHostport");
		host=rsemail.getString("smtpServer");
		mailpassword=rsemail.getString("mailpass");
		//mailpassword=ClsEncrypt.getInstance().decrypt(mailpassword);
		password=rsemail.getString("pass");
		password=ClsEncrypt.getInstance().decrypt(password);
	}
	System.out.println(mail+"::"+emailstatus+"::"+userid+"::"+password+"::"+port+"::"+host+"::"+mailpassword+"::"+password);
	if(emailstatus==1){
		EmailProcess ep=new EmailProcess();
		String subject="Gateway Login Credentials";
		String path="";
		String message="Hi "+user+",You recently requested your login credentials for your Gateway ERP Account.If you did not request this,then please ignore this email or reply us.Your User Id is "+userid+" and Password id "+password+".Thanks Gateway ERP";
		File f1=new File(path);
		/* ep.sendEmailwithpdfNoAuth(host, port, mail, email, subject, message, f1, "1"); */
		ep.sendEmailwithpdf(host, port, mail, mailpassword, email, subject, message, null, "1");
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(emailstatus+"");
%>