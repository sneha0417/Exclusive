package com.fixedassets.masters.groupmaster;

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

public class ClsFixedAssetGroupAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();

	
	ClsFixedAssetGroupDAO gmDAO=new ClsFixedAssetGroupDAO();
	ClsFixedAssetGroupBean bean;
	
	private String fgmdate;
	private int docno;
	private String fgmcode;
	private String fgmname;
	
	private String mode;
	private String msg;
	private String deleted;
	
	
	
	public String getFgmdate() {
		return fgmdate;
	}
	public void setFgmdate(String fgmdate) {
		this.fgmdate = fgmdate;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getFgmcode() {
		return fgmcode;
	}
	public void setFgmcode(String fgmcode) {
		this.fgmcode = fgmcode;
	}
	public String getFgmname() {
		return fgmname;
	}
	public void setFgmname(String fgmname) {
		this.fgmname = fgmname;
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
	
	
	public String saveAction() throws SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		String formcode="";
		int val=0;
		String reslt="";
		
		if(mode.equals("A")){
			
			String fgm_name=getFgmname();
     	   String fgm_code=getFgmcode();
     	   java.sql.Date sqlDate = ClsCommon.changeStringtoSqlDate(getFgmdate());
     	  int result=gmDAO.insert(fgm_name,fgm_code,sqlDate,session,mode);
			
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
			
			String fgm_name=getFgmname();
     	   String fgm_code=getFgmcode();
     	   java.sql.Date sqlDate = ClsCommon.changeStringtoSqlDate(getFgmdate());
     	  int result=gmDAO.edit(fgm_name,fgm_code,sqlDate,session,mode,getDocno());
			
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
			
			String fgm_name=getFgmname();
     	   String fgm_code=getFgmcode();
     	   java.sql.Date sqlDate = ClsCommon.changeStringtoSqlDate(getFgmdate());
     	  int result=gmDAO.delete(fgm_name,fgm_code,sqlDate,session,mode,getDocno());
			
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
		setFgmcode(getFgmcode());
		setFgmname(getFgmname());
		setFgmdate(getFgmdate());
	}
	

	}
