package com.controlcentre.settings.currencybook;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsCurrencyBookAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();

	ClsCurrencyBookDAO currencyBookDAO= new ClsCurrencyBookDAO();
	ClsCurrencyBookBean currencyBookBean;

	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String jqxCurrencyBookDate;
	private String hidjqxCurrencyBookDate;
	private String txtbasecurrency;
	private int txtbasecurId;
	
	//Currency Grid
	private int gridlength;

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

	public String getJqxCurrencyBookDate() {
		return jqxCurrencyBookDate;
	}

	public void setJqxCurrencyBookDate(String jqxCurrencyBookDate) {
		this.jqxCurrencyBookDate = jqxCurrencyBookDate;
	}

	public String getHidjqxCurrencyBookDate() {
		return hidjqxCurrencyBookDate;
	}

	public void setHidjqxCurrencyBookDate(String hidjqxCurrencyBookDate) {
		this.hidjqxCurrencyBookDate = hidjqxCurrencyBookDate;
	}

	public String getTxtbasecurrency() {
		return txtbasecurrency;
	}

	public void setTxtbasecurrency(String txtbasecurrency) {
		this.txtbasecurrency = txtbasecurrency;
	}

	public int getTxtbasecurId() {
		return txtbasecurId;
	}

	public void setTxtbasecurId(int txtbasecurId) {
		this.txtbasecurId = txtbasecurId;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	java.sql.Date currencyBookDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsCurrencyBookBean bean = new ClsCurrencyBookBean();
		currencyBookDate = ClsCommon.changeStringtoSqlDate(getJqxCurrencyBookDate());
		
		if(mode.equalsIgnoreCase("A")){
			/*Currency Grid Saving*/
			ArrayList currencyarray= new ArrayList();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				currencyarray.add(temp+"::"+getTxtbasecurId());
			}
			/*Currency Grid Saving Ends*/
			
						int val=currencyBookDAO.insert(getFormdetailcode(),currencyBookDate,currencyarray,session,mode);
						if(val>0.0){
							
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
		return "fail";
}

	public void setData() {
			
			setHidjqxCurrencyBookDate(currencyBookDate.toString());
			setTxtbasecurrency(getTxtbasecurrency());
			setTxtbasecurId(getTxtbasecurId());
			setFormdetailcode(getFormdetailcode());
		}
}

