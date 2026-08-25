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
	
	
	String strSql = "select s.doc_no,s.sal_name,u.user_id username,s.catid,s.usgper,s.userid userdoc from my_salm s left join my_user u on u.doc_no=s.userid where s.status=3 and s.userid="+session.getAttribute("USERID").toString()+"";
	
	System.out.println("--strSql--"+strSql);
	
	ResultSet rs = stmt.executeQuery(strSql);
	String salesman ="";
	String username ="";
	int catid=0;
	double usgper=0;
	int userdoc=0;
	int saldocno=0;
 
	if(rs.next ()) {
		saldocno=rs.getInt("doc_no");
		catid=rs.getInt("catid");
		userdoc=rs.getInt("userdoc");
		salesman=rs.getString("sal_name");
		username=rs.getString("username");
		
		usgper=rs.getDouble("usgper");
		
		 
	}
	
	stmt.close();
	conn.close();

	response.getWriter().print(saldocno+"##"+catid+"##"+userdoc+"##"+salesman+"##"+username+"##"+usgper+"##");
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>