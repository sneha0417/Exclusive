package com.realestate.propertyinvoice;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;

public class ClsPropertyInvoiceAction extends ActionSupport{


	ClsCommon objcommon=new ClsCommon();

	ClsPropertyInvoiceDAO propertyinvdao= new ClsPropertyInvoiceDAO(); 
	ClsPropertyInvoiceBean pintbean= new ClsPropertyInvoiceBean(); 
	private String billingname,billingtrn;
	private int agentrowlength;
	private String manual;
	private String nipurchasedate,cmbtype,taxpers;
	private String hidnipurchasedate;
	private int  docno,nidescdetailslenght,tarannumber,masterdoc_no,ordermasterdoc_no;
	private String refno,acctype,nipuraccid,puraccname,cmbcurr,hidcmbcurr,currate,deliverydate,hiddeliverydate,delterms,payterms,purdesc,mode,msg, cmbcurrval,acctypeval,accdocno,formdetailcode;
	private String nireftype,deleted,reftypeval,invno,invDate,hidinvDate;
	
	private Double nettotal,taxperc;
	private String cmbreftype,hidcmbreftype,owner,property,contractfromdate,contracttodate,rentsalevalue,brchName;
	
	// for print   
	
	public String getLblttype() {
		return lblttype;
	}
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}
	public String getManual() {
		return manual;
	}
	public void setManual(String manual) {
		this.manual = manual;
	}
	public void setLblttype(String lblttype) {
		this.lblttype = lblttype;
	}
	public String getLblmgtype() {
		return lblmgtype;
	}
	public void setLblmgtype(String lblmgtype) {
		this.lblmgtype = lblmgtype;
	}
	private String lblbranchtrno,lblcltrnno,lbldocno,lblreftype,lblproperty,lblowner,lblfrom,lblto,lblrentsale,lblsalesagent,lbltaxqry,lblttype,lblmgtype;
	private String lblinvoicetype;
	
	
	public String getLblinvoicetype() {
		return lblinvoicetype;
	}
	public void setLblinvoicetype(String lblinvoicetype) {
		this.lblinvoicetype = lblinvoicetype;
	}
	public String getLbltaxqry() {
		return lbltaxqry;
	}
	public void setLbltaxqry(String lbltaxqry) {
		this.lbltaxqry = lbltaxqry;
	}
	
	public String getLblsalesagent() {
		return lblsalesagent;
	}
	public void setLblsalesagent(String lblsalesagent) {
		this.lblsalesagent = lblsalesagent;
	}
	
	public String getLblproperty() {
		return lblproperty;
	}
	public void setLblproperty(String lblproperty) {
		this.lblproperty = lblproperty;
	}
	public String getLblowner() {
		return lblowner;
	}
	public void setLblowner(String lblowner) {
		this.lblowner = lblowner;
	}
	public String getLblfrom() {
		return lblfrom;
	}
	public void setLblfrom(String lblfrom) {
		this.lblfrom = lblfrom;
	}
	public String getLblto() {
		return lblto;
	}
	public void setLblto(String lblto) {
		this.lblto = lblto;
	}
	public String getLblrentsale() {
		return lblrentsale;
	}
	public void setLblrentsale(String lblrentsale) {
		this.lblrentsale = lblrentsale;
	}
	private String lbltaxamount,lblnettaxamount,lblamountinwords;
	private String lbldate,lbltype,docvals,lblacno,lblacnoname,lbldeldate,lbldddtm,lblpatms,lbldsc,nettaxamount;
	
	public String getLblreftype() {
		return lblreftype;
	}
	public void setLblreftype(String lblreftype) {
		this.lblreftype = lblreftype;
	}
	public String getCmbreftype() {
		return cmbreftype;
	}
	public void setCmbreftype(String cmbreftype) {
		this.cmbreftype = cmbreftype;
	}
	public String getHidcmbreftype() {
		return hidcmbreftype;
	}
	public void setHidcmbreftype(String hidcmbreftype) {
		this.hidcmbreftype = hidcmbreftype;
	}
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
	}
	public String getProperty() {
		return property;
	}
	public void setProperty(String property) {
		this.property = property;
	}
	public String getContractfromdate() {
		return contractfromdate;
	}
	public void setContractfromdate(String contractfromdate) {
		this.contractfromdate = contractfromdate;
	}
	public String getContracttodate() {
		return contracttodate;
	}
	public void setContracttodate(String contracttodate) {
		this.contracttodate = contracttodate;
	}
	public String getRentsalevalue() {
		return rentsalevalue;
	}
	public void setRentsalevalue(String rentsalevalue) {
		this.rentsalevalue = rentsalevalue;
	}
	public int getAgentrowlength() {
		return agentrowlength;
	}
	public void setAgentrowlength(int agentrowlength) {
		this.agentrowlength = agentrowlength;
	}
	public String getBillingname() {
		return billingname;
	}
	public void setBillingname(String billingname) {
		this.billingname = billingname;
	}
	public String getBillingtrn() {
		return billingtrn;
	}
	public void setBillingtrn(String billingtrn) {
		this.billingtrn = billingtrn;
	}
	public String getNettaxamount() {
		return nettaxamount;
	}
	public void setNettaxamount(String nettaxamount) {
		this.nettaxamount = nettaxamount;
	}
	public String getCmbtype() {
		return cmbtype;
	}
	public void setCmbtype(String cmbtype) {
		this.cmbtype = cmbtype;
	}
	public String getTaxpers() {
		return taxpers;
	}
	public void setTaxpers(String taxpers) {
		this.taxpers = taxpers;
	}
	private String  lblvenaddress,lblvenphon,lblvenland,lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname,lblinvno,lblinvdate,lblnettotal;	
	
	private String lbllogoimgpath,lblcompbranchaddress,lblbankdetails,lblbankbeneficiary,lblbankaccountno,lblbeneficiarybank,lblbankibanno;
	private String lblmawb,lblmbl,lblhawb,lblhbl,lblshipper,lblconsignee,lblcarrier,lblflightno,lblvessel,lbletd,lbleta,lblttime,lblboe,lblcontainerno,lbltruckno,lblshipqty,lblgrosswt;
	private int interstate;
	private int hidinterstate;
	private String lblctcperson,lblclientemail;
	
	
	
	public String getLblctcperson() {
		return lblctcperson;
	}
	public void setLblctcperson(String lblctcperson) {
		this.lblctcperson = lblctcperson;
	}
	public String getLblclientemail() {
		return lblclientemail;
	}
	public void setLblclientemail(String lblclientemail) {
		this.lblclientemail = lblclientemail;
	}
	public String getLbldocno() {
	return lbldocno;
	}
	public void setLbldocno(String lbldocno) {
		this.lbldocno = lbldocno;
	}

	public String getLblshipqty() {
		return lblshipqty;
	}

	public void setLblshipqty(String lblshipqty) {
		this.lblshipqty = lblshipqty;
	}

	public String getLblgrosswt() {
		return lblgrosswt;
	}

	public void setLblgrosswt(String lblgrosswt) {
		this.lblgrosswt = lblgrosswt;
	}
	public Double getTaxperc() {
		return taxperc;
	}

	public void setTaxperc(Double taxperc) {
		this.taxperc = taxperc;
	}

	public String getLblvenaddress() {
	return lblvenaddress;
}

public void setLblvenaddress(String lblvenaddress) {
	this.lblvenaddress = lblvenaddress;
}

public String getLblvenphon() {
	return lblvenphon;
}

public void setLblvenphon(String lblvenphon) {
	this.lblvenphon = lblvenphon;
}

public String getLblvenland() {
	return lblvenland;
}

public void setLblvenland(String lblvenland) {
	this.lblvenland = lblvenland;
}

public String getLblbranchtrno() {
	return lblbranchtrno;
}

public void setLblbranchtrno(String lblbranchtrno) {
	this.lblbranchtrno = lblbranchtrno;
}

public String getLblcltrnno() {
	return lblcltrnno;
}

public void setLblcltrnno(String lblcltrnno) {
	this.lblcltrnno = lblcltrnno;
}

public String getLbltaxamount() {
	return lbltaxamount;
}

public void setLbltaxamount(String lbltaxamount) {
	this.lbltaxamount = lbltaxamount;
}

public String getLblnettaxamount() {
	return lblnettaxamount;
}

public void setLblnettaxamount(String lblnettaxamount) {
	this.lblnettaxamount = lblnettaxamount;
}

public String getLblamountinwords() {
	return lblamountinwords;
}

public void setLblamountinwords(String lblamountinwords) {
	this.lblamountinwords = lblamountinwords;
}
	
public String getLbllogoimgpath() {
	return lbllogoimgpath;
}

public void setLbllogoimgpath(String lbllogoimgpath) {
	this.lbllogoimgpath = lbllogoimgpath;
}

public String getLblcompbranchaddress() {
	return lblcompbranchaddress;
}

public void setLblcompbranchaddress(String lblcompbranchaddress) {
	this.lblcompbranchaddress = lblcompbranchaddress;
}

public String getLblbankdetails() {
	return lblbankdetails;
}

public void setLblbankdetails(String lblbankdetails) {
	this.lblbankdetails = lblbankdetails;
}

public String getLblbankbeneficiary() {
	return lblbankbeneficiary;
}

public void setLblbankbeneficiary(String lblbankbeneficiary) {
	this.lblbankbeneficiary = lblbankbeneficiary;
}

public String getLblbankaccountno() {
	return lblbankaccountno;
}

public void setLblbankaccountno(String lblbankaccountno) {
	this.lblbankaccountno = lblbankaccountno;
}

public String getLblbeneficiarybank() {
	return lblbeneficiarybank;
}

public void setLblbeneficiarybank(String lblbeneficiarybank) {
	this.lblbeneficiarybank = lblbeneficiarybank;
}

public String getLblbankibanno() {
	return lblbankibanno;
}

public void setLblbankibanno(String lblbankibanno) {
	this.lblbankibanno = lblbankibanno;
}

	public int getInterstate() {
		return interstate;
	}
	public void setInterstate(int interstate) {
		this.interstate = interstate;
	}
	public int getHidinterstate() {
		return hidinterstate;
	}
	public void setHidinterstate(int hidinterstate) {
		this.hidinterstate = hidinterstate;
	}


	private Map<String, Object> param=null;
	
	public String getNipurchasedate() {
		return nipurchasedate;
	}
	public void setNipurchasedate(String nipurchasedate) {
		this.nipurchasedate = nipurchasedate;
	}
	public String getHidnipurchasedate() {
		return hidnipurchasedate;
	}
	public void setHidnipurchasedate(String hidnipurchasedate) {
		this.hidnipurchasedate = hidnipurchasedate;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public int getNidescdetailslenght() {
		return nidescdetailslenght;
	}
	public void setNidescdetailslenght(int nidescdetailslenght) {
		this.nidescdetailslenght = nidescdetailslenght;
	}
	public int getTarannumber() {
		return tarannumber;
	}
	public void setTarannumber(int tarannumber) {
		this.tarannumber = tarannumber;
	}
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	public int getOrdermasterdoc_no() {
		return ordermasterdoc_no;
	}
	public void setOrdermasterdoc_no(int ordermasterdoc_no) {
		this.ordermasterdoc_no = ordermasterdoc_no;
	}
	public String getRefno() {
		return refno;
	}
	public void setRefno(String refno) {
		this.refno = refno;
	}
	public String getAcctype() {
		return acctype;
	}
	public void setAcctype(String acctype) {
		this.acctype = acctype;
	}
	public String getNipuraccid() {
		return nipuraccid;
	}
	public void setNipuraccid(String nipuraccid) {
		this.nipuraccid = nipuraccid;
	}
	public String getPuraccname() {
		return puraccname;
	}
	public void setPuraccname(String puraccname) {
		this.puraccname = puraccname;
	}
	public String getCmbcurr() {
		return cmbcurr;
	}
	public void setCmbcurr(String cmbcurr) {
		this.cmbcurr = cmbcurr;
	}
	public String getHidcmbcurr() {
		return hidcmbcurr;
	}
	public void setHidcmbcurr(String hidcmbcurr) {
		this.hidcmbcurr = hidcmbcurr;
	}
	public String getCurrate() {
		return currate;
	}
	public void setCurrate(String currate) {
		this.currate = currate;
	}
	public String getDeliverydate() {
		return deliverydate;
	}
	public void setDeliverydate(String deliverydate) {
		this.deliverydate = deliverydate;
	}
	public String getHiddeliverydate() {
		return hiddeliverydate;
	}
	public void setHiddeliverydate(String hiddeliverydate) {
		this.hiddeliverydate = hiddeliverydate;
	}
	public String getDelterms() {
		return delterms;
	}
	public void setDelterms(String delterms) {
		this.delterms = delterms;
	}
	public String getPayterms() {
		return payterms;
	}
	public void setPayterms(String payterms) {
		this.payterms = payterms;
	}
	public String getPurdesc() {
		return purdesc;
	}
	public void setPurdesc(String purdesc) {
		this.purdesc = purdesc;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getCmbcurrval() {
		return cmbcurrval;
	}
	public void setCmbcurrval(String cmbcurrval) {
		this.cmbcurrval = cmbcurrval;
	}
	public String getAcctypeval() {
		return acctypeval;
	}
	public void setAcctypeval(String acctypeval) {
		this.acctypeval = acctypeval;
	}
	public String getAccdocno() {
		return accdocno;
	}
	public void setAccdocno(String accdocno) {
		this.accdocno = accdocno;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getNireftype() {
		return nireftype;
	}
	public void setNireftype(String nireftype) {
		this.nireftype = nireftype;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public String getReftypeval() {
		return reftypeval;
	}
	public void setReftypeval(String reftypeval) {
		this.reftypeval = reftypeval;
	}
	public String getInvno() {
		return invno;
	}
	public void setInvno(String invno) {
		this.invno = invno;
	}
	public String getInvDate() {
		return invDate;
	}
	public void setInvDate(String invDate) {
		this.invDate = invDate;
	}
	public String getHidinvDate() {
		return hidinvDate;
	}
	public void setHidinvDate(String hidinvDate) {
		this.hidinvDate = hidinvDate;
	}
	public Double getNettotal() {
		return nettotal;
	}
	public void setNettotal(Double nettotal) {
		this.nettotal = nettotal;
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
	public String getDocvals() {
		return docvals;
	}
	public void setDocvals(String docvals) {
		this.docvals = docvals;
	}
	public String getLblacno() {
		return lblacno;
	}
	public void setLblacno(String lblacno) {
		this.lblacno = lblacno;
	}
	public String getLblacnoname() {
		return lblacnoname;
	}
	public void setLblacnoname(String lblacnoname) {
		this.lblacnoname = lblacnoname;
	}
	public String getLbldeldate() {
		return lbldeldate;
	}
	public void setLbldeldate(String lbldeldate) {
		this.lbldeldate = lbldeldate;
	}
	public String getLbldddtm() {
		return lbldddtm;
	}
	public void setLbldddtm(String lbldddtm) {
		this.lbldddtm = lbldddtm;
	}
	public String getLblpatms() {
		return lblpatms;
	}
	public void setLblpatms(String lblpatms) {
		this.lblpatms = lblpatms;
	}
	public String getLbldsc() {
		return lbldsc;
	}
	public void setLbldsc(String lbldsc) {
		this.lbldsc = lbldsc;
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
	public String getLblinvno() {
		return lblinvno;
	}
	public void setLblinvno(String lblinvno) {
		this.lblinvno = lblinvno;
	}
	public String getLblinvdate() {
		return lblinvdate;
	}
	public void setLblinvdate(String lblinvdate) {
		this.lblinvdate = lblinvdate;
	}
	public String getLblnettotal() {
		return lblnettotal;
	}
	public void setLblnettotal(String lblnettotal) {
		this.lblnettotal = lblnettotal;
	}
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	
	public String url;
	
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getLblmawb() {
		return lblmawb;
	}

	public void setLblmawb(String lblmawb) {
		this.lblmawb = lblmawb;
	}

	public String getLblmbl() {
		return lblmbl;
	}

	public void setLblmbl(String lblmbl) {
		this.lblmbl = lblmbl;
	}

	public String getLblhawb() {
		return lblhawb;
	}

	public void setLblhawb(String lblhawb) {
		this.lblhawb = lblhawb;
	}

	public String getLblhbl() {
		return lblhbl;
	}

	public void setLblhbl(String lblhbl) {
		this.lblhbl = lblhbl;
	}

	public String getLblshipper() {
		return lblshipper;
	}

	public void setLblshipper(String lblshipper) {
		this.lblshipper = lblshipper;
	}

	public String getLblconsignee() {
		return lblconsignee;
	}

	public void setLblconsignee(String lblconsignee) {
		this.lblconsignee = lblconsignee;
	}

	public String getLblcarrier() {
		return lblcarrier;
	}

	public void setLblcarrier(String lblcarrier) {
		this.lblcarrier = lblcarrier;
	}

	public String getLblflightno() {
		return lblflightno;
	}

	public void setLblflightno(String lblflightno) {
		this.lblflightno = lblflightno;
	}

	public String getLblvessel() {
		return lblvessel;
	}

	public void setLblvessel(String lblvessel) {
		this.lblvessel = lblvessel;
	}

	public String getLbletd() {
		return lbletd;
	}

	public void setLbletd(String lbletd) {
		this.lbletd = lbletd;
	}

	public String getLbleta() {
		return lbleta;
	}

	public void setLbleta(String lbleta) {
		this.lbleta = lbleta;
	}

	public String getLblttime() {
		return lblttime;
	}

	public void setLblttime(String lblttime) {
		this.lblttime = lblttime;
	}

	public String getLblboe() {
		return lblboe;
	}

	public void setLblboe(String lblboe) {
		this.lblboe = lblboe;
	}

	public String getLblcontainerno() {
		return lblcontainerno;
	}

	public void setLblcontainerno(String lblcontainerno) {
		this.lblcontainerno = lblcontainerno;
	}

	public String getLbltruckno() {
		return lbltruckno;
	}

	public void setLbltruckno(String lbltruckno) {
		this.lbltruckno = lbltruckno;
	}
	public void setValues(int docno,int trans,int vdocno,java.sql.Date sqldate,java.sql.Date sqlcontractfromdate,java.sql.Date sqlcontracttodate){
		setTarannumber(trans);
		setHidnipurchasedate(sqldate.toString());
		setOrdermasterdoc_no(getOrdermasterdoc_no()) ;
		setRefno(getRefno());
		setReftypeval(getNireftype());
		setAcctypeval(getAcctype());
		setCmbtype(getCmbtype());
		setNipuraccid(getNipuraccid());
		setPuraccname(getPuraccname());
		setHidcmbcurr(getCmbcurr());
		setCmbcurrval(getCmbcurr());
		setAccdocno(getAccdocno());
	    setCurrate(getCurrate());
	    setDelterms(getDelterms());
	    setPayterms(getPayterms());
	    setPurdesc(getPurdesc());
	    setNettotal(getNettotal());
	    setHidinterstate(getInterstate());
	    setTaxperc(getTaxperc());
		//setDocno(val);
		setDocno(vdocno);
		setMasterdoc_no(docno);
		setOwner(getOwner());
		setProperty(getProperty());
		if(sqlcontractfromdate!=null){
			setContractfromdate(sqlcontractfromdate.toString());
		}
		if(sqlcontracttodate!=null){
			setContracttodate(sqlcontracttodate.toString());
		}
		setProperty(getProperty());
		setOwner(getOwner());
		setRentsalevalue(getRentsalevalue());
		setCmbreftype(getCmbreftype());
		setHidcmbreftype(getCmbreftype());
		setLblinvoicetype("Manual Invoice");
		if(getManual().equalsIgnoreCase("")){
			setManual("1");
		}
		else{
			setManual(getManual());
		}
	}
	public String saveAction() throws ParseException, SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		java.sql.Date sqlStartDate1 = null;
		/*java.sql.Date sqlpurdeldate = null;
		java.sql.Date sqlcontractfromdate=null;
		java.sql.Date sqlcontracttodate=null;
		java.sql.Date sqlinvdate=null;
		String mode=getMode();
		if(!getContractfromdate().equalsIgnoreCase("") && getContractfromdate()!=null && !getContractfromdate().equalsIgnoreCase("undefined")){
			sqlcontractfromdate=objcommon.changeStringtoSqlDate(getContractfromdate());
		}
		if(!getContracttodate().equalsIgnoreCase("") && getContracttodate()!=null && !getContracttodate().equalsIgnoreCase("undefined")){
			sqlcontracttodate=objcommon.changeStringtoSqlDate(getContracttodate());
		}*/
		if(getNipurchasedate()!=null){
			sqlStartDate1=objcommon.changeStringtoSqlDate(getNipurchasedate());
		}
		
		java.sql.Date sqlpurdeldate = null;
		java.sql.Date sqlcontractfromdate=null;
		java.sql.Date sqlcontracttodate=null;
		java.sql.Date sqlinvdate=null;
		String mode=getMode();
		if(getContractfromdate()!=null){
			if(!getContractfromdate().equalsIgnoreCase("") && getContractfromdate()!=null && !getContractfromdate().equalsIgnoreCase("undefined")){
				sqlcontractfromdate=objcommon.changeStringtoSqlDate(getContractfromdate());
			}
			else{
				sqlcontractfromdate=sqlStartDate1;
			}
		}
		else{
			sqlcontractfromdate=sqlStartDate1;
		}
		if(getContracttodate()!=null){
			if(!getContracttodate().equalsIgnoreCase("") && getContracttodate()!=null && !getContracttodate().equalsIgnoreCase("undefined")){
				sqlcontracttodate=objcommon.changeStringtoSqlDate(getContracttodate());
			}
			else{
				sqlcontracttodate=sqlStartDate1;
			}
		}
		else{
			sqlcontracttodate=sqlStartDate1;
		}
		
		if(mode.equalsIgnoreCase("A")){
			ArrayList<String> descarray= new ArrayList<>();
			ArrayList<String> agentarray=new ArrayList<>();
			for(int i=0;i<getNidescdetailslenght();i++){
				String temp2=requestParams.get("desctest"+i)[0];
				descarray.add(temp2);
			}
	
			for(int i=0;i<getAgentrowlength();i++){
				String temp2=requestParams.get("agentarray"+i)[0];
				agentarray.add(temp2);
			}
			int val=propertyinvdao.insert(sqlStartDate1,sqlpurdeldate,getCmbreftype(),getRefno(),getAcctype(),getAccdocno(),getPuraccname(), 
					getCmbcurr(),getCurrate(),getDelterms(),getPayterms(),getPurdesc(),session,getMode(),getNettotal(),descarray,getFormdetailcode(),
					request,sqlinvdate,getInvno(),getInvDate(),getInterstate(),getTaxperc(),getBillingname(),getBillingtrn(),agentarray,1,
					getProperty(),getOwner(),sqlcontractfromdate,sqlcontracttodate,getRentsalevalue());
	
			int vdocno=(int) request.getAttribute("vocno");
			if(val>0){
				int tanss=(int) request.getAttribute("trans");
				setValues(val, tanss, vdocno, sqlStartDate1,sqlcontractfromdate,sqlcontracttodate);
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setValues(val, 0, vdocno, sqlStartDate1,sqlcontractfromdate,sqlcontracttodate);
				setMsg("Not Saved");
				return "fail";
			}
		}


	else if(mode.equalsIgnoreCase("E")){
		ArrayList<String> descarray= new ArrayList<>();
		for(int i=0;i<getNidescdetailslenght();i++){
			String temp2=requestParams.get("desctest"+i)[0];
			descarray.add(temp2);
		}
		ArrayList<String> agentarray=new ArrayList<>();
		for(int i=0;i<getAgentrowlength();i++){
			String temp2=requestParams.get("agentarray"+i)[0];
			agentarray.add(temp2);
		}
		System.out.println("Branch :"+getBrchName());
		boolean Status=propertyinvdao.edit(getMasterdoc_no(),sqlStartDate1,sqlpurdeldate,getCmbreftype(),getRefno(),
				getAcctype(),getAccdocno(),getPuraccname(), getCmbcurr(),getCurrate(),getDelterms(),getPayterms(),
				getPurdesc(),session,getMode(),getNettotal(),descarray,getFormdetailcode(),getTarannumber(),request,sqlinvdate,
				getInvno(),getInvDate(),getInterstate(),getTaxperc(),getBillingname(),getBillingtrn(),agentarray,
				getProperty(),getOwner(),sqlcontractfromdate,sqlcontracttodate,getRentsalevalue(),getManual(),getDocno(),getBrchName());
		if(Status){
			setValues(getMasterdoc_no(), getTarannumber(), getDocno(), sqlStartDate1,sqlcontractfromdate,sqlcontracttodate);
			setMsg("Updated Successfully");
			return "success";
		
		}
		else{
			setValues(getMasterdoc_no(), getTarannumber(), getDocno(), sqlStartDate1,sqlcontractfromdate,sqlcontracttodate);
			setMsg("Not Updated");
			return "fail";
		}
	}
else if(mode.equalsIgnoreCase("D")){
		boolean Status=propertyinvdao.delete(getMasterdoc_no(),session,getMode(),getFormdetailcode());
	if(Status){
		setValues(getMasterdoc_no(), getTarannumber(), getDocno(), sqlStartDate1,sqlcontractfromdate,sqlcontracttodate);
		setDeleted("DELETED");
		setMsg("Successfully Deleted");
		return "success";
	}
	else{
		setValues(getMasterdoc_no(), getTarannumber(), getDocno(), sqlStartDate1,sqlcontractfromdate,sqlcontracttodate);
		setMsg("Not Deleted");
		return "fail";
	}

}

else if(mode.equalsIgnoreCase("view")){
	pintbean=propertyinvdao.getViewDetails(session,getDocno());
	setDocno(pintbean.getDocno());
	setManual(pintbean.getManual());
	setMasterdoc_no(pintbean.getMasterdoc_no());
	setNipurchasedate(pintbean.getNipurchasedate());
	setOrdermasterdoc_no(pintbean.getOrdermasterdoc_no());
	setAcctypeval(pintbean.getAcctypeval());
	setCmbtype(pintbean.getCmbtype());
	setReftypeval(pintbean.getReftypeval());
	setNettotal(pintbean.getNettotal());
	setAccdocno(pintbean.getAccdocno());
	setRefno(pintbean.getRefno());
	setTarannumber(pintbean.getTarannumber());
	setNipuraccid(pintbean.getNipuraccid());
	setPuraccname(pintbean.getPuraccname());
	setBillingname(pintbean.getBillingname());
	setBillingtrn(pintbean.getBillingtrn());
	setPurdesc(pintbean.getPurdesc());
	setAcctype(pintbean.getAcctype());
	setCurrate(pintbean.getCurrate());
	setCmbcurr(pintbean.getHidcmbcurr());
	setFormdetailcode(pintbean.getFormdetailcode());
	setProperty(pintbean.getProperty());
	setOwner(pintbean.getOwner());
	setContractfromdate(pintbean.getContractfromdate());
	setContracttodate(pintbean.getContracttodate());
	setRentsalevalue(pintbean.getRentsalevalue());
	setHidcmbreftype(pintbean.getHidcmbreftype());
	
	
	return "success";
}


return "fail";	

}
	
	
	
	
	
	 public String printAction() throws ParseException, SQLException{
			
		  HttpServletRequest request=ServletActionContext.getRequest();
		  HttpSession session=request.getSession();
		 int doc=Integer.parseInt(request.getParameter("docno"));
		  String dtype=request.getParameter("dtype");
		
	 pintbean=propertyinvdao.getPrint(doc,request,session);
	 System.out.println("in printaction");
	 setUrl(objcommon.getPrintPath(dtype)); 
		 
		  //cl details
				setLblvenaddress(pintbean.getLblvenaddress());
	 			setLblvenphon(pintbean.getLblvenphon());
	 			setLblvenland(pintbean.getLblvenland());
	 			setLblbranchtrno(pintbean.getLblbranchtrno());
	 			setLblcltrnno(pintbean.getLblcltrnno());
				 
		        setLblprintname("Service Sales Tax Invoice");
		        setLbldate(pintbean.getLbldate());
		    	setLbltype(pintbean.getLbltype());
		    	setDocvals(pintbean.getDocvals());
		    	setLblacno(pintbean.getLblacno());
		    	    //upper
		    	setLblacnoname(pintbean.getLblacnoname());
		    	setLbldeldate(pintbean.getLbldeldate());
		    	setLbldddtm(pintbean.getLbldddtm());
		    	    
		    	setLbldsc(pintbean.getLbldsc());
		    	setLblpatms(pintbean.getLblpatms());
		
		    	setLblnettotal(pintbean.getLblnettotal());
				setLbltaxamount(pintbean.getLbltaxamount());
		    	setLblnettaxamount(pintbean.getLblnettaxamount());
		    	setLblamountinwords(pintbean.getLblamountinwords());

		    	setLblbranch(pintbean.getLblbranch());
		    	setLblcompname(pintbean.getLblcompname());
		    	setLblcompaddress(pintbean.getLblcompaddress());
		    	setLblcomptel(pintbean.getLblcomptel());
		    	setLblcompfax(pintbean.getLblcompfax());
		    	setLbllocation(pintbean.getLbllocation());
		    	setLblinvno(pintbean.getLblinvno());
		    	setLblinvdate(pintbean.getLblinvdate());
		    	
		    	setLbllogoimgpath(pintbean.getLbllogoimgpath());
				setLblcompbranchaddress(pintbean.getLblcompbranchaddress());
		    	setLblbankdetails(pintbean.getLblbankdetails());
		    	setLblbankbeneficiary(pintbean.getLblbankbeneficiary());
		    	setLblbankaccountno(pintbean.getLblbankaccountno());
		    	setLblbeneficiarybank(pintbean.getLblbeneficiarybank());
		    	setLblbankibanno(pintbean.getLblbankibanno());
				setNettaxamount(pintbean.getNettaxamount());
				setLblmawb(pintbean.getLblmawb());
		    	setLblmbl(pintbean.getLblmbl());
		    	setLblhawb(pintbean.getLblhawb());
		    	setLblhbl(pintbean.getLblhbl());
		    	setLblshipper(pintbean.getLblshipper());
		    	setLblconsignee(pintbean.getLblconsignee());
		    	setLblcarrier(pintbean.getLblcarrier());
		    	setLblflightno(pintbean.getLblflightno());
		    	setLblvessel(pintbean.getLblvessel());
	    	 	setLbletd(pintbean.getLbletd());
	    	 	setLbleta(pintbean.getLbleta());
	    	 	setLblttime(pintbean.getLblttime());
	    	 	setLblboe(pintbean.getLblboe());
	    	 	setLblcontainerno(pintbean.getLblcontainerno());
	    	 	setLbltruckno(pintbean.getLbltruckno());
	    	 	setLblreftype(pintbean.getLblreftype());
	    	 	setLblproperty(pintbean.getLblproperty());
	    	 	setLblowner(pintbean.getLblowner());
	    	 	setLblfrom(pintbean.getLblfrom());
	    	 	setLblto(pintbean.getLblto());
	    	 	setLblrentsale(pintbean.getLblrentsale());
	    	 	setRefno(pintbean.getRefno());
	    	 	setLblsalesagent(pintbean.getLblsalesagent());
	    	 	setLbltaxqry(pintbean.getLbltaxqry());
	    	 	setLblttype(pintbean.getLblttype());
	    	 	setLblmgtype(pintbean.getLblmgtype());

		if(objcommon.getPrintPath(dtype).contains("jrxml")){
	   	 
		    HttpServletResponse response = ServletActionContext.getResponse();
		    
		    request.getParameter("brhid").toString();
		    
		   
		    ClsPropertyInvoiceBean bean= new ClsPropertyInvoiceBean(); 
		    bean=propertyinvdao.getPrint(doc,request,session);
			 
			
			 
			 param = new HashMap();
			 Connection conn = null;
			 
			 ClsConnection conobj=new ClsConnection();
			 conn = conobj.getMyConnection();
			 Statement stmt= conn.createStatement ();
			 try {
		            
	                    
	             
	            
				
	             
		   
		          
		         /* String termsquery="select distinct @s:=@s+1 sr_no,rdocno,termsheader terms,m.doc_no, 0 priorno from "
		          		+ " (select distinct  tr.rdocno,termsid from my_trterms tr "
		          		+ "where  tr.dtype='PRIV' and tr.brhid='"+brhid+"' and tr.rdocno="+doc+" and tr.status=3 ) tr "
		          		+ "inner join my_termsm m on(tr.termsid=m.voc_no), (SELECT @s:= 0) AS s where  m.status=3 union all "
		          		+ "select '       *' sr_no ,tr.rdocno,conditions terms,m.doc_no,priorno "
		          		+ " from my_trterms tr left join my_termsm m on(tr.termsid=m.voc_no) where "
		          		+ "   tr.dtype='PRIV' and tr.rdocno="+doc+" and tr.brhid='"+brhid+"' and tr.status=3 and m.status=3  order by doc_no,priorno" ;
		        		  "select  @i:=@i+1 as srno,concat(coalesce(m.termsheader,''),' - ',coalesce(t.conditions,'')) terms "
		          		+ " from my_trterms t left join MY_termsm m on m.voc_no=t.termsid"
		          		+ " and t.dtype='PO',(select @i:=0) i     where t.dtype='PO' and t.rdocno="+doc+";";
		          
		      System.out.println("termsqueryyyyyyyyyyy"+termsquery);
		           param.put("termsquery",termsquery);*/
		           
		           
		         /* String descQry=" select @i:=@i+1 as rws,a.* from  (select d.srno,d.desc1 description,round(d.unitprice,2) unitprice,"
		          		+ "  round(d.qty) qty,round(d.total,2) total,round(d.discount,2) discount,round(d.nettotal,2) nettotal,d.nuprice,"
		          		+ " round(d.taxper,2) taxper,round(d.tax,2) taxamount,round(d.nettaxamount,2) netamt "
		        		+ "   from rl_prinvd d  where d.rdocno="+docno+"  ) a,(select @i:=0) r;";*/
		          
		          String descQry=" select @i:=@i+1 as rws,a.* from  (select d.srno,d.desc1 description,round(d.nettotal,2) amount,"
			          		+ " round(d.taxper,2) taxrate,round(d.tax,2) vatamt,round(d.nettaxamount,2) nettotal "
			        		+ "   from rl_prinvd d  where d.rdocno="+docno+"  ) a,(select @i:=0) r;";
		           
		           
		        //  System.out.println("descqry====="+descQry);
		           
		           
		        
		        // param.put("descQry",descQry);
		      //   System.out.println("uuuuuuuu"+bean.getUsername());
		        // param.put("uname",bean.getUsername());
		        
		        // param.put("username", username);
		         			         
		       //  System.out.println("product++++++++++"+productQuery);
		         /*String flcimgpath=request.getSession().getServletContext().getRealPath("/icons/flc.jpg");
		        	flcimgpath=flcimgpath.replace("\\", "\\\\");    
		          param.put("flclogo", flcimgpath);
		        
		         String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
		        	imgpath=imgpath.replace("\\", "\\\\");    
		          param.put("imghedderpath", imgpath);
		          
		          String headereasylease=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
		          headereasylease=headereasylease.replace("\\", "\\\\");*/
		          
		          String headerimge=request.getSession().getServletContext().getRealPath("/icons/IGLOGO1.jpg");
		          headerimge=headerimge.replace("\\", "\\\\");
		          
		          String headerimge11=request.getSession().getServletContext().getRealPath("/icons/IGLOGO.jpg");
		          headerimge11=headerimge11.replace("\\", "\\\\");
		        //  param.put("imghedderpathepic", headerimge);
		          
		          /*String imgpath2=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
		        	imgpath2=imgpath2.replace("\\", "\\\\");    
		          param.put("imgfooterpath", imgpath2);
		          
		          String imgfooterpathepic=request.getSession().getServletContext().getRealPath("/icons/emiratesfooter.jpg");
		          imgfooterpathepic=imgfooterpathepic.replace("\\", "\\\\");    
		          param.put("imgfooterpathepic", imgfooterpathepic);*/
		          
		        //  System.out.println("adrsss+++++++++"+bean.getLblvenaddress());
		      
		             param.put("amountinwords", bean.getLblamountinwords());  
	    			// param.put("from", bean.getLblfrom()); 
	    			 //param.put("to", bean.getLblto());
	    			 param.put("tenant", bean.getLblacnoname());
	    			 param.put("address", bean.getLblvenaddress());    
	    			 param.put("cltrno", bean.getLblcltrnno());
	    			 param.put("invno", bean.getLbldocno());
	    			 param.put("invdate", bean.getLbldate());
	    			 param.put("trno", bean.getCompanytrno());
	    			 param.put("invqrry", descQry);
	    		//	 System.out.println("billingname:"+pintbean.getBillingname());
	    			 param.put("docno", doc+"");
	    		//	 System.out.println("Check PAram:"+param.get("docno"));
	    			 param.put("printby", session.getAttribute("USERNAME"));
	    			 param.put("property", bean.getLblproperty());
	    			 param.put("taxqry", bean.getLbltaxqry());
	    			 param.put("salesagent", bean.getLblsalesagent());
	    			 param.put("desc1", bean.getLbldsc());
	    			 param.put("billingname", bean.getBillingname());
	    			 //System.out.println("getLblreftype()-"+getLblreftype()+"-getLblmgtype()--"+getLblmgtype()+"-getLblttype()-"+getLblttype());
	    			 if(getLblreftype().equalsIgnoreCase("SAL")){
	    				 param.put("reftype","Sales");
	    			 }
	    			 
	    			 if(getLblreftype().equalsIgnoreCase("LES")){
	    				 param.put("reftype","Leasing");
	    			 }
	    			 
	    			 if(getLblreftype().equalsIgnoreCase("TNC") && getLblmgtype().equalsIgnoreCase("1")){
		    				 if(getLblttype().equalsIgnoreCase("AP")){
			    				 param.put("ownname","Owner                 :");
			    				 param.put("owner", bean.getLblowner());
			    			}
			    	   // System.out.println("getLblreftype()--"+getLblreftype()+"-getLblmgtype()--"+getLblmgtype()); 
			        	  param.put("cmpname", "Exclusive Links Leasing and Property Management");
			        	  param.put("propname","Property Name :");
			        	  param.put("tenanname","Tenancy Contract No :");
			        	  param.put("salename","Sales Agent :");
			        	  param.put("reftype","Tenancy");
			        	  param.put("cntrctno", bean.getRefno());
			        	  param.put("cmplogo", headerimge11);
			        	  param.put("bdetail1", "All cheques payable to: Exclusive Links Leasing And Property Management");
			    		  param.put("bdetail2", "Account Name :Exclusive Links Leasing and Property Management");
			    		  param.put("bdetail3", "Account No : 1015110813701");
			    		  param.put("bdetail4", "IBAN : AE270260001015110813701 Swift Code : EBILAEAD");
			    		  param.put("bdetail5", "Bank : Emirates NBD , SATWA BRANCH ,P.O. BOX: 777 ,DUBAI, UAE");
			    		  param.put("billingname", bean.getBillingname());
			          }else{
			        	  System.out.println("owner--"+bean.getLblowner());
		        	  param.put("cmpname", "Exclusive Links Real Estate Brokers");
		        	  param.put("propname","Property Name :");
		        	  param.put("valname","Value               :");
		        	  param.put("salename","Sales Agent :");
		        	  param.put("ownname","Owner                 :");
	    			  param.put("owner", bean.getLblowner());
		        	  param.put("fromname","Period From :");
		        	  param.put("toname","To :");
		        	  param.put("rentsalevalue", bean.getLblrentsale());
		        	  
		    		  param.put("from", bean.getLblfrom());
		    		  param.put("billingname", bean.getBillingname());
		    		  param.put("to", bean.getLblto());
		    		  param.put("cmplogo", headerimge);
		    		  param.put("bdetail1", "All cheques payable to: EXCLUSIVE LINKS REAL ESTATE BROKERS");
		        	  param.put("bdetail2", "Account Name :EXCLUSIVE LINKS REAL ESTATE BROKERS");
		        	  param.put("bdetail3", "Account Number: 101 13470043 01");
		        	  param.put("bdetail4", "IBAN Number: AE850260001011347004301 Swift Code : EBILAEAD");
		        	  param.put("bdetail5", "Bank : EMIRATES NBD ,JUMEIRAH BRANCH ,P.O. BOX 11909 , DUBAI, UAE");
		    		 
		        	 
		          }
	    			 
	    			 if(getLblttype().equalsIgnoreCase("GL")){
	    			
	    				 String srtSql="select coalesce(h.Description,'') tenant, coalesce(p.accname,'') property, coalesce(o.primary_owner,'')owner from rl_prinvm m left join my_head h on h.doc_no=m.acno left join rl_propertymaster p on p.mrf_acno=m.acno left join rl_propertryowner o on o.doc_no=p.owid where m.voc_no="+bean.getLbldocno();
	    				 ResultSet rs = stmt.executeQuery(srtSql);
	    				 String tenant = "";
	    				 String property = "";
	    				 String owner = "";
	    				 if (rs.next()) {
	    					 tenant=rs.getString("tenant");
	    					 property=rs.getString("property");
	    					 owner=rs.getString("owner");
	    				 }
	    			 	param.put("tenant", tenant);
	    			 	param.put("property", property);
	    			 	param.put("owner", owner);
	    			 	 

	    			 }		
		        		         
		         
		         
		          /*param.put("vendor", bean.getLblacnoname());
		          param.put("attn", bean.getAttn());
		          param.put("address", bean.getLblvenaddress());
		          //param.put("tel", bean.getTel());
		          param.put("fax", bean.getFax());
		          param.put("email", bean.getEmail());
		          param.put("docno",bean.getLbldocno());
		          param.put("date", bean.getLbldate());
		          param.put("refno", bean.getRefno());
		          param.put("desc", bean.getLbldsc());
		          param.put("payterm", bean.getLblpatms());
		          param.put("delterm", bean.getLbldddtm());
		          param.put("netamt", bean.getLblnettaxamount());
		        //  System.out.println("netamt"+ bean.getLblnettaxamount());
		         // param.put("amountwords", bean.getWordnetamount());
		          param.put("compname",bean.getLblcompname());
		          param.put("compaddress",bean.getLblbranchaddress());
		          param.put("comptel",bean.getLblcomptel());
		          param.put("compfax",bean.getLblcompfax());
		          param.put("branch", bean.getLblbranch());
		          param.put("location", bean.getLbllocation());
		          param.put("tel", bean.getTelno());
		          param.put("clienttrno",bean.getLblcltrnno());
		          param.put("compnytrno", bean.getCompanytrno());
		         param.put("address", bean.getLblvenaddress());
		          param.put("netamounts", bean.getNettaxamount());
		          System.out.println("amt====="+bean.getNettaxamount());
		          param.put("amountwords",bean.getLblamountinwords());*/
		          
		      /*    param.put("total",bean.getLblnettotal());
		          param.put("vatamnt",bean.getLbltaxamount());
				  
		          String flcquery="select coalesce(ed.pol,'') pol,coalesce(ed.pod,'') pod,coalesce(tr.terms,'') terms,coalesce(sl.sal_name,'') salesman,"
						  + " coalesce(sp.shipment,'') shipvia,coalesce(ed.commodity,'') commodity"
		        		  +" from rl_prinvm m left join(select invtrno,rdocno  from  cr_cfid where invtrno>0  group by rdocno,invtrno) dd on dd.invtrno=m.tr_no and m.status=3"
		        		  + " left join cr_cfim  cf on if(dd.invtrno>0,cf.doc_no=dd.rdocno, cf.tr_no=m.tr_no) left join cm_srvcontrm cm on cf.refno=cm.tr_no"
		        		  +" left join cr_joblist jl on cm.tr_no=jl.jobno left join cr_enqd ed on ed.doc_no=jl.enqdocno"
		        		  +" left join cr_enqm em on ed.rdocno=em.doc_no left join my_head h on h.doc_no=m.acno "
		        		  +" left join my_acbook ac on ac.cldocno=h.cldocno and ac.dtype='crm' left join my_salm sl on ac.sal_id=sl.doc_no"
		        		  +" left join cr_shipment sp on ed.shipid=sp.doc_no left join cr_terms tr on ed.termsid=tr.doc_no where m.doc_no="+doc+" ";
		          param.put("flcquery", flcquery);
		          System.out.println("--flcquery--"+flcquery);
		          
		          String fltquery=" select coalesce(ed.pol,'') loading,coalesce(ed.pod,'') destn, coalesce(sm.submode,'') trucktype, "
		          		  +" coalesce(sl.sal_name,'') salesperson, coalesce(md.modename,'') shipvia,if(ag.agtype=1,coalesce(aa.refname,''),coalesce(ss.sal_name,'')) driver, coalesce(tr.terms,'') terms"
		        		  +" from rl_prinvm m left join(select invtrno,rdocno  from  cr_cfid where invtrno>0  group by rdocno,invtrno) dd on dd.invtrno=m.tr_no and m.status=3"
		        		  + " left join cr_cfim  cf on if(dd.invtrno>0,cf.doc_no=dd.rdocno, cf.tr_no=m.tr_no) left join cm_srvcontrm cm on cf.refno=cm.tr_no"
		        		  +" left join cr_joblist jl on cm.tr_no=jl.jobno left join cr_enqd ed on ed.doc_no=jl.enqdocno"
		        		  +" left join cr_enqm em on ed.rdocno=em.doc_no left join my_head h on h.doc_no=m.acno"
		        		  +" left join my_acbook ac on ac.cldocno=em.cldocno and ac.dtype='crm'"
		        		  +" left join my_salm sl on ac. sal_id=sl.doc_no left join cr_mode md on ed.modeid=md.doc_no "
		        		  +" left join cr_smode  sm on ed.smodeid=sm.doc_no left join cr_terms tr on ed.termsid=tr.doc_no "
		        		  +" left join  cr_assignment ag on ed.doc_no=ag.rdocno and jl.jobno=ag.jobno left join my_acbook aa on aa.cldocno=ag.agto and aa.dtype='VND' "
		        		  +" and ag.agtype=1 left join my_salesman ss on ss.doc_no=ag.agto and ss.sal_type='STF' and ag.agtype=2 where m.doc_no="+doc+"";
		          param.put("fltquery", fltquery);
		          
		          String invquery="select @i:=@i+1 as srno,d.desc1 description,"
		          		+ " d.qty,format(d.unitprice,2) rate,format(d.nettotal,2) amount "
		          		+ " from rl_prinvd d,(select @i:=0) i where d.rdocno="+doc+""
		          		+ " union all select '' srno,'' description,'' qty,'' rate,''amount union all select '' srno,'' description,'' qty,'' rate,''amount"
		          		+ " union all select '' srno,'' description,'' qty,'' rate,''amount union all select '' srno,'' description,'' qty,'' rate,''amount";
		          String invquery2="select @i:=@i+1 as srno,desc1 description,'' truck,qty,format(unitprice,2) rate,format(nettotal,2) amount from my_srvsaled d,(select @i:=0) i where d.rdocno="+doc+""
			          		+ " union all select '' srno,'' description,'' qty,'' rate,''amount union all select '' srno,'' description,'' qty,'' rate,''amount"
			          		+ " union all select '' srno,'' description,'' qty,'' rate,''amount union all select '' srno,'' description,'' qty,'' rate,''amount";
		          System.out.println("--invquery--:"+invquery);
		          
		          int header=Integer.parseInt(request.getParameter("header"));
		          
		          System.out.println("headerstatus"+header);
		          
		          param.put("invquery", invquery);
		          param.put("branchname", bean.getLblbranch());
		          param.put("branchaddress", bean.getLblbranchaddress());
		          param.put("branchlocation", bean.getLbllocation());
		          param.put("branchtel", bean.getLblbranchtel());
		          param.put("branchfax", bean.getLblbranchfax());
		          param.put("branchtrn", bean.getLblbranchtrno());
		          param.put("invno", bean.getLbldocno());
		          param.put("jobno", bean.getLbljobno());
		          param.put("customerref", bean.getLblcustomerref());
		          param.put("header",request.getParameter("header"));
		          param.put("clienttrn", bean.getLblcltrnno());
		          param.put("clientname", bean.getLblclientname());
		          param.put("clientaddress", bean.getLblclientaddress());
		          param.put("clienttel", bean.getLblclienttel());
		          param.put("clientfax", bean.getLblclientfax());
		          param.put("branchid", brhid);
		          param.put("grossrate", bean.getLblgrossrate());
		          param.put("grossamount", bean.getLblgrossamount());
		          param.put("discrate", bean.getLbldiscount());
		          param.put("discamount", bean.getLbldiscount());
		          
		          param.put("taxablerate", bean.getLbltaxablerate());
		          param.put("taxableamount", bean.getLbltaxableamount());
		          param.put("vatrate", bean.getLblvatamount());
		          param.put("vatamount", bean.getLblvatamount());
		          param.put("netamount", bean.getLblnetamount());
		          param.put("wordsamount", bean.getLblwordsamount());
				  param.put("shipper", bean.getLblshipper());
		          param.put("consignee", bean.getLblconsignee());
		          param.put("mawb", bean.getLblmawb());
		          param.put("hawb", bean.getLblhawb());
		          param.put("flightno", bean.getLblflightno());
		          param.put("cntrno", bean.getLblcontainerno());
		          param.put("qty", bean.getLblshipqty());
		          param.put("grosswt", bean.getLblgrosswt());
		          param.put("boe", bean.getLblboe());
		          param.put("etd", bean.getLbletd());
		          param.put("eta", bean.getLbleta());
		          
		          param.put("ctcperson", bean.getLblctcperson());
		          param.put("email", bean.getLblclientemail());
		          param.put("lpo", bean.getLblinvno());
		          /////AITS header status/////
		          param.put("headers", header);*/
		          /////cargo-end//////
		       // System.out.println("desc"+bean.getLbldesc1()+"pay"+bean.getLblpaytems()+"paytrim"+bean.getLblpaytems()+"del"+ bean.getLbldelterms());
		        //  System.out.println("objcommon.getPrintPath(dtype)=="+objcommon.getPrintPath(dtype));
             JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/realestate/propertyinvoice/"+objcommon.getPrintPath(dtype)));
         	 
              JasperReport jasperReport = JasperCompileManager.compileReport(design);
             generateReportPDF(response, param, jasperReport, conn);
       

   } catch (Exception e) {

       e.printStackTrace();

   }
			 
			 finally{
				 conn.close();
			 }
	   		
	   	}
   	   
		 return "print";
		 }	
	
	
	
	/*	 public void jasperprintAction() throws ParseException, SQLException{
		 System.out.println("jasperrrrrrrr");
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
		    HttpServletResponse response = ServletActionContext.getResponse();
		    
		    int doc=Integer.parseInt(request.getParameter("docno"));
		    String brhid=request.getParameter("brhid").toString();
		    
		   
		    ClsServiceSaleBean bean= new ClsServiceSaleBean(); 
		    bean=purchaseDAO.getPrint(doc,request,session);
			 
			
			 
			 param = new HashMap();
			 Connection conn = null;
			 
			 String reportFileName = "SrvSaleInvoice";
			 							
			 ClsConnection conobj=new ClsConnection();
			 conn = conobj.getMyConnection();
		     
			 try {
		            
	                    
	             
	            
	            
	             
		   
		          
		          String termsquery="select distinct @s:=@s+1 sr_no,rdocno,termsheader terms,m.doc_no, 0 priorno from "
		          		+ " (select distinct  tr.rdocno,termsid from my_trterms tr "
		          		+ "where  tr.dtype='PRIV' and tr.brhid='"+brhid+"' and tr.rdocno="+doc+" and tr.status=3 ) tr "
		          		+ "inner join my_termsm m on(tr.termsid=m.voc_no), (SELECT @s:= 0) AS s where  m.status=3 union all "
		          		+ "select '       *' sr_no ,tr.rdocno,conditions terms,m.doc_no,priorno "
		          		+ " from my_trterms tr left join my_termsm m on(tr.termsid=m.voc_no) where "
		          		+ "   tr.dtype='PRIV' and tr.rdocno="+doc+" and tr.brhid='"+brhid+"' and tr.status=3 and m.status=3  order by doc_no,priorno" ;
		        		  /*"select  @i:=@i+1 as srno,concat(coalesce(m.termsheader,''),' - ',coalesce(t.conditions,'')) terms "
		          		+ " from my_trterms t left join MY_termsm m on m.voc_no=t.termsid"
		          		+ " and t.dtype='PO',(select @i:=0) i     where t.dtype='PO' and t.rdocno="+doc+";";
		          
		      System.out.println("termsqueryyyyyyyyyyy"+termsquery);
		           param.put("termsquery",termsquery);
		           
		           
		          String descQry=" select @i:=@i+1 as srno,a.* from  (select d.srno,d.desc1 description,round(d.unitprice,2) unitprice,"
		          		+ "  round(d.qty) qty,round(d.total,2) total,round(d.discount,2) discount,round(d.nettotal,2) nettotal,d.nuprice "
		        		+ "   from my_srvsaled d  where d.rdocno="+docno+"  ) a,(select @i:=0) r;";
		           
		           
		           
		           
		           
		        
		         param.put("descQry",descQry);
		         
		       //  System.out.println("product++++++++++"+productQuery);
		         String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
		        	imgpath=imgpath.replace("\\", "\\\\");    
		          param.put("imghedderpath", imgpath);
		          
		          
		          String imgpath2=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
		        	imgpath2=imgpath2.replace("\\", "\\\\");    
		          param.put("imgfooterpath", imgpath2);
		          
		          
		      
		          param.put("vendor", bean.getLblacnoname());
		          param.put("attn", bean.getAttn());
		          param.put("tel", bean.getTel());
		          param.put("fax", bean.getFax());
		          param.put("email", bean.getEmail());
		          param.put("docno",doc);
		          param.put("date", bean.getLbldate());
		          param.put("refno", bean.getRefno());
		          param.put("desc", bean.getLbldsc());
		          param.put("payterm", bean.getLblpatms());
		          param.put("delterm", bean.getLbldddtm());
		          param.put("netamount", bean.getLblnettotal());
		          param.put("amountwords", bean.getWordnetamount());
		       // System.out.println("desc"+bean.getLbldesc1()+"pay"+bean.getLblpaytems()+"paytrim"+bean.getLblpaytems()+"del"+ bean.getLbldelterms());
		          
             JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/project/execution/ServiceSale/" + reportFileName + ".jrxml"));
         	 
              JasperReport jasperReport = JasperCompileManager.compileReport(design);
             generateReportPDF(response, param, jasperReport, conn);
       

   } catch (Exception e) {

       e.printStackTrace();

   }
			 
			 finally{
				 conn.close();
			 }
			
		}*/
	
	
		private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException {
			  byte[] bytes = null;
		    bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
		      resp.reset();
		    resp.resetBuffer();
		    
		    resp.setContentType("application/pdf");
		    resp.setContentLength(bytes.length);
		    ServletOutputStream ouputStream = resp.getOutputStream();
		    ouputStream.write(bytes, 0, bytes.length);
		   
		    ouputStream.flush();
		    ouputStream.close();
		   
		         
		}
	
		
		
		
	
}
