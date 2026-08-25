package com.project.execution.templates;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import sun.reflect.ReflectionFactory.GetReflectionFactoryAction;

import com.common.ClsCommon;

public class ClsTemplateAction {

	ClsCommon com=new ClsCommon();

	private String date;
	private String hiddate;

	private String txtrefno;
	private int docno;

	private String txtprojectname;
	private int txtprojectid;
	private String txtsectionname;
	private int txtsectionid;
	private String txtactivity;
	private String txtdescription;
	private String txtnettotal;

	private String mode;
	private String deleted;
	private String msg;
	private String formdetailcode;

	private String txtmatotal;
	private String txtlabtotal;
	private String txteqptotal;


	private int eqgridlen;
	private int labgridlen;
	private int matgridlen;

	private String masterdoc_no;

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getHiddate() {
		return hiddate;
	}

	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
	}

	public String getTxtrefno() {
		return txtrefno;
	}

	public void setTxtrefno(String txtrefno) {
		this.txtrefno = txtrefno;
	}

	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public String getTxtprojectname() {
		return txtprojectname;
	}

	public void setTxtprojectname(String txtprojectname) {
		this.txtprojectname = txtprojectname;
	}

	public int getTxtprojectid() {
		return txtprojectid;
	}

	public void setTxtprojectid(int txtprojectid) {
		this.txtprojectid = txtprojectid;
	}

	public String getTxtsectionname() {
		return txtsectionname;
	}

	public void setTxtsectionname(String txtsectionname) {
		this.txtsectionname = txtsectionname;
	}

	public int getTxtsectionid() {
		return txtsectionid;
	}

	public void setTxtsectionid(int txtsectionid) {
		this.txtsectionid = txtsectionid;
	}

	public String getTxtactivity() {
		return txtactivity;
	}

	public void setTxtactivity(String txtactivity) {
		this.txtactivity = txtactivity;
	}

	public String getTxtdescription() {
		return txtdescription;
	}

	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}

	public String getTxtnettotal() {
		return txtnettotal;
	}

	public void setTxtnettotal(String txtnettotal) {
		this.txtnettotal = txtnettotal;
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

	public String getTxtmatotal() {
		return txtmatotal;
	}

	public void setTxtmatotal(String txtmatotal) {
		this.txtmatotal = txtmatotal;
	}

	public String getTxtlabtotal() {
		return txtlabtotal;
	}

	public void setTxtlabtotal(String txtlabtotal) {
		this.txtlabtotal = txtlabtotal;
	}

	public String getTxteqptotal() {
		return txteqptotal;
	}

	public void setTxteqptotal(String txteqptotal) {
		this.txteqptotal = txteqptotal;
	}

	public int getEqgridlen() {
		return eqgridlen;
	}

	public void setEqgridlen(int eqgridlen) {
		this.eqgridlen = eqgridlen;
	}

	public int getLabgridlen() {
		return labgridlen;
	}

	public void setLabgridlen(int labgridlen) {
		this.labgridlen = labgridlen;
	}

	public int getMatgridlen() {
		return matgridlen;
	}

	public void setMatgridlen(int matgridlen) {
		this.matgridlen = matgridlen;
	}

	public String getMasterdoc_no() {
		return masterdoc_no;
	}

	public void setMasterdoc_no(String masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}



	public String saveTemplatesAction(){

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		String returns="";
		int val=0;

		System.out.println("inside saveaction");

		try{
			ArrayList matlist=new ArrayList();

			ArrayList lablist=new ArrayList();

			ArrayList equplist=new ArrayList();


			for(int i=0;i<getMatgridlen();i++){
				String temp=requestParams.get("mate"+i)[0];		
				matlist.add(temp);
			}
			for(int i=0;i<getLabgridlen();i++){
				String temp=requestParams.get("lab"+i)[0];		
				lablist.add(temp);
			}
			for(int i=0;i<getEqgridlen();i++){
				String temp=requestParams.get("equip"+i)[0];		
				equplist.add(temp);
			}

			ClsTemplateDAO DAO=new ClsTemplateDAO();

			if(mode.equalsIgnoreCase("A")){

				java.sql.Date date=com.changeStringtoSqlDate(getDate());

				val=DAO.insert(date,getTxtrefno(),getTxtprojectid(),getTxtsectionid(),getTxtactivity(),getTxtdescription(),getTxtnettotal(),getFormdetailcode(),mode,matlist,lablist,equplist,session,request);

				if(val>0){
					setMasterdoc_no(request.getAttribute("docNo").toString());
					setDocno(val);
					setDate(date+"");
					setHiddate(date+"");
					setTxtrefno(getTxtrefno());
					setTxtprojectname(getTxtprojectname());
					setTxtprojectid(getTxtprojectid());
					setTxtsectionname(getTxtsectionname());
					setTxtsectionid(getTxtsectionid());
					setTxtactivity(getTxtactivity());
					setTxtdescription(getTxtdescription());
					setTxtnettotal(getTxtnettotal());
					setFormdetailcode(getFormdetailcode());
					setMode(getMode());
					setMsg("Successfully Saved");
					returns="success";
				}
				else{
					setDate(date+"");
					setHiddate(date+"");
					setTxtrefno(getTxtrefno());
					setTxtprojectname(getTxtprojectname());
					setTxtprojectid(getTxtprojectid());
					setTxtsectionname(getTxtsectionname());
					setTxtsectionid(getTxtsectionid());
					setTxtactivity(getTxtactivity());
					setTxtdescription(getTxtdescription());
					setTxtnettotal(getTxtnettotal());
					setFormdetailcode(getFormdetailcode());
					setMode(getMode());
					setMsg("Not Saved");
					returns="fail";
				}

			}

			if(mode.equalsIgnoreCase("E")){

				java.sql.Date date=com.changeStringtoSqlDate(getDate());

				val=DAO.edit(getDocno(),getMasterdoc_no(),date,getTxtrefno(),getTxtprojectid(),getTxtsectionid(),getTxtactivity(),getTxtdescription(),getTxtnettotal(),getFormdetailcode(),mode,matlist,lablist,equplist,session,request);

				if(val>0){
					setMasterdoc_no(request.getAttribute("docNo").toString());
					setDocno(val);
					setDate(date+"");
					setHiddate(date+"");
					setTxtrefno(getTxtrefno());
					setTxtprojectname(getTxtprojectname());
					setTxtprojectid(getTxtprojectid());
					setTxtsectionname(getTxtsectionname());
					setTxtsectionid(getTxtsectionid());
					setTxtactivity(getTxtactivity());
					setTxtdescription(getTxtdescription());
					setTxtnettotal(getTxtnettotal());
					setFormdetailcode(getFormdetailcode());
					setMode(getMode());
					setMsg("Updated Successfully");
					returns="success";
				}
				else{
					setDate(date+"");
					setHiddate(date+"");
					setTxtrefno(getTxtrefno());
					setTxtprojectname(getTxtprojectname());
					setTxtprojectid(getTxtprojectid());
					setTxtsectionname(getTxtsectionname());
					setTxtsectionid(getTxtsectionid());
					setTxtactivity(getTxtactivity());
					setTxtdescription(getTxtdescription());
					setTxtnettotal(getTxtnettotal());
					setFormdetailcode(getFormdetailcode());
					setMode(getMode());
					setMsg("Not Saved");
					returns="fail";
				}

			}
			if(mode.equalsIgnoreCase("D")){

				java.sql.Date date=com.changeStringtoSqlDate(getDate());

				val=DAO.delete(getDocno(),getMasterdoc_no(),date,getTxtrefno(),getTxtprojectid(),getTxtsectionid(),getTxtactivity(),getTxtdescription(),getTxtnettotal(),getFormdetailcode(),mode,matlist,lablist,equplist,session,request);

				if(val>0){
					setMasterdoc_no(request.getAttribute("docNo").toString());
					setDocno(val);
					setDate(date+"");
					setHiddate(date+"");
					setTxtrefno(getTxtrefno());
					setTxtprojectname(getTxtprojectname());
					setTxtprojectid(getTxtprojectid());
					setTxtsectionname(getTxtsectionname());
					setTxtsectionid(getTxtsectionid());
					setTxtactivity(getTxtactivity());
					setTxtdescription(getTxtdescription());
					setTxtnettotal(getTxtnettotal());
					setFormdetailcode(getFormdetailcode());
					setMode(getMode());
					setMsg("Successfully Deleted");
					returns="success";
				}
				else{
					
					setDate(date+"");
					setHiddate(date+"");
					setTxtrefno(getTxtrefno());
					setTxtprojectname(getTxtprojectname());
					setTxtprojectid(getTxtprojectid());
					setTxtsectionname(getTxtsectionname());
					setTxtsectionid(getTxtsectionid());
					setTxtactivity(getTxtactivity());
					setTxtdescription(getTxtdescription());
					setTxtnettotal(getTxtnettotal());
					setFormdetailcode(getFormdetailcode());
					setMode(getMode());
					setMsg("Not Saved");
					returns="fail";
					
				}

			}
			
			
			if(mode.equalsIgnoreCase("view")){
				
				setDate(date+"");
				setHiddate(date+"");

				returns="success";
			}


		}
		catch(Exception e){
			e.printStackTrace();
		}
		return returns;


	}


}
