package com.sales.Sales.branchInvoicereturn;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.sales.Sales.salesInvoice.ClsSalesInvoiceBean;

public class ClsbranchInvoicereturnDAO {
	ClsbranchInvoicereturnBean bean= new ClsbranchInvoicereturnBean();
	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();
	public   JSONArray searchProduct(HttpSession session,String prodsearchtype,String rdoc,String reftype,String locaid) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 
			String sql="";
			int method=0;
			/*String sqlcond1="";
			String sqlcond2="";
			String sqlselect="";*/



			/*	sql="select  stkid,specid,psrno as doc_no,rdocno,psrno,qty as totqty,(qty-outqty) qty,outqty,(qty-outqty) as balqty,0 size,part_no,productid,productname,unit,unitdocno, unitprice from "
						+ "( select i.stockid as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,d.qty as qty,d.out_qty as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,i.cost_price as unitprice from "
						+ "my_invm ma left join my_invd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "
						+ "inner join my_prddin i on(i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno and ma.brhid=i.brhid) where ma.status=3 and d.rdocno in("+rdoc+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by d.stockid having sum((d.qty)-(d.out_qty))>0 order by d.prdid,i.date ) as a ";*/
				sql=" select bd.brandname,d.stockid stkid,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty-out_qty) totqty,"
					+ " sum(out_qty) as oldqty,sum(qty-out_qty) qty,sum(out_qty) outqty,sum(qty-out_qty) as balqty,part_no,m.part_no "
				    + "	productid,m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, "
				    + "	 KGPrice kgprice,d.amount unitprice,((d.qty-d.out_qty)*d.amount) total,d.disper discper, "
					+ " (sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis, "
					+ " ((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) netotal "
					+ "  from my_invm ma left join my_invd d on(ma.doc_no=d.rdocno)  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) "
					+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
					+ "  where m.status=3 and d.rdocno in("+rdoc+") and   ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' and ma.locid='"+locaid+"' group by d.stockid "
					+ "  having sum(d.qty-d.out_qty)>0  order by d.prdid,d.stockid ";


			System.out.println("----searchProduct-sql---"+sql);

			ResultSet resultSet = stmt.executeQuery (sql);
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


	public   JSONArray searchLocation(HttpSession session) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 

			String brcid = session.getAttribute("BRANCHID").toString(); 

			String sql="select m.doc_no,loc_name as location,branchname as branch from my_locm m left join my_brch b on(b.doc_no=m.brhid) where m.status=3 and brhid="+brcid+"";
			System.out.println("-----searchLocation---"+sql);

			ResultSet resultSet = stmt.executeQuery (sql);
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


	public   JSONArray searchAccount(HttpSession session) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 

			String brcid = session.getAttribute("BRANCHID").toString(); 

			String sql="select acno,h.description as account from my_salexpaccount a left join my_head h on(a.acno=h.doc_no)";
			System.out.println("-----searchLocation---"+sql);

			ResultSet resultSet = stmt.executeQuery (sql);
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


	public   JSONArray searchSalesPerson(HttpSession session) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 


			String sql="select doc_no,sal_name from my_salm where status=3";
			// System.out.println("-----fleetsql---"+fleetsql);

			ResultSet resultSet = stmt.executeQuery (sql);
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


	public   JSONArray termsSearch(HttpSession session,String dtype) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 


			String sql="select voc_no,dtype,termsheader as header from my_termsm where dtype='"+dtype+"'";
			// System.out.println("-----fleetsql---"+fleetsql);

			ResultSet resultSet = stmt.executeQuery (sql);
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







	public  JSONArray reqSearchMasters(HttpSession session,String docnoss,String refnosss,String datess,String clientid,String reftype,String transid,String locid) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}
		String brcid = session.getAttribute("BRANCHID").toString(); 

		String sqltest="";


		java.sql.Date  sqlStartDate = null;
		if(!(datess.equalsIgnoreCase("undefined"))&&!(datess.equalsIgnoreCase(""))&&!(datess.equalsIgnoreCase("0")))
		{
			sqlStartDate = ClsCommon.changeStringtoSqlDate(datess);
		}


		if((!(docnoss.equalsIgnoreCase(""))) && (!(docnoss.equalsIgnoreCase("NA")))){
			sqltest=sqltest+" and m.voc_no like '%"+docnoss+"%'";
		}
		if((!(refnosss.equalsIgnoreCase(""))) && (!(refnosss.equalsIgnoreCase("NA")))){
			sqltest=sqltest+" and m.refno like '%"+refnosss+"%'  ";
		}

		/*if((!(clientid.equalsIgnoreCase(""))) && (!(clientname.equalsIgnoreCase("NA")))){
      		sqltest=sqltest+" and ac.refname like '%"+clientname+"%'  ";
      	}*/


		if(!(sqlStartDate==null)){
			sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
		}

		Connection conn = null;
		try {

			System.out.println("reftype===="+reftype);

			conn = ClsConnection.getMyConnection();
			Statement stmtmain = conn.createStatement ();
			String pySql="";
			/*if(reftype.equalsIgnoreCase("INV")){

				pySql=("select * from (select sum(qty-d.out_qty) as qty,m.doc_no,m.rrefno as refno,m.voc_no,m.date,ac.refname as client,0 as chk from my_invm m left join   my_acbook ac on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_invd d on(d.rdocno=m.doc_no)  where m.status=3 and m.cldocno="+clientid+"  and m.brhid='"+brcid+"' "+sqltest+" group by m.doc_no) as a having qty>0" );
			}*/

			pySql=("select * from (select sum(qty-d.out_qty) as qty,m.doc_no,m.rrefno as refno,m.voc_no,m.date,ac.refname as client, "
					+ " 0 as chk from my_invm m left join   my_acbook ac on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_invd d on(d.rdocno=m.doc_no)   "
					+ "where m.status=3 and m.cldocno="+clientid+"  and m.brhid='"+brcid+"' and m.locid='"+locid+"' and m.paymode="+transid+" and m.ftype=1 "+sqltest+" group by m.doc_no) as a having qty>0" );

			System.out.println("====pySql===="+pySql);
			ResultSet resultSet = stmtmain.executeQuery(pySql);

			RESULTDATA=ClsCommon.convertToJSON(resultSet); 

			stmtmain.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//	System.out.println(RESULTDATA);
		return RESULTDATA;
	}



	public  JSONArray searchMaster(HttpSession session,String msdocno,String clnames,String enqno,String enqdate,String enqtype,String transid,String Cl_mobnos,String Cl_salper) throws SQLException {


		System.out.println("==searchMaster===");

		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}

		//  System.out.println("8888888888"+clnames); 	
		String brhid=session.getAttribute("BRANCHID").toString();



		java.sql.Date sqlStartDate=null;


		if(!(enqdate.equalsIgnoreCase("undefined"))&&!(enqdate.equalsIgnoreCase(""))&&!(enqdate.equalsIgnoreCase("0")))
		{
			sqlStartDate = ClsCommon.changeStringtoSqlDate(enqdate);
		}

		String sqltest="";
		if(!(msdocno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.voc_no like '%"+msdocno+"%'";
		}
		if(!(Cl_mobnos.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.per_mob like '%"+Cl_mobnos+"%'";
		}
		
		if(!(Cl_salper.equalsIgnoreCase(""))){
			sqltest=sqltest+" and sa.sal_name like '%"+Cl_salper+"%'";
		}
		if(!(clnames.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.refname like '%"+clnames+"%'";
		}

		if(!(enqtype.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.ref_type like '%"+enqtype+"%'";
		}

		if(!(enqno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.rrefno like '%"+enqno+"%'";
		}

		if(!(sqlStartDate==null)){
			sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
		} 



		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();

			String clssql= ("select sa.doc_no saldocno,sa.sal_name,ac.per_mob,m.doc_no,m.voc_no,m.date,m.dtype,m.brhid,ac.refname as name,ac.address as cladd,m.cldocno,"
					+ "m.ref_type,rrefno from my_invr m  left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') left join my_salm sa on (sa.doc_no=ac.sal_id and ac.dtype='CRM' ) "
					+ "where m.brhid="+brhid+" and  m.status and m.paymode="+transid+" and m.ftype=1 "+sqltest+"");
			System.out.println("====searchmaster===="+clssql);
			ResultSet resultSet = stmtenq1.executeQuery(clssql);

			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtenq1.close();
			conn.close();
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}



	public JSONArray searchClient(HttpSession session,String clname,String mob) throws SQLException {

		//		System.out.println("==searchClient====");

		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}


		String brid=session.getAttribute("BRANCHID").toString();






		//System.out.println("name"+clname);

		String sqltest="";

		if(!(clname.equalsIgnoreCase(""))){
			sqltest=sqltest+" and refname like '%"+clname+"%'";
		}
		if(!(mob.equalsIgnoreCase(""))){
			sqltest=sqltest+" and per_mob like '%"+mob+"%'";
		}


		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt1 = conn.createStatement ();

			String clsql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM'  " +sqltest);
			//System.out.println("========"+clsql);
			ResultSet resultSet = stmt1.executeQuery(clsql);

			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt1.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public JSONArray prdGridLoad(HttpSession session,String docno) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select  specid,psrno as doc_no,rdocno,psrno,(qty-outqty) qty,outqty,(qty-outqty) as balqty,size,part_no,productid,productname,unit,unitdocno,stkid from "
					+ "( select at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(out_qty) as outqty,0 size,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.stockid as stkid from "
					+ "my_qotd d  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) where m.status=3 and d.rdocno in("+docno+") group by psrno having sum(d.qty-d.out_qty)>0) as a ";
			System.out.println("===prdbranchLoad====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray prdGridReload(HttpSession session,String docno,String enqdoc,String reftype,String locaid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {

			if(((docno.equalsIgnoreCase(""))||(docno.equalsIgnoreCase("undefined")))){

				docno="0";
			}

			if(((enqdoc.equalsIgnoreCase(""))||(enqdoc.equalsIgnoreCase("undefined")))){

				enqdoc="0";
			}

			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();


			String sql="";
			int method=0;
 
/*
			sql="select stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,totqty, qty,qty as oldqty,outqty,"
					+ "case when (totqty-outqty)=0 then 0 else (qty+balqty) end as balqty,0 size,part_no,productid as proid,productid,"
					+ "productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,  dis, netotal from"
					+ "(select  stkid,specid,psrno as doc_no,rdocno,psrno,qtys as totqty, qty,qtys,outqty,(qtys-outqty) as balqty,0 size,part_no,"
					+ "productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper,  dis, netotal from ( select i.stockid as stkid,"
					+ "d.specno as specid,d.rdocno,m.doc_no psrno,d.qty as qty,sum(i.op_qty) as qtys,sum(i.out_qty+i.del_qty+i.rsv_qty) as outqty,"
					+ "m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice,"
					+ "d.total,d.disper discper, d.discount dis,d.nettotal netotal from my_invr ma left join my_inrd d on(ma.doc_no=d.rdocno)"
					+ "left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no)"
					+ "left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno ) left join my_prddin i "
					+ "on (i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno and ma.brhid=i.brhid) where m.status=3 and d.rdocno in("+docno+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by i.prdid"
					+ "  order by i.date ) as a ) as b ; ";
			*/
			
/*			
			sql=" select stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,totqty, qty,qty as oldqty,outqty, "
					 + " inblqty as balqty,0 size,part_no,productid as proid,productid, "
			 + " productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,  dis, netotal "
			 + " from(select  inblqty+qty inblqty,stkid,specid,psrno as doc_no,rdocno,psrno,qtys as totqty, qty,qtys,outqty, "
			 + " 0 size,part_no,productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper, "
			 + " dis, netotal from ( select dd.inblqty, i.stockid as stkid,d.specno as specid,d.rdocno,m.doc_no psrno,sum(d.qty) as qty, "
			 + " sum(i.op_qty) as qtys,outqty as outqty,m.part_no,m.part_no productid,m.productname, "
			 + " u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice,d.total,d.disper discper, "
			 + " d.discount dis,d.nettotal netotal from my_invr ma left join my_inrd d on(ma.doc_no=d.rdocno) "
			 + " left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no) "
			 + " left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno ) "
		 + " 	left join my_prddin i on (i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno and ma.brhid=i.brhid and d.stockid=i.stockid) "
			 + "  left join(select sum(s.qty)-sum(s.out_qty) inblqty, sum(s.out_qty) outqty, "
			 + "  s.prdid,s.psrno,s.specno,dm.brhid "
			 + "   from my_invm dm left join  my_invd s on s.rdocno=dm.doc_no where s.rdocno in("+enqdoc+") group by s.psrno) dd on "
			 + " (dd.psrno=d.psrno and dd.prdid=d.prdid and  dd.specno=d.specno and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"') "
		 + " 	where m.status=3 and  d.rdocno in("+docno+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"'  "
		 		+ " group by i.prdid  order by i.date ) as a ) as b "; 
			*/
			
			
			sql=" select brandname,refstockid refstkid,stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,totqty, qty,qty as oldqty,outqty, "
					 + " inblqty+qty as balqty ,0 size,part_no,productid as proid,productid,  productname as proname,productname,  "
			 + " unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,  dis, netotal  from(select brandname,refstockid, inblqty  "
			 + " inblqty,stkid,specid,psrno as doc_no,rdocno,psrno,qtys as totqty, qty,qtys,outqty,  0 size,  "
			 + " part_no,productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper,  "
			  + " dis, netotal from ( select bd.brandname,dd.inblqty,i.refstockid, i.stockid as stkid,d.specno as specid,d.rdocno,m.doc_no  "
			 + "  psrno,sum(d.qty) as qty,  sum(i.op_qty) as qtys,dd.out_qty as outqty,m.part_no,m.part_no productid,m.productname,  "
			   + "  u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice,d.total,d.disper discper,  "
			   + "    d.discount dis,d.nettotal netotal from my_invr ma left join my_inrd d on(ma.doc_no=d.rdocno)  "
			    + "   left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no)  "
			    + "    left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno )  left join  my_brand bd on m.brandid=bd.doc_no 	left join my_prddin i  "
			       + "  on (i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno and ma.brhid=i.brhid and d.stockid=i.stockid and ma.locid=i.locid)  "
			       + "    left join(select sum(s.qty-s.out_qty) inblqty,sum(s.out_qty) out_qty,s.stockid,s.psrno,s.prdid,s.specno from my_invd s  where s.rdocno in("+enqdoc+") group by s.stockid)  "
			           + "    dd on  (dd.psrno=d.psrno and dd.prdid=d.prdid and  dd.specno=d.specno  and d.refstockid=dd.stockid)  "
		         + "     	where m.status=3 and  d.rdocno in("+docno+") and  ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' "
		         		+ " and ma.locid="+locaid+"  group by i.stockid  order by i.date,i.prdid,i.refstockid ) as a ) as b  ";
			
			
			
			
			
			
			
			
/*			
			sql="select refstkid,stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,totqty, qty,qty as oldqty,outqty,"
					+ "balqty+qty balqty,0 size,part_no,productid as proid,productid,"
					+ "productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,  dis, netotal "
					+ "from(select refstkid, stkid,specid,psrno as doc_no,rdocno,psrno,qtys as totqty, qty,qtys,outqty,delbalqty as balqty,0 size,part_no,"
					+ "productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper,  dis, netotal from (select cc.delbalqty,i.refstockid refstkid,i.stockid as stkid,"
					+ "d.specno as specid,d.rdocno,m.doc_no psrno,sum(d.qty) as qty,sum(i.op_qty) as qtys,sum(i.out_qty+i.del_qty+i.rsv_qty) as outqty,m.part_no,"
					+ "m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice,d.total,"
					+ "d.disper discper, d.discount dis,d.nettotal netotal from my_delrm ma left join my_delrd d on(ma.doc_no=d.rdocno)left join "
					+ "my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at "
					+ "on(at.mpsrno=m.doc_no and d.specno=at.mpsrno ) left join my_prddin i "
					+ "on (i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno and ma.brhid=i.brhid and d.stockid=i.stockid  and i.locid='"+locaid+"')  "
					+ "left join (select sum(qty-out_qty)  delbalqty, psrno,stockid, "
					+ "rdocno,specno,prdid from my_deld where rdocno in("+enqdoc+")   group by  stockid) cc on cc.psrno=d.psrno and cc.prdid=d.prdid and  cc.specno=d.specno and d.refstockid=cc.stockid where m.status=3 and "
					+ "d.rdocno in("+docno+") and i.brhid='"+session.getAttribute("BRANCHID").toString()+"' and i.locid='"+locaid+"' group by d.stockid  order by i.date,i.prdid,i.refstockid) as a ) as b ";
*/
			/*having sum((op_qty)-(i.out_qty+i.rsv_qty+i.del_qty))>0*/
			System.out.println("===prdGridReload=stockcheck=s=sss="+sql);


			
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}


	public JSONArray prdGridReload(HttpSession session,String docno,String reftype,String locaid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {

			if(((docno.equalsIgnoreCase(""))||(docno.equalsIgnoreCase("undefined")))){

				docno="0";
			}
			String sql="";
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();





			if(reftype.equalsIgnoreCase("INV")){

	/*			sql="select d.stockid stkid,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty) totqty,sum(out_qty) as oldqty,sum(qty-out_qty) qty,sum(out_qty) outqty,sum(qty-out_qty) as balqty,"
						+ "part_no,m.part_no productid,m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, KGPrice kgprice,"
						+ "amount unitprice,((qty-out_qty)*amount) total,disper discper,discount dis,((qty-out_qty)*amount) netotal from my_invd d  left join my_main m on(d.psrno=m.doc_no) "
						+ "left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) where m.status=3 and d.rdocno in("+docno+") group by psrno "
						+ "having sum(d.qty-d.out_qty)>0";
				*/
				
				
				sql=" select bd.brandname,d.stockid stkid,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty-out_qty) totqty,"
						+ " sum(out_qty) as oldqty,sum(qty-out_qty) qty,sum(out_qty) outqty,sum(qty-out_qty) as balqty,part_no,m.part_no "
					    + "	productid,m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, "
					    + "	 KGPrice kgprice,d.amount unitprice,((d.qty-d.out_qty)*d.amount) total,d.disper discper, "
						+ " (sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis, "
						+ " ((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) netotal "
						+ "  from my_invm ma left join my_invd d on(ma.doc_no=d.rdocno)  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no) where m.status=3 and d.rdocno in("+docno+") and   ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' and ma.locid='"+locaid+"' group by d.stockid "
						+ "  having sum(d.qty-d.out_qty)>0  order by d.prdid,d.stockid ";
				
				
/*				sql=" select d.stockid stkid,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty-out_qty) totqty, "
						+ "sum(out_qty) as oldqty,sum(qty-out_qty) qty,sum(out_qty) outqty,sum(qty-out_qty) as balqty,part_no,m.part_no "
				+ "productid,m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, "
				+ " KGPrice kgprice,amount unitprice,((qty-out_qty)*amount) total,disper discper,discount dis,((qty-out_qty)*amount) netotal "
				+ "  from my_invd d  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no)
				 + " left join my_prodattrib at on(at.mpsrno=m.doc_no) where m.status=3 and d.rdocno in("+docno+") group by d.stockid
				+ "  having sum(d.qty-d.out_qty)>0  order by d.prdid;
*/				
				
				System.out.println("===prdGridReload===2=="+sql);
				ResultSet resultSet = stmt.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
			}


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}




	public JSONArray termsGridLoad(HttpSession session,String dtype) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select m.voc_no,m.dtype,termsheader terms,termsfooter conditions from MY_termsm m  inner join my_termsd d on(m.voc_no=d.rdocno) where d.status=3 and d.dtype='"+dtype+"' order by terms";
			System.out.println("===termsGridLoad====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray termsGridReLoad(HttpSession session,String dtype,String qotdoc) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select m.voc_no,m.dtype,termsheader terms,conditions conditions from my_trterms tr left join my_termsm m on(tr.termsid=m.voc_no) where  tr.dtype='"+dtype+"' and tr.rdocno="+qotdoc+" order by terms";
			System.out.println("===termsGridLoad====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}



	public   JSONArray qotgridreload(String doc,String reftype) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 
			String sql="";
			int method=0;
			String sqlcond1="";
			String sqlcond2="";
			String sqlselect="";

			if(((doc.equalsIgnoreCase(""))||(doc.equalsIgnoreCase("undefined")))){

				doc="0";
			}

			if(reftype.equalsIgnoreCase("DEL")){

				sql="select  stkid,specid,psrno as doc_no,rdocno,psrno,qty as totqty,(qty-outqty) qty,outqty,(qty-outqty) as balqty,0 size,part_no,productid,productname,unit,unitdocno from "
						+ "( select i.stockid as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(d.out_qty) as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno from "
						+ "my_delm ma left join my_deld d on(ma.doc_no=d.rdocno) inner join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) inner join my_prddin i "
						+ "on(i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno) where m.status=3 and d.rdocno in("+doc+")  group by i.stockid having sum((op_qty)-(i.out_qty+i.rsv_qty+i.del_qty))>0 order by i.date ) as a group by psrno";


			}



			System.out.println("=qotgridreload==="+sql);

			ResultSet resultSet = stmt.executeQuery(sql);

			RESULTDATA=ClsCommon.convertToJSON(resultSet); 
			stmt.close();


		}
		catch(Exception e){
			e.printStackTrace();

		}
		finally{
			conn.close();
		}
		//	System.out.println(RESULTDATA);
		return RESULTDATA;
	}	


	public int insert(java.sql.Date date,String refno,String pricegrp,String curr,String currate,int salesid,int clientid,String rrefno,String rreftype,String payterms,String desc,
			String prodamt,String descount,String nettotal,String servamt,String roundof,String finalamt,String mode,String formcode,ArrayList prodarray,
			HttpSession session,HttpServletRequest request,String qotmasterdocno,String descper,java.sql.Date payduedate,int locationid,String modepay,String deltems) throws SQLException{

		Connection conn=null;
		int srdocno=0;
		int tranid=0;
		conn=ClsConnection.getMyConnection();

		try{

			if(modepay.equalsIgnoreCase("cash")){
				tranid=1;
			}
			else if(modepay.equalsIgnoreCase("credit")){
				tranid=2;
			}
 
			
 
			
			conn.setAutoCommit(false);

		
			CallableStatement stmt = conn.prepareCall("{CALL saleInvReturnDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmt.registerOutParameter(20, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(21, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(22, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(23, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			stmt.setString(2,refno);
			stmt.setInt(3, clientid);
			stmt.setInt(4, Integer.parseInt(curr));
			stmt.setDouble(5, Double.parseDouble(currate));
			stmt.setInt(6, salesid);
			stmt.setString(7,rreftype);
			stmt.setString(8,qotmasterdocno);
			stmt.setString(9,payterms);
			stmt.setString(10,desc);
			stmt.setString(11,mode);
			stmt.setString(12,formcode);
			stmt.setString(13, session.getAttribute("USERID").toString());
			stmt.setString(14, session.getAttribute("BRANCHID").toString());
			stmt.setString(15, session.getAttribute("COMPANYID").toString());
			stmt.setString(16, finalamt);
			stmt.setDate(17,payduedate);
			stmt.setInt(18,locationid);
			stmt.setInt(19,tranid);
			int val = stmt.executeUpdate();
			srdocno=stmt.getInt("sodocno");
			int vocno=stmt.getInt("vdocNo");
			int trno=stmt.getInt("strno");
			int claccno=stmt.getInt("tmpacno");
			request.setAttribute("vdocNo", vocno);
			//System.out.println("===vocno====="+vocno);
			if(vocno>0){

				 Statement stmtss=conn.createStatement();
				 String sqlsu= " update my_invr set delterms='"+deltems+"',ftype=1   where doc_no='"+srdocno+"' ";
				 stmtss.executeUpdate(sqlsu);
				
				int prodet=0;
				int prodout=0;
				for(int i=0;i< prodarray.size();i++){

					String[] prod=((String) prodarray.get(i)).split("::");
					System.out.println("prod[0]===="+prod[0]);
					if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")||(prod[0].equalsIgnoreCase("null"))))){


						if(vocno>0)
						{

							String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
							String specno=""+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"";
							String stkid=""+(prod[12].equalsIgnoreCase("undefined") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"";						 
							String  rqty=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
							double masterqty=Double.parseDouble(rqty);

							//int stockid=Integer.parseInt(stkid);

							double masterqty1=0;

							double balstkqty=0;
							int psrno=0;
							int stockid=0;
							int refstockid=0;
							double remstkqty=0;
							double outstkqty=0;
							double stkqty=0;
							double qty=0;
							double detqty=0;
							double unitprice=0.0;
							double costprice=0.0;
							double tmp_qty=0.0;
							double outqtys=0.0;
							double prdinqty=0.0;
							
							
							double NtWtKG=0.0;
							double KGPrice=0.0;
							double total=0.0;
							double discper=0.0;
							double discount=0.0;
							double netotal=0.0;
							
							masterqty1=masterqty;
							unitprice=Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"");

							Statement stmtstk=conn.createStatement();


							String stkSql="select d.rdocno,d.doc_no,d.stockid,d.psrno,d.specno,d.qty delqty,sum(d.qty) stkqty,sum(d.qty-d.out_qty) balstkqty,(d.out_qty) out_qty,sum(i.del_qty) as qty,m.date,i.unit_price,i.cost_price from my_invm m "
									+ " left join  my_invd d on(d.rdocno=m.doc_no) left join my_prddin i on(d.stockid=i.stockid) "
									+ "where d.rdocno in("+qotmasterdocno+") and d.stockid="+stkid+"  and d.psrno='"+prdid+"' and d.specno='"+specno+"' and d.prdid='"+prdid+"' and m.brhid="+session.getAttribute("BRANCHID").toString()+" and m.locid='"+locationid+"'  "
									+ "group by d.stockid,d.prdid,d.psrno having sum(qty-d.out_qty)>0 order by m.date,i.stockid";
							
	/*						
							
							String stkSql="select stockid,psrno,specno,sum(op_qty) stkqty,sum(op_qty-(out_qty+del_qty+rsv_qty)) balstkqty,(out_qty+del_qty+rsv_qty) out_qty,out_qty as qty,out_qty qtys,date,unit_price,cost_price from my_prddin "
									+ "where psrno='"+prdid+"' and specno='"+specno+"'  and prdid='"+prdid+"' and brhid="+session.getAttribute("BRANCHID").toString()+" "
									+ "group by stockid,cost_price,prdid,psrno  order by date,stockid";
*/
							System.out.println("=stkSql=inside insert="+stkSql);

							ResultSet rsstk = stmtstk.executeQuery(stkSql);

							while(rsstk.next()) {


								balstkqty=rsstk.getDouble("balstkqty");
								psrno=rsstk.getInt("psrno");
								outstkqty=rsstk.getDouble("out_qty");
								stockid=rsstk.getInt("stockid");
								stkqty=rsstk.getDouble("stkqty");
								prdinqty=rsstk.getDouble("qty");
								unitprice=rsstk.getDouble("unit_price");
								costprice=rsstk.getDouble("cost_price");
							 
								
								
								System.out.println("---masterqty-----"+masterqty);	
								System.out.println("---balstkqty-----"+balstkqty);	
								System.out.println("---out_qty-----"+outstkqty);	
								System.out.println("---stkqty-----"+stkqty);
								System.out.println("---qty-----"+qty);

								String queryappnd="";

						

								NtWtKG=Double.parseDouble(""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"");
								KGPrice=Double.parseDouble(""+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"");
								unitprice=Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"");
								total=masterqty*unitprice;
								discper=Double.parseDouble(""+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"");
								discount=(total*discper)/100;
								netotal=total-discount;

					 
								
								String prodinsql="insert into my_prddin(sr_no,TR_NO, dtype,refstockid,unit_price,cost_price,specno, psrno,op_qty,prdid,brhid,locid,date) Values"
										+ " ("+(i+1)+",'"+trno+"','"+formcode+"',"
										+ "'"+stockid+"',"
										+ ""+unitprice+","
										+ ""+costprice+","
										+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
										+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
										+ "'"+masterqty+"',"
										+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
										+"'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"','"+locationid+"','"+date+"')";

								System.out.println("prodinsql--1->>>>Sql"+prodinsql);
								prodout = stmt.executeUpdate (prodinsql);
								Statement stmtstk1=conn.createStatement();
								String nstkSql="select stockid from  my_prddin where  refstockid="+stkid+" and tr_no="+trno+" and psrno='"+prdid+"' and specno='"+specno+"' and prdid='"+prdid+"' and brhid="+session.getAttribute("BRANCHID").toString()+"";

								System.out.println("=nstkSql="+nstkSql);

								ResultSet rsnstk = stmtstk1.executeQuery(nstkSql);

								if(rsnstk.next()) {
									refstockid=rsnstk.getInt("stockid");
								}

					

				  
									if(masterqty<=balstkqty)
									{
										break;
									}	
									
									


							}
				 


							if(rreftype.equalsIgnoreCase("INV"))
							{

								double balqty=0;
								int docno=0;
								int rdocno=0;
								double remqty=0;
								double out_qty=0;
								double qtys=0;
								int invstk=0;
								double secqty=0;
								Statement stmt1=conn.createStatement();

								String strSql="select d.stockid,d.qty qty,sum((d.qty-d.out_qty)) balqty,d.doc_no,d.rdocno,d.out_qty out_qty,d.prdid  from my_invm m  left join "
										+ "my_invd d on m.doc_no=d.rdocno where d.rdocno in ("+qotmasterdocno+") and d.stockid="+stkid+" and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and m.locid='"+locationid+"'  and d.prdid='"+prdid+"' group by d.doc_no having  sum(d.qty-d.out_qty)>0 "
										+ "order by m.date,d.doc_no";

								System.out.println("---strSql-----"+strSql);
								ResultSet rs = stmt1.executeQuery(strSql);


								while(rs.next()) {


									balqty=rs.getDouble("balqty");
									rdocno=rs.getInt("rdocno");
									out_qty=rs.getDouble("out_qty");

									docno=rs.getInt("doc_no");
									qtys=rs.getDouble("qty");
									invstk=rs.getInt("stockid");

									System.out.println("---masterqty-----"+masterqty);	
									System.out.println("---balqty-----"+balqty);	
									System.out.println("---out_qty-----"+out_qty);	
									System.out.println("---qtys-----"+qtys);


									if(remqty>0)
									{

										masterqty1=remqty;
									}


									if(masterqty1<=balqty)
									{
										
										String sql="insert into my_inrd(tr_No,sr_no,rdocno,stockid,refstockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal,ref_row)VALUES"
												+ " ("+trno+","+(i+1)+",'"+srdocno+"',"
												+ "'"+refstockid+"',"
												+ "'"+invstk+"',"
												+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
												+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
												+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
												+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
												+ "'"+masterqty1+"',"
												+ "'"+NtWtKG+"',"
												+ "'"+KGPrice+"',"
												+ "'"+unitprice+"',"
												+ "'"+total+"',"
												+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
												+ "'"+discount+"',"
												+ "'"+netotal+"','"+docno+"')";

										System.out.println("branchper--1->>>>Sql"+sql);
										prodet = stmt.executeUpdate (sql);
										
										
										masterqty1=masterqty1+out_qty;


										String sqls="update my_invd set out_qty="+masterqty1+" where stockid="+invstk+" and rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+"";

										System.out.println("--1---sqls---"+sqls);


										stmt.executeUpdate(sqls);
										break;


									}
									else if(masterqty1>balqty)
									{
										secqty=balqty;


										if(qtys>=(masterqty1+out_qty))

										{
											balqty=masterqty1+out_qty;	
											remqty=qtys-out_qty;

											//	System.out.println("---remqty-1---"+remqty);
										}
										else
										{
											remqty=masterqty1-balqty;
											balqty=qtys;

											//System.out.println("---remqty--2--"+remqty);
										}


										String sqls="update my_invd set out_qty="+balqty+" where stockid="+invstk+" and rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+"";	
										System.out.println("-2----sqls---"+sqls);

										stmt.executeUpdate(sqls);	
										String sql="insert into my_inrd(tr_No,sr_no,rdocno,stockid,refstockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal,ref_row)VALUES"
												+ " ("+trno+","+(i+1)+",'"+srdocno+"',"
												+ "'"+refstockid+"',"
												+ "'"+invstk+"',"
												+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
												+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
												+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
												+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
												+ "'"+secqty+"',"
												+ "'"+NtWtKG+"',"
												+ "'"+KGPrice+"',"
												+ "'"+unitprice+"',"
												+ "'"+total+"',"
												+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
												+ "'"+discount+"',"
												+ "'"+netotal+"','"+docno+"')";

										System.out.println("branchper--1->>>>Sql"+sql);
										prodet = stmt.executeUpdate (sql);
										//remqty=masterqty-qtys;



									}

								}  

							}


						}

					}

				}




				int termsdet=0;


				String descs="Sales INR-"+""+vocno+""+":-Dated :- "+date; 

				String refdetails="INR"+""+vocno;




/*
				int	clientaccount=claccno;



				String vendorcur="1"; 
				double venrate=1;

				String sqls10="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+clientaccount+"'";
				//System.out.println("---1----sqls10----"+sqls10) ;
				ResultSet tass11 = stmt.executeQuery (sqls10);
				if(tass11.next()) {

					vendorcur=tass11.getString("curid");	


				}


				String currencytype="";
				String sqlvenselect = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
				//System.out.println("-----2--sqlss----"+sqlss) ;
				ResultSet resultSet33 = stmt.executeQuery(sqlvenselect);

				while (resultSet33.next()) {
					venrate=resultSet33.getDouble("rate");
					currencytype=resultSet33.getString("type");
				}

				double	dramount=Double.parseDouble(finalamt)*-1; 


				double ldramount=0;
				if(currencytype.equalsIgnoreCase("D"))
				{


					ldramount=dramount/venrate ;  
				}

				else
				{
					ldramount=dramount*venrate ;  
				}



				String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+srdocno+",'"+clientaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,1,4,0,0,0,'"+venrate+"',0,0,'INR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";

				//	System.out.println("--sql1----"+sql1);
				int ss = stmt.executeUpdate(sql1);

				if(ss<=0)
				{
					conn.close();
					return 0;

				}*/
				
				
				
				
				
				
				
				
				//=====1

				int	clientaccount=claccno;



				String vendorcur="1"; 
				double venrate=1;
				
				if(modepay.equalsIgnoreCase("cash")){
					
				String sql29="select  acno from my_account where codeno='CASHACSALES' ";
			System.out.println("-----4--sql2----"+sql29) ;

				ResultSet tass19 = stmt.executeQuery (sql29);

				if (tass19.next()) {

					clientaccount=tass19.getInt("acno");		

				}
				}
				

				String sqls10="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+clientaccount+"'";
				//System.out.println("---1----sqls10----"+sqls10) ;
				ResultSet tass11 = stmt.executeQuery (sqls10);
				if(tass11.next()) {

					vendorcur=tass11.getString("curid");	


				}


				String currencytype="";
				String sqlvenselect = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
				 System.out.println("-----2--sqlvenselect----"+sqlvenselect) ;
				ResultSet resultSet33 = stmt.executeQuery(sqlvenselect);

				while (resultSet33.next()) {
					venrate=resultSet33.getDouble("rate");
					currencytype=resultSet33.getString("type");
				}

				double	dramount=Double.parseDouble(finalamt)*-1; 


				double ldramount=0;
				if(currencytype.equalsIgnoreCase("D"))
				{


					ldramount=dramount/venrate ;  
				}

				else
				{
					ldramount=dramount*venrate ;  
				}



				String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+srdocno+",'"+clientaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,-1,4,0,0,0,'"+venrate+"',0,0,'INR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";

				//	System.out.println("--sql1----"+sql1);
				int ss = stmt.executeUpdate(sql1);

				if(ss<=0)
				{
					conn.close();
					return 0;

				}
		
				
				
				
				
				
				//=============2
				
				
				
				int acnos1=0;
				String curris1="1";
				double rates1=1;

				String sql21="";
				if(modepay.equalsIgnoreCase("credit")){
					 sql21="select  acno from my_account where codeno='SALESCR' ";
				}
				if(modepay.equalsIgnoreCase("cash")){
					 sql21="select  acno from my_account where codeno='SALESCH' ";
				}
				
				//System.out.println("-----4--sql21----"+sql21) ;

				ResultSet tass111 = stmt.executeQuery (sql21);

				if (tass111.next()) {

					acnos1=tass111.getInt("acno");		

				}



				String sqls31="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos1+"'";
				//System.out.println("-----5--sqls31----"+sqls31) ;
				ResultSet tass31 = stmt.executeQuery (sqls31);

				if (tass31.next()) {

					curris1=tass31.getString("curid");	


				}
				String currencytype11="";
				String sqlveh1 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris1+"'";
				//System.out.println("-----6--sqlveh1----"+sqlveh1) ;
				ResultSet resultSet441 = stmt.executeQuery(sqlveh1);

				while (resultSet441.next()) {
					rates1=resultSet441.getDouble("rate");
					currencytype11=resultSet441.getString("type");
				} 

				double pricetottal1=Double.parseDouble(nettotal);
				double ldramounts1=0 ;     
				if(currencytype11.equalsIgnoreCase("D"))
				{

					ldramounts1=pricetottal1/venrate ;  
				}

				else
				{
					ldramounts1=pricetottal1*venrate ;  
				}

				String sql111="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+srdocno+",'"+acnos1+"','"+descs+"','"+curris1+"','"+rates1+"',"+pricetottal1+","+ldramounts1+",0,1,4,0,0,0,'"+rates1+"',0,0,'INR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";



				int ss11 = stmt.executeUpdate(sql111);

				if(ss11<=0)
				{
					conn.close();
					return 0;

				}
				
				
				

				
				
				
				
			/*	
				
				String expcurrid="1"; 
				double exprate=1;
				int acnos=0;
				String curris="1";
				double rates=1;



				String sql2="select  acno from my_account where codeno='STOCK ACCOUNT' ";
				//System.out.println("-----4--sql2----"+sql2) ;

				ResultSet tass1 = stmt.executeQuery (sql2);

				if (tass1.next()) {

					acnos=tass1.getInt("acno");		

				}



				String sqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
				//System.out.println("-----5--sqls3----"+sqls3) ;
				ResultSet tass3 = stmt.executeQuery (sqls3);

				if (tass3.next()) {

					curris=tass3.getString("curid");	


				}
				String currencytype1="";
				String sqlveh = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
				//System.out.println("-----6--sqlveh----"+sqlveh) ;
				ResultSet resultSet44 = stmt.executeQuery(sqlveh);

				while (resultSet44.next()) {
					rates=resultSet44.getDouble("rate");
					currencytype1=resultSet44.getString("type");
				} 

				double pricetottal=Double.parseDouble(nettotal);
				double ldramounts=0 ;     
				if(currencytype1.equalsIgnoreCase("D"))
				{

					ldramounts=pricetottal/venrate ;  
				}

				else
				{
					ldramounts=pricetottal*venrate ;  
				}

				String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+srdocno+",'"+acnos+"','"+descs+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,-1,4,0,0,0,'"+rates+"',0,0,'INR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";


				// System.out.println("---sql11----"+sql11) ; 

				int ss1 = stmt.executeUpdate(sql11);

				if(ss1<=0)
				{
					conn.close();
					return 0;

				}
				
				*/
				
				
				//==================3
				
				
				
				String totalcostval="0";
				String s="select sum(costval) costval,tr_no from  (select op_qty*cost_price costval ,tr_no from my_prddin where  tr_no="+trno+" and dtype='INR'  ) a group by a.tr_no ";
	 
				System.out.println("-totalvalsssssssssssssssssssssssssss----"+s) ;

				ResultSet tcosts = stmt.executeQuery (s);

				if (tcosts.next()) {

					totalcostval=tcosts.getString("costval");		

				}

 
				
				
				//=====4
				int acnos=0;
				String curris="1";
				double rates=1;



				String sql2="select  acno from my_account where codeno='STOCK ACCOUNT' ";
				//System.out.println("-----4--sql2----"+sql2) ;

				ResultSet tass1 = stmt.executeQuery (sql2);

				if (tass1.next()) {

					acnos=tass1.getInt("acno");		

				}



				String sqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
				//System.out.println("-----5--sqls3----"+sqls3) ;
				ResultSet tass3 = stmt.executeQuery (sqls3);

				if (tass3.next()) {

					curris=tass3.getString("curid");	


				}
				String currencytype1="";
				String sqlveh = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
				//System.out.println("-----6--sqlveh----"+sqlveh) ;
				ResultSet resultSet44 = stmt.executeQuery(sqlveh);

				while (resultSet44.next()) {
					rates=resultSet44.getDouble("rate");
					currencytype1=resultSet44.getString("type");
				} 

		 
				double pricetottal=Double.parseDouble(totalcostval);
				double ldramounts=0 ;     
				if(currencytype1.equalsIgnoreCase("D"))
				{

					ldramounts=pricetottal/venrate ;  
				}

				else
				{
					ldramounts=pricetottal*venrate ;  
				}

				String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+srdocno+",'"+acnos+"','"+descs+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,1,4,0,0,0,'"+rates+"',0,0,'INR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";



				int ss1 = stmt.executeUpdate(sql11);

				if(ss1<=0)
				{
					conn.close();
					return 0;

				}


/*
				int acnos1=0;
				String curris1="1";
				double rates1=1;



				String sql21="select  acno from my_account where codeno='SALES' ";
				//System.out.println("-----4--sql21----"+sql21) ;

				ResultSet tass111 = stmt.executeQuery (sql21);

				if (tass111.next()) {

					acnos1=tass111.getInt("acno");		

				}



				String sqls31="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos1+"'";
				//System.out.println("-----5--sqls31----"+sqls31) ;
				ResultSet tass31 = stmt.executeQuery (sqls31);

				if (tass31.next()) {

					curris1=tass31.getString("curid");	


				}
				String currencytype11="";
				String sqlveh1 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris1+"'";
				//System.out.println("-----6--sqlveh1----"+sqlveh1) ;
				ResultSet resultSet441 = stmt.executeQuery(sqlveh1);

				while (resultSet441.next()) {
					rates1=resultSet441.getDouble("rate");
					currencytype11=resultSet441.getString("type");
				} 

				double pricetottal1=Double.parseDouble(nettotal);
				double ldramounts1=0 ;     
				if(currencytype11.equalsIgnoreCase("D"))
				{

					ldramounts1=pricetottal1/venrate ;  
				}

				else
				{
					ldramounts1=pricetottal1*venrate ;  
				}

				String sql111="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+srdocno+",'"+acnos1+"','"+descs+"','"+curris1+"','"+rates1+"',"+pricetottal1+","+ldramounts1+",0,-1,4,0,0,0,'"+rates1+"',0,0,'INR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";


				// System.out.println("---sql11----"+sql11) ; 

				int ss11 = stmt.executeUpdate(sql111);

				if(ss11<=0)
				{
					conn.close();
					return 0;

				}
*/

				
/*				
				
				int acnos2=0;
				String curris2="1";
				double rates2=1;



				String sql22="select  acno from my_account where codeno='COST OF GOODS SOLD' ";
				//System.out.println("-----4--sql22----"+sql22) ;

				ResultSet tass12 = stmt.executeQuery (sql22);

				if (tass12.next()) {

					acnos2=tass12.getInt("acno");		

				}



				String sqls32="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos2+"'";
				//System.out.println("-----5--sqls32----"+sqls32) ;
				ResultSet tass312 = stmt.executeQuery (sqls32);

				if (tass312.next()) {

					curris2=tass312.getString("curid");	


				}
				String currencytype12="";
				String sqlveh12 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris2+"'";
				//System.out.println("-----6--sqlveh12----"+sqlveh12) ;
				ResultSet resultSet442 = stmt.executeQuery(sqlveh12);

				while (resultSet442.next()) {
					rates2=resultSet442.getDouble("rate");
					currencytype12=resultSet442.getString("type");
				} 

				double pricetottal2=Double.parseDouble(nettotal)*-1;
				double ldramounts2=0 ;     
				if(currencytype12.equalsIgnoreCase("D"))
				{

					ldramounts2=pricetottal2/venrate ;  
				}

				else
				{
					ldramounts2=pricetottal2*venrate ;  
				}

				String sql112="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+srdocno+",'"+acnos2+"','"+descs+"','"+curris2+"','"+rates2+"',"+pricetottal2+","+ldramounts2+",0,1,4,0,0,0,'"+rates2+"',0,0,'INR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";


				// System.out.println("---sql11----"+sql11) ; 

				int ss12 = stmt.executeUpdate(sql112);

				if(ss12<=0)
				{
					conn.close();
					return 0;

				}
*/

				int acnos2=0;
				String curris2="1";
				double rates2=1;



				String sql22="select  acno from my_account where codeno='COST OF GOODS SOLD' ";
				//System.out.println("-----4--sql22----"+sql22) ;

				ResultSet tass12 = stmt.executeQuery (sql22);

				if (tass12.next()) {

					acnos2=tass12.getInt("acno");		

				}



				String sqls32="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos2+"'";
				//System.out.println("-----5--sqls32----"+sqls32) ;
				ResultSet tass312 = stmt.executeQuery (sqls32);

				if (tass312.next()) {

					curris2=tass312.getString("curid");	


				}
				String currencytype12="";
				String sqlveh12 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris2+"'";
				//System.out.println("-----6--sqlveh12----"+sqlveh12) ;
				ResultSet resultSet442 = stmt.executeQuery(sqlveh12);

				while (resultSet442.next()) {
					rates2=resultSet442.getDouble("rate");
					currencytype12=resultSet442.getString("type");
				} 
 
				double pricetottal2=Double.parseDouble(totalcostval)*-1;
				double ldramounts2=0 ;     
				if(currencytype12.equalsIgnoreCase("D"))
				{

					ldramounts2=pricetottal2/venrate ;  
				}

				else
				{
					ldramounts2=pricetottal2*venrate ;  
				}

				String sql112="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+srdocno+",'"+acnos2+"','"+descs+"','"+curris2+"','"+rates2+"',"+pricetottal2+","+ldramounts2+",0,-1,4,0,0,0,'"+rates2+"',0,0,'INR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";

				// System.out.println("---sql11----"+sql11) ; 

				int ss12 = stmt.executeUpdate(sql112);

				if(ss12<=0)
				{
					conn.close();
					return 0;

				}


				
				
				
				
				
				double jvdramount=0;
				int id=0;
				int adjustacno=0;

				String adjustcurrid="1";


				double adjustcurrate=1;

				String jvselect="SELECT sum(dramount) dramount from my_jvtran where tr_no='"+trno+"'";
				//System.out.println("-----5--sqls3----"+sqls3) ;
				ResultSet jvrs = stmt.executeQuery (jvselect);

				if (jvrs.next()) {

					jvdramount=jvrs.getDouble("dramount");	


				}
				System.out.println("--jvdramount----"+jvdramount) ;
				if(jvdramount>0 || jvdramount<0)
				{


					if(jvdramount>0)
					{
						id=1;


					}

					else
					{

						id=-1;
					}




					String sqls2="select  acno from my_account where codeno='STOCK ADJUSTMENT ACCOUNT' ";
					//System.out.println("-----4--sql22----"+sql2) ;

					ResultSet adjaccount = stmt.executeQuery (sqls2);

					if (adjaccount.next()) {

						adjustacno=adjaccount.getInt("acno");		

					}



					String expsqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+adjustacno+"'";
					//System.out.println("-----5--sqls3----"+sqls3) ;
					ResultSet exptass3 = stmt.executeQuery (expsqls3);

					if (exptass3.next()) {

						adjustcurrid=exptass3.getString("curid");	


					}
					String adjustcurrencytype1="";
					String adjustsql = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+adjustcurrid+"'";
					System.out.println("---adjustsql----"+adjustsql) ;
					ResultSet resultadj = stmt.executeQuery(adjustsql);

					while (resultadj.next()) {
						adjustcurrate=resultadj.getDouble("rate");
						adjustcurrencytype1=resultadj.getString("type");
					} 


					double adjustldramounts=0 ;     
					if(adjustcurrencytype1.equalsIgnoreCase("D"))
					{

						adjustldramounts=jvdramount/adjustcurrate ;  
					}

					else
					{
						adjustldramounts=jvdramount*adjustcurrate ;  
					}





					String adjustsql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
							+ "values('"+date+"','"+refdetails+"',"+srdocno+",'"+adjustacno+"','"+descs+"','"+adjustcurrid+"','"+adjustcurrate+"',"+jvdramount+","+adjustldramounts+",0,'"+id+"',4,0,0,0,'"+adjustcurrate+"',0,0,'INR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";


					// System.out.println("---sql11----"+sql11) ; 

					int result1 = stmt.executeUpdate(adjustsql11);

					if(result1<=0)
					{
						conn.close();
						return 0;

					}




				}




			}



 	 conn.commit();
		}
		catch(Exception e){
			srdocno=0;
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return srdocno;
	}

	public  ClsbranchInvoicereturnBean getViewDetails(int docno,String branchid) throws SQLException{


		Connection conn =null;
		try {
			conn= ClsConnection.getMyConnection();

			Statement stmt = conn.createStatement ();

			String sql= ("select m.delterms,l.loc_name,m.locid,m.doc_no,m.voc_no,coalesce(m.refno,'') refno,m.date,m.dtype,cr.doc_no as currid,cr.code as curr,cr.c_rate as curate,m.brhid,ac.refname as name,ac.address as cladd,m.cldocno,coalesce(m.ref_type,'DIR') as ref_type ,coalesce(rrefno,'') as rrefno,coalesce(description,'') as descrptn,coalesce(payterms,'') as payterms,coalesce(s.doc_no,0) as salid,coalesce(s.sal_name,'') as sal_name,coalesce(m.amount,0.00) as proamt,coalesce(m.discount,0.00) as discount,coalesce(m.netAmount,0.00) as netotal,coalesce(m.disper,0.00) as discper,round(coalesce(m.grantamt,0.00),2) as ordervalue,coalesce(m.servamt,0.00) as servamt,coalesce(m.roundof,0.00) as roundof "
					+ "from my_invr m left join my_inrd d on(m.doc_no=d.rdocno)  left join my_locm l on(l.doc_no=m.locid) left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') left join my_salm s on(s.doc_no=m.sal_id) left join my_curr cr on(m.curid=cr.doc_no) where m.doc_no="+docno+" and m.brhid="+branchid+"");

			System.out.println("==getViewDetails===="+sql);
			String dtype="";
			String sqot="";
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()){

				bean.setMasterdoc_no(rs.getInt("doc_no"));
				bean.setDocno(rs.getString("voc_no"));
				bean.setTxtrefno(rs.getString("refno"));
				bean.setCmbcurr(rs.getString("currid"));
				bean.setHidcmbcurrency(rs.getString("currid"));
				bean.setCurrate(rs.getString("curate"));
				bean.setSalespersonid(rs.getInt("salid"));
				bean.setTxtsalesperson(rs.getString("sal_name"));
				bean.setClientid(rs.getInt("cldocno"));
				bean.setRefmasterdocno(rs.getString("rrefno"));
				bean.setCmbreftype(rs.getString("ref_type"));
				bean.setHidcmbreftype(rs.getString("ref_type"));
				dtype=rs.getString("ref_type");
				sqot=rs.getString("rrefno");
				bean.setProdsearchtype(rs.getString("ref_type")=="DIR"?"0":"2");
				bean.setTxtpaymentterms(rs.getString("payterms"));
				bean.setTxtdescription(rs.getString("descrptn"));
				bean.setTxtproductamt(rs.getString("proamt"));
				bean.setTxtdiscount(rs.getString("discount"));
				bean.setDescPercentage(rs.getString("discper"));
				bean.setRoundOf(rs.getString("roundof"));
				bean.setTxtnettotal(rs.getString("netotal"));
				bean.setNettotal(rs.getString("servamt"));
				bean.setOrderValue(rs.getString("ordervalue"));
				
				bean.setLocationid(rs.getInt("locid"));
				bean.setTxtlocation(rs.getString("loc_name"));
				
				bean.setTxtdelterms(rs.getString("delterms")) ;
				

			}


			int i=0;
			String qotdoc="";
			if(dtype.equalsIgnoreCase("INV"))
			{
				Statement stmt1  = conn.createStatement ();	
				String sqlss="select voc_no from  my_invm where doc_no in ("+sqot+") ";
				//System.out.println("==sqlss==="+sqlss);

				ResultSet resultSet1= stmt1.executeQuery(sqlss);


				while (resultSet1.next()) {

					if(i==0)
					{
						qotdoc=resultSet1.getString("voc_no")+",";	
					}
					else
					{
						qotdoc=qotdoc+resultSet1.getString("voc_no")+",";
					}


					i++;



				}

				if(qotdoc.endsWith(","))
				{
					qotdoc = qotdoc.substring(0,qotdoc.length() - 1);
				}

				bean.setRrefno(qotdoc);

			}



		}
		catch(Exception e){
			e.printStackTrace();
		}
finally
{
	conn.close();
}
		return bean;
	}



	public int update(String voc_no,int doc_no,java.sql.Date date,String refno,String pricegrp,String curr,String currate,int salesid,int clientid,String rrefno,String rreftype,String payterms,String desc,
			String prodamt,String descount,String nettotal,String servamt,String roundof,String finalamt,String mode,String formcode,ArrayList prodarray,
			HttpSession session,HttpServletRequest request,String qotmasterdocno,String descper,java.sql.Date payduedate,int locationid,String modepay,String deltems) throws SQLException{

		Connection conn=null;
		int srdocno=0;
		int tranid=0;
		conn=ClsConnection.getMyConnection();

		try{

			if(modepay.equalsIgnoreCase("cash")){
				tranid=1;
			}
			else if(modepay.equalsIgnoreCase("credit")){
				tranid=2;
			}
			conn.setAutoCommit(false);

			CallableStatement stmt = conn.prepareCall("{CALL saleInvReturnDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			
			stmt.registerOutParameter(22, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(23, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			stmt.setString(2,refno);
			stmt.setInt(3, clientid);
			stmt.setInt(4, Integer.parseInt(curr));
			stmt.setDouble(5, Double.parseDouble(currate));
			stmt.setInt(6, salesid);
			stmt.setString(7,rreftype);
			stmt.setString(8,rrefno);
			stmt.setString(9,payterms);
			stmt.setString(10,desc);
			stmt.setString(11,mode);
			stmt.setString(12,formcode);
			stmt.setString(13, session.getAttribute("USERID").toString());
			stmt.setString(14, session.getAttribute("BRANCHID").toString());
			stmt.setString(15, session.getAttribute("COMPANYID").toString());
			stmt.setString(16, finalamt);
			stmt.setDate(17,payduedate);
			stmt.setInt(18,locationid);
			stmt.setInt(19,tranid);
			stmt.setInt(20,doc_no);
			stmt.setInt(21,Integer.parseInt(voc_no));
			
			int val = stmt.executeUpdate();
			srdocno=stmt.getInt("sodocno");
			int vocno=stmt.getInt("vdocNo");
			int trno=stmt.getInt("strno");
			int claccno=stmt.getInt("tmpacno");
			request.setAttribute("vdocNo", vocno);
			//System.out.println("===vocno====="+vocno);
			if(vocno>0){
				 Statement stmtss=conn.createStatement();
				 String sqlsu= " update my_invr set delterms='"+deltems+"',ftype=1    where doc_no='"+srdocno+"' ";
				 stmtss.executeUpdate(sqlsu);
				int prodet=0;
				int prodout=0;
				for(int i=0;i< prodarray.size();i++){

					String[] prod=((String) prodarray.get(i)).split("::");
					System.out.println("prod[0]===="+prod[0]);
					if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined"))|| (prod[0].equalsIgnoreCase("null")))){


						if(vocno>0)
						{

							
							
							
							
							 
							if(i==0)
							{
	        int counts=0;							
	        String tempstk="0";	
	        
	        int stkids=0;
	        
	        String tempstkids="0";
	      
	        int ref_row=0;	
			double prdqty=0;

			double saveqty=0;
			int tmptrno=0;
			
			int prdidss=0;
			
			double delnqtys=0;

/*			
			-- select ref_row,qty from my_delrd where rdocno=1;


			select out_qty   from my_deld where doc_no=17;
			*/
		  	
		    Statement stmnt=conn.createStatement();		
		    Statement stmnt1=conn.createStatement();
		    Statement stmnt3=conn.createStatement();
		    	String sql2="select ref_row,qty,prdid,tr_no from my_inrd where rdocno='"+srdocno+"'";
		    	System.out.println("-----sql2-----"+sql2);
		    	ResultSet rsstk111 = stmnt1.executeQuery(sql2);
		    	
		    	
		    	while(rsstk111.next())
		    	{
		    		ref_row=rsstk111.getInt("ref_row");
		    		delnqtys=rsstk111.getDouble("qty");
		    		prdidss=rsstk111.getInt("prdid");
		    		tmptrno=rsstk111.getInt("tr_no");
		    	
		  
		    		
		    	String sql3=" select out_qty   from my_invd where doc_no='"+ref_row+"'";
		    	 System.out.println("-----sql3-----"+sql3);
		    	ResultSet rsstk1111 = stmnt.executeQuery(sql3);
		    	
		    	
		    	if(rsstk1111.next())
		    	{
		    		prdqty=rsstk1111.getDouble("out_qty");
			    	saveqty=prdqty-delnqtys;
			    	
			    	if(saveqty<0){
			    	saveqty=0;
			    	
			    	}
			    	
			      	String sql31="update my_invd set out_qty="+saveqty+" where doc_no='"+ref_row+"'";
			    	 System.out.println("-----sql31-----"+sql31);
			    	 stmnt3.executeUpdate(sql31);
			    	 
			    	 
			    	 
			    	 
		    		
		    	}
		    	}

		    	 
		    	
							 
						    String dql31="delete from my_inrd where rdocno='"+srdocno+"'";
				    	 	  stmt.executeUpdate(dql31);
				    		    String dql311="delete from my_jvtran where tr_no='"+trno+"'";
					    	 	  stmt.executeUpdate(dql311);
				    	 	  
		 
				    	 	  
						}
						
						
					 
						System.out.println("-----srdocno------------------------"+srdocno);
							
							
							
							
							String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
							String specno=""+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"";
							String stkid=""+(prod[12].equalsIgnoreCase("undefined") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"";						 
							String  rqty=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
							double masterqty=Double.parseDouble(rqty);

							//int stockid=Integer.parseInt(stkid);

							int oldStockid=0;
							Statement stmtstk1=conn.createStatement();
							String stkid1="select refstockid from my_prddin where stockid='"+stkid+"'  ";
							ResultSet rsstk1 = stmtstk1.executeQuery(stkid1);
							
							if(rsstk1.next())
							{
								
								oldStockid=rsstk1.getInt("refstockid");
							}

							double masterqty1=0;

							double balstkqty=0;
							int psrno=0;
							int stockid=0;
							int refstockid=0;
							double remstkqty=0;
							double outstkqty=0;
							double stkqty=0;
							double qty=0;
							double detqty=0;
							double unitprice=0.0;
							double costprice=0.0;
							double tmp_qty=0.0;
							double outqtys=0.0;
							double prdinqty=0.0;
							
							
							double NtWtKG=0.0;
							double KGPrice=0.0;
							double total=0.0;
							double discper=0.0;
							double discount=0.0;
							double netotal=0.0;
							
							masterqty1=masterqty;
							unitprice=Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"");

							Statement stmtstk=conn.createStatement();


							String stkSql="select d.rdocno,d.doc_no,d.stockid,d.psrno,d.specno,d.qty delqty,sum(d.qty) stkqty,sum(d.qty-d.out_qty) balstkqty,(d.out_qty) out_qty,sum(i.del_qty) as qty,m.date,i.unit_price,i.cost_price from my_invm m "
									+ " left join  my_invd d on(d.rdocno=m.doc_no) left join my_prddin i on(d.stockid=i.stockid) "
									+ "where d.rdocno in("+qotmasterdocno+") and d.stockid="+oldStockid+"  and d.psrno='"+prdid+"' and d.specno='"+specno+"' and d.prdid='"+prdid+"' and m.brhid="+session.getAttribute("BRANCHID").toString()+" and m.locid='"+locationid+"' "
									+ "group by d.stockid,d.prdid,d.psrno having sum(qty-d.out_qty)>0 order by m.date,i.stockid";
							
	/*						
							
							String stkSql="select stockid,psrno,specno,sum(op_qty) stkqty,sum(op_qty-(out_qty+del_qty+rsv_qty)) balstkqty,(out_qty+del_qty+rsv_qty) out_qty,out_qty as qty,out_qty qtys,date,unit_price,cost_price from my_prddin "
									+ "where psrno='"+prdid+"' and specno='"+specno+"'  and prdid='"+prdid+"' and brhid="+session.getAttribute("BRANCHID").toString()+" "
									+ "group by stockid,cost_price,prdid,psrno  order by date,stockid";
*/
							System.out.println("=stkSql=inside insert="+stkSql);

							ResultSet rsstk = stmtstk.executeQuery(stkSql);

							while(rsstk.next()) {


								balstkqty=rsstk.getDouble("balstkqty");
								psrno=rsstk.getInt("psrno");
								outstkqty=rsstk.getDouble("out_qty");
								stockid=rsstk.getInt("stockid");
								stkqty=rsstk.getDouble("stkqty");
								prdinqty=rsstk.getDouble("qty");
								unitprice=rsstk.getDouble("unit_price");
								costprice=rsstk.getDouble("cost_price");
							 
								
								
								System.out.println("---masterqty-----"+masterqty);	
								System.out.println("---balstkqty-----"+balstkqty);	
								System.out.println("---out_qty-----"+outstkqty);	
								System.out.println("---stkqty-----"+stkqty);
								System.out.println("---qty-----"+qty);

								String queryappnd="";

						

								NtWtKG=Double.parseDouble(""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"");
								KGPrice=Double.parseDouble(""+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"");
								unitprice=Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"");
								total=masterqty*unitprice;
								discper=Double.parseDouble(""+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"");
								discount=(total*discper)/100;
								netotal=total-discount;

					 
								String prodinsql="update my_prddin set  date='"+date+"',op_qty="+masterqty+" where stockid="+stkid+" and psrno='"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"' and "
										+ "prdid='"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"' and "
												+ "brhid='"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"' and locid='"+locationid+"'";
					 


								System.out.println("prodinsql--->>>>Sql"+prodinsql);
								prodout = stmt.executeUpdate (prodinsql);
									if(masterqty<=balstkqty)
									{
										break;
									}	
									
									


							}
				 


							if(rreftype.equalsIgnoreCase("INV"))
							{

								double balqty=0;
								int docno=0;
								int rdocno=0;
								double remqty=0;
								double out_qty=0;
								double qtys=0;
								int invstk=0;
								double secqty=0;
								Statement stmt1=conn.createStatement();

								String strSql="select d.stockid,d.qty qty,sum((d.qty-d.out_qty)) balqty,d.doc_no,d.rdocno,d.out_qty out_qty,d.prdid  from my_invm m  left join "
										+ "my_invd d on m.doc_no=d.rdocno where d.rdocno in ("+qotmasterdocno+") and d.stockid="+oldStockid+" and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and m.locid='"+locationid+"' and d.prdid='"+prdid+"' group by d.doc_no having  sum(d.qty-d.out_qty)>0 "
										+ "order by m.date,d.doc_no";

								System.out.println("---strSql-----"+strSql);
								ResultSet rs = stmt1.executeQuery(strSql);


								while(rs.next()) {


									balqty=rs.getDouble("balqty");
									rdocno=rs.getInt("rdocno");
									out_qty=rs.getDouble("out_qty");

									docno=rs.getInt("doc_no");
									qtys=rs.getDouble("qty");
									invstk=rs.getInt("stockid");

									System.out.println("---masterqty-----"+masterqty);	
									System.out.println("---balqty-----"+balqty);	
									System.out.println("---out_qty-----"+out_qty);	
									System.out.println("---qtys-----"+qtys);


									if(remqty>0)
									{

										masterqty1=remqty;
									}


									if(masterqty1<=balqty)
									{
										
										String sql="insert into my_inrd(tr_No,sr_no,rdocno,stockid,refstockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal,ref_row)VALUES"
												+ " ("+trno+","+(i+1)+",'"+srdocno+"',"
												+ "'"+stkid+"',"
												+ "'"+oldStockid+"',"
												+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
												+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
												+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
												+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
												+ "'"+masterqty1+"',"
												+ "'"+NtWtKG+"',"
												+ "'"+KGPrice+"',"
												+ "'"+unitprice+"',"
												+ "'"+total+"',"
												+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
												+ "'"+discount+"',"
												+ "'"+netotal+"','"+docno+"')";

										System.out.println("branchper--1->>>>Sql"+sql);
										prodet = stmt.executeUpdate (sql);
										
										
										masterqty1=masterqty1+out_qty;


										String sqls="update my_invd set out_qty="+masterqty1+" where stockid="+invstk+" and rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+"";

										System.out.println("--1---sqls---"+sqls);


										stmt.executeUpdate(sqls);
										break;


									}
									else if(masterqty1>balqty)
									{
										secqty=balqty;


										if(qtys>=(masterqty1+out_qty))

										{
											balqty=masterqty1+out_qty;	
											remqty=qtys-out_qty;

											//	System.out.println("---remqty-1---"+remqty);
										}
										else
										{
											remqty=masterqty1-balqty;
											balqty=qtys;

											//System.out.println("---remqty--2--"+remqty);
										}


										String sqls="update my_invd set out_qty="+balqty+" where stockid="+invstk+" and rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+"";	
										System.out.println("-2----sqls---"+sqls);

										stmt.executeUpdate(sqls);	
										String sql="insert into my_inrd(tr_No,sr_no,rdocno,stockid,refstockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal,ref_row)VALUES"
												+ " ("+trno+","+(i+1)+",'"+srdocno+"',"
												+ "'"+stkid+"',"
												+ "'"+oldStockid+"',"
												+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
												+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
												+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
												+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
												+ "'"+secqty+"',"
												+ "'"+NtWtKG+"',"
												+ "'"+KGPrice+"',"
												+ "'"+unitprice+"',"
												+ "'"+total+"',"
												+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
												+ "'"+discount+"',"
												+ "'"+netotal+"','"+docno+"')";

										System.out.println("branchper--1->>>>Sql"+sql);
										prodet = stmt.executeUpdate (sql);
										//remqty=masterqty-qtys;



									}

								}  

							}


						}

					}

				}






				int termsdet=0;


				String descs="Sales INR-"+""+vocno+""+":-Dated :- "+date; 

				String refdetails="INR"+""+vocno;

				
				
				//=====1

				int	clientaccount=claccno;



				String vendorcur="1"; 
				double venrate=1;
				
				if(modepay.equalsIgnoreCase("cash")){
					
				String sql29="select  acno from my_account where codeno='CASHACSALES' ";
			System.out.println("-----4--sql2----"+sql29) ;

				ResultSet tass19 = stmt.executeQuery (sql29);

				if (tass19.next()) {

					clientaccount=tass19.getInt("acno");		

				}
				}
				

				String sqls10="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+clientaccount+"'";
				//System.out.println("---1----sqls10----"+sqls10) ;
				ResultSet tass11 = stmt.executeQuery (sqls10);
				if(tass11.next()) {

					vendorcur=tass11.getString("curid");	


				}


				String currencytype="";
				String sqlvenselect = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
				 System.out.println("-----2--sqlvenselect----"+sqlvenselect) ;
				ResultSet resultSet33 = stmt.executeQuery(sqlvenselect);

				while (resultSet33.next()) {
					venrate=resultSet33.getDouble("rate");
					currencytype=resultSet33.getString("type");
				}

				double	dramount=Double.parseDouble(finalamt)*-1; 


				double ldramount=0;
				if(currencytype.equalsIgnoreCase("D"))
				{


					ldramount=dramount/venrate ;  
				}

				else
				{
					ldramount=dramount*venrate ;  
				}



				String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+srdocno+",'"+clientaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,-1,4,0,0,0,'"+venrate+"',0,0,'INR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";

				//	System.out.println("--sql1----"+sql1);
				int ss = stmt.executeUpdate(sql1);

				if(ss<=0)
				{
					conn.close();
					return 0;

				}
		
				
				
				
				
				
				//=============2
				
				
				
				int acnos1=0;
				String curris1="1";
				double rates1=1;

				String sql21="";
				if(modepay.equalsIgnoreCase("credit")){
					 sql21="select  acno from my_account where codeno='SALESCR' ";
				}
				if(modepay.equalsIgnoreCase("cash")){
					 sql21="select  acno from my_account where codeno='SALESCH' ";
				}
				
				//System.out.println("-----4--sql21----"+sql21) ;

				ResultSet tass111 = stmt.executeQuery (sql21);

				if (tass111.next()) {

					acnos1=tass111.getInt("acno");		

				}



				String sqls31="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos1+"'";
				//System.out.println("-----5--sqls31----"+sqls31) ;
				ResultSet tass31 = stmt.executeQuery (sqls31);

				if (tass31.next()) {

					curris1=tass31.getString("curid");	


				}
				String currencytype11="";
				String sqlveh1 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris1+"'";
				//System.out.println("-----6--sqlveh1----"+sqlveh1) ;
				ResultSet resultSet441 = stmt.executeQuery(sqlveh1);

				while (resultSet441.next()) {
					rates1=resultSet441.getDouble("rate");
					currencytype11=resultSet441.getString("type");
				} 

				double pricetottal1=Double.parseDouble(finalamt);
				double ldramounts1=0 ;     
				if(currencytype11.equalsIgnoreCase("D"))
				{

					ldramounts1=pricetottal1/venrate ;  
				}

				else
				{
					ldramounts1=pricetottal1*venrate ;  
				}

				String sql111="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+srdocno+",'"+acnos1+"','"+descs+"','"+curris1+"','"+rates1+"',"+pricetottal1+","+ldramounts1+",0,1,4,0,0,0,'"+rates1+"',0,0,'INR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";



				int ss11 = stmt.executeUpdate(sql111);

				if(ss11<=0)
				{
					conn.close();
					return 0;

				}
				
				
				

				
				
				
				
				//==================3
				
				
				
				String totalcostval="0";
				String s="select sum(costval) costval,tr_no from  (select op_qty*cost_price costval ,tr_no from my_prddin where  tr_no="+trno+" and dtype='INR'  ) a group by a.tr_no ";
	 
				System.out.println("-totalvalsssssssssssssssssssssssssss----"+s) ;

				ResultSet tcosts = stmt.executeQuery (s);

				if (tcosts.next()) {

					totalcostval=tcosts.getString("costval");		

				}

 
				
				
	 
				int acnos=0;
				String curris="1";
				double rates=1;



				String sql2="select  acno from my_account where codeno='STOCK ACCOUNT' ";
				//System.out.println("-----4--sql2----"+sql2) ;

				ResultSet tass1 = stmt.executeQuery (sql2);

				if (tass1.next()) {

					acnos=tass1.getInt("acno");		

				}



				String sqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
				//System.out.println("-----5--sqls3----"+sqls3) ;
				ResultSet tass3 = stmt.executeQuery (sqls3);

				if (tass3.next()) {

					curris=tass3.getString("curid");	


				}
				String currencytype1="";
				String sqlveh = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
				//System.out.println("-----6--sqlveh----"+sqlveh) ;
				ResultSet resultSet44 = stmt.executeQuery(sqlveh);

				while (resultSet44.next()) {
					rates=resultSet44.getDouble("rate");
					currencytype1=resultSet44.getString("type");
				} 

		 
				double pricetottal=Double.parseDouble(totalcostval);
				double ldramounts=0 ;     
				if(currencytype1.equalsIgnoreCase("D"))
				{

					ldramounts=pricetottal/venrate ;  
				}

				else
				{
					ldramounts=pricetottal*venrate ;  
				}

				String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+srdocno+",'"+acnos+"','"+descs+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,1,4,0,0,0,'"+rates+"',0,0,'INR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";



				int ss1 = stmt.executeUpdate(sql11);

				if(ss1<=0)
				{
					conn.close();
					return 0;

				}

				int acnos2=0;
				String curris2="1";
				double rates2=1;



				String sql22="select  acno from my_account where codeno='COST OF GOODS SOLD' ";
				//System.out.println("-----4--sql22----"+sql22) ;

				ResultSet tass12 = stmt.executeQuery (sql22);

				if (tass12.next()) {

					acnos2=tass12.getInt("acno");		

				}



				String sqls32="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos2+"'";
				//System.out.println("-----5--sqls32----"+sqls32) ;
				ResultSet tass312 = stmt.executeQuery (sqls32);

				if (tass312.next()) {

					curris2=tass312.getString("curid");	


				}
				String currencytype12="";
				String sqlveh12 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris2+"'";
				//System.out.println("-----6--sqlveh12----"+sqlveh12) ;
				ResultSet resultSet442 = stmt.executeQuery(sqlveh12);

				while (resultSet442.next()) {
					rates2=resultSet442.getDouble("rate");
					currencytype12=resultSet442.getString("type");
				} 
 
				double pricetottal2=Double.parseDouble(totalcostval)*-1;
				double ldramounts2=0 ;     
				if(currencytype12.equalsIgnoreCase("D"))
				{

					ldramounts2=pricetottal2/venrate ;  
				}

				else
				{
					ldramounts2=pricetottal2*venrate ;  
				}

				String sql112="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+srdocno+",'"+acnos2+"','"+descs+"','"+curris2+"','"+rates2+"',"+pricetottal2+","+ldramounts2+",0,-1,4,0,0,0,'"+rates2+"',0,0,'INR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";

				// System.out.println("---sql11----"+sql11) ; 

				int ss12 = stmt.executeUpdate(sql112);

				if(ss12<=0)
				{
					conn.close();
					return 0;

				}


				
				
				
				

/*
				int	clientaccount=claccno;



				String vendorcur="1"; 
				double venrate=1;

				String sqls10="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+clientaccount+"'";
				//System.out.println("---1----sqls10----"+sqls10) ;
				ResultSet tass11 = stmt.executeQuery (sqls10);
				if(tass11.next()) {

					vendorcur=tass11.getString("curid");	


				}


				String currencytype="";
				String sqlvenselect = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
				//System.out.println("-----2--sqlss----"+sqlss) ;
				ResultSet resultSet33 = stmt.executeQuery(sqlvenselect);

				while (resultSet33.next()) {
					venrate=resultSet33.getDouble("rate");
					currencytype=resultSet33.getString("type");
				}

				double	dramount=Double.parseDouble(finalamt)*-1; 


				double ldramount=0;
				if(currencytype.equalsIgnoreCase("D"))
				{


					ldramount=dramount/venrate ;  
				}

				else
				{
					ldramount=dramount*venrate ;  
				}



				String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+srdocno+",'"+clientaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,1,4,0,0,0,'"+venrate+"',0,0,'INR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";

				//	System.out.println("--sql1----"+sql1);
				int ss = stmt.executeUpdate(sql1);

				if(ss<=0)
				{
					conn.close();
					return 0;

				}
				
				
				
				*/
		
				
				
				
				
				/*
				
				String expcurrid="1"; 
				double exprate=1;
				int acnos=0;
				String curris="1";
				double rates=1;



				String sql2="select  acno from my_account where codeno='STOCK ACCOUNT' ";
				//System.out.println("-----4--sql2----"+sql2) ;

				ResultSet tass1 = stmt.executeQuery (sql2);

				if (tass1.next()) {

					acnos=tass1.getInt("acno");		

				}



				String sqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
				//System.out.println("-----5--sqls3----"+sqls3) ;
				ResultSet tass3 = stmt.executeQuery (sqls3);

				if (tass3.next()) {

					curris=tass3.getString("curid");	


				}
				String currencytype1="";
				String sqlveh = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
				//System.out.println("-----6--sqlveh----"+sqlveh) ;
				ResultSet resultSet44 = stmt.executeQuery(sqlveh);

				while (resultSet44.next()) {
					rates=resultSet44.getDouble("rate");
					currencytype1=resultSet44.getString("type");
				} 

				double pricetottal=Double.parseDouble(nettotal);
				double ldramounts=0 ;     
				if(currencytype1.equalsIgnoreCase("D"))
				{

					ldramounts=pricetottal/venrate ;  
				}

				else
				{
					ldramounts=pricetottal*venrate ;  
				}

				String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+srdocno+",'"+acnos+"','"+descs+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,-1,4,0,0,0,'"+rates+"',0,0,'INR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";


				// System.out.println("---sql11----"+sql11) ; 

				int ss1 = stmt.executeUpdate(sql11);

				if(ss1<=0)
				{
					conn.close();
					return 0;

				}



				int acnos1=0;
				String curris1="1";
				double rates1=1;



				String sql21="select  acno from my_account where codeno='SALES' ";
				//System.out.println("-----4--sql21----"+sql21) ;

				ResultSet tass111 = stmt.executeQuery (sql21);

				if (tass111.next()) {

					acnos1=tass111.getInt("acno");		

				}



				String sqls31="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos1+"'";
				//System.out.println("-----5--sqls31----"+sqls31) ;
				ResultSet tass31 = stmt.executeQuery (sqls31);

				if (tass31.next()) {

					curris1=tass31.getString("curid");	


				}
				String currencytype11="";
				String sqlveh1 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris1+"'";
				//System.out.println("-----6--sqlveh1----"+sqlveh1) ;
				ResultSet resultSet441 = stmt.executeQuery(sqlveh1);

				while (resultSet441.next()) {
					rates1=resultSet441.getDouble("rate");
					currencytype11=resultSet441.getString("type");
				} 

				double pricetottal1=Double.parseDouble(nettotal);
				double ldramounts1=0 ;     
				if(currencytype11.equalsIgnoreCase("D"))
				{

					ldramounts1=pricetottal1/venrate ;  
				}

				else
				{
					ldramounts1=pricetottal1*venrate ;  
				}

				String sql111="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+srdocno+",'"+acnos1+"','"+descs+"','"+curris1+"','"+rates1+"',"+pricetottal1+","+ldramounts1+",0,-1,4,0,0,0,'"+rates1+"',0,0,'INR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";


				// System.out.println("---sql11----"+sql11) ; 

				int ss11 = stmt.executeUpdate(sql111);

				if(ss11<=0)
				{
					conn.close();
					return 0;

				}


				int acnos2=0;
				String curris2="1";
				double rates2=1;



				String sql22="select  acno from my_account where codeno='COST OF GOODS SOLD' ";
				//System.out.println("-----4--sql22----"+sql22) ;

				ResultSet tass12 = stmt.executeQuery (sql22);

				if (tass12.next()) {

					acnos2=tass12.getInt("acno");		

				}



				String sqls32="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos2+"'";
				//System.out.println("-----5--sqls32----"+sqls32) ;
				ResultSet tass312 = stmt.executeQuery (sqls32);

				if (tass312.next()) {

					curris2=tass312.getString("curid");	


				}
				String currencytype12="";
				String sqlveh12 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris2+"'";
				//System.out.println("-----6--sqlveh12----"+sqlveh12) ;
				ResultSet resultSet442 = stmt.executeQuery(sqlveh12);

				while (resultSet442.next()) {
					rates2=resultSet442.getDouble("rate");
					currencytype12=resultSet442.getString("type");
				} 

				double pricetottal2=Double.parseDouble(nettotal)*-1;
				double ldramounts2=0 ;     
				if(currencytype12.equalsIgnoreCase("D"))
				{

					ldramounts2=pricetottal2/venrate ;  
				}

				else
				{
					ldramounts2=pricetottal2*venrate ;  
				}

				String sql112="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+srdocno+",'"+acnos2+"','"+descs+"','"+curris2+"','"+rates2+"',"+pricetottal2+","+ldramounts2+",0,1,4,0,0,0,'"+rates2+"',0,0,'INR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";


				// System.out.println("---sql11----"+sql11) ; 

				int ss12 = stmt.executeUpdate(sql112);

				if(ss12<=0)
				{
					conn.close();
					return 0;

				}

*/
				double jvdramount=0;
				int id=0;
				int adjustacno=0;

				String adjustcurrid="1";


				double adjustcurrate=1;

				String jvselect="SELECT sum(dramount) dramount from my_jvtran where tr_no='"+trno+"'";
				//System.out.println("-----5--sqls3----"+sqls3) ;
				ResultSet jvrs = stmt.executeQuery (jvselect);

				if (jvrs.next()) {

					jvdramount=jvrs.getDouble("dramount");	


				}
				System.out.println("--jvdramount----"+jvdramount) ;
				if(jvdramount>0 || jvdramount<0)
				{


					if(jvdramount>0)
					{
						id=1;


					}

					else
					{

						id=-1;
					}




					String sqls2="select  acno from my_account where codeno='STOCK ADJUSTMENT ACCOUNT' ";
					//System.out.println("-----4--sql22----"+sql2) ;

					ResultSet adjaccount = stmt.executeQuery (sqls2);

					if (adjaccount.next()) {

						adjustacno=adjaccount.getInt("acno");		

					}



					String expsqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+adjustacno+"'";
					//System.out.println("-----5--sqls3----"+sqls3) ;
					ResultSet exptass3 = stmt.executeQuery (expsqls3);

					if (exptass3.next()) {

						adjustcurrid=exptass3.getString("curid");	


					}
					String adjustcurrencytype1="";
					String adjustsql = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+adjustcurrid+"'";
					System.out.println("---adjustsql----"+adjustsql) ;
					ResultSet resultadj = stmt.executeQuery(adjustsql);

					while (resultadj.next()) {
						adjustcurrate=resultadj.getDouble("rate");
						adjustcurrencytype1=resultadj.getString("type");
					} 


					double adjustldramounts=0 ;     
					if(adjustcurrencytype1.equalsIgnoreCase("D"))
					{

						adjustldramounts=jvdramount/adjustcurrate ;  
					}

					else
					{
						adjustldramounts=jvdramount*adjustcurrate ;  
					}





					String adjustsql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
							+ "values('"+date+"','"+refdetails+"',"+srdocno+",'"+adjustacno+"','"+descs+"','"+adjustcurrid+"','"+adjustcurrate+"',"+jvdramount+","+adjustldramounts+",0,'"+id+"',4,0,0,0,'"+adjustcurrate+"',0,0,'INR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";


					// System.out.println("---sql11----"+sql11) ; 

					int result1 = stmt.executeUpdate(adjustsql11);

					if(result1<=0)
					{
						conn.close();
						return 0;

					}




				}




			}



			conn.commit();
		}
		catch(Exception e){
			srdocno=0;
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return srdocno;
	}

	public int delete(String voc_no,int doc_no,java.sql.Date date,String refno,String pricegrp,String curr,String currate,int salesid,int clientid,String rrefno,String rreftype,String payterms,String desc,
			String prodamt,String descount,String nettotal,String servamt,String roundof,String finalamt,String mode,String formcode,ArrayList prodarray,
			HttpSession session,HttpServletRequest request,String qotmasterdocno,String descper,java.sql.Date payduedate,int locationid) throws SQLException{

		Connection conn=null;
		int srdocno=0;
		conn=ClsConnection.getMyConnection();

		try{

			conn.setAutoCommit(false);

			CallableStatement stmt = conn.prepareCall("{CALL saleInvReturnDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmt.registerOutParameter(19, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(20, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(21, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(22, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			stmt.setString(2,refno);
			stmt.setInt(3, clientid);
			stmt.setInt(4, Integer.parseInt(curr));
			stmt.setDouble(5, Double.parseDouble(currate));
			stmt.setInt(6, salesid);
			stmt.setString(7,rreftype);
			stmt.setString(8,rrefno);
			stmt.setString(9,payterms);
			stmt.setString(10,desc);
			stmt.setString(11,mode);
			stmt.setString(12,formcode);
			stmt.setString(13, session.getAttribute("USERID").toString());
			stmt.setString(14, session.getAttribute("BRANCHID").toString());
			stmt.setString(15, session.getAttribute("COMPANYID").toString());
			stmt.setDouble(16, Double.parseDouble(finalamt));
			stmt.setDate(17,payduedate);
			stmt.setInt(18,locationid);
			int val = stmt.executeUpdate();
			srdocno=stmt.getInt("sodocno");
			int vocno=stmt.getInt("vdocNo");
			int trno=stmt.getInt("strno");
			int claccno=stmt.getInt("tmpacno");
			request.setAttribute("vdocNo", vocno);
			//System.out.println("===vocno====="+vocno);
			if(vocno>0){

				int prodet=0;
				int prodout=0;
				for(int i=0;i< prodarray.size();i++){

					String[] prod=((String) prodarray.get(i)).split("::");
					System.out.println("prod[0]===="+prod[0]);
					if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")))){


						if(vocno>0)
						{

							String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
							String specno=""+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"";
							String stkid=""+(prod[12].equalsIgnoreCase("undefined") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"";						 
							String  rqty=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
							double masterqty=Double.parseDouble(rqty);

							//int stockid=Integer.parseInt(stkid);



							double balstkqty=0;
							int psrno=0;
							int stockid=0;
							double remstkqty=0;
							double outstkqty=0;
							double stkqty=0;
							double qty=0;
							double detqty=0;
							double unitprice=0.0;
							double tmp_qty=0.0;
							double outqtys=0.0;
							String qty_fld="";
							String qryapnd="";
							String slquery="";

							unitprice=Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"");



							Statement stmtstk=conn.createStatement();

							String stkSql="select stockid,psrno,specno,sum(op_qty) stkqty,sum(op_qty-(out_qty+del_qty+rsv_qty)) balstkqty,(out_qty+del_qty+rsv_qty) out_qty,out_qty as qty,out_qty qtys,date from my_prddin "
									+ "where psrno='"+prdid+"' and specno='"+specno+"' and stockid="+stkid+"  and prdid='"+prdid+"' and brhid="+session.getAttribute("BRANCHID").toString()+" "
									+ "group by stockid,cost_price,prdid,psrno  order by date";

							System.out.println("=stkSql=inside insert="+stkSql);

							ResultSet rsstk = stmtstk.executeQuery(stkSql);

							while(rsstk.next()) {


								balstkqty=rsstk.getDouble("balstkqty");
								psrno=rsstk.getInt("psrno");
								outstkqty=rsstk.getDouble("out_qty");
								stockid=rsstk.getInt("stockid");
								stkqty=rsstk.getDouble("stkqty");
								qty=rsstk.getDouble("qty");
								outqtys=rsstk.getDouble("qtys");

								System.out.println("---masterqty-----"+masterqty);	
								System.out.println("---balstkqty-----"+balstkqty);	
								System.out.println("---out_qty-----"+outstkqty);	
								System.out.println("---stkqty-----"+stkqty);
								System.out.println("---qty-----"+qty);

								String queryappnd="";

								/*if((rreftype.equalsIgnoreCase("SOR"))||(rreftype.equalsIgnoreCase("DEL"))){
									queryappnd=","+qty_fld+"="+tmp_qty+"";
								}*/

								/*if(remstkqty>0)
								{

									masterqty=remstkqty;
								}*/

								if(masterqty>=outstkqty){
									String sqls="update my_prddin set out_qty=0  where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+"";
									System.out.println("--1---sqls---"+sqls);
									stmt.executeUpdate(sqls);
								}
								else if(masterqty<=outstkqty){
									
									balstkqty=outstkqty-masterqty;
									
									String sqls="update my_prddin set out_qty="+balstkqty+"  where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+"";
									System.out.println("--2---sqls---"+sqls);
									stmt.executeUpdate(sqls);
									
								}

								/*if(masterqty<=balstkqty)
								{
									detqty=masterqty;

									if(rreftype.equalsIgnoreCase("SOR")){
										qty_fld="rsv_qty";
										tmp_qty=qty-masterqty;
									}
									else if(rreftype.equalsIgnoreCase("DEL")){
										qty_fld="del_qty";
										tmp_qty=qty-masterqty;
									}

									masterqty=masterqty+outqtys;




									String sqls="update my_prddin set out_qty="+masterqty+"  where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+"";
									System.out.println("--1---sqls---"+sqls);
									stmt.executeUpdate(sqls);
									//break;


								}
								else if(masterqty>balstkqty)
								{



									if(stkqty>=(masterqty+outstkqty))

									{
										balstkqty=masterqty+outqtys;	
										remstkqty=stkqty-outstkqty;

										System.out.println("---balstkqty-1---"+balstkqty);
									}
									else
									{
										remstkqty=masterqty-balstkqty;
										balstkqty=stkqty-outstkqty+outqtys;

										System.out.println("---masterqty-2---"+masterqty);
										System.out.println("---outstkqty-2---"+outstkqty);
										System.out.println("---stkqty-2---"+stkqty);
										System.out.println("---remstkqty-2---"+remstkqty);
										System.out.println("---balstkqty--2--"+balstkqty);
									}
									detqty=stkqty-outstkqty;

									String sqls="update my_prddin set out_qty="+balstkqty+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+"";	
									System.out.println("-2----sqls---"+sqls);

									stmt.executeUpdate(sqls);	

									//remstkqty=masterqty-stkqty;



								}
*/


								double NtWtKG=0.0;
								double KGPrice=0.0;
								double total=0.0;
								double discper=0.0;
								double discount=0.0;
								double netotal=0.0;

								NtWtKG=Double.parseDouble(""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"");
								KGPrice=Double.parseDouble(""+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"");
								unitprice=Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"");
								total=detqty*unitprice;
								discper=Double.parseDouble(""+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"");
								discount=(total*discper)/100;
								netotal=total-discount;

								/*System.out.println("==NtWtKG===="+NtWtKG);

									 System.out.println("==KGPrice===="+KGPrice);

									 System.out.println("==unitprice===="+unitprice);

									 System.out.println("==total===="+total);

									 System.out.println("==discper===="+discper);

									 System.out.println("==discount===="+discount);

									 System.out.println("==netotal===="+netotal);*/


								String sql="insert into my_inrd(tr_No,sr_no,rdocno,stockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal)VALUES"
										+ " ("+trno+","+(i+1)+",'"+srdocno+"',"
										+ "'"+stockid+"',"
										+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
										+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
										+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
										+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
										+ "'"+masterqty+"',"
										+ "'"+NtWtKG+"',"
										+ "'"+KGPrice+"',"
										+ "'"+unitprice+"',"
										+ "'"+total+"',"
										+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
										+ "'"+discount+"',"
										+ "'"+netotal+"')";

								System.out.println("branchper--->>>>Sql"+sql);
								prodet = stmt.executeUpdate (sql);

								String prodoutsql="";

							/*	if(rreftype.equalsIgnoreCase("DIR")){


									prodoutsql="insert into my_prddout(sr_no,TR_NO, dtype, rdocno,stockid, specid, psrno,qty,prdid) Values"
											+ " ("+(i+1)+",'"+trno+"','"+formcode+"',"+srdocno+","
											+ "'"+stockid+"',"
											+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+detqty+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"')";


								}
								else{

									prodoutsql="insert into my_prddout(sr_no,TR_NO, dtype, rdocno,stockid, specid, psrno,qty,prdid,"+qty_fld+") Values"
											+ " ("+(i+1)+",'"+trno+"','"+formcode+"',"+srdocno+","
											+ "'"+stockid+"',"
											+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+detqty+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+(detqty*-1)+"')";

								}*/



								/*System.out.println("prodoutsql--->>>>Sql"+prodoutsql);
								prodout = stmt.executeUpdate (prodoutsql);
*/
								if(masterqty<=balstkqty)
								{
									break;
								}


							}



							if(rreftype.equalsIgnoreCase("INV"))
							{

								double balqty=0;
								int docno=0;
								int rdocno=0;
								double remqty=0;
								double out_qty=0;
								double qtys=0;

								Statement stmt1=conn.createStatement();

								String strSql="select d.qty qty,sum((d.qty-d.out_qty)) balqty,d.doc_no,d.rdocno,d.out_qty out_qty,d.prdid  from my_invm m  left join "
										+ "my_invd d on m.doc_no=d.rdocno where d.rdocno in ("+qotmasterdocno+") and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and d.prdid='"+prdid+"' group by d.doc_no having  sum(d.qty-d.out_qty)>0 "
										+ "order by m.date,d.doc_no";

								System.out.println("---strSql-----"+strSql);
								ResultSet rs = stmt1.executeQuery(strSql);


								while(rs.next()) {


									balqty=rs.getDouble("balqty");
									rdocno=rs.getInt("rdocno");
									out_qty=rs.getDouble("out_qty");

									docno=rs.getInt("doc_no");
									qtys=rs.getDouble("qty");


									System.out.println("---masterqty-----"+masterqty);	
									System.out.println("---balqty-----"+balqty);	
									System.out.println("---out_qty-----"+out_qty);	
									System.out.println("---qtys-----"+qtys);


									if(remqty>0)
									{

										masterqty=remqty;
									}


									if(masterqty<=balqty)
									{
										masterqty=masterqty+out_qty;


										String sqls="update my_invd set out_qty="+masterqty+" where stockid="+stockid+" and rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+"";

										System.out.println("--1---sqls---"+sqls);


										stmt.executeUpdate(sqls);
										break;


									}
									else if(masterqty>balqty)
									{



										if(qtys>=(masterqty+out_qty))

										{
											balqty=masterqty+out_qty;	
											remqty=qtys-out_qty;

											//	System.out.println("---remqty-1---"+remqty);
										}
										else
										{
											remqty=masterqty-balqty;
											balqty=qtys;

											//System.out.println("---remqty--2--"+remqty);
										}


										String sqls="update my_invd set out_qty="+balqty+" where stockid="+stockid+" and rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+"";	
										System.out.println("-2----sqls---"+sqls);

										stmt.executeUpdate(sqls);	

										//remqty=masterqty-qtys;



									}

								}  

							}


						}

					}

				}




				int termsdet=0;


				String descs="Sales INR-"+""+vocno+""+":-Dated :- "+date; 

				String refdetails="INR"+""+vocno;





				int	clientaccount=claccno;



				String vendorcur="1"; 
				double venrate=1;

				String sqls10="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+clientaccount+"'";
				//System.out.println("---1----sqls10----"+sqls10) ;
				ResultSet tass11 = stmt.executeQuery (sqls10);
				if(tass11.next()) {

					vendorcur=tass11.getString("curid");	


				}


				String currencytype="";
				String sqlvenselect = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
				//System.out.println("-----2--sqlss----"+sqlss) ;
				ResultSet resultSet33 = stmt.executeQuery(sqlvenselect);

				while (resultSet33.next()) {
					venrate=resultSet33.getDouble("rate");
					currencytype=resultSet33.getString("type");
				}

				double	dramount=Double.parseDouble(finalamt)*-1; 


				double ldramount=0;
				if(currencytype.equalsIgnoreCase("D"))
				{


					ldramount=dramount/venrate ;  
				}

				else
				{
					ldramount=dramount*venrate ;  
				}



				String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+srdocno+",'"+clientaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,1,3,0,0,0,'"+venrate+"',0,0,'INR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";

				//	System.out.println("--sql1----"+sql1);
				int ss = stmt.executeUpdate(sql1);

				if(ss<=0)
				{
					conn.close();
					return 0;

				}
				String expcurrid="1"; 
				double exprate=1;
				int acnos=0;
				String curris="1";
				double rates=1;



				String sql2="select  acno from my_account where codeno='STOCK ACCOUNT' ";
				//System.out.println("-----4--sql2----"+sql2) ;

				ResultSet tass1 = stmt.executeQuery (sql2);

				if (tass1.next()) {

					acnos=tass1.getInt("acno");		

				}



				String sqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
				//System.out.println("-----5--sqls3----"+sqls3) ;
				ResultSet tass3 = stmt.executeQuery (sqls3);

				if (tass3.next()) {

					curris=tass3.getString("curid");	


				}
				String currencytype1="";
				String sqlveh = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
				//System.out.println("-----6--sqlveh----"+sqlveh) ;
				ResultSet resultSet44 = stmt.executeQuery(sqlveh);

				while (resultSet44.next()) {
					rates=resultSet44.getDouble("rate");
					currencytype1=resultSet44.getString("type");
				} 

				double pricetottal=Double.parseDouble(nettotal);
				double ldramounts=0 ;     
				if(currencytype1.equalsIgnoreCase("D"))
				{

					ldramounts=pricetottal/venrate ;  
				}

				else
				{
					ldramounts=pricetottal*venrate ;  
				}

				String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+srdocno+",'"+acnos+"','"+descs+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,-1,3,0,0,0,'"+rates+"',0,0,'INR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";


				// System.out.println("---sql11----"+sql11) ; 

				int ss1 = stmt.executeUpdate(sql11);

				if(ss1<=0)
				{
					conn.close();
					return 0;

				}



				int acnos1=0;
				String curris1="1";
				double rates1=1;



				String sql21="select  acno from my_account where codeno='SALES' ";
				//System.out.println("-----4--sql21----"+sql21) ;

				ResultSet tass111 = stmt.executeQuery (sql21);

				if (tass111.next()) {

					acnos1=tass111.getInt("acno");		

				}



				String sqls31="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos1+"'";
				//System.out.println("-----5--sqls31----"+sqls31) ;
				ResultSet tass31 = stmt.executeQuery (sqls31);

				if (tass31.next()) {

					curris1=tass31.getString("curid");	


				}
				String currencytype11="";
				String sqlveh1 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris1+"'";
				//System.out.println("-----6--sqlveh1----"+sqlveh1) ;
				ResultSet resultSet441 = stmt.executeQuery(sqlveh1);

				while (resultSet441.next()) {
					rates1=resultSet441.getDouble("rate");
					currencytype11=resultSet441.getString("type");
				} 

				double pricetottal1=Double.parseDouble(nettotal);
				double ldramounts1=0 ;     
				if(currencytype11.equalsIgnoreCase("D"))
				{

					ldramounts1=pricetottal1/venrate ;  
				}

				else
				{
					ldramounts1=pricetottal1*venrate ;  
				}

				String sql111="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+srdocno+",'"+acnos1+"','"+descs+"','"+curris1+"','"+rates1+"',"+pricetottal1+","+ldramounts1+",0,-1,3,0,0,0,'"+rates1+"',0,0,'INR','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";


				// System.out.println("---sql11----"+sql11) ; 

				int ss11 = stmt.executeUpdate(sql111);

				if(ss11<=0)
				{
					conn.close();
					return 0;

				}


				int acnos2=0;
				String curris2="1";
				double rates2=1;



				String sql22="select  acno from my_account where codeno='COST OF GOODS SOLD' ";
				//System.out.println("-----4--sql22----"+sql22) ;

				ResultSet tass12 = stmt.executeQuery (sql22);

				if (tass12.next()) {

					acnos2=tass12.getInt("acno");		

				}



				String sqls32="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos2+"'";
				//System.out.println("-----5--sqls32----"+sqls32) ;
				ResultSet tass312 = stmt.executeQuery (sqls32);

				if (tass312.next()) {

					curris2=tass312.getString("curid");	


				}
				String currencytype12="";
				String sqlveh12 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris2+"'";
				//System.out.println("-----6--sqlveh12----"+sqlveh12) ;
				ResultSet resultSet442 = stmt.executeQuery(sqlveh12);

				while (resultSet442.next()) {
					rates2=resultSet442.getDouble("rate");
					currencytype12=resultSet442.getString("type");
				} 

				double pricetottal2=Double.parseDouble(nettotal)*-1;
				double ldramounts2=0 ;     
				if(currencytype12.equalsIgnoreCase("D"))
				{

					ldramounts2=pricetottal2/venrate ;  
				}

				else
				{
					ldramounts2=pricetottal2*venrate ;  
				}

				String sql112="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
						+ "values('"+date+"','"+refdetails+"',"+srdocno+",'"+acnos2+"','"+descs+"','"+curris2+"','"+rates2+"',"+pricetottal2+","+ldramounts2+",0,1,3,0,0,0,'"+rates2+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";


				// System.out.println("---sql11----"+sql11) ; 

				int ss12 = stmt.executeUpdate(sql112);

				if(ss12<=0)
				{
					conn.close();
					return 0;

				}


				double jvdramount=0;
				int id=0;
				int adjustacno=0;

				String adjustcurrid="1";


				double adjustcurrate=1;

				String jvselect="SELECT sum(dramount) dramount from my_jvtran where tr_no='"+trno+"'";
				//System.out.println("-----5--sqls3----"+sqls3) ;
				ResultSet jvrs = stmt.executeQuery (jvselect);

				if (jvrs.next()) {

					jvdramount=jvrs.getDouble("dramount");	


				}
				System.out.println("--jvdramount----"+jvdramount) ;
				if(jvdramount>0 || jvdramount<0)
				{


					if(jvdramount>0)
					{
						id=1;


					}

					else
					{

						id=-1;
					}




					String sqls2="select  acno from my_account where codeno='STOCK ADJUSTMENT ACCOUNT' ";
					//System.out.println("-----4--sql22----"+sql2) ;

					ResultSet adjaccount = stmt.executeQuery (sqls2);

					if (adjaccount.next()) {

						adjustacno=adjaccount.getInt("acno");		

					}



					String expsqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+adjustacno+"'";
					//System.out.println("-----5--sqls3----"+sqls3) ;
					ResultSet exptass3 = stmt.executeQuery (expsqls3);

					if (exptass3.next()) {

						adjustcurrid=exptass3.getString("curid");	


					}
					String adjustcurrencytype1="";
					String adjustsql = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
							+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+adjustcurrid+"'";
					System.out.println("---adjustsql----"+adjustsql) ;
					ResultSet resultadj = stmt.executeQuery(adjustsql);

					while (resultadj.next()) {
						adjustcurrate=resultadj.getDouble("rate");
						adjustcurrencytype1=resultadj.getString("type");
					} 


					double adjustldramounts=0 ;     
					if(adjustcurrencytype1.equalsIgnoreCase("D"))
					{

						adjustldramounts=jvdramount/adjustcurrate ;  
					}

					else
					{
						adjustldramounts=jvdramount*adjustcurrate ;  
					}





					String adjustsql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
							+ "values('"+date+"','"+refdetails+"',"+srdocno+",'"+adjustacno+"','"+descs+"','"+adjustcurrid+"','"+adjustcurrate+"',"+jvdramount+","+adjustldramounts+",0,'"+id+"',3,0,0,0,'"+adjustcurrate+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";


					// System.out.println("---sql11----"+sql11) ; 

					int result1 = stmt.executeUpdate(adjustsql11);

					if(result1<=0)
					{
						conn.close();
						return 0;

					}




				}




			}



			conn.commit();
		}
		catch(Exception e){
			srdocno=0;
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return srdocno;
	}


	public   JSONArray reloadserviceGrid(String docno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh1 = conn.createStatement ();
			String pySql=("select srno,desc1 description,unitprice price,qty,total,discount,nettotal,ir.acno as acno,h.description as account from my_invdser ir left join my_salexpaccount sa on(sa.acno=ir.acno) left join my_head h on(sa.acno=h.doc_no)  where rdocno='"+docno+"' ");
			//System.out.println("========"+pySql);
			ResultSet resultSet = stmtVeh1.executeQuery(pySql);

			RESULTDATA=ClsCommon.convertToJSON(resultSet); 
			stmtVeh1.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//	System.out.println(RESULTDATA);
		return RESULTDATA;
	}



	 public    ClsbranchInvoicereturnBean getPrint(int docno, HttpServletRequest request,String formcode) throws SQLException {
		 ClsbranchInvoicereturnBean bean = new ClsbranchInvoicereturnBean();
		  Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();

				  ClsAmountToWords c = new ClsAmountToWords();
				 
				Statement stmtprint = conn.createStatement ();
	        	
/*				String resql=("select m.rdtype,if(m.rdtype!='DIR',m.rrefno,'') rrefno,if(m.rdtype='DIR','Direct',if(m.rdtype='CEQ','Sales Enquiry','Sales Quotation')) type,m.doc_no,m.voc_no,m.refno,"
						+ " DATE_FORMAT(m.date,'%d.%m.%Y') AS date,h.description descs,h.account,m.acno,m.curId,m.rate,m.amount,m.disstatus,m.disper, \r\n" + 
				" m.discount,m.roundVal,round(m.netAmount,2) netAmount,round(m.supplExp,2) supplExp,round(m.nettotal,2) nettotal,m.prddiscount,m.delterms,m.payterms,m.description,DATE_FORMAT(m.deldate,'%d.%m.%Y') deldate   \r\n" + 
				" from my_qotm m left join my_head h on h.doc_no=m.acno   where   m.doc_no='"+docno+"'");
				*/
			/*    int type=2;
				 
				 if(formcode.equalsIgnoreCase("CASH"))
				 {
					 type=1;
					 
				 }
				    
				*/
				String rdtype="";
				
				String resql=("select m.paymode,l.loc_name location,coalesce(mm.sal_name,'') sal_name,m.ref_type rdtype,if(m.ref_type!='DIR',m.rrefno,'') rrefno, 'Invoice'  type, "
						+ " m.doc_no,m.voc_no,m.refno, DATE_FORMAT(m.date,'%d.%m.%Y') AS date,DATE_FORMAT(m.duedate,'%d.%m.%Y') AS duedate,h.description descs,h.account,m.acno,m.curId,m.rate,m.amount,m.disper,"
						+ " m.discount,round(m.netAmount,2) netAmount,m.delterms,m.payterms,m.description "
				+ "  from my_invr m left join my_head h on h.doc_no=m.acno left join my_salm mm on mm.doc_no=m.sal_id left join my_locm l on l.doc_no=m.locid  where   m.doc_no='"+docno+"'");
				
				
			 System.out.println("---resql----"+resql);
				
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
		 
			       while(pintrs.next()){
			    	
			    	    bean.setLbldoc(pintrs.getInt("voc_no"));
			    	    bean.setLbldate(pintrs.getString("date"));
			    	    bean.setLblrefno(pintrs.getString("refno"));
			    	    bean.setLbldesc1(pintrs.getString("description"));
			    	    bean.setLblpaytems(pintrs.getString("payterms"));
			    	    bean.setLbldelterms(pintrs.getString("delterms"));
			    	    bean.setLbltype(pintrs.getString("type"));
			    	    bean.setLblvendoeacc(pintrs.getString("account"));  
			    	    bean.setLblvendoeaccName(pintrs.getString("descs"));
			    	    
			    	    
			    	    bean.setLblsalesPerson(pintrs.getString("sal_name"));
			    	    bean.setLbllocation1(pintrs.getString("location"));
			    	    
			    	    rdtype=pintrs.getString("rdtype");
			    	    			    	    
			    	    bean.setLblduedate(pintrs.getString("duedate"));
			    	    
			    	    
			    	 //   bean.setExpdeldate(pintrs.getString("deldate"));
			    	    
		/*	    	 
			    	    bean.setLblsubtotal(pintrs.getString("supplExp"));
			            
			    	    bean.setLblordervaluewords(c.convertAmountToWords(pintrs.getString("nettotal")));
			    	    bean.setLblordervalue(pintrs.getString("nettotal"));
			    	    */
			    	    
			    	  
			       }
				

				stmtprint.close();
				
				
				
				 Statement stmt10 = conn.createStatement ();
				    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from my_invr r  "
				    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
				    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";


			         ResultSet resultsetcompany = stmt10.executeQuery(companysql); 
				       
				       while(resultsetcompany.next()){
				    	   
				    	   bean.setLblbranch(resultsetcompany.getString("branchname"));
				    	   bean.setLblcompname(resultsetcompany.getString("company"));
				    	  
				    	   bean.setLblcompaddress(resultsetcompany.getString("address"));
				    	   bean.setLblcomptel(resultsetcompany.getString("tel"));
				    	  
				    	   bean.setLblcompfax(resultsetcompany.getString("fax"));
				    	   bean.setLbllocation(resultsetcompany.getString("location"));
				    	  
				    	   
				    	   
				       } 
				     stmt10.close();
				       
				     double total=0;
				     double grndtotal=0;
				 
				     Statement stmtgrid3 = conn.createStatement ();      
				     String	strSqldetail1="select round(sum(nettotal),2) nettotal  from my_inrd   where rdocno='"+docno+"'";
					 ResultSet rsdetail1=stmtgrid3.executeQuery(strSqldetail1);
				 
						if(rsdetail1.next()){
							
							total=rsdetail1.getDouble("nettotal");
							bean.setLbltotal(total+"");
							grndtotal+=total;
						}
						
						 
						


							 
							
							 bean.setLblordervaluewords(c.convertAmountToWords(grndtotal+""));
					    	 bean.setLblordervalue(grndtotal+"");
							


					    	 
				     ArrayList<String> arr =new ArrayList<String>();
				   	 Statement stmtgrid = conn.createStatement ();       
				     String temp="";  
				       String	strSqldetail="Select d.specno specid ,m.part_no productid,m.productname, u.unit,round(sum(d.qty),2) qty,"
				       		+ " round(d.amount,2) amount,round(sum(d.total),2) total,round(sum(d.discount),2) discount,round(sum(d.nettotal),2) nettotal,round(d.disper,2) disper"
				       		+ "    from my_inrd d "
	        			+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no    where d.rdocno='"+docno+"' group by d.stockid";
					
				      
					ResultSet rsdetail=stmtgrid.executeQuery(strSqldetail);
					
					int rowcount=1;
			
					while(rsdetail.next()){
						 
							 
							temp=rowcount+"::"+rsdetail.getString("productid")+"::"+rsdetail.getString("productname")+"::"+
							rsdetail.getString("unit")+"::"+rsdetail.getString("qty")+"::"+rsdetail.getString("amount")+"::"+
						    rsdetail.getString("total")+"::"+rsdetail.getString("disper")+"::"+rsdetail.getString("discount")+"::"+rsdetail.getString("nettotal") ;
							arr.add(temp);
							rowcount++;
			
							bean.setFirstarray(1);
						
				          }
				             
					request.setAttribute("details", arr);
					stmtgrid.close();
					
					
					
					
					


					
					
					
					
					 
				
				conn.close();



				
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return bean;
		
	
	}

	
	


}

