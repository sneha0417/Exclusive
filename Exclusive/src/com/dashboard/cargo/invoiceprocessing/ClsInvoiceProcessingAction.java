package com.dashboard.cargo.invoiceprocessing;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;
@SuppressWarnings("serial")
public class ClsInvoiceProcessingAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
	ClsInvoiceProcessing Save=new ClsInvoiceProcessing();
	public int gridlength;
	public String uptodate,clientname,hidcldocno,msg;
	private String detail;
	private String detailname;
	
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


	public String getUptodate() {
		return uptodate;
	}


	public void setUptodate(String uptodate) {
		this.uptodate = uptodate;
	}


	public String getClientname() {
		return clientname;
	}


	public void setClientname(String clientname) {
		this.clientname = clientname;
	}


	public String getHidcldocno() {
		return hidcldocno;
	}


	public void setHidcldocno(String hidcldocno) {
		this.hidcldocno = hidcldocno;
	}


	public int getGridlength() {
		return gridlength;
	}


	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}


	public String saveForm() throws SQLException
	{
	 HttpServletRequest request=ServletActionContext.getRequest();

	 HttpSession session=request.getSession();
	 System.out.println("--getUptodate--"+getUptodate());
	 java.sql.Date sqlStartDate=ClsCommon.changeStringtoSqlDate(getUptodate());
	 
	 
	 Map<String, String[]> requestParams = request.getParameterMap();
		System.out.println("getGridlength()--"+getGridlength());
		
			ArrayList<String> descarray= new ArrayList<>();
			for(int i=0;i<getGridlength();i++){
				String temp2=requestParams.get("desctest"+i)[0];
				descarray.add(temp2);
			}
			int value=Save.saveData(descarray,getHidcldocno(),sqlStartDate,session,request);
			if(value>0){
				setDetail("Cargo");
				setDetailname("Invoice Processing");
				setMsg("Succesfully Updated");
				
			}
			else{
				setDetail("Cargo");
				setDetailname("Invoice Processing");
				setMsg("Not Updated");
			}
			return "success";			
			}
			
			
			/**/
			
			
				/*int value=Save.saveData(getMasterdoc_no(),getMastertr_no(),getRefno(),masterdate,getMode(),
						 getFormdetailcode(),getTxtRemarks(),getRefnos(),session,request,descarray,getDocno(),getMawb(), getMbl(), getHawb(),getHbl(),getShipper(),getConsignee(),
				            getCarrier(),getFlightno(),getVoage(),getEta(),getEtd(),getTtime(),getBoe(),getContno(),getTruckno());*/
		
}
