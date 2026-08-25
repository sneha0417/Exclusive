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
		
		String strSql = "SELECT CONCAT(compname,' / ',branchname) compbranch,doc_no intrcompid, brhid intrbrhid,dbname FROM intercompany.my_intrcomp WHERE status=3 and cmpid='"+session.getAttribute("COMPANYID")+"' and brhid='"+session.getAttribute("BRANCHID")+"'";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String compBranch="",intrCompId="",intrBrhId="",dbName="";
		while(rs.next()) {
					compBranch+=rs.getString("compbranch")+",";
					intrCompId+=rs.getString("intrcompid")+",";
					intrBrhId+=rs.getString("intrbrhid")+",";
					dbName+=rs.getString("dbname")+",";
				} 
		
		String brn[]=compBranch.split(",");
		String intrCmpId[]=intrCompId.split(",");
		String intrBrId[]=intrBrhId.split(",");
		String dbNme[]=dbName.split(",");
		
		compBranch=compBranch.substring(0, compBranch.length()-1);
		intrCompId=intrCompId.substring(0, intrCompId.length()-1);
		intrBrhId=intrBrhId.substring(0, intrBrhId.length()-1);
		dbName=dbName.substring(0, dbName.length()-1);
		
		response.getWriter().write(intrCompId+"####"+compBranch+"####"+intrBrhId+"####"+dbName);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  