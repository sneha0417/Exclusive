package com.dashboard.procurment.stockLedger;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsStockLedger  { 
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	public JSONArray brandSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select doc_no,brand from my_brand where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray suitbrandSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select convert(doc_no,char(50)) as doc_no,brand from (select doc_no,brand from my_sbrand where status=3 union all select '-1','ALL') as a ";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}


	public JSONArray suitmodelSearch(HttpSession session,String brandid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			//String sql="select m.doc_no,model,brand from my_smodel m left join my_sbrand b on(m.brandid=b.doc_no) where b.status=3 and m.status=3 and b.doc_no in ("+brandid+")";
			String sql="select convert(doc_no,char(50)) as doc_no,model,brand from ( select m.doc_no,model,brand from my_smodel m left join my_sbrand b on(m.brandid=b.doc_no) where b.status=3 and m.status=3 and m.brandid='"+brandid+"' union all select '-1','ALL','') as a";
//			System.out.println("===modelSearch===="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray subModelSearch(HttpSession session,String brandid,String modelid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			//String sql="select m.doc_no,model,brand from my_smodel m left join my_sbrand b on(m.brandid=b.doc_no) where b.status=3 and m.status=3 and m.brandid='"+brandid+"'";
			String sql="select convert(doc_no,char(50)) as doc_no,submodel,model from "
					+ "( select m.doc_no,submodel,model from my_ssubmodel m left join my_smodel mo "
					+ "on(m.modelid=mo.doc_no) where mo.status=3 and m.status=3 and m.modelid="+modelid+""
					+ " and m.brandid="+brandid+" union all select '-1','ALL','') as a";
//			System.out.println("===subModelSearch===="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray yomSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			//String sql="select doc_no,yom from my_syom where status=3";
			String sql="select convert(doc_no,char(50)) as doc_no,yom from ( select doc_no,yom from my_syom where status=3 union all select '-1','ALL') as a";
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray suitSpec1Search(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			//String sql="select doc_no,spec from my_suitspec1 where status=3";
			String sql="select convert(doc_no,char(50)) as doc_no,spec from ( select doc_no,spec from my_suitspec1 where status=3 union all select '-1','ALL') as a";
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray suitSpec2Search(HttpSession session) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			//String sql="select doc_no,spec from my_suitspec2 where status=3";
			String sql="select convert(doc_no,char(50)) as doc_no,spec from ( select doc_no,spec from my_suitspec2 where status=3 union all select '-1','ALL') as a";
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray suitSpec3Search(HttpSession session) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			//String sql="select doc_no,spec from my_suitspec3 where status=3";
			String sql="select convert(doc_no,char(50)) as doc_no,spec from ( select doc_no,spec from my_suitspec3 where status=3 union all select '-1','ALL') as a";
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray typeSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select doc_no,producttype ptype from my_ptype where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray productSearch(HttpSession session,String brandid,String catid,String subcatid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql1="";
			//System.out.println("brandid===="+brandid);
			if(!(brandid.equals("0") || brandid.equals(""))){
				sql1="and b.doc_no in ("+brandid+")";
			}

			String sql2="";
			//System.out.println("brandid===="+brandid);
			if(!(catid.equals("0") || catid.equals(""))){
				sql2="and c.doc_no in ("+catid+")";
			}

			String sql3="";
			//System.out.println("brandid===="+brandid);
			if(!(subcatid.equals("0") || subcatid.equals(""))){
				sql3="and s.doc_no in ("+subcatid+")";
			}


			String sql="select m.doc_no,m.part_no prodcode,m.productname prodname,b.brand from my_main m inner join my_brand b on(m.brandid=b.doc_no)"
					+ "inner join my_catm c on(m.catid=c.doc_no) inner join my_scatm s on(m.scatid=s.doc_no)  where m.status=3 "+sql1+" "+sql2+" "+sql3+"";
//			System.out.println("==productSearch==="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray catSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select category cat,doc_no  from my_catm where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray deptSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "select department dept, doc_no from my_dept where status<>7";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray subCatSearch(HttpSession session,String catid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "select subcategory subcat,s.doc_no,category cat  from my_scatm s inner join my_catm c on(c.doc_no=s.catid) and c.doc_no in ("+catid+")";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}


	public JSONArray partSearch(HttpSession session,String hidbrand,String fromDate,String toDate,String hidtype,String hidcat,
			String hidsubcat,String hidproduct,String branchid,String hidept) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String minyom="",maxyom="";
			String sql ="";
			//System.out.println("==hidsbrand==="+hidsbrand+"==hidsmodel=="+hidsmodel+"==hidyom==="+hidyom+"=hidspec1=="+hidspec1+"==hidspec2=="+hidspec2+"==hidspec3=="+hidspec3+"==hidbrand==="+hidbrand+"==hidcat==="+hidcat+"==hidsubcat=="+hidsubcat+"==hidproduct="+hidproduct);


			String sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="",sql10="",sql11="",sql12="",sql13="",sqlfinal="";

			if(!(hidbrand.equals("0") || hidbrand.equals("") || hidbrand.equals("undefined"))){
				sql7="and b.doc_no in ("+hidbrand+")";
			}

			if(!(hidtype.equals("0") || hidtype.equals("") || hidtype.equals("undefined"))){
				sql8="and pt.doc_no in ("+hidtype+")";
			}

			if(!(hidcat.equals("0") || hidcat.equals("") || hidcat.equals("undefined"))){
				sql9="and c.doc_no in ("+hidcat+")";
			}
			if(!(hidsubcat.equals("0") || hidsubcat.equals("") || hidsubcat.equals("undefined"))){
				sql10="and sc.doc_no in ("+hidsubcat+")";
			}

			if(!(hidproduct.equals("0") || hidproduct.equals("") || hidproduct.equals("undefined"))){
				sql11="and m.doc_no in ("+hidproduct+")";
			}
			if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
				sql12="and d.brhid in ("+branchid+")";
			}
			if(!(hidept.equals("0") || hidept.equals("") || hidept.equals("undefined"))){
				sql13="and dep.doc_no in ("+hidept+")";
			}

			sqlfinal=sql1+sql2+sql3+sql4+sql5+sql6+sql7+sql8+sql9+sql10+sql11+sql12+sql13;




			sql = "select  m.psrno,m.part_no product,m.productname pdesc,pt.producttype as type,b.brand as brand,c.category as cat,sc.subcategory as scat,"
					+ "br.branchname as branch,"
					+ "dep.department as dept from my_main m inner join my_desc d on(m.doc_no=d.psrno) "
					+ "left join my_prodsuit s on(m.doc_no=s.psrno) left join my_vehsuitmaster vs on(vs.doc_no=s.vehsuitid) "
					+ "left join my_ptype pt on(m.typeid=pt.doc_no) left join my_brand b on(m.brandid=b.doc_no) "
					+ "left join my_dept dep on(dep.doc_no=m.deptid) left join my_catm c on(m.catid=c.doc_no) "
					+ "left join my_scatm sc on(m.scatid=sc.doc_no)  "
					+ "left join my_brch br on(br.doc_no=d.brhid)"
					+ "where m.status=3 "+sqlfinal+" group by m.doc_no ";

//			System.out.println("==sql=type1==="+sql);

			ResultSet resultSet = stmt.executeQuery(sql);


			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
/*	sql="   select * from (select 'in' valtype, ins.tr_no, ins.psrno,ins.date,h.description,ins.stockid,ins.dtype,ins.docno,ins.acno,ins.inqty,ins.inval,ins.isqty, "
			 + "	ins.isval,ins.balqty,ins.balcost,ins.cpu from  "
			 + "(select pin.tr_no,pin.stockid, case when pin.dtype='GRN' then GRN.voc_no   when pin.dtype='PIV' then PIV.voc_no  "
			 + "when pin.dtype='DLR' then DLR.voc_no  when pin.dtype='INR' then INR.voc_no  "
			 + "when  pin.dtype='ITR' then ITR.voc_no   when  pin.dtype='GIR' then GIR.voc_no  else ''  end as DOCNO,  "
			 + "case when pin.dtype='GRN' then GRN.acno   when pin.dtype='PIV' then PIV.acno  "
			 + "when pin.dtype='DLR' then DLR.acno  when pin.dtype='INR' then INR.acno  "
			 + "when  pin.dtype='ITR' then ITR.acno   when  pin.dtype='GIR' then GIR.acno  else ''  end as acno,  "
			 + "pin.dtype, pin.brhid,pin.psrno,pin.date ,pin.op_qty inqty ,pin.op_qty*pin.cost_price inval ,  "
			 + " ' ' isqty, ' '  isval,  "
			 + " (pin.op_qty-(pin.out_qty+pin.rsv_qty+pin.del_qty)) balqty, (pin.op_qty-(pin.out_qty+pin.rsv_qty+pin.del_qty))*cost_price balcost,  "
			 + " cost_price cpu  from my_prddin pin  "
			  + "left join my_grnm GRN on GRN.tr_no=pin.tr_no and pin.dtype='GRN'  "
			  + "left join my_srvm piv on PIV.tr_no=pin.tr_no and pin.dtype='PIV'  "
			  + "left join my_delrm DLR on DLR.tr_no=pin.tr_no and pin.dtype='DLR'  "
			  + "left join   my_invr  INR on INR.tr_no=pin.tr_no and pin.dtype='INR'  "
			  + "left join   my_invtranreceptm  ITR on ITR.tr_no=pin.tr_no and pin.dtype='ITR'  "
			  + "left join   my_girm  GIR on GIR.tr_no=pin.tr_no and pin.dtype='GIR' where 1=1  "
			  + "group by pin.stockid order by pin.stockid) ins  "
			  + "left join my_head h on(h.doc_no=ins.acno)  "
			  + " union all  "
			 + " select 'out' valtype, outs.tr_no,outs.psrno, outs.date,h.description,outs.Stockid,outs.dtype,outs.docno,  "
			 + " outs.acno,' ' inqty,' ' inval,outs.issqty isqty,outs.issqty*outs.issuecostprice isval ,  "
			  + "' 'balqty,' ' balcost, '' cpu  "
			  + "from (select pout.tr_no,pout.psrno,pout.Stockid,pout.dtype,cast(pout.date as date) date,  "
			  + "case when pout.dtype='GRR' then GRR.voc_no   when pout.dtype='PIR' then PIR.voc_no  "
		 + "	when pout.dtype='SOR' then SOR.voc_no  when pout.dtype='JOR' then JOR.voc_no  "
		 + "	when  pout.dtype='DEL' then DEL.voc_no   when  pout.dtype='INV' then INV.voc_no  when  pout.dtype='ITI' then ITI.voc_no  "
		 + "	when  pout.dtype='GIS' then GIS.voc_no  "
		 + "	else ''  end as DOCNO,  "
		 + "	case when pout.dtype='GRR' then GRR.acno   when pout.dtype='PIR' then PIR.acno  "
			 + "when pout.dtype='SOR' then SOR.acno  "
			 + " when  pout.dtype='DEL' then DEL.acno   when  pout.dtype='INV' then INV.acno  when  pout.dtype='ITI' then ITI.acno  "
		 + "	when  pout.dtype='GIS' then GIS.acno  "
		 + "	else ''  end as acno, case when  pout.dtype='DEL' then  "
		  + "	(select sum(del_qty) from my_prddout where Stockid=pout.stockid group by stockid)  "
		 + "	when  pout.dtype='SOR' ||  pout.dtype='JOR' then  "
		 + "	(select sum(rsv_qty) from my_prddout where Stockid=pout.stockid group by stockid)  "
		 + "	else pout.qty end as issqty, p.cost_price issuecostprice  "
		 + "	from my_prddout pout left join  my_prddin p     on pout.stockid=p.stockid  "
		 + "	left join my_grrm GRR on GRR.tr_no=pout.tr_no and pout.dtype='GRR'  "
		 + "	left join my_srvm PIR on PIR.tr_no=pout.tr_no and pout.dtype='PIR'  "
		 + "	left join my_sorderm SOR on SOR.tr_no=pout.tr_no and pout.dtype='SOR'  "
		 + "	left join   my_joborderm  JOR on JOR.tr_no=pout.tr_no and pout.dtype='JOR'  "
		 + "	left join   my_delm  DEL on DEL.tr_no=pout.tr_no and pout.dtype='DEL'  "
		 + "	left join   my_invm  INV on INV.tr_no=pout.tr_no and pout.dtype='INV'  "
		 + "	left join   my_invtranissuem ITI on ITI.tr_no=pout.tr_no and pout.dtype='ITI'  "
			 + "left join   my_gism  GIS on GIS.tr_no=pout.tr_no and GIS.dtype='GIS'  "
		 + "	where 1=1 order by stockid,pout.doc_no) outs  "
			 + "left join my_head h on(h.doc_no=outs.acno) ) res order by res.stockid,res.tr_no  ";

			  ;*/
	

	public JSONArray stockLedgerSummary(HttpSession session,String hidbrand,String fromDate,String toDate,String hidtype,String hidcat,
			String hidsubcat,String hidproduct,String branchid,String hidept,String load) throws SQLException {


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

			String sqlfrm="",sqlto="",sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="",sql10="",sql11="",sql12="",sql13="",sqlfinal="";

			String insqls1="";
			String insqls2="";
			java.sql.Date frmdate=ClsCommon.changeStringtoSqlDate(fromDate);

			java.sql.Date todate=ClsCommon.changeStringtoSqlDate(toDate);

			if(!(hidbrand.equalsIgnoreCase("0") || hidbrand.equalsIgnoreCase("") || hidbrand.equalsIgnoreCase("undefined"))){
				sql7=" and bd.doc_no in ("+hidbrand+")";
			}

			if(!(hidtype.equalsIgnoreCase("0") || hidtype.equalsIgnoreCase("") || hidtype.equalsIgnoreCase("undefined"))){
				sql8=" and pt.doc_no in ("+hidtype+")";
			}

			if(!(hidcat.equalsIgnoreCase("0") || hidcat.equalsIgnoreCase("") || hidcat.equalsIgnoreCase("undefined"))){
				sql9=" and cat.doc_no in ("+hidcat+")";
			}
			if(!(hidsubcat.equalsIgnoreCase("0") || hidsubcat.equalsIgnoreCase("") || hidsubcat.equalsIgnoreCase("undefined"))){
				sql10=" and sc.doc_no in ("+hidsubcat+")";
			}

			if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
				sql11=" and m.doc_no in ("+hidproduct+")";
			}
			 if(!(branchid.equalsIgnoreCase("0") || branchid.equalsIgnoreCase("") || branchid.equalsIgnoreCase("undefined")|| branchid.equalsIgnoreCase("a"))){
		 sql12="and stks.brhid="+branchid+"  ";
				
				insqls2="and pin.brhid="+branchid+"  ";
				
				insqls1= " and brhid="+branchid+" ";
				
				
			} 
			if(!(hidept.equalsIgnoreCase("0") || hidept.equalsIgnoreCase("") || hidept.equalsIgnoreCase("undefined"))){
				sql13=" and dep.doc_no in ("+hidept+")";
			}
			sqlfinal=sql1+sql2+sql3+sql4+sql5+sql6+sql7+sql8+sql9+sql10+sql11+sql12+sql13;
			sqljoin =  "left join my_ptype pt on(m.typeid=pt.doc_no) "
					+ "left join my_brand bd on(m.brandid=bd.doc_no) "
					+ "left join my_dept dep on(dep.doc_no=m.deptid) "
					+ "left join my_catm cat on(m.catid=cat.doc_no)"
					+ "left join my_scatm sc on(m.scatid=sc.doc_no)";

/*			sqljoin = "left join my_main m on(b.psrno=m.psrno) "
					+ "left join my_prodsuit s on(m.doc_no=s.psrno) "
					+ "left join my_vehsuitmaster vs on(vs.doc_no=s.vehsuitid) "
					+ "left join my_ptype pt on(m.typeid=pt.doc_no) "
					+ "left join my_brand bd on(m.brandid=bd.doc_no) "
					+ "left join my_dept dep on(dep.doc_no=m.deptid) "
					+ "left join my_catm cat on(m.catid=cat.doc_no)"
					+ "left join my_scatm sc on(m.scatid=sc.doc_no)";
*/
			/*					sql="select b.pno,b.pname,b.psrno,b.specid,coalesce(if(d.opnqty<0,0,d.opnqty),0) as opnqty,coalesce(if(b.qty<0,0,b.qty),0) as inqty,coalesce(if(e.isqty<0,0,e.isqty),0) as isqty, "
							+ "coalesce(if(b.bqty<0,0,b.bqty),0) as balqty,b.date,(b.bqty*b.unit_price) as stv,((b.bqty*b.unit_price)/b.bqty) as cpu from ( "
							+ "(select part_no pno,productname  pname,a.psrno,a.specid,qty,sum(qty) as bqty,a.date,unit_price from ( "
							+ "select stockid stkid,p.psrno,specno specid,op_qty qty,p.date,unit_price from my_prddin p "
							+ "union all "
							+ "select stockid stkid,p.psrno,p.specid,(qty*-1+rsv_qty*-1+del_qty*-1) qty,p.date,0 unit_price from my_prddout p) as a"
							+ " left join my_main m on(a.psrno=m.psrno) where cast(a.date as date)>='"+frmdate+"' and "
							+ "cast(a.date as date)<='"+todate+"' group by a.psrno order by a.date) as b "
							+ "left join (select c.psrno,qty,sum(qty) as opnqty,c.date from "
							+ "(select stockid stkid,p.psrno,specno specid,op_qty qty,p.date from my_prddin p "
							+ "union all "
							+ "select stockid stkid,p.psrno,p.specid,(qty*-1+rsv_qty*-1+del_qty*-1) qty,p.date from my_prddout p) as c"
							+ "  where cast(c.date as date)<'"+frmdate+"' "
							+ "group by c.psrno order by c.date) as d "
							+ "on (b.psrno=d.psrno) "
							+ "left join ( select p.psrno,p.specid,sum(p.qty+p.rsv_qty+p.del_qty) isqty  from my_prddout p "
							+ "where cast(p.date as date)>='"+frmdate+"' and "
							+ "cast(date as date)<='"+todate+"' group by p.psrno) as e on(e.psrno=b.psrno)) "+sqljoin+" where 1=1 "+sqlfinal+" group by b.psrno";
			 */
		/*//krish	sql="select b.pno,b.pname,b.psrno,b.specid,coalesce(if(d.opnqty<0,0,d.opnqty),0) as opnqty, "
					+ "coalesce(if(d.opnqty<0,0,d.opnqty),0)*b.unit_price as opnval, "
					+ "coalesce(if(b.iqty<0,0,b.iqty),0) as inqty, "
					+ "coalesce(if(b.iqty<0,0,b.iqty),0)*b.unit_price as inval, "
					+ "coalesce(if(e.isqty<0,0,e.isqty),0) as isqty, "
					+ "coalesce(if(e.isqty<0,0,e.isqty),0) *b.unit_price as isval, "
					+ "coalesce(if(b.bqty<0,0,b.bqty),0) as balqty,b.date,(b.bqty*b.unit_price) as stv, "
					+ "((b.bqty*b.unit_price)/b.bqty) as cpu from ( "
					+ "(select part_no pno,productname  pname,a.psrno,a.specid,sum(qty) as qty,sum(qty) as bqty,a.date,unit_price,sum(iqty) iqty from "
					+ "( select stockid stkid,p.psrno,specno specid,op_qty qty,p.date,unit_price,op_qty as iqty from my_prddin p "
					+ "union all "
					+ "select stockid stkid,p.psrno,p.specid,(qty*-1+rsv_qty*-1+del_qty*-1) qty,p.date,0 unit_price,0 as iqty from my_prddout p) as a "
					+ "left join my_main m on(a.psrno=m.psrno) where cast(a.date as date)>='"+frmdate+"' and cast(a.date as date)<='"+todate+"' "
					+ "group by a.psrno order by a.date) as b "
					+ "left join (select c.psrno,qty,sum(qty) as opnqty,c.date from "
					+ "(select stockid stkid,p.psrno,specno specid,op_qty qty,p.date from my_prddin p "
					+ "union all select stockid stkid,p.psrno,p.specid,(qty*-1+rsv_qty*-1+del_qty*-1) qty,p.date from my_prddout p) as c "
					+ "where cast(c.date as date)<'"+frmdate+"' group by c.psrno order by c.date) as d on (b.psrno=d.psrno) "
					+ "left join ( select p.psrno,p.specid,sum(p.qty+p.rsv_qty+p.del_qty) isqty  from my_prddout p "
					+ "where cast(p.date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' group by p.psrno) as e on(e.psrno=b.psrno)) "+sqljoin+" where 1=1 "+sqlfinal+" group by b.psrno";

*/
/*			sql="select m.part_no pno,m.productname  pname,stks.* from (  "
					+ "select  pin.brhid,pin.psrno,date,coalesce(ops.opqty,0) opnqty,coalesce(ops.cost_price,0) opnval "
					+ ",stk.stkqty inqty ,stk.stcost_price inval ,stk.issueqty isqty,stk.isscost isval,stk.stkqty-stk.issueqty balqty, "
					+ "stk.stcost_price-stk.isscost stv,pin.cost_price  cpu1 ,((stk.stcost_price-stk.isscost)/(stk.stkqty-stk.issueqty)) cpu from my_prddin pin  left join "
					+ " (select sum(op.opqty) opqty,sum(op.cost_price)  cost_price,op.Stockid,op.prdid from( "
					+ "select date,(op_qty)-(out_qty+rsv_qty+del_qty) opqty ,((op_qty)-(out_qty+rsv_qty+del_qty))*cost_price "
					 + "cost_price,Stockid,prdid from my_prddin where  cast(date as date)<'"+frmdate+"' "+insqls1+"  group by Stockid "
					+ " ) op group by op.prdid) ops on ops.prdid=pin.prdid left join (select sum(st.stkqty) stkqty,sum(st.stcost_price)  stcost_price,sum(st.issueqty) issueqty, "
					 + " sum(st.isscost) isscost , st.Stockid,st.prdid from(select date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
					 + " (out_qty+rsv_qty+del_qty) issueqty,(out_qty+rsv_qty+del_qty)*cost_price isscost, Stockid,prdid from my_prddin where "
					+ "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  group by Stockid "
					+ "  ) st group by st.prdid) stk on stk.prdid=pin.prdid where cast(pin.date as date)>='"+frmdate+"' "
					 + "  and cast(pin.date as date)<='"+todate+"' "+insqls2+"  group by pin.psrno) stks "
                   + "	left  join my_main m on(stks.psrno=m.psrno) "+sqljoin+"  where 1=1  "+sqlfinal+" " ;*/

/*			
			sql="select m.part_no pno,m.productname  pname,stks.* from (  "
					+ "select  pin.brhid,pin.psrno,date,coalesce(ops.opqty,0) opnqty,coalesce(ops.cost_price,0) opnval "
					+ ",stk.stkqty inqty ,stk.stcost_price inval ,stk.issueqty isqty,stk.isscost isval, "
					+ " (coalesce(stk.stkqty,0)-coalesce(stk.issueqty,0))+coalesce(ops.opqty,0) balqty , "
					+ "  (coalesce(stk.stcost_price,0)-coalesce(stk.isscost,0))+coalesce(ops.cost_price,0) stv,pin.cost_price  cpu1 , "
					+ " (((coalesce(stk.stcost_price,0)-coalesce(stk.isscost,0))+coalesce(ops.cost_price,0))/"
					+ " ((coalesce(stk.stkqty,0)-coalesce(stk.issueqty,0))+coalesce(ops.opqty,0))) cpu  "
					+ "  from my_prddin pin  left join "
					+ " (select sum(op.opqty) opqty,sum(op.cost_price)  cost_price,op.Stockid,op.prdid from( "
					+ "select date,(op_qty)-(out_qty+rsv_qty+del_qty) opqty ,((op_qty)-(out_qty+rsv_qty+del_qty))*cost_price "
					 + "cost_price,Stockid,prdid from my_prddin where  cast(date as date)<'"+frmdate+"' "+insqls1+"  group by Stockid "
					+ " ) op group by op.prdid) ops on ops.prdid=pin.prdid left join (select sum(st.stkqty) stkqty,sum(st.stcost_price)  stcost_price,"
					+ " sum(st.issueqty) issueqty, "
					 + " sum(st.isscost) isscost , st.Stockid,st.prdid from(select date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
					 + " (out_qty+rsv_qty+del_qty) issueqty,(out_qty+rsv_qty+del_qty)*cost_price isscost, Stockid,prdid from my_prddin where "
					+ "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  group by Stockid "
					+ "  ) st group by st.prdid) stk on stk.prdid=pin.prdid where  1=1  "+insqls2+"  group by pin.psrno) stks "
                   + "	left  join my_main m on(stks.psrno=m.psrno) "+sqljoin+"  where 1=1 and"
                   		+ "  (opnqty!=0 or opnval!=0 or inqty!=0 or inval!=0 or isqty!=0 or isval!=0 or balqty!=0 or stv!=0)  "+sqlfinal+" " ;
			
			*/
			
			
			
			sql="select m.part_no pno,m.productname  pname,stks.* from (  "
					+ "select  pin.brhid,pin.psrno,date,coalesce(ops.opqty,0) opnqty,coalesce(ops.cost_price,0) opnval "
					+ ",stk.stkqty inqty ,stk.stcost_price inval ,iss.issueqty isqty,iss.isscost isval, "
					+ " (coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0) balqty , "
					+ "  (coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0) stv,pin.cost_price  cpu1 , "
					+ " (((coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0))/"
					+ " ((coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0))) cpu  "
					+ "  from my_prddin pin  left join "
					+ " ( select sum(op.opqty) opqty,sum(op.cost_price)  cost_price,op.Stockid,op.prdid from ( "
					+ "select p.date,(p.op_qty)-(coalesce(a.outqty,0)) opqty ,((op_qty)-(coalesce(a.outqty,0)))*p.cost_price "
					 + " cost_price,p.Stockid,p.prdid from my_prddin  p	left join ( select sum(qty) outqty,stockid from my_prddout where"
					 + "    cast(date as date)<'"+frmdate+"' "+insqls1+" group by stockid ) a on a.stockid=p.stockid  "
					 + " where  cast(date as date)<'"+frmdate+"' "+insqls1+"  group by p.Stockid "
					+ " ) op group by op.prdid ) ops on ops.prdid=pin.prdid left join ( select sum(st.stkqty) stkqty,sum(st.stcost_price)  stcost_price,"
				  +" st.Stockid,st.prdid from(select date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
					 + "   Stockid,prdid from my_prddin where "
					+ "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  group by Stockid "
					+ "  ) st group by st.prdid ) stk on stk.prdid=pin.prdid"
					+ " left join (select sum(coalesce(a.outqty,0)) issueqty,sum(coalesce(outcost,0)) isscost,prdid from   (select a.outqty ,a.outqty*p.cost_price outcost, a.prdid from "
					+ "	(select sum(qty+del_qty) outqty,stockid,prdid from my_prddout where "
					+ "	cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"   group by stockid) a "
					+ "		left join my_prddin p on a.stockid=p.stockid )  a where 1=1 group by a.prdid ) iss on iss.prdid=pin.prdid "
					+ "  where  1=1  "+insqls2+"  group by pin.psrno) stks "
                   + "	left  join my_main m on(stks.psrno=m.psrno) "+sqljoin+"  where 1=1 and"
                   		+ "  (opnqty!=0 or opnval!=0 or inqty!=0 or inval!=0 or isqty!=0 or isval!=0 or balqty!=0 or stv!=0)  "+sqlfinal+" " ;
			
			
/*			
			select p.date,(p.op_qty)-(a.outqty) opqty
		       ,((op_qty)-(a.outqty))*p.cost_price  cost_price,p.Stockid,p.prdid from my_prddin  p
		       	left join (select sum(qty) outqty,stockid from my_prddout where
		           cast(date as date)<'2017-01-01'    group by stockid) a
		           on a.stockid=p.stockid  where  cast(p.date as date)<'2017-01-01'   group by p.Stockid ;

		select sum(stkqty) stkqty ,sum(stcost_price) stkcost from (select p.date,(p.op_qty) stkqty ,(p.op_qty)*p.cost_price stcost_price,
		   p.Stockid, prdid from my_prddin  p
		             where   cast(p.date as date)>='2017-01-01' and cast(p.date as date)<='2017-01-11'
		               group by p.Stockid) a group by a.prdid;

		select sum(a.outqty) outqty,sum(outcost) outcost from   (select a.outqty ,a.outqty*p.cost_price outcost, a.prdid from
		(select sum(qty) outqty,stockid,prdid from my_prddout where
		cast(date as date)>='2017-01-01' and cast(date as date)<='2017-01-11'    group by stockid) a
		left join my_prddin p on a.stockid=p.stockid )  a where 1=1 group by a.prdid;*/
			
			
			

			System.out.println("==sql==========="+sql);

			ResultSet resultSet = stmt.executeQuery(sql);


			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray stockLedgerSummary1(HttpSession session,String hidbrand,String fromDate,String toDate,String hidtype,String hidcat,
			String hidsubcat,String hidproduct,String branchid,String hidept,String load) throws SQLException {


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

			String sqlfrm="",sqlto="",sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="",sql10="",sql11="",sql12="",sql13="",sqlfinal="";

			String insqls1="";
			String insqls2="";
			java.sql.Date frmdate=ClsCommon.changeStringtoSqlDate(fromDate);

			java.sql.Date todate=ClsCommon.changeStringtoSqlDate(toDate);

			if(!(hidbrand.equalsIgnoreCase("0") || hidbrand.equalsIgnoreCase("") || hidbrand.equalsIgnoreCase("undefined"))){
				sql7=" and bd.doc_no in ("+hidbrand+")";
			}

			if(!(hidtype.equalsIgnoreCase("0") || hidtype.equalsIgnoreCase("") || hidtype.equalsIgnoreCase("undefined"))){
				sql8=" and pt.doc_no in ("+hidtype+")";
			}

			if(!(hidcat.equalsIgnoreCase("0") || hidcat.equalsIgnoreCase("") || hidcat.equalsIgnoreCase("undefined"))){
				sql9=" and cat.doc_no in ("+hidcat+")";
			}
			if(!(hidsubcat.equalsIgnoreCase("0") || hidsubcat.equalsIgnoreCase("") || hidsubcat.equalsIgnoreCase("undefined"))){
				sql10=" and sc.doc_no in ("+hidsubcat+")";
			}

			if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
				sql11=" and m.doc_no in ("+hidproduct+")";
			}
			 if(!(branchid.equalsIgnoreCase("0") || branchid.equalsIgnoreCase("") || branchid.equalsIgnoreCase("undefined")|| branchid.equalsIgnoreCase("a"))){
		 sql12="and stks.brhid="+branchid+"  ";
				
				insqls2="and pin.brhid="+branchid+"  ";
				
				insqls1= " and brhid="+branchid+" ";
				
				
			} 
			if(!(hidept.equalsIgnoreCase("0") || hidept.equalsIgnoreCase("") || hidept.equalsIgnoreCase("undefined"))){
				sql13=" and dep.doc_no in ("+hidept+")";
			}
			sqlfinal=sql1+sql2+sql3+sql4+sql5+sql6+sql7+sql8+sql9+sql10+sql11+sql12+sql13;
			sqljoin =  "left join my_ptype pt on(m.typeid=pt.doc_no) "
					+ "left join my_brand bd on(m.brandid=bd.doc_no) "
					+ "left join my_dept dep on(dep.doc_no=m.deptid) "
					+ "left join my_catm cat on(m.catid=cat.doc_no)"
					+ "left join my_scatm sc on(m.scatid=sc.doc_no)";

/*			sqljoin = "left join my_main m on(b.psrno=m.psrno) "
					+ "left join my_prodsuit s on(m.doc_no=s.psrno) "
					+ "left join my_vehsuitmaster vs on(vs.doc_no=s.vehsuitid) "
					+ "left join my_ptype pt on(m.typeid=pt.doc_no) "
					+ "left join my_brand bd on(m.brandid=bd.doc_no) "
					+ "left join my_dept dep on(dep.doc_no=m.deptid) "
					+ "left join my_catm cat on(m.catid=cat.doc_no)"
					+ "left join my_scatm sc on(m.scatid=sc.doc_no)";
*/
			/*					sql="select b.pno,b.pname,b.psrno,b.specid,coalesce(if(d.opnqty<0,0,d.opnqty),0) as opnqty,coalesce(if(b.qty<0,0,b.qty),0) as inqty,coalesce(if(e.isqty<0,0,e.isqty),0) as isqty, "
							+ "coalesce(if(b.bqty<0,0,b.bqty),0) as balqty,b.date,(b.bqty*b.unit_price) as stv,((b.bqty*b.unit_price)/b.bqty) as cpu from ( "
							+ "(select part_no pno,productname  pname,a.psrno,a.specid,qty,sum(qty) as bqty,a.date,unit_price from ( "
							+ "select stockid stkid,p.psrno,specno specid,op_qty qty,p.date,unit_price from my_prddin p "
							+ "union all "
							+ "select stockid stkid,p.psrno,p.specid,(qty*-1+rsv_qty*-1+del_qty*-1) qty,p.date,0 unit_price from my_prddout p) as a"
							+ " left join my_main m on(a.psrno=m.psrno) where cast(a.date as date)>='"+frmdate+"' and "
							+ "cast(a.date as date)<='"+todate+"' group by a.psrno order by a.date) as b "
							+ "left join (select c.psrno,qty,sum(qty) as opnqty,c.date from "
							+ "(select stockid stkid,p.psrno,specno specid,op_qty qty,p.date from my_prddin p "
							+ "union all "
							+ "select stockid stkid,p.psrno,p.specid,(qty*-1+rsv_qty*-1+del_qty*-1) qty,p.date from my_prddout p) as c"
							+ "  where cast(c.date as date)<'"+frmdate+"' "
							+ "group by c.psrno order by c.date) as d "
							+ "on (b.psrno=d.psrno) "
							+ "left join ( select p.psrno,p.specid,sum(p.qty+p.rsv_qty+p.del_qty) isqty  from my_prddout p "
							+ "where cast(p.date as date)>='"+frmdate+"' and "
							+ "cast(date as date)<='"+todate+"' group by p.psrno) as e on(e.psrno=b.psrno)) "+sqljoin+" where 1=1 "+sqlfinal+" group by b.psrno";
			 */
		/*//krish	sql="select b.pno,b.pname,b.psrno,b.specid,coalesce(if(d.opnqty<0,0,d.opnqty),0) as opnqty, "
					+ "coalesce(if(d.opnqty<0,0,d.opnqty),0)*b.unit_price as opnval, "
					+ "coalesce(if(b.iqty<0,0,b.iqty),0) as inqty, "
					+ "coalesce(if(b.iqty<0,0,b.iqty),0)*b.unit_price as inval, "
					+ "coalesce(if(e.isqty<0,0,e.isqty),0) as isqty, "
					+ "coalesce(if(e.isqty<0,0,e.isqty),0) *b.unit_price as isval, "
					+ "coalesce(if(b.bqty<0,0,b.bqty),0) as balqty,b.date,(b.bqty*b.unit_price) as stv, "
					+ "((b.bqty*b.unit_price)/b.bqty) as cpu from ( "
					+ "(select part_no pno,productname  pname,a.psrno,a.specid,sum(qty) as qty,sum(qty) as bqty,a.date,unit_price,sum(iqty) iqty from "
					+ "( select stockid stkid,p.psrno,specno specid,op_qty qty,p.date,unit_price,op_qty as iqty from my_prddin p "
					+ "union all "
					+ "select stockid stkid,p.psrno,p.specid,(qty*-1+rsv_qty*-1+del_qty*-1) qty,p.date,0 unit_price,0 as iqty from my_prddout p) as a "
					+ "left join my_main m on(a.psrno=m.psrno) where cast(a.date as date)>='"+frmdate+"' and cast(a.date as date)<='"+todate+"' "
					+ "group by a.psrno order by a.date) as b "
					+ "left join (select c.psrno,qty,sum(qty) as opnqty,c.date from "
					+ "(select stockid stkid,p.psrno,specno specid,op_qty qty,p.date from my_prddin p "
					+ "union all select stockid stkid,p.psrno,p.specid,(qty*-1+rsv_qty*-1+del_qty*-1) qty,p.date from my_prddout p) as c "
					+ "where cast(c.date as date)<'"+frmdate+"' group by c.psrno order by c.date) as d on (b.psrno=d.psrno) "
					+ "left join ( select p.psrno,p.specid,sum(p.qty+p.rsv_qty+p.del_qty) isqty  from my_prddout p "
					+ "where cast(p.date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' group by p.psrno) as e on(e.psrno=b.psrno)) "+sqljoin+" where 1=1 "+sqlfinal+" group by b.psrno";

*/
/*			sql="select m.part_no pno,m.productname  pname,stks.* from (  "
					+ "select  pin.brhid,pin.psrno,date,coalesce(ops.opqty,0) opnqty,coalesce(ops.cost_price,0) opnval "
					+ ",stk.stkqty inqty ,stk.stcost_price inval ,stk.issueqty isqty,stk.isscost isval,stk.stkqty-stk.issueqty balqty, "
					+ "stk.stcost_price-stk.isscost stv,pin.cost_price  cpu1 ,((stk.stcost_price-stk.isscost)/(stk.stkqty-stk.issueqty)) cpu from my_prddin pin  left join "
					+ " (select sum(op.opqty) opqty,sum(op.cost_price)  cost_price,op.Stockid,op.prdid from( "
					+ "select date,(op_qty)-(out_qty+rsv_qty+del_qty) opqty ,((op_qty)-(out_qty+rsv_qty+del_qty))*cost_price "
					 + "cost_price,Stockid,prdid from my_prddin where  cast(date as date)<'"+frmdate+"' "+insqls1+"  group by Stockid "
					+ " ) op group by op.prdid) ops on ops.prdid=pin.prdid left join (select sum(st.stkqty) stkqty,sum(st.stcost_price)  stcost_price,sum(st.issueqty) issueqty, "
					 + " sum(st.isscost) isscost , st.Stockid,st.prdid from(select date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
					 + " (out_qty+rsv_qty+del_qty) issueqty,(out_qty+rsv_qty+del_qty)*cost_price isscost, Stockid,prdid from my_prddin where "
					+ "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  group by Stockid "
					+ "  ) st group by st.prdid) stk on stk.prdid=pin.prdid where cast(pin.date as date)>='"+frmdate+"' "
					 + "  and cast(pin.date as date)<='"+todate+"' "+insqls2+"  group by pin.psrno) stks "
                   + "	left  join my_main m on(stks.psrno=m.psrno) "+sqljoin+"  where 1=1  "+sqlfinal+" " ;*/

/*			
			sql="select m.part_no 'PRODUCT CODE',m.productname  DESCRIPTION, opnqty 'OPENING QUANTITY',opnval 'OPENING VALUE', "
					+ " inqty 'IN  QUANTITY',inval 'IN VALUE',isqty 'ISSUED  QUANTITY', isval 'ISSUED  VALUE',balqty 'BALANCE  QUANTITY',stv  'BALANCE VALUE',"
					+ "  cpu 'COST PER UNIT' from (  "
					+ "select  pin.brhid,pin.psrno,date,coalesce(ops.opqty,0) opnqty,coalesce(ops.cost_price,0) opnval "
					+ ",stk.stkqty inqty ,stk.stcost_price inval ,stk.issueqty isqty,stk.isscost isval, "
					+ " (coalesce(stk.stkqty,0)-coalesce(stk.issueqty,0))+coalesce(ops.opqty,0) balqty , "
					+ "  (coalesce(stk.stcost_price,0)-coalesce(stk.isscost,0))+coalesce(ops.cost_price,0) stv,pin.cost_price  cpu1 , "
					+ " (((coalesce(stk.stcost_price,0)-coalesce(stk.isscost,0))+coalesce(ops.cost_price,0))/((coalesce(stk.stkqty,0)-coalesce(stk.issueqty,0))+coalesce(ops.opqty,0))) cpu  "
					+ "  from my_prddin pin  left join "
					+ " (select sum(op.opqty) opqty,sum(op.cost_price)  cost_price,op.Stockid,op.prdid from( "
					+ "select date,(op_qty)-(out_qty+rsv_qty+del_qty) opqty ,((op_qty)-(out_qty+rsv_qty+del_qty))*cost_price "
					 + "cost_price,Stockid,prdid from my_prddin where  cast(date as date)<'"+frmdate+"' "+insqls1+"  group by Stockid "
					+ " ) op group by op.prdid) ops on ops.prdid=pin.prdid left join (select sum(st.stkqty) stkqty,sum(st.stcost_price)  stcost_price,sum(st.issueqty) issueqty, "
					 + " sum(st.isscost) isscost , st.Stockid,st.prdid from(select date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
					 + " (out_qty+rsv_qty+del_qty) issueqty,(out_qty+rsv_qty+del_qty)*cost_price isscost, Stockid,prdid from my_prddin where "
					+ "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  group by Stockid "
					+ "  ) st group by st.prdid) stk on stk.prdid=pin.prdid where  1=1  "+insqls2+"  group by pin.psrno) stks "
                   + "	left  join my_main m on(stks.psrno=m.psrno) "+sqljoin+"  where 1=1 and (opnqty!=0 or opnval!=0 or inqty!=0 or inval!=0 or isqty!=0 or isval!=0 or balqty!=0 or stv!=0)   "+sqlfinal+" " ;
			
			*/
			sql="select m.part_no 'PRODUCT CODE',m.productname  DESCRIPTION, opnqty 'OPENING QUANTITY',opnval 'OPENING VALUE', "
					+ " inqty 'IN  QUANTITY',inval 'IN VALUE',isqty 'ISSUED  QUANTITY', isval 'ISSUED  VALUE',balqty 'BALANCE  QUANTITY',stv  'BALANCE VALUE',"
					+ "  cpu 'COST PER UNIT' from (  "
					+ "select  pin.brhid,pin.psrno,date,coalesce(ops.opqty,0) opnqty,coalesce(ops.cost_price,0) opnval "
					+ ",stk.stkqty inqty ,stk.stcost_price inval ,iss.issueqty isqty,iss.isscost isval, "
					+ " (coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0) balqty , "
					+ "  (coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0) stv,pin.cost_price  cpu1 , "
					+ " (((coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0))/"
					+ " ((coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0))) cpu  "
					+ "  from my_prddin pin  left join "
					+ " (select sum(op.opqty) opqty,sum(op.cost_price)  cost_price,op.Stockid,op.prdid from( "
					+ "select p.date,(p.op_qty)-(coalesce(a.outqty,0)) opqty ,((op_qty)-(coalesce(a.outqty,0)))*p.cost_price "
					 + " cost_price,p.Stockid,p.prdid from my_prddin  p	left join (select sum(qty) outqty,stockid from my_prddout where"
					 + "    cast(date as date)<'"+frmdate+"' "+insqls1+" group by stockid) a on a.stockid=p.stockid  "
					 + " where  cast(date as date)<'"+frmdate+"' "+insqls1+"  group by p.Stockid "
					+ " ) op group by op.prdid) ops on ops.prdid=pin.prdid left join (select sum(st.stkqty) stkqty,sum(st.stcost_price)  stcost_price,"
				  +" st.Stockid,st.prdid from(select date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
					 + "   Stockid,prdid from my_prddin where "
					+ "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  group by Stockid "
					+ "  ) st group by st.prdid) stk on stk.prdid=pin.prdid"
					+ " left join (select sum(coalesce(a.outqty,0)) issueqty,sum(coalesce(outcost,0)) isscost,prdid from   (select a.outqty ,a.outqty*p.cost_price outcost, a.prdid from "
					+ "	(select sum(qty+del_qty) outqty,stockid,prdid from my_prddout where "
					+ "	cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"   group by stockid) a "
					+ "		left join my_prddin p on a.stockid=p.stockid )  a where 1=1 group by a.prdid ) iss on iss.prdid=pin.prdid "
					+ "  where  1=1  "+insqls2+"  group by pin.psrno) stks "
                   + "	left  join my_main m on(stks.psrno=m.psrno) "+sqljoin+"  where 1=1 and"
                   		+ "  (opnqty!=0 or opnval!=0 or inqty!=0 or inval!=0 or isqty!=0 or isval!=0 or balqty!=0 or stv!=0)  "+sqlfinal+" " ;
			
			

			// System.out.println("==sql==========="+sql);

			ResultSet resultSet = stmt.executeQuery(sql);


			RESULTDATA=ClsCommon.convertToEXCEL(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}


	public JSONArray stockLedgerDetail(HttpSession session,String hidbrand,String fromDate,String toDate,String hidtype,String hidcat,
			String hidsubcat,String hidproduct,String branchid,String hidept,String load) throws SQLException {

//		System.out.println("load==============="+load);
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
			String sqljoin1 ="";
			String sqljoin2 ="";
			String wheresql="";

		 String insql="";
		 String outsql="";

			java.sql.Date frmdate=ClsCommon.changeStringtoSqlDate(fromDate);

			java.sql.Date todate=ClsCommon.changeStringtoSqlDate(toDate);

			if(!(hidbrand.equalsIgnoreCase("0") || hidbrand.equalsIgnoreCase("") || hidbrand.equalsIgnoreCase("undefined"))){
				wheresql=wheresql+" and bd.doc_no in ("+hidbrand+")";
			}

			if(!(hidtype.equalsIgnoreCase("0") || hidtype.equalsIgnoreCase("") || hidtype.equalsIgnoreCase("undefined"))){
				wheresql=wheresql+"  and pt.doc_no in ("+hidtype+")";
			}

			if(!(hidcat.equalsIgnoreCase("0") || hidcat.equalsIgnoreCase("") || hidcat.equalsIgnoreCase("undefined"))){
				wheresql=wheresql+"  and cat.doc_no in ("+hidcat+")";
			}
			if(!(hidsubcat.equalsIgnoreCase("0") || hidsubcat.equalsIgnoreCase("") || hidsubcat.equalsIgnoreCase("undefined"))){
				wheresql=wheresql+"  and sc.doc_no in ("+hidsubcat+")";
			}

			if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
				wheresql=wheresql+"  and m.doc_no in ("+hidproduct+")";
			}
			
			String opsql="";
		 if(!(branchid.equalsIgnoreCase("0") || branchid.equalsIgnoreCase("") || branchid.equals("undefined")|| branchid.equalsIgnoreCase("a"))){
				insql=" and pin.brhid in ("+branchid+")";
				outsql=" and pout.brhid in ("+branchid+")";
				opsql="and brhid in ("+branchid+")";
				
			} 
			if(!(hidept.equalsIgnoreCase("0") || hidept.equalsIgnoreCase("") || hidept.equalsIgnoreCase("undefined"))){
				wheresql=wheresql+"  and dep.doc_no in ("+hidept+")";
			}
			 
			 
/*
			sqljoin = "left join my_main m on(pin.psrno=m.psrno) "
					+ "left join my_ptype pt on(m.typeid=pt.doc_no) "
					+ "left join my_brand bd on(m.brandid=bd.doc_no) "
					+ "left join my_dept dep on(dep.doc_no=m.deptid) "
					+ "left join my_catm cat on(m.catid=cat.doc_no)"
					+ "left join my_scatm sc on(m.scatid=sc.doc_no)"
					+ "left join my_brch brc on(e.brhid=brc.doc_no) "
					+ "left join my_locm lm on(e.locid=lm.doc_no)";
			*/

			sqljoin = " left join my_main m on(pin.psrno=m.psrno) "
					+ " left join my_ptype pt on(m.typeid=pt.doc_no) "
					+ " left join my_brand bd on(m.brandid=bd.doc_no) "
					+ " left join my_dept dep on(dep.doc_no=m.deptid) "
					+ " left join my_catm cat on(m.catid=cat.doc_no)"
					+ " left join my_scatm sc on(m.scatid=sc.doc_no)" ;
				 
			
			

			sqljoin1 = " left join my_main m on(pout.psrno=m.psrno) "
					+ " left join my_ptype pt on(m.typeid=pt.doc_no) "
					+ " left join my_brand bd on(m.brandid=bd.doc_no) "
					+ " left join my_dept dep on(dep.doc_no=m.deptid) "
					+ " left join my_catm cat on(m.catid=cat.doc_no) "
					+ " left join my_scatm sc on(m.scatid=sc.doc_no) " ;
 
			
			sqljoin2 = " left join my_main m on(ops.prdid=m.psrno) "
					+ " left join my_ptype pt on(m.typeid=pt.doc_no) "
					+ " left join my_brand bd on(m.brandid=bd.doc_no) "
					+ " left join my_dept dep on(dep.doc_no=m.deptid) "
					+ " left join my_catm cat on(m.catid=cat.doc_no) "
					+ " left join my_scatm sc on(m.scatid=sc.doc_no) " ;
 
			


			/*sql="select e.psrno,stockid,part_no pno,productname pname,inqty,inval,DATE_FORMAT(e.date,'%m-%d-%Y') date,docno,trans_type,outqty isqty,outval isval,inqty-outqty as balqty,inval-outval as balval,trtype from "
					+ "(select opqty inqty,stockid,psrno,date,DOCNO,trans_type,0 as outqty,(opqty*unit_price) as inval,0 as outval,1 as trtype from "
					+ "(select sum(a.qty) opqty,a.stockid,a.psrno,a.date,'OPN' trans_type,0 as docno,a.unit_price from  "
					+ "(select op_qty qty,stockid,psrno,date,dtype,brhid,locid,unit_price from my_prddin p "
					+ "union all select (p.qty*-1+del_qty*-1) qty,stockid,psrno,date,dtype,brhid,locid,0 as unit_price from my_prddout p) as a "
					+ "where cast(a.date as date)<'"+frmdate+"'  group by psrno order by psrno) as b union all select inqty,stockid,psrno,date,DOCNO,trans_type,0 as outqty,(inqty*unit_price) as inval,0 as outval,1 as trtype "
					+ "from (SELECT sum(op_qty) inqty,p.stockid,p.psrno,p.date,(case when p.dtype='GRN' then mg.voc_no else (case when p.dtype='PIV' then sm.voc_no else (case when p.dtype='DLR' then dm.voc_no else "
					+ "(case when p.dtype='INR' then irm.voc_no else itm.voc_no end) end) end) end) as DOCNO, "
					+ "(p.dtype) as  trans_type,p.unit_price from my_prddin p left join my_grnd gn on(gn.psrno=p.psrno and gn.stockid=p.stockid) "
					+ "left join my_grnm mg on(mg.doc_no=gn.rdocno) left join my_srvd sd on(sd.psrno=p.psrno and sd.stockid=p.stockid) left join my_srvm sm on(sm.doc_no=sd.rdocno) left join my_delrd dd on (dd.psrno=p.psrno and dd.stockid=p.stockid) left join my_delrm dm on(dm.doc_no=dd.rdocno) "
					+ "left join my_inrd id on (id.psrno=p.psrno and id.stockid=p.stockid) left join my_invr irm  on(irm.doc_no=id.rdocno) left join my_invtranreceptd it on(it.psrno=p.psrno and it.stockid=p.stockid) left join my_invtranreceptm itm on(itm.doc_no=it.rdocno) "
					+ "where cast(p.date as date)<='"+todate+"' and cast(p.date as date)>='"+frmdate+"' group by p.dtype,p.psrno) as c union all select 0 as opnqty,stockid,psrno,date,DOCNO,trans_type,outqty,0 as inval,(outqty*unit_price) outval,2 as trtype from "
					+ "(select sum(p.qty+p.del_qty) outqty,p.stockid,p.psrno,p.date,(case when p.dtype='GRR' then mg.voc_no else (case when p.dtype='DEL' then dm.voc_no else (case when p.dtype='PIR' then sm.voc_no else (case when p.dtype='INV' then im.voc_no else itm.voc_no end) end) end) end) as DOCNO,"
					+ "(p.dtype) as  trans_type,intb.unit_price "
					+ "from my_prddout p left join my_prddin intb on(p.psrno=intb.psrno and p.stockid=intb.stockid) "
					+" left join my_grrd gr on(gr.psrno=p.psrno and gr.stockid=p.stockid) left join my_grrm mg on(mg.doc_no=gr.rdocno) left join my_deld dr on(dr.psrno=p.psrno and dr.stockid=p.stockid) left join my_delm dm on(dm.doc_no=dr.rdocno ) left join my_srrd sr on(sr.psrno=p.psrno and sr.stockid=p.stockid) "
					+ "left join my_srrm sm on(sm.doc_no=sr.rdocno ) left join my_invd ir on(ir.psrno=p.psrno and ir.stockid=p.stockid) left join my_invm im on(im.doc_no=ir.rdocno) left join my_invtranissued it on(it.psrno=p.psrno and it.stockid=p.stockid) left join my_invtranissuem itm on(itm.doc_no=it.rdocno) "
					+ "where cast(p.date as date)<='"+todate+"' and cast(p.date as date)>='"+frmdate+"' group by p.dtype,psrno)as d) as e  "+sqljoin+" where 1=1  "+sqlfinal+" order by e.psrno,trtype,cast(e.date as date)";*/
	//krish		
/*			sql="select e.psrno,stockid,part_no pno,productname pname,inqty,inval,DATE_FORMAT(e.date,'%d-%m-%Y') date,"
			  + "docno,trans_type,outqty isqty, outval isval,inqty-outqty as balqty,inval-outval as balval,trtype,ACNO,if(trans_type='ITR' or trans_type='ITI',concat(brc.branchname,' : ',lm.loc_name), h.description ) as desc1,e.brhid,e.locid,e.tr_no from "
			  + "(select opqty inqty,stockid,psrno,date,DOCNO,trans_type, "
			  + "0 as outqty,(opqty*unit_price) as inval,0 as outval,1 as trtype,ACNO,brhid,locid,tr_no from (select sum(a.qty) opqty,a.stockid,a.psrno,a.date, "
			  + "'OPN' trans_type,0 as docno,a.unit_price,0 as ACNO,brhid,locid,tr_no from "
			  + "(select op_qty qty,stockid,psrno,date,dtype,brhid,locid,unit_price,tr_no from my_prddin p union all "
			  + "select (p.qty*-1+del_qty*-1) qty,stockid,psrno,date,dtype,brhid,locid,0 as unit_price,tr_no from my_prddout p) as a "
			  + "where cast(a.date as date)<'"+frmdate+"'  group by psrno order by psrno) as b union all "
			  + "select inqty,stockid,psrno,date,DOCNO,trans_type,0 as outqty,(inqty*unit_price) as inval,0 as outval,1 as trtype,ACNO,brhid,locid,tr_no from (SELECT sum(op_qty) inqty,p.stockid,p.psrno,p.date, "
			  + "(case when p.dtype='GRN' then mg.voc_no else (case when p.dtype='PIV' then sm.voc_no else (case when p.dtype='DLR' then dm.voc_no else "
			  + "(case when p.dtype='INR' then irm.voc_no else itm.voc_no end) end) end) end) as DOCNO,(case when p.dtype='GRN' then mg.acno else(case when p.dtype='PIV' then sm.acno else "
			  + "(case when p.dtype='DLR' then dm.acno else (case when p.dtype='INR' then irm.acno else itm.acno end) end) end) end) as ACNO,(p.dtype) as  trans_type,p.unit_price,p.brhid,p.locid,p.tr_no from my_prddin p left join my_grnd gn "
			  + "on(gn.psrno=p.psrno and gn.stockid=p.stockid) left join my_grnm mg on(mg.doc_no=gn.rdocno) left join my_srvd sd on(sd.psrno=p.psrno and sd.stockid=p.stockid) left join my_srvm sm on(sm.doc_no=sd.rdocno) left join my_delrd dd on (dd.psrno=p.psrno and dd.stockid=p.stockid) "
			  + "left join my_delrm dm on(dm.doc_no=dd.rdocno) left join my_inrd id on (id.psrno=p.psrno and id.stockid=p.stockid) left join my_invr irm  on(irm.doc_no=id.rdocno) left join my_invtranreceptd it on(it.psrno=p.psrno and it.stockid=p.stockid) "
			  + "left join my_invtranreceptm itm on(itm.doc_no=it.rdocno) where cast(p.date as date)<='"+todate+"' and cast(p.date as date)>='"+frmdate+"' group by p.dtype,p.psrno) as c "
			  + "union all select 0 as opnqty,stockid,psrno,date,DOCNO,trans_type,outqty,0 as inval,(outqty*unit_price) outval,2 as trtype,ACNO,brhid,locid,tr_no from (select sum(p.qty+p.del_qty) outqty,p.stockid,p.psrno,p.date,(case when p.dtype='GRR' then mg.voc_no else(case when p.dtype='DEL' then dm.voc_no else "
			  + "(case when p.dtype='PIR' then sm.voc_no else (case when p.dtype='INV' then im.voc_no else itm.voc_no end) end) end) end) as DOCNO,(case when p.dtype='GRR' then mg.acno else(case when p.dtype='DEL' then dm.acno else (case when p.dtype='PIR' then sm.acno else(case when p.dtype='INV' then im.acno else itm.acno end) end) end) end) as ACNO, "
			  + "(p.dtype) as  trans_type,intb.unit_price,p.brhid,p.locid,p.tr_no from my_prddout p left join my_prddin intb on(p.psrno=intb.psrno and p.stockid=intb.stockid)  left join my_grrd gr "
			  + "on(gr.psrno=p.psrno and gr.stockid=p.stockid) left join my_grrm mg on(mg.doc_no=gr.rdocno) left join my_deld dr "
			  + "on(dr.psrno=p.psrno and dr.stockid=p.stockid) left join my_delm dm on(dm.doc_no=dr.rdocno ) left join my_srrd sr on(sr.psrno=p.psrno and sr.stockid=p.stockid) left join my_srrm sm on(sm.doc_no=sr.rdocno ) left join my_invd ir "
			  + "on(ir.psrno=p.psrno and ir.stockid=p.stockid) left join my_invm im on(im.doc_no=ir.rdocno) left join my_invtranissued it on(it.psrno=p.psrno and it.stockid=p.stockid) left join my_invtranissuem itm on(itm.doc_no=it.rdocno) where cast(p.date as date)<='"+todate+"' and cast(p.date as date)>='"+frmdate+"' group by p.dtype,psrno)as d) as e "
			  + "left join my_head h on(h.doc_no=e.acno) "+sqljoin+" where 1=1 and trans_type not in('SOR') "+sqlfinal+"  order by e.psrno,tr_no,cast(e.date as date)";
			
*/
			
			
			
			
/*			
		String	sql="   select * from (select 0 minus,'in' valtype, ins.tr_no, ins.psrno,ins.date,h.description, "
				+ "ins.stockid,ins.dtype,ins.docno,ins.acno,ins.inqty,ins.inval,ins.isqty, "
					 + "	ins.isval,ins.balqty,ins.balcost,ins.cpu from  "
					 + "(select pin.tr_no,pin.stockid, case when pin.dtype='GRN' then GRN.voc_no   when pin.dtype='PIV' then PIV.voc_no  "
					 + "when pin.dtype='DLR' then DLR.voc_no  when pin.dtype='INR' then INR.voc_no  "
					 + "when  pin.dtype='ITR' then ITR.voc_no   when  pin.dtype='GIR' then GIR.voc_no  else ''  end as DOCNO,  "
					 + "case when pin.dtype='GRN' then GRN.acno   when pin.dtype='PIV' then PIV.acno  "
					 + "when pin.dtype='DLR' then DLR.acno  when pin.dtype='INR' then INR.acno  "
					 + "when  pin.dtype='ITR' then ITR.acno   when  pin.dtype='GIR' then GIR.acno  else ''  end as acno,  "
					 + "pin.dtype, pin.brhid,pin.psrno,pin.date ,pin.op_qty inqty ,pin.op_qty*pin.cost_price inval ,  "
					 + " ' ' isqty, ' '  isval,  "
					 + " ' ' balqty, ' ' balcost,  "
					 + " cost_price cpu  from my_prddin pin  "
					  + "left join my_grnm GRN on GRN.tr_no=pin.tr_no and pin.dtype='GRN'  "
					  + "left join my_srvm piv on PIV.tr_no=pin.tr_no and pin.dtype='PIV'  "
					  + "left join my_delrm DLR on DLR.tr_no=pin.tr_no and pin.dtype='DLR'  "
					  + "left join   my_invr  INR on INR.tr_no=pin.tr_no and pin.dtype='INR'  "
					  + "left join   my_invtranreceptm  ITR on ITR.tr_no=pin.tr_no and pin.dtype='ITR'  "
					  + "left join   my_girm  GIR on GIR.tr_no=pin.tr_no and pin.dtype='GIR' "+sqljoin+" where 1=1  and "
					  + "  cast(pin.date as date)>='"+frmdate+"' and cast(pin.date as date)<='"+todate+"'  "+insql+" "+wheresql+"  "
					  + "group by pin.stockid order by pin.stockid) ins  "
					  + "left join my_head h on(h.doc_no=ins.acno)  "
					  + " union all  "
					 + " select outs.minus ,'out' valtype, outs.tr_no,outs.psrno, outs.date,ac.refname description,outs.Stockid,outs.dtype,outs.docno,  "
					 + " outs.acno,' ' inqty,' ' inval,outs.issqty isqty,outs.issqty*outs.issuecostprice isval ,  "
					  + "' 'balqty,' ' balcost, outs.issuecostprice cpu  "
					  + "from (select case when pout.dtype='INV' then if(pout.rsv_qty<0,pout.rsv_qty,pout.del_qty) else 0 end as minus,pout.tr_no,pout.psrno,pout.Stockid,pout.dtype,cast(pout.date as date) date,  "
					  + "case when pout.dtype='GRR' then GRR.voc_no   when pout.dtype='PIR' then PIR.voc_no  "
					  + "	when pout.dtype='SOR' then SOR.voc_no  when pout.dtype='JOR' then JOR.voc_no  "
					  + "	when  pout.dtype='DEL' then DEL.voc_no   when  pout.dtype='INV' then INV.voc_no  when  pout.dtype='ITI' then ITI.voc_no  "
					  + "	when  pout.dtype='GIS' then GIS.voc_no  "
					  + "	else ''  end as DOCNO,   case when pout.dtype='GRR' then GRR.cldocno   when pout.dtype='PIR' then PIR.cldocno    when pout.dtype='SOR'  "
					  + " then SOR.cldocno  when pout.dtype='JOR' then JOR.cldocno    when  pout.dtype='DEL'  then DEL.cldocno   when  pout.dtype='INV' then INV.cldocno  "
					  + " 	when  pout.dtype='GIS' then GIS.cldocno  	else ''  end as cldocno , "
					  + "	case when pout.dtype='GRR' then GRR.acno   when pout.dtype='PIR' then PIR.acno  "
					 + "    when pout.dtype='SOR' then SOR.acno  "
					 + "    when  pout.dtype='DEL' then DEL.acno   when  pout.dtype='INV' then INV.acno  when  pout.dtype='ITI' then ITI.acno  "
					 + "	when  pout.dtype='GIS' then GIS.acno  "
					 + "	else ''  end as acno, case when  pout.dtype='DEL' then  "
					 + "	de.del_qty  "
					 + "	when  pout.dtype='SOR' ||  pout.dtype='JOR' then  "
					 + "	 rs.rsv_qty  "
					 + "	else pout.qty end as issqty, p.cost_price issuecostprice  "
					 + "	from my_prddout pout left join  my_prddin p     on pout.stockid=p.stockid and (pout.dtype!='SOR'  or pout.dtype!='JOR')  "
					 + " left join (select rsv_qty,stockid,doc_no from my_prddout group by stockid,doc_no) rs on rs.Stockid=pout.stockid and rs.doc_no=pout.doc_no "
					 + " left join (select del_qty,stockid,doc_no from my_prddout group by stockid,doc_no) de on de.Stockid=pout.stockid and de.doc_no=pout.doc_no "
					 + "	left join my_grrm GRR on GRR.tr_no=pout.tr_no and pout.dtype='GRR'  "
					 + "	left join my_srrm PIR on PIR.tr_no=pout.tr_no and pout.dtype='PIR'  "
					 + "	left join my_sorderm SOR on SOR.tr_no=pout.tr_no and pout.dtype='SOR'  "
					 + "	left join   my_joborderm  JOR on JOR.tr_no=pout.tr_no and pout.dtype='JOR'  "
					 + "	left join   my_delm  DEL on DEL.tr_no=pout.tr_no and pout.dtype='DEL'  "
					 + "	left join   my_invm  INV on INV.tr_no=pout.tr_no and pout.dtype='INV'  "
					 + "	left join   my_invtranissuem ITI on ITI.tr_no=pout.tr_no and pout.dtype='ITI'  "
					 + "    left join   my_gism  GIS on GIS.tr_no=pout.tr_no and GIS.dtype='GIS'  "+sqljoin1+" "
					 + "	where 1=1  and (pout.dtype!='SOR' or pout.dtype!='JOR') and cast(pout.date as date)>='"+frmdate+"' and cast(pout.date as date)<='"+todate+"'   "+outsql+"  "+wheresql+"   order by stockid,pout.doc_no) outs  "
					 + "    left join my_head h on(h.doc_no=outs.acno)     left join my_acbook ac on(ac.doc_no=outs.cldocno and ac.dtype='CRM') ) res order by res.date  ";

					  ;*/
			
/*			
			obj.put("date",stldarray[0]);
			obj.put("docno",stldarray[1]);
			obj.put("trans_type",stldarray[2]);
			obj.put("inqty",stldarray[3]);
			obj.put("inval",stldarray[4]);
			obj.put("isqty",stldarray[5]);
			obj.put("isval",stldarray[6]);
			obj.put("balqty",stldarray[7]);
			obj.put("balval",stldarray[8]);
			obj.put("trtype",stldarray[9]);
			obj.put("cpu", stldarray[10]);
			obj.put("desc1",stldarray[11]);
			obj.put("sl",stldarray[12]);//DATE_ADD('"+frmdate+"', INTERVAL -1 DAY) date
			obj.put("psrno",stldarray[13]);
			*/
			
/*			String	sql="   select ord,valtype trtype,DATE_FORMAT(date,'%d-%m-%Y') date,convert(docno,char(100)) docno,convert(dtype,char(100)) trans_type,"
					+ " convert(inqty,char(100)) inqty,convert(inval,char(100)) inval ,convert(isqty,char(20)) isqty,convert(isval,char(100)) isval,"
					+ " convert(if(valtype!='out',cpu,''),char(100)) cpu,convert(description,char(100))  desc1,coalesce(round(@i:=@i+(inqty-isqty),2),0) balqty ,coalesce(round(@j:=@j+(inval-isval),2),0)  balval"
					+ "  from ("
				 	+ " select 0 ord, 0 minus,'OP' valtype, 0  tr_no,ops.prdid psrno,cast(DATE_ADD('"+frmdate+"', INTERVAL -1 DAY) as date) date, "
					+ " 'OPENING' description,0 stockid,'OPN' dtype, '' docno, '' acno,ops.inqty, ops.inval,'' isqty, '' isval, '' balqty, '' balcost, "
					+ " ops.inval/ops.inqty cpu from (select sum(op.opqty) inqty,sum(op.cost_price)  inval,op.prdid from "
					+ "  (select (p.op_qty)-(coalesce(a.outqty,0)) opqty ,((op_qty)-(coalesce(a.outqty,0)))*p.cost_price  "
					+ " cost_price,p.Stockid,p.prdid,p.brhid from my_prddin  p	left join (select sum(qty) outqty,stockid from my_prddout where "
					+ "     cast(date as date)<'"+frmdate+"' "+opsql+"   group by stockid) a      on a.stockid=p.stockid "
							+ " where  cast(p.date as date)<'"+frmdate+"'  "+opsql+"  group by p.Stockid)  op group by op.prdid ) ops  "+sqljoin2+" where 1=1 "+wheresql+""
									+ " union all  "
					+ "select 1 ord,0 minus,'in' valtype, ins.tr_no, ins.psrno,ins.date,h.description, "
					+ "ins.stockid,ins.dtype,ins.docno,ins.acno,ins.inqty,ins.inval,ins.isqty, "
						 + "	ins.isval,ins.balqty,ins.balcost,ins.cpu from  "
						 + "(select pin.tr_no,pin.stockid, case when pin.dtype='GRN' then GRN.voc_no   when pin.dtype='PIV' then PIV.voc_no  "
						 + "when pin.dtype='DLR' then DLR.voc_no  when pin.dtype='INR' then INR.voc_no  "
						 + "when  pin.dtype='ITR' then ITR.voc_no   when  pin.dtype='GIR' then GIR.voc_no  else ''  end as DOCNO,  "
						 + "case when pin.dtype='GRN' then GRN.acno   when pin.dtype='PIV' then PIV.acno  "
						 + "when pin.dtype='DLR' then DLR.acno  when pin.dtype='INR' then INR.acno  "
						 + "when  pin.dtype='ITR' then ITR.acno   when  pin.dtype='GIR' then GIR.acno  else ''  end as acno,  "
						 + "pin.dtype, pin.brhid,pin.psrno,pin.date ,pin.op_qty inqty ,pin.op_qty*pin.cost_price inval ,  "
						 + " ' ' isqty, ' '  isval,  "
						 + " ' ' balqty, ' ' balcost,  "
						 + " cost_price cpu  from my_prddin pin  "
						  + "left join my_grnm GRN on GRN.tr_no=pin.tr_no and pin.dtype='GRN'  "
						  + "left join my_srvm piv on PIV.tr_no=pin.tr_no and pin.dtype='PIV'  "
						  + "left join my_delrm DLR on DLR.tr_no=pin.tr_no and pin.dtype='DLR'  "
						  + "left join   my_invr  INR on INR.tr_no=pin.tr_no and pin.dtype='INR'  "
						  + "left join   my_invtranreceptm  ITR on ITR.tr_no=pin.tr_no and pin.dtype='ITR'  "
						  + "left join   my_girm  GIR on GIR.tr_no=pin.tr_no and pin.dtype='GIR' "+sqljoin+" where 1=1  and "
						  + "  cast(pin.date as date)>='"+frmdate+"' and cast(pin.date as date)<='"+todate+"'  "+insql+" "+wheresql+"  "
						  + "group by pin.stockid order by pin.stockid) ins  "
						  + "left join my_head h on(h.doc_no=ins.acno)  "
						  + " union all  "
						 + " select 2 ord,outs.minus ,'out' valtype, outs.tr_no,outs.psrno, outs.date,ac.refname description,outs.Stockid,outs.dtype,outs.docno,  "
						 + " outs.acno,' ' inqty,' ' inval,outs.issqty isqty,outs.issqty*outs.issuecostprice isval ,  "
						  + "' 'balqty,' ' balcost, outs.issuecostprice cpu  "
						  + "from (select case when pout.dtype='INV' then if(pout.rsv_qty<0,pout.rsv_qty,pout.del_qty) else 0 end as minus,pout.tr_no,pout.psrno,pout.Stockid,pout.dtype,cast(pout.date as date) date,  "
						  + "case when pout.dtype='GRR' then GRR.voc_no   when pout.dtype='PIR' then PIR.voc_no  "
						  + "	when pout.dtype='SOR' then SOR.voc_no  when pout.dtype='JOR' then JOR.voc_no  "
						  + "	when  pout.dtype='DEL' then DEL.voc_no   when  pout.dtype='INV' then INV.voc_no  when  pout.dtype='ITI' then ITI.voc_no  "
						  + "	when  pout.dtype='GIS' then GIS.voc_no  "
						  + "	else ''  end as DOCNO,   case when pout.dtype='GRR' then GRR.cldocno   when pout.dtype='PIR' then PIR.cldocno    when pout.dtype='SOR'  "
						  + " then SOR.cldocno  when pout.dtype='JOR' then JOR.cldocno    when  pout.dtype='DEL'  then DEL.cldocno   when  pout.dtype='INV' then INV.cldocno  "
						  + " 	when  pout.dtype='GIS' then GIS.cldocno  	else ''  end as cldocno , "
						  + "	case when pout.dtype='GRR' then GRR.acno   when pout.dtype='PIR' then PIR.acno  "
						 + "    when pout.dtype='SOR' then SOR.acno  "
						 + "    when  pout.dtype='DEL' then DEL.acno   when  pout.dtype='INV' then INV.acno  when  pout.dtype='ITI' then ITI.acno  "
						 + "	when  pout.dtype='GIS' then GIS.acno  "
						 + "	else ''  end as acno, case when  pout.dtype='DEL' then  "
						 + "	de.del_qty  "
						 + "	when  pout.dtype='SOR' ||  pout.dtype='JOR' then  "
						 + "	 rs.rsv_qty  "
						 + "	else pout.qty end as issqty, p.cost_price issuecostprice  "
						 + "	from my_prddout pout left join  my_prddin p     on pout.stockid=p.stockid and pout.dtype!='SOR'  and pout.dtype!='JOR'  "
						 + " left join (select rsv_qty,stockid,doc_no from my_prddout group by stockid,doc_no) rs on rs.Stockid=pout.stockid and rs.doc_no=pout.doc_no "
						 + " left join (select del_qty,stockid,doc_no from my_prddout group by stockid,doc_no) de on de.Stockid=pout.stockid and de.doc_no=pout.doc_no "
						 + "	left join my_grrm GRR on GRR.tr_no=pout.tr_no and pout.dtype='GRR'  "
						 + "	left join my_srrm PIR on PIR.tr_no=pout.tr_no and pout.dtype='PIR'  "
						 + "	left join my_sorderm SOR on SOR.tr_no=pout.tr_no and pout.dtype='SOR'  "
						 + "	left join   my_joborderm  JOR on JOR.tr_no=pout.tr_no and pout.dtype='JOR'  "
						 + "	left join   my_delm  DEL on DEL.tr_no=pout.tr_no and pout.dtype='DEL'  "
						 + "	left join   my_invm  INV on INV.tr_no=pout.tr_no and pout.dtype='INV'  "
						 + "	left join   my_invtranissuem ITI on ITI.tr_no=pout.tr_no and pout.dtype='ITI'  "
						 + "    left join   my_gism  GIS on GIS.tr_no=pout.tr_no and GIS.dtype='GIS'  "+sqljoin1+" "
						 + "	where 1=1  and  pout.dtype!='SOR' and pout.dtype!='JOR' and cast(pout.date as date)>='"+frmdate+"' and cast(pout.date as date)<='"+todate+"'   "+outsql+"  "+wheresql+"   order by stockid,pout.doc_no) outs  "
						 + "    left join my_head h on(h.doc_no=outs.acno)     left join my_acbook ac on(ac.doc_no=outs.cldocno and ac.dtype='CRM') ) "
						 + "  res,(select @i:=0) as i,(select @j:=0) as j order by res.psrno, res.date,res.tr_no ";
*/
			String	sql="   select ord,valtype trtype,DATE_FORMAT(date,'%d-%m-%Y') date,convert(docno,char(100)) docno,convert(dtype,char(100)) trans_type,"
					+ " convert(inqty,char(100)) inqty,convert(inval,char(100)) inval ,convert(isqty,char(20)) isqty,convert(isval,char(100)) isval,"
					+ " convert(if(valtype!='out',cpu,''),char(100)) cpu,convert(description,char(100))  desc1,coalesce(round(@i:=@i+(inqty-issqty1),2),0) balqty ,coalesce(round(@j:=@j+(inval-isval1),2),0)  balval"
					+ "  from ("
				 	+ " select 0 ord, 0 minus,'OP' valtype, 0  tr_no,ops.prdid psrno,cast(DATE_ADD('"+frmdate+"', INTERVAL -1 DAY) as date) date, "
					+ " 'OPENING' description,0 stockid,'OPN' dtype, '' docno, '' acno,ops.inqty, ops.inval,'' isqty,'' issqty1, '' isval, '' isval1, '' balqty, '' balcost, "
					+ " ops.inval/ops.inqty cpu from (select sum(op.opqty) inqty,sum(op.cost_price)  inval,op.prdid from "
					+ "  (select (p.op_qty)-(coalesce(a.outqty,0)) opqty ,((op_qty)-(coalesce(a.outqty,0)))*p.cost_price  "
					+ " cost_price,p.Stockid,p.prdid,p.brhid from my_prddin  p	left join (select sum(qty) outqty,stockid from my_prddout where "
					+ "     cast(date as date)<'"+frmdate+"' "+opsql+"   group by stockid) a      on a.stockid=p.stockid "
							+ " where  cast(p.date as date)<'"+frmdate+"'  "+opsql+"  group by p.Stockid)  op group by op.prdid ) ops  "+sqljoin2+" where 1=1 "+wheresql+""
									+ " union all  "
					+ "select 1 ord,0 minus,'in' valtype, ins.tr_no, ins.psrno,ins.date,h.description, "
					+ "ins.stockid,ins.dtype,ins.docno,ins.acno,ins.inqty,ins.inval,ins.isqty, ins.isqty issqty1, "
					+ "  ins.isval,ins.isval isval1,ins.balqty,ins.balcost,ins.cpu from  "
						 + "(select pin.tr_no,pin.stockid, case when pin.dtype='GRN' then GRN.voc_no   when pin.dtype='PIV' then PIV.voc_no  "
						 + "when pin.dtype='DLR' then DLR.voc_no  when pin.dtype='INR' then INR.voc_no  when pin.dtype='PHK' then PHK.voc_no  "
						 + "when  pin.dtype='ITR' then ITR.voc_no   when  pin.dtype='GIR' then GIR.voc_no  else ''  end as DOCNO,  "
						 + "case when pin.dtype='GRN' then GRN.acno   when pin.dtype='PIV' then PIV.acno  "
						 + "when pin.dtype='DLR' then DLR.acno  when pin.dtype='INR' then INR.acno  "
						 + "when  pin.dtype='ITR' then ITR.acno   when  pin.dtype='GIR' then GIR.acno  else ''  end as acno,  "
						 + "pin.dtype, pin.brhid,pin.psrno,pin.date ,pin.op_qty inqty ,pin.op_qty*pin.cost_price inval ,  "
						 + " ' ' isqty,' ' isqty1, ' '  isval, ' '  isval1,  "
						 + " ' ' balqty, ' ' balcost,  "
						 + " cost_price cpu  from my_prddin pin  "
						  + "left join my_grnm GRN on GRN.tr_no=pin.tr_no and pin.dtype='GRN'  "
						  + "left join my_srvm piv on PIV.tr_no=pin.tr_no and pin.dtype='PIV' left join my_phkm PHK on PHK.tr_no=pin.tr_no and pin.dtype='PHK'  "
						  + "left join my_delrm DLR on DLR.tr_no=pin.tr_no and pin.dtype='DLR'  "
						  + "left join   my_invr  INR on INR.tr_no=pin.tr_no and pin.dtype='INR'  "
						  + "left join   my_invtranreceptm  ITR on ITR.tr_no=pin.tr_no and pin.dtype='ITR'  "
						  + "left join   my_girm  GIR on GIR.tr_no=pin.tr_no and pin.dtype='GIR' "+sqljoin+" where 1=1  and "
						  + "  cast(pin.date as date)>='"+frmdate+"' and cast(pin.date as date)<='"+todate+"'  "+insql+" "+wheresql+"  "
						  + "group by pin.stockid order by pin.stockid) ins  "
						  + "left join my_head h on(h.doc_no=ins.acno)  "
						  + " union all  "
						 + " select 2 ord,outs.minus ,'out' valtype, outs.tr_no,outs.psrno, outs.date,ac.refname description,outs.Stockid,outs.dtype,outs.docno,  "
						 + " outs.acno,' ' inqty,' ' inval,outs.issqty isqty,outs.issqty1,outs.issqty*outs.issuecostprice isval , "
						 + " outs.issqty1*outs.issuecostprice isval1,  "
						  + "' 'balqty,' ' balcost, outs.issuecostprice cpu  "
						  + "from (select case when pout.dtype='INV' then if(pout.rsv_qty<0,pout.rsv_qty,pout.del_qty) else 0 end as minus,pout.tr_no,pout.psrno,pout.Stockid,pout.dtype,cast(pout.date as date) date,  "
						  + "case when pout.dtype='GRR' then GRR.voc_no   when pout.dtype='PIR' then PIR.voc_no  "
						  + "	when pout.dtype='SOR' then SOR.voc_no  when pout.dtype='JOR' then JOR.voc_no  when pout.dtype='PHK' then PHK.voc_no  "
						  + "	when  pout.dtype='DEL' then DEL.voc_no   when  pout.dtype='INC' then INV.voc_no  when  pout.dtype='INV' then INV.voc_no  when  pout.dtype='ITI' then ITI.voc_no  "
						  + "	when  pout.dtype='GIS' then GIS.voc_no  "
						  + "	else ''  end as DOCNO,   case when pout.dtype='GRR' then GRR.cldocno   when pout.dtype='PIR' then PIR.cldocno    when pout.dtype='SOR'  "
						  + " then SOR.cldocno  when pout.dtype='JOR' then JOR.cldocno    when  pout.dtype='DEL'  then DEL.cldocno  when  pout.dtype='INC' then INV.cldocno   when  pout.dtype='INV' then INV.cldocno  "
						  + " 	when  pout.dtype='GIS' then GIS.cldocno  	else ''  end as cldocno , "
						  + "	case when pout.dtype='GRR' then GRR.acno   when pout.dtype='PIR' then PIR.acno  "
						 + "    when pout.dtype='SOR' then SOR.acno  "
						 + "    when  pout.dtype='DEL' then DEL.acno when  pout.dtype='INC' then INV.acno   when  pout.dtype='INV' then INV.acno  when  pout.dtype='ITI' then ITI.acno  "
						 + "	when  pout.dtype='GIS' then GIS.acno  "
						 + "	else ''  end as acno, case when  pout.dtype='DEL' then  "
						 + "	de.del_qty  "
						 + "	when  pout.dtype='SOR' ||  pout.dtype='JOR' then  "
						 + "	 rs.rsv_qty  "
						 + "	else pout.qty end as issqty, case when  pout.dtype='DEL' then  "
						 + "	de.del_qty  "
						 + "	when  pout.dtype='SOR' ||  pout.dtype='JOR' then  "
						 + "	 rs.rsv_qty  "
						 + "	else pout.qty+pout.del_qty end as issqty1, p.cost_price issuecostprice "
						 + "	from my_prddout pout left join  my_prddin p     on pout.stockid=p.stockid and pout.dtype!='SOR'  and pout.dtype!='JOR'  "
						 + " left join (select rsv_qty,stockid,doc_no from my_prddout group by stockid,doc_no) rs on rs.Stockid=pout.stockid and rs.doc_no=pout.doc_no "
						 + " left join (select del_qty,stockid,doc_no from my_prddout group by stockid,doc_no) de on de.Stockid=pout.stockid and de.doc_no=pout.doc_no "
						 + "	left join my_grrm GRR on GRR.tr_no=pout.tr_no and pout.dtype='GRR'  "
						 + "	left join my_srrm PIR on PIR.tr_no=pout.tr_no and pout.dtype='PIR'  "
						 + "	left join my_sorderm SOR on SOR.tr_no=pout.tr_no and pout.dtype='SOR'  "
						 + "	left join   my_joborderm  JOR on JOR.tr_no=pout.tr_no and pout.dtype='JOR'  "
						 + "	left join   my_delm  DEL on DEL.tr_no=pout.tr_no and pout.dtype='DEL'  "
						 + "	left join   my_invm  INV on INV.tr_no=pout.tr_no and pout.dtype in ('INV','INC')  left join my_phkm PHK on PHK.tr_no=pout.tr_no and pout.dtype='PHK'  "
						 + "	left join   my_invtranissuem ITI on ITI.tr_no=pout.tr_no and pout.dtype='ITI'  "
						 + "    left join   my_gism  GIS on GIS.tr_no=pout.tr_no and GIS.dtype='GIS'  "+sqljoin1+" "
						 + "	where 1=1  and  pout.dtype!='SOR' and pout.dtype!='JOR' and cast(pout.date as date)>='"+frmdate+"' and cast(pout.date as date)<='"+todate+"'   "+outsql+"  "+wheresql+"   order by stockid,pout.doc_no) outs  "
						 + "    left join my_head h on(h.doc_no=outs.acno)     left join my_acbook ac on ((ac.doc_no=outs.cldocno and ac.dtype='CRM' and outs.dtype!='PIR') or ((ac.doc_no=outs.cldocno and ac.dtype='VND' and outs.dtype='PIR')) ) ) "
						 + "  res,(select @i:=0) as i,(select @j:=0) as j order by res.psrno, res.date,res.tr_no "; 
//		 	System.out.println("==stockLedgerDetail=111=="+sql);
			
			
	/*		 left join (select sum(del_qty) del_qty,stockid,doc_no from my_prddout group by stockid) de
			   on de.Stockid=pout.stockid*/

		//	ArrayList<String> stldarray= new ArrayList<String>();
			ResultSet rs = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(rs);
			
			
			
		/*	
			String valtype="";
			
			String	psrno="";
			String	trtype="";
			String	docno="";
			String	date="";
			String	trans_type="";
			String	desc1="";
			
			String totalqty1="",issueqty1="",balqty1="",remqty1 ="";
			
			String  cpu1="",inval1="",isval1="",totbalval1="";
			
			
			double totalqty=0,issueqty=0,balqty=0,remqty = 0;
			
			double cpu=0,inval=0,isval=0,totbalval=0;
			int i=0;
			int j=0;
			int k=0;

			int minus=0;
			while(rs.next()){
				
				valtype=rs.getString("valtype");
				if(valtype.equalsIgnoreCase("in"))
				{
					totalqty=rs.getDouble("inqty");
					remqty=totalqty;
					issueqty=0;
					i=i+1;
					j=0;
				}
				else if(valtype.equalsIgnoreCase("out"))
				{
					totalqty=0;
					issueqty=rs.getDouble("isqty");
					
					minus=rs.getInt("minus");
		//			System.out.println("======minus======"+minus);
					
					if(minus>=0)
					{
					remqty=remqty-issueqty;
					}
					j=j+1;
				}
				
				balqty=remqty;
			
			
			
		 	psrno=rs.getString("psrno");
		 	trtype=valtype;
		 	docno=rs.getString("docno");
		 	date=rs.getString("date");
		 	trans_type=rs.getString("dtype");
		 	desc1=rs.getString("description");
		 	
	
		 	cpu=rs.getDouble("cpu");
		 	
		 	if(totalqty>0)
		 	{
		 		inval=totalqty*cpu;
		 		totalqty1=totalqty+"";
		 		inval1=inval+"";
		 		cpu1=cpu+"";
		 	}
		 	else
		 	{
		 		cpu1="";
		 		totalqty1="";
		 		inval1="";
		 	}
		 	if(issueqty>0)
		 	{
		 	isval=issueqty*cpu;
		 	issueqty1=issueqty+"";
		 	isval1=isval+"";
		 	}
		 	else
		 	{
		 		
		 	 	 if(valtype.equalsIgnoreCase("out"))
					{
			 		 
		 	 		issueqty1="0";
				 	isval1="0";
					}
		 	 	 else
		 	 	 {
		 		issueqty1="";
			 	isval1="";
		 	 	 }
		 		
		 	}
		 	if(balqty>=0 && minus>=0)
		 	{
		 	totbalval=balqty*cpu;
		 	balqty1=balqty+"";
		 	totbalval1=totbalval+"";
		 	}
		 	else
		 	{
		 		
		 	 	balqty1="";
			 	totbalval1="";	
		 	}
		 	
		 	
		 	if(valtype.equalsIgnoreCase("in"))
			{
		 	  k=i;
			}
		 	else if(valtype.equalsIgnoreCase("out"))
			{
		 		  k=j;
			}
		 
			stldarray.add(date+"::"+docno+"::"+trans_type+"::"+totalqty1+"::"+inval1+"::"+issueqty1+"::"+isval1+"::"+balqty1+"::"+totbalval1+"::"+trtype+"::"+cpu1+"::"+desc1+"::"+k+"::"+psrno);
			
			}
		 	
		//	System.out.println("==============="+stldarray);


			String psrno="0",prvpsrno="0",pno="",pname="",docno="",trans_type="",trtype="",date="",desc1="";
			double inqty=0.00,inval=0.00,isqty=0.00,isval=0.00,balqty=0.00,balval=0.00,totinqty=0.0,totinval=0.0,totisqty=0.0,totisval=0.0,totbalqty=0.0,totbalval=0.0,cpu=0.0;
			int i=0;
			int k=1;
			while(rs.next()){
				psrno=rs.getString("psrno");
				trtype=rs.getString("trtype");
				docno=rs.getString("docno");
				date=rs.getString("date");
				trans_type=rs.getString("trans_type");
				desc1=rs.getString("desc1");
				if(!(prvpsrno.equalsIgnoreCase(psrno))){
					k=1;
					if(i!=0){
						cpu=totbalval/totbalqty;
					stldarray.add(""+"::"+pno+"::"+""+"::"+totinqty+"::"+totinval+"::"+totisqty+"::"+totisval+"::"+totbalqty+"::"+totbalval+"::0"+"::"+cpu+"::"+pname+"::"+""+"::"+psrno);
					}
					inqty=0.00;inval=0.00;isqty=0.00;isval=0.00;balqty=0.00;balval=0.00;totinqty=0.0;totinval=0.0;totisqty=0.0;totisval=0.0;totbalqty=0.0;totbalval=0.0;
					pno=rs.getString("pno");
					pname=rs.getString("pname");
					psrno=rs.getString("psrno");
					trtype=rs.getString("trtype");
					docno=rs.getString("docno");
					date=rs.getString("date");
					trans_type=rs.getString("trans_type");
					desc1=rs.getString("desc1");
				}
				
				inqty=Double.parseDouble(rs.getString("inqty"));inval=Double.parseDouble(rs.getString("inval"));
				isqty=Double.parseDouble(rs.getString("isqty"));isval=Double.parseDouble(rs.getString("isval"));
				balqty=Double.parseDouble(rs.getString("balqty"));balval=Double.parseDouble(rs.getString("balval"));
				totinqty=totinqty+inqty;
				totisqty=totisqty+isqty;
				totinval=totinval+inval;
				totisval=totisval+isval;
				totbalqty=totbalqty+balqty;
				totbalval=totbalval+balval;
				if(trtype.equalsIgnoreCase("2")){
					balqty=totinqty-totisqty;
					balval=totinval-totisval;
							
				}
				
				prvpsrno=psrno;
				
				stldarray.add(date+"::"+docno+"::"+trans_type+"::"+inqty+"::"+inval+"::"+isqty+"::"+isval+"::"+totbalqty+"::"+totbalval+"::"+trtype+"::"+" "+"::"+desc1+"::"+k+"::"+psrno);
				
				i++;
				k++;
	
			}
			cpu=totbalval/totbalqty;
			stldarray.add(""+"::"+pno+"::"+""+"::"+totinqty+"::"+totinval+"::"+totisqty+"::"+totisval+"::"+totbalqty+"::"+totbalval+"::0"+"::"+cpu+"::"+pname+"::"+""+"::"+psrno);
			//stldarray.add(""+"::"+pno+"::"+""+"::"+totinqty+"::"+totinval+"::"+totisqty+"::"+totisval+"::"+totbalqty+"::"+totbalval+"::0"+"::"+pname+"::"+"");
			*/
		//	RESULTDATA=convertArrayToJSON(stldarray);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}


	public JSONArray stockLedgerDetail2(HttpSession session,String hidbrand,String fromDate,String toDate,String hidtype,String hidcat,
			String hidsubcat,String hidproduct,String branchid,String hidept,String load) throws SQLException {

//		System.out.println("load==============="+load);
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
			String sqljoin1 ="";
			String sqljoin2 ="";
			String wheresql="";

		 String insql="";
		 String outsql="";

			java.sql.Date frmdate=ClsCommon.changeStringtoSqlDate(fromDate);

			java.sql.Date todate=ClsCommon.changeStringtoSqlDate(toDate);

			if(!(hidbrand.equalsIgnoreCase("0") || hidbrand.equalsIgnoreCase("") || hidbrand.equalsIgnoreCase("undefined"))){
				wheresql=wheresql+" and bd.doc_no in ("+hidbrand+")";
			}

			if(!(hidtype.equalsIgnoreCase("0") || hidtype.equalsIgnoreCase("") || hidtype.equalsIgnoreCase("undefined"))){
				wheresql=wheresql+"  and pt.doc_no in ("+hidtype+")";
			}

			if(!(hidcat.equalsIgnoreCase("0") || hidcat.equalsIgnoreCase("") || hidcat.equalsIgnoreCase("undefined"))){
				wheresql=wheresql+"  and cat.doc_no in ("+hidcat+")";
			}
			if(!(hidsubcat.equalsIgnoreCase("0") || hidsubcat.equalsIgnoreCase("") || hidsubcat.equalsIgnoreCase("undefined"))){
				wheresql=wheresql+"  and sc.doc_no in ("+hidsubcat+")";
			}

			if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
				wheresql=wheresql+"  and m.doc_no in ("+hidproduct+")";
			}
			
			String opsql="";
		 if(!(branchid.equalsIgnoreCase("0") || branchid.equalsIgnoreCase("") || branchid.equals("undefined")|| branchid.equalsIgnoreCase("a"))){
				insql=" and pin.brhid in ("+branchid+")";
				outsql=" and pout.brhid in ("+branchid+")";
				opsql="and brhid in ("+branchid+")";
				
			} 
			if(!(hidept.equalsIgnoreCase("0") || hidept.equalsIgnoreCase("") || hidept.equalsIgnoreCase("undefined"))){
				wheresql=wheresql+"  and dep.doc_no in ("+hidept+")";
			}
			 
 

			sqljoin = " left join my_main m on(pin.psrno=m.psrno) "
					+ " left join my_ptype pt on(m.typeid=pt.doc_no) "
					+ " left join my_brand bd on(m.brandid=bd.doc_no) "
					+ " left join my_dept dep on(dep.doc_no=m.deptid) "
					+ " left join my_catm cat on(m.catid=cat.doc_no)"
					+ " left join my_scatm sc on(m.scatid=sc.doc_no)" ;
				 
			
			

			sqljoin1 = " left join my_main m on(pout.psrno=m.psrno) "
					+ " left join my_ptype pt on(m.typeid=pt.doc_no) "
					+ " left join my_brand bd on(m.brandid=bd.doc_no) "
					+ " left join my_dept dep on(dep.doc_no=m.deptid) "
					+ " left join my_catm cat on(m.catid=cat.doc_no) "
					+ " left join my_scatm sc on(m.scatid=sc.doc_no) " ;
 
			
			sqljoin2 = " left join my_main m on(ops.prdid=m.psrno) "
					+ " left join my_ptype pt on(m.typeid=pt.doc_no) "
					+ " left join my_brand bd on(m.brandid=bd.doc_no) "
					+ " left join my_dept dep on(dep.doc_no=m.deptid) "
					+ " left join my_catm cat on(m.catid=cat.doc_no) "
					+ " left join my_scatm sc on(m.scatid=sc.doc_no) " ;
 
 
			
/*			String	sql="   select DATE_FORMAT(date,'%d-%m-%Y') DATE,convert(dtype,char(100)) TYPE,convert(docno,char(100)) DOCNO,"
					+ " convert(description,char(100))  'CLIENT/VENDOR',convert(inqty,char(100)) 'IN QUANTITY',convert(inval,char(100)) 'IN VALUE' ,"
					+ " convert(isqty,char(20)) 'ISSUED  QUANTITY',convert(isval,char(100)) 'ISSUED  VALUE',"
					+ " coalesce(round(@i:=@i+(inqty-isqty),2),0) 'BALANCE  QUANTITY' ,coalesce(round(@j:=@j+(inval-isval),2),0)  'BALANCE VALUE', "
					+ " convert(if(valtype!='out',cpu,''),char(100)) 'COST PER UNIT' "
					+ "  from ("
				 	+ " select 0 ord, 0 minus,'OP' valtype, 0  tr_no,ops.prdid psrno,cast(DATE_ADD('"+frmdate+"', INTERVAL -1 DAY) as date) date, "
					+ " 'OPENING' description,0 stockid,'OPN' dtype, '' docno, '' acno,ops.inqty, ops.inval,'' isqty, '' isval, '' balqty, '' balcost, "
					+ " ops.inval/ops.inqty cpu from (select sum(op.opqty) inqty,sum(op.cost_price)  inval,op.prdid from (select (p.op_qty)-(coalesce(a.outqty,0)) opqty ,((op_qty)-(coalesce(a.outqty,0)))*p.cost_price  "
					+ " cost_price,p.Stockid,p.prdid from my_prddin  p	left join (select sum(qty) outqty,stockid from my_prddout where "
					+ "     cast(date as date)<'"+frmdate+"' "+opsql+"   group by stockid) a      on a.stockid=p.stockid "
							+ " where  cast(p.date as date)<'"+frmdate+"'  "+opsql+"  group by p.Stockid)  op group by op.prdid ) ops  "+sqljoin2+" where 1=1 "+wheresql+""
									+ " union all  "
					+ "select 1 ord,0 minus,'in' valtype, ins.tr_no, ins.psrno,ins.date,h.description, "
					+ "ins.stockid,ins.dtype,ins.docno,ins.acno,ins.inqty,ins.inval,ins.isqty, "
						 + "	ins.isval,ins.balqty,ins.balcost,ins.cpu from  "
						 + "(select pin.tr_no,pin.stockid, case when pin.dtype='GRN' then GRN.voc_no   when pin.dtype='PIV' then PIV.voc_no  "
						 + "when pin.dtype='DLR' then DLR.voc_no  when pin.dtype='INR' then INR.voc_no  "
						 + "when  pin.dtype='ITR' then ITR.voc_no   when  pin.dtype='GIR' then GIR.voc_no  else ''  end as DOCNO,  "
						 + "case when pin.dtype='GRN' then GRN.acno   when pin.dtype='PIV' then PIV.acno  "
						 + "when pin.dtype='DLR' then DLR.acno  when pin.dtype='INR' then INR.acno  "
						 + "when  pin.dtype='ITR' then ITR.acno   when  pin.dtype='GIR' then GIR.acno  else ''  end as acno,  "
						 + "pin.dtype, pin.brhid,pin.psrno,pin.date ,pin.op_qty inqty ,pin.op_qty*pin.cost_price inval ,  "
						 + " ' ' isqty, ' '  isval,  "
						 + " ' ' balqty, ' ' balcost,  "
						 + " cost_price cpu  from my_prddin pin  "
						  + "left join my_grnm GRN on GRN.tr_no=pin.tr_no and pin.dtype='GRN'  "
						  + "left join my_srvm piv on PIV.tr_no=pin.tr_no and pin.dtype='PIV'  "
						  + "left join my_delrm DLR on DLR.tr_no=pin.tr_no and pin.dtype='DLR'  "
						  + "left join   my_invr  INR on INR.tr_no=pin.tr_no and pin.dtype='INR'  "
						  + "left join   my_invtranreceptm  ITR on ITR.tr_no=pin.tr_no and pin.dtype='ITR'  "
						  + "left join   my_girm  GIR on GIR.tr_no=pin.tr_no and pin.dtype='GIR' "+sqljoin+" where 1=1  and "
						  + "  cast(pin.date as date)>='"+frmdate+"' and cast(pin.date as date)<='"+todate+"'  "+insql+" "+wheresql+"  "
						  + "group by pin.stockid order by pin.stockid) ins  "
						  + "left join my_head h on(h.doc_no=ins.acno)  "
						  + " union all  "
						 + " select 2 ord,outs.minus ,'out' valtype, outs.tr_no,outs.psrno, outs.date,ac.refname description,outs.Stockid,outs.dtype,outs.docno,  "
						 + " outs.acno,' ' inqty,' ' inval,outs.issqty isqty,outs.issqty*outs.issuecostprice isval ,  "
						  + "' 'balqty,' ' balcost, outs.issuecostprice cpu  "
						  + "from (select case when pout.dtype='INV' then if(pout.rsv_qty<0,pout.rsv_qty,pout.del_qty) else 0 end as minus,pout.tr_no,pout.psrno,pout.Stockid,pout.dtype,cast(pout.date as date) date,  "
						  + "case when pout.dtype='GRR' then GRR.voc_no   when pout.dtype='PIR' then PIR.voc_no  "
						  + "	when pout.dtype='SOR' then SOR.voc_no  when pout.dtype='JOR' then JOR.voc_no  "
						  + "	when  pout.dtype='DEL' then DEL.voc_no   when  pout.dtype='INV' then INV.voc_no  when  pout.dtype='ITI' then ITI.voc_no  "
						  + "	when  pout.dtype='GIS' then GIS.voc_no  "
						  + "	else ''  end as DOCNO,   case when pout.dtype='GRR' then GRR.cldocno   when pout.dtype='PIR' then PIR.cldocno    when pout.dtype='SOR'  "
						  + " then SOR.cldocno  when pout.dtype='JOR' then JOR.cldocno    when  pout.dtype='DEL'  then DEL.cldocno   when  pout.dtype='INV' then INV.cldocno  "
						  + " 	when  pout.dtype='GIS' then GIS.cldocno  	else ''  end as cldocno , "
						  + "	case when pout.dtype='GRR' then GRR.acno   when pout.dtype='PIR' then PIR.acno  "
						 + "    when pout.dtype='SOR' then SOR.acno  "
						 + "    when  pout.dtype='DEL' then DEL.acno   when  pout.dtype='INV' then INV.acno  when  pout.dtype='ITI' then ITI.acno  "
						 + "	when  pout.dtype='GIS' then GIS.acno  "
						 + "	else ''  end as acno, case when  pout.dtype='DEL' then  "
						 + "	de.del_qty  "
						 + "	when  pout.dtype='SOR' ||  pout.dtype='JOR' then  "
						 + "	 rs.rsv_qty  "
						 + "	else pout.qty end as issqty, p.cost_price issuecostprice  "
						 + "	from my_prddout pout left join  my_prddin p     on pout.stockid=p.stockid and pout.dtype!='SOR'  and pout.dtype!='JOR'  "
						 + " left join (select rsv_qty,stockid,doc_no from my_prddout group by stockid,doc_no) rs on rs.Stockid=pout.stockid and rs.doc_no=pout.doc_no "
						 + " left join (select del_qty,stockid,doc_no from my_prddout group by stockid,doc_no) de on de.Stockid=pout.stockid and de.doc_no=pout.doc_no "
						 + "	left join my_grrm GRR on GRR.tr_no=pout.tr_no and pout.dtype='GRR'  "
						 + "	left join my_srrm PIR on PIR.tr_no=pout.tr_no and pout.dtype='PIR'  "
						 + "	left join my_sorderm SOR on SOR.tr_no=pout.tr_no and pout.dtype='SOR'  "
						 + "	left join   my_joborderm  JOR on JOR.tr_no=pout.tr_no and pout.dtype='JOR'  "
						 + "	left join   my_delm  DEL on DEL.tr_no=pout.tr_no and pout.dtype='DEL'  "
						 + "	left join   my_invm  INV on INV.tr_no=pout.tr_no and pout.dtype='INV'  "
						 + "	left join   my_invtranissuem ITI on ITI.tr_no=pout.tr_no and pout.dtype='ITI'  "
						 + "    left join   my_gism  GIS on GIS.tr_no=pout.tr_no and GIS.dtype='GIS'  "+sqljoin1+" "
						 + "	where 1=1  and pout.dtype!='SOR' and pout.dtype!='JOR' and cast(pout.date as date)>='"+frmdate+"' and cast(pout.date as date)<='"+todate+"'   "+outsql+"  "+wheresql+"   order by stockid,pout.doc_no) outs  "
						 + "    left join my_head h on(h.doc_no=outs.acno)     left join my_acbook ac on(ac.doc_no=outs.cldocno and ac.dtype='CRM') ) "
						 + "  res,(select @i:=0) as i,(select @j:=0) as j order by res.psrno, res.date,res.tr_no ";

						  
			*/
			
			String	sql="   select DATE_FORMAT(date,'%d-%m-%Y') DATE,convert(dtype,char(100)) TYPE,convert(docno,char(100)) DOCNO,"
					+ " convert(description,char(100))  'CLIENT/VENDOR',convert(inqty,char(100)) 'IN QUANTITY',convert(inval,char(100)) 'IN VALUE' ,"
					+ " convert(isqty,char(20)) 'ISSUED  QUANTITY',convert(isval,char(100)) 'ISSUED  VALUE',"
					+ " coalesce(round(@i:=@i+(inqty-issqty1),2),0) 'BALANCE  QUANTITY' ,coalesce(round(@j:=@j+(inval-isval1),2),0)  'BALANCE VALUE', "
					+ " convert(if(valtype!='out',cpu,''),char(100)) 'COST PER UNIT' "
					+ "  from ("
				 	+ " select 0 ord, 0 minus,'OP' valtype, 0  tr_no,ops.prdid psrno,cast(DATE_ADD('"+frmdate+"', INTERVAL -1 DAY) as date) date, "
					+ " 'OPENING' description,0 stockid,'OPN' dtype, '' docno, '' acno,ops.inqty, ops.inval,'' isqty,'' issqty1, '' isval, '' isval1, '' balqty, '' balcost, "
					+ " ops.inval/ops.inqty cpu from (select sum(op.opqty) inqty,sum(op.cost_price)  inval,op.prdid from "
					+ "  (select (p.op_qty)-(coalesce(a.outqty,0)) opqty ,((op_qty)-(coalesce(a.outqty,0)))*p.cost_price  "
					+ " cost_price,p.Stockid,p.prdid,p.brhid from my_prddin  p	left join (select sum(qty) outqty,stockid from my_prddout where "
					+ "     cast(date as date)<'"+frmdate+"' "+opsql+"   group by stockid) a      on a.stockid=p.stockid "
							+ " where  cast(p.date as date)<'"+frmdate+"'  "+opsql+"  group by p.Stockid)  op group by op.prdid ) ops  "+sqljoin2+" where 1=1 "+wheresql+""
									+ " union all  "
					+ "select 1 ord,0 minus,'in' valtype, ins.tr_no, ins.psrno,ins.date,h.description, "
					+ "ins.stockid,ins.dtype,ins.docno,ins.acno,ins.inqty,ins.inval,ins.isqty, ins.isqty issqty1, "
					+ "  ins.isval,ins.isval isval1,ins.balqty,ins.balcost,ins.cpu from  "
						 + "(select pin.tr_no,pin.stockid, case when pin.dtype='GRN' then GRN.voc_no when pin.dtype='PHK' then PHK.voc_no   when pin.dtype='PIV' then PIV.voc_no  "
						 + "when pin.dtype='DLR' then DLR.voc_no  when pin.dtype='INR' then INR.voc_no  "
						 + "when  pin.dtype='ITR' then ITR.voc_no   when  pin.dtype='GIR' then GIR.voc_no  else ''  end as DOCNO,  "
						 + "case when pin.dtype='GRN' then GRN.acno   when pin.dtype='PIV' then PIV.acno  "
						 + "when pin.dtype='DLR' then DLR.acno  when pin.dtype='INR' then INR.acno  "
						 + "when  pin.dtype='ITR' then ITR.acno   when  pin.dtype='GIR' then GIR.acno  else ''  end as acno,  "
						 + "pin.dtype, pin.brhid,pin.psrno,pin.date ,pin.op_qty inqty ,pin.op_qty*pin.cost_price inval ,  "
						 + " ' ' isqty,' ' isqty1, ' '  isval, ' '  isval1,  "
						 + " ' ' balqty, ' ' balcost,  "
						 + " cost_price cpu  from my_prddin pin  "
						  + "left join my_grnm GRN on GRN.tr_no=pin.tr_no and pin.dtype='GRN'   left join my_phkm PHK on PHK.tr_no=pin.tr_no and pin.dtype='PHK'    "
						  + "left join my_srvm piv on PIV.tr_no=pin.tr_no and pin.dtype='PIV'  "
						  + "left join my_delrm DLR on DLR.tr_no=pin.tr_no and pin.dtype='DLR'  "
						  + "left join   my_invr  INR on INR.tr_no=pin.tr_no and pin.dtype='INR'  "
						  + "left join   my_invtranreceptm  ITR on ITR.tr_no=pin.tr_no and pin.dtype='ITR'  "
						  + "left join   my_girm  GIR on GIR.tr_no=pin.tr_no and pin.dtype='GIR' "+sqljoin+" where 1=1  and "
						  + "  cast(pin.date as date)>='"+frmdate+"' and cast(pin.date as date)<='"+todate+"'  "+insql+" "+wheresql+"  "
						  + "group by pin.stockid order by pin.stockid) ins  "
						  + "left join my_head h on(h.doc_no=ins.acno)  "
						  + " union all  "
						 + " select 2 ord,outs.minus ,'out' valtype, outs.tr_no,outs.psrno, outs.date,ac.refname description,outs.Stockid,outs.dtype,outs.docno,  "
						 + " outs.acno,' ' inqty,' ' inval,outs.issqty isqty,outs.issqty1,outs.issqty*outs.issuecostprice isval , "
						 + " outs.issqty1*outs.issuecostprice isval1,  "
						  + "' 'balqty,' ' balcost, outs.issuecostprice cpu  "
						  + "from (select case when pout.dtype='INV' then if(pout.rsv_qty<0,pout.rsv_qty,pout.del_qty) else 0 end as minus,pout.tr_no,pout.psrno,pout.Stockid,pout.dtype,cast(pout.date as date) date,  "
						  + "case when pout.dtype='GRR' then GRR.voc_no   when pout.dtype='PIR' then PIR.voc_no  "
						  + "	when pout.dtype='SOR' then SOR.voc_no  when pout.dtype='JOR' then JOR.voc_no   when pout.dtype='PHK' then PHK.voc_no  "
						  + "	when  pout.dtype='DEL' then DEL.voc_no  when  pout.dtype='INC' then INV.voc_no  when  pout.dtype='INV' then INV.voc_no  when  pout.dtype='ITI' then ITI.voc_no  "
						  + "	when  pout.dtype='GIS' then GIS.voc_no  "
						  + "	else ''  end as DOCNO,   case when pout.dtype='GRR' then GRR.cldocno   when pout.dtype='PIR' then PIR.cldocno    when pout.dtype='SOR'  "
						  + " then SOR.cldocno  when pout.dtype='JOR' then JOR.cldocno    when  pout.dtype='DEL'  then DEL.cldocno when  pout.dtype='INC' then INV.cldocno   when  pout.dtype='INV' then INV.cldocno  "
						  + " 	when  pout.dtype='GIS' then GIS.cldocno  	else ''  end as cldocno , "
						  + "	case when pout.dtype='GRR' then GRR.acno   when pout.dtype='PIR' then PIR.acno  "
						 + "    when pout.dtype='SOR' then SOR.acno  "
						 + "    when  pout.dtype='DEL' then DEL.acno  when  pout.dtype='INC' then INV.acno    when  pout.dtype='INV' then INV.acno  when  pout.dtype='ITI' then ITI.acno  "
						 + "	when  pout.dtype='GIS' then GIS.acno  "
						 + "	else ''  end as acno, case when  pout.dtype='DEL' then  "
						 + "	de.del_qty  "
						 + "	when  pout.dtype='SOR' ||  pout.dtype='JOR' then  "
						 + "	 rs.rsv_qty  "
						 + "	else pout.qty end as issqty, case when  pout.dtype='DEL' then  "
						 + "	de.del_qty  "
						 + "	when  pout.dtype='SOR' ||  pout.dtype='JOR' then  "
						 + "	 rs.rsv_qty  "
						 + "	else pout.qty+pout.del_qty end as issqty1, p.cost_price issuecostprice "
						 + "	from my_prddout pout left join  my_prddin p     on pout.stockid=p.stockid and pout.dtype!='SOR'  and pout.dtype!='JOR'  "
						 + " left join (select rsv_qty,stockid,doc_no from my_prddout group by stockid,doc_no) rs on rs.Stockid=pout.stockid and rs.doc_no=pout.doc_no "
						 + " left join (select del_qty,stockid,doc_no from my_prddout group by stockid,doc_no) de on de.Stockid=pout.stockid and de.doc_no=pout.doc_no "
						 + "	left join my_grrm GRR on GRR.tr_no=pout.tr_no and pout.dtype='GRR'  "
						 + "	left join my_srrm PIR on PIR.tr_no=pout.tr_no and pout.dtype='PIR'  "
						 + "	left join my_sorderm SOR on SOR.tr_no=pout.tr_no and pout.dtype='SOR'  "
						 + "	left join   my_joborderm  JOR on JOR.tr_no=pout.tr_no and pout.dtype='JOR' left join my_phkm PHK on PHK.tr_no=pout.tr_no and pout.dtype='PHK'   "
						 + "	left join   my_delm  DEL on DEL.tr_no=pout.tr_no and pout.dtype='DEL'  "
						 + "	left join   my_invm  INV on INV.tr_no=pout.tr_no and pout.dtype in ('INV','INC')  "
						 + "	left join   my_invtranissuem ITI on ITI.tr_no=pout.tr_no and pout.dtype='ITI'  "
						 + "    left join   my_gism  GIS on GIS.tr_no=pout.tr_no and GIS.dtype='GIS'  "+sqljoin1+" "
						 + "	where 1=1  and  pout.dtype!='SOR' and pout.dtype!='JOR' and cast(pout.date as date)>='"+frmdate+"' and cast(pout.date as date)<='"+todate+"'   "+outsql+"  "+wheresql+"   order by stockid,pout.doc_no) outs  "
						 + "    left join my_head h on(h.doc_no=outs.acno)     left join my_acbook ac on ((ac.doc_no=outs.cldocno and ac.dtype='CRM' and outs.dtype!='PIR') or ((ac.doc_no=outs.cldocno and ac.dtype='VND' and outs.dtype='PIR')) ) ) "
						 + "  res,(select @i:=0) as i,(select @j:=0) as j order by res.psrno, res.date,res.tr_no "; 
			
		 	//System.out.println("==stockLedgerDetail=111=="+sql);

		//	ArrayList<String> stldarray= new ArrayList<String>();
			ResultSet rs = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToEXCEL(rs);
			
			
			
		/*	
			String valtype="";
			
			String	psrno="";
			String	trtype="";
			String	docno="";
			String	date="";
			String	trans_type="";
			String	desc1="";
			
			String totalqty1="",issueqty1="",balqty1="",remqty1 ="";
			
			String  cpu1="",inval1="",isval1="",totbalval1="";
			
			
			double totalqty=0,issueqty=0,balqty=0,remqty = 0;
			
			double cpu=0,inval=0,isval=0,totbalval=0;
			int i=0;
			int j=0;
			int k=0;

			int minus=0;
			while(rs.next()){
				
				valtype=rs.getString("valtype");
				if(valtype.equalsIgnoreCase("in"))
				{
					totalqty=rs.getDouble("inqty");
					remqty=totalqty;
					issueqty=0;
					i=i+1;
					j=0;
				}
				else if(valtype.equalsIgnoreCase("out"))
				{
					totalqty=0;
					issueqty=rs.getDouble("isqty");
					
					minus=rs.getInt("minus");
		//			System.out.println("======minus======"+minus);
					
					if(minus>=0)
					{
					remqty=remqty-issueqty;
					}
					j=j+1;
				}
				
				balqty=remqty;
			
			
			
		 	psrno=rs.getString("psrno");
		 	trtype=valtype;
		 	docno=rs.getString("docno");
		 	date=rs.getString("date");
		 	trans_type=rs.getString("dtype");
		 	desc1=rs.getString("description");
		 	
	
		 	cpu=rs.getDouble("cpu");
		 	
		 	if(totalqty>0)
		 	{
		 		inval=totalqty*cpu;
		 		totalqty1=totalqty+"";
		 		inval1=inval+"";
		 		cpu1=cpu+"";
		 	}
		 	else
		 	{
		 		cpu1="";
		 		totalqty1="";
		 		inval1="";
		 	}
		 	if(issueqty>0)
		 	{
		 	isval=issueqty*cpu;
		 	issueqty1=issueqty+"";
		 	isval1=isval+"";
		 	}
		 	else
		 	{
		 		
		 	 	 if(valtype.equalsIgnoreCase("out"))
					{
			 		 
		 	 		issueqty1="0";
				 	isval1="0";
					}
		 	 	 else
		 	 	 {
		 		issueqty1="";
			 	isval1="";
		 	 	 }
		 		
		 	}
		 	if(balqty>=0 && minus>=0)
		 	{
		 	totbalval=balqty*cpu;
		 	balqty1=balqty+"";
		 	totbalval1=totbalval+"";
		 	}
		 	else
		 	{
		 		
		 	 	balqty1="";
			 	totbalval1="";	
		 	}
		 	
		 	
		 	if(valtype.equalsIgnoreCase("in"))
			{
		 	  k=i;
			}
		 	else if(valtype.equalsIgnoreCase("out"))
			{
		 		  k=j;
			}
		 
			stldarray.add(date+"::"+docno+"::"+trans_type+"::"+totalqty1+"::"+inval1+"::"+issueqty1+"::"+isval1+"::"+balqty1+"::"+totbalval1+"::"+trtype+"::"+cpu1+"::"+desc1+"::"+k+"::"+psrno);
			
			}
		 	
		//	System.out.println("==============="+stldarray);


			String psrno="0",prvpsrno="0",pno="",pname="",docno="",trans_type="",trtype="",date="",desc1="";
			double inqty=0.00,inval=0.00,isqty=0.00,isval=0.00,balqty=0.00,balval=0.00,totinqty=0.0,totinval=0.0,totisqty=0.0,totisval=0.0,totbalqty=0.0,totbalval=0.0,cpu=0.0;
			int i=0;
			int k=1;
			while(rs.next()){
				psrno=rs.getString("psrno");
				trtype=rs.getString("trtype");
				docno=rs.getString("docno");
				date=rs.getString("date");
				trans_type=rs.getString("trans_type");
				desc1=rs.getString("desc1");
				if(!(prvpsrno.equalsIgnoreCase(psrno))){
					k=1;
					if(i!=0){
						cpu=totbalval/totbalqty;
					stldarray.add(""+"::"+pno+"::"+""+"::"+totinqty+"::"+totinval+"::"+totisqty+"::"+totisval+"::"+totbalqty+"::"+totbalval+"::0"+"::"+cpu+"::"+pname+"::"+""+"::"+psrno);
					}
					inqty=0.00;inval=0.00;isqty=0.00;isval=0.00;balqty=0.00;balval=0.00;totinqty=0.0;totinval=0.0;totisqty=0.0;totisval=0.0;totbalqty=0.0;totbalval=0.0;
					pno=rs.getString("pno");
					pname=rs.getString("pname");
					psrno=rs.getString("psrno");
					trtype=rs.getString("trtype");
					docno=rs.getString("docno");
					date=rs.getString("date");
					trans_type=rs.getString("trans_type");
					desc1=rs.getString("desc1");
				}
				
				inqty=Double.parseDouble(rs.getString("inqty"));inval=Double.parseDouble(rs.getString("inval"));
				isqty=Double.parseDouble(rs.getString("isqty"));isval=Double.parseDouble(rs.getString("isval"));
				balqty=Double.parseDouble(rs.getString("balqty"));balval=Double.parseDouble(rs.getString("balval"));
				totinqty=totinqty+inqty;
				totisqty=totisqty+isqty;
				totinval=totinval+inval;
				totisval=totisval+isval;
				totbalqty=totbalqty+balqty;
				totbalval=totbalval+balval;
				if(trtype.equalsIgnoreCase("2")){
					balqty=totinqty-totisqty;
					balval=totinval-totisval;
							
				}
				
				prvpsrno=psrno;
				
				stldarray.add(date+"::"+docno+"::"+trans_type+"::"+inqty+"::"+inval+"::"+isqty+"::"+isval+"::"+totbalqty+"::"+totbalval+"::"+trtype+"::"+" "+"::"+desc1+"::"+k+"::"+psrno);
				
				i++;
				k++;
	
			}
			cpu=totbalval/totbalqty;
			stldarray.add(""+"::"+pno+"::"+""+"::"+totinqty+"::"+totinval+"::"+totisqty+"::"+totisval+"::"+totbalqty+"::"+totbalval+"::0"+"::"+cpu+"::"+pname+"::"+""+"::"+psrno);
			//stldarray.add(""+"::"+pno+"::"+""+"::"+totinqty+"::"+totinval+"::"+totisqty+"::"+totisval+"::"+totbalqty+"::"+totbalval+"::0"+"::"+pname+"::"+"");
			*/
		//	RESULTDATA=convertArrayToJSON(stldarray);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}


	public JSONArray suitSearch(HttpSession session,String yomfrm,String yomto) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select s.doc_no,coalesce(syf.yom,s.yom_frm) yomfrm,coalesce(syt.yom,s.yom_to) yomto,s.doc_no,brand,(case when s.smodelid=-1 then 'ALL' else model end) as model,"
					+ "(case when s.submodelid=-1 then 'ALL' else submodel end) as submodel,"
					+ "(case when s.esizeid=-1 then 'ALL' else coalesce(s2.spec,'') end) as esize,"
					+ "(case when s.bsize1id=-1 then 'ALL' else coalesce(s11.spec,'') end) as bsize1,"
					+ "(case when s.bsize2id=-1 then 'ALL' else coalesce(s12.spec,'') end) as bsize2,"
					+ "(case when s.bsize3id=-1 then 'ALL' else coalesce(s13.spec,'') end) as bsize3,"
					+ "(case when s.csize1id=-1 then 'ALL' else coalesce(s31.spec,'') end) as csize1,"
					+ "(case when s.csize2id=-1 then 'ALL' else coalesce(s32.spec,'') end) as csize2,"
					+ "(case when s.csize3id=-1 then 'ALL' else coalesce(s33.spec,'') end) as csize3,"
					+ "s.sbrandid brandid,s.smodelid brandid,s.submodelid submodelid,s.esizeid,s.bsize1id,s.bsize2id,s.bsize3id,"
					+ "s.csize1id,s.csize2id,s.csize3id,ps.syomfrm_id yomfrmid,ps.syomto_id yomtoid  "
					+ "from my_vehsuitmaster s left join my_sbrand b on(b.doc_no=s.sbrandid) left join my_smodel m on(m.doc_no=s.smodelid)"
					+ "left join my_ssubmodel sm on(sm.doc_No=s.submodelid) left join my_suitspec2 s2 on(s2.doc_no=s.esizeid)"
					+ "left join my_suitspec1 s11 on(s11.doc_no=s.bsize1id)"
					+ "left join my_suitspec1 s12 on(s12.doc_no=s.bsize2id)"
					+ "left join my_suitspec1 s13 on(s13.doc_no=s.bsize3id)"
					+ "left join my_suitspec3 s31 on(s31.doc_no=s.csize1id)"
					+ "left join my_suitspec3 s32 on(s32.doc_no=s.csize2id)"
					+ "left join my_suitspec3 s33 on(s33.doc_no=s.csize3id)"
					+ "left join my_prodsuit ps on(ps.vehsuitid=s.doc_no)"
					+ "left join my_syom syf on(ps.syomfrm_id=syf.doc_no)"
					+ "left join my_syom syt on(ps.syomto_id=syt.doc_no)"
					+ "where s.status=3 ";

			/*and date_format(str_to_date(s.yom_frm,'%Y'),'%Y')>="+yomfrm+" and date_format(str_to_date(yom_to,'%Y'),'%Y')<="+yomto+"*/

//			System.out.println("=sql==suitSearch="+sql);

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}


	
	public JSONArray stockLedgerDetail1(HttpSession session,String hidbrand,String fromDate,String toDate,String hidtype,String hidcat,
			String hidsubcat,String hidproduct,String branchid,String hidept,String load) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();
//		System.out.println("load==============="+load);
		
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
			String sqljoin1 ="";
			String wheresql="";

		 String insql="";
		 String outsql="";

			java.sql.Date frmdate=ClsCommon.changeStringtoSqlDate(fromDate);

			java.sql.Date todate=ClsCommon.changeStringtoSqlDate(toDate);

			if(!(hidbrand.equalsIgnoreCase("0") || hidbrand.equalsIgnoreCase("") || hidbrand.equalsIgnoreCase("undefined"))){
				wheresql=wheresql+" and bd.doc_no in ("+hidbrand+")";
			}

			if(!(hidtype.equalsIgnoreCase("0") || hidtype.equalsIgnoreCase("") || hidtype.equalsIgnoreCase("undefined"))){
				wheresql=wheresql+"  and pt.doc_no in ("+hidtype+")";
			}

			if(!(hidcat.equalsIgnoreCase("0") || hidcat.equalsIgnoreCase("") || hidcat.equalsIgnoreCase("undefined"))){
				wheresql=wheresql+"  and cat.doc_no in ("+hidcat+")";
			}
			if(!(hidsubcat.equalsIgnoreCase("0") || hidsubcat.equalsIgnoreCase("") || hidsubcat.equalsIgnoreCase("undefined"))){
				wheresql=wheresql+"  and sc.doc_no in ("+hidsubcat+")";
			}

			if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
				wheresql=wheresql+"  and m.doc_no in ("+hidproduct+")";
			}
		 if(!(branchid.equalsIgnoreCase("0") || branchid.equalsIgnoreCase("") || branchid.equals("undefined")|| branchid.equalsIgnoreCase("a"))){
				insql=" and pin.brhid in ("+branchid+")";
				outsql=" and pout.brhid in ("+branchid+")";
			} 
			if(!(hidept.equalsIgnoreCase("0") || hidept.equalsIgnoreCase("") || hidept.equalsIgnoreCase("undefined"))){
				wheresql=wheresql+"  and dep.doc_no in ("+hidept+")";
			}
			 
			 
/*
			sqljoin = "left join my_main m on(pin.psrno=m.psrno) "
					+ "left join my_ptype pt on(m.typeid=pt.doc_no) "
					+ "left join my_brand bd on(m.brandid=bd.doc_no) "
					+ "left join my_dept dep on(dep.doc_no=m.deptid) "
					+ "left join my_catm cat on(m.catid=cat.doc_no)"
					+ "left join my_scatm sc on(m.scatid=sc.doc_no)"
					+ "left join my_brch brc on(e.brhid=brc.doc_no) "
					+ "left join my_locm lm on(e.locid=lm.doc_no)";
			*/

			sqljoin = " left join my_main m on(pin.psrno=m.psrno) "
					+ " left join my_ptype pt on(m.typeid=pt.doc_no) "
					+ " left join my_brand bd on(m.brandid=bd.doc_no) "
					+ " left join my_dept dep on(dep.doc_no=m.deptid) "
					+ " left join my_catm cat on(m.catid=cat.doc_no)"
					+ " left join my_scatm sc on(m.scatid=sc.doc_no)" ;
				 
			
			

			sqljoin1 = " left join my_main m on(pout.psrno=m.psrno) "
					+ " left join my_ptype pt on(m.typeid=pt.doc_no) "
					+ " left join my_brand bd on(m.brandid=bd.doc_no) "
					+ " left join my_dept dep on(dep.doc_no=m.deptid) "
					+ " left join my_catm cat on(m.catid=cat.doc_no) "
					+ " left join my_scatm sc on(m.scatid=sc.doc_no) " ;
 
			


			/*sql="select e.psrno,stockid,part_no pno,productname pname,inqty,inval,DATE_FORMAT(e.date,'%m-%d-%Y') date,docno,trans_type,outqty isqty,outval isval,inqty-outqty as balqty,inval-outval as balval,trtype from "
					+ "(select opqty inqty,stockid,psrno,date,DOCNO,trans_type,0 as outqty,(opqty*unit_price) as inval,0 as outval,1 as trtype from "
					+ "(select sum(a.qty) opqty,a.stockid,a.psrno,a.date,'OPN' trans_type,0 as docno,a.unit_price from  "
					+ "(select op_qty qty,stockid,psrno,date,dtype,brhid,locid,unit_price from my_prddin p "
					+ "union all select (p.qty*-1+del_qty*-1) qty,stockid,psrno,date,dtype,brhid,locid,0 as unit_price from my_prddout p) as a "
					+ "where cast(a.date as date)<'"+frmdate+"'  group by psrno order by psrno) as b union all select inqty,stockid,psrno,date,DOCNO,trans_type,0 as outqty,(inqty*unit_price) as inval,0 as outval,1 as trtype "
					+ "from (SELECT sum(op_qty) inqty,p.stockid,p.psrno,p.date,(case when p.dtype='GRN' then mg.voc_no else (case when p.dtype='PIV' then sm.voc_no else (case when p.dtype='DLR' then dm.voc_no else "
					+ "(case when p.dtype='INR' then irm.voc_no else itm.voc_no end) end) end) end) as DOCNO, "
					+ "(p.dtype) as  trans_type,p.unit_price from my_prddin p left join my_grnd gn on(gn.psrno=p.psrno and gn.stockid=p.stockid) "
					+ "left join my_grnm mg on(mg.doc_no=gn.rdocno) left join my_srvd sd on(sd.psrno=p.psrno and sd.stockid=p.stockid) left join my_srvm sm on(sm.doc_no=sd.rdocno) left join my_delrd dd on (dd.psrno=p.psrno and dd.stockid=p.stockid) left join my_delrm dm on(dm.doc_no=dd.rdocno) "
					+ "left join my_inrd id on (id.psrno=p.psrno and id.stockid=p.stockid) left join my_invr irm  on(irm.doc_no=id.rdocno) left join my_invtranreceptd it on(it.psrno=p.psrno and it.stockid=p.stockid) left join my_invtranreceptm itm on(itm.doc_no=it.rdocno) "
					+ "where cast(p.date as date)<='"+todate+"' and cast(p.date as date)>='"+frmdate+"' group by p.dtype,p.psrno) as c union all select 0 as opnqty,stockid,psrno,date,DOCNO,trans_type,outqty,0 as inval,(outqty*unit_price) outval,2 as trtype from "
					+ "(select sum(p.qty+p.del_qty) outqty,p.stockid,p.psrno,p.date,(case when p.dtype='GRR' then mg.voc_no else (case when p.dtype='DEL' then dm.voc_no else (case when p.dtype='PIR' then sm.voc_no else (case when p.dtype='INV' then im.voc_no else itm.voc_no end) end) end) end) as DOCNO,"
					+ "(p.dtype) as  trans_type,intb.unit_price "
					+ "from my_prddout p left join my_prddin intb on(p.psrno=intb.psrno and p.stockid=intb.stockid) "
					+" left join my_grrd gr on(gr.psrno=p.psrno and gr.stockid=p.stockid) left join my_grrm mg on(mg.doc_no=gr.rdocno) left join my_deld dr on(dr.psrno=p.psrno and dr.stockid=p.stockid) left join my_delm dm on(dm.doc_no=dr.rdocno ) left join my_srrd sr on(sr.psrno=p.psrno and sr.stockid=p.stockid) "
					+ "left join my_srrm sm on(sm.doc_no=sr.rdocno ) left join my_invd ir on(ir.psrno=p.psrno and ir.stockid=p.stockid) left join my_invm im on(im.doc_no=ir.rdocno) left join my_invtranissued it on(it.psrno=p.psrno and it.stockid=p.stockid) left join my_invtranissuem itm on(itm.doc_no=it.rdocno) "
					+ "where cast(p.date as date)<='"+todate+"' and cast(p.date as date)>='"+frmdate+"' group by p.dtype,psrno)as d) as e  "+sqljoin+" where 1=1  "+sqlfinal+" order by e.psrno,trtype,cast(e.date as date)";*/
	//krish		
/*			sql="select e.psrno,stockid,part_no pno,productname pname,inqty,inval,DATE_FORMAT(e.date,'%d-%m-%Y') date,"
			  + "docno,trans_type,outqty isqty, outval isval,inqty-outqty as balqty,inval-outval as balval,trtype,ACNO,if(trans_type='ITR' or trans_type='ITI',concat(brc.branchname,' : ',lm.loc_name), h.description ) as desc1,e.brhid,e.locid,e.tr_no from "
			  + "(select opqty inqty,stockid,psrno,date,DOCNO,trans_type, "
			  + "0 as outqty,(opqty*unit_price) as inval,0 as outval,1 as trtype,ACNO,brhid,locid,tr_no from (select sum(a.qty) opqty,a.stockid,a.psrno,a.date, "
			  + "'OPN' trans_type,0 as docno,a.unit_price,0 as ACNO,brhid,locid,tr_no from "
			  + "(select op_qty qty,stockid,psrno,date,dtype,brhid,locid,unit_price,tr_no from my_prddin p union all "
			  + "select (p.qty*-1+del_qty*-1) qty,stockid,psrno,date,dtype,brhid,locid,0 as unit_price,tr_no from my_prddout p) as a "
			  + "where cast(a.date as date)<'"+frmdate+"'  group by psrno order by psrno) as b union all "
			  + "select inqty,stockid,psrno,date,DOCNO,trans_type,0 as outqty,(inqty*unit_price) as inval,0 as outval,1 as trtype,ACNO,brhid,locid,tr_no from (SELECT sum(op_qty) inqty,p.stockid,p.psrno,p.date, "
			  + "(case when p.dtype='GRN' then mg.voc_no else (case when p.dtype='PIV' then sm.voc_no else (case when p.dtype='DLR' then dm.voc_no else "
			  + "(case when p.dtype='INR' then irm.voc_no else itm.voc_no end) end) end) end) as DOCNO,(case when p.dtype='GRN' then mg.acno else(case when p.dtype='PIV' then sm.acno else "
			  + "(case when p.dtype='DLR' then dm.acno else (case when p.dtype='INR' then irm.acno else itm.acno end) end) end) end) as ACNO,(p.dtype) as  trans_type,p.unit_price,p.brhid,p.locid,p.tr_no from my_prddin p left join my_grnd gn "
			  + "on(gn.psrno=p.psrno and gn.stockid=p.stockid) left join my_grnm mg on(mg.doc_no=gn.rdocno) left join my_srvd sd on(sd.psrno=p.psrno and sd.stockid=p.stockid) left join my_srvm sm on(sm.doc_no=sd.rdocno) left join my_delrd dd on (dd.psrno=p.psrno and dd.stockid=p.stockid) "
			  + "left join my_delrm dm on(dm.doc_no=dd.rdocno) left join my_inrd id on (id.psrno=p.psrno and id.stockid=p.stockid) left join my_invr irm  on(irm.doc_no=id.rdocno) left join my_invtranreceptd it on(it.psrno=p.psrno and it.stockid=p.stockid) "
			  + "left join my_invtranreceptm itm on(itm.doc_no=it.rdocno) where cast(p.date as date)<='"+todate+"' and cast(p.date as date)>='"+frmdate+"' group by p.dtype,p.psrno) as c "
			  + "union all select 0 as opnqty,stockid,psrno,date,DOCNO,trans_type,outqty,0 as inval,(outqty*unit_price) outval,2 as trtype,ACNO,brhid,locid,tr_no from (select sum(p.qty+p.del_qty) outqty,p.stockid,p.psrno,p.date,(case when p.dtype='GRR' then mg.voc_no else(case when p.dtype='DEL' then dm.voc_no else "
			  + "(case when p.dtype='PIR' then sm.voc_no else (case when p.dtype='INV' then im.voc_no else itm.voc_no end) end) end) end) as DOCNO,(case when p.dtype='GRR' then mg.acno else(case when p.dtype='DEL' then dm.acno else (case when p.dtype='PIR' then sm.acno else(case when p.dtype='INV' then im.acno else itm.acno end) end) end) end) as ACNO, "
			  + "(p.dtype) as  trans_type,intb.unit_price,p.brhid,p.locid,p.tr_no from my_prddout p left join my_prddin intb on(p.psrno=intb.psrno and p.stockid=intb.stockid)  left join my_grrd gr "
			  + "on(gr.psrno=p.psrno and gr.stockid=p.stockid) left join my_grrm mg on(mg.doc_no=gr.rdocno) left join my_deld dr "
			  + "on(dr.psrno=p.psrno and dr.stockid=p.stockid) left join my_delm dm on(dm.doc_no=dr.rdocno ) left join my_srrd sr on(sr.psrno=p.psrno and sr.stockid=p.stockid) left join my_srrm sm on(sm.doc_no=sr.rdocno ) left join my_invd ir "
			  + "on(ir.psrno=p.psrno and ir.stockid=p.stockid) left join my_invm im on(im.doc_no=ir.rdocno) left join my_invtranissued it on(it.psrno=p.psrno and it.stockid=p.stockid) left join my_invtranissuem itm on(itm.doc_no=it.rdocno) where cast(p.date as date)<='"+todate+"' and cast(p.date as date)>='"+frmdate+"' group by p.dtype,psrno)as d) as e "
			  + "left join my_head h on(h.doc_no=e.acno) "+sqljoin+" where 1=1 and trans_type not in('SOR') "+sqlfinal+"  order by e.psrno,tr_no,cast(e.date as date)";
			
*/
			
			
			
			
			
		String	sql="   select * from (select 0 minus,'in' valtype, ins.tr_no, ins.psrno,ins.date,h.description,ins.stockid,ins.dtype,ins.docno,ins.acno,ins.inqty,ins.inval,ins.isqty, "
					 + "	ins.isval,ins.balqty,ins.balcost,ins.cpu from  "
					 + "(select pin.tr_no,pin.stockid, case when pin.dtype='GRN' then GRN.voc_no   when pin.dtype='PIV' then PIV.voc_no  "
					 + "when pin.dtype='DLR' then DLR.voc_no  when pin.dtype='INR' then INR.voc_no  when  pin.dtype='phk' then phk.voc_no  "
					 + "when  pin.dtype='ITR' then ITR.voc_no   when  pin.dtype='GIR' then GIR.voc_no  else ''  end as DOCNO,  "
					 + "case when pin.dtype='GRN' then GRN.acno   when pin.dtype='PIV' then PIV.acno  "
					 + "when pin.dtype='DLR' then DLR.acno  when pin.dtype='INR' then INR.acno  "
					 + "when  pin.dtype='ITR' then ITR.acno   when  pin.dtype='GIR' then GIR.acno  else ''  end as acno,  "
					 + "pin.dtype, pin.brhid,pin.psrno,pin.date ,pin.op_qty inqty ,pin.op_qty*pin.cost_price inval ,  "
					 + " ' ' isqty, ' '  isval,  "
					 + " ' ' balqty, ' ' balcost,  "
					 + " cost_price cpu  from my_prddin pin  "
					  + "left join my_grnm GRN on GRN.tr_no=pin.tr_no and pin.dtype='GRN'  "
					  + "left join my_srvm piv on PIV.tr_no=pin.tr_no and pin.dtype='PIV'  "
					  + "left join my_delrm DLR on DLR.tr_no=pin.tr_no and pin.dtype='DLR'  "
					  + "left join   my_invr  INR on INR.tr_no=pin.tr_no and pin.dtype='INR' left join my_phkm PHK on PHK.tr_no=pin.tr_no and pin.dtype='PHK'   "
					  + "left join   my_invtranreceptm  ITR on ITR.tr_no=pin.tr_no and pin.dtype='ITR'  "
					  + "left join   my_girm  GIR on GIR.tr_no=pin.tr_no and pin.dtype='GIR' "+sqljoin+" where 1=1  and "
					  + "  cast(pin.date as date)>='"+frmdate+"' and cast(pin.date as date)<='"+todate+"'  "+insql+" "+wheresql+"  "
					  + "group by pin.stockid order by pin.stockid) ins  "
					  + "left join my_head h on(h.doc_no=ins.acno)  "
					  + " union all  "
					 + " select outs.minus ,'out' valtype, outs.tr_no,outs.psrno, outs.date,ac.refname description,outs.Stockid,outs.dtype,outs.docno,  "
					 + " outs.acno,' ' inqty,' ' inval,outs.issqty isqty,outs.issqty*outs.issuecostprice isval ,  "
					  + "' 'balqty,' ' balcost, outs.issuecostprice cpu  "
					  + "from (select case when pout.dtype='INV' then if(pout.rsv_qty<0,pout.rsv_qty,pout.del_qty) else 0 end as minus,pout.tr_no,pout.psrno,pout.Stockid,pout.dtype,cast(pout.date as date) date,  "
					  + "case when pout.dtype='GRR' then GRR.voc_no   when pout.dtype='PIR' then PIR.voc_no  "
					  + "	when pout.dtype='SOR' then SOR.voc_no  when pout.dtype='JOR' then JOR.voc_no  when  pout.dtype='PHK' then PHK.voc_no  "
					  + "	when  pout.dtype='DEL' then DEL.voc_no when  pout.dtype='INC' then INV.voc_no   when  pout.dtype='INV' then INV.voc_no  when  pout.dtype='ITI' then ITI.voc_no  "
					  + "	when  pout.dtype='GIS' then GIS.voc_no  "
					  + "	else ''  end as DOCNO,   case when pout.dtype='GRR' then GRR.cldocno   when pout.dtype='PIR' then PIR.cldocno    when pout.dtype='SOR'  "
					  + " then SOR.cldocno  when pout.dtype='JOR' then JOR.cldocno    when  pout.dtype='DEL'  then DEL.cldocno   when  pout.dtype='INV' then INV.cldocno  "
					  + " 	when  pout.dtype='GIS' then GIS.cldocno  	else ''  end as cldocno , "
					  + "	case when pout.dtype='GRR' then GRR.acno   when pout.dtype='PIR' then PIR.acno  "
					 + "    when pout.dtype='SOR' then SOR.acno  "
					 + "    when  pout.dtype='DEL' then DEL.acno when  pout.dtype='INC' then INV.acno   when  pout.dtype='INV' then INV.acno  when  pout.dtype='ITI' then ITI.acno  "
					 + "	when  pout.dtype='GIS' then GIS.acno  "
					 + "	else ''  end as acno, case when  pout.dtype='DEL' then  "
					 + "	de.del_qty  "
					 + "	when  pout.dtype='SOR' ||  pout.dtype='JOR' then  "
					 + "	 rs.rsv_qty  "
					 + "	else pout.qty end as issqty, p.cost_price issuecostprice  "
					 + "	from my_prddout pout left join  my_prddin p     on pout.stockid=p.stockid   "
					 + " left join (select rsv_qty,stockid,doc_no from my_prddout group by stockid,doc_no) rs on rs.Stockid=pout.stockid and rs.doc_no=pout.doc_no "
					 + " left join (select del_qty,stockid,doc_no from my_prddout group by stockid,doc_no) de on de.Stockid=pout.stockid and de.doc_no=pout.doc_no "
					 + "	left join my_grrm GRR on GRR.tr_no=pout.tr_no and pout.dtype='GRR'  "
					 + "	left join my_srrm PIR on PIR.tr_no=pout.tr_no and pout.dtype='PIR'  "
					 + "	left join my_sorderm SOR on SOR.tr_no=pout.tr_no and pout.dtype='SOR'  "
					 + "	left join   my_joborderm  JOR on JOR.tr_no=pout.tr_no and pout.dtype='JOR'  "
					 + "	left join   my_delm  DEL on DEL.tr_no=pout.tr_no and pout.dtype='DEL'  "
					 + "	left join   my_invm  INV on INV.tr_no=pout.tr_no and pout.dtype in ('INV','INC')  left join   my_phkm  PHK on PHK.tr_no=pout.tr_no and pout.dtype='PHK'  "
					 + "	left join   my_invtranissuem ITI on ITI.tr_no=pout.tr_no and pout.dtype='ITI'  "
					 + "    left join   my_gism  GIS on GIS.tr_no=pout.tr_no and GIS.dtype='GIS'  "+sqljoin1+" "
					 + "	where 1=1 and cast(pout.date as date)>='"+frmdate+"' and cast(pout.date as date)<='"+todate+"'   "+outsql+"  "+wheresql+"   order by stockid,pout.doc_no) outs  "
					 + "    left join my_head h on(h.doc_no=outs.acno)     left join my_acbook ac on ((ac.doc_no=outs.cldocno and ac.dtype='CRM' and outs.dtype!='PIR') or ((ac.doc_no=outs.cldocno and ac.dtype='VND' and outs.dtype='PIR')) ) ) res order by res.stockid,res.tr_no  ";

					  ;
			
		 //	System.out.println("==stockLedgerDetail==="+sql);

			ArrayList<String> stldarray= new ArrayList<String>();
			ResultSet rs = stmt.executeQuery(sql);

			
			
			String valtype="";
			
			String	psrno="";
			String	trtype="";
			String	docno="";
			String	date="";
			String	trans_type="";
			String	desc1="";
			
    String totalqty1="",issueqty1="",balqty1="",remqty1 ="";
			
			String  cpu1="",inval1="",isval1="",totbalval1="";
			
			
			double totalqty=0,issueqty=0,balqty=0,remqty = 0;
			
			double cpu=0,inval=0,isval=0,totbalval=0;
int i=0;
int j=0;
int k=0;

int minus=0;
			while(rs.next()){
				
				valtype=rs.getString("valtype");
				if(valtype.equalsIgnoreCase("in"))
				{
					totalqty=rs.getDouble("inqty");
					remqty=totalqty;
					issueqty=0;
					i=i+1;
					j=0;
				}
				else if(valtype.equalsIgnoreCase("out"))
				{
					totalqty=0;
					issueqty=rs.getDouble("isqty");
					
					minus=rs.getInt("minus");
		//			System.out.println("======minus======"+minus);
					
					if(minus>=0)
					{
					remqty=remqty-issueqty;
					}
					j=j+1;
				}
				
				balqty=remqty;
			
			
			
		 	psrno=rs.getString("psrno");
		 	trtype=valtype;
		 	docno=rs.getString("docno");
		 	date=rs.getString("date");
		 	trans_type=rs.getString("dtype");
		 	desc1=rs.getString("description");
		 	
	
		 	cpu=rs.getDouble("cpu");
		 	
		 	if(totalqty>0)
		 	{
		 		inval=totalqty*cpu;
		 		totalqty1=totalqty+"";
		 		inval1=inval+"";
		 		cpu1=cpu+"";
		 	}
		 	else
		 	{
		 		cpu1="";
		 		totalqty1="";
		 		inval1="";
		 	}
		 	if(issueqty>0)
		 	{
		 	isval=issueqty*cpu;
		 	issueqty1=issueqty+"";
		 	isval1=isval+"";
		 	}
		 	else
		 	{
		 		
		 	 	 if(valtype.equalsIgnoreCase("out"))
					{
			 		 
		 	 		issueqty1="0";
				 	isval1="0";
					}
		 	 	 else
		 	 	 {
		 		issueqty1="";
			 	isval1="";
		 	 	 }
		 		
		 	}
		 	if(balqty>=0 && minus>=0)
		 	{
		 	totbalval=balqty*cpu;
		 	balqty1=balqty+"";
		 	totbalval1=totbalval+"";
		 	}
		 	else
		 	{
		 		
		 	 	balqty1="";
			 	totbalval1="";	
		 	}
		 	
		 	
		 	if(valtype.equalsIgnoreCase("in"))
			{
		 	  k=i;
			}
		 	else if(valtype.equalsIgnoreCase("out"))
			{
		 		  k=j;
			}
		 
			stldarray.add(date+"::"+docno+"::"+trans_type+"::"+totalqty1+"::"+inval1+"::"+issueqty1+"::"+isval1+"::"+balqty1+"::"+totbalval1+"::"+trtype+"::"+cpu1+"::"+desc1+"::"+k+"::"+psrno);
			
			}
		 	
		//	System.out.println("==============="+stldarray);


			/*String psrno="0",prvpsrno="0",pno="",pname="",docno="",trans_type="",trtype="",date="",desc1="";
			double inqty=0.00,inval=0.00,isqty=0.00,isval=0.00,balqty=0.00,balval=0.00,totinqty=0.0,totinval=0.0,totisqty=0.0,totisval=0.0,totbalqty=0.0,totbalval=0.0,cpu=0.0;
			int i=0;
			int k=1;
			while(rs.next()){
				psrno=rs.getString("psrno");
				trtype=rs.getString("trtype");
				docno=rs.getString("docno");
				date=rs.getString("date");
				trans_type=rs.getString("trans_type");
				desc1=rs.getString("desc1");
				if(!(prvpsrno.equalsIgnoreCase(psrno))){
					k=1;
					if(i!=0){
						cpu=totbalval/totbalqty;
					stldarray.add(""+"::"+pno+"::"+""+"::"+totinqty+"::"+totinval+"::"+totisqty+"::"+totisval+"::"+totbalqty+"::"+totbalval+"::0"+"::"+cpu+"::"+pname+"::"+""+"::"+psrno);
					}
					inqty=0.00;inval=0.00;isqty=0.00;isval=0.00;balqty=0.00;balval=0.00;totinqty=0.0;totinval=0.0;totisqty=0.0;totisval=0.0;totbalqty=0.0;totbalval=0.0;
					pno=rs.getString("pno");
					pname=rs.getString("pname");
					psrno=rs.getString("psrno");
					trtype=rs.getString("trtype");
					docno=rs.getString("docno");
					date=rs.getString("date");
					trans_type=rs.getString("trans_type");
					desc1=rs.getString("desc1");
				}
				
				inqty=Double.parseDouble(rs.getString("inqty"));inval=Double.parseDouble(rs.getString("inval"));
				isqty=Double.parseDouble(rs.getString("isqty"));isval=Double.parseDouble(rs.getString("isval"));
				balqty=Double.parseDouble(rs.getString("balqty"));balval=Double.parseDouble(rs.getString("balval"));
				totinqty=totinqty+inqty;
				totisqty=totisqty+isqty;
				totinval=totinval+inval;
				totisval=totisval+isval;
				totbalqty=totbalqty+balqty;
				totbalval=totbalval+balval;
				if(trtype.equalsIgnoreCase("2")){
					balqty=totinqty-totisqty;
					balval=totinval-totisval;
							
				}
				
				prvpsrno=psrno;
				
				stldarray.add(date+"::"+docno+"::"+trans_type+"::"+inqty+"::"+inval+"::"+isqty+"::"+isval+"::"+totbalqty+"::"+totbalval+"::"+trtype+"::"+" "+"::"+desc1+"::"+k+"::"+psrno);
				
				i++;
				k++;
	
			}
			cpu=totbalval/totbalqty;
			stldarray.add(""+"::"+pno+"::"+""+"::"+totinqty+"::"+totinval+"::"+totisqty+"::"+totisval+"::"+totbalqty+"::"+totbalval+"::0"+"::"+cpu+"::"+pname+"::"+""+"::"+psrno);
			//stldarray.add(""+"::"+pno+"::"+""+"::"+totinqty+"::"+totinval+"::"+totisqty+"::"+totisval+"::"+totbalqty+"::"+totbalval+"::0"+"::"+pname+"::"+"");
			*/
			RESULTDATA=convertArrayToJSON1(stldarray);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	public static JSONArray convertArrayToJSON1(ArrayList<String> arrayList) throws Exception {
		JSONArray jsonArray = new JSONArray();

		for (int i = 0; i < arrayList.size(); i++) {

			JSONObject obj = new JSONObject();

			String[] stldarray=arrayList.get(i).split("::");

			 
			
			obj.put("DATE",stldarray[0]);
			 
			obj.put("TYPE",stldarray[2]);
			obj.put("DOCNO",stldarray[1]);
			obj.put("CLIENT/VENDOR",stldarray[11]);
			obj.put("IN QUANTITY",stldarray[3]);
			obj.put("IN VALUE",stldarray[4]);
			obj.put("ISSUED  QUANTITY",stldarray[5]);
			obj.put("ISSUED  VALUE",stldarray[6]);
			obj.put("BALANCE  QUANTITY",stldarray[7]);
			obj.put(" BALANCE VALUE",stldarray[8]);
	 
			obj.put("COST PER UNIT", stldarray[10]);
		 
			

			jsonArray.add(obj);
		}
		return jsonArray;
	}

	
	public static JSONArray convertArrayToJSON(ArrayList<String> arrayList) throws Exception {
		JSONArray jsonArray = new JSONArray();

		for (int i = 0; i < arrayList.size(); i++) {

			JSONObject obj = new JSONObject();

			String[] stldarray=arrayList.get(i).split("::");

			 
			
			obj.put("date",stldarray[0]);
			obj.put("docno",stldarray[1]);
			obj.put("trans_type",stldarray[2]);
			obj.put("inqty",stldarray[3]);
			obj.put("inval",stldarray[4]);
			obj.put("isqty",stldarray[5]);
			obj.put("isval",stldarray[6]);
			obj.put("balqty",stldarray[7]);
			obj.put("balval",stldarray[8]);
			obj.put("trtype",stldarray[9]);
			obj.put("cpu", stldarray[10]);
			obj.put("desc1",stldarray[11]);
			obj.put("sl",stldarray[12]);
			obj.put("psrno",stldarray[13]);
			

			jsonArray.add(obj);
		}
		return jsonArray;
	}


}
