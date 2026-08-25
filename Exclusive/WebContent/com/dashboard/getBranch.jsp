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
		
		String strSql = " select b.branchname,b.mclose,taxdate,b.doc_no,u.permission perm from my_brch b  left join my_user u on u.doc_no='"+session.getAttribute("USERID") +"' " 
				+" left join my_usrbr ub on ub.user_id=u.doc_no and ub.brhid=b.doc_no "
				+" where b.cmpid='"+session.getAttribute("COMPANYID")+"' and  if(u.permission=1,ub.user_id,'"+session.getAttribute("USERID") +"')='"+session.getAttribute("USERID") +"'  and  b.status<>7";      
				
		// System.out.println("-------strSql----"+strSql);
		
		ResultSet rs = stmt.executeQuery(strSql);
		
		String brnch="",brnchId="",perm="",mClose="",taxdate="";;
		while(rs.next()) {
					brnch+=rs.getString("branchname")+",";
					brnchId+=rs.getString("doc_no")+",";
					perm=rs.getString("perm");
					mClose+=rs.getString("mClose")+",";
					taxdate+=rs.getString("taxdate")+",";
				} 
		
		 // System.out.println("-------perm----"+perm);
		
		 CallableStatement s = conn.prepareCall("{CALL zz_spclear()}");
			int val = s.executeUpdate();
			// System.out.println("clear ===="+val);
			
		String brn[]=brnch.split(",");
		String brnId[]=brnchId.split(",");
		
		String mClosed[]=mClose.split(",");
		String taxdates[]=taxdate.split(",");
		
		mClose=mClose.substring(0, mClose.length()-1);
		taxdate=taxdate.substring(0, taxdate.length()-1);
		
		brnch=brnch.substring(0, brnch.length()-1);
		brnchId=brnchId.substring(0, brnchId.length()-1);
		
		response.getWriter().write(brnchId+"####"+brnch+"####"+perm+"####"+mClose+"####"+taxdate);
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
  