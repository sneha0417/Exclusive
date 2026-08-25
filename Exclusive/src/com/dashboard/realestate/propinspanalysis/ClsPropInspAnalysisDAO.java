package com.dashboard.realestate.propinspanalysis;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import propertyinsplogin.ClsPropertyInspLoginBean;
import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsPropInspAnalysisDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getDetailData(String branch,String fromdate,String todate,String tenantdocno,String propdocno,String id)throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String sqltest="";
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and insp.brhid="+branch;
			}
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqltest+=" and date(insp.inspdate)>='"+sqlfromdate+"'";
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and date(insp.inspdate)<='"+sqltodate+"'";
			}
			if(!tenantdocno.equalsIgnoreCase("")){
				sqltest+=" and ac.cldocno="+tenantdocno;
			}
			if(!propdocno.equalsIgnoreCase("")){
				sqltest+=" and insp.propdocno="+propdocno;
			}
			String strsql="select 'Edit' editbtn,coalesce(ac.cldocno,'') cldocno,coalesce(ac.mail1,'') email,tnc.voc_no tncvocno,case when insp.signstatus=1 then 'No Issues' when insp.signstatus=2 then 'Minor' when insp.signstatus=3 then 'Major' else '' end signstatus,usr.user_name inspuser,insp.doc_no inspdocno,insp.propdocno,insp.tncdocno,date(insp.inspdate) inspdate,insp.insptype,prop.accname propname,"+
			" ac.refname tenantname,insp.insdate scheduledate,insp.skipped,if(coalesce(insp.skipped,0)=1,'Skipped','Completed') inspstatus,'Attach' attachbtn,'E-mail' emailbtn,if(prop.inspdocno=insp.doc_no,1,0) compl from "+
			" rl_propinspm insp left join rl_propertymaster prop on insp.propdocno=prop.doc_no left join rl_tncm tnc on"+
			" insp.tncdocno=tnc.doc_no left join my_acbook ac on (tnc.cldocno=ac.cldocno and ac.dtype='CRM') left join rl_propertryowner own on"+
			" prop.owid=own.doc_no left join my_user usr on insp.userid=usr.doc_no where insp.status=3"+sqltest;
			System.out.println("strsql---->>>"+strsql);
			ResultSet rs=conn.createStatement().executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public JSONArray getSummaryData(String branch,String fromdate,String todate,String tenantdocno,String propdocno,String id,String summarytype)throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String sqltest="";
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and insp.brhid="+branch;
			}
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqltest+=" and date(insp.inspdate)>='"+sqlfromdate+"'";
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and date(insp.inspdate)<='"+sqltodate+"'";
			}
			if(!tenantdocno.equalsIgnoreCase("")){
				sqltest+=" and ac.cldocno="+tenantdocno;
			}
			if(!propdocno.equalsIgnoreCase("")){
				sqltest+=" and insp.propdocno="+propdocno;
			}
			String strgrpby="";
			String strorderby="";
			if(summarytype.equalsIgnoreCase("M")){
				strgrpby=" group by year(a.inspdate),month(a.inspdate)";
				strorderby=" order by year(a.inspdate),month(a.inspdate)";
			}
			else if(summarytype.equalsIgnoreCase("Y")){
				strgrpby=" group by year(a.inspdate)";
				strorderby=" order by year(a.inspdate)";
			}
			String strsql="select sum(a.inspcount) inspcount,sum(a.handbackcount) handbackcount,sum(a.handovercount) handovercount,monthname(inspdate) "+
			" inspmonthname,year(inspdate) inspyear from ("+
			" select insp.inspdate,if(insp.insptype='Inspection',1,0) inspcount,if(insp.insptype='Hand Back',1,0) handbackcount,if(insp.insptype='Hand Over',1,0) "+
			" handovercount from rl_propinspm insp left join rl_tncm tnc on insp.tncdocno=tnc.doc_no left join my_acbook ac on (tnc.cldocno=ac.cldocno and ac.dtype='CRM') where insp.status=3"+sqltest+") a "+strgrpby+" "+strorderby;
			System.out.println(strsql);
			ResultSet rs=conn.createStatement().executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public JSONArray clientSrearch( HttpSession session,  String sclname,  String smob,  String rno,  String Contact) throws SQLException {
        JSONArray RESULTDATA = new JSONArray();
         String brnchid = session.getAttribute("BRANCHID").toString();
        String sqltest = "";
        if (!sclname.equalsIgnoreCase("")) {
            sqltest = String.valueOf(sqltest) + " and m.refname like '%" + sclname + "%'";
        }
        if (!smob.equalsIgnoreCase("")) {
            sqltest = String.valueOf(sqltest) + " and m.com_mob like '" + smob + "'";
        }
        if (!rno.equalsIgnoreCase("")) {
            sqltest = String.valueOf(sqltest) + " and m.cldocno like '" + rno + "%'";
        }
        if (!Contact.equalsIgnoreCase("")) {
            sqltest = String.valueOf(sqltest) + " and m.contactperson like '" + Contact + "%'";
        }
        Connection conn = null;
        Statement stmtVeh7 = null;
        try {
            conn = objconn.getMyConnection();
            stmtVeh7 = conn.createStatement();
            String str1Sql = "select m.cldocno,m.refname,m.com_mob,m.contactperson as contact,m.PER_TEL as tel,m.per_mob as mob,m.mail1 as email from my_acbook m  left join my_clcatm c on c.doc_no=m.catid  where m.dtype='CRM' and c.tenant=1 and m.status<>7  " + sqltest;
            System.out.println("tenantsql = " + str1Sql);
            ResultSet resultSet = stmtVeh7.executeQuery(str1Sql);
            RESULTDATA = objcommon.convertToJSON(resultSet);
        }
        catch (Exception e) {
            e.printStackTrace();
            return RESULTDATA;
        }
        finally {
            stmtVeh7.close();
            conn.close();
        }
        stmtVeh7.close();
        conn.close();
        return RESULTDATA;
    }
	
	
	
	public JSONArray pmaterearch( HttpSession session,  String docnoss,  String own,  String pname,  String datess,  String aa,  String descriptions,  String propunitno) throws SQLException {
        JSONArray RESULTDATA = new JSONArray();
        if (!aa.equalsIgnoreCase("yes")) {
            return RESULTDATA;
        }
        if (!aa.equalsIgnoreCase("yes")) {
            return RESULTDATA;
        }
        Date sqlStartDate = null;
        if (!datess.equalsIgnoreCase("undefined") && !datess.equalsIgnoreCase("") && !datess.equalsIgnoreCase("0")) {
            sqlStartDate = objcommon.changeStringtoSqlDate(datess);
        }
        String sqltest = "";
        if (!docnoss.equalsIgnoreCase("") && !docnoss.equalsIgnoreCase("NA")) {
            /*sqltest = String.valueOf(sqltest) + " and  m.voc_no like '%" + docnoss + "%'";*/
        	sqltest = String.valueOf(sqltest) + " and  m.prid like '%" + docnoss + "%'";
        }
        if (!propunitno.equalsIgnoreCase("") && !propunitno.equalsIgnoreCase("NA")) {
        	sqltest = String.valueOf(sqltest) + " and  m.unitno='" + propunitno + "'";
        }
        if (!own.equalsIgnoreCase("") && !own.equalsIgnoreCase("NA")) {
            sqltest = String.valueOf(sqltest) + " and o.primary_owner like '%" + own + "%'  ";
        }
        if (!pname.equalsIgnoreCase("") && !pname.equalsIgnoreCase("NA")) {
            sqltest = String.valueOf(sqltest) + " and m.accname like '%" + pname + "%'";
        }
        if (!descriptions.equalsIgnoreCase("") && !descriptions.equalsIgnoreCase("NA")) {
            sqltest = String.valueOf(sqltest) + " and m.desc1 like '%" + descriptions + "%'";
        }
        if (sqlStartDate != null) {
            sqltest = String.valueOf(sqltest) + " and m.date='" + sqlStartDate + "'";
        }
        Connection conn = null;
        try {
            conn = objconn.getMyConnection();
            if (aa.equalsIgnoreCase("yes")) {
                 Statement stmtmain = conn.createStatement();
                 String pySql = " select coalesce(m.mgprpty,0) mgprpty,coalesce(o.tele_phn,'') ownertel,coalesce(o.mobile,'') ownermobile,coalesce(o.email,'') owneremail,coalesce(if(m.terms_mangfeevalue='',0,round(m.terms_mangfeevalue,2)),0) mgmtfeevalue,coalesce(if(m.terms_mangfeeperc='',0,round(m.terms_mangfeeperc,2)),0) mgmtfeepercent,m.tenancy_cheque_owner_name chktenancychequeowner,m.prid propertyid,m.unitno,m.optid,m.doc_no, m.voc_no,  m.date, accname as name,  o.primary_owner  owner,desc1,if(m.cnt_no>0,'RENTED','AVAILABLE') type, convert(if(m.cnt_no>0,DATE_ADD(cnt_date, INTERVAL 1 DAY),''),char(100)) adate, m.terms_mangfeeperc as mngperc  from rl_propertymaster m left join rl_propertryowner o on o.doc_no=m.owid where m.status=3 and m.active=1 and m.cnt_no=0  " + sqltest + " group by m.doc_no ";
                System.out.println("property search=== " + pySql);
                 ResultSet resultSet = stmtmain.executeQuery(pySql);
                RESULTDATA = objcommon.convertToJSON(resultSet);
                stmtmain.close();
            }
            conn.close();
            return RESULTDATA;
        }
        catch (Exception e) {
            e.printStackTrace();
            conn.close();
            return RESULTDATA;
        }
    }
	public ClsPropInspAnalysisBean getPrint(int docno,
			HttpServletRequest request, HttpSession session, Connection conn) throws SQLException {
		// TODO Auto-generated method stub
		ClsPropInspAnalysisBean bean=new ClsPropInspAnalysisBean();       
		try{
			Statement stmt=conn.createStatement();
			String strsql="select date_format(m.inspdate,'%d.%m.%Y %h:%m %a')inspdate,m.insptype,m.chkopt1,m.chkopt2,m.chkopt3,m.chkopt4,coalesce(m.repairdet,'')repdet,coalesce(m.tenantsign,'') as tenantsig,if(m.insptype='Hand Over',1,0) as coladd,coalesce(m.signature,'') as signature,if(m.insptype='Hand Back',1,0)cmnt,po.primary_owner as owner,prop.accname lblproperty,ac.refname lbltenant,usr.user_name lblinspector,m.doc_no lbldocno, date_format(m.inspdate,'%d.%m.%Y') lblinspdate, group_concat(comments) as summary from rl_propinspm m "
					+ "left join rl_propertymaster prop on m.propdocno=prop.doc_no left  join rl_tncm tnc on m.tncdocno=tnc.doc_no "
					+ "left  join rl_propertryowner po on prop.owid=po.doc_no  left join my_acbook ac on (tnc.cldocno=ac.cldocno and ac.dtype='CRM') left join my_user  usr on m.userid=usr.doc_no left join rl_propinspd d on m.doc_no=d.rdocno and comments!='' "
					+ "where m.status=3 and m.doc_no="+docno;
			
			//System.out.println("mainqryinsp======="+strsql);
			
			ResultSet rsprint=stmt.executeQuery(strsql);
			while(rsprint.next()){
				bean.setLbldate(rsprint.getString("lblinspdate"));
				bean.setLbldocno(rsprint.getString("lbldocno"));
				bean.setLblinspector(rsprint.getString("lblinspector"));
				bean.setLblproperty(rsprint.getString("lblproperty"));
				bean.setLbltenant(rsprint.getString("lbltenant"));
				bean.setLblinsptype(rsprint.getString("cmnt"));
				bean.setLblowner(rsprint.getString("owner"));
				bean.setLblsign(rsprint.getString("signature"));
				bean.setLblsumm(rsprint.getString("summary"));
				bean.setLblcoladd(rsprint.getString("coladd"));
				bean.setLbltenantsig(rsprint.getString("tenantsig"));
				bean.setLblchkop1(rsprint.getString("chkopt1"));
				bean.setLblchkop2(rsprint.getString("chkopt2"));
				bean.setLblchkop3(rsprint.getString("chkopt3"));
				bean.setLblchkop4(rsprint.getString("chkopt4"));
				bean.setLblrepdet(rsprint.getString("repdet"));
				bean.setLblinspectype(rsprint.getString("insptype"));
				bean.setLblsigdate(rsprint.getString("inspdate"));
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
		}
		return bean;
	} 
	public   ArrayList<String[]> getInspectionPrintPicsNew(int docno, Connection conn) throws SQLException {   
		// TODO Auto-generated method stub
		
		ArrayList<String[]> picarray=new ArrayList<String[]>();
		
		try {
			conn=objconn.getMyConnection();
			Statement stmtnew=conn.createStatement();
			String strnew="select coalesce(concat(mr.rdesc1,' - ',coalesce(r.fdesc1,'General',r.fdesc1)),'General') imgdesc,a.path from my_fileattach a left join rl_propinspattach p on p.attachdocno=a.rowno "
                          + "left join re_mfurnfix r on r.doc_no=p.furndocno left join re_mroom mr on mr.doc_no=p.roomdocno where a.dtype='BPI' and a.doc_no="+docno+"";
			//System.out.println("printpics========"+strnew);
			ResultSet rsexist=stmtnew.executeQuery(strnew);
			
			while(rsexist.next()){
				//System.out.println("loop========1");
				int i=0;
				String[] temp=new String[1];
				if(!rsexist.getString("path").equalsIgnoreCase("")){
					
					temp[i]=rsexist.getString("path")+"##"+rsexist.getString("imgdesc");
					//System.out.println("temp========"+temp);
					picarray.add(temp);
				}else{
					
				}
			}
			//System.out.println("picarray========"+picarray);
			stmtnew.close();
			
			return picarray;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
			return null;
		}
		finally{
			conn.close();
		}
	}
}
