package com.workdetails;

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
public class ClsWorkDetailsAction extends ActionSupport{

	ClsCommon ClsCommon=new ClsCommon();


	ClsWorkDetailsDAO workDetailsDAO= new ClsWorkDetailsDAO();
	ClsWorkDetailsBean workDetailsBean;
	
	private int txtworkdetailsdocno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String workDetailsDate;
	private String hidworkDetailsDate;
	private String cmbproject;
	private String hidcmbproject;
	private String txtempname;
	private String txtempid;
	private String cmbcorrectiontype;
	private String hidcmbcorrectiontype;
	private String cmbformtype;
	private String hidcmbformtype;
	private String txtformname;
	private String startDate;
	private String hidstartDate;
	private String endDate;
	private String hidendDate;
	private String txtdetail;
	
	public int getTxtworkdetailsdocno() {
		return txtworkdetailsdocno;
	}

	public void setTxtworkdetailsdocno(int txtworkdetailsdocno) {
		this.txtworkdetailsdocno = txtworkdetailsdocno;
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

	public String getWorkDetailsDate() {
		return workDetailsDate;
	}

	public void setWorkDetailsDate(String workDetailsDate) {
		this.workDetailsDate = workDetailsDate;
	}

	public String getHidworkDetailsDate() {
		return hidworkDetailsDate;
	}

	public void setHidworkDetailsDate(String hidworkDetailsDate) {
		this.hidworkDetailsDate = hidworkDetailsDate;
	}

	public String getCmbproject() {
		return cmbproject;
	}

	public void setCmbproject(String cmbproject) {
		this.cmbproject = cmbproject;
	}

	public String getHidcmbproject() {
		return hidcmbproject;
	}

	public void setHidcmbproject(String hidcmbproject) {
		this.hidcmbproject = hidcmbproject;
	}

	public String getTxtempname() {
		return txtempname;
	}

	public void setTxtempname(String txtempname) {
		this.txtempname = txtempname;
	}

	public String getTxtempid() {
		return txtempid;
	}

	public void setTxtempid(String txtempid) {
		this.txtempid = txtempid;
	}

	public String getCmbcorrectiontype() {
		return cmbcorrectiontype;
	}

	public void setCmbcorrectiontype(String cmbcorrectiontype) {
		this.cmbcorrectiontype = cmbcorrectiontype;
	}

	public String getHidcmbcorrectiontype() {
		return hidcmbcorrectiontype;
	}

	public void setHidcmbcorrectiontype(String hidcmbcorrectiontype) {
		this.hidcmbcorrectiontype = hidcmbcorrectiontype;
	}

	public String getCmbformtype() {
		return cmbformtype;
	}

	public void setCmbformtype(String cmbformtype) {
		this.cmbformtype = cmbformtype;
	}

	public String getHidcmbformtype() {
		return hidcmbformtype;
	}

	public void setHidcmbformtype(String hidcmbformtype) {
		this.hidcmbformtype = hidcmbformtype;
	}

	public String getTxtformname() {
		return txtformname;
	}

	public void setTxtformname(String txtformname) {
		this.txtformname = txtformname;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getHidstartDate() {
		return hidstartDate;
	}

	public void setHidstartDate(String hidstartDate) {
		this.hidstartDate = hidstartDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getHidendDate() {
		return hidendDate;
	}

	public void setHidendDate(String hidendDate) {
		this.hidendDate = hidendDate;
	}

	public String getTxtdetail() {
		return txtdetail;
	}

	public void setTxtdetail(String txtdetail) {
		this.txtdetail = txtdetail;
	}

	java.sql.Date date ;
	java.sql.Date startsDate;
	java.sql.Date endsDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsWorkDetailsBean bean = new ClsWorkDetailsBean();

		date = ClsCommon.changeStringtoSqlDate(getWorkDetailsDate());
		startsDate = ClsCommon.changeStringtoSqlDate(getStartDate());
		endsDate = ClsCommon.changeStringtoSqlDate(getEndDate());
		
		if(mode.equalsIgnoreCase("A")){
			          
				int val=workDetailsDAO.insert(date,getFormdetailcode(),getCmbproject(),getTxtempname(),getCmbcorrectiontype(),getCmbformtype(),getTxtformname(),startsDate,endsDate,getTxtdetail(),session,mode);
				if(val>0.0){
					
					setTxtworkdetailsdocno(val);
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

			boolean Status=workDetailsDAO.edit(getTxtworkdetailsdocno(),date,getFormdetailcode(),getCmbproject(),getTxtempname(),getCmbcorrectiontype(),getCmbformtype(),getTxtformname(),startsDate,endsDate,getTxtdetail(),session,mode);
			if(Status){
				
				setTxtworkdetailsdocno(getTxtworkdetailsdocno());
				setData();
				
				setMsg("Updated Successfully");
			    return "success";
		}
		else{
			setTxtworkdetailsdocno(getTxtworkdetailsdocno());
			setData();
			setMsg("Not Updated");
			return "fail";
		}
	  }
		
		
		else if(mode.equalsIgnoreCase("D")){
			
			boolean Status=workDetailsDAO.delete(getTxtworkdetailsdocno(),getFormdetailcode(),mode,session);
			if(Status){
				
				setTxtworkdetailsdocno(getTxtworkdetailsdocno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setTxtworkdetailsdocno(getTxtworkdetailsdocno());
				setData();
				setMsg("Not Deleted");
				return "fail";
			   }
			}
		
		else if(mode.equalsIgnoreCase("View")){
	
			workDetailsBean=workDetailsDAO.getViewDetails(getTxtworkdetailsdocno());
			
			setWorkDetailsDate(workDetailsBean.getWorkDetailsDate());
			setHidcmbproject(workDetailsBean.getHidcmbproject());
			setTxtempname(workDetailsBean.getTxtempname());
			setHidcmbcorrectiontype(workDetailsBean.getHidcmbcorrectiontype());
			setHidcmbformtype(workDetailsBean.getHidcmbformtype());
			setTxtformname(workDetailsBean.getTxtformname());
			setHidstartDate(workDetailsBean.getStartDate());
			setHidendDate(workDetailsBean.getEndDate());
			setTxtdetail(workDetailsBean.getTxtdetail());
			setFormdetailcode(workDetailsBean.getFormdetailcode());
			
			return "success";
		}
		return "fail";
}
	
	public  JSONArray searchDetails(String docNo,String date,String formname,String empname){
			  JSONArray cellarray = new JSONArray();
			  		  JSONObject cellobj = null;
			  try {
				cellarray= workDetailsDAO.ewdMainSearch(docNo,date,formname,empname);
		
			  } catch (SQLException e) {
				  e.printStackTrace();
				  }
			return cellarray;
		}
		
		public void setData() {
			
			setHidworkDetailsDate(date.toString());
			setHidcmbproject(getCmbproject());
			setTxtempname(getTxtempname());
			setHidcmbcorrectiontype(getCmbcorrectiontype());
			setHidcmbformtype(getCmbformtype());
			setTxtformname(getTxtformname());
			setHidstartDate(startsDate.toString());
			setHidendDate(endsDate.toString());
			setTxtdetail(getTxtdetail());
			setFormdetailcode(getFormdetailcode());
		}
}
