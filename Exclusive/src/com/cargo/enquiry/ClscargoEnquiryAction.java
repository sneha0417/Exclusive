package com.cargo.enquiry;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClscargoEnquiryAction {
	

	ClsCommon ClsCommon=new ClsCommon();
	ClscargoEnquiryBean Beans=new ClscargoEnquiryBean();
	
	ClscargoEnquiryBean viewObj = new ClscargoEnquiryBean();
	ClscargoEnquiryDAO saveObj = new ClscargoEnquiryDAO();

	
	private String EnquiryDate,hidEnquiryDate,cmbclient;
	private String txtclientname,txtaddress,txtmobile;
	private String txtemail,txtRemarks,deleted,enqdtype;
	private int masterdoc_no,docno,enqgridlenght;
	private String gridval,forradiochk,fromdatesval,todateval,txtradio,msg,formdetailcode,mode;
	 
	
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getEnquiryDate() {
		return EnquiryDate;
	}
	public void setEnquiryDate(String enquiryDate) {
		EnquiryDate = enquiryDate;
	}
	public String getHidEnquiryDate() {
		return hidEnquiryDate;
	}
	public void setHidEnquiryDate(String hidEnquiryDate) {
		this.hidEnquiryDate = hidEnquiryDate;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getCmbclient() {
		return cmbclient;
	}
	public void setCmbclient(String cmbclient) {
		this.cmbclient = cmbclient;
	}
	public String getTxtclientname() {
		return txtclientname;
	}
	public void setTxtclientname(String txtclientname) {
		this.txtclientname = txtclientname;
	}
	public String getTxtaddress() {
		return txtaddress;
	}
	public void setTxtaddress(String txtaddress) {
		this.txtaddress = txtaddress;
	}
	public String getTxtmobile() {
		return txtmobile;
	}
	public void setTxtmobile(String txtmobile) {
		this.txtmobile = txtmobile;
	}
	public String getTxtemail() {
		return txtemail;
	}
	public void setTxtemail(String txtemail) {
		this.txtemail = txtemail;
	}
	public String getTxtRemarks() {
		return txtRemarks;
	}
	public void setTxtRemarks(String txtRemarks) {
		this.txtRemarks = txtRemarks;
	}
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public String getEnqdtype() {
		return enqdtype;
	}
	public void setEnqdtype(String enqdtype) {
		this.enqdtype = enqdtype;
	}
	public int getEnqgridlenght() {
		return enqgridlenght;
	}
	public void setEnqgridlenght(int enqgridlenght) {
		this.enqgridlenght = enqgridlenght;
	}
	public String getGridval() {
		return gridval;
	}
	public void setGridval(String gridval) {
		this.gridval = gridval;
	}
	public String getForradiochk() {
		return forradiochk;
	}
	public void setForradiochk(String forradiochk) {
		this.forradiochk = forradiochk;
	}
	public String getFromdatesval() {
		return fromdatesval;
	}
	public void setFromdatesval(String fromdatesval) {
		this.fromdatesval = fromdatesval;
	}
	public String getTodateval() {
		return todateval;
	}
	public void setTodateval(String todateval) {
		this.todateval = todateval;
	}
	public String getTxtradio() {
		return txtradio;
	}
	public void setTxtradio(String txtradio) {
		this.txtradio = txtradio;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	ClscargoEnquiryDAO savecargoendata=new ClscargoEnquiryDAO();
	
	public String saveCargoEnquiry() throws ParseException, SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		String mode=getMode();		
		
		if(mode.equalsIgnoreCase("A")){
			java.sql.Date enquirydate = ClsCommon.changeStringtoSqlDate(getEnquiryDate());
			
			ArrayList<String> descarray= new ArrayList<>();
			for(int i=0;i<getEnqgridlenght();i++){
				String temp2=requestParams.get("enqtest"+i)[0];
				descarray.add(temp2);
			}

			
		int val=savecargoendata.insert(enquirydate,getCmbclient(),session,getMode(),getFormdetailcode(),request,descarray,getTxtRemarks());
		int docno=(int) request.getAttribute("vocno");
		if(val>0)
		{
			setDocno(docno);
			setEnquiryDate(enquirydate.toString());
			 setMasterdoc_no(val);
			setData();
			setMsg("Successfully Saved");
			return "success";
		}
		else
		{
			setHidEnquiryDate(hidEnquiryDate.toString());
			setData();
			setMsg("Not Saved");
			return "fail";
		}
		}
		else if(mode.equalsIgnoreCase("E")){
			java.sql.Date enquirydate = ClsCommon.changeStringtoSqlDate(getEnquiryDate());
			ArrayList<String> descarray= new ArrayList<>();
			for(int i=0;i<getEnqgridlenght();i++){
				
			 
				String temp2=requestParams.get("enqtest"+i)[0];
			 

				descarray.add(temp2);
				 
			}
			int val=savecargoendata.update(getMasterdoc_no(),enquirydate,cmbclient,getTxtRemarks(),session,getMode(),getFormdetailcode(),request,descarray);
			if(val>0){
				
					setDocno(getDocno());
					setMasterdoc_no(getMasterdoc_no());
					setData();
					setMsg("Updated Successfully");
				    return "success";
			}
			else{
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());
				setData();
				setMsg("Not Updated");
				return "fail";
				}
		}
		
		else if(mode.equalsIgnoreCase("D")){


			int val=savecargoendata.delete(getMasterdoc_no(),session,getMode(),getFormdetailcode(),request);

			if(val>0)
			{
				
				
			 
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());
				setData();
			    setDeleted("DELETED");
				setMsg("Successfully Deleted");
			    return "success";
			}
			else
			{
				 
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());
				setData();
				setMsg("Not Deleted");
			     return "fail";
					
			}
		}
			else if(mode.equalsIgnoreCase("view")){
				
				viewObj=saveObj.getViewDetails(getMasterdoc_no() , session);
				System.out.println("==== "+getMasterdoc_no());
				setDocno(viewObj.getDocno());
				setMasterdoc_no(viewObj.getMasterdoc_no());
				
				setTxtRemarks(viewObj.getTxtRemarks());
				setHidEnquiryDate(viewObj.getHidEnquiryDate());
				setCmbclient(viewObj.getCmbclient());
				setTxtclientname(viewObj.getTxtclientname());
				setTxtemail(viewObj.getTxtemail());
				setTxtaddress(viewObj.getTxtaddress());
				setTxtmobile(viewObj.getTxtmobile());
				
			}


				
		return "fail";
		
	}
	
	public void setData(){
		setDocno(getDocno());
		setCmbclient(getCmbclient());
		 setEnqdtype(getEnqdtype());
		 setEnqgridlenght(getEnqgridlenght());
		 setEnquiryDate(getEnquiryDate());
		 setFormdetailcode(getFormdetailcode());
		 setForradiochk(getForradiochk());
		 setFromdatesval(getFromdatesval());
		 setGridval(getGridval());
		 setMode(getMode());
		 setHidEnquiryDate(getHidEnquiryDate());
		 setTodateval(getTodateval());
		 setTxtaddress(getTxtaddress());
		 setTxtclientname(getTxtclientname());
		 setTxtemail(getTxtemail());
		 setTxtmobile(getTxtmobile());
		 setTxtradio(getTxtradio());
		 setTxtRemarks(getTxtRemarks());
		 setMasterdoc_no(getMasterdoc_no());
	}	
}
