package com.finance.transactions.bankpayment;

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
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsBankPaymentAction extends ActionSupport{

	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsBankPaymentDAO bankPayDAO= new ClsBankPaymentDAO();
	ClsBankPaymentBean bankPaymentBean;
	
	private int pdcposttrno;
	private int txtbankpaydocno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String jqxBankPaymentDate;
	private String hidjqxBankPaymentDate;
	private String txtrefno;
	private int txtfromdocno;
	private String txtfromaccid;
	private String txtfromaccname;
	private String cmbfromcurrency;
	private String hidcmbfromcurrency;
	private double txtfromrate;
	private int chckpdc;
	private int hidchckpdc;
	private int txtpdcacno;
	private String txtchequename;
	private String txtchequeno;
	private String jqxChequeDate;
	private String hidjqxChequeDate;
	private double txtfromamount;
	private double txtfrombaseamount;
	private String txtdescription;
	private String cmbtotype;
	private String hidcmbtotype;
	private int txttodocno;
	private int txttotrno;
	private int txttotranid;
	private String txttoaccid;
	private String txttoaccname;
	private String cmbtocurrency;
	private String hidcmbtocurrency;
	private double txttorate;
	private double txttoamount;
	private double txttobaseamount;
	private String hidfromcurrencytype;
	private String hidtocurrencytype;
	
	private double txtapplyinvoiceamt;
	private double txtapplyinvoiceapply;
	private double txtapplyinvoicebalance;
	
	private double txtdrtotal;
	private double txtcrtotal;
	private String bank;
	private String printquery;
	
	private String verifiedappr,	verifybydt,	verifybyat,	approved ,	approvedt ,	approveat;
	public String getVerifiedappr() {
		return verifiedappr;
	}
	public void setVerifiedappr(String verifiedappr) {
		this.verifiedappr = verifiedappr;
	}
	public String getVerifybydt() {
		return verifybydt;
	}
	public void setVerifybydt(String verifybydt) {
		this.verifybydt = verifybydt;
	}
	public String getVerifybyat() {
		return verifybyat;
	}
	public void setVerifybyat(String verifybyat) {
		this.verifybyat = verifybyat;
	}
	public String getApproved() {
		return approved;
	}
	public void setApproved(String approved) {
		this.approved = approved;
	}
	public String getApprovedt() {
		return approvedt;
	}
	public void setApprovedt(String approvedt) {
		this.approvedt = approvedt;
	}
	public String getApproveat() {
		return approveat;
	}
	public void setApproveat(String approveat) {
		this.approveat = approveat;
	}
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}

	private String maindate;
	private String hidmaindate;
	
	private String url;
	
	//Bank Payment Grid
	private int gridlength;
	
	//Apply-Invoicing Grid
	private int applylength;
	
	//Apply-Invoicing Grid Updating
	private int applylengthupdate;
	
	//Print
	private String lblmainname;
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
	private String lblrefno;
	private String lblacno;
	private String lblcomptrn;
	private String lblname;
	private String lblvoucherno;
	private String lbldescription;
	private String lbldate;
	private String lblnetamount;
	private String lblnetamountwords;
	private String lbldebittotal;
	private String lblcredittotal;
	private String lblchqno;
	private String lblchqdate;
	private String lblpreparedby;
	private String lblpreparedon;
	private String lblpreparedat;
	private String lblnetapplied;
	
	//for hide
	private int firstarray;
	private int secarray;
	private int txtheader;
	
	//Cheque Print
	private String lblbankid;
	private String lblbankname;
	private String lblpageheight;
	private String lblpagewidth;
	private String lblpagesheight;
	private String lblpageswidth;
	private String lbldatex;
	private String lbldatey;
	private String lblpaytovertical;
	private String lblpaytohorizontal;
	private String lblpaytolength;
	private String lblaccountpayingx;
	private String lblaccountpayingy;
	private String lblamtwordsvertical;
	private String lblamtwordshorizontal;
	private String lblamtwordslength;
	private String lblamountx;
	private String lblamounty;
	private String lblamtwords1vertical;
	private String lblamtwords1horizontal;
	private String lblamtwords1length;
	
	private String lblchequedate;
	private String lblpaidto;
	private String lblaccountno;
	private String lblamountwords;
	private String lblamountwords1;
	private String lblamount;
	private String brchName;
	private String paidto;
	
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}
	public String getPaidto() {
		return paidto;
	}
	public void setPaidto(String paidto) {
		this.paidto = paidto;
	}

	private String applyquery;
	
	private String printurl;
	
	private Map<String, Object> param=null;
	
	public int getTxtbankpaydocno() {
		return txtbankpaydocno;
	}
	public void setTxtbankpaydocno(int txtbankpaydocno) {
		this.txtbankpaydocno = txtbankpaydocno;
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
	public String getJqxBankPaymentDate() {
		return jqxBankPaymentDate;
	}
	public void setJqxBankPaymentDate(String jqxBankPaymentDate) {
		this.jqxBankPaymentDate = jqxBankPaymentDate;
	}
	public String getHidjqxBankPaymentDate() {
		return hidjqxBankPaymentDate;
	}
	public void setHidjqxBankPaymentDate(String hidjqxBankPaymentDate) {
		this.hidjqxBankPaymentDate = hidjqxBankPaymentDate;
	}
	public String getTxtrefno() {
		return txtrefno;
	}
	public void setTxtrefno(String txtrefno) {
		this.txtrefno = txtrefno;
	}
	public int getTxtfromdocno() {
		return txtfromdocno;
	}
	public void setTxtfromdocno(int txtfromdocno) {
		this.txtfromdocno = txtfromdocno;
	}
	public String getTxtfromaccid() {
		return txtfromaccid;
	}
	public void setTxtfromaccid(String txtfromaccid) {
		this.txtfromaccid = txtfromaccid;
	}
	public String getTxtfromaccname() {
		return txtfromaccname;
	}
	public void setTxtfromaccname(String txtfromaccname) {
		this.txtfromaccname = txtfromaccname;
	}
	public String getCmbfromcurrency() {
		return cmbfromcurrency;
	}
	public void setCmbfromcurrency(String cmbfromcurrency) {
		this.cmbfromcurrency = cmbfromcurrency;
	}
	public String getHidcmbfromcurrency() {
		return hidcmbfromcurrency;
	}
	public void setHidcmbfromcurrency(String hidcmbfromcurrency) {
		this.hidcmbfromcurrency = hidcmbfromcurrency;
	}
	public double getTxtfromrate() {
		return txtfromrate;
	}
	public void setTxtfromrate(double txtfromrate) {
		this.txtfromrate = txtfromrate;
	}
	public int getChckpdc() {
		return chckpdc;
	}
	public void setChckpdc(int chckpdc) {
		this.chckpdc = chckpdc;
	}
	public int getHidchckpdc() {
		return hidchckpdc;
	}
	public void setHidchckpdc(int hidchckpdc) {
		this.hidchckpdc = hidchckpdc;
	}
	public int getTxtpdcacno() {
		return txtpdcacno;
	}
	public void setTxtpdcacno(int txtpdcacno) {
		this.txtpdcacno = txtpdcacno;
	}
	public String getTxtchequename() {
		return txtchequename;
	}
	public void setTxtchequename(String txtchequename) {
		this.txtchequename = txtchequename;
	}
	public String getTxtchequeno() {
		return txtchequeno;
	}
	public void setTxtchequeno(String txtchequeno) {
		this.txtchequeno = txtchequeno;
	}
	public String getJqxChequeDate() {
		return jqxChequeDate;
	}
	public void setJqxChequeDate(String jqxChequeDate) {
		this.jqxChequeDate = jqxChequeDate;
	}
	public String getHidjqxChequeDate() {
		return hidjqxChequeDate;
	}
	public void setHidjqxChequeDate(String hidjqxChequeDate) {
		this.hidjqxChequeDate = hidjqxChequeDate;
	}
	public double getTxtfromamount() {
		return txtfromamount;
	}
	public void setTxtfromamount(double txtfromamount) {
		this.txtfromamount = txtfromamount;
	}
	public double getTxtfrombaseamount() {
		return txtfrombaseamount;
	}
	public void setTxtfrombaseamount(double txtfrombaseamount) {
		this.txtfrombaseamount = txtfrombaseamount;
	}
	public String getTxtdescription() {
		return txtdescription;
	}
	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}
	public String getCmbtotype() {
		return cmbtotype;
	}
	public void setCmbtotype(String cmbtotype) {
		this.cmbtotype = cmbtotype;
	}
	public String getHidcmbtotype() {
		return hidcmbtotype;
	}
	public void setHidcmbtotype(String hidcmbtotype) {
		this.hidcmbtotype = hidcmbtotype;
	}
	public int getTxttodocno() {
		return txttodocno;
	}
	public void setTxttodocno(int txttodocno) {
		this.txttodocno = txttodocno;
	}
	public int getTxttotrno() {
		return txttotrno;
	}
	public void setTxttotrno(int txttotrno) {
		this.txttotrno = txttotrno;
	}
	public int getTxttotranid() {
		return txttotranid;
	}
	public void setTxttotranid(int txttotranid) {
		this.txttotranid = txttotranid;
	}
	public String getTxttoaccid() {
		return txttoaccid;
	}
	public void setTxttoaccid(String txttoaccid) {
		this.txttoaccid = txttoaccid;
	}
	public String getTxttoaccname() {
		return txttoaccname;
	}
	public void setTxttoaccname(String txttoaccname) {
		this.txttoaccname = txttoaccname;
	}
	public String getCmbtocurrency() {
		return cmbtocurrency;
	}
	public void setCmbtocurrency(String cmbtocurrency) {
		this.cmbtocurrency = cmbtocurrency;
	}
	public String getHidcmbtocurrency() {
		return hidcmbtocurrency;
	}
	public void setHidcmbtocurrency(String hidcmbtocurrency) {
		this.hidcmbtocurrency = hidcmbtocurrency;
	}
	public double getTxttorate() {
		return txttorate;
	}
	public void setTxttorate(double txttorate) {
		this.txttorate = txttorate;
	}
	public double getTxttoamount() {
		return txttoamount;
	}
	public void setTxttoamount(double txttoamount) {
		this.txttoamount = txttoamount;
	}
	public double getTxttobaseamount() {
		return txttobaseamount;
	}
	public void setTxttobaseamount(double txttobaseamount) {
		this.txttobaseamount = txttobaseamount;
	}
	public String getHidfromcurrencytype() {
		return hidfromcurrencytype;
	}
	public void setHidfromcurrencytype(String hidfromcurrencytype) {
		this.hidfromcurrencytype = hidfromcurrencytype;
	}
	public String getHidtocurrencytype() {
		return hidtocurrencytype;
	}
	public void setHidtocurrencytype(String hidtocurrencytype) {
		this.hidtocurrencytype = hidtocurrencytype;
	}
	public double getTxtapplyinvoiceamt() {
		return txtapplyinvoiceamt;
	}
	public void setTxtapplyinvoiceamt(double txtapplyinvoiceamt) {
		this.txtapplyinvoiceamt = txtapplyinvoiceamt;
	}
	public double getTxtapplyinvoiceapply() {
		return txtapplyinvoiceapply;
	}
	public void setTxtapplyinvoiceapply(double txtapplyinvoiceapply) {
		this.txtapplyinvoiceapply = txtapplyinvoiceapply;
	}
	public double getTxtapplyinvoicebalance() {
		return txtapplyinvoicebalance;
	}
	public void setTxtapplyinvoicebalance(double txtapplyinvoicebalance) {
		this.txtapplyinvoicebalance = txtapplyinvoicebalance;
	}
	public double getTxtdrtotal() {
		return txtdrtotal;
	}
	public void setTxtdrtotal(double txtdrtotal) {
		this.txtdrtotal = txtdrtotal;
	}
	public double getTxtcrtotal() {
		return txtcrtotal;
	}
	public void setTxtcrtotal(double txtcrtotal) {
		this.txtcrtotal = txtcrtotal;
	}
	public String getMaindate() {
		return maindate;
	}
	public void setMaindate(String maindate) {
		this.maindate = maindate;
	}
	public String getHidmaindate() {
		return hidmaindate;
	}
	public void setHidmaindate(String hidmaindate) {
		this.hidmaindate = hidmaindate;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	public int getApplylength() {
		return applylength;
	}
	public void setApplylength(int applylength) {
		this.applylength = applylength;
	}
	public int getApplylengthupdate() {
		return applylengthupdate;
	}
	public void setApplylengthupdate(int applylengthupdate) {
		this.applylengthupdate = applylengthupdate;
	}
	
	public String getLblcomptrn() {
		return lblcomptrn;
	}
	public void setLblcomptrn(String lblcomptrn) {
		this.lblcomptrn = lblcomptrn;
	}
	
	
	public String getLblmainname() {
		return lblmainname;
	}
	public void setLblmainname(String lblmainname) {
		this.lblmainname = lblmainname;
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
	public String getLblname() {
		return lblname;
	}
	public void setLblname(String lblname) {
		this.lblname = lblname;
	}
	public String getLblvoucherno() {
		return lblvoucherno;
	}
	public void setLblvoucherno(String lblvoucherno) {
		this.lblvoucherno = lblvoucherno;
	}
	public String getLbldescription() {
		return lbldescription;
	}
	public void setLbldescription(String lbldescription) {
		this.lbldescription = lbldescription;
	}
	public String getLbldate() {
		return lbldate;
	}
	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}
	public String getLblnetamount() {
		return lblnetamount;
	}
	public void setLblnetamount(String lblnetamount) {
		this.lblnetamount = lblnetamount;
	}
	public String getLblnetamountwords() {
		return lblnetamountwords;
	}
	public void setLblnetamountwords(String lblnetamountwords) {
		this.lblnetamountwords = lblnetamountwords;
	}
	public String getLbldebittotal() {
		return lbldebittotal;
	}
	public void setLbldebittotal(String lbldebittotal) {
		this.lbldebittotal = lbldebittotal;
	}
	public String getLblcredittotal() {
		return lblcredittotal;
	}
	public void setLblcredittotal(String lblcredittotal) {
		this.lblcredittotal = lblcredittotal;
	}
	public String getLblchqno() {
		return lblchqno;
	}
	public void setLblchqno(String lblchqno) {
		this.lblchqno = lblchqno;
	}
	public String getLblchqdate() {
		return lblchqdate;
	}
	public void setLblchqdate(String lblchqdate) {
		this.lblchqdate = lblchqdate;
	}
	public String getLblpreparedby() {
		return lblpreparedby;
	}
	public void setLblpreparedby(String lblpreparedby) {
		this.lblpreparedby = lblpreparedby;
	}
	public String getLblpreparedon() {
		return lblpreparedon;
	}
	public void setLblpreparedon(String lblpreparedon) {
		this.lblpreparedon = lblpreparedon;
	}
	public String getLblpreparedat() {
		return lblpreparedat;
	}
	public void setLblpreparedat(String lblpreparedat) {
		this.lblpreparedat = lblpreparedat;
	}
	public String getLblnetapplied() {
		return lblnetapplied;
	}
	public void setLblnetapplied(String lblnetapplied) {
		this.lblnetapplied = lblnetapplied;
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
	public String getLblbankid() {
		return lblbankid;
	}
	public void setLblbankid(String lblbankid) {
		this.lblbankid = lblbankid;
	}
	public String getLblbankname() {
		return lblbankname;
	}
	public void setLblbankname(String lblbankname) {
		this.lblbankname = lblbankname;
	}
	public String getLblpageheight() {
		return lblpageheight;
	}
	public void setLblpageheight(String lblpageheight) {
		this.lblpageheight = lblpageheight;
	}
	public String getLblpagewidth() {
		return lblpagewidth;
	}
	public void setLblpagewidth(String lblpagewidth) {
		this.lblpagewidth = lblpagewidth;
	}
	public String getLblpagesheight() {
		return lblpagesheight;
	}
	public void setLblpagesheight(String lblpagesheight) {
		this.lblpagesheight = lblpagesheight;
	}
	public String getLblpageswidth() {
		return lblpageswidth;
	}
	public void setLblpageswidth(String lblpageswidth) {
		this.lblpageswidth = lblpageswidth;
	}
	public String getLbldatex() {
		return lbldatex;
	}
	public void setLbldatex(String lbldatex) {
		this.lbldatex = lbldatex;
	}
	public String getLbldatey() {
		return lbldatey;
	}
	public void setLbldatey(String lbldatey) {
		this.lbldatey = lbldatey;
	}
	public String getLblpaytovertical() {
		return lblpaytovertical;
	}
	public void setLblpaytovertical(String lblpaytovertical) {
		this.lblpaytovertical = lblpaytovertical;
	}
	public String getLblpaytohorizontal() {
		return lblpaytohorizontal;
	}
	public void setLblpaytohorizontal(String lblpaytohorizontal) {
		this.lblpaytohorizontal = lblpaytohorizontal;
	}
	public String getLblpaytolength() {
		return lblpaytolength;
	}
	public void setLblpaytolength(String lblpaytolength) {
		this.lblpaytolength = lblpaytolength;
	}
	public String getLblaccountpayingx() {
		return lblaccountpayingx;
	}
	public void setLblaccountpayingx(String lblaccountpayingx) {
		this.lblaccountpayingx = lblaccountpayingx;
	}
	public String getLblaccountpayingy() {
		return lblaccountpayingy;
	}
	public void setLblaccountpayingy(String lblaccountpayingy) {
		this.lblaccountpayingy = lblaccountpayingy;
	}
	public String getLblamtwordsvertical() {
		return lblamtwordsvertical;
	}
	public void setLblamtwordsvertical(String lblamtwordsvertical) {
		this.lblamtwordsvertical = lblamtwordsvertical;
	}
	public String getLblamtwordshorizontal() {
		return lblamtwordshorizontal;
	}
	public void setLblamtwordshorizontal(String lblamtwordshorizontal) {
		this.lblamtwordshorizontal = lblamtwordshorizontal;
	}
	public String getLblamtwordslength() {
		return lblamtwordslength;
	}
	public void setLblamtwordslength(String lblamtwordslength) {
		this.lblamtwordslength = lblamtwordslength;
	}
	public String getLblamountx() {
		return lblamountx;
	}
	public void setLblamountx(String lblamountx) {
		this.lblamountx = lblamountx;
	}
	public String getLblamounty() {
		return lblamounty;
	}
	public void setLblamounty(String lblamounty) {
		this.lblamounty = lblamounty;
	}
	public String getLblamtwords1vertical() {
		return lblamtwords1vertical;
	}
	public void setLblamtwords1vertical(String lblamtwords1vertical) {
		this.lblamtwords1vertical = lblamtwords1vertical;
	}
	public String getLblamtwords1horizontal() {
		return lblamtwords1horizontal;
	}
	public void setLblamtwords1horizontal(String lblamtwords1horizontal) {
		this.lblamtwords1horizontal = lblamtwords1horizontal;
	}
	public String getLblamtwords1length() {
		return lblamtwords1length;
	}
	public void setLblamtwords1length(String lblamtwords1length) {
		this.lblamtwords1length = lblamtwords1length;
	}
	public String getLblchequedate() {
		return lblchequedate;
	}
	public void setLblchequedate(String lblchequedate) {
		this.lblchequedate = lblchequedate;
	}
	public String getLblpaidto() {
		return lblpaidto;
	}
	public void setLblpaidto(String lblpaidto) {
		this.lblpaidto = lblpaidto;
	}
	public String getLblaccountno() {
		return lblaccountno;
	}
	public void setLblaccountno(String lblaccountno) {
		this.lblaccountno = lblaccountno;
	}
	public String getLblamountwords() {
		return lblamountwords;
	}
	public void setLblamountwords(String lblamountwords) {
		this.lblamountwords = lblamountwords;
	}
	public String getLblamountwords1() {
		return lblamountwords1;
	}
	public void setLblamountwords1(String lblamountwords1) {
		this.lblamountwords1 = lblamountwords1;
	}
	public String getLblamount() {
		return lblamount;
	}
	public void setLblamount(String lblamount) {
		this.lblamount = lblamount;
	}
	public String getApplyquery() {
		return applyquery;
	}
	public void setApplyquery(String applyquery) {
		this.applyquery = applyquery;
	}
	public String getPrinturl() {
		return printurl;
	}
	public void setPrinturl(String printurl) {
		this.printurl = printurl;
	}
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	public String getLblrefno() {
		return lblrefno;
	}
	public void setLblrefno(String lblrefno) {
		this.lblrefno = lblrefno;
	}
	public String getPrintquery() {
		return printquery;
	}
	public void setPrintquery(String printquery) {
		this.printquery = printquery;
	}
	public String getLblacno() {
		return lblacno;
	}
	public void setLblacno(String lblacno) {
		this.lblacno = lblacno;
	}
	java.sql.Date bankPaymentDate;
	java.sql.Date chequeDate;
	java.sql.Date hidbankPaymentDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		session.setAttribute("BRANCHID", getBrchName());
		//System.out.println(getBrchName());
		String mode=getMode();
		ClsBankPaymentBean bean = new ClsBankPaymentBean();
		
		bankPaymentDate = commonDAO.changeStringtoSqlDate(getJqxBankPaymentDate());
		chequeDate = commonDAO.changeStringtoSqlDate(getJqxChequeDate());
		hidbankPaymentDate = commonDAO.changeStringtoSqlDate(getMaindate());
		
		if(mode.equalsIgnoreCase("A")){
			Connection conn = null;
			
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			
			/*Bank Payment Grid Saving*/
			ArrayList bankpaymentarray= new ArrayList();
			bankpaymentarray.add(getTxtfromdocno()+"::"+getCmbfromcurrency()+"::"+getTxtfromrate()+"::false::"+getTxtfromamount()*-1+"::"+getTxtdescription()+"::"+getTxtfrombaseamount()*-1+"::0::0::0::"+getHidchckpdc()+"::"+getTxtpdcacno());
			bankpaymentarray.add(getTxttodocno()+"::"+getCmbtocurrency()+"::"+getTxttorate()+"::true::"+getTxttoamount()+"::"+getTxtdescription()+"::"+getTxttobaseamount()+"::"+getTxtapplyinvoiceapply()+"::0::0::"+getHidchckpdc()+"::"+getTxtpdcacno());
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				bankpaymentarray.add(temp+"::"+getHidchckpdc()+"::"+getTxtpdcacno());
			}
			/*Bank Payment Grid Saving Ends*/
			
			/*Apply-Bank Invoice Grid Saving*/
			ArrayList applyinvoicearray= new ArrayList();
			for(int i=0;i<getApplylength();i++){
				String applytemp=requestParams.get("txtapply"+i)[0];
				applyinvoicearray.add(applytemp);
			}
			/*Apply-Bank Invoice Grid Saving Ends*/
						// setHidchckpdc(1);
						int val=bankPayDAO.insert(conn,bankPaymentDate,getFormdetailcode(),getTxtrefno(),getTxtfromrate(),chequeDate,getTxtchequeno(),getTxtchequename(),getHidchckpdc(),getTxtdescription(),getTxtdrtotal(),getTxttodocno(),getTxtapplyinvoiceapply(),bankpaymentarray,applyinvoicearray,session,request,mode);
						if(val>0.0){

							setTxtbankpaydocno(val);
							setTxttotrno(Integer.parseInt(request.getAttribute("tranno").toString()));
							setData();
							conn.commit();
							conn.close();
							setMsg("Successfully Saved");
							return "success";
						}
						else{
							setData();
							conn.close();
							setMsg("Not Saved");
							return "fail";
						}	
		}
		
		else if(mode.equalsIgnoreCase("EDIT")){
			/*Updating Bank Payment Grid*/
			ArrayList bankpaymentarray= new ArrayList();
			bankpaymentarray.add(getTxtfromdocno()+"::"+getCmbfromcurrency()+"::"+getTxtfromrate()+"::false::"+getTxtfromamount()*-1+"::"+getTxtdescription()+"::"+getTxtfrombaseamount()*-1+"::0::0::0::"+getHidchckpdc()+"::"+getTxtpdcacno());
			bankpaymentarray.add(getTxttodocno()+"::"+getCmbtocurrency()+"::"+getTxttorate()+"::true::"+getTxttoamount()+"::"+getTxtdescription()+"::"+getTxttobaseamount()+"::"+getTxtapplyinvoiceapply()+"::0::0::"+getHidchckpdc()+"::"+getTxtpdcacno());
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				bankpaymentarray.add(temp+"::"+getHidchckpdc()+"::"+getTxtpdcacno());
			}
			/*Updating Bank Payment Grid Ends*/
			
			/*Apply-Invoice Grid Saving*/
			ArrayList applyinvoicearray= new ArrayList();
			for(int i=0;i<getApplylength();i++){
				String applytemp=requestParams.get("txtapply"+i)[0];
				applyinvoicearray.add(applytemp);
			}
			/*Apply-Invoice Grid Saving Ends*/
			
			/*Apply-Invoice Grid Updating*/
			ArrayList applyinvoiceupdatearray= new ArrayList();
			for(int i=0;i<getApplylengthupdate();i++){
				String applyupdatetemp=requestParams.get("txtapplyupdate"+i)[0];
				applyinvoiceupdatearray.add(applyupdatetemp);
			}
			/*Apply-Invoice Grid Updating Ends*/
			
			boolean Status=bankPayDAO.edit(getTxtbankpaydocno(),getFormdetailcode(),bankPaymentDate,getTxtrefno(),getTxtdescription(),getTxtfromrate(),getTxtdrtotal(),getTxttodocno(),getTxttotrno(),chequeDate,getTxtchequeno(),getTxtchequename(),getHidchckpdc(),getTxtapplyinvoiceapply(),bankpaymentarray,applyinvoicearray,applyinvoiceupdatearray,session,mode);
			if(Status){
				
				setTxtbankpaydocno(getTxtbankpaydocno());
				setTxttotrno(getTxttotrno());
				setData();
				
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setTxtbankpaydocno(getTxtbankpaydocno());
				setTxttotrno(getTxttotrno());
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("E")){

			boolean Status=bankPayDAO.editMaster(getTxtbankpaydocno(),getFormdetailcode(),bankPaymentDate,getTxtrefno(),getTxtdescription(),getTxtfromrate(),getTxtdrtotal(),getTxttodocno(),getTxttotrno(),session);
			if(Status){
				
				setTxtbankpaydocno(getTxtbankpaydocno());
				setTxttotrno(getTxttotrno());
				setData();
				
				setMsg("Updated Successfully");
			    return "success";
		}
		else{
			setTxtbankpaydocno(getTxtbankpaydocno());
			setTxttotrno(getTxttotrno());
			setData();
			setMsg("Not Updated");
			return "fail";
		}
	  }
		
		
		else if(mode.equalsIgnoreCase("D")){
			
			boolean Status=bankPayDAO.delete(getTxtbankpaydocno(),getFormdetailcode(),getTxttodocno(),getTxttotrno(),session);
			if(Status){
				
				setTxtbankpaydocno(getTxtbankpaydocno());
				setTxttotrno(getTxttotrno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setTxtbankpaydocno(getTxtbankpaydocno());
				setTxttotrno(getTxttotrno());
				setData();
				setMsg("Not Deleted");
				return "fail";
			   }
			}
		
		else if(mode.equalsIgnoreCase("View")){
			String branch=null;
			bankPaymentBean=bankPayDAO.getViewDetails(session,getTxtbankpaydocno());
			
			setJqxBankPaymentDate(bankPaymentBean.getJqxBankPaymentDate());
			setTxtrefno(bankPaymentBean.getTxtrefno());
			
			setTxtfromdocno(bankPaymentBean.getTxtfromdocno());
			setTxtfromaccid(bankPaymentBean.getTxtfromaccid());
			setTxtfromaccname(bankPaymentBean.getTxtfromaccname());
			setHidcmbfromcurrency(bankPaymentBean.getHidcmbfromcurrency());
			setHidfromcurrencytype(bankPaymentBean.getHidfromcurrencytype());
			setTxtfromrate(bankPaymentBean.getTxtfromrate());
			setHidchckpdc(bankPaymentBean.getChckpdc());
			setTxtpdcacno(bankPaymentBean.getTxtpdcacno());
			setTxtchequeno(bankPaymentBean.getTxtchequeno());
			setJqxChequeDate(bankPaymentBean.getJqxChequeDate());
			setTxtchequename(bankPaymentBean.getTxtchequename());
			setTxtfromamount(bankPaymentBean.getTxtfromamount());
			setTxtfrombaseamount(bankPaymentBean.getTxtfrombaseamount());
			setTxtdescription(bankPaymentBean.getTxtdescription());
			
			setTxttodocno(bankPaymentBean.getTxttodocno());
			setTxttotranid(bankPaymentBean.getTxttotranid());
			setTxttotrno(bankPaymentBean.getTxttotrno());
			setHidcmbtotype(bankPaymentBean.getHidcmbtotype());
			setTxttoaccid(bankPaymentBean.getTxttoaccid());
			setTxttoaccname(bankPaymentBean.getTxttoaccname());
			setHidcmbtocurrency(bankPaymentBean.getHidcmbtocurrency());
			setHidtocurrencytype(bankPaymentBean.getHidtocurrencytype());
			setTxttorate(bankPaymentBean.getTxttorate());
			setTxttoamount(bankPaymentBean.getTxttoamount());
			setTxttobaseamount(bankPaymentBean.getTxttobaseamount());
			setTxtapplyinvoiceamt(bankPaymentBean.getTxtapplyinvoiceamt());
			setTxtapplyinvoiceapply(bankPaymentBean.getTxtapplyinvoiceapply());
			setTxtapplyinvoicebalance((bankPaymentBean.getTxtapplyinvoicebalance()));
			
			setTxtdrtotal(bankPaymentBean.getTxtdrtotal());
			setTxtcrtotal(bankPaymentBean.getTxtcrtotal());
			setMaindate(bankPaymentBean.getMaindate());
			setFormdetailcode(bankPaymentBean.getFormdetailcode());
			setPdcposttrno(bankPaymentBean.getPdcposttrno());
			return "success";
		}
		return "fail";
}
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		int docno=Integer.parseInt(request.getParameter("docno"));
		int header=Integer.parseInt(request.getParameter("header"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		bankPaymentBean=bankPayDAO.getPrint(request,docno,branch,header);
		System.out.println("printactionn");
		
		setLblmainname("Paid To");
		setUrl(commonDAO.getPrintPath("BPV"));
		setLblcompname(bankPaymentBean.getLblcompname());
		setLblcomptrn(bankPaymentBean.getLblcomptrn());
		setLblcompaddress(bankPaymentBean.getLblcompaddress());
		setLblpobox(bankPaymentBean.getLblpobox());
		setLblprintname(bankPaymentBean.getLblprintname());
		setLblcomptel(bankPaymentBean.getLblcomptel());
		setLblcompfax(bankPaymentBean.getLblcompfax());
		setLblbranch(bankPaymentBean.getLblbranch());
		setLbllocation(bankPaymentBean.getLbllocation());
		setLblservicetax(bankPaymentBean.getLblservicetax());
		setLblpan(bankPaymentBean.getLblpan());
		setLblcstno(bankPaymentBean.getLblcstno());
		setLblname(bankPaymentBean.getLblname());
		setLblvoucherno(bankPaymentBean.getLblvoucherno());
		setLbldescription(bankPaymentBean.getLbldescription());
		setLbldate(bankPaymentBean.getLbldate());
		setLblnetamount(bankPaymentBean.getLblnetamount());
		setLblnetamountwords(bankPaymentBean.getLblnetamountwords());
		setLbldebittotal(bankPaymentBean.getLbldebittotal());
		setLblcredittotal(bankPaymentBean.getLblcredittotal());
		setLblchqno(bankPaymentBean.getLblchqno());
		setLblchqdate(bankPaymentBean.getLblchqdate());
		setLblpreparedby(bankPaymentBean.getLblpreparedby());
		setLblpreparedon(bankPaymentBean.getLblpreparedon());
		setLblpreparedat(bankPaymentBean.getLblpreparedat());
		setPaidto(bankPaymentBean.getPaidto());
		System.out.println("paidtooooooooo"+bankPaymentBean.getLblpaidto());
		setBank(bankPaymentBean.getBank());

		
		setVerifiedappr(bankPaymentBean.getVerifiedappr());
		setVerifybyat(bankPaymentBean.getVerifybyat());
		setVerifybydt(bankPaymentBean.getVerifybydt());
		setApproved(bankPaymentBean.getApproved());
		setApprovedt(bankPaymentBean.getApprovedt());
		setApproveat(bankPaymentBean.getApproveat());
		// for hide
		setFirstarray(bankPaymentBean.getFirstarray());
		setSecarray(bankPaymentBean.getSecarray());
		setTxtheader(bankPaymentBean.getTxtheader());
		
		if(commonDAO.getPrintPath("BPV").contains(".jrxml"));
		{
			System.out.println("printpath");
			HttpServletResponse response = ServletActionContext.getResponse();
			
			 param = new HashMap();
			 Connection conn = null;
			 
			 try {
				
             	conn = connDAO.getMyConnection();
				 
             	String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
               	imgpath=imgpath.replace("\\", "\\\\");
              	
               	String imgheaderpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
               	imgheaderpath=imgheaderpath.replace("\\", "\\\\");    
	          
	            String imgpath2=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
	        	imgpath2=imgpath2.replace("\\", "\\\\");    
	      
	        	 if(branch==1)
		          {
		        	  String imgpath1=request.getSession().getServletContext().getRealPath("/icons/IGLOGO.jpg");
			        	 imgpath1=imgpath1.replace("\\", "\\\\");
			        	 param.put("cmplogo", imgpath1);
		          }
		          else if(branch==2)
		          {
		        	  String imgpath3=request.getSession().getServletContext().getRealPath("/icons/IGLOGO1.jpg");
			        	 imgpath3=imgpath3.replace("\\", "\\\\");
			        	 param.put("cmplogo", imgpath3);
		          }
		           else if(branch==3)
		          {
		        	  String imgpath3=request.getSession().getServletContext().getRealPath("/icons/IGLOGO3.jpg");
			        	 imgpath3=imgpath3.replace("\\", "\\\\");
			        	 param.put("cmplogo", imgpath3);
		          }
		          if(branch==4)
		          {
		        	  String imgpath3=request.getSession().getServletContext().getRealPath("/icons/IGLOGO4.jpg");
			        	 imgpath3=imgpath3.replace("\\", "\\\\");
			        	 param.put("cmplogo", imgpath3);
		          }
		         
               	 param.put("header", new Integer(header));
		         param.put("imgpath", imgpath);
		     	 param.put("imghedderpath", imgheaderpath);
		     	 param.put("imgfooterpath", imgpath2);
		         param.put("compname", bankPaymentBean.getLblcompname());
		         param.put("compaddress", bankPaymentBean.getLblcompaddress());
		        
		         param.put("comptel", bankPaymentBean.getLblcomptel());
		         param.put("compfax", bankPaymentBean.getLblcompfax());
		         param.put("compbranch", bankPaymentBean.getLblbranch());
		         param.put("location", bankPaymentBean.getLbllocation());
	        	 param.put("doc", new Integer(docno));
		         param.put("brch", new Integer(branch));
		        
		         param.put("printname", bankPaymentBean.getLblprintname());  
		         param.put("name", bankPaymentBean.getLblname());
		         param.put("vno", bankPaymentBean.getLblvoucherno());
		         param.put("descp", bankPaymentBean.getLbldescription());
		         param.put("vdate", bankPaymentBean.getLbldate());
		         param.put("chqno", bankPaymentBean.getLblchqno());
		         param.put("chqdat", bankPaymentBean.getLblchqdate());
		         param.put("amtword", bankPaymentBean.getLblnetamountwords());
		         param.put("amt", bankPaymentBean.getLblnetamount());
		         param.put("bankname", bankPaymentBean.getBank());
		         
		         param.put("debtot", bankPaymentBean.getLbldebittotal());
		         param.put("credtot", bankPaymentBean.getLblcredittotal());
		         param.put("appliedapplyingtot", bankPaymentBean.getLblnetapplied());
		         param.put("paidto", bankPaymentBean.getPaidto());
		         param.put("bank", bankPaymentBean.getBank());
		         
		         
		         param.put("prepby", bankPaymentBean.getLblpreparedby());
		         param.put("prepon", bankPaymentBean.getLblpreparedon());
		         param.put("prepat", bankPaymentBean.getLblpreparedat());
		         
		         param.put("printby", session.getAttribute("USERNAME").toString());
		     	 param.put("sql2",bankPaymentBean.getApplyquery()==null?"":bankPaymentBean.getApplyquery());
		     	
		     	 String path[]=commonDAO.getPrintPath("BPV").split("bankpayment/");
			     setUrl(path[1]);
		    
		         JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(commonDAO.getPrintPath("BPV")));
	     	 
	     	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
	                       generateReportPDF(response, param, jasperReport, conn);
	                 
	      
	             } catch (Exception e) {
	                 e.printStackTrace();
	             }
	            	 
	            finally{
	            	conn.close();
	            }	  	 
		}

/*

 
 //bnk payment print from trading
 
	if(commonDAO.getPrintPath("BPV").contains(".jrxml"));
			{
				HttpServletResponse response = ServletActionContext.getResponse();
				
				 param = new HashMap();
	Connection conn = null;
				 try {
			          
		           	int trno=0;
					int acno=0;
					int srno=0;
					String sql2="";
		             	 conn = connDAO.getMyConnection();
		             
		            
		               	
		                String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
			        	imgpath=imgpath.replace("\\", "\\\\");    
			          param.put("imghedderpath", imgpath);
			          
			          
			          String imgpath2=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
			        	imgpath2=imgpath2.replace("\\", "\\\\");    
			          param.put("imgfooterpath", imgpath2);
			          
		               	
		               	param.put("header", new Integer(header));
				        param.put("imgpath", imgpath);
				    //     System.out.println("hearerrrrrr"+param);
				         param.put("compname", bankPaymentBean.getLblcompname());
				         param.put("compaddress", bankPaymentBean.getLblcompaddress());
				        
				         param.put("comptel", bankPaymentBean.getLblcomptel());
				         param.put("compfax", bankPaymentBean.getLblcompfax());
				         param.put("compbranch", bankPaymentBean.getLblbranch());
				         param.put("location", bankPaymentBean.getLbllocation());
		        	 param.put("doc", new Integer(docno));
			         param.put("brch", new Integer(branch));
			        
			         param.put("printname", bankPaymentBean.getLblprintname());  
			         param.put("name", bankPaymentBean.getLblname());
			         
			         param.put("paidto", bankPaymentBean.getPaidTo());
			         param.put("bank", bankPaymentBean.getBank());
			         param.put("vno", bankPaymentBean.getLblvoucherno());
			         param.put("descp", bankPaymentBean.getLbldescription());
			         param.put("vdate", bankPaymentBean.getLbldate());
			         param.put("chqno", bankPaymentBean.getLblchqno());
			         param.put("chqdat", bankPaymentBean.getLblchqdate());
			         param.put("amtword", bankPaymentBean.getLblnetamountwords());
			         param.put("amt", bankPaymentBean.getLblnetamount());
			         
			         param.put("debtot", bankPaymentBean.getLbldebittotal());
			         param.put("credtot", bankPaymentBean.getLblcredittotal());
			         
			         
			         param.put("prepby", bankPaymentBean.getLblpreparedby());
			         param.put("prepon", bankPaymentBean.getLblpreparedon());
			         param.put("prepat", bankPaymentBean.getLblpreparedat());
			         
			         param.put("printby", session.getAttribute("USERNAME").toString());
			     	param.put("sql2",bankPaymentBean.getApplyquery()==null?"":bankPaymentBean.getApplyquery());
			     	
			     //	System.out.println("param==="+param);
			     	 String path[]=commonDAO.getPrintPath("BPV").split("bankpayment/");
				        setUrl(path[1]);
			    
			         JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(commonDAO.getPrintPath("BPV")));
		     	 
		     	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
		                       generateReportPDF(response, param, jasperReport, conn);
		                 
		      
		             } catch (Exception e) {

		                 e.printStackTrace();
		             }
		            	 
		            finally{
				conn.close();
			}	  	 
			}*/

	
	return "print";
	}
	
	public String printChequeAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		int docno=Integer.parseInt(request.getParameter("docno"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		bankPaymentBean=bankPayDAO.getChequePrint(docno,branch);
		setLblbankid(bankPaymentBean.getLblbankid());
		setLblbankname(bankPaymentBean.getLblbankname());
		setLblpageswidth(bankPaymentBean.getLblpageswidth());
		setLblpagesheight(bankPaymentBean.getLblpagesheight());
		setLblpagewidth(bankPaymentBean.getLblpagewidth());
		setLblpageheight(bankPaymentBean.getLblpageheight());
		setLbldatex(bankPaymentBean.getLbldatex());
		setLbldatey(bankPaymentBean.getLbldatey());
		setLblpaytovertical(bankPaymentBean.getLblpaytovertical());
		setLblpaytohorizontal(bankPaymentBean.getLblpaytohorizontal());
		setLblpaytolength(bankPaymentBean.getLblpaytolength());
		setLblaccountpayingx(bankPaymentBean.getLblaccountpayingx());
		setLblaccountpayingy(bankPaymentBean.getLblaccountpayingy());
		setLblamtwordsvertical(bankPaymentBean.getLblamtwordsvertical());
		setLblamtwordshorizontal(bankPaymentBean.getLblamtwordshorizontal());
		setLblamtwordslength(bankPaymentBean.getLblamtwordslength());
		setLblamountx(bankPaymentBean.getLblamountx());
		setLblamounty(bankPaymentBean.getLblamounty());
		setLblamtwords1vertical(bankPaymentBean.getLblamtwords1vertical());
		setLblamtwords1horizontal(bankPaymentBean.getLblamtwords1horizontal());
		setLblamtwords1length(bankPaymentBean.getLblamtwords1length());
		
		setLblchequedate(bankPaymentBean.getLblchequedate());
		setLblpaidto(bankPaymentBean.getLblpaidto());
		
		setLblaccountno(bankPaymentBean.getLblaccountno());
		setLblamountwords(bankPaymentBean.getLblamountwords());
		setLblamountwords1(bankPaymentBean.getLblamountwords1());
		setLblamount(bankPaymentBean.getLblamount());
		setPrinturl(bankPaymentBean.getPrinturl());
		setLbldate(bankPaymentBean.getLbldate());
	    setLblvoucherno(bankPaymentBean.getLblvoucherno());
		System.out.println(getPrinturl());
		if(getPrinturl().contains(".jrxml")) {
			Connection conn = null;
			
			try {
				 conn = connDAO.getMyConnection();
				 param = new HashMap();
            
				 param.put("date", bankPaymentBean.getLblchequedate());
				 param.put("payto", bankPaymentBean.getLblpaidto());
				 param.put("amountinwords", bankPaymentBean.getLblamountwords()+" "+(bankPaymentBean.getLblamountwords1()==null?" ":bankPaymentBean.getLblamountwords1()));
				 System.out.println(bankPaymentBean.getLblamountwords()+" "+(bankPaymentBean.getLblamountwords1()==null?" ":bankPaymentBean.getLblamountwords1()));
				 param.put("amount", "#"+bankPaymentBean.getLblamount()+"#");
				 param.put("chqno", bankPaymentBean.getLblchqno());
				 param.put("paydocdate",bankPaymentBean.getLbldate());
				 param.put("paydocno", bankPaymentBean.getLblvoucherno());
				 JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(getPrinturl()));
				 JasperReport jasperReport = JasperCompileManager.compileReport(design);
				 generateReportPDF(response, param, jasperReport, conn);

			} catch (Exception e) {
	              e.printStackTrace();
	              conn.close();
	      	} finally{
	      		conn.close();
	      	}
            
		}
		
	return "print";
	}
	
	public String paymentprintAction() throws ParseException, SQLException{
		String imgpath="";
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		int docno=Integer.parseInt(request.getParameter("docno"));
		int header=Integer.parseInt(request.getParameter("header"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		bankPaymentBean=bankPayDAO.getPrint(request,docno,branch,header);
		
		setLblmainname("Paid To");
		setUrl(commonDAO.getPrintPath("BPV"));
		setLblcompname(bankPaymentBean.getLblcompname());
		setLblcomptrn(bankPaymentBean.getLblcomptrn());
		setLblcompaddress(bankPaymentBean.getLblcompaddress());
		setLblpobox(bankPaymentBean.getLblpobox());
		setLblprintname(bankPaymentBean.getLblprintname());
		setLblcomptel(bankPaymentBean.getLblcomptel());
		setLblcompfax(bankPaymentBean.getLblcompfax());
		setLblbranch(bankPaymentBean.getLblbranch());
		setLbllocation(bankPaymentBean.getLbllocation());
		setLblservicetax(bankPaymentBean.getLblservicetax());
		setLblpan(bankPaymentBean.getLblpan());
		setLblcstno(bankPaymentBean.getLblcstno());
		setLblrefno(bankPaymentBean.getLblrefno());
		setLblacno(bankPaymentBean.getLblacno());
		setLblname(bankPaymentBean.getLblname());
		setLblvoucherno(bankPaymentBean.getLblvoucherno());
		setLbldescription(bankPaymentBean.getLbldescription());
		setLbldate(bankPaymentBean.getLbldate());
		setLblnetamount(bankPaymentBean.getLblnetamount());
		setLblnetamountwords(bankPaymentBean.getLblnetamountwords());
		setLbldebittotal(bankPaymentBean.getLbldebittotal());
		setLblcredittotal(bankPaymentBean.getLblcredittotal());
		setLblchqno(bankPaymentBean.getLblchqno());
		setLblchqdate(bankPaymentBean.getLblchqdate());
		setLblpreparedby(bankPaymentBean.getLblpreparedby());
		setLblpreparedon(bankPaymentBean.getLblpreparedon());
		setLblpreparedat(bankPaymentBean.getLblpreparedat());
		setPaidto(bankPaymentBean.getPaidto());
		System.out.println("paidtooooooooo"+bankPaymentBean.getLblpaidto());
		setBank(bankPaymentBean.getBank());

		
		setVerifiedappr(bankPaymentBean.getVerifiedappr());
		setVerifybyat(bankPaymentBean.getVerifybyat());
		setVerifybydt(bankPaymentBean.getVerifybydt());
		setApproved(bankPaymentBean.getApproved());
		setApprovedt(bankPaymentBean.getApprovedt());
		setApproveat(bankPaymentBean.getApproveat());
		// for hide
		setFirstarray(bankPaymentBean.getFirstarray());
		setSecarray(bankPaymentBean.getSecarray());
		setTxtheader(bankPaymentBean.getTxtheader());
		setPrintquery(bankPaymentBean.getPrintquery());
		System.out.println("printqury====="+bankPaymentBean.getPrintquery());
		System.out.println("accid====="+bankPaymentBean.getTxttoaccid());
		
			Connection conn = null;
			
			try {
				 conn = connDAO.getMyConnection();
				 param = new HashMap();
				 ClsAmountToWords c = new ClsAmountToWords();
				 imgpath=request.getSession().getServletContext().getRealPath("/icons/autoroutepng.png");
			        imgpath=imgpath.replace("\\", "\\\\"); 
				 param.put("complogo", imgpath);
				 param.put("spname", bankPaymentBean.getPaidto());
				 param.put("spref", bankPaymentBean.getLblacno());
				 param.put("docdate", bankPaymentBean.getLbldate());
				 param.put("docno", bankPaymentBean.getLblvoucherno());
				 param.put("chqno", bankPaymentBean.getLblchqno());
				 param.put("totalwords", bankPaymentBean.getLblnetamountwords());
				 param.put("user", bankPaymentBean.getLblpreparedby());
				 param.put("printquery",bankPaymentBean.getPrintquery()==null?"":bankPaymentBean.getPrintquery());
				 //param.put("obj", c);
				 //param.put("payto", bankPaymentBean.getLblpaidto());
				 //param.put("amountinwords", bankPaymentBean.getLblamountwords()+" "+(bankPaymentBean.getLblamountwords1()==null?" ":bankPaymentBean.getLblamountwords1()));
				 //param.put("amount", "#"+bankPaymentBean.getLblamount()+"#");
	        	 
				 JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/finance/transactions/bankpayment/authform.jrxml"));
				 JasperReport jasperReport = JasperCompileManager.compileReport(design);
				 generateReportPDF(response, param, jasperReport, conn);

			} catch (Exception e) {
	              e.printStackTrace();
	              conn.close();
	      	} finally{
	      		conn.close();
	      	}
            
		
		
	return "print";
	}
	
	public JSONArray searchDetails(HttpSession session,String partyname,String docNo,String date,String amount,String chequeDt,String chequeNo,String check){
			  JSONArray cellarray = new JSONArray();
			  		  JSONObject cellobj = null;
			  try {
				  String chqname="";
				cellarray= bankPayDAO.bpvMainSearch(session,partyname,docNo,date,amount,chequeNo,chequeDt,check,chqname);       
		
			  } catch (SQLException e) {
				  e.printStackTrace();
				  }
			return cellarray;
	}
	
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
		
		public void setData() {
			
			setHidjqxBankPaymentDate(bankPaymentDate.toString());
			setHidmaindate(hidbankPaymentDate.toString());
			setTxtrefno(getTxtrefno());
			
			setTxtfromdocno(getTxtfromdocno());
			setTxtfromaccid(getTxtfromaccid());
			setTxtfromaccname(getTxtfromaccname());
			setHidcmbfromcurrency(getCmbfromcurrency());
			setHidfromcurrencytype(getHidfromcurrencytype());
			setHidchckpdc(getHidchckpdc());
			setTxtpdcacno(getTxtpdcacno());
			setTxtchequeno(getTxtchequeno());
			setHidjqxChequeDate(chequeDate.toString());
			setTxtchequename(getTxtchequename());
			setTxtfromrate(getTxtfromrate());
			setTxtfromamount(getTxtfromamount());
			setTxtfrombaseamount(getTxtfrombaseamount());
			setTxtdescription(getTxtdescription());
			
			setHidcmbtotype(getCmbtotype());
			setTxttodocno(getTxttodocno());
			setTxttoaccid(getTxttoaccid());
			setTxttoaccname(getTxttoaccname());
			setHidcmbtocurrency(getCmbtocurrency());
			setHidtocurrencytype(getHidtocurrencytype());
			setTxttorate(getTxttorate());
			setTxttoamount(getTxttoamount());
			setTxttobaseamount(getTxttobaseamount());
			
			setTxtapplyinvoiceamt(getTxtapplyinvoiceamt());
			setTxtapplyinvoiceapply(getTxtapplyinvoiceapply());
			setTxtapplyinvoicebalance(getTxtapplyinvoicebalance());
			
			setTxtdrtotal(getTxtdrtotal());
			setTxtcrtotal(getTxtdrtotal());
			setFormdetailcode(getFormdetailcode());
		}
		public int getPdcposttrno() {
			return pdcposttrno;
		}
		public void setPdcposttrno(int pdcposttrno) {
			this.pdcposttrno = pdcposttrno;
		}
		
		
	


 	/* public void jasperprintAction() throws ParseException, SQLException{
				HttpServletRequest request=ServletActionContext.getRequest();
				HttpSession session=request.getSession();
			    HttpServletResponse response = ServletActionContext.getResponse();
				
				int docno=Integer.parseInt(request.getParameter("docno"));
				int header=Integer.parseInt(request.getParameter("header"));
				int branch=Integer.parseInt(request.getParameter("branch"));
				bankPaymentBean=bankPayDAO.getPrint(request,docno,branch,header);
				
				String reportFileName = "bankpaymentprint";
				 param = new HashMap();
 Connection conn = null;
				 try {
			          
		           	int trno=0;
					int acno=0;
					int srno=0;
					String sql2="";
		             	 conn = connDAO.getMyConnection();
		             
		             	String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
		               	imgpath=imgpath.replace("\\", "\\\\");
		              	
		               	param.put("header", new Integer(header));
				         param.put("imgpath", imgpath);
				         
				         param.put("compname", bankPaymentBean.getLblcompname());
				         param.put("compaddress", bankPaymentBean.getLblcompaddress());
				        
				         param.put("comptel", bankPaymentBean.getLblcomptel());
				         param.put("compfax", bankPaymentBean.getLblcompfax());
				         param.put("compbranch", bankPaymentBean.getLblbranch());
				         param.put("location", bankPaymentBean.getLbllocation());
		        	 param.put("doc", new Integer(docno));
			         param.put("brch", new Integer(branch));
			        
			         param.put("printname", bankPaymentBean.getLblprintname());  
			         param.put("name", bankPaymentBean.getLblname());
			         param.put("vno", bankPaymentBean.getLblvoucherno());
			         param.put("descp", bankPaymentBean.getLbldescription());
			         param.put("vdate", bankPaymentBean.getLbldate());
			         param.put("chqno", bankPaymentBean.getLblchqno());
			         param.put("chqdat", bankPaymentBean.getLblchqdate());
			         param.put("amtword", bankPaymentBean.getLblnetamountwords());
			         param.put("amt", bankPaymentBean.getLblnetamount());
			         
			         param.put("debtot", bankPaymentBean.getLbldebittotal());
			         param.put("credtot", bankPaymentBean.getLblcredittotal());
			         
			         param.put("prepby", bankPaymentBean.getLblpreparedby());
			         param.put("prepon", bankPaymentBean.getLblpreparedon());
			         param.put("prepat", bankPaymentBean.getLblpreparedat());
			         
			         param.put("printby", session.getAttribute("USERNAME").toString());
			     	param.put("sql2",bankPaymentBean.getApplyquery()==null?"":bankPaymentBean.getApplyquery());
			     	
			     //	System.out.println("param==="+param);
			         
			    
			    JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/finance/transactions/bankpayment/" + reportFileName + ".jrxml"));
		     	 
		     	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
		                       generateReportPDF(response, param, jasperReport, conn);
		                 
		      
		             } catch (Exception e) {

		                 e.printStackTrace();

		             }
		            	 
		            finally{
				conn.close();
			}	  	 
		      	
						}*/
		 
}
