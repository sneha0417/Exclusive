package com.controlcentre.masters.vehiclemaster.group;
import java.util.*;
public class ClsGroupBean {
private int docno;
private String group;
private String name;
private String utype;
private int level;
private String mode;
private String delete;
private String groupdatehidden;
private String utypehidden;
public String getUtypehidden() {
	return utypehidden;
}
public void setUtypehidden(String utypehidden) {
	this.utypehidden = utypehidden;
}
private Date groupdate;
public int getDocno() {
	return docno;
}
public void setDocno(int docno) {
	this.docno = docno;
}
public String getGroup() {
	return group;
}
public void setGroup(String group) {
	this.group = group;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getUtype() {
	return utype;
}
public void setUtype(String utype) {
	this.utype = utype;
}
public int getLevel() {
	return level;
}
public void setLevel(int level) {
	this.level = level;
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
public String getGroupdatehidden() {
	return groupdatehidden;
}
public void setGroupdatehidden(String groupdatehidden) {
	this.groupdatehidden = groupdatehidden;
}
public Date getGroupdate() {
	return groupdate;
}
public void setGroupdate(Date groupdate) {
	this.groupdate = groupdate;
}


}
