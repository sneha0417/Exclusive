package com.controlcentre.masters.relatedmaster.pricecategory;

public class ClsPriceCategoryBean {
	private int docno;
	private String servicedate;
	private String code;
	private String name;


	private String hidservicedate;
	private String mode;
	private String delete;

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
}
