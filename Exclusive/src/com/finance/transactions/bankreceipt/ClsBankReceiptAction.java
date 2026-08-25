package com.finance.transactions.bankreceipt;

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
public class ClsBankReceiptAction extends ActionSupport{

	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsBankReceiptDAO bankReceiptDAO= new ClsBankReceiptDAO();
	ClsBankReceiptBean bankReceiptBean;
	
	private int pdcposttrno;
	private int txtbankreceiptdocno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String jqxBankReceiptDate;
	private String hidjqxBankReceiptDate;
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
	
	private String maindate;
	private String hidmaindate;
	
	private String url;
	private String lblprintnamensib;
	public String getLblprintnamensib() {
		return lblprintnamensib;
	}
	public void setLblprintnamensib(String lblprintnamensib) {
		this.lblprintnamensib = lblprintnamensib;
	}

	//Bank Receipt Grid
	private int gridlength;
	
	//Apply-Invoicing Grid
	private int applylength;
	
	//Apply-Invoicing Grid Updating
	private int applylengthupdate;
	
	//Print
	private String lblcomptrn;
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
	private String brchName;
	private String printurl;
	
	private Map<String, Object> param=null;
	
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}
	public int getTxtbankreceiptdocno() {
		return txtbankreceiptdocno;
	}
	public void setTxtbankreceiptdocno(int txtbankreceiptdocno) {
		this.txtbankreceiptdocno = txtbankreceiptdocno;
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
	public String getJqxBankReceiptDate() {
		return jqxBankReceiptDate;
	}
	public void setJqxBankReceiptDate(String jqxBankReceiptDate) {
		this.jqxBankReceiptDate = jqxBankReceiptDate;
	}
	public String getHidjqxBankReceiptDate() {
		return hidjqxBankReceiptDate;
	}
	public void setHidjqxBankReceiptDate(String hidjqxBankReceiptDate) {
		this.hidjqxBankReceiptDate = hidjqxBankReceiptDate;
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
	
	java.sql.Date bankReceiptDate ;
	java.sql.Date chequeDate;
	java.sql.Date hidbankReceiptDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		session.setAttribute("BRANCHID", getBrchName());
		//System.out.println(getBrchName());
		String mode=getMode();
		ClsBankReceiptBean bean = new ClsBankReceiptBean();

		bankReceiptDate = commonDAO.changeStringtoSqlDate(getJqxBankReceiptDate());
		chequeDate = commonDAO.changeStringtoSqlDate(getJqxChequeDate());
		hidbankReceiptDate = commonDAO.changeStringtoSqlDate(getMaindate());
		
		if(mode.equalsIgnoreCase("A")){
		
		    Connection conn = null;
			
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			
			/*Bank Receipt Grid Saving*/
			ArrayList bankreceiptarray= new ArrayList();
			bankreceiptarray.add(getTxtfromdocno()+"::"+getCmbfromcurrency()+"::"+getTxtfromrate()+"::false::"+getTxtfromamount()+"::"+getTxtdescription()+"::"+getTxtfrombaseamount()+"::0::0::0::"+getHidchckpdc()+"::"+getTxtpdcacno());
			bankreceiptarray.add(getTxttodocno()+"::"+getCmbtocurrency()+"::"+getTxttorate()+"::true::"+getTxttoamount()*-1+"::"+getTxtdescription()+"::"+getTxttobaseamount()*-1+"::"+getTxtapplyinvoiceapply()+"::0::0::"+getHidchckpdc()+"::"+getTxtpdcacno());
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				bankreceiptarray.add(temp+"::"+getHidchckpdc()+"::"+getTxtpdcacno());
			}
			/*Bank Receipt Grid Saving Ends*/
			
			/*Apply-Bank Invoice Grid Saving*/
			ArrayList applyinvoicearray= new ArrayList();
			for(int i=0;i<getApplylength();i++){
				String applytemp=requestParams.get("txtapply"+i)[0];
				applyinvoicearray.add(applytemp);
			}
			/*Apply-Bank Invoice Grid Saving Ends*/
				//	setHidchckpdc(1);
						int val=bankReceiptDAO.insert(conn,bankReceiptDate,getFormdetailcode(),getTxtrefno(),getTxtfromrate(),chequeDate,getTxtchequeno(),getTxttoaccname(),getHidchckpdc(),getTxtdescription(),getTxtdrtotal(),getTxttodocno(),getTxtapplyinvoiceapply(),bankreceiptarray,applyinvoicearray,session,request,mode);
						if(val>0.0){
							
							setTxtbankreceiptdocno(val);
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
			/*Updating Bank Receipt Grid*/
			ArrayList bankreceiptarray= new ArrayList();
			bankreceiptarray.add(getTxtfromdocno()+"::"+getCmbfromcurrency()+"::"+getTxtfromrate()+"::false::"+getTxtfromamount()+"::"+getTxtdescription()+"::"+getTxtfrombaseamount()+"::0::0::0::"+getHidchckpdc()+"::"+getTxtpdcacno());
			bankreceiptarray.add(getTxttodocno()+"::"+getCmbtocurrency()+"::"+getTxttorate()+"::true::"+getTxttoamount()*-1+"::"+getTxtdescription()+"::"+getTxttobaseamount()*-1+"::"+getTxtapplyinvoiceapply()+"::0::0::"+getHidchckpdc()+"::"+getTxtpdcacno());
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				bankreceiptarray.add(temp+"::"+getHidchckpdc()+"::"+getTxtpdcacno());
			}
			/*Updating Bank Receipt Grid Ends*/
			
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
			
			boolean Status=bankReceiptDAO.edit(getTxtbankreceiptdocno(),getFormdetailcode(),bankReceiptDate,getTxtrefno(),getTxtdescription(),getTxtfromrate(),getTxtdrtotal(),getTxttodocno(),getTxttotrno(),chequeDate,getTxtchequeno(),getTxttoaccname(),getHidchckpdc(),getTxtapplyinvoiceapply(),bankreceiptarray,applyinvoicearray,applyinvoiceupdatearray,session,mode);
			if(Status){
				
				setTxtbankreceiptdocno(getTxtbankreceiptdocno());
				setTxttotrno(getTxttotrno());
				setData();
				
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setTxtbankreceiptdocno(getTxtbankreceiptdocno());
				setTxttotrno(getTxttotrno());
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("E")){

			boolean Status=bankReceiptDAO.editMaster(getTxtbankreceiptdocno(),getFormdetailcode(),bankReceiptDate,getTxtrefno(),getTxtdescription(),getTxtfromrate(),getTxtdrtotal(),getTxttodocno(),getTxttotrno(),session);
			if(Status){
				
				setTxtbankreceiptdocno(getTxtbankreceiptdocno());
				setTxttotrno(getTxttotrno());
				setData();
				
				setMsg("Updated Successfully");
			    return "success";
		}
		else{
			setTxtbankreceiptdocno(getTxtbankreceiptdocno());
			setTxttotrno(getTxttotrno());
			setData();
			setMsg("Not Updated");
			return "fail";
		}
	  }
		
		
		else if(mode.equalsIgnoreCase("D")){
			
			boolean Status=bankReceiptDAO.delete(getTxtbankreceiptdocno(),getFormdetailcode(),getTxttodocno(),getTxttotrno(),session);
			if(Status){
				
				setTxtbankreceiptdocno(getTxtbankreceiptdocno());
				setTxttotrno(getTxttotrno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setTxtbankreceiptdocno(getTxtbankreceiptdocno());
				setTxttotrno(getTxttotrno());
				setData();
				setMsg("Not Deleted");
				return "fail";
			   }
			}
		
		else if(mode.equalsIgnoreCase("View")){
	
			String branch=null;
			bankReceiptBean=bankReceiptDAO.getViewDetails(session,getTxtbankreceiptdocno());
			
			setJqxBankReceiptDate(bankReceiptBean.getJqxBankReceiptDate());
			setTxtrefno(bankReceiptBean.getTxtrefno());
			
			setTxtfromdocno(bankReceiptBean.getTxtfromdocno());
			setTxtfromaccid(bankReceiptBean.getTxtfromaccid());
			setTxtfromaccname(bankReceiptBean.getTxtfromaccname());
			setHidcmbfromcurrency(bankReceiptBean.getHidcmbfromcurrency());
			setHidfromcurrencytype(bankReceiptBean.getHidfromcurrencytype());
			setTxtfromrate(bankReceiptBean.getTxtfromrate());
			setHidchckpdc(bankReceiptBean.getChckpdc());
			setTxtpdcacno(bankReceiptBean.getTxtpdcacno());
			setTxtchequeno(bankReceiptBean.getTxtchequeno());
			setJqxChequeDate(bankReceiptBean.getJqxChequeDate());
			setTxtfromamount(bankReceiptBean.getTxtfromamount());
			setTxtfrombaseamount(bankReceiptBean.getTxtfrombaseamount());
			setTxtdescription(bankReceiptBean.getTxtdescription());
			
			setTxttodocno(bankReceiptBean.getTxttodocno());
			setTxttotranid(bankReceiptBean.getTxttotranid());
			setTxttotrno(bankReceiptBean.getTxttotrno());
			setHidcmbtotype(bankReceiptBean.getHidcmbtotype());
			setTxttoaccid(bankReceiptBean.getTxttoaccid());
			setTxttoaccname(bankReceiptBean.getTxttoaccname());
			setHidcmbtocurrency(bankReceiptBean.getHidcmbtocurrency());
			setHidtocurrencytype(bankReceiptBean.getHidtocurrencytype());
			setTxttorate(bankReceiptBean.getTxttorate());
			setTxttoamount(bankReceiptBean.getTxttoamount());
			setTxttobaseamount(bankReceiptBean.getTxttobaseamount());
			setTxtapplyinvoiceamt(bankReceiptBean.getTxtapplyinvoiceamt());
			setTxtapplyinvoiceapply(bankReceiptBean.getTxtapplyinvoiceapply());
			setTxtapplyinvoicebalance((bankReceiptBean.getTxtapplyinvoicebalance()));
			
			setTxtdrtotal(bankReceiptBean.getTxtdrtotal());
			setTxtcrtotal(bankReceiptBean.getTxtcrtotal());
			setMaindate(bankReceiptBean.getMaindate());
			setFormdetailcode(bankReceiptBean.getFormdetailcode());
			setPdcposttrno(bankReceiptBean.getPdcposttrno());
			// System.out.println("===== DAO ======== "+bankReceiptBean.getPdcposttrno());
			
			
			return "success";
		}
		return "fail";
}
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		System.out.println("print action");
		int docno=Integer.parseInt(request.getParameter("docno"));
		int header=Integer.parseInt(request.getParameter("header"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		System.out.println("branch--"+branch);
		bankReceiptBean=bankReceiptDAO.getPrint(request,docno,branch,header);
		setLblmainname("Received From");
		setUrl(commonDAO.getPrintPath("BRV"));
		setLblcomptrn(bankReceiptBean.getLblcomptrn());
		setLblcompname(bankReceiptBean.getLblcompname());
		setLblcompaddress(bankReceiptBean.getLblcompaddress());
		setLblpobox(bankReceiptBean.getLblpobox());
		setLblprintname(bankReceiptBean.getLblprintname());
		setLblcomptel(bankReceiptBean.getLblcomptel());
		setLblcompfax(bankReceiptBean.getLblcompfax());
		setLblbranch(bankReceiptBean.getLblbranch());
		setLbllocation(bankReceiptBean.getLbllocation());
		setLblpan(bankReceiptBean.getLblpan());
		setLblcstno(bankReceiptBean.getLblcstno());
		setLblservicetax(bankReceiptBean.getLblservicetax());
		setLblname(bankReceiptBean.getLblname());
		setLblname(bankReceiptBean.getLblname());
		setLblvoucherno(bankReceiptBean.getLblvoucherno());
		setLbldescription(bankReceiptBean.getLbldescription());
		setLbldate(bankReceiptBean.getLbldate());
		setLblnetamount(bankReceiptBean.getLblnetamount());
		setLblnetamountwords(bankReceiptBean.getLblnetamountwords());
		setLbldebittotal(bankReceiptBean.getLbldebittotal());
		setLblcredittotal(bankReceiptBean.getLblcredittotal());
		setLblchqno(bankReceiptBean.getLblchqno());
		setLblchqdate(bankReceiptBean.getLblchqdate());
		setLblpreparedby(bankReceiptBean.getLblpreparedby());
		setLblpreparedon(bankReceiptBean.getLblpreparedon());
		setLblpreparedat(bankReceiptBean.getLblpreparedat());
		setLblprintnamensib(bankReceiptBean.getLblprintnamensib());
		
		// for hide
		setFirstarray(bankReceiptBean.getFirstarray());
		setSecarray(bankReceiptBean.getSecarray());
		setTxtheader(bankReceiptBean.getTxtheader());
		
		if(commonDAO.getPrintPath("BRV").contains(".jrxml"));
		{
			 HttpServletResponse response = ServletActionContext.getResponse();
			 param = new HashMap();
			 Connection conn = null;
			 
			 try {
		          
	             	 conn = connDAO.getMyConnection();
	               	
  	                 String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
		        	 imgpath=imgpath.replace("\\", "\\\\");    
		             
		        	 param.put("imghedderpath", imgpath);
		        	
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
		             String imgpath2=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
		        	 imgpath2=imgpath2.replace("\\", "\\\\");    
		             param.put("imgfooterpath", imgpath2);
	               	
	               	 param.put("header", new Integer(header));
			         param.put("imgpath", imgpath);
			        
		        	 param.put("doc", new Integer(docno));	
					 param.put("brch", new Integer(branch));		        
			         param.put("bank", bankReceiptBean.getBank());
			         param.put("vno", bankReceiptBean.getLblvoucherno());			       
			         param.put("vdate", bankReceiptBean.getLbldate());
			         param.put("chqno", bankReceiptBean.getLblchqno());
			         param.put("chqdat", bankReceiptBean.getLblchqdate());
			         param.put("amtword", bankReceiptBean.getLblnetamountwords());
			         param.put("amt", bankReceiptBean.getLblnetamount());
			         
			         param.put("debtot", bankReceiptBean.getLbldebittotal());
			         param.put("credtot", bankReceiptBean.getLblcredittotal());
			         param.put("descp", bankReceiptBean.getLbldescription());
			         
			         param.put("prepby", bankReceiptBean.getLblpreparedby());
			         param.put("prepon", bankReceiptBean.getLblpreparedon());
			         param.put("prepat", bankReceiptBean.getLblpreparedat());
			         
			         param.put("printby", session.getAttribute("USERNAME").toString());
			     	
			         param.put("applyingqry",bankReceiptBean.getApplyqry());			     	
		     
			         String path[]=commonDAO.getPrintPath("BRV").split("bankreceipt/");
			         setUrl(path[1]);
		    
			         JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(commonDAO.getPrintPath("BRV")));
	     	 System.out.println("get real path--"+getUrl());
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
	
	public String printChequeAction() throws ParseException, SQLException{
	    HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		int docno=Integer.parseInt(request.getParameter("docno"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		bankReceiptBean=bankReceiptDAO.getChequePrint(docno,branch);
		setLblbankid(bankReceiptBean.getLblbankid());
		setLblbankname(bankReceiptBean.getLblbankname());
		setLblpageswidth(bankReceiptBean.getLblpageswidth());
		setLblpagesheight(bankReceiptBean.getLblpagesheight());
		setLblpagewidth(bankReceiptBean.getLblpagewidth());
		setLblpageheight(bankReceiptBean.getLblpageheight());
		setLbldatex(bankReceiptBean.getLbldatex());
		setLbldatey(bankReceiptBean.getLbldatey());
		setLblpaytovertical(bankReceiptBean.getLblpaytovertical());
		setLblpaytohorizontal(bankReceiptBean.getLblpaytohorizontal());
		setLblpaytolength(bankReceiptBean.getLblpaytolength());
		setLblaccountpayingx(bankReceiptBean.getLblaccountpayingx());
		setLblaccountpayingy(bankReceiptBean.getLblaccountpayingy());
		setLblamtwordsvertical(bankReceiptBean.getLblamtwordsvertical());
		setLblamtwordshorizontal(bankReceiptBean.getLblamtwordshorizontal());
		setLblamtwordslength(bankReceiptBean.getLblamtwordslength());
		setLblamountx(bankReceiptBean.getLblamountx());
		setLblamounty(bankReceiptBean.getLblamounty());
		setLblamtwords1vertical(bankReceiptBean.getLblamtwords1vertical());
		setLblamtwords1horizontal(bankReceiptBean.getLblamtwords1horizontal());
		setLblamtwords1length(bankReceiptBean.getLblamtwords1length());
		
		setLblchequedate(bankReceiptBean.getLblchequedate());
		setLblpaidto(bankReceiptBean.getLblpaidto());
		setLblaccountno(bankReceiptBean.getLblaccountno());
		setLblamountwords(bankReceiptBean.getLblamountwords());
		setLblamountwords1(bankReceiptBean.getLblamountwords1());
		setLblamount(bankReceiptBean.getLblamount());
		setPrinturl(bankReceiptBean.getPrinturl());
		Connection conn = null;
		if(getPrinturl().contains(".jrxml")) {
			
			
			try {
				 conn = connDAO.getMyConnection();
				 param = new HashMap();
            
				 param.put("date", bankReceiptBean.getLblchequedate());
				 param.put("payto", bankReceiptBean.getLblpaidto());
				 param.put("amountinwords", bankReceiptBean.getLblamountwords()+" "+(bankReceiptBean.getLblamountwords1()==null?" ":bankReceiptBean.getLblamountwords1()));
				 param.put("amount", "#"+bankReceiptBean.getLblamount()+"#");
	        	 
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
			
		/* trading print
			
			if(commonDAO.getPrintPath("BRV").contains(".jrxml"));
			{
				HttpSession session=request.getSession();
				int header=Integer.parseInt(request.getParameter("header"));
				 param = new HashMap();
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
				        
		        	 param.put("doc", new Integer(docno));	
  				 param.put("brch", new Integer(branch));		        
			         param.put("bank", bankReceiptBean.getBank());
			         param.put("vno", bankReceiptBean.getLblvoucherno());			       
			         param.put("vdate", bankReceiptBean.getLbldate());
			         param.put("chqno", bankReceiptBean.getLblchqno());
			         param.put("chqdat", bankReceiptBean.getLblchqdate());
			         param.put("amtword", bankReceiptBean.getLblnetamountwords());
			         param.put("amt", bankReceiptBean.getLblnetamount());
			         
			         param.put("debtot", bankReceiptBean.getLbldebittotal());
			         param.put("credtot", bankReceiptBean.getLblcredittotal());
			         param.put("descp", bankReceiptBean.getLbldescription());
			         
			         param.put("prepby", bankReceiptBean.getLblpreparedby());
			         param.put("prepon", bankReceiptBean.getLblpreparedon());
			         param.put("prepat", bankReceiptBean.getLblpreparedat());
			         
			         param.put("printby", session.getAttribute("USERNAME").toString());
			     	
			         param.put("applyingqry",bankReceiptBean.getApplyqry());			     	
			     //	System.out.println("param==="+param);
			     	 String path[]=commonDAO.getPrintPath("BRV").split("bankreceipt/");
				        setUrl(path[1]);
			    
			         JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(commonDAO.getPrintPath("BRV")));
		     	 
		     	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
		                       generateReportPDF(response, param, jasperReport, conn);
		                 
		      
		             } catch (Exception e) {

		                 e.printStackTrace();
		             }
		            	 
		            finally{
				conn.close();
			}	  	 
			
			}

			 */
            
		
		
	return "print";
	}
	
	public JSONArray searchDetails(HttpSession session,String partyname,String docNo,String date,String amount,String chequeDt,String chequeNo,String check){
			  JSONArray cellarray = new JSONArray();
			  		  JSONObject cellobj = null;
			  try {
				cellarray= bankReceiptDAO.brvMainSearch(session,partyname,docNo,date,amount,chequeNo,chequeDt,check);
		
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
			
			setHidjqxBankReceiptDate(bankReceiptDate.toString());
			setHidmaindate(hidbankReceiptDate.toString());
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
}
