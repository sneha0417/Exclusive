package com.finance.transactions.budget;

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
public class ClsBudgetAction extends ActionSupport{

	ClsCommon commonDAO= new ClsCommon();
	ClsBudgetDAO budgetDAO= new ClsBudgetDAO();
	ClsBudgetBean budgetBean;

	private int txtbudgetdocno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String budgetDate;
	private String hidbudgetDate;
	private String assessmentYearDate;
	private String hidassessmentYearDate;
	private String txtdescription;
	private double txttotalincome;
	private double txttotalexpenditure;
	
	private int incomegridlength;
	private int expendituregridlength;
	private String incomegridcolumn;
	private String expendituregridcolumn;
	
	private String maindate;
	private String hidmaindate;
	
	private String url;
	
	//Print
	private String lblmainname;
	private String lblcompname;
	private String lblcompaddress;
	private String lblpobox;
	private String lblprintname;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	private String lblservicetax;
	private String lblpan;
	private String lblcstno;
	
	private String lblassessmentyear;
	private String lblvoucherno;
	private String lbldescription;
	private String lbldate;
	private String lbltotincome;
	private String lbltotexpenditure;
	
	private String lblincomemonth1;
	private String lblincomemonth2;
	private String lblincomemonth3;
	private String lblincomemonth4;
	private String lblincomemonth5;
	private String lblincomemonth6;
	private String lblincomemonth7;
	private String lblincomemonth8;
	private String lblincomemonth9;
	private String lblincomemonth10;
	private String lblincomemonth11;
	private String lblincomemonth12;
	private String lblexpendituremonth1;
	private String lblexpendituremonth2;
	private String lblexpendituremonth3;
	private String lblexpendituremonth4;
	private String lblexpendituremonth5;
	private String lblexpendituremonth6;
	private String lblexpendituremonth7;
	private String lblexpendituremonth8;
	private String lblexpendituremonth9;
	private String lblexpendituremonth10;
	private String lblexpendituremonth11;
	private String lblexpendituremonth12;
	private String lblincometotal;
	private String lblexpendituretotal;
	private String lblpreparedby;
	private String lblpreparedon;
	private String lblpreparedat;

	//for hide
	private int firstarray;
	private int secarray;
	private int txtheader;
	
	public int getTxtbudgetdocno() {
		return txtbudgetdocno;
	}

	public void setTxtbudgetdocno(int txtbudgetdocno) {
		this.txtbudgetdocno = txtbudgetdocno;
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

	public String getBudgetDate() {
		return budgetDate;
	}

	public void setBudgetDate(String budgetDate) {
		this.budgetDate = budgetDate;
	}

	public String getHidbudgetDate() {
		return hidbudgetDate;
	}

	public void setHidbudgetDate(String hidbudgetDate) {
		this.hidbudgetDate = hidbudgetDate;
	}

	public String getAssessmentYearDate() {
		return assessmentYearDate;
	}

	public void setAssessmentYearDate(String assessmentYearDate) {
		this.assessmentYearDate = assessmentYearDate;
	}

	public String getHidassessmentYearDate() {
		return hidassessmentYearDate;
	}

	public void setHidassessmentYearDate(String hidassessmentYearDate) {
		this.hidassessmentYearDate = hidassessmentYearDate;
	}

	public String getTxtdescription() {
		return txtdescription;
	}

	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}

	public double getTxttotalincome() {
		return txttotalincome;
	}

	public void setTxttotalincome(double txttotalincome) {
		this.txttotalincome = txttotalincome;
	}

	public double getTxttotalexpenditure() {
		return txttotalexpenditure;
	}

	public void setTxttotalexpenditure(double txttotalexpenditure) {
		this.txttotalexpenditure = txttotalexpenditure;
	}

	public int getIncomegridlength() {
		return incomegridlength;
	}

	public void setIncomegridlength(int incomegridlength) {
		this.incomegridlength = incomegridlength;
	}

	public int getExpendituregridlength() {
		return expendituregridlength;
	}

	public void setExpendituregridlength(int expendituregridlength) {
		this.expendituregridlength = expendituregridlength;
	}

	public String getIncomegridcolumn() {
		return incomegridcolumn;
	}

	public void setIncomegridcolumn(String incomegridcolumn) {
		this.incomegridcolumn = incomegridcolumn;
	}

	public String getExpendituregridcolumn() {
		return expendituregridcolumn;
	}

	public void setExpendituregridcolumn(String expendituregridcolumn) {
		this.expendituregridcolumn = expendituregridcolumn;
	}

	public String getMaindate() {
		return maindate;
	}

	public void setMaindate(String maindate) {
		this.maindate = maindate;
	}

	public String getHidmaindate() {
		return hidmaindate;
	}

	public void setHidmaindate(String hidmaindate) {
		this.hidmaindate = hidmaindate;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getLblmainname() {
		return lblmainname;
	}

	public void setLblmainname(String lblmainname) {
		this.lblmainname = lblmainname;
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

	public String getLblassessmentyear() {
		return lblassessmentyear;
	}

	public void setLblassessmentyear(String lblassessmentyear) {
		this.lblassessmentyear = lblassessmentyear;
	}

	public String getLblvoucherno() {
		return lblvoucherno;
	}

	public void setLblvoucherno(String lblvoucherno) {
		this.lblvoucherno = lblvoucherno;
	}

	public String getLbldescription() {
		return lbldescription;
	}

	public void setLbldescription(String lbldescription) {
		this.lbldescription = lbldescription;
	}

	public String getLbldate() {
		return lbldate;
	}

	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}

	public String getLbltotincome() {
		return lbltotincome;
	}

	public void setLbltotincome(String lbltotincome) {
		this.lbltotincome = lbltotincome;
	}

	public String getLbltotexpenditure() {
		return lbltotexpenditure;
	}

	public void setLbltotexpenditure(String lbltotexpenditure) {
		this.lbltotexpenditure = lbltotexpenditure;
	}

	public String getLblincomemonth1() {
		return lblincomemonth1;
	}

	public void setLblincomemonth1(String lblincomemonth1) {
		this.lblincomemonth1 = lblincomemonth1;
	}

	public String getLblincomemonth2() {
		return lblincomemonth2;
	}

	public void setLblincomemonth2(String lblincomemonth2) {
		this.lblincomemonth2 = lblincomemonth2;
	}

	public String getLblincomemonth3() {
		return lblincomemonth3;
	}

	public void setLblincomemonth3(String lblincomemonth3) {
		this.lblincomemonth3 = lblincomemonth3;
	}

	public String getLblincomemonth4() {
		return lblincomemonth4;
	}

	public void setLblincomemonth4(String lblincomemonth4) {
		this.lblincomemonth4 = lblincomemonth4;
	}

	public String getLblincomemonth5() {
		return lblincomemonth5;
	}

	public void setLblincomemonth5(String lblincomemonth5) {
		this.lblincomemonth5 = lblincomemonth5;
	}

	public String getLblincomemonth6() {
		return lblincomemonth6;
	}

	public void setLblincomemonth6(String lblincomemonth6) {
		this.lblincomemonth6 = lblincomemonth6;
	}

	public String getLblincomemonth7() {
		return lblincomemonth7;
	}

	public void setLblincomemonth7(String lblincomemonth7) {
		this.lblincomemonth7 = lblincomemonth7;
	}

	public String getLblincomemonth8() {
		return lblincomemonth8;
	}

	public void setLblincomemonth8(String lblincomemonth8) {
		this.lblincomemonth8 = lblincomemonth8;
	}

	public String getLblincomemonth9() {
		return lblincomemonth9;
	}

	public void setLblincomemonth9(String lblincomemonth9) {
		this.lblincomemonth9 = lblincomemonth9;
	}

	public String getLblincomemonth10() {
		return lblincomemonth10;
	}

	public void setLblincomemonth10(String lblincomemonth10) {
		this.lblincomemonth10 = lblincomemonth10;
	}

	public String getLblincomemonth11() {
		return lblincomemonth11;
	}

	public void setLblincomemonth11(String lblincomemonth11) {
		this.lblincomemonth11 = lblincomemonth11;
	}

	public String getLblincomemonth12() {
		return lblincomemonth12;
	}

	public void setLblincomemonth12(String lblincomemonth12) {
		this.lblincomemonth12 = lblincomemonth12;
	}

	public String getLblexpendituremonth1() {
		return lblexpendituremonth1;
	}

	public void setLblexpendituremonth1(String lblexpendituremonth1) {
		this.lblexpendituremonth1 = lblexpendituremonth1;
	}

	public String getLblexpendituremonth2() {
		return lblexpendituremonth2;
	}

	public void setLblexpendituremonth2(String lblexpendituremonth2) {
		this.lblexpendituremonth2 = lblexpendituremonth2;
	}

	public String getLblexpendituremonth3() {
		return lblexpendituremonth3;
	}

	public void setLblexpendituremonth3(String lblexpendituremonth3) {
		this.lblexpendituremonth3 = lblexpendituremonth3;
	}

	public String getLblexpendituremonth4() {
		return lblexpendituremonth4;
	}

	public void setLblexpendituremonth4(String lblexpendituremonth4) {
		this.lblexpendituremonth4 = lblexpendituremonth4;
	}

	public String getLblexpendituremonth5() {
		return lblexpendituremonth5;
	}

	public void setLblexpendituremonth5(String lblexpendituremonth5) {
		this.lblexpendituremonth5 = lblexpendituremonth5;
	}

	public String getLblexpendituremonth6() {
		return lblexpendituremonth6;
	}

	public void setLblexpendituremonth6(String lblexpendituremonth6) {
		this.lblexpendituremonth6 = lblexpendituremonth6;
	}

	public String getLblexpendituremonth7() {
		return lblexpendituremonth7;
	}

	public void setLblexpendituremonth7(String lblexpendituremonth7) {
		this.lblexpendituremonth7 = lblexpendituremonth7;
	}

	public String getLblexpendituremonth8() {
		return lblexpendituremonth8;
	}

	public void setLblexpendituremonth8(String lblexpendituremonth8) {
		this.lblexpendituremonth8 = lblexpendituremonth8;
	}

	public String getLblexpendituremonth9() {
		return lblexpendituremonth9;
	}

	public void setLblexpendituremonth9(String lblexpendituremonth9) {
		this.lblexpendituremonth9 = lblexpendituremonth9;
	}

	public String getLblexpendituremonth10() {
		return lblexpendituremonth10;
	}

	public void setLblexpendituremonth10(String lblexpendituremonth10) {
		this.lblexpendituremonth10 = lblexpendituremonth10;
	}

	public String getLblexpendituremonth11() {
		return lblexpendituremonth11;
	}

	public void setLblexpendituremonth11(String lblexpendituremonth11) {
		this.lblexpendituremonth11 = lblexpendituremonth11;
	}

	public String getLblexpendituremonth12() {
		return lblexpendituremonth12;
	}

	public void setLblexpendituremonth12(String lblexpendituremonth12) {
		this.lblexpendituremonth12 = lblexpendituremonth12;
	}

	public String getLblincometotal() {
		return lblincometotal;
	}

	public void setLblincometotal(String lblincometotal) {
		this.lblincometotal = lblincometotal;
	}

	public String getLblexpendituretotal() {
		return lblexpendituretotal;
	}

	public void setLblexpendituretotal(String lblexpendituretotal) {
		this.lblexpendituretotal = lblexpendituretotal;
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

	public int getFirstarray() {
		return firstarray;
	}

	public void setFirstarray(int firstarray) {
		this.firstarray = firstarray;
	}

	public int getSecarray() {
		return secarray;
	}

	public void setSecarray(int secarray) {
		this.secarray = secarray;
	}

	public int getTxtheader() {
		return txtheader;
	}

	public void setTxtheader(int txtheader) {
		this.txtheader = txtheader;
	}



	java.sql.Date budgetsDate;
	java.sql.Date hidbudgetsDate;
	java.sql.Date assessmentDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		String mode=getMode();
		ClsBudgetBean bean = new ClsBudgetBean();

		budgetsDate = commonDAO.changeStringtoSqlDate(getBudgetDate());
		hidbudgetsDate = commonDAO.changeStringtoSqlDate(getMaindate());
		assessmentDate = commonDAO.changeStringtoSqlDate("01."+getAssessmentYearDate());
		
		if(mode.equalsIgnoreCase("A")){
			ArrayList<String> incomearray= new ArrayList<String>();
			ArrayList<String> expenditurearray= new ArrayList<String>();
			
			/*Income Grid Saving*/
			for(int i=0;i<getIncomegridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				incomearray.add(temp);
			}
			/*Income Grid Saving*/
			
			/*Expenditure Grid Saving*/
			for(int j=0;j<getExpendituregridlength();j++){
				String temps=requestParams.get("tests"+j)[0];
				expenditurearray.add(temps);
			}
			/*Expenditure Grid Saving*/
			
			int val=budgetDAO.insert(budgetsDate,getFormdetailcode(),assessmentDate,getTxtdescription(),getTxttotalincome(),getTxttotalexpenditure(),getIncomegridcolumn(),getExpendituregridcolumn(),
					incomearray,expenditurearray,session,request,mode);
			if(val>0.0){

				setTxtbudgetdocno(val);
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
			ArrayList<String> incomearray= new ArrayList<String>();
			ArrayList<String> expenditurearray= new ArrayList<String>();
			
			/*Income Grid Saving*/
			for(int i=0;i<getIncomegridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				incomearray.add(temp);
			}
			/*Income Grid Saving*/
			
			/*Expenditure Grid Saving*/
			for(int j=0;j<getExpendituregridlength();j++){
				String temps=requestParams.get("tests"+j)[0];
				expenditurearray.add(temps);
			}
			/*Expenditure Grid Saving*/
					
			boolean Status=budgetDAO.edit(getTxtbudgetdocno(),budgetsDate,getFormdetailcode(),assessmentDate,getTxtdescription(),getTxttotalincome(),getTxttotalexpenditure(),getIncomegridcolumn(),getExpendituregridcolumn(),
					incomearray,expenditurearray,session,request,mode);
			if(Status){
				
				setTxtbudgetdocno(getTxtbudgetdocno());
				setData();
				
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setTxtbudgetdocno(getTxtbudgetdocno());
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("D")){
					
			boolean Status=budgetDAO.delete(getTxtbudgetdocno(),getFormdetailcode(),session,mode);
			if(Status){
				setTxtbudgetdocno(getTxtbudgetdocno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setData();
				setTxtbudgetdocno(getTxtbudgetdocno());
				setMsg("Not Deleted");
				return "fail";
			   }
			}
			
		else if(mode.equalsIgnoreCase("View")){
			
			String branch=null;
			budgetBean=budgetDAO.getViewDetails(session,getTxtbudgetdocno());
			
			setBudgetDate(budgetBean.getBudgetDate());
			setAssessmentYearDate(budgetBean.getAssessmentYearDate());
			setTxtbudgetdocno(budgetBean.getTxtbudgetdocno());
			setTxtdescription(budgetBean.getTxtdescription());
			setTxttotalincome(budgetBean.getTxttotalincome());
			setTxttotalexpenditure(budgetBean.getTxttotalexpenditure());
			setMaindate(budgetBean.getMaindate());
			setFormdetailcode(budgetBean.getFormdetailcode());
			
			return "success";
		}
		return "fail";
   }
	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		int docno=Integer.parseInt(request.getParameter("docno"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		int header=Integer.parseInt(request.getParameter("header"));
		budgetBean=budgetDAO.getPrint(request,docno,branch,header);
		setUrl(commonDAO.getPrintPath("BGT"));
		setLblcompname(budgetBean.getLblcompname());
		setLblcompaddress(budgetBean.getLblcompaddress());
		setLblpobox(budgetBean.getLblpobox());
		setLblprintname("Budget");
		setLblcomptel(budgetBean.getLblcomptel());
		setLblcompfax(budgetBean.getLblcompfax());
		setLblbranch(budgetBean.getLblbranch());
		setLbllocation(budgetBean.getLbllocation());
		setLblservicetax(budgetBean.getLblservicetax());
		setLblpan(budgetBean.getLblpan());
		setLblcstno(budgetBean.getLblcstno());
		
		setLblassessmentyear(budgetBean.getLblassessmentyear());
		setLblvoucherno(budgetBean.getLblvoucherno());
		setLbldate(budgetBean.getLbldate());
		setLbldescription(budgetBean.getLbldescription());
		setLbltotincome(budgetBean.getLbltotincome());
		setLbltotexpenditure(budgetBean.getLbltotexpenditure());
		
		setLblincomemonth1(budgetBean.getLblincomemonth1());
		setLblincomemonth2(budgetBean.getLblincomemonth2());
		setLblincomemonth3(budgetBean.getLblincomemonth3());
		setLblincomemonth4(budgetBean.getLblincomemonth4());
		setLblincomemonth5(budgetBean.getLblincomemonth5());
		setLblincomemonth6(budgetBean.getLblincomemonth6());
		setLblincomemonth7(budgetBean.getLblincomemonth7());
		setLblincomemonth8(budgetBean.getLblincomemonth8());
		setLblincomemonth9(budgetBean.getLblincomemonth9());
		setLblincomemonth10(budgetBean.getLblincomemonth10());
		setLblincomemonth11(budgetBean.getLblincomemonth11());
		setLblincomemonth12(budgetBean.getLblincomemonth12());
		setLblincometotal(budgetBean.getLblincometotal());
		
		setLblexpendituremonth1(budgetBean.getLblexpendituremonth1());
		setLblexpendituremonth2(budgetBean.getLblexpendituremonth2());
		setLblexpendituremonth3(budgetBean.getLblexpendituremonth3());
		setLblexpendituremonth4(budgetBean.getLblexpendituremonth4());
		setLblexpendituremonth5(budgetBean.getLblexpendituremonth5());
		setLblexpendituremonth6(budgetBean.getLblexpendituremonth6());
		setLblexpendituremonth7(budgetBean.getLblexpendituremonth7());
		setLblexpendituremonth8(budgetBean.getLblexpendituremonth8());
		setLblexpendituremonth9(budgetBean.getLblexpendituremonth9());
		setLblexpendituremonth10(budgetBean.getLblexpendituremonth10());
		setLblexpendituremonth11(budgetBean.getLblexpendituremonth11());
		setLblexpendituremonth12(budgetBean.getLblexpendituremonth12());
		setLblexpendituretotal(budgetBean.getLblexpendituretotal());
		
		setLblpreparedby(budgetBean.getLblpreparedby());
		setLblpreparedon(budgetBean.getLblpreparedon());
		setLblpreparedat(budgetBean.getLblpreparedat());
		
		setFirstarray(budgetBean.getFirstarray());
		setSecarray(budgetBean.getSecarray());
		setTxtheader(budgetBean.getTxtheader());
			
		return "print";
	}
	
	public JSONArray searchDetails(HttpSession session,String docNo,String date,String assessmentsDate,String description){
		  JSONArray cellarray = new JSONArray();
		  		  JSONObject cellobj = null;
		  try {
			cellarray= budgetDAO.bgtMainSearch(session,docNo, date, assessmentsDate, description);
	
		  } catch (SQLException e) {
			  e.printStackTrace();
			  }
		return cellarray;
	}
	
	public void setData(){
		
		setHidbudgetDate(budgetsDate.toString());
		setHidassessmentYearDate(assessmentYearDate.toString());
		setHidmaindate(hidbudgetsDate.toString());
		setTxtdescription(getTxtdescription());
		setTxttotalincome(getTxttotalincome());
		setTxttotalexpenditure(getTxttotalexpenditure());
		setFormdetailcode(getFormdetailcode());
	}
}

