<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
	Connection conn = null;

	try{
		
		ClsConnection connDAO = new ClsConnection();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		String sql = "";
		int AlreadyExists=0;

		String chequeno=request.getParameter("chequeno");
		String bankacno=request.getParameter("bankacno");
		String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
		String mode=request.getParameter("mode");
	    //System.out.println("mode="+mode+"docno="+docno);
	    
		if(mode.equalsIgnoreCase("A") && docno.equalsIgnoreCase("")){
	        sql = "select * from my_chqbm m left join my_chqdet d on m.tr_no=d.tr_no left join my_chqbd de on de.tr_no=m.tr_no and sr_no=0 "
	    		+ "where m.status=3 and m.chqno=d.chqno and d.chqno='"+chequeno+"' and de.acno="+bankacno+"";
		}else if(mode.equalsIgnoreCase("EDIT") && !(docno.equalsIgnoreCase(""))){
			sql = "select * from my_chqbm m left join my_chqdet d on m.tr_no=d.tr_no left join my_chqbd de on de.tr_no=m.tr_no and sr_no=0 "
		    	+ "where m.status=3 and m.chqno=d.chqno and d.chqno='"+chequeno+"' and de.acno="+bankacno+" and doc_no!="+docno+"";
		}else{}
		
		if(!sql.equals("")){
			 ResultSet rs = stmt.executeQuery(sql);
			 while(rs.next()) {
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
  