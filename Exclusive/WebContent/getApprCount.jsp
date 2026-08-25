<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession" %>


<%	
ClsConnection ClsConnection=new ClsConnection();

	Connection conn = null;
	
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		Statement stmt1 = conn.createStatement();
		
		String docno=request.getParameter("docno");
		String dtype=request.getParameter("dtype");
		String brch=request.getParameter("brch");
		String usrid=request.getParameter("usrid");
		String mtable="0";
		int tstatus=0;
		int iuser=0;
		
		
		String glconfig="select method from gl_config where field_nme='approve'";
		
		ResultSet rsc = stmt.executeQuery(glconfig);
		
		int isglconfig=0;
		while(rsc.next()) {
			isglconfig=rsc.getInt("method");
	  		} 
		
		if(isglconfig>0){
		 String strSql1 = "Select count(*) as isaaprval from  my_exdoc where dtype='"+dtype+"' and userid="+usrid+"  ";
		 ResultSet rs1 = stmt.executeQuery(strSql1);
		
		int isaaprval=0;
		while(rs1.next()) {
			isaaprval=rs1.getInt("isaaprval");
			
	  		} 
		
		
		String strSql = " select coalesce(count(*),0) as count from  my_exeb dt  "+
		" where dt.dtype='"+dtype+"' and dt.userid="+usrid+" and dt.brhId="+brch+" and dt.doc_no='"+docno+"'";
				
		ResultSet rs = stmt.executeQuery(strSql);
		int count=0;
		while(rs.next()) {
			count=rs.getInt("count");
	  		} 
		
		
		String strSql2 = " select coalesce(count(*),0) as count from  my_exdet dt   where dt.dtype='"+dtype+"'  and dt.brhId="+brch+" and dt.doc_no='"+docno+"'";
		
		ResultSet rs2 = stmt.executeQuery(strSql2);
		
		int firstappr=0;
		while(rs2.next()) {
			firstappr=rs2.getInt("count");
			
	  		}
		
		String strSql22 = "select coalesce(count(*),0) as count from  my_exdet dt   where dt.apprstatus=2 and dt.dtype='"+dtype+"'  and dt.brhId="+brch+" and dt.doc_no='"+docno+"'";
		// System.out.println("===== sql = "+strSql22);
		ResultSet rs22 = stmt.executeQuery(strSql22);
		
		int returned=0;
		while(rs22.next()) {
			returned=rs22.getInt("count");
	  		}
		 if(returned>0){		firstappr=0;}
		
		
		String strSql3 = "select msttable as mtbl,transtype from win_tbldet where dtype='"+dtype+"'";
		
		ResultSet rs3 = stmt.executeQuery(strSql3);
		String transtype="";
		
		while(rs3.next()) {
				mtable=rs3.getString("mtbl")==null?"0":rs3.getString("mtbl");
				transtype=rs3.getString("transtype");
	  		}

		if(!(mtable.equalsIgnoreCase("0"))){
			
		/* 	String strSql4 = "select count(*) as count,userid from  "+mtable+"  where dtype='"+dtype+"' and brhId="+brch+" and "+transtype+"='"+docno+"' and status=0";
			// System.out.println("====need =="+strSql4);
			ResultSet rs4 = stmt.executeQuery(strSql4);
			
			while(rs4.next()) {
				tstatus=rs4.getInt("count");
				iuser=rs4.getInt("userid");
		  		}
		 */		
		}
		int sessionuid=Integer.parseInt(session.getAttribute("USERID").toString().trim());
		
		
		
		/* if((returned>0) || (firstappr==0 && sessionuid==iuser) ){
			isaaprval=1;
			firstappr=0;
		}
		 
		*/
		//System.out.println("===== firstappr==0 && sessionuid==iuser = "+firstappr+"==="+sessionuid+"=="+iuser+"==="+returned);
		 //System.out.println("===== firstappr==0 && sessionuid==iuser = "+(firstappr==0 && sessionuid==iuser));
		if(firstappr==0 && sessionuid==iuser ){
			isaaprval=1;
		}
		 
		int aprval=tstatus>0?tstatus:isaaprval;
		
		int isaproved=firstappr==0?aprval:count;
		// System.out.println("===== isaproved"+isaproved+"####"+dtype+"####"+firstappr);
		if(mtable.equalsIgnoreCase("0")){
			
		/* String strSq99 = "select * from  "+mtable+"  where dtype='"+dtype+"' and brhId="+brch+" and "+transtype+"='"+docno+"' and status=3";
		 // System.out.println("====need =="+strSq99);
		ResultSet rs99 = stmt.executeQuery(strSq99);
		
		while(rs99.next()) {
			// tstatus=rs99.getInt("count");
			// iuser=rs99.getInt("userid"); 
			isaproved=0;
	  		}
 */
		}
		response.getWriter().write(isaproved+"####"+dtype+"####"+firstappr);
		}
		else{
			response.getWriter().write(0+"####"+""+"####"+0);
		}
		 
		stmt.close();
		conn.close();
		// System.out.println("===== isaproved");
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		// conn.close();
	}
  %>
  
