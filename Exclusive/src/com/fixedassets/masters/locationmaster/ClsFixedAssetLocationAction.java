package com.fixedassets.masters.locationmaster;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

public class ClsFixedAssetLocationAction extends ActionSupport{

	ClsCommon ClsCommon=new ClsCommon();

	
	ClsFixedAssetLocationDAO gmDAO=new ClsFixedAssetLocationDAO();
	ClsFixedAssetLocationBean bean;
	
	private String flmdate;
	private int docno;
	private String flmcode;
	private String flmname;
	
	private String mode;
	private String msg;
	private String deleted;
	
	
	
	
	public String getFlmdate() {
		return flmdate;
	}
	public void setFlmdate(String flmdate) {
		this.flmdate = flmdate;
	}
	public String getFlmcode() {
		return flmcode;
	}
	public void setFlmcode(String flmcode) {
		this.flmcode = flmcode;
	}
	public String getFlmname() {
		return flmname;
	}
	public void setFlmname(String flmname) {
		this.flmname = flmname;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
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
	
	
	public String saveActionloc() throws SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		String formcode="";
		int val=0;
		String reslt="";
		
		if(mode.equals("A")){
			
			String flm_name=getFlmname();
     	   String flm_code=getFlmcode();
     	   
     	   
     	   System.out.println("===getFlmname()==="+getFlmname()+"===getFlmcode()==="+getFlmcode());
     	   
     	   java.sql.Date sqlDate = ClsCommon.changeStringtoSqlDate(getFlmdate());
     	  int result=gmDAO.insert(flm_name,flm_code,sqlDate,session,mode);
			
			if(result>0){
				setData(result);
				reslt="success";
				setMsg("Successfully Saved");
			}
			else{
				reslt="fail";
				setMsg("Not Saved");
			}
		}
		
		else if(mode.equals("E")){
			
			String flm_name=getFlmname();
     	   String flm_code=getFlmcode();
     	   java.sql.Date sqlDate = ClsCommon.changeStringtoSqlDate(getFlmdate());
     	  int result=gmDAO.edit(flm_name,flm_code,sqlDate,session,mode,getDocno());
			
			if(result>0){
				setData(result);
				reslt="success";
				setMsg("Updated Successfully");
			}
			else{
				reslt="fail";
				setMsg("Not Saved");
			}
		}
		
else if(mode.equals("D")){
			
			String flm_name=getFlmname();
     	   String flm_code=getFlmcode();
     	   java.sql.Date sqlDate = ClsCommon.changeStringtoSqlDate(getFlmdate());
     	  int result=gmDAO.delete(flm_name,flm_code,sqlDate,session,mode,getDocno());
			
			if(result>0){
				setData(result);
				reslt="success";
				setMsg("Deleted Successfully");
			}
			else{
				reslt="fail";
				setMsg("Not Saved");
			}
		}
		
		
		return reslt;
		
		
	}
	
	
	public void setData(int docno){
		
		setDocno(docno);
		setFlmcode(getFlmcode());
		setFlmname(getFlmname());
		setFlmdate(getFlmdate());
	}
	

	}
