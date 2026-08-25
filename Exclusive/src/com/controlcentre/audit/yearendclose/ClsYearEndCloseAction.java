package com.controlcentre.audit.yearendclose;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsYearEndCloseAction {

	ClsYearEndCloseDAO yearEndCloseDAO= new ClsYearEndCloseDAO();
	ClsYearEndCloseBean yearEndCloseBean;
	ClsCommon ClsCommon=new ClsCommon();
	
	private int txtyearendclosedocno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String yearEndDate;
	private String hidyearEndDate;
	private String accountingYearFrom;
	private String hidaccountingYearFrom;
	private String accountingYearTo;
	private String hidaccountingYearTo;
	private String ycloseDateFrom;
	private String hidycloseDateFrom;
	private String ycloseDateTo;
	private String hidycloseDateTo;
	private int txttrno;
	private double txtnettotal;
	
	//Year End Close Grid
	private int gridlength;
	
	//Year End Close Group Grid
	private int yearendclosegroupgridlength;

	public int getTxtyearendclosedocno() {
		return txtyearendclosedocno;
	}
	public void setTxtyearendclosedocno(int txtyearendclosedocno) {
		this.txtyearendclosedocno = txtyearendclosedocno;
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
	public String getYearEndDate() {
		return yearEndDate;
	}
	public void setYearEndDate(String yearEndDate) {
		this.yearEndDate = yearEndDate;
	}
	public String getHidyearEndDate() {
		return hidyearEndDate;
	}
	public void setHidyearEndDate(String hidyearEndDate) {
		this.hidyearEndDate = hidyearEndDate;
	}
	public String getAccountingYearFrom() {
		return accountingYearFrom;
	}
	public void setAccountingYearFrom(String accountingYearFrom) {
		this.accountingYearFrom = accountingYearFrom;
	}
	public String getHidaccountingYearFrom() {
		return hidaccountingYearFrom;
	}
	public void setHidaccountingYearFrom(String hidaccountingYearFrom) {
		this.hidaccountingYearFrom = hidaccountingYearFrom;
	}
	public String getAccountingYearTo() {
		return accountingYearTo;
	}
	public void setAccountingYearTo(String accountingYearTo) {
		this.accountingYearTo = accountingYearTo;
	}
	public String getHidaccountingYearTo() {
		return hidaccountingYearTo;
	}
	public void setHidaccountingYearTo(String hidaccountingYearTo) {
		this.hidaccountingYearTo = hidaccountingYearTo;
	}
	public String getYcloseDateFrom() {
		return ycloseDateFrom;
	}
	public void setYcloseDateFrom(String ycloseDateFrom) {
		this.ycloseDateFrom = ycloseDateFrom;
	}
	public String getHidycloseDateFrom() {
		return hidycloseDateFrom;
	}
	public void setHidycloseDateFrom(String hidycloseDateFrom) {
		this.hidycloseDateFrom = hidycloseDateFrom;
	}
	public String getYcloseDateTo() {
		return ycloseDateTo;
	}
	public void setYcloseDateTo(String ycloseDateTo) {
		this.ycloseDateTo = ycloseDateTo;
	}
	public String getHidycloseDateTo() {
		return hidycloseDateTo;
	}
	public void setHidycloseDateTo(String hidycloseDateTo) {
		this.hidycloseDateTo = hidycloseDateTo;
	}
	public int getTxttrno() {
		return txttrno;
	}
	public void setTxttrno(int txttrno) {
		this.txttrno = txttrno;
	}
	public double getTxtnettotal() {
		return txtnettotal;
	}
	public void setTxtnettotal(double txtnettotal) {
		this.txtnettotal = txtnettotal;
	}
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	public int getYearendclosegroupgridlength() {
		return yearendclosegroupgridlength;
	}
	public void setYearendclosegroupgridlength(int yearendclosegroupgridlength) {
		this.yearendclosegroupgridlength = yearendclosegroupgridlength;
	}

	java.sql.Date yearEndCloseDate=null;
	java.sql.Date yearToCloseFromDate=null;
	java.sql.Date yearToCloseToDate=null;
	java.sql.Date nextAccountingYearFromDate=null;
	java.sql.Date nextAccountingYearToDate=null;
	
	public String saveAction() throws ParseException, Exception{
		
		try{
			 System.out.println("==== inside ===");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsYearEndCloseBean bean = new ClsYearEndCloseBean();
		
		yearEndCloseDate = (getYearEndDate()==null || getYearEndDate().trim().equalsIgnoreCase(""))?null:ClsCommon.changeStringtoSqlDate(getYearEndDate());
		yearToCloseFromDate = (getYcloseDateFrom()==null || getYcloseDateFrom().trim().equalsIgnoreCase(""))?null:ClsCommon.changeStringtoSqlDate(getYcloseDateFrom());
		yearToCloseToDate = (getYcloseDateTo()==null || getYcloseDateTo().trim().equalsIgnoreCase(""))?null:ClsCommon.changeStringtoSqlDate(getYcloseDateTo());
		nextAccountingYearFromDate = (getAccountingYearFrom()==null || getAccountingYearFrom().trim().equalsIgnoreCase(""))?null:ClsCommon.changeStringtoSqlDate(getAccountingYearFrom());
		nextAccountingYearToDate = (getAccountingYearTo()==null || getAccountingYearTo().trim().equalsIgnoreCase(""))?null:ClsCommon.changeStringtoSqlDate(getAccountingYearTo());
		
		if(mode.equalsIgnoreCase("A")){
			/*Year End Close Grid Saving*/
			ArrayList<String> yearendclosearray= new ArrayList<String>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				yearendclosearray.add(temp);
			}
			// System.out.println("===== "+yearendclosearray);
			/*Year End Close Grid Saving Ends*/
			
			/*Year End Close Group Grid Saving*/
			ArrayList<String> yearendclosegrouparray= new ArrayList<String>();
			for(int i=0;i<getYearendclosegroupgridlength();i++){
				String grouptemp=requestParams.get("txttest"+i)[0];
				yearendclosegrouparray.add(grouptemp);
			}
			/*Year End Close Group Grid Saving Ends*/
			
						int val=yearEndCloseDAO.insert(yearEndCloseDate,getFormdetailcode(),yearToCloseFromDate,yearToCloseToDate,nextAccountingYearFromDate,nextAccountingYearToDate,getTxtnettotal(),yearendclosearray,yearendclosegrouparray,session,request,mode);
						if(val>0.0){
							
							setTxtyearendclosedocno(val);
							setTxttrno(Integer.parseInt(request.getAttribute("tranno").toString()));
							setTxtnettotal(getTxtnettotal());
							setHidyearEndDate(yearEndCloseDate==null?null:yearEndCloseDate.toString());
							setHidycloseDateFrom(yearToCloseFromDate==null?null:yearToCloseFromDate.toString());
							setHidycloseDateTo(yearToCloseToDate==null?null:yearToCloseToDate.toString());
							setHidaccountingYearFrom(nextAccountingYearFromDate==null?null:nextAccountingYearFromDate.toString());
							setHidaccountingYearTo(nextAccountingYearToDate==null?null:nextAccountingYearToDate.toString());
							
							setMsg("Successfully Saved");
							return "success";
						}
						else{
							setTxtnettotal(getTxtnettotal());
							setHidyearEndDate(yearEndCloseDate==null?null:yearEndCloseDate.toString());
							setHidycloseDateFrom(yearToCloseFromDate==null?null:yearToCloseFromDate.toString());
							setHidycloseDateTo(yearToCloseToDate==null?null:yearToCloseToDate.toString());
							setHidaccountingYearFrom(nextAccountingYearFromDate==null?null:nextAccountingYearFromDate.toString());
							setHidaccountingYearTo(nextAccountingYearToDate==null?null:nextAccountingYearToDate.toString());
							
							setMsg("Not Saved");
							return "fail";
						}	
		}
		
		else if(mode.equalsIgnoreCase("E")){

			/*Year End Close Grid Saving*/
			ArrayList<String> yearendclosearray= new ArrayList<String>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				yearendclosearray.add(temp);
			}
			/*Year End Close Grid Saving Ends*/
			
			/*Year End Close Group Grid Saving*/
			ArrayList<String> yearendclosegrouparray= new ArrayList<String>();
			for(int i=0;i<getYearendclosegroupgridlength();i++){
				String grouptemp=requestParams.get("txttest"+i)[0];
				yearendclosegrouparray.add(grouptemp);
			}
			/*Year End Close Group Grid Saving Ends*/
			
			boolean Status=yearEndCloseDAO.edit(getTxtyearendclosedocno(),getFormdetailcode(),yearEndCloseDate,yearToCloseFromDate,yearToCloseToDate,nextAccountingYearFromDate,nextAccountingYearToDate,getTxttrno(),yearendclosearray,yearendclosegrouparray,session,mode);
			if(Status){

				setTxtyearendclosedocno(getTxtyearendclosedocno());
				setTxttrno(getTxttrno());
				setTxtnettotal(getTxtnettotal());
				setHidyearEndDate(yearEndCloseDate==null?null:yearEndCloseDate.toString());
				setHidycloseDateFrom(yearToCloseFromDate==null?null:yearToCloseFromDate.toString());
				setHidycloseDateTo(yearToCloseToDate==null?null:yearToCloseToDate.toString());
				setHidaccountingYearFrom(nextAccountingYearFromDate==null?null:nextAccountingYearFromDate.toString());
				setHidaccountingYearTo(nextAccountingYearToDate==null?null:nextAccountingYearToDate.toString());
				
				setMsg("Updated Successfully");
			    return "success";
		}
		else{
			setTxtyearendclosedocno(getTxtyearendclosedocno());
			setTxttrno(getTxttrno());
			setTxtnettotal(getTxtnettotal());
			setHidyearEndDate(yearEndCloseDate==null?null:yearEndCloseDate.toString());
			setHidycloseDateFrom(yearToCloseFromDate==null?null:yearToCloseFromDate.toString());
			setHidycloseDateTo(yearToCloseToDate==null?null:yearToCloseToDate.toString());
			setHidaccountingYearFrom(nextAccountingYearFromDate==null?null:nextAccountingYearFromDate.toString());
			setHidaccountingYearTo(nextAccountingYearToDate==null?null:nextAccountingYearToDate.toString());
			
			setMsg("Not Updated");
			return "fail";
		}
	  }
		
		
		else if(mode.equalsIgnoreCase("D")){
			
			boolean Status=yearEndCloseDAO.delete(getTxtyearendclosedocno(),getFormdetailcode(),session,mode);
			if(Status){
				
				setTxtyearendclosedocno(getTxtyearendclosedocno());
				setTxttrno(getTxttrno());
				setTxtnettotal(getTxtnettotal());
				setHidyearEndDate(yearEndCloseDate==null?null:yearEndCloseDate.toString());
				setHidycloseDateFrom(yearToCloseFromDate==null?null:yearToCloseFromDate.toString());
				setHidycloseDateTo(yearToCloseToDate==null?null:yearToCloseToDate.toString());
				setHidaccountingYearFrom(nextAccountingYearFromDate==null?null:nextAccountingYearFromDate.toString());
				setHidaccountingYearTo(nextAccountingYearToDate==null?null:nextAccountingYearToDate.toString());
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setTxtyearendclosedocno(getTxtyearendclosedocno());
				setTxttrno(getTxttrno());
				setTxtnettotal(getTxtnettotal());
				setHidyearEndDate(yearEndCloseDate==null?null:yearEndCloseDate.toString());
				setHidycloseDateFrom(yearToCloseFromDate==null?null:yearToCloseFromDate.toString());
				setHidycloseDateTo(yearToCloseToDate==null?null:yearToCloseToDate.toString());
				setHidaccountingYearFrom(nextAccountingYearFromDate==null?null:nextAccountingYearFromDate.toString());
				setHidaccountingYearTo(nextAccountingYearToDate==null?null:nextAccountingYearToDate.toString());
				
				setMsg("Not Deleted");
				return "fail";
			   }
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	
	}



}
