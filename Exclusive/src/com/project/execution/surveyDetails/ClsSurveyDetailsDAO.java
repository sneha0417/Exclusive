package com.project.execution.surveyDetails;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.project.execution.serviceContract.ClsServiceContractBean;

public class ClsSurveyDetailsDAO {

	ClsCommon com=new ClsCommon();
	ClsConnection conobj=new ClsConnection();
	ClsSurveyDetailsBean bean=new ClsSurveyDetailsBean();

	public JSONArray enquirySrearch(HttpSession session,String msdocno,String Cl_names,String Cl_mobno,String enqdate,int id) throws SQLException {

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



		Connection conn =null;
		Statement stmt = null;
		try {
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();

			if(id>0){

				String str1Sql=("select m.date,m.doc_no,m.voc_no, if(m.cldocno>0,ac.refname,m.name) as name,coalesce(ac.doc_no,0) as clientid, "
						+ "if(m.cldocno>0,concat(coalesce(ac.address,''),',',coalesce(ac.com_mob,'') ,',',coalesce(ac.mail1,'') ),com_add1) as details, "
						+ "if(m.cpersonid>0,c.cperson,coalesce(m.cperson,'')) as cperson,coalesce(c.row_no,0) as cpersonid, "
						+ "if(m.cpersonid>0,c.mob,coalesce(m.mob,'')) as contmob,m.sh_empid empid,UPPER(coalesce(hm.name,'')) empname from gl_enqm m left join my_acbook ac "
						+ "on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_crmcontact c on(c.row_no=m.cpersonid) left join  hr_empm hm on m.sh_empid=hm.doc_no where surtrno=0 and m.status=3 "+sqltest+"");

				//System.out.println("======enqsearch===="+str1Sql);

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


	public JSONArray employeeDetailsSearch(String empid,String employeename,String contact) throws SQLException {
		Connection conn=null;

		JSONArray RESULTDATA1=new JSONArray();

		try {
			conn = conobj.getMyConnection();
			Statement stmtATTN = conn.createStatement();

			String sql = "";

			if(!(empid.equalsIgnoreCase(""))){
				sql=sql+" and m.codeno like '%"+empid+"%'";
			}
			if(!(employeename.equalsIgnoreCase(""))){
				sql=sql+" and m.name like '%"+employeename+"%'";
			}
			if(!(contact.equalsIgnoreCase(""))){
				sql=sql+" and m.pmmob like '%"+contact+"%'";
			}

			sql = "select  distinct m.doc_no,m.codeno,UPPER(m.name) name,m.pmmob  from  hr_empm m left join cm_serteamd d on(m.doc_no=d.empid) where m.status=3"+sql;


//			System.out.println("===sql===="+sql);


			ResultSet resultSet1 = stmtATTN.executeQuery(sql);

			RESULTDATA1=com.convertToJSON(resultSet1);

			stmtATTN.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return RESULTDATA1;
	}

	public JSONArray areaSearch(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select groupname area,codeno,doc_no areadocno from my_groupvals where grptype='area' and status=3";


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



	public JSONArray serviceSearch(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select groupname service,codeno,doc_no serdocno from my_groupvals where grptype='service' and status=3";


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


	public JSONArray ServiceType(HttpSession session,String docno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select m.doc_no servtypeid,name servtype,d.description as sepc,d.rowno specid,d.rowno rdocno from cm_proptypem m "
					+ "left join cm_proptyped d on(m.doc_no=d.doc_no) where m.doc_no in ("+docno+") order by m.doc_no";


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

	public JSONArray buildAMC(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select d.description as sepc,d.rowno specid,d.rowno rdocno from cm_proptypem m left join cm_proptyped d on(m.doc_no=d.doc_no)  where name='Building-AMC'";


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

	public JSONArray projectdetails(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select d.description as sepc,d.rowno specid,d.rowno rdocno from cm_proptypem m left join cm_proptyped d on(m.doc_no=d.doc_no) where name='Project'";


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


	public JSONArray searchSerType(HttpSession session,String sertype,String sertypeid,String id) throws SQLException {


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


		if(!(sertype.equalsIgnoreCase("undefined"))&&!(sertype.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.name like '%"+sertype+"%'";
		}

		if(!(sertypeid.equalsIgnoreCase("undefined"))&&!(sertypeid.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.doc_no not in("+sertypeid+")";
		}


		Connection conn = null;
		ResultSet resultSet =null;
		try {
			if(Integer.parseInt(id)>0){
				conn = conobj.getMyConnection();
				Statement stmtenq1 = conn.createStatement ();

				String str1Sql=("select doc_no,name from cm_proptypem m where status=3 "+sqltest+"");

//				System.out.println("==searchSerType==="+str1Sql);


				resultSet = stmtenq1.executeQuery(str1Sql);


				RESULTDATA=com.convertToJSON(resultSet);
				stmtenq1.close();
				conn.close();
			}

		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}

		return RESULTDATA;
	}


	public JSONArray loadSerType(HttpSession session,String aid,String sid,String pid) throws SQLException {


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


	public int insert(java.sql.Date date,int enqid,int clientid,int empid,String txtdesc,String enqno,ArrayList sertypelist,ArrayList sertypedetlist,ArrayList servlist,
			ArrayList sitelist,HttpSession session,HttpServletRequest request,String mode,String formcode,int cpersonid,String sertypeids,String contractr) throws SQLException{

		Connection conn=null;
		int docNo=0;
		int vocno=0;
		int tranid=0;

		try{


			conn=conobj.getMyConnection();

			conn.setAutoCommit(false);


			CallableStatement stmt = conn.prepareCall("{CALL Sr_surveydetailsDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(15, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			stmt.setInt(2,enqid);
			stmt.setInt(3, clientid);
			stmt.setInt(4,empid);
			stmt.setString(5,txtdesc);
			stmt.setString(6,enqno);
			stmt.setString(7,mode);
			stmt.setString(8,formcode);
			stmt.setString(9, session.getAttribute("BRANCHID").toString());
			stmt.setString(10, session.getAttribute("USERID").toString());
			stmt.setInt(11,cpersonid);
			stmt.setString(12,sertypeids);
			stmt.setString(13,contractr);

			int val = stmt.executeUpdate();
			docNo=stmt.getInt("docNo");
			vocno=stmt.getInt("vocNo");
			request.setAttribute("docNo", docNo);

			if(docNo>0){

//				System.out.println("=====sertypelist.size()===="+sertypelist.size());

				for(int i=0;i< sertypelist.size();i++){


					String[] surveydet=((String) sertypelist.get(i)).split("::");

					if(!(surveydet[1].trim().equalsIgnoreCase("undefined")|| surveydet[1].trim().equalsIgnoreCase("NaN")||surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()))
					{

//						System.out.println("=====surveydet[3]===="+surveydet[3]);

						String sql="INSERT INTO cm_surveyd(sr_no,propId,details, description,propType,rdocno)VALUES"
								+ " ("+(i+1)+","
								+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
								+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?"":surveydet[1].trim())+"',"
								+ "'"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")||surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?"":surveydet[2].trim())+"',"
								+ ""+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")||surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:surveydet[3].trim())+","
								+"'"+docNo+"')";


//						System.out.println("===sql====="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}	

					}

				}



				for(int i=0;i< servlist.size();i++){


					String[] surveydet=((String) servlist.get(i)).split("::");
					if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
					{

						String sql="INSERT INTO cm_surveysd( sr_no, servId, rdocno)VALUES"
								+ " ("+(i+1)+","
								+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
								+"'"+docNo+"')";

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}	

					}

				}

				for(int i=0;i< sertypedetlist.size();i++){


					String[] surveydet=((String) sertypedetlist.get(i)).split("::");
					if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
					{

						String sql="INSERT INTO cm_sursertype(sertypeid, doc_no)VALUES"
								+ "('"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
								+"'"+docNo+"')";

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}	

					}

				}



				for(int i=0;i< sitelist.size();i++){


					String[] surveydet=((String) sitelist.get(i)).split("::");
					if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
					{

						String sql="INSERT INTO cm_surveysid(site, areaid,sr_no,rdocno)VALUES"
								+ "('"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
								+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
								+ " "+(i+1)+","
								+"'"+docNo+"')";


//						System.out.println("====sql====="+sql);

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
		finally{
			conn.close();
		}





		return vocno;


	}

	public int edit(int docNo,int vocno,java.sql.Date date,int enqid,int clientid,int empid,String txtdesc,String enqno,ArrayList sertypelist,ArrayList sertypedetlist,
			ArrayList servlist,ArrayList sitelist,HttpSession session,HttpServletRequest request,String mode,String formcode,int cpersonid,String sertypeids,String contractr) throws SQLException{

		Connection conn=null;
		int tranid=0;

		try{

			sertypeids=sertypeids.trim();

			conn=conobj.getMyConnection();

			conn.setAutoCommit(false);


			CallableStatement stmt = conn.prepareCall("{CALL Sr_surveydetailsDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");


			stmt.setDate(1,date);
			stmt.setInt(2,enqid);
			stmt.setInt(3, clientid);
			stmt.setInt(4,empid);
			stmt.setString(5,txtdesc);
			stmt.setString(6,enqno);
			stmt.setString(7,mode);
			stmt.setString(8,formcode);
			stmt.setString(9, session.getAttribute("BRANCHID").toString());
			stmt.setString(10, session.getAttribute("USERID").toString());
			stmt.setInt(11,cpersonid);
			stmt.setString(12,sertypeids);
			stmt.setString(13,contractr);
			stmt.setInt(14, docNo);
			stmt.setInt(15, vocno);
			int val = stmt.executeUpdate();
			docNo=stmt.getInt("docNo");
			vocno=stmt.getInt("vocNo");
			request.setAttribute("docNo", docNo);

			if(docNo>0){


				for(int i=0;i< sertypelist.size();i++){


					String[] surveydet=((String) sertypelist.get(i)).split("::");
					if(!(surveydet[1].trim().equalsIgnoreCase("undefined")|| surveydet[1].trim().equalsIgnoreCase("NaN")||surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()))
					{

						String sql="INSERT INTO cm_surveyd(sr_no,propId,details, description,propType,rdocno)VALUES"
								+ " ("+(i+1)+","
								+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
								+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?"":surveydet[1].trim())+"',"
								+ "'"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")||surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?"":surveydet[2].trim())+"',"
								+ "'"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")||surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?"":surveydet[3].trim())+"',"
								+"'"+docNo+"')";

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}	

					}

				}

				for(int i=0;i< servlist.size();i++){


					String[] surveydet=((String) servlist.get(i)).split("::");
					if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
					{

						String sql="INSERT INTO cm_surveysd( sr_no, servId, rdocno)VALUES"
								+ " ("+(i+1)+","
								+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
								+"'"+docNo+"')";

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}	

					}

				}


				for(int i=0;i< sertypedetlist.size();i++){


					String[] surveydet=((String) sertypedetlist.get(i)).split("::");
					if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
					{

						String sql="INSERT INTO cm_sursertype(sertypeid, doc_no)VALUES"
								+ "('"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
								+"'"+docNo+"')";

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}	

					}

				}




				for(int i=0;i< sitelist.size();i++){


					String[] surveydet=((String) sitelist.get(i)).split("::");
					if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
					{

						String sql="INSERT INTO cm_surveysid(site, areaid,sr_no,rdocno)VALUES"
								+ "('"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
								+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
							+ " "+(i+1)+","
								+"'"+docNo+"')";




						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}	

					}

				}


			}

			conn.commit();		
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}





		return vocno;


	}

	public int delete(int docNo,int vocno,java.sql.Date date,int enqid,int clientid,int empid,String txtdesc,String enqno,ArrayList sertypelist,ArrayList sertypedetlist,
			ArrayList servlist,ArrayList sitelist,HttpSession session,HttpServletRequest request,String mode,String formcode,int cpersonid,String sertypeids,String contractr) throws SQLException{

		Connection conn=null;
		int tranid=0;

		try{


			conn=conobj.getMyConnection();

			conn.setAutoCommit(false);


			CallableStatement stmt = conn.prepareCall("{CALL Sr_surveydetailsDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");


			stmt.setDate(1,date);
			stmt.setInt(2,enqid);
			stmt.setInt(3, clientid);
			stmt.setInt(4,empid);
			stmt.setString(5,txtdesc);
			stmt.setString(6,enqno);
			stmt.setString(7,mode);
			stmt.setString(8,formcode);
			stmt.setString(9, session.getAttribute("BRANCHID").toString());
			stmt.setString(10, session.getAttribute("USERID").toString());
			stmt.setInt(11,cpersonid);
			stmt.setString(12,sertypeids);
			stmt.setString(13,contractr);
			stmt.setInt(14, docNo);
			stmt.setInt(15, vocno);
			int val = stmt.executeUpdate();
			docNo=stmt.getInt("docNo");
			vocno=stmt.getInt("vocNo");
			request.setAttribute("docNo", docNo);


			conn.commit();		
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}





		return vocno;


	}



	public JSONArray ServiceTypeGridReLaod(HttpSession session,String docno,String serid) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select * from (select m.doc_no servtypeid,name servtype,d.description as sepc,d.rowno specid,d.rowno rdocno,coalesce(sd.description,'') desc1, "
					+ "coalesce(details,'') details from cm_proptypem m left join cm_proptyped d on(m.doc_no=d.doc_no) "
					+ "left join cm_surveyd sd on(sd.propid=d.rowno and sd.proptype=m.doc_no) "
					+ " where sd.rdocno="+docno+" and sd.proptype in ("+serid+") union all "
					+ "select m.doc_no servtypeid,name servtype,d.description sepc,d.rowno specid,0 rdocno,'' desc1,'' details from "
					+ "cm_proptypem m left join cm_proptyped d on(m.doc_no=d.doc_no) "
					+ "where d.doc_no  in ("+serid+") and d.rowno not in (select propid from cm_surveyd where rdocno="+docno+")) as a order by servtypeid";


				System.out.println("===ServiceTypeGridReLaod===="+sql);

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

	public JSONArray buildAMCGridLoad(HttpSession session,String docno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			/*sql="select d.description as sepc,d.rowno specid,d.rowno rdocno,coalesce(sd.description,'') desc1,coalesce(details,'') details from "
				+ "cm_proptypem m left join cm_proptyped d on(m.doc_no=d.doc_no) left join cm_surveyd sd on(sd.propid=d.rowno) "
				+ "where name='Building-AMC' and sd.rdocno="+docno+"";*/

			sql="select * from (select d.description as sepc,d.rowno specid,d.rowno rdocno,coalesce(sd.description,'') desc1, "
					+ "coalesce(details,'') details from cm_proptypem m left join cm_proptyped d on(m.doc_no=d.doc_no) "
					+ "left join cm_surveyd sd on(sd.propid=d.rowno) where name='Building-AMC' and sd.rdocno="+docno+" union all "
					+ "select d.description sepc,d.rowno specid,0 rdocno,'' desc1,'' details from "
					+ "cm_proptypem m left join cm_proptyped d on(m.doc_no=d.doc_no) "
					+ "where name='Building-AMC' and rowno not in (select propid from cm_surveyd where proptype=2 and rdocno="+docno+")) as a";


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

	public JSONArray projectAMCGridLoad(HttpSession session,String docno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			/*sql="select d.description as sepc,d.rowno specid,d.rowno rdocno,coalesce(sd.description,'') desc1,coalesce(details,'') details from "
				+ "cm_proptypem m left join cm_proptyped d on(m.doc_no=d.doc_no) left join cm_surveyd sd on(sd.propid=d.rowno) "
				+ "where name='Warehouse-AMC' and sd.rdocno="+docno+"";*/


			sql="select * from (select d.description as sepc,d.rowno specid,d.rowno rdocno,coalesce(sd.description,'') desc1, "
					+ "coalesce(details,'') details from cm_proptypem m left join cm_proptyped d on(m.doc_no=d.doc_no) "
					+ "left join cm_surveyd sd on(sd.propid=d.rowno) where name='project' and sd.rdocno="+docno+" union all "
					+ "select d.description sepc,d.rowno specid,0 rdocno,'' desc1,'' details from "
					+ "cm_proptypem m left join cm_proptyped d on(m.doc_no=d.doc_no) "
					+ "where name='project' and rowno not in (select propid from cm_surveyd where proptype=3 and rdocno="+docno+")) as a ";


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



	public JSONArray siteGridLoad(HttpSession session,String docno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";


			sql="select groupname area,s.doc_no areaid,site from  cm_surveysid d left join my_groupvals s on(s.doc_no=d.areaid) where grptype='area' and d.rdocno="+docno+"";


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

	public JSONArray serviceGridLoad(HttpSession session,String docno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";



			sql="select groupname service,s.doc_no serid from  cm_surveysd d left join my_groupvals s on(s.doc_no=d.servid) where grptype='service' and d.rdocno="+docno+"";

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


	public JSONArray searchMaster(HttpSession session,String msdocno,String Cl_names,String Cl_enqno,String surdate,int id) throws SQLException {


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
		if(!(surdate.equalsIgnoreCase("undefined"))&&!(surdate.equalsIgnoreCase(""))&&!(surdate.equalsIgnoreCase("0")))
		{
			sqlStartDate = com.changeStringtoSqlDate(surdate);
			sqltest=sqltest+" and m.date<="+sqlStartDate+"";
		}
		if(!(msdocno.equalsIgnoreCase("")) &&!(msdocno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and m.voc_no like '%"+msdocno+"%'";
		}
		if(!(Cl_names.equalsIgnoreCase("")) &&!(Cl_names.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and ac.refname like '%"+Cl_names+"%'";
		}
		if(!(Cl_enqno.equalsIgnoreCase("")) && !(Cl_enqno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and m.refvocno like '%"+Cl_enqno+"%'";
		}


		Connection conn = null;

		try {
			conn = conobj.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();

			if(id>0){
				String str1Sql=("select m.date,m.doc_no,m.voc_no,m.refdocno enqdoc_no,m.refvocno enqvoc_no,ac.refname as name,coalesce(ac.doc_no,0) as clientid,"
						+ "concat(coalesce(ac.address,''),',',coalesce(ac.com_mob,'') ,',',coalesce(ac.mail1,'') ) as details,"
						+ "c.cperson as cperson,c.row_no as cpersonid,c.mob as contmob,em.name survey,em.doc_no as surveyid,m.remarks,excontr,eq.enqstatus from cm_surveym m left join my_acbook ac "
						+ "on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_crmcontact c on(c.row_no=m.cpersonid) "
						+ "left join hr_empm em on(m.survby=em.doc_no) left join gl_enqm eq on eq.doc_no=m.refdocno where 1=1 and m.status=3 "+sqltest+" ");

				System.out.println("==survey refmainsearch==="+str1Sql);

				ResultSet resultSet = stmtenq1.executeQuery(str1Sql);

				RESULTDATA=com.convertToJSON(resultSet);
				stmtenq1.close();
				conn.close();
			}
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;

	}


	public JSONArray serTypeReLoad(HttpSession session,int trno) throws SQLException {


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

			String str1Sql=("select pm.name servtype,pm.doc_no from cm_surveym m left join cm_sursertype s on(m.doc_no=s.doc_no) "
					+ "left join cm_proptypem pm on(pm.doc_no=s.sertypeid) where m.doc_no="+trno+"");




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


	public JSONArray loadSertype(HttpSession session,String aid,String sid,String pid) throws SQLException {


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


	public ClsSurveyDetailsBean printMaster(HttpSession session,String docno,String brhid,String trno,String dtype,String sertypeids) throws SQLException {



		String brid=session.getAttribute("BRANCHID").toString();
		java.sql.Date sqlStartDate=null;
		String sqltest="";
		Connection conn = null;
		ArrayList sitelist=null;
		ArrayList trlist=null;
		ArrayList serlist=null;
		ArrayList list=null;
		try {
			sitelist=new ArrayList();
			trlist=new ArrayList();
			serlist=new ArrayList();
			list=new ArrayList();

			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement ();

			String Sql1=("select DATE_FORMAT(m.date,'%d-%m-%Y') as date,m.doc_no,m.voc_no,m.refdocno enqdoc_no,m.refvocno enqvoc_no,ac.refname as name,coalesce(ac.doc_no,0) as clientid,"
					+ "coalesce(ac.address,'') as details,coalesce(ac.com_mob,'') as mob,coalesce(ac.mail1,'') as email, "
					+ "c.cperson as cperson,c.row_no as cpersonid,c.mob as contmob,em.name survey,em.doc_no as surveyid,m.remarks,b.branchname brch, "
					+ "b.address as baddress,b.tel,b.fax,com.company comp,loc.loc_name,DATE_FORMAT(CURDATE(),'%d/%m/%Y') as finaldate,excontr from cm_surveym m left join my_acbook ac "
					+ "on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_crmcontact c on(c.row_no=m.cpersonid) left join hr_empm em on(m.survby=em.doc_no) "
					+ "left join my_brch b on(b.doc_no=m.brhid) left join my_locm loc on(b.doc_no=loc.brhid) left join my_comp com on(com.doc_no=b.cmpid)  "
					+ "where  m.status!=7 and m.voc_no='"+docno+"' and m.brhid='"+brhid+"'");


		System.out.println("==surveydetails======"+Sql1);	

			ResultSet rs = stmt.executeQuery(Sql1);

			while(rs.next()){

				bean.setDate(rs.getString("date"));
				bean.setDocno(rs.getString("voc_no"));
				bean.setEnqdoc_no(Integer.parseInt(rs.getString("enqvoc_no")));
				
				bean.setTxtclient(rs.getString("name"));
				bean.setTxtclientdet(rs.getString("details"));
				bean.setTxtmob(rs.getString("mob"));
				bean.setTxtemail(rs.getString("email"));
				bean.setTxtcontact(rs.getString("cperson"));
				bean.setSurveyedby(rs.getString("survey"));
				bean.setTxtdesc(rs.getString("remarks"));
				bean.setLblbranch(rs.getString("brch"));
				bean.setLblcompaddress(rs.getString("baddress"));
				bean.setLblcompfax(rs.getString("fax"));
				bean.setLblcomptel(rs.getString("tel"));
				bean.setLbllocation(rs.getString("loc_name"));
				bean.setLblcompname(rs.getString("comp"));
				bean.setLblfinaldate(rs.getString("finaldate"));
				bean.setTxtcontractr(rs.getString("excontr"));
				

			}


			String sql2="select  groupname area,g.doc_no areaid,site,upper(concat(site,',',groupname)) as sited from  cm_surveysid  d left join my_groupvals g on(d.areaid=g.doc_no and grptype='area') "
					+ " where rdocno="+trno+"";


//			System.out.println("==surveydetails==Site===="+sql2);	


			ResultSet rs1 = stmt.executeQuery(sql2);

			String site="";
			String temp="";
			while(rs1.next()){

				site=rs1.getString("sited")+"::"+site;
				temp=site.trim();

			}

			sitelist.add(temp);
			bean.setSitelist(sitelist);



			String sql4="select groupname service,s.doc_no serid from  cm_surveysd d left join my_groupvals s "
					+ "on(s.doc_no=d.servid) where grptype='service' and d.rdocno="+trno+"";



			ResultSet rs4 = stmt.executeQuery(sql4);

			String service="";
			temp="";
			while(rs4.next()){

				service=rs4.getString("service")+"::"+service;
				temp=service.trim();

			}

			serlist.add(temp);
			bean.setSerlist(serlist);



			String	sql5="select * from (select m.doc_no servtypeid,name servtype,d.description as sepc,d.rowno specid,d.rowno rdocno,coalesce(sd.description,'') desc1, "
					+ "coalesce(details,'') details from cm_proptypem m left join cm_proptyped d on(m.doc_no=d.doc_no) "
					+ "left join cm_surveyd sd on(sd.propid=d.rowno and sd.proptype=m.doc_no) left join cm_sursertype st on(st.sertypeid=sd.proptype and st.doc_no=sd.propid)"
					+ " where sd.rdocno="+trno+" and st.sertypeid in ("+sertypeids+") union all "
					+ "select m.doc_no servtypeid,name servtype,d.description sepc,d.rowno specid,0 rdocno,'' desc1,'' details from "
					+ "cm_proptypem m left join cm_proptyped d on(m.doc_no=d.doc_no) "
					+ "where d.doc_no  in ("+sertypeids+") and d.rowno not in (select propid from cm_surveyd where rdocno="+trno+")) as a order by servtypeid";

			System.out.println("==sql5survey details======="+sql5);


			ResultSet rs5 = stmt.executeQuery(sql5);

			int sercount=1;
			String oldser="";
			String newser="";
			String serdata="";
			String serdet="";
			temp="";
			while(rs5.next()){


				newser=rs5.getString("servtype");
				if(oldser.equalsIgnoreCase(newser)){
					serdata="";
					sercount++;
				}
				else{
					sercount=1;
					serdata=rs5.getString("servtype");
				}
				serdet=rs5.getString("sepc")+"::"+rs5.getString("details")+" "+"::"+rs5.getString("desc1")+" ";
				temp=serdata+"::"+serdet;	

				list.add(temp);
				oldser=newser;
			}
			
			/*while(rs5.next()){
				temp="";
				temp=rs5.getString("servtype")+"::"+rs5.getString("sepc")+"::"+rs5.getString("details");
				list.add(temp);
			}*/
			
			
			bean.setList(list);


			for(int k=0;k<list.size();k++){

//				System.out.println("==list==="+list.get(k));

			}


			String sql3="select m.voc_no,m.dtype,termsheader terms,conditions conditions from my_trterms tr left join my_termsm m on(tr.termsid=m.voc_no) where "
					+ " tr.dtype='"+dtype+"' and tr.rdocno="+docno+" order by terms";

			//					System.out.println("==sql2===="+sql2);

			ResultSet rs3 = stmt.executeQuery(sql3);

			int trcount=1;
			String oldtrms="";
			String newtrms="";
			String testing="";
			String cond="";
			temp="";
			while(rs3.next()){
				newtrms=rs3.getString("terms");
				if(oldtrms.equalsIgnoreCase(newtrms)){
					testing="";
					trcount++;
				}
				else{
					trcount=1;
					testing=rs3.getString("terms");
				}
				cond=trcount+")"+rs3.getString("conditions");
				temp=testing+"::"+cond;	

				trlist.add(temp);
				oldtrms=newtrms;
			}
			bean.setTermlist(trlist);





			conn.close();

		}
		catch(Exception e){

			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return bean;

	}


public JSONArray siteRefGridLoad(HttpSession session,String doc_no) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			String brhid=session.getAttribute("BRANCHID").toString();

			sql="select  groupname area,g.doc_no areaid,site from  gl_enqsited  d left join my_groupvals g on(d.areaid=g.doc_no and grptype='area') "
					+ "left join gl_enqm em on(em.doc_no=d.rdocno) where em.doc_no="+doc_no+"";
					
			//System.out.println("===sql==siteGridLoad=="+sql);

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



}
