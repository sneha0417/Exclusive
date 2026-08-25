package com.controlcentre.masters.maintenancemaster.complaint;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;


@SuppressWarnings("serial")
public class ClsComplaintAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
	ClsComplaintDAO ComplaintDAO=new ClsComplaintDAO();
	ClsComplaintBean bean;
private int docno;
private String  compdate ,compdatehidden,compliant;

private String msg;
private String formdetailcode;
private String formdetail;


public String getFormdetailcode() {
	return formdetailcode;
}
public void setFormdetailcode(String formdetailcode) {
	this.formdetailcode = formdetailcode;
}
public String getFormdetail() {
	return formdetail;
}
public void setFormdetail(String formdetail) {
	this.formdetail = formdetail;
}
public String getMsg() {
	return msg;
}
public void setMsg(String msg) {
	this.msg = msg;
}


private String mode;
private String delete;

public int getDocno() {
	return docno;
}
public void setDocno(int docno) {
	this.docno = docno;
}


public String getCompdate() {
	return compdate;
}
public void setCompdate(String compdate) {
	this.compdate = compdate;
}
public String getCompdatehidden() {
	return compdatehidden;
}
public void setCompdatehidden(String compdatehidden) {
	this.compdatehidden = compdatehidden;
}
public String getCompliant() {
	return compliant;
}
public void setCompliant(String compliant) {
	this.compliant = compliant;
}
public String getMode() {
	return mode;
}
public void setMode(String mode) {
	this.mode = mode;
}
public String getDelete() {
	return delete;
}
public void setDelete(String delete) {
	this.delete = delete;
}

public String saveAction() throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();

	session.getAttribute("BRANCHID");
	String mode=getMode();



	if(mode.equalsIgnoreCase("A")){
		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getCompdate());
					int val=ComplaintDAO.insert(getCompliant(),sqlStartDate,session,getMode(),getFormdetailcode());
					if(val>0){
						setCompliant(getCompliant());
						setCompdatehidden(sqlStartDate.toString());
						setDocno(val);
						setMsg("Successfully Saved");

						return "success";
					}
					else{
						setCompliant(getCompliant());
						setCompdatehidden(sqlStartDate.toString());
						setDocno(val);
						setMsg("Not Saved");

						return "fail";
					}	
	}
	else if(mode.equalsIgnoreCase("E")){
		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getCompdate());
		boolean Status=ComplaintDAO.edit(getCompliant(),sqlStartDate,session,getMode(),getFormdetailcode(),getDocno());
		if(Status){
			
			setDocno(getDocno());
			setCompliant(getCompliant());
			setCompdatehidden(sqlStartDate.toString());
			setMsg("Updated Successfully");

			return "success";
		}
		else{
			setDocno(getDocno());
			setCompliant(getCompliant());
			setCompdatehidden(sqlStartDate.toString());
			setMsg("Not Updated");

			return "fail";
		}
	}
	else if(mode.equalsIgnoreCase("D")){
		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getCompdate());

		boolean Status=ComplaintDAO.delete(session,getMode(),getFormdetailcode(),getDocno());
	if(Status){
		//setBra(getBrand());
		setDocno(getDocno());
		setCompliant(getCompliant());
		setCompdatehidden(sqlStartDate.toString());
		
		setDelete("DELETED");
		setMsg("Successfully Deleted");

		return "success";
	}
	else{
		setDocno(getDocno());
		setCompliant(getCompliant());
		setCompdatehidden(sqlStartDate.toString());
		setMsg("Not Deleted");

		return "fail";
	}
	}
	return "fail";
}


}

