<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
	Connection conn = null;

	try{
		ClsConnection connDAO = new ClsConnection();
		ClsCommon commonDAO = new ClsCommon();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();

		java.sql.Date sqlBankReconcilationDate=null;
		java.sql.Date sqlBankReconciledDate=null;
		
		String reconcileddate=request.getParameter("reconcileddate");
		String account=request.getParameter("account");
		
	    if(!(reconcileddate.equalsIgnoreCase("undefined"))&&!(reconcileddate.equalsIgnoreCase(""))&&!(reconcileddate.equalsIgnoreCase("0"))){
	    	sqlBankReconcilationDate=commonDAO.changeStringtoSqlDate(reconcileddate);
		}
	    
	    String bankreconcileDate="",diff="0";
	    /*Bank Reconcile Date*/
	    String sqls = "SELECT max(date) bankreconciledate,DATE_FORMAT(max(date) ,'%d.%m.%Y') bankreconciledate1,DATEDIFF('"+sqlBankReconcilationDate+"',max(date)) diff "
	    + "FROM my_breconm where status=3 and acno="+account+" and date>='"+sqlBankReconcilationDate+"'";
	    ResultSet rss = stmt.executeQuery(sqls);
		
		while(rss.next()) {
			sqlBankReconciledDate=rss.getDate("bankreconciledate");
			bankreconcileDate=rss.getString("bankreconciledate1");
			diff=rss.getString("diff")==null?"0":rss.getString("diff");
		} 
		/*Bank Reconcile Date Ends*/
		
		response.getWriter().write(sqlBankReconciledDate+"***"+bankreconcileDate+"***"+diff);
		
		stmt.close();
		conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	} finally{
		conn.close();
	}
  %>
  