package com.controlcentre.settings.userrolebi;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsUserRoleBIAction extends ActionSupport{

	ClsUserRoleBIDAO userRoleDAO= new ClsUserRoleBIDAO();
	ClsUserRoleBIBean userrolebean;

	private int txtuserrolebidocno;
	private String chkstatus;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String txtrolename;
	private int txtroleid;
	
	//User Role Grid
	private int gridlength;

	public int getTxtuserrolebidocno() {
		return txtuserrolebidocno;
	}

	public void setTxtuserrolebidocno(int txtuserrolebidocno) {
		this.txtuserrolebidocno = txtuserrolebidocno;
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

	public String getTxtrolename() {
		return txtrolename;
	}

	public void setTxtrolename(String txtrolename) {
		this.txtrolename = txtrolename;
	}

	public int getTxtroleid() {
		return txtroleid;
	}

	public void setTxtroleid(int txtroleid) {
		this.txtroleid = txtroleid;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		String mode=getMode();
		ClsUserRoleBIBean bean = new ClsUserRoleBIBean();

		if(mode.equalsIgnoreCase("A")){
			
			/*User Role Grid*/
			ArrayList<String> userrolearray= new ArrayList<>();
			for(int i=0;i<getGridlength();i++){
				ClsUserRoleBIBean userrolebean=new ClsUserRoleBIBean();
				String temp=requestParams.get("test"+i)[0];
				userrolearray.add(temp);
			}
								
			int val=userRoleDAO.insert(getTxtrolename(),getTxtroleid(),getFormdetailcode(),userrolearray,session,request,mode);
			if(val>0.0){
				
				setTxtuserrolebidocno(val);
				setTxtrolename(getTxtrolename());
				setTxtroleid(getTxtroleid());
				
				setMsg("Successfully Saved");
				return "success";
			}
			else if(val==-1)
			   {
				setTxtrolename(getTxtrolename());
				setTxtroleid(getTxtroleid());
				setChkstatus("1");
				setMsg("Role Already Exists");
			    return "fail";
			   }
			else{
				setTxtrolename(getTxtrolename());
				setTxtroleid(getTxtroleid());
				setMsg("Not Saved");
				return "fail";
			}	
		}
		
		else if(mode.equalsIgnoreCase("E")){
			
			/*User Role Grid*/
			ArrayList<String> userrolearray= new ArrayList<>();
			for(int i=0;i<getGridlength();i++){
				ClsUserRoleBIBean userrolebean=new ClsUserRoleBIBean();
				String temp=requestParams.get("test"+i)[0];
				userrolearray.add(temp);
			}
			
			int Status=userRoleDAO.edit(getFormdetailcode(),getTxtuserrolebidocno(),getTxtroleid(),getTxtrolename(),userrolearray,session,mode);
			if(Status>0){
				
				setTxtuserrolebidocno(getTxtuserrolebidocno());
				setTxtroleid(getTxtroleid());
				setTxtrolename(getTxtrolename());
				
				setMsg("Updated Successfully");
				return "success";
			}
			else if(Status==-1)
			   {
				setTxtuserrolebidocno(getTxtuserrolebidocno());
				setTxtroleid(getTxtroleid());
				setTxtrolename(getTxtrolename());
				setChkstatus("2");
				setMsg("Role Already Exists");
			    return "fail";
			}
			else{
				setTxtuserrolebidocno(getTxtuserrolebidocno());
				setTxtroleid(getTxtroleid());
				setTxtrolename(getTxtrolename());
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("D")){
			boolean Status=userRoleDAO.delete(getTxtuserrolebidocno(),getFormdetailcode(),session);
		if(Status){
			
			setTxtuserrolebidocno(getTxtuserrolebidocno());
			setTxtrolename(getTxtrolename());
			setTxtroleid(getTxtroleid());
			
			setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
		}
		else{
			setTxtuserrolebidocno(getTxtuserrolebidocno());
			setTxtrolename(getTxtrolename());
			setTxtroleid(getTxtroleid());
			setMsg("Not Deleted");
			return "fail";
		}
	  }
		return "fail";
    }
	
}
