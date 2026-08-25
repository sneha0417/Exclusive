package com.controlcentre.settings.currencybook;

public class ClsCurrencyBookBean {
	
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String jqxCurrencyBookDate;
	private String hidjqxCurrencyBookDate;
	private String txtbasecurrency;
	private int txtbasecurId;
	
	//Currency Grid
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

	public String getJqxCurrencyBookDate() {
		return jqxCurrencyBookDate;
	}

	public void setJqxCurrencyBookDate(String jqxCurrencyBookDate) {
		this.jqxCurrencyBookDate = jqxCurrencyBookDate;
	}

	public String getHidjqxCurrencyBookDate() {
		return hidjqxCurrencyBookDate;
	}

	public void setHidjqxCurrencyBookDate(String hidjqxCurrencyBookDate) {
		this.hidjqxCurrencyBookDate = hidjqxCurrencyBookDate;
	}

	public String getTxtbasecurrency() {
		return txtbasecurrency;
	}

	public void setTxtbasecurrency(String txtbasecurrency) {
		this.txtbasecurrency = txtbasecurrency;
	}

	public int getTxtbasecurId() {
		return txtbasecurId;
	}

	public void setTxtbasecurId(int txtbasecurId) {
		this.txtbasecurId = txtbasecurId;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	
}
