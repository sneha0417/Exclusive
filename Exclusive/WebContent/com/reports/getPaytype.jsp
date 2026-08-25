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
		
		String strSql = "select 'TODAY' PAYTYPE,FORMAT(COALESCE(ROUND(SUM(if(paytype=1,netamt,0)),2),0),2) CASH,FORMAT(COALESCE(ROUND(SUM(if(paytype=2,netamt,0)),2),0),2) 'Card',FORMAT(COALESCE(ROUND(SUM(if(paytype=3 and refdate>date,netamt,0)),2),0),2) 'Cheque PDC',FORMAT(COALESCE(ROUND(SUM(if(paytype=3 and refdate<=date,netamt,0)),2),0),2) 'Cheque CDC' from gl_rentreceipt WHERE DATE=CURDATE() and status=3 UNION ALL select 'FOR THE MONTH' PAYTYPE,FORMAT(coalesce(ROUND(SUM(if(paytype=1,netamt,0)),2),0),2) CASH,FORMAT(coalesce(ROUND(SUM(if(paytype=2,netamt,0)),2),0),2) 'Card',FORMAT(coalesce(ROUND(SUM(if(paytype=3 and refdate>date,netamt,0)),2),0),2) 'Cheque PDC',FORMAT(coalesce( ROUND(SUM(if(paytype=3 and refdate<=date,netamt,0)),2),0),2) 'Cheque CDC' from gl_rentreceipt WHERE MONTH(DATE)=MONTH(CURDATE()) AND YEAR(DATE)=YEAR(CURDATE()) and status=3;";
		//System.out.println("paytype=="+strSql);
		rs = stmt.executeQuery(strSql);
		
		String pay="",cash="",card="",chpdc="",chcdc="";
		int i=0;
		while(rs.next()) {
			if(i==0){
				pay+=rs.getString("PAYTYPE");
				cash+=rs.getString("CASH");
				card+=rs.getString("Card");
				chpdc+=rs.getString("Cheque PDC");
				chcdc+=rs.getString("Cheque CDC");
			}
			else{
				pay+="#"+rs.getString("PAYTYPE");
				cash+="#"+rs.getString("CASH");
				card+="#"+rs.getString("Card");
				chpdc+="#"+rs.getString("Cheque PDC");
				chcdc+="#"+rs.getString("Cheque CDC");
			}
			i++;
					
				} 
		//System.out.println("pay=="+pay+"cash=-"+cash+"card="+card+"chpdc="+chpdc+"chcdc=="+chcdc);
		
		response.getWriter().write(pay+"####"+cash+"####"+card+"####"+chpdc+"####"+chcdc);
		
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
  