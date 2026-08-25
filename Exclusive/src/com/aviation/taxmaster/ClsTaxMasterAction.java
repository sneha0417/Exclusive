package com.aviation.taxmaster;
import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;
import com.operations.clientrelations.clientcategory.ClsClientCategoryBean;

public class ClsTaxMasterAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
	ClsTaxMasterDAO pDAO= new ClsTaxMasterDAO();
	ClsTaxMasterBean bean;
	private int docno;
	private String mode;
	private String deleted;
	private String msg;
	private String formdetail;
	private String formdetailcode;
	private String tax;
	private String taxdesc;
	private String date;
	private String taxid;
	
	
	
	
	public String getTaxdesc() {
		return taxdesc;
	}
	public void setTaxdesc(String taxdesc) {
		this.taxdesc = taxdesc;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
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
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getFormdetail() {
		return formdetail;
	}
	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
	}
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
	
	
	
	

	public String getTax() {
		return tax;
	}
	public void setTax(String tax) {
		this.tax = tax;
	}
	
	public String getTaxid() {
		return taxid;
	}
	public void setTaxid(String taxid) {
		this.taxid = taxid;
	}
	public String savetaxAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();

		String mode=getMode();
		

		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getDate());

		if(mode.equalsIgnoreCase("A")){
			//			System.out.println("date---"+sqlStartDate);
			int val=pDAO.insert(sqlStartDate,getTax(),getTaxdesc(),getMode(),session,getFormdetailcode());
			if(val>0){
				setTax(getTax());
				//setTaxdesc(getTaxdesc());
				setDocno(val);
				//session.setAttribute("SAVED", "SUCCESSFULLY SAVED");
				setMsg("Successfully Saved");
				addActionMessage("Saved Successfully");
				//							System.out.println(session.getAttribute("SAVED"));
				return "success";
			}
			else if(val==-1){

				setTax(getTax());
				//setTaxdesc(getTaxdesc());
				
				setMsg("Tax Already Exists");
				//request.setAttribute("SAVED", "Not Saved");
				//addActionError("Not Saved");
				return "fail";
			}
			else{
				setTaxdesc(getTaxdesc());
				
				setTax(getTax());
				setMsg("Not Saved");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("E")){
			int Status=pDAO.edit(getDocno(),sqlStartDate,getTax(),getTaxdesc(),session,getFormdetailcode());
			if(Status>0){

				
				setTax(getTax());
				setDocno(getDocno());
				setMsg("Updated Successfully");
				return "success";
			}
			else if(Status==-1){

				setTax(getTax());
				setDocno(getDocno());
				
				setMsg("Tax Already Exists");
				return "fail";

			}
			else{

				setTax(getTax());
				setDocno(getDocno());
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			int Status=pDAO.delete(getDocno(),session,getTax(),getFormdetailcode());
			if(Status>0){
				
				setTax(getTax());
				setDocno(getDocno());
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else if(Status==-2){
				
				setTax(getTax());
				setDocno(getDocno());
				setMsg("References Present in Other Documents");
				return "fail";
			}
			else{

				setTax(getTax());
				setDocno(getDocno());
				setMsg("Not Deleted");
				return "fail";
			}
		}
		return "fail";
	}

	
	

}

