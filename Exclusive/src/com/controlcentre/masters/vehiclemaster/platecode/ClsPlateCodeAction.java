package com.controlcentre.masters.vehiclemaster.platecode;

import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.common.ClsCommon;


@SuppressWarnings("serial")
public class ClsPlateCodeAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
	ClsPlateCodeDAO plateDAO= new ClsPlateCodeDAO();
	ClsPlateCodeBean bean;
	private int docno;
	private String mode;
	private String deleted;
	private String authName;
	private String authId;
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

	public String getAuthId() {
		return authId;
	}

	public void setAuthId(String authId) {
		this.authId = authId;
	}

	private String date_plateCode;
	private String datehidden;
	 
	public String getDatehidden() {
		return datehidden;
	}

	public void setDatehidden(String datehidden) {
		this.datehidden = datehidden;
	}

	public String getDate_plateCode() {
		return date_plateCode;
	}

	public void setDate_plateCode(String date_plateCode) {
		this.date_plateCode = date_plateCode;
	}

	private String plateCode;
	 private String platename;

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

	public String getAuthName() {
		return authName;
	}

	public void setAuthName(String authName) {
		this.authName = authName;
	}

	
	public String getPlateCode() {
		return plateCode;
	}

	public void setPlateCode(String plateCode) {
		this.plateCode = plateCode;
	}

	public String getPlatename() {
		return platename;
	}

	public void setPlatename(String platename) {
		this.platename = platename;
	}

	
	public String saveAction() throws ParseException, SQLException{
//		System.out.println("here");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();

		session.getAttribute("BranchName");
		String mode=getMode();
		ClsPlateCodeBean bean = new ClsPlateCodeBean();
		

		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getDate_plateCode());
//		System.out.println("aaaaaaaaaaaa"+sqlStartDate);
		if(mode.equalsIgnoreCase("A")){
						int val=plateDAO.insert(getPlateCode(),getPlatename(),sqlStartDate,getAuthName(),session,getFormdetailcode());
						if(val>0.0){
							setPlateCode(getPlateCode());
							setPlatename(getPlatename());
							setDocno(val);
							setDatehidden(sqlStartDate.toString());
							setAuthId(getAuthName());
							setMsg("Successfully Saved");

							return "success";
						}
						else if(val==-1){
							setPlateCode(getPlateCode());
							setPlatename(getPlatename());
							setDocno(val);
							setDatehidden(sqlStartDate.toString());
							setAuthId(getAuthName());
							//setMode("A");
							setChkstatus("1");
							setMsg("Plate Code Already Exists");
							return "fail";
						}
						else{
							setPlateCode(getPlateCode());
							setPlatename(getPlatename());
							setDocno(val);
							setDatehidden(sqlStartDate.toString());
							setAuthId(getAuthName());
							//setMode("A");
							setChkstatus("1");
							setMsg("Not Saved");
							return "fail";
						}
		}
		else if(mode.equalsIgnoreCase("E")){
			int Status=plateDAO.edit(getDocno(),sqlStartDate,getPlateCode(),getPlatename(),getAuthName(),session,getFormdetailcode());
			if(Status>0){
				setPlateCode(getPlateCode());
				setPlatename(getPlatename());
				setDatehidden(sqlStartDate.toString());
				setAuthId(getAuthName());
				setDocno(getDocno());
		//		setDate_plateCode(getDate_plateCode());
				setMsg("Updated Successfully");

				return "success";
			}
			else if(Status==-1){
				setPlateCode(getPlateCode());
				setPlatename(getPlatename());
				setDatehidden(sqlStartDate.toString());
				setAuthId(getAuthName());
				setDocno(getDocno());
				//setMode("E");
				setChkstatus("2");
				setMsg("Plate Code Already Exists");
				return "fail";
			}
			else{
				setPlateCode(getPlateCode());
				setPlatename(getPlatename());
				setDatehidden(sqlStartDate.toString());
				setAuthId(getAuthName());
				setDocno(getDocno());
				//setMode("E");

				setMsg("Not Updated");

				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			int Status=plateDAO.delete(getDocno(),session,getPlateCode(),getFormdetailcode());
		if(Status>0){
			setPlateCode(getPlateCode());
			setPlatename(getPlatename());
			setDocno(getDocno());
			setDatehidden(sqlStartDate.toString());
			setAuthId(getAuthName());
			setDate_plateCode(getDate_plateCode());
			setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
		}
		else if(Status==-2){
			setPlateCode(getPlateCode());
			setPlatename(getPlatename());
			setDocno(getDocno());
			setDatehidden(sqlStartDate.toString());
			setAuthId(getAuthName());
			setMsg("References Present in Other Documents");
			return "fail";
		}
		else{
			setPlateCode(getPlateCode());
			setPlatename(getPlatename());
			setDocno(getDocno());
			setDatehidden(sqlStartDate.toString());
			setAuthId(getAuthName());
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
			  List <ClsPlateCodeBean> list= plateDAO.list();
			  for(ClsPlateCodeBean bean:list){
			  cellobj = new JSONObject();
			  cellobj.put("doc_no", bean.getDocno());
			  cellobj.put("code_no", bean.getPlateCode());
			  cellobj.put("code_name",bean.getPlatename());
			  cellobj.put("authname",bean.getAuthName());
			  cellobj.put("authId",bean.getAuthId());
			  cellobj.put("plateDate",bean.getDate_plateCode().toString());
			 cellarray.add(cellobj);
			 }
//			  System.out.println(cellarray);
		  } catch (SQLException e) {
		  }
		return cellarray;
	}
}
