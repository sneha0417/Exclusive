package com.controlcentre.settings.companysettings.company;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

public class ClsCompanyAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
	
	ClsCompanyDAO companyDAO= new ClsCompanyDAO();
	ClsCompanyBean bean;
	private String txtcompid;
	private String txtcompname;
	private String txtaddress;
	private String txtpbno;
	private String txttel1;
	private String txttel2;
	private String txtfax1;
	private String txtfax2;
	private String txtemail1;
	private String txtwebsite;
	/*private String txtsmsno;
	private String txtusername;
	private String txtpassword;
	private String txtsmsurl;
	private String txtfoliotime;*/
	private String compaccdate1;
	private String compaccdate2;
	private String hidcompaccdate1;
	private String hidcompaccdate2;
	private String cmbcurr;
	private String hidcmbcurr;
	private String mode;
	private String deleted;
	private int docno;
	private String msg;
	private String formdetailcode;
	private String formdetail;
	private String cmbtimezone;
	private String hidcmbtimezone;
	
	
	
		public String getCmbtimezone() {
		return cmbtimezone;
	}

	public void setCmbtimezone(String cmbtimezone) {
		this.cmbtimezone = cmbtimezone;
	}

	public String getHidcmbtimezone() {
		return hidcmbtimezone;
	}

	public void setHidcmbtimezone(String hidcmbtimezone) {
		this.hidcmbtimezone = hidcmbtimezone;
	}

		public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getFormdetail() {
		return formdetail;
	}

	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
	}

		public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

		public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

		public String getTxtcompid() {
		return txtcompid;
	}

	public void setTxtcompid(String txtcompid) {
		this.txtcompid = txtcompid;
	}

	public String getTxtcompname() {
		return txtcompname;
	}

	public void setTxtcompname(String txtcompname) {
		this.txtcompname = txtcompname;
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

	public String getCompaccdate1() {
		return compaccdate1;
	}

	public void setCompaccdate1(String compaccdate1) {
		this.compaccdate1 = compaccdate1;
	}

	public String getCompaccdate2() {
		return compaccdate2;
	}

	public void setCompaccdate2(String compaccdate2) {
		this.compaccdate2 = compaccdate2;
	}

	public String getHidcompaccdate1() {
		return hidcompaccdate1;
	}

	public void setHidcompaccdate1(String hidcompaccdate1) {
		this.hidcompaccdate1 = hidcompaccdate1;
	}

	public String getHidcompaccdate2() {
		return hidcompaccdate2;
	}

	public void setHidcompaccdate2(String hidcompaccdate2) {
		this.hidcompaccdate2 = hidcompaccdate2;
	}

	public String getCmbcurr() {
		return cmbcurr;
	}

	public void setCmbcurr(String cmbcurr) {
		this.cmbcurr = cmbcurr;
	}

	public String getHidcmbcurr() {
		return hidcmbcurr;
	}

	public void setHidcmbcurr(String hidcmbcurr) {
		this.hidcmbcurr = hidcmbcurr;
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
		setTxtcompid(getTxtcompid());
		setTxtcompname(getTxtcompname());
		setTxtaddress(getTxtaddress());
		setTxtemail1(getTxtemail1());
		setTxtwebsite(getTxtwebsite());
		setTxtfax1(getTxtfax1());
		setTxtfax2(getTxtfax2());
		setTxttel1(getTxttel1());
		setTxttel2(getTxttel2());
		setTxtpbno(getTxtpbno());
		if(accdate1!=null){
			setCompaccdate1(accdate1.toString());	
		}
		if(accdate2!=null){
			setCompaccdate2(accdate2.toString());
		}
		setHidcmbcurr(getCmbcurr());
		setDocno(docno);
		if(getCmbtimezone()!=null){
			setHidcmbtimezone(getCmbtimezone());	
		}
		
	}
		public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();

		session.getAttribute("BranchName");
		System.out.println("sessoin"+session.getAttribute("BRANCHSELECTED"));
		System.out.println("sessoin"+session.getAttribute("COMPANYNAME"));
		
		java.sql.Date sqlStartDate = null;
		java.sql.Date sqlStartDate2 = null;
		if(getCompaccdate1()!=null){
			sqlStartDate=ClsCommon.changeStringtoSqlDate(getCompaccdate1());
		}
		if(getCompaccdate2()!=null){
			sqlStartDate2=ClsCommon.changeStringtoSqlDate(getCompaccdate2());
		}
		


		
		if(mode.equalsIgnoreCase("A")){
			//System.out.println("inside a");
						int val=companyDAO.insert(getTxtcompid(),getTxtcompname(),getTxtaddress(),getTxtemail1(),getTxtwebsite(),getTxtfax1(),getTxtfax2(),
								getTxttel1(),getTxttel2(),getTxtpbno(),sqlStartDate,sqlStartDate2,getCmbcurr(),session,getMode(),getFormdetailcode(),getCmbtimezone());
						if(val>0.0){
							//setDealerid(getDealerid());
							setValues(val,sqlStartDate,sqlStartDate2);
							setMsg("Successfully Saved");

							return "success";
						}
						else if(val==-1){
							setValues(val,sqlStartDate,sqlStartDate2);
							setMsg("Company Already Exists");
							return "fail";
						}
						else{
							setValues(val,sqlStartDate,sqlStartDate2);
							setMsg("Not Saved");
							return "fail";
						}	
		}


		else if(mode.equalsIgnoreCase("E")){
				int Status=companyDAO.edit(getTxtcompid(),getTxtcompname(),getTxtaddress(),getTxtemail1(),getTxtwebsite(),getTxtfax1(),getTxtfax2(),
						getTxttel1(),getTxttel2(),getTxtpbno(),sqlStartDate,sqlStartDate2,getCmbcurr(),session,getMode(),getDocno(),getFormdetailcode(),getCmbtimezone());
				if(Status>0){
					setValues(getDocno(),sqlStartDate,sqlStartDate2);
					setMsg("Updated Successfully");
					return "success";
				}
				else if(Status==-1){
					setValues(getDocno(),sqlStartDate,sqlStartDate2);
					setMsg("Company Already Exists");
				}
				else{
					setValues(getDocno(),sqlStartDate,sqlStartDate2);
					setMsg("Not Updated");

					return "fail";
				}
			}
			else if(mode.equalsIgnoreCase("D")){
				//System.out.println(getDocno()+","+getBrandid()+","+getModeldate());
				int Status=companyDAO.delete(getTxtcompid(),getTxtcompname(),getTxtaddress(),getTxtemail1(),getTxtwebsite(),getTxtfax1(),getTxtfax2(),
						getTxttel1(),getTxttel2(),getTxtpbno(),sqlStartDate,sqlStartDate2,getCmbcurr(),session,getMode(),getDocno(),getFormdetailcode());
			if(Status>0){
				//setDealerid(getDealerid());
				setValues(getDocno(),sqlStartDate,sqlStartDate2);
				setDeleted("DELETED");
				setMsg("Successfully Deleted");

				return "success";
			}
			else if(Status==-1){
				setValues(getDocno(),sqlStartDate,sqlStartDate2);
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
		
	}

