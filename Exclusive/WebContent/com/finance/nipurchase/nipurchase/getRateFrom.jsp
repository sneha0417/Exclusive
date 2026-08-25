<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>

<%	
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;
	
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String curr=request.getParameter("curr");
		String date=request.getParameter("date");
		
		java.sql.Date sqlDate=null;
        
        date.trim();
        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
        {
        	sqlDate = ClsCommon.changeStringtoSqlDate(date);
        }
		
		/* String strSql = "select c_rate,type from my_curr where doc_no='"+curr+"'"; */
		
		String strSql = "select a.rate c_rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
		 +"where  coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curr+"'";
		
		ResultSet rs = stmt.executeQuery(strSql);
		
		String rate="";String type="";
		while(rs.next()) {
			rate+=rs.getString("c_rate")+",";
			type+=rs.getString("type")+",";
	  		} 
		
		rate=rate.substring(0, rate.length()-1);
		type=type.substring(0, type.length()-1);
		
		response.getWriter().write(rate);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
