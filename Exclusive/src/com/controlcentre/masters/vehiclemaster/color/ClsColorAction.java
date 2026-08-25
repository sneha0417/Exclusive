package com.controlcentre.masters.vehiclemaster.color;
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
public class ClsColorAction extends ActionSupport {
	ClsColorDAO colorDAO= new ClsColorDAO();
	ClsColorBean bean;
	private int docno;
	private String color;
	private String mode;
	private String deleted;
	private String msg;
	private String formdetailcode;
	private String formdetail;
	private String chkstatus;
	
	
	public String getChkstatus() {
		return chkstatus;
	}
	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
	}
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
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
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
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
//		System.out.println("hhhhhhhhhhhhhhhhheeeeeeeeeee"+getMode());

		session.getAttribute("BranchName");
//		System.out.println("sessoin"+session.getAttribute("BRANCHSELECTED"));
//		System.out.println("sessoin"+session.getAttribute("COMPANYNAME"));
		//System.out.println("request==="+request.getAttribute("BranchName"));
		
		String mode=getMode();
		ClsColorBean bean=new ClsColorBean();
//		String startDate=getDate_brand();
//		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
//		java.util.Date date = sdf1.parse(startDate);
//		java.sql.Date sqlStartDate = new java.sql.Date(date.getTime()); 
		
//		Date trail=getDate_plateCode();
		//String startDate=getModeldate();
		
		if(mode.equalsIgnoreCase("A")){
						int val=colorDAO.insert(getColor(),session,getMode(),getFormdetailcode());
						if(val>0.0){
							setColor(getColor());
							setMode(getMode());
//							System.out.println(val);
							setDocno(val);
							setMsg("Successfully Saved");

							return "success";
						}
						else if(val==-1){
							setColor(getColor());
							setMode(getMode());
//							System.out.println(val);
							//setDocno(val);
						setChkstatus("1");
							setMsg("Color Already Exists");
							return "fail";
						}
						else{
							setColor(getColor());
							setMode(getMode());
//							System.out.println(val);
							setDocno(val);
							setMsg("Not Saved");
							return "fail";
						}	
		}


		else if(mode.equalsIgnoreCase("E")){
				int Status=colorDAO.edit(getColor().trim(),getDocno(),getMode(),session,getFormdetailcode());
				if(Status>0){
					
					//System.out.println("hhhhhhhhhhhhhhhhheeeeeeeeeee"+getMode()+","+getModeldate());
					session.getAttribute("BranchName");
					setColor(getColor());
					setDocno(getDocno());
					//System.out.println("Action"+getUnitdesc());
					setMode(getMode());
				//	System.out.println("brand"+brand);
					setMsg("Updated Successfully");

					return "success";
				}
				else if(Status==-1){
					setColor(getColor());
					setDocno(getDocno());
					//System.out.println("Action"+getUnitdesc());
					setChkstatus("2");
					setMode(getMode());
					setMsg("Color Already Exists");
					return "fail";
				}
				else{
					setColor(getColor());
					setDocno(getDocno());
					//System.out.println("Action"+getUnitdesc());
					setMode(getMode());
					setMsg("Not Updated");

					return "fail";
				}
			}
			else if(mode.equalsIgnoreCase("D")){
				//System.out.println(getDocno()+","+getUnit()+","+getUnitdesc());
				int Status=colorDAO.delete(getColor(),getDocno(),getMode(),session,getFormdetailcode());
			if(Status>0){
				setColor(getColor());
				setDocno(getDocno());
				setMode(getMode());
				setDeleted("DELETED");
				setMsg("Successfully Deleted");

				return "success";
			}
			else if(Status==-2){
				setColor(getColor());
				setDocno(getDocno());
				setMode(getMode());
				setMsg("References Present in Other Documents");
				return "fail";
			}
			else{
				setColor(getColor());
				setDocno(getDocno());
				setMode(getMode());
				setMsg("Not Deleted");

				return "fail";
			}
			}
			return "fail";
		}

		public  JSONArray searchDetails(){
			  JSONArray cellarray = new JSONArray();
			  JSONObject cellobj = null;
			  try {
				  List <ClsColorBean> list= colorDAO.list();
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
		}
		
	}


