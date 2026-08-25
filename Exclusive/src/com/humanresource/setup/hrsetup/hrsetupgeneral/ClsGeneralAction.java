package com.humanresource.setup.hrsetup.hrsetupgeneral;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

 



import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
 

public class ClsGeneralAction {

	ClsCommon ClsCommon=new ClsCommon();

	ClsGeneralDAO saveDAO= new ClsGeneralDAO()	;
	ClsGeneralBean viewDAO= new ClsGeneralBean()	;
	
	private String   masterdate,hidmasterdate,validfromdate,hidvalidfromdate,lastreviseddate,hidlastreviseddate,workingtime,hidworkingtime,
			convformula,normalrate,ot,holidayot,mode,deleted,msg,formdetailcode,hidweakoff ;
	private int docno,mon,tue,wed,thu,fri,sat,sun,carryforward,hidcarryforward,benigridlength,trmigridlength,resiggridlength,
			accountsetupgridlength,leaveid,cmbcategory,hidleaveid,hidcatval;
	private double  eligibledays,forworkingdays;

	public String getMasterdate() {
		return masterdate;
	}
	
	public void setMasterdate(String masterdate) {     
		this.masterdate = masterdate;
	}
	public String getHidmasterdate() {
		return hidmasterdate;
	}
	public void setHidmasterdate(String hidmasterdate) {
		this.hidmasterdate = hidmasterdate;
	}
	public String getValidfromdate() {
		return validfromdate;
	}
	public void setValidfromdate(String validfromdate) {
		this.validfromdate = validfromdate;
	}
	public String getHidvalidfromdate() {
		return hidvalidfromdate;
	}
	public void setHidvalidfromdate(String hidvalidfromdate) {
		this.hidvalidfromdate = hidvalidfromdate;
	}
	public String getLastreviseddate() {
		return lastreviseddate;
	}
	public void setLastreviseddate(String lastreviseddate) {
		this.lastreviseddate = lastreviseddate;
	}
	public String getHidlastreviseddate() {
		return hidlastreviseddate;
	}
	public void setHidlastreviseddate(String hidlastreviseddate) {
		this.hidlastreviseddate = hidlastreviseddate;
	}
	public int getHidcatval() {
		return hidcatval;
	}
	public void setHidcatval(int hidcatval) {
		this.hidcatval = hidcatval;
	}
	public String getWorkingtime() {
		return workingtime;
	}
	public void setWorkingtime(String workingtime) { 
		this.workingtime = workingtime;
	}
	public String getHidworkingtime() {
		return hidworkingtime;
	}
	public void setHidworkingtime(String hidworkingtime) {
		this.hidworkingtime = hidworkingtime;
	}
	public int getHidleaveid() {
		return hidleaveid;
	}
	public void setHidleaveid(int hidleaveid) {
		this.hidleaveid = hidleaveid;
	}
	public int getLeaveid() {
		return leaveid;
	}
	public void setLeaveid(int leaveid) {
		this.leaveid = leaveid;
	}
	public int getCmbcategory() {
		return cmbcategory;
	}
	public void setCmbcategory(int cmbcategory) {
		this.cmbcategory = cmbcategory;
	}
	public double getEligibledays() {
		return eligibledays;
	}
	public void setEligibledays(double eligibledays) {
		this.eligibledays = eligibledays;
	}
	public double getForworkingdays() {
		return forworkingdays;
	}
	public void setForworkingdays(double forworkingdays) {
		this.forworkingdays = forworkingdays;
	}
	public String getConvformula() {          
		return convformula;
	}
	public void setConvformula(String convformula) {
		this.convformula = convformula;
	}
	public String getNormalrate() {
		return normalrate;
	}
	public void setNormalrate(String normalrate) {
		this.normalrate = normalrate;
	}
	public String getOt() {
		return ot;
	}
	public void setOt(String ot) {
		this.ot = ot;
	}
	public String getHolidayot() {
		return holidayot;
	}
	public void setHolidayot(String holidayot) {
		this.holidayot = holidayot;
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
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public int getMon() {       
		return mon;
	}
	public void setMon(int mon) {
		this.mon = mon;
	}
	public int getTue() {
		return tue;
	}
	public void setTue(int tue) {
		this.tue = tue;
	}
	public int getWed() {
		return wed;
	}
	public void setWed(int wed) {
		this.wed = wed;
	}
	public int getThu() {
		return thu;
	}
	public void setThu(int thu) {
		this.thu = thu;
	}
	public int getFri() {
		return fri;
	}
	public void setFri(int fri) {
		this.fri = fri;
	}
	public int getSat() {
		return sat;
	}
	public void setSat(int sat) {
		this.sat = sat;
	}
	public int getSun() {
		return sun;
	}
	public void setSun(int sun) {
		this.sun = sun;
	}
	public int getCarryforward() {
		return carryforward;
	}
	public void setCarryforward(int carryforward) {
		this.carryforward = carryforward;
	}
	public int getHidcarryforward() {
		return hidcarryforward;
	}
	public void setHidcarryforward(int hidcarryforward) {
		this.hidcarryforward = hidcarryforward;
	}
	public String getHidweakoff() {
		return hidweakoff;
	}
	public void setHidweakoff(String hidweakoff) {
		this.hidweakoff = hidweakoff;
	}
	public int getBenigridlength() {
		return benigridlength;
	}
	public void setBenigridlength(int benigridlength) {
		this.benigridlength = benigridlength;
	}
	public int getTrmigridlength() {
		return trmigridlength;
	}
	public void setTrmigridlength(int trmigridlength) {
		this.trmigridlength = trmigridlength;
	}
	public int getResiggridlength() {
		return resiggridlength;
	}
	public void setResiggridlength(int resiggridlength) {
		this.resiggridlength = resiggridlength;
	}
	public int getAccountsetupgridlength() {
		return accountsetupgridlength;
	}
	public void setAccountsetupgridlength(int accountsetupgridlength) {
		this.accountsetupgridlength = accountsetupgridlength;
	}

	public String saveAction() throws SQLException {
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	Map<String, String[]> requestParams = request.getParameterMap();
	
	if(getMode().equalsIgnoreCase("A")) {
 
		java.sql.Date masterdate=	ClsCommon.changeStringtoSqlDate(getMasterdate());
	
		java.sql.Date fromdate=	ClsCommon.changeStringtoSqlDate(getValidfromdate());
		java.sql.Date lastdate=	ClsCommon.changeStringtoSqlDate(getLastreviseddate());
	
		ArrayList<String> beniarray= new ArrayList<>();
		for(int i=0;i<getBenigridlength() ;i++){
			String temp1=requestParams.get("trbenitest"+i)[0];
			beniarray.add(temp1);
		}

		ArrayList<String> termiarray= new ArrayList<>();
		for(int i=0;i<getTrmigridlength() ;i++){
			String temp2=requestParams.get("termitest"+i)[0];
			termiarray.add(temp2);
		}
	
		ArrayList<String> resiarray= new ArrayList<>();
		for(int i=0;i<getResiggridlength() ;i++){
			String temp3=requestParams.get("resigtest"+i)[0];
			resiarray.add(temp3);
		}
	
		ArrayList<String> accsetuparray= new ArrayList<>();
		for(int i=0;i<getAccountsetupgridlength() ;i++){
			String temp4=requestParams.get("acnotest"+i)[0];
			accsetuparray.add(temp4);
		}
	
	 String woff="";
	 if(getMon()==1) {	woff=woff+"1,"; }
	 if(getTue()==1) {	woff=woff+"2,"; }
	 if(getWed()==1) {	woff=woff+"3,"; }
	 if(getThu()==1) {	woff=woff+"4,"; }
	 if(getFri()==1) {	woff=woff+"5,"; }
	 if(getSat()==1) {	woff=woff+"6,"; }
	 if(getSun()==1) {	woff=woff+"7,"; }
	 
		if(!(woff.equalsIgnoreCase(""))) {
			if(woff.endsWith(",")) {
				woff = woff.substring(0,woff.length() - 1);
			}
		}
 
		int val=saveDAO.insert(masterdate,fromdate,lastdate,getCmbcategory(),getWorkingtime(),getLeaveid(),getCarryforward(),getEligibledays(),getForworkingdays(),
				getConvformula(),getNormalrate(),getOt(),getHolidayot(),getMode(),getFormdetailcode(),woff,session,request,beniarray,termiarray,resiarray,accsetuparray);
		
		if(val>0) {
			  setDocno(val);
  			  // getWorkingtime() setHidworkingtime() getEligibledays() getLeaveid() getForworkingdays()
			  setHidmasterdate(masterdate.toString());
			  setValidfromdate(fromdate.toString());
			  setLastreviseddate(lastdate.toString());
			  setHidcatval(getCmbcategory());
			  setHidworkingtime(getWorkingtime());
			  setEligibledays(getEligibledays());
			  setHidleaveid(getLeaveid());
			  setForworkingdays(getForworkingdays());
			  setConvformula(getConvformula());
			  setNormalrate(getNormalrate()); 
			  setOt(getOt()); 
			  setHolidayot(getHolidayot());
			  setHidcarryforward(getCarryforward());
			  setHidweakoff(woff);
			  
			  setMsg("Successfully Saved");
			  return "success";
		} else {
			 
			  setHidmasterdate(masterdate.toString());
			  setValidfromdate(fromdate.toString());
			  setLastreviseddate(lastdate.toString());
			  setHidcatval(getCmbcategory());
			  setHidworkingtime(getWorkingtime());
			  setEligibledays(getEligibledays());
			  setHidleaveid(getLeaveid());
			  setForworkingdays(getForworkingdays());
			  setConvformula(getConvformula());
			  setNormalrate(getNormalrate()); 
			  setOt(getOt()); 
			  setHolidayot(getHolidayot());
			  setHidcarryforward(getCarryforward());
			  setHidweakoff(woff);
			  
			  setMsg("Not Saved");
			  return "fail";
		}
	}
	
	 else if(getMode().equalsIgnoreCase("E")) {
 
		    java.sql.Date masterdate=	ClsCommon.changeStringtoSqlDate(getMasterdate());
			
			java.sql.Date fromdate=	ClsCommon.changeStringtoSqlDate(getValidfromdate());
			java.sql.Date lastdate=	ClsCommon.changeStringtoSqlDate(getLastreviseddate());
			
			ArrayList<String> beniarray= new ArrayList<>();
			for(int i=0;i<getBenigridlength() ;i++){
				String temp1=requestParams.get("trbenitest"+i)[0];
				beniarray.add(temp1);
			 
			}

			ArrayList<String> termiarray= new ArrayList<>();
			for(int i=0;i<getTrmigridlength() ;i++){
				String temp2=requestParams.get("termitest"+i)[0];
				termiarray.add(temp2);
			}
			
			ArrayList<String> resiarray= new ArrayList<>();
			for(int i=0;i<getResiggridlength() ;i++){
				String temp3=requestParams.get("resigtest"+i)[0];
				resiarray.add(temp3);
			}
			
			
			ArrayList<String> accsetuparray= new ArrayList<>();
			for(int i=0;i<getAccountsetupgridlength() ;i++){
				String temp4=requestParams.get("acnotest"+i)[0];
				accsetuparray.add(temp4);
			}
			
			 String woff="";
			 if(getMon()==1) {	woff=woff+"1,"; }
			 if(getTue()==1) {	woff=woff+"2,"; }
			 if(getWed()==1) {	woff=woff+"3,"; }
			 if(getThu()==1) {	woff=woff+"4,"; }
			 if(getFri()==1) {	woff=woff+"5,"; }
			 if(getSat()==1) {	woff=woff+"6,"; }
			 if(getSun()==1) {	woff=woff+"7,"; }
			 
				if(!(woff.equalsIgnoreCase(""))) {
					if(woff.endsWith(",")) {
						woff = woff.substring(0,woff.length() - 1);
					}
				}
		 
				int val=saveDAO.update(getDocno(),masterdate,fromdate,lastdate,getCmbcategory(),getWorkingtime(),getLeaveid(),getCarryforward(),getEligibledays(),getForworkingdays(),
						getConvformula(),getNormalrate(),getOt(),getHolidayot(),getMode(),getFormdetailcode(),woff,session,request,beniarray,termiarray,resiarray,accsetuparray);
				if(val>0) {
					
					  setDocno(getDocno());
					  // getWorkingtime() setHidworkingtime() getEligibledays() getLeaveid() getForworkingdays()
					  setHidmasterdate(masterdate.toString());
					  setValidfromdate(fromdate.toString());
					  setLastreviseddate(lastdate.toString());
					  setHidcatval(getCmbcategory());
					  setHidworkingtime(getWorkingtime());
					  setEligibledays(getEligibledays());
					  setHidleaveid(getLeaveid());
					  setForworkingdays(getForworkingdays());
					  setConvformula(getConvformula());
					  setNormalrate(getNormalrate()); 
					  setOt(getOt()); 
					  setHolidayot(getHolidayot());
					  setHidcarryforward(getCarryforward());
					  setHidweakoff(woff);
					  
					  setMsg("Updated Successfully");
					  return "success";
				} else {
					 
					  setHidmasterdate(masterdate.toString());
					  setValidfromdate(fromdate.toString());
					  setLastreviseddate(lastdate.toString());
					  setHidcatval(getCmbcategory());
					  setHidworkingtime(getWorkingtime());
					  setEligibledays(getEligibledays());
					  setHidleaveid(getLeaveid());
					  setForworkingdays(getForworkingdays());
					  setConvformula(getConvformula());
					  setNormalrate(getNormalrate()); 
					  setOt(getOt()); 
					  setHolidayot(getHolidayot());
					  setHidcarryforward(getCarryforward());
					  setHidweakoff(woff);
					  
					  setMsg("Not Updated");
					  return "fail";
				}
	} else if(getMode().equalsIgnoreCase("D")) {
 		 String woff="";
		 if(getMon()==1) {	woff=woff+"1,"; }
		 if(getTue()==1) {	woff=woff+"2,"; }
		 if(getWed()==1) {	woff=woff+"3,"; }
		 if(getThu()==1) {	woff=woff+"4,"; }
		 if(getFri()==1) {	woff=woff+"5,"; }
		 if(getSat()==1) {	woff=woff+"6,"; }
		 if(getSun()==1) {	woff=woff+"7,"; }
		 
			if(!(woff.equalsIgnoreCase(""))) {
				if(woff.endsWith(",")) {
					woff = woff.substring(0,woff.length() - 1);
				}
			}
	 
		int val=saveDAO.delete(getDocno(),getMode(),getFormdetailcode(),session,request);
		
		if(val>0) {
			
			  setDocno(getDocno());
			  setHidcatval(getCmbcategory());
			  setHidworkingtime(getWorkingtime());
			  setEligibledays(getEligibledays());
			  setHidleaveid(getLeaveid());
			  setForworkingdays(getForworkingdays());
			  setConvformula(getConvformula());
			  setNormalrate(getNormalrate()); 
			  setOt(getOt()); 
			  setHolidayot(getHolidayot());
			  setHidcarryforward(getCarryforward());
			  setHidweakoff(woff);
			 
			  setDeleted("DELETED");
			  setMsg("Successfully Deleted");
			  return "success";
		} else {
			  setDocno(getDocno());
			  setHidcatval(getCmbcategory());
			  setHidworkingtime(getWorkingtime());
			  setEligibledays(getEligibledays());
			  setHidleaveid(getLeaveid());
			  setForworkingdays(getForworkingdays());
			  setConvformula(getConvformula());
			  setNormalrate(getNormalrate()); 
			  setOt(getOt()); 
			  setHolidayot(getHolidayot());
			  setHidcarryforward(getCarryforward());
			  setHidweakoff(woff);
			 
			  setMsg("Not Deleted");
			  return "fail";
		}
	} 
	
 	else if(getMode().equalsIgnoreCase("view")) {
		 viewDAO=saveDAO.getViewDetails(getDocno());
		
 
		 setDocno(getDocno());
		 setHidmasterdate(viewDAO.getHidmasterdate());
		 setValidfromdate(viewDAO.getValidfromdate());
		 setLastreviseddate(viewDAO.getLastreviseddate());
		 setHidcatval(viewDAO.getHidcatval());
		 setHidworkingtime(viewDAO.getHidworkingtime());
		 setEligibledays(viewDAO.getEligibledays());
		 setHidleaveid(viewDAO.getHidleaveid());
		 setForworkingdays(viewDAO.getForworkingdays());
		 setConvformula(viewDAO.getConvformula());
		 setNormalrate(viewDAO.getNormalrate()); 
		 setOt(viewDAO.getOt()); 
		 setHolidayot(viewDAO.getHolidayot());
		 setHidcarryforward(viewDAO.getHidcarryforward());
		 setHidweakoff(viewDAO.getHidweakoff());

		 return "success";
	}
	return "fail";
  }
}
