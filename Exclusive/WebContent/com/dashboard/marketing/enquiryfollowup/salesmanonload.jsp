<%@page import="com.itextpdf.text.log.SysoCounter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% 
		 
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

	try{
		
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		String consql="",chksalmanid="",flag="0";
		
		String checksaleman="select sal_name,doc_no,salesuserlink from my_salm where status=3 and salesuserlink="+session.getAttribute("USERID")+" ";
		ResultSet chksalman=stmt.executeQuery(checksaleman);
		while(chksalman.next()){
					chksalmanid=chksalman.getString("salesuserlink");
					flag="1";
		}	
		if(flag.equalsIgnoreCase("1")){
			consql="select sal_name,doc_no,salesuserlink from my_salm where status=3 and salesuserlink="+session.getAttribute("USERID")+" ";
		}
		else if(flag.equalsIgnoreCase("0")){
				consql="select sal_name,doc_no,salesuserlink from my_salm where status=3 and salesuserlink="+session.getAttribute("USERID")+" "
					+"union select sal_name,doc_no,salesuserlink from my_salm" ;
			}
		ResultSet rsconfg = stmt.executeQuery(consql);
		//System.out.println("consql=="+consql);
		String salman="",salid="",userlink="";
		while(rsconfg.next()) {
			salman+=rsconfg.getString("sal_name")+",";
			salid+=rsconfg.getString("doc_no")+",";
			userlink+=rsconfg.getString("salesuserlink")+",";
				} 
		salman=salman.substring(0, salman.length()-1);
		salid=salid.substring(0, salid.length()-1);
		userlink=userlink.substring(0, userlink.length()-1);
		
		
		/* salman=salman.substring(0, salman.length()-1);
		salid=salid.substring(0, salid.length()-1); */
	/* 	if(salman.length()>0){
			salman=salman.substring(0, salman.length()-1);
		} */
			
		response.getWriter().write(salid+"####"+salman+"####"+userlink);
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  