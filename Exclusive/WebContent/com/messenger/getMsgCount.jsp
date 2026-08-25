<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%	

	//String brch=request.getParameter("branch");
	/* String usertoid=request.getParameter("usertoid").toString().trim(); */
	String userfrmid=session.getAttribute("USERID").toString().trim();
	//System.out.println("======userfrmid==="+userfrmid);
	ClsConnection ClsConnection=new ClsConnection();

	String strSql ="",user="";
	int msgcnt=0;
	int cnt=0;
		 strSql ="select distinct coalesce(u.user_id,'')  as user,(select count(*) from my_mesngr n left join my_user v on(n.userfrm=v.doc_no) where n.is_read=0 and userto='"+userfrmid+"') as  msgcount from my_mesngr m inner join my_user u on(m.userfrm=u.doc_no) where m.is_read=0 and userto='"+userfrmid+"' ";	
	
	//System.out.println("===strSql===="+strSql);
 	Connection conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	ResultSet rs = stmt.executeQuery(strSql);
	
	while(rs.next()) {
		
			if(cnt==0){
				user=rs.getString("user");
				msgcnt=rs.getInt("msgcount");
			}
			else{
				user=user+","+rs.getString("user");
				msgcnt=rs.getInt("msgcount");
			}
			cnt++;
	}
	

	
    response.getWriter().write(user+"####"+msgcnt);
    
   
	stmt.close();
	conn.close();
	
  %>
  
