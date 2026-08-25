package com.controlcentre.masters.vehiclemaster.authority;
import java.util.*;
public class ClsAuthorityBean {

private int docno;
private Date authdate;
private String auth;
private String authname;
private Date authdatehidden;

public Date getAuthdatehidden() {
	return authdatehidden;
}
public void setAuthdatehidden(Date authdatehidden) {
	this.authdatehidden = authdatehidden;
}
public int getDocno() {
	return docno;
}
public Date getAuthdate() {
	return authdate;
}
public void setAuthdate(Date authdate) {
	this.authdate = authdate;
}
public void setDocno(int docno) {
	this.docno = docno;
}

public String getAuth() {
	return auth;
}
public void setAuth(String auth) {
	this.auth = auth;
}
public String getAuthname() {
	return authname;
}
public void setAuthname(String authname) {
	this.authname = authname;
}

}
