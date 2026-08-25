package com.project.execution.estimationnew;

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


//			System.out.println("==searchActivity==="+str1Sql);
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
		} finally{
			conn.close();
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
		} finally{
			conn.close();
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
		} finally{
			conn.close();
		}
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
					+ "u.unit unit,ed.unitid as unitdocno,jobtype as activity,mp.tr_no activityid,m.stdprice,ed.marginper,m.productname proname,m.productname product,ed.sitesrno,round(d.costprice,2) unittotal from cm_prjmaster mp "
					+ " left join cm_estmprdd ed on mp.tr_no=ed.tr_no left join cm_mprdd d on(mp.tr_no=d.tr_no) left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no) "
					+ "left join my_prodattrib at on(at.mpsrno=m.doc_no) "
					+ "left join my_unitm u on ed.unitid=u.doc_no  where mp.tr_no in ('"+trno+"') order by ed.sr_no";


//						System.out.println("===materialGridLoad===="+sql);

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
	
	public JSONArray scopeSearch(HttpSession session,String scopegroup) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select doc_no,scode,sname,product from my_scope where status=3 and groupid="+scopegroup+"";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=com.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
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
	
	public JSONArray brandSearch() throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select doc_no,brandname from my_brand where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=com.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray subCategorySearch() throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select doc_no,subcategory from my_scatm where status=3";

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

			String sql="select d.site Site,d.description Description,grp.groupname as'Service Type',CONVERT(coalesce(m.productname,''),CHAR(100)) Product,"
					+ "CONVERT(coalesce(bd.brandname,''),CHAR(100)) Brand,CONVERT(coalesce(u.unit,''),CHAR(100)) Unit,CONVERT(coalesce(d.qty,''),CHAR(100)) Qty,"
					+ "CONVERT(coalesce(round(d.costprice,2),''),CHAR(100)) Amount,CONVERT(coalesce(round(d.total,2),''),CHAR(100)) Total,"
					+ "CONVERT(coalesce(round(d.profitper,2),''),CHAR(100)) Margin,CONVERT(coalesce(round(d.nettotal,2),''),CHAR(100)) as 'Net Total'"
					+ " from cm_estmprdd d  "
					+ " left join cm_prjmaster mp  on(mp.tr_no=d.activityid) left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no) "
					+ " left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) "
					+ "left join (select psrno,brhid,locid,sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty from my_prddin group by psrno,brhid ) prd on prd.psrno=d.psrno and prd.brhid=mp.brhid "
					+ "left join my_unitm u on m.munit=u.doc_no left join my_groupvals grp on grp.doc_no=d.sertypeid and grp.grptype='service' where 1=1  and d.tr_no="+trno+"";

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




	 public JSONArray sitegridSearch(String reftrno,int loadid,String reftype,String srvedocno) throws SQLException{


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
				//sql="select site,sr_no sitesrno from cm_srvcsited where tr_no='"+reftrno+"'";
				
				sql="select st.sr_no sitesrno,st.site from cm_srvdetm m left join cm_srvcsited st on m.siteid=st.rowno where m.tr_no=(select tr_no from cm_srvdetm where status=3 and dtype='SRVE' and doc_no="+srvedocno+")";
			
}

//						System.out.println("===sql===="+sql);

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


//						System.out.println("===labourGridLoad===="+sql);

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

	public   JSONArray searchProduct(HttpSession session,String prodsearchtype,String rdoc,String reftype,String clientid,String date,
					String prdname,String brandname,String id,String gridunit,String gridprdname,String scopeid,String category, String subcategory) throws SQLException {

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
			
			if(!(prdname.equalsIgnoreCase(""))&&!(prdname.equalsIgnoreCase("undefined"))&&!(prdname.equalsIgnoreCase("0"))){
				condtn ="  and m.part_no like '%"+prdname+"%' ";
			}
			
			if(!(brandname.equalsIgnoreCase(""))&&!(brandname.equalsIgnoreCase("undefined"))&&!(brandname.equalsIgnoreCase("0"))){
				condtn +="  and brd.brandname like '%"+brandname+"%' ";
			}
			
			gridprdname=gridprdname.replaceAll("@","%");
			if(!(gridprdname.equalsIgnoreCase(""))&&!(gridprdname.equalsIgnoreCase("undefined"))&&!(gridprdname.equalsIgnoreCase("0"))){
				condtn +="  and m.productname like '%"+gridprdname+"%' ";
			}
			
			if(!(gridunit.equalsIgnoreCase(""))&&!(gridunit.equalsIgnoreCase("undefined"))&&!(gridunit.equalsIgnoreCase("0"))){
				condtn +="  and u.unit like '%"+gridunit+"%' ";
			}
			
			if(!(category.equalsIgnoreCase(""))&&!(category.equalsIgnoreCase("undefined"))&&!(category.equalsIgnoreCase("0"))){
				condtn +="  and c.category like '%"+category+"%' ";
			}
			
			if(!(subcategory.equalsIgnoreCase(""))&&!(subcategory.equalsIgnoreCase("undefined"))&&!(subcategory.equalsIgnoreCase("0"))){
				condtn +="  and sc.subcategory like '%"+subcategory+"%' ";
			}
			
			
           String brcid=session.getAttribute("BRANCHID").toString();
			
           String strSql = "select method from gl_config where field_nme='srvcPreSalesScope'";
   		   ResultSet rs = stmt.executeQuery(strSql);
   		
   		   String srvcPreSalesScope="";
   		   while(rs.next()) {
   			   srvcPreSalesScope=rs.getString("method");
   		   } 
   		   
   		   String strSql1 = "select method from gl_config where field_nme='srvcProductBranchAvailability'";
		   ResultSet rs1 = stmt.executeQuery(strSql1);
		
		   String srvcProductBranchAvailability="";
		   while(rs1.next()) {
			   srvcProductBranchAvailability=rs1.getString("method");
		   } 
   		
   		   if(srvcPreSalesScope.equalsIgnoreCase("1")) {
   			   
   			   /*if(!(servicetypeid.equalsIgnoreCase(""))&&!(servicetypeid.equalsIgnoreCase("undefined"))&&!(servicetypeid.equalsIgnoreCase("0"))){
   				   condtn +="  and c.link in (0,"+servicetypeid+") ";
   			   } else {
   				   condtn +="  and c.link in (0) ";
   			   }*/
   			   
   			   if(srvcProductBranchAvailability.equalsIgnoreCase("1")) {
   			
   				   sql="select at.mspecno as specid,m.part_no,m.productname prdname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,coalesce(m.fixingprice ,0) amount, "
   						   + "coalesce(m.lbrchg,0) lbrchg,brd.brandname,m.brandid,m.stdprice, coalesce(spr.fprice,0) scopefprice , coalesce(spr.stdcost,0) scopestdcost "
   						   + "from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) "
   						   + "left join my_brand brd on brd.doc_no=m.brandid left join my_scopepr spr on spr.psrno=m.psrno and scpid="+scopeid+" left join my_catm c on c.doc_no=m.catid "
   						   + "left join my_scatm sc on m.scatid=sc.doc_no where m.status=3 "+condtn+" and if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"' group by m.psrno  order by m.psrno";
   			   } else {
   			   
   				   sql="select at.mspecno as specid,m.part_no,m.productname prdname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,coalesce(m.fixingprice ,0) amount, "
   						   + "coalesce(m.lbrchg,0) lbrchg,brd.brandname,m.brandid,m.stdprice, coalesce(spr.fprice,0) scopefprice , coalesce(spr.stdcost,0) scopestdcost "
   						   + "from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) "
   						   + "left join my_brand brd on brd.doc_no=m.brandid left join my_scopepr spr on spr.psrno=m.psrno and scpid="+scopeid+" left join my_catm c on c.doc_no=m.catid "
   						   + "left join my_scatm sc on m.scatid=sc.doc_no where m.status=3 "+condtn+"  group by m.psrno  order by m.psrno";
   			   }
   		   } else {
   			   
   			   if(srvcProductBranchAvailability.equalsIgnoreCase("1")) {
   				   
   					sql="select at.mspecno as specid,m.part_no,m.productname prdname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno, "
   							+ " round(case when '"+estdate+"' BETWEEN cfr.frmdate and cfr.todate then cfr.ofrprice else m.fixingprice end,2) as amount,"
   							+ "brd.brandname,m.brandid,m.stdprice from my_main m left join my_unitm u on m.munit=u.doc_no "
   							+ "left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) left join my_brand brd on brd.doc_no=m.brandid "
   							+ "left join my_clientoffer cfr on cfr.psrno=m.psrno and cfr.cldocno="+clientid+" and '"+estdate+"' BETWEEN cfr.frmdate and cfr.todate "
   							+ "where m.status=3  "+condtn+" and if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"'  group by m.psrno  order by m.psrno ";
   					
   			   } else {
   				   
   				   sql="select at.mspecno as specid,m.part_no,m.productname prdname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno, "
							+ " round(case when '"+estdate+"' BETWEEN cfr.frmdate and cfr.todate then cfr.ofrprice else m.fixingprice end,2) as amount,"
							+ "brd.brandname,m.brandid,m.stdprice from my_main m left join my_unitm u on m.munit=u.doc_no "
							+ "left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_brand brd on brd.doc_no=m.brandid "
							+ "left join my_clientoffer cfr on cfr.psrno=m.psrno and cfr.cldocno="+clientid+" and '"+estdate+"' BETWEEN cfr.frmdate and cfr.todate "
							+ "where m.status=3  "+condtn+"  group by m.psrno  order by m.psrno ";
   				
   			   }
   		   }
			
			
			/*sql="select at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno "
					+ "from my_main m left join my_unitm u on m.munit=u.doc_no "
					+ "left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) "
					+ "where m.status=3 and de.brhid='"+session.getAttribute("BRANCHID").toString()+"'  group by m.psrno  order by m.psrno ";*/


			//System.out.println("----searchProduct-sql---"+sql);   

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
						+ "if(m.cpersonid>0,c.mob,coalesce(m.mob,'')) as contmob,m.surtrno,m.contrmode from gl_enqm m left join my_acbook ac "
						+ "on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_crmcontact c on(c.row_no=m.cpersonid) where 1=1 and m.status=3 and esttrno=0 and m.brhid="+brcid+" "+sqltest+"");
				}
				else{
					str1Sql="select sm.date,sm.tr_no doc_no,sm.doc_no voc_no,ac.refname name,coalesce(ac.doc_no,0) as clientid,"
							+ " concat(coalesce(ac.address,''),',',coalesce(ac.com_mob,'') ,',',coalesce(ac.mail1,'') ) as details,sm.costid surtrno,sm.ref_type contrmode from cm_srvdetm sm "
							+ "left join my_acbook ac on ac.cldocno=sm.cldocno and ac.dtype='CRM'"
							+ "left join (select refdocno,cldocno from cm_srvqotm where ref_type='SRVE') qtm on 1=1  "
									+ " where sm.chkrect=1 and qtm.refdocno!=sm.tr_no  and m.brhid="+brcid+" "+sqltest+" group by sm.tr_no";
					
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
		//jprintln(RESULTDATA);
		return RESULTDATA;
	}


	public int insert(java.sql.Date date,int clientid,String reviseno,String cmbreftype,String txtenquiry,String txtnettotal,String txtmatotal,String txtlabtotal,
			String txteqptotal,String formcode,int enqid,String mode,ArrayList matlist,HttpSession session,
			HttpServletRequest request,String activitiesid,String contrmode,String scopegroup){


		Connection conn=null;
		int docNo=0;
		int vocno=0;

		try{


			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			
			if(scopegroup.equalsIgnoreCase("") || scopegroup==null ){
				scopegroup="0";
			}
			
			CallableStatement stmt = conn.prepareCall("{CALL Sr_EstimationDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmt.registerOutParameter(18, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(19, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(20, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			stmt.setInt(2,clientid);
			stmt.setString(3,reviseno);
			stmt.setString(4,cmbreftype);
			stmt.setString(5, txtenquiry=="" || txtenquiry==null || txtenquiry.equalsIgnoreCase("")?"0":txtenquiry);
			stmt.setString(6,txtnettotal);
			stmt.setString(7,txtmatotal=="" || txtmatotal==null || txtmatotal.equalsIgnoreCase("")?"0.00000":txtmatotal);
			stmt.setString(8,txtlabtotal=="" || txtlabtotal==null || txtlabtotal.equalsIgnoreCase("")?"0.00000":txtlabtotal);
			stmt.setString(9,txteqptotal=="" || txteqptotal==null || txteqptotal.equalsIgnoreCase("")?"0.00000":txteqptotal);
			stmt.setString(10,mode);
			stmt.setString(11,formcode);
			stmt.setInt(12,enqid);
			stmt.setString(13, session.getAttribute("BRANCHID").toString());
			stmt.setString(14, session.getAttribute("USERID").toString());
			stmt.setString(15,activitiesid);
			stmt.setString(16,contrmode);
			stmt.setString(17,scopegroup);
			int val = stmt.executeUpdate();
			docNo=stmt.getInt("docNo");
			vocno=stmt.getInt("vocNo");
			request.setAttribute("docNo", docNo);


			if(docNo>0){


				for(int i=0;i< matlist.size();i++){


					String[] arrayDet=((String) matlist.get(i)).split("::");

					//					System.out.println("====material activity=="+arrayDet[9]);

					if((!(arrayDet[11].trim().equalsIgnoreCase("undefined")|| arrayDet[11].trim().equalsIgnoreCase("NaN")||arrayDet[11].trim().equalsIgnoreCase("")|| arrayDet[11].isEmpty()))
							|| (!(arrayDet[0].trim().equalsIgnoreCase("undefined")|| arrayDet[0].trim().equalsIgnoreCase("NaN")||arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()))
							|| (!(arrayDet[1].trim().equalsIgnoreCase("undefined")|| arrayDet[1].trim().equalsIgnoreCase("NaN")||arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty())))
					{

						System.out.println("+iii==="+i);			

						String sql="INSERT INTO cm_estmprdd(tr_no, SR_NO,Description, psrno, prdId,UNITID, qty, costPrice,  total, profitPer,activityid, NetTotal,site,sertypeid,sitesrno,marginper,scopeid,scopeamount,stdprice,lbrchg,scopestdcost) VALUES"
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
								+ "'"+(arrayDet[8].trim().equalsIgnoreCase("undefined") || arrayDet[8].trim().equalsIgnoreCase("NaN")|| arrayDet[8].trim().equalsIgnoreCase("")|| arrayDet[8].isEmpty()?0:arrayDet[8].trim())+"',"
								+ "'"+(arrayDet[10].trim().equalsIgnoreCase("undefined") || arrayDet[10].trim().equalsIgnoreCase("NaN")|| arrayDet[10].trim().equalsIgnoreCase("")|| arrayDet[10].isEmpty()?"":arrayDet[10].trim())+"',"
								+ "'"+(arrayDet[11].trim().equalsIgnoreCase("undefined") || arrayDet[11].trim().equalsIgnoreCase("NaN")|| arrayDet[11].trim().equalsIgnoreCase("")|| arrayDet[11].isEmpty()?0:arrayDet[11].trim())+"',"
								+ "'"+(arrayDet[12].trim().equalsIgnoreCase("undefined") || arrayDet[12].trim().equalsIgnoreCase("NaN")|| arrayDet[12].trim().equalsIgnoreCase("")|| arrayDet[12].isEmpty()?0:arrayDet[12].trim())+"',"
								+ "'"+(arrayDet[13].trim().equalsIgnoreCase("undefined") || arrayDet[13].trim().equalsIgnoreCase("NaN")|| arrayDet[13].trim().equalsIgnoreCase("")|| arrayDet[13].isEmpty()?0:arrayDet[13].trim())+"',"
								+ "'"+(arrayDet[14].trim().equalsIgnoreCase("undefined") || arrayDet[14].trim().equalsIgnoreCase("NaN")|| arrayDet[14].trim().equalsIgnoreCase("")|| arrayDet[14].isEmpty()?0:arrayDet[14].trim())+"',"
								+ "'"+(arrayDet[15].trim().equalsIgnoreCase("undefined") || arrayDet[15].trim().equalsIgnoreCase("NaN")|| arrayDet[15].trim().equalsIgnoreCase("")|| arrayDet[15].isEmpty()?0:arrayDet[15].trim())+"',"
								+ "'"+(arrayDet[16].trim().equalsIgnoreCase("undefined") || arrayDet[16].trim().equalsIgnoreCase("NaN")|| arrayDet[16].trim().equalsIgnoreCase("")|| arrayDet[16].isEmpty()?0:arrayDet[16].trim())+"',"
								+ "'"+(arrayDet[17].trim().equalsIgnoreCase("undefined") || arrayDet[17].trim().equalsIgnoreCase("NaN")|| arrayDet[17].trim().equalsIgnoreCase("")|| arrayDet[17].isEmpty()?0:arrayDet[17].trim())+"',"
								+ "'"+(arrayDet[18].trim().equalsIgnoreCase("undefined") || arrayDet[18].trim().equalsIgnoreCase("NaN")|| arrayDet[18].trim().equalsIgnoreCase("")|| arrayDet[18].isEmpty()?0:arrayDet[18].trim())+"')";

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

				

				conn.commit();
			}


		}
		catch(Exception e){
			e.printStackTrace();
		}



		return vocno;

	}


	public JSONArray materialGridReLoad(HttpSession session,String trno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select d.rowno,d.tr_no,m.psrno,m.psrno pid,m.psrno prodoc,at.mspecno specid,mp.brhid,prd.locid,m.part_no productid,m.productname,d.qty qty,d.costprice amount,d.total total,d.profitper margin,d.nettotal,d.description desc1,"
					+ "d.scopeid,d.stdprice,d.scopeamount,sp.scode scope,coalesce(sp.product,1) scopeproduct,d.lbrchg,d.scopestdcost,u.unit unit,d.unitid as unitdocno,jobtype as activity,mp.tr_no activityid,prd.stkqty,"
					+ "if(prd.stkqty>d.qty,d.qty,prd.stkqty) resqty,d.qty-if(prd.stkqty>d.qty,d.qty,prd.stkqty) purqty,bd.brandname,d.site,d.sertypeid stypeid,grp.groupname sertype,m.stdprice,d.marginper,m.productname proname,m.productname product,d.sitesrno,(d.costprice+d.scopeamount) unittotal from cm_estmprdd d  "
					+ "left join cm_prjmaster mp  on(mp.tr_no=d.activityid) left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no) left join my_scope sp on sp.doc_no=d.scopeid "
					+ " left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) "
					+ "left join (select psrno,brhid,locid,sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty from my_prddin group by psrno,brhid ) prd on prd.psrno=d.psrno and prd.brhid=mp.brhid "
					+ "left join my_unitm u on d.unitid=u.doc_no left join my_groupvals grp on grp.doc_no=d.sertypeid and grp.grptype='service' where 1=1  and d.tr_no='"+trno+"' order by d.sr_no";


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

	public JSONArray templateSearchGridLoading(String code,String name,String check) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA1;
		}
		
		Connection conn=null;
		
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sqltest="";
	        
	        if(!(code.equalsIgnoreCase("")) && !(code.equalsIgnoreCase("0"))){
	            sqltest=sqltest+" and code like '%"+code+"%'";
	        }
	        
	        if(!(name.equalsIgnoreCase("")) && !(name.equalsIgnoreCase("0"))){
	        	sqltest=sqltest+" and name like '%"+name+"%'";
	        }

			String sql="select doc_no,code,name from cm_templatem where dtype='STM' and status=3"+sqltest+"";

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
			sqltest=sqltest+" and m.refdocno like '%"+refno+"%'";
		}


		Connection conn = null;
		ResultSet resultSet =null;
		try {

			conn = conobj.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();

			/*String str1Sql=("select m.doc_no,m.tr_no,ac.refname as client,ac.doc_no as cldocno,m.date,m.reviseno,m.ref_type,CONVERT(coalesce(m.refdocno,''),CHAR(100)) as refdocno,material,"
					+ " labour, machine, netTotal,mp.jobtype as activity,mp.tr_no as activityid from cm_prjestm m left join cm_estactivity ea on(m.tr_no=ea.doc_no) left join cm_prjmaster mp on(mp.tr_no=ea.activityid) "
					+ "left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') where 1=1 "+sqltest+" ");*/

			String str1Sql="select m.doc_no,m.tr_no,ac.refname as client,ac.doc_no as cldocno,m.date,m.reviseno,m.ref_type,CONVERT(coalesce(m.refdocno,''),CHAR(100)) as refdocno,m.contrmode,m.scopegrpid,"
					+ "material, labour, machine, netTotal,m.reftrno,trim(ac.address) address,coalesce(enq.esttrno,0) esttrno,coalesce(enq.qottrno,0) qottrno,coalesce(esq.surtrno,0) surtrno from  cm_prjestm m "
					+ " left join gl_enqm enq on m.tr_no=enq.esttrno left join gl_enqm esq on m.reftrno=esq.doc_no left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') where m.brhid="+brid+" and m.status=3 "+sqltest+"";

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

	public int edit(int docNo,int vocno,java.sql.Date date,int clientid,String reviseno,String cmbreftype,String txtenquiry,String txtnettotal,String txtmatotal,String txtlabtotal,
			String txteqptotal,String formcode,int enqid,String mode,ArrayList matlist,HttpSession session,
			HttpServletRequest request,String activitiesid,String contrmode,String scopegroup) throws SQLException{


		Connection conn=null;


		try{

			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			if(scopegroup==null ){
				scopegroup="0";
			}
			if(scopegroup.equalsIgnoreCase("")){
				scopegroup="0";
			}
			
			CallableStatement stmt = conn.prepareCall("{CALL Sr_EstimationDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmt.registerOutParameter(20, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			stmt.setInt(2,clientid);
			stmt.setString(3,reviseno);
			stmt.setString(4,cmbreftype);
			stmt.setString(5, txtenquiry=="" || txtenquiry==null || txtenquiry.equalsIgnoreCase("")?"0":txtenquiry);
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
			stmt.setString(16,contrmode);
			stmt.setString(17,scopegroup);
			stmt.setInt(18, docNo);
			stmt.setInt(19,vocno);
//			System.out.println("========= "+stmt);
			int val = stmt.executeUpdate();
			docNo=stmt.getInt("docNo");
			vocno=stmt.getInt("vocNo");
			request.setAttribute("docNo", docNo);


			if(docNo>0){


				for(int i=0;i< matlist.size();i++){


					String[] arrayDet=((String) matlist.get(i)).split("::");

					//					System.out.println("====material activity=="+arrayDet[9]);

					if((!(arrayDet[11].trim().equalsIgnoreCase("undefined")|| arrayDet[11].trim().equalsIgnoreCase("NaN")||arrayDet[11].trim().equalsIgnoreCase("")|| arrayDet[11].isEmpty()))
							|| (!(arrayDet[0].trim().equalsIgnoreCase("undefined")|| arrayDet[0].trim().equalsIgnoreCase("NaN")||arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()))
							|| (!(arrayDet[1].trim().equalsIgnoreCase("undefined")|| arrayDet[1].trim().equalsIgnoreCase("NaN")||arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty())))
					{
						//SpecNo					

						String sql="INSERT INTO cm_estmprdd(tr_no, SR_NO,Description, psrno, prdId,UNITID, qty, costPrice,  total, profitPer,activityid, NetTotal,site,sertypeid,sitesrno,marginper,scopeid,scopeamount,stdprice,lbrchg,scopestdcost)VALUES"
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
								+ "'"+(arrayDet[8].trim().equalsIgnoreCase("undefined") || arrayDet[8].trim().equalsIgnoreCase("NaN")|| arrayDet[8].trim().equalsIgnoreCase("")|| arrayDet[8].isEmpty()?0:arrayDet[8].trim())+"',"
								+ "'"+(arrayDet[10].trim().equalsIgnoreCase("undefined") || arrayDet[10].trim().equalsIgnoreCase("NaN")|| arrayDet[10].trim().equalsIgnoreCase("")|| arrayDet[10].isEmpty()?"":arrayDet[10].trim())+"',"
								+ "'"+(arrayDet[11].trim().equalsIgnoreCase("undefined") || arrayDet[11].trim().equalsIgnoreCase("NaN")|| arrayDet[11].trim().equalsIgnoreCase("")|| arrayDet[11].isEmpty()?0:arrayDet[11].trim())+"',"
								+ "'"+(arrayDet[12].trim().equalsIgnoreCase("undefined") || arrayDet[12].trim().equalsIgnoreCase("NaN")|| arrayDet[12].trim().equalsIgnoreCase("")|| arrayDet[12].isEmpty()?0:arrayDet[12].trim())+"',"
								+ "'"+(arrayDet[13].trim().equalsIgnoreCase("undefined") || arrayDet[13].trim().equalsIgnoreCase("NaN")|| arrayDet[13].trim().equalsIgnoreCase("")|| arrayDet[13].isEmpty()?0:arrayDet[13].trim())+"',"
								+ "'"+(arrayDet[14].trim().equalsIgnoreCase("undefined") || arrayDet[14].trim().equalsIgnoreCase("NaN")|| arrayDet[14].trim().equalsIgnoreCase("")|| arrayDet[14].isEmpty()?0:arrayDet[14].trim())+"',"
								+ "'"+(arrayDet[15].trim().equalsIgnoreCase("undefined") || arrayDet[15].trim().equalsIgnoreCase("NaN")|| arrayDet[15].trim().equalsIgnoreCase("")|| arrayDet[15].isEmpty()?0:arrayDet[15].trim())+"',"
								+ "'"+(arrayDet[16].trim().equalsIgnoreCase("undefined") || arrayDet[16].trim().equalsIgnoreCase("NaN")|| arrayDet[16].trim().equalsIgnoreCase("")|| arrayDet[16].isEmpty()?0:arrayDet[16].trim())+"',"
								+ "'"+(arrayDet[17].trim().equalsIgnoreCase("undefined") || arrayDet[17].trim().equalsIgnoreCase("NaN")|| arrayDet[17].trim().equalsIgnoreCase("")|| arrayDet[17].isEmpty()?0:arrayDet[17].trim())+"',"
								+ "'"+(arrayDet[18].trim().equalsIgnoreCase("undefined") || arrayDet[18].trim().equalsIgnoreCase("NaN")|| arrayDet[18].trim().equalsIgnoreCase("")|| arrayDet[18].isEmpty()?0:arrayDet[18].trim())+"')";

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


				conn.commit();
			}


		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}



		return vocno;

	}
	
	
	public int delete(int docNo,int vocno,java.sql.Date date,int clientid,String reviseno,String cmbreftype,String txtenquiry,String txtnettotal,String txtmatotal,String txtlabtotal,
			String txteqptotal,String formcode,int enqid,String mode,ArrayList matlist,HttpSession session,
			HttpServletRequest request,String activitiesid,String contrmode,String scopegroup) throws SQLException{


		Connection conn=null;


		try{

			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			
			if(scopegroup.equalsIgnoreCase("") || scopegroup==null ){
				scopegroup="0";
			}
			
			CallableStatement stmt = conn.prepareCall("{CALL Sr_EstimationDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmt.registerOutParameter(20, java.sql.Types.VARCHAR);
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
			stmt.setString(16,contrmode);
			stmt.setString(17,scopegroup);
			stmt.setInt(18, docNo);
			stmt.setInt(19,vocno);
			int val = stmt.executeUpdate();
			docNo=stmt.getInt("docNo");
			vocno=stmt.getInt("vocNo");
			request.setAttribute("docNo", docNo);


			if(docNo>0){

				conn.commit();
			}


		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}



		return vocno;

	}

public     ClsEstimationBean getPrint(int docno, HttpServletRequest request,String brhid) throws SQLException {
		ClsEstimationBean bean = new ClsEstimationBean();
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
			    	   bean.setCustomer(pintrs.getString("client"));
			    	   bean.setCustomeraddress(pintrs.getString("address"));
			    	   bean.setLbldate(pintrs.getString("date"));
			    	   bean.setLbldoc(pintrs.getString("doc_no"));
			    	   bean.setLblrefno(pintrs.getString("refdocno"));
			    	   bean.setLbltype(pintrs.getString("ref_type"));
			    	   bean.setRevisionno(pintrs.getString("reviseno"));
			    	   
			    				       }
				

				stmtprint.close();	
				
				ArrayList<String> arr =new ArrayList<String>();
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
			        			
//				      System.out.println("Table11111111111"+strSqldetail);
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
//				         System.out.println("arr"+arr);
					request.setAttribute("details", arr);
					stmtgrid.close();
					
				
				
				
				ArrayList<String> arry =new ArrayList<String>();
				Statement sitestmtgrid = conn.createStatement();
				String temp1="";
				
		        String Sitedetail="select d.site,sum(round(d.total,2)) total,sum(round(d.profitper,2)) margin, sum(round(d.nettotal,2))nettotal from cm_estmprdd d  where 1=1  and d.tr_no="+docno+" group by site";
                
		        ResultSet result=sitestmtgrid.executeQuery(Sitedetail);
		        while(result.next()){
//		        	System.out.println("site"+result.getString("site"));
		        	 temp1=result.getString("site")+"::"+result.getString("total")+"::"+result.getString("margin")+"::"+result.getString("nettotal");
		        	 arry.add(temp1);
		        }
//		        System.out.println("arry"+arry);
		       request.setAttribute("sitedetails", arry);
		       sitestmtgrid.close();

		       conn.close();
				
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return bean;
		
	
	}
	 

	




}
