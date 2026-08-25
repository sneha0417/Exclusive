package com.finance.interbranchtransactions.ibjournalvouchers;

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
public class ClsIbJournalVouchersAction extends ActionSupport{

	ClsCommon commonDAO= new ClsCommon();
	ClsIbJournalVouchersDAO ibJournalVouchersDAO= new ClsIbJournalVouchersDAO();
	ClsIbJournalVouchersBean ibJournalVouchersBean;

	private int txtibjournalvouchersdocno;
	private String formdetailcode;
	private String brchName;
	private String mode;
	private String deleted;
	private String msg;
	private String jqxIbJournalVouchersDate;
	private String hidjqxIbJournalVouchersDate;
	private String txtrefno;
	private String txtdescription;
	private Double txtdrtotal;
	private Double txtcrtotal;
	private int txttrno;
	private String lblformposted;
	
	private String maindate;
	private String hidmaindate;
	
	private String url;
	
	//Ib-Journal Vouchers Grid
	private int gridlength;
	
	//Print
	private String lblcompname;
	private String lblcompaddress;
	private String lblpobox;
	private String lblprintname;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	private String lblservicetax;
	private String lblpan;
	private String lblcstno;
	
	private String lbldate;
	private String lblvoucherno;
	private String lblrefno;
	private String lblnetamount;
	private String lblnetamountwords;
	private String lbldescription;
	private String lbldebittotal;
	private String lblcredittotal;
	private String lblpreparedby;
	private String lblpreparedon;
	private String lblpreparedat;

	//for hide
	private int firstarray;
	private int txtheader;

	public int getTxtibjournalvouchersdocno() {
		return txtibjournalvouchersdocno;
	}

	public void setTxtibjournalvouchersdocno(int txtibjournalvouchersdocno) {
		this.txtibjournalvouchersdocno = txtibjournalvouchersdocno;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getBrchName() {
		return brchName;
	}

	public void setBrchName(String brchName) {
		this.brchName = brchName;
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

	public String getJqxIbJournalVouchersDate() {
		return jqxIbJournalVouchersDate;
	}

	public void setJqxIbJournalVouchersDate(String jqxIbJournalVouchersDate) {
		this.jqxIbJournalVouchersDate = jqxIbJournalVouchersDate;
	}

	public String getHidjqxIbJournalVouchersDate() {
		return hidjqxIbJournalVouchersDate;
	}

	public void setHidjqxIbJournalVouchersDate(String hidjqxIbJournalVouchersDate) {
		this.hidjqxIbJournalVouchersDate = hidjqxIbJournalVouchersDate;
	}

	public String getTxtrefno() {
		return txtrefno;
	}

	public void setTxtrefno(String txtrefno) {
		this.txtrefno = txtrefno;
	}

	public String getTxtdescription() {
		return txtdescription;
	}

	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}

	public Double getTxtdrtotal() {
		return txtdrtotal;
	}

	public void setTxtdrtotal(Double txtdrtotal) {
		this.txtdrtotal = txtdrtotal;
	}

	public Double getTxtcrtotal() {
		return txtcrtotal;
	}

	public void setTxtcrtotal(Double txtcrtotal) {
		this.txtcrtotal = txtcrtotal;
	}

	public int getTxttrno() {
		return txttrno;
	}

	public void setTxttrno(int txttrno) {
		this.txttrno = txttrno;
	}

	public String getLblformposted() {
		return lblformposted;
	}

	public void setLblformposted(String lblformposted) {
		this.lblformposted = lblformposted;
	}

	public String getMaindate() {
		return maindate;
	}

	public void setMaindate(String maindate) {
		this.maindate = maindate;
	}

	public String getHidmaindate() {
		return hidmaindate;
	}

	public void setHidmaindate(String hidmaindate) {
		this.hidmaindate = hidmaindate;
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

	public String getLblcompname() {
		return lblcompname;
	}

	public void setLblcompname(String lblcompname) {
		this.lblcompname = lblcompname;
	}

	public String getLblcompaddress() {
		return lblcompaddress;
	}

	public void setLblcompaddress(String lblcompaddress) {
		this.lblcompaddress = lblcompaddress;
	}

	public String getLblpobox() {
		return lblpobox;
	}

	public void setLblpobox(String lblpobox) {
		this.lblpobox = lblpobox;
	}
	
	public String getLblprintname() {
		return lblprintname;
	}

	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}

	public String getLblcomptel() {
		return lblcomptel;
	}

	public void setLblcomptel(String lblcomptel) {
		this.lblcomptel = lblcomptel;
	}

	public String getLblcompfax() {
		return lblcompfax;
	}

	public void setLblcompfax(String lblcompfax) {
		this.lblcompfax = lblcompfax;
	}

	public String getLblbranch() {
		return lblbranch;
	}

	public void setLblbranch(String lblbranch) {
		this.lblbranch = lblbranch;
	}

	public String getLbllocation() {
		return lbllocation;
	}

	public String getLblservicetax() {
		return lblservicetax;
	}

	public void setLblservicetax(String lblservicetax) {
		this.lblservicetax = lblservicetax;
	}

	public String getLblpan() {
		return lblpan;
	}

	public void setLblpan(String lblpan) {
		this.lblpan = lblpan;
	}

	public String getLblcstno() {
		return lblcstno;
	}

	public void setLblcstno(String lblcstno) {
		this.lblcstno = lblcstno;
	}

	public void setLbllocation(String lbllocation) {
		this.lbllocation = lbllocation;
	}

	public String getLbldate() {
		return lbldate;
	}

	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}

	public String getLblvoucherno() {
		return lblvoucherno;
	}

	public void setLblvoucherno(String lblvoucherno) {
		this.lblvoucherno = lblvoucherno;
	}

	public String getLblrefno() {
		return lblrefno;
	}

	public void setLblrefno(String lblrefno) {
		this.lblrefno = lblrefno;
	}

	public String getLblnetamount() {
		return lblnetamount;
	}

	public void setLblnetamount(String lblnetamount) {
		this.lblnetamount = lblnetamount;
	}

	public String getLblnetamountwords() {
		return lblnetamountwords;
	}

	public void setLblnetamountwords(String lblnetamountwords) {
		this.lblnetamountwords = lblnetamountwords;
	}
	
	public String getLbldescription() {
		return lbldescription;
	}

	public void setLbldescription(String lbldescription) {
		this.lbldescription = lbldescription;
	}

	public String getLbldebittotal() {
		return lbldebittotal;
	}

	public void setLbldebittotal(String lbldebittotal) {
		this.lbldebittotal = lbldebittotal;
	}

	public String getLblcredittotal() {
		return lblcredittotal;
	}

	public void setLblcredittotal(String lblcredittotal) {
		this.lblcredittotal = lblcredittotal;
	}

	public String getLblpreparedby() {
		return lblpreparedby;
	}

	public void setLblpreparedby(String lblpreparedby) {
		this.lblpreparedby = lblpreparedby;
	}

	public String getLblpreparedon() {
		return lblpreparedon;
	}

	public void setLblpreparedon(String lblpreparedon) {
		this.lblpreparedon = lblpreparedon;
	}

	public String getLblpreparedat() {
		return lblpreparedat;
	}

	public void setLblpreparedat(String lblpreparedat) {
		this.lblpreparedat = lblpreparedat;
	}

	public int getFirstarray() {
		return firstarray;
	}

	public void setFirstarray(int firstarray) {
		this.firstarray = firstarray;
	}

	public int getTxtheader() {
		return txtheader;
	}

	public void setTxtheader(int txtheader) {
		this.txtheader = txtheader;
	}

	java.sql.Date ibJournalVouchersDate;
	java.sql.Date hidibJournalVouchersDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		String mode=getMode();
		ClsIbJournalVouchersBean bean = new ClsIbJournalVouchersBean();

		ibJournalVouchersDate = commonDAO.changeStringtoSqlDate(getJqxIbJournalVouchersDate());
		hidibJournalVouchersDate = commonDAO.changeStringtoSqlDate(getMaindate());
		
		if(mode.equalsIgnoreCase("A")){
			String mainBranch=session.getAttribute("BRANCHID").toString().trim();
			/*Ib-Journal Voucher Grid*/
			ArrayList<String> ibjournalvouchersarray= new ArrayList<>();
			
			for(int i=0;i<getGridlength();i++){
				ClsIbJournalVouchersBean ibjournalvouchersbean=new ClsIbJournalVouchersBean();
				String temp=requestParams.get("test"+i)[0]+"::"+mainBranch;
				ibjournalvouchersarray.add(temp);
			}
			/*Ib-Journal Voucher Grid Ends*/
						int val=ibJournalVouchersDAO.insert(ibJournalVouchersDate, getFormdetailcode().concat("-15"), getTxtrefno(), getTxtdescription(), getTxtdrtotal(), getTxtcrtotal(),
								ibjournalvouchersarray,session,request,mode);
						if(val>0.0){

							setTxtibjournalvouchersdocno(val);
							setTxttrno(Integer.parseInt(request.getAttribute("tranno").toString()));
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
		
		else if(mode.equalsIgnoreCase("EDIT")){
			String mainBranch=session.getAttribute("BRANCHID").toString().trim();
			/*Updating Ib-Journal Voucher Grid*/
			ArrayList<String> ibjournalvouchersarray= new ArrayList<>();
			for(int i=0;i<getGridlength();i++){
				ClsIbJournalVouchersBean ibjournalvouchersbean=new ClsIbJournalVouchersBean();
				String temp=requestParams.get("test"+i)[0]+"::"+mainBranch;
				ibjournalvouchersarray.add(temp);
			}
			/*Updating Ib-Journal Voucher Grid Ends*/
			
			boolean Status=ibJournalVouchersDAO.edit(getTxtibjournalvouchersdocno(),getFormdetailcode(), ibJournalVouchersDate, getTxtrefno(), getTxtdescription(), getTxttrno(), getTxtdrtotal(), getTxtcrtotal(),ibjournalvouchersarray,session,mode);
			if(Status){
				setTxtibjournalvouchersdocno(getTxtibjournalvouchersdocno());
				setTxttrno(getTxttrno());
				setData();
				
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setTxtibjournalvouchersdocno(getTxtibjournalvouchersdocno());
				setTxttrno(getTxttrno());
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("E")){

			boolean Status=ibJournalVouchersDAO.editMaster(getTxtibjournalvouchersdocno(),getFormdetailcode(), ibJournalVouchersDate, getTxtrefno(), getTxtdescription(),getTxttrno(), getTxtdrtotal(), getTxtcrtotal(),session);
			if(Status){
				setTxtibjournalvouchersdocno(getTxtibjournalvouchersdocno());
				setTxttrno(getTxttrno());
				setData();
				
				setMsg("Updated Successfully");
			    return "success";
		}
		else{
			setTxtibjournalvouchersdocno(getTxtibjournalvouchersdocno());
			setTxttrno(getTxttrno());
			setData();
			setMsg("Not Updated");
			return "fail";
		}
	  }
		
		else if(mode.equalsIgnoreCase("D")){
			String mainBranch=session.getAttribute("BRANCHID").toString().trim();
			/*Updating Ib-Journal Voucher Grid*/
			ArrayList<String> ibjournalvouchersarray= new ArrayList<>();
			for(int i=0;i<getGridlength();i++){
				ClsIbJournalVouchersBean ibjournalvouchersbean=new ClsIbJournalVouchersBean();
				String temp=requestParams.get("test"+i)[0]+"::"+mainBranch;
				ibjournalvouchersarray.add(temp);
			}
			/*Updating Ib-Journal Voucher Grid Ends*/
			
			boolean Status=ibJournalVouchersDAO.delete(getTxtibjournalvouchersdocno(),getFormdetailcode(), getTxttrno(),session);
			if(Status){
				setTxtibjournalvouchersdocno(getTxtibjournalvouchersdocno());
				setTxttrno(getTxttrno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setTxtibjournalvouchersdocno(getTxtibjournalvouchersdocno());
				setTxttrno(getTxttrno());
				setData();
				setMsg("Not Deleted");
				return "fail";
			   }
			}
		
		else if(mode.equalsIgnoreCase("View")){
			
			ibJournalVouchersBean=ibJournalVouchersDAO.getViewDetails(getBrchName(),getTxtibjournalvouchersdocno());
			
			setJqxIbJournalVouchersDate(ibJournalVouchersBean.getJqxIbJournalVouchersDate());
			setTxtrefno(ibJournalVouchersBean.getTxtrefno());
			setTxtdescription(ibJournalVouchersBean.getTxtdescription());
			setTxtdrtotal(ibJournalVouchersBean.getTxtdrtotal());
			setTxtcrtotal(ibJournalVouchersBean.getTxtcrtotal());
			setTxttrno(ibJournalVouchersBean.getTxttrno());
			setLblformposted(ibJournalVouchersBean.getLblformposted());
			setMaindate(ibJournalVouchersBean.getMaindate());
			setFormdetailcode(ibJournalVouchersBean.getFormdetailcode());
			
			return "success";
		}
		
		return "fail";
   }
	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		int docno=Integer.parseInt(request.getParameter("docno"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		int header=Integer.parseInt(request.getParameter("header"));
		ibJournalVouchersBean=ibJournalVouchersDAO.getPrint(request,docno,branch,header);
		
		setUrl(commonDAO.getPrintPath("IJV"));
		setLblcompname(ibJournalVouchersBean.getLblcompname());
		setLblcompaddress(ibJournalVouchersBean.getLblcompaddress());
		setLblpobox(ibJournalVouchersBean.getLblpobox());
		setLblprintname(ibJournalVouchersBean.getLblprintname());
		setLblcomptel(ibJournalVouchersBean.getLblcomptel());
		setLblcompfax(ibJournalVouchersBean.getLblcompfax());
		setLblbranch(ibJournalVouchersBean.getLblbranch());
		setLbllocation(ibJournalVouchersBean.getLbllocation());
		setLblpan(ibJournalVouchersBean.getLblpan());
		setLblcstno(ibJournalVouchersBean.getLblcstno());
		setLbldate(ibJournalVouchersBean.getLbldate());
		setLbldate(ibJournalVouchersBean.getLbldate());
		setLblvoucherno(ibJournalVouchersBean.getLblvoucherno());
		setLblrefno(ibJournalVouchersBean.getLblrefno());
		setLblnetamount(ibJournalVouchersBean.getLblnetamount());
		setLblnetamountwords(ibJournalVouchersBean.getLblnetamountwords());
		setLbldescription(ibJournalVouchersBean.getLbldescription());
		setLbldebittotal(ibJournalVouchersBean.getLbldebittotal());
		setLblcredittotal(ibJournalVouchersBean.getLblcredittotal());
		setLblpreparedby(ibJournalVouchersBean.getLblpreparedby());
		setLblpreparedon(ibJournalVouchersBean.getLblpreparedon());
		setLblpreparedat(ibJournalVouchersBean.getLblpreparedat());
		
		// for hide
		setFirstarray(ibJournalVouchersBean.getFirstarray());
		setTxtheader(ibJournalVouchersBean.getTxtheader());
	
		return "print";
	}
	
	public void setData(){
		setHidjqxIbJournalVouchersDate(ibJournalVouchersDate.toString());
		setHidmaindate(hidibJournalVouchersDate.toString());
		setTxtrefno(getTxtrefno());
		setTxtdescription(getTxtdescription());
		setTxtdrtotal(getTxtdrtotal());
		setTxtcrtotal(getTxtcrtotal());
		setFormdetailcode(getFormdetailcode());
	}
}

