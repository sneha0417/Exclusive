package com.controlcentre.masters.vehiclemaster.vehicle;

import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;


@SuppressWarnings("serial")
public class ClsVehicleAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();

	ClsVehicleDAO clsVehicleDAO= new ClsVehicleDAO();
	private int fleetno;
	private String fleetname;
	private String jqxDate1;
	private String hidjqxDate1;
	private int docno;
	private String cmbauthority;
	private String hidcmbauthority;
	private String cmbplate;
	private String hidcmbplate;
	private String regno;
	private String cmbgroup;
	private String hidcmbgroup;
	private String group_name;
	private String fileno;
		private String mortgaged;
	private String hidmortgaged;
	private String errormsg;
	
	public String getErrormsg() {
		return errormsg;
	}

	public void setErrormsg(String errormsg) {
		this.errormsg = errormsg;
	}

	public String getMortgaged() {
		return mortgaged;
	}

	public void setMortgaged(String mortgaged) {
		this.mortgaged = mortgaged;
	}

	public String getHidmortgaged() {
		return hidmortgaged;
	}

	public void setHidmortgaged(String hidmortgaged) {
		this.hidmortgaged = hidmortgaged;
	}
	public String getFileno() {
		return fileno;
	}

	public void setFileno(String fileno) {
		this.fileno = fileno;
	}

	private String cmbbrand;
	private String hidcmbbrand;
	private String cmbmodel;
	private String hidcmbmodel;
	private String cmbyom;
	private String hidcmbyom;
	private String aststatus;
	private String opstatus;
	private String salik_tag;
	private String tcno;
	private String mode;
	private String formdetail;
	private String formdetailcode;
	private int gridlength;
	
	
public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
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

	//puechase info
	private String dealer;
	private int hiddealer;
	private String dealer3;
	private String dealer4;
	private String deal_no;
	private String purchase;
	private String hidpurchase;
	private int lpo_no;
	private String purchase_invoice;
	private String jqxPurchaseDate;
	private String hidjqxPurchaseDate;
	private double purchase_cost;
	private double additions;
	private double total;

	//-------Finance Info--------
	private String financier;
	private int hidfinancier;
	private int cmbfinancer;
	private int hidcmbfinancer;
	private double interest_amt;
	private double down_payment;
	private int no_installments;
	private String jqxFinRegDate;
	private String hidjqxFinRegDate;
	private String jqxFinRelDate;
	private String hidjqxFinRelDate;
	private double installment_amt;
	private int tran_no;
	private double depr_perc;
	private String accu_dep;


	//Other Info
	private String jqxOtherRegExp;
	private String hidjqxOtherRegExp;
	private String cmbinsurance_type;
	private String hidcmbinsurance_type;
	private String insurance_comp;
	private int hidinsurance_comp;
	private double insured_amt;
	private String jqxOtherInsExp;
	private String hidjqxOtherInsExp;
	private double premium_perc;
	private String policy_no;
	private double premium_amt;
	private String insurmember;
	private String trackid;


	//Vehicle Info
	private String engine_no;
	private String vin;
	private String chasis_no;
	private int cmbveh_color;
	private int hidcmbveh_color;

	//Warranty Info
	private int warranty_period;
	private String jqxWrntyFrmDate;
	private String hidjqxWrntyFrmDate;
	private String jqxWrntyToDate;
	private String hidjqxWrntyToDate;
	private double warranty_km;


	//service INfo
	private double service_km;
	private String jqxLstSrvcDate;
	private String hidjqxLstSrvcDate;
	private double last_srvc_km;


	//Release Info
	private int current_km;
	private String cmbfuel;
	private String hidcmbfuel;
	private String branded;
	private String hidbranded;
	private String cmbavail_br1;
	private String hidcmbavail_br1;
	private String fuelcapacity;
	private String cmbfueltype;
	private String hidcmbfueltype;
	//FleetRelease 
	private int releasefleet;
	private String cmbrlsbranch;
	private String hidcmbrlsbranch;
	private String cmbrlsloc;
	private String hidcmbrlsloc;
	private String cmbrentalstatus;
	private String hidcmbrentalstatus;
	private String cmbstatus;
	private String hidcmbstatus;
	private String hidreleasedate;
	private String releasedate;
	private String releasetime;
	private String hidreleasetime;
	private String releasekm;
	private String releasefuel;
	
	
private String deleted;
private String msg;
private String chkstatus;
	

	public String getInsurmember() {
	return insurmember;
}

public void setInsurmember(String insurmember) {
	this.insurmember = insurmember;
}

public String getTrackid() {
	return trackid;
}

public void setTrackid(String trackid) {
	this.trackid = trackid;
}

	public String getChkstatus() {
	return chkstatus;
}

public void setChkstatus(String chkstatus) {
	this.chkstatus = chkstatus;
}

	public String getMsg() {
	return msg;
}

public void setMsg(String msg) {
	this.msg = msg;
}

public String getDeleted() {
	return deleted;
}

	public String getDelete() {
	return deleted;
}

public void setDeleted(String deleted) {
	this.deleted = deleted;
}

	public String getReleasetime() {
		return releasetime;
	}

	public void setReleasetime(String releasetime) {
		this.releasetime = releasetime;
	}

	public String getHidreleasetime() {
		return hidreleasetime;
	}

	public void setHidreleasetime(String hidreleasetime) {
		this.hidreleasetime = hidreleasetime;
	}

	public String getReleasekm() {
		return releasekm;
	}

	public void setReleasekm(String releasekm) {
		this.releasekm = releasekm;
	}

	public String getReleasefuel() {
		return releasefuel;
	}

	public void setReleasefuel(String releasefuel) {
		this.releasefuel = releasefuel;
	}

	public String getFuelcapacity() {
		return fuelcapacity;
	}

	public void setFuelcapacity(String fuelcapacity) {
		this.fuelcapacity = fuelcapacity;
	}

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

	public String getHidreleasedate() {
		return hidreleasedate;
	}

	public void setHidreleasedate(String hidreleasedate) {
		this.hidreleasedate = hidreleasedate;
	}

	public String getReleasedate() {
		return releasedate;
	}

	public void setReleasedate(String releasedate) {
		this.releasedate = releasedate;
	}

	public int getReleasefleet() {
		return releasefleet;
	}

	public void setReleasefleet(int releasefleet) {
		this.releasefleet = releasefleet;
	}

	public String getCmbrlsbranch() {
		return cmbrlsbranch;
	}

	public void setCmbrlsbranch(String cmbrlsbranch) {
		this.cmbrlsbranch = cmbrlsbranch;
	}

	public String getHidcmbrlsbranch() {
		return hidcmbrlsbranch;
	}

	public void setHidcmbrlsbranch(String hidcmbrlsbranch) {
		this.hidcmbrlsbranch = hidcmbrlsbranch;
	}

	public String getCmbrlsloc() {
		return cmbrlsloc;
	}

	public void setCmbrlsloc(String cmbrlsloc) {
		this.cmbrlsloc = cmbrlsloc;
	}

	public String getHidcmbrlsloc() {
		return hidcmbrlsloc;
	}

	public void setHidcmbrlsloc(String hidcmbrlsloc) {
		this.hidcmbrlsloc = hidcmbrlsloc;
	}

	public String getCmbrentalstatus() {
		return cmbrentalstatus;
	}

	public void setCmbrentalstatus(String cmbrentalstatus) {
		this.cmbrentalstatus = cmbrentalstatus;
	}

	public String getHidcmbrentalstatus() {
		return hidcmbrentalstatus;
	}

	public void setHidcmbrentalstatus(String hidcmbrentalstatus) {
		this.hidcmbrentalstatus = hidcmbrentalstatus;
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

	public String getDealer() {
		return dealer;
	}

	public void setDealer(String dealer) {
		this.dealer = dealer;
	}

	public int getHiddealer() {
		return hiddealer;
	}

	public void setHiddealer(int hiddealer) {
		this.hiddealer = hiddealer;
	}

	public String getFinancier() {
		return financier;
	}

	public void setFinancier(String financier) {
		this.financier = financier;
	}

	public int getHidfinancier() {
		return hidfinancier;
	}

	public void setHidfinancier(int hidfinancier) {
		this.hidfinancier = hidfinancier;
	}

	public int getHidinsurance_comp() {
		return hidinsurance_comp;
	}

	public void setHidinsurance_comp(int hidinsurance_comp) {
		this.hidinsurance_comp = hidinsurance_comp;
	}

	public int getFleetno() {
		return fleetno;
	}

	public void setFleetno(int fleetno) {
		this.fleetno = fleetno;
	}

	public String getFleetname() {
		return fleetname;
	}

	public void setFleetname(String fleetname) {
		this.fleetname = fleetname;
	}

	public String getJqxDate1() {
		return jqxDate1;
	}

	public void setJqxDate1(String jqxDate1) {
		this.jqxDate1 = jqxDate1;
	}

	public String getHidjqxDate1() {
		return hidjqxDate1;
	}

	public void setHidjqxDate1(String hidjqxDate1) {
		this.hidjqxDate1 = hidjqxDate1;
	}

	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
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

	public String getCmbplate() {
		return cmbplate;
	}

	public void setCmbplate(String cmbplate) {
		this.cmbplate = cmbplate;
	}

	public String getHidcmbplate() {
		return hidcmbplate;
	}

	public void setHidcmbplate(String hidcmbplate) {
		this.hidcmbplate = hidcmbplate;
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

	public String getGroup_name() {
		return group_name;
	}

	public void setGroup_name(String group_name) {
		this.group_name = group_name;
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

	public String getAststatus() {
		return aststatus;
	}

	public void setAststatus(String aststatus) {
		this.aststatus = aststatus;
	}

	public String getOpstatus() {
		return opstatus;
	}

	public void setOpstatus(String opstatus) {
		this.opstatus = opstatus;
	}

	public String getSalik_tag() {
		return salik_tag;
	}

	public void setSalik_tag(String salik_tag) {
		this.salik_tag = salik_tag;
	}

	public String getTcno() {
		return tcno;
	}

	public void setTcno(String tcno) {
		this.tcno = tcno;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getDealer3() {
		return dealer3;
	}

	public void setDealer3(String dealer3) {
		this.dealer3 = dealer3;
	}

	public String getDealer4() {
		return dealer4;
	}

	public void setDealer4(String dealer4) {
		this.dealer4 = dealer4;
	}

	public String getDeal_no() {
		return deal_no;
	}

	public void setDeal_no(String deal_no) {
		this.deal_no = deal_no;
	}

	public String getPurchase() {
		return purchase;
	}

	public void setPurchase(String purchase) {
		this.purchase = purchase;
	}
	public String getHidpurchase() {
		return hidpurchase;
	}

	public void setHidpurchase(String hidpurchase) {
		this.hidpurchase = hidpurchase;
	}


	public int getLpo_no() {
		return lpo_no;
	}

	public void setLpo_no(int lpo_no) {
		this.lpo_no = lpo_no;
	}

	public String getPurchase_invoice() {
		return purchase_invoice;
	}

	public void setPurchase_invoice(String purchase_invoice) {
		this.purchase_invoice = purchase_invoice;
	}

	public String getJqxPurchaseDate() {
		return jqxPurchaseDate;
	}

	public void setJqxPurchaseDate(String jqxPurchaseDate) {
		this.jqxPurchaseDate = jqxPurchaseDate;
	}

	public String getHidjqxPurchaseDate() {
		return hidjqxPurchaseDate;
	}

	public void setHidjqxPurchaseDate(String hidjqxPurchaseDate) {
		this.hidjqxPurchaseDate = hidjqxPurchaseDate;
	}

	public double getPurchase_cost() {
		return purchase_cost;
	}

	public void setPurchase_cost(double purchase_cost) {
		this.purchase_cost = purchase_cost;
	}

	public double getAdditions() {
		return additions;
	}

	public void setAdditions(double additions) {
		this.additions = additions;
	}

	public double getTotal() {
		return total;
	}

	public void setTotal(double total) {
		this.total = total;
	}

	public int getCmbfinancer() {
		return cmbfinancer;
	}

	public void setCmbfinancer(int cmbfinancer) {
		this.cmbfinancer = cmbfinancer;
	}

	public int getHidcmbfinancer() {
		return hidcmbfinancer;
	}

	public void setHidcmbfinancer(int hidcmbfinancer) {
		this.hidcmbfinancer = hidcmbfinancer;
	}

	public double getInterest_amt() {
		return interest_amt;
	}

	public void setInterest_amt(double interest_amt) {
		this.interest_amt = interest_amt;
	}

	public double getDown_payment() {
		return down_payment;
	}

	public void setDown_payment(double down_payment) {
		this.down_payment = down_payment;
	}

	public int getNo_installments() {
		return no_installments;
	}

	public void setNo_installments(int no_installments) {
		this.no_installments = no_installments;
	}

	public String getJqxFinRegDate() {
		return jqxFinRegDate;
	}

	public void setJqxFinRegDate(String jqxFinRegDate) {
		this.jqxFinRegDate = jqxFinRegDate;
	}

	public String getHidjqxFinRegDate() {
		return hidjqxFinRegDate;
	}

	public void setHidjqxFinRegDate(String hidjqxFinRegDate) {
		this.hidjqxFinRegDate = hidjqxFinRegDate;
	}

	public String getJqxFinRelDate() {
		return jqxFinRelDate;
	}

	public void setJqxFinRelDate(String jqxFinRelDate) {
		this.jqxFinRelDate = jqxFinRelDate;
	}

	public String getHidjqxFinRelDate() {
		return hidjqxFinRelDate;
	}

	public void setHidjqxFinRelDate(String hidjqxFinRelDate) {
		this.hidjqxFinRelDate = hidjqxFinRelDate;
	}

	public double getInstallment_amt() {
		return installment_amt;
	}

	public void setInstallment_amt(double installment_amt) {
		this.installment_amt = installment_amt;
	}

	public int getTran_no() {
		return tran_no;
	}

	public void setTran_no(int tran_no) {
		this.tran_no = tran_no;
	}

	public double getDepr_perc() {
		return depr_perc;
	}

	public void setDepr_perc(double depr_perc) {
		this.depr_perc = depr_perc;
	}

	public String getAccu_dep() {
		return accu_dep;
	}

	public void setAccu_dep(String accu_dep) {
		this.accu_dep = accu_dep;
	}

	public String getJqxOtherRegExp() {
		return jqxOtherRegExp;
	}

	public void setJqxOtherRegExp(String jqxOtherRegExp) {
		this.jqxOtherRegExp = jqxOtherRegExp;
	}

	public String getHidjqxOtherRegExp() {
		return hidjqxOtherRegExp;
	}

	public void setHidjqxOtherRegExp(String hidjqxOtherRegExp) {
		this.hidjqxOtherRegExp = hidjqxOtherRegExp;
	}

	public String getCmbinsurance_type() {
		return cmbinsurance_type;
	}

	public void setCmbinsurance_type(String cmbinsurance_type) {
		this.cmbinsurance_type = cmbinsurance_type;
	}

	public String getHidcmbinsurance_type() {
		return hidcmbinsurance_type;
	}

	public void setHidcmbinsurance_type(String hidcmbinsurance_type) {
		this.hidcmbinsurance_type = hidcmbinsurance_type;
	}

	public String getInsurance_comp() {
		return insurance_comp;
	}

	public void setInsurance_comp(String insurance_comp) {
		this.insurance_comp = insurance_comp;
	}

	public double getInsured_amt() {
		return insured_amt;
	}

	public void setInsured_amt(double insured_amt) {
		this.insured_amt = insured_amt;
	}

	public String getJqxOtherInsExp() {
		return jqxOtherInsExp;
	}

	public void setJqxOtherInsExp(String jqxOtherInsExp) {
		this.jqxOtherInsExp = jqxOtherInsExp;
	}

	public String getHidjqxOtherInsExp() {
		return hidjqxOtherInsExp;
	}

	public void setHidjqxOtherInsExp(String hidjqxOtherInsExp) {
		this.hidjqxOtherInsExp = hidjqxOtherInsExp;
	}

	public double getPremium_perc() {
		return premium_perc;
	}

	public void setPremium_perc(double premium_perc) {
		this.premium_perc = premium_perc;
	}

	public String getPolicy_no() {
		return policy_no;
	}

	public void setPolicy_no(String policy_no) {
		this.policy_no = policy_no;
	}

	public double getPremium_amt() {
		return premium_amt;
	}

	public void setPremium_amt(double premium_amt) {
		this.premium_amt = premium_amt;
	}

	public String getEngine_no() {
		return engine_no;
	}

	public void setEngine_no(String engine_no) {
		this.engine_no = engine_no;
	}

	public String getVin() {
		return vin;
	}

	public void setVin(String vin) {
		this.vin = vin;
	}

	public String getChasis_no() {
		return chasis_no;
	}

	public void setChasis_no(String chasis_no) {
		this.chasis_no = chasis_no;
	}

	public int getCmbveh_color() {
		return cmbveh_color;
	}

	public void setCmbveh_color(int cmbveh_color) {
		this.cmbveh_color = cmbveh_color;
	}

	public int getHidcmbveh_color() {
		return hidcmbveh_color;
	}

	public void setHidcmbveh_color(int hidcmbveh_color) {
		this.hidcmbveh_color = hidcmbveh_color;
	}

	public int getWarranty_period() {
		return warranty_period;
	}

	public void setWarranty_period(int warranty_period) {
		this.warranty_period = warranty_period;
	}

	public String getJqxWrntyFrmDate() {
		return jqxWrntyFrmDate;
	}

	public void setJqxWrntyFrmDate(String jqxWrntyFrmDate) {
		this.jqxWrntyFrmDate = jqxWrntyFrmDate;
	}

	public String getHidjqxWrntyFrmDate() {
		return hidjqxWrntyFrmDate;
	}

	public void setHidjqxWrntyFrmDate(String hidjqxWrntyFrmDate) {
		this.hidjqxWrntyFrmDate = hidjqxWrntyFrmDate;
	}

	public String getJqxWrntyToDate() {
		return jqxWrntyToDate;
	}

	public void setJqxWrntyToDate(String jqxWrntyToDate) {
		this.jqxWrntyToDate = jqxWrntyToDate;
	}

	public String getHidjqxWrntyToDate() {
		return hidjqxWrntyToDate;
	}

	public void setHidjqxWrntyToDate(String hidjqxWrntyToDate) {
		this.hidjqxWrntyToDate = hidjqxWrntyToDate;
	}

	public double getWarranty_km() {
		return warranty_km;
	}

	public void setWarranty_km(double warranty_km) {
		this.warranty_km = warranty_km;
	}

	public double getService_km() {
		return service_km;
	}

	public void setService_km(double service_km) {
		this.service_km = service_km;
	}

	public String getJqxLstSrvcDate() {
		return jqxLstSrvcDate;
	}

	public void setJqxLstSrvcDate(String jqxLstSrvcDate) {
		this.jqxLstSrvcDate = jqxLstSrvcDate;
	}

	public String getHidjqxLstSrvcDate() {
		return hidjqxLstSrvcDate;
	}

	public void setHidjqxLstSrvcDate(String hidjqxLstSrvcDate) {
		this.hidjqxLstSrvcDate = hidjqxLstSrvcDate;
	}

	public double getLast_srvc_km() {
		return last_srvc_km;
	}

	public void setLast_srvc_km(double last_srvc_km) {
		this.last_srvc_km = last_srvc_km;
	}

	public int getCurrent_km() {
		return current_km;
	}

	public void setCurrent_km(int current_km) {
		this.current_km = current_km;
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

	public String getBranded() {
		return branded;
	}

	public void setBranded(String branded) {
		this.branded = branded;
	}

	public String getCmbavail_br1() {
		return cmbavail_br1;
	}

	public void setCmbavail_br1(String cmbavail_br1) {
		this.cmbavail_br1 = cmbavail_br1;
	}

	public String getHidcmbavail_br1() {
		return hidcmbavail_br1;
	}

	public void setHidcmbavail_br1(String hidcmbavail_br1) {
		this.hidcmbavail_br1 = hidcmbavail_br1;
	}
	public String getHidbranded() {
		return hidbranded;
	}

	public void setHidbranded(String hidbranded) {
		this.hidbranded = hidbranded;
	}
	
	private String calibrationkm;
	
	
	public String getCalibrationkm() {
		return calibrationkm;
	}

	public void setCalibrationkm(String calibrationkm) {
		this.calibrationkm = calibrationkm;
	}
	Date jqxDate,purchDate,regDate,relDate,regExpDate,regotherInsDate,warntyFrmDate,warntyToDate,lstserDate;
public void getData(ClsVehicleBean bean){
	setFleetno(bean.getFleetno());setFleetname(getFleetname());
	setHidcmbauthority(getCmbauthority());setHidcmbplate(getCmbplate());
	
	setRegno(getRegno());setHidcmbgroup(getCmbgroup());setHidcmbbrand(getCmbbrand());
	setHidcmbmodel(getCmbmodel());setHidcmbyom(getCmbyom());setAststatus("INDUCTED");setOpstatus(getOpstatus());setSalik_tag(getSalik_tag());
	setTcno(getTcno());setDealer3(getDealer3());setDeal_no(getDeal_no());setHidpurchase(getPurchase());setLpo_no(getLpo_no());setPurchase_invoice(getPurchase_invoice());
	if(purchDate!=null){
		setJqxPurchaseDate(purchDate.toString());
	}
	if(jqxDate!=null){
		setJqxDate1(jqxDate.toString());
	}
	if(regDate!=null){
		setJqxFinRegDate(regDate.toString());
	}
	if(relDate!=null){
		setJqxFinRelDate(relDate.toString());
	}
	if(regExpDate!=null){
		setJqxOtherRegExp(regExpDate.toString());
	}
	if(regotherInsDate!=null){
		setJqxOtherInsExp(regotherInsDate.toString());
	}
	if(warntyFrmDate!=null){
		setJqxWrntyFrmDate(warntyFrmDate.toString());
	}
	if(warntyToDate!=null){
		setJqxWrntyToDate(warntyToDate.toString());
	}
	if(lstserDate!=null){
		setJqxLstSrvcDate(lstserDate.toString());
	}
	setWarranty_km(getWarranty_km());setService_km(getService_km());
	
	setPurchase_cost(getPurchase_cost());setAdditions(getAdditions());setTotal(getTotal());
	setHidcmbfinancer(getCmbfinancer());setInterest_amt(getInterest_amt());setDown_payment(getDown_payment());setNo_installments(getNo_installments());
	
	
	setInstallment_amt(getInstallment_amt());setTran_no(bean.getFleetno());
	setDepr_perc(getDepr_perc());setAccu_dep(getAccu_dep());setAccu_dep(getAccu_dep());
	
	setHidcmbinsurance_type(getCmbinsurance_type());setInsurance_comp(getInsurance_comp());setInsured_amt(getInsured_amt());
	
	setPremium_perc(getPremium_perc());setPolicy_no(getPolicy_no());setPremium_amt(getPremium_amt());
	setEngine_no(getEngine_no());setVin(getVin());setChasis_no(getChasis_no());setHidcmbveh_color(getCmbveh_color());setWarranty_period(getWarranty_period());
	
	setLast_srvc_km(getLast_srvc_km());setCurrent_km(getCurrent_km());setHidcmbfuel(getCmbfuel());
	setHidbranded(getBranded());setHidcmbavail_br1(getCmbavail_br1());setAccu_dep(getAccu_dep());
	setFileno(getFileno());setInsurmember(getInsurmember());setTrackid(getTrackid());
	setMortgaged(getMortgaged());setHidmortgaged(getHidmortgaged());
	setDocno(bean.getDocno());
	setDealer(getDealer());
	setHiddealer(getHiddealer());
	setFinancier(getFinancier());
	setReleasefleet(getFleetno());
	setHidfinancier(getHidfinancier());
	setFuelcapacity(getFuelcapacity());
	setHidcmbfueltype(getCmbfueltype());
//	System.out.println(getPurchase_cost());
//	System.out.println(getJqxFinRegDate());
//	System.out.println(getJqxFinRelDate());
//	System.out.println(getJqxOtherRegExp());
//	System.out.println(getJqxOtherInsExp());
//	System.out.println(getPremium_perc());
//	System.out.println(getTcno());
setCalibrationkm(getCalibrationkm());
}
	public String saveAction() throws ParseException, SQLException{
//		System.out.println("inside============================ ");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
//		System.out.println("here");
		try{
		String mode=getMode();
		ClsVehicleBean bean=new ClsVehicleBean();
		if(mode.equalsIgnoreCase("A") || mode.equalsIgnoreCase("E") || mode.equalsIgnoreCase("R")){
			if(!getJqxDate1().equalsIgnoreCase("") && getJqxDate1()!=null){
				jqxDate=ClsCommon.changeStringtoSqlDate(getJqxDate1());
			}
			if(!getJqxPurchaseDate().equalsIgnoreCase("") && getJqxPurchaseDate()!=null){
				purchDate=ClsCommon.changeStringtoSqlDate(getJqxPurchaseDate());
			}
			if(!getJqxFinRegDate().equalsIgnoreCase("") && getJqxFinRegDate()!=null){
				regDate=ClsCommon.changeStringtoSqlDate(getJqxFinRegDate());
			}
			if(!getJqxFinRelDate().equalsIgnoreCase("") && getJqxFinRelDate()!=null){
				relDate=ClsCommon.changeStringtoSqlDate(getJqxFinRelDate());
			}
			if(!getJqxOtherRegExp().equalsIgnoreCase("") && getJqxOtherRegExp()!=null){
				regExpDate=ClsCommon.changeStringtoSqlDate(getJqxOtherRegExp());
			}
			if(!getJqxOtherInsExp().equalsIgnoreCase("") && getJqxOtherInsExp()!=null){
				regotherInsDate=ClsCommon.changeStringtoSqlDate(getJqxOtherInsExp());
			}
			if(!getJqxWrntyFrmDate().equalsIgnoreCase("") && getJqxWrntyFrmDate()!=null){
				warntyFrmDate=ClsCommon.changeStringtoSqlDate(getJqxWrntyFrmDate());
			}
			if(!getJqxWrntyToDate().equalsIgnoreCase("") && getJqxWrntyToDate()!=null){
				warntyToDate=ClsCommon.changeStringtoSqlDate(getJqxWrntyToDate());
			}
			if(!getJqxLstSrvcDate().equalsIgnoreCase("") && getJqxLstSrvcDate()!=null){
				lstserDate=ClsCommon.changeStringtoSqlDate(getJqxLstSrvcDate());
			}
					
				/*System.out.println(getCmbauthority()+","+getCmbavail_br1()+","+getCmbbrand()+","+getCmbfinancer()+","+getCmbfuel()+","+getCmbgroup()+","+getCmbinsurance_type()+","
						+ ""+getCmbmodel()+","+getCmbplate()+","+getCmbveh_color()+","+getCmbyom()+","+getCmbfuel()+","+getBranded()+","+getPurchase());*/
		}
		
		if(mode.equalsIgnoreCase("A")){
			ArrayList<String> specarray= new ArrayList<>();
//			System.out.println("inside tarifsave");
			for(int i=0;i<getGridlength();i++){
				//ClsTarifBean tarifbean=new ClsTarifBean();
//				System.out.println("request =========="+request.getAttribute("test"+i));
				String temp=requestParams.get("test"+i)[0];
				
				specarray.add(temp);
//				System.out.println(specarray.get(i));
			}
//			System.out.println("%"+getPurchase()+"%"+getFormdetailcode());
			setAststatus("I");
								bean=clsVehicleDAO.insert(getFleetname(),jqxDate,getCmbauthority(),getCmbplate(),getRegno(),getCmbgroup(),getCmbbrand(),getCmbmodel(),
								getCmbyom(),getAststatus(),getOpstatus(),getSalik_tag(),getTcno(),getHiddealer(),getDeal_no(),getPurchase(),getLpo_no(),getPurchase_invoice(),
								purchDate,getPurchase_cost(),getAdditions(),getTotal(),getHidfinancier(),getInterest_amt(),getDown_payment(),getNo_installments(),regDate,
								relDate,getInstallment_amt(),getDepr_perc(),getAccu_dep(),regExpDate,getCmbinsurance_type(),getHidinsurance_comp(),getInsured_amt(),
								regotherInsDate,getPremium_perc(),getPolicy_no(),getPremium_amt(),getEngine_no(),getVin(),getChasis_no(),getCmbveh_color(),getWarranty_period(),
								warntyFrmDate,warntyToDate,getWarranty_km(),getService_km(),lstserDate,getLast_srvc_km(),getCurrent_km(),getCmbfuel(),getBranded(),getCmbavail_br1()
								,session,getFuelcapacity(),getCmbfueltype(),getFormdetailcode(),specarray,getFileno(),getInsurmember(),getTrackid(),getHidmortgaged(),getCalibrationkm());

						if(bean.getDocno()>0){
							getData(bean);
							setMode("View");
							setMsg("Successfully Saved");

							return "success";
						}
						else{
							getData(bean);
							setMsg("Not Saved");

							return "fail";
						}	
		}
		else if(mode.equalsIgnoreCase("R")){
//			System.out.println("Release Location"+getCmbrlsloc());
			java.sql.Date reldate=null;
			if(!(getReleasedate()==null)){
				reldate=ClsCommon.changeStringtoSqlDate(getReleasedate());
			}
			int val1=clsVehicleDAO.release(getReleasefleet(),getCmbrlsbranch(),getCmbrlsloc(),getCurrent_km(),getCmbfuel(),getDocno(),session,mode,getCmbrentalstatus(),reldate,getReleasetime());
			if(purchDate!=null){
				setJqxPurchaseDate(purchDate.toString());
			}
			if(jqxDate!=null){
				setJqxDate1(jqxDate.toString());
			}
			if(regDate!=null){
				setJqxFinRegDate(regDate.toString());
			}
			if(relDate!=null){
				setJqxFinRelDate(relDate.toString());
			}
			if(regExpDate!=null){
				setJqxOtherRegExp(regExpDate.toString());
			}
			if(regotherInsDate!=null){
				setJqxOtherInsExp(regotherInsDate.toString());
			}
			if(warntyFrmDate!=null){
				setJqxWrntyFrmDate(warntyFrmDate.toString());
			}
			if(warntyToDate!=null){
				setJqxWrntyToDate(warntyToDate.toString());
			}
			if(lstserDate!=null){
				setJqxLstSrvcDate(lstserDate.toString());
			}
				setFleetno(getFleetno());setFleetname(getFleetname());setHidcmbauthority(getCmbauthority());setHidcmbplate(getCmbplate());
				setRegno(getRegno());setHidcmbgroup(getCmbgroup());setHidcmbbrand(getCmbbrand());
				setHidcmbmodel(getCmbmodel());setHidcmbyom(getCmbyom());setAststatus(getAststatus());setOpstatus(getOpstatus());setSalik_tag(getSalik_tag());
				setTcno(getTcno());setDealer3(getDealer3());setDeal_no(getDeal_no());setHidpurchase(getPurchase());setLpo_no(getLpo_no());setPurchase_invoice(getPurchase_invoice());
				setPurchase_cost(getPurchase_cost());setAdditions(getAdditions());setTotal(getTotal());
				setHidcmbfinancer(getCmbfinancer());setInterest_amt(getInterest_amt());setDown_payment(getDown_payment());setNo_installments(getNo_installments());
				setInstallment_amt(getInstallment_amt());setTran_no(getTran_no());
				setDepr_perc(getDepr_perc());setAccu_dep(getAccu_dep());setAccu_dep(getAccu_dep());
				setHidcmbinsurance_type(getCmbinsurance_type());setInsurance_comp(getInsurance_comp());setInsured_amt(getInsured_amt());
				setPremium_perc(getPremium_perc());setPolicy_no(getPolicy_no());setPremium_amt(getPremium_amt());
				setEngine_no(getEngine_no());setVin(getVin());setChasis_no(getChasis_no());setHidcmbveh_color(getCmbveh_color());setWarranty_period(getWarranty_period());
				setCalibrationkm(getCalibrationkm());
				setWarranty_km(getWarranty_km());setService_km(getService_km());
				setLast_srvc_km(getLast_srvc_km());setCurrent_km(getCurrent_km());setHidcmbfuel(getCmbfuel());
				setHidbranded(getBranded());setHidcmbavail_br1(getCmbavail_br1());setDocno(getDocno());
				setDealer(getDealer());
				setHiddealer(getHiddealer());
				setFinancier(getFinancier());
				setHidfinancier(getHidfinancier());
				setInsurance_comp(getInsurance_comp());
				setHidinsurance_comp(getHidinsurance_comp());
				setHidcmbfueltype(getCmbfueltype());
				setFuelcapacity(getFuelcapacity());setAccu_dep(getAccu_dep());
				setReleasefleet(getFleetno());
				setAststatus(getAststatus());
				setOpstatus(getOpstatus());
				setFileno(getFileno());
				setInsurmember(getInsurmember());
				setTrackid(getTrackid());
				setMortgaged(getMortgaged());setHidmortgaged(getHidmortgaged());
		
			if(val1>0){
//				System.out.println(getCmbrlsloc());
				setReleasefleet(getReleasefleet());setHidcmbrlsbranch(getCmbrlsbranch());setHidcmbrlsloc(getCmbrlsloc());setMode("View");
				setHidcmbrentalstatus(getCmbrentalstatus());setAststatus("LIVE");
				setReleasedate(reldate.toString());
				setHidreleasetime(getReleasetime());
				setReleasekm(getReleasekm());
//				System.out.println("Sucessfully released");		
					
				setMsg("Successfully Released");
					return "success";
				}
				else if(val1==-1){
					
//					System.out.println(getCmbrlsloc());
					setReleasefleet(getReleasefleet());setHidcmbrlsbranch(getCmbrlsbranch());setHidcmbrlsloc(getCmbrlsloc());
					setHidcmbrentalstatus(getCmbrentalstatus());setAststatus("IN");
					setReleasedate(releasedate.toString());
					setHidreleasetime(getReleasetime());
					setReleasekm(getReleasekm());
//		System.out.println("References Present in Other Documents");
		setMsg("References Present in Other Documents");
				return "fail";
				}
				else if(val1==-2){
					
//					System.out.println(getCmbrlsloc());
					setReleasefleet(getReleasefleet());setHidcmbrlsbranch(getCmbrlsbranch());setHidcmbrlsloc(getCmbrlsloc());
					setHidcmbrentalstatus(getCmbrentalstatus());setAststatus("IN");
					setReleasedate(releasedate.toString());
					setHidreleasetime(getReleasetime());
					setReleasekm(getReleasekm());
//		System.out.println("References Present in Other Documents");
					setMsg("Reg No not set");
				return "fail";
				}
				else{
//					System.out.println(getCmbrlsloc());
					setReleasefleet(getReleasefleet());setHidcmbrlsbranch(getCmbrlsbranch());setHidcmbrlsloc(getCmbrlsloc());
					setHidcmbrentalstatus(getCmbrentalstatus());setAststatus("IN");
					setReleasedate(releasedate.toString());
					setHidreleasetime(getReleasetime());
					setReleasekm(getReleasekm());
//		System.out.println("not saved");
		setMsg("Not Saved");
				return "fail";
				}
				
				}
				
		
		else if(mode.equalsIgnoreCase("E")){
			//System.out.println("========="+getFormdetailcode());
			ArrayList<String> specarray= new ArrayList<>();
			//System.out.println("inside tarifsave");
			for(int i=0;i<getGridlength();i++){
				//ClsTarifBean tarifbean=new ClsTarifBean();
				//System.out.println("request =========="+request.getAttribute("test"+i));
				String temp=requestParams.get("test"+i)[0];
				
				specarray.add(temp);
				//System.out.println(specarray.get(i));
			}
			boolean Status=clsVehicleDAO.edit(getFleetno(),getFleetname(),jqxDate,getCmbauthority(),getCmbplate(),getRegno(),getCmbgroup(),getCmbbrand(),getCmbmodel(),
					getCmbyom(),getAststatus(),getOpstatus(),getSalik_tag(),getTcno(),getHiddealer(),getDeal_no(),getPurchase(),getLpo_no(),getPurchase_invoice(),
					purchDate,getPurchase_cost(),getAdditions(),getTotal(),getHidfinancier(),getInterest_amt(),getDown_payment(),getNo_installments(),regDate,
					relDate,getInstallment_amt(),getTran_no(),getDepr_perc(),getAccu_dep(),regExpDate,getCmbinsurance_type(),getHidinsurance_comp(),getInsured_amt(),
					regotherInsDate,getPremium_perc(),getPolicy_no(),getPremium_amt(),getEngine_no(),getVin(),getChasis_no(),getCmbveh_color(),getWarranty_period(),
					warntyFrmDate,warntyToDate,getWarranty_km(),getService_km(),lstserDate,getLast_srvc_km(),getCurrent_km(),getCmbfuel(),getBranded(),getCmbavail_br1(),
					getDocno(),session,getFuelcapacity(),getCmbfueltype(),getFormdetailcode(),specarray,getFileno(),getInsurmember(),getTrackid(),getHidmortgaged(),getCalibrationkm());
			//System.out.println(getTcno()+"actiontcno");
setCalibrationkm(getCalibrationkm());
			if(Status){
				if(purchDate!=null){
					setJqxPurchaseDate(purchDate.toString());
				}
				if(jqxDate!=null){
					setJqxDate1(jqxDate.toString());
				}
				if(regDate!=null){
					setJqxFinRegDate(regDate.toString());
				}
				if(relDate!=null){
					setJqxFinRelDate(relDate.toString());
				}
				if(regExpDate!=null){
					setJqxOtherRegExp(regExpDate.toString());
				}
				if(regotherInsDate!=null){
					setJqxOtherInsExp(regotherInsDate.toString());
				}
				if(warntyFrmDate!=null){
					setJqxWrntyFrmDate(warntyFrmDate.toString());
				}
				if(warntyToDate!=null){
					setJqxWrntyToDate(warntyToDate.toString());
				}
				if(lstserDate!=null){
					setJqxLstSrvcDate(lstserDate.toString());
				}
					setFleetno(getFleetno());setFleetname(getFleetname());setHidcmbauthority(getCmbauthority());setHidcmbplate(getCmbplate());
					setRegno(getRegno());setHidcmbgroup(getCmbgroup());setHidcmbbrand(getCmbbrand());
					setHidcmbmodel(getCmbmodel());setHidcmbyom(getCmbyom());setAststatus(getAststatus());setOpstatus(getOpstatus());setSalik_tag(getSalik_tag());
					setTcno(getTcno());setDealer3(getDealer3());setDeal_no(getDeal_no());setHidpurchase(getPurchase());setLpo_no(getLpo_no());setPurchase_invoice(getPurchase_invoice());
					setPurchase_cost(getPurchase_cost());setAdditions(getAdditions());setTotal(getTotal());
					setHidcmbfinancer(getCmbfinancer());setInterest_amt(getInterest_amt());setDown_payment(getDown_payment());setNo_installments(getNo_installments());
					setInstallment_amt(getInstallment_amt());setTran_no(getTran_no());
					setDepr_perc(getDepr_perc());setAccu_dep(getAccu_dep());setAccu_dep(getAccu_dep());
					setHidcmbinsurance_type(getCmbinsurance_type());setInsurance_comp(getInsurance_comp());setInsured_amt(getInsured_amt());
					setPremium_perc(getPremium_perc());setPolicy_no(getPolicy_no());setPremium_amt(getPremium_amt());
					setEngine_no(getEngine_no());setVin(getVin());setChasis_no(getChasis_no());setHidcmbveh_color(getCmbveh_color());setWarranty_period(getWarranty_period());
					
					setWarranty_km(getWarranty_km());setService_km(getService_km());
					setLast_srvc_km(getLast_srvc_km());setCurrent_km(getCurrent_km());setHidcmbfuel(getCmbfuel());
					setHidbranded(getBranded());setHidcmbavail_br1(getCmbavail_br1());setDocno(getDocno());
					setDealer(getDealer());
					setHiddealer(getHiddealer());
					setFinancier(getFinancier());
					setHidfinancier(getHidfinancier());
					setInsurance_comp(getInsurance_comp());
					setHidinsurance_comp(getHidinsurance_comp());
					setHidcmbfueltype(getCmbfueltype());
					setFuelcapacity(getFuelcapacity());setAccu_dep(getAccu_dep());
					setReleasefleet(getFleetno());
					setAststatus(getAststatus());
					setOpstatus(getOpstatus());
					setFileno(getFileno());
					setInsurmember(getInsurmember());
					setTrackid(getTrackid());
					setMortgaged(getMortgaged());setHidmortgaged(getHidmortgaged());
					/*setHidreleasedate(relDate.toString());
					setHidcmbrlsbranch(getCmbrlsbranch());
					setHidcmbrlsloc(getCmbrlsloc());
					setHidcmbrentalstatus(getCmbrentalstatus());
					setHidreleasetime(getReleasetime());
					setReleasekm(getReleasekm());
					setReleasefuel(getReleasefuel());*/
					setMsg("Updated Successfully");
					

				return "success";
			}
			else{
				if(purchDate!=null){
					setJqxPurchaseDate(purchDate.toString());
				}
				if(jqxDate!=null){
					setJqxDate1(jqxDate.toString());
				}
				if(regDate!=null){
					setJqxFinRegDate(regDate.toString());
				}
				if(relDate!=null){
					setJqxFinRelDate(relDate.toString());
				}
				if(regExpDate!=null){
					setJqxOtherRegExp(regExpDate.toString());
				}
				if(regotherInsDate!=null){
					setJqxOtherInsExp(regotherInsDate.toString());
				}
				if(warntyFrmDate!=null){
					setJqxWrntyFrmDate(warntyFrmDate.toString());
				}
				if(warntyToDate!=null){
					setJqxWrntyToDate(warntyToDate.toString());
				}
				if(lstserDate!=null){
					setJqxLstSrvcDate(lstserDate.toString());
				}
				setFleetno(getFleetno());setFleetname(getFleetname());setHidcmbauthority(getCmbauthority());setHidcmbplate(getCmbplate());
				setRegno(getRegno());setHidcmbgroup(getCmbgroup());setHidcmbbrand(getCmbbrand());
				setHidcmbmodel(getCmbmodel());setHidcmbyom(getCmbyom());setAststatus(getAststatus());setOpstatus(getOpstatus());setSalik_tag(getSalik_tag());
				setTcno(getTcno());setDealer3(getDealer3());setDeal_no(getDeal_no());setHidpurchase(getPurchase());setLpo_no(getLpo_no());setPurchase_invoice(getPurchase_invoice());
				setPurchase_cost(getPurchase_cost());setAdditions(getAdditions());setTotal(getTotal());
				setHidcmbfinancer(getCmbfinancer());setInterest_amt(getInterest_amt());setDown_payment(getDown_payment());setNo_installments(getNo_installments());
				setInstallment_amt(getInstallment_amt());setTran_no(getTran_no());
				setDepr_perc(getDepr_perc());setAccu_dep(getAccu_dep());setAccu_dep(getAccu_dep());
				setHidcmbinsurance_type(getCmbinsurance_type());setInsurance_comp(getInsurance_comp());setInsured_amt(getInsured_amt());
				setPremium_perc(getPremium_perc());setPolicy_no(getPolicy_no());setPremium_amt(getPremium_amt());
				setEngine_no(getEngine_no());setVin(getVin());setChasis_no(getChasis_no());setHidcmbveh_color(getCmbveh_color());setWarranty_period(getWarranty_period());
				setWarranty_km(getWarranty_km());setService_km(getService_km());
				setLast_srvc_km(getLast_srvc_km());setCurrent_km(getCurrent_km());setHidcmbfuel(getCmbfuel());
				setHidbranded(getBranded());setHidcmbavail_br1(getCmbavail_br1());setDocno(getDocno());
				setDealer(getDealer());
				setHiddealer(getHiddealer());
				setFinancier(getFinancier());
				setHidfinancier(getHidfinancier());
				setInsurance_comp(getInsurance_comp());
				setHidinsurance_comp(getHidinsurance_comp());
				setHidcmbfueltype(getCmbfueltype());
				setFuelcapacity(getFuelcapacity());setAccu_dep(getAccu_dep());setFileno(getFileno());
				setReleasefleet(getFleetno());
				setAststatus(getAststatus());
				setOpstatus(getOpstatus());	
				setReleasefleet(getFleetno());
				setInsurmember(getInsurmember());
				setTrackid(getTrackid());
				setMsg("Not Updated");
setMortgaged(getMortgaged());setHidmortgaged(getHidmortgaged());
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
					int Status=clsVehicleDAO.delete(getFleetno(),getFleetname(),jqxDate,getCmbauthority(),getCmbplate(),getRegno(),getCmbgroup(),getCmbbrand(),getCmbmodel(),
							getCmbyom(),getAststatus(),getOpstatus(),getSalik_tag(),getTcno(),getHiddealer(),getDeal_no(),getPurchase(),getLpo_no(),getPurchase_invoice(),
							purchDate,getPurchase_cost(),getAdditions(),getTotal(),getHidfinancier(),getInterest_amt(),getDown_payment(),getNo_installments(),regDate,
							relDate,getInstallment_amt(),getTran_no(),getDepr_perc(),getAccu_dep(),regExpDate,getCmbinsurance_type(),getHidinsurance_comp(),getInsured_amt(),
							regotherInsDate,getPremium_perc(),getPolicy_no(),getPremium_amt(),getEngine_no(),getVin(),getChasis_no(),getCmbveh_color(),getWarranty_period(),
							warntyFrmDate,warntyToDate,getWarranty_km(),getService_km(),lstserDate,getLast_srvc_km(),getCurrent_km(),getCmbfuel(),getBranded(),getCmbavail_br1(),
							getDocno(),session,getFuelcapacity(),getCmbfueltype(),getFormdetailcode(),getFileno(),getInsurmember(),getTrackid());
					setCalibrationkm(getCalibrationkm());
				if(Status>0){
					setFleetno(getFleetno());setFleetname(getFleetname());
					if(jqxDate!=null){
						setJqxDate1(jqxDate.toString());	
					}
					setHidcmbauthority(getCmbauthority());setHidcmbplate(getCmbplate());
					setRegno(getRegno());setHidcmbgroup(getCmbgroup());setHidcmbbrand(getCmbbrand());
					setHidcmbmodel(getCmbmodel());setHidcmbyom(getCmbyom());setAststatus(getAststatus());setOpstatus(getOpstatus());setSalik_tag(getSalik_tag());
					setTcno(getTcno());setDealer3(getDealer3());setDeal_no(getDeal_no());setHidpurchase(getPurchase());setLpo_no(getLpo_no());setPurchase_invoice(getPurchase_invoice());
					if(purchDate!=null){
						setJqxPurchaseDate(purchDate.toString());	
					}
					setPurchase_cost(getPurchase_cost());setAdditions(getAdditions());setTotal(getTotal());
					setHidcmbfinancer(getCmbfinancer());setInterest_amt(getInterest_amt());setDown_payment(getDown_payment());setNo_installments(getNo_installments());
					if(regDate!=null){
						setJqxFinRegDate(regDate.toString());	
					}
					if(relDate!=null){
						setJqxFinRelDate(relDate.toString());	
					}
					setInstallment_amt(getInstallment_amt());setTran_no(getTran_no());
					setDepr_perc(getDepr_perc());setAccu_dep(getAccu_dep());setAccu_dep(getAccu_dep());
					if(regExpDate!=null){
						setJqxOtherRegExp(regExpDate.toString());
					}
					setHidcmbinsurance_type(getCmbinsurance_type());setInsurance_comp(getInsurance_comp());setInsured_amt(getInsured_amt());
					if(regotherInsDate!=null){
						setJqxOtherInsExp(regotherInsDate.toString());
						
					}
					setPremium_perc(getPremium_perc());setPolicy_no(getPolicy_no());setPremium_amt(getPremium_amt());
					setEngine_no(getEngine_no());setVin(getVin());setChasis_no(getChasis_no());setHidcmbveh_color(getCmbveh_color());setWarranty_period(getWarranty_period());
					if(warntyFrmDate!=null){
						setJqxWrntyFrmDate(warntyFrmDate.toString());
					}
					if(warntyToDate!=null){
						setJqxWrntyToDate(warntyToDate.toString());
					}
					setWarranty_km(getWarranty_km());setService_km(getService_km());
					if(lstserDate!=null){
						setJqxLstSrvcDate(lstserDate.toString());	
					}
					setLast_srvc_km(getLast_srvc_km());setCurrent_km(getCurrent_km());setHidcmbfuel(getCmbfuel());
					setHidbranded(getBranded());setHidcmbavail_br1(getCmbavail_br1());setDocno(getDocno());
					setDealer(getDealer());
					setHiddealer(getHiddealer());
					setFinancier(getFinancier());
					setHidfinancier(getHidfinancier());
					setInsurance_comp(getInsurance_comp());
					setHidinsurance_comp(getHidinsurance_comp());
					setHidcmbfueltype(getCmbfueltype());
					setFuelcapacity(getFuelcapacity());setAccu_dep(getAccu_dep());
					setReleasefleet(getFleetno());
					setAststatus(getAststatus());
					setOpstatus(getOpstatus());setReleasefleet(getFleetno());setFileno(getFileno());setInsurmember(getInsurmember());
					setTrackid(getTrackid());
					setMortgaged(getMortgaged());setHidmortgaged(getHidmortgaged());
					setDeleted("DELETED");
					setMsg("Successfully Deleted");

					return "success";
				}
				else if(Status==-2){	setFleetno(getFleetno());setFleetname(getFleetname());
					if(jqxDate!=null){
						setJqxDate1(jqxDate.toString());	
					}
					setHidcmbauthority(getCmbauthority());setHidcmbplate(getCmbplate());
					setRegno(getRegno());setHidcmbgroup(getCmbgroup());setHidcmbbrand(getCmbbrand());
					setHidcmbmodel(getCmbmodel());setHidcmbyom(getCmbyom());setAststatus(getAststatus());setOpstatus(getOpstatus());setSalik_tag(getSalik_tag());
					setTcno(getTcno());setDealer3(getDealer3());setDeal_no(getDeal_no());setHidpurchase(getPurchase());setLpo_no(getLpo_no());setPurchase_invoice(getPurchase_invoice());
					if(purchDate!=null){
						setJqxPurchaseDate(purchDate.toString());	
					}
					setPurchase_cost(getPurchase_cost());setAdditions(getAdditions());setTotal(getTotal());
					setHidcmbfinancer(getCmbfinancer());setInterest_amt(getInterest_amt());setDown_payment(getDown_payment());setNo_installments(getNo_installments());
					if(regDate!=null){
						setJqxFinRegDate(regDate.toString());	
					}
					if(relDate!=null){
						setJqxFinRelDate(relDate.toString());	
					}
					setInstallment_amt(getInstallment_amt());setTran_no(getTran_no());
					setDepr_perc(getDepr_perc());setAccu_dep(getAccu_dep());setAccu_dep(getAccu_dep());
					if(regExpDate!=null){
						setJqxOtherRegExp(regExpDate.toString());
					}
					setHidcmbinsurance_type(getCmbinsurance_type());setInsurance_comp(getInsurance_comp());setInsured_amt(getInsured_amt());
					if(regotherInsDate!=null){
						setJqxOtherInsExp(regotherInsDate.toString());
						
					}
					setPremium_perc(getPremium_perc());setPolicy_no(getPolicy_no());setPremium_amt(getPremium_amt());
					setEngine_no(getEngine_no());setVin(getVin());setChasis_no(getChasis_no());setHidcmbveh_color(getCmbveh_color());setWarranty_period(getWarranty_period());
					if(warntyFrmDate!=null){
						setJqxWrntyFrmDate(warntyFrmDate.toString());
					}
					if(warntyToDate!=null){
						setJqxWrntyToDate(warntyToDate.toString());
					}
					setWarranty_km(getWarranty_km());setService_km(getService_km());
					if(lstserDate!=null){
						setJqxLstSrvcDate(lstserDate.toString());	
					}
					setLast_srvc_km(getLast_srvc_km());setCurrent_km(getCurrent_km());setHidcmbfuel(getCmbfuel());
					setHidbranded(getBranded());setHidcmbavail_br1(getCmbavail_br1());setDocno(getDocno());
					setDealer(getDealer());
					setHiddealer(getHiddealer());
					setFinancier(getFinancier());
					setHidfinancier(getHidfinancier());
					setInsurance_comp(getInsurance_comp());
					setHidinsurance_comp(getHidinsurance_comp());
					setHidcmbfueltype(getCmbfueltype());
					setFuelcapacity(getFuelcapacity());setAccu_dep(getAccu_dep());
					setReleasefleet(getFleetno());
					setAststatus(getAststatus());
					setOpstatus(getOpstatus());setReleasefleet(getFleetno());setFileno(getFileno());setInsurmember(getInsurmember());
					setTrackid(getTrackid());
					setMortgaged(getMortgaged());setHidmortgaged(getHidmortgaged());
					setMsg("References Present in Other Documents");
					return "fail";
				}
				else{setFleetno(getFleetno());setFleetname(getFleetname());
					if(jqxDate!=null){
						setJqxDate1(jqxDate.toString());	
					}
					setHidcmbauthority(getCmbauthority());setHidcmbplate(getCmbplate());
					setRegno(getRegno());setHidcmbgroup(getCmbgroup());setHidcmbbrand(getCmbbrand());
					setHidcmbmodel(getCmbmodel());setHidcmbyom(getCmbyom());setAststatus(getAststatus());setOpstatus(getOpstatus());setSalik_tag(getSalik_tag());
					setTcno(getTcno());setDealer3(getDealer3());setDeal_no(getDeal_no());setHidpurchase(getPurchase());setLpo_no(getLpo_no());setPurchase_invoice(getPurchase_invoice());
					if(purchDate!=null){
						setJqxPurchaseDate(purchDate.toString());	
					}
					setPurchase_cost(getPurchase_cost());setAdditions(getAdditions());setTotal(getTotal());
					setHidcmbfinancer(getCmbfinancer());setInterest_amt(getInterest_amt());setDown_payment(getDown_payment());setNo_installments(getNo_installments());
					if(regDate!=null){
						setJqxFinRegDate(regDate.toString());	
					}
					if(relDate!=null){
						setJqxFinRelDate(relDate.toString());	
					}
					setInstallment_amt(getInstallment_amt());setTran_no(getTran_no());
					setDepr_perc(getDepr_perc());setAccu_dep(getAccu_dep());setAccu_dep(getAccu_dep());
					if(regExpDate!=null){
						setJqxOtherRegExp(regExpDate.toString());
					}
					setHidcmbinsurance_type(getCmbinsurance_type());setInsurance_comp(getInsurance_comp());setInsured_amt(getInsured_amt());
					if(regotherInsDate!=null){
						setJqxOtherInsExp(regotherInsDate.toString());
						
					}
					setPremium_perc(getPremium_perc());setPolicy_no(getPolicy_no());setPremium_amt(getPremium_amt());
					setEngine_no(getEngine_no());setVin(getVin());setChasis_no(getChasis_no());setHidcmbveh_color(getCmbveh_color());setWarranty_period(getWarranty_period());
					if(warntyFrmDate!=null){
						setJqxWrntyFrmDate(warntyFrmDate.toString());
					}
					if(warntyToDate!=null){
						setJqxWrntyToDate(warntyToDate.toString());
					}
					setWarranty_km(getWarranty_km());setService_km(getService_km());
					if(lstserDate!=null){
						setJqxLstSrvcDate(lstserDate.toString());	
					}
					setLast_srvc_km(getLast_srvc_km());setCurrent_km(getCurrent_km());setHidcmbfuel(getCmbfuel());
					setHidbranded(getBranded());setHidcmbavail_br1(getCmbavail_br1());setDocno(getDocno());
					setDealer(getDealer());
					setHiddealer(getHiddealer());
					setFinancier(getFinancier());
					setHidfinancier(getHidfinancier());
					setInsurance_comp(getInsurance_comp());
					setHidinsurance_comp(getHidinsurance_comp());
					setHidcmbfueltype(getCmbfueltype());
					setFuelcapacity(getFuelcapacity());setAccu_dep(getAccu_dep());
					setReleasefleet(getFleetno());
					setAststatus(getAststatus());
					setOpstatus(getOpstatus());setReleasefleet(getFleetno());setFileno(getFileno());setInsurmember(getInsurmember());
					setTrackid(getTrackid());
					setMortgaged(getMortgaged());setHidmortgaged(getHidmortgaged());
					setMsg("Not Deleted");

					return "fail";
				}
		}
		else if(mode.equalsIgnoreCase("View")){
//			System.out.println("view===="+getFleetno());
			//ClsVehicleBean bean = new ClsVehicleBean(); 
//			System.out.println("Release Request:"+request.getParameter("fleetno"));
			/*if(request.getParameter("fleetno")!="" || request.getParameter("fleetno")!=null){
				setFleetno(Integer.parseInt(request.getParameter("fleetno")));
			}*/
					bean=clsVehicleDAO.getViewDetails(getFleetno());
//			System.out.println(bean);
					System.out.println("getErrormsg==="+bean.getErrormsg());
			setErrormsg(bean.getErrormsg());
			setCalibrationkm(bean.getCalibrationkm());	
			setHidcmbveh_color(Integer.parseInt(bean.getHidcmbveh_color()));
			setFleetno(bean.getFleetno());setFleetname(bean.getFleetname());setJqxDate1(bean.getJqxDate1());setHidcmbauthority(bean.getCmbauthority());
//			System.out.println("Authority Code:"+getHidcmbauthority());
			setHidcmbplate(bean.getCmbplate());
			setRegno(bean.getRegno());setHidcmbgroup(bean.getCmbgroup());setHidcmbbrand(bean.getCmbbrand());
			setHidcmbmodel(bean.getCmbmodel());setHidcmbyom(bean.getCmbyom());setAststatus(bean.getAststatus());setOpstatus(bean.getOpstatus());setSalik_tag(bean.getSalik_tag());
			setTcno(bean.getTcno());setDealer3(bean.getDealer3());setDeal_no(bean.getDeal_no2());setHidpurchase(bean.getPurchase());setLpo_no(bean.getLpo_no());
			setPurchase_invoice(bean.getPurchase_invoice());
			setJqxPurchaseDate(bean.getJqxPurchaseDate());setPurchase_cost(bean.getPurchase_cost());setAdditions(bean.getAdditions());setTotal(bean.getTotal());
			setHidcmbfinancer(bean.getCmbfinancer());setInterest_amt(bean.getInterest_amt());setDown_payment(bean.getDown_payment());setNo_installments(bean.getNo_installments());
			setJqxFinRegDate(bean.getJqxFinRegDate());setJqxFinRelDate(bean.getJqxFinRelDate());setInstallment_amt(bean.getInstallment_amt());setTran_no(bean.getTran_no());
			setDepr_perc(bean.getDepr_perc());setAccu_dep(bean.getAccu_dep());setAccu_dep(bean.getAccu_dep());setJqxOtherRegExp(bean.getJqxOtherRegExp());
			setHidcmbinsurance_type(bean.getCmbinsurance_type());
//			System.out.println("Insur Type:"+getHidcmbinsurance_type());
			setInsurance_comp(bean.getInsurance_comp());setInsured_amt(bean.getInsured_amt());
			setJqxOtherInsExp(bean.getJqxOtherInsExp());setPremium_perc(bean.getPremium_perc()); setPolicy_no(bean.getPolicy_no());setPremium_amt(bean.getPremium_amt());
			setEngine_no(bean.getEngine_no());setVin(bean.getVin());setChasis_no(bean.getChasis_no());setHidcmbveh_color(bean.getCmbveh_color());setWarranty_period(bean.getWarranty_period());
			setJqxWrntyFrmDate(bean.getJqxWrntyFrmDate());setJqxWrntyToDate(bean.getJqxWrntyToDate());setWarranty_km(bean.getWarranty_km());setService_km(bean.getService_km());
			setJqxLstSrvcDate(bean.getJqxLstSrvcDate());setLast_srvc_km(bean.getLast_srvc_km());setCurrent_km(bean.getCurrent_km());setHidcmbfuel(bean.getCmbfuel());
			setHidbranded(bean.getBranded());setHidcmbavail_br1(bean.getCmbavail_br1());setDocno(bean.getDocno());setReleasefleet(bean.getReleasefleet());
			setDealer(bean.getDealer());setHidcmbrlsbranch(bean.getHidcmbrlsbranch());setHidcmbrlsloc(bean.getHidcmbrlsloc());
			setHiddealer(bean.getHiddealer());setReleasedate(bean.getHidreleasedate());setJqxFinRegDate(bean.getJqxFinRegDate());
			setAccu_dep(bean.getAccu_dep());
			setFinancier(bean.getFinancier());
			setHidfinancier(bean.getHidfinancier());
			setInsurance_comp(bean.getInsurance_comp());
			setHidcmbfueltype(bean.getHidcmbfueltype());
			setFuelcapacity(bean.getFuelcapacity());
			setHidinsurance_comp(bean.getHidinsurance_comp());
			setHidreleasetime(bean.getHidreleasetime());
			setReleasekm(bean.getReleasekm());
			setReleasefuel(bean.getReleasefuel());
			setFileno(bean.getFileno());
			setInsurmember(bean.getInsurmember());
			setTrackid(bean.getTrackid());
			setMortgaged(bean.getMortgaged());setHidmortgaged(bean.getHidmortgaged());
			setCmbrentalstatus(bean.getCmbrentalstatus());
			setHidcmbrentalstatus(bean.getCmbrentalstatus());
//			System.out.println(getDocno());
//			System.out.println(bean.getDocno());
//			System.out.println(getHidpurchase());
//			System.out.println(bean.getAststatus());
//			System.out.println(getAststatus());
//			System.out.println(bean.getPurchase());
//	System.out.println("sucess");
			
		}	
		
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
		
	
	
	

	public  JSONArray searchDetails(){
		  JSONArray cellarray = new JSONArray();
		  		  JSONObject cellobj = null;
		  try {
			  cellarray= clsVehicleDAO.list();
//			  System.out.println("cellobj"+cellarray);  
		  } catch (SQLException e) {
		  }
		return cellarray;
	}

	public String vehicleGrid() throws ParseException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		
//		System.out.println(getFleetno());
		JSONArray cellarray = new JSONArray();
		  		  JSONObject cellobj = null;
//			  System.out.println("inside vehicle grid"+getFleetname());
		return "fail";
	}

	
	
}

