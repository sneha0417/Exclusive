package com.dashboard.marketing.quotationdetail;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;


public class ClsQuotationDetailAction {
	
	ClsQuotationDetailDAO DAO=new ClsQuotationDetailDAO();
	ClsCommon com=new ClsCommon();
	
	private String msg;
	private String hidtrno;
	private String quttrno;
	private String detail;
	private String detailname;
	private String presalesscopeallowed;
	private String reftype;
	private String txtcontrmode;
	private String cmbscopegroup;
	private String hidcmbscopegroup;
	private String cmbscopegroupchange;
	private String hidcmbscopegroupchange;
	private String txtscopegroupchanged;
	private String qutnettotal;
	private String estimationtotal;
	private String txtclient;
	private String txtremarks;
	private String txtdiscount;
	private String txtnettotal; 
	private String btnval;
	private String clientid;
	private int hidchkrev;
	private String qutname;
	private String fromdate;
	private String todate;
	private String revision;
	private String enqno;
	private String surtrno;
	private String quotdate;
	private String hidquotdate;
	private String cldocno;
	private String date;
	private String brhid;
	
	private int estimationgrdlen;
	private int qutgridlen;
	private int sitegridlen;
	
	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getHidtrno() {
		return hidtrno;
	}

	public void setHidtrno(String hidtrno) {
		this.hidtrno = hidtrno;
	}

	public String getQuttrno() {
		return quttrno;
	}

	public void setQuttrno(String quttrno) {
		this.quttrno = quttrno;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getDetailname() {
		return detailname;
	}

	public void setDetailname(String detailname) {
		this.detailname = detailname;
	}
	
	public String getPresalesscopeallowed() {
		return presalesscopeallowed;
	}

	public void setPresalesscopeallowed(String presalesscopeallowed) {
		this.presalesscopeallowed = presalesscopeallowed;
	}

	public String getReftype() {
		return reftype;
	}

	public void setReftype(String reftype) {
		this.reftype = reftype;
	}
	
	public String getTxtcontrmode() {
		return txtcontrmode;
	}

	public void setTxtcontrmode(String txtcontrmode) {
		this.txtcontrmode = txtcontrmode;
	}

	public String getCmbscopegroup() {
		return cmbscopegroup;
	}

	public void setCmbscopegroup(String cmbscopegroup) {
		this.cmbscopegroup = cmbscopegroup;
	}

	public String getHidcmbscopegroup() {
		return hidcmbscopegroup;
	}

	public void setHidcmbscopegroup(String hidcmbscopegroup) {
		this.hidcmbscopegroup = hidcmbscopegroup;
	}

	public String getCmbscopegroupchange() {
		return cmbscopegroupchange;
	}

	public void setCmbscopegroupchange(String cmbscopegroupchange) {
		this.cmbscopegroupchange = cmbscopegroupchange;
	}

	public String getHidcmbscopegroupchange() {
		return hidcmbscopegroupchange;
	}

	public void setHidcmbscopegroupchange(String hidcmbscopegroupchange) {
		this.hidcmbscopegroupchange = hidcmbscopegroupchange;
	}

	public String getTxtscopegroupchanged() {
		return txtscopegroupchanged;
	}

	public void setTxtscopegroupchanged(String txtscopegroupchanged) {
		this.txtscopegroupchanged = txtscopegroupchanged;
	}

	public String getQutnettotal() {
		return qutnettotal;
	}

	public void setQutnettotal(String qutnettotal) {
		this.qutnettotal = qutnettotal;
	}

	public String getEstimationtotal() {
		return estimationtotal;
	}

	public void setEstimationtotal(String estimationtotal) {
		this.estimationtotal = estimationtotal;
	}

	public String getTxtclient() {
		return txtclient;
	}

	public void setTxtclient(String txtclient) {
		this.txtclient = txtclient;
	}

	public String getTxtremarks() {
		return txtremarks;
	}

	public void setTxtremarks(String txtremarks) {
		this.txtremarks = txtremarks;
	}

	public String getTxtdiscount() {
		return txtdiscount;
	}

	public void setTxtdiscount(String txtdiscount) {
		this.txtdiscount = txtdiscount;
	}

	public String getTxtnettotal() {
		return txtnettotal;
	}

	public void setTxtnettotal(String txtnettotal) {
		this.txtnettotal = txtnettotal;
	}

	public String getBtnval() {
		return btnval;
	}

	public void setBtnval(String btnval) {
		this.btnval = btnval;
	}

	public String getClientid() {
		return clientid;
	}

	public void setClientid(String clientid) {
		this.clientid = clientid;
	}

	public int getHidchkrev() {
		return hidchkrev;
	}

	public void setHidchkrev(int hidchkrev) {
		this.hidchkrev = hidchkrev;
	}

	public String getQutname() {
		return qutname;
	}

	public void setQutname(String qutname) {
		this.qutname = qutname;
	}

	public String getFromdate() {
		return fromdate;
	}

	public void setFromdate(String fromdate) {
		this.fromdate = fromdate;
	}

	public String getTodate() {
		return todate;
	}

	public void setTodate(String todate) {
		this.todate = todate;
	}

	public String getRevision() {
		return revision;
	}

	public void setRevision(String revision) {
		this.revision = revision;
	}

	public String getEnqno() {
		return enqno;
	}

	public void setEnqno(String enqno) {
		this.enqno = enqno;
	}

	public String getSurtrno() {
		return surtrno;
	}

	public void setSurtrno(String surtrno) {
		this.surtrno = surtrno;
	}

	public String getQuotdate() {
		return quotdate;
	}

	public void setQuotdate(String quotdate) {
		this.quotdate = quotdate;
	}
	
	public String getHidquotdate() {
		return hidquotdate;
	}

	public void setHidquotdate(String hidquotdate) {
		this.hidquotdate = hidquotdate;
	}

	public String getCldocno() {
		return cldocno;
	}

	public void setCldocno(String cldocno) {
		this.cldocno = cldocno;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getBrhid() {
		return brhid;
	}

	public void setBrhid(String brhid) {
		this.brhid = brhid;
	}

	public int getEstimationgrdlen() {
		return estimationgrdlen;
	}

	public void setEstimationgrdlen(int estimationgrdlen) {
		this.estimationgrdlen = estimationgrdlen;
	}

	public int getQutgridlen() {
		return qutgridlen;
	}

	public void setQutgridlen(int qutgridlen) {
		this.qutgridlen = qutgridlen;
	}

	public int getSitegridlen() {
		return sitegridlen;
	}

	public void setSitegridlen(int sitegridlen) {
		this.sitegridlen = sitegridlen;
	}

	public String saveQutDetailAction(){

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String returns="";
		int val=0;

		try{
			ArrayList<String> matlist=new ArrayList<String>();
			ArrayList<String> servlist=new ArrayList<String>();
			ArrayList<String> sitelist=new ArrayList<String>();
			
			java.sql.Date fdate=com.changeStringtoSqlDate(getFromdate());
			java.sql.Date tdate=com.changeStringtoSqlDate(getTodate());
			java.sql.Date dates=(getDate()==null || getDate().trim().equalsIgnoreCase(""))?null:com.changeStringtoSqlDate2(getDate());
			java.sql.Date quotdates=(getQuotdate()==null || getQuotdate().trim().equalsIgnoreCase(""))?null:com.changeStringtoSqlDate(getQuotdate());
			
			for(int i=0;i<getEstimationgrdlen();i++){
				String temp=requestParams.get("mate"+i)[0];		
				matlist.add(temp);
			}
			//System.out.println("inside saveaction matlist"+matlist);
			
			
			for(int i=0;i<getQutgridlen();i++){

				String temp=requestParams.get("service"+i)[0];		
				servlist.add(temp);
			}
			
			for(int i=0;i<getSitegridlen();i++){
				String temp=requestParams.get("site"+i)[0];		
				sitelist.add(temp);
			}

				val=DAO.edit(servlist,matlist,sitelist,getHidtrno(),getQuttrno(),session,request,getReftype(),getQutnettotal(),getBtnval(),getTxtdiscount(),
						getTxtnettotal(),getClientid(),quotdates,getTxtremarks(),getHidchkrev(),getTxtscopegroupchanged());
 

				if(val>0){
					System.out.println("getQuttrno()=="+getQuttrno());
				//	setFromdate(fdate+"");
				//	setTodate(tdate+"");
					setHidquotdate(quotdates.toString());
					if(getBtnval().equalsIgnoreCase("SQ")) {
					setRevision(request.getAttribute("revisionnoval").toString());
					} else {
					setRevision(getRevision());	
					}
					setQutname(getQutname());
					setQuttrno(getQuttrno());
					setHidtrno(getHidtrno());
					setReftype(getReftype());
					setSurtrno(getSurtrno());
					setEnqno(getEnqno());
					setCldocno(getCldocno());
					setDate(dates+"");
					setBrhid(getBrhid());
					setPresalesscopeallowed(getPresalesscopeallowed());
					setTxtcontrmode(getTxtcontrmode());
					setHidcmbscopegroup(getCmbscopegroup());
					setHidcmbscopegroupchange(getCmbscopegroupchange());
					setDetail("Pre Sales");
					setDetailname("Quotation Detail");
					setMsg("Successfully Saved");
					return "success";
					
				}
				else{
				//	setFromdate(fdate+"");
				//	setTodate(tdate+"");
					setHidquotdate(quotdates.toString());
					setQutname(getQutname());
					setQuttrno(getQuttrno());
					setHidtrno(getHidtrno());
					setReftype(getReftype());
					setRevision(getRevision());
					setSurtrno(getSurtrno());
					setEnqno(getEnqno());
					setCldocno(getCldocno());
					setDate(dates+"");
					setBrhid(getBrhid());
					setPresalesscopeallowed(getPresalesscopeallowed());
					setTxtcontrmode(getTxtcontrmode());
					setHidcmbscopegroup(getCmbscopegroup());
					setHidcmbscopegroupchange(getCmbscopegroupchange());
					setMsg("Not Saved");
					returns="fail";
				}



			}

		
		
		catch(Exception e){
			e.printStackTrace();
			
		}
		
		return returns;
	}



}
