package com.dashboard.analysis.activityanalysis;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsActivityAnalysisDAO {

	ClsConnection ClsConnection=new ClsConnection();
    ClsCommon cmn=new ClsCommon();
	
    /* activityGrid data loading */
    public  JSONArray loadGridData(String userid,String check) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
        
		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		
		try {
        
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			
			String sqltest="";
			
			if(!(userid.equalsIgnoreCase("")) && !(userid.equalsIgnoreCase("0"))) {
				sqltest+=" and m.userid='"+userid+"'";
			}
			
			String sqldata="select d.rdocno doc_no,m.highlight,CASE WHEN m.confirmed=0 "
					+ "THEN 'To be Submitted' WHEN m.confirmed=1 THEN 'Submitted' ELSE '' "
					+ "END AS fromstatus,d.intime,d.outtime,d.hrs,d.clnew,d.cldocno,d.client,"
					+ "d.jobtype,d.jobno,d.notes,d.followupdate, d.followupnotes,u.user_name username "
					+ "from cm_activityreportm m left join cm_activityreportd d on m.doc_no=d.rdocno "
					+ " left join my_user u on m.userid=u.doc_no where m.status=3 and d.status=3"+sqltest+"";
			
			resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cmn.convertToJSON(resultSet);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		return RESULTDATA;
	}
    
    /* countUsergrid data loading */
    public  JSONArray countGridData(String userid,String highlight) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
        
		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		
		try {
        
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			String sqltest="";
			
			if(!(userid.equalsIgnoreCase("")) && !(userid.equalsIgnoreCase("0"))) {
				sqltest+=" and m.userid='"+userid+"'";
			}
			
			if(!(highlight.equalsIgnoreCase("")) && !(highlight.equalsIgnoreCase("0"))) {
				sqltest+=" and m.highlight='"+highlight+"'";
			}
			
			String sqldata="select u.user_name,count(*) submitted,m.userid from cm_activityreportm m "
					+ "left join my_user u on u.doc_no=m.userid where m.status=3 and m.confirmed=1"+sqltest+" group by "
					+ "m.userid UNION ALL select 'ALL' user_name,count(*) submitted,0 userid "
					+ "from cm_activityreportm m left join my_user u on u.doc_no=m.userid where "
					+ "m.status=3 and m.confirmed=1"+sqltest+"";
			
			resultSet= stmt.executeQuery(sqldata);
			RESULTDATA=cmn.convertToJSON(resultSet);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		return RESULTDATA;
	}
 
    
    public JSONArray searchUser() throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();

			
			String clsql= "select doc_no userid, USER_NAME from my_user where status=3";

			ResultSet resultSet = stmt.executeQuery(clsql);

			RESULTDATA=cmn.convertToJSON(resultSet);
			stmt.close();
			conn.close();
			}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return RESULTDATA;
	}
    
    public JSONArray searchHigh() throws SQLException {

    	JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();

			
			String clsql= "select highlight from cm_activityreportm where status=3";

			ResultSet resultSet = stmt.executeQuery(clsql);

			RESULTDATA=cmn.convertToJSON(resultSet);
			stmt.close();
			conn.close();
			}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return RESULTDATA;
	}

    public  JSONArray loadGridExcel(String userid,String id) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();

			String sqltest="";
			
			if(!(userid.equalsIgnoreCase("")) && !(userid.equalsIgnoreCase("0"))) {
				sqltest+=" and m.userid='"+userid+"'";
			}
			
			String sqldata="select d.rdocno 'Doc No',m.highlight 'Highlight',u.user_name 'User Name',CASE WHEN m.confirmed=0 "
					+ "THEN 'To be Submitted' WHEN m.confirmed=1 THEN 'Submitted' ELSE '' "
					+ "END AS 'Status',d.intime 'From',d.outtime 'To',d.hrs 'Hours',if(d.clnew=0,'Existing','New') 'Client Status',d.client 'Client',"
					+ "d.jobtype 'Job Type',d.jobno 'Job No',d.notes 'Notes',d.followupdate 'Follow Up Date', d.followupnotes 'Follow Up Notes' "
					+ "from cm_activityreportm m left join cm_activityreportd d on m.doc_no=d.rdocno "
					+ " left join my_user u on m.userid=u.doc_no where m.status=3 and d.status=3"+sqltest+"";
		
				resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cmn.convertToEXCEL(resultSet);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		return RESULTDATA;
	}
	
}





