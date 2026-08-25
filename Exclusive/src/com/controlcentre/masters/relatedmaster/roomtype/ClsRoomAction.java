package com.controlcentre.masters.relatedmaster.roomtype;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsRoomAction extends ActionSupport{
	
	ClsCommon ClsCommon=new ClsCommon();
	ClsRoomDAO serviceDAO= new ClsRoomDAO();
	ClsRoomBean bean;

	private int docno;
	private String name;
	private String remarks;
	private String rdate;
	private String hidrdate;
	
	private String mode;
	private String deleted;
	
	private String msg;
	private String formdetailcode;
	private String formdetail;
	private String chkstatus;
	
	
	public String getFormdetail() {
		return formdetail;
	}
	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
	}
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
	
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	
	
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	
	
	
	
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
		System.out.println("*** ACTION *****");
		
	    HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		java.sql.Date rDate = ClsCommon.changeStringtoSqlDate(getRdate());
		
		if(mode.equalsIgnoreCase("A")){
						int val=serviceDAO.insert(getName(),getRemarks(),rDate, session,getMode(),getFormdetailcode());
						System.out.println(val);
						if(val>0){
							
							setName(getName());
							setRemarks(getRemarks());
							setHidrdate(rDate.toString());
							setMode(getMode());
						    setDocno(val);						    
						    setMsg("Successfully Saved");
							return "success";
						}
						else if(val==-1){
							setName(getName());
							setRemarks(getRemarks());
							setHidrdate(rDate.toString());
							setDocno(getDocno());
							setMode(getMode());							
							setChkstatus("1");
							setMsg("Roomtype Already Exists.");
							return "fail";
						}
						
						else{
							setName(getName());
							setRemarks(getRemarks());
							setHidrdate(rDate.toString());						
							setMode(getMode());
						    setDocno(val);							
						    setMsg("Not Saved");
							return "fail";
						}	
		}

		else if(mode.equalsIgnoreCase("E")){
				int val=serviceDAO.edit(getName(),getRemarks(),rDate,session,getMode(),getDocno(),getFormdetailcode());
				
				if(val>0){
					
					//session.getAttribute("BranchName");
					setName(getName());
					setRemarks(getRemarks());
					setHidrdate(rDate.toString());
					setDocno(getDocno());
					setMode(getMode());
					
					setMsg("Updated Successfully");
					return "success";
				}
				else if(val==-1){
					setName(getName());
					setRemarks(getRemarks());
					setHidrdate(rDate.toString());
					setDocno(getDocno());
					setMode(getMode());
					
					setChkstatus("2");
					setMsg("Roomtype Already Exists.");
					return "fail";
				}
				else{
					setName(getName());
					setRemarks(getRemarks());
					setHidrdate(rDate.toString());
					setDocno(getDocno());
					setMode(getMode());
					
					setMsg("Not Updated");
					return "fail";
				}
			}
	
			else if(mode.equalsIgnoreCase("D")){
				boolean Status=serviceDAO.delete(getName(),getRemarks(),rDate,session,getMode(),getDocno(),getFormdetailcode());
			if(Status){
				setName(getName());
				setRemarks(getRemarks());
				setHidrdate(rDate.toString());
				setDocno(getDocno());
				setMode(getMode());
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				
				setName(getName());
				setRemarks(getRemarks());
				setHidrdate(rDate.toString());
				
				setDocno(getDocno());
				setMode(getMode());
				
				setMsg("Not Deleted");
				return "fail";
			}
			}
		return "fail";
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getRdate() {
		return rdate;
	}
	public void setRdate(String rdate) {
		this.rdate = rdate;
	}
	public String getHidrdate() {
		return hidrdate;
	}
	public void setHidrdate(String hidrdate) {
		this.hidrdate = hidrdate;
	}

		/*public  JSONArray searchDetails(){
			  JSONArray cellarray = new JSONArray();
			  JSONObject cellobj = null;
			  try {
				  List <ClsServiceBean> list= serviceDAO.list();
				  for(ClsServiceBean bean:list){
				  cellobj = new JSONObject();
				  cellobj.put("DOC_NO", bean.getDocno());
				  cellobj.put("sal_code",bean.getCode());
				  cellobj.put("sal_name",bean.getName());
				  cellobj.put("date",bean.gettechniciandate().toString());
				  cellobj.put("acc_no",bean.getTxtaccno());
				  cellobj.put("description", bean.getTxtaccname());
				  cellobj.put("mobile",bean.getMobile());
				  cellobj.put("email", bean.getEmail());
				  cellobj.put("acdoc", bean.getHidacno());
				  cellarray.add(cellobj);
				 }
			  } catch (SQLException e) {
				  e.printStackTrace();
			  }
			return cellarray;
		}
*/
}


