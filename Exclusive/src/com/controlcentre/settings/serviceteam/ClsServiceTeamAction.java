package com.controlcentre.settings.serviceteam;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;


public class ClsServiceTeamAction {
	
	ClsServiceTeamDAO DAO= new ClsServiceTeamDAO();
	ClsCommon com=new ClsCommon();
	
	ClsServiceTeamBean bean;

	private int docno;
	private String date;
	private String mode;
	private String deleted;
	private String hiddate;
	private String msg;
	private String txtgpcode;
	private String txtdesc;
	private int serteamgridlen;
	private String formdetailcode;
	private int ismultiemp;
	private boolean ismemp;
	private String txtteamuserlinkname;
	private String txtteamuserlinkid;

	public boolean isIsmemp() {
		return ismemp;
	}
	public void setIsmemp(boolean ismemp) {
		this.ismemp = ismemp;
	}
	public int getIsmultiemp() {
		return ismultiemp;
	}
	public void setIsmultiemp(int ismultiemp) {
		this.ismultiemp = ismultiemp;
	}
	public int getSerteamgridlen() {
		return serteamgridlen;
	}
	public void setSerteamgridlen(int serteamgridlen) {
		this.serteamgridlen = serteamgridlen;
	}
	public String getTxtgpcode() {
		return txtgpcode;
	}
	public void setTxtgpcode(String txtgpcode) {
		this.txtgpcode = txtgpcode;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getHiddate() {
		return hiddate;
	}
	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}

	public String getTxtdesc() {
		return txtdesc;
	}
	public void setTxtdesc(String txtdesc) {
		this.txtdesc = txtdesc;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
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
	
	public String getTxtteamuserlinkname() {
		return txtteamuserlinkname;
	}
	public void setTxtteamuserlinkname(String txtteamuserlinkname) {
		this.txtteamuserlinkname = txtteamuserlinkname;
	}
	public String getTxtteamuserlinkid() {
		return txtteamuserlinkid;
	}
	public void setTxtteamuserlinkid(String txtteamuserlinkid) {
		this.txtteamuserlinkid = txtteamuserlinkid;
	}
	
	public String saveAction() throws ParseException, SQLException{

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		ClsServiceTeamBean bean=new ClsServiceTeamBean();
		java.sql.Date sqlStartDate = com.changeStringtoSqlDate(getDate());

		if(mode.equalsIgnoreCase("A")){


			ArrayList<String> descarray= new ArrayList<>();

			Map<String, String[]> requestParams = request.getParameterMap();
			for(int i=0;i<getSerteamgridlen();i++){

				String temp=requestParams.get("test"+i)[0];

				descarray.add(temp);
			}


			int val=DAO.insert(getTxtgpcode(),getTxtdesc(),descarray,session,sqlStartDate,getMode(),getFormdetailcode(),getIsmultiemp(),getTxtteamuserlinkid());
			if(val>0){
				setDate(sqlStartDate.toString());
				setTxtgpcode(getTxtgpcode());
				setTxtdesc(getTxtdesc());
				setTxtteamuserlinkname(getTxtteamuserlinkname());
				setTxtteamuserlinkid(getTxtteamuserlinkid());
				setDocno(val);
				if(getIsmultiemp()>=1){
					setIsmemp(true);
				}
				else{
					setIsmemp(false);
				}
				setMsg("Successfully Saved");

				return "success";
			}
			else{
				setDate(sqlStartDate.toString());
				setTxtgpcode(getTxtgpcode());
				setTxtdesc(getTxtdesc());
				setTxtteamuserlinkname(getTxtteamuserlinkname());
				setTxtteamuserlinkid(getTxtteamuserlinkid());
				setDocno(val);
				setMode("A");
				if(getIsmultiemp()>=1){
					setIsmemp(true);
				}
				else{
					setIsmemp(false);
				}
				setMsg("Not Saved");
				return "fail";
			}	

		}

		else if(mode.equalsIgnoreCase("E")){


			ArrayList<String> descarray= new ArrayList<>();

			Map<String, String[]> requestParams = request.getParameterMap();
			for(int i=0;i<getSerteamgridlen();i++){

				String temp=requestParams.get("test"+i)[0];

				descarray.add(temp);
			}


			int val=DAO.edit(getDocno(),getTxtgpcode(),getTxtdesc(),descarray,session,sqlStartDate,getMode(),getFormdetailcode(),getIsmultiemp(),getTxtteamuserlinkid());
			if(val>0){
				setDate(sqlStartDate.toString());
				setTxtgpcode(getTxtgpcode());
				setTxtdesc(getTxtdesc());
				setTxtteamuserlinkname(getTxtteamuserlinkname());
				setTxtteamuserlinkid(getTxtteamuserlinkid());
				setDocno(val);

				setMsg("Updated Successfully");

				return "success";
			}
			else{
				setDate(sqlStartDate.toString());
				setTxtgpcode(getTxtgpcode());
				setTxtdesc(getTxtdesc());
				setTxtteamuserlinkname(getTxtteamuserlinkname());
				setTxtteamuserlinkid(getTxtteamuserlinkid());
				setDocno(val);
				if(getIsmultiemp()>=1){
					setIsmemp(true);
				}
				else{
					setIsmemp(false);
				}
				setMode("E");
				setMsg("Not Saved");
				return "fail";
			}	

		}

		else if(mode.equalsIgnoreCase("D")){


			ArrayList<String> descarray= new ArrayList<>();

			Map<String, String[]> requestParams = request.getParameterMap();
			/*for(int i=0;i<getSerteamgridlen();i++){

				String temp=requestParams.get("test"+i)[0];

				descarray.add(temp);
			}*/


			int val=DAO.delete(getDocno(),getTxtgpcode(),getTxtdesc(),descarray,session,sqlStartDate,getMode(),getFormdetailcode(),getIsmultiemp(),getTxtteamuserlinkid());
			if(val>0){
				setDate(sqlStartDate.toString());
				setTxtgpcode(getTxtgpcode());
				setTxtdesc(getTxtdesc());
				setTxtteamuserlinkname(getTxtteamuserlinkname());
				setTxtteamuserlinkid(getTxtteamuserlinkid());
				setDocno(val);

				setMsg("Successfully Deleted");

				return "success";
			}
			else{
				setDate(sqlStartDate.toString());
				setTxtgpcode(getTxtgpcode());
				setTxtdesc(getTxtdesc());
				setTxtteamuserlinkname(getTxtteamuserlinkname());
				setTxtteamuserlinkid(getTxtteamuserlinkid());
				setDocno(val);
				if(getIsmultiemp()>=1){
					setIsmemp(true);
				}
				else{
					setIsmemp(false);
				}
				setMsg("Not Deleted");
				return "fail";
			}	

		}


		return "fail";
	}

}
