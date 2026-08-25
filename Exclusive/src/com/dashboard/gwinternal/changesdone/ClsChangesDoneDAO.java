package com.dashboard.gwinternal.changesdone;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsChangesDoneDAO  {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
  public JSONArray changesDoneGridLoading(String reportType, String branch, String fromdate, String todate, String cldocno, String project, String check) throws SQLException {
	JSONArray RESULTDATA=new JSONArray();
	
	if(!(check.equalsIgnoreCase("1"))){
		return RESULTDATA;
	}
	
	Connection conn = null;  
	
	  try {
		    conn = ClsConnection.getMyConnection();
		    Statement stmtCHNG = conn.createStatement();
	    
		    java.sql.Date sqlFromDate = null;
		    java.sql.Date sqlToDate = null;
	        
	        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
	        	sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
	        }
	        
	        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
	        	sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
	        }
	        
		    String sql="",sqls="";
		    
		    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
				sqls+=" and m.brhid="+branch+"";
    		}
		    
		    if(!(sqlFromDate==null)){
	        	sqls+=" and m.date>='"+sqlFromDate+"'";
		    }
		    
		    if(!(sqlToDate==null)){
	        	sqls+=" and m.date<='"+sqlToDate+"'";
		    }
		    
		    if(!((project.equalsIgnoreCase("")) || (project.equalsIgnoreCase("0")))){
				sqls+=" and m.projectid="+project+"";
    		}
		    
		    if(reportType.equalsIgnoreCase("1")) {
		    	
			    sql = "select m.doc_no, m.date, m.form_name, m.files_tobecopied, m.file_path, m.query_file, m.description, p.name project, u.user_name employee,'Attach' attachbtn from gw_changesdone m left join "
			    		+ "gw_changescopied d on m.doc_no=d.rdocno and d.cldocno="+cldocno+" left join gw_projects p on m.projectid=p.doc_no left join my_user u on m.userid=u.doc_no "
			    		+ "where m.status=3 and d.cldocno is null"+sqls+"";
			    
		    } else if(reportType.equalsIgnoreCase("2")) {
		    	
		    	 sql = "select m.doc_no, m.date, m.form_name, m.files_tobecopied, m.file_path, m.query_file, m.description, p.name project, u.user_name employee,'Attach' attachbtn from gw_changesdone m left join "
				    		+ "gw_changescopied d on m.doc_no=d.rdocno and d.cldocno="+cldocno+" left join gw_projects p on m.projectid=p.doc_no left join my_user u on m.userid=u.doc_no "
				    		+ "where m.status=3 and d.cldocno is not null"+sqls+"";
		    	 
		    }
		    
		    ResultSet resultSet = stmtCHNG.executeQuery(sql);
		    RESULTDATA=ClsCommon.convertToJSON(resultSet);
		    
		    stmtCHNG.close();
		    conn.close();
	  } catch(Exception e){
		  e.printStackTrace();
		  conn.close();
	  } finally{
		  conn.close();
	  }
	  return RESULTDATA;
	}
  
  public JSONArray clientDetailsSearch(String client, String check) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		
		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
		
		Connection conn = null;  
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtCHNG = conn.createStatement();
		        
			    String sqls="";
			    
			    if(!((client.equalsIgnoreCase("")) || (client.equalsIgnoreCase("0")))){
					sqls+=" and refname like '%"+client+"%'";
	    		}
			    
			    ResultSet resultSet = stmtCHNG.executeQuery ("SELECT refname,doc_no FROM my_acbook WHERE status=3"+sqls+"");
			    
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtCHNG.close();
			    conn.close();
		  } catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  } finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
  
}
