<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>

<%	
	ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	
	try{

		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
		
		String strSql = "select m.description,p.email,p.excel from gl_bibd m inner join my_powrbi p on p.dno=m.doc_no left join my_user u on (u.role_id=p.roleid) where m.status=1 and p.permission=1 and m.doc_no="+docno+" and u.doc_no='"+session.getAttribute("USERID").toString()+"'";
		System.out.println(" ========== "+strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		
		int email=0;
		int excel=0;
		while(rs.next()) {
			email=rs.getInt("email");
			excel=rs.getInt("excel");
		} 
		
		response.getWriter().write(email+"##"+excel);
		
		stmt.close();
		conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	} finally{
		conn.close();
	}
  %>
  