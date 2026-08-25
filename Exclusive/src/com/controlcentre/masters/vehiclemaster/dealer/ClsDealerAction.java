package com.controlcentre.masters.vehiclemaster.dealer;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

public class ClsDealerAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
	ClsDealerDAO dealerDAO= new ClsDealerDAO();
	ClsDealerBean bean;
private int docno;
private String dealerid;
private String dealername;
private String accno;
private int txtaccno;
private String mode;
private String deleted;
private String dealerdate;
private String dealerdatehidden;
private String txtaccname;
private String msg;
private String formdetailcode;
private String formdetail;
private String chkstatus;


public String getChkstatus() {
	return chkstatus;
}
public void setChkstatus(String chkstatus) {
	this.chkstatus = chkstatus;
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
public String getDealerdatehidden() {
	return dealerdatehidden;
}
public void setDealerdatehidden(String dealerdatehidden) {
	this.dealerdatehidden = dealerdatehidden;
}
public String getDealerdate() {
	return dealerdate;
}
public void setDealerdate(String dealerdate) {
	this.dealerdate = dealerdate;
}
public int getDocno() {
	return docno;
}
public void setDocno(int docno) {
	this.docno = docno;
}
public String getDealerid() {
	return dealerid;
}
public void setDealerid(String dealerid) {
	this.dealerid = dealerid;
}
public String getDealername() {
	return dealername;
}
public void setDealername(String dealername) {
	this.dealername = dealername;
}
public String getAccno() {
	return accno;
}
public void setAccno(String accno) {
	this.accno = accno;
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
public String saveAction() throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
//	System.out.println("hhhhhhhhhhhhhhhhheeeeeeeeeee"+getMode()+","+getModeldate());

	session.getAttribute("BranchName");
//	System.out.println("sessoin"+session.getAttribute("BRANCHSELECTED"));
//	System.out.println("sessoin"+session.getAttribute("COMPANYNAME"));
	//System.out.println("request==="+request.getAttribute("BranchName"));
	
	String mode=getMode();
	ClsDealerBean bean=new ClsDealerBean();
//	String startDate=getDate_brand();
//	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
//	java.util.Date date = sdf1.parse(startDate);
//	java.sql.Date sqlStartDate = new java.sql.Date(date.getTime()); 
	
//	Date trail=getDate_plateCode();

	java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getDealerdate());

	
	if(mode.equalsIgnoreCase("A")){
					int val=dealerDAO.insert(getDealername(),sqlStartDate,getTxtaccno(),session,getMode(),getFormdetailcode());
					if(val>0.0){
						//setDealerid(getDealerid());
						setDealerdatehidden(sqlStartDate.toString());
//						System.out.println(getDealerdatehidden());
						//setAccnohidden(getAccno());
//						System.out.println("accno"+getAccno());
						setDealername(getDealername());
						setMode(getMode());
						setTxtaccno(getTxtaccno());
						setTxtaccname(getTxtaccname());
//						System.out.println(val);
						setDocno(val);
						setMsg("Successfully Saved");

						return "success";
					}
					else if(val==-1){
						setDealerdatehidden(sqlStartDate.toString());
//						System.out.println(getDealerdatehidden());
						//setAccnohidden(getAccno());
//						System.out.println("accno"+getAccno());
						setDealername(getDealername());
						setMode(getMode());
						setTxtaccno(getTxtaccno());
						setTxtaccname(getTxtaccname());
//						System.out.println(val);
						//setDocno(val);
						setChkstatus("1");
						setMsg("Dealer Already Exists");
						return "fail";
					}
					else{
						setDealerdatehidden(sqlStartDate.toString());
//						System.out.println(getDealerdatehidden());
						//setAccnohidden(getAccno());
//						System.out.println("accno"+getAccno());
						setDealername(getDealername());
						setMode(getMode());
						setTxtaccno(getTxtaccno());
						setTxtaccname(getTxtaccname());
//						System.out.println(val);
						setDocno(val);
						setMsg("Not Saved");
						return "fail";
					}
	}


	else if(mode.equalsIgnoreCase("E")){
			int Status=dealerDAO.edit(getDealername(),getDocno(),sqlStartDate,getTxtaccno(),getMode(),session,getFormdetailcode());
			if(Status>0){
				
				//System.out.println("hhhhhhhhhhhhhhhhheeeeeeeeeee"+getMode()+","+getModeldate());
				session.getAttribute("BranchName");
				//setDealerid(getDealerid());
				setDealerdate(sqlStartDate.toString());
				setDocno(getDocno());
				setTxtaccno(getTxtaccno());
				setTxtaccname(getTxtaccname());

				setDealerdatehidden(getDealerdate());
				//System.out.println("Action"+getBrandid());
				setMode(getMode());
			//	System.out.println("brand"+brand);
				setMsg("Updated Successfully");

				return "success";
			}
			else if(Status==-1){
				setDealerdate(sqlStartDate.toString());
//				setDocno(getDocno());
				setTxtaccno(getTxtaccno());
				setTxtaccname(getTxtaccname());
				setChkstatus("2");
				setDealerdatehidden(getDealerdate());
				//System.out.println("Action"+getBrandid());
				setMode(getMode());
				setMsg("Dealer Already Exists");
				return "fail";
			}
			else{
				setDealerdate(sqlStartDate.toString());
				setDocno(getDocno());
				setTxtaccno(getTxtaccno());
				setTxtaccname(getTxtaccname());

				setDealerdatehidden(getDealerdate());
				//System.out.println("Action"+getBrandid());
				setMode(getMode());
				setMsg("Not Updated");

				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			//System.out.println(getDocno()+","+getBrandid()+","+getModeldate());
			int Status=dealerDAO.delete(getDealername(),getDocno(),sqlStartDate,getTxtaccno(),getMode(),session,getFormdetailcode());
		if(Status>0){
			//setDealerid(getDealerid());
			setDocno(getDocno());
			setDealername(getDealername());
			setTxtaccno(getTxtaccno());
			setTxtaccname(getTxtaccname());

			setDealerdatehidden(sqlStartDate.toString());
			setDeleted("DELETED");
			setMsg("Successfully Deleted");

			return "success";
		}
		else if(Status==-2){
			setDocno(getDocno());
			setDealername(getDealername());
			setTxtaccno(getTxtaccno());
			setTxtaccname(getTxtaccname());

			setDealerdatehidden(sqlStartDate.toString());
			setMsg("References Present in Other Documents");
			return "fail";
		}
		else{
			setDocno(getDocno());
			setDealername(getDealername());
			setTxtaccno(getTxtaccno());
			setTxtaccname(getTxtaccname());

			setDealerdatehidden(sqlStartDate.toString());
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
			  List <ClsDealerBean> list= dealerDAO.list();
			  for(ClsDealerBean bean:list){
			  cellobj = new JSONObject();
			  cellobj.put("DOC_NO", bean.getDocno());
			  cellobj.put("name",bean.getDealername());
			  cellobj.put("date",bean.getDealerdate().toString());
			  cellobj.put("acc_no",bean.getTxtaccno());
			  cellobj.put("description", bean.getTxtaccname());
			 cellarray.add(cellobj);

			 }
//		 System.out.println("cellobj"+cellarray);
		  } catch (SQLException e) {
			  e.printStackTrace();
		  }
		return cellarray;
	}
	public  JSONArray accountsSearch(){
		JSONArray cellarray = new JSONArray();
		  JSONObject cellobj = null;
		  try {
			  List <ClsDealerBean> list= dealerDAO.listacc();
			  for(ClsDealerBean bean:list){
			  cellobj = new JSONObject();
			  cellobj.put("DOC_NO", bean.getTxtaccno());
			  cellobj.put("description",bean.getTxtaccname());
			 cellarray.add(cellobj);

			 }
				// System.out.println("cellobj"+cellarray);
		  } catch (SQLException e) {
			  e.printStackTrace();
		  }
		return cellarray;
	}
}

