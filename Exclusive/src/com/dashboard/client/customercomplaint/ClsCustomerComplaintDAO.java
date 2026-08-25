package com.dashboard.client.customercomplaint;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.realestate.tenantrequest.ClsTenantRequestBean;

import net.sf.json.JSONArray;

public class ClsCustomerComplaintDAO {

    ClsConnection ClsConnection=new ClsConnection();
    ClsCommon ClsCommon=new ClsCommon();
    
    public JSONArray GridLoading(String check,String type) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
         if(!(check.equalsIgnoreCase("1"))){
            
        return RESULTDATA;
        
    }
    try {
            conn = ClsConnection.getMyConnection();
            Statement stmtCRM = conn.createStatement();
         //   System.out.println(type);
            String sql = "";
            if(type.equalsIgnoreCase("2")){
          	 sql=" select gr.rowno, gr.name, gr.mob, gr.roomno, gr.complaint, gr.description, gr.status, date_format(gr.edate, '%d.%m.%y')edate,time_format(gr.edate, '%H:%i') etime,gr.request_docno reqcomp,convert(CONCAT(gr.complaint,'  -  ',gr.description),char(1000))description1 from rl_guestregd gr where gr.status=3 and gr.complete=1 group by gr.rowno";
          			  //System.out.println(" ===1==== "+sql);         
            } else {
           	 sql=" select gr.rowno, gr.name, gr.mob, gr.roomno, gr.complaint, gr.description, gr.status, date_format(gr.edate, '%d.%m.%y')edate,time_format(gr.edate, '%H:%i') etime,gr.request_docno reqcomp,convert(CONCAT(gr.complaint,'  -  ',gr.description),char(1000))description1 from rl_guestregd gr where gr.status=3 and gr.complete=0 group by gr.rowno";
               //System.out.println(" ===2==== "+sql);         
               }
              ResultSet resultSet = stmtCRM.executeQuery(sql);
           
           RESULTDATA=ClsCommon.convertToJSON(resultSet);
           
           stmtCRM.close();
           conn.close();
   }catch(Exception e){
       e.printStackTrace();
       conn.close();
   }finally{
       conn.close();
   }
   return RESULTDATA;
}
    public JSONArray FollowUpGrid(String rdocno,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        if(!(check.equalsIgnoreCase("1"))){
            return RESULTDATA;
        }
        try {
                conn = ClsConnection.getMyConnection();
                Statement stmtCRM = conn.createStatement();
                
                String sql = "select m.date detdate,m.remarks remk,m.fdate,u.user_id user from gl_bcuc m inner join my_user u on u.doc_no=m.userid where m.rdocno="+rdocno+" group by m.doc_no";
                //System.out.println("queryfollowup==========="+sql);
                ResultSet resultSet = stmtCRM.executeQuery(sql);
                RESULTDATA=ClsCommon.convertToJSON(resultSet);
                
                stmtCRM.close();
                conn.close();
        }catch(Exception e){
            e.printStackTrace();
            conn.close();
        }finally{
            conn.close();
        }
        return RESULTDATA;
    }
    

    public JSONArray propertyrequest(HttpSession session, String docnoss,
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
			sqltest = sqltest + " and m.accname like '%" + pname + "%' ";
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

				String pySql = (" select  m.doc_no, m.voc_no,  m.date, m.accname as name,  o.primary_owner  owner,desc1,if(m.cnt_no>0,'RENTED','AVAILABLE') type,"
						+ " convert(if(m.cnt_no>0,DATE_ADD(cnt_date, INTERVAL 1 DAY),''),char(100)) adate,t.cldocno as tdoc_no,concat(ma.refname ,' - ',ma.address) as tenant  "
						+ " from rl_propertymaster m left join rl_tncm t on t.doc_no=m.cnt_no left join my_acbook ma on t.cldocno=ma.cldocno and ma.dtype='crm' "
						+ " left join my_clcatm c on c.doc_no=ma.catid left join rl_propertryowner o on o.doc_no=m.owid where m.status=3 and m.active=1  "
						+ sqltest + " group by m.doc_no ");

				//System.out.println("property search=== " + pySql);

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


    	public JSONArray tenantrequest(HttpSession session, String sclname,
    			String smob, String rno, String Contact) throws SQLException {

    		JSONArray RESULTDATA = new JSONArray();

    	//	String brnchid = session.getAttribute("BRANCHID").toString();

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
    			conn = ClsConnection.getMyConnection();
    			stmtVeh7 = conn.createStatement();
    			String str1Sql = ("select m.cldocno,m.refname,m.com_mob,m.contactperson as contact from my_acbook m "
    					+ " left join my_clcatm c on c.doc_no=m.catid  where m.dtype='CRM' and c.tenant=1 and m.status<>7  " + sqltest);
    			//System.out.println("==========" + str1Sql);
    			ResultSet resultSet = stmtVeh7.executeQuery(str1Sql);
    			RESULTDATA = ClsCommon.convertToJSON(resultSet);

    		} catch (Exception e) {
    			e.printStackTrace();
    		} finally {
    			stmtVeh7.close();
    			conn.close();
    		}
    		// System.out.println(RESULTDATA);
    		return RESULTDATA;
    	}
      
    	public JSONArray jobSearch(HttpSession session) throws SQLException {

    		JSONArray RESULTDATA = new JSONArray();
    		Connection conn = null;
    		try {
    			conn = ClsConnection.getMyConnection();
    			Statement stmt = conn.createStatement();
    			String sql = "SELECT * FROM rl_jobmaster where status=3";
    		//	System.out.println("jobsearch===========" + sql);
    			
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
