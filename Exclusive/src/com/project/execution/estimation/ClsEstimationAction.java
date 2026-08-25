package com.project.execution.estimation;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import sun.reflect.ReflectionFactory.GetReflectionFactoryAction;

import com.common.ClsCommon;

public class ClsEstimationAction {


	ClsCommon com=new ClsCommon();

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

	private String masterdoc_no;

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

	public String getMasterdoc_no() {
		return masterdoc_no;
	}

	public void setMasterdoc_no(String masterdoc_no) {
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

	public String saveEstimateAction(){

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		String returns="";
		int val=0;

		System.out.println("inside saveaction");

		try{
			ArrayList matlist=new ArrayList();

			ArrayList lablist=new ArrayList();

			ArrayList equplist=new ArrayList();

			ArrayList actlist=new ArrayList();


			for(int i=0;i<getMatgridlen();i++){
				String temp=requestParams.get("mate"+i)[0];		
				matlist.add(temp);
			}
			for(int i=0;i<getLabgridlen();i++){
				String temp=requestParams.get("lab"+i)[0];		
				lablist.add(temp);
			}
			for(int i=0;i<getEqgridlen();i++){
				String temp=requestParams.get("equip"+i)[0];		
				equplist.add(temp);
			}
			for(int i=0;i<getActgridlen();i++){
				String temp=requestParams.get("act"+i)[0];		
				actlist.add(temp);
			}

			ClsEstimationDAO DAO=new ClsEstimationDAO();

			if(mode.equalsIgnoreCase("A")){

				java.sql.Date date=com.changeStringtoSqlDate(getDate());


				val=DAO.insert(date,getClientid(),getTxtreviseno(),getCmbreftype(),getTxtenquiry(),getTxtnettotal(),getTxtmatotal(),getTxtlabtotal(),
						getTxteqptotal(),getFormdetailcode(),getEnquiryid(),mode,matlist,lablist,equplist,actlist,session,request,getActivitiesid());


				if(val>0){
					setMasterdoc_no(request.getAttribute("docNo").toString());
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
					setTxtmatotal(getTxtmatotal());
					setTxtlabtotal(getTxtlabtotal());
					setTxteqptotal(getTxteqptotal());
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
					setTxtmatotal(getTxtmatotal());
					setTxtlabtotal(getTxtlabtotal());
					setTxteqptotal(getTxteqptotal());
					setTxtnettotal(getTxtnettotal());
					setFormdetailcode(getFormdetailcode());
					setMode(getMode());
					setMsg("Not Saved");
					returns="fail";
				}



			}

			if(mode.equalsIgnoreCase("E")){

				java.sql.Date date=com.changeStringtoSqlDate(getDate());


				val=DAO.edit(getDocno(),getMasterdoc_no(),date,getClientid(),getTxtreviseno(),getCmbreftype(),getTxtenquiry(),getTxtnettotal(),getTxtmatotal(),getTxtlabtotal(),
						getTxteqptotal(),getFormdetailcode(),getEnquiryid(),mode,matlist,lablist,equplist,actlist,session,request,getActivitiesid());


				if(val>0){
					setMasterdoc_no(request.getAttribute("docNo").toString());
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
					setTxtmatotal(getTxtmatotal());
					setTxtlabtotal(getTxtlabtotal());
					setTxteqptotal(getTxteqptotal());
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
					setTxtmatotal(getTxtmatotal());
					setTxtlabtotal(getTxtlabtotal());
					setTxteqptotal(getTxteqptotal());
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

				returns="success";
			}

			if(mode.equalsIgnoreCase("D")){

				java.sql.Date date=com.changeStringtoSqlDate(getDate());


				val=DAO.delete(getDocno(),getMasterdoc_no(),date,getClientid(),getTxtreviseno(),getCmbreftype(),getTxtenquiry(),getTxtnettotal(),getTxtmatotal(),getTxtlabtotal(),
						getTxteqptotal(),getFormdetailcode(),getEnquiryid(),mode,matlist,lablist,equplist,actlist,session,request,getActivitiesid());


				if(val>0){
					setMasterdoc_no(request.getAttribute("docNo").toString());
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

}
