package com.humanresource.setup.employeemaster;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsEmployeeMasterAction extends ActionSupport{

	ClsCommon ClsCommon=new ClsCommon();

    
	ClsEmployeeMasterDAO employeemasterDAO= new ClsEmployeeMasterDAO();
	ClsEmployeeMasterBean employeemasterbean;

	private int txtempmasterdocno;
	private String formdetailcode;
	private String chkstatus;
	private String mode;
	private String deleted;
	private String msg;
	private String employeeDate;
	private String hidemployeeDate;
	private String txtemployeeid;
	private String txtemployeename;
	private String txtempaccount;
	private String txtempaccountname;
	private int txtempaccdocno;
	private String cmbcurrency;
	private String hidcmbcurrency;
	private String joiningDate;
	private String hidjoiningDate;
	private String cmbempdesignation;
	private String hidcmbempdesignation;
	private String cmbempdepartment;
	private String hidcmbempdepartment;
	private String cmbpayrollcategory;
	private String hidcmbpayrollcategory;
	private double txtemptravels;
	private double txtempcostperhour;
	private String txtpermanentaddress;
	private String txtpresentaddress;
	private String txtpermanentmobile;
	private String txtpermanentemail;
	private String txtpresentmobile;
	private String txtpresentemail;
	private String txtest_code;
	private String txtco_name;
	
	
	public String getTxtest_code() {
		return txtest_code;
	}

	public void setTxtest_code(String txtest_code) {
		this.txtest_code = txtest_code;
	}

	public String getTxtco_name() {
		return txtco_name;
	}

	public void setTxtco_name(String txtco_name) {
		this.txtco_name = txtco_name;
	}
	
	private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	private String txtempcity;
	private String txtempstate;
	private String txtemppincode;
	private String txtempnationality;
	private int txtempnationalityid;
	private String txtempreligion;
	
	private String txtempnearestairport;
	private String txtempplaceofbirth;
	private String empDateOfBirth;
	private String hidempDateOfBirth;
	
	private String cmbempsex;
	private String hidcmbempsex;
	
	private String cmbempbloodgroup;
	private String hidcmbempbloodgroup;
	private String cmbempmaritalstatus;
	private String hidcmbempmaritalstatus;
	private String txtempfathername;
	private String txtempmothername;
	private String txtempspousename;
	private String txtempotherdetails;
	private String cmbempagentid;
	private String hidcmbempagentid;
	private String txtbankemployeeid;
	private String txtbankaccountno;
	private String txtbankbranchname;
	private String txtbankifsccode;
	private String lblemployeestatus;
	private String txtqualification;
	
	//Monthly Salary Grid
	private int monthlysalarygridlength;
	
	//Documents Grid
	private int documentsgridlength;

	
	public String getTxtqualification() {
		return txtqualification;
	}

	public void setTxtqualification(String txtqualification) {
		this.txtqualification = txtqualification;
	}

	public int getTxtempmasterdocno() {
		return txtempmasterdocno;
	}

	public void setTxtempmasterdocno(int txtempmasterdocno) {
		this.txtempmasterdocno = txtempmasterdocno;
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

	public String getEmployeeDate() {
		return employeeDate;
	}

	public void setEmployeeDate(String employeeDate) {
		this.employeeDate = employeeDate;
	}

	public String getHidemployeeDate() {
		return hidemployeeDate;
	}

	public void setHidemployeeDate(String hidemployeeDate) {
		this.hidemployeeDate = hidemployeeDate;
	}

	public String getTxtemployeeid() {
		return txtemployeeid;
	}

	public void setTxtemployeeid(String txtemployeeid) {
		this.txtemployeeid = txtemployeeid;
	}

	public String getTxtemployeename() {
		return txtemployeename;
	}

	public void setTxtemployeename(String txtemployeename) {
		this.txtemployeename = txtemployeename;
	}

	public String getTxtempaccount() {
		return txtempaccount;
	}

	public void setTxtempaccount(String txtempaccount) {
		this.txtempaccount = txtempaccount;
	}

	public String getTxtempaccountname() {
		return txtempaccountname;
	}

	public void setTxtempaccountname(String txtempaccountname) {
		this.txtempaccountname = txtempaccountname;
	}

	public int getTxtempaccdocno() {
		return txtempaccdocno;
	}

	public void setTxtempaccdocno(int txtempaccdocno) {
		this.txtempaccdocno = txtempaccdocno;
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

	public String getJoiningDate() {
		return joiningDate;
	}

	public void setJoiningDate(String joiningDate) {
		this.joiningDate = joiningDate;
	}

	public String getHidjoiningDate() {
		return hidjoiningDate;
	}

	public void setHidjoiningDate(String hidjoiningDate) {
		this.hidjoiningDate = hidjoiningDate;
	}

	public String getCmbempdesignation() {
		return cmbempdesignation;
	}

	public void setCmbempdesignation(String cmbempdesignation) {
		this.cmbempdesignation = cmbempdesignation;
	}

	public String getHidcmbempdesignation() {
		return hidcmbempdesignation;
	}

	public void setHidcmbempdesignation(String hidcmbempdesignation) {
		this.hidcmbempdesignation = hidcmbempdesignation;
	}

	public String getCmbempdepartment() {
		return cmbempdepartment;
	}

	public void setCmbempdepartment(String cmbempdepartment) {
		this.cmbempdepartment = cmbempdepartment;
	}

	public String getHidcmbempdepartment() {
		return hidcmbempdepartment;
	}

	public void setHidcmbempdepartment(String hidcmbempdepartment) {
		this.hidcmbempdepartment = hidcmbempdepartment;
	}

	public String getCmbpayrollcategory() {
		return cmbpayrollcategory;
	}

	public void setCmbpayrollcategory(String cmbpayrollcategory) {
		this.cmbpayrollcategory = cmbpayrollcategory;
	}

	public String getHidcmbpayrollcategory() {
		return hidcmbpayrollcategory;
	}

	public void setHidcmbpayrollcategory(String hidcmbpayrollcategory) {
		this.hidcmbpayrollcategory = hidcmbpayrollcategory;
	}
	
	public double getTxtempcostperhour() {
		return txtempcostperhour;
	}

	public void setTxtempcostperhour(double txtempcostperhour) {
		this.txtempcostperhour = txtempcostperhour;
	}
	
	public double getTxtemptravels() {
		return txtemptravels;
	}

	public void setTxtemptravels(double txtemptravels) {
		this.txtemptravels = txtemptravels;
	}

	public String getTxtpermanentaddress() {
		return txtpermanentaddress;
	}

	public void setTxtpermanentaddress(String txtpermanentaddress) {
		this.txtpermanentaddress = txtpermanentaddress;
	}

	public String getTxtpresentaddress() {
		return txtpresentaddress;
	}

	public void setTxtpresentaddress(String txtpresentaddress) {
		this.txtpresentaddress = txtpresentaddress;
	}

	public String getTxtpermanentmobile() {
		return txtpermanentmobile;
	}

	public void setTxtpermanentmobile(String txtpermanentmobile) {
		this.txtpermanentmobile = txtpermanentmobile;
	}

	public String getTxtpermanentemail() {
		return txtpermanentemail;
	}

	public void setTxtpermanentemail(String txtpermanentemail) {
		this.txtpermanentemail = txtpermanentemail;
	}

	public String getTxtpresentmobile() {
		return txtpresentmobile;
	}

	public void setTxtpresentmobile(String txtpresentmobile) {
		this.txtpresentmobile = txtpresentmobile;
	}

	public String getTxtpresentemail() {
		return txtpresentemail;
	}

	public void setTxtpresentemail(String txtpresentemail) {
		this.txtpresentemail = txtpresentemail;
	}

	public String getTxtempcity() {
		return txtempcity;
	}

	public void setTxtempcity(String txtempcity) {
		this.txtempcity = txtempcity;
	}

	public String getTxtempstate() {
		return txtempstate;
	}

	public void setTxtempstate(String txtempstate) {
		this.txtempstate = txtempstate;
	}

	public String getTxtemppincode() {
		return txtemppincode;
	}

	public void setTxtemppincode(String txtemppincode) {
		this.txtemppincode = txtemppincode;
	}

	public String getTxtempnationality() {
		return txtempnationality;
	}

	public void setTxtempnationality(String txtempnationality) {
		this.txtempnationality = txtempnationality;
	}

	public int getTxtempnationalityid() {
		return txtempnationalityid;
	}

	public void setTxtempnationalityid(int txtempnationalityid) {
		this.txtempnationalityid = txtempnationalityid;
	}

	public String getTxtempreligion() {
		return txtempreligion;
	}

	public void setTxtempreligion(String txtempreligion) {
		this.txtempreligion = txtempreligion;
	}

	public String getTxtempnearestairport() {
		return txtempnearestairport;
	}

	public void setTxtempnearestairport(String txtempnearestairport) {
		this.txtempnearestairport = txtempnearestairport;
	}

	public String getTxtempplaceofbirth() {
		return txtempplaceofbirth;
	}

	public void setTxtempplaceofbirth(String txtempplaceofbirth) {
		this.txtempplaceofbirth = txtempplaceofbirth;
	}

	public String getEmpDateOfBirth() {
		return empDateOfBirth;
	}

	public void setEmpDateOfBirth(String empDateOfBirth) {
		this.empDateOfBirth = empDateOfBirth;
	}

	public String getHidempDateOfBirth() {
		return hidempDateOfBirth;
	}

	public void setHidempDateOfBirth(String hidempDateOfBirth) {
		this.hidempDateOfBirth = hidempDateOfBirth;
	}

	public String getCmbempsex() {
		return cmbempsex;
	}

	public void setCmbempsex(String cmbempsex) {
		this.cmbempsex = cmbempsex;
	}

	public String getHidcmbempsex() {
		return hidcmbempsex;
	}

	public void setHidcmbempsex(String hidcmbempsex) {
		this.hidcmbempsex = hidcmbempsex;
	}

	public String getCmbempbloodgroup() {
		return cmbempbloodgroup;
	}

	public void setCmbempbloodgroup(String cmbempbloodgroup) {
		this.cmbempbloodgroup = cmbempbloodgroup;
	}

	public String getHidcmbempbloodgroup() {
		return hidcmbempbloodgroup;
	}

	public void setHidcmbempbloodgroup(String hidcmbempbloodgroup) {
		this.hidcmbempbloodgroup = hidcmbempbloodgroup;
	}

	public String getCmbempmaritalstatus() {
		return cmbempmaritalstatus;
	}

	public void setCmbempmaritalstatus(String cmbempmaritalstatus) {
		this.cmbempmaritalstatus = cmbempmaritalstatus;
	}

	public String getHidcmbempmaritalstatus() {
		return hidcmbempmaritalstatus;
	}

	public void setHidcmbempmaritalstatus(String hidcmbempmaritalstatus) {
		this.hidcmbempmaritalstatus = hidcmbempmaritalstatus;
	}

	public String getTxtempfathername() {
		return txtempfathername;
	}

	public void setTxtempfathername(String txtempfathername) {
		this.txtempfathername = txtempfathername;
	}

	public String getTxtempmothername() {
		return txtempmothername;
	}

	public void setTxtempmothername(String txtempmothername) {
		this.txtempmothername = txtempmothername;
	}

	public String getTxtempspousename() {
		return txtempspousename;
	}

	public void setTxtempspousename(String txtempspousename) {
		this.txtempspousename = txtempspousename;
	}

	public String getTxtempotherdetails() {
		return txtempotherdetails;
	}

	public void setTxtempotherdetails(String txtempotherdetails) {
		this.txtempotherdetails = txtempotherdetails;
	}

	public String getCmbempagentid() {
		return cmbempagentid;
	}

	public void setCmbempagentid(String cmbempagentid) {
		this.cmbempagentid = cmbempagentid;
	}

	public String getHidcmbempagentid() {
		return hidcmbempagentid;
	}

	public void setHidcmbempagentid(String hidcmbempagentid) {
		this.hidcmbempagentid = hidcmbempagentid;
	}

	public String getTxtbankemployeeid() {
		return txtbankemployeeid;
	}

	public void setTxtbankemployeeid(String txtbankemployeeid) {
		this.txtbankemployeeid = txtbankemployeeid;
	}

	public String getTxtbankaccountno() {
		return txtbankaccountno;
	}

	public void setTxtbankaccountno(String txtbankaccountno) {
		this.txtbankaccountno = txtbankaccountno;
	}

	public String getTxtbankbranchname() {
		return txtbankbranchname;
	}

	public void setTxtbankbranchname(String txtbankbranchname) {
		this.txtbankbranchname = txtbankbranchname;
	}

	public String getTxtbankifsccode() {
		return txtbankifsccode;
	}

	public void setTxtbankifsccode(String txtbankifsccode) {
		this.txtbankifsccode = txtbankifsccode;
	}

	public String getLblemployeestatus() {
		return lblemployeestatus;
	}

	public void setLblemployeestatus(String lblemployeestatus) {
		this.lblemployeestatus = lblemployeestatus;
	}

	public int getMonthlysalarygridlength() {
		return monthlysalarygridlength;
	}

	public void setMonthlysalarygridlength(int monthlysalarygridlength) {
		this.monthlysalarygridlength = monthlysalarygridlength;
	}

	public int getDocumentsgridlength() {
		return documentsgridlength;
	}

	public void setDocumentsgridlength(int documentsgridlength) {
		this.documentsgridlength = documentsgridlength;
	}

	java.sql.Date employeeMasterDate=null;
	java.sql.Date employeeJoiningDate=null;
	java.sql.Date employeeDateOfBirth=null;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		String mode=getMode();
		
		int docno=Integer.parseInt(request.getParameter("docno")==null?"0":request.getParameter("docno"));
		String id=request.getParameter("id")==null?"0":request.getParameter("id");
		String mode1=request.getParameter("mode")==null?"view":request.getParameter("mode"); 
		
		if(id.equalsIgnoreCase("2")){
			mode=mode1;
			setTxtempmasterdocno(docno);
		} 
		
		
		ClsEmployeeMasterBean bean = new ClsEmployeeMasterBean();

		if(mode.equalsIgnoreCase("A")){
			employeeMasterDate = ClsCommon.changeStringtoSqlDate(getEmployeeDate());	
			employeeJoiningDate = (getJoiningDate()==null || getJoiningDate().trim().equalsIgnoreCase(""))?null:ClsCommon.changeStringtoSqlDate(getJoiningDate());
			employeeDateOfBirth = (getEmpDateOfBirth()==null || getEmpDateOfBirth().trim().equalsIgnoreCase(""))?null:ClsCommon.changeStringtoSqlDate(getEmpDateOfBirth());
			
			/*Monthly Salary Grid*/
			ArrayList<String> monthlysalaryarray= new ArrayList<>();
			for(int i=0;i<getMonthlysalarygridlength();i++){
				String temp=requestParams.get("txtcompensations"+i)[0];
				monthlysalaryarray.add(temp);
			}
			
			/*Documents Grid*/
			ArrayList<String> documentsarray= new ArrayList<>();
			for(int i=0;i<getDocumentsgridlength();i++){
				String tempreference=requestParams.get("txtdocuments"+i)[0];
				documentsarray.add(tempreference);
			}
			
			int val=employeemasterDAO.insert(employeeMasterDate,getTxtest_code(),getTxtco_name(),getFormdetailcode(),getTxtemployeeid(),getTxtemployeename(),getTxtempaccdocno(),getCmbcurrency(),employeeJoiningDate,
					getCmbempdesignation(),getCmbempdepartment(),getCmbpayrollcategory(),getTxtempcostperhour(),getTxtemptravels(),getTxtpermanentaddress(),getTxtpresentaddress(),getTxtpermanentmobile(),
					getTxtpresentmobile(),getTxtpermanentemail(),getTxtpresentemail(),getTxtempcity(),getTxtempstate(),getTxtemppincode(),getTxtempnationalityid(),
					getTxtempreligion(),getTxtempnearestairport(),getTxtempplaceofbirth(),employeeDateOfBirth,getCmbempsex(),getCmbempbloodgroup(),getCmbempmaritalstatus(),
					getTxtempfathername(),getTxtempmothername(),getTxtempspousename(),getTxtempotherdetails(),getCmbempagentid(),getTxtbankemployeeid(),getTxtbankaccountno(),
					getTxtbankbranchname(),getTxtbankifsccode(),getTxtqualification(),monthlysalaryarray,documentsarray,session,request,mode);
			if(val>0.0){
				
				setTxtempmasterdocno(val);
				setHidemployeeDate(employeeMasterDate.toString());
				setHidjoiningDate(employeeJoiningDate==null?null:employeeJoiningDate.toString());
				setHidempDateOfBirth(employeeDateOfBirth==null?null:employeeDateOfBirth.toString());
				setData();
				
				setMsg("Successfully Saved");
				return "success";
			}
			
			else if(val==-1){
				

				setMsg("Employee ID Already Exists");
				return "success";
				
			}
			else{
				setData();
				setHidemployeeDate(employeeMasterDate.toString());
				setHidjoiningDate(employeeJoiningDate==null?null:employeeJoiningDate.toString());
				setHidempDateOfBirth(employeeDateOfBirth==null?null:employeeDateOfBirth.toString());
				setMsg("Not Saved");
				return "fail";
			}	}
		
		else if(mode.equalsIgnoreCase("E")){
			employeeMasterDate = ClsCommon.changeStringtoSqlDate(getEmployeeDate());	
			employeeJoiningDate = (getJoiningDate()==null || getJoiningDate().trim().equalsIgnoreCase(""))?null:ClsCommon.changeStringtoSqlDate(getJoiningDate());
			employeeDateOfBirth = (getEmpDateOfBirth()==null || getEmpDateOfBirth().trim().equalsIgnoreCase(""))?null:ClsCommon.changeStringtoSqlDate(getEmpDateOfBirth());
			
			/*Monthly Salary Grid*/
			ArrayList<String> monthlysalaryarray= new ArrayList<>();
			for(int i=0;i<getMonthlysalarygridlength();i++){
				ClsEmployeeMasterBean employeemasterbean=new ClsEmployeeMasterBean();
				String temp=requestParams.get("txtcompensations"+i)[0];
				monthlysalaryarray.add(temp);
			}
			
			/*Documents Grid*/
			ArrayList<String> documentsarray= new ArrayList<>();
			for(int i=0;i<getDocumentsgridlength();i++){
				ClsEmployeeMasterBean employeemasterbean=new ClsEmployeeMasterBean();
				String tempreference=requestParams.get("txtdocuments"+i)[0];
				documentsarray.add(tempreference);
			}
			
			int Status=employeemasterDAO.edit(getTxtest_code(),getTxtco_name(),getTxtempmasterdocno(),getFormdetailcode(),employeeMasterDate,getTxtemployeeid(),getTxtemployeename(),getTxtempaccdocno(),getCmbcurrency(),
					employeeJoiningDate,getCmbempdesignation(),getCmbempdepartment(),getCmbpayrollcategory(),getTxtempcostperhour(),getTxtemptravels(),getTxtpermanentaddress(),getTxtpresentaddress(),
					getTxtpermanentmobile(),getTxtpresentmobile(),getTxtpermanentemail(),getTxtpresentemail(),getTxtempcity(),getTxtempstate(),getTxtemppincode(),
					getTxtempnationalityid(),getTxtempreligion(),getTxtempnearestairport(),getTxtempplaceofbirth(),employeeDateOfBirth,getCmbempsex(),getCmbempbloodgroup(),
					getCmbempmaritalstatus(),getTxtempfathername(),getTxtempmothername(),getTxtempspousename(),getTxtempotherdetails(),getCmbempagentid(),getTxtbankemployeeid(),
					getTxtbankaccountno(),getTxtbankbranchname(),getTxtbankifsccode(),getTxtqualification(),monthlysalaryarray,documentsarray,session,mode);
			
			if(Status>0){
						
						setTxtempmasterdocno(getTxtempmasterdocno());
						setHidemployeeDate(employeeMasterDate.toString());
						setHidjoiningDate(employeeJoiningDate==null?null:employeeJoiningDate.toString());
						setHidempDateOfBirth(employeeDateOfBirth==null?null:employeeDateOfBirth.toString());
						setData();
				
						setMsg("Updated Successfully");
				        return "success";
			}
			else{
				setData();
				setTxtempmasterdocno(getTxtempmasterdocno());
				setHidemployeeDate(employeeMasterDate.toString());
				setHidjoiningDate(employeeJoiningDate==null?null:employeeJoiningDate.toString());
				setHidempDateOfBirth(employeeDateOfBirth==null?null:employeeDateOfBirth.toString());
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
		int Status=employeemasterDAO.delete(getTxtest_code(),getTxtco_name(),getTxtempmasterdocno(),getFormdetailcode(),session,mode);
		if(Status>0){
					setTxtempmasterdocno(getTxtempmasterdocno());
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
			
			employeemasterbean=employeemasterDAO.getViewDetails(getTxtempmasterdocno());
			
			setEmployeeDate(employeemasterbean.getEmployeeDate());
			setTxtest_code(employeemasterbean.getTxtest_code());
			setTxtco_name(employeemasterbean.getTxtco_name());
			setTxtemployeeid(employeemasterbean.getTxtemployeeid());
			setTxtemployeename(employeemasterbean.getTxtemployeename());
			setTxtempaccount(employeemasterbean.getTxtempaccount());
			setTxtempaccountname(employeemasterbean.getTxtempaccountname());
			setTxtempaccdocno(employeemasterbean.getTxtempaccdocno());
			setHidcmbcurrency(employeemasterbean.getHidcmbcurrency());
			setJoiningDate(employeemasterbean.getJoiningDate());
			setHidcmbempdesignation(employeemasterbean.getHidcmbempdesignation());
			setHidcmbempdepartment(employeemasterbean.getHidcmbempdepartment());
			setHidcmbpayrollcategory(employeemasterbean.getHidcmbpayrollcategory());
			setTxtempcostperhour(employeemasterbean.getTxtempcostperhour());
			setTxtemptravels(employeemasterbean.getTxtemptravels());
			setTxtpermanentaddress(employeemasterbean.getTxtpermanentaddress());
			setTxtpresentaddress(employeemasterbean.getTxtpresentaddress());
			setTxtpermanentmobile(employeemasterbean.getTxtpermanentmobile());
			setTxtpresentmobile(employeemasterbean.getTxtpresentmobile());
			setTxtpermanentemail(employeemasterbean.getTxtpermanentemail());
			setTxtpresentemail(employeemasterbean.getTxtpresentemail());
			setTxtempcity(employeemasterbean.getTxtempcity());
			setTxtempstate(employeemasterbean.getTxtempstate());
			setTxtemppincode(employeemasterbean.getTxtemppincode());
			setTxtempnationality(employeemasterbean.getTxtempnationality());
			setTxtempnationalityid(employeemasterbean.getTxtempnationalityid());
			setTxtempreligion(employeemasterbean.getTxtempreligion());
			setTxtempnearestairport(employeemasterbean.getTxtempnearestairport());
			setTxtempplaceofbirth(employeemasterbean.getTxtempplaceofbirth());
			setEmpDateOfBirth(employeemasterbean.getEmpDateOfBirth());
			setHidcmbempsex(employeemasterbean.getHidcmbempsex());
			setHidcmbempbloodgroup(employeemasterbean.getHidcmbempbloodgroup());
			setHidcmbempmaritalstatus(employeemasterbean.getHidcmbempmaritalstatus());
			setTxtempfathername(employeemasterbean.getTxtempfathername());
			setTxtempmothername(employeemasterbean.getTxtempmothername());
			setTxtempspousename(employeemasterbean.getTxtempspousename());
			setTxtempotherdetails(employeemasterbean.getTxtempotherdetails());
			setHidcmbempagentid(employeemasterbean.getHidcmbempagentid());
			setTxtbankemployeeid(employeemasterbean.getTxtbankemployeeid());
			setTxtbankaccountno(employeemasterbean.getTxtbankaccountno());
			setTxtbankbranchname(employeemasterbean.getTxtbankbranchname());
 			setTxtbankifsccode(employeemasterbean.getTxtbankifsccode());
			setTxtqualification(employeemasterbean.getTxtqualification());
			setLblemployeestatus(employeemasterbean.getLblemployeestatus());
			setFormdetailcode(employeemasterbean.getFormdetailcode());
			return "success";
		}      
		
		return "fail";
}
	public String printAction() throws ParseException, SQLException{
		System.out.println("inside print action ");
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpServletResponse response=ServletActionContext.getResponse();
			HttpSession session=request.getSession();
			String docno=request.getParameter("docno");
			String brhid=request.getParameter("brhid");
			String dtype=request.getParameter("dtype");
			String contextPath=request.getContextPath();
			
			ClsEmployeeMasterDAO empDAO=new ClsEmployeeMasterDAO();
			//ClsEmployeeMasterBean printbean=empDAO.getPrint(docno);
			
			if(ClsCommon.getPrintPath(dtype).contains(".jrxml")==true){
				System.out.println("print jrxml----------------------------");
				 ClsConnection conobj=new ClsConnection();
	        	   param = new HashMap();
	        	   Connection conn = null;
	        	   conn = conobj.getMyConnection();	        	   
	        	   String reportFileName = "Employee Details";
	        	   String photopath="1";
	        	   try{
	        		   Statement stmt= conn.createStatement();
	        		   String strsql="select coalesce(fa.path,1) path,fa.filename from my_fileattach fa left join my_attach_type at on fa.ref_id=at.doc_no where fa.dtype='EMP' and at.type_code='Photo' and fa.doc_no="+docno;
	        		   ResultSet rs=stmt.executeQuery(strsql);
	        		   while(rs.next()){
	        			   photopath=rs.getString("path");
	        		   }
	        		   System.out.println(photopath);
	        		   photopath=photopath.replace("\\", "\\\\");      
	        		   
	        		   String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
	        		   imgpath=imgpath.replace("\\", "\\\\");
	        		   
	        		   param.put("photo", photopath);
	        		   param.put("complogo", imgpath);
	        		   param.put("docno", docno);
	        		   
	        		   JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/humanresource/setup/employeemaster/empMaster.jrxml"));	      	     	 
    	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
                       generateReportPDF(response, param, jasperReport, conn);
	        	   }catch (Exception e) {
				       e.printStackTrace();
				   }
	        	   finally{
	        		   conn.close();
	        	   }
			 }
		 return "print";
	}
	
	public String printAction1() throws ParseException, SQLException{
		
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpServletResponse response=ServletActionContext.getResponse();
			HttpSession session=request.getSession();
			String docno=request.getParameter("docno");
			String brhid=request.getParameter("brhid");
			String dtype=request.getParameter("dtype");
			String contextPath=request.getContextPath();
			
			ClsEmployeeMasterDAO empDAO=new ClsEmployeeMasterDAO();
			
			
			if(ClsCommon.getPrintPath(dtype).contains(".jrxml")==true)
			{
				System.out.println("print jrxml----------------------------");
				 ClsConnection conobj=new ClsConnection();
	        	   param = new HashMap();
	        	   Connection conn = null;
	        	   conn = conobj.getMyConnection();	        	   
	        	   /*String reportFileName = "Employee Details";
	        	   String photopath="1";*/
	        	   try{
	        		   Statement stmt= conn.createStatement();
	        		  /* String strsql="select coalesce(fa.path,1) path,fa.filename from my_fileattach fa left join my_attach_type at on fa.ref_id=at.doc_no where fa.dtype='EMP' and at.type_code='Photo' and fa.doc_no="+docno;
	        		   ResultSet rs=stmt.executeQuery(strsql);
	        		   while(rs.next()){
	        			   photopath=rs.getString("path");
	        		   }
	        		   System.out.println(photopath);
	        		   photopath=photopath.replace("\\", "\\\\");  */    
	        		   
	        		   String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
	        		   imgpath=imgpath.replace("\\", "\\\\");
	        		   String imgfooter=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
	        		   imgfooter=imgfooter.replace("\\", "\\\\");
	        		   
	        		//   param.put("photo", photopath);
	        		   param.put("complogo", imgpath);
	        		   param.put("docno", docno);
	        		   param.put("imgheader", imgpath);
	        		   param.put("imgfooter", imgfooter);
	        		   
	        		   JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(ClsCommon.getPrintPath(dtype)));	      	     	 
    	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
                       generateReportPDF(response, param, jasperReport, conn);
	        	   }catch (Exception e) {
				       e.printStackTrace();
				   }
	        	   finally{
	        		   conn.close();
	        	   }
			 }
		 return "print";
	}
	
	public String printAction2() throws ParseException, SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		HttpSession session=request.getSession();
		String docno=request.getParameter("docno");
		String brhid=request.getParameter("brhid");
		String dtype=request.getParameter("dtype");
		String contextPath=request.getContextPath();
		
		ClsEmployeeMasterDAO empDAO=new ClsEmployeeMasterDAO();
		
		
		if(ClsCommon.getPrintPath(dtype).contains(".jrxml")==true)
		{
			//System.out.println("print jrxml----------------------------");
			 ClsConnection conobj=new ClsConnection();
        	   param = new HashMap();
        	   Connection conn = null;
        	   conn = conobj.getMyConnection();	        	   
        	   /*String reportFileName = "Employee Details";
        	   String photopath="1";*/
        	   try{
        		   Statement stmt= conn.createStatement();
        		  /* String strsql="select coalesce(fa.path,1) path,fa.filename from my_fileattach fa left join my_attach_type at on fa.ref_id=at.doc_no where fa.dtype='EMP' and at.type_code='Photo' and fa.doc_no="+docno;
        		   ResultSet rs=stmt.executeQuery(strsql);
        		   while(rs.next()){
        			   photopath=rs.getString("path");
        		   }
        		   System.out.println(photopath);
        		   photopath=photopath.replace("\\", "\\\\");  */    
        		   
        		   String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
        		   imgpath=imgpath.replace("\\", "\\\\");
        		   String imgfooter=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
        		   imgfooter=imgfooter.replace("\\", "\\\\");
        		   
        		
        		   param.put("docno", docno);
        		   param.put("imgheader", imgpath);
        		   param.put("imgfooter", imgfooter);
        		   
        		   JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/humanresource/setup/employeemaster/applicationform.jrxml"));	      	     	 
	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
                   generateReportPDF(response, param, jasperReport, conn);
        	   }catch (Exception e) {
			       e.printStackTrace();
			   }
        	   finally{
        		   conn.close();
        	   }
		 }
	 return "print";
}

public String printAction4() throws ParseException, SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		HttpSession session=request.getSession();
		String docno=request.getParameter("docno");
		String brhid=request.getParameter("brhid");
		String dtype=request.getParameter("dtype");
		String contextPath=request.getContextPath();
		
		ClsEmployeeMasterDAO empDAO=new ClsEmployeeMasterDAO();
		
		
		if(ClsCommon.getPrintPath(dtype).contains(".jrxml")==true)
		{
			//System.out.println("print jrxml----------------------------");
			 ClsConnection conobj=new ClsConnection();
        	   param = new HashMap();
        	   Connection conn = null;
        	   conn = conobj.getMyConnection();	        	   
        	   /*String reportFileName = "Employee Details";
        	   String photopath="1";*/
        	   try{
        		   Statement stmt= conn.createStatement();
        		  /* String strsql="select coalesce(fa.path,1) path,fa.filename from my_fileattach fa left join my_attach_type at on fa.ref_id=at.doc_no where fa.dtype='EMP' and at.type_code='Photo' and fa.doc_no="+docno;
        		   ResultSet rs=stmt.executeQuery(strsql);
        		   while(rs.next()){
        			   photopath=rs.getString("path");
        		   }
        		   System.out.println(photopath);
        		   photopath=photopath.replace("\\", "\\\\");  */    
        		   
        		   String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
        		   imgpath=imgpath.replace("\\", "\\\\");
        		   String imgfooter=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
        		   imgfooter=imgfooter.replace("\\", "\\\\");
        		   
        		
        		   param.put("docno", docno);
        		   param.put("imgheader", imgpath);
        		   param.put("imgfooter", imgfooter);
        		   
        		   JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/humanresource/setup/employeemaster/checklist.jrxml"));	      	     	 
	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
                   generateReportPDF(response, param, jasperReport, conn);
        	   }catch (Exception e) {
			       e.printStackTrace();
			   }
        	   finally{
        		   conn.close();
        	   }
		 }
	 return "print";
}

public String printAction5() throws ParseException, SQLException{
	
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpServletResponse response=ServletActionContext.getResponse();
	HttpSession session=request.getSession();
	String docno=request.getParameter("docno");
	String brhid=request.getParameter("brhid");
	String dtype=request.getParameter("dtype");
	String contextPath=request.getContextPath();
	
	ClsEmployeeMasterDAO empDAO=new ClsEmployeeMasterDAO();
	
	
	if(ClsCommon.getPrintPath(dtype).contains(".jrxml")==true)
	{
		//System.out.println("print jrxml----------------------------");
		 ClsConnection conobj=new ClsConnection();
    	   param = new HashMap();
    	   Connection conn = null;
    	   conn = conobj.getMyConnection();	        	   
    	   /*String reportFileName = "Employee Details";
    	   String photopath="1";*/
    	   try{
    		   Statement stmt= conn.createStatement();
    		  /* String strsql="select coalesce(fa.path,1) path,fa.filename from my_fileattach fa left join my_attach_type at on fa.ref_id=at.doc_no where fa.dtype='EMP' and at.type_code='Photo' and fa.doc_no="+docno;
    		   ResultSet rs=stmt.executeQuery(strsql);
    		   while(rs.next()){
    			   photopath=rs.getString("path");
    		   }
    		   System.out.println(photopath);
    		   photopath=photopath.replace("\\", "\\\\");  */    
    		   
    		   String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
    		   imgpath=imgpath.replace("\\", "\\\\");
    		   String imgfooter=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
    		   imgfooter=imgfooter.replace("\\", "\\\\");
    		   
    		
    		   param.put("docno", docno);
    		   param.put("imgheader", imgpath);
    		   param.put("imgfooter", imgfooter);
    		   
    		   JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/humanresource/setup/employeemaster/confidentialagreement.jrxml"));	      	     	 
               JasperReport jasperReport = JasperCompileManager.compileReport(design);
               generateReportPDF(response, param, jasperReport, conn);
    	   }catch (Exception e) {
		       e.printStackTrace();
		   }
    	   finally{
    		   conn.close();
    	   }
	 }
 return "print";
}

public String printAction6() throws ParseException, SQLException{
	
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpServletResponse response=ServletActionContext.getResponse();
	HttpSession session=request.getSession();
	String docno=request.getParameter("docno");
	String brhid=request.getParameter("brhid");
	String dtype=request.getParameter("dtype");
	String contextPath=request.getContextPath();
	
	ClsEmployeeMasterDAO empDAO=new ClsEmployeeMasterDAO();
	
	
	if(ClsCommon.getPrintPath(dtype).contains(".jrxml")==true)
	{
		//System.out.println("print jrxml----------------------------");
		 ClsConnection conobj=new ClsConnection();
    	   param = new HashMap();
    	   Connection conn = null;
    	   conn = conobj.getMyConnection();	        	   
    	   /*String reportFileName = "Employee Details";
    	   String photopath="1";*/
    	   try{
    		   Statement stmt= conn.createStatement();
    		  /* String strsql="select coalesce(fa.path,1) path,fa.filename from my_fileattach fa left join my_attach_type at on fa.ref_id=at.doc_no where fa.dtype='EMP' and at.type_code='Photo' and fa.doc_no="+docno;
    		   ResultSet rs=stmt.executeQuery(strsql);
    		   while(rs.next()){
    			   photopath=rs.getString("path");
    		   }
    		   System.out.println(photopath);
    		   photopath=photopath.replace("\\", "\\\\");  */    
    		   
    		   String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
    		   imgpath=imgpath.replace("\\", "\\\\");
    		   String imgfooter=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
    		   imgfooter=imgfooter.replace("\\", "\\\\");
    		   
    		
    		   param.put("docno", docno);
    		   param.put("imgheader", imgpath);
    		   param.put("imgfooter", imgfooter);
    		   
    		   JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/humanresource/setup/employeemaster/joiningletter.jrxml"));	      	     	 
               JasperReport jasperReport = JasperCompileManager.compileReport(design);
               generateReportPDF(response, param, jasperReport, conn);
    	   }catch (Exception e) {
		       e.printStackTrace();
		   }
    	   finally{
    		   conn.close();
    	   }
	 }
 return "print";
}

public String printAction7() throws ParseException, SQLException{
	
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpServletResponse response=ServletActionContext.getResponse();
	HttpSession session=request.getSession();
	String docno=request.getParameter("docno");
	String brhid=request.getParameter("brhid");
	String dtype=request.getParameter("dtype");
	String contextPath=request.getContextPath();
	
	ClsEmployeeMasterDAO empDAO=new ClsEmployeeMasterDAO();
	
	
	if(ClsCommon.getPrintPath(dtype).contains(".jrxml")==true)
	{
		//System.out.println("print jrxml----------------------------");
		 ClsConnection conobj=new ClsConnection();
    	   param = new HashMap();
    	   Connection conn = null;
    	   conn = conobj.getMyConnection();	        	   
    	   /*String reportFileName = "Employee Details";
    	   String photopath="1";*/
    	   try{
    		   Statement stmt= conn.createStatement();
    		  /* String strsql="select coalesce(fa.path,1) path,fa.filename from my_fileattach fa left join my_attach_type at on fa.ref_id=at.doc_no where fa.dtype='EMP' and at.type_code='Photo' and fa.doc_no="+docno;
    		   ResultSet rs=stmt.executeQuery(strsql);
    		   while(rs.next()){
    			   photopath=rs.getString("path");
    		   }
    		   System.out.println(photopath);
    		   photopath=photopath.replace("\\", "\\\\");  */    
    		   
    		   String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
    		   imgpath=imgpath.replace("\\", "\\\\");
    		   String imgfooter=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
    		   imgfooter=imgfooter.replace("\\", "\\\\");
    		   
    		
    		   param.put("docno", docno);
    		   param.put("imgheader", imgpath);
    		   param.put("imgfooter", imgfooter);
    		   
    		   JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/humanresource/setup/employeemaster/perfevalreport.jrxml"));	      	     	 
               JasperReport jasperReport = JasperCompileManager.compileReport(design);
               generateReportPDF(response, param, jasperReport, conn);
    	   }catch (Exception e) {
		       e.printStackTrace();
		   }
    	   finally{
    		   conn.close();
    	   }
	 }
 return "print";
}

public String printAction3() throws ParseException, SQLException{
	
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpServletResponse response=ServletActionContext.getResponse();
	HttpSession session=request.getSession();
	String docno=request.getParameter("docno");
	String brhid=request.getParameter("brhid");
	String dtype=request.getParameter("dtype");
	String contextPath=request.getContextPath();
	
	ClsEmployeeMasterDAO empDAO=new ClsEmployeeMasterDAO();
	
	
	if(ClsCommon.getPrintPath(dtype).contains(".jrxml")==true)
	{
		//System.out.println("print jrxml----------------------------");
		 ClsConnection conobj=new ClsConnection();
    	   param = new HashMap();
    	   Connection conn = null;
    	   conn = conobj.getMyConnection();	        	   
    	   /*String reportFileName = "Employee Details";
    	   String photopath="1";*/
    	   try{
    		   Statement stmt= conn.createStatement();
    		  /* String strsql="select coalesce(fa.path,1) path,fa.filename from my_fileattach fa left join my_attach_type at on fa.ref_id=at.doc_no where fa.dtype='EMP' and at.type_code='Photo' and fa.doc_no="+docno;
    		   ResultSet rs=stmt.executeQuery(strsql);
    		   while(rs.next()){
    			   photopath=rs.getString("path");
    		   }
    		   System.out.println(photopath);
    		   photopath=photopath.replace("\\", "\\\\");  */    
    		   
    		   String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
    		   imgpath=imgpath.replace("\\", "\\\\");
    		   String imgfooter=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
    		   imgfooter=imgfooter.replace("\\", "\\\\");
    		   
    		
    		   param.put("docno", docno);
    		   param.put("imgheader", imgpath);
    		   param.put("imgfooter", imgfooter);
    		   
    		   JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/humanresource/setup/employeemaster/personaldata.jrxml"));	      	     	 
               JasperReport jasperReport = JasperCompileManager.compileReport(design);
               generateReportPDF(response, param, jasperReport, conn);
    	   }catch (Exception e) {
		       e.printStackTrace();
		   }
    	   finally{
    		   conn.close();
    	   }
	 }
 return "print";
}

	
	private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException {
		  byte[] bytes = null;
	    bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
	      resp.reset();
	    resp.resetBuffer();
	    
	    resp.setContentType("application/pdf");
	    resp.setContentLength(bytes.length);
	    ServletOutputStream ouputStream = resp.getOutputStream();
	    ouputStream.write(bytes, 0, bytes.length);
	   
	    ouputStream.flush();
	    ouputStream.close();
	}
		
		public  JSONArray searchAllDetails(HttpSession session,String empname,String mob,String employeedesignation,String employeedepartment,String empid,String dob){
			  JSONArray cellarray = new JSONArray();
			  		  JSONObject cellobj = null;
			  try {
				  cellarray= employeemasterDAO.employeeMainSearch(session,empname,mob,employeedesignation,employeedepartment,empid,dob);
		
			  } catch (SQLException e) {
				  e.printStackTrace();
				  }
			return cellarray;
		}
		
		public void setData() {
			setTxtest_code(getTxtest_code());
			setTxtco_name(getTxtco_name());
			setTxtemployeeid(getTxtemployeeid());
			setTxtemployeename(getTxtemployeename());
			setTxtempaccount(getTxtempaccount());
			setTxtempaccountname(getTxtempaccountname());
			setTxtempaccdocno(getTxtempaccdocno());
			setHidcmbcurrency(getCmbcurrency());
			setHidcmbempdesignation(getCmbempdesignation());
			setHidcmbempdepartment(getCmbempdepartment());
			setHidcmbpayrollcategory(getCmbpayrollcategory());
			setTxtempcostperhour(getTxtempcostperhour());
			setTxtemptravels(getTxtemptravels());
			setTxtpermanentaddress(getTxtpermanentaddress());
			setTxtpresentaddress(getTxtpresentaddress());
			setTxtpermanentmobile(getTxtpermanentmobile());
			setTxtpresentmobile(getTxtpresentmobile());
			setTxtpermanentemail(getTxtpermanentemail());
			setTxtpresentemail(getTxtpresentemail());
			setTxtempcity(getTxtempcity());
			setTxtempstate(getTxtempstate());
			setTxtemppincode(getTxtemppincode());
			setTxtempnationality(getTxtempnationality());
			setTxtempnationalityid(getTxtempnationalityid());
			setTxtempreligion(getTxtempreligion());
			setTxtempnearestairport(getTxtempnearestairport());
			setTxtempplaceofbirth(getTxtempplaceofbirth());
			setHidcmbempsex(getCmbempsex());
			setHidcmbempbloodgroup(getCmbempbloodgroup());
			setHidcmbempmaritalstatus(getCmbempmaritalstatus());
			setTxtempfathername(getTxtempfathername());
			setTxtempmothername(getTxtempmothername());
			setTxtempspousename(getTxtempspousename());
			setTxtempotherdetails(getTxtempotherdetails());
			setHidcmbempagentid(getCmbempagentid());
			setTxtbankemployeeid(getTxtbankemployeeid());
			setTxtbankaccountno(getTxtbankaccountno());
			setTxtbankbranchname(getTxtbankbranchname());
			setTxtbankifsccode(getTxtbankifsccode());
			setFormdetailcode(getFormdetailcode());
			
	}
	
}
