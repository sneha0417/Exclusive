package com.humanresource.setup.candidatemaster;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsCandidateMasterAction {
	ClsCommon ClsCommon=new ClsCommon();
	ClsCandidateMasterDAO cndDao=new ClsCandidateMasterDAO();
	ClsCandidateMasterBean cndBean=new ClsCandidateMasterBean();
	
	private int hidmasterdocno;
	private int docno;
	private String formdetailcode;
	private String chkstatus;
	private String mode;
	private String deleted;
	private String msg;
	
	private String hidqualificationid;
	private String hidnationid;
	private String txtremarks;
	private String hiddesignationid;
	private String txtpostapplied;
	private String txtexpyear;
	private String txtqualification;
	private String txtnationality;
	private String txtdesignation;
	private String cnddob;
	private String cmbgender;
	private String txtcndname;
	private String txtrefno;
	private String cnddate;
	private int cvarraygridlength;
	private String hidcnddate,hidcnddob,hidcmbgender;
	
	
	
	public String getTxtdesignation() {
		return txtdesignation;
	}
	public void setTxtdesignation(String txtdesignation) {
		this.txtdesignation = txtdesignation;
	}
	public String getHidcnddate() {
		return hidcnddate;
	}
	public void setHidcnddate(String hidcnddate) {
		this.hidcnddate = hidcnddate;
	}
	public String getHidcnddob() {
		return hidcnddob;
	}
	public void setHidcnddob(String hidcnddob) {
		this.hidcnddob = hidcnddob;
	}
	public String getHidcmbgender() {
		return hidcmbgender;
	}
	public void setHidcmbgender(String hidcmbgender) {
		this.hidcmbgender = hidcmbgender;
	}
	public int getCvarraygridlength() {
		return cvarraygridlength;
	}
	public void setCvarraygridlength(int cvarraygridlength) {
		this.cvarraygridlength = cvarraygridlength;
	}
	public String getHiddesignationid() {
		return hiddesignationid;
	}
	public void setHiddesignationid(String hiddesignationid) {
		this.hiddesignationid = hiddesignationid;
	}
	public int getHidmasterdocno() {
		return hidmasterdocno;
	}
	public void setHidmasterdocno(int hidmasterdocno) {
		this.hidmasterdocno = hidmasterdocno;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getChkstatus() {
		return chkstatus;
	}
	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
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
	public String getHidqualificationid() {
		return hidqualificationid;
	}
	public void setHidqualificationid(String hidqualificationid) {
		this.hidqualificationid = hidqualificationid;
	}
	public String getHidnationid() {
		return hidnationid;
	}
	public void setHidnationid(String hidnationid) {
		this.hidnationid = hidnationid;
	}
	public String getTxtremarks() {
		return txtremarks;
	}
	public void setTxtremarks(String txtremarks) {
		this.txtremarks = txtremarks;
	}
	
	public String getTxtpostapplied() {
		return txtpostapplied;
	}
	public void setTxtpostapplied(String txtpostapplied) {
		this.txtpostapplied = txtpostapplied;
	}
	public String getTxtexpyear() {
		return txtexpyear;
	}
	public void setTxtexpyear(String txtexpyear) {
		this.txtexpyear = txtexpyear;
	}
	public String getTxtqualification() {
		return txtqualification;
	}
	public void setTxtqualification(String txtqualification) {
		this.txtqualification = txtqualification;
	}
	public String getTxtnationality() {
		return txtnationality;
	}
	public void setTxtnationality(String txtnationality) {
		this.txtnationality = txtnationality;
	}
	public String getCnddob() {
		return cnddob;
	}
	public void setCnddob(String cnddob) {
		this.cnddob = cnddob;
	}
	public String getCmbgender() {
		return cmbgender;
	}
	public void setCmbgender(String cmbgender) {
		this.cmbgender = cmbgender;
	}
	public String getTxtcndname() {
		return txtcndname;
	}
	public void setTxtcndname(String txtcndname) {
		this.txtcndname = txtcndname;
	}
	public String getTxtrefno() {
		return txtrefno;
	}
	public void setTxtrefno(String txtrefno) {
		this.txtrefno = txtrefno;
	}
	public String getCnddate() {
		return cnddate;
	}
	public void setCnddate(String cnddate) {
		this.cnddate = cnddate;
	}




	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		String mode=getMode();
		System.out.println("inside save action"+mode);
		
		if(mode.equalsIgnoreCase("A")){
			ArrayList<String> cvarray= new ArrayList<>();
			for(int i=0;i<getCvarraygridlength();i++){
				String temp=requestParams.get("txtcvanalyse"+i)[0];
				cvarray.add(temp);
			}
			
			int val=cndDao.insert(getCnddate(),getTxtrefno(),getTxtcndname(),getCmbgender(),getCnddob(),getHidnationid(),getHidqualificationid(),getTxtexpyear(),getTxtpostapplied(),getHiddesignationid(),getTxtremarks(),cvarray,session,request,mode);
			if(val>0.0){
				
				setDocno(val);
				setHidmasterdocno(val);
				setData();
				
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setData();
				setMsg("Not Saved");
				return "fail";
			}
			
		}else if(mode.equalsIgnoreCase("E")){
			ArrayList<String> cvarray= new ArrayList<>();
			for(int i=0;i<getCvarraygridlength();i++){
				String temp=requestParams.get("txtcvanalyse"+i)[0];
				cvarray.add(temp);
			}
			int val=cndDao.edit(getDocno(),getCnddate(),getTxtrefno(),getTxtcndname(),getCmbgender(),getCnddob(),getHidnationid(),getHidqualificationid(),getTxtexpyear(),getTxtpostapplied(),getHiddesignationid(),getTxtremarks(),cvarray,session,request,mode);
			if(val>0.0){
				setDocno(val);
				setHidmasterdocno(val);
				setData();
				
				setMsg("Successfully Updated");
				return "success";
			}
			else{
				setData();
				setMsg("Not Updated");
				return "fail";
			}
			
			
		}else if(mode.equalsIgnoreCase("D")){
			
			int val=cndDao.delete(session,request,mode,getDocno());
			if(val>0.0){
				setDocno(val);
				setHidmasterdocno(val);
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setData();
				setMsg("Not Deleted");
				return "fail";
			}
			
		}else if(mode.equalsIgnoreCase("view")){
			cndBean=cndDao.getViewDetails(getDocno());
			
			setHidnationid(cndBean.getHidnationid());
			setHidqualificationid(cndBean.getHidqualificationid());
			setHidcnddate(cndBean.getHidcnddate());
			setHidcmbgender(cndBean.getHidcmbgender());
			setHidcnddob(cndBean.getHidcnddob());
			setDocno(cndBean.getDocno());
			setTxtcndname(cndBean.getTxtcndname());
			setTxtexpyear(cndBean.getTxtexpyear());
			setTxtnationality(cndBean.getTxtnationality());
			setTxtqualification(cndBean.getTxtqualification());
			setTxtpostapplied(cndBean.getTxtpostapplied());
			setTxtrefno(cndBean.getTxtrefno());
			setTxtremarks(cndBean.getTxtremarks());
			setTxtdesignation(cndBean.getTxtdesignation());
			
			return "success";
		}
		
		return "fail";
	}
	
	public void setData() {
		setCvarraygridlength(getCvarraygridlength());
		setDocno(getDocno());
		setHidcmbgender(getCmbgender());
		setHidcnddate(getHidcnddate());
		setHidcnddob(getHidcnddob());
		setHiddesignationid(getHiddesignationid());
		setHidmasterdocno(getDocno());
		setHidnationid(getHidnationid());
		setHidqualificationid(getHidqualificationid());
		setMsg(getMsg());
		setTxtcndname(getTxtcndname());
		setTxtexpyear(getTxtexpyear());
		setTxtnationality(getTxtnationality());
		setTxtpostapplied(getTxtpostapplied());
		setTxtqualification(getTxtqualification());
		setTxtrefno(getTxtrefno());
		setTxtremarks(getTxtremarks());
		setFormdetailcode(getFormdetailcode());
	}
}
