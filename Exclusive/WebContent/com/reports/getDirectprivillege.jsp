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
		
		String strSql = "select COALESCE(M1.PRIVILLEGE,'') PRIVILLEGE,FORMAT(COALESCE(ROUND(sum(outstanding),2),0),2) outstanding,FORMAT(COALESCE(ROUND(sum(advance),2),0),2) advance,FORMAT(COALESCE(ROUND(sum(dueoutstanding),2),0),2) dueoutstanding from ( SELECT j.PRIVILLEGE,j.CLACNO,if(SUM(J.AMOUNT)>0,SUM(J.AMOUNT),0) outstanding,if(SUM(J.AMOUNT)<0,SUM(J.AMOUNT),0) advance, if(SUM(J.dueamount)>0,SUM(J.dueamount),0) dueoutstanding from (select h.ACNO CLACNO,h.PRIVILLEGE,AMOUNT-OUTAMOUNT AMOUNT, if(date_add(j.date , interval period day)<=curdate(),j.AMOUNT-OUTAMOUNT,0) dueamount FROM IN_OPACCOUNTD J INNER JOIN MY_ACBOOK H ON J.CLACNO=H.ACNO WHERE H.DTYPE='CRM' AND J.STATUS=3  AND (J.AMOUNT - J.OUTAMOUNT!=0)) j GROUP BY j.CLACNO ) a LEFT JOIN IN_PRIVILLEGE M1 ON a.PRIVILLEGE = M1.DOC_NO group by PRIVILLEGE union all select 'TOTAL' PRIVILLEGE,FORMAT(COALESCE(ROUND(sum(outstanding),2),0),2) outstanding,FORMAT(COALESCE(ROUND(sum(advance),2),0),2) advance,FORMAT(COALESCE(ROUND(sum(dueoutstanding),2),0),2) dueoutstanding from ( SELECT j.PRIVILLEGE,j.CLACNO,if(SUM(J.AMOUNT)>0,SUM(J.AMOUNT),0) outstanding,if(SUM(J.AMOUNT)<0,SUM(J.AMOUNT),0) advance, if(SUM(J.dueamount)>0,SUM(J.dueamount),0) dueoutstanding from ( select h.ACNO CLACNO,h.PRIVILLEGE,AMOUNT-OUTAMOUNT AMOUNT, if(date_add(j.date , interval period day)<=curdate(),j.AMOUNT-OUTAMOUNT,0) dueamount FROM IN_OPACCOUNTD J INNER JOIN MY_ACBOOK H ON J.CLACNO=H.ACNO WHERE H.DTYPE='CRM' AND J.STATUS=3 AND (J.AMOUNT - J.OUTAMOUNT!=0) ) j GROUP BY j.CLACNO ) a LEFT JOIN IN_PRIVILLEGE M1 ON a.PRIVILLEGE = M1.DOC_NO  ;";
		//System.out.println("dirpriv=="+strSql); 
		rs = stmt.executeQuery(strSql);
		
		String cat2="",outstanding2="",advance2="",dueoutstanding2="";
		int i=0;
		while(rs.next()) {
			if(i==0){
					cat2+=rs.getString("PRIVILLEGE");
					outstanding2+=rs.getString("outstanding");
					advance2+=rs.getString("advance");
					dueoutstanding2+=rs.getString("dueoutstanding");
				} 
			else{
				cat2+="#"+rs.getString("PRIVILLEGE");
				outstanding2+="#"+rs.getString("outstanding");
				advance2+="#"+rs.getString("advance");
				dueoutstanding2+="#"+rs.getString("dueoutstanding");
			} 
			i++;
			}
		
		
		response.getWriter().write(cat2+"####"+outstanding2+"####"+advance2+"####"+dueoutstanding2);
		rs.close(); 
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
  