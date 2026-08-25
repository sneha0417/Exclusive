package com.finance.posting.manualapplying;

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
public class ClsManualApplyingAction extends ActionSupport{

	ClsManualApplyingDAO manualApplyingDAO= new ClsManualApplyingDAO();
	ClsManualApplyingBean manualApplyingBean;

	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	
	private String cmbacctype;
	private String hidcmbacctype;
	private int txtdocno;
	private int txtaccid;
	private String txtaccname;
	private String txttrno;
	private String txttranid;
	private double txtoutamount;
	private int txtacno;
	private String txtdoctype;
	private int txtgriddocno;
	private double txtapplyinvoiceamt;
	private double txtapplyinvoiceapply;
	private double txtapplyinvoicebalance;
	
	//Applying Grid Saving
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
	public int getTxtdocno() {
		return txtdocno;
	}
	public void setTxtdocno(int txtdocno) {
		this.txtdocno = txtdocno;
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
	public String getTxttrno() {
		return txttrno;
	}
	public void setTxttrno(String txttrno) {
		this.txttrno = txttrno;
	}
	public String getTxttranid() {
		return txttranid;
	}
	public void setTxttranid(String txttranid) {
		this.txttranid = txttranid;
	}
	public double getTxtoutamount() {
		return txtoutamount;
	}
	public void setTxtoutamount(double txtoutamount) {
		this.txtoutamount = txtoutamount;
	}
	public int getTxtacno() {
		return txtacno;
	}
	public void setTxtacno(int txtacno) {
		this.txtacno = txtacno;
	}
	public String getTxtdoctype() {
		return txtdoctype;
	}
	public void setTxtdoctype(String txtdoctype) {
		this.txtdoctype = txtdoctype;
	}
	public int getTxtgriddocno() {
		return txtgriddocno;
	}
	public void setTxtgriddocno(int txtgriddocno) {
		this.txtgriddocno = txtgriddocno;
	}
	public double getTxtapplyinvoiceamt() {
		return txtapplyinvoiceamt;
	}
	public void setTxtapplyinvoiceamt(double txtapplyinvoiceamt) {
		this.txtapplyinvoiceamt = txtapplyinvoiceamt;
	}
	public double getTxtapplyinvoiceapply() {
		return txtapplyinvoiceapply;
	}
	public void setTxtapplyinvoiceapply(double txtapplyinvoiceapply) {
		this.txtapplyinvoiceapply = txtapplyinvoiceapply;
	}
	public double getTxtapplyinvoicebalance() {
		return txtapplyinvoicebalance;
	}
	public void setTxtapplyinvoicebalance(double txtapplyinvoicebalance) {
		this.txtapplyinvoicebalance = txtapplyinvoicebalance;
	}
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsManualApplyingBean bean = new ClsManualApplyingBean();

		if(mode.equalsIgnoreCase("A")){
			
			/*Apply-Invoice Grid Saving*/
			ArrayList manualapplyarray= new ArrayList();
			
			for(int i=0;i<getGridlength();i++){
				String applytemp=requestParams.get("test"+i)[0];
				manualapplyarray.add(applytemp);
			}
			/*Apply-Invoice Grid Saving Ends*/
			
						int val=manualApplyingDAO.insert(getFormdetailcode(),getTxtgriddocno(),getTxtdoctype(),getTxttrno(),getTxttranid(),getTxtoutamount(),getTxtapplyinvoiceapply(),manualapplyarray,session,request);
						if(val>0.0){
							
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
		return "fail";
	}
	
	public void setData(){
		setHidcmbacctype(getCmbacctype());
		setTxtdocno(getTxtdocno());
		setTxtaccid(getTxtaccid());
		setTxtaccname(getTxtaccname());
		setTxtgriddocno(getTxtgriddocno());
		setTxtdoctype(getTxtdoctype());
		setTxtacno(getTxtacno());
		setTxttrno(getTxttrno());
		setTxtapplyinvoiceamt(getTxtapplyinvoiceamt());
		setTxtapplyinvoiceapply(getTxtapplyinvoiceapply());
		setTxtapplyinvoicebalance(getTxtapplyinvoicebalance());
	}
}


