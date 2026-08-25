<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
	String psrno=request.getParameter("psrno").toString();
   System.out.println("psrno="+psrno);
	String brch=session.getAttribute("BRANCHID").toString();
	ClsConnection ClsConnection=new ClsConnection();
 	Connection conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	String strSql = "select m.part_no,m.productname,m.doc_no,u.unit,m.munit from my_main m left join my_unitm u on m.munit=u.doc_no where m.status=3 and  m.doc_no="+psrno+"";
	ResultSet rs = stmt.executeQuery(strSql);
	String productname="";
	String unit="";
	String munit="";
	String docno="";
	while(rs.next()) {
		productname=rs.getString("productname");
		unit=rs.getString("unit");
		munit=rs.getString("munit");
  		} 
	
	System.out.println(productname+"krishnan"+unit+"krishnan"+munit);
	response.getWriter().write(productname+"####"+unit+"####"+munit);
	
	
	stmt.close();
	conn.close();
  %>
  
