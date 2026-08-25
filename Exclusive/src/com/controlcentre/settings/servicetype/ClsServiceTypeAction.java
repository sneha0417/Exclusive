package com.controlcentre.settings.servicetype;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;


public class ClsServiceTypeAction {
	ClsServiceTypeDAO DAO= new ClsServiceTypeDAO();
	ClsCommon com=new ClsCommon();
	ClsServiceTypeBean bean;

	private int docno;
	private String date;
	private String mode;
	private String deleted;
	private String hiddate;
	private String msg;
	private String txtname;
	private String txtdesc;
	private int descgridlen;
	private String formdetailcode;


	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public int getDescgridlen() {
		return descgridlen;
	}
	public void setDescgridlen(int descgridlen) {
		this.descgridlen = descgridlen;
	}
	public String getHiddate() {
		return hiddate;
	}
	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getTxtname() {
		return txtname;
	}
	public void setTxtname(String txtname) {
		this.txtname = txtname;
	}
	public String getTxtdesc() {
		return txtdesc;
	}
	public void setTxtdesc(String txtdesc) {
		this.txtdesc = txtdesc;
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

	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String saveAction() throws ParseException, SQLException{

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		ClsServiceTypeBean bean=new ClsServiceTypeBean();
		java.sql.Date sqlStartDate = com.changeStringtoSqlDate(getDate());
		bean.setTxtname(getTxtname());
		bean.setTxtdesc(getTxtdesc());
		bean.setDate(sqlStartDate.toString());
		bean.setDocno(getDocno());
		bean.setMode(getMode());
		if(mode.equalsIgnoreCase("A")){


			ArrayList<String> descarray= new ArrayList<>();

			Map<String, String[]> requestParams = request.getParameterMap();
			for(int i=0;i<getDescgridlen();i++){

				String temp=requestParams.get("test"+i)[0];

				descarray.add(temp);
			}


			int val=DAO.insert(getTxtname(),getTxtdesc(),descarray,session,sqlStartDate,getMode(),getFormdetailcode());
			if(val>0){
				setDate(sqlStartDate.toString());
				setTxtname(getTxtname());
				setTxtdesc(getTxtdesc());
				setDocno(val);
				setMsg("Successfully Saved");

				return "success";
			}
			else{
				setMsg("Not Saved");
				return "fail";
			}	

		}

		else if(mode.equalsIgnoreCase("E")){


			ArrayList<String> descarray= new ArrayList<>();

			Map<String, String[]> requestParams = request.getParameterMap();
			for(int i=0;i<getDescgridlen();i++){

				String temp=requestParams.get("test"+i)[0];

				descarray.add(temp);
			}


			int val=DAO.edit(getDocno(),getTxtname(),getTxtdesc(),descarray,session,sqlStartDate,getMode(),getFormdetailcode());
			if(val>0){
				setDate(sqlStartDate.toString());
				setTxtname(getTxtname());
				setTxtdesc(getTxtdesc());
				setDocno(getDocno());
				setMsg("Updated Successfully");

				return "success";
			}
			else{
				setMsg("Not Updated");
				return "fail";
			}	

		}

		else if(mode.equalsIgnoreCase("D")){


			ArrayList<String> descarray= new ArrayList<>();

			Map<String, String[]> requestParams = request.getParameterMap();
			for(int i=0;i<getDescgridlen();i++){

				String temp=requestParams.get("test"+i)[0];

				descarray.add(temp);
			}


			int val=DAO.delete(getDocno(),getTxtname(),getTxtdesc(),descarray,session,sqlStartDate,getMode(),getFormdetailcode());
			if(val>0){
				setDate(sqlStartDate.toString());
				setTxtname(getTxtname());
				setTxtdesc(getTxtdesc());
				setDocno(getDocno());
				setDeleted("DELETED");
				setMsg("Successfully Deleted");

				return "success";
			}
			else{
				setMsg("Not Deleted");
				return "fail";
			}	

		}


		return "fail";
	}

}
