package com.controlcentre.masters.salesmanmaster.staff;

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

public class ClsStaffAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
	ClsStaffDAO staffDAO= new ClsStaffDAO();
	ClsStaffBean bean;
	
	private int docno;
	private String staffdate;
	private String code;
	private String name;
	private String txtaccno;
	private String txtaccname;
	private String hidstaffdate;
	private String mode;
	private String deleted;
	private int gridlength;
	private String mail;
	private String msg;
	private String formdetail;
	private String formdetailcode;
	private String chkstatus;
	private int hidacno;
	
	
	
	public int getHidacno() {
		return hidacno;
	}
	public void setHidacno(int hidacno) {
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
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getStaffdate() {
		return staffdate;
	}
	public void setStaffdate(String staffdate) {
		this.staffdate = staffdate;
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
	public String getHidstaffdate() {
		return hidstaffdate;
	}
	public void setHidstaffdate(String hidstaffdate) {
		this.hidstaffdate = hidstaffdate;
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
	public String getChkstatus() {
		return chkstatus;
	}
	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
	}
	
	public String saveAction() throws ParseException, SQLException{
     	HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		String mode=getMode();

		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getStaffdate());
		
		if(mode.equalsIgnoreCase("A")){
			ArrayList<String> driverarray= new ArrayList<>();
			for(int i=0;i<getGridlength();i++){
				ClsStaffBean staffbean=new ClsStaffBean();
				String temp=requestParams.get("test"+i)[0];
				driverarray.add(temp);
			}
						int val=staffDAO.insert(getCode(),getName(),sqlStartDate,getHidacno(),session,getMode(),driverarray,getMail(),getFormdetailcode());
						if(val>0){
							setHidacno(getHidacno());
							setCode(getCode());
							setName(getName());
							setHidstaffdate(getStaffdate());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
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
							setHidstaffdate(getStaffdate());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
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
							setHidstaffdate(getStaffdate());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
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
							setHidstaffdate(getStaffdate());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
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
							setHidstaffdate(getStaffdate());
							setTxtaccname(getTxtaccname());
							setTxtaccno(getTxtaccno());
							setMail(getMail());
							setMode(getMode());
						    setDocno(val);
							setMsg("Not Saved");
							return "fail";
						}	
		}

		else if(mode.equalsIgnoreCase("E")){
			ArrayList<String> driverarray= new ArrayList<>();
			for(int i=0;i<getGridlength();i++){
				ClsStaffBean staffbean=new ClsStaffBean();
				String temp=requestParams.get("test"+i)[0];
				driverarray.add(temp);
			}
				int Status=staffDAO.edit(getCode(),getName(),sqlStartDate,getHidacno(),session,getMode(),getDocno(),driverarray,getMail(),getFormdetailcode());
				if(Status>0){
					setHidacno(getHidacno());
					setMail(getMail());
					setCode(getCode());
					setName(getName());
					setHidstaffdate(getStaffdate());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setDocno(getDocno());
					setMode(getMode());
					setMsg("Updated Successfully");
					return "success";
				}
				else if(Status==-1){
					setHidacno(getHidacno());
					setMail(getMail());
					setCode(getCode());
					setName(getName());
					setHidstaffdate(getStaffdate());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setDocno(getDocno());
					setMode(getMode());

					setChkstatus("2");
					setMsg("Code Already Exists.");
					return "fail";
				}
				else if(Status==-2){
					setHidacno(getHidacno());
					setMail(getMail());
					setCode(getCode());
					setName(getName());
					setHidstaffdate(getStaffdate());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setDocno(getDocno());
					setMode(getMode());

					setChkstatus("2");
					setMsg("Name Already Exists.");
					return "fail";
				}
				else if(Status==-3){
					setHidacno(getHidacno());
					setMail(getMail());
					setCode(getCode());
					setName(getName());
					setHidstaffdate(getStaffdate());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setDocno(getDocno());
					setMode(getMode());

					setChkstatus("2");
					setMsg("Account Already Exists.");
					return "fail";
				}
				else{
					setHidacno(getHidacno());
					setMail(getMail());
					setCode(getCode());
					setName(getName());
					setHidstaffdate(getStaffdate());
					setTxtaccname(getTxtaccname());
					setTxtaccno(getTxtaccno());
					setDocno(getDocno());
					setMode(getMode());

					setMsg("Not Updated");
					return "fail";
				}
			}
	
			else if(mode.equalsIgnoreCase("D")){
				boolean Status=staffDAO.delete(getCode(),getName(),sqlStartDate,getTxtaccno(),session,getMode(),getDocno(),getMail(),getFormdetailcode());
			if(Status){
				setMail(getMail());
				setCode(getCode());
				setName(getName());
				setHidstaffdate(getStaffdate());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				setDocno(getDocno());
				setHidacno(getHidacno());
				setMode(getMode());
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{

				setMail(getMail());
				setCode(getCode());
				setName(getName());
				setHidstaffdate(getStaffdate());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				setDocno(getDocno());
				setHidacno(getHidacno());
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
				  List <ClsStaffBean> list= staffDAO.list();
				  for(ClsStaffBean bean:list){
				  cellobj = new JSONObject();
				  cellobj.put("DOC_NO", bean.getDocno());
				  cellobj.put("sal_code",bean.getCode());
				  cellobj.put("sal_name",bean.getName());
				  cellobj.put("date",bean.getStaffdate().toString());
				  cellobj.put("acc_no",bean.getTxtaccno());
				  cellobj.put("description", bean.getTxtaccname());
				  cellobj.put("mail",bean.getMail());
				  cellobj.put("authority", bean.getAuthority());
				  cellobj.put("acdoc", bean.getHidacno());
				  cellarray.add(cellobj);
				 }
			  } catch (SQLException e) {
				  e.printStackTrace();
			  }
			return cellarray;
		}
}



