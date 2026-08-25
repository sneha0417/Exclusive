package com.finance.transactions.unclearedchequepayment;

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
public class ClsUnclearedChequePaymentAction extends ActionSupport{

	ClsConnection connDAO= new ClsConnection();
	ClsCommon commonDAO= new ClsCommon();
	ClsUnclearedChequePaymentDAO unclearedChequePayDAO= new ClsUnclearedChequePaymentDAO();
	ClsUnclearedChequePaymentBean unclearedChequePaymentBean;
	
	private int txtunclearedchequepaydocno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String jqxUnclearedChequePaymentDate;
	private String hidjqxUnclearedChequePaymentDate;
	private String txtrefno;
	private int txtfromdocno;
	private String txtfromaccid;
	private String txtfromaccname;
	private String cmbfromcurrency;
	private String hidcmbfromcurrency;
	private String hidfromcurrencytype;
	private double txtfromrate;
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
	private String txttoaccid;
	private String txttoaccname;
	private String cmbtocurrency;
	private String hidcmbtocurrency;
	private String hidtocurrencytype;
	private double txttorate;
	private double txttoamount;
	private double txttobaseamount;
	
	private double txtdrtotal;
	private double txtcrtotal;
	
	private String maindate;
	private String hidmaindate;
	
	private String url;
	
	//Uncleared Cheque Payment Grid
	private int gridlength;
	
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
	
	public int getTxtunclearedchequepaydocno() {
		return txtunclearedchequepaydocno;
	}
	public void setTxtunclearedchequepaydocno(int txtunclearedchequepaydocno) {
		this.txtunclearedchequepaydocno = txtunclearedchequepaydocno;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
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
	public String getJqxUnclearedChequePaymentDate() {
		return jqxUnclearedChequePaymentDate;
	}
	public void setJqxUnclearedChequePaymentDate(
			String jqxUnclearedChequePaymentDate) {
		this.jqxUnclearedChequePaymentDate = jqxUnclearedChequePaymentDate;
	}
	public String getHidjqxUnclearedChequePaymentDate() {
		return hidjqxUnclearedChequePaymentDate;
	}
	public void setHidjqxUnclearedChequePaymentDate(
			String hidjqxUnclearedChequePaymentDate) {
		this.hidjqxUnclearedChequePaymentDate = hidjqxUnclearedChequePaymentDate;
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
	public String getHidfromcurrencytype() {
		return hidfromcurrencytype;
	}
	public void setHidfromcurrencytype(String hidfromcurrencytype) {
		this.hidfromcurrencytype = hidfromcurrencytype;
	}
	public double getTxtfromrate() {
		return txtfromrate;
	}
	public void setTxtfromrate(double txtfromrate) {
		this.txtfromrate = txtfromrate;
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
	public String getHidtocurrencytype() {
		return hidtocurrencytype;
	}
	public void setHidtocurrencytype(String hidtocurrencytype) {
		this.hidtocurrencytype = hidtocurrencytype;
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
	
	java.sql.Date unclearedChequePaymentDate;
	java.sql.Date hidunclearedChequePaymentDate;
	java.sql.Date chequeDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		session.setAttribute("BRANCHID", getBrchName());
		//System.out.println(getBrchName());
		String mode=getMode();
		ClsUnclearedChequePaymentBean bean = new ClsUnclearedChequePaymentBean();
		
		unclearedChequePaymentDate = commonDAO.changeStringtoSqlDate(getJqxUnclearedChequePaymentDate());
		hidunclearedChequePaymentDate = commonDAO.changeStringtoSqlDate(getMaindate());
		chequeDate = commonDAO.changeStringtoSqlDate(getJqxChequeDate());
		
		if(mode.equalsIgnoreCase("A")){
			/*Uncleared Cheque Payment Grid Saving*/
			ArrayList<String> unclearedchequepaymentarray= new ArrayList<String>();
			unclearedchequepaymentarray.add(getTxtfromdocno()+"::"+getCmbfromcurrency()+"::"+getTxtfromrate()+"::false::"+getTxtfromamount()*-1+"::"+getTxtdescription()+"::"+getTxtfrombaseamount()*-1+"::0::0::0");
			unclearedchequepaymentarray.add(getTxttodocno()+"::"+getCmbtocurrency()+"::"+getTxttorate()+"::true::"+getTxttoamount()+"::"+getTxtdescription()+"::"+getTxttobaseamount()+"::0::0::0");
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				unclearedchequepaymentarray.add(temp+"::0");
			}
			/*Uncleared Cheque Payment Grid Saving Ends*/
			          
						int val=unclearedChequePayDAO.insert(unclearedChequePaymentDate,getFormdetailcode(),getTxtrefno(),getTxtfromrate(),chequeDate,getTxtchequeno(),getTxtchequename(),0,getTxtdescription(),getTxtdrtotal(),getTxttodocno(),unclearedchequepaymentarray,session,request,mode);
						
						if(val>0.0){

							setTxtunclearedchequepaydocno(val);
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
		
		else if(mode.equalsIgnoreCase("EDIT")){
			/*Updating Uncleared Cheque Payment Grid*/
			ArrayList<String> unclearedchequepaymentarray= new ArrayList<String>();
			unclearedchequepaymentarray.add(getTxtfromdocno()+"::"+getCmbfromcurrency()+"::"+getTxtfromrate()+"::false::"+getTxtfromamount()*-1+"::"+getTxtdescription()+"::"+getTxtfrombaseamount()*-1+"::0::0::0");
			unclearedchequepaymentarray.add(getTxttodocno()+"::"+getCmbtocurrency()+"::"+getTxttorate()+"::true::"+getTxttoamount()+"::"+getTxtdescription()+"::"+getTxttobaseamount()+"::0::0::0");
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				unclearedchequepaymentarray.add(temp+"::0");
			}
			/*Updating Uncleared Cheque Payment Grid Ends*/
			
			boolean Status=unclearedChequePayDAO.edit(getTxtunclearedchequepaydocno(),getFormdetailcode(),unclearedChequePaymentDate,getTxtrefno(),getTxtdescription(),getTxtfromrate(),getTxtdrtotal(),getTxttodocno(),chequeDate,getTxtchequeno(),getTxtchequename(),0,unclearedchequepaymentarray,session,mode);
			if(Status){
				
				setTxtunclearedchequepaydocno(getTxtunclearedchequepaydocno());
				setData();
				
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setTxtunclearedchequepaydocno(getTxtunclearedchequepaydocno());
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("E")){

			boolean Status=unclearedChequePayDAO.editMaster(getTxtunclearedchequepaydocno(),getFormdetailcode(),unclearedChequePaymentDate,getTxtrefno(),getTxtdescription(),getTxtfromrate(),getTxtdrtotal(),getTxttodocno(),chequeDate,getTxtchequeno(),0,session);
			if(Status){
				
				setTxtunclearedchequepaydocno(getTxtunclearedchequepaydocno());
				setData();
				
				setMsg("Updated Successfully");
			    return "success";
		}
		else{
			setTxtunclearedchequepaydocno(getTxtunclearedchequepaydocno());
			setData();
			
			setMsg("Not Updated");
			return "fail";
		}
	  }
		
		
		else if(mode.equalsIgnoreCase("D")){
			
			boolean Status=unclearedChequePayDAO.delete(getTxtunclearedchequepaydocno(),getFormdetailcode(),getTxttodocno(),session);
			if(Status){
				
				setTxtunclearedchequepaydocno(getTxtunclearedchequepaydocno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setTxtunclearedchequepaydocno(getTxtunclearedchequepaydocno());
				setData();
				setMsg("Not Deleted");
				return "fail";
			   }
			}
		
		else if(mode.equalsIgnoreCase("View")){
	
			String branch=null;
			unclearedChequePaymentBean=unclearedChequePayDAO.getViewDetails(session,getTxtunclearedchequepaydocno());
			
			setTxtunclearedchequepaydocno(unclearedChequePaymentBean.getTxtunclearedchequepaydocno());
			setJqxUnclearedChequePaymentDate(unclearedChequePaymentBean.getJqxUnclearedChequePaymentDate());
			setTxtrefno(unclearedChequePaymentBean.getTxtrefno());
			
			setTxtfromdocno(unclearedChequePaymentBean.getTxtfromdocno());
			setTxtfromaccid(unclearedChequePaymentBean.getTxtfromaccid());
			setTxtfromaccname(unclearedChequePaymentBean.getTxtfromaccname());
			setHidcmbfromcurrency(unclearedChequePaymentBean.getHidcmbfromcurrency());
			setHidfromcurrencytype(unclearedChequePaymentBean.getHidfromcurrencytype());
			setTxtfromrate(unclearedChequePaymentBean.getTxtfromrate());
			setTxtchequeno(unclearedChequePaymentBean.getTxtchequeno());
			setJqxChequeDate(unclearedChequePaymentBean.getJqxChequeDate());
			setTxtchequename(unclearedChequePaymentBean.getTxtchequename());
			setTxtfromamount(unclearedChequePaymentBean.getTxtfromamount());
			setTxtfrombaseamount(unclearedChequePaymentBean.getTxtfrombaseamount());
			setTxtdescription(unclearedChequePaymentBean.getTxtdescription());
			
			setTxttodocno(unclearedChequePaymentBean.getTxttodocno());
			setHidcmbtotype(unclearedChequePaymentBean.getHidcmbtotype());
			setTxttoaccid(unclearedChequePaymentBean.getTxttoaccid());
			setTxttoaccname(unclearedChequePaymentBean.getTxttoaccname());
			setHidcmbtocurrency(unclearedChequePaymentBean.getHidcmbtocurrency());
			setHidtocurrencytype(unclearedChequePaymentBean.getHidtocurrencytype());
			setTxttorate(unclearedChequePaymentBean.getTxttorate());
			setTxttoamount(unclearedChequePaymentBean.getTxttoamount());
			setTxttobaseamount(unclearedChequePaymentBean.getTxttobaseamount());
			
			setTxtdrtotal(unclearedChequePaymentBean.getTxtdrtotal());
			setTxtcrtotal(unclearedChequePaymentBean.getTxtdrtotal());
			setMaindate(unclearedChequePaymentBean.getMaindate());
			setFormdetailcode(unclearedChequePaymentBean.getFormdetailcode());
			
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
		unclearedChequePaymentBean=unclearedChequePayDAO.getPrint(request,docno,branch,header);
		
		setLblmainname("Paid To");
		setUrl(commonDAO.getPrintPath("UCP"));
		setLblcompname(unclearedChequePaymentBean.getLblcompname());
		setLblcompaddress(unclearedChequePaymentBean.getLblcompaddress());
		setLblpobox(unclearedChequePaymentBean.getLblpobox());
		setLblprintname(unclearedChequePaymentBean.getLblprintname());
		setLblcomptel(unclearedChequePaymentBean.getLblcomptel());
		setLblcompfax(unclearedChequePaymentBean.getLblcompfax());
		setLblbranch(unclearedChequePaymentBean.getLblbranch());
		setLbllocation(unclearedChequePaymentBean.getLbllocation());
		setLblservicetax(unclearedChequePaymentBean.getLblservicetax());
		setLblpan(unclearedChequePaymentBean.getLblpan());
		setLblcstno(unclearedChequePaymentBean.getLblcstno());
		setLblname(unclearedChequePaymentBean.getLblname());
		setLblvoucherno(unclearedChequePaymentBean.getLblvoucherno());
		setLbldescription(unclearedChequePaymentBean.getLbldescription());
		setLbldate(unclearedChequePaymentBean.getLbldate());
		setLblnetamount(unclearedChequePaymentBean.getLblnetamount());
		setLblnetamountwords(unclearedChequePaymentBean.getLblnetamountwords());
		setLbldebittotal(unclearedChequePaymentBean.getLbldebittotal());
		setLblcredittotal(unclearedChequePaymentBean.getLblcredittotal());
		setLblchqno(unclearedChequePaymentBean.getLblchqno());
		setLblchqdate(unclearedChequePaymentBean.getLblchqdate());
		setLblpreparedby(unclearedChequePaymentBean.getLblpreparedby());
		setLblpreparedon(unclearedChequePaymentBean.getLblpreparedon());
		setLblpreparedat(unclearedChequePaymentBean.getLblpreparedat());
		
		// for hide
		setFirstarray(unclearedChequePaymentBean.getFirstarray());
		setTxtheader(unclearedChequePaymentBean.getTxtheader());
		
	
	return "print";
	}
	
	public String printChequeAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		int docno=Integer.parseInt(request.getParameter("docno"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		unclearedChequePaymentBean=unclearedChequePayDAO.getChequePrint(docno,branch);
		setLblbankid(unclearedChequePaymentBean.getLblbankid());
		setLblbankname(unclearedChequePaymentBean.getLblbankname());
		setLblpageswidth(unclearedChequePaymentBean.getLblpageswidth());
		setLblpagesheight(unclearedChequePaymentBean.getLblpagesheight());
		setLblpagewidth(unclearedChequePaymentBean.getLblpagewidth());
		setLblpageheight(unclearedChequePaymentBean.getLblpageheight());
		setLbldatex(unclearedChequePaymentBean.getLbldatex());
		setLbldatey(unclearedChequePaymentBean.getLbldatey());
		setLblpaytovertical(unclearedChequePaymentBean.getLblpaytovertical());
		setLblpaytohorizontal(unclearedChequePaymentBean.getLblpaytohorizontal());
		setLblpaytolength(unclearedChequePaymentBean.getLblpaytolength());
		setLblaccountpayingx(unclearedChequePaymentBean.getLblaccountpayingx());
		setLblaccountpayingy(unclearedChequePaymentBean.getLblaccountpayingy());
		setLblamtwordsvertical(unclearedChequePaymentBean.getLblamtwordsvertical());
		setLblamtwordshorizontal(unclearedChequePaymentBean.getLblamtwordshorizontal());
		setLblamtwordslength(unclearedChequePaymentBean.getLblamtwordslength());
		setLblamountx(unclearedChequePaymentBean.getLblamountx());
		setLblamounty(unclearedChequePaymentBean.getLblamounty());
		setLblamtwords1vertical(unclearedChequePaymentBean.getLblamtwords1vertical());
		setLblamtwords1horizontal(unclearedChequePaymentBean.getLblamtwords1horizontal());
		setLblamtwords1length(unclearedChequePaymentBean.getLblamtwords1length());
		
		setLblchequedate(unclearedChequePaymentBean.getLblchequedate());
		setLblpaidto(unclearedChequePaymentBean.getLblpaidto());
		setLblaccountno(unclearedChequePaymentBean.getLblaccountno());
		setLblamountwords(unclearedChequePaymentBean.getLblamountwords());
		setLblamountwords1(unclearedChequePaymentBean.getLblamountwords1());
		setLblamount(unclearedChequePaymentBean.getLblamount());
		setPrinturl(unclearedChequePaymentBean.getPrinturl());
		
		if(getPrinturl().contains(".jrxml")) {
			Connection conn = null;
			
			try {
				 conn = connDAO.getMyConnection();
				 param = new HashMap();
            
				 param.put("date", unclearedChequePaymentBean.getLblchequedate());
				 param.put("payto", unclearedChequePaymentBean.getLblpaidto());
				 param.put("amountinwords", unclearedChequePaymentBean.getLblamountwords()+" "+(unclearedChequePaymentBean.getLblamountwords1()==null?" ":unclearedChequePaymentBean.getLblamountwords1()));
				 param.put("amount", "#"+unclearedChequePaymentBean.getLblamount()+"#");
	        	 
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
	
		public JSONArray searchDetails(HttpSession session,String partyname,String docNo,String date,String amount,String chequeDt,String chequeNo,String check){
			  JSONArray cellarray = new JSONArray();
			  		  JSONObject cellobj = null;
			  try {
				cellarray= unclearedChequePayDAO.ucpMainSearch(session,partyname,docNo,date,amount,chequeNo,chequeDt,check);
		
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
			
			setHidjqxUnclearedChequePaymentDate(unclearedChequePaymentDate.toString());
			setHidmaindate(hidunclearedChequePaymentDate.toString());
			setTxtrefno(getTxtrefno());
			
			setTxtfromdocno(getTxtfromdocno());
			setTxtfromaccid(getTxtfromaccid());
			setTxtfromaccname(getTxtfromaccname());
			setHidcmbfromcurrency(getCmbfromcurrency());
			setHidfromcurrencytype(getHidfromcurrencytype());
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
			
			setTxtdrtotal(getTxtdrtotal());
			setTxtcrtotal(getTxtdrtotal());
			setFormdetailcode(getFormdetailcode());
		}
}
