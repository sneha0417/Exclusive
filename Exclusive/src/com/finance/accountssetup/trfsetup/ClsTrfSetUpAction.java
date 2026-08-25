package com.finance.accountssetup.trfsetup;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsTrfSetUpAction extends ActionSupport{
	
	ClsCommon ClsCommon=new ClsCommon();

    
	ClsTrfSetUpDAO trfsetupDAO= new ClsTrfSetUpDAO();
	ClsTrfSetUpBean trfsetupbean;

	private int txttrfsetupdocno;
	private String formdetailcode;
	private String chkstatus;
	private String mode;
	private String deleted;
	private String msg;
	private String trfSetUpDate;
	private String hidtrfSetUpDate;
	private String txttrfsetupname;
	private String txtdescription;
	
	private String txtmainaccountno;
	private String txtmainaccountname;
	private String txtmainaccountdocno;
	
	//Inter Company Account Grid
	private int gridlength;

	public int getTxttrfsetupdocno() {
		return txttrfsetupdocno;
	}

	public void setTxttrfsetupdocno(int txttrfsetupdocno) {
		this.txttrfsetupdocno = txttrfsetupdocno;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getChkstatus() {
		return chkstatus;
	}

	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
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

	public String getTrfSetUpDate() {
		return trfSetUpDate;
	}

	public void setTrfSetUpDate(String trfSetUpDate) {
		this.trfSetUpDate = trfSetUpDate;
	}

	public String getHidtrfSetUpDate() {
		return hidtrfSetUpDate;
	}

	public void setHidtrfSetUpDate(String hidtrfSetUpDate) {
		this.hidtrfSetUpDate = hidtrfSetUpDate;
	}

	public String getTxttrfsetupname() {
		return txttrfsetupname;
	}

	public void setTxttrfsetupname(String txttrfsetupname) {
		this.txttrfsetupname = txttrfsetupname;
	}

	public String getTxtdescription() {
		return txtdescription;
	}

	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}

	public String getTxtmainaccountno() {
		return txtmainaccountno;
	}

	public void setTxtmainaccountno(String txtmainaccountno) {
		this.txtmainaccountno = txtmainaccountno;
	}

	public String getTxtmainaccountname() {
		return txtmainaccountname;
	}

	public void setTxtmainaccountname(String txtmainaccountname) {
		this.txtmainaccountname = txtmainaccountname;
	}

	public String getTxtmainaccountdocno() {
		return txtmainaccountdocno;
	}

	public void setTxtmainaccountdocno(String txtmainaccountdocno) {
		this.txtmainaccountdocno = txtmainaccountdocno;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	java.sql.Date trfSetUpsDate=null;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		String mode=getMode();
		
		
		ClsTrfSetUpBean bean = new ClsTrfSetUpBean();

		if(mode.equalsIgnoreCase("A")){
			trfSetUpsDate = ClsCommon.changeStringtoSqlDate(getTrfSetUpDate());	
			
			/*Inter Company Accounts Grid*/
			ArrayList<String> intercompanyaccountsarray= new ArrayList<>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				intercompanyaccountsarray.add(temp);
			}
			
			int val=trfsetupDAO.insert(trfSetUpsDate,getFormdetailcode(),getTxttrfsetupname(),getTxtmainaccountdocno(),getTxtdescription(),intercompanyaccountsarray,session,request,mode);
			if(val>0.0){
				
				setTxttrfsetupdocno(val);
				setHidtrfSetUpDate(trfSetUpsDate==null?null:trfSetUpsDate.toString());
				setData();
				
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setData();
				setHidtrfSetUpDate(trfSetUpsDate==null?null:trfSetUpsDate.toString());
				setMsg("Not Saved");
				return "fail";
			}	
		}
		else if(mode.equalsIgnoreCase("E")){
			trfSetUpsDate = ClsCommon.changeStringtoSqlDate(getTrfSetUpDate());	
			
			/*Inter Company Accounts Grid*/
			ArrayList<String> intercompanyaccountsarray= new ArrayList<>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				intercompanyaccountsarray.add(temp);
			}
			
			int Status=trfsetupDAO.edit(getTxttrfsetupdocno(),getFormdetailcode(),trfSetUpsDate,getTxttrfsetupname(),getTxtmainaccountdocno(),getTxtdescription(),intercompanyaccountsarray,session,request,mode);
			
			if(Status>0){
						
						setTxttrfsetupdocno(getTxttrfsetupdocno());
						setHidtrfSetUpDate(trfSetUpsDate==null?null:trfSetUpsDate.toString());
						setData();
				
						setMsg("Updated Successfully");
				        return "success";
			}
			else{
				setData();
				setTxttrfsetupdocno(getTxttrfsetupdocno());
				setHidtrfSetUpDate(trfSetUpsDate==null?null:trfSetUpsDate.toString());
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			
		int Status=trfsetupDAO.delete(getTxttrfsetupdocno(),getFormdetailcode(),session,mode);
		if(Status>0){
					setTxttrfsetupdocno(getTxttrfsetupdocno());
					setData();
			
					setDeleted("DELETED");
					setMsg("Successfully Deleted");
					return "success";
		}
		else if(Status==-1){
			setChkstatus("1");
			setData();
			setMsg("Transaction Already Exists.");
			return "fail";
		}
		else{
			setData();
			setMsg("Not Deleted");
			return "fail";
		}
		}
		

		else if(mode.equalsIgnoreCase("View")){
			
			trfsetupbean=trfsetupDAO.getViewDetails(getTxttrfsetupdocno());
			
			setTrfSetUpDate(trfsetupbean.getTrfSetUpDate());
			setTxttrfsetupname(trfsetupbean.getTxttrfsetupname());
			setTxtmainaccountno(trfsetupbean.getTxtmainaccountno());
			setTxtmainaccountdocno(trfsetupbean.getTxtmainaccountdocno());
			setTxtmainaccountname(trfsetupbean.getTxtmainaccountname());
			setTxtdescription(trfsetupbean.getTxtdescription());
			setFormdetailcode(trfsetupbean.getFormdetailcode());
			
			return "success";
		}
		
		return "fail";
}

		public  JSONArray searchAllDetails(HttpSession session,String docno,String date,String clustername,String check){
			  JSONArray cellarray = new JSONArray();
			  		  JSONObject cellobj = null;
			  try {
				  cellarray= trfsetupDAO.interCompanyMainSearch(session,docno,date,clustername,check);
		
			  } catch (SQLException e) {
				  e.printStackTrace();
				  }
			return cellarray;
		}
		
		public void setData() {
			
			setTxttrfsetupname(getTxttrfsetupname());
			setTxtmainaccountno(getTxtmainaccountno());
			setTxtmainaccountdocno(getTxtmainaccountdocno());
			setTxtmainaccountname(getTxtmainaccountname());
			setTxtdescription(getTxtdescription());
			setFormdetailcode(getFormdetailcode());
			
	}
	
}
