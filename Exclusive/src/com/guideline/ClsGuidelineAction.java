package com.guideline;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

public class ClsGuidelineAction  extends ActionSupport {
	ClsCommon ClsCommon=new ClsCommon();

	ClsGuidelineDAO gld=new ClsGuidelineDAO();
	ClsGuidelineBean guidelineBean;
	
	private String jqxIpglDate;
	private String hidjqxIpglDate;
	private String txtrefno;
	private String docno;
	private String txtdoctype;
	private String txtmenuname;
	private int descgridlen;
	private int notegridlen;
	private int fieldgridlen;
	private String mode;
	private String msg;
	private String formDetailCode;
	private String txtmenuid;
	private String lblformname;
	private String lblformcode;
	private String lblrefno;
	
	
	public String getLblformname() {
		return lblformname;
	}

	public void setLblformname(String lblformname) {
		this.lblformname = lblformname;
	}

	public String getLblformcode() {
		return lblformcode;
	}

	public void setLblformcode(String lblformcode) {
		this.lblformcode = lblformcode;
	}

	public String getLblrefno() {
		return lblrefno;
	}

	public void setLblrefno(String lblrefno) {
		this.lblrefno = lblrefno;
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
	public String getJqxIpglDate() {
		return jqxIpglDate;
	}
	public void setJqxIpglDate(String jqxIpglDate) {
		this.jqxIpglDate = jqxIpglDate;
	}
	public String getHidjqxIpglDate() {
		return hidjqxIpglDate;
	}
	public void setHidjqxIpglDate(String hidjqxIpglDate) {
		this.hidjqxIpglDate = hidjqxIpglDate;
	}
	public String getTxtrefno() {
		return txtrefno;
	}
	public void setTxtrefno(String txtrefno) {
		this.txtrefno = txtrefno;
	}
	public String getDocno() {
		return docno;
	}
	public void setDocno(String docno) {
		this.docno = docno;
	}
	public String getTxtdoctype() {
		return txtdoctype;
	}
	public void setTxtdoctype(String txtdoctype) {
		this.txtdoctype = txtdoctype;
	}
	public String getTxtmenuname() {
		return txtmenuname;
	}
	public void setTxtmenuname(String txtmenuname) {
		this.txtmenuname = txtmenuname;
	}
	public int getDescgridlen() {
		return descgridlen;
	}
	public void setDescgridlen(int descgridlen) {
		this.descgridlen = descgridlen;
	}
	public int getNotegridlen() {
		return notegridlen;
	}
	public void setNotegridlen(int notegridlen) {
		this.notegridlen = notegridlen;
	}
	public int getFieldgridlen() {
		return fieldgridlen;
	}
	public void setFieldgridlen(int fieldgridlen) {
		this.fieldgridlen = fieldgridlen;
	}
	public String getFormDetailCode() {
		return formDetailCode;
	}
	public void setFormDetailCode(String formDetailCode) {
		this.formDetailCode = formDetailCode;
	}
	
	public String getTxtmenuid() {
		return txtmenuid;
	}
	public void setTxtmenuid(String txtmenuid) {
		this.txtmenuid = txtmenuid;
	}
	
	public String saveGuideline() throws ParseException, SQLException
	{
		String result="";
		
		ClsGuidelineDAO guidelineDAO= new ClsGuidelineDAO();
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		String formcode="";
		
		formcode=session.getAttribute("Code").toString();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		if(mode.equalsIgnoreCase("A")){
     	   
     	   java.sql.Date sqlDate = ClsCommon.changeStringtoSqlDate(getJqxIpglDate());
     	   
     	   
     	   
     	   ArrayList<String> descarray= new ArrayList<>();
     	  ArrayList<String> fieldarray= new ArrayList<>();
     	 ArrayList<String> notearray= new ArrayList<>();
     	   
				for(int i=0;i<getDescgridlen();i++){
					/*
					if(requestParams.get("test"+i)[0]==null || requestParams.get("test"+i)[0].equals(null))
						{
						continue;
						}*/
					
				 String temp=requestParams.get("test"+i)[0];
				 
				 descarray.add(temp);
				}
				for(int i=0;i<getFieldgridlen();i++){
					/*
					if(requestParams.get("test"+i)[0]==null || requestParams.get("test"+i)[0].equals(null))
						{
						continue;
						}*/
					
				 String temp=requestParams.get("test2"+i)[0];
				 
				 fieldarray.add(temp);
				}
				for(int i=0;i<getNotegridlen();i++){
					/*
					if(requestParams.get("test"+i)[0]==null || requestParams.get("test"+i)[0].equals(null))
						{
						continue;
						}*/
					
				 String temp=requestParams.get("test3"+i)[0];
				 
				 notearray.add(temp);
				}
				
				int val=guidelineDAO.insert(getTxtrefno(),getTxtmenuid(),sqlDate,getTxtdoctype(),getTxtmenuname(),descarray,fieldarray,notearray);
				
				if(val>0){
					 reloadData();
					result="success";
					setMsg("Successfully Saved");
				}
				else{
					 reloadData();
					result="fail";
					setMsg("Failed");
				}
				
				
		}
		return result;
		
	}
	
	public void reloadData(){
		
		setJqxIpglDate(ClsCommon.changeStringtoSqlDate(getJqxIpglDate()).toString());
		setHidjqxIpglDate(getHidjqxIpglDate());
		setTxtrefno(getTxtrefno());
		setTxtdoctype(getTxtdoctype());
		setTxtmenuid(getTxtmenuid());
		setTxtmenuname(getTxtmenuname());
	}
	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		
		String formCode = request.getParameter("formCode");
		String formName = request.getParameter("formName");
		
		guidelineBean=gld.getPrint(request,formCode);
		
		setLblformname(formName);
		setLblformcode(formCode);
		setLblrefno(guidelineBean.getLblrefno());
		
		return "print";
	}
	
	public String printDashBoardAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		
		String formDetail = request.getParameter("formDetail");
		String formDetailName = request.getParameter("formDetailName");
		
		guidelineBean=gld.getPrintDashBoard(request,formDetailName);
		
		setLblformname(formDetail);
		setLblformcode(formDetailName);
		setLblrefno(guidelineBean.getLblrefno());
		
		return "print";
	}
	
}
