package com.dashboard.realestate.reports;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ClsReportsDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon =new ClsCommon();
	
	public JSONArray mstatusData(String id) throws SQLException{  
		JSONArray data=new JSONArray();   
		if(!id.equalsIgnoreCase("1")){
			return data;           
		}
		Connection conn=null; 
		try{
			conn=ClsConnection.getMyConnection();     
			Statement stmt=conn.createStatement();     
			        
			String strsql="select s.name status,count(*) count,m.statusid  from re_mreq m left join re_pstatus s on s.doc_no=m.statusid where m.edate>='2020-03-01' and m.confirm=0 and m.status=3 group by statusid";        
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
	public JSONArray getPropertyData(String id) throws SQLException{  
		JSONArray data=new JSONArray();   
		if(!id.equalsIgnoreCase("1")){
			return data;           
		}
		Connection conn=null; 
		try{
			conn=ClsConnection.getMyConnection();     
			Statement stmt=conn.createStatement();     
			        
			String strsql="select pt.code type,count(*) total,count(case when pm.cnt_no=0 then 1 end) available, count(case when pm.cnt_no>0 then 1 end) contract ,count(case when pm.cnt_date between curdate() and date_add(curdate() , interval 30 day) then 1 end) expiry1 ,count(case when pm.cnt_date between date_add(curdate() , interval 30 day) and date_add(curdate() , interval 60 day) then 1 end) expiry2, count(case when pforsale='Sale' then 1 end) forsale from rl_propertymaster pm left join rl_propertytype pt on pt.doc_no=pm.ptype where (PM.PFORRENT='Rent' or pforsale='Sale') AND pm.mgprpty=1 and pm.active=1 and pm.status =3 group by pm.ptype;";        
			System.out.println("strsql--->>>"+strsql);
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
	public JSONArray getchartData(String id) throws SQLException{      
		JSONArray data=new JSONArray();   
		if(!id.equalsIgnoreCase("1")){
			return data;           
		}
		Connection conn=null; 
		try{
			conn=ClsConnection.getMyConnection();     
			Statement stmt=conn.createStatement();     
			        
			String strsql="select pt.code type,count(*) total,count(case when pm.cnt_no=0 then 1 end) available, count(case when pm.cnt_no>0 then 1 end) contract , count(case when pforsale='Sale' then 1 end) forsale from rl_propertymaster pm left join rl_propertytype pt on pt.doc_no=pm.ptype where (PM.PFORRENT='Rent' or pforsale='Sale') AND pm.mgprpty=1 and pm.active=1 and pm.status =3 group by pm.ptype;";        
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
	public JSONArray getPropertyDetailsData(String type,String id,String ptype) throws SQLException {             
		JSONArray RESULTDATA=new JSONArray();     
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn = null;
		String sqltest="";    
		if(type.equalsIgnoreCase("AV")){
			sqltest+=" and m.cnt_no=0";  
		}else if(type.equalsIgnoreCase("CO")){
			sqltest+=" and m.cnt_no>0";  
		}else if(type.equalsIgnoreCase("E1")){
			sqltest+=" and m.cnt_date between curdate() and date_add(curdate() , interval 30 day)";  
		}else if(type.equalsIgnoreCase("E2")){
			sqltest+=" and m.cnt_date between date_add(curdate() , interval 30 day) and date_add(curdate() , interval 60 day)";  
		}else if(type.equalsIgnoreCase("FO")){
			sqltest+=" and pforsale='Sale'";  
		}else{}   
		if(!ptype.equalsIgnoreCase("")){
			sqltest+=" and pt.code='"+ptype+"'";         
		}
		try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmt = conn.createStatement();
			
			 String strsql="select m.doc_no,m.active pstatus,m.mgprpty,m.prid,m.accname,m.date,m.terms_warranty,o.primary_owner  owner_name,m.unitno unit_number,bm.name Unit_of,pt.code type,ut.unittype unit_type,aa.area,m.landmark,t.transtype transaction_type "
			 		+" , convert(if(m.cnt_no=0,'',DATE_ADD(m.cnt_date, INTERVAL 1 DAY)),char(100)) availability_date,c.msg comment,c.msgdate commentdate,u.user_name commentby,ac.refname tenant,us.user_name statuschangeby,uw.user_name warrantychangeby,ac.per_mob tmobno,ac.mail1 temail,o.mobile omobno,o.email oemail, tn.Period_from constdate, tn.Period_to conenddate,coalesce(rv.nettotal,0) rentalval from rl_propertymaster m "
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
					+" left join rl_tncm tn on tn.doc_no=m.cnt_no left join rl_tncterms rv on rv.rdocno=m.doc_no and rv.idno=1 "
					+" left join my_acbook ac on ac.cldocno=tn.cldocno and ac.dtype='crm'"
					+" where (m.PFORRENT='Rent' or pforsale='Sale') and m.mgprpty=1 and m.active=1 and m.status=3 "+sqltest+" group by m.doc_no";     
            
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
	public JSONArray getMaintenanceData(String id,String status) throws SQLException {     
		JSONArray RESULTDATA=new JSONArray();     
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn = null;
		String sqltest="";
		if(!status.equalsIgnoreCase("")){
			 sqltest+=" and r.statusid='"+status+"'";	
		}
		try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmt = conn.createStatement();
			 String strsql="select a.* from(select coalesce(p.owid,0) owid,round(coalesce(rm.total,0),2) total,r.jv_vocno,r.blockamt,r.jvtrno,st.name status,p.acno owneracno,r.branch brhid,r.posttrno,p.mrf_acno mrfacno,r.margin,o.acno accountno,o.account_name accountname,ac.acno,r.doc_no,r.voc_no,r.edate date,j.job_desc job,r.comments,ac.refname tenant,if(p.mgprpty=1,'Y','N') managed,p.prid,p.accname property,o.primary_owner owner_name,p.unitno unit_number,r.priority,round(r.est_amt,2) estcost,h.description proname,h.account proacno,if(p.mgprpty=1,'Managed','Non Managed') classified from re_mreq r left join my_acbook ac on (ac.cldocno=r.tdoc_no and ac.dtype='crm') left join rl_propertymaster p on (p.doc_no=r.pdoc_no) left join rl_propertryowner o on o.doc_no=p.owid left join rl_jobmaster j on j.doc_no=r.job_docno left join my_head h on (h.doc_no=r.jbprov and h.atype='ap')"       
						+" left join re_pstatus st on st.doc_no=r.statusid left join (select sum(total) total,rvocno,rbrhid  from re_mreqmgmt group by rvocno) rm on (rm.rvocno=r.voc_no and rm.rbrhid=r.branch) where r.edate>='2020-03-01' and  r.status=3 and confirm=0 "+sqltest+" order by statusid desc)a group by a.doc_no";     
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
	
	public  JSONArray convertRowArrayToJSON(ArrayList<ArrayList<String>> rowsList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < rowsList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			ArrayList<String> rowArray=rowsList.get(i);
			obj.put("name",rowArray.get(0));
			for (int k=1; k < 7; k++) {
					obj.put("month"+k,rowArray.get(k));      
			}
			jsonArray.add(obj);   
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("rows",jsonArray);
		jsonArray1.add(obj1);
		return jsonArray1;
	 }
	 
	  public  JSONArray convertColumnArrayToJSON(ArrayList<String> columnsList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < columnsList.size(); i++) {
			
			JSONObject obj = new JSONObject();    
			
			String[] columnArray=columnsList.get(i).split("::");
			
			obj.put("text",columnArray[0]);
			obj.put("datafield",columnArray[1]);
			
			if(!(columnArray[2].trim().equalsIgnoreCase(""))){
				obj.put("width",columnArray[2]);
		    }
			
			jsonArray.add(obj);
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("columns",jsonArray);   
		jsonArray1.add(obj1);
		return jsonArray1;
		}
	  public JSONArray dproData(String id)  throws SQLException {
			
			 JSONArray RESULTDATA=new JSONArray();
			 JSONArray ROWDATA=new JSONArray();
			 JSONArray COLUMNDATA=new JSONArray();
			 if(!id.equalsIgnoreCase("1")){
				 return RESULTDATA;
			 }
			 Connection conn =  null;
			
			 try {
				 conn = ClsConnection.getMyConnection();
				 Statement stmt = conn.createStatement();
				 ArrayList<String> columnarray= new ArrayList<String>();
				 columnarray.add("::name::40%:: ");     
				 String sqlinsp1="",sqlinsp2="",sqlinsp3="",sqlinsp4="",sqlinsp5="",sqlinsp6="",sqlmrwrk1="",sqlmrwrk2="",sqlmrwrk3="",sqlmrwrk4="",sqlmrwrk5="",sqlmrwrk6="",sqlmr1="",sqlmr2="",sqlmr3="",sqlmr4="",sqlmr5="",sqlmr6="",sqlcolumn = "",sqlrow="",sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sqlrow1="",sqlrow2="",sqlrow3="",sqlrow4="",sqlrow5="",sqlrow6="",sqlscdle1="",sqlscdle2="",sqlscdle3="",sqlscdle4="",sqlscdle5="",sqlscdle6="";
				 
				 sql1="if(date between date_add(last_day(date_sub(curdate() , interval 6 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 6 month)), interval 1 day)),1,0)";
				 sql2="if(date between date_add(last_day(date_sub(curdate() , interval 5 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 5 month)), interval 1 day)),1,0)";
				 sql3="if(date between date_add(last_day(date_sub(curdate() , interval 4 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 4 month)), interval 1 day)),1,0)";
				 sql4="if(date between date_add(last_day(date_sub(curdate() , interval 3 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 3 month)), interval 1 day)),1,0)";
				 sql5="if(date between date_add(last_day(date_sub(curdate() , interval 2 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 2 month)), interval 1 day)),1,0)";
				 sql6="if(date between date_add(last_day(date_sub(curdate() , interval 1 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 1 month)), interval 1 day)),1,0)";
				
				 sqlmr1="if(edate between date_add(last_day(date_sub(curdate() , interval 6 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 6 month)), interval 1 day)),1,0)";
				 sqlmr2="if(edate between date_add(last_day(date_sub(curdate() , interval 5 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 5 month)), interval 1 day)),1,0)";
				 sqlmr3="if(edate between date_add(last_day(date_sub(curdate() , interval 4 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 4 month)), interval 1 day)),1,0)";
				 sqlmr4="if(edate between date_add(last_day(date_sub(curdate() , interval 3 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 3 month)), interval 1 day)),1,0)";
				 sqlmr5="if(edate between date_add(last_day(date_sub(curdate() , interval 2 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 2 month)), interval 1 day)),1,0)";
				 sqlmr6="if(edate between date_add(last_day(date_sub(curdate() , interval 1 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 1 month)), interval 1 day)),1,0)";
				   
				 sqlmrwrk1="if(wdate between date_add(last_day(date_sub(curdate() , interval 6 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 6 month)), interval 1 day)),1,0)";
				 sqlmrwrk2="if(wdate between date_add(last_day(date_sub(curdate() , interval 5 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 5 month)), interval 1 day)),1,0)";
				 sqlmrwrk3="if(wdate between date_add(last_day(date_sub(curdate() , interval 4 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 4 month)), interval 1 day)),1,0)";
				 sqlmrwrk4="if(wdate between date_add(last_day(date_sub(curdate() , interval 3 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 3 month)), interval 1 day)),1,0)";
				 sqlmrwrk5="if(wdate between date_add(last_day(date_sub(curdate() , interval 2 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 2 month)), interval 1 day)),1,0)";
				 sqlmrwrk6="if(wdate between date_add(last_day(date_sub(curdate() , interval 1 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 1 month)), interval 1 day)),1,0)";
				       
				 sqlinsp1="if(inspdate between date_add(last_day(date_sub(curdate() , interval 6 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 6 month)), interval 1 day)),1,0)";
				 sqlinsp2="if(inspdate between date_add(last_day(date_sub(curdate() , interval 5 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 5 month)), interval 1 day)),1,0)";
				 sqlinsp3="if(inspdate between date_add(last_day(date_sub(curdate() , interval 4 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 4 month)), interval 1 day)),1,0)";
				 sqlinsp4="if(inspdate between date_add(last_day(date_sub(curdate() , interval 3 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 3 month)), interval 1 day)),1,0)";
				 sqlinsp5="if(inspdate between date_add(last_day(date_sub(curdate() , interval 2 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 2 month)), interval 1 day)),1,0)";
				 sqlinsp6="if(inspdate between date_add(last_day(date_sub(curdate() , interval 1 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 1 month)), interval 1 day)),1,0)";
				 
				 sqlscdle1="if(ins_date between date_add(last_day(date_sub(curdate() , interval 6 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 6 month)), interval 1 day)),1,0)";
				 sqlscdle2="if(ins_date between date_add(last_day(date_sub(curdate() , interval 5 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 5 month)), interval 1 day)),1,0)";
				 sqlscdle3="if(ins_date between date_add(last_day(date_sub(curdate() , interval 4 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 4 month)), interval 1 day)),1,0)";
				 sqlscdle4="if(ins_date between date_add(last_day(date_sub(curdate() , interval 3 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 3 month)), interval 1 day)),1,0)";
				 sqlscdle5="if(ins_date between date_add(last_day(date_sub(curdate() , interval 2 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 2 month)), interval 1 day)),1,0)";
				 sqlscdle6="if(ins_date between date_add(last_day(date_sub(curdate() , interval 1 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 1 month)), interval 1 day)),1,0)";
				 
				 sqlrow1="concat(SUBSTRING(monthname(date_add(last_day(date_sub(curdate() , interval 6 month)), interval 1 day)),1,3),' ',year(date_add(last_day(date_sub(curdate() , interval 6 month)), interval 1 day)))";
				 sqlrow2="concat(SUBSTRING(monthname(date_add(last_day(date_sub(curdate() , interval 5 month)), interval 1 day)),1,3),' ',year(date_add(last_day(date_sub(curdate() , interval 5 month)), interval 1 day)))";
				 sqlrow3="concat(SUBSTRING(monthname(date_add(last_day(date_sub(curdate() , interval 4 month)), interval 1 day)),1,3),' ',year(date_add(last_day(date_sub(curdate() , interval 4 month)), interval 1 day)))";
				 sqlrow4="concat(SUBSTRING(monthname(date_add(last_day(date_sub(curdate() , interval 3 month)), interval 1 day)),1,3),' ',year(date_add(last_day(date_sub(curdate() , interval 3 month)), interval 1 day)))";
				 sqlrow5="concat(SUBSTRING(monthname(date_add(last_day(date_sub(curdate() , interval 2 month)), interval 1 day)),1,3),' ',year(date_add(last_day(date_sub(curdate() , interval 2 month)), interval 1 day)))";
				 sqlrow6="concat(SUBSTRING(monthname(date_add(last_day(date_sub(curdate() , interval 1 month)), interval 1 day)),1,3),' ',year(date_add(last_day(date_sub(curdate() , interval 1 month)), interval 1 day)))";     
				 
				 sqlcolumn = "select 1 seq,("+sqlrow1+") counts union all select 2 seq,("+sqlrow2+") counts union all select 3 seq,("+sqlrow3+") counts union all select 4 seq,("+sqlrow4+") counts union all select 5 seq,("+sqlrow5+") counts union all select 6 seq,("+sqlrow6+") counts";       
				 //System.out.println("sqlcolumn--->>>"+sqlcolumn);   
				 ResultSet resultSet = stmt.executeQuery(sqlcolumn);
				 while(resultSet.next()){
					 columnarray.add(resultSet.getString("counts")+"::month"+resultSet.getInt("seq")+"::10%:: ");
				 }
			     
				 sqlrow = "select sum(month1) month1,sum(month2) month2,sum(month3) month3,sum(month4) month4,sum(month5) month5,sum(month6) month6,count,name from (select "+sql1+" month1,"+sql2+" month2,"+sql3+" month3,"+sql4+" month4,"+sql5+" month5,"+sql6+" month6,1 count,'New property added' name from rl_propertymaster where status=3 union all select "+sql1+" month1,"+sql2+" month2,"+sql3+" month3,"+sql4+" month4,"+sql5+" month5,"+sql6+" month6,2 count,'Contracted New' name from rl_tncm where renewaldocno=0 and status=3 union all select "+sql1+" month1,"+sql2+" month2,"+sql3+" month3,"+sql4+" month4,"+sql5+" month5,"+sql6+" month6,3 count,'Tenancy Renewal' name from rl_tncm where renewaldocno>0 and status=3 union all select month1,month2,month3,month4,month5,month6,count,name from(select voc_no,"+sqlmr1+" month1,"+sqlmr2+" month2,"+sqlmr3+" month3,"+sqlmr4+" month4,"+sqlmr5+" month5,"+sqlmr6+" month6,4 count,'Tenant Requested' name from re_mreq where status=3 and confirm=0)a group by voc_no union all select month1,month2,month3,month4,month5,month6,count,name from(select voc_no,"+sqlmrwrk1+" month1,"+sqlmrwrk2+" month2,"+sqlmrwrk3+" month3,"+sqlmrwrk4+" month4,"+sqlmrwrk5+" month5,"+sqlmrwrk6+" month6,5 count,'Tenant Requested Completed' name from re_mreq where status=3 and confirm=0)a group by voc_no  union all select "+sqlinsp1+" month1,"+sqlinsp2+" month2,"+sqlinsp3+" month3,"+sqlinsp4+" month4,"+sqlinsp5+" month5,"+sqlinsp6+" month6,6 count,'Inspected' name from rl_propinspm where status=3 and  skipped=0 union all select "+sqlscdle1+" month1,"+sqlscdle2+" month2,"+sqlscdle3+" month3,"+sqlscdle4+" month4,"+sqlscdle5+" month5,"+sqlscdle6+" month6,7 count,'Scheduled(Not executed)' name from rl_propertymaster where status=3 union all select "+sqlinsp1+" month1,"+sqlinsp2+" month2,"+sqlinsp3+" month3,"+sqlinsp4+" month4,"+sqlinsp5+" month5,"+sqlinsp6+" month6,8 count,'Skipped' name from rl_propinspm where status=3 and skipped=1)a group by count";
				 //System.out.println("sqlrow--->>>"+sqlrow);                                   
				 ResultSet resultSet1 = stmt.executeQuery(sqlrow);
				 
				 ArrayList<ArrayList<String>> rowarray= new ArrayList<ArrayList<String>>();
				 while(resultSet1.next()){
						ArrayList<String> temp=new ArrayList<String>();
						temp.add(resultSet1.getString("name"));
						temp.add(resultSet1.getString("month1"));
						temp.add(resultSet1.getString("month2"));
						temp.add(resultSet1.getString("month3"));
						temp.add(resultSet1.getString("month4"));
						temp.add(resultSet1.getString("month5"));    
						temp.add(resultSet1.getString("month6"));
						rowarray.add(temp);
				 }
				 //System.out.println("rowarray--->>>"+rowarray); 
					 COLUMNDATA=convertColumnArrayToJSON(columnarray);
					 ROWDATA=convertRowArrayToJSON(rowarray);
				 
					 JSONArray detailsarray=new JSONArray();
				 
					 detailsarray.addAll(COLUMNDATA);
					 detailsarray.addAll(ROWDATA);
				     //System.out.println("detailsarray--->>>"+detailsarray); 
					 RESULTDATA=detailsarray;
				 
				 stmt.close();
				 conn.close();

				} catch(Exception e){
				    e.printStackTrace();
				    conn.close();
			  }
			 return RESULTDATA;
	     }
	  
	  public JSONArray loadpropertyStatistics(String mtype,String id) throws SQLException {             
			JSONArray RESULTDATA=new JSONArray();     
			if(!id.equalsIgnoreCase("1")){
				return RESULTDATA;
			}
			Connection conn = null;
			String sqltest="";
			try {
				 conn = ClsConnection.getMyConnection();
				 Statement stmt = conn.createStatement();
				 if(mtype.equalsIgnoreCase("M1")){
					 sqltest=" and m.date between date_add(last_day(date_sub(curdate() , interval 6 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 6 month)), interval 1 day))"; 
				 }else if(mtype.equalsIgnoreCase("M2")){
					 sqltest=" and m.date between date_add(last_day(date_sub(curdate() , interval 5 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 5 month)), interval 1 day))";
				 }else if(mtype.equalsIgnoreCase("M3")){
					 sqltest=" and m.date between date_add(last_day(date_sub(curdate() , interval 4 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 4 month)), interval 1 day))";
				 }else if(mtype.equalsIgnoreCase("M4")){
					 sqltest=" and m.date between date_add(last_day(date_sub(curdate() , interval 3 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 3 month)), interval 1 day))";
				 }else if(mtype.equalsIgnoreCase("M5")){
					 sqltest=" and m.date between date_add(last_day(date_sub(curdate() , interval 2 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 2 month)), interval 1 day))";
				 }else if(mtype.equalsIgnoreCase("M6")){
					 sqltest=" and m.date between date_add(last_day(date_sub(curdate() , interval 1 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 1 month)), interval 1 day))";  
				 }else{}   
				 String strsql="select m.doc_no,m.active pstatus,m.mgprpty,m.prid,m.accname,m.date,m.terms_warranty,o.primary_owner  owner_name,m.unitno unit_number,bm.name Unit_of,pt.code type,ut.unittype unit_type,aa.area,m.landmark,t.transtype transaction_type "
					 		+" , convert(if(m.cnt_no=0,'',DATE_ADD(m.cnt_date, INTERVAL 1 DAY)),char(100)) availability_date,c.msg comment,c.msgdate commentdate,u.user_name commentby,ac.refname tenant,us.user_name statuschangeby,uw.user_name warrantychangeby,ac.per_mob tmobno,ac.mail1 temail,o.mobile omobno,o.email oemail, tn.Period_from constdate, tn.Period_to conenddate,coalesce(rv.nettotal,0) rentalval from rl_propertymaster m "
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
							+" left join rl_tncm tn on tn.doc_no=m.cnt_no  left join rl_tncterms rv on rv.rdocno=m.doc_no and rv.idno=1 "
							+" left join my_acbook ac on ac.cldocno=tn.cldocno and ac.dtype='crm'"
							+" where m.status=3  "+sqltest+" group by m.doc_no";    
	            
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
	  public   JSONArray loadcontractsStatistics(String mtype,String id) throws SQLException {
			JSONArray data=new JSONArray();
		    if(!id.equalsIgnoreCase("1")){     
		    	return data;
		    }
		    String sqltest="";
	     	Connection conn = null;
			try {
				conn = ClsConnection.getMyConnection();        
				Statement stm = conn.createStatement ();   
				if(mtype.equalsIgnoreCase("M1")){
					 sqltest=" and m.date between date_add(last_day(date_sub(curdate() , interval 6 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 6 month)), interval 1 day))"; 
				 }else if(mtype.equalsIgnoreCase("M2")){
					 sqltest=" and m.date between date_add(last_day(date_sub(curdate() , interval 5 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 5 month)), interval 1 day))";
				 }else if(mtype.equalsIgnoreCase("M3")){
					 sqltest=" and m.date between date_add(last_day(date_sub(curdate() , interval 4 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 4 month)), interval 1 day))";
				 }else if(mtype.equalsIgnoreCase("M4")){
					 sqltest=" and m.date between date_add(last_day(date_sub(curdate() , interval 3 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 3 month)), interval 1 day))";
				 }else if(mtype.equalsIgnoreCase("M5")){
					 sqltest=" and m.date between date_add(last_day(date_sub(curdate() , interval 2 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 2 month)), interval 1 day))";
				 }else if(mtype.equalsIgnoreCase("M6")){
					 sqltest=" and m.date between date_add(last_day(date_sub(curdate() , interval 1 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 1 month)), interval 1 day))";  
				 }else{} 
				String sql="select coalesce(ownerhead.description,'') owneraccountname,coalesce(tenanthead.description,'') tenantaccountname,coalesce(mrfhead.description,'') mrfaccountname,coalesce(ac.acno,0) tenantacno,coalesce(pr.acno,0) owneracno,coalesce(pr.mrf_acno,0) mrfacno,coalesce(pr.unitno,'') unitno,coalesce(m.renewalremarks,'') renewalremarks,m.clstatus,pr.cnt_no propcontractno, m.brhid,pr.doc_no propdocno,m.doc_no,m.voc_no,ac.refname tenantname,ac.per_mob tenantmobile,ac.mail1 tenantemail,coalesce(pr.prid,'') propid,"+
				" coalesce(pr.accname,'') propname,date_sub(m.period_to,interval m.not_period day) notifydate,m.period_from fromdate,m.period_to todate,coalesce(st.statusname,'')"+
				" renewalstatus,round(coalesce(amt.amount,0),2) rent,ownhead.primary_owner owner from rl_tncm m left join rl_propertymaster pr on m.prtype=pr.doc_no left join"+
				" my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM') left join rl_contractrenewalstatus st on"+
				" (m.renewalstatus=st.doc_no and st.status=3) left join (select amount,rdocno from rl_tncterms where idno=1 group by rdocno) amt"+
				" on (m.doc_no=amt.rdocno) left join rl_propertryowner ownhead on (pr.owid=ownhead.doc_no) left join my_head tenanthead on ac.acno=tenanthead.doc_no left join my_head ownerhead on pr.acno=ownerhead.doc_no left join my_head mrfhead on pr.mrf_acno=mrfhead.doc_no where m.renewaldocno=0 and m.status=3 "+sqltest;   
				//System.out.println("Tenancy Mgmt Query:  "+sql);	
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
	  public   JSONArray loadrenewalStatistics(String mtype,String id) throws SQLException {
			JSONArray data=new JSONArray();
		    if(!id.equalsIgnoreCase("1")){     
		    	return data;
		    }
		    String sqltest="";
	     	Connection conn = null;
			try {
				conn = ClsConnection.getMyConnection();        
				Statement stm = conn.createStatement ();   
				if(mtype.equalsIgnoreCase("M1")){    
					 sqltest=" and m.date between date_add(last_day(date_sub(curdate() , interval 6 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 6 month)), interval 1 day))"; 
				 }else if(mtype.equalsIgnoreCase("M2")){
					 sqltest=" and m.date between date_add(last_day(date_sub(curdate() , interval 5 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 5 month)), interval 1 day))";
				 }else if(mtype.equalsIgnoreCase("M3")){
					 sqltest=" and m.date between date_add(last_day(date_sub(curdate() , interval 4 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 4 month)), interval 1 day))";
				 }else if(mtype.equalsIgnoreCase("M4")){
					 sqltest=" and m.date between date_add(last_day(date_sub(curdate() , interval 3 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 3 month)), interval 1 day))";
				 }else if(mtype.equalsIgnoreCase("M5")){
					 sqltest=" and m.date between date_add(last_day(date_sub(curdate() , interval 2 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 2 month)), interval 1 day))";
				 }else if(mtype.equalsIgnoreCase("M6")){
					 sqltest=" and m.date between date_add(last_day(date_sub(curdate() , interval 1 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 1 month)), interval 1 day))";  
				 }else{} 
				String sql="select coalesce(ownerhead.description,'') owneraccountname,coalesce(tenanthead.description,'') tenantaccountname,coalesce(mrfhead.description,'') mrfaccountname,coalesce(ac.acno,0) tenantacno,coalesce(pr.acno,0) owneracno,coalesce(pr.mrf_acno,0) mrfacno,coalesce(pr.unitno,'') unitno,coalesce(m.renewalremarks,'') renewalremarks,m.clstatus,pr.cnt_no propcontractno, m.brhid,pr.doc_no propdocno,m.doc_no,m.voc_no,ac.refname tenantname,ac.per_mob tenantmobile,ac.mail1 tenantemail,coalesce(pr.prid,'') propid,"+
				" coalesce(pr.accname,'') propname,date_sub(m.period_to,interval m.not_period day) notifydate,m.period_from fromdate,m.period_to todate,coalesce(st.statusname,'')"+
				" renewalstatus,round(coalesce(amt.amount,0),2) rent,ownhead.primary_owner owner from rl_tncm m left join rl_propertymaster pr on m.prtype=pr.doc_no left join"+
				" my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM') left join rl_contractrenewalstatus st on"+
				" (m.renewalstatus=st.doc_no and st.status=3) left join (select amount,rdocno from rl_tncterms where idno=1 group by rdocno) amt"+
				" on (m.doc_no=amt.rdocno) left join rl_propertryowner ownhead on (pr.owid=ownhead.doc_no) left join my_head tenanthead on ac.acno=tenanthead.doc_no left join my_head ownerhead on pr.acno=ownerhead.doc_no left join my_head mrfhead on pr.mrf_acno=mrfhead.doc_no where m.renewaldocno>0 and m.status=3 "+sqltest;   
				//System.out.println("Tenancy Mgmt Query:  "+sql);	
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
	  public JSONArray loadtrequestStatistics(String mtype,String id) throws SQLException {     
			JSONArray RESULTDATA=new JSONArray();     
			if(!id.equalsIgnoreCase("1")){
				return RESULTDATA;
			}
			Connection conn = null;
			String sqltest="";
			try {
				 conn = ClsConnection.getMyConnection();
				 Statement stmt = conn.createStatement();
				 if(mtype.equalsIgnoreCase("M1")){    
					 sqltest=" and r.edate between date_add(last_day(date_sub(curdate() , interval 6 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 6 month)), interval 1 day))"; 
				 }else if(mtype.equalsIgnoreCase("M2")){
					 sqltest=" and r.edate between date_add(last_day(date_sub(curdate() , interval 5 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 5 month)), interval 1 day))";
				 }else if(mtype.equalsIgnoreCase("M3")){
					 sqltest=" and r.edate between date_add(last_day(date_sub(curdate() , interval 4 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 4 month)), interval 1 day))";
				 }else if(mtype.equalsIgnoreCase("M4")){
					 sqltest=" and r.edate between date_add(last_day(date_sub(curdate() , interval 3 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 3 month)), interval 1 day))";
				 }else if(mtype.equalsIgnoreCase("M5")){
					 sqltest=" and r.edate between date_add(last_day(date_sub(curdate() , interval 2 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 2 month)), interval 1 day))";
				 }else if(mtype.equalsIgnoreCase("M6")){
					 sqltest=" and r.edate between date_add(last_day(date_sub(curdate() , interval 1 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 1 month)), interval 1 day))";  
				 }else{} 
				 String strsql="select a.* from(select coalesce(p.owid,0) owid,round(coalesce(rm.total,0),2) total,r.jv_vocno,r.blockamt,r.jvtrno,st.name status,p.acno owneracno,r.branch brhid,r.posttrno,p.mrf_acno mrfacno,r.margin,o.acno accountno,o.account_name accountname,ac.acno,r.doc_no,r.voc_no,r.edate date,j.job_desc job,r.comments,ac.refname tenant,if(p.mgprpty=1,'Y','N') managed,p.prid,p.accname property,o.primary_owner owner_name,p.unitno unit_number,r.priority,round(r.est_amt,2) estcost,h.description proname,h.account proacno,if(p.mgprpty=1,'Managed','Non Managed') classified from re_mreq r left join my_acbook ac on (ac.cldocno=r.tdoc_no and ac.dtype='crm') left join rl_propertymaster p on (p.doc_no=r.pdoc_no) left join rl_propertryowner o on o.doc_no=p.owid left join rl_jobmaster j on j.doc_no=r.job_docno left join my_head h on (h.doc_no=r.jbprov and h.atype='ap')"       
							+" left join re_pstatus st on st.doc_no=r.statusid left join (select sum(total) total,rvocno,rbrhid  from re_mreqmgmt group by rvocno) rm on (rm.rvocno=r.voc_no and rm.rbrhid=r.branch) where r.status=3 and confirm=0 "+sqltest+" order by statusid desc)a group by a.voc_no"; 
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
	  public JSONArray loadtreqcompleteStatistics(String mtype,String id) throws SQLException {     
			JSONArray RESULTDATA=new JSONArray();     
			if(!id.equalsIgnoreCase("1")){
				return RESULTDATA;
			}
			Connection conn = null;
			String sqltest="";
			try {
				 conn = ClsConnection.getMyConnection();
				 Statement stmt = conn.createStatement();
				 if(mtype.equalsIgnoreCase("M1")){    
					 sqltest=" and r.wdate between date_add(last_day(date_sub(curdate() , interval 6 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 6 month)), interval 1 day))"; 
				 }else if(mtype.equalsIgnoreCase("M2")){
					 sqltest=" and r.wdate between date_add(last_day(date_sub(curdate() , interval 5 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 5 month)), interval 1 day))";
				 }else if(mtype.equalsIgnoreCase("M3")){
					 sqltest=" and r.wdate between date_add(last_day(date_sub(curdate() , interval 4 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 4 month)), interval 1 day))";
				 }else if(mtype.equalsIgnoreCase("M4")){
					 sqltest=" and r.wdate between date_add(last_day(date_sub(curdate() , interval 3 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 3 month)), interval 1 day))";
				 }else if(mtype.equalsIgnoreCase("M5")){
					 sqltest=" and r.wdate between date_add(last_day(date_sub(curdate() , interval 2 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 2 month)), interval 1 day))";
				 }else if(mtype.equalsIgnoreCase("M6")){
					 sqltest=" and r.wdate between date_add(last_day(date_sub(curdate() , interval 1 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 1 month)), interval 1 day))";  
				 }else{} 
				 String strsql="select a.* from(select coalesce(p.owid,0) owid,round(coalesce(rm.total,0),2) total,r.jv_vocno,r.blockamt,r.jvtrno,st.name status,p.acno owneracno,r.branch brhid,r.posttrno,p.mrf_acno mrfacno,r.margin,o.acno accountno,o.account_name accountname,ac.acno,r.doc_no,r.voc_no,r.edate date,j.job_desc job,r.comments,ac.refname tenant,if(p.mgprpty=1,'Y','N') managed,p.prid,p.accname property,o.primary_owner owner_name,p.unitno unit_number,r.priority,round(r.est_amt,2) estcost,h.description proname,h.account proacno,if(p.mgprpty=1,'Managed','Non Managed') classified from re_mreq r left join my_acbook ac on (ac.cldocno=r.tdoc_no and ac.dtype='crm') left join rl_propertymaster p on (p.doc_no=r.pdoc_no) left join rl_propertryowner o on o.doc_no=p.owid left join rl_jobmaster j on j.doc_no=r.job_docno left join my_head h on (h.doc_no=r.jbprov and h.atype='ap')"       
							+" left join re_pstatus st on st.doc_no=r.statusid left join (select sum(total) total,rvocno,rbrhid  from re_mreqmgmt group by rvocno) rm on (rm.rvocno=r.voc_no and rm.rbrhid=r.branch) where r.status=3 and confirm=0 "+sqltest+" order by statusid desc)a group by a.voc_no"; 
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
	  public   JSONArray loadinspStatistics(String type,String mtype,String id) throws SQLException {
			JSONArray data=new JSONArray();
		    if(!id.equalsIgnoreCase("1")){
		    	return data;
		    }
		    String sqltest="",sql="";      
	     	Connection conn = null;
			try {
				conn = ClsConnection.getMyConnection();
				Statement stm = conn.createStatement (); 
				if(type.equalsIgnoreCase("INS")){
					if(mtype.equalsIgnoreCase("M1")){    
						 sqltest=" and m.inspdate between date_add(last_day(date_sub(curdate() , interval 6 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 6 month)), interval 1 day))"; 
					 }else if(mtype.equalsIgnoreCase("M2")){
						 sqltest=" and m.inspdate between date_add(last_day(date_sub(curdate() , interval 5 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 5 month)), interval 1 day))";
					 }else if(mtype.equalsIgnoreCase("M3")){
						 sqltest=" and m.inspdate between date_add(last_day(date_sub(curdate() , interval 4 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 4 month)), interval 1 day))";
					 }else if(mtype.equalsIgnoreCase("M4")){
						 sqltest=" and m.inspdate between date_add(last_day(date_sub(curdate() , interval 3 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 3 month)), interval 1 day))";
					 }else if(mtype.equalsIgnoreCase("M5")){
						 sqltest=" and m.inspdate between date_add(last_day(date_sub(curdate() , interval 2 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 2 month)), interval 1 day))";
					 }else if(mtype.equalsIgnoreCase("M6")){
						 sqltest=" and m.inspdate between date_add(last_day(date_sub(curdate() , interval 1 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 1 month)), interval 1 day))";  
					 }else{}
				    sql="select inspdate,u.user_name user,insdate,m.doc_no from rl_propinspm m left join my_user u on u.doc_no=m.userid where m.skipped=0 and m.status=3 "+sqltest+"";
				}else if(type.equalsIgnoreCase("SKP")){   
					if(mtype.equalsIgnoreCase("M1")){    
						 sqltest=" and m.inspdate between date_add(last_day(date_sub(curdate() , interval 6 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 6 month)), interval 1 day))"; 
					 }else if(mtype.equalsIgnoreCase("M2")){
						 sqltest=" and m.inspdate between date_add(last_day(date_sub(curdate() , interval 5 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 5 month)), interval 1 day))";
					 }else if(mtype.equalsIgnoreCase("M3")){
						 sqltest=" and m.inspdate between date_add(last_day(date_sub(curdate() , interval 4 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 4 month)), interval 1 day))";
					 }else if(mtype.equalsIgnoreCase("M4")){
						 sqltest=" and m.inspdate between date_add(last_day(date_sub(curdate() , interval 3 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 3 month)), interval 1 day))";
					 }else if(mtype.equalsIgnoreCase("M5")){
						 sqltest=" and m.inspdate between date_add(last_day(date_sub(curdate() , interval 2 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 2 month)), interval 1 day))";
					 }else if(mtype.equalsIgnoreCase("M6")){
						 sqltest=" and m.inspdate between date_add(last_day(date_sub(curdate() , interval 1 month)), interval 1 day) and last_day(date_add(last_day(date_sub(curdate() , interval 1 month)), interval 1 day))";  
					 }else{}
				    sql="select inspdate,u.user_name user,insdate,m.doc_no from rl_propinspm m left join my_user u on u.doc_no=m.userid where m.skipped=1 and m.status=3 "+sqltest+"";  
	
				}else{}
			    //System.out.println("Inspection Mgmt Query:  "+sql);	
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
}
