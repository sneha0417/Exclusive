package com.controlcentre.masters.vehiclemaster.specification;
import java.util.*;
public class ClsSpecificationBean {
private int docno;
private String specname;
private String specdetails;
private String mode;
private String delete;


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
public String getSpecname() {
	return specname;
}
public void setSpecname(String specname) {
	this.specname = specname;
}
public String getSpecdetails() {
	return specdetails;
}
public void setSpecdetails(String specdetails) {
	this.specdetails = specdetails;
}

}
