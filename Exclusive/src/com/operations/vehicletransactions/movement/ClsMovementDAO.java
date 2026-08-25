package com.operations.vehicletransactions.movement;

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
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsMovementDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsMovementBean movementbean=new ClsMovementBean();
	public  JSONArray fleetSearch(String branch,String searchdate,String fleetno,String docno,String regno,String color,String group) throws SQLException {
	    List<ClsMovementBean> movementbean = new ArrayList<ClsMovementBean>();
	    Connection conn = null;
	    JSONArray RESULTDATA=new JSONArray();
		try {
			conn=objconn.getMyConnection();
			java.sql.Date sqldate=null;
			String sqltest="";
			if(!(searchdate.equalsIgnoreCase(""))){
				sqldate=objcommon.changeStringtoSqlDate(searchdate);
			}
			if(!(docno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and v.doc_no like '%"+docno+"%'";
			}
			if(!(fleetno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and v.fleet_no like '%"+fleetno+"%'";
			}
			if(!(regno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and v.reg_no like '%"+regno+"%'";
			}
			if(sqldate!=null){
				sqltest=sqltest+" and v.date='"+sqldate+"'";
				
			}
			if(!(group.equalsIgnoreCase(""))){
				sqltest=sqltest+" and v.vgrpid like '%"+group+"%'";
			}
			if(!(color.equalsIgnoreCase(""))){
				sqltest=sqltest+" and v.clrid like '%"+color+"%'";
			}
				Statement stmtmovement = conn.createStatement ();
	        	String strSql="select v.tran_code,v.doc_no,v.date,v.reg_no,v.fleet_no,v.FLNAME,m.fin,round(m.kmin,2) kmin,c.color,g.gid,m.din,m.tin,m.ilocid,m.ibrhid from gl_vehmaster v left join gl_vmove m"+
	        			" on v.fleet_no=m.fleet_no left join my_color c  on v.clrid=c.doc_no left join gl_vehgroup g on g.doc_no=v.vgrpid where"+
	        			" v.a_br='"+branch+"' and v.statu <> 7 and  v.fstatus in ('L','N') and v.status='IN'and m.doc_no=(select"+
	        			" (max(doc_no)) from gl_vmove where fleet_no=v.fleet_no) and  v.fstatus in ('L','N')  and v.status='IN' "+sqltest;
	        	System.out.println(strSql);
				ResultSet resultSet = stmtmovement.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtmovement.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
//		System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	
	
	 public   JSONArray mainSearch(String reftype,String searchdate,String fleetno,String docno,String regno,String status) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	    	    	
	       // String brnchid=session.getAttribute("BRANCHID").toString();
	    	//System.out.println("name"+sclname);
	    	Connection conn=null;
	    	try{		
	    	String sqltest="";
	    	java.sql.Date sqldate=null;
	    	if(!(searchdate.equalsIgnoreCase(""))){
	    		sqldate=objcommon.changeStringtoSqlDate(searchdate);	
	    	}
	    	
	    
	    	if(!(reftype.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and nrm.movtype like '%"+reftype+"%'";
	    	}
	    	
	    	if(!(fleetno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and nrm.fleet_no like '%"+fleetno+"%'";
	    	}
//	    	System.out.println("0000000"+docno+"000000");
	    	if(!(docno.equalsIgnoreCase(""))){
//	    		System.out.println("Inside");
	    		sqltest=sqltest+" and nrm.doc_no="+docno+"";
	    	}
	    	
	    	 if(sqldate!=null){
	    		 sqltest=sqltest+" and nrm.date='"+sqldate+"'";
	    	 }
	        if(!(regno.equalsIgnoreCase(""))){
	        	sqltest=sqltest+" and veh.reg_no like '"+regno+"'";
	        }
	        if(!(status.equalsIgnoreCase(""))){
	        	sqltest=sqltest+" and nrm.clstatus="+status;
	        }
			
					conn=objconn.getMyConnection();
					Statement stmtsearch = conn.createStatement ();
					String str1Sql="select nrm.doc_no,nrm.date,nrm.fleet_no,if(nrm.clstatus=1,'IN','OUT') status,st.st_desc,veh.reg_no from gl_nrm nrm left join "+
							" gl_vehmaster veh on nrm.fleet_no=veh.fleet_no left join gl_status st on nrm.movtype=st.status where nrm.status<>7 "+sqltest+" group by nrm.doc_no";
//					System.out.println("=========="+str1Sql);
					ResultSet resultSet = stmtsearch.executeQuery (str1Sql);
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
	 
	 
	 
	public   ClsMovementBean getViewDetails(int docno) throws SQLException {
		//List<ClsVehicleBean> listBean = new ArrayList<ClsVehicleBean>();
		ClsMovementBean bean = new ClsMovementBean();
		Connection conn = null;
		try {
			conn=objconn.getMyConnection();
			Statement stmtMove = conn.createStatement ();
			int i=0;
        	String strSql="";
        	strSql="select closeuser.user_name closeusername,coalesce(nrm.vehtrancode,'') vehtrancode,nrm.outbranch,nrm.inbranch,nrm.closedr,cldrv.sal_name closedriver,nrm.doc_no,nrm.fleet_no,nrm.date,nrm.userid,nrm.drid,nrm.staffid,nrm.garageid,nrm.clstatus,nrm.delivery,nrm.collection,nrm.accd,"+
        			" mov.dout,mov.tout,round(mov.kmout,0) kmout,mov.trancode,round(mov.fout,3) fout,mov.olocid,mov.oreason,mov.din,mov.tin,"+
        			" round(mov.kmin,2) kmin,round(mov.fin,3) fin,mov.ibrhid,mov.ilocid,mov.ireason,mov.iaccident,round(mov.tkm,0) tkm,veh.reg_no,"+
        			" veh.flname,trim(grp.gid) gid,col.color,loc.doc_no locdoc,loc1.doc_no locdoc1,nrm.userid,usr.user_name,grg.name,st.sal_name staffname,"+
        			" dr.sal_name drname,tran.remarks accremarks,tran.auth_fne from gl_nrm nrm inner join gl_vmove mov on(nrm.doc_no=mov.rdocno and"+
        			" nrm.fleet_no=mov.fleet_no) left join gl_vehmaster veh on nrm.fleet_no=veh.fleet_no left join gl_vehgroup grp on"+
        			" veh.vgrpid=grp.doc_no left join my_color col on veh.clrid=col.doc_no left join my_locm loc on mov.olocid=loc.doc_no"+
        			" left join my_locm loc1 on mov.ilocid=loc1.doc_no left join my_user usr on nrm.userid=usr.doc_no left join my_user closeuser on "+
        			" nrm.closeuserid=closeuser.doc_no left join gl_garrage grg on"+
        			" nrm.garageid=grg.doc_no left join my_salesman dr on (nrm.drid=dr.doc_no and dr.sal_type='DRV') left join my_salesman cldrv on "+
			" (nrm.closedr=cldrv.doc_no and cldrv.sal_type='DRV') left join my_salesman st on"+
        			" (nrm.staffid=st.doc_no and st.sal_type='STF')left join gl_trandetails tran on (nrm.doc_no=tran.refno and tran.dtype='MOV')"+
        			" where mov.rdtype='MOV' and nrm.doc_no="+docno;
//        	System.out.println(strSql);
			ResultSet resultSet = stmtMove.executeQuery (strSql);
			
			while (resultSet.next()) {
				if(i==0){
					bean.setVehtrancode(resultSet.getString("vehtrancode"));
					bean.setDate(resultSet.getDate("date").toString());
				bean.setDocno(resultSet.getInt("doc_no"));
				bean.setTxtfleetno(resultSet.getInt("fleet_no"));
				String temp=resultSet.getString("flname");
				temp=temp+"Reg No:"+resultSet.getString("reg_no");
				temp=temp+"Group:"+resultSet.getString("gid");
				temp=temp+"Color:"+resultSet.getString("color");
				bean.setHidgarage(resultSet.getInt("garageid"));
				bean.setGarage(resultSet.getString("name"));
				bean.setHidchkgaragedelivery(resultSet.getInt("delivery"));
				bean.setHidchkgaragecollect(resultSet.getInt("collection"));
				bean.setTxtfleetname(temp);
				bean.setHidcmblocation(resultSet.getString("olocid"));
//				System.out.println("Out Location in DAO:"+resultSet.getString("olocid")); 
				bean.setOutremarks(resultSet.getString("oreason"));
				bean.setHidcmbcloselocation(resultSet.getString("ilocid"));
				bean.setCloseremarks(resultSet.getString("ireason"));
				bean.setCloseuser(resultSet.getString("closeusername"));
				bean.setOutuser(resultSet.getString("user_name"));
				bean.setOutuserid(resultSet.getInt("userid"));
				bean.setHidcloseuser(resultSet.getInt("userid"));
				bean.setHidcmbaccidents(resultSet.getString("accd"));
				bean.setHiddriver(resultSet.getString("drid"));
				bean.setDriver(resultSet.getString("drname"));
				bean.setHidstaff(resultSet.getInt("staffid"));
				bean.setStaff(resultSet.getString("staffname"));
				bean.setAccdetails(resultSet.getString("accremarks"));
				bean.setAccfines(resultSet.getFloat("auth_fne"));
				bean.setClosedriver(resultSet.getString("closedriver"));
				bean.setHidclosedriver(resultSet.getString("closedr"));
				bean.setClosestaff(bean.getStaff());
				bean.setClstatus(resultSet.getString("clstatus"));
				bean.setDeliverystatus(resultSet.getString("delivery"));
				bean.setHidcmbbranch(resultSet.getString("outbranch"));
				bean.setHidcmbclosebranch(resultSet.getString("inbranch"));
				}
				if(!(resultSet.getString("trancode").equalsIgnoreCase("DL"))){
					bean.setHidcmbstatus(resultSet.getString("trancode"));
				}
				if(i==0 && resultSet.getString("trancode").equalsIgnoreCase("DL") && resultSet.getInt("delivery")==1){
					bean.setDateout(resultSet.getDate("dout").toString());
					bean.setHidtimeout(resultSet.getString("tout"));
					bean.setOutkm(resultSet.getString("kmout"));
					bean.setHidcmboutfuel(resultSet.getString("fout"));
					bean.setGaragedeliverydate(resultSet.getDate("din").toString());
					bean.setHidgaragedeliverytime(resultSet.getString("tin"));
					bean.setGaragedeliverykm(resultSet.getFloat("kmin"));
					bean.setHidcmbgaragedeliveryfuel(resultSet.getString("fin"));
					
				}
				else if((i==1) && (resultSet.getString("trancode").equalsIgnoreCase("DL")) && (resultSet.getInt("delivery")==1)){
					System.out.println("Delivery");
					bean.setDateout(resultSet.getDate("dout").toString());
					bean.setHidtimeout(resultSet.getString("tout"));
					bean.setOutkm(resultSet.getString("kmout"));
					bean.setHidcmboutfuel(resultSet.getString("fout"));
					//System.out.println("Delivery Fuel");
					bean.setGaragedeliverydate(resultSet.getDate("din").toString());
					//System.out.println("Delivery Date Check:"+bean.getGaragedeliverydate());
					bean.setHidgaragedeliverytime(resultSet.getString("tin"));
					bean.setGaragedeliverykm(resultSet.getFloat("kmin"));
					bean.setHidcmbgaragedeliveryfuel(resultSet.getString("fin"));
					//bean.setTotalkm(resultSet.getFloat("tkm"));
				}
				else if((i>1) && (resultSet.getString("trancode").equalsIgnoreCase("DL")) && (resultSet.getInt("collection")==1)){
					System.out.println("Collection");
					bean.setGaragecollectdate(resultSet.getDate("dout").toString());
					bean.setHidgaragecollecttime(resultSet.getString("tout"));
					bean.setGaragecollectkm(resultSet.getFloat("kmout"));
					bean.setHidcmbgaragecollectfuel(resultSet.getString("fout"));
//					System.out.println("Bean Collection Fuel"+bean.getHidcmbgaragecollectfuel());
					bean.setClosedate(resultSet.getDate("din").toString());
					bean.setHidclosetime(resultSet.getString("tin"));
					bean.setClosekm(resultSet.getFloat("kmin"));
					bean.setHidcmbclosefuel(resultSet.getString("fin"));
//					System.out.println("Bean Close Fuel"+bean.getHidcmbclosefuel());
					//bean.setTotalkm(resultSet.getFloat("tkm"));
				}
				else if((!(resultSet.getString("trancode").equalsIgnoreCase("DL"))) && (resultSet.getInt("collection")==0) && (resultSet.getInt("delivery")==0)){
					System.out.println("Normal");
					if(resultSet.getDate("dout")!=null){
						bean.setDateout(resultSet.getDate("dout").toString());	
					}
					
					bean.setHidtimeout(resultSet.getString("tout"));
					bean.setOutkm(resultSet.getString("kmout"));
					bean.setHidcmboutfuel(resultSet.getString("fout"));
					if(resultSet.getDate("din")!=null){
						bean.setClosedate(resultSet.getDate("din").toString());	
					}
					
					bean.setHidclosetime(resultSet.getString("tin"));
					bean.setClosekm(resultSet.getFloat("kmin"));
					bean.setHidcmbclosefuel(resultSet.getString("fin"));
					//bean.setTotalkm(resultSet.getFloat("tkm"));
					
				}
				else{
					/*
					bean.setDateout(resultSet.getDate("dout").toString());
					bean.setHidtimeout(resultSet.getString("tout"));
					bean.setOutkm(resultSet.getString("kmout"));
					bean.setHidcmboutfuel(resultSet.getString("fout"));
					*///bean.setTotalkm(resultSet.getFloat("tkm"));
				}
				i++;
			}
				
			if(bean.getClstatus().equalsIgnoreCase("1")){
				bean.setTotalkm(bean.getClosekm()-Float.parseFloat(bean.getOutkm()));	
				
			}
			
//			System.out.println("Out Loop delivery date:"+bean.getGaragedeliverydate());
		stmtMove.close();
		conn.close();
		}
		
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		
		return bean;
	}	
	
	
	public   JSONArray maintenanceSearch(String value) throws SQLException {
	    List<ClsMovementBean> movementbean = new ArrayList<ClsMovementBean>();
	  String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn =null;
		try {
			conn= objconn.getMyConnection();
			value=value.replace('"', ' ');
			value=value.trim();
				
				Statement stmtmovement = conn.createStatement ();
				if(value.equalsIgnoreCase("Maintenance")){
//					System.out.println("value"+value);
					strSql="select name,doc_no from gl_prmaster where status<>7";
				}
				else if(value.equalsIgnoreCase("Damage")){
//					System.out.println("value"+value);
					strSql="select name,doc_no from gl_damage where status<>7";
				}
				else{
//					System.out.println("Error Value"+value);
				}
//	        	System.out.println(strSql);
				ResultSet resultSet = stmtmovement.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtmovement.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
//		System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	public   JSONArray driverSearch(String trancode) throws SQLException {
	    List<ClsMovementBean> movementbean = new ArrayList<ClsMovementBean>();
	  String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn = null;
		try {
			conn= objconn.getMyConnection();
				
				Statement stmtmovement = conn.createStatement ();
				
				strSql="select sal.doc_no,sal.sal_name from my_salesman sal"+
						" where sal.sal_type='DRV' and sal.status=3";
			
				
				/*final query for driver validation
				 * commented for epic now
				 * strSql="select sal.doc_no,sal.sal_name from my_salesman sal where status<>7 and sal_type='DRV' and doc_no"+
						" not in (select distinct(drid) from gl_nrm where 1=1 and ((delivery=0  and movtype in ('GA','GM','GS')) or"+
						" (clstatus=0  and movtype in ('tr','ST'))) and drid!=0)";*/
			//	System.out.println("Driver Sql:"+strSql);
				ResultSet resultSet = stmtmovement.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtmovement.close();
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
	public   JSONArray staffSearch(String session1) throws SQLException {
	    List<ClsMovementBean> movementbean = new ArrayList<ClsMovementBean>();
	  String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
	    try {
			conn= objconn.getMyConnection();
		
				Statement stmtmovement = conn.createStatement ();
				strSql="select sal.doc_no dr_id,sal.sal_name name from my_salesman sal"+
						" where sal.sal_type='STF' and sal.status<>7";
//	        	System.out.println(strSql);
				  /*and sal.doc_no not in (select staffid from gl_nrm where clstatus=0)*/
				ResultSet resultSet = stmtmovement.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtmovement.close();
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
	public   JSONArray garageSearch() throws SQLException {
	    List<ClsMovementBean> movementbean = new ArrayList<ClsMovementBean>();
	  String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn = null;
	    try {
	    	conn= objconn.getMyConnection();
				
				Statement stmtmovement = conn.createStatement ();
				strSql="select name,doc_no from gl_garrage where  status<>7";
//	        	System.out.println(strSql);
				
				ResultSet resultSet = stmtmovement.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtmovement.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	    finally{
			conn.close();
		}
//		System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	public   JSONArray mainSearch(String session) throws SQLException {
	    List<ClsMovementBean> movementbean = new ArrayList<ClsMovementBean>();
	  String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn = null;
	    try {
			
	    	conn= objconn.getMyConnection();
				Statement stmtmovement = conn.createStatement ();
				strSql="select doc_no,date,fleet_no,if(clstatus=1,'IN','OUT') status from gl_nrm where status<>7 and brhid="+session;
//	        	System.out.println(strSql);
				ResultSet resultSet = stmtmovement.executeQuery (strSql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtmovement.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	    finally{
			conn.close();
		}
//		System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	
	public int insert(Date date, Date dateout, int txtfleetno,
			String cmblocation, String timeout, String outkm,
			String cmboutfuel, String cmbstatus, String hiddriver,
			String outremarks, String outuser, String cmbacctype,
			int cmbprcs, String accplace, double fine,
			String details, String acctime,String mode,HttpSession session,int hidaccidents,
			int hidstaff,int hidgarage,int hidchkgaragedelivery,int hidchkgaragecollect,String formdetailcode,String cmbbranch,String vehtrancode) throws SQLException {
		Connection conn=null;
		try{
			int aaa;
			conn= objconn.getMyConnection();
//System.out.println("UNSAVED DAO"+hidgarage+hidchkgaragedelivery+hidchkgaragecollect);

conn.setAutoCommit(false);

if(hiddriver.equalsIgnoreCase("")){
	hiddriver="0";
}
hidchkgaragedelivery=0;
//System.out.println("Fuel Out:"+cmboutfuel);
//			System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
			CallableStatement stmtMovement = conn.prepareCall("{call movementDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
//			System.out.println("TEST");
			stmtMovement.registerOutParameter(15, java.sql.Types.INTEGER);
			stmtMovement.setDate(1,date);
			stmtMovement.setString(2,cmbstatus);
			stmtMovement.setString(3,session.getAttribute("BRANCHID").toString());
			stmtMovement.setInt(4, txtfleetno);
			stmtMovement.setString(5,session.getAttribute("BRANCHID").toString());
			stmtMovement.setString(6,cmboutfuel);
			stmtMovement.setString(7,timeout);
			stmtMovement.setString(8,outkm);
			stmtMovement.setString(9,outremarks);
			stmtMovement.setDate(10,dateout);
			stmtMovement.setString(11,"OUT");
			stmtMovement.setString(12,cmblocation);
			stmtMovement.setString(13,session.getAttribute("USERID").toString());
			stmtMovement.setString(14,session.getAttribute("BRANCHID").toString());
			stmtMovement.setString(16,mode);
			stmtMovement.setString(17, hiddriver);
			stmtMovement.setInt(18, hidstaff);
			stmtMovement.setInt(19, hidaccidents);
			stmtMovement.setInt(20, hidgarage);
			stmtMovement.setInt(21,hidchkgaragedelivery);
			stmtMovement.setInt(22,hidchkgaragecollect);
			stmtMovement.setString(23,formdetailcode);
			stmtMovement.setString(24,cmbbranch);
			stmtMovement.setString(25,vehtrancode);
			stmtMovement.executeQuery();
			aaa=stmtMovement.getInt("docNo");
//			System.out.println("no====="+aaa);
			movementbean.setDocno(aaa);
			if (aaa > 0) {
				
				System.out.println("Success"+movementbean.getDocno());
				conn.commit();
				stmtMovement.close();
				conn.close();
				return aaa;
			}
			stmtMovement.close();
			conn.close();
		}catch(Exception e){	
		e.printStackTrace();	
		conn.close();
		}
		finally{
			conn.close();
		}
		return 0;
	}
	
	public int close(int docno,String cmbcloselocation,String cmbclosefuel,Date closedate,String closetime,float closekm,String closeremarks,float totalkm,
			HttpSession session,int txtfleetno,String accdetails,float accfines,int hidaccidents,int hidgaragecollect,Date garagecollectdate,String garagecollecttime,
			float garagecollectkm,String cmbgaragecollectfuel,String cmblocation,String cmbstatus,int hidchkgaragecollect,String hidclosedriver,
			String cmbclosebranch,String cmbbranch,String vehtrancode) throws SQLException {
		Connection conn=null;
		try{
			conn= objconn.getMyConnection();

			conn.setAutoCommit(false);

			Statement stmtmovement = conn.createStatement ();
			String strsqlcollect="";
			String strsqlcollect1="";
			String strsqlcollect2="";
			String strtestdoc="";
			String strparentdoc="";
			String strsqlacc="";
			String strsqlupdatenrm="";
			if(hidclosedriver.equalsIgnoreCase("")){
				hidclosedriver="0";
			}
//			System.out.println("ChkGarageCollect:"+hidchkgaragecollect);
			if(hidgaragecollect==1){
				double testfout1=0.0,testkmout1=0.0;
				java.sql.Date testdout1=null;
				String testtout1="";
				int testdocno1=0,testrdocno=0;
				
				String strSql11="select dout,tout,fout,kmout,doc_no,rdocno from gl_vmove where fleet_no='"+txtfleetno+"' and status='OUT' ";
				ResultSet rs11=stmtmovement.executeQuery(strSql11);
				while(rs11.next()){
					testfout1=rs11.getDouble("fout");
					testdout1=rs11.getDate("dout");
					testtout1=rs11.getString("tout");
					testkmout1=rs11.getDouble("kmout");
					testdocno1=rs11.getInt("doc_no");
					testrdocno=rs11.getInt("rdocno");
//					System.out.println("TEST Collection in"+testfout1+testdout1+testtout1+testkmout1+testdocno1);
				}
				double totalfuel1=Double.parseDouble(cmbgaragecollectfuel)-testfout1;
				double totalinkm1=garagecollectkm-testkmout1;
				double totaltime1=0.0;
				String sql222="select TIMESTAMPDIFF(SECOND,ts_din,ts_dout)/60 totalmin from (select  cast(concat('"+garagecollectdate+"',' ','"+garagecollecttime+"') as datetime) ts_din,"+
			" cast(concat('"+testdout1+"',' ','"+testtout1+"')as datetime)ts_dout from gl_vmove where doc_no='"+testdocno1+"') m";
				ResultSet rs222=stmtmovement.executeQuery(sql222);
				while(rs222.next()){
					totaltime1=rs222.getDouble("totalmin");
//					System.out.println("TOTAL TIME1"+totaltime1);
				}
				strsqlupdatenrm="update gl_nrm set collection=1 where doc_no='"+testrdocno+"' and fleet_no='"+txtfleetno+"'";
				int rsupdatenrm=stmtmovement.executeUpdate(strsqlupdatenrm);
				if(rsupdatenrm>0){
					
				}
				strsqlcollect="update gl_vmove set din='"+garagecollectdate+"',tin='"+garagecollecttime+"',kmin='"+garagecollectkm+"',fin='"+cmbgaragecollectfuel+"',"+
			"ibrhid='"+cmbclosebranch+"',ilocid='"+cmbcloselocation+"',status='IN',ttime="+totaltime1+",tkm="+totalinkm1+",tfuel="+totalfuel1+" where rdtype='MOV' and fleet_no='"+txtfleetno+"' and status='OUT'";
//			System.out.println("Collection Update"+strsqlcollect);
				int xx=stmtmovement.executeUpdate(strsqlcollect);
				if(xx>0){
			int testdocno=0;
			int parentdocno=0;
			strtestdoc="select max(doc_no)+1 docNo from gl_vmove";
				ResultSet rs1=stmtmovement.executeQuery(strtestdoc);
				if(rs1.next()){
					testdocno=rs1.getInt("docNo");
				}
				strparentdoc="select max(doc_no) parentdoc from gl_vmove where fleet_no="+txtfleetno;
				ResultSet rs2=stmtmovement.executeQuery(strparentdoc);
				if(rs2.next()){
					parentdocno=rs2.getInt("parentdoc");
				}
String tin1="";
java.sql.Date din1=null;
String sqlcollectin="select tin tin1,din din1 from gl_vmove where doc_no='"+parentdocno+"'";
//System.out.println("Collection In time"+sqlcollectin);
ResultSet rscollect=stmtmovement.executeQuery(sqlcollectin);
while(rscollect.next()){
	tin1=rscollect.getString("tin1");
	din1=rscollect.getDate("din1");
//	System.out.println("Time And Date"+tin1+din1);
}
double ideal=0.0;
String sqlcollecttimediff="select TIMESTAMPDIFF(SECOND,ts_dout,ts_din)/60 tmin from (select  cast(concat('"+din1+"',' ','"+tin1+"') as datetime) ts_din,"+
		" cast(concat('"+garagecollectdate+"',' ','"+garagecollecttime+"')as datetime)ts_dout from gl_vmove where doc_no='"+parentdocno+"') m";
//System.out.println("Collection TimeDiff"+sqlcollecttimediff);
ResultSet rscollecttime=stmtmovement.executeQuery(sqlcollecttimediff);
if(rscollecttime.next()){
	ideal=rscollecttime.getDouble("tmin");
//	System.out.println("IDEAL"+ideal);
}
strsqlcollect1="insert into gl_vmove(doc_no,date,rdocno,rdtype,fleet_no,trancode,status,parent,dout,tout,kmout,fout,obrhid,olocid,tideal,emp_id,emp_type)values("+
			"'"+testdocno+"','"+garagecollectdate+"','"+docno+"','MOV','"+txtfleetno+"','DL','OUT','"+parentdocno+"','"+garagecollectdate+"','"+garagecollecttime+"',"+
			"'"+garagecollectkm+"','"+cmbgaragecollectfuel+"','"+cmbclosebranch+"','"+cmbcloselocation+"','"+ideal+"',"+hidclosedriver+",'DRV')";
//				System.out.println("Collection Insert"+strsqlcollect1);
				int rs3=stmtmovement.executeUpdate(strsqlcollect1);
				if(rs3>0){
				
				}
			}
			
			}
			if(hidaccidents>0){
				int tranid1=0;
				String strsqltran="select max(tran_id)+1 tran_id from gl_trandetails";
				ResultSet rsacc=stmtmovement.executeQuery(strsqltran);
				if(rsacc.next()){
					tranid1=rsacc.getInt("tran_id");
				}
				strsqlacc="insert into gl_trandetails(tran_id,remarks,auth_fne,branch,refno,fleet_no,dtype,date)values('"+tranid1+"','"+accdetails+"','"+accfines+"',"+
			"'"+cmbbranch+"','"+docno+"','"+txtfleetno+"','MOV',curdate())";
//				System.out.println("Accident Insert"+strsqlacc);
				int val=stmtmovement.executeUpdate(strsqlacc);
				if(val<=0){
//					System.out.println("Accident Error");
					conn.close();
					return 0;
				}
				int val1=stmtmovement.executeUpdate("update gl_nrm set accd=1 where doc_no='"+docno+"'");
				if(val1<=0){
//					System.out.println("Accident Updation Error");
					conn.close();
					return 0;
				}
				}
			String strSql="update gl_nrm set clstatus=1,closedr="+hidclosedriver+",closeuserid="+session.getAttribute("USERID").toString()+",inbranch="+cmbclosebranch+" where doc_no="+docno;
//			System.out.println("Updating Master"+strSql);
			double testfout=0.0,testkmout=0.0;
			java.sql.Date testdout=null;
			String testtout="";
			int testdocno=0;
			String strSql22="select dout,tout,fout,kmout,doc_no from gl_vmove where fleet_no='"+txtfleetno+"' and status='OUT' ";
			ResultSet rs22=stmtmovement.executeQuery(strSql22);
			while(rs22.next()){
				testfout=rs22.getDouble("fout");
				testdout=rs22.getDate("dout");
				testtout=rs22.getString("tout");
				testkmout=rs22.getDouble("kmout");
				testdocno=rs22.getInt("doc_no");
//				System.out.println("IN INFO"+testfout+testdout+testtout+testkmout+testdocno);
			}
			double totalfuel=Double.parseDouble(cmbclosefuel)-testfout;
			double totalinkm=closekm-testkmout;
			double totaltime=0.0;
			String sql222="select  TIMESTAMPDIFF(SECOND,ts_din,ts_dout)/60 totalmin from (select  cast(concat('"+closedate+"',' ','"+closetime+"') as datetime) ts_din,"+
		" cast(concat('"+testdout+"',' ','"+testtout+"')as datetime)ts_dout from gl_vmove where doc_no='"+testdocno+"') m";
//		System.out.println("total time Query"+sql222);
			ResultSet rs222=stmtmovement.executeQuery(sql222);
			while(rs222.next()){
				totaltime=rs222.getDouble("totalmin");
//				System.out.println("TOTAL TIME"+totaltime);
			}
			/*double idletimetemp=0.0;
			String sqlidletemp="select TIMESTAMPDIFF(SECOND,ts_dout,ts_din)/60 idletime from (select  cast(concat('"+testdout+"',' ','"+testtout+"') as datetime) ts_din,"+
					" cast(concat('"+closedate+"',' ','"+closetime+"')as datetime)ts_dout from gl_vmove where doc_no='"+testdocno+"') m";
			ResultSet rsidletime=stmtmovement.executeQuery(sqlidletemp);
			if(rsidletime.next()){
				idletimetemp=rsidletime.getDouble("idletime");
			}*/			
			String strSql2="update gl_vmove set status='IN',din='"+closedate+"',tin='"+closetime+"',kmin='"+closekm+"',fin='"+cmbclosefuel+"',"+
			" ibrhid='"+cmbclosebranch+"',ilocid='"+cmbcloselocation+"',ireason='"+closeremarks+"',iaccident='"+hidaccidents+"',"+
			" ttime='"+totaltime+"',tkm='"+totalinkm+"',tfuel='"+totalfuel+"' where rdtype='MOV' and fleet_no='"+txtfleetno+"' and status='OUT'";
//			System.out.println("Updating Close"+strSql2);
			//(select if(dtype='VEH','UR','NR'))
			String strSql3="update gl_vehmaster set tran_code='"+vehtrancode+"',a_br='"+cmbclosebranch+"',a_loc='"+cmbcloselocation+"',status='IN' where fleet_no="+txtfleetno;
//			System.out.println("Updating Vehiclemaster"+strSql3);
			
			/*String strSql2="update gl_vehmaster set status='IN',tran_code='IN' where statu <>7 and fleet_no="+txtfleetno;
			String strSql="update gl_vmove set fin='"+cmbclosefuel+"',ibrhid='"+session.getAttribute("BRANCHID").toString()+"',tin='"+closetime+"',din='"+closedate+"'"+
			"kmin='"+closekm+"',ilocid='"+cmbcloselocation+"',ireason='"+closeremarks+"',set status='IN' where doc_no="+docno;*/
			int aaa=stmtmovement.executeUpdate(strSql);
			
			//aaa=stmtmovement.executeUpdate(strSql4);
			if (aaa > 0) {
				int b=stmtmovement.executeUpdate(strSql2);
				if(b>0){
					int c=stmtmovement.executeUpdate(strSql3);
					if(c>0){

						System.out.println("Success"+aaa);
						conn.commit();
						stmtmovement.close();
						conn.close();
						return aaa;
					}
				}
			}
			stmtmovement.close();
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
	public boolean delete(int docno, String formdetailcode,HttpSession session) throws SQLException {
		// TODO Auto-generated method stub
			//System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
		
		Connection conn=null;
		try{
			conn= objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtMovement=conn.createStatement();
			String strsql="update gl_nrm set status=7 where doc_no="+docno;
			int val=stmtMovement.executeUpdate(strsql);
			String strsql2="insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+session.getAttribute("BRANCHID").toString()+"','"+formdetailcode+"',now(),'"+session.getAttribute("USERID").toString()+"','D')";
			int val2=stmtMovement.executeUpdate(strsql2);
			if (val > 0) {
				String strmovdelete="delete from gl_vmove where rdocno="+docno+" and rdtype='MOV'";
				int movdeleteval=stmtMovement.executeUpdate(strmovdelete);
				if(movdeleteval>0){
					conn.commit();
					stmtMovement.close();
					conn.close();
					return true;	
				}
				//System.out.println("Success"+movementbean.getDocno());
				
			}
			stmtMovement.close();
			conn.close();
		}catch(Exception e){	
		e.printStackTrace();	
		conn.close();
		return false;
		}
		finally{
			conn.close();
		}
		return false;
	}
public   ClsMovementBean getPrint(int docno,String brhid,String dtype) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn= objconn.getMyConnection();
			ClsMovementBean bean=new ClsMovementBean();
			ClsCommon printdao=new ClsCommon();
			conn.setAutoCommit(false);
			Statement stmtMovement=conn.createStatement();
			int i=0;
			String strsql="select closeuser.user_name closeusername,nrm.outbranch,nrm.inbranch,nrm.closedr,cldrv.sal_name closedriver,cmp.company,cmp.address,cmp.tel,cmp.fax,openbr.branchname,stat.st_desc,openbr.branchname openbranch,closebr.branchname closebranch,nrm.doc_no,nrm.fleet_no,DATE_FORMAT(nrm.date,'%d/%m/%Y') date,"+
			" nrm.clstatus,nrm.delivery,nrm.collection,nrm.accd,DATE_FORMAT(mov.dout,'%d/%m/%Y') dout,mov.tout,round(mov.kmout,0) kmout,mov.trancode,round(mov.fout,3)"+
			" fout,mov.oreason,DATE_FORMAT(mov.din,'%d/%m/%Y') din,mov.tin,round(mov.kmin,0) kmin,round(mov.fin,3) fin,mov.ibrhid,mov.ilocid,mov.ireason,"+
			" mov.iaccident,round(mov.tkm,0) tkm,veh.reg_no,"+
			" veh.flname,trim(grp.gid) gid,col.color,loc.loc_name openloc,loc1.loc_name closeloc,usr.user_name,grg.name,st.sal_name staffname,"+
			" dr.sal_name drname,tran.remarks accremarks,tran.auth_fne from gl_nrm nrm inner join gl_vmove mov on(nrm.doc_no=mov.rdocno and"+
			" nrm.fleet_no=mov.fleet_no) left join gl_vehmaster veh on nrm.fleet_no=veh.fleet_no left join gl_vehgroup grp on"+
			" veh.vgrpid=grp.doc_no left join my_color col on veh.clrid=col.doc_no left join my_locm loc on mov.olocid=loc.doc_no"+
			" left join my_locm loc1 on mov.ilocid=loc1.doc_no left join my_user usr on nrm.userid=usr.doc_no left join my_user closeuser on nrm.closeuserid=closeuser.doc_no left join gl_garrage grg on"+
			" nrm.garageid=grg.doc_no left join my_salesman dr on (nrm.drid=dr.doc_no and dr.sal_type='DRV') left join my_salesman cldrv on "+
			" (nrm.closedr=cldrv.doc_no and cldrv.sal_type='DRV') left join my_salesman st on"+
			" (nrm.staffid=st.doc_no and st.sal_type='STF')left join gl_trandetails tran on (nrm.doc_no=tran.refno and tran.dtype='MOV') left join"+
			" my_brch openbr on mov.obrhid=openbr.doc_no left join my_brch closebr on mov.ibrhid=closebr.doc_no left join gl_status stat on"+
			" nrm.movtype=stat.status left join my_comp cmp on cmp.doc_no=openbr.cmpid where mov.rdtype='MOV' and nrm.doc_no="+docno;
			
			//System.out.println("Print Query: "+strsql);
			ResultSet rsprint=stmtMovement.executeQuery(strsql);
			while(rsprint.next()){
				
				if(i==0){
					
					
					bean.setLblcompname(rsprint.getString("company"));
					bean.setLblcompaddress(rsprint.getString("address"));
					bean.setLblcomptel(rsprint.getString("tel"));
					bean.setLblcompfax(rsprint.getString("fax"));
					bean.setLblbranch(rsprint.getString("branchname"));
					bean.setLbllocation(rsprint.getString("openloc"));
					bean.setLbldate(rsprint.getString("date").toString());
				//	System.out.println("check outreason: "+rsprint.getString("oreason"));
					bean.setLblopenremarks(rsprint.getString("oreason"));
					//System.out.println("check bean outreason: "+bean.getLblopenremarks());
					bean.setLblcloseremarks(rsprint.getString("ireason"));
					bean.setLbldocno(rsprint.getInt("doc_no")+"");
				bean.setLblfleetno(rsprint.getInt("fleet_no")+"");
				String temp=rsprint.getString("flname");
				temp=temp+" Reg No:"+rsprint.getString("reg_no");
				temp=temp+" Group:"+rsprint.getString("gid");
				temp=temp+" Color:"+rsprint.getString("color");
				bean.setLblfleetdetails(temp);
				bean.setLblgaragename(rsprint.getString("name"));
				bean.setLblclosegarage(rsprint.getString("name"));
				bean.setLblhiddelivery(rsprint.getString("delivery"));
				bean.setLblhidcollection(rsprint.getString("collection"));
				bean.setLblopenlocation(rsprint.getString("openloc"));
				bean.setLblopenbranch(rsprint.getString("openbranch"));
				bean.setLblclosebranch(rsprint.getString("closebranch"));
				
				//bean.setTxtfleetname(temp);
				//bean.setHidcmblocation(rsprint.getString("olocid"));
				//System.out.println("Out Location in DAO:"+rsprint.getString("olocid")); 
				//bean.setOutremarks(rsprint.getString("oreason"));
				bean.setLblcloselocation(rsprint.getString("closeloc"));
			//	bean.setCloseremarks(rsprint.getString("ireason"));
				bean.setLblcloseuser(rsprint.getString("closeusername"));
				bean.setLblopenuser(rsprint.getString("user_name"));
				//bean.setOutuser(rsprint.getString("user_name"));
				//bean.setOutuserid(rsprint.getInt("userid"));
				//bean.setHidcloseuser(rsprint.getInt("userid"));
				bean.setHidcmbaccidents(rsprint.getString("accd"));
			//	bean.setHiddriver(rsprint.getString("drid"));
				bean.setLblopendriver(rsprint.getString("drname"));
				//bean.setHidstaff(rsprint.getInt("staffid"));
				bean.setLblopenstaff(rsprint.getString("staffname"));
				bean.setLblaccdetails(rsprint.getString("accremarks"));
				bean.setLblaccfines(rsprint.getFloat("auth_fne")+"");
				bean.setLblclosedriver(rsprint.getString("closedriver"));
				bean.setLblclosestaff(bean.getStaff());
				
				bean.setClstatus(rsprint.getString("clstatus"));
				bean.setLblmovtype(rsprint.getString("st_desc"));
				}
				if(!(rsprint.getString("trancode").equalsIgnoreCase("DL"))){
					bean.setHidcmbstatus(rsprint.getString("trancode"));
				}
				i++;
				if((i==1) && (rsprint.getString("trancode").equalsIgnoreCase("DL")) && (rsprint.getInt("delivery")==1)){
//					System.out.println("Delivery");
					bean.setLbldateout(rsprint.getString("dout"));
					bean.setLbltimeout(rsprint.getString("tout"));
					bean.setLblkmout(rsprint.getString("kmout"));
					bean.setLblfuelout(printdao.checkFuelName(conn, rsprint.getString("fout")));
					//System.out.println("Delivery Fuel");
					bean.setLbldeldate(rsprint.getString("din").toString());
					//System.out.println("Delivery Date Check:"+bean.getGaragedeliverydate());
					bean.setLbldeltime(rsprint.getString("tin"));
					
					
					
					
					
					
					
					
					bean.setLbldelkm(rsprint.getString("kmin"));
					bean.setLbldelfuel(printdao.checkFuelName(conn, rsprint.getString("fin")));
					//bean.setTotalkm(rsprint.getFloat("tkm"));
					
				}
				else if((i>1) && (rsprint.getString("trancode").equalsIgnoreCase("DL")) && (rsprint.getInt("collection")==1)){
//					System.out.println("Collection");
					bean.setLblcoldate(rsprint.getString("dout").toString());
					bean.setLblcoltime(rsprint.getString("tout"));
					bean.setLblcolkm(rsprint.getString("kmout"));
					bean.setLblcolfuel(printdao.checkFuelName(conn, rsprint.getString("fout")));
					bean.setLblclosedate(rsprint.getString("din").toString());
					bean.setLblclosetime(rsprint.getString("tin"));
					bean.setLblclosekm(rsprint.getString("kmin"));
					
					
					
					
					bean.setLblclosefuel(printdao.checkFuelName(conn, rsprint.getString("fin")));
					//bean.setTotalkm(rsprint.getFloat("tkm"));
					bean.setLblmovtype(rsprint.getString("st_desc"));
					bean.setLblcloseremarks(rsprint.getString("ireason"));
				}
				else if((!(rsprint.getString("trancode").equalsIgnoreCase("DL"))) && (rsprint.getInt("collection")==0) && (rsprint.getInt("delivery")==0)){
//					System.out.println("Normal");
					if(rsprint.getString("dout")!=null){
						bean.setLbldateout(rsprint.getString("dout").toString());	
					}
					
					bean.setLbltimeout(rsprint.getString("tout"));
					bean.setLblkmout(rsprint.getString("kmout"));
					bean.setLblfuelout(printdao.checkFuelName(conn, rsprint.getString("fout")));
					if(rsprint.getString("din")!=null){
						bean.setLblclosedate(rsprint.getString("din").toString());	
					}
					
					bean.setLblclosetime(rsprint.getString("tin"));
					bean.setLblclosekm(rsprint.getString("kmin"));
					bean.setLblclosefuel(printdao.checkFuelName(conn, rsprint.getString("fin")));
					//bean.setTotalkm(rsprint.getFloat("tkm"));
					bean.setLblmovtype(rsprint.getString("st_desc"));
					bean.setLblcloseremarks(rsprint.getString("ireason"));
				}
				else{
//					System.out.println("ERROR");
//					System.out.println("TranCode:"+rsprint.getString("trancode"));
					bean.setLbldateout(rsprint.getString("dout").toString());
					bean.setLbltimeout(rsprint.getString("tout"));
					bean.setLblkmout(rsprint.getString("kmout"));
					bean.setLblfuelout(printdao.checkFuelName(conn, rsprint.getString("fout")));
					//bean.setTotalkm(rsprint.getFloat("tkm"));
				}
				//System.out.println("check inreason: "+rsprint.getString("ireason")+i+"::::::"+rsprint.getString("trancode")+":::::"+rsprint.getString("collection")+":::::::"+rsprint.getString("delivery"));	
			}
			
			if(bean.getClstatus().equalsIgnoreCase("1")){
				//System.out.println("closekm:"+bean.getClosekm()+"            OutKM:"+bean.getOutkm());
				double tot=Double.parseDouble(bean.getLblclosekm())-Double.parseDouble(bean.getLblkmout());
//				System.out.println("Total KM"+tot);
				bean.setLbltotalkm(tot+"");
				
			}
			
			
			
			String termqry="select distinct rdocno,termsheader terms,m.doc_no, 0 priorno from "
			+ " (select distinct  tr.rdocno,termsid from my_trterms tr   where  tr.dtype='"+dtype+"' and tr.brhid='"+brhid+"' "
			+ "and tr.rdocno='"+docno+"' and tr.status=3 ) "
			+ "  tr inner join my_termsm m on(tr.termsid=m.voc_no), (SELECT @s:= 0) AS s where  m.status=3 "
			+ "  union all select tr.rdocno,conditions terms,m.doc_no,priorno "
			+ "  from my_trterms tr left join my_termsm m on(tr.termsid=m.voc_no) where  tr.dtype='"+dtype+"' "
			+ "  and tr.rdocno='"+docno+"' and tr.brhid='"+brhid+"' and tr.status=3 and m.status=3  order by doc_no,priorno;";
			
			bean.setTermqry(termqry);
			System.out.println("=====bean.getTermqry()=="+bean.getTermqry());
			stmtMovement.close();
			conn.close();
			return bean;
		}catch(Exception e){	
		e.printStackTrace();	
		conn.close();
		return null;
		}
		finally{
			conn.close();
		}
			
	}	public   ClsMovementBean getDeliveryData(int docno) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		ClsMovementBean bean=new ClsMovementBean();
		try{
			conn=objconn.getMyConnection();
			Statement stmtdel=conn.createStatement();
			String strdel="select din,tin,kmin,fin from gl_vmove where rdocno="+docno+" and rdtype='MOV' and trancode='DL'";
			ResultSet rsdel=stmtdel.executeQuery(strdel);
			if(rsdel.next()){
				bean.setGaragedeliverydate(rsdel.getDate("din").toString());
				bean.setHidgaragedeliverytime(rsdel.getString("tin"));
				bean.setGaragedeliverykm(rsdel.getFloat("kmin"));
				bean.setHidcmbgaragedeliveryfuel(rsdel.getString("fin"));
			}
			stmtdel.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return bean;
	}
	

}
