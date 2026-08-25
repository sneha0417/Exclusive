package com.controlcentre.settings.monthclose;
import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;
public class ClsMonthCloseAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
ClsMonthCloseDAO mclosedao=new ClsMonthCloseDAO();
ClsMonthCloseBean bean;
private int docno;
private int vocno;
private String date;
private String hiddate;
private String dateupto;
private String hiddateupto;
private String mclosedate;
private String hidmclosedate;
private String brchName;
private String msg;
private String mode;
private String deleted;
private String formdetailcode;




public String getFormdetailcode() {
	return formdetailcode;
}
public void setFormdetailcode(String formdetailcode) {
	this.formdetailcode = formdetailcode;
}
public int getDocno() {
	return docno;
}
public void setDocno(int docno) {
	this.docno = docno;
}
public int getVocno() {
	return vocno;
}
public void setVocno(int vocno) {
	this.vocno = vocno;
}
public String getDate() {
	return date;
}
public void setDate(String date) {
	this.date = date;
}
public String getHiddate() {
	return hiddate;
}
public void setHiddate(String hiddate) {
	this.hiddate = hiddate;
}
public String getDateupto() {
	return dateupto;
}
public void setDateupto(String dateupto) {
	this.dateupto = dateupto;
}
public String getHiddateupto() {
	return hiddateupto;
}
public void setHiddateupto(String hiddateupto) {
	this.hiddateupto = hiddateupto;
}
public String getMclosedate() {
	return mclosedate;
}
public void setMclosedate(String mclosedate) {
	this.mclosedate = mclosedate;
}
public String getHidmclosedate() {
	return hidmclosedate;
}
public void setHidmclosedate(String hidmclosedate) {
	this.hidmclosedate = hidmclosedate;
}
public String getBrchName() {
	return brchName;
}
public void setBrchName(String brchName) {
	this.brchName = brchName;
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

public void setData(int val,int vocno,java.sql.Date date,java.sql.Date dateupto,java.sql.Date mclosedate,String msg){
	setDocno(val);
	setVocno(vocno);
	if(date!=null){
		setDate(date.toString());	
	}
	if(dateupto!=null){
		setDateupto(dateupto.toString());	
	}
	if(mclosedate!=null){
		setMclosedate(mclosedate.toString());	
	}
	setMsg(msg);
}

public String saveAction() throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	String mode=getMode();
	java.sql.Date date=null,dateupto=null,mclosedate=null;
	
	if(getDate()!=null){
		date=ClsCommon.changeStringtoSqlDate(getDate());
	}
	if(getDateupto()!=null){
		dateupto=ClsCommon.changeStringtoSqlDate(getDateupto());
		
	}
	if(getMclosedate()!=null){
		mclosedate=ClsCommon.changeStringtoSqlDate(getMclosedate());
	}

if(mode.equalsIgnoreCase("A")){
	//System.out.println("Check Branch: "+getBrchName());
	int val=mclosedao.insert(date,dateupto,mclosedate,session,getBrchName(),request,mode,getFormdetailcode());
	if(val>0){
		setData(val,Integer.parseInt(request.getAttribute("VOCNO").toString()),date,dateupto,mclosedate,"Successfully Saved");
		return "success";
	}
	else{
		setData(val,Integer.parseInt(request.getAttribute("VOCNO").toString()),date,dateupto,mclosedate,"Not Saved");
		return "fail";
	}
}
else if(mode.equalsIgnoreCase("D")){
	int val=mclosedao.checkDeleteStatus(getDocno(),getBrchName());
//	System.out.println("Check Delete: "+val);
	if(val==1){
		boolean status=mclosedao.delete(date,dateupto,mclosedate,session,getBrchName(),request,mode,getFormdetailcode(),getDocno());
		if(status){
			setData(getDocno(),getVocno(),date,dateupto,mclosedate,"Successfully Deleted");
			return "success";
		}
		else{
			setData(getDocno(),getVocno(),date,dateupto,mclosedate,"Not Deleted");
			return "fail";
		}
	}
	else{
		setData(getDocno(),getVocno(),date,dateupto,mclosedate,"Not Deleted");
		return "fail";
		
	}
	
}

return "fail";
}

}
