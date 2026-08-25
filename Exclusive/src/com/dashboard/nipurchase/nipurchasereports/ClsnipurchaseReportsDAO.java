package com.dashboard.nipurchase.nipurchasereports;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsnipurchaseReportsDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	
	
	public   JSONArray nipurchaseReports(String branch,String fromdate,String todate,String fromdocno,String todocno,String fromamount,String toamount, String accdocno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
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
     	
        if(!(fromdocno.equalsIgnoreCase("0")) && !(fromdocno.equalsIgnoreCase("")) && !(todocno.equalsIgnoreCase("0")) && !(todocno.equalsIgnoreCase(""))){
            sqltest=sqltest+" and m.voc_no between "+fromdocno+" and  "+todocno+" ";
        }
        if(!(fromamount.equalsIgnoreCase("0")) && !(fromamount.equalsIgnoreCase("")) && !(toamount.equalsIgnoreCase("0")) && !(toamount.equalsIgnoreCase(""))){
           sqltest=sqltest+" and d.nettotal between "+fromamount+" and  "+toamount+" ";
        }
        if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
            sqltest=sqltest+" and m.acno ="+accdocno+" ";
         }
         		
        

    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and m.brhid='"+branch+"'";
 		}	
     	Connection conn = null;
 
    
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
 
				
				String sql=" select m.doc_no,m.reftype,m.refno,br.branchname,m.invno,m.invdate,m.desc1,m.payterm,m.delterm,m.deldate,m.voc_no,m.date,m.invno,m.invdate,h.account venacno,h.description vendaccname,\r\n" + 
						"h1.account detacno,h1.description detaccname,d.qty,d.unitprice,d.total,d.discount,m.netamount\r\n" + 
						"  from my_srvpurm m left join my_srvpurd d on d.rdocno=m.doc_no\r\n" + 
						" left join my_head h on h.doc_no=m.acno  left join my_head h1 on h1.doc_no=d.acno\r\n left join my_brch br on m.brhid=br.doc_no" + 
						"   where  m.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "
						+ "    and  m.status<>7  "+sqltest+"  group by  m.doc_no order by d.rowno ";
         
            		
       System.out.println("------sql-----"+sql);
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
	
	
	

	
	
	
	public   JSONArray nipurchaseReportsex(String branch,String fromdate,String todate,String fromdocno,String todocno,String fromamount,String toamount, String accdocno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
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
     	
        if(!(fromdocno.equalsIgnoreCase("0")) && !(fromdocno.equalsIgnoreCase("")) && !(todocno.equalsIgnoreCase("0")) && !(todocno.equalsIgnoreCase(""))){
            sqltest=sqltest+" and m.voc_no between "+fromdocno+" and  "+todocno+" ";
        }
        if(!(fromamount.equalsIgnoreCase("0")) && !(fromamount.equalsIgnoreCase("")) && !(toamount.equalsIgnoreCase("0")) && !(toamount.equalsIgnoreCase(""))){
           sqltest=sqltest+" and d.nettotal between "+fromamount+" and  "+toamount+" ";
        }
        if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
            sqltest=sqltest+" and m.acno ="+accdocno+" ";
         }
         		
        

    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and m.brhid='"+branch+"'";
 		}	
     	Connection conn = null;
 
    
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
 
				
				
				  
 
				
				String sql=" select br.branchname 'Branch',m.voc_no  'Doc No',date_format(m.date,'%d-%m-%Y') 'Date',h.account 'Vendor',h.description ' Name',\r\n" + 
						"h1.account  'Account',h1.description 'Account Name',d.total 'Total',d.discount 'Discount',m.netamount 'Net Amount', \r\n" + 
						" m.reftype 'RefType',m.refno 'RefNo',m.invno 'Inv_No',m.invdate 'Inv_Date',m.desc1 'Description',m.payterm 'Pay_Term',m.delterm 'del_Term',m.deldate 'Del_Date' from my_srvpurm m left join my_srvpurd d on d.rdocno=m.doc_no\r\n" + 
						" left join my_head h on h.doc_no=m.acno  left join my_head h1 on h1.doc_no=d.acno\r\n left join my_brch br on m.brhid=br.doc_no" + 
						"   where  m.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "
						+ "    and  m.status<>7  "+sqltest+"  group by  m.doc_no order by d.rowno ";
         
            		
      //    System.out.println("------sql-----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
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
	
	public   JSONArray nipurchaseorderReports(String branch,String fromdate,String todate,String fromdocno,String todocno,String fromamount,String toamount, String accdocno,String type) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
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
     	
        if(!(fromdocno.equalsIgnoreCase("0")) && !(fromdocno.equalsIgnoreCase("")) && !(todocno.equalsIgnoreCase("0")) && !(todocno.equalsIgnoreCase(""))){
            sqltest=sqltest+" and m.voc_no between "+fromdocno+" and  "+todocno+" ";
        }
        if(!(fromamount.equalsIgnoreCase("0")) && !(fromamount.equalsIgnoreCase("")) && !(toamount.equalsIgnoreCase("0")) && !(toamount.equalsIgnoreCase(""))){
           sqltest=sqltest+" and d.nettotal between "+fromamount+" and  "+toamount+" ";
        }
        if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
            sqltest=sqltest+" and m.acno ="+accdocno+" ";
         }
         		
        

    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and m.brhid='"+branch+"'";
 		}
    
    	
    	
    	if(type.equalsIgnoreCase("ALL")){
    		sqltest+=" and 1=1";
    	
    	}
    	else if(type.equalsIgnoreCase("PED")){
    		sqltest+="and d.qty-d.out_qty!=0";
    	//pending
    	}
    	else if(type.equalsIgnoreCase("INV")){
    		sqltest+="and d.out_qty>0";
    	//invoiced
    	}
    	
  
    	
     	Connection conn = null;
 
    
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
 
				
				String sql=" select m.doc_no,m.voc_no,m.date,m.refno,h.account venacno,m.type,m.payterm,m.delterm,m.deldate,h.description vendaccname,\r\n" + 
						" m.desc1 desc1,d.qty,d.unitprice,d.total,d.discount,m.netamount\r\n" + 
						"  from my_srvlpom m left join my_srvlpod d on d.rdocno=m.doc_no\r\n" + 
						" left join my_head h on h.doc_no=m.acno   \r\n" + 
						"   where  m.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "
						+ "    and  m.status<>7  "+sqltest+"  group by  m.doc_no order by d.rowno  ";
         
            		
          System.out.println("------sql*********-----"+sql);
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
	
	

	
	public   JSONArray nipurchaseorderReportsex(String branch,String fromdate,String todate,String fromdocno,String todocno,String fromamount,String toamount, String accdocno,String type) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
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
     	
        if(!(fromdocno.equalsIgnoreCase("0")) && !(fromdocno.equalsIgnoreCase("")) && !(todocno.equalsIgnoreCase("0")) && !(todocno.equalsIgnoreCase(""))){
            sqltest=sqltest+" and m.voc_no between "+fromdocno+" and  "+todocno+" ";
        }
        if(!(fromamount.equalsIgnoreCase("0")) && !(fromamount.equalsIgnoreCase("")) && !(toamount.equalsIgnoreCase("0")) && !(toamount.equalsIgnoreCase(""))){
           sqltest=sqltest+" and d.nettotal between "+fromamount+" and  "+toamount+" ";
        }
        if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
            sqltest=sqltest+" and m.acno ="+accdocno+" ";
         }
         		
        
        
        

    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and m.brhid='"+branch+"'";
 		}
    	
    	
    	if(type.equalsIgnoreCase("ALL")){
    		
    		sqltest+="and 1=1";
    	}
    	
    	else if(type.equalsIgnoreCase("PED")){
    		
    		sqltest+="and d.qty-d.out_qty!=0";
    	}
    	
    	
        else if(type.equalsIgnoreCase("INV")){
    		
    		sqltest+="and d.out_qty>0";
    	}
    	
    	
     	Connection conn = null;
 
    
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
 
				  
				String sql=" select m.voc_no 'Doc No',date_format(m.date,'%d-%m-%Y') 'Date',m.refno 'Ref No',h.account 'Vendor' ,h.description ' Name',\r\n" + 
						" m.payterm 'Pay_Ter',m.delterm 'Del_Term',m.deldate 'Del_Date',d.total 'Total',d.discount 'Discount' ,m.netamount 'Net Amount',\r\n" + 
						"  m.desc1 'Description' from my_srvlpom m left join my_srvlpod d on d.rdocno=m.doc_no\r\n" + 
						" left join my_head h on h.doc_no=m.acno   \r\n" + 
						"   where  m.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "
						+ "    and  m.status<>7  "+sqltest+"  group by  m.doc_no order by d.rowno ";
         
            		
         // System.out.println("------sql-----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
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
	
	
	
public   JSONArray accountsDetails(HttpSession session,String accountno,String accountname,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
	       
		       conn = ClsConnection.getMyConnection();
		       Statement stmt = conn.createStatement();
	
		    
	   
	           if(check.equalsIgnoreCase("1")){
	        	   
		        String sqltest="";
		        String sql="";
		 
		           
		        if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and t.account like '%"+accountno+"%'";
		        }
		        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		           sqltest=sqltest+" and t.description like '%"+accountname+"%'";
		        }
		        	
		        sql="select   t.description,t.doc_no,t.account from my_head t  where t.atype='AP' and t.m_s=0 "+sqltest+" ";
		        
		     
		        
		       ResultSet resultSet = stmt.executeQuery(sql);
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	           
	 
		       }
		      stmt.close();
			  conn.close();   
	     }
	     catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     }finally{
				conn.close();
			}
	       return RESULTDATA;
	  }

public   JSONArray nipurchasedatailsReports(String branch,String fromdate,String todate,String fromdocno,String todocno,String fromamount,String toamount, String accdocno) throws SQLException {

    JSONArray RESULTDATA=new JSONArray();
    
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
 	
    if(!(fromdocno.equalsIgnoreCase("0")) && !(fromdocno.equalsIgnoreCase("")) && !(todocno.equalsIgnoreCase("0")) && !(todocno.equalsIgnoreCase(""))){
        sqltest=sqltest+" and m.voc_no between "+fromdocno+" and  "+todocno+" ";
    }
    if(!(fromamount.equalsIgnoreCase("0")) && !(fromamount.equalsIgnoreCase("")) && !(toamount.equalsIgnoreCase("0")) && !(toamount.equalsIgnoreCase(""))){
       sqltest=sqltest+" and d.nettotal between "+fromamount+" and  "+toamount+" ";
    }
    if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
        sqltest=sqltest+" and m.acno ="+accdocno+" ";
     }
     		
    

	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		sqltest+=" and m.brhid='"+branch+"'";
		}	
 	Connection conn = null;


    
	try {
			 conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();

			
			String sql="select m.voc_no,m.doc_no,m.date,concat(m.reftype,'-',m.refno) reftype,br.branchname,h1.atype,h.account,h.description accname,d.desc1,d.qty," +
					" d.unitprice,d.total,d.discount,d.nettotal,d.taxper,d.taxamount,d.nettaxamount,d.costtype,d.costcode,d.remarks,h1.account acc,h1.description accntt" +
					" from my_srvpurd d left join my_srvpurm m on m.doc_no=d.rdocno" +
					" left join my_head h1 on h1.doc_no=d.acno left join my_head h on h.doc_no=m.acno left join my_brch br on m.brhid=br.doc_no" + 
					"   where  m.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "
					+ "    and  m.status<>7  "+sqltest+"  group by  d.rowno order by d.rdocno ";
     
        		
   System.out.println("------1322344-----"+sql);
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
	
public   JSONArray nipurchasedetailsReportsex(String branch,String fromdate,String todate,String fromdocno,String todocno,String fromamount,String toamount, String accdocno) throws SQLException {

    JSONArray RESULTDATA=new JSONArray();
    
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
 	
    if(!(fromdocno.equalsIgnoreCase("0")) && !(fromdocno.equalsIgnoreCase("")) && !(todocno.equalsIgnoreCase("0")) && !(todocno.equalsIgnoreCase(""))){
        sqltest=sqltest+" and m.voc_no between "+fromdocno+" and  "+todocno+" ";
    }
    if(!(fromamount.equalsIgnoreCase("0")) && !(fromamount.equalsIgnoreCase("")) && !(toamount.equalsIgnoreCase("0")) && !(toamount.equalsIgnoreCase(""))){
       sqltest=sqltest+" and d.nettotal between "+fromamount+" and  "+toamount+" ";
    }
    if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
        sqltest=sqltest+" and m.acno ="+accdocno+" ";
     }
     		
    

	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		sqltest+=" and m.brhid='"+branch+"'";
		}	
 	Connection conn = null;


    
	try {
			 conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();

			
			
			  

			
			String sql="select br.branchname 'Branch',m.voc_no 'Doc_No',m.date 'Date',concat(m.reftype,'-',m.refno)  'Reftype_refno',h.account 'Vendor',h.description 'Vender_Name',h1.account 'Account',h1.atype 'Type',h1.description 'Account_Name',d.desc1 'Description',d.qty 'Qty'," +
					" d.unitprice 'Unit_Price',d.total 'Total',d.discount 'Discount',d.nettotal 'Net_Total',d.taxper 'tax_per',d.taxamount 'tax_Amount',d.nettaxamount 'Net_TaxAmount',d.costtype 'Cost_Type',d.costcode 'Cost_Code',d.remarks 'Remarks'" +
					" from my_srvpurd d left join my_srvpurm m on m.doc_no=d.rdocno" +
					" left join my_head h1 on h1.doc_no=d.acno left join my_head h on h.doc_no=m.acno left join my_brch br on m.brhid=br.doc_no" + 
					"   where  m.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "
					+ "    and  m.status<>7  "+sqltest+"  group by  d.rowno order by d.rdocno ";
     
        		
    System.out.println("------sql-----"+sql);
        		ResultSet resultSet = stmtVeh.executeQuery(sql);
        		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
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
public   JSONArray nipurchaseorderdetailsReports(String branch,String fromdate,String todate,String fromdocno,String todocno,String fromamount,String toamount, String accdocno,String type) throws SQLException {

    JSONArray RESULTDATA=new JSONArray();
    
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
 	
    if(!(fromdocno.equalsIgnoreCase("0")) && !(fromdocno.equalsIgnoreCase("")) && !(todocno.equalsIgnoreCase("0")) && !(todocno.equalsIgnoreCase(""))){
        sqltest=sqltest+" and m.voc_no between "+fromdocno+" and  "+todocno+" ";
    }
    if(!(fromamount.equalsIgnoreCase("0")) && !(fromamount.equalsIgnoreCase("")) && !(toamount.equalsIgnoreCase("0")) && !(toamount.equalsIgnoreCase(""))){
       sqltest=sqltest+" and d.nettotal between "+fromamount+" and  "+toamount+" ";
    }
    if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
        sqltest=sqltest+" and m.acno ="+accdocno+" ";
     }
     		
    

	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		sqltest+=" and m.brhid='"+branch+"'";
		}
	
	
	
	
	

	if(type.equalsIgnoreCase("ALL")){
		sqltest+=" and 1=1";
	
	}
	else if(type.equalsIgnoreCase("PED")){
		sqltest+="and d.qty-d.out_qty!=0";
	//pending
	}
	else if(type.equalsIgnoreCase("INV")){
		sqltest+="and d.out_qty>0";
	//invoiced
	}
	
	
	
	
	
	
 	Connection conn = null;


    
	try {
			 conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();

			
			String sql=" select m.doc_no,m.voc_no,m.date,m.refno,h.account venacno,h.description vendaccname,\r\n" + 
					" d.desc1 desc1,d.qty,d.unitprice,d.total,d.discount,d.nettotal netamount,\r\n" + 
					"  d.taxper,d.taxamount,d.nettaxamount,d.out_qty issuedqty from my_srvlpod d left join my_srvlpom m  on d.rdocno=m.doc_no\r\n" + 
					" left join my_head h on h.doc_no=m.acno   \r\n" + 
					"   where  m.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "
					+ "    and  m.status<>7  "+sqltest+"  group by  d.rowno order by m.doc_no ";
     
        		
  System.out.println("------ni purchase order detail grid data-----"+sql);
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

public   JSONArray nipurchaseorderdetailsReportsex(String branch,String fromdate,String todate,String fromdocno,String todocno,String fromamount,String toamount, String accdocno,String type) throws SQLException {

    JSONArray RESULTDATA=new JSONArray();
    
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
 	
    if(!(fromdocno.equalsIgnoreCase("0")) && !(fromdocno.equalsIgnoreCase("")) && !(todocno.equalsIgnoreCase("0")) && !(todocno.equalsIgnoreCase(""))){
        sqltest=sqltest+" and m.voc_no between "+fromdocno+" and  "+todocno+" ";
    }
    if(!(fromamount.equalsIgnoreCase("0")) && !(fromamount.equalsIgnoreCase("")) && !(toamount.equalsIgnoreCase("0")) && !(toamount.equalsIgnoreCase(""))){
       sqltest=sqltest+" and d.nettotal between "+fromamount+" and  "+toamount+" ";
    }
    if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
        sqltest=sqltest+" and m.acno ="+accdocno+" ";
     }
     		
    
    
    

	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		sqltest+=" and m.brhid='"+branch+"'";
		}	
	
	
	
	
	

	if(type.equalsIgnoreCase("ALL")){
		sqltest+=" and 1=1";
	
	}
	else if(type.equalsIgnoreCase("PED")){
		sqltest+="and d.qty-d.out_qty!=0";
	//pending
	}
	else if(type.equalsIgnoreCase("INV")){
		sqltest+="and d.out_qty>0";
	//invoiced
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
 	Connection conn = null;


    
	try {
			 conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();

			  
			String sql=" select m.voc_no 'Doc No',date_format(m.date,'%d-%m-%Y') 'Date',m.refno 'Ref No',h.account 'Vendor' ,h.description 'Name',\r\n" + 
					" d.total 'Total',d.discount 'Discount' ,d.nettotal 'Net Amount',\r\n" + 
					"  d.taxper 'Tax_Per',d.taxamount 'Tax_Amount',d.nettaxamount 'net_tax_Amount',d.desc1 'Description' from my_srvlpod d left join my_srvlpom m on d.rdocno=m.doc_no\r\n" + 
					" left join my_head h on h.doc_no=m.acno   \r\n" + 
					"   where  m.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "
					+ "    and  m.status<>7  "+sqltest+"  group by  d.rowno order by m.doc_no ";
     
        		
      //System.out.println("------1234234567-----"+sql);
        		ResultSet resultSet = stmtVeh.executeQuery(sql);
        		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
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
