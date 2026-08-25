package com.dashboard.realestate.inspectionmanagement;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsInspectionManagementDAO {
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
		
		try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmt = conn.createStatement();
			 if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
				 sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
				}
			 if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
				 sqltodate=ClsCommon.changeStringtoSqlDate(todate);   
				}
			 String strsql="select p.doc_no pdocno,if(round(timestampdiff(month,t.period_from,p.ins_date)/(case when p.terms_insptype='M' then 1 when p.terms_insptype='Q' then 3 when p.terms_insptype='HY' then 6 else 0 end),0)=0,1,round(timestampdiff(month,t.period_from,p.ins_date)/(case when p.terms_insptype='M' then 1 when p.terms_insptype='Q' then 3 when p.terms_insptype='HY' then 6 else 0 end))) seqno,coalesce(p.terms_insptype,'') instype,p.unitno,st.name status,p.ins_date,u.user_name as uname,p.doc_no,p.date pdate,t.doc_no tdocno,t.Period_from tdate,p.accname property,if(aliasname !='',aliasname,primary_owner) owner,m.refname tenant,m.mail1 as tenantemail,case when p.terms_insptype='HY' then 'Half Yearly' when  p.terms_insptype='M' then 'Monthly' when p.terms_insptype='Q' then 'Quaterly' end as terms_insptype ,case when p.terms_insasper='P' then 'Property' when p.terms_insasper='T' then 'Tenancy' end as terms_insasper from rl_propertymaster p "
			 		+ " left join rl_propertryowner o on o.doc_no=p.owid "
			 		+ " left join rl_tncm t on t.doc_no=p.cnt_no  left join my_acbook m on m.cldocno=t.cldocno and m.dtype='crm' "
			 		+ " left join my_user u on p.insassignuser=u.doc_no left join rl_istatus st on st.rowno=p.ins_status "
			 		+ " where p.mgprpty=1 and p.active=1 and p.ins_date between '"+sqlfromdate+"' and '"+sqltodate+"'  order by p.doc_no ";
			 //System.out.println("strsql---->>>"+strsql);    			 
			 /**/
			ResultSet resultSet = stmt.executeQuery(strsql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	public JSONArray searchvendor(HttpSession session) throws SQLException{       
		JSONArray data=new JSONArray();                                           
		Connection conn=null; 
		 java.sql.Date edates = null;     
		try{
			conn=ClsConnection.getMyConnection();  
			Statement stmt=conn.createStatement();
			        
			String strsql="select h.description accname,h.doc_no from my_acbook ac left join my_head h on h.doc_no=ac.acno where ac.dtype='vnd' and h.atype='ap' and ac.status=3";          
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
	
	public JSONArray getStatushistory(String docno) throws SQLException {     
		JSONArray RESULTDATA=new JSONArray();     
		/*if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}*/
		Connection conn = null;
		 
		try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmt = conn.createStatement();
			 
			 String strsql="select ist.name as status,ins.remarks,ins.created_date,u.user_name as user from rl_inspection ins left join rl_istatus ist on ist.rowno=ins.status left join my_user u on u.doc_no=ins.userId  "
			 		+ "  where ins.pdocno='"+docno+"' and ins.status is not null  order by ins.created_date asc";
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
	public JSONArray getSchedulehistory(String docno) throws SQLException {     
		JSONArray RESULTDATA=new JSONArray();     
		/*if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}*/
		Connection conn = null;
	 
		
		try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmt = conn.createStatement();
			 
			 String strsql="select ins.date,u.user_name as user,ins.created_date from rl_inspection ins left join my_user u on u.doc_no=ins.userId"
			 		+ " where ins.pdocno='"+docno+"'  order by ins.date  asc";
			 System.out.println("strsql---->>>"+strsql);    			 
			 /*and p.ins_date between '"+sqlfromdate+"' and '"+sqltodate+"'*/
			ResultSet resultSet = stmt.executeQuery(strsql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	public   JSONArray getInspection(String id,String docno) throws SQLException {
		JSONArray data=new JSONArray();       
	    if(!id.equalsIgnoreCase("1")){
	    	return data;
	    }
     	Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stm = conn.createStatement ();           
			String sql="select case when m.signstatus=1 then 'No Issues' when m.signstatus=2 then 'Minor' when m.signstatus=3 then 'Major' else '' end signstatus,if(skipped=1,'Skipped','Completed') status,inspdate,u.user_name user,insdate,m.doc_no from rl_propinspm m left join my_user u on u.doc_no=m.userid where m.propdocno='"+docno+"'";
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
