package com.controlcentre.masters.relatedmaster.servicetype;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsServiceAction extends ActionSupport{
	
	ClsCommon ClsCommon=new ClsCommon();
	ClsServiceDAO serviceDAO= new ClsServiceDAO();
	ClsServiceBean bean;

	private int docno;
	private String name;
	private String txttype;
	private String txthidtype;
	
	
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
	public String getTxttype() {
		return txttype;
	}
	public void setTxttype(String txttype) {
		this.txttype = txttype;
	}
	public String getTxthidtype() {
		return txthidtype;
	}
	public void setTxthidtype(String txthidtype) {
		this.txthidtype = txthidtype;
	}

	public String saveAction() throws ParseException, SQLException{
		System.out.println("*** ACTION *****");
		
	    HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		
		if(mode.equalsIgnoreCase("A")){
						int val=serviceDAO.insert(getName(),session,getMode(),getFormdetailcode(),getTxttype());
						System.out.println(val);
						if(val>0){
							setTxthidtype(getTxttype());
							setName(getName());
							setMode(getMode());
						    setDocno(val);						    
						    setMsg("Successfully Saved");
							return "success";
						}
						else if(val==-1){
							setTxthidtype(getTxttype());
							setName(getName());
							setDocno(getDocno());
							setMode(getMode());							
							setChkstatus("1");
							setMsg("Name Already Exists.");
							return "fail";
						}
						else{
							setTxthidtype(getTxttype());
							setName(getName());
							setMode(getMode());
						    setDocno(val);							
						    setMsg("Not Saved");
							return "fail";
						}	
		}

		else if(mode.equalsIgnoreCase("E")){
				int val=serviceDAO.edit(getName(),session,getMode(),getDocno(),getFormdetailcode(),getTxttype());
				
				if(val>0){
					
					//session.getAttribute("BranchName");
					setTxthidtype(getTxttype());
					setName(getName());
					
					setDocno(getDocno());
					setMode(getMode());
					
					setMsg("Updated Successfully");
					return "success";
				}
				else if(val==-1){
					setTxthidtype(getTxttype());
					setName(getName());
					
					setDocno(getDocno());
					setMode(getMode());
					
					setChkstatus("2");
					setMsg("Name Already Exists.");
					return "fail";
				}else{
					setTxthidtype(getTxttype());
					setName(getName());
					
					setDocno(getDocno());
					setMode(getMode());
					
					setMsg("Not Updated");
					return "fail";
				}
			}
	
			else if(mode.equalsIgnoreCase("D")){
				boolean Status=serviceDAO.delete(getName(),session,getMode(),getDocno(),getFormdetailcode(),getTxttype());
			if(Status){
				setTxthidtype(getTxttype());
				setName(getName());
				
				setDocno(getDocno());
				setMode(getMode());
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setTxthidtype(getTxttype());
				setName(getName());
				
				setDocno(getDocno());
				setMode(getMode());
				
				setMsg("Not Deleted");
				return "fail";
			}
			}
		return "fail";
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


