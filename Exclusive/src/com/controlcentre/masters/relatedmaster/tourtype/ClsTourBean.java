package com.controlcentre.masters.relatedmaster.tourtype;
import java.util.*;
public class ClsTourBean {


private int docno,childmin,childmax,agemin,agemax,chkprivate;
public int getChkprivate() {
	return chkprivate;
}  
public void setChkprivate(int chkprivate) {
	this.chkprivate = chkprivate;
}
private String delete,hghtmin,hghtmax,wghtmin,wghtmax,desc;
private String servicedate;
private String code;
private String name;

public int getChildmin() {
	return childmin;
}
public void setChildmin(int childmin) {
	this.childmin = childmin;
}
public int getChildmax() {
	return childmax;
}
public void setChildmax(int childmax) {
	this.childmax = childmax;
}
public int getAgemin() {
	return agemin;
}
public void setAgemin(int agemin) {
	this.agemin = agemin;
}
public int getAgemax() {
	return agemax;
}
public void setAgemax(int agemax) {
	this.agemax = agemax;
}
public String getHghtmin() {
	return hghtmin;
}
public void setHghtmin(String hghtmin) {
	this.hghtmin = hghtmin;
}
public String getHghtmax() {
	return hghtmax;
}
public void setHghtmax(String hghtmax) {
	this.hghtmax = hghtmax;
}
public String getWghtmin() {
	return wghtmin;
}
public void setWghtmin(String wghtmin) {
	this.wghtmin = wghtmin;
}
public String getWghtmax() {
	return wghtmax;
}
public void setWghtmax(String wghtmax) {
	this.wghtmax = wghtmax;
}
private String hidservicedate;
private String mode;



public int getDocno() {
	return docno;
}
public void setDocno(int docno) {
	this.docno = docno;
}
public String getServicedate() {
	return servicedate;
}
public void setServicedate(String servicedate) {
	this.servicedate = servicedate;
}
public String getCode() {
	return code;
}
public void setCode(String code) {
	this.code = code;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getHidservicedate() {
	return hidservicedate;
}
public void setHidservicedate(String hidservicedate) {
	this.hidservicedate = hidservicedate;
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
public String getDesc() {
	return desc;
}
public void setDesc(String desc) {
	this.desc = desc;
}




}