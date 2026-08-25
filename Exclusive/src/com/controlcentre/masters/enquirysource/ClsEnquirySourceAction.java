package com.controlcentre.masters.enquirysource;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsEnquirySourceAction {

	ClsConnection conobj=new ClsConnection();
	ClsCommon com=new ClsCommon();
	ClsEnquirySourceDAO DAO = new ClsEnquirySourceDAO();
	
	private String date;
	private String hidendate;
	private int    docno;
	private String txtname;
	private String txtmobile;
	private String txtemail;
	private String txtaddress;
	private String txtdescription;
	private String mode;
	private String msg;
	private String deleted;
	private String formdetailcode;
	
	
	
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getHidendate() {
		return hidendate;
	}
	public void setHidendate(String hidendate) {
		this.hidendate = hidendate;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getTxtname() {
		return txtname;
	}
	public void setTxtname(String txtname) {
		this.txtname = txtname;
	}
	public String getTxtmobile() {
		return txtmobile;
	}
	public void setTxtmobile(String txtmobile) {
		this.txtmobile = txtmobile;
	}
	public String getTxtemail() {
		return txtemail;
	}
	public void setTxtemail(String txtemail) {
		this.txtemail = txtemail;
	}
	public String getTxtaddress() {
		return txtaddress;
	}
	public void setTxtaddress(String txtaddress) {
		this.txtaddress = txtaddress;
	}
	public String getTxtdescription() {
		return txtdescription;
	}
	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
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
	
	
	
	public String saveAction(){
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		int val=0;
		java.sql.Date sqlStartDate = com.changeStringtoSqlDate(getDate());
		
		if(mode.equalsIgnoreCase("A")){
		
			val=DAO.insert(sqlStartDate,getTxtname(),getTxtaddress(),getTxtmobile(),getTxtemail(),getTxtdescription(),getMode(),getFormdetailcode(),session,request);
			
			if(val>0){
				setDocno(val);
				setDate(sqlStartDate+"");
				setTxtname(getTxtname());
				setTxtaddress(getTxtaddress());
				setTxtmobile(getTxtmobile());
				setTxtemail(getTxtemail());
				setTxtdescription(getTxtdescription());
			setMsg("Successfully Saved");

			return "success";
		}
		else{
			setMsg("Not Saved");
			return "fail";
		}	
			
			
		}
		
		if(mode.equalsIgnoreCase("E")){
			
			val=DAO.edit(getDocno(),sqlStartDate,getTxtname(),getTxtaddress(),getTxtmobile(),getTxtemail(),getTxtdescription(),getMode(),getFormdetailcode(),session,request);
			
			if(val>0){
				setDate(sqlStartDate+"");
				setTxtname(getTxtname());
				setTxtaddress(getTxtaddress());
				setTxtmobile(getTxtmobile());
				setTxtemail(getTxtemail());
				setTxtdescription(getTxtdescription());
			setMsg("Updated Successfully");

			return "success";
		}
		else{
			setMsg("Not Updated");
			return "fail";
		}	
			
			
		}
		
		if(mode.equalsIgnoreCase("D")){
			
			val=DAO.delete(getDocno(),sqlStartDate,getTxtname(),getTxtaddress(),getTxtmobile(),getTxtemail(),getTxtdescription(),getMode(),getFormdetailcode(),session,request);
			
			if(val>0){
				setDate(sqlStartDate+"");
				setTxtname(getTxtname());
				setTxtaddress(getTxtaddress());
				setTxtmobile(getTxtmobile());
				setTxtemail(getTxtemail());
				setTxtdescription(getTxtdescription());
			setMsg("Successfully Deleted");

			return "success";
		}
		else{
			setMsg("Not Deelted");
			return "fail";
		}	
			
			
		}
			
		return "fail";
		
	}
	
}
