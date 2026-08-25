package com.dashboard.procurment.detailStockEnqiry;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsStockEnqiry {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	public JSONArray productSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql1="";
		

			String sql="select m.psrno doc_no,m.part_no prodcode,m.productname prodname,um.unit from my_main m inner join my_brand b on(m.brandid=b.doc_no)"
					+ "inner join my_catm c on(m.catid=c.doc_no) inner join my_scatm s on(m.scatid=s.doc_no) left join my_unit u on(u.psrno=m.psrno) left join my_unitm um on(um.doc_no=m.munit)  where m.status=3";
			System.out.println("==productSearch==="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	
	public JSONArray currentStock(HttpSession session,String branchid,String fromDate,String toDate,String hidproduct,String load) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();
		System.out.println("==load===="+load);
		if(!(load.equalsIgnoreCase("yes")))
		{
			return RESULTDATA;
		}
		
		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String minyom="",maxyom="";
			String sqljoin ="";
			String sql="";

					
			String sql1="",sql2="",sql3="",sql10="";


			java.sql.Date frmdate=ClsCommon.changeStringtoSqlDate(fromDate);

			java.sql.Date todate=ClsCommon.changeStringtoSqlDate(toDate);


			if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
				sql1="and pin.psrno ="+hidproduct+" ";
				
				
				sql3=" and psrno ="+hidproduct+" ";
				sql10= "  and psrno ="+hidproduct+" ";
			}
			
			if(!(branchid.equalsIgnoreCase("0") || branchid.equalsIgnoreCase("") || branchid.equalsIgnoreCase("undefined")|| branchid.equalsIgnoreCase("a"))){
				sql1=sql1+"and  pin.brhid ="+branchid+" ";
				
				sql3=sql3+"and  brhid ="+branchid+" ";
				
				
				sql10=sql10+"a nd  brhid ="+branchid+" ";
				
				
				sql2=" and  m.brhid ="+branchid+" ";
			}
/*			
			sqlfinal=sql1+sql2+sql3+sql4+sql5+sql6+sql7+sql8+sql9+sql10+sql11+sql12+sql13;

 		sqljoin = "left join my_main m on(b.psrno=m.psrno) "
					+ "left join my_prodsuit s on(m.doc_no=s.psrno) "
					+ "left join my_vehsuitmaster vs on(vs.doc_no=s.vehsuitid) "
					+ "left join my_ptype pt on(m.typeid=pt.doc_no) "
					+ "left join my_brand bd on(m.brandid=bd.doc_no) "
					+ "left join my_dept dep on(dep.doc_no=m.deptid) "
					+ "left join my_catm cat on(m.catid=cat.doc_no)"
					+ "left join my_scatm sc on(m.scatid=sc.doc_no)";
 

			sql="select stkid,b.pno,b.pname,b.psrno,b.specid, coalesce(if(b.bqty<0,0,b.bqty),0) as balqty,(b.bqty*b.unit_price) as balval,"
				+ "((b.bqty*b.unit_price)/b.bqty) as cpu,coalesce(rsvqty,0) as rsvqty,sum(p.rsv_qty) reserved,coalesce(delqty,0) as delqty,br.branchname brname,"
				+ "l.loc_name as locm,b.brhid,b.locid from "
				+ "((select part_no pno,productname  pname,a.psrno,a.specid,sum(a.qty) as qty,sum(a.qty) as bqty,"
				+ "a.date,unit_price,sum(iqty) iqty,brhid,locid,(sd.qty-sd.out_qty) as rsvqty,(dd.qty-dd.out_qty) as delqty,stkid from "
				+ "( select stockid stkid,p.psrno,specno specid,op_qty-(out_qty+rsv_qty+del_qty) qty,p.date,cost_price unit_price,op_qty as iqty,brhid,locid from my_prddin p "
				+ "union all select stockid stkid,p.psrno,p.specid,0 qty,p.date,0 unit_price,0 as iqty,brhid,locid"
				+ " from my_prddout p) as a left join my_sorderd sd on(sd.psrno=a.psrno) left join my_deld dd on(dd.psrno=a.psrno)"
				+ "left join my_main m on(a.psrno=m.psrno) where cast(a.date as date)>='"+frmdate+"' and cast(a.date as date)<='"+todate+"' group by a.psrno "
				+ "order by a.date) as b) left join my_prddin p on(p.psrno=b.psrno ) left join my_brch br on(br.doc_no=b.brhid)"
				+ "  left join my_locm l on(l.doc_no=b.locid) "+sqljoin+""
				+ " where 1=1 "+sqlfinal+" group by b.psrno";

			*/
			
			
			sql=" select a.brname,a.locm,a.stv balval,a.balqty,a.cpu,a.psrno,coalesce(a.ordqty,0) rsvqty,coalesce(a.delqty,0) delqty from "
				+ " (select coalesce(od.ordqty,0) ordqty,coalesce(del.delqty,0) delqty,br.branchname brname,l.loc_name as locm, pin.brhid,pin.psrno, "
				+ " stk.isscost isval,stk.stkqty-stk.issueqty balqty, "
				+ " stk.stcost_price-stk.isscost stv,pin.cost_price  cpu1 ,((stk.stcost_price-stk.isscost)/(stk.stkqty-stk.issueqty)) cpu "
				+ "  from my_prddin pin  left join  ( "
				+ " select  st.brhid,st.locid,sum(st.stkqty) stkqty,sum(st.stcost_price) "
				+ "   stcost_price,sum(st.issueqty) issueqty,  sum(st.isscost) isscost , st.Stockid,st.prdid "
				+ "   from(select brhid,locid,date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
				+ "    coalesce(aa.qty) issueqty,(out_qty+rsv_qty+del_qty)*cost_price isscost, pin.Stockid,pin.prdid "
				+ "    from my_prddin  pin left join (select sum(qty) qty,stockid from my_prddout where cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+sql10+" group by stockid) aa  on aa.stockid=pin.stockid  where    cast(pin.date as date)>='"+frmdate+"' and cast(pin.date as date)<='"+todate+"'  "+sql3+" "
				+ "    group by pin.Stockid) st group by st.prdid,st.brhid,st.locid) stk on stk.prdid=pin.prdid   and stk.brhid=pin.brhid and stk.locid=pin.locid  "
				+ " left join my_brch br on(br.doc_no=pin.brhid) "
				+ "	left join my_locm l on(l.doc_no=pin.locid) "
				+ " left join ( select  sum(qty-out_qty) ordqty,d.psrno from  my_sorderm m left join  my_sorderd d on(d.rdocno=m.doc_no) where  1=1 "
				+ " "+sql2+" group by d.psrno)  od on  od.psrno=pin.psrno "
				+ " left join ( select  sum(qty-out_qty) delqty,d.psrno from  my_delm m left join  my_deld d on(d.rdocno=m.doc_no) where  1=1 "
				+ " "+sql2+" group by d.psrno)  del on  od.psrno=pin.psrno "
				+ " where 1=1 "+sql1+"    group by pin.psrno,pin.brhid,pin.locid  ) a ";
			
			
			
/*			vselect a.brname,a.locm,a.stv balval,a.balqty,a.cpu,a.psrno,coalesce(a.ordqty,0) rsvqty,coalesce(a.delqty,0) delqty
			from  (select coalesce(od.ordqty,0) ordqty,coalesce(del.delqty,0) delqty,br.branchname brname,l.loc_name as locm,
					 pin.brhid,pin.psrno,  stk.isscost isval,stk.stkqty-stk.issueqty balqty,  stk.stcost_price-stk.isscost stv,pin.cost_price
					  cpu1 ,((stk.stcost_price-stk.isscost)/(stk.stkqty-stk.issueqty)) cpu   from my_prddin pin
					   left join  (  select st.brhid,st.locid, sum(st.stkqty) stkqty,sum(st.stcost_price)    stcost_price,sum(st.issueqty) issueqty,
					    sum(st.isscost) isscost , st.Stockid,st.prdid    from(select brhid,locid,date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price,
					         (out_qty+rsv_qty+del_qty) issueqty,(out_qty+rsv_qty+del_qty)*cost_price isscost, Stockid,prdid
					             from my_prddin where   1=1  and psrno =2      group by Stockid) st group by st.prdid,st.brhid,st.locid) stk
					             on stk.prdid=pin.prdid  and stk.brhid=pin.brhid and stk.locid=pin.locid left join my_brch br on(br.doc_no=pin.brhid)
					             left join my_locm l on(l.doc_no=pin.locid)  left join ( select  sum(qty-out_qty)
					              ordqty,d.psrno from  my_sorderm m left join  my_sorderd d on(d.rdocno=m.doc_no)
					              where  1=1   group by d.psrno)  od on  od.psrno=pin.psrno  left join
					              ( select  sum(qty-out_qty) delqty,d.psrno from  my_delm m left join
					               my_deld d on(d.rdocno=m.doc_no) where  1=1   group by d.psrno)  del on
					                od.psrno=pin.psrno  where 1=1 and pin.psrno =2    group by pin.psrno,pin.brhid,pin.locid ) a;
			
			*/
			

			System.out.println("==sql=================================================================="+sql);

			ResultSet resultSet = stmt.executeQuery(sql);


			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray transactionDetails(HttpSession session,String branchid,String fromDate,String toDate,String hidproduct,String trtype,String load) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();
		if(!(load.equalsIgnoreCase("yes")))
		{
			return RESULTDATA;
		}
		
		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String minyom="",maxyom="";
			String sqljoin ="";
			String sql="";
			
			String mtbl="";
			String dtbl="";
			if(trtype.equalsIgnoreCase("SOR")){
				mtbl="my_sorderm";
				dtbl="my_sorderd";
			}
			if(trtype.equalsIgnoreCase("DEL")){
				mtbl="my_delm";
				dtbl="my_deld";
			}
					
			String sqlfrm="",sqlto="",sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="",sql10="",sql11="",sql12="",sql13="",sqlfinal="";


			java.sql.Date frmdate=ClsCommon.changeStringtoSqlDate(fromDate);

			java.sql.Date todate=ClsCommon.changeStringtoSqlDate(toDate);


			if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
				sql11="and m.doc_no in ("+hidproduct+")";
			}
			
			if(!(branchid.equalsIgnoreCase("0") || branchid.equalsIgnoreCase("") || branchid.equalsIgnoreCase("undefined")|| branchid.equalsIgnoreCase("a"))){
				sql12="and d.brhid in ("+branchid+")";
			}
			
			sqlfinal=sql1+sql2+sql3+sql4+sql5+sql6+sql7+sql8+sql9+sql10+sql11+sql12+sql13;

			sqljoin = "left join my_main m on(ds.psrno=m.psrno) "
					+ "left join my_ptype pt on(m.typeid=pt.doc_no) "
					+ "left join my_brand bd on(m.brandid=bd.doc_no) "
					+ "left join my_dept dep on(dep.doc_no=m.deptid) "
					+ "left join my_catm cat on(m.catid=cat.doc_no)"
					+ "left join my_scatm sc on(m.scatid=sc.doc_no)" 
					+ "left join my_unit u on(m.psrno=u.psrno) "
					+ "left join my_unitm um on(um.doc_no=m.munit) "
					+ "left join my_head h on(h.doc_no=ms.acno )";


			sql="select DATE_FORMAT(ms.date,'%d-%m-%Y') date,ms.voc_no docno,h.description partyname,um.unit unit,sum(qty) as qty,sum(out_qty) as trhead,"
					+ "1 as size,sum(qty-out_qty) balance,ds.psrno from "+mtbl+" ms "
					+ "left join "+dtbl+" ds on (ms.doc_no=ds.rdocno)   "+sqljoin+""
				    + " where 1=1 and cast(ms.date as date)>='"+frmdate+"' and cast(ms.date as date)<='"+todate+"' "+sqlfinal+" group by ds.psrno  ";


			System.out.println("==transactionDetails===="+sql);

			ResultSet resultSet = stmt.executeQuery(sql);


			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	
	public JSONArray transactionPriceMasterDetails(HttpSession session,String branchid,String fromDate,String toDate,String hidproduct,String trtype,String load) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();
		if(!(load.equalsIgnoreCase("yes")))
		{
			return RESULTDATA;
		}
		
		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String minyom="",maxyom="";
			String sqljoin ="";
			String sql="";
			
			String forms1="";
			String forms="";
			
			String mtbl="";
			String dtbl="";
			
			if(trtype.equalsIgnoreCase("saldet")){
				mtbl="my_invm";
				dtbl="my_invd";
				
				forms= " , round(sd.nettotal/sd.qty,2) unit_price ";
				forms1=" sd.amount";
			}
			if(trtype.equalsIgnoreCase("lpurdet")){
				mtbl="my_srvm";
				dtbl="my_srvd";
				
				forms= " ,round(i.cost_price,2) unit_price ";
				forms1=" i.cost_price";
			}
					
			String sqlfrm="",sqlto="",sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="",sql10="",sql11="",sql12="",sql13="",sqlfinal="";


			java.sql.Date frmdate=ClsCommon.changeStringtoSqlDate(fromDate);

			java.sql.Date todate=ClsCommon.changeStringtoSqlDate(toDate);


			if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
				sql11="and m.doc_no in ("+hidproduct+")";
			}
			
			if(!(branchid.equalsIgnoreCase("0") || branchid.equalsIgnoreCase("") || branchid.equalsIgnoreCase("undefined")|| branchid.equalsIgnoreCase("a"))){
				sql12="and sm.brhid in ("+branchid+")";
			}
			
			sqlfinal=sql1+sql2+sql3+sql4+sql5+sql6+sql7+sql8+sql9+sql10+sql11+sql12+sql13;

			sqljoin = "left join my_main m on(sd.psrno=m.psrno) "
					+ "left join my_ptype pt on(m.typeid=pt.doc_no) "
					+ "left join my_brand bd on(m.brandid=bd.doc_no) "
					+ "left join my_dept dep on(dep.doc_no=m.deptid) "
					+ "left join my_catm cat on(m.catid=cat.doc_no)"
					+ "left join my_scatm sc on(m.scatid=sc.doc_no)" 
					+ "left join my_unit u on(m.psrno=u.psrno) "
					+ "left join my_unitm um on(um.doc_no=m.munit) "
					+ "left join my_head h on(h.doc_no=sm.acno and h.dtype='VND')";

			sql="select count(*) parties,round(sum(qty),2)  qty "+forms+" ,DATE_FORMAT(max(sm.date),'%d-%m-%Y') maxdate,DATE_FORMAT(min(sm.date),'%d-%m-%Y') mindate,"
					+ "coalesce(um.unit,'') as units,sd.psrno from "+mtbl+" sm left join "+dtbl+" sd "
					+ "on(sm.doc_no=sd.rdocno) left join my_prddin i on(sd.psrno=i.psrno and sd.stockid=i.stockid)   "+sqljoin+""
				    + " where 1=1 and cast(sm.date as date)>='"+frmdate+"' and cast(sm.date as date)<='"+todate+"' "+sqlfinal+" group by "+forms1+" ";


			System.out.println("==purchasePriceMasterDetails===="+sql);

			ResultSet resultSet = stmt.executeQuery(sql);


			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	
	public JSONArray transactionPriceDetails(HttpSession session,String branchid,String fromDate,String toDate,String hidproduct,String trtype) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String minyom="",maxyom="";
			String sqljoin ="";
			String sql="";
			String forms="";
			String forms1="";
			String mtbl="";
			String dtbl="";
			
			if(trtype.equalsIgnoreCase("saldet")){
				mtbl="my_invm";
				dtbl="my_invd";
				forms= " , round(sd.nettotal/sd.qty,2) unit_price ";
				forms1=" ,sd.amount";
			}
			if(trtype.equalsIgnoreCase("lpurdet")){
				mtbl="my_srvm";
				dtbl="my_srvd";
				forms= " ,round(i.cost_price,2) unit_price ";
				forms1=" ,i.cost_price";
			}
					
			String sqlfrm="",sqlto="",sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="",sql10="",sql11="",sql12="",sql13="",sqlfinal="";


			java.sql.Date frmdate=ClsCommon.changeStringtoSqlDate(fromDate);

			java.sql.Date todate=ClsCommon.changeStringtoSqlDate(toDate);


			if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
				sql11="and m.doc_no in ("+hidproduct+")";
			}

			
			if(!(branchid.equalsIgnoreCase("0") || branchid.equalsIgnoreCase("") || branchid.equalsIgnoreCase("undefined")|| branchid.equalsIgnoreCase("a"))){
				sql12="and sm.brhid in ("+branchid+")";
			}
			
			sqlfinal=sql1+sql2+sql3+sql4+sql5+sql6+sql7+sql8+sql9+sql10+sql11+sql12+sql13;

			sqljoin = "left join my_main m on(sd.psrno=m.psrno) "
					+ "left join my_ptype pt on(m.typeid=pt.doc_no) "
					+ "left join my_brand bd on(m.brandid=bd.doc_no) "
					+ "left join my_dept dep on(dep.doc_no=m.deptid) "
					+ "left join my_catm cat on(m.catid=cat.doc_no)"
					+ "left join my_scatm sc on(m.scatid=sc.doc_no)" 
					+ "left join my_unit u on(m.psrno=u.psrno) "
					+ "left join my_unitm um on(um.doc_no=m.munit) "
					+ "left join my_head h on(h.doc_no=sm.acno)";


			sql="select sm.voc_no,DATE_FORMAT(sm.date,'%d-%m-%Y') date,round(sum(sd.qty),2) qty,coalesce(um.unit,'') as units,sd.psrno,h.description as desc1 "+forms+" from "+mtbl+" sm "
					+ "left join "+dtbl+" sd on(sm.doc_no=sd.rdocno) left join my_prddin i on(sd.psrno=i.psrno and sd.stockid=i.stockid and sd.tr_no=i.tr_no)  "+sqljoin+""
				    + " where 1=1 and cast(sm.date as date)>='"+frmdate+"' and cast(sm.date as date)<='"+todate+"' "+sqlfinal+" group by sm.doc_no"+forms1+" ";


			System.out.println("==purchasePriceDetails===="+sql);

			ResultSet resultSet = stmt.executeQuery(sql);


			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	
}
