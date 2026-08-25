package com.humanresource.setup.designationsetup;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;



public class ClsdesignationsetupAction {

	ClsCommon ClsCommon =new ClsCommon();
	
	
	ClsdesignationsetupDAO  ClsdesignationsetupDAO=new ClsdesignationsetupDAO();
	
	
	private String  grddate,qlfdate,grade,qualification,mode,msg,deleted,datehidden;
	private int  docno ;
	public String getGrddate() {
		return grddate;
	}
	public void setGrddate(String grddate) {
		this.grddate = grddate;
	}
	public String getQlfdate() {
		return qlfdate;
	}
	public void setQlfdate(String qlfdate) {
		this.qlfdate = qlfdate;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getQualification() {
		return qualification;
	}
	public void setQualification(String qualification) {
		this.qualification = qualification;
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
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public String getDatehidden() {
		return datehidden;
	}
	public void setDatehidden(String datehidden) {
		this.datehidden = datehidden;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	java.sql.Date masterdate=null;
	
	public String saveAction1() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		 
			masterdate = ClsCommon.changeStringtoSqlDate(getGrddate());	
			int val=ClsdesignationsetupDAO.insert1(masterdate,getGrade(), session,request,mode,getDocno());
			if(val>0.0){
			setDocno(val);
			setDatehidden(masterdate.toString());
			setGrade(getGrade());
			
			if(mode.equalsIgnoreCase("A"))
			{
				
				 setMsg("Successfully Saved");
				 
			}

			if(mode.equalsIgnoreCase("E"))
			{
				
				setMsg("Updated Successfully");
				 
			}
			

			if(mode.equalsIgnoreCase("D"))
			{
				
				 setDeleted("DELETED");
				 setMsg("Successfully Deleted");
				  
			}
			
				
				return "success";
			}
			else
			{
				setDocno(0);
				setDatehidden(masterdate.toString());
				setGrade(getGrade());
				
				if(mode.equalsIgnoreCase("A"))
				{
					 setMsg("Not Saved");
				}
				if(mode.equalsIgnoreCase("E"))
				{
					 setMsg("Not Updated");
				}
				if(mode.equalsIgnoreCase("D"))
				{
					 setMsg("Not Deleted");
					 setDeleted("");
				}
				
				
				return "fail";
			}
			
		}
		
	public String saveAction2() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
	 
			masterdate = ClsCommon.changeStringtoSqlDate(getQlfdate());	
			int val=ClsdesignationsetupDAO.insert2(masterdate,getQualification(),session,request,mode,getDocno());
			if(val>0.0){
			
				setDocno(val);
				setDatehidden(masterdate.toString());
				setQualification(getQualification());
				if(mode.equalsIgnoreCase("A"))
				{
					
					 setMsg("Successfully Saved");
					 
				}

				if(mode.equalsIgnoreCase("E"))
				{
					
					setMsg("Updated Successfully");
					 
				}
				

				if(mode.equalsIgnoreCase("D"))
				{
					
					 setDeleted("DELETED");
					 setMsg("Successfully Deleted");
					  
				}
				
				return "success";
			}
			else
			{
				setDocno(0);
				setDatehidden(masterdate.toString());
				setQualification(getQualification());
				
				if(mode.equalsIgnoreCase("A"))
				{
					 setMsg("Not Saved");
				}
				if(mode.equalsIgnoreCase("E"))
				{    setDocno(getDocno());
					 setMsg("Not Updated");
				}
				if(mode.equalsIgnoreCase("D"))
				{       setDocno(getDocno());
					 setMsg("Not Deleted");
					 setDeleted("");
				}
				
				return "fail";
			}
			
			
		 
			
		}
	
}
