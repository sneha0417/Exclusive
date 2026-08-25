<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
ClsConnection ClsConnection=new ClsConnection();

	Connection conn = null;
	
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String brch=request.getParameter("branch");
		
		String strSq = "select multiCur from my_brch where doc_no='"+brch+"'";
		ResultSet rs1 = stmt.executeQuery(strSq);
		
		int multi = 0;
		while(rs1.next()){
			multi = rs1.getInt("multiCur");
		}
		
		String strSql ="";
		
		if(multi==0){
			strSql = "select b.mclose,c.doc_no,c.code,c.type from my_brch b inner join my_curr c on(c.doc_no=curId) where c.status <> 7 and b.doc_no='"+brch+"'";
			//strSql = "select b.curid,b.mclose,c.code from my_brch b inner join my_curr c on(c.doc_no=curId) where b.doc_no ='"+brch+"'";
		}else{
			strSql = "select doc_no,code,type,(select mclose from my_brch where doc_no='"+brch+"') mclose from my_curr where status <> 7";
		}
		
		ResultSet rs = stmt.executeQuery(strSql);
		
		String currId="",mClose="",currCode="",curtype="";
		while(rs.next()) {
		         	currId+=rs.getString("doc_no")+",";
		        	mClose+=rs.getString("mclose")+",";
		        	currCode+=rs.getString("code")+",";
		        	curtype+=rs.getString("type")+",";
		}
			   
	    String curId[]=currId.split(",");
	    String mClosed[]=mClose.split(",");
	    String curCode[]=currCode.split(",");
	    String currtype[]=curtype.split(",");
		
	    currId=currId.substring(0, currId.length()-1);
	    mClose=mClose.substring(0, mClose.length()-1);
	    currCode=currCode.substring(0, currCode.length()-1);
	    curtype=curtype.substring(0, curtype.length()-1);
	   
	    response.getWriter().write(currId+"####"+mClose+"####"+currCode+"####"+curtype+"####"+multi);
		
	     session.setAttribute("CURRENCY", currId);
	    session.setAttribute("CURRENCYCODE", currCode);
	    session.setAttribute("BRANCHID", brch); 
	   // session.setAttribute("BRANCHNAME", brch);
	    session.setAttribute("MONTHCLOSED", mClose);
	    session.setAttribute("CURRENCYTYPE", currtype[0]);
	    
	    stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
