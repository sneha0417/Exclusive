<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%	

	ClsConnection connDAO=new ClsConnection();
	ClsCommon commonDAO=new ClsCommon();
	 

	Connection conn = null;
	
	String cldocno=request.getParameter("cldocno")==null || request.getParameter("cldocno").trim().equalsIgnoreCase("")?"0":request.getParameter("cldocno").toString();
	String check=request.getParameter("check")==null || request.getParameter("check").trim().equalsIgnoreCase("")?"0":request.getParameter("check").toString();
	String val=request.getParameter("i")==null || request.getParameter("i").trim().equalsIgnoreCase("")?"0":request.getParameter("i").toString();
	 
	try{
		conn=connDAO.getMyConnection();
		Statement stmt=conn.createStatement();
		String result="";
		double invoiceamt=0.0,salikamt=0.0,trafficamt=0.0;
	 	int client=0;
		String strsql="select rent.invamount,rent.cldocno,coalesce(sal.salikamt,0) salikamount,coalesce(traf.trafficamt,0) trafficamount from "+
		" (select sum(invamount) invamount,cldocno from (select round(coalesce((a.datediff/a.rentalno)*(trf.rate+trf.cdw+trf.pai+trf.cdw1+trf.pai1+"+
	 	" trf.gps+trf.babyseater+trf.cooler),0),2) invamount,a.cldocno from ("+
		" select case when trf.rentaltype='Daily' then 1 when trf.rentaltype='Weekly' then 7 when (trf.rentaltype='Monthly' and"+
		" (select method from gl_config where field_nme='monthlycal')=0) then (select value from gl_config where field_nme='monthlycal')"+
		" when (trf.rentaltype='Monthly' and (select method from gl_config where field_nme='monthlycal')=1) then"+
		" day(last_day('2017-04-22')) else 0 end as rentalno,datediff('2017-04-22',agmt.invdate) datediff,agmt.doc_no,agmt.cldocno,"+
		" trf.rentaltype,agmt.invdate from gl_ragmt agmt inner join gl_rtarif trf on (agmt.doc_no=trf.rdocno and trf.rstatus=5) where"+
		" agmt.clstatus=0 group by agmt.doc_no) a left join gl_rtarif trf on (a.doc_no=trf.rdocno and rstatus=7)) re group by cldocno) rent"+
		" left join (select sum(coalesce(amount,0)) salikamt,EMP_ID from gl_salik where isallocated=1 and amount>0 and inv_no=0 AND EMP_TYPE='CRM' "+
		" group by emp_id) sal on rent.cldocno=sal.emp_id left join (select sum(coalesce(amount,0)) trafficamt,EMP_ID from gl_traffic where"+
		" isallocated=1 and amount>0 and inv_no=0 AND EMP_TYPE='CRM' group by emp_id) traf on rent.cldocno=traf.emp_id order by rent.cldocno";
		System.out.println(strsql);
	 	ResultSet rs=stmt.executeQuery(strsql);
	 	int i=0;
	 	while(rs.next()){
	 		client=rs.getInt("cldocno");
	 		invoiceamt=rs.getDouble("invamount");
	 		salikamt=rs.getDouble("salikamount");
	 		trafficamt=rs.getDouble("trafficamount");
	 		if(i==0){
	 			result=client+"###"+salikamt+"###"+trafficamt+"###"+invoiceamt;
	 		}
	 		else{
	 			result+=","+client+"###"+salikamt+"###"+trafficamt+"###"+invoiceamt;
	 		}
	 		i++;
	 	}
		/* double salik=0.00,traffic=0.00,curamt=0.00;
		String currentdoc_no;
		String result="";
		String currenttype="";
		java.sql.Date uptodate=null;
		Statement stmt1 = conn.createStatement ();
		ResultSet resultSet1,resultSet2,resultSet3,resultSet4;
		 
		String dateqry="select CURDATE() uptodate;";
		resultSet4=stmt1.executeQuery(dateqry);
		while(resultSet4.next()){
			uptodate=resultSet4.getDate("uptodate");
		}
		
	 
			
			String sql1="select coalesce(sum(amount),0) salamt,ra_no,rtype,EMP_ID,EMP_TYPE from gl_salik where"
					+ " isallocated=1 and amount>0 and inv_no=0 AND EMP_TYPE='CRM' and emp_id="+cldocno+" " ;
			
			resultSet1 = stmt1.executeQuery(sql1);
			while (resultSet1.next()){
				 salik=resultSet1.getDouble("salamt");
			}
			
			String sql2="select coalesce(sum(amount),0) trafficamt,ra_no,rtype,EMP_ID,EMP_TYPE from gl_TRAFFIC where " 
				+"	isallocated=1 and amount>0 and inv_no=0 AND EMP_TYPE='CRM' and emp_id="+cldocno+" ;" ;
			resultSet2 = stmt1.executeQuery(sql2);
			while (resultSet2.next()){
				 traffic=resultSet2.getDouble("trafficamt");
			}
			
			String sql3="select doc_no,'RAG' from gl_ragmt where cldocno="+cldocno+" and clstatus=0 "
					+" union all "
					+" select doc_no,'LAG' from gl_lagmt where cldocno="+cldocno+" and clstatus=0;" ;
					
			resultSet3 = stmt1.executeQuery(sql3);
			while (resultSet3.next()){
				 currentdoc_no=resultSet3.getString("doc_no");
				 currenttype=resultSet3.getString("RAG");
				 curamt+= DAO.getAgmtCurrAmount( currentdoc_no,  currenttype,  conn,  uptodate);
			} */ 
			
		 System.out.println("Result: "+result);
		response.getWriter().write(result);
		
	 	conn.close();

	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		 conn.close();
	}

%>





<%-- <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%@page import="com.dashboard.analysis.rawisebal.ClsRawiseBalanceDAO"%>
<%ClsRawiseBalanceDAO DAO= new ClsRawiseBalanceDAO(); %>
<%	

	ClsConnection connDAO=new ClsConnection();
	ClsCommon commonDAO=new ClsCommon();
	 

	Connection conn = null;
	
	String paymentfollowuparray=request.getParameter("paymentfollowuparray")==null || request.getParameter("paymentfollowuparray").trim().equalsIgnoreCase("")?"0":request.getParameter("paymentfollowuparray").toString();
	String check=request.getParameter("check")==null || request.getParameter("check").trim().equalsIgnoreCase("")?"0":request.getParameter("check").toString();
	System.out.println("paymentfollowuparray=="+paymentfollowuparray);
	try{
		conn=connDAO.getMyConnection();
		
		ArrayList<String> newarray=new ArrayList<String>();
		
		if(paymentfollowuparray.length()>0){
			String temparray[]=paymentfollowuparray.split(",");
			for(int i=0;i<temparray.length;i++){
				newarray.add(temparray[i]);
			}
		}
		double salik=0.00,traffic=0.00,curamt=0.00;
		String currentdoc_no;
		String result="";
		String currenttype="";
		java.sql.Date uptodate=null;
		Statement stmt1 = conn.createStatement ();
		ResultSet resultSet1,resultSet2,resultSet3,resultSet4;
		System.out.println("newarray=="+newarray);
		String dateqry="select CURDATE() uptodate;";
		resultSet4=stmt1.executeQuery(dateqry);
		while(resultSet4.next()){
			uptodate=resultSet4.getDate("uptodate");
		}
		
		for(int i=0;i<newarray.size();i++){
			
			String temp[]=newarray.get(i).split("::");
			String cldocno=temp[0].trim().equalsIgnoreCase("undefined") || temp[0].trim().equalsIgnoreCase("NaN") || temp[0].trim().equalsIgnoreCase("") || temp[0].trim().isEmpty()?"0":temp[0].trim().toString();
			
			String sql1="select coalesce(sum(amount),0) salamt,ra_no,rtype,EMP_ID,EMP_TYPE from gl_salik where"
					+ " isallocated=1 and amount>0 and inv_no=0 AND EMP_TYPE='CRM' and emp_id="+cldocno+" " ;
			
			resultSet1 = stmt1.executeQuery(sql1);
			while (resultSet1.next()){
				 salik=resultSet1.getDouble("salamt");
			}
			
			String sql2="select coalesce(sum(amount),0) trafficamt,ra_no,rtype,EMP_ID,EMP_TYPE from gl_TRAFFIC where " 
				+"	isallocated=1 and amount>0 and inv_no=0 AND EMP_TYPE='CRM' and emp_id="+cldocno+" ;" ;
			resultSet2 = stmt1.executeQuery(sql2);
			while (resultSet2.next()){
				 traffic=resultSet2.getDouble("trafficamt");
			}
			
			String sql3="select doc_no,'RAG' from gl_ragmt where cldocno="+cldocno+" and clstatus=0 "
					+" union all "
					+" select doc_no,'LAG' from gl_lagmt where cldocno="+cldocno+" and clstatus=0;" ;
			resultSet3 = stmt1.executeQuery(sql3);
			while (resultSet3.next()){
				 currentdoc_no=resultSet3.getString("doc_no");
				 currenttype=resultSet3.getString("RAG");
				 
				 curamt += DAO.getAgmtCurrAmount( currentdoc_no,  currenttype,  conn,  uptodate);
			}
			result +=cldocno+","+salik+","+traffic+","+curamt+"###";
		}
		System.out.println("result==="+result);
		response.getWriter().write(result);
	 	conn.close();

	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		 conn.close();
	}

%> --%>