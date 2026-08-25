package com.controlcentre.settings.companysettings.currency;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;
public class ClsCurrencyAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
	ClsCurrencyDAO currencyDAO= new ClsCurrencyDAO();
	ClsCurrencyBean bean;
	javax.servlet.http.HttpServletResponse response;

	private int docno;
	private String currdate;
	private String hidcurrdate;
	private String txtcode;
	private String txtcodename;
	private String txtfraction;
	private String txtdecimal;
	private String txtcountry;
	private String mode;
	private String deleted;
	private String msg;
	private String formdetailcode;
	private String formdetail;
	
	
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getFormdetail() {
		return formdetail;
	}
	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getCurrdate() {
		return currdate;
	}
	public void setCurrdate(String currdate) {
		this.currdate = currdate;
	}
	public String getHidcurrdate() {
		return hidcurrdate;
	}
	public void setHidcurrdate(String hidcurrdate) {
		this.hidcurrdate = hidcurrdate;
	}
	public String getTxtcode() {
		return txtcode;
	}
	public void setTxtcode(String txtcode) {
		this.txtcode = txtcode;
	}
	public String getTxtcodename() {
		return txtcodename;
	}
	public void setTxtcodename(String txtcodename) {
		this.txtcodename = txtcodename;
	}
	public String getTxtfraction() {
		return txtfraction;
	}
	public void setTxtfraction(String txtfraction) {
		this.txtfraction = txtfraction;
	}
	public String getTxtdecimal() {
		return txtdecimal;
	}
	public void setTxtdecimal(String txtdecimal) {
		this.txtdecimal = txtdecimal;
	}
	public String getTxtcountry() {
		return txtcountry;
	}
	public void setTxtcountry(String txtcountry) {
		this.txtcountry = txtcountry;
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
	
	
	
	public void setValues(int docno){
		setTxtcode(getTxtcode());
		setTxtcodename(getTxtcodename());
		setTxtcountry(getTxtcountry());
		setTxtdecimal(getTxtdecimal());
		setTxtfraction(getTxtfraction());
		setDocno(docno);
	}
	public String saveAction() throws ParseException, IOException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		session.getAttribute("BranchName");
//		System.out.println("sessoin"+session.getAttribute("BRANCHSELECTED"));
//		System.out.println("sessoin"+session.getAttribute("COMPANYNAME"));
		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getCurrdate());

		if(mode.equalsIgnoreCase("A")){
//			System.out.println("inside a");
						int val=currencyDAO.insert(getTxtcode(),getTxtcodename(),getTxtcountry(),getTxtdecimal(),getTxtfraction(),session,getMode(),getFormdetailcode());
						if(val>0.0){
								setValues(val);
								setMsg("Successfully Saved");

								return "success";
							}
							
							else{
								setValues(val);
								setMsg("Not Saved");

								return "fail";
							}	
			}
		else if(mode.equalsIgnoreCase("E")){
			boolean Status=currencyDAO.edit(getTxtcode(),sqlStartDate,getTxtcodename(),getTxtcountry(),getTxtdecimal(),getTxtfraction(),session,getMode(),getDocno(),getFormdetailcode());
		
			if(Status){
				setValues(getDocno());
				setMsg("Updated Successfully");

				return "success";
			}
			else{
				setValues(getDocno());
				setMsg("Not Updated");

				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			int Status=currencyDAO.delete(getTxtcode(),sqlStartDate,getTxtcodename(),getTxtcountry(),getTxtdecimal(),getTxtfraction(),session,getMode(),getDocno(),getFormdetailcode());
		if(Status>0){
			setValues(getDocno());
			setDeleted("DELETED");
			setMsg("Successfully Deleted");

			return "success";
		}
		else if(Status==-1){
			setValues(getDocno());
			setMsg("References Present In Other Documents");

			return "fail";
		}
		else{
			setValues(getDocno());
			setMsg("References Present In Other Documents");

			return "fail";
			
		}
	}
		return "fail";
	}public  JSONArray searchDetails(){
		  JSONArray cellarray = new JSONArray();
		  JSONObject cellobj = null;
		  try {
			  List <ClsCurrencyBean> list= currencyDAO.list();
			  for(ClsCurrencyBean bean:list){
			  cellobj = new JSONObject();
			  cellobj.put("doc_no", bean.getDocno());
			  cellobj.put("code",bean.getTxtcode());
			  cellobj.put("c_name",bean.getTxtcodename());
			  cellobj.put("decimals",bean.getTxtdecimal());
			  cellobj.put("fraction",bean.getTxtfraction());
			  cellobj.put("country",bean.getTxtcountry());
			  
			  cellarray.add(cellobj);	

			 }
//			 System.out.println("cellobj"+cellarray);
		  } catch (SQLException e) {
			  e.printStackTrace();
		  }
		return cellarray;
	}
	}

