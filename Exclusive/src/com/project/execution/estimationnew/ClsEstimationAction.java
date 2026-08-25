package com.project.execution.estimationnew;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

public class ClsEstimationAction {


	ClsCommon com=new ClsCommon();
	ClsEstimationBean pintbean=new ClsEstimationBean();
	private String date;
	private String hiddate;

	private String txtrefno;
	private int docno;

	private String txtactivityname;
	private int txtactivityid;
	private String txtclient;
	private String txtclientdet;
	private int clientid;
	private String txtreviseno;
	private String txtenquiry;
	private int enquiryid;
	private String cmbreftype;
	private String hidcmbreftype;
	private String txtcontrmode;
	private String cmbscopegroup;
	private String hidcmbscopegroup;
	private String mode;
	private String deleted;
	private String msg;
	private String formdetailcode;

	private String txtmatotal;
	private String txtlabtotal;
	private String txteqptotal;
	private String txtnettotal;
	private String activitiesid;

	private int eqgridlen;
	private int labgridlen;
	private int matgridlen;
	private int actgridlen;

	private int masterdoc_no;
	private String hidestedit;
	private String hidsurtrno;
	private String hidenqtrno;
			
	private String productchk;
	
	public String getProductchk() {
		return productchk;
	}

	public void setProductchk(String productchk) {
		this.productchk = productchk;
	}
	public String getHidsurtrno() {
		return hidsurtrno;
	}

	public void setHidsurtrno(String hidsurtrno) {
		this.hidsurtrno = hidsurtrno;
	}

	public String getHidenqtrno() {
		return hidenqtrno;
	}

	public void setHidenqtrno(String hidenqtrno) {
		this.hidenqtrno = hidenqtrno;
	}

	public String getHidestedit() {
		return hidestedit;
	}

	public void setHidestedit(String hidestedit) {
		this.hidestedit = hidestedit;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getHiddate() {
		return hiddate;
	}

	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
	}

	public String getTxtrefno() {
		return txtrefno;
	}

	public void setTxtrefno(String txtrefno) {
		this.txtrefno = txtrefno;
	}

	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public String getTxtactivityname() {
		return txtactivityname;
	}

	public void setTxtactivityname(String txtactivityname) {
		this.txtactivityname = txtactivityname;
	}

	public int getTxtactivityid() {
		return txtactivityid;
	}

	public void setTxtactivityid(int txtactivityid) {
		this.txtactivityid = txtactivityid;
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

	public int getClientid() {
		return clientid;
	}

	public void setClientid(int clientid) {
		this.clientid = clientid;
	}

	public String getTxtreviseno() {
		return txtreviseno;
	}

	public void setTxtreviseno(String txtreviseno) {
		this.txtreviseno = txtreviseno;
	}

	public String getTxtenquiry() {
		return txtenquiry;
	}

	public void setTxtenquiry(String txtenquiry) {
		this.txtenquiry = txtenquiry;
	}

	public int getEnquiryid() {
		return enquiryid;
	}

	public void setEnquiryid(int enquiryid) {
		this.enquiryid = enquiryid;
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

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getTxtmatotal() {
		return txtmatotal;
	}

	public void setTxtmatotal(String txtmatotal) {
		this.txtmatotal = txtmatotal;
	}

	public String getTxtlabtotal() {
		return txtlabtotal;
	}

	public void setTxtlabtotal(String txtlabtotal) {
		this.txtlabtotal = txtlabtotal;
	}

	public String getTxteqptotal() {
		return txteqptotal;
	}

	public void setTxteqptotal(String txteqptotal) {
		this.txteqptotal = txteqptotal;
	}

	public String getTxtnettotal() {
		return txtnettotal;
	}

	public void setTxtnettotal(String txtnettotal) {
		this.txtnettotal = txtnettotal;
	}

	public int getEqgridlen() {
		return eqgridlen;
	}

	public void setEqgridlen(int eqgridlen) {
		this.eqgridlen = eqgridlen;
	}

	public int getLabgridlen() {
		return labgridlen;
	}

	public void setLabgridlen(int labgridlen) {
		this.labgridlen = labgridlen;
	}

	public int getMatgridlen() {
		return matgridlen;
	}

	public void setMatgridlen(int matgridlen) {
		this.matgridlen = matgridlen;
	}

	public int getMasterdoc_no() {
		return masterdoc_no;
	}

	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}

	public String getCmbreftype() {
		return cmbreftype;
	}

	public void setCmbreftype(String cmbreftype) {
		this.cmbreftype = cmbreftype;
	}

	public String getHidcmbreftype() {
		return hidcmbreftype;
	}

	public void setHidcmbreftype(String hidcmbreftype) {
		this.hidcmbreftype = hidcmbreftype;
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

	public int getActgridlen() {
		return actgridlen;
	}

	public void setActgridlen(int actgridlen) {
		this.actgridlen = actgridlen;
	}

	public String getActivitiesid() {
		return activitiesid;
	}

	public void setActivitiesid(String activitiesid) {
		this.activitiesid = activitiesid;
	}

	
private String totalamount,revisionno,lbldoc,lblrefno,lbltype,lbldate,customer,customeraddress;
	
	
	
	public String getTotalamount() {
		return totalamount;
	}

	public void setTotalamount(String totalamount) {
		this.totalamount = totalamount;
	}

	public String getRevisionno() {
		return revisionno;
	}

	public void setRevisionno(String revisionno) {
		this.revisionno = revisionno;
	}

	public String getLbldoc() {
		return lbldoc;
	}

	public void setLbldoc(String lbldoc) {
		this.lbldoc = lbldoc;
	}

	public String getLblrefno() {
		return lblrefno;
	}

	public void setLblrefno(String lblrefno) {
		this.lblrefno = lblrefno;
	}

	public String getLbltype() {
		return lbltype;
	}

	public void setLbltype(String lbltype) {
		this.lbltype = lbltype;
	}

	public String getLbldate() {
		return lbldate;
	}

	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}

	public String getCustomer() {
		return customer;
	}

	public void setCustomer(String customer) {
		this.customer = customer;
	}

	public String getCustomeraddress() {
		return customeraddress;
	}

	public void setCustomeraddress(String customeraddress) {
		this.customeraddress = customeraddress;
	}
	private String url;
	

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String saveEstimateAction(){

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		String returns="";
		int val=0;

		try{
			ArrayList matlist=new ArrayList();

			ClsEstimationDAO DAO=new ClsEstimationDAO();

			if(mode.equalsIgnoreCase("A")){

				java.sql.Date date=com.changeStringtoSqlDate(getDate());

				for(int i=0;i<getMatgridlen();i++){
					String temp=requestParams.get("mate"+i)[0];		
					matlist.add(temp);
				}
				val=DAO.insert(date,getClientid(),getTxtreviseno(),getCmbreftype(),getTxtenquiry(),getTxtnettotal(),getTxtmatotal(),getTxtlabtotal(),
						getTxteqptotal(),getFormdetailcode(),getEnquiryid(),mode,matlist,session,request,getActivitiesid(),getTxtcontrmode(),getCmbscopegroup());


				if(val>0){
					setMasterdoc_no(Integer.parseInt(request.getAttribute("docNo").toString()));
					setDocno(val);
					setDate(date+"");
					setHiddate(date+"");
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setClientid(getClientid());
					setCmbreftype(getCmbreftype());
					setHidcmbreftype(getCmbreftype());
					setTxtreviseno(getTxtreviseno());
					setTxtenquiry(getTxtenquiry());
					setEnquiryid(getEnquiryid());
					setTxtcontrmode(getTxtcontrmode());
					setHidcmbscopegroup(getCmbscopegroup());
					setTxtmatotal(getTxtmatotal());
					
					setTxtnettotal(getTxtnettotal());
					setFormdetailcode(getFormdetailcode());
					setMode(getMode());
					setMsg("Successfully Saved");
					returns="success";
				}
				else{
					setDate(date+"");
					setHiddate(date+"");
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setClientid(getClientid());
					setCmbreftype(getCmbreftype());
					setHidcmbreftype(getCmbreftype());
					setTxtreviseno(getTxtreviseno());
					setTxtenquiry(getTxtenquiry());
					setEnquiryid(getEnquiryid());
					setTxtcontrmode(getTxtcontrmode());
					setHidcmbscopegroup(getCmbscopegroup());
					setTxtmatotal(getTxtmatotal());
					
					setTxtnettotal(getTxtnettotal());
					setFormdetailcode(getFormdetailcode());
					setMode(getMode());
					setMsg("Not Saved");
					returns="fail";
				}



			}

			if(mode.equalsIgnoreCase("E")){

				java.sql.Date date=com.changeStringtoSqlDate(getDate());
				for(int i=0;i<getMatgridlen();i++){
					String temp=requestParams.get("mate"+i)[0];		
					matlist.add(temp);
				}

				val=DAO.edit(getMasterdoc_no(),getDocno(),date,getClientid(),getTxtreviseno(),getCmbreftype(),getTxtenquiry(),getTxtnettotal(),getTxtmatotal(),getTxtlabtotal(),
						getTxteqptotal(),getFormdetailcode(),getEnquiryid(),mode,matlist,session,request,getActivitiesid(),getTxtcontrmode(),getCmbscopegroup());


				if(val>0){
					setMasterdoc_no(Integer.parseInt(request.getAttribute("docNo").toString()));
					setDocno(val);
					setDate(date+"");
					setHiddate(date+"");
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setClientid(getClientid());
					setCmbreftype(getCmbreftype());
					setHidcmbreftype(getCmbreftype());
					setTxtreviseno(getTxtreviseno());
					setTxtenquiry(getTxtenquiry());
					setEnquiryid(getEnquiryid());
					setTxtcontrmode(getTxtcontrmode());
					setHidcmbscopegroup(getCmbscopegroup());
					setTxtmatotal(getTxtmatotal());
					
					setTxtnettotal(getTxtnettotal());
					setFormdetailcode(getFormdetailcode());
					setMode(getMode());
					setMsg("Updated Successfully");
					returns="success";
				}
				else{
					setDate(date+"");
					setHiddate(date+"");
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setClientid(getClientid());
					setCmbreftype(getCmbreftype());
					setHidcmbreftype(getCmbreftype());
					setTxtreviseno(getTxtreviseno());
					setTxtenquiry(getTxtenquiry());
					setEnquiryid(getEnquiryid());
					setTxtcontrmode(getTxtcontrmode());
					setHidcmbscopegroup(getCmbscopegroup());
					setTxtmatotal(getTxtmatotal());
					
					setTxtnettotal(getTxtnettotal());
					setFormdetailcode(getFormdetailcode());
					setMode(getMode());
					setMsg("Not Saved");
					returns="fail";
				}



			}

			if(mode.equalsIgnoreCase("view")){
				java.sql.Date date=com.changeStringtoSqlDate(getDate());
				setDate(date+"");
				setHiddate(date+"");
				setMasterdoc_no(getMasterdoc_no());
				setDocno(getDocno());
				setTxtclient(getTxtclient());
				setTxtclientdet(getTxtclientdet());
				setClientid(getClientid());
				setCmbreftype(getCmbreftype());
				setHidcmbreftype(getCmbreftype());
				setTxtreviseno(getTxtreviseno());
				setTxtenquiry(getTxtenquiry());
				setEnquiryid(getEnquiryid());
				setTxtcontrmode(getTxtcontrmode());
				setHidcmbscopegroup(getCmbscopegroup());
				setHidsurtrno(getHidsurtrno());
				setHidenqtrno(getHidenqtrno());
				setHidestedit(getHidestedit());
				setTxtmatotal(getTxtmatotal());
				
				setTxtnettotal(getTxtnettotal());
				setFormdetailcode(getFormdetailcode());
				setMode(getMode());
				
				returns="success";
			}

			if(mode.equalsIgnoreCase("D")){

				java.sql.Date date=com.changeStringtoSqlDate(getDate());


				val=DAO.delete(getMasterdoc_no(),getDocno(),date,getClientid(),getTxtreviseno(),getCmbreftype(),getTxtenquiry(),getTxtnettotal(),getTxtmatotal(),getTxtlabtotal(),
						getTxteqptotal(),getFormdetailcode(),getEnquiryid(),mode,matlist,session,request,getActivitiesid(),getTxtcontrmode(),getCmbscopegroup());


				if(val>0){
					setMasterdoc_no(Integer.parseInt(request.getAttribute("docNo").toString()));
					setDocno(val);
					setDate(date+"");
					setHiddate(date+"");
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setClientid(getClientid());
					setCmbreftype(getCmbreftype());
					setHidcmbreftype(getCmbreftype());
					setTxtreviseno(getTxtreviseno());
					setTxtenquiry(getTxtenquiry());
					setEnquiryid(getEnquiryid());
					setTxtcontrmode(getTxtcontrmode());
					setHidcmbscopegroup(getCmbscopegroup());
					setTxtmatotal(getTxtmatotal());
					setTxtlabtotal(getTxtlabtotal());
					setTxteqptotal(getTxteqptotal());
					setTxtnettotal(getTxtnettotal());
					setFormdetailcode(getFormdetailcode());
					setMode(getMode());
					setMsg("Successfully Deleted");
					setDeleted("DELETED");
					returns="success";
				}
				else{
					setDate(date+"");
					setHiddate(date+"");
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setClientid(getClientid());
					setCmbreftype(getCmbreftype());
					setHidcmbreftype(getCmbreftype());
					setTxtreviseno(getTxtreviseno());
					setTxtenquiry(getTxtenquiry());
					setEnquiryid(getEnquiryid());
					setTxtcontrmode(getTxtcontrmode());
					setHidcmbscopegroup(getCmbscopegroup());
					setTxtmatotal(getTxtmatotal());
					setTxtlabtotal(getTxtlabtotal());
					setTxteqptotal(getTxteqptotal());
					setTxtnettotal(getTxtnettotal());
					setFormdetailcode(getFormdetailcode());
					setMode(getMode());
					setMsg("Not Deleted");
					returns="fail";
				}



			}



		}
		catch(Exception e){
			e.printStackTrace();
		}
		return returns;


	}




	
	public String printAction() throws ParseException, SQLException{
		
		  HttpServletRequest request=ServletActionContext.getRequest();
		  HttpServletResponse response=ServletActionContext.getResponse();
		 int doc=Integer.parseInt(request.getParameter("docno"));
		 String brhid=request.getParameter("brhid");
		 String dtype=request.getParameter("dtype");
		 ClsEstimationDAO ClsEstimationDAO=new ClsEstimationDAO();
		 pintbean=ClsEstimationDAO.getPrint(doc,request,brhid);
	  	 setUrl(com.getPrintPath(dtype));
		 
		
		  //cl details
	  	setCustomer(pintbean.getCustomer());
	  	setCustomeraddress(pintbean.getCustomeraddress());
	  //	setLbldate(getDate());
	  	setRevisionno(pintbean.getRevisionno());
	  	setLbltype(pintbean.getLbltype());
	  	setLblrefno(pintbean.getLblrefno());
	  	setTotalamount(pintbean.getTotalamount());
	  	setLbldoc(pintbean.getLbldoc());
	  	setLbldate(pintbean.getLbldate());
	  	setTotalamount(pintbean.getTotalamount());
	  	
	  	
		  					// setLblshipfax(pintbean.getLblshipfax());
				
		    	  System.out.println("getUrl==="+getUrl());

				      
		   
		 return "print";
		 }	


}
