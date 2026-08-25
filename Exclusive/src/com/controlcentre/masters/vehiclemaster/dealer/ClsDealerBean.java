package com.controlcentre.masters.vehiclemaster.dealer;
import java.util.*;
public class ClsDealerBean {
private int docno;
private Date dealerdate;
private String dealerid;
private String dealername;
private String accno;
private int txtaccno;
private String mode;
private Date dealerdatehidden;
private String delete;
private String txtaccname;

public String getTxtaccname() {
	return txtaccname;
}
public void setTxtaccname(String txtaccname) {
	this.txtaccname = txtaccname;
}
public int getDocno() {
	return docno;
}
public void setDocno(int docno) {
	this.docno = docno;
}
public int getTxtaccno() {
	return txtaccno;
}
public void setTxtaccno(int txtaccno) {
	this.txtaccno = txtaccno;
}
public Date getDealerdate() {
	return dealerdate;
}
public void setDealerdate(Date dealerdate) {
	this.dealerdate = dealerdate;
}
public String getDealerid() {
	return dealerid;
}
public Date getDealerdatehidden() {
	return dealerdatehidden;
}
public void setDealerdatehidden(Date dealerdatehidden) {
	this.dealerdatehidden = dealerdatehidden;
}
public void setDealerid(String dealerid) {
	this.dealerid = dealerid;
}
public String getDealername() {
	return dealername;
}
public void setDealername(String dealername) {
	this.dealername = dealername;
}
public String getAccno() {
	return accno;
}
public void setAccno(String accno) {
	this.accno = accno;
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

}
