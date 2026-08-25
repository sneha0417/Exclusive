package com.dashboard.purchases.purchaserequestfollowup;  

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.*;

public class ClsPurchaseRequestFollowupDAO {
	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();
	
	public   JSONArray listsearch(String branch,String fromdate,String todate,String status,String reqdocno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
/*        java.sql.Date sqlfromdate = null;
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
     
     	}*/

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
      	if((!(reqdocno.equalsIgnoreCase("NA")) )&&(!(reqdocno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.doc_no='"+reqdocno+"'";
 		}
    	
    	 
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();     
		 
		
				
				String sql=" select bv.fdate,mm.brhid,mm.description desc1, mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc "
						+ "  from my_reqm mm left join my_reqd d on d.tr_no=mm.tr_no  "
				 		+ "left join (select max(b.doc_no) doc_no,rdocno from my_bprf b group by  rdocno) "
	        			+ "  b on(b.rdocno=mm.doc_no) left join  my_bprf bv on b.doc_no=bv.doc_no  "
	        			+ "    where    d.qty>d.out_qty   "+sqltest+" group by mm.doc_no  ";
						
//            	     /  System.out.println("-----------"+sql);	
            		   ResultSet resultSet = stmt.executeQuery(sql);
            		   RESULTDATA=ClsCommon.convertToJSON(resultSet);
            		   stmt.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	public   JSONArray listsearchex(String branch,String fromdate,String todate,String status,String reqdocno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
/*        java.sql.Date sqlfromdate = null;
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
     
     	}*/

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
     
      	if((!(reqdocno.equalsIgnoreCase("NA")) )&&(!(reqdocno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.doc_no='"+reqdocno+"'";
 		}
    	
    	 
    	 
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt  = conn.createStatement ();     
		 
  
				String sql=" select  mm.voc_no 'Doc No',mm.date 'Date',mm.refno 'Ref No',mm.description 'Description',bv.fdate 'Follow up Date' "
						+ "  from my_reqm mm left join my_reqd d on d.tr_no=mm.tr_no  "
				 		+ "left join (select max(b.doc_no) doc_no,rdocno from my_bprf b group by  rdocno) "
	        			+ "  b on(b.rdocno=mm.doc_no) left join  my_bprf bv on b.doc_no=bv.doc_no  "
	        			+ "    where    d.qty>d.out_qty   "+sqltest+" group by mm.doc_no  ";
						
            	    //   System.out.println("-----------"+sql);	
            		   ResultSet resultSet = stmt.executeQuery(sql);
            		   RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
            		   stmt.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	
	
	
	public   JSONArray listsubsearch(String docno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
 
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();      
		 
				String sql=" select    m.part_no productid,m.productname,u.unit,bd.brandname , "
						+ "  d.qty-d.out_qty  qty  "
						+ "  from my_reqm mm left join my_reqd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId "
						+ "  left join my_unitm u on d.unitid=u.doc_no left join  my_brand bd on m.brandid=bd.doc_no "
					 	+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)    where     d.qty>d.out_qty and   mm.doc_no="+docno+" ";
          
            	//  System.out.println("-----------"+sql);	
            		ResultSet resultSet = stmt.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
            		 stmt.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	
	public   JSONArray listsubsearchex(String docno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
 
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();   
				
	 
		
				
				String sql=" select  mm.voc_no 'Doc No'  ,m.part_no 'Product Id',m.productname 'Product Name',bd.brandname 'Brand Name' ,u.unit 'Unit' , "
						+ "  d.qty-d.out_qty   'Qty'  "
						+ "  from my_reqm mm left join my_reqd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId "
						+ "  left join my_unitm u on d.unitid=u.doc_no left join  my_brand bd on m.brandid=bd.doc_no "
					 	+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)    where     d.qty>d.out_qty and   mm.doc_no="+docno+" ";
          
            	 // System.out.println("-----------"+sql);	
            		ResultSet resultSet = stmt.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
            		 stmt.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	
	
	
	
	
	public   JSONArray Details(String rdocno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();
			
            		String sql=" select m.date detdate,m.remarks remk,m.fdate,u.user_name user from my_bprf m "
            				+ " inner join my_user u on u.doc_no=m.userid where m.rdocno='"+rdocno+"'     group by m.doc_no ";
///System.out.println("=======sql=="+sql);
            		ResultSet resultSet = stmt.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
            		 stmt.close();
     				conn.close();
            
            	
          

		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
public   JSONArray mainsearch(HttpSession session,String docnoss,String datess,String aa,String descriptions,String refnoss) throws SQLException {

		
	
 
		
		JSONArray RESULTDATA=new JSONArray();
		if(!(aa.equalsIgnoreCase("yes")))
		{
			return RESULTDATA;
		}
		
		
		
	   
	    
	    java.sql.Date  sqlStartDate = null;
	  		if(!(datess.equalsIgnoreCase("undefined"))&&!(datess.equalsIgnoreCase(""))&&!(datess.equalsIgnoreCase("0")))
	      	{
	      	sqlStartDate = ClsCommon.changeStringtoSqlDate(datess);
	      	}
	      	
	      	
	     
	  		String sqltest="";
	  	    
	  	   	if((!(docnoss.equalsIgnoreCase(""))) && (!(docnoss.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and m.voc_no like '%"+docnoss+"%'";
	      	}
	       
	      	if((!(descriptions.equalsIgnoreCase(""))) && (!(descriptions.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and m.description like '%"+descriptions+"%'";
	      	}
	      
	     	if((!(refnoss.equalsIgnoreCase(""))) && (!(refnoss.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and m.refno like '%"+refnoss+"%'";
	      	}
	      
	      	
	      	
	      	
	      	if(!(sqlStartDate==null)){
	      		sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
	      	}
	    
	   
	    
	    Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
		 
			
				Statement stmtmain = conn.createStatement ();
				
				
 		
	        	String pySql=("select m.doc_no,m.voc_no,m.date,m.description,m.refno  from my_reqm m    where m.status!=7    "+sqltest+" ");
	      
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
				stmtmain.close();
				
			 
			conn.close();
			  return RESULTDATA;
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}
	
	
}
