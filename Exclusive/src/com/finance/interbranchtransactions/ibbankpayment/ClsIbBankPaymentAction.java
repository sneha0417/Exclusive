package com.finance.interbranchtransactions.ibbankpayment;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
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

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsIbBankPaymentAction extends ActionSupport{

	ClsConnection connDAO=new ClsConnection();
	ClsCommon commonDAO= new ClsCommon();
	ClsIbBankPaymentDAO ibBankPayDAO= new ClsIbBankPaymentDAO();
	ClsIbBankPaymentBean ibBankPaymentBean;
	
	private int pdcposttrno;
	private int txtibbankpaydocno;
	private String brchName;
	private String formdetailcode;
	private String chkstatus;
	private String mode;
	private String deleted;
	private String msg;
	private String jqxIbBankPaymentDate;
	private String hidjqxIbBankPaymentDate;
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
	private String cmbtobranch;
	private String hidcmbtobranch;
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
	
	private String printurl;
	
	private Map<String, Object> param=null;
	
	
	
	public int getPdcposttrno() {
		return pdcposttrno;
	}
	public void setPdcposttrno(int pdcposttrno) {
		this.pdcposttrno = pdcposttrno;
	}
	public int getTxtibbankpaydocno() {
		return txtibbankpaydocno;
	}
	public void setTxtibbankpaydocno(int txtibbankpaydocno) {
		this.txtibbankpaydocno = txtibbankpaydocno;
	}
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
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
	public String getJqxIbBankPaymentDate() {
		return jqxIbBankPaymentDate;
	}
	public void setJqxIbBankPaymentDate(String jqxIbBankPaymentDate) {
		this.jqxIbBankPaymentDate = jqxIbBankPaymentDate;
	}
	public String getHidjqxIbBankPaymentDate() {
		return hidjqxIbBankPaymentDate;
	}
	public void setHidjqxIbBankPaymentDate(String hidjqxIbBankPaymentDate) {
		this.hidjqxIbBankPaymentDate = hidjqxIbBankPaymentDate;
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
	public String getCmbtobranch() {
		return cmbtobranch;
	}
	public void setCmbtobranch(String cmbtobranch) {
		this.cmbtobranch = cmbtobranch;
	}
	public String getHidcmbtobranch() {
		return hidcmbtobranch;
	}
	public void setHidcmbtobranch(String hidcmbtobranch) {
		this.hidcmbtobranch = hidcmbtobranch;
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

	java.sql.Date ibBankPaymentDate;
	java.sql.Date hidibBankPaymentDate;
	java.sql.Date chequeDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsIbBankPaymentBean bean = new ClsIbBankPaymentBean();

		ibBankPaymentDate = commonDAO.changeStringtoSqlDate(getJqxIbBankPaymentDate());
		hidibBankPaymentDate = commonDAO.changeStringtoSqlDate(getMaindate());
		chequeDate = commonDAO.changeStringtoSqlDate(getJqxChequeDate());
		
		if(mode.equalsIgnoreCase("A")){
			String mainBranch=session.getAttribute("BRANCHID").toString().trim();
			/*Ib-Bank Payment Grid Saving*/
			ArrayList ibbankpaymentarray= new ArrayList();
			ibbankpaymentarray.add(getTxtfromdocno()+"::"+getCmbfromcurrency()+"::"+getTxtfromrate()+"::false::"+getTxtfromamount()*-1+"::"+getTxtdescription()+"::"+getTxtfrombaseamount()*-1+"::0::0::0::"+mainBranch+"::"+mainBranch+"::"+getHidchckpdc()+"::"+getTxtpdcacno());
			ibbankpaymentarray.add(getTxttodocno()+"::"+getCmbtocurrency()+"::"+getTxttorate()+"::true::"+getTxttoamount()+"::"+getTxtdescription()+"::"+getTxttobaseamount()+"::"+getTxtapplyinvoiceapply()+"::0::0::"+getCmbtobranch()+"::"+mainBranch+"::"+getHidchckpdc()+"::"+getTxtpdcacno());
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0]+"::"+mainBranch+"::"+getHidchckpdc()+"::"+getTxtpdcacno();
				ibbankpaymentarray.add(temp);
			}
			/*Ib-Bank Payment Grid Saving Ends*/
			
			/*Apply-Invoice Grid Saving*/
			ArrayList applyibinvoicearray= new ArrayList();
			for(int i=0;i<getApplylength();i++){
				String applytemp=requestParams.get("txtapply"+i)[0];
				applyibinvoicearray.add(applytemp);
			}
			/*Apply-Invoice Grid Saving Ends*/
			
			/*Checking main-branch & to-branch are equal*/ 
			int chk=0;
			for(int i=0;i<ibbankpaymentarray.size();i++){
				String[] array=ibbankpaymentarray.get(i).toString().split("::");
				if(!(array[10].equalsIgnoreCase(array[11]))){
				chk=1;
				}
				else{}
			}
			/*Checking main-branch & to-branch are equal ends*/
			
			if(chk>0){
						int val=ibBankPayDAO.insert(ibBankPaymentDate,getFormdetailcode(),getTxtrefno(),getTxtfromrate(),chequeDate,getTxtchequeno(),getTxtchequename(),getHidchckpdc(),getTxtdescription(),getTxtdrtotal(),getTxttodocno(),getTxtapplyinvoiceapply(),ibbankpaymentarray,applyibinvoicearray,session,request,mode);
			
						if(val>0.0){

							setTxtibbankpaydocno(val);
							setTxttotrno(Integer.parseInt(request.getAttribute("tranno").toString()));
							setData();
							
							setMsg("Successfully Saved");
							return "success";
						}
						else{
							setData();
							setMsg("Not Saved");
							return "fail";
						}	
						
			}
			else{
				setChkstatus("1");
				setData();
				setMsg("Main-Branch and Inter-Branch are Equal.");
			    return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("EDIT")){
			String mainBranch=session.getAttribute("BRANCHID").toString().trim();
			/*Updating Ib-Bank Payment Grid*/
			ArrayList ibbankpaymentarray= new ArrayList();
			ibbankpaymentarray.add(getTxtfromdocno()+"::"+getCmbfromcurrency()+"::"+getTxtfromrate()+"::false::"+getTxtfromamount()*-1+"::"+getTxtdescription()+"::"+getTxtfrombaseamount()*-1+"::0::0::0::"+mainBranch+"::"+mainBranch+"::"+getHidchckpdc()+"::"+getTxtpdcacno());
			ibbankpaymentarray.add(getTxttodocno()+"::"+getCmbtocurrency()+"::"+getTxttorate()+"::true::"+getTxttoamount()+"::"+getTxtdescription()+"::"+getTxttobaseamount()+"::"+getTxtapplyinvoiceapply()+"::0::0::"+getCmbtobranch()+"::"+mainBranch+"::"+getHidchckpdc()+"::"+getTxtpdcacno());
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0]+"::"+mainBranch+"::"+getHidchckpdc()+"::"+getTxtpdcacno();
				ibbankpaymentarray.add(temp);
			}
			/*Updating Ib-Bank Payment Grid Ends*/
			
			/*Apply-Invoice Grid Saving*/
			ArrayList applyibinvoicearray= new ArrayList();
			for(int i=0;i<getApplylength();i++){
				String applytemp=requestParams.get("txtapply"+i)[0];
				applyibinvoicearray.add(applytemp);
			}
			/*Apply-Invoice Grid Saving Ends*/
			
			/*Apply-Invoice Grid Updating*/
			ArrayList applyibinvoiceupdatearray= new ArrayList();
			for(int i=0;i<getApplylengthupdate();i++){
				String applyupdatetemp=requestParams.get("txtapplyupdate"+i)[0];
				applyibinvoiceupdatearray.add(applyupdatetemp);
			}
			/*Apply-Invoice Grid Updating Ends*/
			
			boolean Status=ibBankPayDAO.edit(getTxtibbankpaydocno(),getFormdetailcode(),ibBankPaymentDate,getTxtrefno(),getTxtdescription(),getTxtfromrate(),getTxtdrtotal(),getTxttodocno(),getTxttotrno(),chequeDate,getTxtchequeno(),getTxtchequename(),getHidchckpdc(),getTxtapplyinvoiceapply(),ibbankpaymentarray,applyibinvoicearray,applyibinvoiceupdatearray,session,mode);
			if(Status){
				
				setTxtibbankpaydocno(getTxtibbankpaydocno());
				setTxttotrno(getTxttotrno());
				setData();
				
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setTxtibbankpaydocno(getTxtibbankpaydocno());
				setTxttotrno(getTxttotrno());
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("E")){

			boolean Status=ibBankPayDAO.editMaster(getTxtibbankpaydocno(),getFormdetailcode(),ibBankPaymentDate,getTxtrefno(),getTxtdescription(),getTxtfromrate(),getTxtdrtotal(),getTxttodocno(),getTxttotrno(),session);
			if(Status){
				setTxtibbankpaydocno(getTxtibbankpaydocno());
				setTxttotrno(getTxttotrno());
				setData();
				
				setMsg("Updated Successfully");
			    return "success";
		}
		else{
			setTxtibbankpaydocno(getTxtibbankpaydocno());
			setTxttotrno(getTxttotrno());
			setData();
			setMsg("Not Updated");
			return "fail";
		}
	  }
		
		
		else if(mode.equalsIgnoreCase("D")){
			
			boolean Status=ibBankPayDAO.delete(getTxtibbankpaydocno(),getFormdetailcode(),getTxttotrno(),getTxttodocno(),session);
			if(Status){
				setTxtibbankpaydocno(getTxtibbankpaydocno());
				setTxttotrno(getTxttotrno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setTxtibbankpaydocno(getTxtibbankpaydocno());
				setTxttotrno(getTxttotrno());
				setData();
				setMsg("Not Deleted");
				return "fail";
			   }
			}
		
		else if(mode.equalsIgnoreCase("View")){
	
			String branch=null;
		//	System.out.println(" inside view === "+getBrchName()+" ===== "+getTxtibbankpaydocno());
			ibBankPaymentBean=ibBankPayDAO.getViewDetails(session,getTxtibbankpaydocno());
			
			setJqxIbBankPaymentDate(ibBankPaymentBean.getJqxIbBankPaymentDate());
			setTxtrefno(ibBankPaymentBean.getTxtrefno());
			
			setTxtfromdocno(ibBankPaymentBean.getTxtfromdocno());
			setTxtfromaccid(ibBankPaymentBean.getTxtfromaccid());
			setTxtfromaccname(ibBankPaymentBean.getTxtfromaccname());
			setHidcmbfromcurrency(ibBankPaymentBean.getHidcmbfromcurrency());
			setHidfromcurrencytype(ibBankPaymentBean.getHidfromcurrencytype());
			setTxtfromrate(ibBankPaymentBean.getTxtfromrate());
			setHidchckpdc(ibBankPaymentBean.getChckpdc());
			setTxtpdcacno(ibBankPaymentBean.getTxtpdcacno());
			setTxtchequename(ibBankPaymentBean.getTxtchequename());
			setTxtchequeno(ibBankPaymentBean.getTxtchequeno());
			setJqxChequeDate(ibBankPaymentBean.getJqxChequeDate());
			setTxtfromamount(ibBankPaymentBean.getTxtfromamount());
			setTxtfrombaseamount(ibBankPaymentBean.getTxtfrombaseamount());
			setTxtdescription(ibBankPaymentBean.getTxtdescription());
			
			setTxttodocno(ibBankPaymentBean.getTxttodocno());
			setTxttotranid(ibBankPaymentBean.getTxttotranid());
			setTxttotrno(ibBankPaymentBean.getTxttotrno());
			setHidcmbtobranch(ibBankPaymentBean.getHidcmbtobranch());
			setHidcmbtotype(ibBankPaymentBean.getHidcmbtotype());
			setTxttoaccid(ibBankPaymentBean.getTxttoaccid());
			setTxttoaccname(ibBankPaymentBean.getTxttoaccname());
			setHidcmbtocurrency(ibBankPaymentBean.getHidcmbtocurrency());
			setHidtocurrencytype(ibBankPaymentBean.getHidtocurrencytype());
			setTxttorate(ibBankPaymentBean.getTxttorate());
			setTxttoamount(ibBankPaymentBean.getTxttoamount());
			setTxttobaseamount(ibBankPaymentBean.getTxttobaseamount());
			setTxtapplyinvoiceamt(ibBankPaymentBean.getTxtapplyinvoiceamt());
			setTxtapplyinvoiceapply(ibBankPaymentBean.getTxtapplyinvoiceapply());
			setTxtapplyinvoicebalance(ibBankPaymentBean.getTxtapplyinvoicebalance());
			setPdcposttrno(ibBankPaymentBean.getPdcposttrno());
			
			setTxtdrtotal(ibBankPaymentBean.getTxtdrtotal());
			setTxtcrtotal(ibBankPaymentBean.getTxtcrtotal());
			setMaindate(ibBankPaymentBean.getMaindate());
			setFormdetailcode(ibBankPaymentBean.getFormdetailcode());
			
			return "success";
		}
		return "fail";
     }
	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		int docno=Integer.parseInt(request.getParameter("docno"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		int header=Integer.parseInt(request.getParameter("header"));
		ibBankPaymentBean=ibBankPayDAO.getPrint(request,docno,branch,header);
		
		setLblmainname("Paid To");
		setUrl(commonDAO.getPrintPath("IBP"));
		setLblcompname(ibBankPaymentBean.getLblcompname());
		setLblcompaddress(ibBankPaymentBean.getLblcompaddress());
		setLblpobox(ibBankPaymentBean.getLblpobox());
		setLblprintname(ibBankPaymentBean.getLblprintname());
		setLblcomptel(ibBankPaymentBean.getLblcomptel());
		setLblcompfax(ibBankPaymentBean.getLblcompfax());
		setLblbranch(ibBankPaymentBean.getLblbranch());
		setLbllocation(ibBankPaymentBean.getLbllocation());
		setLblservicetax(ibBankPaymentBean.getLblservicetax());
		setLblpan(ibBankPaymentBean.getLblpan());
		setLblcstno(ibBankPaymentBean.getLblcstno());
		setLblname(ibBankPaymentBean.getLblname());
		setLblvoucherno(ibBankPaymentBean.getLblvoucherno());
		setLbldescription(ibBankPaymentBean.getLbldescription());
		setLbldate(ibBankPaymentBean.getLbldate());
		setLblnetamount(ibBankPaymentBean.getLblnetamount());
		setLblnetamountwords(ibBankPaymentBean.getLblnetamountwords());
		setLbldebittotal(ibBankPaymentBean.getLbldebittotal());
		setLblcredittotal(ibBankPaymentBean.getLblcredittotal());
		setLblchqno(ibBankPaymentBean.getLblchqno());
		setLblchqdate(ibBankPaymentBean.getLblchqdate());
		setLblpreparedby(ibBankPaymentBean.getLblpreparedby());
		setLblpreparedon(ibBankPaymentBean.getLblpreparedon());
		setLblpreparedat(ibBankPaymentBean.getLblpreparedat());
		
		// for hide
		setFirstarray(ibBankPaymentBean.getFirstarray());
		setSecarray(ibBankPaymentBean.getSecarray());
		setTxtheader(ibBankPaymentBean.getTxtheader());
	
	return "print";
	}
	
	public String printChequeAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		int docno=Integer.parseInt(request.getParameter("docno"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		ibBankPaymentBean=ibBankPayDAO.getChequePrint(docno,branch);
		setLblbankid(ibBankPaymentBean.getLblbankid());
		setLblbankname(ibBankPaymentBean.getLblbankname());
		setLblpageswidth(ibBankPaymentBean.getLblpageswidth());
		setLblpagesheight(ibBankPaymentBean.getLblpagesheight());
		setLblpagewidth(ibBankPaymentBean.getLblpagewidth());
		setLblpageheight(ibBankPaymentBean.getLblpageheight());
		setLbldatex(ibBankPaymentBean.getLbldatex());
		setLbldatey(ibBankPaymentBean.getLbldatey());
		setLblpaytovertical(ibBankPaymentBean.getLblpaytovertical());
		setLblpaytohorizontal(ibBankPaymentBean.getLblpaytohorizontal());
		setLblpaytolength(ibBankPaymentBean.getLblpaytolength());
		setLblaccountpayingx(ibBankPaymentBean.getLblaccountpayingx());
		setLblaccountpayingy(ibBankPaymentBean.getLblaccountpayingy());
		setLblamtwordsvertical(ibBankPaymentBean.getLblamtwordsvertical());
		setLblamtwordshorizontal(ibBankPaymentBean.getLblamtwordshorizontal());
		setLblamtwordslength(ibBankPaymentBean.getLblamtwordslength());
		setLblamountx(ibBankPaymentBean.getLblamountx());
		setLblamounty(ibBankPaymentBean.getLblamounty());
		setLblamtwords1vertical(ibBankPaymentBean.getLblamtwords1vertical());
		setLblamtwords1horizontal(ibBankPaymentBean.getLblamtwords1horizontal());
		setLblamtwords1length(ibBankPaymentBean.getLblamtwords1length());
		
		setLblchequedate(ibBankPaymentBean.getLblchequedate());
		setLblpaidto(ibBankPaymentBean.getLblpaidto());
		setLblaccountno(ibBankPaymentBean.getLblaccountno());
		setLblamountwords(ibBankPaymentBean.getLblamountwords());
		setLblamountwords1(ibBankPaymentBean.getLblamountwords1());
		setLblamount(ibBankPaymentBean.getLblamount());
		setPrinturl(ibBankPaymentBean.getPrinturl());
		
		if(getPrinturl().contains(".jrxml")) {
			Connection conn = null;
			
			try {
				 conn = connDAO.getMyConnection();
				 param = new HashMap();
            
				 param.put("date", ibBankPaymentBean.getLblchequedate());
				 param.put("payto", ibBankPaymentBean.getLblpaidto());
				 param.put("amountinwords", ibBankPaymentBean.getLblamountwords()+" "+(ibBankPaymentBean.getLblamountwords1()==null?" ":ibBankPaymentBean.getLblamountwords1()));
				 param.put("amount", "#"+ibBankPaymentBean.getLblamount()+"#");
	        	 
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

		public JSONArray searchDetails(HttpSession session,String partyname,String docNo,String date,String amount,String chequeDt, String chequeNo,String check){
			  JSONArray cellarray = new JSONArray();
			  		  JSONObject cellobj = null;
			  try {
				cellarray= ibBankPayDAO.ibpMainSearch(session,partyname,docNo,date,amount,chequeNo,chequeDt,check);
		
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
		
		public void setData(){
			setHidjqxIbBankPaymentDate(ibBankPaymentDate.toString());
			setHidmaindate(hidibBankPaymentDate.toString());
			setTxtrefno(getTxtrefno());
			
			setTxtfromdocno(getTxtfromdocno());
			setTxtfromaccid(getTxtfromaccid());
			setTxtfromaccname(getTxtfromaccname());
			setHidcmbfromcurrency(getCmbfromcurrency());
			setHidfromcurrencytype(getHidfromcurrencytype());
			setTxtfromrate(getTxtfromrate());
			setHidchckpdc(getHidchckpdc());
			setTxtpdcacno(getTxtpdcacno());
			setTxtchequename(getTxtchequename());
			setTxtchequeno(getTxtchequeno());
			setHidjqxChequeDate(chequeDate.toString());
			setTxtfromamount(getTxtfromamount());
			setTxtfrombaseamount(getTxtfrombaseamount());
			setTxtdescription(getTxtdescription());
			
			setHidcmbtotype(getCmbtotype());
			setHidcmbtobranch(getCmbtobranch());
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
		
}

