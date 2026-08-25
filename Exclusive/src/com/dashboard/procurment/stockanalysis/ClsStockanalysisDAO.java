package com.dashboard.procurment.stockanalysis;


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

 
public class ClsStockanalysisDAO {
 

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
			System.out.println("===modelSearch===="+sql);
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
			System.out.println("===subModelSearch===="+sql);
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

	public JSONArray locationSearch(HttpSession session,String brhdid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			
			String sqls="";
			
			if(!(brhdid.equalsIgnoreCase("0") || brhdid.equalsIgnoreCase("") || brhdid.equalsIgnoreCase("a"))){
				sqls="and b.doc_no in ("+brhdid+")";
			}
			

			String sql = "select l.loc_name locname,l.doc_no,b.branchname from "
					+ " my_locm l left join my_brch b on b.doc_no=l.brhid where l.status=3 "+sqls+" ";

			
			
			System.out.println("====sql====="+sql);
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

			System.out.println("==sql=type1==="+sql);

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
			String hidsubcat,String hidproduct,String branchid,String hidept,String load,String prodgroupby,String hidlocid) throws SQLException {


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

			String sqlfrm="",sqlto="",sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="",sql10="",sql11="",sql12="",sql13="",sql14="",sqlfinal="";

			String insqls1="";
			String insqls2="";
			java.sql.Date frmdate=ClsCommon.changeStringtoSqlDate(fromDate);

			java.sql.Date todate=ClsCommon.changeStringtoSqlDate(toDate);
String  sql71="";
			if(!(hidbrand.equalsIgnoreCase("0") || hidbrand.equalsIgnoreCase("") || hidbrand.equalsIgnoreCase("undefined"))){
				sql7=" and bd.doc_no in ("+hidbrand+")";
				sql71=" and stks.brandid in ("+hidbrand+")";
				
				
			}

			String  sql81="";
			
			if(!(hidtype.equalsIgnoreCase("0") || hidtype.equalsIgnoreCase("") || hidtype.equalsIgnoreCase("undefined"))){
				sql8=" and pt.doc_no in ("+hidtype+")";
				sql81 =" and stks.typeid in ("+hidtype+")";
			}
			String sql131="";
			if(!(hidept.equalsIgnoreCase("0") || hidept.equalsIgnoreCase("") || hidept.equalsIgnoreCase("undefined"))){
				sql13=" and dep.doc_no in ("+hidept+")";
				
				sql131=" and stks.deptid in ("+hidept+")";
				
			}
			
        String sql91="";
			if(!(hidcat.equalsIgnoreCase("0") || hidcat.equalsIgnoreCase("") || hidcat.equalsIgnoreCase("undefined"))){
				sql9=" and cat.doc_no in ("+hidcat+") ";
				
				sql91= "   and stks.catid in ("+hidcat+")";
				
			}
			
			String  sql101="";
			if(!(hidsubcat.equalsIgnoreCase("0") || hidsubcat.equalsIgnoreCase("") || hidsubcat.equalsIgnoreCase("undefined"))){
				sql10=" and sc.doc_no in ("+hidsubcat+")";
				
				sql101=" and stks.scatid in ("+hidsubcat+")";
			}
 
			System.out.println("===============hidproduct=============="+hidproduct);
			
			
			if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
				sql11=" and m.doc_no in ("+hidproduct+")";
				
				 
				
			}
			
			
		 
			String opsql="";    	 
			
			String sksql="";   
			String pinsql="";   
			
			
			String opselect="";
			
			
			
			String locsql1="";
			String locsql2="";
			
			if(!(hidlocid.equalsIgnoreCase("0") || hidlocid.equalsIgnoreCase("") || hidlocid.equalsIgnoreCase("undefined"))){
				sql14=" and stks.locid in ("+hidlocid+")";
				
				locsql2="and pin.locid in ("+hidlocid+")  ";
				
                locsql1= " and locid in ("+hidlocid+") ";
				
				
			}  
			
			
			 if(!(branchid.equalsIgnoreCase("0") || branchid.equalsIgnoreCase("") || branchid.equalsIgnoreCase("undefined")|| branchid.equalsIgnoreCase("a"))){
		         sql12="and stks.brhid="+branchid+"  ";
				
				insqls2="and pin.brhid="+branchid+"  ";
				
				insqls1= " and brhid="+branchid+" ";
				
				
			} 
			
			sqlfinal=sql1+sql2+sql3+sql4+sql5+sql6+sql7+sql8+sql9+sql10+sql11+sql12+sql13+sql14;
			sqljoin =  "left join my_ptype pt on(m.typeid=pt.doc_no) "
					+ "left join my_brand bd on(m.brandid=bd.doc_no) "
					+ "left join my_dept dep on(dep.doc_no=m.deptid) "
					+ "left join my_catm cat on(m.catid=cat.doc_no)"
					+ "left join my_scatm sc on(m.scatid=sc.doc_no)";
				int method=0;
			
			String sqlsss="select method from gl_prdconfig where field_nme='stockanalysis';";
					ResultSet rd=stmt.executeQuery(sqlsss);
			if(rd.first())
			{
				method=rd.getInt("method");
			}
			
			String sqlss="";
			String sqls2="";
			
			if(method==1)
			{
				sqlss="a.cost_price";
				
				sqls2= "(op_qty*cost_price)-coalesce(cost,0) ";
				
			}
			else
			{
				sqlss="a.outqty*p.cost_price";
				sqls2= " ((op_qty)-(coalesce(a.outqty,0)))*p.cost_price ";
				
			}
			
			
			if(prodgroupby.equalsIgnoreCase("gloca"))
					{
/*	 
				
				sql="	select l.doc_no pno,l.loc_name  pname,stks.* from ( select pin.locid, pin.brhid,pin.psrno,coalesce(ops.opqty,0) opnqty, "
						+ " coalesce(ops.cost_price,0) opnval "
						+ ",stk.stkqty inqty ,stk.stcost_price inval ,stk.issueqty isqty,stk.isscost isval, "
						+ " (coalesce(stk.stkqty,0)-coalesce(stk.issueqty,0))+coalesce(ops.opqty,0) balqty , "
						+ "  (coalesce(stk.stcost_price,0)-coalesce(stk.isscost,0))+coalesce(ops.cost_price,0) stv,pin.cost_price  cpu1 , "
						+ " (((coalesce(stk.stcost_price,0)-coalesce(stk.isscost,0))+coalesce(ops.cost_price,0))/((coalesce(stk.stkqty,0)-coalesce(stk.issueqty,0))+coalesce(ops.opqty,0))) cpu  "
						+ "  from my_prddin pin  left join my_main m on  m.psrno=pin.psrno left join "
						+ " (select sum(op.opqty) opqty,sum(op.cost_price)  cost_price,op.Stockid,op.prdid,locid from( "
						+ "select locid,date,(op_qty)-(out_qty+rsv_qty+del_qty) opqty ,((op_qty)-(out_qty+rsv_qty+del_qty))*cost_price "
						 + "cost_price,Stockid,prdid from my_prddin where  cast(date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by Stockid "
						+ " ) op group by op.locid) ops on ops.locid=pin.locid left join (select locid, sum(st.stkqty) stkqty,sum(st.stcost_price)  stcost_price,sum(st.issueqty) issueqty, "
						 + " sum(st.isscost) isscost , st.Stockid,st.prdid from(select locid, date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
						 + " (out_qty+rsv_qty+del_qty) issueqty,(out_qty+rsv_qty+del_qty)*cost_price isscost, Stockid,prdid from my_prddin where "
						+ "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  "+locsql1+" group by Stockid "
						+ "  ) st group by st.locid) stk on stk.locid=pin.locid where  1=1  "+insqls2+" "+locsql2+"  group by pin.locid) stks "
	                   + "	inner  join my_locm l on(stks.locid=l.doc_no)    where 1=1 "
	                   + " and (opnqty!=0 or opnval!=0 or inqty!=0 or inval!=0 or isqty!=0 or isval!=0 or balqty!=0 or stv!=0)   "+sql14+" " ; 
					*/		
	 
				
				sql="	select l.doc_no pno,l.loc_name  pname,stks.* from ( select pin.locid, pin.brhid,pin.psrno,coalesce(ops.opqty,0) opnqty, "
						+ "coalesce(ops.cost_price,0) opnval "
						+ ",stk.stkqty inqty ,stk.stcost_price inval ,iss.issueqty isqty,iss.isscost isval, "
						+ " (coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0) balqty , "
						+ "  (coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0) stv,pin.cost_price  cpu1 , "
						+ " (((coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0))/"
						+ " ((coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0))) cpu  "
						+ "  from my_prddin pin  left join my_main m on  m.psrno=pin.psrno left join "
						+ " (select sum(op.opqty) opqty,sum(op.cost_price)  cost_price,op.Stockid,op.prdid,locid from( "
						+ "select p.locid,p.date,(p.op_qty)-(coalesce(a.outqty,0)) opqty ,"+sqls2+"   "
						 + "cost_price,p.Stockid,p.prdid from my_prddin  p  "
						 + "left join (select sum(qty) outqty,stockid,sum(qty*cost_price) cost from my_prddout where"
							 + "    cast(date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by stockid) a on a.stockid=p.stockid "
							 		+ " where  cast(p.date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by p.Stockid "
						+ " ) op group by op.locid) ops on ops.locid=pin.locid left join (select locid, sum(st.stkqty) stkqty,sum(st.stcost_price)  stcost_price, "
						+ " st.Stockid,st.prdid from(select locid, date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
						 + "  Stockid,prdid from my_prddin where "
						+ "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  "+locsql1+" group by Stockid "
						+ "  ) st group by st.locid) stk on stk.locid=pin.locid"
						+ " left join (select sum(coalesce(a.outqty,0)) issueqty,sum(coalesce(outcost,0)) isscost,prdid,locid from "
						+ "   (select a.outqty ,"+sqlss+" outcost, a.prdid,a.locid from "
						+ "	(select sum(qty) outqty,stockid,prdid,locid,sum(qty*cost_price) cost_price from my_prddout where "
						+ "	cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"'  "+insqls1+"  "+locsql1+"  group by stockid) a "
						+ "		left join my_prddin p on a.stockid=p.stockid )  a where 1=1 group by a.locid ) iss on iss.locid=pin.locid "
						+ " where  1=1  "+insqls2+" "+locsql2+"  group by pin.locid) stks "
	                   + "	inner  join my_locm l on(stks.locid=l.doc_no)    where 1=1 "
	                   + " and (opnqty!=0 or opnval!=0 or inqty!=0 or inval!=0 or isqty!=0 or isval!=0 or balqty!=0 or stv!=0)   "+sql14+" " ; 
					
	/*			      ( "
						+ "select p.date,(p.op_qty)-(a.outqty) opqty ,((op_qty)-(a.outqty))*p.cost_price "
						 + " cost_price,p.Stockid,p.prdid from my_prddin  p	left join (select sum(qty) outqty,stockid from my_prddout where"
						 + "    cast(date as date)<'"+frmdate+"' "+insqls1+" group by stockid) a on a.stockid=p.stockid  "
						 + " where  cast(date as date)<'"+frmdate+"' "+insqls1+"  group by p.Stockid "
						+ " ) op group by op.prdid)
*/				
					}
			

			else if(prodgroupby.equalsIgnoreCase("gptype"))
			{
 
				
				sql="	select t.doc_no pno,t.producttype  pname,stks.* from ( select m.typeid, pin.brhid,pin.psrno,coalesce(ops.opqty,0) opnqty ,"
						+ "coalesce(ops.cost_price,0) opnval "
						+ ",stk.stkqty inqty ,stk.stcost_price inval ,iss.issueqty isqty,iss.isscost isval, "
						+ " (coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0) balqty , "
						+ "  (coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0) stv,pin.cost_price  cpu1 , "
						+ " (((coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0))/"
						+ " ((coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0))) cpu  "
						+ "  from my_prddin pin  inner join my_main m on  m.psrno=pin.psrno left join "
						+ " (select m.typeid,sum(op.opqty) opqty,sum(op.cost_price)  cost_price,op.Stockid,op.prdid from( "
						+ "select p.date,(p.op_qty)-(coalesce(a.outqty,0)) opqty ,"+sqls2+"  "
						 + "cost_price,p.Stockid,p.prdid from my_prddin  p  "
						 + "left join (select sum(qty) outqty,stockid,sum(qty*cost_price) cost from my_prddout where"
							 + "    cast(date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by stockid) a on a.stockid=p.stockid "  
							+ " where  cast(p.date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by p.Stockid "
						+ " ) op left join my_main m on m.psrno=op.prdid   group by m.typeid) ops on ops.typeid=m.typeid"
						+ "  left join (select m.typeid,sum(st.stkqty) stkqty,sum(st.stcost_price)  stcost_price ,st.Stockid,st.prdid from(select  date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
						 + "  Stockid,prdid from my_prddin where "
						+ "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  "+locsql1+" group by Stockid "
						+ "  ) st  left join my_main m on m.psrno=st.prdid   group by m.typeid) stk on stk.typeid=m.typeid "
						+ " left join (select typeid,sum(coalesce(a.outqty,0)) issueqty,sum(coalesce(outcost,0)) isscost,prdid,brhid from"
						+ "   (select a.outqty ,"+sqlss+" outcost, a.prdid,a.brhid from "
						+ "	(select sum(qty) outqty,stockid,prdid,brhid,sum(qty*cost_price) cost_price from my_prddout where "
						+ "	cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  "+locsql1+"  group by stockid) a "
						+ "		left join my_prddin p on a.stockid=p.stockid )  a left join my_main m on m.psrno=a.prdid   group by m.typeid) iss on iss.typeid=m.typeid "
						+ "where  1=1  "+insqls2+" "+locsql2+" "
								+ "   group by m.typeid) stks "
	                   + "	inner  join my_ptype t on(stks.typeid=t.doc_no)   where 1=1"
	                   		+ " and (opnqty!=0 or opnval!=0 or inqty!=0 or inval!=0 or isqty!=0 or isval!=0 or balqty!=0 or stv!=0)   "+sql81+" " ; 
				
				
			}
			else if(prodgroupby.equalsIgnoreCase("gpbrand"))
					{
						
	 
			
				
				
				sql="	select b.doc_no pno,b.brandname  pname,stks.* from ( select m.brandid, pin.brhid,pin.psrno,coalesce(ops.opqty,0) opnqty,"
						+ "coalesce(ops.cost_price,0) opnval "
						+ ",stk.stkqty inqty ,stk.stcost_price inval ,iss.issueqty isqty,iss.isscost isval, "
						+ " (coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0) balqty , "
						+ "  (coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0) stv,pin.cost_price  cpu1 , "
						+ " (((coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0))/"
						+ " ((coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0))) cpu  "
						+ "  from my_prddin pin  inner join my_main m on  m.psrno=pin.psrno left join "
						+ " (select m.brandid,sum(op.opqty) opqty,sum(op.cost_price)  cost_price,op.Stockid,op.prdid from( "
						+ "select p.date,(p.op_qty)-(coalesce(a.outqty,0)) opqty ,"+sqls2+"   "
						 + "cost_price,p.Stockid,p.prdid from my_prddin  p  "
						 + "left join (select sum(qty) outqty,stockid,sum(qty*cost_price) cost  from my_prddout where"
							 + "    cast(date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by stockid) a on a.stockid=p.stockid "  
							+ " where  cast(p.date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by p.Stockid "
						+ " ) op left join my_main m on m.psrno=op.prdid   group by m.brandid) ops on ops.brandid=m.brandid"
						+ "  left join (select m.brandid,sum(st.stkqty) stkqty,sum(st.stcost_price)  stcost_price ,st.Stockid,st.prdid from(select  date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
						 + "  Stockid,prdid from my_prddin where "
						+ "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  "+locsql1+" group by Stockid "
						+ "  ) st  left join my_main m on m.psrno=st.prdid   group by m.brandid) stk on stk.brandid=m.brandid "
						+ " left join (select brandid,sum(coalesce(a.outqty,0)) issueqty,sum(coalesce(outcost,0)) isscost,prdid,brhid from"
						+ "   (select a.outqty ,"+sqlss+" outcost, a.prdid,a.brhid from "
						+ "	(select sum(qty) outqty,stockid,prdid,brhid,sum(qty*cost_price) cost_price from my_prddout where "
						+ "	cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  "+locsql1+"  group by stockid) a "
						+ "		left join my_prddin p on a.stockid=p.stockid )  a left join my_main m on m.psrno=a.prdid   group by m.brandid) iss on iss.brandid=m.brandid "
						+ "where  1=1  "+insqls2+" "+locsql2+" "
								+ "   group by m.brandid) stks "
	                   + "	inner  join my_brand b on(stks.brandid=b.doc_no)   where 1=1"
	                   		+ " and (opnqty!=0 or opnval!=0 or inqty!=0 or inval!=0 or isqty!=0 or isval!=0 or balqty!=0 or stv!=0)   "+sql71+" " ; 
				
				
				
				
				
					}
			
			
			else if(prodgroupby.equalsIgnoreCase("gpdept"))
			{ 
				
				
		

				sql="	select d.doc_no pno,d.department  pname,stks.* from ( select m.deptid, pin.brhid,pin.psrno,coalesce(ops.opqty,0) opnqty,"
						+ "coalesce(ops.cost_price,0) opnval "
						+ ",stk.stkqty inqty ,stk.stcost_price inval ,iss.issueqty isqty,iss.isscost isval, "
						+ " (coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0) balqty , "
						+ "  (coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0) stv,pin.cost_price  cpu1 , "
						+ " (((coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0))/"
						+ " ((coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0))) cpu  "
						+ "  from my_prddin pin  inner join my_main m on  m.psrno=pin.psrno left join "
						+ " (select m.deptid,sum(op.opqty) opqty,sum(op.cost_price)  cost_price,op.Stockid,op.prdid from( "
						+ "select p.date,(p.op_qty)-(coalesce(a.outqty,0)) opqty ,"+sqls2+"   "
						 + "cost_price,p.Stockid,p.prdid from my_prddin  p  "
						 + "left join (select sum(qty) outqty,stockid,sum(qty*cost_price) cost  from my_prddout where"
							 + "    cast(date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by stockid) a on a.stockid=p.stockid "  
							+ " where  cast(p.date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by p.Stockid "
						+ " ) op left join my_main m on m.psrno=op.prdid   group by m.deptid) ops on ops.deptid=m.deptid"
						+ "  left join (select m.deptid,sum(st.stkqty) stkqty,sum(st.stcost_price)  stcost_price ,st.Stockid,st.prdid from(select  date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
						 + "  Stockid,prdid from my_prddin where "
						+ "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  "+locsql1+" group by Stockid "
						+ "  ) st  left join my_main m on m.psrno=st.prdid   group by m.deptid) stk on stk.deptid=m.deptid "
						+ " left join (select deptid,sum(coalesce(a.outqty,0)) issueqty,sum(coalesce(outcost,0)) isscost,prdid,brhid from"
						+ "   (select a.outqty ,"+sqlss+" outcost, a.prdid,a.brhid from "
						+ "	(select sum(qty) outqty,stockid,prdid,brhid,sum(qty*cost_price) cost_price from my_prddout where "
						+ "	cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  "+locsql1+"  group by stockid) a "
						+ "		left join my_prddin p on a.stockid=p.stockid )  a left join my_main m on m.psrno=a.prdid   group by m.deptid) iss on iss.deptid=m.deptid "
						+ "where  1=1  "+insqls2+" "+locsql2+" "
								+ "   group by m.deptid) stks "
	                   + "	inner  join my_dept d on(stks.deptid=d.doc_no)   where 1=1"
	                   		+ " and (opnqty!=0 or opnval!=0 or inqty!=0 or inval!=0 or isqty!=0 or isval!=0 or balqty!=0 or stv!=0)   "+sql131+" " ; 
				
				
				
				
			}
			else if(prodgroupby.equalsIgnoreCase("gpcategory"))
					{
 
				
		
				
				sql="	select c.doc_no pno,c.category  pname,stks.* from ( select m.catid, pin.brhid,pin.psrno,coalesce(ops.opqty,0) opnqty, "
						+ "coalesce(ops.cost_price,0) opnval "
						+ ",stk.stkqty inqty ,stk.stcost_price inval ,iss.issueqty isqty,iss.isscost isval, "
						+ " (coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0) balqty , "
						+ "  (coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0) stv,pin.cost_price  cpu1 , "
						+ " (((coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0))/"
						+ " ((coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0))) cpu  "
						+ "  from my_prddin pin  inner join my_main m on  m.psrno=pin.psrno left join "
						+ " (select m.catid,sum(op.opqty) opqty,sum(op.cost_price)  cost_price,op.Stockid,op.prdid from( "
						+ "select p.date,(p.op_qty)-(coalesce(a.outqty,0)) opqty ,"+sqls2+"   "
						 + "cost_price,p.Stockid,p.prdid from my_prddin  p  "
						 + "left join (select sum(qty) outqty,stockid,sum(qty*cost_price) cost from my_prddout where"
							 + "    cast(date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by stockid) a on a.stockid=p.stockid "  
							+ " where  cast(p.date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by p.Stockid "
						+ " ) op left join my_main m on m.psrno=op.prdid   group by m.catid) ops on ops.catid=m.catid"
						+ "  left join (select m.catid,sum(st.stkqty) stkqty,sum(st.stcost_price)  stcost_price ,st.Stockid,st.prdid from(select  date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
						 + "  Stockid,prdid from my_prddin where "
						+ "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  "+locsql1+" group by Stockid "
						+ "  ) st  left join my_main m on m.psrno=st.prdid   group by m.catid) stk on stk.catid=m.catid "
						+ " left join (select catid,sum(coalesce(a.outqty,0)) issueqty,sum(coalesce(outcost,0)) isscost,prdid,brhid from"
						+ "   (select a.outqty ,"+sqlss+" outcost, a.prdid,a.brhid from "
						+ "	(select sum(qty) outqty,stockid,prdid,brhid,sum(qty*cost_price) cost_price from my_prddout where "
						+ "	cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  "+locsql1+"  group by stockid) a "
						+ "		left join my_prddin p on a.stockid=p.stockid )  a left join my_main m on m.psrno=a.prdid   group by m.catid) iss on iss.catid=m.catid "
						+ "where  1=1  "+insqls2+" "+locsql2+" "
								+ "   group by m.catid) stks "
	                   + "	inner  join my_catm c on(stks.catid=c.doc_no)   where 1=1"
	                   		+ " and (opnqty!=0 or opnval!=0 or inqty!=0 or inval!=0 or isqty!=0 or isval!=0 or balqty!=0 or stv!=0)   "+sql91+" " ; 
				
				 
						
					}
			else if(prodgroupby.equalsIgnoreCase("gpsubcategory"))
					{
						
				
				
				sql="	select sc.doc_no pno,sc.subcategory  pname,stks.* from ( select m.scatid, pin.brhid,pin.psrno,coalesce(ops.opqty,0) opnqty, "
						+ "coalesce(ops.cost_price,0) opnval "
						+ ",stk.stkqty inqty ,stk.stcost_price inval ,iss.issueqty isqty,iss.isscost isval, "
						+ " (coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0) balqty , "
						+ "  (coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0) stv,pin.cost_price  cpu1 , "
						+ " (((coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0))/"
						+ " ((coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0))) cpu  "
						+ "  from my_prddin pin  inner join my_main m on  m.psrno=pin.psrno left join "
						+ " (select m.scatid,sum(op.opqty) opqty,sum(op.cost_price)  cost_price,op.Stockid,op.prdid from( "
						+ "select p.date,(p.op_qty)-(coalesce(a.outqty,0)) opqty ,"+sqls2+"   "
						 + "cost_price,p.Stockid,p.prdid from my_prddin  p  "
						 + "left join (select sum(qty) outqty,stockid,sum(qty*cost_price) cost  from my_prddout where"
							 + "    cast(date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by stockid) a on a.stockid=p.stockid "  
							+ " where  cast(p.date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by p.Stockid "
						+ " ) op left join my_main m on m.psrno=op.prdid   group by m.scatid) ops on ops.scatid=m.scatid"
						+ "  left join (select m.scatid,sum(st.stkqty) stkqty,sum(st.stcost_price)  stcost_price ,st.Stockid,st.prdid "
						+ " from(select  date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
						 + "  Stockid,prdid from my_prddin where "
						+ "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  "+locsql1+" group by Stockid "
						+ "  ) st  left join my_main m on m.psrno=st.prdid   group by m.scatid) stk on stk.scatid=m.scatid "
						+ " left join (select scatid,sum(coalesce(a.outqty,0)) issueqty,sum(coalesce(outcost,0)) isscost,prdid,brhid from"
						+ "   (select a.outqty ,"+sqlss+" outcost, a.prdid,a.brhid from "
						+ "	(select sum(qty) outqty,stockid,prdid,brhid,sum(qty*cost_price) cost_price from my_prddout where "
						+ "	cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  "+locsql1+"  group by stockid) a "
						+ "		left join my_prddin p on a.stockid=p.stockid )  a left join my_main m on m.psrno=a.prdid   group by m.scatid) iss on iss.scatid=m.scatid "
						+ "where  1=1  "+insqls2+" "+locsql2+" "
								+ "   group by m.scatid) stks "
	                   + "	inner  join my_scatm sc on(stks.scatid=sc.doc_no)   where 1=1 "
	                   		+ " and (opnqty!=0 or opnval!=0 or inqty!=0 or inval!=0 or isqty!=0 or isval!=0 or balqty!=0 or stv!=0)   "+sql101+" " ; 
				
				 
				
					}
			else if(prodgroupby.equalsIgnoreCase("gbranch"))
			{
				
				
				
				sql="	select br.doc_no pno,br.branchname  pname,stks.* from ( select pin.brhid,pin.psrno,coalesce(ops.opqty,0) opnqty, "
						+ "coalesce(ops.cost_price,0) opnval "
						+ ",stk.stkqty inqty ,stk.stcost_price inval ,iss.issueqty isqty,iss.isscost isval, "
						+ " (coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0) balqty , "
						+ "  (coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0) stv,pin.cost_price  cpu1 , "
						+ " (((coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0))/"
						+ " ((coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0))) cpu  "
						+ "  from my_prddin pin  left join my_main m on  m.psrno=pin.psrno left join "
						+ " (select sum(op.opqty) opqty,sum(op.cost_price)  cost_price,op.Stockid,op.prdid,brhid from( "
						+ "select p.brhid,p.date,(p.op_qty)-(coalesce(a.outqty,0)) opqty ,"+sqls2+"   "
						 + "cost_price,p.Stockid,p.prdid from my_prddin  p  "
						 + "left join (select sum(qty) outqty,stockid,sum(qty*cost_price) cost  from my_prddout where"
							 + "    cast(date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by stockid) a on a.stockid=p.stockid "
							 		+ " where  cast(p.date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by p.Stockid "
						+ " ) op group by op.brhid) ops on ops.brhid=pin.brhid left join (select brhid, sum(st.stkqty) stkqty,sum(st.stcost_price)  stcost_price, "
						+ " st.Stockid,st.prdid from(select brhid, date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
						 + "  Stockid,prdid from my_prddin where "
						+ "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  "+locsql1+" group by Stockid "
						+ "  ) st group by st.brhid) stk on stk.brhid=pin.brhid"
						+ " left join (select sum(coalesce(a.outqty,0)) issueqty,sum(coalesce(outcost,0)) isscost,prdid,brhid from "
						+ "  (select a.outqty ,"+sqlss+" outcost, a.prdid,a.brhid from "
						+ "	(select sum(qty) outqty,stockid,prdid,brhid,sum(qty*cost_price) cost_price from my_prddout where "
						+ "	cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"'  "+insqls1+"  "+locsql1+"  group by stockid) a "
						+ "		left join my_prddin p on a.stockid=p.stockid )  a where 1=1 group by a.brhid ) iss on iss.brhid=pin.brhid "
						+ " where  1=1  "+insqls2+" "+locsql2+"  group by pin.brhid) stks "
	                   + "	inner  join my_brch br on(stks.brhid=br.doc_no)    where 1=1 "
	                   + " and (opnqty!=0 or opnval!=0 or inqty!=0 or inval!=0 or isqty!=0 or isval!=0 or balqty!=0 or stv!=0)   "+sql12+" " ; 
				
				
				
			 
			}
			else  
					{ 
						
 
				sql="	select m.part_no pno,m.productname  pname,stks.* from ( select  pin.brhid,pin.psrno,date,coalesce(ops.opqty,0) opnqty,"
						+ " coalesce(ops.cost_price,0) opnval "
					+ ",stk.stkqty inqty ,stk.stcost_price inval ,iss.issueqty isqty,iss.isscost isval, "
					+ " (coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0) balqty , "
					+ "  (coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0) stv,pin.cost_price  cpu1 , "
					+ " (((coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0))/"
					+ " ((coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0))) cpu  "
						+ "  from my_prddin pin  left join  "
						+ " (select sum(op.opqty) opqty,sum(op.cost_price)  cost_price,op.Stockid,op.prdid from( "
						+ "select p.date,(p.op_qty)-(coalesce(a.outqty,0)) opqty ,"+sqls2+"  "
						 + "cost_price,p.Stockid,p.prdid from my_prddin p left join (select sum(qty) outqty,stockid,sum(qty*cost_price) cost  from my_prddout where"
						 + "    cast(date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by stockid) a on a.stockid=p.stockid"
						 		+ " where  cast(p.date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by p.Stockid "
						+ " ) op group by op.prdid) ops on ops.prdid=pin.prdid left join (select sum(st.stkqty) stkqty,"
						+ "sum(st.stcost_price)  stcost_price , st.Stockid,st.prdid from(select date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
						 + "   Stockid,prdid from my_prddin where "
						+ "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  "+locsql1+" group by Stockid "
						+ "  ) st group by st.prdid) stk on stk.prdid=pin.prdid "
						+ " left join (select sum(coalesce(a.outqty,0)) issueqty,sum(coalesce(outcost,0)) isscost,prdid from   "
						+ " (select a.outqty ,"+sqlss+" outcost, a.prdid from "
						+ "	(select sum(qty) outqty,stockid,prdid,sum(qty*cost_price) cost_price from my_prddout where "
						+ "	cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"'  "+insqls1+"  "+locsql1+"  group by stockid) a "
						+ "		left join my_prddin p on a.stockid=p.stockid )  a where 1=1 group by a.prdid ) iss on iss.prdid=pin.prdid "
						+ "where  1=1  "+insqls2+" "+locsql2+"    group by pin.prdid) stks "
	                   + "	left  join my_main m on(stks.psrno=m.psrno) "+sqljoin+"  where 1=1"
	                   		+ " and (opnqty!=0 or opnval!=0 or inqty!=0 or inval!=0 or isqty!=0 or isval!=0 or balqty!=0 or stv!=0)   "+sql11+" " ;
				
				
				
		 
				
				
				
				
					}
			
			
			/*
			sql="select m.part_no pno,m.productname  pname,stks.* from (  "
					+ "select  pin.brhid,pin.psrno,date,coalesce(ops.opqty,0) opnqty,coalesce(ops.cost_price,0) opnval "
					+ ",stk.stkqty inqty ,stk.stcost_price inval ,iss.issueqty isqty,iss.isscost isval, "
					+ " (coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0) balqty , "
					+ "  (coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0) stv,pin.cost_price  cpu1 , "
					+ " (((coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0))/"
					+ " ((coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0))) cpu  "
					+ "  from my_prddin pin  left join "
					+ " (select sum(op.opqty) opqty,sum(op.cost_price)  cost_price,op.Stockid,op.prdid from( "
					+ "select p.date,(p.op_qty)-(a.outqty) opqty ,((op_qty)-(a.outqty))*p.cost_price "
					 + " cost_price,p.Stockid,p.prdid from my_prddin  p	left join (select sum(qty) outqty,stockid from my_prddout where"
					 + "    cast(date as date)<'"+frmdate+"' "+insqls1+" group by stockid) a on a.stockid=p.stockid  "
					 + " where  cast(date as date)<'"+frmdate+"' "+insqls1+"  group by p.Stockid "
					+ " ) op group by op.prdid) ops on ops.prdid=pin.prdid left join (select sum(st.stkqty) stkqty,sum(st.stcost_price)  stcost_price,"
				  +" st.Stockid,st.prdid from(select date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
					 + "   Stockid,prdid from my_prddin where "
					+ "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  group by Stockid "
					+ "  ) st group by st.prdid) stk on stk.prdid=pin.prdid"
					+ " left join (select sum(a.outqty) issueqty,sum(outcost) isscost,prdid from   (select a.outqty ,a.outqty*p.cost_price outcost, a.prdid from "
					+ "	(select sum(qty) outqty,stockid,prdid from my_prddout where "
					+ "	cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"   group by stockid) a "
					+ "		left join my_prddin p on a.stockid=p.stockid )  a where 1=1 group by a.prdid ) iss on iss.prdid=pin.prdid "
					+ "  where  1=1  "+insqls2+"  group by pin.psrno) stks "
                   + "	left  join my_main m on(stks.psrno=m.psrno) "+sqljoin+"  where 1=1 and"
                   		+ "  (opnqty!=0 or opnval!=0 or inqty!=0 or inval!=0 or isqty!=0 or isval!=0 or balqty!=0 or stv!=0)  "+sqlfinal+" " ;
			
			
			+ " left join (select sum(a.outqty) issueqty,sum(outcost) isscost,prdid from   (select a.outqty ,a.outqty*p.cost_price outcost, a.prdid from "
			+ "	(select sum(qty) outqty,stockid,prdid from my_prddout where "
			+ "	cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"   group by stockid) a "
			+ "		left join my_prddin p on a.stockid=p.stockid )  a where 1=1 group by a.prdid ) iss on iss.prdid=pin.prdid "*/
			
			/*  ( "
						+ "select p.date,(p.op_qty)-(a.outqty) opqty ,((op_qty)-(a.outqty))*p.cost_price "
						 + " cost_price,p.Stockid,p.prdid from my_prddin  p	left join (select sum(qty) outqty,stockid from my_prddout where"
						 + "    cast(date as date)<'"+frmdate+"' "+insqls1+" group by stockid) a on a.stockid=p.stockid  "
						 + " where  cast(date as date)<'"+frmdate+"' "+insqls1+"  group by p.Stockid "
						+ " ) op group by op.prdid)
			
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

			
/* 			sql="select m.part_no pno,m.productname  pname,stks.* from (  "
					+ "select pin.locid, pin.brhid,pin.psrno,date,coalesce(ops.opqty,0) opnqty,coalesce(ops.cost_price,0) opnval "
					+ ",stk.stkqty inqty ,stk.stcost_price inval ,stk.issueqty isqty,stk.isscost isval, "
					+ " (coalesce(stk.stkqty,0)-coalesce(stk.issueqty,0))+coalesce(ops.opqty,0) balqty , "
					+ "  (coalesce(stk.stcost_price,0)-coalesce(stk.isscost,0))+coalesce(ops.cost_price,0) stv,pin.cost_price  cpu1 , "
					+ " (((coalesce(stk.stcost_price,0)-coalesce(stk.isscost,0))+coalesce(ops.cost_price,0))/((coalesce(stk.stkqty,0)-coalesce(stk.issueqty,0))+coalesce(ops.opqty,0))) cpu  "
					+ "  from my_prddin pin  left join "
					+ " (select sum(op.opqty) opqty,sum(op.cost_price)  cost_price,op.Stockid,op.prdid,locid,brhid from( "
					+ "select date,locid,brhid,(op_qty)-(out_qty+rsv_qty+del_qty) opqty ,((op_qty)-(out_qty+rsv_qty+del_qty))*cost_price "
					 + "cost_price,Stockid,prdid from my_prddin where  cast(date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by Stockid "
					+ " ) op "+opsql+" ) ops on ops.prdid=pin.prdid left join (select sum(st.stkqty) stkqty,sum(st.stcost_price)  stcost_price,sum(st.issueqty) issueqty, "
					 + " sum(st.isscost) isscost , st.Stockid,st.prdid from(select date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
					 + " (out_qty+rsv_qty+del_qty) issueqty,(out_qty+rsv_qty+del_qty)*cost_price isscost, Stockid,prdid from my_prddin where "
					+ "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+" "+locsql1+"   group by Stockid "
					+ "  ) st group by "+sksql+" where  1=1  "+insqls2+" "+locsql2+"  "+pinsql+") stks "
                   + "	left  join my_main m on(stks.psrno=m.psrno) "+sqljoin+"  where 1=1 and "
                   		+ "(opnqty!=0 or opnval!=0 or inqty!=0 or inval!=0 or isqty!=0 or isval!=0 or balqty!=0 or stv!=0)  "+sqlfinal+" " ;
			
		 */
			 
 			 
				
				
				

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
			String hidsubcat,String hidproduct,String branchid,String hidept,String load,String prodgroupby,String hidlocid) throws SQLException {


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

			String sqlfrm="",sqlto="",sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="",sql10="",sql11="",sql12="",sql13="",sql14="",sqlfinal="";

			String insqls1="";
			String insqls2="";
			java.sql.Date frmdate=ClsCommon.changeStringtoSqlDate(fromDate);

			java.sql.Date todate=ClsCommon.changeStringtoSqlDate(toDate);
			String  sql71="";
			if(!(hidbrand.equalsIgnoreCase("0") || hidbrand.equalsIgnoreCase("") || hidbrand.equalsIgnoreCase("undefined"))){
				sql7=" and bd.doc_no in ("+hidbrand+")";
				sql71=" and stks.brandid in ("+hidbrand+")";
				
				
			}

			String  sql81="";
			
			if(!(hidtype.equalsIgnoreCase("0") || hidtype.equalsIgnoreCase("") || hidtype.equalsIgnoreCase("undefined"))){
				sql8=" and pt.doc_no in ("+hidtype+")";
				sql81 =" and stks.typeid in ("+hidtype+")";
			}
			String sql131="";
			if(!(hidept.equalsIgnoreCase("0") || hidept.equalsIgnoreCase("") || hidept.equalsIgnoreCase("undefined"))){
				sql13=" and dep.doc_no in ("+hidept+")";
				
				sql131=" and stks.deptid in ("+hidept+")";
				
			}
			
        String sql91="";
			if(!(hidcat.equalsIgnoreCase("0") || hidcat.equalsIgnoreCase("") || hidcat.equalsIgnoreCase("undefined"))){
				sql9=" and cat.doc_no in ("+hidcat+") ";
				
				sql91= "   and stks.catid in ("+hidcat+")";
				
			}
			
			String  sql101="";
			if(!(hidsubcat.equalsIgnoreCase("0") || hidsubcat.equalsIgnoreCase("") || hidsubcat.equalsIgnoreCase("undefined"))){
				sql10=" and sc.doc_no in ("+hidsubcat+")";
				
				sql101=" and stks.scatid in ("+hidsubcat+")";
			}
 
			
			if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
				sql11=" and m.doc_no in ("+hidproduct+")";
				
				 
				
			}
			
			
		 
			String opsql="";    	 
			
			String sksql="";   
			String pinsql="";   
			
			
			String opselect="";
			
			
			
			String locsql1="";
			String locsql2="";
			
			if(!(hidlocid.equalsIgnoreCase("0") || hidlocid.equalsIgnoreCase("") || hidlocid.equalsIgnoreCase("undefined"))){
				sql14=" and stks.locid in ("+hidlocid+")";
				
				locsql2="and pin.locid in ("+hidlocid+")  ";
				
                locsql1= " and locid in ("+hidlocid+") ";
				
				
			}  
			
			
			 if(!(branchid.equalsIgnoreCase("0") || branchid.equalsIgnoreCase("") || branchid.equalsIgnoreCase("undefined")|| branchid.equalsIgnoreCase("a"))){
		         sql12="and stks.brhid="+branchid+"  ";
				
				insqls2="and pin.brhid="+branchid+"  ";
				
				insqls1= " and brhid="+branchid+" ";
				
				
			} 
			 
			 
				int method=0;
				
				String sqlsss="select method from gl_prdconfig where field_nme='stockanalysis';";
						ResultSet rd=stmt.executeQuery(sqlsss);
				if(rd.first())
				{
					method=rd.getInt("method");
				}
				
				String sqlss="";
				String sqls2="";
				
 
				if(method==1)
				{
					sqlss="a.cost_price";
					
					sqls2= "(op_qty*cost_price)-coalesce(cost,0) ";
					
				}
				else
				{
					sqlss="a.outqty*p.cost_price";
					sqls2= " ((op_qty)-(coalesce(a.outqty,0)))*p.cost_price ";
					
				}
			 
			 
			
			sqlfinal=sql1+sql2+sql3+sql4+sql5+sql6+sql7+sql8+sql9+sql10+sql11+sql12+sql13+sql14;
			sqljoin =  "left join my_ptype pt on(m.typeid=pt.doc_no) "
					+ "left join my_brand bd on(m.brandid=bd.doc_no) "
					+ "left join my_dept dep on(dep.doc_no=m.deptid) "
					+ "left join my_catm cat on(m.catid=cat.doc_no)"
					+ "left join my_scatm sc on(m.scatid=sc.doc_no)";

			
			
			if(prodgroupby.equalsIgnoreCase("gloca"))
					{
	 
				
				sql="	 select pin.locid, pin.brhid,pin.psrno,coalesce(ops.opqty,0) opnqty, "
						+ "coalesce(ops.cost_price,0) opnval "
						+ ",stk.stkqty inqty ,stk.stcost_price inval ,iss.issueqty isqty,iss.isscost isval, "
						+ " (coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0) balqty , "
						+ "  (coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0) stv,pin.cost_price  cpu1 , "
						+ " (((coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0))/"
						+ " ((coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0))) cpu  "
						+ "  from my_prddin pin  left join my_main m on  m.psrno=pin.psrno left join "
						+ " (select sum(op.opqty) opqty,sum(op.cost_price)  cost_price,op.Stockid,op.prdid,locid from( "
						+ "select p.locid,p.date,(p.op_qty)-(coalesce(a.outqty,0)) opqty ,"+sqls2+"   "
						 + "cost_price,p.Stockid,p.prdid from my_prddin  p  "
						 + "left join (select sum(qty) outqty,stockid,sum(qty*cost_price) cost from my_prddout where"
							 + "    cast(date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by stockid) a on a.stockid=p.stockid "
							 		+ " where  cast(p.date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by p.Stockid "
						+ " ) op group by op.locid) ops on ops.locid=pin.locid left join (select locid, sum(st.stkqty) stkqty,sum(st.stcost_price)  stcost_price, "
						+ " st.Stockid,st.prdid from(select locid, date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
						 + "  Stockid,prdid from my_prddin where "
						+ "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  "+locsql1+" group by Stockid "
						+ "  ) st group by st.locid) stk on stk.locid=pin.locid"
						+ " left join (select sum(coalesce(a.outqty,0)) issueqty,sum(coalesce(outcost,0)) isscost,prdid,locid from "
						+ "   (select a.outqty ,"+sqlss+" outcost, a.prdid,a.locid from "
						+ "	(select sum(qty) outqty,stockid,prdid,locid,sum(qty*cost_price) cost_price from my_prddout where "
						+ "	cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"'  "+insqls1+"  "+locsql1+"  group by stockid) a "
						+ "		left join my_prddin p on a.stockid=p.stockid )  a where 1=1 group by a.locid ) iss on iss.locid=pin.locid "
						+ " where  1=1  "+insqls2+" "+locsql2+"  group by pin.locid  " ; 
				
				
				
 
				sql="	select l.doc_no ' CODE',l.loc_name  DESCRIPTION, opnqty 'OPENING QUANTITY',opnval 'OPENING VALUE', "
						+ " inqty 'IN  QUANTITY',inval 'IN VALUE',isqty 'ISSUED  QUANTITY', isval 'ISSUED  VALUE',balqty 'BALANCE  QUANTITY',stv  'BALANCE VALUE',"
						+ "  cpu 'COST PER UNIT'  from ( "+sql+") stks "
	                   + "	inner  join my_locm l on(stks.locid=l.doc_no)    where 1=1 "
	                   + " and (opnqty!=0 or opnval!=0 or inqty!=0 or inval!=0 or isqty!=0 or isval!=0 or balqty!=0 or stv!=0)   "+sql14+" " ; 
							
					}
			else if(prodgroupby.equalsIgnoreCase("gptype"))
			{
 
				
				sql="	 select m.typeid, pin.brhid,pin.psrno,coalesce(ops.opqty,0) opnqty ,"
						+ "coalesce(ops.cost_price,0) opnval "
						+ ",stk.stkqty inqty ,stk.stcost_price inval ,iss.issueqty isqty,iss.isscost isval, "
						+ " (coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0) balqty , "
						+ "  (coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0) stv,pin.cost_price  cpu1 , "
						+ " (((coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0))/"
						+ " ((coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0))) cpu  "
						+ "  from my_prddin pin  inner join my_main m on  m.psrno=pin.psrno left join "
						+ " (select m.typeid,sum(op.opqty) opqty,sum(op.cost_price)  cost_price,op.Stockid,op.prdid from( "
						+ "select p.date,(p.op_qty)-(coalesce(a.outqty,0)) opqty ,"+sqls2+"  "
						 + "cost_price,p.Stockid,p.prdid from my_prddin  p  "
						 + "left join (select sum(qty) outqty,stockid,sum(qty*cost_price) cost from my_prddout where"
							 + "    cast(date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by stockid) a on a.stockid=p.stockid "  
							+ " where  cast(p.date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by p.Stockid "
						+ " ) op left join my_main m on m.psrno=op.prdid   group by m.typeid) ops on ops.typeid=m.typeid"
						+ "  left join (select m.typeid,sum(st.stkqty) stkqty,sum(st.stcost_price)  stcost_price ,st.Stockid,st.prdid from(select  date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
						 + "  Stockid,prdid from my_prddin where "
						+ "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  "+locsql1+" group by Stockid "
						+ "  ) st  left join my_main m on m.psrno=st.prdid   group by m.typeid) stk on stk.typeid=m.typeid "
						+ " left join (select typeid,sum(coalesce(a.outqty,0)) issueqty,sum(coalesce(outcost,0)) isscost,prdid,brhid from"
						+ "   (select a.outqty ,"+sqlss+" outcost, a.prdid,a.brhid from "
						+ "	(select sum(qty) outqty,stockid,prdid,brhid,sum(qty*cost_price) cost_price from my_prddout where "
						+ "	cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  "+locsql1+"  group by stockid) a "
						+ "		left join my_prddin p on a.stockid=p.stockid )  a left join my_main m on m.psrno=a.prdid   group by m.typeid) iss on iss.typeid=m.typeid "
						+ "where  1=1  "+insqls2+" "+locsql2+" "
								+ "   group by m.typeid " ; 
				
			
				
 
				sql="	select t.doc_no ' CODE',t.producttype  DESCRIPTION, opnqty 'OPENING QUANTITY',opnval 'OPENING VALUE', "
						+ " inqty 'IN  QUANTITY',inval 'IN VALUE',isqty 'ISSUED  QUANTITY', isval 'ISSUED  VALUE',balqty 'BALANCE  QUANTITY',stv  'BALANCE VALUE',"
						+ "  cpu 'COST PER UNIT'  from ( "+sql+") stks "
	                   + "	inner  join my_ptype t on(stks.typeid=t.doc_no)   where 1=1"
	                   		+ " and (opnqty!=0 or opnval!=0 or inqty!=0 or inval!=0 or isqty!=0 or isval!=0 or balqty!=0 or stv!=0)   "+sql81+" " ; 
				
				
				
			}
			else if(prodgroupby.equalsIgnoreCase("gpbrand"))
					{
						
	 
				sql="	 select m.brandid, pin.brhid,pin.psrno,coalesce(ops.opqty,0) opnqty,"
						+ "coalesce(ops.cost_price,0) opnval "
						+ ",stk.stkqty inqty ,stk.stcost_price inval ,iss.issueqty isqty,iss.isscost isval, "
						+ " (coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0) balqty , "
						+ "  (coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0) stv,pin.cost_price  cpu1 , "
						+ " (((coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0))/"
						+ " ((coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0))) cpu  "
						+ "  from my_prddin pin  inner join my_main m on  m.psrno=pin.psrno left join "
						+ " (select m.brandid,sum(op.opqty) opqty,sum(op.cost_price)  cost_price,op.Stockid,op.prdid from( "
						+ "select p.date,(p.op_qty)-(coalesce(a.outqty,0)) opqty ,"+sqls2+"   "
						 + "cost_price,p.Stockid,p.prdid from my_prddin  p  "
						 + "left join (select sum(qty) outqty,stockid,sum(qty*cost_price) cost  from my_prddout where"
							 + "    cast(date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by stockid) a on a.stockid=p.stockid "  
							+ " where  cast(p.date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by p.Stockid "
						+ " ) op left join my_main m on m.psrno=op.prdid   group by m.brandid) ops on ops.brandid=m.brandid"
						+ "  left join (select m.brandid,sum(st.stkqty) stkqty,sum(st.stcost_price)  stcost_price ,st.Stockid,st.prdid from(select  date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
						 + "  Stockid,prdid from my_prddin where "
						+ "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  "+locsql1+" group by Stockid "
						+ "  ) st  left join my_main m on m.psrno=st.prdid   group by m.brandid) stk on stk.brandid=m.brandid "
						+ " left join (select brandid,sum(coalesce(a.outqty,0)) issueqty,sum(coalesce(outcost,0)) isscost,prdid,brhid from"
						+ "   (select a.outqty ,"+sqlss+" outcost, a.prdid,a.brhid from "
						+ "	(select sum(qty) outqty,stockid,prdid,brhid,sum(qty*cost_price) cost_price from my_prddout where "
						+ "	cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  "+locsql1+"  group by stockid) a "
						+ "		left join my_prddin p on a.stockid=p.stockid )  a left join my_main m on m.psrno=a.prdid   group by m.brandid) iss on iss.brandid=m.brandid "
						+ "where  1=1  "+insqls2+" "+locsql2+" "
								+ "   group by m.brandid " ; 
				
				
				

				

				sql="	select b.doc_no ' CODE',b.brandname  DESCRIPTION, opnqty 'OPENING QUANTITY',opnval 'OPENING VALUE', "
					+ " inqty 'IN  QUANTITY',inval 'IN VALUE',isqty 'ISSUED  QUANTITY', isval 'ISSUED  VALUE',balqty 'BALANCE  QUANTITY',stv  'BALANCE VALUE',"
					+ "  cpu 'COST PER UNIT'  from ( "+sql+") stks "
	                   + "	inner  join my_brand b on(stks.brandid=b.doc_no)   where 1=1"
	                   		+ " and (opnqty!=0 or opnval!=0 or inqty!=0 or inval!=0 or isqty!=0 or isval!=0 or balqty!=0 or stv!=0)   "+sql71+" " ; 
				
				
				
				
				
 	}
			
			
			else if(prodgroupby.equalsIgnoreCase("gpdept"))
			{ 

 

				sql="	 select m.deptid, pin.brhid,pin.psrno,coalesce(ops.opqty,0) opnqty,"
						+ "coalesce(ops.cost_price,0) opnval "
						+ ",stk.stkqty inqty ,stk.stcost_price inval ,iss.issueqty isqty,iss.isscost isval, "
						+ " (coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0) balqty , "
						+ "  (coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0) stv,pin.cost_price  cpu1 , "
						+ " (((coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0))/"
						+ " ((coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0))) cpu  "
						+ "  from my_prddin pin  inner join my_main m on  m.psrno=pin.psrno left join "
						+ " (select m.deptid,sum(op.opqty) opqty,sum(op.cost_price)  cost_price,op.Stockid,op.prdid from( "
						+ "select p.date,(p.op_qty)-(coalesce(a.outqty,0)) opqty ,"+sqls2+"   "
						 + "cost_price,p.Stockid,p.prdid from my_prddin  p  "
						 + "left join (select sum(qty) outqty,stockid,sum(qty*cost_price) cost  from my_prddout where"
							 + "    cast(date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by stockid) a on a.stockid=p.stockid "  
							+ " where  cast(p.date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by p.Stockid "
						+ " ) op left join my_main m on m.psrno=op.prdid   group by m.deptid) ops on ops.deptid=m.deptid"
						+ "  left join (select m.deptid,sum(st.stkqty) stkqty,sum(st.stcost_price)  stcost_price ,st.Stockid,st.prdid from(select  date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
						 + "  Stockid,prdid from my_prddin where "
						+ "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  "+locsql1+" group by Stockid "
						+ "  ) st  left join my_main m on m.psrno=st.prdid   group by m.deptid) stk on stk.deptid=m.deptid "
						+ " left join (select deptid,sum(coalesce(a.outqty,0)) issueqty,sum(coalesce(outcost,0)) isscost,prdid,brhid from"
						+ "   (select a.outqty ,"+sqlss+" outcost, a.prdid,a.brhid from "
						+ "	(select sum(qty) outqty,stockid,prdid,brhid,sum(qty*cost_price) cost_price from my_prddout where "
						+ "	cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  "+locsql1+"  group by stockid) a "
						+ "		left join my_prddin p on a.stockid=p.stockid )  a left join my_main m on m.psrno=a.prdid   group by m.deptid) iss on iss.deptid=m.deptid "
						+ "where  1=1  "+insqls2+" "+locsql2+" "
								+ "   group by m.deptid  " ; 
				
				
				
				
				
				sql="	select d.doc_no ' CODE',d.department  DESCRIPTION, opnqty 'OPENING QUANTITY',opnval 'OPENING VALUE', "
					+ " inqty 'IN  QUANTITY',inval 'IN VALUE',isqty 'ISSUED  QUANTITY', isval 'ISSUED  VALUE',balqty 'BALANCE  QUANTITY',stv  'BALANCE VALUE',"
					+ "  cpu 'COST PER UNIT'   from ("+sql+") stks "
	                   + "	inner  join my_dept d on(stks.deptid=d.doc_no)   where 1=1"
	                   		+ " and (opnqty!=0 or opnval!=0 or inqty!=0 or inval!=0 or isqty!=0 or isval!=0 or balqty!=0 or stv!=0)   "+sql131+" " ; 
				
				
				
				
				
				
			}
			else if(prodgroupby.equalsIgnoreCase("gpcategory"))
					{
				sql="	  select m.catid, pin.brhid,pin.psrno,coalesce(ops.opqty,0) opnqty, "
						+ "coalesce(ops.cost_price,0) opnval "
						+ ",stk.stkqty inqty ,stk.stcost_price inval ,iss.issueqty isqty,iss.isscost isval, "
						+ " (coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0) balqty , "
						+ "  (coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0) stv,pin.cost_price  cpu1 , "
						+ " (((coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0))/"
						+ " ((coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0))) cpu  "
						+ "  from my_prddin pin  inner join my_main m on  m.psrno=pin.psrno left join "
						+ " (select m.catid,sum(op.opqty) opqty,sum(op.cost_price)  cost_price,op.Stockid,op.prdid from( "
						+ "select p.date,(p.op_qty)-(coalesce(a.outqty,0)) opqty ,"+sqls2+"   "
						 + "cost_price,p.Stockid,p.prdid from my_prddin  p  "
						 + "left join (select sum(qty) outqty,stockid,sum(qty*cost_price) cost from my_prddout where"
							 + "    cast(date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by stockid) a on a.stockid=p.stockid "  
							+ " where  cast(p.date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by p.Stockid "
						+ " ) op left join my_main m on m.psrno=op.prdid   group by m.catid) ops on ops.catid=m.catid"
						+ "  left join (select m.catid,sum(st.stkqty) stkqty,sum(st.stcost_price)  stcost_price ,st.Stockid,st.prdid from(select  date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
						 + "  Stockid,prdid from my_prddin where "
						+ "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  "+locsql1+" group by Stockid "
						+ "  ) st  left join my_main m on m.psrno=st.prdid   group by m.catid) stk on stk.catid=m.catid "
						+ " left join (select catid,sum(coalesce(a.outqty,0)) issueqty,sum(coalesce(outcost,0)) isscost,prdid,brhid from"
						+ "   (select a.outqty ,"+sqlss+" outcost, a.prdid,a.brhid from "
						+ "	(select sum(qty) outqty,stockid,prdid,brhid,sum(qty*cost_price) cost_price from my_prddout where "
						+ "	cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  "+locsql1+"  group by stockid) a "
						+ "		left join my_prddin p on a.stockid=p.stockid )  a left join my_main m on m.psrno=a.prdid   group by m.catid) iss on iss.catid=m.catid "
						+ "where  1=1  "+insqls2+" "+locsql2+" "
								+ "   group by m.catid " ; 
				
			 
				sql="	select c.doc_no ' CODE',c.category  DESCRIPTION, opnqty 'OPENING QUANTITY',opnval 'OPENING VALUE', "
						+ " inqty 'IN  QUANTITY',inval 'IN VALUE',isqty 'ISSUED  QUANTITY', isval 'ISSUED  VALUE',balqty 'BALANCE  QUANTITY',stv  'BALANCE VALUE',"
						+ "  cpu 'COST PER UNIT'  from (  "+sql+") stks "
	                   + "	inner  join my_catm c on(stks.catid=c.doc_no)   where 1=1"
	                   		+ " and (opnqty!=0 or opnval!=0 or inqty!=0 or inval!=0 or isqty!=0 or isval!=0 or balqty!=0 or stv!=0)   "+sql91+" " ; 
				
				 
				
				
						
					}
			else if(prodgroupby.equalsIgnoreCase("gpsubcategory"))
					{
						
				sql="	  select m.scatid, pin.brhid,pin.psrno,coalesce(ops.opqty,0) opnqty, "
						+ "coalesce(ops.cost_price,0) opnval "
						+ ",stk.stkqty inqty ,stk.stcost_price inval ,iss.issueqty isqty,iss.isscost isval, "
						+ " (coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0) balqty , "
						+ "  (coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0) stv,pin.cost_price  cpu1 , "
						+ " (((coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0))/"
						+ " ((coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0))) cpu  "
						+ "  from my_prddin pin  inner join my_main m on  m.psrno=pin.psrno left join "
						+ " (select m.scatid,sum(op.opqty) opqty,sum(op.cost_price)  cost_price,op.Stockid,op.prdid from( "
						+ "select p.date,(p.op_qty)-(coalesce(a.outqty,0)) opqty ,"+sqls2+"   "
						 + "cost_price,p.Stockid,p.prdid from my_prddin  p  "
						 + "left join (select sum(qty) outqty,stockid,sum(qty*cost_price) cost  from my_prddout where"
							 + "    cast(date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by stockid) a on a.stockid=p.stockid "  
							+ " where  cast(p.date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by p.Stockid "
						+ " ) op left join my_main m on m.psrno=op.prdid   group by m.scatid) ops on ops.scatid=m.scatid"
						+ "  left join (select m.scatid,sum(st.stkqty) stkqty,sum(st.stcost_price)  stcost_price ,st.Stockid,st.prdid "
						+ " from(select  date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
						 + "  Stockid,prdid from my_prddin where "
						+ "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  "+locsql1+" group by Stockid "
						+ "  ) st  left join my_main m on m.psrno=st.prdid   group by m.scatid) stk on stk.scatid=m.scatid "
						+ " left join (select scatid,sum(coalesce(a.outqty,0)) issueqty,sum(coalesce(outcost,0)) isscost,prdid,brhid from"
						+ "   (select a.outqty ,"+sqlss+" outcost, a.prdid,a.brhid from "
						+ "	(select sum(qty) outqty,stockid,prdid,brhid,sum(qty*cost_price) cost_price from my_prddout where "
						+ "	cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  "+locsql1+"  group by stockid) a "
						+ "		left join my_prddin p on a.stockid=p.stockid )  a left join my_main m on m.psrno=a.prdid   group by m.scatid " ; 
			
				
				sql="select sc.doc_no ' CODE',sc.subcategory  DESCRIPTION, opnqty 'OPENING QUANTITY',opnval 'OPENING VALUE', "
						+ " inqty 'IN  QUANTITY',inval 'IN VALUE',isqty 'ISSUED  QUANTITY', isval 'ISSUED  VALUE',balqty 'BALANCE  QUANTITY',stv  'BALANCE VALUE',"
						+ "  cpu 'COST PER UNIT'  from ( "+sql+") stks "
	                   + "	inner  join my_scatm sc on(stks.scatid=sc.doc_no)   where 1=1 "
	                   		+ " and (opnqty!=0 or opnval!=0 or inqty!=0 or inval!=0 or isqty!=0 or isval!=0 or balqty!=0 or stv!=0)   "+sql101+" " ; 
				

				

				
					}
			else if(prodgroupby.equalsIgnoreCase("gbranch"))
			{
				sql="	 select pin.brhid,pin.psrno,coalesce(ops.opqty,0) opnqty, "
						+ "coalesce(ops.cost_price,0) opnval "
						+ ",stk.stkqty inqty ,stk.stcost_price inval ,iss.issueqty isqty,iss.isscost isval, "
						+ " (coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0) balqty , "
						+ "  (coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0) stv,pin.cost_price  cpu1 , "
						+ " (((coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0))/"
						+ " ((coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0))) cpu  "
						+ "  from my_prddin pin  left join my_main m on  m.psrno=pin.psrno left join "
						+ " (select sum(op.opqty) opqty,sum(op.cost_price)  cost_price,op.Stockid,op.prdid,brhid from( "
						+ "select p.brhid,p.date,(p.op_qty)-(coalesce(a.outqty,0)) opqty ,"+sqls2+"   "
						 + "cost_price,p.Stockid,p.prdid from my_prddin  p  "
						 + "left join (select sum(qty) outqty,stockid,sum(qty*cost_price) cost  from my_prddout where"
							 + "    cast(date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by stockid) a on a.stockid=p.stockid "
							 		+ " where  cast(p.date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by p.Stockid "
						+ " ) op group by op.brhid) ops on ops.brhid=pin.brhid left join (select brhid, sum(st.stkqty) stkqty,sum(st.stcost_price)  stcost_price, "
						+ " st.Stockid,st.prdid from(select brhid, date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
						 + "  Stockid,prdid from my_prddin where "
						+ "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  "+locsql1+" group by Stockid "
						+ "  ) st group by st.brhid) stk on stk.brhid=pin.brhid"
						+ " left join (select sum(coalesce(a.outqty,0)) issueqty,sum(coalesce(outcost,0)) isscost,prdid,brhid from "
						+ "  (select a.outqty ,"+sqlss+" outcost, a.prdid,a.brhid from "
						+ "	(select sum(qty) outqty,stockid,prdid,brhid,sum(qty*cost_price) cost_price from my_prddout where "
						+ "	cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"'  "+insqls1+"  "+locsql1+"  group by stockid) a "
						+ "		left join my_prddin p on a.stockid=p.stockid )  a where 1=1 group by a.brhid ) iss on iss.brhid=pin.brhid "
						+ " where  1=1  "+insqls2+" "+locsql2+"  group by pin.brhid  " ; 
				
				
				sql="	select br.doc_no ' CODE',br.branchname  DESCRIPTION, opnqty 'OPENING QUANTITY',opnval 'OPENING VALUE', "
						+ " inqty 'IN  QUANTITY',inval 'IN VALUE',isqty 'ISSUED  QUANTITY', isval 'ISSUED  VALUE',balqty 'BALANCE  QUANTITY',stv  'BALANCE VALUE',"
						+ "  cpu 'COST PER UNIT'  from ("+sql+") stks "
	                   + "	inner  join my_brch br on(stks.brhid=br.doc_no)    where 1=1 "
	                   + " and (opnqty!=0 or opnval!=0 or inqty!=0 or inval!=0 or isqty!=0 or isval!=0 or balqty!=0 or stv!=0)   "+sql12+" " ; 
				
				
				
			}
			else  
					{ 
    

				sql="	  select  pin.brhid,pin.psrno,date,coalesce(ops.opqty,0) opnqty,"
						+ " coalesce(ops.cost_price,0) opnval "
					+ ",stk.stkqty inqty ,stk.stcost_price inval ,iss.issueqty isqty,iss.isscost isval, "
					+ " (coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0) balqty , "
					+ "  (coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0) stv,pin.cost_price  cpu1 , "
					+ " (((coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0))/"
					+ " ((coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0))) cpu  "
						+ "  from my_prddin pin  left join  "
						+ " (select sum(op.opqty) opqty,sum(op.cost_price)  cost_price,op.Stockid,op.prdid from( "
						+ "select p.date,(p.op_qty)-(coalesce(a.outqty,0)) opqty ,"+sqls2+"  "
						
						 + "cost_price,p.Stockid,p.prdid from my_prddin p left join (select sum(qty) outqty,stockid,sum(qty*cost_price) cost  from my_prddout where"
						 + "    cast(date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by stockid) a on a.stockid=p.stockid"
						 		+ " where  cast(p.date as date)<'"+frmdate+"' "+insqls1+" "+locsql1+"  group by p.Stockid "
						+ " ) op group by op.prdid) ops on ops.prdid=pin.prdid left join (select sum(st.stkqty) stkqty,"
						+ "sum(st.stcost_price)  stcost_price , st.Stockid,st.prdid from(select date,(op_qty) stkqty ,(op_qty*cost_price) stcost_price, "
						 + "   Stockid,prdid from my_prddin where "
						+ "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  "+locsql1+" group by Stockid "
						+ "  ) st group by st.prdid) stk on stk.prdid=pin.prdid "
						+ " left join (select sum(coalesce(a.outqty,0)) issueqty,sum(coalesce(outcost,0)) isscost,prdid from   "
						+ " (select a.outqty ,"+sqlss+" outcost, a.prdid from "
						+ "	(select sum(qty) outqty,stockid,prdid,sum(qty*cost_price) cost_price from my_prddout where "
						+ "	cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"'  "+insqls1+"  "+locsql1+"  group by stockid) a "
						+ "		left join my_prddin p on a.stockid=p.stockid )  a where 1=1 group by a.prdid ) iss on iss.prdid=pin.prdid "
						+ "where  1=1  "+insqls2+" "+locsql2+"  group by pin.prdid " ;

				sql="	select m.part_no ' CODE',m.productname  DESCRIPTION, opnqty 'OPENING QUANTITY',opnval 'OPENING VALUE', "
					+ " inqty 'IN  QUANTITY',inval 'IN VALUE',isqty 'ISSUED  QUANTITY', isval 'ISSUED  VALUE',balqty 'BALANCE  QUANTITY',stv  'BALANCE VALUE',"
					+ "  cpu 'COST PER UNIT'  from ("+sql+") stks "
	                   + "	left  join my_main m on(stks.psrno=m.psrno) "+sqljoin+"  where 1=1 "
	                   		+ " and (opnqty!=0 or opnval!=0 or inqty!=0 or inval!=0 or isqty!=0 or isval!=0 or balqty!=0 or stv!=0)   "+sql11+" " ; 
					}
			
		  
 

			 System.out.println("==sql==========="+sql);

			ResultSet resultSet = stmt.executeQuery(sql);


			RESULTDATA=ClsCommon.convertToEXCEL(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
 
  
 
	
	public JSONArray stockLedgeralabar(HttpSession session,String hidbrand,String fromDate,String toDate,String hidtype,String hidcat,
			String hidsubcat,String hidproduct,String branchid,String hidept,String load,String prodgroupby,String hidlocid) throws SQLException {


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

			String sqlfrm="",sqlto="",sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="",sql10="",sql11="",sql12="",sql13="",sql14="",sqlfinal="";

			String insqls1="";
			String insqls2="";
			java.sql.Date frmdate=ClsCommon.changeStringtoSqlDate(fromDate);

			java.sql.Date todate=ClsCommon.changeStringtoSqlDate(toDate);
String  sqlslast="";
			if(!(hidbrand.equalsIgnoreCase("0") || hidbrand.equalsIgnoreCase("") || hidbrand.equalsIgnoreCase("undefined"))){
				 
				sqlslast=sqlslast +" and m.brandid in ("+hidbrand+")";
				
				
			}

	 
			
			if(!(hidtype.equalsIgnoreCase("0") || hidtype.equalsIgnoreCase("") || hidtype.equalsIgnoreCase("undefined"))){
			 
				sqlslast=sqlslast +" and m.typeid in ("+hidtype+")";
			}
		 
			if(!(hidept.equalsIgnoreCase("0") || hidept.equalsIgnoreCase("") || hidept.equalsIgnoreCase("undefined"))){
				 
				
				sqlslast=sqlslast +" and m.deptid in ("+hidept+")";
				
			}
			
      
			if(!(hidcat.equalsIgnoreCase("0") || hidcat.equalsIgnoreCase("") || hidcat.equalsIgnoreCase("undefined"))){
				 
				
				sqlslast=sqlslast +" and m.catid in ("+hidcat+")";
				
			}
			
		 
			if(!(hidsubcat.equalsIgnoreCase("0") || hidsubcat.equalsIgnoreCase("") || hidsubcat.equalsIgnoreCase("undefined"))){
				 
				
				sqlslast=sqlslast +" and m.scatid in ("+hidsubcat+")";
			}
			 
		 
			
			if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
				sqlslast=sqlslast +"  and m.doc_no in ("+hidproduct+")";
				
				 
				
			}
			
			
		 
			String opsql="";    	 
			
			String sksql="";   
			String pinsql="";   
			
			
			String opselect="";
			
			
			
			String locsql1="";
			String locsql2="";
			
			if(!(hidlocid.equalsIgnoreCase("0") || hidlocid.equalsIgnoreCase("") || hidlocid.equalsIgnoreCase("undefined"))){
				sqlslast=sqlslast +" and l.locid in ("+hidlocid+")";
				
				 
				
                locsql1= " and locid in ("+hidlocid+") ";
				
				
			}  
			
			
			 if(!(branchid.equalsIgnoreCase("0") || branchid.equalsIgnoreCase("") || branchid.equalsIgnoreCase("undefined")|| branchid.equalsIgnoreCase("a"))){
					sqlslast=sqlslast +" and br.brhid="+branchid+"  ";
				
			 
				insqls1= " and brhid="+branchid+" ";
				
				
			} 
			
			sqlfinal=sql1+sql2+sql3+sql4+sql5+sql6+sql7+sql8+sql9+sql10+sql11+sql12+sql13+sql14;
			sqljoin =  "left join my_ptype pt on(m.typeid=pt.doc_no) "
					+ "left join my_brand bd on(m.brandid=bd.doc_no) "
					+ "left join my_dept dep on(dep.doc_no=m.deptid) "
					+ "left join my_catm cat on(m.catid=cat.doc_no)"
					+ "left join my_scatm sc on(m.scatid=sc.doc_no)";
 
			
			String sqlsmain=" ";
			
			
			
			
			 
			
			 
			 
			 String sqlsgy= "";
			
			
			
			if(prodgroupby.equalsIgnoreCase("gloca"))
					{
 
				sqlsmain= " l.doc_no code,l.loc_name  description, ";
				sqlsgy =  " group by l.doc_no ";
 		
					}
			else if(prodgroupby.equalsIgnoreCase("gptype"))
			{
 
				sqlsmain= " pt.doc_no code,pt.producttype  description, ";
				
				sqlsgy =  " group by pt.doc_no ";
				
			}
			else if(prodgroupby.equalsIgnoreCase("gpbrand"))
					{
						
				sqlsmain= "  bd.doc_no code,bd.brandname  description, ";
				
				sqlsgy =  " group by bd.doc_no  ";
 
				
					}
			
			
			else if(prodgroupby.equalsIgnoreCase("gpdept"))
			{ 
				sqlsmain= "  dep.doc_no code,dep.department  description,  ";
				
				
				sqlsgy =  " group by d.doc_no  ";
				
				
			}
			else if(prodgroupby.equalsIgnoreCase("gpcategory"))
					{
 
				sqlsmain= " cat.doc_no code,cat.category  description,  ";
				
				sqlsgy =  " group by cat.doc_no  ";
				 
						
					}
			else if(prodgroupby.equalsIgnoreCase("gpsubcategory"))
					{
						
				sqlsmain= " sc.doc_no code,sc.subcategory  description, ";
				
				sqlsgy =  " group by sc.doc_no  ";
				
					}
			else if(prodgroupby.equalsIgnoreCase("gbranch"))
			{
 
				sqlsmain= "   br.doc_no code,br.branchname  description,  ";
				
				sqlsgy =  " group by  br.doc_no  ";
			}
			else  
					{ 
				sqlsmain=" m.part_no code,m.productname  description, ";
				
				sqlsgy =  " group by  m.part_no  ";
					}
				
		 
				
/*	 
			select    br.doc_no code,br.branchname  description,   sum(opn_qty) opnqty, sum(opn_value) opnval, sum(stock_qty) inqty,
		   	 sum(stock_value) inval,  sum(issuestkqty)  isqty,sum(issuestkval) isval,
		       (coalesce(sum(stock_qty),0)-coalesce(sum(issuestkqty),0))+coalesce(sum(opn_qty),0) balqty,
		       	  (coalesce(sum(stock_value),0)-coalesce(sum(issuestkval),0))+coalesce(sum(opn_value),0) stv ,
		            (((coalesce(sum(stock_value),0)-coalesce(sum(issuestkval),0))+coalesce(sum(opn_value),0))/
		             ((coalesce(sum(stock_qty),0)-coalesce(sum(issuestkqty),0))+coalesce(sum(opn_qty),0))) cpu
		              	  from(   select locid, brhid,psrno,sum(opn_qty) opn_qty,sum(opn_value) opn_value,sum(stock_qty)
		                  	 stock_qty,sum(stock_value) stock_value,   sum(issuestkqty) issuestkqty,sum(issuestkval) issuestkval
		                     	   from  (select locid, brhid,psrno,if(date<'2014-01-01',op_qty,0) opn_qty,
		                          	  if(date<'2014-01-01',op_qty*cost_price,0) opn_value,  if(date>='2014-01-01'
		                                and date<='2014-12-31',op_qty,0) stock_qty,   if(date>='2014-01-01'
		                                 and date<='2014-12-31' 	  ,op_qty*cost_price,0) stock_value,
		                                   0 issuestkqty,0 issuestkval from my_prddin where 1=1
		                                    	union all  	select locid, brhid,psrno,if(date<'2014-01-01',qty*-1,0) opn_qty,
		                                      	 	if(date<'2014-01-01',qty*cost_price*-1,0) opn_value,0 stock_qty,0 stock_value,
		                                           	   if(date>='2014-01-01' and date<='2014-12-31',qty,0) issuestkqty,
		                                                	   if(date>='2014-01-01' and	date<='2014-12-31',qty*cost_price,0) issuestkval
		                                                     	   from my_prddout where 1=1    ) a group by psrno)  stks
		                             left  join my_main m on(stks.psrno=m.psrno)
		                              left join my_ptype pt on(m.typeid=pt.doc_no)
		                               left join my_brand bd on(m.brandid=bd.doc_no)
		                                  left join my_dept dep on(dep.doc_no=m.deptid)
		                                    left join my_catm cat on(m.catid=cat.doc_no)
		                                    left join my_scatm sc on(m.scatid=sc.doc_no)
		                                  left  join my_locm l on(stks.locid=l.doc_no)
		                                    left  join my_brch br on(stks.brhid=br.doc_no) where 1=1      group by  br.doc_no      ;
 
 */
			 
				sql="	select a.* from ( select "+sqlsmain+"  sum(opn_qty) opening_qty, sum(opn_value) opening_value, sum(stock_qty) stock_qty, "
						+ "	 sum(stock_value) stock_value,  sum(issuestkqty)  issue_qty,sum(issuestkval) issue_value, "
						 + "	 (coalesce(sum(stock_qty),0)-coalesce(sum(issuestkqty),0))+coalesce(sum(opn_qty),0) bal_qty, "
						  + "	  (coalesce(sum(stock_value),0)-coalesce(sum(issuestkval),0))+coalesce(sum(opn_value),0) bal_value , "
						  + " (((coalesce(sum(stock_value),0)-coalesce(sum(issuestkval),0))+coalesce(sum(opn_value),0))/"
							+ " ((coalesce(sum(stock_qty),0)-coalesce(sum(issuestkqty),0))+coalesce(sum(opn_qty),0))) costperunit  "
						  + "	  from(   select locid, brhid,psrno,sum(opn_qty) opn_qty,sum(opn_value) opn_value,sum(stock_qty) "
						   + "	 stock_qty,sum(stock_value) stock_value,   sum(issuestkqty) issuestkqty,sum(issuestkval) issuestkval "
						 + "	   from  (select locid, brhid,psrno,if(date<'"+frmdate+"',op_qty,0) opn_qty, "
						  + "	  if(date<'"+frmdate+"',op_qty*cost_price,0) opn_value,  if(date>='"+frmdate+"' "
						  + "	  and date<='"+todate+"',op_qty,0) stock_qty,   if(date>='"+frmdate+"' and date<='"+todate+"' "
						  + "	  ,op_qty*cost_price,0) stock_value,   0 issuestkqty,0 issuestkval from my_prddin where 1=1 "+insqls1+" "+locsql1+" "
						   + "	 	union all  	select locid, brhid,psrno,if(date<'"+frmdate+"',qty*-1,0) opn_qty, "
						     + "	 	if(date<'"+frmdate+"',qty*cost_price*-1,0) opn_value,0 stock_qty,0 stock_value, "
						      + "	   if(date>='"+frmdate+"' and date<='"+todate+"',qty,0) issuestkqty, "
						      + "	   if(date>='"+frmdate+"' and	date<='"+todate+"',qty*cost_price,0) issuestkval "
						      + "	   from my_prddout where 1=1  "+insqls1+" "+locsql1+"   ) a group by psrno )  stks  "
						      + "			left  join my_main m on(stks.psrno=m.psrno)     left join my_ptype pt on(m.typeid=pt.doc_no) " 
						          + "	 left join my_brand bd on(m.brandid=bd.doc_no)       left join my_dept dep on(dep.doc_no=m.deptid) "
						         + "	  left join my_catm cat on(m.catid=cat.doc_no)    left join my_scatm sc on(m.scatid=sc.doc_no)"
						         + "  left  join my_locm l on(stks.locid=l.doc_no)   left  join my_brch br on(stks.brhid=br.doc_no)  where 1=1  "+sqlslast+"  "
						          + "	    "+sqlsgy+" ) a  where 1=1 and (opening_qty!=0 or opening_value!=0 or stock_qty!=0 or stock_value!=0 or issue_qty!=0 or issue_value!=0 or bal_qty!=0 or bal_value!=0)   ";
				
				
				
				
/*			 						sql="	select "+sqlsmain+" stks.* from ( "
						+ "	select stks.locid, stks.brhid,stks.psrno,sum(opn_qty) opnqty, sum(opn_value) opnval, sum(stock_qty) inqty, "
						+ "	 sum(stock_value) inval,  sum(issuestkqty)  isqty,sum(issuestkval) isval, "
						 + "	 (coalesce(sum(stock_qty),0)-coalesce(sum(issuestkqty),0))+coalesce(sum(opn_qty),0) balqty, "
						  + "	  (coalesce(sum(stock_value),0)-coalesce(sum(issuestkval),0))+coalesce(sum(opn_value),0) stv , "
						  + " (((coalesce(sum(stock_value),0)-coalesce(sum(issuestkval),0))+coalesce(sum(opn_value),0))/"
							+ " ((coalesce(sum(stock_qty),0)-coalesce(sum(issuestkqty),0))+coalesce(sum(opn_qty),0))) cpu  "
						  + "	  from(   select locid, brhid,psrno,sum(opn_qty) opn_qty,sum(opn_value) opn_value,sum(stock_qty) "
						   + "	 stock_qty,sum(stock_value) stock_value,   sum(issuestkqty) issuestkqty,sum(issuestkval) issuestkval "
						 + "	   from  (select locid, brhid,psrno,if(date<'"+frmdate+"',op_qty,0) opn_qty, "
						  + "	  if(date<'"+frmdate+"',op_qty*cost_price,0) opn_value,  if(date>='"+frmdate+"' "
						  + "	  and date<='"+todate+"',op_qty,0) stock_qty,   if(date>='"+frmdate+"' and date<='"+todate+"' "
						  + "	  ,op_qty*cost_price,0) stock_value,   0 issuestkqty,0 issuestkval from my_prddin where 1=1 "+insqls1+" "+locsql1+" "
						   + "	 	union all  	select locid, brhid,psrno,if(date<'"+frmdate+"',qty*-1,0) opn_qty, "
						     + "	 	if(date<'"+frmdate+"',qty*cost_price*-1,0) opn_value,0 stock_qty,0 stock_value, "
						      + "	   if(date>='"+frmdate+"' and date<='"+todate+"',qty,0) issuestkqty, "
						      + "	   if(date>='"+frmdate+"' and	date<='"+todate+"',qty*cost_price,0) issuestkval "
						      + "	   from my_prddout where 1=1  "+insqls1+" "+locsql1+"   ) a group by psrno )  stks  "
						      + "			left  join my_main m on(stks.psrno=m.psrno)     left join my_ptype pt on(m.typeid=pt.doc_no) " 
						          + "	 left join my_brand bd on(m.brandid=bd.doc_no)       left join my_dept dep on(dep.doc_no=m.deptid) "
						         + "	  left join my_catm cat on(m.catid=cat.doc_no)    left join my_scatm sc on(m.scatid=sc.doc_no)"
						         + "  left  join my_locm l on(stks.locid=l.doc_no)   left  join my_brch br on(stks.brhid=br.doc_no)   "
						          + "	    where 1=1 and (opnqty!=0 or opnval!=0 or inqty!=0 or inval!=0 or isqty!=0 or isval!=0 or balqty!=0 or stv!=0) "+sqlsgy+"   ) stks   ";
				
				
				*/
				
	 
 
				


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


	
	
	
}
