package com.controlcentre.masters.vehiclemaster.group;
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

public class ClsGroupAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
ClsGroupDAO groupDAO=new ClsGroupDAO();
ClsGroupBean bean;
private int docno;
private String groupdate;
private String group;
private String name;
private String mode;
private String deleted;
private String groupdatehidden;
private String msg;
private String formdetail;
private String formdetailcode;
private String chkstatus;


public String getChkstatus() {
	return chkstatus;
}
public void setChkstatus(String chkstatus) {
	this.chkstatus = chkstatus;
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
public String getMsg() {
	return msg;
}
public void setMsg(String msg) {
	this.msg = msg;
}
public String getUtypehidden() {
	return utypehidden;
}
public void setUtypehidden(String utypehidden) {
	this.utypehidden = utypehidden;
}

private String utypehidden;
private int level;
private String utype;
public int getDocno() {
	return docno;
}
public void setDocno(int docno) {
	this.docno = docno;
}
public String getGroupdate() {
	return groupdate;
}
public void setGroupdate(String groupdate) {
	this.groupdate = groupdate;
}
public String getGroup() {
	return group;
}
public void setGroup(String group) {
	this.group = group;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
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
public String getGroupdatehidden() {
	return groupdatehidden;
}
public void setGroupdatehidden(String groupdatehidden) {
	this.groupdatehidden = groupdatehidden;
}
public int getLevel() {
	return level;
}
public void setLevel(int level) {
	this.level = level;
}
public String getUtype() {
	return utype;
}
public void setUtype(String utype) {
	this.utype = utype;
}
public String saveAction() throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	//System.out.println("hhhhhhhhhhhhhhhhheeeeeeeeeee"+getMode()+","+getModeldate());

	session.getAttribute("BranchName");
//	System.out.println("sessoin"+session.getAttribute("BRANCHSELECTED"));
//	System.out.println("sessoin"+session.getAttribute("COMPANYNAME"));
	//System.out.println("request==="+request.getAttribute("BranchName"));
	
	String mode=getMode();
	ClsGroupBean bean=new ClsGroupBean();
	
	java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getGroupdate());
	if(mode.equalsIgnoreCase("A")){
//		System.out.println("inside a");
					int val=groupDAO.insert(getGroup(),sqlStartDate,getUtype(),getLevel(),getName(),session,getMode(),getFormdetailcode());
					if(val>0.0){
						//setDealerid(getDealerid());
						setGroup(getGroup());
						setMode(getMode());
//						System.out.println("ddddddddddd"+getUtype());
						setUtypehidden(getUtype());
						setGroupdatehidden(sqlStartDate.toString());
						setName(getName());
						setLevel(getLevel());
						//System.out.println("ddddddddddd"+getUtype());                                                                           
						//setGroupdate(getGroupdatehidden());
//						System.out.println(val);
						setDocno(val);
						setMsg("Successfully Saved");

						return "success";
					}
					else if(val==-1){
						setGroup(getGroup());
						setMode(getMode());
//						System.out.println("ddddddddddd"+getUtype());
						setUtypehidden(getUtype());
						setGroupdatehidden(sqlStartDate.toString());
						setName(getName());
						setLevel(getLevel());
						setChkstatus("1");
						//System.out.println("ddddddddddd"+getUtype());                                                                           
						//setGroupdate(getGroupdatehidden());
//						System.out.println(val);
						//setDocno(val);
						setMsg("Group Already Exists");
						return "fail";
					}
					else{
						setGroup(getGroup());
						setMode(getMode());
//						System.out.println("ddddddddddd"+getUtype());
						setUtypehidden(getUtype());
						setGroupdatehidden(sqlStartDate.toString());
						setName(getName());
						setLevel(getLevel());
						//System.out.println("ddddddddddd"+getUtype());                                                                           
						//setGroupdate(getGroupdatehidden());
//						System.out.println(val);
						setDocno(val);
						setMsg("Not Saved");
						return "fail";
					}	
	}


	else if(mode.equalsIgnoreCase("E")){
			int Status=groupDAO.edit(getGroup(),sqlStartDate,getUtype(),getLevel(),getName(),session,getMode(),getDocno(),getFormdetailcode());
			if(Status>0){
				setGroup(getGroup());
				setMode(getMode());
				setUtype(getUtype());
				setUtypehidden(getUtype());
				setName(getName());
//				System.out.println(getLevel());
				setLevel(getLevel());
				setGroupdatehidden(sqlStartDate.toString());
				setDocno(getDocno());
				setMode(getMode());
				setMsg("Updated Successfully");

				return "success";
			}
			else if(Status==-1){
				setGroup(getGroup());
				setMode(getMode());
				setUtype(getUtype());
				setUtypehidden(getUtype());
				setName(getName());
//				System.out.println(getLevel());
				setLevel(getLevel());
				setGroupdatehidden(sqlStartDate.toString());
				setChkstatus("2");
				//setDocno(getDocno());
				setMode(getMode());
				setMsg("Group Already Exists");
				return "fail";
			}
			else{
				setGroup(getGroup());
				setMode(getMode());
				setUtype(getUtype());
				setUtypehidden(getUtype());
				setName(getName());
//				System.out.println(getLevel());
				setLevel(getLevel());
				setGroupdatehidden(sqlStartDate.toString());
				setDocno(getDocno());
				setMode(getMode());
				setMsg("Not Updated");

				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			//System.out.println(getDocno()+","+getBrandid()+","+getModeldate());
			int Status=groupDAO.delete(getGroup(),sqlStartDate,getUtype(),getLevel(),getName(),session,getMode(),getDocno(),getFormdetailcode());
		if(Status>0){
			//setDealerid(getDealerid());
			setGroup(getGroup());
			setMode(getMode());
			setUtype(getUtype());
			setUtypehidden(getUtype());
			setName(getName());
//			System.out.println(getLevel());
			setLevel(getLevel());
			setGroupdatehidden(sqlStartDate.toString());
			setDocno(getDocno());
			setMode(getMode());
			setDeleted("DELETED");
			setMsg("Successfully Deleted");

			return "success";
		}
		else if(Status==-2){
			setGroup(getGroup());
			setMode(getMode());
			setUtype(getUtype());
			setUtypehidden(getUtype());
			setName(getName());
//			System.out.println(getLevel());
			setLevel(getLevel());
			setGroupdatehidden(sqlStartDate.toString());
			setDocno(getDocno());
			setMode(getMode());
			setMsg("References Present in Other Documents");
			return "fail";
		}
		else{
			setGroup(getGroup());
			setMode(getMode());
			setUtype(getUtype());
			setUtypehidden(getUtype());
			setName(getName());
//			System.out.println(getLevel());
			setLevel(getLevel());
			setGroupdatehidden(sqlStartDate.toString());
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
			  List <ClsGroupBean> list= groupDAO.list();
			  for(ClsGroupBean bean:list){
			  cellobj = new JSONObject();
			  cellobj.put("doc_no", bean.getDocno());
			  cellobj.put("gid",bean.getGroup());
			  cellobj.put("date",bean.getGroupdate().toString());
			  cellobj.put("gname",bean.getName());
			  cellobj.put("level", bean.getLevel());
			  cellobj.put("utype",bean.getUtype());
			  
			  cellarray.add(cellobj);

			 }
//				 System.out.println("cellobj"+cellarray);
		  } catch (SQLException e) {
			  e.printStackTrace();
		  }
		return cellarray;
	}
	
}
