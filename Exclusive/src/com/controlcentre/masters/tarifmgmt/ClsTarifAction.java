package com.controlcentre.masters.tarifmgmt;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;
public class ClsTarifAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
	ClsTarifDAO tarifDAO= new ClsTarifDAO();
	ClsTarifBean bean;
	private int docno;
	private String test0;
	private String txtclient;
	private int hidtxtclient;
	private String txtweekday1;
	private String txtweekday2;
	private String gridweekday;
	private String txtweekday0;
	private int deliverylength;
	private String txtdelivery0;
	private String test1;
	private String test2;
	private String test3;
	private String test4;
	private String hidjqxTariffDate;
	private String jqxTariffDate;
	private String cmbtariftype;
	private String hidcmbtariftype;
	private String cmbtariffor;
	private String hidcmbtariffor;
	private String hidjqxTariffFromDate;
	private String jqxTariffFromDate;
	private String hidjqxTariffToDate;
	private String jqxTariffToDate;
	private String chckdeliverychg;
	private String hidcheck;
	private String notes;
	private String tempgroup;
	private int gridlength;
	private String mode;
	private String delete;
	private String tarifmode;
	private int weekdaylength;
	private int foclength;
	private int fuellength;
	private String txtfuel0;
	private String txtfoc1;
	private String msg;
	private String tempstatus;
	private String formdetailcode;
	private String formdetail;
	private String hidgroupdoc;
	private String insurexcess;
	private String cdwexcess;
	private String scdwexcess;
	private String securityamt;
	//Getters & Setters for Print
	
	private String lblcompname;
	private String lblcompaddress;
	private String lblcomptel;
	private String lblcompfax;
	private String lbldocno;
	private String lblfromdate;
	private String lbltodate;
	private String lbltariftype;
	private String lblclient;
	private String lblbranch;
	private String lblprintname;
	
	
	public String getLblprintname() {
		return lblprintname;
	}
	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}
	public String getLblbranch() {
		return lblbranch;
	}
	public void setLblbranch(String lblbranch) {
		this.lblbranch = lblbranch;
	}
	public String getLbldocno() {
		return lbldocno;
	}
	public void setLbldocno(String lbldocno) {
		this.lbldocno = lbldocno;
	}
	public String getLblfromdate() {
		return lblfromdate;
	}
	public void setLblfromdate(String lblfromdate) {
		this.lblfromdate = lblfromdate;
	}
	public String getLbltodate() {
		return lbltodate;
	}
	public void setLbltodate(String lbltodate) {
		this.lbltodate = lbltodate;
	}
	public String getLbltariftype() {
		return lbltariftype;
	}
	public void setLbltariftype(String lbltariftype) {
		this.lbltariftype = lbltariftype;
	}
	public String getLblclient() {
		return lblclient;
	}
	public void setLblclient(String lblclient) {
		this.lblclient = lblclient;
	}
	public String getLblcompname() {
		return lblcompname;
	}
	public void setLblcompname(String lblcompname) {
		this.lblcompname = lblcompname;
	}
	public String getLblcompaddress() {
		return lblcompaddress;
	}
	public void setLblcompaddress(String lblcompaddress) {
		this.lblcompaddress = lblcompaddress;
	}
	public String getLblcomptel() {
		return lblcomptel;
	}
	public void setLblcomptel(String lblcomptel) {
		this.lblcomptel = lblcomptel;
	}
	public String getLblcompfax() {
		return lblcompfax;
	}
	public void setLblcompfax(String lblcompfax) {
		this.lblcompfax = lblcompfax;
	}
	public String getInsurexcess() {
		return insurexcess;
	}
	public void setInsurexcess(String insurexcess) {
		this.insurexcess = insurexcess;
	}
	public String getCdwexcess() {
		return cdwexcess;
	}
	public void setCdwexcess(String cdwexcess) {
		this.cdwexcess = cdwexcess;
	}
	public String getScdwexcess() {
		return scdwexcess;
	}
	public void setScdwexcess(String scdwexcess) {
		this.scdwexcess = scdwexcess;
	}
	public String getHidgroupdoc() {
		return hidgroupdoc;
	}
	public void setHidgroupdoc(String hidgroupdoc) {
		this.hidgroupdoc = hidgroupdoc;
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
	public String getTempstatus() {
		return tempstatus;
	}
	public void setTempstatus(String tempstatus) {
		this.tempstatus = tempstatus;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getTxtclient() {
		return txtclient;
	}
	public void setTxtclient(String txtclient) {
		this.txtclient = txtclient;
	}
	public int getHidtxtclient() {
		return hidtxtclient;
	}
	public void setHidtxtclient(int hidtxtclient) {
		this.hidtxtclient = hidtxtclient;
	}
	public String getTest4() {
		return test4;
	}
	public void setTest4(String test4) {
		this.test4 = test4;
	}
	public String getTxtweekday1() {
		return txtweekday1;
	}
	public void setTxtweekday1(String txtweekday1) {
		this.txtweekday1 = txtweekday1;
	}
	private String txtfoc0;

	public String getTxtfoc0() {
	return txtfoc0;
	}
	public void setTxtfoc0(String txtfoc0) {
	this.txtfoc0 = txtfoc0;
	}


	public int getDeliverylength() {
	return deliverylength;
	}
	public void setDeliverylength(int deliverylength) {
	this.deliverylength = deliverylength;
	}
	public String getTxtdelivery0() {
	return txtdelivery0;
	}
	public void setTxtdelivery0(String txtdelivery0) {
	this.txtdelivery0 = txtdelivery0;
	}
				
		
		public String getTxtfoc1() {
			return txtfoc1;
		}
		public void setTxtfoc1(String txtfoc1) {
			this.txtfoc1 = txtfoc1;
		}
		
		public String getTxtweekday2() {
			return txtweekday2;
		}
		public void setTxtweekday2(String txtweekday2) {
			this.txtweekday2 = txtweekday2;
		}
		public int getFuellength() {
			return fuellength;
		}
		public void setFuellength(int fuellength) {
			this.fuellength = fuellength;
		}
		public String getTxtfuel0() {
			return txtfuel0;
		}
		public void setTxtfuel0(String txtfuel0) {
			this.txtfuel0 = txtfuel0;
		}
		public int getFoclength() {
			return foclength;
		}
		public void setFoclength(int foclength) {
			this.foclength = foclength;
		}
		public int getWeekdaylength() {
			return weekdaylength;
		}
		public void setGridweekday(String gridweekday) {
			this.gridweekday = gridweekday;
		}
		public int getGridweekday() {
			return weekdaylength;
		}
		public void setWeekdaylength(int weekdaylength) {
			this.weekdaylength = weekdaylength;
		}
		public String getTarifmode() {
			return tarifmode;
		}
		public void setTarifmode(String tarifmode) {
			this.tarifmode = tarifmode;
		}
		public String getTxtweekday0() {
			return txtweekday0;
		}
		public void setTxtweekday0(String txtweekday0) {
			this.txtweekday0 = txtweekday0;
		}
	public String getTest0() {
		return test0;
	}
	public void setTest0(String test0) {
		this.test0 = test0;
	}

	public String getTest1() {
		return test1;
	}
	public void setTest1(String test1) {
		this.test1 = test1;
	}
	public String getTest2() {
		return test2;
	}
	public void setTest2(String test2) {
		this.test2 = test2;
	}
	public String getTest3() {
		return test3;
	}
	public void setTest3(String test3) {
		this.test3 = test3;
	}
	
	
	
	public String getTempgroup() {
		return tempgroup;
	}
	public void setTempgroup(String tempgroup) {
		this.tempgroup = tempgroup;
	}
	public String getChckdeliverychg() {
		return chckdeliverychg;
	}
	public void setChckdeliverychg(String chckdeliverychg) {
		this.chckdeliverychg = chckdeliverychg;
	}

	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	public String getJqxTariffDate() {
	return jqxTariffDate;
}
public void setJqxTariffDate(String jqxTariffDate) {
	this.jqxTariffDate = jqxTariffDate;
}
public String getJqxTariffToDate() {
	return jqxTariffToDate;
}
public void setJqxTariffToDate(String jqxTariffToDate) {
	this.jqxTariffToDate = jqxTariffToDate;
}
public String getJqxTariffFromDate() {
	return jqxTariffFromDate;
}
public void setJqxTariffFromDate(String jqxTariffFromDate) {
	this.jqxTariffFromDate = jqxTariffFromDate;
}
	public int getDocno() {
	return docno;
}
public void setDocno(int docno) {
	this.docno = docno;
}
public String getHidjqxTariffDate() {
	return hidjqxTariffDate;
}
public void setHidjqxTariffDate(String hidjqxTariffDate) {
	this.hidjqxTariffDate = hidjqxTariffDate;
}
public String getCmbtariftype() {
	return cmbtariftype;
}
public void setCmbtariftype(String cmbtariftype) {
	this.cmbtariftype = cmbtariftype;
}
public String getHidcmbtariftype() {
	return hidcmbtariftype;
}
public void setHidcmbtariftype(String hidcmbtariftype) {
	this.hidcmbtariftype = hidcmbtariftype;
}
public String getCmbtariffor() {
	return cmbtariffor;
}
public void setCmbtariffor(String cmbtariffor) {
	this.cmbtariffor = cmbtariffor;
}
public String getHidcmbtariffor() {
	return hidcmbtariffor;
}
public void setHidcmbtariffor(String hidcmbtariffor) {
	this.hidcmbtariffor = hidcmbtariffor;
}
public String getHidjqxTariffFromDate() {
	return hidjqxTariffFromDate;
}
public void setHidjqxTariffFromDate(String hidjqxTariffFromDate) {
	this.hidjqxTariffFromDate = hidjqxTariffFromDate;
}
public String getHidjqxTariffToDate() {
	return hidjqxTariffToDate;
}
public void setHidjqxTariffToDate(String hidjqxTariffToDate) {
	this.hidjqxTariffToDate = hidjqxTariffToDate;
}
public String getHidcheck() {
	return hidcheck;
}
public void setHidcheck(String hidcheck) {
	this.hidcheck = hidcheck;
}
public String getNotes() {
	return notes;
}
public void setNotes(String notes) {
	this.notes = notes;
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



public String getSecurityamt() {
	return securityamt;
}
public void setSecurityamt(String securityamt) {
	this.securityamt = securityamt;
}
public void getValues(){
	setHidcmbtariffor(getCmbtariffor());
	setHidcheck(getHidcheck());
	setHidcmbtariftype(getCmbtariftype());
	setHidjqxTariffFromDate(getJqxTariffFromDate());
	setHidjqxTariffToDate(getJqxTariffToDate());
	setNotes(getNotes());
	setHidtxtclient(getHidtxtclient());
	setTxtclient(getTxtclient());
	setMode(getMode());
	setSecurityamt(getSecurityamt());
}
public String saveAction() throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	//System.out.println("hhhhhhhhhhhhhhhhheeeeeeeeeee"+getMode()+","+getDate_plateCode());
	Map<String, String[]> requestParams = request.getParameterMap();
//System.out.println("hai");
	session.getAttribute("BRANCHID");

	String mode=getMode();
	ClsTarifBean bean=new ClsTarifBean();
//	System.out.println("mode"+mode);
java.sql.Date sqlStartDate =null;
java.sql.Date fromdate=null;
java.sql.Date todate=null;
	if(getJqxTariffDate()!=null){
		 sqlStartDate = ClsCommon.changeStringtoSqlDate(getJqxTariffDate());
	}
if(getJqxTariffFromDate()!=null){
	 fromdate = ClsCommon.changeStringtoSqlDate(getJqxTariffFromDate());

}
if(getJqxTariffToDate()!=null){
	 todate = ClsCommon.changeStringtoSqlDate(getJqxTariffToDate());

}
if(mode.equalsIgnoreCase("A")){
//		System.out.println("Action DocNo1"+getDocno());
		if(getDocno()<=0){
				
					int val=tarifDAO.insert(sqlStartDate,fromdate,todate,getCmbtariftype(),getCmbtariffor(),getNotes(),getHidcheck(),getHidtxtclient(),session,getMode(),getFormdetailcode());
					
					
					if(val>0.0){
							
						getValues();
						//System.out.println(val);
						setDocno(val);
						setMsg("Successfully Saved");

						return "success";
					}
					else{
						setMsg("Not Saved");

						return "fail";
					}
		}
		else{
			//System.out.println("Check Tariftype: "+getCmbtariftype());
			
		if(getCmbtariftype().equalsIgnoreCase("regular") || getCmbtariftype().equalsIgnoreCase("promotion") || getCmbtariftype().equalsIgnoreCase("corporate")){
			if(getGridlength()>0){
			ArrayList<String> tarifarray= new ArrayList<>();
			for(int i=0;i<getGridlength();i++){
				ClsTarifBean tarifbean=new ClsTarifBean();
				String temp=requestParams.get("test"+i)[0];
				tarifarray.add(temp);
			}
//			System.out.println("Gid in Action "+getHidgroupdoc());
			int val=tarifDAO.insert_detail(tarifarray,getTempgroup(),getDocno(),session,getTempstatus(),getHidgroupdoc());
//			System.out.println("inside DAO regular");
			if(val>0.0){
				int val2=tarifDAO.excessinsert(getDocno(), getHidgroupdoc(), getInsurexcess(), getCdwexcess(), getScdwexcess(),getSecurityamt());
				if(val2<0){
					
					return "fail";
				}
				getValues();
if(!(getCmbtariftype().equalsIgnoreCase("Client"))){
	setTxtclient("");

}
				setMsg("Successfully Saved");
			}
			else{
				getValues();
				if(!(getCmbtariftype().equalsIgnoreCase("Client"))){
					setTxtclient("");

				}
				setMsg("Not Saved");
				//System.out.println("fail");
			}
			}
		}
		else{
			int val2=tarifDAO.excessinsert(getDocno(), getHidgroupdoc(), getInsurexcess(), getCdwexcess(), getScdwexcess(),getSecurityamt());
	if(val2<0){
		return "fail";
	}
			if(getCmbtariftype().equalsIgnoreCase("Weekend")){
					ArrayList<String> weekdayarray= new ArrayList<>();
					//System.out.println("Inside Weekend");
					//System.out.println("Weekday Length: "+weekdaylength);
							for(int i=0;i<getWeekdaylength();i++){
								ClsTarifBean tarifbean=new ClsTarifBean();
								String tempweekday=requestParams.get("txtweekday"+i)[0];
								weekdayarray.add(tempweekday);
							//	System.out.println(tempweekday);
							}
					
					int valweekday=tarifDAO.insert_weekday(weekdayarray,getTempgroup(),getDocno(),session,getTempstatus(),getHidgroupdoc());
					if(valweekday>0){
						
						getValues();
						if(!(getCmbtariftype().equalsIgnoreCase("Client"))){
							setTxtclient("");

						}
						setMsg("Successfully Saved");
//						System.out.println("Success");
					}
					else{
						getValues();
						if(!(getCmbtariftype().equalsIgnoreCase("Client"))){
							setTxtclient("");

						}
						setMsg("Not Saved");
						return "fail";
					}
			}
			if(getCmbtariftype().equalsIgnoreCase("FOC")){
						ArrayList<String> focarray= new ArrayList<>();
						for(int i=0;i<getFoclength();i++){
							ClsTarifBean tarifbean=new ClsTarifBean();
							String tempfoc=requestParams.get("txtfoc"+i)[0];
							focarray.add(tempfoc);
						}
						
						int valfoc=tarifDAO.insert_foc(focarray,getTempgroup(),getDocno(),session,getTempstatus(),getHidgroupdoc());
//						System.out.println("inside DAO foc");
						if(valfoc>0){
							getValues();
							if(!(getCmbtariftype().equalsIgnoreCase("Client"))){
								setTxtclient("");

							}
							setMsg("Successfully Saved");
						}
						else{
							getValues();
							if(!(getCmbtariftype().equalsIgnoreCase("Client"))){
								setTxtclient("");

							}
							setMsg("Not Saved");
						}
			}
		}
		}
		
	
		
	}
	else if(mode.equalsIgnoreCase("E")){
		boolean Status=tarifDAO.edit(sqlStartDate,fromdate,todate,getCmbtariftype(),getCmbtariffor(),getNotes(),getHidcheck(),getHidtxtclient(),session,getMode(),getDocno(),getFormdetailcode());
		//System.out.println("after edit stmt");
		if(Status){
			getValues();
			if(!(getCmbtariftype().equalsIgnoreCase("Client"))){
				setTxtclient("");
			}
			setDocno(getDocno());
			
			setMsg("Updated Successfully");

			return "success";
		}
		else{
			getValues();
			if(!(getCmbtariftype().equalsIgnoreCase("Client"))){
				setTxtclient("");

			}
			setDocno(getDocno());
			setMsg("Not Updated");

			return "fail";
		}
	}
	else if(mode.equalsIgnoreCase("D")){
		boolean Status=tarifDAO.delete(sqlStartDate,fromdate,todate,getCmbtariftype(),getCmbtariffor(),getNotes(),getHidcheck(),getHidtxtclient(),session,getMode(),getDocno(),getFormdetailcode());
	if(Status){
		getValues();
		if(!(getCmbtariftype().equalsIgnoreCase("Client"))){
			setTxtclient("");

		}
		setDocno(getDocno());
		setDelete("DELETED");
		setMsg("Successfully Deleted");

		return "success";
	}
	else{
		getValues();
		if(!(getCmbtariftype().equalsIgnoreCase("Client"))){
			setTxtclient("");

		}
		setDocno(getDocno());
		setMsg("Not Deleted");

		return "fail";
	}
	}
	return "fail";
}
public String printAction() throws ParseException, SQLException{
//	System.out.println("Inside print Action");
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	bean=tarifDAO.getPrint(getDocno());
	setLblcompname(bean.getLblcompname());
	setLblcompaddress(bean.getLblcompaddress());
	setLblcompfax(bean.getLblcompfax());
	setLblcomptel(bean.getLblcomptel());
	setLblbranch(bean.getLblbranch());
	setLbldocno(bean.getLbldocno());
	setLbltariftype(bean.getLbltariftype());
	setLblclient(bean.getLblclient());
	setLblfromdate(bean.getLblfromdate());
	setLbltodate(bean.getLbltodate());
	setLblprintname("Tariff Management");
	ArrayList<String> normaltarifprint=tarifDAO.getNormalTarifPrint(getDocno());
	request.setAttribute("NORMALPRINT", normaltarifprint);
	return "print";
}


	private int getfoclength() {
	// TODO Auto-generated method stub
	return 0;
}
	public JSONArray searchDetails(){
		  JSONArray cellarray = new JSONArray();
		  JSONObject cellobj = null;
		  try {
			  List <ClsTarifBean> list= tarifDAO.list(getDocno(),getTempgroup());
			  for(ClsTarifBean bean:list){
			  cellobj = new JSONObject();
			  cellobj.put("gid", bean.getGroup());
			 cellarray.add(cellobj);
			 }
		  } catch (SQLException e) {
		  }
		return cellarray;
	}
	/*public  JSONArray searchDetails2(){
		  JSONArray cellarray = new JSONArray();
		  JSONObject cellobj = null;
		  try {
			  List <ClsTarifBean> list= tarifDAO.list2();
			  for(ClsTarifBean bean:list){
			  cellobj = new JSONObject();
			  cellobj.put("", bean.getGroup());
			  
			 cellarray.add(cellobj);

			 }
		  } catch (SQLException e) {
		  }
		return cellarray;
	}*/
	public  JSONArray searchDetails3(){
		  JSONArray cellarray = new JSONArray();
		  JSONObject cellobj = null;
		  try {
			  List <ClsTarifBean> list= tarifDAO.list3();
			  for(ClsTarifBean bean:list){
			  cellobj = new JSONObject();
			  cellobj.put("branch", bean.getBranch());
			  cellobj.put("area",bean.getArea());
			  cellobj.put("tariff",bean.getTariff());
			 cellarray.add(cellobj);

			 }
		  } catch (SQLException e) {
		  }
		return cellarray;
	}
	public  JSONArray searchDetails4(){
		  JSONArray cellarray = new JSONArray();
		  JSONObject cellobj = null;
		  try {
			  List <ClsTarifBean> list= tarifDAO.list4();
			  for(ClsTarifBean bean:list){
			  cellobj = new JSONObject();
			 
			  cellobj.put("quarter",bean.getQuarter());
			  cellobj.put("half",bean.getHalf());
			  cellobj.put("triquarter",bean.getTriquarter());
			  cellobj.put("full", bean.getFull());
			 cellarray.add(cellobj);

			 }
		  } catch (SQLException e) {
		  }
		return cellarray;
	}
	public  JSONArray searchDetails1(){
		JSONArray cellarray = new JSONArray();
		  JSONObject cellobj = null;
		  try {
			  
			  List <ClsTarifBean> list= tarifDAO.list1();
			  for(ClsTarifBean bean:list){
			  cellobj = new JSONObject();
			  cellobj.put("rentaltype", bean.getRatedesc());
			 cellarray.add(cellobj);

			 }
				 //System.out.println(" Tariff cellobj"+cellarray);
		  } catch (SQLException e) {
		  }
		return cellarray;
	}
	public  JSONArray searchDetails_weekday(){
		  JSONArray cellarray = new JSONArray();
		  JSONObject cellobj = null;
		  try {
			  List <ClsTarifBean> list= tarifDAO.listweekday();
			  for(ClsTarifBean bean:list){
			  cellobj = new JSONObject();
			 
			 cellarray.add(cellobj);

			 }
				// System.out.println("cellobj"+cellarray);
		  } catch (SQLException e) {
		  }
		return cellarray;
	}
	public  JSONArray searchDetails_foc(){
		  JSONArray cellarray = new JSONArray();
		  JSONObject cellobj = null;
		  try {
			  List <ClsTarifBean> list= tarifDAO.listfoc();
			  for(ClsTarifBean bean:list){
			  cellobj = new JSONObject();
			  
			 cellarray.add(cellobj);

			 }
		  } catch (SQLException e) {
		  }
		return cellarray;
	}
	public  JSONArray mainSearch(){
		  JSONArray cellarray = new JSONArray();
		  JSONObject cellobj = null;
		  try {
			  List <ClsTarifBean> list= tarifDAO.mainSearchList();
			  for(ClsTarifBean bean:list){
			  cellobj = new JSONObject();
			  cellobj.put("docno", bean.getDocno());
			  cellobj.put("date", bean.getJqxTariffDate());
			  cellobj.put("tariftype", bean.getCmbtariftype());
			  cellobj.put("tariffor", bean.getCmbtariffor());
			  cellobj.put("fromdate", bean.getJqxTariffFromDate());
			  cellobj.put("todate", bean.getJqxTariffToDate());
			 cellobj.put("notes", bean.getNotes());
			 cellobj.put("clientid",bean.getHidtxtclient());
			 cellobj.put("clientname",bean.getTxtclient());
			 cellarray.add(cellobj);

			 }
//				 System.out.println("cellobj"+cellarray);
		  } catch (SQLException e) {
		  }
		return cellarray;
	}
	public  JSONArray searchDetailsGrpComplete(){
		
		  JSONArray cellarray = new JSONArray();
		  JSONObject cellobj = null;
		  try {
			  List <ClsTarifBean> list= tarifDAO.listGrpComplete();
			  for(ClsTarifBean bean:list){
			  cellobj = new JSONObject();
			  cellobj.put("gid1", bean.getGroup1());
			 cellarray.add(cellobj);
			 }
				// System.out.println("cellobj"+cellarray);
		  } catch (SQLException e) {
		  }
		return cellarray;
	}
	public  JSONArray searchDelivery(){
		
		  JSONArray cellarray = new JSONArray();
		  JSONObject cellobj = null;
		  try {
			  List <ClsTarifBean> list= tarifDAO.listSearchDelivery();
			  for(ClsTarifBean bean:list){
			  cellobj = new JSONObject();
			  cellobj.put("deldoc_no",bean.getDeldocno());
			  cellobj.put("delarea", bean.getDelarea());
			  
			 cellarray.add(cellobj);
			 }
				// System.out.println("cellobj"+cellarray);
		  } catch (SQLException e) {
		  }
		return cellarray;
	}
}
