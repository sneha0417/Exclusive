package com.dashboard.nipurchase.nisalesreport;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsnisalesReportsDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public   JSONArray nipurchaseReports(String fromdate,String todate,String client,String type,int id) throws SQLException {

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
     	
     	String sqltest="",sqljoin="";
     	if((sqlfromdate!=null)&&(sqltodate!=null)){
            sqltest=sqltest+" and m.date between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
        }
     	if(!(client.equalsIgnoreCase(null)) && !(client.equalsIgnoreCase("")) && !(client.equalsIgnoreCase("undefined")) && !(client.equalsIgnoreCase("NaN"))){
            sqltest=sqltest+" and ac.cldocno='"+client+"' ";
            sqljoin+="left join my_acbook ac on m.acno=ac.acno";
             }
           String sqlsal="";
           if(id==1){
	           if(type.equalsIgnoreCase("ctodr")){
	            sqlsal="select m.voc_no invno,m.date invdate,br.branchname,h.description customername,"
	            +" case when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100))"
	            +" when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'projectname',"
	            +" s.sal_name salesman,m.lpono,round(sum(d.amount),2) price,round(sum(d.amount),2) amount from my_corm m inner join my_cord d on m.doc_no=d.rdocno left join my_head h on h.doc_no=m.acno"
	            +" left join my_salm s on m.sal_id=s.doc_no left join my_ccentre c on c.costcode=m.costcode and m.costtype=1"
	            +" left join cm_srvcontrm co on co.tr_no=m.costcode and m.costtype in(3,4)"
	            +" left join cm_cuscallm cs on cs.tr_no=m.costcode and m.costtype=5 left join my_brch br on m.brhid=br.branch "
	            +sqljoin+" where m.status=3"+sqltest+" group by m.doc_no";
	           }else if(type.equalsIgnoreCase("dlnot")){
	            sqlsal="select m.voc_no invno,m.date invdate,br.branchname,h.description customername,"
	                  +" case when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100))"
	                  +" when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'projectname',"
	                  +" s.sal_name salesman,m.lpono,round(sum(d.amount),2) price,round(sum(d.amount),2) amount"
	                  +" from my_dlym m inner join my_dlyd d on m.doc_no=d.rdocno left join my_head h on h.doc_no=m.acno"
	                  +" left join my_salm s on m.sal_id=s.doc_no left join my_ccentre c on c.costcode=m.costcode and m.costtype=1"
	                  +" left join cm_srvcontrm co on co.tr_no=m.costcode and m.costtype in(3,4)"
	                  +" left join cm_cuscallm cs on cs.tr_no=m.costcode and m.costtype=5 left join my_brch br on m.brhid=br.branch "
	                  +sqljoin+" where m.status=3"+sqltest+" group by m.doc_no";
	            
	           }else if(type.equalsIgnoreCase("ctinv")){
	            sqlsal="select m.date invdate,m.voc_no invno,br.branchname,h.description customername,"
	              +" round(m.taxamount,2) vatamount,round(m.invvalue,2) amount,m.rdtype,m.rrefno,"
	              +" case when m.ftype=1 then 'CASH' when m.ftype=2 then 'SHOWROOM' when m.ftype=3 then 'CREDIT' end as ftype,"
	              +" case when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100))"
	              +" when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'projectname',"
	              +" s.sal_name salesman,m.lpono,round(m.totalamount,2) price,round(m.discount,2) discount,ar.area,m.remarks"
	              +" from my_cutinvm m inner join my_cutinvd d on m.doc_no=d.rdocno left join my_head h on h.doc_no=m.acno"
	              +" left join my_salm s on m.sal_id=s.doc_no left join my_ccentre c on c.costcode=m.costcode and m.costtype=1"
	              +" left join cm_srvcontrm co on co.tr_no=m.costcode and m.costtype in(3,4)"
	              +" left join cm_cuscallm cs on cs.tr_no=m.costcode and m.costtype=5 left join my_brch br on m.brhid=br.branch "
	              +" left join my_acbook ac on ac.acno=m.acno left join my_area ar on ac.area_id=ar.doc_no"
	              +sqljoin+" where m.status=3"+sqltest+" group by m.doc_no";
	           }
           }else if(id==2){
        	   if(type.equalsIgnoreCase("ctodr")){
   	            sqlsal="select m.voc_no invno,m.date invdate,br.branchname,h.description customername,"
   	            +" case when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100))"
   	            +" when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'projectname',"
   	            +"  n.productname,s.sal_name salesman,m.lpono,round(d.qty,2) qty,round((d.qty-d.out_qty),2) pending,round(d.totsize,2) sqm, "
   	            +" d.price,d.amount from my_corm m inner join my_cord d on m.doc_no=d.rdocno left join my_head h on h.doc_no=m.acno"
   	            +" left join my_salm s on m.sal_id=s.doc_no left join my_ccentre c on c.costcode=m.costcode and m.costtype=1"
   	            +" left join cm_srvcontrm co on co.tr_no=m.costcode and m.costtype in(3,4) left join my_main n on d.psrno=n.psrno"
   	            +" left join cm_cuscallm cs on cs.tr_no=m.costcode and m.costtype=5 left join my_brch br on m.brhid=br.branch "
   	            +sqljoin+" where m.status=3"+sqltest+" ";
   	           }else if(type.equalsIgnoreCase("dlnot")){
   	            sqlsal="select m.voc_no invno,m.date invdate,br.branchname,h.description customername,"
   	                  +" case when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100))"
   	                  +" when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'projectname',n.productname,"
   	                  +" s.sal_name salesman, m.lpono,round(d.qty,2) qty,round((d.qty-d.out_qty),2) pending,round(d.totsize,2) sqm,d.price,d.amount"
   	                  +" from my_dlym m inner join my_dlyd d on m.doc_no=d.rdocno left join my_head h on h.doc_no=m.acno"
   	                  +" left join my_salm s on m.sal_id=s.doc_no left join my_ccentre c on c.costcode=m.costcode and m.costtype=1"
   	                  +" left join cm_srvcontrm co on co.tr_no=m.costcode and m.costtype in(3,4) left join my_main n on d.psrno=n.psrno"
   	                  +" left join cm_cuscallm cs on cs.tr_no=m.costcode and m.costtype=5 left join my_brch br on m.brhid=br.branch "
   	                  +sqljoin+" where m.status=3"+sqltest+" ";
   	            
   	           }else if(type.equalsIgnoreCase("ctinv")){
   	            sqlsal="select m.voc_no invno,m.date invdate,br.branchname,h.description customername,"
   	              +" case when m.ftype=1 then 'CASH' when m.ftype=2 then 'SHOWROOM' when m.ftype=3 then 'CREDIT' end as ftype,"
   	              +" case when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100))"
   	              +" when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'projectname',n.productname,"
   	              +" s.sal_name salesman,m.rdtype,m.rrefno, m.lpono,round(d.qty,2) qty,round((d.qty-d.out_qty),2) pending,round(d.totsize,2) sqm,d.price,d.amount, "
   	              +" ar.area,m.remarks from my_cutinvm m inner join my_cutinvd d on m.doc_no=d.rdocno left join my_head h on h.doc_no=m.acno"
   	              +" left join my_salm s on m.sal_id=s.doc_no left join my_ccentre c on c.costcode=m.costcode and m.costtype=1"
   	              +" left join cm_srvcontrm co on co.tr_no=m.costcode and m.costtype in(3,4) left join my_main n on d.psrno=n.psrno"
   	              +" left join cm_cuscallm cs on cs.tr_no=m.costcode and m.costtype=5 left join my_brch br on m.brhid=br.branch "
   	              +" left join my_acbook ac on ac.acno=m.acno left join my_area ar on ac.area_id=ar.doc_no"
   	              +sqljoin+" where m.status=3"+sqltest+" ";
   	           }
           }
     	System.out.println(client+"++sqlsal+++"+sqlsal);
     	Connection conn =null;
		
		try {
			conn=ClsConnection.getMyConnection();

			Statement stmt = conn.createStatement ();
		ResultSet resultSet = stmt.executeQuery(sqlsal);
		
		RESULTDATA=ClsCommon.convertToJSON(resultSet);
		
		stmt.close();
		conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
     	return RESULTDATA;
	}
	
	public JSONArray clientData(String clientname,String id) throws SQLException{
		
		JSONArray RESULTDATA=new JSONArray();

		if(!(id.equalsIgnoreCase("1"))) {
        	return RESULTDATA;
        }
		
		Connection conn =null;
        
		try {
			conn=ClsConnection.getMyConnection();

			Statement stmt = conn.createStatement ();
        	
			String sqltest="";
			if(!clientname.equalsIgnoreCase("")){
				sqltest+=" and refname like '%"+clientname+"%'";
			}
			String sqlqry= "select refname clientname,cldocno from my_acbook where dtype='CRM' and status='3'"+sqltest;
			System.out.println("sqlqry ="+sqlqry);
			ResultSet resultSet = stmt.executeQuery(sqlqry);
			
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			
			stmt.close();
			conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
		finally{
			conn.close();
		}
	
	return RESULTDATA;
	}
	
}
