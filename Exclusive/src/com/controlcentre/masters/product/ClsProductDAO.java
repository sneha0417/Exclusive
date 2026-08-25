package com.controlcentre.masters.product;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
public class ClsProductDAO {
	ClsProductBean proact= new ClsProductBean();
	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();
	 
	public JSONArray ssedingLoad(HttpSession session,String psrno) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

 
			String sql="select part_no,priority,if(discontinued=1,true,false) discontinued  FROM  my_prdsuperseding where psrno='"+psrno+"'   ";
 
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	 
	
	public JSONArray prdbranchLoad(HttpSession session,String chktype) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			 
		 
        if(chktype.equalsIgnoreCase("2"))
        {
		 	String sql="select  BRANCHNAME branch,doc_no bdocno from my_brch where status=3";
			
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt.close();
        }
        
        else 
        {
        	String sql="select company branch,doc_no bdocno from my_comp where status=3";
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt.close();
        	
        	
        }

		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray prdbranchLoad(HttpSession session,String docno,String chktype) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			//String sql="select 1 as selects,b.BRANCHNAME branch,b.doc_no bdocno,d.discontinued,d.bin as bin,d.minStock as minstock,d.maxStock as maxstock,d.price1 as retailprice,d.price2 as wholesale,d.price3 as normal from my_brch b left join my_desc d on(d.brhid=b.doc_no) where d.psrno='"+docno+"'";
			  if(chktype.equalsIgnoreCase("2"))
		        {
			String sql="select selects, branch,bdocno,discontinued,bin, minstock,maxstock,"
					+ "retailprice,wholesale,normal,reorderlevel,reorderqty from (select 1 as selects,b.BRANCHNAME branch,"
					+ "b.doc_no bdocno,d.discontinued,d.bin as bin,d.minStock as minstock,d.maxStock as maxstock,"
					+ "d.price1 as retailprice,d.price2 as wholesale,d.price3 as normal,d.reorderlevel,d.reorderqty from my_brch b left join my_desc d "
					+ "on(d.brhid=b.doc_no) where d.psrno='"+docno+"' union all "
					+ "select 0 as selects,b.BRANCHNAME branch,b.doc_no bdocno,0 as discontinued,'' as bin,"
					+ "0 as minstock,0 as maxstock,0 as retailprice,0 as wholesale,0 as normal,0 reorderlevel,0 reorderqty "
					+ " from my_brch b where b.doc_no not in(select brhid from my_desc where psrno='"+docno+"')) as a";
			
		//	System.out.println("===prdbranchLoadwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww===2=="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
		        }
			  else
			  {
					String sql="select selects, branch,bdocno,discontinued,bin, minstock,maxstock,"
							+ "retailprice,wholesale,normal,reorderlevel,reorderqty from (select 1 as selects,b.COMPANY branch,"
							+ "b.doc_no bdocno,d.discontinued,d.bin as bin,d.minStock as minstock,d.maxStock as maxstock,"
							+ "d.price1 as retailprice,d.price2 as wholesale,d.price3 as normal,d.reorderlevel,d.reorderqty from my_comp b left join my_desc d "
							+ "on(d.cmpid=b.doc_no) where d.psrno='"+docno+"' union all "
							+ "select 0 as selects,b.COMPANY branch,b.doc_no bdocno,0 as discontinued,'' as bin,0 as minstock"
							+ ",0 as maxstock,0 as retailprice,0 as wholesale,0 as normal,0 reorderlevel,0 reorderqty "
							+ " from my_comp b where b.doc_no not in(select cmpid from my_desc where psrno='"+docno+"')) as a";
					
		//		System.out.println("===prdbranchLoad===sadfffasddfffffffffffffffffffffffffffffffffffffffffffffffffffff1="+sql);
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
	
	
	public JSONArray pmLoad(HttpSession session,String psrno) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			//String sql="select 1 as selects,b.BRANCHNAME branch,b.doc_no bdocno,d.discontinued,d.bin as bin,d.minStock as minstock,d.maxStock as maxstock,d.price1 as retailprice,d.price2 as wholesale,d.price3 as normal from my_brch b left join my_desc d on(d.brhid=b.doc_no) where d.psrno='"+docno+"'";
			
/*			String sql="select  p.catid,  p.price1, p.price2, p.price3, p.discount1, p.discount2, p.discount3, p.foc1, p.foc2, p.foc3,c.cat_name from my_descpr p "
					+ " left join my_clcatm c on p.catid=c.doc_no where psrno='"+psrno+"' ";*/
			
			String sql="select  convert(p.catid,char(100)) catid, convert(if(p.price1=0,'',p.price1),char(100)) price1,convert(if(p.price2=0,'',p.price2),char(100)) price2,convert(if(p.price3=0,'',p.price3),char(100)) price3, "
					+ " convert(if(p.discount1=0,'',p.discount1),char(100)) discount1,convert(if(p.discount2=0,'',p.discount2),char(100)) discount2,convert(if(p.discount3=0,'',p.discount3),char(100)) discount3, "
					+ " convert(if(p.foc1=0,'',p.foc1),char(100)) foc1, convert(if(p.foc2=0,'',p.foc2),char(100)) foc2,convert(if(p.foc3=0,'',p.foc3),char(100)) foc3, "
					+ " convert(if(p.qty1=0,'',p.qty1),char(100)) qty1,convert(if(p.qty2=0,'',p.qty2),char(100))  qty2,convert(if(p.qty3=0,'',p.qty3),char(100)) qty3,c.cat_name from my_descpr p left join my_clcatm c on p.catid=c.doc_no where psrno='"+psrno+"' and c.dtype='CRM' "
							+ "	union all select convert(doc_no,char(100)) catid,  '' price1, '' price2, '' price3, '' discount1,'' discount2, '' discount3, "
							+ "	'' foc1, '' foc2, '' foc3,'' qty1,'' qty2,'' qty3, cat_name from my_clcatm 	where doc_no not in(select catid from my_descpr where psrno='"+psrno+"' )   and dtype='CRM' ";
			
					
		// System.out.println("==ss==ass=="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray pmLoad() throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			//String sql="select 1 as selects,b.BRANCHNAME branch,b.doc_no bdocno,d.discontinued,d.bin as bin,d.minStock as minstock,d.maxStock as maxstock,d.price1 as retailprice,d.price2 as wholesale,d.price3 as normal from my_brch b left join my_desc d on(d.brhid=b.doc_no) where d.psrno='"+docno+"'";
			
			String sql="select doc_no catid,cat_name,category from my_clcatm where status=3 and dtype='CRM' ";
					
	 //	System.out.println("==ss111111111111111111111111111==="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	public JSONArray prduomLoad(HttpSession session,String docno) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select m.doc_no as unitid,m.unit,fr,wt weight,volume volumn,thk thickness,leng len,width width from my_unit u left join my_unitm m on(u.unit=m.doc_no) where psrno='"+docno+"'";
			//System.out.println("===prduomLoad====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray prdsuitLoad(HttpSession session,String docno) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			/*String sql="select coalesce(sb.doc_no,-1) brandid,case when s.sbrand_id=-1 then 'ALL' else sb.brand end as brand,coalesce(sm.doc_no,-1) as modelid"
					+ ",case when s.smodel_id=-1 then 'ALL' else sm.model end as model,case when s.syomfrm_id=-1 then 'ALL' else y1.yom end as  yomfrm"
					+ ",coalesce(y1.doc_no,-1) as yomfrmid,case when s.syomto_id=-1 then 'ALL' else y2.yom end as yomto,coalesce(y2.doc_no,-1) as yomtoid,"
					+ "case when s.spec1_id=-1 then 'ALL' else s1.spec end as spec1,coalesce(s1.doc_no,-1) spec1id,case when s.spec2_id=-1 then 'ALL' else s2.spec end  as spec2"
					+ ",coalesce(s2.doc_no,-1)  spec2id,case when s.spec3_id=-1 then 'ALL' else s3.spec end  as spec3,coalesce(s3.doc_no,-1) spec3id,"
					+ "case when s.submodelid=-1 then 'ALL' else sub.submodel end as submodel,coalesce(sub.doc_no,-1) as submodelid from my_prodsuit s left join my_sbrand sb  "
					+ "on(s.sbrand_id=sb.doc_no) left join my_smodel sm on(s.smodel_id=sm.doc_no) left join my_syom  y1 "
					+ "on(y1.doc_no=s.syomfrm_id) left join my_syom y2 on(y2.doc_no=s.syomto_id) left join my_suitspec1 s1 "
					+ "on(s1.doc_no=s.spec1_id) left join my_suitspec2 s2 on(s2.doc_no=s.spec2_id) left join my_suitspec3 s3 "
					+ "on(s3.doc_no=s.spec3_id) left join my_ssubmodel sub on(s.submodelid=sub.doc_no) where psrno='"+docno+"'";*/

			
			if(docno.equalsIgnoreCase(""))
			{
				docno="0";
			}
			
			String sql="select s.doc_no,sf.yom yomfrm,st.yom yomto,s.doc_no,brand,(case when s.smodelid=-1 then 'ALL' else model end) as model,"
					+ "(case when s.submodelid=-1 then 'ALL' else submodel end) as submodel,"
					+ "(case when s.esizeid=-1 then 'ALL' else coalesce(s2.spec,'') end) as esize,"
					+ "(case when sp.bsize1id=-1 then 'ALL' else coalesce(s11.spec,'') end) as bsize1,"
					+ "(case when sp.bsize2id=-1 then 'ALL' else coalesce(s12.spec,'') end) as bsize2,"
					+ "(case when sp.bsize3id=-1 then 'ALL' else coalesce(s13.spec,'') end) as bsize3,"
					+ "(case when sp.csize1id=-1 then 'ALL' else coalesce(s31.spec,'') end) as csize1,"
					+ "(case when sp.csize2id=-1 then 'ALL' else coalesce(s32.spec,'') end) as csize2,"
					+ "(case when sp.csize3id=-1 then 'ALL' else coalesce(s33.spec,'') end) as csize3,"
					+ "s.sbrandid brandid,s.smodelid modelid,s.submodelid submodelid,s.esizeid,sp.bsize1id,sp.bsize2id,sp.bsize3id,"
					+ "sp.csize1id,sp.csize2id,sp.csize3id,sf.doc_no yomfrmid,st.doc_no yomtoid  "
					+ "from my_prodsuit sp left join  my_vehsuitmaster s on(s.doc_no=sp.vehsuitid)"
					+ " left join my_sbrand b on(b.doc_no=s.sbrandid) left join my_smodel m on(m.doc_no=s.smodelid)"
					+ "left join my_ssubmodel sm on(sm.doc_No=s.submodelid and sm.modelid=s.smodelid) left join my_suitspec2 s2 on(s2.doc_no=s.esizeid)" //and sm.modelid=s.smodelid
					+ "left join my_suitspec1 s11 on(s11.doc_no=sp.bsize1id)"
					+ "left join my_suitspec1 s12 on(s12.doc_no=sp.bsize2id)"
					+ "left join my_suitspec1 s13 on(s13.doc_no=sp.bsize3id)"
					+ "left join my_suitspec3 s31 on(s31.doc_no=sp.csize1id)"
					+ "left join my_suitspec3 s32 on(s32.doc_no=sp.csize2id)"
					+ "left join my_suitspec3 s33 on(s33.doc_no=sp.csize3id)"
					+ "left join my_syom sf on(sf.doc_no=sp.syomfrm_id)"
					+ "left join my_syom st on(st.doc_no=sp.syomto_id)"
					+ "where s.status=3 and sp.psrno in ("+docno+")";
			
			
		//	System.out.println("===prdsuitLoad====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray suitSpecload(HttpSession session,String stype,String spec1id,String spec2id,String spec3id) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			 String sql="";
			if(stype.equalsIgnoreCase("1")){
			
				 sql="select s.doc_no spec1id, spec spec1,brand,(case when s.modelid=-1 then 'ALL' else model end) as model,(case when s.submodelid=-1 then 'ALL' else submodel end) as submodel,s.brandid,s.modelid,s.submodelid from my_suitspec1 s left join my_sbrand b "
						+ "on(b.doc_no=s.brandid) left join my_smodel m on(m.doc_no=s.modelid) left join my_ssubmodel "
						+ "sm on(sm.doc_No=s.submodelid) where s.doc_no in("+spec1id+") and s.status=3";

			}
			
			if(stype.equalsIgnoreCase("2")){
				
				 sql="select s.doc_no spec1id, s.spec spec1,s1.doc_no spec2id, s1.spec spec2,brand,(case when s.modelid=-1 then 'ALL' else model end) as model,(case when s.submodelid=-1 then 'ALL' else submodel end) as submodel,s.brandid,s.modelid,s.submodelid from my_suitspec1 s left join my_sbrand b "
						+ "on(b.doc_no=s.brandid) left join my_smodel m on(m.doc_no=s.modelid) left join my_ssubmodel "
						+ "sm on(sm.doc_No=s.submodelid) left join my_suitspec2 s1 on(s1.submodelid=sm.doc_no) where s.doc_no in("+spec1id+") and s1.doc_no in("+spec2id+") and s.status=3";

			}
			
			if(stype.equalsIgnoreCase("3")){
				
				 sql="select s.doc_no spec1id, s.spec spec1,s1.doc_no spec2id, s1.spec spec2,s2.doc_no spec3id, s2.spec spec3,brand,(case when s.modelid=-1 then 'ALL' else model end) as model,(case when s.submodelid=-1 then 'ALL' else submodel end) as submodel,s.brandid,s.modelid,s.submodelid from my_suitspec1 s left join my_sbrand b "
						+ "on(b.doc_no=s.brandid) left join my_smodel m on(m.doc_no=s.modelid) left join my_ssubmodel "
						+ "sm on(sm.doc_No=s.submodelid) left join my_suitspec2 s1 on(s1.submodelid=sm.doc_no) left join my_suitspec3 s2 on(s2.submodelid=sm.doc_no) where s.doc_no in("+spec1id+") and s1.doc_no in("+spec2id+") and s2.doc_no in("+spec3id+") and s.status=3";

			}
			
//
		//	System.out.println("==sql==suitSpecload=="+sql);
			
			ResultSet resultSet = stmt.executeQuery(sql);
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


	public JSONArray unitSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
int method=0;
			String sqlss="select method from GL_PRDCONFIG where field_nme='multiqty' ";
			ResultSet rss=stmt.executeQuery(sqlss);
			if(rss.next())
			{
				method=rss.getInt("method");
			}
			
			String sql="select "+method+" method, doc_no,unit,unit_desc from my_unitm where status=3";

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

			String sql = "select department, doc_no from my_dept where status<>7";

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

			String sql="select doc_no,type ptype from my_stype where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}


	public JSONArray typeFormSearch(HttpSession session) throws SQLException {


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

	public JSONArray modelSearch(HttpSession session,String brandid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			//String sql="select m.doc_no,model,brand from my_smodel m left join my_sbrand b on(m.brandid=b.doc_no) where b.status=3 and m.status=3 and m.brandid='"+brandid+"'";
			String sql="select convert(doc_no,char(50)) as doc_no,model,brand from ( select m.doc_no,model,brand from my_smodel m left join my_sbrand b on(m.brandid=b.doc_no) where b.status=3 and m.status=3 and m.brandid='"+brandid+"' union all select '-1','ALL','') as a";
			/*System.out.println("===modelSearch===="+sql);*/
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray subModelSearch(HttpSession session,String modelid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			//String sql="select m.doc_no,model,brand from my_smodel m left join my_sbrand b on(m.brandid=b.doc_no) where b.status=3 and m.status=3 and m.brandid='"+brandid+"'";
			String sql="select convert(doc_no,char(50)) as doc_no,submodel,model from ( select m.doc_no,submodel,model from my_ssubmodel m left join my_smodel mo on(m.modelid=mo.doc_no) where mo.status=3 and m.status=3 and m.modelid='"+modelid+"' union all select '-1','ALL','') as a";
		//	System.out.println("===subModelSearch===="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray brandSearch(HttpSession session) throws SQLException {


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

	public JSONArray brandFormSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select doc_no,brandname brand from my_brand where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray yomSearch(HttpSession session,String type,String yomfrm,String yomto,String suitrows) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql="";
			String sqlappend="";
		if(!(yomfrm.equalsIgnoreCase("ALL")|| yomfrm.equalsIgnoreCase("") || yomfrm.equalsIgnoreCase("undefined") ) ){
				sqlappend=sqlappend+" and date_format(str_to_date(yom,'%Y'),'%Y')>="+yomfrm+" ";
			}
			
			if(!(yomto.equalsIgnoreCase("ALL") || yomto.equalsIgnoreCase("") || yomto.equalsIgnoreCase("undefined") )){
				sqlappend=sqlappend+" and date_format(str_to_date(yom,'%Y'),'%Y')<="+yomto+"";
			}
			
			if(Integer.parseInt(suitrows)<=0){
				if(type.equalsIgnoreCase("frm")){
					sql="select convert(doc_no,char(50)) as doc_no,yom from ( select doc_no,yom from my_syom where status=3 union all select '-1','ALL' union all select '-2','' ) as a order by yom ";
				
					//System.out.println("==sql==1=="+sql);
				
				}
				else if(type.equalsIgnoreCase("to")){
					sql="select convert(doc_no,char(50)) as doc_no,yom from ( select doc_no,yom from my_syom where status=3 and date_format(str_to_date(yom,'%Y'),'%Y')>="+yomfrm+" union all select '-1','ALL' union all select '-2','') as a where 1=1  order by yom ";/*date_format(str_to_date(yom,'%Y'),'%Y')>="+yomfrm+"*/
				
					//System.out.println("==sql==2=="+sql);
				}
			}
			else if(Integer.parseInt(suitrows)>0){
				
					sql="select convert(doc_no,char(50)) as doc_no,yom from ( select doc_no,yom from my_syom where status=3 "+sqlappend+" union all select '-1','ALL' union all select '-2','') as a where 1=1  order by yom ";
					//System.out.println("==sql==3=="+sql);
			}
			
			//System.out.println("==sql===="+sql);

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray suitSpec1Search(HttpSession session,String submodelid,String brandid,String modelid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select convert(doc_no,char(50)) as doc_no,spec from ( select s.doc_no,spec from "
					+ "my_suitspec1 s left join my_sbrand sb on(sb.doc_no=s.brandid) left join my_smodel sm on(sm.doc_no=s.modelid) left join my_ssubmodel m on(m.doc_no=s.submodelid) where "
					+ "m.doc_no='"+submodelid+"' and sb.doc_no='"+brandid+"' and sm.doc_no='"+modelid+"'  and s.status=3 union all select '-1','ALL') as a";

			
		//	System.out.println("=sql==="+sql);
			
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	


	public JSONArray suitSpec2Search(HttpSession session,String submodelid,String brandid,String modelid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select convert(doc_no,char(50)) as doc_no,spec from ( select s.doc_no,spec from "
					+ "my_suitspec2 s left join my_sbrand sb on(sb.doc_no=s.brandid) left join my_smodel sm on(sm.doc_no=s.modelid) left join my_ssubmodel m on(m.doc_no=s.submodelid) where "
					+ "m.doc_no='"+submodelid+"' and sb.doc_no='"+brandid+"' and sm.doc_no='"+modelid+"'  and s.status=3 union all select '-1','ALL') as a";

			System.out.println("=sql==2="+sql);
			
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}


	public JSONArray suitSpec3Search(HttpSession session,String submodelid,String brandid,String modelid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select convert(doc_no,char(50)) as doc_no,spec from ( select s.doc_no,spec from "
					+ "my_suitspec3 s left join my_sbrand sb on(sb.doc_no=s.brandid) left join my_smodel sm on(sm.doc_no=s.modelid) left join my_ssubmodel m on(m.doc_no=s.submodelid) where "
					+ "m.doc_no='"+submodelid+"' and sb.doc_no='"+brandid+"' and sm.doc_no='"+modelid+"'  and s.status=3 union all select '-1','ALL') as a";

		//	System.out.println("=sql==3="+sql);
			
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray catFormSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select category,doc_no  from my_catm where status <> 7";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray subCatFormSearch(HttpSession session,String catid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "select subcategory,doc_no  from my_scatm where status <>7 and catid="+catid+"";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public int insert(java.sql.Date date,String pname,String pcode,String pbarcode,String ptype,String pbrand,String pcat,
			String psubcat,String unit,String dept,String mode,String dtype,ArrayList prodarray,ArrayList uomarray,ArrayList suitarray,
			ArrayList specarray,HttpSession session,int comp_brach, ArrayList<String> pmgntarray, int cmbstar, int cmbmastertype,
			String arabicprdname,ArrayList ssarray,String desc1) throws SQLException{


		Connection conn=null;
		int pdocno=0;
		conn=ClsConnection.getMyConnection();
		try{
			
  
  
  
			conn.setAutoCommit(false);

			CallableStatement stmt = conn.prepareCall("{CALL productDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");


			stmt.registerOutParameter(15, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			stmt.setString(2,pname);
			stmt.setString(3,pcode);
			stmt.setString(4, pbarcode);
			stmt.setInt(5, Integer.parseInt(ptype));
			stmt.setInt(6, Integer.parseInt(pbrand));
			stmt.setInt(7, Integer.parseInt(pcat));
			stmt.setInt(8, Integer.parseInt(psubcat));
			stmt.setInt(9, Integer.parseInt(unit));
			stmt.setInt(10, Integer.parseInt(dept));
			stmt.setString(11, mode);
			stmt.setString(12, dtype);
			stmt.setString(13, session.getAttribute("USERID").toString());
			stmt.setString(14, session.getAttribute("BRANCHID").toString());
			int val = stmt.executeUpdate();
			pdocno=stmt.getInt("pdocno");


			if (pdocno > 0) {
				
				String sqls4="update my_main set prdname='"+arabicprdname+"',star='"+cmbstar+"',mtypeid='"+cmbmastertype+"',desc1='"+desc1+"' where doc_no='"+pdocno+"'";
				System.out.println("======sqls4=="+sqls4);
				
				stmt.executeUpdate(sqls4);
				
				
				int branchper=0;
				
				if(comp_brach==1)
				{
					String sqls="update my_main set comp_brch='C' where doc_no='"+pdocno+"'";
					stmt.executeUpdate(sqls);
				}
				else if(comp_brach==2)
				{
					String sqls="update my_main set comp_brch='B' where doc_no='"+pdocno+"'";
					stmt.executeUpdate(sqls);
				}
				
				
				if(pbarcode.equalsIgnoreCase("") || pbarcode==null)
				{
					String sqls="update my_main set barcode='"+pdocno+"' where doc_no='"+pdocno+"'";
					stmt.executeUpdate(sqls);
				}
				
				
				
				for(int i=0;i< prodarray.size();i++){
					String[] prod=((String) prodarray.get(i)).split("::");
					if(!((prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()))){

						if(comp_brach==2)
						{
						String sql="INSERT INTO my_desc(psrno, brhid,bin, minStock, maxStock, PRICE1, PRICE2, PRICE3,discontinued,reorderlevel,reorderqty)VALUES"
								+ " ('"+pdocno+"',"
								+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
								+ "'"+(prod[3].trim().equalsIgnoreCase("undefined")  || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"',"
								+ "'"+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"',"
								+ "'"+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"',"
								+ "'"+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
								+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
								+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"',"
								+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"', "
								+ "'"+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].isEmpty()?0:prod[9].trim())+"',"
								+ "'"+(prod[10].trim().equalsIgnoreCase("undefined") || prod[10].trim().equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"')";



						System.out.println("branchper--->>>>Sql"+sql);
						branchper = stmt.executeUpdate (sql);
						}
						
						else if(comp_brach==1)
						{
							String sql="INSERT INTO my_desc(psrno, cmpid,bin, minStock, maxStock, PRICE1, PRICE2, PRICE3,discontinued,reorderlevel,reorderqty)VALUES"
									+ " ('"+pdocno+"',"
									+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
									+ "'"+(prod[3].trim().equalsIgnoreCase("undefined")  || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"',"
									+ "'"+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"',"
									+ "'"+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"',"
									+ "'"+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
									+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
									+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"',"
									+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"' ,"
									+ "'"+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].isEmpty()?0:prod[9].trim())+"',"
									+ "'"+(prod[10].trim().equalsIgnoreCase("undefined") || prod[10].trim().equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"')";



							//System.out.println("branchper--->>>>Sql"+sql);
							branchper = stmt.executeUpdate (sql);
						}
					 
					}

				}

				
				
				
				
				
				
				
				
				
				for(int i=0;i< ssarray.size();i++){
					String[] ssarr=((String) ssarray.get(i)).split("::");
					
					if(!((ssarr[0].trim().equalsIgnoreCase("undefined") || ssarr[0].trim().equalsIgnoreCase("0") || ssarr[0].trim().equalsIgnoreCase("") || ssarr[0].trim().equalsIgnoreCase("NaN")|| ssarr[0].isEmpty()))){

					
					
				     String sql="INSERT INTO my_prdsuperseding(sr_no,psrno,part_no,priority,discontinued)VALUES"
						       + " ("+(i+1)+","
						       + " '"+pdocno+"',"
						       + "'"+(ssarr[0].trim().equalsIgnoreCase("undefined") || ssarr[0].trim().equalsIgnoreCase("NaN")|| ssarr[0].trim().equalsIgnoreCase("")|| ssarr[0].isEmpty()?0:ssarr[0].trim())+"',"
						       + "'"+(ssarr[1].trim().equalsIgnoreCase("undefined") || ssarr[1].trim().equalsIgnoreCase("NaN")|| ssarr[1].trim().equalsIgnoreCase("")|| ssarr[1].isEmpty()?0:ssarr[1].trim())+"',"
						       + "'"+(ssarr[2].trim().equalsIgnoreCase("undefined") || ssarr[2].trim().equalsIgnoreCase("NaN")|| ssarr[2].trim().equalsIgnoreCase("")|| ssarr[2].isEmpty()?0:ssarr[2].trim())+"' )";
			 	     int resultSet2 = stmt.executeUpdate(sql);
					     if(resultSet2<=0)
							{
								conn.close();
								return 0;
								
							}
					}
					
					
										}
				
				
				
				
				for(int i=0;i< pmgntarray.size();i++){
					String[] pmgntarr=((String) pmgntarray.get(i)).split("::");
		
					
 
					 if((!(pmgntarr[1].trim().equalsIgnoreCase("undefined") || pmgntarr[1].trim().equalsIgnoreCase("") || pmgntarr[1].trim().equalsIgnoreCase("NaN")|| pmgntarr[1].trim().isEmpty())) 
					   || (!(pmgntarr[2].trim().equalsIgnoreCase("undefined") || pmgntarr[2].trim().equalsIgnoreCase("") || pmgntarr[2].trim().equalsIgnoreCase("NaN")|| pmgntarr[2].trim().isEmpty()))
					  ||  (!(pmgntarr[3].trim().equalsIgnoreCase("undefined") || pmgntarr[3].trim().equalsIgnoreCase("") || pmgntarr[3].trim().equalsIgnoreCase("NaN")|| pmgntarr[3].trim().isEmpty()))
					   ||  (!(pmgntarr[4].trim().equalsIgnoreCase("undefined") || pmgntarr[4].trim().equalsIgnoreCase("") || pmgntarr[4].trim().equalsIgnoreCase("NaN")|| pmgntarr[4].trim().isEmpty()))
					  ||  (!(pmgntarr[5].trim().equalsIgnoreCase("undefined") || pmgntarr[5].trim().equalsIgnoreCase("") || pmgntarr[5].trim().equalsIgnoreCase("NaN")|| pmgntarr[5].trim().isEmpty()))
					  ||  (!(pmgntarr[6].trim().equalsIgnoreCase("undefined") || pmgntarr[6].trim().equalsIgnoreCase("") || pmgntarr[6].trim().equalsIgnoreCase("NaN")|| pmgntarr[6].trim().isEmpty()))
					  ||  (!(pmgntarr[7].trim().equalsIgnoreCase("undefined") || pmgntarr[7].trim().equalsIgnoreCase("") || pmgntarr[7].trim().equalsIgnoreCase("NaN")|| pmgntarr[7].trim().isEmpty()))
					  ||  (!(pmgntarr[8].trim().equalsIgnoreCase("undefined") || pmgntarr[8].trim().equalsIgnoreCase("") || pmgntarr[8].trim().equalsIgnoreCase("NaN")|| pmgntarr[8].trim().isEmpty()))
					  ||  (!(pmgntarr[9].trim().equalsIgnoreCase("undefined") || pmgntarr[9].trim().equalsIgnoreCase("") || pmgntarr[9].trim().equalsIgnoreCase("NaN")|| pmgntarr[9].trim().isEmpty()))
					   ||  (!(pmgntarr[10].trim().equalsIgnoreCase("undefined") || pmgntarr[10].trim().equalsIgnoreCase("") || pmgntarr[10].trim().equalsIgnoreCase("NaN")|| pmgntarr[10].trim().isEmpty()))
					   ||  (!(pmgntarr[11].trim().equalsIgnoreCase("undefined") || pmgntarr[11].trim().equalsIgnoreCase("") || pmgntarr[11].trim().equalsIgnoreCase("NaN")|| pmgntarr[11].trim().isEmpty()))
					  ||  (!(pmgntarr[12].trim().equalsIgnoreCase("undefined") || pmgntarr[12].trim().equalsIgnoreCase("") || pmgntarr[12].trim().equalsIgnoreCase("NaN")|| pmgntarr[12].trim().isEmpty()))){
					
 
			     String sql="INSERT INTO my_descpr(sr_no,psrno, catid,  price1, price2, price3, discount1, discount2, discount3, foc1, foc2, foc3,qty1,qty2,qty3)VALUES"
					       + " ("+(i+1)+","
					       + " '"+pdocno+"',"
					       + "'"+(pmgntarr[0].trim().equalsIgnoreCase("undefined") || pmgntarr[0].trim().equalsIgnoreCase("NaN")|| pmgntarr[0].trim().equalsIgnoreCase("")|| pmgntarr[0].isEmpty()?0:pmgntarr[0].trim())+"',"
					       + "'"+(pmgntarr[1].trim().equalsIgnoreCase("undefined") || pmgntarr[1].trim().equalsIgnoreCase("NaN")|| pmgntarr[1].trim().equalsIgnoreCase("")|| pmgntarr[1].isEmpty()?0:pmgntarr[1].trim())+"',"
					       + "'"+(pmgntarr[2].trim().equalsIgnoreCase("undefined") || pmgntarr[2].trim().equalsIgnoreCase("NaN")|| pmgntarr[2].trim().equalsIgnoreCase("")|| pmgntarr[2].isEmpty()?0:pmgntarr[2].trim())+"',"
					       + "'"+(pmgntarr[3].trim().equalsIgnoreCase("undefined") || pmgntarr[3].trim().equalsIgnoreCase("NaN")||pmgntarr[3].trim().equalsIgnoreCase("")|| pmgntarr[3].isEmpty()?0:pmgntarr[3].trim())+"',"
					       + "'"+(pmgntarr[4].trim().equalsIgnoreCase("undefined") || pmgntarr[4].trim().equalsIgnoreCase("NaN")|| pmgntarr[4].trim().equalsIgnoreCase("")|| pmgntarr[4].isEmpty()?0:pmgntarr[4].trim())+"',"
					       + "'"+(pmgntarr[5].trim().equalsIgnoreCase("undefined") || pmgntarr[5].trim().equalsIgnoreCase("NaN")||pmgntarr[5].trim().equalsIgnoreCase("")|| pmgntarr[5].isEmpty()?0:pmgntarr[5].trim())+"',"
					       + "'"+(pmgntarr[6].trim().equalsIgnoreCase("undefined") || pmgntarr[6].trim().equalsIgnoreCase("NaN")||pmgntarr[6].trim().equalsIgnoreCase("")|| pmgntarr[6].isEmpty()?0:pmgntarr[6].trim())+"',"
					       + "'"+(pmgntarr[7].trim().equalsIgnoreCase("undefined") || pmgntarr[7].trim().equalsIgnoreCase("NaN")||pmgntarr[7].trim().equalsIgnoreCase("")|| pmgntarr[7].isEmpty()?0:pmgntarr[7].trim())+"',"
					       + "'"+(pmgntarr[8].trim().equalsIgnoreCase("undefined") || pmgntarr[8].trim().equalsIgnoreCase("NaN")||pmgntarr[8].trim().equalsIgnoreCase("")|| pmgntarr[8].isEmpty()?0:pmgntarr[8].trim())+"',"
					       + "'"+(pmgntarr[9].trim().equalsIgnoreCase("undefined") || pmgntarr[9].trim().equalsIgnoreCase("NaN")||pmgntarr[9].trim().equalsIgnoreCase("")|| pmgntarr[9].isEmpty()?0:pmgntarr[9].trim())+"',"
			               + "'"+(pmgntarr[10].trim().equalsIgnoreCase("undefined") || pmgntarr[10].trim().equalsIgnoreCase("NaN")||pmgntarr[10].trim().equalsIgnoreCase("")|| pmgntarr[10].isEmpty()?0:pmgntarr[10].trim())+"',"
			               + "'"+(pmgntarr[11].trim().equalsIgnoreCase("undefined") || pmgntarr[11].trim().equalsIgnoreCase("NaN")||pmgntarr[11].trim().equalsIgnoreCase("")|| pmgntarr[11].isEmpty()?0:pmgntarr[11].trim())+"',"
			               + "'"+(pmgntarr[12].trim().equalsIgnoreCase("undefined") || pmgntarr[12].trim().equalsIgnoreCase("NaN")||pmgntarr[12].trim().equalsIgnoreCase("")|| pmgntarr[12].isEmpty()?0:pmgntarr[12].trim())+"')";
			    
				
		 	     int resultSet2 = stmt.executeUpdate(sql);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
					     
					}
			            	}
				
				
				int unitdesc=0;

				for(int i=0;i< uomarray.size();i++){
					String[] uomarr=((String) uomarray.get(i)).split("::");
					if(!((uomarr[0].equalsIgnoreCase("undefined") || uomarr[0].equalsIgnoreCase("") || uomarr[0].trim().equalsIgnoreCase("NaN")|| uomarr[0].isEmpty()))){


						String sql="INSERT INTO my_unit(PSRNO, UNIT, FR, wt, VOLUME, thk, leng, width)VALUES"
								+ " ('"+pdocno+"',"
								+ "'"+(uomarr[0].equalsIgnoreCase("undefined") || uomarr[0].equalsIgnoreCase("") || uomarr[0].trim().equalsIgnoreCase("NaN")|| uomarr[0].isEmpty()?0:uomarr[0].trim())+"',"
								+ "'"+(uomarr[1].trim().equalsIgnoreCase("undefined")  || uomarr[1].trim().equalsIgnoreCase("") || uomarr[1].trim().equalsIgnoreCase("NaN")|| uomarr[1].isEmpty()?0:uomarr[1].trim())+"',"
								+ "'"+(uomarr[2].trim().equalsIgnoreCase("undefined") || uomarr[2].trim().equalsIgnoreCase("") || uomarr[2].trim().equalsIgnoreCase("NaN")|| uomarr[2].isEmpty()?0:uomarr[2].trim())+"',"
								+ "'"+(uomarr[3].trim().equalsIgnoreCase("undefined") || uomarr[3].trim().equalsIgnoreCase("") || uomarr[3].trim().equalsIgnoreCase("NaN")|| uomarr[3].isEmpty()?0:uomarr[3].trim())+"',"
								+ "'"+(uomarr[4].trim().equalsIgnoreCase("undefined") || uomarr[4].trim().equalsIgnoreCase("") || uomarr[4].trim().equalsIgnoreCase("NaN")|| uomarr[4].isEmpty()?0:uomarr[4].trim())+"',"
								+ "'"+(uomarr[5].trim().equalsIgnoreCase("undefined") || uomarr[5].trim().equalsIgnoreCase("") || uomarr[5].trim().equalsIgnoreCase("NaN")|| uomarr[5].isEmpty()?0:uomarr[5].trim())+"',"
								+ "'"+(uomarr[6].trim().equalsIgnoreCase("undefined") || uomarr[6].trim().equalsIgnoreCase("") || uomarr[6].trim().equalsIgnoreCase("NaN")|| uomarr[6].isEmpty()?0:uomarr[6].trim())+"')";


					//	System.out.println("uomarr--->>>>Sql"+sql);
						unitdesc = stmt.executeUpdate (sql);
					}

				}


				int specdesc=0;

				for(int i=0;i< specarray.size();i++){
					String[] specarr=((String) specarray.get(i)).split("::");
					if(!((specarr[0].equalsIgnoreCase("0"))||(specarr[0].equalsIgnoreCase("undefined")))){


						String sql="INSERT INTO my_prodattrib(MPSRNO, spec1, spec2, spec3, spec4, barcode)VALUES"
								+ " ('"+pdocno+"',"
								+ "'"+(specarr[0].equalsIgnoreCase("undefined") || specarr[0].equalsIgnoreCase("") || specarr[0].trim().equalsIgnoreCase("NaN")|| specarr[0].isEmpty()?0:specarr[0].trim())+"',"
								+ "'"+(specarr[1].trim().equalsIgnoreCase("undefined")  || specarr[1].trim().equalsIgnoreCase("") || specarr[1].trim().equalsIgnoreCase("NaN")|| specarr[1].isEmpty()?0:specarr[1].trim())+"',"
								+ "'"+(specarr[2].trim().equalsIgnoreCase("undefined") || specarr[2].trim().equalsIgnoreCase("") || specarr[2].trim().equalsIgnoreCase("NaN")|| specarr[2].isEmpty()?0:specarr[2].trim())+"',"
								+ "'"+(specarr[3].trim().equalsIgnoreCase("undefined") || specarr[3].trim().equalsIgnoreCase("") || specarr[3].trim().equalsIgnoreCase("NaN")|| specarr[3].isEmpty()?0:specarr[3].trim())+"',"
								+ "'"+(specarr[4].trim().equalsIgnoreCase("undefined") || specarr[4].trim().equalsIgnoreCase("") || specarr[4].trim().equalsIgnoreCase("NaN")|| specarr[4].isEmpty()?0:specarr[4].trim())+"')";


					//	System.out.println("specarr--->>>>Sql"+sql);
						specdesc = stmt.executeUpdate (sql);
					}

				}


				int suitdesc=0;

/*				for(int i=0;i< suitarray.size();i++){
					String[] suitarr=((String) suitarray.get(i)).split("::");
					if(!((suitarr[0].equalsIgnoreCase("0"))||(suitarr[0].equalsIgnoreCase("undefined")))){


						String sql="INSERT INTO my_prodsuit(PSRNO, sbrand_id, smodel_id, syomfrm_id, syomto_id, spec1_id, spec2_id, spec3_id,submodelid)VALUES"
								+ " ('"+pdocno+"',"
								+ "'"+(suitarr[0].equalsIgnoreCase("undefined") || suitarr[0].equalsIgnoreCase("") || suitarr[0].trim().equalsIgnoreCase("NaN")|| suitarr[0].isEmpty()?0:suitarr[0].trim())+"',"
								+ "'"+(suitarr[1].trim().equalsIgnoreCase("undefined")  || suitarr[1].trim().equalsIgnoreCase("") || suitarr[1].trim().equalsIgnoreCase("NaN")|| suitarr[1].isEmpty()?0:suitarr[1].trim())+"',"
								+ "'"+(suitarr[2].trim().equalsIgnoreCase("undefined") || suitarr[2].trim().equalsIgnoreCase("") || suitarr[2].trim().equalsIgnoreCase("NaN")|| suitarr[2].isEmpty()?0:suitarr[2].trim())+"',"
								+ "'"+(suitarr[3].trim().equalsIgnoreCase("undefined") || suitarr[3].trim().equalsIgnoreCase("") || suitarr[3].trim().equalsIgnoreCase("NaN")|| suitarr[3].isEmpty()?0:suitarr[3].trim())+"',"
								+ "'"+(suitarr[4].trim().equalsIgnoreCase("undefined") || suitarr[4].trim().equalsIgnoreCase("") || suitarr[4].trim().equalsIgnoreCase("NaN")|| suitarr[4].isEmpty()?0:suitarr[4].trim())+"',"
								+ "'"+(suitarr[5].trim().equalsIgnoreCase("undefined") || suitarr[5].trim().equalsIgnoreCase("") || suitarr[5].trim().equalsIgnoreCase("NaN")|| suitarr[5].isEmpty()?0:suitarr[5].trim())+"',"
								+ "'"+(suitarr[6].trim().equalsIgnoreCase("undefined") || suitarr[6].trim().equalsIgnoreCase("") || suitarr[6].trim().equalsIgnoreCase("NaN")|| suitarr[6].isEmpty()?0:suitarr[6].trim())+"',"
								+ "'"+(suitarr[7].trim().equalsIgnoreCase("undefined") || suitarr[7].trim().equalsIgnoreCase("") || suitarr[7].trim().equalsIgnoreCase("NaN")|| suitarr[7].isEmpty()?0:suitarr[7].trim())+"')";
						
						System.out.println("suitarr--->>>>Sql"+sql);
						suitdesc = stmt.executeUpdate (sql);
					}

				}*/
				
				
				for(int i=0;i< suitarray.size();i++){
					String[] suitarr=((String) suitarray.get(i)).split("::");
					if(!((suitarr[0].equalsIgnoreCase("undefined") || suitarr[0].equalsIgnoreCase("") || suitarr[0].trim().equalsIgnoreCase("NaN")|| suitarr[0].isEmpty()))){


						String sql="INSERT INTO my_prodsuit(PSRNO, vehsuitid,syomfrm_id,syomto_id,bsize1id,bsize2id,bsize3id,csize1id,csize2id,csize3id)VALUES"
								+ " ('"+pdocno+"',"
								+ "'"+(suitarr[0].equalsIgnoreCase("undefined") || suitarr[0].equalsIgnoreCase("") || suitarr[0].trim().equalsIgnoreCase("NaN")|| suitarr[0].isEmpty()?0:suitarr[0].trim())+"',"
								+ "'"+(suitarr[1].trim().equalsIgnoreCase("undefined")  || suitarr[1].trim().equalsIgnoreCase("") || suitarr[1].trim().equalsIgnoreCase("NaN")|| suitarr[1].isEmpty()?0:suitarr[1].trim())+"',"
								+ "'"+(suitarr[2].trim().equalsIgnoreCase("undefined") || suitarr[2].trim().equalsIgnoreCase("") || suitarr[2].trim().equalsIgnoreCase("NaN")|| suitarr[2].isEmpty()?0:suitarr[2].trim())+"',"
								+ "'"+(suitarr[3].trim().equalsIgnoreCase("undefined") || suitarr[3].trim().equalsIgnoreCase("") || suitarr[3].trim().equalsIgnoreCase("NaN")|| suitarr[3].isEmpty()?0:suitarr[3].trim())+"',"
								+ "'"+(suitarr[4].trim().equalsIgnoreCase("undefined") || suitarr[4].trim().equalsIgnoreCase("") || suitarr[4].trim().equalsIgnoreCase("NaN")|| suitarr[4].isEmpty()?0:suitarr[4].trim())+"',"
								+ "'"+(suitarr[5].trim().equalsIgnoreCase("undefined") || suitarr[5].trim().equalsIgnoreCase("") || suitarr[5].trim().equalsIgnoreCase("NaN")|| suitarr[5].isEmpty()?0:suitarr[5].trim())+"',"
								+ "'"+(suitarr[6].trim().equalsIgnoreCase("undefined") || suitarr[6].trim().equalsIgnoreCase("") || suitarr[6].trim().equalsIgnoreCase("NaN")|| suitarr[6].isEmpty()?0:suitarr[6].trim())+"',"
								+ "'"+(suitarr[7].trim().equalsIgnoreCase("undefined") || suitarr[7].trim().equalsIgnoreCase("") || suitarr[7].trim().equalsIgnoreCase("NaN")|| suitarr[7].isEmpty()?0:suitarr[7].trim())+"',"
								+ "'"+(suitarr[8].trim().equalsIgnoreCase("undefined") || suitarr[8].trim().equalsIgnoreCase("") || suitarr[8].trim().equalsIgnoreCase("NaN")|| suitarr[8].isEmpty()?0:suitarr[8].trim())+"')";
							
						//System.out.println("suitarr--->>>>Sql"+sql);
						suitdesc = stmt.executeUpdate (sql);
					}

				}



			}


			conn.commit();
		}
		catch(Exception e){
			pdocno=0;
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return pdocno;
	}

	public int update(int docno,java.sql.Date date,String pname,String pcode,String pbarcode,String ptype,String pbrand,String pcat,
			String psubcat,String unit,String dept,String mode,String dtype,ArrayList prodarray,ArrayList<String> uomarray,
			ArrayList<String> suitarray,ArrayList<String> specarray,HttpSession session, int comp_brach, ArrayList<String> pmgntarray,
			int cmbstar, int cmbmastertype, String arabicprdname,ArrayList<String> ssarray,String desc1) throws SQLException{

		System.out.println("====update===="+mode);

		Connection conn=null;
		int pdocno=0;
		conn=ClsConnection.getMyConnection();
		
		try{
			

			conn.setAutoCommit(false);

			CallableStatement stmt = conn.prepareCall("{CALL productDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");


			System.out.println("CALL productDML('"+date+"','"+pname+"','"+pcode+"','"+pbarcode+"','"+ptype+"','"+pbrand+"','"+pcat+"','"+psubcat+"','"+unit+"','"+dept+"','"+mode+"','"+dtype+"','"+session.getAttribute("USERID").toString()+"','"+session.getAttribute("BRANCHID").toString()+"')");

			stmt.setInt(15,docno);
			stmt.setDate(1,date);
			stmt.setString(2,pname);
			stmt.setString(3,pcode);
			stmt.setString(4, pbarcode);
			stmt.setInt(5, Integer.parseInt(ptype));
			stmt.setInt(6, Integer.parseInt(pbrand));
			stmt.setInt(7, Integer.parseInt(pcat));
			stmt.setInt(8, Integer.parseInt(psubcat));
			stmt.setInt(9, Integer.parseInt(unit));
			stmt.setInt(10, Integer.parseInt(dept));
			stmt.setString(11, mode);
			stmt.setString(12, dtype);
			stmt.setString(13, session.getAttribute("USERID").toString());
			stmt.setString(14, session.getAttribute("BRANCHID").toString());
			int val = stmt.executeUpdate();
			pdocno=stmt.getInt("pdocno");


			if (pdocno > 0) {
				
				
				String sqls4="update my_main set prdname='"+arabicprdname+"',star='"+cmbstar+"',mtypeid='"+cmbmastertype+"',desc1='"+desc1+"'  where doc_no='"+pdocno+"'";
				System.out.println("======sqls4=="+sqls4);
				
				stmt.executeUpdate(sqls4);
				
				int branchper=0;
				
				if(comp_brach==1)
				{
					String sqls="update my_main set comp_brch='C' where doc_no='"+pdocno+"'";
					stmt.executeUpdate(sqls);
				}
				else if(comp_brach==2)
				{
					String sqls="update my_main set comp_brch='B' where doc_no='"+pdocno+"'";
					stmt.executeUpdate(sqls);
				}
				
				
				if(pbarcode.equalsIgnoreCase("") || pbarcode==null)
				{
					String sqls="update my_main set barcode='"+pdocno+"' where doc_no='"+pdocno+"'";
					stmt.executeUpdate(sqls);
				}
				
				
				
				for(int i=0;i< prodarray.size();i++){
					String[] prod=((String) prodarray.get(i)).split("::");
					if(!((prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()))){

						if(comp_brach==2)
						{
						String sql="INSERT INTO my_desc(psrno, brhid,bin, minStock, maxStock, PRICE1, PRICE2, PRICE3,discontinued,reorderlevel,reorderqty)VALUES"
								+ " ('"+pdocno+"',"
								+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
								+ "'"+(prod[3].trim().equalsIgnoreCase("undefined")  || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"',"
								+ "'"+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"',"
								+ "'"+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"',"
								+ "'"+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
								+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
								+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"',"
								+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
								+ "'"+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].isEmpty()?0:prod[9].trim())+"',"
								+ "'"+(prod[10].trim().equalsIgnoreCase("undefined") || prod[10].trim().equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"')";


						System.out.println("branchper--->>>>Sql"+sql);
						branchper = stmt.executeUpdate (sql);
						}
						
						else if(comp_brach==1)
						{
							String sql="INSERT INTO my_desc(psrno, cmpid,bin, minStock, maxStock, PRICE1, PRICE2, PRICE3,discontinued,reorderlevel,reorderqty)VALUES"
									+ " ('"+pdocno+"',"
									+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
									+ "'"+(prod[3].trim().equalsIgnoreCase("undefined")  || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"',"
									+ "'"+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"',"
									+ "'"+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"',"
									+ "'"+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
									+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
									+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"',"
									+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
									+ "'"+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].isEmpty()?0:prod[9].trim())+"',"
									+ "'"+(prod[10].trim().equalsIgnoreCase("undefined") || prod[10].trim().equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"')";



						//	System.out.println("branchper--->>>>Sql"+sql);
							branchper = stmt.executeUpdate (sql);
						}
					 
					}

				}
				
				
				
 
				
				
				for(int i=0;i< ssarray.size();i++){
					String[] ssarr=((String) ssarray.get(i)).split("::");
					
					if(i==0)
					{
						String delsql="delete  from my_prdsuperseding where psrno='"+pdocno+"'";
						stmt.executeUpdate(delsql);
					}
					
					if(!((ssarr[0].trim().equalsIgnoreCase("undefined") || ssarr[0].trim().equalsIgnoreCase("0") || ssarr[0].trim().equalsIgnoreCase("") || ssarr[0].trim().equalsIgnoreCase("NaN")|| ssarr[0].isEmpty()))){
				     String sql="INSERT INTO my_prdsuperseding(sr_no,psrno,part_no,priority,discontinued)VALUES"
						       + " ("+(i+1)+","
						       + " '"+pdocno+"',"
						       + "'"+(ssarr[0].trim().equalsIgnoreCase("undefined") || ssarr[0].trim().equalsIgnoreCase("NaN")|| ssarr[0].trim().equalsIgnoreCase("")|| ssarr[0].isEmpty()?0:ssarr[0].trim())+"',"
						       + "'"+(ssarr[1].trim().equalsIgnoreCase("undefined") || ssarr[1].trim().equalsIgnoreCase("NaN")|| ssarr[1].trim().equalsIgnoreCase("")|| ssarr[1].isEmpty()?0:ssarr[1].trim())+"',"
						       + "'"+(ssarr[2].trim().equalsIgnoreCase("undefined") || ssarr[2].trim().equalsIgnoreCase("NaN")|| ssarr[2].trim().equalsIgnoreCase("")|| ssarr[2].isEmpty()?0:ssarr[2].trim())+"' )";
			 	     int resultSet2 = stmt.executeUpdate(sql);
					     if(resultSet2<=0)
							{
								conn.close();
								return 0;
								
							}
									}
					
					
								}
				
				
				
				for(int i=0;i< pmgntarray.size();i++){
					
					if(i==0)
					{
						String delsql="delete  from my_descpr where psrno='"+pdocno+"'";
						stmt.executeUpdate(delsql);
					}
					
					
					String[] pmgntarr=((String) pmgntarray.get(i)).split("::");
		
					
					 if((!(pmgntarr[1].trim().equalsIgnoreCase("undefined") || pmgntarr[1].trim().equalsIgnoreCase("") || pmgntarr[1].trim().equalsIgnoreCase("NaN")|| pmgntarr[1].trim().isEmpty())) 
							   || (!(pmgntarr[2].trim().equalsIgnoreCase("undefined") || pmgntarr[2].trim().equalsIgnoreCase("") || pmgntarr[2].trim().equalsIgnoreCase("NaN")|| pmgntarr[2].trim().isEmpty()))
							  ||  (!(pmgntarr[3].trim().equalsIgnoreCase("undefined") || pmgntarr[3].trim().equalsIgnoreCase("") || pmgntarr[3].trim().equalsIgnoreCase("NaN")|| pmgntarr[3].trim().isEmpty()))
							   ||  (!(pmgntarr[4].trim().equalsIgnoreCase("undefined") || pmgntarr[4].trim().equalsIgnoreCase("") || pmgntarr[4].trim().equalsIgnoreCase("NaN")|| pmgntarr[4].trim().isEmpty()))
							  ||  (!(pmgntarr[5].trim().equalsIgnoreCase("undefined") || pmgntarr[5].trim().equalsIgnoreCase("") || pmgntarr[5].trim().equalsIgnoreCase("NaN")|| pmgntarr[5].trim().isEmpty()))
							  ||  (!(pmgntarr[6].trim().equalsIgnoreCase("undefined") || pmgntarr[6].trim().equalsIgnoreCase("") || pmgntarr[6].trim().equalsIgnoreCase("NaN")|| pmgntarr[6].trim().isEmpty()))
							  ||  (!(pmgntarr[7].trim().equalsIgnoreCase("undefined") || pmgntarr[7].trim().equalsIgnoreCase("") || pmgntarr[7].trim().equalsIgnoreCase("NaN")|| pmgntarr[7].trim().isEmpty()))
							  ||  (!(pmgntarr[8].trim().equalsIgnoreCase("undefined") || pmgntarr[8].trim().equalsIgnoreCase("") || pmgntarr[8].trim().equalsIgnoreCase("NaN")|| pmgntarr[8].trim().isEmpty()))
							  ||  (!(pmgntarr[9].trim().equalsIgnoreCase("undefined") || pmgntarr[9].trim().equalsIgnoreCase("") || pmgntarr[9].trim().equalsIgnoreCase("NaN")|| pmgntarr[9].trim().isEmpty()))
							   ||  (!(pmgntarr[10].trim().equalsIgnoreCase("undefined") || pmgntarr[10].trim().equalsIgnoreCase("") || pmgntarr[10].trim().equalsIgnoreCase("NaN")|| pmgntarr[10].trim().isEmpty()))
							   ||  (!(pmgntarr[11].trim().equalsIgnoreCase("undefined") || pmgntarr[11].trim().equalsIgnoreCase("") || pmgntarr[11].trim().equalsIgnoreCase("NaN")|| pmgntarr[11].trim().isEmpty()))
							  ||  (!(pmgntarr[12].trim().equalsIgnoreCase("undefined") || pmgntarr[12].trim().equalsIgnoreCase("") || pmgntarr[12].trim().equalsIgnoreCase("NaN")|| pmgntarr[12].trim().isEmpty()))){
					
 
			     String sql="INSERT INTO my_descpr(sr_no,psrno, catid,  price1, price2, price3, discount1, discount2, discount3, foc1, foc2, foc3,qty1,qty2,qty3)VALUES"
					       + " ("+(i+1)+","
					       + " '"+pdocno+"',"
					       + "'"+(pmgntarr[0].trim().equalsIgnoreCase("undefined") || pmgntarr[0].trim().equalsIgnoreCase("NaN")|| pmgntarr[0].trim().equalsIgnoreCase("")|| pmgntarr[0].isEmpty()?0:pmgntarr[0].trim())+"',"
					       + "'"+(pmgntarr[1].trim().equalsIgnoreCase("undefined") || pmgntarr[1].trim().equalsIgnoreCase("NaN")|| pmgntarr[1].trim().equalsIgnoreCase("")|| pmgntarr[1].isEmpty()?0:pmgntarr[1].trim())+"',"
					       + "'"+(pmgntarr[2].trim().equalsIgnoreCase("undefined") || pmgntarr[2].trim().equalsIgnoreCase("NaN")|| pmgntarr[2].trim().equalsIgnoreCase("")|| pmgntarr[2].isEmpty()?0:pmgntarr[2].trim())+"',"
					       + "'"+(pmgntarr[3].trim().equalsIgnoreCase("undefined") || pmgntarr[3].trim().equalsIgnoreCase("NaN")||pmgntarr[3].trim().equalsIgnoreCase("")|| pmgntarr[3].isEmpty()?0:pmgntarr[3].trim())+"',"
					       + "'"+(pmgntarr[4].trim().equalsIgnoreCase("undefined") || pmgntarr[4].trim().equalsIgnoreCase("NaN")|| pmgntarr[4].trim().equalsIgnoreCase("")|| pmgntarr[4].isEmpty()?0:pmgntarr[4].trim())+"',"
					       + "'"+(pmgntarr[5].trim().equalsIgnoreCase("undefined") || pmgntarr[5].trim().equalsIgnoreCase("NaN")||pmgntarr[5].trim().equalsIgnoreCase("")|| pmgntarr[5].isEmpty()?0:pmgntarr[5].trim())+"',"
					       + "'"+(pmgntarr[6].trim().equalsIgnoreCase("undefined") || pmgntarr[6].trim().equalsIgnoreCase("NaN")||pmgntarr[6].trim().equalsIgnoreCase("")|| pmgntarr[6].isEmpty()?0:pmgntarr[6].trim())+"',"
					       + "'"+(pmgntarr[7].trim().equalsIgnoreCase("undefined") || pmgntarr[7].trim().equalsIgnoreCase("NaN")||pmgntarr[7].trim().equalsIgnoreCase("")|| pmgntarr[7].isEmpty()?0:pmgntarr[7].trim())+"',"
					       + "'"+(pmgntarr[8].trim().equalsIgnoreCase("undefined") || pmgntarr[8].trim().equalsIgnoreCase("NaN")||pmgntarr[8].trim().equalsIgnoreCase("")|| pmgntarr[8].isEmpty()?0:pmgntarr[8].trim())+"',"
					       + "'"+(pmgntarr[9].trim().equalsIgnoreCase("undefined") || pmgntarr[9].trim().equalsIgnoreCase("NaN")||pmgntarr[9].trim().equalsIgnoreCase("")|| pmgntarr[9].isEmpty()?0:pmgntarr[9].trim())+"',"
			               + "'"+(pmgntarr[10].trim().equalsIgnoreCase("undefined") || pmgntarr[10].trim().equalsIgnoreCase("NaN")||pmgntarr[10].trim().equalsIgnoreCase("")|| pmgntarr[10].isEmpty()?0:pmgntarr[10].trim())+"',"
			               + "'"+(pmgntarr[11].trim().equalsIgnoreCase("undefined") || pmgntarr[11].trim().equalsIgnoreCase("NaN")||pmgntarr[11].trim().equalsIgnoreCase("")|| pmgntarr[11].isEmpty()?0:pmgntarr[11].trim())+"',"
			               + "'"+(pmgntarr[12].trim().equalsIgnoreCase("undefined") || pmgntarr[12].trim().equalsIgnoreCase("NaN")||pmgntarr[12].trim().equalsIgnoreCase("")|| pmgntarr[12].isEmpty()?0:pmgntarr[12].trim())+"')";
			    
				
		 	     int resultSet2 = stmt.executeUpdate(sql);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
					     
					}
			            	}

				int unitdesc=0;

				for(int i=0;i< uomarray.size();i++){
					String[] uomarr=((String) uomarray.get(i)).trim().split("::");
					
					
					if(!((uomarr[0].equalsIgnoreCase("undefined") || uomarr[0].equalsIgnoreCase("") || uomarr[0].trim().equalsIgnoreCase("NaN")|| uomarr[0].isEmpty()))){


						String sql="INSERT INTO my_unit(PSRNO, UNIT, FR, wt, VOLUME, thk, leng, width)VALUES"
								+ " ('"+pdocno+"',"
								+ "'"+(uomarr[0].equalsIgnoreCase("undefined") || uomarr[0].equalsIgnoreCase("") || uomarr[0].trim().equalsIgnoreCase("NaN")|| uomarr[0].isEmpty()?0:uomarr[0].trim())+"',"
								+ "'"+(uomarr[1].trim().equalsIgnoreCase("undefined")  || uomarr[1].trim().equalsIgnoreCase("") || uomarr[1].trim().equalsIgnoreCase("NaN")|| uomarr[1].isEmpty()?0:uomarr[1].trim())+"',"
								+ "'"+(uomarr[2].trim().equalsIgnoreCase("undefined") || uomarr[2].trim().equalsIgnoreCase("") || uomarr[2].trim().equalsIgnoreCase("NaN")|| uomarr[2].isEmpty()?0:uomarr[2].trim())+"',"
								+ "'"+(uomarr[3].trim().equalsIgnoreCase("undefined") || uomarr[3].trim().equalsIgnoreCase("") || uomarr[3].trim().equalsIgnoreCase("NaN")|| uomarr[3].isEmpty()?0:uomarr[3].trim())+"',"
								+ "'"+(uomarr[4].trim().equalsIgnoreCase("undefined") || uomarr[4].trim().equalsIgnoreCase("") || uomarr[4].trim().equalsIgnoreCase("NaN")|| uomarr[4].isEmpty()?0:uomarr[4].trim())+"',"
								+ "'"+(uomarr[5].trim().equalsIgnoreCase("undefined") || uomarr[5].trim().equalsIgnoreCase("") || uomarr[5].trim().equalsIgnoreCase("NaN")|| uomarr[5].isEmpty()?0:uomarr[5].trim())+"',"
								+ "'"+(uomarr[6].trim().equalsIgnoreCase("undefined") || uomarr[6].trim().equalsIgnoreCase("") || uomarr[6].trim().equalsIgnoreCase("NaN")|| uomarr[6].isEmpty()?0:uomarr[6].trim())+"')";


						System.out.println("uomarr--->>>>Sql"+sql);
						unitdesc = stmt.executeUpdate (sql);
					}

				}


				int specdesc=0;

				for(int i=0;i< specarray.size();i++){
					String[] specarr=((String) specarray.get(i)).split("::");
					if(!((specarr[0].equalsIgnoreCase("undefined") || specarr[0].equalsIgnoreCase("") || specarr[0].trim().equalsIgnoreCase("NaN")|| specarr[0].isEmpty()))){


						String sql="INSERT INTO my_prodattrib(MPSRNO, spec1, spec2, spec3, spec4, barcode)VALUES"
								+ " ('"+pdocno+"',"
								+ "'"+(specarr[0].equalsIgnoreCase("undefined") || specarr[0].equalsIgnoreCase("") || specarr[0].trim().equalsIgnoreCase("NaN")|| specarr[0].isEmpty()?0:specarr[0].trim())+"',"
								+ "'"+(specarr[1].trim().equalsIgnoreCase("undefined")  || specarr[1].trim().equalsIgnoreCase("") || specarr[1].trim().equalsIgnoreCase("NaN")|| specarr[1].isEmpty()?0:specarr[1].trim())+"',"
								+ "'"+(specarr[2].trim().equalsIgnoreCase("undefined") || specarr[2].trim().equalsIgnoreCase("") || specarr[2].trim().equalsIgnoreCase("NaN")|| specarr[2].isEmpty()?0:specarr[2].trim())+"',"
								+ "'"+(specarr[3].trim().equalsIgnoreCase("undefined") || specarr[3].trim().equalsIgnoreCase("") || specarr[3].trim().equalsIgnoreCase("NaN")|| specarr[3].isEmpty()?0:specarr[3].trim())+"',"
								+ "'"+(specarr[4].trim().equalsIgnoreCase("undefined") || specarr[4].trim().equalsIgnoreCase("") || specarr[4].trim().equalsIgnoreCase("NaN")|| specarr[4].isEmpty()?0:specarr[4].trim())+"')";


				//		System.out.println("specarr--->>>>Sql"+sql);
						specdesc = stmt.executeUpdate (sql);
					}

				}


				int suitdesc=0;

				/*for(int i=0;i< suitarray.size();i++){
					String[] suitarr=((String) suitarray.get(i)).split("::");
					if(!((suitarr[0].equalsIgnoreCase("0"))||(suitarr[0].equalsIgnoreCase("undefined")))){


						String sql="INSERT INTO my_prodsuit(PSRNO, sbrand_id, smodel_id, syomfrm_id, syomto_id, spec1_id, spec2_id, spec3_id,submodelid)VALUES"
								+ " ('"+pdocno+"',"
								+ "'"+(suitarr[0].equalsIgnoreCase("undefined") || suitarr[0].equalsIgnoreCase("") || suitarr[0].trim().equalsIgnoreCase("NaN")|| suitarr[0].isEmpty()?0:suitarr[0].trim())+"',"
								+ "'"+(suitarr[1].trim().equalsIgnoreCase("undefined")  || suitarr[1].trim().equalsIgnoreCase("") || suitarr[1].trim().equalsIgnoreCase("NaN")|| suitarr[1].isEmpty()?0:suitarr[1].trim())+"',"
								+ "'"+(suitarr[2].trim().equalsIgnoreCase("undefined") || suitarr[2].trim().equalsIgnoreCase("") || suitarr[2].trim().equalsIgnoreCase("NaN")|| suitarr[2].isEmpty()?0:suitarr[2].trim())+"',"
								+ "'"+(suitarr[3].trim().equalsIgnoreCase("undefined") || suitarr[3].trim().equalsIgnoreCase("") || suitarr[3].trim().equalsIgnoreCase("NaN")|| suitarr[3].isEmpty()?0:suitarr[3].trim())+"',"
								+ "'"+(suitarr[4].trim().equalsIgnoreCase("undefined") || suitarr[4].trim().equalsIgnoreCase("") || suitarr[4].trim().equalsIgnoreCase("NaN")|| suitarr[4].isEmpty()?0:suitarr[4].trim())+"',"
								+ "'"+(suitarr[5].trim().equalsIgnoreCase("undefined") || suitarr[5].trim().equalsIgnoreCase("") || suitarr[5].trim().equalsIgnoreCase("NaN")|| suitarr[5].isEmpty()?0:suitarr[5].trim())+"',"
								+ "'"+(suitarr[6].trim().equalsIgnoreCase("undefined") || suitarr[6].trim().equalsIgnoreCase("") || suitarr[6].trim().equalsIgnoreCase("NaN")|| suitarr[6].isEmpty()?0:suitarr[6].trim())+"',"
								+ "'"+(suitarr[7].trim().equalsIgnoreCase("undefined") || suitarr[7].trim().equalsIgnoreCase("") || suitarr[7].trim().equalsIgnoreCase("NaN")|| suitarr[7].isEmpty()?0:suitarr[7].trim())+"')";
						
						System.out.println("suitarr--->>>>Sql"+sql);
						suitdesc = stmt.executeUpdate (sql);
					}

				}*/
				
				for(int i=0;i< suitarray.size()-1;i++){
				//	System.out.println("==suitarray.size()==="+suitarray.size());
					String[] suitarr=((String) suitarray.get(i)).split("::");
					if(!((suitarr[0].equalsIgnoreCase("undefined") || suitarr[0].equalsIgnoreCase("") || suitarr[0].trim().equalsIgnoreCase("NaN")|| suitarr[0].isEmpty()))){


						String sql="INSERT INTO my_prodsuit(PSRNO, vehsuitid,syomfrm_id,syomto_id,bsize1id,bsize2id,bsize3id,csize1id,csize2id,csize3id)VALUES"
								+ " ('"+pdocno+"',"
								+ "'"+(suitarr[0].equalsIgnoreCase("undefined") || suitarr[0].equalsIgnoreCase("") || suitarr[0].trim().equalsIgnoreCase("NaN")|| suitarr[0].isEmpty()?0:suitarr[0].trim())+"',"
								+ "'"+(suitarr[1].trim().equalsIgnoreCase("undefined")  || suitarr[1].trim().equalsIgnoreCase("") || suitarr[1].trim().equalsIgnoreCase("NaN")|| suitarr[1].isEmpty()?0:suitarr[1].trim())+"',"
								+ "'"+(suitarr[2].trim().equalsIgnoreCase("undefined") || suitarr[2].trim().equalsIgnoreCase("") || suitarr[2].trim().equalsIgnoreCase("NaN")|| suitarr[2].isEmpty()?0:suitarr[2].trim())+"',"
								+ "'"+(suitarr[3].trim().equalsIgnoreCase("undefined") || suitarr[3].trim().equalsIgnoreCase("") || suitarr[3].trim().equalsIgnoreCase("NaN")|| suitarr[3].isEmpty()?0:suitarr[3].trim())+"',"
								+ "'"+(suitarr[4].trim().equalsIgnoreCase("undefined") || suitarr[4].trim().equalsIgnoreCase("") || suitarr[4].trim().equalsIgnoreCase("NaN")|| suitarr[4].isEmpty()?0:suitarr[4].trim())+"',"
								+ "'"+(suitarr[5].trim().equalsIgnoreCase("undefined") || suitarr[5].trim().equalsIgnoreCase("") || suitarr[5].trim().equalsIgnoreCase("NaN")|| suitarr[5].isEmpty()?0:suitarr[5].trim())+"',"
								+ "'"+(suitarr[6].trim().equalsIgnoreCase("undefined") || suitarr[6].trim().equalsIgnoreCase("") || suitarr[6].trim().equalsIgnoreCase("NaN")|| suitarr[6].isEmpty()?0:suitarr[6].trim())+"',"
								+ "'"+(suitarr[7].trim().equalsIgnoreCase("undefined") || suitarr[7].trim().equalsIgnoreCase("") || suitarr[7].trim().equalsIgnoreCase("NaN")|| suitarr[7].isEmpty()?0:suitarr[7].trim())+"',"
								+ "'"+(suitarr[8].trim().equalsIgnoreCase("undefined") || suitarr[8].trim().equalsIgnoreCase("") || suitarr[8].trim().equalsIgnoreCase("NaN")|| suitarr[8].isEmpty()?0:suitarr[8].trim())+"')";
						
					//	System.out.println("suitarr--->>>>Sql"+sql);
						suitdesc = stmt.executeUpdate (sql);
					}

				}



			}


			conn.commit();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return pdocno;
	}


	public int delete(int docno,java.sql.Date date,String pname,String pcode,String pbarcode,String ptype,String pbrand,String pcat,
			String psubcat,String unit,String dept,String mode,String dtype,ArrayList prodarray,ArrayList uomarray,ArrayList suitarray,ArrayList specarray,HttpSession session) throws SQLException{



		Connection conn=null;
		int pdocno=0;
		
		int method=0;
		conn=ClsConnection.getMyConnection();
		try{
			
			Statement stmt1=conn.createStatement();

			String chk=" select (sum(op_qty)-(sum(out_qty)+sum(rsv_qty)+sum(del_qty))) qty from my_prddin where prdid='"+docno+"'  group by prdid  "
			           +" having (sum(op_qty)-(sum(out_qty)+sum(rsv_qty)+sum(del_qty)))>0 ";
			
			
			
			ResultSet rs=stmt1.executeQuery(chk); 
			if(rs.next())
			{
				
				method=1;
			}
			
			if(method>0)
			{
				
				pdocno=-5;
				
				return  pdocno;
			}
			

			conn.setAutoCommit(false);
			
			
			
			
			

			CallableStatement stmt = conn.prepareCall("{CALL productDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");


			//System.out.println("CALL productDML('"+date+"','"+pname+"','"+pcode+"','"+pbarcode+"','"+ptype+"','"+pbrand+"','"+pcat+"','"+psubcat+"','"+unit+"','"+dept+"','"+mode+"','"+dtype+"','"+session.getAttribute("USERID").toString()+"','"+session.getAttribute("BRANCHID").toString()+"')");

			stmt.setInt(15,docno);
			stmt.setDate(1,date);
			stmt.setString(2,pname);
			stmt.setString(3,pcode);
			stmt.setString(4, pbarcode);
			stmt.setInt(5, Integer.parseInt(ptype));
			stmt.setInt(6, Integer.parseInt(pbrand));
			stmt.setInt(7, Integer.parseInt(pcat));
			stmt.setInt(8, Integer.parseInt(psubcat));
			stmt.setInt(9, Integer.parseInt(unit));
			stmt.setInt(10, Integer.parseInt(dept));
			stmt.setString(11, mode);
			stmt.setString(12, dtype);
			stmt.setString(13, session.getAttribute("USERID").toString());
			stmt.setString(14, session.getAttribute("BRANCHID").toString());
			int val = stmt.executeUpdate();
			pdocno=stmt.getInt("pdocno");

			conn.commit();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return pdocno;
	}

	public  JSONArray mainSrearch(HttpSession session,String name,String code,String brand,String cat,String subcat) throws SQLException { 

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

		String brnchid=session.getAttribute("BRANCHID").toString();
		String sqltest="";

		if(!(code.equalsIgnoreCase(""))){
			sqltest=sqltest+" and part_no like '%"+code+"%'";
		}
		if(!(name.equalsIgnoreCase(""))){
			sqltest=sqltest+" and productname like '%"+name+"%'";
		}
		if(!(brand.equalsIgnoreCase(""))){
			sqltest=sqltest+" and b.brand like '%"+brand+"%'";
		}
		if(!(cat.equalsIgnoreCase(""))){
			sqltest=sqltest+" and c.category like '%"+cat+"%' ";
		}
		if(!(subcat.equalsIgnoreCase(""))){
			sqltest=sqltest+" and s.subcategory like '%"+subcat+"%'";
		}


		Connection conn=null;  

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();
			String str1Sql=("select m.doc_no docno,part_no as productcode,productname ,b.brandname brand,c.category,s.subcategory "
					+ "from my_main m left join my_ptype t on(m.typeid=t.doc_no) left join "
					+ "my_brand b on(m.brandid=b.doc_no) left join my_catm c on(m.catid=c.doc_no)"
					+ " left join my_scatm s on(m.scatid=s.doc_no) left join my_unitm u "
					+ "on(m.munit=u.doc_no) left join my_dept d on(m.deptid=d.doc_no) where 1=1 " +sqltest+" and m.status=3 order by m.doc_no");

		//	System.out.println("=====mainSrearch====="+str1Sql);
			ResultSet resultSet = stmt.executeQuery (str1Sql); 

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


	public  ClsProductBean getViewDetails(HttpSession session,int docno) throws SQLException { 


		Connection conn=null;  

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();
			String str1Sql=("select  m.desc1,coalesce(m.prdname,'') prdname,m.mtypeid,m.lbrchg,m.fixingprice ,m.stdprice, m.star,if(m.comp_brch='C',1,2) comp_brch, m.barcode,m.doc_no sdocno,part_no as procode,"
					+ " s.subcategory as subcat,s.doc_no as scatdocno,c.category as catm,c.doc_no as catdocno,u.unit,u.doc_no as udocno,productname sname,b.brandname sbrand,b.doc_no as bdocno,t.producttype as stype,t.doc_no as tdocno,d.department sdept,d.doc_no as dedocno "
					+ "from my_main m left join my_ptype t on(m.typeid=t.doc_no) left join "
					+ "my_brand b on(m.brandid=b.doc_no) left join my_catm c on(m.catid=c.doc_no)"
					+ " left join my_scatm s on(m.scatid=s.doc_no) left join my_unitm u "
					+ "on(m.munit=u.doc_no) left join my_dept d on(m.deptid=d.doc_no)  where m.doc_No="+docno+" order by m.doc_no");

			System.out.println("=====getViewDetails====="+str1Sql);
			ResultSet rs = stmt.executeQuery (str1Sql); 

			while(rs.next()){
				
			 Double stdcost=0.00;
			 Double fixcost=0.00;
			 Double lbrcost=0.00;
			  
 
			 
			 stdcost=rs.getDouble("stdprice") ;
			 fixcost=rs.getDouble("fixingprice") ;
			 lbrcost=rs.getDouble("lbrchg") ;
			  DecimalFormat f = new DecimalFormat("##.00");
			 System.out.println("=====stdcost====="+stdcost);
			 if(stdcost>0)
			 {
				 proact.setStdcostname("Standard Cost :");
				 
				 
 				 
				proact.setStdcostprice(f.format(stdcost)+""); 
				// proact.setStdcostprice(stdcost+""); 
				  
				 
				  
			 }
			 if(fixcost>0)
			 {
				 proact.setFixname("Selling Price :");
				proact.setFixprices(f.format(fixcost)+""); 
				// proact.setFixprices(fixcost+""); 
			 }

			 if(lbrcost>0)
			 {
				 proact.setLbrcostname("Labour Charge :");
			   proact.setLbrcosts(f.format(lbrcost)+""); 
				 
				 
				 //proact.setLbrcosts(lbrcost+""); 
			 }

 
			 proact.setDesc1(rs.getString("desc1"));
		 
			 proact.setTxtarbicprdname(rs.getString("prdname"));
			 
				proact.setCmbmastertype(rs.getInt("mtypeid"));
				proact.setCmbstar(rs.getInt("star"));
				proact.setTxtproducttype(rs.getString("stype"));
				proact.setCmbproducttype(rs.getString("tdocno"));
				proact.setTxtbrand(rs.getString("sbrand"));
				proact.setCmbbrand(rs.getString("bdocno"));
				proact.setTxtproductname(rs.getString("sname"));
				proact.setTxtproductcode(rs.getString("procode"));
				proact.setTxtunit(rs.getString("unit"));
				proact.setCmbunit(rs.getString("udocno"));
				proact.setTxtbarcode(rs.getString("barcode"));
				proact.setTextdept(rs.getString("sdept"));
				proact.setCmbdept(rs.getString("dedocno"));
				proact.setTxtcategory(rs.getString("catm"));
				proact.setCmbcategory(rs.getString("catdocno"));
				proact.setTxtsubcategory(rs.getString("subcat"));
				proact.setCmbsubcategory(rs.getString("scatdocno"));
				
				
				proact.setComorbranch(rs.getInt("comp_brch"));
				
				
				
				
			}

			stmt.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}

		return proact;
	}
	
	
	public JSONArray suitSearch(HttpSession session,String yomfrm,String yomto,String suitid,String chkbed,String chkbed2,String chkbed3,
			String chkcab,String chkcab2,String chkcab3,String rba,String rbb,String rca,String rcb,String typeid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		String sql="",sqlbed="",sqlcab="",sqlappnd="";
		try {
			
/*			
			System.out.println("======rba======"+rba);
			System.out.println("======rbb======"+rbb);
			System.out.println("======rca======"+rca);
			System.out.println("======rcb======"+rcb);
			*/
			//System.out.println("suitid=="+suitid+"==chkbed==="+chkbed+"==chkcab=="+chkcab+"==rba==="+rba+"==rbb==="+rbb+"===rca=="+rca+"==rcb==="+rcb+"===typeid=="+typeid);
			
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			if(typeid.equalsIgnoreCase("0")){
				sql="select s.doc_no,s.yom_frm yomfrm,s.yom_to yomto,s.doc_no,brand,(case when s.smodelid=-1 then 'ALL' else model end) as model,"
						+ "(case when s.submodelid=-1 then 'ALL' else submodel end) as submodel,"
						+ "(case when s.esizeid=-1 then 'ALL' else coalesce(s2.spec,'') end) as esize,"
						+ "(case when s.bsize1id=-1 then 'ALL' else coalesce(s11.spec,'') end) as bsize1,"
						+ "(case when s.bsize2id=-1 then 'ALL' else coalesce(s12.spec,'') end) as bsize2,"
						+ "(case when s.bsize3id=-1 then 'ALL' else coalesce(s13.spec,'') end) as bsize3,"
						+ "(case when s.csize1id=-1 then 'ALL' else coalesce(s31.spec,'') end) as csize1,"
						+ "(case when s.csize2id=-1 then 'ALL' else coalesce(s32.spec,'') end) as csize2,"
						+ "(case when s.csize3id=-1 then 'ALL' else coalesce(s33.spec,'') end) as csize3,"
						+ "s.sbrandid brandid,s.smodelid modelid,s.submodelid submodelid,if(s.esizeid='-2',0,s.esizeid)  esizeid, "
						+ " if(s.bsize1id='-2',0,s.bsize1id)  bsize1id, if(s.bsize2id='-2',0,s.bsize2id) bsize2id, if(s.bsize3id='-2',0,s.bsize3id) bsize3id,"
						+ "  if(s.csize1id='-2',0,s.csize1id) csize1id,if(s.csize2id='-2',0,s.csize2id) csize2id,if(s.csize3id='-2',0,s.csize3id) csize3id, "
						+ "if(s.yom_frmid='-2',0,s.yom_frmid) yomfrmid,if(s.yom_toid='-2',0,s.yom_toid)  yomtoid  "
						+ "from my_vehsuitmaster s left join my_sbrand b on(b.doc_no=s.sbrandid) left join my_smodel m on(m.doc_no=s.smodelid)"
						+ "left join my_ssubmodel sm on(sm.doc_No=s.submodelid and sm.modelid=s.smodelid) left join my_suitspec2 s2 on(s2.doc_no=s.esizeid)" //and sm.modelid=s.smodelid
						+ "left join my_suitspec1 s11 on(s11.doc_no=s.bsize1id)"
						+ "left join my_suitspec1 s12 on(s12.doc_no=s.bsize2id)"
						+ "left join my_suitspec1 s13 on(s13.doc_no=s.bsize3id)"
						+ "left join my_suitspec3 s31 on(s31.doc_no=s.csize1id)"
						+ "left join my_suitspec3 s32 on(s32.doc_no=s.csize2id)"
						+ "left join my_suitspec3 s33 on(s33.doc_no=s.csize3id)"
						+ "where s.status=3 ";
			//	System.out.println("===1sql====="+sql);
			}
			
			else if(typeid.equalsIgnoreCase("1")){
				
				if(chkbed.equalsIgnoreCase("1")){
					
					if(rba.equalsIgnoreCase("1")){
						sqlbed=" and s.bsize1id=-1 and s.bsize2id=-1 and s.bsize3id=-1";
					}
					if(rbb.equalsIgnoreCase("1")){
						sqlbed=" and s.bsize1id=0 and s.bsize2id=0 and s.bsize3id=0";
					}
				}
				
				else if(chkcab.equalsIgnoreCase("1")){
					
					if(rca.equalsIgnoreCase("1")){
						sqlcab=" and s.csize1id=-1 and s.csize2id=-1 and s.csize3id=-1";
					}
					if(rcb.equalsIgnoreCase("1")){
						sqlcab=" and s.csize1id=0 and s.csize2id=0 and s.csize3id=0";
					}
				}
				
				/*sqlappnd=" and s.doc_no in("+suitid+") "+sqlbed+" "+sqlcab+"";*/
				sqlappnd=" and s.doc_no in("+suitid+")";
				
				sql="select s.doc_no,s.yom_frm yomfrm,s.yom_to yomto,s.doc_no,brand,(case when s.smodelid=-1 then 'ALL' else model end) as model,"
						+ "(case when s.submodelid=-1 then 'ALL' else submodel end) as submodel,"
						+ "(case when s.esizeid=-1 then 'ALL' else coalesce(s2.spec,'') end) as esize,"
						+ "(case when "+chkbed.equalsIgnoreCase("1")+" then (case when "+rba.equalsIgnoreCase("1")+" then 'ALL' else '' end) else coalesce(s11.spec,'') end) as bsize1,"
						+ "(case when "+chkbed2.equalsIgnoreCase("1")+" then (case when "+rba.equalsIgnoreCase("1")+" then 'ALL' else '' end) else coalesce(s12.spec,'') end) as bsize2,"
						+ "(case when "+chkbed3.equalsIgnoreCase("1")+" then (case when "+rba.equalsIgnoreCase("1")+" then 'ALL' else '' end) else coalesce(s13.spec,'') end) as bsize3,"
						+ "(case when "+chkcab.equalsIgnoreCase("1")+" then (case when "+rca.equalsIgnoreCase("1")+" then 'ALL' else '' end) else coalesce(s31.spec,'') end) as csize1,"
						+ "(case when "+chkcab2.equalsIgnoreCase("1")+" then (case when "+rca.equalsIgnoreCase("1")+" then 'ALL' else '' end) else coalesce(s32.spec,'') end) as csize2,"
						+ "(case when "+chkcab3.equalsIgnoreCase("1")+" then (case when "+rca.equalsIgnoreCase("1")+" then 'ALL' else '' end) else coalesce(s33.spec,'') end) as csize3,"
						+ "s.sbrandid brandid,s.smodelid modelid,s.submodelid submodelid,s.esizeid, "
						+ "(case when "+chkbed.equalsIgnoreCase("1")+" then (case when "+rba.equalsIgnoreCase("1")+" then -1 else 0 end) else coalesce(s11.doc_no,0) end) as bsize1id,"
						+ "(case when "+chkbed2.equalsIgnoreCase("1")+" then (case when "+rba.equalsIgnoreCase("1")+" then -1 else 0 end) else coalesce(s12.doc_no,0) end) as bsize2id,"
						+ "(case when "+chkbed3.equalsIgnoreCase("1")+" then (case when "+rba.equalsIgnoreCase("1")+" then -1 else 0 end) else coalesce(s13.doc_no,0) end) as bsize3id,"
						+ "(case when "+chkcab.equalsIgnoreCase("1")+" then (case when "+rca.equalsIgnoreCase("1")+" then  -1 else 0 end) else coalesce(s31.doc_no,0) end) as csize1id,"
						+ "(case when "+chkcab2.equalsIgnoreCase("1")+" then (case when "+rca.equalsIgnoreCase("1")+" then -1 else 0 end) else coalesce(s32.doc_no,0) end) as csize2id,"
						+ "(case when "+chkcab3.equalsIgnoreCase("1")+" then (case when "+rca.equalsIgnoreCase("1")+" then -1 else 0 end) else coalesce(s33.doc_no,0) end) as csize3id,"
						+ "s.yom_frmid yomfrmid,s.yom_toid yomtoid  "
						+ "from my_vehsuitmaster s left join my_sbrand b on(b.doc_no=s.sbrandid) left join my_smodel m on(m.doc_no=s.smodelid)"
						+ "left join my_ssubmodel sm on(sm.doc_No=s.submodelid and sm.modelid=s.smodelid) left join my_suitspec2 s2 on(s2.doc_no=s.esizeid)" //and sm.modelid=s.smodelid
						+ "left join my_suitspec1 s11 on(s11.doc_no=s.bsize1id)"
						+ "left join my_suitspec1 s12 on(s12.doc_no=s.bsize2id)"
						+ "left join my_suitspec1 s13 on(s13.doc_no=s.bsize3id)"
						+ "left join my_suitspec3 s31 on(s31.doc_no=s.csize1id)"
						+ "left join my_suitspec3 s32 on(s32.doc_no=s.csize2id)"
						+ "left join my_suitspec3 s33 on(s33.doc_no=s.csize3id)"
						+ "where s.status=3 "+sqlappnd+" ";
				
				
				//System.out.println("===2sql====="+sql);
				
			}
			
	 

	/*and date_format(str_to_date(s.yom_frm,'%Y'),'%Y')>="+yomfrm+" and date_format(str_to_date(yom_to,'%Y'),'%Y')<="+yomto+"*/
	
		//	System.out.println("=sql==suitSearch="+sql);
			
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	
	public JSONArray suitSearchLoad(HttpSession session,String doc_no) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

	String sql="select s.doc_no,s.yom_frm yomfrm,s.yom_to yomto,s.doc_no,brand,(case when s.smodelid=-1 then 'ALL' else model end) as model,"
				+ "(case when s.submodelid=-1 then 'ALL' else submodel end) as submodel,"
				+ "(case when s.esizeid=-1 then 'ALL' else coalesce(s2.spec,'') end) as esize,"
				+ "(case when s.bsize1id=-1 then 'ALL' else coalesce(s11.spec,'') end) as bsize1,"
				+ "(case when s.bsize2id=-1 then 'ALL' else coalesce(s12.spec,'') end) as bsize2,"
				+ "(case when s.bsize3id=-1 then 'ALL' else coalesce(s13.spec,'') end) as bsize3,"
				+ "(case when s.csize1id=-1 then 'ALL' else coalesce(s31.spec,'') end) as csize1,"
				+ "(case when s.csize2id=-1 then 'ALL' else coalesce(s32.spec,'') end) as csize2,"
				+ "(case when s.csize3id=-1 then 'ALL' else coalesce(s33.spec,'') end) as csize3,"
				+ "s.sbrandid brandid,s.smodelid modelid,s.submodelid submodelid,s.esizeid,s.bsize1id,s.bsize2id,s.bsize3id,"
				+ "s.csize1id,s.csize2id,s.csize3id,s.yom_frmid yomfrmid,s.yom_toid yomtoid  "
				+ "from my_vehsuitmaster s left join my_sbrand b on(b.doc_no=s.sbrandid) left join my_smodel m on(m.doc_no=s.smodelid)"
				+ "left join my_ssubmodel sm on(sm.doc_No=s.submodelid and sm.modelid=s.smodelid) left join my_suitspec2 s2 on(s2.doc_no=s.esizeid)" // and sm.modelid=s.smodelid
				+ "left join my_suitspec1 s11 on(s11.doc_no=s.bsize1id)"
				+ "left join my_suitspec1 s12 on(s12.doc_no=s.bsize2id)"
				+ "left join my_suitspec1 s13 on(s13.doc_no=s.bsize3id)"
				+ "left join my_suitspec3 s31 on(s31.doc_no=s.csize1id)"
				+ "left join my_suitspec3 s32 on(s32.doc_no=s.csize2id)"
				+ "left join my_suitspec3 s33 on(s33.doc_no=s.csize3id)"
				+ "where s.status=3 and s.doc_no in ("+doc_no+")";

			
		//	System.out.println("=sql==suitSearch="+sql);
			
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