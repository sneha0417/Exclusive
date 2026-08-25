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
	Connection conn = null;
    ClsConnection ClsConnection=new ClsConnection();

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String year=request.getParameter("year");
		String month=request.getParameter("month");
		String emptotalleavesarray=request.getParameter("emptotalleavesarray");
		String emptotalleavesgridlength=request.getParameter("emptotalleavesgridlength");
		
		//System.out.println("emptotalleavesarray ="+emptotalleavesarray);
		//System.out.println("emptotalleavesgridlength ="+emptotalleavesgridlength);
		
		String sql=null;
		int val=0;
			
		/*Updating Total Leaves and Over Times*/
		for(int j=0;j<Integer.parseInt(emptotalleavesgridlength);j++){
			
			String[] totalleavesarray=emptotalleavesarray.split(",");
			String [] emptotleavesarray = totalleavesarray[j].split("::"); 

			sql="UPDATE hr_timesheet SET tot_leave1="+emptotleavesarray[1]+",tot_leave2="+emptotleavesarray[2]+",tot_leave3="+emptotleavesarray[3]+",tot_leave4="+emptotleavesarray[4]+",tot_leave5="+emptotleavesarray[5]+",tot_leave6="+emptotleavesarray[6]+",tot_ot="+emptotleavesarray[7]+",tot_hot="+emptotleavesarray[8]+" WHERE payroll_processed=0 and empId="+emptotleavesarray[0]+" and year="+year+" and month="+month+"";
			System.out.println("sql ="+sql);
			val= stmt.executeUpdate(sql);
			
		}
		/*Updating Total Leaves and Over Times Ends*/
		 
		// System.out.println("val ="+val);
		
		response.getWriter().print(val);

	 	stmt.close();
	 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
	
%>
