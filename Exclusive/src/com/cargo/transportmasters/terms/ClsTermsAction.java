package com.cargo.transportmasters.terms;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.cargo.transportmasters.servicetype.ClsServiceTypeBean;
import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

public class ClsTermsAction extends ActionSupport{
	
	ClsCommon ClsCommon=new ClsCommon();
	ClsTermsDAO termsDAO= new ClsTermsDAO();
	ClsTermsBean bean;
	
	private int docno;
	private String termsdate;
	private String code;
	private String name;
    private String cmbmode;
    private String hidtermsdate;
	public String getHidtermsdate() {
		return hidtermsdate;
	}
	public void setHidtermsdate(String hidtermsdate) {
		this.hidtermsdate = hidtermsdate;
	}
	private String mode;
	private String deleted;
	private int gridlength;
	private String msg;
	private String formdetail;
	private String formdetailcode;
	private String chkstatus;
	private int modeid;
	
	
	
	
	public int getModeid() {
		return modeid;
	}
	public void setModeid(int modeid) {
		this.modeid = modeid;
	}
	public ClsCommon getClsCommon() {
		return ClsCommon;
	}
	public void setClsCommon(ClsCommon clsCommon) {
		ClsCommon = clsCommon;
	}

	public ClsTermsBean getBean() {
		return bean;
	}
	public void setBean(ClsTermsBean bean) {
		this.bean = bean;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getTermsdate() {
		return termsdate;
	}
	public void setTermsdate(String termsdate) {
		this.termsdate = termsdate;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCmbmode() {
		return cmbmode;
	}
	public void setCmbmode(String cmbmode) {
		this.cmbmode = cmbmode;
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
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getFormdetail() {
		return formdetail;
	}
	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
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
	
	
	public String saveAction() throws ParseException, SQLException{
     	HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		String mode=getMode();

		java.sql.Date sqlTermsDate = ClsCommon.changeStringtoSqlDate(getTermsdate());
		
		if(mode.equalsIgnoreCase("A")){
						int val=termsDAO.insert(getDocno(),sqlTermsDate, getCode(), getName(), getCmbmode(), mode, session, getFormdetailcode());
						if(val>0){
							setTermsdate(getTermsdate());
							setCode(getCode());
							setName(getName());
							setCmbmode(getCmbmode());
						    setDocno(val);
							setMsg("Successfully Saved");
							return "success";
						}
						
						else{
						
							setHidtermsdate(getHidtermsdate());
							setCode(getCode());
							setName(getName());
							setCmbmode(getCmbmode());
							setMode(getMode());
						    setDocno(val);
							setMsg("Not Saved");
							return "fail";
						}	
		}
		if(mode.equalsIgnoreCase("E")){
			int val=termsDAO.edit(getDocno(),sqlTermsDate, getCode(), getName(), getCmbmode(), mode, session, getFormdetailcode());
			if(val>0){
				setTermsdate(getTermsdate());
				setCode(getCode());
				setName(getName());
				setCmbmode(getCmbmode());
			    setDocno(val);
				setMode(getMode());
			    setDocno(val);
				setMsg("Updated Successfully");
				return "success";
			}
			
			else{
				setHidtermsdate(getHidtermsdate());
				setCode(getCode());
				setName(getName());
				setCmbmode(getCmbmode());
				setMode(getMode());
			    setDocno(val);
			    setMsg("Not Updated");
				return "fail";
			}	
}
		if(mode.equalsIgnoreCase("D")){
			boolean Status=termsDAO.delete(getDocno(),sqlTermsDate, getCode(), getName(), getCmbmode(), mode, session, getFormdetailcode());
			if(Status){
				setTermsdate(getTermsdate());
				setCode(getCode());
				setName(getName());
				setCmbmode(getCmbmode());
		
				setMode(getMode());
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			
			else{
				setHidtermsdate(getHidtermsdate());
				setCode(getCode());
				setName(getName());
				setCmbmode(getCmbmode());
				setMode(getMode());
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "fail";
			}	
}

	return "fail";
	}
	public  JSONArray searchDetails(){
		  JSONArray cellarray = new JSONArray();
		  JSONObject cellobj = null;
		  try {
			  List <ClsTermsBean> list= termsDAO.list();
			  for(ClsTermsBean bean:list){
			  cellobj = new JSONObject();
			  cellobj.put("doc_no", bean.getDocno());
			  cellobj.put("date",bean.getServicedate().toString());
			  cellobj.put("modeid",bean.getModeid());
			  cellobj.put("modename",bean.getCmbmode());
			  cellobj.put("terms",bean.getName());
			  cellobj.put("tcode", bean.getCode());
		
			  cellarray.add(cellobj);
			 }
		  } catch (SQLException e) {
			  e.printStackTrace();
		  }
		return cellarray;
	}
}



