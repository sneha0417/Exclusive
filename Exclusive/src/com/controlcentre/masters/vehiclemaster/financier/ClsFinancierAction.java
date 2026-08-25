package com.controlcentre.masters.vehiclemaster.financier;
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

public class ClsFinancierAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
	ClsFinancierDAO financierDAO= new ClsFinancierDAO();
	ClsFinancierBean bean;
private int docno;
private String finid;
private String findate;
private String finname;
private String mode;
private String deleted;
private String accno;
private int txtaccno;
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

public void setTxtaccno(int txtaccno) {
	this.txtaccno = txtaccno;
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
public int getDocno() {
	return docno;
}
public void setDocno(int docno) {
	this.docno = docno;
}
public String getFinid() {
	return finid;
}
public void setFinid(String finid) {
	this.finid = finid;
}
public String getFindate() {
	return findate;
}
public void setFindate(String findate) {
	this.findate = findate;
}
public String getFinname() {
	return finname;
}
public void setFinname(String finname) {
	this.finname = finname;
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

public String getAccno() {
	return accno;
}
public void setAccno(String accno) {
	this.accno = accno;
}

public String saveAction() throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	//System.out.println("hhhhhhhhhhhhhhhhheeeeeeeeeee"+getMode()+","+getModeldate());

	session.getAttribute("BranchName");
//	System.out.println("sessoin"+session.getAttribute("BRANCHSELECTED"));
//	System.out.println("sessoin"+session.getAttribute("COMPANYNAME"));
	//System.out.println("request==="+request.getAttribute("BranchName"));
	
	String mode=getMode();
	ClsFinancierBean bean=new ClsFinancierBean();
//	String startDate=getDate_brand();
//	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
//	java.util.Date date = sdf1.parse(startDate);
//	java.sql.Date sqlStartDate = new java.sql.Date(date.getTime()); 
	
//	Date trail=getDate_plateCode();
	java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getFindate());

	if(mode.equalsIgnoreCase("A")){
					int val=financierDAO.insert(getFinid(),getFinname(),sqlStartDate,getTxtaccno(),session,getMode(),getFormdetailcode());
					if(val>0.0){
						setFinid(getFinid());
						setFinname(getFinname());
						setMode(getMode());
						setTxtaccno(getTxtaccno());
						setFindate(sqlStartDate.toString());
						setTxtaccname(getTxtaccname());
//						System.out.println(val);
						setDocno(val);
						setMsg("Successfully Saved");

						return "success";
					}
					else if(val==-1){
						setFinid(getFinid());
						setFinname(getFinname());
						setMode(getMode());
						setTxtaccno(getTxtaccno());
						setFindate(sqlStartDate.toString());
						setTxtaccname(getTxtaccname());
//						System.out.println(val);
						//setDocno(val);
						setChkstatus("1");
						setMsg("Financier Already Exists");
						return "fail";
					}
					else{
						setFinid(getFinid());
						setFinname(getFinname());
						setMode(getMode());
						setTxtaccno(getTxtaccno());
						setFindate(sqlStartDate.toString());
						setTxtaccname(getTxtaccname());
//						System.out.println(val);
						setDocno(val);
						setMsg("Not Saved");
						return "fail";
					}
	}


	else if(mode.equalsIgnoreCase("E")){
			int Status=financierDAO.edit(getFinid(),getFinname(),getDocno(),sqlStartDate,getTxtaccno(),getMode(),session,getFormdetailcode());
			if(Status>0){
				
				//System.out.println("hhhhhhhhhhhhhhhhheeeeeeeeeee"+getMode()+","+getModeldate());
				session.getAttribute("BranchName");
				setFinid(getFinid());
				setFindate(sqlStartDate.toString());
				setDocno(getDocno());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				//System.out.println("Action"+getBrandid());
				setMode(getMode());
			//	System.out.println("brand"+brand);
				setMsg("Updated Successfully");

				return "success";
			}
			else if(Status==-1){
				setFinid(getFinid());
				setFindate(sqlStartDate.toString());
				//setDocno(getDocno());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				//System.out.println("Action"+getBrandid());
				setChkstatus("2");
				//setMode(getMode());
				setMsg("Financier Already Exists");
				return "fail";
			}
			else{
				setFinid(getFinid());
				setFindate(sqlStartDate.toString());
				setDocno(getDocno());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				//System.out.println("Action"+getBrandid());
				setMode(getMode());
				setMsg("Not Updated");

				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			//System.out.println(getDocno()+","+getBrandid()+","+getModeldate());
			int Status=financierDAO.delete(getFinid(),getFinname(),getDocno(),sqlStartDate,getTxtaccno(),getMode(),session,getFormdetailcode());
		if(Status>0){
			setFinid(getFinid());
			setDocno(getDocno());
			setFinname(getFinname());
			setFindate(sqlStartDate.toString());

			setTxtaccname(getTxtaccname());
			setTxtaccno(getTxtaccno());
			setDeleted("DELETED");
			setMsg("Successfully Deleted");

			return "success";
		}
		else if(Status==-2){
			setFinid(getFinid());
			setDocno(getDocno());
			setFinname(getFinname());
			setFindate(sqlStartDate.toString());

			setTxtaccname(getTxtaccname());
			setTxtaccno(getTxtaccno());
			setMsg("References Present in Other Documents");
			return "fail";
		}
		else{
			setFinid(getFinid());
			setDocno(getDocno());
			setFinname(getFinname());
			setFindate(sqlStartDate.toString());

			setTxtaccname(getTxtaccname());
			setTxtaccno(getTxtaccno());
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
			  List <ClsFinancierBean> list= financierDAO.list();
			  for(ClsFinancierBean bean:list){
			  cellobj = new JSONObject();
			  cellobj.put("DOC_NO", bean.getDocno());
			  cellobj.put("fname",bean.getFinname());
			  cellobj.put("fid",bean.getFinid());
			  cellobj.put("date",bean.getFindate().toString());
			  cellobj.put("acc_no",bean.getTxtaccno());
			  cellobj.put("description", bean.getTxtaccname());
			 cellarray.add(cellobj);

			 }
//				 System.out.println("cellobj"+cellarray);
		  } catch (SQLException e) {
			  //e.printStackTrace();
		  }
		return cellarray;
	}
	
}

