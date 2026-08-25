package com.dashboard.leadmanagement.executivediary;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import com.common.ClsCommon;
import com.connection.ClsConnection;

	public class ClsExecutiveDiaryDAO {
		
		ClsConnection ClsConnection=new ClsConnection();
		ClsCommon ClsCommon=new ClsCommon();

		public JSONArray executiveDiaryGridLoading(HttpSession session,String fromdate,String todate,String activitystatus,String chkfollowup, String followupdate, String check) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        if(!(check.equalsIgnoreCase("1"))){
	        	return RESULTDATA;
	        }
	        Connection conn = null;
	        
			try {
					 conn = ClsConnection.getMyConnection();
					 Statement stmtBIB = conn.createStatement();  
					 
					 String userid=session.getAttribute("USERID").toString().trim();
					 
					 java.sql.Date sqlfromdate = null;
					 java.sql.Date sqltodate = null;
					 java.sql.Date sqlfollowupdate = null;
					 
					 String sqltest="";
				        
			         if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))) {
			     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
			     	 }

			     	 if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
			     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
			     	 }
			     	
			     	 if(!(followupdate.equalsIgnoreCase("undefined"))&&!(followupdate.equalsIgnoreCase(""))&&!(followupdate.equalsIgnoreCase("0"))) {
			     		sqlfollowupdate=ClsCommon.changeStringtoSqlDate(followupdate);
			     	 }
			        
			     	 if(!(activitystatus.equalsIgnoreCase("undefined"))&&!(activitystatus.equalsIgnoreCase(""))) {
			     		sqltest+=" and m.confirmed="+activitystatus+"";
			     	 }
			     	 
			     	if(chkfollowup.equalsIgnoreCase("1")){
						if(!(sqlfollowupdate==null)){
							sqltest+=" and d.followupdate<='"+sqlfollowupdate+"'";
						}
					} else {
						
						if(!(sqlfromdate==null)){
							sqltest+=" and m.date>='"+sqlfromdate+"'";
						}
						
						if(!(sqltodate==null)){
							sqltest+=" and m.date<='"+sqltodate+"'";
						}
					}
				
			     	 String sql="select d.rdocno doc_no,m.highlight,CASE WHEN m.confirmed=0 THEN 'To be Submitted' WHEN m.confirmed=1 THEN 'Submitted'"
						   +" ELSE '' END AS fromstatus,d.intime,d.outtime,d.hrs,if(d.clnew=1,true,false) clnew,d.cldocno,d.client,d.jobtype,d.jobno,d.notes,d.followupdate,"
						   +" d.followupnotes from cm_activityreportm m left join cm_activityreportd d on m.doc_no=d.rdocno where m.status=3 and"
						   +" d.status=3 and m.userid='"+userid+"' "+sqltest;
					  
			     	 ResultSet resultSet = stmtBIB.executeQuery(sql);
			     	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
			     	 stmtBIB.close();
			     	 conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
				
			}
	        return RESULTDATA;
	    }
		
		public JSONArray executiveDiaryExcelExport(HttpSession session,String fromdate,String todate,String activitystatus,String chkfollowup, String followupdate, String check) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        if(!(check.equalsIgnoreCase("1"))){
	        	return RESULTDATA;
	        }
	        Connection conn = null;
	        
			try {
					 conn = ClsConnection.getMyConnection();
					 Statement stmtBIB = conn.createStatement();  
					 
					 String userid=session.getAttribute("USERID").toString().trim();
					 
					 java.sql.Date sqlfromdate = null;
					 java.sql.Date sqltodate = null;
					 java.sql.Date sqlfollowupdate = null;
					 
					 String sqltest="";
				        
			         if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))) {
			     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
			     	 }

			     	 if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
			     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
			     	 }
			     	
			     	 if(!(followupdate.equalsIgnoreCase("undefined"))&&!(followupdate.equalsIgnoreCase(""))&&!(followupdate.equalsIgnoreCase("0"))) {
			     		sqlfollowupdate=ClsCommon.changeStringtoSqlDate(followupdate);
			     	 }
			        
			     	 if(!(activitystatus.equalsIgnoreCase("undefined"))&&!(activitystatus.equalsIgnoreCase(""))) {
			     		sqltest+=" and m.confirmed="+activitystatus+"";
			     	 }
			     	 
			     	if(chkfollowup.equalsIgnoreCase("1")){
						if(!(sqlfollowupdate==null)){
							sqltest+=" and d.followupdate<='"+sqlfollowupdate+"'";
						}
					} else {
						
						if(!(sqlfromdate==null)){
							sqltest+=" and m.date>='"+sqlfromdate+"'";
						}
						
						if(!(sqltodate==null)){
							sqltest+=" and m.date<='"+sqltodate+"'";
						}
					}
				
			     	 String sql="select d.rdocno 'Doc No',m.highlight 'Highlight',CASE WHEN m.confirmed=0 THEN 'To be Submitted' WHEN m.confirmed=1 THEN 'Submitted'"
						   +" ELSE '' END AS 'Status',d.intime 'From',d.outtime 'To',d.hrs 'Hours',if(d.clnew=1,'New Client','Existing Client') 'Client Status',"
			     		   + "d.client 'Client',d.jobtype 'Jobtype',d.jobno 'Jobno',d.notes 'Notes',d.followupdate 'Followup Date',d.followupnotes 'Followup Notes' "
						   + "from cm_activityreportm m left join cm_activityreportd d on m.doc_no=d.rdocno where m.status=3 and d.status=3 and m.userid='"+userid+"' "+sqltest;

			     	 ResultSet resultSet = stmtBIB.executeQuery(sql);
			     	 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
					
			     	 stmtBIB.close();
			     	 conn.close();
			} catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
	        return RESULTDATA;
	    }
		
}
