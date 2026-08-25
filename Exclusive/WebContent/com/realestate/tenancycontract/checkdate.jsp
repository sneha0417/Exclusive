 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>


<%
   
      String fromdate=request.getParameter("fromdate")==null?"0":request.getParameter("fromdate");

String txtpropertydocno=request.getParameter("txtpropertydocno")==null?"0":request.getParameter("txtpropertydocno");

ClsCommon ClsCommon=new ClsCommon();
 
 	Connection conn = null;
try{	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int val=0;
	   
	
	
    java.sql.Date  sqlStartDate = null;
		if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
  	{
  	sqlStartDate = ClsCommon.changeStringtoSqlDate(fromdate);
  	}
  	
		int cont_no=0;
		 java.sql.Date  condate = null;
		 
		 String strSql21 = "select cnt_date,cnt_no from rl_propertymaster where   status=3 and doc_no='"+txtpropertydocno+"' ";
			
		 System.out.println("==strSql21=="+strSql21);
		ResultSet rs11 = stmt.executeQuery(strSql21);

		if(rs11.next()) {
			 
			cont_no=rs11.getInt("cnt_no");
			condate=rs11.getDate("cnt_date");
			
			
			} 
		 
		 if(cont_no>0)
		 {
			 int no=0;
			String sqlss=" select   DATEDIFF( '"+condate+"','"+sqlStartDate+"') val     "  ;
			 System.out.println("==sqlss=="+sqlss);
			ResultSet rs111 = stmt.executeQuery(sqlss);
			
			if(rs111.next()) {
				 
				no=rs111.getInt("val");
				
				
				} 
			
			
			if(no>=0)
			{
				val=1;
			}
			else
			{
				val=0;
			}
			
			
			
			
			
			
		 }
		 else
		 {
			 val=0;
		 }
		
		
	 
		
	
 
/* 	 
	 String strSql21 = "select * from rl_tncm where  pstatus>0 and doc_no='"+masterdoc_no+"' ";
	
	 System.out.println("==strSql21=="+strSql21);
	ResultSet rs11 = stmt.executeQuery(strSql21);

	if(rs11.next()) {
		val=1;
		} 
	 
	
	

	 
	String strSql2 = "select * from rl_tncpayment where refno>0 and rdocno='"+masterdoc_no+"' ";
	
	
	
	 
	ResultSet rs1 = stmt.executeQuery(strSql2);

	if(rs1.next()) {
		val=1;
 		} 
	 
	 */
	 
		
	 
	

	
	stmt.close();
	conn.close();
	 System.out.println("--in-val--"+val);
	response.getWriter().print(val);
}
catch(Exception e){
	e.printStackTrace();
	response.getWriter().print(0);
	conn.close();
}
finally{
	conn.close();
}
	%>