package com.supportdetails;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsSupportDetailsAction extends ActionSupport{

	ClsCommon ClsCommon=new ClsCommon();


	ClsSupportDetailsDAO supportDetailsDAO= new ClsSupportDetailsDAO();
	ClsSupportDetailsBean supportDetailsBean;
	
	private int txtsupportdetailsdocno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String issueDate;
	private String hidissueDate;
	private String issueTime;
	private String hidissueTime;
	private String cmbcompany;
	private String hidcmbcompany;
	private String txtusername;
	private int txtuserid;
	private String cmbissuecategory;
	private String hidcmbissuecategory;
	private String txtissuedescription;
	private String txtempname;
	private int txtempid;
	private String txtremarks;
	private String txtsupportname;
	private int txtsupportid;
	private String cmbstatus;
	private String hidcmbstatus;

	public int getTxtsupportdetailsdocno() {
		return txtsupportdetailsdocno;
	}

	public void setTxtsupportdetailsdocno(int txtsupportdetailsdocno) {
		this.txtsupportdetailsdocno = txtsupportdetailsdocno;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
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

	public String getIssueDate() {
		return issueDate;
	}

	public void setIssueDate(String issueDate) {
		this.issueDate = issueDate;
	}

	public String getHidissueDate() {
		return hidissueDate;
	}

	public void setHidissueDate(String hidissueDate) {
		this.hidissueDate = hidissueDate;
	}

	public String getIssueTime() {
		return issueTime;
	}

	public void setIssueTime(String issueTime) {
		this.issueTime = issueTime;
	}

	public String getHidissueTime() {
		return hidissueTime;
	}

	public void setHidissueTime(String hidissueTime) {
		this.hidissueTime = hidissueTime;
	}

	public String getCmbcompany() {
		return cmbcompany;
	}

	public void setCmbcompany(String cmbcompany) {
		this.cmbcompany = cmbcompany;
	}

	public String getHidcmbcompany() {
		return hidcmbcompany;
	}

	public void setHidcmbcompany(String hidcmbcompany) {
		this.hidcmbcompany = hidcmbcompany;
	}

	public String getTxtusername() {
		return txtusername;
	}

	public void setTxtusername(String txtusername) {
		this.txtusername = txtusername;
	}

	public int getTxtuserid() {
		return txtuserid;
	}

	public void setTxtuserid(int txtuserid) {
		this.txtuserid = txtuserid;
	}

	public String getCmbissuecategory() {
		return cmbissuecategory;
	}

	public void setCmbissuecategory(String cmbissuecategory) {
		this.cmbissuecategory = cmbissuecategory;
	}

	public String getHidcmbissuecategory() {
		return hidcmbissuecategory;
	}

	public void setHidcmbissuecategory(String hidcmbissuecategory) {
		this.hidcmbissuecategory = hidcmbissuecategory;
	}

	public String getTxtissuedescription() {
		return txtissuedescription;
	}

	public void setTxtissuedescription(String txtissuedescription) {
		this.txtissuedescription = txtissuedescription;
	}

	public String getTxtempname() {
		return txtempname;
	}

	public void setTxtempname(String txtempname) {
		this.txtempname = txtempname;
	}

	public int getTxtempid() {
		return txtempid;
	}

	public void setTxtempid(int txtempid) {
		this.txtempid = txtempid;
	}

	public String getTxtremarks() {
		return txtremarks;
	}

	public void setTxtremarks(String txtremarks) {
		this.txtremarks = txtremarks;
	}

	public String getTxtsupportname() {
		return txtsupportname;
	}

	public void setTxtsupportname(String txtsupportname) {
		this.txtsupportname = txtsupportname;
	}

	public int getTxtsupportid() {
		return txtsupportid;
	}

	public void setTxtsupportid(int txtsupportid) {
		this.txtsupportid = txtsupportid;
	}

	public String getCmbstatus() {
		return cmbstatus;
	}

	public void setCmbstatus(String cmbstatus) {
		this.cmbstatus = cmbstatus;
	}

	public String getHidcmbstatus() {
		return hidcmbstatus;
	}

	public void setHidcmbstatus(String hidcmbstatus) {
		this.hidcmbstatus = hidcmbstatus;
	}

	java.sql.Date date ;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsSupportDetailsBean bean = new ClsSupportDetailsBean();

		date = ClsCommon.changeStringtoSqlDate(getIssueDate());
		
		if(mode.equalsIgnoreCase("A")){
			          
				int val=supportDetailsDAO.insert(date,getFormdetailcode(),getIssueTime(),getCmbcompany(),getTxtuserid(),getCmbissuecategory(),getTxtissuedescription(),getTxtempid(),getTxtremarks(),getTxtsupportid(),getCmbstatus(),session,mode);
				if(val>0.0){
					
					setTxtsupportdetailsdocno(val);
					setData();
					
					setMsg("Successfully Saved");
					return "success";
				}
				else{
					setData();
					setMsg("Not Saved");
					return "fail";
				}	
		}
		
		else if(mode.equalsIgnoreCase("E")){

			boolean Status=supportDetailsDAO.edit(getTxtsupportdetailsdocno(),date,getFormdetailcode(),getIssueTime(),getCmbcompany(),getTxtuserid(),getCmbissuecategory(),getTxtissuedescription(),getTxtempid(),getTxtremarks(),getTxtsupportid(),getCmbstatus(),session,mode);
			if(Status){
				
				setTxtsupportdetailsdocno(getTxtsupportdetailsdocno());
				setData();
				
				setMsg("Updated Successfully");
			    return "success";
		}
		else{
			setTxtsupportdetailsdocno(getTxtsupportdetailsdocno());
			setData();
			setMsg("Not Updated");
			return "fail";
		}
	  }
		
		
		else if(mode.equalsIgnoreCase("D")){
			
			boolean Status=supportDetailsDAO.delete(getTxtsupportdetailsdocno(),getFormdetailcode(),mode,session);
			if(Status){
				
				setTxtsupportdetailsdocno(getTxtsupportdetailsdocno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setTxtsupportdetailsdocno(getTxtsupportdetailsdocno());
				setData();
				setMsg("Not Deleted");
				return "fail";
			   }
			}
		
		else if(mode.equalsIgnoreCase("View")){
	
			supportDetailsBean=supportDetailsDAO.getViewDetails(getTxtsupportdetailsdocno());
			
			setIssueDate(supportDetailsBean.getIssueDate());
			setHidissueTime(supportDetailsBean.getIssueTime());
			setHidcmbcompany(supportDetailsBean.getHidcmbcompany());
			setTxtuserid(supportDetailsBean.getTxtuserid());
			setTxtusername(supportDetailsBean.getTxtusername());
			setHidcmbissuecategory(supportDetailsBean.getHidcmbissuecategory());
			setTxtissuedescription(supportDetailsBean.getTxtissuedescription());
			setTxtempid(supportDetailsBean.getTxtempid());
			setTxtempname(supportDetailsBean.getTxtempname());
			setTxtremarks(supportDetailsBean.getTxtremarks());
			setTxtsupportid(supportDetailsBean.getTxtsupportid());
			setTxtsupportname(supportDetailsBean.getTxtsupportname());
			setHidcmbstatus(supportDetailsBean.getHidcmbstatus());
			setFormdetailcode(supportDetailsBean.getFormdetailcode());
			
			return "success";
		}
		return "fail";
}
	
	public  JSONArray searchDetails(String docNo,String date,String issuedstatus,String companyname,String issuedtime,String check){
			  JSONArray cellarray = new JSONArray();
			  		  JSONObject cellobj = null;
			  try {
				cellarray= supportDetailsDAO.esdMainSearch(docNo,date,issuedstatus,companyname,issuedtime,check);
		
			  } catch (SQLException e) {
				  e.printStackTrace();
				  }
			return cellarray;
		}
		
		public void setData() {
			
			setHidissueDate(date.toString());
			setHidissueTime(getIssueTime());
			setHidcmbcompany(getCmbcompany());
			setTxtuserid(getTxtuserid());
			setTxtusername(getTxtusername());
			setHidcmbissuecategory(getCmbissuecategory());
			setTxtissuedescription(getTxtissuedescription());
			setTxtempid(getTxtempid());
			setTxtempname(getTxtempname());
			setTxtremarks(getTxtremarks());
			setTxtsupportid(getTxtsupportid());
			setTxtsupportname(getTxtsupportname());
			setHidcmbstatus(getCmbstatus());
			setFormdetailcode(getFormdetailcode());
		}
}
