package com.controlcentre.settings.fuelcharge;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;


public class ClsFuelChargeAction {
	ClsCommon ClsCommon=new ClsCommon();
	ClsFuelChargeDAO fuelchargeDAO = new ClsFuelChargeDAO();
	private String masterdate,fromdate,todate,mode,msg,hidmaster,hidfrmdate,hidtodate,formdetailcode;
	private int docno;
	private double petrolcharge,deccharge;
	public String getMasterdate() {
		return masterdate;
	}
	public void setMasterdate(String masterdate) {
		this.masterdate = masterdate;
	}
	public String getFromdate() {
		return fromdate;
	}
	public void setFromdate(String fromdate) {
		this.fromdate = fromdate;
	}
	public String getTodate() {
		return todate;
	}
	public void setTodate(String todate) {
		this.todate = todate;
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
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public double getPetrolcharge() {
		return petrolcharge;
	}
	public void setPetrolcharge(double petrolcharge) {
		this.petrolcharge = petrolcharge;
	}
	public double getDeccharge() {
		return deccharge;
	}
	public void setDeccharge(double deccharge) {
		this.deccharge = deccharge;
	}
	
	
	public String getHidmaster() {
		return hidmaster;
	}
	public void setHidmaster(String hidmaster) {
		this.hidmaster = hidmaster;
	}
	public String getHidfrmdate() {
		return hidfrmdate;
	}
	public void setHidfrmdate(String hidfrmdate) {
		this.hidfrmdate = hidfrmdate;
	}
	public String getHidtodate() {
		return hidtodate;
	}
	public void setHidtodate(String hidtodate) {
		this.hidtodate = hidtodate;
	}
	
	
	
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String saveAction() throws SQLException
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		
		String mode=getMode();
		
		if(mode.equalsIgnoreCase("A"))
		{
		java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getMasterdate()); 
		java.sql.Date fromdate = ClsCommon.changeStringtoSqlDate(getFromdate());
		java.sql.Date todate = ClsCommon.changeStringtoSqlDate(getTodate());
			
		int val=fuelchargeDAO.insert(masterdate,fromdate,todate,getPetrolcharge(),getDeccharge(),session,getFormdetailcode());	
			if(val>0)
			{
				
				setHidmaster(masterdate.toString());
				setHidfrmdate(fromdate.toString());
				setHidtodate(todate.toString());
				setPetrolcharge(getPetrolcharge());
				setDeccharge(getDeccharge());
				setDocno(val);
                setMsg("Successfully Saved");
				return "success";
			}
			else
			{
				setHidmaster(masterdate.toString());
				setHidfrmdate(fromdate.toString());
				setHidtodate(todate.toString());
				setPetrolcharge(getPetrolcharge());
				setDeccharge(getDeccharge());
	           setMsg("Not Saved");
			   return "fail";
			}
		}
		
		
		return "fail";
		
		
		
		
	}
	
	
}
