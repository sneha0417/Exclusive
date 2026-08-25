package com.controlcentre.masters.vehiclemaster.securitypass;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsSecurityPassAction {
	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	ClsSecurityPassDAO spdao=new ClsSecurityPassDAO();
	
	private int docno;
	private String name,description,date,startdate,enddate,qty;
	private String mode;
	private String msg;
	private String deleted;
	private String brchName;
	
	public String getStartdate() {
		return startdate;
	}
	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	public String getQty() {
		return qty;
	}
	public void setQty(String qty) {
		this.qty = qty;
	}
	private String formdetailcode;
	
	
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
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
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public void setValues(int docno,java.sql.Date sqldate,java.sql.Date sqlsdate,java.sql.Date sqledate,String qty){
		setDocno(docno);
		setDate(sqldate.toString());
		setStartdate(sqlsdate.toString());
		setEnddate(sqledate.toString());
		setQty(getQty());
		setName(getName());
		setDescription(getDescription());
	}
	public String saveAction() throws SQLException{
		System.out.println("inside save action ");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		java.sql.Date sqldate=null;
		java.sql.Date sqlsdate=null;
		java.sql.Date sqledate=null;
		if(!getDate().equalsIgnoreCase("") && getDate()!=null){
			sqldate=objcommon.changeStringtoSqlDate(getDate());
		}
		if(!getStartdate().equalsIgnoreCase("") && getStartdate()!=null){
			sqlsdate=objcommon.changeStringtoSqlDate(getStartdate());
		}
		if(!getEnddate().equalsIgnoreCase("") && getEnddate()!=null){
			sqledate=objcommon.changeStringtoSqlDate(getEnddate());
		}
		if(mode.equalsIgnoreCase("A")){
			int val=spdao.insert(sqldate,getName(),getDescription(),mode,session,getFormdetailcode(),sqlsdate,sqledate,getQty());
			if(val>0){
				setValues(val, sqldate,sqlsdate,sqledate,getQty());
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setValues(val, sqldate,sqlsdate,sqledate,getQty());
				setMsg("Not Saved");
				return "fail";
			}
		}
		else if (mode.equalsIgnoreCase("E")){
			boolean status=spdao.edit(getDocno(),sqldate,getName(),getDescription(),mode,session,getFormdetailcode(),sqlsdate,sqledate,getQty());
			if(status){
				setValues(getDocno(), sqldate,sqlsdate,sqledate,getQty());
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setValues(getDocno(), sqldate,sqlsdate,sqledate,getQty());
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if (mode.equalsIgnoreCase("D")){
			boolean status=spdao.delete(getDocno(),mode,session,getFormdetailcode());
			if(status){
				setValues(getDocno(), sqldate,sqlsdate,sqledate,getQty());
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				
				return "success";
			}
			else{
				setValues(getDocno(), sqldate,sqlsdate,sqledate,getQty());
				setMsg("Not Deleted");
				return "fail";
			}
		}
		return "fail";
	}
}
