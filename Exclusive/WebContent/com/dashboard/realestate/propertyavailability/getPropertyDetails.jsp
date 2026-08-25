 <%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>

<%
	String ptype = request.getParameter("type") == ""
			|| request.getParameter("type") == null ? "" : request
			.getParameter("type").toString();
	String todate = request.getParameter("todate") == ""
			|| request.getParameter("todate") == null ? "" : request
			.getParameter("todate").toString();
	String area = request.getParameter("area") == ""
			|| request.getParameter("area") == null ? "" : request
			.getParameter("area").toString();
	String landmark = request.getParameter("landmark") == ""
			|| request.getParameter("landmark") == null ? "" : request
			.getParameter("landmark").toString();
/* 	String mgprpty = request.getParameter("mgprpty") == ""
			|| request.getParameter("mgprpty") == null ? "" : request
			.getParameter("mgprpty").toString();
	String prtype = request.getParameter("prtype") == ""
			|| request.getParameter("prtype") == null ? "" : request
			.getParameter("prtype").toString(); */

	System.out.println("area=" + area);
	ClsCommon com = new ClsCommon();
	ClsConnection ClsConnection = new ClsConnection();
	Connection conn = null;

	java.sql.Date sqlToDate = null;
	if (!(todate.equalsIgnoreCase("undefined"))
			&& !(todate.equalsIgnoreCase(""))
			&& !(todate.equalsIgnoreCase("0"))) {
		sqlToDate = com.changeStringtoSqlDate(todate);
	}

	String sqltest = "";

	if (!(ptype.equalsIgnoreCase(""))) {
		sqltest = sqltest + " and p.propertyfor = '" + ptype + "'";
	}
	if (!(area.equalsIgnoreCase(""))) {
		sqltest = sqltest + " and p.area = '" + area + "'";
	}
	if (!(landmark.equalsIgnoreCase(""))) {
		sqltest = sqltest + " and p.landmark like '" + landmark + "%'";
	}
	
	/* if (!(mgprpty.equalsIgnoreCase(""))) {
		sqltest = sqltest + " and p.mgprpty = '" + mgprpty + "'";
	}

	String[] prtypearray = prtype.split(",");

	for (int i = 0; i < prtypearray.length; i++) {
		String prtp = prtypearray[i];

		if (i == 0) {
			if (!(prtp.equalsIgnoreCase(""))) {
				sqltest = sqltest + " and p.ptype = '" + prtp + "'";
			}
		} else {
			if (!(prtp.equalsIgnoreCase(""))) {
				sqltest = sqltest + " or p.ptype = '" + prtp + "'";

			}
		}
	} */

	try {
		JSONObject objdata = new JSONObject();
		conn = ClsConnection.getMyConnection();
		ClsCommon cmn = new ClsCommon();
		Statement stmt = conn.createStatement();
		String trsnt = "", transport = "", childage = "", height = "", weight = "", ageres = "";
		//String strSql = "select coalesce(name,'') name, coalesce(childmin,0) childmin, coalesce(childmax,0) childmax, coalesce(hghtmin,0) hghtmin, coalesce(hghtmax,0) hghtmax, coalesce(wghtmin,0) wghtmin, coalesce(wghtmax,0) wghtmax, coalesce(agemin,0) agemin, coalesce(agemax,0) agemax, coalesce(description,'') description, coalesce(transport,'') transport from tr_tours where status=3 and doc_no='"+rdocno+"'";

		String strSql = "select p.doc_no,p.accname,if(pforsale='Sale','S','') pfors,if(pforrent='Rent','R','') pforr,if(pforhc='HC','HC','') pforhc,coalesce(p.prid,'') prid,coalesce(p.no_of_rooms,'')no_of_rooms,if(mgprpty=1,'Yes','No') as mgprpty,coalesce(p.address1,'') address,coalesce(p.landmark,'') landmark,coalesce(a.area,'') areaname,"
				+ " coalesce(o.primary_owner,'') owner , coalesce(pt.code,'')  ptype, coalesce(mc.refname,'') tenant,"
				+ " coalesce(DATE_FORMAT(DATE_ADD(tn.Period_to ,INTERVAL 1 DAY),'%d-%m-%Y'),'')availdate,p.desc1,p.buildup_area,p.specialnotes,  coalesce(coalesce(o.tele_phn,mobile),'') as contactno,if(p.cnt_no>0,'','Vacant') as status "
				+ " from rl_propertymaster p"
				+ " left join my_area a on a.doc_no=p.area"
				+ " left join rl_propertryowner o on o.doc_no=p.owid"
				+ " left join rl_propertytype pt on pt.doc_no=p.ptype"
				+ " left join rl_tncm tn on tn.doc_no=p.cnt_no"
				+ " left join my_acbook mc on mc.cldocno=tn.cldocno"
				+ " where 1=1 " + sqltest +" group by p.doc_no";

		//coalesce( TRIM(BOTH ',' FROM CONCAT_WS(',',pforsale,pforrent,pforhc)),'') as pfor
		System.out.println("property sql=====" + strSql);
		ResultSet rs1 = stmt.executeQuery(strSql);
		JSONArray dataarray = new JSONArray();
		while (rs1.next()) {
			JSONObject temp = new JSONObject();
			temp.put("address", rs1.getString("address"));
			temp.put("owner", rs1.getString("owner"));
			temp.put("tenant", rs1.getString("tenant"));
			temp.put("availabilitydate", rs1.getString("availdate"));
			temp.put("area", rs1.getString("areaname"));
			temp.put("ptype", rs1.getString("ptype"));
			temp.put("desc", rs1.getString("desc1"));
			temp.put("doc_no", rs1.getString("doc_no"));
			temp.put("builduparea", rs1.getString("buildup_area"));
			temp.put("splnote", rs1.getString("specialnotes"));
			temp.put("contactno", rs1.getString("contactno"));
			temp.put("mgprpty", rs1.getString("mgprpty"));
			temp.put("status", rs1.getString("status"));
			temp.put("prid", rs1.getString("prid"));
			temp.put("no_of_rooms", rs1.getString("no_of_rooms"));
			
			temp.put("accname", rs1.getString("accname"));
			temp.put("pfors", rs1.getString("pfors"));
			temp.put("pforr", rs1.getString("pforr"));
			temp.put("pforhc", rs1.getString("pforhc"));
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