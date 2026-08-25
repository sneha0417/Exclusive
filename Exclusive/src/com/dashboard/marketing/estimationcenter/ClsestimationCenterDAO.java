package com.dashboard.marketing.estimationcenter;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsestimationCenterDAO {

	ClsConnection conobj= new ClsConnection();
	ClsCommon com=new ClsCommon();

	public JSONArray estCenterdata(String fromdate,String todate,String branch,String clientid) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        
     	String sqltest="",sqltest1="";
        java.sql.Date sqlfromdate = null;
        java.sql.Date sqltodate = null;
    	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=com.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

       
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=com.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

       
       	if(!(clientid.equalsIgnoreCase(""))){
       		sqltest+=" and e.cldocno= "+clientid+" ";
       		sqltest1+=" and sdm.cldocno= "+clientid+" ";
       	}
       
    	
       	if(branch.equalsIgnoreCase("a")||branch.equalsIgnoreCase("0"))
    	{
			sqltest+="";
    	}
		else
		{
			sqltest+=" and e.brhid="+branch;
			sqltest1+=" and sdm.brhid="+branch;
		}
       
     	Connection conn = null;
     	
		Statement stmtVeh =null;
		ResultSet resultSet=null;
        
		try {
				 conn = conobj.getMyConnection();
				 stmtVeh = conn.createStatement ();
				
				 String sql="select a.voc_no,a.site,a.doc_no,a.ftype,a.brhid,a.date,a.remarks,a.cldocno,a.name,a.salm,a.mob,a.type,a.source,a.surdoc,a.asnuser from(select 'ENQ' as ftype,e.voc_no,e.brhid, e.doc_no, e.date, e.remarks, e.cldocno, e.name,gs.site,ms.sal_name salm, e.mob,"
						+ "if(e.enqtype=0,'General','Client') type,	ce.txtname source,CONVERT(srm.voc_no,CHAR) surdoc,um.user_name asnuser from gl_enqm e left join (select rdocno,rowno,group_concat(site) site from gl_enqsited group by rdocno) gs on gs.rdocno=e.doc_no "
						+ "left join  cm_enqsource ce on ce.doc_no=e.sourceid left join my_acbook ma on ma.cldocno=e.cldocno and ma.dtype='CRM' "
						+ "left join my_salm ms on ms.doc_no=ma.sal_id "
						+ "left join cm_surveym srm on srm.refdocno=e.doc_no left join (select refdocno,max(tr_no) trno from gl_besc group by refdocno) bs on bs.refdocno=e.doc_no left join gl_besc bc on bc.tr_no=bs.trno left join my_user um on um.doc_no=bc.asgnuserid "
						+ "where e.status=3 and e.enqstatus=1 and e.DATE between '"+sqlfromdate+"' and '"+sqltodate+"'"+sqltest+" group by e.doc_no "
						+ "union all "
						+ "select 'SRVE' as ftype,sdm.doc_no voc_no,sdm.brhid, sdm.tr_no doc_no,sdm.date, sdm.rect remarks, sdm.cldocno, "
						+ "ma.refname name,gs.site,'' as salm, '' asmob,'' as type,	'' as source,'' as surdoc,um.user_name asnuser from cm_srvdetm sdm "
						+ " left join cm_srvcontrm cm on sdm.costId=cm.tr_no left join (select tr_no,rowno,group_concat(site) site from cm_srvcsited group by tr_no) gs on gs.tr_no=cm.tr_no left join my_acbook ma on ma.cldocno=sdm.cldocno and ma.dtype='CRM' left join (select refdocno,max(tr_no) trno from gl_besc group by refdocno) bs on bs.refdocno=sdm.tr_no left join gl_besc bc on bc.tr_no=bs.trno left join my_user um on um.doc_no=bc.asgnuserid"
						+ " where sdm.DATE between '"+sqlfromdate+"' and '"+sqltodate+"' and chkrect=1"+sqltest1+") a group by a.doc_no";
            		  
				 /*String sql="select e.voc_no,e.brhid, e.doc_no,bq.tr_no schtrno, e.date, e.remarks, e.cldocno, e.name,ms.sal_name salm, e.mob, if(e.enqtype=0,'General','Client') type,"
            				+ "	ce.txtname source,m.grpcode groups,em.name grpmem,gr.groupname asgmeth,bq.plannedon,bq.pltime,bq.description,bq.empgroupid, bq.empid, bq.asgnMode,md.doc_no as teampid from gl_enqm e  "
            				+ "  left join gl_beqs bq on bq.rdocno=e.doc_no left join cm_serteamm m on(bq.empgroupid=m.doc_no) left join cm_serteamd md on(md.rdocno=m.doc_no and bq.empid=md.empid) "
            				+ "left join hr_empm em on(md.empid=em.doc_no) left join my_groupvals gr on(gr.doc_no=bq.asgnmode and gr.grptype='assignmode') left join  cm_enqsource ce on ce.doc_no=e.sourceid left join my_acbook ma on ma.cldocno=e.cldocno left join my_salm ms on ms.doc_no=ma.sal_id"
            				+ "	 where e.status=3 and e.enqstatus=1 and e.DATE between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+" ";*/
          
				System.out.println("--estimationcenter=--"+sql);
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


	public JSONArray userSearch(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select doc_no docno,user_name username from my_user where status=3 and block=0";

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
