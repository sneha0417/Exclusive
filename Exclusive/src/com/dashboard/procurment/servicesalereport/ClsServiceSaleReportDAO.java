package com.dashboard.procurment.servicesalereport;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsServiceSaleReportDAO {
	
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	
	
	public   JSONArray servicesaleReports(String branch,String fromdate,String todate,String fromdocno,String todocno,String fromamount,String toamount, String accdocno) throws SQLException {

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
						"h1.account detacno,h1.description detaccname,d.qty,d.unitprice,d.total,d.discount,sum(d.nettotal+d.tax) netamount\r\n" + 
						"  from my_srvsalem m left join my_srvsaled d on d.rdocno=m.doc_no\r\n" + 
						" left join my_head h on h.doc_no=m.acno  left join my_head h1 on h1.doc_no=d.acno\r\n left join my_brch br on m.brhid=br.doc_no" + 
						"   where  m.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "
						+ "    and  m.status<>7  "+sqltest+"  group by  m.doc_no order by d.rowno ";
         
            		
       System.out.println("------summary grid loading-----"+sql);
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
	
	
	

	
	
	
	public   JSONArray servicesaleReportexel(String branch,String fromdate,String todate,String fromdocno,String todocno,String fromamount,String toamount, String accdocno) throws SQLException {

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
 
				
				
				  
 
				
				String sql=" select br.branchname 'Branch',m.voc_no  'Doc No',date_format(m.date,'%d-%m-%Y') 'Date',h.account 'Client',h.description ' Name',\r\n" + 
						"h1.account  'Account',h1.description 'Account Name',d.total 'Total',d.discount 'Discount',sum(d.nettotal+d.tax) 'Net Amount', \r\n" + 
						" m.refno 'RefNo',m.invno 'PO No',m.invdate 'PO Date',m.desc1 'Description',m.payterm 'Pay_Term',m.delterm 'del_Term',m.deldate 'Del_Date' from my_srvsalem m left join my_srvsaled d on d.rdocno=m.doc_no\r\n" + 
						" left join my_head h on h.doc_no=m.acno  left join my_head h1 on h1.doc_no=d.acno\r\n left join my_brch br on m.brhid=br.doc_no" + 
						"   where  m.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "
						+ "    and  m.status<>7  "+sqltest+"  group by  m.doc_no order by d.rowno ";
         
            		
         System.out.println("------summary exel-----"+sql);
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
		        	
		        sql="select   t.description,t.doc_no,t.account from my_head t  where t.atype='AR' and t.m_s=0 "+sqltest+" ";
		        
		        System.out.println("client search===="+sql);
		        
		     
		        
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

public   JSONArray servicesaledetailReport(String branch,String fromdate,String todate,String fromdocno,String todocno,String fromamount,String toamount, String accdocno) throws SQLException {

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

			
			String sql="select m.voc_no,m.doc_no,m.date,invno refno,br.branchname,h1.atype,h.account,h.description accname,d.desc1,d.qty," +
					" d.unitprice,d.total,d.discount,d.nettotal,d.taxper,d.tax taxamount,d.nettaxamount,d.costtype,d.costcode,d.remarks,h1.account acc,h1.description accntt" +
					" from my_srvsaled d left join my_srvsalem m on m.doc_no=d.rdocno" +
					" left join my_head h1 on h1.doc_no=d.acno left join my_head h on h.doc_no=m.acno left join my_brch br on m.brhid=br.doc_no" + 
					"   where  m.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "
					+ "    and  m.status<>7  "+sqltest+"  group by  d.rowno order by d.rdocno ";
     
        		
   System.out.println("------detail grid query-----"+sql);
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
	
public   JSONArray servicesaledetailreportexel(String branch,String fromdate,String todate,String fromdocno,String todocno,String fromamount,String toamount, String accdocno) throws SQLException {

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

			
			
			  

			
			String sql="select br.branchname 'Branch',m.voc_no 'Doc_No',m.date 'Date',invno  'PO No',h.account 'Client',h.description 'Client_Name',h1.account 'Account',h1.atype 'Type',h1.description 'Account_Name',d.desc1 'Description',d.qty 'Qty'," +
					" d.unitprice 'Unit_Price',d.total 'Total',d.discount 'Discount',d.nettotal 'Net_Total',d.taxper 'tax_per',d.tax 'tax_Amount',d.nettaxamount 'Net_TaxAmount',d.costtype 'Cost_Type',d.costcode 'Cost_Code',d.remarks 'Remarks'" +
					" from my_srvsaled d left join my_srvsalem m on m.doc_no=d.rdocno" +
					" left join my_head h1 on h1.doc_no=d.acno left join my_head h on h.doc_no=m.acno left join my_brch br on m.brhid=br.doc_no" + 
					"   where  m.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "
					+ "    and  m.status<>7  "+sqltest+"  group by  d.rowno order by d.rdocno ";
     
        		
    System.out.println("------service sale detail exel-----"+sql);
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
