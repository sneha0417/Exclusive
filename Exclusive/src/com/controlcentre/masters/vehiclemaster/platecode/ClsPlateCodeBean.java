package com.controlcentre.masters.vehiclemaster.platecode;

import java.util.*;

public class ClsPlateCodeBean {
	
	 private String authName;
	 private Date date_plateCode;
	 private int docno;
	 private String plateCode;
	 private String platename;
	 private String authId;
	public String getAuthName() {
		return authName;
	}
	public void setAuthName(String authName) {
		this.authName = authName;
	}
	public Date getDate_plateCode() {
		return date_plateCode;
	}
	public void setDate_plateCode(Date date_plateCode) {
		this.date_plateCode = date_plateCode;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getPlateCode() {
		return plateCode;
	}
	public void setPlateCode(String plateCode) {
		this.plateCode = plateCode;
	}
	public String getPlatename() {
		return platename;
	}
	public void setPlatename(String platename) {
		this.platename = platename;
	}
	public String getAuthId() {
		return authId;
	}
	public void setAuthId(String authId) {
		this.authId = authId;
	}
	}
