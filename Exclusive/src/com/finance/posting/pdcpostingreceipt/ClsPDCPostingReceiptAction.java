package com.finance.posting.pdcpostingreceipt;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsPDCPostingReceiptAction extends ActionSupport{

	ClsCommon commonDAO= new ClsCommon();
	ClsPDCPostingReceiptDAO pdcPostingReceiptDAO= new ClsPDCPostingReceiptDAO();
	ClsPDCPostingReceiptBean pdcPostingReceiptBean;

	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	
	private String cmbcriteria;
	private String hidcmbcriteria;
	private String jqxFromDate;
	private String hidjqxFromDate;
	private String jqxToDate;
	private String hidjqxToDate;
	private String cmbacctype;
	private String hidcmbacctype;
	private int txtaccid;
	private String txtaccname;
	private int txtdocno;
	private String jqxDate;
	private String hidjqxDate;
	private int txtbankaccid;
	private String txtbankaccname;
	private int txtbankdocno;
	private String txtchequeno;
	private String chequedate;
	private String hidchequedate;
	private String txtchqno;
	private String txtrowno;
	private String txttrno;
	private String txtdtype;
	private int txtgriddocno;
	private int txtposttrno;
	
	//PDC Receipt Grid
	private int gridlength;
	
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

	public String getCmbcriteria() {
		return cmbcriteria;
	}

	public void setCmbcriteria(String cmbcriteria) {
		this.cmbcriteria = cmbcriteria;
	}

	public String getHidcmbcriteria() {
		return hidcmbcriteria;
	}

	public void setHidcmbcriteria(String hidcmbcriteria) {
		this.hidcmbcriteria = hidcmbcriteria;
	}

	public String getJqxFromDate() {
		return jqxFromDate;
	}

	public void setJqxFromDate(String jqxFromDate) {
		this.jqxFromDate = jqxFromDate;
	}

	public String getHidjqxFromDate() {
		return hidjqxFromDate;
	}

	public void setHidjqxFromDate(String hidjqxFromDate) {
		this.hidjqxFromDate = hidjqxFromDate;
	}

	public String getJqxToDate() {
		return jqxToDate;
	}

	public void setJqxToDate(String jqxToDate) {
		this.jqxToDate = jqxToDate;
	}

	public String getHidjqxToDate() {
		return hidjqxToDate;
	}

	public void setHidjqxToDate(String hidjqxToDate) {
		this.hidjqxToDate = hidjqxToDate;
	}

	public String getCmbacctype() {
		return cmbacctype;
	}

	public void setCmbacctype(String cmbacctype) {
		this.cmbacctype = cmbacctype;
	}

	public String getHidcmbacctype() {
		return hidcmbacctype;
	}

	public void setHidcmbacctype(String hidcmbacctype) {
		this.hidcmbacctype = hidcmbacctype;
	}

	public int getTxtaccid() {
		return txtaccid;
	}

	public void setTxtaccid(int txtaccid) {
		this.txtaccid = txtaccid;
	}

	public String getTxtaccname() {
		return txtaccname;
	}

	public void setTxtaccname(String txtaccname) {
		this.txtaccname = txtaccname;
	}

	public int getTxtdocno() {
		return txtdocno;
	}

	public void setTxtdocno(int txtdocno) {
		this.txtdocno = txtdocno;
	}
	
	public String getJqxDate() {
		return jqxDate;
	}

	public void setJqxDate(String jqxDate) {
		this.jqxDate = jqxDate;
	}

	public String getHidjqxDate() {
		return hidjqxDate;
	}

	public void setHidjqxDate(String hidjqxDate) {
		this.hidjqxDate = hidjqxDate;
	}

	public int getTxtbankaccid() {
		return txtbankaccid;
	}

	public void setTxtbankaccid(int txtbankaccid) {
		this.txtbankaccid = txtbankaccid;
	}

	public String getTxtbankaccname() {
		return txtbankaccname;
	}

	public void setTxtbankaccname(String txtbankaccname) {
		this.txtbankaccname = txtbankaccname;
	}

	public int getTxtbankdocno() {
		return txtbankdocno;
	}

	public void setTxtbankdocno(int txtbankdocno) {
		this.txtbankdocno = txtbankdocno;
	}

	public String getTxtchequeno() {
		return txtchequeno;
	}

	public void setTxtchequeno(String txtchequeno) {
		this.txtchequeno = txtchequeno;
	}

	public String getChequedate() {
		return chequedate;
	}

	public void setChequedate(String chequedate) {
		this.chequedate = chequedate;
	}

	public String getHidchequedate() {
		return hidchequedate;
	}

	public void setHidchequedate(String hidchequedate) {
		this.hidchequedate = hidchequedate;
	}

	public String getTxtchqno() {
		return txtchqno;
	}

	public void setTxtchqno(String txtchqno) {
		this.txtchqno = txtchqno;
	}

	public String getTxtrowno() {
		return txtrowno;
	}

	public void setTxtrowno(String txtrowno) {
		this.txtrowno = txtrowno;
	}
	
	public String getTxttrno() {
		return txttrno;
	}

	public void setTxttrno(String txttrno) {
		this.txttrno = txttrno;
	}
	
	public String getTxtdtype() {
		return txtdtype;
	}

	public void setTxtdtype(String txtdtype) {
		this.txtdtype = txtdtype;
	}

	public int getTxtgriddocno() {
		return txtgriddocno;
	}

	public void setTxtgriddocno(int txtgriddocno) {
		this.txtgriddocno = txtgriddocno;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	
	public int getTxtposttrno() {
		return txtposttrno;
	}

	public void setTxtposttrno(int txtposttrno) {
		this.txtposttrno = txtposttrno;
	}

	java.sql.Date fromDate;
	java.sql.Date toDate;
	java.sql.Date chequeDate;
	java.sql.Date postingDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsPDCPostingReceiptBean bean = new ClsPDCPostingReceiptBean();

		if(!(getJqxFromDate()==null || getJqxFromDate().equalsIgnoreCase(""))){
			fromDate = commonDAO.changeStringtoSqlDate(getJqxFromDate());
		 }
		
		if(!(getJqxToDate()==null || getJqxToDate().equalsIgnoreCase(""))){
			toDate = commonDAO.changeStringtoSqlDate(getJqxToDate());
		 }
		
		if(!(getChequedate()==null || getChequedate().equalsIgnoreCase(""))){
			chequeDate = commonDAO.changeStringtoSqlDate(getChequedate());
		 }
		
		if(!(getJqxDate()==null || getJqxDate().equalsIgnoreCase(""))){
			postingDate = commonDAO.changeStringtoSqlDate(getJqxDate());
		 }
		 
		if(mode.equalsIgnoreCase("A")){
			
			/*PDC Receipt Grid Saving*/
			ArrayList<String> pdcreceiptarray= new ArrayList<String>();
			for(int i=0;i<getGridlength();i++){
				String applytemp=requestParams.get("test"+i)[0];
				pdcreceiptarray.add(applytemp);
			}
			/*PDC Receipt Grid Saving Ends*/
			
						int val=pdcPostingReceiptDAO.insert(getFormdetailcode(),getCmbcriteria(),postingDate,getTxtchqno(),getTxtrowno(),getTxttrno(),getTxtdtype(),getTxtgriddocno(),chequeDate,getTxtbankdocno(),getTxtposttrno(),pdcreceiptarray,session,request,mode);
						if(val>0.0){
							
							setData();
							setTxttrno(request.getAttribute("tranno").toString());
							setMsg("Successfully Saved");
							return "success";
						}
						else{
							setData();
							setMsg("Not Saved");
							return "fail";
						}	
		}
		return "fail";
	}
	
	public void setData(){
		setHidcmbcriteria(getCmbcriteria());
		if(!(getJqxFromDate()==null || getJqxFromDate().equalsIgnoreCase(""))){
			setHidjqxFromDate(fromDate.toString());
		}
		if(!(getJqxToDate()==null || getJqxToDate().equalsIgnoreCase(""))){
			setHidjqxToDate(toDate.toString());
		}
		setHidcmbacctype(getCmbacctype());
		setTxtdocno(getTxtdocno());
		setTxtaccid(getTxtaccid());
		setTxtaccname(getTxtaccname());
		if(!(getJqxDate()==null || getJqxDate().equalsIgnoreCase(""))){
			setHidjqxDate(postingDate.toString());
		}
		setTxtbankaccid(getTxtbankaccid());
		setTxtbankaccname(getTxtbankaccname());
		setTxtbankdocno(getTxtbankdocno());
		setTxtchequeno(getTxtchequeno());
		if(!(getChequedate()==null || getChequedate().equalsIgnoreCase(""))){
			setHidchequedate(chequeDate.toString());
		}
		setTxtchqno(getTxtchqno());
		setTxtrowno(getTxtrowno());
		setTxtdtype(getTxtdtype());
		setTxtposttrno(getTxtposttrno());
	}
}
