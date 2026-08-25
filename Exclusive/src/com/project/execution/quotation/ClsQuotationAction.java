package com.project.execution.quotation;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.itextpdf.text.log.SysoCounter;

public class ClsQuotationAction {

	ClsCommon com=new ClsCommon();
	ClsConnection conobj=new ClsConnection();
	private String hidradio;
	private String date;
	private String hiddate;
	private String mode;
	private String msg;
	private String deleted;
	private String docno;
	private int masterdoc_no;
	private String txtrefno;
	private String formdetailcode;

	private String txtclient;
	private String txtclientdet;
	private String txttel;
	private String txtmob;
	private String txtemail;
	private int clientid;

	private String txtcontact;
	private String txtcontactdetails;
	private int cpersonid;

	private String ramc;
	private String rsjob;
	private String rdo;
	private String txtdcdamount;
	private String cmbreftype;
	private String hidcmbreftype;

	private String txtenquiry;
	private int enquiryid;

	private String txtsubject;
	private String txtclientref;

	private String txtdesc1;
	private String url;
	private String txtgrtotal;
	private String txtdisper;
	private String txtdisamt;
	private String txttotalamt;
	private String txttaxper;
	private String txttaxamt;
	private String txtnettotal;
	private String contrtype;
	private int servicelen;
	private int sitelen;
	private int termsgridlen;
	
	private ArrayList list;
	private ArrayList termlist;
	private ArrayList amclist;
	
    private String lblcompname;
    private String lblcompaddress;
    private String lblprintname;
    private String lblcomptel;
    private String lblcompfax;
    private String lblprintname1;
    private String lblbranch;
    private String lbllocation;
    private String amountwords;
    private String lblcheckedby;
    private String lblfinaldate;
    private String txtheader;
    private String txtsalman;
    private int salid;
    private String txtsalmob;
    private int id,revcheck;
    
    private String hidestamt;

    public String getHidestamt() {
		return hidestamt;
	}
	public void setHidestamt(String hidestamt) {
		this.hidestamt = hidestamt;
	}
	public int getRevcheck() {
		return revcheck;
	}
	public void setRevcheck(int revcheck) {
		this.revcheck = revcheck;
	}

	private int cmbprocess;
    
    private int hidcmbprocess;

    private String txtrevise;

   	public String getTxtrevise() {
		return txtrevise;
	}
	public void setTxtrevise(String txtrevise) {
		this.txtrevise = txtrevise;
	}
	public int getHidcmbprocess() {
   	return hidcmbprocess;
   }
   public void setHidcmbprocess(int hidcmbprocess) {
   	this.hidcmbprocess = hidcmbprocess;
   }
   	public int getCmbprocess() {
   	return cmbprocess;
   }
   public void setCmbprocess(int cmbprocess) {
   	this.cmbprocess = cmbprocess;
   }

	public String getTxtsalmob() {
		return txtsalmob;
	}
	public void setTxtsalmob(String txtsalmob) {
		this.txtsalmob = txtsalmob;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public ArrayList getAmclist() {
		return amclist;
	}
	public void setAmclist(ArrayList amclist) {
		this.amclist = amclist;
	}
	public String getTxtsalman() {
		return txtsalman;
	}
	public void setTxtsalman(String txtsalman) {
		this.txtsalman = txtsalman;
	}
	public int getSalid() {
		return salid;
	}
	public void setSalid(int salid) {
		this.salid = salid;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getHiddate() {
		return hiddate;
	}
	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public String getDocno() {
		return docno;
	}
	public void setDocno(String docno) {
		this.docno = docno;
	}
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	public String getTxtrefno() {
		return txtrefno;
	}
	public void setTxtrefno(String txtrefno) {
		this.txtrefno = txtrefno;
	}
	public String getTxtclient() {
		return txtclient;
	}
	public void setTxtclient(String txtclient) {
		this.txtclient = txtclient;
	}
	public String getTxtclientdet() {
		return txtclientdet;
	}
	public void setTxtclientdet(String txtclientdet) {
		this.txtclientdet = txtclientdet;
	}
	public String getTxttel() {
		return txttel;
	}
	public void setTxttel(String txttel) {
		this.txttel = txttel;
	}
	public String getTxtmob() {
		return txtmob;
	}
	public void setTxtmob(String txtmob) {
		this.txtmob = txtmob;
	}
	public String getTxtemail() {
		return txtemail;
	}
	public void setTxtemail(String txtemail) {
		this.txtemail = txtemail;
	}
	public int getClientid() {
		return clientid;
	}
	public void setClientid(int clientid) {
		this.clientid = clientid;
	}
	public String getTxtcontact() {
		return txtcontact;
	}
	public void setTxtcontact(String txtcontact) {
		this.txtcontact = txtcontact;
	}
	public String getTxtcontactdetails() {
		return txtcontactdetails;
	}
	public void setTxtcontactdetails(String txtcontactdetails) {
		this.txtcontactdetails = txtcontactdetails;
	}
	public int getCpersonid() {
		return cpersonid;
	}
	public void setCpersonid(int cpersonid) {
		this.cpersonid = cpersonid;
	}

	public String getTxtdcdamount() {
		return txtdcdamount;
	}
	public void setTxtdcdamount(String txtdcdamount) {
		this.txtdcdamount = txtdcdamount;
	}
	public String getCmbreftype() {
		return cmbreftype;
	}
	public void setCmbreftype(String cmbreftype) {
		this.cmbreftype = cmbreftype;
	}
	public String getHidcmbreftype() {
		return hidcmbreftype;
	}
	public void setHidcmbreftype(String hidcmbreftype) {
		this.hidcmbreftype = hidcmbreftype;
	}
	public String getTxtenquiry() {
		return txtenquiry;
	}
	public void setTxtenquiry(String txtenquiry) {
		this.txtenquiry = txtenquiry;
	}
	public int getEnquiryid() {
		return enquiryid;
	}
	public void setEnquiryid(int enquiryid) {
		this.enquiryid = enquiryid;
	}
	public String getTxtsubject() {
		return txtsubject;
	}
	public void setTxtsubject(String txtsubject) {
		this.txtsubject = txtsubject;
	}
	public String getTxtclientref() {
		return txtclientref;
	}
	public void setTxtclientref(String txtclientref) {
		this.txtclientref = txtclientref;
	}
	public String getTxtdesc1() {
		return txtdesc1;
	}
	public void setTxtdesc1(String txtdesc1) {
		this.txtdesc1 = txtdesc1;
	}
	public String getTxtgrtotal() {
		return txtgrtotal;
	}
	public void setTxtgrtotal(String txtgrtotal) {
		this.txtgrtotal = txtgrtotal;
	}
	public String getTxtdisper() {
		return txtdisper;
	}
	public void setTxtdisper(String txtdisper) {
		this.txtdisper = txtdisper;
	}

	public String getTxtdisamt() {
		return txtdisamt;
	}
	public void setTxtdisamt(String txtdisamt) {
		this.txtdisamt = txtdisamt;
	}
	public String getTxttotalamt() {
		return txttotalamt;
	}
	public void setTxttotalamt(String txttotalamt) {
		this.txttotalamt = txttotalamt;
	}
	public String getTxttaxper() {
		return txttaxper;
	}
	public void setTxttaxper(String txttaxper) {
		this.txttaxper = txttaxper;
	}
	public String getTxttaxamt() {
		return txttaxamt;
	}
	public void setTxttaxamt(String txttaxamt) {
		this.txttaxamt = txttaxamt;
	}
	public String getTxtnettotal() {
		return txtnettotal;
	}
	public void setTxtnettotal(String txtnettotal) {
		this.txtnettotal = txtnettotal;
	}

	public int getServicelen() {
		return servicelen;
	}
	public void setServicelen(int servicelen) {
		this.servicelen = servicelen;
	}
	public int getSitelen() {
		return sitelen;
	}
	public void setSitelen(int sitelen) {
		this.sitelen = sitelen;
	}
	public int getTermsgridlen() {
		return termsgridlen;
	}
	public void setTermsgridlen(int termsgridlen) {
		this.termsgridlen = termsgridlen;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getRamc() {
		return ramc;
	}
	public void setRamc(String ramc) {
		this.ramc = ramc;
	}
	public String getRsjob() {
		return rsjob;
	}
	public void setRsjob(String rsjob) {
		this.rsjob = rsjob;
	}

	public String getRdo() {
		return rdo;
	}
	public void setRdo(String rdo) {
		this.rdo = rdo;
	}
	public String getHidradio() {
		return hidradio;
	}
	public void setHidradio(String hidradio) {
		this.hidradio = hidradio;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	public ArrayList getList() {
		return list;
	}
	public void setList(ArrayList list) {
		this.list = list;
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
	public String getLblprintname1() {
		return lblprintname1;
	}
	public void setLblprintname1(String lblprintname1) {
		this.lblprintname1 = lblprintname1;
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
	public String getAmountwords() {
		return amountwords;
	}
	public void setAmountwords(String amountwords) {
		this.amountwords = amountwords;
	}
	public String getLblcheckedby() {
		return lblcheckedby;
	}
	public void setLblcheckedby(String lblcheckedby) {
		this.lblcheckedby = lblcheckedby;
	}
	public String getLblfinaldate() {
		return lblfinaldate;
	}
	public void setLblfinaldate(String lblfinaldate) {
		this.lblfinaldate = lblfinaldate;
	}
	public ArrayList getTermlist() {
		return termlist;
	}
	public void setTermlist(ArrayList termlist) {
		this.termlist = termlist;
	}
	public String getContrtype() {
		return contrtype;
	}
	public void setContrtype(String contrtype) {
		this.contrtype = contrtype;
	}
	public String getTxtheader() {
		return txtheader;
	}
	public void setTxtheader(String txtheader) {
		this.txtheader = txtheader;
	}
	
private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	private String sitequery;
	public String getSitequery() {
		return sitequery;
	}
	public void setSitequery(String sitequery) {
		this.sitequery = sitequery;
	}
	public String saveQotAction(){

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		String returns="",type="";
		int val=0;

//		System.out.println("inside saveaction");

		try{

			ArrayList servlist=new ArrayList();

			ArrayList sitelist=new ArrayList();

			ArrayList termslist=new ArrayList();

			


			ClsQuotationDAO DAO= new  ClsQuotationDAO();





			if(mode.equalsIgnoreCase("A")){

				java.sql.Date date=com.changeStringtoSqlDate(getDate());
				
				for(int i=0;i<getServicelen();i++){

					String temp=requestParams.get("service"+i)[0];		
					servlist.add(temp);
				}

				for(int i=0;i<getSitelen();i++){
					String temp=requestParams.get("site"+i)[0];		
					sitelist.add(temp);
				}

				/*for(int i=0;i<getTermsgridlen();i++){
					String temp=requestParams.get("termg"+i)[0];		
					termslist.add(temp);
				}*/
				
				
				val=DAO.insert(date,getTxtrefno(),getClientid(),getCpersonid(),getCmbreftype(),getEnquiryid(),getRdo(),getTxtdcdamount(),getTxtsubject(),getTxtdesc1(),
						getTxtclientref(),getTxtgrtotal(),getTxtdisper(),getTxtdisamt(),getTxttotalamt(),getTxttaxper(),getTxttaxamt(),getTxtnettotal(),getFormdetailcode(),
						mode,servlist,sitelist,termslist,session,request,getSalid(),getCmbprocess(),Integer.parseInt("0"));

				if(val>0){

					setMasterdoc_no(val);
					setDocno(request.getAttribute("vocno").toString());
					setDate(date+"");
					setHiddate(date+"");
					setClientid(getClientid());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setTxtmob(getTxtmob());
					setTxtemail(getTxtemail());
					setTxttel(getTxttel());
					setCpersonid(getCpersonid());
					setTxtcontact(getTxtcontact());
					setTxtcontactdetails(getTxtcontactdetails());
					setCmbreftype(getCmbreftype());
					setHidcmbreftype(getCmbreftype());
					setTxtdcdamount(getTxtdcdamount());
					setTxtenquiry(getTxtenquiry());
					setEnquiryid(getEnquiryid());
					//setRdo(getRdo());
					setHidradio(getRdo());
					setTxtdesc1(getTxtdesc1());
					setTxtrefno(getTxtrefno());
					setTxtsubject(getTxtsubject());
					setTxtclientref(getTxtclientref());
					setTxtgrtotal(getTxtgrtotal());
					setTxtdisamt(getTxtdisamt());
					setTxttotalamt(getTxttotalamt());
					setTxttaxper(getTxttaxper());
					setTxttaxamt(getTxttaxamt());
					setTxtnettotal(getTxtnettotal());
					setCmbprocess(getCmbprocess());
					setHidcmbprocess(getCmbprocess());
					setTxtrevise(request.getAttribute("revision").toString());
					setMsg("Successfully Saved");
					returns="success";
				}
				else{
					setDate(date+"");
					setHiddate(date+"");
					setClientid(getClientid());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setTxtmob(getTxtmob());
					setTxtemail(getTxtemail());
					setTxttel(getTxttel());
					setCpersonid(getCpersonid());
					setTxtcontact(getTxtcontact());
					setTxtcontactdetails(getTxtcontactdetails());
					setCmbreftype(getCmbreftype());
					setHidcmbreftype(getCmbreftype());
					setTxtdcdamount(getTxtdcdamount());
					setTxtenquiry(getTxtenquiry());
					setEnquiryid(getEnquiryid());
					setHidradio(getRdo());
					setTxtdesc1(getTxtdesc1());
					setTxtrefno(getTxtrefno());
					setTxtsubject(getTxtsubject());
					setTxtclientref(getTxtclientref());
					setTxtgrtotal(getTxtgrtotal());
					setTxtdisamt(getTxtdisamt());
					setTxttotalamt(getTxttotalamt());
					setTxttaxper(getTxttaxper());
					setTxttaxamt(getTxttaxamt());
					setTxtnettotal(getTxtnettotal());
					setCmbprocess(getCmbprocess());
					setHidcmbprocess(getCmbprocess());
				//	setTxtrevise("0");
					setMsg("Not Saved");
					returns="fail";
				}

			}

			if(mode.equalsIgnoreCase("E")){
				
				java.sql.Date date=com.changeStringtoSqlDate(getDate());
				
				for(int i=0;i<getServicelen();i++){

					String temp=requestParams.get("service"+i)[0];		
					servlist.add(temp);
				}

				for(int i=0;i<getSitelen();i++){
					String temp=requestParams.get("site"+i)[0];		
					sitelist.add(temp);
				}

				/*for(int i=0;i<getTermsgridlen();i++){
					String temp=requestParams.get("termg"+i)[0];		
					termslist.add(temp);
				}*/

				val=DAO.edit(getMasterdoc_no(),Integer.parseInt(getDocno()),date,getTxtrefno(),getClientid(),getCpersonid(),getCmbreftype(),getEnquiryid(),getRdo(),getTxtdcdamount(),getTxtsubject(),getTxtdesc1(),
						getTxtclientref(),getTxtgrtotal(),getTxtdisper(),getTxtdisamt(),getTxttotalamt(),getTxttaxper(),getTxttaxamt(),getTxtnettotal(),getFormdetailcode(),
						mode,servlist,sitelist,termslist,session,request,getSalid(),getCmbprocess(),Integer.parseInt(getTxtrevise()));

				if(val>0){

					setMasterdoc_no(val);
					setDocno(request.getAttribute("vocno").toString());
					setDate(date+"");
					setHiddate(date+"");
					setClientid(getClientid());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setTxtmob(getTxtmob());
					setTxtemail(getTxtemail());
					setTxttel(getTxttel());
					setCpersonid(getCpersonid());
					setTxtcontact(getTxtcontact());
					setTxtcontactdetails(getTxtcontactdetails());
					setCmbreftype(getCmbreftype());
					setHidcmbreftype(getCmbreftype());
					setTxtdcdamount(getTxtdcdamount());
					setTxtenquiry(getTxtenquiry());
					setEnquiryid(getEnquiryid());
					//setRdo(getRdo());
					setHidradio(getRdo());
					setTxtdesc1(getTxtdesc1());
					setTxtrefno(getTxtrefno());
					setTxtsubject(getTxtsubject());
					setTxtclientref(getTxtclientref());
					setTxtgrtotal(getTxtgrtotal());
					setTxtdisamt(getTxtdisamt());
					setTxttotalamt(getTxttotalamt());
					setTxttaxper(getTxttaxper());
					setTxttaxamt(getTxttaxamt());
					setTxtnettotal(getTxtnettotal());
					setCmbprocess(getCmbprocess());
					setHidcmbprocess(getCmbprocess());
					setTxtrevise(request.getAttribute("revision").toString());
					setMsg("Successfully Saved");
					returns="success";
				}
				else{
					setDate(date+"");
					setHiddate(date+"");
					setClientid(getClientid());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setTxtmob(getTxtmob());
					setTxtemail(getTxtemail());
					setTxttel(getTxttel());
					setCpersonid(getCpersonid());
					setTxtcontact(getTxtcontact());
					setTxtcontactdetails(getTxtcontactdetails());
					setCmbreftype(getCmbreftype());
					setHidcmbreftype(getCmbreftype());
					setTxtdcdamount(getTxtdcdamount());
					setTxtenquiry(getTxtenquiry());
					setEnquiryid(getEnquiryid());
					setHidradio(getRdo());
					setTxtdesc1(getTxtdesc1());
					setTxtrefno(getTxtrefno());
					setTxtsubject(getTxtsubject());
					setTxtclientref(getTxtclientref());
					setTxtgrtotal(getTxtgrtotal());
					setTxtdisamt(getTxtdisamt());
					setTxttotalamt(getTxttotalamt());
					setTxttaxper(getTxttaxper());
					setTxttaxamt(getTxttaxamt());
					setTxtnettotal(getTxtnettotal());
					setCmbprocess(getCmbprocess());
					setHidcmbprocess(getCmbprocess());
					setTxtrevise(getTxtrevise());
					setMsg("Not Saved");
					returns="fail";
				}

			}

			if(mode.equalsIgnoreCase("view")){
				java.sql.Date date=com.changeStringtoSqlDate(getDate());
				setDate(date+"");
				setHiddate(date+"");
				setTxtenquiry(getTxtenquiry());
				setEnquiryid(getEnquiryid());
				
				
				//=-----------------------------------------------------------------------------------------------------------------------//
				ClsQuotationBean bean = new ClsQuotationBean();
				
				bean=DAO.getViewDetails(session,getDocno(),session.getAttribute("BRANCHID").toString(),getMasterdoc_no()+"");
				
				System.out.println("===bean.getTxtcontact()===="+bean.getTxtcontact());
		
				setClientid(bean.getClientid());
				setTxtclient(bean.getTxtclient());
				setTxtclientdet(bean.getTxtclientdet());
				setTxtmob(bean.getTxtmob());
				setTxtemail(bean.getTxtemail());
				setTxttel(bean.getTxttel());
				setCpersonid(bean.getCpersonid());
				setTxtcontact(bean.getTxtcontact());
				setTxtcontactdetails(bean.getTxtcontactdetails());
				setCmbreftype(bean.getCmbreftype());
				setHidcmbreftype(bean.getCmbreftype());
				setTxtdcdamount(bean.getTxtdcdamount());
				setTxtenquiry(bean.getTxtenquiry());
				setEnquiryid(bean.getEnquiryid());
				setHidradio(bean.getHidradio());
				setTxtdesc1(bean.getTxtdesc1());
				setTxtrefno(bean.getTxtrefno());
				setTxtsubject(bean.getTxtsubject());
				setTxtclientref(bean.getTxtclientref());
				setTxtgrtotal(bean.getTxtgrtotal());
				setTxtdisper(bean.getTxtdisper());
				setTxtdisamt(bean.getTxtdisamt());
				setTxttotalamt(bean.getTxttotalamt());
				setTxttaxper(bean.getTxttaxper());
				setTxttaxamt(bean.getTxttaxamt());
				setTxtnettotal(bean.getTxtnettotal());
				setTxtsalman(bean.getTxtsalman());
				setSalid(bean.getSalid());
				setMasterdoc_no(bean.getMasterdoc_no());
				setTxtrefno(bean.getTxtrefno());
				setTxtrevise(bean.getTxtrevise());
				//-----------------------------------------------------------------------------------------------------------------------------//
				
				
				returns="success";
			}

			if(mode.equalsIgnoreCase("D")){

				java.sql.Date date=com.changeStringtoSqlDate(getDate());
				
				for(int i=0;i<getServicelen();i++){

					String temp=requestParams.get("service"+i)[0];		
					servlist.add(temp);
				}

				for(int i=0;i<getSitelen();i++){
					String temp=requestParams.get("site"+i)[0];		
					sitelist.add(temp);
				}

				for(int i=0;i<getTermsgridlen();i++){
					String temp=requestParams.get("termg"+i)[0];		
					termslist.add(temp);
				}

				val=DAO.delete(getMasterdoc_no(),Integer.parseInt(getDocno()),date,getTxtrefno(),getClientid(),getCpersonid(),getCmbreftype(),getEnquiryid(),getRdo(),getTxtdcdamount(),getTxtsubject(),getTxtdesc1(),
						getTxtclientref(),getTxtgrtotal(),getTxtdisper(),getTxtdisamt(),getTxttotalamt(),getTxttaxper(),getTxttaxamt(),getTxtnettotal(),getFormdetailcode(),
						mode,servlist,sitelist,termslist,session,request,getSalid());

				if(val>0){

					setMasterdoc_no(val);
					setDocno(request.getAttribute("vocno").toString());
					setDate(date+"");
					setHiddate(date+"");
					setClientid(getClientid());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setTxtmob(getTxtmob());
					setTxtemail(getTxtemail());
					setTxttel(getTxttel());
					setCpersonid(getCpersonid());
					setTxtcontact(getTxtcontact());
					setTxtcontactdetails(getTxtcontactdetails());
					setCmbreftype(getCmbreftype());
					setHidcmbreftype(getCmbreftype());
					setTxtdcdamount(getTxtdcdamount());
					setTxtenquiry(getTxtenquiry());
					setEnquiryid(getEnquiryid());
					setHidradio(getRdo());
					setTxtdesc1(getTxtdesc1());
					setTxtrefno(getTxtrefno());
					setTxtsubject(getTxtsubject());
					setTxtclientref(getTxtclientref());
					setTxtgrtotal(getTxtgrtotal());
					setTxtdisamt(getTxtdisamt());
					setTxttotalamt(getTxttotalamt());
					setTxttaxper(getTxttaxper());
					setTxttaxamt(getTxttaxamt());
					setTxtnettotal(getTxtnettotal());
					
					setDeleted("DELETED");
					setMsg("Successfully Deleted");
					returns="success";
				}
				else{
					setDate(date+"");
					setHiddate(date+"");
					setClientid(getClientid());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setTxtmob(getTxtmob());
					setTxtemail(getTxtemail());
					setTxttel(getTxttel());
					setCpersonid(getCpersonid());
					setTxtcontact(getTxtcontact());
					setTxtcontactdetails(getTxtcontactdetails());
					setCmbreftype(getCmbreftype());
					setHidcmbreftype(getCmbreftype());
					setTxtdcdamount(getTxtdcdamount());
					setTxtenquiry(getTxtenquiry());
					setEnquiryid(getEnquiryid());
					setHidradio(getRdo());
					setTxtdesc1(getTxtdesc1());
					setTxtrefno(getTxtrefno());
					setTxtsubject(getTxtsubject());
					setTxtclientref(getTxtclientref());
					setTxtgrtotal(getTxtgrtotal());
					setTxtdisamt(getTxtdisamt());
					setTxttotalamt(getTxttotalamt());
					setTxttaxper(getTxttaxper());
					setTxttaxamt(getTxttaxamt());
					setTxtnettotal(getTxtnettotal());
					setMsg("Not Deleted");
					returns="fail";
				}

			}


/*if(mode.equalsIgnoreCase("R")){
				
				java.sql.Date date=com.changeStringtoSqlDate(getDate());
				
				for(int i=0;i<getServicelen();i++){

					String temp=requestParams.get("service"+i)[0];		
					servlist.add(temp);
				}

				for(int i=0;i<getSitelen();i++){
					String temp=requestParams.get("site"+i)[0];		
					sitelist.add(temp);
				}

				for(int i=0;i<getTermsgridlen();i++){
					String temp=requestParams.get("termg"+i)[0];		
					termslist.add(temp);
				}

				val=DAO.edit(getMasterdoc_no(),Integer.parseInt(getDocno()),date,getTxtrefno(),getClientid(),getCpersonid(),getCmbreftype(),getEnquiryid(),getRdo(),getTxtdcdamount(),getTxtsubject(),getTxtdesc1(),
						getTxtclientref(),getTxtgrtotal(),getTxtdisper(),getTxtdisamt(),getTxttotalamt(),getTxttaxper(),getTxttaxamt(),getTxtnettotal(),getFormdetailcode(),
						mode,servlist,sitelist,termslist,session,request,getSalid(),getCmbprocess());

				if(val>0){

					setMasterdoc_no(val);
					setDocno(request.getAttribute("vocno").toString());
					setTxtrevise(request.getAttribute("revno").toString());
					setDate(date+"");
					setHiddate(date+"");
					setClientid(getClientid());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setTxtmob(getTxtmob());
					setTxtemail(getTxtemail());
					setTxttel(getTxttel());
					setCpersonid(getCpersonid());
					setTxtcontact(getTxtcontact());
					setTxtcontactdetails(getTxtcontactdetails());
					setCmbreftype(getCmbreftype());
					setHidcmbreftype(getCmbreftype());
					setTxtdcdamount(getTxtdcdamount());
					setTxtenquiry(getTxtenquiry());
					setEnquiryid(getEnquiryid());
					//setRdo(getRdo());
					setHidradio(getRdo());
					setTxtdesc1(getTxtdesc1());
					setTxtrefno(getTxtrefno());
					setTxtsubject(getTxtsubject());
					setTxtclientref(getTxtclientref());
					setTxtgrtotal(getTxtgrtotal());
					setTxtdisamt(getTxtdisamt());
					setTxttotalamt(getTxttotalamt());
					setTxttaxper(getTxttaxper());
					setTxttaxamt(getTxttaxamt());
					setTxtnettotal(getTxtnettotal());
					setCmbprocess(getCmbprocess());
					setHidcmbprocess(getCmbprocess());
					setMsg("Successfully Saved");
					returns="success";
				}
				else{
					setDate(date+"");
					setHiddate(date+"");
					setClientid(getClientid());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setTxtmob(getTxtmob());
					setTxtemail(getTxtemail());
					setTxttel(getTxttel());
					setCpersonid(getCpersonid());
					setTxtcontact(getTxtcontact());
					setTxtcontactdetails(getTxtcontactdetails());
					setCmbreftype(getCmbreftype());
					setHidcmbreftype(getCmbreftype());
					setTxtdcdamount(getTxtdcdamount());
					setTxtenquiry(getTxtenquiry());
					setEnquiryid(getEnquiryid());
					setHidradio(getRdo());
					setTxtdesc1(getTxtdesc1());
					setTxtrefno(getTxtrefno());
					setTxtsubject(getTxtsubject());
					setTxtclientref(getTxtclientref());
					setTxtgrtotal(getTxtgrtotal());
					setTxtdisamt(getTxtdisamt());
					setTxttotalamt(getTxttotalamt());
					setTxttaxper(getTxttaxper());
					setTxttaxamt(getTxttaxamt());
					setTxtnettotal(getTxtnettotal());
					setCmbprocess(getCmbprocess());
					setHidcmbprocess(getCmbprocess());
					setMsg("Not Saved");
					returns="fail";
				}

			}
*/



		}
		catch(Exception e){
			e.printStackTrace();
		}
		return returns;



	}
	
	
	
	public String printAction() throws ParseException, SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		ClsQuotationBean bean = new ClsQuotationBean();
		ClsQuotationDAO DAO= new  ClsQuotationDAO();
		String dtype=request.getParameter("dtype").toString();
		setUrl(com.getPrintPath(dtype));
	//	System.out.println("com.getPrintPath(dtype)=="+com.getPrintPath(dtype));
	//	String allbranch=request.getParameter("allbranch")==null?"0":request.getParameter("allbranch");
	//	String hidheader=request.getParameter("hidheader")==null?"0":request.getParameter("hidheader");
		String id=request.getParameter("id")==null?"0":request.getParameter("id");
		String docno=request.getParameter("docno").toString();
		String brhid=request.getParameter("brhid").toString();
		String trno=request.getParameter("trno").toString();
		String header=request.getParameter("header").toString();
		bean=DAO.printMaster(session,docno,brhid,trno,dtype);
		
	/*ArrayList lst=new ArrayList();
	lst=bean.getTermlist();
	String term[]=lst.get(0).toString().split("::");
	System.out.println(term[0]);
	System.out.println("lst=="+lst);*/

		
		setTxtheader(header);
		setMasterdoc_no(bean.getMasterdoc_no());
		setDocno(bean.getDocno());
		setDate(bean.getDate());
		setHiddate(bean.getDate());
		setClientid(bean.getClientid());
		setTxtclient(bean.getTxtclient());
		setTxtclientdet(bean.getTxtclientdet());
		setTxtmob(bean.getTxtmob());
		setTxtemail(bean.getTxtemail());
		setTxttel(bean.getTxttel());
		setCpersonid(bean.getCpersonid());
		setTxtcontact(bean.getTxtcontact());
		setTxtcontactdetails(bean.getTxtcontactdetails());
		setCmbreftype(bean.getCmbreftype());
		setHidcmbreftype(bean.getCmbreftype());
		setTxtdcdamount(bean.getTxtdcdamount());
		setTxtenquiry(bean.getTxtenquiry());
		setEnquiryid(bean.getEnquiryid());
		setHidradio(bean.getRdo());
		setTxtdesc1(bean.getTxtdesc1());
		setTxtrefno(bean.getTxtrefno());
		setTxtsubject(bean.getTxtsubject());
		setTxtclientref(bean.getTxtclientref());
		setTxtgrtotal(bean.getTxtgrtotal());
		setTxtdisper(bean.getTxtdisper());
		setTxtdisamt(bean.getTxtdisamt());
		setTxttotalamt(bean.getTxttotalamt());
		setTxttaxper(bean.getTxttaxper());
		setTxttaxamt(bean.getTxttaxamt());
		setTxtnettotal(bean.getTxtnettotal());
		setList(bean.getList());
		setLblbranch(bean.getLblbranch());
		setLblcompaddress(bean.getLblcompaddress());
		setLblcompfax(bean.getLblcompfax());
		setLblcomptel(bean.getLblcomptel());
		setLbllocation(bean.getLbllocation());
		setAmountwords(bean.getAmountwords());
		setLblcompname(bean.getLblcompname());
		setTxtsalman(bean.getTxtsalman());
		setTxtrefno(bean.getTxtrefno());
		setLblcheckedby(session.getAttribute("USERNAME").toString().trim());
		setLblfinaldate(bean.getLblfinaldate());
		setTxtsalmob(bean.getTxtsalmob());
		
		
		setLblprintname("QUOTATION");
		setId(Integer.parseInt(id));
		setContrtype(bean.getContrtype());
		ArrayList list=bean.getList();
		setList(list);
		ArrayList termlist=bean.getTermlist();
		setTermlist(termlist);
		ArrayList amclist=bean.getAmclist();
		setAmclist(amclist);
		request.setAttribute("QOTLIST", list);
		request.setAttribute("AMCLIST", amclist);
		request.setAttribute("TERMLIST", termlist);
		
		if(com.getPrintPath(dtype).contains(".jrxml"))
		{
		
		    HttpServletResponse response = ServletActionContext.getResponse();
			
			bean=DAO.printMaster(session,docno,brhid,trno,dtype);
			int newid=Integer.parseInt(id);
			int newheader=Integer.parseInt(header);
			
			String reportFileName = "";
			String headerimgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
	     	headerimgpath=headerimgpath.replace("\\", "\\\\");
	     
	     	String footerimgpath=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
	     	footerimgpath=footerimgpath.replace("\\", "\\\\");
			 param = new HashMap();
	 		Connection conn = null;
			 try {
		       conn = conobj.getMyConnection();
				 Statement stmt=conn.createStatement();
				 String chkprint="select method from gl_config where field_nme='fire7print' ";
	             ResultSet rs=stmt.executeQuery(chkprint);
	             String status="";
	             String headerstat,unitpricestat;
	             int head_stat=-1,unitprice_stat=-1;
	             while(rs.next()){
	            	 status=rs.getString("method");
	             }
	             
	             if(status.equalsIgnoreCase("1")){
	            	 reportFileName = "fire7quotation_amc";
	            	setUrl("com/project/execution/quotation/fire7quotation_amc.jrxml");
	            	headerstat=request.getParameter("hedderstat").toString();
	            	//unitpricestat=request.getParameter("upstat").toString();
	            	//unitprice_stat=Integer.parseInt(unitpricestat);
	            	head_stat=Integer.parseInt(headerstat);
	            	 // FIRE 7 SPECIAL
			         String qry="select @i:=@i+1 srno,a.* from(select site,s.sr_no siteid,groupname stype,g.doc_no stypeid, d.description desc1, Equips item, qty, d.Amount amount,"
			        		 +"total,u.unit as unit,unitid from cm_srvqotd d left join my_groupvals g on(d.servid=g.doc_no and grptype='service')"
			        		 +" left join cm_servsited s on(s.rowno=d.sitesrno) left join my_unitm u on(u.doc_no=d.unitid) where d.tr_no="+trno+")a,(select @i:=0)r;";
			        param.put("fire7tot",bean.getFire7total());
			         param.put("fire7amcservicequery",qry);
			         param.put("fire7_amontwords",bean.getFire7amountword());
			         param.put("telphno", bean.getF7telno());
			         param.put("mobno", bean.getF7mobno());
			         param.put("header_stat",head_stat);
			         
			        String imgpath=request.getSession().getServletContext().getRealPath("/icons/fire7headder.png");
			        imgpath=imgpath.replace("\\", "\\\\");
			         param.put("fire7headerimgpath", imgpath);
			         param.put("unitprice_stat",new Integer(newid));
			         param.put("sitedet",bean.getFire7sitedetail());
			         param.put("qotno", bean.getDocno());
	            	
	             }
	             else{
	             	
	             	if(newid==0)
	             	{
	             		reportFileName = "quotation_AMC";
	                 	
	                    param.put("id", new Integer(newid));
	                    setUrl("com/project/execution/quotation/quotation_AMC.jrxml");
	    		       
	             		
	             	}
	             	else if(newid==1)
	             	{
	             	reportFileName = "quotation_SJOB";
	             	
	                param.put("id", new Integer(newid));
	                setUrl("com/project/execution/quotation/quotation_SJOB.jrxml");
			     	}
	             	else if(newid==2)
	             	{
	             		reportFileName = "quotation_SJOB";
	                 	
	                    param.put("id", new Integer(newid));
	                    setUrl("com/project/execution/quotation/quotation_SJOB.jrxml");
	             	}
	             }
	        	
	             	String firstquery="select @id:=@id+1 as srno,a.* from(select  groupname area,g.doc_no areaid,"
	             			+ "site from  cm_servsited  d left join my_groupvals g on(d.areaid=g.doc_no and grptype='area') where tr_no="+trno+") a,"
	             					+ "(select @id:=0) r";
	             	String termsquery="select distinct termsheader terms,m.doc_no, 0 priorno from (select distinct termsid from my_trterms tr where  tr.dtype='"+dtype+"' and tr.rdocno="+docno+" and tr.brhid="+brhid+" and tr.status=3 ) tr inner join my_termsm m on(tr.termsid=m.voc_no) where  m.status=3 union all select conditions terms,m.doc_no,priorno from my_trterms tr left join my_termsm m on(tr.termsid=m.voc_no) where  tr.dtype='"+dtype+"' and tr.rdocno="+docno+" and tr.brhid="+brhid+" and tr.status=3 and m.status=3  order by doc_no,priorno";
	           
	            String amcservicequery="select @id:=@id+1 as srno,a.* from(select site,s.sr_no siteid,groupname stype,"
	                    + "g.doc_no stypeid,coalesce(d.description,'') desc1, Equips item, round(qty,0) qty, "
	                    + " round(d.Amount,2) as amount,round(d.total,2) total,u.unit as unit,unitid"
	                    + " from cm_srvqotd d left join my_groupvals g on(d.servid=g.doc_no and grptype='service') "
	                    + "left join cm_servsited s on(s.rowno=d.sitesrno) left join my_unitm u on(u.doc_no=d.unitid)"
	                    + " where d.tr_no="+trno+"  and d.amount!=0  union all select 'site,',0,'stype',0,'CIVIL DEFENCE CONTRACT ATTESTATION' ,"
	                    + "'CIVIL DEFENCE CONTRACT ATTESTATION' ,1,round(legalchrg,2) legalchrg,round(legalchrg,2) legalchrg,'NOS',1 from cm_srvqotm where"
	                    + " tr_no="+trno+" and legalchrg!=0 ) a,(select @id:=0) r"; 
	          //     System.out.println("amcservicequery=="+amcservicequery);
	                  String amcppmfreqquery="select @id:=@id+1 as srno,a.* from (select distinct  groupname stype,"
	                    + "'3 Months' months,'4 Times' years from cm_srvqotd d "
	                    + " left join my_groupvals g on(d.servid=g.doc_no and grptype='service') "
	                    + " where d.tr_no="+trno+") a,(select @id:=0)r";
	                  
	               
	                  param.put("amcservicequery",amcservicequery);
	                
	                  param.put("ppmfreqquery",amcppmfreqquery);
	            
	            param.put("sitequery", bean.getSitequery());
	             	 param.put("termsquery", termsquery);
	             	 param.put("firstquery", firstquery);
	             
	             	 param.put("printname", "QUOTATION"); 
		             param.put("bgtext", bean.getPrintname()) ;
	             param.put("headerimgpath", headerimgpath);
		         param.put("footerimgpath", footerimgpath);
		         param.put("subject", bean.getTxtsubject());
		         param.put("compname", bean.getLblcompname());
			        param.put("salmob", bean.getTxtsalmob());
		         param.put("custname", bean.getTxtclient());
		         String docf="AITS/";
		         param.put("custdocno", docf.concat(bean.getDocno()));
		         param.put("attn", bean.getTxtcontact());
		         param.put("custdate", bean.getDate());
		         param.put("telno", bean.getTxtmob());
		         param.put("refno", bean.getTxtrefno());
		         
		         param.put("email", bean.getTxtemail());
		         param.put("salesagent", bean.getTxtsalman());
		         
		         param.put("total", bean.getTxttotalamt());
		         param.put("discount", bean.getTxtdisamt());
		         param.put("netamount", bean.getTxtnettotal());
		         param.put("amountwords", bean.getAmountwords());
		         
		       //  String path[]=com.getPrintPath(dtype).split("quotation/");
			    //    setUrl(path[1].trim());
		         /*setUrl(com.getPrintPath(dtype));*/
		          	        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/project/execution/quotation/" + reportFileName + ".jrxml"));
	     	 
	     	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
	                       generateReportPDF(response, param, jasperReport, conn);
	                 
	      
	             } catch (Exception e) {

	                 e.printStackTrace();

	             }
	            	 finally{
					conn.close();
				} 
		}
		return "print";
	}


	/*public void printActionJasper() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
	    HttpServletResponse response = ServletActionContext.getResponse();
		
	    ClsQuotationBean bean = new ClsQuotationBean();
		ClsQuotationDAO DAO= new  ClsQuotationDAO();
		String dtype=request.getParameter("dtype").toString();
	
		String id=request.getParameter("id")==null?"0":request.getParameter("id");
		String docno=request.getParameter("docno").toString();
		String brhid=request.getParameter("brhid").toString();
		String trno=request.getParameter("trno").toString();
		String header=request.getParameter("header").toString();
		bean=DAO.printMaster(session,docno,brhid,trno,dtype);
		int newid=Integer.parseInt(id);
		int newheader=Integer.parseInt(header);
		
		String reportFileName = "";
		String headerimgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
     	headerimgpath=headerimgpath.replace("\\", "\\\\");
     
     	String footerimgpath=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
     	footerimgpath=footerimgpath.replace("\\", "\\\\");
		 param = new HashMap();
 		Connection conn = null;
		 try {
	      
           
             	 conn = conobj.getMyConnection();
             	Statement stmtPC = conn.createStatement();
             	
             	if(newid==0)
             	{
             		reportFileName = "quotation_AMC";
                 	
                    param.put("id", new Integer(newid));
    		       
             		
             	}
             	else if(newid==1)
             	{
             	reportFileName = "quotation_SJOB";
             	
                param.put("id", new Integer(newid));
		   
		     	}
             	else if(newid==2)
             	{
             		reportFileName = "quotation_SJOB";
                 	
                    param.put("id", new Integer(newid));
    		      
             	}
             	
        	
             	String firstquery="select @id:=@id+1 as srno,a.* from(select  groupname area,g.doc_no areaid,"
             			+ "site from  cm_servsited  d left join my_groupvals g on(d.areaid=g.doc_no and grptype='area') where tr_no="+trno+") a,"
             					+ "(select @id:=0) r";
             	String termsquery="select distinct termsheader terms,m.doc_no, 0 priorno from (select distinct termsid from my_trterms tr where  tr.dtype='"+dtype+"' and tr.rdocno="+docno+" and tr.brhid="+brhid+" and tr.status=3 ) tr inner join my_termsm m on(tr.termsid=m.voc_no) where  m.status=3 union all select conditions terms,m.doc_no,priorno from my_trterms tr left join my_termsm m on(tr.termsid=m.voc_no) where  tr.dtype='"+dtype+"' and tr.rdocno="+docno+" and tr.brhid="+brhid+" and tr.status=3 and m.status=3  order by doc_no,priorno";
           
            String amcservicequery="select @id:=@id+1 as srno,a.* from(select site,s.sr_no siteid,groupname stype,"
                    + "g.doc_no stypeid,coalesce(d.description,'') desc1, Equips item, round(qty,0) qty, "
                    + " round(d.Amount,2) as amount,round(d.total,2) total,u.unit as unit,unitid"
                    + " from cm_srvqotd d left join my_groupvals g on(d.servid=g.doc_no and grptype='service') "
                    + "left join cm_servsited s on(s.rowno=d.sitesrno) left join my_unitm u on(u.doc_no=d.unitid)"
                    + " where d.tr_no="+trno+"  and d.amount!=0  union all select 'site,',0,'stype',0,'CIVIL DEFENCE CONTRACT ATTESTATION' ,"
                    + "'CIVIL DEFENCE CONTRACT ATTESTATION' ,1,round(legalchrg,2) legalchrg,round(legalchrg,2) legalchrg,'NOS',1 from cm_srvqotm where"
                    + " tr_no="+trno+" and legalchrg!=0 ) a,(select @id:=0) r"; 
               System.out.println("amcservicequery=="+amcservicequery);
                  String amcppmfreqquery="select @id:=@id+1 as srno,a.* from (select distinct  groupname stype,"
                    + "'3 Months' months,'4 Times' years from cm_srvqotd d "
                    + " left join my_groupvals g on(d.servid=g.doc_no and grptype='service') "
                    + " where d.tr_no="+trno+") a,(select @id:=0)r";
                  
               
                  param.put("amcservicequery",amcservicequery);
                
                  param.put("ppmfreqquery",amcppmfreqquery);
            
            param.put("sitequery", bean.getSitequery());
             	 param.put("termsquery", termsquery);
             	 param.put("firstquery", firstquery);
             
              param.put("printname", "QUOTATION"); 
	             param.put("bgtext", bean.getPrintname()) ;
             param.put("headerimgpath", headerimgpath);
	         param.put("footerimgpath", footerimgpath);
	         param.put("subject", bean.getTxtsubject());
	         param.put("compname", bean.getLblcompname());
		        param.put("salmob", bean.getTxtsalmob());
	         param.put("custname", bean.getTxtclient());
	         param.put("custdocno", bean.getDocno());
	         param.put("attn", bean.getTxtcontact());
	         param.put("custdate", bean.getDate());
	         param.put("telno", bean.getTxtmob());
	         param.put("refno", bean.getTxtrefno());
	         
	         param.put("email", bean.getTxtemail());
	         param.put("salesagent", bean.getTxtsalman());
	         
	         param.put("total", bean.getTxttotalamt());
	         param.put("discount", bean.getTxtdisamt());
	         param.put("netamount", bean.getTxtnettotal());
	         param.put("amountwords", bean.getAmountwords());
	         
	         
	         param.put("prepby", bean.getLblpreparedby());
	         param.put("prepon", bean.getLblpreparedon());
	         param.put("prepat", bean.getLblpreparedat());
	         
	         param.put("printby", session.getAttribute("USERNAME"));
	         
	          	        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/project/execution/quotation/" + reportFileName + ".jrxml"));
     	 
     	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
                       generateReportPDF(response, param, jasperReport, conn);
                 
      
             } catch (Exception e) {

                 e.printStackTrace();

             }
            	 finally{
				conn.close();
			} 
            	 
      	
				}*/
	
	  private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException {
  		  byte[] bytes = null;
          bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
            resp.reset();
          resp.resetBuffer();
          
          resp.setContentType("application/pdf");
          resp.setContentLength(bytes.length);
          ServletOutputStream ouputStream = resp.getOutputStream();
          ouputStream.write(bytes, 0, bytes.length);
         
          ouputStream.flush();
          ouputStream.close();
         
               
      }



}

