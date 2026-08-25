package com.finance.transactions.securitycheque;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
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
public class ClsSecurityChequeAction extends ActionSupport{

	ClsConnection connDAO= new ClsConnection();
	ClsCommon commonDAO= new ClsCommon();
	ClsSecurityChequeDAO securityChqDAO= new ClsSecurityChequeDAO();
	ClsSecurityChequeBean securityChqBean;

	private int txtsecuritychequedocno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String jqxSecurityChequeDate;
	private String hidjqxSecurityChequeDate;
	private String cmbtotype;
	private String hidcmbtotype;
	private int txttodocno;
	private String txttoaccid;
	private String txttoaccname;
	private int txtfromdocno;
	private String txtfromaccid;
	private String txtfromaccname;
	private String txtchequename;
	private String txtchequeno;
	private String jqxValidUpTo;
	private String hidjqxValidUpTo;
	private String chckchqdate;
	private String hidchckchqdate;
	private String jqxChequeDate;
	private String hidjqxChequeDate;
	private String chckamount;
	private String hidchckamount;
	private double txtamount;
	private String txtremarks;
	
	private String maindate;
	private String hidmaindate;
	
	//Print
	private String url;
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
	
	private String lblvoucherno;
	private String lbldate;
	private String lblnetamount;
	private String lblnetamountwords;
	private String lblpaidtoname;
	private String lblchqno;
	private String lblchqdate;
	private String lblreceivedname;
	private String lbldescription;
	private String lblvalidupto;
	private String lblpreparedby;
	private String lblpreparedon;
	private String lblpreparedat;
	
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
	
	public int getTxtsecuritychequedocno() {
		return txtsecuritychequedocno;
	}

	public void setTxtsecuritychequedocno(int txtsecuritychequedocno) {
		this.txtsecuritychequedocno = txtsecuritychequedocno;
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

	public String getJqxSecurityChequeDate() {
		return jqxSecurityChequeDate;
	}

	public void setJqxSecurityChequeDate(String jqxSecurityChequeDate) {
		this.jqxSecurityChequeDate = jqxSecurityChequeDate;
	}

	public String getHidjqxSecurityChequeDate() {
		return hidjqxSecurityChequeDate;
	}

	public void setHidjqxSecurityChequeDate(String hidjqxSecurityChequeDate) {
		this.hidjqxSecurityChequeDate = hidjqxSecurityChequeDate;
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

	public String getJqxValidUpTo() {
		return jqxValidUpTo;
	}

	public void setJqxValidUpTo(String jqxValidUpTo) {
		this.jqxValidUpTo = jqxValidUpTo;
	}

	public String getHidjqxValidUpTo() {
		return hidjqxValidUpTo;
	}

	public void setHidjqxValidUpTo(String hidjqxValidUpTo) {
		this.hidjqxValidUpTo = hidjqxValidUpTo;
	}

	public String getChckchqdate() {
		return chckchqdate;
	}

	public void setChckchqdate(String chckchqdate) {
		this.chckchqdate = chckchqdate;
	}

	public String getHidchckchqdate() {
		return hidchckchqdate;
	}

	public void setHidchckchqdate(String hidchckchqdate) {
		this.hidchckchqdate = hidchckchqdate;
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

	public String getChckamount() {
		return chckamount;
	}

	public void setChckamount(String chckamount) {
		this.chckamount = chckamount;
	}

	public String getHidchckamount() {
		return hidchckamount;
	}

	public void setHidchckamount(String hidchckamount) {
		this.hidchckamount = hidchckamount;
	}

	public double getTxtamount() {
		return txtamount;
	}

	public void setTxtamount(double txtamount) {
		this.txtamount = txtamount;
	}
	
	public String getTxtremarks() {
		return txtremarks;
	}

	public void setTxtremarks(String txtremarks) {
		this.txtremarks = txtremarks;
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

	public String getLblvoucherno() {
		return lblvoucherno;
	}

	public void setLblvoucherno(String lblvoucherno) {
		this.lblvoucherno = lblvoucherno;
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

	public String getLblpaidtoname() {
		return lblpaidtoname;
	}

	public void setLblpaidtoname(String lblpaidtoname) {
		this.lblpaidtoname = lblpaidtoname;
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

	public String getLblreceivedname() {
		return lblreceivedname;
	}

	public void setLblreceivedname(String lblreceivedname) {
		this.lblreceivedname = lblreceivedname;
	}

	public String getLbldescription() {
		return lbldescription;
	}

	public void setLbldescription(String lbldescription) {
		this.lbldescription = lbldescription;
	}

	public String getLblvalidupto() {
		return lblvalidupto;
	}

	public void setLblvalidupto(String lblvalidupto) {
		this.lblvalidupto = lblvalidupto;
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
	
	java.sql.Date securityChequeDate;
	java.sql.Date hidsecurityChequeDate;
	java.sql.Date validUpToDate;
	java.sql.Date chequeDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		session.setAttribute("BRANCHID", getBrchName());
		//System.out.println(getBrchName());
		String mode=getMode();
		ClsSecurityChequeBean bean = new ClsSecurityChequeBean();
		securityChequeDate = commonDAO.changeStringtoSqlDate(getJqxSecurityChequeDate());
		hidsecurityChequeDate = commonDAO.changeStringtoSqlDate(getMaindate());
		validUpToDate = commonDAO.changeStringtoSqlDate(getJqxValidUpTo());
		chequeDate = commonDAO.changeStringtoSqlDate(getJqxChequeDate());
		
		if(mode.equalsIgnoreCase("A")){
			
						int val=securityChqDAO.insert(securityChequeDate,getFormdetailcode(),getCmbtotype(),getTxttodocno(),getTxtfromdocno(),getTxtchequeno(),validUpToDate,getHidchckchqdate(),chequeDate,getHidchckamount(),getTxtamount(),getTxtremarks(),getTxtchequename(),session,mode);
						if(val>0.0){
							
							setTxtsecuritychequedocno(val);
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
		
		else if(mode.equalsIgnoreCase("E")){

			boolean Status=securityChqDAO.edit(getTxtsecuritychequedocno(),securityChequeDate,getFormdetailcode(),getCmbtotype(),getTxttodocno(),getTxtfromdocno(),getTxtchequeno(),validUpToDate,getHidchckchqdate(),chequeDate,getHidchckamount(),getTxtamount(),getTxtremarks(),getTxtchequename(),session,mode);
			if(Status){

				setTxtsecuritychequedocno(getTxtsecuritychequedocno());
				setData();
				
				setMsg("Updated Successfully");
			    return "success";
		}
		else{
			setTxtsecuritychequedocno(getTxtsecuritychequedocno());
			setData();
			setMsg("Not Updated");
			return "fail";
		}
	  }
		
		
		else if(mode.equalsIgnoreCase("D")){
			
			boolean Status=securityChqDAO.delete(getTxtsecuritychequedocno(),getFormdetailcode(),session,mode);
			if(Status){
				
				setTxtsecuritychequedocno(getTxtsecuritychequedocno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setData();
				setMsg("Not Deleted");
				return "fail";
			   }
			}
		
		 else if(mode.equalsIgnoreCase("View")){
	
			String branch=null;
			securityChqBean=securityChqDAO.getViewDetails(session,getTxtsecuritychequedocno());
			
			setJqxSecurityChequeDate(securityChqBean.getJqxSecurityChequeDate());
			
			setHidcmbtotype(securityChqBean.getHidcmbtotype());
			setTxttodocno(securityChqBean.getTxttodocno());
			setTxttoaccid(securityChqBean.getTxttoaccid());
			setTxttoaccname(securityChqBean.getTxttoaccname());
			setTxtfromdocno(securityChqBean.getTxtfromdocno());
			setTxtfromaccid(securityChqBean.getTxtfromaccid());
			setTxtfromaccname(securityChqBean.getTxtfromaccname());
			
			setTxtchequename(securityChqBean.getTxtchequename());
			setTxtchequeno(securityChqBean.getTxtchequeno());
			setJqxValidUpTo(securityChqBean.getJqxValidUpTo());
			setHidchckchqdate(securityChqBean.getHidchckchqdate());
			setJqxChequeDate(securityChqBean.getJqxChequeDate());
			setHidchckamount(securityChqBean.getHidchckamount());
			setTxtamount(securityChqBean.getTxtamount());
			setTxtremarks(securityChqBean.getTxtremarks());
			setMaindate(securityChqBean.getMaindate());
			
			setFormdetailcode(securityChqBean.getFormdetailcode());
			
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
		securityChqBean=securityChqDAO.getPrint(request,docno,branch,header);
		setUrl(commonDAO.getPrintPath("SEC"));
		setLblcompname(securityChqBean.getLblcompname());
		setLblcompaddress(securityChqBean.getLblcompaddress());
		setLblpobox(securityChqBean.getLblpobox());
		setLblprintname("Security Cheque");
		setLblcomptel(securityChqBean.getLblcomptel());
		setLblcompfax(securityChqBean.getLblcompfax());
		setLblbranch(securityChqBean.getLblbranch());
		setLbllocation(securityChqBean.getLbllocation());
		setLblservicetax(securityChqBean.getLblservicetax());
		setLblpan(securityChqBean.getLblpan());
		setLblcstno(securityChqBean.getLblcstno());
		
		setLblvoucherno(securityChqBean.getLblvoucherno());
		setLbldate(securityChqBean.getLbldate());
		setLblnetamount(securityChqBean.getLblnetamount());
		setLblnetamountwords(securityChqBean.getLblnetamountwords());
		setLblpaidtoname(securityChqBean.getLblpaidtoname());
		setLblchqno(securityChqBean.getLblchqno());
		setLblchqdate(securityChqBean.getLblchqdate());
		setLblreceivedname(securityChqBean.getLblreceivedname());
		setLbldescription(securityChqBean.getLbldescription());
		setLblpreparedby(securityChqBean.getLblpreparedby());
		setLblpreparedon(securityChqBean.getLblpreparedon());
		setLblpreparedat(securityChqBean.getLblpreparedat());
		setLblvalidupto(securityChqBean.getLblvalidupto());
		
		setTxtheader(securityChqBean.getTxtheader());
		
		return "print";
	}
	
	public String printChequeAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		int docno=Integer.parseInt(request.getParameter("docno"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		securityChqBean=securityChqDAO.getChequePrint(docno,branch);
		setLblbankid(securityChqBean.getLblbankid());
		setLblbankname(securityChqBean.getLblbankname());
		setLblpageswidth(securityChqBean.getLblpageswidth());
		setLblpagesheight(securityChqBean.getLblpagesheight());
		setLblpagewidth(securityChqBean.getLblpagewidth());
		setLblpageheight(securityChqBean.getLblpageheight());
		setLbldatex(securityChqBean.getLbldatex());
		setLbldatey(securityChqBean.getLbldatey());
		setLblpaytovertical(securityChqBean.getLblpaytovertical());
		setLblpaytohorizontal(securityChqBean.getLblpaytohorizontal());
		setLblpaytolength(securityChqBean.getLblpaytolength());
		setLblaccountpayingx(securityChqBean.getLblaccountpayingx());
		setLblaccountpayingy(securityChqBean.getLblaccountpayingy());
		setLblamtwordsvertical(securityChqBean.getLblamtwordsvertical());
		setLblamtwordshorizontal(securityChqBean.getLblamtwordshorizontal());
		setLblamtwordslength(securityChqBean.getLblamtwordslength());
		setLblamountx(securityChqBean.getLblamountx());
		setLblamounty(securityChqBean.getLblamounty());
		setLblamtwords1vertical(securityChqBean.getLblamtwords1vertical());
		setLblamtwords1horizontal(securityChqBean.getLblamtwords1horizontal());
		setLblamtwords1length(securityChqBean.getLblamtwords1length());
		
		setLblchequedate(securityChqBean.getLblchequedate());
		setLblpaidto(securityChqBean.getLblpaidto());
		setLblaccountno(securityChqBean.getLblaccountno());
		setLblamountwords(securityChqBean.getLblamountwords());
		setLblamountwords1(securityChqBean.getLblamountwords1());
		setLblamount(securityChqBean.getLblamount());
		setPrinturl(securityChqBean.getPrinturl());
		
		if(getPrinturl().contains(".jrxml")) {
			Connection conn = null;
			
			try {
				 conn = connDAO.getMyConnection();
				 param = new HashMap();
            
				 param.put("date", securityChqBean.getLblchequedate());
				 param.put("payto", securityChqBean.getLblpaidto());
				 param.put("amountinwords", securityChqBean.getLblamountwords()+" "+(securityChqBean.getLblamountwords1()==null?" ":securityChqBean.getLblamountwords1()));
				 param.put("amount", "#"+securityChqBean.getLblamount()+"#");
	        	 
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
			cellarray= securityChqDAO.secMainSearch(session,partyname,docNo,date,amount,chequeNo,chequeDt,check);
	
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
			if(!(mode.equalsIgnoreCase("D"))){
			setHidjqxSecurityChequeDate(securityChequeDate.toString());
			setHidmaindate(hidsecurityChequeDate.toString());
			setHidjqxValidUpTo(validUpToDate.toString());
			setHidjqxChequeDate(chequeDate.toString());
			}
			setHidcmbtotype(getCmbtotype());
			setTxttodocno(getTxttodocno());
			setTxttoaccid(getTxttoaccid());
			setTxttoaccname(getTxttoaccname());
			setTxtfromdocno(getTxtfromdocno());
			setTxtfromaccid(getTxtfromaccid());
			setTxtfromaccname(getTxtfromaccname());
			setTxtchequename(getTxtchequename());
			setTxtchequeno(getTxtchequeno());
			
			setHidchckchqdate(getHidchckchqdate());
			setHidchckamount(getHidchckamount());
			setTxtamount(getTxtamount());
			setTxtremarks(getTxtremarks());
			setFormdetailcode(getFormdetailcode());
		}
}

