package com.controlcentre.masters.vehiclemaster.model;
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

public class ClsModelAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
	ClsModelDAO modelDAO= new ClsModelDAO();
	ClsModelBean bean;
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

public String saveAction() throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
//	System.out.println("hhhhhhhhhhhhhhhhheeeeeeeeeee"+getMode()+","+getModeldate());

	session.getAttribute("BranchName");
//	System.out.println("sessoin"+session.getAttribute("BRANCHSELECTED"));
//	System.out.println("sessoin"+session.getAttribute("COMPANYNAME"));
	//System.out.println("request==="+request.getAttribute("BranchName"));
	
	String mode=getMode();
	ClsModelBean bean=new ClsModelBean();
//	String startDate=getDate_brand();
//	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
//	java.util.Date date = sdf1.parse(startDate);
//	java.sql.Date sqlStartDate = new java.sql.Date(date.getTime()); 
	
//	Date trail=getDate_plateCode();
	java.sql.Date sqlStartDate=null;
	if((mode.equalsIgnoreCase("A"))||(mode.equalsIgnoreCase("E"))){
		sqlStartDate = ClsCommon.changeStringtoSqlDate(getModeldate());

	}
//	System.out.println(sqlStartDate);
	if(mode.equalsIgnoreCase("A")){
					int val=modelDAO.insert(getModel(),getBrand(),sqlStartDate,session,getMode(),getFormdetailcode());
					if(val>0.0){
						setModel(getModel());
						setBrandid(getBrand());
						setModeldate(sqlStartDate.toString());
						setMode(getMode());
//						System.out.println(val);
						setDocno(val);
						setMsg("Successfully Saved");
						return "success";
					}
					else if(val==-1){
						setModel(getModel());
						setBrandid(getBrand());
						setModeldate(sqlStartDate.toString());
						setMode(getMode());
//						System.out.println(val);
						//setDocno(val);
						setChkstatus("1");
						setMsg("Model Already Exists");
						return "fail";
					}
					else{
						setModel(getModel());
						setBrandid(getBrand());
						setModeldate(sqlStartDate.toString());
						setMode(getMode());
//						System.out.println(val);
						setDocno(val);
						setMsg("Not Saved");
						return "fail";
					}
	}


	else if(mode.equalsIgnoreCase("E")){
			int Status=modelDAO.edit(getModel(),getDocno(),sqlStartDate,getBrand(),getMode(),session,getFormdetailcode());
			if(Status>0){
				
				setModel(getModel());
				setModeldate(getModeldate());
				setDocno(getDocno());
				setBrandid(getBrand());
//				System.out.println("Action"+getBrandid());
				setMode(getMode());
				setMsg("Updated Successfully");

				return "success";
			}
			else if(Status==-1){
				setModel(getModel());
				setModeldate(getModeldate());
				setDocno(getDocno());
				setBrandid(getBrand());
//				System.out.println("Action"+getBrandid());
				//setMode(getMode());
				setChkstatus("2");
				setMsg("Model Already Exists");
				return "fail";
			}
			else{
				setModel(getModel());
				setModeldate(getModeldate());
				setDocno(getDocno());
				setBrandid(getBrand());
//				System.out.println("Action"+getBrandid());
				setMode(getMode());
				setMsg("Not Updated");

				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
//			System.out.println(getDocno()+","+getBrandid()+","+getModeldate());
			int Status=modelDAO.delete(getModel(),getDocno(),sqlStartDate,getBrand(),getMode(),session,getFormdetailcode());
		if(Status>0){
			setModel(getModel());
			setModeldate(getModeldate());
			setDocno(getDocno());
			setBrandid(getBrand());
			setBrand(getBrand());
			setDeleted("DELETED");
			setMsg("Successfully Deleted");

			return "success";
		}
		else if(Status==-2){
			setModel(getModel());
			setModeldate(getModeldate());
			setDocno(getDocno());
			setBrandid(getBrand());
			setBrand(getBrand());
			setMsg("References Present in Other Documents");
			return "fail";
		}
		else{
			setModel(getModel());
			setModeldate(getModeldate());
			setDocno(getDocno());
			setBrandid(getBrand());
			setBrand(getBrand());
			setMsg("Not Deleted");

			return "fail";
		}
		}
		return "fail";
	}

	public String getDeleted() {
	return deleted;
}
public void setDeleted(String deleted) {
	this.deleted = deleted;
}
	public  JSONArray searchDetails(){
		  JSONArray cellarray = new JSONArray();
		  JSONObject cellobj = null;
		  try {
			  List <ClsModelBean> list= modelDAO.list();
			  for(ClsModelBean bean:list){
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
