package com.dashboard.marketing.salesuserlink;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsSalesUserLink  {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray salesUserLinkGridLoading(String rpttype,String check) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtSUL = conn.createStatement();
			    
			    if(check.equalsIgnoreCase("1")) {
			    
				    String sql = "";
				    
				    if(rpttype.equalsIgnoreCase("1")) {
				    	sql=sql+" and m.salesuserlink is null";
				    } else if(rpttype.equalsIgnoreCase("2")) {
				    	sql=sql+" and m.salesuserlink is not null";
				    }
				    
				    sql = "select m.sal_id code,m.sal_name name,m.mail email,m.mob_no mobile,m.doc_no docno,h.account,u.user_name,convert(concat(' Code: ',coalesce(m.sal_id,''), ' * ','Salesman  : ',coalesce(m.sal_name,'')," 
				    	 + "coalesce(CONCAT(' * ','User  : ',u.user_name),'')),char(1000)) salesmaninfo from my_salm m left join my_head h on m.acc_no=h.doc_no left join my_user u on m.salesuserlink=u.doc_no "  
				    	 + "where m.status=3"+sql;
				    
				    ResultSet resultSet = stmtSUL.executeQuery(sql);
				                
				    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    }
			    
			    stmtSUL.close();
			    conn.close();
		  } catch(Exception e){
		   e.printStackTrace();
		   conn.close();
		  } finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	public JSONArray userDetails(String username, String userrole, String chk) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtSUL = conn.createStatement();
			    
			    if(chk.equalsIgnoreCase("1")) {
			    	
				    String sql = "";
				    
				    if(!((username.equalsIgnoreCase("")) || (username.equalsIgnoreCase("0")))){
		                sql=sql+" and u.user_name like '%"+username+"%'";
		            }
				    
		            if(!((userrole.equalsIgnoreCase("")) || (userrole.equalsIgnoreCase("0")))){
		             sql=sql+" and r.user_role like '%"+userrole+"%'";
		            }
		            
				    sql = "select u.user_name,u.doc_no,r.user_role from my_user u left join my_urole r on u.role_id=r.doc_no where u.status=3 and r.status=3"+sql;
				    
				    ResultSet resultSet = stmtSUL.executeQuery(sql);
				                
				    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    }
			    
			    stmtSUL.close();
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