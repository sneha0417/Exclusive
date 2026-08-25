package com.operations.clientrelations.clientcategory;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsClientCategoryAction extends ActionSupport{

	ClsClientCategoryDAO clientCategoryDAO= new ClsClientCategoryDAO();
	ClsClientCategoryBean clientcategorybean;
	
	private String formdetailcode;
	private String chkstatus;
	private String mode;
	private String deleted;
	private String msg;
	private int hidtxtclientcategorydocno;
	private String cmbtype;
	private String hidcmbtype;
	private String txtcategory;
	private String txtcategoryname;
	private String cmbaccountgroup;
	private String hidcmbaccountgroup;
	private int chckapproval;
	private int hidchckapproval;
	
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

	public int getHidtxtclientcategorydocno() {
		return hidtxtclientcategorydocno;
	}

	public void setHidtxtclientcategorydocno(int hidtxtclientcategorydocno) {
		this.hidtxtclientcategorydocno = hidtxtclientcategorydocno;
	}

	public String getCmbtype() {
		return cmbtype;
	}

	public void setCmbtype(String cmbtype) {
		this.cmbtype = cmbtype;
	}

	public String getHidcmbtype() {
		return hidcmbtype;
	}

	public void setHidcmbtype(String hidcmbtype) {
		this.hidcmbtype = hidcmbtype;
	}

	public String getTxtcategory() {
		return txtcategory;
	}

	public void setTxtcategory(String txtcategory) {
		this.txtcategory = txtcategory;
	}

	public String getTxtcategoryname() {
		return txtcategoryname;
	}

	public void setTxtcategoryname(String txtcategoryname) {
		this.txtcategoryname = txtcategoryname;
	}

	public String getCmbaccountgroup() {
		return cmbaccountgroup;
	}

	public void setCmbaccountgroup(String cmbaccountgroup) {
		this.cmbaccountgroup = cmbaccountgroup;
	}

	public String getHidcmbaccountgroup() {
		return hidcmbaccountgroup;
	}

	public void setHidcmbaccountgroup(String hidcmbaccountgroup) {
		this.hidcmbaccountgroup = hidcmbaccountgroup;
	}

	public int getChckapproval() {
		return chckapproval;
	}

	public void setChckapproval(int chckapproval) {
		this.chckapproval = chckapproval;
	}

	public int getHidchckapproval() {
		return hidchckapproval;
	}

	public void setHidchckapproval(int hidchckapproval) {
		this.hidchckapproval = hidchckapproval;
	}

	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();

		String mode=getMode();
		ClsClientCategoryBean clientcategorybean = new ClsClientCategoryBean();
		
		if(mode.equalsIgnoreCase("A")){
			int val=clientCategoryDAO.insert(getFormdetailcode(),getCmbtype(),getTxtcategory(),getTxtcategoryname(),getCmbaccountgroup(),getHidchckapproval(),session,mode);
			if(val>0.0){
				
				setHidtxtclientcategorydocno(val);
				setData();
				
				setMsg("Successfully Saved");
				return "success";
			}
			 else if(val==-1)
			   {
				setData();
				setChkstatus("1");
				setMsg("Category Already Exists");
			    return "fail";
			   }
			else{
				setData();
				setMsg("Not Saved");
				return "fail";
			}	
		}
		else if(mode.equalsIgnoreCase("E")){
			int Status=clientCategoryDAO.edit(getFormdetailcode(),getCmbtype(),getHidtxtclientcategorydocno(),getTxtcategory(),getTxtcategoryname(),getCmbaccountgroup(),getHidchckapproval(),session,mode);
			if(Status>0){
				
				setHidtxtclientcategorydocno(getHidtxtclientcategorydocno());
				setData();
				
				setMsg("Updated Successfully");
				return "success";
			}
			else if(Status==-1)
			   {
				setData();
				setChkstatus("2");
			    setMsg("Category Already Exists");
			    return "fail";
			}
			else{
				setHidtxtclientcategorydocno(getHidtxtclientcategorydocno());
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("D")){
			boolean Status=clientCategoryDAO.delete(getHidtxtclientcategorydocno(),getFormdetailcode(),session,mode);
		if(Status){
			
			setHidtxtclientcategorydocno(getHidtxtclientcategorydocno());
			setData();
			
			setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
		}
		else{
			setHidtxtclientcategorydocno(getHidtxtclientcategorydocno());
			setData();
			setMsg("Not Deleted");
			return "fail";
		}
		}
		return "fail";
	}

	public JSONArray searchDetails(){
		  JSONArray cellarray = new JSONArray();
		  JSONObject cellobj = null;
		  try {
			  List <ClsClientCategoryBean> list= clientCategoryDAO.list();
			  for(ClsClientCategoryBean bean:list){
			  cellobj = new JSONObject();
			  cellobj.put("doc_no", bean.getDoc_no());
			  cellobj.put("dtypes", bean.getCmbtype());
			  cellobj.put("dtype", bean.getHidcmbtype());
			  cellobj.put("category", bean.getCategory());
			  cellobj.put("cat_name",bean.getCat_name());
			  cellobj.put("acc_group",bean.getHidcmbaccountgroup());
			  cellobj.put("approval",bean.getChckapproval());
			  cellarray.add(cellobj);
			 }
		  } catch (SQLException e) {
		  }
		return cellarray;
	}
	
	public void setData(){
		setHidcmbtype(getCmbtype());
		setTxtcategory(getTxtcategory());
		setTxtcategoryname(getTxtcategoryname());
		setHidcmbaccountgroup(getCmbaccountgroup());
		setHidchckapproval(getHidchckapproval());
		setFormdetailcode(getFormdetailcode());
	}
}
