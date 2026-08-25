package com.dashboard.realestate.maintenancemanagement;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsMaintenanceManagementDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon =new ClsCommon();
	
	
	public JSONArray getPropertyData(String fromdate,String todate,String id) throws SQLException {     
		JSONArray RESULTDATA=new JSONArray();     
		if(!id.equalsIgnoreCase("1")){    
			return RESULTDATA;
		}
		Connection conn = null;
		java.sql.Date sqltodate=null;
		java.sql.Date sqlfromdate=null;
		/*sqluptodate=ClsCommon.changeStringtoSqlDate(uptodate);*/
		String strsql="";    
		try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmt = conn.createStatement();
			 if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
				 sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
				}
			 if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
				 sqltodate=ClsCommon.changeStringtoSqlDate(todate);      
				}
			strsql="select if(a.statusid=4,DATEDIFF(now(),owapvldate)>3,0) owneraprvl,a.* from(select r.owapvldate,r.statusid,coalesce(p.owid,0) owid,round(coalesce(rm.total,0),2) total,r.jv_vocno,r.blockamt,r.jvtrno,st.name status,p.acno owneracno,r.branch brhid,r.posttrno,p.mrf_acno mrfacno,r.margin,o.acno accountno,o.account_name accountname,ac.acno,r.doc_no,r.voc_no,r.edate date,j.job_desc job,r.comments,ac.refname tenant,if(p.mgprpty=1,'Y','N') managed,p.prid,p.accname property,o.primary_owner owner_name,p.unitno unit_number,r.priority,round(r.est_amt,2) estcost,h.description proname,h.account proacno,if(p.mgprpty=1,'Managed','Non Managed') classified from re_mreq r left join my_acbook ac on (ac.cldocno=r.tdoc_no and ac.dtype='crm') left join rl_propertymaster p on (p.doc_no=r.pdoc_no) left join rl_propertryowner o on o.doc_no=p.owid left join rl_jobmaster j on j.doc_no=r.job_docno left join my_head h on (h.doc_no=r.jbprov and h.atype='ap')"       
							+" left join re_pstatus st on st.doc_no=r.statusid left join (select sum(total) total,rvocno,rbrhid  from re_mreqmgmt group by rvocno) rm on (rm.rvocno=r.voc_no and rm.rbrhid=r.branch) where r.status=3 and confirm=0  and r.edate between '"+sqlfromdate+"' and '"+sqltodate+"'  order by statusid desc)a group by a.voc_no";
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
	public JSONArray loadRequestGrid(String vocno,String brhid,String id,String status) throws SQLException {     
		JSONArray RESULTDATA=new JSONArray();     
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn = null;
		try {
			 conn = ClsConnection.getMyConnection(); 
			 Statement stmt = conn.createStatement();
			 String strsql="select st.name status,re.job_docno,re.branch brhid,j.job_desc job,h.description vendor_name,h.account vendor_acno,h.doc_no vendor_docno,re.doc_no,re.voc_no, r.paytype pay, r.estval est_cost, r.margin, r.total,coalesce(r.description,'') description,r.rowno  from re_mreq re left join re_mreqmgmt r on re.doc_no=r.rdocno left join re_pstatus st on st.doc_no=re.statusid left join rl_jobmaster j on j.doc_no=re.job_docno left join my_head h on (h.doc_no=r.vndacno and h.atype='ap') where re.voc_no='"+vocno+"' and re.branch='"+brhid+"' and re.confirm=0 group by re.doc_no";
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
	public JSONArray jobSearch(HttpSession session) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();
		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql = "SELECT * FROM rl_jobmaster where status=3;";

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
	public JSONArray vendorSearch(HttpSession session) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();
		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql = "select h.description accname,h.doc_no,h.account  acno from  my_acbook ac left join my_head h on h.doc_no=ac.acno where ac.dtype='vnd' and h.atype='ap' and ac.catid=6";
			//System.out.println("sql---->>>"+sql);
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
	public   JSONArray loadjvGrid(String payacno,String id,String blockamt) throws SQLException {
		JSONArray data=new JSONArray();    
	    if(!id.equalsIgnoreCase("1")){
	    	return data;
	    }
	    int mbacno=0; 	
     	Connection conn = null;
     	Double mbval=0.0,payval=0.0;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stm = conn.createStatement ();
			if(Double.parseDouble(blockamt)>0){
				mbval=Double.parseDouble(blockamt)*-1;
				payval=Double.parseDouble(blockamt); 
			}else{
				mbval=Double.parseDouble(blockamt);
				payval=Double.parseDouble(blockamt)*-1;    
			}
			String str="select (SELECT coalesce(acno,0) acno FROM MY_ACCOUNT WHERE CODENO='MAINTENANCE BLOCK') mbacno";
			ResultSet rs = stm.executeQuery(str);     
			while(rs.next()){
				mbacno=rs.getInt("mbacno");   
			}
			String sql="select '"+payacno+"' account,(select description from my_head where doc_no='"+payacno+"') accountname,0 credit,if("+payval+"<0,("+payval+")*-1,"+payval+") debit,if("+payval+"<0,("+payval+")*-1,"+payval+") baseamt,1 id union all select '"+mbacno+"' account,(select description from my_head where doc_no='"+mbacno+"') accountname,if("+mbval+"<0,("+mbval+")*-1,"+mbval+") credit,0 debit,if("+mbval+">0,("+mbval+")*-1,"+mbval+") baseamt,-1 id";
			//System.out.println("jv Query:--->>>  "+sql);	   
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
			 String strsql="select a.accname,a.acno,a.mrfacno,round(if(coalesce(a.pcredit,0)<0,coalesce(a.pcredit,0)*-1,coalesce(a.pcredit,0)),2) pcredit,round(if(coalesce(a.pdebit,0)<0,coalesce(a.pdebit,0)*-1,coalesce(a.pdebit,0)),2) pdebit,round(if(coalesce(b.mcredit,0)<0,coalesce(b.mcredit,0)*-1,coalesce(b.mcredit,0)),2) mcredit,round(if(coalesce(b.mdebit,0)<0,coalesce(b.mdebit,0)*-1,coalesce(b.mdebit,0)),2) mdebit,round((if(coalesce(a.pdebit,0)<0,coalesce(a.pdebit,0)*-1,coalesce(a.pdebit,0))-if(coalesce(a.pcredit,0)<0,coalesce(a.pcredit,0)*-1,coalesce(a.pcredit,0))+if(coalesce(b.mdebit,0)<0,coalesce(b.mdebit,0)*-1,coalesce(b.mdebit,0))-if(coalesce(b.mcredit,0)<0,coalesce(b.mcredit,0)*-1,coalesce(b.mcredit,0))),2) nettotal from (select  m.accname,m.mrf_acno mrfacno,m.acno,if(sum(coalesce(dramount,0))<0,sum(coalesce(dramount,0)),0) pcredit,if(sum(coalesce(dramount,0))>0,sum(coalesce(dramount,0)),0) pdebit,m.doc_no   from rl_propertymaster m left join my_jvtran j on j.acno=m.acno where m.owid='"+ownid+"' and m.status=3 and j.status=3 and j.date<'"+sqlToDate+"' group by m.acno) a left join (select  if(sum(coalesce(dramount,0))<0,sum(coalesce(dramount,0)),0) mcredit,if(sum(coalesce(dramount,0))>0,sum(coalesce(dramount,0)),0) mdebit,m.doc_no from rl_propertymaster m left join my_jvtran j on j.acno=m.mrf_acno where m.owid='"+ownid+"' and m.status=3 and j.status=3 and j.date<'"+sqlToDate+"' group by m.mrf_acno) b on a.doc_no=b.doc_no";
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
	public JSONArray mstatusData(String fromdate,String todate,String id) throws SQLException{  
		JSONArray data=new JSONArray();   
		if(!id.equalsIgnoreCase("1")){
			return data;           
		}
		Connection conn=null; 
		java.sql.Date sqltodate=null;
		java.sql.Date sqlfromdate=null;
		try{
			conn=ClsConnection.getMyConnection();     
			Statement stmt=conn.createStatement();     
			if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
				 sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
				}
			 if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
				 sqltodate=ClsCommon.changeStringtoSqlDate(todate);      
				}          
			 String strsql="select count(*) count,b.* from(select a.* from(select st.name status,r.statusid,r.voc_no from re_mreq r left join re_pstatus st on st.doc_no=r.statusid where r.edate between '"+sqlfromdate+"' and '"+sqltodate+"' and r.confirm=0 and r.status=3)a group by a.voc_no order by statusid asc)b group by statusid";        
			//System.out.println("strsql---->>>"+strsql);
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
