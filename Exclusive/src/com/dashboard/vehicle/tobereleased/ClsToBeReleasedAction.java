package com.dashboard.vehicle.tobereleased;
import com.common.*;
import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;
import com.controlcentre.masters.vehiclemaster.vehicle.*;
import com.opensymphony.xwork2.ActionSupport;


@SuppressWarnings("serial")
public class ClsToBeReleasedAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();

	private int dashreleasefleet;
	private String dashcmbrlsbranch;
	private String dashhidcmbrlsbranch;
	private String dashcmbrlsloc;
	private String dashhidcmbrlsloc;
	private String dashcmbrentalstatus;
	private String dashhidcmbrentalstatus;
	private String dashcmbstatus;
	private String dashhidcmbstatus;
	private String dashhidreleasedate;
	private String dashreleasedate;
	private String dashreleasetime;
	private String dashhidreleasetime;
	private String dashreleasekm;
	private String dashreleasefuel;
	private String dashhidreleasefuel;
	private String msg;
	private String mode;
	private int docno;
	private String dashaststatus;
	private String cmbbranch;
	private String hidcmbbranch;
	private String detail;
	private String detailname;
	
	
	
	
	public int getDashreleasefleet() {
		return dashreleasefleet;
	}




	public void setDashreleasefleet(int dashreleasefleet) {
		this.dashreleasefleet = dashreleasefleet;
	}




	public String getDashcmbrlsbranch() {
		return dashcmbrlsbranch;
	}




	public void setDashcmbrlsbranch(String dashcmbrlsbranch) {
		this.dashcmbrlsbranch = dashcmbrlsbranch;
	}




	public String getDashhidcmbrlsbranch() {
		return dashhidcmbrlsbranch;
	}




	public void setDashhidcmbrlsbranch(String dashhidcmbrlsbranch) {
		this.dashhidcmbrlsbranch = dashhidcmbrlsbranch;
	}




	public String getDashcmbrlsloc() {
		return dashcmbrlsloc;
	}




	public void setDashcmbrlsloc(String dashcmbrlsloc) {
		this.dashcmbrlsloc = dashcmbrlsloc;
	}




	public String getDashhidcmbrlsloc() {
		return dashhidcmbrlsloc;
	}




	public void setDashhidcmbrlsloc(String dashhidcmbrlsloc) {
		this.dashhidcmbrlsloc = dashhidcmbrlsloc;
	}




	public String getDashcmbrentalstatus() {
		return dashcmbrentalstatus;
	}




	public void setDashcmbrentalstatus(String dashcmbrentalstatus) {
		this.dashcmbrentalstatus = dashcmbrentalstatus;
	}




	public String getDashhidcmbrentalstatus() {
		return dashhidcmbrentalstatus;
	}




	public void setDashhidcmbrentalstatus(String dashhidcmbrentalstatus) {
		this.dashhidcmbrentalstatus = dashhidcmbrentalstatus;
	}




	public String getDashcmbstatus() {
		return dashcmbstatus;
	}




	public void setDashcmbstatus(String dashcmbstatus) {
		this.dashcmbstatus = dashcmbstatus;
	}




	public String getDashhidcmbstatus() {
		return dashhidcmbstatus;
	}




	public void setDashhidcmbstatus(String dashhidcmbstatus) {
		this.dashhidcmbstatus = dashhidcmbstatus;
	}




	public String getDashhidreleasedate() {
		return dashhidreleasedate;
	}




	public void setDashhidreleasedate(String dashhidreleasedate) {
		this.dashhidreleasedate = dashhidreleasedate;
	}




	public String getDashreleasedate() {
		return dashreleasedate;
	}




	public void setDashreleasedate(String dashreleasedate) {
		this.dashreleasedate = dashreleasedate;
	}




	public String getDashreleasetime() {
		return dashreleasetime;
	}




	public void setDashreleasetime(String dashreleasetime) {
		this.dashreleasetime = dashreleasetime;
	}




	public String getDashhidreleasetime() {
		return dashhidreleasetime;
	}




	public void setDashhidreleasetime(String dashhidreleasetime) {
		this.dashhidreleasetime = dashhidreleasetime;
	}




	public String getDashreleasekm() {
		return dashreleasekm;
	}




	public void setDashreleasekm(String dashreleasekm) {
		this.dashreleasekm = dashreleasekm;
	}




	public String getDashreleasefuel() {
		return dashreleasefuel;
	}




	public void setDashreleasefuel(String dashreleasefuel) {
		this.dashreleasefuel = dashreleasefuel;
	}




	public String getDashhidreleasefuel() {
		return dashhidreleasefuel;
	}




	public void setDashhidreleasefuel(String dashhidreleasefuel) {
		this.dashhidreleasefuel = dashhidreleasefuel;
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




	public int getDocno() {
		return docno;
	}




	public void setDocno(int docno) {
		this.docno = docno;
	}




	public String getDashaststatus() {
		return dashaststatus;
	}




	public void setDashaststatus(String dashaststatus) {
		this.dashaststatus = dashaststatus;
	}




	public String getCmbbranch() {
		return cmbbranch;
	}




	public void setCmbbranch(String cmbbranch) {
		this.cmbbranch = cmbbranch;
	}




	public String getHidcmbbranch() {
		return hidcmbbranch;
	}




	public void setHidcmbbranch(String hidcmbbranch) {
		this.hidcmbbranch = hidcmbbranch;
	}




	public String getDetail() {
		return detail;
	}




	public void setDetail(String detail) {
		this.detail = detail;
	}




	public String getDetailname() {
		return detailname;
	}




	public void setDetailname(String detailname) {
		this.detailname = detailname;
	}




	public String saveAction() throws ParseException, SQLException{
		ClsVehicleDAO ClsVehicleDAO=new ClsVehicleDAO();
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		ClsToBeReleasedDAO releaseDAO= new ClsToBeReleasedDAO();
		String mode=getMode();
		ClsToBeReleasedBean bean=new ClsToBeReleasedBean();
		 if(mode.equalsIgnoreCase("R")){
//			System.out.println("Release Location"+getDashcmbrlsloc());
			java.sql.Date reldate=null;
			if(!(getDashreleasedate()==null)){
				reldate=ClsCommon.changeStringtoSqlDate(getDashreleasedate());
			}
			int val1=releaseDAO.release(getDashreleasefleet(),getDashcmbrlsbranch(),getDashcmbrlsloc(),getDashreleasekm(),getDashreleasefuel(),getDocno(),session,mode,getDashcmbrentalstatus(),reldate,getDashreleasetime());
			if(val1>0){
				/*System.out.println(getDashcmbrlsloc());
				setDashreleasefleet(getDashreleasefleet());setDashhidcmbrlsbranch(getDashcmbrlsbranch());setDashhidcmbrlsloc(getDashcmbrlsloc());setMode("View");
				setDashhidcmbrentalstatus(getDashcmbrentalstatus());
				setDashaststatus("LIVE");
				setDashhidreleasedate(reldate.toString());
				setDashhidreleasetime(getDashreleasetime());
				setDashreleasekm(getDashreleasekm());
				setDashhidreleasefuel(getDashreleasefuel());
				setCmbbranch(getCmbbranch());*/
				setDetail("Vehicle");
				setDetailname("To Be Released");
//				System.out.println("Sucessfully released");		
					
				setMsg("Successfully Released");
					return "success";
				}
				else if(val1==-1){
					
					//System.out.println(getCmbrlsloc());
				/*	setDashreleasefleet(getDashreleasefleet());setDashhidcmbrlsbranch(getDashcmbrlsbranch());setDashhidcmbrlsloc(getDashcmbrlsloc());setMode("View");
					setDashhidcmbrentalstatus(getDashcmbrentalstatus());
					setDashaststatus("LIVE");
					setDashhidreleasedate(reldate.toString());
					setDashhidreleasetime(getDashreleasetime());
					setDashreleasekm(getDashreleasekm());
					setDashhidreleasefuel(getDashreleasefuel());
					setCmbbranch(getCmbbranch());
		System.out.println("References Present in Other Documents");*/
					setDetail("Vehicle");
					setDetailname("To Be Released");
		setMsg("References Present in Other Documents");
				return "fail";
				}
				else{
					/*setDashreleasefleet(getDashreleasefleet());setDashhidcmbrlsbranch(getDashcmbrlsbranch());setDashhidcmbrlsloc(getDashcmbrlsloc());setMode("View");
					setDashhidcmbrentalstatus(getDashcmbrentalstatus());
					setDashaststatus("LIVE");
					setDashhidreleasedate(reldate.toString());
					setDashhidreleasetime(getDashreleasetime());
					setDashreleasekm(getDashreleasekm());
					setDashhidreleasefuel(getDashreleasefuel());
					setCmbbranch(getCmbbranch());
		System.out.println("not saved");*/
					setDetail("Vehicle");
					setDetailname("To Be Released");
		setMsg("Not Saved");
				return "fail";
				}
				
				}
		 if(mode.equalsIgnoreCase("V")){
			 ClsVehicleDAO.getViewDetails(getDashreleasefleet());
		 }
		return "fail";
	}
}
