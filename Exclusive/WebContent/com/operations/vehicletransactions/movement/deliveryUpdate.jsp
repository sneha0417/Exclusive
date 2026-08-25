<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="com.common.*" %>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.*"%>
<script>
<%
Connection conn=null;
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
try{
conn=objconn.getMyConnection();

System.out.println("DELIVERY JSP PAGE");
String doc=request.getParameter("doc");
String fleet=request.getParameter("fleet");
String date=request.getParameter("date");
String time=request.getParameter("time");
String km=request.getParameter("km");
String fuel=request.getParameter("fuel");
String location=request.getParameter("location");
String branch=request.getParameter("branch");
String trancode=request.getParameter("trancode");
String driver=request.getParameter("driver");
java.sql.Date date1 = objcommon.changetstmptoSqlDate(date);
System.out.println("Date================"+date1);
//Date date1=new Date('2015-01-11');
System.out.println("INSIDE DELIVERY JSP"+doc+fleet+date+time+km+fuel+location+branch+trancode);
	Statement stmt = conn.createStatement ();
	String testdoc="";
	String testparent="";
	double testfout=0.0,testkmout=0.0;
	java.sql.Date testdout=null;
	String testtout="";
	int testdocno=0;
	String strSql22="select dout,tout,fout,kmout,doc_no from gl_vmove where fleet_no='"+fleet+"' and status='OUT' ";
	ResultSet rs22=stmt.executeQuery(strSql22);
	while(rs22.next()){
		testfout=rs22.getDouble("fout");
		testdout=rs22.getDate("dout");
		testtout=rs22.getString("tout");
		testkmout=rs22.getDouble("kmout");
		testdocno=rs22.getInt("doc_no");
		System.out.println("IN INFO"+testfout+testdout+testtout+testkmout+testdocno);
	}
	double totalfuel=Double.parseDouble(fuel)-testfout;
	double totalinkm=Double.parseDouble(km)-testkmout;
	double totaltime=0.0;
	String sql222="select TIMESTAMPDIFF(SECOND,ts_din,ts_dout)/60 totalmin from (select  cast(concat('"+date1+"',' ','"+time+"') as datetime) ts_din,"+
" cast(concat('"+testdout+"',' ','"+testtout+"')as datetime)ts_dout from gl_vmove where doc_no='"+testdocno+"') m";
	System.out.println("First Idle Query in Ajax Mv:"+sql222);
	ResultSet rs222=stmt.executeQuery(sql222);
	while(rs222.next()){
		totaltime=rs222.getDouble("totalmin");
		System.out.println("TOTAL TIME"+totaltime);
	}
	String strSql = "update gl_vmove set din='"+date1+"',tin='"+time+"',kmin='"+km+"',fin='"+fuel+"',status='IN',trancode='DL',ibrhid='"+branch+"',ilocid='"+location+"',"+
	" ttime='"+totaltime+"',tkm='"+totalinkm+"',tfuel='"+totalfuel+"' where fleet_no='"+fleet+"' and rdtype='MOV' and status='OUT'"; 
	System.out.println(strSql);
	int rs = stmt.executeUpdate(strSql);
	String test1="select max(doc_no)+1 docNo from gl_vmove";
	String test2="select max(doc_no) parentdoc from gl_vmove where fleet_no="+fleet;
	
	ResultSet testrs=stmt.executeQuery(test1);
	if(testrs.next()){
		testdoc=testrs.getString("docNo");
	}
	ResultSet testrs2=stmt.executeQuery(test2);
	if(testrs2.next()){
		testparent=testrs2.getString("parentdoc");
	}
	
	String tin1="";
	java.sql.Date din1=null;
	String sqlcollectin="select tin tin1,din din1 from gl_vmove where doc_no='"+testparent+"'";
	System.out.println("Sql Delivery "+sqlcollectin);
	ResultSet rscollect=stmt.executeQuery(sqlcollectin);
	while(rscollect.next()){
		tin1=rscollect.getString("tin1");
		din1=rscollect.getDate("din1");
		System.out.println("Delivery Time and Date"+tin1+din1);
	}
	double ideal=0.0;
	String sqlcollecttimediff="select TIMESTAMPDIFF(SECOND,ts_dout,ts_din)/60 tmin from (select  cast(concat('"+din1+"',' ','"+tin1+"') as datetime) ts_din,"+
			" cast(concat('"+date1+"',' ','"+time+"')as datetime)ts_dout from gl_vmove where doc_no='"+testparent+"') m";
	System.out.println("Delivery Time Diff"+sqlcollecttimediff);
	ResultSet rscollecttime=stmt.executeQuery(sqlcollecttimediff);
	if(rscollecttime.next()){
		ideal=rscollecttime.getDouble("tmin");
		System.out.println("IDEAL"+ideal);
	}
	String strsql2="insert into gl_vmove(doc_no,date,fleet_no,rdocno,rdtype,trancode,status,parent,dout,tout,kmout,fout,obrhid,olocid,tideal,emp_id,emp_type)values('"+testdoc+"','"+date1+"',"+
			"'"+fleet+"','"+doc+"','MOV','"+trancode+"','OUT','"+testparent+"','"+date1+"','"+time+"','"+km+"','"+fuel+"','"+branch+"','"+location+"','"+ideal+"',"+driver+",'DRV')";
	System.out.println(strsql2);
	if(rs>0){
		Statement stmtnrm=conn.createStatement();
			String strnrmupdate="update gl_nrm set delivery=1 where doc_no="+doc;
			int nrmupdate=stmtnrm.executeUpdate(strnrmupdate);
			if(nrmupdate>0){
				
			}
			else{
				conn.close();
			}
	
	
	
	%>
	
	document.getElementById("msg").value="Updated Successfully";
		<%
		System.out.println("Updation Success");
		System.out.println("RS"+rs);
	}
	else{%>
		document.getElementById("msg").value="Not Updated";
	
<%		System.out.println("Updation Error");
	}
	int rsinsert=stmt.executeUpdate(strsql2);
	if(rsinsert>0){
		System.out.println("Insertion Update");
	}
	else{
		System.out.println("Insertion Error");
	}
	response.getWriter().write(rsinsert+"");

	stmt.close();
	conn.close();
	
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>
	</script>
  