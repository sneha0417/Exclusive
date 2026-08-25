package com.dashboard.realestate.propertyaccountmanagement;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsPropertyAccountManagementDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon =new ClsCommon();
	
	public JSONArray pendingGrid(String userid) throws SQLException{  
		JSONArray data=new JSONArray();                      
		Connection conn=null; 
		 java.sql.Date edates = null;     
		try{
			conn=ClsConnection.getMyConnection();     
			Statement stmt=conn.createStatement();     
			        
			String strsql="select  us.user_name crtuser,u.user_name user,t.userid,ass_user,t.doc_no,strt_date,strt_time,description,act_status status from an_taskcreation t left join an_taskcreationdets a on t.doc_no=a.rdocno left join my_user u on u.doc_no=t.ass_user left join my_user us on us.doc_no=t.userid where  (t.userid='"+userid+"' or t.ass_user='"+userid+"') and t.close_status=0 and t.utype!='app' group by doc_no";        
			//System.out.println("pendingGrid--->>>"+strsql);                                    
			ResultSet rs=stmt.executeQuery(strsql);
			data=ClsCommon.convertToJSON(rs);  
		}   
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();  
		}
		return data;
	}     

	public JSONArray getPropertyData(String fromdate,String todate,String id,String status,String actype) throws SQLException {     
		JSONArray RESULTDATA=new JSONArray();     
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn = null;
		java.sql.Date sqltodate=null;
		java.sql.Date sqlfromdate=null;
		String str="";
		if(!(actype.equalsIgnoreCase("") || actype.equalsIgnoreCase("a")))
		{
		  str+=" and m.active="+actype;
		}
		try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmt = conn.createStatement();                
			 /*if(!fromdate.equalsIgnoreCase("0") && !fromdate.equalsIgnoreCase("")){      
				 sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
			 }
			 if(!todate.equalsIgnoreCase("0") && !todate.equalsIgnoreCase("")){
				 sqltodate=ClsCommon.changeStringtoSqlDate(todate);               
			 }*/
			 String strsql="select coalesce(o.email,o.email2) ownermail,m.owid,h1.account macno,h1.description maccount,h2.account oacno,h2.description oaccount,m.brhid,m.mrf_acno mrfacno,m.acno owneracno,m.doc_no,m.active pstatus,m.mgprpty,m.prid,m.accname,m.date,m.terms_warranty,o.primary_owner  owner_name,m.unitno unit_number,bm.name Unit_of,pt.code type,ut.unittype unit_type,aa.area,m.landmark,t.transtype transaction_type "
				 		+" , convert(if(m.cnt_no=0,'',DATE_ADD(m.cnt_date, INTERVAL 1 DAY)),char(100)) availability_date,c.msg comment,c.msgdate commentdate,u.user_name commentby,ac.refname tenant,us.user_name statuschangeby,uw.user_name warrantychangeby from rl_propertymaster m "
				 		+" left join rl_propertryowner o on o.doc_no=m.owid "
						+" left join rl_transtype t on t.doc_no=m.ttype"
						+" left join rl_propertytype pt on pt.doc_no=m.ptype"
						+" left join rl_unittype ut on ut.doc_no=m.unittype"
						+" left join my_area aa on aa.doc_no=m.area"
						+" left join (select msg,msgdate,doc_no,userid from rl_comments order by rowno desc limit 1) c on c.doc_no=m.doc_no"
						+" left join my_user u on u.doc_no=c.userid"
						+" left join (select formid,userid,status from gl_bpmt order by doc_no desc) c1 on c1.formid=m.doc_no and c1.status=m.pstatus"
						+" left join my_user us on us.doc_no=c1.userid"
						+" left join (select formid,userid,warrantydate from gl_bpmt order by doc_no desc) c2 on c2.formid=m.doc_no and c2.warrantydate=m.terms_warranty"
						+" left join my_user uw on uw.doc_no=c2.userid"
						+" left join rl_buildingm bm on bm.doc_no=m.unitof "
						+" left join rl_tncm tn on tn.doc_no=m.cnt_no "         
						+" left join my_acbook ac on ac.cldocno=tn.cldocno and ac.dtype='crm' left join my_head h1 on h1.doc_no=m.mrf_acno left join my_head h2 on h2.doc_no=m.acno"
						+" where m.status=3   "+str+"  group by m.doc_no"; 
			 // and m.date between '"+sqlfromdate+"' and '"+sqltodate+"' and m.active=1
			System.out.println("strsql---->>>"+strsql);
			ResultSet resultSet = stmt.executeQuery(strsql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	public JSONArray getPropertyExcel(String fromdate,String todate,String id) throws SQLException {           
		JSONArray RESULTDATA=new JSONArray();     
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn = null;
		java.sql.Date sqltodate=null;
		java.sql.Date sqlfromdate=null;
		/*sqluptodate=ClsCommon.changeStringtoSqlDate(uptodate);*/
		
		try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmt = conn.createStatement();
			
			 String strsql="select o.primary_owner  owner_name,m.unitno unit_number,bm.name Unit_of,pt.prtype type,ut.unittype unit_type,aa.area,m.landmark,t.transtype transaction_type "
			 		+" , convert(if(m.cnt_no=0,'',DATE_ADD(m.cnt_date, INTERVAL 1 DAY)),char(100))  availability_date from rl_propertymaster m "
			 		+" left join rl_propertryowner o on o.doc_no=m.owid"
					+" left join rl_transtype t on t.doc_no=m.ttype"
					+" left join rl_propertytype pt on pt.doc_no=m.prtype"
					+" left join rl_unittype ut on ut.doc_no=m.prunit"
					+" left join my_area aa on aa.doc_no=m.area"
					+" left join rl_buildingm bm on bm.doc_no=m.unitof"
					+" where m.status=3  and m.active=1  group by m.doc_no";     
            
			System.out.println("strsql---->>>"+strsql);
			ResultSet resultSet = stmt.executeQuery(strsql);
			RESULTDATA=ClsCommon.convertToEXCEL(resultSet);    
		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	public JSONArray searchuser(HttpSession session) throws SQLException{   
		JSONArray data=new JSONArray();                                      
		Connection conn=null; 
		 java.sql.Date edates = null;     
		try{
			conn=ClsConnection.getMyConnection();  
			Statement stmt=conn.createStatement();
			        
			String strsql="select user_name user,doc_no from my_user";  
			ResultSet rs=stmt.executeQuery(strsql);
			data=ClsCommon.convertToJSON(rs);  
		}   
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();  
		}
		return data;
	}
	public JSONArray searchowner(HttpSession session) throws SQLException{       
		JSONArray data=new JSONArray();                                      
		Connection conn=null; 
		 java.sql.Date edates = null;     
		try{
			conn=ClsConnection.getMyConnection();  
			Statement stmt=conn.createStatement();
			        
			String strsql="select primary_owner owner,doc_no from rl_propertryowner where status=3";        
			ResultSet rs=stmt.executeQuery(strsql);
			data=ClsCommon.convertToJSON(rs);  
		}   
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();  
		}
		return data;
	}
	public JSONArray loadflwupgrid(String docno) throws SQLException{ 
		JSONArray data=new JSONArray(); 
		Connection conn=null; 
		java.sql.Date edates = null; 
		try{
		conn=ClsConnection.getMyConnection(); 
		Statement stmt=conn.createStatement(); 

		String strsql=" select f.ass_date date,u.user_name asuser,r.user_name user,f.remarks remark,f.action_status status from an_taskcreationdets f left join my_user u on u.doc_no=f.userid left join my_user r on r.doc_no=f.assnfrom_user where f.rdocno='"+docno+"'"; 
		//System.out.println("flwp--->>>"+strsql); 
		ResultSet rs=stmt.executeQuery(strsql);
		data=ClsCommon.convertToJSON(rs); 
		} 
		catch(Exception e){
		e.printStackTrace();
		}
		finally{
		conn.close(); 
		}
return data;
}	

	
	public JSONArray accountsStatement(String branch,String fromdate,String todate,String accdocno,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtAccountStatement2 = conn.createStatement();
				String sql = "";String joins="";String casestatement="";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.brhId="+branch+"";
	    		}
            		
				joins=ClsCommon.getFinanceVocTablesJoins(conn);
				casestatement=ClsCommon.getFinanceVocTablesCase(conn);
				
				sql = "select b.*,coalesce(round(@i:=@i+nettotal,2),0) balance from ( select a.trdate, a.brhid, a.transtype, a.description, a.ref_detail, a.tr_no, a.curId, a.currency, a.dramount, a.dr, a.cr, a.ldramount,"  
					    + "a.debit, a.credit, a.rate, a.account, a.accountname, a.grpno, a.alevel, a.acno,round((a.debit+(a.credit)*-1),2) nettotal,"+casestatement+"b.branchname from (select date(t.trdate) trdate,t.brhid,transno,transtype,t.tr_des description,t.ref_detail,t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,"
						+ "CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,"
						+ "round((t.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno from my_head h inner join (select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,"
						+ "t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where  t.status=3 and date between "
						+ "'"+sqlFromDate+"' and  '"+sqlToDate+"' and trtype!=1 "+sql+" and t.acno= "+accdocno+" and t.yrid=0 union all select t.brhid,DATE_ADD('"+sqlFromDate+"',INTERVAL -1 DAY) trdate,"
						+ "'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,t.rate,0 transNo,'OPN' transType "
						+ "from my_jvtran t where t.status=3 and ((t.trtype=1 and t.date <= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+sql+" "
						+ "and t.acno= "+accdocno+" group by t.acno,t.curId )t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,"
						+ "trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid"+joins+" order by trdate,TRANSNO) b,(select @i:=0) as i";
				System.out.println("============"+sql);
				ResultSet resultSet = stmtAccountStatement2.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtAccountStatement2.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	public JSONArray getMaintenaceData(String pdocno,String id) throws SQLException {     
		JSONArray RESULTDATA=new JSONArray();         
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn = null;
		try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmt = conn.createStatement();
			 String strsql="select  r.branch brhid,r.confirm,r.voc_no,r.comments,ac.refname tenant,r.edate date,rm.estval amount,rm.margin profit,rm.total,rm.description compremark,st.name status,j.job_desc job,h.description proname,rm.paytype from re_mreq r left join re_mreqmgmt rm on rm.rdocno=r.doc_no left join my_acbook ac on (ac.cldocno=r.tdoc_no and ac.dtype='crm') left join rl_propertymaster p on (p.doc_no=r.pdoc_no) left join re_pstatus st on st.doc_no=r.statusid left join rl_jobmaster j on j.doc_no=rm.jobdocno left join my_head h on (h.doc_no=rm.vndacno and h.atype='ap') where r.status=3 and p.doc_no='"+pdocno+"' order by r.confirm asc"; 
			 //System.out.println("strsql---->>>"+strsql);             
			ResultSet resultSet = stmt.executeQuery(strsql);        
			RESULTDATA=ClsCommon.convertToJSON(resultSet);   
		}catch(Exception e){   
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}	
	public   JSONArray getMgmtData(String branch,String fromdate,String todate,String id,String docno) throws SQLException {
		JSONArray data=new JSONArray();
	    if(!id.equalsIgnoreCase("1")){
	    	return data;
	    }
	    String sqltest="";
	    java.sql.Date sqlfromdate = null,sqltodate = null;
	    
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and m.brhid='"+branch+"'";
 		}
    	
     	Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stm = conn.createStatement ();           
			String sql="select coalesce(group_concat(d.sal_name),'') agent,m.voc_no cnt_no,m.date cnt_date,ac.refname tenantname,m.period_from fromdate,m.period_to todate,coalesce(rv.nettotal,0) rentalv,coalesce(ad.nettotal,0) tadminfee,coalesce(m.commisionamt,0) commamt,coalesce(managementamt,0) mgmtamt,coalesce(owneradminfee,0) oadminfee, coalesce(sum(camount)*-1,0) agentcomm, coalesce(ad.nettotal,0)+coalesce(m.commisionamt,0)+coalesce(managementamt,0)+coalesce(owneradminfee,0)-coalesce(sum(camount),0) income from rl_tncm m  left join my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM') left join rl_tncterms rv on rv.rdocno=m.doc_no and rv.idno=1 left join rl_tncterms ad on ad.rdocno=m.doc_no and ad.idno=6  left join rl_tncagent am on am.rdocno=m.doc_no left join my_salesman d on d.doc_no=am.sal_id and d.sal_type='SLA'  where m.status=3 and m.prtype='"+docno+"' group by m.doc_no ";
			System.out.println("Tenancy Mgmt Query:  "+sql);	
            ResultSet resultSet = stm.executeQuery(sql);
            data=ClsCommon.convertToJSON(resultSet);
            conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		// System.out.println(data);
        return data;
    }	
	public   JSONArray getInspection(String branch,String fromdate,String todate,String id,String docno) throws SQLException {
		JSONArray data=new JSONArray();
	    if(!id.equalsIgnoreCase("1")){
	    	return data;
	    }
	    String sqltest="";
	    java.sql.Date sqlfromdate = null,sqltodate = null;     
	    
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and m.brhid='"+branch+"'";
 		}
    	
     	Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stm = conn.createStatement ();           
			String sql="select inspdate,u.user_name user,insdate,m.doc_no from rl_propinspm m left join my_user u on u.doc_no=m.userid where m.propdocno='"+docno+"'";
			System.out.println("Inspection Mgmt Query:  "+sql);	
            ResultSet resultSet = stm.executeQuery(sql);
            data=ClsCommon.convertToJSON(resultSet);
            conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		// System.out.println(data);
        return data;
    }	
	public JSONArray summaryASData(String branch,String fromdate,String todate,String accdocno,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtAccountStatement2 = conn.createStatement();
				String sql = "";String joins="";String casestatement="";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.brhId="+branch+"";
	    		}
            		
				joins=ClsCommon.getFinanceVocTablesJoins(conn);
				casestatement=ClsCommon.getFinanceVocTablesCase(conn);
				
				sql = "select b.*,coalesce(round(@i:=@i+nettotal,2),0) balance from ( select a.trdate, a.brhid, a.transtype, a.description, a.ref_detail, a.tr_no, a.curId, a.currency, a.dramount, a.dr, a.cr, a.ldramount,"  
					    + "a.debit, a.credit, a.rate, a.account, a.accountname, a.grpno, a.alevel, a.acno,round((a.debit+(a.credit)*-1),2) nettotal,"+casestatement+"b.branchname from (select date(t.trdate) trdate,t.brhid,transno,transtype,t.tr_des description,t.ref_detail,t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,"
						+ "CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,"
						+ "round((t.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno from my_head h inner join (select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,"
						+ "t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where  t.status=3 and date between "
						+ "'"+sqlFromDate+"' and  '"+sqlToDate+"' and trtype!=1 "+sql+" and t.acno= "+accdocno+" and t.yrid=0 union all select t.brhid,DATE_ADD('"+sqlFromDate+"',INTERVAL -1 DAY) trdate,"
						+ "'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,t.rate,0 transNo,'OPN' transType "
						+ "from my_jvtran t where t.status=3 and ((t.trtype=1 and t.date <= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+sql+" "
						+ "and t.acno= "+accdocno+" group by t.acno,t.curId )t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,"
						+ "trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid"+joins+" order by trdate,TRANSNO) b,(select @i:=0) as i";
				//System.out.println("============"+sql);
				ResultSet resultSet = stmtAccountStatement2.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtAccountStatement2.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	public JSONArray loadsummaryGrid(String ownid,String id,String todate) throws SQLException {              
		JSONArray RESULTDATA=new JSONArray();     
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn = null;
		 java.sql.Date sqlToDate = null;
		try {
			 conn = ClsConnection.getMyConnection(); 
			 Statement stmt = conn.createStatement();
			 if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
			 }
			 //String strsql="select accname,mrfacno,acno,round(pcredit,2) pcredit,round(pdebit,2) pdebit,round(mcredit,2) mcredit,round(mdebit,2) mdebit,round((pcredit+pdebit+mcredit+mdebit),2) nettotal from(select  m.accname,coalesce(m.mrf_acno,0) mrfacno,coalesce(m.acno,0) acno,if(coalesce(jp1.credit,0)<0,coalesce(jp1.credit,0)*-1,0) pcredit,coalesce(jp2.debit,0) pdebit,if(coalesce(jm1.credit,0)<0,coalesce(jm1.credit,0)*-1,0) mcredit,coalesce(jm2.debit,0) mdebit from rl_propertymaster m left join (select sum(coalesce(dramount,0)) credit,acno from my_jvtran where dramount<0 group by acno) jp1 on jp1.acno=m.acno left join (select sum(coalesce(dramount,0)) debit,acno from my_jvtran where dramount>=0 group by acno) jp2 on jp2.acno=m.acno left join (select sum(coalesce(dramount,0)) credit,acno from my_jvtran where dramount<0 group by acno) jm1 on jm1.acno=m.mrf_acno left join (select sum(coalesce(dramount,0)) debit,acno from my_jvtran where dramount>=0 group by acno) jm2 on jm2.acno=m.mrf_acno  where m.owid='"+ownid+"')a"; 
			 String strsql="select a.accname,a.acno,a.mrfacno,round(if(coalesce(a.pcredit,0)<0,coalesce(a.pcredit,0)*-1,coalesce(a.pcredit,0)),2) pcredit,round(if(coalesce(a.pdebit,0)<0,coalesce(a.pdebit,0)*-1,coalesce(a.pdebit,0)),2) pdebit,round(if(coalesce(b.mcredit,0)<0,coalesce(b.mcredit,0)*-1,coalesce(b.mcredit,0)),2) mcredit,round(if(coalesce(b.mdebit,0)<0,coalesce(b.mdebit,0)*-1,coalesce(b.mdebit,0)),2) mdebit,round((if(coalesce(a.pdebit,0)<0,coalesce(a.pdebit,0)*-1,coalesce(a.pdebit,0))-if(coalesce(a.pcredit,0)<0,coalesce(a.pcredit,0)*-1,coalesce(a.pcredit,0))+if(coalesce(b.mdebit,0)<0,coalesce(b.mdebit,0)*-1,coalesce(b.mdebit,0))-if(coalesce(b.mcredit,0)<0,coalesce(b.mcredit,0)*-1,coalesce(b.mcredit,0))),2) nettotal from (select  m.accname,m.mrf_acno mrfacno,m.acno,if(sum(coalesce(dramount,0))<0,sum(coalesce(dramount,0)),0) pcredit,if(sum(coalesce(dramount,0))>0,sum(coalesce(dramount,0)),0) pdebit,m.doc_no   from rl_propertymaster m left join my_jvtran j on j.acno=m.acno where m.owid='"+ownid+"' and m.status=3 and j.status=3 and j.date<='"+sqlToDate+"' group by m.acno) a left join (select  if(sum(coalesce(dramount,0))<0,sum(coalesce(dramount,0)),0) mcredit,if(sum(coalesce(dramount,0))>0,sum(coalesce(dramount,0)),0) mdebit,m.doc_no from rl_propertymaster m left join my_jvtran j on j.acno=m.mrf_acno where m.owid='"+ownid+"' and m.status=3 and j.status=3 and j.date<='"+sqlToDate+"' group by m.mrf_acno) b on a.doc_no=b.doc_no";
//			 System.out.println("strsql---->>>"+strsql);            
			 ResultSet resultSet = stmt.executeQuery(strsql);            
			 RESULTDATA=ClsCommon.convertToJSON(resultSet);
		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	public JSONArray splInstructionData(HttpSession session, String docno, String id)
			throws SQLException {
		JSONArray RESULTDATA = new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;    
		}
		Connection conn = null;
		try {
		   
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql = "select rowno,remarks desc1 from re_ownersplins where rdocno='"+docno+"' and status<>7";  
			//System.out.println("splInstructionData--->>>"+sql);
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
