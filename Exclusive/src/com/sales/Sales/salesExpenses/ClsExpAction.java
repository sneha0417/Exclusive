package com.sales.Sales.salesExpenses;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

public class ClsExpAction {

	ClsExpDAO saveDAO= new ClsExpDAO();
	
	private int  accdocno,acno,docno;
	
	private String accname,desc1,mode,deleted,msg,formdetailcode;
	
	
	

	public int getAccdocno() {
		return accdocno;
	}

	public void setAccdocno(int accdocno) {
		this.accdocno = accdocno;
	}

	public int getAcno() {                       
		return acno;
	}

	public void setAcno(int acno) {
		this.acno = acno;
	}

	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public String getAccname() {
		return accname;
	}

	public void setAccname(String accname) {
		this.accname = accname;
	}

	public String getDesc1() {
		return desc1;
	}

	public void setDesc1(String desc1) {
		this.desc1 = desc1;
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

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String saveAction() throws SQLException
	{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		
		if(getMode().equalsIgnoreCase("A"))
		{
			
			
			int val=saveDAO.insert(getAccdocno(),getDesc1(),getMode(),getFormdetailcode(),request,session);
			
			if(val>0)
			{
				setDocno(val);
				 
				
				
				
				 setAccdocno(getAccdocno()); 
				 setAcno(getAcno());
				 setAccname(getAccname()); 
				 setDesc1(getDesc1());
				 setMode(getMode()); 
				 
				 setFormdetailcode(getFormdetailcode());
				
				
				
				
				setMsg("Successfully Saved");
				return "success";
				
			}
			else
			{
				
				 setAccdocno(getAccdocno()); 
				 setAcno(getAcno());
				 setAccname(getAccname()); 
				 setDesc1(getDesc1());
				 setMode(getMode()); 
				 
				 setFormdetailcode(getFormdetailcode());
 
				setMsg("Not Saved");
				return "fail";
				
			}
				
			
		}
		else if(getMode().equalsIgnoreCase("E"))
		{
			
			int val=saveDAO.update(getDocno(),getAccdocno(),getDesc1(),getMode(),getFormdetailcode(),request,session);
			if(val>0)
			{
				setDocno(getDocno());
				 setAccdocno(getAccdocno()); 
				 setAcno(getAcno());
				 setAccname(getAccname()); 
				 setDesc1(getDesc1());
				 setMode(getMode()); 
				 
				 setFormdetailcode(getFormdetailcode());
	 			setMsg("Updated Successfully");
				return "success";
				
			}
			else
			{
				setDocno(getDocno());
				 setAccdocno(getAccdocno()); 
				 setAcno(getAcno());
				 setAccname(getAccname()); 
				 setDesc1(getDesc1());
				 setMode(getMode()); 
				 
				 setFormdetailcode(getFormdetailcode());
 
			    setMsg("Not Updated");
				return "fail";
				
			}	
			
		}
		else if(getMode().equalsIgnoreCase("D"))
		{
		
			int val=saveDAO.delete(getDocno(),getAccdocno(),getDesc1(),getMode(),getFormdetailcode(),request,session);
			if(val>0)
			{
			 
				setDocno(getDocno());
				 setAccdocno(getAccdocno()); 
				 setAcno(getAcno());
				 setAccname(getAccname()); 
				 setDesc1(getDesc1());
				 setMode(getMode()); 
				 
				 setFormdetailcode(getFormdetailcode());
				   setDeleted("DELETED");
					setMsg("Successfully Deleted");
					return "success";
				
			}
			else
			{
				
				setDocno(getDocno());
				 setAccdocno(getAccdocno()); 
				 setAcno(getAcno());
				 setAccname(getAccname()); 
				 setDesc1(getDesc1());
				 setMode(getMode()); 
				 
				 setFormdetailcode(getFormdetailcode());
 
			     
	             setMsg("Not Deleted");
	             return "fail";
				
			
			
		}
		
		}
		
		
		
		
	return "fail";	
 
	
	
	
	}
}
