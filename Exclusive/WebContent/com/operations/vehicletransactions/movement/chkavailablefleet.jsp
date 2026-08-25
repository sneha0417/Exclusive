
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


	String valfleet=request.getParameter("valfleet");
	String dateout=request.getParameter("dateout");
	String timeout=request.getParameter("timeout");
	String mode=request.getParameter("mode");
ClsCommon objcommon=new ClsCommon();
ClsConnection objconn=new ClsConnection();
java.sql.Date sqloutdate=null;

if(!(dateout.equalsIgnoreCase("undefined"))&&!(dateout.equalsIgnoreCase(""))&&!(dateout.equalsIgnoreCase("0")))
	{
	sqloutdate=objcommon.changeStringtoSqlDate(dateout);
		
	}
	else{

	}

	 String upsql=null;

	 int val=0;
	 int docval=0;

	 Connection conn=null;

	 try{

	 
    conn = objconn.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	
		
				 /*   upsql="select cast(concat(v.dout,concat(' ',v.tout)) as datetime) dtout,cast(concat(v.din,concat(' ',v.tin)) as datetime) dtin, cast(concat('"+sqloutdate+"',concat(' ','"+timeout+"')) as datetime) agmtdt , (select cast(concat(vm.din,concat(' ',vm.tin)) as datetime) dtin from gl_vmove vm where rdtype='veh' and fleet_no='"+valfleet+"') reldt from gl_vmove v where fleet_no='"+valfleet+"' having (agmtdt  between dtout and dtin) and (agmtdt>reldt)"; */
if(mode.equalsIgnoreCase("add")){
System.out.println("Inside Add");	
	upsql="select cast(concat('"+sqloutdate+"',concat(' ','"+timeout+"')) as datetime) agmtdt ,cast(concat(vm.din,concat(' ',vm.tin)) as datetime) dtin from gl_vmove vm where doc_no=(select max(doc_no) from gl_vmove  where  fleet_no='"+valfleet+"' and status='IN') having agmtdt<dtin";		   
	System.out.println("===== "+upsql); 
	ResultSet resultSet = stmt.executeQuery(upsql);
	 
	   while (resultSet.next()) {
	    	
	    	val=1;
	    }		  
	   String upsql1="select status,tran_code from gl_vehmaster where  fleet_no="+valfleet;		   
	   
	   ResultSet reSet = stmt.executeQuery(upsql1);   
	   
		
	   
	   while(reSet.next()) {
	    	
		   
		   if(reSet.getString("status").equalsIgnoreCase("OUT") )						   
		   {
	    	val=1;
		   }
		  /* if(!(reSet.getString("tran_code").equalsIgnoreCase("RR"))){
			   val=1;
		   }*/ 
		  
	    }		  

}
else if(mode.equalsIgnoreCase("close")){
	System.out.println("Inside Close");
	upsql="select cast(concat('"+sqloutdate+"',concat(' ','"+timeout+"')) as datetime) agmtdt ,cast(concat(vm.dout,concat(' ',vm.tout)) as datetime) dtout from gl_vmove vm where doc_no=(select max(doc_no) from gl_vmove  where  fleet_no='"+valfleet+"' and status='OUT') having agmtdt<dtout";
	System.out.println("Sql:"+upsql);
	ResultSet resultSet = stmt.executeQuery(upsql);
	 
	   while (resultSet.next()) {
	    	
	    	val=1;
	    }		  
	   String upsql1="select status,tran_code from gl_vehmaster where  fleet_no="+valfleet;		   
	   
	   ResultSet reSet = stmt.executeQuery(upsql1);   
	   
		
	   
	   while(reSet.next()) {
	    	
		   
		   if(reSet.getString("status").equalsIgnoreCase("IN") )						   
		   {
	    	val=1;
		   }
	
}
				 
		System.out.println("Fleet Available Value:"+val);
		 response.getWriter().print(val);
	
	 	
	 	stmt.close();
	 	conn.close();
}
	 }
	 catch(Exception e){
	e.printStackTrace();		
			conn.close();
			
		} 
	 finally{
		 conn.close();
	 }

	%>
