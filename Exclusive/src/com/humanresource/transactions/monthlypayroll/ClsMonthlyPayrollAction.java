package com.humanresource.transactions.monthlypayroll;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsMonthlyPayrollAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();


	ClsMonthlyPayrollDAO monthlyPayrollDAO= new ClsMonthlyPayrollDAO();
	ClsMonthlyPayrollBean monthlyPayrollBean;

	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String payrollDate;
	private String hidpayrollDate;
	private int txtmonthlypayrolldocno;
	
	//Monthly Payroll Grid
	private int gridlength;
	
	//Print
	private String url;
	private String lblcompname;
	private String lblcompaddress;
	private String lblpobox;
	private String lblprintname;
	private String lblprintname1;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	private String lblservicetax;
	private String lblpan;
	private String lblcstno;
	
	private String lblgrosstotal;
	private String lbladditiontotal;
	private String lbldeductiontotal;
	private String lblloantotal;
	private String lblnetsalarytotal;
	
	private String lblpreparedby;
	private String lblpreparedon;
	private String lblpreparedat;
	private String lblverifiedby;
	private String lblapprovedby;
	
	//for hide
	private int txtheader;
	
	//Pay Slip
	private String lblemployeeid;
	private String lblemployeename;
	private String lblempdateofjoining;
	private String lblempdepartment;
	private String lblempdaysworked;
	private String lblempdesignation;
	
	private String lblearningbasic;
	private String lblearningbasicvalue;
	private String lblearningallowance0;
	private String lblearningallowance0value;
	private String lblearningallowance1;
	private String lblearningallowance1value;
	private String lblearningallowance2;
	private String lblearningallowance2value;
	private String lblearningallowance3;
	private String lblearningallowance3value;
	private String lblearningallowance4;
	private String lblearningallowance4value;
	private String lblearningallowance5;
	private String lblearningallowance5value;
	private String lblearningallowance6;
	private String lblearningallowance6value;
	private String lblearningallowance7;
	private String lblearningallowance7value;
	private String lblearningallowance8;
	private String lblearningallowance8value;
	private String lblearningallowance9;
	private String lblearningallowance9value;
	private String lblearningovertime;
	private String lblearningovertimevalue;
	private String lblearningaddition;
	private String lblearningadditionvalue;
	private String lbltotalearning;
	
	private String lbldeductionsleavedeductions;
	private String lbldeductionsleavedeductionsvalue;
	private String lbldeductionsloan;
	private String lbldeductionsloanvalue;
	private String lbldeductionsdeduction;
	private String lbldeductionsdeductionvalue;
	private String lbltotaldeduction;
	
	private String lblgrosssalary;
	private String lblgrossdeduction;
	private String lblnetsalary;
	
	//for hide
	private int lblallowancecount;
	
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

	public String getPayrollDate() {
		return payrollDate;
	}

	public void setPayrollDate(String payrollDate) {
		this.payrollDate = payrollDate;
	}

	public String getHidpayrollDate() {
		return hidpayrollDate;
	}

	public void setHidpayrollDate(String hidpayrollDate) {
		this.hidpayrollDate = hidpayrollDate;
	}

	public int getTxtmonthlypayrolldocno() {
		return txtmonthlypayrolldocno;
	}

	public void setTxtmonthlypayrolldocno(int txtmonthlypayrolldocno) {
		this.txtmonthlypayrolldocno = txtmonthlypayrolldocno;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getLblcompname() {
		return lblcompname;
	}

	public void setLblcompname(String lblcompname) {
		this.lblcompname = lblcompname;
	}

	public String getLblcompaddress() {
		return lblcompaddress;
	}

	public void setLblcompaddress(String lblcompaddress) {
		this.lblcompaddress = lblcompaddress;
	}

	public String getLblpobox() {
		return lblpobox;
	}

	public void setLblpobox(String lblpobox) {
		this.lblpobox = lblpobox;
	}

	public String getLblprintname() {
		return lblprintname;
	}

	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}

	public String getLblprintname1() {
		return lblprintname1;
	}

	public void setLblprintname1(String lblprintname1) {
		this.lblprintname1 = lblprintname1;
	}

	public String getLblcomptel() {
		return lblcomptel;
	}

	public void setLblcomptel(String lblcomptel) {
		this.lblcomptel = lblcomptel;
	}

	public String getLblcompfax() {
		return lblcompfax;
	}

	public void setLblcompfax(String lblcompfax) {
		this.lblcompfax = lblcompfax;
	}

	public String getLblbranch() {
		return lblbranch;
	}

	public void setLblbranch(String lblbranch) {
		this.lblbranch = lblbranch;
	}

	public String getLbllocation() {
		return lbllocation;
	}

	public void setLbllocation(String lbllocation) {
		this.lbllocation = lbllocation;
	}

	public String getLblservicetax() {
		return lblservicetax;
	}

	public void setLblservicetax(String lblservicetax) {
		this.lblservicetax = lblservicetax;
	}

	public String getLblpan() {
		return lblpan;
	}

	public void setLblpan(String lblpan) {
		this.lblpan = lblpan;
	}

	public String getLblcstno() {
		return lblcstno;
	}

	public void setLblcstno(String lblcstno) {
		this.lblcstno = lblcstno;
	}

	public String getLblgrosstotal() {
		return lblgrosstotal;
	}

	public void setLblgrosstotal(String lblgrosstotal) {
		this.lblgrosstotal = lblgrosstotal;
	}

	public String getLbladditiontotal() {
		return lbladditiontotal;
	}

	public void setLbladditiontotal(String lbladditiontotal) {
		this.lbladditiontotal = lbladditiontotal;
	}

	public String getLbldeductiontotal() {
		return lbldeductiontotal;
	}

	public void setLbldeductiontotal(String lbldeductiontotal) {
		this.lbldeductiontotal = lbldeductiontotal;
	}

	public String getLblloantotal() {
		return lblloantotal;
	}

	public void setLblloantotal(String lblloantotal) {
		this.lblloantotal = lblloantotal;
	}

	public String getLblnetsalarytotal() {
		return lblnetsalarytotal;
	}

	public void setLblnetsalarytotal(String lblnetsalarytotal) {
		this.lblnetsalarytotal = lblnetsalarytotal;
	}

	public String getLblpreparedby() {
		return lblpreparedby;
	}

	public void setLblpreparedby(String lblpreparedby) {
		this.lblpreparedby = lblpreparedby;
	}

	public String getLblpreparedon() {
		return lblpreparedon;
	}

	public void setLblpreparedon(String lblpreparedon) {
		this.lblpreparedon = lblpreparedon;
	}

	public String getLblpreparedat() {
		return lblpreparedat;
	}

	public void setLblpreparedat(String lblpreparedat) {
		this.lblpreparedat = lblpreparedat;
	}

	public String getLblverifiedby() {
		return lblverifiedby;
	}

	public void setLblverifiedby(String lblverifiedby) {
		this.lblverifiedby = lblverifiedby;
	}

	public String getLblapprovedby() {
		return lblapprovedby;
	}

	public void setLblapprovedby(String lblapprovedby) {
		this.lblapprovedby = lblapprovedby;
	}
	
	public int getTxtheader() {
		return txtheader;
	}

	public void setTxtheader(int txtheader) {
		this.txtheader = txtheader;
	}

	public String getLblemployeeid() {
		return lblemployeeid;
	}

	public void setLblemployeeid(String lblemployeeid) {
		this.lblemployeeid = lblemployeeid;
	}

	public String getLblemployeename() {
		return lblemployeename;
	}

	public void setLblemployeename(String lblemployeename) {
		this.lblemployeename = lblemployeename;
	}

	public String getLblempdateofjoining() {
		return lblempdateofjoining;
	}

	public void setLblempdateofjoining(String lblempdateofjoining) {
		this.lblempdateofjoining = lblempdateofjoining;
	}

	public String getLblempdepartment() {
		return lblempdepartment;
	}

	public void setLblempdepartment(String lblempdepartment) {
		this.lblempdepartment = lblempdepartment;
	}

	public String getLblempdaysworked() {
		return lblempdaysworked;
	}

	public void setLblempdaysworked(String lblempdaysworked) {
		this.lblempdaysworked = lblempdaysworked;
	}

	public String getLblempdesignation() {
		return lblempdesignation;
	}

	public void setLblempdesignation(String lblempdesignation) {
		this.lblempdesignation = lblempdesignation;
	}

	public String getLblearningbasic() {
		return lblearningbasic;
	}

	public void setLblearningbasic(String lblearningbasic) {
		this.lblearningbasic = lblearningbasic;
	}

	public String getLblearningbasicvalue() {
		return lblearningbasicvalue;
	}

	public void setLblearningbasicvalue(String lblearningbasicvalue) {
		this.lblearningbasicvalue = lblearningbasicvalue;
	}

	public String getLblearningallowance0() {
		return lblearningallowance0;
	}

	public void setLblearningallowance0(String lblearningallowance0) {
		this.lblearningallowance0 = lblearningallowance0;
	}

	public String getLblearningallowance0value() {
		return lblearningallowance0value;
	}

	public void setLblearningallowance0value(String lblearningallowance0value) {
		this.lblearningallowance0value = lblearningallowance0value;
	}

	public String getLblearningallowance1() {
		return lblearningallowance1;
	}

	public void setLblearningallowance1(String lblearningallowance1) {
		this.lblearningallowance1 = lblearningallowance1;
	}

	public String getLblearningallowance1value() {
		return lblearningallowance1value;
	}

	public void setLblearningallowance1value(String lblearningallowance1value) {
		this.lblearningallowance1value = lblearningallowance1value;
	}

	public String getLblearningallowance2() {
		return lblearningallowance2;
	}

	public void setLblearningallowance2(String lblearningallowance2) {
		this.lblearningallowance2 = lblearningallowance2;
	}

	public String getLblearningallowance2value() {
		return lblearningallowance2value;
	}

	public void setLblearningallowance2value(String lblearningallowance2value) {
		this.lblearningallowance2value = lblearningallowance2value;
	}

	public String getLblearningallowance3() {
		return lblearningallowance3;
	}

	public void setLblearningallowance3(String lblearningallowance3) {
		this.lblearningallowance3 = lblearningallowance3;
	}

	public String getLblearningallowance3value() {
		return lblearningallowance3value;
	}

	public void setLblearningallowance3value(String lblearningallowance3value) {
		this.lblearningallowance3value = lblearningallowance3value;
	}

	public String getLblearningallowance4() {
		return lblearningallowance4;
	}

	public void setLblearningallowance4(String lblearningallowance4) {
		this.lblearningallowance4 = lblearningallowance4;
	}

	public String getLblearningallowance4value() {
		return lblearningallowance4value;
	}

	public void setLblearningallowance4value(String lblearningallowance4value) {
		this.lblearningallowance4value = lblearningallowance4value;
	}

	public String getLblearningallowance5() {
		return lblearningallowance5;
	}

	public void setLblearningallowance5(String lblearningallowance5) {
		this.lblearningallowance5 = lblearningallowance5;
	}

	public String getLblearningallowance5value() {
		return lblearningallowance5value;
	}

	public void setLblearningallowance5value(String lblearningallowance5value) {
		this.lblearningallowance5value = lblearningallowance5value;
	}

	public String getLblearningallowance6() {
		return lblearningallowance6;
	}

	public void setLblearningallowance6(String lblearningallowance6) {
		this.lblearningallowance6 = lblearningallowance6;
	}

	public String getLblearningallowance6value() {
		return lblearningallowance6value;
	}

	public void setLblearningallowance6value(String lblearningallowance6value) {
		this.lblearningallowance6value = lblearningallowance6value;
	}

	public String getLblearningallowance7() {
		return lblearningallowance7;
	}

	public void setLblearningallowance7(String lblearningallowance7) {
		this.lblearningallowance7 = lblearningallowance7;
	}

	public String getLblearningallowance7value() {
		return lblearningallowance7value;
	}

	public void setLblearningallowance7value(String lblearningallowance7value) {
		this.lblearningallowance7value = lblearningallowance7value;
	}

	public String getLblearningallowance8() {
		return lblearningallowance8;
	}

	public void setLblearningallowance8(String lblearningallowance8) {
		this.lblearningallowance8 = lblearningallowance8;
	}

	public String getLblearningallowance8value() {
		return lblearningallowance8value;
	}

	public void setLblearningallowance8value(String lblearningallowance8value) {
		this.lblearningallowance8value = lblearningallowance8value;
	}

	public String getLblearningallowance9() {
		return lblearningallowance9;
	}

	public void setLblearningallowance9(String lblearningallowance9) {
		this.lblearningallowance9 = lblearningallowance9;
	}

	public String getLblearningallowance9value() {
		return lblearningallowance9value;
	}

	public void setLblearningallowance9value(String lblearningallowance9value) {
		this.lblearningallowance9value = lblearningallowance9value;
	}

	public String getLblearningovertime() {
		return lblearningovertime;
	}

	public void setLblearningovertime(String lblearningovertime) {
		this.lblearningovertime = lblearningovertime;
	}

	public String getLblearningovertimevalue() {
		return lblearningovertimevalue;
	}

	public void setLblearningovertimevalue(String lblearningovertimevalue) {
		this.lblearningovertimevalue = lblearningovertimevalue;
	}

	public String getLblearningaddition() {
		return lblearningaddition;
	}

	public void setLblearningaddition(String lblearningaddition) {
		this.lblearningaddition = lblearningaddition;
	}

	public String getLblearningadditionvalue() {
		return lblearningadditionvalue;
	}

	public void setLblearningadditionvalue(String lblearningadditionvalue) {
		this.lblearningadditionvalue = lblearningadditionvalue;
	}

	public String getLbltotalearning() {
		return lbltotalearning;
	}

	public void setLbltotalearning(String lbltotalearning) {
		this.lbltotalearning = lbltotalearning;
	}

	public String getLbldeductionsleavedeductions() {
		return lbldeductionsleavedeductions;
	}

	public void setLbldeductionsleavedeductions(String lbldeductionsleavedeductions) {
		this.lbldeductionsleavedeductions = lbldeductionsleavedeductions;
	}

	public String getLbldeductionsleavedeductionsvalue() {
		return lbldeductionsleavedeductionsvalue;
	}

	public void setLbldeductionsleavedeductionsvalue(
			String lbldeductionsleavedeductionsvalue) {
		this.lbldeductionsleavedeductionsvalue = lbldeductionsleavedeductionsvalue;
	}

	public String getLbldeductionsloan() {
		return lbldeductionsloan;
	}

	public void setLbldeductionsloan(String lbldeductionsloan) {
		this.lbldeductionsloan = lbldeductionsloan;
	}

	public String getLbldeductionsloanvalue() {
		return lbldeductionsloanvalue;
	}

	public void setLbldeductionsloanvalue(String lbldeductionsloanvalue) {
		this.lbldeductionsloanvalue = lbldeductionsloanvalue;
	}

	public String getLbldeductionsdeduction() {
		return lbldeductionsdeduction;
	}

	public void setLbldeductionsdeduction(String lbldeductionsdeduction) {
		this.lbldeductionsdeduction = lbldeductionsdeduction;
	}

	public String getLbldeductionsdeductionvalue() {
		return lbldeductionsdeductionvalue;
	}

	public void setLbldeductionsdeductionvalue(String lbldeductionsdeductionvalue) {
		this.lbldeductionsdeductionvalue = lbldeductionsdeductionvalue;
	}

	public String getLbltotaldeduction() {
		return lbltotaldeduction;
	}

	public void setLbltotaldeduction(String lbltotaldeduction) {
		this.lbltotaldeduction = lbltotaldeduction;
	}

	public String getLblgrosssalary() {
		return lblgrosssalary;
	}

	public void setLblgrosssalary(String lblgrosssalary) {
		this.lblgrosssalary = lblgrosssalary;
	}

	public String getLblgrossdeduction() {
		return lblgrossdeduction;
	}

	public void setLblgrossdeduction(String lblgrossdeduction) {
		this.lblgrossdeduction = lblgrossdeduction;
	}

	public String getLblnetsalary() {
		return lblnetsalary;
	}

	public void setLblnetsalary(String lblnetsalary) {
		this.lblnetsalary = lblnetsalary;
	}

	public int getLblallowancecount() {
		return lblallowancecount;
	}

	public void setLblallowancecount(int lblallowancecount) {
		this.lblallowancecount = lblallowancecount;
	}

	java.sql.Date monthlyPayrollDate=null;
	
	public ClsMonthlyPayrollAction(){}
	
	public ClsMonthlyPayrollAction(String lblcompname, String lblcompaddress, String lblcomptel,String lblcompfax,String lblbranch,String lbllocation,String lblprintname,
			String lblemployeeid, String lblemployeename, String lblempdateofjoining, String lblempdepartment, String lblempdaysworked, String lblempdesignation, 
			String lblearningbasic, String lblearningbasicvalue, String lblearningallowance0,String lblearningallowance0value,String lblearningallowance1,String lblearningallowance1value,
			String lblearningallowance2, String lblearningallowance2value, String lblearningallowance3,String lblearningallowance3value,String lblearningallowance4,
			String lblearningallowance4value,String lblearningallowance5,String lblearningallowance5value,String lblearningallowance6,String lblearningallowance6value,
			String lblearningallowance7,String lblearningallowance7value,String lblearningallowance8,String lblearningallowance8value,String lblearningallowance9,
			String lblearningallowance9value,String lblearningovertime,String lblearningovertimevalue,String lblearningaddition,String lblearningadditionvalue,String lbltotalearning,
			String lbldeductionsleavedeductions,String lbldeductionsleavedeductionsvalue,String lbldeductionsloan,String lbldeductionsloanvalue,String lbldeductionsdeduction,
			String lbldeductionsdeductionvalue,String lbltotaldeduction,String lblgrosssalary,String lblgrossdeduction, String lblnetsalary, int lblallowancecount) {
		    
		    this.lblcompname = lblcompname;
		    this.lblcompaddress = lblcompaddress;
		    this.lblcomptel = lblcomptel;
		    this.lblcompfax = lblcompfax;
		    this.lblbranch=lblbranch;
		    this.lbllocation=lbllocation;
		    this.lblprintname=lblprintname;
		    this.lblemployeeid = lblemployeeid;
		    this.lblemployeename = lblemployeename;
		    this.lblempdateofjoining = lblempdateofjoining;
		    this.lblempdepartment = lblempdepartment;
		    this.lblempdaysworked = lblempdaysworked;
		    this.lblempdesignation = lblempdesignation;
		    this.lblearningbasic = lblearningbasic;
		    this.lblearningbasicvalue = lblearningbasicvalue;
		    this.lblearningallowance0 = lblearningallowance0;
		    this.lblearningallowance0value = lblearningallowance0value;
		    this.lblearningallowance1 = lblearningallowance1;
		    this.lblearningallowance1value = lblearningallowance1value;
		    this.lblearningallowance2 = lblearningallowance2;
		    this.lblearningallowance2value = lblearningallowance2value;
		    this.lblearningallowance3 = lblearningallowance3;
		    this.lblearningallowance3value = lblearningallowance3value;
		    this.lblearningallowance4 = lblearningallowance4;
		    this.lblearningallowance4value = lblearningallowance4value;
		    this.lblearningallowance5 = lblearningallowance5;
		    this.lblearningallowance5value = lblearningallowance5value;
		    this.lblearningallowance6 = lblearningallowance6;
		    this.lblearningallowance6value = lblearningallowance6value;
		    this.lblearningallowance7 = lblearningallowance7;
		    this.lblearningallowance7value = lblearningallowance7value;
		    this.lblearningallowance8 = lblearningallowance8;
		    this.lblearningallowance8value = lblearningallowance8value;
		    this.lblearningallowance9 = lblearningallowance9;
		    this.lblearningallowance9value = lblearningallowance9value;
		    this.lblearningovertime = lblearningovertime;
		    this.lblearningovertimevalue = lblearningovertimevalue;
		    this.lblearningaddition = lblearningaddition;
		    this.lblearningadditionvalue = lblearningadditionvalue;
		    this.lbltotalearning = lbltotalearning;
		    this.lbldeductionsleavedeductions = lbldeductionsleavedeductions;
		    this.lbldeductionsleavedeductionsvalue = lbldeductionsleavedeductionsvalue;
		    this.lbldeductionsloan = lbldeductionsloan;
		    this.lbldeductionsloanvalue = lbldeductionsloanvalue;
		    this.lbldeductionsdeduction = lbldeductionsdeduction;
		    this.lbldeductionsdeductionvalue = lbldeductionsdeductionvalue;
		    this.lbltotaldeduction = lbltotaldeduction;
		    this.lblgrosssalary = lblgrosssalary;
		    this.lblgrossdeduction = lblgrossdeduction;
		    this.lblnetsalary = lblnetsalary;
		    this.lblallowancecount = lblallowancecount;
	}
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		monthlyPayrollDate = (getPayrollDate()==null || getPayrollDate().trim().equalsIgnoreCase(""))?null:ClsCommon.changeStringtoSqlDate(getPayrollDate());
		
		if(mode.equalsIgnoreCase("A")){
			   System.out.println("=============in add==============");
			/*Monthly Payroll Grid Saving*/            
			ArrayList<String> monthlypayrollarray= new ArrayList<String>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				monthlypayrollarray.add(temp);
			}
			/*Monthly Payroll Grid Saving Ends*/
			
			
						int val=monthlyPayrollDAO.insert(getFormdetailcode(),monthlyPayrollDate,monthlypayrollarray,session,request,mode);
						if(val>0.0){
							
							setTxtmonthlypayrolldocno(val);
							setData();
							
							setMsg("Successfully Saved");
							return "success";
						}
						else{
							setMsg("Not Saved");
							return "fail";
						}	
		} else if(mode.equalsIgnoreCase("E")){
           System.out.println("=============in eeee ==============");
			/*Monthly Payroll Grid Saving*/
			ArrayList<String> monthlypayrollarray= new ArrayList<String>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				monthlypayrollarray.add(temp);
			}
			/*Monthly Payroll Grid Saving Ends*/
			
			boolean Status=monthlyPayrollDAO.edit(getTxtmonthlypayrolldocno(),getFormdetailcode(),monthlyPayrollDate,monthlypayrollarray,session,request,mode);
			if(Status){

				setTxtmonthlypayrolldocno(getTxtmonthlypayrolldocno());
				setData();
				
				setMsg("Updated Successfully");
			    return "success";
		} else{
			setTxtmonthlypayrolldocno(getTxtmonthlypayrolldocno());
			setData();
			setMsg("Not Updated");
			return "fail";
		}
	
	  } else if(mode.equalsIgnoreCase("EDIT")){
		  System.out.println("=============in edit ==============");
		  /*Monthly Payroll Grid Saving*/
			ArrayList<String> monthlypayrollarray= new ArrayList<String>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				monthlypayrollarray.add(temp);
			}
			/*Monthly Payroll Grid Saving Ends*/
			
			boolean Status=monthlyPayrollDAO.confirmPayroll(getTxtmonthlypayrolldocno(),getFormdetailcode(),monthlyPayrollDate,monthlypayrollarray,session,request,mode);
			if(Status){

				setTxtmonthlypayrolldocno(getTxtmonthlypayrolldocno());
				setData();
				
				setMsg("Updated Successfully");
			    return "success";
		} else{
			setTxtmonthlypayrolldocno(getTxtmonthlypayrolldocno());
			setData();
			setMsg("Not Updated");
			return "fail";
		}

	  /*} else if(mode.equalsIgnoreCase("D")){
			
			boolean Status=monthlyPayrollDAO.delete(getTxtmonthlypayrolldocno(),getFormdetailcode(),session,mode);
			if(Status){
				
				setTxtmonthlypayrolldocno(getTxtmonthlypayrolldocno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setData();
				setMsg("Not Deleted");
				return "fail";
			   }*/
		} else if(mode.equalsIgnoreCase("View")){
	
			monthlyPayrollBean=monthlyPayrollDAO.getViewDetails(session,getTxtmonthlypayrolldocno());
			
			setPayrollDate(monthlyPayrollBean.getPayrollDate());
			setFormdetailcode(monthlyPayrollBean.getFormdetailcode());
			
			return "success";
		}
		return "fail";
	}
	
	public String printAction() throws ParseException, SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String docno=request.getParameter("docno");
		int header=Integer.parseInt(request.getParameter("header"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		monthlyPayrollBean=monthlyPayrollDAO.getPrint(request,docno,branch,header);
		
		setUrl(ClsCommon.getPrintPath("HMSP"));
		setLblcompname(monthlyPayrollBean.getLblcompname());
		setLblcompaddress(monthlyPayrollBean.getLblcompaddress());
		setLblpobox(monthlyPayrollBean.getLblpobox());
		setLblprintname(monthlyPayrollBean.getLblprintname());
		setLblprintname1(monthlyPayrollBean.getLblprintname1());
		setLblcomptel(monthlyPayrollBean.getLblcomptel());
		setLblcompfax(monthlyPayrollBean.getLblcompfax());
		setLblbranch(monthlyPayrollBean.getLblbranch());
		setLbllocation(monthlyPayrollBean.getLbllocation());
		setLblservicetax(monthlyPayrollBean.getLblservicetax());
		setLblpan(monthlyPayrollBean.getLblpan());
		setLblcstno(monthlyPayrollBean.getLblcstno());
		setLblgrosstotal(monthlyPayrollBean.getLblgrosstotal());
		setLbladditiontotal(monthlyPayrollBean.getLbladditiontotal());
		setLbldeductiontotal(monthlyPayrollBean.getLbldeductiontotal());
		setLblloantotal(monthlyPayrollBean.getLblloantotal());
		setLblnetsalarytotal(monthlyPayrollBean.getLblnetsalarytotal());
		setLblpreparedby(monthlyPayrollBean.getLblpreparedby());
		setLblpreparedon(monthlyPayrollBean.getLblpreparedon());
		setLblpreparedat(monthlyPayrollBean.getLblpreparedat());
		setLblverifiedby(monthlyPayrollBean.getLblverifiedby());
		setLblapprovedby(monthlyPayrollBean.getLblapprovedby());
		
		// for hide
		setTxtheader(monthlyPayrollBean.getTxtheader());
		
		return "print";
	}
	
	public String printPaySlipAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String employeedocno=request.getParameter("employeedocno");
		String date=request.getParameter("date");
		int allowancecount=Integer.parseInt(request.getParameter("allowancecount"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		String docno=request.getParameter("docno");
		monthlyPayrollBean=monthlyPayrollDAO.getPaySlipPrint(employeedocno,date,branch,allowancecount,docno);
		setLblcompname(monthlyPayrollBean.getLblcompname());
		setLblcompaddress(monthlyPayrollBean.getLblcompaddress());
		setLblcomptel(monthlyPayrollBean.getLblcomptel());
		setLblcompfax(monthlyPayrollBean.getLblcompfax());
		setLblbranch(monthlyPayrollBean.getLblbranch());
		setLbllocation(monthlyPayrollBean.getLbllocation());
		setLblprintname(monthlyPayrollBean.getLblprintname());
		setLblemployeeid(monthlyPayrollBean.getLblemployeeid());
		setLblemployeename(monthlyPayrollBean.getLblemployeename());
		setLblempdateofjoining(monthlyPayrollBean.getLblempdateofjoining());
		setLblempdepartment(monthlyPayrollBean.getLblempdepartment());
		setLblempdaysworked(monthlyPayrollBean.getLblempdaysworked());
		setLblempdesignation(monthlyPayrollBean.getLblempdesignation());
		
		setLblearningbasic(monthlyPayrollBean.getLblearningbasic());
		setLblearningbasicvalue(monthlyPayrollBean.getLblearningbasicvalue());
		setLblearningallowance0(monthlyPayrollBean.getLblearningallowance0());
		setLblearningallowance0value(monthlyPayrollBean.getLblearningallowance0value());
		setLblearningallowance1(monthlyPayrollBean.getLblearningallowance1());
		setLblearningallowance1value(monthlyPayrollBean.getLblearningallowance1value());
		setLblearningallowance2(monthlyPayrollBean.getLblearningallowance2());
		setLblearningallowance2value(monthlyPayrollBean.getLblearningallowance2value());
		setLblearningallowance3(monthlyPayrollBean.getLblearningallowance3());
		setLblearningallowance3value(monthlyPayrollBean.getLblearningallowance3value());
		setLblearningallowance4(monthlyPayrollBean.getLblearningallowance4());
		setLblearningallowance4value(monthlyPayrollBean.getLblearningallowance4value());
		setLblearningallowance5(monthlyPayrollBean.getLblearningallowance5());
		setLblearningallowance5value(monthlyPayrollBean.getLblearningallowance5value());
		setLblearningallowance6(monthlyPayrollBean.getLblearningallowance6());
		setLblearningallowance6value(monthlyPayrollBean.getLblearningallowance6value());
		setLblearningallowance7(monthlyPayrollBean.getLblearningallowance7());
		setLblearningallowance7value(monthlyPayrollBean.getLblearningallowance7value());
		setLblearningallowance8(monthlyPayrollBean.getLblearningallowance8());
		setLblearningallowance8value(monthlyPayrollBean.getLblearningallowance8value());
		setLblearningallowance9(monthlyPayrollBean.getLblearningallowance9());
		setLblearningallowance9value(monthlyPayrollBean.getLblearningallowance9value());
		setLblearningovertime(monthlyPayrollBean.getLblearningovertime());
		setLblearningovertimevalue(monthlyPayrollBean.getLblearningovertimevalue());
		setLblearningaddition(monthlyPayrollBean.getLblearningaddition());
		setLblearningadditionvalue(monthlyPayrollBean.getLblearningadditionvalue());
		setLbltotalearning(monthlyPayrollBean.getLbltotalearning());
		
		setLbldeductionsleavedeductions(monthlyPayrollBean.getLbldeductionsleavedeductions());
		setLbldeductionsleavedeductionsvalue(monthlyPayrollBean.getLbldeductionsleavedeductionsvalue());
		setLbldeductionsloan(monthlyPayrollBean.getLbldeductionsloan());
		setLbldeductionsloanvalue(monthlyPayrollBean.getLbldeductionsloanvalue());
		setLbldeductionsdeduction(monthlyPayrollBean.getLbldeductionsdeduction());
		setLbldeductionsdeductionvalue(monthlyPayrollBean.getLbldeductionsdeductionvalue());
		setLbltotaldeduction(monthlyPayrollBean.getLbltotaldeduction());
		
		setLblgrosssalary(monthlyPayrollBean.getLblgrosssalary());
		setLblgrossdeduction(monthlyPayrollBean.getLblgrossdeduction());
		setLblnetsalary(monthlyPayrollBean.getLblnetsalary());
		setLblallowancecount(monthlyPayrollBean.getLblallowancecount());
		
		return "print";
	}
	public String printAction2() throws ParseException, SQLException{         
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String docno=request.getParameter("docno");
		String mode=request.getParameter("mode");
		String date=request.getParameter("date");
		String category=request.getParameter("category");
		String empid=request.getParameter("empid");
		String check=request.getParameter("check");
		docno="0";    
		int header=Integer.parseInt(request.getParameter("header"));
		int branch=Integer.parseInt(request.getParameter("branch")); 
		monthlyPayrollBean=monthlyPayrollDAO.getPrint2(request,docno,branch,header,mode,date,category,empid,check);                                                        
		
		setUrl(ClsCommon.getPrintPath("HMSP"));
		setLblcompname(monthlyPayrollBean.getLblcompname());
		setLblcompaddress(monthlyPayrollBean.getLblcompaddress());
		setLblpobox(monthlyPayrollBean.getLblpobox());
		setLblprintname(monthlyPayrollBean.getLblprintname());
		setLblprintname1(monthlyPayrollBean.getLblprintname1());
		setLblcomptel(monthlyPayrollBean.getLblcomptel());
		setLblcompfax(monthlyPayrollBean.getLblcompfax());
		setLblbranch(monthlyPayrollBean.getLblbranch());
		setLbllocation(monthlyPayrollBean.getLbllocation());
		setLblservicetax(monthlyPayrollBean.getLblservicetax());
		setLblpan(monthlyPayrollBean.getLblpan());
		setLblcstno(monthlyPayrollBean.getLblcstno());
		setLblgrosstotal(monthlyPayrollBean.getLblgrosstotal());
		setLbladditiontotal(monthlyPayrollBean.getLbladditiontotal());
		setLbldeductiontotal(monthlyPayrollBean.getLbldeductiontotal());
		setLblloantotal(monthlyPayrollBean.getLblloantotal());
		setLblnetsalarytotal(monthlyPayrollBean.getLblnetsalarytotal());
		setLblpreparedby(monthlyPayrollBean.getLblpreparedby());
		setLblpreparedon(monthlyPayrollBean.getLblpreparedon());
		setLblpreparedat(monthlyPayrollBean.getLblpreparedat());
		setLblverifiedby(monthlyPayrollBean.getLblverifiedby());
		setLblapprovedby(monthlyPayrollBean.getLblapprovedby());
		
		// for hide
		setTxtheader(monthlyPayrollBean.getTxtheader());
		
		return "print";
	}
	/*Multiple Print ENDS*/

	public void setData() {

    	    if(monthlyPayrollDate != null){
    	    setHidpayrollDate(monthlyPayrollDate.toString());
    	    }
			setFormdetailcode(getFormdetailcode());
		}
}

