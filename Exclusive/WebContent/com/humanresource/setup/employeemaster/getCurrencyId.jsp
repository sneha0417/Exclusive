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
		
		String brch=session.getAttribute("BRANCHID").toString();
		
		String strSq = "select multiCur from my_brch where doc_no='"+brch+"'";
		ResultSet rs1 = stmt.executeQuery(strSq);

		int multi = 0;
		while(rs1.next()){
		multi = rs1.getInt("multiCur");
		}
		String strSql ="";
		if(multi==0){
			strSql = "select c.doc_no,c.code from my_brch b inner join my_curr c on(c.doc_no=curId) where c.status <> 7 and b.doc_no='"+brch+"'";
		}else{
			strSql = "select doc_no,code from my_curr where status <> 7";
		}
		ResultSet rs = stmt.executeQuery(strSql);
		String curid="";
		String curcode="";
		
		while(rs.next()) {
			curid+=rs.getInt("doc_no")+",";
			curcode+=rs.getString("code")+",";
	  		} 
		
		curid=curid.substring(0, curid.length()>0?curid.length()-1:0);
		curcode=curcode.substring(0, curcode.length()>0?curcode.length()-1:0);

		response.getWriter().write(curid+"####"+curcode+"####"+multi);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
