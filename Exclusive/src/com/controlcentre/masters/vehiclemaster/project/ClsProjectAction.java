package com.controlcentre.masters.vehiclemaster.project;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsProjectAction extends ActionSupport {
	ClsCommon ClsCommon=new ClsCommon();
	
	ClsProjectDAO projectDAO= new ClsProjectDAO();
	ClsProjectBean projectbean;
	
	private int txtprojectdocno;
	private String mode;
	private String deleted;
	private String msg;
	private String formdetailcode;
	private String projectDate;
	private String hidprojectDate;
	private String txtclientname;
	private int txtcldocno;
	private String txtprojectname;
	private String formdetail;
	private String chkstatus;
	
	public int getTxtprojectdocno() {
		return txtprojectdocno;
	}

	public void setTxtprojectdocno(int txtprojectdocno) {
		this.txtprojectdocno = txtprojectdocno;
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

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getProjectDate() {
		return projectDate;
	}

	public void setProjectDate(String projectDate) {
		this.projectDate = projectDate;
	}

	public String getHidprojectDate() {
		return hidprojectDate;
	}

	public void setHidprojectDate(String hidprojectDate) {
		this.hidprojectDate = hidprojectDate;
	}

	public String getTxtclientname() {
		return txtclientname;
	}

	public void setTxtclientname(String txtclientname) {
		this.txtclientname = txtclientname;
	}

	public int getTxtcldocno() {
		return txtcldocno;
	}

	public void setTxtcldocno(int txtcldocno) {
		this.txtcldocno = txtcldocno;
	}

	public String getTxtprojectname() {
		return txtprojectname;
	}

	public void setTxtprojectname(String txtprojectname) {
		this.txtprojectname = txtprojectname;
	}

	public String getFormdetail() {
		return formdetail;
	}

	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
	}

	public String getChkstatus() {
		return chkstatus;
	}

	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
	}

	java.sql.Date projectsDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsProjectBean bean = new ClsProjectBean();
		projectsDate = ClsCommon.changeStringtoSqlDate(getProjectDate());
		
		if(mode.equalsIgnoreCase("A")){
						int val=projectDAO.insert(getFormdetailcode(),projectsDate,getTxtcldocno(),getTxtprojectname(),session,mode);
						if(val>0.0){
							setMode(getMode());
							setTxtprojectdocno(val);
							setData();
							setMsg("Successfully Saved");
							return "success";
						}
						else if(val==-1){
							setMode(getMode());
							setData();
						    setChkstatus("1");
							setMsg("Project Already Exists");
							return "fail";
						}
						else{
							setMode(getMode());
							setTxtprojectdocno(val);
							setData();
							setMsg("Not Saved");
							return "fail";
						}	
		}
		
		else if(mode.equalsIgnoreCase("E")){

			boolean Status=projectDAO.edit(getTxtprojectdocno(),getFormdetailcode(),projectsDate,getTxtcldocno(),getTxtprojectname(),session,mode);
			if(Status){

				setTxtprojectdocno(getTxtprojectdocno());
				setMode(getMode());
				setData();
				
				setMsg("Updated Successfully");
			    return "success";
		}
		/*else if(Status==-1){
			setColor(getColor());
			setDocno(getDocno());
			//System.out.println("Action"+getUnitdesc());
			setChkstatus("2");
			setMode(getMode());
			setMsg("Color Already Exists");
			return "fail";
		}*/
		else{
			setTxtprojectdocno(getTxtprojectdocno());
			setMode(getMode());
			setData();
			setMsg("Not Updated");
			return "fail";
		}
	  }
		
		else if(mode.equalsIgnoreCase("D")){
			
			int Status=projectDAO.delete(getTxtprojectdocno(),getFormdetailcode(),projectsDate,getTxtcldocno(),getTxtprojectname(),session,mode);
			if(Status>0){
				
				setTxtprojectdocno(getTxtprojectdocno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			/*else if(Status==-2){
				setColor(getColor());
				setDocno(getDocno());
				setMode(getMode());
				setMsg("References Present in Other Documents");
				return "fail";
			}*/
			else{
				setData();
				setMsg("Not Deleted");
				return "fail";
			   }
			}
			return "fail";
		}

		/*public  JSONArray searchDetails(){
			  JSONArray cellarray = new JSONArray();
			  JSONObject cellobj = null;
			  try {
				  List <ClsColorBean> list= ClsProjectDAO.list();
				  for(ClsColorBean bean:list){
				  cellobj = new JSONObject();
				  cellobj.put("DOC_NO", bean.getDocno());
				  cellobj.put("color",bean.getColor());
				 cellarray.add(cellobj);

				 }
//					 System.out.println("cellobj"+cellarray);
			  } catch (SQLException e) {
			  }
			return cellarray;
		}*/
		
	public void setData() {
		
		setProjectDate(projectsDate.toString());
        setTxtcldocno(getTxtcldocno());
        setTxtclientname(getTxtclientname());
        setTxtprojectname(getTxtprojectname());
		setFormdetailcode(getFormdetailcode());
	}
	
}
