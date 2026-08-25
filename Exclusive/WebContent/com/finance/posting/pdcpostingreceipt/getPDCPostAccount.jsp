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
		
		String strSql = "select coalesce(h.doc_no,0) doc_no,coalesce(h.account,'') account,coalesce(h.description,'') description,coalesce(h.atype,'GL') atype,coalesce(h.curid,1) curid,"
				+ "coalesce(h.rate,1) rate,coalesce(cr.type,'M') type from my_account c left join my_head h on c.acno=h.doc_no left join my_curr cr on cr.doc_no=h.curId where c.codeno='PDCPOSTACCOUNT'";
		
	    ResultSet rs = stmt.executeQuery(strSql);
		
		String docno="",account="",description="",atype="",curid="",rate="",type="";
		while(rs.next()) {
					docno=rs.getString("doc_no");
					account=rs.getString("account");
					description=rs.getString("description");
					atype=rs.getString("atype");
					curid=rs.getString("curid");
					rate=rs.getString("rate");
					type=rs.getString("type");
				} 
		
		response.getWriter().write(docno+"####"+account+"####"+description+"####"+atype+"####"+curid+"####"+rate+"####"+type);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  