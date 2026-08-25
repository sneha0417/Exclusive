package com.controlcentre.masters.supplier;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;

import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;

public class ClsSupplierBean {
	
	private String supplierDate;
	private String hidSupplierDate;
	private String txtcode;
	private String txtsupplier_name;
	private String docno;
	private int currencyid;
	private int hidcmbcurrencyid;
	private String cmbgroup;
	private String hidcmbgroup;
	private int cmbcategory;
	private int hidcmbcategory;
	private String cmbsalesman;
	private String hidcmbsalesman;
	private int cmbsalesmanid;
	private int hidcmbsalesmanid;
	private int cmbacgroup;
	private int hidcmbacgroup;
	private String txtaccount;
	private String txttinno;
	private String txtcstno;
	private Double txtcredit_period_min=0.0;
	private Double txtcredit_period_max=0.0;
	private Double txtcredit_limit=0.0;
	private String txtaddress;
	private String txtextnno;
	private String txttelephone;
	private String txtmobile;
	private String txtfax;
	private String txtemail;
	private String txtweb;
	private String txtcontact;
	private String txtarea;
	private String txtareadet;
	private int txtareaid;
	private String txtaccountno;
	private String txtbankname;
	private String txtbranchname;
	private String txtbranchaddress;
	private String txtswiftno;
	private String txtibanno;
	private String txtcity;
	private String txtcountry;
	private int cpgridlength;
	private String mode;
	private String msg;
	private int countryid;
	
	
	
	
	
	public String getDocno() {
		return docno;
	}
	public void setDocno(String docno) {
		this.docno = docno;
	}
	public String getSupplierDate() {
		return supplierDate;
	}
	public void setSupplierDate(String supplierDate) {
		this.supplierDate = supplierDate;
	}
	public String getHidSupplierDate() {
		return hidSupplierDate;
	}
	public void setHidSupplierDate(String hidSupplierDate) {
		this.hidSupplierDate = hidSupplierDate;
	}
	public String getTxtcode() {
		return txtcode;
	}
	public void setTxtcode(String txtcode) {
		this.txtcode = txtcode;
	}
	public String getTxtsupplier_name() {
		return txtsupplier_name;
	}
	public void setTxtsupplier_name(String txtsupplier_name) {
		this.txtsupplier_name = txtsupplier_name;
	}
	
	
	public int getHidcmbcurrencyid() {
		return hidcmbcurrencyid;
	}
	public void setHidcmbcurrencyid(int hidcmbcurrencyid) {
		this.hidcmbcurrencyid = hidcmbcurrencyid;
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
	public int getCmbcategory() {
		return cmbcategory;
	}
	public void setCmbcategory(int cmbcategory) {
		this.cmbcategory = cmbcategory;
	}
	public int getHidcmbcategory() {
		return hidcmbcategory;
	}
	public void setHidcmbcategory(int hidcmbcategory) {
		this.hidcmbcategory = hidcmbcategory;
	}
	public String getCmbsalesman() {
		return cmbsalesman;
	}
	public void setCmbsalesman(String cmbsalesman) {
		this.cmbsalesman = cmbsalesman;
	}
	public String getHidcmbsalesman() {
		return hidcmbsalesman;
	}
	public void setHidcmbsalesman(String hidcmbsalesman) {
		this.hidcmbsalesman = hidcmbsalesman;
	}
	public int getCmbsalesmanid() {
		return cmbsalesmanid;
	}
	public void setCmbsalesmanid(int cmbsalesmanid) {
		this.cmbsalesmanid = cmbsalesmanid;
	}
	public int getHidcmbsalesmanid() {
		return hidcmbsalesmanid;
	}
	public void setHidcmbsalesmanid(int hidcmbsalesmanid) {
		this.hidcmbsalesmanid = hidcmbsalesmanid;
	}
	public int getCmbacgroup() {
		return cmbacgroup;
	}
	public void setCmbacgroup(int cmbacgroup) {
		this.cmbacgroup = cmbacgroup;
	}
	public int getHidcmbacgroup() {
		return hidcmbacgroup;
	}
	public void setHidcmbacgroup(int hidcmbacgroup) {
		this.hidcmbacgroup = hidcmbacgroup;
	}
	public String getTxtaccount() {
		return txtaccount;
	}
	public void setTxtaccount(String txtaccount) {
		this.txtaccount = txtaccount;
	}
	public String getTxttinno() {
		return txttinno;
	}
	public void setTxttinno(String txttinno) {
		this.txttinno = txttinno;
	}
	public String getTxtcstno() {
		return txtcstno;
	}
	public void setTxtcstno(String txtcstno) {
		this.txtcstno = txtcstno;
	}
	public Double getTxtcredit_period_min() {
		return txtcredit_period_min;
	}
	public void setTxtcredit_period_min(Double txtcredit_period_min) {
		this.txtcredit_period_min = txtcredit_period_min;
	}
	public Double getTxtcredit_period_max() {
		return txtcredit_period_max;
	}
	public void setTxtcredit_period_max(Double txtcredit_period_max) {
		this.txtcredit_period_max = txtcredit_period_max;
	}
	public Double getTxtcredit_limit() {
		return txtcredit_limit;
	}
	public void setTxtcredit_limit(Double txtcredit_limit) {
		this.txtcredit_limit = txtcredit_limit;
	}
	public String getTxtaddress() {
		return txtaddress;
	}
	public void setTxtaddress(String txtaddress) {
		this.txtaddress = txtaddress;
	}
	public String getTxtextnno() {
		return txtextnno;
	}
	public void setTxtextnno(String txtextnno) {
		this.txtextnno = txtextnno;
	}
	public String getTxttelephone() {
		return txttelephone;
	}
	public void setTxttelephone(String txttelephone) {
		this.txttelephone = txttelephone;
	}
	public String getTxtmobile() {
		return txtmobile;
	}
	public void setTxtmobile(String txtmobile) {
		this.txtmobile = txtmobile;
	}
	public String getTxtfax() {
		return txtfax;
	}
	public void setTxtfax(String txtfax) {
		this.txtfax = txtfax;
	}
	public String getTxtemail() {
		return txtemail;
	}
	public void setTxtemail(String txtemail) {
		this.txtemail = txtemail;
	}
	public String getTxtweb() {
		return txtweb;
	}
	public void setTxtweb(String txtweb) {
		this.txtweb = txtweb;
	}
	public String getTxtcontact() {
		return txtcontact;
	}
	public void setTxtcontact(String txtcontact) {
		this.txtcontact = txtcontact;
	}
	public String getTxtarea() {
		return txtarea;
	}
	public void setTxtarea(String txtarea) {
		this.txtarea = txtarea;
	}
	public String getTxtareadet() {
		return txtareadet;
	}
	public void setTxtareadet(String txtareadet) {
		this.txtareadet = txtareadet;
	}
	public int getTxtareaid() {
		return txtareaid;
	}
	public void setTxtareaid(int txtareaid) {
		this.txtareaid = txtareaid;
	}
	public String getTxtaccountno() {
		return txtaccountno;
	}
	public void setTxtaccountno(String txtaccountno) {
		this.txtaccountno = txtaccountno;
	}
	public String getTxtbankname() {
		return txtbankname;
	}
	public void setTxtbankname(String txtbankname) {
		this.txtbankname = txtbankname;
	}
	public String getTxtbranchname() {
		return txtbranchname;
	}
	public void setTxtbranchname(String txtbranchname) {
		this.txtbranchname = txtbranchname;
	}
	public String getTxtbranchaddress() {
		return txtbranchaddress;
	}
	public void setTxtbranchaddress(String txtbranchaddress) {
		this.txtbranchaddress = txtbranchaddress;
	}
	public String getTxtswiftno() {
		return txtswiftno;
	}
	public void setTxtswiftno(String txtswiftno) {
		this.txtswiftno = txtswiftno;
	}
	public String getTxtibanno() {
		return txtibanno;
	}
	public void setTxtibanno(String txtibanno) {
		this.txtibanno = txtibanno;
	}
	public String getTxtcity() {
		return txtcity;
	}
	public void setTxtcity(String txtcity) {
		this.txtcity = txtcity;
	}
	public String getTxtcountry() {
		return txtcountry;
	}
	public void setTxtcountry(String txtcountry) {
		this.txtcountry = txtcountry;
	}
	public int getCpgridlength() {
		return cpgridlength;
	}
	public void setCpgridlength(int cpgridlength) {
		this.cpgridlength = cpgridlength;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public int getCountryid() {
		return countryid;
	}
	public void setCountryid(int countryid) {
		this.countryid = countryid;
	}
	public int getCurrencyid() {
		return currencyid;
	}
	public void setCurrencyid(int currencyid) {
		this.currencyid = currencyid;
	}

	
	
	

}
