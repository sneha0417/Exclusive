package com.controlcentre.settings.chequeprintingsetup;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsChequeSetUpAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
	ClsChequeSetUpDAO chqSetUpDAO= new ClsChequeSetUpDAO();
	ClsChequeSetUpBean chqSetUpBean;
	
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String chkstatus;
	private String msg;
	private int txtchqsetupdocno;
	private String jqxChqPrintSetUpDate;
	private String hidjqxChqPrintSetUpDate;
	private int txtbankdocno;
	private String txtbankid;
	private String txtbankname;
	private String txtpageheight;
	private String txtpagewidth;
	private String txtdate;
	private String txtdate1;
	private String txtaccountpaying;
	private String txtaccountpaying1;
	private String txtvertical;
	private String txthorizontal;
	private String txtlength;
	private String txtamtvertical;
	private String txtamthorizontal;
	private String txtamtlength;
	private String txtamount;
	private String txtamount1;
	private String txtamt1vertical;
	private String txtamt1horizontal;
	private String txtamt1length;
	
	//Print
	private String lblpageheight;
	private String lblpagewidth;
	private String lblpagesheight;
	private String lblpageswidth;
	private String lbldatex;
	private String lbldatey;
	private String lblpaytovertical;
	private String lblpaytohorizontal;
	private String lblpaytolength;
	private String lblaccountpayingx;
	private String lblaccountpayingy;
	private String lblamtwordsvertical;
	private String lblamtwordshorizontal;
	private String lblamtwordslength;
	private String lblamountx;
	private String lblamounty;
	private String lblamtwords1vertical;
	private String lblamtwords1horizontal;
	private String lblamtwords1length;
	
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
	public String getChkstatus() {
		return chkstatus;
	}
	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public int getTxtchqsetupdocno() {
		return txtchqsetupdocno;
	}
	public void setTxtchqsetupdocno(int txtchqsetupdocno) {
		this.txtchqsetupdocno = txtchqsetupdocno;
	}
	public String getJqxChqPrintSetUpDate() {
		return jqxChqPrintSetUpDate;
	}
	public void setJqxChqPrintSetUpDate(String jqxChqPrintSetUpDate) {
		this.jqxChqPrintSetUpDate = jqxChqPrintSetUpDate;
	}
	public String getHidjqxChqPrintSetUpDate() {
		return hidjqxChqPrintSetUpDate;
	}
	public void setHidjqxChqPrintSetUpDate(String hidjqxChqPrintSetUpDate) {
		this.hidjqxChqPrintSetUpDate = hidjqxChqPrintSetUpDate;
	}
	public int getTxtbankdocno() {
		return txtbankdocno;
	}
	public void setTxtbankdocno(int txtbankdocno) {
		this.txtbankdocno = txtbankdocno;
	}
	public String getTxtbankid() {
		return txtbankid;
	}
	public void setTxtbankid(String txtbankid) {
		this.txtbankid = txtbankid;
	}
	public String getTxtbankname() {
		return txtbankname;
	}
	public void setTxtbankname(String txtbankname) {
		this.txtbankname = txtbankname;
	}
	public String getTxtpageheight() {
		return txtpageheight;
	}
	public void setTxtpageheight(String txtpageheight) {
		this.txtpageheight = txtpageheight;
	}
	public String getTxtpagewidth() {
		return txtpagewidth;
	}
	public void setTxtpagewidth(String txtpagewidth) {
		this.txtpagewidth = txtpagewidth;
	}
	public String getTxtdate() {
		return txtdate;
	}
	public void setTxtdate(String txtdate) {
		this.txtdate = txtdate;
	}
	public String getTxtdate1() {
		return txtdate1;
	}
	public void setTxtdate1(String txtdate1) {
		this.txtdate1 = txtdate1;
	}
	public String getTxtaccountpaying() {
		return txtaccountpaying;
	}
	public void setTxtaccountpaying(String txtaccountpaying) {
		this.txtaccountpaying = txtaccountpaying;
	}
	public String getTxtaccountpaying1() {
		return txtaccountpaying1;
	}
	public void setTxtaccountpaying1(String txtaccountpaying1) {
		this.txtaccountpaying1 = txtaccountpaying1;
	}
	public String getTxtvertical() {
		return txtvertical;
	}
	public void setTxtvertical(String txtvertical) {
		this.txtvertical = txtvertical;
	}
	public String getTxthorizontal() {
		return txthorizontal;
	}
	public void setTxthorizontal(String txthorizontal) {
		this.txthorizontal = txthorizontal;
	}
	public String getTxtlength() {
		return txtlength;
	}
	public void setTxtlength(String txtlength) {
		this.txtlength = txtlength;
	}
	public String getTxtamtvertical() {
		return txtamtvertical;
	}
	public void setTxtamtvertical(String txtamtvertical) {
		this.txtamtvertical = txtamtvertical;
	}
	public String getTxtamthorizontal() {
		return txtamthorizontal;
	}
	public void setTxtamthorizontal(String txtamthorizontal) {
		this.txtamthorizontal = txtamthorizontal;
	}
	public String getTxtamtlength() {
		return txtamtlength;
	}
	public void setTxtamtlength(String txtamtlength) {
		this.txtamtlength = txtamtlength;
	}
	public String getTxtamount() {
		return txtamount;
	}
	public void setTxtamount(String txtamount) {
		this.txtamount = txtamount;
	}
	public String getTxtamount1() {
		return txtamount1;
	}
	public void setTxtamount1(String txtamount1) {
		this.txtamount1 = txtamount1;
	}
	public String getTxtamt1vertical() {
		return txtamt1vertical;
	}
	public void setTxtamt1vertical(String txtamt1vertical) {
		this.txtamt1vertical = txtamt1vertical;
	}
	public String getTxtamt1horizontal() {
		return txtamt1horizontal;
	}
	public void setTxtamt1horizontal(String txtamt1horizontal) {
		this.txtamt1horizontal = txtamt1horizontal;
	}
	public String getTxtamt1length() {
		return txtamt1length;
	}
	public void setTxtamt1length(String txtamt1length) {
		this.txtamt1length = txtamt1length;
	}

	public String getLblpageheight() {
		return lblpageheight;
	}
	public void setLblpageheight(String lblpageheight) {
		this.lblpageheight = lblpageheight;
	}
	public String getLblpagewidth() {
		return lblpagewidth;
	}
	public void setLblpagewidth(String lblpagewidth) {
		this.lblpagewidth = lblpagewidth;
	}
	public String getLblpagesheight() {
		return lblpagesheight;
	}
	public void setLblpagesheight(String lblpagesheight) {
		this.lblpagesheight = lblpagesheight;
	}
	public String getLblpageswidth() {
		return lblpageswidth;
	}
	public void setLblpageswidth(String lblpageswidth) {
		this.lblpageswidth = lblpageswidth;
	}
	public String getLbldatex() {
		return lbldatex;
	}
	public void setLbldatex(String lbldatex) {
		this.lbldatex = lbldatex;
	}
	public String getLbldatey() {
		return lbldatey;
	}
	public void setLbldatey(String lbldatey) {
		this.lbldatey = lbldatey;
	}
	public String getLblpaytovertical() {
		return lblpaytovertical;
	}
	public void setLblpaytovertical(String lblpaytovertical) {
		this.lblpaytovertical = lblpaytovertical;
	}
	public String getLblpaytohorizontal() {
		return lblpaytohorizontal;
	}
	public void setLblpaytohorizontal(String lblpaytohorizontal) {
		this.lblpaytohorizontal = lblpaytohorizontal;
	}
	public String getLblpaytolength() {
		return lblpaytolength;
	}
	public void setLblpaytolength(String lblpaytolength) {
		this.lblpaytolength = lblpaytolength;
	}
	public String getLblaccountpayingx() {
		return lblaccountpayingx;
	}
	public void setLblaccountpayingx(String lblaccountpayingx) {
		this.lblaccountpayingx = lblaccountpayingx;
	}
	public String getLblaccountpayingy() {
		return lblaccountpayingy;
	}
	public void setLblaccountpayingy(String lblaccountpayingy) {
		this.lblaccountpayingy = lblaccountpayingy;
	}
	public String getLblamtwordsvertical() {
		return lblamtwordsvertical;
	}
	public void setLblamtwordsvertical(String lblamtwordsvertical) {
		this.lblamtwordsvertical = lblamtwordsvertical;
	}
	public String getLblamtwordshorizontal() {
		return lblamtwordshorizontal;
	}
	public void setLblamtwordshorizontal(String lblamtwordshorizontal) {
		this.lblamtwordshorizontal = lblamtwordshorizontal;
	}
	public String getLblamtwordslength() {
		return lblamtwordslength;
	}
	public void setLblamtwordslength(String lblamtwordslength) {
		this.lblamtwordslength = lblamtwordslength;
	}
	public String getLblamountx() {
		return lblamountx;
	}
	public void setLblamountx(String lblamountx) {
		this.lblamountx = lblamountx;
	}
	public String getLblamounty() {
		return lblamounty;
	}
	public void setLblamounty(String lblamounty) {
		this.lblamounty = lblamounty;
	}
	public String getLblamtwords1vertical() {
		return lblamtwords1vertical;
	}
	public void setLblamtwords1vertical(String lblamtwords1vertical) {
		this.lblamtwords1vertical = lblamtwords1vertical;
	}
	public String getLblamtwords1horizontal() {
		return lblamtwords1horizontal;
	}
	public void setLblamtwords1horizontal(String lblamtwords1horizontal) {
		this.lblamtwords1horizontal = lblamtwords1horizontal;
	}
	public String getLblamtwords1length() {
		return lblamtwords1length;
	}
	public void setLblamtwords1length(String lblamtwords1length) {
		this.lblamtwords1length = lblamtwords1length;
	}

	java.sql.Date chqSetUpDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();

		String mode=getMode();
		ClsChequeSetUpBean chequeSetUpbean = new ClsChequeSetUpBean();
		
		if(mode.equalsIgnoreCase("A")){
			chqSetUpDate = ClsCommon.changeStringtoSqlDate(getJqxChqPrintSetUpDate());
			
			int val=chqSetUpDAO.insert(getFormdetailcode(),chqSetUpDate,getTxtbankdocno(),getTxtbankid(),getTxtbankname(),getTxtpageheight(),getTxtpagewidth(),getTxtdate(),getTxtdate1(),getTxtaccountpaying(),
					getTxtaccountpaying1(),getTxthorizontal(),getTxtvertical(),getTxtlength(),getTxtamtvertical(),getTxtamthorizontal(),getTxtamtlength(),getTxtamount(),getTxtamount1(),getTxtamt1vertical(),
					getTxtamt1horizontal(),getTxtamt1length(),session,mode);
			if(val>0.0){
				
				setTxtchqsetupdocno(val);
				setHidjqxChqPrintSetUpDate(chqSetUpDate.toString());
				setData();
				
				setMsg("Successfully Saved");
				return "success";
			}
			else if(val==-1)
			   {
				setData();
				setHidjqxChqPrintSetUpDate(chqSetUpDate.toString());
				setChkstatus("1");
				setMsg("Bank Already Exists");
			    return "fail";
			   }
			else{
				setData();
				setHidjqxChqPrintSetUpDate(chqSetUpDate.toString());
				setMsg("Not Saved");
				return "fail";
			}	
		}
		else if(mode.equalsIgnoreCase("E")){
			chqSetUpDate = ClsCommon.changeStringtoSqlDate(getJqxChqPrintSetUpDate());
			
			int Status=chqSetUpDAO.edit(getFormdetailcode(),getTxtchqsetupdocno(),chqSetUpDate,getTxtbankdocno(),getTxtbankid(),getTxtbankname(),getTxtpageheight(),getTxtpagewidth(),getTxtdate(),getTxtdate1(),getTxtaccountpaying(),
					getTxtaccountpaying1(),getTxthorizontal(),getTxtvertical(),getTxtlength(),getTxtamtvertical(),getTxtamthorizontal(),getTxtamtlength(),getTxtamount(),getTxtamount1(),getTxtamt1vertical(),
					getTxtamt1horizontal(),getTxtamt1length(),session,mode);
			if(Status>0){
				
				setTxtchqsetupdocno(getTxtchqsetupdocno());
				setHidjqxChqPrintSetUpDate(chqSetUpDate.toString());
				setData();
				
				setMsg("Updated Successfully");
				return "success";
			}
			else if(Status==-1)
			   {
				setData();
				setTxtchqsetupdocno(getTxtchqsetupdocno());
				setHidjqxChqPrintSetUpDate(chqSetUpDate.toString());
				setChkstatus("2");
			    setMsg("Bank Already Exists");
			    return "fail";
			}
			else{
				setTxtchqsetupdocno(getTxtchqsetupdocno());
				setHidjqxChqPrintSetUpDate(chqSetUpDate.toString());
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("D")){
			boolean Status=chqSetUpDAO.delete(getTxtchqsetupdocno(),getFormdetailcode(),session,mode);
		if(Status){
			
			setTxtchqsetupdocno(getTxtchqsetupdocno());
			setData();
			
			setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
		}
		else{
			setTxtchqsetupdocno(getTxtchqsetupdocno());
			setHidjqxChqPrintSetUpDate(chqSetUpDate.toString());
			setData();
			setMsg("Not Deleted");
			return "fail";
		}
		}
		
		else if(mode.equalsIgnoreCase("View")){
			
			chqSetUpBean=chqSetUpDAO.getViewDetails(getTxtchqsetupdocno());
			
			setJqxChqPrintSetUpDate(chqSetUpBean.getJqxChqPrintSetUpDate());
			setTxtbankdocno(chqSetUpBean.getTxtbankdocno());
			setTxtbankid(chqSetUpBean.getTxtbankid());
			setTxtbankname(chqSetUpBean.getTxtbankname());
			setTxtpageheight(chqSetUpBean.getTxtpageheight());
			setTxtpagewidth(chqSetUpBean.getTxtpagewidth());
			setTxtdate(chqSetUpBean.getTxtdate());
			setTxtdate1(chqSetUpBean.getTxtdate1());
			setTxtaccountpaying(chqSetUpBean.getTxtaccountpaying());
			setTxtaccountpaying1(chqSetUpBean.getTxtaccountpaying1());
			setTxtvertical(chqSetUpBean.getTxtvertical());
			setTxthorizontal(chqSetUpBean.getTxthorizontal());
			setTxtlength(chqSetUpBean.getTxtlength());
			setTxtamtvertical(chqSetUpBean.getTxtamtvertical());
			setTxtamthorizontal(chqSetUpBean.getTxtamthorizontal());
			setTxtamtlength(chqSetUpBean.getTxtamtlength());
			setTxtamount(chqSetUpBean.getTxtamount());
			setTxtamount1(chqSetUpBean.getTxtamount1());
			setTxtamt1vertical(chqSetUpBean.getTxtamt1vertical());
			setTxtamt1horizontal(chqSetUpBean.getTxtamt1horizontal());
			setTxtamt1length(chqSetUpBean.getTxtamt1length());

			setFormdetailcode(chqSetUpBean.getFormdetailcode());
			
			return "success";
		}
		return "fail";
	}
	
	public  JSONArray searchAllDetails(HttpSession session,String chqdate,String documentno,String bankid,String bankname){
		  JSONArray cellarray = new JSONArray();
		  JSONObject cellobj = null;
		  try {
			  cellarray= chqSetUpDAO.cpsMainSearch(session, chqdate, documentno, bankid, bankname);
	
		  } catch (SQLException e) {
			  e.printStackTrace();
			  }
		return cellarray;
	}
	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		int docno=Integer.parseInt(request.getParameter("docno"));
		chqSetUpBean=chqSetUpDAO.getPrint(docno);
		setLblpageswidth(chqSetUpBean.getLblpageswidth());
		setLblpagesheight(chqSetUpBean.getLblpagesheight());
		setLblpagewidth(chqSetUpBean.getLblpagewidth());
		setLblpageheight(chqSetUpBean.getLblpageheight());
		setLbldatex(chqSetUpBean.getLbldatex());
		setLbldatey(chqSetUpBean.getLbldatey());
		setLblpaytovertical(chqSetUpBean.getLblpaytovertical());
		setLblpaytohorizontal(chqSetUpBean.getLblpaytohorizontal());
		setLblpaytolength(chqSetUpBean.getLblpaytolength());
		setLblaccountpayingx(chqSetUpBean.getLblaccountpayingx());
		setLblaccountpayingy(chqSetUpBean.getLblaccountpayingy());
		setLblamtwordsvertical(chqSetUpBean.getLblamtwordsvertical());
		setLblamtwordshorizontal(chqSetUpBean.getLblamtwordshorizontal());
		setLblamtwordslength(chqSetUpBean.getLblamtwordslength());
		setLblamountx(chqSetUpBean.getLblamountx());
		setLblamounty(chqSetUpBean.getLblamounty());
		setLblamtwords1vertical(chqSetUpBean.getLblamtwords1vertical());
		setLblamtwords1horizontal(chqSetUpBean.getLblamtwords1horizontal());
		setLblamtwords1length(chqSetUpBean.getLblamtwords1length());
	
	return "print";
	}
	
		public void setData() {
			
			setTxtbankdocno(getTxtbankdocno());
			setTxtbankid(getTxtbankid());
			setTxtbankname(getTxtbankname());
			setTxtpageheight(getTxtpageheight());
			setTxtpagewidth(getTxtpagewidth());
			setTxtdate(getTxtdate());
			setTxtdate1(getTxtdate1());
			setTxtaccountpaying(getTxtaccountpaying());
			setTxtaccountpaying1(getTxtaccountpaying1());
			setTxtvertical(getTxtvertical());
			setTxthorizontal(getTxthorizontal());
			setTxtlength(getTxtlength());
			setTxtamtvertical(getTxtamtvertical());
			setTxtamthorizontal(getTxtamthorizontal());
			setTxtamtlength(getTxtamtlength());
			setTxtamount(getTxtamount());
			setTxtamount1(getTxtamount1());
			setTxtamt1vertical(getTxtamt1vertical());
			setTxtamt1horizontal(getTxtamt1horizontal());
			setTxtamt1length(getTxtamt1length());

			setFormdetailcode(getFormdetailcode());
	}
}