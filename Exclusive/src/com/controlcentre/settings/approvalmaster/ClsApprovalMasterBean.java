package com.controlcentre.settings.approvalmaster;
import java.util.*;
public class ClsApprovalMasterBean {
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

}
