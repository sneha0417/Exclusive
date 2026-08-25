<%@page import="com.dashboard.accounts.ageingstatementnew.ClsAgeingStatementDAO"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.dashboard.accounts.ageingstatementnew.ClsAgeingStatementBean"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
String result="",lblprintname="";
try{
	/* ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select a.date 'Date',CASE WHEN a.transType in ('INV','INS','INT') THEN m.voc_no WHEN a.transType in ('VPU') THEN vp.voc_no WHEN a.transType in"+
	" ('VPD') THEN vd.voc_no WHEN a.transType in ('NPA') THEN np.voc_no WHEN a.transType in ('VSI') THEN vs.voc_no WHEN a.transType in"+
	" ('CPU') THEN cpu.voc_no ELSE a.transno END AS 'Docno',a.transType 'Type',a.branchname 'Branch',a.ref_detail 'RefNo',a.description 'Description',"+
	" round(a.netamount,2) 'Amount',round(a.applied,2) 'Applied',round(a.balance,2) 'Balance',a.duedys 'Age' from"+
	" (select j.doc_no transNo,coalesce(j.ref_detail,'') ref_detail,j.description,DATE_FORMAT((j.date),'%d-%m-%Y') date,j.dtype transType,"+
	" round(sum(j.dramount)*j.id,2) netamount,round(coalesce(o.amount,0),2) applied,"+
	" round((sum(dramount) - coalesce(o.amount,0)*id)*j.id,2) balance,b.branchname,"+
	" TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('2019-03-30' as datetime)) duedys,j.brhid from my_jvtran j"+
	" inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o"+
	" inner join my_jvtran j on j.tranid=o.AP_trid where j.date<='2019-03-30' group by tranid) o on j.tranid=o.tranid"+
	" inner join my_brch b on j.brhId=b.doc_no where j.status=3 and h.atype='AR' and j.acno=6656 and j.date<='2019-03-30' and j.id < 0"+
	" group by j.tranid having balance<>0 order by j.date) a  left join gl_invm m on (a.transno=m.doc_no and a.brhid=m.brhid"+
	" and a.transType in ('INV','INS','INT'))  left join gl_vpurm vp on (a.transno=vp.doc_no and a.brhid=vp.brhid"+
	" and a.transType in ('VPU'))  left join gl_vpurdirm vd on (a.transno=vd.doc_no and a.brhid=vd.brhid and a.transType in ('VPD'))"+
	" left join gl_nonpoolveh np on (a.transno=np.doc_no and a.transType in ('NPA'))"+
	" left join gl_vsalem vs on (a.transno=vs.doc_no and a.brhid=vs.brhid and a.transType in ('VSI'))"+
	" left join my_srvpurm cpu on (a.transno=cpu.doc_no and a.brhid=cpu.brhid and a.transType in ('CPU'))";
	ResultSet rs=stmt.executeQuery(strsql);
	result="<table id='tabledata'><thead><tr><th>Date</th><th>Docno</th><th>Type</th><th>Branch</th><th>RefNo</th><th>Description</th><th>Amount</th><th>Applied</th><th>Balance</th><th>Age</th></tr></thead><tbody>";
	result+="<tr><td colspan='10' align='center'>Unapplied</td></tr>";
	while(rs.next()){
		result+="<tr>";
		result+="<td>"+rs.getString("Date")+"</td><td>"+rs.getString("Docno")+"</td><td>"+rs.getString("Type")+"</td><td>"+rs.getString("Branch")+"</td><td>"+rs.getString("RefNo")+"</td><td>"+rs.getString("Description")+"</td><td>"+rs.getString("Amount")+"</td><td>"+rs.getString("Applied")+"</td><td>"+rs.getString("Balance")+"</td><td>"+rs.getString("Age")+"</td>";
		result+="</tr>";
	}
	result+="</tbody></table>"; */
	
	
	ClsConnection objconn=new ClsConnection();
	conn = objconn.getMyConnection();
    Statement stmtAgeingStatement =conn.createStatement();
    String sqld="",sqld1="",select="",joins="",casestatement="",sqlUnapplyResult="0";
    
	String atype = request.getParameter("atype");
	int acno=Integer.parseInt(request.getParameter("acno"));
	int level1from=Integer.parseInt(request.getParameter("level1from"));
	int level1to=Integer.parseInt(request.getParameter("level1to"));
	int level2from=Integer.parseInt(request.getParameter("level2from"));
	int level2to=Integer.parseInt(request.getParameter("level2to"));
	int level3from=Integer.parseInt(request.getParameter("level3from"));
	int level3to=Integer.parseInt(request.getParameter("level3to"));
	int level4from=Integer.parseInt(request.getParameter("level4from"));
	int level4to=Integer.parseInt(request.getParameter("level4to"));
	int level5from=Integer.parseInt(request.getParameter("level5from"));
	String branch = request.getParameter("branch");
	String uptoDate = request.getParameter("uptoDate");
	String email = request.getParameter("email");
	String print = request.getParameter("print");
	java.sql.Date sqlUpToDate = null;   
	ClsCommon objcommon=new ClsCommon();
	if(!(uptoDate.equalsIgnoreCase("undefined")) && !(uptoDate.equalsIgnoreCase("")) && !(uptoDate.equalsIgnoreCase("0"))){
		sqlUpToDate = objcommon.changeStringtoSqlDate(uptoDate);
    }
	ClsAgeingStatementBean ageingStatementBean=new ClsAgeingStatementBean();
	ClsAgeingStatementDAO ageingStatementDAO=new ClsAgeingStatementDAO();
	ageingStatementBean=ageingStatementDAO.getPrint(request,atype,acno,branch,uptoDate,level1from,level1to,level2from,level2to,level3from,level3to,level4from,level4to,level5from);
    
    if(atype.equalsIgnoreCase("AR")){
		sqld=" and j.id < 0";
		sqld1=" and j.id > 0";
		
		select ="select CONVERT(if(sum(t7)>0,round((sum(t7)),2),'  '),CHAR(50)) netamount,CONVERT(if(sum(l1)>0,round((sum(l1)),2),'  '),CHAR(50)) level1,"
				+ "CONVERT(if(sum(l2)>0,round((sum(l2)),2),'  '),CHAR(50)) level2,CONVERT(if(sum(l3)>0,round((sum(l3)),2),'  '),CHAR(50)) level3,"  
				+ "CONVERT(if(sum(l4)>0,round((sum(l4)),2),'  '),CHAR(50)) level4,CONVERT(if(sum(l5)>0,round((sum(l5)),2),'  '),CHAR(50)) level5 from ("
				+ "select d.acno,d.brhid,d.doc_no,if(d.duedys between "+level1from+" and "+level1to+" and d.bal>0,round((d.bal),2),0) l1,if(d.duedys between "
				+ ""+level2from+" and "+level2to+" and d.bal>0,round((d.bal),2),0) l2,if(d.duedys between "+level3from+" and "+level3to+" and d.bal>0,"
				+ "round((d.bal),2),0) l3,if(d.duedys between "+level4from+" and "+level4to+" and d.bal>0,round((d.bal),2),0) l4,if(d.duedys >="+level5from+" "
				+ "and d.bal>0,round((d.bal),2),0) l5,CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(10)) U6,if(d.bal>0,d.bal,0) t7 from ";
	}
	else if(atype.equalsIgnoreCase("AP")){
		sqld=" and j.id > 0";
		sqld1=" and j.id < 0";
		
		select ="select CONVERT(if(sum(t7)<0,round((sum(t7)*-1),2),'  '),CHAR(50)) netamount,CONVERT(if(sum(l1)<0,round((sum(l1)*-1),2),'  '),CHAR(50)) level1,"  
				+ "CONVERT(if(sum(l2)<0,round((sum(l2)*-1),2),'  '),CHAR(50)) level2,CONVERT(if(sum(l3)<0,round((sum(l3)*-1),2),'  '),CHAR(50)) level3,"  
				+ "CONVERT(if(sum(l4)<0,round((sum(l4)*-1),2),'  '),CHAR(50)) level4,CONVERT(if(sum(l5)<0,round((sum(l5)*-1),2),'  '),CHAR(50)) level5 from ("
				+ "select d.acno,d.brhid,d.doc_no,if(d.duedys between "+level1from+" and "+level1to+" and d.bal<0,round((d.bal),2),0) l1,"
				+ "if(d.duedys between "+level2from+" and "+level2to+"  and d.bal<0,round((d.bal),2),0) l2,if(d.duedys between "+level3from+" and "+level3to+"  and "
				+ "d.bal<0,round((d.bal),2),0) l3,if(d.duedys between "+level4from+" and "+level4to+"  and d.bal<0,round((d.bal),2),0) l4,if(d.duedys >="+level5from+"  "
				+ "and d.bal<0,round((d.bal),2),0) l5,CONVERT(if(d.bal>0,round((d.bal),2),''),CHAR(10)) U6,if(d.bal<0,d.bal,0) t7 from ";
	}
    
    String sqlAgeing = "";
	
	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		sqlAgeing+=" and j.brhId="+branch+"";
	}
			
	sqlAgeing = select+" (select j.acno,j.brhid,h.description name,sum(dramount) - coalesce(o.amount,0)*id bal, j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys\r\n" + 
				"from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.tranid where\r\n" + 
				"j.date<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' and j.acno="+acno+""+sqlAgeing+""+sqld1+" group by j.tranid having bal<>0 \r\n" + 
				" union all select j.acno,j.brhid,h.description name,sum(dramount)- coalesce(o.amount,0)*id bal, j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys\r\n" + 
				" from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"'\r\n" + 
				" group by tranid) o on j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' and j.acno="+acno+""+sqlAgeing+""+sqld+" group by j.tranid having bal<>0) d) ag group by acno";	
	 
	joins=objcommon.getFinanceVocTablesJoins(conn);
	casestatement=objcommon.getFinanceVocTablesCase(conn);
	
	String sqlUnapply = "select "+casestatement+"a.date,a.transType,a.ref_detail,a.branchname,a.description,round(a.netamount,2) netamount,round(a.applied,2) applied,round(a.balance,2) balance,a.duedys,a.brhid from ("
				+ "select j.doc_no transNo,coalesce(j.ref_detail,'') ref_detail,j.description,DATE_FORMAT((j.date),'%d-%m-%Y') date,j.dtype transType,round(sum(j.dramount)*j.id,2) netamount,round(coalesce(o.amount,0),2) applied," 
				+ "round((sum(dramount) - coalesce(o.amount,0)*id)*j.id,2) balance,b.branchname,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys,j.brhid from my_jvtran j inner join my_head h "
				+ "on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.AP_trid where j.date<='"+sqlUpToDate+"' group by tranid) o on "
				+ "j.tranid=o.tranid inner join my_brch b on j.brhId=b.doc_no where j.status=3 and h.atype='"+atype+"' and j.acno="+acno+" and j.date<='"+sqlUpToDate+"'"+sqld+" group by j.tranid having balance<>0 order by j.date) a"+joins+"";
	
	System.out.println("unapplied query======"+sqlUnapply);
	
	ResultSet resultSetUnapply = stmtAgeingStatement.executeQuery(sqlUnapply);
	
	while(resultSetUnapply.next()){
		sqlUnapplyResult="1";
	}
	
	if(sqlUnapplyResult.equalsIgnoreCase("0")){
		sqlUnapply="select null date,null transno,null transType,null ref_detail,null branchname,null description,null netamount,null applied,null balance,null duedys";
	}
	
	String sqlOutStanding = "select "+casestatement+"a.date,a.transType,a.ref_detail,a.branchname,a.description,round(a.netamount,2) netamount,round(a.applied,2) applied,round(a.balance,2) balance,a.duedys,a.brhid from ("
				+ "select j.doc_no transNo,coalesce(j.ref_detail,'') ref_detail,j.description,DATE_FORMAT((j.date),'%d-%m-%Y') date,j.dtype transType,round(sum(j.dramount)*j.id,2) netamount,round(coalesce(o.amount,0),2) applied," 
				+ "round((sum(dramount) - coalesce(o.amount,0)*id)*j.id,2) balance,b.branchname,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys,j.brhid from my_jvtran j inner join my_head h "
				+ "on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.trANid where j.date<='"+sqlUpToDate+"' group by AP_trid) o on "
				+ "j.tranid=o.ap_trid inner join my_brch b on j.brhId=b.doc_no where j.status=3 and h.atype='"+atype+"' and j.acno="+acno+" and j.date<='"+sqlUpToDate+"'"+sqld1+" group by j.tranid having balance<>0 order by j.date) a"+joins+"";
	
	String sqlTotal = "select round(sum(unappliedramount),2) totalunappliedamount,round(sum(unappliedoutamount),2) totalapplied,round(sum(unappliedbalance),2) unappliedbalance,round(sum(applieddramount),2) totaloutamount,"
			+ "round(sum(appliedoutamount),2) totaloutapplied,round(sum(appliedbalance),2) outstandingbalance,round(coalesce(sum(appliedbalance),0)-coalesce(sum(unappliedbalance),0),2) nettotal from (" +  
			"select 0 applieddramount,0 appliedoutamount,0 appliedbalance,round(sum(j.dramount)*j.id,2) unappliedramount,"
			+ "coalesce(o.amount,0) unappliedoutamount,round((sum(dramount) - coalesce(o.amount,0)*id)*j.id,2) unappliedbalance " +
			" from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount "
			+ "from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"'" +
			" group by tranid) o on j.tranid=o.tranid inner join my_brch b on j.brhId=b.doc_no where j.status=3 and h.atype='"+atype+"' and j.acno="+acno+" and j.date<='"+sqlUpToDate+"'"+sqld+" group by j.tranid having unappliedbalance<>0 UNION ALL" +
			" select round(sum(j.dramount)*j.id,2) applieddramount,coalesce(o.amount,0)*id appliedoutamount,round((sum(dramount) - coalesce(o.amount,0)*id)*j.id,2) appliedbalance,0 unappliedramount,0 unappliedoutamount,0 unappliedbalance from my_jvtran j" +
			" inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.tranid where j.date<='"+sqlUpToDate+"' group by ap_trid) o on j.tranid=o.ap_trid " +
			" inner join my_brch b on j.brhId=b.doc_no where j.status=3 and h.atype='"+atype+"' and j.acno="+acno+" and j.date<='"+sqlUpToDate+"'"+sqld1+" group by j.tranid having appliedbalance<>0) a";
			
	ResultSet resultSetTotal = stmtAgeingStatement.executeQuery(sqlTotal);
	
	while(resultSetTotal.next()){
		ageingStatementBean.setLblsumnetamount(resultSetTotal.getString("totalunappliedamount"));
		ageingStatementBean.setLblsumapplied(resultSetTotal.getString("totalapplied"));
		ageingStatementBean.setLblsumbalance(resultSetTotal.getString("unappliedbalance"));
		
		ageingStatementBean.setLblsumoutnetamount(resultSetTotal.getString("totaloutamount"));
		ageingStatementBean.setLblsumoutapplied(resultSetTotal.getString("totaloutapplied"));
		ageingStatementBean.setLblsumoutbalance(resultSetTotal.getString("outstandingbalance"));
		
		ageingStatementBean.setLblnetamount(resultSetTotal.getString("nettotal"));
	}
    
	String unclearedreceiptssql = "",sqlUnclrAccountStatementResult="0";
   	Double netunclrdebittotal=0.00;Double netunclrcredittotal=0.00;Double netunclramount=0.00;
   	   
	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
			unclearedreceiptssql+=" and m.brhId="+branch+"";
		}
	
		unclearedreceiptssql="select a.*,coalesce(round(@i:=@i+amount,2),0) netamountvalue from (SELECT m.doc_no,DATE_FORMAT((m.date),'%d-%m-%Y') date,m.dtype,m.chqno,DATE_FORMAT((m.chqdt),'%d-%m-%Y') chqdt,m.chqname,CONVERT(if(d.amount>0,round((d.amount*1),2),null),CHAR(100)) debit,"  
		   		+ "CONVERT(if(d.amount<0,round((d.amount*-1),2),' '),CHAR(100)) credit,d.amount FROM my_unclrchqreceiptm m left join my_unclrchqreceiptd d on m.doc_no=d.rdocno where m.status=3 and m.bpvno=0 and d.acno="+acno+""+unclearedreceiptssql+") a,"
				+ "(select @i:=0) as i";
		
		ResultSet resultSetUnclearAgeingStatement = stmtAgeingStatement.executeQuery(unclearedreceiptssql);
	//	System.out.println("uncleadred cheque"+unclearedreceiptssql);
		while(resultSetUnclearAgeingStatement.next()){
			sqlUnclrAccountStatementResult="1";
			netunclrdebittotal=netunclrdebittotal+resultSetUnclearAgeingStatement.getDouble("debit");
			netunclrcredittotal=netunclrcredittotal+resultSetUnclearAgeingStatement.getDouble("credit");
		}
		
		netunclramount=netunclrdebittotal-netunclrcredittotal;
		
		netunclrdebittotal = objcommon.Round(netunclrdebittotal, 2);
		netunclrcredittotal = objcommon.Round(netunclrcredittotal, 2);
		netunclramount = objcommon.Round(netunclramount, 2);
		
		String unclearedreceiptssql2 = "",sqlUnclrAccountStatementResult2="0";
		Double netunclrdebittotalnew=0.00;Double netunclrcredittotalnew=0.00;Double netunclramountnew=0.00;
		
		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
			unclearedreceiptssql2+=" and m.brhId="+branch+"";
		}
	
		unclearedreceiptssql2="select a.*,coalesce(round(@i:=@i+amount,2),0) netamountvalue from (SELECT m.doc_no,DATE_FORMAT((m.date),'%d-%m-%Y') date,"
			+ " m.dtype,m.chqno,DATE_FORMAT((m.chqdt),'%d-%m-%Y') chqdt,m.chqname,CONVERT(if(d.amount>0,round((d.amount*1),2),null),CHAR(100)) debit,"
			+" CONVERT(if(d.amount<0,round((d.amount*-1),2),0.00),CHAR(100)) credit,d.amount FROM my_chqbm m "
		+" left join my_chqbd d on (m.tr_no=d.tr_no and m.brhid=d.brhid) left join my_chqdet d1 on m.tr_no=d1.tr_no "
		+" where m.status=3 and d1.pdc=1 and d1.status='E' and m.date<='"+uptoDate+"' and d.acno = "+acno+" "+unclearedreceiptssql2+" ) a, (select @i:=0) as i order by date ";
	//System.out.println("===sqllaaa=="+unclearedreceiptssql2);
		ResultSet resultSetUnclearAccountStatement = stmtAgeingStatement.executeQuery(unclearedreceiptssql2);
		
		while(resultSetUnclearAccountStatement.next()){
			sqlUnclrAccountStatementResult2="1";
			netunclrdebittotalnew=netunclrdebittotalnew+resultSetUnclearAccountStatement.getDouble("debit");
			netunclrcredittotalnew=netunclrcredittotalnew+resultSetUnclearAccountStatement.getDouble("credit");
		}
		
		netunclramountnew=netunclrdebittotalnew-netunclrcredittotalnew;

		netunclrdebittotalnew = objcommon.Round(netunclrdebittotalnew, 2);
		netunclrcredittotalnew = objcommon.Round(netunclrcredittotalnew, 2);
		netunclramountnew = objcommon.Round(netunclramountnew, 2);
	
		//System.out.println("amount:"+netunclrdebittotalnew+netunclrcredittotalnew+netunclramountnew);
		//System.out.println("outstanding query====="+sqlOutStanding);
		lblprintname=ageingStatementBean.getLblprintname()+" "+ageingStatementBean.getLblprintname1();
		String reportFileName = objcommon.getBIBPrintPath("BAGS");
    	String lblaccount="",lblcreditperiod="",lblcreditlimit="",lblcurrency="";
		if(reportFileName.contains("ageingStatementAlfahimPrint.jrxml")){
    		lblaccount=ageingStatementBean.getLblaccountno()+" - "+ageingStatementBean.getLblaccountname();
    	} else {
    		lblaccount=ageingStatementBean.getLblaccountname()+" - "+ageingStatementBean.getLblaccountaddress()+" - "+ageingStatementBean.getLblaccountmobileno();            	
    	}
	
		lblcreditperiod="Credit Period :   "+ageingStatementBean.getLblcreditperiodmin()+" (Days)";
    	lblcreditlimit="Credit Limit :   "+ageingStatementBean.getLblcreditlimit();
    	lblcurrency="Currency :   "+ageingStatementBean.getLblcurrencycode();
    	ResultSet rsunapplied=stmtAgeingStatement.executeQuery(sqlUnapply);
    	result="<table id='tabledata'><thead><tr><th>Date</th><th>Docno</th><th>Type</th><th>Branch</th><th>RefNo</th><th>Description</th><th>Amount</th><th>Applied</th><th>Balance</th><th>Age</th></tr></thead><tbody>";
    	result+="<tr><td colspan='10'>"+lblaccount+"</td></tr>";
    	result+="<tr><td colspan='3'>"+lblcreditperiod+"</td><td colspan='3'>"+lblcreditlimit+"</td><td colspan='4'>"+lblcurrency+"</td></tr>";
    	if(sqlUnapplyResult.equalsIgnoreCase("1")){
        	result+="<tr><td colspan='10' align='center' style='font-weight:bold'>Unapplied</td></tr>";
        	while(rsunapplied.next()){
        		result+="<tr>";
        		result+="<td>"+rsunapplied.getString("date")+"</td><td>"+rsunapplied.getString("transno")+"</td><td>"+rsunapplied.getString("transType")+"</td><td>"+rsunapplied.getString("branchname")+"</td><td>"+rsunapplied.getString("ref_detail")+"</td><td>"+rsunapplied.getString("description")+"</td><td>"+rsunapplied.getString("netamount")+"</td><td>"+rsunapplied.getString("applied")+"</td><td>"+rsunapplied.getString("balance")+"</td><td>"+rsunapplied.getString("duedys")+"</td>";
        		result+="</tr>";
        	}    		
    	}
    	result+="<tr><td colspan='10' align='center' style='font-weight:bold'>Outstanding</td></tr>";
    	ResultSet rsoutstanding=stmtAgeingStatement.executeQuery(sqlOutStanding);
    	while(rsoutstanding.next()){
    		result+="<tr>";
    		result+="<td>"+rsoutstanding.getString("date")+"</td><td>"+rsoutstanding.getString("transno")+"</td><td>"+rsoutstanding.getString("transType")+"</td><td>"+rsoutstanding.getString("branchname")+"</td><td>"+rsoutstanding.getString("ref_detail")+"</td><td>"+rsoutstanding.getString("description")+"</td><td>"+rsoutstanding.getString("netamount")+"</td><td>"+rsoutstanding.getString("applied")+"</td><td>"+rsoutstanding.getString("balance")+"</td><td>"+rsoutstanding.getString("duedys")+"</td>";
    		result+="</tr>";
    	}
    	/* result+="<tr><td colspan='10' align='center'>Ageing Summary</td></tr>";
    	ResultSet rsageing=stmtAgeingStatement.executeQuery(sqlAgeing);
    	while(rsageing.next()){
    		result+="<tr>";
    		result+="<td>"+rsageing.getString("date")+"</td><td>"+rsageing.getString("transno")+"</td><td>"+rsageing.getString("transType")+"</td><td>"+rsageing.getString("branchname")+"</td><td>"+rsageing.getString("ref_detail")+"</td><td>"+rsageing.getString("description")+"</td><td>"+rsageing.getString("netamount")+"</td><td>"+rsageing.getString("applied")+"</td><td>"+rsageing.getString("balance")+"</td><td>"+rsageing.getString("duedys")+"</td>";
    		result+="</tr>";
    	}
    	result+="<tr><td colspan='8'>&nbsp;</td><td>Net Total:</td><td align:'right'>"+ageingStatementBean.getLblnetamount()+"</td></tr>";
 		 */
 		 result+="</tbody></table>";
    	/*    param.put("ageingstatementunapplysql", sqlUnapply);
    param.put("unappliedtotalamount", ageingStatementBean.getLblsumnetamount());
    param.put("unappliedtotalapplied", ageingStatementBean.getLblsumapplied());
    param.put("unappliedtotalbalance", ageingStatementBean.getLblsumbalance());
    param.put("ageingstatementoutstandingsql", sqlOutStanding);
    param.put("outstandingtotalamount", ageingStatementBean.getLblsumoutnetamount());
    param.put("outstandingtotalapplied", ageingStatementBean.getLblsumoutapplied());
    param.put("outstandingtotalbalance", ageingStatementBean.getLblsumoutbalance());
    param.put("ageingstatementsummarysql", sqlAgeing);
    param.put("level1", level1from+" - "+level1to);
    param.put("level2", level2from+" - "+level2to);
    param.put("level3", level3from+" - "+level3to);
    param.put("level4", level4from+" - "+level4to);
    param.put("level5", ">="+level5from+" days");
   // param.put("unclearedreceiptssql", unclearedreceiptssql);
   // param.put("unclearedreceiptssqlnew", unclearedreceiptssql2);
    param.put("unclearedreceiptscheck", sqlUnclrAccountStatementResult);
    param.put("unclrdebittotal", String.valueOf(netunclrdebittotal));
    param.put("unclrcredittotal", String.valueOf(netunclrcredittotal));
    param.put("unclrnettotal", String.valueOf(netunclramount));
    param.put("nettotalamount", ageingStatementBean.getLblnetamount());
    param.put("printby", session.getAttribute("USERNAME"));
    param.put("debit", netunclrdebittotalnew);
    param.put("credit", netunclrcredittotalnew);
    param.put("nettotal", netunclramountnew); */ 
    
    stmtAgeingStatement.close();

}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(result+"::"+lblprintname);
%>