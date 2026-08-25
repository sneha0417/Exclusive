package com.dashboard.marketing.estimationfollowup;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsestimationFollowupDAO {

	ClsConnection conobj= new ClsConnection();
	ClsCommon com=new ClsCommon();

	public JSONArray estFollowupdata(String fromdate,String todate,String branch,String clientid) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
      //  System.out.println("clientid=="+clientid);
     	String sqltest="";
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
       		sqltest+=" and e.cldocno="+clientid+" ";
       	}
       
    	
       	if(branch.equalsIgnoreCase("a")||branch.equalsIgnoreCase("0"))
    	{
			sqltest+="";
    	}
		else
		{
			sqltest+=" and e.brhid="+branch;
		}
       
     	Connection conn = null;
     	
		Statement stmtVeh =null;
		ResultSet resultSet=null;
        
		try {
				 conn = conobj.getMyConnection();
				 stmtVeh = conn.createStatement ();
				
				String sql="select 'ENQ' as ftype,e.voc_no,e.brhid, e.doc_no, e.date, e.remarks, e.cldocno, e.name,ms.sal_name salm, e.mob,"
						+ "if(e.enqtype=0,'General','Client') type,	ce.txtname source,CONVERT(srm.voc_no,CHAR) surdoc,mu.user_name asnuser,coalesce(trim(ma.address),'') address,"
						+ "ma.per_tel pertel,ma.per_mob,trim(ma.mail1) mail1,sm.sal_name as salname,sm.doc_no as salid,e.surtrno,"
						+ "if(e.enqstatus=1,'To be Estimated','Estimated') status,e.enqstatus,e.contrmode contrtype,e.esttrno,e.cpersonid,e.cperson,e.sjobtype,concat('MOB',':',cp.mob,';','Email',':',cp.email,';','Tele',':',cp.tel) contactdet,if(ma.nontax=1,coalesce(tax.per,0.00),0.00) taxper,st.site from gl_enqm e "
						+ "left join  cm_enqsource ce on ce.doc_no=e.sourceid left join my_acbook ma on ma.cldocno=e.cldocno and ma.dtype='CRM'  "
						+ " left join my_salm sm on(ma.sal_id=sm.doc_no) left join my_salm ms on ms.doc_no=ma.sal_id "
						+ "left join (select rdocno,group_concat(site) site from gl_enqsited group by rdocno) st on st.rdocno=e.doc_no "
						+ "left join cm_surveym srm on srm.refdocno=e.doc_no left join (select max(tr_no) tr_no,refdocno from gl_besc group by refdocno) bs on bs.refdocno=e.doc_no left join gl_besc gs on bs.tr_no=gs.tr_no "
						+ "left join my_user mu on mu.doc_no=gs.asgnuserid left join my_crmcontact cp on cp.row_no=e.cpersonid left join gl_taxsubmaster tax on (tax.fromdate<='"+sqlfromdate+"' and tax.todate>='"+sqltodate+"' and tax.status=3 and tax.type=2 and tax.per>0) "
						+ "where e.status=3 and e.enqstatus in (1,2)  and e.DATE between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+" group by e.doc_no "
						+ "union all "
						+ "select 'SRVE' as ftype,e.doc_no voc_no,e.brhid, e.tr_no doc_no,e.date, e.rect remarks, e.cldocno, "
						+ "ma.refname name,sm.sal_name as salm, ma.per_mob asmob,'Client' as type,	'' as source,'' as surdoc,mu.user_name asnuser,coalesce(trim(ma.address),'') address,"
						+ "ma.per_tel pertel,ma.per_mob,trim(ma.mail1) mail1,sm.sal_name as salname,sm.doc_no as salid,e.costid surtrno,"
						+ "CASE WHEN est.ref_type='SRVE' THEN 'Estimated' ELSE 'To be Estimated' END AS status,CASE WHEN est.ref_type='SRVE' THEN 2 ELSE 0 END AS enqstatus,e.ref_type contrtype,0 as esttrno,0 cpersonid,'' cperson,0 sjobtype,'' contactdet,if(ma.nontax=1,coalesce(tax.per,0.00),0.00) taxper,st.site from cm_srvdetm e "
						+ "left join cm_prjestm est on (e.doc_no=est.refdocno and est.ref_type='SRVE') left join cm_srvqotm qotm on (e.tr_no=qotm.refdocno and qotm.ref_type='SRVE' and qotm.status<>7) "
						+ "left join my_acbook ma on ma.cldocno=e.cldocno and ma.dtype='CRM' left join my_salm sm on(ma.sal_id=sm.doc_no) left join cm_srvcsited st on (e.siteid=st.rowno) "
						+ " left join (select max(tr_no) tr_no,refdocno from gl_besc group by refdocno) bs on bs.refdocno=e.tr_no left join gl_besc gs on bs.tr_no=gs.tr_no left join my_user mu on mu.doc_no=gs.asgnuserid left join gl_taxsubmaster tax on (tax.fromdate<='"+sqlfromdate+"' and tax.todate>='"+sqltodate+"' and tax.status=3 and tax.type=2 and tax.per>0) "
						+ " where e.DATE between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+" and e.chkrect=1 and qotm.doc_no is null group by e.tr_no ";
            		
					 System.out.println("--estimationfollowup=--"+sql);
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

	public JSONArray estFollowupExcel(String fromdate,String todate,String branch,String clientid) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
     	String sqltest="";
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
       		sqltest+=" and e.cldocno="+clientid+" ";
       	}
       
    	
       	if(branch.equalsIgnoreCase("a")||branch.equalsIgnoreCase("0"))
    	{
			sqltest+="";
    	}
		else
		{
			sqltest+=" and e.brhid="+branch;
		}
       
     	Connection conn = null;
     	
		Statement stmtVeh =null;
		ResultSet resultSet=null;
        
		try {
				 conn = conobj.getMyConnection();
				 stmtVeh = conn.createStatement ();
				
				String sql="select 'ENQ' as 'TYPE', e.date 'Date',e.voc_no 'Doc No', e.name 'Client',ms.sal_name 'Salesman', e.mob 'MOB',e.contrmode 'Contract Type', e.remarks 'Remarks',mu.user_name 'Assigned User',st.site 'Site',"
						+ "if(e.enqstatus=1,'To be Estimated','Estimated') 'Status' from gl_enqm e left join  cm_enqsource ce on ce.doc_no=e.sourceid left join my_acbook ma on ma.cldocno=e.cldocno and ma.dtype='CRM' "
						+ " left join my_salm sm on(ma.sal_id=sm.doc_no) left join my_salm ms on ms.doc_no=ma.sal_id "
						+ " left join (select rdocno,group_concat(site) site from gl_enqsited group by rdocno) st on st.rdocno=e.doc_no "
						+ "left join cm_surveym srm on srm.refdocno=e.doc_no left join (select max(tr_no) tr_no,refdocno from gl_besc group by refdocno) bs on bs.refdocno=e.doc_no left join gl_besc gs on bs.tr_no=gs.tr_no "
						+ "left join my_user mu on mu.doc_no=gs.asgnuserid "
						+ "where e.status=3 and e.enqstatus in (1,2)  and e.DATE between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+" group by e.doc_no "
						+ "union all "
						+ "select 'SRVE' as 'TYPE',e.date 'Date',e.doc_no 'Doc No',ma.refname 'Client',sm.sal_name as 'Salesman',ma.per_mob as 'MOB',e.ref_type 'Contract Type',e.rect 'Remarks',"
						+ "mu.user_name 'Assigned User',st.site 'Site',CASE WHEN est.ref_type='SRVE' THEN 'Estimated' ELSE 'To be Estimated' END AS 'Status' from cm_srvdetm e "
						+ "left join cm_prjestm est on (e.doc_no=est.refdocno and est.ref_type='SRVE') left join cm_srvqotm qotm on (e.tr_no=qotm.refdocno and qotm.ref_type='SRVE' and qotm.status<>7) "
						+ "left join my_acbook ma on ma.cldocno=e.cldocno and ma.dtype='CRM' left join my_salm sm on(ma.sal_id=sm.doc_no) left join cm_srvcsited st on (e.siteid=st.rowno) "
						+ " left join (select max(tr_no) tr_no,refdocno from gl_besc group by refdocno) bs on bs.refdocno=e.tr_no left join gl_besc gs on bs.tr_no=gs.tr_no left join my_user mu on mu.doc_no=gs.asgnuserid"
						+ " where e.DATE between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+" and e.chkrect=1 and qotm.doc_no is null  group by e.tr_no";
            		
            		resultSet = stmtVeh.executeQuery(sql);
            		RESULTDATA=com.convertToEXCEL(resultSet);
     			
		}
		catch(Exception e){
			conn.close();
		}
		finally{
			stmtVeh.close();
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

	

	

}
