<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %> 
<%@page import="com.finance.transactions.journalvouchers.ClsJournalVouchersDAO" %> 
<%
String journalarray=request.getParameter("journalvocarray")==null?"":request.getParameter("journalvocarray");
String vndacno=request.getParameter("vndacno")==null || request.getParameter("vndacno")==""?"0":request.getParameter("vndacno");
String tenantacno=request.getParameter("tenantacno")==null || request.getParameter("tenantacno")==""?"0":request.getParameter("tenantacno");
String owneracno=request.getParameter("owneracno")==null || request.getParameter("owneracno")==""?"0":request.getParameter("owneracno");
String amount=request.getParameter("amount")==null || request.getParameter("amount")==""?"0":request.getParameter("amount");
String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno");
String invno=request.getParameter("invno")==null || request.getParameter("invno")==""?"0":request.getParameter("invno");
String invdate=request.getParameter("invdate")==null || request.getParameter("invdate")==""?null:request.getParameter("invdate");
String desc=request.getParameter("desc")==null || request.getParameter("desc")==""?"0":request.getParameter("desc");
int val=0;
Connection conn=null;    
try{
	System.out.println("journalarray=="+journalarray);
	ClsJournalVouchersDAO dao= new ClsJournalVouchersDAO();
	ClsConnection objconn=new ClsConnection();         
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement(); 
	java.sql.Date cdate=objcommon.changeStringtoSqlDate(invdate);  
	double cmaount=Double.parseDouble(amount);
	int val1=0;
	String comacno="",comname="",expacno="",expacname="",profacno="",profacname="",vatacno="",vatacname="";
	ArrayList<String> journalvouchersarray=new ArrayList<String>();
	if(!journalarray.equalsIgnoreCase("")){
		String temp[]=journalarray.split(",");
		for(int i=0;i<temp.length;i++){
			journalvouchersarray.add(temp[i]);
		}	
	}
	
	int trno=dao.insert(cdate,"JVT-1", invno, desc, cmaount, cmaount, journalvouchersarray, session, request);
	//System.out.println("docno===="+docno+"invno==="+invno+"invdate==="+invdate+"cmbpay==="+cmbpay+"tenantacno==="+tenantacno+"owneracno==="+owneracno+"owneracname==="+owneracname);
	
	String strsql="update my_jvtran set status=7 where doc_no='"+trno+"'";       	                         
	//,lstdate=now(),lstuser="+session.getAttribute("USERID").toString()+"      
	val1=stmt.executeUpdate(strsql);   
	
	String strsq2="update my_jvma set status=7 where doc_no='"+trno+"'";       	                         
	//,lstdate=now(),lstuser="+session.getAttribute("USERID").toString()+"      
	val1=stmt.executeUpdate(strsq2);
	
	String strsq3="update re_mreq set posttrno="+trno+" where doc_no="+docno+"";       	                         
	//,lstdate=now(),lstuser="+session.getAttribute("USERID").toString()+"      
	val1=stmt.executeUpdate(strsq3);
	
	response.getWriter().print(trno); 
}
catch(Exception e){  
	e.printStackTrace();
}
finally{
	conn.close();
}
%>