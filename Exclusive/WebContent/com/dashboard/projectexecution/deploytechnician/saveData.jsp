<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>

<%
	Connection conn = null;

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();


	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt=conn.createStatement();

		String costtype=request.getParameter("costtype")==null || request.getParameter("costtype").trim().equalsIgnoreCase("")?"0":request.getParameter("costtype");
		String costcode=request.getParameter("costcode")==null || request.getParameter("costcode").trim().equalsIgnoreCase("")?"0":request.getParameter("costcode");
		String budget=request.getParameter("budget")==null || request.getParameter("budget").trim().equalsIgnoreCase("")?"0":request.getParameter("budget");
		String consumed=request.getParameter("consumed")==null || request.getParameter("consumed").trim().equalsIgnoreCase("")?"0":request.getParameter("consumed");
		String balance=request.getParameter("balance")==null || request.getParameter("balance").trim().equalsIgnoreCase("")?"0":request.getParameter("balance");
		String gridarray=request.getParameter("gridarray")==null?"":request.getParameter("gridarray");
		
		String sql=null,sql1=null,sql2=null;
		int val = 0, docNo = 0;
		
		ArrayList<String> griddataarray=new ArrayList<String>();
		String[] temparray=gridarray.split(",");
		for(int i=0;i<temparray.length;i++){
			griddataarray.add(temparray[i]);
		}
		
		ArrayList<String> deploytechnicianarray=new ArrayList<String>();
		for(int i=0;i<griddataarray.size();i++){
			String[] temp=griddataarray.get(i).split("::");
			deploytechnicianarray.add(temp[0]+":: "+temp[1]+":: "+temp[2]+":: "+temp[3]+":: "+temp[4]+":: "+temp[5]+":: "+temp[6]+":: "+temp[7]+":: "+temp[8]+":: "+temp[9]+":: "+temp[10]);
		}
			
		if(costtype.contains("AMC") || costtype.contains("amc")) {
			costtype="3";
		} else if(costtype.contains("SJOB") || costtype.contains("sjob")) {
			costtype="4";
		}
		
		sql="select coalesce(max(doc_no)+1,1) doc_no from cm_deploytechm";
        ResultSet resultSet = stmt.executeQuery(sql);
  
        while (resultSet.next()) {
		   docNo=resultSet.getInt("doc_no");
        }
		
		 /*Inserting cm_deploytechm*/
	     sql1="insert into cm_deploytechm(doc_no, date, costtype, costcode, budget, consumed, balance, brhid, userid, status) values('"+docNo+"', now(), '"+costtype+"', '"+costcode+"', '"+budget+"', '"+consumed+"', '"+balance+"', '"+session.getAttribute("BRANCHID").toString()+"', '"+session.getAttribute("USERID").toString()+"', 3)";
	     val= stmt.executeUpdate(sql1); 
		 /*Inserting cm_deploytechm Ends*/
		 
		 /*Inserting cm_deploytechd*/
		 int dataExist=0;
		 Statement stmtBDT = conn.createStatement(); 
		 for(int i=0;i< deploytechnicianarray.size();i++){
		 	 CallableStatement stmtBDT1=null;
		 	 String[] deploytechnician=deploytechnicianarray.get(i).split("::");
			 if(!deploytechnician[0].equalsIgnoreCase("undefined") && !deploytechnician[0].equalsIgnoreCase("NaN")){
				 if(!deploytechnician[1].equalsIgnoreCase("undefined") && !deploytechnician[1].equalsIgnoreCase("NaN")){
					 
					java.sql.Date date=(deploytechnician[0].trim().equalsIgnoreCase("undefined") || deploytechnician[0].trim().equalsIgnoreCase("NaN") || deploytechnician[0].trim().equalsIgnoreCase("") ||  deploytechnician[0].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(deploytechnician[0].trim()));
					String costtypes = (deploytechnician[8].trim().equalsIgnoreCase("undefined") || deploytechnician[8].trim().equalsIgnoreCase("NaN") || deploytechnician[8].trim().equalsIgnoreCase("") ||deploytechnician[8].trim().isEmpty()?0:deploytechnician[8].trim()).toString();
					String empdocno=(deploytechnician[1].trim().equalsIgnoreCase("undefined") || deploytechnician[1].trim().equalsIgnoreCase("NaN") || deploytechnician[1].trim().equalsIgnoreCase("") ||deploytechnician[1].trim().isEmpty()?0:deploytechnician[1].trim()).toString();
					String inttime=(deploytechnician[2].trim().equalsIgnoreCase("undefined") || deploytechnician[2].trim().equalsIgnoreCase("NaN") || deploytechnician[2].trim().equalsIgnoreCase("") ||deploytechnician[2].trim().isEmpty()?0:deploytechnician[2].trim()).toString();
					String outtime=(deploytechnician[3].trim().equalsIgnoreCase("undefined") || deploytechnician[3].trim().equalsIgnoreCase("NaN") || deploytechnician[3].trim().equalsIgnoreCase("") ||deploytechnician[3].trim().isEmpty()?0:deploytechnician[3].trim()).toString();
					if(costtypes.contains("AMC") || costtypes.contains("amc")) {
						costtypes="3";
					} else if(costtypes.contains("SJOB") || costtypes.contains("sjob")) {
						costtypes="4";
					}
					
					String sqlCheck="select * from (select STR_TO_DATE(replace(intime,':',''),'%h%i%s') intime,STR_TO_DATE(replace(outtime,':',''),'%h%i%s') outtime from cm_deploytechd where empid='"+empdocno+"' and date='"+date+"') a where "
							   + "((a.outtime between STR_TO_DATE(replace('"+inttime+"',':',''),'%h%i%s') and STR_TO_DATE(replace('"+outtime+"',':',''),'%h%i%s')) "
							   + "and (a.intime between STR_TO_DATE(replace('"+inttime+"',':',''),'%h%i%s') and STR_TO_DATE(replace('"+outtime+"',':',''),'%h%i%s'))) UNION ALL "
							  
							   + "select * from (select STR_TO_DATE(replace(intime,':',''),'%h%i%s') intime,STR_TO_DATE(replace(outtime,':',''),'%h%i%s') outtime from cm_deploytechd where empid='"+empdocno+"' and date='"+date+"') a where "
							   + "((STR_TO_DATE(replace('"+inttime+"',':',''),'%h%i%s') between a.intime and a.outtime) or (STR_TO_DATE(replace('"+outtime+"',':',''),'%h%i%s') between a.intime and a.outtime)) UNION ALL "
		
							   + "select * from (select STR_TO_DATE(replace(intime,':',''),'%h%i%s') intime,STR_TO_DATE(replace(outtime,':',''),'%h%i%s') outtime from cm_deploytechd where empid='"+empdocno+"' and date='"+date+"') a where "
							   + "((a.outtime<STR_TO_DATE(replace('"+inttime+"',':',''),'%h%i%s')) and (a.intime between STR_TO_DATE(replace('"+inttime+"',':',''),'%h%i%s') and STR_TO_DATE(replace('"+outtime+"',':',''),'%h%i%s'))) UNION ALL "

							   + "select * from (select STR_TO_DATE(replace(intime,':',''),'%h%i%s') intime,STR_TO_DATE(replace(outtime,':',''),'%h%i%s') outtime from cm_deploytechd where empid='"+empdocno+"' and date='"+date+"') a where "
							   + "((a.outtime between STR_TO_DATE(replace('"+inttime+"',':',''),'%h%i%s')  and STR_TO_DATE(replace('"+outtime+"',':',''),'%h%i%s')) and (a.intime>STR_TO_DATE(replace('"+outtime+"',':',''),'%h%i%s'))) UNION ALL "

							   + "select * from (select STR_TO_DATE(replace(intime,':',''),'%h%i%s') intime,STR_TO_DATE(replace(outtime,':',''),'%h%i%s') outtime from cm_deploytechd where empid='"+empdocno+"' and date='"+date+"') a where "
							   + "((STR_TO_DATE(replace('"+inttime+"',':',''),'%h%i%s') < a.intime) and (STR_TO_DATE(replace('"+outtime+"',':',''),'%h%i%s') between a.intime and a.outtime))";
					
					ResultSet resultSetCheck = stmtBDT.executeQuery(sqlCheck);
				    
					while (resultSetCheck.next()) {
					 	val=-1;
					 	dataExist=1;
					}
					
					if(dataExist==1){
						break;
					}
					 
					stmtBDT1 = conn.prepareCall("INSERT INTO cm_deploytechd(date, empid, intime, outtime, hrs, actualhrs, stdcost, total, costtype, costcode, sitename, brhid, rdocno, status) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
					
					stmtBDT1.setDate(1,date);
					stmtBDT1.setString(2,(deploytechnician[1].trim().equalsIgnoreCase("undefined") || deploytechnician[1].trim().equalsIgnoreCase("NaN") || deploytechnician[1].trim().equalsIgnoreCase("") ||deploytechnician[1].trim().isEmpty()?0:deploytechnician[1].trim()).toString());
					stmtBDT1.setString(3,(deploytechnician[2].trim().equalsIgnoreCase("undefined") || deploytechnician[2].trim().equalsIgnoreCase("NaN") || deploytechnician[2].trim().equalsIgnoreCase("") ||deploytechnician[2].trim().isEmpty()?0:deploytechnician[2].trim()).toString());
					stmtBDT1.setString(4,(deploytechnician[3].trim().equalsIgnoreCase("undefined") || deploytechnician[3].trim().equalsIgnoreCase("NaN") || deploytechnician[3].trim().equalsIgnoreCase("") ||deploytechnician[3].trim().isEmpty()?0:deploytechnician[3].trim()).toString());
					stmtBDT1.setString(5,(deploytechnician[4].trim().equalsIgnoreCase("undefined") || deploytechnician[4].trim().equalsIgnoreCase("NaN") || deploytechnician[4].trim().equalsIgnoreCase("") ||deploytechnician[4].trim().isEmpty()?0:deploytechnician[4].trim()).toString());
					stmtBDT1.setString(6,(deploytechnician[5].trim().equalsIgnoreCase("undefined") || deploytechnician[5].trim().equalsIgnoreCase("NaN") || deploytechnician[5].trim().equalsIgnoreCase("") ||deploytechnician[5].trim().isEmpty()?0:deploytechnician[5].trim()).toString());
					stmtBDT1.setString(7,(deploytechnician[6].trim().equalsIgnoreCase("undefined") || deploytechnician[6].trim().equalsIgnoreCase("NaN") || deploytechnician[6].trim().equalsIgnoreCase("") ||deploytechnician[6].trim().isEmpty()?0:deploytechnician[6].trim()).toString());
					stmtBDT1.setString(8,(deploytechnician[7].trim().equalsIgnoreCase("undefined") || deploytechnician[7].trim().equalsIgnoreCase("NaN") || deploytechnician[7].trim().equalsIgnoreCase("") ||deploytechnician[7].trim().isEmpty()?0:deploytechnician[7].trim()).toString());
					stmtBDT1.setString(9,costtypes);
					stmtBDT1.setString(10,(deploytechnician[9].trim().equalsIgnoreCase("undefined") || deploytechnician[9].trim().equalsIgnoreCase("NaN") || deploytechnician[9].trim().equalsIgnoreCase("") ||deploytechnician[9].trim().isEmpty()?0:deploytechnician[9].trim()).toString());
					stmtBDT1.setString(11,(deploytechnician[10].trim().equalsIgnoreCase("undefined") || deploytechnician[10].trim().equalsIgnoreCase("NaN") || deploytechnician[10].trim().equalsIgnoreCase("") ||deploytechnician[10].trim().isEmpty()?0:deploytechnician[10].trim()).toString());
					stmtBDT1.setString(12,session.getAttribute("BRANCHID").toString());
					stmtBDT1.setInt(13,docNo);
					stmtBDT1.setString(14,"3");
					val = stmtBDT1.executeUpdate();
				 
					if(val<=0){
						stmtBDT1.close();
						conn.close();
					}
				 }
			 }
		 }
		 /*Inserting cm_deploytechd Ends*/
		 
		 if(dataExist==0){
	     	sql2="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+session.getAttribute("BRANCHID").toString()+"','BDT',now(),'"+session.getAttribute("USERID").toString()+"','A')";
	     	val= stmt.executeUpdate(sql2); 
		 }
		 
	     response.getWriter().print(val+"***"+docNo);
	
	 	 stmt.close();
	 	 conn.close(); 
	}catch(Exception e){
	 	e.printStackTrace();	
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
  
