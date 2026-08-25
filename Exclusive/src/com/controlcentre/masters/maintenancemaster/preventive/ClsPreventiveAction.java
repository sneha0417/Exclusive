package com.controlcentre.masters.maintenancemaster.preventive;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsPreventiveAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();

	ClsPreventiveDAO preventiveDAO=new ClsPreventiveDAO();
	ClsPreventiveBean bean;

	private int docno;
	private String prevdate;
	private String prevdatehidden;
	private String maintenanceid;
	private String maintenancetype;
	private String msg;
	private String formdetailcode;
	private String formdetail;
	private String mode;
	private String delete;
	private double lbrchg;

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
	public String getPrevdate() {
		return prevdate;
	}
	public void setPrevdate(String prevdate) {
		this.prevdate = prevdate;
	}
	public String getPrevdatehidden() {
		return prevdatehidden;
	}
	public void setPrevdatehidden(String prevdatehidden) {
		this.prevdatehidden = prevdatehidden;
	}
	public String getMaintenanceid() {
		return maintenanceid;
	}
	public void setMaintenanceid(String maintenanceid) {
		this.maintenanceid = maintenanceid;
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
	public double getLbrchg() {
		return lbrchg;
	}
	public void setLbrchg(double lbrchg) {
		this.lbrchg = lbrchg;
	}
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();

		session.getAttribute("BRANCHID");
		String mode=getMode();
		ClsPreventiveBean bean=new ClsPreventiveBean();
		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getPrevdate());

	if(mode.equalsIgnoreCase("A")){
			int val=preventiveDAO.insert(getMaintenanceid(),getMaintenancetype(),sqlStartDate,getLbrchg(),session,getMode(),getFormdetailcode());
			
			if(val>0.0){
				
				setMaintenanceid(getMaintenanceid());
				setMode(getMode());
				setMaintenancetype(getMaintenancetype());
				setPrevdatehidden(getPrevdate());
				setLbrchg(getLbrchg());
				setDocno(val);

				setMsg("Successfully Saved");
				return "success";
			}
			else{
			
				setMaintenanceid(getMaintenanceid());
				setMode(getMode());
				setMaintenancetype(getMaintenancetype());
				setPrevdatehidden(getPrevdate());
				setLbrchg(getLbrchg());
				setDocno(val);

				setMsg("Not Saved");
				return "fail";
			}	
	}
	
	else if(mode.equalsIgnoreCase("E")){
		
		boolean Status=preventiveDAO.edit(getMaintenanceid(),getMaintenancetype(),sqlStartDate,getLbrchg(),session,getMode(),getDocno(),getFormdetailcode());
		
		if(Status){
		
			setMaintenanceid(getMaintenanceid());
			setDocno(getDocno());
			setMode(getMode());
			setMaintenancetype(getMaintenancetype());
			setPrevdatehidden(getPrevdate());
			setMode(getMode());
			setLbrchg(getLbrchg());
			
			setMsg("Updated Successfully");
			return "success";
		}
		else{setMaintenanceid(getMaintenanceid());
			setDocno(getDocno());
			setMode(getMode());
			setMaintenancetype(getMaintenancetype());
			setPrevdatehidden(getPrevdate());
			setMode(getMode());
			setLbrchg(getLbrchg());
			
			setMsg("Not Updated");
			return "fail";
		}
	}
	else if(mode.equalsIgnoreCase("D")){

		boolean Status=preventiveDAO.delete(getMaintenanceid(),getMaintenancetype(),sqlStartDate,getLbrchg(),session,getMode(),getDocno(),getFormdetailcode());
	
		if(Status){
			setMaintenanceid(getMaintenanceid());
			setDocno(getDocno());
			setMode(getMode());
			setMaintenancetype(getMaintenancetype());
			setPrevdatehidden(getPrevdate());
			setMode(getMode());
			setLbrchg(getLbrchg());
			
			setDelete("DELETED");
			setMsg("Successfully Deleted");
			return "success";
	}
	else{
		setMaintenanceid(getMaintenanceid());
		setDocno(getDocno());
		setMode(getMode());
		setMaintenancetype(getMaintenancetype());
		setPrevdatehidden(getPrevdate());
		setMode(getMode());
		setLbrchg(getLbrchg());

		setMsg("Not Deleted");
		return "fail";
	}
	}
	return "fail";
  }
}

