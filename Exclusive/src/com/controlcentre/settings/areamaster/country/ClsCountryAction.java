package com.controlcentre.settings.areamaster.country;

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



public class ClsCountryAction extends ActionSupport {
	
	ClsCountryDAO counDAO= new ClsCountryDAO();
	ClsConnection conobj=new ClsConnection();
	ClsCommon com=new ClsCommon();
	
	ClsCountryBean bean;
	
	private int docno;
	private String country;
	private String contry_code;
	private String region;
	private int reg_id;
	private String date_coun;
	private String mode;
	private String deleted;
	private String datehidden;
	private String msg;
	
	public ClsCountryBean getBean() {
		return bean;
	}
	public void setBean(ClsCountryBean bean) {
		this.bean = bean;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getContry_code() {
		return contry_code;
	}
	public void setContry_code(String contry_code) {
		this.contry_code = contry_code;		
	}	
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public int getReg_id() {
		return reg_id;
	}
	public void setReg_id(int reg_id) {
		this.reg_id = reg_id;
	}
	public String getDate_coun() {
		return date_coun;
	}
	public void setDate_coun(String date_coun) {
		this.date_coun = date_coun;
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
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		
		String mode=getMode();
		ClsCountryBean bean=new ClsCountryBean();
		try{
		java.sql.Date sqlStartDate = com.changeStringtoSqlDate(getDate_coun());
		System.out.println("date"+sqlStartDate);
		System.out.println("Country"+getCountry());
		System.out.println("Contry_code()"+getContry_code());
		System.out.println("Reg_id()"+getReg_id());
		bean.setCountry(getCountry());
		bean.setContry_code(getContry_code());
		bean.setRegion(getRegion());
		bean.setReg_id(getReg_id());
		bean.setDate_coun(sqlStartDate);
		bean.setMode(getMode());
		bean.setDocno(getDocno());
		
		if(mode.equalsIgnoreCase("A")){
			
			int val=counDAO.insert(bean,session);
			if(val>0){
//				setDatehidden(getDate_coun());
				setDate_coun(sqlStartDate.toString());
				setCountry(getCountry());
				setContry_code(getContry_code());
				setRegion(getRegion());
				setReg_id(Integer.parseInt(getRegion()));
				setDocno(val);
				setMsg("Successfully Saved");
				
				return "success";
			}
			else{
				setMsg("Not Saved");
				return "fail";
			}	
			
		}
		else if(mode.equalsIgnoreCase("E")){
			
			boolean Status=counDAO.edit(bean,session);
			if(Status){
//				setDatehidden(getDate_coun());
				setDate_coun(sqlStartDate.toString());
				setCountry(getCountry());
				setContry_code(getContry_code());
				setRegion(getRegion());
				setReg_id(Integer.parseInt(getRegion()));
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
			boolean Status=counDAO.delete(bean,session);
		if(Status){
//			setDatehidden(getDate_coun());
			setDate_coun(sqlStartDate.toString());
			setCountry(getCountry());
			setContry_code(getContry_code());
			setRegion(getRegion());
			setReg_id(Integer.parseInt(getRegion()));
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
		}
		catch(Exception e){
			e.printStackTrace();
		}

		
		return "fail";
	}
	
	/*public static JSONArray searchDetails(){
		  JSONArray cellarray = new JSONArray();
		  JSONObject cellobj = null;
		  try {
			  List <ClsCountryBean> list = ClsCountryDAO.list();
			  for(ClsCountryBean bean:list){
					  cellobj = new JSONObject();
					  cellobj.put("doc_no", bean.getDocno());
					  cellobj.put("country_name",bean.getCountry());
					  cellobj.put("country_code",bean.getContry_code());
					  cellobj.put("region",bean.getRegion());
					  cellobj.put("reg_id",bean.getReg_id());
					  cellobj.put("date",((bean.getDate_coun()==null) ? "NA" : bean.getDate_coun()).toString());
					  cellarray.add(cellobj);
			 }
				 System.out.println("cellobj"+cellarray);
		  } catch (SQLException e) {
		  }
		return cellarray;
	}
*/
}
