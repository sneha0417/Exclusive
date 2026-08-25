package com.dashboard.purchase;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
 


import net.sf.json.JSONArray;
 


import com.common.ClsCommon;
import com.connection.ClsConnection;
public class ClspurchaseReportsnewDAO {

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	public   JSONArray reqlistsearch(String branch,String fromdate,String todate,String status) throws SQLException {

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
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
  	
    
     	else if(status.equalsIgnoreCase("ORD"))
  	    {
  		
      		sqltest+=" and mm.status=3 and d.out_qty!=0  "; 
  	    }
     	 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
		
				
				
				String sql=" select mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc,m.part_no productid,m.productname,u.unit, d.unitid unitdocno,d.qty,"
						+ " convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,if(d.qty-d.out_qty=0,'',d.qty-d.out_qty) balqty "
						+ "  from my_reqm mm left join my_reqd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join  "
						+ " my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)   "
						+ "  where    mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest;
			
          
            	//System.out.println("-----------"+sql);	
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
	
	public   JSONArray reqlistsearchex(String branch,String fromdate,String todate,String status) throws SQLException {

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
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
  	
    
     	else if(status.equalsIgnoreCase("ORD"))
  	    {
  		
      		sqltest+=" and mm.status=3 and d.out_qty!=0  "; 
  	    }
     	 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
		
				
				
				String sql=" select mm.voc_no doc_no,mm.date,mm.refno,m.part_no productid,m.productname,u.unit,d.qty"
				 		+ "  from my_reqm mm left join my_reqd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join  "
						+ " my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)   "
						+ "  where    mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest;
			
          
            	//System.out.println("-----------"+sql);	
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
		
	public   JSONArray summorderlistsearch(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

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
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
    	 
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
  	
    
     	else if(status.equalsIgnoreCase("GRN"))
  	    {
  		
      		sqltest+=" and mm.status=3 and d.out_qty!=0  "; 
  	    }
     	 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();      
		 
		
				
				/*String sql=" select 'View' butview,sum((d.qty-d.out_qty)*d.amount-(((d.qty-d.out_qty)*d.amount)*d.disper/100)) balamount,"
						+"case when mm.rdtype='SOR' then 'Sales Order' when mm.rdtype='RFQ' then 'Purchase Request For Quote'  when   mm.rdtype='PR' then 'Purchase Request' else 'Direct' end as dtype"
						+ " ,mm.refno,mm.doc_no,mm.voc_no,mm.date,coalesce(cancelamt,0) cancelamt,d.prdId prodoc,if(d.clstatus=1,'Canceled','') status,d.clstatus, "
						+ "  h.account,h.description acname, "
						+ "  m.part_no productid,m.productname,u.unit, d.unitid unitdocno,d.taxper, sum(d.taxamount) taxamount, sum(d.nettotal+coalesce(d.taxamount,0)) totalamount, "
						+ "  d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,"
						+ "  convert(if(d.disper=0,'',d.disper),char(30)) disper,convert(if(d.discount=0,'',d.discount),char(30)) discount,sum(d.nettotal) nettotal   "
						+ "  from my_ordm mm left join my_ordd d on d.tr_no=mm.tr_no left join( select rdocno,coalesce(sum((d.qty-d.out_qty)*d.amount-(((d.qty-d.out_qty)*d.amount)*d.disper/100)),0) cancelamt  from my_ordd d"
						+" where clstatus=1 group by rdocno)  ss on ss.rdocno=mm.doc_no"
						+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)    where "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'    "+sqltest+" group by mm.doc_no ";*/
						
						
						String sql=" select 'View' butview,sum((d.qty-d.out_qty)*d.amount-(((d.qty-d.out_qty)*d.amount)*d.disper/100)) balamount,"
						+"case when mm.rdtype='SOR' then 'Sales Order' when mm.rdtype='RFQ' then 'Purchase Request For Quote'  when   mm.rdtype='PR' then 'Purchase Request' else 'Direct' end as dtype"
						+ " ,mm.refno,mm.doc_no,mm.voc_no,case when mm.billtype='1' then 'LOCAL' when mm.billtype='2' then 'INTERSTATE' else '' end as billtype,mm.ordervalue,mm.date,coalesce(cancelamt,0) cancelamt,d.prdId prodoc,if(d.clstatus=1,'Canceled','') status,d.clstatus, "
						+ "  h.account,h.description acname,e.exptax,e.exptot,"
						+ "  m.part_no productid,m.productname,u.unit,sum(d.discount) totaldiscount, d.unitid unitdocno,d.taxper, sum(d.taxamount) totaltax, sum(d.nettotal+coalesce(d.taxamount,0)) totalamount, "
						+ "  d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,"
						+ "  convert(if(d.disper=0,'',d.disper),char(30)) disper,convert(if(d.discount=0,'',d.discount),char(30)) discount,sum(d.total) nettotal   "
						+ "  from my_ordm mm left join my_ordd d on d.tr_no=mm.tr_no left join( select rdocno,coalesce(sum((d.qty-d.out_qty)*d.amount-(((d.qty-d.out_qty)*d.amount)*d.disper/100)),0) cancelamt  from my_ordd d"
						+" where clstatus=1 group by rdocno)  ss on ss.rdocno=mm.doc_no"
						+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno "
						+ "  left join( select rdocno,sum(srvtaxamount) exptax ,sum(nettotal) exptot from my_ordser group by rdocno)  e on e.rdocno=mm.doc_no"
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)    where "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'    "+sqltest+" group by mm.doc_no ";
        
						
        System.out.println("-----------"+sql);	
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
	
	
 
	public   JSONArray summorderlistsearchExcel(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

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
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
    	 
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
  	
    
     	else if(status.equalsIgnoreCase("GRN"))
  	    {
  		
      		sqltest+=" and mm.status=3 and d.out_qty!=0  "; 
  	    }
     	 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();     
		 
				
	 
				/*,d.taxper, d.taxamount*/
				
				/* String sql=" select mm.voc_no doc_no,DATE_FORMAT(mm.date,'%d-%m-%Y') date,mm.refno,"
					      + " case when mm.rdtype='SOR' then 'Sales Order' when mm.rdtype='RFQ' then 'Purchase Request For Quote'  when   mm.rdtype='PR' then 'Purchase Request' else 'Direct' end as type "
					          + " ,h.account,h.description 'Account_Name',sum(d.nettotal) NetTotal, sum(d.taxamount) taxamount, sum(d.nettotal+coalesce(d.taxamount,0)) 'Total Amount'  "
					          + " sum((d.qty-d.out_qty)*d.amount-(((d.qty-d.out_qty)*d.amount)*d.disper/100)) balamount,round(coalesce(cancelamt,0),2) as 'Cancel Amount' "
					      + "  from my_ordm mm left join my_ordd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
					      + "  left join my_head h on h.doc_no=mm.acno left join( select rdocno,coalesce(sum((d.qty-d.out_qty)*d.amount-(((d.qty-d.out_qty)*d.amount)*d.disper/100)),0) cancelamt  from my_ordd d"
					      + "  where clstatus=1 group by rdocno)  ss on ss.rdocno=mm.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no)    where "
					      + "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'   "+sqltest+" group by mm.doc_no";*/
					   
					   
					   String sql=" select mm.voc_no doc_no,DATE_FORMAT(mm.date,'%d-%m-%Y') date,mm.refno,"
					     // + " case when mm.rdtype='SOR' then 'Sales Order' when mm.rdtype='RFQ' then 'Purchase Request For Quote'  when   mm.rdtype='PR' then 'Purchase Request' else 'Direct' end as type "
					          + " h.account,h.description 'Account_Name',case when mm.billtype='1' then 'LOCAL' when mm.billtype='2' then 'INTERSTATE' else '' end as 'Bill Type',e.exptot 'Service Expense',e.exptax ' Service Tax Amount',sum(d.total) 'Product Total',sum(d.taxamount) 'Product Tax',sum(d.discount) 'Product Discount', sum(d.nettotal+coalesce(d.taxamount,0)) 'Total Amount' ,mm.ordervalue 'Order Value' "
					         /* + " sum((d.qty-d.out_qty)*d.amount-(((d.qty-d.out_qty)*d.amount)*d.disper/100)) balamount,round(coalesce(cancelamt,0),2) as 'Cancel Amount' "*/
					      + "  from my_ordm mm left join my_ordd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
					      + "  left join my_head h on h.doc_no=mm.acno "
					      + "  left join( select rdocno,sum(srvtaxamount) exptax,sum(nettotal) exptot from my_ordser group by rdocno)  e on e.rdocno=mm.doc_no"
					      + " left join( select rdocno,coalesce(sum((d.qty-d.out_qty)*d.amount-(((d.qty-d.out_qty)*d.amount)*d.disper/100)),0) cancelamt  from my_ordd d"
					      + "  where clstatus=1 group by rdocno)  ss on ss.rdocno=mm.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no)    where "
					      + "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'   "+sqltest+" group by mm.doc_no";
					   
             System.out.println("-----------"+sql);	
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
	

	

	public   JSONArray orderlistsearch(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

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
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
    	 
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
  	
    
     	else if(status.equalsIgnoreCase("GRN"))
  	    {
  		
      		sqltest+=" and mm.status=3 and d.out_qty!=0  "; 
  	    }
     	 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();     
		 
		
				
/*String sql=" select case when mm.rdtype='SOR' then 'Sales Order' when mm.rdtype='RFQ' then 'Purchase Request For Quote'  when   mm.rdtype='PR' then 'Purchase Request' else 'Direct' end as dtype"
						+ " ,mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc,if(d.clstatus=1,'Canceled','') status,d.clstatus, "
						+ "  h.account,h.description acname, "
						+ "  m.part_no productid,m.productname,u.unit, d.unitid unitdocno,d.taxper,d.taxamount,d.nettotal+coalesce(d.taxamount,0) nettaxamount , "
						+ "  d.qty,convert(if(d.foc=0,'',d.foc),char(30)) foc,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal,coalesce(cancelamt,0) cancelamt  "
						+ "  from my_ordm mm left join my_ordd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno left join( select psrno,rdocno,coalesce(sum((d.qty-d.out_qty)*d.amount-(((d.qty-d.out_qty)*d.amount)*d.disper/100)),0) cancelamt  from my_ordd d "
						+" where clstatus=1 group by rdocno,psrno)  ss on ss.rdocno=mm.doc_no and ss.psrno=d.psrno"
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)    where "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'    "+sqltest;*/
			
          String sql=" select case when mm.rdtype='SOR' then 'Sales Order' when mm.rdtype='RFQ' then 'Purchase Request For Quote'  when   mm.rdtype='PR' then 'Purchase Request' else 'Direct' end as dtype"
						+ " ,mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc,if(d.clstatus=1,'Canceled','') status,d.clstatus, "
						+ "  h.account,h.description acname,case when mm.billtype='1' then d.taxamount/2 when  mm.billtype='2' then 0  end as cgst,case when mm.billtype='1' then d.taxamount/2 when   mm.billtype='2' then 0 end as sgst,case when mm.billtype='1' then 0 when   mm.billtype='2' then d.taxamount end as igst, "
						+ "  m.part_no productid,m.productname,b.brandname,u.unit, d.unitid unitdocno,d.taxper,d.nettotal+coalesce(d.taxamount,0) nettaxamount , "
						+ "  d.qty,convert(if(d.foc=0,'',d.foc),char(30)) foc,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal,coalesce(cancelamt,0) cancelamt  "
						+ "  from my_ordm mm left join my_ordd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno left join( select psrno,rdocno,coalesce(sum((d.qty-d.out_qty)*d.amount-(((d.qty-d.out_qty)*d.amount)*d.disper/100)),0) cancelamt  from my_ordd d "
						+" where clstatus=1 group by rdocno,psrno)  ss on ss.rdocno=mm.doc_no and ss.psrno=d.psrno"
						+ "  left join my_brand b on b.doc_no=m.brandid left join my_prodattrib at on(at.mpsrno=m.doc_no) where "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'    "+sqltest;
			
            	//System.out.println("-----------"+sql);	
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
	
	
 
	public   JSONArray orderlistsearchExcel(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

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
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
    	 
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
  	
    
     	else if(status.equalsIgnoreCase("GRN"))
  	    {
  		
      		sqltest+=" and mm.status=3 and d.out_qty!=0  "; 
  	    }
     	 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();     
		 
				int  method=0;
		    	   
		    	String chk="select method  from gl_prdconfig where field_nme='foc'";
		    	ResultSet rs=stmtVeh.executeQuery(chk); 
		    	if(rs.next())
		    	{
		    		
		    		method=rs.getInt("method");
		    	}
		    	
		    	String sql1="";
		    	if(method==1)
		    	{
		    		sql1= " ,convert(if(d.foc=0,'',d.foc),char(30)) foc ";
		    		
		    	}
	 
		
				
			/*	String sql=" select mm.voc_no doc_no,DATE_FORMAT(mm.date,'%d-%m-%Y') date,mm.refno,"
					      + " case when mm.rdtype='SOR' then 'Sales Order' when mm.rdtype='RFQ' then 'Purchase Request For Quote'  when   mm.rdtype='PR' then 'Purchase Request' else 'Direct' end as dtype "
					      + "  ,h.account,h.description 'Account_Name', "
					      + "  m.part_no productid,m.productname,u.unit,  "
					      + "  d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
					      + "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal,d.taxper, d.taxamount,d.nettaxamount totalamount,round(coalesce(cancelamt,0),2) as 'Cancel Amount' "
					      + "  from my_ordm mm left join my_ordd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
					      + "  left join my_head h on h.doc_no=mm.acno left join( select psrno,rdocno,coalesce(sum((d.qty-d.out_qty)*d.amount-(((d.qty-d.out_qty)*d.amount)*d.disper/100)),0) cancelamt  from my_ordd d "
					      + " where clstatus=1 group by rdocno,psrno) ss on ss.rdocno=mm.doc_no and ss.psrno=d.psrno"
					      + "  left join my_prodattrib at on(at.mpsrno=m.doc_no)    where "
					      + "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest;*/
				
				
				
		  
		  String sql=" select mm.voc_no doc_no,DATE_FORMAT(mm.date,'%d-%m-%Y') date,mm.refno,"
					     // + " case when mm.rdtype='SOR' then 'Sales Order' when mm.rdtype='RFQ' then 'Purchase Request For Quote'  when   mm.rdtype='PR' then 'Purchase Request' else 'Direct' end as dtype "
					      + "  h.account,h.description 'Account_Name',m.part_no productid,m.productname,b.brandname 'Brand Name',u.unit,d.qty "+sql1+",d.total, "
					      + " convert(if(d.disper=0,'',d.disper),char(30)) 'Discount %',convert(if(d.discount=0,'',d.discount),char(30)) 'Discount Amount',d.taxper 'Tax %' "
					      
					      + "  ,case when mm.billtype='1' then d.taxamount/2 when  mm.billtype='2' then 0  end as 'CGST',case when mm.billtype='1' then d.taxamount/2 when   mm.billtype='2' then 0 end as 'SGST',case when mm.billtype='1' then 0 when   mm.billtype='2' then d.taxamount end as 'IGST', "
					      + "  d.amount ,d.nettotal,d.nettotal+coalesce(d.taxamount,0) totalamount "
					      + "  from my_ordm mm left join my_ordd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
					      + "  left join my_head h on h.doc_no=mm.acno left join( select psrno,rdocno,coalesce(sum((d.qty-d.out_qty)*d.amount-(((d.qty-d.out_qty)*d.amount)*d.disper/100)),0) cancelamt  from my_ordd d "
					      + " where clstatus=1 group by rdocno,psrno) ss on ss.rdocno=mm.doc_no and ss.psrno=d.psrno"
					      + "  left join my_brand b on b.doc_no=m.brandid left join my_prodattrib at on(at.mpsrno=m.doc_no)    where "
					      + "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest;
            	//System.out.println("-----------"+sql);	
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
                         sqltest=sqltest+" and t.account like '%"+accountno+"%'";
                     }
                     if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
                      sqltest=sqltest+" and t.description like '%"+accountname+"%'";
                     }
                     if(!(mob.equalsIgnoreCase("0")) && !(mob.equalsIgnoreCase(""))){
                       sqltest=sqltest+" and if(a.per_mob=0,a.per_tel,a.per_mob) like '%"+mob+"%'";
                  }
  try {
     conn = ClsConnection.getMyConnection();
     if(chk.equalsIgnoreCase("1"))
     {
    Statement stmt = conn.createStatement ();
      
   
    String  sql= "select t.doc_no,t.account,t.description,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_head t "
    		+ " inner join my_acbook a on t.cldocno=a.cldocno and a.dtype='VND'	and t.atype='AP' where a.active=1 and t.m_s=0 "+sqltest;
 
    
  //  System.out.println("-----sql---+"+sql);
    
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

	
	
	public   JSONArray grnlistsearch(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

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
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
 
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and  d.qty-d.out_qty>0 ";
     		 
  		
      	}
  	
    
     	else if(status.equalsIgnoreCase("PIV"))
  	    {
  		
      		sqltest+=" and mm.status=3 and  d.qty-d.out_qty!=d.qty  "; 
  	    }
     	 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
			
 
			/*	String sql="select mm.voc_no,mm.date,convert(if(mm.rdtype='DIR','Direct','Purchase Order'),char(30)) dtype, "
						+ "	mm.refno,h.account,h.description acname,m.part_no productid,m.productname,m.part_no proid ,  "
						+ " sum(dd.op_qty-dd.foc) qty,convert(if(sum(dd.out_qty+dd.rsv_qty+dd.del_qty-dd.foc)=0,'',sum(dd.out_qty+dd.rsv_qty+dd.del_qty-dd.foc)),char(30)) Out_qty,  "
						+ "convert(if((sum(dd.op_qty-dd.foc)-sum(dd.out_qty+dd.rsv_qty+dd.del_qty-dd.foc))=0,'',sum(dd.op_qty-dd.foc)-sum(dd.out_qty+dd.rsv_qty+dd.del_qty-dd.foc)),char(50)) balqty, "
						+ "	convert(if(sum(dd.foc)=0,'',sum(dd.foc)),char(30)) foc ,convert(if(sum(dd.foc_out)=0,'',sum(dd.foc_out)),char(30)) foc_out,convert(if(sum(dd.foc)-sum(dd.foc_out)=0,'',sum(dd.foc)-sum(dd.foc_out)),char(30)) focbal, "
						+ " d.prdId prodoc, u.unit, d.unitid unitdocno "
						+ " from  my_grnm  mm left join my_grnd d  on mm.tr_no=d.tr_no	left join my_head h on h.doc_no=mm.acno  "
						+ " left join my_prddin dd on dd.stockid=d.stockid and dd.prdid=d.prdid and d.psrno=dd.psrno and  d.specno=dd.specno  "
						+ " left join my_main m on m.doc_no=d.prdId	 left join my_unitm u on d.unitid=u.doc_no where  "
						+ " mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"' " +sqltest+ " group by dd.stockid" ;*/
				/*0 foc ,0 focbal,*/	
				
				 String sql ="select mm.voc_no,mm.date,convert(concat(if(mm.rdtype='DIR','Direct','Purchase Order'),' - ',mm.rrefno),char(30)) rdtype,mm.refno,	h.account, "
				 		+ " h.description acname,m.part_no productid,m.productname,m.part_no proid ,  d.qty, d.Out_qty,(d.qty - d.Out_qty) balqty,mm.description,bd.brandname brand,loc.loc_name location, "
				 		+ "   d.prdId prodoc, u.unit,d.unitid unitdocno,mm.refinvDate invdate,mm.refinvNo invno, d.foc,d.foc,d.batchno batch,d.expdate "
				 		+ " from  my_grnm  mm left join my_grnd d  on mm.tr_no=d.tr_no	left join my_head h on h.doc_no=mm.acno   "
				 		+ " left join my_main m on m.doc_no=d.prdId	 left join my_unitm u on d.unitid=u.doc_no left join my_brand bd on m.brandid=bd.doc_no"
				 		+ " left join my_locm loc on mm.locid=loc.doc_no "
				 		+ " where   mm.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"' " +sqltest+ " "; 
          System.out.println("====== "+sql);   	 
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
	
	
	public   JSONArray grnlistsearchexcel(String branch,String fromdate,String todate,String status,String acno) throws SQLException {
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
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		sqltest+=" and mm.status=3 and  d.qty-d.out_qty>0 ";
      	}
     	else if(status.equalsIgnoreCase("PIV"))
  	    {
      		sqltest+=" and mm.status=3 and  d.qty-d.out_qty!=d.qty  "; 
  	    }
     	Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();   

			String sql ="select mm.voc_no 'Doc No',mm.date 'Date',h.account 'Account No.',loc.loc_name location,convert(concat(if(mm.rdtype='DIR','Direct','Purchase Order'),' - ',mm.rrefno)),char(30)) 'Ref. Type', "
			 		+ "	mm.refno 'Ref No.',mm.refinvDate 'Inv Date',mm.refinvNo 'Inv No.',h.description 'Account Name',"
			 		+ " m.part_no 'ProductId',m.productname 'Product Name',bd.brandname brand, u.unit 'Unit', d.foc 'FOC',d.batchno 'Batch',d.expdate 'Exp Date',"
			 		+ "  d.qty 'Qty', d.Out_qty 'Out Qty',  (d.qty - d.Out_qty) 'Balance Qty',mm.description 	 "
			 		+ " from  my_grnm  mm left join my_grnd d  on mm.tr_no=d.tr_no	left join my_head h on h.doc_no=mm.acno  "
			 		+ " left join my_main m on m.doc_no=d.prdId	 left join my_unitm u on d.unitid=u.doc_no left join my_brand bd on m.brandid=bd.doc_no"
				 		+ " left join my_locm loc on mm.locid=loc.doc_no"
			 		+ " where   mm.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"' " +sqltest+ " "; 
			System.out.println("====== "+sql);   	 
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
	public   JSONArray grrlistsearchexcel(String branch,String fromdate,String todate,String status,String acno) throws SQLException {
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
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		sqltest+=" and mm.status=3 and  d.qty-d.out_qty>0 ";
      	}
     	else if(status.equalsIgnoreCase("PIV"))
  	    {
      		sqltest+=" and mm.status=3 and  d.qty-d.out_qty!=d.qty  "; 
  	    }
     	Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();   

			String sql ="select mm.voc_no 'Doc No',mm.date 'Date',h.account 'Account No.',loc.loc_name location,convert(concat(if(mm.rdtype='DIR','Direct','Purchase Order'),' - ',mm.rrefno),char(30)) 'Ref. Type', "
			 		+ "	mm.refno 'Ref No.',mm.refinvDate 'Inv Date',mm.refinvNo 'Inv No.',h.description 'Account Name',"
			 		+ " m.part_no 'ProductId',m.productname 'Product Name',bd.brandname brand, u.unit 'Unit', d.foc 'FOC',d.batchno 'Batch',d.expdate 'Exp Date',"
			 		+ "  d.qty 'Qty',mm.description 	 "
			 		+ " from  my_grrm  mm left join my_grrd d  on mm.tr_no=d.tr_no	left join my_head h on h.doc_no=mm.acno  "
			 		+ " left join my_main m on m.doc_no=d.prdId	 left join my_unitm u on d.unitid=u.doc_no left join my_brand bd on m.brandid=bd.doc_no"
				 		+ " left join my_locm loc on mm.locid=loc.doc_no"
			 		+ " where   mm.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"' " +sqltest+ " "; 
			System.out.println("====== "+sql);   	 
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
	
	
	
	public   JSONArray grrlistsearch(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

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
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
 
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
 
    	
     	Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
				
				String sql="select mm.voc_no,mm.date,convert(if(mm.rdtype='DIR','Direct','Goods Receipt Note'),char(30)) rdtype, "
						+ " mm.refno,h.account,h.description acname,m.part_no productid,m.productname,m.part_no proid ,  "
						+ " sum(d.qty) qty,sum(d.out_qty) out_qty,sum(d.qty-d.out_qty) bal_qty,convert(if(sum(d.foc)=0,'',sum(d.foc)),char(30)) foc , "
						+ " d.prdId prodoc, u.unit, d.unitid unitdocno,d.batchno batch,d.expdate,gm.refInvDate invdate,gm.refInvno invno,mm.description,bd.brand,loc.loc_name location"
			            + " from  my_grrm  mm left join my_grrd d  on mm.tr_no=d.tr_no " 
			            + " left join my_head h on h.doc_no=mm.acno    left join my_prddin dd "
			            + " on dd.stockid=d.stockid and dd.prdid=d.prdid and d.psrno=dd.psrno and  d.specno=dd.specno "
			            + " left join my_main m on m.doc_no=d.prdId	 left join my_unitm u on d.unitid=u.doc_no "
			            + " left join my_grnm gm on gm.doc_no=mm.rrefno left join my_brand bd on m.brandid=bd.doc_no left join my_locm loc on mm.locid=loc.doc_no"
			            + " where mm.status=3 and mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'" +sqltest+ "  group by dd.stockid ";
            	System.out.println("-----sql--"+sql); 
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
	
	
	public   JSONArray purchaselistsearch(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

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
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
  
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
  	
    
    
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
		
				
				
				String sql=" select  case when mm.rdtype='GRN' then 'Goods Receipt Note' when   mm.rdtype='PO' then 'Purchase Order' else 'Direct' end as dtype,mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc, "
						+ "  h.account,h.description acname, "
						+ "  m.part_no productid,m.productname,u.unit, d.unitid unitdocno,d.taxper, d.taxamount, d.nettaxamount, "
						+ "  d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal  "
						+ "  from my_srvm mm left join my_srvd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)    where "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest;
			
          
            //	System.out.println("-----------"+sql);	
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
	public   JSONArray purchaselistsearchex(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

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
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
  
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
  	
    
    
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
		
				
				
				String sql=" select  mm.voc_no doc_no,mm.date,mm.refno,case when mm.rdtype='GRN' then 'Goods Receipt Note' when   mm.rdtype='PO' then 'Purchase Order' else 'Direct' end as dtype, "
						+ "  h.account,h.description  account_name, "
						+ "  m.part_no productid,m.productname,u.unit, "
						+ "  d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal,d.taxper, d.taxamount,d.nettaxamount totalamount   "
						+ "  from my_srvm mm left join my_srvd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)    where "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest;
			
          
            //	System.out.println("-----------"+sql);	
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
	public   JSONArray purchasereturnlistsearch(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

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
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
  
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
     
    
    
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
		
				
				
			String sql=" select  mm.refno,d.batchno,d.expdate,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc, "
						+ "  h.account,h.description acname, "
						+ "  m.part_no productid,m.productname,l.loc_name,concat(if(mm.rdtype='PIV','Purchase Invoice','') ,' - ',mm.rrefno)  reftype,u.unit, d.unitid unitdocno,case when mm.billtype='1' then 'LOCAL' when mm.billtype='2' then 'INTERSTATE' else '' end as billtype,case when mm.billtype='1' then d.taxamount/2 when  mm.billtype='2' then 0  end as cgst,case when mm.billtype='1' then d.taxamount/2 when   mm.billtype='2' then 0 end as sgst,case when mm.billtype='1' then 0 when   mm.billtype='2' then d.taxamount end as igst, "
						+ "  d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.foc=0,'',d.foc),char(30)) foc,convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettaxamount nettotal  "
						+ "  from my_srrm mm left join my_srrd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno left join my_locm l on mm.locid=l.loc "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)    where "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest;
          
            	//System.out.println("-----------"+sql);	
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
	
	public   JSONArray purchasereturnlistsearchex(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

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

        String sqltest="",sqltest1="",sqltest2="",sqltest3="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
  
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
     
    
    
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
		
				int batchno=0,expdate=0,foc=0;
				String chk311="select method  from gl_prdconfig where field_nme='batch_no' ";
				ResultSet rss31=stmtVeh.executeQuery(chk311); 
				if(rss31.next())
				{

					batchno=rss31.getInt("method");
				}
				
				
				if(batchno>0)
				{
					sqltest1+=",d.batchno 'Batch No' ";
				}

				String chk="select method  from gl_prdconfig where field_nme='foc' ";
				ResultSet rss1=stmtVeh.executeQuery(chk); 
				if(rss1.next())
				{

					foc=rss1.getInt("method");
				}
				
				
				if(foc>0)
				{
					sqltest3+=",d.foc 'Foc' ";
				}

				String chk3="select method  from gl_prdconfig where field_nme='exp_date' ";
				ResultSet rss=stmtVeh.executeQuery(chk3); 
				if(rss.next())
				{

					expdate=rss.getInt("method");
				}
				if(expdate>0)
				{
					sqltest2+=",d.expdate 'Expdate' ";
				}
				
				String sql=" select  mm.voc_no 'Doc No',mm.date 'Date',mm.refno 'Ref No',case when mm.billtype='1' then 'LOCAL' when mm.billtype='2' then 'INTERSTATE' else '' end as 'Billtype',l.loc_name 'Location',concat(if(mm.rdtype='PIV','Purchase Invoice','') ,' - ',mm.rrefno)  reftype, "
						+ "  h.account 'Account No',h.description 'Account Name',m.part_no 'Product Id',m.productname 'Product Name',u.unit 'Unit',d.qty 'Out Qty',d.amount 'Unit Price'"+sqltest1+" "+sqltest2+" "+sqltest3+",case when mm.billtype='1' then d.taxamount/2 when  mm.billtype='2' then 0  end as 'CGST',case when mm.billtype='1' then d.taxamount/2 when   mm.billtype='2' then 0 end as 'SGST',case when mm.billtype='1' then 0 when   mm.billtype='2' then d.taxamount end as 'IGST', "
						+ "  d.total 'Total',convert(if(d.disper=0,'',d.disper),char(30)) 'Discount Percentage', convert(if(d.discount=0,'',d.discount),char(30)) 'Discount',d.nettaxamount 'Net Total'		  "
						+ "  from my_srrm mm left join my_srrd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno left join my_locm l on mm.locid=l.loc "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)    where "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest;
			
          
            	//System.out.println("-----------"+sql);	
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
	
	public   JSONArray ordercancellistsearch(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

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
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
    	 
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
		
				
				
				String sql=" select  'Edit' btnsave, d.rowno,case when mm.rdtype='SOR' then 'Sales Order' when mm.rdtype='RFQ' then 'Purchase Request For Quote'  when   mm.rdtype='PR' then 'Purchase Request' else 'Direct' end as dtype, "
						+ " mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc, "
						+ "  h.account,h.description acname, "
						+ "  m.part_no productid,m.productname,u.unit, d.unitid unitdocno, "
						+ "  d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal  "
						+ "  from my_ordm mm left join my_ordd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)    where mm.status=3 and d.qty!=d.out_qty  and d.clstatus=0 and"
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest;
			
          
            //	System.out.println("-----------"+sql);	
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
	
	
	public   JSONArray ordercancellistshow(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

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
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
    	 
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
		
				
				
				String sql=" select   case when mm.rdtype='SOR' then 'Sales Order' when mm.rdtype='RFQ' then 'Purchase Request For Quote'  when   mm.rdtype='PR' then 'Purchase Request' else 'Direct' end as dtype,mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc, "
						+ "  h.account,h.description acname, "
						+ "  m.part_no productid,m.productname,u.unit, d.unitid unitdocno, "
						+ "  d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal  "
						+ "  from my_ordm mm left join my_ordd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)    where  d.clstatus=1 and "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest;
			
          
            //	System.out.println("-----------"+sql);	
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
	
	
	/*public   JSONArray summpurchase(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

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
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
    	 
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
  	
    
     	else if(status.equalsIgnoreCase("GRN"))
  	    {
  		
      		sqltest+=" and mm.status=3 and d.out_qty!=0  "; 
  	    }
     	 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();      
				
				String sql=" select 'View' butview,dd.total ptotal,ser.nettotal service,convert(coalesce(sexp.nettotal,''),char(40))  purexp,lm.loc_name loc,mm.refinvdate invdate,mm.refinvno invno,sum((d.qty-d.out_qty)*d.amount-(((d.qty-d.out_qty)*d.amount)*d.disper/100)) balamount,"
						+" convert(concat(case when mm.rdtype='GRN' then 'Goods Receipt Note -' when   mm.rdtype='PO' then 'Purchase Order -' else 'Direct' end,rd.voc_no),char(100)) dtype  "
						+ " ,mm.refno,case when mm.billtype='1' then 'LOCAL' when   mm.billtype='2' then 'INTERSTATE' else ''  end as billtype,mm.doc_no,mm.voc_no,mm.date,0 cancelamt,d.prdId prodoc , "
						+ "  h.account,h.description acname, "
						+ "  m.part_no productid,m.productname,u.unit, d.unitid unitdocno,d.taxper, sum(d.taxamount) taxamount, sum(d.nettotal+coalesce(d.taxamount,0)) totalamount, "
						+ "  d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,"
						+ "  convert(if(d.disper=0,'',d.disper),char(30)) disper,convert(if(d.discount=0,'',d.discount),char(30)) discount,sum(d.nettotal) nettotal, sum(d.nettotal) nettotal,"
						+ "case when mm.billtype='1' then (sum(d.taxamount)+(ser.taxamount))/2 when   mm.billtype='2' then 0 end as cgst,"
						+ "case when mm.billtype='1' then (sum(d.taxamount)+(ser.taxamount))/2 when   mm.billtype='2' then 0 end as sgst,case when mm.billtype='2' then (sum(d.taxamount)+(ser.taxamount)) when   mm.billtype='1' then 0 end as igst,"
						+ "sum(d.discount) distotal   "
						+ "  from my_srvm mm left join my_srvd d on d.tr_no=mm.tr_no "
						+ " left join my_main m on m.doc_no=d.prdId left join my_locm lm on lm.loc=mm.locid left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno left join my_ordm rd on rd.doc_no=mm.rrefno"
						+ "  left join (select sum(nettotal) nettotal,sum(srvtaxamount) taxamount,rdocno from my_srvser group by rdocno)  ser on ser.rdocno=mm.doc_no "
						+ "left join (select sum(nettotal) nettotal,sum(total) total,rdocno from my_srvd group by rdocno)  dd on dd.rdocno=mm.doc_no "
						+ "left join (select sum(nettotal) nettotal,rdocno from my_srvexp group by rdocno)  sexp on sexp.rdocno=mm.doc_no"
						+ " left join my_prodattrib at on(at.mpsrno=m.doc_no)    where "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'    "+sqltest+" group by mm.doc_no ";
         //System.out.println("-----++------"+sql);	
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
	
	
 
	public   JSONArray summpurchaseExcel(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

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
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
    	 
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
  	
    
     	else if(status.equalsIgnoreCase("GRN"))
  	    {
  		
      		sqltest+=" and mm.status=3 and d.out_qty!=0  "; 
  	    }
     	 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();     
		 
				
	 
				,d.taxper, d.taxamount
				
				String sql=" select mm.voc_no doc_no,DATE_FORMAT(mm.date,'%d-%m-%Y') date,h.account,h.description 'Account Name',"
						+ "lm.loc_name 'Location',case when mm.billtype='1' then 'LOCAL' when   mm.billtype='2' then 'INTERSTATE' else ''  end as 'Bill Type',"
					    		  + " convert(concat(case when mm.rdtype='GRN' then 'Goods Receipt Note -' when   mm.rdtype='PO' then 'Purchase Order -' else 'Direct' end,rd.voc_no),char(100)) 'Ref Type'  ,"
					      + "mm.refno,mm.refinvno invno,mm.refinvdate invdate "
					          + " ,d.total 'Product Total',sum(d.discount) 'Discount Total',sum(d.nettotal) NetTotal,ser.nettotal service,d.nettotal 'Purchase Expense',"
					          + "case when mm.billtype='1' then (sum(d.taxamount)+(ser.taxamount))/2 when   mm.billtype='2' then 0 end as cgst,"
								+ "case when mm.billtype='1' then (sum(d.taxamount)+(ser.taxamount))/2 when   mm.billtype='2' then 0 end as sgst,case when mm.billtype='2' then (sum(d.taxamount)+(ser.taxamount)) when   mm.billtype='1' then 0 end as igst,"
					          + " sum(d.nettotal+coalesce(d.taxamount,0)) 'Total Amount'  "
					      + "  from my_srvm mm left join my_srvd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
					      + "  left join my_head h on h.doc_no=mm.acno  left join my_locm lm on lm.loc=mm.locid "
					      + "  left join my_ordm rd on rd.doc_no=mm.rrefno"
							+ "  left join (select sum(nettotal) nettotal,sum(srvtaxamount) taxamount,rdocno from my_srvser group by rdocno)  ser on ser.rdocno=mm.doc_no "
							+ "left join (select sum(nettotal) nettotal,sum(total) total,rdocno from my_srvd group by rdocno)  dd on dd.rdocno=mm.doc_no "
							+ "left join (select sum(nettotal) nettotal,rdocno from my_srvexp group by rdocno)  sexp on sexp.rdocno=mm.doc_no"
							+ " left join my_prodattrib at on(at.mpsrno=m.doc_no) "
					      + "   where  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'   "+sqltest+" group by mm.doc_no";
					   
                     // System.out.println("-----------"+sql);	
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
    }*/
	/*public   JSONArray purchaselistdetsearch(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

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
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
    	 
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
  	
    
     	else if(status.equalsIgnoreCase("GRN"))
  	    {
  		
      		sqltest+=" and mm.status=3 and d.out_qty!=0  "; 
  	    }
     	 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();     
		 
		
				
				String sql=" select br.brand,CONVERT(group_concat(pr.exp_date),CHAR(1000)) expdate,CONVERT(group_concat(pr.batch_no),CHAR(1000)) batch,case when mm.rdtype='GRN' then 'Goods Receipt Note' when   mm.rdtype='PO' then 'Purchase Order' else 'Direct' end as  dtype "
						+ " ,mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc , "
						+ "  h.account,h.description acname, "
						+ "  m.part_no productid,m.productname,u.unit, d.unitid unitdocno,d.taxper, d.taxamount, d.nettotal+coalesce(d.taxamount,0) nettaxamount , "
						+ "  d.qty,convert(if(d.foc=0,'',d.foc),char(30)) foc,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal,case when mm.billtype='1' then taxamount/2 when   mm.billtype='2' then 0 end as cgst,case when mm.billtype='1' then taxamount/2 when   mm.billtype='2' then 0 end as sgst,case when mm.billtype='2' then taxamount/2 when   mm.billtype='1' then 0 end as igst   "
						+ "  from my_srvm mm left join my_srvd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno left join my_prddin pr on pr.tr_no=d.tr_no and pr.psrno=d.psrno"
						+ "  left join my_brand br on br.doc_no=m.brandid left join my_prodattrib at on(at.mpsrno=m.doc_no)    where "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'    "+sqltest+" group by d.tr_no,d.psrno ";
			
          
            	//System.out.println("------++-----"+sql);	
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
	
	
 
	public   JSONArray purchaselistdetsearchExcel(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

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
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
    	 
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
  	
    
     	else if(status.equalsIgnoreCase("GRN"))
  	    {
  		
      		sqltest+=" and mm.status=3 and d.out_qty!=0  "; 
  	    }
     	 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();     
		 
				
 
				
				String sql=" select mm.voc_no doc_no,DATE_FORMAT(mm.date,'%d-%m-%Y') date,mm.refno,"
					      + " case when mm.rdtype='GRN' then 'Goods Receipt Note' when   mm.rdtype='PO' then 'Purchase Order' else 'Direct' end as  type "
					      + "  ,h.account,h.description 'Account_Name', "
					      + "  m.part_no productid,m.productname 'Product Name',br.brand 'Brand Name',CONVERT(group_concat(pr.batch_no),CHAR(1000)) batch,CONVERT(group_concat(pr.exp_date),CHAR(1000)) 'Exp Date',u.unit,  "
					      + "  d.qty,convert(if(d.foc=0,'',d.foc),char(30)) foc,case when mm.billtype='1' then taxamount/2 when   mm.billtype='2' then 0 end as CGST,case when mm.billtype='1' then taxamount/2 when   mm.billtype='2' then 0 end as SGST,"
					      + "case when mm.billtype='2' then taxamount/2 when   mm.billtype='1' then 0 end as IGST,convert(if(d.disper=0,'',d.disper),char(30)) 'Discount Perc',"
					      + "convert(if(d.discount=0,'',d.discount),char(30)) Discount,d.amount 'Unit Price',d.total Total,d.nettotal,d.nettotal+coalesce(d.taxamount,0)  totalamount "
					      + "  from my_srvm mm left join my_srvd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
					      + "  left join my_prddin pr on pr.tr_no=d.tr_no and pr.psrno=d.psrno left join my_head h on h.doc_no=mm.acno "
					      + "  left join my_brand br on br.doc_no=m.brandid left join my_prodattrib at on(at.mpsrno=m.doc_no)    where "
					      + "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest+" group by d.tr_no,d.psrno";
          
            	//System.out.println("-----------"+sql);	
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
	*/
	public   JSONArray purchaselistdetsearch(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

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
     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
      sqltest+=" and mm.brhid='"+branch+"'";
   }
     
      
     if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
      sqltest+=" and mm.acno='"+acno+"'";
   }
     
     if(status.equalsIgnoreCase("All"))
     {
      sqltest+=" and  mm.status=3 "; 
     }
      
     else if(status.equalsIgnoreCase("PED"))
      {
       
       sqltest+=" and mm.status=3 and d.out_qty=0 ";
        
    
       }
   
    
      else if(status.equalsIgnoreCase("GRN"))
       {
    
        sqltest+=" and mm.status=3 and d.out_qty!=0  "; 
       }
       
        
     
      Connection conn = null;
        
  try {
     conn = ClsConnection.getMyConnection();
    Statement stmtVeh = conn.createStatement ();     
   
  
    
    String sql=" select c.category category,br.brand,CONVERT(group_concat(pr.exp_date),CHAR(1000)) expdate,CONVERT(group_concat(pr.batch_no),CHAR(1000)) batch,convert(concat(case when mm.rdtype='GRN' then 'Goods Receipt Note -' when   mm.rdtype='PO' then 'Purchase Order -' else 'Direct' end, if( mm.rdtype='DIR','',rd.voc_no)),char(100)) dtype "
      + " ,mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc , "
      + "  h.account,h.description acname, "
      + "  m.part_no productid,m.productname,u.unit, d.unitid unitdocno,d.taxper, d.taxamount, d.nettotal+coalesce(d.taxamount,0) nettaxamount , "
      + "  d.qty,convert(if(d.foc=0,'',d.foc),char(30)) foc,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
      + "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal,case when mm.billtype='1' then taxamount/2 when   mm.billtype='2' then 0 end as cgst,case when mm.billtype='1' then taxamount/2 when   mm.billtype='2' then 0 end as sgst,case when mm.billtype='2' then taxamount when   mm.billtype='1' then 0 end as igst   "
      + "  from my_srvm mm left join my_srvd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join my_catm c on c.doc_no=m.catid left join my_unitm u on d.unitid=u.doc_no "
      + "  left join my_head h on h.doc_no=mm.acno left join my_prddin pr on pr.tr_no=d.tr_no and pr.psrno=d.psrno"
      + "  left join my_ordm rd on rd.doc_no=mm.rrefno left join my_brand br on br.doc_no=m.brandid left join my_prodattrib at on(at.mpsrno=m.doc_no)    where "
      + "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'    "+sqltest+" group by d.tr_no,d.psrno ";
          
                 System.out.println("------+detailorderlist+-----"+sql); 
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
 
	public   JSONArray purchaselistdetsearchExcel(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

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
     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
      sqltest+=" and mm.brhid='"+branch+"'";
   }
     
      
     if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
      sqltest+=" and mm.acno='"+acno+"'";
   }
     
     if(status.equalsIgnoreCase("All"))
     {
      sqltest+=" and  mm.status=3 "; 
     }
      
     else if(status.equalsIgnoreCase("PED"))
      {
       
       sqltest+=" and mm.status=3 and d.out_qty=0 ";
        
    
       }
   
    
      else if(status.equalsIgnoreCase("GRN"))
       {
    
        sqltest+=" and mm.status=3 and d.out_qty!=0  "; 
       }
       
        
     
      Connection conn = null;
        
  try {
     conn = ClsConnection.getMyConnection();
    Statement stmtVeh = conn.createStatement ();   
    
    //+ "case when mm.billtype='2' then coalesce(taxamount,0) when   mm.billtype='1' then 0 end as IGST,
    
    String sql=" select mm.voc_no doc_no,DATE_FORMAT(mm.date,'%d-%m-%Y') date,mm.refno,"
           + "convert(concat(case when mm.rdtype='GRN' then 'Goods Receipt Note -' when   mm.rdtype='PO' then 'Purchase Order -' else 'Direct' end, if( mm.rdtype='DIR','',rd.voc_no)),char(100))  type "
           + "  ,h.account 'Account No',h.description 'Account Name', "
           + "  m.part_no productid,m.productname 'Product Name',br.brand 'Brand Name',c.category 'category',CONVERT(group_concat(pr.batch_no),CHAR(1000)) batch,CONVERT(group_concat(pr.exp_date),CHAR(1000)) 'Exp Date',u.unit,  "
           + "  d.qty,convert(if(d.foc=0,'',d.foc),char(30)) foc,"
           + "convert(if(d.disper=0,'',d.disper),char(30)) 'Discount Perc',"
           + "convert(if(d.discount=0,'',d.discount),char(30)) 'Discount Amount',d.amount 'Unit Price',d.total Total,d.nettotal,d.taxamount,d.nettotal+coalesce(d.taxamount,0)  totalamount "
           + "  from my_srvm mm left join my_srvd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join my_catm c on c.doc_no=m.catid left join my_unitm u on d.unitid=u.doc_no "   
           + "  left join my_prddin pr on pr.tr_no=d.tr_no and pr.psrno=d.psrno left join my_head h on h.doc_no=mm.acno "
           + "  left join my_ordm rd on rd.doc_no=mm.rrefno left join my_brand br on br.doc_no=m.brandid left join my_prodattrib at on(at.mpsrno=m.doc_no)    where "
           + "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest+" group by d.tr_no,d.psrno";
            
                  System.out.println("------excel detail data-----"+sql); 
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
	public   JSONArray summpurchase(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

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
     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
      sqltest+=" and mm.brhid='"+branch+"'";
   }
     
      
     if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
      sqltest+=" and mm.acno='"+acno+"'";
   }
     
     if(status.equalsIgnoreCase("All"))
     {
      sqltest+=" and  mm.status=3 "; 
     }
      
     else if(status.equalsIgnoreCase("PED"))
      {
       
       sqltest+=" and mm.status=3 and d.out_qty=0 ";
        
    
       }
   
    
      else if(status.equalsIgnoreCase("GRN"))
       {
    
        sqltest+=" and mm.status=3 and d.out_qty!=0  "; 
       }
       
        
     
      Connection conn = null;
        
  try {
     conn = ClsConnection.getMyConnection();
    Statement stmtVeh = conn.createStatement ();      
    
    String sql=" select mm.tr_no,mm.brhid,'View' butview,dd.total ptotal,ser.nettotal service,convert(coalesce(sexp.nettotal,''),char(40))  purexp,lm.loc_name loc,mm.refinvdate invdate,mm.refinvno invno,sum((d.qty-d.out_qty)*d.amount-(((d.qty-d.out_qty)*d.amount)*d.disper/100)) balamount,"
      +" convert(concat(case when mm.rdtype='GRN' then 'Goods Receipt Note -' when   mm.rdtype='PO' then 'Purchase Order -' else 'Direct' end, if( mm.rdtype='DIR','',rd.voc_no)),char(100)) dtype  "
      + " ,mm.refno,case when mm.billtype='1' then 'LOCAL' when   mm.billtype='2' then 'INTERSTATE' else ''  end as billtype,mm.doc_no,mm.voc_no,mm.date,0 cancelamt,d.prdId prodoc , "
      + "  h.account,h.description acname, "
      + "  m.part_no productid,m.productname,u.unit, d.unitid unitdocno,d.taxper,sum(d.taxamount) taxamount,mm.nettotal totalamount, "
      + "  d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,"
      + "  convert(if(d.disper=0,'',d.disper),char(30)) disper,convert(if(d.discount=0,'',d.discount),char(30)) discount,sum(d.nettaxamount) nettotaltax, sum(d.nettotal) nettotal,"
      + " case when mm.billtype='1' then (coalesce(sum(d.taxamount),0)+coalesce((ser.taxamount),0))/2 when mm.billtype='2' then 0 end as cgst,case when mm.billtype='1' then (coalesce(sum(d.taxamount),0)+coalesce((ser.taxamount),0))/2 when   mm.billtype='2' then 0 end as sgst,case when mm.billtype='2' then (coalesce(sum(d.taxamount),0)+coalesce((ser.taxamount),0)) when   mm.billtype='1' then 0 end as igst, "
      + "sum(d.discount) distotal   "
      + "  from my_srvm mm left join my_srvd d on d.tr_no=mm.tr_no "
      + " left join my_main m on m.doc_no=d.prdId left join my_locm lm on lm.loc=mm.locid left join my_unitm u on d.unitid=u.doc_no "
      + "  left join my_head h on h.doc_no=mm.acno left join my_ordm rd on rd.doc_no=mm.rrefno"
      + "  left join (select sum(nettotal) nettotal,sum(srvtaxamount) taxamount,rdocno from my_srvser group by rdocno)  ser on ser.rdocno=mm.doc_no "
      + "left join (select sum(nettotal) nettotal,sum(total) total,rdocno from my_srvd group by rdocno)  dd on dd.rdocno=mm.doc_no "
      + "left join (select sum(nettotal) nettotal,rdocno from my_srvexp group by rdocno)  sexp on sexp.rdocno=mm.doc_no"
      + " left join my_prodattrib at on(at.mpsrno=m.doc_no)    where "
      + "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'    "+sqltest+" group by mm.doc_no ";
              System.out.println("-----SUMMARY GRID DATA------"+sql);       
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
	public   JSONArray summpurchaseExcel(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

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
     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
      sqltest+=" and mm.brhid='"+branch+"'";
   }
     
      
     if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
      sqltest+=" and mm.acno='"+acno+"'";
   }
     
     if(status.equalsIgnoreCase("All"))
     {
      sqltest+=" and  mm.status=3 "; 
     }
      
     else if(status.equalsIgnoreCase("PED"))
      {
       
       sqltest+=" and mm.status=3 and d.out_qty=0 ";
        
    
       }
   
    
      else if(status.equalsIgnoreCase("GRN"))
       {
    
        sqltest+=" and mm.status=3 and d.out_qty!=0  "; 
       }
       
        
     
      Connection conn = null;
        
  try {
     conn = ClsConnection.getMyConnection();
    Statement stmtVeh = conn.createStatement ();     
   
    
  
    /*,d.taxper, d.taxamount*/
    
    
    //+ " case when mm.billtype='1' then (coalesce(sum(d.taxamount),0)+coalesce((ser.taxamount),0))/2 when mm.billtype='2' then 0 end as cgst,case when mm.billtype='1' then (coalesce(sum(d.taxamount),0)+coalesce((ser.taxamount),0))/2 when   mm.billtype='2' then 0 end as sgst,case when mm.billtype='2' then (coalesce(sum(d.taxamount),0)+coalesce((ser.taxamount),0)) when   mm.billtype='1' then 0 end as igst, "
    
    String sql=" select mm.voc_no doc_no,DATE_FORMAT(mm.date,'%d-%m-%Y') date,h.account 'Account No',h.description 'Account Name',"
      + "lm.loc_name 'Location',case when mm.billtype='1' then 'LOCAL' when   mm.billtype='2' then 'INTERSTATE' else ''  end as 'Bill Type',"
             + " convert(concat(case when mm.rdtype='GRN' then 'Goods Receipt Note -' when   mm.rdtype='PO' then 'Purchase Order -' else 'Direct' end,if( mm.rdtype='DIR','',rd.voc_no)),char(100)) 'Ref Type'  ,"
           + "mm.refno,mm.refinvno invno,mm.refinvdate invdate "
               + " ,d.total 'Product Total',sum(d.discount) 'Discount Total',sum(d.taxamount)'Tax Amount',sum(d.nettaxamount) NetTotal,ser.nettotal service,sexp.nettotal 'Purchase Expense',"
               
               + " mm.nettotal 'Total Amount'  "   
           + "  from my_srvm mm left join my_srvd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
           + "  left join my_head h on h.doc_no=mm.acno  left join my_locm lm on lm.loc=mm.locid "
           + "  left join my_ordm rd on rd.doc_no=mm.rrefno"
       + "  left join (select sum(nettotal) nettotal,sum(srvtaxamount) taxamount,rdocno from my_srvser group by rdocno)  ser on ser.rdocno=mm.doc_no "
       + "left join (select sum(nettotal) nettotal,sum(total) total,rdocno,sum(taxamount) prdtax  from my_srvd group by rdocno)  dd on dd.rdocno=mm.doc_no "
       + "left join (select sum(nettotal) nettotal,rdocno from my_srvexp group by rdocno)  sexp on sexp.rdocno=mm.doc_no"
       + " left join my_prodattrib at on(at.mpsrno=m.doc_no) "
           + "   where  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'   "+sqltest+" group by mm.doc_no";
        
                      System.out.println("-----EXCEL SUMMARY DATA------"+sql); 
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
	