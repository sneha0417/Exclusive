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

	Connection conn = null;

	try{
	 	 conn = ClsConnection.getMyConnection();
	 	 conn.setAutoCommit(false);
		 Statement stmt = conn.createStatement();
		 Statement stmt1 = conn.createStatement();
		
		 String year=request.getParameter("year");
		 String month=request.getParameter("month");
	   	 String mode=request.getParameter("mode");
	
	   	 int premonth=Integer.parseInt(month)-1;
	   	 
		 int val=0;
		 int pflag=0;
		 int val1=0,val2=0,errorstatus=0;
		 
		 if(mode.equalsIgnoreCase("A")) {
			 
			String strsql1="select * from hr_timesheet where year="+year+" and month="+month+" and payroll_processed=1";
			System.out.println(strsql1);
			ResultSet rs1=stmt.executeQuery(strsql1); 
			while(rs1.next())  {
				pflag=1;
				errorstatus=2;
			} 
	     	
			if(pflag!=1){
				String strsql2="update hr_timesheethrs set confirm=0 where date between '"+year+"-"+month+"-1' and LAST_DAY('"+year+"-"+month+"-1')";
				val1=stmt1.executeUpdate(strsql2);
				System.out.println(strsql2);
				String strsql3="delete h.* from hr_timesheet h left join hr_empm m on h.empid=m.doc_no left join hr_setpaycat c on c.doc_no=m.pay_catid where year="+year+" and month="+month+"  and c.timesheet=1";
				System.out.println(strsql3);
				val2=stmt1.executeUpdate(strsql3);
				if(val1<1 && val2<1){
					errorstatus=1;
				}
			}
			
			
		 } 
		 System.out.println(errorstatus);
		 if(errorstatus==2 || errorstatus==0){
			 conn.commit();
		 }
		response.getWriter().print(errorstatus);

		stmt1.close();
	 	stmt.close();
	 	conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   } finally{
	   conn.close();
   }
	
%>
