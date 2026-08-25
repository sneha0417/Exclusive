package com.controlcentre.masters.nonpoolvehicle;
import com.common.*;
import com.controlcentre.masters.vehiclemaster.vehicle.ClsVehicleDAO;

import java.sql.*;
import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import java.io.*;
@SuppressWarnings("serial")
public class ClsNonPoolVehAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
ClsNonPoolVehDAO nonpoolDAO=new ClsNonPoolVehDAO();
ClsNonPoolVehDAO ClsNonPoolVehDAO=new ClsNonPoolVehDAO();
//vehicle Info
private String formdetailcode;
private String testdata;
private int vehdocno;
private String fleetno;
private String fleetname;
private int docno;
private String nonpooldate;
private String hidnonpooldate;
private String aststatus;
private String cmbauthority;
private String hidcmbauthority;
private String cmbplatecode;
private String hidcmbplatecode;
private String regno;
private String cmbgroup;
private String hidcmbgroup;
private String utype;
private String opstatus;
private String cmbbrand;
private String hidcmbbrand;
private String cmbmodel;
private String hidcmbmodel;
private String cmbyom;
private String hidcmbyom;
private String chasisno;
private String cmbcolor;
private String hidcmbcolor;
private String engineno;
private String vin;
private int servicekm;
private String lstsrvcdate;
private String hidlstsrvcdate;
private String saliktag;
private int currentkm;
private String cmbfuel;
private String hidcmbfuel;
private String costtranno;
private int lastservicekm;
private String regexpiry;
private String hidregexpiry;
private String insurexpiry;
private String hidinsurexpiry;
private String cmbavailbranch;
private String hidcmbavailbranch;
private String cmbavailloc;
private String hidcmbavailloc;
private String availlocname;
private String cmbfueltype;
private String hidcmbfueltype;
private String fuelcapacity;
//User Info
private String txtaccname;
private int txtaccno;
private String address;
private String tel1;
private String tel2;
//Contract Info
private int cmbperiodno;
private String hidcmbperiodno;
private String cmbperiodtype;
private String hidcmbperiodtype;
private double rent;
private double cdw;
private double pai;
//Opening Info
private String datein;
private String hiddatein;
private String timein;
private String hidtimein;
private String datedue;
private String hiddatedue;
private String timedue;
private String hidtimedue;
private int inkm;
private String infuel;
private String hidinfuel;
private String cmbcheckin;
private String hidcmbcheckin;
private String user;
//Charges Info
private double ownclaimexcess;
private double salikservchg;
private int kmrestrict;
private double tfineservchg;
private double within12;
private double excesskmchg;
private double kmtotal;
private double within24;
private String total;
private double within36;
//Closing Info
private String cmbbranch;
private String hidcmbbranch;
private String closedate;
private String hidclosedate;
private String closetime;
private String hidclosetime;
private int closekm;
private String cmbclosefuel;
private String hidcmbclosefuel;
private String cmbcheckout;
private String hidcmbcheckout;
private String closetotalkm;
private String closeavgkm;
private String closeuser;
private String mode;
private String delete;
private String msg;



public String getCmbfueltype() {
	return cmbfueltype;
}
public void setCmbfueltype(String cmbfueltype) {
	this.cmbfueltype = cmbfueltype;
}
public String getHidcmbfueltype() {
	return hidcmbfueltype;
}
public void setHidcmbfueltype(String hidcmbfueltype) {
	this.hidcmbfueltype = hidcmbfueltype;
}
public String getFuelcapacity() {
	return fuelcapacity;
}
public void setFuelcapacity(String fuelcapacity) {
	this.fuelcapacity = fuelcapacity;
}
public String getFormdetailcode() {
	return formdetailcode;
}
public void setFormdetailcode(String formdetailcode) {
	this.formdetailcode = formdetailcode;
}
public String getMsg() {
	return msg;
}
public void setMsg(String msg) {
	this.msg = msg;
}
public String getTestdata() {
	return testdata;
}
public void setTestdata(String testdata) {
	this.testdata = testdata;
}
public String getHidinfuel() {
	return hidinfuel;
}
public void setHidinfuel(String hidinfuel) {
	this.hidinfuel = hidinfuel;
}
public int getVehdocno() {
	return vehdocno;
}
public void setVehdocno(int vehdocno) {
	this.vehdocno = vehdocno;
}
public String getMode() {
	return mode;
}
public void setMode(String mode) {
	this.mode = mode;
}
public String getDelete() {
	return delete;
}
public void setDelete(String delete) {
	this.delete = delete;
}
public String getFleetno() {
	return fleetno;
}
public void setFleetno(String fleetno) {
	this.fleetno = fleetno;
}
public String getFleetname() {
	return fleetname;
}
public void setFleetname(String fleetname) {
	this.fleetname = fleetname;
}
public int getDocno() {
	return docno;
}
public void setDocno(int docno) {
	this.docno = docno;
}
public String getNonpooldate() {
	return nonpooldate;
}
public void setNonpooldate(String nonpooldate) {
	this.nonpooldate = nonpooldate;
}
public String getHidnonpooldate() {
	return hidnonpooldate;
}
public void setHidnonpooldate(String hidnonpooldate) {
	this.hidnonpooldate = hidnonpooldate;
}
public String getAststatus() {
	return aststatus;
}
public void setAststatus(String aststatus) {
	this.aststatus = aststatus;
}
public String getCmbauthority() {
	return cmbauthority;
}
public void setCmbauthority(String cmbauthority) {
	this.cmbauthority = cmbauthority;
}
public String getHidcmbauthority() {
	return hidcmbauthority;
}
public void setHidcmbauthority(String hidcmbauthority) {
	this.hidcmbauthority = hidcmbauthority;
}
public String getCmbplatecode() {
	return cmbplatecode;
}
public void setCmbplatecode(String cmbplatecode) {
	this.cmbplatecode = cmbplatecode;
}
public String getHidcmbplatecode() {
	return hidcmbplatecode;
}
public void setHidcmbplatecode(String hidcmbplatecode) {
	this.hidcmbplatecode = hidcmbplatecode;
}
public String getRegno() {
	return regno;
}
public void setRegno(String regno) {
	this.regno = regno;
}
public String getCmbgroup() {
	return cmbgroup;
}
public void setCmbgroup(String cmbgroup) {
	this.cmbgroup = cmbgroup;
}
public String getHidcmbgroup() {
	return hidcmbgroup;
}
public void setHidcmbgroup(String hidcmbgroup) {
	this.hidcmbgroup = hidcmbgroup;
}
public String getUtype() {
	return utype;
}
public void setUtype(String utype) {
	this.utype = utype;
}
public String getOpstatus() {
	return opstatus;
}
public void setOpstatus(String opstatus) {
	this.opstatus = opstatus;
}
public String getCmbbrand() {
	return cmbbrand;
}
public void setCmbbrand(String cmbbrand) {
	this.cmbbrand = cmbbrand;
}
public String getHidcmbbrand() {
	return hidcmbbrand;
}
public void setHidcmbbrand(String hidcmbbrand) {
	this.hidcmbbrand = hidcmbbrand;
}
public String getCmbmodel() {
	return cmbmodel;
}
public void setCmbmodel(String cmbmodel) {
	this.cmbmodel = cmbmodel;
}
public String getHidcmbmodel() {
	return hidcmbmodel;
}
public void setHidcmbmodel(String hidcmbmodel) {
	this.hidcmbmodel = hidcmbmodel;
}
public String getCmbyom() {
	return cmbyom;
}
public void setCmbyom(String cmbyom) {
	this.cmbyom = cmbyom;
}
public String getHidcmbyom() {
	return hidcmbyom;
}
public void setHidcmbyom(String hidcmbyom) {
	this.hidcmbyom = hidcmbyom;
}
public String getChasisno() {
	return chasisno;
}
public void setChasisno(String chasisno) {
	this.chasisno = chasisno;
}
public String getCmbcolor() {
	return cmbcolor;
}
public void setCmbcolor(String cmbcolor) {
	this.cmbcolor = cmbcolor;
}
public String getHidcmbcolor() {
	return hidcmbcolor;
}
public void setHidcmbcolor(String hidcmbcolor) {
	this.hidcmbcolor = hidcmbcolor;
}
public String getEngineno() {
	return engineno;
}
public void setEngineno(String engineno) {
	this.engineno = engineno;
}
public String getVin() {
	return vin;
}
public void setVin(String vin) {
	this.vin = vin;
}
public int getServicekm() {
	return servicekm;
}
public void setServicekm(int servicekm) {
	this.servicekm = servicekm;
}
public String getLstsrvcdate() {
	return lstsrvcdate;
}
public void setLstsrvcdate(String lstsrvcdate) {
	this.lstsrvcdate = lstsrvcdate;
}
public String getHidlstsrvcdate() {
	return hidlstsrvcdate;
}
public void setHidlstsrvcdate(String hidlstsrvcdate) {
	this.hidlstsrvcdate = hidlstsrvcdate;
}
public String getSaliktag() {
	return saliktag;
}
public void setSaliktag(String saliktag) {
	this.saliktag = saliktag;
}
public int getCurrentkm() {
	return currentkm;
}
public void setCurrentkm(int currentkm) {
	this.currentkm = currentkm;
}
public String getCmbfuel() {
	return cmbfuel;
}
public void setCmbfuel(String cmbfuel) {
	this.cmbfuel = cmbfuel;
}
public String getHidcmbfuel() {
	return hidcmbfuel;
}
public void setHidcmbfuel(String hidcmbfuel) {
	this.hidcmbfuel = hidcmbfuel;
}
public String getCosttranno() {
	return costtranno;
}
public void setCosttranno(String costtranno) {
	this.costtranno = costtranno;
}
public int getLastservicekm() {
	return lastservicekm;
}
public void setLastservicekm(int lastservicekm) {
	this.lastservicekm = lastservicekm;
}
public String getRegexpiry() {
	return regexpiry;
}
public void setRegexpiry(String regexpiry) {
	this.regexpiry = regexpiry;
}
public String getHidregexpiry() {
	return hidregexpiry;
}
public void setHidregexpiry(String hidregexpiry) {
	this.hidregexpiry = hidregexpiry;
}
public String getInsurexpiry() {
	return insurexpiry;
}
public void setInsurexpiry(String insurexpiry) {
	this.insurexpiry = insurexpiry;
}
public String getHidinsurexpiry() {
	return hidinsurexpiry;
}
public void setHidinsurexpiry(String hidinsurexpiry) {
	this.hidinsurexpiry = hidinsurexpiry;
}

public String getCmbavailbranch() {
	return cmbavailbranch;
}
public void setCmbavailbranch(String cmbavailbranch) {
	this.cmbavailbranch = cmbavailbranch;
}
public String getHidcmbavailbranch() {
	return hidcmbavailbranch;
}
public void setHidcmbavailbranch(String hidcmbavailbranch) {
	this.hidcmbavailbranch = hidcmbavailbranch;
}
public String getCmbavailloc() {
	return cmbavailloc;
}
public void setCmbavailloc(String cmbavailloc) {
	this.cmbavailloc = cmbavailloc;
}
public String getHidcmbavailloc() {
	return hidcmbavailloc;
}
public void setHidcmbavailloc(String hidcmbavailloc) {
	this.hidcmbavailloc = hidcmbavailloc;
}
public String getAvaillocname() {
	return availlocname;
}
public void setAvaillocname(String availlocname) {
	this.availlocname = availlocname;
}
public String getTxtaccname() {
	return txtaccname;
}
public void setTxtaccname(String txtaccname) {
	this.txtaccname = txtaccname;
}
public int getTxtaccno() {
	return txtaccno;
}
public void setTxtaccno(int txtaccno) {
	this.txtaccno = txtaccno;
}
public String getAddress() {
	return address;
}
public void setAddress(String address) {
	this.address = address;
}
public String getTel1() {
	return tel1;
}
public void setTel1(String tel1) {
	this.tel1 = tel1;
}
public String getTel2() {
	return tel2;
}
public void setTel2(String tel2) {
	this.tel2 = tel2;
}
public int getCmbperiodno() {
	return cmbperiodno;
}
public void setCmbperiodno(int cmbperiodno) {
	this.cmbperiodno = cmbperiodno;
}
public String getHidcmbperiodno() {
	return hidcmbperiodno;
}
public void setHidcmbperiodno(String hidcmbperiodno) {
	this.hidcmbperiodno = hidcmbperiodno;
}
public String getCmbperiodtype() {
	return cmbperiodtype;
}
public void setCmbperiodtype(String cmbperiodtype) {
	this.cmbperiodtype = cmbperiodtype;
}
public String getHidcmbperiodtype() {
	return hidcmbperiodtype;
}
public void setHidcmbperiodtype(String hidcmbperiodtype) {
	this.hidcmbperiodtype = hidcmbperiodtype;
}
public double getRent() {
	return rent;
}
public void setRent(double rent) {
	this.rent = rent;
}
public double getCdw() {
	return cdw;
}
public void setCdw(double cdw) {
	this.cdw = cdw;
}
public double getPai() {
	return pai;
}
public void setPai(double pai) {
	this.pai = pai;
}
public String getDatein() {
	return datein;
}
public void setDatein(String datein) {
	this.datein = datein;
}
public String getHiddatein() {
	return hiddatein;
}
public void setHiddatein(String hiddatein) {
	this.hiddatein = hiddatein;
}
public String getTimein() {
	return timein;
}
public void setTimein(String timein) {
	this.timein = timein;
}
public String getHidtimein() {
	return hidtimein;
}
public void setHidtimein(String hidtimein) {
	this.hidtimein = hidtimein;
}
public String getDatedue() {
	return datedue;
}
public void setDatedue(String datedue) {
	this.datedue = datedue;
}
public String getHiddatedue() {
	return hiddatedue;
}
public void setHiddatedue(String hiddatedue) {
	this.hiddatedue = hiddatedue;
}
public String getTimedue() {
	return timedue;
}
public void setTimedue(String timedue) {
	this.timedue = timedue;
}
public String getHidtimedue() {
	return hidtimedue;
}
public void setHidtimedue(String hidtimedue) {
	this.hidtimedue = hidtimedue;
}
public int getInkm() {
	return inkm;
}
public void setInkm(int inkm) {
	this.inkm = inkm;
}
public String getInfuel() {
	return infuel;
}
public void setInfuel(String infuel) {
	this.infuel = infuel;
}
public String getCmbcheckin() {
	return cmbcheckin;
}
public void setCmbcheckin(String cmbcheckin) {
	this.cmbcheckin = cmbcheckin;
}
public String getHidcmbcheckin() {
	return hidcmbcheckin;
}
public void setHidcmbcheckin(String hidcmbcheckin) {
	this.hidcmbcheckin = hidcmbcheckin;
}
public String getUser() {
	return user;
}
public void setUser(String user) {
	this.user = user;
}
public double getOwnclaimexcess() {
	return ownclaimexcess;
}
public void setOwnclaimexcess(double ownclaimexcess) {
	this.ownclaimexcess = ownclaimexcess;
}
public double getSalikservchg() {
	return salikservchg;
}
public void setSalikservchg(double salikservchg) {
	this.salikservchg = salikservchg;
}
public int getKmrestrict() {
	return kmrestrict;
}
public void setKmrestrict(int kmrestrict) {
	this.kmrestrict = kmrestrict;
}
public double getTfineservchg() {
	return tfineservchg;
}
public void setTfineservchg(double tfineservchg) {
	this.tfineservchg = tfineservchg;
}
public double getWithin12() {
	return within12;
}
public void setWithin12(double within12) {
	this.within12 = within12;
}
public double getExcesskmchg() {
	return excesskmchg;
}
public void setExcesskmchg(double excesskmchg) {
	this.excesskmchg = excesskmchg;
}
public double getKmtotal() {
	return kmtotal;
}
public void setKmtotal(double kmtotal) {
	this.kmtotal = kmtotal;
}
public double getWithin24() {
	return within24;
}
public void setWithin24(double within24) {
	this.within24 = within24;
}
public String getTotal() {
	return total;
}
public void setTotal(String total) {
	this.total = total;
}
public double getWithin36() {
	return within36;
}
public void setWithin36(double within36) {
	this.within36 = within36;
}
public String getCmbbranch() {
	return cmbbranch;
}
public void setCmbbranch(String cmbbranch) {
	this.cmbbranch = cmbbranch;
}
public String getHidcmbbranch() {
	return hidcmbbranch;
}
public void setHidcmbbranch(String hidcmbbranch) {
	this.hidcmbbranch = hidcmbbranch;
}
public String getClosedate() {
	return closedate;
}
public void setClosedate(String closedate) {
	this.closedate = closedate;
}
public String getHidclosedate() {
	return hidclosedate;
}
public void setHidclosedate(String hidclosedate) {
	this.hidclosedate = hidclosedate;
}
public String getClosetime() {
	return closetime;
}
public void setClosetime(String closetime) {
	this.closetime = closetime;
}
public String getHidclosetime() {
	return hidclosetime;
}
public void setHidclosetime(String hidclosetime) {
	this.hidclosetime = hidclosetime;
}
public int getClosekm() {
	return closekm;
}
public void setClosekm(int closekm) {
	this.closekm = closekm;
}
public String getCmbclosefuel() {
	return cmbclosefuel;
}
public void setCmbclosefuel(String cmbclosefuel) {
	this.cmbclosefuel = cmbclosefuel;
}
public String getHidcmbclosefuel() {
	return hidcmbclosefuel;
}
public void setHidcmbclosefuel(String hidcmbclosefuel) {
	this.hidcmbclosefuel = hidcmbclosefuel;
}
public String getCmbcheckout() {
	return cmbcheckout;
}
public void setCmbcheckout(String cmbcheckout) {
	this.cmbcheckout = cmbcheckout;
}
public String getHidcmbcheckout() {
	return hidcmbcheckout;
}
public void setHidcmbcheckout(String hidcmbcheckout) {
	this.hidcmbcheckout = hidcmbcheckout;
}
public String getClosetotalkm() {
	return closetotalkm;
}
public void setClosetotalkm(String closetotalkm) {
	this.closetotalkm = closetotalkm;
}
public String getCloseavgkm() {
	return closeavgkm;
}
public void setCloseavgkm(String closeavgkm) {
	this.closeavgkm = closeavgkm;
}
public String getCloseuser() {
	return closeuser;
}
public void setCloseuser(String closeuser) {
	this.closeuser = closeuser;
}

java.sql.Date nonpooldate1=null,closedate1=null,datein1=null,datedue1=null,regexpiry1=null,insurexpiry1=null,lstsrvcdate1=null;


public void setData(String fleetno,int docno,java.sql.Date nonpooldate1,java.sql.Date closedate1,java.sql.Date datein1,
		java.sql.Date datedue1,java.sql.Date regexpiry1,java.sql.Date insurexpiry1,java.sql.Date lstsrvcdate1){
	
	setFleetno(fleetno);
	setDocno(docno);
	setFleetname(getFleetname());setNonpooldate(nonpooldate1.toString());setAststatus(getAststatus());
	setHidcmbauthority(getCmbauthority());setHidcmbplatecode(getCmbplatecode());setRegno(getRegno());setHidcmbgroup(getCmbgroup());
	setHidcmbfueltype(getCmbfueltype());
	setFuelcapacity(getFuelcapacity());
	//setUtype(getUtype());
	setRegexpiry(regexpiry1.toString());setInsurexpiry(insurexpiry1.toString());
	setOpstatus(getOpstatus());setHidcmbbrand(getCmbbrand());setHidcmbmodel(getCmbmodel());setHidcmbyom(getCmbyom());setChasisno(getChasisno());
	setHidcmbcolor(getCmbcolor());setEngineno(getEngineno());setVin(getVin());setServicekm(getServicekm());setLstsrvcdate(lstsrvcdate1.toString());
	setSaliktag(getSaliktag());setCurrentkm(getCurrentkm());setHidcmbfuel(getCmbfuel());
	setCosttranno(fleetno);
	setLastservicekm(getLastservicekm());
	setHidregexpiry(getRegexpiry());setHidinsurexpiry(getInsurexpiry());setHidcmbavailbranch(getCmbavailbranch());
	setHidcmbavailloc(getCmbavailloc());setAvaillocname(getAvaillocname());
	
}
public String saveAction() throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	//System.out.println("here");
	String mode=getMode();
	String testdata=getTestdata();
	//System.out.println("============"+request.getParameter("mode"));
	//System.out.println("mode==="+getMode());
	//System.out.println(mode);
	ClsNonPoolVehBean bean=new ClsNonPoolVehBean();
	if(mode.equalsIgnoreCase("A") || mode.equalsIgnoreCase("E") || mode.equalsIgnoreCase("D")){
		nonpooldate1=ClsCommon.changeStringtoSqlDate(getNonpooldate());
		
		regexpiry1=ClsCommon.changeStringtoSqlDate(getRegexpiry());
		insurexpiry1=ClsCommon.changeStringtoSqlDate(getInsurexpiry());
		lstsrvcdate1=ClsCommon.changeStringtoSqlDate(getLstsrvcdate());
		
	}
	//System.out.println("mode==="+getMode());
	if(mode.equalsIgnoreCase("A")){
		//System.out.println("Time"+getClosetime().substring(0, getClosetime().length()-3));
		/*getTxtaccno(),getCmbperiodno(),getCmbperiodtype(),
		getRent(),getCdw(),getPai(),datein1,getTimein(),datedue1,getTimedue(),getInkm(),getInfuel(),getCmbcheckin(),getUser(),
		getOwnclaimexcess(),getSalikservchg(),getKmrestrict(),getTfineservchg(),getWithin12(),getExcesskmchg(),getKmtotal(),getWithin24(),
		getTotal(),getWithin36(),getCmbbranch(),closedate1,getClosetime(),getClosekm(),getCmbclosefuel(),getClosetotalkm(),getCloseavgkm(),
		getCmbcheckout(),getCloseuser()*/
		
		bean=nonpoolDAO.insert(getFleetname(),nonpooldate1,getAststatus(),getCmbauthority(),getCmbplatecode(),getRegno(),getCmbgroup(),getUtype(),getOpstatus(),getAststatus(),
				getCmbbrand(),getCmbmodel(),getCmbyom(),getChasisno(),getCmbcolor(),getEngineno(),getVin(),getServicekm(),lstsrvcdate1,getLastservicekm(),getSaliktag(),
				getCurrentkm(),getCmbfuel(),insurexpiry1,regexpiry1,getCmbavailbranch(),getCmbavailloc(),session,getMode(),getFormdetailcode(),getCmbfueltype(),getFuelcapacity());
		if(bean.getDocno()>0){
			
			
			setData(bean.getFleetno(), bean.getDocno(), nonpooldate1, closedate1, datein1, datedue1, regexpiry1, insurexpiry1, lstsrvcdate1);
			/*
		setFleetno(bean.getFleetno());setFleetname(getFleetname());setNonpooldate(nonpooldate1.toString());setAststatus(getAststatus());setDocno(bean.getDocno());
		setHidcmbauthority(getCmbauthority());setHidcmbplatecode(getCmbplatecode());setRegno(getRegno());setHidcmbgroup(getCmbgroup());
		setHidcmbfueltype(getCmbfueltype());
		setFuelcapacity(getFuelcapacity());
		//setUtype(getUtype());
		setRegexpiry(regexpiry1.toString());setInsurexpiry(insurexpiry1.toString());
		setOpstatus(getOpstatus());setHidcmbbrand(getCmbbrand());setHidcmbmodel(getCmbmodel());setHidcmbyom(getCmbyom());setChasisno(getChasisno());
		setHidcmbcolor(getCmbcolor());setEngineno(getEngineno());setVin(getVin());setServicekm(getServicekm());setLstsrvcdate(lstsrvcdate1.toString());
		setSaliktag(getSaliktag());setCurrentkm(getCurrentkm());setHidcmbfuel(getCmbfuel());setCosttranno(bean.getFleetno());setLastservicekm(getLastservicekm());
		setHidregexpiry(getRegexpiry());setHidinsurexpiry(getInsurexpiry());setHidcmbavailbranch(getCmbavailbranch());setHidcmbavailloc(getCmbavailloc());setAvaillocname(getAvaillocname());
		
		*/
		/*setTxtaccname(getTxtaccname());setTxtaccno(getTxtaccno());setHidcmbperiodno(getCmbperiodno());setHidcmbperiodtype(getCmbperiodtype());setRent(getRent());
		setCdw(getCdw());setPai(getPai());setHiddatein(getDatein());setHidtimein(getTimein());setHiddatedue(getDatedue());setHidtimedue(getTimedue());setInkm(getInkm());
		setHidinfuel(getHidinfuel());setHidcmbcheckin(getCmbcheckin());setUser(getUser());setOwnclaimexcess(getOwnclaimexcess());setSalikservchg(getSalikservchg());
		setKmrestrict(getKmrestrict());setTfineservchg(getTfineservchg());setWithin12(getWithin12());setWithin24(getWithin24());setWithin36(getWithin36());
		setExcesskmchg(getExcesskmchg());setKmtotal(getKmtotal());setTotal(getTotal());
		System.out.println("platehid"+getHidcmbplatecode());
		System.out.println("plate"+getCmbplatecode());
		System.out.println("modelhid"+getHidcmbmodel());
		System.out.println("model"+getCmbmodel());*/

		setMsg("Successfully Saved");

			return "success";
		}
		else{
			setData(bean.getFleetno(), bean.getDocno(), nonpooldate1, closedate1, datein1, datedue1, regexpiry1, insurexpiry1, lstsrvcdate1);
			/*setFleetno(bean.getFleetno());setFleetname(getFleetname());setNonpooldate(nonpooldate1.toString());setAststatus(getAststatus());setDocno(bean.getDocno());
			setHidcmbauthority(getCmbauthority());setHidcmbplatecode(getCmbplatecode());setRegno(getRegno());setHidcmbgroup(getCmbgroup());
			//setUtype(getUtype());
			setHidcmbfueltype(getCmbfueltype());
			setFuelcapacity(getFuelcapacity());
			setOpstatus(getOpstatus());setHidcmbbrand(getCmbbrand());setHidcmbmodel(getCmbmodel());setHidcmbyom(getCmbyom());setChasisno(getChasisno());
			setHidcmbcolor(getCmbcolor());setEngineno(getEngineno());setVin(getVin());setServicekm(getServicekm());setLstsrvcdate(lstsrvcdate1.toString());
			setSaliktag(getSaliktag());setCurrentkm(getCurrentkm());setHidcmbfuel(getCmbfuel());setCosttranno(bean.getFleetno());setLastservicekm(getLastservicekm());
			setHidregexpiry(getRegexpiry());setHidinsurexpiry(getInsurexpiry());setHidcmbavailbranch(getCmbavailbranch());setHidcmbavailloc(getCmbavailloc());setAvaillocname(getAvaillocname());
			*/
			setMsg("Not Saved");

			return "fail";
		}	
}
	else if(mode.equalsIgnoreCase("E")){
		//System.out.println("Mode="+getMode());

		boolean Status=nonpoolDAO.edit(getFleetname(),nonpooldate1,getAststatus(),getCmbauthority(),getCmbplatecode(),getRegno(),getCmbgroup(),getUtype(),getOpstatus(),getAststatus(),
				getCmbbrand(),getCmbmodel(),getCmbyom(),getChasisno(),getCmbcolor(),getEngineno(),getVin(),getServicekm(),lstsrvcdate1,getLastservicekm(),getSaliktag(),
				getCurrentkm(),getCmbfuel(),insurexpiry1,regexpiry1,getCmbavailbranch(),getCmbavailloc(),session,getMode(),getFormdetailcode(),getDocno(),getFleetno(),getCmbfueltype(),getFuelcapacity());
		
		if(Status){
			setData(getFleetno(), getDocno(), nonpooldate1, closedate1, datein1, datedue1, regexpiry1, insurexpiry1, lstsrvcdate1);
			/*	setDocno(getDocno());
			setFleetno(getFleetno());setFleetname(getFleetname());setNonpooldate(nonpooldate1.toString());setAststatus(getAststatus());
			setHidcmbauthority(getCmbauthority());setHidcmbplatecode(getCmbplatecode());setRegno(getRegno());setHidcmbgroup(getCmbgroup());
			//setUtype(getUtype());
			setHidcmbfueltype(getCmbfueltype());
			setFuelcapacity(getFuelcapacity());
			setOpstatus(getOpstatus());setHidcmbbrand(getCmbbrand());setHidcmbmodel(getCmbmodel());setHidcmbyom(getCmbyom());setChasisno(getChasisno());
			setHidcmbcolor(getCmbcolor());setEngineno(getEngineno());setVin(getVin());setServicekm(getServicekm());setLstsrvcdate(lstsrvcdate1.toString());
			setSaliktag(getSaliktag());setCurrentkm(getCurrentkm());setHidcmbfuel(getCmbfuel());setCosttranno(bean.getFleetno());setLastservicekm(getLastservicekm());
			setHidregexpiry(getRegexpiry());setHidinsurexpiry(getInsurexpiry());setHidcmbavailbranch(getCmbavailbranch());setHidcmbavailloc(getCmbavailloc());setAvaillocname(getAvaillocname());
			*/
			setMsg("Updated Successfully");
			
			return "success";
		}
		else{
			/*setDocno(getDocno());
			setFleetno(getFleetno());setFleetname(getFleetname());setNonpooldate(nonpooldate1.toString());setAststatus(getAststatus());
			setHidcmbauthority(getCmbauthority());setHidcmbplatecode(getCmbplatecode());setRegno(getRegno());setHidcmbgroup(getCmbgroup());
			//setUtype(getUtype());
			setHidcmbfueltype(getCmbfueltype());
			setFuelcapacity(getFuelcapacity());
			setOpstatus(getOpstatus());setHidcmbbrand(getCmbbrand());setHidcmbmodel(getCmbmodel());setHidcmbyom(getCmbyom());setChasisno(getChasisno());
			setHidcmbcolor(getCmbcolor());setEngineno(getEngineno());setVin(getVin());setServicekm(getServicekm());setLstsrvcdate(lstsrvcdate1.toString());
			setSaliktag(getSaliktag());setCurrentkm(getCurrentkm());setHidcmbfuel(getCmbfuel());setCosttranno(bean.getFleetno());setLastservicekm(getLastservicekm());
			setHidregexpiry(getRegexpiry());setHidinsurexpiry(getInsurexpiry());setHidcmbavailbranch(getCmbavailbranch());setHidcmbavailloc(getCmbavailloc());setAvaillocname(getAvaillocname());
			*/
			setData(getFleetno(), getDocno(), nonpooldate1, closedate1, datein1, datedue1, regexpiry1, insurexpiry1, lstsrvcdate1);
			setMsg("Not Updated");

			return "fail";
		}
	}
	
	else if(mode.equalsIgnoreCase("D")){
		//System.out.println("Delete here"+getMode());
		//System.out.println("Mode="+getMode());

				boolean Status=nonpoolDAO.delete(getFleetname(),nonpooldate1,getAststatus(),getCmbauthority(),getCmbplatecode(),getRegno(),getCmbgroup(),getUtype(),getOpstatus(),getAststatus(),
						getCmbbrand(),getCmbmodel(),getCmbyom(),getChasisno(),getCmbcolor(),getEngineno(),getVin(),getServicekm(),lstsrvcdate1,getLastservicekm(),getSaliktag(),
						getCurrentkm(),getCmbfuel(),insurexpiry1,regexpiry1,getCmbavailbranch(),getCmbavailloc(),session,getMode(),getFormdetailcode(),getDocno(),getFleetno(),getCmbfueltype(),getFuelcapacity());
			if(Status){
				/*setDocno(getDocno());
				setFleetno(getFleetno());setFleetname(getFleetname());setNonpooldate(nonpooldate1.toString());setAststatus(getAststatus());
				setHidcmbauthority(getCmbauthority());setHidcmbplatecode(getCmbplatecode());setRegno(getRegno());setHidcmbgroup(getCmbgroup());
				//setUtype(getUtype());
				setHidcmbfueltype(getCmbfueltype());
				setFuelcapacity(getFuelcapacity());
				setOpstatus(getOpstatus());setHidcmbbrand(getCmbbrand());setHidcmbmodel(getCmbmodel());setHidcmbyom(getCmbyom());setChasisno(getChasisno());
				setHidcmbcolor(getCmbcolor());setEngineno(getEngineno());setVin(getVin());setServicekm(getServicekm());setLstsrvcdate(lstsrvcdate1.toString());
				setSaliktag(getSaliktag());setCurrentkm(getCurrentkm());setHidcmbfuel(getCmbfuel());setCosttranno(bean.getFleetno());setLastservicekm(getLastservicekm());
				setHidregexpiry(getRegexpiry());setHidinsurexpiry(getInsurexpiry());setHidcmbavailbranch(getCmbavailbranch());setHidcmbavailloc(getCmbavailloc());setAvaillocname(getAvaillocname());
					*/
				setData(getFleetno(), getDocno(), nonpooldate1, closedate1, datein1, datedue1, regexpiry1, insurexpiry1, lstsrvcdate1);
				setMsg("Successfully Deleted");

				return "success";
			}
			else{
				/*setDocno(getDocno());
				setFleetno(getFleetno());setFleetname(getFleetname());setNonpooldate(nonpooldate1.toString());setAststatus(getAststatus());
				setHidcmbauthority(getCmbauthority());setHidcmbplatecode(getCmbplatecode());setRegno(getRegno());setHidcmbgroup(getCmbgroup());
				//setUtype(getUtype());
				setHidcmbfueltype(getCmbfueltype());
				setFuelcapacity(getFuelcapacity());
				setOpstatus(getOpstatus());setHidcmbbrand(getCmbbrand());setHidcmbmodel(getCmbmodel());setHidcmbyom(getCmbyom());setChasisno(getChasisno());
				setHidcmbcolor(getCmbcolor());setEngineno(getEngineno());setVin(getVin());setServicekm(getServicekm());setLstsrvcdate(lstsrvcdate1.toString());
				setSaliktag(getSaliktag());setCurrentkm(getCurrentkm());setHidcmbfuel(getCmbfuel());setCosttranno(bean.getFleetno());setLastservicekm(getLastservicekm());
				setHidregexpiry(getRegexpiry());setHidinsurexpiry(getInsurexpiry());setHidcmbavailbranch(getCmbavailbranch());setHidcmbavailloc(getCmbavailloc());setAvaillocname(getAvaillocname());
				*/
				setData(getFleetno(), getDocno(), nonpooldate1, closedate1, datein1, datedue1, regexpiry1, insurexpiry1, lstsrvcdate1);
				setMsg("Not Deleted");

				return "fail";
			}
	}
	else if(mode.equalsIgnoreCase("View")){
		//System.out.println("mode==="+getMode());

		//System.out.println("view===="+getFleetno());
		//ClsNonPoolVehBean bean = new ClsNonPoolVehBean(); 
				bean=ClsNonPoolVehDAO.getViewDetails(getFleetno());
		//System.out.println(bean);
		setFleetno(bean.getFleetno());setFleetname(bean.getFleetname());setNonpooldate(bean.getNonpooldate());
		setAststatus(bean.getAststatus());setDocno(bean.getDocno());setVehdocno(bean.getVehdocno());setHidcmbauthority(bean.getHidcmbauthority());
		setHidcmbplatecode(bean.getHidcmbplatecode());setRegno(bean.getRegno());setHidcmbgroup(bean.getHidcmbgroup());
		setUtype(bean.getUtype());
		setOpstatus(bean.getOpstatus());setHidcmbbrand(bean.getHidcmbbrand());setHidcmbmodel(bean.getHidcmbmodel());setHidcmbyom(bean.getHidcmbyom());
		setChasisno(bean.getChasisno());setHidcmbcolor(bean.getHidcmbcolor());setEngineno(bean.getEngineno());setVin(bean.getVin());setServicekm(bean.getServicekm());
		setSaliktag(bean.getSaliktag());setCurrentkm(bean.getCurrentkm());setHidcmbfuel(bean.getHidcmbfuel());setInsurexpiry(bean.getInsurexpiry());
		setRegexpiry(bean.getRegexpiry());
		setHidcmbavailbranch(bean.getCmbavailbranch());setHidcmbavailloc(bean.getCmbavailloc());
		//System.out.println(getHidcmbavailloc()+":::::::"+getHidcmbavailbranch());
		
		setHidcmbfueltype(bean.getHidcmbfueltype());
		setFuelcapacity(bean.getFuelcapacity());
		/*setTxtaccname(bean.getTxtaccname());setTxtaccno(bean.getTxtaccno());
		setAddress(bean.getAddress());setTel1(bean.getTel1());setTel2(bean.getTel2());setHidcmbperiodno(bean.getHidcmbperiodno());
		setHidcmbperiodtype(bean.getHidcmbperiodtype());setRent(bean.getRent());setCdw(bean.getCdw());setPai(bean.getPai());
		setHiddatein(bean.getHiddatein());setHidtimein(bean.getHidtimein());setHiddatedue(bean.getHiddatedue());
		setHidtimedue(bean.getHidtimedue());setInkm(bean.getInkm());setHidcmbcheckin(bean.getHidcmbcheckin());setUser(bean.getUser());
		setOwnclaimexcess(bean.getOwnclaimexcess());setSalikservchg(bean.getSalikservchg());setKmrestrict(bean.getKmrestrict());
		setTfineservchg(bean.getTfineservchg());setExcesskmchg(bean.getExcesskmchg());setKmtotal(bean.getKmtotal());setTotal(bean.getTotal());
		setWithin12(bean.getWithin12());setWithin24(bean.getWithin24());setWithin36(bean.getWithin36());
		setHidcmbbranch(bean.getHidcmbbranch());setHidclosedate(bean.getHidclosedate());setHidclosetime(bean.getHidclosetime());
		setClosekm(bean.getClosekm());setHidcmbclosefuel(bean.getHidcmbclosefuel());setClosetotalkm(bean.getClosetotalkm());
		setCloseavgkm(bean.getCloseavgkm());setHidcmbcheckout(bean.getHidcmbcheckout());setCloseuser(bean.getCloseuser());
		setVehdocno(bean.getVehdocno());setHidinfuel(bean.getHidinfuel());setInfuel(bean.getInfuel());
*/
		setLstsrvcdate(bean.getLstsrvcdate());setInkm(inkm);
		
		setCosttranno(bean.getCosttranno());
		/*setUtype(bean.getUtype());
		setTimein(bean.getTimein());
		setAddress(bean.getAddress());setTel1(bean.getTel1());setTel2(bean.getTel2());
		*/System.out.println(getDocno());
		//System.out.println(bean.getDocno());

		return "success";
	}
	return "fail";
}



public String vehicleGrid() throws ParseException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	//System.out.println(getFleetno());
	JSONArray cellarray = new JSONArray();
	  		  JSONObject cellobj = null;
	
		//  System.out.println("inside vehicle grid"+getFleetname());

	return "fail";
}
}
