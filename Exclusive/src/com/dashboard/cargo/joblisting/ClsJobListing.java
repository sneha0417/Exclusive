package com.dashboard.cargo.joblisting;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsJobListing {
	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	Connection conn = null;
	public JSONArray gridDataLoad(String cldocno,String jobno,String id, String branch) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }
        else{
			try {
				conn = connDAO.getMyConnection();
				Statement stmtCRM = conn.createStatement();
			    java.sql.Date  sqlDate = null;
			    
			    String sqltest="";
				if(!(cldocno.equalsIgnoreCase(""))||(cldocno.equalsIgnoreCase("0"))){
					sqltest+=" and m.cldocno = "+cldocno+"";
				}
				if(!(jobno.equalsIgnoreCase(""))||(jobno.equalsIgnoreCase("0"))){
					sqltest+=" and ct.doc_no ="+jobno;
				}
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		    		sqltest+=" and m.brhid='"+branch+"'";
		 		}
				
			    String sql=" select m.doc_no,m.brhid branch,m.date,ac.refname client,m.voc_no qotno ,ct.remarks ,ct.tr_no,ct.doc_no jobno,ct.refno,'Attach' as attach, "
			    		+ " cm.mawb,cm.mbl,cm.hawb,cm.hbl,cm.shipper,cm.consignee,cm.carrier,cm.flightno,cm.voage,cm.etd,cm.eta,cm.ttime,cm.boe,cm.contno,cm.truckno"
			    		+ " from cr_qotm m left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' "
			    		+ " left join cr_qotd d on m.doc_no=d.rdocno left join cr_enqm em on m.rrefno=em.doc_no  and m.reftype='ENQ'"
			    		+ " left join cr_enqd ed on em.doc_no=ed.rdocno and ed.doc_no=d.refdocno"
			    		+ " left join cr_joblist l on l.enqdocno=ed.doc_no left join cm_srvcontrm ct on l.jobno=ct.tr_no"
			    		+ " left join cr_cfim cm on cm.refno=ct.tr_no where 1=1 "+sqltest+" group by l.jobno";
					System.out.println("--gridsql--"+sql);
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
	   }
       return RESULTDATA;
   }
	
	public JSONArray enqryDataLoad(String jobno) throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 System.out.println(jobno+"---doc");
	        Connection conn = null;
	        
			try {
				conn = connDAO.getMyConnection();
				Statement stmtCRM = conn.createStatement();
			      	String sql="select d.doc_no enqdoc,d.modeid,md.modename mode,d.smodeid,sm.submode,d.shipid,sp.shipment,d.termsid,t.terms,d.origin,"
			      			+ "d.pol,d.pod,d.commodity,d.wight weight,d.noofpacks,d.dimension,d.volume,d.remarks,d.qty"
			      			+ " from cr_enqd d left join cr_mode md on md.doc_no=d.modeid left join cr_smode sm on sm.doc_no=d.smodeid"
			      			+ " left join cr_shipment sp on sp.doc_no=d.shipid left join cr_terms t on t.doc_no=d.termsid "
			      			+ " left join cr_joblist l on l.enqdocno=d.doc_no where l.jobno="+jobno;
					System.out.println("--enqrysql--"+sql);
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
	public JSONArray estmDataLoad(String docno) throws SQLException {
		 System.out.println("adsaas"+docno);
		 JSONArray RESULTDATA=new JSONArray();
	        Connection conn = null;
	        if(docno.equalsIgnoreCase("0")){
	        	return RESULTDATA;
	        }
			try {
				conn = connDAO.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				String sql="select s.srvtype sertype,d.typeid srvdocno,cr.code currency,d.curid,convert(d.rate,char(50)) rate,convert(d.price,char(50)) price,"
						+ " convert(d.qty,char(50)) qty,d.uom unitid,u.unit uom,convert(d.total,char(50)) total,convert(d.btotal,char(50))  basetotal,d.billing,"
						+" d.vndid,ac.refname vendor, if(cc.agtype=1,aa.refname,ss.sal_name) name, if(cc.agtype=1,'Vendor','Own') atype,cc.equipment regno,cc.trackid,cc.expdate,cc.remarks "
						+ " from cr_qotm m left join cr_qotd d on d.rdocno=m.doc_no left join cr_srvtype s on d.typeid=s.doc_no left join my_curr cr on cr.doc_no=d.curid"
						+" left join my_unitm u on u.doc_no=d.uom left join my_acbook ac on ac.cldocno=d.vndid and ac.dtype='VND' "
						+ "  left join cr_enqm em on m.rrefno=em.doc_no and m.reftype='ENQ' left join cr_enqd ed on em.doc_no=ed.rdocno and ed.doc_no=d.refdocno "
				    	+ "  left join cr_joblist l on l.enqdocno=ed.doc_no left join cr_assignment cc on cc.rdocno=d.doc_no and l.jobno=cc.jobno "
						+ " left join my_acbook aa on aa.cldocno=cc.agto and aa.dtype='VND' and cc.agtype=1 left join my_salesman ss on ss.doc_no=cc.agto and sal_type='STF' and cc.agtype=2"
						+ " where l.jobno="+docno+"";
					System.out.println("--estmsql--"+sql);	
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
	
	public JSONArray clientData(String clientname,String mob,String id) throws SQLException{
		
		JSONArray RESULTDATA=new JSONArray();

		if(!(id.equalsIgnoreCase("1"))) {
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
			String sqlqry= "select refname clientname,cldocno from my_acbook where dtype='CRM' and status='3'"+sqltest;
			System.out.println("sqlqry ="+sqlqry);
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
	public JSONArray jobnoSearch() throws SQLException{
		JSONArray RESULTDATA=new JSONArray();
		Connection conn =null;
		try {
			conn=connDAO.getMyConnection();
			Statement stmt = conn.createStatement ();
        	String sqlqry= "select l.jobno,ct.doc_no from cr_joblist l left join cm_srvcontrm ct on l.jobno=ct.tr_no group by l.jobno";
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
}
