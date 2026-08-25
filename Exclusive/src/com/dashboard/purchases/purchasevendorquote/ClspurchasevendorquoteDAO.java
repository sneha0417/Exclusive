package com.dashboard.purchases.purchasevendorquote;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClspurchasevendorquoteDAO {

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	public   JSONArray subgridsearch(String branch,String fromdate,String todate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
 
        java.sql.Date sqlfromdate = null;
       	if((!fromdate.equalsIgnoreCase("undefined")) && (!fromdate.equalsIgnoreCase("")) && (!fromdate.equalsIgnoreCase("0")) && (!fromdate.equalsIgnoreCase("NA")))
       	{
       		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
       		
       	}
       	else{
       
       	}

          java.sql.Date sqltodate = null;
       	if((!todate.equalsIgnoreCase("undefined")) && (!todate.equalsIgnoreCase("")) && (!todate.equalsIgnoreCase("0")) && (!todate.equalsIgnoreCase("NA")))
       	{
       		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
       		
       	}
       	else{
       
       	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and m.brhid='"+branch+"'";
 		}
    	
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
		
				
				
			//	doc_no voc_no description
				
				
	        	String pySql=("select m.doc_no,m.voc_no,m.date,h.description vendor,h.account, m.acno,if(rdtype='DIR','DIR',concat('CEQ-',m.rvocno)) reftype from my_prfqm m "
	        			+ " left join my_head h on h.doc_no=m.acno   where m.status=3  and pstatus<2 and m.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest );
			
          
            	 System.out.println("----pySql-------"+pySql);	
            		ResultSet resultSet = stmtVeh.executeQuery(pySql);
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

	
	public   JSONArray mainsearch(String docno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
  
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
		
				
				
			//	doc_no voc_no description
 
	        	String pySql=(" select d.rowno refrowno,bv.fdate,m1.brhid branchids,d.rdocno docno, d.clstatus,at.mspecno specid,d.disper discper,m1.rdtype,m1.rrefno,m.part_no productid,m.productname,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid , "
	        			+ " m.productname proname,	 u.unit, d.unitid unitdocno,d.qty,d.amount unitprice,d.total,d.discount,d.nettotal from my_prfqm m1 "
	        			+ " left join my_prfqd d on m1.doc_no=d.rdocno	 left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
	        			+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)  left join (select max(b.doc_no) doc_no,rdocno,refrowno from my_bprfq b group by  refrowno) "
	        			+ "  b on(b.refrowno=d.rowno) left join  my_bprfq bv on b.doc_no=bv.doc_no and d.rowno=bv.refrowno  where d.rdocno='"+docno+"' and d.clstatus=0 ");
			
          
            	 System.out.println("----pySql-------"+pySql);	
            		ResultSet resultSet = stmtVeh.executeQuery(pySql);
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
	
	

	public   JSONArray Details(String rdocno,String refrowno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
			
            		String sql=" select m.date detdate,m.remarks remk,m.fdate,u.user_name user from my_bprfq m "
            				+ " inner join my_user u on u.doc_no=m.userid where m.rdocno='"+rdocno+"' and m.refrowno='"+refrowno+"' and m.fdate is not null  group by m.doc_no ";
///System.out.println("=======sql=="+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				conn.close();
            
            	
          

		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
 
}
