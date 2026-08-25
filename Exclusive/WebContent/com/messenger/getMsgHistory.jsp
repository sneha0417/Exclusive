<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
	//String brch=request.getParameter("branch");
	String usertoid=request.getParameter("usertoid").toString().trim();
	String userfrmid=session.getAttribute("USERID").toString().trim();
	String strSql ="",msg="";
	
	
		 strSql ="select concat(UPPER(uf.user_id),'  :',mesg ) as message from my_mesngr m inner join my_user uf on(uf.doc_no=userfrm) inner join my_user ut on(ut.doc_no=userto ) where  ut.doc_no in ('"+userfrmid+"','"+usertoid+"') and    uf.doc_no in ('"+userfrmid+"','"+usertoid+"')   order by m.doc_no";	
	
	//System.out.println("===strSql===="+strSql);
	ClsConnection ClsConnection=new ClsConnection();

 	Connection conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	ResultSet rs = stmt.executeQuery(strSql);
	
	while(rs.next()) {
		
				
					msg=msg+rs.getString("message")+"\n\n";
	}
	
	String updateSql = "update my_mesngr set is_read=1  where userfrm='"+usertoid+"' ";
	//System.out.println("strSql==update===="+strSql);
	int rsupdate = stmt.executeUpdate(updateSql);
	
    response.getWriter().write(msg);
	
   
	stmt.close();
	conn.close();
	
  %>
  
