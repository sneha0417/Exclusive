package com.controlcentre.settings.areamaster.region;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;


public class ClsRegionAction extends ActionSupport {
	
	ClsRegionDAO regionDAO= new ClsRegionDAO();
	ClsCommon com=new  ClsCommon();
	ClsConnection conobj=new ClsConnection();
	
	ClsRegionBean bean;
	private int docno;
	private String region;
	private String date_reg;
	private String mode;
	private String deleted;
	private String datehidden;
	private String msg;
	
	
	
	 
	 public ClsRegionBean getBean() {
		return bean;
	}
	public void setBean(ClsRegionBean bean) {
		this.bean = bean;
	}
	
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getDate_reg() {
		return date_reg;
	}
	public void setDate_reg(String date_reg) {
		this.date_reg = date_reg;
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
	public String getDatehidden() {
		return datehidden;
	}
	public void setDatehidden(String datehidden) {
		this.datehidden = datehidden;
	}
	
	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	public String saveAction() throws ParseException{
//		System.out.println("testing saveAction ------------ ");
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		
		String mode=getMode();
		ClsRegionBean bean=new ClsRegionBean();
		ClsRegionAction cra=new ClsRegionAction();
		
		java.sql.Date sqlStartDate = com.changeStringtoSqlDate(getDate_reg());
		System.out.println("date"+sqlStartDate);
		bean.setRegion(getRegion());
		bean.setDate_reg(sqlStartDate);
		bean.setMode(getMode());
		bean.setDocno(getDocno());

		if(mode.equalsIgnoreCase("A")){
			System.out.println("date--ClsRegionBean-"+sqlStartDate);
			int val=regionDAO.insert(bean,session);
			if(val>0){
//				setDatehidden(getDate_reg());
				setDate_reg(sqlStartDate.toString());
				setRegion(getRegion());
				setDocno(val);
				setMsg("Successfully Saved");
//				request.setAttribute("SAVED", "SUCCESSFULLY SAVED");
				//addActionMessage("Saved Successfully");
//				System.out.println(session.getAttribute("SAVED"));
				return "success";
			}
			else{
//				request.setAttribute("SAVED", "NOT SAVED");
//				addActionError("Not Saved");
				setMsg("Not Saved");
				return "fail";
			}	
		}
		
		else if(mode.equalsIgnoreCase("E")){
		
		boolean Status=regionDAO.edit(bean,session);
		if(Status){
//			setDatehidden(getDate_reg());
			setDate_reg(sqlStartDate.toString());
			setRegion(getRegion());
			setDocno(getDocno());
			setMsg("Updated Successfully");
			return "success";
		}
		else{
			setMsg("Not Updated");
			return "fail";
		}
	}
		else if(mode.equalsIgnoreCase("D")){
			boolean Status=regionDAO.delete(bean,session);
		if(Status){
//			setDatehidden(getDate_reg());
			setDate_reg(sqlStartDate.toString());
			setRegion(getRegion());
			setDocno(getDocno());
			setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
		}
		else{
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
			  List <ClsRegionBean> list = regionDAO.list();
			  for(ClsRegionBean bean:list){
					  cellobj = new JSONObject();
					  cellobj.put("DOC_NO", bean.getDocno());
					  cellobj.put("REG_NAME",bean.getRegion());
					  cellobj.put("DATE",((bean.getDate_reg()==null) ? "NA" : bean.getDate_reg().toString()));
					  cellarray.add(cellobj);
			 }
				 System.out.println("cellobj"+cellarray);
		  } catch (SQLException e) {
		  }
		return cellarray;
	}

}
