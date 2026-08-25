package com.realestate.maintenancerequest;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsMaintenanceRequestDAO {

	ClsConnection conobj = new ClsConnection();

	ClsConnection ClsConnection = new ClsConnection();
	ClsMaintenanceRequestBean temp = new ClsMaintenanceRequestBean();
	ClsCommon ClsCommon = new ClsCommon();
	ClsCommon com = new ClsCommon();
	Connection c = null;

	public JSONArray Load(HttpSession session) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "select a.doc_no as areadocno,a.area as area,c.city_name as city_name,ac.country_name as country_name,r.reg_name as region_name, "
					+ " m.doc_no, m.name, m.plno,   m.date from rl_buildingm m "
					+ " left join    my_area a on m.area=a.doc_no inner join my_acity c on(a.city_id=c.doc_no) "
					+ " left join my_acountry ac on(ac.doc_no=c.country_id) "
					+ "left join my_aregion r on(r.doc_no=ac.reg_id)where m.status=3 ";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);

			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray omainsearch(HttpSession session, String docnoss,
			String own, String address, String datess, String aa,
			String descriptions, String mob) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();

		if (!aa.equalsIgnoreCase("yes")) {
			return RESULTDATA;
		}

		if (!aa.equalsIgnoreCase("yes")) {
			return RESULTDATA;
		}

		java.sql.Date sqlStartDate = null;
		if (!(datess.equalsIgnoreCase("undefined"))
				&& !(datess.equalsIgnoreCase(""))
				&& !(datess.equalsIgnoreCase("0"))) {
			sqlStartDate = ClsCommon.changeStringtoSqlDate(datess);
		}

		String sqltest = "";

		if ((!(docnoss.equalsIgnoreCase("")))
				&& (!(docnoss.equalsIgnoreCase("NA")))) {
			sqltest = sqltest + " and  voc_no like '%" + docnoss + "%'";
		}
		if ((!(own.equalsIgnoreCase(""))) && (!(own.equalsIgnoreCase("NA")))) {
			sqltest = sqltest + " and primary_owner like '%" + own + "%'  ";
		}
		if ((!(address.equalsIgnoreCase("")))
				&& (!(address.equalsIgnoreCase("NA")))) {
			sqltest = sqltest + " and address like '%" + address + "%'";
		}

		if ((!(descriptions.equalsIgnoreCase("")))
				&& (!(descriptions.equalsIgnoreCase("NA")))) {
			sqltest = sqltest + " and remarks like '%" + descriptions + "%'";
		}

		if ((!(mob.equalsIgnoreCase(""))) && (!(mob.equalsIgnoreCase("NA")))) {
			sqltest = sqltest + "  and a.costcode like '%" + mob + "%'";
		}

		if (!(sqlStartDate == null)) {
			sqltest = sqltest + " and date='" + sqlStartDate + "'";
		}

		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			if (aa.equalsIgnoreCase("yes")) {

				Statement stmtmain = conn.createStatement();

				String pySql = (" select primary_owner owner,doc_no ,voc_no,date,mobile,remarks,status,address  from rl_propertryowner where status<>7     "
						+ sqltest + " ");

				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA = ClsCommon.convertToJSON(resultSet);
				stmtmain.close();

			}
			conn.close();
			return RESULTDATA;
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		}
		// System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public JSONArray materearch(HttpSession session, String docnoss,
			String own, String pname, String datess, String aa,
			String descriptions, String mob) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();

		if (!aa.equalsIgnoreCase("yes")) {
			return RESULTDATA;
		}

		if (!aa.equalsIgnoreCase("yes")) {
			return RESULTDATA;
		}

		java.sql.Date sqlStartDate = null;
		if (!(datess.equalsIgnoreCase("undefined"))
				&& !(datess.equalsIgnoreCase(""))
				&& !(datess.equalsIgnoreCase("0"))) {
			sqlStartDate = ClsCommon.changeStringtoSqlDate(datess);
		}

		String sqltest = "";

		if ((!(docnoss.equalsIgnoreCase("")))
				&& (!(docnoss.equalsIgnoreCase("NA")))) {
			sqltest = sqltest + " and  m.voc_no like '%" + docnoss + "%'";
		}
		if ((!(own.equalsIgnoreCase(""))) && (!(own.equalsIgnoreCase("NA")))) {
			sqltest = sqltest + " and o.primary_owner like '%" + own + "%'  ";
		}
		if ((!(pname.equalsIgnoreCase("")))
				&& (!(pname.equalsIgnoreCase("NA")))) {
			sqltest = sqltest + " and m.name like '%" + pname + "%'";
		}

		if ((!(descriptions.equalsIgnoreCase("")))
				&& (!(descriptions.equalsIgnoreCase("NA")))) {
			sqltest = sqltest + " and m.desc1 like '%" + descriptions + "%'";
		}

		if (!(sqlStartDate == null)) {
			sqltest = sqltest + " and date='" + sqlStartDate + "'";
		}

		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			if (aa.equalsIgnoreCase("yes")) {

				Statement stmtmain = conn.createStatement();

				String pySql = (" select  m.doc_no, m.voc_no,  m.date, m.name,  o.primary_owner  owner,desc1 "
						+ " from rl_propertymaster m left join rl_propertryowner o on o.doc_no=m.owid where m.status=3    "
						+ sqltest + " ");

				System.out.println("property search sql=" + pySql);
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA = ClsCommon.convertToJSON(resultSet);
				stmtmain.close();

			}
			conn.close();
			return RESULTDATA;
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		}
		// System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public int insert(Date masterdate, int vocno, String rtime, int docno,
			int pdocno, int tdocno, ArrayList<String> jobarray,
			HttpSession session, HttpServletRequest request, String mode)
			throws SQLException {

		Connection conn = null;

		System.out.println("JOBARRAY=" + jobarray);
	
		try {
			conn = ClsConnection.getMyConnection();
			Statement s1 = conn.createStatement();
			Statement s2 = conn.createStatement();
			Statement s3 = conn.createStatement();
			Statement s4 = conn.createStatement();
			Statement s5 = conn.createStatement();
			Statement st = conn.createStatement();

			String branch = session.getAttribute("BRANCHID").toString().trim();

			int voc_no = 0;

			String q1 = "select coalesce((max(voc_no)+1),1) vocNo from re_mreq where branch=" + branch;

			ResultSet rs = s1.executeQuery(q1);
			if (rs.next()) {
				voc_no = rs.getInt("vocNo");
			}

			String jobdoc, jobprov, notifyowner, comments, priority, estcost;
			int doc_no = 0, ownotify=0, mdocno=0,vno=0;

			// save reqst grid
			for (int i = 0; i < jobarray.size(); i++) {
				String[] rqst = jobarray.get(i).split("::");
				if (!rqst[0].trim().equalsIgnoreCase("undefined")
						&& !rqst[0].trim().equalsIgnoreCase("NaN")) {

					jobdoc = (rqst[0].trim().equalsIgnoreCase("undefined")
							|| rqst[0].trim().equalsIgnoreCase("NaN")
							|| rqst[0].trim().isEmpty() ? "0" : rqst[0].trim())
							.toString();
					jobprov = (rqst[1].trim().equalsIgnoreCase("undefined")
							|| rqst[1].trim().equalsIgnoreCase("NaN")
							|| rqst[1].trim().isEmpty() ? "0" : rqst[1].trim())
							.toString();
					notifyowner = (rqst[4].trim().equalsIgnoreCase("undefined")
							|| rqst[4].trim().equalsIgnoreCase("NaN")
							|| rqst[4].trim().isEmpty() ? "0" : rqst[4].trim())
							.toString();									
					
					if (notifyowner.equalsIgnoreCase("true")) {		  
						ownotify = 1;
					} else {
						ownotify = 0;
					}
					
					comments = (rqst[5].trim().equalsIgnoreCase("undefined")
							|| rqst[5].trim().equalsIgnoreCase("NaN")
							|| rqst[5].trim().isEmpty() ? "0" : rqst[5].trim())
							.toString();
					priority = (rqst[2].trim().equalsIgnoreCase("undefined")
							|| rqst[2].trim().equalsIgnoreCase("NaN")
							|| rqst[2].trim().isEmpty() ? "0" : rqst[2].trim())
							.toString();
					estcost = (rqst[3].trim().equalsIgnoreCase("undefined")
							|| rqst[3].trim().equalsIgnoreCase("NaN")
							|| rqst[3].trim().isEmpty() ? "0" : rqst[3].trim())
							.toString();

					mdocno = (rqst[6].trim().equalsIgnoreCase("undefined")
							|| rqst[6].trim().equalsIgnoreCase("NaN")
							|| rqst[6].trim().isEmpty() ? 0 : Integer
							.parseInt(rqst[6].trim()));
					
				 
					if (mode.equalsIgnoreCase("A")) {    
						String query = "select coalesce(max(doc_no)+1,1) docno from re_mreq";
						ResultSet rs1 = s2.executeQuery(query);
						if (rs1.next()) {
							doc_no = rs1.getInt("docno");
						}
						  
						String sql2 = ("insert into re_mreq (doc_no, pdoc_no, branch, sr_no, Edate, ETime, job_docno, jbprov, OwNotif, comments, stat, priority, est_amt, tdoc_no,  voc_no,status)"
								+ " values ('"
								+ doc_no
								+ "','"
								+ pdocno
								+ "','"
								+ branch
								+ "', '"
								+ (i + 1)
								+ "','"
								+ masterdate
								+ "','"
								+ rtime
								+ "','"
								+ jobdoc
								+ "','"
								+ jobprov
								+ "','"
								+ ownotify
								+ "','"
								+ comments
								+ "','0','"
								+ priority
								+ "','"
								+ estcost
								+ "','" + tdocno + "','" + voc_no + "','3')");
						int re = s3.executeUpdate(sql2);
						if (re <= 0) {
							s3.close();
							conn.close();
							return 0;
						}
						else
						{
							request.setAttribute( "docno",doc_no);
							request.setAttribute( "vocno",voc_no);
						}
					} else if (mode.equalsIgnoreCase("E")) {    
						if (mdocno > 0) { 			
							String update_query = " update re_mreq set"
									+ " pdoc_no='"
									+ pdocno
									+ "',"
									+ " Edate='"
									+ masterdate
									+ "',"
									+ " ETime='"
									+ rtime
									+ "',"
									+ " job_docno='"
									+ jobdoc
									+ "',"
									+ " jbprov='"
									+ jobprov
									+ "',"
									+ " OwNotif='"
									+ ownotify
									+ "',"
									+ " comments='"
									+ comments
									+ "',"
									+ " priority='"
									+ priority
									+ "',"
									+ " est_amt='"
									+ estcost
									+ "',"
									+ " tdoc_no='"
									+ tdocno
									+ "',"
									+ " voc_no='"
									+ vocno
									+ "'"
									+ " where doc_no=" + mdocno;
							System.out.println("updaete query"+update_query);
							
							int result = s4.executeUpdate(update_query);
							if (result <= 0) {
								//s4.close();
								//conn.close();
								return 0;
							}
							else
							{
								request.setAttribute( "docno",mdocno);
								request.setAttribute( "vocno",voc_no);
							}

						} else {
							
							String query = "select coalesce(max(doc_no)+1,1) docno from re_mreq";
							ResultSet rst = st.executeQuery(query);
							if (rst.next()) {
								doc_no = rst.getInt("docno");
							}

							String insertnew = ("insert into re_mreq (doc_no, pdoc_no, branch, sr_no, Edate, ETime, job_docno, jbprov, OwNotif, comments, stat, priority, est_amt, tdoc_no,  voc_no)"
									+ " values ('"
									+ doc_no
									+ "','"
									+ pdocno
									+ "','"
									+ branch
									+ "', '"
									+ (i + 1)
									+ "','"
									+ masterdate
									+ "','"
									+ rtime
									+ "','"
									+ jobdoc
									+ "','"
									+ jobprov
									+ "','"
									+ ownotify
									+ "','"
									+ comments
									+ "','1','"
									+ priority
									+ "','"
									+ estcost + "','" + tdocno + "','" + vocno + "')");
							int result = s5.executeUpdate(insertnew);
							if (result <= 0) {
								s5.close();
								//conn.close();
								return 0;
							}
							else
							{
								request.setAttribute( "docno",docno);
								request.setAttribute( "vocno",voc_no);
							}
						}
					}

				}
			} 

		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
			return 0;
		}
		return 1;
	}

	public JSONArray clientSrearch(HttpSession session, String sclname,
			String smob, String rno, String Contact) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();

		String brnchid = session.getAttribute("BRANCHID").toString();

		String sqltest = "";

		if (!(sclname.equalsIgnoreCase(""))) {
			sqltest = sqltest + " and m.refname like '%" + sclname + "%'";
		}
		if (!(smob.equalsIgnoreCase(""))) {
			sqltest = sqltest + " and m.com_mob like '" + smob + "'";
		}
		if (!(rno.equalsIgnoreCase(""))) {
			sqltest = sqltest + " and m.cldocno like '" + rno + "%'";
		}
		if (!(Contact.equalsIgnoreCase(""))) {
			sqltest = sqltest + " and m.contactperson like '" + Contact + "%'";
		}

		Connection conn = null;
		Statement stmtVeh7 = null;

		try {
			conn = conobj.getMyConnection();
			stmtVeh7 = conn.createStatement();
			String str1Sql = ("select m.cldocno,m.refname,m.com_mob,m.contactperson as contact from my_acbook m "
					+ " left join my_clcatm c on c.doc_no=m.catid  where m.dtype='CRM' and c.tenant=1 and m.status<>7  " + sqltest);
			System.out.println("==========" + str1Sql);
			ResultSet resultSet = stmtVeh7.executeQuery(str1Sql);
			RESULTDATA = com.convertToJSON(resultSet);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmtVeh7.close();
			conn.close();
		}
		// System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public JSONArray pmaterearch(HttpSession session, String docnoss,
			String own, String pname, String datess, String aa,
			String descriptions, String mob) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();

		if (!aa.equalsIgnoreCase("yes")) {
			return RESULTDATA;
		}

		if (!aa.equalsIgnoreCase("yes")) {
			return RESULTDATA;
		}

		java.sql.Date sqlStartDate = null;
		if (!(datess.equalsIgnoreCase("undefined"))
				&& !(datess.equalsIgnoreCase(""))
				&& !(datess.equalsIgnoreCase("0"))) {
			sqlStartDate = ClsCommon.changeStringtoSqlDate(datess);
		}

		String sqltest = "";

		if ((!(docnoss.equalsIgnoreCase("")))
				&& (!(docnoss.equalsIgnoreCase("NA")))) {
			sqltest = sqltest + " and  m.voc_no like '%" + docnoss + "%'";
		}
		if ((!(own.equalsIgnoreCase(""))) && (!(own.equalsIgnoreCase("NA")))) {
			sqltest = sqltest + " and o.primary_owner like '%" + own + "%'  ";
		}
		if ((!(pname.equalsIgnoreCase("")))
				&& (!(pname.equalsIgnoreCase("NA")))) {
			sqltest = sqltest + " and m.name like '%" + pname + "%'";
		}

		if ((!(descriptions.equalsIgnoreCase("")))
				&& (!(descriptions.equalsIgnoreCase("NA")))) {
			sqltest = sqltest + " and m.desc1 like '%" + descriptions + "%'";
		}

		if (!(sqlStartDate == null)) {
			sqltest = sqltest + " and m.date='" + sqlStartDate + "'";
		}

		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			if (aa.equalsIgnoreCase("yes")) {

				Statement stmtmain = conn.createStatement();

				String pySql = (" select  m.doc_no, m.voc_no,  m.date, if( m.name='' or m.name=null ,m.address1,m.name) as name,  o.primary_owner  owner,desc1,if(m.cnt_no>0,'RENTED','AVAILABLE') type,"
						+ " convert(if(m.cnt_no>0,DATE_ADD(cnt_date, INTERVAL 1 DAY),''),char(100)) adate,t.cldocno as tdoc_no,ma.refname as tenant  "
						+ " from rl_propertymaster m left join rl_tncm t on t.doc_no=m.cnt_no left join my_acbook ma on t.cldocno=ma.cldocno left join my_clcatm c on c.doc_no=ma.catid left join rl_propertryowner o on o.doc_no=m.owid where m.status=3 and m.active=1   "
						+ sqltest + " group by m.doc_no ");

				System.out.println("property search=== " + pySql);

				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA = ClsCommon.convertToJSON(resultSet);
				stmtmain.close();

			}
			conn.close();
			return RESULTDATA;
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		}
		// System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public JSONArray furnitureLoadByRoomID(HttpSession session, int docno)
			throws SQLException {

		System.out.println("room id=" + docno);
		JSONArray RESULTDATA = new JSONArray();
		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql = "SELECT * FROM re_mfurnfix  where ftype=1 and rdoc_no="
					+ docno;
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray vendorSearch(HttpSession session) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();
		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql = "select h.description accname,h.doc_no,h.account  acno from  my_acbook ac left join my_head h on h.doc_no=ac.acno where ac.dtype='vnd' and h.atype='ap'";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray jobSearch(HttpSession session) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();
		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql = "SELECT * FROM rl_jobmaster where status=3;";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray requestSearch(HttpSession session, String vocno, String id)
			throws SQLException { 
		 
		JSONArray RESULTDATA = new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql = " select mr.doc_no, j.job_desc as job,mr.job_docno,mr.jbprov as vendor_acno, h.description as vendor_name,"
					+ " mr.tdoc_no as vendor_docno,mr.priority ,mr.est_amt as est_cost,mr.ownotif as notify_owner,mr.comments from re_mreq mr"
					+ " left join rl_propertymaster pm on pm.doc_no=mr.pdoc_no"
					+ " left join rl_jobmaster j on j.doc_no=mr.job_docno"
					+ " left join my_head h on h.doc_no=mr.jbprov and h.atype='ap'"
					+ " where mr.voc_no=" + vocno;
           
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray requestMainSearch(String property, String tenant,String id)
			throws SQLException {

		JSONArray RESULTDATA = new JSONArray();
		
		if(!(id.equalsIgnoreCase("1")))
		{
			return RESULTDATA;
		}
		
		Connection conn = null;
		
		
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql = " select pm.address1 as address, group_concat(j.job_desc) job,mc.refname as tenant,mr.est_amt as amount,pm.doc_no as pdocno ,mr.tdoc_no,mr.voc_no,mr.doc_no from re_mreq mr"
					+ "	left join rl_propertymaster pm on pm.doc_no=mr.pdoc_no"
					+ "	left join rl_jobmaster j on j.doc_no=mr.job_docno"
					+ "	left  join my_acbook mc on mc.cldocno=mr.tdoc_no and mc.dtype='CRM'"
					+ " where pm.address1 like '%"
					+ property
					+ "%' or mc.refname like '%"
					+ tenant
					+ "%'"
					+ " group by mr.voc_no";
 
			System.out.println("sql---------->>>"+sql);
			 
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();
			
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
		return RESULTDATA;
	}
}
