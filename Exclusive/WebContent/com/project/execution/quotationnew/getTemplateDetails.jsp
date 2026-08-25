<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
	Connection conn = null;
	
	try{
		ClsConnection connDAO = new ClsConnection();
	 	conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String docNo=request.getParameter("docno")==null || request.getParameter("docno").equalsIgnoreCase("")?"0":request.getParameter("docno");
		String sitename=request.getParameter("sitename")==null || request.getParameter("sitename").equalsIgnoreCase("")?"0":request.getParameter("sitename");
		String siteid=request.getParameter("siteid")==null || request.getParameter("siteid").equalsIgnoreCase("")?"0":request.getParameter("siteid");

		ArrayList<String> templatearray = new ArrayList<String>();
		
		String sql = "select d.description desc1,sc.scode scope,d.scopeid,m.productname product,m.part_no productid,grp.groupname activity,d.sertypeid activityid,bd.brandname,"
				+ "u.unit,d.qty,d.scope_amount scopeamount,d.amount,d.total,d.total nettotal,0 margin,0 invoiced,m.productname proname,m.psrno prodoc,d.unitid unitdocno,"
				+ "m.psrno,m.psrno proid,at.mspecno specid,d.sertypeid stypeid,'"+sitename+"' site,grp.groupname sertype,m.brandid,"+siteid+" sitesrno,d.prdstdcost stdprice,0 marginper,d.lblchrge lbrchg,"
				+ "d.scopestdcost from cm_templatem t left join cm_templated d on t.doc_no=d.rdocno left join my_main m on (d.psrno=m.doc_no and d.prdid=m.doc_no) left join "
				+ "my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on (at.mpsrno=m.doc_no) left join my_unitm u on d.unitid=u.doc_no left join my_groupvals grp on "
				+ "grp.doc_no=d.sertypeid and grp.grptype='service' left join my_scope sc on sc.doc_no=d.scopeid where t.status=3 and d.rdocno="+docNo+"";
		
		ResultSet rs = stmt.executeQuery(sql);
		
		while(rs.next()) {
			
			templatearray.add(rs.getString("desc1")+" :: "+rs.getString("scope")+" :: "+rs.getString("scopeid")+" :: "+rs.getString("product")+" :: "+rs.getString("productid")+" :: "+rs.getString("activity")+" :: "+rs.getString("activityid")+" :: "+rs.getString("brandname")+" :: "+rs.getString("unit")+" :: "+rs.getString("scopeamount")+" :: "+rs.getString("amount")+" :: "+rs.getString("total")+" :: "+rs.getString("nettotal")+" :: "+rs.getString("margin")+" :: "+rs.getString("invoiced")+" :: "+rs.getString("proname")+" :: "+rs.getString("prodoc")+" :: "+rs.getString("unitdocno")+" :: "+rs.getString("psrno")+" :: "+rs.getString("proid")+" :: "+rs.getString("specid")+" :: "+rs.getString("stypeid")+" :: "+rs.getString("site")+" :: "+rs.getString("sertype")+" :: "+rs.getString("brandid")+" :: "+rs.getString("sitesrno")+" :: "+rs.getString("stdprice")+" :: "+rs.getString("marginper")+" :: "+rs.getString("lbrchg")+" :: "+rs.getString("scopestdcost")+" :: "+rs.getString("qty")+" :: ");
			
		}
		
		response.getWriter().print(templatearray);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  