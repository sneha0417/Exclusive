package com.realestate.jobmaster;

public class ClsJobMasterBean {
	private int docno,vocno,txtjobdesc,vdocno;
	
	public int getTxtjobdesc() {
		return txtjobdesc;
	}

	public void setTxtjobdesc(int txtjobdesc) {
		this.txtjobdesc = txtjobdesc;
	}

	public int getVdocno() {
		return vdocno;
	}
	
	public void setVdocno(int vdocno) {
		this.vdocno = vdocno;
	}

	
	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public int getVocno() {
		return vocno;
	}

	public void setVocno(int vocno) {
		this.vocno = vocno;
	}
 
	private String jqxdate, hiddate,mode,msg,formdetailcode;
	
	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	} 
	
	public String getJqxdate() {
		return jqxdate;
	}

	public void setJqxdate(String jqxdate) {
		this.jqxdate = jqxdate;
	}

	public String getHiddate() {
		return hiddate;
	}

	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	    
}
