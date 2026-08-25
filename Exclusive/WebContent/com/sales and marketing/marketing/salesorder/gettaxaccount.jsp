

<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%@page import="com.common.*" %>


<%	
int method=0;

String name="";
double taxper=0;



String name1="";
double taxper1=0;
 

String name2="";
double taxper2=0;
int prvdocno=0;
int val=0;
int aa=0;
String dates=request.getParameter("date")==null?"NA":request.getParameter("date").trim();
String cmbbilltype=request.getParameter("cmbbilltype")==null?"NA":request.getParameter("cmbbilltype").trim();

ClsCommon ClsCommon=new ClsCommon();

System.out.println("----cmbbilltype------"+cmbbilltype);
System.out.println("----date------"+dates);

Connection conn = null;
try
{	ClsConnection ClsConnection=new ClsConnection();
  conn = ClsConnection.getMyConnection();

  
  java.sql.Date masterdate = null;
	if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0"))&&!(dates.equalsIgnoreCase("NA")))
	{
		masterdate=ClsCommon.changeStringtoSqlDate(dates);
		
	}
	else{
	 
Statement stmt=conn.createStatement();
		String chks="select curdate() date";
		ResultSet rs10=stmt.executeQuery(chks); 
		if(rs10.next())
		{
			
			masterdate=rs10.getDate("date");
		}

	}
	
  
Statement stmt=conn.createStatement();

String chk="select method  from gl_prdconfig where field_nme='tax'";
ResultSet rss=stmt.executeQuery(chk); 
if(rss.next())
{
	
	method=rss.getInt("method");
}

 if(method>0)
 {
		Statement pv=conn.createStatement();
	
		String dd="select prvdocno from my_brch where doc_no="+session.getAttribute("BRANCHID").toString()+" ";
		
		System.out.println("=======dd========"+dd);
		
		
		ResultSet rs13=pv.executeQuery(dd); 
		if(rs13.next())
		{

			prvdocno=rs13.getInt("prvdocno");
		}
		System.out.println("======prvdocno========"+prvdocno);

		 
		 String sql=" select value,case when 1="+cmbbilltype+"   then s.per when  2="+cmbbilltype+"  then s.cstper else 0 end as  'taxper' ,  s.tax_name,s.per,s.cstper "
				 +" from  gl_taxsubmaster s where s.doc_no=(select max(doc_no) tdocno from gl_taxsubmaster  where "
				 +"  fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and status=3 and type=2 and seqno=1 and provid='"+prvdocno+"' ) " 
				  + " and status=3 and type=2 and seqno=1 and provid='"+prvdocno+"'  " ;
		 
		 
		 
		 
		 System.out.println("=====sql====="+sql);
		 
		 
		 ResultSet rs1=stmt.executeQuery(sql); 
		 if(rs1.next())
		 {
			 aa=1;
			 name=rs1.getString("tax_name");
			 taxper=rs1.getDouble("taxper");
			 val=rs1.getInt("value");
		 	
		 	
		 }
	
		 
		 String sqls=" select case when 1="+cmbbilltype+"   then s.per when  2="+cmbbilltype+"  then s.cstper else 0 end as  'taxper' ,  s.tax_name,s.per,s.cstper "
				 +" from  gl_taxsubmaster s where s.doc_no=(select max(doc_no) tdocno from gl_taxsubmaster  where "
				 +"  fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and status=3 and type=2 and seqno=2 and provid='"+prvdocno+"' )  " 
				  +" and status=3 and type=2 and seqno=2 and provid='"+prvdocno+"' " ;
		 
		 System.out.println("=====sqls====="+sqls);
		 
		 ResultSet rs2=stmt.executeQuery(sqls); 
		 if(rs2.next())
		 {
			 aa=2;
			 name1=rs2.getString("tax_name");
			 taxper1=rs2.getDouble("taxper");
			 
		 	
		 	
		 }
	
		 
		 String sqlss=" select case when 1="+cmbbilltype+"   then s.per when  2="+cmbbilltype+"  then s.cstper else 0 end as  'taxper' ,  s.tax_name,s.per,s.cstper "
				 +" from  gl_taxsubmaster s where s.doc_no=(select max(doc_no) tdocno from gl_taxsubmaster  where "
				 +"  fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and status=3 and type=2 and seqno=3 and provid='"+prvdocno+"' )  " 
				  +" and status=3 and type=2 and seqno=3 and provid='"+prvdocno+"' " ;
		 
		 System.out.println("=====sqlss====="+sqlss);
		 
		 ResultSet rs21=stmt.executeQuery(sqlss); 
		 if(rs21.next())
		 {
			 aa=3;
			 name2=rs21.getString("tax_name");
			 taxper2=rs21.getDouble("taxper");
			 
		 	
		 	
		 }
	
	 
 }

	response.getWriter().print(method+"::"+aa+"::"+name+"::"+taxper+"::"+name1+"::"+taxper1+"::"+val+"::"+name2+"::"+taxper2);
	stmt.close();
	conn.close();
}
catch(Exception e)
{
	e.printStackTrace();
	conn.close();
}
  %>