package com.project.execution.projectInvoicereturn;

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

public class ClsProjectInvoiceReturnAction {

	ClsProjectInvoiceReturnDAO proinvretDAO= new ClsProjectInvoiceReturnDAO();
	ClsProjectInvoiceReturnBean proinvretBean;
	
	ClsConnection conobj=new ClsConnection();
	ClsCommon com=new ClsCommon();
	
	private String date;
	private String hiddate;
	private String refno;
	private String brchName;

	private String txtlegalamt;
	private String txtseramt;
	private String txtexptotal;
	private String txtnettotal;
	private String txtpjivnettotal;
	private String txtpjivnetlegalamt;
	private String txtpjivnetrettotal;
	private String txtpjivnetretlegalamt;
	
	private String clacno;
	private int costid;
	private int maintrno;
	
	private String nireftype;
	private String hidnireftype;
	private String rrefno;
	private int rreftrno;
	
	private String searchtrno;
	private int docno;
	private String pdid;
	private int invgridlength;
	private int expgridlength;
	private String cmbcontracttype;
	private String cmbcontracttypeid;
	private String ptype;


	private String desc;
	private String txtnotes;
	private String mode;
	private String msg;
	private String deleted;
	private String formdetailcode;

	private String lblcompname;
	private String lblcompaddress;
	private String lblcompanyaddress;
	private String lblprintname;
	private String lblcomptel;
	private String lblcompfax;
	private String lblprintname1;
	private String lblbranch;
	private String lbllocation;
	private String lblcomptrno;
	private String lblclientname;
	private String lblclientaddress;
	private String lblclienttrno;
	private String lbldate;
	private String lbldocno;
	private String lblrefno;
	private String lblsite;
	private String lblnotes;
	private String lblgrossamount;
	private String lblvatamount;
	private String lblnettotal;
	private String lblreturndetailsquery;
	private String lblbranchtrno;
	private String amountwords;
	private String lblcheckedby;
	private String lblfinaldate;
	private String txtheader;
	private String url;
	private String txttel;
	private String txtmob;
	private String txtemail;
	private String txtjobrefno; 
    private String contypeval;
	private int masterdoc_no;

	private int clientid;
	private int cpersonid;

	private String txtclient;
	private String txtclientdet;
	private int txtcontract;
	private String lblcltrnno;
	private String series;
	private String lblamountinwords;
	private String lblrrefno;
	private String lblemail;
	
	
	
	

	public String getLblemail() {
		return lblemail;
	}
	public void setLblemail(String lblemail) {
		this.lblemail = lblemail;
	}
	public String getLblrrefno() {
		return lblrrefno;
	}
	public void setLblrrefno(String lblrrefno) {
		this.lblrrefno = lblrrefno;
	}
	public String getLblamountinwords() {
		return lblamountinwords;
	}
	public void setLblamountinwords(String lblamountinwords) {
		this.lblamountinwords = lblamountinwords;
	}
	public String getSeries() {
		return series;
	}
	public void setSeries(String series) {
		this.series = series;
	}

	private ArrayList list;
	private ArrayList sitelist;
	private ArrayList serlist;
	private ArrayList termlist;
	private ArrayList paylist;

	private String mxrnomin;
	private String mxrnomax;
	private String total1;
	private String invoived;
	private String balance;
	
	private String cperson;
	
	private String txtrefdetails;
	private String txtdtype;
	private String cltelno;
	
	private Map<String, Object> param=null;
	
	private String fire7site;
	
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
	public String getRefno() {
		return refno;
	}
	public void setRefno(String refno) {
		this.refno = refno;
	}
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}
	public String getTxtlegalamt() {
		return txtlegalamt;
	}
	public void setTxtlegalamt(String txtlegalamt) {
		this.txtlegalamt = txtlegalamt;
	}
	public String getTxtseramt() {
		return txtseramt;
	}
	public void setTxtseramt(String txtseramt) {
		this.txtseramt = txtseramt;
	}
	public String getTxtexptotal() {
		return txtexptotal;
	}
	public void setTxtexptotal(String txtexptotal) {
		this.txtexptotal = txtexptotal;
	}
	public String getTxtnettotal() {
		return txtnettotal;
	}
	public void setTxtnettotal(String txtnettotal) {
		this.txtnettotal = txtnettotal;
	}
	
	public String getTxtpjivnettotal() {
		return txtpjivnettotal;
	}
	public void setTxtpjivnettotal(String txtpjivnettotal) {
		this.txtpjivnettotal = txtpjivnettotal;
	}
	public String getTxtpjivnetlegalamt() {
		return txtpjivnetlegalamt;
	}
	public void setTxtpjivnetlegalamt(String txtpjivnetlegalamt) {
		this.txtpjivnetlegalamt = txtpjivnetlegalamt;
	}
	public String getTxtpjivnetrettotal() {
		return txtpjivnetrettotal;
	}
	public void setTxtpjivnetrettotal(String txtpjivnetrettotal) {
		this.txtpjivnetrettotal = txtpjivnetrettotal;
	}
	public String getTxtpjivnetretlegalamt() {
		return txtpjivnetretlegalamt;
	}
	public void setTxtpjivnetretlegalamt(String txtpjivnetretlegalamt) {
		this.txtpjivnetretlegalamt = txtpjivnetretlegalamt;
	}
	public String getClacno() {
		return clacno;
	}
	public void setClacno(String clacno) {
		this.clacno = clacno;
	}
	public int getCostid() {
		return costid;
	}
	public void setCostid(int costid) {
		this.costid = costid;
	}
	public int getMaintrno() {
		return maintrno;
	}
	public void setMaintrno(int maintrno) {
		this.maintrno = maintrno;
	}
	public String getNireftype() {
		return nireftype;
	}
	public void setNireftype(String nireftype) {
		this.nireftype = nireftype;
	}
	public String getHidnireftype() {
		return hidnireftype;
	}
	public void setHidnireftype(String hidnireftype) {
		this.hidnireftype = hidnireftype;
	}
	public String getRrefno() {
		return rrefno;
	}
	public void setRrefno(String rrefno) {
		this.rrefno = rrefno;
	}
	public int getRreftrno() {
		return rreftrno;
	}
	public void setRreftrno(int rreftrno) {
		this.rreftrno = rreftrno;
	}
	public String getSearchtrno() {
		return searchtrno;
	}
	public void setSearchtrno(String searchtrno) {
		this.searchtrno = searchtrno;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getPdid() {
		return pdid;
	}
	public void setPdid(String pdid) {
		this.pdid = pdid;
	}
	public int getInvgridlength() {
		return invgridlength;
	}
	public void setInvgridlength(int invgridlength) {
		this.invgridlength = invgridlength;
	}
	public int getExpgridlength() {
		return expgridlength;
	}
	public void setExpgridlength(int expgridlength) {
		this.expgridlength = expgridlength;
	}
	public String getCmbcontracttype() {
		return cmbcontracttype;
	}
	public void setCmbcontracttype(String cmbcontracttype) {
		this.cmbcontracttype = cmbcontracttype;
	}
	public String getCmbcontracttypeid() {
		return cmbcontracttypeid;
	}
	public void setCmbcontracttypeid(String cmbcontracttypeid) {
		this.cmbcontracttypeid = cmbcontracttypeid;
	}
	public String getPtype() {
		return ptype;
	}
	public void setPtype(String ptype) {
		this.ptype = ptype;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public String getTxtnotes() {
		return txtnotes;
	}
	public void setTxtnotes(String txtnotes) {
		this.txtnotes = txtnotes;
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
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
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
	public String getLblcompanyaddress() {
		return lblcompanyaddress;
	}
	public void setLblcompanyaddress(String lblcompanyaddress) {
		this.lblcompanyaddress = lblcompanyaddress;
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
	public String getLblcomptrno() {
		return lblcomptrno;
	}
	public void setLblcomptrno(String lblcomptrno) {
		this.lblcomptrno = lblcomptrno;
	}
	public String getLblclientname() {
		return lblclientname;
	}
	public void setLblclientname(String lblclientname) {
		this.lblclientname = lblclientname;
	}
	public String getLblclientaddress() {
		return lblclientaddress;
	}
	public void setLblclientaddress(String lblclientaddress) {
		this.lblclientaddress = lblclientaddress;
	}
	public String getLblclienttrno() {
		return lblclienttrno;
	}
	public void setLblclienttrno(String lblclienttrno) {
		this.lblclienttrno = lblclienttrno;
	}
	public String getLbldate() {
		return lbldate;
	}
	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}
	public String getLbldocno() {
		return lbldocno;
	}
	public void setLbldocno(String lbldocno) {
		this.lbldocno = lbldocno;
	}
	public String getLblrefno() {
		return lblrefno;
	}
	public void setLblrefno(String lblrefno) {
		this.lblrefno = lblrefno;
	}
	public String getLblsite() {
		return lblsite;
	}
	public void setLblsite(String lblsite) {
		this.lblsite = lblsite;
	}
	public String getLblnotes() {
		return lblnotes;
	}
	public void setLblnotes(String lblnotes) {
		this.lblnotes = lblnotes;
	}
	public String getLblgrossamount() {
		return lblgrossamount;
	}
	public void setLblgrossamount(String lblgrossamount) {
		this.lblgrossamount = lblgrossamount;
	}
	public String getLblvatamount() {
		return lblvatamount;
	}
	public void setLblvatamount(String lblvatamount) {
		this.lblvatamount = lblvatamount;
	}
	public String getLblnettotal() {
		return lblnettotal;
	}
	public void setLblnettotal(String lblnettotal) {
		this.lblnettotal = lblnettotal;
	}
	public String getLblreturndetailsquery() {
		return lblreturndetailsquery;
	}
	public void setLblreturndetailsquery(String lblreturndetailsquery) {
		this.lblreturndetailsquery = lblreturndetailsquery;
	}
	public String getLblbranchtrno() {
		return lblbranchtrno;
	}
	public void setLblbranchtrno(String lblbranchtrno) {
		this.lblbranchtrno = lblbranchtrno;
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
	public String getTxtheader() {
		return txtheader;
	}
	public void setTxtheader(String txtheader) {
		this.txtheader = txtheader;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
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
	public String getTxtjobrefno() {
		return txtjobrefno;
	}
	public void setTxtjobrefno(String txtjobrefno) {
		this.txtjobrefno = txtjobrefno;
	}
	public String getContypeval() {
		return contypeval;
	}
	public void setContypeval(String contypeval) {
		this.contypeval = contypeval;
	}
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	public int getClientid() {
		return clientid;
	}
	public void setClientid(int clientid) {
		this.clientid = clientid;
	}
	public int getCpersonid() {
		return cpersonid;
	}
	public void setCpersonid(int cpersonid) {
		this.cpersonid = cpersonid;
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
	public int getTxtcontract() {
		return txtcontract;
	}
	public void setTxtcontract(int txtcontract) {
		this.txtcontract = txtcontract;
	}
	public String getLblcltrnno() {
		return lblcltrnno;
	}
	public void setLblcltrnno(String lblcltrnno) {
		this.lblcltrnno = lblcltrnno;
	}
	public ArrayList getList() {
		return list;
	}
	public void setList(ArrayList list) {
		this.list = list;
	}
	public ArrayList getSitelist() {
		return sitelist;
	}
	public void setSitelist(ArrayList sitelist) {
		this.sitelist = sitelist;
	}
	public ArrayList getSerlist() {
		return serlist;
	}
	public void setSerlist(ArrayList serlist) {
		this.serlist = serlist;
	}
	public ArrayList getTermlist() {
		return termlist;
	}
	public void setTermlist(ArrayList termlist) {
		this.termlist = termlist;
	}
	public ArrayList getPaylist() {
		return paylist;
	}
	public void setPaylist(ArrayList paylist) {
		this.paylist = paylist;
	}
	public String getMxrnomin() {
		return mxrnomin;
	}
	public void setMxrnomin(String mxrnomin) {
		this.mxrnomin = mxrnomin;
	}
	public String getMxrnomax() {
		return mxrnomax;
	}
	public void setMxrnomax(String mxrnomax) {
		this.mxrnomax = mxrnomax;
	}
	public String getTotal1() {
		return total1;
	}
	public void setTotal1(String total1) {
		this.total1 = total1;
	}
	public String getInvoived() {
		return invoived;
	}
	public void setInvoived(String invoived) {
		this.invoived = invoived;
	}
	public String getBalance() {
		return balance;
	}
	public void setBalance(String balance) {
		this.balance = balance;
	}
	public String getCperson() {
		return cperson;
	}
	public void setCperson(String cperson) {
		this.cperson = cperson;
	}
	public String getTxtrefdetails() {
		return txtrefdetails;
	}
	public void setTxtrefdetails(String txtrefdetails) {
		this.txtrefdetails = txtrefdetails;
	}
	public String getTxtdtype() {
		return txtdtype;
	}
	public void setTxtdtype(String txtdtype) {
		this.txtdtype = txtdtype;
	}
	public String getCltelno() {
		return cltelno;
	}
	public void setCltelno(String cltelno) {
		this.cltelno = cltelno;
	}
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	public String getFire7site() {
		return fire7site;
	}
	public void setFire7site(String fire7site) {
		this.fire7site = fire7site;
	}
	
	public String saveInvoiceAction()throws ParseException, SQLException{



		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		String searchtrno=getSearchtrno();

		int val=0;
		Double taxamt=0.0,taxtot=0.0;
		String nontax="0";
		ClsProjectInvoiceReturnDAO DAO=new ClsProjectInvoiceReturnDAO();

		if(mode.equals("A")){

			java.sql.Date date=com.changeStringtoSqlDate(getDate());

			ArrayList<String> invarray= new ArrayList<>();
			ArrayList<String> exparray= new ArrayList<>();
			ArrayList taxlist=new ArrayList();

			for(int i=0;i<getInvgridlength();i++){
				String temp2=requestParams.get("inv"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();
				invarray.add(temp2);

			}
			for(int i=0;i<getExpgridlength();i++){
				String temp2=requestParams.get("exp"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();
				exparray.add(temp2);

			}
			
			double nettotal=Double.parseDouble(getTxtseramt())+Double.parseDouble(getTxtlegalamt())+Double.parseDouble(getTxtexptotal());
			
			taxlist=DAO.getTax(session,nettotal,date,"0",getClientid());
			
			for(int t=0;t<taxlist.size();t++){

				String[] tmp=((String) taxlist.get(t)).split("::");

				//System.out.println("==tmp===="+tmp.length);

				taxamt=Double.parseDouble(tmp[3]);
				taxtot=taxtot+taxamt;
				//netotal=netotal;
			}

			System.out.println("Contypeval ="+getContypeval());
			
			val=DAO.insert(date,getRrefno(),getRreftrno(),getRefno(),getContypeval(),getTxtcontract(),getTxtclient(),getTxtclientdet(),getDesc(),getBrchName(),getClacno(),getClientid(),
					getCostid(),invarray,exparray,session,getMode(),getFormdetailcode(),request,getTxtlegalamt(),getTxtseramt(),getTxtexptotal(),"0",getPdid(),getTxtnotes(),getPtype(),
					taxtot,getTxtpjivnettotal(),getTxtpjivnetlegalamt(),getTxtpjivnetrettotal(),getTxtpjivnetretlegalamt(),taxlist,nontax);
			if(val>0){

				setMaintrno(val);
				setDocno(Integer.parseInt(request.getAttribute("docno").toString()));
				setDate(date+"");
				setRrefno(getRrefno());
				setRreftrno(getRreftrno());
				setHidnireftype(getNireftype());
				setRefno(getRefno());
				setCmbcontracttype(getCmbcontracttype());
				setCmbcontracttypeid(getCmbcontracttypeid());
				setTxtrefdetails(getTxtrefdetails());
				setContypeval(getContypeval());
				setTxtcontract(getTxtcontract());
				setTxtclient(getTxtclient());
				setTxtclientdet(getTxtclientdet());
				setDesc(getDesc());
				setTxtnotes(getTxtnotes());
				setClacno(getClacno());
				setClientid(getClientid());
				setCostid(getCostid());
				setPdid(getPdid());
				setPtype(getPtype());
				setTxtpjivnettotal(getTxtpjivnettotal());
				setTxtpjivnetlegalamt(getTxtpjivnetlegalamt());
				setTxtpjivnetrettotal(getTxtpjivnetrettotal());
				setTxtpjivnetretlegalamt(getTxtpjivnetretlegalamt());
				setMode(getMode());
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setMaintrno(val);
				setDate(date+"");
				setRrefno(getRrefno());
				setRreftrno(getRreftrno());
				setHidnireftype(getNireftype());
				setRefno(getRefno());
				setCmbcontracttype(getCmbcontracttype());
				setCmbcontracttypeid(getCmbcontracttypeid());
				setTxtrefdetails(getTxtrefdetails());
				setContypeval(getContypeval());
				setTxtcontract(getTxtcontract());
				setTxtclient(getTxtclient());
				setTxtclientdet(getTxtclientdet());
				setDesc(getDesc());
				setTxtnotes(getTxtnotes());
				setClacno(getClacno());
				setClientid(getClientid());
				setCostid(getCostid());
				setPdid(getPdid());
				setPtype(getPtype());
				setTxtpjivnettotal(getTxtpjivnettotal());
				setTxtpjivnetlegalamt(getTxtpjivnetlegalamt());
				setTxtpjivnetrettotal(getTxtpjivnetrettotal());
				setTxtpjivnetretlegalamt(getTxtpjivnetretlegalamt());
				
				setMsg("Not Saved");
				return "fail";


			}

		}

		else if(mode.equalsIgnoreCase("E")){
			java.sql.Date date=com.changeStringtoSqlDate(getDate());

			ArrayList<String> invarray= new ArrayList<>();
			ArrayList<String> exparray= new ArrayList<>();
			ArrayList taxlist=new ArrayList();

			for(int i=0;i<getInvgridlength();i++){
				String temp2=requestParams.get("inv"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();
				invarray.add(temp2);

			}
			for(int i=0;i<getExpgridlength();i++){
				String temp2=requestParams.get("exp"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();
				exparray.add(temp2);

			}
			
			double nettotal=Double.parseDouble(getTxtseramt())+Double.parseDouble(getTxtlegalamt())+Double.parseDouble(getTxtexptotal());
			
			taxlist=DAO.getTax(session,nettotal,date,"0",getClientid());
			
			for(int t=0;t<taxlist.size();t++){

				String[] tmp=((String) taxlist.get(t)).split("::");

				//System.out.println("==tmp===="+tmp.length);

				taxamt=Double.parseDouble(tmp[3]);
				taxtot=taxtot+taxamt;
				//netotal=netotal;
			}

			val=DAO.edit(getMaintrno(),getDocno(),date,getRrefno(),getRreftrno(),getRefno(),getCmbcontracttype(),getTxtcontract(),getTxtclient(),getTxtclientdet(),getDesc(),getBrchName(),getClacno(),getClientid(),
					getCostid(),invarray,exparray,session,getMode(),getFormdetailcode(),request,getTxtlegalamt(),getTxtseramt(),getTxtexptotal(),"0",getPdid(),getTxtnotes(),getPtype(),
					taxtot,getTxtpjivnettotal(),getTxtpjivnetlegalamt(),getTxtpjivnetrettotal(),getTxtpjivnetretlegalamt(),taxlist);

			if(val>0){

				setMaintrno(val);
				setDocno(Integer.parseInt(request.getAttribute("docno").toString()));
				setDate(date+"");
				setRrefno(getRrefno());
				setRreftrno(getRreftrno());
				setHidnireftype(getNireftype());
				setRefno(getRefno());
				setCmbcontracttype(getCmbcontracttype());
				setCmbcontracttypeid(getCmbcontracttypeid());
				setTxtrefdetails(getTxtrefdetails());
				setContypeval(getContypeval());
				setTxtcontract(getTxtcontract());
				setTxtclient(getTxtclient());
				setTxtclientdet(getTxtclientdet());
				setDesc(getDesc());
				setTxtnotes(getTxtnotes());
				setClacno(getClacno());
				setClientid(getClientid());
				setCostid(getCostid());
				setPdid(getPdid());
				setPtype(getPtype());
				setTxtpjivnettotal(getTxtpjivnettotal());
				setTxtpjivnetlegalamt(getTxtpjivnetlegalamt());
				setTxtpjivnetrettotal(getTxtpjivnetrettotal());
				setTxtpjivnetretlegalamt(getTxtpjivnetretlegalamt());
				
				setMsg("Updated Successfully");
				return "success";
			}
			else{

				setDate(date+"");
				setRrefno(getRrefno());
				setRreftrno(getRreftrno());
				setHidnireftype(getNireftype());
				setRefno(getRefno());
				setCmbcontracttype(getCmbcontracttype());
				setCmbcontracttypeid(getCmbcontracttypeid());
				setTxtrefdetails(getTxtrefdetails());
				setContypeval(getContypeval());
				setTxtcontract(getTxtcontract());
				setTxtclient(getTxtclient());
				setTxtclientdet(getTxtclientdet());
				setDesc(getDesc());
				setTxtnotes(getTxtnotes());
				setClacno(getClacno());
				setClientid(getClientid());
				setCostid(getCostid());
				setPdid(getPdid());
				setPtype(getPtype());
				setTxtpjivnettotal(getTxtpjivnettotal());
				setTxtpjivnetlegalamt(getTxtpjivnetlegalamt());
				setTxtpjivnetrettotal(getTxtpjivnetrettotal());
				setTxtpjivnetretlegalamt(getTxtpjivnetretlegalamt());
				
				setMsg("Not Updated");
				return "fail";
			}
		}

		else if(mode.equalsIgnoreCase("D")){
			java.sql.Date date=com.changeStringtoSqlDate(getDate());

			ArrayList<String> invarray= new ArrayList<>();
			ArrayList<String> exparray= new ArrayList<>();
			ArrayList taxlist=new ArrayList();
			
			
			System.out.println("invarray=="+invarray);
			System.out.println("array length:"+getInvgridlength());
			/*for(int i=0;i<getInvgridlength();i++){
				String temp2=requestParams.get("inv"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();
				invarray.add(temp2);
				System.out.println("invarray 1=="+invarray);
			}*/
			
			
			/*for(int i=0;i<getExpgridlength();i++){
				String temp2=requestParams.get("exp"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();
				exparray.add(temp2);

			}*/
			
			taxlist=DAO.getTax(session,Double.parseDouble(getTxtnettotal()),date,"0",getClientid());
			
			for(int t=0;t<taxlist.size();t++){

				String[] tmp=((String) taxlist.get(t)).split("::");

//				System.out.println("==tmp===="+tmp.length);

				taxamt=Double.parseDouble(tmp[3]);
				taxtot=taxtot+taxamt;
				//netotal=netotal;
			}

			val=DAO.delete(getMaintrno(),getDocno(),date,getRrefno(),getRreftrno(),getRefno(),getContypeval(),getTxtcontract(),getTxtclient(),getTxtclientdet(),getDesc(),getBrchName(),getClacno(),getClientid(),
					getCostid(),invarray,exparray,session,getMode(),getFormdetailcode(),request,getTxtlegalamt(),getTxtseramt(),getTxtexptotal(),"0",getPdid(),getTxtnotes(),getPtype(),
					taxtot,getTxtpjivnettotal(),getTxtpjivnetlegalamt(),getTxtpjivnetrettotal(),getTxtpjivnetretlegalamt(),taxlist);

			if(val>0){

				setMaintrno(val);
				setDocno(Integer.parseInt(request.getAttribute("docno").toString()));
				setDate(date+"");
				setRrefno(getRrefno());
				setRreftrno(getRreftrno());
				setHidnireftype(getNireftype());
				setRefno(getRefno());
				setCmbcontracttype(getCmbcontracttype());
				setCmbcontracttypeid(getCmbcontracttypeid());
				setTxtrefdetails(getTxtrefdetails());
				setContypeval(getContypeval());
				setTxtcontract(getTxtcontract());
				setTxtclient(getTxtclient());
				setTxtclientdet(getTxtclientdet());
				setDesc(getDesc());
				setTxtnotes(getTxtnotes());
				setClacno(getClacno());
				setClientid(getClientid());
				setCostid(getCostid());
				setPdid(getPdid());
				setPtype(getPtype());
				setTxtpjivnettotal(getTxtpjivnettotal());
				setTxtpjivnetlegalamt(getTxtpjivnetlegalamt());
				setTxtpjivnetrettotal(getTxtpjivnetrettotal());
				setTxtpjivnetretlegalamt(getTxtpjivnetretlegalamt());
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setMaintrno(val);
				setDocno(Integer.parseInt(request.getAttribute("docno").toString()));
				setDate(date+"");
				setRrefno(getRrefno());
				setRreftrno(getRreftrno());
				setHidnireftype(getNireftype());
				setRefno(getRefno());
				setCmbcontracttype(getCmbcontracttype());
				setCmbcontracttypeid(getCmbcontracttypeid());
				setTxtrefdetails(getTxtrefdetails());
				setContypeval(getContypeval());
				setTxtcontract(getTxtcontract());
				setTxtclient(getTxtclient());
				setTxtclientdet(getTxtclientdet());
				setDesc(getDesc());
				setTxtnotes(getTxtnotes());
				setClacno(getClacno());
				setClientid(getClientid());
				setCostid(getCostid());
				setPdid(getPdid());
				setPtype(getPtype());
				setTxtpjivnettotal(getTxtpjivnettotal());
				setTxtpjivnetlegalamt(getTxtpjivnetlegalamt());
				setTxtpjivnetrettotal(getTxtpjivnetrettotal());
				setTxtpjivnetretlegalamt(getTxtpjivnetretlegalamt());
				
				setMsg("Not Deleted");
				return "fail";
			}
		}

		else if(mode.equalsIgnoreCase("view")){
			proinvretBean=proinvretDAO.getViewDetails(session,getMaintrno(),getBrchName());

			setDocno(proinvretBean.getDocno());
			setDate(proinvretBean.getDate());
			setRrefno(proinvretBean.getRrefno());
			setRreftrno(proinvretBean.getRreftrno());
			setHidnireftype(proinvretBean.getHidnireftype());
			setRefno(proinvretBean.getRefno());
			setTxtclient(proinvretBean.getTxtclient());
			setTxtclientdet(proinvretBean.getTxtclientdet());
			setCmbcontracttype(proinvretBean.getCmbcontracttype());
			setCmbcontracttypeid(proinvretBean.getCmbcontracttypeid());
			setContypeval(proinvretBean.getContypeval());
			setDesc(proinvretBean.getDesc());
			setTxtcontract(proinvretBean.getTxtcontract());
			setMaintrno(proinvretBean.getMaintrno());
			setClientid(proinvretBean.getClientid());
			setClacno(proinvretBean.getClacno());
			setCostid(proinvretBean.getCostid());
			setPdid(proinvretBean.getPdid());
			setPtype(proinvretBean.getPtype());
			setTxtnettotal(proinvretBean.getTxtnettotal());
			setTxtlegalamt(proinvretBean.getTxtlegalamt());
			setTxtseramt(proinvretBean.getTxtseramt());
			setTxtexptotal(proinvretBean.getTxtexptotal());
			setTxtnotes(proinvretBean.getTxtnotes());
			setTxtrefdetails(proinvretBean.getTxtrefdetails());

			return "success";
		}

		return "fail";

	}	
	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		int docno=Integer.parseInt(request.getParameter("docno")==null?"0":request.getParameter("docno"));
		int trno=Integer.parseInt(request.getParameter("trno")==null?"0":request.getParameter("trno"));
		int branch=Integer.parseInt(request.getParameter("brhid")==null?"0":request.getParameter("brhid"));
		String dtype=request.getParameter("dtype")==null?"0":request.getParameter("dtype");
		
		proinvretBean=proinvretDAO.getPrint(request,docno,branch,trno,dtype);
		
		setUrl(com.getPrintPath("PJIR"));
		setLblcompname(proinvretBean.getLblcompname());
		setLblcompaddress(proinvretBean.getLblcompaddress());
		setLblprintname(proinvretBean.getLblprintname());
		setLblcomptel(proinvretBean.getLblcomptel());
		setLblcompfax(proinvretBean.getLblcompfax());
		setLblbranch(proinvretBean.getLblbranch());
		setLbllocation(proinvretBean.getLbllocation());
		setSeries(proinvretBean.getSeries());
		setLblamountinwords(proinvretBean.getLblamountinwords());
		setLblrrefno(proinvretBean.getLblrrefno());
		setLblemail(proinvretBean.getLblemail());
		
		if(com.getPrintPath("PJIR").contains(".jrxml"));
		{
			HttpServletResponse response = ServletActionContext.getResponse();
			
			 param = new HashMap();
			 Connection conn = null;
			 
			 try {
				
             	conn = conobj.getMyConnection();
             	
             	
             	
             	String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
               	imgpath=imgpath.replace("\\", "\\\\");
              	
               	String imgheaderpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
               	imgheaderpath=imgheaderpath.replace("\\", "\\\\");    
	          
	            String imgpath2=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
	        	imgpath2=imgpath2.replace("\\", "\\\\");    
		          
		         param.put("imgpath", imgpath);
		     	 param.put("imghedderpath", imgheaderpath);
		     	 param.put("imgfooterpath", imgpath2);
		         param.put("compname", proinvretBean.getLblcompname());
		         param.put("compaddress", proinvretBean.getLblcompaddress());
		         param.put("comptrno", proinvretBean.getLblcomptrno());
		         param.put("clientname", proinvretBean.getLblclientname());
		         param.put("clientaddress", proinvretBean.getLblclientaddress());
		         param.put("clienttrno", proinvretBean.getLblclienttrno());
		         param.put("date", proinvretBean.getLbldate());
		         param.put("docno", proinvretBean.getLbldocno());
		         param.put("refno", proinvretBean.getLblrrefno());
		         param.put("site", proinvretBean.getLblsite());
		         param.put("notes", proinvretBean.getLblnotes());
		         param.put("returndetailssql", proinvretBean.getLblreturndetailsquery());
		         param.put("grossamount", proinvretBean.getLblgrossamount());
		         param.put("vatamount", proinvretBean.getLblvatamount());
	             param.put("nettotal", proinvretBean.getLblnettotal());
		         param.put("printby", session.getAttribute("USERNAME").toString());
		         param.put("docno", proinvretBean.getSeries());
		         param.put("amtinwords", proinvretBean.getLblamountinwords());
		         param.put("tel", proinvretBean.getLblcomptel());
		         param.put("fax", proinvretBean.getLblcompfax());
		         param.put("email",proinvretBean.getLblemail());
		         String cityheaderpath=request.getSession().getServletContext().getRealPath("/icons/cityheader.png");
					cityheaderpath=cityheaderpath.replace("\\", "\\\\");
					
					String cityfooterpath=request.getSession().getServletContext().getRealPath("/icons/cityfooter.jpg");
					cityfooterpath=cityfooterpath.replace("\\", "\\\\");
					
					param.put("cityheader", cityheaderpath);
					param.put("cityfooter", cityfooterpath);
					
		     	
		         JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(com.getPrintPath("PJIR")));
	     	 
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
