package com.dashboard.marketing.designhandover;

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
import com.dashboard.marketing.leadfollowuplog.ClsLeadFollowupLogBean;

import net.sf.json.JSONArray;

public class ClsDesignHandoverDAO {

	ClsConnection conobj= new ClsConnection();
	ClsCommon com=new ClsCommon();

	public JSONArray enquirySchedulerdata(String uptodate,String branch,String clientid,String area,HttpSession session) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
     	String sqltest="";
        java.sql.Date sqluptodate = null;
     	if(!(uptodate.equalsIgnoreCase("undefined"))&&!(uptodate.equalsIgnoreCase(""))&&!(uptodate.equalsIgnoreCase("0")))
     	{
     		sqluptodate=com.changeStringtoSqlDate(uptodate);
     	}
     	else{
     	}
       
       	if(!(clientid.equalsIgnoreCase("")||clientid.equalsIgnoreCase("0"))){
       		sqltest+=" and e.cldocno= "+clientid+" ";
       	}
       	if(!(area.equalsIgnoreCase("")||area.equalsIgnoreCase("0"))){
       		sqltest+=" and e.sourceid="+area+" ";
       	}
    	
       	if(!(branch.equalsIgnoreCase("a")||branch.equalsIgnoreCase("0")))
    	{
			sqltest+=" and e.brhid="+branch;
		}
       	
       	
       
     	Connection conn = null;
		Statement stmtVeh =null;
		ResultSet resultSet=null;
		try {
				 conn = conobj.getMyConnection();
				 stmtVeh = conn.createStatement ();
				 
				 String sql=" select e.voc_no,e.brhid, e.doc_no, e.date, e.remarks, e.cldocno, e.name,ms.sal_name salm, e.mob, if(e.enqtype=0,'General','Client') type,"
            				+ "	ce.txtname source,'VIEW' as view,mu.func path,round(timestampdiff(minute,e.survdatetime,now())/60,2) age "
            				+ " from gl_enqm e  left join  cm_enqsource ce on ce.doc_no=e.sourceid "
            				+ " left join my_acbook ma on ma.cldocno=e.cldocno and ma.dtype='crm' left join my_salm ms on ms.doc_no=ma.sal_id "
            				+ " left join my_menu mu on mu.doc_type='enq' left join my_salesman sl on sl.doc_no=ma.sal_id and sl.sal_type='DRF' where e.status=3 and e.enqstatus=1 "
            				+ " and e.designstat=0 and e.DATE<='"+sqluptodate+"' and sl.userlink="+session.getAttribute("USERID").toString()+" "+sqltest+" group by e.doc_no ";
          System.out.println("--enqscheduler=--"+sql);
            		resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=com.convertToJSON(resultSet);
     			
		}
		catch(Exception e){
			conn.close();
		}
		finally{
			stmtVeh.close();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }

	public JSONArray siteGridLoad(HttpSession session,String docno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select a.rdocno,eq.sr_no,eq.rowno, (SELECT GROUP_CONCAT(name ORDER BY cm_proptypem.doc_no) nam  FROM cm_proptypem "
					+ "WHERE FIND_IN_SET(cm_proptypem.doc_no, a.surv_id) order by doc_no) surtype,eq.site,grp.groupname area,eq.remarks, eq.areaid, "
					+ "eq.surv_id surid  from gl_enqsited eq  left  join (select eq.rdocno,eq.surv_id,eq.sr_no   "
					+ "from gl_enqsited eq where eq.rdocno="+docno+") a on (a.rdocno =eq.rdocno and a.sr_no=eq.sr_no) "
					+ "left join my_groupvals grp on grp.doc_no=eq.areaid and grp.grptype='area' where eq.rdocno="+docno+"";


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
			String clsql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM'  " +sqltest);

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

	public JSONArray serviceSite(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select  distinct site  from cm_srvcsited";



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
	
	public JSONArray assignmode(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select groupname assign,codeno,doc_no docno from my_groupvals where grptype='assignmode' and status=3";

//			System.out.println("===getassign===="+sql);

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
}
