package com.dashboard.audit.loginprivilage;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsLoginPrivilageDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray userDetailsSearchGridLoading() throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtBUP = conn.createStatement();
			    
			    String sql = "select u.doc_no,u.user_name,u.role_id,r.user_role from my_user u left join my_urole r on u.role_id=r.doc_no where u.status=3 and u.block=0";
			    
			    ResultSet resultSet = stmtBUP.executeQuery(sql);
			                
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtBUP.close();
			    conn.close();
		  } catch(Exception e){
		   e.printStackTrace();
		   conn.close();
		  } finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	   
	public JSONArray userLoginPrivilageGridLoading(String user,String rpttype,String check) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		
		if(!(check.equalsIgnoreCase("1"))){
	    	   return RESULTDATA;
	    }
		
		Connection conn = null;
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtBUP = conn.createStatement();
			    String sql="";
			    
			    if(!((user.equalsIgnoreCase("0")) ||  (user.equalsIgnoreCase("")))){
		 			sql+=" and user_id='"+user+"'";
		 		}
			    
			    if(rpttype.equalsIgnoreCase("1")){
			    	
			    	sql = "select * from ( select date,user_id doc_no, UPPER(user) user_name, win_cmp, win_user, mac_address,convert(concat(' User : ',coalesce(UPPER(user)), "  
			    		+ "' * ','Computer  : ',coalesce(win_cmp), ' * ','Profile  : ',coalesce(win_user), ' * ','MAC Address  : ',coalesce(mac_address)),char(1000)) userinfo "
			    		+ "from gc_usermac where status=3 and approval=1"+sql+" order by date desc) a  group by a.mac_address,a.doc_no";
			    	
			    } else if(rpttype.equalsIgnoreCase("2")){
			    	
			    	sql = "select date,user_id doc_no, UPPER(user) user_name, win_cmp, win_user, mac_address,convert(concat(' User : ',coalesce(UPPER(user)), ' * ','Computer  : ',coalesce(win_cmp), ' * ',"
						+ "'Profile  : ',coalesce(win_user), ' * ','MAC Address  : ',coalesce(mac_address)),char(1000)) userinfo from gc_usermac where status=3 and approval=0"+sql+"";
			    	
			    }
			    
			    ResultSet resultSet = stmtBUP.executeQuery(sql);
			                
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtBUP.close();
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
