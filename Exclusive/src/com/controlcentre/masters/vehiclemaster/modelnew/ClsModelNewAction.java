package com.controlcentre.masters.vehiclemaster.modelnew;
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
import com.controlcentre.masters.vehiclemaster.platecode.ClsPlateCodeBean;

public class ClsModelNewAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
	ClsModelNewDAO modelDAO= new ClsModelNewDAO();
	ClsModelNewBean bean;
private int docno;
private String mode;
private String deleted;
private String model; 
private String modeldate;
private String brand;
private String brandid;
private String msg;
private String formdetailcode;
private String formdetail;
private String chkstatus;
private String cmbvehtype,hidcmbvehtype,cmbdoor,cmbseat,cmbluggage,cmbpassengers,cmbac,hidcmbdoor,hidcmbseat,hidcmbluggage,hidcmbpassengers,hidcmbac;


public String getHidcmbdoor() {
	return hidcmbdoor;
}
public void setHidcmbdoor(String hidcmbdoor) {
	this.hidcmbdoor = hidcmbdoor;
}
public String getHidcmbseat() {
	return hidcmbseat;
}
public void setHidcmbseat(String hidcmbseat) {
	this.hidcmbseat = hidcmbseat;
}
public String getHidcmbluggage() {
	return hidcmbluggage;
}
public void setHidcmbluggage(String hidcmbluggage) {
	this.hidcmbluggage = hidcmbluggage;
}
public String getHidcmbpassengers() {
	return hidcmbpassengers;
}
public void setHidcmbpassengers(String hidcmbpassengers) {
	this.hidcmbpassengers = hidcmbpassengers;
}
public String getHidcmbac() {
	return hidcmbac;
}
public void setHidcmbac(String hidcmbac) {
	this.hidcmbac = hidcmbac;
}
public String getCmbvehtype() {
	return cmbvehtype;
}
public void setCmbvehtype(String cmbvehtype) {
	this.cmbvehtype = cmbvehtype;
}
public String getHidcmbvehtype() {
	return hidcmbvehtype;
}
public void setHidcmbvehtype(String hidcmbvehtype) {
	this.hidcmbvehtype = hidcmbvehtype;
}
public String getCmbdoor() {
	return cmbdoor;
}
public void setCmbdoor(String cmbdoor) {
	this.cmbdoor = cmbdoor;
}
public String getCmbseat() {
	return cmbseat;
}
public void setCmbseat(String cmbseat) {
	this.cmbseat = cmbseat;
}
public String getCmbluggage() {
	return cmbluggage;
}
public void setCmbluggage(String cmbluggage) {
	this.cmbluggage = cmbluggage;
}
public String getCmbpassengers() {
	return cmbpassengers;
}
public void setCmbpassengers(String cmbpassengers) {
	this.cmbpassengers = cmbpassengers;
}
public String getCmbac() {
	return cmbac;
}
public void setCmbac(String cmbac) {
	this.cmbac = cmbac;
}
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
public String getBrandid() {
	return brandid;
}
public void setBrandid(String brandid) {
	this.brandid = brandid;
}
public String getModel() {
	return model;
}
public void setModel(String model) {
	this.model = model;
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

public String getModeldate() {
	return modeldate;
}
public void setModeldate(String modeldate) {
	this.modeldate = modeldate;
}
public String getBrand() {
	return brand;
}
public void setBrand(String brand) {
	this.brand = brand;
}
public String getDeleted() {
	return deleted;
}
public void setDeleted(String deleted) {
	this.deleted = deleted;
}
public void setValues(java.sql.Date sqldate,int docno,String msg){
	setModel(getModel());
	setBrandid(getBrand());
	setModeldate(sqldate.toString());
	setMode(getMode());
	setDocno(docno);
	setCmbvehtype(getCmbvehtype());
	setHidcmbvehtype(getCmbvehtype());
	setCmbac(getCmbac());
	setCmbdoor(getCmbdoor());
	setCmbseat(getCmbseat());
	setCmbluggage(getCmbluggage());
	setCmbpassengers(getCmbpassengers());
	setHidcmbac(getCmbac());
	setHidcmbdoor(getCmbdoor());
	setHidcmbseat(getCmbseat());
	setHidcmbluggage(getCmbluggage());
	setHidcmbpassengers(getCmbpassengers());
	setMsg(msg);
}
public String saveAction() throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	session.getAttribute("BranchName");
	String mode=getMode();
	ClsModelNewBean bean=new ClsModelNewBean();
	java.sql.Date sqlStartDate=null;
	if((mode.equalsIgnoreCase("A"))||(mode.equalsIgnoreCase("E"))){
		sqlStartDate = ClsCommon.changeStringtoSqlDate(getModeldate());
	}
	if(mode.equalsIgnoreCase("A")){
		int val=modelDAO.insert(getModel(),getBrand(),sqlStartDate,session,getMode(),getFormdetailcode(),getCmbvehtype(),getCmbdoor(),getCmbseat(),getCmbluggage(),getCmbpassengers(),getCmbac());
		if(val>0.0){
			setValues(sqlStartDate, val, "Successfully Saved");
			return "success";
		}
		else if(val==-1){
			setValues(sqlStartDate, val, "Model Already Exists");
			setChkstatus("1");
			return "fail";
		}
		else{
			setValues(sqlStartDate, val, "Not Saved");
			return "fail";
		}
	}


	else if(mode.equalsIgnoreCase("E")){
		int Status=modelDAO.edit(getModel(),getDocno(),sqlStartDate,getBrand(),getMode(),session,getFormdetailcode(),getCmbvehtype(),getCmbdoor(),getCmbseat(),getCmbluggage(),getCmbpassengers(),getCmbac());
		if(Status>0){
			setValues(sqlStartDate, getDocno(), "Updated Successfully");
			return "success";
			}
			else if(Status==-1){
				setValues(sqlStartDate, getDocno(), "Model Already Exists");
				setChkstatus("2");
				return "fail";
			}
			else{
				setValues(sqlStartDate, getDocno(),"Not Updated");
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			int Status=modelDAO.delete(getModel(),getDocno(),sqlStartDate,getBrand(),getMode(),session,getFormdetailcode());
			if(Status>0){
				setValues(sqlStartDate, getDocno(),"Successfully Deleted");
				setDeleted("DELETED");
				return "success";
			}
			else if(Status==-2){
				setValues(sqlStartDate, getDocno(),"References Present in Other Documents");
				return "fail";
			}
			else{
				setValues(sqlStartDate, getDocno(),"Not Deleted");
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
			  List <ClsModelNewBean> list= modelDAO.list();
			  for(ClsModelNewBean bean:list){
			  cellobj = new JSONObject();
			  cellobj.put("DOC_NO", bean.getDocno());
			  cellobj.put("vtype",bean.getModel());
			  cellobj.put("date",((bean.getModeldate()==null) ? "NA" : bean.getModeldate().toString()));
			  cellobj.put("brand_name",bean.getBrand());
			  cellobj.put("brandid",bean.getBrandid());
			  cellarray.add(cellobj);

			 }
//				 System.out.println("cellobj"+cellarray);
		  } catch (SQLException e) {
		  }
		return cellarray;
	}
	
}
