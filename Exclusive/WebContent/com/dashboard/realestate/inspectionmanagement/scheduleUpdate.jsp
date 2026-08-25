<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.*"%>
 
<%

String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"":request.getParameter("docno");
String masterdate=request.getParameter("insdate")==null || request.getParameter("insdate")==""?"":request.getParameter("insdate");
String tdocno=request.getParameter("tdocno")==null || request.getParameter("tdocno")==""?"":request.getParameter("tdocno");


System.out.println("date="+masterdate);
ClsCommon ClsCommon = new ClsCommon();
ClsConnection objconn=new ClsConnection();
Connection conn=null;
String msg="";
try{
	
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	String userid=session.getAttribute("USERID").toString();
	Statement st=conn.createStatement();
	Statement st1=conn.createStatement();
	int insertval=0,updateval=0;
	 java.sql.Date insdate = null; 
	String qry = "";
	  
	
	if(!(masterdate.equalsIgnoreCase("undefined"))&&!(masterdate.equalsIgnoreCase(""))&&!(masterdate.equalsIgnoreCase("0"))){
		insdate=ClsCommon.changeStringtoSqlDate(masterdate);   
    }
	 
	
	/* Calculate inspection date starts */ 
	/* if(chk.equalsIgnoreCase("Y"))
	{
		if (insper != null && insper != "" && insper.equalsIgnoreCase("P")) {
		 insdate = ClsCommon.changeStringtoSqlDate(masterdate);
		}
		else if(insper != null && insper != "" && insper.equalsIgnoreCase("T"))
		{
			 insdate = ClsCommon.changeStringtoSqlDate(tdate);	 
		}
	}
	else
	{
	
	
	if (insper != null && insper != ""
			&& insper.equalsIgnoreCase("P")) {
		
		if (instype != null && instype != "") {
			if (instype.equalsIgnoreCase("HY")) {
				qry = "SELECT DATE_ADD( '" + masterdate
						+ "', INTERVAL 6 month ) insdate";
				ResultSet rst = st.executeQuery(qry);
				while (rst.next()) {
					insdate = rst.getDate("insdate");
				}
			} else if (instype.equalsIgnoreCase("Q")) {
				qry = "SELECT DATE_ADD( '" + masterdate
						+ "', INTERVAL 3 month ) insdate";
				ResultSet rst = st.executeQuery(qry);
				while (rst.next()) {
					insdate = rst.getDate("insdate");
				}
			} else if (instype.equalsIgnoreCase("M")) {
				qry = "SELECT DATE_ADD( '" + masterdate
						+ "', INTERVAL 1 month ) insdate";
				ResultSet rst = st.executeQuery(qry);
				while (rst.next()) {
					insdate = rst.getDate("insdate");
				}
			}
		}
	}
	else if (insper != null && insper != ""
			&& insper.equalsIgnoreCase("T")) {
		
		if (instype != null && instype != "") {
			if (instype.equalsIgnoreCase("HY")) {
				qry = "SELECT DATE_ADD( '" + tdate
						+ "', INTERVAL 6 month ) insdate";
				ResultSet rst = st.executeQuery(qry);
				while (rst.next()) {
					insdate = rst.getDate("insdate");
				}
			} else if (instype.equalsIgnoreCase("Q")) {
				qry = "SELECT DATE_ADD( '" + tdate
						+ "', INTERVAL 3 month ) insdate";
				ResultSet rst = st.executeQuery(qry);
				while (rst.next()) {
					insdate = rst.getDate("insdate");
				}
			} else if (instype.equalsIgnoreCase("M")) {
				qry = "SELECT DATE_ADD( '" + tdate
						+ "', INTERVAL 1 month ) insdate";
				ResultSet rst = st.executeQuery(qry);
				while (rst.next()) {
					insdate = rst.getDate("insdate");
				}
			}
		}
	}
	

	}	 */
	/* Calculate inspection date ends */	
	
	String strsql="insert into rl_inspection (pdocno,tdocno,date,userId,created_date) values('"+docno+"','"+tdocno+"','"+insdate+"','"+userid+"',now()) ";
	
	System.out.println("insert sql=" + strsql);
	insertval=st.executeUpdate(strsql);
	 
	String strsql1="update rl_propertymaster set ins_date='"+insdate+"'  where doc_no="+docno+""; 
	updateval=st1.executeUpdate(strsql1); 
	  
	if(insertval>0 && updateval>0){ 
		msg="1";
		conn.commit();
	} 
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(msg);
%>