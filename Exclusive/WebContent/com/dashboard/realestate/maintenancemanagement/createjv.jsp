<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %> 
<%@page import="com.finance.transactions.journalvouchers.ClsJournalVouchersDAO" %>
<%@page import="com.ibm.icu.text.SimpleDateFormat" %>  
<%@page import="com.common.*"%>
<%
String journalarray=request.getParameter("jvarray")==null?"":request.getParameter("jvarray");   
String amount=request.getParameter("amount")==null || request.getParameter("amount")==""?"0.0":request.getParameter("amount");
String invno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno");
String docno=request.getParameter("invdocno")==null || request.getParameter("invdocno")==""?"0":request.getParameter("invdocno");
String brhid=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid");
String invdate=request.getParameter("invdate")==null || request.getParameter("invdate")==""?null:request.getParameter("invdate");
String desc=request.getParameter("desc")==null || request.getParameter("desc")==""?"":request.getParameter("desc");
int val=0,trnno=0;
Connection conn=null;                         
try{
	//System.out.println("journalarray=="+journalarray);
	ClsJournalVouchersDAO dao= new ClsJournalVouchersDAO();
	ClsConnection objconn=new ClsConnection();         
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement(); 
	//SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");     
	//java.util.Date curDate=new java.util.Date();  
    java.sql.Date cdate=objcommon.changeStringtoSqlDate(invdate);   
	double cmaount=Double.parseDouble(amount);
	session.setAttribute("BRANCHID",brhid);
	ArrayList<String> journalvouchersarray=new ArrayList<String>();  
	if(!journalarray.equalsIgnoreCase("")){
		String temp[]=journalarray.split(",");
		for(int i=0;i<temp.length;i++){
			journalvouchersarray.add(temp[i]);
		}	
	}
	
	int trno=dao.insert(cdate,"JVT-23", invno, desc, cmaount, cmaount, journalvouchersarray, session, request);
	trnno=Integer.parseInt(request.getAttribute("tranno").toString());
	if(trno>0){
		String strsql="update re_mreq set jvtrno='"+trnno+"',jv_vocno='"+trno+"',blockamt="+cmaount+" where voc_no='"+docno+"' and branch='"+brhid+"'";                	                         
		//System.out.println("====="+strsql);
		val=stmt.executeUpdate(strsql);
		String strjvup="update my_jvtran set rtype='MMT',rdocno='"+docno+"' where tr_no='"+trnno+"'";                	                         
		//System.out.println("====="+strjvup);    
		val=stmt.executeUpdate(strjvup);   
	}
	if(val>0){
		String sqllog="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,description) values("+docno+",'"+brhid+"','MMT',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','Amount Blocked')";            
		System.out.println(sqllog);                       
		int val1=stmt.executeUpdate(sqllog); 
	}
	response.getWriter().print(trno);          
}
catch(Exception e){  
	e.printStackTrace();
}
finally{
	conn.close();
}
%>