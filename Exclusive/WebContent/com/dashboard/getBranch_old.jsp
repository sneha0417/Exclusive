<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();

	Connection conn = null;
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		
		String strSql = " select b.branchname,b.doc_no from my_brch b  left join my_user u on u.doc_no='"+session.getAttribute("USERID") +"' " 
				+" left join my_usrbr ub on ub.user_id=u.doc_no and ub.brhid=b.doc_no and u.permission=1 "
				+" where b.cmpid='"+session.getAttribute("COMPANYID")+"' and  if(u.permission=1,ub.user_id,'"+session.getAttribute("USERID") +"')='"+session.getAttribute("USERID") +"'  and  b.status<>7";      
				
		// System.out.println("-----------"+strSql);
		
		ResultSet rs = stmt.executeQuery(strSql);
		
		String brnch="",brnchId="";
		while(rs.next()) {
					brnch+=rs.getString("branchname")+",";
					brnchId+=rs.getString("doc_no")+",";
				} 
		
		String brn[]=brnch.split(",");
		String brnId[]=brnchId.split(",");
		
		brnch=brnch.substring(0, brnch.length()-1);
		brnchId=brnchId.substring(0, brnchId.length()-1);
		
		response.getWriter().write(brnchId+"####"+brnch);
		session.setAttribute("BRANCHID", brnId[0]);
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  