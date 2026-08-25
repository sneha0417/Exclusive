<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%
    String assessmentyear=request.getParameter("assessmentyear")==null?"0":request.getParameter("assessmentyear");
 	System.out.println("in"+assessmentyear);  
    Connection conn = null;
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	ClsCommon commonDAO = new ClsCommon();   
	Statement stmt = conn.createStatement ();  
	int val=0;
	java.sql.Date sqlAssessmentDate = null;
    
    if(!(assessmentyear.equalsIgnoreCase("undefined")) && !(assessmentyear.equalsIgnoreCase("")) && !(assessmentyear.equalsIgnoreCase("0"))){
   	 sqlAssessmentDate = commonDAO.changeStringtoSqlDate(assessmentyear);
    }
	 String strSql = "select rowno from (select rowno from my_budgetdetail where month(date_add('"+sqlAssessmentDate+"', interval 0 month))=month and year(date_add('"+sqlAssessmentDate+"', interval 0 month))=year union all select rowno from my_budgetdetail where month(date_add('"+sqlAssessmentDate+"', interval 1 month))=month and year(date_add('"+sqlAssessmentDate+"', interval 0 month))=year union all select rowno from my_budgetdetail where month(date_add('"+sqlAssessmentDate+"', interval 2 month))=month and year(date_add('"+sqlAssessmentDate+"', interval 0 month))=year union all select rowno from my_budgetdetail where month(date_add('"+sqlAssessmentDate+"', interval 3 month))=month and year(date_add('"+sqlAssessmentDate+"', interval 0 month))=year union all select rowno from my_budgetdetail where month(date_add('"+sqlAssessmentDate+"', interval 4 month))=month and year(date_add('"+sqlAssessmentDate+"', interval 0 month))=year union all select rowno from my_budgetdetail where month(date_add('"+sqlAssessmentDate+"', interval 5 month))=month and year(date_add('"+sqlAssessmentDate+"', interval 0 month))=year union all select rowno from my_budgetdetail where month(date_add('"+sqlAssessmentDate+"', interval 6 month))=month and year(date_add('"+sqlAssessmentDate+"', interval 0 month))=year union all select rowno from my_budgetdetail where month(date_add('"+sqlAssessmentDate+"', interval 7 month))=month and year(date_add('"+sqlAssessmentDate+"', interval 0 month))=year union all select rowno from my_budgetdetail where month(date_add('"+sqlAssessmentDate+"', interval 8 month))=month and year(date_add('"+sqlAssessmentDate+"', interval 0 month))=year union all select rowno from my_budgetdetail where month(date_add('"+sqlAssessmentDate+"', interval 9 month))=month and year(date_add('"+sqlAssessmentDate+"', interval 0 month))=year union all select rowno from my_budgetdetail where month(date_add('"+sqlAssessmentDate+"', interval 10 month))=month and year(date_add('"+sqlAssessmentDate+"', interval 0 month))=year union all select rowno from my_budgetdetail where month(date_add('"+sqlAssessmentDate+"', interval 11 month))=month and year(date_add('"+sqlAssessmentDate+"', interval 0 month))=year)a";   
	//System.out.println("strSqlval--------->>>"+strSql);           
	ResultSet rs = stmt.executeQuery(strSql);       
   
	if(rs.next()) {      
		val=1;
  		}   
	
	stmt.close();
	conn.close();  

	response.getWriter().print(val);         
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>