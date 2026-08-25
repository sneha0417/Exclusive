package com.controlcentre.masters.maintenancemaster.maintenance;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsMaintenanceAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
	ClsMaintenanceDAO maintenanceDAO=new ClsMaintenanceDAO();
	ClsMaintenanceBean bean;

	private int docno;
	private String miandate,miandatehidden,maintenancetype,desc;
	
	private String msg;
	private String formdetailcode;
	private String formdetail;
	private String mode;
	private String delete;

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
	public String getMaintenancetype() {
		return maintenancetype;
	}
	public void setMaintenancetype(String maintenancetype) {
		this.maintenancetype = maintenancetype;
	}
	
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	
	public String getMiandate() {
		return miandate;
	}
	public void setMiandate(String miandate) {
		this.miandate = miandate;
	}
	public String getMiandatehidden() {
		return miandatehidden;
	}
	public void setMiandatehidden(String miandatehidden) {
		this.miandatehidden = miandatehidden;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
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
		
		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getMiandate());
		
		 int val=maintenanceDAO.insert(getMaintenancetype(),getDesc(),sqlStartDate,session,getMode(),getFormdetailcode());
				if(val>0){
					setMaintenancetype(getMaintenancetype());
					setMode(getMode());
					setDesc(getDesc());
					setMiandatehidden(sqlStartDate.toString());
					setDocno(val);
					
					setMsg("Successfully Saved");
					return "success";
				}
				else{
					setMaintenancetype(getMaintenancetype());
					setMode(getMode());
					setDesc(getDesc());
					setMiandatehidden(sqlStartDate.toString());
					setDocno(val);
					
					setMsg("Not Saved");
					return "fail";
				}	
	}
	else if(mode.equalsIgnoreCase("E")){
		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getMiandate());
		
		boolean Status=maintenanceDAO.edit(getMaintenancetype(),getDesc(),sqlStartDate,session,getMode(),getFormdetailcode(),getDocno());
		
		if(Status){
			
			setDocno(getDocno());
			setMaintenancetype(getMaintenancetype());
			setMode(getMode());
			setDesc(getDesc());
			setMiandatehidden(sqlStartDate.toString());
		
			setMsg("Updated Successfully");
			return "success";
		}
		else{
			setDocno(getDocno());
			setMaintenancetype(getMaintenancetype());
			setMode(getMode());
			setDesc(getDesc());
			setMiandatehidden(sqlStartDate.toString());
			
			setMsg("Not Updated");
			return "fail";
		}
	}
	else if(mode.equalsIgnoreCase("D")){
		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getMiandate());

		boolean Status=maintenanceDAO.delete(session,getMode(),getFormdetailcode(),getDocno());
		if(Status){
			setDocno(getDocno());
			setMaintenancetype(getMaintenancetype());
			setMode(getMode());
			setDesc(getDesc());
			setMiandatehidden(sqlStartDate.toString());
			
			setDelete("DELETED");
			setMsg("Successfully Deleted");
			return "success";
		}
		else{
			setDocno(getDocno());
			setMaintenancetype(getMaintenancetype());
			setMode(getMode());
			setDesc(getDesc());
			setMiandatehidden(sqlStartDate.toString());

			setMsg("Not Deleted");
			return "fail";
		}
	}
	return "fail";
}


}

