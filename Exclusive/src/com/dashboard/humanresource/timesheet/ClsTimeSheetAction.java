package com.dashboard.humanresource.timesheet;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsTimeSheetAction {
	
	ClsCommon ClsCommon=new ClsCommon();
	ClsTimeSheetDAO timeSheetDAO=new ClsTimeSheetDAO();

	private String mode;
	private String msg;
	private String detail;
	private String detailname;
	private String cmbbranch;
	private String cmbyear;
	private String hidcmbyear;
	private String cmbmonth;
	private String hidcmbmonth;
	private String date;
	private String hiddate;
	private String txtprojecttype;
	private String txtprojecttypeid;
	private String txtprojectidname;
	private String txtprojectid;
	private String txtemployeeid;
	private String txtemployeedocno;
	private String txtemployeename;
	
	private int gridlength;

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

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getDetailname() {
		return detailname;
	}

	public void setDetailname(String detailname) {
		this.detailname = detailname;
	}

	public String getCmbbranch() {
		return cmbbranch;
	}

	public void setCmbbranch(String cmbbranch) {
		this.cmbbranch = cmbbranch;
	}

	public String getCmbyear() {
		return cmbyear;
	}

	public void setCmbyear(String cmbyear) {
		this.cmbyear = cmbyear;
	}

	public String getHidcmbyear() {
		return hidcmbyear;
	}

	public void setHidcmbyear(String hidcmbyear) {
		this.hidcmbyear = hidcmbyear;
	}

	public String getCmbmonth() {
		return cmbmonth;
	}

	public void setCmbmonth(String cmbmonth) {
		this.cmbmonth = cmbmonth;
	}

	public String getHidcmbmonth() {
		return hidcmbmonth;
	}

	public void setHidcmbmonth(String hidcmbmonth) {
		this.hidcmbmonth = hidcmbmonth;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getHiddate() {
		return hiddate;
	}

	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
	}

	public String getTxtprojecttype() {
		return txtprojecttype;
	}

	public void setTxtprojecttype(String txtprojecttype) {
		this.txtprojecttype = txtprojecttype;
	}

	public String getTxtprojecttypeid() {
		return txtprojecttypeid;
	}

	public void setTxtprojecttypeid(String txtprojecttypeid) {
		this.txtprojecttypeid = txtprojecttypeid;
	}

	public String getTxtprojectidname() {
		return txtprojectidname;
	}

	public void setTxtprojectidname(String txtprojectidname) {
		this.txtprojectidname = txtprojectidname;
	}

	public String getTxtprojectid() {
		return txtprojectid;
	}

	public void setTxtprojectid(String txtprojectid) {
		this.txtprojectid = txtprojectid;
	}

	public String getTxtemployeeid() {
		return txtemployeeid;
	}

	public void setTxtemployeeid(String txtemployeeid) {
		this.txtemployeeid = txtemployeeid;
	}

	public String getTxtemployeedocno() {
		return txtemployeedocno;
	}

	public void setTxtemployeedocno(String txtemployeedocno) {
		this.txtemployeedocno = txtemployeedocno;
	}

	public String getTxtemployeename() {
		return txtemployeename;
	}

	public void setTxtemployeename(String txtemployeename) {
		this.txtemployeename = txtemployeename;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	java.sql.Date dbTimeSheetDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		
		dbTimeSheetDate = (getDate()==null || getDate().trim().equalsIgnoreCase(""))?null:ClsCommon.changeStringtoSqlDate(getDate());
		
		if(mode.equalsIgnoreCase("A")){
			
			/*Time Sheet Grid Saving*/
			ArrayList<String> timesheetarray= new ArrayList<String>();
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				timesheetarray.add(temp);
			}
			/*Time Sheet Grid Saving Ends*/
			
			int val=timeSheetDAO.insert(getCmbbranch(),getCmbyear(),getCmbmonth(),timesheetarray,session,request,mode);
			if(val>0.0){
				setDetail("Human Resource");
				setDetailname("Time Sheet");
				setHidcmbyear(getCmbyear());
				setHidcmbmonth(getCmbmonth());
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setDetail("Human Resource");
				setDetailname("Time Sheet");
				setHidcmbyear(getCmbyear());
				setHidcmbmonth(getCmbmonth());
				setMsg("Not Saved");
				return "fail";
			}	
		}
		return "fail";
	}
}


