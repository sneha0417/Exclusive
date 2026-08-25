package com.humanresource.setup.hrsetup.leavesetup;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

 



import org.apache.struts2.ServletActionContext;
 

public class ClsLeavesetupAction {

	ClsLeavesetupDAO saveDAO= new ClsLeavesetupDAO()	;
	
	private String mode,msg,deleted,formdetailcode,category,newmode,hidshowlabel ;
	private int algridlength,refno,catid,leaveid;
 
	public String getHidshowlabel() {
		return hidshowlabel;
	}
	public void setHidshowlabel(String hidshowlabel) {
		this.hidshowlabel = hidshowlabel;
	}
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
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public int getRefno() {
		return refno;
	}
	public void setRefno(int refno) {
		this.refno = refno;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {       
		this.category = category;
	}
	public int getCatid() {
		return catid;
	}
	public void setCatid(int catid) {
		this.catid = catid;
	}
	public int getAlgridlength() {
		return algridlength;
	}
	public void setAlgridlength(int algridlength) {
		this.algridlength = algridlength;
	}
	public String getNewmode() {
		return newmode;
	}
	public void setNewmode(String newmode) {
		this.newmode = newmode;
	}
	public int getLeaveid() {
		return leaveid;
	}
	public void setLeaveid(int leaveid) {
		this.leaveid = leaveid;
	}
	
	public String saveAction() throws SQLException {
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	Map<String, String[]> requestParams = request.getParameterMap();
	
	ArrayList<String> mainarray= new ArrayList<>();
	for(int i=0;i<1;i++){
		String temp3=requestParams.get("leavetest"+i)[0];
		mainarray.add(temp3);
	}

	ArrayList<String> subarray= new ArrayList<>();
	for(int i=0;i<getAlgridlength() ;i++){
		String temp4=requestParams.get("condtest"+i)[0];
		subarray.add(temp4);
	}
 
		int val=saveDAO.insert(getRefno(),getCatid(),getMode(),getFormdetailcode(),session,request,mainarray,subarray);
		
		if(val>0) {
			
			setRefno(getRefno());
			setCategory(getCategory());
			setCatid(getCatid());
			setLeaveid(val);
			setHidshowlabel(getHidshowlabel());
			
			setNewmode("Saved");
			return "success";
		} else {
			 
			setRefno(getRefno());
			setCategory(getCategory());
			setCatid(getCatid());
			setLeaveid(0);
			setHidshowlabel(getHidshowlabel());
			
			setNewmode("notSaved");
			return "fail";
		}
	}
}
