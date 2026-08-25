<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
ClsConnection ClsConnection=new ClsConnection();


	Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String code=request.getParameter("code");
		String name=request.getParameter("name");
		String accno=request.getParameter("accno");
		String dtype=request.getParameter("dtype");
		
		String strSql = "select sal_code from my_salesman where sal_type='"+dtype+"' and sal_code='"+code+"' and status<>7";
		ResultSet rs = stmt.executeQuery(strSql);
		String codestatus="",namestatus="",acnostatus="";
		if(rs.next()){
			codestatus="1";
		}
		String strSql2="select sal_name from my_salesman where sal_type='"+dtype+"' and sal_name='"+name+"' and status<>7";
		ResultSet rs2=stmt.executeQuery(strSql2);
		if(rs2.next()){
			namestatus="1";
		}
		String strsql3="select acc_no from my_salesman where sal_type='"+dtype+"' and acc_no="+accno+" and status<>7";
		ResultSet rs3=stmt.executeQuery(strsql3);
		if(rs3.next()){
			acnostatus="1";
		}
		
		response.getWriter().write(codestatus+"***"+namestatus+"***"+acnostatus);
		
		stmt.close();
	 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>