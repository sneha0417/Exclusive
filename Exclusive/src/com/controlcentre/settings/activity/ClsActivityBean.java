package com.controlcentre.settings.activity;

import java.util.Date;

public class ClsActivityBean {
	
	
	private String activity;
	private String activity_code;
    private Date date_acti;
	private int docno;
    private String mode;
	public String getActivity() {
		return activity;
	}
	public void setActivity(String activity) {
		this.activity = activity;
	}
	public String getActivity_code() {
		return activity_code;
	}
	public void setActivity_code(String activity_code) {
		this.activity_code = activity_code;
	}
	public Date getDate_acti() {
		return date_acti;
	}
	public void setDate_acti(Date date_acti) {
		this.date_acti = date_acti;
	}
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
    

}
