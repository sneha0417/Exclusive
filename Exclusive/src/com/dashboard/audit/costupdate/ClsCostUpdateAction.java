package com.dashboard.audit.costupdate;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

public class ClsCostUpdateAction {
ClsCostupdateDAO costupdatedao=new ClsCostupdateDAO();
private String hidtrno;
private String hidgridacno;
private String mode;
private String msg;
private String detail;
private String detailname;
private String cmbcosttype;
private String hidcostcode;
private String missingtrno;



public String getHidgridacno() {
	return hidgridacno;
}

public void setHidgridacno(String hidgridacno) {
	this.hidgridacno = hidgridacno;
}

public String getCmbcosttype() {
	return cmbcosttype;
}

public void setCmbcosttype(String cmbcosttype) {
	this.cmbcosttype = cmbcosttype;
}

public String getHidcostcode() {
	return hidcostcode;
}

public void setHidcostcode(String hidcostcode) {
	this.hidcostcode = hidcostcode;
}

public String getMissingtrno() {
	return missingtrno;
}

public void setMissingtrno(String missingtrno) {
	this.missingtrno = missingtrno;
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

public String getMode() {
	return mode;
}

public void setMode(String mode) {
	this.mode = mode;
}

public String getHidtrno() {
	return hidtrno;
}

public void setHidtrno(String hidtrno) {
	this.hidtrno = hidtrno;
}

public String getMsg() {
	return msg;
}

public void setMsg(String msg) {
	this.msg = msg;
}

public String saveAction() throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	String mode=getMode();
	if(mode.equalsIgnoreCase("A")){
		int val=costupdatedao.InsertNew(getHidgridacno());
		if(val>0){
			setMsg("Successfully Saved");
			 setDetail("Audit");
				setDetailname("Cost Update");
			return "success";
		}
		else{
			setMsg("Not Saved");
			setDetail("Audit");
			setDetailname("Cost Update");
			return "fail";
		}
	}
	else if(mode.equalsIgnoreCase("MU")){
		System.out.println("trno: "+getMissingtrno());
		int val=costupdatedao.updateMissing(getMissingtrno(),getCmbcosttype(),getHidcostcode());
		if(val>0){
			setMissingtrno("");
			setCmbcosttype("");
			setHidcostcode("");
			setMsg("Updated Successfully");
			 setDetail("Audit");
				setDetailname("Cost Update");
			return "success";
		}
		else{
			setMissingtrno("");
			setCmbcosttype("");
			setHidcostcode("");
			setMsg("Not Updated");
			setDetail("Audit");
			setDetailname("Cost Update");
			return "fail";
		}
	}
	
	
	return "fail";
}

}
