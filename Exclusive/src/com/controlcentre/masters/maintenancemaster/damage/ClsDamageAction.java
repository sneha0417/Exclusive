package com.controlcentre.masters.maintenancemaster.damage;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsDamageAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
	ClsDamageDAO damageDAO= new ClsDamageDAO();
	ClsDamageBean bean;
	
	private int docno;
	private String mode;
	private String deleted;
	private String damagedate;
	private double dmgcharge;
	private String name1;
	private String cmbtype;
	private String damagedatehidden;
	private String msg;
	private String formdetailcode;
	private String formdetail;
	private String hidcmbtype;
	private String chkstatus;
	
	
	public String getChkstatus() {
		return chkstatus;
	}
	
	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
	}
	
	public String getHidcmbtype() {
		return hidcmbtype;
	}
	
	public void setHidcmbtype(String hidcmbtype) {
		this.hidcmbtype = hidcmbtype;
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
	
	public String getDamagedatehidden() {
		return damagedatehidden;
	}
	
	public void setDamagedatehidden(String damagedatehidden) {
		this.damagedatehidden = damagedatehidden;
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
	
	public String getDeleted() {
		return deleted;
	}
	
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	
	public String getDamagedate() {
		return damagedate;
	}
	
	public void setDamagedate(String damagedate) {
		this.damagedate = damagedate;
	}
	
	public double getDmgcharge() {
		return dmgcharge;
	}
	
	public void setDmgcharge(double dmgcharge) {
		this.dmgcharge = dmgcharge;
	}
	
	public String getName1() {
		return name1;
	}
	
	public void setName1(String name1) {
		this.name1 = name1;
	}
	
	public String getCmbtype() {
		return cmbtype;
	}
	
	public void setCmbtype(String cmbtype) {
		this.cmbtype = cmbtype;
	}

	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();

		session.getAttribute("BRANCHID");
		String mode=getMode();
		ClsDamageBean bean=new ClsDamageBean();
		
		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getDamagedate());
	
		if(mode.equalsIgnoreCase("A")){
			
			int val=damageDAO.insert(getCmbtype(),getName1(),sqlStartDate,getDmgcharge(),session,getMode(),getFormdetailcode());
			
			if(val>0.0){
				setHidcmbtype(getCmbtype());
				setMode(getMode());
				setName1(getName1());
				setDamagedatehidden(sqlStartDate.toString());
				setDmgcharge(getDmgcharge());
				setDocno(val);
				setMsg("Successfully Saved");

				return "success";
			}
			else{
				setHidcmbtype(getCmbtype());
				setMode(getMode());
				setName1(getName1());
				setDamagedatehidden(sqlStartDate.toString());
				setDmgcharge(getDmgcharge());
				setDocno(val);
				setMsg("Not Saved");

				return "fail";
			}	
		}
		
		else if(mode.equalsIgnoreCase("E")){
			
			boolean Status=damageDAO.edit(getCmbtype(),getName1(),sqlStartDate,getDmgcharge(),session,getMode(),getDocno(),getFormdetailcode());
			
			if(Status){
				setHidcmbtype(getCmbtype());
				setDocno(getDocno());
				setMode(getMode());
				setName1(getName1());
				setDamagedatehidden(sqlStartDate.toString());
				setMode(getMode());
				setDmgcharge(getDmgcharge());
			
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setHidcmbtype(getCmbtype());
				setDocno(getDocno());
				setMode(getMode());
				setName1(getName1());
				setDamagedatehidden(sqlStartDate.toString());
				setMode(getMode());
				setDmgcharge(getDmgcharge());

				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("D")){
		
			boolean Status=damageDAO.delete(getCmbtype(),getName1(),sqlStartDate,getDmgcharge(),session,getMode(),getDocno(),getFormdetailcode());
		
			if(Status){
			setHidcmbtype(getCmbtype());
			setDocno(getDocno());
			setMode(getMode());
			setName1(getName1());
			setDamagedatehidden(sqlStartDate.toString());
			setMode(getMode());
			setDmgcharge(getDmgcharge());

			setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
		}
		else{
			setHidcmbtype(getCmbtype());
			setDocno(getDocno());
			setMode(getMode());
			setName1(getName1());
			setDamagedatehidden(sqlStartDate.toString());
			setMode(getMode());
			setDmgcharge(getDmgcharge());

			setMsg("Not Deleted");
			return "fail";
		}
	 }
	 return "fail";
	}

}
