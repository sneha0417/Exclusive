package com.dashboard.projectexecution.proformaInvoice;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsProformaInvoiceAction {

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon common =new ClsCommon();


	private int invgridlength;
	private String mode;
	private String formcode;
	private String clientid;
	private String msg;
	private String detail;
	private String detailname;
	private String todate;
	private String invdate;
private String txtdesc;

	
	public String getTxtdesc() {
		return txtdesc;
	}
	public void setTxtdesc(String txtdesc) {
		this.txtdesc = txtdesc;
	}

	public int getInvgridlength() {
		return invgridlength;
	}
	public void setInvgridlength(int invgridlength) {
		this.invgridlength = invgridlength;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getClientid() {
		return clientid;
	}
	public void setClientid(String clientid) {
		this.clientid = clientid;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public String getDetailname() {
		return detailname;
	}
	public void setDetailname(String detailname) {
		this.detailname = detailname;
	}
	public String getTodate() {
		return todate;
	}
	public void setTodate(String todate) {
		this.todate = todate;
	}
	public String getInvdate() {
		return invdate;
	}
	public void setInvdate(String invdate) {
		this.invdate = invdate;
	}

	public String getFormcode() {
		return formcode;
	}
	public void setFormcode(String formcode) {
		this.formcode = formcode;
	}
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();

		Map<String, String[]> requestParams = request.getParameterMap();

		session.getAttribute("BranchName");
		Connection conn =null;
		String retunrns="";
		String invno="";
		ClsProformaInvoiceDAO DAO= new ClsProformaInvoiceDAO();
		try{

			ArrayList invoiceList = new ArrayList();
			ArrayList retList = new ArrayList();

			java.sql.Date date=common.changeStringtoSqlDate(getInvdate());

			for(int i=0;i<getInvgridlength();i++){

				String temp=requestParams.get("prinv"+i)[0];		
				invoiceList.add(temp);
			}


			retList=DAO.Insert(session,request,date,getFormcode(),getMode(),invoiceList, getTxtdesc());

			if(retList.size()>0){

				for(int i=0;i<retList.size();i++){

					if(retList.size()==1){
						invno=retList.get(i).toString();
					}
					else{
						invno=retList.get(i)+","+invno;
					}



				}

				if (invno.trim().endsWith(",")) {
					invno = invno.trim().substring(0,invno.length() - 1);
				}



				setDetail("Project Execution");
				setDetailname("Invoice Processing-Proforma");
				setMsg("Invoice For  "+invno+" Successfully Generated");
				retunrns="success";
			}

		}
		catch(Exception e){
			e.printStackTrace();
		}

		return retunrns;

	}	

}
