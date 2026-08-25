package com.operations.vehicletransactions.vehicleinspection;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsVehicleInspectionDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsVehicleInspectionBean inspectionBean=new ClsVehicleInspectionBean();
	public  ClsVehicleInspectionBean getViewDetails(int docNo) throws SQLException{
		ClsVehicleInspectionBean inspectionBean = new ClsVehicleInspectionBean();
		Connection conn =null;
		try {
		conn= objconn.getMyConnection();
		
		Statement stmtmanual = conn.createStatement ();
		
      /*  String sql= ("select insp.agmtbranch,insp.doc_no,insp.date,insp.type,insp.reftype,insp.refdocno,insp.amount,insp.accident,insp.polrep,insp.acdate,insp.coldate,insp.place,"
        		+ "insp.fine,insp.remarks,insp.claim,insp.rfleet from gl_vinspm insp where insp.status<>7 and insp.doc_no="+docNo);
        */
		String sql="select ac.refname,veh.reg_no,insp.agmtbranch,insp.doc_no,insp.date,insp.type,insp.reftype,insp.refdocno,insp.amount,insp.accident,insp.polrep,"+
        		" insp.acdate,insp.coldate,insp.place,insp.fine,insp.remarks,insp.claim,insp.rfleet from gl_vinspm insp left join gl_vehmaster veh"+
        		" on insp.rfleet=veh.fleet_no left join gl_ragmt rag on (insp.reftype='RAG' and insp.refdocno=rag.doc_no) left join gl_lagmt lag"+
        		" on (insp.reftype='LAG' and insp.refdocno=lag.doc_no) left join gl_vehreplace rep on (insp.reftype='RPL' and insp.refdocno=rep.doc_no)"+
        		" left join gl_ragmt reprag on (rep.rtype='RAG' and rep.rdocno=reprag.doc_no) left join gl_lagmt replag on (rep.rtype='LAG' and"+
        		" rep.rdocno=replag.doc_no) left join my_acbook ac on (case when insp.reftype='RAG' then (rag.cldocno=ac.cldocno and ac.dtype='CRM')"+
        		" when insp.reftype='LAG' then (lag.cldocno=ac.cldocno and ac.dtype='CRM') when (insp.reftype='RPL' and rep.rtype='RAG') then"+
        		" (reprag.cldocno=ac.cldocno and ac.dtype='CRM') when (insp.reftype='RPL' and rep.rtype='LAG') then"+
        		" (replag.cldocno=ac.cldocno and ac.dtype='CRM') else 0 end) where insp.status<>7 and insp.doc_no="+docNo;
		ResultSet resultSet = stmtmanual.executeQuery(sql);
					
		while (resultSet.next()) {
			inspectionBean.setDate(resultSet.getDate("date").toString());
			inspectionBean.setHidcmbtype(resultSet.getString("type"));
			inspectionBean.setHidcmbreftype(resultSet.getString("reftype"));
			inspectionBean.setRdocno(resultSet.getInt("refdocno"));
			inspectionBean.setDocno(docNo);
			inspectionBean.setAccdate(resultSet.getDate("acdate").toString());
			inspectionBean.setPrcs(resultSet.getString("polrep"));
			inspectionBean.setCollectdate(resultSet.getDate("coldate").toString());
			inspectionBean.setAccplace(resultSet.getString("place"));
			inspectionBean.setAccfines(resultSet.getString("fine"));
			inspectionBean.setHidcmbclaim(resultSet.getString("claim"));
			inspectionBean.setAmount(resultSet.getString("amount"));
			inspectionBean.setHidaccidents(resultSet.getString("accident"));
			inspectionBean.setAccremarks(resultSet.getString("remarks"));
			inspectionBean.setRfleet(resultSet.getString("rfleet"));
			inspectionBean.setHidcmbagmtbranch(resultSet.getString("agmtbranch"));
			inspectionBean.setRegno(resultSet.getString("reg_no"));
			inspectionBean.setClient(resultSet.getString("refname"));
		}
		stmtmanual.close();
		conn.close();
		}
		catch(Exception e){
		e.printStackTrace();
		conn.close();
		}
		finally{
			conn.close();
		}

		return inspectionBean;
		}

	
	
	 public JSONArray mainSearch(String cmbtype,String cmbreftype,String fleetno,String refdocno,String searchdate,String docno,String branch,String regno) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	 Connection conn=null;
	    	    	// String brnchid=session.getAttribute("BRANCHID").toString();
	    	//System.out.println("name"+sclname);
	   
     
				try {
					conn=objconn.getMyConnection();
	    	String sqltest="";
	    	java.sql.Date sqldate=null;
	    	if(!(searchdate.equalsIgnoreCase(""))){
	    		sqldate=objcommon.changeStringtoSqlDate(searchdate);	
	    	}
	    	
	    	if(!(cmbtype.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and insp.type like '%"+cmbtype+"%'";
	    	}
	    	if(!(cmbreftype.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and insp.reftype='"+cmbreftype+"'";
	    	}
	    	if(!(fleetno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and insp.rfleet like '%"+fleetno+"%'";
	    	}
	    	
	    	if(!(refdocno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and insp.refvoucherno like'%"+refdocno+"%'";
	    	}
	    	if(!(docno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and insp.doc_no like '%"+docno+"%'";
	    	}
	    	 if(sqldate!=null){
	    		 sqltest=sqltest+" and insp.date='"+sqldate+"'";
	    	 }
	    	 if(!regno.equalsIgnoreCase("")){
	    		 sqltest=sqltest+" and veh.reg_no="+regno+"";
	    	 }
					Statement stmtsearch = conn.createStatement ();
			/*		String str1Sql="select insp.agmtbranch,veh.reg_no,insp.doc_no,insp.date,insp.type,insp.reftype,insp.refdocno,insp.refvoucherno,insp.amount,insp.accident,insp.polrep,insp.acdate,"+
					" insp.coldate,insp.place,insp.fine,insp.remarks,insp.claim,insp.rfleet from gl_vinspm insp left join gl_vehmaster veh on insp.rfleet=veh.fleet_no where insp.status<>7 and insp.brhid="+branch+" "+sqltest+" group by insp.doc_no";
				*/
				
							 String sql="select ac.refname,veh.reg_no,insp.agmtbranch,insp.doc_no,insp.date,insp.type,insp.reftype,insp.refdocno,insp.refvoucherno,insp.amount,insp.accident,insp.polrep,"+
				        		" insp.acdate,insp.coldate,insp.place,insp.fine,insp.remarks,insp.claim,insp.rfleet from gl_vinspm insp left join gl_vehmaster veh"+
				        		" on insp.rfleet=veh.fleet_no left join gl_ragmt rag on (insp.reftype='RAG' and insp.refdocno=rag.doc_no) left join gl_lagmt lag"+
				        		" on (insp.reftype='LAG' and insp.refdocno=lag.doc_no) left join gl_vehreplace rep on (insp.reftype='RPL' and insp.refdocno=rep.doc_no)"+
				        		" left join gl_ragmt reprag on (rep.rtype='RAG' and rep.rdocno=reprag.doc_no) left join gl_lagmt replag on (rep.rtype='LAG' and"+
				        		" rep.rdocno=replag.doc_no) left join my_acbook ac on (case when insp.reftype='RAG' then (rag.cldocno=ac.cldocno and ac.dtype='CRM')"+
				        		" when insp.reftype='LAG' then (lag.cldocno=ac.cldocno and ac.dtype='CRM') when (insp.reftype='RPL' and rep.rtype='RAG') then"+
				        		" (reprag.cldocno=ac.cldocno and ac.dtype='CRM') when (insp.reftype='RPL' and rep.rtype='LAG') then"+
				        		" (replag.cldocno=ac.cldocno and ac.dtype='CRM') else 0 end) where insp.status<>7 and insp.brhid="+branch+" "+sqltest+" group by insp.doc_no order by insp.doc_no";
					
					//					System.out.println("======="+str1Sql);
					ResultSet resultSet = stmtsearch.executeQuery(sql);
					RESULTDATA=objcommon.convertToJSON(resultSet);
					stmtsearch.close();
					conn.close();
					return RESULTDATA;
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
				finally{
					conn.close();
				}
			//System.out.println(RESULTDATA);
			conn.close();
	        return RESULTDATA;
	    }
	 
	 
	 
	 
	public JSONArray getDoc(String reftype,String branch,String docno,String fleetno,String regno,String date,String mode,String type) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();
	    if(!mode.equalsIgnoreCase("1")){
	    	return RESULTDATA;
	    }
	    Connection conn =null;
	    try {
			conn=objconn.getMyConnection();
			Statement stmtmanual = conn.createStatement ();
			String table="";
			java.sql.Date sqldate=null;
			String sqltest="";
			String sqlbranch="";
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
			}
			
			if(!docno.equalsIgnoreCase("")){
				if(reftype.equalsIgnoreCase("RAG")){
					sqltest+=" and r.voc_no like '%"+docno+"%'";
				}
				else if(reftype.equalsIgnoreCase("LAG")){
					sqltest+=" and l.voc_no like '%"+docno+"%'";
				}
				else if(reftype.equalsIgnoreCase("RPL")){
					sqltest+=" and rep.doc_no like '%"+docno+"%'";
				}
				else if(reftype.equalsIgnoreCase("NRM")){
					sqltest+=" and nrm.doc_no like '%"+docno+"%'";
				}
			}
			if(!fleetno.equalsIgnoreCase("")){
					sqltest+=" and veh.fleet_no like '%"+fleetno+"%'";
			}
			if(!regno.equalsIgnoreCase("")){
				sqltest+=" and veh.reg_no like '%"+regno+"%'";
			}
			if(sqldate!=null){
				if(reftype.equalsIgnoreCase("RAG")){
					sqltest+=" and r.date='"+sqldate+"'";
				}
				else if(reftype.equalsIgnoreCase("LAG")){
					sqltest+=" and l.date='"+sqldate+"'";
				}
				else if(reftype.equalsIgnoreCase("RPL")){
					sqltest+=" and rep.date='"+sqldate+"'";
				}
				else if(reftype.equalsIgnoreCase("NRM")){
					sqltest+=" and nrm.date='"+sqldate+"'";
				}
			}
			
			
			if(reftype.equalsIgnoreCase("RAG")){
				if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
					sqlbranch+=" and r.brhid="+branch;
				}
				table="select ac.refname,r.fleet_no,r.doc_no,r.voc_no,r.date,'RAG' reftype,coalesce(r.insex,0.0) insurexcess,veh.reg_no  from"+
						" gl_ragmt r inner join gl_vehmaster veh on r.fleet_no=veh.fleet_no inner join my_acbook ac on (r.cldocno=ac.cldocno and ac.dtype='CRM')"+
						" where r.status=3 "+sqlbranch+sqltest;
			}
			if(reftype.equalsIgnoreCase("LAG")){
/*				table="select ac.refname,l.doc_no,l.voc_no,l.date,if(l.perfleet=0,l.tmpfleet,l.perfleet) fleet_no,'LAG' reftype,veh.reg_no,coalesce(insurexcess,0.0)"+
						" insurexcess from gl_lagmt l left join gl_vehmaster veh on (l.perfleet=veh.fleet_no or l.tmpfleet=veh.fleet_no) left join my_acbook ac"+
						" on (l.cldocno=ac.cldocno and ac.dtype='CRM') where l.status=3 and l.brhid="+branch+sqltest;*/
				if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
					sqlbranch+=" and l.brhid="+branch;
				}
				
				table="select mov.doc_no,mov.rdocno,mov.rdtype,ac.refname,l.doc_no,l.voc_no,l.date,mov.fleet_no,'LAG' reftype,veh.reg_no,coalesce(insurexcess,0.0) "+
				" insurexcess from gl_lagmt l left join gl_vmove mov on (mov.doc_no=(select max(doc_no) from gl_vmove where rdocno=l.doc_no and rdtype='LAG' group "+
				" by rdtype,rdocno)) left join gl_vehmaster veh on mov.fleet_no=veh.fleet_no left join my_acbook ac on (l.cldocno=ac.cldocno and ac.dtype='CRM')  "+
				" where l.status=3 "+sqlbranch+sqltest+" group by mov.rdtype,mov.rdocno";
				
			}
			if(reftype.equalsIgnoreCase("RPL")){
				String sqlfleet="";
				if(type.equalsIgnoreCase("IN")){
					sqlfleet="rep.rfleetno";
				}
				else if(type.equalsIgnoreCase("OUT")){
					sqlfleet="rep.ofleetno";
				}
				else{
					sqlfleet="rep.rfleetno";
				}
				
				if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
					sqlbranch+=" and rep.inbrhid="+branch;
				}
				
				table="select distinct rep.doc_no,rep.doc_no voc_no,rep.date,"+sqlfleet+" fleet_no,'RPL' reftype,veh.reg_no,ac.refname,"+
						" coalesce(if(rep.rtype='RAG',rag.insex,lag.insurexcess),0.0) insurexcess from gl_vehreplace rep left join gl_ragmt rag on"+
						" (rep.rdocno=rag.doc_no and rep.rtype='RAG') left join gl_lagmt lag on (rep.rdocno=lag.doc_no and rep.rtype='LAG') left join"+
						" gl_vehmaster veh on ("+sqlfleet+"=veh.fleet_no) left join my_acbook ac on (if(rep.rtype='RAG',rag.cldocno=ac.cldocno,lag.cldocno=ac.cldocno)"+
						" and ac.dtype='CRM') where rep.status=3 "+sqlbranch+sqltest;
			}
			if(reftype.equalsIgnoreCase("NRM")){
				
				if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
					sqlbranch+=" and nrm.brhid="+branch;
				}
				
				table="select distinct nrm.fleet_no,nrm.doc_no,nrm.doc_no voc_no,nrm.date,'NRM' reftype,0 insurexcess,veh.reg_no,sal.sal_name refname from gl_nrm nrm "+
						" left join gl_vehmaster veh  on  (nrm.fleet_no=veh.fleet_no) left join my_salesman sal on (if(nrm.movtype='ST',(nrm.staffid=sal.doc_no and "+
						" sal.sal_type='STF'), (nrm.drid=sal.doc_no and sal.sal_type='DRV'))) where nrm.status=3 "+sqlbranch+sqltest;
			}
			//System.out.println(table);
			ResultSet resultSet = stmtmanual.executeQuery(table);

			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	    conn.close();
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	public   JSONArray getDamage() throws SQLException {
	    List<ClsVehicleInspectionBean> vehicleinspectionbean = new ArrayList<ClsVehicleInspectionBean>();
	  String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn =null;
		try {
			conn=objconn.getMyConnection();
			
			Statement stmtmanual = conn.createStatement ();
			strSql="select type code1,name description1,doc_no docno1 from gl_damage";
			ResultSet resultSet = stmtmanual.executeQuery (strSql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	public   JSONArray getComplaint() throws SQLException {
	    List<ClsVehicleInspectionBean> vehicleinspectionbean = new ArrayList<ClsVehicleInspectionBean>();
	  String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn =null;
		try {
			conn=objconn.getMyConnection();
					
			Statement stmtmanual = conn.createStatement ();
			strSql="select compname,doc_no docno from gl_complaint where status<>7";
			ResultSet resultSet = stmtmanual.executeQuery (strSql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	public   JSONArray getNewDamage(String fleet,String docno,String formdetailcode) throws SQLException {
	    List<ClsVehicleInspectionBean> vehicleinspectionbean = new ArrayList<ClsVehicleInspectionBean>();
	  
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn =null;
	    try {
			conn=objconn.getMyConnection();
			Statement stmtmanual = conn.createStatement ();
			String strSql="select  replace(inspd.path,'\\\\',';') path,dmg.name description,dmg.type code,inspd.type,inspd.remarks,inspd.attach upload,inspd.rowno srno,dmg.doc_no dmgid"+
					" from gl_vinspm insp left join gl_vinspd inspd on insp.doc_no=inspd.rdocno left join gl_damage dmg on"+
					" inspd.dmid=dmg.doc_no where inspd.dm=0 and insp.rfleet='"+fleet+"' and insp.doc_no='"+docno+"' group by inspd.rowno";
			ResultSet resultSet = stmtmanual.executeQuery (strSql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	    finally{
	    	conn.close();
	    }
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	public   JSONArray getNewMaintenance(String fleet,String docno) throws SQLException {
	    List<ClsVehicleInspectionBean> vehicleinspectionbean = new ArrayList<ClsVehicleInspectionBean>();
	    Connection conn =null;
	    JSONArray RESULTDATA=new JSONArray();
		try {
			conn=objconn.getMyConnection();
			Statement stmtmanual = conn.createStatement ();
			String strSql="select comp.compname description,comp.doc_no doc,inspd.remarks from gl_vinspm insp left join gl_vinspd inspd on "+
					"insp.doc_no=inspd.rdocno left join gl_complaint comp on inspd.dmid=comp.doc_no where inspd.dm=1 and insp.rfleet='"+fleet+"' and insp.doc_no='"+docno+"'";
			ResultSet resultSet = stmtmanual.executeQuery (strSql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	public   JSONArray getExistDamage(String fleet,String docno) throws SQLException {
	    List<ClsVehicleInspectionBean> vehicleinspectionbean = new ArrayList<ClsVehicleInspectionBean>();
	  String strSql="";
	  Connection conn =null;
	    JSONArray RESULTDATA=new JSONArray();
		try {
			conn=objconn.getMyConnection();
			Statement stmtmanual = conn.createStatement ();
			//System.out.println("getdid"+docno);
			if(docno.equalsIgnoreCase("0")){
				strSql="select dmg.name description,dmg.type code,inspd.type,inspd.remarks,inspd.attach upload,dmg.doc_no dmgid,inspd.rowno from gl_vinspm insp left join"+
						" gl_vinspd inspd on insp.doc_no=inspd.rdocno left join gl_damage dmg on inspd.dmid=dmg.doc_no where inspd.dm=0 and"+
						"  insp.rfleet="+fleet+" and inspd.clstatus=0";
//				System.out.println("EXIST DAMAGE SQL"+strSql);
				ResultSet resultSet = stmtmanual.executeQuery(strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
			}
			else{
				strSql="select dmg.name description,dmg.type code,inspd.type,inspd.remarks,inspd.attach upload,dmg.doc_no dmgid,inspd.rowno from gl_vinspm insp"+
						" left join gl_vinspd inspd on insp.doc_no=inspd.rdocno left join gl_damage dmg on inspd.dmid=dmg.doc_no where inspd.dm=0"+
						" and insp.rfleet="+fleet+" and insp.doc_no != "+docno+" and inspd.rdocno <= "+docno ;
//				System.out.println("EXIST DAMAGE SQL"+strSql);
				ResultSet resultSet = stmtmanual.executeQuery(strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
			}
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	public   JSONArray getExistComplaint(String fleet,String docno) throws SQLException {
	    List<ClsVehicleInspectionBean> vehicleinspectionbean = new ArrayList<ClsVehicleInspectionBean>();
	  String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn =null;
		try {
			conn=objconn.getMyConnection();
			Statement stmtmanual = conn.createStatement ();
//			System.out.println("getcmpid"+docno);
			if(docno.equalsIgnoreCase("0")){
				strSql="select comp.compname description,comp.doc_no doc,inspd.remarks from gl_vinspm insp left join gl_vinspd inspd on insp.doc_no=inspd.rdocno "+
						" left join gl_complaint comp on inspd.dmid=comp.doc_no where inspd.dm=1 and insp.rfleet="+fleet+"  and inspd.clstatus=0";
//				System.out.println("getexistcomplaint"+strSql);
				ResultSet resultSet = stmtmanual.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
			}
			else{
				strSql="select comp.compname description,comp.doc_no doc,inspd.remarks from gl_vinspm insp left join gl_vinspd inspd on insp.doc_no=inspd.rdocno "+
						" left join gl_complaint comp on inspd.dmid=comp.doc_no where inspd.dm=1 and insp.date<inspd.cldate and insp.date<CURDATE() "
						+ "and insp.rfleet="+fleet;

//				System.out.println("getexistcomplaint"+strSql);
				ResultSet resultSet = stmtmanual.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
			}
			
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	public   JSONArray getSearchData(HttpSession session) throws SQLException {
	    List<ClsVehicleInspectionBean> vehicleinspectionbean = new ArrayList<ClsVehicleInspectionBean>();
	  String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn =null;
	    try {
			conn=objconn.getMyConnection();
			Statement stmtmanual = conn.createStatement ();
			/*strSql="select insp.doc_no,insp.date,insp.type,insp.reftype,insp.refdocno,insp.amount,insp.accident,insp.polrep,insp.acdate,"+
					" insp.coldate,insp.place,insp.fine,insp.remarks,insp.claim,insp.rfleet from gl_vinspm insp where insp.status<>7 and insp.brhid='"+session.getAttribute("BRANCHID").toString()+"'";
			*/
				strSql="select ac.refname,veh.reg_no,insp.agmtbranch,insp.doc_no,insp.date,insp.type,insp.reftype,insp.refdocno,insp.amount,insp.accident,insp.polrep,"+
		" insp.acdate,insp.coldate,insp.place,insp.fine,insp.remarks,insp.claim,insp.rfleet from gl_vinspm insp left join gl_vehmaster veh"+
		" on insp.rfleet=veh.fleet_no left join gl_ragmt rag on (insp.reftype='RAG' and insp.refdocno=rag.doc_no) left join gl_lagmt lag"+
		" on (insp.reftype='LAG' and insp.refdocno=lag.doc_no) left join gl_vehreplace rep on (insp.reftype='RPL' and insp.refdocno=rep.doc_no)"+
		" left join gl_ragmt reprag on (rep.rtype='RAG' and rep.rdocno=reprag.doc_no) left join gl_lagmt replag on (rep.rtype='LAG' and"+
		" rep.rdocno=replag.doc_no) left join my_acbook ac on (case when insp.reftype='RAG' then (rag.cldocno=ac.cldocno and ac.dtype='CRM')"+
		" when insp.reftype='LAG' then (lag.cldocno=ac.cldocno and ac.dtype='CRM') when (insp.reftype='RPL' and rep.rtype='RAG') then"+
		" (reprag.cldocno=ac.cldocno and ac.dtype='CRM') when (insp.reftype='RPL' and rep.rtype='LAG') then"+
		" (replag.cldocno=ac.cldocno and ac.dtype='CRM') else 0 end) where insp.status<>7 and insp.brhid='"+session.getAttribute("BRANCHID").toString()+"'";
			ResultSet resultSet = stmtmanual.executeQuery (strSql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	    finally{
	    	conn.close();
	    }
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	public int insert(Date date, String cmbtype, String cmbreftype,int rdocno, Date accdate, String prcs, Date collectdate,String accplace,
			String accfines, String cmbclaim, String amount,String formdetailcode,String hidaccidents,String accremarks,HttpSession session,
			String mode,String rfleet,ArrayList<String> damagearray,ArrayList<String> maintenancearray,ArrayList<String> existdamagearray,
			String time,String refvoucherno,String branch,String agmtbranch) throws SQLException {
		// TODO Auto-generated method stub
//	System.out.println("ACC"+hidaccidents);
	Connection conn=null;
		try{
			int val;
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			if(accfines.equalsIgnoreCase("")){
				accfines="0";
			}
			if(amount.equalsIgnoreCase("")){
				amount="0";
			}
			if(hidaccidents.equalsIgnoreCase("")){
				hidaccidents="0";
			}
			if(cmbclaim.equalsIgnoreCase("")){
				cmbclaim="0";
			}
			//accfines="round("+accfines+","+session.getAttribute("AMTDEC").toString()+")";
			//amount="round("+amount+","+session.getAttribute("AMTDEC").toString()+")";
			String tempround=session.getAttribute("AMTDEC").toString();
		CallableStatement stmtMovement = conn.prepareCall("{call vehInspectionDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		
		stmtMovement.registerOutParameter(16, java.sql.Types.INTEGER);
		stmtMovement.setDate(1,date);
		stmtMovement.setString(2,cmbtype);
		stmtMovement.setString(3,cmbreftype);
		stmtMovement.setInt(4, rdocno);
		stmtMovement.setString(5,amount);
		stmtMovement.setString(6,hidaccidents);
		stmtMovement.setString(7,prcs);
		stmtMovement.setDate(8,accdate);
		stmtMovement.setDate(9,collectdate);
		stmtMovement.setString(10,accplace);
		stmtMovement.setString(11,accfines);
		stmtMovement.setString(12,accremarks);
		stmtMovement.setString(13,cmbclaim);
		stmtMovement.setString(14,session.getAttribute("USERID").toString());
		stmtMovement.setString(15,branch);
		stmtMovement.setString(17, mode);
		stmtMovement.setString(18, formdetailcode);
		stmtMovement.setString(19, rfleet);
		stmtMovement.setString(20, tempround);
		stmtMovement.setString(21,time);
		stmtMovement.setString(22, refvoucherno);
		stmtMovement.setString(23, agmtbranch);
//		System.out.println(stmtMovement);
		stmtMovement.executeQuery();
		val=stmtMovement.getInt("docNo");
		//System.out.println("no====="+val);
		inspectionBean.setDocno(val);
		Statement stmtrcalc=conn.createStatement();
		String strrcalc="";
		String strinsurexcess="";
		if(cmbreftype.equalsIgnoreCase("RAG") && (Double.parseDouble(amount))>0){
			strrcalc="insert into gl_rcalc(brhid,rdocno,dtype,idno,amount,qty,invoiced,invno,invdate)values('"+session.getAttribute("BRANCHID").toString()+"',"+
			""+rdocno+",'"+cmbreftype+"',10,"+amount+",1,0,0,null)";
			if(!accfines.equalsIgnoreCase("") && !accfines.equalsIgnoreCase("0")){
				strinsurexcess="insert into gl_rcalc(brhid,rdocno,dtype,idno,amount,qty,invoiced,invno,invdate)values('"+session.getAttribute("BRANCHID").toString()+"',"+
						""+rdocno+",'"+cmbreftype+"',21,"+accfines+",1,0,0,null)";
			}
		}
		if(cmbreftype.equalsIgnoreCase("LAG") && (Double.parseDouble(amount))>0){
			strrcalc="insert into gl_lcalc(brhid,rdocno,dtype,idno,amount,qty,invoiced,invno,invdate)values('"+session.getAttribute("BRANCHID").toString()+"',"+
					""+rdocno+",'"+cmbreftype+"',10,"+amount+",1,0,0,null)";
		
			if(!accfines.equalsIgnoreCase("") && !accfines.equalsIgnoreCase("0")){
				strinsurexcess="insert into gl_lcalc(brhid,rdocno,dtype,idno,amount,qty,invoiced,invno,invdate)values('"+session.getAttribute("BRANCHID").toString()+"',"+
						""+rdocno+",'"+cmbreftype+"',21,"+accfines+",1,0,0,null)";
			}
		}
//		System.out.println("Check String: "+strrcalc);
		if(!(strrcalc.equalsIgnoreCase(""))){
			int rcalcval=stmtrcalc.executeUpdate(strrcalc);
			if(rcalcval<=0){
				if(!strinsurexcess.equalsIgnoreCase("")){
					int insurval=stmtrcalc.executeUpdate(strinsurexcess);
					if(insurval<=0){
						conn.close();
						return 0;
					}
				}
			}
		}
		
		if (val > 0) {
			for(int i=0;i< damagearray.size();i++){
				String[] damage=damagearray.get(i).split("::");
				if(!(damage[5].equalsIgnoreCase("undefined") || damage[5].isEmpty() || damage[5]==null)){
				String strdamage="insert into gl_vinspd(rowno,rdocno,dmid,type,remarks,attach,dm,fleetno)values('"+(i+1)+"','"+val+"','"+(damage[5].equalsIgnoreCase("undefined") || damage[5].isEmpty()?0:damage[5])+"',"+
				"'"+(damage[2].equalsIgnoreCase("undefined") || damage[2].isEmpty()?0:damage[2])+"','"+(damage[3].equalsIgnoreCase("undefined") || damage[3].isEmpty()?0:damage[3])+"','"+(damage[4].equalsIgnoreCase("undefined") || damage[4].isEmpty()?0:damage[4])+"',0,'"+rfleet+"')";
				Statement stmt=conn.createStatement();
//				System.out.println("Damage SQL"+strdamage);
				int val1=stmt.executeUpdate(strdamage);
				
				if(val1<=0){
					conn.close();
					return 0;
				}
				}
			}
			/*for(int i=0;i< existdamagearray.size();i++){
				String[] existdamage=existdamagearray.get(i).split("::");
				if(!(existdamage[0].equalsIgnoreCase("undefined") || existdamage[0].isEmpty() || existdamage[0]==null)){
				String strdamage="update gl_vinspd set rdocno="+val+" where srno="+(existdamage[0].equalsIgnoreCase("undefined") || existdamage[0].isEmpty()?0:existdamage[0])+"";
				Statement stmt=conn.createStatement();
				System.out.println("Exist Damage SQL"+strdamage);
				int val5=stmt.executeUpdate(strdamage);
				
				if(val5<=0){
					return 0;
				}
				}
			}*/
			for(int i=0;i< maintenancearray.size();i++){
				String[] maintenance=maintenancearray.get(i).split("::");
				if(!(maintenance[2].equalsIgnoreCase("undefined") || maintenance[2].isEmpty() || maintenance[2]==null)){
				String strmaintenance="insert into gl_vinspd(rowno,rdocno,dmid,remarks,dm,fleetno)values('"+(i+1)+"','"+val+"','"+(maintenance[2].equalsIgnoreCase("undefined") || maintenance[2].isEmpty()?0:maintenance[2])+"',"+
				"'"+(maintenance[1].equalsIgnoreCase("undefined") || maintenance[1].isEmpty()?0:maintenance[1])+"',1,'"+rfleet+"')";
				Statement stmt=conn.createStatement();
//				System.out.println("MAINTENANCE SQL"+strmaintenance);
				int val1=stmt.executeUpdate(strmaintenance);
				if(val1<=0){
					conn.close();
					return 0;
				}
			}
			}
//			System.out.println("Success"+inspectionBean.getDocno());
			if(inspectionBean.getDocno()>0){
			conn.commit();
			stmtMovement.close();
			conn.close();
			return val;
			}
		}
		stmtMovement.close();
		conn.close();
	}catch(Exception e){	
	e.printStackTrace();
	conn.close();
	return 0;
	}
		finally{
			conn.close();
		}
	
	return 0;
}
	public boolean delete(Date date, String cmbtype, String cmbreftype,
			int rdocno, Date accdate, String prcs, Date collectdate,
			String accplace, String accfines, String cmbclaim, String amount,
			String formdetailcode, String hidaccidents, String accremarks,
			HttpSession session, String mode, String rfleet, int docno,String time) throws SQLException {
		Connection conn=null;
	//	System.out.println(date+"::"+cmbtype+"::"+cmbreftype+"::"+rdocno+"::"+accdate+"::"+prcs+"::"+collectdate+"::"+accplace+"::"+accfines+"::"+cmbclaim+"::"+amount+"::"+formdetailcode+"::"+hidaccidents+"::"+accremarks+"::"+session+"::"+mode+"::"+rfleet+"::"+docno+"::"+time);
		
		try {
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			
			accfines=accfines==null || accfines.equalsIgnoreCase("")?"0":accfines;
			amount=amount==null || amount.equalsIgnoreCase("")?"0":amount;
			hidaccidents=hidaccidents==null || hidaccidents.equalsIgnoreCase("")?"0":hidaccidents;
			/*if(accfines.equalsIgnoreCase("")){
				accfines="0";
			}
			if(amount.equalsIgnoreCase("")){
				amount="0";
			}
			if(hidaccidents.equalsIgnoreCase("")){
				hidaccidents="0";
			}
			*/
		CallableStatement stmtMovement = conn.prepareCall("{call vehInspectionDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtMovement.setInt(16, docno);
			stmtMovement.setDate(1,date);
			stmtMovement.setString(2,cmbtype);
			stmtMovement.setString(3,cmbreftype);
			stmtMovement.setInt(4, rdocno);
			stmtMovement.setString(5,amount);
			stmtMovement.setInt(6,1);
			stmtMovement.setString(7,prcs);
			stmtMovement.setDate(8,accdate);
			stmtMovement.setDate(9,collectdate);
			stmtMovement.setString(10,accplace);
			stmtMovement.setString(11,accfines);
			stmtMovement.setString(12,accremarks);
			stmtMovement.setString(13,cmbclaim);
			stmtMovement.setString(14,session.getAttribute("USERID").toString());
			stmtMovement.setString(15,null);
			stmtMovement.setString(17, mode);
			stmtMovement.setString(18, formdetailcode);
			stmtMovement.setString(19, rfleet);
			stmtMovement.setString(20, null);
			stmtMovement.setString(21,time);
			stmtMovement.setString(22, null);
			stmtMovement.setString(23, null);
//		System.out.println(stmtMovement);
		int val=stmtMovement.executeUpdate();
		if(val>0){
			conn.commit();
			stmtMovement.close();
			conn.close();
			return true;
		}
		stmtMovement.close();
		conn.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		// TODO Auto-generated method stub
		return false;
	}

	public   ClsVehicleInspectionBean getPrint(int docno) throws SQLException {
		// TODO Auto-generated method stub
		ClsVehicleInspectionBean bean=new ClsVehicleInspectionBean();
		Connection conn=null;
		try {
			conn=objconn.getMyConnection();
			Statement printstmt=conn.createStatement();
			String strprintmaster="select concat(case when insp.reftype='RAG' then agmt.voc_no when insp.reftype='LAG' then lagmt.voc_no when insp.reftype='NRM' then"+
			" nrm.doc_no when insp.reftype='RPL' then rep.doc_no end,'    ',coalesce(ac.refname,'')) docdetails, comp.company,comp.address,comp.tel,comp.fax,br.branchname,"+
			" insp.doc_no,DATE_FORMAT(insp.date,'%d/%m/%Y') date,insp.time,insp.type,case when insp.reftype='RAG' then 'Rental' when insp.reftype='LAG' then"+
			" 'Lease' when insp.reftype='RPL' then 'Replacement' when insp.reftype='NRM' then 'Non Revenue Movement' end reftype,insp.refdocno,insp.rfleet,"+
			" round(insp.amount,2) amount,insp.accident,DATE_FORMAT(insp.acdate,'%d/%m/%Y') acdate,insp.polrep,DATE_FORMAT(insp.coldate,'%d/%m/%Y') coldate,"+
			" insp.place,round(insp.fine,2) fine,if(insp.claim=1,'Own','Third Party') claim,insp.remarks from gl_vinspm insp left join gl_ragmt agmt on "+
			" (insp.reftype='RAG' and insp.refdocno=agmt.doc_no) left join gl_lagmt lagmt on (insp.reftype='LAG' and insp.refdocno=lagmt.doc_no) left join gl_nrm nrm on"+
			" (insp.reftype='NRM' and insp.refdocno=nrm.doc_no) left join gl_vehreplace rep on (insp.reftype='RPL' and insp.refdocno=rep.doc_no)"+
			" left join gl_ragmt reprag on (insp.reftype='RPL' and rep.rtype='RAG' and rep.rdocno=reprag.doc_no) left join gl_lagmt replag on "+
			" (insp.reftype='RPL' and rep.rtype='LAG' and rep.rdocno=replag.doc_no) left join my_acbook ac on ((case when insp.reftype='RAG' then agmt.cldocno when "+
			" insp.reftype='LAG' then lagmt.cldocno when insp.reftype='RPL' and rep.rtype='RAG' then reprag.cldocno when insp.reftype='RPL' and rep.rtype='LAG' then "+
			" replag.cldocno else 0 end)=ac.cldocno and ac.dtype='CRM') left join my_brch br on insp.brhid=br.doc_no left join my_comp comp on br.cmpid=comp.doc_no "+
			" where insp.doc_no="+docno+" and insp.status=3";
			ResultSet rsprintmaster=printstmt.executeQuery(strprintmaster);
			while(rsprintmaster.next()){
				bean.setLblcompname(rsprintmaster.getString("company"));
				bean.setLblcompaddress(rsprintmaster.getString("address"));
				bean.setLblcomptel(rsprintmaster.getString("tel"));
				bean.setLblcompfax(rsprintmaster.getString("fax"));
				bean.setLblbranch(rsprintmaster.getString("branchname"));
				bean.setLbldate(rsprintmaster.getString("date"));
				bean.setLbldocno(rsprintmaster.getString("doc_no"));
				bean.setLbltime(rsprintmaster.getString("time"));
				bean.setLbltype(rsprintmaster.getString("type"));
				bean.setLblreftype(rsprintmaster.getString("reftype"));
				bean.setLblrefdocno(rsprintmaster.getString("docdetails"));
				bean.setLblreffleetno(rsprintmaster.getString("rfleet"));
				bean.setLblamount(rsprintmaster.getString("amount")); 
				bean.setLblaccident(rsprintmaster.getString("accident"));
				bean.setLblaccdate(rsprintmaster.getString("acdate"));
				bean.setLblprcs(rsprintmaster.getString("polrep"));
				bean.setLblcoldate(rsprintmaster.getString("coldate"));
				bean.setLblplace(rsprintmaster.getString("place"));
				bean.setLblfines(rsprintmaster.getString("fine"));
				
				if(bean.getLblaccident().equalsIgnoreCase("1")){
					bean.setLblclaim(rsprintmaster.getString("claim"));	
				}
				else{
					bean.setLblclaim(" ");
				}
				
				bean.setLblremarks(rsprintmaster.getString("remarks"));
				
			}
			printstmt.close();
			conn.close();
			return bean;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			conn.close();
			return null;
		}
		finally{
			conn.close();
		}
		
	}

	public   ArrayList<String> getExistingDamagePrint(int docno,String fleetno) throws SQLException {
		// TODO Auto-generated method stub
		ArrayList<String> existarray=new ArrayList<String>();
		Connection conn=null;
		try {
			conn=objconn.getMyConnection();
			Statement stmtexist=conn.createStatement();
			String strexist="select dmg.name description,dmg.type code,inspd.type,if(inspd.remarks='0','',inspd.remarks) remarks from gl_vinspm insp left join gl_vinspd inspd on"+
					" insp.doc_no=inspd.rdocno left join gl_damage dmg on inspd.dmid=dmg.doc_no where inspd.dm=0 and insp.rfleet="+fleetno+""+
					" and insp.doc_no !="+docno+" and inspd.rdocno <="+docno;
//			System.out.println("Existing Query:"+strexist);
			
			ResultSet rsexist=stmtexist.executeQuery(strexist);
			int i=1;
			while(rsexist.next()){
				String temp=i+"::"+rsexist.getString("code")+"::"+rsexist.getString("description")+"::"+rsexist.getString("type")+"::"+rsexist.getString("remarks");
				i++;
				existarray.add(temp);
			}
//			System.out.println("Existing Array:"+existarray);
			stmtexist.close();
			conn.close();
			return existarray;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			conn.close();
			return null;
		}
		finally{
			conn.close();
		}
	}

	public   ArrayList<String> getNewDamagePrint(int docno,String fleetno) throws SQLException {
		
		// TODO Auto-generated method stub
		ArrayList<String> newarray=new ArrayList<String>();
		Connection conn=null;
		try {
			conn=objconn.getMyConnection();
			Statement stmtnew=conn.createStatement();
			String strnew="select  dmg.name description,dmg.type code,inspd.type,if(inspd.remarks='0','',inspd.remarks) remarks from gl_vinspm insp left join gl_vinspd inspd on"+
					" insp.doc_no=inspd.rdocno left join gl_damage dmg on inspd.dmid=dmg.doc_no where inspd.dm=0 and insp.rfleet="+fleetno+""+
					" and insp.doc_no="+docno+" group by inspd.rowno";
			ResultSet rsexist=stmtnew.executeQuery(strnew);
			int i=1;
			while(rsexist.next()){
				String temp=i+"::"+rsexist.getString("code")+"::"+rsexist.getString("description")+"::"+rsexist.getString("type")+"::"+rsexist.getString("remarks");
				i++;
				newarray.add(temp);
			}
			
			stmtnew.close();
			conn.close();
			return newarray;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			conn.close();
			return null;
		}
		finally{
			conn.close();
		}
	}



	public   ArrayList<String> getNewDamagePrintPics(int docno,
			String fleetno,String url) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		ArrayList<String> picarray=new ArrayList<String>();
		try {
			conn=objconn.getMyConnection();
			Statement stmtnew=conn.createStatement();
			String strnew="select coalesce(inspd.path,'') path from gl_vinspm insp left join gl_vinspd inspd on"+
					" insp.doc_no=inspd.rdocno left join gl_damage dmg on inspd.dmid=dmg.doc_no where inspd.dm=0 and insp.rfleet="+fleetno+""+
					" and insp.doc_no="+docno+" group by inspd.rowno";
			ResultSet rsexist=stmtnew.executeQuery(strnew);
			int i=1;
			while(rsexist.next()){
				if(!rsexist.getString("path").equalsIgnoreCase("")){
					String temp=rsexist.getString("path").split("webapps")[1];
					
					//System.out.println(temp);
					i++;
					picarray.add(url+temp);
				}
				
			}
			
			stmtnew.close();
			conn.close();
			return picarray;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			conn.close();
			return null;
		}
		finally{
			conn.close();
		}
	}
}
