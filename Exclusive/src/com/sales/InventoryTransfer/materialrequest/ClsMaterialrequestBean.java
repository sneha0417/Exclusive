package com.sales.InventoryTransfer.materialrequest;

public class ClsMaterialrequestBean {

	
	
    private String masterdate, hidmasterdate,  txtlocation,itemname,clientname,site,refno , msg, mode ,deleted, formdetailcode, purdesc;
    private int txtlocationid, type, cldocno ,docno, siteid ,masterdoc_no,serviecGridlength, hideitemtype, hidetype,itemdocno,itemtype,costtr_no;
    
    private String contperson,mob,date,loc_name,flname,desc,refname,costdoc;
    
	 public String  lbldate ,lbltype, lblrefno ,lbldocno,  lblprjname ,lblclname ,lblsite, lbldesc1;
		private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname,lblsalesPerson,lbllocation1;

    

public String getRefname() {
		return refname;
	}

	public void setRefname(String refname) {
		this.refname = refname;
	}

	public String getCostdoc() {
		return costdoc;
	}

	public void setCostdoc(String costdoc) {
		this.costdoc = costdoc;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public String getContperson() {
		return contperson;
	}

	public void setContperson(String contperson) {
		this.contperson = contperson;
	}

	public String getMob() {
		return mob;
	}

	public void setMob(String mob) {
		this.mob = mob;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	
	public String getLoc_name() {
		return loc_name;
	}

	public void setLoc_name(String loc_name) {
		this.loc_name = loc_name;
	}

	public String getFlname() {
		return flname;
	}

	public void setFlname(String flname) {
		this.flname = flname;
	}


    public String getLbldate() {
			return lbldate;
		}

		public void setLbldate(String lbldate) {
			this.lbldate = lbldate;
		}

		public String getLbltype() {
			return lbltype;
		}

		public void setLbltype(String lbltype) {
			this.lbltype = lbltype;
		}

		public String getLblrefno() {
			return lblrefno;
		}

		public void setLblrefno(String lblrefno) {
			this.lblrefno = lblrefno;
		}

		public String getLbldocno() {
			return lbldocno;
		}

		public void setLbldocno(String lbldocno) {
			this.lbldocno = lbldocno;
		}

		public String getLblprjname() {
			return lblprjname;
		}

		public void setLblprjname(String lblprjname) {
			this.lblprjname = lblprjname;
		}

		public String getLblclname() {
			return lblclname;
		}

		public void setLblclname(String lblclname) {
			this.lblclname = lblclname;
		}

		public String getLblsite() {
			return lblsite;
		}

		public void setLblsite(String lblsite) {
			this.lblsite = lblsite;
		}

		public String getLbldesc1() {
			return lbldesc1;
		}

		public void setLbldesc1(String lbldesc1) {
			this.lbldesc1 = lbldesc1;
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

		public String getLblsalesPerson() {
			return lblsalesPerson;
		}

		public void setLblsalesPerson(String lblsalesPerson) {
			this.lblsalesPerson = lblsalesPerson;
		}

		public String getLbllocation1() {
			return lbllocation1;
		}

		public void setLbllocation1(String lbllocation1) {
			this.lbllocation1 = lbllocation1;
		}

	private double productTotal;

	public String getMasterdate() {
		return masterdate;
	}

	public void setMasterdate(String masterdate) {
		this.masterdate = masterdate;
	}

	public String getHidmasterdate() {
		return hidmasterdate;
	}

	public void setHidmasterdate(String hidmasterdate) {
		this.hidmasterdate = hidmasterdate;
	}

	public String getTxtlocation() {
		return txtlocation;
	}

	public void setTxtlocation(String txtlocation) {
		this.txtlocation = txtlocation;
	}

	public String getItemname() {
		return itemname;
	}

	public void setItemname(String itemname) {
		this.itemname = itemname;
	}

	public String getClientname() {
		return clientname;
	}

	public void setClientname(String clientname) {
		this.clientname = clientname;
	}

	public String getSite() {
		return site;
	}

	public void setSite(String site) {
		this.site = site;
	}

	public String getRefno() {
		return refno;
	}

	public void setRefno(String refno) {
		this.refno = refno;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
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

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getPurdesc() {
		return purdesc;
	}

	public void setPurdesc(String purdesc) {
		this.purdesc = purdesc;
	}

	public int getTxtlocationid() {
		return txtlocationid;
	}

	public void setTxtlocationid(int txtlocationid) {
		this.txtlocationid = txtlocationid;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getCldocno() {
		return cldocno;
	}

	public void setCldocno(int cldocno) {
		this.cldocno = cldocno;
	}

	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public int getSiteid() {
		return siteid;
	}

	public void setSiteid(int siteid) {
		this.siteid = siteid;
	}

	public int getMasterdoc_no() {
		return masterdoc_no;
	}

	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}

	public int getServiecGridlength() {
		return serviecGridlength;
	}

	public void setServiecGridlength(int serviecGridlength) {
		this.serviecGridlength = serviecGridlength;
	}

	public int getHideitemtype() {
		return hideitemtype;
	}

	public void setHideitemtype(int hideitemtype) {
		this.hideitemtype = hideitemtype;
	}

	public int getHidetype() {
		return hidetype;
	}

	public void setHidetype(int hidetype) {
		this.hidetype = hidetype;
	}

	public int getItemdocno() {
		return itemdocno;
	}

	public void setItemdocno(int itemdocno) {
		this.itemdocno = itemdocno;
	}

	public int getItemtype() {
		return itemtype;
	}

	public void setItemtype(int itemtype) {
		this.itemtype = itemtype;
	}

	public int getCosttr_no() {
		return costtr_no;
	}

	public void setCosttr_no(int costtr_no) {
		this.costtr_no = costtr_no;
	}

	public double getProductTotal() {
		return productTotal;
	}

	public void setProductTotal(double productTotal) {
		this.productTotal = productTotal;
	}
                   
	
	
	
	
	
	
}
