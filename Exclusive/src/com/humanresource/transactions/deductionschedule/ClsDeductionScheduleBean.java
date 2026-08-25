package com.humanresource.transactions.deductionschedule;

public class ClsDeductionScheduleBean {
	
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String deductionScheduleDate;
	private String hiddeductionScheduleDate;
	private String txtemployeerefno;
	private int txtdeductionscheduledocno;
	private String txtemployeedetails;
	private int txtemployeedocno;
	private double txtamount;
	private int txtinstnos;
	private double txtinstamt;
	private String startDate;
	private String hidstartDate;
	private String txtdescription;
	
	//Deduction Schedule Grid
	private int gridlength;
	
	//Print
		private String lblcompname;
		private String lblcompaddress;
		private String lblpobox;
		private String lblprintname;
		private String lblcomptel;
		private String lblcompfax;
		private String lblbranch;
		private String lbllocation;
		private String lblservicetax;
		private String lblpan;
		private String lblcstno;
		private int srno;
		private int amount;
		private String date;
	//for hide
		private int firstarray;
		private int secarray;
		private int txtheader;
		
		


		
	   
		
	    public int getAmount() {
			return amount;
		}

		public void setAmount(int amount) {
			this.amount = amount;
		}

		public String getDate() {
			return date;
		}

		public void setDate(String date) {
			this.date = date;
		}

		public int getSrno() {
			return srno;
		}

		public void setSrno(int srno) {
			this.srno = srno;
		}

		public String getLblservicetax() {
			return lblservicetax;
		}

		public void setLblservicetax(String lblservicetax) {
			this.lblservicetax = lblservicetax;
		}

		public String getLblpan() {
			return lblpan;
		}

		public void setLblpan(String lblpan) {
			this.lblpan = lblpan;
		}

		public String getLblcstno() {
			return lblcstno;
		}

		public void setLblcstno(String lblcstno) {
			this.lblcstno = lblcstno;
		}

	public int getFirstarray() {
			return firstarray;
		}

		public void setFirstarray(int firstarray) {
			this.firstarray = firstarray;
		}

		public int getSecarray() {
			return secarray;
		}

		public void setSecarray(int secarray) {
			this.secarray = secarray;
		}

		public int getTxtheader() {
			return txtheader;
		}

		public void setTxtheader(int txtheader) {
			this.txtheader = txtheader;
		}

	public String getLblcompname() {
			return lblcompname;
		}

		public void setLblcompname(String lblcompname) {
			this.lblcompname = lblcompname;
		}

		public String getLblcompaddress() {
			return lblcompaddress;
		}

		public void setLblcompaddress(String lblcompaddress) {
			this.lblcompaddress = lblcompaddress;
		}

		public String getLblpobox() {
			return lblpobox;
		}

		public void setLblpobox(String lblpobox) {
			this.lblpobox = lblpobox;
		}

		public String getLblprintname() {
			return lblprintname;
		}

		public void setLblprintname(String lblprintname) {
			this.lblprintname = lblprintname;
		}

		public String getLblcomptel() {
			return lblcomptel;
		}

		public void setLblcomptel(String lblcomptel) {
			this.lblcomptel = lblcomptel;
		}

		public String getLblcompfax() {
			return lblcompfax;
		}

		public void setLblcompfax(String lblcompfax) {
			this.lblcompfax = lblcompfax;
		}

		public String getLblbranch() {
			return lblbranch;
		}

		public void setLblbranch(String lblbranch) {
			this.lblbranch = lblbranch;
		}

		public String getLbllocation() {
			return lbllocation;
		}

		public void setLbllocation(String lbllocation) {
			this.lbllocation = lbllocation;
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

	public String getDeductionScheduleDate() {
		return deductionScheduleDate;
	}

	public void setDeductionScheduleDate(String deductionScheduleDate) {
		this.deductionScheduleDate = deductionScheduleDate;
	}

	public String getHiddeductionScheduleDate() {
		return hiddeductionScheduleDate;
	}

	public void setHiddeductionScheduleDate(String hiddeductionScheduleDate) {
		this.hiddeductionScheduleDate = hiddeductionScheduleDate;
	}

	public String getTxtemployeerefno() {
		return txtemployeerefno;
	}

	public void setTxtemployeerefno(String txtemployeerefno) {
		this.txtemployeerefno = txtemployeerefno;
	}

	public int getTxtdeductionscheduledocno() {
		return txtdeductionscheduledocno;
	}

	public void setTxtdeductionscheduledocno(int txtdeductionscheduledocno) {
		this.txtdeductionscheduledocno = txtdeductionscheduledocno;
	}

	public String getTxtemployeedetails() {
		return txtemployeedetails;
	}

	public void setTxtemployeedetails(String txtemployeedetails) {
		this.txtemployeedetails = txtemployeedetails;
	}

	public int getTxtemployeedocno() {
		return txtemployeedocno;
	}

	public void setTxtemployeedocno(int txtemployeedocno) {
		this.txtemployeedocno = txtemployeedocno;
	}

	public double getTxtamount() {
		return txtamount;
	}

	public void setTxtamount(double txtamount) {
		this.txtamount = txtamount;
	}

	public int getTxtinstnos() {
		return txtinstnos;
	}

	public void setTxtinstnos(int txtinstnos) {
		this.txtinstnos = txtinstnos;
	}

	public double getTxtinstamt() {
		return txtinstamt;
	}

	public void setTxtinstamt(double txtinstamt) {
		this.txtinstamt = txtinstamt;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getHidstartDate() {
		return hidstartDate;
	}

	public void setHidstartDate(String hidstartDate) {
		this.hidstartDate = hidstartDate;
	}

	public String getTxtdescription() {
		return txtdescription;
	}

	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	
}
