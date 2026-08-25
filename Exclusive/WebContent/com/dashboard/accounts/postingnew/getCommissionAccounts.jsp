<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon"%>

<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;
	
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		java.sql.Date sqlDate=null;
		
		String paytype=request.getParameter("paytype")==""?"0":request.getParameter("paytype");
		String date=request.getParameter("date");
		
		if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
        {
     	   sqlDate = ClsCommon.changeStringtoSqlDate(date);
        }
		
		String strSql = "select m.acno,m.costtype,m.costcode,h.account,h.description,h.atype,h.curid,round(cb.rate,2) rate,c.type from my_account m left join my_head h on m.acno=h.doc_no "
				+ "left join my_curr c on h.curid=c.doc_no left join my_curbook cb on h.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,"
				+ "cr.frmDate from my_curbook cr where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no "
				+ "and cb.curid=bo.curid) where m.codeno='COMMISSION ACCOUNT'";
		
		ResultSet rs = stmt.executeQuery(strSql);
		
		String docno="",account="",description="",atype="",curid="",rate="",type="",costtype="",costcode="";
		while(rs.next()) {
					docno=rs.getString("acno");
					account=rs.getString("account");
					description=rs.getString("description");
					atype=rs.getString("atype");
					curid=rs.getString("curid");
					rate=rs.getString("rate");
					type=rs.getString("type");
					costtype=rs.getString("costtype");
					costcode=rs.getString("costcode");
				} 
		
		response.getWriter().write(docno+"####"+account+"####"+description+"####"+atype+"####"+curid+"####"+rate+"####"+type+"####"+costtype+"####"+costcode);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  