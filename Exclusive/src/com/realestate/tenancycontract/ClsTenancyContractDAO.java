package com.realestate.tenancycontract;

import com.common.ClsAmountToWords;

import java.sql.CallableStatement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import java.sql.Date;

import javax.servlet.http.HttpSession;

import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;

import net.sf.json.JSONArray;

import java.sql.Connection;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsTenancyContractDAO
{
    ClsConnection objconn=new ClsConnection();
    ClsCommon objcommon=new ClsCommon();
    
    public JSONArray paymentloading( String docno) throws SQLException {
        JSONArray RESULTDATA = new JSONArray();
        Connection conn = null;
        try {
            conn = objconn.getMyConnection();
             Statement stmtVeh = conn.createStatement();
             String salsql = "select convert(concat(coalesce(jv.dtype,''),' - ',coalesce(jv.doc_no,'')),char(25)) jvdetails,pyt.doc_no, pyt.rdocno, pyt.slno, pyt.desc1 description, pyt.date, pyt.pamount amount, pyt.notes , pyt.chqno chqno, pyt.paidto, pyt.payment paymentmethod, pyt.bank  bankaccount from rl_tncpayment pyt left join  my_jvtran jv on (jv.status=3 and pyt.refno=jv.tr_no) where pyt.rdocno='" + docno + "' group by pyt.doc_no ";
            System.out.println("-------salsql------" + salsql);
             ResultSet resultSet = stmtVeh.executeQuery(salsql);
            RESULTDATA = objcommon.convertToJSON(resultSet);
            stmtVeh.close();
            conn.close();
        }
        catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }
        finally{
        	conn.close();
        }
        return RESULTDATA;
    }
    
    public JSONArray agentloading( String docno) throws SQLException {
        JSONArray RESULTDATA = new JSONArray();
        Connection conn = null;
        try {
            conn = objconn.getMyConnection();
             Statement stmtVeh = conn.createStatement();
             String salsql = "select   d.sal_name agent,m.sal_id salid,cper commperc,camount commamount from rl_tncagent m left join my_salesman d on (d.doc_no=m.sal_id and d.sal_type='SLA')  where m.rdocno='" + docno + "' ";
            System.out.println("-------salsql------" + salsql);
             ResultSet resultSet = stmtVeh.executeQuery(salsql);
            RESULTDATA = objcommon.convertToJSON(resultSet);
            stmtVeh.close();
            conn.close();
        }
        catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }
        finally{
        	conn.close();
        }
        return RESULTDATA;
    }
    
    public JSONArray termsloading( String docno) throws SQLException {
        JSONArray RESULTDATA = new JSONArray();
        Connection conn = null;
        try {
            conn = objconn.getMyConnection();
             Statement stmtVeh = conn.createStatement();
             String salsql = "select * from (select m.idno docno, m.description, m.acno,d.amount,m.tax,d.taxtype,d.taxvalue,d.nettotal from rl_tncterms d  left join rl_terms_contract m on d.idno=m.idno where d.rdocno='" + docno + "' " + " union all select m.idno docno, m.description, m.acno,d.amount,m.tax,d.taxtype,d.taxvalue,d.nettotal from rl_terms_contract m " + " left join rl_tncterms d on d.idno=m.idno and d.rdocno='" + docno + "' where    d.idno is  null  ) a order by a.docno  ";
            System.out.println("-------salsql------" + salsql);
             ResultSet resultSet = stmtVeh.executeQuery(salsql);
            RESULTDATA = objcommon.convertToJSON(resultSet);
            stmtVeh.close();
            conn.close();
        }
        catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }
        finally{
        	conn.close();
        }
        return RESULTDATA;
    }
    
    public JSONArray termsloading() throws SQLException {
        JSONArray RESULTDATA = new JSONArray();
        Connection conn = null;
        try {
            conn = objconn.getMyConnection();
             Statement stmtVeh = conn.createStatement();
             String salsql = "select idno docno, description, acno,tax from rl_terms_contract where status=1 ";
             ResultSet resultSet = stmtVeh.executeQuery(salsql);
            RESULTDATA = objcommon.convertToJSON(resultSet);
            stmtVeh.close();
            conn.close();
        }
        catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }
        finally{
        	conn.close();
        }
        return RESULTDATA;
    }
    
    public JSONArray SalesgentSearch() throws SQLException {
        JSONArray RESULTDATA = new JSONArray();
        Connection conn = null;
        try {
            conn = objconn.getMyConnection();
            Statement stmtVeh = conn.createStatement();
            String salsql = "select doc_no,sal_name  from my_salesman where sal_type='SLA' and status<>7 and activestatus='A';";
            ResultSet resultSet = stmtVeh.executeQuery(salsql);
            RESULTDATA = objcommon.convertToJSON(resultSet);
            stmtVeh.close();
            conn.close();
        }
        catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }
        finally{
        	conn.close();
        }
        return RESULTDATA;
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
                 String pySql = " select if(coalesce(m.mgprpty,0)=1,'Managed','Unmanaged') strmanage,coalesce(o.tele_phn,'') ownertel,coalesce(o.mobile,'') ownermobile,coalesce(o.email,'') owneremail,coalesce(if(m.terms_rentcommisiomperc='',0,round(m.terms_rentcommisiomperc,2)),0) mgmtfeevalue,coalesce(if(m.terms_mangfeeperc='',0,round(m.terms_mangfeeperc,2)),0) mgmtfeepercent,m.tenancy_cheque_owner_name chktenancychequeowner,m.prid propertyid,m.unitno,m.optid,m.doc_no, m.voc_no,  m.date, accname as name,  o.primary_owner  owner,desc1,if(m.cnt_no>0,'RENTED','AVAILABLE') type, convert(if(m.cnt_no>0,DATE_ADD(cnt_date, INTERVAL 1 DAY),''),char(100)) adate, m.terms_mangfeeperc as mngperc  from rl_propertymaster m left join rl_propertryowner o on o.doc_no=m.owid where m.status=3 and m.active=1 and m.cnt_no=0  " + sqltest + " group by m.doc_no ";
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
        finally{
        	conn.close();
        }
    }
    
    public JSONArray materearch( HttpSession session,  String docnoss,  String own,  String pname,  String datess,  String aa,  String descriptions,  String unitno,String brhid) throws SQLException {
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
            sqltest = String.valueOf(sqltest) + " and  m.voc_no like '%" + docnoss + "%'";
        }
        if (!own.equalsIgnoreCase("") && !own.equalsIgnoreCase("NA")) {
            sqltest = String.valueOf(sqltest) + " and a.refname like '%" + own + "%'  ";
        }
        if (!unitno.equalsIgnoreCase("") && !unitno.equalsIgnoreCase("NA")) {
            sqltest = String.valueOf(sqltest) + " and pm.unitno='" + unitno + "'  ";
        }
        if (!pname.equalsIgnoreCase("") && !pname.equalsIgnoreCase("NA")) {
            sqltest = String.valueOf(sqltest) + " and pm.accname like '%" + pname + "%'";
        }
        if (sqlStartDate != null) {
            sqltest = String.valueOf(sqltest) + " and m.date='" + sqlStartDate + "'";
        }
        
        if(!brhid.trim().equalsIgnoreCase("") && !brhid.trim().equalsIgnoreCase("a")) {
        	sqltest+=" and m.brhid="+brhid;
        }
        Connection conn = null;
        try {
            conn = objconn.getMyConnection();
            if (aa.equalsIgnoreCase("yes")) {
                 Statement stmtmain = conn.createStatement();
                 String pySql = " select coalesce(pm.unitno,'') unitno,m.doc_no,m.date,m.voc_no , m.ttype , m.cldocno,a.refname,pm.accname as pname, pm.prid, m.prtype, m.Period, m.Period_no, m.Period_from, m.Period_to, m.not_Period ,a.com_mob as tel,a.per_mob as mob,a.mail1 as email,po.primary_owner as owner from rl_tncm  m  left join rl_propertymaster pm on pm.doc_no=m.prtype left join rl_propertryowner po on po.doc_no=pm.owid left join my_acbook a on a.acno=m.acno  where m.status=3   " + sqltest + " order by m.doc_no";
                System.out.println("tenanacysearchquery == " + pySql);
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
        finally{
        	conn.close();
        }
    }
    
    public int savemaster( Date masterdate, int docno,  String mode,  int cmbtenancytype,  int txttenantdocno,  int txtpropertydocno,  
    		int cmbcontractperiod,  int txtcontractperiod,  Date fromdate,  Date todate,  int txtnotificationperiod,  HttpSession session,  
    		HttpServletRequest request,  String formdetailcode,  ArrayList<String> termarr,  ArrayList<String> agentarr,  
    		ArrayList<String> paymentarr,  String commisionperc,  String commisionamt,  String nettotal,  String mngper,  String mngval,  
    		String owneradminfee,  String ownertotal,  String numcheque,  ArrayList<String> mngfeearr,  String mngfeeinstalmnt, 
    		String cmbcommvattype,String commvatamount,String cmbmgmtvattype,String mgmtvatamount,String mgmtnettotal,String holdingsecurity,
    		String hidchkvatdistributed, String renewalstatus, String contractdocno) throws SQLException {
        	Connection conn=null;
    	try {
        	//hidchkvatdistributed=hidchkvatdistributed.equalsIgnoreCase("")?"0":"1";
            if(hidchkvatdistributed.trim().equalsIgnoreCase("")){
            	hidchkvatdistributed="0";
            }
            
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
            if(renewalstatus.equalsIgnoreCase("1")){
            	Statement stmtrenewal=conn.createStatement();
            	String strupdatemaster="update rl_tncm set clstatus=1 where doc_no="+contractdocno;
            	System.out.println(strupdatemaster);
            	int updatemaster=stmtrenewal.executeUpdate(strupdatemaster);
            	if(updatemaster<=0){
            		// return 0;
            	}
            	String strgetproperty="select prtype from rl_tncm where status=3 and doc_no="+contractdocno;
            	System.out.println(strgetproperty);
            	ResultSet rsgetproperty=stmtrenewal.executeQuery(strgetproperty);
            	int propdoco=0;
            	while(rsgetproperty.next()){
            		propdoco=rsgetproperty.getInt("prtype");
            	}
            	String strupdateproperty="update rl_propertymaster set cnt_no=0,cnt_date=null where doc_no="+propdoco+" and cnt_no="+contractdocno;
            	System.out.println(strupdateproperty);
            	int updateproperty=stmtrenewal.executeUpdate(strupdateproperty);
            	if(updateproperty<=0){
            		// return 0;
            	}
            	String strloginsert="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+contractdocno+"','"+session.getAttribute("BRANCHID").toString()+"','TCCL',now(),'"+session.getAttribute("USERID").toString()+"','A')";
            	int loginsert=stmtrenewal.executeUpdate(strloginsert);
            	if(loginsert<=0){
            		// return 0;
            	}
            }
            CallableStatement s = conn.prepareCall("{CALL rl_TenancyContractDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            System.out.println("mode==" + mode);
            if (mode.equalsIgnoreCase("A")) {
                s.registerOutParameter(24, java.sql.Types.INTEGER);
            }
            else {
                s.setInt(24, docno);
            }
            s.setDate(1, masterdate);
            s.setInt(2, cmbtenancytype);
            s.setInt(3, txttenantdocno);
            s.setInt(4, txtpropertydocno);
            s.setString(5, session.getAttribute("BRANCHID").toString());
            s.setString(6, session.getAttribute("USERID").toString());
            s.setString(7, session.getAttribute("COMPANYID").toString());
            s.setInt(8, cmbcontractperiod);
            s.setInt(9, txtcontractperiod);
            s.setDate(10, fromdate);
            s.setDate(11, todate);
            s.setInt(12, txtnotificationperiod);
            s.setString(13, mode);
            s.setString(14, formdetailcode);
            s.setString(15, commisionperc.equalsIgnoreCase("") ? "0" : commisionperc);
            s.setString(16, commisionamt.equalsIgnoreCase("") ? "0" : commisionamt);
            s.setString(17, nettotal.equalsIgnoreCase("") ? "0" : nettotal);
            s.setString(18, mngper.equalsIgnoreCase("") ? "0" : mngper);
            s.setString(19, mngval.equalsIgnoreCase("") ? "0" : mngval);
            s.setString(20, owneradminfee.equalsIgnoreCase("") ? "0" : owneradminfee);
            s.setString(21, ownertotal.equalsIgnoreCase("") ? "0" : ownertotal);
            s.setString(22, numcheque.equalsIgnoreCase("") ? "0" : numcheque);
            s.setString(23, mngfeeinstalmnt.equalsIgnoreCase("") ? "1" : mngfeeinstalmnt);
            System.out.println("Saving query = " + s);
             int val = s.executeUpdate();
            docno = s.getInt("docNo");
            System.out.println("==============docno========" + docno);
            if(docno>0){
            	if(!mode.equalsIgnoreCase("D")){
            		if(renewalstatus.equalsIgnoreCase("1")){
            			// ,renewalstatus=8,renewalremarks='Auto Renewal'
                		String strupdatemaster="update rl_tncm set renewaldocno="+docno+" where doc_no="+contractdocno;
                		int updatemaster=s.executeUpdate(strupdatemaster);
                		if(updatemaster<=0){
                			return 0;
                		}
                	}
                	commvatamount=commvatamount.equalsIgnoreCase("")?"0":commvatamount;
                	nettotal=nettotal.equalsIgnoreCase("")?"0":nettotal;
                	mgmtvatamount=mgmtvatamount.equalsIgnoreCase("")?"0":mgmtvatamount;
                	mgmtnettotal=mgmtnettotal.equalsIgnoreCase("")?"0":mgmtnettotal;
                	holdingsecurity=holdingsecurity.equalsIgnoreCase("")?"0":holdingsecurity;
                	String strsql="update rl_tncm set chkvatdistributed="+hidchkvatdistributed+",commissionvattype='"+cmbcommvattype+"',commissionvatvalue="+commvatamount+",commissiontaxtotal="+nettotal+",mgmtvattype='"+cmbmgmtvattype+"',mgmtvatvalue="+mgmtvatamount+",mgmttaxtotal="+mgmtnettotal+",holdingsecurity="+holdingsecurity+" where doc_no="+docno+" and status=3 and brhid="+session.getAttribute("BRANCHID").toString();
                	System.out.println("Update Query:"+strsql);
                	int update=s.executeUpdate(strsql);
                	if(update<=0){
                		return 0;
                	}
            	}
            	
            	//Update ins_date=contract start+ period if inspection is for Tenant
    			//update on 20-04-2020
            	if(!mode.equalsIgnoreCase("D")){
            		Statement stmt=conn.createStatement();
        			String strgetpropdetails="select terms_insptype inspinterval,terms_insasper inspfor from rl_propertymaster where doc_no="+txtpropertydocno;
        			String inspinterval="",inspfor="";
        			ResultSet rsgetpropdetails=stmt.executeQuery(strgetpropdetails);
        			while(rsgetpropdetails.next()){
        				inspinterval=rsgetpropdetails.getString("inspinterval");
        				inspfor=rsgetpropdetails.getString("inspfor");
        			}
        			int inspintervalno=0;
        			if(inspinterval.trim().equalsIgnoreCase("Q")){
        				inspintervalno=3;
        			}
        			else if(inspinterval.trim().equalsIgnoreCase("M")){
        				inspintervalno=1;
        			}
        			else if(inspinterval.trim().equalsIgnoreCase("HY")){
        				inspintervalno=6;
        			}
        			if(inspfor.trim().equalsIgnoreCase("T")){
        				java.sql.Date sqlnextinsp=null;
        				String strgetnextinsp="select date_add(period_from,interval "+inspintervalno+" month) nextinspdate from rl_tncm where doc_no="+docno;
        				ResultSet rsgetnextinsp=stmt.executeQuery(strgetnextinsp);
        				while(rsgetnextinsp.next()){
        					sqlnextinsp=rsgetnextinsp.getDate("nextinspdate");
        				}
        				String strupdateproperty="update rl_propertymaster set ins_date='"+sqlnextinsp+"' where doc_no="+txtpropertydocno;
        				System.out.println(strupdateproperty);
        				int updateproperty=stmt.executeUpdate(strupdateproperty);
        				if(updateproperty<0){
        					conn.close();
        				}
        			}
            	}
            	
            }
            if (val > 0 && docno > 0) {
                if (!mode.equalsIgnoreCase("D")) {
                    for (int i = 0; i < termarr.size(); ++i) {
                        if (i == 0 && mode.equalsIgnoreCase("E")) {
                             String sqls = "delete from rl_tncterms where rdocno=" + docno + "  ";
                            s.executeUpdate(sqls);
                        }
                         String[] ar = termarr.get(i).split("::");
                        if (!ar[1].trim().equalsIgnoreCase("undefined") && !ar[1].trim().equalsIgnoreCase("0") && !ar[1].trim().equalsIgnoreCase("") && !ar[1].trim().equalsIgnoreCase("NaN") && !ar[1].isEmpty()) {
                            String tax= ar[4].trim().equalsIgnoreCase("undefined") || ar[4].trim().equalsIgnoreCase("") || ar[4]==null || ar[4].isEmpty()?"0":ar[4];
                            String taxtype= ar[5].trim().equalsIgnoreCase("undefined") || ar[5].trim().equalsIgnoreCase("") || ar[5]==null || ar[5].isEmpty()?"0":ar[5];
                            String taxvalue= ar[6].trim().equalsIgnoreCase("undefined") || ar[6].trim().equalsIgnoreCase("") || ar[6]==null || ar[6].isEmpty()?"0":ar[6];
                            String contractnettotal= ar[7].trim().equalsIgnoreCase("undefined") || ar[7].trim().equalsIgnoreCase("") || ar[7]==null || ar[7].isEmpty()?"0":ar[7];
                            String sql = "insert into rl_tncterms(rdocno,slno,idno, amount,tax,taxtype,taxvalue,nettotal)values(" + docno + "," + (i + 1) + "," + "'" + ((ar[0].trim().equalsIgnoreCase("undefined") || ar[0].trim().equalsIgnoreCase("") || ar[0].trim().equalsIgnoreCase("NaN") || ar[0].isEmpty()) ? Integer.valueOf(0) : ar[0].trim()) + "'," + "'" + ((ar[1].trim().equalsIgnoreCase("undefined") || ar[1].trim().equalsIgnoreCase("") || ar[1].trim().equalsIgnoreCase("NaN") || ar[1].isEmpty()) ? Integer.valueOf(0) : ar[1].trim()) + "',"+tax+",'"+taxtype+"',"+taxvalue+","+contractnettotal+")";
                            System.out.println("Insert Terms:"+sql);
                            int aa = s.executeUpdate(sql);
                            if (aa <= 0) {
                                conn.close();
                                return 0;
                            }
                        }
                    }
                    for (int i = 0; i < agentarr.size(); ++i) {
                        if (i == 0 && mode.equalsIgnoreCase("E")) {
                             String sqls = "delete from rl_tncagent where rdocno=" + docno + "  ";
                            s.executeUpdate(sqls);
                        }
                         String[] ar2 = agentarr.get(i).split("::");
                        if (!ar2[0].trim().equalsIgnoreCase("undefined") && !ar2[0].trim().equalsIgnoreCase("0") && !ar2[0].trim().equalsIgnoreCase("") && !ar2[0].trim().equalsIgnoreCase("NaN") && !ar2[0].isEmpty()) {
                             String sql = "insert into rl_tncagent(rdocno,slno,sal_id, cper, camount)values(" + docno + "," + (i + 1) + "," + "'" + ((ar2[0].trim().equalsIgnoreCase("undefined") || ar2[0].trim().equalsIgnoreCase("") || ar2[0].trim().equalsIgnoreCase("NaN") || ar2[0].isEmpty()) ? Integer.valueOf(0) : ar2[0].trim()) + "'," + "'" + ((ar2[1].trim().equalsIgnoreCase("undefined") || ar2[1].trim().equalsIgnoreCase("") || ar2[1].trim().equalsIgnoreCase("NaN") || ar2[1].isEmpty()) ? Integer.valueOf(0) : ar2[1].trim()) + "'," + "'" + ((ar2[2].trim().equalsIgnoreCase("undefined") || ar2[2].trim().equalsIgnoreCase("") || ar2[2].trim().equalsIgnoreCase("NaN") || ar2[2].isEmpty()) ? Integer.valueOf(0) : ar2[2].trim()) + "' ) ";
                            System.out.println("=========sql=====" + sql);
                             int aa = s.executeUpdate(sql);
                            if (aa <= 0) {
                                conn.close();
                                return 0;
                            }
                        }
                    }
                    for (int i = 0; i < paymentarr.size(); ++i) {
                        if (i == 0 && mode.equalsIgnoreCase("E")) {
                             String sqls = "delete from rl_tncpayment where rdocno=" + docno + "  ";
                            s.executeUpdate(sqls);
                        }
                         String[] ar3 = paymentarr.get(i).split("::");
                        if (!ar3[1].trim().equalsIgnoreCase("undefined") && !ar3[1].trim().equalsIgnoreCase("0") && !ar3[1].trim().equalsIgnoreCase("") && !ar3[1].trim().equalsIgnoreCase("NaN") && !ar3[1].isEmpty()) {
                            String bank=(ar3[7].trim().equalsIgnoreCase("undefined") || ar3[7].trim().equalsIgnoreCase("") || ar3[7].trim().equalsIgnoreCase("NaN") || ar3[7].isEmpty()) ? "" : ar3[7].trim();
                            String payment=(ar3[6].trim().equalsIgnoreCase("undefined") || ar3[6].trim().equalsIgnoreCase("") || ar3[6].trim().equalsIgnoreCase("NaN") || ar3[6].isEmpty()) ? "" : ar3[6].trim();
                            String paidto=(ar3[5].trim().equalsIgnoreCase("undefined") || ar3[5].trim().equalsIgnoreCase("") || ar3[5].trim().equalsIgnoreCase("NaN") || ar3[5].isEmpty()) ? "" : ar3[5].trim();
                            String chequeno=(ar3[4].trim().equalsIgnoreCase("undefined") || ar3[4].trim().equalsIgnoreCase("") || ar3[4].trim().equalsIgnoreCase("NaN") || ar3[4].isEmpty()) ? "0" : ar3[4].trim();
                            String notes=(ar3[3].trim().equalsIgnoreCase("undefined") || ar3[3].trim().equalsIgnoreCase("") || ar3[3].trim().equalsIgnoreCase("NaN") || ar3[3].isEmpty()) ? "" : ar3[3].trim();
                            String pamount=(ar3[2].trim().equalsIgnoreCase("undefined") || ar3[2].trim().equalsIgnoreCase("") || ar3[2].trim().equalsIgnoreCase("NaN") || ar3[2].isEmpty()) ? "0" : ar3[2].trim();
                        	java.sql.Date sqlpaymentdate=null;
                        	if(!ar3[1].trim().equalsIgnoreCase("undefined") && !ar3[1].trim().equalsIgnoreCase("") && !ar3[1].trim().equalsIgnoreCase("NaN") && !ar3[1].isEmpty()){
                        		sqlpaymentdate=objcommon.changeStringtoSqlDate(ar3[1].trim());
                        	}
                        	String desc=(ar3[0].trim().equalsIgnoreCase("undefined") || ar3[0].trim().equalsIgnoreCase("") || ar3[0].trim().equalsIgnoreCase("NaN") || ar3[0].isEmpty()) ? "" : ar3[0].trim();
                            //String sql = "insert into rl_tncpayment(rdocno,slno, desc1, date, pamount, notes, chqno, paidto, payment, bank)values(" + docno + "," + (i + 1) + "," + "'" + ((ar3[0].trim().equalsIgnoreCase("undefined") || ar3[0].trim().equalsIgnoreCase("") || ar3[0].trim().equalsIgnoreCase("NaN") || ar3[0].isEmpty()) ? Integer.valueOf(0) : ar3[0].trim()) + "'," + "'" + ((ar3[1].trim().equalsIgnoreCase("undefined") || ar3[1].trim().equalsIgnoreCase("") || ar3[1].trim().equalsIgnoreCase("NaN") || ar3[1].isEmpty()) ? Integer.valueOf(0) : objcommon.changeStringtoSqlDate(ar3[1].trim())) + "'," + "'" + ((ar3[2].trim().equalsIgnoreCase("undefined") || ar3[2].trim().equalsIgnoreCase("") || ar3[2].trim().equalsIgnoreCase("NaN") || ar3[2].isEmpty()) ? Integer.valueOf(0) : ar3[2].trim()) + "'," + "'" + ((ar3[3].trim().equalsIgnoreCase("undefined") || ar3[3].trim().equalsIgnoreCase("") || ar3[3].trim().equalsIgnoreCase("NaN") || ar3[3].isEmpty()) ? Integer.valueOf(0) : ar3[3].trim()) + "'," + "'" + ((ar3[4].trim().equalsIgnoreCase("undefined") || ar3[4].trim().equalsIgnoreCase("") || ar3[4].trim().equalsIgnoreCase("NaN") || ar3[4].isEmpty()) ? Integer.valueOf(0) : ar3[4].trim()) + "'," + "'" + ((ar3[5].trim().equalsIgnoreCase("undefined") || ar3[5].trim().equalsIgnoreCase("") || ar3[5].trim().equalsIgnoreCase("NaN") || ar3[5].isEmpty()) ? Integer.valueOf(0) : ar3[5].trim()) + "'," + "'" + ((ar3[6].trim().equalsIgnoreCase("undefined") || ar3[6].trim().equalsIgnoreCase("") || ar3[6].trim().equalsIgnoreCase("NaN") || ar3[6].isEmpty()) ? Integer.valueOf(0) : ar3[6].trim()) + "'," + "'" + ((ar3[7].trim().equalsIgnoreCase("undefined") || ar3[7].trim().equalsIgnoreCase("") || ar3[7].trim().equalsIgnoreCase("NaN") || ar3[7].isEmpty()) ? Integer.valueOf(0) : ar3[7].trim()) + "'    ) ";
                        	if(payment.equalsIgnoreCase("Cash")){
                        		paidto="Self";
                        	}
                        	String sql = "";
                        	if(sqlpaymentdate!=null){
                        		sql="insert into rl_tncpayment(rdocno,slno, desc1, date, pamount, notes, chqno, paidto, payment, bank)values("+docno+","+(i+1)+",'"+desc+"','"+sqlpaymentdate+"',"+pamount+",'"+notes+"','"+chequeno+"','"+paidto+"','"+payment+"','"+bank+"')";
                        	}
                        	else{
                        		sql="insert into rl_tncpayment(rdocno,slno, desc1, date, pamount, notes, chqno, paidto, payment, bank)values("+docno+","+(i+1)+",'"+desc+"',"+sqlpaymentdate+","+pamount+",'"+notes+"','"+chequeno+"','"+paidto+"','"+payment+"','"+bank+"')";
                        	}
                        	System.out.println("===sql=====" + sql);
                            int aa = s.executeUpdate(sql);
                            if (aa <= 0) {
                                conn.close();
                                return 0;
                            }
                        }
                    }
                    for (int i = 0; i < mngfeearr.size(); ++i) {
                        if (i == 0 && mode.equalsIgnoreCase("E")) {
                             String sqls = "delete from rl_tncmanagefee where tdoc_no=" + docno + "  ";
                            s.executeUpdate(sqls);
                        }
                         String[] ar2 = mngfeearr.get(i).split("::");
                        Date mngfeedate = null;
                        if (!ar2[0].trim().equalsIgnoreCase("undefined") && !ar2[0].trim().equalsIgnoreCase("0") && !ar2[0].trim().equalsIgnoreCase("") && !ar2[0].trim().equalsIgnoreCase("NaN") && !ar2[0].isEmpty()) {
                             String date1 = ar2[0].toString();
                            mngfeedate = objcommon.changetstmptoSqlDate(date1);
                            System.out.println(mngfeedate);
                             String sql2 = "insert into rl_tncmanagefee(tdoc_no,date,amount)values(" + docno + "," + "'" + mngfeedate + "'," + "'" + ((ar2[1].trim().equalsIgnoreCase("undefined") || ar2[1].trim().equalsIgnoreCase("") || ar2[1].trim().equalsIgnoreCase("NaN") || ar2[1].isEmpty()) ? Integer.valueOf(0) : ar2[1].trim()) + "' ) ";
                            System.out.println("=========sql=====" + sql2);
                             int aa2 = s.executeUpdate(sql2);
                            if (aa2 <= 0) {
                                conn.close();
                                return 0;
                            }
                        }
                    }
                    if (mode.equalsIgnoreCase("A")) {
                         String sql3 = "select voc_no from rl_tncm where doc_no=" + docno + " ";
                         ResultSet rs = s.executeQuery(sql3);
                        if (rs.first()) {
                            request.setAttribute("vocno", (Object)rs.getInt("voc_no"));
                        }
                    }
                }
                conn.commit();
                conn.close();
                return docno;
            }
        }
        catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }
    	finally{
        	conn.close();
        }
        return 0;
    }
    
    public ClsTenancyContractBean getData( int docno,  HttpSession session) throws SQLException {
         ClsTenancyContractBean temp = new ClsTenancyContractBean();
        Connection conn = null;
        try {
            conn = objconn.getMyConnection();
             Statement stmt = conn.createStatement();
             String sqls = "select m.doc_no masterdocno,if(coalesce(pm.mgprpty,0)=1,'Managed','Unmanaged') strmanage,coalesce(po.tele_phn,'') ownertel,coalesce(po.mobile,'') ownermobile,coalesce(po.email,'') owneremail,coalesce(pusr.user_name,'') posteduser,coalesce(cusr.user_name,'') createduser,chkvatdistributed,coalesce(pm.tenancy_cheque_owner_name,'') Chktenancychequeowner,coalesce(m.commissionvattype,'') commissionvattype,round(coalesce(m.commissionvatvalue,0.0),2) commissionvatvalue,"+
             " round(coalesce(m.commissiontaxtotal,0.0),2) commissiontaxtotal,coalesce(m.mgmtvattype,'') mgmtvattype,round(coalesce(m.mgmtvatvalue,0.0),2) "+
             " mgmtvatvalue,round(coalesce(m.mgmttaxtotal,0.0),2) mgmttaxtotal,round(coalesce(m.holdingsecurity,0.0),2) holdingsecurity,m.date,"+
             " m.ttype , m.cldocno,a.refname,pm.accname as pname, pm.prid,m.prtype, m.Period, m.Period_no, m.Period_from, m.Period_to, m.not_Period,"+
             " a.com_mob as tel,a.per_mob as mob,a.mail1 as email,po.primary_owner as owner,m.commisionperc,m.commisionamt,m.nettotal,"+
             " m.managementper,m.managementamt,m.owneradminfee,m.ownertotal,m.Numofcheque,mngfeeinstalmnt from rl_tncm  m left join rl_propertymaster "+
             " pm on pm.doc_no=m.prtype left join rl_propertryowner po on po.doc_no=pm.owid  left join my_acbook a on a.acno=m.acno left join "+
             " my_user cusr on m.userid=cusr.doc_no left join rl_prinvm inv on reftype='TNC' and inv.doc_no=m.pstatus"+
             " left join my_user pusr on inv.userid=pusr.doc_no where m.status=3 and m.voc_no=" + docno + " and m.brhid='" + session.getAttribute("BRANCHID").toString() + "' ";
            
             //left join (select acno,userid,refno from rl_prinvm where reftype='TNC' and refno="+docno+") inv on (inv.refno=m.doc_no and inv.acno=m.acno)
             
             //System.out.println("get tenant="+sqls);
             ResultSet rss = stmt.executeQuery(sqls);
             if(rss.first()){
            	if(!rss.getString("posteduser").equalsIgnoreCase("")){
            		temp.setLblpostedby("Posted By "+rss.getString("posteduser"));
            	}
            	temp.setLblcreatedby("Created By "+rss.getString("createduser"));
            	temp.setMasterdoc_no(rss.getInt("masterdocno"));
            	temp.setHidchkvatdistributed(rss.getString("chkvatdistributed"));
            	temp.setChktenancychequeowner(rss.getString("Chktenancychequeowner"));
            	temp.setHidcmbcommvattype(rss.getString("commissionvattype"));
            	temp.setCommvatamount(rss.getString("commissionvatvalue"));
            	temp.setHidcmbmgmtvattype(rss.getString("mgmtvattype"));
            	temp.setMgmtvatamount(rss.getString("mgmtvatvalue"));
            	temp.setMgmtnettotal(rss.getString("mgmttaxtotal"));
            	temp.setHoldingsecurity(rss.getString("holdingsecurity"));
                temp.setTenancyContractDate(rss.getDate("date").toString());
                temp.setTxttenant(rss.getString("refname"));
                temp.setTxttenantdocno(rss.getInt("cldocno"));
                temp.setTxtproperty(rss.getString("pname"));
                temp.setTxtpropertydocno(rss.getInt("prtype"));
                temp.setHidcmbtenancytype(rss.getInt("ttype"));
                temp.setHidcmbcontractperiod(rss.getInt("Period"));
                temp.setTxtcontractperiod(rss.getInt("Period_no"));
                temp.setPeriodFromDate(rss.getDate("Period_from").toString());
                temp.setPeriodToDate(rss.getDate("Period_to").toString());
                temp.setTxtnotificationperiod(rss.getInt("not_Period"));
                temp.setLblmanage(rss.getString("strmanage"));
                 String tdet = (String.valueOf(rss.getString("refname")) + "\nTel: " + rss.getString("tel") + "\nMob: " + rss.getString("mob") + "\nEmail: " + rss.getString("email")).toString();
                temp.setTenantdet(tdet);
                String pdet = (String.valueOf(rss.getString("prid")) + "\nOwner: " + rss.getString("owner") + "\nTel: " + rss.getString("ownertel") + "\nMobile: " + rss.getString("ownermobile") + "\nEmail: " + rss.getString("owneremail")).toString();
                temp.setPropertydet(pdet);
                temp.setTxtcommisionperc(rss.getString("commisionperc"));
                temp.setTxtcommisionval(rss.getString("commisionamt"));
                temp.setTxtnettotal(rss.getString("nettotal"));
                temp.setTxtmanagementperc(rss.getString("managementper"));
                temp.setTxtmanagementval(rss.getString("managementamt"));
                temp.setTxtadminfeeowner(rss.getString("owneradminfee"));
                temp.setTxtownertotal(rss.getString("ownertotal"));
                temp.setTxtnumofcheque(rss.getString("Numofcheque"));
                temp.setTxtmngfeeinstmnt(rss.getString("mngfeeinstalmnt"));
            }
        }
        catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }
        finally{
        	conn.close();
        }
        return temp;
    }
    
    public ClsTenancyContractBean getPrint( int docno,  HttpServletRequest request,  HttpSession session,int print) throws SQLException {
        ClsTenancyContractBean bean = new ClsTenancyContractBean();
       Connection conn = null;
       try {
           conn = objconn.getMyConnection();
            Statement stmtprint = conn.createStatement();
            String sql = "select  m.doc_no masterdocno,pm.accname as pname,coalesce(pm.mgprpty,0)mgprpty,coalesce(br.tinno,0)tinno,coalesce(pm.tenancy_cheque_owner_name,'') Chktenancychequeowner, coalesce(m.commissionvattype,'') commissionvattype,round(coalesce(m.commissionvatvalue,0.0),2) commissionvatvalue,"+
            " round(coalesce(m.commissiontaxtotal,0.0),2) commissiontaxtotal,coalesce(m.mgmtvattype,'') mgmtvattype,round(coalesce(m.mgmtvatvalue,0.0),2) "+
            " mgmtvatvalue,round(coalesce(m.mgmttaxtotal,0.0),2) mgmttaxtotal,round(coalesce(m.holdingsecurity,0.0),2) holdingsecurity,date_format(m.date,'%d-%m-%Y') date,m.voc_no contractno,po.primary_owner landlord,ac.refname tenant,ac.address,ac.trnnumber clienttrn, convert(concat(m.Period_no,'  ',if(m.Period=1,'YEAR','MONTH'),if(m.Period_no>1,'S','')),char(100)) period, convert(concat(pm.unitno,' , ',ut.unittype),char(100)) subject,if(m.ttype=1,'RESIDENCE','COMMERCIAL') purpose,date_format(m.period_from,'%d.%m.%Y')period_from,date_format(m.period_to,'%d.%m.%Y')period_to, format(tr.amount,2) rent,round(tr.amount,2) rentword,po.mobile contactno,pm.pre_no,pm.elec_water,bm.plno,pm.area, date_format(cdp.expdt,'%d-%m-%Y') passportexp,date_format(cdv.expdt,'%d-%m-%Y') visaexp,date_format(cdt.expdt,'%d-%m-%Y') tradeexp,format(coalesce(ts.amount,0),2) security from rl_tncm m left join rl_propertryowner po on m.acno=po.acno left join my_acbook ac on m.cldocno=ac.cldocno and ac.dtype='CRM'  left join my_brch br on m.brhid=br.doc_no left join rl_propertymaster pm on pm.doc_no=m.prtype left join rl_unittype ut on pm.unitof=ut.doc_no left join (select amount,idno,rdocno from rl_tncterms) tr on tr.rdocno=m.doc_no and tr.idno=1 left join (select amount,idno,rdocno from rl_tncterms) ts on ts.rdocno=m.doc_no and ts.idno=2 left join rl_buildingm bm on bm.doc_no=pm.unitof left join (select docid,expdt,cldocno from rl_cldoc) cdp on cdp.cldocno=m.cldocno and cdp.docid=1 left join (select docid,expdt,cldocno from rl_cldoc) cdv on cdv.cldocno=m.cldocno and cdv.docid=2 left join (select docid,expdt,cldocno from rl_cldoc) cdt on cdt.cldocno=m.cldocno and cdt.docid=4 where m.status=3 and m.doc_no=" + docno;
            System.out.println("master qry======"+sql);
            ResultSet printrs = stmtprint.executeQuery(sql);
           while (printrs.next()) {
           	bean.setChktenancychequeowner(printrs.getString("Chktenancychequeowner"));
           		bean.setMasterdoc_no(printrs.getInt("masterdocno"));
               bean.setLbldate(printrs.getString("date"));
               bean.setLblcontractno(printrs.getString("contractno"));
               bean.setLbllandlord(printrs.getString("landlord"));
               bean.setLbltenant(printrs.getString("tenant"));
               bean.setLblperiodtenancy(printrs.getString("period"));
               bean.setLblpurposetenancy(printrs.getString("purpose"));
               bean.setLblsubjecttenancy(printrs.getString("subject"));
               bean.setLblfrom(printrs.getString("period_from"));
               bean.setLblto(printrs.getString("period_to"));
               bean.setLblrent(printrs.getString("rent"));
               
               bean.setLblcontactno(printrs.getString("contactno"));
               bean.setLblpremisesno(printrs.getString("pre_no"));
               bean.setLbldewano(printrs.getString("elec_water"));
               bean.setLblplotno(printrs.getString("plno"));
               bean.setLblarea(printrs.getString("area"));
               bean.setLblpassportexp(printrs.getString("passportexp"));
               bean.setLblvisaexp(printrs.getString("visaexp"));
               bean.setLbltradelicenseexp(printrs.getString("tradeexp"));
               bean.setLblsecurity(printrs.getString("security"));
               bean.setLbltinno(printrs.getString("tinno"));
               bean.setLbladdress(printrs.getString("address"));
               bean.setLblcltrno(printrs.getString("clienttrn"));
               bean.setLblmgtype(printrs.getString("mgprpty"));
               bean.setLblpropname(printrs.getString("pname"));
           }
           System.out.println("security====" + bean.getLblsecurity());
            String sqlcontract = "select @s:=@s+1 sl,case when idno=1 then 'Rental Value' when idno=2 then 'Security Deposit'when idno=3 then 'Electricity' when idno=4 then 'GAS' when idno=5 then 'Chiller' when idno=6 then 'Admin Fee'when idno=7 then 'others' end as description,format(amount,2) amount from (select @s:=0) s,rl_tncterms tnc where rdocno=" + docno;
            ResultSet contractrs = stmtprint.executeQuery(sqlcontract);
            ArrayList<String> arr = new ArrayList<String>();
           while (contractrs.next()) {
               String temp = "";
               temp = String.valueOf(contractrs.getString("sl")) + "::" + contractrs.getString("description") + "::" + contractrs.getString("amount");
               arr.add(temp);
           }
           contractrs.close();
           request.setAttribute("contractdetails", (Object)arr);
           /*String salsql ="select @i:=@i+1 rws,a.* from(select m.description,case when d.taxtype='Inclusive' then round(d.amount-d.taxvalue,2) else round(d.amount,2) end"
           		+" amount,if(d.taxvalue>0,5,0) taxrate,round(d.taxvalue,2) vatamt,round(d.nettotal,2) nettotal from rl_tncterms d  left join "
           		+"rl_terms_contract m on d.idno=m.idno where d.rdocno='"+docno+"')a,(SELECT @i:=0)c";*/
          /* String salsql ="select @i:=@i+1 rws,a.* from("+
                   " select x.description,round(x.amount,2) amount,if(x.taxvalue>0.0,5.0,0.0) taxrate,round(x.taxvalue,2) vatamt,round((x.amount+x.taxvalue),2) nettotal from ("+
                   " select m.description,case"+
                   " when tnc.chkvatdistributed=0 and  pyt.slno=1 then pyt.pamount-d.taxvalue"+
                   " when tnc.chkvatdistributed=0 and pyt.desc1='Rental Value' and pyt.slno<>1 then pyt.pamount"+
                   " when tnc.chkvatdistributed=1 then pyt.pamount-d.taxvalue end amount, case"+
       			" when tnc.chkvatdistributed=0 and pyt.slno=1 then d.taxvalue"+
       			" when tnc.chkvatdistributed=0 and pyt.desc1='Rental Value' and pyt.slno<>1 then 0.0"+
       			" when tnc.chkvatdistributed=1 then d.taxvalue"+
       			"  end taxvalue from rl_tncm tnc left join rl_tncpayment pyt on (tnc.doc_no=pyt.rdocno) left join rl_terms_contract m on (pyt.desc1=m.description) left join rl_tncterms d"+
       			" on (d.idno=m.idno and d.rdocno=pyt.rdocno) where pyt.rdocno="+docno+" and pyt.desc1='Rental Value') x union all"+
       			"  select m.description,case when d.taxtype='Inclusive' then round(d.amount-d.taxvalue,2) else round(d.amount,2) end"+
       			"  amount,if(d.taxvalue>0,5,0) taxrate,round(d.taxvalue,2) vatamt,round(d.nettotal,2) nettotal from rl_tncterms d  left join"+
       			"  rl_terms_contract m on d.idno=m.idno where d.rdocno="+docno+" and m.idno<>1 union all"+
       			"  select 'Commission' description,case when tnc.commissionvattype='Inclusive' then round(tnc.commisionamt-tnc.commissionvatvalue,2)"+
       			"  else round(tnc.commisionamt,2) end amount,if(tnc.commissionvatvalue>0,5,0) taxrate,round(tnc.commissionvatvalue,2) vatamt,"+
       			"  round(case when tnc.commissionvattype='Inclusive' then tnc.commisionamt else tnc.commisionamt+tnc.commissionvatvalue end,2) nettotal"+
       			"  from rl_tncm tnc where tnc.doc_no="+docno+" and tnc.commisionamt>0.0 )a,(SELECT @i:=0)c";*/
           String salsql="";
           String salsql2="";
           if(print==1) {
        	   salsql="select @i:=@i+1 rws,a.* from (select coalesce(x.receiptno,0)receiptno,x.chqno,x.pydate,x.description,round(x.amount,2) amount,if(x.taxvalue>0.0,5.0,0.0) taxrate,round(x.taxvalue,2) vatamt,round((x.amount+x.taxvalue),2) nettotal from(\r\n" + 
        	   		"select convert(concat(coalesce(jv.dtype,''),' - ',coalesce(jv.doc_no,'')),char(25)) receiptno,pyt.chqno,date_format(pyt.date,'%d-%m-%Y')pydate,concat( notes ) description ,case when tnc.chkvatdistributed=0 and pyt.slno=1 then pyt.pamount-d.taxvalue when tnc.chkvatdistributed=0 and pyt.desc1='Rental Value' and pyt.slno<>1 then pyt.pamount when tnc.chkvatdistributed=1 then pyt.pamount-(d.taxvalue/numofcheque) end amount, case when tnc.chkvatdistributed=0 and pyt.slno=1 then d.taxvalue when tnc.chkvatdistributed=0 and pyt.desc1='Rental Value' and pyt.slno<>1 then 0.0when tnc.chkvatdistributed=1 then d.taxvalue/numofcheque end taxvalue from rl_tncm tnc left join rl_tncpayment pyt on (tnc.doc_no=pyt.rdocno) left join  my_jvtran jv on (jv.status=3 and pyt.refno=jv.tr_no) left join rl_terms_contract m on (pyt.desc1=m.description) left join rl_tncterms d on (d.idno=m.idno and d.rdocno=pyt.rdocno) where pyt.rdocno="+docno+" and pyt.desc1='Rental Value' group by pyt.doc_no) x\r\n" + 
        	   		"union all\r\n" + 
        	   		"select convert(concat(coalesce(jv.dtype,''),' - ',coalesce(jv.doc_no,'')),char(25)) receiptno,pyt.chqno,date_format(pyt.date,'%d-%m-%Y')pydate,m.description,case when d.taxtype='Inclusive' then round(d.amount-d.taxvalue,2) else round(d.amount,2) end amount,if(d.taxvalue>0,5,0) taxrate,round(d.taxvalue,2) vatamt,round(d.nettotal,2) nettotal from rl_tncterms d left join rl_terms_contract m on d.idno=m.idno left join rl_tncpayment pyt on (d.rdocno=pyt.rdocno and m.description=pyt.desc1) left join  my_jvtran jv on (jv.status=3 and pyt.refno=jv.tr_no) where d.rdocno="+docno+" and m.idno<>1  group by pyt.doc_no\r\n" + 
        	   		"union all\r\n" + 
        	   		"select convert(concat(coalesce(jv.dtype,''),' - ',coalesce(jv.doc_no,'')),char(25)) receiptno,pyt.chqno,date_format(pyt.date,'%d-%m-%Y')pydate,'Commission' description,case when tnc.commissionvattype='Inclusive' then round(tnc.commisionamt-tnc.commissionvatvalue,2)else round(tnc.commisionamt,2) end amount,if(tnc.commissionvatvalue>0,5,0) taxrate,round(tnc.commissionvatvalue,2) vatamt,round(case when tnc.commissionvattype='Inclusive' then tnc.commisionamt else tnc.commisionamt+tnc.commissionvatvalue end,2) nettotal from rl_tncm tnc left join rl_tncpayment pyt on (tnc.doc_no=pyt.rdocno and pyt.desc1='Commision') left join  my_jvtran jv on (jv.status=3 and pyt.refno=jv.tr_no) where tnc.doc_no="+docno+" and tnc.commisionamt>0.0 group by pyt.doc_no)a,(SELECT @i:=0)c;"; 
           }
           if(print==2) {
            salsql="select @i:=@i+1 rws,a.* from (select x.pydate,x.description,round(x.amount,2) amount,if(x.taxvalue>0.0,5.0,0.0) taxrate,round(x.taxvalue,2) vatamt,round((x.amount+x.taxvalue),2) nettotal "
           		+ "from(select date_format(pyt.date,'%d-%m-%Y')pydate,concat( notes ) description ,case when tnc.chkvatdistributed=0 and pyt.slno=1 then pyt.pamount-d.taxvalue "
           		+ "when tnc.chkvatdistributed=0 and pyt.desc1='Rental Value' and pyt.slno<>1 then pyt.pamount when tnc.chkvatdistributed=1 then pyt.pamount-(d.taxvalue/numofcheque) end amount, case when tnc.chkvatdistributed=0 and pyt.slno=1 then d.taxvalue "
           		+ "when tnc.chkvatdistributed=0 and pyt.desc1='Rental Value' and pyt.slno<>1 then 0.0when tnc.chkvatdistributed=1 then d.taxvalue/numofcheque end taxvalue from rl_tncm tnc "
           		+ "left join rl_tncpayment pyt on (tnc.doc_no=pyt.rdocno) left join rl_terms_contract m on (pyt.desc1=m.description) left join rl_tncterms d on (d.idno=m.idno and d.rdocno=pyt.rdocno) where pyt.rdocno="+docno+" and pyt.desc1='Rental Value') x union all "
           		+ "select date_format(pyt.date,'%d-%m-%Y')pydate,m.description,case when d.taxtype='Inclusive' then round(d.amount-d.taxvalue,2) else round(d.amount,2) end amount,"
           		+ "if(d.taxvalue>0,5,0) taxrate,round(d.taxvalue,2) vatamt,round(d.nettotal,2) nettotal from rl_tncterms d left join rl_terms_contract m on d.idno=m.idno left join rl_tncpayment pyt on (d.rdocno=pyt.rdocno and m.description=pyt.desc1) where d.rdocno="+docno+" and m.idno<>1 union all "
           		+ "select date_format(pyt.date,'%d-%m-%Y')pydate,'Commission' description,case when tnc.commissionvattype='Inclusive' then round(tnc.commisionamt-tnc.commissionvatvalue,2)"
           		+ "else round(tnc.commisionamt,2) end amount,if(tnc.commissionvatvalue>0,5,0) taxrate,round(tnc.commissionvatvalue,2) vatamt,"
           		+ "round(case when tnc.commissionvattype='Inclusive' then tnc.commisionamt else tnc.commisionamt+tnc.commissionvatvalue end,2) nettotal "
           		+ "from rl_tncm tnc left join rl_tncpayment pyt on (tnc.doc_no=pyt.rdocno and pyt.desc1='Commision') where tnc.doc_no="+docno+" and tnc.commisionamt>0.0 )a,(SELECT @i:=0)c";
           
           salsql2="select @i:=@i+1 rws,a.* from (select date_format(pyt.date,'%d-%m-%Y')pydate,m.description,case when d.taxtype='Inclusive' then round(d.amount-d.taxvalue,2) else round(d.amount,2) end amount,if(d.taxvalue>0,5,0) taxrate,round(d.taxvalue,2) vatamt,round(d.nettotal,2) nettotal from rl_tncterms d left join rl_terms_contract m on d.idno=m.idno left join rl_tncpayment pyt on (d.rdocno=pyt.rdocno and m.description=pyt.desc1) where d.rdocno="+docno+" and m.idno<>1 and m.description != 'Ejari'"
+" union all select '' pydate, 'Charges' description, round(sum(amount),2)amount, 0 taxrate, round(sum(vatamt),2) vatamt, round(sum(nettotal),2) nettotal from ("
+" select date_format(pyt.date,'%d-%m-%Y')pydate,m.description,case when d.taxtype='Inclusive' then round(d.amount-d.taxvalue,2) else round(d.amount,2) end amount,if(d.taxvalue>0,5,0) taxrate,round(d.taxvalue,2) vatamt,round(d.nettotal,2) nettotal from rl_tncterms d left join rl_terms_contract m on d.idno=m.idno left join rl_tncpayment pyt on (d.rdocno=pyt.rdocno and m.description=pyt.desc1) where d.rdocno="+docno+" and m.idno<>1 and m.description = 'Ejari'"
+" union all select x.pydate,x.description,round(x.amount,2) amount,if(x.taxvalue>0.0,5.0,0.0) taxrate,round(x.taxvalue,2) vatamt,round((x.amount+x.taxvalue),2) nettotal from(select date_format(pyt.date,'%d-%m-%Y')pydate,concat( notes ) description ,case when tnc.chkvatdistributed=0 and pyt.slno=1 then pyt.pamount-d.taxvalue when tnc.chkvatdistributed=0 and pyt.desc1='Rental Value' and pyt.slno<>1 then pyt.pamount when tnc.chkvatdistributed=1 then pyt.pamount-(d.taxvalue/numofcheque) end amount, case when tnc.chkvatdistributed=0 and pyt.slno=1 then d.taxvalue when tnc.chkvatdistributed=0 and pyt.desc1='Rental Value' and pyt.slno<>1 then 0.0 when tnc.chkvatdistributed=1 then d.taxvalue/numofcheque end taxvalue from rl_tncm tnc left join rl_tncpayment pyt on (tnc.doc_no=pyt.rdocno) left join rl_terms_contract m on (pyt.desc1=m.description) left join rl_tncterms d on (d.idno=m.idno and d.rdocno=pyt.rdocno) where pyt.rdocno="+docno+" and pyt.desc1='Rental Value') x" 
+" union all select date_format(pyt.date,'%d-%m-%Y')pydate,'Commission' description,case when tnc.commissionvattype='Inclusive' then round(tnc.commisionamt-tnc.commissionvatvalue,2)else round(tnc.commisionamt,2) end amount,if(tnc.commissionvatvalue>0,5,0) taxrate,round(tnc.commissionvatvalue,2) vatamt,round(case when tnc.commissionvattype='Inclusive' then tnc.commisionamt else tnc.commisionamt+tnc.commissionvatvalue end,2) nettotal from rl_tncm tnc left join rl_tncpayment pyt on (tnc.doc_no=pyt.rdocno and pyt.desc1='Commision') where tnc.doc_no="+docno+" and tnc.commisionamt>0.0)t)a,(SELECT @i:=0)c";
       }
           bean.setGridqry(salsql);
           bean.setGridqry2(salsql2);
           //String salsql = "select desc1 description,date_format(date,'%d-%m-%Y') date, ROUND(pamount,2) amount, notes , chqno chqno, paidto, payment, bank from rl_tncpayment where  rdocno='" + docno + "' ";
            ResultSet resultSet1 = stmtprint.executeQuery(salsql);
            ArrayList<String> arr2 = new ArrayList<String>();
           while (resultSet1.next()) {
               String temp2 = "1";
               //temp2 = String.valueOf(resultSet1.getString("description")) + "::" + resultSet1.getString("date") + "::" + resultSet1.getString("amount") + "::" + resultSet1.getString("notes") + "::" + resultSet1.getString("chqno") + "::" + resultSet1.getString("paidto") + "::" + resultSet1.getString("payment") + "::" + resultSet1.getString("bank");
               arr2.add(temp2);
           }
           resultSet1.close();
           request.setAttribute("details22", (Object)arr2);
           String sql2="select round(sum(nettotal),2)net from rl_tncterms where rdocno='"+docno+"'";
           double gridtotal=0.0;
           ResultSet resultSet3 = stmtprint.executeQuery(sql2);
           while (resultSet3.next()) {
           	gridtotal+=resultSet3.getDouble("net");
           }
           String strgetcommission="select round(case when tnc.commissionvattype='Inclusive' then tnc.commisionamt else tnc.commisionamt+tnc.commissionvatvalue end,2) commtotal from rl_tncm tnc where status=3 and doc_no="+docno;
           ResultSet rsgetcommission=stmtprint.executeQuery(strgetcommission);
           while(rsgetcommission.next()){
           	gridtotal+=rsgetcommission.getDouble("commtotal");
           }
           ClsAmountToWords c = new ClsAmountToWords();
       //    bean.setLblrentwords(c.convertAmountToWords(objcommon.Round(gridtotal, 2)+""));
           
       }
       catch (Exception e) {
           conn.close();
           e.printStackTrace();
       }
       finally{
       	conn.close();
       }
       return bean;
   }
    
    public JSONArray managementfeeloading( String docno) throws SQLException {
        JSONArray RESULTDATA = new JSONArray();
        Connection conn = null;
        try {
            conn = objconn.getMyConnection();
             Statement stmtVeh = conn.createStatement();
             String sql1 = " select date,amount from rl_tncmanagefee where tdoc_no=" + docno;
            System.out.println("mng fee sql=" + sql1);
             ResultSet resultSet = stmtVeh.executeQuery(sql1);
            RESULTDATA = objcommon.convertToJSON(resultSet);
            stmtVeh.close();
            conn.close();
        }
        catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }
        finally{
        	conn.close();
        }
        return RESULTDATA;
    }
}