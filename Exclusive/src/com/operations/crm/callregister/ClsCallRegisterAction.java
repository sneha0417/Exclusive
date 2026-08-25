package com.operations.crm.callregister;

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
	private String txtclientname;
	private int txtclientdocno;
	private String txtclientacno;
	private String txtcontactperson;
	private String txtmobile;
	private String txtregno,txtvehicleno,txtvehicle,chkrepeated,chkhidrepeated,cmbtype,hidcmbtype,txtdescription,txtplace,datetime,hiddatetime;
	
	private String url;
	
	//Complaints Grid
	private int gridlength;
	

	public String getTxtregno() {
		return txtregno;
	}

	public void setTxtregno(String txtregno) {
		this.txtregno = txtregno;
	}

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


	public String getTxtcontactperson() {
		return txtcontactperson;
	}

	public void setTxtcontactperson(String txtcontactperson) {
		this.txtcontactperson = txtcontactperson;
	}

	public String getTxtvehicleno() {
		return txtvehicleno;
	}

	public void setTxtvehicleno(String txtvehicleno) {
		this.txtvehicleno = txtvehicleno;
	}

	public String getTxtvehicle() {
		return txtvehicle;
	}

	public void setTxtvehicle(String txtvehicle) {
		this.txtvehicle = txtvehicle;
	}

	public String getTxtmobile() {
		return txtmobile;
	}

	public void setTxtmobile(String txtmobile) {
		this.txtmobile = txtmobile;
	}

	public String getChkrepeated() {
		return chkrepeated;
	}

	public void setChkrepeated(String chkrepeated) {
		this.chkrepeated = chkrepeated;
	}

	public String getChkhidrepeated() {
		return chkhidrepeated;
	}

	public void setChkhidrepeated(String chkhidrepeated) {
		this.chkhidrepeated = chkhidrepeated;
	}

	public String getCmbtype() {
		return cmbtype;
	}

	public void setCmbtype(String cmbtype) {
		this.cmbtype = cmbtype;
	}

	public String getHidcmbtype() {
		return hidcmbtype;
	}

	public void setHidcmbtype(String hidcmbtype) {
		this.hidcmbtype = hidcmbtype;
	}

	public String getTxtdescription() {
		return txtdescription;
	}

	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}

	public String getTxtplace() {
		return txtplace;
	}

	public void setTxtplace(String txtplace) {
		this.txtplace = txtplace;
	}

	public String getDatetime() {
		return datetime;
	}

	public void setDatetime(String datetime) {
		this.datetime = datetime;
	}

	public String getHiddatetime() {
		return hiddatetime;
	}

	public void setHiddatetime(String hiddatetime) {
		this.hiddatetime = hiddatetime;
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
	java.sql.Date sqldateTime=null;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		ClsCallRegisterBean bean = new ClsCallRegisterBean();
		
		
		
		System.out.println("inside saveactionneww===="+getChkhidrepeated());
		callRegistersDate = (getCallRegisterDate()==null || getCallRegisterDate().trim().equalsIgnoreCase(""))?null:commonDAO.changeStringtoSqlDate(getCallRegisterDate());
//		sqldateTime = (getDatetime()==null || getDatetime().trim().equalsIgnoreCase(""))?null:commonDAO.changetstmptoSqlDate(getDatetime());
		if(mode.equalsIgnoreCase("A")){

			
			/*Complaints Grid Saving Ends*/
			
				int val=callRegisterDAO.insert(callRegistersDate,getFormdetailcode(),getTxtregno(),getTxtvehicleno(),getTxtclientdocno(),getTxtcontactperson(),getTxtmobile(),
						getChkhidrepeated(),getCmbtype(), sqldateTime,getDatetime(),getTxtdescription(),getTxtplace(),session,request,mode);

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
			
			boolean Status=callRegisterDAO.edit(getTxtcallregisterdocno(),getTxtcallregistertrno(), callRegistersDate,getFormdetailcode(),getTxtregno(),getTxtvehicleno(),getTxtclientdocno(),getTxtcontactperson(),getTxtmobile(),
					getChkhidrepeated(),getCmbtype(), sqldateTime,getDatetime(),getTxtdescription(),getTxtplace(),session,request,mode);
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
	
			
			String branch = session.getAttribute("BRANCHID").toString();
			
			callRegisterBean=callRegisterDAO.getViewDetails(session,getTxtcallregisterdocno(),branch);
			
						
			setTxtcallregisterdocno(callRegisterBean.getTxtcallregisterdocno());
			setTxtcallregistertrno(callRegisterBean.getTxtcallregistertrno());
			setCallRegisterDate(callRegisterBean.getCallRegisterDate());
			setTxtregno(callRegisterBean.getTxtregno());
			setTxtvehicle(callRegisterBean.getTxtvehicle());
			setTxtvehicleno(callRegisterBean.getTxtvehicleno());
			setTxtclientname(callRegisterBean.getTxtclientname());
			setTxtclientdocno(callRegisterBean.getTxtclientdocno());
			setTxtclientacno(callRegisterBean.getTxtclientacno());
			setTxtcontactperson(callRegisterBean.getTxtcontactperson());
			setChkhidrepeated(callRegisterBean.getChkhidrepeated());
			setTxtmobile(callRegisterBean.getTxtmobile());
			//setDatetime(callRegisterBean.getDatetime());
			setHidcmbtype(callRegisterBean.getHidcmbtype());
			setTxtplace(callRegisterBean.getTxtplace());
			setHiddatetime(callRegisterBean.getHiddatetime());
			setTxtdescription(callRegisterBean.getTxtdescription());
			
			System.out.println("==getHiddatetime()===="+getHiddatetime());
			
			return "success";
		}
		return "fail";
    }
	
	/*public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		int docno=Integer.parseInt(request.getParameter("docno"));
		int header=Integer.parseInt(request.getParameter("header"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		callRegisterBean=callRegisterDAO.getPrint(request,docno,branch,header);
		
		setUrl(commonDAO.getPrintPath("CREG"));
	
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
		}*/
		
		public void setData() {
			
			setHidcallRegisterDate(callRegistersDate.toString());
			setTxtregno(getTxtregno());
			setTxtvehicle(getTxtvehicle());
			setTxtvehicleno(getTxtvehicleno());
			setTxtclientname(getTxtclientname());
			setTxtclientdocno(getTxtclientdocno());
			setTxtclientacno(getTxtclientacno());
			setTxtcontactperson(getTxtcontactperson());
			setTxtmobile(getTxtmobile());
			setChkhidrepeated(getChkhidrepeated());
			System.out.println("setdata vals====mob--"+getTxtmobile()+"---cmb-"+getCmbtype()+"--hidcmnb--"+getHidcmbtype());
			setCmbtype(getCmbtype());
			setHidcmbtype(getCmbtype());
			setTxtplace(getTxtplace());
//			setDatetime(getDatetime());
			setHiddatetime(getDatetime());
			
			
			if(!(mode.equalsIgnoreCase("D"))) {
//				setDatetime((datetime==null?"":datetime.toString()));
				setHiddatetime((hiddatetime==null?"":hiddatetime.toString()));
			}
			setTxtdescription(getTxtdescription());
			setTxtplace(getTxtplace());
			setFormdetailcode(getFormdetailcode());
			setMode("view");
		}
}

