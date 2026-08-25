package com.controlcentre.masters.vehiclemaster.vehtype;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.controlcentre.masters.vehiclemaster.authority.ClsAuthorityBean;

public class ClsVehTypeAction {
	ClsCommon objcommon=new ClsCommon();
	ClsVehTypeDAO dao=new ClsVehTypeDAO();
	private int docno;
	private String name;
	private String date;
	private String mode;
	private String deleted;
	private String msg;
	private String formdetail;
	private String formdetailcode;
	private String chkstatus;
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
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
	public String getFormdetail() {
		return formdetail;
	}
	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
	}
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
	
	public void setValues(java.sql.Date sqldate,int docno,String msg){
		setName(getName());
		setMode(getMode());
		setDate(sqldate.toString());
		setDocno(docno);
		setMsg(msg);
	}
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		java.sql.Date sqldate=null;
		if(!getDate().equalsIgnoreCase("") && getDate()!=null && !getDate().equalsIgnoreCase("undefined")){
			sqldate=objcommon.changeStringtoSqlDate(getDate());
		}
		if(mode.equalsIgnoreCase("A")){
			int val=dao.insert(getName(),sqldate,session,mode,getFormdetailcode());
			if(val>0.0){
				setValues(sqldate, val, "Successfully Saved");
				return "success";
			}
			else if(val==-1){
				setValues(sqldate, val,"Vehicle Type Already Exists");
				setChkstatus("1");
				return "fail";
			}
			else{
				setValues(sqldate, val,"Not Saved");
				return "fail";
			}	
		}
		else if(mode.equalsIgnoreCase("E")){
			int editstatus=dao.edit(getDocno(),sqldate,getName(),session,getMode(),getFormdetailcode());
			if(editstatus>0){
				setValues(sqldate, getDocno(), "Updated Successfully");
				return "success";
			}
			else if(editstatus==-1){
				setValues(sqldate, getDocno(), "Vehicle Type Already Exists");
				setChkstatus("2");
				return "fail";
			}
			else{
				setValues(sqldate, getDocno(), "Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			int deletestatus=dao.delete(getDocno(),sqldate,getName(),session,getMode(),getFormdetailcode());
			if(deletestatus>0){
				setValues(sqldate, getDocno(), "Successfully Deleted");
				setDeleted("DELETED");
				return "success";
			}
			else if(deletestatus<0){
				setValues(sqldate, getDocno(), "References Present in Other Documents");
				return "fail";
			}
			else{
				setValues(sqldate, getDocno(), "Not Deleted");
				return "fail";
			}
		}
		return "fail";
	}
}
