package com.controlcentre.masters.salesmanmaster.salesagent;

import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.common.ClsCommon;
import com.controlcentre.masters.salesmanmaster.salesagent.ClsSalesAgentBean;
import com.controlcentre.masters.salesmanmaster.salesagent.ClsSalesAgentDAO;

public class ClsSalesAgentAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
	ClsSalesAgentDAO salesagentDAO= new ClsSalesAgentDAO();
	ClsSalesAgentBean bean;

	private int docno;
	private String txtaccname;
	private int txtaccno;
	private String code;
	private String name;
	private String salesagentdate;
	private String hidsalesagentdate;
	private String mode;
	private String deleted;
	private String mobile;
	private String mail;
	private String msg;
	private String formdetail;
	private String formdetailcode;
	private String chkstatus;
	private String hidacno;
	private String cmbactivestatus;
	private String hidactivestatus;
	
	public String getHidacno() {
		return hidacno;
	}
	public void setHidacno(String hidacno) {
		this.hidacno = hidacno;
	}
	public String getFormdetail() {
		return formdetail;
	}
	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
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
	public int getDocno() {
		return docno ;
	}
	public void setDocno(int docno) {
		this.docno = docno;
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
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSalesagentdate() {
		return salesagentdate;
	}
	public void setSalesagentdate(String salesagentdate) {
		this.salesagentdate = salesagentdate;
	}
	public String getHidsalesagentdate() {
		return hidsalesagentdate;
	}
	public void setHidsalesagentdate(String hidsalesagentdate) {
		this.hidsalesagentdate = hidsalesagentdate;
	}
	public String getChkstatus() {
		return chkstatus;
	}
	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
	}
	public String getCmbactivestatus() {
		return cmbactivestatus;
	}
	public void setCmbactivestatus(String cmbactivestatus) {
		this.cmbactivestatus = cmbactivestatus;
	}
	public String getHidactivestatus() {
		return hidactivestatus;
	}
	public void setHidactivestatus(String hidactivestatus) {
		this.hidactivestatus = hidactivestatus;
	}
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();

		session.getAttribute("BranchName");
		String mode=getMode();
		ClsSalesAgentBean bean=new ClsSalesAgentBean();

		java.sql.Date slaesAgentDate = ClsCommon.changeStringtoSqlDate(getSalesagentdate());
		if(mode.equalsIgnoreCase("A")){
						int val=salesagentDAO.insert(getCode(),getName(),slaesAgentDate,getHidacno(),session,getMode(),getMobile(),getMail(),getFormdetailcode(),getCmbactivestatus());
						if(val>0.0){
							setCode(getCode());
							setName(getName());
							setHidsalesagentdate(slaesAgentDate.toString());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
							setMobile(getMobile());
							setMode(getMode());
							setMail(getMail());
							setDocno(val);
							setHidacno(getHidacno());
							setCmbactivestatus(getCmbactivestatus());
							setHidactivestatus(getCmbactivestatus());
							setMsg("Successfully Saved");
							return "success";
						}
						else if(val==-1){
							setCode(getCode());
							setName(getName());
							setHidsalesagentdate(slaesAgentDate.toString());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
							setMobile(getMobile());
							setMode(getMode());
							setMail(getMail());
							setDocno(val);
							setHidacno(getHidacno());
							setCmbactivestatus(getCmbactivestatus());
							setHidactivestatus(getCmbactivestatus());
							setChkstatus("1");
							setMsg("Code Already Exists.");
							return "fail";
						}
						else if(val==-2){
							setCode(getCode());
							setName(getName());
							setHidsalesagentdate(slaesAgentDate.toString());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
							setMobile(getMobile());
							setMode(getMode());
							setMail(getMail());
							setDocno(val);
							setHidacno(getHidacno());
							setCmbactivestatus(getCmbactivestatus());
							setHidactivestatus(getCmbactivestatus());
							setChkstatus("1");
							setMsg("Name Already Exists.");
							return "fail";
						}
						else if(val==-3){
							setCode(getCode());
							setName(getName());
							setHidsalesagentdate(slaesAgentDate.toString());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
							setMobile(getMobile());
							setMode(getMode());
							setMail(getMail());
							setDocno(val);
							setHidacno(getHidacno());
							setCmbactivestatus(getCmbactivestatus());
							setHidactivestatus(getCmbactivestatus());
							setChkstatus("1");
							setMsg("Account Already Exists.");
							return "fail";
						}
						else{
							setCode(getCode());
							setName(getName());
							setHidsalesagentdate(slaesAgentDate.toString());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
							setMobile(getMobile());
							setMode(getMode());
							setMail(getMail());
							setDocno(val);
							setHidacno(getHidacno());
							setCmbactivestatus(getCmbactivestatus());
							setHidactivestatus(getCmbactivestatus());
							setMsg("Not Saved");
							return "fail";
						}	
		}

		else if(mode.equalsIgnoreCase("E")){
				int val=salesagentDAO.edit(getCode(),getName(),slaesAgentDate,getHidacno(),session,getMode(),getDocno(),getMobile(),getMail(),getFormdetailcode(),getCmbactivestatus());
				if(val>0){
					
					//session.getAttribute("BranchName");
					setCode(getCode());
					setName(getName());
					setHidacno(getHidacno());
					setHidsalesagentdate(slaesAgentDate.toString());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setDocno(getDocno());
					setMode(getMode());
					setMobile(getMobile());
					setMail(getMail());
					setCmbactivestatus(getCmbactivestatus());
					setHidactivestatus(getCmbactivestatus());
					setMsg("Updated Successfully");
					return "success";
				}
				else if(val==-1){
					setCode(getCode());
					setName(getName());
					setHidacno(getHidacno());
					setHidsalesagentdate(slaesAgentDate.toString());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setDocno(getDocno());
					setMode(getMode());
					setMobile(getMobile());
					setMail(getMail());
					setCmbactivestatus(getCmbactivestatus());
					setHidactivestatus(getCmbactivestatus());
					setChkstatus("2");
					setMsg("Code Already Exists.");
					return "fail";
				}
				else if(val==-2){
					setCode(getCode());
					setName(getName());
					setHidacno(getHidacno());
					setHidsalesagentdate(slaesAgentDate.toString());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setDocno(getDocno());
					setMode(getMode());
					setMobile(getMobile());
					setMail(getMail());
					setCmbactivestatus(getCmbactivestatus());
					setHidactivestatus(getCmbactivestatus());
					setChkstatus("2");
					setMsg("Name Already Exists.");
					return "fail";
				}
				else if(val==-3){
					setCode(getCode());
					setName(getName());
					setHidacno(getHidacno());
					setHidsalesagentdate(slaesAgentDate.toString());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setDocno(getDocno());
					setMode(getMode());
					setMobile(getMobile());
					setMail(getMail());
					setCmbactivestatus(getCmbactivestatus());
					setHidactivestatus(getCmbactivestatus());
					setChkstatus("2");
					setMsg("Account Already Exists.");
					return "fail";
				}
				else{
					setCode(getCode());
					setName(getName());
					setHidacno(getHidacno());
					setHidsalesagentdate(slaesAgentDate.toString());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setDocno(getDocno());
					setMode(getMode());
					setMobile(getMobile());
					setMail(getMail());
					setCmbactivestatus(getCmbactivestatus());
					setHidactivestatus(getCmbactivestatus());
					setMsg("Not Updated");
					return "fail";
				}
			}
			else if(mode.equalsIgnoreCase("D")){
				boolean Status=salesagentDAO.delete(getCode(),getName(),slaesAgentDate,getTxtaccno(),session,getMode(),getDocno(),getMobile(),getMail(),getFormdetailcode(),getCmbactivestatus());
			if(Status){
				setCode(getCode());
				setName(getName());
				setHidsalesagentdate(slaesAgentDate.toString());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				setDocno(getDocno());
				setMode(getMode());
				setMobile(getMobile());
				setMail(getMail());
				setHidacno(getHidacno());
				setCmbactivestatus(getCmbactivestatus());
				setHidactivestatus(getCmbactivestatus());
				setDeleted("DELETED");
				setMsg("Successfully Deleted");

				return "success";
			}
			else{

				setCode(getCode());
				setName(getName());
				setHidsalesagentdate(slaesAgentDate.toString());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				setDocno(getDocno());
				setMode(getMode());
				setMobile(getMobile());
				setMail(getMail());
				setHidacno(getHidacno());
				setCmbactivestatus(getCmbactivestatus());
				setHidactivestatus(getCmbactivestatus());
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
				  List <ClsSalesAgentBean> list= salesagentDAO.list();
				  for(ClsSalesAgentBean bean:list){
				  cellobj = new JSONObject();
				  cellobj.put("DOC_NO", bean.getDocno());
				  cellobj.put("sal_code",bean.getCode());
				  cellobj.put("sal_name",bean.getName());
				  cellobj.put("date",bean.getSalesagentdate().toString());
				  cellobj.put("acc_no",bean.getTxtaccno());
				  cellobj.put("description", bean.getTxtaccname());
				  cellobj.put("mobile", bean.getMobile());
				  cellobj.put("mail", bean.getMail());
				  cellobj.put("acdoc", bean.getHidacno());
				  cellobj.put("active", bean.getCmbactivestatus());
				  cellobj.put("hidactive", bean.getHidactivestatus());
				  cellarray.add(cellobj);
				 }
			  } catch (SQLException e) {
				  e.printStackTrace();
			  }
			return cellarray;
		}
}

