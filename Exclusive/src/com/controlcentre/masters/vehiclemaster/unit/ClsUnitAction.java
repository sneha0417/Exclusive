package com.controlcentre.masters.vehiclemaster.unit;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

public class ClsUnitAction extends ActionSupport{
	ClsUnitDAO unitDAO= new ClsUnitDAO();
	ClsUnitBean bean;
private int docno;
private String unit;
private String unitdesc;
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
public int getDocno() {
	return docno;
}
public void setDocno(int docno) {
	this.docno = docno;
}
public String getUnit() {
	return unit;
}
public void setUnit(String unit) {
	this.unit = unit;
}
public String getUnitdesc() {
	return unitdesc;
}
public void setUnitdesc(String unitdesc) {
	this.unitdesc = unitdesc;
}
public String saveAction() throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
//	System.out.println("hhhhhhhhhhhhhhhhheeeeeeeeeee"+getMode());

	session.getAttribute("BranchName");
//	System.out.println("sessoin"+session.getAttribute("BRANCHSELECTED"));
//	System.out.println("sessoin"+session.getAttribute("COMPANYNAME"));
	//System.out.println("request==="+request.getAttribute("BranchName"));
	
	String mode=getMode();
	ClsUnitBean bean=new ClsUnitBean();
//	String startDate=getDate_brand();
//	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
//	java.util.Date date = sdf1.parse(startDate);
//	java.sql.Date sqlStartDate = new java.sql.Date(date.getTime()); 
	
//	Date trail=getDate_plateCode();
	//String startDate=getModeldate();
	
	if(mode.equalsIgnoreCase("A")){
					int val=unitDAO.insert(getUnit(),getUnitdesc(),session,getMode(),getFormdetailcode());
					if(val>0.0){
						setUnit(getUnit());
						setUnitdesc(getUnitdesc());
						setMode(getMode());
//						System.out.println(val);
						setDocno(val);
						setMsg("Successfully Saved");

						return "success";
					}
					else if(val==-1){
						setUnit(getUnit());
						setUnitdesc(getUnitdesc());
						setMode(getMode());
//						System.out.println(val);
						//setDocno(val);
						setChkstatus("1");
						setMsg("Unit Already Exists");
						return "fail";
					}
					else{
						setUnit(getUnit());
						setUnitdesc(getUnitdesc());
						setMode(getMode());
//						System.out.println(val);
						setDocno(val);
						setMsg("Not Saved");
						return "fail";
					}
	}


	else if(mode.equalsIgnoreCase("E")){
			int Status=unitDAO.edit(getUnit().trim(),getDocno(),getUnitdesc(),getMode(),session,getFormdetailcode());
			if(Status>0){
				
				//System.out.println("hhhhhhhhhhhhhhhhheeeeeeeeeee"+getMode()+","+getModeldate());
				session.getAttribute("BranchName");
				setUnit(getUnit());
				setDocno(getDocno());
				setUnitdesc(getUnitdesc());
				setMode(getMode());
				setMsg("Updated Successfully");

				return "success";
			}
			else if(Status==-1){
				setUnit(getUnit());
				setDocno(getDocno());
				setUnitdesc(getUnitdesc());
				setMode(getMode());
				setChkstatus("2");
				setMsg("Unit Already Exists");
				return "fail";
			}
			else{
				setUnit(getUnit());
				setDocno(getDocno());
				setUnitdesc(getUnitdesc());
				setMode(getMode());
				setMsg("Not Updated");

				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
//			System.out.println(getDocno()+","+getUnit()+","+getUnitdesc());
			boolean Status=unitDAO.delete(getUnit(),getDocno(),getUnitdesc(),getMode(),session,getFormdetailcode());
		if(Status){
			setUnit(getUnit());
			setDocno(getDocno());
			setUnitdesc(getUnitdesc());
			setDeleted("DELETED");
			setMsg("Successfully Deleted");

			return "success";
		}
		else{
			setUnit(getUnit());
			setDocno(getDocno());
			setUnitdesc(getUnitdesc());
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
			  List <ClsUnitBean> list= unitDAO.list();
			  for(ClsUnitBean bean:list){
			  cellobj = new JSONObject();
			  cellobj.put("DOC_NO", bean.getDocno());
			  cellobj.put("unit",bean.getUnit());
			  cellobj.put("unit_desc", bean.getUnitdesc());
			 cellarray.add(cellobj);

			 }
//				 System.out.println("cellobj"+cellarray);
		  } catch (SQLException e) {
		  }
		return cellarray;
	}
	
}


