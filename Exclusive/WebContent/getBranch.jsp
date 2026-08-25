
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
ClsConnection ClsConnection=new ClsConnection();


    String menubrch=request.getParameter("menubranch");
	Connection conn = null;
	
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
/* 		
		String strSql = "select branchname,mclose,doc_no,(select code from my_curr where doc_no=curId) as curr,"
				+"curId from my_brch where cmpid='"+session.getAttribute("COMPANYID")+"'"; */
		

	 String strSql = "select b.branchname,b.taxdate,b.mclose,b.doc_no,(select code from my_curr where doc_no=b.curId) as curr,(select type from my_curr where doc_no=b.curId) as type,b.curId "
			 +" from my_brch b  left join my_user u on u.doc_no='"+session.getAttribute("USERID") +"'  left join my_usrbr ub on ub.user_id=u.doc_no and ub.brhid=b.doc_no and u.permission=1 "
			 +" where  b.cmpid='"+session.getAttribute("COMPANYID")+"'  and  if(u.permission=1,ub.user_id,'"+session.getAttribute("USERID")+"')='"+session.getAttribute("USERID")+"'  and  b.status<>7" ;
		//System.out.println("sql ====== "+strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		
		String brnch="",currency="",brnchId="",currId="",mClose="",curType="",taxdate="";
		while(rs.next()) {
					brnch+=rs.getString("branchname")+",";
					currency+=rs.getString("curr")+",";
					brnchId+=rs.getString("doc_no")+",";
					currId+=rs.getString("curId")+",";
					mClose+=rs.getString("mClose")+",";
					curType+=rs.getString("type")+",";
					taxdate+=rs.getString("taxdate")+",";
	  		} 
	
		CallableStatement s = conn.prepareCall("{CALL zz_spclear()}");
		int val = s.executeUpdate();
		//System.out.println("clear ===="+val);
			
		String brn[]=brnch.split(",");
		String cur[]=currency.split(",");
		String brnId[]=brnchId.split(",");
		String curId[]=currId.split(",");
		String mClosed[]=mClose.split(",");
		String currType[]=curType.split(",");
		
		String taxdates[]=taxdate.split(",");
		
		
		brnch=brnch.substring(0, brnch.length()-1);
		currency=currency.substring(0, currency.length()-1);
		mClose=mClose.substring(0, mClose.length()-1);
		curType=curType.substring(0, curType.length()-1);
		
		taxdate=taxdate.substring(0, taxdate.length()-1);
		
		response.getWriter().write(brnchId+"####"+brnch+"####"+currId+"####"+currency+"####"+mClose+"####"+curType+"####"+taxdate);

		if(menubrch==""){
			session.setAttribute("BRANCHNAME", brn[0]);
			session.setAttribute("CURRENCY", cur[0]);
			session.setAttribute("BRANCHID", brnId[0]);
			session.setAttribute("CURRENCYID", curId[0]);
			session.setAttribute("MONTHCLOSED", mClosed[0]);
			session.setAttribute("CURRENCYTYPE", currType[0]);
			session.setAttribute("TAXDATE", taxdates[0]);
		}
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
 
 
 
 
 
 
 
 
 