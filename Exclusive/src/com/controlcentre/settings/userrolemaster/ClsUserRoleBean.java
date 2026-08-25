package com.controlcentre.settings.userrolemaster;

public class ClsUserRoleBean {
	
	private int txtuserroledocno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String txtrolename;
	
	public int getTxtuserroledocno() {
		return txtuserroledocno;
	}
	public void setTxtuserroledocno(int txtuserroledocno) {
		this.txtuserroledocno = txtuserroledocno;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getTxtrolename() {
		return txtrolename;
	}
	public void setTxtrolename(String txtrolename) {
		this.txtrolename = txtrolename;
	}
}