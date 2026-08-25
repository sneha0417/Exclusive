package com.dashboard.humanresource.monthlypayrollposting;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsMonthlyPayrollPostingAction {
	
	ClsCommon commonDAO = new ClsCommon();
	ClsMonthlyPayrollPostingDAO monthlyPayrollPostingDAO=new ClsMonthlyPayrollPostingDAO();

	private String mode;
	private String msg;
	private String detail;
	private String detailname;
	private String cmbbranch;
	private String uptodate;
	private String hiduptodate;
	private String postingDate;
	private String hidpostingDate;
	private String txtremarks;
	private String txtselectedemployees;
	private String txtcategoryids;
	private double txtdrtotal;
	private double txtcrtotal;
	private String lbllastposted;
	
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

	public String getUptodate() {
		return uptodate;
	}

	public void setUptodate(String uptodate) {
		this.uptodate = uptodate;
	}

	public String getHiduptodate() {
		return hiduptodate;
	}

	public void setHiduptodate(String hiduptodate) {
		this.hiduptodate = hiduptodate;
	}

	public String getPostingDate() {
		return postingDate;
	}

	public void setPostingDate(String postingDate) {
		this.postingDate = postingDate;
	}

	public String getHidpostingDate() {
		return hidpostingDate;
	}

	public void setHidpostingDate(String hidpostingDate) {
		this.hidpostingDate = hidpostingDate;
	}

	public String getTxtremarks() {
		return txtremarks;
	}

	public void setTxtremarks(String txtremarks) {
		this.txtremarks = txtremarks;
	}

	public String getTxtselectedemployees() {
		return txtselectedemployees;
	}

	public void setTxtselectedemployees(String txtselectedemployees) {
		this.txtselectedemployees = txtselectedemployees;
	}

	public String getTxtcategoryids() {
		return txtcategoryids;
	}

	public void setTxtcategoryids(String txtcategoryids) {
		this.txtcategoryids = txtcategoryids;
	}

	public double getTxtdrtotal() {
		return txtdrtotal;
	}

	public void setTxtdrtotal(double txtdrtotal) {
		this.txtdrtotal = txtdrtotal;
	}

	public double getTxtcrtotal() {
		return txtcrtotal;
	}

	public void setTxtcrtotal(double txtcrtotal) {
		this.txtcrtotal = txtcrtotal;
	}

	public String getLbllastposted() {
		return lbllastposted;
	}

	public void setLbllastposted(String lbllastposted) {
		this.lbllastposted = lbllastposted;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	java.sql.Date dbUpToDate=null;
	java.sql.Date dbMonthlyPayrollPostingDate=null;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		
		dbUpToDate = commonDAO.changeStringtoSqlDate("01."+getUptodate());
		dbMonthlyPayrollPostingDate = commonDAO.changeStringtoSqlDate(getPostingDate());
		
		if(mode.equalsIgnoreCase("A")){
			
			/*Journal Grid Saving*/
			ArrayList<String> payrollpostingarray= new ArrayList<String>();
			
			for(int i=0;i<getGridlength();i++){
				String posttemp=requestParams.get("test"+i)[0];
				payrollpostingarray.add(posttemp);
			}
			/*Journal Grid Saving Ends*/
			
			int val=monthlyPayrollPostingDAO.insert(getCmbbranch(),dbMonthlyPayrollPostingDate,getTxtdrtotal(),getTxtremarks(),getTxtselectedemployees(),dbUpToDate,payrollpostingarray,session,request,mode);
			if(val>0.0){
				setDetail("Human Resource");
				setDetailname("Monthly Payroll Posting");
				setHiduptodate(dbUpToDate.toString());
				setHidpostingDate(dbMonthlyPayrollPostingDate.toString());
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setDetail("Human Resource");
				setDetailname("Monthly Payroll Posting");
				setHiduptodate(dbUpToDate.toString());
				setHidpostingDate(dbMonthlyPayrollPostingDate.toString());
				setMsg("Not Saved");
				return "fail";
			}	
		}
		return "fail";
	}
}


