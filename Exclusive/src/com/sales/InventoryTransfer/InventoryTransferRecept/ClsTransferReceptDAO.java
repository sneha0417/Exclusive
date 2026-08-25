package com.sales.InventoryTransfer.InventoryTransferRecept;

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

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.sales.InventoryTransfer.InventoryTransferIssue.ClsTransferIssueBean;
import com.sales.Sales.salesInvoice.ClsSalesInvoiceBean;

public class ClsTransferReceptDAO {
	ClsTransferReceptBean bean= new ClsTransferReceptBean();
	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();
	public   JSONArray searchProduct(HttpSession session,String prodsearchtype,String rdoc,String locationfrmid) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 
			String sql="";
			int method=0;

 
				
/*				  sql="select bd.brandname,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(d.qty-d.out_qty) totqty,qty as oldqty,sum(d.qty-d.out_qty) qty,out_qty outqty,sum(d.qty-d.out_qty) as balqty,"
						+ "part_no,m.part_no productid,m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, KGPrice kgprice,"
						+ "amount unitprice,(sum(qty-out_qty)*amount) total,disper discper,discount dis,(sum(qty-out_qty)*amount) netotal from my_invtranissued d  left join my_main m on(d.psrno=m.doc_no) "
						+ "left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no where m.status=3 and d.rdocno in("+rdoc+")  group by psrno "
						+ "having sum(d.qty-d.out_qty)>0 order by psrno";
*/
			
	/*		  sql="select bd.brandname,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(d.qty-d.out_qty) totqty,qty as oldqty,sum(d.qty-d.out_qty) qty,out_qty outqty,sum(d.qty-d.out_qty) as balqty,"
						+ "part_no,m.part_no productid,m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, KGPrice kgprice,"
						+ "amount unitprice,(sum(qty-out_qty)*amount) total,disper discper,discount dis,(sum(qty-out_qty)*amount) netotal from my_invtranissued d  left join my_main m on(d.psrno=m.doc_no) "
						+ "left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no where m.status=3 and d.rdocno in("+rdoc+")  group by psrno "
						+ "having sum(d.qty-d.out_qty)>0 order by psrno";
			  */
			  
			  
				  sql="select  d.stockid stkid,bd.brandname,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(d.qty-d.out_qty) totqty,qty as oldqty,sum(d.qty-d.out_qty) qty,out_qty outqty,sum(d.qty-d.out_qty) as balqty,"
						+ "part_no,m.part_no productid,m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, KGPrice kgprice,"
						+ "amount unitprice,(sum(qty-out_qty)*amount) total,disper discper,discount dis,(sum(qty-out_qty)*amount) netotal from my_invtranissued d  left join my_main m on(d.psrno=m.doc_no) "
						+ "left join  my_unitm u on(d.unitid=u.doc_no) left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) where m.status=3 and d.rdocno in("+rdoc+")  group by d.stockid "
						+ "having sum(d.qty-d.out_qty)>0 order by d.prdid,d.stockid";
			
			System.out.println("----searchProduct-sql---"+sql);

				ResultSet resultSet = stmt.executeQuery (sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
		/*	}
*/



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

	public   JSONArray searchLocation(HttpSession session,String branchid,String searchtype) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			String brcid ="";
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 
			if(searchtype.equalsIgnoreCase("2")){
				brcid = session.getAttribute("BRANCHID").toString();
			}
			else if(searchtype.equalsIgnoreCase("1")){
				brcid =branchid;
			}

			//			System.out.println("==brcid===="+brcid);
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



	public   JSONArray searchBranch(HttpSession session,String branchid) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 

			String brcid = session.getAttribute("BRANCHID").toString(); 

			String sql="select doc_no,branchname branch from  my_brch b  where status=3 and doc_no not in("+brcid+")";
			System.out.println("-----searchBranch---"+sql);

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







	public  JSONArray reqSearchMasters(HttpSession session,String docnoss,String refnosss,String datess,String aa,String frmlocid,String tolocid) throws SQLException {

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
			conn = ClsConnection.getMyConnection();
			Statement stmtmain = conn.createStatement ();

			String pySql=("select * from (select sum(qty-d.out_qty) as qty,m.doc_no,m.rrefno as refno,m.voc_no,m.date,concat(b.branchname,':',l.loc_name) as details,0 as chk from "
					+ "my_invtranissuem m left join   my_brch b on(b.doc_no=m.frmbrhid) left join my_locm l on(l.doc_no=m.frmlocid) left join my_locm lt on(lt.doc_no=m.tolocid) left join my_invtranissued d "
					+ "on(d.rdocno=m.doc_no)  where m.status=3  and lt.doc_no="+tolocid+" and l.doc_no="+frmlocid+"  "+sqltest+"" 
					+ "group by m.doc_no) as a having qty>0" );
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



	public  JSONArray searchMaster(HttpSession session,String msdocno,String tobranch,String tolocation,String sdate,String reftype) throws SQLException {


		//		System.out.println("==searchMaster===");

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

		//  System.out.println("8888888888"+tobranch); 	
		String brid=session.getAttribute("BRANCHID").toString();



		java.sql.Date sqlStartDate=null;


		if(!(sdate.equalsIgnoreCase("undefined"))&&!(sdate.equalsIgnoreCase(""))&&!(sdate.equalsIgnoreCase("0")))
		{
			sqlStartDate = ClsCommon.changeStringtoSqlDate(sdate);
		}

		String sqltest="";
		if(!(msdocno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.voc_no like '%"+msdocno+"%'";
		}
		
		if(!(reftype.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.reftype like '%"+reftype+"%'";
		}

		if(!(tobranch.equalsIgnoreCase(""))){
			sqltest=sqltest+" and b.branchname like '%"+tobranch+"%'";
		}


		if(!(tolocation.equalsIgnoreCase(""))){
			sqltest=sqltest+" and l.loc_name like '%"+tolocation+"%'";
		}

		if(!(sqlStartDate==null)){
			sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
		} 



		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();

			String clssql= ("select coalesce(m.reftype,'') as reftype,coalesce(m.remarks,'') as remarks,m.doc_no,m.voc_no,m.date,m.tobrhid,m.tolocid,b.branchname as tobranch,l.loc_name as toloc,m.frmbrhid,m.frmlocid,fb.branchname as frmbranch,fl.loc_name as frmloc,amount,netamount,servamt,grantamt,coalesce(refno,'') refno,coalesce(rrefno,'') rrefno from my_invtranreceptm m"
					+ "  left join my_brch b on(m.frmbrhid=b.doc_no) left join my_locm l on(l.doc_no=m.tolocid) left join my_brch fb on(m.frmbrhid=fb.doc_no) left join my_locm fl on(fl.doc_no=m.frmlocid)   where m.status=3 and m.brhid="+session.getAttribute("BRANCHID").toString()+" "+sqltest+"");
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
					+ "my_invtranreceptd d  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) where m.status=3 and d.rdocno in("+docno+") group by psrno having sum(d.qty-d.out_qty)>0) as a ";
			//			System.out.println("===prdbranchLoad====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray prdGridReload(HttpSession session,String docno,String enqdoc) throws SQLException {


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


 
			
/*			sql=" select brandname,foc,stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,totqty, qty,qty as oldqty,outqty, "
					+ " balqty balqty,0 size,part_no,productid as proid,productid, "
			+ " productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,  dis, netotal from "
			+ " (select  brandname,foc,stkid,specid,psrno as doc_no,rdocno,psrno,(qtys-outqty)+qty as totqty, qty,qtys,outqty,(qtys-outqty)+qty as balqty,0 size, "
			+ " part_no,productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper,  dis, netotal from "
			+ " (select bd.brandname,d.foc,i.stockid as stkid,d.specno as specid,d.rdocno,m.doc_no psrno,sum(d.qty) as qty,dd.inblqty as qtys, "
			+ " dd.out_qty as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno, "
			+ " d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice,d.total,d.disper discper, d.discount dis,sum(d.nettotal) netotal "
			+ " from my_invtranreceptm ma left join my_invtranreceptd d on(ma.doc_no=d.rdocno) "
			+ " left join my_main m on(d.psrno=m.doc_no "
			+ " and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no) left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no and "
			+ " d.specno=at.mpsrno ) left join my_prddin i on (i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno and "
			+ " ma.brhid=i.brhid and d.stockid=i.stockid) "
			+ " left join(select sum(s.qty) inblqty,sum(s.out_qty) out_qty,s.stockid,s.psrno,s.prdid,s.specno from my_invtranissued s "
			+ "  where s.rdocno in("+enqdoc+") group by s.prdid) "
			+ "  dd on  (dd.psrno=d.psrno and dd.prdid=d.prdid and  dd.specno=d.specno) "
			+ " where m.status=3 and d.rdocno in("+docno+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by d.prdid "
			+ " order by i.date,d.prdid) as a ) as b ";*/
			
			sql="select  brandname,refstkid,stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,totqty, qty,qty as oldqty,outqty,"
					+ "balqty+qty balqty,0 size,part_no,productid as proid,productid,"
					+ "productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,  dis, netotal "
					+ "from(select  brandname,refstkid, stkid,specid,psrno as doc_no,rdocno,psrno,qtys as totqty, qty,qtys,outqty,delbalqty as balqty,0 size,part_no,"
					+ "productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper,  dis, netotal from (select bd.brandname,cc.delbalqty,i.refstockid refstkid,i.stockid as stkid,"
					+ "d.specno as specid,d.rdocno,m.doc_no psrno,sum(d.qty) as qty,sum(i.op_qty) as qtys,sum(i.out_qty+i.del_qty+i.rsv_qty) as outqty,m.part_no,"
					+ "m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice,d.total,"
					+ "d.disper discper, d.discount dis,d.nettotal netotal from my_invtranreceptm ma left join my_invtranreceptd d on(ma.doc_no=d.rdocno)left join "
					+ "my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no) left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at "
					+ "on(at.mpsrno=m.doc_no and d.specno=at.mpsrno ) left join my_prddin i "
					+ "on (i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno and ma.brhid=i.brhid and d.stockid=i.stockid   )  "
					+ "left join (select sum(qty-out_qty)  delbalqty, psrno,stockid, "
					+ "rdocno,specno,prdid from my_invtranissued where rdocno in("+enqdoc+")   group by  stockid) cc on cc.psrno=d.psrno and cc.prdid=d.prdid and  cc.specno=d.specno and d.refstockid=cc.stockid where m.status=3 and "
					+ "d.rdocno in("+docno+") and i.brhid='"+session.getAttribute("BRANCHID").toString()+"'   group by d.stockid  order by i.date,i.prdid,i.refstockid) as a ) as b ";
			

			System.out.println("===prdGridReload==3==="+sql);


			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}


	public JSONArray prdGridReload(HttpSession session,String docno) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {

			if(((docno.equalsIgnoreCase(""))||(docno.equalsIgnoreCase("undefined")))){

				docno="0";
			}

			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

	/*		String sql="select bd.brandname,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(d.qty-d.out_qty) totqty,qty as oldqty,sum(d.qty-d.out_qty) qty,out_qty outqty,sum(d.qty-d.out_qty) as balqty,"
					+ "part_no,m.part_no productid,m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, KGPrice kgprice,"
					+ "amount unitprice,(sum(qty-out_qty)*amount) total,disper discper,discount dis,(sum(qty-out_qty)*amount) netotal from my_invtranissued d  left join my_main m on(d.psrno=m.doc_no) "
					+ "left join  my_unitm u on(d.unitid=u.doc_no) left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) where m.status=3 and d.rdocno in("+docno+")  group by psrno "
					+ "having sum(d.qty-d.out_qty)>0 order by psrno";
*/
			
			String sql="select d.stockid stkid, bd.brandname,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(d.qty-d.out_qty) totqty,qty as oldqty,sum(d.qty-d.out_qty) qty,out_qty outqty,sum(d.qty-d.out_qty) as balqty,"
					+ "part_no,m.part_no productid,m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, KGPrice kgprice,"
					+ "amount unitprice,(sum(qty-out_qty)*amount) total,disper discper,discount dis,(sum(qty-out_qty)*amount) netotal from my_invtranissued d  left join my_main m on(d.psrno=m.doc_no) "
					+ "left join  my_unitm u on(d.unitid=u.doc_no) left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) where m.status=3 and d.rdocno in("+docno+")  group by d.stockid "
					+ "having sum(d.qty-d.out_qty)>0 order by d.prdid,d.stockid";
			
			System.out.println("===prdGridReload===2=="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


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
			//			System.out.println("===termsGridLoad====="+sql);
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
			//			System.out.println("===termsGridLoad====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}



	public   JSONArray qotgridreload(String doc) throws SQLException {

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

			/*			String chk="select method  from gl_prdconfig where field_nme='prosearch_stock'";
			ResultSet rs=stmt.executeQuery(chk); 
			if(rs.next())
			{

				method=rs.getInt("method");
			}


			if(method>0){
				sqlcond1="inner join my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno)";
				sqlcond2="group by i.stockid having sum((op_qty)-(i.out_qty+i.rsv_qty+i.del_qty))>0 order by i.date";
				sqlselect="i.stockid";
			}
			else{
				sqlselect="0";
				sqlcond1="";
				sqlcond2="group by psrno having sum(d.qty-d.out_qty)>0";
			}*/


			sqlcond1="inner join my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno)";
			sqlcond2="group by i.stockid having sum((op_qty)-(i.out_qty+i.rsv_qty+i.del_qty))>0 order by i.date";
			sqlselect="i.stockid";

			sql="select  stkid,specid,psrno as doc_no,rdocno,psrno,qty as totqty,(qty-outqty) qty,outqty,(qty-outqty) as balqty,0 size,part_no,productid,productname,unit,unitdocno from "
					+ "( select "+sqlselect+" as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(d.out_qty) as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno from "
					+ "my_sorderm ma left join my_sorderd d on(ma.doc_no=d.rdocno) inner join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "+sqlcond1+" where m.status=3 and d.rdocno in("+doc+")  "+sqlcond2+" ) as a group by psrno";


			//			System.out.println("=qotgridreload==="+sql);

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


	public int insert(String refno,java.sql.Date date,String reftype,int frmbrchid,int frmlocid,int tobrchid,int tolocid,String remarks,
			String prodamt,String nettotal,String servamt,String rrefno,String finalamt,String mode,String formcode,ArrayList prodarray,HttpSession session,HttpServletRequest request) throws SQLException{

		Connection conn=null;
		int docno=0;
		conn=ClsConnection.getMyConnection();

		try{



			conn.setAutoCommit(false);

			CallableStatement stmt = conn.prepareCall("{CALL invTransReceptDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmt.registerOutParameter(19, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(20, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(21, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			stmt.setString(2,refno);
			stmt.setInt(3, frmbrchid);
			stmt.setInt(4, frmlocid);
			stmt.setInt(5, Integer.parseInt(session.getAttribute("COMPANYID").toString()));
			stmt.setInt(6, tolocid);
			stmt.setString(7,remarks);
			stmt.setDouble(8,Double.parseDouble(prodamt));
			stmt.setDouble(9,Double.parseDouble(nettotal));
			stmt.setDouble(10, 0);
			stmt.setString(11, rrefno);
			stmt.setDouble(12, Double.parseDouble(finalamt));
			stmt.setString(13,mode);
			stmt.setString(14,formcode);
			stmt.setString(15, session.getAttribute("USERID").toString());
			stmt.setString(16, session.getAttribute("BRANCHID").toString());
			stmt.setString(17, session.getAttribute("COMPANYID").toString());
			stmt.setString(18, reftype);
			int val = stmt.executeUpdate();
			docno=stmt.getInt("docno");
			int vocno=stmt.getInt("vdocNo");
			int trno=stmt.getInt("strno");
			request.setAttribute("vdocNo", vocno);

			if(vocno>0){

				int prodet=0;
				int prodout=0;
				for(int i=0;i< prodarray.size();i++){

					String[] prod=((String) prodarray.get(i)).split("::");
					if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")))){




						if(docno>0)
						{

						/*	String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
							String specno=""+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"";
							String stkid=""+(prod[12].equalsIgnoreCase("undefined") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"";						 
							String  rqty=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
							double masterqty=Double.parseDouble(rqty);
							double foc=Double.parseDouble(""+(prod[14].trim().equalsIgnoreCase("undefined") || prod[14].trim().equalsIgnoreCase("NaN")|| prod[14].trim().equalsIgnoreCase("")|| prod[14].isEmpty()?0:prod[14].trim())+"");

							String sql2="insert into my_prddin(sr_no, psrno,prdid,specno,unit_price,cost_price,op_qty,locid,brhid,tr_no,dtype,date)values"
									+ "("+(i+1)+","
									+ "'"+prdid+"',"
									+ "'"+prdid+"',"
									+ "'"+specno+"',"
									+ "'"+Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"")+"',"
									+ "'"+Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"")+"',"
									+"'"+masterqty+"',"
									+"'"+tolocid+"','"+session.getAttribute("BRANCHID").toString()+"','"+trno+"','"+formcode+"','"+date+"')";

						  System.out.println("--sql2-----"+sql2);
							int resultSet10 = stmt.executeUpdate(sql2);
							if(resultSet10<=0)
							{
								conn.close();
								return 0;

							}

							Double NtWtKG=0.0;
							Double KGPrice=0.0;
							Double unitprice=0.0;
							Double total=0.0;
							Double discper=0.0;
							Double discount=0.0;
							Double netotal=0.0;
							int psrno=0;
							int stockid=0;
							double remstkqty=0;
							double outstkqty=0;
							double stkqty=0;
							double qty=0;
							double detqty=0;
							double focmasterqty=0.0;


							Statement selstmt=conn.createStatement();
							String sqlssel="select coalesce((max(stockid)),1) stockid from my_prddin  ";



							ResultSet selrss=selstmt.executeQuery(sqlssel);

							if(selrss.next())
							{
								stockid=selrss.getInt("stockid") ;




							}

							NtWtKG=Double.parseDouble(""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"");
							KGPrice=Double.parseDouble(""+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"");
							unitprice=Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"");
							total=Double.parseDouble(rqty)*unitprice;
							discper=Double.parseDouble(""+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"");
							discount=(total*discper)/100;
							netotal=total-discount;

							
							String sql="insert into my_invtranreceptd(tr_No,sr_no,rdocno,stockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal,foc)VALUES"
									+ " ("+trno+","+(i+1)+",'"+docno+"',"
									+ "'"+stockid+"',"
									+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
									+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
									+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
									+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
									+ "'"+rqty+"',"
									+ "'"+NtWtKG+"',"
									+ "'"+KGPrice+"',"
									+ "'"+unitprice+"',"
									+ "'"+total+"',"
									+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
									+ "'"+discount+"',"
									+ "'"+netotal+"',"
									+ "'"+foc+"')";

						 	 System.out.println("branchper--->>>>Sql"+sql);
							prodet = stmt.executeUpdate (sql);





							double balqty=0;
							int rdocno=0;
							double remqty=0;
							double out_qty=0;
							double qtys=0;
							int docno1=0;

							Statement stmt1=conn.createStatement();

							String strSql="select d.qty qty,sum((d.qty-d.out_qty)) balqty,d.doc_no,d.rdocno,d.out_qty out_qty,d.prdid  from my_invtranissuem m  left join "
									+ "my_invtranissued d on m.doc_no=d.rdocno where d.rdocno in ("+rrefno+") and  m.frmbrhid="+frmbrchid+" and d.prdid='"+prdid+"' group by d.doc_no having  sum(d.qty-d.out_qty)>0 "
									+ "order by m.date,d.doc_no";

						 						System.out.println("---strSql-----"+strSql);
							ResultSet rs = stmt1.executeQuery(strSql);


							while(rs.next()) {


								balqty=rs.getDouble("balqty");
								rdocno=rs.getInt("rdocno");
								out_qty=rs.getDouble("out_qty");

								docno1=rs.getInt("doc_no");
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


									String sqls="update my_invtranissued set out_qty="+masterqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno1+"";

									//									System.out.println("--1---sqls---"+sqls);


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


									String sqls="update my_invtranissued set out_qty="+balqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno1+"";	
									//									System.out.println("-2----sqls---"+sqls);

									stmt.executeUpdate(sqls);	

									//remqty=masterqty-qtys;



								}


							}  
*/
						
						
						
						
					 
								String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
								String specno=""+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"";
								String stkid=""+(prod[12].equalsIgnoreCase("undefined") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"";						 
								String  rqty=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
								double masterqty=Double.parseDouble(rqty);
								double foc=Double.parseDouble(""+(prod[14].trim().equalsIgnoreCase("undefined") || prod[14].trim().equalsIgnoreCase("NaN")|| prod[14].trim().equalsIgnoreCase("")|| prod[14].isEmpty()?0:prod[14].trim())+"");
								//int stockid=Integer.parseInt(stkid);
								/*int method=0;
								String chk="select method  from gl_prdconfig where field_nme='prosearch_stock'";
								ResultSet rsconfiq=stmt.executeQuery(chk); 
								if(rsconfiq.next())
								{

									method=rsconfiq.getInt("method");
								}*/

								double saveqty=0;
								double delnqty=0;
								double balstkqty=0;
								int psrno=0;
								int stockid=0;
								int refstockid=0;
								double remstkqty=0.0;
								double outstkqty=0.0;
								double stkqty=0.0;
								double inqty=0.0;
								double detqty=0.0;
								double prdinqty=0.0;
								double delqty=0.0;
								double unitprice=0.0;
								double costprice=0.0;
								Statement stmtstk=conn.createStatement();

								String stkSql="select d.rdocno,d.doc_no,d.stockid,d.psrno,d.specno,d.qty delqty,sum(d.qty) stkqty,sum(d.qty-d.out_qty) balstkqty,(d.out_qty) out_qty,sum(i.del_qty) as qty,m.date,i.unit_price,i.cost_price from my_invtranissuem m left join  my_invtranissued d on(d.rdocno=m.doc_no) left join my_prddin i on(d.stockid=i.stockid) "
										+ "where d.rdocno in("+rrefno+") and d.stockid="+stkid+"  and d.psrno='"+prdid+"' and d.specno='"+specno+"' and d.prdid='"+prdid+"' and m.brhid="+frmbrchid+" "
										+ "group by d.stockid,d.prdid,d.psrno having sum(qty-d.out_qty)>0 order by m.date,i.stockid";

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
									inqty=prdinqty-masterqty;
									/*String sqls="update my_prddin set del_qty="+inqty+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+"";
									System.out.println("--1---sqls---"+sqls);
									stmt.executeUpdate(sqls);*/
									
									 
									
									
								
									
									
									
									
						/*			String delsqls="update my_deld set out_qty="+delqty+" where rdocno="+rsstk.getInt("d.rdocno")+" and prdid="+prdid+" and  doc_no="+rsstk.getInt("d.doc_no")+"";
									System.out.println("--1---delsqls---"+delsqls);
									stmt.executeUpdate(delsqls);*/
									
									String prodinsql="insert into my_prddin(sr_no,TR_NO, dtype,refstockid,unit_price,cost_price,specno, psrno,op_qty,prdid,brhid,locid,date) Values"
											+ " ("+(i+1)+",'"+trno+"','"+formcode+"',"
											+ "'"+stockid+"',"
											+ ""+unitprice+","
											+ ""+costprice+","
											+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+masterqty+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+"'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"','"+tolocid+"','"+date+"')";

									System.out.println("prodinsql--->>>>Sql"+prodinsql);
									prodout = stmt.executeUpdate (prodinsql);

									String nstkSql="select stockid from  my_prddin where  refstockid="+stkid+" and tr_no="+trno+" and psrno='"+prdid+"' and specno='"+specno+"' and prdid='"+prdid+"' and brhid="+session.getAttribute("BRANCHID").toString()+"";

									System.out.println("=nstkSql="+nstkSql);

									ResultSet rsnstk = stmtstk.executeQuery(nstkSql);

									while(rsnstk.next()) {
										refstockid=rsnstk.getInt("stockid");
									}

									


									
								/*	String stkSql="select d.rdocno,d.doc_no,d.stockid,d.psrno,d.specno,d.qty delqty,sum(d.qty) stkqty,sum(d.qty-d.out_qty) balstkqty,(d.out_qty) out_qty,sum(i.del_qty) as qty,m.date,i.unit_price,i.cost_price from my_delm m left join  my_deld d on(d.rdocno=m.doc_no) left join my_prddin i on(d.stockid=i.stockid) "
											+ "where d.rdocno in("+refmasterdocno+") and d.stockid="+stkid+"  and d.psrno='"+prdid+"' and d.specno='"+specno+"' and d.prdid='"+prdid+"' and m.brhid="+session.getAttribute("BRANCHID").toString()+" "
											+ "group by d.stockid,d.prdid,d.psrno having sum(qty-d.out_qty)>0 order by m.date";*/
								
									
							 
									
									if(masterqty<=balstkqty)
									{
									 
										
										
										break;
									}

								
								}
									 
									double masterqty1=masterqty;
									double balqty1=0;
									int docno1=0;
									int rdocno1=0;
									double remqty1=0;
									double out_qty1=0;
									double qtys1=0;
									int dnstk=0;
									
									double secqty=0;
									
									Double NtWtKG=0.0;
									Double KGPrice=0.0;
									Double unitprice1=0.0;
									Double total=0.0;
									Double discper=0.0;
									Double discount=0.0;
									Double netotal=0.0;
									Statement stmt1=conn.createStatement();
									String strSql="select d.stockid,d.qty qty,sum((d.qty-d.out_qty)) balqty,d.doc_no,d.rdocno,d.out_qty out_qty,d.prdid  from my_invtranissuem m  left join "
											+ "my_invtranissued d on m.doc_no=d.rdocno where d.rdocno in ("+rrefno+") and d.stockid="+stkid+" and  m.brhid="+frmbrchid+" and d.specno='"+specno+"' and d.prdid='"+prdid+"' group by d.doc_no having  sum(d.qty-d.out_qty)>0 "
											+ "order by m.date,d.doc_no";
									System.out.println("--1-222222222222222--strSql---"+strSql);	
		      /*                    delqty=outstkqty+masterqty;
									
									
								 
										String delsqls="update my_deld set out_qty="+saveqty+" where rdocno="+rsstk.getInt("d.rdocno")+" and prdid="+prdid+" and  doc_no="+rsstk.getInt("d.doc_no")+"";
										System.out.println("--1---delsqls---"+delsqls);	
										*/
										
								 
									ResultSet rs = stmt1.executeQuery(strSql);


									while(rs.next()) {

									 
										
										

													balqty1=rs.getDouble("balqty");
													rdocno1=rs.getInt("rdocno");
													out_qty1=rs.getDouble("out_qty");
				
													docno1=rs.getInt("doc_no");
													qtys1=rs.getDouble("qty");
													dnstk=rs.getInt("stockid");
				
													System.out.println("---masterqty-----"+masterqty);	
													System.out.println("---balqty-----"+balqty1);	
													System.out.println("---out_qty-----"+out_qty1);	
													System.out.println("---qtys-----"+qtys1);
				
				
													if(remqty1>0)
													{
				
														masterqty1=remqty1;
													}
				
				
													if(masterqty1<=balqty1)
													{
														 
														NtWtKG=Double.parseDouble(""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"");
														KGPrice=Double.parseDouble(""+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"");
														unitprice1=Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"");
														total=Double.parseDouble(rqty)*unitprice1;
														discper=Double.parseDouble(""+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"");
														discount=(total*discper)/100;
														netotal=total-discount;
														
														String sql="insert into my_invtranreceptd(tr_No,sr_no,rdocno,stockid,refstockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal,foc,ref_row)VALUES"
																+ " ("+trno+","+(i+1)+",'"+docno+"',"
																+ "'"+refstockid+"',"
																+ "'"+stockid+"',"
																+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
																+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
																+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
																+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
																+ "'"+masterqty1+"',"
																+ "'"+NtWtKG+"',"
																+ "'"+KGPrice+"',"
																+ "'"+unitprice1+"',"
																+ "'"+total+"',"
																+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
																+ "'"+discount+"',"
																+ "'"+netotal+"',"
																+ "'"+foc+"','"+docno1+"')";

														
									/*					String sql="insert into my_delrd(tr_No,sr_no,rdocno,stockid,refstockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice,ref_row)VALUES"
																+ " ("+trno+","+(i+1)+",'"+deldocno+"',"
																+ "'"+refstockid+"',"
																+ "'"+stockid+"',"
																+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
																+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
																+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
																+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
																+ "'"+masterqty1+"',"
																+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
																+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[7].trim())+"','"+docno1+"')";
*/
														System.out.println("branchper--1->>>>Sql"+sql);
														prodet = stmt.executeUpdate (sql);
														 
														masterqty1=masterqty1+out_qty1;
				
				
													//	String sqls="update my_sorderd set out_qty="+masterqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+"";
														String delsqls="update my_invtranissued set out_qty="+masterqty1+" where rdocno="+rdocno1+" and prdid="+prdid+" and  doc_no="+docno1+" and stockid="+dnstk+" ";
														System.out.println("--1---sqls---"+delsqls);
				
				
														stmt.executeUpdate(delsqls);
														 
				
														
														
														
														
														
								
														
														break;
														
														
				
													}
													else if(masterqty1>balqty1)
													{
				
				
														secqty=balqty1;
														if(qtys1>=(masterqty1+out_qty1))
				
														{
															balqty1=masterqty1+out_qty1;	
															remqty1=qtys1-out_qty1;
				
														 	System.out.println("---remqty-1---"+remqty1);
														}
														else
														{
															remqty1=masterqty1-balqty1;
															balqty1=qtys1;
				
															 System.out.println("---remqty--2--"+remqty1);
														}
				
														String delsqls="update my_invtranissued set out_qty="+balqty1+" where rdocno="+rdocno1+" and prdid="+prdid+" and  doc_no="+docno1+" and stockid="+dnstk+" ";
													//	String sqls="update my_sorderd set out_qty="+balqty1+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+"";	
														System.out.println("-2----sqls---"+delsqls);
				
														stmt.executeUpdate(delsqls);	
														
														
														NtWtKG=Double.parseDouble(""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"");
														KGPrice=Double.parseDouble(""+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"");
														unitprice1=Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"");
														total=secqty*unitprice1;
														discper=Double.parseDouble(""+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"");
														discount=(total*discper)/100;
														netotal=total-discount;
														
														String sql="insert into my_invtranreceptd(tr_No,sr_no,rdocno,stockid,refstockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal,foc,ref_row)VALUES"
																+ " ("+trno+","+(i+1)+",'"+docno+"',"
																+ "'"+refstockid+"',"
																+ "'"+stockid+"',"
																+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
																+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
																+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
																+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
																+ "'"+secqty+"',"
																+ "'"+NtWtKG+"',"
																+ "'"+KGPrice+"',"
																+ "'"+unitprice1+"',"
																+ "'"+total+"',"
																+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
																+ "'"+discount+"',"
																+ "'"+netotal+"',"
																+ "'"+foc+"','"+docno1+"')";
/*
														String sql="insert into my_delrd(tr_No,sr_no,rdocno,stockid,refstockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice,ref_row)VALUES"
																+ " ("+trno+","+(i+1)+",'"+deldocno+"',"
																+ "'"+refstockid+"',"
																+ "'"+stockid+"',"
																+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
																+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
																+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
																+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
																+ "'"+secqty+"',"
																+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
																+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[7].trim())+"','"+docno1+"')";*/
														//remqty=masterqty-qtys;
														prodet = stmt.executeUpdate (sql);
														
														System.out.println("branchper--2->>>>Sql"+sql);
				
				
													}

		
								 
									

								             }




							 
						
						
						
						
						
						
						
						
						
						
						}
					}
				} //for
					
				
				
				
				
				
				
				
				
				
				
				
				
				
				
		/*	 	if(reftype.equalsIgnoreCase("IBT")){*/

							String finalamt1="0";
							Statement stmt2=conn.createStatement();
							String strSql="select sum(nettotal) nettotal from  my_invtranreceptd where rdocno="+docno+" ";
						 	System.out.println("---strSql-----"+strSql);
							ResultSet rsss = stmt2.executeQuery(strSql);
							if(rsss.next())
							{
								finalamt1=rsss.getString("nettotal");
							}
							 						
						for(int a=0;a<=3;a++){


							int acnos=0;
							String curris="1";
							double rates=1;
							String descs="Inventory Receipt "+formcode+"-"+""+vocno+""+":-Dated :- "+date; 
							String refdetails=""+formcode+""+vocno;
							String sql2="";
							String jvbranch="";
							int id=0;
							if(a==0){
								sql2="select  acno from my_account where codeno='STOCK ACCOUNT' ";
								jvbranch=session.getAttribute("BRANCHID").toString();
								id=1;
							}
							if(a==1){
								sql2="select  acno from my_account where codeno='GOODSTRANSIT' ";
								jvbranch=frmbrchid+"";
								id=-1;
							}

							if((!reftype.equalsIgnoreCase("IBT")) && (a==2)){
								
								//System.out.println("==========IN=============="+reftype);
								
								break ;	
								}
							//System.out.println("==========OUT=============="+reftype);	
							
							if(a==2){
								sql2="Select h.doc_no acno from my_head h INNER JOIN my_intr b ON(b.doc_no=h.doc_no) where h.doc_no=b.doc_no and "
										+ "((b.br1="+frmbrchid+" and  b.br2="+session.getAttribute("BRANCHID").toString()+") or (b.br1="+session.getAttribute("BRANCHID").toString()+" and  b.br2="+frmbrchid+")) ";
								id=-1;
								jvbranch=session.getAttribute("BRANCHID").toString();
							}

							if(a==3){
								sql2="Select h.doc_no acno from my_head h INNER JOIN my_intr b ON(b.doc_no=h.doc_no) where h.doc_no=b.doc_no and "
										+ "((b.br1="+frmbrchid+" and  b.br2="+session.getAttribute("BRANCHID").toString()+") or (b.br1="+session.getAttribute("BRANCHID").toString()+" and  b.br2="+frmbrchid+")) ";
								id=1;
								
								jvbranch=frmbrchid+"";
							}

							System.out.println("===sql2====="+sql2);


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

							double pricetottal=Double.parseDouble(finalamt1)*id;
							double ldramounts=0 ;     
							if(currencytype1.equalsIgnoreCase("D"))
							{

								ldramounts=pricetottal/rates ;  
							}

							else
							{
								ldramounts=pricetottal*rates ;  
							}

							String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
									+ "values('"+date+"','"+refdetails+"',"+docno+",'"+acnos+"','"+descs+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,"+id+",5,0,0,0,'"+rates+"',0,0,'"+formcode+"','"+jvbranch+"',"+trno+",3)";

							System.out.println("==sql11===="+sql11);

							int ss1 = stmt.executeUpdate(sql11);

							if(ss1<=0)
							{
								conn.close();
								return 0;

							}




						}

						}

/*
					}
*/
			 

			 




		  conn.commit();
		}
		catch(Exception e){
			docno=0;
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return docno;
	}



	public int update(String voc_no,int doc_no,String refno,java.sql.Date date,String reftype,int frmbrchid,int frmlocid,int tobrchid,int tolocid,String remarks,
			String prodamt,String nettotal,String servamt,String rrefno,String finalamt,String mode,String formcode,ArrayList prodarray,HttpSession session,HttpServletRequest request) throws SQLException{

		Connection conn=null;
		int docno=0;
		conn=ClsConnection.getMyConnection();

		try{



			conn.setAutoCommit(false);

			CallableStatement stmt = conn.prepareCall("{CALL invTransReceptDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			
			stmt.registerOutParameter(21, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			stmt.setString(2,refno);
			stmt.setInt(3, frmbrchid);
			stmt.setInt(4, frmlocid);
			stmt.setInt(5, Integer.parseInt(session.getAttribute("COMPANYID").toString()));
			stmt.setInt(6, tolocid);
			stmt.setString(7,remarks);
			stmt.setDouble(8,Double.parseDouble(prodamt));
			stmt.setDouble(9,Double.parseDouble(nettotal));
			stmt.setDouble(10, 0);
			stmt.setString(11, rrefno);
			stmt.setDouble(12, Double.parseDouble(finalamt));
			stmt.setString(13,mode);
			stmt.setString(14,formcode);
			stmt.setString(15, session.getAttribute("USERID").toString());
			stmt.setString(16, session.getAttribute("BRANCHID").toString());
			stmt.setString(17, session.getAttribute("COMPANYID").toString());
			stmt.setString(18, reftype);
			stmt.setInt(19,doc_no);
			stmt.setInt(20, Integer.parseInt(voc_no));
			int val = stmt.executeUpdate();
			docno=stmt.getInt("docno");
			int vocno=stmt.getInt("vdocNo");
			int trno=stmt.getInt("strno");
			request.setAttribute("vdocNo", vocno);

			if(vocno>0){
				int	updateid=0;
				int prodet=0;
				int prodout=0;
				for(int i=0;i< prodarray.size();i++){

					String[] prod=((String) prodarray.get(i)).split("::");
					if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined"))||(prod[0].equalsIgnoreCase("null")))){




						if(docno>0)
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

 
		  	
		    Statement stmnt=conn.createStatement();		
		    Statement stmnt1=conn.createStatement();
		    Statement stmnt3=conn.createStatement();
		    	String sql2="select ref_row,qty,prdid,tr_no from my_invtranreceptd where rdocno='"+docno+"'";
		    	System.out.println("-----sql2-----"+sql2);
		    	ResultSet rsstk111 = stmnt1.executeQuery(sql2);
		    	
		    	
		    	while(rsstk111.next())
		    	{
		    		ref_row=rsstk111.getInt("ref_row");
		    		delnqtys=rsstk111.getDouble("qty");
		    		prdidss=rsstk111.getInt("prdid");
		    		tmptrno=rsstk111.getInt("tr_no");
		    	
		  
		    		
		    	String sql3=" select out_qty   from my_invtranissued where doc_no='"+ref_row+"'";
		    	 System.out.println("-----sql3-----"+sql3);
		    	ResultSet rsstk1111 = stmnt.executeQuery(sql3);
		    	
		    	
		    	if(rsstk1111.next())
		    	{
		    		prdqty=rsstk1111.getDouble("out_qty");
			    	saveqty=prdqty-delnqtys;
			    	
			    	if(saveqty<0){
			    	saveqty=0;
			    	
			    	}
			    	
			      	String sql31="update my_invtranissued set out_qty="+saveqty+" where doc_no='"+ref_row+"'";
			    	 System.out.println("-----sql31-----"+sql31);
			    	 stmnt3.executeUpdate(sql31);
			    	 
			    	 
			    	 
			    	 
		    		
		    	}
		    	}

		    	 
		    	
							 
			     String dql31="delete from my_invtranreceptd where rdocno='"+docno+"'";
	    	 	  stmt.executeUpdate(dql31);
	    	 
 
						}
						
							
							
							
							
							
							/*if(i==0)
							{
							
						     String dql31="delete from my_invtranreceptd where rdocno='"+docno+"'";
				    	 	  stmt.executeUpdate(dql31);
				    	 
				   	 	 
				    	 	 String dql33= "delete from my_prddin where tr_no='"+trno+"' and dtype='"+formcode+"' ";
				    	 	 stmt.executeUpdate(dql33);
							}
						 
							
							
							
							String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
							String specno=""+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"";
							String stkid=""+(prod[12].equalsIgnoreCase("undefined") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"";						 
							String  rqty=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
							double masterqty=Double.parseDouble(rqty);
							double foc=Double.parseDouble(""+(prod[14].trim().equalsIgnoreCase("undefined") || prod[14].trim().equalsIgnoreCase("NaN")|| prod[14].trim().equalsIgnoreCase("")|| prod[14].isEmpty()?0:prod[14].trim())+"");
							String old=""+(prod[13].trim().equalsIgnoreCase("undefined") || prod[13].trim().equalsIgnoreCase("NaN")|| prod[13].trim().equalsIgnoreCase("")|| prod[13].isEmpty()?0:prod[13].trim())+"";
							String  outs=""+(prod[11].trim().equalsIgnoreCase("undefined") || prod[11].trim().equalsIgnoreCase("NaN")|| prod[11].trim().equalsIgnoreCase("")|| prod[11].isEmpty()?0:prod[11].trim())+"";
							
							
							 int pridforchk=Integer.parseInt(prdid);
					    	 
							  double totalqty=Double.parseDouble(outs)-Double.parseDouble(old);
				    		 
				    	
							
							
							
							String sql2="insert into my_prddin(sr_no, psrno,prdid,specno,unit_price,cost_price,op_qty,locid,brhid,tr_no,dtype,date)values"
									+ "("+(i+1)+","
									+ "'"+prdid+"',"
									+ "'"+prdid+"',"
									+ "'"+specno+"',"
									+ "'"+Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"")+"',"
									+ "'"+Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"")+"',"
									+"'"+masterqty+"',"
									+"'"+tolocid+"','"+session.getAttribute("BRANCHID").toString()+"','"+trno+"','"+formcode+"','"+date+"')";

							// System.out.println("--sql2-----"+sql2);
							int resultSet10 = stmt.executeUpdate(sql2);
							if(resultSet10<=0)
							{
								conn.close();
								return 0;

							}

							Double NtWtKG=0.0;
							Double KGPrice=0.0;
							Double unitprice=0.0;
							Double total=0.0;
							Double discper=0.0;
							Double discount=0.0;
							Double netotal=0.0;
							int psrno=0;
							int stockid=0;
							double remstkqty=0;
							double outstkqty=0;
							double stkqty=0;
							double qty=0;
							double detqty=0;
							double focmasterqty=0.0;


							Statement selstmt=conn.createStatement();
							String sqlssel="select coalesce((max(stockid)),1) stockid from my_prddin  ";



							ResultSet selrss=selstmt.executeQuery(sqlssel);

							if(selrss.next())
							{
								stockid=selrss.getInt("stockid") ;


							}

							NtWtKG=Double.parseDouble(""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"");
							KGPrice=Double.parseDouble(""+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"");
							unitprice=Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"");
							total=Double.parseDouble(rqty)*unitprice;
							discper=Double.parseDouble(""+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"");
							discount=(total*discper)/100;
							netotal=total-discount;


							String sql="insert into my_invtranreceptd(tr_No,sr_no,rdocno,stockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal,foc)VALUES"
									+ " ("+trno+","+(i+1)+",'"+docno+"',"
									+ "'"+stockid+"',"
									+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
									+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
									+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
									+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
									+ "'"+rqty+"',"
									+ "'"+NtWtKG+"',"
									+ "'"+KGPrice+"',"
									+ "'"+unitprice+"',"
									+ "'"+total+"',"
									+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
									+ "'"+discount+"',"
									+ "'"+netotal+"',"
									+ "'"+foc+"')";

							//							System.out.println("branchper--->>>>Sql"+sql);
							prodet = stmt.executeUpdate (sql);





							double balqty=0;
							int rdocno=0;
							double remqty=0;
							double out_qty=0;
							double qtys=0;
							int docno1=0;

							Statement stmt1=conn.createStatement();
							
							 if(pridforchk!=updateid)
				    		 {
				    		 
				 			String sqls="update  my_invtranissued set out_qty=0 where rdocno in ("+rrefno+") and prdid="+pridforchk+" ";
		  

                     System.out.println("-----"+sqls);
		    			   	
				 			stmt.executeUpdate(sqls);
		    				
		    				updateid=pridforchk;
				    		 
				    		 }
							
							 masterqty=totalqty+masterqty;
							

							String strSql="select d.qty qty,sum((d.qty-d.out_qty)) balqty,d.doc_no,d.rdocno,d.out_qty out_qty,d.prdid  from my_invtranissuem m  left join "
									+ "my_invtranissued d on m.doc_no=d.rdocno where d.rdocno in ("+rrefno+") and  m.frmbrhid="+frmbrchid+" and d.prdid='"+prdid+"' group by d.doc_no having  sum(d.qty-d.out_qty)>0 "
									+ "order by m.date,d.doc_no";

							//							System.out.println("---strSql-----"+strSql);
							ResultSet rs = stmt1.executeQuery(strSql);


							while(rs.next()) {


								balqty=rs.getDouble("balqty");
								rdocno=rs.getInt("rdocno");
								out_qty=rs.getDouble("out_qty");

								docno1=rs.getInt("doc_no");
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


									String sqls="update my_invtranissued set out_qty="+masterqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno1+"";

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


									String sqls="update my_invtranissued set out_qty="+balqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno1+"";	
								System.out.println("-2----sqls---"+sqls);

									stmt.executeUpdate(sqls);	

									//remqty=masterqty-qtys;



								}


							}  
						*/
						
						
						
						
							String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
							String specno=""+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"";
							String stkid=""+(prod[12].equalsIgnoreCase("undefined") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"";						 
							String  rqty=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
							double masterqty=Double.parseDouble(rqty);
							double foc=Double.parseDouble(""+(prod[14].trim().equalsIgnoreCase("undefined") || prod[14].trim().equalsIgnoreCase("NaN")|| prod[14].trim().equalsIgnoreCase("")|| prod[14].isEmpty()?0:prod[14].trim())+"");
							int oldStockid=0;
							Statement stmtstk1=conn.createStatement();
							String stkid1="select refstockid from my_prddin where stockid='"+stkid+"'  ";
							ResultSet rsstk1 = stmtstk1.executeQuery(stkid1);
							
							if(rsstk1.next())
							{
								
								oldStockid=rsstk1.getInt("refstockid");
							}

							
							double balstkqty=0;
							int psrno=0;
							int stockid=0;
							double remstkqty=0.0;
							double outstkqty=0.0;
							double stkqty=0.0;
							double inqty=0.0;
							double detqty=0.0;
							double prdinqty=0.0;
							double delqty=0.0;
							double unitprice=0.0;
							double costprice=0.0;
							Statement stmtstk=conn.createStatement();
					 
							String stkSql="select d.rdocno,d.doc_no,d.stockid,d.psrno,d.specno,sum(d.qty) stkqty,sum(d.qty-d.out_qty) balstkqty,(d.out_qty) out_qty,sum(i.del_qty) as qty,m.date,i.unit_price,i.cost_price from my_invtranissuem m left join  my_invtranissued d on(d.rdocno=m.doc_no) left join my_prddin i on(d.stockid=i.stockid) "
									+ "where d.rdocno in("+rrefno+") and d.stockid="+oldStockid+"  and d.psrno='"+prdid+"' and d.specno='"+specno+"' and d.prdid='"+prdid+"' and m.brhid="+frmbrchid+" "
									+ "group by d.stockid,d.prdid,d.psrno  order by m.date,i.stockid";

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
								inqty=prdinqty-masterqty;
					 
								
 

								String prodinsql="update my_prddin set date='"+date+"',op_qty="+masterqty+" where stockid="+stkid+" and psrno='"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"' and "
										+ "prdid='"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"' and "
												+ "brhid='"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"' and locid='"+tolocid+"'";
								
					 

								System.out.println("prodinsql--->>>>Sql"+prodinsql);
								prodout = stmt.executeUpdate (prodinsql);


								if(masterqty<=balstkqty)
								{
									break;
								}

							}



							double masterqty1=masterqty;
							double balqty1=0;
							int docno1=0;
							int rdocno1=0;
							double remqty1=0;
							double out_qty1=0;
							double qtys1=0;
							int dnstk=0;
							 	double secqty=0;
							 	
							 	
								Double NtWtKG=0.0;
								Double KGPrice=0.0;
								Double unitprice1=0.0;
								Double total=0.0;
								Double discper=0.0;
								Double discount=0.0;
								Double netotal=0.0;
							Statement stmt1=conn.createStatement();
							String strSql="select d.stockid,d.qty qty,sum((d.qty-d.out_qty)) balqty,d.doc_no,d.rdocno,d.out_qty out_qty,d.prdid  from my_invtranissuem m  left join "
									+ "my_invtranissued d on m.doc_no=d.rdocno where d.rdocno in ("+rrefno+") and d.stockid="+oldStockid+" and  m.brhid="+frmbrchid+" and d.specno='"+specno+"' and d.prdid='"+prdid+"' group by d.doc_no having  sum(d.qty-d.out_qty)>0 "
									+ "order by m.date,d.doc_no";
							
							
						 
							
							System.out.println("--1-222222222222222--strSql---"+strSql);	
      
								
						 
							ResultSet rs = stmt1.executeQuery(strSql);


							while(rs.next()) {

								
								
								

											balqty1=rs.getDouble("balqty");
											rdocno1=rs.getInt("rdocno");
											out_qty1=rs.getDouble("out_qty");
		
											docno1=rs.getInt("doc_no");
											qtys1=rs.getDouble("qty");
											dnstk=rs.getInt("stockid");
		
											System.out.println("---masterqty-----"+masterqty);	
											System.out.println("---balqty-----"+balqty1);	
											System.out.println("---out_qty-----"+out_qty1);	
											System.out.println("---qtys-----"+qtys1);
		
		
											if(remqty1>0)
											{
		
												masterqty1=remqty1;
											}
		
		
											if(masterqty1<=balqty1)
											{
												
												
												
												NtWtKG=Double.parseDouble(""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"");
												KGPrice=Double.parseDouble(""+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"");
												unitprice1=Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"");
												total=masterqty1*unitprice1;
												discper=Double.parseDouble(""+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"");
												discount=(total*discper)/100;
												netotal=total-discount;
												
												String sql="insert into my_invtranreceptd(tr_No,sr_no,rdocno,stockid,refstockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal,foc,ref_row)VALUES"
														+ " ("+trno+","+(i+1)+",'"+docno+"',"
														+ "'"+stkid+"',"
														+ "'"+oldStockid+"',"
														+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
														+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
														+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
														+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
														+ "'"+masterqty1+"',"
														+ "'"+NtWtKG+"',"
														+ "'"+KGPrice+"',"
														+ "'"+unitprice1+"',"
														+ "'"+total+"',"
														+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
														+ "'"+discount+"',"
														+ "'"+netotal+"',"
														+ "'"+foc+"','"+docno1+"')";

												
												
 											System.out.println("branchper--->>>>Sql"+sql);
												prodet = stmt.executeUpdate (sql);
												
												
												
												
												
												
												masterqty1=masterqty1+out_qty1;
		
		
											//	String sqls="update my_sorderd set out_qty="+masterqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+"";
												String delsqls="update my_invtranissued set out_qty="+masterqty1+" where rdocno="+rdocno1+" and prdid="+prdid+" and  doc_no="+docno1+" and stockid="+oldStockid+" ";
												System.out.println("--1---sqls---"+delsqls);
		
		
												stmt.executeUpdate(delsqls);
												 
		
												 
								
												break;
												
												
		
											}
											else if(masterqty1>balqty1)
											{
		
												  secqty=balqty1;
		
												if(qtys1>=(masterqty1+out_qty1))
		
												{
													balqty1=masterqty1+out_qty1;	
													remqty1=qtys1-out_qty1;
		
													//	System.out.println("---remqty-1---"+remqty);
												}
												else
												{
													remqty1=masterqty1-balqty1;
													balqty1=qtys1;
		
													//System.out.println("---remqty--2--"+remqty);
												}
		
												String delsqls="update my_invtranissued set out_qty="+balqty1+" where rdocno="+rdocno1+" and prdid="+prdid+" and  doc_no="+docno1+" and stockid="+dnstk+" ";
											//	String sqls="update my_sorderd set out_qty="+balqty1+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+"";	
												System.out.println("-2----sqls---"+delsqls);
		
												stmt.executeUpdate(delsqls);	
												
												NtWtKG=Double.parseDouble(""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"");
												KGPrice=Double.parseDouble(""+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"");
												unitprice1=Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"");
												total=secqty*unitprice1;
												discper=Double.parseDouble(""+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"");
												discount=(total*discper)/100;
												netotal=total-discount;
												String sql="insert into my_invtranreceptd(tr_No,sr_no,rdocno,stockid,refstockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal,foc,ref_row)VALUES"
														+ " ("+trno+","+(i+1)+",'"+docno+"',"
														+ "'"+stkid+"',"
														+ "'"+oldStockid+"',"
														+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
														+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
														+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
														+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
														+ "'"+secqty+"',"
														+ "'"+NtWtKG+"',"
														+ "'"+KGPrice+"',"
														+ "'"+unitprice1+"',"
														+ "'"+total+"',"
														+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
														+ "'"+discount+"',"
														+ "'"+netotal+"',"
														+ "'"+foc+"','"+docno1+"')";
												
												
												
											/*	String sql="insert into my_delrd(tr_No,sr_no,rdocno,stockid,refstockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice,ref_row)VALUES"
														+ " ("+trno+","+(i+1)+",'"+docno+"',"
														+ "'"+stkid+"',"
														+ "'"+oldStockid+"',"
														+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
														+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
														+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
														+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
														+ "'"+secqty+"',"
														+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
														+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[7].trim())+"','"+docno1+"')";
												//remqty=masterqty-qtys;
*/												prodet = stmt.executeUpdate (sql);
		
		
											}


						 
							

						             }

						
						
						}
						}
				}
					
					/*	if(reftype.equalsIgnoreCase("IBT")){*/
							 String dql33= "delete from my_jvtran where tr_no='"+trno+"' and dtype='"+formcode+"'  ";
				    	 	 stmt.executeUpdate(dql33);

				    	 	 
				    	 	String finalamt1="0";
							Statement stmt2=conn.createStatement();
							String strSql="select sum(nettotal) nettotal from  my_invtranreceptd where rdocno="+docno+" ";
						 	System.out.println("---strSql-----"+strSql);
							ResultSet rsss = stmt2.executeQuery(strSql);
							if(rsss.next())
							{
								finalamt1=rsss.getString("nettotal");
							}
								
				    	 	 
				    	 	 
						for(int a=0;a<=3;a++){


							int acnos=0;
							String curris="1";
							double rates=1;
							String descs="Inventory Receipt "+formcode+"-"+""+vocno+""+":-Dated :- "+date; 
							String refdetails=""+formcode+""+vocno;
							String sql2="";
							String jvbranch="";
							int id=0;
							if(a==0){
								sql2="select  acno from my_account where codeno='STOCK ACCOUNT' ";
								jvbranch=session.getAttribute("BRANCHID").toString();
								id=1;
							}
							if(a==1){
								sql2="select  acno from my_account where codeno='GOODSTRANSIT' ";
								jvbranch=frmbrchid+"";
								id=-1;
							}

							
							if((!reftype.equalsIgnoreCase("IBT")) && (a==2)){
								
							//	System.out.println("==========IN=============="+reftype);
								
								break ;	
								}
							//System.out.println("==========OUT=============="+reftype);	
							if(a==2){
								sql2="Select h.doc_no acno from my_head h INNER JOIN my_intr b ON(b.doc_no=h.doc_no) where h.doc_no=b.doc_no and "
										+ "((b.br1="+frmbrchid+" and  b.br2="+session.getAttribute("BRANCHID").toString()+") or (b.br1="+session.getAttribute("BRANCHID").toString()+" and  b.br2="+frmbrchid+")) ";
								id=-1;
								jvbranch=session.getAttribute("BRANCHID").toString();
							}

							if(a==3){
								sql2="Select h.doc_no acno from my_head h INNER JOIN my_intr b ON(b.doc_no=h.doc_no) where h.doc_no=b.doc_no and "
										+ "((b.br1="+frmbrchid+" and  b.br2="+session.getAttribute("BRANCHID").toString()+") or (b.br1="+session.getAttribute("BRANCHID").toString()+" and  b.br2="+frmbrchid+")) ";
								id=1;
							
								jvbranch=frmbrchid+"";
							}

							//System.out.println("===sql2====="+sql2);


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

							double pricetottal=Double.parseDouble(finalamt1)*id;
							double ldramounts=0 ;     
							if(currencytype1.equalsIgnoreCase("D"))
							{

								ldramounts=pricetottal/rates ;  
							}

							else
							{
								ldramounts=pricetottal*rates ;  
							}

							String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
									+ "values('"+date+"','"+refdetails+"',"+docno+",'"+acnos+"','"+descs+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,"+id+",5,0,0,0,'"+rates+"',0,0,'"+formcode+"','"+jvbranch+"',"+trno+",3)";

							System.out.println("==sql11===="+sql11);

							int ss1 = stmt.executeUpdate(sql11);

							if(ss1<=0)
							{
								conn.close();
								return 0;

							}




						}

						}


					/*}*/

			 

		 



System.out.println("====commit====");

			conn.commit();
		}
		catch(Exception e){
			docno=0;
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return docno;
	}

	public int delete(String voc_no,int doc_no,java.sql.Date date,String refno,String pricegroup,String curr,String currate,int salesid,int clientid,String rrefno,String rreftype,String locid,String desc,
			String prodamt,String descount,String nettotal,String servamt,String roundof,String finalamt,String mode,String formcode,ArrayList prodarray,ArrayList termsarray,ArrayList servarray,HttpSession session,HttpServletRequest request,String qotmasterdocno,String descper) throws SQLException{

		Connection conn=null;
		int deldocno=0;
		conn=ClsConnection.getMyConnection();

		try{

			conn.setAutoCommit(false);

			CallableStatement stmt = conn.prepareCall("{CALL deliveryNoteDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");


			stmt.setDate(1,date);
			stmt.setString(2,refno);
			stmt.setInt(3, clientid);
			stmt.setInt(4, Integer.parseInt(curr));
			stmt.setDouble(5, Double.parseDouble(currate));
			stmt.setInt(6, salesid);
			stmt.setString(7,rreftype);
			stmt.setString(8,rrefno);
			stmt.setString(9,locid);
			stmt.setString(10,desc);
			stmt.setDouble(11,Double.parseDouble(prodamt));
			stmt.setDouble(12,Double.parseDouble(descount));
			stmt.setDouble(13,Double.parseDouble(nettotal));
			stmt.setString(14,mode);
			stmt.setString(15,formcode);
			stmt.setString(16, session.getAttribute("USERID").toString());
			stmt.setString(17, session.getAttribute("BRANCHID").toString());
			stmt.setString(18, session.getAttribute("COMPANYID").toString());
			stmt.setDouble(19, Double.parseDouble(descper));
			stmt.setDouble(20, Double.parseDouble(servamt));
			stmt.setDouble(21, Double.parseDouble(roundof));
			stmt.setDouble(22, Double.parseDouble(finalamt));
			stmt.setInt(23, Integer.parseInt(pricegroup));
			stmt.setInt(24,doc_no);
			stmt.setInt(25,Integer.parseInt(voc_no));
			int val = stmt.executeUpdate();
			deldocno=stmt.getInt("deldocno");
			int vocno=stmt.getInt("vdocNo");	
			request.setAttribute("vdocNo", vocno);
			//System.out.println("===vocno====="+vocno);
			/*			if(vocno>0){

				int prodet=0;
				for(int i=0;i< prodarray.size();i++){

					String[] prod=((String) prodarray.get(i)).split("::");
					if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")))){




						String sql="insert into my_invtranreceptd(sr_no,rdocno,stockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal)VALUES"
								+ " ("+(i+1)+",'"+deldocno+"',"
								+ "'"+(prod[12].equalsIgnoreCase("undefined")|| prod[12].equalsIgnoreCase("null") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"',"
								+ "'"+(prod[10].equalsIgnoreCase("undefined")|| prod[10].equalsIgnoreCase("null") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
								+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("null")|| prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
								+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("null")|| prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
								+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("null")|| prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
								+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("null")|| prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
								+ "'"+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("null")|| prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"',"
								+ "'"+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("null")|| prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"',"
								+ "'"+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("null")|| prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"',"
								+ "'"+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("null")|| prod[6].trim().equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
								+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("null")|| prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
								+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("null")|| prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"',"
								+ "'"+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("null")|| prod[9].trim().equalsIgnoreCase("") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].isEmpty()?0:prod[9].trim())+"')";


						System.out.println("branchper--->>>>Sql"+sql);
						prodet = stmt.executeUpdate (sql);


						if(prodet>0)
						{

							String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";						     							  
							//String entrytype=""+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].trim().equalsIgnoreCase("")|| prod[9].isEmpty()?0:prod[9].trim())+"";						 
							String  rqty=""+(prod[2].trim().equalsIgnoreCase("undefined")|| prod[2].trim().equalsIgnoreCase("null") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
							double masterqty=Double.parseDouble(rqty);

							if(rreftype.equalsIgnoreCase("SQOT"))
							{

								double balqty=0;
								int docno=0;
								int rdocno=0;
								double remqty=0;
								double out_qty=0;
								double qty=0;

								Statement stmt1=conn.createStatement();

								String strSql="select d.qty qty,sum((d.qty-d.out_qty)) balqty,d.doc_no,d.rdocno,d.out_qty out_qty,d.prdid  from my_invtranreceptm m  left join "
										+ "my_invtranreceptd d on m.doc_no=d.rdocno where d.rdocno in ("+qotmasterdocno+") and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and d.prdid='"+prdid+"' group by d.doc_no having  sum(d.qty-d.out_qty)>0 "
										+ "order by m.date,d.doc_no";

								System.out.println("---strSql-----"+strSql);
								ResultSet rs = stmt1.executeQuery(strSql);


								while(rs.next()) {


									balqty=rs.getDouble("balqty");
									rdocno=rs.getInt("rdocno");
									out_qty=rs.getDouble("out_qty");

									docno=rs.getInt("doc_no");
									qty=rs.getDouble("qty");

									System.out.println("---masterqty-----"+masterqty);	

									System.out.println("---balqty-----"+balqty);	

									System.out.println("---out_qty-----"+out_qty);	
									System.out.println("---qty-----"+qty);


									if(remqty>0)
									{

										masterqty=remqty;
									}


									if(masterqty<=balqty)
									{
										masterqty=masterqty+out_qty;


										String sqls="update my_qotd set out_qty="+masterqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+"";

										System.out.println("--1---sqls---"+sqls);


										stmt.executeUpdate(sqls);
										break;


									}
									else if(masterqty>balqty)
									{



										if(qty>=(masterqty+out_qty))

										{
											balqty=masterqty+out_qty;	
											remqty=qty-out_qty;

											//	System.out.println("---remqty-1---"+remqty);
										}
										else
										{
											remqty=masterqty-balqty;
											balqty=qty;

											//System.out.println("---remqty--2--"+remqty);
										}


										String sqls="update my_qotd set out_qty="+balqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+"";	
										System.out.println("-2----sqls---"+sqls);

										stmt.executeUpdate(sqls);	

										//remqty=masterqty-qty;



									}


								}  







							}



						}

					}

				}


				for(int i=0;i< servarray.size();i++){

					String[] sorderarray=((String) servarray.get(i)).split("::");
					if(!(sorderarray[1].trim().equalsIgnoreCase("undefined")|| sorderarray[1].trim().equalsIgnoreCase("NaN")||sorderarray[1].trim().equalsIgnoreCase("")|| sorderarray[1].isEmpty()))
					{

						String sql="INSERT INTO my_deldser(srno,qty,desc1,unitprice,total,discount,nettotal,brhid,rdocno)VALUES"
								+ " ("+(i+1)+","
								+ "'"+(sorderarray[1].trim().equalsIgnoreCase("undefined") || sorderarray[1].trim().equalsIgnoreCase("NaN")|| sorderarray[1].trim().equalsIgnoreCase("")|| sorderarray[1].isEmpty()?0:sorderarray[1].trim())+"',"
								+ "'"+(sorderarray[2].trim().equalsIgnoreCase("undefined") || sorderarray[2].trim().equalsIgnoreCase("NaN")|| sorderarray[2].trim().equalsIgnoreCase("")|| sorderarray[2].isEmpty()?0:sorderarray[2].trim())+"',"
								+ "'"+(sorderarray[3].trim().equalsIgnoreCase("undefined") || sorderarray[3].trim().equalsIgnoreCase("NaN")||sorderarray[3].trim().equalsIgnoreCase("")|| sorderarray[3].isEmpty()?0:sorderarray[3].trim())+"',"
								+ "'"+(sorderarray[4].trim().equalsIgnoreCase("undefined") || sorderarray[4].trim().equalsIgnoreCase("NaN")||sorderarray[4].trim().equalsIgnoreCase("")|| sorderarray[4].isEmpty()?0:sorderarray[4].trim())+"',"
								+ "'"+(sorderarray[5].trim().equalsIgnoreCase("undefined") || sorderarray[5].trim().equalsIgnoreCase("NaN")||sorderarray[5].trim().equalsIgnoreCase("")|| sorderarray[5].isEmpty()?0:sorderarray[5].trim())+"',"
								+ "'"+(sorderarray[6].trim().equalsIgnoreCase("undefined") || sorderarray[6].trim().equalsIgnoreCase("NaN")||sorderarray[6].trim().equalsIgnoreCase("")|| sorderarray[6].isEmpty()?0:sorderarray[6].trim())+"',"
								+ "'"+session.getAttribute("BRANCHID").toString()+"',"
								+"'"+deldocno+"')";

						int resultSet2 = stmt.executeUpdate(sql);

					}	    

				}


				int termsdet=0;

				System.out.println("termsarray.size()==="+termsarray.size());

				for(int i=0;i< termsarray.size();i++){


					String[] terms=((String) termsarray.get(i)).split("::");

					if(!((terms[0].equalsIgnoreCase("0"))||(terms[0].equalsIgnoreCase("undefined")))){




						String termsql="insert into my_trterms(rdocno, termsid, conditions, status, dtype)VALUES"
								+ " ('"+deldocno+"',"
								+ "'"+(terms[0].equalsIgnoreCase("undefined") || terms[0].equalsIgnoreCase("") || terms[0].trim().equalsIgnoreCase("NaN")|| terms[0].isEmpty()?0:terms[0].trim())+"',"
								+ "'"+(terms[3].equalsIgnoreCase("undefined") || terms[3].equalsIgnoreCase("") || terms[3].trim().equalsIgnoreCase("NaN")|| terms[3].isEmpty()?0:terms[3].trim())+"',"
								+ "'3',"
								+ "'"+formcode+"')";


						System.out.println("termsdet--->>>>Sql"+termsql);
						termsdet = stmt.executeUpdate (termsql);

					}
				}


			}*/



			conn.commit();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return deldocno;
	}


	public   JSONArray reloadserviceGrid(String docno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh1 = conn.createStatement ();
			String pySql=(" select srno,desc1 description,unitprice,qty,total,discount,nettotal from my_deldser  where rdocno='"+docno+"' ");
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




	public  ClsTransferReceptBean getViewDetails(String rrefno,int branchid) throws SQLException{


		Connection conn =null;
		try {
			conn= ClsConnection.getMyConnection();
			
			Statement stmt = conn.createStatement ();
			String refdocno="";
			int i=0;
			Statement stmt1  = conn.createStatement ();	
			String sqlss="select voc_no from  my_invtranissuem where doc_no in ("+rrefno+") ";
			//System.out.println("==sqlss==="+sqlss);

			ResultSet resultSet1= stmt1.executeQuery(sqlss);


			while (resultSet1.next()) {

				if(i==0)
				{
					refdocno=resultSet1.getString("voc_no")+",";	
				}
				else
				{
					refdocno=refdocno+resultSet1.getString("voc_no")+",";
				}


				i++;



			}

			if(refdocno.endsWith(","))
			{
				refdocno = refdocno.substring(0,refdocno.length() - 1);
			}

			bean.setRrefno(refdocno);
			 




		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		conn.close();
		return bean;
	}
	 public     ClsTransferReceptBean getPrint(int docno, HttpServletRequest request) throws SQLException {
		 ClsTransferReceptBean bean = new ClsTransferReceptBean();
		  Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtprint = conn.createStatement ();
 
/*				String resql=("select if(m.reftype='IBT','Branch Trasfer','Location Transfer') reftype,coalesce(m.remarks,'') as remarks,m.doc_no,m.voc_no,date_format(m.date,'%d-%m-%Y') date,m.tobrhid,m.tolocid,b.branchname as tobranch,l.loc_name as toloc,m.frmbrhid,m.frmlocid,fb.branchname as frmbranch,fl.loc_name as frmloc,amount,netamount,servamt,grantamt,coalesce(refno,'') refno from my_invtranreceptm m"
						+ "  left join my_brch b on(m.tobrhid=b.doc_no) left join my_locm l on(l.doc_no=m.tolocid) left join my_brch fb on(m.frmbrhid=fb.doc_no) left join my_locm fl on(fl.doc_no=m.frmlocid) where m.status=3 and m.doc_no='"+docno+"'");
				*/
				
				String resql=("select if(m.reftype='IBT','Branch Trasfer','Location Transfer')  reftype,coalesce(m.remarks,'') as remarks,m.doc_no,m.voc_no,date_format(m.date,'%d-%m-%Y') date,m.tobrhid,m.tolocid,b.branchname as tobranch,l.loc_name as toloc,m.frmbrhid,m.frmlocid,fb.branchname as frmbranch,fl.loc_name as frmloc,amount,netamount,servamt,grantamt,coalesce(refno,'') refno,coalesce(rrefno,'') rrefno from my_invtranreceptm m"
						+ "  left join my_brch b on(m.frmbrhid=b.doc_no) left join my_locm l on(l.doc_no=m.tolocid) left join my_brch fb on(m.frmbrhid=fb.doc_no) left join my_locm fl on(fl.doc_no=m.frmlocid)   where m.status=3 and m.doc_no='"+docno+"'");
				
				
				//System.out.println("======resql==="+resql);
				
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
		 
			       while(pintrs.next()){
			    	 
			   
			    	    bean.setLbldocno(pintrs.getString("voc_no"));
			    	    bean.setLbldate(pintrs.getString("date"));
			    	    bean.setLblrefno(pintrs.getString("refno"));
			    	    bean.setLblreftype(pintrs.getString("reftype"));
			    	    bean.setLblbranchfrom(pintrs.getString("frmbranch"));
			    	    
			    	    
			    	    bean.setLbllocationfrom(pintrs.getString("frmloc"));
			    	  
			    	    bean.setLbllocationto(pintrs.getString("toloc"));
			    	    
			    	    bean.setLblremarks(pintrs.getString("remarks")); 
			    	  
			    	    
			   
			    	  
			       }
				

				stmtprint.close();
 
				
				 Statement stmt10 = conn.createStatement ();
				    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from my_invtranreceptm r  "
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
				       
				       ArrayList<String> arr =new ArrayList<String>();
				   	Statement stmtgrid = conn.createStatement ();       
				     String temp="";  
				       String	strSqldetail="Select d.specno specid ,m.part_no productid,m.productname, u.unit,round(sum(d.qty),2) qty  from my_invtranreceptd d"
	        			+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no    where rdocno='"+docno+"'  group by d.prdid";
					
			
					ResultSet rsdetail=stmtgrid.executeQuery(strSqldetail);
					
					int rowcount=1;
			
					while(rsdetail.next()){

							 
							 
							temp=rowcount+"::"+rsdetail.getString("productid")+"::"+rsdetail.getString("productname")+"::"+rsdetail.getString("unit")+"::"+rsdetail.getString("qty") ;

							arr.add(temp);
							rowcount++;
			
					
						
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