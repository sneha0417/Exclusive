package com.sales.InventoryTransfer.InventoryTransferIssue;

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
//import com.dashboard.accounts.individualageing.ClsIndividualAgeing;
import com.sales.marketing.salesenquiry.ClsSalesEnquiryBean;

public class ClsTransferIssueDAO {
	ClsTransferIssueBean bean= new ClsTransferIssueBean();
	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();
	public   JSONArray searchProduct(HttpSession session,String prodsearchtype,String rdoc,String frmlocation) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 
			String sql="";
			int method=0;

/*
			if(prodsearchtype.equals("0")){
*/

				sql="select bd.brandname,at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,'' qty,sum(i.out_qty) outqty, "
						+ " sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty,sum(i.op_qty) as totqty,i.stockid as stkid,i.cost_price unitprice   "
						+ "from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
						+ " inner join my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no "
						+ "and i.specno=at.mspecno and i.brhid='"+session.getAttribute("BRANCHID").toString()+"' ) where m.status=3 and i.brhid='"+session.getAttribute("BRANCHID").toString()+"' "
								+ " and i.locid='"+frmlocation+"' "
								+ "group by i.prdid having sum(op_qty-(i.out_qty+i.rsv_qty+i.del_qty))>0 order by i.date ";
			/*}
			else{

				sql="select  stkid,specid,psrno as doc_no,rdocno,psrno,qty as totqty,(qty-outqty) qty,outqty,(qty-outqty) as balqty,0 size,part_no,productid,productname,unit,unitdocno, unitprice from "
						+ "( select i.stockid as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(i.op_qty) as qty,sum(i.out_qty+i.del_qty+i.rsv_qty) as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,i.unit_price unitprice from "
						+ "my_sorderm ma left join my_sorderd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) inner join my_prddin i on(i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno and ma.brhid=i.brhid) where m.status=3 and d.rdocno in("+rdoc+") and d.clstatus=0 and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by i.prdid having sum((op_qty)-(i.out_qty+i.rsv_qty+i.del_qty))>0 order by i.date ) as a ";

			}*/

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

	public   JSONArray searchLocation(HttpSession session,String branchid,String cmbreftype,String frmlocation) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 

			String brcid = session.getAttribute("BRANCHID").toString(); 

			
			String sqltest="";
			
			if(cmbreftype.equalsIgnoreCase("ILT"))
			{
				sqltest=" and m.doc_no not in("+frmlocation+") ";
			}
		 
			
			
			String sql="select m.doc_no,loc_name as location,branchname as branch from my_locm m left join my_brch b on(b.doc_no=m.brhid) where m.status=3 and brhid="+branchid+" "+sqltest;
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

			String sql="select doc_no,branchname branch from  my_brch b  where status=3 and doc_no not in("+branchid+")";
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







	public  JSONArray reqSearchMasters(HttpSession session,String docnoss,String refnosss,String datess,String aa,String clientid) throws SQLException {

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

			String pySql=("select * from (select sum(qty-d.out_qty) as qty,m.doc_no,m.rrefno as refno,m.voc_no,m.date,ac.refname as client,0 as chk from my_sorderm m left join   my_acbook ac on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_sorderd d on(d.rdocno=m.doc_no)  where m.status=3 and m.cldocno="+clientid+"  and m.brhid='"+brcid+"' "+sqltest+" group by m.doc_no) as a having qty>0" );
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

			String clssql= ("select reftype,coalesce(m.remarks,'') as remarks,m.doc_no,m.voc_no,m.date,m.tobrhid,m.tolocid,b.branchname as tobranch,"
					+ " l.loc_name as toloc,m.frmbrhid,m.frmlocid,fb.branchname as frmbranch,fl.loc_name as frmloc,amount,netamount,servamt,grantamt,coalesce(refno,'') refno from my_invtranissuem m"
					+ "  left join my_brch b on(m.tobrhid=b.doc_no) left join my_locm l on(l.doc_no=m.tolocid) "
					+ "left join my_brch fb on(m.frmbrhid=fb.doc_no) left join my_locm fl on(fl.doc_no=m.frmlocid) where m.status=3 and m.brhid='"+brid+"' "+sqltest+"");
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
					+ "my_invtranissued d  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) where m.status=3 and d.rdocno in("+docno+") group by psrno having sum(d.qty-d.out_qty)>0) as a ";
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


			sql="select brandname,0 foc,stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,totqty, qty,qty as oldqty,outqty,"
					+ " (qty+balqty)  as balqty,0 size,part_no,productid as proid,productid,"
					+ "productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,  dis, netotal "
					+ "from(select  brandname,foc,stkid,specid,psrno as doc_no,rdocno,psrno,qtys as totqty, qty,qtys,outqty,(qtys-outqty) as balqty,0 size,part_no,"
					+ "productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper,  dis, netotal from (select bd.brandname,d.foc,i.stockid as stkid,"
					+ "d.specno as specid,d.rdocno,m.doc_no psrno,sum(d.qty) as qty,coalesce(ii.totalqty,0) as qtys,coalesce(ii.outqty,0) as outqty,m.part_no,"
					+ "m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice,d.total,"
					+ "d.disper discper, d.discount dis,sum(d.nettotal) netotal from my_invtranissuem ma left join my_invtranissued d on(ma.doc_no=d.rdocno)left join "
					+ "my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no)left join my_prodattrib at "
					+ "on(at.mpsrno=m.doc_no and d.specno=at.mpsrno ) left join  my_brand bd on m.brandid=bd.doc_no left join my_prddin i "
					+ "on (i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno and ma.brhid=i.brhid and d.stockid=i.stockid)"
					+ "left join( select date,sum(op_qty) totalqty,sum(op_qty)-sum(out_qty+del_qty+rsv_qty) balqty,stockid, "
					+ " sum(out_qty+del_qty+rsv_qty) outqty,prdid,psrno,specno,brhid,locid  from my_prddin where 1=1 group by psrno,locid,brhid) ii on " 
					 + "(ii.psrno=i.psrno and ii.prdid=i.prdid and i.specno=ii.specno and ma.brhid=ii.brhid and ii.locid=i.locid) where m.status=3 and "
					+ "d.rdocno in("+docno+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by d.prdid  order by i.date) as a ) as b ";

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

			String sql="select bd.brandname,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,qty totqty,qty as oldqty,sum(d.qty-d.out_qty) qty,out_qty outqty,qty as balqty,"
					+ "part_no,m.part_no productid,m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, KGPrice kgprice,"
					+ "amount unitprice, total,disper discper,discount dis,nettotal netotal from my_sorderd d  left join my_main m on(d.psrno=m.doc_no) "
					+ "left join  my_unitm u on(d.unitid=u.doc_no) left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) where m.status=3 and d.rdocno in("+docno+") and d.clstatus=0 group by psrno "
					+ "having sum(d.qty-d.out_qty)>0";

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


	public int insert(String refno,java.sql.Date date,String reftype,int frmbrchid,int frmlocid,int tobrchid,int tolocid,String remarks,
			String prodamt,String nettotal,String servamt,String roundof,String finalamt,String mode,String formcode,ArrayList prodarray,HttpSession session,HttpServletRequest request) throws SQLException{

		Connection conn=null;
		int docno=0;
		conn=ClsConnection.getMyConnection();

		try{

			System.out.println("==frmbrchid==="+frmbrchid+"==frmlocid=="+frmlocid);

			conn.setAutoCommit(false);

			CallableStatement stmt = conn.prepareCall("{CALL invTransIssueDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmt.registerOutParameter(19, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(20, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(21, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			stmt.setString(2,refno);
			stmt.setInt(3, frmbrchid);
			stmt.setInt(4, frmlocid);
			stmt.setInt(5, tobrchid);
			stmt.setInt(6, tolocid);
			stmt.setString(7,remarks);
			stmt.setDouble(8,Double.parseDouble(prodamt));
			stmt.setDouble(9,Double.parseDouble(nettotal));
			stmt.setDouble(10, Double.parseDouble(servamt));
			stmt.setDouble(11, Double.parseDouble(roundof));
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
				double mastercostprice=0;
				for(int i=0;i< prodarray.size();i++){

					String[] prod=((String) prodarray.get(i)).split("::");
					if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")))){




						if(docno>0)
						{

							String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
							String specno=""+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"";
							String stkid=""+(prod[12].equalsIgnoreCase("undefined") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"";						 
							String  rqty=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
							double masterqty=Double.parseDouble(rqty);
							double foc=Double.parseDouble(""+(prod[13].trim().equalsIgnoreCase("undefined") || prod[13].trim().equalsIgnoreCase("NaN")|| prod[13].trim().equalsIgnoreCase("")|| prod[13].isEmpty()?0:prod[13].trim())+"");

							double balstkqty=0;
							int psrno=0;
							int stockid=0;
							double remstkqty=0;
							double outstkqty=0;
							double stkqty=0;
							double qty=0;
							double detqty=0;
							double savemasterqty=0.0;
							double costprice=0.00;
							double mastr=0.0;
							
							Statement stmtstk=conn.createStatement();

							String stkSql="select cost_price,stockid,psrno,specno,sum(op_qty) stkqty,sum((op_qty-(rsv_qty+out_qty+del_qty))) balstkqty,(rsv_qty+out_qty+del_qty) out_qty,out_qty as qty,date from my_prddin "
									+ "where psrno='"+prdid+"' and specno='"+specno+"' and prdid='"+prdid+"' and brhid="+frmbrchid+" and locid="+frmlocid+" "
									+ "group by stockid,prdid,psrno having sum((op_qty-(rsv_qty+out_qty+del_qty)))>0 order by date,stockid";

							System.out.println("=stkSql=inside insert="+stkSql);

							ResultSet rsstk = stmtstk.executeQuery(stkSql);

							while(rsstk.next()) {

						 

								balstkqty=rsstk.getDouble("balstkqty");
								psrno=rsstk.getInt("psrno");
								outstkqty=rsstk.getDouble("out_qty");
								stockid=rsstk.getInt("stockid");
								stkqty=rsstk.getDouble("stkqty");
								qty=rsstk.getDouble("qty");
								costprice=rsstk.getDouble("cost_price");

								
								
								
								double NtWtKG=0.0;
								double KGPrice=0.0;
								double unitprice=0.0;
								double total=0.0;
								double discper=0.0;
								double discount=0.0;
								double netotal=0.0;
								
								
								
								if(remstkqty>0)
								{

									masterqty=remstkqty;
								}


								if(masterqty<=balstkqty)
								{
									mastr=masterqty-mastr;
									savemasterqty=masterqty;
									masterqty=masterqty+qty;
									detqty=masterqty;

									unitprice=costprice;
									total=costprice*savemasterqty;
									netotal=total;
									String sqls="update my_prddin set out_qty="+masterqty+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+"";
									System.out.println("--1---sqls---"+sqls);
									stmt.executeUpdate(sqls);
									
									mastercostprice=mastercostprice+(costprice*savemasterqty);
									
									//break;
									
									System.out.println("---savemasterqty-1---"+savemasterqty);
								  
									
									
									
									String sql="insert into my_invtranissued(tr_No,sr_no,rdocno,stockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal,foc)VALUES"
											+ " ("+trno+","+(i+1)+",'"+docno+"',"
											+ "'"+stockid+"',"
											+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
											+ "'"+savemasterqty+"',"
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


									String prodoutsql="insert into my_prddout(sr_no,TR_NO,date,dtype, rdocno,stockid, specid, psrno,qty,prdid,brhid,locid,unit_price,cost_price) Values"
											+ " ("+(i+1)+",'"+trno+"','"+date+"','"+formcode+"',"+docno+","
											+ "'"+stockid+"',"
											+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+savemasterqty+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+"'"+frmbrchid+"','"+frmlocid+"','"+costprice+"','"+costprice+"')";

									System.out.println("prodoutsql-1-->>>>Sql"+prodoutsql);
									prodout = stmt.executeUpdate (prodoutsql);
									
									
									break;

								}
								else if(masterqty>balstkqty)
								{

									mastr=masterqty-mastr;

									if(stkqty>=(masterqty+outstkqty))

									{
										balstkqty=masterqty+qty;	
										remstkqty=stkqty-outstkqty;

										System.out.println("---balstkqty-1---"+balstkqty);
									}
									else
									{
										
										mastr=masterqty-balstkqty;
										remstkqty=masterqty-balstkqty;
										balstkqty=stkqty-outstkqty+qty;

										System.out.println("---balstkqty-1---"+balstkqty);
									}
									detqty=stkqty-outstkqty;

									System.out.println("---stkqty-2---"+stkqty);
									 System.out.println("---outstkqty-2---"+outstkqty);
									 System.out.println("---detqty-2---"+detqty);
									
									
									String sqls="update my_prddin set out_qty="+balstkqty+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+"";	
									System.out.println("-2----sqls---"+sqls);

									stmt.executeUpdate(sqls);	
									
									
									unitprice=costprice;
									total=costprice*detqty;
									netotal=total;
									
									String sql="insert into my_invtranissued(tr_No,sr_no,rdocno,stockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal,foc)VALUES"
											+ " ("+trno+","+(i+1)+",'"+docno+"',"
											+ "'"+stockid+"',"
											+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
											+ "'"+detqty+"',"
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


									String prodoutsql="insert into my_prddout(sr_no,TR_NO,date, dtype, rdocno,stockid, specid, psrno,qty,prdid,brhid,locid,unit_price,cost_price) Values"
											+ " ("+(i+1)+",'"+trno+"','"+date+"','"+formcode+"',"+docno+","
											+ "'"+stockid+"',"
											+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+detqty+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+"'"+frmbrchid+"','"+frmlocid+"','"+costprice+"','"+costprice+"')";

									System.out.println("prodoutsql-2-->>>>Sql"+prodoutsql);
									prodout = stmt.executeUpdate (prodoutsql);
									
									
									
									mastercostprice=mastercostprice+(costprice*detqty);



								}

				
								System.out.println("----------asdjhajshdf------------");

							 
							}


						}

					}
						
				}
						
 

					/*		if(reftype.equalsIgnoreCase("IBT")){

*/

								for(int a=0;a<=1;a++){


									int acnos=0;
									String curris="1";
									double rates=1;
									String descs="Inventory Recept "+formcode+"-"+""+vocno+""+":-Dated :- "+date; 
									String refdetails=""+formcode+""+vocno;
									String sql2="";
									String jvbranch="";
									int id=0;
									if(a==0){
										sql2="select  acno from my_account where codeno='STOCK ACCOUNT' ";
										jvbranch=frmbrchid+"";
										id=-1;
									}
									if(a==1){
										sql2="select  acno from my_account where codeno='GOODSTRANSIT' ";
										jvbranch=tobrchid+"";
										id=1;
									}





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

									double pricetottal=mastercostprice*id;
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
					}*/

				


			 



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
			String prodamt,String nettotal,String servamt,String roundof,String finalamt,String mode,String formcode,ArrayList prodarray,HttpSession session,HttpServletRequest request) throws SQLException{

		Connection conn=null;
		int docno=0;
		conn=ClsConnection.getMyConnection();

		try{

			//System.out.println("==frmbrchid==="+frmbrchid+"==frmlocid=="+frmlocid);

			conn.setAutoCommit(false);

			CallableStatement stmt = conn.prepareCall("{CALL invTransIssueDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			
			stmt.registerOutParameter(21, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			stmt.setString(2,refno);
			stmt.setInt(3, frmbrchid);
			stmt.setInt(4, frmlocid);
			stmt.setInt(5, tobrchid);
			stmt.setInt(6, tolocid);
			stmt.setString(7,remarks);
			stmt.setDouble(8,Double.parseDouble(prodamt));
			stmt.setDouble(9,Double.parseDouble(nettotal));
			stmt.setDouble(10, Double.parseDouble(servamt));
			stmt.setDouble(11, Double.parseDouble(roundof));
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

				int prodet=0;
				int prodout=0;
				double mastercostprice=0;
				for(int i=0;i< prodarray.size();i++){

					String[] prod=((String) prodarray.get(i)).split("::");
					if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")))){




						if(docno>0)
						{
                                if(i==0)
                                {
							   int counts=0;							
						        String tempstk="0";	
						        
						        int stkids=0;
						        
						        String tempstkids="0";
						      
								double chkqtys=0;	
								double prdqty=0;

								double saveqty=0;
								int tmptrno=0;
								
								int prdidss=0;

								String sql9="select count(*) tmpcount from my_invtranissued where rdocno='"+docno+"'"	;				
						 
							//	System.out.println("-----sql9-----"+sql9);
								
								ResultSet rsstk11 = stmt.executeQuery(sql9);

								
								if(rsstk11.next())
								{
									counts=rsstk11.getInt("tmpcount");
								}
								
								Statement st=conn.createStatement();
							     for(int m=0;m<=counts;m++)
							     {
							    	 
							    	String sql2="select stockid,qty,prdid,tr_no from my_invtranissued where rdocno='"+docno+"' and stockid not in("+tempstk+") group by stockid limit 1";
							    	System.out.println("-----sql2-----"+sql2);
							    	ResultSet rsstk111 = stmt.executeQuery(sql2);
							    	
							    	
							    	if(rsstk111.next())
							    	{
							    		chkqtys=rsstk111.getDouble("qty");
							    		stkids=rsstk111.getInt("stockid");
							    		prdidss=rsstk111.getInt("prdid");
							    		tmptrno=rsstk111.getInt("tr_no");
							    	
							    	
							    	String sql3=" select out_qty   prdqty  from my_prddin where stockid='"+stkids+"'";
							    	 System.out.println("-----sql3-----"+sql3);
							    	ResultSet rsstk1111 = stmt.executeQuery(sql3);
							    	
							    	
							    	if(rsstk1111.next())
							    	{
							    		prdqty=rsstk1111.getDouble("prdqty");
								    	saveqty=prdqty-chkqtys;
								    	
								    	if(saveqty<0){
								    	saveqty=0;
								    	
								    	}
								    	
								      	String sql31="update my_prddin set out_qty="+saveqty+" where stockid='"+stkids+"'";
								    	 System.out.println("-----sql31-----"+sql31);
								    	 stmt.executeUpdate(sql31);
								    	 
								    	 	String sql34="delete from my_prddout  where stockid='"+stkids+"' and prdid='"+prdidss+"' and tr_no='"+tmptrno+"' and brhid="+session.getAttribute("BRANCHID").toString()+" and locid='"+frmlocid+"' ";
									    //	System.out.println("-----sql34-----"+sql34);
									    	 stmt.executeUpdate(sql34);
								    	 
								    	 if(m==0)
								    	 {
								    		 tempstk=String.valueOf(stkids);	 
								    	 }
								    	 else
								    	 {
								    	 tempstkids=tempstk+","+stkids+",";
								    	 tempstk=tempstkids;
								    	 }
								    	 System.out.println("-----tempstkids-----"+tempstkids);
								    	 //System.out.println("========"+m+"-----tempstk-----"+tempstk);
								    	  
								    	
								    	 
								    	 if(tempstk.endsWith(","))
											{
								    		 tempstk = tempstk.substring(0,tempstk.length() - 1);
											}
							    		
							    		
							    	}
							    	}

							    	 
							     }
						 

						 

						    	 
						    	      String dql31="delete from my_invtranissued where rdocno='"+docno+"'";
						    	 	  stmt.executeUpdate(dql31);
						    	 	 String dql32="delete from my_deldser where rdocno='"+docno+"'";
						    	 	 stmt.executeUpdate(dql32);
						   	 	 
						    	
						    	  
						    			
												}
							
			 
 
							
							
							
							
							
							
							
							String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
							String specno=""+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"";
							String stkid=""+(prod[12].equalsIgnoreCase("undefined") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"";						 
							String rqty=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
							double masterqty=Double.parseDouble(rqty);
							double foc=Double.parseDouble(""+(prod[13].trim().equalsIgnoreCase("undefined") || prod[13].trim().equalsIgnoreCase("NaN")|| prod[13].trim().equalsIgnoreCase("")|| prod[13].isEmpty()?0:prod[13].trim())+"");

							double balstkqty=0;
							int psrno=0;
							int stockid=0;
							double remstkqty=0;
							double outstkqty=0;
							double stkqty=0;
							double qty=0;
							double detqty=0;
							double savemasterqty=0.0;
							double costprice=0.00;
						 
							
							Statement stmtstk=conn.createStatement();

							String stkSql="select cost_price,stockid,psrno,specno,sum(op_qty) stkqty,sum((op_qty-(rsv_qty+out_qty+del_qty))) balstkqty,(rsv_qty+out_qty+del_qty) out_qty,out_qty as qty,date from my_prddin "
									+ "where psrno='"+prdid+"' and specno='"+specno+"' and prdid='"+prdid+"' and brhid="+frmbrchid+" and locid="+frmlocid+" "
									+ "group by stockid,prdid,psrno having sum((op_qty-(rsv_qty+out_qty+del_qty)))>0 order by date,stockid";

							System.out.println("=stkSql=inside insert="+stkSql);

							ResultSet rsstk = stmtstk.executeQuery(stkSql);

							while(rsstk.next()) {

						 

								balstkqty=rsstk.getDouble("balstkqty");
								psrno=rsstk.getInt("psrno");
								outstkqty=rsstk.getDouble("out_qty");
								stockid=rsstk.getInt("stockid");
								stkqty=rsstk.getDouble("stkqty");
								qty=rsstk.getDouble("qty");
								costprice=rsstk.getDouble("cost_price");

								
								
								
								double NtWtKG=0.0;
								double KGPrice=0.0;
								double unitprice=0.0;
								double total=0.0;
								double discper=0.0;
								double discount=0.0;
								double netotal=0.0;
								
								
								
								if(remstkqty>0)
								{

									masterqty=remstkqty;
								}


								if(masterqty<=balstkqty)
								{
									
									savemasterqty=masterqty;
									masterqty=masterqty+qty;
									detqty=masterqty;

									unitprice=costprice;
									total=costprice*savemasterqty;
									netotal=total;
									String sqls="update my_prddin set out_qty="+masterqty+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+"";
									System.out.println("--1---sqls---"+sqls);
									stmt.executeUpdate(sqls);
									
									mastercostprice=mastercostprice+(costprice*savemasterqty);
									
									//break;
									
									System.out.println("---savemasterqty-1---"+savemasterqty);
								 
									
									
									
									String sql="insert into my_invtranissued(tr_No,sr_no,rdocno,stockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal,foc)VALUES"
											+ " ("+trno+","+(i+1)+",'"+docno+"',"
											+ "'"+stockid+"',"
											+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
											+ "'"+savemasterqty+"',"
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


									String prodoutsql="insert into my_prddout(sr_no,TR_NO,date, dtype, rdocno,stockid, specid, psrno,qty,prdid,brhid,locid,unit_price,cost_price) Values"
											+ " ("+(i+1)+",'"+trno+"','"+date+"','"+formcode+"',"+docno+","
											+ "'"+stockid+"',"
											+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+savemasterqty+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+"'"+frmbrchid+"','"+frmlocid+"','"+costprice+"','"+costprice+"')";

									System.out.println("prodoutsql--->>>>Sql"+prodoutsql);
									prodout = stmt.executeUpdate (prodoutsql);
									
									
									break;

								}
								else if(masterqty>balstkqty)
								{



									if(stkqty>=(masterqty+outstkqty))

									{
										balstkqty=masterqty+qty;	
										remstkqty=stkqty-outstkqty;

										System.out.println("---balstkqty-1---"+balstkqty);
									}
									else
									{
										remstkqty=masterqty-balstkqty;
										balstkqty=stkqty-outstkqty+qty;


									}
									detqty=stkqty-outstkqty;

									System.out.println("---stkqty-2---"+stkqty);
									 System.out.println("---outstkqty-2---"+outstkqty);
									 System.out.println("---detqty-2---"+detqty);
									
									
									String sqls="update my_prddin set out_qty="+balstkqty+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+"";	
									System.out.println("-2----sqls---"+sqls);

									stmt.executeUpdate(sqls);	
									
									
									unitprice=costprice;
									total=costprice*detqty;
									netotal=total;
									
									String sql="insert into my_invtranissued(tr_No,sr_no,rdocno,stockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal,foc)VALUES"
											+ " ("+trno+","+(i+1)+",'"+docno+"',"
											+ "'"+stockid+"',"
											+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
											+ "'"+detqty+"',"
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


									String prodoutsql="insert into my_prddout(sr_no,TR_NO,date, dtype, rdocno,stockid, specid, psrno,qty,prdid,brhid,locid,unit_price,cost_price) Values"
											+ " ("+(i+1)+",'"+trno+"','"+date+"','"+formcode+"',"+docno+","
											+ "'"+stockid+"',"
											+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+detqty+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+"'"+frmbrchid+"','"+frmlocid+"','"+costprice+"','"+costprice+"')";

									System.out.println("prodoutsql--->>>>Sql"+prodoutsql);
									prodout = stmt.executeUpdate (prodoutsql);
									
									
									
									mastercostprice=mastercostprice+(costprice*detqty);



								}

				

 

							/*	if(masterqty<=balstkqty)
								{
									break;
								}*/

							}


						}
					}
				}
 

						/*	if(reftype.equalsIgnoreCase("IBT")){*/

								 String dql33= "delete from my_jvtran where tr_no='"+trno+"' and dtype='"+formcode+"'  ";
					    	 	 stmt.executeUpdate(dql33);

					 			for(int a=0;a<=1;a++){


									int acnos=0;
									String curris="1";
									double rates=1;
									String descs="Inventory Recept "+formcode+"-"+""+vocno+""+":-Dated :- "+date; 
									String refdetails=""+formcode+""+vocno;
									String sql2="";
									String jvbranch="";
									int id=0;
									if(a==0){
										sql2="select  acno from my_account where codeno='STOCK ACCOUNT' ";
										jvbranch=frmbrchid+"";
										id=-1;
									}
									if(a==1){
										sql2="select  acno from my_account where codeno='GOODSTRANSIT' ";
										jvbranch=tobrchid+"";
										id=1;
									}





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

									double pricetottal=mastercostprice*id;
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

									//System.out.println("==sql11===="+sql11);

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




						String sql="insert into my_invtranissued(sr_no,rdocno,stockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal)VALUES"
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

								String strSql="select d.qty qty,sum((d.qty-d.out_qty)) balqty,d.doc_no,d.rdocno,d.out_qty out_qty,d.prdid  from my_invtranissuem m  left join "
										+ "my_invtranissued d on m.doc_no=d.rdocno where d.rdocno in ("+qotmasterdocno+") and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and d.prdid='"+prdid+"' group by d.doc_no having  sum(d.qty-d.out_qty)>0 "
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

	 public     ClsTransferIssueBean getPrint(int docno, HttpServletRequest request) throws SQLException {
		 ClsTransferIssueBean bean = new ClsTransferIssueBean();
		  Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtprint = conn.createStatement ();
	        	
			/*	String resql=("select m.date,m.mob,m.email,m.doc_no,m.voc_no,if(m.cltype=0,a.refname,m.clientname) client,if(m.cltype=0,'Client','General') type,payterms, delterms, description "
						+ "  from my_cusenqm m left join my_acbook a on a.cldocno=m.clientid and m.dtype='CEQ' where m.doc_no='"+docno+"'");
				*/
				
				String resql=("select if(m.reftype='IBT','Branch Trasfer','Location Transfer') reftype,coalesce(m.remarks,'') as remarks,m.doc_no,m.voc_no,date_format(m.date,'%d-%m-%Y') date,m.tobrhid,m.tolocid,b.branchname as tobranch,l.loc_name as toloc,m.frmbrhid,m.frmlocid,fb.branchname as frmbranch,fl.loc_name as frmloc,amount,netamount,servamt,grantamt,coalesce(refno,'') refno from my_invtranissuem m"
						+ "  left join my_brch b on(m.tobrhid=b.doc_no) left join my_locm l on(l.doc_no=m.tolocid) left join my_brch fb on(m.frmbrhid=fb.doc_no) left join my_locm fl on(fl.doc_no=m.frmlocid) where m.status=3 and m.doc_no='"+docno+"'");
				
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
		 
			       while(pintrs.next()){
			    	 
			   
			    	    bean.setLbldocno(pintrs.getString("voc_no"));
			    	    bean.setLbldate(pintrs.getString("date"));
			    	    bean.setLblrefno(pintrs.getString("refno"));
			    	    bean.setLblreftype(pintrs.getString("reftype"));
			    	    bean.setLblbranchfrom(pintrs.getString("frmbranch"));
			    	    
			    	    
			    	    bean.setLbllocationfrom(pintrs.getString("frmloc"));
			    	    bean.setLblbranchto(pintrs.getString("tobranch"));
			    	    bean.setLbllocationto(pintrs.getString("toloc"));
			    	    
			    	    bean.setLblremarks(pintrs.getString("remarks")); 
			    	  
			    	    
			   
			    	  
			       }
				

				stmtprint.close();
				
				
				
				 Statement stmt10 = conn.createStatement ();
				    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from my_invtranissuem r  "
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
				       String	strSqldetail="Select d.specno specid ,m.part_no productid,m.productname, u.unit,round(sum(d.qty),2) qty  from my_invtranissued d"
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

