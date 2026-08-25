package com.operations.clientrelations.client;


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
public class ClsClientAction extends ActionSupport{
    
	ClsCommon commonDAO= new ClsCommon();
	ClsClientDAO clientDAO= new ClsClientDAO();
	ClsClientBean clientbean;

	private int txtclientdocno;
	private String formdetailcode;
	private String chkstatus;
	private String mode;
	private String deleted;
	private String msg;
	private String jqxClientDate;
	private String hidjqxClientDate;
	private int txtcode;
	private String txtclient_name;
	private String cmbsalutation;
	private String hidcmbsalutation;
	private String cmbcurrency;
	private String hidcmbcurrency;
	private String cmbgroup;
	private String hidcmbgroup;
	private String cmbcategory;
	private String hidcmbcategory;
	private String cmbsalesman;
	private String hidcmbsalesman;
	private int chckadvance;
	private int hidchckadvance;
	private String cmbinvoicing_method;
	private String hidcmbinvoicing_method;
	private int cmbdel_charges;
	private int hidcmbdel_charges;
	
	private String cmbgroup1;
	private String hidcmbgroup1;
	private String txtaccount;
	private int txtcredit_period_min;
	private int txtcredit_period_max;
	private int txtcredit_limit;
	
	private int chckdefault;
	private int hidchckdefault;
	private String txtsalik;
	private String txttraffic;
	
	private String txtref_no;
	private String txtref_type;
	
	private String txtpersonal_add1;
	private String txtoffice_add1;
	private String txtresidence_add1;
	private String txthome_add1;
	private String txtpersonal_add2;
	private String txtoffice_add2;
	private String txtresidence_add2;
	private String txthome_add2;
	private String txtpersonal_tel1;
	private String txtoffice_tel1;
	private String txtresidence_tel1;
	private String txthome_tel1;
	private String personal_tel2;
	private String office_tel2;
	private String residence_tel2;
	private String home_tel2;
	private String txtpersonal_fax;
	private String txtoffice_fax;
	private String txtresidence_fax;
	private String txthome_fax;
	private String txtpersonal_email;
	private String txtoffice_email;
	private String txtresidence_email;
	private String txthome_email;
	private String txtpersonal_contact;
	private String txtoffice_contact;
	private String txtresidence_contact;
	private String txthome_contact;
	private String txtpersonal_extn_no;
	private String txtoffice_extn_no;
	private String txtresidence_extn_no;
	private String txthome_extn_no;
	
	private String txtname;
	private String txtaddress;
	private String txttelephone;
	private int txtid;
	private String cmbnationality;
	private String hidcmbnationality;
	private String txtsecurity;
	private String txtsecurity1;
	
	private String txtcontractno;
	private String jqxContractDate;
	private String hidjqxContractDate;
	private String txtcontractremarks;
	private String idpdetailsallowed;
	
	//Driver Grid
	private int gridlength;
	
	//Reference Grid
	private int referencelength;
	
	//Reference Grid
	private int attachlength;
	
	//Credit Card Details Grid
	private int creditcardlength;

	public int getTxtclientdocno() {
		return txtclientdocno;
	}

	public void setTxtclientdocno(int txtclientdocno) {
		this.txtclientdocno = txtclientdocno;
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

	public String getJqxClientDate() {
		return jqxClientDate;
	}

	public void setJqxClientDate(String jqxClientDate) {
		this.jqxClientDate = jqxClientDate;
	}

	public String getHidjqxClientDate() {
		return hidjqxClientDate;
	}

	public void setHidjqxClientDate(String hidjqxClientDate) {
		this.hidjqxClientDate = hidjqxClientDate;
	}

	public int getTxtcode() {
		return txtcode;
	}

	public void setTxtcode(int txtcode) {
		this.txtcode = txtcode;
	}

	public String getTxtclient_name() {
		return txtclient_name;
	}

	public void setTxtclient_name(String txtclient_name) {
		this.txtclient_name = txtclient_name;
	}

	public String getCmbsalutation() {
		return cmbsalutation;
	}

	public void setCmbsalutation(String cmbsalutation) {
		this.cmbsalutation = cmbsalutation;
	}

	public String getHidcmbsalutation() {
		return hidcmbsalutation;
	}

	public void setHidcmbsalutation(String hidcmbsalutation) {
		this.hidcmbsalutation = hidcmbsalutation;
	}

	public String getCmbcurrency() {
		return cmbcurrency;
	}

	public void setCmbcurrency(String cmbcurrency) {
		this.cmbcurrency = cmbcurrency;
	}

	public String getHidcmbcurrency() {
		return hidcmbcurrency;
	}

	public void setHidcmbcurrency(String hidcmbcurrency) {
		this.hidcmbcurrency = hidcmbcurrency;
	}

	public String getCmbgroup() {
		return cmbgroup;
	}

	public void setCmbgroup(String cmbgroup) {
		this.cmbgroup = cmbgroup;
	}

	public String getHidcmbgroup() {
		return hidcmbgroup;
	}

	public void setHidcmbgroup(String hidcmbgroup) {
		this.hidcmbgroup = hidcmbgroup;
	}

	public String getCmbcategory() {
		return cmbcategory;
	}

	public void setCmbcategory(String cmbcategory) {
		this.cmbcategory = cmbcategory;
	}

	public String getHidcmbcategory() {
		return hidcmbcategory;
	}

	public void setHidcmbcategory(String hidcmbcategory) {
		this.hidcmbcategory = hidcmbcategory;
	}

	public String getCmbsalesman() {
		return cmbsalesman;
	}

	public void setCmbsalesman(String cmbsalesman) {
		this.cmbsalesman = cmbsalesman;
	}

	public String getHidcmbsalesman() {
		return hidcmbsalesman;
	}

	public void setHidcmbsalesman(String hidcmbsalesman) {
		this.hidcmbsalesman = hidcmbsalesman;
	}

	public int getChckadvance() {
		return chckadvance;
	}

	public void setChckadvance(int chckadvance) {
		this.chckadvance = chckadvance;
	}

	public int getHidchckadvance() {
		return hidchckadvance;
	}

	public void setHidchckadvance(int hidchckadvance) {
		this.hidchckadvance = hidchckadvance;
	}
	
	public String getCmbinvoicing_method() {
		return cmbinvoicing_method;
	}

	public void setCmbinvoicing_method(String cmbinvoicing_method) {
		this.cmbinvoicing_method = cmbinvoicing_method;
	}

	public String getHidcmbinvoicing_method() {
		return hidcmbinvoicing_method;
	}

	public void setHidcmbinvoicing_method(String hidcmbinvoicing_method) {
		this.hidcmbinvoicing_method = hidcmbinvoicing_method;
	}

	public int getCmbdel_charges() {
		return cmbdel_charges;
	}

	public void setCmbdel_charges(int cmbdel_charges) {
		this.cmbdel_charges = cmbdel_charges;
	}

	public int getHidcmbdel_charges() {
		return hidcmbdel_charges;
	}

	public void setHidcmbdel_charges(int hidcmbdel_charges) {
		this.hidcmbdel_charges = hidcmbdel_charges;
	}

	public String getCmbgroup1() {
		return cmbgroup1;
	}

	public void setCmbgroup1(String cmbgroup1) {
		this.cmbgroup1 = cmbgroup1;
	}

	public String getHidcmbgroup1() {
		return hidcmbgroup1;
	}

	public void setHidcmbgroup1(String hidcmbgroup1) {
		this.hidcmbgroup1 = hidcmbgroup1;
	}

	public String getTxtaccount() {
		return txtaccount;
	}

	public void setTxtaccount(String txtaccount) {
		this.txtaccount = txtaccount;
	}

	public int getTxtcredit_period_min() {
		return txtcredit_period_min;
	}

	public void setTxtcredit_period_min(int txtcredit_period_min) {
		this.txtcredit_period_min = txtcredit_period_min;
	}

	public int getTxtcredit_period_max() {
		return txtcredit_period_max;
	}

	public void setTxtcredit_period_max(int txtcredit_period_max) {
		this.txtcredit_period_max = txtcredit_period_max;
	}

	public int getTxtcredit_limit() {
		return txtcredit_limit;
	}

	public void setTxtcredit_limit(int txtcredit_limit) {
		this.txtcredit_limit = txtcredit_limit;
	}

	public int getChckdefault() {
		return chckdefault;
	}

	public void setChckdefault(int chckdefault) {
		this.chckdefault = chckdefault;
	}

	public int getHidchckdefault() {
		return hidchckdefault;
	}

	public void setHidchckdefault(int hidchckdefault) {
		this.hidchckdefault = hidchckdefault;
	}

	public String getTxtsalik() {
		return txtsalik;
	}

	public void setTxtsalik(String txtsalik) {
		this.txtsalik = txtsalik;
	}

	public String getTxttraffic() {
		return txttraffic;
	}

	public void setTxttraffic(String txttraffic) {
		this.txttraffic = txttraffic;
	}

	public String getTxtref_no() {
		return txtref_no;
	}

	public void setTxtref_no(String txtref_no) {
		this.txtref_no = txtref_no;
	}

	public String getTxtref_type() {
		return txtref_type;
	}

	public void setTxtref_type(String txtref_type) {
		this.txtref_type = txtref_type;
	}

	public String getTxtpersonal_add1() {
		return txtpersonal_add1;
	}

	public void setTxtpersonal_add1(String txtpersonal_add1) {
		this.txtpersonal_add1 = txtpersonal_add1;
	}

	public String getTxtoffice_add1() {
		return txtoffice_add1;
	}

	public void setTxtoffice_add1(String txtoffice_add1) {
		this.txtoffice_add1 = txtoffice_add1;
	}

	public String getTxtresidence_add1() {
		return txtresidence_add1;
	}

	public void setTxtresidence_add1(String txtresidence_add1) {
		this.txtresidence_add1 = txtresidence_add1;
	}

	public String getTxthome_add1() {
		return txthome_add1;
	}

	public void setTxthome_add1(String txthome_add1) {
		this.txthome_add1 = txthome_add1;
	}

	public String getTxtpersonal_add2() {
		return txtpersonal_add2;
	}

	public void setTxtpersonal_add2(String txtpersonal_add2) {
		this.txtpersonal_add2 = txtpersonal_add2;
	}

	public String getTxtoffice_add2() {
		return txtoffice_add2;
	}

	public void setTxtoffice_add2(String txtoffice_add2) {
		this.txtoffice_add2 = txtoffice_add2;
	}

	public String getTxtresidence_add2() {
		return txtresidence_add2;
	}

	public void setTxtresidence_add2(String txtresidence_add2) {
		this.txtresidence_add2 = txtresidence_add2;
	}

	public String getTxthome_add2() {
		return txthome_add2;
	}

	public void setTxthome_add2(String txthome_add2) {
		this.txthome_add2 = txthome_add2;
	}

	public String getTxtpersonal_tel1() {
		return txtpersonal_tel1;
	}

	public void setTxtpersonal_tel1(String txtpersonal_tel1) {
		this.txtpersonal_tel1 = txtpersonal_tel1;
	}

	public String getTxtoffice_tel1() {
		return txtoffice_tel1;
	}

	public void setTxtoffice_tel1(String txtoffice_tel1) {
		this.txtoffice_tel1 = txtoffice_tel1;
	}

	public String getTxtresidence_tel1() {
		return txtresidence_tel1;
	}

	public void setTxtresidence_tel1(String txtresidence_tel1) {
		this.txtresidence_tel1 = txtresidence_tel1;
	}

	public String getTxthome_tel1() {
		return txthome_tel1;
	}

	public void setTxthome_tel1(String txthome_tel1) {
		this.txthome_tel1 = txthome_tel1;
	}

	public String getPersonal_tel2() {
		return personal_tel2;
	}

	public void setPersonal_tel2(String personal_tel2) {
		this.personal_tel2 = personal_tel2;
	}

	public String getOffice_tel2() {
		return office_tel2;
	}

	public void setOffice_tel2(String office_tel2) {
		this.office_tel2 = office_tel2;
	}

	public String getResidence_tel2() {
		return residence_tel2;
	}

	public void setResidence_tel2(String residence_tel2) {
		this.residence_tel2 = residence_tel2;
	}

	public String getHome_tel2() {
		return home_tel2;
	}

	public void setHome_tel2(String home_tel2) {
		this.home_tel2 = home_tel2;
	}

	public String getTxtpersonal_fax() {
		return txtpersonal_fax;
	}

	public void setTxtpersonal_fax(String txtpersonal_fax) {
		this.txtpersonal_fax = txtpersonal_fax;
	}

	public String getTxtoffice_fax() {
		return txtoffice_fax;
	}

	public void setTxtoffice_fax(String txtoffice_fax) {
		this.txtoffice_fax = txtoffice_fax;
	}

	public String getTxtresidence_fax() {
		return txtresidence_fax;
	}

	public void setTxtresidence_fax(String txtresidence_fax) {
		this.txtresidence_fax = txtresidence_fax;
	}

	public String getTxthome_fax() {
		return txthome_fax;
	}

	public void setTxthome_fax(String txthome_fax) {
		this.txthome_fax = txthome_fax;
	}

	public String getTxtpersonal_email() {
		return txtpersonal_email;
	}

	public void setTxtpersonal_email(String txtpersonal_email) {
		this.txtpersonal_email = txtpersonal_email;
	}

	public String getTxtoffice_email() {
		return txtoffice_email;
	}

	public void setTxtoffice_email(String txtoffice_email) {
		this.txtoffice_email = txtoffice_email;
	}

	public String getTxtresidence_email() {
		return txtresidence_email;
	}

	public void setTxtresidence_email(String txtresidence_email) {
		this.txtresidence_email = txtresidence_email;
	}

	public String getTxthome_email() {
		return txthome_email;
	}

	public void setTxthome_email(String txthome_email) {
		this.txthome_email = txthome_email;
	}

	public String getTxtpersonal_contact() {
		return txtpersonal_contact;
	}

	public void setTxtpersonal_contact(String txtpersonal_contact) {
		this.txtpersonal_contact = txtpersonal_contact;
	}

	public String getTxtoffice_contact() {
		return txtoffice_contact;
	}

	public void setTxtoffice_contact(String txtoffice_contact) {
		this.txtoffice_contact = txtoffice_contact;
	}

	public String getTxtresidence_contact() {
		return txtresidence_contact;
	}

	public void setTxtresidence_contact(String txtresidence_contact) {
		this.txtresidence_contact = txtresidence_contact;
	}

	public String getTxthome_contact() {
		return txthome_contact;
	}

	public void setTxthome_contact(String txthome_contact) {
		this.txthome_contact = txthome_contact;
	}

	public String getTxtpersonal_extn_no() {
		return txtpersonal_extn_no;
	}

	public void setTxtpersonal_extn_no(String txtpersonal_extn_no) {
		this.txtpersonal_extn_no = txtpersonal_extn_no;
	}

	public String getTxtoffice_extn_no() {
		return txtoffice_extn_no;
	}

	public void setTxtoffice_extn_no(String txtoffice_extn_no) {
		this.txtoffice_extn_no = txtoffice_extn_no;
	}

	public String getTxtresidence_extn_no() {
		return txtresidence_extn_no;
	}

	public void setTxtresidence_extn_no(String txtresidence_extn_no) {
		this.txtresidence_extn_no = txtresidence_extn_no;
	}

	public String getTxthome_extn_no() {
		return txthome_extn_no;
	}

	public void setTxthome_extn_no(String txthome_extn_no) {
		this.txthome_extn_no = txthome_extn_no;
	}

	public String getTxtname() {
		return txtname;
	}

	public void setTxtname(String txtname) {
		this.txtname = txtname;
	}

	public String getTxtaddress() {
		return txtaddress;
	}

	public void setTxtaddress(String txtaddress) {
		this.txtaddress = txtaddress;
	}

	public String getTxttelephone() {
		return txttelephone;
	}

	public void setTxttelephone(String txttelephone) {
		this.txttelephone = txttelephone;
	}

	public int getTxtid() {
		return txtid;
	}

	public void setTxtid(int txtid) {
		this.txtid = txtid;
	}

	public String getCmbnationality() {
		return cmbnationality;
	}

	public void setCmbnationality(String cmbnationality) {
		this.cmbnationality = cmbnationality;
	}

	public String getHidcmbnationality() {
		return hidcmbnationality;
	}

	public void setHidcmbnationality(String hidcmbnationality) {
		this.hidcmbnationality = hidcmbnationality;
	}

	public String getTxtsecurity() {
		return txtsecurity;
	}

	public void setTxtsecurity(String txtsecurity) {
		this.txtsecurity = txtsecurity;
	}

	public String getTxtsecurity1() {
		return txtsecurity1;
	}

	public void setTxtsecurity1(String txtsecurity1) {
		this.txtsecurity1 = txtsecurity1;
	}
	
	public String getTxtcontractno() {
		return txtcontractno;
	}

	public void setTxtcontractno(String txtcontractno) {
		this.txtcontractno = txtcontractno;
	}
	
	public String getJqxContractDate() {
		return jqxContractDate;
	}

	public void setJqxContractDate(String jqxContractDate) {
		this.jqxContractDate = jqxContractDate;
	}

	public String getHidjqxContractDate() {
		return hidjqxContractDate;
	}

	public void setHidjqxContractDate(String hidjqxContractDate) {
		this.hidjqxContractDate = hidjqxContractDate;
	}

	public String getTxtcontractremarks() {
		return txtcontractremarks;
	}

	public void setTxtcontractremarks(String txtcontractremarks) {
		this.txtcontractremarks = txtcontractremarks;
	}

	public String getIdpdetailsallowed() {
		return idpdetailsallowed;
	}

	public void setIdpdetailsallowed(String idpdetailsallowed) {
		this.idpdetailsallowed = idpdetailsallowed;
	}
	
	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	public int getReferencelength() {
		return referencelength;
	}

	public void setReferencelength(int referencelength) {
		this.referencelength = referencelength;
	}

	public int getAttachlength() {
		return attachlength;
	}

	public void setAttachlength(int attachlength) {
		this.attachlength = attachlength;
	}

	public int getCreditcardlength() {
		return creditcardlength;
	}

	public void setCreditcardlength(int creditcardlength) {
		this.creditcardlength = creditcardlength;
	}

	public ArrayList<String> getDriverarray() {
		return driverarray;
	}

	public void setDriverarray(ArrayList<String> driverarray) {
		this.driverarray = driverarray;
	}

	java.sql.Date clientDate=null;
	java.sql.Date contractDate=null;
	ArrayList<String> driverarray= new ArrayList<>();
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		String mode=getMode();
		
		
		ClsClientBean bean = new ClsClientBean();

		if(mode.equalsIgnoreCase("A")){
			clientDate = commonDAO.changeStringtoSqlDate(getJqxClientDate());	
			contractDate = (getJqxContractDate()==null || getJqxContractDate().trim().equalsIgnoreCase(""))?null:commonDAO.changeStringtoSqlDate(getJqxContractDate());
			
			/*Driver Grid*/
			for(int i=0;i<getGridlength();i++){
				ClsClientBean clientbean=new ClsClientBean();
				String temp=requestParams.get("test"+i)[0];
				driverarray.add(temp);
			}
			
			/*Reference Grid*/
			ArrayList<String> referencearray= new ArrayList<>();
			for(int i=0;i<getReferencelength();i++){
				ClsClientBean clientbean=new ClsClientBean();
				String tempreference=requestParams.get("txtreference"+i)[0];
				referencearray.add(tempreference);
			}
			
			/*Document Attach Grid*/
			ArrayList<String> attacharray= new ArrayList<>();
			for(int i=0;i<getAttachlength();i++){
				ClsClientBean clientbean=new ClsClientBean();
				String tempattach=requestParams.get("txtattach"+i)[0];
				attacharray.add(tempattach);
			}
			
			/*Credit Card Details Grid*/
			ArrayList<String> creditcardarray= new ArrayList<>();
			for(int i=0;i<getCreditcardlength();i++){
				ClsClientBean clientbean=new ClsClientBean();
				String tempcard=requestParams.get("txtcard"+i)[0];
				creditcardarray.add(tempcard);
			}
			
			int val=clientDAO.insert(clientDate,getFormdetailcode(),getTxtclient_name(),getCmbsalutation(),getCmbcurrency(),getCmbgroup(),getCmbcategory(),
					getCmbsalesman(),getHidchckadvance(),getCmbinvoicing_method(),getCmbdel_charges(),getCmbgroup1(),getTxtaccount(),getTxtcredit_period_min(),
					getTxtcredit_period_max(),getTxtcredit_limit(),getHidchckdefault(),getTxtsalik(),getTxttraffic(),getTxtref_no(),getTxtref_type(),
					getTxtpersonal_add1(),getTxtpersonal_add2(),getTxtpersonal_tel1(),getPersonal_tel2(),getTxtpersonal_fax(),getTxtpersonal_email(),
					getTxtpersonal_contact(),getTxtpersonal_extn_no(),getTxtoffice_add1(),getTxtoffice_add2(),getTxtoffice_tel1(),getOffice_tel2(),
					getTxtoffice_fax(),getTxtoffice_email(),getTxtoffice_contact(),getTxtoffice_extn_no(),getTxtresidence_add1(),getTxtresidence_add2(),
					getTxtresidence_tel1(),getResidence_tel2(),getTxtresidence_fax(),getTxtresidence_email(),getTxtresidence_contact(),getTxtresidence_extn_no(),
					getTxthome_add1(),getTxthome_add2(),getTxthome_tel1(),getHome_tel2(),getTxthome_fax(), getTxthome_email(),getTxthome_contact(),getTxthome_extn_no(),
					getTxtname(),getTxtaddress(),getTxttelephone(),getTxtid(),getCmbnationality(),getTxtsecurity(),getTxtsecurity1(),getTxtcontractno(),contractDate,
					getTxtcontractremarks(),driverarray,referencearray,attacharray,creditcardarray,session,request);
			if(val>0.0){
				
				setTxtclientdocno(val);
				setTxtcode(val);
				setTxtaccount(request.getAttribute("acno").toString());
				setHidjqxClientDate(clientDate.toString());
				setHidjqxContractDate(contractDate==null?null:contractDate.toString());
				setData();
				
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setData();
				setHidjqxClientDate(clientDate.toString());
				setHidjqxContractDate(contractDate.toString());
				setMsg("Not Saved");
				return "fail";
			}	
		}
		else if(mode.equalsIgnoreCase("E")){
			clientDate = commonDAO.changeStringtoSqlDate(getJqxClientDate());
			contractDate = (getJqxContractDate()==null || getJqxContractDate().trim().equalsIgnoreCase(""))?null:commonDAO.changeStringtoSqlDate(getJqxContractDate());
			
			/*Driver Grid*/
			ArrayList<String> driverarray= new ArrayList<>();
			for(int i=0;i<getGridlength();i++){
				ClsClientBean clientbean=new ClsClientBean();
				String temp=requestParams.get("test"+i)[0];
				driverarray.add(temp);
			}
			
			/*Reference Grid*/
			ArrayList<String> referencearray= new ArrayList<>();
			for(int i=0;i<getReferencelength();i++){
				ClsClientBean clientbean=new ClsClientBean();
				String tempreference=requestParams.get("txtreference"+i)[0];
				referencearray.add(tempreference);
			}
			
			/*Document Attach Grid*/
			ArrayList<String> attacharray= new ArrayList<>();
			for(int i=0;i<getAttachlength();i++){
				ClsClientBean clientbean=new ClsClientBean();
				String tempattach=requestParams.get("txtattach"+i)[0];
				attacharray.add(tempattach);
			}
			
			/*Credit Card Details Grid*/
			ArrayList<String> creditcardarray= new ArrayList<>();
			for(int i=0;i<getCreditcardlength();i++){
				ClsClientBean clientbean=new ClsClientBean();
				String tempcard=requestParams.get("txtcard"+i)[0];
				creditcardarray.add(tempcard);
			}
			
			int Status=clientDAO.edit(getTxtclientdocno(),getFormdetailcode(),clientDate,getTxtclient_name(),getCmbsalutation(),getCmbcurrency(),getCmbgroup(),getCmbcategory(),
					getCmbsalesman(),getHidchckadvance(),getCmbinvoicing_method(),getCmbdel_charges(),getCmbgroup1(),getTxtaccount(),getTxtcredit_period_min(),
					getTxtcredit_period_max(),getTxtcredit_limit(),getHidchckdefault(),getTxtsalik(),getTxttraffic(),getTxtref_no(),getTxtref_type(),
					getTxtpersonal_add1(),getTxtpersonal_add2(),getTxtpersonal_tel1(),getPersonal_tel2(),getTxtpersonal_fax(),getTxtpersonal_email(),
					getTxtpersonal_contact(),getTxtpersonal_extn_no(),getTxtoffice_add1(),
					getTxtoffice_add2(),getTxtoffice_tel1(),getOffice_tel2(),getTxtoffice_fax(),getTxtoffice_email(),
					getTxtoffice_contact(),getTxtoffice_extn_no(),getTxtresidence_add1(),getTxtresidence_add2(),getTxtresidence_tel1(),
					getResidence_tel2(),getTxtresidence_fax(),getTxtresidence_email(),getTxtresidence_contact(),getTxtresidence_extn_no(),getTxthome_add1(),
					getTxthome_add2(),getTxthome_tel1(),getHome_tel2(),getTxthome_fax(), getTxthome_email(),getTxthome_contact(),getTxthome_extn_no(),
					getTxtname(),getTxtaddress(),getTxttelephone(),getTxtid(),getCmbnationality(),getTxtsecurity(),getTxtsecurity1(),getTxtcontractno(),contractDate,
					getTxtcontractremarks(),driverarray,referencearray,attacharray,creditcardarray,session);
			if(Status>0){
						
						setTxtclientdocno(getTxtclientdocno());
						setTxtcode(getTxtcode());
						setTxtaccount(getTxtaccount());
						setHidjqxClientDate(clientDate.toString());
						setHidjqxContractDate(contractDate==null?null:contractDate.toString());
						setData();
				
						setMsg("Updated Successfully");
				        return "success";
			}
			else{
				setData();
				setHidjqxClientDate(clientDate.toString());
				setHidjqxContractDate(contractDate==null?null:contractDate.toString());
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
		int Status=clientDAO.delete(getTxtclientdocno(),getTxtaccount(),getFormdetailcode(),session);
		if(Status>0){
					setTxtclientdocno(getTxtclientdocno());
					setTxtcode(getTxtcode());
					setTxtaccount(getTxtaccount());
					setData();
			
					setDeleted("DELETED");
					setMsg("Successfully Deleted");
					return "success";
		}
		else if(Status==-1){
			setChkstatus("1");
			setData();
			setMsg("Transaction Already Exists.");
			return "fail";
		}
		else{
			setData();
			setMsg("Not Deleted");
			return "fail";
		}
		}
		

		else if(mode.equalsIgnoreCase("View")){
			
			clientbean=clientDAO.getViewDetails(getTxtclientdocno());
			
			setJqxClientDate(clientbean.getJqxClientDate());
			setTxtcode(clientbean.getTxtcode());
			setTxtclient_name(clientbean.getTxtclient_name());
			setHidcmbsalutation(clientbean.getHidcmbsalutation());
			setHidcmbcurrency(clientbean.getHidcmbcurrency());
			setHidcmbgroup(clientbean.getHidcmbgroup());
			setHidcmbcategory(clientbean.getHidcmbcategory());
			setHidcmbsalesman(clientbean.getHidcmbsalesman());
			setHidchckadvance(clientbean.getChckadvance());
			setHidcmbinvoicing_method(clientbean.getHidcmbinvoicing_method());
			setHidcmbdel_charges(clientbean.getHidcmbdel_charges());
			setHidcmbgroup1(clientbean.getHidcmbgroup1());
			setTxtaccount(clientbean.getTxtaccount());
			setTxtcredit_period_min(clientbean.getTxtcredit_period_min());
			setTxtcredit_period_max(clientbean.getTxtcredit_period_max());
			setTxtcredit_limit(clientbean.getTxtcredit_limit());
			setHidchckdefault(clientbean.getChckdefault());
			setTxtsalik(clientbean.getTxtsalik());
			setTxttraffic(clientbean.getTxttraffic());
			setTxtpersonal_add1(clientbean.getTxtpersonal_add1());
			setTxtpersonal_add2(clientbean.getTxtpersonal_add2());
			setTxtpersonal_tel1(clientbean.getTxtpersonal_tel1());
			setPersonal_tel2(clientbean.getPersonal_tel2());
			setTxtpersonal_fax(clientbean.getTxtpersonal_fax());
			setTxtpersonal_email(clientbean.getTxtpersonal_email());
			setTxtpersonal_contact(clientbean.getTxtpersonal_contact());
			setTxtpersonal_extn_no(clientbean.getTxtpersonal_extn_no());
			setTxtoffice_add1(clientbean.getTxtoffice_add1());
			setTxtoffice_add2(clientbean.getTxtoffice_add2());
			setTxtoffice_tel1(clientbean.getTxtoffice_tel1());
			setOffice_tel2(clientbean.getOffice_tel2());
			setTxtoffice_fax(clientbean.getTxtoffice_fax());
			setTxtoffice_email(clientbean.getTxtoffice_email());
			setTxtoffice_contact(clientbean.getTxtoffice_contact());
			setTxtoffice_extn_no(clientbean.getTxtoffice_extn_no());
			setTxtresidence_add1(clientbean.getTxtresidence_add1());
			setTxtresidence_add2(clientbean.getTxtresidence_add2());
			setTxtresidence_tel1(clientbean.getTxtresidence_tel1());
			setResidence_tel2(clientbean.getResidence_tel2());
			setTxtresidence_fax(clientbean.getTxtresidence_fax());
			setTxtresidence_email(clientbean.getTxtresidence_email());
			setTxtresidence_contact(clientbean.getTxtresidence_contact());
			setTxtresidence_extn_no(clientbean.getTxtresidence_extn_no());
			setTxthome_add1(clientbean.getTxthome_add1());
			setTxthome_add2(clientbean.getTxthome_add2());
			setTxthome_tel1(clientbean.getTxthome_tel1());
			setHome_tel2(clientbean.getHome_tel2());
			setTxthome_fax(clientbean.getTxthome_fax());
			setTxthome_email(clientbean.getTxthome_email());
			setTxthome_contact(clientbean.getTxthome_contact());
			setTxthome_extn_no(clientbean.getTxthome_extn_no());
			setTxtname(clientbean.getTxtname());
			setTxtaddress(clientbean.getTxtaddress());
			setTxttelephone(clientbean.getTxttelephone());
			setTxtid(clientbean.getTxtid());
			setHidcmbnationality(clientbean.getHidcmbnationality());
			setTxtsecurity(clientbean.getTxtsecurity());
			setTxtsecurity1(clientbean.getTxtsecurity1());
			setTxtcontractno(clientbean.getTxtcontractno());
			setJqxContractDate(clientbean.getJqxContractDate());
			setTxtcontractremarks(clientbean.getTxtcontractremarks());
			setIdpdetailsallowed(clientbean.getIdpdetailsallowed());
			setFormdetailcode(clientbean.getFormdetailcode());
			
			return "success";
		}
		
		return "fail";
}

		public JSONArray searchAllDetails(HttpSession session,String clname,String mob,String lcno,String clientid,String dob,String nation){
			  JSONArray cellarray = new JSONArray();
			  		  JSONObject cellobj = null;
			  try {
				  cellarray= clientDAO.clientSearch(session,clname, mob,lcno,clientid,nation, dob);
		
			  } catch (SQLException e) {
				  e.printStackTrace();
				  }
			return cellarray;
		}
		
		public void setData() {
			String drivermobileno = driverarray.size()>0?(driverarray.get(0).split("::")[3]!=null?driverarray.get(0).split("::")[3].trim().toString():""):"";

			if(drivermobileno.trim().equalsIgnoreCase("undefined")){
				drivermobileno="";
			}
			
			setTxtclient_name(getTxtclient_name());
			setHidcmbsalutation(getCmbsalutation());
			setHidcmbcurrency(getCmbcurrency());
			setHidcmbgroup(getCmbgroup());
			setHidcmbcategory(getCmbcategory());
			setHidcmbsalesman(getCmbsalesman());
			setHidchckadvance(getHidchckadvance());
			setHidcmbinvoicing_method(getCmbinvoicing_method());
			setHidcmbdel_charges(getCmbdel_charges());
			
			setHidcmbgroup1(getCmbgroup1());
			setTxtcredit_period_min(getTxtcredit_period_min());
			setTxtcredit_period_max(getTxtcredit_period_max());
			setTxtcredit_limit(getTxtcredit_limit());
			
			setHidchckdefault(getHidchckdefault());
			setTxtsalik(getTxtsalik());
			setTxttraffic(getTxttraffic());
			
			setTxtref_no(getTxtref_no());
			setTxtref_type(getTxtref_type());
			setTxtpersonal_add1(getTxtpersonal_add1());
			setTxtpersonal_add2(getTxtpersonal_add2());
			setTxtpersonal_tel1(getTxtpersonal_tel1());

			if(getPersonal_tel2().trim().equalsIgnoreCase("")){
				setPersonal_tel2(drivermobileno);
			}
			else{
				setPersonal_tel2(getPersonal_tel2());
			}
			setTxtpersonal_fax(getTxtpersonal_fax());
			setTxtpersonal_email(getTxtpersonal_email());
			setTxtpersonal_contact(getTxtpersonal_contact());
			setTxtpersonal_extn_no(getTxtpersonal_extn_no());
			
			setTxtoffice_add1(getTxtoffice_add1());
			setTxtoffice_add2(getTxtoffice_add2());
			setTxtoffice_tel1(getTxtoffice_tel1());
			setOffice_tel2(getOffice_tel2());
			setTxtoffice_fax(getTxtoffice_fax());
			setTxtoffice_email(getTxtoffice_email());
			setTxtoffice_contact(getTxtoffice_contact());
			setTxtoffice_extn_no(getTxtoffice_extn_no());
			
			setTxtresidence_add1(getTxtresidence_add1());
			setTxtresidence_add2(getTxtresidence_add2());
			setTxtresidence_tel1(getTxtresidence_tel1());
			setResidence_tel2(getResidence_tel2());
			setTxtresidence_fax(getTxtresidence_fax());
			setTxtresidence_email(getTxtresidence_email());
			setTxtresidence_contact(getTxtresidence_contact());
			setTxtresidence_extn_no(getTxtresidence_extn_no());
			
			setTxthome_add1(getTxthome_add1());
			setTxthome_add2(getTxthome_add2());
			setTxthome_tel1(getTxthome_tel1());
			setHome_tel2(getHome_tel2());
			setTxthome_fax(getTxthome_fax());
			setTxthome_email(getTxthome_email());
			setTxthome_contact(getTxthome_contact());
			setTxthome_extn_no(getTxthome_extn_no());
			
			setTxtname(getTxtname());
			setTxtaddress(getTxtaddress());
			setTxttelephone(getTxttelephone());
			setTxtid(getTxtid());
			setHidcmbnationality(getCmbnationality());
			setTxtsecurity(getTxtsecurity());
			setTxtsecurity1(getTxtsecurity1());
			
			setTxtcontractno(getTxtcontractno());
			setTxtcontractremarks(getTxtcontractremarks());
			setIdpdetailsallowed(getIdpdetailsallowed());
			setFormdetailcode(getFormdetailcode());
	}
	
}
