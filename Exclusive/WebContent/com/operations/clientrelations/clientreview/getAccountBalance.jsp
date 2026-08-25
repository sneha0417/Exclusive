<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
	Connection conn = null;

	try{
		ClsConnection connDAO = new ClsConnection();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String accountno=request.getParameter("accountno");
		String cldocno=request.getParameter("cldocno");

		String strSql = "select sum(round(dramount,2)) balance from my_jvtran where status=3 and yrid=0 and acno="+accountno+"";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String balance="0.00";
		while(rs.next()) {
			balance=rs.getString("balance");
		} 
		
		String strSql1 = "select pcase from my_acbook where status=3 and dtype='CRM' and cldocno="+cldocno+"";
		ResultSet rs1 = stmt.executeQuery(strSql1);
		
		String status="";
		while(rs1.next()) {
			status=rs1.getString("pcase");
		} 
		
		if(status.equalsIgnoreCase("1")){
			status="Litigation";
		} else if(status.equalsIgnoreCase("2")){
			status="Dispute";
		} else if(status.equalsIgnoreCase("3")){
			status="Bad Debts";
		} else {
			status="Active";
		}
		
		response.getWriter().write(balance+"####"+status);
		
		stmt.close();
		conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	} finally{
		conn.close();
	}
  %>
  