<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
String masterdoc_no=request.getParameter("masterdoc_no")==null?"0":request.getParameter("masterdoc_no");
int tr_no=0;

Connection conn = null;
try{
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int val=0;
	String strSql2 = "select * from cr_qotm m left join cr_qotd d on m.doc_no=d.rdocno"
			+" left join cr_enqm em on m.rrefno=em.doc_no  and m.reftype='ENQ' "
			+" left join cr_enqd ed on em.doc_no=ed.rdocno and ed.doc_no=d.refdocno "
			+" left join cr_joblist l on l.enqdocno=ed.doc_no left join cm_srvcontrm ct on l.jobno=ct.tr_no "
			+" left join cr_cfim cm on cm.refno=ct.tr_no "
			+" where m.doc_no='"+masterdoc_no+"' and ct.tr_no is not null";
	
	
	System.out.println("==strSql2=="+strSql2);
	ResultSet rs1 = stmt.executeQuery(strSql2);
	if(rs1.next()) {
		val=1;
	}
	
	
	
	
	System.out.println("==val=="+val);
	stmt.close();
	conn.close();
	response.getWriter().print(val);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
%>