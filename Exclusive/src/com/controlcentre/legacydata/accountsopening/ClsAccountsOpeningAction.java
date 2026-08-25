package com.controlcentre.legacydata.accountsopening;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsAccountsOpeningAction extends ActionSupport{

	ClsAccountsOpeningDAO accountsOpeningDAO= new ClsAccountsOpeningDAO();
	ClsAccountsOpeningBean accountsOpeningBean;
	ClsAccountsOpeningDAO ClsAccountsOpeningDAO=new ClsAccountsOpeningDAO();
	private int txtaccountopeningdocno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String jqxAccountOpeningDate;
	private String hidjqxAccountOpeningDate;
	private String cmbacctype;
	private String hidcmbacctype;
	private int txtdocno;
	private String txtaccid;
	private String txtaccname;
	private double txtamount;
	private String txtaccountcurrency;
	private String txtaccountcurrencyid;
	private double txtrate;
	private double txtbaseamount;
	private double txtdebittotal;
	private double txtcredittotal;
	private double txtnettotal;
	private int txttrno;
	private String hidcurrencytype;
	
	//Accounts Invoice Grid
	private int gridlength;
		
	public int getTxtaccountopeningdocno() {
		return txtaccountopeningdocno;
	}

	public void setTxtaccountopeningdocno(int txtaccountopeningdocno) {
		this.txtaccountopeningdocno = txtaccountopeningdocno;
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

	public String getJqxAccountOpeningDate() {
		return jqxAccountOpeningDate;
	}

	public void setJqxAccountOpeningDate(String jqxAccountOpeningDate) {
		this.jqxAccountOpeningDate = jqxAccountOpeningDate;
	}

	public String getHidjqxAccountOpeningDate() {
		return hidjqxAccountOpeningDate;
	}

	public void setHidjqxAccountOpeningDate(String hidjqxAccountOpeningDate) {
		this.hidjqxAccountOpeningDate = hidjqxAccountOpeningDate;
	}

	public String getCmbacctype() {
		return cmbacctype;
	}

	public void setCmbacctype(String cmbacctype) {
		this.cmbacctype = cmbacctype;
	}

	public String getHidcmbacctype() {
		return hidcmbacctype;
	}

	public void setHidcmbacctype(String hidcmbacctype) {
		this.hidcmbacctype = hidcmbacctype;
	}

	public int getTxtdocno() {
		return txtdocno;
	}

	public void setTxtdocno(int txtdocno) {
		this.txtdocno = txtdocno;
	}

	public String getTxtaccid() {
		return txtaccid;
	}

	public void setTxtaccid(String txtaccid) {
		this.txtaccid = txtaccid;
	}

	public String getTxtaccname() {
		return txtaccname;
	}

	public void setTxtaccname(String txtaccname) {
		this.txtaccname = txtaccname;
	}

	public double getTxtamount() {
		return txtamount;
	}

	public void setTxtamount(double txtamount) {
		this.txtamount = txtamount;
	}

	public String getTxtaccountcurrency() {
		return txtaccountcurrency;
	}

	public void setTxtaccountcurrency(String txtaccountcurrency) {
		this.txtaccountcurrency = txtaccountcurrency;
	}

	public String getTxtaccountcurrencyid() {
		return txtaccountcurrencyid;
	}

	public void setTxtaccountcurrencyid(String txtaccountcurrencyid) {
		this.txtaccountcurrencyid = txtaccountcurrencyid;
	}

	public double getTxtrate() {
		return txtrate;
	}

	public void setTxtrate(double txtrate) {
		this.txtrate = txtrate;
	}

	public double getTxtbaseamount() {
		return txtbaseamount;
	}

	public void setTxtbaseamount(double txtbaseamount) {
		this.txtbaseamount = txtbaseamount;
	}

	public double getTxtdebittotal() {
		return txtdebittotal;
	}

	public void setTxtdebittotal(double txtdebittotal) {
		this.txtdebittotal = txtdebittotal;
	}

	public double getTxtcredittotal() {
		return txtcredittotal;
	}

	public void setTxtcredittotal(double txtcredittotal) {
		this.txtcredittotal = txtcredittotal;
	}

	public double getTxtnettotal() {
		return txtnettotal;
	}

	public void setTxtnettotal(double txtnettotal) {
		this.txtnettotal = txtnettotal;
	}

	public int getTxttrno() {
		return txttrno;
	}

	public void setTxttrno(int txttrno) {
		this.txttrno = txttrno;
	}

	public String getHidcurrencytype() {
		return hidcurrencytype;
	}

	public void setHidcurrencytype(String hidcurrencytype) {
		this.hidcurrencytype = hidcurrencytype;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	//java.sql.Date accountsOpeningDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsAccountsOpeningBean bean = new ClsAccountsOpeningBean();
		//accountsOpeningDate = ClsCommon.changeStringtoSqlDate(getJqxAccountOpeningDate());
		
		if(mode.equalsIgnoreCase("A")){
			/*Accounts Invoice Grid Saving*/
			ArrayList accountsopeningarray= new ArrayList();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				accountsopeningarray.add(temp);
			}
			/*Accounts Invoice Grid Saving Ends*/
			
						int val=accountsOpeningDAO.insert(getFormdetailcode(),getCmbacctype(),getTxtdocno(),getTxtamount(),getTxtaccountcurrencyid(),getTxtrate(),getTxtbaseamount(),getTxtdebittotal(),getTxtcredittotal(),getTxtnettotal(),accountsopeningarray,session,request,mode);
						if(val>0.0){
							
							setTxtaccountopeningdocno(val);
							setTxttrno(Integer.parseInt(request.getAttribute("tranno").toString()));
							setData();
							
							setMsg("Successfully Saved");
							return "success";
						}
						else{
							setData();
							setMsg("Not Saved");
							return "fail";
						}	
		}
		
		else if(mode.equalsIgnoreCase("E")){
			/*Accounts Invoice Grid Saving*/
			ArrayList accountsopeningarray= new ArrayList();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				accountsopeningarray.add(temp);
			}
			/*Accounts Invoice Grid Saving Ends*/
			
			boolean Status=accountsOpeningDAO.edit(getFormdetailcode(),getCmbacctype(),getTxtdocno(),getTxttrno(),getTxtamount(),getTxtaccountcurrencyid(),getTxtrate(),getTxtbaseamount(),getTxtdebittotal(),getTxtcredittotal(),getTxtnettotal(),accountsopeningarray,session,request,mode);
			if(Status){

				setTxttrno(getTxttrno());
				setData();
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setTxttrno(getTxttrno());
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("D")){
			boolean Status=accountsOpeningDAO.delete(getTxttrno(),getTxtdocno(),getFormdetailcode(),session);
			if(Status){
				
				setTxttrno(getTxttrno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setData();
				setMsg("Not Deleted");
				return "fail";
			   }
			}
		
		else if(mode.equalsIgnoreCase("View")){
	
			String branch=null;
			accountsOpeningBean=ClsAccountsOpeningDAO.getViewDetails(getTxttrno());
			//setHidjqxAccountOpeningDate(accountsOpeningDate.toString());
			setHidcmbacctype(accountsOpeningBean.getHidcmbacctype());
			setTxtdocno(accountsOpeningBean.getTxtdocno());
			setTxtaccid(accountsOpeningBean.getTxtaccid());
			setTxtaccname(accountsOpeningBean.getTxtaccname());
			setTxtamount(accountsOpeningBean.getTxtamount());
			setTxtaccountcurrency(accountsOpeningBean.getTxtaccountcurrency());
			setTxtaccountcurrencyid(accountsOpeningBean.getTxtaccountcurrencyid());
			setHidcurrencytype(accountsOpeningBean.getHidcurrencytype());
			setTxtrate(accountsOpeningBean.getTxtrate());
			setTxtbaseamount(accountsOpeningBean.getTxtbaseamount());
			setTxtdebittotal(accountsOpeningBean.getTxtdebittotal());
			setTxtcredittotal(accountsOpeningBean.getTxtcredittotal());
			setTxtnettotal(accountsOpeningBean.getTxtnettotal());
			setTxttrno(accountsOpeningBean.getTxttrno());
			setFormdetailcode(accountsOpeningBean.getFormdetailcode());
			
			return "success";
		}
		return "fail";
}

		public  JSONArray searchDetails(HttpSession session,String accountNo,String accountName,String total){
			  JSONArray cellarray = new JSONArray();
			  
			  		  JSONObject cellobj = null;
			  try {
				cellarray= ClsAccountsOpeningDAO.opnMainSearch(session,accountNo, accountName, total);
		
			  } catch (SQLException e) {
				  e.printStackTrace();
				  }
			return cellarray;
		}
		
		public void setData() {
			
			//setHidjqxAccountOpeningDate(accountsOpeningDate.toString());
			setHidcmbacctype(getCmbacctype());
			setTxtdocno(getTxtdocno());
			setTxtaccid(getTxtaccid());
			setTxtaccname(getTxtaccname());
			setTxtamount(getTxtamount());
			setTxtaccountcurrency(getTxtaccountcurrency());
			setTxtaccountcurrencyid(getTxtaccountcurrencyid());
			setHidcurrencytype(getHidcurrencytype());
			setTxtrate(getTxtrate());
			setTxtbaseamount(getTxtbaseamount());
			setTxtdebittotal(getTxtdebittotal());
			setTxtcredittotal(getTxtcredittotal());
			setTxtnettotal(getTxtnettotal());
			setFormdetailcode(getFormdetailcode());
		}
}

