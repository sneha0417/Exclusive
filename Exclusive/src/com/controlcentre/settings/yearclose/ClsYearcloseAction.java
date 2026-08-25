package com.controlcentre.settings.yearclose;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsYearcloseAction {

	ClsCommon ClsCommon=new ClsCommon();



private int docno;
private String  date,dateupto,yclosedate,msg,mode,deleted,formdetailcode;

public int getDocno() {
	return docno;
}
public void setDocno(int docno) {
	this.docno = docno;
}
public String getDate() {
	return date;
}
public void setDate(String date) {
	this.date = date;
}
public String getDateupto() {
	return dateupto;
}
public void setDateupto(String dateupto) {
	this.dateupto = dateupto;
}
public String getYclosedate() {
	return yclosedate;
}
public void setYclosedate(String yclosedate) {
	this.yclosedate = yclosedate;
}
public String getMsg() {
	return msg;
}
public void setMsg(String msg) {
	this.msg = msg;
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




public String getFormdetailcode() {
	return formdetailcode;
}
public void setFormdetailcode(String formdetailcode) {
	this.formdetailcode = formdetailcode;
}




ClsYearcloseDAO saveDAO=new ClsYearcloseDAO();



public String  saveAction() throws SQLException
{
	
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
 java.sql.Date	date=ClsCommon.changeStringtoSqlDate(getDate());
 
 
 java.sql.Date	dateupto=ClsCommon.changeStringtoSqlDate(getDateupto());
	
 
 
 java.sql.Date yclosedate=ClsCommon.changeStringtoSqlDate(getYclosedate());
 if(mode.equalsIgnoreCase("A")){
	int val=saveDAO.insert(date,dateupto,yclosedate,session,request,getFormdetailcode());
	//System.out.println("----val----"+val);
	if(val>0)
	{
		
	//	System.out.println("----setMsg----"+val);
	setDocno(val);	
	setDate(date.toString());
	setDateupto(dateupto.toString());
	setYclosedate(yclosedate.toString());
	setMsg("Successfully Saved");
	return "success";
	}
	else
	{
		setDate(date.toString());
		setDateupto(dateupto.toString());
		setYclosedate(yclosedate.toString());	
		setMsg("Not Saved");
		return "fail";
	}
	
 }
 
 else if(mode.equalsIgnoreCase("E")){
	 
	 
	 
	 int status=saveDAO.update(getDocno(),date,dateupto,yclosedate,session,request,getFormdetailcode());
		//System.out.println("----val----"+val);
		if(status>0)
		{
			
		//	System.out.println("----setMsg----"+val);
		setDocno(getDocno());	
		setDate(date.toString());
		setDateupto(dateupto.toString());
		setYclosedate(yclosedate.toString());
		setMsg("Updated Successfully");
		return "success";
		}
		else
		{
			setDocno(getDocno());
			setDate(date.toString());
			setDateupto(dateupto.toString());
			setYclosedate(yclosedate.toString());	
			setMsg("Not Updated");
			return "fail";
		}
   }
		else if(mode.equalsIgnoreCase("D")){
			 
			 
			 
			 int status=saveDAO.delete(getDocno(),session,request,getFormdetailcode());
				//System.out.println("----val----"+val);
				if(status>0)
				{
					
				//	System.out.println("----setMsg----"+val);
				setDocno(getDocno());	
				setDate(date.toString());
				setDateupto(dateupto.toString());
				setYclosedate(yclosedate.toString());
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
				}
				else
				{
					setDocno(getDocno());
					setDate(date.toString());
					setDateupto(dateupto.toString());
					setYclosedate(yclosedate.toString());	
					setMsg("Not Deleted");
					return "fail";
				}
	 
	 
	 
 }
 
 
 
 return "fail";
	
}



}
