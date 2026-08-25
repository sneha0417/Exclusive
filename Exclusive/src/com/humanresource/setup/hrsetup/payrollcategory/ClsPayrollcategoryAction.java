package com.humanresource.setup.hrsetup.payrollcategory;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsPayrollcategoryAction {

	ClsCommon ClsCommon=new ClsCommon();


	ClsPayrollcategoryDAO saveDAO= new ClsPayrollcategoryDAO()	;
	
	private String  parrolldate,category,remarks,mode,msg,deleted,chkstatus,datehidden,formdetailcode ;
	private int docno,timesheet,hidtimesheet;
 
	public int getHidtimesheet() {
		return hidtimesheet;
	}
	public void setHidtimesheet(int hidtimesheet) {
		this.hidtimesheet = hidtimesheet;
	}
	public String getParrolldate() {
		return parrolldate;
	}
	public void setParrolldate(String parrolldate) {
		this.parrolldate = parrolldate;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getTimesheet() {
		return timesheet;
	}
	public void setTimesheet(int timesheet) {
		this.timesheet = timesheet;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
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
	public String getChkstatus() {
		return chkstatus;
	}
	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
	}
	public String getDatehidden() {
		return datehidden;
	}
	public void setDatehidden(String datehidden) {
		this.datehidden = datehidden;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	} 
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String saveAction() throws SQLException {
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	
	if(getMode().equalsIgnoreCase("A")) {
 
		java.sql.Date formdate=	ClsCommon.changeStringtoSqlDate(getParrolldate());
 
		int val=saveDAO.insert(formdate,getCategory(),getRemarks(),getMode(),getFormdetailcode(),session,request,getTimesheet());
		
		if(val>0) {
			
			 setDocno(val);
			 setDatehidden(formdate.toString());
			 setCategory(getCategory());
			 setRemarks(getRemarks());
			 setHidtimesheet(getTimesheet());
			 
			 setMsg("Successfully Saved");
			 return "success";
		} else if(val==-1) {
		    setDatehidden(formdate.toString());
		    setCategory(getCategory());
			setRemarks(getRemarks());
			setHidtimesheet(getTimesheet());
		    setChkstatus("1");
		    
		    setMsg("Payroll Category Already Exists");
	        return "fail";
		}  else {
			 
			 setDatehidden(formdate.toString());
			 setCategory(getCategory());
			 setRemarks(getRemarks());
			 setHidtimesheet(getTimesheet());
			
			 setMsg("Not Saved");
			 return "fail";
		}
	}
	
	else if(getMode().equalsIgnoreCase("E")) {
 
		java.sql.Date formdate=	ClsCommon.changeStringtoSqlDate(getParrolldate());
 
		int val=saveDAO.Update(getDocno(),formdate,getCategory(),getRemarks(),getMode(),getFormdetailcode(),session,request,getTimesheet());
		
		if(val>0) {
			
			 setDocno(getDocno());
			 setDatehidden(formdate.toString());
			 setCategory(getCategory());
			 setRemarks(getRemarks());
			 setHidtimesheet(getTimesheet());
	 			
			 setMsg("Updated Successfully");
			 return "success";
			
		} else if(val==-1) {
			setDocno(getDocno());
		    setDatehidden(formdate.toString());
		    setCategory(getCategory());
			setRemarks(getRemarks());
			setHidtimesheet(getTimesheet());
		    setChkstatus("2");
		    
		    setMsg("Payroll Category Already Exists");
	        return "fail";
		}  else {
			 setDocno(getDocno());
			 setDatehidden(formdate.toString());
			 setCategory(getCategory());
			 setRemarks(getRemarks());
			 setHidtimesheet(getTimesheet());
				
			 setMsg("Not Updated");
			 return "fail";
		}
	}
	
	else if(getMode().equalsIgnoreCase("D")) {
 
		java.sql.Date formdate=	ClsCommon.changeStringtoSqlDate(getParrolldate());
 
		int val=saveDAO.delete(getDocno(),getMode(),getFormdetailcode(),session,request);
		
		if(val>0) {
			
			 setDocno(getDocno());
			 setDatehidden(formdate.toString());
			 setCategory(getCategory());
			 setRemarks(getRemarks());
			 setHidtimesheet(getTimesheet());
			 setDeleted("DELETED");
			 setMsg("Successfully Deleted");
			 return "success";
			
		} else {
			 setDocno(getDocno());
			 setDatehidden(formdate.toString());
			 setCategory(getCategory());
			 setRemarks(getRemarks());
			 setHidtimesheet(getTimesheet());
			 setMsg("Not Deleted");
             return "fail";
		}
	}
	return "fail";
  }
}
