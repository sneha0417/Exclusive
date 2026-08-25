package com.controlcentre.settings.termsnconditions;

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
public class ClsTermsAndConditionsAction extends ActionSupport{

	ClsTermsAndConditionsDAO termsNConditionDAO= new ClsTermsAndConditionsDAO();
	ClsTermsAndConditionsBean termsNConditionBean;
	ClsCommon ClsCommon=new ClsCommon();
	private int Docno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String jqxItacDate;
	private String rheader;
	private String rfooter;
	private String txthdoctype;
	private String txtheaderdescription;
	private String txtfdoctype;
	private String txtfooterdescription;
	private String txtfheaderdescription;
	private int headergridlen;
	private int footergridlen;
	private int headerid;
	private int indexval;



	public int getIndexval() {
		return indexval;
	}
	public void setIndexval(int indexval) {
		this.indexval = indexval;
	}
	public int getHeaderid() {
		return headerid;
	}
	public void setHeaderid(int headerid) {
		this.headerid = headerid;
	}
	public int getHeadergridlen() {
		return headergridlen;
	}
	public void setHeadergridlen(int headergridlen) {
		this.headergridlen = headergridlen;
	}
	public int getFootergridlen() {
		return footergridlen;
	}
	public void setFootergridlen(int footergridlen) {
		this.footergridlen = footergridlen;
	}
	public int getDocno() {
		return Docno;
	}
	public void setDocno(int docno) {
		Docno = docno;
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
	public String getJqxItacDate() {
		return jqxItacDate;
	}
	public void setJqxItacDate(String jqxItacDate) {
		this.jqxItacDate = jqxItacDate;
	}

	public String getRheader() {
		return rheader;
	}
	public void setRheader(String rheader) {
		this.rheader = rheader;
	}
	public String getRfooter() {
		return rfooter;
	}
	public void setRfooter(String rfooter) {
		this.rfooter = rfooter;
	}
	public String getTxthdoctype() {
		return txthdoctype;
	}
	public void setTxthdoctype(String txthdoctype) {
		this.txthdoctype = txthdoctype;
	}
	public String getTxtheaderdescription() {
		return txtheaderdescription;
	}
	public void setTxtheaderdescription(String txtheaderdescription) {
		this.txtheaderdescription = txtheaderdescription;
	}
	public String getTxtfdoctype() {
		return txtfdoctype;
	}
	public void setTxtfdoctype(String txtfdoctype) {
		this.txtfdoctype = txtfdoctype;
	}
	public String getTxtfooterdescription() {
		return txtfooterdescription;
	}
	public void setTxtfooterdescription(String txtfooterdescription) {
		this.txtfooterdescription = txtfooterdescription;
	}
	public String getTxtfheaderdescription() {
		return txtfheaderdescription;
	}
	public void setTxtfheaderdescription(String txtfheaderdescription) {
		this.txtfheaderdescription = txtfheaderdescription;
	}


	public String savetermsAction(){

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		String returns="";
		int val=0;
		try{

			java.sql.Date date=ClsCommon.changeStringtoSqlDate(getJqxItacDate());

			ArrayList<String> headarray= new ArrayList<>();	   
			ArrayList<String> footarray= new ArrayList<>();

			for(int i=0;i<getHeadergridlen();i++){
				String temp=requestParams.get("hdrs"+i)[0];		
				headarray.add(temp);
			}

			for(int i=0;i<getFootergridlen();i++){
				String temp1=requestParams.get("fdrs"+i)[0];
				footarray.add(temp1);
			}


			if(mode.equalsIgnoreCase("A")){

				val=termsNConditionDAO.insert(date, mode,headarray,footarray, getTxthdoctype(), getTxtfdoctype(),getHeaderid(),session);

				if(val>0){
					setIndexval(val);
					setMode(mode);
					setJqxItacDate(date.toString());
					setMsg("Successfully Saved");
				}

			}






		}
		catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}




}

