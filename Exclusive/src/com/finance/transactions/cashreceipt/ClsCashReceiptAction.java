package com.finance.transactions.cashreceipt;

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

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsCashReceiptAction extends ActionSupport{

	ClsCommon commonDAO= new ClsCommon();
	ClsCashReceiptDAO cashReceiptDAO= new ClsCashReceiptDAO();
	ClsCashReceiptBean cashReceiptBean;
	ClsConnection connDAO = new ClsConnection();
	private Map<String, Object> param=null;
	private String applyquery;

	public String getApplyquery() {
		return applyquery;
	}
	public void setApplyquery(String applyquery) {
		this.applyquery = applyquery;
	}
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	
	private int txtcashreceiptdocno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String jqxCashReceiptDate;
	private String hidjqxCashReceiptDate;
	private String txtrefno;
	private int txtfromdocno;
	private String txtfromaccid;
	private String txtfromaccname;
	private String cmbfromcurrency;
	private String hidcmbfromcurrency;
	private double txtfromrate;
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
	
	//Cash Payment Grid
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
	private String lblcomptrn;
	private String lblname;
	private String lblvoucherno;
	private String lbldescription;
	private String lbldate;
	private String lblnetamount;
	private String lblnetamountwords;
	private String lbldebittotal;
	private String lblcredittotal;
	private String lblpreparedby;
	private String lblpreparedon;
	private String lblpreparedat;
	private String brchName;
	
	//for hide
	private int firstarray;
	private int secarray;
	private int txtheader;
	
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}
	public String getLblcomptrn() {
		return lblcomptrn;
	}

	public void setLblcomptrn(String lblcomptrn) {
		this.lblcomptrn = lblcomptrn;
	}

	public int getTxtcashreceiptdocno() {
		return txtcashreceiptdocno;
	}
	public void setTxtcashreceiptdocno(int txtcashreceiptdocno) {
		this.txtcashreceiptdocno = txtcashreceiptdocno;
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
	public String getJqxCashReceiptDate() {
		return jqxCashReceiptDate;
	}
	public void setJqxCashReceiptDate(String jqxCashReceiptDate) {
		this.jqxCashReceiptDate = jqxCashReceiptDate;
	}
	public String getHidjqxCashReceiptDate() {
		return hidjqxCashReceiptDate;
	}
	public void setHidjqxCashReceiptDate(String hidjqxCashReceiptDate) {
		this.hidjqxCashReceiptDate = hidjqxCashReceiptDate;
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

	java.sql.Date cashReceiptDate;
	java.sql.Date hidcashReceiptDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		session.setAttribute("BRANCHID", getBrchName());
		//System.out.println(getBrchName());
		String mode=getMode();
		ClsCashReceiptBean bean = new ClsCashReceiptBean();
		cashReceiptDate = commonDAO.changeStringtoSqlDate(getJqxCashReceiptDate());
		hidcashReceiptDate = commonDAO.changeStringtoSqlDate(getMaindate());
		
		if(mode.equalsIgnoreCase("A")){
			/*Cash Receipt Grid Saving*/
			ArrayList cashreceiptarray= new ArrayList();
			cashreceiptarray.add(getTxtfromdocno()+"::"+getCmbfromcurrency()+"::"+getTxtfromrate()+"::false::"+getTxtfromamount()+"::"+getTxtdescription()+"::"+getTxtfrombaseamount()+"::0::0::0");
			cashreceiptarray.add(getTxttodocno()+"::"+getCmbtocurrency()+"::"+getTxttorate()+"::true::"+getTxttoamount()*-1+"::"+getTxtdescription()+"::"+getTxttobaseamount()*-1+"::"+getTxtapplyinvoiceapply()+"::0::0");
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				cashreceiptarray.add(temp);
			}
			/*Cash Receipt Grid Saving Ends*/
			
			/*Apply-Invoice Grid Saving*/
			ArrayList applyinvoicearray= new ArrayList();
			for(int i=0;i<getApplylength();i++){
				String applytemp=requestParams.get("txtapply"+i)[0];
				applyinvoicearray.add(applytemp);
			}
			/*Apply-Invoice Grid Saving Ends*/
			
						int val=cashReceiptDAO.insert(cashReceiptDate,getFormdetailcode(),getTxtrefno(),getTxtfromrate(),getTxtdescription(),getTxtdrtotal(),getTxtapplyinvoiceapply(),cashreceiptarray,applyinvoicearray,session,request,mode);
						if(val>0.0){
							setTxtcashreceiptdocno(val);
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
			/*Updating Cash Receipt Grid*/
			ArrayList cashreceiptarray= new ArrayList();
			cashreceiptarray.add(getTxtfromdocno()+"::"+getCmbfromcurrency()+"::"+getTxtfromrate()+"::false::"+getTxtfromamount()+"::"+getTxtdescription()+"::"+getTxtfrombaseamount()+"::0::0::0");
			cashreceiptarray.add(getTxttodocno()+"::"+getCmbtocurrency()+"::"+getTxttorate()+"::true::"+getTxttoamount()*-1+"::"+getTxtdescription()+"::"+getTxttobaseamount()*-1+"::"+getTxtapplyinvoiceapply()+"::0::0");
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				cashreceiptarray.add(temp);
			}
			/*Updating Cash Receipt Grid Ends*/
			
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
			
			boolean Status=cashReceiptDAO.edit(getTxtcashreceiptdocno(),getFormdetailcode(),cashReceiptDate,getTxtrefno(),getTxtdescription(),getTxtfromrate(),getTxtdrtotal(),getTxttodocno(),getTxttotrno(),getTxtapplyinvoiceapply(),cashreceiptarray,applyinvoicearray,applyinvoiceupdatearray,session,mode);
			if(Status){
				setTxtcashreceiptdocno(getTxtcashreceiptdocno());
				setTxttotrno(getTxttotrno());
				setData();
				
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setTxtcashreceiptdocno(getTxtcashreceiptdocno());
				setTxttotrno(getTxttotrno());
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("E")){

			boolean Status=cashReceiptDAO.editMaster(getTxtcashreceiptdocno(),getFormdetailcode(),cashReceiptDate,getTxtrefno(),getTxtdescription(),getTxtfromrate(),getTxtdrtotal(),getTxttodocno(),getTxttotrno(),session);
			if(Status){
				setTxtcashreceiptdocno(getTxtcashreceiptdocno());
				setTxttotrno(getTxttotrno());
				setData();
				
				setMsg("Updated Successfully");
			    return "success";
		}
		else{
			setTxtcashreceiptdocno(getTxtcashreceiptdocno());
			setTxttotrno(getTxttotrno());
			setData();
			setMsg("Not Updated");
			return "fail";
		}
	  }
		
		
		else if(mode.equalsIgnoreCase("D")){
			
			boolean Status=cashReceiptDAO.delete(getTxtcashreceiptdocno(),getFormdetailcode(),getTxttotrno(),getTxttodocno(),session);
			if(Status){
				setTxtcashreceiptdocno(getTxtcashreceiptdocno());
				setTxttotrno(getTxttotrno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setTxtcashreceiptdocno(getTxtcashreceiptdocno());
				setTxttotrno(getTxttotrno());
				setData();
				setMsg("Not Deleted");
				return "fail";
			   }
			}
		
		else if(mode.equalsIgnoreCase("View")){
	
			String branch=null;
			cashReceiptBean=cashReceiptDAO.getViewDetails(session,getTxtcashreceiptdocno());
			
			setJqxCashReceiptDate(cashReceiptBean.getJqxCashReceiptDate());
			setTxtrefno(cashReceiptBean.getTxtrefno());
			
			setTxtfromdocno(cashReceiptBean.getTxtfromdocno());
			setTxtfromaccid(cashReceiptBean.getTxtfromaccid());
			setTxtfromaccname(cashReceiptBean.getTxtfromaccname());
			setHidcmbfromcurrency(cashReceiptBean.getHidcmbfromcurrency());
			setHidfromcurrencytype(cashReceiptBean.getHidfromcurrencytype());
			setTxtfromrate(cashReceiptBean.getTxtfromrate());
			setTxtfromamount(cashReceiptBean.getTxtfromamount());
			setTxtfrombaseamount(cashReceiptBean.getTxtfrombaseamount());
			setTxtdescription(cashReceiptBean.getTxtdescription());
			
			setTxttodocno(cashReceiptBean.getTxttodocno());
			setTxttotranid(cashReceiptBean.getTxttotranid());
			setTxttotrno(cashReceiptBean.getTxttotrno());
			setHidcmbtotype(cashReceiptBean.getHidcmbtotype());
			setTxttoaccid(cashReceiptBean.getTxttoaccid());
			setTxttoaccname(cashReceiptBean.getTxttoaccname());
			setHidcmbtocurrency(cashReceiptBean.getHidcmbtocurrency());
			setHidtocurrencytype(cashReceiptBean.getHidtocurrencytype());
			setTxttorate(cashReceiptBean.getTxttorate());
			setTxttoamount(cashReceiptBean.getTxttoamount());
			setTxttobaseamount(cashReceiptBean.getTxttobaseamount());
			setTxtapplyinvoiceamt(cashReceiptBean.getTxtapplyinvoiceamt());
			setTxtapplyinvoiceapply(cashReceiptBean.getTxtapplyinvoiceapply());
			setTxtapplyinvoicebalance((cashReceiptBean.getTxtapplyinvoicebalance()));
			
			setTxtdrtotal(cashReceiptBean.getTxtdrtotal());
			setTxtcrtotal(cashReceiptBean.getTxtcrtotal());
			setMaindate(cashReceiptBean.getMaindate());
			setFormdetailcode(cashReceiptBean.getFormdetailcode());
			
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
		cashReceiptBean=cashReceiptDAO.getPrint(request,docno,branch,header);
		
		setLblmainname("Received From");
		setUrl(commonDAO.getPrintPath("CRV"));
		setLblcompname(cashReceiptBean.getLblcompname());
		setLblcompaddress(cashReceiptBean.getLblcompaddress());
		setLblpobox(cashReceiptBean.getLblpobox());
		setLblprintname(cashReceiptBean.getLblprintname());
		setLblcomptrn(cashReceiptBean.getLblcomptrn());
		setLblcomptel(cashReceiptBean.getLblcomptel());
		setLblcompfax(cashReceiptBean.getLblcompfax());
		setLblbranch(cashReceiptBean.getLblbranch());
		setLbllocation(cashReceiptBean.getLbllocation());
		setLblservicetax(cashReceiptBean.getLblservicetax());
		setLblpan(cashReceiptBean.getLblpan());
		setLblcstno(cashReceiptBean.getLblcstno());
		setLblname(cashReceiptBean.getLblname());
		setLblvoucherno(cashReceiptBean.getLblvoucherno());
		setLbldescription(cashReceiptBean.getLbldescription());
		setLbldate(cashReceiptBean.getLbldate());
		setLblnetamount(cashReceiptBean.getLblnetamount());
		setLblnetamountwords(cashReceiptBean.getLblnetamountwords());
		setLbldebittotal(cashReceiptBean.getLbldebittotal());
		setLblcredittotal(cashReceiptBean.getLblcredittotal());
		setLblpreparedby(cashReceiptBean.getLblpreparedby());
		setLblpreparedon(cashReceiptBean.getLblpreparedon());
		setLblpreparedat(cashReceiptBean.getLblpreparedat());
		
		// for hide
		setFirstarray(cashReceiptBean.getFirstarray());
		setSecarray(cashReceiptBean.getSecarray());
		setTxtheader(cashReceiptBean.getTxtheader());
	
		if(commonDAO.getPrintPath("CRV").contains(".jrxml"));
		{
			System.out.println("printpath");
			HttpServletResponse response = ServletActionContext.getResponse();
			
			 param = new HashMap();
			 Connection conn = null;
			 
			 try {
				
             	conn = connDAO.getMyConnection();
             	Statement stmt = conn.createStatement();

               	String branchheader="",branchfooter="";
               	String sql1="select '' imgpath,'' imgfooter from my_brch where doc_no="+branch;
				ResultSet resultSet = stmt.executeQuery(sql1);
			    
				 while (resultSet.next()) {
				 branchheader=resultSet.getString("imgpath");
				 branchfooter=resultSet.getString("imgfooter");

				 }
               	String branch1header = request.getSession().getServletContext().getRealPath(branchheader);
					branch1header =branch1header.replace("\\", "\\\\");	

					String branch1footer = request.getSession().getServletContext().getRealPath(branchfooter);
					branch1footer =branch1footer.replace("\\", "\\\\");
					param.put("bheader", branch1header);
					param.put("bfooter", branch1footer);
				
             	String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
               	imgpath=imgpath.replace("\\", "\\\\");
              	
               	String imgheaderpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
               	imgheaderpath=imgheaderpath.replace("\\", "\\\\");    
	          
				/*
				 * String imgpath2=request.getSession().getServletContext().cashReceiptBean(
				 * "/icons/aitsfooter.jpg"); imgpath2=imgpath2.replace("\\", "\\\\");
				 */	String watermark=request.getSession().getServletContext().getRealPath("/icons/draft.png");
               	watermark=watermark.replace("\\", "\\\\");
                param.put("watermark", watermark);
              //  param.put("watermarksts", cashReceiptBean.getWatermark());
               	 param.put("header", new Integer(header));
		         param.put("imgpath", imgpath);
		     	 param.put("imghedderpath", imgheaderpath);
		     	// param.put("imgfooterpath", imgpath2);
		         param.put("compname", cashReceiptBean.getLblcompname());
		         param.put("compaddress", cashReceiptBean.getLblcompaddress());
		        
		         param.put("comptel", cashReceiptBean.getLblcomptel());
		         param.put("compfax", cashReceiptBean.getLblcompfax());
		         param.put("compbranch", cashReceiptBean.getLblbranch());
		         param.put("location", cashReceiptBean.getLbllocation());
	        	 param.put("doc", new Integer(docno));
		         param.put("brch", new Integer(branch));
		      //   param.put("trno", cashReceiptBean.getBpvtrno());  
		         
		         param.put("printname", cashReceiptBean.getLblprintname());  
		         param.put("name", cashReceiptBean.getLblname());
		         param.put("vno", cashReceiptBean.getLblvoucherno());
		         param.put("descp", cashReceiptBean.getLbldescription());
		         param.put("vdate", cashReceiptBean.getLbldate());
		        // param.put("chqno", cashReceiptBean.getLblchqno());
		        // param.put("chqdat", cashReceiptBean.getLblchqdate());
		         param.put("amtword", cashReceiptBean.getLblnetamountwords());
		         param.put("amt", cashReceiptBean.getLblnetamount());
		      //   param.put("bankname", cashReceiptBean.getBank());
		         
		         param.put("debtot", cashReceiptBean.getLbldebittotal());
		         param.put("credtot", cashReceiptBean.getLblcredittotal());
		        // param.put("appliedapplyingtot", cashReceiptBean.getLblnetapplied());
		         param.put("paidto", cashReceiptBean.getLblname());
		     //    param.put("bank", cashReceiptBean.getBank());
		         
		         
		         param.put("prepby", cashReceiptBean.getLblpreparedby());
		         param.put("prepon", cashReceiptBean.getLblpreparedon());
		         param.put("prepat", cashReceiptBean.getLblpreparedat());
		       //  param.put("approved", cashReceiptBean.getApproved());
		        // param.put("verified", cashReceiptBean.getVerified());
		       
		     //    param.put("verifiedon", cashReceiptBean.getVerifiedOn());		         
		      //   param.put("approvedon", cashReceiptBean.getApprovedOn());
		         
		         param.put("printby", session.getAttribute("USERNAME").toString());
		     	 param.put("applyingqry",cashReceiptBean.getApplyquery()==null?"":cashReceiptBean.getApplyquery());
		     	
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
				
		     	 
		     	 String path[]=commonDAO.getPrintPath("CRV").split("cashreceipt/");
		     	System.out.println("CRV--------1-----"+path);
		     	 setUrl(path[1]);
		    System.out.println("CRV--------2-----"+commonDAO.getPrintPath("CRV"));
		         JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(commonDAO.getPrintPath("CRV")));
	     	 
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
		public JSONArray searchDetails( HttpSession session,String partyname,String docNo,String date,String amount,String check){
			  JSONArray cellarray = new JSONArray();
			  		  JSONObject cellobj = null;
			  		  
			  try {
				  cellarray= cashReceiptDAO.crvMainSearch(session,partyname,docNo,date,amount,check);
		
			  } catch (SQLException e) {
				  e.printStackTrace();
				  }
			return cellarray;
		}
		
		public void setData() {
			
			setHidjqxCashReceiptDate(cashReceiptDate.toString());
			setHidmaindate(hidcashReceiptDate.toString());
			setTxtrefno(getTxtrefno());
			
			setTxtfromdocno(getTxtfromdocno());
			setTxtfromaccid(getTxtfromaccid());
			setTxtfromaccname(getTxtfromaccname());
			setHidcmbfromcurrency(getCmbfromcurrency());
			setHidfromcurrencytype(getHidfromcurrencytype());
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
		/* public String getWatermark() {
			return watermark;
		}

		public void setWatermark(String watermark) {
			this.watermark = watermark;
		}

		public String getApproved() {
			return approved;
		}

		public void setApproved(String approved) {
			this.approved = approved;
		}

		public String getVerified() {
			return verified;
		}

		public void setVerified(String verified) {
			this.verified = verified;
		} */
}

