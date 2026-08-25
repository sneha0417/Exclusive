package com.cargo.estimation;

import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsEstimationAction {
	ClsCommon ClsCommon=new ClsCommon();
	ClsEstimationDAO DAO = new ClsEstimationDAO();

	private String estmDate,hidestmDate,cmbreftype,txtclient,txtclientname,txtaddress,txtmobile,txtemail,txtRemarks,mode,deleted,enqdtype,enqgridlenght,gridval,forradiochk,brandval,fromdatesval,todateval,txtradio,msg;
	private int refno,hidrefno,docno,masterdoc_no;
	public String getEstmDate() {
		return estmDate;
	}
	public void setEstmDate(String estmDate) {
		this.estmDate = estmDate;
	}
	public String getHidestmDate() {
		return hidestmDate;
	}
	public void setHidestmDate(String hidestmDate) {
		this.hidestmDate = hidestmDate;
	}
	public String getCmbreftype() {
		return cmbreftype;
	}
	public void setCmbreftype(String cmbreftype) {
		this.cmbreftype = cmbreftype;
	}
	public String getTxtclient() {
		return txtclient;
	}
	public void setTxtclient(String txtclient) {
		this.txtclient = txtclient;
	}
	public String getTxtclientname() {
		return txtclientname;
	}
	public void setTxtclientname(String txtclientname) {
		this.txtclientname = txtclientname;
	}
	public String getTxtaddress() {
		return txtaddress;
	}
	public void setTxtaddress(String txtaddress) {
		this.txtaddress = txtaddress;
	}
	public String getTxtmobile() {
		return txtmobile;
	}
	public void setTxtmobile(String txtmobile) {
		this.txtmobile = txtmobile;
	}
	public String getTxtemail() {
		return txtemail;
	}
	public void setTxtemail(String txtemail) {
		this.txtemail = txtemail;
	}
	public String getTxtRemarks() {
		return txtRemarks;
	}
	public void setTxtRemarks(String txtRemarks) {
		this.txtRemarks = txtRemarks;
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
	public String getEnqdtype() {
		return enqdtype;
	}
	public void setEnqdtype(String enqdtype) {
		this.enqdtype = enqdtype;
	}
	public String getEnqgridlenght() {
		return enqgridlenght;
	}
	public void setEnqgridlenght(String enqgridlenght) {
		this.enqgridlenght = enqgridlenght;
	}
	public String getGridval() {
		return gridval;
	}
	public void setGridval(String gridval) {
		this.gridval = gridval;
	}
	public String getForradiochk() {
		return forradiochk;
	}
	public void setForradiochk(String forradiochk) {
		this.forradiochk = forradiochk;
	}
	public String getBrandval() {
		return brandval;
	}
	public void setBrandval(String brandval) {
		this.brandval = brandval;
	}
	public String getFromdatesval() {
		return fromdatesval;
	}
	public void setFromdatesval(String fromdatesval) {
		this.fromdatesval = fromdatesval;
	}
	public String getTodateval() {
		return todateval;
	}
	public void setTodateval(String todateval) {
		this.todateval = todateval;
	}
	public String getTxtradio() {
		return txtradio;
	}
	public void setTxtradio(String txtradio) {
		this.txtradio = txtradio;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public int getRefno() {
		return refno;
	}
	public void setRefno(int refno) {
		this.refno = refno;
	}
	
	public int getHidrefno() {
		return hidrefno;
	}
	public void setHidrefno(int hidrefno) {
		this.hidrefno = hidrefno;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	
	//print
	private String url;
	private String lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblcompemail,lblbranchtrno,lblprintname,lbllocation;
	private String lblclientname,lbladdress,lblmobile,lbldocno,lbldate,lblenquiryno,lblremarks;
	
	public String getLblprintname() {
		return lblprintname;
	}
	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}
	public String getLblcompname() {
		return lblcompname;
	}
	public void setLblcompname(String lblcompname) {
		this.lblcompname = lblcompname;
	}
	public String getLbllocation() {
		return lbllocation;
	}
	public void setLbllocation(String lbllocation) {
		this.lbllocation = lbllocation;
	}
	public String getLblcompaddress() {
		return lblcompaddress;
	}
	public void setLblcompaddress(String lblcompaddress) {
		this.lblcompaddress = lblcompaddress;
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
	public String getLblcompemail() {
		return lblcompemail;
	}
	public void setLblcompemail(String lblcompemail) {
		this.lblcompemail = lblcompemail;
	}
	public String getLblbranchtrno() {
		return lblbranchtrno;
	}
	public void setLblbranchtrno(String lblbranchtrno) {
		this.lblbranchtrno = lblbranchtrno;
	}
	public String getLblclientname() {
		return lblclientname;
	}
	public void setLblclientname(String lblclientname) {
		this.lblclientname = lblclientname;
	}
	public String getLbladdress() {
		return lbladdress;
	}
	public void setLbladdress(String lbladdress) {
		this.lbladdress = lbladdress;
	}
	public String getLblmobile() {
		return lblmobile;
	}
	public void setLblmobile(String lblmobile) {
		this.lblmobile = lblmobile;
	}
	public String getLbldocno() {
		return lbldocno;
	}
	public void setLbldocno(String lbldocno) {
		this.lbldocno = lbldocno;
	}
	public String getLbldate() {
		return lbldate;
	}
	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}
	public String getLblenquiryno() {
		return lblenquiryno;
	}
	public void setLblenquiryno(String lblenquiryno) {
		this.lblenquiryno = lblenquiryno;
	}
	public String getLblremarks() {
		return lblremarks;
	}
	public void setLblremarks(String lblremarks) {
		this.lblremarks = lblremarks;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	////
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getEstmDate());

		if(mode.equalsIgnoreCase("A")){
			int val = DAO.insert(masterdate,getCmbreftype(),getHidrefno(),getTxtclient(),getTxtclientname(),getTxtaddress(),getTxtmobile(),getTxtemail(),getTxtRemarks(),getMode(),getDeleted(),getEnqdtype(),getEnqgridlenght(),getGridval(),getForradiochk(),getBrandval(),getFromdatesval(),getTodateval(),getTxtradio(),getMsg(),session,request);
			int vdocno=(int) request.getAttribute("vocno");
			if(val>0)
			{
				setData(masterdate);
				setDocno(vdocno);
				setMasterdoc_no(val);
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setData(masterdate);
				setMsg("Not Saved");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("E")){
			boolean status=DAO.edit(getMasterdoc_no(), masterdate, getCmbreftype(),getHidrefno(), getTxtclient(), getTxtclientname(), getTxtaddress(),
					getTxtmobile(), getTxtemail(), getTxtRemarks(), getMode(), getDeleted(), getEnqdtype(), getEnqgridlenght(), getGridval(), getForradiochk(),
					getBrandval(), getFromdatesval(), getTodateval(), getTxtradio(), getMsg(), session, request);
			if(status){
				setData(masterdate);
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setData(masterdate);
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			boolean Status=DAO.delete(getMasterdoc_no(),session,getMode());
			if(Status){
				
				
			}
		}
		
		return "success";
	}
	
	public void setData(Date masterdate) {
//		setEstmDate(getEstmDate());
		setHidestmDate(masterdate.toString());
		//System.out.println("--date--  "+getEstmDate()+"  |||  "+getHidestmDate());
		setCmbreftype(getCmbreftype());
		setTxtclient(getTxtclient());
		setTxtclientname(getTxtclientname());
		setTxtaddress(getTxtaddress());
		setTxtmobile(getTxtmobile());
		setTxtemail(getTxtemail());
		setTxtRemarks(getTxtRemarks());
		setMode(getMode());
		setDeleted(getDeleted());
		setEnqdtype(getEnqdtype());
		setEnqgridlenght(getEnqgridlenght());
		setGridval(getGridval());
		setForradiochk(getForradiochk());
		setBrandval(getBrandval());
		setFromdatesval(getFromdatesval());
		setTodateval(getTodateval());
		setTxtradio(getTxtradio());
		setMsg(getMsg());
		setRefno(getRefno());
		setHidrefno(getHidrefno());
		setDocno(getDocno());
		setMasterdoc_no(getMasterdoc_no());
	}
	
	public String printAction() throws ParseException, SQLException{
		
		  HttpServletRequest request=ServletActionContext.getRequest();
		  HttpSession session=request.getSession();
		  int doc=Integer.parseInt(request.getParameter("docno"));
		  ClsEstimationBean bean=new ClsEstimationBean();
		  String dtype=request.getParameter("dtype");
		  
		  bean=DAO.getPrint(docno,request,session);
		  setUrl(ClsCommon.getPrintPath(dtype));
		  setLbldate(bean.getLbldate());
		 setLblcompname(bean.getLblcompname());
		 setLblcompaddress(bean.getLblcompaddress());
		 setLblcomptel(bean.getLblcomptel());
		 setLblcompfax(bean.getLblcompfax());
		setLblprintname("ESTIMATION");
		setLblbranchtrno(bean.getLblbranchtrno());
		setLbllocation(bean.getLbllocation());
		
		setLblclientname(bean.getLblclientname());
		setLbladdress(bean.getLbladdress());
		setLblmobile(bean.getLblmobile());
		setLbldocno(bean.getLbldocno());
		setLbldate(bean.getLbldate());
		setLblenquiryno(bean.getLblenquiryno());
		
		 
		  return "print";
	}
}
