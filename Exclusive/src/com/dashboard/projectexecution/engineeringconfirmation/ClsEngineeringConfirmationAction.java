package com.dashboard.projectexecution.engineeringconfirmation;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;


public class ClsEngineeringConfirmationAction {
	ClsEngineeringConfirmationDAO DAO=new ClsEngineeringConfirmationDAO();
	ClsCommon com=new ClsCommon();
 
	 private String txtrdocno;
	 private String date;
	 private String txtremarks;
	 private String cmbprocess;
	 private String txtbrchid;
	 private String txtuserid;
	 private String hidcontracttrno;
	 private int estimationgrdlen;

	 private String detail;
		private String detailname;
		private String msg;
	


	public String getDetail() {
			return detail;
		}


		public void setDetail(String detail) {
			this.detail = detail;
		}


		public String getDetailname() {
			return detailname;
		}


		public void setDetailname(String detailname) {
			this.detailname = detailname;
		}


		public String getMsg() {
			return msg;
		}


		public void setMsg(String msg) {
			this.msg = msg;
		}


	public int getEstimationgrdlen() {
		return estimationgrdlen;
	}


	public void setEstimationgrdlen(int estimationgrdlen) {
		this.estimationgrdlen = estimationgrdlen;
	}


	public String getTxtrdocno() {
		return txtrdocno;
	}


	public void setTxtrdocno(String txtrdocno) {
		this.txtrdocno = txtrdocno;
	}


	public String getDate() {
		return date;
	}


	public void setDate(String date) {
		this.date = date;
	}


	public String getTxtremarks() {
		return txtremarks;
	}


	public void setTxtremarks(String txtremarks) {
		this.txtremarks = txtremarks;
	}


	public String getCmbprocess() {
		return cmbprocess;
	}


	public void setCmbprocess(String cmbprocess) {
		this.cmbprocess = cmbprocess;
	}


	public String getTxtbrchid() {
		return txtbrchid;
	}


	public void setTxtbrchid(String txtbrchid) {
		this.txtbrchid = txtbrchid;
	}


	public String getTxtuserid() {
		return txtuserid;
	}


	public void setTxtuserid(String txtuserid) {
		this.txtuserid = txtuserid;
	}


	public String getHidcontracttrno() {
		return hidcontracttrno;
	}


	public void setHidcontracttrno(String hidcontracttrno) {
		this.hidcontracttrno = hidcontracttrno;
	}


	public String savepfAction(){

		HttpServletRequest request=ServletActionContext.getRequest();
	//	HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String returns="";
		int val=0;

		System.out.println("inside est confirm saveaction");
		java.sql.Date date=com.changeStringtoSqlDate(getDate());

		try{
			ArrayList<String> matlist=new ArrayList<String> ();
		
			for(int i=0;i<getEstimationgrdlen();i++){
				String temp=requestParams.get("mate"+i)[0];		
				matlist.add(temp);
			}
			System.out.println("matlist=="+matlist);
			val=DAO.insert(date, getTxtrdocno(), getTxtremarks(), getTxtbrchid(), getTxtuserid(),getCmbprocess(),matlist,getHidcontracttrno());
			
			if(val>0){
				
				setDetail("Project Excecution");
				setDetailname("Engineering Confirmation");
				setMsg("Successfully Saved");
				setCmbprocess("");
				setTxtremarks("");
				return "success";
				
			}
			else{
				setMsg("Not Saved");
				setCmbprocess("");
				setTxtremarks("");
				returns="fail";
			}

				

			}

		
		
		catch(Exception e){
			e.printStackTrace();
			
		}
		
		return returns;
	}



}
