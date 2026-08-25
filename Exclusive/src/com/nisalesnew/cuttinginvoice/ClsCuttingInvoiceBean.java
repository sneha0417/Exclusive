package com.nisalesnew.cuttinginvoice;

public class ClsCuttingInvoiceBean {
	private int itemtype,itemdocno,docno,accid,costtr_no,hideitemtype,gridlenght,masterdoc_no,salid,acno,currsid,rrefno,masterrrefno,ftype,hidftype;
	private String  date,itemname,salesmanname ,acctype,accname,currs,fixDate,lpono,deliveryDate,deliveryTime,remarks,formdetailcode;
	private String  hideacctype,hiddate, hidfixDate,hiddeliveryDate,hiddeliveryTime,mode,deleted,msg,rreftypeval,rreftype;
	 private double ratess,hidtaxper;
	 


		private double  totalamount,charge,discount,nettotal,taxamount,invvalue;
		private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname,lbltotaltax;	
		private String lblBuye,lblTel,lblFax,lblRemarks,lblProject,lblOrderNO,lblDate,lblPoNo,lblSalseman,lblDeliveryDate,lblFixingDate,lbladdresscl;
		private String lblamountvaluewords,lbltotalamount,lblnettotal,lblcharge,lbldiscount,lblinvvalue,lbldocNO,lbltrnno,lblcltrno;
		private String cutqry;
		
 
		public double getHidtaxper() {
		return hidtaxper;
	}
	public void setHidtaxper(double hidtaxper) {
		this.hidtaxper = hidtaxper;
	}

		public String getCutqry() {
			return cutqry;
		}
		public void setCutqry(String cutqry) {
			this.cutqry = cutqry;
		}
		
		
		
		 public String getLbltrnno() {
			return lbltrnno;
		}


		public void setLbltrnno(String lbltrnno) {
			this.lbltrnno = lbltrnno;
		}


		public String getLblcltrno() {
			return lblcltrno;
		}


		public void setLblcltrno(String lblcltrno) {
			this.lblcltrno = lblcltrno;
		}

		
		
	


	public String getLbltotaltax() {
			return lbltotaltax;
		}


		public void setLbltotaltax(String lbltotaltax) {
			this.lbltotaltax = lbltotaltax;
		}


	public String getLblcharge() {
			return lblcharge;
		}


		public void setLblcharge(String lblcharge) {
			this.lblcharge = lblcharge;
		}


		public String getLbldiscount() {
			return lbldiscount;
		}


		public void setLbldiscount(String lbldiscount) {
			this.lbldiscount = lbldiscount;
		}


	public int getFtype() {
			return ftype;
		}


		public void setFtype(int ftype) {
			this.ftype = ftype;
		}


		public int getHidftype() {
			return hidftype;
		}


		public void setHidftype(int hidftype) {
			this.hidftype = hidftype;
		}


	public String getLblamountvaluewords() {
			return lblamountvaluewords;
		}


		public void setLblamountvaluewords(String lblamountvaluewords) {
			this.lblamountvaluewords = lblamountvaluewords;
		}


		public String getLbltotalamount() {
			return lbltotalamount;
		}


		public void setLbltotalamount(String lbltotalamount) {
			this.lbltotalamount = lbltotalamount;
		}


		public String getLblnettotal() {
			return lblnettotal;
		}


		public void setLblnettotal(String lblnettotal) {
			this.lblnettotal = lblnettotal;
		}


	

		public String getLblinvvalue() {
			return lblinvvalue;
		}


		public void setLblinvvalue(String lblinvvalue) {
			this.lblinvvalue = lblinvvalue;
		}


		public String getLbldocNO() {
			return lbldocNO;
		}


		public void setLbldocNO(String lbldocNO) {
			this.lbldocNO = lbldocNO;
		}


	public double getTotalamount() {
			return totalamount;
		}


		public void setTotalamount(double totalamount) {
			this.totalamount = totalamount;
		}


		public double getCharge() {
			return charge;
		}


		public void setCharge(double charge) {
			this.charge = charge;
		}


		public double getDiscount() {
			return discount;
		}


		public void setDiscount(double discount) {
			this.discount = discount;
		}


		public double getNettotal() {
			return nettotal;
		}


		public void setNettotal(double nettotal) {
			this.nettotal = nettotal;
		}


		public double getTaxamount() {
			return taxamount;
		}


		public void setTaxamount(double taxamount) {
			this.taxamount = taxamount;
		}


		public double getInvvalue() {
			return invvalue;
		}


		public void setInvvalue(double invvalue) {
			this.invvalue = invvalue;
		}


	public int getRrefno() {
		return rrefno;
	}


	public void setRrefno(int rrefno) {
		this.rrefno = rrefno;
	}


	public int getMasterrrefno() {
		return masterrrefno;
	}


	public void setMasterrrefno(int masterrrefno) {
		this.masterrrefno = masterrrefno;
	}


	public String getRreftypeval() {
		return rreftypeval;
	}


	public void setRreftypeval(String rreftypeval) {
		this.rreftypeval = rreftypeval;
	}


	public String getRreftype() {
		return rreftype;
	}


	public void setRreftype(String rreftype) {
		this.rreftype = rreftype;
	}


	public int getCurrsid() {
		return currsid;
	}


	public void setCurrsid(int currsid) {
		this.currsid = currsid;
	}


	public String getFormdetailcode() {
		return formdetailcode;
	}


	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}


	public int getSalid() {
		return salid;
	}


	public void setSalid(int salid) {
		this.salid = salid;
	}


	public int getAcno() {
		return acno;
	}


	public void setAcno(int acno) {
		this.acno = acno;
	}


	public int getItemtype() {
		return itemtype;
	}


	public void setItemtype(int itemtype) {
		this.itemtype = itemtype;
	}


	public int getItemdocno() {
		return itemdocno;
	}


	public void setItemdocno(int itemdocno) {
		this.itemdocno = itemdocno;
	}


	public int getDocno() {
		return docno;
	}


	public void setDocno(int docno) {
		this.docno = docno;
	}


	public int getAccid() {
		return accid;
	}


	public void setAccid(int accid) {
		this.accid = accid;
	}


	public int getCosttr_no() {
		return costtr_no;
	}


	public void setCosttr_no(int costtr_no) {
		this.costtr_no = costtr_no;
	}


	public int getHideitemtype() {
		return hideitemtype;
	}


	public void setHideitemtype(int hideitemtype) {
		this.hideitemtype = hideitemtype;
	}


	public int getGridlenght() {
		return gridlenght;
	}


	public void setGridlenght(int gridlenght) {
		this.gridlenght = gridlenght;
	}


	public int getMasterdoc_no() {
		return masterdoc_no;
	}


	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}


	public String getDate() {
		return date;
	}


	public void setDate(String date) {
		this.date = date;
	}


	public String getItemname() {
		return itemname;
	}


	public void setItemname(String itemname) {
		this.itemname = itemname;
	}


	public String getSalesmanname() {
		return salesmanname;
	}


	public void setSalesmanname(String salesmanname) {
		this.salesmanname = salesmanname;
	}


	public String getAcctype() {
		return acctype;
	}


	public void setAcctype(String acctype) {
		this.acctype = acctype;
	}


	public String getAccname() {
		return accname;
	}


	public void setAccname(String accname) {
		this.accname = accname;
	}


	public String getCurrs() {
		return currs;
	}


	public void setCurrs(String currs) {
		this.currs = currs;
	}


	public String getFixDate() {
		return fixDate;
	}


	public void setFixDate(String fixDate) {
		this.fixDate = fixDate;
	}


	public String getLpono() {
		return lpono;
	}


	public void setLpono(String lpono) {
		this.lpono = lpono;
	}


	public String getDeliveryDate() {
		return deliveryDate;
	}


	public void setDeliveryDate(String deliveryDate) {
		this.deliveryDate = deliveryDate;
	}


	public String getDeliveryTime() {
		return deliveryTime;
	}


	public void setDeliveryTime(String deliveryTime) {
		this.deliveryTime = deliveryTime;
	}


	public String getRemarks() {
		return remarks;
	}


	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}


	public String getHideacctype() {
		return hideacctype;
	}


	public void setHideacctype(String hideacctype) {
		this.hideacctype = hideacctype;
	}


	public String getHiddate() {
		return hiddate;
	}


	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
	}


	public String getHidfixDate() {
		return hidfixDate;
	}


	public void setHidfixDate(String hidfixDate) {
		this.hidfixDate = hidfixDate;
	}


	public String getHiddeliveryDate() {
		return hiddeliveryDate;
	}


	public void setHiddeliveryDate(String hiddeliveryDate) {
		this.hiddeliveryDate = hiddeliveryDate;
	}


	public String getHiddeliveryTime() {
		return hiddeliveryTime;
	}


	public void setHiddeliveryTime(String hiddeliveryTime) {
		this.hiddeliveryTime = hiddeliveryTime;
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


	public double getRatess() {
		return ratess;
	}


	public void setRatess(double ratess) {
		this.ratess = ratess;
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


	public String getLblprintname() {
		return lblprintname;
	}


	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}


	public String getLblBuye() {
		return lblBuye;
	}


	public void setLblBuye(String lblBuye) {
		this.lblBuye = lblBuye;
	}


	public String getLblTel() {
		return lblTel;
	}


	public void setLblTel(String lblTel) {
		this.lblTel = lblTel;
	}


	public String getLblFax() {
		return lblFax;
	}


	public void setLblFax(String lblFax) {
		this.lblFax = lblFax;
	}


	public String getLblRemarks() {
		return lblRemarks;
	}


	public void setLblRemarks(String lblRemarks) {
		this.lblRemarks = lblRemarks;
	}


	public String getLblProject() {
		return lblProject;
	}


	public void setLblProject(String lblProject) {
		this.lblProject = lblProject;
	}


	public String getLblOrderNO() {
		return lblOrderNO;
	}


	public void setLblOrderNO(String lblOrderNO) {
		this.lblOrderNO = lblOrderNO;
	}


	public String getLblDate() {
		return lblDate;
	}


	public void setLblDate(String lblDate) {
		this.lblDate = lblDate;
	}


	public String getLblPoNo() {
		return lblPoNo;
	}


	public void setLblPoNo(String lblPoNo) {
		this.lblPoNo = lblPoNo;
	}


	public String getLblSalseman() {
		return lblSalseman;
	}


	public void setLblSalseman(String lblSalseman) {
		this.lblSalseman = lblSalseman;
	}


	public String getLblDeliveryDate() {
		return lblDeliveryDate;
	}


	public void setLblDeliveryDate(String lblDeliveryDate) {
		this.lblDeliveryDate = lblDeliveryDate;
	}


	public String getLblFixingDate() {
		return lblFixingDate;
	}


	public void setLblFixingDate(String lblFixingDate) {
		this.lblFixingDate = lblFixingDate;
	}


	public String getLbladdresscl() {
		return lbladdresscl;
	}


	public void setLbladdresscl(String lbladdresscl) {
		this.lbladdresscl = lbladdresscl;
	}
}
