package com.dashboard.realestate.propertyavailability;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.dashboard.ClsDashBoardBean;

import net.sf.json.JSONArray;

public class ClsPropertyAvailabilityDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon =new ClsCommon();
	
	public JSONArray propertylist(String uptodate,String id, String managed, String branchid) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		
		Connection conn = null;
		java.sql.Date sqluptodate=null;
		sqluptodate=ClsCommon.changeStringtoSqlDate(uptodate);
		
		try {
			 conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sqlmanaged="",sqlbrch="";
			System.out.println("managed === "+managed);
			if(managed.equalsIgnoreCase("1")){
				sqlmanaged= " and mgprpty=1 ";
			}
			if(!branchid.equalsIgnoreCase("a") && !branchid.equalsIgnoreCase("0")){
				sqlbrch= " and m.brhid='"+branchid+"' ";     
			}
			/*String strsql="(select  coalesce(count(*),0) value,'Rented' as status,1 relodestatus from  rl_propertymaster m left join  rl_tncm a on m.doc_no=a.prtype where m.status=3   and "+sqluptodate+" between a.period_from and a.period_to and a.status=3   group by m.doc_no)"
					 +" UNION ALL (select sum(nos) value,'Available' as status,2 relodestatus from(select count(*) nos  from  rl_propertymaster m left join (select doc_no docno,period_from, period_to,prtype from rl_tncm where "+sqluptodate+" between period_from and period_to and status=3) a "
					 +" on m.doc_no=a.prtype where m.status=3 and a.prtype is null   group by m.doc_no) a)"
					 +" UNION ALL (select  count(*) value,'All' as status,3 relodestatus  from  rl_propertymaster m  where m.status=3)";*/
			
			/* removed from all query and active=1 */
			String strsql=" select  coalesce(count(*),0) value,'For Rent' as status,1 relodestatus from "
					 +" rl_propertymaster m left join rl_tncm tn on tn.doc_no=m.cnt_no where m.status=3 and m.active=1  and coalesce(tn.renewalstatus,0) not in(1,8,15,17)  and pforrent='Rent' and (m.cnt_date is null or m.cnt_date<'"+sqluptodate+"') "+sqlmanaged+" "+sqlbrch 
					 +" union all "
			 +"select    coalesce(count(*),0) value,'For Sale' as status,2 relodestatus "
			 +" from  rl_propertymaster m left join rl_tncm tn on tn.doc_no=m.cnt_no  where m.status=3 and m.active=1  and coalesce(tn.renewalstatus,0) not in(1,8,15,17)  and pforsale='Sale' and (m.cnt_date is null or m.cnt_date<'"+sqluptodate+"') "+sqlmanaged+" "+sqlbrch ;
			 
			 /*+"union all "
			 +"select  coalesce(count(*),0) value,'All' as status,3 relodestatus from "         
			 +" rl_propertymaster m where status=3  "  ;
			*/
			System.out.println("==== "+strsql);
			ResultSet resultSet = stmt.executeQuery(strsql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			
			CallableStatement s = conn.prepareCall("{CALL zz_spclear()}");
			int val = s.executeUpdate();
			
			}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray getPropertyData(String uptodate,String relodestatus,String id,String managed,String branch) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}      
		
		Connection conn = null;
		java.sql.Date sqluptodate=null;
		sqluptodate=ClsCommon.changeStringtoSqlDate(uptodate);
		
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			
			String strsql="",strbrch="";
			String sqlmanaged="";
			if(managed.equalsIgnoreCase("1")){
				sqlmanaged= " and mgprpty=1 ";
			}
			if(!branch.equalsIgnoreCase("a")){
				strbrch= " and m.brhid='"+branch+"' ";
			}
			/*if(relodestatus.equalsIgnoreCase("1")){
				
				strsql="select m.doc_no,active,prid,if(mgprpty=1,'Y','N') m,substring(pforsale,1,1) s,substring(pforrent,1,1) r,substring(pforhc,1,1) h, m.accname, o.primary_owner  owner_name,m.unitno unit_number,bm.name Unit_of,pt.code type,ut.unittype unit_type,aa.area,m.landmark,t.transtype transaction_type  , convert(if(m.cnt_no=0,'',DATE_ADD(m.cnt_date, INTERVAL 1 DAY)),char(100))  availability_date,area_sq, buildup_area,terms_rentalvaluefrom,desc1,specialnotes,contactperson,conatctnumber,no_of_rooms from rl_propertymaster m left join rl_propertryowner o on o.doc_no=m.owid left join rl_transtype t on t.doc_no=m.ttype left join rl_propertytype pt on pt.doc_no=m.ptype left join rl_unittype ut on ut.doc_no=m.unittype left join my_area aa on aa.doc_no=m.area left join rl_buildingm bm on bm.doc_no=m.unitof "
						+ "where m.status=3 and m.cnt_date>='"+sqluptodate+"' group by m.doc_no;";
				and m.active=1
				strsql="select o.primary_owner  owner_name,m.unitno unit_number,bm.name Unit_of,pt.prtype type,ut.unittype unit_type,"
						+ " aa.area,m.landmark,t.transtype transaction_type,DATE_ADD(m.cnt_date, INTERVAL 1 DAY) availability_date "
					+" from rl_propertymaster m left join rl_propertryowner o on o.doc_no=m.owid"
					+" left join rl_transtype t on t.doc_no=m.ttype"
					+" left join rl_propertytype pt on pt.doc_no=m.prtype"
					+" left join rl_unittype ut on ut.doc_no=m.prunit"
					+" left join my_area aa on aa.doc_no=m.area"
					+" left join rl_buildingm bm on bm.doc_no=m.unitof"
					+" left join rl_tncm a on m.doc_no=a.prtype"
					+" where m.status=3    and m.active=1 and m.cnt_no>0  group by m.doc_no;";
			
			}else if(relodestatus.equalsIgnoreCase("2")){
				
				strsql="select m.doc_no,active,prid,if(mgprpty=1,'Y','N') m,substring(pforsale,1,1) s,substring(pforrent,1,1) r,substring(pforhc,1,1) h, m.accname, o.primary_owner  owner_name,m.unitno unit_number,bm.name Unit_of,pt.code type,ut.unittype unit_type,aa.area,m.landmark,t.transtype transaction_type  , convert(if(m.cnt_no=0,'',DATE_ADD(m.cnt_date, INTERVAL 1 DAY)),char(100))  availability_date,area_sq, buildup_area,terms_rentalvaluefrom,desc1,specialnotes,contactperson,conatctnumber,no_of_rooms from rl_propertymaster m left join rl_propertryowner o on o.doc_no=m.owid left join rl_transtype t on t.doc_no=m.ttype left join rl_propertytype pt on pt.doc_no=m.ptype left join rl_unittype ut on ut.doc_no=m.unittype left join my_area aa on aa.doc_no=m.area left join rl_buildingm bm on bm.doc_no=m.unitof "
						+ "where m.status=3 and (m.cnt_date is null or m.cnt_date<'"+sqluptodate+"')  group by m.doc_no;";
				and m.active=1 
				strsql="select o.primary_owner  owner_name,m.unitno unit_number,bm.name Unit_of,pt.prtype type,ut.unittype "
						+ "unit_type,aa.area,m.landmark,t.transtype transaction_type "
					+" from rl_propertymaster m left join rl_propertryowner o on o.doc_no=m.owid"
					+" left join rl_transtype t on t.doc_no=m.ttype"
					+" left join rl_propertytype pt on pt.doc_no=m.prtype"
					+" left join rl_unittype ut on ut.doc_no=m.prunit"
					+" left join my_area aa on aa.doc_no=m.area"
					+" left join rl_buildingm bm on bm.doc_no=m.unitof"
					+" left join (select doc_no docno,period_from, period_to,prtype from rl_tncm where "+sqluptodate+" between period_from and period_to and status=3) a on m.doc_no=a.prtype"
					+" where m.status=3 and m.active=1 and m.cnt_no=0  group by m.doc_no;";
			
			}else if(relodestatus.equalsIgnoreCase("3")){
				strsql="select m.doc_no,active,prid,if(mgprpty=1,'Y','N') m,substring(pforsale,1,1) s,substring(pforrent,1,1) r,substring(pforhc,1,1) h, m.accname, o.primary_owner  owner_name,m.unitno unit_number,bm.name Unit_of,pt.code type,ut.unittype unit_type,aa.area,m.landmark,t.transtype transaction_type  , convert(if(m.cnt_no=0,'',DATE_ADD(m.cnt_date, INTERVAL 1 DAY)),char(100))  availability_date,area_sq, buildup_area,terms_rentalvaluefrom,desc1,specialnotes,contactperson,conatctnumber,no_of_rooms from rl_propertymaster m left join rl_propertryowner o on o.doc_no=m.owid left join rl_transtype t on t.doc_no=m.ttype left join rl_propertytype pt on pt.doc_no=m.ptype left join rl_unittype ut on ut.doc_no=m.unittype left join my_area aa on aa.doc_no=m.area left join rl_buildingm bm on bm.doc_no=m.unitof "
						+ "where m.status=3    group by m.doc_no;";
				and m.active=1
			}else{
				strsql="";
			}*/
			 if(relodestatus.equalsIgnoreCase("1")){
					
					strsql=" select address1,if(m.cnt_date<curdate(),'',renewalremarks)  remarks,if(m.cnt_date<curdate() or tn.period_to is null ,'Vacant',coalesce(rs.statusname,'',rs.statusname)) statusname,m.doc_no,active,prid,if(mgprpty=1,'Y','N') m,substring(pforsale,1,1) s,substring(pforrent,1,1) r,substring(pforhc,1,1) h, m.accname, o.primary_owner  owner_name,m.unitno unit_number,bm.name Unit_of,pt.code type,ut.unittype unit_type,aa.area,m.landmark,t.transtype transaction_type  , if(convert(if(m.cnt_no=0,'',DATE_ADD(m.cnt_date, INTERVAL 1 DAY)),char(100))='',curdate(),convert(if(m.cnt_no=0,'',DATE_ADD(m.cnt_date, INTERVAL 1 DAY)),char(100)))  availability_date,area_sq, buildup_area,yard,terms_rentalvaluefrom,desc1,specialnotes,contactperson,conatctnumber,SUBSTRING(Ut.UNITTYPE,1,1) no_of_rooms ,tn.period_to expdt  from rl_propertymaster m left join gl_bpmt gp on gp.formid=m.doc_no left join rl_propertryowner o on o.doc_no=m.owid left join rl_transtype t on t.doc_no=m.ttype left join rl_propertytype pt on pt.doc_no=m.ptype left join rl_unittype ut on ut.doc_no=m.unittype left join my_area aa on aa.doc_no=m.area left join rl_buildingm bm on bm.doc_no=m.unitof left join rl_tncm tn on tn.doc_no=m.cnt_no left join rl_contractrenewalstatus rs on rs.doc_no=tn.renewalstatus "
						 + " where m.status=3 and m.active=1 and pforrent='Rent' and coalesce(tn.renewalstatus,0) not in(1,8,15,17) and (m.cnt_date is null or m.cnt_date<'"+sqluptodate+"') "+sqlmanaged+" "+strbrch+" group by m.doc_no  order by ut.unittype ,address1 ;";
				
				
				}else if(relodestatus.equalsIgnoreCase("2")){
					
					strsql="select address1,if(m.cnt_date<curdate(),'',renewalremarks) remarks,if(m.cnt_date<curdate() or tn.period_to is null ,'Vacant',coalesce(rs.statusname,'',rs.statusname))  statusname,m.doc_no,active,prid,if(mgprpty=1,'Y','N') m,substring(pforsale,1,1) s,substring(pforrent,1,1) r,substring(pforhc,1,1) h, m.accname, o.primary_owner  owner_name,m.unitno unit_number,bm.name Unit_of,pt.code type,ut.unittype unit_type,aa.area,m.landmark,t.transtype transaction_type  , if(convert(if(m.cnt_no=0,'',DATE_ADD(m.cnt_date, INTERVAL 1 DAY)),char(100))='',curdate(),convert(if(m.cnt_no=0,'',DATE_ADD(m.cnt_date, INTERVAL 1 DAY)),char(100)))  availability_date,area_sq, buildup_area,yard,terms_rentalvaluefrom,desc1,specialnotes,contactperson,conatctnumber,SUBSTRING(Ut.UNITTYPE,1,1) no_of_rooms,tn.period_to expdt  from rl_propertymaster m left join gl_bpmt gp on gp.formid=m.doc_no left join rl_propertryowner o on o.doc_no=m.owid left join rl_transtype t on t.doc_no=m.ttype left join rl_propertytype pt on pt.doc_no=m.ptype left join rl_unittype ut on ut.doc_no=m.unittype left join my_area aa on aa.doc_no=m.area left join rl_buildingm bm on bm.doc_no=m.unitof left join rl_tncm tn on tn.doc_no=m.cnt_no left join rl_contractrenewalstatus rs on rs.doc_no=tn.renewalstatus "
						 + "where m.status=3 and m.active=1 and pforsale='Sale' and coalesce(tn.renewalstatus,0) not in(1,8,15,17)  and (m.cnt_date is null or m.cnt_date<'"+sqluptodate+"') "+sqlmanaged+" "+strbrch+"  group by m.doc_no order by ut.unittype,address1 ;";
				}
			System.out.println("==== "+strsql);
			ResultSet resultSet = stmt.executeQuery(strsql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
public JSONArray ptypewisedata() throws SQLException {
		
        List<ClsDashBoardBean> fleetStatusBean = new ArrayList<ClsDashBoardBean>();
        
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDashBoard6 = conn.createStatement();            	
			/*	ResultSet resultSet6 = stmtDashBoard6.executeQuery ("select round(aa.val/bb.val *100,2) per,aa.tran_code from (select count(*) val,tran_code from gl_vehmaster vm  where fstatus='L' group by vm.tran_code )aa,"
						+ "(select count(*) val,tran_code from gl_vehmaster vm  where fstatus='L' and tran_code is not null )bb");
			*/
		/*String sqld="select pt.code type,count(case when pm.status =3 and pm.cnt_no=0 then 1 end) num  from rl_propertymaster pm left join rl_propertytype pt on pt.doc_no=pm.prtype where  pm.status=3 group by pt.doc_no";*/
				
				String sqld="select pt.code type,count(case when pm.status =3 and pm.cnt_no=0 then 1 end) num  from rl_propertymaster pm left join rl_propertytype pt on pt.doc_no=pm.prtype where  pm.status=3 group by pt.doc_no";
						 
		ResultSet resultSet6 = stmtDashBoard6.executeQuery(sqld);	
		RESULTDATA=ClsCommon.convertToJSON(resultSet6);					
		stmtDashBoard6.close();
		conn.close();				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
public JSONArray roomewisedata() throws SQLException {
	 
    JSONArray RESULTDATA=new JSONArray();
    Connection conn = null;
	try {
			conn = ClsConnection.getMyConnection();
			Statement stmtDashBoardd = conn.createStatement ();        	
				 
			String sqls="select no_of_rooms room,count(case when status =3 and ucnt_no=0 then 1 end) num  from rl_propertymaster  where  status=3 group by no_of_rooms";
							 
			ResultSet resultSett = stmtDashBoardd.executeQuery(sqls);			
			RESULTDATA=ClsCommon.convertToJSON(resultSett);			
			stmtDashBoardd.close();
			conn.close();
			
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}finally{
		conn.close();
	}
    return RESULTDATA;
}

	
}
