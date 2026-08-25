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
<%@page import="com.dashboard.humanresource.timesheetreview.ClsTimeSheetReviewDAO" %>
<%	

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	ClsTimeSheetReviewDAO DAO=new ClsTimeSheetReviewDAO();

	Connection conn = null;

	try{
		
		
	 	 conn = ClsConnection.getMyConnection();
	 	 conn.setAutoCommit(false);
		 Statement stmt = conn.createStatement();
		
		 String date=request.getParameter("date");
		 String empdocno=request.getParameter("empdocno");
		 String costtype=request.getParameter("costtype");
		 String costcode=request.getParameter("costcode");
		 String normalhrs=request.getParameter("normalhrs");
		 String overtimehrs=request.getParameter("overtimehrs");
		 String holidayovertimehrs=request.getParameter("holidayovertimehrs");
		 String rowno=request.getParameter("rowno");
		 String mode=request.getParameter("mode");
		 String intime=request.getParameter("intime");
		 String outtime=request.getParameter("outtime");
		
		 java.sql.Date sqlDate=null;
		
		 if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(date);
		 }
		
		 String sql=null;
		 int val=0;
	
		 if(mode.equalsIgnoreCase("E")) {
			 
			 /*Edit */
			 String[] normalHour=normalhrs.split(":");
			 String[] otHour=overtimehrs.split(":");
			 String[] hotHour=holidayovertimehrs.split(":");
			 
			 int normalHourInHour = (Integer.parseInt(normalHour[0]) * 60)+ Integer.parseInt(normalHour[1]); 
			 int otInHour = (Integer.parseInt(otHour[0]) * 60)+ Integer.parseInt(otHour[1]);
			 int hotInHour = (Integer.parseInt(hotHour[0]) * 60)+ Integer.parseInt(hotHour[1]);
			 
			 val=DAO.timeSheetUpdate(conn,sqlDate,empdocno,normalhrs,intime,outtime,costtype,costcode,rowno);
			 
	    	 /* sql="update hr_timesheethrs set date='"+sqlDate+"', empid='"+empdocno+"', costtype='"+costtype+"', costcode='"+costcode+"', normalhrs='"+normalhrs+"', othrs='"+overtimehrs+"', hothrs='"+holidayovertimehrs+"', normal='"+normalHourInHour+"', ot='"+otInHour+"', hot='"+hotInHour+"' where status=3 and rowno='"+rowno+"'";
	    	 val= stmt.executeUpdate(sql); */
	     	/*Edit Ends*/
	     	
		 } else if(mode.equalsIgnoreCase("D")) {
			 
			 /*Delete */
			 System.out.println("----mode--- "+mode);
			 
			 val=DAO.timeSheetDelete(conn,sqlDate,empdocno,rowno);
			 
			 System.out.println("----value--- "+val);
	    	 /* sql="update hr_timesheethrs set status=7 where status=3 and rowno='"+rowno+"'";
	     	 val= stmt.executeUpdate(sql); */
	     	/*Delete Ends*/
	     	
		 }
		 
     	 //sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+rowno+"','"+session.getAttribute("BRANCHID").toString()+"','BTSR',now(),'"+session.getAttribute("USERID").toString()+"','"+mode+"')";
	 	 //int data= stmt.executeUpdate(sql);
		 				
		response.getWriter().print(val);

	 	stmt.close();
	 	conn.commit();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   } finally{
	   conn.close();
   }
	
%>
