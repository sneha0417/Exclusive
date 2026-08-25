package com.controlcentre.masters.vehiclemaster.vehicle;

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

public class ClsVehicleDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	ClsVehicleBean Bean = new ClsVehicleBean();


	public ClsVehicleBean insert( String fleetname, Date jqxDate1,	String cmbauthority, String cmbplate, String regno,String cmbgroup, String cmbbrand, 
			String cmbmodel, String cmbyom,	String aststatus, String opstatus, String salik_tag, String tcno,int hiddealer, String dealNo, String purchase, int lpo_no,
			String purchase_invoice, Date purchDate, double purchase_cost,double additions, double total, int hidfinancier,double interest_amt, double down_payment, 
			int no_installments,Date regDate, Date relDate, double installment_amt,	double depr_perc, String accu_dep, Date regExpDate,
			String cmbinsurance_type, int hidinsurance_comp,double insured_amt, Date regotherInsDate, double premium_perc,	String policy_no, double premium_amt,
			String engine_no, String vin,String chasis_no, int cmbveh_color, int warranty_period,Date warntyFrmDate, Date warntyToDate, double warranty_km,
			double service_km,Date lstserDate,double last_srvc_km, int current_km,String cmbfuel, String branded, String cmbavail_br1,HttpSession session,
			String fuelcapacity,String fueltype,String formdetailcode,ArrayList<String> specarray,String fileno,String insurmember,String trackid,String hidmortgaged,String calibrationkm) throws SQLException {
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			int aaa;
			
			conn.setAutoCommit(false);
			if(accu_dep.equalsIgnoreCase("")){
				accu_dep="0.0";
			}
			if(hidmortgaged.equalsIgnoreCase("")){
			hidmortgaged="0";
			}
			if(calibrationkm.equalsIgnoreCase("")){
				calibrationkm="0";
				}
			CallableStatement stmtVeh = conn.prepareCall("{CALL vehicleDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,"
					+ "?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtVeh.registerOutParameter(1, java.sql.Types.VARCHAR);
			stmtVeh.registerOutParameter(54,java.sql.Types.INTEGER);
			stmtVeh.registerOutParameter(58, java.sql.Types.INTEGER);
			
			stmtVeh.setString(2,fleetname);
			stmtVeh.setDate(3,jqxDate1);
			stmtVeh.setString(4,regno);
			stmtVeh.setString(5,cmbyom);
			stmtVeh.setString(6,aststatus);
			stmtVeh.setString(7,"IN");
			stmtVeh.setString(8,salik_tag);
			stmtVeh.setString(9,tcno);
			stmtVeh.setInt(10,hiddealer);
			stmtVeh.setString(11,dealNo);
			stmtVeh.setString(12,purchase);
			stmtVeh.setInt(13,lpo_no);
			stmtVeh.setString(14,purchase_invoice);
			stmtVeh.setDate(15,purchDate);
			stmtVeh.setDouble(16,purchase_cost);
			stmtVeh.setDouble(17,additions);
			stmtVeh.setDouble(18,total);
			stmtVeh.setDouble(19,interest_amt);
			stmtVeh.setInt(20,hidfinancier);
			stmtVeh.setDouble(21,down_payment);
			stmtVeh.setInt(22,no_installments);
			stmtVeh.setDate(23,regDate);
			stmtVeh.setDate(24,relDate);
			stmtVeh.setDouble(25,installment_amt);
			stmtVeh.setDouble(26,depr_perc);
			stmtVeh.setDate(27,regExpDate);
			stmtVeh.setString(28,cmbinsurance_type);
			stmtVeh.setInt(29,hidinsurance_comp);
			stmtVeh.setDouble(30,insured_amt);
			stmtVeh.setDate(31,regotherInsDate);
			stmtVeh.setDouble(32,premium_perc);
			stmtVeh.setString(33,policy_no);
			stmtVeh.setDouble(34,premium_amt);
			stmtVeh.setString(35,engine_no.toUpperCase());
			stmtVeh.setString(36,vin);
			System.out.println("VIN:"+vin);
			stmtVeh.setString(37,chasis_no.toUpperCase());
			stmtVeh.setInt(38,cmbveh_color);
			stmtVeh.setDate(39,warntyFrmDate);
			stmtVeh.setDate(40,warntyToDate);
			stmtVeh.setDouble(41,warranty_km);
			stmtVeh.setDouble(42,service_km);
			stmtVeh.setDate(43,lstserDate);
			stmtVeh.setDouble(44,last_srvc_km);
			stmtVeh.setInt(45,current_km);
			stmtVeh.setString(46,cmbfuel);
			stmtVeh.setString(47,branded);
			stmtVeh.setString(48,null);
			stmtVeh.setString(49,cmbauthority);
			stmtVeh.setString(50,cmbplate);
			stmtVeh.setString(51,cmbgroup);
			stmtVeh.setString(52,cmbbrand);
			stmtVeh.setString(53,cmbmodel);
			
			stmtVeh.setString(55,cmbavail_br1);
			stmtVeh.setString(56,session.getAttribute("USERID").toString());
			stmtVeh.setString(57,session.getAttribute("BRANCHID").toString());
			stmtVeh.setString(59,"A");
			stmtVeh.setInt(60, warranty_period);
			stmtVeh.setString(61, fueltype);
			stmtVeh.setString(62, fuelcapacity);
			stmtVeh.setString(63, formdetailcode);
			stmtVeh.setString(64, accu_dep);
			stmtVeh.setString(65,fileno);
			stmtVeh.setString(66, insurmember);
			stmtVeh.setString(67,trackid);
			stmtVeh.setString(68,hidmortgaged);
			stmtVeh.setDouble(69, Double.parseDouble(calibrationkm));
//			System.out.println("SQL========="+stmtVeh);
			int val = stmtVeh.executeUpdate();
			aaa=stmtVeh.getInt("docNo");
			int bbbb=stmtVeh.getInt("fleetNo");
//			System.out.println(aaa);
//			System.out.println(bbbb);
			
			
			if (val > 0) {
				System.out.println("Sucess"+Bean.getDocno());
				int specval=0;
				for(int i=0;i< specarray.size();i++){
					String[] spec=specarray.get(i).split("::");
					System.out.println("SPEC"+spec[0]);
					if(!((spec[0].equalsIgnoreCase("0"))||(spec[0].equalsIgnoreCase("undefined")))){
					String sql="insert into gl_vdspec(rdocno,specid)values('"+aaa+"','"+(spec[0].equalsIgnoreCase("undefined") || spec[0].isEmpty()?0:spec[0])+"')";
					
//					System.out.println("Sql"+sql);
					 specval = stmtVeh.executeUpdate (sql);
					}
					if(specval>0){
						
					}
					else{
						Bean.setDocno(0);
						conn.close();
						return Bean;
					}
						
					}
				Bean.setDocno(aaa);
				Bean.setFleetno(bbbb);
				conn.commit();
				stmtVeh.close();
				conn.close();
				return Bean;
			}
			Bean.setDocno(0);
			stmtVeh.close();
			conn.close();
		}catch(Exception e){	
			
		e.printStackTrace();	
		conn.close();
		}
		finally{
			conn.close();
		}
		return Bean;
	}

	
	public  JSONArray mainSearch(String docno,String fleetname,String fleetno,String regno,String searchdate,HttpSession session,String engine,String chassis) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
 Connection conn=null;
    	    	// String brnchid=session.getAttribute("BRANCHID").toString();
    	//System.out.println("name"+sclname);
    	try{
    		conn=ClsConnection.getMyConnection();
    	String sqltest="";
    	java.sql.Date sqldate=null;
    	if(!(searchdate.equalsIgnoreCase(""))){
    		sqldate=ClsCommon.changeStringtoSqlDate(searchdate);	
    	}
    	if(!(docno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and doc_no like '%"+docno+"%'";
    	}
    	if(!(fleetname.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and flname like '%"+fleetname+"%'";
    	}
    	
    	if(!(fleetno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and fleet_no like '%"+fleetno+"%'";
    	}
    	if(!(regno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and reg_no like '%"+regno+"%'";
    	}
    	if(!engine.equalsIgnoreCase("")){
    		sqltest=sqltest+" and eng_no like '%"+engine+"%'";
    	}
    	
    	if(!chassis.equalsIgnoreCase("")){
    		sqltest=sqltest+" and ch_no like  '%"+chassis+"%'";
    	}
    	
    	 if(sqldate!=null){
    		 sqltest=sqltest+" and date='"+sqldate+"'";
    	 }
        
     
		
				Statement stmtsearch = conn.createStatement();
					String str1Sql="select eng_no engine,ch_no chassis,doc_no,date,reg_no,fleet_no,flname from gl_vehmaster where statu<>7 and dtype='VEH' "+
							" "+sqltest+"";
//					System.out.println("======="+str1Sql);
					ResultSet resultSet = stmtsearch.executeQuery(str1Sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
 
 
	public boolean edit(int fleetno, String fleetname, Date jqxDate1,
			String cmbauthority, String cmbplate, String regno,
			String cmbgroup, String cmbbrand, String cmbmodel, String cmbyom,
			String aststatus, String opstatus, String salik_tag, String tcno,
			int hiddealer, String deal_no2, String purchase, int lpo_no,
			String purchase_invoice, Date purchDate, double purchase_cost,
			double additions, double total, int hidfinancier,
			double interest_amt, double down_payment, int no_installments,
			Date regDate, Date relDate, double installment_amt, int tran_no,
			double depr_perc, String accu_dep, Date regExpDate,
			String cmbinsurance_type, int hidinsurance_comp,
			double insured_amt, Date regotherInsDate, double premium_perc,
			String policy_no, double premium_amt, String engine_no, String vin,
			String chasis_no, int cmbveh_color, int warranty_period,
			Date warntyFrmDate, Date warntyToDate, double warranty_km,
			double service_km, Date lstserDate, double last_srvc_km,
			int current_km, String cmbfuel, String branded,
			String cmbavail_br1, int docno, HttpSession session, String fuelcapacity, String fueltype,String formdetailcode,ArrayList<String> specarray,String fileno,String insurmember,String trackid,String hidmortgaged,String calibrationkm) throws SQLException {
//		System.out.println(tcno+"tcno");

		int aaa;
		Connection conn=null;
		try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				if(hidmortgaged.equalsIgnoreCase("")){
					hidmortgaged="0";
					}
					if(calibrationkm.equalsIgnoreCase("")){
					calibrationkm="0";
					}
				CallableStatement stmtVeh = conn.prepareCall("{CALL vehicleDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,"
					+ "?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtVeh.setInt(1,fleetno);
				stmtVeh.setString(2,fleetname);
				stmtVeh.setDate(3,jqxDate1);
				stmtVeh.setString(4,regno);
				stmtVeh.setString(5,cmbyom);
				stmtVeh.setString(6,"I");
				stmtVeh.setString(7,"IN");
				stmtVeh.setString(8,salik_tag);
				stmtVeh.setString(9,tcno);
				stmtVeh.setInt(10,hiddealer);
				stmtVeh.setString(11,deal_no2);
				stmtVeh.setString(12,purchase);
				stmtVeh.setInt(13,lpo_no);
				stmtVeh.setString(14,purchase_invoice);
				stmtVeh.setDate(15,purchDate);
				stmtVeh.setDouble(16,purchase_cost);
				stmtVeh.setDouble(17,additions);
				stmtVeh.setDouble(18,total);
				stmtVeh.setDouble(19,interest_amt);
				stmtVeh.setInt(20,hidfinancier);
				stmtVeh.setDouble(21,down_payment);
				stmtVeh.setInt(22,no_installments);
				stmtVeh.setDate(23,regDate);
				stmtVeh.setDate(24,relDate);
				stmtVeh.setDouble(25,installment_amt);
				stmtVeh.setDouble(26,depr_perc);
				stmtVeh.setDate(27,regExpDate);
				stmtVeh.setString(28,cmbinsurance_type);
				stmtVeh.setInt(29,hidinsurance_comp);
				stmtVeh.setDouble(30,insured_amt);
				stmtVeh.setDate(31,regotherInsDate);
				stmtVeh.setDouble(32,premium_perc);
				stmtVeh.setString(33,policy_no);
				stmtVeh.setDouble(34,premium_amt);
				stmtVeh.setString(35,engine_no.toUpperCase());
				stmtVeh.setString(36,vin);
				stmtVeh.setString(37,chasis_no.toUpperCase());
				stmtVeh.setInt(38,cmbveh_color);
				stmtVeh.setDate(39,warntyFrmDate);
				stmtVeh.setDate(40,warntyToDate);
				stmtVeh.setDouble(41,warranty_km);
				stmtVeh.setDouble(42,service_km);
				stmtVeh.setDate(43,lstserDate);
				stmtVeh.setDouble(44,last_srvc_km);
				stmtVeh.setInt(45,current_km);
				stmtVeh.setString(46,cmbfuel);
				stmtVeh.setString(47,branded);
				stmtVeh.setString(48,null);
				stmtVeh.setString(49,cmbauthority);
				stmtVeh.setString(50,cmbplate);
				stmtVeh.setString(51,cmbgroup);
				stmtVeh.setString(52,cmbbrand);
				stmtVeh.setString(53,cmbmodel);
				stmtVeh.setInt(54,tran_no);
				stmtVeh.setString(55,cmbavail_br1);
				stmtVeh.setString(56,session.getAttribute("USERID").toString());
				stmtVeh.setString(57,session.getAttribute("BRANCHID").toString());
				stmtVeh.setInt(58, docno);
				stmtVeh.setString(59,"E");
				stmtVeh.setInt(60, warranty_period);
				stmtVeh.setString(61, fueltype);
				stmtVeh.setString(62, fuelcapacity);	
				stmtVeh.setString(63, formdetailcode);
				stmtVeh.setString(64, accu_dep);
				stmtVeh.setString(65, fileno);
				stmtVeh.setString(66, insurmember);
				stmtVeh.setString(67,trackid);
				stmtVeh.setString(68,hidmortgaged);
				stmtVeh.setDouble(69, Double.parseDouble(calibrationkm));
//				System.out.println("SQL========="+stmtVeh);
				int val = stmtVeh.executeUpdate();
				aaa=stmtVeh.getInt("docNo");
//				System.out.println(aaa);
				Bean.setDocno(aaa);
				if (aaa > 0) {
					int specval=0;
					String delsql="delete from gl_vdspec where rdocno='"+docno+"'";
					int specval1=stmtVeh.executeUpdate(delsql);
					for(int i=0;i< specarray.size();i++){
						String[] spec=specarray.get(i).split("::");
//						System.out.println("SPEC"+spec[0]);
						if(!((spec[0].equalsIgnoreCase("0"))||(spec[0].equalsIgnoreCase("undefined")))){
							
						String sql="insert into gl_vdspec(rdocno,specid)values('"+docno+"','"+(spec[0].equalsIgnoreCase("undefined") || spec[0].isEmpty()?0:spec[0])+"')";
						
//						System.out.println("Sql"+sql);
						 specval = stmtVeh.executeUpdate (sql);
						}
						if(specval>0){
							
						}
						else{
							Bean.setDocno(0);
							stmtVeh.close();
							conn.close();
							return false;
						}
							
						}
//					System.out.println("Sucess");
					conn.commit();
					stmtVeh.close();
					conn.close();
					return true;
				}
				stmtVeh.close();
				conn.close();
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



	public int delete(int fleetno, String fleetname, Date jqxDate1,
			String cmbauthority, String cmbplate, String regno,
			String cmbgroup, String cmbbrand, String cmbmodel, String cmbyom,
			String aststatus, String opstatus, String salik_tag, String tcno,
			int hiddealer, String deal_no2, String purchase, int lpo_no,
			String purchase_invoice, Date purchDate, double purchase_cost,
			double additions, double total, int hidfinancier,
			double interest_amt, double down_payment, int no_installments,
			Date regDate, Date relDate, double installment_amt, int tran_no,
			double depr_perc, String accu_dep, Date regExpDate,
			String cmbinsurance_type, int hidinsurance_comp,
			double insured_amt, Date regotherInsDate, double premium_perc,
			String policy_no, double premium_amt, String engine_no, String vin,
			String chasis_no, int cmbveh_color, int warranty_period,
			Date warntyFrmDate, Date warntyToDate, double warranty_km,
			double service_km, Date lstserDate, double last_srvc_km,
			int current_km, String cmbfuel, String branded,
			String cmbavail_br1, int docno, HttpSession session, String fuelcapacity, String fueltype,String formdetailcode,String fileno,String insurmember,String trackid) throws SQLException {
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtTest=conn.createStatement ();
			String testsql3="select m.doc_no from gl_vehmaster b inner join gl_vmove m on m.fleet_no=b.fleet_no where m.status='OUT' and b.fleet_no='"+fleetno+"'";
			ResultSet resultSet3 = stmtTest.executeQuery (testsql3);
			if(resultSet3.next()){
				stmtTest.close();
				conn.close();
				return -2;
			}
			CallableStatement stmtVeh = conn.prepareCall("{CALL vehicleDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,"
					+ "?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtVeh.setInt(1,fleetno);
			stmtVeh.setString(2,fleetname);
			stmtVeh.setDate(3,jqxDate1);
			stmtVeh.setString(4,regno);
			stmtVeh.setString(5,cmbyom);
			stmtVeh.setString(6,null);
			stmtVeh.setString(7,null);
			stmtVeh.setString(8,salik_tag);
			stmtVeh.setString(9,null);
			stmtVeh.setInt(10,hiddealer);
			stmtVeh.setString(11,deal_no2);
			stmtVeh.setString(12,purchase);
			stmtVeh.setInt(13,lpo_no);
			stmtVeh.setString(14,purchase_invoice);
			stmtVeh.setDate(15,purchDate);
			stmtVeh.setDouble(16,purchase_cost);
			stmtVeh.setDouble(17,additions);
			stmtVeh.setDouble(18,total);
			stmtVeh.setDouble(19,interest_amt);
			stmtVeh.setInt(20,hidfinancier);
			stmtVeh.setDouble(21,down_payment);
			stmtVeh.setInt(22,no_installments);
			stmtVeh.setDate(23,regDate);
			stmtVeh.setDate(24,relDate);
			stmtVeh.setDouble(25,installment_amt);
			stmtVeh.setDouble(26,depr_perc);
			stmtVeh.setDate(27,regExpDate);
			stmtVeh.setString(28,cmbinsurance_type);
			stmtVeh.setInt(29,hidinsurance_comp);
			stmtVeh.setDouble(30,insured_amt);
			stmtVeh.setDate(31,regotherInsDate);
			stmtVeh.setDouble(32,premium_perc);
			stmtVeh.setString(33,policy_no);
			stmtVeh.setDouble(34,premium_amt);
			stmtVeh.setString(35,engine_no.toUpperCase());
			stmtVeh.setString(36,vin);
			stmtVeh.setString(37,chasis_no.toUpperCase());
			stmtVeh.setInt(38,cmbveh_color);
			stmtVeh.setDate(39,warntyFrmDate);
			stmtVeh.setDate(40,warntyToDate);
			stmtVeh.setDouble(41,warranty_km);
			stmtVeh.setDouble(42,service_km);
			stmtVeh.setDate(43,lstserDate);
			stmtVeh.setDouble(44,last_srvc_km);
			stmtVeh.setInt(45,current_km);
			stmtVeh.setString(46,cmbfuel);
			stmtVeh.setString(47,branded);
			stmtVeh.setString(48,null);
			stmtVeh.setString(49,cmbauthority);
			stmtVeh.setString(50,cmbplate);
			stmtVeh.setString(51,cmbgroup);
			stmtVeh.setString(52,cmbbrand);
			stmtVeh.setString(53,cmbmodel);
			stmtVeh.setInt(54,tran_no);
			stmtVeh.setString(55,cmbavail_br1);
			stmtVeh.setString(56,session.getAttribute("USERID").toString());
			stmtVeh.setString(57,session.getAttribute("BRANCHID").toString());
			stmtVeh.setInt(58, docno);
			stmtVeh.setString(59,"D");
			stmtVeh.setInt(60, warranty_period);
			stmtVeh.setString(61, fueltype);
			stmtVeh.setString(62, fuelcapacity);
			stmtVeh.setString(63, formdetailcode);
			stmtVeh.setString(64, accu_dep);
			stmtVeh.setString(65, fileno);
			stmtVeh.setString(66, insurmember);
			stmtVeh.setString(67,trackid);
			stmtVeh.setString(68,"0");
			stmtVeh.setString(69,"0");
//			System.out.println("SQL========="+stmtVeh);

//			System.out.println("delete");
			int val = stmtVeh.executeUpdate();
			val=stmtVeh.getInt("docNo");
//			System.out.println(val);
//			System.out.println("delete");
			Bean.setDocno(val);
			
			if (val > 0) {
//				System.out.println("Sucess");
				conn.commit();
				stmtVeh.close();
				stmtTest.close();
				conn.close();
				return val;
			}	
			stmtVeh.close();
			stmtTest.close();
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
	public int release(int releasefleet, String cmbrlsbranch,
			String cmbrlsloc, int current_km, String cmbfuel, int docno,
			HttpSession session, String mode,String cmbrentalstatus,Date reldate,String releasetime) throws SQLException {
		// TODO Auto-generated method stub
//		System.out.println("FUEL"+cmbfuel);
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
//			System.out.println(cmbrlsloc);
			Statement stmt=conn.createStatement();
			ResultSet rsstmt=stmt.executeQuery("select doc_no from gl_vehmaster where fleet_no='"+releasefleet+"' and statu=7");
			if(rsstmt.next()){
				stmt.close();
				conn.close();
				return -1;
			}
			ResultSet rscheck=stmt.executeQuery("select doc_no from gl_vehmaster where fleet_no="+releasefleet+" and statu<>7 and fstatus='L'");
			if(rscheck.next()){
				stmt.close();
				conn.close();
				return -1;
			}
			String checkregno="";int regnoerror=0;
			ResultSet rsregno=stmt.executeQuery("select reg_no from gl_vehmaster where fleet_no="+releasefleet+" and status<>7");
			if(rsregno.next()){
				checkregno=rsregno.getString("reg_no");
			}
			else{
				regnoerror=1;
			}
			if(checkregno.equalsIgnoreCase("") || checkregno==null ||checkregno.isEmpty()){
				regnoerror=1;
			}
			if(regnoerror==1){
				stmt.close();
				conn.close();
				return -2;
			}
			CallableStatement stmtVeh = conn.prepareCall("{CALL vehReleaseDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtVeh.registerOutParameter(10, java.sql.Types.INTEGER);
			stmtVeh.setInt(1, releasefleet);
			stmtVeh.setString(2,cmbfuel);
			stmtVeh.setInt(3,current_km);
			stmtVeh.setString(4, mode);
			stmtVeh.setInt(5, docno);
			stmtVeh.setString(6, cmbrlsloc);
			stmtVeh.setString(7,session.getAttribute("USERID").toString());
			stmtVeh.setString(8,cmbrlsbranch);
			stmtVeh.setString(9, cmbrentalstatus);
			stmtVeh.setDate(11, reldate);
			stmtVeh.setString(12, releasetime);
//			System.out.println(stmtVeh);
			int val = stmtVeh.executeUpdate();
			val=stmtVeh.getInt("docNo1");
//			System.out.println(val);
//			System.out.println("delete");
			//Bean.setDocno(val);
			
			if (val > 0) {
//				System.out.println("Sucess");
				conn.commit();
				stmtVeh.close();
				conn.close();
				return val;
			}	
			stmtVeh.close();
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

	public  ClsVehicleBean getViewDetails(int fleetno) throws SQLException {
		//List<ClsVehicleBean> listBean = new ArrayList<ClsVehicleBean>();
		ClsVehicleBean bean = new ClsVehicleBean();
		Connection conn =null;
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
        	String str="Select m1.fstatus,round(coalesce(m1.calibrationkm,0),2) calibrationkm,m1.renttype,m2.doc_no dealerdocno,m3.doc_no financierdocno,m4.doc_no insurdocno,coalesce(mort.fname,'') mortgage,mort.doc_no mortid,m1.insur_member,m1.track_id,m1.fileno,m1.fueltype,m1.tcap,m5.ibrhid,m5.ilocid,m5.din releasedate,m5.kmin releasekm,m5.fin releasefuel,m5.tin releasetime,m2.name,m3.fname,m4.inname,m1.FLNAME,m1.DATE,m1.DOC_NO,m1.REG_NO,m1.YOM,m1.FSTATUS,m1.STATUS,m1.SALIK_TAG,m1.tcno,m1.DLRID,m1.DL_NO,"+
					"m1.PUR_TYPE,m1.LPO,m1.PRCH_INV,m1.PRCH_DTE,m1.PRCH_COST,m1.ADD1,m1.TVAL,m1.INT_AMT,m1.FINID,m1.DN_PAY,m1.NO_INST,m1.REG_DATE,m1.REL_DATE,m1.INST_AMT,m1.DEPR,m1.REG_EXP,"+
					"m1.ITYPE,m1.INS_COMP,m1.INS_AMT,m1.INS_EXP,m1.PRMYM_PERC,m1.PNO,m1.PRMYM,m1.ENG_NO,m1.VIN,m1.CH_NO,m1.CLRID,m1.WAR,m1.WAR_PRD,m1.WAREND,m1.WAR_KM,m1.SRVC_KM,m1.SRVC_DTE,m1.LST_SRV,m1.CUR_KM,"+
					"round(m1.C_FUEL,3) c_fuel,m1.branded,m1.renttype,m1.AUTHID,m1.PLTID,m1.VGRPID,m1.BRDID,m1.VMODID,m1.costid,m1.BRHID,m1.STATU,m1.accdepr from gl_vehmaster m1 left join my_vendorm m2 on m1.dlrid=m2.doc_no left join gl_vehfin m3 on m1.finid=m3.doc_no left join"+
					" gl_vehin m4 on m1.ins_comp=m4.doc_no left join gl_vmove m5 on m1.fleet_no=m5.fleet_no left join gl_vehfin mort on m1.mortgageid=mort.doc_no where m1.fleet_no="+fleetno;
        	System.out.println(str);
        	ResultSet resultSet = stmtVeh.executeQuery (str);
			
			while (resultSet.next()) {
//				System.out.println(resultSet.getString("FLNAME"));
				if(resultSet.getString("fstatus").equalsIgnoreCase("Z")){
					bean.setErrormsg("VEHICLE SOLD");
				}
				else{
					bean.setErrormsg("");
				}
				bean.setCalibrationkm(resultSet.getString("calibrationkm"));
				bean.setHidcmbveh_color(resultSet.getString("CLRID"));
				bean.setHiddealer(resultSet.getInt("dealerdocno"));
				bean.setHidfinancier(resultSet.getInt("financierdocno"));
				bean.setHidinsurance_comp(resultSet.getInt("insurdocno"));
				bean.setMortgaged(resultSet.getString("mortgage"));bean.setHidmortgaged(resultSet.getString("mortid"));				
				bean.setFleetno(fleetno);bean.setFleetname(resultSet.getString("FLNAME"));	bean.setJqxDate1(resultSet.getString("DATE"));	
				bean.setDocno(resultSet.getInt("DOC_NO")); 	bean.setRegno(resultSet.getString("REG_NO"));bean.setCmbyom(resultSet.getString("YOM")); 	 
            	bean.setOpstatus(resultSet.getString("STATUS")); bean.setSalik_tag(resultSet.getString("SALIK_TAG")); 
            	bean.setTcno(resultSet.getString("tcno")); bean.setDealer3(resultSet.getString("DLRID")); bean.setDeal_no2(resultSet.getString("DL_NO")); 
            	bean.setPurchase(resultSet.getString("PUR_TYPE")); bean.setLpo_no(resultSet.getInt("LPO")); 
            	bean.setPurchase_invoice(resultSet.getString("PRCH_INV")); bean.setJqxPurchaseDate(resultSet.getString("PRCH_DTE")); 
            	bean.setPurchase_cost(resultSet.getDouble("PRCH_COST")); 
            	bean.setAdditions(resultSet.getDouble("ADD1")); bean.setTotal(resultSet.getDouble("TVAL")); bean.setInterest_amt(resultSet.getDouble("INT_AMT")); 
            	bean.setDown_payment(resultSet.getDouble("DN_PAY"));   	bean.setCmbfinancer(resultSet.getInt("FINID"));
            	bean.setNo_installments(resultSet.getInt("NO_INST"));      	bean.setJqxFinRegDate(resultSet.getString("REG_DATE"));
            	bean.setJqxFinRelDate(resultSet.getString("REL_DATE"));		bean.setInstallment_amt(resultSet.getDouble("INST_AMT")); 
            	bean.setDepr_perc(resultSet.getDouble("DEPR"));         	bean.setJqxOtherRegExp(resultSet.getString("REG_EXP"));
            	bean.setCmbinsurance_type(resultSet.getString("ITYPE")); 	bean.setInsurance_comp(resultSet.getString("INS_COMP")); 
            	bean.setInsured_amt(resultSet.getDouble("INS_AMT")); 
            	bean.setJqxOtherInsExp(resultSet.getString("INS_EXP"));	bean.setAccu_dep(resultSet.getString("accdepr"));
            	bean.setPremium_perc(resultSet.getDouble("PRMYM_PERC")); bean.setPolicy_no(resultSet.getString("PNO")); 
            	bean.setPremium_amt(resultSet.getDouble("PRMYM") );
            	bean.setEngine_no(resultSet.getString("ENG_NO")); bean.setVin(resultSet.getString("VIN")); bean.setChasis_no(resultSet.getString("CH_NO"));
            	bean.setCmbveh_color(resultSet.getInt("CLRID")); bean.setJqxWrntyFrmDate(resultSet.getString("WAR")); 
            	bean.setJqxWrntyToDate(resultSet.getString("WAREND")); bean.setWarranty_km(resultSet.getDouble("WAR_KM")); bean.setService_km(resultSet.getDouble("SRVC_KM")); 
            	bean.setLast_srvc_km(resultSet.getDouble("LST_SRV"));
            	bean.setJqxLstSrvcDate(resultSet.getString("srvc_dte")); 
            	bean.setCurrent_km(resultSet.getInt("CUR_KM")); bean.setCmbfuel(resultSet.getString("C_FUEL")); 
//            	System.out.println("FUELSEARCH"+bean.getCmbfuel());
            	bean.setBranded(resultSet.getString("branded")); bean.setCmbauthority(resultSet.getString("AUTHID")); 
            	bean.setCmbplate(resultSet.getString("PLTID")); bean.setCmbgroup(resultSet.getString("VGRPID")); bean.setCmbbrand(resultSet.getString("BRDID")); 
            	bean.setCmbmodel(resultSet.getString("VMODID"));
            	bean.setTran_no(resultSet.getInt("costid")); 
            	bean.setCmbavail_br1(resultSet.getString("BRHID")); 
            	bean.setDealer(resultSet.getString("name"));
            	bean.setFinancier(resultSet.getString("fname"));
            	bean.setInsurance_comp(resultSet.getString("inname"));
            	bean.setWarranty_period(resultSet.getInt("WAR_PRD"));
            	bean.setHidcmbrlsbranch(resultSet.getString("ibrhid"));bean.setHidcmbrlsloc(resultSet.getString("ilocid"));
            	bean.setHidreleasedate(resultSet.getString("releasedate"));
            	bean.setHidreleasetime(resultSet.getString("releasetime"));
            	bean.setFileno(resultSet.getString("fileno"));
            	bean.setInsurmember(resultSet.getString("insur_member"));
            	bean.setTrackid(resultSet.getString("track_id"));
            	/*if()*/
            	bean.setCmbrentalstatus(resultSet.getString("renttype"));
            	
            	bean.setReleasefleet(bean.getFleetno());
            	String temp=resultSet.getString("fstatus");
//            	System.out.println(temp);
            	if(temp.equalsIgnoreCase("I")){
            		bean.setAststatus("INDUCTED");
            		
            	}
            	else if(temp.equalsIgnoreCase("L")){
            		bean.setAststatus("LIVE");
            		bean.setReleasekm(resultSet.getString("releasekm"));
                	//System.out.println("BEANRELEASEKM:"+resultSet.getString("releasekm"));
                	double tempfuel=resultSet.getDouble("releasefuel");
                	//System.out.println(resultSet.getDouble("releasefuel")+"asdassd");
                	if(tempfuel==0.000){
                		bean.setReleasefuel("Level 0/8");
                	}
                	if(tempfuel==0.125){
                		bean.setReleasefuel("Level 1/8");
                	}
                	if(tempfuel==0.250){
                		bean.setReleasefuel("Level 2/8");
                	}
                	if(tempfuel==0.375){
                		bean.setReleasefuel("Level 3/8");
                	}
                	if(tempfuel==0.500){
                		bean.setReleasefuel("Level 4/8");
                	}
                	if(tempfuel==0.625){
                		bean.setReleasefuel("Level 5/8");
                	}
                	if(tempfuel==0.750){
                		bean.setReleasefuel("Level 6/8");
                	}
                	if(tempfuel==0.875){
                		bean.setReleasefuel("Level 7/8");
                	}
                	if(tempfuel==1.000){
                		bean.setReleasefuel("Level 8/8");
                	}
            	}
            	bean.setFuelcapacity(resultSet.getString("tcap"));
            	bean.setHidcmbfueltype(resultSet.getString("fueltype"));
//            	System.out.println("aaa"+bean.getFleetname());
//            	listBean.add(bean);
            	//System.out.println(listBean);
			}
			stmtVeh.close();
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

    public  JSONArray list() throws SQLException {
        List<ClsVehicleBean> listBean = new ArrayList<ClsVehicleBean>();

        JSONArray RESULTDATA=new JSONArray();
        Connection conn =null;
		try {
				conn=ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
            	
				ResultSet resultSet = stmtVeh.executeQuery ("Select FLEET_NO,FLNAME,REG_NO from gl_vehmaster where statu<>7 and dtype='VEH'");

				RESULTDATA=ClsCommon.convertToJSON(resultSet);

				
				
				stmtVeh.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
//System.out.println("nitin===="+listBean);
//		System.out.println(RESULTDATA);
        return RESULTDATA;
    }
    
    public  JSONArray getSpec() throws SQLException {
        List<ClsVehicleBean> listBean = new ArrayList<ClsVehicleBean>();

        JSONArray RESULTDATA=new JSONArray();
        Connection conn =null;
		try {
				conn=ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
            	
				ResultSet resultSet = stmtVeh.executeQuery ("select doc_no,name,details from gl_vehspec where status<>7");

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
stmtVeh.close();
conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
//System.out.println("nitin===="+listBean);
//		System.out.println(RESULTDATA);
        return RESULTDATA;
    }
    public  JSONArray getSpecdetails(String docno) throws SQLException {
        List<ClsVehicleBean> listBean = new ArrayList<ClsVehicleBean>();

        JSONArray RESULTDATA=new JSONArray();
        Connection conn =null;
		try {
				conn=ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
            	String sql="";
            	sql="select spec.doc_no,spec.name,spec.details description from gl_vdspec specd left join gl_vehspec spec"
						+ " on specd.specid=spec.doc_no where specd.rdocno='"+docno+"'";
//            	System.out.println("SQL"+sql);
				ResultSet resultSet = stmtVeh.executeQuery (sql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
stmtVeh.close();
conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
//System.out.println("nitin===="+listBean);
//		System.out.println(RESULTDATA);
        return RESULTDATA;
    }
    



}
