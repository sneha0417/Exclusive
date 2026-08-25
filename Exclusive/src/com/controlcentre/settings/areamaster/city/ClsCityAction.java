package com.controlcentre.settings.areamaster.city;

import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsCityAction {
	ClsCityDAO cityDAO=new ClsCityDAO();
	
	ClsCommon com=new ClsCommon();
	
	ClsCityBean bean;
	
	private int docno;
	private String city;
	private String city_code;
	private String country;
	private int cou_id;
	private String region;
	private int reg_id;
	private String date_city;
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
	public String getCity_code() {
		return city_code;
	}
	public void setCity_code(String city_code) {
		this.city_code = city_code;
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
	public String getDate_city() {
		return date_city;
	}
	public void setDate_city(String date_city) {
		this.date_city = date_city;
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
		
		ClsCityBean bean =new ClsCityBean();
		
		String mode=getMode();
		java.sql.Date sqlStartDate = com.changeStringtoSqlDate(getDate_city());
		//System.out.println("   ---  "+getCity());
		//System.out.println("   ---  "+getCity_code());
		
		bean.setCity(getCity());
		bean.setCity_code(getCity_code());
		bean.setCountry(getCountry());
		bean.setCou_id(getCou_id());
		bean.setRegion(getRegion());
		bean.setReg_id(getReg_id());
		bean.setDate_city(sqlStartDate);
		bean.setMode(getMode());
		bean.setDocno(getDocno());
		
if(mode.equalsIgnoreCase("A")){
			
			int val=cityDAO.insert(bean,session);
			if(val>0){
//				setDatehidden(getDate_city());
				setDate_city(sqlStartDate.toString());
				setCity(getCity());
				setCity_code(getCity_code());
				setCountry(getCountry());	
				setCou_id(Integer.parseInt(getCountry()));
				setRegion(getRegion());
				setReg_id(Integer.parseInt(getRegion()));
				
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
	
	boolean Status=cityDAO.edit(bean,session);
	if(Status){
//		setDatehidden(getDate_city());
		setDate_city(sqlStartDate.toString());
		setCity(getCity());
		setCity_code(getCity_code());
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
	boolean Status=cityDAO.delete(bean,session);
if(Status){
//	setDatehidden(getDate_city());
	setDate_city(sqlStartDate.toString());
	setCity(getCity());
	setCity_code(getCity_code());
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
