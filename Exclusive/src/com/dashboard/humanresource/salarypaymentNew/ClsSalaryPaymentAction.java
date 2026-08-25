package com.dashboard.humanresource.salarypaymentNew;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
  
public class ClsSalaryPaymentAction {
	
	ClsCommon ClsCommon=new ClsCommon();
	ClsSalaryPaymentDAO salaryPaymentDAO=new ClsSalaryPaymentDAO();

	private String mode;
	private String msg;
	private String detail;
	private String detailname;
	private String cmbbranch;
	private String cmbyear;
	private String hidcmbyear;
	private String cmbmonth;
	private String hidcmbmonth;
	private String cmbempagentid;
	private String txtaccount;
	private String txtaccountdocno;
	private String txtaccountname;
	private String date;
	private String hiddate;
	private double txtdrtotal;
	private double txtcrtotal;
	private String txtselectedemployees;
	
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

	public String getCmbempagentid() {
		return cmbempagentid;
	}

	public void setCmbempagentid(String cmbempagentid) {
		this.cmbempagentid = cmbempagentid;
	}

	public String getTxtaccount() {
		return txtaccount;
	}

	public void setTxtaccount(String txtaccount) {
		this.txtaccount = txtaccount;
	}

	public String getTxtaccountdocno() {
		return txtaccountdocno;
	}

	public void setTxtaccountdocno(String txtaccountdocno) {
		this.txtaccountdocno = txtaccountdocno;
	}

	public String getTxtaccountname() {
		return txtaccountname;
	}

	public void setTxtaccountname(String txtaccountname) {
		this.txtaccountname = txtaccountname;
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

	public String getTxtselectedemployees() {
		return txtselectedemployees;
	}

	public void setTxtselectedemployees(String txtselectedemployees) {
		this.txtselectedemployees = txtselectedemployees;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	java.sql.Date dbPaymentDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		
		dbPaymentDate = ClsCommon.changeStringtoSqlDate(getDate());
		
		if(mode.equalsIgnoreCase("A")){
			
			/*Journal Grid Saving*/
			ArrayList<String> paymentarray= new ArrayList<String>();
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				paymentarray.add(temp);
			}
			/*Journal Grid Saving Ends*/
			
			String[] employeearray = getTxtselectedemployees().split(",");
			
			int val=salaryPaymentDAO.insert(getCmbbranch(),getCmbyear(),getCmbmonth(),getTxtaccountdocno(),getTxtdrtotal(),getTxtcrtotal(),getTxtselectedemployees(),dbPaymentDate,employeearray,paymentarray,session,request,mode);
			if(val>0.0){
				setDetail("Human Resource");
				setDetailname("Salary Payment");
				setHidcmbyear(getCmbyear());
				setHidcmbmonth(getCmbmonth());
				setMsg("JV No. "+val+" is Successfully Saved");
				return "success";
			}
			else{
				setDetail("Human Resource");
				setDetailname("Salary Payment");
				setHidcmbyear(getCmbyear());
				setHidcmbmonth(getCmbmonth());
				setTxtaccount(getTxtaccount());
				setTxtaccountdocno(getTxtaccountdocno());
				setTxtaccountname(getTxtaccountname());
				setMsg("Not Saved");
				return "fail";
			}	
		}
		return "fail";
	}
}


