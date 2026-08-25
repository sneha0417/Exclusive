package com.controlcentre.masters.maintenancemaster.garage;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsGarageAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
	ClsGarageDAO garageDAO=new ClsGarageDAO();
	ClsGarageBean bean;
	
	private int docno;
	private String mode;
	private String delete;
	private String garagedate;
	private String hidgaragedate;
	private String type;
	private String hidtype;
	private String txtaccname;
	private int txtaccno;
	private String location;
	private String hidlocation;
	private String garagecode;
	private String garagename;
	private String msg;
	private String formdetail;
	private String formdetailcode;
	private String hidacno;
	
	
	public String getHidacno() {
		return hidacno;
	}
	public void setHidacno(String hidacno) {
		this.hidacno = hidacno;
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
	public String getDelete() {
		return delete;
	}
	public void setDelete(String delete) {
		this.delete = delete;
	}
	public String getGaragedate() {
		return garagedate;
	}
	public void setGaragedate(String garagedate) {
		this.garagedate = garagedate;
	}
	public String getHidgaragedate() {
		return hidgaragedate;
	}
	public void setHidgaragedate(String hidgaragedate) {
		this.hidgaragedate = hidgaragedate;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getHidtype() {
		return hidtype;
	}
	public void setHidtype(String hidtype) {
		this.hidtype = hidtype;
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
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getHidlocation() {
		return hidlocation;
	}
	public void setHidlocation(String hidlocation) {
		this.hidlocation = hidlocation;
	}
	public String getGaragecode() {
		return garagecode;
	}
	public void setGaragecode(String garagecode) {
		this.garagecode = garagecode;
	}
	public String getGaragename() {
		return garagename;
	}
	public void setGaragename(String garagename) {
		this.garagename = garagename;
	}
	
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.getAttribute("BRANCHID");
		
		String mode=getMode();
		ClsGarageBean bean=new ClsGarageBean();

		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getGaragedate());

		if(mode.equalsIgnoreCase("A")){
				
			int val=garageDAO.insert(getGaragecode(),getGaragename(),sqlStartDate,Integer.parseInt(getHidacno()),getType(),getLocation(),session,getMode(),getFormdetailcode());
				
				if(val>0.0){
					setHidacno(getHidacno());
					setGaragecode(getGaragecode());
					setGaragename(getGaragename());
					setGaragedate(getGaragedate());
					setHidgaragedate(getGaragedate());
					setType(getType());
					setHidtype(getType());
					setTxtaccno(getTxtaccno());
				    setTxtaccname(getTxtaccname());
					setLocation(getLocation());
					setHidlocation(getLocation());
					setMode(getMode());
					setDocno(val);

					setMsg("Successfully Saved");
					return "success";
				}
				else{
				setHidacno(getHidacno());
					setGaragecode(getGaragecode());
					setGaragename(getGaragename());
					setGaragedate(getGaragedate());
					setHidgaragedate(getGaragedate());
					setType(getType());
					setHidtype(getType());
					setTxtaccno(getTxtaccno());
					setTxtaccname(getTxtaccname());
					setLocation(getLocation());
					setHidlocation(getLocation());
					setMode(getMode());
					setDocno(val);

					setMsg("Not Saved");
					return "fail";
				}	
		}
		else if(mode.equalsIgnoreCase("E")){

			boolean Status=garageDAO.edit(getGaragecode(),getGaragename(),sqlStartDate,Integer.parseInt(getHidacno()),getType(),getLocation(),session,getMode(),getDocno(),getFormdetailcode());
			
			if(Status){
				setHidacno(getHidacno());
				setDocno(getDocno());
				setMode(getMode());
				setGaragecode(getGaragecode());
				setGaragename(getGaragename());
				setGaragedate(getGaragedate());
				setHidgaragedate(getGaragedate());
				setType(getType());
				setHidtype(getType());
				setTxtaccno(getTxtaccno());
				setTxtaccname(getTxtaccname());
				setLocation(getLocation());
				setHidlocation(getLocation());
			
				setMsg("Updated Successfully");
				return "success";
			}
			else{
			setHidacno(getHidacno());
				setDocno(getDocno());
				setMode(getMode());
				setGaragecode(getGaragecode());
				setGaragename(getGaragename());
				setGaragedate(getGaragedate());
				setHidgaragedate(getGaragedate());
				setType(getType());
				setHidtype(getType());
				setTxtaccno(getTxtaccno());
				setTxtaccname(getTxtaccname());
				setLocation(getLocation());
				setHidlocation(getLocation());

				setMsg("Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){

			boolean Status=garageDAO.delete(getGaragecode(),getGaragename(),sqlStartDate,Integer.parseInt(getHidacno()),getType(),getLocation(),session,getMode(),getDocno(),getFormdetailcode());
		
			if(Status){
			setHidacno(getHidacno());
				setDocno(getDocno());
				setMode(getMode());
				setGaragecode(getGaragecode());
				setGaragename(getGaragename());
				setGaragedate(getGaragedate());
				setHidgaragedate(getGaragedate());
				setType(getType());
				setHidtype(getType());
				setTxtaccno(getTxtaccno());
				setTxtaccname(getTxtaccname());
				setLocation(getLocation());
				setHidlocation(getLocation());
				
				setDelete("DELETED");
				setMsg("Successfully Deleted");
				return "success";
		}
		else{
setHidacno(getHidacno());
			setDocno(getDocno());
			setMode(getMode());
			setGaragecode(getGaragecode());
			setGaragename(getGaragename());
			setGaragedate(getGaragedate());
			setHidgaragedate(getGaragedate());
			setType(getType());
			setHidtype(getType());
			setTxtaccno(getTxtaccno());
			setTxtaccname(getTxtaccname());
			setLocation(getLocation());
			setHidlocation(getLocation());
			
			setMsg("Not Deleted");
			return "fail";
		  }
		}
		return "fail";
	}

  }
