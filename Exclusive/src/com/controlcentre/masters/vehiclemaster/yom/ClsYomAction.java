package com.controlcentre.masters.vehiclemaster.yom;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.controlcentre.masters.vehiclemaster.color.ClsColorBean;
import com.controlcentre.masters.vehiclemaster.color.ClsColorDAO;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsYomAction extends ActionSupport {
	ClsYomDAO colorDAO= new ClsYomDAO();
	ClsYomBean bean;
	private int docno;
	private String yom;
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
	public String getYom() {
		return yom;
	}
	public void setYom(String yom) {
		this.yom = yom;
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
		ClsYomBean bean=new ClsYomBean();
//		String startDate=getDate_brand();
//		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
//		java.util.Date date = sdf1.parse(startDate);
//		java.sql.Date sqlStartDate = new java.sql.Date(date.getTime()); 
		
//		Date trail=getDate_plateCode();
		//String startDate=getModeldate();
		
		if(mode.equalsIgnoreCase("A")){
						int val=colorDAO.insert(getYom(),session,getMode(),getFormdetailcode());
						if(val>0.0){
							setYom(getYom());
							setMode(getMode());
//							System.out.println(val);
							setDocno(val);
							setMsg("Successfully Saved");

							return "success";
						}
						else if(val==-1){
							setYom(getYom());
							setMode(getMode());
//							System.out.println(val);
							//setDocno(val);
						setChkstatus("1");
							setMsg("Yom Already Exists");
							return "fail";
						}
						else{
							setYom(getYom());
							setMode(getMode());
//							System.out.println(val);
							setDocno(val);
							setMsg("Not Saved");
							return "fail";
						}	
		}


		else if(mode.equalsIgnoreCase("E")){
				int Status=colorDAO.edit(getYom().trim(),getDocno(),getMode(),session,getFormdetailcode());
				if(Status>0){
					
					//System.out.println("hhhhhhhhhhhhhhhhheeeeeeeeeee"+getMode()+","+getModeldate());
					session.getAttribute("BranchName");
					setYom(getYom());
					setDocno(getDocno());
					//System.out.println("Action"+getUnitdesc());
					setMode(getMode());
				//	System.out.println("brand"+brand);
					setMsg("Updated Successfully");

					return "success";
				}
				else if(Status==-1){
					setYom(getYom());
					setDocno(getDocno());
					//System.out.println("Action"+getUnitdesc());
					setChkstatus("2");
					setMode(getMode());
					setMsg("Yom Already Exists");
					return "fail";
				}
				else{
					setYom(getYom());
					setDocno(getDocno());
					//System.out.println("Action"+getUnitdesc());
					setMode(getMode());
					setMsg("Not Updated");

					return "fail";
				}
			}
			else if(mode.equalsIgnoreCase("D")){
				//System.out.println(getDocno()+","+getUnit()+","+getUnitdesc());
				int Status=colorDAO.delete(getYom(),getDocno(),getMode(),session,getFormdetailcode());
			if(Status>0){
				setYom(getYom());
				setDocno(getDocno());
				setMode(getMode());
				setDeleted("DELETED");
				setMsg("Successfully Deleted");

				return "success";
			}
			else if(Status==-2){
				setYom(getYom());
				setDocno(getDocno());
				setMode(getMode());
				setMsg("References Present in Other Documents");
				return "fail";
			}
			else{
				setYom(getYom());
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
				  List <ClsYomBean> list= colorDAO.list();
				  for(ClsYomBean bean:list){
				  cellobj = new JSONObject();
				  cellobj.put("DOC_NO", bean.getDocno());
				  cellobj.put("yom",bean.getYom());
				 cellarray.add(cellobj);

				 }
//					 System.out.println("cellobj"+cellarray);
			  } catch (SQLException e) {
			  }
			return cellarray;
		}
		

}
