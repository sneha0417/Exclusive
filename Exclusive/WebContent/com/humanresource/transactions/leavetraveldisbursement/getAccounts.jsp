<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon"%>

<%	

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;
	
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		java.sql.Date sqlDate=null;
		
		String empId=request.getParameter("empId")==""?"0":request.getParameter("empId");
		String date=request.getParameter("date");
		
		if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
        {
     	   sqlDate = ClsCommon.changeStringtoSqlDate(date);
        }
			
		String strSql = "select m.acno,h.account,h.description,h.atype,h.curid,round(cb.rate,2) rate,c.type from hr_empm m left join my_head h on m.acno=h.doc_no left join "
				+ "my_curr c on h.curid=c.doc_no left join my_curbook cb on h.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
				+ "from my_curbook cr where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
				+ "where m.doc_no="+empId+"";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String empaccdocno="",empaccount="",empdescription="",empatype="",empcurid="",emprate="",emptype="";
		while(rs.next()) {
					empaccdocno=rs.getString("acno");
					empaccount=rs.getString("account");
					empdescription=rs.getString("description");
					empatype=rs.getString("atype");
					empcurid=rs.getString("curid");
					emprate=rs.getString("rate");
					emptype=rs.getString("type");
				} 
		
		String strSql1 = "select h.doc_no acno,h.account,h.description,h.atype,h.curid,round(cb.rate,2) rate,c.type from my_account a left join my_head h on a.acno=h.doc_no "
				+ "left join my_curr c on h.curid=c.doc_no left join my_curbook cb on h.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
				+ "from my_curbook cr where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
				+ "where a.codeno IN ('HREXPENSE2LEAVESALARYEXPENSEACCOUNT')";
		
		ResultSet rs1 = stmt.executeQuery(strSql1);
		
		String lsexpensedocno="",lsexpenseaccount="",lsexpensedescription="",lsexpenseatype="",lsexpensecurid="",lsexpenserate="",lsexpensetype="";
		while(rs1.next()) {
			        lsexpensedocno=rs1.getString("acno");
			        lsexpenseaccount=rs1.getString("account");
			        lsexpensedescription=rs1.getString("description");
			        lsexpenseatype=rs1.getString("atype");
			        lsexpensecurid=rs1.getString("curid");
			        lsexpenserate=rs1.getString("rate");
			        lsexpensetype=rs1.getString("type");
				} 
		
		String strSql2 = "select h.doc_no acno,h.account,h.description,h.atype,h.curid,round(cb.rate,2) rate,c.type from my_account a left join my_head h on a.acno=h.doc_no "
				+ "left join my_curr c on h.curid=c.doc_no left join my_curbook cb on h.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
				+ "from my_curbook cr where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
				+ "where a.codeno IN ('HRPROVISION2LEAVESALARYBENEFITACCOUNT')";
		
		ResultSet rs2 = stmt.executeQuery(strSql2);
		
		String lsprovisiondocno="",lsprovisionaccount="",lsprovisiondescription="",lsprovisionatype="",lsprovisioncurid="",lsprovisionrate="",lsprovisiontype="";
		while(rs2.next()) {
			        lsprovisiondocno=rs2.getString("acno");
			        lsprovisionaccount=rs2.getString("account");
			        lsprovisiondescription=rs2.getString("description");
			        lsprovisionatype=rs2.getString("atype");
			        lsprovisioncurid=rs2.getString("curid");
			        lsprovisionrate=rs2.getString("rate");
			        lsprovisiontype=rs2.getString("type");
				} 
		
		String strSql3 = "select h.doc_no acno,h.account,h.description,h.atype,h.curid,round(cb.rate,2) rate,c.type from my_account a left join my_head h on a.acno=h.doc_no "
				+ "left join my_curr c on h.curid=c.doc_no left join my_curbook cb on h.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
				+ "from my_curbook cr where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
				+ "where a.codeno IN ('HREXPENSE4LEAVESALARYEXPENSEBALANCEACCOUNT')";
		
		ResultSet rs3 = stmt.executeQuery(strSql3);
		
		String lsexpensebalancedocno="",lsexpensebalanceaccount="",lsexpensebalancedescription="",lsexpensebalanceatype="",lsexpensebalancecurid="",lsexpensebalancerate="",lsexpensebalancetype="";
		while(rs3.next()) {
			        lsexpensebalancedocno=rs3.getString("acno");
			        lsexpensebalanceaccount=rs3.getString("account");
			        lsexpensebalancedescription=rs3.getString("description");
			        lsexpensebalanceatype=rs3.getString("atype");
			        lsexpensebalancecurid=rs3.getString("curid");
			        lsexpensebalancerate=rs3.getString("rate");
			        lsexpensebalancetype=rs3.getString("type");
				} 
		
		String strSql4 = "select h.doc_no acno,h.account,h.description,h.atype,h.curid,round(cb.rate,2) rate,c.type from my_account a left join my_head h on a.acno=h.doc_no "
				+ "left join my_curr c on h.curid=c.doc_no left join my_curbook cb on h.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
				+ "from my_curbook cr where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
				+ "where a.codeno IN ('HREXPENSE3TRAVELEXPENSEACCOUNT')";
		
		ResultSet rs4 = stmt.executeQuery(strSql4);
		
		String travelexpensedocno="",travelexpenseaccount="",travelexpensedescription="",travelexpenseatype="",travelexpensecurid="",travelexpenserate="",travelexpensetype="";
		while(rs4.next()) {
			        travelexpensedocno=rs4.getString("acno");
			        travelexpenseaccount=rs4.getString("account");
			        travelexpensedescription=rs4.getString("description");
			        travelexpenseatype=rs4.getString("atype");
			        travelexpensecurid=rs4.getString("curid");
			        travelexpenserate=rs4.getString("rate");
			        travelexpensetype=rs4.getString("type");
				} 
		
		String strSql5 = "select h.doc_no acno,h.account,h.description,h.atype,h.curid,round(cb.rate,2) rate,c.type from my_account a left join my_head h on a.acno=h.doc_no "
				+ "left join my_curr c on h.curid=c.doc_no left join my_curbook cb on h.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
				+ "from my_curbook cr where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
				+ "where a.codeno IN ('HRPROVISION3TRAVELBENEFITACCOUNT')";
		
		ResultSet rs5 = stmt.executeQuery(strSql5);
		
		String travelprovisiondocno="",travelprovisionaccount="",travelprovisiondescription="",travelprovisionatype="",travelprovisioncurid="",travelprovisionrate="",travelprovisiontype="";
		while(rs5.next()) {
			        travelprovisiondocno=rs5.getString("acno");
			        travelprovisionaccount=rs5.getString("account");
			        travelprovisiondescription=rs5.getString("description");
			        travelprovisionatype=rs5.getString("atype");
			        travelprovisioncurid=rs5.getString("curid");
			        travelprovisionrate=rs5.getString("rate");
			        travelprovisiontype=rs5.getString("type");
				} 
		
		
		response.getWriter().write(empaccdocno+"####"+empaccount+"####"+empdescription+"####"+empatype+"####"+empcurid+"####"+emprate+"####"+emptype+"####"+lsexpensedocno+"####"+lsexpenseaccount+"####"+lsexpensedescription+"####"+lsexpenseatype+"####"+lsexpensecurid+"####"+lsexpenserate+"####"+lsexpensetype+"####"+lsprovisiondocno+"####"+lsprovisionaccount+"####"+lsprovisiondescription+"####"+lsprovisionatype+"####"+lsprovisioncurid+"####"+lsprovisionrate+"####"+lsprovisiontype+"####"+travelexpensedocno+"####"+travelexpenseaccount+"####"+travelexpensedescription+"####"+travelexpenseatype+"####"+travelexpensecurid+"####"+travelexpenserate+"####"+travelexpensetype+"####"+travelprovisiondocno+"####"+travelprovisionaccount+"####"+travelprovisiondescription+"####"+travelprovisionatype+"####"+travelprovisioncurid+"####"+travelprovisionrate+"####"+travelprovisiontype+"####"+lsexpensebalancedocno+"####"+lsexpensebalanceaccount+"####"+lsexpensebalancedescription+"####"+lsexpensebalanceatype+"####"+lsexpensebalancecurid+"####"+lsexpensebalancerate+"####"+lsexpensebalancetype);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  