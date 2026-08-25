package com.dashboard.audit.securitychequelist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsSecurityChequeList  {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray securityChequeListGridLoading(String branch,String uptodate) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		
		java.sql.Date sqlUpToDate = null;
        
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtSecChqList = conn.createStatement();
			    
			    if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
		        	sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
		        }
			    
			    String sql = "";
			    
			    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and s.brhid="+branch+"";
	    		}
			    
			    if(!(sqlUpToDate==null)){
		        	sql+=" and s.chqdt<='"+sqlUpToDate+"'";
			    }
			    
			    sql = "select s.date,s.doc_no,s.chqno,s.chqdt,s.amount,s.remarks,s.acno_from,s.acno_to,s.brhid,h.description bank,h1.description,"
			        + "convert(concat(' Date : ',coalesce(DATE_FORMAT(s.date,'%d-%m-%Y'),'  '),' * ','Doc No  : ',coalesce(s.doc_no, ' '),' * ',"
			    	+"'Cheque No : ' ,coalesce(s.chqno,' '),' * ','Cheque Date : ', coalesce(DATE_FORMAT(s.chqdt,'%d-%m-%Y'),' ')),char(1000)) info from my_secchq s " 
			    	+ "left join my_head h on s.acno_from=h.doc_no left join my_head h1 on s.acno_to=h1.doc_no where s.status=3 and s.chqclose=0"+sql+"";
			    
			    ResultSet resultSet = stmtSecChqList.executeQuery(sql);
			                
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtSecChqList.close();
			    conn.close();
		  }catch(Exception e){
		   e.printStackTrace();
		   conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}	
}