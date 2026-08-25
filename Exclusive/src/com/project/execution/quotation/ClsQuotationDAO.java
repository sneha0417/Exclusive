package com.project.execution.quotation;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.common.ClsNumberToWord;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ClsQuotationDAO {

	ClsCommon com=new ClsCommon();
	ClsConnection conobj=new ClsConnection();
	ClsQuotationBean bean = new ClsQuotationBean();

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
				String clsql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1,sal_name as salname,sm.doc_no as salid"
						+ " from my_acbook ac left join my_salm sm on(ac.sal_id=sm.doc_no) where  dtype='CRM' " +sqltest);

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
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}


	public JSONArray unitSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select doc_no,unit,unit_desc from my_unitm where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=com.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray contactpersonSearch(HttpSession session,int clientid) throws SQLException
	{

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

		Connection conn =null;
		Statement stmt =null;
		try {
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();
			String sql= ("select cperson,concat('MOB',':',mob,';','Email',':',email,';','Tele',':',tel) contactdet,row_no as cprowno from my_crmcontact c left join my_acbook a on(a.doc_no=c.cldocno)  where a.status=3 and a.dtype='CRM' and c.dtype='CRM' and c.cldocno="+clientid+" and a.doc_no="+clientid+"" );
			//			System.out.println("------------------"+sql);
			ResultSet resultSet = stmt.executeQuery(sql) ;
			RESULTDATA=com.convertToJSON(resultSet);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}

		return RESULTDATA;

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


	public JSONArray assignfrm(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select grpcode,doc_no  from cm_serteamm where status=3";


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


	public JSONArray assignteam(HttpSession session,int assignid) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select s.doc_no,s.rdocno,name,grpcode,s.empid from cm_serteamd s left join hr_empm e on(s.empid=e.doc_no) "
					+ "left join cm_serteamm m on(m.doc_no=s.rdocno) where m.status=3 and m.doc_no="+assignid+"";


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


	public JSONArray serviceType(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select groupname stype,codeno,doc_no docno from my_groupvals where grptype='service' and status=3";



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

	public JSONArray serviceSite(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select groupname site,codeno,doc_no docno from my_groupvals where grptype='site' and status=3";



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

	public JSONArray siteGridLoad(HttpSession session,String doc_no) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			String brhid=session.getAttribute("BRANCHID").toString();

			sql="select  groupname area,g.doc_no areaid,site,refrowno rowno  from  cm_servsited  d left join my_groupvals g on(d.areaid=g.doc_no and grptype='area') "
					+ " where tr_no="+doc_no+"";

			//			System.out.println("===sql==siteGridLoad=="+sql);

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


	public JSONArray siteRefGridLoad(HttpSession session,String doc_no) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			String brhid=session.getAttribute("BRANCHID").toString();

			sql="select  groupname area,g.doc_no areaid,site from  cm_surveysid  d left join my_groupvals g on(d.areaid=g.doc_no and grptype='area') "
					+ "left join cm_surveym m on(m.doc_no=d.rdocno) left join gl_enqm em on(em.doc_no=m.refdocno)"
					+ " where em.doc_no="+doc_no+"";

			//			System.out.println("===sql==siteGridLoad=="+sql);

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


	public JSONArray serviceGridLoad(HttpSession session,String doc_no,String reviseno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			String brhid=session.getAttribute("BRANCHID").toString();

			sql="select site,s.sr_no siteid,groupname stype,g.doc_no stypeid, d.description desc1, Equips item, qty, d.Amount, total,u.unit as unit,unitid,d.revision_no from "
					+ "cm_srvqotd d left join my_groupvals g on(d.servid=g.doc_no and grptype='service') left join cm_servsited s on(s.rowno=d.sitesrno) "
					+ "left join my_unitm u on(u.doc_no=d.unitid) where d.tr_no="+doc_no+" and d.revision_no="+reviseno+"";

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



	public   JSONArray termsSearch(HttpSession session,String dtype) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement (); 


			String sql="select doc_no,voc_no,dtype,termsheader as header from my_termsm where dtype='"+dtype+"'";
			// System.out.println("-----fleetsql---"+fleetsql);

			ResultSet resultSet = stmt.executeQuery (sql);
			RESULTDATA=com.convertToJSON(resultSet);
			stmt.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public   JSONArray condtnSearch(HttpSession session,String dtype,String tdocno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement (); 


			String sql="select doc_no, rdocno, termsfooter from my_termsd where  dtype='"+dtype+"' and rdocno="+tdocno+"";

			//			 System.out.println("-----condtnSearch---"+sql);

			ResultSet resultSet = stmt.executeQuery (sql);
			RESULTDATA=com.convertToJSON(resultSet);
			stmt.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}



	public JSONArray termsGridLoad(HttpSession session,String dtype) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select m.doc_no,m.voc_no,m.dtype,termsheader terms,termsfooter conditions from MY_termsm m  inner join my_termsd d on(m.voc_no=d.rdocno) where d.status=3 and m.mand=1 and d.dtype='"+dtype+"' order by m.doc_no";
			//			System.out.println("===termsGridLoad====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=com.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray termsGridReLoad(HttpSession session,String dtype,String qotdoc) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select m.voc_no,m.dtype,termsheader terms,conditions conditions from my_trterms tr left join my_termsm m on(tr.termsid=m.voc_no) where  tr.dtype='"+dtype+"' and tr.rdocno="+qotdoc+" order by terms";
			//			System.out.println("===termsGridLoad====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=com.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray enquirySrearch(HttpSession session,String msdocno,String Cl_names,String Cl_mobno,String enqdate,String clientid,int id,String cntype) throws SQLException {

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
		if(!(cntype.equalsIgnoreCase("undefined"))&&!(cntype.equalsIgnoreCase(""))&&!(cntype.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and m.contrmode='"+cntype+"'";
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
						+ "on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_crmcontact c on(c.row_no=m.cpersonid) where 1=1 and m.status=3 and qottrno=0 "+sqltest+"");

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


	public int insert(java.sql.Date date,String txtrefno,int clientid,int cpersonid,String reftype,int enquiryid,String chkRdo,String dcdamount,String txtsubject,String txtdesc1,
			String clientref,String txtgrtotal,String txtdisper,String txtdisamt,String txttotalamt,String txttaxper,String txttaxamt,String txtnettotal,String formcode,
			String mode,ArrayList servlist,ArrayList sitelist,ArrayList termslist,HttpSession session,HttpServletRequest request,int salid,int cmbprocess,int txtrevise) throws SQLException{


		Connection conn=null;
		int docno=0;
		conn=conobj.getMyConnection();

		try{

			conn.setAutoCommit(false);

			CallableStatement stmt = conn.prepareCall("{CALL sr_QotDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmt.registerOutParameter(25, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(26, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			stmt.setString(2,txtrefno);
			stmt.setInt(3, clientid);
			stmt.setInt(4, cpersonid);
			stmt.setString(5,reftype);
			stmt.setInt(6, enquiryid);
			stmt.setString(7,chkRdo);
			stmt.setDouble(8,Double.parseDouble(dcdamount));
			stmt.setString(9,txtsubject);
			stmt.setString(10,txtdesc1);
			stmt.setString(11,clientref);
			stmt.setDouble(12,Double.parseDouble(txtgrtotal));
			stmt.setDouble(13,Double.parseDouble(txtdisper));
			stmt.setDouble(14,Double.parseDouble(txtdisamt));
			stmt.setDouble(15,Double.parseDouble(txttotalamt));
			stmt.setDouble(16,Double.parseDouble(txttaxper));
			stmt.setDouble(17,Double.parseDouble(txttaxamt));
			stmt.setDouble(18,Double.parseDouble(txtnettotal));
			stmt.setString(19,mode);
			stmt.setString(20,formcode);
			stmt.setString(21, session.getAttribute("USERID").toString());
			stmt.setString(22, session.getAttribute("BRANCHID").toString());
			stmt.setString(23, session.getAttribute("COMPANYID").toString());
			stmt.setInt(24, salid);
			stmt.setInt(27, cmbprocess);
			stmt.registerOutParameter(28, java.sql.Types.VARCHAR);
			int val = stmt.executeUpdate();
			docno=stmt.getInt("docno");
			int vocno=stmt.getInt("vocno");
			request.setAttribute("vocno", vocno);
			txtrevise=stmt.getInt("revision");
			request.setAttribute("revision", txtrevise);
			
			if(docno>0){

				for(int i=0;i< sitelist.size();i++){


					String[] surveydet=((String) sitelist.get(i)).split("::");
					if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
					{

						String sql1 = "";
						int refrowno=0;

						sql1="select coalesce(max(rowno)+1,1) as refrowno from   cm_servsited ";

						//						System.out.println("==sql1=cm_srvcsited==="+sql1);

						ResultSet resultSet1 = stmt.executeQuery(sql1);
						while(resultSet1.next()){
							refrowno=resultSet1.getInt("refrowno");
						}



						String sql="INSERT INTO cm_servsited(sr_no,refrowno, site, areaId, amount,dtype,tr_no)VALUES"
								+ " ("+(i+1)+","
								+ ""+refrowno+","
								+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
								+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
								+ "'"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim())+"',"
								+ " '"+formcode+"',"
								+"'"+docno+"')";

						//						System.out.println("==sitelist==="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}
						//conn.commit();

					}

				}


				String sql1 = "";
				int siteid=0;

				for(int i=0;i< servlist.size();i++){

					String[] surveydet=((String) servlist.get(i)).split("::");

					if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
					{		

						siteid=(Integer) (surveydet[6].trim().equalsIgnoreCase("undefined") || surveydet[6].trim().equalsIgnoreCase("NaN")|| surveydet[6].trim().equalsIgnoreCase("")|| surveydet[6].isEmpty()?"":Integer.parseInt(surveydet[6].trim()));

						sql1="select rowno from   cm_servsited where tr_no="+docno+" and sr_no="+siteid+"";

						//						System.out.println("==sql1=cm_srvcsited==="+sql1);

						ResultSet resultSet1 = stmt.executeQuery(sql1);
						while(resultSet1.next()){
							siteid=resultSet1.getInt("rowno");
						}

						String sql="INSERT INTO cm_srvqotd(sr_no,servId,Equips, qty, Amount,total,description,unitid,sitesrno, tr_no)VALUES"
								+ " ("+(i+1)+","
								+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
								+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
								+ "'"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim())+"',"
								+ "'"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:surveydet[3].trim())+"',"
								+ "'"+(surveydet[4].trim().equalsIgnoreCase("undefined") || surveydet[4].trim().equalsIgnoreCase("NaN")|| surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()?0:surveydet[4].trim())+"',"
								+ "'"+(surveydet[5].trim().equalsIgnoreCase("undefined") || surveydet[5].trim().equalsIgnoreCase("NaN")|| surveydet[5].trim().equalsIgnoreCase("")|| surveydet[5].isEmpty()?"":surveydet[5].trim())+"',"
								+ "'"+(surveydet[7].trim().equalsIgnoreCase("undefined") || surveydet[7].trim().equalsIgnoreCase("NaN")|| surveydet[7].trim().equalsIgnoreCase("")|| surveydet[7].isEmpty()?"":surveydet[7].trim())+"',"
								+ " "+siteid+","
								+"'"+docno+"')";


						//						System.out.println("====sql====="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}	

					}

				}




				for(int i=0;i< termslist.size();i++){


					String[] terms=((String) termslist.get(i)).split("::");

					if(!((terms[0].equalsIgnoreCase("0"))||(terms[0].equalsIgnoreCase("undefined")))){




						String termsql="insert into my_trterms(rdocno, termsid, conditions, status, dtype)VALUES"
								+ " ('"+docno+"',"
								+ "'"+(terms[0].equalsIgnoreCase("undefined") || terms[0].equalsIgnoreCase("") || terms[0].trim().equalsIgnoreCase("NaN")|| terms[0].isEmpty()?0:terms[0].trim())+"',"
								+ "'"+(terms[3].equalsIgnoreCase("undefined") || terms[3].equalsIgnoreCase("") || terms[3].trim().equalsIgnoreCase("NaN")|| terms[3].isEmpty()?0:terms[3].trim())+"',"
								+ "'3',"
								+ "'"+formcode+"')";


						//						System.out.println("termsdet--->>>>Sql"+termsql);
						int resultSet3 = stmt.executeUpdate (termsql);

						if(resultSet3<=0)
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



		return docno;


	}


	public int edit(int docno,int vocno,java.sql.Date date,String txtrefno,int clientid,int cpersonid,String reftype,int enquiryid,String chkRdo,String dcdamount,String txtsubject,String txtdesc1,
			String clientref,String txtgrtotal,String txtdisper,String txtdisamt,String txttotalamt,String txttaxper,String txttaxamt,String txtnettotal,String formcode,
			String mode,ArrayList servlist,ArrayList sitelist,ArrayList termslist,HttpSession session,HttpServletRequest request,int salid,int cmbprocess,int txtrevise) throws SQLException{


		Connection conn=null;

		conn=conobj.getMyConnection();
		
		try{
System.out.println("txtrevise=="+txtrevise);
			conn.setAutoCommit(false);

			CallableStatement stmt = conn.prepareCall("{CALL sr_QotDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");


			stmt.setDate(1,date);
			stmt.setString(2,txtrefno);
			stmt.setInt(3, clientid);
			stmt.setInt(4, cpersonid);
			stmt.setString(5,reftype);
			stmt.setInt(6, enquiryid);
			stmt.setString(7,chkRdo);
			stmt.setDouble(8,Double.parseDouble(dcdamount));
			stmt.setString(9,txtsubject);
			stmt.setString(10,txtdesc1);
			stmt.setString(11,clientref);
			stmt.setDouble(12,Double.parseDouble(txtgrtotal));
			stmt.setDouble(13,Double.parseDouble(txtdisper));
			stmt.setDouble(14,Double.parseDouble(txtdisamt));
			stmt.setDouble(15,Double.parseDouble(txttotalamt));
			stmt.setDouble(16,Double.parseDouble(txttaxper));
			stmt.setDouble(17,Double.parseDouble(txttaxamt));
			stmt.setDouble(18,Double.parseDouble(txtnettotal));
			stmt.setString(19,mode);
			stmt.setString(20,formcode);
			stmt.setString(21, session.getAttribute("USERID").toString());
			stmt.setString(22, session.getAttribute("BRANCHID").toString());
			stmt.setString(23, session.getAttribute("COMPANYID").toString());
			stmt.setInt(24, salid);
			stmt.setInt(25, docno);
			stmt.setInt(26, vocno);
			stmt.setInt(27, cmbprocess);
			stmt.setInt(28, txtrevise);
			int val = stmt.executeUpdate();
			docno=stmt.getInt("docno");
			vocno=stmt.getInt("vocno");
			request.setAttribute("vocno", vocno);
			txtrevise=stmt.getInt("revision");
			request.setAttribute("revision", txtrevise);
			if(docno>0){
			//	System.out.println("====docno=="+docno);
			for(int i=0;i< sitelist.size();i++){

					System.out.println("====iii=="+i);
					String[] surveydet=((String) sitelist.get(i)).split("::");
				
					if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
					{
						int refrowno=0;

						refrowno=(Integer) (surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:Integer.parseInt(surveydet[3].trim()));

						String sql="INSERT INTO cm_servsited(sr_no,refrowno, site, areaId, amount,dtype,tr_no)VALUES"
								+ " ("+(i+1)+","
								+ ""+refrowno+","
								+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
								+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
								+ "'"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim())+"',"
								+ " '"+formcode+"',"
								+"'"+docno+"')";

						//						System.out.println("==sitelist==="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}
						//conn.commit();

					}

				}


				String sql1 = "";
				int siteid=0;

				for(int i=0;i< servlist.size();i++){

					String[] surveydet=((String) servlist.get(i)).split("::");

					if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
					{		

						siteid=(Integer) (surveydet[6].trim().equalsIgnoreCase("undefined") || surveydet[6].trim().equalsIgnoreCase("NaN")|| surveydet[6].trim().equalsIgnoreCase("")|| surveydet[6].isEmpty()?0:Integer.parseInt(surveydet[6].trim()));

						sql1="select rowno from cm_servsited where tr_no="+docno+" and sr_no="+siteid+"";

						//						System.out.println("==sql1=cm_srvcsited==="+sql1);

						ResultSet resultSet1 = stmt.executeQuery(sql1);
						while(resultSet1.next()){
							siteid=resultSet1.getInt("rowno");
						}

						String sql="INSERT INTO cm_srvqotd(sr_no,servId,Equips, qty, Amount,total,description,unitid,revision_no,sitesrno, tr_no)VALUES"
								+ " ("+(i+1)+","
								+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
								+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
								+ "'"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim())+"',"
								+ "'"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:surveydet[3].trim())+"',"
								+ "'"+(surveydet[4].trim().equalsIgnoreCase("undefined") || surveydet[4].trim().equalsIgnoreCase("NaN")|| surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()?0:surveydet[4].trim())+"',"
								+ "'"+(surveydet[5].trim().equalsIgnoreCase("undefined") || surveydet[5].trim().equalsIgnoreCase("NaN")|| surveydet[5].trim().equalsIgnoreCase("")|| surveydet[5].isEmpty()?"":surveydet[5].trim())+"',"
								+ "'"+(surveydet[7].trim().equalsIgnoreCase("undefined") || surveydet[7].trim().equalsIgnoreCase("NaN")|| surveydet[7].trim().equalsIgnoreCase("")|| surveydet[7].isEmpty()?"":surveydet[7].trim())+"',"
							+ "'"+txtrevise+"',"
								+ " "+siteid+","
								+"'"+docno+"')";



						//						System.out.println("====sql====="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}	

					}

				}




				for(int i=0;i< termslist.size();i++){


					String[] terms=((String) termslist.get(i)).split("::");

					if(!((terms[0].equalsIgnoreCase("0"))||(terms[0].equalsIgnoreCase("undefined")))){




						String termsql="insert into my_trterms(rdocno, termsid, conditions, status, dtype)VALUES"
								+ " ('"+docno+"',"
								+ "'"+(terms[0].equalsIgnoreCase("undefined") || terms[0].equalsIgnoreCase("") || terms[0].trim().equalsIgnoreCase("NaN")|| terms[0].isEmpty()?0:terms[0].trim())+"',"
								+ "'"+(terms[3].equalsIgnoreCase("undefined") || terms[3].equalsIgnoreCase("") || terms[3].trim().equalsIgnoreCase("NaN")|| terms[3].isEmpty()?0:terms[3].trim())+"',"
								+ "'3',"
								+ "'"+formcode+"')";


						//						System.out.println("termsdet--->>>>Sql"+termsql);
						int resultSet3 = stmt.executeUpdate (termsql);

						if(resultSet3<=0)
						{
							conn.close();
							return 0;
						}
					}
				}
				/*String sqlrevise="select revision_no from cm_srvqotm where tr_no="+docno+" and doc_no="+vocno+"";

										System.out.println("==sqlrevise==="+sqlrevise);

				ResultSet rsrevise = stmt.executeQuery(sqlrevise);
				while(rsrevise.next()){
					reviseno=rsrevise.getInt("revision_no");
					request.setAttribute("revno", reviseno);
				}	*/
				

			}

			conn.commit();

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}



		return docno;


	}


	public int delete(int docno,int vocno,java.sql.Date date,String txtrefno,int clientid,int cpersonid,String reftype,int enquiryid,String chkRdo,String dcdamount,String txtsubject,String txtdesc1,
			String clientref,String txtgrtotal,String txtdisper,String txtdisamt,String txttotalamt,String txttaxper,String txttaxamt,String txtnettotal,String formcode,
			String mode,ArrayList servlist,ArrayList sitelist,ArrayList termslist,HttpSession session,HttpServletRequest request,int salid) throws SQLException{


		Connection conn=null;

		conn=conobj.getMyConnection();

		try{

			conn.setAutoCommit(false);

			CallableStatement stmt = conn.prepareCall("{CALL sr_QotDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");


			stmt.setDate(1,date);
			stmt.setString(2,txtrefno);
			stmt.setInt(3, clientid);
			stmt.setInt(4, cpersonid);
			stmt.setString(5,reftype);
			stmt.setInt(6, enquiryid);
			stmt.setString(7,chkRdo);
			stmt.setDouble(8,Double.parseDouble(dcdamount));
			stmt.setString(9,txtsubject);
			stmt.setString(10,txtdesc1);
			stmt.setString(11,clientref);
			stmt.setDouble(12,Double.parseDouble(txtgrtotal));
			stmt.setDouble(13,Double.parseDouble(txtdisper));
			stmt.setDouble(14,Double.parseDouble(txtdisamt));
			stmt.setDouble(15,Double.parseDouble(txttotalamt));
			stmt.setDouble(16,Double.parseDouble(txttaxper));
			stmt.setDouble(17,Double.parseDouble(txttaxamt));
			stmt.setDouble(18,Double.parseDouble(txtnettotal));
			stmt.setString(19,mode);
			stmt.setString(20,formcode);
			stmt.setString(21, session.getAttribute("USERID").toString());
			stmt.setString(22, session.getAttribute("BRANCHID").toString());
			stmt.setString(23, session.getAttribute("COMPANYID").toString());
			stmt.setInt(24, salid);
			stmt.setInt(25, docno);
			stmt.setInt(26, vocno);

			int val = stmt.executeUpdate();
			docno=stmt.getInt("docno");
			vocno=stmt.getInt("vocno");
			request.setAttribute("vocno", vocno);

			if(docno>0){

				conn.commit();

			}



		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}



		return docno;


	}




	public JSONArray searchMaster(HttpSession session,String msdocno,String Cl_names,String sereftype,String surdate,String cntrtype,int id) throws SQLException {


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
		if(!(msdocno.equalsIgnoreCase("undefined"))&&!(msdocno.equalsIgnoreCase(""))&&!(msdocno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and m.doc_no like '%"+msdocno+"%'";
		}
		if(!(Cl_names.equalsIgnoreCase("undefined"))&&!(Cl_names.equalsIgnoreCase(""))&&!(Cl_names.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and ac.refname like '%"+Cl_names+"%'";
		}
		if(!(sereftype.equalsIgnoreCase("undefined"))&&!(sereftype.equalsIgnoreCase(""))&&!(sereftype.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and m.ref_type like '%"+sereftype+"%'";
		}
		if(!(cntrtype.equalsIgnoreCase("undefined"))&&!(cntrtype.equalsIgnoreCase(""))&&!(cntrtype.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and m.cntr_type like '%"+cntrtype+"%'";
		}


		Connection conn = null;

		try {
			if(id>0){

				conn = conobj.getMyConnection();
				Statement stmtenq1 = conn.createStatement ();

				String str1Sql=("select m.TR_NO tr_no, m.DOC_NO doc_no, m.DATE date,round(coalesce(netAmount,0.0),2) as netAmount, m.refNo,m.dtype,m.ref_type reftype,refname,trim(address) address,per_mob,trim(mail1) mail1,"
						+ " subject, refDocNo, clrefNo,round(coalesce(taxPer,0.0),2) taxPer,round(coalesce(tax,0.0),2) as tax,round(coalesce(amount,0.0),2) as amount,round(coalesce(discount,0.0),2) discount, round(coalesce(disPer,0.0),2) disper, costType,round(coalesce(total,0.0),2) as total, cpersonid,m.cntr_type,ac.refname as name,"
						+ "ac.doc_no as clientid,cn.cperson,concat('MOB',':',cn.mob,';','Email',':',cn.email,';','Tele',':',cn.tel) contactdet,cn.row_no as cprowno,cpersonid, "
						+ "trim(address) address,coalesce(per_mob,'') per_mob,trim(mail1) mail1,m.remarks remarks,round(coalesce(legalchrg,0.0),2) legalchrg,cntr_type,sm.sal_name as salname,sm.doc_no as salid,m.sjobtype,m.revision_no,rv.maxrev from  cm_srvqotm m left join my_acbook ac "
						+ "on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_crmcontact cn on(cn.cldocno=m.cpersonid and cn.row_no=m.cpersonid) left join my_salm sm on(sm.doc_no=m.sal_id)"
						+ "left join (select max(revision_no) maxrev,doc_no from cm_srvqotm group by doc_no) rv on rv.doc_no=m.doc_no"
						+ " where m.status!=7 and m.brhid="+brid+"  "+sqltest+" ");


				System.out.println("===str1Sql===="+str1Sql);

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


	public ClsQuotationBean printMaster(HttpSession session,String msdocno,String brhid,String trno,String dtype) throws SQLException {


		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}


		String brid=session.getAttribute("BRANCHID").toString();
		java.sql.Date sqlStartDate=null;
		String sqltest="",contrtype="";
		Connection conn = null;
		ArrayList list=null;
		ArrayList amclist=null;
		ArrayList trlist=null;
		try {
			list= new ArrayList();
			trlist= new ArrayList();
			amclist= new ArrayList();
			ClsNumberToWord obj=new ClsNumberToWord();
			ClsAmountToWords obj1=new ClsAmountToWords();
			double lfee=0.0;

			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement ();

			String Sql=("select if(m.status!=3,'Draft',' ') printname,m.TR_NO tr_no,concat( cntr_type,'/','QTN','/',m.DOC_NO) doc_no,DATE_FORMAT(m.date,'%d/%m/%Y') date,round(coalesce(netAmount,0.0),2) as netAmount, m.refNo,m.dtype,m.ref_type reftype,refname,trim(ac.address) address,concat(per_mob,'/',per_tel) as per_mob,trim(mail1) mail1,"
					+ " subject, refDocNo, clrefNo,round(coalesce(taxPer,0.0),2) taxPer,round(coalesce(tax,0.0),2) as tax,(round(coalesce(legalchrg,0.0),2)+round(coalesce(amount,0.0),2)) as amount,round(coalesce(discount,0.0),2) discount, round(coalesce(disPer,0.0),2) disper, costType, "
					+ "(round(coalesce(legalchrg,0.0),2)+round(coalesce(total,0.0),2)+round(coalesce(tax,0.0),2)) as total, cpersonid,m.cntr_type,ac.refname as name,"
					+ "ac.doc_no as clientid,cn.cperson,concat('MOB',':',cn.mob,';','Email',':',cn.email,';','Tele',':',cn.tel) contactdet,cn.row_no as cprowno,cpersonid, "
					+ "trim(ac.address) address,coalesce(per_mob,'') per_mob,trim(mail1) mail1,m.remarks remarks,coalesce(round(legalchrg,2),0.0) legalchrg,cntr_type,cur.code as code,b.branchname brch,b.address as baddress,b.tel,b.fax,com.company comp,cur.code,loc.loc_name,DATE_FORMAT(CURDATE(),'%d/%m/%Y') as finaldate,sm.sal_name as salnme,sm.mob_no as salmob  ,per_mob mobile,per_tel telno,round(coalesce(amount,0.0),2) fire7tot "
					+ "from  cm_srvqotm m left join my_acbook ac on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_curr cur on(cur.doc_no=ac.curid) left join my_crmcontact cn on(cn.cldocno=m.cldocno and cn.row_no=m.cpersonid)"
					+ "left join my_brch b on(b.doc_no=m.brhid) left join my_locm loc on(b.doc_no=loc.brhid) left join my_salm sm on(sm.doc_no=m.sal_id) left join my_comp com on(com.doc_no=b.cmpid) where m.status!=7 and m.doc_no="+msdocno+" and m.tr_no="+trno+" and m.brhid="+brid+"");


			System.out.println("===Sql===="+Sql);

			ResultSet rs = stmt.executeQuery(Sql);
			while(rs.next()){
				bean.setPrintname(rs.getString("printname"));
				bean.setMasterdoc_no(rs.getInt("tr_no"));
				bean.setDocno(rs.getString("doc_no"));
				bean.setDate(rs.getString("date"));
				bean.setTxtclient(rs.getString("refname"));
				bean.setTxtclientdet(rs.getString("address"));
				bean.setTxtmob(rs.getString("per_mob"));
				bean.setTxtemail(rs.getString("mail1"));
				bean.setTxttel(rs.getString("per_mob"));
				bean.setTxtcontact(rs.getString("cn.cperson"));
				bean.setTxtcontactdetails(rs.getString("contactdet"));
				bean.setTxtdcdamount(rs.getString("legalchrg"));
				bean.setTxtdesc1(rs.getString("remarks"));
				bean.setTxtsubject(rs.getString("subject"));
				bean.setTxtclientref(rs.getString("clrefNo"));
				bean.setTxtgrtotal(rs.getString("amount"));
				bean.setTxtdisper(rs.getString("disper"));
				bean.setTxtdisamt(rs.getString("discount"));
				bean.setTxttotalamt(rs.getString("amount"));
				bean.setTxttaxper(rs.getString("taxPer"));
				bean.setTxttaxamt(rs.getString("tax"));
				bean.setTxtnettotal(rs.getString("total"));
				bean.setContrtype(rs.getString("cntr_type"));
				bean.setLblbranch(rs.getString("brch"));
				bean.setLblcompaddress(rs.getString("baddress"));
				bean.setLblcompfax(rs.getString("fax"));
				bean.setLblcomptel(rs.getString("tel"));
				bean.setLbllocation(rs.getString("loc_name"));
				bean.setLblcompname(rs.getString("comp"));
				bean.setLblfinaldate(rs.getString("finaldate"));
				bean.setTxtsalman(rs.getString("salnme"));
				bean.setTxtrefno(rs.getString("refno"));
				bean.setTxtsalmob(rs.getString("salmob"));
					/// fire 7telno,mobno
				bean.setFire7total(rs.getString("fire7tot"));
				bean.setF7mobno(rs.getString("mobile"));
				bean.setF7telno(rs.getString("telno"));


				bean.setAmountwords(rs.getString("code")+" "+obj1.convertAmountToWords(rs.getString("total")));

				lfee=Double.parseDouble(rs.getString("legalchrg"));
				contrtype=rs.getString("cntr_type");
			}
			
			///fire 7 tot amoun in word
			bean.setFire7amountword(obj1.convertAmountToWords(bean.getFire7total()));
			System.out.println("setTxttotalamt="+bean.getFire7total()+"=="+bean.getFire7amountword());
			
				/// fire 7 site details
			String sitedetsql="select  group_concat(site) site  from  cm_servsited  d left join my_groupvals g on(d.areaid=g.doc_no and grptype='area')where tr_no="+trno+";";
			ResultSet siters=stmt.executeQuery(sitedetsql);
			while(siters.next()){
				bean.setFire7sitedetail(siters.getString("site"));
			}
			
			//end fire 7 site detail


			String sql="select @id:=@id+1 as srno,a.* from(select site,s.sr_no siteid,groupname stype,g.doc_no stypeid,coalesce(d.description,'') desc1, Equips item, round(qty,0) qty, round(d.Amount,2) as amount,round(d.total,2) total,u.unit as unit,unitid from "
					+ "cm_srvqotd d left join my_groupvals g on(d.servid=g.doc_no and grptype='service') left join cm_servsited s on(s.rowno=d.sitesrno) left join my_unitm u on(u.doc_no=d.unitid) "
					+ "where d.tr_no="+trno+") a,(select @id:=0) r";

			bean.setSitequery(sql);
			ResultSet rs2 = stmt.executeQuery(sql);
			int rowcount=1;
			String oldsite="";
			String newsite="";
			String site="";
			String temp="";
			while(rs2.next()){

				if(Double.parseDouble(rs2.getString("total"))>0){

					temp="";
					newsite=rs2.getString("site");
					if(oldsite.equalsIgnoreCase(newsite)){
						rowcount++;
						site="";

					}
					else{
						rowcount=1;
						site=rs2.getString("site");
					}

					temp=site+"::"+rowcount+"::"+rs2.getString("stype")+"::"+rs2.getString("desc1")+"::"+rs2.getString("unit")+"::"+rs2.getString("qty")+"::"+rs2.getString("Amount")+"::"+rs2.getString("total");

					list.add(temp);

					oldsite=newsite;

				}

			}
			if(contrtype.equalsIgnoreCase("AMC")){
				if(lfee>0){
					temp=""+"::"+(rowcount+1)+"::"+"CIVIL DEFENCE CONTRACT ATTESTATION"+"::"+"CIVIL DEFENCE CONTRACT ATTESTATION"+"::"+""+"::"+""+"::"+lfee+"::"+lfee;
					list.add(temp);
				}
			}


			bean.setList(list);


			String sqllist="select distinct  groupname stype from "
					+ "cm_srvqotd d left join my_groupvals g on(d.servid=g.doc_no and grptype='service')  "
					+ "where d.tr_no="+trno+"";

			ResultSet rslist = stmt.executeQuery(sqllist);
			temp="";
			rowcount=1;
			while(rslist.next()){

				temp=+(rowcount)+"::"+rslist.getString("stype")+"::"+"3 Months"+"::"+ "4 Times";

				amclist.add(temp);
				rowcount++;
			}
			bean.setAmclist(amclist);

			String sql2="select m.voc_no,m.dtype,termsheader terms,conditions conditions from my_trterms tr left join my_termsm m on(tr.termsid=m.voc_no) where "
					+ " tr.dtype='"+dtype+"' and tr.rdocno="+msdocno+" and tr.brhid="+brid+" and tr.status=3 and m.status=3  order by priorno";

			//System.out.println("=====terms==="+sql2);


			ResultSet rs3 = stmt.executeQuery(sql2);

			int trcount=1;
			String point="*";
			String oldtrms="";
			String newtrms="";
			String testing="";
			String cond="";
			while(rs3.next()){

				String temp1="";
				newtrms=rs3.getString("terms");
				if(oldtrms.equalsIgnoreCase(newtrms)){
					testing="";
					trcount++;
				}
				else{
					trcount=1;
					testing=rs3.getString("terms");
				}
				cond=point+" "+rs3.getString("conditions");
				temp1=testing+"::"+cond;	

				trlist.add(temp1);
				oldtrms=newtrms;
			}
			bean.setTermlist(trlist);

			stmt.close();
			conn.close();
		}

		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return bean;
	}



	public  JSONArray convertArrayToJSON(ArrayList<String> arrayList) throws Exception {
		JSONArray jsonArray = new JSONArray();

		for (int i = 0; i < arrayList.size(); i++) {

			JSONObject obj = new JSONObject();

			String[] Array=arrayList.get(i).split("::");

			obj.put("id",Array[0]);
			obj.put("description",Array[1]);
			obj.put("grpamt",Array[2]);
			obj.put("netamt",Array[3]);
			obj.put("childamt",Array[4]);
			obj.put("subchildamt",Array[5]);
			obj.put("parentid",Array[6]);
			obj.put("ordno",Array[7]);
			obj.put("groupno",Array[8]);
			obj.put("subac",Array[9]);
			obj.put("gp_id",Array[10]);

			jsonArray.add(obj);
		}
		return jsonArray;
	}


	public JSONArray serviceRefGridLoad(HttpSession session,String doc_no) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			String brhid=session.getAttribute("BRANCHID").toString();

			sql="select site,s.doc_no siteid,groupname stype,g.doc_no stypeid from cm_surveysd d left join my_groupvals g on(d.servid=g.doc_no and grptype='service') "
					+ "left join cm_surveysid s on(s.rdocno=d.rdocno) left join cm_surveym m on(m.doc_no=d.rdocno) left join gl_enqm em on(em.doc_no=m.refdocno)"
					+ " where em.doc_no="+doc_no+"";

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


	public ClsQuotationBean getViewDetails(HttpSession session,String msdocno,String brhid,String trno) throws SQLException {


		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}


		String brid=session.getAttribute("BRANCHID").toString();

		Connection conn = null;

		try {

			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement ();

			String Sql=("select  m.TR_NO tr_no, m.DOC_NO doc_no, m.DATE date,round(coalesce(netAmount,0.0),2) as netAmount, m.refNo,m.dtype,m.ref_type reftype,refname,"
					+ "trim(address) address,per_mob,trim(mail1) mail1,per_tel, "
					+ " subject, refDocNo, clrefNo,round(coalesce(taxPer,0.0),2) taxPer,round(coalesce(tax,0.0),2) as tax,round(coalesce(amount,0.0),2) as amount,"
					+ "round(coalesce(discount,0.0),2) discount, round(coalesce(disPer,0.0),2) disper, costType,round(coalesce(total,0.0),2) as total, cpersonid,"
					+ "m.cntr_type,ac.refname as name,"
					+ "ac.doc_no as clientid,cn.cperson,concat('MOB',':',cn.mob,';','Email',':',cn.email,';','Tele',':',cn.tel) contactdet,cn.row_no as cprowno,cpersonid, "
					+ "trim(address) address,coalesce(per_mob,'') per_mob,trim(mail1) mail1,m.remarks remarks,round(coalesce(legalchrg,0.0),2) legalchrg,cntr_type,"
					+ "sm.sal_name as salname,sm.doc_no as salid,m.revision_no from  cm_srvqotm m left join my_acbook ac "
					+ "on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_crmcontact cn on(cn.cldocno=m.cldocno and cn.row_no=m.cpersonid) "
					+ "left join my_salm sm on(sm.doc_no=m.sal_id) where m.status!=7 and m.doc_no="+msdocno+"  and m.brhid="+brid+" ");

			System.out.println("===getViewDetails===="+Sql);

			ResultSet rs = stmt.executeQuery(Sql);
			while(rs.next()){
				bean.setMasterdoc_no(rs.getInt("tr_no"));
				bean.setClientid(rs.getInt("clientid"));
				bean.setTxtclient(rs.getString("name"));
				bean.setTxtclientdet(rs.getString("address"));
				bean.setTxtmob(rs.getString("per_mob"));
				bean.setTxtemail(rs.getString("mail1"));
				bean.setTxttel(rs.getString("per_tel"));
				bean.setCpersonid(rs.getInt("cpersonid"));
				bean.setTxtcontact(rs.getString("cperson"));
				bean.setTxtcontactdetails(rs.getString("contactdet"));
				bean.setCmbreftype(rs.getString("reftype"));
				bean.setHidcmbreftype(rs.getString("reftype"));
				bean.setTxtdcdamount(rs.getString("legalchrg"));
				bean.setTxtenquiry(rs.getString("refdocno"));
				bean.setEnquiryid(rs.getInt("refdocno"));
				bean.setHidradio(rs.getString("cntr_type"));
				bean.setTxtdesc1(rs.getString("remarks"));
				bean.setTxtsubject(rs.getString("subject"));
				bean.setTxtclientref(rs.getString("clrefno"));
				bean.setTxtgrtotal(rs.getString("amount"));
				bean.setTxtdisper(rs.getString("disper"));
				bean.setTxtdisamt(rs.getString("discount"));
				bean.setTxttotalamt(rs.getString("total"));
				bean.setTxttaxper(rs.getString("taxper"));
				bean.setTxttaxamt(rs.getString("tax"));
				bean.setTxtnettotal(rs.getString("netamount"));
				bean.setTxtsalman(rs.getString("salname"));
				bean.setSalid(rs.getInt("salid"));
				bean.setHidradio(rs.getString("cntr_type"));
				bean.setTxtrefno(rs.getString("refno"));
				bean.setTxtrevise(rs.getString("revision_no"));
				
			}


		}

		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return bean;
	}



}
