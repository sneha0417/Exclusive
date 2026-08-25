<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>

<%
	String docno = request.getParameter("docno") == "" || request.getParameter("docno") == null ? "" : request.getParameter("docno").toString(); 
 
	ClsCommon com = new ClsCommon();
	ClsConnection ClsConnection = new ClsConnection();
	Connection conn = null; 

	try {
		JSONObject objdata = new JSONObject();
		conn = ClsConnection.getMyConnection();
		ClsCommon cmn = new ClsCommon();
		Statement stmt = conn.createStatement();
		String trsnt = "", transport = "", childage = "", height = "", weight = "", ageres = "";
		//String strSql = "select coalesce(name,'') name, coalesce(childmin,0) childmin, coalesce(childmax,0) childmax, coalesce(hghtmin,0) hghtmin, coalesce(hghtmax,0) hghtmax, coalesce(wghtmin,0) wghtmin, coalesce(wghtmax,0) wghtmax, coalesce(agemin,0) agemin, coalesce(agemax,0) agemax, coalesce(description,'') description, coalesce(transport,'') transport from tr_tours where status=3 and doc_no='"+rdocno+"'";

		String strSql = "select rm.rdesc1 room,fm.fdesc1 furniture  from rl_propertymaster pm left join re_proomfurnfix rf on rf.pdoc_no=pm.doc_no left join re_mroom rm on rm.doc_no=rf.rdoc_no left join re_mfurnfix fm on fm.doc_no=rf.furnfixdoc_no"
				+ " where pm.doc_no="+docno;

		System.out.println("property sql=====" + strSql);
		ResultSet rs1 = stmt.executeQuery(strSql);
		JSONArray dataarray = new JSONArray();
		while (rs1.next()) {
			JSONObject temp = new JSONObject();
			temp.put("main", rs1.getString("room"));
			temp.put("sub", rs1.getString("furniture"));
		 
			dataarray.add(temp);
		}

		JSONObject object = new JSONObject();
		object.put("property", dataarray);
		//response.getWriter().print(dataarray);    
		response.getWriter().print(object);

		stmt.close();
		conn.close();
	} catch (Exception e) {
		e.printStackTrace();
		conn.close();
	} finally {
		conn.close();
	}
%>