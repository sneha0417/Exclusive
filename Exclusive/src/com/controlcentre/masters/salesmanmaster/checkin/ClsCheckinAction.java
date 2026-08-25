package com.controlcentre.masters.salesmanmaster.checkin;

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

public class ClsCheckinAction extends ActionSupport{
	
	ClsCommon ClsCommon=new ClsCommon();
	ClsCheckinDAO checkinDAO= new ClsCheckinDAO();
	ClsCheckinBean bean;

	private int docno;
	private String checkindate;
	private String code;
	private String name;
	private String txtaccno;
	private String txtaccname;
	private String hidcheckindate;
	private String mode;
	private String delete;
	private String mobile;
	private String mail;
	private String msg;
	private String formdetailcode;
	private String formdetail;
	private String chkstatus;
	private String hidacno;
	
	public String getHidacno() {
		return hidacno;
	}
	public void setHidacno(String hidacno) {
		this.hidacno = hidacno;
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
	public String getCheckindate() {
		return checkindate;
	}
	public void setCheckindate(String checkindate) {
		this.checkindate = checkindate;
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
	
	public String getTxtaccno() {
		return txtaccno;
	}
	public void setTxtaccno(String txtaccno) {
		this.txtaccno = txtaccno;
	}
	public String getTxtaccname() {
		return txtaccname;
	}
	public void setTxtaccname(String txtaccname) {
		this.txtaccname = txtaccname;
	}
	public String getHidcheckindate() {
		return hidcheckindate;
	}
	public void setHidcheckindate(String hidcheckindate) {
		this.hidcheckindate = hidcheckindate;
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

		java.sql.Date checkinDate = ClsCommon.changeStringtoSqlDate(getCheckindate());
		
		if(mode.equalsIgnoreCase("A")){
						int val=checkinDAO.insert(getCode(),getName(),checkinDate,getHidacno(),session,getMode(),getMobile(),getMail(),getFormdetailcode());
						if(val>0){
							
							setCode(getCode());
							setName(getName());
							setHidcheckindate(checkinDate.toString());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
							setMobile(getMobile());
							setMail(getMail());
							setMode(getMode());
						    setDocno(val);
						    setHidacno(getHidacno());
						    setMsg("Successfully Saved");
							return "success";
						}
						else if(val==-1){
							setCode(getCode());
							setName(getName());
							setHidcheckindate(checkinDate.toString());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
							setMobile(getMobile());
							setMail(getMail());
							setDocno(getDocno());
							setMode(getMode());
							setHidacno(getHidacno());
							setChkstatus("1");
							setMsg("Code Already Exists.");
							return "fail";
						}
						else if(val==-2){
							setCode(getCode());
							setName(getName());
							setHidcheckindate(checkinDate.toString());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
							setMobile(getMobile());
							setMail(getMail());
							setDocno(getDocno());
							setMode(getMode());
							setHidacno(getHidacno());
							setChkstatus("1");
							setMsg("Name Already Exists.");
							return "fail";
						}
						else if(val==-3){
							setCode(getCode());
							setName(getName());
							setHidcheckindate(checkinDate.toString());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
							setMobile(getMobile());
							setMail(getMail());
							setDocno(getDocno());
							setMode(getMode());
							setHidacno(getHidacno());
							setChkstatus("1");
							setMsg("Account Already Exists.");
							return "fail";
						}
						else{
							setCode(getCode());
							setName(getName());
							setHidcheckindate(getCheckindate());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
							setMobile(getMobile());
							setMail(getMail());
							setMode(getMode());
						    setDocno(val);
							setHidacno(getHidacno());
						    setMsg("Not Saved");
							return "fail";
						}	
		}

		else if(mode.equalsIgnoreCase("E")){
				int val=checkinDAO.edit(getCode(),getName(),checkinDate,getHidacno(),session,getMode(),getDocno(),getMobile(),getMail(),getFormdetailcode());
				if(val>0){
					
					session.getAttribute("BranchName");
					setCode(getCode());
					setName(getName());
					setHidcheckindate(checkinDate.toString());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setMobile(getMobile());
					setMail(getMail());
					setDocno(getDocno());
					setMode(getMode());
					setHidacno(getHidacno());
					setMsg("Updated Successfully");
					return "success";
				}
				else if(val==-1){
					setCode(getCode());
					setName(getName());
					setHidcheckindate(checkinDate.toString());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setMobile(getMobile());
					setMail(getMail());
					setDocno(getDocno());
					setMode(getMode());
					setHidacno(getHidacno());
					setChkstatus("2");
					setMsg("Code Already Exists.");
					return "fail";
				}
				else if(val==-2){
					setCode(getCode());
					setName(getName());
					setHidcheckindate(checkinDate.toString());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setMobile(getMobile());
					setMail(getMail());
					setDocno(getDocno());
					setMode(getMode());
					setHidacno(getHidacno());
					setChkstatus("2");
					setMsg("Name Already Exists.");
					return "fail";
				}
				else if(val==-3){
					setCode(getCode());
					setName(getName());
					setHidcheckindate(checkinDate.toString());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setMobile(getMobile());
					setMail(getMail());
					setDocno(getDocno());
					setMode(getMode());
					setHidacno(getHidacno());
					setChkstatus("2");
					setMsg("Account Already Exists.");
					return "fail";
				}
				else{
					setCode(getCode());
					setName(getName());
					setHidcheckindate(getCheckindate());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setMobile(getMobile());
					setMail(getMail());
					setDocno(getDocno());
					setMode(getMode());
					setHidacno(getHidacno());
					setMsg("Not Updated");
					return "fail";
				}
			}
	
			else if(mode.equalsIgnoreCase("D")){
				boolean Status=checkinDAO.delete(getCode(),getName(),checkinDate,getTxtaccno(),session,getMode(),getDocno(),getMobile(),getMail(),getFormdetailcode());
			if(Status){
				setCode(getCode());
				setName(getName());
				setHidcheckindate(checkinDate.toString());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				setMobile(getMobile());
				setMail(getMail());
				setDocno(getDocno());
				setMode(getMode());
				setHidacno(getHidacno());
				setDelete("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setHidacno(getHidacno());
				setCode(getCode());
				setName(getName());
				setHidcheckindate(getCheckindate());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				setMobile(getMobile());
				setMail(getMail());
				setDocno(getDocno());
				setMode(getMode());
				
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
				  List <ClsCheckinBean> list= checkinDAO.list();
				  for(ClsCheckinBean bean:list){
				  cellobj = new JSONObject();
				  cellobj.put("DOC_NO", bean.getDocno());
				  cellobj.put("sal_code",bean.getCode());
				  cellobj.put("sal_name",bean.getName());
				  cellobj.put("date",bean.getCheckindate().toString());
				  cellobj.put("acc_no",bean.getTxtaccno());
				  cellobj.put("description", bean.getTxtaccname());
				  cellobj.put("mobile",bean.getMobile());
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


