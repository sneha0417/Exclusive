package com.project.leadmanagement.activityreport;

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
public class ClsActivityReportAction extends ActionSupport{

	ClsActivityReportDAO activityReportDAO= new ClsActivityReportDAO();
	ClsActivityReportBean activityreportbean;
	
	ClsCommon commonDAO= new ClsCommon();
	
	private String formdetailcode;
	private String chkstatus;
	private String mode;
	private String deleted;
	private String msg;
	private int txtactivityreportdocno;
	private String activityDate;
	private String hidactivityDate;
	private String lblformstatus;
	private String lblformusername;
	private String txthighlight;
	
	private int gridlength;
	
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

	public int getTxtactivityreportdocno() {
		return txtactivityreportdocno;
	}

	public void setTxtactivityreportdocno(int txtactivityreportdocno) {
		this.txtactivityreportdocno = txtactivityreportdocno;
	}

	public String getActivityDate() {
		return activityDate;
	}

	public void setActivityDate(String activityDate) {
		this.activityDate = activityDate;
	}

	public String getHidactivityDate() {
		return hidactivityDate;
	}

	public void setHidactivityDate(String hidactivityDate) {
		this.hidactivityDate = hidactivityDate;
	}

	public String getLblformstatus() {
		return lblformstatus;
	}

	public void setLblformstatus(String lblformstatus) {
		this.lblformstatus = lblformstatus;
	}

	public String getLblformusername() {
		return lblformusername;
	}

	public void setLblformusername(String lblformusername) {
		this.lblformusername = lblformusername;
	}

	public String getTxthighlight() {
		return txthighlight;
	}

	public void setTxthighlight(String txthighlight) {
		this.txthighlight = txthighlight;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	java.sql.Date activityReportDate=null; 
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsActivityReportBean activityreportbean = new ClsActivityReportBean();
		
		if(mode.equalsIgnoreCase("A")){
			
			activityReportDate = (getActivityDate()==null || getActivityDate().trim().equalsIgnoreCase(""))?null:commonDAO.changeStringtoSqlDate(getActivityDate());
			
			/*Activity Report Grid Saving*/
			ArrayList<String> activityreportarray= new ArrayList<String>();
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				activityreportarray.add(temp);
			}
			/*Activity Report Grid Saving Ends*/
			
			int val=activityReportDAO.insert(getFormdetailcode(),activityReportDate,getTxthighlight(),activityreportarray,session,mode);
			if(val>0.0){
				
				setTxtactivityreportdocno(val);
				setLblformusername(session.getAttribute("USERNAME").toString().trim());
				setLblformstatus("TO BE SUBMITTED");
				setData();
				
				setMsg("Successfully Saved");
				return "success";
			}
			 else if(val==-1)
			   {
				setLblformusername(session.getAttribute("USERNAME").toString().trim());
				setLblformstatus("TO BE SUBMITTED");
				setData();
				setChkstatus("1");
				setMsg("Transaction Restricted. Invalid Date.");
			    return "fail";
			   }
			else{
				setLblformusername(session.getAttribute("USERNAME").toString().trim());
				setLblformstatus("TO BE SUBMITTED");
				setData();
				setMsg("Not Saved");
				return "fail";
			}	
		}
		
		else if(mode.equalsIgnoreCase("EDIT")){

			boolean Status=activityReportDAO.editMaster(getFormdetailcode(),getTxtactivityreportdocno(),session,mode);
			if(Status){
				
				setTxtactivityreportdocno(getTxtactivityreportdocno());
				setLblformusername(session.getAttribute("USERNAME").toString().trim());
				setLblformstatus("SUBMITTED");
				setData();
				
				setMsg("Updated Successfully");
			    return "success";
			}
			else{
				setTxtactivityreportdocno(getTxtactivityreportdocno());
				setLblformusername(session.getAttribute("USERNAME").toString().trim());
				setLblformstatus("TO BE SUBMITTED");
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		  }
			
		else if(mode.equalsIgnoreCase("E")){
			
			activityReportDate = (getActivityDate()==null || getActivityDate().trim().equalsIgnoreCase(""))?null:commonDAO.changeStringtoSqlDate(getActivityDate());
			
			/*Activity Report Grid Saving*/
			ArrayList<String> activityreportarray= new ArrayList<String>();
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				activityreportarray.add(temp);
			}
			/*Activity Report Grid Saving Ends*/
			
			int Status=activityReportDAO.edit(getFormdetailcode(),getTxtactivityreportdocno(),activityReportDate,getTxthighlight(),activityreportarray,session,mode);
			if(Status>0){
				
				setTxtactivityreportdocno(getTxtactivityreportdocno());
				setLblformusername(session.getAttribute("USERNAME").toString().trim());
				setLblformstatus("TO BE SUBMITTED");
				setData();
				
				setMsg("Updated Successfully");
				return "success";
			}
			else if(Status==-1)
			   {
				setLblformusername(session.getAttribute("USERNAME").toString().trim());
				setLblformstatus("TO BE SUBMITTED");
				setData();
				setChkstatus("2");
			    setMsg("Transaction Restricted. Invalid Date.");
			    return "fail";
			}
			else{
				setTxtactivityreportdocno(getTxtactivityreportdocno());
				setLblformusername(session.getAttribute("USERNAME").toString().trim());
				setLblformstatus("TO BE SUBMITTED");
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("D")){
			
		boolean Status=activityReportDAO.delete(getTxtactivityreportdocno(),getFormdetailcode(),session,mode);
		
		if(Status){
			
			setTxtactivityreportdocno(getTxtactivityreportdocno());
			setLblformusername(session.getAttribute("USERNAME").toString().trim());
			setLblformstatus("TO BE SUBMITTED");
			setData();
			
			setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
		}
		else{
			setTxtactivityreportdocno(getTxtactivityreportdocno());
			setLblformusername(session.getAttribute("USERNAME").toString().trim());
			setLblformstatus("TO BE SUBMITTED");
			setData();
			setMsg("Not Deleted");
			return "fail";
		}
		
		}
		
		else if(mode.equalsIgnoreCase("View")){
			
			String branch=null;
			activityreportbean=activityReportDAO.getViewDetails(session,getTxtactivityreportdocno());
			
			setActivityDate(activityreportbean.getActivityDate());
			setTxthighlight(activityreportbean.getTxthighlight());
			setTxtactivityreportdocno(getTxtactivityreportdocno());
			setLblformstatus(activityreportbean.getLblformstatus());
			setLblformusername(activityreportbean.getLblformusername());
			setFormdetailcode(activityreportbean.getFormdetailcode());
			
			return "success";
		}
		return "fail";
	}
	
	public void setData(){
		setHidactivityDate(activityReportDate==null?null:activityReportDate.toString());
		setTxthighlight(getTxthighlight());
		setFormdetailcode(getFormdetailcode());
	}
}
