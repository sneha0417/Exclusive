<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession" %>


<%	 
ClsConnection conobj= new ClsConnection();
	/* String brch=session.getAttribute("BRANCHNAME").toString();

	System.out.println("===brch===="+brch); */

 	Connection conn = conobj.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select c.doc_no as curid,c.code from  my_curr c where status=3 ";
	
	System.out.println("===strSql===currency="+strSql);
	
	ResultSet rs = stmt.executeQuery(strSql);
	String currId="",mClose="",currCode="";
	while(rs.next()) {
	         	currId+=rs.getString("curid")+",";
	        	currCode+=rs.getString("code")+",";
	}
		   
    System.out.println("curr code "+currCode);

    String curId[]=currId.split(",");
    String curCode[]=currCode.split(",");
	
    currId=currId.substring(0, currId.length()-1);
    currCode=currCode.substring(0, currCode.length()-1);
   
    response.getWriter().write(currId+"####"+currCode);
	
  
	stmt.close();
	conn.close();
  %>
  
