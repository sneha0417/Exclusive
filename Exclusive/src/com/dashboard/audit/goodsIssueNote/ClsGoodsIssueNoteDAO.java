package com.dashboard.audit.goodsIssueNote;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsGoodsIssueNoteDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public   JSONArray goodsIssueGrid(String branch,String fromdate,String todate) throws SQLException {

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
    		sqltest+=" and m.brhid='"+branch+"'";
 		}
    	
    
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
		
				
				String sql=" select u.costgroup,t.type,m.description desc1,m.refno,m.doc_no,m.voc_no,m.date,m.issuetype,m.locid,l.loc_name,"
	        			+ "m.costtype,m.siteid,s.site,a.refname,m.cldocno, "
	        			+ " case when m.costtype=1 then m.costdocno when m.costtype in(3,4) then co.doc_no "
	        			+ " when m.costtype in(5) then cs.doc_no  end as 'costdocno' , "
	        			+ " case when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100)) "
	        			+ "  when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'prjname' "
	        			+ " from my_gism m left join my_locm l on l.doc_no=m.locid left join my_issuetype t on t.doc_no=m.issuetype"
	        			+ " left join my_costunit u on u.costtype=m.costtype  "
	        			+ " left join my_ccentre c on c.costcode=m.costdocno and m.costtype=1 "
	        			+ " left join cm_srvcontrm co on co.tr_no=m.costdocno and m.costtype in(3,4) "
	        			+ " left join cm_cuscallm cs on cs.tr_no=m.costdocno and m.costtype=5 "
	        			+ " left join cm_srvcsited s on s.rowno=m.siteid and m.costtype in(3,4,5) "
	        			+ " left join my_acbook a on a.cldocno=m.cldocno and m.costtype in(3,4,5) and a.dtype='CRM' "
	        			+ " where  m.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"' and m.audit=0  "+sqltest ;				
				
				
          
            	System.out.println("------goodsIssueGrid-----"+sql);	
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
	
	public   JSONArray goodsIssueDetailGrid(String docno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
		
				String sql=" select bd.brandname,0 as stkid,d.specno as specid,d.rdocno,m.doc_no psrno,"
						+ "  d.qty as qty ,m.part_no,m.part_no productid, "
						+ " m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice,d.total total, "
						+ " d.disper discper,d.discount dis,d.nettotal netotal from my_gism ma left join my_gisd d on(ma.doc_no=d.rdocno) "
						+ "  left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no) left join "
						+ "  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno ) "
						+ "   where rdocno="+docno+" ";
            	System.out.println("------goodsIssueDetailGrid-----"+sql);	
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
