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
		
		String sql = "select method from gl_config where field_nme='tax'";
		ResultSet rsConfig = stmt.executeQuery(sql);
		
		int configTax=0;
		while(rsConfig.next()) {
			configTax=rsConfig.getInt("method");
		} 

		String docno="0",account="",description="",atype="",curid="",rate="",type="",costtype="",costcode="",taxper="0";
		
		if(configTax==1){
		
		String strSql = "select t.per,t.acno,h.account,h.description,h.atype,h.curid,round(cb.rate,2) rate,c.type,0 costtype,0 costcode from gl_taxmaster t left join "
				+ "my_head h on t.acno=h.doc_no left join my_curr c on h.curid=c.doc_no left join my_curbook cb on h.curid=cb.curid inner join ( select max(cr.doc_no) doc_no,"
				+ "cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo "
				+ "on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where t.status=3 and t.type=1 and t.per>0 and t.fromdate<='"+sqlDate+"' and t.todate>='"+sqlDate+"'";
		
		ResultSet rs = stmt.executeQuery(strSql);
		
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
					taxper=rs.getString("per");
				} 
		
		}
		
		response.getWriter().write(docno+"####"+account+"####"+description+"####"+atype+"####"+curid+"####"+rate+"####"+type+"####"+costtype+"####"+costcode+"####"+taxper);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  