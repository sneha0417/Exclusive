package com.controlcentre.masters.relatedmaster.pricecategory;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsPriceCategoryAction extends ActionSupport {
	ClsCommon ClsCommon=new ClsCommon();
	ClsPriceCategoryDAO serviceDAO= new ClsPriceCategoryDAO();
	ClsPriceCategoryBean bean;

	private int docno;
	private String nation;
	private String category;
	
	
	private String mode;
	private String deleted;
	
	private String msg;
	private String formdetailcode;
	private String formdetail;
	private String chkstatus;
	
	
	public String getFormdetail() {
		return formdetail;
	}
	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
	}
	public String getChkstatus() {
		return chkstatus;
	}
	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
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
	
	
	
	
	
	
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getNation() {
		return nation;
	}
	public void setNation(String nation) {
		this.nation = nation;
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

	public String saveAction() throws ParseException, SQLException{
		//System.out.println("*** ACTION *****");
		
	    HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		
		if(mode.equalsIgnoreCase("A")){
						int val=serviceDAO.insert(getCategory(), session,getMode(),getFormdetailcode());
						//System.out.println(val);
						if(val>0){
							
							
							setCategory(getCategory());
							setMode(getMode());
						    setDocno(val);						    
						    setMsg("Successfully Saved");
							return "success";
						}
						else if(val==-1){
							
							setCategory(getCategory());
							setDocno(getDocno());
							setMode(getMode());							
							setChkstatus("1");
							setMsg("PriceCategory Already Exists.");
							return "fail";
						}
						else{
							
							setCategory(getCategory());
							setMode(getMode());
						    setDocno(val);							
						    setMsg("Not Saved");
							return "fail";
						}	
		}

		else if(mode.equalsIgnoreCase("E")){
				int val=serviceDAO.edit(getCategory(),session,getMode(),getDocno(),getFormdetailcode());
				//System.out.println("val========"+val);
				if(val>0){
					
					//session.getAttribute("BranchName");
					
					setDocno(getDocno());
					setCategory(getCategory());
					setMode(getMode());
					
					setMsg("Updated Successfully");
					return "success";
				}
				else if(val==-1){
					
					setCategory(getCategory());
					setDocno(getDocno());
					setMode(getMode());
					
					setChkstatus("2");
					setMsg("PriceCategory Already Exists.");
					return "fail";
				}
				else{
					
					setCategory(getCategory());
					setDocno(getDocno());
					setMode(getMode());
					
					setMsg("Not Updated");
					return "fail";
				}
			}
	
			else if(mode.equalsIgnoreCase("D")){
				boolean Status=serviceDAO.delete(getCategory(),session,getMode(),getDocno(),getFormdetailcode());
			if(Status){
				
				setCategory(getCategory());
				setDocno(getDocno());
				setMode(getMode());
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				
				
				setCategory(getCategory());
				setDocno(getDocno());
				setMode(getMode());
				
				setMsg("Not Deleted");
				return "fail";
			}
			}
		return "fail";
	}
}
