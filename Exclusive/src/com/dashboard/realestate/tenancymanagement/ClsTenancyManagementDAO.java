package com.dashboard.realestate.tenancymanagement;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsTenancyManagementDAO {   
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon =new ClsCommon();
	
	
	public   JSONArray getMgmtData(String branch,String fromdate,String todate,String id,String allcontracts,String chkexpiry,
			String cmbmanage,String chkcreated,String cmbowner,String cmbproperty,String cmbtenant) throws SQLException {
		JSONArray data=new JSONArray();
	    if(!id.equalsIgnoreCase("1")){
	    	return data;
	    }
	    String sqltest="";
	    java.sql.Date sqlfromdate = null,sqltodate = null;
	    if(chkexpiry.equalsIgnoreCase("1") || chkcreated.equalsIgnoreCase("1")){
	    	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
	    		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
	    	}
	    	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
	    		sqltodate=objcommon.changeStringtoSqlDate(todate);
	    	}
	    	if(chkexpiry.equalsIgnoreCase("1")){
	    		sqltest+=" and m.period_to>='"+sqlfromdate+"'";
	    		sqltest+=" and m.period_to<='"+sqltodate+"'";
	    	}
	    	else if(chkcreated.equalsIgnoreCase("1")){
	    		sqltest+=" and m.date>='"+sqlfromdate+"'";
	    		sqltest+=" and m.date<='"+sqltodate+"'";
	    	}
	    }
	    else{
	    	if(allcontracts.equalsIgnoreCase("1")){
		    	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
		    		sqltodate=objcommon.changeStringtoSqlDate(todate);
		    	}
		    	// sqltest+=" and m.period_from>='"+sqltodate+"' and m.period_to<='"+sqltodate+"'";
	    	}
		    else{
		    	
		     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
		     		sqltodate=objcommon.changeStringtoSqlDate(todate);
		     		sqltest+=" and '"+sqltodate+"' between  m.period_from and m.period_to ";
		     	}
		     	sqltest+=" and m.clstatus=0";
		    }
	    }
	    
	    
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and m.brhid='"+branch+"'";
 		}
    	if(!cmbmanage.equalsIgnoreCase("")){
    		sqltest+=" and pr.mgprpty="+cmbmanage;
    	}
    	if(!cmbtenant.equalsIgnoreCase("")){
    		sqltest+=" and ac.cldocno in ("+cmbtenant+")";
    	}
    	if(!cmbowner.equalsIgnoreCase("")){
    		sqltest+=" and ownhead.doc_no in ("+cmbowner+")";
    	}
    	if(!cmbproperty.equalsIgnoreCase("")){
    		sqltest+=" and pr.doc_no in ("+cmbproperty+")";
    	}
     	Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			Statement stm = conn.createStatement ();     
			String sql="select br.branchname,m.numofcheque chequecount,ownhead.doc_no ownerdocno,ownhead.email owneremail,ac.cldocno tenantdocno,m.pstatus poststatus,coalesce(group_concat(crm.mob),'') contactmobile,coalesce(group_concat(crm.email),'') contactemail,coalesce(ownerhead.description,'') owneraccountname,coalesce(tenanthead.description,'') tenantaccountname,coalesce(mrfhead.description,'') mrfaccountname,coalesce(ac.acno,0) tenantacno,coalesce(pr.acno,0) owneracno,coalesce(pr.mrf_acno,0) mrfacno,coalesce(pr.unitno,'') unitno,coalesce(m.renewalremarks,'') renewalremarks,m.clstatus,pr.cnt_no propcontractno, m.brhid,pr.doc_no propdocno,m.doc_no,m.voc_no,ac.refname tenantname,ac.per_mob tenantmobile,ac.mail1 tenantemail,coalesce(pr.prid,'') propid,"+
			" coalesce(pr.accname,'') propname,date_sub(m.period_to,interval m.not_period day) notifydate,m.period_from fromdate,m.period_to todate,coalesce(st.statusname,'')"+
			" renewalstatus,round(coalesce(amt.amount,0),2) rent,ownhead.primary_owner owner from rl_tncm m left join rl_propertymaster pr on m.prtype=pr.doc_no left join"+
			" my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM') left join rl_contractrenewalstatus st on"+
			" (m.renewalstatus=st.doc_no and st.status=3) left join (select amount,rdocno from rl_tncterms where idno=1 group by rdocno) amt"+
			" on (m.doc_no=amt.rdocno) left join rl_propertryowner ownhead on (pr.owid=ownhead.doc_no) left join my_head tenanthead on "+
			" ac.acno=tenanthead.doc_no left join my_head ownerhead on pr.acno=ownerhead.doc_no left join my_head mrfhead on "+
			" pr.mrf_acno=mrfhead.doc_no left join my_crmcontact crm on (ac.cldocno=crm.cldocno and crm.dtype='CRM') left join my_brch br on m.brhid=br.doc_no where m.status=3 "+sqltest+" group by m.doc_no order by m.doc_no";
			System.out.println("Tenancy Mgmt Query:  "+sql);	
            ResultSet resultSet = stm.executeQuery(sql);
            data=objcommon.convertToJSON(resultSet);
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
	
	public JSONArray searchvendor(HttpSession session) throws SQLException{
		JSONArray data=new JSONArray();
		Connection conn=null;
		java.sql.Date edates = null;
		try{
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();

		String strsql="select h.description accname,h.doc_no from my_acbook ac left join my_head h on h.doc_no=ac.acno where ac.dtype='vnd' and h.atype='ap' and ac.status=3";
		ResultSet rs=stmt.executeQuery(strsql);
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
	
	
	public  JSONArray accountstatementSearch(String contractdocno,String id) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
	    if(!id.equalsIgnoreCase("1")){
	    	return RESULTDATA;
	    }
		Connection conn=null;
		try {
			conn =objconn.getMyConnection();
			Statement stmt= conn.createStatement ();
			String sql="select br.branchname,a.*,if(a.transtype in ('PRIV'),m.voc_no,a.transno) transno  from ("+
			" select j.brhid,j.acno,j.doc_no transno,j.tr_no,j.tranid,j.dtype transtype,j.date trdate,j.rdocno rentaldoc,j.rtype rentaltype,"+
			" CONVERT(if(j.ldramount>0,round((j.ldramount*1),2),''),CHAR(100)) debit,CONVERT(if(j.ldramount<0,round((j.ldramount*-1),2),''),CHAR(100))"+
			" credit,if(j.description='0','',j.description) description from my_jvtran j inner join rl_tncm r on (j.rdocno=r.doc_no and rtype='TNC') "+
			" left join my_acbook c on (r.cldocno=c.cldocno and c.dtype='CRM' and c.acno=j.acno) where j.status=3 and j.rdocno="+contractdocno+" and j.rtype='TNC' and (c.doc_no is not null)"+
			" union all"+
			" (select brhid,acno,transno,tr_no,tranid,transtype,trdate,rentaldoc,rentaltype,if(sum(gr.debit)=0,'',round(sum(gr.debit),2)),"+
			" if(sum(gr.credit)=0,'',round(sum(gr.credit),2)) ,if(description='0','',description) description from ("+
			" select j1.acno,j1.doc_no transno,j1.tr_no,j1.tranid,j1.dtype transtype,j1.date trdate,j.rdocno rentaldoc,j.rtype rentaltype,j.brhid,"+
			" CONVERT(if(j1.ldramount>0,round((d.amount),2),''),CHAR(100)) debit, 	CONVERT(if(j1.ldramount<0,round((d.amount),2),''),CHAR(100))"+
			" credit,j.ldramount,if(j1.description='0','',j1.description) description  from my_jvtran j inner join my_outd d on"+
			" d.ap_trid=j.tranid inner join my_jvtran j1 on d.tranid=j1.tranid  inner join rl_tncm r"+
			" on (j.rdocno=r.doc_no and j.rtype='TNC') inner join my_acbook c on c.doc_no=r.cldocno and c.dtype='CRM' and c.acno=j.acno"+
			" where  j.status=3 and j.rdocno="+contractdocno+" and j.rtype='TNC' and j1.tr_no is not null group by j1.doc_no) gr group by"+
			" gr.tranid)) a left join rl_prinvm m on m.dtype=a.transtype and a.transno=m.doc_no left join my_brch br on a.brhid=br.doc_no group by a.tranid order by a.trdate";
			System.out.println("-----sql-----"+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
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
	    return RESULTDATA;
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
				conn = objconn.getMyConnection();
				Statement stmtAccountStatement2 = conn.createStatement();
				String sql = "";String joins="";String casestatement="";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = objcommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = objcommon.changeStringtoSqlDate(todate);
				}
				
				/*if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.brhId="+branch+"";
	    		}*/
            		
				joins=objcommon.getFinanceVocTablesJoins(conn);
				casestatement=objcommon.getFinanceVocTablesCase(conn);
				
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
				RESULTDATA=objcommon.convertToJSON(resultSet);
				
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
	
	public JSONArray pendingGrid(String userid) throws SQLException{  
		JSONArray data=new JSONArray();                      
		Connection conn=null; 
		 java.sql.Date edates = null;     
		try{
			conn=objconn.getMyConnection();     
			Statement stmt=conn.createStatement();     
			        
			String strsql="select  us.user_name crtuser,u.user_name user,t.userid,ass_user,t.doc_no,strt_date,strt_time,description,act_status status from an_taskcreation t left join an_taskcreationdets a on t.doc_no=a.rdocno left join my_user u on u.doc_no=t.ass_user left join my_user us on us.doc_no=t.userid where  (t.userid='"+userid+"' or t.ass_user='"+userid+"') and t.close_status=0 and t.utype!='app' group by doc_no";        
			//System.out.println("pendingGrid--->>>"+strsql);                                    
			ResultSet rs=stmt.executeQuery(strsql);
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
	
	public JSONArray loadflwupgrid(String docno) throws SQLException{ 
		JSONArray data=new JSONArray(); 
		Connection conn=null; 
		java.sql.Date edates = null; 
		try{
		conn=objconn.getMyConnection(); 
		Statement stmt=conn.createStatement(); 

		String strsql=" select f.ass_date date,u.user_name asuser,r.user_name user,f.remarks remark,f.action_status status from an_taskcreationdets f left join my_user u on u.doc_no=f.userid left join my_user r on r.doc_no=f.assnfrom_user where f.rdocno='"+docno+"'"; 
		//System.out.println("flwp--->>>"+strsql); 
		ResultSet rs=stmt.executeQuery(strsql);
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
	
	public JSONArray getMgmtLogData(String contractdocno,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select tnc.voc_no tncvocno,tnc.doc_no tncdocno,br.branchname,usr.user_name,l.logdate,l.remarks,l.systemremarks from "+
			" rl_tncmgmtlog l left join rl_tncm tnc on l.docno=tnc.doc_no left join my_brch br on l.brhid=br.doc_no left join my_user usr"+
			" on l.userid=usr.doc_no where tnc.doc_no="+contractdocno;
			ResultSet rs=stmt.executeQuery(strsql);
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
	public JSONArray searchuser(HttpSession session) throws SQLException{   
		JSONArray data=new JSONArray();                                      
		Connection conn=null; 
		 java.sql.Date edates = null;     
		try{
			conn=objconn.getMyConnection();  
			Statement stmt=conn.createStatement();
			        
			String strsql="select user_name user,doc_no from my_user";  
			ResultSet rs=stmt.executeQuery(strsql);
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
}
