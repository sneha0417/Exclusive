package com.controlcentre.masters.vehiclemaster.brand;

import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.common.ClsCommon;

@SuppressWarnings("serial")
public class ClsBrandAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();

	ClsBrandDAO brandDAO= new ClsBrandDAO();
	ClsBrandBean bean;
	private int docno;
	private String brand;
	private String date_brand;
	private String mode;
	private String deleted;
	private Date datehidden;
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
	public ClsBrandBean getBean() {
		return bean;
	}
	public void setBean(ClsBrandBean bean) {
		this.bean = bean;
	}
	 public String getDate_brand() {
		return date_brand;
	}
	public void setDate_brand(String date_brand) {
		this.date_brand = date_brand;
	}
	public int  getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
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
	public Date getDatehidden() {
		return datehidden;
	}
	public void setDatehidden(Date datehidden) {
		this.datehidden = datehidden;
	}


	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		
		String mode=getMode();
		ClsBrandBean bean=new ClsBrandBean();

		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getDate_brand());
//		System.out.println("date"+sqlStartDate);
//		System.out.println(getMode());
		if(mode.equalsIgnoreCase("A")){
//			System.out.println("date---"+sqlStartDate);
						int val=brandDAO.insert(sqlStartDate,getBrand(),getMode(),session,getFormdetailcode());
						if(val>0){
							setDatehidden(sqlStartDate);
							setBrand(getBrand());
							setDocno(val);
							//session.setAttribute("SAVED", "SUCCESSFULLY SAVED");
							setMsg("Successfully Saved");
							addActionMessage("Saved Successfully");
//							System.out.println(session.getAttribute("SAVED"));
							return "success";
						}
						else if(val==-1){
							setDatehidden(sqlStartDate);
							setBrand(getBrand());
							setChkstatus("1");
							setMsg("Brand Already Exists");
							//request.setAttribute("SAVED", "Not Saved");
							//addActionError("Not Saved");
							return "fail";
						}
						else{
							setDatehidden(sqlStartDate);
							setBrand(getBrand());
							setMsg("Not Saved");
							return "fail";
						}
		}
		else if(mode.equalsIgnoreCase("E")){
			int Status=brandDAO.edit(getDocno(),(Date)sqlStartDate,getBrand(),session,getFormdetailcode());
			if(Status>0){
				setDatehidden(sqlStartDate);
				setBrand(getBrand());
				setDocno(getDocno());
				setMsg("Updated Successfully");
				return "success";
			}
			else if(Status==-1){
				setDatehidden(sqlStartDate);
				setBrand(getBrand());
				setDocno(getDocno());
				setChkstatus("2");

				setMsg("Brand Already Exists");
				return "fail";

			}
			else{
				setDatehidden(sqlStartDate);
				setBrand(getBrand());
				setDocno(getDocno());
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			int Status=brandDAO.delete(getDocno(),session,getBrand(),getFormdetailcode());
		if(Status>0){
			setDatehidden(sqlStartDate);
			setBrand(getBrand());
			setDocno(getDocno());
			setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
		}
		else if(Status==-2){
			setDatehidden(sqlStartDate);
			setBrand(getBrand());
			setDocno(getDocno());
			setMsg("References Present in Other Documents");
			return "fail";
		}
		else{
			setDatehidden(sqlStartDate);
			setBrand(getBrand());
			setDocno(getDocno());
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
			  List <ClsBrandBean> list = brandDAO.list();
			  for(ClsBrandBean bean:list){
					  cellobj = new JSONObject();
					  cellobj.put("DOC_NO", bean.getDocno());
					  cellobj.put("BRAND_NAME",bean.getBrand());
					  cellobj.put("DATE",((bean.getDate_brand()==null) ? "NA" : bean.getDate_brand().toString()));
					  cellarray.add(cellobj);
			 }
//				 System.out.println("cellobj"+cellarray);
		  } catch (SQLException e) {
		  }
		return cellarray;
	}
	
	public void validate(){
//		System.out.println("validdate");
		if(getDocno()==0){
//			System.out.println("validdate  sucess");
			addActionMessage("Got It");
		}
		else{
//			System.out.println("validdate  else");
			addActionError("Got error");
		}
	}
}
