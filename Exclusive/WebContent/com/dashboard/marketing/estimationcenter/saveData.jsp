<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% 
 String remark =request.getParameter("remark")==null?"0":request.getParameter("remark").toString();
 String amount =request.getParameter("amount")==null?"0":request.getParameter("amount").toString();
 String reftrno =request.getParameter("reftrno")==null?"0":request.getParameter("reftrno").toString();
 String brhid1 =request.getParameter("brhid1")==null?"0":request.getParameter("brhid1").toString();
 String refdtype =request.getParameter("refdtype")==null?"0":request.getParameter("refdtype").toString();
 String asgnuserid =request.getParameter("userid")==null?"0":request.getParameter("userid").toString();

 //System.out.println("schtrno=="+schtrno);
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();
int rs=0;
	try{
		String userid=session.getAttribute("USERID").toString();
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		
			 String sqlbesc="insert into gl_besc (dtype, refDocNo, brhid, userid, asgnuserid,amount,remark) values ('"+refdtype+"','"+reftrno+"',"+brhid1+","+userid+","+asgnuserid+","+amount+",'"+remark+"')";
			rs=stmt.executeUpdate(sqlbesc);
		
		response.getWriter().write(rs+"###"+reftrno);

		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  