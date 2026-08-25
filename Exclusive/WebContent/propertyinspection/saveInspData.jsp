<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
	String tncdocno=request.getParameter("tncdocno")==null?"0":request.getParameter("tncdocno");
	String propdocno=request.getParameter("propdocno")==null?"0":request.getParameter("propdocno");
	String insptype=request.getParameter("insptype")==null?"0":request.getParameter("insptype");
	String strinsparray=request.getParameter("insparray")==null?"0":request.getParameter("insparray");
	String strkeyarray=request.getParameter("keyarray")==null?"0":request.getParameter("keyarray");
	String inspdocno=request.getParameter("inspdocno")==null?"0":request.getParameter("inspdocno");
	String scheduledate=request.getParameter("scheduledate")==null?"":request.getParameter("scheduledate");
	System.out.println("Insp Doc No:"+inspdocno);
	System.out.println("As Recieved:"+strinsparray);
	ArrayList<String> insparray=new ArrayList();
	if(!strinsparray.trim().equalsIgnoreCase("")){
		for(int i=0;i<strinsparray.split(",").length;i++){
			insparray.add(strinsparray.split(",")[i]);
		}		
	}
	ArrayList<String> keyarray=new ArrayList();
	if(!strkeyarray.trim().equalsIgnoreCase("")){
		for(int i=0;i<strkeyarray.split(",").length;i++){
			keyarray.add(strkeyarray.split(",")[i]);
		}		
	}
	
	Connection conn=null;
	int errorstatus=0;
	int docno=0;
	try{
		ClsConnection objconn=new ClsConnection();
		ClsCommon objcommon=new ClsCommon();
		conn=objconn.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmt=conn.createStatement();
		java.sql.Date sqlscheduletdate=null;
		if(!scheduledate.equalsIgnoreCase("")){
			sqlscheduletdate=objcommon.changeStringtoSqlDate(scheduledate);
		}
		String branchid=session.getAttribute("BRANCHID")==null?"0":session.getAttribute("BRANCHID").toString();
		String userid=session.getAttribute("USERID")==null?"0":session.getAttribute("USERID").toString();
		java.sql.Date sqlcontractfromdate=null,sqlcontracttodate=null;
		if(!tncdocno.equalsIgnoreCase("")){
			String strgetcontractdate="select period_from fromdate,period_to todate from rl_tncm where doc_no="+tncdocno;
			ResultSet rsgetcontractdate=stmt.executeQuery(strgetcontractdate);
			while(rsgetcontractdate.next()){
				sqlcontractfromdate=rsgetcontractdate.getDate("fromdate");
				sqlcontracttodate=rsgetcontractdate.getDate("todate");
			}
		}
		if(insptype.equalsIgnoreCase("Hand Over")){
			sqlscheduletdate=sqlcontractfromdate;
		}
		else if(insptype.equalsIgnoreCase("Hand Back")){
			sqlscheduletdate=sqlcontracttodate;
		}
		if(inspdocno.equalsIgnoreCase("0")){
			String strmaxdocno="select coalesce(max(doc_no),0)+1 inspdocno from rl_propinspm";
			ResultSet rsmaxdocno=stmt.executeQuery(strmaxdocno);
			while(rsmaxdocno.next()){
				docno=rsmaxdocno.getInt("inspdocno");			
			}
			inspdocno=docno+"";
			String strinsertmaster="insert into rl_propinspm(doc_no, propdocno, tncdocno, inspdate, brhid, userid, status, insptype,insdate)values("+
			""+docno+","+propdocno+","+tncdocno+",now(),"+branchid+","+userid+",3,'"+insptype+"','"+sqlscheduletdate+"')";
			System.out.println(strinsertmaster);
			int insertmaster=stmt.executeUpdate(strinsertmaster);
			if(insertmaster<=0){
				errorstatus=1;
			}
		}
		else{
			docno=Integer.parseInt(inspdocno);
			String strdelete="delete from rl_propinspd where rdocno="+docno;
			int delete=stmt.executeUpdate(strdelete);
			String strdeletekeys="delete from rl_propkeys where rdocno="+docno;
			int deletekeys=stmt.executeUpdate(strdeletekeys);
		}
		for(int i=0;i<insparray.size();i++){
			String roomdocno=insparray.get(i).split("::")[0].trim();
			String furndocno=insparray.get(i).split("::")[1].trim();
			String comment=insparray.get(i).split("::")[2].trim();
			String inspstatus=insparray.get(i).split("::")[3].trim();
			if(inspstatus.trim().equalsIgnoreCase("") || inspstatus==null || inspstatus.trim().equalsIgnoreCase("undefined")){
				inspstatus="0";
			}
			String strinsertdetail="insert into rl_propinspd(rdocno, roomdocno, furndocno, comments, inspstatus, status)values("+
			""+docno+","+roomdocno+","+furndocno+",'"+comment+"',"+inspstatus+",3)";
			System.out.println(strinsertdetail);
			int insertdetail=stmt.executeUpdate(strinsertdetail);
			if(insertdetail<=0){
				errorstatus=1;
			}
		}
		for(int i=0;i<keyarray.size();i++){
			String keydocno=keyarray.get(i).split("::")[0].trim();
			String comment=keyarray.get(i).split("::")[1].trim();
			String strinsertkeys="insert into rl_propkeys(rdocno,keydocno,comments)values("+docno+","+keydocno+",'"+comment+"')";
			System.out.println(strinsertkeys);
			int insertkey=stmt.executeUpdate(strinsertkeys);
			if(insertkey<=0){
				errorstatus=1;
			}
		}
		
		if(errorstatus==0){
			
			String strupdateproperty="update rl_propertymaster set inspdocno="+inspdocno+" where doc_no="+propdocno;
			System.out.println(strupdateproperty);
			int updateproperty=stmt.executeUpdate(strupdateproperty);
			if(updateproperty<0){
				errorstatus=1;
			}
		}
		if(errorstatus==0){
			conn.commit();
		}
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	response.getWriter().write((errorstatus==0?docno:0)+"");
%>