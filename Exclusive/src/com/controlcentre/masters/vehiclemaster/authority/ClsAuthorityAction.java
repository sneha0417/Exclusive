package com.controlcentre.masters.vehiclemaster.authority;
import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.common.ClsCommon;
import com.controlcentre.masters.vehiclemaster.authority.ClsAuthorityBean;

@SuppressWarnings("serial")
public class ClsAuthorityAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
	ClsAuthorityDAO authorityDAO= new ClsAuthorityDAO();
	ClsAuthorityBean bean;
private int docno;
private String authdatehidden;
private String auth;
private String authname;
private String authdate;
private String mode;
private String deleted;
private String msg;
private String formdetail;
private String formdetailcode;
private String chkstatus;


public String getChkstatus() {
	return chkstatus;
}
public void setChkstatus(String chkstatus) {
	this.chkstatus = chkstatus;
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
public String getMsg() {
	return msg;
}
public void setMsg(String msg) {
	this.msg = msg;
}
public String getAuthdatehidden() {
	return authdatehidden;
}
public void setAuthdatehidden(String authdatehidden) {
	this.authdatehidden = authdatehidden;
}


public int getDocno() {
	return docno;
}
public void setDocno(int docno) {
	this.docno = docno;
}
public String getAuth() {
	return auth;
}
public void setAuth(String auth) {
	this.auth = auth;
}
public String getAuthname() {
	return authname;
}
public void setAuthname(String authname) {
	this.authname = authname;
}
public String getAuthdate() {
	return authdate;
}
public void setAuthdate(String authdate) {
	this.authdate = authdate;
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


public String saveAction() throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	//System.out.println("hhhhhhhhhhhhhhhhheeeeeeeeeee"+getMode()+","+getDate_plateCode());

	session.getAttribute("BRANCHID");
	//System.out.println("sessoin"+session.getAttribute("BRANCHSELECTED"));
//	System.out.println("sessoin"+session.getAttribute("COMPANYNAME"));
//	System.out.println("request==="+request.getAttribute("BranchName"));
	
	String mode=getMode();
	ClsAuthorityBean bean=new ClsAuthorityBean();
//	String startDate=getDate_brand();
//	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
//	java.util.Date date = sdf1.parse(startDate);
//	java.sql.Date sqlStartDate = new java.sql.Date(date.getTime()); 
	
//	Date trail=getDate_plateCode();
	java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getAuthdate());

	//System.out.println("aaaaaaa");

	if(mode.equalsIgnoreCase("A")){
					int val=authorityDAO.insert(getAuth(),getAuthname(),sqlStartDate,session,getMode(),getFormdetailcode());
					if(val>0.0){
						setAuth(getAuth());
//						System.out.println(getAuth());
						setMode(getMode());
						setAuthname(getAuthname());
						setAuthdatehidden(sqlStartDate.toString());
//						System.out.println(getAuthname());
//						System.out.println(val);
						setDocno(val);
						setMsg("Successfully Saved");

						return "success";
					}
					else if(val==-1){
						setAuth(getAuth());
//						System.out.println(getAuth());
						setMode(getMode());
						setAuthname(getAuthname());
						setAuthdatehidden(sqlStartDate.toString());
//						System.out.println(getAuthname());
//						System.out.println(val);
						//setDocno(val);
						setChkstatus("1");
						setMsg("Authority Already Exists");
						return "fail";
					}
					else{
						setAuth(getAuth());
//						System.out.println(getAuth());
						setMode(getMode());
						setAuthname(getAuthname());
						setAuthdatehidden(sqlStartDate.toString());
//						System.out.println(getAuthname());
//						System.out.println(val);
						setDocno(val);
						setMsg("Not Saved");
						return "fail";
					}	
	}
	else if(mode.equalsIgnoreCase("E")){
		int Status=authorityDAO.edit(getDocno(),sqlStartDate,getAuth(),getAuthname(),session,getMode(),getFormdetailcode());
		if(Status>0){
			setAuth(getAuth());
			setDocno(getDocno());
			setAuthname(getAuthname());
			setAuthdatehidden(sqlStartDate.toString());
			setMode(getMode());
			//System.out.println("brand"+brand);
			setMsg("Updated Successfully");

			return "success";
		}
		else if(Status==-1){
			setAuth(getAuth());
			setDocno(getDocno());
			setAuthname(getAuthname());
			setAuthdatehidden(sqlStartDate.toString());
			setMode(getMode());
			setChkstatus("2");
			//System.out.println("brand"+brand);
			setMsg("Authority Already Exists");
			return "fail";

		}
		else{
			setAuth(getAuth());
			setDocno(getDocno());
			setAuthname(getAuthname());
			setAuthdatehidden(sqlStartDate.toString());
			setMode(getMode());
			//System.out.println("brand"+brand);
			setMsg("Not Updated");

			return "fail";
		}
	}
	else if(mode.equalsIgnoreCase("D")){
		//System.out.println(getDocno()+","+getBrand()+","+getDate_brand());
		int Status=authorityDAO.delete(getDocno(),sqlStartDate,getAuth(),getAuthname(),session,getMode(),getFormdetailcode());
//		System.out.println("STATUS"+Status);
	if(Status>0){
		//setBra(getBrand());
		setDocno(getDocno());
		setAuth(getAuth());
		setAuthname(getAuthname());
		setAuthdatehidden(sqlStartDate.toString());
		setDeleted("DELETED");
//		System.out.println(getDeleted()+"====Delete");
		setMsg("Successfully Deleted");

		return "success";
	}
	else if(Status<0){
		setDocno(getDocno());
		setAuth(getAuth());
		setAuthname(getAuthname());
		setAuthdatehidden(sqlStartDate.toString());
		setMsg("References Present in Other Documents");
		return "fail";
	}
	else{
		setDocno(getDocno());
		setAuth(getAuth());
		setAuthname(getAuthname());
		setAuthdatehidden(sqlStartDate.toString());
		setMsg("Not Deleted");

		return "fail";
	}
	}
	return "fail";
}

public  JSONArray searchDetails(){
	  JSONArray cellarray = new JSONArray();
	  JSONObject cellobj = null;
	  try {
		  List <ClsAuthorityBean> list= authorityDAO.list();
		  for(ClsAuthorityBean bean:list){
		  cellobj = new JSONObject();
		  cellobj.put("DOC_NO", bean.getDocno());
		  cellobj.put("authname",bean.getAuthname());
		  cellobj.put("date",bean.getAuthdate().toString());
		  cellobj.put("authid", bean.getAuth());
		 cellarray.add(cellobj);

		 }
//		 System.out.println("cellobj"+cellarray);
	  } catch (SQLException e) {
		  e.printStackTrace();
	  }
	return cellarray;
}

}






