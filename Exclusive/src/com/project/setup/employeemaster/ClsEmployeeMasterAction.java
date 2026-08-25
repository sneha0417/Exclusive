package com.project.setup.employeemaster;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsEmployeeMasterAction extends ActionSupport{

	ClsCommon ClsCommon=new ClsCommon();
	
	ClsEmployeeMasterDAO employeemasterDAO= new ClsEmployeeMasterDAO();
	ClsEmployeeMasterBean employeemasterbean;

	private int txtempmasterdocno;
	private String formdetailcode;
	private String chkstatus;
	private String mode;
	private String deleted;
	private String msg;
	private String employeeDate;
	private String hidemployeeDate;
	private String txtemployeeid;
	private String txtemployeename;
	private String txtempaccount;
	private int txtempaccdocno;
	
	private String lblemployeestatus;

	public int getTxtempmasterdocno() {
		return txtempmasterdocno;
	}

	public void setTxtempmasterdocno(int txtempmasterdocno) {
		this.txtempmasterdocno = txtempmasterdocno;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getChkstatus() {
		return chkstatus;
	}

	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
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

	public String getEmployeeDate() {
		return employeeDate;
	}

	public void setEmployeeDate(String employeeDate) {
		this.employeeDate = employeeDate;
	}

	public String getHidemployeeDate() {
		return hidemployeeDate;
	}

	public void setHidemployeeDate(String hidemployeeDate) {
		this.hidemployeeDate = hidemployeeDate;
	}

	public String getTxtemployeeid() {
		return txtemployeeid;
	}

	public void setTxtemployeeid(String txtemployeeid) {
		this.txtemployeeid = txtemployeeid;
	}

	public String getTxtemployeename() {
		return txtemployeename;
	}

	public void setTxtemployeename(String txtemployeename) {
		this.txtemployeename = txtemployeename;
	}

	public String getTxtempaccount() {
		return txtempaccount;
	}

	public void setTxtempaccount(String txtempaccount) {
		this.txtempaccount = txtempaccount;
	}

	public int getTxtempaccdocno() {
		return txtempaccdocno;
	}

	public void setTxtempaccdocno(int txtempaccdocno) {
		this.txtempaccdocno = txtempaccdocno;
	}

	public String getLblemployeestatus() {
		return lblemployeestatus;
	}

	public void setLblemployeestatus(String lblemployeestatus) {
		this.lblemployeestatus = lblemployeestatus;
	}

	java.sql.Date employeeMasterDate=null;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		String mode=getMode();
		
		
		ClsEmployeeMasterBean bean = new ClsEmployeeMasterBean();

		if(mode.equalsIgnoreCase("A")){
			employeeMasterDate = ClsCommon.changeStringtoSqlDate(getEmployeeDate());	
			
			int val=employeemasterDAO.insert(employeeMasterDate,getFormdetailcode(),getTxtemployeeid(),getTxtemployeename(),getTxtempaccdocno(),session,request,mode);
			if(val>0.0){
				
				setTxtempmasterdocno(val);
				setHidemployeeDate(employeeMasterDate.toString());
				setData();
				
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setData();
				setHidemployeeDate(employeeMasterDate.toString());
				setMsg("Not Saved");
				return "fail";
			}	
		}
		else if(mode.equalsIgnoreCase("E")){
			employeeMasterDate = ClsCommon.changeStringtoSqlDate(getEmployeeDate());	
			
			int Status=employeemasterDAO.edit(getTxtempmasterdocno(),getFormdetailcode(),employeeMasterDate,getTxtemployeeid(),getTxtemployeename(),getTxtempaccdocno(),session,mode);
			
			if(Status>0){
						
						setTxtempmasterdocno(getTxtempmasterdocno());
						setHidemployeeDate(employeeMasterDate.toString());
						setData();
				
						setMsg("Updated Successfully");
				        return "success";
			}
			else{
				setData();
				setTxtempmasterdocno(getTxtempmasterdocno());
				setHidemployeeDate(employeeMasterDate.toString());
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
		int Status=employeemasterDAO.delete(getTxtempmasterdocno(),getFormdetailcode(),session,mode);
		if(Status>0){
					setTxtempmasterdocno(getTxtempmasterdocno());
					setData();
			
					setDeleted("DELETED");
					setMsg("Successfully Deleted");
					return "success";
		}
		else if(Status==-1){
			setChkstatus("1");
			setData();
			setMsg("Transaction Already Exists.");
			return "fail";
		}
		else{
			setData();
			setMsg("Not Deleted");
			return "fail";
		}
		}
		

		else if(mode.equalsIgnoreCase("View")){
			
			employeemasterbean=employeemasterDAO.getViewDetails(getTxtempmasterdocno());
			
			setEmployeeDate(employeemasterbean.getEmployeeDate());
			setTxtemployeeid(employeemasterbean.getTxtemployeeid());
			setTxtemployeename(employeemasterbean.getTxtemployeename());
			setTxtempaccount(employeemasterbean.getTxtempaccount());
			setTxtempaccdocno(employeemasterbean.getTxtempaccdocno());
			setLblemployeestatus(employeemasterbean.getLblemployeestatus());
			setFormdetailcode(employeemasterbean.getFormdetailcode());
			
			return "success";
		}
		
		return "fail";
}

		public  JSONArray searchAllDetails(HttpSession session,String empname,String empid){
			  JSONArray cellarray = new JSONArray();
			  		  JSONObject cellobj = null;
			  try {
				  cellarray= employeemasterDAO.employeeMainSearch(session,empname,empid);
		
			  } catch (SQLException e) {
				  e.printStackTrace();
				  }
			return cellarray;
		}
		
		public void setData() {
			
			setTxtemployeeid(getTxtemployeeid());
			setTxtemployeename(getTxtemployeename());
			setTxtempaccount(getTxtempaccount());
			setTxtempaccdocno(getTxtempaccdocno());
			setFormdetailcode(getFormdetailcode());
			
	}
	
}
