package com.controlcentre.masters.vehiclemaster.financier;
import java.util.*;
public class ClsFinancierBean {
private String finid;
private String finname;
private String accno;
private String mode;
private String delete;
private Date findate;
private int docno;
private int txtaccno;
private String txtaccname;


public void setTxtaccno(int txtaccno) {
	this.txtaccno = txtaccno;
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

public int getDocno() {
	return docno;
}
public void setDocno(int docno) {
	this.docno = docno;
}
public String getFinid() {
	return finid;
}
public void setFinid(String finid) {
	this.finid = finid;
}
public String getFinname() {
	return finname;
}
public void setFinname(String finname) {
	this.finname = finname;
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
public Date getFindate() {
	return findate;
}
public void setFindate(Date findate) {
	this.findate = findate;
}

}
