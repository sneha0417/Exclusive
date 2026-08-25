package com.realestate.tenancycontract;

public class ClsTenancyContractBean
{
	private String lblcreatedby,lblpostedby,lblmgtype,lblmanage,lblpropname;
	private String cmbcommvattype,commvatamount,cmbmgmtvattype,mgmtvatamount,mgmtnettotal,holdingsecurity,hidcmbmgmtvattype,hidcmbcommvattype,chktenancychequeowner,hidchkvatdistributed;
    private String mode;
    private String deleted;
    private String msg,gridqry,gridqry2,lbladdress,lbltinno,lblcltrno;
    private String tenancyContractDate;
    private String hidtenancyContractDate;
    private String txttenant;
    private String txtproperty;
    private String periodFromDate;
    private String hidperiodFromDate;
    private String periodToDate;
    private String hidPeriodToDate;
   

	private int masterdoc_no;
    private int cmbtenancytype;
    private int hidcmbtenancytype;
    private int docno;
    private int txttenantdocno;
    private int txtpropertydocno;
    private int cmbcontractperiod;
    private int hidcmbcontractperiod;
    private int txtcontractperiod;
    private int txtnotificationperiod;
    private String lbldate;
    private String lblcontractno;
    private String lbllandlord;
    private String lbltenant;
    private String lblperiodtenancy;
    private String lblsubjecttenancy;
    private String lblpurposetenancy;
    private String lblfrom;
    private String lblto;
    private String lblrent;
    private String lblrentwords;
    private String lblpayterm;
    private String lblarea;
    private String lblcontactno;
    private String lblpremisesno;
    private String lbldewano;
    private String lblplotno;
    private String lblpassportexp;
    private String lblvisaexp;
    private String lbltradelicenseexp;
    private String lblsecurity;
    private String tenantdet;
    private String propertydet;
    String txtcommisionperc;
    String txtcommisionval;
    String txtnettotal;
    String txtmanagementperc;
    String txtmanagementval;
    String txtadminfeeowner;
    String txtownertotal;
    String txtnumofcheque;
    String txtmngfeeinstmnt;
    
    
    public String getLblmanage() {
		return lblmanage;
	}

	public void setLblmanage(String lblmanage) {
		this.lblmanage = lblmanage;
	}

	public String getLblcreatedby() {
		return lblcreatedby;
	}

	public void setLblcreatedby(String lblcreatedby) {
		this.lblcreatedby = lblcreatedby;
	}

	public String getLblpostedby() {
		return lblpostedby;
	}

	public void setLblpostedby(String lblpostedby) {
		this.lblpostedby = lblpostedby;
	}

	public String getLbladdress() {
		return lbladdress;
	}

	public void setLbladdress(String lbladdress) {
		this.lbladdress = lbladdress;
	}

	public String getLbltinno() {
		return lbltinno;
	}

	public void setLbltinno(String lbltinno) {
		this.lbltinno = lbltinno;
	}

	public String getLblcltrno() {
		return lblcltrno;
	}

	public void setLblcltrno(String lblcltrno) {
		this.lblcltrno = lblcltrno;
	}
    public String getHidchkvatdistributed() {
		return hidchkvatdistributed;
	}

	public void setHidchkvatdistributed(String hidchkvatdistributed) {
		this.hidchkvatdistributed = hidchkvatdistributed;
	}

	public String getChktenancychequeowner() {
		return chktenancychequeowner;
	}

	public void setChktenancychequeowner(String chktenancychequeowner) {
		this.chktenancychequeowner = chktenancychequeowner;
	}

	public String getLbldate() {
        return this.lbldate;
    }
    
    public void setLbldate(final String lbldate) {
        this.lbldate = lbldate;
    }
    
    public String getLblcontractno() {
        return this.lblcontractno;
    }
    
    public void setLblcontractno(final String lblcontractno) {
        this.lblcontractno = lblcontractno;
    }
    
    public String getLbllandlord() {
        return this.lbllandlord;
    }
    
    public void setLbllandlord(final String lbllandlord) {
        this.lbllandlord = lbllandlord;
    }
    
    public String getLbltenant() {
        return this.lbltenant;
    }
    
    public void setLbltenant(final String lbltenant) {
        this.lbltenant = lbltenant;
    }
    
    public String getLblperiodtenancy() {
        return this.lblperiodtenancy;
    }
    
    public void setLblperiodtenancy(final String lblperiodtenancy) {
        this.lblperiodtenancy = lblperiodtenancy;
    }
    
    public String getLblsubjecttenancy() {
        return this.lblsubjecttenancy;
    }
    
    public void setLblsubjecttenancy(final String lblsubjecttenancy) {
        this.lblsubjecttenancy = lblsubjecttenancy;
    }
    
    public String getLblpurposetenancy() {
        return this.lblpurposetenancy;
    }
    
    public void setLblpurposetenancy(final String lblpurposetenancy) {
        this.lblpurposetenancy = lblpurposetenancy;
    }
    
    public String getLblfrom() {
        return this.lblfrom;
    }
    
    public void setLblfrom(final String lblfrom) {
        this.lblfrom = lblfrom;
    }
    
    public String getLblto() {
        return this.lblto;
    }
    
    public void setLblto(final String lblto) {
        this.lblto = lblto;
    }
    
    public String getLblrent() {
        return this.lblrent;
    }
    
    public void setLblrent(final String lblrent) {
        this.lblrent = lblrent;
    }
    
    public String getLblrentwords() {
        return this.lblrentwords;
    }
    
    public void setLblrentwords(final String lblrentwords) {
        this.lblrentwords = lblrentwords;
    }
    
    public String getLblpayterm() {
        return this.lblpayterm;
    }
    
    public void setLblpayterm(final String lblpayterm) {
        this.lblpayterm = lblpayterm;
    }
    
    public String getLblarea() {
        return this.lblarea;
    }
    
    public void setLblarea(final String lblarea) {
        this.lblarea = lblarea;
    }
    
    public String getLblcontactno() {
        return this.lblcontactno;
    }
    
    public void setLblcontactno(final String lblcontactno) {
        this.lblcontactno = lblcontactno;
    }
    
    public String getLblpremisesno() {
        return this.lblpremisesno;
    }
    
    public void setLblpremisesno(final String lblpremisesno) {
        this.lblpremisesno = lblpremisesno;
    }
    
    public String getLbldewano() {
        return this.lbldewano;
    }
    
    public void setLbldewano(final String lbldewano) {
        this.lbldewano = lbldewano;
    }
    
    public String getLblplotno() {
        return this.lblplotno;
    }
    
    public void setLblplotno(final String lblplotno) {
        this.lblplotno = lblplotno;
    }
    
    public String getLblpassportexp() {
        return this.lblpassportexp;
    }
    
    public void setLblpassportexp(final String lblpassportexp) {
        this.lblpassportexp = lblpassportexp;
    }
    
    public String getLblvisaexp() {
        return this.lblvisaexp;
    }
    
    public void setLblvisaexp(final String lblvisaexp) {
        this.lblvisaexp = lblvisaexp;
    }
    
    public String getLbltradelicenseexp() {
        return this.lbltradelicenseexp;
    }
    
    public void setLbltradelicenseexp(final String lbltradelicenseexp) {
        this.lbltradelicenseexp = lbltradelicenseexp;
    }
    
    public String getLblsecurity() {
        return this.lblsecurity;
    }
    
    public void setLblsecurity(final String lblsecurity) {
        this.lblsecurity = lblsecurity;
    }
    
    public String getMode() {
        return this.mode;
    }
    
    public void setMode(final String mode) {
        this.mode = mode;
    }
    
    public String getDeleted() {
        return this.deleted;
    }
    
    public void setDeleted(final String deleted) {
        this.deleted = deleted;
    }
    
    public String getMsg() {
        return this.msg;
    }
    
    public void setMsg(final String msg) {
        this.msg = msg;
    }
    
    public String getTenancyContractDate() {
        return this.tenancyContractDate;
    }
    
    public void setTenancyContractDate(final String tenancyContractDate) {
        this.tenancyContractDate = tenancyContractDate;
    }
    
    public String getHidtenancyContractDate() {
        return this.hidtenancyContractDate;
    }
    
    public void setHidtenancyContractDate(final String hidtenancyContractDate) {
        this.hidtenancyContractDate = hidtenancyContractDate;
    }
    
    public String getTxttenant() {
        return this.txttenant;
    }
    
    public void setTxttenant(final String txttenant) {
        this.txttenant = txttenant;
    }
    
    public String getTxtproperty() {
        return this.txtproperty;
    }
    
    public void setTxtproperty(final String txtproperty) {
        this.txtproperty = txtproperty;
    }
    
    public String getPeriodFromDate() {
        return this.periodFromDate;
    }
    
    public void setPeriodFromDate(final String periodFromDate) {
        this.periodFromDate = periodFromDate;
    }
    
    public String getHidperiodFromDate() {
        return this.hidperiodFromDate;
    }
    
    public void setHidperiodFromDate(final String hidperiodFromDate) {
        this.hidperiodFromDate = hidperiodFromDate;
    }
    
    public String getPeriodToDate() {
        return this.periodToDate;
    }
    
    public void setPeriodToDate(final String periodToDate) {
        this.periodToDate = periodToDate;
    }
    
    public String getHidPeriodToDate() {
        return this.hidPeriodToDate;
    }
    
    public void setHidPeriodToDate(final String hidPeriodToDate) {
        this.hidPeriodToDate = hidPeriodToDate;
    }
    
    public int getMasterdoc_no() {
        return this.masterdoc_no;
    }
    
    public void setMasterdoc_no(final int masterdoc_no) {
        this.masterdoc_no = masterdoc_no;
    }
    
    public int getCmbtenancytype() {
        return this.cmbtenancytype;
    }
    
    public void setCmbtenancytype(final int cmbtenancytype) {
        this.cmbtenancytype = cmbtenancytype;
    }
    
    public int getHidcmbtenancytype() {
        return this.hidcmbtenancytype;
    }
    
    public void setHidcmbtenancytype(final int hidcmbtenancytype) {
        this.hidcmbtenancytype = hidcmbtenancytype;
    }
    
    public int getDocno() {
        return this.docno;
    }
    
    public void setDocno(final int docno) {
        this.docno = docno;
    }
    
    public int getTxttenantdocno() {
        return this.txttenantdocno;
    }
    
    public void setTxttenantdocno(final int txttenantdocno) {
        this.txttenantdocno = txttenantdocno;
    }
    
    public int getTxtpropertydocno() {
        return this.txtpropertydocno;
    }
    
    public void setTxtpropertydocno(final int txtpropertydocno) {
        this.txtpropertydocno = txtpropertydocno;
    }
    
    public int getCmbcontractperiod() {
        return this.cmbcontractperiod;
    }
    
    public void setCmbcontractperiod(final int cmbcontractperiod) {
        this.cmbcontractperiod = cmbcontractperiod;
    }
    
    public int getHidcmbcontractperiod() {
        return this.hidcmbcontractperiod;
    }
    
    public void setHidcmbcontractperiod(final int hidcmbcontractperiod) {
        this.hidcmbcontractperiod = hidcmbcontractperiod;
    }
    
    public int getTxtcontractperiod() {
        return this.txtcontractperiod;
    }
    
    public void setTxtcontractperiod(final int txtcontractperiod) {
        this.txtcontractperiod = txtcontractperiod;
    }
    
    public int getTxtnotificationperiod() {
        return this.txtnotificationperiod;
    }
    
    public void setTxtnotificationperiod(final int txtnotificationperiod) {
        this.txtnotificationperiod = txtnotificationperiod;
    }
    
    public String getTenantdet() {
        return this.tenantdet;
    }
    
    public void setTenantdet(final String tenantdet) {
        this.tenantdet = tenantdet;
    }
    
    public String getPropertydet() {
        return this.propertydet;
    }
    
    public void setPropertydet(final String propertydet) {
        this.propertydet = propertydet;
    }
    
    public String getTxtmngfeeinstmnt() {
        return this.txtmngfeeinstmnt;
    }
    
    public void setTxtmngfeeinstmnt(final String txtmngfeeinstmnt) {
        this.txtmngfeeinstmnt = txtmngfeeinstmnt;
    }
    
    public String getTxtcommisionperc() {
        return this.txtcommisionperc;
    }
    
    public void setTxtcommisionperc(final String txtcommisionperc) {
        this.txtcommisionperc = txtcommisionperc;
    }
    
    public String getTxtcommisionval() {
        return this.txtcommisionval;
    }
    
    public void setTxtcommisionval(final String txtcommisionval) {
        this.txtcommisionval = txtcommisionval;
    }
    
    public String getTxtnettotal() {
        return this.txtnettotal;
    }
    
    public void setTxtnettotal(final String txtnettotal) {
        this.txtnettotal = txtnettotal;
    }
    
    public String getTxtmanagementperc() {
        return this.txtmanagementperc;
    }
    
    public void setTxtmanagementperc(final String txtmanagementperc) {
        this.txtmanagementperc = txtmanagementperc;
    }
    
    public String getTxtmanagementval() {
        return this.txtmanagementval;
    }
    
    public void setTxtmanagementval(final String txtmanagementval) {
        this.txtmanagementval = txtmanagementval;
    }
    
    public String getTxtadminfeeowner() {
        return this.txtadminfeeowner;
    }
    
    public void setTxtadminfeeowner(final String txtadminfeeowner) {
        this.txtadminfeeowner = txtadminfeeowner;
    }
    
    public String getTxtownertotal() {
        return this.txtownertotal;
    }
    
    public void setTxtownertotal(final String txtownertotal) {
        this.txtownertotal = txtownertotal;
    }
    
    public String getTxtnumofcheque() {
        return this.txtnumofcheque;
    }
    
    public void setTxtnumofcheque(final String txtnumofcheque) {
        this.txtnumofcheque = txtnumofcheque;
    }

	public String getCmbcommvattype() {
		return cmbcommvattype;
	}

	public void setCmbcommvattype(String cmbcommvattype) {
		this.cmbcommvattype = cmbcommvattype;
	}

	public String getCommvatamount() {
		return commvatamount;
	}

	public void setCommvatamount(String commvatamount) {
		this.commvatamount = commvatamount;
	}

	public String getCmbmgmtvattype() {
		return cmbmgmtvattype;
	}

	public void setCmbmgmtvattype(String cmbmgmtvattype) {
		this.cmbmgmtvattype = cmbmgmtvattype;
	}

	public String getMgmtvatamount() {
		return mgmtvatamount;
	}

	public void setMgmtvatamount(String mgmtvatamount) {
		this.mgmtvatamount = mgmtvatamount;
	}

	public String getMgmtnettotal() {
		return mgmtnettotal;
	}

	public void setMgmtnettotal(String mgmtnettotal) {
		this.mgmtnettotal = mgmtnettotal;
	}

	public String getHoldingsecurity() {
		return holdingsecurity;
	}

	public void setHoldingsecurity(String holdingsecurity) {
		this.holdingsecurity = holdingsecurity;
	}

	public String getHidcmbmgmtvattype() {
		return hidcmbmgmtvattype;
	}

	public void setHidcmbmgmtvattype(String hidcmbmgmtvattype) {
		this.hidcmbmgmtvattype = hidcmbmgmtvattype;
	}

	public String getHidcmbcommvattype() {
		return hidcmbcommvattype;
	}

	public void setHidcmbcommvattype(String hidcmbcommvattype) {
		this.hidcmbcommvattype = hidcmbcommvattype;
	}

	public String getGridqry() {
		return gridqry;
	}

	public void setGridqry(String gridqry) {
		this.gridqry = gridqry;
	}

	
	public String getGridqry2() {
		return gridqry2;
	}
	
	public void setGridqry2(String gridqry) {
		this.gridqry2 = gridqry;
	}
	
	
	public String getLblmgtype() {
		return lblmgtype;
	}

	public void setLblmgtype(String lblmgtype) {
		this.lblmgtype = lblmgtype;
	}

	public String getLblpropname() {
		return lblpropname;
	}

	public void setLblpropname(String lblpropname) {
		this.lblpropname = lblpropname;
	}
    
    
}