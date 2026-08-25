<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% 
 String masterdoc =request.getParameter("masterdoc")==null?"0":request.getParameter("masterdoc").toString();
 
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		String 	date="",doc_no="",voc_no="",enqdoc_no="",enqvoc_no="",name="",clientid="",details="",cperson="",cpersonid="",contmob="",survey="",surveyid="",remarks="",excontr="";
		java.sql.Date sdate=null;
		java.sql.Date edate=null;
		String branchid=session.getAttribute("BRANCHID").toString();
		int rs=0;
		String str1Sql=("select m.date,m.doc_no,m.voc_no,m.refdocno enqdoc_no,m.refvocno enqvoc_no,ac.refname as name,coalesce(ac.doc_no,0) as clientid,"
				+ "concat(coalesce(ac.address,''),',',coalesce(ac.com_mob,'') ,',',coalesce(ac.mail1,'') ) as details,"
				+ "coalesce(c.cperson,'') as cperson,coalesce(c.row_no,'') as cpersonid,coalesce(c.mob,'') as contmob,em.name survey,em.doc_no as surveyid,m.remarks,excontr from cm_surveym m left join my_acbook ac "
				+ "on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_crmcontact c on(c.row_no=m.cpersonid) left join hr_empm em on(m.survby=em.doc_no) where 1=1 and m.voc_no="+masterdoc+" and m.brhid="+branchid+" and m.status=3  ");
ResultSet rst=stmt.executeQuery(str1Sql);
while(rst.next())
{
	date=rst.getString("date");
	doc_no=rst.getString("doc_no");
	voc_no=rst.getString("voc_no");
	enqdoc_no=rst.getString("enqdoc_no");
	enqvoc_no=rst.getString("enqvoc_no");
	name=rst.getString("name");
	clientid=rst.getString("clientid");
	details=rst.getString("details");
	cperson=rst.getString("cperson");
	cpersonid=rst.getString("cpersonid");
	contmob=rst.getString("contmob");
	survey=rst.getString("survey");
	surveyid=rst.getString("surveyid");
	remarks=rst.getString("remarks");
	excontr=rst.getString("excontr");
}
		response.getWriter().write(date+"###"+doc_no+"###"+voc_no+"###"+enqdoc_no+"###"+enqvoc_no+"###"+name+"###"+
clientid+"###"+details+"###"+cperson+"###"+cpersonid+"###"+contmob+"###"+survey+"###"+surveyid+"###"+remarks+"###"+excontr);

		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  