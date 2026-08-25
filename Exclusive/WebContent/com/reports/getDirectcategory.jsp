<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();

	Connection conn = null;
	Statement stmts=null;
	ResultSet rs=null;
	
	try{
		conn = ClsConnection.getMyConnection();
		stmts = conn.createStatement();
		
		String strSql = "select COALESCE(CAT_NAME,'') CAT_NAME,FORMAT(COALESCE(ROUND(sum(outstanding),2),0),2) outstanding,FORMAT(COALESCE(ROUND(sum(advance),2),0),2) advance,FORMAT(COALESCE(ROUND(sum(dueoutstanding),2),0),2) dueoutstanding from ( SELECT j.catid,j.CLACNO,if(SUM(J.AMOUNT)>0,SUM(J.AMOUNT),0) outstanding,if(SUM(J.AMOUNT)<0,SUM(J.AMOUNT),0) advance,if(SUM(J.dueamount)>0,SUM(J.dueamount),0) dueoutstanding from (select h.ACNO CLACNO,h.catid,AMOUNT-OUTAMOUNT AMOUNT, if(date_add(j.date , interval period day)<=curdate(),j.AMOUNT-OUTAMOUNT,0) dueamount FROM IN_OPACCOUNTD J INNER JOIN MY_ACBOOK H ON J.CLACNO=H.ACNO WHERE H.DTYPE='CRM' AND J.STATUS=3  AND (J.AMOUNT - J.OUTAMOUNT!=0)) j GROUP BY j.CLACNO ) a LEFT JOIN MY_CLCATM M1 ON a.CATID = M1.DOC_NO group by catid union all select 'TOTAL' CAT_NAME,FORMAT(COALESCE(ROUND(sum(outstanding),2),0),2) outstanding,FORMAT(COALESCE(ROUND(sum(advance),2),0),2) advance,FORMAT(COALESCE(ROUND(sum(dueoutstanding),2),0),2) dueoutstanding from ( SELECT j.catid,j.CLACNO,if(SUM(J.AMOUNT)>0,SUM(J.AMOUNT),0) outstanding,if(SUM(J.AMOUNT)<0,SUM(J.AMOUNT),0) advance,if(SUM(J.dueamount)>0,SUM(J.dueamount),0) dueoutstanding from ( select h.ACNO CLACNO,h.catid,AMOUNT-OUTAMOUNT AMOUNT, if(date_add(j.date , interval period day)<=curdate(),j.AMOUNT-OUTAMOUNT,0) dueamount FROM IN_OPACCOUNTD J INNER JOIN MY_ACBOOK H ON J.CLACNO=H.ACNO WHERE H.DTYPE='CRM' AND J.STATUS=3 AND (J.AMOUNT - J.OUTAMOUNT!=0) ) j GROUP BY j.CLACNO ) a LEFT JOIN MY_CLCATM M1 ON a.CATID = M1.DOC_NO ;";
		//System.out.println("dircat=="+strSql);  
		rs = stmts.executeQuery(strSql);
		
		String cat="",outstanding="",advance="",dueoutstanding="";
		int i=0;
		while(rs.next()) {
			if(i==0){
					cat+=rs.getString("CAT_NAME");
					outstanding+=rs.getString("outstanding");
					advance+=rs.getString("advance");
					dueoutstanding+=rs.getString("dueoutstanding");
				} 
			else{
				cat+="#"+rs.getString("CAT_NAME");
				outstanding+="#"+rs.getString("outstanding");
				advance+="#"+rs.getString("advance");
				dueoutstanding+="#"+rs.getString("dueoutstanding");
			} 
			i++;
			}
		
		
		response.getWriter().write(cat+"####"+outstanding+"####"+advance+"####"+dueoutstanding);
		
		stmts.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally {
		if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
		if (stmts != null) try { stmts.close(); } catch (SQLException ignore) {}
		if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
		}
  %>
  