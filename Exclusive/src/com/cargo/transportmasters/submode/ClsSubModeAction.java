package com.cargo.transportmasters.submode;

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

import com.cargo.transportmasters.mode.ClsModeBean;
import com.cargo.transportmasters.shipment.ClsShipmentBean;
import com.common.ClsCommon;
import com.itextpdf.text.pdf.PdfStructTreeController.returnType;
import com.opensymphony.xwork2.ActionSupport;

public class ClsSubModeAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
	ClsSubModeDAO submodeDAO= new ClsSubModeDAO();
	ClsSubModeBean bean;
	
	private int docno;
	private int modeid;
	private String submodedate;
	private String submodeid;
	private String cmbmode;
	private String mode;
	private String deleted;
	private String msg;
	private String formdetail;
	private String formdetailcode;
	
	
	
	
		
	public int getModeid() {
		return modeid;
	}
	public void setModeid(int modeid) {
		this.modeid = modeid;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}

	public String getSubmodedate() {
		return submodedate;
	}
	public void setSubmodedate(String submodedate) {
		this.submodedate = submodedate;
	}
	public String getSubmodeid() {
		return submodeid;
	}
	public void setSubmodeid(String submodeid) {
		this.submodeid = submodeid;
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
	
	
	
	public String saveAction() throws ParseException, SQLException{
		
		System.out.println("======action=====");
     	HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		String mode=getMode();

		java.sql.Date submodeDate = ClsCommon.changeStringtoSqlDate(getSubmodedate());
		
		if(mode.equalsIgnoreCase("A")){
			ArrayList<String> driverarray= new ArrayList<>();

			
						int val=submodeDAO.insert(getDocno(),submodeDate,getCmbmode(),getSubmodeid(),mode,session,formdetailcode);
						if(val>0){
							
							setMsg("Successfully Saved");
							return "success";
						}
						else{

							setMsg("Not Saved");
							return "fail";
						}		
						
		}
	
		
		else if(mode.equalsIgnoreCase("E")){
			ArrayList<String> driverarray= new ArrayList<>();

				int Status=submodeDAO.edit(getDocno(),submodeDate,getCmbmode(),getSubmodeid(),mode,session,formdetailcode);
				if(Status>0){
					
					setMsg("Updated Successfully");
					return "success";
				}
				else
				{
					setMsg("not updated");
					return "fail";

			}
	
		
	}
	


		else if(mode.equalsIgnoreCase("D")){
			boolean Status=submodeDAO.delete(getDocno(),submodeDate,getCmbmode(),getSubmodeid(),mode,session,formdetailcode);
		if(Status){
			
			setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
		}
		else{

			
			setMode(getMode());
			setMsg("Not Deleted");
			return "fail";
		}
		}
	return "fail";
}

	
	

	
public  JSONArray searchDetails(){
		
		System.out.println("search deatails action");
		  JSONArray cellarray = new JSONArray();
		  JSONObject cellobj = null;
		  try {
			  
			  List <ClsSubModeBean> list=submodeDAO.list();
			  for(ClsSubModeBean bean:list){
				  
			  cellobj = new JSONObject();
			  
			  cellobj.put("doc_no", bean.getDocno());
			  cellobj.put("date",bean.getSubmodedate().toString());
			  cellobj.put("modename",bean.getCmbmode());
			  cellobj.put("submode",bean.getSubmodeid());
			  cellobj.put("modeid",bean.getModeid());
			
			  cellarray.add(cellobj);
			 }
		  } catch (SQLException e) {
			  e.printStackTrace();
		  }
		return cellarray;
	}
	
}



