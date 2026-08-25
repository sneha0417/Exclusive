package com.controlcentre.settings.companysettings.branch;
import java.sql.*;
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
import com.controlcentre.settings.companysettings.branch.ClsBranchBean;
import com.controlcentre.settings.companysettings.branch.ClsBranchDAO;

public class ClsBranchAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
	ClsBranchDAO branchDAO= new ClsBranchDAO();
	ClsBranchBean bean;
	private int docno;
	private String compname;
	private String txtbranchid;
	private String txtbranchname;
	private String txtaddress;
	private String txtpbno;
	private String txttel1;
	private String txttel2;
	private String txtfax1;
	private String txtfax2;
	private String txtemail1;
	private String txtwebsite;
	private String txttinno;
	private String txtcstno;
	private String txtstcno;
	private String branchaccdate1;
	private String hidbranchaccdate1;
	private String branchaccdate2;
	private String hidbranchaccdate2;
	private String cmbbranchcurr;
	private String hidcmbbranchcurr;
	private String mode;
	private String deleted;
	private String cmbcompname;
	private String hidcmbcompname;
	private boolean chckfollowhr;
	private String msg;
	private String formdetail;
	private String formdetailcode;
	
	
	public String getFormdetail() {
		return formdetail;
	}
	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public boolean isChckfollowhr() {
		return chckfollowhr;
	}
	public void setChckfollowhr(boolean chckfollowhr) {
		this.chckfollowhr = chckfollowhr;
	}
	public String getCmbcompname() {
		return cmbcompname;
	}
	public void setCmbcompname(String cmbcompname) {
		this.cmbcompname = cmbcompname;
	}
	public String getHidcmbcompname() {
		return hidcmbcompname;
	}
	public void setHidcmbcompname(String hidcmbcompname) {
		this.hidcmbcompname = hidcmbcompname;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getCompname() {
		return compname;
	}
	public void setCompname(String compname) {
		this.compname = compname;
	}
	public String getTxtbranchid() {
		return txtbranchid;
	}
	public void setTxtbranchid(String txtbranchid) {
		this.txtbranchid = txtbranchid;
	}
	public String getTxtbranchname() {
		return txtbranchname;
	}
	public void setTxtbranchname(String txtbranchname) {
		this.txtbranchname = txtbranchname;
	}
	public String getTxtaddress() {
		return txtaddress;
	}
	public void setTxtaddress(String txtaddress) {
		this.txtaddress = txtaddress;
	}
	public String getTxtpbno() {
		return txtpbno;
	}
	public void setTxtpbno(String txtpbno) {
		this.txtpbno = txtpbno;
	}
	public String getTxttel1() {
		return txttel1;
	}
	public void setTxttel1(String txttel1) {
		this.txttel1 = txttel1;
	}
	public String getTxttel2() {
		return txttel2;
	}
	public void setTxttel2(String txttel2) {
		this.txttel2 = txttel2;
	}
	public String getTxtfax1() {
		return txtfax1;
	}
	public void setTxtfax1(String txtfax1) {
		this.txtfax1 = txtfax1;
	}
	public String getTxtfax2() {
		return txtfax2;
	}
	public void setTxtfax2(String txtfax2) {
		this.txtfax2 = txtfax2;
	}
	public String getTxtemail1() {
		return txtemail1;
	}
	public void setTxtemail1(String txtemail1) {
		this.txtemail1 = txtemail1;
	}
	public String getTxtwebsite() {
		return txtwebsite;
	}
	public void setTxtwebsite(String txtwebsite) {
		this.txtwebsite = txtwebsite;
	}
	public String getTxttinno() {
		return txttinno;
	}
	public void setTxttinno(String txttinno) {
		this.txttinno = txttinno;
	}
	public String getTxtcstno() {
		return txtcstno;
	}
	public void setTxtcstno(String txtcstno) {
		this.txtcstno = txtcstno;
	}
	public String getTxtstcno() {
		return txtstcno;
	}
	public void setTxtstcno(String txtstcno) {
		this.txtstcno = txtstcno;
	}
	public String getBranchaccdate1() {
		return branchaccdate1;
	}
	public void setBranchaccdate1(String branchaccdate1) {
		this.branchaccdate1 = branchaccdate1;
	}
	public String getHidbranchaccdate1() {
		return hidbranchaccdate1;
	}
	public void setHidbranchaccdate1(String hidbranchaccdate1) {
		this.hidbranchaccdate1 = hidbranchaccdate1;
	}
	public String getBranchaccdate2() {
		return branchaccdate2;
	}
	public void setBranchaccdate2(String branchaccdate2) {
		this.branchaccdate2 = branchaccdate2;
	}
	public String getHidbranchaccdate2() {
		return hidbranchaccdate2;
	}
	public void setHidbranchaccdate2(String hidbranchaccdate2) {
		this.hidbranchaccdate2 = hidbranchaccdate2;
	}
	public String getCmbbranchcurr() {
		return cmbbranchcurr;
	}
	public void setCmbbranchcurr(String cmbbranchcurr) {
		this.cmbbranchcurr = cmbbranchcurr;
	}
	public String getHidcmbbranchcurr() {
		return hidcmbbranchcurr;
	}
	public void setHidcmbbranchcurr(String hidcmbbranchcurr) {
		this.hidcmbbranchcurr = hidcmbbranchcurr;
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
	
	
	public void setValues(int docno,java.sql.Date accdate1,java.sql.Date accdate2){
		setCmbcompname(getCmbcompname());
		setHidcmbcompname(getCmbcompname());
		setTxtbranchid(getTxtbranchid());
		setTxtbranchname(getTxtbranchname());
		setTxtaddress(getTxtaddress());
		setTxtemail1(getTxtemail1());
		setTxtwebsite(getTxtwebsite());
		setTxtfax1(getTxtfax1());
		setTxtfax2(getTxtfax2());
		setTxttel1(getTxttel1());
		setTxttel2(getTxttel2());
		setTxtpbno(getTxtpbno());
		setBranchaccdate1(accdate1.toString());
		setBranchaccdate2(accdate2.toString());
		setTxttinno(getTxttinno());
		setTxtcstno(getTxtcstno());
		setTxtstcno(getTxtstcno());
		
		setHidcmbbranchcurr(getCmbbranchcurr());
		setDocno(docno);
	}
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
//		System.out.println("hhhhhhhhhhhhhhhhheeeeeeeeeee"+isChckfollowhr());
		session.getAttribute("BranchName");
//		System.out.println("sessoin"+session.getAttribute("BRANCHSELECTED"));
//		System.out.println("sessoin"+session.getAttribute("COMPANYNAME"));
		//System.out.println("request==="+request.getAttribute("BranchName"));
		
		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getBranchaccdate1());
		java.sql.Date sqlStartDate2 = ClsCommon.changeStringtoSqlDate(getBranchaccdate2());

//		System.out.println(request.getParameter("chckfollowhr"));
		
		if(mode.equalsIgnoreCase("A")){
//			System.out.println("inside a");
						int val=branchDAO.insert(getCmbcompname(),getTxtbranchid(),getTxtbranchname(),getTxtaddress(),getTxtemail1(),getTxtwebsite(),getTxtfax1(),getTxtfax2(),
								getTxttel1(),getTxttel2(),getTxtpbno(),sqlStartDate,sqlStartDate2,getCmbbranchcurr(),getTxttinno(),getTxtcstno(),getTxtstcno(),session,getMode(),getFormdetailcode());
						if(val>0.0){
							//setDealerid(getDealerid());
							setValues(val,sqlStartDate,sqlStartDate2);
							setMsg("Successfully Saved");

							return "success";
							
						}
					
						else{
							setValues(val,sqlStartDate,sqlStartDate2);
							setMsg("Not Saved");

							return "fail";
						}	
		}

		else if(mode.equalsIgnoreCase("E")){
				boolean Status=branchDAO.edit(getCmbcompname(),getTxtbranchid(),getTxtbranchname(),getTxtaddress(),getTxtemail1(),getTxtwebsite(),getTxtfax1(),getTxtfax2(),
						getTxttel1(),getTxttel2(),getTxtpbno(),sqlStartDate,sqlStartDate2,getCmbbranchcurr(),getTxttinno(),getTxtcstno(),getTxtstcno(),session,getMode(),getDocno(),getFormdetailcode());
				if(Status){
					setValues(getDocno(),sqlStartDate,sqlStartDate2);
				//	System.out.println("brand"+brand);
					setMsg("Updated Successfully");

					return "success";
				}
				else{
					setValues(getDocno(),sqlStartDate,sqlStartDate2);
					setMsg("Not Updated");

					return "fail";
				}
			}
			else if(mode.equalsIgnoreCase("D")){
				//System.out.println(getDocno()+","+getBrandid()+","+getModeldate());
				int Status=branchDAO.delete(getCmbcompname(),getTxtbranchid(),getTxtbranchname(),getTxtaddress(),getTxtemail1(),getTxtwebsite(),getTxtfax1(),getTxtfax2(),
						getTxttel1(),getTxttel2(),getTxtpbno(),sqlStartDate,sqlStartDate2,getCmbbranchcurr(),getTxttinno(),getTxtcstno(),getTxtstcno(),session,getMode(),getDocno(),getFormdetailcode());
			if(Status>0){
				//setDealerid(getDealerid());
				setValues(getDocno(),sqlStartDate,sqlStartDate2);
				setDeleted("DELETED");
				setMsg("Successfully Deleted");

				return "success";
			}
			else if(Status==-1){
				setValues(getDocno(),sqlStartDate,sqlStartDate2);
				setMode(getMode());
				setMsg("References Present in Other Documents");

				return "fail";
			}
			else{
				setValues(getDocno(),sqlStartDate,sqlStartDate2);
				setMsg("Not Deleted");

				return "fail";
			}
		}
			return "fail";
		}
	public  JSONArray searchDetails(){
		  JSONArray cellarray = new JSONArray();
		  JSONObject cellobj = null;
		  try {
			  List <ClsBranchBean> list= branchDAO.list();
			  for(ClsBranchBean bean:list){
			  cellobj = new JSONObject();
			  cellobj.put("doc_no", bean.getDocno());
			  cellobj.put("branch",bean.getTxtbranchid());
			  cellobj.put("branchname",bean.getTxtbranchname());
			  cellobj.put("address",bean.getTxtaddress());
			  cellobj.put("tel",bean.getTxttel1());
			  cellobj.put("tel2",bean.getTxttel2());
			  cellobj.put("fax",bean.getTxtfax1());
			  cellobj.put("fax2",bean.getTxtfax2());
			  cellobj.put("accyear_f",((bean.getBranchaccdate1()==null) ? "NA" : bean.getBranchaccdate1().toString()));
			  cellobj.put("accyear_t",((bean.getBranchaccdate2()==null) ? "NA" : bean.getBranchaccdate2().toString()));
			  cellobj.put("email",bean.getTxtemail1());
			  cellobj.put("web",bean.getTxtwebsite());
			  cellobj.put("pbno",bean.getTxtpbno());
			  cellobj.put("cstno",bean.getTxtcstno());
			  cellobj.put("stcno",bean.getTxtstcno());
			  cellobj.put("tinno",bean.getTxttinno());
			  cellobj.put("curid",bean.getCmbbranchcurr());
			  cellobj.put("cmpid",bean.getCmbcompname());
			  cellarray.add(cellobj);

			 }
//			 System.out.println("cellobj"+cellarray);
		  } catch (SQLException e) {
			  e.printStackTrace();
		  }
		return cellarray;
	}
	}

