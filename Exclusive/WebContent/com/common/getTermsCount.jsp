<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>

<%	
ClsConnection ClsConnection=new ClsConnection();

	Connection conn = null;
	
	try{ 
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String dtype=request.getParameter("dtype").toString();
		String docno=request.getParameter("docno").toString();
		String brhid=request.getParameter("brhid").toString();
		String userid=session.getAttribute("USERID").toString().trim();
		
		
		String strSql ="select count(*) as count  from my_trterms where dtype='"+dtype+"' and rdocno='"+docno+"' and brhid='"+brhid+"'";
		
		//System.out.println("==strSql==="+strSql);
		
		ResultSet rs = stmt.executeQuery(strSql);
		int count=0;
		if(rs.next()) {
			count=rs.getInt("count");
	  		} 
		
		 
		response.getWriter().write(count+"####"+dtype);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>