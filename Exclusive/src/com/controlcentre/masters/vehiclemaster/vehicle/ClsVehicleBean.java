package com.controlcentre.masters.vehiclemaster.vehicle;

import java.util.*;

public class ClsVehicleBean {
	private String hidcmbveh_color;
	private int fleetno;
	private String fleetname;
	private String jqxDate1;
	private int docno;
	private String cmbauthority;
	private String cmbplate;
	private String regno;
	private String cmbgroup;
	private String group_name;

	private String cmbbrand;
	private String cmbmodel;
	private String cmbyom;
	private String aststatus;
	private String opstatus;
	private String salik_tag;
	private String tcno;
	private String mode;
		private String mortgaged;
	private String hidmortgaged;
	private String errormsg;
	
	public String getErrormsg() {
		return errormsg;
	}

	public void setErrormsg(String errormsg) {
		this.errormsg = errormsg;
	}
	
	public String getHidcmbveh_color() {
		return hidcmbveh_color;
	}

	public void setHidcmbveh_color(String hidcmbveh_color) {
		this.hidcmbveh_color = hidcmbveh_color;
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
private String fileno;
public String getFileno() {
	return fileno;
}
public void setFileno(String fileno) {
	this.fileno = fileno;
}
	//puechase info
	private String dealer;
	private int hiddealer;
	
	private String dealer3;
	private String dealer4;
	private String deal_no2;
	private String purchase;
	private int lpo_no;
	private String purchase_invoice;
	private String jqxPurchaseDate;
	private double purchase_cost;
	private double additions;
	private double total;

	//-------Finance Info--------
	private int cmbfinancer;
	private double interest_amt;
	private double down_payment;
	private int no_installments;
	private String jqxFinRegDate;
	private String jqxFinRelDate;
	private double installment_amt;
	private int tran_no;
	private double depr_perc;
	private String accu_dep;
	private String financier;
	private int hidfinancier;

	//Other Info
	private String jqxOtherRegExp;
	private String cmbinsurance_type;
	private String insurance_comp;
	private int hidinsurance_comp;
	private double insured_amt;
	private String jqxOtherInsExp;
	private double premium_perc;
	private String policy_no;
	private double premium_amt;
	private String insurmember;
	private String trackid;


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
	//Vehicle Info
	private String engine_no;
	private String vin;
	private String chasis_no;
	private int cmbveh_color;

	//Warranty Info
	private int warranty_period;
	private String jqxWrntyFrmDate;
	private String jqxWrntyToDate;
	private double warranty_km;


	//service INfo
		private double service_km;
		private String jqxLstSrvcDate;
		private double last_srvc_km;


		//Release Info
		private int current_km;
		private String cmbfuel;
		private String branded;
		private String cmbavail_br1;
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
	public String getCmbplate() {
		return cmbplate;
	}
	public void setCmbplate(String cmbplate) {
		this.cmbplate = cmbplate;
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
	public String getCmbmodel() {
		return cmbmodel;
	}
	public void setCmbmodel(String cmbmodel) {
		this.cmbmodel = cmbmodel;
	}
	public String getCmbyom() {
		return cmbyom;
	}
	public void setCmbyom(String cmbyom) {
		this.cmbyom = cmbyom;
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
	public String getDeal_no2() {
		return deal_no2;
	}
	public void setDeal_no2(String deal_no2) {
		this.deal_no2 = deal_no2;
	}
	public String getPurchase() {
		return purchase;
	}
	public void setPurchase(String purchase) {
		this.purchase = purchase;
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
	public String getJqxFinRelDate() {
		return jqxFinRelDate;
	}
	public void setJqxFinRelDate(String jqxFinRelDate) {
		this.jqxFinRelDate = jqxFinRelDate;
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
	public String getCmbinsurance_type() {
		return cmbinsurance_type;
	}
	public void setCmbinsurance_type(String cmbinsurance_type) {
		this.cmbinsurance_type = cmbinsurance_type;
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
	public String getJqxWrntyToDate() {
		return jqxWrntyToDate;
	}
	public void setJqxWrntyToDate(String jqxWrntyToDate) {
		this.jqxWrntyToDate = jqxWrntyToDate;
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
		

		private String calibrationkm;



public String getCalibrationkm() {
	return calibrationkm;
}

public void setCalibrationkm(String calibrationkm) {
	this.calibrationkm = calibrationkm;
}

	
	}
