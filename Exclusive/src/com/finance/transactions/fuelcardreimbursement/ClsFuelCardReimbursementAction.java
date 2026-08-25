package com.finance.transactions.fuelcardreimbursement;

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
public class ClsFuelCardReimbursementAction extends ActionSupport{

	ClsCommon commonDAO= new ClsCommon();
	ClsFuelCardReimbursementDAO fuelCardReimbursementDAO= new ClsFuelCardReimbursementDAO();
	ClsFuelCardReimbursementBean fuelCardReimbursementBean;

	private int txtfuelcardreimbursementdocno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String jqxFuelCardReimbursementDate;
	private String hidjqxFuelCardReimbursementDate;
	private String txtrefno;
	private int txtdocno;
	private String txtaccid;
	private String txtaccname;
	private String cmbcurrency;
	private String hidcmbcurrency;
	private double txtrate;
	private double txtamount;
	private double txtbaseamount;
	private String txtdescription;
	private int txttrno;
	private int txttranid;
	private String hidcurrencytype;
	
	private String maindate;
	private String hidmaindate;
	
	private String url;
		
	//Fuel Card Reimbursement Grid
	private int gridlength;
	
	//Print
	private String lblmainname;
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
	
	private String lblname;
	private String lblvoucherno;
	private String lbldescription;
	private String lbldate;
	private String lblrefno;
	private String lblnetamount;
	private String lblnetamountwords;
	private String lbldebittotal;
	private String lblcredittotal;
	private String lblpreparedby;
	private String lblpreparedon;
	private String lblpreparedat;

	//for hide
	private int firstarray;
	private int txtheader;
    
	public int getTxtfuelcardreimbursementdocno() {
		return txtfuelcardreimbursementdocno;
	}

	public void setTxtfuelcardreimbursementdocno(int txtfuelcardreimbursementdocno) {
		this.txtfuelcardreimbursementdocno = txtfuelcardreimbursementdocno;
	}

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

	public String getJqxFuelCardReimbursementDate() {
		return jqxFuelCardReimbursementDate;
	}

	public void setJqxFuelCardReimbursementDate(String jqxFuelCardReimbursementDate) {
		this.jqxFuelCardReimbursementDate = jqxFuelCardReimbursementDate;
	}

	public String getHidjqxFuelCardReimbursementDate() {
		return hidjqxFuelCardReimbursementDate;
	}

	public void setHidjqxFuelCardReimbursementDate(
			String hidjqxFuelCardReimbursementDate) {
		this.hidjqxFuelCardReimbursementDate = hidjqxFuelCardReimbursementDate;
	}

	public String getTxtrefno() {
		return txtrefno;
	}

	public void setTxtrefno(String txtrefno) {
		this.txtrefno = txtrefno;
	}

	public int getTxtdocno() {
		return txtdocno;
	}

	public void setTxtdocno(int txtdocno) {
		this.txtdocno = txtdocno;
	}

	public String getTxtaccid() {
		return txtaccid;
	}

	public void setTxtaccid(String txtaccid) {
		this.txtaccid = txtaccid;
	}

	public String getTxtaccname() {
		return txtaccname;
	}

	public void setTxtaccname(String txtaccname) {
		this.txtaccname = txtaccname;
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

	public double getTxtrate() {
		return txtrate;
	}

	public void setTxtrate(double txtrate) {
		this.txtrate = txtrate;
	}

	public double getTxtamount() {
		return txtamount;
	}

	public void setTxtamount(double txtamount) {
		this.txtamount = txtamount;
	}

	public double getTxtbaseamount() {
		return txtbaseamount;
	}

	public void setTxtbaseamount(double txtbaseamount) {
		this.txtbaseamount = txtbaseamount;
	}

	public String getTxtdescription() {
		return txtdescription;
	}

	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}

	public int getTxttrno() {
		return txttrno;
	}

	public void setTxttrno(int txttrno) {
		this.txttrno = txttrno;
	}

	public int getTxttranid() {
		return txttranid;
	}

	public void setTxttranid(int txttranid) {
		this.txttranid = txttranid;
	}

	public String getHidcurrencytype() {
		return hidcurrencytype;
	}

	public void setHidcurrencytype(String hidcurrencytype) {
		this.hidcurrencytype = hidcurrencytype;
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

	public String getLblmainname() {
		return lblmainname;
	}

	public void setLblmainname(String lblmainname) {
		this.lblmainname = lblmainname;
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

	public void setLbllocation(String lbllocation) {
		this.lbllocation = lbllocation;
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

	public String getLblname() {
		return lblname;
	}

	public void setLblname(String lblname) {
		this.lblname = lblname;
	}

	public String getLblvoucherno() {
		return lblvoucherno;
	}

	public void setLblvoucherno(String lblvoucherno) {
		this.lblvoucherno = lblvoucherno;
	}

	public String getLbldescription() {
		return lbldescription;
	}

	public void setLbldescription(String lbldescription) {
		this.lbldescription = lbldescription;
	}

	public String getLbldate() {
		return lbldate;
	}

	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
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

	java.sql.Date fuelCardReimbursementDate;
	java.sql.Date hidfuelCardReimbursementDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsFuelCardReimbursementBean bean = new ClsFuelCardReimbursementBean();
		fuelCardReimbursementDate = commonDAO.changeStringtoSqlDate(getJqxFuelCardReimbursementDate());
		hidfuelCardReimbursementDate = commonDAO.changeStringtoSqlDate(getMaindate());
		
		if(mode.equalsIgnoreCase("A")){
			/*Fuel Card Reimbursement Grid Saving*/
			ArrayList<String> fuelcardreimbursementarray= new ArrayList<String>();
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				fuelcardreimbursementarray.add(temp);
			}
			/*Fuel Card Reimbursement Grid Saving Ends*/
			
						int val=fuelCardReimbursementDAO.insert(fuelCardReimbursementDate,getFormdetailcode(),getTxtrefno(),getTxtdocno(),getCmbcurrency(),getTxtrate(),getTxtamount(),getTxtdescription(),getTxtbaseamount(),fuelcardreimbursementarray,session,request,mode);
						if(val>0.0){
							
							setTxtfuelcardreimbursementdocno(val);
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
			/*Updating Fuel Card Reimbursement Grid*/
			ArrayList<String> fuelcardreimbursementarray= new ArrayList<String>();
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				fuelcardreimbursementarray.add(temp);
			}
			/*Updating Fuel Card Reimbursement Grid Ends*/
					
			boolean Status=fuelCardReimbursementDAO.edit(getTxtfuelcardreimbursementdocno(),getFormdetailcode(),fuelCardReimbursementDate,getTxtrefno(),getTxtdocno(),getCmbcurrency(),getTxtrate(),getTxtamount(),getTxtdescription(),getTxtbaseamount(),getTxttrno(),fuelcardreimbursementarray,session,mode);
			if(Status){

				setTxtfuelcardreimbursementdocno(getTxtfuelcardreimbursementdocno());
				setTxttrno(getTxttrno());
				setData();
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setTxtfuelcardreimbursementdocno(getTxtfuelcardreimbursementdocno());
				setTxttrno(getTxttrno());
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("E")){

			boolean Status=fuelCardReimbursementDAO.editMaster(getTxtfuelcardreimbursementdocno(),getFormdetailcode(),fuelCardReimbursementDate,getTxtrefno(),getTxtdescription(),getTxtrate(),getTxtamount(),getTxtdocno(),getTxttrno(),session);
			if(Status){

				setTxtfuelcardreimbursementdocno(getTxtfuelcardreimbursementdocno());
				setTxttrno(getTxttrno());
				setData();
				
				setMsg("Updated Successfully");
			    return "success";
		}
		else{
			setTxtfuelcardreimbursementdocno(getTxtfuelcardreimbursementdocno());
			setTxttrno(getTxttrno());
			setData();
			setMsg("Not Updated");
			return "fail";
		}
	  }
		
		else if(mode.equalsIgnoreCase("D")){
					
			boolean Status=fuelCardReimbursementDAO.delete(getTxtfuelcardreimbursementdocno(),getTxttrno(),getFormdetailcode(),session);
			if(Status){
				
				setTxtfuelcardreimbursementdocno(getTxtfuelcardreimbursementdocno());
				setTxttrno(getTxttrno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setData();
				setMsg("Not Deleted");
				return "fail";
			   }
			}
		
		else if(mode.equalsIgnoreCase("View")){
	
			String branch=null;
			fuelCardReimbursementBean=fuelCardReimbursementDAO.getViewDetails(session,getTxtfuelcardreimbursementdocno());
			
			setJqxFuelCardReimbursementDate(fuelCardReimbursementBean.getJqxFuelCardReimbursementDate());
			setTxtrefno(fuelCardReimbursementBean.getTxtrefno());
			
			setTxtdocno(fuelCardReimbursementBean.getTxtdocno());
			setTxtaccid(fuelCardReimbursementBean.getTxtaccid());
			setTxtaccname(fuelCardReimbursementBean.getTxtaccname());
			setHidcmbcurrency(fuelCardReimbursementBean.getHidcmbcurrency());
			setHidcurrencytype(fuelCardReimbursementBean.getHidcurrencytype());
			setTxtrate(fuelCardReimbursementBean.getTxtrate());
			setTxtamount(fuelCardReimbursementBean.getTxtamount());
			setTxtbaseamount(fuelCardReimbursementBean.getTxtbaseamount());
			setTxtdescription(fuelCardReimbursementBean.getTxtdescription());
			setTxttranid(fuelCardReimbursementBean.getTxttranid());
			setTxttrno(fuelCardReimbursementBean.getTxttrno());
			setMaindate(fuelCardReimbursementBean.getMaindate());
			setFormdetailcode(fuelCardReimbursementBean.getFormdetailcode());
			
			return "success";
		}
		return "fail";
    }
	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		int docno=Integer.parseInt(request.getParameter("docno"));
		int header=Integer.parseInt(request.getParameter("header"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		fuelCardReimbursementBean=fuelCardReimbursementDAO.getPrint(request,docno,branch,header);
		
		setLblmainname("Account Name");
		setUrl(commonDAO.getPrintPath("FCR"));
		setLblcompname(fuelCardReimbursementBean.getLblcompname());
		setLblcompaddress(fuelCardReimbursementBean.getLblcompaddress());
		setLblpobox(fuelCardReimbursementBean.getLblpobox());
		setLblprintname(fuelCardReimbursementBean.getLblprintname());
		setLblcomptel(fuelCardReimbursementBean.getLblcomptel());
		setLblcompfax(fuelCardReimbursementBean.getLblcompfax());
		setLblbranch(fuelCardReimbursementBean.getLblbranch());
		setLbllocation(fuelCardReimbursementBean.getLbllocation());
		setLblservicetax(fuelCardReimbursementBean.getLblservicetax());
		setLblpan(fuelCardReimbursementBean.getLblpan());
		setLblcstno(fuelCardReimbursementBean.getLblcstno());
		setLblname(fuelCardReimbursementBean.getLblname());
		setLblvoucherno(fuelCardReimbursementBean.getLblvoucherno());
		setLbldescription(fuelCardReimbursementBean.getLbldescription());
		setLbldate(fuelCardReimbursementBean.getLbldate());
		setLblrefno(fuelCardReimbursementBean.getLblrefno());
		setLblnetamount(fuelCardReimbursementBean.getLblnetamount());
		setLblnetamountwords(fuelCardReimbursementBean.getLblnetamountwords());
		setLbldebittotal(fuelCardReimbursementBean.getLbldebittotal());
		setLblcredittotal(fuelCardReimbursementBean.getLblcredittotal());
		setLblpreparedby(fuelCardReimbursementBean.getLblpreparedby());
		setLblpreparedon(fuelCardReimbursementBean.getLblpreparedon());
		setLblpreparedat(fuelCardReimbursementBean.getLblpreparedat());
		
		// for hide
		setFirstarray(fuelCardReimbursementBean.getFirstarray());
		setTxtheader(fuelCardReimbursementBean.getTxtheader());
	
		return "print";
	}

		public JSONArray searchDetails(HttpSession session,String partyname,String docNo,String date,String amount,String check){
			  JSONArray cellarray = new JSONArray();
			  		  JSONObject cellobj = null;
			  try {
				cellarray= fuelCardReimbursementDAO.fcrMainSearch(session, partyname, docNo, date, amount,check);
		
			  } catch (SQLException e) {
				  e.printStackTrace();
				  }
			return cellarray;
		}
		
		public void setData() {
			
			setHidjqxFuelCardReimbursementDate(fuelCardReimbursementDate.toString());
			setHidmaindate(hidfuelCardReimbursementDate.toString());
			setTxtrefno(getTxtrefno());
			
			setTxtdocno(getTxtdocno());
			setTxtaccid(getTxtaccid());
			setTxtaccname(getTxtaccname());
			setHidcmbcurrency(getCmbcurrency());
			setHidcurrencytype(getHidcurrencytype());
			setTxtrate(getTxtrate());
			setTxtamount(getTxtamount());
			setTxtbaseamount(getTxtbaseamount());
			setTxtdescription(getTxtdescription());
		
			setFormdetailcode(getFormdetailcode());
		}
}

