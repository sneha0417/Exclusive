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
		java.sql.Date sqlDeprDate=null;
		
		String employeeId=request.getParameter("empid")==""?"0":request.getParameter("empid");
		String leaveSalaryPaid=request.getParameter("leavesalarypaid")==""?"0":request.getParameter("leavesalarypaid");
		
		String leaveSalaryPaidEligibleDays="0",empCategoryID="",allowanceID="",leaveSalaryAmount="0";
		
		String sql = "select pay_catid from hr_empm where status=3 and active=1 and doc_no="+employeeId+"";
		ResultSet resultSet = stmt.executeQuery(sql);
		
		while(resultSet.next()) {
			empCategoryID=resultSet.getString("pay_catid");
		}
		
		String sql1 = "select d.alwid from hr_paycode m left join hr_payleaved d on m.doc_no=d.rdocno where d.status=3 and d.levid=m.annual_id and d.rdocno=(select MAX(doc_no) docno from hr_paycode where catid="+empCategoryID+")";
		ResultSet resultSet1 = stmt.executeQuery(sql1);
		
		int k=0;
		while(resultSet1.next()) {
			if(k==0) {
				allowanceID+=resultSet1.getString("alwid");
				k=1;
			}else {
				allowanceID+=","+resultSet1.getString("alwid");
			}
		}
		
		if(!(allowanceID.equalsIgnoreCase(""))) {
			
			String sql2 = "select round(sum(amount),0) amount from ( select * from ( select t.empid,id.rdocno,id.awlid,(id.revadd-id.revded) amount from hr_timesheet t left join hr_incrm im on t.empid=im.empid left join hr_incrd id on im.doc_no=id.rdocno where "  
				   + "im.doc_no=(select max(doc_no) from hr_incrm where t.empid=empid) and id.refdtype!='STD' and t.empid="+employeeId+" union all select 0 empid,0 rdocno,hrs.doc_no awlid,0 amount from hr_setallowance hrs where hrs.status=3 and hrs.doc_no not in (select id.awlid "
				   + "from hr_timesheet t left join hr_incrm im on t.empid=im.empid left join hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) from hr_incrm where t.empid=empid) and id.refdtype!='STD' and t.empid="+employeeId+")) as a where a.awlid in ("+allowanceID+") "
				   + "group by empid,awlid order by awlid) as b";
			ResultSet resultSet2 = stmt.executeQuery(sql2);		
			
			while(resultSet2.next()){
				leaveSalaryAmount=resultSet2.getString("amount");
			}
				
		}
		
		String sql3 = "select round((("+leaveSalaryPaid+"*30)/"+leaveSalaryAmount+"),2) lseligibledays";
		ResultSet resultSet3 = stmt.executeQuery(sql3);
		
		while(resultSet3.next()) {
			leaveSalaryPaidEligibleDays=resultSet3.getString("lseligibledays");
		}
		
		response.getWriter().write(leaveSalaryPaidEligibleDays);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  