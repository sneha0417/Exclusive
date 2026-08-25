package com.project.execution.callRegister;

import java.lang.invoke.CallSite;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsCallRegisterAction extends ActionSupport{

	ClsCommon commonDAO= new ClsCommon();
	ClsCallRegisterDAO callRegisterDAO= new ClsCallRegisterDAO();
	ClsCallRegisterBean callRegisterBean;

	private int txtcallregisterdocno;
	private int txtcallregistertrno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String callRegisterDate;
	private String hidcallRegisterDate;
	private String txtrefno;
	private String txtclientname;
	private int txtclientdocno;
	private String txtclientacno;
	private String txtclientdetails;
	private String txtclienttele;
	private String txtclientmobile;
	private String txtclientmail;
	private String txtcontactperson;
	private String txtcontactpersontele;
	private String txtcontactpersonmob;
	private String txtcontactpersonmail;
	private String contractDate;
	private String hidcontractDate;
	private String contractTime;
	private String hidcontractTime;
	private String cmbcontracttype;
	private String hidcmbcontracttype;
	private String txtcontractno;
	private String txtcontracttrno;
	private String txtcontractdetails;
	private String txtsite;
	private String txtsiteid;
	private String txtdescription;
	
	private String lblclname;
	private String lbljobdat;
	private String lblsite;
	private String lbldocnno;
	private String lbldtype;
	private String lblschno;
	private String lblarea;
	private String lblclientlpo;
	private String lbldescription;
	

	public String getLblclname() {
		return lblclname;
	}

	public void setLblclname(String lblclname) {
		this.lblclname = lblclname;
	}

	public String getLbljobdat() {
		return lbljobdat;
	}

	public void setLbljobdat(String lbljobdat) {
		this.lbljobdat = lbljobdat;
	}

	public String getLblsite() {
		return lblsite;
	}

	public void setLblsite(String lblsite) {
		this.lblsite = lblsite;
	}

	public String getLbldocnno() {
		return lbldocnno;
	}

	public void setLbldocnno(String lbldocnno) {
		this.lbldocnno = lbldocnno;
	}

	public String getLbldtype() {
		return lbldtype;
	}

	public void setLbldtype(String lbldtype) {
		this.lbldtype = lbldtype;
	}

	public String getLblschno() {
		return lblschno;
	}

	public void setLblschno(String lblschno) {
		this.lblschno = lblschno;
	}

	public String getLblarea() {
		return lblarea;
	}

	public void setLblarea(String lblarea) {
		this.lblarea = lblarea;
	}

	public String getLblclientlpo() {
		return lblclientlpo;
	}

	public void setLblclientlpo(String lblclientlpo) {
		this.lblclientlpo = lblclientlpo;
	}

	public String getLbldescription() {
		return lbldescription;
	}

	public void setLbldescription(String lbldescription) {
		this.lbldescription = lbldescription;
	}

	private String url;
	
	//Complaints Grid
	private int gridlength;
	
	public int getTxtcallregisterdocno() {
		return txtcallregisterdocno;
	}

	public void setTxtcallregisterdocno(int txtcallregisterdocno) {
		this.txtcallregisterdocno = txtcallregisterdocno;
	}

	public int getTxtcallregistertrno() {
		return txtcallregistertrno;
	}

	public void setTxtcallregistertrno(int txtcallregistertrno) {
		this.txtcallregistertrno = txtcallregistertrno;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
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

	public String getCallRegisterDate() {
		return callRegisterDate;
	}

	public void setCallRegisterDate(String callRegisterDate) {
		this.callRegisterDate = callRegisterDate;
	}

	public String getHidcallRegisterDate() {
		return hidcallRegisterDate;
	}

	public void setHidcallRegisterDate(String hidcallRegisterDate) {
		this.hidcallRegisterDate = hidcallRegisterDate;
	}

	public String getTxtrefno() {
		return txtrefno;
	}

	public void setTxtrefno(String txtrefno) {
		this.txtrefno = txtrefno;
	}

	public String getTxtclientname() {
		return txtclientname;
	}

	public void setTxtclientname(String txtclientname) {
		this.txtclientname = txtclientname;
	}

	public int getTxtclientdocno() {
		return txtclientdocno;
	}

	public void setTxtclientdocno(int txtclientdocno) {
		this.txtclientdocno = txtclientdocno;
	}

	public String getTxtclientacno() {
		return txtclientacno;
	}

	public void setTxtclientacno(String txtclientacno) {
		this.txtclientacno = txtclientacno;
	}

	public String getTxtclientdetails() {
		return txtclientdetails;
	}

	public void setTxtclientdetails(String txtclientdetails) {
		this.txtclientdetails = txtclientdetails;
	}

	public String getTxtclienttele() {
		return txtclienttele;
	}

	public void setTxtclienttele(String txtclienttele) {
		this.txtclienttele = txtclienttele;
	}

	public String getTxtclientmobile() {
		return txtclientmobile;
	}

	public void setTxtclientmobile(String txtclientmobile) {
		this.txtclientmobile = txtclientmobile;
	}

	public String getTxtclientmail() {
		return txtclientmail;
	}

	public void setTxtclientmail(String txtclientmail) {
		this.txtclientmail = txtclientmail;
	}

	public String getTxtcontactperson() {
		return txtcontactperson;
	}

	public void setTxtcontactperson(String txtcontactperson) {
		this.txtcontactperson = txtcontactperson;
	}

	public String getTxtcontactpersontele() {
		return txtcontactpersontele;
	}

	public void setTxtcontactpersontele(String txtcontactpersontele) {
		this.txtcontactpersontele = txtcontactpersontele;
	}

	public String getTxtcontactpersonmob() {
		return txtcontactpersonmob;
	}

	public void setTxtcontactpersonmob(String txtcontactpersonmob) {
		this.txtcontactpersonmob = txtcontactpersonmob;
	}

	public String getTxtcontactpersonmail() {
		return txtcontactpersonmail;
	}

	public void setTxtcontactpersonmail(String txtcontactpersonmail) {
		this.txtcontactpersonmail = txtcontactpersonmail;
	}

	public String getContractDate() {
		return contractDate;
	}

	public void setContractDate(String contractDate) {
		this.contractDate = contractDate;
	}

	public String getHidcontractDate() {
		return hidcontractDate;
	}

	public void setHidcontractDate(String hidcontractDate) {
		this.hidcontractDate = hidcontractDate;
	}

	public String getContractTime() {
		return contractTime;
	}

	public void setContractTime(String contractTime) {
		this.contractTime = contractTime;
	}

	public String getHidcontractTime() {
		return hidcontractTime;
	}

	public void setHidcontractTime(String hidcontractTime) {
		this.hidcontractTime = hidcontractTime;
	}

	public String getCmbcontracttype() {
		return cmbcontracttype;
	}

	public void setCmbcontracttype(String cmbcontracttype) {
		this.cmbcontracttype = cmbcontracttype;
	}

	public String getHidcmbcontracttype() {
		return hidcmbcontracttype;
	}

	public void setHidcmbcontracttype(String hidcmbcontracttype) {
		this.hidcmbcontracttype = hidcmbcontracttype;
	}

	public String getTxtcontractno() {
		return txtcontractno;
	}

	public void setTxtcontractno(String txtcontractno) {
		this.txtcontractno = txtcontractno;
	}

	public String getTxtcontracttrno() {
		return txtcontracttrno;
	}

	public void setTxtcontracttrno(String txtcontracttrno) {
		this.txtcontracttrno = txtcontracttrno;
	}

	public String getTxtcontractdetails() {
		return txtcontractdetails;
	}

	public void setTxtcontractdetails(String txtcontractdetails) {
		this.txtcontractdetails = txtcontractdetails;
	}

	public String getTxtsite() {
		return txtsite;
	}

	public void setTxtsite(String txtsite) {
		this.txtsite = txtsite;
	}

	public String getTxtsiteid() {
		return txtsiteid;
	}

	public void setTxtsiteid(String txtsiteid) {
		this.txtsiteid = txtsiteid;
	}

	public String getTxtdescription() {
		return txtdescription;
	}

	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	java.sql.Date callRegistersDate=null;
	java.sql.Date contractsDate=null;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		ClsCallRegisterBean bean = new ClsCallRegisterBean();
		
		
		
		System.out.println("inside saveaction===="+mode);
		
		if(mode.equalsIgnoreCase("A")){

			callRegistersDate = commonDAO.changeStringtoSqlDate(getCallRegisterDate());
			contractsDate = (getContractDate()==null || getContractDate().trim().equalsIgnoreCase(""))?null:commonDAO.changeStringtoSqlDate(getContractDate());
			
			ArrayList<String> complaintsarray= new ArrayList<String>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				complaintsarray.add(temp);
			}
			/*Complaints Grid Saving Ends*/
			
				int val=callRegisterDAO.insert(callRegistersDate,getFormdetailcode(),getTxtrefno(),getTxtclientdocno(),getTxtcontactperson(),getTxtcontactpersontele(),getTxtcontactpersonmob(),getTxtcontactpersonmail(),
						contractsDate,getContractTime(),getCmbcontracttype(),getTxtcontracttrno(),getTxtsiteid(),getTxtdescription(),complaintsarray,session,request,mode);
				if(val>0.0){
					
					setTxtcallregisterdocno(val);
					setTxtcallregistertrno(Integer.parseInt(request.getAttribute("tranno").toString()));
					setData();
					
					setMsg("Successfully Saved");
					return "success";
				}
				else{
					setData();
					setMsg("Not Saved");
					return "fail";
				}	
		}
		
		else if(mode.equalsIgnoreCase("E")){
			/*Updating Complaints Grid*/
			
			callRegistersDate = commonDAO.changeStringtoSqlDate(getCallRegisterDate());
			contractsDate = (getContractDate()==null || getContractDate().trim().equalsIgnoreCase(""))?null:commonDAO.changeStringtoSqlDate(getContractDate());
			
			ArrayList<String> complaintsarray= new ArrayList<String>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				complaintsarray.add(temp);
			}
			/*Updating Complaints Grid Ends*/
			
			boolean Status=callRegisterDAO.edit(getTxtcallregisterdocno(),getFormdetailcode(),callRegistersDate,getTxtrefno(),getTxtcallregistertrno(),getTxtclientdocno(),getTxtcontactperson(),getTxtcontactpersontele(),getTxtcontactpersonmob(),getTxtcontactpersonmail(),
					contractsDate,getContractTime(),getCmbcontracttype(),getTxtcontracttrno(),getTxtsiteid(),getTxtdescription(),complaintsarray,session,request,mode);
			if(Status){

				setTxtcallregisterdocno(getTxtcallregisterdocno());
				setTxtcallregistertrno(getTxtcallregistertrno());
				setData();
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setTxtcallregisterdocno(getTxtcallregisterdocno());
				setTxtcallregistertrno(getTxtcallregistertrno());
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("D")){
			
			boolean Status=callRegisterDAO.delete(getTxtcallregisterdocno(),getFormdetailcode(),getTxtcallregistertrno(),session,mode);
			if(Status){
				
				setTxtcallregisterdocno(getTxtcallregisterdocno());
				setTxtcallregistertrno(getTxtcallregistertrno());
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
			}
		
		else if(mode.equalsIgnoreCase("View")){
	
			//System.out.println("==getTxtcallregisterdocno===="+getTxtcallregisterdocno());
			
			String branch = session.getAttribute("BRANCHID").toString();
			
			callRegisterBean=callRegisterDAO.getViewDetails(session,getTxtcallregisterdocno(),branch);
			setHidcallRegisterDate(callRegisterBean.getCallRegisterDate());
			setTxtrefno(callRegisterBean.getTxtrefno());
			setTxtcallregistertrno(callRegisterBean.getTxtcallregistertrno());
			setTxtclientname(callRegisterBean.getTxtclientname());
			setTxtclientdocno(callRegisterBean.getTxtclientdocno());
			setTxtclientacno(callRegisterBean.getTxtclientacno());
			setTxtclientdetails(callRegisterBean.getTxtclientdetails());
			setTxtclienttele(callRegisterBean.getTxtclienttele());
			setTxtclientmobile(callRegisterBean.getTxtclientmobile());
			setTxtclientmail(callRegisterBean.getTxtclientmail());
			setTxtcontactperson(callRegisterBean.getTxtcontactperson());
			setTxtcontactpersontele(callRegisterBean.getTxtcontactpersontele());
			setTxtcontactpersonmob(callRegisterBean.getTxtcontactpersonmob());
			setTxtcontactpersonmail(callRegisterBean.getTxtcontactpersonmail());
			setHidcontractDate(callRegisterBean.getContractDate());
			setHidcontractTime(callRegisterBean.getContractTime());
			setHidcmbcontracttype(callRegisterBean.getHidcmbcontracttype());
			setTxtcontractno(callRegisterBean.getTxtcontractno());
			setTxtcontracttrno(callRegisterBean.getTxtcontracttrno());
			setTxtcontractdetails(callRegisterBean.getTxtcontractdetails());
			setTxtsite(callRegisterBean.getTxtsite());
			setTxtsiteid(callRegisterBean.getTxtsiteid());
			setTxtdescription(callRegisterBean.getTxtdescription());
			setFormdetailcode(callRegisterBean.getFormdetailcode());
			
			return "success";
		}
		return "fail";
    }
	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		int docno=Integer.parseInt(request.getParameter("docno"));
		int header=Integer.parseInt(request.getParameter("header"));
		int branch=Integer.parseInt(request.getParameter("brhid"));
		String trno=request.getParameter("trno");
		
		callRegisterBean=callRegisterDAO.getPrint(request,docno,branch,header,trno);
		
		System.out.println("+++++++++++++++++"+branch+header+docno);
		
		setUrl(commonDAO.getPrintPath("CREG"));
		
		setLblclname(callRegisterBean.getLblclname());
		setLbljobdat(callRegisterBean.getLbljobdat());
		setLblsite(callRegisterBean.getLblsite());
		setLbldocnno(callRegisterBean.getLbldocnno());
		setLbldtype(callRegisterBean.getLbldtype());
		setLblschno(callRegisterBean.getLblschno());
		setLblarea(callRegisterBean.getLblarea());
		setLblclientlpo(callRegisterBean.getLblclientlpo());
		setLbldescription(callRegisterBean.getLbldescription());
		
	
		return "print";
	}

		public JSONArray searchDetails(HttpSession session, String clientsname, String docNo, String date, String contractstype, String contractsno){
			  JSONArray cellarray = new JSONArray();
			  		  JSONObject cellobj = null;
			  try {
				cellarray= callRegisterDAO.cregMainSearch(session, clientsname, docNo, date, contractstype, contractsno);
		
			  } catch (SQLException e) {
				  e.printStackTrace();
				  }
			return cellarray;
		}
		
		public void setData() {
			
			setHidcallRegisterDate(callRegistersDate.toString());
			setTxtrefno(getTxtrefno());
			setTxtclientname(getTxtclientname());
			setTxtclientdocno(getTxtclientdocno());
			setTxtclientacno(getTxtclientacno());
			setTxtclientdetails(getTxtclientdetails());
			setTxtclienttele(getTxtclienttele());
			setTxtclientmobile(getTxtclientmobile());
			setTxtclientmail(getTxtclientmail());
			setTxtcontactperson(getTxtcontactperson());
			setTxtcontactpersontele(getTxtcontactpersontele());
			setTxtcontactpersonmob(getTxtcontactpersonmob());
			setTxtcontactpersonmail(getTxtcontactpersonmail());
			if(!(mode.equalsIgnoreCase("D"))) {
			setHidcontractDate(contractsDate==null?"":contractsDate.toString());
			}
			setHidcontractTime(getContractTime());
			setHidcmbcontracttype(getCmbcontracttype());
			setTxtcontractno(getTxtcontractno());
			setTxtcontracttrno(getTxtcontracttrno());
			setTxtcontractdetails(getTxtcontractdetails());
			setTxtsite(getTxtsite());
			setTxtsiteid(getTxtsiteid());
			setTxtdescription(getTxtdescription());
			setFormdetailcode(getFormdetailcode());
		}
}

