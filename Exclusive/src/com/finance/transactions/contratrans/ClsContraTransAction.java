package com.finance.transactions.contratrans;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsContraTransAction extends ActionSupport{

	ClsCommon commonDAO= new ClsCommon();
	ClsContraTransDAO contraTransDAO= new ClsContraTransDAO();
	ClsContraTransBean contraTransBean;

	private int txtcontratransdocno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String jqxContraTransDate;
	private String hidjqxContraTransDate;
	private String txtrefno;
	private String cmbtype;
	private String hidcmbtype;
	private int txtfromaccid;
	private String txtfromaccname;
	private int txtfromdocno;
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
	private int chckib;
	private int hidchckib;
	private String cmbbranch;
	private String hidcmbbranch;
	private String cmbtotype;
	private String hidcmbtotype;
	private int txttoaccid;
	private String txttoaccname;
	private int txttodocno;
	private int txttotranid;
	private int txttotrno;
	private String cmbtocurrency;
	private String hidcmbtocurrency;
	private double txttorate;
	private double txttoamount;
	private double txttobaseamount;
	private String hidfromcurrencytype;
	private String hidtocurrencytype;
	
	private String maindate;
	private String hidmaindate;
	
	private String url;
	
	//Print
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
	private String lblinterbranch;
	private String lblpreparedby;
	private String lblpreparedon;
	private String lblpreparedat;
	private String brchName;
	private String firstarray;
	private int txtheader;
	
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
		}
	public int getTxtcontratransdocno() {
		return txtcontratransdocno;
	}

	public void setTxtcontratransdocno(int txtcontratransdocno) {
		this.txtcontratransdocno = txtcontratransdocno;
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

	public String getJqxContraTransDate() {
		return jqxContraTransDate;
	}

	public void setJqxContraTransDate(String jqxContraTransDate) {
		this.jqxContraTransDate = jqxContraTransDate;
	}

	public String getHidjqxContraTransDate() {
		return hidjqxContraTransDate;
	}

	public void setHidjqxContraTransDate(String hidjqxContraTransDate) {
		this.hidjqxContraTransDate = hidjqxContraTransDate;
	}

	public String getTxtrefno() {
		return txtrefno;
	}

	public void setTxtrefno(String txtrefno) {
		this.txtrefno = txtrefno;
	}

	public String getCmbtype() {
		return cmbtype;
	}

	public void setCmbtype(String cmbtype) {
		this.cmbtype = cmbtype;
	}

	public String getHidcmbtype() {
		return hidcmbtype;
	}

	public void setHidcmbtype(String hidcmbtype) {
		this.hidcmbtype = hidcmbtype;
	}

	public int getTxtfromaccid() {
		return txtfromaccid;
	}

	public void setTxtfromaccid(int txtfromaccid) {
		this.txtfromaccid = txtfromaccid;
	}

	public String getTxtfromaccname() {
		return txtfromaccname;
	}

	public void setTxtfromaccname(String txtfromaccname) {
		this.txtfromaccname = txtfromaccname;
	}

	public int getTxtfromdocno() {
		return txtfromdocno;
	}

	public void setTxtfromdocno(int txtfromdocno) {
		this.txtfromdocno = txtfromdocno;
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

	public int getChckib() {
		return chckib;
	}

	public void setChckib(int chckib) {
		this.chckib = chckib;
	}

	public int getHidchckib() {
		return hidchckib;
	}

	public void setHidchckib(int hidchckib) {
		this.hidchckib = hidchckib;
	}

	public String getCmbbranch() {
		return cmbbranch;
	}

	public void setCmbbranch(String cmbbranch) {
		this.cmbbranch = cmbbranch;
	}

	public String getHidcmbbranch() {
		return hidcmbbranch;
	}

	public void setHidcmbbranch(String hidcmbbranch) {
		this.hidcmbbranch = hidcmbbranch;
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

	public int getTxttoaccid() {
		return txttoaccid;
	}

	public void setTxttoaccid(int txttoaccid) {
		this.txttoaccid = txttoaccid;
	}

	public String getTxttoaccname() {
		return txttoaccname;
	}

	public void setTxttoaccname(String txttoaccname) {
		this.txttoaccname = txttoaccname;
	}

	public int getTxttodocno() {
		return txttodocno;
	}

	public void setTxttodocno(int txttodocno) {
		this.txttodocno = txttodocno;
	}

	public int getTxttotranid() {
		return txttotranid;
	}

	public void setTxttotranid(int txttotranid) {
		this.txttotranid = txttotranid;
	}

	public int getTxttotrno() {
		return txttotrno;
	}

	public void setTxttotrno(int txttotrno) {
		this.txttotrno = txttotrno;
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

	public String getLblinterbranch() {
		return lblinterbranch;
	}

	public void setLblinterbranch(String lblinterbranch) {
		this.lblinterbranch = lblinterbranch;
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

	public String getFirstarray() {
		return firstarray;
	}

	public void setFirstarray(String firstarray) {
		this.firstarray = firstarray;
	}

	public int getTxtheader() {
		return txtheader;
	}

	public void setTxtheader(int txtheader) {
		this.txtheader = txtheader;
	}


	java.sql.Date contraTransDate;
	java.sql.Date hidcontraTransDate;
	java.sql.Date chequeDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		session.setAttribute("BRANCHID", getBrchName());
		//System.out.println(getBrchName());
		String mode=getMode();
		ClsContraTransBean bean = new ClsContraTransBean();

		contraTransDate = commonDAO.changeStringtoSqlDate(getJqxContraTransDate());
		hidcontraTransDate = commonDAO.changeStringtoSqlDate(getMaindate());
		chequeDate = commonDAO.changeStringtoSqlDate(getJqxChequeDate());
		
		if(mode.equalsIgnoreCase("A")){
			String mainBranch=session.getAttribute("BRANCHID").toString().trim();
			
			/*Cash Payment Saving*/
			ArrayList cashpaymentarray= new ArrayList();
			cashpaymentarray.add(getTxtfromdocno()+"::"+getCmbfromcurrency()+"::"+getTxtfromrate()+"::false::"+getTxtfromamount()*-1+"::"+getTxtdescription()+"::"+getTxtfrombaseamount()*-1+"::0::0::0");
			cashpaymentarray.add(getTxttodocno()+"::"+getCmbtocurrency()+"::"+getTxttorate()+"::true::"+getTxttoamount()+"::"+getTxtdescription()+"::"+getTxttobaseamount()+"::0::0::0");
			/*Cash Payment Saving Ends*/
			
			/*Ib-Cash Payment Grid Saving*/
			ArrayList ibcashpaymentarray= new ArrayList();
			ibcashpaymentarray.add(getTxtfromdocno()+"::"+getCmbfromcurrency()+"::"+getTxtfromrate()+"::false::"+getTxtfromamount()*-1+"::"+getTxtdescription()+"::"+getTxtfrombaseamount()*-1+"::0::0::0::"+mainBranch+"::"+mainBranch);
			ibcashpaymentarray.add(getTxttodocno()+"::"+getCmbtocurrency()+"::"+getTxttorate()+"::true::"+getTxttoamount()+"::"+getTxtdescription()+"::"+getTxttobaseamount()+"::0::0::0::"+getCmbbranch()+"::"+mainBranch);
			/*Ib-Cash Payment Grid Saving Ends*/
			
			/*Bank Payment Saving*/
			ArrayList bankpaymentarray= new ArrayList();
			bankpaymentarray.add(getTxtfromdocno()+"::"+getCmbfromcurrency()+"::"+getTxtfromrate()+"::false::"+getTxtfromamount()*-1+"::"+getTxtdescription()+"::"+getTxtfrombaseamount()*-1+"::0::0::0::"+getHidchckpdc()+"::"+getTxtpdcacno());
			bankpaymentarray.add(getTxttodocno()+"::"+getCmbtocurrency()+"::"+getTxttorate()+"::true::"+getTxttoamount()+"::"+getTxtdescription()+"::"+getTxttobaseamount()+"::0::0::0::"+getHidchckpdc()+"::"+getTxtpdcacno());
			/*Bank Payment Saving Ends*/
			
			/*Ib-Bank Payment Saving*/
			ArrayList ibbankpaymentarray= new ArrayList();
			ibbankpaymentarray.add(getTxtfromdocno()+"::"+getCmbfromcurrency()+"::"+getTxtfromrate()+"::false::"+getTxtfromamount()*-1+"::"+getTxtdescription()+"::"+getTxtfrombaseamount()*-1+"::0::0::0::"+mainBranch+"::"+mainBranch+"::"+getHidchckpdc()+"::"+getTxtpdcacno());
			ibbankpaymentarray.add(getTxttodocno()+"::"+getCmbtocurrency()+"::"+getTxttorate()+"::true::"+getTxttoamount()+"::"+getTxtdescription()+"::"+getTxttobaseamount()+"::0::0::0::"+getCmbbranch()+"::"+mainBranch+"::"+getHidchckpdc()+"::"+getTxtpdcacno());
			/*Ib-Bank Payment Saving Ends*/
			
			int val=contraTransDAO.insert(contraTransDate,getFormdetailcode(),getTxtrefno(),getCmbtype(),getTxtfromdocno(),getCmbfromcurrency(),getTxtfromrate(),getHidchckpdc(),
					getTxtpdcacno(),getTxtchequeno(),chequeDate,getTxtfromamount(),getTxtfrombaseamount(),getTxtdescription(),getHidchckib(),getCmbbranch(),getCmbtotype(),
					getTxttodocno(),getCmbtocurrency(),getTxttorate(),getTxttoamount(),getTxttobaseamount(),cashpaymentarray,ibcashpaymentarray,bankpaymentarray,ibbankpaymentarray,
					session,request,mode);
			if(val>0.0){

				setTxtcontratransdocno(val);
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
		
		else if(mode.equalsIgnoreCase("EDIT")){
			String mainBranch=session.getAttribute("BRANCHID").toString().trim();
			
			/*Cash Payment Saving*/
			ArrayList cashpaymentarray= new ArrayList();
			cashpaymentarray.add(getTxtfromdocno()+"::"+getCmbfromcurrency()+"::"+getTxtfromrate()+"::false::"+getTxtfromamount()*-1+"::"+getTxtdescription()+"::"+getTxtfrombaseamount()*-1+"::0::0::0");
			cashpaymentarray.add(getTxttodocno()+"::"+getCmbtocurrency()+"::"+getTxttorate()+"::true::"+getTxttoamount()+"::"+getTxtdescription()+"::"+getTxttobaseamount()+"::0::0::0");
			/*Cash Payment Saving Ends*/
			
			/*Ib-Cash Payment Grid Saving*/
			ArrayList ibcashpaymentarray= new ArrayList();
			ibcashpaymentarray.add(getTxtfromdocno()+"::"+getCmbfromcurrency()+"::"+getTxtfromrate()+"::false::"+getTxtfromamount()*-1+"::"+getTxtdescription()+"::"+getTxtfrombaseamount()*-1+"::0::0::0::"+mainBranch+"::"+mainBranch);
			ibcashpaymentarray.add(getTxttodocno()+"::"+getCmbtocurrency()+"::"+getTxttorate()+"::true::"+getTxttoamount()+"::"+getTxtdescription()+"::"+getTxttobaseamount()+"::0::0::0::"+getCmbbranch()+"::"+mainBranch);
			/*Ib-Cash Payment Grid Saving Ends*/
			
			/*Bank Payment Saving*/
			ArrayList bankpaymentarray= new ArrayList();
			bankpaymentarray.add(getTxtfromdocno()+"::"+getCmbfromcurrency()+"::"+getTxtfromrate()+"::false::"+getTxtfromamount()*-1+"::"+getTxtdescription()+"::"+getTxtfrombaseamount()*-1+"::0::0::0::"+getHidchckpdc()+"::"+getTxtpdcacno());
			bankpaymentarray.add(getTxttodocno()+"::"+getCmbtocurrency()+"::"+getTxttorate()+"::true::"+getTxttoamount()+"::"+getTxtdescription()+"::"+getTxttobaseamount()+"::0::0::0::"+getHidchckpdc()+"::"+getTxtpdcacno());
			/*Bank Payment Saving Ends*/
			
			/*Ib-Bank Payment Saving*/
			ArrayList ibbankpaymentarray= new ArrayList();
			ibbankpaymentarray.add(getTxtfromdocno()+"::"+getCmbfromcurrency()+"::"+getTxtfromrate()+"::false::"+getTxtfromamount()*-1+"::"+getTxtdescription()+"::"+getTxtfrombaseamount()*-1+"::0::0::0::"+mainBranch+"::"+mainBranch+"::"+getHidchckpdc()+"::"+getTxtpdcacno());
			ibbankpaymentarray.add(getTxttodocno()+"::"+getCmbtocurrency()+"::"+getTxttorate()+"::true::"+getTxttoamount()+"::"+getTxtdescription()+"::"+getTxttobaseamount()+"::0::0::0::"+getCmbbranch()+"::"+mainBranch+"::"+getHidchckpdc()+"::"+getTxtpdcacno());
			/*Ib-Bank Payment Saving Ends*/
					
			boolean Status=contraTransDAO.edit(getTxtcontratransdocno(),contraTransDate,getFormdetailcode(),getTxtrefno(),getCmbtype(),getTxtfromdocno(),getCmbfromcurrency(),getTxtfromrate(),getHidchckpdc(),
					getTxtpdcacno(),getTxtchequeno(),chequeDate,getTxtfromamount(),getTxtfrombaseamount(),getTxtdescription(),getHidchckib(),getCmbbranch(),getCmbtotype(),getTxttodocno(),getCmbtocurrency(),
					getTxttorate(),getTxttoamount(),getTxttobaseamount(),getTxttotrno(),cashpaymentarray,ibcashpaymentarray,bankpaymentarray,ibbankpaymentarray,session,request,mode);
			if(Status){
				
				setTxtcontratransdocno(getTxtcontratransdocno());
				setTxttotrno(getTxttotrno());
				setData();
				
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setTxtcontratransdocno(getTxtcontratransdocno());
				setTxttotrno(getTxttotrno());
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("E")){

			boolean Status=contraTransDAO.editMaster(getTxtcontratransdocno(),getFormdetailcode(),contraTransDate, getTxtrefno(),getCmbtype(),getTxtdescription(),
					getTxttotrno(),session,mode);
			if(Status){
				setTxtcontratransdocno(getTxtcontratransdocno());
				setTxttotrno(getTxttotrno());
				setData();
				
				setMsg("Updated Successfully");
			    return "success";
		}
		else{
			setTxtcontratransdocno(getTxtcontratransdocno());
			setTxttotrno(getTxttotrno());
			setData();
			setMsg("Not Updated");
			return "fail";
		}
	  }
		
		else if(mode.equalsIgnoreCase("D")){
					
			boolean Status=contraTransDAO.delete(getTxtcontratransdocno(),getCmbtype(),getFormdetailcode(),getTxttotrno(),session,mode);
			if(Status){
				setTxtcontratransdocno(getTxtcontratransdocno());
				setTxttotrno(getTxttotrno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setData();
				setTxtcontratransdocno(getTxtcontratransdocno());
				setTxttotrno(getTxttotrno());
				setMsg("Not Deleted");
				return "fail";
			   }
			}
			
		else if(mode.equalsIgnoreCase("View")){
			
			String branch=null;
			contraTransBean=contraTransDAO.getViewDetails(session,getTxtcontratransdocno());
			
			setJqxContraTransDate(contraTransBean.getJqxContraTransDate());
			setTxtrefno(contraTransBean.getTxtrefno());
			setTxtcontratransdocno(contraTransBean.getTxtcontratransdocno());
			
			setHidcmbtype(contraTransBean.getHidcmbtype());
			setTxtfromdocno(contraTransBean.getTxtfromdocno());
			setTxtfromaccid(contraTransBean.getTxtfromaccid());
			setTxtfromaccname(contraTransBean.getTxtfromaccname());
			setHidcmbfromcurrency(contraTransBean.getHidcmbfromcurrency());
			setHidfromcurrencytype(contraTransBean.getHidfromcurrencytype());
			setTxtfromrate(contraTransBean.getTxtfromrate());
			setHidchckpdc(contraTransBean.getChckpdc());
			setTxtpdcacno(contraTransBean.getTxtpdcacno());
			setTxtchequeno(contraTransBean.getTxtchequeno());
			setJqxChequeDate(contraTransBean.getJqxChequeDate());
			setTxtfromamount(contraTransBean.getTxtfromamount());
			setTxtfrombaseamount(contraTransBean.getTxtfrombaseamount());
			setTxtdescription(contraTransBean.getTxtdescription());
			
			setTxttodocno(contraTransBean.getTxttodocno());
			setTxttotranid(contraTransBean.getTxttotranid());
			setTxttotrno(contraTransBean.getTxttotrno());
			setHidchckib(contraTransBean.getHidchckib());
			setHidcmbbranch(contraTransBean.getHidcmbbranch());
			setHidcmbtotype(contraTransBean.getHidcmbtotype());
			setTxttoaccid(contraTransBean.getTxttoaccid());
			setTxttoaccname(contraTransBean.getTxttoaccname());
			setHidcmbtocurrency(contraTransBean.getHidcmbtocurrency());
			setHidtocurrencytype(contraTransBean.getHidtocurrencytype());
			setTxttorate(contraTransBean.getTxttorate());
			setTxttoamount(contraTransBean.getTxttoamount());
			setTxttobaseamount(contraTransBean.getTxttobaseamount());
			setMaindate(contraTransBean.getMaindate());
			setFormdetailcode(contraTransBean.getFormdetailcode());
			
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
		contraTransBean=contraTransDAO.getPrint(request,docno,branch,header);
		setUrl(commonDAO.getPrintPath("COT"));
		setLblcompname(contraTransBean.getLblcompname());
		setLblcompaddress(contraTransBean.getLblcompaddress());
		setLblpobox(contraTransBean.getLblpobox());
		setLblprintname("Contra Trans");
		setLblcomptel(contraTransBean.getLblcomptel());
		setLblcompfax(contraTransBean.getLblcompfax());
		setLblbranch(contraTransBean.getLblbranch());
		setLbllocation(contraTransBean.getLbllocation());
		setLblservicetax(contraTransBean.getLblservicetax());
		setLblpan(contraTransBean.getLblpan());
		setLblcstno(contraTransBean.getLblcstno());
		
		setLblvoucherno(contraTransBean.getLblvoucherno());
		setLbldate(contraTransBean.getLbldate());
		setLblnetamount(contraTransBean.getLblnetamount());
		setLblnetamountwords(contraTransBean.getLblnetamountwords());
		setLblpaidtoname(contraTransBean.getLblpaidtoname());
		setLblchqno(contraTransBean.getLblchqno());
		setLblchqdate(contraTransBean.getLblchqdate());
		setLblreceivedname(contraTransBean.getLblreceivedname());
		setLbldescription(contraTransBean.getLbldescription());
		setLblpreparedby(contraTransBean.getLblpreparedby());
		setLblpreparedon(contraTransBean.getLblpreparedon());
		setLblpreparedat(contraTransBean.getLblpreparedat());
		
		setLblinterbranch(contraTransBean.getLblinterbranch());
		setFirstarray(contraTransBean.getFirstarray());
		setTxtheader(contraTransBean.getTxtheader());
			
		return "print";
	}
	
	public JSONArray searchDetails(HttpSession session,String partyname,String docNo,String date,String amount,String chequeDt,String chequeNo,String check){
		  JSONArray cellarray = new JSONArray();
		  		  JSONObject cellobj = null;
		  try {
			cellarray= contraTransDAO.cotMainSearch(session,partyname,docNo,date,amount,chequeNo,chequeDt,check);
	
		  } catch (SQLException e) {
			  e.printStackTrace();
			  }
		return cellarray;
	}
	
	public void setData(){
		
		setHidjqxContraTransDate(contraTransDate.toString());
		setHidmaindate(hidcontraTransDate.toString());
		setTxtrefno(getTxtrefno());
		
		setHidcmbtype(getCmbtype());
		setTxtfromdocno(getTxtfromdocno());
		setTxtfromaccid(getTxtfromaccid());
		setTxtfromaccname(getTxtfromaccname());
		setHidcmbfromcurrency(getCmbfromcurrency());
		setHidfromcurrencytype(getHidfromcurrencytype());
		setTxtfromrate(getTxtfromrate());
		setHidchckpdc(getHidchckpdc());
		setTxtpdcacno(getTxtpdcacno());
		setTxtchequeno(getTxtchequeno());
		setHidjqxChequeDate(chequeDate.toString());
		setTxtfromamount(getTxtfromamount());
		setTxtfrombaseamount(getTxtfrombaseamount());
		setTxtdescription(getTxtdescription());
		
		setHidchckib(getHidchckib());
		setHidcmbbranch(getCmbbranch());
		setHidcmbtotype(getCmbtotype());
		setTxttodocno(getTxttodocno());
		setTxttoaccid(getTxttoaccid());
		setTxttoaccname(getTxttoaccname());
		setHidcmbtocurrency(getCmbtocurrency());
		setHidtocurrencytype(getHidtocurrencytype());
		setTxttorate(getTxttorate());
		setTxttoamount(getTxttoamount());
		setTxttobaseamount(getTxttobaseamount());
		
		setFormdetailcode(getFormdetailcode());
	}
}

