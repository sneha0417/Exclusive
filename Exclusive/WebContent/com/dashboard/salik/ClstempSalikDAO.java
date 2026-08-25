package com.dashboard.salik;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClstempSalikDAO {

	ClsConnection ClsConnection=new ClsConnection();
	
	ClsCommon ClsCommon=new ClsCommon();
	public  JSONArray unallocation1(String update,String tagno,String regno,String aa) throws SQLException {
//		System.out.println("--------IN---------");
        JSONArray RESULTDATA=new JSONArray();
        Connection conn =null;
    	try {    
        java.sql.Date sqluptodate = null;
        
     	if(!(update.equalsIgnoreCase("undefined"))&&!(update.equalsIgnoreCase(""))&&!(update.equalsIgnoreCase("0"))){
     		sqluptodate=ClsCommon.changeStringtoSqlDate(update);
     	}
     
     
    	
    	String sqltest="";
    	
    	if(!(tagno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and tagno='"+tagno+"'";
    	}
    	if(!(regno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and regno='"+regno+"' ";
    	}
     	
       
	
				 conn = ClsConnection.getMyConnection();
				 Statement stmtVeh = conn.createStatement ();
				if(aa.equalsIgnoreCase("2"))
				{
//					System.out.println("--------aa--------"+aa);
				 String sql="select regno,tagno,salik_date,  salik_time,  fleetno,trans,round(AMOUNT,2) AMOUNT,if(reason is null,'',reason) reason,convert(coalesce(ra_no,' '),char(30)) rano,convert(coalesce(branch,''),char(30)) branch from gl_salik where ISALLOCATED=0 and status in (0,3) and sal_date<='"+sqluptodate+"'   " +sqltest;
//          System.out.println("------------------"+sql);
            	 ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
				}
            	 stmtVeh.close();
 				 conn.close();
		}catch(Exception e){
			 e.printStackTrace();
			 conn.close();
		}
        return RESULTDATA;
    }
	
	public  JSONArray allocationlist1(String update,String tagno,String regno,String bb) throws SQLException {
//		System.out.println("--------IN---2------");
        JSONArray RESULTDATA=new JSONArray();
        Connection conn =null;
        
		try {
        java.sql.Date sqluptodate = null;
        
     	if(!(update.equalsIgnoreCase("undefined"))&&!(update.equalsIgnoreCase(""))&&!(update.equalsIgnoreCase("0"))){
     		sqluptodate=ClsCommon.changeStringtoSqlDate(update);
     	}
     
    	
    	
    	String sqltest="";
    	
    	if(!(tagno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and s.tagno='"+tagno+"'";
    	}
    	if(!(regno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and s.regno='"+regno+"' ";
    	}
    	
     	
				 conn = ClsConnection.getMyConnection();
				 Statement stmtVeh = conn.createStatement();

				/* String sql="select regno,tagno,salik_date,fleetno,trans,round(AMOUNT,2) AMOUNT,if(reason is null,'',reason) reason,convert(coalesce(ra_no,' '),char(30)) rano,convert(coalesce(branch,''),char(30)) branch from gl_salik where ISALLOCATED=1 and sal_date<='"+sqluptodate+"' "+sqltest;*/
				 
				 if(bb.equalsIgnoreCase("10"))
				 {
//					 System.out.println("--------bb--------"+bb);
				 String sql="select  s.regno,s.tagno,s.salik_date,  s.salik_time,  s.fleetno,s.trans,round(s.AMOUNT,2) AMOUNT, "
				 		+ " if(s.reason is null,'',reason) reason, case when s.rtype in ('RM','RA', 'RD','RW','RF') then ragmt.voc_no when  "
				 		+ "s.rtype in ('LA','LC')  then lagmt.voc_no else s.ra_no end as 'rano',convert(coalesce(s.branch,''),char(30)) branch  "
				 		+ " from gl_salik s	 left join gl_ragmt ragmt on (s.ra_no=ragmt.doc_no and s.rtype in ('RA','RD','RW','RF','RM'))   "
				 		+ " left join gl_lagmt  lagmt on  (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) where s.ISALLOCATED=1 "
				 		+ " and s.sal_date<='"+sqluptodate+"'  "+sqltest;
				 
				//System.out.println("------sql---"+sql);
            	ResultSet resultSet = stmtVeh.executeQuery(sql);
            	RESULTDATA=ClsCommon.convertToJSON(resultSet);
				 }
            	stmtVeh.close();
 				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }	
	
	
}
