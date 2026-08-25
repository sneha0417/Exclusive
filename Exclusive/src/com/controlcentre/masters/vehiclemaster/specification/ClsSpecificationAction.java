package com.controlcentre.masters.vehiclemaster.specification;
import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
public class ClsSpecificationAction extends ActionSupport {
	ClsSpecificationDAO specificationDAO=new ClsSpecificationDAO();
	ClsSpecificationBean bean;
	private int docno;
	private String specname;
	private String specdetails;
	private String mode;
	private String deleted;
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


	public int getDocno() {
		return docno;
	}


	public void setDocno(int docno) {
		this.docno = docno;
	}


	public String getSpecname() {
		return specname;
	}


	public void setSpecname(String specname) {
		this.specname = specname;
	}


	public String getSpecdetails() {
		return specdetails;
	}


	public void setSpecdetails(String specdetails) {
		this.specdetails = specdetails;
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
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		//System.out.println("hhhhhhhhhhhhhhhhheeeeeeeeeee"+getMode()+","+getModeldate());

		session.getAttribute("BranchName");
//		System.out.println("sessoin"+session.getAttribute("BRANCHSELECTED"));
//		System.out.println("sessoin"+session.getAttribute("COMPANYNAME"));
		//System.out.println("request==="+request.getAttribute("BranchName"));
		
		String mode=getMode();
		ClsSpecificationBean bean=new ClsSpecificationBean();

		
		if(mode.equalsIgnoreCase("A")){
//			System.out.println("Inside Action Mode A");
			//System.out.println("Unsaved Data"+getHiddriver());
						int val=specificationDAO.insert(getSpecname(),getSpecdetails(),getMode(),session,getFormdetailcode());
						if(val>0.0){
							//setDealerid(getDealerid());
							setSpecname(getSpecname());
							setSpecdetails(getSpecdetails());
							setMode(getMode());
//							System.out.println(val);
							setDocno(val);
							setMsg("Successfully Saved");

							return "success";
						}
						else if(val==-1){
							setSpecname(getSpecname());
							setSpecdetails(getSpecdetails());
							setMode(getMode());
//							System.out.println(val);
							//setDocno(val);
							setChkstatus("1");
							setMsg("Specification Already Exists");
							return "fail";
						}
						else{
							setSpecname(getSpecname());
							setSpecdetails(getSpecdetails());
							setMode(getMode());
//							System.out.println(val);
							setDocno(val);
							setMsg("Not Saved");
							return "fail";
						}
		}
		else if(mode.equalsIgnoreCase("E")){
			int Status=specificationDAO.edit(getSpecname(),getSpecdetails(),getMode(),session,getDocno(),getFormdetailcode());
			if(Status>0){
				setSpecname(getSpecname());
				setSpecdetails(getSpecdetails());
				setMode(getMode());
				
				setDocno(getDocno());
				setMsg("Updated Successfully");
				return "success";
			}
			else if(Status==-1){
				setSpecname(getSpecname());
				setSpecdetails(getSpecdetails());
				setMode(getMode());
				setChkstatus("2");
				setDocno(getDocno());
				setMsg("Specification Already Exists");
				return "fail";

			}
			else{
				setSpecname(getSpecname());
				setSpecdetails(getSpecdetails());
				setMode(getMode());
				
				setDocno(getDocno());
//				System.out.println("STATUS EDIT"+Status);
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			int Status=specificationDAO.delete(getSpecname(),getSpecdetails(),getMode(),session,getDocno(),getFormdetailcode());
		if(Status>0){
			setSpecname(getSpecname());
			setSpecdetails(getSpecdetails());
			setMode(getMode());
			
			setDocno(getDocno());
			setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
		}
		else if(Status==-2){
			setSpecname(getSpecname());
			setSpecdetails(getSpecdetails());
			setMode(getMode());
			
			setDocno(getDocno());
			setMsg("References Present in Other Documents");
			return "fail";
		}
		else{
			setSpecname(getSpecname());
			setSpecdetails(getSpecdetails());
			setMode(getMode());
			
			setDocno(getDocno());
//			System.out.println("STATUS Delete"+Status);

			setMsg("Not Deleted");
			return "fail";
		}
		}
		return "fail";
	}


		
	}

