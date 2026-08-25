package com.controlcentre.settings.areamaster.area;

import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;



public class ClsAreaAction {
	ClsAreaDAO areaDAO=new ClsAreaDAO();
	ClsCommon com=new ClsCommon();
	
	ClsAreaBean bean;
	
	private int docno;
	private String city;
	private int city_id;
	private String area;
	private String country;
	private int cou_id;
	private String region;
	private int reg_id;
	private String date_area;
	private String mode;
	private String deleted;
	private String datehidden;
	private String msg;
	
	
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public int getCity_id() {
		return city_id;
	}
	public void setCity_id(int city_id) {
		this.city_id = city_id;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public int getCou_id() {
		return cou_id;
	}
	public void setCou_id(int cou_id) {
		this.cou_id = cou_id;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public int getReg_id() {
		return reg_id;
	}
	public void setReg_id(int reg_id) {
		this.reg_id = reg_id;
	}
	public String getDate_area() {
		return date_area;
	}
	public void setDate_area(String date_area) {
		this.date_area = date_area;
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
	public String getDatehidden() {
		return datehidden;
	}
	public void setDatehidden(String datehidden) {
		this.datehidden = datehidden;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String saveAction() throws ParseException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		
		ClsAreaBean bean=new ClsAreaBean();
		
		String mode=getMode();
		java.sql.Date sqlStartDate = com.changeStringtoSqlDate(getDate_area());
		bean.setCity(getCity());
		bean.setCity_id(getCity_id());
		bean.setArea(getArea());
		bean.setCountry(getCountry());
		bean.setCou_id(getCou_id());
		bean.setRegion(getRegion());
		bean.setReg_id(getReg_id());
		bean.setDate_area(sqlStartDate);
		bean.setMode(getMode());
		bean.setDocno(getDocno());
		
		if(mode.equalsIgnoreCase("A")){
			
			int val=areaDAO.insert(bean,session);
//			setDatehidden(getDate_area());
			setDate_area(sqlStartDate.toString());
			setCity(getCity());
			setCity_id(Integer.parseInt(getCity()));
			setArea(getArea());
			setCountry(getCountry());	
			setCou_id(Integer.parseInt(getCountry()));
			setRegion(getRegion());
			setReg_id(Integer.parseInt(getRegion()));
			
			if(val>0){
			
			setDocno(val);
			setMsg("Successfully Saved");
			
			return "success";
		}
		else{
			setMsg("Not Saved");
			return "fail";
		}	
		
	}
		else if(mode.equalsIgnoreCase("E")){
			
			boolean Status=areaDAO.edit(bean,session);
			if(Status){
//				setDatehidden(getDate_area());
				setDate_area(sqlStartDate.toString());
				setCity(getCity());
				setCity_id(Integer.parseInt(getCity()));
				setArea(getArea());
				setCountry(getCountry());	
				setCou_id(Integer.parseInt(getCountry()));
				setRegion(getRegion());
				setReg_id(Integer.parseInt(getRegion()));
				setDocno(getDocno());
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("D")){
			boolean Status=areaDAO.delete(bean,session);
		if(Status){
//			setDatehidden(getDate_area());
			setDate_area(sqlStartDate.toString());
			setCity(getCity());
			setCity_id(Integer.parseInt(getCity()));
			setArea(getArea());
			setCountry(getCountry());	
			setCou_id(Integer.parseInt(getCountry()));
			setRegion(getRegion());
			setReg_id(Integer.parseInt(getRegion()));
			setDocno(getDocno());
			setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
		}
		else{
			setMsg("Not Deleted");
			return "fail";
		}
		}
		return "fail";
	}
}
