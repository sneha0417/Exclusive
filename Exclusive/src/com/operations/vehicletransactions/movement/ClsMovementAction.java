package com.operations.vehicletransactions.movement;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.common.ClsNumberToWord;
import com.connection.ClsConnection;
import com.ibm.icu.text.DecimalFormat;
import com.opensymphony.xwork2.ActionSupport;
public class ClsMovementAction extends ActionSupport{
ClsCommon objcommon=new ClsCommon();
ClsMovementDAO movementDAO=new ClsMovementDAO();
ClsMovementBean bean;
private String clstatus;
private String accdetails;
private float accfines;
private String garagedeldate;
private String hidgaragedeliverydate;
private String garagedeliverytime;
private String hidgaragedeliverytime;
private float garagedeliverykm;
private String cmbgaragedeliveryfuel;
private String hidcmbgaragedeliveryfuel;
private String garagecollectdate;
private String hidgaragecollectdate;
private String garagecollecttime;
private String hidgaragecollecttime;
private float garagecollectkm;
private String cmbgaragecollectfuel;
private String hidcmbgaragecollectfuel;
private int hidgarage;
private String garage;
private int hidchkgaragedelivery;
private int hidchkgaragecollect;
private int hidaccidents;
private String staff;
private int hidstaff;
private int docno;
private String date;
private String hiddate;
private int txtfleetno;
private String txtfleetname;
private String cmblocation;
private String hidcmblocation;
private String dateout;
private String hiddateout;
private String timeout;
private String hidtimeout;
private String outkm;
private String cmboutfuel;
private String hidcmboutfuel;
private String cmbstatus;
private String hidcmbstatus;
private String driver;
private String hiddriver;
private String outremarks;
private String outuser;
private String cmbcloselocation;
private String hidcmbcloselocation;
private String closedate;
private String hidclosedate;
private String closetime;
private String hidclosetime;
private float closekm;
private String cmbclosefuel;
private String hidcmbclosefuel;
private String closedriver;
private String hidclosedriver;
private String closeremarks;
private String closeuser;
private float totalkm;
private String accdate;
private String hidaccdate;
private String acctime;
private String hidacctime;
private String cmbacctype;
private String hidcmbacctype;
private int cmbprcs;
private int hidcmbprcs;
private String collectdate;
private String hidcollectdate;
private String accplace;
private double fines;
private String details;
private String mode;
private String delete;
private int outuserid;
private int hidcloseuser;
private String msg;
private String cmbaccidents;
private String hidcmbaccidents;
private String closestaff;
private String formdetail;
private String formdetailcode;
private String movtempstatus;
private String hiddelivery;
private String hidcollect;
private String chkstatus;
private String deliverystatus;
private String cmbbranch;
private String hidcmbbranch;
private String cmbclosebranch;
private String hidcmbclosebranch;
private String vehtrancode;
//Getters for Print

private String lblcompname;
private String lblcompaddress;
private String lblcomptel;
private String lblcompfax;
private String lbllocation;
private String lbldocno;
private String lblfromdate;
private String lbltodate;
private String lbltariftype;
private String lblclient;
private String lblbranch;
private String lblprintname;
//open
private String lblopenbranch;
private String lblopenlocation;
private String lblfleetno;
private String lblfleetdetails;
private String lblkmout;
private String lbldateout;
private String lbltimeout;
private String lblfuelout;
private String lblmovtype;
private String lblgaragename;
private String lbldate;
private String lblopenuser;
private String lblopenstaff;
private String lblopendriver;
//delivery
private String lbldeldate;
private String lbldeltime;
private String lbldelkm;
private String lbldelfuel;
//Collection
private String lblcoldate;
private String lblcoltime;
private String lblcolfuel;
private String lblcolkm;
//Closing
private String lblclosebranch;
private String lblcloselocation;
private String lblaccfines;
private String lblaccdetails;
private String lblclosekm;
private String lblclosefuel;
private String lblclosedate;
private String lblclosetime;
private String lblclosedriver;




private String lblclosestaff;
private String lblcloseuser;
private String lblclosegarage;
private String lbltotalkm;


 private String lblhiddelivery;
 private String lblhidcollection;
 private String lblopenremarks;
 private String lblcloseremarks;
//getter and setter for printpath in db
	private String url;
 
 
public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	
	
public String getLblopenremarks() {
		return lblopenremarks;
	}
	public void setLblopenremarks(String lblopenremarks) {
		this.lblopenremarks = lblopenremarks;
	}
	public String getLblcloseremarks() {
		return lblcloseremarks;
	}
	public void setLblcloseremarks(String lblcloseremarks) {
		this.lblcloseremarks = lblcloseremarks;
	}
public String getVehtrancode() {
		return vehtrancode;
	}
	public void setVehtrancode(String vehtrancode) {
		this.vehtrancode = vehtrancode;
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
public String getCmbclosebranch() {
	return cmbclosebranch;
}
public void setCmbclosebranch(String cmbclosebranch) {
	this.cmbclosebranch = cmbclosebranch;
}
public String getHidcmbclosebranch() {
	return hidcmbclosebranch;
}
public void setHidcmbclosebranch(String hidcmbclosebranch) {
	this.hidcmbclosebranch = hidcmbclosebranch;
}
public String getDeliverystatus() {
	return deliverystatus;
}
public void setDeliverystatus(String deliverystatus) {
	this.deliverystatus = deliverystatus;
}
public String getChkstatus() {
	return chkstatus;
}
public void setChkstatus(String chkstatus) {
	this.chkstatus = chkstatus;
}
public String getLbltimeout() {
	return lbltimeout;
}
public void setLbltimeout(String lbltimeout) {
	this.lbltimeout = lbltimeout;
}
public String getLbllocation() {
	return lbllocation;
}
public void setLbllocation(String lbllocation) {
	this.lbllocation = lbllocation;
}
public String getLblprintname() {
	return lblprintname;
}
public void setLblprintname(String lblprintname) {
	this.lblprintname = lblprintname;
}
public String getLblhiddelivery() {
	return lblhiddelivery;
}
public void setLblhiddelivery(String lblhiddelivery) {
	this.lblhiddelivery = lblhiddelivery;
}
public String getLblhidcollection() {
	return lblhidcollection;
}
public void setLblhidcollection(String lblhidcollection) {
	this.lblhidcollection = lblhidcollection;
}

public String getLblopenbranch() {
	return lblopenbranch;
}
public void setLblopenbranch(String lblopenbranch) {
	this.lblopenbranch = lblopenbranch;
}
public String getLblopenlocation() {
	return lblopenlocation;
}
public void setLblopenlocation(String lblopenlocation) {
	this.lblopenlocation = lblopenlocation;
}
public String getLblfleetno() {
	return lblfleetno;
}
public void setLblfleetno(String lblfleetno) {
	this.lblfleetno = lblfleetno;
}
public String getLblkmout() {
	return lblkmout;
}
public void setLblkmout(String lblkmout) {
	this.lblkmout = lblkmout;
}
public String getLbldateout() {
	return lbldateout;
}
public void setLbldateout(String lbldateout) {
	this.lbldateout = lbldateout;
}
public String getLblfuelout() {
	return lblfuelout;
}
public void setLblfuelout(String lblfuelout) {
	this.lblfuelout = lblfuelout;
}
public String getLblmovtype() {
	return lblmovtype;
}
public void setLblmovtype(String lblmovtype) {
	this.lblmovtype = lblmovtype;
}
public String getLblgaragename() {
	return lblgaragename;
}
public void setLblgaragename(String lblgaragename) {
	this.lblgaragename = lblgaragename;
}
public String getLbldate() {
	return lbldate;
}
public void setLbldate(String lbldate) {
	this.lbldate = lbldate;
}
public String getLblopenuser() {
	return lblopenuser;
}
public void setLblopenuser(String lblopenuser) {
	this.lblopenuser = lblopenuser;
}
public String getLblopenstaff() {
	return lblopenstaff;
}
public void setLblopenstaff(String lblopenstaff) {
	this.lblopenstaff = lblopenstaff;
}
public String getLblopendriver() {
	return lblopendriver;
}
public void setLblopendriver(String lblopendriver) {
	this.lblopendriver = lblopendriver;
}
public String getLbldeldate() {
	return lbldeldate;
}
public void setLbldeldate(String lbldeldate) {
	this.lbldeldate = lbldeldate;
}
public String getLbldeltime() {
	return lbldeltime;
}
public void setLbldeltime(String lbldeltime) {
	this.lbldeltime = lbldeltime;
}

public String getLblfleetdetails() {
	return lblfleetdetails;
}
public void setLblfleetdetails(String lblfleetdetails) {
	this.lblfleetdetails = lblfleetdetails;
}
public String getLbldelkm() {
	return lbldelkm;
}
public void setLbldelkm(String lbldelkm) {
	this.lbldelkm = lbldelkm;
}
public String getLbldelfuel() {
	return lbldelfuel;
}
public void setLbldelfuel(String lbldelfuel) {
	this.lbldelfuel = lbldelfuel;
}
public String getLblcoldate() {
	return lblcoldate;
}
public void setLblcoldate(String lblcoldate) {
	this.lblcoldate = lblcoldate;
}
public String getLblcoltime() {
	return lblcoltime;
}
public void setLblcoltime(String lblcoltime) {
	this.lblcoltime = lblcoltime;
}
public String getLblcolfuel() {
	return lblcolfuel;
}
public void setLblcolfuel(String lblcolfuel) {
	this.lblcolfuel = lblcolfuel;
}
public String getLblcolkm() {
	return lblcolkm;
}
public void setLblcolkm(String lblcolkm) {
	this.lblcolkm = lblcolkm;
}
public String getLblclosebranch() {
	return lblclosebranch;
}
public void setLblclosebranch(String lblclosebranch) {
	this.lblclosebranch = lblclosebranch;
}
public String getLblcloselocation() {
	return lblcloselocation;
}
public void setLblcloselocation(String lblcloselocation) {
	this.lblcloselocation = lblcloselocation;
}
public String getLblaccfines() {
	return lblaccfines;
}
public void setLblaccfines(String lblaccfines) {
	this.lblaccfines = lblaccfines;
}
public String getLblaccdetails() {
	return lblaccdetails;
}
public void setLblaccdetails(String lblaccdetails) {
	this.lblaccdetails = lblaccdetails;
}
public String getLblclosekm() {
	return lblclosekm;
}
public void setLblclosekm(String lblclosekm) {
	this.lblclosekm = lblclosekm;
}
public String getLblclosefuel() {
	return lblclosefuel;
}
public void setLblclosefuel(String lblclosefuel) {
	this.lblclosefuel = lblclosefuel;
}
public String getLblclosedate() {
	return lblclosedate;
}
public void setLblclosedate(String lblclosedate) {
	this.lblclosedate = lblclosedate;
}
public String getLblclosetime() {
	return lblclosetime;
}
public void setLblclosetime(String lblclosetime) {
	this.lblclosetime = lblclosetime;
}
public String getLblclosedriver() {
	return lblclosedriver;
}
public void setLblclosedriver(String lblclosedriver) {
	this.lblclosedriver = lblclosedriver;
}
public String getLblclosestaff() {
	return lblclosestaff;
}
public void setLblclosestaff(String lblclosestaff) {
	this.lblclosestaff = lblclosestaff;
}
public String getLblcloseuser() {
	return lblcloseuser;
}
public void setLblcloseuser(String lblcloseuser) {
	this.lblcloseuser = lblcloseuser;
}
public String getLblclosegarage() {
	return lblclosegarage;
}
public void setLblclosegarage(String lblclosegarage) {
	this.lblclosegarage = lblclosegarage;
}

public String getLbltotalkm() {
	return lbltotalkm;
}
public void setLbltotalkm(String lbltotalkm) {
	this.lbltotalkm = lbltotalkm;
}
public String getLblcompname() {
	return lblcompname;
}
public void setLblcompname(String lblcompname) {
	this.lblcompname = lblcompname;
}
public String getLblcompaddress() {
	return lblcompaddress;
}
public void setLblcompaddress(String lblcompaddress) {
	this.lblcompaddress = lblcompaddress;
}
public String getLblcomptel() {
	return lblcomptel;
}
public void setLblcomptel(String lblcomptel) {
	this.lblcomptel = lblcomptel;
}
public String getLblcompfax() {
	return lblcompfax;
}
public void setLblcompfax(String lblcompfax) {
	this.lblcompfax = lblcompfax;
}
public String getLbldocno() {
	return lbldocno;
}
public void setLbldocno(String lbldocno) {
	this.lbldocno = lbldocno;
}
public String getLblfromdate() {
	return lblfromdate;
}
public void setLblfromdate(String lblfromdate) {
	this.lblfromdate = lblfromdate;
}
public String getLbltodate() {
	return lbltodate;
}
public void setLbltodate(String lbltodate) {
	this.lbltodate = lbltodate;
}
public String getLbltariftype() {
	return lbltariftype;
}
public void setLbltariftype(String lbltariftype) {
	this.lbltariftype = lbltariftype;
}
public String getLblclient() {
	return lblclient;
}
public void setLblclient(String lblclient) {
	this.lblclient = lblclient;
}
public String getLblbranch() {
	return lblbranch;
}
public void setLblbranch(String lblbranch) {
	this.lblbranch = lblbranch;
}
public String getHiddelivery() {
	return hiddelivery;
}
public void setHiddelivery(String hiddelivery) {
	this.hiddelivery = hiddelivery;
}
public String getHidcollect() {
	return hidcollect;
}
public void setHidcollect(String hidcollect) {
	this.hidcollect = hidcollect;
}
public String getClstatus() {
	return clstatus;
}
public void setClstatus(String clstatus) {
	this.clstatus = clstatus;
}
public String getMovtempstatus() {
	return movtempstatus;
}
public void setMovtempstatus(String movtempstatus) {
	this.movtempstatus = movtempstatus;
}
public String getFormdetail() {
	return formdetail;
}
public void setFormdetail(String formdetail) {
	this.formdetail = formdetail;
}
public String getFormdetailcode() {
	return formdetailcode;
}
public void setFormdetailcode(String formdetailcode) {
	this.formdetailcode = formdetailcode;
}
public String getClosestaff() {
	return closestaff;
}
public void setClosestaff(String closestaff) {
	this.closestaff = closestaff;
}
public String getCmbaccidents() {
	return cmbaccidents;
}
public void setCmbaccidents(String cmbaccidents) {
	this.cmbaccidents = cmbaccidents;
}
public String getHidcmbaccidents() {
	return hidcmbaccidents;
}
public void setHidcmbaccidents(String hidcmbaccidents) {
	this.hidcmbaccidents = hidcmbaccidents;
}
public String getMsg() {
	return msg;
}
public void setMsg(String msg) {
	this.msg = msg;
}
public String getAccdetails() {
	return accdetails;
}
public void setAccdetails(String accdetails) {
	this.accdetails = accdetails;
}
public float getAccfines() {
	return accfines;
}
public void setAccfines(float accfines) {
	this.accfines = accfines;
}
public String getGaragedeldate() {
	return garagedeldate;
}
public void setGaragedeldate(String garagedeldate) {
	this.garagedeldate = garagedeldate;
}
public String getHidgaragedeliverydate() {
	return hidgaragedeliverydate;
}
public void setHidgaragedeliverydate(String hidgaragedeliverydate) {
	this.hidgaragedeliverydate = hidgaragedeliverydate;
}
public String getGaragedeliverytime() {
	return garagedeliverytime;
}
public void setGaragedeliverytime(String garagedeliverytime) {
	this.garagedeliverytime = garagedeliverytime;
}
public String getHidgaragedeliverytime() {
	return hidgaragedeliverytime;
}
public void setHidgaragedeliverytime(String hidgaragedeliverytime) {
	this.hidgaragedeliverytime = hidgaragedeliverytime;
}
public float getGaragedeliverykm() {
	return garagedeliverykm;
}
public void setGaragedeliverykm(float garagedeliverykm) {
	this.garagedeliverykm = garagedeliverykm;
}
public String getCmbgaragedeliveryfuel() {
	return cmbgaragedeliveryfuel;
}
public void setCmbgaragedeliveryfuel(String cmbgaragedeliveryfuel) {
	this.cmbgaragedeliveryfuel = cmbgaragedeliveryfuel;
}
public String getHidcmbgaragedeliveryfuel() {
	return hidcmbgaragedeliveryfuel;
}
public void setHidcmbgaragedeliveryfuel(String hidcmbgaragedeliveryfuel) {
	this.hidcmbgaragedeliveryfuel = hidcmbgaragedeliveryfuel;
}
public String getGaragecollectdate() {
	return garagecollectdate;
}
public void setGaragecollectdate(String garagecollectdate) {
	this.garagecollectdate = garagecollectdate;
}
public String getHidgaragecollectdate() {
	return hidgaragecollectdate;
}
public void setHidgaragecollectdate(String hidgaragecollectdate) {
	this.hidgaragecollectdate = hidgaragecollectdate;
}
public String getGaragecollecttime() {
	return garagecollecttime;
}
public void setGaragecollecttime(String garagecollecttime) {
	this.garagecollecttime = garagecollecttime;
}
public String getHidgaragecollecttime() {
	return hidgaragecollecttime;
}
public void setHidgaragecollecttime(String hidgaragecollecttime) {
	this.hidgaragecollecttime = hidgaragecollecttime;
}
public float getGaragecollectkm() {
	return garagecollectkm;
}
public void setGaragecollectkm(float garagecollectkm) {
	this.garagecollectkm = garagecollectkm;
}

public String getCmbgaragecollectfuel() {
	return cmbgaragecollectfuel;
}
public void setCmbgaragecollectfuel(String cmbgaragecollectfuel) {
	this.cmbgaragecollectfuel = cmbgaragecollectfuel;
}
public String getHidcmbgaragecollectfuel() {
	return hidcmbgaragecollectfuel;
}
public void setHidcmbgaragecollectfuel(String hidcmbgaragecollectfuel) {
	this.hidcmbgaragecollectfuel = hidcmbgaragecollectfuel;
}
public int getOutuserid() {
	return outuserid;
}
public void setOutuserid(int outuserid) {
	this.outuserid = outuserid;
}
public int getHidcloseuser() {
	return hidcloseuser;
}
public void setHidcloseuser(int hidcloseuser) {
	this.hidcloseuser = hidcloseuser;
}
public int getHidgarage() {
	return hidgarage;
}
public void setHidgarage(int hidgarage) {
	this.hidgarage = hidgarage;
}
public String getGarage() {
	return garage;
}
public void setGarage(String garage) {
	this.garage = garage;
}
public int getHidchkgaragedelivery() {
	return hidchkgaragedelivery;
}
public void setHidchkgaragedelivery(int hidchkgaragedelivery) {
	this.hidchkgaragedelivery = hidchkgaragedelivery;
}
public int getHidchkgaragecollect() {
	return hidchkgaragecollect;
}
public void setHidchkgaragecollect(int hidchkgaragecollect) {
	this.hidchkgaragecollect = hidchkgaragecollect;
}
public String getHiddate() {
	return hiddate;
}
public void setHiddate(String hiddate) {
	this.hiddate = hiddate;
}
public String getStaff() {
	return staff;
}
public void setStaff(String staff) {
	this.staff = staff;
}

public int getHidaccidents() {
	return hidaccidents;
}
public void setHidaccidents(int hidaccidents) {
	this.hidaccidents = hidaccidents;
}
public int getHidstaff() {
	return hidstaff;
}
public void setHidstaff(int i) {
	this.hidstaff = i;
}
public String getOutkm() {
	return outkm;
}
public void setOutkm(String outkm) {
	this.outkm = outkm;
}
public int getDocno() {
	return docno;
}
public void setDocno(int docno) {
	this.docno = docno;
}
public String getDate() {
	return date;
}
public void setDate(String date) {
	this.date = date;
}
public int getTxtfleetno() {
	return txtfleetno;
}
public void setTxtfleetno(int txtfleetno) {
	this.txtfleetno = txtfleetno;
}
public String getTxtfleetname() {
	return txtfleetname;
}
public void setTxtfleetname(String txtfleetname) {
	this.txtfleetname = txtfleetname;
}
public String getCmblocation() {
	return cmblocation;
}
public void setCmblocation(String cmblocation) {
	this.cmblocation = cmblocation;
}
public String getHidcmblocation() {
	return hidcmblocation;
}
public void setHidcmblocation(String hidcmblocation) {
	this.hidcmblocation = hidcmblocation;
}
public String getDateout() {
	return dateout;
}
public void setDateout(String dateout) {
	this.dateout = dateout;
}
public String getHiddateout() {
	return hiddateout;
}
public void setHiddateout(String hiddateout) {
	this.hiddateout = hiddateout;
}
public String getTimeout() {
	return timeout;
}
public void setTimeout(String timeout) {
	this.timeout = timeout;
}
public String getHidtimeout() {
	return hidtimeout;
}
public void setHidtimeout(String hidtimeout) {
	this.hidtimeout = hidtimeout;
}
public String getCmboutfuel() {
	return cmboutfuel;
}
public void setCmboutfuel(String cmboutfuel) {
	this.cmboutfuel = cmboutfuel;
}
public String getHidcmboutfuel() {
	return hidcmboutfuel;
}
public void setHidcmboutfuel(String hidcmboutfuel) {
	this.hidcmboutfuel = hidcmboutfuel;
}
public String getCmbstatus() {
	return cmbstatus;
}
public void setCmbstatus(String cmbstatus) {
	this.cmbstatus = cmbstatus;
}
public String getHidcmbstatus() {
	return hidcmbstatus;
}
public void setHidcmbstatus(String hidcmbstatus) {
	this.hidcmbstatus = hidcmbstatus;
}
public String getDriver() {
	return driver;
}
public void setDriver(String driver) {
	this.driver = driver;
}
public String getHiddriver() {
	return hiddriver;
}
public void setHiddriver(String hiddriver) {
	this.hiddriver = hiddriver;
}
public String getOutremarks() {
	return outremarks;
}
public void setOutremarks(String outremarks) {
	this.outremarks = outremarks;
}
public String getOutuser() {
	return outuser;
}
public void setOutuser(String outuser) {
	this.outuser = outuser;
}
public String getCmbcloselocation() {
	return cmbcloselocation;
}
public void setCmbcloselocation(String cmbcloselocation) {
	this.cmbcloselocation = cmbcloselocation;
}
public String getHidcmbcloselocation() {
	return hidcmbcloselocation;
}
public void setHidcmbcloselocation(String hidcmbcloselocation) {
	this.hidcmbcloselocation = hidcmbcloselocation;
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
public float getClosekm() {
	return closekm;
}
public void setClosekm(float closekm) {
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
public String getClosedriver() {
	return closedriver;
}
public void setClosedriver(String closedriver) {
	this.closedriver = closedriver;
}
public String getHidclosedriver() {
	return hidclosedriver;
}
public void setHidclosedriver(String hidclosedriver) {
	this.hidclosedriver = hidclosedriver;
}
public String getCloseremarks() {
	return closeremarks;
}
public void setCloseremarks(String closeremarks) {
	this.closeremarks = closeremarks;
}
public String getCloseuser() {
	return closeuser;
}
public void setCloseuser(String closeuser) {
	this.closeuser = closeuser;
}
public float getTotalkm() {
	return totalkm;
}
public void setTotalkm(float totalkm) {
	this.totalkm = totalkm;
}
public String getAccdate() {
	return accdate;
}
public void setAccdate(String accdate) {
	this.accdate = accdate;
}
public String getHidaccdate() {
	return hidaccdate;
}
public void setHidaccdate(String hidaccdate) {
	this.hidaccdate = hidaccdate;
}
public String getAcctime() {
	return acctime;
}
public void setAcctime(String acctime) {
	this.acctime = acctime;
}
public String getHidacctime() {
	return hidacctime;
}
public void setHidacctime(String hidacctime) {
	this.hidacctime = hidacctime;
}
public String getCmbacctype() {
	return cmbacctype;
}
public void setCmbacctype(String cmbacctype) {
	this.cmbacctype = cmbacctype;
}
public String getHidcmbacctype() {
	return hidcmbacctype;
}
public void setHidcmbacctype(String hidcmbacctype) {
	this.hidcmbacctype = hidcmbacctype;
}
public int getCmbprcs() {
	return cmbprcs;
}
public void setCmbprcs(int cmbprcs) {
	this.cmbprcs = cmbprcs;
}
public int getHidcmbprcs() {
	return hidcmbprcs;
}
public void setHidcmbprcs(int hidcmbprcs) {
	this.hidcmbprcs = hidcmbprcs;
}
public String getCollectdate() {
	return collectdate;
}
public void setCollectdate(String collectdate) {
	this.collectdate = collectdate;
}
public String getHidcollectdate() {
	return hidcollectdate;
}
public void setHidcollectdate(String hidcollectdate) {
	this.hidcollectdate = hidcollectdate;
}
public String getAccplace() {
	return accplace;
}
public void setAccplace(String accplace) {
	this.accplace = accplace;
}
public double getFines() {
	return fines;
}
public void setFines(double fines) {
	this.fines = fines;
}
public String getDetails() {
	return details;
}
public void setDetails(String details) {
	this.details = details;
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




private Map<String, Object> param=null;


public Map<String, Object> getParam() {
	return param;
}
public void setParam(Map<String, Object> param) {
	this.param = param;
}



//Reload Method
public void setvalues(java.sql.Date date,java.sql.Date dateout,java.sql.Date closedate,java.sql.Date garagedeliverydate,java.sql.Date garagecollectdate,String mode,HttpSession session){
	if(date!=null){
		setDate(date.toString());	
	}
	if(dateout!=null){
		setDateout(dateout.toString());	
	}
//	System.out.println("Out Date:"+getDateout());
		setHidcmbstatus(getCmbstatus());
		setHidtimeout(getTimeout());
		setTxtfleetno(getTxtfleetno());
		setTxtfleetname(getTxtfleetname());
		setHidcmblocation(getCmblocation());
		setHidcmbbranch(getCmbbranch());
		setOutkm(getOutkm());
		setHidcmboutfuel(getCmboutfuel());
		setHiddriver(getHiddriver());
		setDriver(getDriver());
		setOutremarks(getOutremarks());
		setHidchkgaragecollect(getHidchkgaragecollect());
		setHidchkgaragedelivery(getHidchkgaragedelivery());
		
		setVehtrancode(getVehtrancode());
		/*if(getHidchkgaragedelivery()==1){
			if(mode.equalsIgnoreCase("A")){
				setDeliverystatus("0");	
			}
			else{
				setDeliverystatus("1");
			}
			
		}
		else{
			setDeliverystatus("0");
		}*/
		if(getHidchkgaragedelivery()==1){
			
			if(garagedeliverydate!=null){
				setGaragedeldate(garagedeliverydate.toString());
				//setHiddelivery(garagedeliverydate.toString());
				}
				
			setHidgaragedeliverytime(getGaragedeliverytime());
			setGaragedeliverykm(getGaragedeliverykm());
			setHidcmbgaragedeliveryfuel(getCmbgaragedeliveryfuel());
			}
		if(getHidchkgaragecollect()==1){
			if(garagecollectdate!=null){
				setGaragecollectdate(garagecollectdate.toString());		
				setHidcollect(garagecollectdate.toString());
			}
			
			setHidgaragecollecttime(getGaragecollecttime());
			setGaragecollectkm(getGaragecollectkm());
			setHidcmbgaragecollectfuel(getCmbgaragecollectfuel());
			}
if(closedate!=null){
	setClosedate(closedate.toString());
}	

		setHidcmbcloselocation(getCmbcloselocation());
		setHidcmbclosebranch(getCmbclosebranch());
		setHidclosetime(getClosetime());
		setClosekm(getClosekm());
		setHidcmbclosefuel(getCmbclosefuel());
		setHidclosedriver(getHidclosedriver());
		setClosedriver(getClosedriver());
		setHidcmbaccidents(getCmbaccidents());
		setAccdetails(getAccdetails());
		setAccfines(getAccfines());
		
		setHidcloseuser(getHidcloseuser());
		setCloseremarks(getCloseremarks());
		setTotalkm(getTotalkm());
		
}


public String saveAction() throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	//System.out.println("hhhhhhhhhhhhhhhhheeeeeeeeeee"+getMode()+","+getModeldate());

	session.getAttribute("BranchName");
//	System.out.println("sessoin"+session.getAttribute("BRANCHSELECTED"));
//	System.out.println("sessoin"+session.getAttribute("COMPANYNAME"));
	//System.out.println("request==="+request.getAttribute("BranchName"));
	
	String mode=getMode();
	ClsMovementBean bean=new ClsMovementBean();
	java.sql.Date date = null;
	java.sql.Date dateout=null ;
	java.sql.Date closedate=null;
	java.sql.Date garagecollectdate=null;
	java.sql.Date garagedeliverydate=null;
	//System.out.println("Close Date:::::"+getClosedate());
	//closedate = ClsCommon.changeStringtoSqlDate(getClosedate());
//	System.out.println("Close Date In Action :"+getClosedate());
	if(getClosedate()==null){
//		System.out.println("inside null");
	}
if((mode.equalsIgnoreCase("A"))||mode.equalsIgnoreCase("close")||mode.equalsIgnoreCase("D")){
	if(getDate()!=null){
	date = objcommon.changeStringtoSqlDate(getDate());
	}
	if(getDateout()!=null ){
		dateout = objcommon.changeStringtoSqlDate(getDateout());	
	}
	if(getClosedate()!=null ){
//		System.out.println("CheckCloseDate:"+getClosedate());
		closedate = objcommon.changeStringtoSqlDate(getClosedate());	
	}
	if(getGaragedeldate()!=null ){
		if(!(getGaragedeldate().equalsIgnoreCase(""))){
		garagedeliverydate=objcommon.changeStringtoSqlDate(getGaragedeldate());	
	}
	}
	
	if(getGaragecollectdate()!=null ){
		if(!(getGaragecollectdate().equalsIgnoreCase(""))){
		garagecollectdate=objcommon.changeStringtoSqlDate(getGaragecollectdate());
	}
	}
	System.out.println("///"+getGaragecollectdate()+"////");
	System.out.println("///"+garagecollectdate+"////");
}
	
	
	if(mode.equalsIgnoreCase("A")){
		
					int val=movementDAO.insert(date,dateout,getTxtfleetno(),getCmblocation(),getTimeout(),getOutkm(),
							getCmboutfuel(),getCmbstatus(),getHiddriver(),getOutremarks(),getOutuser(),getCmbacctype(),getCmbprcs(),getAccplace(),
							getFines(),getDetails(),getAcctime(),getMode(),session,getHidaccidents(),getHidstaff(),getHidgarage(),getHidchkgaragedelivery(),
							getHidchkgaragecollect(),getFormdetailcode(),getCmbbranch(),getVehtrancode());
					if(val>0.0){
						
						setvalues(date,dateout,closedate,garagedeliverydate,garagecollectdate,mode,session);
						setDocno(val);
						setMovtempstatus("OUT");
						setOutuser(session.getAttribute("USERNAME").toString());
						setMsg("Successfully Saved");
						setDeliverystatus("0");
						return "success";
					}
					else{
						
						setvalues(date,dateout,closedate,garagedeliverydate,garagecollectdate,mode,session);
						setDocno(val);
						setOutuser(session.getAttribute("USERNAME").toString());

						setMsg("Not Saved");
						setChkstatus("1");
						setDeliverystatus("0");
						return "fail";
					}	
	}
	else if(mode.equalsIgnoreCase("close")){
//		System.out.println("Inside Close");
		if(getCmbstatus().equalsIgnoreCase("GA") || getCmbstatus().equalsIgnoreCase("GS") || getCmbstatus().equalsIgnoreCase("GM")){
		bean=movementDAO.getDeliveryData(getDocno());
		setGaragedeldate(bean.getGaragedeliverydate());
		setGaragedeliverytime(bean.getHidgaragedeliverytime());
		setGaragedeliverykm(bean.getGaragedeliverykm());
		setCmbgaragedeliveryfuel(bean.getHidcmbgaragedeliveryfuel());
		}
		System.out.println("check: "+garagecollectdate);
		int value=movementDAO.close(getDocno(),getCmbcloselocation(),getCmbclosefuel(),closedate,getClosetime(),getClosekm(),getCloseremarks(),getTotalkm(),session,getTxtfleetno(),
				getAccdetails(),getAccfines(),getHidaccidents(),getHidchkgaragecollect(),garagecollectdate,getGaragecollecttime(),getGaragecollectkm(),
				getCmbgaragecollectfuel(),getCmbcloselocation(),getCmbstatus(),getHidchkgaragecollect(),getHidclosedriver(),getCmbclosebranch(),getCmbbranch(),getVehtrancode());
	if(value>0){

		setvalues(date,dateout,closedate,garagedeliverydate,garagecollectdate,mode,session);
		setDocno(getDocno());
		setMsg("Successfully Saved");
		setOutuser(getOutuser());
		setCloseuser(session.getAttribute("USERNAME").toString());
		setClstatus("1");
		setMovtempstatus("IN");
		setDeliverystatus("1");
		return "success";
		
	}
	else{
		setvalues(date,dateout,closedate,garagedeliverydate,garagecollectdate,mode,session);
		setDocno(getDocno());
		setChkstatus("1");
		setOutuser(getOutuser());
		setCloseuser(session.getAttribute("USERNAME").toString());
		setDeliverystatus("1");
		setMsg("Not Saved");
		return "fail";

	}
	}
	else if(mode.equalsIgnoreCase("View")){

				bean=movementDAO.getViewDetails(getDocno());
				setTxtfleetno(bean.getTxtfleetno());
				setTxtfleetname(bean.getTxtfleetname());
				setDocno(bean.getDocno());
				if(bean.getDate()!=null){
					setDate(bean.getDate());	
				}
				if(bean.getDateout()!=null){
					setDateout(bean.getDateout());	
				}
				setVehtrancode(bean.getVehtrancode());
				setHidtimeout(bean.getHidtimeout());
				setOutkm(bean.getOutkm());
				setHidcmboutfuel(bean.getHidcmboutfuel());
				setHidcmblocation(bean.getHidcmblocation());
				setHidcmbbranch(bean.getHidcmbbranch());
				//System.out.println("::::::::::::::::::"+getHidcmbbranch());
				setHidcmbstatus(bean.getHidcmbstatus());
				setOutremarks(bean.getOutremarks());
				setOutuser(bean.getOutuser());
				setHidchkgaragedelivery(bean.getHidchkgaragedelivery());
				//System.out.println("Delivery check:"+getHidchkgaragedelivery());
				if(bean.getGaragedeliverydate()!=null){
					setGaragedeldate(bean.getGaragedeliverydate());	
					setHiddelivery(bean.getGaragedeliverydate());
//					System.out.println("Get Garage Delivery :"+getHiddelivery());
				}
				//setGaragedeldate(bean.getGaragedeliverydate());
				setHidgaragedeliverytime(bean.getHidgaragedeliverytime());
				setGaragedeliverykm(bean.getGaragedeliverykm());
				setHidcmbgaragedeliveryfuel(bean.getHidcmbgaragedeliveryfuel());
				
				setHidchkgaragecollect(bean.getHidchkgaragecollect());
				if(bean.getGaragecollectdate()!=null){
					setGaragecollectdate(bean.getGaragecollectdate());
					setHidcollect(bean.getGaragecollectdate());
				}
				
				setHidgaragecollecttime(bean.getHidgaragecollecttime());
				setGaragecollectkm(bean.getGaragecollectkm());
				setHidcmbgaragecollectfuel(bean.getHidcmbgaragecollectfuel());
				setTotalkm(bean.getTotalkm());
				setHidcmbcloselocation(bean.getHidcmbcloselocation());
				if(bean.getClosedate()!=null){
					setClosedate(bean.getClosedate());
				}
				setHidcmbclosebranch(bean.getHidcmbclosebranch());
				setHidclosetime(bean.getHidclosetime());
				setClosekm(bean.getClosekm());
				setHidcmbclosefuel(bean.getHidcmbclosefuel());
				setClosedriver(bean.getClosedriver());
				setHidclosedriver(bean.getHidclosedriver());
				setCloseremarks(bean.getCloseremarks());
				setCloseuser(bean.getCloseuser());
				setHidcloseuser(bean.getHidcloseuser());
				setHidcmbstatus(bean.getHidcmbstatus());
				setHidgarage(bean.getHidgarage());
				setGarage(bean.getGarage());
				setOutuserid(bean.getOutuserid());
				setHidcmbaccidents(bean.getHidcmbaccidents());
				setHiddriver(bean.getHiddriver());
				setDriver(bean.getDriver());
				setHidstaff(bean.getHidstaff());
				setStaff(bean.getStaff());
				setAccdetails(bean.getAccdetails());
				setAccfines(bean.getAccfines());
				setClosedriver(bean.getClosedriver());
				setHidclosedriver(bean.getHidclosedriver());
				setClosestaff(bean.getClosestaff());
				setCloseremarks(bean.getCloseremarks());
				setClstatus(bean.getClstatus());
				setDeliverystatus(bean.getDeliverystatus());
				//setTotalkm(bean.getTotalkm());
//				System.out.println("Check Delivery Date:"+getGaragedeldate());
				/*setHidgaragedeliverydate(getGaragedeliverydate());
				setHidgaragecollectdate(getGaragecollectdate());*/
				if(getClstatus()!=null){
				if(getClstatus().equalsIgnoreCase("1")){
					setMovtempstatus("IN");
					
				}
				else{
					setMovtempstatus("OUT");
				}
				}
//				System.out.println("sucess");

	}



	/*else if(mode.equalsIgnoreCase("E")){
			boolean Status=rentalagentDAO.edit(getCode(),getName(),sqlStartDate,getTxtaccno(),session,getMode(),getDocno());
			if(Status){
				
				//System.out.println("hhhhhhhhhhhhhhhhheeeeeeeeeee"+getMode()+","+getModeldate());
				session.getAttribute("BranchName");
				//setDealerid(getDealerid());
				setCode(getCode());
				setName(getName());
				setHidrentalagentdate(getRentalagentdate());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				setDocno(getDocno());
				setMode(getMode());
		
				request.setAttribute("SAVED", "Updated Successfully");

				return "success";
			}
			else{
				request.setAttribute("SAVED", "Not Updated");

				return "fail";
			}
		}*/
		else if(mode.equalsIgnoreCase("D")){
			//System.out.println(getDocno()+","+getBrandid()+","+getModeldate());
			boolean Status=movementDAO.delete(getDocno(),getFormdetailcode(),session);
			
		if(Status){
			
			setDocno(getDocno());
			setvalues(date,dateout,closedate,garagedeliverydate,garagecollectdate,mode,session);
			setDelete("DELETED");
			
			setMsg("Successfully Deleted");

			return "success";
		}
		else{
			
			setvalues(date,dateout,closedate,garagedeliverydate,garagecollectdate,mode,session);
			setMsg("Not Deleted");
			setDocno(getDocno());
			

			return "fail";
		}
		}
		return "fail";
	}


public String printAction() throws ParseException, SQLException{
//	System.out.println("Inside print Action");
	
	
	//System.out.println("helo");
	
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	String dtype=request.getParameter("dtype").toString();
	String brhid=request.getParameter("brhid").toString();
	ClsMovementAction movaction =new ClsMovementAction();
	ClsConnection conobj=new ClsConnection();
	bean=movementDAO.getPrint(getDocno(),brhid,dtype);
	setLblcompname(bean.getLblcompname());
	setLblcompaddress(bean.getLblcompaddress());
	setLblcompfax(bean.getLblcompfax());
	setLblcomptel(bean.getLblcomptel());
	setLblbranch(bean.getLblbranch());
	setLbllocation(bean.getLbllocation());
	setLblprintname("Movement");
	setUrl(objcommon.getPrintPath("MOV"));
	/*setLbldocno(bean.getLbldocno());
	setLbltariftype(bean.getLbltariftype());
	setLblclient(bean.getLblclient());
	setLblfromdate(bean.getLblfromdate());
	setLbltodate(bean.getLbltodate());*/
	
	setLblopenbranch(bean.getLblopenbranch());
	setLblopenlocation(bean.getLblopenlocation());
	setLblfleetno(bean.getLblfleetno());
	setLblfleetdetails(bean.getLblfleetdetails());
	setLbldateout(bean.getLbldateout());
	setLbltimeout(bean.getLbltimeout());
	setLblfuelout(bean.getLblfuelout());
	setLblkmout(bean.getLblkmout());
	setLbldocno(bean.getLbldocno());
	setLbldate(bean.getLbldate());
	setLblopendriver(bean.getLblopendriver());
	setLblopenstaff(bean.getLblopenstaff());
	setLblopenuser(bean.getLblopenuser());
	setLbldeldate(bean.getLbldeldate());
	setLbldelfuel(bean.getLbldelfuel());
	setLbldelkm(bean.getLbldelkm());
	setLbldeltime(bean.getLbldeltime());
	setLblcoldate(bean.getLblcoldate());
	setLblcoltime(bean.getLblcoltime());
	setLblcolkm(bean.getLblcolkm());
	setLblcolfuel(bean.getLblcolfuel());
	setLblclosebranch(bean.getLblclosebranch());
	setLblcloselocation(bean.getLblcloselocation());
	setLblaccdetails(bean.getLblaccdetails());
	setLblaccfines(bean.getLblaccfines());
	setLblclosekm(bean.getLblclosekm());
	setLblclosefuel(bean.getLblclosefuel());
	setLblclosedate(bean.getLblclosedate());
	setLblclosetime(bean.getLblclosetime());
	setLbltotalkm(bean.getLbltotalkm());
	setLblclosedriver(bean.getLblclosedriver());
	setLblclosestaff(bean.getLblclosestaff());
	setLblclosegarage(bean.getLblclosegarage());
	setLblcloseuser(bean.getLblcloseuser());
	setLblhiddelivery(bean.getLblhiddelivery());
	setLblhidcollection(bean.getLblhidcollection());
	setLblgaragename(bean.getLblgaragename());
	setLblclosegarage(bean.getLblclosegarage());
	setLblmovtype(bean.getLblmovtype());
	setLblopenremarks(bean.getLblopenremarks());
	setLblcloseremarks(bean.getLblcloseremarks());
	
	//System.out.println("helo path======"+objcommon.getPrintPath(dtype)+"dtyperrrrr"+dtype);
	if(objcommon.getPrintPath(dtype).contains(".jrxml")==true)
	{
		 HttpServletResponse response = ServletActionContext.getResponse();
	//	jasperHVLPrintAction();
		   Connection conn = null;
		 try {
			  
				String id=request.getParameter("id")==null?"0":request.getParameter("id");
			
				 param = new HashMap();
		   
		                conn = conobj.getMyConnection();
		           
			          
			        param.put("doc",getDocno());		         
			         param.put("staff",bean.getLblopenstaff());
			         param.put("fleetno", bean.getLblfleetno());
			         param.put("fleetdetail", bean.getLblfleetdetails());
			         param.put("dateout", bean.getLbldateout());
			         param.put("kmout", bean.getLblkmout());
			         param.put("fueldet", bean.getLblfuelout());
			         param.put("datein", bean.getLblclosedate());
			         param.put("timein", bean.getLblclosetime());
			         param.put("drverdet", bean.getLblclosedriver());
			         param.put("accidet", bean.getLblaccdetails());
			         param.put("accifine", bean.getLblaccfines());
			         param.put("branch", bean.getLblopenbranch());
			         param.put("kmin", bean.getLblclosekm());
			         param.put("fueldetin", bean.getLblclosefuel());
				        
			         param.put("branchin", bean.getLblclosebranch());
				        
			         String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
			        	imgpath=imgpath.replace("\\", "\\\\");    
			          param.put("imghedderpath", imgpath); 
			          
			          
			          String imgpath2=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
			        	imgpath2=imgpath2.replace("\\", "\\\\");    
			          param.put("imgfooterpath", imgpath2);
			          
			         param.put("header",1);
			         param.put("remarkmov", bean.getLblopenremarks());
			         param.put("remarkcls", bean.getLblcloseremarks());
					  param.put("termqry",bean.getTermqry());
			     	
					  String path[]=objcommon.getPrintPath(dtype).split("movement/");
				        setUrl(path[1]);

		           JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(objcommon.getPrintPath(dtype)));
	         	 
	         	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
	                           generateReportPDF(response, param, jasperReport, conn);
	                     
	          
	                 } catch (Exception e) {
	  
	                     e.printStackTrace();
	  
	                 }
		 finally{
			 conn.close();
		 }

	}
	return "print";
}


private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException {
	  byte[] bytes = null;
  bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
    resp.reset();
  resp.resetBuffer();
  
  resp.setContentType("application/pdf");
  resp.setContentLength(bytes.length);
  ServletOutputStream ouputStream = resp.getOutputStream();
  ouputStream.write(bytes, 0, bytes.length);
 
  ouputStream.flush();
  ouputStream.close();
 
       
}


	
}

