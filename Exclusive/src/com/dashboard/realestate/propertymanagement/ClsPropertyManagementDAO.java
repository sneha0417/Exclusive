package com.dashboard.realestate.propertymanagement;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsPropertyManagementDAO {
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

	public JSONArray getPropertyData(String fromdate,String todate,String id,String status,String cmbmanage) throws SQLException {     
		JSONArray RESULTDATA=new JSONArray();     
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn = null;
		java.sql.Date sqltodate=null;
		java.sql.Date sqlfromdate=null;
		/*sqluptodate=ClsCommon.changeStringtoSqlDate(uptodate);*/
		String str="",sqltest="";
		
		if(status !="")
		{
		  str+=" and m.active="+status;
		}
		if(!cmbmanage.equalsIgnoreCase("")){
    		sqltest+=" and m.mgprpty="+cmbmanage;
    	}
		
		try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmt = conn.createStatement();       
			
			 String strsql="select m.brhid,coalesce(m.optid,'') optid,m.doc_no,m.active pstatus,m.mgprpty,m.prid,m.accname,m.date,m.terms_warranty,o.primary_owner  owner_name,m.unitno unit_number,bm.name Unit_of,pt.code type,ut.unittype unit_type,aa.area,m.landmark,t.transtype transaction_type "
				 		+" , convert(if(m.cnt_no=0,'',DATE_ADD(m.cnt_date, INTERVAL 1 DAY)),char(100)) availability_date,c.msg comment,c.msgdate commentdate,u.user_name commentby,ac.refname tenant,us.user_name statuschangeby,uw.user_name warrantychangeby,ac.per_mob tmobno,ac.mail1 temail,concat(o.mobile,', ',o.mobile2) omobno,concat(o.email,', ',o.email2) oemail, tn.Period_from constdate, tn.Period_to conenddate,coalesce(rv.nettotal,0) rentalval from rl_propertymaster m "
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
						+" where m.status=3   "+str+" "+sqltest+" group by m.doc_no";    
            
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
	
}
