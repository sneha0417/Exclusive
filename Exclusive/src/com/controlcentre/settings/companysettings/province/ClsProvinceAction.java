package com.controlcentre.settings.companysettings.province;


import com.opensymphony.xwork2.ActionSupport;
import com.common.ClsCommon;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;


public class ClsProvinceAction{
	ClsCommon ClsCommon=new ClsCommon();
	
	ClsProvinceDAO ProvinceDAO= new ClsProvinceDAO();
	private int docno;
	private int txtprovincecode;
	private String txtprovincename;
	private String mode;
	private String deleted;
	private String msg;
	private String formdetailcode;
	private String date_province;
	

	public String getDate_province() {
		return date_province;
	}
	public void setDate_province(String date_province) {
		this.date_province = date_province;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
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
	public int getTxtprovincecode() {
		return txtprovincecode;
	}
	public void setTxtprovincecode(int txtprovincecode) {
		this.txtprovincecode = txtprovincecode;
	}
	public String getTxtprovincename() {
		return txtprovincename;
	}
	public void setTxtprovincename(String txtprovincename) {
		this.txtprovincename = txtprovincename;
	}
	
	public void setValues(int docno){
		setTxtprovincecode(getTxtprovincecode());
		setTxtprovincename(getTxtprovincename());
		setDocno(docno);
	}
	public String saveActionProvince() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		//System.out.println("inside -------------------getMode--------------------------------a"+getMode());
		
		if(getMode().equalsIgnoreCase("A")){
			java.sql.Date sqlDate = ClsCommon.changeStringtoSqlDate(getDate_province());
		System.out.println("inside ---------------------------------------------------a");
						int val=ProvinceDAO.insert(sqlDate,getTxtprovincecode(),getTxtprovincename(),session,getMode(),getDocno(),getFormdetailcode());
						if(val>0.0){
								setValues(val);
								setMsg("Successfully Saved");

								return "success";
							}
							else{
								setValues(val);
								setMsg("Not Saved");

								return "fail";
							}	
			}
		
		
		else if(getMode().equalsIgnoreCase("E")){
			java.sql.Date sqlDate = ClsCommon.changeStringtoSqlDate(getDate_province());
			boolean Status=ProvinceDAO.edit(sqlDate,getTxtprovincecode(),getTxtprovincename(),session,getMode(),getDocno(),getFormdetailcode());
			if(Status){
				setValues(getDocno());
			//	System.out.println("brand"+brand);
				//System.out.println("-------------------------------");
				setMsg("Updated Successfully");

				return "success";
			}
			else{
				setValues(getDocno());
				setMsg("Not Updated");

				return "fail";
			}
		}
		else if(getMode().equalsIgnoreCase("D")){
			java.sql.Date sqlDate = ClsCommon.changeStringtoSqlDate(getDate_province());
			//System.out.println(getDocno()+","+getBrandid()+","+getModeldate());
			int Status=ProvinceDAO.delete(sqlDate,getTxtprovincecode(),getTxtprovincename(),session,getMode(),getDocno(),getFormdetailcode());
		if(Status>0){
			setValues(getDocno());
			setDeleted("DELETED");
		//	System.out.println("brand"+brand);
			setMsg("Successfully Deleted");

			return "success";
		}
		else if(Status==-1){
			setValues(getDocno());
			setMsg("References Present in Other Documents");

			return "fail";
		}
		else{
			setValues(getDocno());
			setMsg("Not Deleted");

			return "fail";
		}
	}
		return "fail";
	}
}

		
	


		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		

	

