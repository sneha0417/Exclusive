<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();

	Connection conn = null;
	Statement stmt=null;
	ResultSet rs=null;
	
	try{
		conn = ClsConnection.getMyConnection();
		 stmt = conn.createStatement();
		
		String strSql = "SELECT 1 ord , if(DEN=604,'CASH','BANK') DEN,H.DESCRIPTION,FORMAT(COALESCE(ROUND(SUM(DRAMOUNT),2),0),2) AMT FROM MY_HEAD H INNER JOIN MY_JVTRAN J ON H.DOC_NO=J.ACNO WHERE j.status=3 and DEN IN (604,305) AND M_S=0  GROUP BY J.ACNO UNION ALL SELECT 0 ord,if(DEN=604,'CASH','BANK') DEN,IF(H.DEN=604,'CASH TOTAL','BANK TOTAL'),FORMAT(COALESCE(ROUND(SUM(DRAMOUNT),2),0),2) AMT FROM MY_HEAD H INNER JOIN MY_JVTRAN J ON H.DOC_NO=J.ACNO WHERE j.status=3 and  DEN IN (604,305) AND M_S=0 GROUP BY H.DEN ORDER BY DEN,ord DESC ;";
		// System.out.println("bank=="+strSql);
		 rs = stmt.executeQuery(strSql);
		
		String den="",descr="",amt="",temp="",temp1="";
		int i=0;
		while(rs.next()) {
			String val=rs.getString("DEN");
			if(!temp.equalsIgnoreCase(val)){
				temp=rs.getString("DEN");
				temp1=temp;
			}
			else{
				temp1="";
			}
			
			if(i==0){
					den+=temp1;
					descr+=rs.getString("DESCRIPTION");
					amt+=rs.getString("AMT");
			}
			else{
				den+=",,"+temp1;
				descr+=",,"+rs.getString("DESCRIPTION");
				amt+=",,"+rs.getString("AMT");
			}
			i++;
			
				} 
	
		response.getWriter().write(den+"####"+descr+"####"+amt);
		
		stmt.close();
		conn.close();
		 rs.close(); 
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally {
		if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
		if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
		if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
		}
  %>
  