package com.finance.interbranchtransactions.ibcashreceipt;

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
public class ClsIbCashReceiptAction extends ActionSupport{

	ClsCommon commonDAO= new ClsCommon();
	ClsIbCashReceiptDAO ibCashReceiptDAO= new ClsIbCashReceiptDAO();
	ClsIbCashReceiptBean ibCashReceiptBean;

	private int txtibcashreceiptdocno;
	private String brchName;
	private String formdetailcode;
	private String chkstatus;
	private String mode;
	private String deleted;
	private String msg;
	private String jqxIBCashReceiptDate;
	private String hidjqxIBCashReceiptDate;
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
	
	//Cash Receipt Grid
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
	private String lblpreparedby;
	private String lblpreparedon;
	private String lblpreparedat;
	
	//for hide
	private int firstarray;
	private int secarray;
	private int txtheader;
	
	public int getTxtibcashreceiptdocno() {
		return txtibcashreceiptdocno;
	}
	public void setTxtibcashreceiptdocno(int txtibcashreceiptdocno) {
		this.txtibcashreceiptdocno = txtibcashreceiptdocno;
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
	public String getJqxIBCashReceiptDate() {
		return jqxIBCashReceiptDate;
	}
	public void setJqxIBCashReceiptDate(String jqxIBCashReceiptDate) {
		this.jqxIBCashReceiptDate = jqxIBCashReceiptDate;
	}
	public String getHidjqxIBCashReceiptDate() {
		return hidjqxIBCashReceiptDate;
	}
	public void setHidjqxIBCashReceiptDate(String hidjqxIBCashReceiptDate) {
		this.hidjqxIBCashReceiptDate = hidjqxIBCashReceiptDate;
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

	java.sql.Date ibCashReceiptDate;
	java.sql.Date hidibCashReceiptDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsIbCashReceiptBean bean = new ClsIbCashReceiptBean();
		ibCashReceiptDate = commonDAO.changeStringtoSqlDate(getJqxIBCashReceiptDate());
		hidibCashReceiptDate = commonDAO.changeStringtoSqlDate(getMaindate());
		
		if(mode.equalsIgnoreCase("A")){
			String mainBranch=session.getAttribute("BRANCHID").toString().trim();
			/*Cash Payment Grid Saving*/
			ArrayList ibcashreceiptarray= new ArrayList();
			ibcashreceiptarray.add(getTxtfromdocno()+"::"+getCmbfromcurrency()+"::"+getTxtfromrate()+"::false::"+getTxtfromamount()+"::"+getTxtdescription()+"::"+getTxtfrombaseamount()+"::0::0::0::"+mainBranch+"::"+mainBranch);
			ibcashreceiptarray.add(getTxttodocno()+"::"+getCmbtocurrency()+"::"+getTxttorate()+"::true::"+getTxttoamount()*-1+"::"+getTxtdescription()+"::"+getTxttobaseamount()*-1+"::"+getTxtapplyinvoiceapply()+"::0::0::"+getCmbtobranch()+"::"+mainBranch);
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0]+"::"+mainBranch;
				ibcashreceiptarray.add(temp);
			}
			/*Cash Payment Grid Saving Ends*/
			
			/*Apply-Invoice Grid Saving*/
			ArrayList applyibinvoicearray= new ArrayList();
			for(int i=0;i<getApplylength();i++){
				String applytemp=requestParams.get("txtapply"+i)[0];
				applyibinvoicearray.add(applytemp);
			}
			/*Apply-Invoice Grid Saving Ends*/
			
			int chk=0;
			for(int i=0;i<ibcashreceiptarray.size();i++){
				String[] array=ibcashreceiptarray.get(i).toString().split("::");
				if(!(array[10].equalsIgnoreCase(array[11]))){
				chk=1;
				}
				else{}
			}
			
			if(chk>0){
						int val=ibCashReceiptDAO.insert(ibCashReceiptDate,getFormdetailcode(),getTxtrefno(),getTxtfromrate(),getTxtdescription(),getTxtdrtotal(),getTxtapplyinvoiceapply(),ibcashreceiptarray,applyibinvoicearray,session,request,mode);
						if(val>0.0){
							
							setTxtibcashreceiptdocno(val);
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
				setData();
				setChkstatus("1");
				setMsg("Main-Branch and Inter-Branch are Equal.");
			   return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("EDIT")){
			String mainBranch=session.getAttribute("BRANCHID").toString().trim();
			/*Updating Cash Payment Grid*/
			ArrayList ibcashreceiptarray= new ArrayList();
			ibcashreceiptarray.add(getTxtfromdocno()+"::"+getCmbfromcurrency()+"::"+getTxtfromrate()+"::false::"+getTxtfromamount()+"::"+getTxtdescription()+"::"+getTxtfrombaseamount()+"::0::0::0::"+mainBranch+"::"+mainBranch);
			ibcashreceiptarray.add(getTxttodocno()+"::"+getCmbtocurrency()+"::"+getTxttorate()+"::true::"+getTxttoamount()*-1+"::"+getTxtdescription()+"::"+getTxttobaseamount()*-1+"::"+getTxtapplyinvoiceapply()+"::0::0::"+getCmbtobranch()+"::"+mainBranch);
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0]+"::"+mainBranch;
				ibcashreceiptarray.add(temp);
			}
			/*Updating Cash Payment Grid Ends*/
			
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
			
			boolean Status=ibCashReceiptDAO.edit(getTxtibcashreceiptdocno(),getFormdetailcode(),ibCashReceiptDate,getTxtrefno(),getTxtdescription(),getTxtfromrate(),getTxtdrtotal(),getTxttodocno(),getTxttotrno(),getTxtapplyinvoiceapply(),ibcashreceiptarray,applyibinvoicearray,applyibinvoiceupdatearray,session,mode);
			if(Status){
				setTxtibcashreceiptdocno(getTxtibcashreceiptdocno());
				setTxttotrno(getTxttotrno());
				setData();
				
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setTxtibcashreceiptdocno(getTxtibcashreceiptdocno());
				setTxttotrno(getTxttotrno());
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("E")){

			boolean Status=ibCashReceiptDAO.editMaster(getTxtibcashreceiptdocno(),getFormdetailcode(),ibCashReceiptDate,getTxtrefno(),getTxtdescription(),getTxtfromrate(),getTxtdrtotal(),getTxttodocno(),getTxttotrno(),session);
			if(Status){
				
				setTxtibcashreceiptdocno(getTxtibcashreceiptdocno());
				setTxttotrno(getTxttotrno());
				setData();
				
				setMsg("Updated Successfully");
			    return "success";
		}
		else{
			setTxtibcashreceiptdocno(getTxtibcashreceiptdocno());
			setTxttotrno(getTxttotrno());
			setData();
			setMsg("Not Updated");
			return "fail";
		}
	  }
		
		
		else if(mode.equalsIgnoreCase("D")){
			
			boolean Status=ibCashReceiptDAO.delete(getTxtibcashreceiptdocno(),getFormdetailcode(),getTxttotrno(),getTxttodocno(),session);
			if(Status){

				setTxtibcashreceiptdocno(getTxtibcashreceiptdocno());
				setTxttotrno(getTxttotrno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setTxtibcashreceiptdocno(getTxtibcashreceiptdocno());
				setTxttotrno(getTxttotrno());
				setData();
				setMsg("Not Deleted");
				return "fail";
			   }
			}
		
		else if(mode.equalsIgnoreCase("View")){
			String branch=null;
			ibCashReceiptBean=ibCashReceiptDAO.getViewDetails(getBrchName(),getTxtibcashreceiptdocno());
			setJqxIBCashReceiptDate(ibCashReceiptBean.getJqxIBCashReceiptDate());
			setTxtrefno(ibCashReceiptBean.getTxtrefno());
			
			setTxtfromdocno(ibCashReceiptBean.getTxtfromdocno());
			setTxtfromaccid(ibCashReceiptBean.getTxtfromaccid());
			setTxtfromaccname(ibCashReceiptBean.getTxtfromaccname());
			setHidcmbfromcurrency(ibCashReceiptBean.getHidcmbfromcurrency());
			setHidfromcurrencytype(ibCashReceiptBean.getHidfromcurrencytype());
			setTxtfromrate(ibCashReceiptBean.getTxtfromrate());;
			setTxtfromamount(ibCashReceiptBean.getTxtfromamount());
			setTxtfrombaseamount(ibCashReceiptBean.getTxtfrombaseamount());
			setTxtdescription(ibCashReceiptBean.getTxtdescription());
			
			setTxttodocno(ibCashReceiptBean.getTxttodocno());
			setTxttotranid(ibCashReceiptBean.getTxttotranid());
			setTxttotrno(ibCashReceiptBean.getTxttotrno());
			
			setHidcmbtobranch(ibCashReceiptBean.getHidcmbtobranch());
			setHidcmbtotype(ibCashReceiptBean.getHidcmbtotype());
			setTxttoaccid(ibCashReceiptBean.getTxttoaccid());
			setTxttoaccname(ibCashReceiptBean.getTxttoaccname());
			setHidcmbtocurrency(ibCashReceiptBean.getHidcmbtocurrency());
			setHidtocurrencytype(ibCashReceiptBean.getHidtocurrencytype());
			setTxttorate(ibCashReceiptBean.getTxttorate());
			setTxttoamount(ibCashReceiptBean.getTxttoamount());
			setTxttobaseamount(ibCashReceiptBean.getTxttobaseamount());
			setTxtapplyinvoiceamt(ibCashReceiptBean.getTxtapplyinvoiceamt());
			setTxtapplyinvoiceapply(ibCashReceiptBean.getTxtapplyinvoiceapply());
			setTxtapplyinvoicebalance(ibCashReceiptBean.getTxtapplyinvoicebalance());
			
			setTxtdrtotal(ibCashReceiptBean.getTxtdrtotal());
			setTxtcrtotal(ibCashReceiptBean.getTxtcrtotal());
			setMaindate(ibCashReceiptBean.getMaindate());
			setFormdetailcode(ibCashReceiptBean.getFormdetailcode());
			
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
		ibCashReceiptBean=ibCashReceiptDAO.getPrint(request,docno,branch,header);
		
		setLblmainname("Received From");
		setUrl(commonDAO.getPrintPath("ICRV"));
		setLblcompname(ibCashReceiptBean.getLblcompname());
		setLblcompaddress(ibCashReceiptBean.getLblcompaddress());
		setLblpobox(ibCashReceiptBean.getLblpobox());
		setLblprintname(ibCashReceiptBean.getLblprintname());
		setLblcomptel(ibCashReceiptBean.getLblcomptel());
		setLblcompfax(ibCashReceiptBean.getLblcompfax());
		setLblbranch(ibCashReceiptBean.getLblbranch());
		setLbllocation(ibCashReceiptBean.getLbllocation());
		setLblservicetax(ibCashReceiptBean.getLblservicetax());
		setLblpan(ibCashReceiptBean.getLblpan());
		setLblcstno(ibCashReceiptBean.getLblcstno());
		setLblname(ibCashReceiptBean.getLblname());
		setLblvoucherno(ibCashReceiptBean.getLblvoucherno());
		setLbldescription(ibCashReceiptBean.getLbldescription());
		setLbldate(ibCashReceiptBean.getLbldate());
		setLblnetamount(ibCashReceiptBean.getLblnetamount());
		setLblnetamountwords(ibCashReceiptBean.getLblnetamountwords());
		setLbldebittotal(ibCashReceiptBean.getLbldebittotal());
		setLblcredittotal(ibCashReceiptBean.getLblcredittotal());
		setLblpreparedby(ibCashReceiptBean.getLblpreparedby());
		setLblpreparedon(ibCashReceiptBean.getLblpreparedon());
		setLblpreparedat(ibCashReceiptBean.getLblpreparedat());
		
		// for hide
		setFirstarray(ibCashReceiptBean.getFirstarray());
		setSecarray(ibCashReceiptBean.getSecarray());
		setTxtheader(ibCashReceiptBean.getTxtheader());
	
		return "print";
	}

		public JSONArray searchDetails(HttpSession session,String partyname,String docNo,String date,String amount, String check){
			  JSONArray cellarray = new JSONArray();
			  		  JSONObject cellobj = null;
			  try {
				cellarray= ibCashReceiptDAO.icrvMainSearch(session, partyname, docNo, date, amount, check);
		
			  } catch (SQLException e) {
				  e.printStackTrace();
				  }
			return cellarray;
		}
		
		public void setData(){
			setHidjqxIBCashReceiptDate(ibCashReceiptDate.toString());
			setHidmaindate(hidibCashReceiptDate.toString());
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

