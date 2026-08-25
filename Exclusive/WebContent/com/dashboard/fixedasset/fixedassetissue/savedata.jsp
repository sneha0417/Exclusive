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

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon(); 
	
	String groupno = request.getParameter("groupno")==null || request.getParameter("groupno").trim().equalsIgnoreCase("")?"0":request.getParameter("groupno").trim();
	String issue_ret= request.getParameter("issue_ret")==null || request.getParameter("issue_ret").trim().equalsIgnoreCase("")?"0":request.getParameter("issue_ret").trim();
	String hidfixmsrno=request.getParameter("hidfixmsrno")==null || request.getParameter("hidfixmsrno").trim().equalsIgnoreCase("")?"0":request.getParameter("hidfixmsrno").trim();
	String userid = request.getParameter("userid")==null || request.getParameter("userid").trim().equalsIgnoreCase("")?"0":request.getParameter("userid").trim();
	String sbrhid = request.getParameter("sbrhid")==null || request.getParameter("sbrhid").trim().equalsIgnoreCase("")?"1":request.getParameter("sbrhid").trim();
	String issueddate= request.getParameter("issueddate")==null || request.getParameter("issueddate").trim().equalsIgnoreCase("")?"0":request.getParameter("issueddate").trim();
    String issuedtime = request.getParameter("issuedtime")==null || request.getParameter("issuedtime").trim().equalsIgnoreCase("")?"0":request.getParameter("issuedtime").trim();
	String txtbranchid= request.getParameter("txtbranchid")==null || request.getParameter("txtbranchid").trim().equalsIgnoreCase("")?"0":request.getParameter("txtbranchid").trim();
	String txtjobid=request.getParameter("txtjobid")==null || request.getParameter("txtjobid").trim().equalsIgnoreCase("")?"0":request.getParameter("txtjobid").trim();
	String txtempid = request.getParameter("txtempid")==null || request.getParameter("txtempid").trim().equalsIgnoreCase("")?"0":request.getParameter("txtempid").trim();
	String txtdesp= request.getParameter("txtdesp")==null || request.getParameter("txtdesp").trim().equalsIgnoreCase("")?"0":request.getParameter("txtdesp").trim();
	String cmbtype = request.getParameter("cmbtype")==null || request.getParameter("cmbtype").trim().equalsIgnoreCase("")?"0":request.getParameter("cmbtype").trim();
	String cmbjobtype= request.getParameter("cmbjobtype")==null || request.getParameter("cmbjobtype").trim().equalsIgnoreCase("")?"0":request.getParameter("cmbjobtype").trim();
	String hidbranch= request.getParameter("hidbranch")==null || request.getParameter("hidbranch").trim().equalsIgnoreCase("")?"0":request.getParameter("hidbranch").trim();

	 Connection conn=null;

	 try{
		    int val=0;
			java.sql.Date sqlIssuedDate=null;
            issueddate.trim();
            if(!(issueddate.equalsIgnoreCase("undefined"))&&!(issueddate.equalsIgnoreCase(""))&&!(issueddate.equalsIgnoreCase("0"))) {
            	sqlIssuedDate = ClsCommon.changeStringtoSqlDate(issueddate);
            }
            
		 	conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();
			Statement stmt1 = conn.createStatement();
	
			String maxdocno="";
			String issu_status="";
			String upfixmsql="";
			String insql="";
			
			String getdocno="select coalesce((max(doc_no)+1),1) docNo from gl_bfai";
			ResultSet result = stmt1.executeQuery(getdocno); 
    		while(result.next()){
    	 		maxdocno=result.getString("docNo");
    		}
    	   if(cmbtype.equalsIgnoreCase("1")){
				    issu_status="1";
					insql="insert into gl_bfai(doc_no, date, issuedstatus, issuedt, issuedtime, empid, jobtype, jobno, asset_no, trbrhid_from, trbrhid_to, description, brhid, userid, status) values('"+maxdocno+"',now(),'"+issu_status+"','"+sqlIssuedDate+"','"+issuedtime+"','"+txtempid+"','"+cmbjobtype+"','"+txtjobid+"','"+hidfixmsrno+"','"+hidbranch+"','"+txtbranchid+"', '"+txtdesp+"','"+sbrhid+"','"+userid+"',3);";
					upfixmsql="update my_fixm set issue_status='"+issu_status+"',trbrhid='"+txtbranchid+"' where sr_no='"+hidfixmsrno+"' ;" ;
			} else if(cmbtype.equalsIgnoreCase("2")){
				    issu_status="2";
					insql="insert into gl_bfai(doc_no, date, issuedstatus, issuedt, issuedtime, empid, jobtype, jobno, asset_no, trbrhid_from, trbrhid_to, description, brhid, userid, status) values('"+maxdocno+"',now(),'"+issu_status+"','"+sqlIssuedDate+"','"+issuedtime+"','"+txtempid+"','"+cmbjobtype+"','"+txtjobid+"','"+hidfixmsrno+"','"+sbrhid+"','"+sbrhid+"', '"+txtdesp+"','"+sbrhid+"','"+userid+"',3);";
					upfixmsql="update my_fixm set issue_status='"+issu_status+"',issuedt='"+sqlIssuedDate+"',trbrhid='"+sbrhid+"' where sr_no='"+hidfixmsrno+"' ;" ;
			}
			 else if(cmbtype.equalsIgnoreCase("3")){
				    issu_status="3";
				    insql="insert into gl_bfai(doc_no, date, issuedstatus, returneddt, issuedtime, empid, jobtype, jobno, asset_no, trbrhid_from, trbrhid_to, description, brhid, userid, status) values('"+maxdocno+"',now(),'"+issu_status+"','"+sqlIssuedDate+"','"+issuedtime+"','"+txtempid+"','"+cmbjobtype+"','"+txtjobid+"','"+hidfixmsrno+"','"+sbrhid+"','"+sbrhid+"', '"+txtdesp+"','"+sbrhid+"','"+userid+"',3);";
				    upfixmsql="update my_fixm set issue_status='"+issu_status+"',trbrhid='"+sbrhid+"' where sr_no='"+hidfixmsrno+"' ;" ;
			}
				
		    val= stmt.executeUpdate(insql);
			val= stmt.executeUpdate(upfixmsql);
			String datalog="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+maxdocno+"','"+sbrhid+"','BFAI',now(),'"+userid+"','A')";
			stmt.executeUpdate(datalog);
	        response.getWriter().print(val);
    		
	 		stmt.close();
	 		conn.close();
	 	  
	 }
	 catch(Exception e){

	 			conn.close();
	 			e.printStackTrace();
	 		}
	%>
