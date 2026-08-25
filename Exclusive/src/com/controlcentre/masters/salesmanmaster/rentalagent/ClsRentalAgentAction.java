package com.controlcentre.masters.salesmanmaster.rentalagent;

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

public class ClsRentalAgentAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
	
	ClsRentalAgentDAO rentalagentDAO= new ClsRentalAgentDAO();
	ClsRentalAgentBean bean;
	
	private int docno;
	private String txtaccname;
	private String txtaccno;
	private String code;
	private String name;
	private String rentalagentdate;
	private String hidrentalagentdate;
	private String mode;
	private String delete;
	private String mobile;
	private String mail;
	private String msg;
	private String formdetail;
	private String formdetailcode;
	private String chkstatus;
	private String hidacno;
	
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
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public int getDocno() {
		return docno;
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
	
	public String getTxtaccno() {
		return txtaccno;
	}
	public void setTxtaccno(String txtaccno) {
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
	public String getRentalagentdate() {
		return rentalagentdate;
	}
	public void setRentalagentdate(String rentalagentdate) {
		this.rentalagentdate = rentalagentdate;
	}
	public String getHidrentalagentdate() {
		return hidrentalagentdate;
	}
	public void setHidrentalagentdate(String hidrentalagentdate) {
		this.hidrentalagentdate = hidrentalagentdate;
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
	public String getChkstatus() {
		return chkstatus;
	}
	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
	}
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		
		String mode=getMode();
		ClsRentalAgentBean bean=new ClsRentalAgentBean();

		java.sql.Date renatalAgentDate = ClsCommon.changeStringtoSqlDate(getRentalagentdate());
		
		if(mode.equalsIgnoreCase("A")){
						int val=rentalagentDAO.insert(getCode(),getName(),renatalAgentDate,getHidacno(),session,getMode(),getMail(),getMobile(),getFormdetailcode());
						if(val>0.0){
							setHidacno(getHidacno());
							setCode(getCode());
							setName(getName());
							setHidrentalagentdate(renatalAgentDate.toString());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
							setMobile(getMobile());
							setMail(getMail());
							setMode(getMode());
							setDocno(val);
							setMsg("Successfully Saved");
							return "success";
						}
						else if(val==-1){
							setHidacno(getHidacno());
							setCode(getCode());
							setName(getName());
							setHidrentalagentdate(renatalAgentDate.toString());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
							setMobile(getMobile());
							setMail(getMail());
							setMode(getMode());
							setDocno(val);
							setChkstatus("1");
							setMsg("Code Already Exists.");
							return "fail";
						}
						else if(val==-2){
							setHidacno(getHidacno());
							setCode(getCode());
							setName(getName());
							setHidrentalagentdate(renatalAgentDate.toString());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
							setMobile(getMobile());
							setMail(getMail());
							setMode(getMode());
							setDocno(val);
							setChkstatus("1");
							setMsg("Name Already Exists.");
							return "fail";
						}
						else if(val==-3){
							setHidacno(getHidacno());
							setCode(getCode());
							setName(getName());
							setHidrentalagentdate(renatalAgentDate.toString());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
							setMobile(getMobile());
							setMail(getMail());
							setMode(getMode());
							setDocno(val);
							setChkstatus("1");
							setMsg("Account Already Exists.");
							return "fail";
						}
						else{
							setHidacno(getHidacno());
							setCode(getCode());
							setName(getName());
							setHidrentalagentdate(renatalAgentDate.toString());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
							setMobile(getMobile());
							setMail(getMail());
							setMode(getMode());
							setDocno(val);
							setMsg("Not Saved");
							return "fail";
						}	
		}

		else if(mode.equalsIgnoreCase("E")){
				int Status=rentalagentDAO.edit(getCode(),getName(),renatalAgentDate,getHidacno(),session,getMode(),getDocno(),getMail(),getMobile(),getFormdetailcode());
				if(Status>0){
					setCode(getCode());
					setName(getName());
					setHidacno(getHidacno());
					setHidrentalagentdate(renatalAgentDate.toString());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setDocno(getDocno());
					setMode(getMode());
					setMobile(getMobile());
					setMail(getMail());
					setMsg("Updated Successfully");
					return "success";
				}
				else if(Status==-1){
					setCode(getCode());
					setName(getName());
					setHidacno(getHidacno());
					setHidrentalagentdate(renatalAgentDate.toString());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setDocno(getDocno());
					setMode(getMode());
					setMobile(getMobile());
					setMail(getMail());
					setChkstatus("2");
					setMsg("Code Already Exists.");
					return "fail";
				}
				else if(Status==-2){
					setCode(getCode());
					setName(getName());
					setHidacno(getHidacno());
					setHidrentalagentdate(renatalAgentDate.toString());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setDocno(getDocno());
					setMode(getMode());
					setMobile(getMobile());
					setMail(getMail());
					setChkstatus("2");
					setMsg("Name Already Exists.");
					return "fail";
				}
				else if(Status==-3){
					setCode(getCode());
					setName(getName());
					setHidacno(getHidacno());
					setHidrentalagentdate(renatalAgentDate.toString());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setDocno(getDocno());
					setMode(getMode());
					setMobile(getMobile());
					setMail(getMail());
					setChkstatus("2");
					setMsg("Account Already Exists.");
					return "fail";
				}
				else{
					setCode(getCode());
					setName(getName());
					setHidacno(getHidacno());
					setHidrentalagentdate(renatalAgentDate.toString());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setDocno(getDocno());
					setMode(getMode());
					setMobile(getMobile());
					setMail(getMail());
					setMsg("Not Updated");
					return "fail";
				}
			}
		
			else if(mode.equalsIgnoreCase("D")){
				boolean Status=rentalagentDAO.delete(getCode(),getName(),renatalAgentDate,getTxtaccno(),session,getMode(),getDocno(),getMail(),getMobile(),getFormdetailcode());
			if(Status){
				setCode(getCode());
				setName(getName());
				setHidrentalagentdate(renatalAgentDate.toString());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				setDocno(getDocno());
				setMobile(getMobile());
				setMail(getMail());
				setMode(getMode());
				setDelete("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setCode(getCode());
				setName(getName());
				setHidacno(getHidacno());
				setHidrentalagentdate(renatalAgentDate.toString());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				setDocno(getDocno());
				setMode(getMode());
				setMobile(getMobile());
				setMail(getMail());
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
				  List <ClsRentalAgentBean> list= rentalagentDAO.list();
				  for(ClsRentalAgentBean bean:list){
				  cellobj = new JSONObject();
				  cellobj.put("DOC_NO", bean.getDocno());
				  cellobj.put("sal_code",bean.getCode());
				  cellobj.put("sal_name",bean.getName());
				  cellobj.put("date",bean.getRentalagentdate().toString());
				  cellobj.put("acc_no",bean.getTxtaccno());
				  cellobj.put("description", bean.getTxtaccname());
				  cellobj.put("mobile", bean.getMobile());
				  cellobj.put("mail", bean.getMail());
				  cellobj.put("acdoc", bean.getHidacno());
				  cellarray.add(cellobj);

				 }
			  } catch (SQLException e) {
				  e.printStackTrace();
			  }
			return cellarray;
		}
}

