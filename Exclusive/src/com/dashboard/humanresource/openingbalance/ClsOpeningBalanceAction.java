package com.dashboard.humanresource.openingbalance;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsOpeningBalanceAction {
	
	ClsCommon ClsCommon=new ClsCommon();
	ClsOpeningBalanceDAO openingBalanceDAO=new ClsOpeningBalanceDAO();

	private String mode;
	private String msg;
	private String detail;
	private String detailname;
	private String cmbbranch;
	private String cmbempcategory;
	private String hidcmbempcategory;
	private String cmbdepartment;
	private String hidcmbdepartment;
	private String txtemployeeid;
	private String txtemployeename;
	private int txtemployeedocno;
	private String txtemployeeids;
	
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

	public String getCmbempcategory() {
		return cmbempcategory;
	}

	public void setCmbempcategory(String cmbempcategory) {
		this.cmbempcategory = cmbempcategory;
	}

	public String getHidcmbempcategory() {
		return hidcmbempcategory;
	}

	public void setHidcmbempcategory(String hidcmbempcategory) {
		this.hidcmbempcategory = hidcmbempcategory;
	}

	public String getCmbdepartment() {
		return cmbdepartment;
	}

	public void setCmbdepartment(String cmbdepartment) {
		this.cmbdepartment = cmbdepartment;
	}

	public String getHidcmbdepartment() {
		return hidcmbdepartment;
	}

	public void setHidcmbdepartment(String hidcmbdepartment) {
		this.hidcmbdepartment = hidcmbdepartment;
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

	public int getTxtemployeedocno() {
		return txtemployeedocno;
	}

	public void setTxtemployeedocno(int txtemployeedocno) {
		this.txtemployeedocno = txtemployeedocno;
	}

	public String getTxtemployeeids() {
		return txtemployeeids;
	}

	public void setTxtemployeeids(String txtemployeeids) {
		this.txtemployeeids = txtemployeeids;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}



	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		
		if(mode.equalsIgnoreCase("A")){
			
			/*Opening Balance Grid Saving*/
			ArrayList<String> openingbalancearray= new ArrayList<String>();
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				openingbalancearray.add(temp);
			}
			/*Opening Balance Grid Saving Ends*/
			
			String[] employeeidsarray = getTxtemployeeids().split("::");
			
			int val=openingBalanceDAO.insert(getCmbbranch(),getTxtemployeeids(),employeeidsarray,openingbalancearray,session,request,mode);
			if(val>0.0){
				setDetail("Human Resource");
				setDetailname("Opening Balance");
				setHidcmbempcategory(getCmbempcategory());
				setHidcmbdepartment(getCmbdepartment());
				setTxtemployeeid(getTxtemployeeid());
				setTxtemployeename(getTxtemployeename());
				setTxtemployeedocno(getTxtemployeedocno());
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setDetail("Human Resource");
				setDetailname("Opening Balance");
				setHidcmbempcategory(getCmbempcategory());
				setHidcmbdepartment(getCmbdepartment());
				setTxtemployeeid(getTxtemployeeid());
				setTxtemployeename(getTxtemployeename());
				setTxtemployeedocno(getTxtemployeedocno());
				setTxtemployeeids(getTxtemployeeids());
				setGridlength(getGridlength());
				setMsg("Not Saved");
				return "fail";
			}	
		}
		return "fail";
	}
}


