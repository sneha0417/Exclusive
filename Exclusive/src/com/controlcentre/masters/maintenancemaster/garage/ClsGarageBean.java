package com.controlcentre.masters.maintenancemaster.garage;

import java.util.*;

public class ClsGarageBean {

	private int docno;
	private String mode;
	private String delete;
	private Date garagedate;
	private Date hidgaragedate;
	private String type;
	private String hidtype;
	private String txtaccname;
	private int txtaccno;
	private String location;
	private String hidlocation;
	private String garagecode;
	private String garagename;
	
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
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
	public Date getGaragedate() {
		return garagedate;
	}
	public void setGaragedate(Date garagedate) {
		this.garagedate = garagedate;
	}
	public Date getHidgaragedate() {
		return hidgaragedate;
	}
	public void setHidgaragedate(Date hidgaragedate) {
		this.hidgaragedate = hidgaragedate;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getHidtype() {
		return hidtype;
	}
	public void setHidtype(String hidtype) {
		this.hidtype = hidtype;
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
	public void setTxtaccno(int txtaccno) {
		this.txtaccno = txtaccno;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getHidlocation() {
		return hidlocation;
	}
	public void setHidlocation(String hidlocation) {
		this.hidlocation = hidlocation;
	}
	public String getGaragecode() {
		return garagecode;
	}
	public void setGaragecode(String garagecode) {
		this.garagecode = garagecode;
	}
	public String getGaragename() {
		return garagename;
	}
	public void setGaragename(String garagename) {
		this.garagename = garagename;
	}

}
