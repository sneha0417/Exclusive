package com.humanresource.setup.employeemaster;

public class ClsEmployeeMasterBean {

	private int txtempmasterdocno;
	private String formdetailcode;
	private String chkstatus;
	private String mode;
	private String deleted;
	private String msg;
	private String employeeDate;
	private String hidemployeeDate;
	private String txtemployeeid;
	private String txtemployeename;
	private String txtempaccount;
	private String txtempaccountname;
	private int txtempaccdocno;
	private String cmbcurrency;
	private String hidcmbcurrency;
	private String joiningDate;
	private String hidjoiningDate;
	private String cmbempdesignation;
	private String hidcmbempdesignation;
	private String cmbempdepartment;
	private String hidcmbempdepartment;
	private String cmbpayrollcategory;
	private String hidcmbpayrollcategory;
	private double txtempcostperhour;
	private double txtemptravels;
	private String txtpermanentaddress;
	private String txtpresentaddress;
	private String txtpermanentmobile;
	private String txtpermanentemail;
	private String txtpresentmobile;
	private String txtpresentemail;
	private String txtest_code;
	private String txtco_name;
	private String txtqualification;
	
	
	public String getTxtqualification() {
		return txtqualification;
	}

	public void setTxtqualification(String txtqualification) {
		this.txtqualification = txtqualification;
	}

	public String getTxtest_code() {
		return txtest_code;
	}

	public void setTxtest_code(String txtest_code) {
		this.txtest_code = txtest_code;
	}

	public String getTxtco_name() {
		return txtco_name;
	}

	public void setTxtco_name(String txtco_name) {
		this.txtco_name = txtco_name;
	}

	private String txtempcity;
	private String txtempstate;
	private String txtemppincode;
	private String txtempnationality;
	private int txtempnationalityid;
	private String txtempreligion;
	
	private String txtempnearestairport;
	private String txtempplaceofbirth;
	private String empDateOfBirth;
	private String hidempDateOfBirth;
	
	private String cmbempsex;
	private String hidcmbempsex;
	
	private String cmbempbloodgroup;
	private String hidcmbempbloodgroup;
	private String cmbempmaritalstatus;
	private String hidcmbempmaritalstatus;
	private String txtempfathername;
	private String txtempmothername;
	private String txtempspousename;
	private String txtempotherdetails;
	private String cmbempagentid;
	private String hidcmbempagentid;
	private String txtbankemployeeid;
	private String txtbankaccountno;
	private String txtbankbranchname;
	private String txtbankifsccode;
	private String lblemployeestatus;
	
	//Monthly Salary Grid
	private int monthlysalarygridlength;
	
	//Documents Grid
	private int documentsgridlength;

	public int getTxtempmasterdocno() {
		return txtempmasterdocno;
	}

	public void setTxtempmasterdocno(int txtempmasterdocno) {
		this.txtempmasterdocno = txtempmasterdocno;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getChkstatus() {
		return chkstatus;
	}

	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
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

	public String getEmployeeDate() {
		return employeeDate;
	}

	public void setEmployeeDate(String employeeDate) {
		this.employeeDate = employeeDate;
	}

	public String getHidemployeeDate() {
		return hidemployeeDate;
	}

	public void setHidemployeeDate(String hidemployeeDate) {
		this.hidemployeeDate = hidemployeeDate;
	}

	public String getTxtemployeeid() {
		return txtemployeeid;
	}

	public void setTxtemployeeid(String txtemployeeid) {
		this.txtemployeeid = txtemployeeid;
	}

	public String getTxtemployeename() {
		return txtemployeename;
	}

	public void setTxtemployeename(String txtemployeename) {
		this.txtemployeename = txtemployeename;
	}

	public String getTxtempaccount() {
		return txtempaccount;
	}

	public void setTxtempaccount(String txtempaccount) {
		this.txtempaccount = txtempaccount;
	}

	public String getTxtempaccountname() {
		return txtempaccountname;
	}

	public void setTxtempaccountname(String txtempaccountname) {
		this.txtempaccountname = txtempaccountname;
	}
	
	public int getTxtempaccdocno() {
		return txtempaccdocno;
	}

	public void setTxtempaccdocno(int txtempaccdocno) {
		this.txtempaccdocno = txtempaccdocno;
	}

	public String getCmbcurrency() {
		return cmbcurrency;
	}

	public void setCmbcurrency(String cmbcurrency) {
		this.cmbcurrency = cmbcurrency;
	}

	public String getHidcmbcurrency() {
		return hidcmbcurrency;
	}

	public void setHidcmbcurrency(String hidcmbcurrency) {
		this.hidcmbcurrency = hidcmbcurrency;
	}

	public String getJoiningDate() {
		return joiningDate;
	}

	public void setJoiningDate(String joiningDate) {
		this.joiningDate = joiningDate;
	}

	public String getHidjoiningDate() {
		return hidjoiningDate;
	}

	public void setHidjoiningDate(String hidjoiningDate) {
		this.hidjoiningDate = hidjoiningDate;
	}

	public String getCmbempdesignation() {
		return cmbempdesignation;
	}

	public void setCmbempdesignation(String cmbempdesignation) {
		this.cmbempdesignation = cmbempdesignation;
	}

	public String getHidcmbempdesignation() {
		return hidcmbempdesignation;
	}

	public void setHidcmbempdesignation(String hidcmbempdesignation) {
		this.hidcmbempdesignation = hidcmbempdesignation;
	}

	public String getCmbempdepartment() {
		return cmbempdepartment;
	}

	public void setCmbempdepartment(String cmbempdepartment) {
		this.cmbempdepartment = cmbempdepartment;
	}

	public String getHidcmbempdepartment() {
		return hidcmbempdepartment;
	}

	public void setHidcmbempdepartment(String hidcmbempdepartment) {
		this.hidcmbempdepartment = hidcmbempdepartment;
	}

	public String getCmbpayrollcategory() {
		return cmbpayrollcategory;
	}

	public void setCmbpayrollcategory(String cmbpayrollcategory) {
		this.cmbpayrollcategory = cmbpayrollcategory;
	}

	public String getHidcmbpayrollcategory() {
		return hidcmbpayrollcategory;
	}

	public void setHidcmbpayrollcategory(String hidcmbpayrollcategory) {
		this.hidcmbpayrollcategory = hidcmbpayrollcategory;
	}
	
	public double getTxtempcostperhour() {
		return txtempcostperhour;
	}

	public void setTxtempcostperhour(double txtempcostperhour) {
		this.txtempcostperhour = txtempcostperhour;
	}

	public double getTxtemptravels() {
		return txtemptravels;
	}

	public void setTxtemptravels(double txtemptravels) {
		this.txtemptravels = txtemptravels;
	}

	public String getTxtpermanentaddress() {
		return txtpermanentaddress;
	}

	public void setTxtpermanentaddress(String txtpermanentaddress) {
		this.txtpermanentaddress = txtpermanentaddress;
	}

	public String getTxtpresentaddress() {
		return txtpresentaddress;
	}

	public void setTxtpresentaddress(String txtpresentaddress) {
		this.txtpresentaddress = txtpresentaddress;
	}

	public String getTxtpermanentmobile() {
		return txtpermanentmobile;
	}

	public void setTxtpermanentmobile(String txtpermanentmobile) {
		this.txtpermanentmobile = txtpermanentmobile;
	}

	public String getTxtpermanentemail() {
		return txtpermanentemail;
	}

	public void setTxtpermanentemail(String txtpermanentemail) {
		this.txtpermanentemail = txtpermanentemail;
	}

	public String getTxtpresentmobile() {
		return txtpresentmobile;
	}

	public void setTxtpresentmobile(String txtpresentmobile) {
		this.txtpresentmobile = txtpresentmobile;
	}

	public String getTxtpresentemail() {
		return txtpresentemail;
	}

	public void setTxtpresentemail(String txtpresentemail) {
		this.txtpresentemail = txtpresentemail;
	}

	public String getTxtempcity() {
		return txtempcity;
	}

	public void setTxtempcity(String txtempcity) {
		this.txtempcity = txtempcity;
	}

	public String getTxtempstate() {
		return txtempstate;
	}

	public void setTxtempstate(String txtempstate) {
		this.txtempstate = txtempstate;
	}

	public String getTxtemppincode() {
		return txtemppincode;
	}

	public void setTxtemppincode(String txtemppincode) {
		this.txtemppincode = txtemppincode;
	}

	public String getTxtempnationality() {
		return txtempnationality;
	}

	public void setTxtempnationality(String txtempnationality) {
		this.txtempnationality = txtempnationality;
	}

	public int getTxtempnationalityid() {
		return txtempnationalityid;
	}

	public void setTxtempnationalityid(int txtempnationalityid) {
		this.txtempnationalityid = txtempnationalityid;
	}

	public String getTxtempreligion() {
		return txtempreligion;
	}

	public void setTxtempreligion(String txtempreligion) {
		this.txtempreligion = txtempreligion;
	}

	public String getTxtempnearestairport() {
		return txtempnearestairport;
	}

	public void setTxtempnearestairport(String txtempnearestairport) {
		this.txtempnearestairport = txtempnearestairport;
	}

	public String getTxtempplaceofbirth() {
		return txtempplaceofbirth;
	}

	public void setTxtempplaceofbirth(String txtempplaceofbirth) {
		this.txtempplaceofbirth = txtempplaceofbirth;
	}

	public String getEmpDateOfBirth() {
		return empDateOfBirth;
	}

	public void setEmpDateOfBirth(String empDateOfBirth) {
		this.empDateOfBirth = empDateOfBirth;
	}

	public String getHidempDateOfBirth() {
		return hidempDateOfBirth;
	}

	public void setHidempDateOfBirth(String hidempDateOfBirth) {
		this.hidempDateOfBirth = hidempDateOfBirth;
	}

	public String getCmbempsex() {
		return cmbempsex;
	}

	public void setCmbempsex(String cmbempsex) {
		this.cmbempsex = cmbempsex;
	}

	public String getHidcmbempsex() {
		return hidcmbempsex;
	}

	public void setHidcmbempsex(String hidcmbempsex) {
		this.hidcmbempsex = hidcmbempsex;
	}

	public String getCmbempbloodgroup() {
		return cmbempbloodgroup;
	}

	public void setCmbempbloodgroup(String cmbempbloodgroup) {
		this.cmbempbloodgroup = cmbempbloodgroup;
	}

	public String getHidcmbempbloodgroup() {
		return hidcmbempbloodgroup;
	}

	public void setHidcmbempbloodgroup(String hidcmbempbloodgroup) {
		this.hidcmbempbloodgroup = hidcmbempbloodgroup;
	}

	public String getCmbempmaritalstatus() {
		return cmbempmaritalstatus;
	}

	public void setCmbempmaritalstatus(String cmbempmaritalstatus) {
		this.cmbempmaritalstatus = cmbempmaritalstatus;
	}

	public String getHidcmbempmaritalstatus() {
		return hidcmbempmaritalstatus;
	}

	public void setHidcmbempmaritalstatus(String hidcmbempmaritalstatus) {
		this.hidcmbempmaritalstatus = hidcmbempmaritalstatus;
	}

	public String getTxtempfathername() {
		return txtempfathername;
	}

	public void setTxtempfathername(String txtempfathername) {
		this.txtempfathername = txtempfathername;
	}

	public String getTxtempmothername() {
		return txtempmothername;
	}

	public void setTxtempmothername(String txtempmothername) {
		this.txtempmothername = txtempmothername;
	}

	public String getTxtempspousename() {
		return txtempspousename;
	}

	public void setTxtempspousename(String txtempspousename) {
		this.txtempspousename = txtempspousename;
	}

	public String getTxtempotherdetails() {
		return txtempotherdetails;
	}

	public void setTxtempotherdetails(String txtempotherdetails) {
		this.txtempotherdetails = txtempotherdetails;
	}

	public String getCmbempagentid() {
		return cmbempagentid;
	}

	public void setCmbempagentid(String cmbempagentid) {
		this.cmbempagentid = cmbempagentid;
	}

	public String getHidcmbempagentid() {
		return hidcmbempagentid;
	}

	public void setHidcmbempagentid(String hidcmbempagentid) {
		this.hidcmbempagentid = hidcmbempagentid;
	}

	public String getTxtbankemployeeid() {
		return txtbankemployeeid;
	}

	public void setTxtbankemployeeid(String txtbankemployeeid) {
		this.txtbankemployeeid = txtbankemployeeid;
	}

	public String getTxtbankaccountno() {
		return txtbankaccountno;
	}

	public void setTxtbankaccountno(String txtbankaccountno) {
		this.txtbankaccountno = txtbankaccountno;
	}

	public String getTxtbankbranchname() {
		return txtbankbranchname;
	}

	public void setTxtbankbranchname(String txtbankbranchname) {
		this.txtbankbranchname = txtbankbranchname;
	}

	public String getTxtbankifsccode() {
		return txtbankifsccode;
	}

	public void setTxtbankifsccode(String txtbankifsccode) {
		this.txtbankifsccode = txtbankifsccode;
	}
	
	public String getLblemployeestatus() {
		return lblemployeestatus;
	}

	public void setLblemployeestatus(String lblemployeestatus) {
		this.lblemployeestatus = lblemployeestatus;
	}

	public int getMonthlysalarygridlength() {
		return monthlysalarygridlength;
	}

	public void setMonthlysalarygridlength(int monthlysalarygridlength) {
		this.monthlysalarygridlength = monthlysalarygridlength;
	}

	public int getDocumentsgridlength() {
		return documentsgridlength;
	}

	public void setDocumentsgridlength(int documentsgridlength) {
		this.documentsgridlength = documentsgridlength;
	}

}