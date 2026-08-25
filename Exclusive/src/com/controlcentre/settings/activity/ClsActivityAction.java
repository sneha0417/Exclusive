package com.controlcentre.settings.activity;

import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;


public class ClsActivityAction {
	ClsActivityDAO actiDAO= new ClsActivityDAO();
	ClsCommon com= new ClsCommon();
	ClsActivityBean bean;
	
	private int docno;
	private String activity;
	private String activity_code;
	private String date_acti;
	private String mode;
	private String deleted;
	private String datehidden;
	private String msg;
	
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getActivity() {
		return activity;
	}
	public void setActivity(String activity) {
		this.activity = activity;
	}
	public String getActivity_code() {
		return activity_code;
	}
	public void setActivity_code(String activity_code) {
		this.activity_code = activity_code;
	}
	public String getDate_acti() {
		return date_acti;
	}
	public void setDate_acti(String date_acti) {
		this.date_acti = date_acti;
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
	public String getDatehidden() {
		return datehidden;
	}
	public void setDatehidden(String datehidden) {
		this.datehidden = datehidden;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	
public String saveAction() throws ParseException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		ClsActivityBean bean=new ClsActivityBean();
		java.sql.Date sqlStartDate = com.changeStringtoSqlDate(getDate_acti());
		bean.setActivity(getActivity());
		bean.setActivity_code(getActivity_code());
		bean.setDate_acti(sqlStartDate);
		bean.setDocno(getDocno());
		bean.setMode(getMode());
         if(mode.equalsIgnoreCase("A")){
			
			int val=actiDAO.insert(bean,session);
			if(val>0){
				setDate_acti(sqlStartDate.toString());
				setActivity(getActivity());
				setActivity_code(getActivity_code());
				setDocno(val);
				setMsg("Successfully Saved");
				
				return "success";
			}
			else{
				setMsg("Not Saved");
				return "fail";
			}	
			
		}
         else if(mode.equalsIgnoreCase("E")){
 			
 			boolean Status=actiDAO.edit(bean,session);
 			if(Status){
 				setDate_acti(sqlStartDate.toString());
				setActivity(getActivity());
				setActivity_code(getActivity_code());
 				setDocno(getDocno());
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setMsg("Not Updated");
				return "fail";
			}
		}
         else if(mode.equalsIgnoreCase("D")){
 			boolean Status=actiDAO.delete(bean,session);
 		if(Status){
 			setDate_acti(sqlStartDate.toString());
			setActivity(getActivity());
			setActivity_code(getActivity_code());
 			setDocno(getDocno());
			setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
		}
		else{
			setMsg("Not Deleted");
			return "fail";
		}
		}
	
		return "fail";
	}

}
