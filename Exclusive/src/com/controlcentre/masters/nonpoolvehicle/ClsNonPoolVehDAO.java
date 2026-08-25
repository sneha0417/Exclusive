package com.controlcentre.masters.nonpoolvehicle;
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

public class ClsNonPoolVehDAO {
ClsNonPoolVehBean bean=new ClsNonPoolVehBean();
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();



public  JSONArray mainSearch(HttpSession session,String searchdate,String fleetno,String docno,String regno,String color,String group) throws SQLException {
    Connection conn = null;
    JSONArray RESULTDATA=new JSONArray();
	try {
			conn=ClsConnection.getMyConnection();
		java.sql.Date sqldate=null;
		String sqltest="";
		if(!(searchdate.equalsIgnoreCase(""))){
			sqldate=ClsCommon.changeStringtoSqlDate(searchdate);
		}
		if(!(docno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and veh.doc_no like '%"+docno+"%'";
		}
		if(!(fleetno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and veh.fleet_no like '%"+fleetno+"%'";
		}
		if(!(regno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and veh.reg_no like '%"+regno+"%'";
		}
		if(sqldate!=null){
			sqltest=sqltest+" and veh.date='"+sqldate+"'";
			
		}
		if(!(group.equalsIgnoreCase(""))){
			sqltest=sqltest+" and veh.vgrpid like '%"+group+"%'";
		}
		if(!(color.equalsIgnoreCase(""))){
			sqltest=sqltest+" and veh.clrid like '%"+color+"%'";
		}
			Statement stmtmovement = conn.createStatement ();
        	String strSql="select veh.doc_no,veh.date,veh.reg_no,veh.fleet_no,veh.flname,clr.color,grp.gid from gl_vehmaster veh left join my_color clr  "+
        			" on veh.clrid=clr.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no where statu<>7 and dtype='NPV'"+sqltest;
//        	System.out.println(strSql);
			ResultSet resultSet = stmtmovement.executeQuery (strSql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
//	System.out.println("RESULTDATA=========>"+RESULTDATA);
    return RESULTDATA;
}


public ClsNonPoolVehBean insert(String fleetname, Date nonpooldate1,
		String aststatus, String cmbauthority, String cmbplatecode,
		String regno, String cmbgroup, String utype, String opstatus,
		String aststatus2, String cmbbrand, String cmbmodel, String cmbyom,
		String chasisno, String cmbcolor, String engineno, String vin,
		int servicekm, Date lstsrvcdate1, int lastservicekm, String saliktag,
		int currentkm, String cmbfuel, Date insurexpiry1, Date regexpiry1,
		String cmbavailbr, String cmbavailloc, HttpSession session, String mode,String formdetailcode,String cmbfueltype,String fuelcapacity) throws SQLException{
	
	/*
	 int txtaccno, int cmbperiodno,
		String cmbperiodtype, double rent, double cdw, double pai,
		Date datein1, String timein, Date datedue1, String timedue, int inkm,
		String infuel, String cmbcheckin, String user, double ownclaimexcess,
		double salikservchg, int kmrestrict, double tfineservchg,
		double within12, double excesskmchg, double kmtotal, double within24,
		String total, double within36, String cmbbranch, Date closedate1,
		String closetime, int closekm, String cmbclosefuel,
		String closetotalkm, String closeavgkm, String cmbcheckout,
		String closeuser,
		
		*/
	Connection conn=null;
	try{
		/*,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?*/
		conn=ClsConnection.getMyConnection();
		CallableStatement stmtnonpool = conn.prepareCall("{CALL nonPoolVehDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		stmtnonpool.registerOutParameter(1, java.sql.Types.INTEGER);
		stmtnonpool.registerOutParameter(28, java.sql.Types.INTEGER);
		stmtnonpool.setDate(2,nonpooldate1);
		stmtnonpool.setString(3,regno);
		stmtnonpool.setString(4, fleetname);
		stmtnonpool.setDate(5, insurexpiry1);
		stmtnonpool.setDate(6, regexpiry1);
		stmtnonpool.setString(7, engineno);
		stmtnonpool.setString(8, chasisno);
		stmtnonpool.setString(9, cmbavailloc);
		stmtnonpool.setInt(10,currentkm);
		stmtnonpool.setString(11, cmbfuel);
		stmtnonpool.setString(12, formdetailcode);
		stmtnonpool.setString(13,cmbcolor);
		stmtnonpool.setString(14, cmbmodel);
		stmtnonpool.setString(15,cmbbrand);
		stmtnonpool.setString(16, cmbgroup);
		stmtnonpool.setString(17,cmbplatecode);
		stmtnonpool.setString(18, cmbauthority);
		stmtnonpool.setInt(19,servicekm);
		stmtnonpool.setDate(20, lstsrvcdate1);
		stmtnonpool.setInt(21,lastservicekm);
		stmtnonpool.setString(22, vin);
		stmtnonpool.setString(23,cmbyom);
		stmtnonpool.setString(24, saliktag);
		stmtnonpool.setString(25,cmbavailbr);
		stmtnonpool.setString(26, session.getAttribute("USERID").toString());
		stmtnonpool.setString(27, session.getAttribute("BRANCHID").toString());
		stmtnonpool.setString(29, mode);
		stmtnonpool.setString(30, cmbfueltype);
		stmtnonpool.setString(31, fuelcapacity);
		int val = stmtnonpool.executeUpdate();
		int nonpooldoc=stmtnonpool.getInt("doc_No1");
		int fleet=stmtnonpool.getInt("fleetNo");
		//int ccc=stmtnonpool.getInt("doc_No1");
		//System.out.println("Nonpooldoc"+nonpooldoc);
		/*
		System.out.println(aaa);
		System.out.println(bbbb);
		System.out.println(ccc);
*/
		
		
		
		if (nonpooldoc > 0) {
			//System.out.println("Sucess"+bean.getDocno());
			bean.setDocno(nonpooldoc);
			bean.setFleetno(fleet+"");
			//bean.setVehdocno(ccc);
			//bean.setCosttranno(bbbb);
			stmtnonpool.close();
			conn.close();
			return bean;
		}
		else{
			bean.setDocno(0);
			bean.setFleetno("0");
			stmtnonpool.close();
			conn.close();	
		}
		
	}catch(Exception e){	
		
	e.printStackTrace();	
	conn.close();
	}
	finally{
		conn.close();
	}
	return bean;
}

public boolean edit(String fleetname, Date nonpooldate1, String aststatus,
		String cmbauthority, String cmbplatecode, String regno,
		String cmbgroup, String utype, String opstatus, String aststatus2,
		String cmbbrand, String cmbmodel, String cmbyom, String chasisno,
		String cmbcolor, String engineno, String vin, int servicekm,
		Date lstsrvcdate1, int lastservicekm, String saliktag, int currentkm,
		String cmbfuel, Date insurexpiry1, Date regexpiry1, String cmbavailbr,
		String cmbavailloc, HttpSession session, String mode,String formdetailcode,
		int docno, String fleetno,String cmbfueltype,String fuelcapacity) throws SQLException {
	Connection conn=null;
	try{
		conn=ClsConnection.getMyConnection();
		CallableStatement stmtnonpool = conn.prepareCall("{CALL nonPoolVehDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		stmtnonpool.setInt(1, Integer.parseInt(fleetno));
		stmtnonpool.setInt(28, docno);
		stmtnonpool.setDate(2,nonpooldate1);
		stmtnonpool.setString(3,regno);
		stmtnonpool.setString(4, fleetname);
		stmtnonpool.setDate(5, insurexpiry1);
		stmtnonpool.setDate(6, regexpiry1);
		stmtnonpool.setString(7, engineno);
		stmtnonpool.setString(8, chasisno);
		stmtnonpool.setString(9, cmbavailloc);
		stmtnonpool.setInt(10,currentkm);
		stmtnonpool.setString(11, cmbfuel);
		
		stmtnonpool.setString(12, formdetailcode);
		stmtnonpool.setString(13,cmbcolor);
		stmtnonpool.setString(14, cmbmodel);
		stmtnonpool.setString(15,cmbbrand);
		stmtnonpool.setString(16, cmbgroup);
		stmtnonpool.setString(17,cmbplatecode);
		stmtnonpool.setString(18, cmbauthority);
		stmtnonpool.setInt(19,servicekm);
		stmtnonpool.setDate(20, lstsrvcdate1);
		stmtnonpool.setInt(21,lastservicekm);
		stmtnonpool.setString(22, vin);
		stmtnonpool.setString(23,cmbyom);
		stmtnonpool.setString(24, saliktag);
		stmtnonpool.setString(25,cmbavailloc);
		stmtnonpool.setString(26, session.getAttribute("USERID").toString());
		stmtnonpool.setString(27, session.getAttribute("BRANCHID").toString());
		stmtnonpool.setString(29, mode);
		stmtnonpool.setString(30, cmbfueltype);
		stmtnonpool.setString(31, fuelcapacity);
	// TODO Auto-generated method stub
	
	int val = stmtnonpool.executeUpdate();
	//aaa=stmtnonpool.getInt("docNooo");
	/*System.out.println(aaa);
	bean.setDocno(aaa);
	stmtnonpool.close();
	conn.close();*/
	if (val > 0) {
		stmtnonpool.close();
		conn.close();
		//System.out.println("Sucess");
		return true;
	}
	else{
		stmtnonpool.close();
		conn.close();
		//System.out.println("Sucess");
		return false;
	}
}
catch(Exception e){
e.printStackTrace();
conn.close();
}
return false;
}

public boolean delete(String fleetname, Date nonpooldate1, String aststatus,
		String cmbauthority, String cmbplatecode, String regno,
		String cmbgroup, String utype, String opstatus, String aststatus2,
		String cmbbrand, String cmbmodel, String cmbyom, String chasisno,
		String cmbcolor, String engineno, String vin, int servicekm,
		Date lstsrvcdate1, int lastservicekm, String saliktag, int currentkm,
		String cmbfuel, Date insurexpiry1, Date regexpiry1, String cmbavailbr,
		String cmbavailloc, HttpSession session, String mode,String formdetailcode,
		int docno, String fleetno,String cmbfueltype,String fuelcapacity) throws SQLException {
	Connection conn=null;
	try{
		conn=ClsConnection.getMyConnection();

		CallableStatement stmtnonpool = conn.prepareCall("{CALL nonPoolVehDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		stmtnonpool.setInt(1, Integer.parseInt(fleetno));
		stmtnonpool.setInt(28, docno);
		stmtnonpool.setDate(2,nonpooldate1);
		stmtnonpool.setString(3,regno);
		stmtnonpool.setString(4, fleetname);
		stmtnonpool.setDate(5, insurexpiry1);
		stmtnonpool.setDate(6, regexpiry1);
		stmtnonpool.setString(7, engineno);
		stmtnonpool.setString(8, chasisno);
		stmtnonpool.setString(9, cmbavailloc);
		stmtnonpool.setInt(10,currentkm);
		stmtnonpool.setString(11, cmbfuel);
		
		stmtnonpool.setString(12, formdetailcode);
		stmtnonpool.setString(13,cmbcolor);
		stmtnonpool.setString(14, cmbmodel);
		stmtnonpool.setString(15,cmbbrand);
		stmtnonpool.setString(16, cmbgroup);
		stmtnonpool.setString(17,cmbplatecode);
		stmtnonpool.setString(18, cmbauthority);
		stmtnonpool.setInt(19,servicekm);
		stmtnonpool.setDate(20, lstsrvcdate1);
		stmtnonpool.setInt(21,lastservicekm);
		stmtnonpool.setString(22, vin);
		stmtnonpool.setString(23,cmbyom);
		stmtnonpool.setString(24, saliktag);
		stmtnonpool.setString(25,cmbavailloc);
		stmtnonpool.setString(26, session.getAttribute("USERID").toString());
		stmtnonpool.setString(27, session.getAttribute("BRANCHID").toString());
		stmtnonpool.setString(29, mode);
		stmtnonpool.setString(30, cmbfueltype);
		stmtnonpool.setString(31, fuelcapacity);
	// TODO Auto-generated method stub
	
	int val = stmtnonpool.executeUpdate();
	//aaa=stmtnonpool.getInt("docNooo");
	/*System.out.println(aaa);
	bean.setDocno(aaa);
	stmtnonpool.close();
	conn.close();*/
	if (val > 0) {
		stmtnonpool.close();
		conn.close();
		//System.out.println("Sucess");
		return true;
	}
	else{
		stmtnonpool.close();
		conn.close();
		//System.out.println("Sucess");
		return false;
	}
}
catch(Exception e){
e.printStackTrace();
conn.close();
}
	finally{
		conn.close();
	}
return false;
}


public  ClsNonPoolVehBean getViewDetails(String fleetno) throws SQLException {
//List<ClsVehicleBean> listBean = new ArrayList<ClsVehicleBean>();
	ClsNonPoolVehBean bean = new ClsNonPoolVehBean();
	Connection conn = null;
	try {
conn=ClsConnection.getMyConnection();
Statement stmtnonpool = conn.createStatement ();

ResultSet resultSet = stmtnonpool.executeQuery ("select fueltype,tcap,doc_no,date,reg_no,fleet_no,flname,ins_exp insurexpdate,reg_exp regexpdate,eng_no,ch_no,a_loc,status,"+
		" srvc_km,srvc_dte,lst_srv,cur_km,vin,c_fuel,tran_code,yom,salik_tag,fstatus,a_br,authid,pltid,vgrpid,brdid,vmodid,brhid,costid,clrid from gl_vehmaster"+
		" where fleet_no="+fleetno);

while (resultSet.next()) {
	bean.setFleetno(fleetno);
	//System.out.println(resultSet.getString("flname"));	
	//bean.setVehdocno(resultSet.getInt("vehdocno"));
	bean.setFleetno(fleetno);bean.setFleetname(resultSet.getString("FLNAME"));bean.setNonpooldate(resultSet.getDate("date").toString());bean.setAststatus(resultSet.getString("status"));
	bean.setDocno(resultSet.getInt("doc_no"));bean.setHidcmbauthority(resultSet.getString("authid"));bean.setHidcmbplatecode(resultSet.getString("pltid"));
	bean.setRegno(resultSet.getString("reg_no"));bean.setHidcmbgroup(resultSet.getString("vgrpid"));bean.setOpstatus(resultSet.getString("fstatus"));
	bean.setHidcmbbrand(resultSet.getString("brdid"));bean.setHidcmbmodel(resultSet.getString("vmodid"));bean.setHidcmbyom(resultSet.getString("yom"));
	bean.setChasisno(resultSet.getString("ch_no"));bean.setHidcmbcolor(resultSet.getString("clrid"));bean.setEngineno(resultSet.getString("eng_no"));bean.setVin(resultSet.getString("vin"));
	bean.setServicekm(resultSet.getInt("srvc_km"));bean.setLstsrvcdate(resultSet.getDate("srvc_dte").toString());bean.setSaliktag(resultSet.getString("salik_tag"));bean.setCurrentkm(resultSet.getInt("cur_km"));
	bean.setHidcmbfuel(resultSet.getString("c_fuel"));
	bean.setCosttranno(resultSet.getString("fleet_no"));bean.setLastservicekm(resultSet.getInt("lst_srv"));bean.setRegexpiry(resultSet.getDate("regexpdate").toString());
	bean.setInsurexpiry(resultSet.getDate("insurexpdate").toString());bean.setCmbavailbranch(resultSet.getString("a_br"));bean.setCmbavailloc(resultSet.getString("a_loc"));
	bean.setHidcmbfueltype(resultSet.getString("fueltype"));
	bean.setFuelcapacity(resultSet.getString("tcap"));
	/*
	bean.setTxtaccno(resultSet.getInt("acc_no"));bean.setHidcmbperiodno(resultSet.getString("period"));bean.setHidcmbperiodtype(resultSet.getString("period_type"));
	bean.setRent(resultSet.getDouble("rent"));bean.setCdw(resultSet.getDouble("cdw"));bean.setPai(resultSet.getDouble("pai"));bean.setHiddatein(resultSet.getDate("din").toString());
	bean.setHidtimein(resultSet.getString("tin"));bean.setHiddatedue(resultSet.getDate("date_due").toString());bean.setHidtimedue(resultSet.getString("time_due"));bean.setInkm(resultSet.getInt("kmin"));
	bean.setInfuel(resultSet.getString("fin"));bean.setHidcmbcheckin(resultSet.getString("check_in"));
	bean.setUser(resultSet.getString("user"));bean.setOwnclaimexcess(resultSet.getDouble("onclaim"));bean.setSalikservchg(resultSet.getDouble("salik_chg"));
	bean.setKmrestrict(resultSet.getInt("km_rest"));bean.setTfineservchg(resultSet.getDouble("traffic_fne"));bean.setWithin12(resultSet.getDouble("term1"));
	bean.setWithin24(resultSet.getDouble("term2"));bean.setWithin36(resultSet.getDouble("term3"));bean.setExcesskmchg(resultSet.getDouble("exkm_rate"));
	bean.setKmtotal(resultSet.getDouble("km_tot"));bean.setTotal(resultSet.getString("exkm_chg"));bean.setHidcmbbranch(resultSet.getString("cbranch"));
	bean.setHidclosedate(resultSet.getDate("dout").toString());bean.setHidclosetime(resultSet.getString("tout"));bean.setClosekm(resultSet.getInt("kmout"));
	bean.setHidcmbclosefuel(resultSet.getString("fout"));bean.setClosetotalkm(resultSet.getString("km_tot"));bean.setCloseavgkm(resultSet.getString("as"));
	bean.setHidcmbcheckout(resultSet.getString("check_out"));bean.setUtype(resultSet.getString("utype"));bean.setVehdocno(resultSet.getInt("vehdocno"));
	System.out.println("aaa"+bean.getFleetname());bean.setTxtaccname(resultSet.getString("description"));bean.setAddress(resultSet.getString("address"));
	bean.setTel1(resultSet.getString("com_mob"));bean.setTel2(resultSet.getString("per_mob"));
	String temp=resultSet.getString("fin");
	System.out.println(temp);
String temp2="";
	if(temp.equals("E")){
		temp2="Empty";
	}
	else if(temp.equals("H")){
		temp2="Half";
	}
	else if(temp.equals("T")){
		temp2="TriQuarter";
	}
	else if(temp.equals("F")){
		temp2="Full";
	}
	else
		System.out.println("ERROR");
	bean.setHidinfuel(temp2);
	bean.setInfuel(resultSet.getString("fin"));
*/

}
stmtnonpool.close();
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

/*public  JSONArray list() throws SQLException {
List<ClsNonPoolVehBean> listBean = new ArrayList<ClsNonPoolVehBean>();

JSONArray RESULTDATA=new JSONArray();
try {
	Connection conn = ClsConnection.getMyConnection();
	Statement stmtNonPool = conn.createStatement ();
	
	ResultSet resultSet = stmtNonPool.executeQuery ("Select FLEET_NO,FLNAME,REG_NO from gl_vehmaster where statu<>7 and dtype='NPV'");

	RESULTDATA=convertToJSON(resultSet);

}
catch(Exception e){
e.printStackTrace();
}
System.out.println(RESULTDATA);
return RESULTDATA;
}*/





}
