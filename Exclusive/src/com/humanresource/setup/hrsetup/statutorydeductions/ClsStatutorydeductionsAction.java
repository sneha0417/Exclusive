package com.humanresource.setup.hrsetup.statutorydeductions;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsStatutorydeductionsAction {

	ClsCommon ClsCommon=new ClsCommon();

	 
	ClsStatutorydeductionsDAO saveDAO= new ClsStatutorydeductionsDAO()	;
	
	private String  statudate,satudeduction,remarks,mode,msg,deleted,chkstatus,datehidden,formdetailcode,accname ;
	private int docno,acno,accdocno,type,hidtype;
 
	public int getHidtype() {
		return hidtype;
	}
	public void setHidtype(int hidtype) {
		this.hidtype = hidtype;
	}
	public String getStatudate() {
		return statudate;
	}
	public void setStatudate(String statudate) {
		this.statudate = statudate;
	}
	public String getSatudeduction() {
		return satudeduction;
	}
	public void setSatudeduction(String satudeduction) {
		this.satudeduction = satudeduction;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {   
		this.type = type;
	}
	public String getAccname() {
		return accname;
	}
	public void setAccname(String accname) { 
		this.accname = accname;
	}
	public int getAcno() {
		return acno;
	}
	public void setAcno(int acno) {
		this.acno = acno;
	}
	public int getAccdocno() {
		return accdocno;
	}
	public void setAccdocno(int accdocno) {
		this.accdocno = accdocno;
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
 
		java.sql.Date formdate=	ClsCommon.changeStringtoSqlDate(getStatudate());
 
		int val=saveDAO.insert(formdate,getSatudeduction(),getRemarks(),getMode(),getFormdetailcode(),session,request,getAccdocno(),getType());
		
		if(val>0) {
			
			 setDocno(val);
			 setDatehidden(formdate.toString());
			 setSatudeduction(getSatudeduction());
			 setHidtype(getType());
			 setRemarks(getRemarks());
			 setAccname(getAccname());
			 setAcno(getAcno());
			 setAccdocno(getAccdocno());
			 
			 setMsg("Successfully Saved");
			 return "success";
		} else if(val==-1) {
			setDatehidden(formdate.toString());
			setSatudeduction(getSatudeduction());
			setHidtype(getType());
			setRemarks(getRemarks());
			setAccname(getAccname());
			setAcno(getAcno());
			setAccdocno(getAccdocno());
		    setChkstatus("1");
		    
		    setMsg("Statutory Deductions Already Exists");
	        return "fail";
	     }  else {
			 
			 setDatehidden(formdate.toString());
             setSatudeduction(getSatudeduction());
             setHidtype(getType());
			 setRemarks(getRemarks());
			 setAccname(getAccname());
			 setAcno(getAcno());
			 setAccdocno(getAccdocno());
			 
			 setMsg("Not Saved");
			 return "fail";
		}
	}
	
	else if(getMode().equalsIgnoreCase("E")) {
 
		java.sql.Date formdate=	ClsCommon.changeStringtoSqlDate(getStatudate());
 
		int val=saveDAO.Update(getDocno(),formdate,getSatudeduction(),getRemarks(),getMode(),getFormdetailcode(),session,request,getAccdocno(),getType());
		
		if(val>0) {
			
			 setDocno(getDocno());
			 setDatehidden(formdate.toString());
			 setSatudeduction(getSatudeduction());
			 setHidtype(getType());
			 setRemarks(getRemarks());
			 setAccname(getAccname());
			 setAcno(getAcno());
			 setAccdocno(getAccdocno());
	 			
			 setMsg("Updated Successfully");
			 return "success";
		} else if(val==-1) {
			setDocno(getDocno());
			setDatehidden(formdate.toString());
			setSatudeduction(getSatudeduction());
			setHidtype(getType());
			setRemarks(getRemarks());
			setAccname(getAccname());
			setAcno(getAcno());
			setAccdocno(getAccdocno());
		    setChkstatus("2");
		    setMsg("Statutory Deductions Already Exists");
	        return "fail";
	   }  else {
			 setDocno(getDocno());
			 setDatehidden(formdate.toString());
			 setSatudeduction(getSatudeduction());
			 setHidtype(getType());
			 setRemarks(getRemarks());
			 setAccname(getAccname());
			 setAcno(getAcno());
			 setAccdocno(getAccdocno());
				
			 setMsg("Not Updated");
			 return "fail";
		}
	}
	
	else if(getMode().equalsIgnoreCase("D")) {
 
		java.sql.Date formdate=	ClsCommon.changeStringtoSqlDate(getStatudate());
 
		int val=saveDAO.delete(getDocno(),getMode(),getFormdetailcode(),session,request,getAccdocno());
		
		if(val>0) {
			
			 setDocno(getDocno());
			 setDatehidden(formdate.toString());
			 setSatudeduction(getSatudeduction());
			 setHidtype(getType());
			 setRemarks(getRemarks());
			 setAccname(getAccname());
			 setAcno(getAcno());
			 setAccdocno(getAccdocno());
			 
			 setDeleted("DELETED");
			 setMsg("Successfully Deleted");
			 return "success";
			
		} else {
			 setDocno(getDocno());
			 setDatehidden(formdate.toString());
			 setSatudeduction(getSatudeduction());
			 setHidtype(getType());
			 setRemarks(getRemarks());
			 setAccname(getAccname());
			 setAcno(getAcno());
			 setAccdocno(getAccdocno());
			 
			 setMsg("Not Deleted");
             return "fail";
		}
	}
	return "fail";
  }
}
