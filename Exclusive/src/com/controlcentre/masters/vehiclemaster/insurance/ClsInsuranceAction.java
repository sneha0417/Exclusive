package com.controlcentre.masters.vehiclemaster.insurance;
import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.common.ClsCommon;
import com.controlcentre.masters.vehiclemaster.insurance.ClsInsuranceBean;
import com.controlcentre.masters.vehiclemaster.insurance.ClsInsuranceDAO;

public class ClsInsuranceAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
	ClsInsuranceDAO insuranceDAO= new ClsInsuranceDAO();
	ClsInsuranceBean bean;
private int docno;
private String insurdate;
private String insurvalidfrom;
private String insurvalidto;
private double premium;
private double exchg;
private String mode;
private String deleted;
private String utype;
private String insurtype;
private String policyno;
private String insurcompany;
private String insurdatehidden;
private String insurvalidfromhidden;
private String insurvalidtohidden;
private String hidinsurtype;
private String hidutype;
private String txtaccname;
private int txtaccno;
private String msg;
private String formdetailcode;
private String formdetail;
private String chkstatus;


public String getChkstatus() {
	return chkstatus;
}
public void setChkstatus(String chkstatus) {
	this.chkstatus = chkstatus;
}
public String getFormdetailcode() {
	return formdetailcode;
}
public void setFormdetailcode(String formdetailcode) {
	this.formdetailcode = formdetailcode;
}
public String getFormdetail() {
	return formdetail;
}
public void setFormdetail(String formdetail) {
	this.formdetail = formdetail;
}
public String getMsg() {
	return msg;
}
public void setMsg(String msg) {
	this.msg = msg;
}
public String getTxtaccname() {
	return txtaccname;
}
public void setTxtaccname(String txtaccname) {
	this.txtaccname = txtaccname;
}
public int getTxtaccno() {
	return txtaccno;
}
public void setTxtaccno(int txtaccno) {
	this.txtaccno = txtaccno;
}
public String getHidinsurtype() {
	return hidinsurtype;
}
public void setHidinsurtype(String hidinsurtype) {
	this.hidinsurtype = hidinsurtype;
}
public String getHidutype() {
	return hidutype;
}
public void setHidutype(String hidutype) {
	this.hidutype = hidutype;
}
public String getInsurdatehidden() {
	return insurdatehidden;
}
public void setInsurdatehidden(String insurdatehidden) {
	this.insurdatehidden = insurdatehidden;
}
public String getInsurvalidfromhidden() {
	return insurvalidfromhidden;
}
public void setInsurvalidfromhidden(String insurvalidfromhidden) {
	this.insurvalidfromhidden = insurvalidfromhidden;
}
public String getInsurvalidtohidden() {
	return insurvalidtohidden;
}
public void setInsurvalidtohidden(String insurvalidtohidden) {
	this.insurvalidtohidden = insurvalidtohidden;
}
public String getInsurcompany() {
	return insurcompany;
}
public void setInsurcompany(String insurcompany) {
	this.insurcompany = insurcompany;
}
public int getDocno() {
	return docno;
}
public void setDocno(int docno) {
	this.docno = docno;
}
public String getInsurdate() {
	return insurdate;
}
public void setInsurdate(String insurdate) {
	this.insurdate = insurdate;
}
public String getInsurvalidfrom() {
	return insurvalidfrom;
}
public void setInsurvalidfrom(String insurvalidfrom) {
	this.insurvalidfrom = insurvalidfrom;
}
public String getInsurvalidto() {
	return insurvalidto;
}
public void setInsurvalidto(String insurvalidto) {
	this.insurvalidto = insurvalidto;
}
public double getPremium() {
	return premium;
}
public void setPremium(double premium) {
	this.premium = premium;
}
public double getExchg() {
	return exchg;
}
public void setExchg(double exchg) {
	this.exchg = exchg;
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
public String getUtype() {
	return utype;
}
public void setUtype(String utype) {
	this.utype = utype;
}
public String getInsurtype() {
	return insurtype;
}
public void setInsurtype(String insurtype) {
	this.insurtype = insurtype;
}
public String getPolicyno() {
	return policyno;
}
public void setPolicyno(String policyno) {
	this.policyno = policyno;
}
public String saveAction() throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	//System.out.println("hhhhhhhhhhhhhhhhheeeeeeeeeee"+getMode()+","+getModeldate());

	session.getAttribute("BranchName");
//	System.out.println("sessoin"+session.getAttribute("BRANCHSELECTED"));
//	System.out.println("sessoin"+session.getAttribute("COMPANYNAME"));
	//System.out.println("request==="+request.getAttribute("BranchName"));
	
	String mode=getMode();
	ClsInsuranceBean bean=new ClsInsuranceBean();
	java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getInsurdate());

	
	if(mode.equalsIgnoreCase("A")){
//		System.out.println("inside a");
					int val=insuranceDAO.insert(getInsurcompany(),sqlStartDate,getTxtaccno(),session,getMode(),getFormdetailcode());
					if(val>0.0){
						//setDealerid(getDealerid());
						setInsurcompany(getInsurcompany());
						
						//setInsurdate(getInsurdatehidden());
						setInsurdate(getInsurdate());
						setInsurdatehidden(sqlStartDate.toString());
						setTxtaccname(getTxtaccname());
						setTxtaccno(getTxtaccno());
						setMode(getMode());
//						System.out.println(val);
						setDocno(val);
						setMsg("Successfully Saved");

						return "success";
					}
					else if(val==-1){
						setInsurcompany(getInsurcompany());
						setInsurdate(getInsurdate());
						setInsurdatehidden(sqlStartDate.toString());
						setTxtaccname(getTxtaccname());
						setTxtaccno(getTxtaccno());
						setMode(getMode());
//						System.out.println(val);
						setChkstatus("1");
						//setDocno(val);
						setMsg("Insurance Already Exists");
						return "fail";
					}
					else{
						setInsurcompany(getInsurcompany());
						setInsurdate(getInsurdate());
						setInsurdatehidden(sqlStartDate.toString());
						setTxtaccname(getTxtaccname());
						setTxtaccno(getTxtaccno());
						setMode(getMode());
//						System.out.println(val);
						setDocno(val);
						setMsg("Not Saved");
						return "fail";
					}
	}


	else if(mode.equalsIgnoreCase("E")){
			int Status=insuranceDAO.edit(getInsurcompany(),sqlStartDate,getTxtaccno(),session,getMode(),getDocno(),getFormdetailcode());
			if(Status>0){
				setInsurcompany(getInsurcompany());
				setMode(getMode());
				setInsurdatehidden(sqlStartDate.toString());
				setInsurvalidtohidden(getInsurvalidto());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				setDocno(getDocno());
				setMode(getMode());
//				System.out.println("brand"+brand);
				setMsg("Updated Successfully");

				return "success";
			}
			else if(Status==-1){
				setInsurcompany(getInsurcompany());
				setMode(getMode());
				setInsurdatehidden(sqlStartDate.toString());
				setInsurvalidtohidden(getInsurvalidto());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				setDocno(getDocno());
				setChkstatus("2");
				setMode(getMode());
				setMsg("Insurance Already Exists");
				return "fail";
			}
			else{
				setInsurcompany(getInsurcompany());
				setMode(getMode());
				setInsurdatehidden(sqlStartDate.toString());
				setInsurvalidtohidden(getInsurvalidto());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				setDocno(getDocno());
				setMode(getMode());
				setMsg("Updated Successfully");

				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			//System.out.println(getDocno()+","+getBrandid()+","+getModeldate());
			int Status=insuranceDAO.delete(getInsurcompany(),sqlStartDate,getTxtaccno(),session,getMode(),getDocno(),getFormdetailcode());
		if(Status>0){
			//setDealerid(getDealerid());
			setDocno(getDocno());
			setInsurcompany(getInsurcompany());
			setMode(getMode());
			setInsurdatehidden(sqlStartDate.toString());
			setTxtaccname(getTxtaccname());
			setTxtaccno(getTxtaccno());
			setDeleted("DELETED");
			setMsg("Successfully Deleted");

			return "success";
		}
		else if(Status==-2){
			setDocno(getDocno());
			setInsurcompany(getInsurcompany());
			setMode(getMode());
			setInsurdatehidden(sqlStartDate.toString());
			setTxtaccname(getTxtaccname());
			setTxtaccno(getTxtaccno());
			setMsg("References Present in Other Documents");
			return "fail";
		}
		else{
			setDocno(getDocno());
			setInsurcompany(getInsurcompany());
			setMode(getMode());
			setInsurdatehidden(sqlStartDate.toString());
			setTxtaccname(getTxtaccname());
			setTxtaccno(getTxtaccno());
//			System.out.println("STATUS DELETE"+Status);
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
			  List <ClsInsuranceBean> list= insuranceDAO.list();
			  for(ClsInsuranceBean bean:list){
			  cellobj = new JSONObject();
			  cellobj.put("doc_no", bean.getDocno());
			  cellobj.put("inname",bean.getInsurcompany());
			  cellobj.put("date",((bean.getInsurdate()==null) ? "NA" : bean.getInsurdate().toString()));

			 cellobj.put("description", bean.getTxtaccname());
			 cellobj.put("acc_no", bean.getTxtaccno());
			  cellarray.add(cellobj);

			 }
//				 System.out.println("cellobj"+cellarray);
		  } catch (SQLException e) {
			  e.printStackTrace();
		  }
		return cellarray;
	}
	
}





