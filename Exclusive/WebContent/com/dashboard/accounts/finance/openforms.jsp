<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.finance.transactions.bankpayment.ClsBankPaymentDAO"%>
<%@page import="com.finance.transactions.bankpayment.ClsBankPaymentBean"%>
<%	
	Connection conn = null;

	try{
		
		ClsConnection connDAO = new ClsConnection();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		String sql = "",result="1";
		int AlreadyExists=0;
		ClsBankPaymentDAO bankPayDAO= new ClsBankPaymentDAO();
		ClsBankPaymentBean bankPaymentBean;

		String docno=request.getParameter("doc");
		int docs=Integer.parseInt(docno);
		/* String bankacno=request.getParameter("bankacno");
		String docno=request.getParameter("docno");
		String mode=request.getParameter("mode"); */
	    System.out.println("======doc======="+docno);
		bankPayDAO.getViewDetails(session,docs);
		
	        //sql = "select method from gl_config where field_nme like'paymentauthorizationformprint'";
		
	    
		
		
		
		response.getWriter().print(result);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  