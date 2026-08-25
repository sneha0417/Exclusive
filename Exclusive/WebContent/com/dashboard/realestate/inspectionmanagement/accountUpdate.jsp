<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %> 
<%@page import="com.finance.transactions.journalvouchers.ClsJournalVouchersDAO" %> 
<%
String journalarray=request.getParameter("journalarray")==null?"":request.getParameter("journalarray");
String vndacno=request.getParameter("vndacno")==null || request.getParameter("vndacno")==""?"0":request.getParameter("vndacno");
String tenantacno=request.getParameter("tenantacno")==null || request.getParameter("tenantacno")==""?"0":request.getParameter("tenantacno");
String owneracno=request.getParameter("owneracno")==null || request.getParameter("owneracno")==""?"0":request.getParameter("owneracno");
String owneracname=request.getParameter("owneracname")==null || request.getParameter("owneracname")==""?"0":request.getParameter("owneracname");
String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno");
String invno=request.getParameter("invno")==null || request.getParameter("invno")==""?"0":request.getParameter("invno");
String invdate=request.getParameter("invdate")==null || request.getParameter("invdate")==""?null:request.getParameter("invdate");
String mrfacno=request.getParameter("mrfacno")==null || request.getParameter("mrfacno")==""?"0":request.getParameter("mrfacno");
int val=0;
Connection conn=null;    
try{
	System.out.println("=-=======in account update========");
	ClsConnection objconn=new ClsConnection();         
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement(); 
	String comacno="",comname="",expacno="",expacname="",profacno="",profacname="",vatacno="",vatacname="",owneraccno="",owneraccname="",mrfaccno="",mrfacname="";
	
	String sql="select account,description from my_head where doc_no="+tenantacno+"";
	ResultSet res= stmt.executeQuery(sql);
	while(res.next()){
		comacno=res.getString("account");
		comname=res.getString("description");
		
	}
	String sql1="select codeno,acno from my_account where codeno='profit income'";
	ResultSet res2= stmt.executeQuery(sql1);
	while(res2.next()){
		profacno=res2.getString("acno");
		profacname=res2.getString("codeno");
		
	}
	
	String sql2="select codeno,acno from my_account where codeno='expense'";
	ResultSet res3= stmt.executeQuery(sql2);
	while(res3.next()){
		expacno=res3.getString("acno");
		expacname=res3.getString("codeno");
		
	}
	
	String sql3="select p.doc_no,p.producttype ptype,m.per,m.acno taxaccount from my_ptype p left join gl_taxmaster m on p.doc_no=m.typeid and m.type=1 where  p.status=3 and m.type=1  and m.typeid>0 group by p.doc_no order by p.doc_no";
	ResultSet res4= stmt.executeQuery(sql3);
	while(res4.next()){
		vatacno=res4.getString("taxaccount");
		vatacname=res4.getString("ptype");
		
	}
	
	String sql4="select account,description from my_head where doc_no="+owneracno+"";
	ResultSet res5= stmt.executeQuery(sql4);
	while(res5.next()){
		owneraccno=res5.getString("account");
		owneraccname=res5.getString("description");
		
	}
	
	String sql5="select account,description from my_head where doc_no="+mrfacno+"";
	ResultSet res6= stmt.executeQuery(sql5);
	while(res6.next()){
		mrfaccno=res6.getString("account");
		mrfacname=res6.getString("description");
		
	}
	System.out.println(comacno+"::"+comname+"::"+profacno+"::"+profacname+"::"+expacno+"::"+expacname+"::"+vatacno+"::"+vatacname+"::"+owneraccno+"::"+owneraccname+"::"+mrfaccno+"::"+mrfacname);  
	response.getWriter().print(comacno+"::"+comname+"::"+profacno+"::"+profacname+"::"+expacno+"::"+expacname+"::"+vatacno+"::"+vatacname+"::"+owneraccno+"::"+owneraccname+"::"+mrfaccno+"::"+mrfacname); 
}
catch(Exception e){  
	e.printStackTrace();
}
finally{
	conn.close();
}
%>