package com.controlcentre.masters.shippingdetail;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

public class ClsShippingdetailsAction {

	ClsShippingdetailsDAO saveDAO= new ClsShippingdetailsDAO();
	
	private int  chkcllient,cldocno,docno,hidechkcllient;
	
	private String clname,shipaddress,contactperson,shiptelephone,shipemail,shipmob,shipfax,mode,deleted,msg,formdetailcode;
	
	
 
	
	
 
	
	
	public int getHidechkcllient() {
		return hidechkcllient;
	}

	public void setHidechkcllient(int hidechkcllient) {
		this.hidechkcllient = hidechkcllient;
	}

	public int getChkcllient() {   
		return chkcllient;
	}

	public void setChkcllient(int chkcllient) {
		this.chkcllient = chkcllient;
	}

	public int getCldocno() {
		return cldocno;
	}

	public void setCldocno(int cldocno) {
		this.cldocno = cldocno;
	}

	public int getDocno() {
		return docno;
	}

	
	public void setDocno(int docno) {
		this.docno = docno;
	}

	public String getClname() {
		return clname;
	}

	public void setClname(String clname) {
		this.clname = clname;
	}

	public String getShipaddress() {
		return shipaddress;
	}

	public void setShipaddress(String shipaddress) {
		this.shipaddress = shipaddress;
	}

	public String getContactperson() {
		return contactperson;
	}

	public void setContactperson(String contactperson) {
		this.contactperson = contactperson;
	}

	public String getShiptelephone() {
		return shiptelephone;
	}

	public void setShiptelephone(String shiptelephone) {
		this.shiptelephone = shiptelephone;
	}

	public String getShipemail() {
		return shipemail;
	}

	public void setShipemail(String shipemail) {
		this.shipemail = shipemail;
	}

	public String getShipmob() {
		return shipmob; 
	}

	public void setShipmob(String shipmob) {
		this.shipmob = shipmob;
	}

	public String getShipfax() {
		return shipfax;
	}

	public void setShipfax(String shipfax) {
		this.shipfax = shipfax;
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
			
			
			int val=saveDAO.insert(getChkcllient(),getCldocno(),getClname(),getMode(),getShipaddress(),getFormdetailcode(),getContactperson(),getShiptelephone(),
					getShipemail() ,getShipmob(), getShipfax(),request,session);
			
			if(val>0)
			{
				setDocno(val);
				 
				
				 setHidechkcllient(getChkcllient());
				 setCldocno(getCldocno());
				 setClname(getClname());
				 setShipaddress(getShipaddress());
				 setContactperson(getContactperson());
				 setShiptelephone(getShiptelephone());;
				 setShipemail(getShipemail());
				 setShipmob(getShipmob());
				 setShipfax(getShipfax());
				
 
				 setMode(getMode()); 
				 
				 setFormdetailcode(getFormdetailcode());
				
				
				
				
				setMsg("Successfully Saved");
				return "success";
				
			}
			else
			{
				
				 setHidechkcllient(getChkcllient());
				 setCldocno(getCldocno());
				 setClname(getClname());
				 setShipaddress(getShipaddress());
				 setContactperson(getContactperson());
				 setShiptelephone(getShiptelephone());;
				 setShipemail(getShipemail());
				 setShipmob(getShipmob());
				 setShipfax(getShipfax());
				
				 
				 setFormdetailcode(getFormdetailcode());
 
				setMsg("Not Saved");
				return "fail";
				
			}
				
			
		}
		else if(getMode().equalsIgnoreCase("E"))
		{
			
			int val=saveDAO.update(getDocno(),getChkcllient(),getCldocno(),getClname(),getMode(),getShipaddress(),getFormdetailcode(),getContactperson(),getShiptelephone(),
					getShipemail() ,getShipmob(), getShipfax(),request,session);
			if(val>0)
			{
				setDocno(getDocno());
				 setHidechkcllient(getChkcllient());
				 setCldocno(getCldocno());
				 setClname(getClname());
				 setShipaddress(getShipaddress());
				 setContactperson(getContactperson());
				 setShiptelephone(getShiptelephone());;
				 setShipemail(getShipemail());
				 setShipmob(getShipmob());
				 setShipfax(getShipfax());
				
				 setMode(getMode()); 
				 
				 setFormdetailcode(getFormdetailcode());
	 			setMsg("Updated Successfully");
				return "success";
				
			}
			else
			{
				setDocno(getDocno());
				 setHidechkcllient(getChkcllient());
				 setCldocno(getCldocno());
				 setClname(getClname());
				 setShipaddress(getShipaddress());
				 setContactperson(getContactperson());
				 setShiptelephone(getShiptelephone());;
				 setShipemail(getShipemail());
				 setShipmob(getShipmob());
				 setShipfax(getShipfax());
				
				 setMode(getMode()); 
				 
				 setFormdetailcode(getFormdetailcode());
 
			    setMsg("Not Updated");
				return "fail";
				
			}	
			
		}
		else if(getMode().equalsIgnoreCase("D"))
		{
		
			int val=saveDAO.delete(getDocno(),getMode(),getFormdetailcode(),request,session);
			if(val>0)
			{
			 
				setDocno(getDocno());
				 setHidechkcllient(getChkcllient());
				 setCldocno(getCldocno());
				 setClname(getClname());
				 setShipaddress(getShipaddress());
				 setContactperson(getContactperson());
				 setShiptelephone(getShiptelephone());;
				 setShipemail(getShipemail());
				 setShipmob(getShipmob());
				 setShipfax(getShipfax());
				
				 setMode(getMode()); 
				 
				 setFormdetailcode(getFormdetailcode());
				   setDeleted("DELETED");
					setMsg("Successfully Deleted");
					return "success";
				
			}
			else
			{
				
				setDocno(getDocno());
				 setHidechkcllient(getChkcllient());
				 setCldocno(getCldocno());
				 setClname(getClname());
				 setShipaddress(getShipaddress());
				 setContactperson(getContactperson());
				 setShiptelephone(getShiptelephone());;
				 setShipemail(getShipemail());
				 setShipmob(getShipmob());
				 setShipfax(getShipfax());
				
				 setMode(getMode()); 
				 
				 setFormdetailcode(getFormdetailcode());
 
			     
	             setMsg("Not Deleted");
	             return "fail";
				
			
			
		}
		
		}
		
		
		
		
	return "fail";	
 
	
	
	
	}
}
