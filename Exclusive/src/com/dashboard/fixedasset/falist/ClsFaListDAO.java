package com.dashboard.fixedasset.falist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsFaListDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

public JSONArray getAssetGroup() throws SQLException {
        
        
        JSONArray RESULTDATA=new JSONArray();
        Connection conn =null;
        		
        		try {
					conn=ClsConnection.getMyConnection();

					Statement stmtassetgrp = conn.createStatement ();
	            	
					String clsql= "select doc_no,grp_name,grp_code from my_fagrp where status=3";
					ResultSet resultSet = stmtassetgrp.executeQuery(clsql);
					
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtassetgrp.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
        		finally{
        			conn.close();
        		}
	        return RESULTDATA;
	    
    }



public JSONArray getAssetList(String branch,String assetgroup,String check) throws SQLException {
    
    
    JSONArray RESULTDATA=new JSONArray();
    if(!(check.equalsIgnoreCase("1"))){
    	return RESULTDATA;
    }
    Connection conn =null;
    		
    		try {
				conn=ClsConnection.getMyConnection();

				Statement stmtassetlist = conn.createStatement ();
            	String sqltest="";
            	if(!assetgroup.equalsIgnoreCase("")){
            		sqltest=" and asset.assetgp="+assetgroup+"";
            	}
				String strassetlist= "select asset.doc_no,asset.assetid,asset.assetname,coalesce(grp.grp_name,'') assetgrp,coalesce(loc.loc_name,'') assetloc,"+
						" coalesce(ac.refname,'') supplier,asset.purefno prefno,asset.purdate pdate,asset.totpurval totalpval,coalesce(fix.description,'') fixedassetac,"+
						" coalesce(accdep.description,'') accdeprac,coalesce(dep.description,'') deprac from my_fixm asset left join my_fagrp grp on"+
						" asset.assetgp=grp.doc_no left join my_faloc loc on asset.loc=loc.doc_no left join my_acbook ac on (asset.supacno=ac.acno and"+
						" ac.dtype='VND' and asset.supacno!=0) left join my_head fix on asset.fixastacno=fix.doc_no left join my_head accdep on asset.accdepacno=accdep.doc_no left join"+
						" my_head dep on asset.depacno=dep.doc_no where 1=1  "+sqltest+" and asset.status=3";
				System.out.println(strassetlist);
				ResultSet resultSet = stmtassetlist.executeQuery(strassetlist);
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtassetlist.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
    		finally{
    			conn.close();
    		}
        return RESULTDATA;
    
}
public JSONArray getAssetListExcel(String branch,String assetgroup,String check) throws SQLException {
    
    
    JSONArray RESULTDATA=new JSONArray();
    if(!(check.equalsIgnoreCase("1"))){
    	return RESULTDATA;
    }
    Connection conn =null;
    		
    		try {
				conn=ClsConnection.getMyConnection();

				Statement stmtassetlist = conn.createStatement ();
            	String sqltest="";
            	if(!assetgroup.equalsIgnoreCase("")){
            		sqltest=" and asset.assetgp="+assetgroup+"";
            	}
				String strassetlist= "select asset.assetid 'Asset Id',asset.assetname 'Asset Name',coalesce(grp.grp_name,'') 'Asset Group', "
						+" coalesce(loc.loc_name,'') 'Asset Location', coalesce(ac.refname,'') supplier,asset.purefno 'Pur. Ref No', "
						+" asset.purdate 'Pur. Date',asset.totpurval 'Total Pur Value',coalesce(fix.description,'') 'Fixed Asset A/c',"
						+" coalesce(accdep.description,'') 'Acc Depr A/c',coalesce(dep.description,'') 'Depr A/c' "
						+" from my_fixm asset left join my_fagrp grp on asset.assetgp=grp.doc_no"
						+" left join my_faloc loc on asset.loc=loc.doc_no left join my_acbook ac on (asset.supacno=ac.acno and"
						+" ac.dtype='VND'  and asset.supacno!=0 ) left join my_head fix on asset.fixastacno=fix.doc_no left join my_head accdep on asset.accdepacno=accdep.doc_no left join"
						+" my_head dep on asset.depacno=dep.doc_no where 1=1  "+sqltest+" and asset.status=3";
				System.out.println(strassetlist);
				ResultSet resultSet = stmtassetlist.executeQuery(strassetlist);
				
				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				stmtassetlist.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
    		finally{
    			conn.close();
    		}
        return RESULTDATA;
    
}
}
