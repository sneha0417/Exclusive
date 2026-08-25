<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String cardtype=request.getParameter("cardtype");
		String netamt=request.getParameter("netamt");
		String paytype=request.getParameter("paytype");
		String comm=request.getParameter("comm");
		String index=request.getParameter("index");
		
		double amount = Double.parseDouble(netamt);
		double commissionTotal=0.00,commissionNetTotal=0.00;

		String sql = "select round(("+amount+"*("+comm+"/100)),2) commissiontotal";
		ResultSet rs1 = stmt.executeQuery(sql);
		
		while(rs1.next()) {
			commissionTotal=rs1.getDouble("commissiontotal");
		}
		
		String sql1 = "select round("+amount+"-"+commissionTotal+",2) commissionnettotal";
		ResultSet rs2 = stmt.executeQuery(sql1);
		
		while(rs2.next()) {
			commissionNetTotal=rs2.getDouble("commissionnettotal");
		} 
		
		response.getWriter().write(commissionNetTotal+":"+commissionTotal+":"+index+":"+paytype);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>