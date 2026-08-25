package com.dashboard.audit.salesinvoiceaudit;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsSalesInvoiceAuditDAO { 
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	public   JSONArray accountsDetailsFrom(String date,String accountno, String accountname,String mob,String chk) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
	  
     //   JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        
        
   java.sql.Date sqlDate=null;
      date.trim();
      String sqltest="";
                  /*   if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
                     {
                      sqlDate = ClsCommon.changeStringtoSqlDate(date);
                     }*/
                     
                     if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
                         sqltest=sqltest+" and a.refname like '%"+accountno+"%'";
                     }
                     if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
                      sqltest=sqltest+" and a.refname like '%"+accountname+"%'";
                     }
                     if(!(mob.equalsIgnoreCase("0")) && !(mob.equalsIgnoreCase(""))){
                       sqltest=sqltest+" and if(a.per_mob=0,a.per_tel,a.per_mob) like '%"+mob+"%'";
                  }
  try {
     conn = ClsConnection.getMyConnection();
     if(chk.equalsIgnoreCase("1"))
     {
    Statement stmt = conn.createStatement ();
      
   
    String  sql= "select a.doc_no,a.refname as account,a.refname description,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_acbook a where dtype='CRM' "+sqltest;
 
    
 
    
    ResultSet resultSet = stmt.executeQuery(sql);
    RESULTDATA=ClsCommon.convertToJSON(resultSet);
    
    stmt.close();
     }
    conn.close();
  }
  catch(Exception e){
   e.printStackTrace();
   conn.close();
  }
        return RESULTDATA;
    }
	
	
	public   JSONArray saleauditsearch(String branch,String fromdate,String todate,String status,String acno,String type,String load) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        if(!(load.equalsIgnoreCase("yes")))
        {
        	return RESULTDATA;
        }
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
  
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.cldocno='"+acno+"'";
 		}
    	
     
    
    
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
		
				
				
				String sql=" select   mm.voc_no,mm.doc_no, mm.refno,mm.date , "
						+ "  h.account,h.description acname,nettotal "
					   + "  from my_invm mm left join (select sum(coalesce(taxamount,0)+nettotal) nettotal,rdocno from my_invd group by rdocno) d on d.rdocno=mm.doc_no  "
						+ "  left join my_head h on h.doc_no=mm.acno "
						+ "     where mm.status=3 and mm.audit=0 and mm.paymode='"+type+"' and "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest;
			
          
          
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	

}
