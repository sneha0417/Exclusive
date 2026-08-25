package com.controlcentre.settings.approvalmaster;
import java.sql.*

;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.*;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.controlcentre.settings.approvalmaster.ClsApprovalMasterBean;
import com.controlcentre.settings.approvalmaster.ClsApprovalMasterDAO;


public class ClsApprovalMasterAction extends ActionSupport{
ClsApprovalMasterDAO approvalmasterDAO=new ClsApprovalMasterDAO();
ClsApprovalMasterBean bean;
private int docno;
private String hidapprdate;;
private String mode,msg,deleted,formdetailcode;

private String apprdate;
private String doctype;
private String doctypename;

private String txtfinal_user1;
private String txtfinal_userfull1;
private String txtfinal_user2;
private String txtfinal_userfull2;
private String txtfinal_user3;
private String txtfinal_userfull3;
private String txtfinal_user4;
private String txtfinal_userfull4;
private String txtfinal_user5;
private String txtfinal_userfull5;

private String txtsecond_user1;
private String txtsecond_userfull1;
private String txtsecond_user2;
private String txtsecond_userfull2;
private String txtsecond_user3;
private String txtsecond_userfull3;

private String txtsecond_user4;
private String txtsecond_userfull4;

private String txtsecond_user5;
private String txtsecond_userfull5;


private String txtfirst_user1;
private String txtfirst_userfull1;

private String txtfirst_user2;
private String txtfirst_userfull2;
private String txtfirst_user3;
private String txtfirst_userfull3;

private String txtfirst_user4;
private String txtfirst_userfull4;

private String txtfirst_user5;
private String txtfirst_userfull5;

private int chckfinal_mandatory1;
private int chckfinal_mandatory2;
private int chckfinal_mandatory3;
private int chckfinal_mandatory4;
private int chckfinal_mandatory5;

private int chcksecond_mandatory1;
private int chcksecond_mandatory2;
private int chcksecond_mandatory3;
private int chcksecond_mandatory4;
private int chcksecond_mandatory5;

private int chckfirst_mandatory1;
private int chckfirst_mandatory2;
private int chckfirst_mandatory3;
private int chckfirst_mandatory4;
private int chckfirst_mandatory5;

private int docno2;
private String userid;
private String username;
private String userrole;




private String txtfinal_userdoc1;  
private String txtfinal_userdoc2;
private String txtfinal_userdoc3;
private String txtfinal_userdoc4;
private String txtfinal_userdoc5;

private String txtsecond_userdoc1;
private String txtsecond_userdoc2;
private String txtsecond_userdoc3;
private String txtsecond_userdoc4;
private String txtsecond_userdoc5;


private String txtfirst_userdoc1;
private String txtfirst_userdoc2;
private String txtfirst_userdoc3;
private String txtfirst_userdoc4;
private String txtfirst_userdoc5;


private String chckfinalmodify;
private String chcksecondmodify;
private String chckfirstmodify;


private String txtfinal_minapproval;  
private String txtsecond_minapproval;
private String txtfirst_minapproval;



private String chkmodify1;
private String chkmodify2;
private String chkmodify3;



private String menu_name;
private String doc_type;





public String getDoctypename() {
	return doctypename;
}
public void setDoctypename(String doctypename) {
	this.doctypename = doctypename;
}
public String getTxtfinal_user1() {
	return txtfinal_user1;
}
public void setTxtfinal_user1(String txtfinal_user1) {
	this.txtfinal_user1 = txtfinal_user1;
}



public String getTxtfinal_userfull2() {
	return txtfinal_userfull2;
}
public void setTxtfinal_userfull2(String txtfinal_userfull2) {
	this.txtfinal_userfull2 = txtfinal_userfull2;
}
public String getTxtfinal_user3() {
	return txtfinal_user3;
}
public void setTxtfinal_user3(String txtfinal_user3) {
	this.txtfinal_user3 = txtfinal_user3;
}
public String getTxtfinal_userfull3() {
	return txtfinal_userfull3;
}
public void setTxtfinal_userfull3(String txtfinal_userfull3) {
	this.txtfinal_userfull3 = txtfinal_userfull3;
}
public String getTxtfinal_user4() {
	return txtfinal_user4;
}
public void setTxtfinal_user4(String txtfinal_user4) {
	this.txtfinal_user4 = txtfinal_user4;
}
public String getTxtfinal_userfull4() {
	return txtfinal_userfull4;
}
public void setTxtfinal_userfull4(String txtfinal_userfull4) {
	this.txtfinal_userfull4 = txtfinal_userfull4;
}
public String getTxtfinal_user5() {
	return txtfinal_user5;
}
public void setTxtfinal_user5(String txtfinal_user5) {
	this.txtfinal_user5 = txtfinal_user5;
}
public String getTxtfinal_userfull5() {
	return txtfinal_userfull5;
}
public void setTxtfinal_userfull5(String txtfinal_userfull5) {
	this.txtfinal_userfull5 = txtfinal_userfull5;
}
public String getTxtsecond_user1() {
	return txtsecond_user1;
}
public void setTxtsecond_user1(String txtsecond_user1) {
	this.txtsecond_user1 = txtsecond_user1;
}
public String getTxtsecond_userfull1() {
	return txtsecond_userfull1;
}
public void setTxtsecond_userfull1(String txtsecond_userfull1) {
	this.txtsecond_userfull1 = txtsecond_userfull1;
}
public String getTxtsecond_user2() {
	return txtsecond_user2;
}
public void setTxtsecond_user2(String txtsecond_user2) {
	this.txtsecond_user2 = txtsecond_user2;
}
public String getTxtsecond_userfull2() {
	return txtsecond_userfull2;
}
public void setTxtsecond_userfull2(String txtsecond_userfull2) {
	this.txtsecond_userfull2 = txtsecond_userfull2;
}
public String getTxtsecond_user3() {
	return txtsecond_user3;
}
public void setTxtsecond_user3(String txtsecond_user3) {
	this.txtsecond_user3 = txtsecond_user3;
}
public String getTxtsecond_userfull3() {
	return txtsecond_userfull3;
}
public void setTxtsecond_userfull3(String txtsecond_userfull3) {
	this.txtsecond_userfull3 = txtsecond_userfull3;
}
public String getTxtsecond_user4() {
	return txtsecond_user4;
}
public void setTxtsecond_user4(String txtsecond_user4) {
	this.txtsecond_user4 = txtsecond_user4;
}
public String getTxtsecond_userfull4() {
	return txtsecond_userfull4;
}
public void setTxtsecond_userfull4(String txtsecond_userfull4) {
	this.txtsecond_userfull4 = txtsecond_userfull4;
}
public String getTxtsecond_user5() {
	return txtsecond_user5;
}
public void setTxtsecond_user5(String txtsecond_user5) {
	this.txtsecond_user5 = txtsecond_user5;
}
public String getTxtsecond_userfull5() {
	return txtsecond_userfull5;
}
public void setTxtsecond_userfull5(String txtsecond_userfull5) {
	this.txtsecond_userfull5 = txtsecond_userfull5;
}
public String getTxtfirst_user1() {
	return txtfirst_user1;
}
public void setTxtfirst_user1(String txtfirst_user1) {
	this.txtfirst_user1 = txtfirst_user1;
}
public String getTxtfirst_userfull1() {
	return txtfirst_userfull1;
}
public void setTxtfirst_userfull1(String txtfirst_userfull1) {
	this.txtfirst_userfull1 = txtfirst_userfull1;
}
public String getTxtfirst_user2() {
	return txtfirst_user2;
}
public void setTxtfirst_user2(String txtfirst_user2) {
	this.txtfirst_user2 = txtfirst_user2;
}
public String getTxtfirst_userfull2() {
	return txtfirst_userfull2;
}
public void setTxtfirst_userfull2(String txtfirst_userfull2) {
	this.txtfirst_userfull2 = txtfirst_userfull2;
}
public String getTxtfirst_user3() {
	return txtfirst_user3;
}
public void setTxtfirst_user3(String txtfirst_user3) {
	this.txtfirst_user3 = txtfirst_user3;
}
public String getTxtfirst_userfull3() {
	return txtfirst_userfull3;
}
public void setTxtfirst_userfull3(String txtfirst_userfull3) {
	this.txtfirst_userfull3 = txtfirst_userfull3;
}
public String getTxtfirst_user4() {
	return txtfirst_user4;
}
public void setTxtfirst_user4(String txtfirst_user4) {
	this.txtfirst_user4 = txtfirst_user4;
}
public String getTxtfirst_userfull4() {
	return txtfirst_userfull4;
}
public void setTxtfirst_userfull4(String txtfirst_userfull4) {
	this.txtfirst_userfull4 = txtfirst_userfull4;
}
public String getTxtfirst_user5() {
	return txtfirst_user5;
}
public void setTxtfirst_user5(String txtfirst_user5) {
	this.txtfirst_user5 = txtfirst_user5;
}
public String getTxtfirst_userfull5() {
	return txtfirst_userfull5;
}
public void setTxtfirst_userfull5(String txtfirst_userfull5) {
	this.txtfirst_userfull5 = txtfirst_userfull5;
}
public String getTxtfinal_user2() {
	return txtfinal_user2;
}
public void setTxtfinal_user2(String txtfinal_user2) {
	this.txtfinal_user2 = txtfinal_user2;
}
public String getTxtfinal_userfull1() {
	return txtfinal_userfull1;
}
public void setTxtfinal_userfull1(String txtfinal_userfull1) {
	this.txtfinal_userfull1 = txtfinal_userfull1;
}
public String getMenu_name() {
	return menu_name;
}
public void setMenu_name(String menu_name) {
	this.menu_name = menu_name;
}
public String getDoc_type() {
	return doc_type;
}
public void setDoc_type(String doc_type) {
	this.doc_type = doc_type;
}

public String getTxtfinal_minapproval() {
	return txtfinal_minapproval;
}
public void setTxtfinal_minapproval(String txtfinal_minapproval) {
	this.txtfinal_minapproval = txtfinal_minapproval;
}
public String getTxtsecond_minapproval() {
	return txtsecond_minapproval;
}
public void setTxtsecond_minapproval(String txtsecond_minapproval) { 
	this.txtsecond_minapproval = txtsecond_minapproval;
}
public String getTxtfirst_minapproval() {
	return txtfirst_minapproval;
}
public void setTxtfirst_minapproval(String txtfirst_minapproval) {
	this.txtfirst_minapproval = txtfirst_minapproval;
}



public String getChckfinalmodify() {
	return chckfinalmodify;
}
public void setChckfinalmodify(String chckfinalmodify) {
	this.chckfinalmodify = chckfinalmodify;
}
public String getChcksecondmodify() {
	return chcksecondmodify;
}
public void setChcksecondmodify(String chcksecondmodify) {
	this.chcksecondmodify = chcksecondmodify;
}
public String getChckfirstmodify() {
	return chckfirstmodify;
}
public void setChckfirstmodify(String chckfirstmodify) {
	this.chckfirstmodify = chckfirstmodify;
}
public String getTxtfinal_userdoc1() {
	return txtfinal_userdoc1;
}
public void setTxtfinal_userdoc1(String txtfinal_userdoc1) {
	this.txtfinal_userdoc1 = txtfinal_userdoc1;
}
public String getTxtfinal_userdoc2() {
	return txtfinal_userdoc2;
}
public void setTxtfinal_userdoc2(String txtfinal_userdoc2) {
	this.txtfinal_userdoc2 = txtfinal_userdoc2;
}
public String getTxtfinal_userdoc3() {
	return txtfinal_userdoc3;
}
public void setTxtfinal_userdoc3(String txtfinal_userdoc3) {
	this.txtfinal_userdoc3 = txtfinal_userdoc3;
}
public String getTxtfinal_userdoc4() {
	return txtfinal_userdoc4;
}
public void setTxtfinal_userdoc4(String txtfinal_userdoc4) {
	this.txtfinal_userdoc4 = txtfinal_userdoc4;
}
public String getTxtfinal_userdoc5() {
	return txtfinal_userdoc5;
}
public void setTxtfinal_userdoc5(String txtfinal_userdoc5) {
	this.txtfinal_userdoc5 = txtfinal_userdoc5;
}
public String getTxtsecond_userdoc1() {
	return txtsecond_userdoc1;
}
public void setTxtsecond_userdoc1(String txtsecond_userdoc1) {
	this.txtsecond_userdoc1 = txtsecond_userdoc1;
}
public String getTxtsecond_userdoc2() {
	return txtsecond_userdoc2;
}
public void setTxtsecond_userdoc2(String txtsecond_userdoc2) {
	this.txtsecond_userdoc2 = txtsecond_userdoc2;
}
public String getTxtsecond_userdoc3() {
	return txtsecond_userdoc3;
}
public void setTxtsecond_userdoc3(String txtsecond_userdoc3) {
	this.txtsecond_userdoc3 = txtsecond_userdoc3;
}
public String getTxtsecond_userdoc4() {
	return txtsecond_userdoc4;
}
public void setTxtsecond_userdoc4(String txtsecond_userdoc4) {
	this.txtsecond_userdoc4 = txtsecond_userdoc4;
}
public String getTxtsecond_userdoc5() {
	return txtsecond_userdoc5;
}
public void setTxtsecond_userdoc5(String txtsecond_userdoc5) {
	this.txtsecond_userdoc5 = txtsecond_userdoc5;
}
public String getTxtfirst_userdoc1() {
	return txtfirst_userdoc1;
}
public void setTxtfirst_userdoc1(String txtfirst_userdoc1) {
	this.txtfirst_userdoc1 = txtfirst_userdoc1;
}
public String getTxtfirst_userdoc2() {
	return txtfirst_userdoc2;
}
public void setTxtfirst_userdoc2(String txtfirst_userdoc2) {
	this.txtfirst_userdoc2 = txtfirst_userdoc2;
}
public String getTxtfirst_userdoc3() {
	return txtfirst_userdoc3;
}
public void setTxtfirst_userdoc3(String txtfirst_userdoc3) {
	this.txtfirst_userdoc3 = txtfirst_userdoc3;
}
public String getTxtfirst_userdoc4() {
	return txtfirst_userdoc4;
}
public void setTxtfirst_userdoc4(String txtfirst_userdoc4) {
	this.txtfirst_userdoc4 = txtfirst_userdoc4;
}
public String getTxtfirst_userdoc5() {
	return txtfirst_userdoc5;
}
public void setTxtfirst_userdoc5(String txtfirst_userdoc5) {
	this.txtfirst_userdoc5 = txtfirst_userdoc5;
}
public String getUserrole() {
	return userrole;
}
public void setUserrole(String userrole) {
	this.userrole = userrole;
}


public String getUserid() {
	return userid;
}
public void setUserid(String userid) {
	this.userid = userid;
}
public String getUsername() {
	return username;
}
public void setUsername(String username) {
	this.username = username;
}








public int getChckfinal_mandatory1() {
	return chckfinal_mandatory1;
}
public void setChckfinal_mandatory1(int chckfinal_mandatory1) {
	this.chckfinal_mandatory1 = chckfinal_mandatory1;
}
public int getChckfinal_mandatory2() {
	return chckfinal_mandatory2;
}
public void setChckfinal_mandatory2(int chckfinal_mandatory2) {
	this.chckfinal_mandatory2 = chckfinal_mandatory2;
}
public int getChckfinal_mandatory3() {
	return chckfinal_mandatory3;
}
public void setChckfinal_mandatory3(int chckfinal_mandatory3) {
	this.chckfinal_mandatory3 = chckfinal_mandatory3;
}
public int getChckfinal_mandatory4() {
	return chckfinal_mandatory4;
}
public void setChckfinal_mandatory4(int chckfinal_mandatory4) {
	this.chckfinal_mandatory4 = chckfinal_mandatory4;
}
public int getChckfinal_mandatory5() {
	return chckfinal_mandatory5;
}
public void setChckfinal_mandatory5(int chckfinal_mandatory5) {
	this.chckfinal_mandatory5 = chckfinal_mandatory5;
}
public int getChcksecond_mandatory1() {
	return chcksecond_mandatory1;
}
public void setChcksecond_mandatory1(int chcksecond_mandatory1) {
	this.chcksecond_mandatory1 = chcksecond_mandatory1;
}
public int getChcksecond_mandatory2() {
	return chcksecond_mandatory2;
}
public void setChcksecond_mandatory2(int chcksecond_mandatory2) {
	this.chcksecond_mandatory2 = chcksecond_mandatory2;
}
public int getChcksecond_mandatory3() {
	return chcksecond_mandatory3;
}
public void setChcksecond_mandatory3(int chcksecond_mandatory3) {
	this.chcksecond_mandatory3 = chcksecond_mandatory3;
}
public int getChcksecond_mandatory4() {
	return chcksecond_mandatory4;
}
public void setChcksecond_mandatory4(int chcksecond_mandatory4) {
	this.chcksecond_mandatory4 = chcksecond_mandatory4;
}
public int getChcksecond_mandatory5() {
	return chcksecond_mandatory5;
}
public void setChcksecond_mandatory5(int chcksecond_mandatory5) {
	this.chcksecond_mandatory5 = chcksecond_mandatory5;
}
public int getChckfirst_mandatory1() {
	return chckfirst_mandatory1;
}
public void setChckfirst_mandatory1(int chckfirst_mandatory1) {
	this.chckfirst_mandatory1 = chckfirst_mandatory1;
}
public int getChckfirst_mandatory2() {
	return chckfirst_mandatory2;
}
public void setChckfirst_mandatory2(int chckfirst_mandatory2) {
	this.chckfirst_mandatory2 = chckfirst_mandatory2;
}
public int getChckfirst_mandatory3() {
	return chckfirst_mandatory3;
}
public void setChckfirst_mandatory3(int chckfirst_mandatory3) {
	this.chckfirst_mandatory3 = chckfirst_mandatory3;
}
public int getChckfirst_mandatory4() {
	return chckfirst_mandatory4;
}
public void setChckfirst_mandatory4(int chckfirst_mandatory4) {
	this.chckfirst_mandatory4 = chckfirst_mandatory4;
}
public int getChckfirst_mandatory5() {
	return chckfirst_mandatory5;
}
public void setChckfirst_mandatory5(int chckfirst_mandatory5) {
	this.chckfirst_mandatory5 = chckfirst_mandatory5;
}
public String getHidapprdate() {
	return hidapprdate;
}
public void setHidapprdate(String hidapprdate) {
	this.hidapprdate = hidapprdate;
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

public String getApprdate() {
	return apprdate;
}
public void setApprdate(String apprdate) {
	this.apprdate = apprdate;
}
public String getDoctype() {
	return doctype;
}
public void setDoctype(String doctype) {
	this.doctype = doctype;
}



public String getMsg() {
	return msg;
}
public void setMsg(String msg) {
	this.msg = msg;
}
public String getDeleted() {
	return deleted;
}
public void setDeleted(String deleted) {
	this.deleted = deleted;
}
public String getFormdetailcode() {
	return formdetailcode;
}
public void setFormdetailcode(String formdetailcode) {
	this.formdetailcode = formdetailcode;
}

//===================================================modify val========


private String chckfinalmodifyval,chcksecondmodifyval,chckfirstmodifyval;





public String getChckfinalmodifyval() {
	return chckfinalmodifyval;
}
public void setChckfinalmodifyval(String chckfinalmodifyval) {
	this.chckfinalmodifyval = chckfinalmodifyval;
}
public String getChcksecondmodifyval() {
	return chcksecondmodifyval;
}
public void setChcksecondmodifyval(String chcksecondmodifyval) {
	this.chcksecondmodifyval = chcksecondmodifyval;
}
public String getChckfirstmodifyval() {
	return chckfirstmodifyval;
}
public void setChckfirstmodifyval(String chckfirstmodifyval) {
	this.chckfirstmodifyval = chckfirstmodifyval;
}
public String saveAction() throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	
	///session.getAttribute("BranchName");
	//System.out.println("sessoin"+session.getAttribute("BRANCHSELECTED"));
	//System.out.println("sessoin"+session.getAttribute("COMPANYNAME"));
	
	ArrayList<String> tempuserdoc = new ArrayList<String>();

		String templevel = null;
		chkmodify1=(getChckfinalmodify()==null) ? "0" : getChckfinalmodify();
		chkmodify2=(getChcksecondmodify()==null) ? "0" :getChcksecondmodify();
		chkmodify3=(getChckfirstmodify()==null) ? "0" : getChckfirstmodify();
		
	
		
	 String finalapprov = getTxtfinal_minapproval()==""?"0":getTxtfinal_minapproval();
		
	 String secondapprov= getTxtsecond_minapproval();
	 String firstapprov=getTxtfirst_minapproval();
	 
	
	 /*if(chkmodify1.equalsIgnoreCase("1")){
		 
		 templevel="3";
	 }
	 if(chkmodify2.equalsIgnoreCase("1")){
		 
		 templevel="2";
	 }
	 if(chkmodify3.equalsIgnoreCase("1")){
	 
	 templevel="1";
}*/

	
	if( (getTxtfinal_userdoc1()!= null && !"".equals(getTxtfinal_userdoc1() )) ){
		templevel="3";
		tempuserdoc.add(getTxtfinal_userdoc1()+"::"+templevel+"::"+chkmodify1+"::"+finalapprov);
			
		if( (getTxtfinal_userdoc2() != null && !"".equals(getTxtfinal_userdoc2() )) ){
			tempuserdoc.add(getTxtfinal_userdoc2()+"::"+templevel+"::"+chkmodify1+"::"+finalapprov);
			
			if( (getTxtfinal_userdoc3()!= null && !"".equals(getTxtfinal_userdoc3() )) ){
				tempuserdoc.add(getTxtfinal_userdoc3()+"::"+templevel+"::"+chkmodify1+"::"+finalapprov);
				
				if( (getTxtfinal_userdoc4() != null && !"".equals(getTxtfinal_userdoc4() )) ){
					tempuserdoc.add(getTxtfinal_userdoc4()+"::"+templevel+"::"+chkmodify1+"::"+finalapprov);
					
					if( (getTxtfinal_userdoc5()!= null && !"".equals(getTxtfinal_userdoc5() )) ){
						tempuserdoc.add(getTxtfinal_userdoc5()+"::"+templevel+"::"+chkmodify1+"::"+finalapprov);
					}
				}
			}
		}
	}
	
	if( (getTxtsecond_userdoc1() != null && !"".equals(getTxtsecond_userdoc1() )) ){
		templevel="2";
		tempuserdoc.add(getTxtsecond_userdoc1()+"::"+templevel+"::"+chkmodify2+"::"+secondapprov);
			
		if( (getTxtsecond_userdoc2() != null && !"".equals(getTxtsecond_userdoc2() )) ){
			tempuserdoc.add(getTxtsecond_userdoc2()+"::"+templevel+"::"+chkmodify2+"::"+secondapprov);
			
			if( (getTxtsecond_userdoc3() != null && !"".equals(getTxtsecond_userdoc3() )) ){
				tempuserdoc.add(getTxtsecond_userdoc3()+"::"+templevel+"::"+chkmodify2+"::"+secondapprov);
				
				if( (getTxtsecond_userdoc4() != null && !"".equals(getTxtsecond_userdoc4() )) ){
					tempuserdoc.add(getTxtsecond_userdoc4()+"::"+templevel+"::"+chkmodify2+"::"+secondapprov);
					
					if( (getTxtsecond_userdoc5() != null && !"".equals(getTxtsecond_userdoc5() )) ){
						tempuserdoc.add(getTxtsecond_userdoc5()+"::"+templevel+"::"+chkmodify2+"::"+secondapprov);
					}
				}
			}
		}
	}
	
	if( (getTxtfirst_userdoc1() != null && !"".equals(getTxtfirst_userdoc1() )) ){
		templevel="1";
		tempuserdoc.add(getTxtfirst_userdoc1()+"::"+templevel+"::"+chkmodify3+"::"+firstapprov);
			
		if( (getTxtfirst_userdoc2() != null && !"".equals(getTxtfirst_userdoc2() )) ){
			tempuserdoc.add(getTxtfirst_userdoc2()+"::"+templevel+"::"+chkmodify3+"::"+firstapprov);
			
			if( (getTxtfirst_userdoc3() != null && !"".equals(getTxtfirst_userdoc3() )) ){
				tempuserdoc.add(getTxtfirst_userdoc3()+"::"+templevel+"::"+chkmodify3+"::"+firstapprov);
				
				if( (getTxtfirst_userdoc4() != null && !"".equals(getTxtfirst_userdoc4() )) ){
					tempuserdoc.add(getTxtfirst_userdoc4()+"::"+templevel+"::"+chkmodify3+"::"+firstapprov);
					
					if( (getTxtfirst_userdoc5() != null && !"".equals(getTxtfirst_userdoc5() )) ){
						tempuserdoc.add(getTxtfirst_userdoc5()+"::"+templevel+"::"+chkmodify3+"::"+firstapprov);
					}
				}
			}
		}
	}
	
	 

if(mode.equalsIgnoreCase("A")){
		//System.out.println("inside a");
					int val=approvalmasterDAO.insert(getDoctype(),tempuserdoc,templevel,session,getMode(),getFormdetailcode());
					if(val>0.0){
						
						setDoctype(getDoctype());
						

						
						setDate();
						
						
						
					
						setDocno(val);
						setMsg("Successfully Saved");
						return "success";
					}
					else{
						setDate();
						
						setMsg("Not Saved");
						return "fail";
					}	
	}
	
	else if(mode.equalsIgnoreCase("E")){
			boolean Status=approvalmasterDAO.edit(getDocno(),getDoctype(),tempuserdoc,templevel,session,getMode(),getFormdetailcode());
			if(Status){
				setDoctype(getDoctype());
				setDocno(getDocno());
		/*		setTxtfinal_user1(getTxtfinal_user1());
				setTxtfinal_user2(getTxtfinal_user2());
				setTxtfinal_user3(getTxtfinal_user3());
				setTxtfinal_user4(getTxtfinal_user4());
				setTxtfinal_user5(getTxtfinal_user5());
				
				setTxtsecond_user1(getTxtsecond_user1());
				setTxtsecond_user2(getTxtsecond_user2());
				setTxtsecond_user3(getTxtsecond_user3());
				setTxtsecond_user4(getTxtsecond_user4());
				setTxtsecond_user5(getTxtsecond_user5());
				
				setTxtfirst_user1(getTxtfirst_user1());
				setTxtfirst_user2(getTxtfirst_user2());
				setTxtfirst_user3(getTxtfirst_user3());
				setTxtfirst_user4(getTxtfirst_user4());
				setTxtfirst_user5(getTxtfirst_user5());*/
				setDate();
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setDocno(getDocno());
				setDoctype(getDoctype());
				setDate();
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			
			boolean Status=approvalmasterDAO.delete(getDoctype(),session,getMode(),getDocno(),getFormdetailcode());
		if(Status){
			
			setDoctype(getDoctype());
	
			setDocno(getDocno());
			setMode(getMode());
			setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
		}
		else{
			setDate();
			setMsg("Not Deleted");
			return "fail";
		}
	}

		else if(mode.equalsIgnoreCase("view")){
			
			bean=approvalmasterDAO.getDetails(getDocno());;
			
			
			
			setDocno(getDocno());
			setDoctype(getDoctype());
			setDoctypename(getDoctypename());
			
			setChckfinalmodifyval(bean.getChckfinalmodify());
			setChcksecondmodifyval(bean.getChcksecondmodify());
			setChckfirstmodifyval(bean.getChckfirstmodify());
			
			
			setTxtfinal_minapproval(bean.getTxtfinal_minapproval());
			setTxtsecond_minapproval(bean.getTxtsecond_minapproval());
			setTxtfirst_minapproval(bean.getTxtfirst_minapproval());
			
			
			
			
			setTxtfinal_user1(bean.getTxtfinal_user1());
			setTxtfinal_user2(bean.getTxtfinal_user2());
			setTxtfinal_user3(bean.getTxtfinal_user3());
			setTxtfinal_user4(bean.getTxtfinal_user4());
			setTxtfinal_user5(bean.getTxtfinal_user5());
			
			setTxtfinal_userdoc1(bean.getTxtfinal_userdoc1());
			setTxtfinal_userdoc2(bean.getTxtfinal_userdoc2());
			setTxtfinal_userdoc3(bean.getTxtfinal_userdoc3());
			setTxtfinal_userdoc4(bean.getTxtfinal_userdoc4());
			setTxtfinal_userdoc5(bean.getTxtfinal_userdoc5());
			
			setTxtfinal_userfull1(bean.getTxtfinal_userfull1());
			setTxtfinal_userfull2(bean.getTxtfinal_userfull2());
			setTxtfinal_userfull3(bean.getTxtfinal_userfull3());
			setTxtfinal_userfull4(bean.getTxtfinal_userfull4());
			setTxtfinal_userfull5(bean.getTxtfinal_userfull5());
			
			
			
			
			
			
			setTxtsecond_user1(bean.getTxtsecond_user1());
			setTxtsecond_user2(bean.getTxtsecond_user2());
			setTxtsecond_user3(bean.getTxtsecond_user3());
			setTxtsecond_user4(bean.getTxtsecond_user4());
			setTxtsecond_user5(bean.getTxtsecond_user5());
			
			
			setTxtsecond_userdoc1(bean.getTxtsecond_userdoc1());
			setTxtsecond_userdoc2(bean.getTxtsecond_userdoc2());
			setTxtsecond_userdoc3(bean.getTxtsecond_userdoc3());
			setTxtsecond_userdoc4(bean.getTxtsecond_userdoc4());
			setTxtsecond_userdoc5(bean.getTxtsecond_userdoc5());
			
			setTxtsecond_userfull1(bean.getTxtsecond_userfull1());
			setTxtsecond_userfull2(bean.getTxtsecond_userfull2());
			setTxtsecond_userfull3(bean.getTxtsecond_userfull3());
			setTxtsecond_userfull4(bean.getTxtsecond_userfull4());
			setTxtsecond_userfull5(bean.getTxtsecond_userfull5());
			
			
			setTxtfirst_user1(bean.getTxtfirst_user1());
			setTxtfirst_user2(bean.getTxtfirst_user2());
			setTxtfirst_user3(bean.getTxtfirst_user3());
			setTxtfirst_user4(bean.getTxtfirst_user4());
			setTxtfirst_user5(bean.getTxtfirst_user5());
			
			
			
			
			setTxtfirst_userdoc1(bean.getTxtfirst_userdoc1());
			setTxtfirst_userdoc2(bean.getTxtfirst_userdoc2());
			setTxtfirst_userdoc3(bean.getTxtfirst_userdoc3());
			setTxtfirst_userdoc4(bean.getTxtfirst_userdoc4());
			setTxtfirst_userdoc5(bean.getTxtfirst_userdoc5());
			
			setTxtfirst_userfull1(bean.getTxtfirst_userfull1());
			setTxtfirst_userfull2(bean.getTxtfirst_userfull2());
			setTxtfirst_userfull3(bean.getTxtfirst_userfull3());
			setTxtfirst_userfull4(bean.getTxtfirst_userfull4());
			setTxtfirst_userfull5(bean.getTxtfirst_userfull5());
			
			
			
			
		
		}





		return "fail";
	}






public void setDate()
{
	setDoctype(getDoctype());
	setDoctypename(getDoctypename());
	
	setChckfinalmodifyval(getChckfinalmodify());
	setChcksecondmodifyval(getChcksecondmodify());
	setChckfirstmodifyval(getChckfirstmodify());
	
	
	
	setTxtfinal_minapproval(getTxtfinal_minapproval());
	setTxtsecond_minapproval(getTxtsecond_minapproval());
	setTxtfirst_minapproval(getTxtfirst_minapproval());
	
	
	setTxtfinal_user1(getTxtfinal_user1());
	setTxtfinal_user2(getTxtfinal_user2());
	setTxtfinal_user3(getTxtfinal_user3());
	setTxtfinal_user4(getTxtfinal_user4());
	setTxtfinal_user5(getTxtfinal_user5());
	
	setTxtfinal_userdoc1(getTxtfinal_userdoc1());
	setTxtfinal_userdoc2(getTxtfinal_userdoc2());
	setTxtfinal_userdoc3(getTxtfinal_userdoc3());
	setTxtfinal_userdoc4(getTxtfinal_userdoc4());
	setTxtfinal_userdoc5(getTxtfinal_userdoc5());
	
	setTxtfinal_userfull1(getTxtfinal_userfull1());
	setTxtfinal_userfull2(getTxtfinal_userfull2());
	setTxtfinal_userfull3(getTxtfinal_userfull3());
	setTxtfinal_userfull4(getTxtfinal_userfull4());
	setTxtfinal_userfull5(getTxtfinal_userfull5());
	
	
	
	
	
	
	setTxtsecond_user1(getTxtsecond_user1());
	setTxtsecond_user2(getTxtsecond_user2());
	setTxtsecond_user3(getTxtsecond_user3());
	setTxtsecond_user4(getTxtsecond_user4());
	setTxtsecond_user5(getTxtsecond_user5());
	
	
	setTxtsecond_userdoc1(getTxtsecond_userdoc1());
	setTxtsecond_userdoc2(getTxtsecond_userdoc2());
	setTxtsecond_userdoc3(getTxtsecond_userdoc3());
	setTxtsecond_userdoc4(getTxtsecond_userdoc4());
	setTxtsecond_userdoc5(getTxtsecond_userdoc5());
	
	setTxtsecond_userfull1(getTxtsecond_userfull1());
	setTxtsecond_userfull2(getTxtsecond_userfull2());
	setTxtsecond_userfull3(getTxtsecond_userfull3());
	setTxtsecond_userfull4(getTxtsecond_userfull4());
	setTxtsecond_userfull5(getTxtsecond_userfull5());
	
	
	setTxtfirst_user1(getTxtfirst_user1());
	setTxtfirst_user2(getTxtfirst_user2());
	setTxtfirst_user3(getTxtfirst_user3());
	setTxtfirst_user4(getTxtfirst_user4());
	setTxtfirst_user5(getTxtfirst_user5());
	
	
	
	
	setTxtfirst_userdoc1(getTxtfirst_userdoc1());
	setTxtfirst_userdoc2(getTxtfirst_userdoc2());
	setTxtfirst_userdoc3(getTxtfirst_userdoc3());
	setTxtfirst_userdoc4(getTxtfirst_userdoc4());
	setTxtfirst_userdoc5(getTxtfirst_userdoc5());
	
	setTxtfirst_userfull1(getTxtfirst_userfull1());
	setTxtfirst_userfull2(getTxtfirst_userfull2());
	setTxtfirst_userfull3(getTxtfirst_userfull3());
	setTxtfirst_userfull4(getTxtfirst_userfull4());
	setTxtfirst_userfull5(getTxtfirst_userfull5());
	
}





/*public  JSONArray searchDetails(){
	  JSONArray cellarray = new JSONArray();
	  JSONObject cellobj = null;
	  try {
		  List <ClsApprovalMasterBean> list= ClsApprovalMasterDAO.list();
		  for(ClsApprovalMasterBean bean:list){
		  cellobj = new JSONObject();
		  cellobj.put("doc_no", bean.getDocno());
		  cellobj.put("dtype",bean.getDoctype());
		  cellobj.put("menu_name",bean.getMenu_name());
		  cellarray.add(cellobj);

		 }
		// System.out.println("cellobj"+cellarray);
	  } catch (SQLException e) {
		  e.printStackTrace();
	  }
	return cellarray;
}*/
/*public  JSONArray searchUserDetails(){
	  JSONArray cellarray = new JSONArray();
	  JSONObject cellobj = null;
	  try {
		  List <ClsApprovalMasterBean> list= ClsApprovalMasterDAO.list1();
		  for(ClsApprovalMasterBean bean:list){
		  cellobj = new JSONObject();
		  cellobj.put("doc_no", bean.getDocno());
		  cellobj.put("user_id",bean.getUserid());
		  cellobj.put("user_name",bean.getUsername());
		 
		  cellarray.add(cellobj);

		 }
		// System.out.println("cellobj"+cellarray);
	  } catch (SQLException e) {
		  e.printStackTrace();
	  }
	return cellarray;
}*/
/*public  JSONArray usersearchDetails(){
	  JSONArray cellarray = new JSONArray();
	  JSONObject cellobj = null;
	  try {
		  List <ClsApprovalMasterBean> list= ClsApprovalMasterDAO.list2();
		  for(ClsApprovalMasterBean bean:list){
		  cellobj = new JSONObject();
		  cellobj.put("doc_type", bean.getDoc_type());
		  cellobj.put("menu_name",bean.getMenu_name());
		  
		  cellarray.add(cellobj);

		 }
		// System.out.println("cellobj"+cellarray);
	  } catch (SQLException e) {
		  e.printStackTrace();
	  }
	return cellarray;
}*/
}