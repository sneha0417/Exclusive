package com.cargo.transportmasters.submode;
import java.util.*;

import com.common.ClsCommon;
public class ClsSubModeBean {
	
	
	private String submodeid;
	
	private int docno;
	private int modeid;
	private String submodedate;
	private String cmbmode;
	private String mode;
	private String deleted;
	private String msg;
	private String formdetail;
	private String formdetailcode;
	
	
	

	public int getModeid() {
		return modeid;
	}
	public void setModeid(int modeid) {
		this.modeid = modeid;
	}
	public String getSubmodeid() {
		return submodeid;
	}
	public void setSubmodeid(String submodeid) {
		this.submodeid = submodeid;
	}	
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}

	public String getSubmodedate() {
		return submodedate;
	}
	public void setSubmodedate(String submodedate) {
		this.submodedate = submodedate;
	}
	public String getCmbmode() {
		return cmbmode;
	}
	public void setCmbmode(String cmbmode) {
		this.cmbmode = cmbmode;
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
	public String getFormdetail() {
		return formdetail;
	}
	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	
}
