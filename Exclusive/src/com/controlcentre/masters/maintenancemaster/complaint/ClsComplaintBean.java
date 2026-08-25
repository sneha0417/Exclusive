package com.controlcentre.masters.maintenancemaster.complaint;

import java.util.*;

public class ClsComplaintBean {

	private int docno;
	private Date prevdate;
	private Date prevdatehidden;
	private String maintenanceid;
	private String maintenancetype;
	private String mode;
	private String delete;
	private double lbrchg;

	public double getLbrchg() {
		return lbrchg;
	}
	public void setLbrchg(double lbrchg) {
		this.lbrchg = lbrchg;
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
	public Date getPrevdate() {
		return prevdate;
	}
	public void setPrevdate(Date prevdate) {
		this.prevdate = prevdate;
	}
	public Date getPrevdatehidden() {
		return prevdatehidden;
	}
	public void setPrevdatehidden(Date prevdatehidden) {
		this.prevdatehidden = prevdatehidden;
	}
	public String getMaintenanceid() {
		return maintenanceid;
	}
	public void setMaintenanceid(String maintenanceid) {
		this.maintenanceid = maintenanceid;
	}
	public String getMaintenancetype() {
		return maintenancetype;
	}
	public void setMaintenancetype(String maintenancetype) {
		this.maintenancetype = maintenancetype;
	}

}
