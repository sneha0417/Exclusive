package com.dashboard.procurment.salesReports;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
 


import net.sf.json.JSONArray;
 


import com.common.ClsCommon;
import com.connection.ClsConnection;
public class ClssalesReportsDAO {

	
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
		 
				
				
				String sql=" select convert(if(mm.rdtype='DIR','Direct','Purchase Request'),char(30)) dtype,mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc,if(d.clstatus=1,'Canceled','') status,d.clstatus, "
						+ "  h.account,h.description acname, "
						+ "  m.part_no productid,m.productname,u.unit, d.unitid unitdocno, "
						+ "  d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal  "
						+ "  from my_ordm mm left join my_ordd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno "
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
     		
     		sqltest+=" and mm.status=3 and dd.out_qty=0 ";
     		 
  		
      	}
  	
    
     	else if(status.equalsIgnoreCase("PIV"))
  	    {
  		
      		sqltest+=" and mm.status=3 and dd.pstatus=1  "; 
  	    }
     	 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
			
 
				String sql="select mm.voc_no,mm.date,convert(if(mm.rdtype='DIR','Direct','Purchase Order'),char(30)) dtype, "
						+ "	mm.refno,h.account,h.description acname,m.part_no productid,m.productname,m.part_no proid ,  "
						+ " sum(dd.op_qty-dd.foc) qty,convert(if(sum(dd.out_qty+dd.rsv_qty+dd.del_qty-dd.foc)=0,'',sum(dd.out_qty+dd.rsv_qty+dd.del_qty-dd.foc)),char(30)) Out_qty,  "
						+ "convert(if((sum(dd.op_qty-dd.foc)-sum(dd.out_qty+dd.rsv_qty+dd.del_qty-dd.foc))=0,'',sum(dd.op_qty-dd.foc)-sum(dd.out_qty+dd.rsv_qty+dd.del_qty-dd.foc)),char(50)) balqty, "
						+ "	convert(if(sum(dd.foc)=0,'',sum(dd.foc)),char(30)) foc ,convert(if(sum(dd.foc_out)=0,'',sum(dd.foc_out)),char(30)) foc_out,convert(if(sum(dd.foc)-sum(dd.foc_out)=0,'',sum(dd.foc)-sum(dd.foc_out)),char(30)) focbal, "
						+ " d.prdId prodoc, u.unit, d.unitid unitdocno "
						+ " from  my_grnm  mm left join my_grnd d  on mm.tr_no=d.tr_no	left join my_head h on h.doc_no=mm.acno  "
						+ " left join my_prddin dd on dd.stockid=d.stockid and dd.prdid=d.prdid and d.psrno=dd.psrno and  d.specno=dd.specno  "
						+ " left join my_main m on m.doc_no=d.prdId	 left join my_unitm u on d.unitid=u.doc_no where  "
						+ " mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"' " +sqltest+ " group by dd.stockid" ;
            	 
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
    	
  /*  	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and dd.out_qty=0 ";
     		 
  		
      	}
  	
    
     	else if(status.equalsIgnoreCase("PIV"))
  	    {
  		
      		sqltest+=" and mm.status=3 and dd.pstatus=1  "; 
  	    }
     	*/ 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
			
  
				
				
				String sql="select mm.voc_no,mm.date,convert(if(mm.rdtype='DIR','Direct','Goods Receipt Note'),char(30)) dtype, "
						+ " mm.refno,h.account,h.description acname,m.part_no productid,m.productname,m.part_no proid ,  "
						+ " sum(d.qty) qty,convert(if(sum(d.foc)=0,'',sum(d.foc)),char(30)) foc , "
						+ " d.prdId prodoc, u.unit, d.unitid unitdocno "
			            + " from  my_grrm  mm left join my_grrd d  on mm.tr_no=d.tr_no " 
			            + " left join my_head h on h.doc_no=mm.acno    left join my_prddin dd "
			            + " on dd.stockid=d.stockid and dd.prdid=d.prdid and d.psrno=dd.psrno and  d.specno=dd.specno "
			            + " left join my_main m on m.doc_no=d.prdId	 left join my_unitm u on "
			            + " d.unitid=u.doc_no where mm.status=3 and   mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'" +sqltest+ "  group by dd.stockid ";
				
				
				
				
				
            	//System.out.println("-----sql--"+sql); 
				
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
		
				
				
				String sql=" select convert(if(mm.rdtype='DIR','Direct','Goods Receipt Note'),char(30)) dtype,mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc, "
						+ "  h.account,h.description acname, "
						+ "  m.part_no productid,m.productname,u.unit, d.unitid unitdocno, "
						+ "  d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal  "
						+ "  from my_srvm mm left join my_srvd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno "
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
		
				
				
				String sql=" select  mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc, "
						+ "  h.account,h.description acname, "
						+ "  m.part_no productid,m.productname,u.unit, d.unitid unitdocno, "
						+ "  d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal  "
						+ "  from my_srrm mm left join my_srrd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno "
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
		
				
				
				String sql=" select  'Edit' btnsave, d.rowno,convert(if(mm.rdtype='DIR','Direct','Purchase Request'),char(30)) dtype,mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc, "
						+ "  h.account,h.description acname, "
						+ "  m.part_no productid,m.productname,u.unit, d.unitid unitdocno, "
						+ "  d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal  "
						+ "  from my_ordm mm left join my_ordd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)    where d.qty!=d.out_qty  and d.clstatus=0 and"
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
		
				
				
				String sql=" select   convert(if(mm.rdtype='DIR','Direct','Purchase Request'),char(30)) dtype,mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc, "
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
	
	
	
	
	
}
