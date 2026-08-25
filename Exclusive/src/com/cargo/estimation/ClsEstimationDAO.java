package com.cargo.estimation;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpRequest;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsEstimationDAO {
	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	Connection conn = null;
	 
	 public JSONArray currencySearch() throws SQLException {
	        JSONArray RESULTDATA=new JSONArray();
	        Connection conn = null;
	        
			try {
				conn = connDAO.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				ResultSet resultSet = stmtCRM.executeQuery ("select doc_no curid,code currency,round(c_rate,2) rate from my_curr where status=3");
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				stmtCRM.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
	 public JSONArray unitSearch() throws SQLException {
	        JSONArray RESULTDATA=new JSONArray();
	        Connection conn = null;
//	        System.out.println("=====================aaaa-----");
			try {
				conn = connDAO.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				ResultSet resultSet = stmtCRM.executeQuery ("select doc_no,unit from my_unitm where status=3");
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				stmtCRM.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
	        return RESULTDATA;
	    }

	 public JSONArray searchVendor(HttpSession session,String clientname,String mob,String id) throws SQLException{
			System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
			JSONArray RESULTDATA=new JSONArray();

			if(!(id.equalsIgnoreCase("1"))) {
				System.out.println("---id--------"+id);
	        	return RESULTDATA;
	        }
			
			Connection conn =null;
	        
			try {
				conn=connDAO.getMyConnection();

				Statement stmt = conn.createStatement ();
         	
				String sqltest="";
				if(!clientname.equalsIgnoreCase("")){
					sqltest+=" and refname like '%"+clientname+"%'";
				}
				if(!mob.equalsIgnoreCase("")){
					sqltest+=" and per_mob like '%"+mob+"%'";
				}
				String sqlqry= "select refname,address,per_mob,cldocno from my_acbook where dtype='VND' and status='3'"+sqltest;
				System.out.println("sqlqry ==="+sqlqry);
				ResultSet resultSet = stmt.executeQuery(sqlqry);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
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
	 //refSearchMasters
	 public JSONArray refSearchMasters(HttpSession session,String docnoss,String datess,String aa,String client) throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
	        Connection conn = null;
	        System.out.println("====="+aa);
			try {
				conn = connDAO.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				String sqltest="";
			    java.sql.Date  sqlDate = null;
			    if(!aa.equalsIgnoreCase("yes")){
			    	return RESULTDATA;
			    }
			    else{
			  		if(!(datess.equalsIgnoreCase("undefined"))&&!(datess.equalsIgnoreCase(""))&&!(datess.equalsIgnoreCase("0")))
			      	{
			  			sqlDate = commonDAO.changeStringtoSqlDate(datess);
			  			sqltest+=" and m.date = '"+sqlDate+"'";
			      	}
			  	   	if((!(docnoss.equalsIgnoreCase(""))) && (!(docnoss.equalsIgnoreCase("NA")))){
			      		sqltest+=" and m.voc_no like '%"+docnoss+"%'";
			      	}
			      	if((!(client.equalsIgnoreCase(""))) && (!(client.equalsIgnoreCase("NA")))){
			      		sqltest+=" and ac.refname like '%"+client+"%'  ";
			      	}
			      	String sql="select m.doc_no,m.date,m.voc_no,ac.cldocno,ac.refname,ac.address,ac.per_mob mob,coalesce(mail1,mail2) email, "
			      			+ " m.remarks from cr_enqm m left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' "
			      			+ " left join cr_qotm q on q.rrefno=m.doc_no where m.status=3 "+sqltest+" AND M.BRHID="+session.getAttribute("BRANCHID").toString()
			      			+" and q.rrefno is null ";
			      	System.out.println("--sql---"+sql);
					ResultSet resultSet = stmtCRM.executeQuery (sql);
					RESULTDATA=commonDAO.convertToJSON(resultSet);
					stmtCRM.close();
					conn.close();
			    }
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
	 //enqryDataLoad(session,enqrdocno)
	 public JSONArray enqryDataLoad(HttpSession session,String enqrdocno) throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 System.out.println(enqrdocno+"---doc");
	        Connection conn = null;
	        
			try {
				conn = connDAO.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				String sqltest="";
			    java.sql.Date  sqlDate = null;
			    
			  	   	if((!(enqrdocno.equalsIgnoreCase(""))) && (!(enqrdocno.equalsIgnoreCase("NA")))){
			      		sqltest+=" and m.voc_no like '%"+enqrdocno+"%'";
			      	}
			  	   	
			      	String sql="select d.doc_no enqdoc,d.modeid,md.modename mode,d.smodeid,sm.submode,d.shipid,sp.shipment,d.termsid,t.terms,d.origin,"
			      			+ "d.pol,d.pod,d.commodity,d.wight weight,d.noofpacks,d.dimension,d.volume,d.remarks,d.qty,'Calculate' as calculate"
			      			+ " from cr_enqd d left join cr_mode md on md.doc_no=d.modeid left join cr_smode sm on sm.doc_no=d.smodeid"
			      			+ " left join cr_shipment sp on sp.doc_no=d.shipid left join cr_terms t on t.doc_no=d.termsid where d.rdocno="+enqrdocno;
					System.out.println("-- enqrysql --"+sql);
			      	ResultSet resultSet = stmtCRM.executeQuery (sql);
					RESULTDATA=commonDAO.convertToJSON(resultSet);
					stmtCRM.close();
					conn.close();
			    
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
//	 estmDataLoad(id,modeid,smodeid,shipid)

	 public JSONArray estmDataLoad(String docno,String enqdocno,String id,String modeid,String smodeid,String shipid) throws SQLException {
		 System.out.println("adsaas");
		 JSONArray RESULTDATA=new JSONArray();
	        Connection conn = null;
	        if(!id.equalsIgnoreCase("1")){
	        	return RESULTDATA;
	        }
			try {
				conn = connDAO.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				String sql="select 1 status,s.srvtype sertype,d.typeid srvdocno,cr.code currency,d.curid,convert(d.rate,char(50)) rate,convert(d.price,char(50)) price,"
						+ " convert(d.qty,char(50)) qty,d.uom unitid,u.unit uom,convert(d.total,char(50)) total,convert(d.btotal,char(50))  basetotal,d.billing,"
						+" d.vndid,ac.refname vendor from cr_qotd d left join cr_srvtype s on d.typeid=s.doc_no left join my_curr cr on cr.doc_no=d.curid"
						+" left join my_unitm u on u.doc_no=d.uom left join my_acbook ac on ac.cldocno=d.vndid and ac.dtype='VND' where rdocno="+docno+" and refdocno="+enqdocno+""
						+" union all select 0 status,s.srvtype sertype,s.doc_no srvdocno,'' currency,0 curid, '' rate, '' price,convert('',char(50)) qty,0 unitid,'' uom,convert('',char(50)) total,'' basetotal,"
						+" '' billing,0 vndid,'' vendor from cr_srvtype s left join cr_qotd d on d.typeid=s.doc_no and rdocno="+docno+" and refdocno="+enqdocno+" and s.status=3"
						+" where s.modeid="+modeid+" and s.smodeid="+smodeid+" and s.shipid="+shipid+" and d.typeid  is null";
				System.out.println("==estmsql=="+sql);
				ResultSet resultSet = stmtCRM.executeQuery (sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				stmtCRM.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
			return RESULTDATA;
	 }
	 public JSONArray volumeDataLoad(String enqddocno) throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
	        Connection conn = null;
	        
			try {
				conn = connDAO.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				String sqltest="";
			    java.sql.Date  sqlDate = null;
			    
			      	String sql="select rdocno, type, length length1, width, height, qty qty1, volweight, actweight actualweight from cr_enqvol where rdocno="+enqddocno;
					System.out.println("-- volsqlLoad--"+sql);
			      	ResultSet resultSet = stmtCRM.executeQuery (sql);
					RESULTDATA=commonDAO.convertToJSON(resultSet);
					stmtCRM.close();
					conn.close();
			    
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
	 public JSONArray masterSearch(String date,String docno,String client,String refno,String id,HttpSession session) throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
	        Connection conn = null;
	        System.out.println("----dao----");
	        if(!id.equalsIgnoreCase("1")){
	        	return RESULTDATA;
	        }
			try {
				conn = connDAO.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				java.sql.Date sqlDate=null;
		        String sqltest="";
		        if(!date.equalsIgnoreCase("")){
					sqlDate=commonDAO.changeStringtoSqlDate(date);
					sqltest+= " and m.date='"+sqlDate+"'";
				}
		        if(!client.equalsIgnoreCase("")){
					sqltest+=" and ac.refname like '%"+client+"%'";
				}
		        if(!docno.equalsIgnoreCase("")){
					sqltest+=" and m.docno = "+docno;
				}
		        if(!refno.equalsIgnoreCase("")){
					sqltest+=" and em.voc_no = "+refno;
				}
				String sql="select em.doc_no enqdocno,m.doc_no,m.voc_no,m.date,m.cldocno,ac.refname,m.reftype,em.voc_no rrefno,ac.address,ac.per_mob mob,coalesce(mail1,mail2) email,m.remarks "
						+ " from cr_qotm m left join cr_enqm em on m.rrefno=em.doc_no "
						+ " left join my_acbook ac on m.cldocno=ac.cldocno and ac.dtype='CRM' where m.status=3  AND M.BRHID="+session.getAttribute("BRANCHID").toString()+" "+sqltest+" ";
				System.out.println("==searchsql=="+sql);
				ResultSet resultSet = stmtCRM.executeQuery (sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				stmtCRM.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
			return RESULTDATA;
	 }
	 
	public int insert(Date masterdate, String cmbreftype, int refno,
			String txtclient, String txtclientname, String txtaddress,
			String txtmobile, String txtemail, String txtRemarks, String mode,
			String deleted, String enqdtype, String enqgridlenght,
			String gridval, String forradiochk, String brandval,
			String fromdatesval, String todateval, String txtradio, String msg,HttpSession session,HttpServletRequest request) throws SQLException {		// TODO Auto-generated method stub
		try{
			int docno;
			
			
			conn=connDAO.getMyConnection();
			/*Statement stmt=conn.createStatement();
			String sql11="select doc_no from cr_enqm where voc_no="+refno+" and brhid="+session.getAttribute("BRANCHID").toString();
			System.out.println("=sql11=="+sql11);
			ResultSet resultSet = stmt.executeQuery (sql11);
			int rrefno=0;
			while(resultSet.next()){
				rrefno=resultSet.getInt("doc_no");
			}
			System.out.println("refno---"+rrefno);
			*/
			conn.setAutoCommit(false);
			CallableStatement stmtestm= conn.prepareCall("{call estimationDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtestm.registerOutParameter(10, java.sql.Types.INTEGER);
			stmtestm.setInt(12, java.sql.Types.INTEGER);
			stmtestm.setDate(1,masterdate);
			stmtestm.setInt(2,Integer.parseInt(session.getAttribute("USERID").toString()));
			stmtestm.setInt(3,Integer.parseInt(session.getAttribute("BRANCHID").toString()));
		   	stmtestm.setInt(4,Integer.parseInt(session.getAttribute("COMPANYID").toString()));
			stmtestm.setInt(5,Integer.parseInt(txtclient));
			stmtestm.setString(6,cmbreftype);
			stmtestm.setInt(7,refno);
			stmtestm.setString(8,txtRemarks);
			stmtestm.setString(9,"CEST");
			stmtestm.setString(11,mode);
			
			stmtestm.executeQuery();
			docno=stmtestm.getInt("docNo");
			int vocno=stmtestm.getInt("vocNo");	
			request.setAttribute("vocno", vocno);
			if(docno<=0){
				conn.close();
				return 0;
			}
			if (docno > 0) {
				conn.commit();
				stmtestm.close();
				conn.close();
				return docno;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return 0;
	}
	
	public boolean edit(int docno,Date masterdate, String cmbreftype, int refno,
			String txtclient, String txtclientname, String txtaddress,
			String txtmobile, String txtemail, String txtRemarks, String mode,
			String deleted, String enqdtype, String enqgridlenght,
			String gridval, String forradiochk, String brandval,
			String fromdatesval, String todateval, String txtradio, String msg,HttpSession session,HttpServletRequest request) throws SQLException {		// TODO Auto-generated method stub
		try{
			
			conn=connDAO.getMyConnection();
			/*Statement stmt=conn.createStatement();
			String sql11="select doc_no from cr_enqm where voc_no="+refno+" and brhid="+session.getAttribute("BRANCHID").toString();
			ResultSet resultSet = stmt.executeQuery (sql11);
			int rrefno=0;
			while(resultSet.next()){
				rrefno=resultSet.getInt("doc_no");
			}
			*/
			conn.setAutoCommit(false);
			CallableStatement stmtestm= conn.prepareCall("{call estimationDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtestm.setDate(1,masterdate);
			stmtestm.setInt(2,Integer.parseInt(session.getAttribute("USERID").toString()));
			stmtestm.setInt(3,Integer.parseInt(session.getAttribute("BRANCHID").toString()));
		   	stmtestm.setInt(4,Integer.parseInt(session.getAttribute("COMPANYID").toString()));
			stmtestm.setInt(5,Integer.parseInt(txtclient));
			stmtestm.setString(6,cmbreftype);
			stmtestm.setInt(7,refno);
			stmtestm.setString(8,txtRemarks);
			stmtestm.setString(9,"CEST");
			stmtestm.setInt(10, docno);
			stmtestm.setString(11,mode);
			stmtestm.setInt(12, 0);

			int aaa=stmtestm.executeUpdate();
			docno=stmtestm.getInt("docNo");
			
			int vocno=stmtestm.getInt("vocNo");	
			request.setAttribute("vocno", vocno);
			if(aaa<=0)
			{
				conn.close();
				return false;
			}
			if (aaa > 0) {
				conn.commit();
				stmtestm.close();
				conn.close();
				return true;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return false;
	}
	 
	public boolean delete(int docno,HttpSession session,String mode) throws SQLException {

		try{
			conn=connDAO.getMyConnection();

			CallableStatement stmtestm= conn.prepareCall("{call estimationDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtestm.setDate(1,null);
			stmtestm.setInt(2,Integer.parseInt(session.getAttribute("USERID").toString()));
			stmtestm.setInt(3,Integer.parseInt(session.getAttribute("BRANCHID").toString()));
		   	stmtestm.setInt(4,Integer.parseInt(session.getAttribute("COMPANYID").toString()));
			stmtestm.setInt(5,0);
			stmtestm.setString(6,null);
			stmtestm.setInt(7,0);
			stmtestm.setString(8,null);
			stmtestm.setString(9,"CEST");
			stmtestm.setInt(10, docno);
			stmtestm.setString(11,mode);
			stmtestm.setInt(12, 0);

			int aaa=stmtestm.executeUpdate();
			if (aaa > 0) {
				stmtestm.close();
				conn.close();
				return true;
			}
			else{
				conn.close();
				return false;
			}
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return false;
	}
	
	public  ClsEstimationBean getPrint(int docno, HttpServletRequest request ,HttpSession session) throws SQLException {
		ClsEstimationBean bean=new ClsEstimationBean(); 
 		Connection conn = null;
 		
 		try {
 			conn = connDAO.getMyConnection();
			Statement stmtprint = conn.createStatement ();
			String sql="select m.voc_no,m.date,em.voc_no enqno,ac.refname,ac.address,ac.per_mob,ac.mail1,m.remarks,em.doc_no enqdoc, "
					+" b.branchname,b.address branchaddress,b.tel branchtel,b.fax branchfax,b.email branchmail,b.tinno,l.loc_name"
					+" from cr_qotm m left join cr_enqm em on m.rrefno=em.doc_no left join my_acbook ac on m.cldocno=ac.cldocno "
					+ " left join my_brch b on m.brhid=b.doc_no left join my_locm l on b.doc_no=l.doc_no where m.doc_no="+docno;
			ResultSet printrs = stmtprint.executeQuery(sql);
			int enqno=0;
			while(printrs.next()){
				bean.setLblcompname(printrs.getString("branchname"));
				bean.setLblcompaddress(printrs.getString("branchaddress"));
				bean.setLblcomptel(printrs.getString("branchtel"));
				bean.setLblcompfax(printrs.getString("branchfax"));
				bean.setLblcompemail(printrs.getString("branchmail"));
				bean.setLblbranchtrno(printrs.getString("tinno"));
				bean.setLbllocation(printrs.getString("loc_name"));
				
				bean.setLblclientname(printrs.getString("refname"));
				bean.setLbladdress(printrs.getString("address"));
				bean.setLblmobile(printrs.getString("per_mob"));
				bean.setLbldocno(printrs.getString("voc_no"));
				bean.setLbldate(printrs.getString("date"));
				bean.setLblenquiryno(printrs.getString("enqno"));
				enqno=Integer.parseInt(printrs.getString("enqdoc"));
			}
			
			
			ArrayList<String> enqarray=new ArrayList<>();
			enqarray=getEnqdetails(enqno,conn);
			request.setAttribute("ENQDATA", enqarray);
			
			ArrayList<String> estmarray=new ArrayList<>();
			estmarray=getEstmDetails(docno,conn);
			request.setAttribute("ESTMDATA", estmarray);
 		}
 		catch(Exception e){
 			conn.close();
 			e.printStackTrace();
 		}
 		conn.close();
 		return bean;
	}
	private ArrayList<String> getEnqdetails(int enqrdocno, Connection conn3) throws SQLException {
		Connection conn2=conn3;
		ArrayList<String> enqarray=new ArrayList<>();
		try{
			Statement stmt=conn2.createStatement();
			String sql="select d.doc_no enqdoc,md.modename mode,sm.submode,sp.shipment,coalesce(t.terms,'') terms,d.origin,"
	      			+ " d.pol,d.pod,d.commodity,d.wight weight,d.noofpacks,d.dimension,d.volume,d.remarks,d.qty"
	      			+ " from cr_enqd d left join cr_mode md on md.doc_no=d.modeid left join cr_smode sm on sm.doc_no=d.smodeid"
	      			+ " left join cr_shipment sp on sp.doc_no=d.shipid left join cr_terms t on t.doc_no=d.termsid where d.rdocno="+enqrdocno;
			System.out.println("enqsql-----:"+sql);
			ResultSet rsreq=stmt.executeQuery(sql);
			int i=0;
			while(rsreq.next()){
				i++;
				enqarray.add(rsreq.getString("enqdoc")+"::"+i+"::"+rsreq.getString("mode")+"::"+rsreq.getString("submode")+"::"+rsreq.getString("shipment")
						+"::"+rsreq.getString("terms")+"::"+rsreq.getString("origin")+"::"+rsreq.getString("pol")+"::"+rsreq.getString("pod")
						+"::"+rsreq.getString("commodity")+"::"+rsreq.getString("weight")+"::"+rsreq.getString("noofpacks")+"::"+rsreq.getString("dimension")
						+"::"+rsreq.getString("volume")+"::"+rsreq.getString("remarks")+"::"+rsreq.getString("qty")+"::");
				
				System.out.println("enqarray---"+enqarray);
			}
		}
		catch(Exception e){
			conn2.close();
			e.printStackTrace();
		}
		return enqarray;
	}
	private ArrayList<String> getEstmDetails(int docno, Connection conn3) throws SQLException {
		Connection conn2=conn3;
		ArrayList<String> estmarray=new ArrayList<>();
		try{
			Statement stmt=conn2.createStatement();
			String sql="select d.refdocno enqdoc,s.srvtype sertype,cr.code currency,convert(round(d.rate,2),char(50)) rate,convert(round(d.price,2),char(50)) price,"
					+" convert(round(d.qty,2),char(50)) qty,u.unit uom,convert(round(d.total,2),char(50)) total,convert(round(d.btotal,2),char(50))  basetotal,d.billing,"
					+" coalesce(ac.refname,'') vendor from cr_qotd d left join cr_srvtype s on d.typeid=s.doc_no left join my_curr cr on cr.doc_no=d.curid"
					+" left join my_unitm u on u.doc_no=d.uom left join my_acbook ac on ac.cldocno=d.vndid and ac.dtype='VND' where d.rdocno="+docno+"";
//			System.out.println("estsql-----:"+sql);
			ResultSet rsreq=stmt.executeQuery(sql);
			int i=0;
			while(rsreq.next()){
				i++;
				estmarray.add(rsreq.getString("enqdoc")+"::"+i+"::"+rsreq.getString("sertype")+"::"+rsreq.getString("vendor")+"::"+rsreq.getString("currency")
						+"::"+rsreq.getString("rate")+"::"+rsreq.getString("price")+"::"+rsreq.getString("qty")+"::"+rsreq.getString("total")+"::"+rsreq.getString("basetotal")
						+"::"+rsreq.getString("uom")+"::"+rsreq.getString("billing"));
				System.out.println("estmarray---"+estmarray);
			}
		}
		catch(Exception e){
		conn2.close();
			e.printStackTrace();
		}
		return estmarray;
	}
}
