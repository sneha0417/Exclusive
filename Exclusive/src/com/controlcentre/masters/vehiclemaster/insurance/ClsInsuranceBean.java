package com.controlcentre.masters.vehiclemaster.insurance;
import java.util.*;
public class ClsInsuranceBean {
private int docno;
private Date insurdate;
private Date insurvalidfrom;
private Date insurvalidto;
private String insurcompany;
private String utype;
private String insurtype;
private String policyno;
private double premium;
private double exchg;
private String mode;
private String delete;
private Date insurdatehidden;
private Date insurvalidfromhidden;
private Date insurvalidtohidden;
private String hidutype;
private String hidinsurtype;
private String txtaccname;
private int txtaccno;


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
public String getHidutype() {
	return hidutype;
}
public void setHidutype(String hidutype) {
	this.hidutype = hidutype;
}
public String getHidinsurtype() {
	return hidinsurtype;
}
public void setHidinsurtype(String hidinsurtype) {
	this.hidinsurtype = hidinsurtype;
}
public Date getInsurdatehidden() {
	return insurdatehidden;
}
public void setInsurdatehidden(Date insurdatehidden) {
	this.insurdatehidden = insurdatehidden;
}
public Date getInsurvalidfromhidden() {
	return insurvalidfromhidden;
}
public void setInsurvalidfromhidden(Date insurvalidfromhidden) {
	this.insurvalidfromhidden = insurvalidfromhidden;
}
public Date getInsurvalidtohidden() {
	return insurvalidtohidden;
}
public void setInsurvalidtohidden(Date insurvalidtohidden) {
	this.insurvalidtohidden = insurvalidtohidden;
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
public int getDocno() {
	return docno;
}
public void setDocno(int docno) {
	this.docno = docno;
}
public Date getInsurdate() {
	return insurdate;
}
public void setInsurdate(Date insurdate) {
	this.insurdate = insurdate;
}
public Date getInsurvalidfrom() {
	return insurvalidfrom;
}
public void setInsurvalidfrom(Date insurvalidfrom) {
	this.insurvalidfrom = insurvalidfrom;
}
public Date getInsurvalidto() {
	return insurvalidto;
}
public void setInsurvalidto(Date insurvalidto) {
	this.insurvalidto = insurvalidto;
}
public String getInsurcompany() {
	return insurcompany;
}
public void setInsurcompany(String insurcompany) {
	this.insurcompany = insurcompany;
}
public String getUtype() {
	return utype;
}
public void setUtype(String utype) {
	this.utype = utype;
}
public String getInsurtype() {
	return insurtype;
}
public void setInsurtype(String insurtype) {
	this.insurtype = insurtype;
}
public String getPolicyno() {
	return policyno;
}
public void setPolicyno(String policyno) {
	this.policyno = policyno;
}
public double getPremium() {
	return premium;
}
public void setPremium(double premium) {
	this.premium = premium;
}
public double getExchg() {
	return exchg;
}
public void setExchg(double exchg) {
	this.exchg = exchg;
}

}
