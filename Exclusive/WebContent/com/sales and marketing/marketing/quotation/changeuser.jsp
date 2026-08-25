 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsEncrypt" %>

<%        
ClsEncrypt ClsEncrypt=new ClsEncrypt();
      String userids=request.getParameter("userids")==null?"0":request.getParameter("userids");

	 String pass_wordss=request.getParameter("pass_wordss")==null?"0":request.getParameter("pass_wordss");
 
	    String userName=userids;
		String passWord=pass_wordss;


 	Connection conn = null;
try{	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int val=0;
	
	passWord=ClsEncrypt.getInstance().encrypt(passWord);
	
	
	String strSql = "select * from my_user where user_id='"+userName+"' and pass='"+passWord+"'";
	
	System.out.println("--strSql--"+strSql);
	
	ResultSet rs = stmt.executeQuery(strSql);
	int userid=0;
	if(rs.next ()) {
		userid=rs.getInt("doc_no");
		 
	}
	
	String strSql1 = "select usgper,catid from my_salm where userid='"+userid+"'";
	
	System.out.println("--strSql1--"+strSql1);
	
	ResultSet rs1 = stmt.executeQuery(strSql1);
	double discper=0;
	
	int catid=0;
	
	if(rs1.next ()) {
		discper=rs1.getDouble("usgper");
		catid=rs1.getInt("catid");
	}
	
	
	
	stmt.close();
	conn.close();

	response.getWriter().print(userid+"::"+discper+"::"+catid);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>