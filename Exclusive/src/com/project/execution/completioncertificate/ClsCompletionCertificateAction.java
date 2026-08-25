package com.project.execution.completioncertificate;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.ResultSet;
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

import org.apache.http.HttpRequest;
import org.apache.struts2.ServletActionContext;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.common.ClsNumberToWord;
import com.ibm.icu.text.DecimalFormat;
import com.itextpdf.text.pdf.PRIndirectReference;
import com.project.execution.completioncertificate.ClsCompletionCertificateBean;
import com.project.execution.completioncertificate.ClsCompletionCertificateDAO;

public class ClsCompletionCertificateAction {

	ClsCommon com=new ClsCommon();
	ClsCompletionCertificateDAO ccDAO= new ClsCompletionCertificateDAO();
	ClsCompletionCertificateBean ccBean;
	ClsConnection conobj=new ClsConnection();
	private String date;
	private String hiddate;
	private String refno;
	private String brchName;

	private int costid;
	private int maintrno;
	private String searchtrno;
	private int docno;
	private String pdid;
	private int invgridlength;
	
	private String cmbcontracttype;
	private String ptype;


	private String desc;
	private String txtnotes;
	private String mode;
	private String msg;
	private String deleted;
	private String formdetailcode;

	private String lblcompname;
	private String lblcompaddress;
	private String lblprintname;
	private String lblcomptel;
	private String lblcompfax;
	private String lblprintname1;
	private String lblbranch;
	private String lbllocation;
	private String amountwords;
	private String lblcheckedby;
	private String lblfinaldate;
	private String txtheader;
	private String url;
	private String txttel;
	private String txtmob;
	private String txtemail;
	private String txtjobrefno; 
    private String contypeval;
	private int masterdoc_no;

	private String contrval;
	private String certifyper;
	private String pytval;
	private String totinvoice;
	private String tobeinvoice;
	private String retnamount;
	private String invdate;
	private String invdesc;

	private String contrretn;
	private String contrtotinv;
	private String hidestedit;
	
	public String getHidestedit() {
		return hidestedit;
	}
	public void setHidestedit(String hidestedit) {
		this.hidestedit = hidestedit;
	}
	public String getContrretn() {
		return contrretn;
	}
	public void setContrretn(String contrretn) {
		this.contrretn = contrretn;
	}
	public String getContrtotinv() {
		return contrtotinv;
	}
	public void setContrtotinv(String contrtotinv) {
		this.contrtotinv = contrtotinv;
	}
	public String getContrval() {
		return contrval;
	}
	public void setContrval(String contrval) {
		this.contrval = contrval;
	}
	public String getCertifyper() {
		return certifyper;
	}
	public void setCertifyper(String certifyper) {
		this.certifyper = certifyper;
	}
	public String getPytval() {
		return pytval;
	}
	public void setPytval(String pytval) {
		this.pytval = pytval;
	}
	public String getTotinvoice() {
		return totinvoice;
	}
	public void setTotinvoice(String totinvoice) {
		this.totinvoice = totinvoice;
	}
	public String getTobeinvoice() {
		return tobeinvoice;
	}
	public void setTobeinvoice(String tobeinvoice) {
		this.tobeinvoice = tobeinvoice;
	}
	public String getRetnamount() {
		return retnamount;
	}
	public void setRetnamount(String retnamount) {
		this.retnamount = retnamount;
	}
	public String getInvdate() {
		return invdate;
	}
	public void setInvdate(String invdate) {
		this.invdate = invdate;
	}
	public String getInvdesc() {
		return invdesc;
	}
	public void setInvdesc(String invdesc) {
		this.invdesc = invdesc;
	}
	private int clientid;
	private int cpersonid;

	private String txtclient;
	private String txtclientdet;
	private int txtcontract;

	private ArrayList list;
	private ArrayList sitelist;
	private ArrayList serlist;
	private ArrayList termlist;
	private ArrayList paylist;

	private String mxrnomin;
	private String mxrnomax;
	private String total1;
	private String invoived;
	private String balance;
	
	private String cperson;
	
	private String txtrefdetails;
	private String txtdtype;
	
	
	public String getTxtdtype() {
		return txtdtype;
	}
	public void setTxtdtype(String txtdtype) {
		this.txtdtype = txtdtype;
	}
	public String getTxtrefdetails() {
		return txtrefdetails;
	}
	public void setTxtrefdetails(String txtrefdetails) {
		this.txtrefdetails = txtrefdetails;
	}
	public String getCperson() {
		return cperson;
	}
	public void setCperson(String cperson) {
		this.cperson = cperson;
	}
	
	
	public String getMxrnomin() {
		return mxrnomin;
	}
	public void setMxrnomin(String mxrnomin) {
		this.mxrnomin = mxrnomin;
	}
	public String getMxrnomax() {
		return mxrnomax;
	}
	public void setMxrnomax(String mxrnomax) {
		this.mxrnomax = mxrnomax;
	}
	public String getTotal1() {
		return total1;
	}
	public void setTotal1(String total1) {
		this.total1 = total1;
	}
	public String getInvoived() {
		return invoived;
	}
	public void setInvoived(String invoived) {
		this.invoived = invoived;
	}
	public String getBalance() {
		return balance;
	}
	public void setBalance(String balance) {
		this.balance = balance;
	}

	public String getContypeval() {
		return contypeval;
	}
	public void setContypeval(String contypeval) {
		this.contypeval = contypeval;
	}
	public String getPtype() {
		return ptype;
	}
	public void setPtype(String ptype) {
		this.ptype = ptype;
	}
	public ArrayList getPaylist() {
		return paylist;
	}
	public void setPaylist(ArrayList paylist) {
		this.paylist = paylist;
	}
	public String getHiddate() {
		return hiddate;
	}
	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
	}
	public String getTxttel() {
		return txttel;
	}
	public void setTxttel(String txttel) {
		this.txttel = txttel;
	}
	public String getTxtmob() {
		return txtmob;
	}
	public void setTxtmob(String txtmob) {
		this.txtmob = txtmob;
	}
	public String getTxtemail() {
		return txtemail;
	}
	public void setTxtemail(String txtemail) {
		this.txtemail = txtemail;
	}
	public String getTxtjobrefno() {
		return txtjobrefno;
	}
	public void setTxtjobrefno(String txtjobrefno) {
		this.txtjobrefno = txtjobrefno;
	}
	public ArrayList getList() {
		return list;
	}
	public void setList(ArrayList list) {
		this.list = list;
	}
	public ArrayList getSitelist() {
		return sitelist;
	}
	public void setSitelist(ArrayList sitelist) {
		this.sitelist = sitelist;
	}
	public ArrayList getSerlist() {
		return serlist;
	}
	public void setSerlist(ArrayList serlist) {
		this.serlist = serlist;
	}
	public ArrayList getTermlist() {
		return termlist;
	}
	public void setTermlist(ArrayList termlist) {
		this.termlist = termlist;
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
	public String getLblprintname1() {
		return lblprintname1;
	}
	public void setLblprintname1(String lblprintname1) {
		this.lblprintname1 = lblprintname1;
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
	public String getAmountwords() {
		return amountwords;
	}
	public void setAmountwords(String amountwords) {
		this.amountwords = amountwords;
	}
	public String getLblcheckedby() {
		return lblcheckedby;
	}
	public void setLblcheckedby(String lblcheckedby) {
		this.lblcheckedby = lblcheckedby;
	}
	public String getLblfinaldate() {
		return lblfinaldate;
	}
	public void setLblfinaldate(String lblfinaldate) {
		this.lblfinaldate = lblfinaldate;
	}
	public String getTxtheader() {
		return txtheader;
	}
	public void setTxtheader(String txtheader) {
		this.txtheader = txtheader;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getCostid() {
		return costid;
	}
	public void setCostid(int costid) {
		this.costid = costid;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public int getTxtcontract() {
		return txtcontract;
	}
	public void setTxtcontract(int txtcontract) {
		this.txtcontract = txtcontract;
	}

	public String getSearchtrno() {
		return searchtrno;
	}
	public void setSearchtrno(String searchtrno) {
		this.searchtrno = searchtrno;
	}


	public int getMaintrno() {
		return maintrno;
	}
	public void setMaintrno(int maintrno) {
		this.maintrno = maintrno;
	}
	
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}
	public String getRefno() {
		return refno;
	}
	public void setRefno(String refno) {
		this.refno = refno;
	}



	public int getInvgridlength() {
		return invgridlength;
	}
	public void setInvgridlength(int invgridlength) {
		this.invgridlength = invgridlength;
	}


	public String getCmbcontracttype() {
		return cmbcontracttype;
	}
	public void setCmbcontracttype(String cmbcontracttype) {
		this.cmbcontracttype = cmbcontracttype;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}




	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}

	public String getTxtclient() {
		return txtclient;
	}
	public void setTxtclient(String txtclient) {
		this.txtclient = txtclient;
	}
	public String getTxtclientdet() {
		return txtclientdet;
	}
	public void setTxtclientdet(String txtclientdet) {
		this.txtclientdet = txtclientdet;
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
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}


	public int getClientid() {
		return clientid;
	}
	public void setClientid(int clientid) {
		this.clientid = clientid;
	}
	public int getCpersonid() {
		return cpersonid;
	}
	public void setCpersonid(int cpersonid) {
		this.cpersonid = cpersonid;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getPdid() {
		return pdid;
	}
	public void setPdid(String pdid) {
		this.pdid = pdid;
	}
	public String getTxtnotes() {
		return txtnotes;
	}
	public void setTxtnotes(String txtnotes) {
		this.txtnotes = txtnotes;
	}
private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}


private String fire7site;
	
	public String getFire7site() {
		return fire7site;
	}
	public void setFire7site(String fire7site) {
		this.fire7site = fire7site;
	}
	public String saveAction()throws ParseException, SQLException{



		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		String searchtrno=getSearchtrno();

		int val=0;
		Double taxamt=0.0,taxtot=0.0;
		String nontax="0";
	//	ClsProjectInvoiceDAO DAO=new ClsProjectInvoiceDAO();

		if(mode.equals("A")){

			java.sql.Date date=com.changeStringtoSqlDate(getDate());
		//	java.sql.Date invdate=com.changeStringtoSqlDate(getInvdate());
			ArrayList<String> invarray= new ArrayList<>();
		
			System.out.println("INSIDE INSERT ACTION");
			val=ccDAO.insert(date,getCmbcontracttype(),getTxtcontract(),getClientid(),getDesc(),getContrval(),getCertifyper(),
					invarray,session,getMode(),getFormdetailcode(),request);
			
			
			
			if(val>0){

				setMaintrno(val);
				setDocno(Integer.parseInt(request.getAttribute("docno").toString()));
				setDate(date+"");
				setRefno(getRefno());
				setContypeval(getCmbcontracttype());
				setCmbcontracttype(getCmbcontracttype());
				setTxtcontract(getTxtcontract());
				setTxtclient(getTxtclient());
				setTxtclientdet(getTxtclientdet());
				setDesc(getDesc());
				setTxtnotes(getTxtnotes());
				
				setClientid(getClientid());
				setCostid(getCostid());
				setPdid(getPdid());
				setPtype(getPtype());
				
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setMaintrno(val);
				setDate(date+"");
				setRefno(getRefno());
				setContypeval(getCmbcontracttype());
				setCmbcontracttype(getCmbcontracttype());
				setTxtcontract(getTxtcontract());
				setTxtclient(getTxtclient());
				setTxtclientdet(getTxtclientdet());
				setDesc(getDesc());
				setTxtnotes(getTxtnotes());
			
				setClientid(getClientid());
				setCostid(getCostid());
				setPdid(getPdid());
				setPtype(getPtype());
				setMsg("Not Saved");
				return "fail";


			}

		}

		else if(mode.equalsIgnoreCase("E")){
			java.sql.Date date=com.changeStringtoSqlDate(getDate());

			ArrayList<String> invarray= new ArrayList<>();
	

			val=ccDAO.edit(getMaintrno(),getDocno(),date,getCmbcontracttype(),getTxtcontract(),getClientid(),getDesc(),getContrval(),getCertifyper(),
					invarray,session,getMode(),getFormdetailcode(),request);



			if(val>0){

				setMaintrno(val);
				setDocno(Integer.parseInt(request.getAttribute("docno").toString()));
				setDate(date+"");
				setRefno(getRefno());
				setContypeval(getCmbcontracttype());
				setCmbcontracttype(getCmbcontracttype());
				setTxtcontract(getTxtcontract());
				setTxtclient(getTxtclient());
				setTxtclientdet(getTxtclientdet());
				setDesc(getDesc());
				setTxtnotes(getTxtnotes());
			
				setClientid(getClientid());
				setCostid(getCostid());
				setPdid(getPdid());
				setPtype(getPtype());
				setMsg("Updated Successfully");
				return "success";
			}
			else{

				setDate(date+"");
				setRefno(getRefno());
				setContypeval(getCmbcontracttype());
				setCmbcontracttype(getCmbcontracttype());
				setTxtcontract(getTxtcontract());
				setTxtclient(getTxtclient());
				setTxtclientdet(getTxtclientdet());
				setDesc(getDesc());
				setTxtnotes(getTxtnotes());
				
				setClientid(getClientid());
				setCostid(getCostid());
				setPdid(getPdid());
				setPtype(getPtype());
				setMsg("Not Updated");
				return "fail";
			}
		}

		else if(mode.equalsIgnoreCase("D")){
			java.sql.Date date=com.changeStringtoSqlDate(getDate());

			ArrayList<String> invarray= new ArrayList<>();
	

			val=ccDAO.edit(getMaintrno(),getDocno(),date,getCmbcontracttype(),getTxtcontract(),getClientid(),getDesc(),getContrval(),getCertifyper(),
					invarray,session,getMode(),getFormdetailcode(),request);



			if(val>0){

				setMaintrno(val);
				setDocno(Integer.parseInt(request.getAttribute("docno").toString()));
				setDate(date+"");
				setRefno(getRefno());
				setContypeval(getCmbcontracttype());
				setCmbcontracttype(getCmbcontracttype());
				setTxtcontract(getTxtcontract());
				setTxtclient(getTxtclient());
				setTxtclientdet(getTxtclientdet());
				setDesc(getDesc());
				setTxtnotes(getTxtnotes());
			
				setClientid(getClientid());
				setCostid(getCostid());
				setPdid(getPdid());
				setPtype(getPtype());
				setMsg("Deleted Successfully");
				return "success";
			}
			else{

				setDate(date+"");
				setRefno(getRefno());
				setContypeval(getCmbcontracttype());
				setCmbcontracttype(getCmbcontracttype());
				setTxtcontract(getTxtcontract());
				setTxtclient(getTxtclient());
				setTxtclientdet(getTxtclientdet());
				setDesc(getDesc());
				setTxtnotes(getTxtnotes());
				
				setClientid(getClientid());
				setCostid(getCostid());
				setPdid(getPdid());
				setPtype(getPtype());
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("view")){
			ccBean=ccDAO.getViewDetails(session,getMaintrno(),getBrchName());

			setDocno(ccBean.getDocno());
			setDate(ccBean.getDate());
			
			setTxtclient(ccBean.getTxtclient());
			setTxtclientdet(ccBean.getTxtclientdet());
			setContypeval(ccBean.getCmbcontracttype());
			setCmbcontracttype(ccBean.getCmbcontracttype());
			setDesc(ccBean.getDesc());
			setTxtcontract(ccBean.getTxtcontract());
			setMaintrno(ccBean.getMaintrno());
			setClientid(ccBean.getClientid());
		setContrval(ccBean.getContrval());
		setCertifyper(ccBean.getCertifyper());
			setTxtrefdetails(ccBean.getTxtrefdetails());

			return "success";
		}
		return "fail";

	}	



}
