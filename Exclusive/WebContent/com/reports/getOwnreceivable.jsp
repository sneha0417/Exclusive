<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();

	Connection conn = null;
	ResultSet rs=null;
	Statement stmt=null;
	
	try{
		conn = ClsConnection.getMyConnection();
		 stmt = conn.createStatement();
		
		String strSql = "select coalesce(M1.NAME,'') PRIVILLEGE,FORMAT(COALESCE(ROUND(sum(outstanding),2),0),2) outstanding,FORMAT(COALESCE(ROUND(sum(advance),2),0),2) advance,FORMAT(COALESCE(ROUND(sum(dueoutstanding),2),0),2) dueoutstanding from( SELECT j.PRIVILLEGE,j.acno,if(SUM(J.DRAMOUNT)>0,SUM(J.DRAMOUNT),0) outstanding,if(SUM(J.DRAMOUNT)<0,SUM(J.DRAMOUNT),0) advance,if(SUM(J.dueamount)>0,SUM(J.dueamount),0) dueoutstanding from (select h.acno,h.PRIVILLEGE,(J.DRAMOUNT-J.OUT_AMOUNT) dramount, if(date_add(j.date , interval period day)<=curdate(),(J.DRAMOUNT-J.OUT_AMOUNT),0) dueamount FROM MY_JVTRAN J INNER JOIN MY_ACBOOK H ON J.ACNO=H.ACNO WHERE H.DTYPE='CRM' AND J.STATUS=3 AND (J.DRAMOUNT - J.OUT_AMOUNT!=0)  ) j GROUP BY j.acno ) a LEFT JOIN my_clprivilage M1 ON a.PRIVILLEGE = M1.DOC_NO group by PRIVILLEGE union all select 'TOTAL' PRIVILLEGE,FORMAT(COALESCE(ROUND(sum(outstanding),2),0),2) outstanding,FORMAT(COALESCE(ROUND(sum(advance),2),0),2) advance,FORMAT(COALESCE(ROUND(sum(dueoutstanding),2),0),2) dueoutstanding from ( SELECT j.PRIVILLEGE,j.acno,if(SUM(J.DRAMOUNT)>0,SUM(J.DRAMOUNT),0) outstanding,if(SUM(J.DRAMOUNT)<0,SUM(J.DRAMOUNT),0) advance,if(SUM(J.dueamount)>0,SUM(J.dueamount),0) dueoutstanding from (select h.acno,h.PRIVILLEGE,(J.DRAMOUNT-J.OUT_AMOUNT) dramount, if(date_add(j.date , interval period day)<=curdate(),(J.DRAMOUNT-J.OUT_AMOUNT),0) dueamount FROM MY_JVTRAN J INNER JOIN MY_ACBOOK H ON J.ACNO=H.ACNO WHERE H.DTYPE='CRM' AND J.STATUS=3 AND (J.DRAMOUNT - J.OUT_AMOUNT!=0) ) j GROUP BY j.acno ) a LEFT JOIN my_clprivilage M1 ON a.PRIVILLEGE = M1.DOC_NO ";
		//System.out.println("Rownreceivable=="+strSql);
		rs = stmt.executeQuery(strSql);
		
		String cat="",outstanding="",advance="",dueoutstanding="";
		int i=0;
		while(rs.next()) {
			if(i==0){
					cat+=rs.getString("PRIVILLEGE");
					outstanding+=rs.getString("outstanding");
					advance+=rs.getString("advance");
					dueoutstanding+=rs.getString("dueoutstanding");
				} 
			else{
				cat+="#"+rs.getString("PRIVILLEGE");
				outstanding+="#"+rs.getString("outstanding");
				advance+="#"+rs.getString("advance");
				dueoutstanding+="#"+rs.getString("dueoutstanding");
			} 
			i++;
			}
		
		
		response.getWriter().write(cat+"####"+outstanding+"####"+advance+"####"+dueoutstanding);
		
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
  