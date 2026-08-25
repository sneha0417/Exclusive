<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();

	Connection conn = null;
	ResultSet rs=null;
	Statement  stmt=null;
	
	try{
		conn = ClsConnection.getMyConnection();
		 stmt = conn.createStatement();
		
		String strSql = "SELECT 'NOT POSTED' TYPE,FORMAT(COALESCE(SUM(ROUND(IF(DTYPE IN ('BPV','OPP'),TOTALAMOUNT,0),2)),0),2) PAYMENT,FORMAT(COALESCE(SUM(ROUND(IF(DTYPE IN ('BRV','OPR'),TOTALAMOUNT,0),2)),0),2) RECEIPT FROM MY_CHQBM M INNER JOIN MY_CHQDET D ON M.TR_NO=D.TR_NO WHERE M.STATUS=3 AND PDC=1 AND D.STATUS='E' AND M.CHQDT<=CURDATE() UNION ALL SELECT 'NEXT 10 DAYS' TYPE,FORMAT(coalesce(SUM(ROUND(IF(DTYPE IN ('BPV','OPP'),TOTALAMOUNT,0),2)),0),2) PAYMENT,FORMAT(coalesce(SUM(ROUND(IF(DTYPE IN ('BRV','OPR'),TOTALAMOUNT,0),2)),0),2) RECEIPT FROM MY_CHQBM M INNER JOIN MY_CHQDET D ON M.TR_NO=D.TR_NO WHERE M.STATUS=3 AND PDC=1 AND D.STATUS='E' AND M.CHQDT<=CURDATE()+10 AND M.CHQDT>CURDATE() UNION ALL SELECT 'BALANCE' TYPE,FORMAT(COALESCE(SUM(ROUND(IF(DTYPE IN ('BPV','OPP'),TOTALAMOUNT,0),2)),0),2) PAYMENT,FORMAT(COALESCE(SUM(ROUND(IF(DTYPE IN ('BRV','OPR'),TOTALAMOUNT,0),2)),0),2) RECEIPT FROM MY_CHQBM M INNER JOIN MY_CHQDET D ON M.TR_NO=D.TR_NO WHERE M.STATUS=3 AND PDC=1 AND D.STATUS='E' AND M.CHQDT>CURDATE()+10 UNION ALL SELECT 'TOTAL' TYPE,FORMAT(COALESCE(SUM(ROUND(IF(DTYPE IN ('BPV','OPP'),TOTALAMOUNT,0),2)),0),2) PAYMENT,FORMAT(COALESCE(SUM(ROUND(IF(DTYPE IN ('BRV','OPR'),TOTALAMOUNT,0),2)),0),2) RECEIPT FROM MY_CHQBM M INNER JOIN MY_CHQDET D ON M.TR_NO=D.TR_NO WHERE M.STATUS=3 AND PDC=1 AND D.STATUS='E' ;";
		System.out.println("pdc=="+strSql); 
		rs = stmt.executeQuery(strSql);
		
		String type="",received="",paid="";
		int i=0;
		while(rs.next()) {
			if(i==0){
					type+=rs.getString("TYPE");
					received+=rs.getString("RECEIPT");
					paid+=rs.getString("PAYMENT");
				} 
			else{
				type+="#"+rs.getString("TYPE");
				received+="#"+rs.getString("RECEIPT");
				paid+="#"+rs.getString("PAYMENT");
			} 
			i++;
			}
		
		
		response.getWriter().write(type+"####"+received+"####"+paid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally {
		if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
		if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
		if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
		}
  %>
  