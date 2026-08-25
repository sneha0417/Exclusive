package com.dashboard;

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
public class ClsDashBoardAction extends ActionSupport{

	ClsCommon ClsCommon=new ClsCommon();

	ClsDashBoardDAO dashboardDAO= new ClsDashBoardDAO();
	ClsDashBoardBean dashboardBean;

	private int txttododocno;
	private String mode;
	private String deleted;
	private String msg;
	private String txttitle;
	private String jqxDate;
	private String hidjqxDate;
	private String cmbpriority;
	private String hidcmbpriority;
	private String txtdescription;
	
	public int getTxttododocno() {
		return txttododocno;
	}
	public void setTxttododocno(int txttododocno) {
		this.txttododocno = txttododocno;
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
	public String getTxttitle() {
		return txttitle;
	}
	public void setTxttitle(String txttitle) {
		this.txttitle = txttitle;
	}
	public String getJqxDate() {
		return jqxDate;
	}
	public void setJqxDate(String jqxDate) {
		this.jqxDate = jqxDate;
	}
	public String getHidjqxDate() {
		return hidjqxDate;
	}
	public void setHidjqxDate(String hidjqxDate) {
		this.hidjqxDate = hidjqxDate;
	}
	public String getCmbpriority() {
		return cmbpriority;
	}
	public void setCmbpriority(String cmbpriority) {
		this.cmbpriority = cmbpriority;
	}
	public String getHidcmbpriority() {
		return hidcmbpriority;
	}
	public void setHidcmbpriority(String hidcmbpriority) {
		this.hidcmbpriority = hidcmbpriority;
	}
	public String getTxtdescription() {
		return txtdescription;
	}
	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}

java.sql.Date toDotDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();

		String mode=getMode();
		ClsDashBoardBean bean = new ClsDashBoardBean();
		toDotDate = ClsCommon.changeStringtoSqlDate(getJqxDate());

		if(mode.equalsIgnoreCase("A")){
			
						int val=dashboardDAO.insert(toDotDate,getTxttitle(),getTxtdescription(),getCmbpriority(),session,mode);
						if(val>0.0){
							
							setTxttododocno(val);
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

			boolean Status=dashboardDAO.edit(getTxttododocno(),toDotDate,getTxttitle(),getTxtdescription(),getCmbpriority(),session,mode);
			if(Status){

				setTxttododocno(getTxttododocno());
				setData();
				
				setMsg("Updated Successfully");
			    return "success";
		}
		else{
			setTxttododocno(getTxttododocno());
			setData();
			setMsg("Not Updated");
			return "fail";
		}
	  }
		
		
		else if(mode.equalsIgnoreCase("D")){
			
			boolean Status=dashboardDAO.delete(getTxttododocno(),session,mode);
			if(Status){
				
				setTxttododocno(getTxttododocno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setData();
				setMsg("Not Deleted");
				return "fail";
			   }
			}
		
		return "fail";
}
	
	public void setData() {
		setHidjqxDate(toDotDate.toString());
		setTxttitle(getTxttitle());
		setHidcmbpriority(getCmbpriority());
		setTxtdescription(getTxtdescription());
	}
	
}
