package com.controlcentre.settings.companysettings.location;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

public class ClsLocationAction extends ActionSupport{
	ClsLocationDAO locationDAO= new ClsLocationDAO();
	ClsLocationBean bean;
private int docno;
private String cmbbranchname;
private String hidcmbbranchname;
private String txtloccode;
private String txtlocname;
private String txtaddress;
private String txtpbno;
private String txttel1;
private String txttel2;
private String txtfax1;
private String txtfax2;
private String txtemail1;
private String txtwebsite;
private String mode;
private String deleted;
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
public int getDocno() {
	return docno;
}
public void setDocno(int docno) {
	this.docno = docno;
}
public String getCmbbranchname() {
	return cmbbranchname;
}
public void setCmbbranchname(String cmbbranchname) {
	this.cmbbranchname = cmbbranchname;
}
public String getHidcmbbranchname() {
	return hidcmbbranchname;
}
public void setHidcmbbranchname(String hidcmbbranchname) {
	this.hidcmbbranchname = hidcmbbranchname;
}
public String getTxtloccode() {
	return txtloccode;
}
public void setTxtloccode(String txtloccode) {
	this.txtloccode = txtloccode;
}
public String getTxtlocname() {
	return txtlocname;
}
public void setTxtlocname(String txtlocname) {
	this.txtlocname = txtlocname;
}
public String getTxtaddress() {
	return txtaddress;
}
public void setTxtaddress(String txtaddress) {
	this.txtaddress = txtaddress;
}
public String getTxtpbno() {
	return txtpbno;
}
public void setTxtpbno(String txtpbno) {
	this.txtpbno = txtpbno;
}
public String getTxttel1() {
	return txttel1;
}
public void setTxttel1(String txttel1) {
	this.txttel1 = txttel1;
}
public String getTxttel2() {
	return txttel2;
}
public void setTxttel2(String txttel2) {
	this.txttel2 = txttel2;
}
public String getTxtfax1() {
	return txtfax1;
}
public void setTxtfax1(String txtfax1) {
	this.txtfax1 = txtfax1;
}
public String getTxtfax2() {
	return txtfax2;
}
public void setTxtfax2(String txtfax2) {
	this.txtfax2 = txtfax2;
}
public String getTxtemail1() {
	return txtemail1;
}
public void setTxtemail1(String txtemail1) {
	this.txtemail1 = txtemail1;
}
public String getTxtwebsite() {
	return txtwebsite;
}
public void setTxtwebsite(String txtwebsite) {
	this.txtwebsite = txtwebsite;
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



public void setValues(int docno){
	setCmbbranchname(getCmbbranchname());
	setHidcmbbranchname(getCmbbranchname());
	setTxtloccode(getTxtloccode());
	setTxtlocname(getTxtlocname());
	setTxtaddress(getTxtaddress());
	setTxttel1(getTxttel1());
	setTxttel2(getTxttel2());
	setTxtfax1(getTxtfax1());
	setTxtfax2(getTxtfax2());
	setTxtemail1(getTxtemail1());
	setTxtwebsite(getTxtwebsite());
	setDocno(docno);
}
public String saveAction() throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	session.getAttribute("BranchName");
//	System.out.println("sessoin"+session.getAttribute("BRANCHSELECTED"));
//	System.out.println("sessoin"+session.getAttribute("COMPANYNAME"));
	if(mode.equalsIgnoreCase("A")){
//		System.out.println("inside a");
					int val=locationDAO.insert(getCmbbranchname(),getTxtloccode(),getTxtlocname(),getTxtaddress(),getTxtpbno(),getTxttel1(),
							getTxttel2(),getTxtfax1(),getTxtfax2(),getTxtemail1(),getTxtwebsite(),session,getMode(),getFormdetailcode());
					if(val>0.0){
							setValues(val);
							setMsg("Successfully Saved");

							return "success";
						}
						else{
							setValues(val);
							setMsg("Not Saved");

							return "fail";
						}	
		}

		else if(mode.equalsIgnoreCase("E")){
				boolean Status=locationDAO.edit(getCmbbranchname(),getTxtloccode(),getTxtlocname(),getTxtaddress(),getTxtpbno(),
						getTxttel1(),getTxttel2(),getTxtfax1(),getTxtfax2(),getTxtemail1(),getTxtwebsite(),session,getMode(),getDocno(),getFormdetailcode());
				if(Status){
					setValues(getDocno());
				//	System.out.println("brand"+brand);
					setMsg("Updated Successfully");

					return "success";
				}
				else{
					setValues(getDocno());
					setMsg("Not Updated");

					return "fail";
				}
			}
			else if(mode.equalsIgnoreCase("D")){
				//System.out.println(getDocno()+","+getBrandid()+","+getModeldate());
				int Status=locationDAO.delete(getCmbbranchname(),getTxtloccode(),getTxtlocname(),getTxtaddress(),getTxtpbno(),
						getTxttel1(),getTxttel2(),getTxtfax1(),getTxtfax2(),getTxtemail1(),getTxtwebsite(),session,getMode(),getDocno(),getFormdetailcode());
			if(Status>0){
				setValues(getDocno());
				setDeleted("DELETED");
			//	System.out.println("brand"+brand);
				setMsg("Successfully Deleted");

				return "success";
			}
			else if(Status==-1){
				setValues(getDocno());
				setMsg("References Present in Other Documents");

				return "fail";
			}
			else{
				setValues(getDocno());
				setMsg("Not Deleted");

				return "fail";
			}
		}
			return "fail";
		}
	}


		  