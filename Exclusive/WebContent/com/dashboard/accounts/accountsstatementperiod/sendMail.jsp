<%@page import="com.common.ClsCommon"%>
<%@page import="com.dashboard.accounts.accountsstatementperiod.ClsAccountsStatementPeriodAction"%>      
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>
<%@page import="java.io.*" %>
<%@page import="org.apache.struts2.ServletActionContext" %>
<%
    int val=0;    
	ClsConnection objconn=new ClsConnection();  
	ClsCommon ClsCommon=new ClsCommon();
	Connection conn=null;   
	Statement stmt=null;
	ResultSet rs=null;
	try{
		conn=objconn.getMyConnection();
	     stmt=conn.createStatement(); 
		String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
		String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
		String acnoarray=request.getParameter("gridarray")==null?"":request.getParameter("gridarray");
		String print="1",chckopn="1",branch="a";       
		ClsAccountsStatementPeriodAction aspaction=new ClsAccountsStatementPeriodAction();
		                                                     
		aspaction.printAction(conn, branch, fromdate, todate, chckopn, print, acnoarray);
		String sql = "select o.email from  rl_propertryowner o left join rl_propertymaster m on o.doc_no=m.owid where m.acno in("+acnoarray.substring(0, acnoarray.length()-1)+") and (o.email is not null or o.email!='')";                
		 rs=stmt.executeQuery(sql);         
		while(rs.next()){
			val=1;     
		}
	    response.getWriter().print(val);                 
	 
	}catch(Exception e){   
		conn.close();
	 	e.printStackTrace();	
   }
	finally{
		rs.close();
		stmt.close();   
		conn.close();
	}
%>