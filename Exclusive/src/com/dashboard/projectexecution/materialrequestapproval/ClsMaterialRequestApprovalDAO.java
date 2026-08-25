package com.dashboard.projectexecution.materialrequestapproval;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsMaterialRequestApprovalDAO {

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();


public   JSONArray listsearch(HttpSession session,String branch,String aa, String cldocno,String docnoss) throws SQLException {

	
	JSONArray RESULTDATA=new JSONArray();
	
      
    
    Connection conn = null;
	try {
		conn = ClsConnection.getMyConnection();
		if(aa.equalsIgnoreCase("yes"))
		{	
		
			Statement stmtmain = conn.createStatement ();
			
			
			
			String sqltest="";
			
			if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
				sqltest=sqltest+" and m.brhid='"+branch+"'";
				}
			
			if(!(cldocno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and m.cldocno = '"+cldocno+"'";
			}
		 
			String sqltest1="";
			if(!(docnoss.equalsIgnoreCase(""))){
				sqltest1= " and a.costdocno = '"+docnoss+"'";
			}
           String pySql = " select a.* from (  select m.brhid, u.costgroup,t.type,m.description desc1,m.refno,m.doc_no,m.voc_no,m.date,m.issuetype,m.locid,l.loc_name,"
        				+ " m.costtype,m.siteid,s.site,a.refname,m.cldocno, "
        				+ " case when m.costtype=1 then m.costdocno when m.costtype in(3,4) then co.doc_no "
        				+ " when m.costtype in(5) then cs.doc_no  end as 'costdocno' , "
        				+ " case when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100)) "
        				+ " when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'prjname' "
        				+ " from my_mreqm m left join my_locm l on l.doc_no=m.locid left join my_issuetype t on t.doc_no=m.issuetype"
        				+ " left join my_costunit u on u.costtype=m.costtype  "
        				+ " left join my_ccentre c on c.costcode=m.costdocno and m.costtype=1 "
        				+ " left join cm_srvcontrm co on co.tr_no=m.costdocno and m.costtype in(3,4) "
        				+ " left join cm_cuscallm cs on cs.tr_no=m.costdocno and m.costtype=5 "
        				+ " left join cm_srvcsited s on s.rowno=m.siteid and m.costtype in(3,4,5) "
        				+ " left join my_acbook a on a.cldocno=m.cldocno and m.costtype in(3,4,5) and a.dtype='CRM'  "
        				+ " left join my_mreqd d on d.rdocno=m.doc_no  left join (select sum(qty) eqty ,psrno,tr_no,costdocno from  gl_estconfirm es group by costdocno,psrno) e "
        				+ " on (m.costdocno=e.costdocno and d.psrno=e.psrno ) "
        				+ " where m.status=3  and d.qty>d.out_qty  and d.approval=0  and  (e.costdocno is null or coalesce(e.eqty,0)<d.qty)  "+sqltest+"  group by m.doc_no ) a  where 1=1 "+sqltest1+""    ;
        	
        	 //System.out.println("=======pySql======="+pySql);
        	
     
			ResultSet resultSet = stmtmain.executeQuery(pySql);

			RESULTDATA=ClsCommon.convertToJSON(resultSet); 
			stmtmain.close();
			
		}
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

public   JSONArray sublistGridReload(String barchval,String doc_no,String locid) throws SQLException {

	
	JSONArray RESULTDATA=new JSONArray();
	
      
    
    Connection conn = null;
	try {
		conn = ClsConnection.getMyConnection();
	    Statement stmtmain = conn.createStatement ();
        	   String pySql = " select e.tr_no,e.eqty,ma.locid,ma.brhid,bd.brandname,d.psrno, d.qty, d.rowno, "
        					+ " m.part_no productid,m.productname,u.unit  from my_mreqm ma left join my_mreqd d on(ma.doc_no=d.rdocno) "
        					+ " left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no) "
        					+ " left join  my_brand bd on m.brandid=bd.doc_no "
        					+ " left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno ) "
        					+ " left join (select sum(qty) eqty ,psrno,tr_no,costdocno from  gl_estconfirm es group by costdocno,psrno) e "
        					+ " on (ma.costdocno=e.costdocno and d.psrno=e.psrno) " // qty-issue>0
        					+ " where m.status=3 and d.rdocno='"+doc_no+"' and d.qty>d.out_qty and (e.costdocno is null or coalesce(e.eqty,0)<d.qty)  and d.approval=0 " ;
    
        	 // System.out.println("=======pySql======="+pySql);
     
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
