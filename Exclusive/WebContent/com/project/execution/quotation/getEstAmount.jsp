<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% 
 String enqid =request.getParameter("enqid")==null?"0":request.getParameter("enqid").toString();

	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		String 	estamnt="0",doc_no="0";
		
		int rs=0;
		String str1Sql=("SELECT round(est.nettotal,2) estamt FROM cm_prjestm est where est.reftrno="+enqid+" ");
		System.out.println("str1Sql====="+str1Sql);
		
		ResultSet rst=stmt.executeQuery(str1Sql);
while(rst.next())
{

	estamnt=rst.getString("estamt");

}
System.out.println("estamnt====="+estamnt);
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
  