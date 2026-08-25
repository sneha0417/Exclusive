package com.dashboard.procurment.partSearch;

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

public class ClsPartSearchDAO {
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


	public JSONArray partSearch(HttpSession session,String type,String hidsbrand,String hidsmodel,
			String hidyom,String hidspec1,String hidspec2,String hidspec3,String hidbrand,String hidtype,String hidcat,
			String hidsubcat,String hidproduct,String branchid,String hidept,String suitid,String hidsubmodel) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String minyom="",maxyom="";
			String sql ="";
			//System.out.println("==hidsbrand==="+hidsbrand+"==hidsmodel=="+hidsmodel+"==hidyom==="+hidyom+"=hidspec1=="+hidspec1+"==hidspec2=="+hidspec2+"==hidspec3=="+hidspec3+"==hidbrand==="+hidbrand+"==hidcat==="+hidcat+"==hidsubcat=="+hidsubcat+"==hidproduct="+hidproduct);


			String sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="",sql10="",sql11="",sql12="",sql13="",sqlfinal="";

			if(!(hidsbrand.equals("0") || hidsbrand.equals("") || hidsbrand.equals("undefined"))){
				if(hidsbrand.equals("-1")){
					sql1="and vs.sbrandid in ("+hidsbrand+")";
				}
				else{
					sql1="and sb.doc_no in ("+hidsbrand+")";
				}

			}

			if(!(hidsmodel.equals("0") || hidsmodel.equals("") || hidsmodel.equals("undefined"))){
				if(hidsmodel.equals("-1")){
					sql2="and vs.smodelid in ("+hidsmodel+")";
				}
				else{
					sql2="and sm.doc_no in ("+hidsmodel+")";
				}
			}


			if(!(hidsubmodel.equals("0") || hidsmodel.equals("") || hidsubmodel.equals("undefined"))){
				if(hidsubmodel.equals("-1")){
					sql2="and vs.submodelid in ("+hidsubmodel+")";
				}
				else{
					sql2="and sbm.doc_no in ("+hidsubmodel+")";
				}
			}

			if(!(hidyom.equals("0") || hidyom.equals("") || hidyom.equals("undefined"))){

				if(hidyom.equals("-1")){
					sql3 ="and s.syomfrm_id in ("+hidyom+") or s.syomto_id in ("+hidyom+")";
				}
				else{
					String sqlyom="select min(yom) y1,max(yom) y2 from my_syom where doc_no in ("+hidyom+")"; 
					ResultSet rsyom=stmt.executeQuery(sqlyom);
					while(rsyom.next()){
						minyom=rsyom.getString("y1");
						maxyom=rsyom.getString("y2");
						//System.out.println("===minyom===="+minyom+"==maxyom==="+maxyom);
					}

					sql3="and str_to_date(y1.yom, '%Y')<=str_to_date("+maxyom+" , '%Y') and str_to_date(y2.yom, '%Y')>=str_to_date("+minyom+" , '%Y') ";
				}
			}
			if(!( hidspec1.equals("") || hidspec1.equals("undefined"))){
				if(hidspec1.equals("0") || hidspec1.equals("-1")){
					sql4="and vs.bsize1id in ("+hidspec1+")";
					sql4=sql4+" or vs.bsize2id in ("+hidspec1+")";
					sql4=sql4+" or vs.bsize3id in ("+hidspec1+")";
				}
				else{
					sql4=" and s11.doc_no in ("+hidspec1+")";
					sql4=sql4+" or s12.doc_no in ("+hidspec1+")";
					sql4=sql4+" or s13.doc_no in ("+hidspec1+")";
				}
			}

			if(!(hidspec2.equals("0") || hidspec2.equals("") || hidspec2.equals("undefined"))){
				if(hidspec2.equals("-1")){
					sql5="and s.spec2_id in ("+hidspec2+")";

				}
				else{
					sql5="and s2.doc_no in ("+hidspec2+")";

				}
			}

			if(!(hidspec3.equals("null") || hidspec3.equals("") || hidspec3.equals("undefined"))){
				if(hidspec3.equals("-1") || hidspec3.equals("0")){
					sql6="and vs.csize1id in ("+hidspec3+")";
					sql6=sql6+" or vs.csize2id in ("+hidspec3+")";
					sql6=sql6+" or vs.csize3id in ("+hidspec3+")";
				}
				else{
					sql6=" and s31.doc_no in ("+hidspec3+")";
					sql6=sql6+" or s32.doc_no in ("+hidspec3+")";
					sql6=sql6+" or s33.doc_no in ("+hidspec3+")";
				}
			}
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


			//System.out.println("===sqlfinal===="+sqlfinal);
			if(type.equalsIgnoreCase("1")){

				/* sql = "select  m.part_no product,m.productname pdesc,pt.producttype as type,b.brand as brand,c.category as cat,sc.subcategory as scat,"
					+ "case when s.sbrand_id=-1 then 'ALL' else sb.brand end  as sbrand,case when s.smodel_id=-1 then 'ALL' else sm.model end  as smodel,"
					+ "case when s.syomfrm_id=-1 then 'ALL' else y1.yom end as yomfrm,case when s.syomto_id=-1 then 'ALL' else y2.yom end as yomto,"
					+ "case when s.spec1_id=-1 then 'ALL' else s1.spec end as spec1,case when s.spec2_id=-1 then 'ALL' else s2.spec end as spec2,"
					+ "case when s.spec3_id=-1 then 'ALL' else s3.spec end as spec3,dep.department as dept from my_main m inner join my_desc d on(m.doc_no=d.psrno) left join my_prodsuit s on(m.doc_no=s.psrno) "
					+ "left join my_ptype pt on(m.typeid=pt.doc_no) left join my_brand b on(m.brandid=b.doc_no) left join my_dept dep on(dep.doc_no=m.deptid) left join my_catm c on(m.catid=c.doc_no) "
					+ "left join my_scatm sc on(m.scatid=sc.doc_no) left join my_sbrand sb  on(s.sbrand_id=sb.doc_no) left join my_smodel sm on(s.smodel_id=sm.doc_no) "
					+ "left join my_syom  y1 on(y1.doc_no=s.syomfrm_id) left join my_syom y2 on(y2.doc_no=s.syomto_id) left join my_suitspec1 s1 on(s1.doc_no=s.spec1_id) "
					+ "left join my_suitspec2 s2 on(s2.doc_no=s.spec2_id) "
					+ "left join my_suitspec3 s3 on(s3.doc_no=s.spec3_id) where m.status=3 "+sqlfinal+"";*/


				sql = "select  m.part_no product,m.productname pdesc,pt.producttype as type,b.brand as brand,c.category as cat,sc.subcategory as scat,"
						+ "case when vs.sbrandid=-1 then 'ALL' else sb.brand end  as sbrand,"
						+ "case when vs.smodelid=-1 then 'ALL' else sm.model end  as smodel,"
						+ "(case when vs.submodelid=-1 then 'ALL' else submodel end) as submodel,"
						+ "(case when vs.esizeid=-1 then 'ALL' else coalesce(s2.spec,'') end) as esize,"
						+ "(case when s.bsize1id=-1 then 'ALL' else coalesce(s11.spec,'') end) as bsize1,"
						+ "(case when s.bsize2id=-1 then 'ALL' else coalesce(s12.spec,'') end) as bsize2,"
						+ "(case when s.bsize3id=-1 then 'ALL' else coalesce(s13.spec,'') end) as bsize3,"
						+ "(case when s.csize1id=-1 then 'ALL' else coalesce(s31.spec,'') end) as csize1,"
						+ "(case when s.csize2id=-1 then 'ALL' else coalesce(s32.spec,'') end) as csize2,"
						+ "(case when s.csize3id=-1 then 'ALL' else coalesce(s33.spec,'') end) as csize3,"
						+ "case when s.syomfrm_id=-1 then 'ALL' else y1.yom end as yomfrm,"
						+ "case when s.syomto_id=-1 then 'ALL' else y2.yom end as yomto,"
						+ "br.branchname as branch,"
						+ "dep.department as dept from my_main m inner join my_desc d on(m.doc_no=d.psrno) "
						+ "left join my_prodsuit s on(m.doc_no=s.psrno) left join my_vehsuitmaster vs on(vs.doc_no=s.vehsuitid) "
						+ "left join my_ptype pt on(m.typeid=pt.doc_no) left join my_brand b on(m.brandid=b.doc_no) "
						+ "left join my_dept dep on(dep.doc_no=m.deptid) left join my_catm c on(m.catid=c.doc_no) "
						+ "left join my_scatm sc on(m.scatid=sc.doc_no) left join my_sbrand sb  on(vs.sbrandid=sb.doc_no) "
						+ "left join my_smodel sm on(vs.smodelid=sm.doc_no) "
						+ "left join my_syom  y1 on(y1.doc_no=s.syomfrm_id) left join my_syom y2 on(y2.doc_no=s.syomto_id) "
						+ "left join my_ssubmodel sbm on(sbm.doc_No=vs.submodelid) left join my_suitspec2 s2 on(s2.doc_no=vs.esizeid)"
						+ "left join my_suitspec1 s11 on(s11.doc_no=s.bsize1id)"
						+ "left join my_suitspec1 s12 on(s12.doc_no=s.bsize2id)"
						+ "left join my_suitspec1 s13 on(s13.doc_no=s.bsize3id)"
						+ "left join my_suitspec3 s31 on(s31.doc_no=s.csize1id)"
						+ "left join my_suitspec3 s32 on(s32.doc_no=s.csize2id)"
						+ "left join my_suitspec3 s33 on(s33.doc_no=s.csize3id)"
						+ "left join my_brch br on(br.doc_no=d.brhid)"
						+ "where m.status=3 "+sqlfinal+" group by m.doc_no ";

						System.out.println("==sql=type1==="+sql);

				ResultSet resultSet = stmt.executeQuery(sql);

			}
			else if(type.equalsIgnoreCase("2")){


				sql = "select  m.part_no product,m.productname pdesc,pt.producttype as type,b.brand as brand,c.category as cat,sc.subcategory as scat,"
						+ "case when vs.sbrandid=-1 then 'ALL' else sb.brand end  as sbrand,"
						+ "case when vs.smodelid=-1 then 'ALL' else sm.model end  as smodel,"
						+ "(case when vs.submodelid=-1 then 'ALL' else submodel end) as submodel,"
						+ "(case when vs.esizeid=-1 then 'ALL' else coalesce(s2.spec,'') end) as esize,"
						+ "(case when vs.bsize1id=-1 then 'ALL' else coalesce(s11.spec,'') end) as bsize1,"
						+ "(case when vs.bsize2id=-1 then 'ALL' else coalesce(s12.spec,'') end) as bsize2,"
						+ "(case when vs.bsize3id=-1 then 'ALL' else coalesce(s13.spec,'') end) as bsize3,"
						+ "(case when vs.csize1id=-1 then 'ALL' else coalesce(s31.spec,'') end) as csize1,"
						+ "(case when vs.csize2id=-1 then 'ALL' else coalesce(s32.spec,'') end) as csize2,"
						+ "(case when vs.csize3id=-1 then 'ALL' else coalesce(s33.spec,'') end) as csize3,"
						+ "case when s.syomfrm_id=-1 then 'ALL' else y1.yom end as yomfrm,"
						+ "case when s.syomto_id=-1 then 'ALL' else y2.yom end as yomto,"
						+ "br.branchname as branch,"
						+ "dep.department as dept from my_main m inner join my_desc d on(m.doc_no=d.psrno) "
						+ "left join my_prodsuit s on(m.doc_no=s.psrno) left join my_vehsuitmaster vs on(vs.doc_no=s.vehsuitid) "
						+ "left join my_ptype pt on(m.typeid=pt.doc_no) left join my_brand b on(m.brandid=b.doc_no) "
						+ "left join my_dept dep on(dep.doc_no=m.deptid) left join my_catm c on(m.catid=c.doc_no) "
						+ "left join my_scatm sc on(m.scatid=sc.doc_no) left join my_sbrand sb  on(vs.sbrandid=sb.doc_no) "
						+ "left join my_smodel sm on(vs.smodelid=sm.doc_no) "
						+ "left join my_syom  y1 on(y1.doc_no=s.syomfrm_id) left join my_syom y2 on(y2.doc_no=s.syomto_id) "
						+ "left join my_ssubmodel sbm on(sbm.doc_No=vs.submodelid) left join my_suitspec2 s2 on(s2.doc_no=vs.esizeid)"
						+ "left join my_suitspec1 s11 on(s11.doc_no=vs.bsize1id)"
						+ "left join my_suitspec1 s12 on(s12.doc_no=vs.bsize2id)"
						+ "left join my_suitspec1 s13 on(s13.doc_no=vs.bsize3id)"
						+ "left join my_suitspec3 s31 on(s31.doc_no=vs.csize1id)"
						+ "left join my_suitspec3 s32 on(s32.doc_no=vs.csize2id)"
						+ "left join my_suitspec3 s33 on(s33.doc_no=vs.csize3id)"
						+ "left join my_brch br on(br.doc_no=d.brhid)"
						+ "where m.status=3 and vs.doc_no in("+suitid+") group by m.doc_no ";

				System.out.println("==sql=type2==="+sql);

				ResultSet resultSet = stmt.executeQuery(sql);
			}
			

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


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

			System.out.println("=sql==suitSearch="+sql);

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
