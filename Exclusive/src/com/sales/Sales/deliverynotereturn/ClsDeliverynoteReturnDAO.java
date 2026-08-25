package com.sales.Sales.deliverynotereturn;

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
import com.sales.Sales.deliverynote.ClsDeliveryNoteBean;

public class ClsDeliverynoteReturnDAO {
	ClsDeliverynoteReturnBean bean= new ClsDeliverynoteReturnBean();
	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();
	public   JSONArray searchProduct(HttpSession session,String prodsearchtype,String rdoc,String locaid) throws SQLException {

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

			/*			String chk="select method  from gl_prdconfig where field_nme='prosearch_stock'";
			ResultSet rs=stmt.executeQuery(chk); 
			if(rs.next())
			{

				method=rs.getInt("method");
			}*/


			if(prodsearchtype.equals("0")){

			 
				

		 
			// sql="select um(i.out_qty) outqty,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty,sum(i.op_qty) as totqty,i.stockid as stkid  from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) inner join my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno ) where m.status=3 and de.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by i.prdid having sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by i.date ";
			}
			else{

				/*if(method>0){

					sql="select  stkid,specid,psrno as doc_no,rdocno,psrno,qty as totqty,(qty-outqty) qty,outqty,(qty-outqty) as balqty,0 size,part_no,productid,productname,unit,unitdocno from "
							+ "( select i.stockid as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(i.op_qty) as qty,sum(i.out_qty+i.del_qty+i.rsv_qty) as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno from "
							+ "my_delm ma left join my_delrd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) inner join my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and ma.brhid=i.brhid) where m.status=3 and d.rdocno in("+rdoc+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by i.prdid having sum((op_qty)-(i.out_qty+i.rsv_qty+i.del_qty))>0 order by i.date ) as a ";


				}
				else{


					sql="select  stkid,specid,psrno as doc_no,rdocno,psrno,qty as totqty,(qty-outqty) qty,outqty,(qty-outqty) as balqty,0 size,part_no,productid,productname,unit,unitdocno from "
							+ "( select 0 as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(d.out_qty) as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno from "
							+ "my_delm ma left join my_delrd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no)  where m.status=3 and d.rdocno in("+rdoc+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by psrno having sum(d.qty-d.out_qty)>0 ) as a ";



				}
				 */

				sql="select  brandname,specid,psrno as doc_no,rdocno,psrno,qty as totqty,(qty-outqty) qty,outqty,(qty-outqty) as balqty,0 size,part_no,productid,productname,unit,unitdocno from "
						+ "( select bd.brandname ,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(d.qty) as qty,sum(d.out_qty) as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno from "
						+ "my_delm ma left join my_deld d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "
						+ "  where m.status=3 and d.rdocno in("+rdoc+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' and ma.locid='"+locaid+"' group by  d.rdocno,d.psrno,d.unitid having sum((d.qty)-(d.out_qty))>0 order by d.rdocno,d.prdid,d.unitid) as a ";
				
 
				System.out.println("----searchProduct-sql---"+sql);
				ResultSet resultSet = stmt.executeQuery (sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
			}

	 
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







	public  JSONArray reqSearchMasters(HttpSession session,String docnoss,String refnosss,String datess,String aa,String clientid,String locaid) throws SQLException {

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

			String pySql=("select * from (select sum(qty-d.out_qty) as qty,m.doc_no,m.rrefno as refno,m.voc_no,m.date,ac.refname as client,0 as chk from my_delm m left join   my_acbook ac on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_deld d on(d.rdocno=m.doc_no)  where m.status=3 and m.cldocno="+clientid+"  and m.brhid='"+brcid+"' and m.locid='"+locaid+"'   "+sqltest+" group by m.doc_no) as a having qty>0" );
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



	public  JSONArray searchMaster(HttpSession session,String msdocno,String clnames,String enqno,String enqdate,String enqtype,String Cl_clientsale1,String Cl_mobnos) throws SQLException {


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
		String brid=session.getAttribute("BRANCHID").toString();



		java.sql.Date sqlStartDate=null;


		if(!(enqdate.equalsIgnoreCase("undefined"))&&!(enqdate.equalsIgnoreCase(""))&&!(enqdate.equalsIgnoreCase("0")))
		{
			sqlStartDate = ClsCommon.changeStringtoSqlDate(enqdate);
		}

		String sqltest="";
		if(!(msdocno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.voc_no like '%"+msdocno+"%'";
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


		if(!(Cl_mobnos.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.per_mob like '%"+Cl_mobnos+"%'";
		}


		if(!(Cl_clientsale1.equalsIgnoreCase(""))){
			sqltest=sqltest+" and sa.sal_name like '%"+Cl_clientsale1+"%'";
		}


		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();

			String clssql= ("select ac.per_mob,sa.doc_no saldocno,sa.sal_name,m.doc_no,m.voc_no,m.date,m.dtype,m.brhid,ac.refname as name,ac.address as cladd,"
					+ "m.cldocno,m.ref_type,rrefno from my_delrm m  left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') "
					+ " left join my_salm sa on sa.doc_no=ac.sal_id and   ac.dtype='CRM' where m.brhid="+brid+" and m.status=3 "+sqltest+"");
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
					+ "my_delrm m left join my_delrd d on(m.doc_no=d.rdocno)  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "
					+ "  where m.status=3 and m.doc_no in("+docno+") group by psrno having sum(d.qty-d.out_qty)>0) as a ";
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

	public JSONArray prdGridReload(HttpSession session,String docno,String enqdoc,String locaid) throws SQLException {


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
			/*String sqlcond1="";
			String sqlcond2="";
			String sqlselect="";*/

			/*String chk="select method  from gl_prdconfig where field_nme='prosearch_stock'";
			ResultSet rs=stmt.executeQuery(chk); 
			if(rs.next())
			{

				method=rs.getInt("method");
			}
			 */



			/*			if(method>0){

				sql="select stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,totqty, qty,qty as oldqty,outqty,case when (totqty-outqty)=0 then 0 else (qty+balqty) end as balqty,0 size,part_no,productid as proid,productid,productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,"
						+ "  dis, netotal from "
						+ "(select  stkid,specid,psrno as doc_no,rdocno,psrno,qtys as totqty, qty,qtys,outqty,(qtys-outqty) as balqty,0 size,part_no,productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper,"
						+ "  dis, netotal from "
						+ "( select i.stockid as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(d.qty) as qty,sum(i.op_qty) as qtys,sum(i.out_qty+i.del_qty+i.rsv_qty) as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice, d.total,d.disper discper,"
						+ " d.discount dis,d.nettotal netotal from "
						+ "my_delrm ma left join my_delrd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) left join "
						+ " my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "
						+ "inner join my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and ma.brhid=i.brhid and d.stockid=i.stockid) "
						+ "where m.status=3 and d.rdocno in("+docno+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' "
						+ "group by d.prdid  order by i.date ) as a) as b ";

				having sum((op_qty)-(i.out_qty+i.rsv_qty+i.del_qty))>0
				System.out.println("===prdGridReload=stockcheck==="+sql);

			}
			else{

				sql="select stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,totqty, qty,qty as oldqty,outqty,case when (totqty-outqty)=0 then 0 else (qty+balqty) end as balqty,0 size,part_no,productid as proid,productid,productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,"
						+ "  dis, netotal from "
						+ "(select  stkid,specid,psrno as doc_no,rdocno,psrno,qtys as totqty, qty,qtys,outqty,(qtys-outqty) as balqty,0 size,part_no,productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper,"
						+ "  dis, netotal from "
						+ "( select 0 as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(d.qty) as qty,sum(d.qty) as qtys,sum(d.out_qty) as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice, d.total,d.disper discper,"
						+ " d.discount dis,d.nettotal netotal from "
						+ "my_delrm ma left join my_delrd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) left join "
						+ " my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "
						+ "where m.status=3 and d.rdocno in("+docno+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' "
						+ "group by d.prdid  order by i.date ) as a) as b ";

				System.out.println("===prdGridReload===="+sql);

				sql="select  stkid,specid,psrno as doc_no,rdocno,psrno,qty as totqty,(qty-outqty) qty,outqty,(qty-outqty) as balqty,0 size,part_no,productid,productname,unit,unitdocno from "
							+ "( select 0 as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(d.out_qty) as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno from "
							+ "my_delrm ma left join my_delrd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no)  where m.status=3 and d.rdocno in("+docno+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by psrno having sum(d.qty-d.out_qty)>0 ) as a ";


				//System.out.println("===prdGridReload==3==="+sql);

			}*/



/*			sql="select  brandname,refstkid,stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,totqty, qty,qty as oldqty,outqty,"
					+ "balqty+qty balqty,0 size,part_no,productid as proid,productid,"
					+ "productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,  dis, netotal "
					+ "from(select  brandname,refstkid, stkid,specid,psrno as doc_no,rdocno,psrno,qtys as totqty, qty,qtys,outqty,delbalqty as balqty,0 size,part_no,"
					+ "productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper,  dis, netotal from (select bd.brandname,cc.delbalqty,i.refstockid refstkid,i.stockid as stkid,"
					+ "d.specno as specid,d.rdocno,m.doc_no psrno,sum(d.qty) as qty,sum(i.op_qty) as qtys,sum(i.out_qty+i.del_qty+i.rsv_qty) as outqty,m.part_no,"
					+ "m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice,d.total,"
					+ "d.disper discper, d.discount dis,d.nettotal netotal from my_delrm ma left join my_delrd d on(ma.doc_no=d.rdocno)left join "
					+ "my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no) left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at "
					+ "on(at.mpsrno=m.doc_no and d.specno=at.mpsrno ) left join my_prddin i "
					+ "on (i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno and ma.brhid=i.brhid and d.stockid=i.stockid  and i.locid='"+locaid+"')  "
					+ "left join (select sum(qty-out_qty)  delbalqty, psrno,stockid, "
					+ "rdocno,specno,prdid from my_deld where rdocno in("+enqdoc+")   group by  stockid) cc on cc.psrno=d.psrno and cc.prdid=d.prdid and  cc.specno=d.specno and d.refstockid=cc.stockid where m.status=3 and "
					+ "d.rdocno in("+docno+") and i.brhid='"+session.getAttribute("BRANCHID").toString()+"' and i.locid='"+locaid+"' group by d.stockid  order by i.date,i.prdid,i.refstockid) as a ) as b ";
*/
			
			sql="select  detdocno,rdocno,brandname,refstkid,stkid,specid,psrno as prodoc,psrno as doc_no,psrno,totqty, qty,qty as oldqty,outqty,"
					+ "balqty+qty balqty,0 size,part_no,productid as proid,productid,"
					+ "productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,  dis, netotal "
					+ "from(select  detdocno,ref_row rdocno,brandname,refstkid, stkid,specid,psrno as doc_no,psrno,qtys as totqty, qty,qtys,outqty,delbalqty as balqty,0 size,part_no,"
					+ "productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper,  dis, netotal from ("
					+ " select 0 detdocno, d.ref_row ,bd.brandname,cc.delbalqty,i.refstockid refstkid,i.stockid as stkid,"
					+ "d.specno as specid,m.doc_no psrno,sum(d.qty) as qty,cc.oldqty as qtys,cc.delbalqty as outqty,m.part_no,"
					+ "m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice,d.total,"
					+ "d.disper discper, d.discount dis,d.nettotal netotal from my_delrm ma left join my_delrd d on(ma.doc_no=d.rdocno)left join "
					+ "my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no) left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at "
					+ "on(at.mpsrno=m.doc_no and d.specno=at.mpsrno ) left join my_prddin i "
					+ "on (i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno and ma.brhid=i.brhid and d.stockid=i.stockid  and i.locid='"+locaid+"')  "
					+ "left join (select doc_no,sum(qty-out_qty)  delbalqty,sum(qty) oldqty, psrno,stockid,unitid, "
					+ "rdocno,specno,prdid from my_deld where rdocno in("+enqdoc+")   group by  rdocno,psrno,unitid,specno) cc"
							+ "  on cc.psrno=d.psrno and cc.prdid=d.prdid and  cc.specno=d.specno and  d.unitid=cc.unitid and cc.rdocno=d.ref_row where m.status=3 and "
					+ "d.rdocno in("+docno+")  group by d.ref_row,d.psrno,d.unitid,d.specno   order by d.ref_row,d.psrno,d.unitid,d.specno ) as a ) as b ";
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


	public JSONArray prdGridReload(HttpSession session,String docno,String locaid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {

			if(((docno.equalsIgnoreCase(""))||(docno.equalsIgnoreCase("undefined")))){

				docno="0";
			}

			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

/*			String sql="select bd.brandname,d.stockid as stkid,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty) totqty,sum(qty) as oldqty,sum(qty-out_qty) qty,sum(out_qty) outqty,sum(qty-out_qty) as balqty,"
					+ "part_no,m.part_no productid,m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, KGPrice kgprice,"
					+ " d.amount unitprice,d.total,d.disper discper,d.discount dis,d.nettotal netotal from my_delm ma left join  my_deld d on d.rdocno=ma.doc_no left join my_main m on(d.psrno=m.doc_no) "
					+ "left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no where m.status=3 and d.rdocno in("+docno+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' and ma.locid='"+locaid+"' group by d.stockid "
					+ "having sum(d.qty-d.out_qty)>0 order by d.prdid,d.stockid ";
			*/
			
			String sql="select bd.brandname,d.stockid as stkid,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty) totqty,sum(qty) as oldqty,sum(qty-out_qty) qty,sum(out_qty) outqty,sum(qty-out_qty) as balqty,"
					+ "part_no,m.part_no productid,m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, KGPrice kgprice,"
					+ " d.amount unitprice,d.total,d.disper discper,d.discount dis,d.nettotal netotal from my_delm ma left join  my_deld d on d.rdocno=ma.doc_no left join my_main m on(d.psrno=m.doc_no) "
					+ "left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no where m.status=3 and d.rdocno in("+docno+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' and ma.locid='"+locaid+"' group by d.rdocno,d.psrno,d.unitid "
					+ "having sum(d.qty-d.out_qty)>0 order by d.rdocno,d.prdid,d.stockid ";

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
					+ "my_sorderm ma left join my_deld d on(ma.doc_no=d.rdocno) inner join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "+sqlcond1+" where m.status=3 and d.rdocno in("+doc+")  "+sqlcond2+" ) as a group by psrno";


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


	public int insert(java.sql.Date date,String refno,String curr,String currate,int clientid,String rrefno,String rreftype,String locid,String payterms,String delterms,String desc,
			String mode,String formcode,ArrayList prodarray,HttpSession session,HttpServletRequest request,String refmasterdocno) throws SQLException{

		Connection conn=null;
		int deldocno=0;
		conn=ClsConnection.getMyConnection();

		try{

			conn.setAutoCommit(false);

			CallableStatement stmt = conn.prepareCall("{CALL deliveryReturnDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		
			stmt.registerOutParameter(17, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(18, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(19, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			stmt.setString(2,refno);
			stmt.setInt(3, clientid);
			stmt.setInt(4, Integer.parseInt(curr));
			stmt.setDouble(5, Double.parseDouble(currate));
			stmt.setString(6,rreftype);
			stmt.setString(7,refmasterdocno);
			stmt.setInt(8, Integer.parseInt(locid));
			stmt.setString(9,payterms);
			stmt.setString(10,delterms);
			stmt.setString(11,desc);
			stmt.setString(12,mode);
			stmt.setString(13,formcode);
			stmt.setString(14, session.getAttribute("USERID").toString());
			stmt.setString(15, session.getAttribute("BRANCHID").toString());
			stmt.setString(16, session.getAttribute("COMPANYID").toString());
			int val = stmt.executeUpdate();
			deldocno=stmt.getInt("deldocno");
			int vocno=stmt.getInt("vdocNo");
			int trno=stmt.getInt("strno");
			request.setAttribute("vdocNo", vocno);
			//System.out.println("===vocno====="+vocno);
			if(vocno>0){

				int prodet=0;
				int prodout=0;
				String docnoset="0,";
				
				int mm=0;
				for(int i=0;i< prodarray.size();i++){

					String[] prod=((String) prodarray.get(i)).split("::");
					
				//	System.out.println("=====test===="+prod[0]);
					
					if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")))){




						if(deldocno>0)
						{

							String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
							String specno=""+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"";
							String stkid=""+(prod[12].equalsIgnoreCase("undefined") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"";						 
							String  rqty=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
							double masterqty=Double.parseDouble(rqty);

							//int stockid=Integer.parseInt(stkid);
							/*int method=0;
							String chk="select method  from gl_prdconfig where field_nme='prosearch_stock'";
							ResultSet rsconfiq=stmt.executeQuery(chk); 
							if(rsconfiq.next())
							{

								method=rsconfiq.getInt("method");
							}*/

								String unitidss=""+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].trim().equalsIgnoreCase("")|| prod[1].isEmpty()?0:prod[1].trim())+"";
							    String prsros=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
							     
								String rdocno=""+(prod[14].trim().equalsIgnoreCase("undefined") || prod[14].trim().equalsIgnoreCase("NaN")|| prod[14].trim().equalsIgnoreCase("")|| prod[14].isEmpty()?0:prod[14].trim())+"";
								
								String sqlssss="select  * from my_deld   where rdocno="+rdocno+" and stockid>0 ";
								 ResultSet rsss=stmt.executeQuery(sqlssss);
								 if(rsss.next())
								 {
									 
									 mm=1;
								 }
									
								
								
							     double fr=1;
							     String slss=" select fr from my_unit where psrno="+prsros+" and unit='"+unitidss+"' ";
							     
							   //  System.out.println("====slss==="+slss);
							     ResultSet rv1=stmt.executeQuery(slss);
							     if(rv1.next())
							     {
							    	 fr=rv1.getDouble("fr"); 
							     }
					    	 
							     
									String sqlsss="insert into my_delrd(tr_No,sr_no,rdocno,stockid,refstockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice,ref_row,fr)VALUES"
											+ " ("+trno+","+(i+1)+",'"+deldocno+"',"
											+ "'"+0+"',"
											+ "'"+0+"',"
											+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
											+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
											+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
											+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
											+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"','"+rdocno+"',"+fr+")";
								//	System.out.println("--1--sqlsss--"+sqlsss);
									prodet = stmt.executeUpdate (sqlsss);
									
									int stockidss=0;
									double   out_qty=0;
									
									String delsqls1="select out_qty,stockid from  my_deld   where rdocno="+rdocno+" and prdid="+prdid+" and  unitid="+unitidss+"  ";
									ResultSet rssss=stmt.executeQuery(delsqls1);
									if(rssss.first())
									{
										out_qty=rssss.getDouble("out_qty");
										stockidss=rssss.getInt("stockid");
									}
									//System.out.println("--out_qtys---"+out_qty);
								//	System.out.println("--rqty---"+rqty);
									if(stockidss==0)
									{
									out_qty=out_qty+masterqty;
									String delsqls="update my_deld set out_qty="+out_qty+" where rdocno="+rdocno+" and prdid="+prdid+" and  unitid="+unitidss+" ";
									//System.out.println("--1---sqls---"+delsqls);
									 
	 
									stmt.executeUpdate(delsqls);
									
										}
					                   double remqty=0;
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
										double del_qty=0.0;
										double unitprice=0.0;
										double costprice=0.0,prdout=0;
										
										
									 
										double pdelqty=0;
									 
										double savepdelqty=0;
										
										
										
										double outsave=0.0;
										
										String docnoss="";
										Statement stmtstk=conn.createStatement();

										Statement stmtstk1=conn.createStatement();
										
										
									//	System.out.println("=masterqty=== ="+masterqty);

										System.out.println("=fr=== ="+fr);
										double masterqty1=masterqty*fr;
									//	System.out.println("=masterqty1=== ="+masterqty1);
										
								/*		String stkSql=" select o.del_qty,o.stockid,o.doc_no from my_deld d   left join my_prddout o on o.tr_no=d.tr_no and d.rdocno in("+rdocno+") "
												 	+ "left join my_prddin pin on pin.stockid=o.stockid and pin.psrno=o.psrno " 
												+ " 	where   d.rdocno in("+rdocno+") and o.doc_no not in ("+docnoset.substring(0,docnoset.length() - 1)+") and   d.psrno='"+prdid+"' and d.specno='"+specno+"' and d.unitid="+unitidss+" and pin.unitid="+unitidss+" group by o.doc_no ";
								 */
										
										String stkSql=" select o.del_qty-coalesce(o.out_qty,0) del_qty ,o.stockid,o.doc_no    from my_prddout o  "
												+ " 	where   o.rdocno in("+rdocno+")    and  "
														+ " o.psrno='"+prdid+"' and o.specid='"+specno+"'   and  o.del_qty>coalesce(o.out_qty,0)     group by o.doc_no ";
									
								 
										
										

										//System.out.println("=stkSql=inside==================== insert="+stkSql);

										ResultSet rsstk = stmtstk.executeQuery(stkSql);

										while(rsstk.next()) {
											 
											docnoss=rsstk.getString("doc_no");
										 
											stockid=rsstk.getInt("stockid");
											del_qty=rsstk.getDouble("del_qty");
											 
											
										/*	 if(docnoset.equalsIgnoreCase("0"))
											 {
												 docnoset="0,";
											 }
											 else
											 {
												 docnoset=docnoss+","; 
											 }*/
												
												docnoset=docnoset+docnoss+",";
												
											/* 	 if(docnoset.endsWith(","))
													{
										    		 docnoset = docnoset.substring(0,docnoset.length() - 1);
													}*/
											 	 
											 	 
											 //	 System.out.println("==========docnoset========"+docnoset);
											 	 
											 	 
												
											 String stkSql11="select i.unit_price,i.cost_price,i.del_qty from  my_prddin i where  i.stockid="+stockid+" " ;
											 
											 ResultSet rsstk1 = stmtstk1.executeQuery(stkSql11);

												if(rsstk1.next()) {
													unitprice=rsstk1.getDouble("unit_price");
													costprice=rsstk1.getDouble("cost_price");
													pdelqty=rsstk1.getDouble("del_qty");
													
												}
												 String stkSql111="select out_qty from  my_prddout  where  doc_no="+docnoss+" " ;
												 
												 ResultSet rsstk11 = stmtstk1.executeQuery(stkSql111);

													if(rsstk11.next()) {
														prdout=rsstk11.getDouble("out_qty");
														 
														
													}
												 
											 
											 
												if(remqty>0)
												{

													masterqty1=remqty;
												}

												
											//	System.out.println("=masterqty1======== ="+masterqty1);
											//	System.out.println("=del_qty======== ="+del_qty);
												

												if(masterqty1<=del_qty)
												{
													savepdelqty=pdelqty-masterqty1;
													if(savepdelqty<0) {savepdelqty=0; }
													 
													String prodinsql="insert into my_prddin(sr_no,TR_NO, dtype,refstockid,unit_price,cost_price,specno, psrno,op_qty,prdid,brhid,locid,date,unitid,fr,outdocno) Values"
															+ " ("+(i+1)+",'"+trno+"','"+formcode+"',"
															+ "'"+stockid+"',"
															+ ""+unitprice+","
															+ ""+costprice+","
															+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
															+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
															+ "'"+masterqty1+"',"
															+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
															+"'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"','"+locid+"','"+date+"',"+unitidss+","+fr+","+docnoss+")";

													System.out.println("prodinsql-1-->>>>Sql"+prodinsql);
													prodout = stmt.executeUpdate (prodinsql);
												
													
													
													String prodinsql111="update   my_prddin set out_qty=out_qty+"+masterqty1+",del_qty="+savepdelqty+" where stockid="+stockid+"";
													System.out.println("prodinsql111-1-->>>>Sql"+prodinsql111);
													prodout = stmt.executeUpdate (prodinsql111);

													
													outsave=prdout+masterqty1;
													
													String prodinsql1="update   my_prddout set out_qty="+outsave+" where doc_no="+docnoss+"";
													System.out.println("prodinsql-1-->>>>Sql"+prodinsql1);
													prodout = stmt.executeUpdate (prodinsql1);

													if(mm==1)
													{
													
													String prodinsql11="update   my_deld set out_qty=out_qty+"+masterqty1+" where stockid="+stockid+" and psrno='"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"'";
													System.out.println("prodinsql11-1-->>>>Sql"+prodinsql11);
													prodout = stmt.executeUpdate (prodinsql11);
													
													}
													
													masterqty1=0;
													break;


												}
												else if(masterqty1>del_qty)
												{



													 
														remqty=masterqty1-del_qty;
														savepdelqty=pdelqty-del_qty;
														if(savepdelqty<0) {savepdelqty=0; }
														
														
														String prodinsql="insert into my_prddin(sr_no,TR_NO, dtype,refstockid,unit_price,cost_price,specno, psrno,op_qty,prdid,brhid,locid,date,unitid,fr,outdocno) Values"
																+ " ("+(i+1)+",'"+trno+"','"+formcode+"',"
																+ "'"+stockid+"',"
																+ ""+unitprice+","
																+ ""+costprice+","
																+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
																+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
																+ "'"+del_qty+"',"
																+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
																+"'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"','"+locid+"','"+date+"',"+unitidss+","+fr+","+docnoss+")";

														//System.out.println("prodinsql--2->>>>Sql"+prodinsql);
														prodout = stmt.executeUpdate (prodinsql);
														
														String prodinsql1111="update   my_prddin set out_qty=out_qty+"+del_qty+",del_qty="+savepdelqty+" where stockid="+stockid+"";
														System.out.println("prodinsql1111-2-->>>>Sql"+prodinsql1111);
														prodout = stmt.executeUpdate (prodinsql1111);
														
														
														
														outsave=prdout+del_qty;
														
														String prodinsql1="update   my_prddout set out_qty="+outsave+" where doc_no="+docnoss+"";
														//System.out.println("prodinsql-1-->>>>Sql"+prodinsql1);
														prodout = stmt.executeUpdate (prodinsql1);

														 
														if(mm==1)
														{
														String prodinsql11="update   my_deld set out_qty=out_qty+"+del_qty+" where stockid="+stockid+" and psrno='"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"'";
														//System.out.println("prodinsql11-1-->>>>Sql"+prodinsql11);
														prodout = stmt.executeUpdate (prodinsql11);
														}

														 
													}


											 
												 
											 	 System.out.println("==========docnoss========"+docnoss);
											 	 
												 

									
											 	if(masterqty1==0)
												{
													
													break;
												}
										    	 }
										    	  
									
/*							double saveqty=0;
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
 
							String stkSql="select d.rdocno,d.doc_no,d.stockid,d.psrno,d.specno,d.qty delqty,sum(d.qty) stkqty,sum(d.qty-d.out_qty) balstkqty,(d.out_qty) out_qty,sum(i.del_qty) as qty,m.date,i.unit_price,i.cost_price from my_delm m left join  my_deld d on(d.rdocno=m.doc_no) left join my_prddin i on(d.stockid=i.stockid) "
									+ "where d.rdocno in("+refmasterdocno+") and d.stockid="+stkid+"  and d.psrno='"+prdid+"' and d.specno='"+specno+"' and d.prdid='"+prdid+"' and m.brhid="+session.getAttribute("BRANCHID").toString()+" "
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
								
 
								
								String prodinsql="insert into my_prddin(sr_no,TR_NO, dtype,refstockid,unit_price,cost_price,specno, psrno,op_qty,prdid,brhid,locid,date) Values"
										+ " ("+(i+1)+",'"+trno+"','"+formcode+"',"
										+ "'"+stockid+"',"
										+ ""+unitprice+","
										+ ""+costprice+","
										+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
										+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
										+ "'"+masterqty+"',"
										+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
										+"'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"','"+locid+"','"+date+"')";

								System.out.println("prodinsql--->>>>Sql"+prodinsql);
								prodout = stmt.executeUpdate (prodinsql);

								String nstkSql="select stockid from  my_prddin where  refstockid="+stkid+" and tr_no="+trno+" and psrno='"+prdid+"' and specno='"+specno+"' and prdid='"+prdid+"' and brhid="+session.getAttribute("BRANCHID").toString()+"";

								System.out.println("=nstkSql="+nstkSql);

								ResultSet rsnstk = stmtstk.executeQuery(nstkSql);

								while(rsnstk.next()) {
									refstockid=rsnstk.getInt("stockid");
								}

								


								
								String stkSql="select d.rdocno,d.doc_no,d.stockid,d.psrno,d.specno,d.qty delqty,sum(d.qty) stkqty,sum(d.qty-d.out_qty) balstkqty,(d.out_qty) out_qty,sum(i.del_qty) as qty,m.date,i.unit_price,i.cost_price from my_delm m left join  my_deld d on(d.rdocno=m.doc_no) left join my_prddin i on(d.stockid=i.stockid) "
										+ "where d.rdocno in("+refmasterdocno+") and d.stockid="+stkid+"  and d.psrno='"+prdid+"' and d.specno='"+specno+"' and d.prdid='"+prdid+"' and m.brhid="+session.getAttribute("BRANCHID").toString()+" "
										+ "group by d.stockid,d.prdid,d.psrno having sum(qty-d.out_qty)>0 order by m.date";
							
								
						 
								
								if(masterqty<=balstkqty)
								{
								 
									
									
									break;
								}

							
							}*/
								 
	/*							double masterqty1=masterqty;
								double balqty1=0;
								int docno1=0;
								int rdocno1=0;
								double remqty1=0;
								double out_qty1=0;
								double qtys1=0;
								int dnstk=0;
								
								double secqty=0;
								Statement stmt1=conn.createStatement();
								String strSql="select d.stockid,d.qty qty,sum((d.qty-d.out_qty)) balqty,d.doc_no,d.rdocno,d.out_qty out_qty,d.prdid  from my_delm m  left join "
										+ "my_deld d on m.doc_no=d.rdocno where d.rdocno in ("+refmasterdocno+") and d.stockid="+stkid+" and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and d.specno='"+specno+"' and d.prdid='"+prdid+"' group by d.doc_no having  sum(d.qty-d.out_qty)>0 "
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
													 
													
													String sql="insert into my_delrd(tr_No,sr_no,rdocno,stockid,refstockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice,ref_row)VALUES"
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

													System.out.println("branchper--1->>>>Sql"+sql);
													prodet = stmt.executeUpdate (sql);
													 
													masterqty1=masterqty1+out_qty1;
			
			
												//	String sqls="update my_sorderd set out_qty="+masterqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+"";
													String delsqls="update my_deld set out_qty="+masterqty1+" where rdocno="+rdocno1+" and prdid="+prdid+" and  doc_no="+docno1+" and stockid="+dnstk+" ";
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
			
													String delsqls="update my_deld set out_qty="+balqty1+" where rdocno="+rdocno1+" and prdid="+prdid+" and  doc_no="+docno1+" and stockid="+dnstk+" ";
												//	String sqls="update my_sorderd set out_qty="+balqty1+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+"";	
													System.out.println("-2----sqls---"+delsqls);
			
													stmt.executeUpdate(delsqls);	
													
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
															+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[7].trim())+"','"+docno1+"')";
													//remqty=masterqty-qtys;
													prodet = stmt.executeUpdate (sql);
													
													System.out.println("branchper--2->>>>Sql"+sql);
			
			
												}

	
							 
								

							             }*/




						}

					}

				}



			}



			  conn.commit();
		}
		catch(Exception e){
			deldocno=0;
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return deldocno;
	}

	public  ClsDeliverynoteReturnBean getViewDetails(int docno,String branchid) throws SQLException{


		Connection conn =null;
		try {
			conn= ClsConnection.getMyConnection();

			Statement stmt = conn.createStatement ();

			String sql= ("select l.loc_name,m.locid,m.doc_no,m.voc_no,coalesce(m.refno,'') refno,m.date,m.dtype,cr.doc_no as currid,cr.code as curr,cr.c_rate as curate,m.brhid,ac.refname as name,ac.address as cladd,m.cldocno,coalesce(m.ref_type,'DIR') as ref_type ,coalesce(rrefno,'') as rrefno,coalesce(description,'') as descrptn,coalesce(payterms,'') as payterms,coalesce(s.doc_no,0) as salid,coalesce(s.sal_name,'') as sal_name,coalesce(m.amount,0.00) as proamt,coalesce(m.discount,0.00) as discount,coalesce(m.netAmount,0.00) as netotal,coalesce(m.disper,0.00) as discper,coalesce(m.grantamt,0.00) as ordervalue,coalesce(m.servamt,0.00) as servamt,coalesce(m.roundof,0.00) as roundof "
					+ "from my_delrm m left join my_delrd d on(m.doc_no=d.rdocno)  left join my_locm l on l.doc_no=m.locid left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') left join my_salm s on(s.doc_no=m.sal_id) left join my_curr cr on(m.curid=cr.doc_no) where m.doc_no="+docno+" and m.brhid="+branchid+"");

			System.out.println("==getViewDetails===="+sql);
			String dtype="";
			String sqot="";
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()){
				bean.setTxtlocation(rs.getString("loc_name"));
				bean.setLocationid(rs.getString("locid"));
				
				bean.setHiddate(rs.getString("date"));
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

			}


			int i=0;
			String qotdoc="";
			
				Statement stmt1  = conn.createStatement ();	
				String sqlss="select voc_no from  my_delm where doc_no in ("+sqot+") ";
				System.out.println("==getrefmasterdocno==="+sqlss);

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
		catch(Exception e){
			e.printStackTrace();
		}
		finally
		{
			conn.close();
		}

		return bean;
	}



	public int update(String voc_no,int doc_no,java.sql.Date date,String refno,String curr,String currate,int clientid,String rrefno,String rreftype,String locid,String payterms,String delterms,String desc,
			String mode,String formcode,ArrayList prodarray,HttpSession session,HttpServletRequest request,String refmasterdocno,String updatadata) throws SQLException{

		Connection conn=null;
		int deldocno=0;
		conn=ClsConnection.getMyConnection();

		try{

			conn.setAutoCommit(false);

			CallableStatement stmt = conn.prepareCall("{CALL deliveryReturnDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			 
			
			stmt.registerOutParameter(19, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			stmt.setString(2,refno);
			stmt.setInt(3, clientid);
			stmt.setInt(4, Integer.parseInt(curr));
			stmt.setDouble(5, Double.parseDouble(currate));
			stmt.setString(6,rreftype);
			stmt.setString(7,refmasterdocno);
			stmt.setInt(8, Integer.parseInt(locid));
			stmt.setString(9,payterms);
			stmt.setString(10,delterms);
			stmt.setString(11,desc);
			stmt.setString(12,mode);
			stmt.setString(13,formcode);
			stmt.setString(14, session.getAttribute("USERID").toString());
			stmt.setString(15, session.getAttribute("BRANCHID").toString());
			stmt.setString(16, session.getAttribute("COMPANYID").toString());
			stmt.setInt(17, doc_no);
			stmt.setInt(18, Integer.parseInt(voc_no));
			int val = stmt.executeUpdate();
			deldocno=stmt.getInt("deldocno");
			int vocno=stmt.getInt("vdocNo");
			int trno=stmt.getInt("strno");
			request.setAttribute("vdocNo", vocno);
			
			
			if(vocno>0){

				System.out.println("-----updatadata----------"+updatadata);
				if(updatadata.equalsIgnoreCase("Editvalue"))
				{
					System.out.println("-----IN----------");
				int prodet=0;
				int prodout=0;
				String docnoset="0,";
				
				
				int mm=0;
				
				for(int i=0;i< prodarray.size();i++){

					String[] prod=((String) prodarray.get(i)).split("::");
					if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")))){

                     
						
						 
							if(i==0)
							{
	        int counts=0;							
	        String tempstk="0";	
	        
	        int stkids=0;
	        
	        String tempstkids="0";
	      
	        int ref_row=0;	
			double prdqty=0;

			double saveqty=0;
			int tmptrno=0,unitid=0,refstockid=0;
			
			int prdidss=0;
			
			double delnqtys=0;
			
		//	----------------------
			
			double poutqty=0;
			
			double poutqtys=0;
			
			
			double savepoutqtys=0;
			
			int   pdocnos=0;
/*			
			-- select ref_row,qty from my_delrd where rdocno=1;


			select out_qty   from my_deld where doc_no=17;
			*/
		  	
			int kk=0;
			Statement stmnt1112=conn.createStatement();
			  Statement stmnt1111=conn.createStatement();	
			  
			  Statement st33=conn.createStatement();	
			  Statement st34=conn.createStatement();	
			  
			  
			  
			  String sql21="select * from my_prddin  where tr_no='"+trno+"' and dtype='DLR' and outdocno>0  ";
			  ResultSet rtk1111= stmnt1111.executeQuery(sql21);
		    	
		    	
		    	if(rtk1111.next())
		    	{
		    		
		    		kk=1;
		    	}
			
			
			
		    Statement stmnt=conn.createStatement();		
		    Statement stmnt1=conn.createStatement();
		    Statement stmnt3=conn.createStatement();
		    
		    Statement stmnt4=conn.createStatement();
		    
		    	String sql2="select ref_row,qty qty,prdid,tr_no,unitid,stockid, qty*fr outqty from my_delrd where rdocno='"+deldocno+"'";
		    	//System.out.println("-----sql2-----"+sql2);
		    	ResultSet rsstk111 = stmnt1.executeQuery(sql2);
		    	
		    	
		    	while(rsstk111.next())
		    	{
		    		ref_row=rsstk111.getInt("ref_row");
		    		delnqtys=rsstk111.getDouble("qty");
		    		prdidss=rsstk111.getInt("prdid");
		    		tmptrno=rsstk111.getInt("tr_no");
		    		unitid=rsstk111.getInt("unitid");
		  
		    		
		    		refstockid=rsstk111.getInt("stockid");
		    		
		    		
		    		poutqty=rsstk111.getDouble("outqty");
		    		double	remqty=0;
		    		
		    		if(kk==0)	
			    	{	
		    		
		    	String sqlss="select doc_no, out_qty from my_prddout where rdocno='"+ref_row+"' and prdid="+prdidss+" and out_qty!=0 ";
		    	
		    	//System.out.println("========sqlss===="+sqlss);
		    	
		    	ResultSet rssss=stmnt4.executeQuery(sqlss);
		    	
		    	loop:while (rssss.next())
		    		
		    	{
		    		
		    		poutqtys=rssss.getDouble("out_qty");
		    		
		    		pdocnos=rssss.getInt("doc_no");
		    		
		    	
		    		if(remqty>0)
					{

		    			poutqty=remqty;
					}
	
		    		
		    	//	System.out.println("========poutqtys out===="+poutqtys);
		    		
		    		//System.out.println("========poutqty ret===="+poutqtys);
		    		
		    		
		    		if(poutqty<=poutqtys)
		    		{
		    			 
		    			
		    			savepoutqtys=poutqtys-poutqty;
				    	
				    	if(savepoutqtys<0){
				    		savepoutqtys=0;
				    	
				    	}
		    			
				     	
				      	String sql31="update my_prddout set out_qty="+savepoutqtys+" where doc_no='"+pdocnos+"'  ";
				      	
				      	 
				      	
				    	 // System.out.println("-----sql31---1--"+sql31);
				    	 stmnt3.executeUpdate(sql31);
				    	 
		    			break loop;
		    			
		    		}
		    		
		    		else if(poutqty>poutqtys)
		    		{
		    			remqty=poutqty-poutqtys;
		    			
		    			
                           savepoutqtys=0;
				    	
                        	String sql31="update my_prddout set out_qty="+savepoutqtys+" where doc_no='"+pdocnos+"'  ";
    				      	
   				      	 
    				      	
    				    	//  System.out.println("-----sql31- 2----"+sql31);
    				    	 stmnt3.executeUpdate(sql31);
		    			
		    			
		    			
		    			
		    		}
		    		
		    		
		    		
		    		
		    		
		    		
		    	}
		    		
		    		
			    	}
		    		
		    		
		    	String sql3=" select out_qty   from my_deld where rdocno='"+ref_row+"' and prdid="+prdidss+"  and unitid="+unitid+"  and stockid="+refstockid+"  ";
		    	// System.out.println("-----sql3-----"+sql3);
		    	ResultSet rsstk1111 = stmnt.executeQuery(sql3);
		    	
		    	
		    	if(rsstk1111.next())
		    	{
		    		prdqty=rsstk1111.getDouble("out_qty");
			    	saveqty=prdqty-delnqtys;
			    	
			    	if(saveqty<0){
			    	saveqty=0;
			    	
			    	}
			    	
			      	String sql31="update my_deld set out_qty="+saveqty+"   where rdocno='"+ref_row+"' and prdid="+prdidss+"  and unitid="+unitid+"  and stockid="+refstockid+"  ";
			    //	 System.out.println("-----sql31-----"+sql31);
			    	 stmnt3.executeUpdate(sql31);
			    	 
			    	 
			    	 
			    	 
		    		
		    	}
		    	}
		    	
		    	
		    	
		    	if(kk==1)
		    	{
		    		
		    		int outdocno=0;
		    		int refstockids=0;
		    		double op_qty=0;
		    		double savedata=0;
		    		
		     
		    		
		    	 	String sql31111=" select op_qty,outdocno,refstockid   from my_prddin where tr_no="+trno+"  ";
			    	 
			    	 System.out.println("-----sql31111-----"+sql31111);
			    	ResultSet rsstk11111 = stmnt1112.executeQuery(sql31111);
			    	
			    	
			    	while(rsstk11111.next())
			    	{
			    		
			    		op_qty=0;
			    		outdocno=0;
			    		op_qty=rsstk11111.getDouble("op_qty");
			    		outdocno=rsstk11111.getInt("outdocno");
			    		refstockids=rsstk11111.getInt("refstockid");
			    		
			    		String sql312111="update my_prddin set out_qty=out_qty-"+op_qty+",del_qty=del_qty+"+op_qty+" where stockid='"+refstockids+"'  ";
				    	 
				    	 System.out.println("-----sql312111-----"+sql312111);
			    		 st34.executeUpdate(sql312111);
			    		
			    		
				    	
				     String selecsql="select out_qty from my_prddout where doc_no='"+outdocno+"' ";
				     
				     ResultSet rd1=st33.executeQuery(selecsql); 
				     
				     if(rd1.next())
				     {
				    	 savedata=rd1.getDouble("out_qty")-op_qty;
				    	 
				    	 if(savedata<=0)
				    	 {
				    		 savedata=0;
				    	 }
				    	 
				    	 String sql3121="update my_prddout set out_qty="+savedata+" where doc_no='"+outdocno+"'  ";
				    	 
				    	 System.out.println("-----sql3121-----"+sql3121);
			    		 st34.executeUpdate(sql3121);
			    	 
				    	 
				    		
				     }
				     
				   
			    		
			    	}	
		    		
		    		
		    		
		    	}
		    	

		    	 
		    	
							 
					 
							    String dql31="delete from my_delrd where rdocno='"+deldocno+"'";
							    
							//	System.out.println("-----dql31------------------------"+dql31);
							    
					    	 	  stmt.executeUpdate(dql31);
					    	 	    String dql311="delete from my_prddin where tr_no='"+trno+"'   and dtype='"+formcode+"' ";
						    	 	  stmt.executeUpdate(dql311); 
				    	 	  
						}
						
						
					 
						//System.out.println("-----deldocno------------------------"+deldocno);


						if(deldocno>0)
						{
							
							String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
							String specno=""+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"";
							String stkid=""+(prod[12].equalsIgnoreCase("undefined") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"";						 
							String  rqty=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
							double masterqty=Double.parseDouble(rqty);
							int oldStockid=0;
							Statement stmtstk1=conn.createStatement();
					/*		String stkid1="select refstockid from my_prddin where stockid='"+stkid+"'  ";
							ResultSet rsstk1 = stmtstk1.executeQuery(stkid1);
							
							if(rsstk1.next())
							{
								
								oldStockid=rsstk1.getInt("refstockid");
							}*/

							
							
						    String unitidss=""+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].trim().equalsIgnoreCase("")|| prod[1].isEmpty()?0:prod[1].trim())+"";
						    String prsros=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
						     
					    	 
					         
						     double fr=1;
						     String slss=" select fr from my_unit where psrno="+prsros+" and unit='"+unitidss+"' ";
						     
						   //  System.out.println("====slss==="+slss);
						     ResultSet rv1=stmt.executeQuery(slss);
						     if(rv1.next())
						     {
						    	 fr=rv1.getDouble("fr"); 
						     }
						     
						     
						     
						 	 String rdocno=""+(prod[14].trim().equalsIgnoreCase("undefined") || prod[14].trim().equalsIgnoreCase("NaN")|| prod[14].trim().equalsIgnoreCase("")|| prod[14].isEmpty()?0:prod[14].trim())+"";
						 	 String sqlssss="select  * from my_deld   where rdocno="+rdocno+" and stockid>0 ";
							 ResultSet rsss=stmt.executeQuery(sqlssss);
							 if(rsss.next())
							 {
								 
								 mm=1;
							 }
						 	
							  
							String sqlsss="insert into my_delrd(tr_No,sr_no,rdocno,stockid,refstockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice,ref_row,fr)VALUES"
									+ " ("+trno+","+(i+1)+",'"+deldocno+"',"
									+ "'"+0+"',"
									+ "'"+0+"',"
									+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
									+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
									+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
									+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
									+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
									+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
									+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"','"+rdocno+"',"+fr+")";
						//	System.out.println("--1--sqlsss--"+sqlsss);
							prodet = stmt.executeUpdate (sqlsss);
							
							double   out_qty=0;
							
							
							int stockidss=0;
							
							
							String delsqls1="select out_qty,stockid from  my_deld   where rdocno="+rdocno+" and prdid="+prdid+" and  unitid="+unitidss+"  ";
						//	System.out.println("==##############delsqls1#############################====\n"+delsqls1);
							
							
							ResultSet rssss=stmt.executeQuery(delsqls1);
							if(rssss.first())
							{
								out_qty=rssss.getDouble("out_qty");
								stockidss=rssss.getInt("stockid");
							}
							
							//System.out.println("-out_qty--"+out_qty);
						//	System.out.println("--masterqty-"+masterqty);
							if(stockidss==0)
							{
							out_qty=out_qty+masterqty;
							String delsqls="update my_deld set out_qty="+out_qty+" where rdocno="+rdocno+" and prdid="+prdid+" and  unitid="+unitidss+"  ";
							//System.out.println("--1---sqls---"+delsqls);
							stmt.executeUpdate(delsqls);

							}
							
							
						//	System.out.println("==############################################====\n");
							
							
							
							  double remqty=0;
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
								double del_qty=0.0;
								double unitprice=0.0;
								double costprice=0.0,prdout=0;
								 
								double pdelqty=0;
							 
								double savepdelqty=0;
								
								
								double outsave=0.0;
								
								String docnoss="";
								Statement stmtstk=conn.createStatement();

							//	Statement stmtstk1=conn.createStatement();
								
								
								//System.out.println("=masterqty=== ="+masterqty);

							//	System.out.println("=fr=== ="+fr);
								double masterqty1=masterqty*fr;
							//	System.out.println("=masterqty1=== ="+masterqty1);
								
					/*			String stkSql=" select o.del_qty,o.stockid,o.doc_no from my_deld d   left join my_prddout o on o.tr_no=d.tr_no and d.rdocno in("+rdocno+")"
										+ "left join my_prddin pin on pin.stockid=o.stockid and pin.psrno=o.psrno "
										+ " 	where   d.rdocno in("+rdocno+") and o.doc_no not in"
												+ " ("+docnoset.substring(0,docnoset.length() - 1)+") and   d.psrno='"+prdid+"' "
														+ " and d.specno='"+specno+"' and d.unitid="+unitidss+" and pin.unitid="+unitidss+" group by o.doc_no ";
								*/
								String stkSql=" select o.del_qty-coalesce(o.out_qty,0) del_qty ,o.stockid,o.doc_no from  my_prddout o  "
										+ " 	where   o.rdocno in("+rdocno+")    and  "
												+ " o.psrno='"+prdid+"' and o.specid='"+specno+"' and  o.del_qty>coalesce(o.out_qty,0)     group by o.doc_no ";
								

								//System.out.println("=stkSql=inside==================== insert="+stkSql);

								ResultSet rsstk = stmtstk.executeQuery(stkSql);

								while(rsstk.next()) {
									 
									docnoss=rsstk.getString("doc_no");
								 
									stockid=rsstk.getInt("stockid");
									del_qty=rsstk.getDouble("del_qty");
									 
									
								/*	 if(docnoset.equalsIgnoreCase("0"))
									 {
										 docnoset="0,";
									 }
									 else
									 {
										 docnoset=docnoss+","; 
									 }*/
										
										docnoset=docnoset+docnoss+",";
										
									/* 	 if(docnoset.endsWith(","))
											{
								    		 docnoset = docnoset.substring(0,docnoset.length() - 1);
											}*/
									 	 
									 	 
									 	// System.out.println("==========docnoset========"+docnoset);
									 	 
									 	 
										
									 String stkSql11="select i.unit_price,i.cost_price,i.del_qty from  my_prddin i where  i.stockid="+stockid+" " ;
									 
									 ResultSet rsstk1 = stmtstk1.executeQuery(stkSql11);

										if(rsstk1.next()) {
											unitprice=rsstk1.getDouble("unit_price");
											costprice=rsstk1.getDouble("cost_price");
											pdelqty=rsstk1.getDouble("del_qty");
										}
										String stkSql111="select out_qty from  my_prddout  where  doc_no="+docnoss+" " ;
										 
										 ResultSet rsstk11 = stmtstk1.executeQuery(stkSql111);

											if(rsstk11.next()) {
												prdout=rsstk11.getDouble("out_qty");
												 
												
											}
										 
									 
									 
										if(remqty>0)
										{

											masterqty1=remqty;
										}

										
									//	System.out.println("=masterqty1======== ="+masterqty1);
									//	System.out.println("=del_qty======== ="+del_qty);
										

										if(masterqty1<=del_qty)
										{
											 
											savepdelqty=pdelqty-masterqty1;
											if(savepdelqty<0) {savepdelqty=0; }

											String prodinsql="insert into my_prddin(sr_no,TR_NO, dtype,refstockid,unit_price,cost_price,specno, psrno,op_qty,prdid,brhid,locid,date,unitid,fr,outdocno) Values"
													+ " ("+(i+1)+",'"+trno+"','"+formcode+"',"
													+ "'"+stockid+"',"
													+ ""+unitprice+","
													+ ""+costprice+","
													+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
													+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
													+ "'"+masterqty1+"',"
													+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
													+"'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"','"+locid+"','"+date+"',"+unitidss+","+fr+","+docnoss+")";

											//System.out.println("prodinsql-1-->>>>Sql"+prodinsql);
											prodout = stmt.executeUpdate (prodinsql);
											String prodinsql111="update   my_prddin set out_qty=out_qty+"+masterqty1+",del_qty="+savepdelqty+" where stockid="+stockid+"";
											System.out.println("prodinsql111-1-->>>>Sql"+prodinsql111);
											prodout = stmt.executeUpdate (prodinsql111);
											outsave=prdout+masterqty1;
											String prodinsql1="update   my_prddout set out_qty="+outsave+" where doc_no="+docnoss+"";
											//System.out.println("prodinsql-1-->>>>Sql"+prodinsql1);
											prodout = stmt.executeUpdate (prodinsql1);
											if(mm==1)
											{
											
											String prodinsql11="update   my_deld set out_qty=out_qty+"+masterqty1+" where stockid="+stockid+" and psrno='"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"'";
										//	System.out.println("prodinsql11-1-->>>>Sql"+prodinsql11);
											prodout = stmt.executeUpdate (prodinsql11);
											
											}
											
											masterqty1=0;
											break;


										}
										else if(masterqty1>del_qty)
										{



											 
												remqty=masterqty1-del_qty;
												savepdelqty=pdelqty-del_qty;
												if(savepdelqty<0) {savepdelqty=0; }
												
												
												String prodinsql="insert into my_prddin(sr_no,TR_NO, dtype,refstockid,unit_price,cost_price,specno, psrno,op_qty,prdid,brhid,locid,date,unitid,fr,outdocno) Values"
														+ " ("+(i+1)+",'"+trno+"','"+formcode+"',"
														+ "'"+stockid+"',"
														+ ""+unitprice+","
														+ ""+costprice+","
														+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
														+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
														+ "'"+del_qty+"',"
														+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
														+"'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"','"+locid+"','"+date+"',"+unitidss+","+fr+","+docnoss+")";

											//	System.out.println("prodinsql--2->>>>Sql"+prodinsql);
												prodout = stmt.executeUpdate (prodinsql);

												 
												
												String prodinsql1111="update   my_prddin set out_qty=out_qty+"+del_qty+",del_qty="+savepdelqty+" where stockid="+stockid+"";
												System.out.println("prodinsql1111-2-->>>>Sql"+prodinsql1111);
												prodout = stmt.executeUpdate (prodinsql1111);
												
												outsave=prdout+del_qty;
												
												String prodinsql1="update   my_prddout set out_qty="+outsave+" where doc_no="+docnoss+"";
												//System.out.println("prodinsql-1-->>>>Sql"+prodinsql1);
												prodout = stmt.executeUpdate (prodinsql1);

												 
												if(mm==1)
												{
												String prodinsql11="update   my_deld set out_qty=out_qty+"+del_qty+" where stockid="+stockid+" and psrno='"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"'";
												//System.out.println("prodinsql11-1-->>>>Sql"+prodinsql11);
												prodout = stmt.executeUpdate (prodinsql11);
												}
												
												
											}


									 
										 
									 //	 System.out.println("==========docnoss========"+docnoss);
									 	 
										 

							
									 	if(masterqty1==0)
										{
											
											break;
										}
								    	 }
								    	  
								    	 
							 	
							
/*							double balstkqty=0;
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

							String stkSql="select d.rdocno,d.doc_no,d.stockid,d.psrno,d.specno,sum(d.qty) stkqty,sum(d.qty-d.out_qty) balstkqty,(d.out_qty) out_qty,sum(i.del_qty) as qty,m.date,i.unit_price,i.cost_price from my_delm m left join  my_deld d on(d.rdocno=m.doc_no) left join my_prddin i on(d.stockid=i.stockid) "
									+ "where d.rdocno in("+refmasterdocno+") and d.stockid="+oldStockid+"  and d.psrno='"+prdid+"' and d.specno='"+specno+"' and d.prdid='"+prdid+"' and m.brhid="+session.getAttribute("BRANCHID").toString()+" "
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
												+ "brhid='"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"' and locid='"+locid+"'";
								
					 

								System.out.println("prodinsql--->>>>Sql"+prodinsql);
								prodout = stmt.executeUpdate (prodinsql);


								if(masterqty<=balstkqty)
								{
									break;
								}

							}

*/

				/*			double masterqty1=masterqty;
							double balqty1=0;
							int docno1=0;
							int rdocno1=0;
							double remqty1=0;
							double out_qty1=0;
							double qtys1=0;
							int dnstk=0;
							 	double secqty=0;
							Statement stmt1=conn.createStatement();
							String strSql="select d.stockid,d.qty qty,sum((d.qty-d.out_qty)) balqty,d.doc_no,d.rdocno,d.out_qty out_qty,d.prdid  from my_delm m  left join "
									+ "my_deld d on m.doc_no=d.rdocno where d.rdocno in ("+refmasterdocno+") and d.stockid="+oldStockid+" and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and d.specno='"+specno+"' and d.prdid='"+prdid+"' group by d.doc_no having  sum(d.qty-d.out_qty)>0 "
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
												
												
												
												
												
												
												
												String sql="insert into my_delrd(tr_No,sr_no,rdocno,stockid,refstockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice,ref_row)VALUES"
														+ " ("+trno+","+(i+1)+",'"+deldocno+"',"
														+ "'"+stkid+"',"
														+ "'"+oldStockid+"',"
														+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
														+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
														+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
														+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
														+ "'"+masterqty1+"',"
														+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
														+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[7].trim())+"','"+docno1+"')";

												System.out.println("branchper--->>>>Sql"+sql);
												prodet = stmt.executeUpdate (sql);
												
												
												
												
												
												
												masterqty1=masterqty1+out_qty1;
		
		
											//	String sqls="update my_sorderd set out_qty="+masterqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+"";
												String delsqls="update my_deld set out_qty="+masterqty1+" where rdocno="+rdocno1+" and prdid="+prdid+" and  doc_no="+docno1+" and stockid="+oldStockid+" ";
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
		
												String delsqls="update my_deld set out_qty="+balqty1+" where rdocno="+rdocno1+" and prdid="+prdid+" and  doc_no="+docno1+" and stockid="+dnstk+" ";
											//	String sqls="update my_sorderd set out_qty="+balqty1+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+"";	
												System.out.println("-2----sqls---"+delsqls);
		
												stmt.executeUpdate(delsqls);	
												
												String sql="insert into my_delrd(tr_No,sr_no,rdocno,stockid,refstockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice,ref_row)VALUES"
														+ " ("+trno+","+(i+1)+",'"+deldocno+"',"
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
												prodet = stmt.executeUpdate (sql);
		
		
											}


						 
							

						             }*/

						}

					}

				}



			}

			}
			
			
			if(deldocno>0)
			{
			 conn.commit();		
				return deldocno;
			}
		}
		catch(Exception e){
			deldocno=0;
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return deldocno;
	}

	public int delete(String voc_no,int doc_no,java.sql.Date date,String refno,String pricegroup,String curr,String currate,int salesid,int clientid,String rrefno,String rreftype,String locid,String desc,
			String prodamt,String descount,String nettotal,String servamt,String roundof,String finalamt,String mode,String formcode,ArrayList prodarray,ArrayList termsarray,ArrayList servarray,HttpSession session,HttpServletRequest request,String qotmasterdocno,String descper) throws SQLException{

		Connection conn=null;
		int deldocno=0;
		conn=ClsConnection.getMyConnection();

		try{

			conn.setAutoCommit(false);

			CallableStatement stmt = conn.prepareCall("{CALL deliveryReturnDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");


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




						String sql="insert into my_delrd(sr_no,rdocno,stockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal)VALUES"
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

								String strSql="select d.qty qty,sum((d.qty-d.out_qty)) balqty,d.doc_no,d.rdocno,d.out_qty out_qty,d.prdid  from my_delrm m  left join "
										+ "my_delrd d on m.doc_no=d.rdocno where d.rdocno in ("+qotmasterdocno+") and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and d.prdid='"+prdid+"' group by d.doc_no having  sum(d.qty-d.out_qty)>0 "
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


	public    ClsDeliverynoteReturnBean getPrint(int docno, HttpServletRequest request) throws SQLException {
		ClsDeliverynoteReturnBean bean = new ClsDeliverynoteReturnBean();
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
				
				String resql=("select l.loc_name location,coalesce(mm.sal_name,'') sal_name,m.ref_type rdtype,if(m.ref_type!='DIR',m.rrefno,'') rrefno,'Delivery Note' type, "
						+ " m.doc_no,m.voc_no,m.refno, DATE_FORMAT(m.date,'%d.%m.%Y') AS date,h.description descs,h.account,m.acno,m.curId,m.rate,m.amount,m.disper,"
						+ " m.discount,round(m.netAmount,2) netAmount,m.delterms,m.payterms,m.description "
				+ "  from my_delrm m left join my_head h on h.doc_no=m.acno left join my_salm mm on mm.doc_no=m.sal_id left join my_locm l on l.doc_no=m.locid  where   m.doc_no='"+docno+"'");
				
				
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
		 
			       while(pintrs.next()){
			    	
			    	    bean.setLbldoc(pintrs.getInt("voc_no"));
			    	    bean.setLbldate(pintrs.getString("date"));
			    	    bean.setLblrefno(pintrs.getString("refno"));
			    	    bean.setLbldesc1(pintrs.getString("description"));
			    	    bean.setLbllocation1(pintrs.getString("location"));
			    	    bean.setLbldelterms(pintrs.getString("delterms"));
			    	    bean.setLbltype(pintrs.getString("type"));
			    	    bean.setLblvendoeacc(pintrs.getString("account"));  
			    	    bean.setLblvendoeaccName(pintrs.getString("descs"));
			    	    
			    	    
			    	    bean.setLblsalesPerson(pintrs.getString("sal_name"));
	 
			    	    
			    	  
			       }
				

				stmtprint.close();
				
				
				
				 Statement stmt10 = conn.createStatement ();
				    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from my_delrm r  "
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
				   	 Statement stmtgrid = conn.createStatement();       
				     String temp="";  
				       String	strSqldetail="Select d.specno specid ,m.part_no productid,m.productname, u.unit,round(sum(d.qty),2) qty    from my_delrd d "
	       			+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no    where d.rdocno='"+docno+"' group by d.stockid";
					
				        
				       
					ResultSet rsdetail=stmtgrid.executeQuery(strSqldetail);
					
					int rowcount=1;
			
					while(rsdetail.next()){
						 
							 
							temp=rowcount+"::"+rsdetail.getString("productid")+"::"+rsdetail.getString("productname")+"::"+
							rsdetail.getString("unit")+"::"+rsdetail.getString("qty") ;
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

