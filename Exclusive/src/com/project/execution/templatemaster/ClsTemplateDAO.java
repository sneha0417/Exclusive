package com.project.execution.templatemaster;

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

public class ClsTemplateDAO {

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
					+ "u.unit unit,ed.unitid as unitdocno,jobtype as activity,mp.tr_no activityid,m.stdprice,ed.marginper,m.productname proname,m.productname product,ed.sitesrno from cm_prjmaster mp "
					+ " left join cm_estmprdd ed on mp.tr_no=ed.tr_no left join cm_mprdd d on(mp.tr_no=d.tr_no) left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no) "
					+ "left join my_prodattrib at on(at.mpsrno=m.doc_no) "
					+ "left join my_unitm u on ed.unitid=u.doc_no  where mp.tr_no in ('"+trno+"')";


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

	public JSONArray materialGridSiteLoad(HttpSession session,String reftrno,int loadid) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();
			ResultSet resultSet1 = null;
			String sql = "";
if(loadid==3)
{
	sql="select site,sr_no sitesrno from gl_enqsited where rdocno='"+reftrno+"'";
	resultSet1 = stmt.executeQuery(sql);
	RESULTDATA1=com.convertToJSON(resultSet1);
}
else if(loadid==4)
{
	sql="select site,sr_no sitesrno from cm_surveysid where rdocno='"+reftrno+"'";
	resultSet1 = stmt.executeQuery(sql);
	RESULTDATA1=com.convertToJSON(resultSet1);
}		


//					System.out.println("===materialGridSiteLoad===="+sql);


					

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
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
	public JSONArray serviceSearch(HttpSession session) throws SQLException{


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

	public JSONArray siteSearch(HttpSession session) throws SQLException{


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


	public JSONArray materialGridExcel(HttpSession session,String trno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "",sqltest="";


			sql="select grp.groupname Service_Type,d.description Description,sc.sname Scope,m.productname Product,bd.brandname Brand,u.unit Unit,d.qty Quantity,d.scope_amount Scope_Amount"
					+ " ,d.amount Amount,d.total Total"
					+ " from cm_templated d left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no)"
					+ " left join my_scope sc on d.scopeid=sc.doc_no"
					+ " left join cm_templatem tm on tm.doc_no=d.rdocno left join  my_brand bd on m.brandid=bd.doc_no left join my_unitm u on d.unitid=u.doc_no left join my_groupvals grp on grp.doc_no=d.sertypeid and grp.grptype='service'"
					+ "  where tm.status=3  and d.rdocno="+trno+"";


			//System.out.println("===materialGridLoad===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToEXCEL(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}




	 public JSONArray sitegridSearch(String reftrno,int loadid,String reftype) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
if(reftype.equalsIgnoreCase("ENQ"))
{
			if(loadid==3)
			{
				sql="select site,sr_no sitesrno from gl_enqsited where rdocno='"+reftrno+"'";
				
			}
			else if(loadid==4)
			{
				sql="select site,sr_no sitesrno from cm_surveysid where rdocno='"+reftrno+"'";
			}	
}
else if(reftype.equalsIgnoreCase("SRVE"))
{
				sql="select site,sr_no sitesrno from cm_srvcsited where tr_no='"+reftrno+"'";
			
}

						System.out.println("===sql===="+sql);

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

	public JSONArray searchProduct(HttpSession session,String prodsearchtype,String rdoc,String reftype,String clientid,String date,
			String prdname,String brandname,String id,String gridunit,String gridprdname,String scopeid,String servicetypeid) throws SQLException {

JSONArray RESULTDATA=new JSONArray();

Connection conn = null;
if(!(id.equalsIgnoreCase("1"))){
	return RESULTDATA;
}

try {
	conn = conobj.getMyConnection();
	Statement stmt = conn.createStatement (); 
	String sql="";
	int method=0;
	java.sql.Date estdate=null;
	String sqltest="";
/*System.out.println(clientid+"=="+date);
	if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
		sqltest=" and x.cldocno in ("+clientid+")";
	}
*/	

	if(!(date.equals("0") || date.equals("") || date.equals("undefined"))){
		estdate=com.changeStringtoSqlDate(date);
		
	}


String condtn="";
	
	//System.out.println("----prdname-sql---"+prdname);
	
	if(!(prdname.equalsIgnoreCase(""))&&!(prdname.equalsIgnoreCase("undefined"))&&!(prdname.equalsIgnoreCase("0"))){
		condtn ="  and m.part_no like '%"+prdname+"%' ";
	}
	
	if(!(brandname.equalsIgnoreCase(""))&&!(brandname.equalsIgnoreCase("undefined"))&&!(brandname.equalsIgnoreCase("0"))){
		condtn +="  and brd.brandname like '%"+brandname+"%' ";
	}
	
	if(!(gridprdname.equalsIgnoreCase(""))&&!(gridprdname.equalsIgnoreCase("undefined"))&&!(gridprdname.equalsIgnoreCase("0"))){
		condtn +="  and m.productname like '%"+gridprdname+"%' ";
	}
	
	if(!(gridunit.equalsIgnoreCase(""))&&!(gridunit.equalsIgnoreCase("undefined"))&&!(gridunit.equalsIgnoreCase("0"))){
		condtn +="  and u.unit like '%"+gridunit+"%' ";
	}
	
	
		   String brcid=session.getAttribute("BRANCHID").toString();
	
		   String strSql1 = "select method from gl_config where field_nme='srvcProductBranchAvailability'";
		   ResultSet rs1 = stmt.executeQuery(strSql1);
		
		   String srvcProductBranchAvailability="";
		   while(rs1.next()) {
			   srvcProductBranchAvailability=rs1.getString("method");
		   } 
		   
		   if(!(servicetypeid.equalsIgnoreCase(""))&&!(servicetypeid.equalsIgnoreCase("undefined"))&&!(servicetypeid.equalsIgnoreCase("0"))){
			   condtn +="  and c.link in (0,"+servicetypeid+") ";
		   } else {
			   condtn +="  and c.link in (0) ";
		   }
		   
		   if(srvcProductBranchAvailability.equalsIgnoreCase("1")) {
		   
			   sql="select at.mspecno as specid,m.part_no,m.productname prdname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,coalesce(m.fixingprice ,0) amount, "
					   + "coalesce(m.lbrchg,0) lbrchg,brd.brandname,m.brandid,m.stdprice, coalesce(spr.fprice,0) scopefprice , coalesce(spr.stdcost,0) scopestdcost "
					   + "from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) "
					   + "left join my_brand brd on brd.doc_no=m.brandid left join my_scopepr spr on spr.psrno=m.psrno and scpid="+scopeid+" left join my_catm c on c.doc_no=m.catid "
					   + "where m.status=3 "+condtn+" and if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"' group by m.psrno  order by m.psrno";
		   } else {

			   sql="select at.mspecno as specid,m.part_no,m.productname prdname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,coalesce(m.fixingprice ,0) amount, "
					+ "coalesce(m.lbrchg,0) lbrchg,brd.brandname,m.brandid,m.stdprice, coalesce(spr.fprice,0) scopefprice , coalesce(spr.stdcost,0) scopestdcost "
					+ "from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
					+ "left join my_brand brd on brd.doc_no=m.brandid left join my_scopepr spr on spr.psrno=m.psrno and scpid="+scopeid+" left join my_catm c on c.doc_no=m.catid "
					+ "where m.status=3 "+condtn+" group by m.psrno  order by m.psrno";
		   }
		   
		   	System.out.println("----searchProduct-sql---"+sql);

	ResultSet resultSet = stmt.executeQuery (sql);
	RESULTDATA=com.convertToJSON(resultSet);
	stmt.close();
	conn.close();

}
catch(Exception e){
	e.printStackTrace();
	conn.close();
} finally{
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

	public JSONArray enquirySrearch(HttpSession session,String msdocno,String Cl_names,String Cl_mobno,String enqdate,String clientid,int id,String reftypes) throws SQLException {

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
		if(reftypes.equalsIgnoreCase("ENQ"))
		{
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

		}
		else{
	
			if(!(enqdate.equalsIgnoreCase("undefined"))&&!(enqdate.equalsIgnoreCase(""))&&!(enqdate.equalsIgnoreCase("0")))
			{
				sqlStartDate = com.changeStringtoSqlDate(enqdate);
				sqltest=sqltest+" and sm.date<="+sqlStartDate+"";
			}
			if(!(msdocno.equalsIgnoreCase("undefined"))&&!(msdocno.equalsIgnoreCase(""))&&!(msdocno.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and sm.doc_no like '%"+msdocno+"%'";
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
			

		}
		Connection conn =null;
		Statement stmt = null;
		try {
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();
			String str1Sql="";

			if(id>0){
				if(reftypes.equalsIgnoreCase("ENQ"))
				{
				 str1Sql=("select m.date,m.doc_no,m.voc_no, if(m.cldocno>0,ac.refname,m.name) as name,coalesce(ac.doc_no,0) as clientid, "
						+ "if(m.cldocno>0,concat(coalesce(ac.address,''),',',coalesce(ac.com_mob,'') ,',',coalesce(ac.mail1,'') ),com_add1) as details, "
						+ "if(m.cpersonid>0,c.cperson,coalesce(m.cperson,'')) as cperson,coalesce(c.row_no,0) as cpersonid, "
						+ "if(m.cpersonid>0,c.mob,coalesce(m.mob,'')) as contmob,m.surtrno from gl_enqm m left join my_acbook ac "
						+ "on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_crmcontact c on(c.row_no=m.cpersonid) where 1=1 and m.status=3 and esttrno=0 "+sqltest+"");
				}
				else{
					str1Sql="select sm.date,sm.tr_no doc_no,sm.doc_no voc_no,ac.refname name,coalesce(ac.doc_no,0) as clientid,"
							+ " concat(coalesce(ac.address,''),',',coalesce(ac.com_mob,'') ,',',coalesce(ac.mail1,'') ) as details,sm.costid surtrno from cm_srvdetm sm "
							+ "left join my_acbook ac on ac.cldocno=sm.cldocno and ac.dtype='CRM'"
							+ "left join (select refdocno,cldocno from cm_srvqotm where ref_type='SRVE') qtm on 1=1  "
									+ " where sm.chkrect=1 and qtm.refdocno!=sm.tr_no "+sqltest+" group by sm.tr_no";
					
				}
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


	public int insert(java.sql.Date date,String code,String name,String formcode,String mode,ArrayList matlist,
			HttpSession session,HttpServletRequest request){

		Connection conn=null;
		int docNo=0;
		

		try{
             

			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmt = conn.prepareCall("{CALL sr_TemplateDML(?,?,?,?,?,?,?,?)}");
			stmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			stmt.setString(2,code);
			stmt.setString(3,name);
			stmt.setString(4,mode);
			stmt.setString(5,formcode);	
			stmt.setString(6, session.getAttribute("USERID").toString());
			stmt.setString(7, session.getAttribute("BRANCHID").toString());
			
			int val = stmt.executeUpdate();
			docNo=stmt.getInt("tdocno");
			request.setAttribute("tdocno", docNo);


			if(docNo>0){
       
            System.out.println(matlist);
				for(int i=0;i< matlist.size();i++){


					String[] arrayDet=((String) matlist.get(i)).split("::");
					/*System.out.println("====material activity=="+arrayDet[0]);
					System.out.println("====material activity=="+arrayDet[1]);
					System.out.println("====material activity=="+arrayDet[2]);
					System.out.println("====material activity=="+arrayDet[3]);
					System.out.println("====material activity=="+arrayDet[4]);
					System.out.println("====material activity=="+arrayDet[5]);
					System.out.println("====material activity=="+arrayDet[6]);
					System.out.println("====material activity=="+arrayDet[7]);
					System.out.println("====material activity=="+arrayDet[8]);
					System.out.println("====material activity=="+arrayDet[9]);
					System.out.println("====material activity=="+arrayDet[10]);
					System.out.println("====material activity=="+arrayDet[11]);
					System.out.println("====material activity=="+arrayDet[12]);
					System.out.println("====material activity=="+arrayDet[13]);
					System.out.println("====material activity=="+arrayDet[14]);*/
					
					String brhid=session.getAttribute("BRANCHID").toString();
					System.out.println(brhid);
					
					if((!(arrayDet[0].trim().equalsIgnoreCase("undefined")|| arrayDet[0].trim().equalsIgnoreCase("NaN")||arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()))
							|| (!(arrayDet[2].trim().equalsIgnoreCase("undefined")|| arrayDet[2].trim().equalsIgnoreCase("NaN")||arrayDet[2].trim().equalsIgnoreCase("")|| arrayDet[2].isEmpty()))
							|| (!(arrayDet[10].trim().equalsIgnoreCase("undefined")|| arrayDet[10].trim().equalsIgnoreCase("NaN")||arrayDet[10].trim().equalsIgnoreCase("")|| arrayDet[10].isEmpty())))
					{

						//System.out.println("+iii==="+i);			

						String sql="INSERT INTO cm_templated(rdocno, sertypeid, scopeid, prdId, psrno, SpecNo, unitid, qty, amount, scope_amount, total, description, brhId, scopestdcost, lblchrge, prdstdcost)VALUES"
								+ " ("+docNo+","
								+ "'"+(arrayDet[0].trim().equalsIgnoreCase("undefined") || arrayDet[0].trim().equalsIgnoreCase("NaN")|| arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()?"":arrayDet[0].trim())+"',"
								+ "'"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?0:arrayDet[1].trim())+"',"
								+ "'"+(arrayDet[2].trim().equalsIgnoreCase("undefined") || arrayDet[2].trim().equalsIgnoreCase("NaN")|| arrayDet[2].trim().equalsIgnoreCase("")|| arrayDet[2].isEmpty()?0:arrayDet[2].trim())+"',"
								+ "'"+(arrayDet[3].trim().equalsIgnoreCase("undefined") || arrayDet[3].trim().equalsIgnoreCase("NaN")|| arrayDet[3].trim().equalsIgnoreCase("")|| arrayDet[3].isEmpty()?0:arrayDet[3].trim())+"',"
								+ "'"+(arrayDet[4].trim().equalsIgnoreCase("undefined") || arrayDet[4].trim().equalsIgnoreCase("NaN")|| arrayDet[4].trim().equalsIgnoreCase("")|| arrayDet[4].isEmpty()?0:arrayDet[4].trim())+"',"
								+ "'"+(arrayDet[5].trim().equalsIgnoreCase("undefined") || arrayDet[5].trim().equalsIgnoreCase("NaN")|| arrayDet[5].trim().equalsIgnoreCase("")|| arrayDet[5].isEmpty()?0:arrayDet[5].trim())+"',"
								+ "'"+(arrayDet[6].trim().equalsIgnoreCase("undefined") || arrayDet[6].trim().equalsIgnoreCase("NaN")|| arrayDet[6].trim().equalsIgnoreCase("")|| arrayDet[6].isEmpty()?0:arrayDet[6].trim())+"',"
								+ "'"+(arrayDet[7].trim().equalsIgnoreCase("undefined") || arrayDet[7].trim().equalsIgnoreCase("NaN")|| arrayDet[7].trim().equalsIgnoreCase("")|| arrayDet[7].isEmpty()?0:arrayDet[7].trim())+"',"
								+ "'"+(arrayDet[8].trim().equalsIgnoreCase("undefined") || arrayDet[8].trim().equalsIgnoreCase("NaN")|| arrayDet[8].trim().equalsIgnoreCase("")|| arrayDet[8].isEmpty()?0:arrayDet[8].trim())+"',"
								+ "'"+(arrayDet[9].trim().equalsIgnoreCase("undefined") || arrayDet[9].trim().equalsIgnoreCase("NaN")|| arrayDet[9].trim().equalsIgnoreCase("")|| arrayDet[9].isEmpty()?0:arrayDet[9].trim())+"',"
								+ "'"+(arrayDet[10].trim().equalsIgnoreCase("undefined") || arrayDet[10].trim().equalsIgnoreCase("NaN")|| arrayDet[10].trim().equalsIgnoreCase("")|| arrayDet[10].isEmpty()?"":arrayDet[10].trim())+"',"
								+ "'"+brhid+"',"
								+ "'"+(arrayDet[11].trim().equalsIgnoreCase("undefined") || arrayDet[11].trim().equalsIgnoreCase("NaN")|| arrayDet[11].trim().equalsIgnoreCase("")|| arrayDet[11].isEmpty()?0:arrayDet[11].trim())+"',"
								+ "'"+(arrayDet[12].trim().equalsIgnoreCase("undefined") || arrayDet[12].trim().equalsIgnoreCase("NaN")|| arrayDet[12].trim().equalsIgnoreCase("")|| arrayDet[12].isEmpty()?0:arrayDet[12].trim())+"',"
						        + "'"+(arrayDet[13].trim().equalsIgnoreCase("undefined") || arrayDet[13].trim().equalsIgnoreCase("NaN")|| arrayDet[13].trim().equalsIgnoreCase("")|| arrayDet[13].isEmpty()?0:arrayDet[13].trim())+"')";

												System.out.println("==matlist==="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}
						//conn.commit();

					}

				}

				

				conn.commit();
			}


		}
		catch(Exception e){
			e.printStackTrace();
		}



		return docNo;

	}

	public int edit(int docno,java.sql.Date date,String code,String name,String formcode,String mode,ArrayList matlist,
			HttpSession session,HttpServletRequest request){

System.out.println("inside edit");
		Connection conn=null;


		try{

			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmt = conn.prepareCall("{CALL sr_TemplateDML(?,?,?,?,?,?,?,?)}");
			stmt.setInt(8,docno);
			stmt.setDate(1,date);
			stmt.setString(2,code);
			stmt.setString(3,name);
			stmt.setString(4,mode);
			stmt.setString(5,formcode);	
			stmt.setString(6, session.getAttribute("USERID").toString());
			stmt.setString(7, session.getAttribute("BRANCHID").toString());
			
			int val = stmt.executeUpdate();
			
			request.setAttribute("tdocno", docno);


			if(docno>0){
       
          
				for(int i=0;i< matlist.size();i++){


					String[] arrayDet=((String) matlist.get(i)).split("::");
				
					
					String brhid=session.getAttribute("BRANCHID").toString();
					System.out.println(brhid);
					
					if((!(arrayDet[0].trim().equalsIgnoreCase("undefined")|| arrayDet[0].trim().equalsIgnoreCase("NaN")||arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()))
							|| (!(arrayDet[2].trim().equalsIgnoreCase("undefined")|| arrayDet[2].trim().equalsIgnoreCase("NaN")||arrayDet[2].trim().equalsIgnoreCase("")|| arrayDet[2].isEmpty()))
							|| (!(arrayDet[10].trim().equalsIgnoreCase("undefined")|| arrayDet[10].trim().equalsIgnoreCase("NaN")||arrayDet[10].trim().equalsIgnoreCase("")|| arrayDet[10].isEmpty())))
					{

						//System.out.println("+iii==="+i);			

						String sql="INSERT INTO cm_templated(rdocno, sertypeid, scopeid, prdId, psrno, SpecNo, unitid, qty, amount, scope_amount, total, description, brhId, scopestdcost, lblchrge, prdstdcost)VALUES"
								+ " ("+docno+","
								+ "'"+(arrayDet[0].trim().equalsIgnoreCase("undefined") || arrayDet[0].trim().equalsIgnoreCase("NaN")|| arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()?"":arrayDet[0].trim())+"',"
								+ "'"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?0:arrayDet[1].trim())+"',"
								+ "'"+(arrayDet[2].trim().equalsIgnoreCase("undefined") || arrayDet[2].trim().equalsIgnoreCase("NaN")|| arrayDet[2].trim().equalsIgnoreCase("")|| arrayDet[2].isEmpty()?0:arrayDet[2].trim())+"',"
								+ "'"+(arrayDet[3].trim().equalsIgnoreCase("undefined") || arrayDet[3].trim().equalsIgnoreCase("NaN")|| arrayDet[3].trim().equalsIgnoreCase("")|| arrayDet[3].isEmpty()?0:arrayDet[3].trim())+"',"
								+ "'"+(arrayDet[4].trim().equalsIgnoreCase("undefined") || arrayDet[4].trim().equalsIgnoreCase("NaN")|| arrayDet[4].trim().equalsIgnoreCase("")|| arrayDet[4].isEmpty()?0:arrayDet[4].trim())+"',"
								+ "'"+(arrayDet[5].trim().equalsIgnoreCase("undefined") || arrayDet[5].trim().equalsIgnoreCase("NaN")|| arrayDet[5].trim().equalsIgnoreCase("")|| arrayDet[5].isEmpty()?0:arrayDet[5].trim())+"',"
								+ "'"+(arrayDet[6].trim().equalsIgnoreCase("undefined") || arrayDet[6].trim().equalsIgnoreCase("NaN")|| arrayDet[6].trim().equalsIgnoreCase("")|| arrayDet[6].isEmpty()?0:arrayDet[6].trim())+"',"
								+ "'"+(arrayDet[7].trim().equalsIgnoreCase("undefined") || arrayDet[7].trim().equalsIgnoreCase("NaN")|| arrayDet[7].trim().equalsIgnoreCase("")|| arrayDet[7].isEmpty()?0:arrayDet[7].trim())+"',"
								+ "'"+(arrayDet[8].trim().equalsIgnoreCase("undefined") || arrayDet[8].trim().equalsIgnoreCase("NaN")|| arrayDet[8].trim().equalsIgnoreCase("")|| arrayDet[8].isEmpty()?0:arrayDet[8].trim())+"',"
								+ "'"+(arrayDet[9].trim().equalsIgnoreCase("undefined") || arrayDet[9].trim().equalsIgnoreCase("NaN")|| arrayDet[9].trim().equalsIgnoreCase("")|| arrayDet[9].isEmpty()?0:arrayDet[9].trim())+"',"
								+ "'"+(arrayDet[10].trim().equalsIgnoreCase("undefined") || arrayDet[10].trim().equalsIgnoreCase("NaN")|| arrayDet[10].trim().equalsIgnoreCase("")|| arrayDet[10].isEmpty()?"":arrayDet[10].trim())+"',"
								+ "'"+brhid+"',"
								+ "'"+(arrayDet[11].trim().equalsIgnoreCase("undefined") || arrayDet[11].trim().equalsIgnoreCase("NaN")|| arrayDet[11].trim().equalsIgnoreCase("")|| arrayDet[11].isEmpty()?0:arrayDet[11].trim())+"',"
								+ "'"+(arrayDet[12].trim().equalsIgnoreCase("undefined") || arrayDet[12].trim().equalsIgnoreCase("NaN")|| arrayDet[12].trim().equalsIgnoreCase("")|| arrayDet[12].isEmpty()?0:arrayDet[12].trim())+"',"
						        + "'"+(arrayDet[13].trim().equalsIgnoreCase("undefined") || arrayDet[13].trim().equalsIgnoreCase("NaN")|| arrayDet[13].trim().equalsIgnoreCase("")|| arrayDet[13].isEmpty()?0:arrayDet[13].trim())+"')";

												System.out.println("==matlist==="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}
						//conn.commit();

					}

				}

				

				conn.commit();
			}


		}
		catch(Exception e){
			e.printStackTrace();
		}



		return docno;

	}

	
	public int delete(int docno,java.sql.Date date,String code,String name,String formcode,String mode,ArrayList matlist,
			HttpSession session,HttpServletRequest request){

		Connection conn=null;


		try{

			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmt = conn.prepareCall("{CALL sr_TemplateDML(?,?,?,?,?,?,?,?)}");
			stmt.setInt(8,docno);
			stmt.setDate(1,date);
			stmt.setString(2,code);
			stmt.setString(3,name);
			stmt.setString(4,mode);
			stmt.setString(5,formcode);	
			stmt.setString(6, session.getAttribute("USERID").toString());
			stmt.setString(7, session.getAttribute("BRANCHID").toString());
			
			int val = stmt.executeUpdate();
			
			request.setAttribute("tdocno", docno);


			if(docno<=0)
				{
					conn.close();
					return 0;
				}
          
				

				

				conn.commit();
			


		}
		catch(Exception e){
			e.printStackTrace();
		}



		return docno;

	}

	public JSONArray materialGridReLoad(HttpSession session,String trno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "",sqltest="";


			sql="select d.sertypeid stypeid,d.scopeid,d.prdid,d.psrno,d.specno specid,d.unitid,d.qty,d.amount,d.scope_amount,d.total,d.description desc1,"
					+ " d.scopestdcost scopestdcost,d.lblchrge lbrchg,d.prdstdcost stdprice,m.productname product,m.part_no productid,sc.sname scope,sc.doc_no scopeid,"
					+ " u.unit unit,d.unitid as unitdocno,m.productname proname,m.psrno prodoc,d.psrno proid,grp.groupname sertype,bd.brandname"
					+ " from cm_templated d left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no)"
					+ " left join my_scope sc on d.scopeid=sc.doc_no"
					+ " left join cm_templatem tm on tm.doc_no=d.rdocno left join  my_brand bd on m.brandid=bd.doc_no left join my_unitm u on d.unitid=u.doc_no left join my_groupvals grp on grp.doc_no=d.sertypeid and grp.grptype='service'"
					+ "  where tm.status=3  and d.rdocno="+trno+"";


			System.out.println("===materialGridLoad===="+sql);

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


	public JSONArray searchMaster(HttpSession session,String msdocno,String Cl_namess,String dates,int id) throws SQLException {


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
			sqltest=sqltest+" and doc_no like '%"+msdocno+"%'";
		}
		if(!(Cl_namess.equalsIgnoreCase("undefined"))&&!(Cl_namess.equalsIgnoreCase(""))&&!(Cl_namess.equalsIgnoreCase("0"))){

			sqltest=sqltest+" and name like '%"+Cl_namess+"%'";
		}
		if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0"))){
			sqlDate = com.changeStringtoSqlDate(dates);
			sqltest=sqltest+" and date<="+sqlDate+"";
		}


		Connection conn = null;
		ResultSet resultSet =null;
		try {

			conn = conobj.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();

			/*String str1Sql=("select m.doc_no,m.tr_no,ac.refname as client,ac.doc_no as cldocno,m.date,m.reviseno,m.ref_type,CONVERT(coalesce(m.refdocno,''),CHAR(100)) as refdocno,material,"
					+ " labour, machine, netTotal,mp.jobtype as activity,mp.tr_no as activityid from cm_prjestm m left join cm_estactivity ea on(m.tr_no=ea.doc_no) left join cm_prjmaster mp on(mp.tr_no=ea.activityid) "
					+ "left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') where 1=1 "+sqltest+" ");*/

			String str1Sql="select doc_no,date,code,name from cm_templatem where status=3"+sqltest+"";

						//System.out.println("==estimationsearch==="+str1Sql);
			if(id>0){
				resultSet = stmtenq1.executeQuery(str1Sql);
				RESULTDATA=com.convertToJSON(resultSet);
			}


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

	
	public int delete(int docNo,String vocno,java.sql.Date date,int clientid,String reviseno,String cmbreftype,String txtenquiry,String txtnettotal,String txtmatotal,String txtlabtotal,
			String txteqptotal,String formcode,int enqid,String mode,ArrayList matlist,HttpSession session,
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
			stmt.setString(7,txtmatotal=="" || txtmatotal==null || txtmatotal.equalsIgnoreCase("")?"0.00000":txtmatotal);
			stmt.setString(8,txtlabtotal=="" || txtlabtotal==null || txtlabtotal.equalsIgnoreCase("")?"0.00000":txtlabtotal);
			stmt.setString(9,txteqptotal=="" || txteqptotal==null || txteqptotal.equalsIgnoreCase("")?"0.00000":txteqptotal);
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

public     ClsTemplateBean getPrint(int docno, HttpServletRequest request,String brhid) throws SQLException {
		ClsTemplateBean bean = new ClsTemplateBean();
		  Connection conn = null;
		try {
				 conn = conobj.getMyConnection();

				Statement stmtprint = conn.createStatement();
	        	String resql=" select m.doc_no,m.tr_no,ac.refname as client,ac.doc_no as cldocno,DATE_FORMAT(m.date,'%d-%m-%Y')date,m.reviseno,m.ref_type,"
	        			+ " CONVERT(coalesce(m.refdocno,''),CHAR(100)) as refdocno,material, labour, machine, netTotal,m.reftrno, "
	        			+ "trim(ac.address) address,coalesce(enq.esttrno,0) esttrno,coalesce(enq.qottrno,0) qottrno from "
	        			+ " cm_prjestm m  left join gl_enqm enq on m.tr_no=enq.esttrno left join my_acbook ac "
	        			+ " on(ac.doc_no=m.cldocno and ac.dtype='CRM') where m.status=3 and m.tr_no="+docno+"";
	        		//	System.out.println("--gridload--55533"+resql);
				
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
		 
			       while(pintrs.next()){
			    	   
			    	   bean.setLbldate(pintrs.getString("date"));
			    	   bean.setLbldoc(pintrs.getString("doc_no"));
			    	   bean.setLblrefno(pintrs.getString("refdocno"));
			    	   bean.setLbltype(pintrs.getString("ref_type"));
			    	   bean.setRevisionno(pintrs.getString("reviseno"));
			    	   
			    				       }
				

				stmtprint.close();				     ArrayList<String> arr =new ArrayList<String>();
				   	 Statement stmtgrid = conn.createStatement ();       
				     String temp="";  
				       String	strSqldetail="select b.*,coalesce(round(@i:=@i+b.nettotal,2),0.00) totalnetamount from (select d.rowno,d.tr_no,round(d.qty,2) qty,round(d.costprice,2) amount,round(d.total,2) total,round(d.profitper,2) margin, "
			        			+ " round(d.nettotal,2)nettotal,d.description desc1,d.site,d.sertypeid stypeid, "
			        			+ "grp.groupname sertype,coalesce(m.productname,'') productname,coalesce(u.unit,'') unit from cm_estmprdd d "
			        			+ " left join cm_prjmaster mp  on(mp.tr_no=d.activityid) left join my_main m "
			        			+ " on(d.psrno=m.doc_no and d.prdid=m.doc_no)  left join  my_brand bd on "
			        			+ " m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join"
			        			+ " (select psrno,brhid,locid,sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty from my_prddin"
			        			+ " group by psrno,brhid ) prd on prd.psrno=d.psrno and prd.brhid=mp.brhid left join my_unitm u"
			        			+ " on m.munit=u.doc_no left join my_groupvals grp on grp.doc_no=d.sertypeid and "
			        			+ "grp.grptype='service' where 1=1  and d.tr_no="+docno+") b,(select @i:=0) as i;";
			        			
				     // System.out.println("Table11111111111"+strSqldetail);
					ResultSet rsdetail=stmtgrid.executeQuery(strSqldetail);
					int rowcount=1;
					String netamt="0.00";
					while(rsdetail.next()){
							temp=rowcount+"::"+rsdetail.getString("site")+"::"+rsdetail.getString("sertype")+"::"+
							rsdetail.getString("desc1")+"::"+rsdetail.getString("productname")+"::"+

						    rsdetail.getString("unit")+"::"+rsdetail.getString("qty")+"::"+rsdetail.getString("amount")+"::"+rsdetail.getString("total")+"::"+rsdetail.getString("margin")+"::"+rsdetail.getString("nettotal");
							arr.add(temp);
							rowcount++;
							netamt=rsdetail.getString("totalnetamount");
						
				          }
				         bean.setTotalamount(netamt+"");
					request.setAttribute("details", arr);
					stmtgrid.close();
					
				
				conn.close();



				
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return bean;
		
	
	}
	 

public JSONArray scopeSearch(HttpSession session) throws SQLException{


	JSONArray RESULTDATA1=new JSONArray();

	Connection conn=null;
	try {
		conn = conobj.getMyConnection();
		Statement stmt = conn.createStatement();

		String sql = "";

		sql="select  sname,doc_no from my_scope where status=3";



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





}
