<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		int AlreadyExists=0;

		String chequeno=request.getParameter("chequeno");
		String bankacno=request.getParameter("bankacno");
		String docno=request.getParameter("docno");
		
		String sql = "select * from my_unclrchqbm m left join my_unclrchqbd d  on (d.rdocno=m.doc_no and m.bpvno=0 and d.sr_no=0) where m.status=3 "
				+ "and m.chqno='"+chequeno+"' and d.acno="+bankacno+" and m.doc_no!="+docno+"";
		ResultSet rs = stmt.executeQuery(sql);
			
		while(rs.next()) {
			AlreadyExists=1;
		} 
		
		if(AlreadyExists==0){
			
		    String sql1 = "select * from my_chqbm m left join my_chqdet d on m.tr_no=d.tr_no left join my_chqbd de on de.tr_no=m.tr_no and sr_no=0 "
		    		+ "where m.status=3 and m.chqno=d.chqno and d.chqno='"+chequeno+"' and de.acno="+bankacno+" and m.doc_no!="+docno+"";
		    ResultSet rs1 = stmt.executeQuery(sql1);
			
			while(rs1.next()) {
				AlreadyExists=1;
			} 
			
		}
		
		response.getWriter().print(AlreadyExists);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  