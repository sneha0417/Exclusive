package com.controlcentre.masters.vehiclemaster.leasecdw;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

// import bsh.ParseException;

import com.common.ClsCommon;

public class ClsLeaseCDWAction {
	
	ClsLeaseCDWDAO cdwdao=new ClsLeaseCDWDAO();
	ClsCommon objcommon=new ClsCommon();
	private int docno;
	private String date;
	private String name;
	private String remarks;
	private String description;
	private String hidchkreplace;
	private String mode;
	private String msg;
	private String deleted;
	private String brchName;
	private String formdetailcode;
	private String hidchkexscdw;
	
	
	public String getHidchkexscdw() {
		return hidchkexscdw;
	}
	public void setHidchkexscdw(String hidchkexscdw) {
		this.hidchkexscdw = hidchkexscdw;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
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
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getHidchkreplace() {
		return hidchkreplace;
	}
	public void setHidchkreplace(String hidchkreplace) {
		this.hidchkreplace = hidchkreplace;
	}
	
	public void setValues(int docno,java.sql.Date sqldate){
		setDocno(docno);
		setDate(sqldate.toString());
		setName(getName());
		setRemarks(getRemarks());
		setDescription(getDescription());
		setHidchkreplace(getHidchkreplace());
	}
	public String saveAction() throws SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		
		String mode=getMode();
		java.sql.Date sqldate=null;
		if(!getDate().equalsIgnoreCase("") && getDate()!=null){
			sqldate=objcommon.changeStringtoSqlDate(getDate());
		}
		if(mode.equalsIgnoreCase("A")){
			int val=cdwdao.insert(sqldate,getName(),getHidchkreplace(),getRemarks(),getDescription(),mode,session,getBrchName(),getFormdetailcode(),getHidchkexscdw());
			if(val>0){
				setValues(val, sqldate);
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setValues(val, sqldate);
				setMsg("Not Saved");
				return "fail";
			}
		}
		else if (mode.equalsIgnoreCase("E")){
			boolean status=cdwdao.edit(getDocno(),sqldate,getName(),getHidchkreplace(),getRemarks(),getDescription(),mode,session,getBrchName(),getFormdetailcode(),getHidchkexscdw());
			if(status){
				setValues(getDocno(), sqldate);
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setValues(getDocno(), sqldate);
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if (mode.equalsIgnoreCase("D")){
			boolean status=cdwdao.delete(getDocno(),sqldate,getName(),getHidchkreplace(),getRemarks(),getDescription(),mode,session,getBrchName(),getFormdetailcode(),getHidchkexscdw());
			if(status){
				setValues(getDocno(), sqldate);
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				
				return "success";
			}
			else{
				setValues(getDocno(), sqldate);
				setMsg("Not Deleted");
				return "fail";
			}
		}
		return "fail";
	}
}
