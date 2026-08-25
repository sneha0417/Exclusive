package com.operations.marketing.enquirynew;

import java.util.*;

public class ClsEnquiryBean {

	private String BRAND;
	private String VTYPE;
	private String SPEC;
	private String COLOR;
	private String RTYPE;
	private Date FRM_CONTR;
	private Date TO_CONTR;
	private int UNIT;
	private String hidradio;
	private int siteGridlength;
	private int chksurvey;
	private int hidsurvey;
	private String sal_id,sal_name;
	
	 public String getSal_id() {
		return sal_id;
	}
	public void setSal_id(String sal_id) {
		this.sal_id = sal_id;
	}
	public String getSal_name() {
		return sal_name;
	}
	public void setSal_name(String sal_name) {
		this.sal_name = sal_name;
	}
	public int getHidsurvey() {
		return hidsurvey;
	}
	public void setHidsurvey(int hidsurvey) {
		this.hidsurvey = hidsurvey;
	}
	public int getChksurvey() {
		return chksurvey;
	}
	public void setChksurvey(int chksurvey) {
		this.chksurvey = chksurvey;
	}
	public int getSiteGridlength() {
			return siteGridlength;
		}
		public void setSiteGridlength(int siteGridlength) {
			this.siteGridlength = siteGridlength;
		}
	

	public String getHidradio() {
		return hidradio;
	}
	public void setHidradio(String hidradio) {
		this.hidradio = hidradio;
	}
	public String getBRAND() {
		return BRAND;
	}
	public void setBRAND(String bRAND) {
		BRAND = bRAND;
	}
	public String getVTYPE() {
		return VTYPE;
	}
	public void setVTYPE(String vTYPE) {
		VTYPE = vTYPE;
	}
	public String getSPEC() {
		return SPEC;
	}
	public void setSPEC(String sPEC) {
		SPEC = sPEC;
	}
	public String getCOLOR() {
		return COLOR;
	}
	public void setCOLOR(String cOLOR) {
		COLOR = cOLOR;
	}
	public String getRTYPE() {
		return RTYPE;
	}
	public void setRTYPE(String rTYPE) {
		RTYPE = rTYPE;
	}
	public Date getFRM_CONTR() {
		return FRM_CONTR;
	}
	public void setFRM_CONTR(Date fRM_CONTR) {
		FRM_CONTR = fRM_CONTR;
	}
	public Date getTO_CONTR() {
		return TO_CONTR;
	}
	public void setTO_CONTR(Date tO_CONTR) {
		TO_CONTR = tO_CONTR;
	}
	public int getUNIT() {
		return UNIT;
	}
	public void setUNIT(int uNIT) {
		UNIT = uNIT;
	}	
	private String rentaltype;

	public String getRentaltype() {
		return rentaltype;
	}
	public void setRentaltype(String rentaltype) {
		this.rentaltype = rentaltype;
	}





	//----------------------------------------------------------




	private String lblclient,lblclientaddress,lblmob,lblemail,lbldate,lbltypep,lblsalesman;



	private int docvals;

	private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation;	
	private String lblcstno,lblservicetax,lblpan;


	//------------------------------------------------------------------------------
	 private int cmbprocess;
	 
	 private int hidcmbprocess;


		public int getHidcmbprocess() {
		return hidcmbprocess;
	}
	public void setHidcmbprocess(int hidcmbprocess) {
		this.hidcmbprocess = hidcmbprocess;
	}
		public int getCmbprocess() {
		return cmbprocess;
	}
	public void setCmbprocess(int cmbprocess) {
		this.cmbprocess = cmbprocess;
	}
	public String getLblclient() {
		return lblclient;
	}
	public void setLblclient(String lblclient) {           
		this.lblclient = lblclient;
	}
	public String getLblclientaddress() {
		return lblclientaddress;
	}
	public void setLblclientaddress(String lblclientaddress) {
		this.lblclientaddress = lblclientaddress;
	}
	public String getLblmob() {
		return lblmob;
	}
	public void setLblmob(String lblmob) {
		this.lblmob = lblmob;
	}
	public String getLblemail() {
		return lblemail;
	}
	public void setLblemail(String lblemail) {
		this.lblemail = lblemail;
	}
	public String getLblsalesman() {
			return lblsalesman;
		}
		public void setLblsalesman(String lblsalesman) {
			this.lblsalesman = lblsalesman;
		}
	public String getLbldate() {
		return lbldate;
	}
	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}
	public String getLbltypep() {
		return lbltypep;
	}
	public void setLbltypep(String lbltypep) {
		this.lbltypep = lbltypep;
	}
	public int getDocvals() {
		return docvals;
	}
	public void setDocvals(int docvals) {
		this.docvals = docvals;
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
	public String getLblbranch() {
		return lblbranch;
	}
	public void setLblbranch(String lblbranch) {
		this.lblbranch = lblbranch;
	}
	public String getLblcstno() {
		return lblcstno;
	}
	public void setLblcstno(String lblcstno) {
		this.lblcstno = lblcstno;
	}
	public String getLblservicetax() {
		return lblservicetax;
	}
	public void setLblservicetax(String lblservicetax) {
		this.lblservicetax = lblservicetax;
	}
	public String getLblpan() {
		return lblpan;
	}
	public void setLblpan(String lblpan) {
		this.lblpan = lblpan;
	}
	public String getLbllocation() {
		return lbllocation;
	}
	public void  setLbllocation(String lbllocation) {
		this.lbllocation = lbllocation;
	}










}