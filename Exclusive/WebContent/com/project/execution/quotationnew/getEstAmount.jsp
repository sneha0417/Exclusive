<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% 
 String enqid =request.getParameter("enqid")==null?"0":request.getParameter("enqid").toString();
String dtype=request.getParameter("dtype")==null?"0":request.getParameter("dtype").trim().toString();
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		String 	estamnt="0",doc_no="0",conf="0";
		
		int rs=0;
		
		String str1Sql=("select round(sum(ed.total),2) estamt from cm_estmprdd ed left join cm_prjestm pm on ed.tr_no=pm.tr_no where pm.reftrno="+enqid+" and pm.ref_type='"+dtype+"'");  
		//System.out.println("str1Sql====="+str1Sql);
		
		ResultSet rst=stmt.executeQuery(str1Sql);
while(rst.next())
{

	estamnt=rst.getString("estamt");

}
// System.out.println("estamnt====="+estamnt);
		response.getWriter().write(estamnt+"###"+doc_no);
		

		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  