<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
    ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;           
	String brhid=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid");
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();

		String strSql = "select loc_name loc,doc_no , u.userid='"+session.getAttribute("USERID").toString()+"' stat from my_locm m left join tr_userloclink u on u.locid=m.doc_no where status=3 and m.brhid='"+brhid+"' and u.userid='"+session.getAttribute("USERID").toString()+"'";     
	    //System.out.println("sql --====== "+strSql);        
		ResultSet rs = stmt.executeQuery(strSql);
		
		String loc="",locId="";
		int stat=0;
		while(rs.next()) {
				if(rs.getInt("stat")==1){
					stat=1;
			        loc+=rs.getString("loc")+",";
					locId+=rs.getString("doc_no")+",";
				}
	  		}  

		if(stat==0){
			strSql = "select loc_name loc,doc_no from my_locm m where status=3  and m.brhid='"+brhid+"'";     
		    //System.out.println("sql --====== "+strSql);        
			ResultSet rs1 = stmt.executeQuery(strSql);
			
			while(rs1.next()) {
				        loc+=rs1.getString("loc")+",";
						locId+=rs1.getString("doc_no")+",";
		  		}  
		}
		
		String brn[]=loc.split(",");
		String brnId[]=locId.split(",");
		loc=loc.substring(0, loc.length()-1);
		
		response.getWriter().write(locId+"####"+loc);                     
 		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>