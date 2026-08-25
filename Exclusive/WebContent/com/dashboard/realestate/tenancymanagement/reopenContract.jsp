<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
	String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
	String propdocno=request.getParameter("propdocno")==null?"":request.getParameter("propdocno");	
	String vocno=request.getParameter("vocno")==null?"":request.getParameter("vocno");	
	Connection conn=null;
	int errorstatus=0;
	try{
		ClsConnection objconn=new ClsConnection();
		conn=objconn.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmt=conn.createStatement();
		String strcheckcontract="select coalesce(max(doc_no),0) maxdocno from rl_tncm where prtype="+propdocno+" and status=3 group by prtype";
		System.out.println(strcheckcontract);
		int maxdocno=0;
		ResultSet rscheckcontract=stmt.executeQuery(strcheckcontract);
		while(rscheckcontract.next()){
			maxdocno=rscheckcontract.getInt("maxdocno");
		}
		if(Integer.parseInt(docno)!=maxdocno){
			errorstatus=2;
		}
		if(errorstatus==0){
			String strupdatemaster="update rl_tncm set clstatus=0 where doc_no="+docno;
			int updatemaster=stmt.executeUpdate(strupdatemaster);
			if(updatemaster<=0){
				System.out.println("Update Master Error");
				errorstatus=1;
			}
			String strupdateproperty="update rl_tncm m left join rl_propertymaster prop on m.prtype=prop.doc_no set prop.cnt_no=m.doc_no,prop.cnt_date=m.period_to where m.doc_no="+docno;
			int updateproperty=stmt.executeUpdate(strupdateproperty);
			if(updateproperty<=0){
				System.out.println("Update Property Error");
				errorstatus=1;
			}
			String branchid=session.getAttribute("BRANCHID")==null?"":session.getAttribute("BRANCHID").toString();
			String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
			String username=session.getAttribute("USERNAME")==null?"":session.getAttribute("USERNAME").toString();
			String systemremarks="Contract re-opening of TNC "+vocno+" by "+username;
			String strloginsert="insert into rl_tncmgmtlog(docno, brhid, userid, logdate, process, remarks, systemremarks)values("+docno+","+branchid+","+userid+",now(),1,'','"+systemremarks+"')";
			System.out.println(strloginsert);
			int loginsert=stmt.executeUpdate(strloginsert);
			if(loginsert<=0){
				errorstatus=1;
			}
		}
		if(errorstatus==0){
			conn.commit();
		}
	}
	catch(Exception e){
		e.printStackTrace();
		errorstatus=1;
	}
	finally{
		conn.close();
	}
	response.getWriter().write(errorstatus+"");
%>