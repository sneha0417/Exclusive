package com.humanresource.transactions.termination;

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
public class ClsTerminationAction extends ActionSupport{

	ClsCommon ClsCommon=new ClsCommon();

	ClsTerminationDAO terminationDAO= new ClsTerminationDAO();
	ClsTerminationBean terminationBean;

	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String brchName;
	private String terminationDate;
	private String hidterminationDate;
	private int txtterminationdocno;
	private String txtemployeeid;
	private String txtemployeename;
	private int txtemployeedocno;
	private String txtemployeedesignation;
	private String txtemployeedepartment;
	private String txtemployeecategory;
	private String notifyDate;
	private String hidnotifyDate;
	private String joiningDate;
	private String hidjoiningDate;
	private String appraisalDate;
	private String hidappraisalDate;
	/*type= termination or resignation*/
	private String cmbtype;
	private String hidcmbtype;
	
	public String getHidcmbtype() {
		return hidcmbtype;
	}

	public void setHidcmbtype(String hidcmbtype) {
		this.hidcmbtype = hidcmbtype;
	}

	public String getCmbtype() {
		return cmbtype;
	}

	public void setCmbtype(String cmbtype) {
		this.cmbtype = cmbtype;
	}
	/* type end*/
	private double txtdrtotal;
	private double txtcrtotal;
	private int txttrno;
	
	//Termination Details Grid 
	private int gridlength;
	
	//Account Details Grid
	private int journalsgridlength;
	
	//Account Details Grid
	private int journalgridlength;

    private String url;
	
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
	
	private String lblvoucherno;
	private String lbldate;
	private String lblemployeeid;
	private String lblemployeename;
	private String lbldesignation;
	private String lbldepartment;
	private String lblcategory;
	private String lbldateofjoin;
	private String lblappraisaldt;
	private String lblnotifydate;
	private String lbldebittotal;
	private String lblcredittotal;
	private String lblpreparedby;
	private String lblpreparedon;
	private String lblpreparedat;

	//for hide
	private int firstarray;
	private int secarray;
	private int txtheader;
	
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

	public String getBrchName() {
		return brchName;
	}

	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}

	public String getTerminationDate() {
		return terminationDate;
	}

	public void setTerminationDate(String terminationDate) {
		this.terminationDate = terminationDate;
	}

	public String getHidterminationDate() {
		return hidterminationDate;
	}

	public void setHidterminationDate(String hidterminationDate) {
		this.hidterminationDate = hidterminationDate;
	}

	public int getTxtterminationdocno() {
		return txtterminationdocno;
	}

	public void setTxtterminationdocno(int txtterminationdocno) {
		this.txtterminationdocno = txtterminationdocno;
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

	public int getTxtemployeedocno() {
		return txtemployeedocno;
	}

	public void setTxtemployeedocno(int txtemployeedocno) {
		this.txtemployeedocno = txtemployeedocno;
	}

	public String getTxtemployeedesignation() {
		return txtemployeedesignation;
	}

	public void setTxtemployeedesignation(String txtemployeedesignation) {
		this.txtemployeedesignation = txtemployeedesignation;
	}

	public String getTxtemployeedepartment() {
		return txtemployeedepartment;
	}

	public void setTxtemployeedepartment(String txtemployeedepartment) {
		this.txtemployeedepartment = txtemployeedepartment;
	}

	public String getTxtemployeecategory() {
		return txtemployeecategory;
	}

	public void setTxtemployeecategory(String txtemployeecategory) {
		this.txtemployeecategory = txtemployeecategory;
	}

	public String getNotifyDate() {
		return notifyDate;
	}

	public void setNotifyDate(String notifyDate) {
		this.notifyDate = notifyDate;
	}

	public String getHidnotifyDate() {
		return hidnotifyDate;
	}

	public void setHidnotifyDate(String hidnotifyDate) {
		this.hidnotifyDate = hidnotifyDate;
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

	public String getAppraisalDate() {
		return appraisalDate;
	}

	public void setAppraisalDate(String appraisalDate) {
		this.appraisalDate = appraisalDate;
	}

	public String getHidappraisalDate() {
		return hidappraisalDate;
	}

	public void setHidappraisalDate(String hidappraisalDate) {
		this.hidappraisalDate = hidappraisalDate;
	}

	public double getTxtdrtotal() {
		return txtdrtotal;
	}

	public void setTxtdrtotal(double txtdrtotal) {
		this.txtdrtotal = txtdrtotal;
	}

	public double getTxtcrtotal() {
		return txtcrtotal;
	}

	public void setTxtcrtotal(double txtcrtotal) {
		this.txtcrtotal = txtcrtotal;
	}

	public int getTxttrno() {
		return txttrno;
	}

	public void setTxttrno(int txttrno) {
		this.txttrno = txttrno;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	
	public int getJournalsgridlength() {
		return journalsgridlength;
	}

	public void setJournalsgridlength(int journalsgridlength) {
		this.journalsgridlength = journalsgridlength;
	}

	public int getJournalgridlength() {
		return journalgridlength;
	}

	public void setJournalgridlength(int journalgridlength) {
		this.journalgridlength = journalgridlength;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
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

	public String getLblvoucherno() {
		return lblvoucherno;
	}

	public void setLblvoucherno(String lblvoucherno) {
		this.lblvoucherno = lblvoucherno;
	}

	public String getLbldate() {
		return lbldate;
	}

	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}

	public String getLblemployeeid() {
		return lblemployeeid;
	}

	public void setLblemployeeid(String lblemployeeid) {
		this.lblemployeeid = lblemployeeid;
	}

	public String getLblemployeename() {
		return lblemployeename;
	}

	public void setLblemployeename(String lblemployeename) {
		this.lblemployeename = lblemployeename;
	}

	public String getLbldesignation() {
		return lbldesignation;
	}

	public void setLbldesignation(String lbldesignation) {
		this.lbldesignation = lbldesignation;
	}

	public String getLbldepartment() {
		return lbldepartment;
	}

	public void setLbldepartment(String lbldepartment) {
		this.lbldepartment = lbldepartment;
	}

	public String getLblcategory() {
		return lblcategory;
	}

	public void setLblcategory(String lblcategory) {
		this.lblcategory = lblcategory;
	}

	public String getLbldateofjoin() {
		return lbldateofjoin;
	}

	public void setLbldateofjoin(String lbldateofjoin) {
		this.lbldateofjoin = lbldateofjoin;
	}

	public String getLblappraisaldt() {
		return lblappraisaldt;
	}

	public void setLblappraisaldt(String lblappraisaldt) {
		this.lblappraisaldt = lblappraisaldt;
	}

	public String getLblnotifydate() {
		return lblnotifydate;
	}

	public void setLblnotifydate(String lblnotifydate) {
		this.lblnotifydate = lblnotifydate;
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

	public int getSecarray() {
		return secarray;
	}

	public void setSecarray(int secarray) {
		this.secarray = secarray;
	}

	public int getTxtheader() {
		return txtheader;
	}

	public void setTxtheader(int txtheader) {
		this.txtheader = txtheader;
	}


	java.sql.Date terminationsDate;
	java.sql.Date notifyingDate;
	java.sql.Date joinedDate;
	java.sql.Date lastAppraisalDate;
	
	public String saveAction() throws ParseException, SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsTerminationBean bean = new ClsTerminationBean();

		terminationsDate = ClsCommon.changeStringtoSqlDate(getTerminationDate());
		notifyingDate = ClsCommon.changeStringtoSqlDate(getNotifyDate());
		joinedDate = ClsCommon.changeStringtoSqlDate(getJoiningDate());
		lastAppraisalDate = ClsCommon.changeStringtoSqlDate(getAppraisalDate());
		
		if(mode.equalsIgnoreCase("A")){
			
			/*Termination Details Grid*/
			ArrayList<String> employeedetailsarray= new ArrayList<>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				employeedetailsarray.add(temp);
			}
			/*Termination Details Grid Ends*/
			
			/*Account Grid*/
			ArrayList<String> accountsarray= new ArrayList<>();
			for(int i=0;i<getJournalsgridlength();i++){
				String temp1=requestParams.get("journals"+i)[0];
				accountsarray.add(temp1);
			}
			/*Account Grid Ends*/
			
			/*Journal Voucher Grid*/
			ArrayList<String> journalvouchersarray= new ArrayList<>();
			for(int i=0;i<getJournalgridlength();i++){
				String temp2=requestParams.get("journal"+i)[0];
				journalvouchersarray.add(temp2);
			}
			/*Journal Voucher Grid Ends*/
			
			int val=terminationDAO.insert(getFormdetailcode(),getBrchName(),terminationsDate,getTxtemployeedocno(),notifyingDate,joinedDate,lastAppraisalDate,getTxtdrtotal(),employeedetailsarray,accountsarray,journalvouchersarray,getCmbtype(),session,request,mode);
			if(val>0.0){
				
				setTxtterminationdocno(val);
				setTxttrno(Integer.parseInt(request.getAttribute("tranno").toString()));
				setData();
				
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setMsg("Not Saved");
				return "fail";
			}	
		} else if(mode.equalsIgnoreCase("View")){
	
			String branch=null;
			terminationBean=terminationDAO.getViewDetails(session,getTxtterminationdocno());
			
			setTerminationDate(terminationBean.getTerminationDate());
			setTxtemployeedocno(terminationBean.getTxtemployeedocno());
			setTxtemployeeid(terminationBean.getTxtemployeeid());
			setTxtemployeename(terminationBean.getTxtemployeename());
			setTxtemployeedesignation(terminationBean.getTxtemployeedesignation());
			setTxtemployeedepartment(terminationBean.getTxtemployeedepartment());
			setTxtemployeecategory(terminationBean.getTxtemployeecategory());
			setNotifyDate(terminationBean.getNotifyDate());
			setJoiningDate(terminationBean.getJoiningDate());
			setAppraisalDate(terminationBean.getAppraisalDate());
			setTxtdrtotal(terminationBean.getTxtdrtotal());
			setTxtcrtotal(terminationBean.getTxtcrtotal());
			setTxttrno(terminationBean.getTxttrno());
			setHidcmbtype(terminationBean.getCmbtype());
			
			setFormdetailcode(terminationBean.getFormdetailcode());
			
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
		terminationBean=terminationDAO.getPrint(request,docno,branch,header);
		
		setUrl(ClsCommon.getPrintPath("HTRE"));
		setLblcompname(terminationBean.getLblcompname());
		setLblcompaddress(terminationBean.getLblcompaddress());
		setLblpobox(terminationBean.getLblpobox());
		setLblprintname(terminationBean.getLblprintname());
		setLblcomptel(terminationBean.getLblcomptel());
		setLblcompfax(terminationBean.getLblcompfax());
		setLblbranch(terminationBean.getLblbranch());
		setLbllocation(terminationBean.getLbllocation());
		setLblservicetax(terminationBean.getLblservicetax());
		setLblpan(terminationBean.getLblpan());
		setLblcstno(terminationBean.getLblcstno());
		setLblvoucherno(terminationBean.getLblvoucherno());
		setLbldate(terminationBean.getLbldate());
		setLblemployeeid(terminationBean.getLblemployeeid());
		setLblemployeename(terminationBean.getLblemployeename());
		setLbldesignation(terminationBean.getLbldesignation());
		setLbldepartment(terminationBean.getLbldepartment());
		setLblcategory(terminationBean.getLblcategory());
		setLbldateofjoin(terminationBean.getLbldateofjoin());
		setLblappraisaldt(terminationBean.getLblappraisaldt());
		setLblnotifydate(terminationBean.getLblnotifydate());
		setLbldebittotal(terminationBean.getLbldebittotal());
		setLblcredittotal(terminationBean.getLblcredittotal());
		setLblpreparedby(terminationBean.getLblpreparedby());
		setLblpreparedon(terminationBean.getLblpreparedon());
		setLblpreparedat(terminationBean.getLblpreparedat());
		
		// for hide
		setFirstarray(terminationBean.getFirstarray());
		setSecarray(terminationBean.getSecarray());
		setTxtheader(terminationBean.getTxtheader());
	
		return "print";
	}

	public void setData() {

			if(terminationsDate != null){
	    	    setHidterminationDate(terminationsDate.toString());
	    	}
			setTxtemployeedocno(getTxtemployeedocno());
			setTxtemployeeid(getTxtemployeeid());
			setTxtemployeename(getTxtemployeename());
			setTxtemployeedesignation(getTxtemployeedesignation());
			setTxtemployeedepartment(getTxtemployeedepartment());
			setTxtemployeecategory(getTxtemployeecategory());
			if(notifyingDate != null){
	    	    setHidnotifyDate(notifyingDate.toString());
	    	}
			if(joinedDate != null){
	    	    setHidjoiningDate(joinedDate.toString());
	    	}
			if(lastAppraisalDate != null){
	    	    setHidappraisalDate(lastAppraisalDate.toString());
	    	}
			setTxtdrtotal(getTxtdrtotal());
			setTxtcrtotal(getTxtcrtotal());
			setHidcmbtype(getCmbtype());
			
		}
}

