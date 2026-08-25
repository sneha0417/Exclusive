package com.humanresource.transactions.leaveopening;

public class ClsLeaveOpeningBean {
	
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String leaveOpeningDate;
	private String hidleaveOpeningDate;
	private int txtleaveopeningdocno;
	
	//Leave Opening Grid
	private int gridlength;

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

	public String getLeaveOpeningDate() {
		return leaveOpeningDate;
	}

	public void setLeaveOpeningDate(String leaveOpeningDate) {
		this.leaveOpeningDate = leaveOpeningDate;
	}

	public String getHidleaveOpeningDate() {
		return hidleaveOpeningDate;
	}

	public void setHidleaveOpeningDate(String hidleaveOpeningDate) {
		this.hidleaveOpeningDate = hidleaveOpeningDate;
	}

	public int getTxtleaveopeningdocno() {
		return txtleaveopeningdocno;
	}

	public void setTxtleaveopeningdocno(int txtleaveopeningdocno) {
		this.txtleaveopeningdocno = txtleaveopeningdocno;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	
}
