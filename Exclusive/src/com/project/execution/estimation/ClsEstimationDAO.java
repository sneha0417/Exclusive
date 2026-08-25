package com.project.execution.estimation;

import java.sql.CallableStatement;
import java.sql.Connection;
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

public class ClsEstimationDAO {

	ClsCommon com=new ClsCommon();
	ClsConnection conobj=new ClsConnection();


	public JSONArray searchActivity(HttpSession session,String Cl_project,String Cl_section,String Cl_activity,String activid,String id) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}

		//  System.out.println("8888888888"+clnames); 	
		String brid=session.getAttribute("BRANCHID").toString();



		java.sql.Date sqlStartDate=null;


		String sqltest="";


		if(!(Cl_project.equalsIgnoreCase("undefined"))&&!(Cl_project.equalsIgnoreCase(""))){
			sqltest=sqltest+" and p.groupname like '%"+Cl_project+"%'";
		}
		if(!(Cl_section.equalsIgnoreCase("undefined"))&&!(Cl_section.equalsIgnoreCase(""))){
			sqltest=sqltest+" and s.groupname like '%"+Cl_section+"%'";
		}
		if(!(Cl_activity.equalsIgnoreCase("undefined"))&&!(Cl_activity.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.jobtype like '%"+Cl_activity+"%'";
		}
		if(!(activid.equalsIgnoreCase("undefined"))&&!(activid.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.tr_no not in("+activid+")";
		}


		Connection conn = null;
		ResultSet resultSet =null;
		try {

			conn = conobj.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();

			String str1Sql=("select m.date,m.doc_no,m.tr_no,m.jobtype as activity,p.groupname as project,cgroup as projectid,s.groupname as section,"
					+ "cdivision as sectionid from cm_prjmaster m left join my_groupvals p on(m.cgroup= p.doc_no and p.grptype='project') "
					+ "left join my_groupvals s on(m.cdivision=s.doc_no and s.grptype='section') where m.status=3  "+sqltest+"");


			System.out.println("==searchActivity==="+str1Sql);
			if(Integer.parseInt(id)>0){
				resultSet = stmtenq1.executeQuery(str1Sql);
			}


			RESULTDATA=com.convertToJSON(resultSet);
			stmtenq1.close();
			conn.close();
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}

		return RESULTDATA;
	}


	public JSONArray loadActivity(HttpSession session,String aid,String sid,String pid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}

		//  System.out.println("8888888888"+clnames); 	
		String brid=session.getAttribute("BRANCHID").toString();



		java.sql.Date sqlStartDate=null;


		String sqltest="";


		/*aid = aid.replaceAll(", $", "");
		sid = sid.replaceAll(", $", "");
		pid = pid.replaceAll(", $", "");*/

		if (aid.trim().endsWith(",")) {
			aid = aid.trim().substring(0,aid.length() - 1);
		}
		if (sid.trim().endsWith(",")) {
			sid = sid.trim().substring(0,sid.length() - 1);
		}
		if (pid.trim().endsWith(",")) {
			pid = pid.trim().substring(0,pid.length() - 1);
		}

		/*if(!(Cl_project.equalsIgnoreCase("undefined"))&&!(Cl_project.equalsIgnoreCase(""))&&!(Cl_project.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and p.groupname like '%"+Cl_project+"%'";
		}
		if(!(Cl_section.equalsIgnoreCase("undefined"))&&!(Cl_section.equalsIgnoreCase(""))&&!(Cl_section.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and s.groupname like '%"+Cl_section+"%'";
		}
		if(!(Cl_activity.equalsIgnoreCase("undefined"))&&!(Cl_activity.equalsIgnoreCase(""))&&!(Cl_activity.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and m.jobtype like '%"+Cl_activity+"%'";
		}*/


		Connection conn = null;

		try {

			conn = conobj.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();

			String str1Sql=("select m.date,m.doc_no,m.tr_no,m.jobtype as activity,p.groupname as project,cgroup as projectid,s.groupname as section,"
					+ "cdivision as sectionid from cm_prjmaster m left join my_groupvals p on(m.cgroup= p.doc_no and p.grptype='project') "
					+ "left join my_groupvals s on(m.cdivision=s.doc_no and s.grptype='section') where 1=1  and m.tr_no in("+aid+")");


			//			System.out.println("==searchActivity==="+str1Sql);

			ResultSet resultSet = stmtenq1.executeQuery(str1Sql);

			RESULTDATA=com.convertToJSON(resultSet);
			stmtenq1.close();
			conn.close();
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}

		return RESULTDATA;
	}

	public JSONArray searchClient(HttpSession session,String clname,String mob,int id) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}


		String brid=session.getAttribute("BRANCHID").toString();


		String sqltest="";

		if(!(clname.equalsIgnoreCase("undefined"))&&!(clname.equalsIgnoreCase(""))&&!(clname.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and refname like '%"+clname+"%'";
		}
		if(!(mob.equalsIgnoreCase("undefined"))&&!(mob.equalsIgnoreCase(""))&&!(mob.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and per_mob like '%"+mob+"%'";
		}


		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmtVeh1 = conn.createStatement ();

			if(id>0){
				String clsql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM' and status=3  " +sqltest);

				ResultSet resultSet = stmtVeh1.executeQuery(clsql);

				RESULTDATA=com.convertToJSON(resultSet);
				stmtVeh1.close();
				conn.close();
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public JSONArray materialGridLoad(HttpSession session,String trno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select d.tr_no,m.psrno,m.psrno pid,m.psrno prodoc,at.mspecno specid,m.part_no productid,m.productname,d.qty qty,round(d.costprice,2) amount,round(d.total,2) total,round(d.profitper,2) margin,round(d.nettotal,2) netotal,d.description desc1,"
					+ "u.unit unit,m.munit as unitdocno,jobtype as activity,mp.tr_no activityid from cm_prjmaster mp left join cm_mprdd d on(mp.tr_no=d.tr_no) left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "
					+ "left join my_unitm u on m.munit=u.doc_no  where mp.tr_no in ("+trno+")";


			//			System.out.println("===materialGridLoad===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}

	public JSONArray labourGridLoad(HttpSession session,String trno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select mp.tr_no,othid docno,s.code as codeno,s.name as desc1, round(rateHr,2) rate,l.description, round(total,2) total1, round(profitPer,2) margin1, round(NetTotal,2) netotal1, "
					+ "lblhours hrs, lblmins min,jobtype as activity,mp.tr_no activityid from cm_prjmaster mp left join cm_mprlabour l on(mp.tr_no=l.tr_no) "
					+ "left join cm_chrgm s on(s.doc_no=l.othid) where mp.tr_no in ("+trno+")";


			//			System.out.println("===labourGridLoad===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}


	public JSONArray equipmentGridLoad(HttpSession session,String trno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select mp.tr_no,assetid docno,s.code as codeno,s.name as desc2, round(rateHr,2) rate2,m.description, round(total,2) total2, round(profitPer,2) margin2, round(NetTotal,2) netotal2,"
					+ " lblhours hrs2, lblmins min2,jobtype as activity,mp.tr_no activityid from cm_prjmaster mp left join cm_mprmachine m on(mp.tr_no=m.tr_no)"
					+ "left join cm_chrgm s on(s.doc_no=m.assetid) where mp.tr_no in ("+trno+")";

			//			System.out.println("===equipmentGridLoad===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}

	public   JSONArray searchProduct(HttpSession session,String prodsearchtype,String rdoc,String reftype) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement (); 
			String sql="";
			int method=0;

           String brcid=session.getAttribute("BRANCHID").toString();
			
			sql="select at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno "
					+ "from my_main m left join my_unitm u on m.munit=u.doc_no "
					+ "left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) "
					+ "where m.status=3 and if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"'  group by m.psrno  order by m.psrno ";


			/*sql="select at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno "
					+ "from my_main m left join my_unitm u on m.munit=u.doc_no "
					+ "left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) "
					+ "where m.status=3 and de.brhid='"+session.getAttribute("BRANCHID").toString()+"'  group by m.psrno  order by m.psrno ";*/


			//			System.out.println("----searchProduct-sql---"+sql);

			ResultSet resultSet = stmt.executeQuery (sql);
			RESULTDATA=com.convertToJSON(resultSet);
			stmt.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public JSONArray lchrgeSearch(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="SELECT doc_no docno,name,code,rate FROM cm_chrgm c where status=3 and dtype='lcm'";


			//			System.out.println("===sql===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}




	public JSONArray echrgeSearch(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="SELECT doc_no docno,name,code,rate FROM cm_chrgm c where status=3 and dtype='ecm'";


			//			System.out.println("===sql===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}

	public JSONArray enquirySrearch(HttpSession session,String msdocno,String Cl_names,String Cl_mobno,String enqdate,String clientid,int id) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}


		String brcid=session.getAttribute("BRANCHID").toString();


		String sqltest="";
		java.sql.Date sqlStartDate=null;
		if(!(enqdate.equalsIgnoreCase("undefined"))&&!(enqdate.equalsIgnoreCase(""))&&!(enqdate.equalsIgnoreCase("0")))
		{
			sqlStartDate = com.changeStringtoSqlDate(enqdate);
			sqltest=sqltest+" and m.date<="+sqlStartDate+"";
		}
		if(!(msdocno.equalsIgnoreCase("undefined"))&&!(msdocno.equalsIgnoreCase(""))&&!(msdocno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and m.voc_no like '%"+msdocno+"%'";
		}
		if(!(Cl_names.equalsIgnoreCase("undefined"))&&!(Cl_names.equalsIgnoreCase(""))&&!(Cl_names.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and ac.refname like '%"+Cl_names+"%'";
		}
		if(!(Cl_mobno.equalsIgnoreCase("undefined"))&&!(Cl_mobno.equalsIgnoreCase(""))&&!(Cl_mobno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and ac.com_mob like '%"+Cl_mobno+"%'";
		}
		if(!(clientid.equalsIgnoreCase("undefined"))&&!(clientid.equalsIgnoreCase(""))&&!(clientid.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and ac.cldocno="+clientid+"";
		}


		Connection conn =null;
		Statement stmt = null;
		try {
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();


			if(id>0){
				String str1Sql=("select m.date,m.doc_no,m.voc_no, if(m.cldocno>0,ac.refname,m.name) as name,coalesce(ac.doc_no,0) as clientid, "
						+ "if(m.cldocno>0,concat(coalesce(ac.address,''),',',coalesce(ac.com_mob,'') ,',',coalesce(ac.mail1,'') ),com_add1) as details, "
						+ "if(m.cpersonid>0,c.cperson,coalesce(m.cperson,'')) as cperson,coalesce(c.row_no,0) as cpersonid, "
						+ "if(m.cpersonid>0,c.mob,coalesce(m.mob,'')) as contmob from gl_enqm m left join my_acbook ac "
						+ "on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_crmcontact c on(c.row_no=m.cpersonid) where 1=1 and m.status=3 and esttrno=0 "+sqltest+"");

				//			System.out.println("======enqsearch===="+str1Sql);

				ResultSet resultSet = stmt.executeQuery (str1Sql);
				RESULTDATA=com.convertToJSON(resultSet);
				stmt.close();
				conn.close();
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}


	public int insert(java.sql.Date date,int clientid,String reviseno,String cmbreftype,String txtenquiry,String txtnettotal,String txtmatotal,String txtlabtotal,
			String txteqptotal,String formcode,int enqid,String mode,ArrayList matlist,ArrayList lablist,ArrayList equplist,ArrayList actlist,HttpSession session,
			HttpServletRequest request,String activitiesid){


		Connection conn=null;
		int docNo=0;
		int vocno=0;

		try{


			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmt = conn.prepareCall("{CALL Sr_EstimationDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmt.registerOutParameter(16, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(17, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(18, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			stmt.setInt(2,clientid);
			stmt.setString(3,reviseno);
			stmt.setString(4,cmbreftype);
			stmt.setString(5,txtenquiry);
			stmt.setString(6,txtnettotal);
			stmt.setString(7,txtmatotal);
			stmt.setString(8,txtlabtotal);
			stmt.setString(9,txteqptotal);
			stmt.setString(10,mode);
			stmt.setString(11,formcode);
			stmt.setInt(12,enqid);
			stmt.setString(13, session.getAttribute("BRANCHID").toString());
			stmt.setString(14, session.getAttribute("USERID").toString());
			stmt.setString(15,activitiesid);
			int val = stmt.executeUpdate();
			docNo=stmt.getInt("docNo");
			vocno=stmt.getInt("vocNo");
			request.setAttribute("docNo", docNo);


			if(docNo>0){


				for(int i=0;i< matlist.size();i++){


					String[] arrayDet=((String) matlist.get(i)).split("::");

					//					System.out.println("====material activity=="+arrayDet[9]);

					if(!(arrayDet[9].trim().equalsIgnoreCase("undefined")|| arrayDet[9].trim().equalsIgnoreCase("NaN")||arrayDet[9].trim().equalsIgnoreCase("")|| arrayDet[9].isEmpty()))
					{

						//SpecNo					

						String sql="INSERT INTO cm_estmprdd(tr_no, SR_NO,Description, psrno, prdId,UNITID, qty, costPrice,  total, profitPer,activityid, NetTotal)VALUES"
								+ " ("+docNo+","
								+ " "+(i+1)+","
								+ "'"+(arrayDet[0].trim().equalsIgnoreCase("undefined") || arrayDet[0].trim().equalsIgnoreCase("NaN")|| arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()?"":arrayDet[0].trim())+"',"
								+ "'"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?0:arrayDet[1].trim())+"',"
								+ "'"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?0:arrayDet[1].trim())+"',"
								+ "'"+(arrayDet[3].trim().equalsIgnoreCase("undefined") || arrayDet[3].trim().equalsIgnoreCase("NaN")|| arrayDet[3].trim().equalsIgnoreCase("")|| arrayDet[3].isEmpty()?0:arrayDet[3].trim())+"',"
								+ "'"+(arrayDet[4].trim().equalsIgnoreCase("undefined") || arrayDet[4].trim().equalsIgnoreCase("NaN")|| arrayDet[4].trim().equalsIgnoreCase("")|| arrayDet[4].isEmpty()?0:arrayDet[4].trim())+"',"
								+ "'"+(arrayDet[5].trim().equalsIgnoreCase("undefined") || arrayDet[5].trim().equalsIgnoreCase("NaN")|| arrayDet[5].trim().equalsIgnoreCase("")|| arrayDet[5].isEmpty()?0:arrayDet[5].trim())+"',"
								+ "'"+(arrayDet[6].trim().equalsIgnoreCase("undefined") || arrayDet[6].trim().equalsIgnoreCase("NaN")|| arrayDet[6].trim().equalsIgnoreCase("")|| arrayDet[6].isEmpty()?0:arrayDet[6].trim())+"',"
								+ "'"+(arrayDet[7].trim().equalsIgnoreCase("undefined") || arrayDet[7].trim().equalsIgnoreCase("NaN")|| arrayDet[7].trim().equalsIgnoreCase("")|| arrayDet[7].isEmpty()?0:arrayDet[7].trim())+"',"
								+ "'"+(arrayDet[9].trim().equalsIgnoreCase("undefined") || arrayDet[9].trim().equalsIgnoreCase("NaN")|| arrayDet[9].trim().equalsIgnoreCase("")|| arrayDet[9].isEmpty()?0:arrayDet[9].trim())+"',"
								+ "'"+(arrayDet[8].trim().equalsIgnoreCase("undefined") || arrayDet[8].trim().equalsIgnoreCase("NaN")|| arrayDet[8].trim().equalsIgnoreCase("")|| arrayDet[8].isEmpty()?0:arrayDet[8].trim())+"')";

						//						System.out.println("==matlist==="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}
						//conn.commit();

					}

				}


				for(int i=0;i< lablist.size();i++){


					String[] arrayDet=((String) lablist.get(i)).split("::");

					//					System.out.println("====labal activity=="+arrayDet[8]);

					if(!(arrayDet[8].trim().equalsIgnoreCase("undefined")|| arrayDet[8].trim().equalsIgnoreCase("NaN")||arrayDet[8].trim().equalsIgnoreCase("")|| arrayDet[8].isEmpty()))
					{


						String sql="INSERT INTO cm_estlabour(tr_no, SR_NO,othid,description,lblhours,lblmins, rateHr, total, profitPer,activityid, NetTotal)VALUES"
								+ " ("+docNo+","
								+ " "+(i+1)+","
								+ "'"+(arrayDet[0].trim().equalsIgnoreCase("undefined") || arrayDet[0].trim().equalsIgnoreCase("NaN")|| arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()?0:arrayDet[0].trim())+"',"
								+ "'"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?0:arrayDet[1].trim())+"',"
								+ "'"+(arrayDet[2].trim().equalsIgnoreCase("undefined") || arrayDet[2].trim().equalsIgnoreCase("NaN")|| arrayDet[2].trim().equalsIgnoreCase("")|| arrayDet[2].isEmpty()?0:arrayDet[2].trim())+"',"
								+ "'"+(arrayDet[3].trim().equalsIgnoreCase("undefined") || arrayDet[3].trim().equalsIgnoreCase("NaN")|| arrayDet[3].trim().equalsIgnoreCase("")|| arrayDet[3].isEmpty()?0:arrayDet[3].trim())+"',"
								+ "'"+(arrayDet[4].trim().equalsIgnoreCase("undefined") || arrayDet[4].trim().equalsIgnoreCase("NaN")|| arrayDet[4].trim().equalsIgnoreCase("")|| arrayDet[4].isEmpty()?0:arrayDet[4].trim())+"',"
								+ "'"+(arrayDet[5].trim().equalsIgnoreCase("undefined") || arrayDet[5].trim().equalsIgnoreCase("NaN")|| arrayDet[5].trim().equalsIgnoreCase("")|| arrayDet[5].isEmpty()?0:arrayDet[5].trim())+"',"
								+ "'"+(arrayDet[6].trim().equalsIgnoreCase("undefined") || arrayDet[6].trim().equalsIgnoreCase("NaN")|| arrayDet[6].trim().equalsIgnoreCase("")|| arrayDet[6].isEmpty()?0:arrayDet[6].trim())+"',"
								+ "'"+(arrayDet[8].trim().equalsIgnoreCase("undefined") || arrayDet[8].trim().equalsIgnoreCase("NaN")|| arrayDet[8].trim().equalsIgnoreCase("")|| arrayDet[8].isEmpty()?0:arrayDet[8].trim())+"',"
								+ "'"+(arrayDet[7].trim().equalsIgnoreCase("undefined") || arrayDet[7].trim().equalsIgnoreCase("NaN")|| arrayDet[7].trim().equalsIgnoreCase("")|| arrayDet[7].isEmpty()?0:arrayDet[7].trim())+"')";

						//						System.out.println("==matlist==="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}


					}

				}

				for(int i=0;i< equplist.size();i++){

					String[] arrayDet=((String) equplist.get(i)).split("::");

					//					System.out.println("====equipment activity=="+arrayDet[8]);

					if(!(arrayDet[8].trim().equalsIgnoreCase("undefined")|| arrayDet[8].trim().equalsIgnoreCase("NaN")||arrayDet[8].trim().equalsIgnoreCase("")|| arrayDet[8].isEmpty()))
					{


						String sql="INSERT INTO cm_estmachine(tr_no, SR_NO,assetid,description,lblhours,lblmins, rateHr, total, profitPer,activityid, NetTotal)VALUES"
								+ " ("+docNo+","
								+ " "+(i+2)+","
								+ "'"+(arrayDet[0].trim().equalsIgnoreCase("undefined") || arrayDet[0].trim().equalsIgnoreCase("NaN")|| arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()?0:arrayDet[0].trim())+"',"
								+ "'"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?"":arrayDet[1].trim())+"',"
								+ "'"+(arrayDet[2].trim().equalsIgnoreCase("undefined") || arrayDet[2].trim().equalsIgnoreCase("NaN")|| arrayDet[2].trim().equalsIgnoreCase("")|| arrayDet[2].isEmpty()?0:arrayDet[2].trim())+"',"
								+ "'"+(arrayDet[3].trim().equalsIgnoreCase("undefined") || arrayDet[3].trim().equalsIgnoreCase("NaN")|| arrayDet[3].trim().equalsIgnoreCase("")|| arrayDet[3].isEmpty()?0:arrayDet[3].trim())+"',"
								+ "'"+(arrayDet[4].trim().equalsIgnoreCase("undefined") || arrayDet[4].trim().equalsIgnoreCase("NaN")|| arrayDet[4].trim().equalsIgnoreCase("")|| arrayDet[4].isEmpty()?0:arrayDet[4].trim())+"',"
								+ "'"+(arrayDet[5].trim().equalsIgnoreCase("undefined") || arrayDet[5].trim().equalsIgnoreCase("NaN")|| arrayDet[5].trim().equalsIgnoreCase("")|| arrayDet[5].isEmpty()?0:arrayDet[5].trim())+"',"
								+ "'"+(arrayDet[6].trim().equalsIgnoreCase("undefined") || arrayDet[6].trim().equalsIgnoreCase("NaN")|| arrayDet[6].trim().equalsIgnoreCase("")|| arrayDet[6].isEmpty()?0:arrayDet[6].trim())+"',"
								+ "'"+(arrayDet[8].trim().equalsIgnoreCase("undefined") || arrayDet[8].trim().equalsIgnoreCase("NaN")|| arrayDet[8].trim().equalsIgnoreCase("")|| arrayDet[8].isEmpty()?0:arrayDet[8].trim())+"',"
								+ "'"+(arrayDet[7].trim().equalsIgnoreCase("undefined") || arrayDet[7].trim().equalsIgnoreCase("NaN")|| arrayDet[7].trim().equalsIgnoreCase("")|| arrayDet[7].isEmpty()?0:arrayDet[7].trim())+"')";

						//						System.out.println("==equplist==="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}


					}

				}

				for(int i=0;i< actlist.size();i++){

					String[] arrayDet=((String) actlist.get(i)).split("::");



					if(!(arrayDet[0].trim().equalsIgnoreCase("undefined")|| arrayDet[0].trim().equalsIgnoreCase("NaN")||arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()))
					{

						String sql="INSERT INTO cm_estactivity(doc_no, activityid)VALUES"
								+ " ("+docNo+","
								+ "'"+(arrayDet[0].trim().equalsIgnoreCase("undefined") || arrayDet[0].trim().equalsIgnoreCase("NaN")|| arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()?0:arrayDet[0].trim())+"')";


						//						System.out.println("==actlist==="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}


					}

				}

				conn.commit();
			}


		}
		catch(Exception e){
			e.printStackTrace();
		}



		return vocno;

	}


	public JSONArray materialGridReLoad(HttpSession session,String trno,String aid) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "",sqltest="";

			if(!(aid.equalsIgnoreCase("undefined"))&&!(aid.equalsIgnoreCase(""))&&!(aid.equalsIgnoreCase("0"))){

				if (aid.trim().endsWith(",")) {
					aid = aid.trim().substring(0,aid.length() - 1);
				}
				sqltest=sqltest+" and d.activityid in("+aid+")";
			}

			sql="select d.tr_no,m.psrno,m.psrno pid,m.psrno prodoc,at.mspecno specid,m.part_no productid,m.productname,d.qty qty,d.costprice amount,d.total total,d.profitper margin,d.nettotal netotal,d.description desc1,"
					+ "u.unit unit,m.munit as unitdocno,jobtype as activity,mp.tr_no activityid from cm_estmprdd d  left join cm_prjmaster mp  on(mp.tr_no=d.activityid) left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "
					+ "left join my_unitm u on m.munit=u.doc_no  where 1=1 "+sqltest+" and d.tr_no="+trno+"";


			//			System.out.println("===materialGridLoad===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}

	public JSONArray labourGridReLoad(HttpSession session,String trno,String aid) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "",sqltest="";

			if(!(aid.equalsIgnoreCase("undefined"))&&!(aid.equalsIgnoreCase(""))&&!(aid.equalsIgnoreCase("0"))){

				if (aid.trim().endsWith(",")) {
					aid = aid.trim().substring(0,aid.length() - 1);
				}
				sqltest=sqltest+" and l.activityid in("+aid+")";
			}

			sql="select l.tr_no,othid docno,s.code as codeno,s.name as desc1, rateHr rate,l.description, total total1, profitPer margin1, NetTotal netotal1, "
					+ "lblhours hrs, lblmins min,jobtype as activity,mp.tr_no activityid from cm_estlabour l left join cm_prjmaster mp on(mp.tr_no=l.activityid) "
					+ "left join cm_chrgm s on(s.doc_no=l.othid) where 1=1 "+sqltest+" and l.tr_no="+trno+"";


			//			System.out.println("===labourGridLoad===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}


	public JSONArray equipmentGridReLoad(HttpSession session,String trno,String aid) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "",sqltest="";

			if(!(aid.equalsIgnoreCase("undefined"))&&!(aid.equalsIgnoreCase(""))&&!(aid.equalsIgnoreCase("0"))){

				if (aid.trim().endsWith(",")) {
					aid = aid.trim().substring(0,aid.length() - 1);
				}
				sqltest=sqltest+" and m.activityid in("+aid+")";
			}

			sql="select mp.tr_no,assetid docno,s.code as codeno,s.name as desc2, rateHr rate2,m.description, total total2, profitPer margin2, NetTotal netotal2,"
					+ " lblhours hrs2, lblmins min2,jobtype as activity,mp.tr_no activityid from cm_estmachine m  left join cm_prjmaster mp on(mp.tr_no=m.activityid)"
					+ "left join cm_chrgm s on(s.doc_no=m.assetid) where 1=1 "+sqltest+" and m.tr_no="+trno+"";

			//			System.out.println("===equipmentGridLoad===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}


	public JSONArray searchMaster(HttpSession session,String msdocno,String Cl_namess,String dates,String reftype,int id,String refno) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}

		//  System.out.println("8888888888"+clnames); 	
		String brid=session.getAttribute("BRANCHID").toString();



		java.sql.Date sqlDate=null;


		String sqltest="";

		if(!(msdocno.equalsIgnoreCase("undefined"))&&!(msdocno.equalsIgnoreCase(""))&&!(msdocno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and m.doc_no like '%"+msdocno+"%'";
		}
		if(!(Cl_namess.equalsIgnoreCase("undefined"))&&!(Cl_namess.equalsIgnoreCase(""))&&!(Cl_namess.equalsIgnoreCase("0"))){

			sqltest=sqltest+" and ac.refname like '%"+Cl_namess+"%'";
		}
		if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0"))){
			sqlDate = com.changeStringtoSqlDate(dates);
			sqltest=sqltest+" and m.date<="+sqlDate+"";
		}
		if(!(reftype.equalsIgnoreCase("undefined"))&&!(reftype.equalsIgnoreCase(""))&&!(reftype.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and m.ref_type like '%"+reftype+"%'";
		}
		if(!(refno.equalsIgnoreCase("undefined"))&&!(refno.equalsIgnoreCase(""))&&!(refno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and m.refdocno="+refno+"";
		}


		Connection conn = null;
		ResultSet resultSet =null;
		try {

			conn = conobj.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();

			/*String str1Sql=("select m.doc_no,m.tr_no,ac.refname as client,ac.doc_no as cldocno,m.date,m.reviseno,m.ref_type,CONVERT(coalesce(m.refdocno,''),CHAR(100)) as refdocno,material,"
					+ " labour, machine, netTotal,mp.jobtype as activity,mp.tr_no as activityid from cm_prjestm m left join cm_estactivity ea on(m.tr_no=ea.doc_no) left join cm_prjmaster mp on(mp.tr_no=ea.activityid) "
					+ "left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') where 1=1 "+sqltest+" ");*/

			String str1Sql="select m.doc_no,m.tr_no,ac.refname as client,ac.doc_no as cldocno,m.date,m.reviseno,m.ref_type,CONVERT(coalesce(m.refdocno,''),CHAR(100)) as refdocno,"
					+ "material, labour, machine, netTotal,m.reftrno,trim(ac.address) address from  cm_prjestm m left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') where m.status=3 "+sqltest+"";

			//			System.out.println("==refmainsearch==="+str1Sql);
			if(id>0){
				resultSet = stmtenq1.executeQuery(str1Sql);

			}
			RESULTDATA=com.convertToJSON(resultSet);

			stmtenq1.close();
			conn.close();
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}

		return RESULTDATA;
	}

	public JSONArray activityReLoad(HttpSession session,int trno) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}

		//  System.out.println("8888888888"+clnames); 	
		String brid=session.getAttribute("BRANCHID").toString();



		java.sql.Date sqlStartDate=null;


		String sqltest="";


		/*aid = aid.replaceAll(", $", "");
		sid = sid.replaceAll(", $", "");
		pid = pid.replaceAll(", $", "");*/

		/*if (trno.trim().endsWith(",")) {
			trno = trno.trim().substring(0,trno.length() - 1);
		}*/

		Connection conn = null;

		try {

			conn = conobj.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();

			String str1Sql=("select m.date,m.doc_no,m.tr_no,m.jobtype as activity,p.groupname as project,cgroup as projectid,s.groupname as section,"
					+ "cdivision as sectionid from cm_estactivity ea left join  cm_prjmaster m on(ea.activityid=m.tr_no) left join my_groupvals p on(m.cgroup= p.doc_no and p.grptype='project') "
					+ "left join my_groupvals s on(m.cdivision=s.doc_no and s.grptype='section') where 1=1  and ea.doc_no="+trno+"");



			//			System.out.println("==activityReLoad==="+str1Sql);

			ResultSet resultSet = stmtenq1.executeQuery(str1Sql);

			RESULTDATA=com.convertToJSON(resultSet);
			stmtenq1.close();
			conn.close();
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}

		return RESULTDATA;
	}

	public int edit(int docNo,String vocno,java.sql.Date date,int clientid,String reviseno,String cmbreftype,String txtenquiry,String txtnettotal,String txtmatotal,String txtlabtotal,
			String txteqptotal,String formcode,int enqid,String mode,ArrayList matlist,ArrayList lablist,ArrayList equplist,ArrayList actlist,HttpSession session,
			HttpServletRequest request,String activitiesid){


		Connection conn=null;


		try{

			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmt = conn.prepareCall("{CALL Sr_EstimationDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmt.registerOutParameter(18, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			stmt.setInt(2,clientid);
			stmt.setString(3,reviseno);
			stmt.setString(4,cmbreftype);
			stmt.setString(5,txtenquiry);
			stmt.setString(6,txtnettotal);
			stmt.setString(7,txtmatotal);
			stmt.setString(8,txtlabtotal);
			stmt.setString(9,txteqptotal);
			stmt.setString(10,mode);
			stmt.setString(11,formcode);
			stmt.setInt(12,enqid);
			stmt.setString(13, session.getAttribute("BRANCHID").toString());
			stmt.setString(14, session.getAttribute("USERID").toString());
			stmt.setString(15, activitiesid);
			stmt.setInt(16, docNo);
			stmt.setString(17,vocno);
			int val = stmt.executeUpdate();
			docNo=stmt.getInt("docNo");
			vocno=stmt.getString("vocNo");
			request.setAttribute("docNo", docNo);


			if(docNo>0){


				for(int i=0;i< matlist.size();i++){


					String[] arrayDet=((String) matlist.get(i)).split("::");

					//					System.out.println("====material activity=="+arrayDet[9]);

					if(!(arrayDet[9].trim().equalsIgnoreCase("undefined")|| arrayDet[9].trim().equalsIgnoreCase("NaN")||arrayDet[9].trim().equalsIgnoreCase("")|| arrayDet[9].isEmpty()))
					{

						//SpecNo					

						String sql="INSERT INTO cm_estmprdd(tr_no, SR_NO,Description, psrno, prdId,UNITID, qty, costPrice,  total, profitPer,activityid, NetTotal)VALUES"
								+ " ("+docNo+","
								+ " "+(i+1)+","
								+ "'"+(arrayDet[0].trim().equalsIgnoreCase("undefined") || arrayDet[0].trim().equalsIgnoreCase("NaN")|| arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()?"":arrayDet[0].trim())+"',"
								+ "'"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?0:arrayDet[1].trim())+"',"
								+ "'"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?0:arrayDet[1].trim())+"',"
								+ "'"+(arrayDet[3].trim().equalsIgnoreCase("undefined") || arrayDet[3].trim().equalsIgnoreCase("NaN")|| arrayDet[3].trim().equalsIgnoreCase("")|| arrayDet[3].isEmpty()?0:arrayDet[3].trim())+"',"
								+ "'"+(arrayDet[4].trim().equalsIgnoreCase("undefined") || arrayDet[4].trim().equalsIgnoreCase("NaN")|| arrayDet[4].trim().equalsIgnoreCase("")|| arrayDet[4].isEmpty()?0:arrayDet[4].trim())+"',"
								+ "'"+(arrayDet[5].trim().equalsIgnoreCase("undefined") || arrayDet[5].trim().equalsIgnoreCase("NaN")|| arrayDet[5].trim().equalsIgnoreCase("")|| arrayDet[5].isEmpty()?0:arrayDet[5].trim())+"',"
								+ "'"+(arrayDet[6].trim().equalsIgnoreCase("undefined") || arrayDet[6].trim().equalsIgnoreCase("NaN")|| arrayDet[6].trim().equalsIgnoreCase("")|| arrayDet[6].isEmpty()?0:arrayDet[6].trim())+"',"
								+ "'"+(arrayDet[7].trim().equalsIgnoreCase("undefined") || arrayDet[7].trim().equalsIgnoreCase("NaN")|| arrayDet[7].trim().equalsIgnoreCase("")|| arrayDet[7].isEmpty()?0:arrayDet[7].trim())+"',"
								+ "'"+(arrayDet[9].trim().equalsIgnoreCase("undefined") || arrayDet[9].trim().equalsIgnoreCase("NaN")|| arrayDet[9].trim().equalsIgnoreCase("")|| arrayDet[9].isEmpty()?0:arrayDet[9].trim())+"',"
								+ "'"+(arrayDet[8].trim().equalsIgnoreCase("undefined") || arrayDet[8].trim().equalsIgnoreCase("NaN")|| arrayDet[8].trim().equalsIgnoreCase("")|| arrayDet[8].isEmpty()?0:arrayDet[8].trim())+"')";

						//						System.out.println("==matlist==="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}
						//conn.commit();

					}

				}


				for(int i=0;i< lablist.size();i++){


					String[] arrayDet=((String) lablist.get(i)).split("::");

					//					System.out.println("====labal activity=="+arrayDet[8]);

					if(!(arrayDet[8].trim().equalsIgnoreCase("undefined")|| arrayDet[8].trim().equalsIgnoreCase("NaN")||arrayDet[8].trim().equalsIgnoreCase("")|| arrayDet[8].isEmpty()))
					{


						String sql="INSERT INTO cm_estlabour(tr_no, SR_NO,othid,description,lblhours,lblmins, rateHr, total, profitPer,activityid, NetTotal)VALUES"
								+ " ("+docNo+","
								+ " "+(i+1)+","
								+ "'"+(arrayDet[0].trim().equalsIgnoreCase("undefined") || arrayDet[0].trim().equalsIgnoreCase("NaN")|| arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()?0:arrayDet[0].trim())+"',"
								+ "'"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?0:arrayDet[1].trim())+"',"
								+ "'"+(arrayDet[2].trim().equalsIgnoreCase("undefined") || arrayDet[2].trim().equalsIgnoreCase("NaN")|| arrayDet[2].trim().equalsIgnoreCase("")|| arrayDet[2].isEmpty()?0:arrayDet[2].trim())+"',"
								+ "'"+(arrayDet[3].trim().equalsIgnoreCase("undefined") || arrayDet[3].trim().equalsIgnoreCase("NaN")|| arrayDet[3].trim().equalsIgnoreCase("")|| arrayDet[3].isEmpty()?0:arrayDet[3].trim())+"',"
								+ "'"+(arrayDet[4].trim().equalsIgnoreCase("undefined") || arrayDet[4].trim().equalsIgnoreCase("NaN")|| arrayDet[4].trim().equalsIgnoreCase("")|| arrayDet[4].isEmpty()?0:arrayDet[4].trim())+"',"
								+ "'"+(arrayDet[5].trim().equalsIgnoreCase("undefined") || arrayDet[5].trim().equalsIgnoreCase("NaN")|| arrayDet[5].trim().equalsIgnoreCase("")|| arrayDet[5].isEmpty()?0:arrayDet[5].trim())+"',"
								+ "'"+(arrayDet[6].trim().equalsIgnoreCase("undefined") || arrayDet[6].trim().equalsIgnoreCase("NaN")|| arrayDet[6].trim().equalsIgnoreCase("")|| arrayDet[6].isEmpty()?0:arrayDet[6].trim())+"',"
								+ "'"+(arrayDet[8].trim().equalsIgnoreCase("undefined") || arrayDet[8].trim().equalsIgnoreCase("NaN")|| arrayDet[8].trim().equalsIgnoreCase("")|| arrayDet[8].isEmpty()?0:arrayDet[8].trim())+"',"
								+ "'"+(arrayDet[7].trim().equalsIgnoreCase("undefined") || arrayDet[7].trim().equalsIgnoreCase("NaN")|| arrayDet[7].trim().equalsIgnoreCase("")|| arrayDet[7].isEmpty()?0:arrayDet[7].trim())+"')";

						//						System.out.println("==matlist==="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}


					}

				}

				for(int i=0;i< equplist.size();i++){

					String[] arrayDet=((String) equplist.get(i)).split("::");

					//					System.out.println("====equipment activity=="+arrayDet[8]);

					if(!(arrayDet[8].trim().equalsIgnoreCase("undefined")|| arrayDet[8].trim().equalsIgnoreCase("NaN")||arrayDet[8].trim().equalsIgnoreCase("")|| arrayDet[8].isEmpty()))
					{


						String sql="INSERT INTO cm_estmachine(tr_no, SR_NO,assetid,description,lblhours,lblmins, rateHr, total, profitPer,activityid, NetTotal)VALUES"
								+ " ("+docNo+","
								+ " "+(i+2)+","
								+ "'"+(arrayDet[0].trim().equalsIgnoreCase("undefined") || arrayDet[0].trim().equalsIgnoreCase("NaN")|| arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()?0:arrayDet[0].trim())+"',"
								+ "'"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?"":arrayDet[1].trim())+"',"
								+ "'"+(arrayDet[2].trim().equalsIgnoreCase("undefined") || arrayDet[2].trim().equalsIgnoreCase("NaN")|| arrayDet[2].trim().equalsIgnoreCase("")|| arrayDet[2].isEmpty()?0:arrayDet[2].trim())+"',"
								+ "'"+(arrayDet[3].trim().equalsIgnoreCase("undefined") || arrayDet[3].trim().equalsIgnoreCase("NaN")|| arrayDet[3].trim().equalsIgnoreCase("")|| arrayDet[3].isEmpty()?0:arrayDet[3].trim())+"',"
								+ "'"+(arrayDet[4].trim().equalsIgnoreCase("undefined") || arrayDet[4].trim().equalsIgnoreCase("NaN")|| arrayDet[4].trim().equalsIgnoreCase("")|| arrayDet[4].isEmpty()?0:arrayDet[4].trim())+"',"
								+ "'"+(arrayDet[5].trim().equalsIgnoreCase("undefined") || arrayDet[5].trim().equalsIgnoreCase("NaN")|| arrayDet[5].trim().equalsIgnoreCase("")|| arrayDet[5].isEmpty()?0:arrayDet[5].trim())+"',"
								+ "'"+(arrayDet[6].trim().equalsIgnoreCase("undefined") || arrayDet[6].trim().equalsIgnoreCase("NaN")|| arrayDet[6].trim().equalsIgnoreCase("")|| arrayDet[6].isEmpty()?0:arrayDet[6].trim())+"',"
								+ "'"+(arrayDet[8].trim().equalsIgnoreCase("undefined") || arrayDet[8].trim().equalsIgnoreCase("NaN")|| arrayDet[8].trim().equalsIgnoreCase("")|| arrayDet[8].isEmpty()?0:arrayDet[8].trim())+"',"
								+ "'"+(arrayDet[7].trim().equalsIgnoreCase("undefined") || arrayDet[7].trim().equalsIgnoreCase("NaN")|| arrayDet[7].trim().equalsIgnoreCase("")|| arrayDet[7].isEmpty()?0:arrayDet[7].trim())+"')";

						//						System.out.println("==equplist==="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}


					}

				}

				for(int i=0;i< actlist.size();i++){

					String[] arrayDet=((String) actlist.get(i)).split("::");



					if(!(arrayDet[0].trim().equalsIgnoreCase("undefined")|| arrayDet[0].trim().equalsIgnoreCase("NaN")||arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()))
					{

						String sql="INSERT INTO cm_estactivity(doc_no, activityid)VALUES"
								+ " ("+docNo+","
								+ "'"+(arrayDet[0].trim().equalsIgnoreCase("undefined") || arrayDet[0].trim().equalsIgnoreCase("NaN")|| arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()?0:arrayDet[0].trim())+"')";


						//						System.out.println("==actlist==="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}


					}

				}

				conn.commit();
			}


		}
		catch(Exception e){
			e.printStackTrace();
		}



		return Integer.parseInt(vocno);

	}
	
	
	public int delete(int docNo,String vocno,java.sql.Date date,int clientid,String reviseno,String cmbreftype,String txtenquiry,String txtnettotal,String txtmatotal,String txtlabtotal,
			String txteqptotal,String formcode,int enqid,String mode,ArrayList matlist,ArrayList lablist,ArrayList equplist,ArrayList actlist,HttpSession session,
			HttpServletRequest request,String activitiesid){


		Connection conn=null;


		try{

			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmt = conn.prepareCall("{CALL Sr_EstimationDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmt.registerOutParameter(18, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			stmt.setInt(2,clientid);
			stmt.setString(3,reviseno);
			stmt.setString(4,cmbreftype);
			stmt.setString(5,txtenquiry);
			stmt.setString(6,txtnettotal);
			stmt.setString(7,txtmatotal);
			stmt.setString(8,txtlabtotal);
			stmt.setString(9,txteqptotal);
			stmt.setString(10,mode);
			stmt.setString(11,formcode);
			stmt.setInt(12,enqid);
			stmt.setString(13, session.getAttribute("BRANCHID").toString());
			stmt.setString(14, session.getAttribute("USERID").toString());
			stmt.setString(15, activitiesid);
			stmt.setInt(16, docNo);
			stmt.setString(17,vocno);
			int val = stmt.executeUpdate();
			docNo=stmt.getInt("docNo");
			vocno=stmt.getString("vocNo");
			request.setAttribute("docNo", docNo);


			if(docNo>0){

				conn.commit();
			}


		}
		catch(Exception e){
			e.printStackTrace();
		}



		return Integer.parseInt(vocno);

	}





}
