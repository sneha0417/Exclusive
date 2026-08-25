<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();

	Connection conn = null;
	
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select shipment shipment1 ,doc_no from cr_shipment where  status=3";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String shipment="",sr="";
		while(rs.next()) {
					shipment+=rs.getString("shipment1")+",";
					sr+=rs.getString("doc_no")+",";
				} 
		
		String shipments[]=shipment.split(",");
		String shipmentId[]=sr.split(",");
		
		shipment=shipment.substring(0, shipment.length()-1);
		sr=sr.substring(0, sr.length()-1);
		
		response.getWriter().write(sr+"####"+shipment);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  