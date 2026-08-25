package com.project.execution.surveyDetails;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.project.execution.quotation.ClsQuotationBean;
import com.project.execution.quotation.ClsQuotationDAO;

public class ClsSurveyDetailsAction {

	ClsCommon com=new ClsCommon();

	private String date;
	private String txtenquiry;
	private String docno;
	private String txtclient;
	private String txtcontact;
	private String contactnumber;
	private String surveyedby;
	private String txtdesc;
	private String hiddate;
	private String mode;
	private String msg;
	private String deleted;
	private int clientid;
	private int cpersonid;
	private int masterdoc_no;
	private int enqdoc_no;
	private int empid;
	private int sertypegridlen;
	private int servtypdetgridlen;
	private String formdetailcode;
	private int servlen;
	private int sitelen;
	private String sertypeids;

	private String txttel;
	private String txtmob;
	private String txtemail;
	private String url;
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
	private String txtclientdet;
	private String txtrefno;
	private String txtcontractr;
	
	private ArrayList sitelist;
	private ArrayList serlist;
	private ArrayList list;
	private ArrayList termlist;
	
	private int hidsuredit;
	
	public int getHidsuredit() {
		return hidsuredit;
	}
	public void setHidsuredit(int hidsuredit) {
		this.hidsuredit = hidsuredit;
	}
	public ArrayList getTermlist() {
		return termlist;
	}
	public void setTermlist(ArrayList termlist) {
		this.termlist = termlist;
	}
	public ArrayList getList() {
		return list;
	}
	public void setList(ArrayList list) {
		this.list = list;
	}
	public ArrayList getSerlist() {
		return serlist;
	}
	public void setSerlist(ArrayList serlist) {
		this.serlist = serlist;
	}
	public String getTxtcontractr() {
		return txtcontractr;
	}
	public void setTxtcontractr(String txtcontractr) {
		this.txtcontractr = txtcontractr;
	}
	public ArrayList getSitelist() {
		return sitelist;
	}
	public void setSitelist(ArrayList sitelist) {
		this.sitelist = sitelist;
	}
	public String getTxtrefno() {
		return txtrefno;
	}
	public void setTxtrefno(String txtrefno) {
		this.txtrefno = txtrefno;
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
	public String getTxtclientdet() {
		return txtclientdet;
	}
	public void setTxtclientdet(String txtclientdet) {
		this.txtclientdet = txtclientdet;
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
	public String getTxtheader() {
		return txtheader;
	}
	public void setTxtheader(String txtheader) {
		this.txtheader = txtheader;
	}
	public int getServlen() {
		return servlen;
	}
	public void setServlen(int servlen) {
		this.servlen = servlen;
	}
	public int getSitelen() {
		return sitelen;
	}
	public void setSitelen(int sitelen) {
		this.sitelen = sitelen;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getTxtenquiry() {
		return txtenquiry;
	}
	public void setTxtenquiry(String txtenquiry) {
		this.txtenquiry = txtenquiry;
	}
	public String getDocno() {
		return docno;
	}
	public void setDocno(String docno) {
		this.docno = docno;
	}
	public String getTxtclient() {
		return txtclient;
	}
	public void setTxtclient(String txtclient) {
		this.txtclient = txtclient;
	}
	public String getTxtcontact() {
		return txtcontact;
	}
	public void setTxtcontact(String txtcontact) {
		this.txtcontact = txtcontact;
	}
	public String getContactnumber() {
		return contactnumber;
	}
	public void setContactnumber(String contactnumber) {
		this.contactnumber = contactnumber;
	}
	public String getSurveyedby() {
		return surveyedby;
	}
	public void setSurveyedby(String surveyedby) {
		this.surveyedby = surveyedby;
	}
	public String getTxtdesc() {
		return txtdesc;
	}
	public void setTxtdesc(String txtdesc) {
		this.txtdesc = txtdesc;
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
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	public int getEnqdoc_no() {
		return enqdoc_no;
	}
	public void setEnqdoc_no(int enqdoc_no) {
		this.enqdoc_no = enqdoc_no;
	}
	public int getEmpid() {
		return empid;
	}
	public void setEmpid(int empid) {
		this.empid = empid;
	}
	public int getSertypegridlen() {
		return sertypegridlen;
	}
	public void setSertypegridlen(int sertypegridlen) {
		this.sertypegridlen = sertypegridlen;
	}
	public int getServtypdetgridlen() {
		return servtypdetgridlen;
	}
	public void setServtypdetgridlen(int servtypdetgridlen) {
		this.servtypdetgridlen = servtypdetgridlen;
	}

	public String getSertypeids() {
		return sertypeids;
	}
	public void setSertypeids(String sertypeids) {
		this.sertypeids = sertypeids;
	}
	public String saveAction(){

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		String returns="";
		int val=0;
		ClsSurveyDetailsDAO DAO=new ClsSurveyDetailsDAO();

		try{

			ArrayList sertypelist = new ArrayList();

			ArrayList sertypedetlist = new ArrayList();

			ArrayList servlist= new ArrayList();

			ArrayList sitelist = new ArrayList();


			for(int i=0;i<getSertypegridlen();i++){

				String temp=requestParams.get("test"+i)[0];		
				sertypelist.add(temp);
			}

			for(int i=0;i<getServtypdetgridlen();i++){

				String temp=requestParams.get("sertyp"+i)[0];		
				sertypedetlist.add(temp);
			}

			for(int i=0;i<getSitelen();i++){

				String temp=requestParams.get("site"+i)[0];		
				sitelist.add(temp);
			}

			for(int i=0;i<getServlen();i++){

				String temp=requestParams.get("serv"+i)[0];		
				servlist.add(temp);
			}



			if(mode.equals("A")){


				java.sql.Date date=com.changeStringtoSqlDate(getDate());

				val=DAO.insert(date,getEnqdoc_no(),getClientid(),getEmpid(),getTxtdesc(),getTxtenquiry(),sertypelist,
						sertypedetlist,servlist,sitelist,session,request,mode,getFormdetailcode(),getCpersonid(),
						getSertypeids(),getTxtcontractr());

				if(val>0){
					setDocno(val+"");
					setDate(date+"");
					setMasterdoc_no(Integer.parseInt(request.getAttribute("docNo").toString()));
					setClientid(getClientid());
					setContactnumber(getContactnumber());
					setCpersonid(getCpersonid());
					setDate(date+"");
					setEmpid(getEmpid());
					setEnqdoc_no(getEnqdoc_no());
					setSurveyedby(getSurveyedby());
					setTxtclient(getTxtclient());
					setTxtcontact(getTxtcontact());
					setTxtdesc(getTxtdesc());
					setTxtenquiry(getTxtenquiry());
					setTxtcontractr(getTxtcontractr());
					setMsg("Successfully Saved");
					returns="success";
				}
				else{
					setDocno(val+"");
					setDate(date+"");
					setMasterdoc_no(Integer.parseInt(request.getAttribute("vocno").toString()));
					setClientid(getClientid());
					setContactnumber(getContactnumber());
					setCpersonid(getCpersonid());
					setDate(date+"");
					setEmpid(getEmpid());
					setEnqdoc_no(getEnqdoc_no());
					setSurveyedby(getSurveyedby());
					setTxtclient(getTxtclient());
					setTxtcontact(getTxtcontact());
					setTxtdesc(getTxtdesc());
					setTxtenquiry(getTxtenquiry());
					setTxtcontractr(getTxtcontractr());
					setMsg("Not Saved");
					returns="fail";
				}

			}
			else if(mode.equals("E")){


				java.sql.Date date=com.changeStringtoSqlDate(getDate());

				val=DAO.edit(getMasterdoc_no(),Integer.parseInt(getDocno()),date,getEnqdoc_no(),getClientid(),getEmpid(),
						getTxtdesc(),getTxtenquiry(),sertypelist,sertypedetlist,servlist,sitelist,session,request,mode,
						getFormdetailcode(),getCpersonid(),getSertypeids(),getTxtcontractr());

				if(val>0){
					setDocno(val+"");
					setDate(date+"");
					setMasterdoc_no(Integer.parseInt(request.getAttribute("docNo").toString()));
					setClientid(getClientid());
					setContactnumber(getContactnumber());
					setCpersonid(getCpersonid());
					setDate(date+"");
					setEmpid(getEmpid());
					setEnqdoc_no(getEnqdoc_no());
					setSurveyedby(getSurveyedby());
					setTxtclient(getTxtclient());
					setTxtcontact(getTxtcontact());
					setTxtdesc(getTxtdesc());
					setTxtenquiry(getTxtenquiry());
					setTxtcontractr(getTxtcontractr());
					setMsg("Updated Successfully");
					returns="success";
				}
				else{
					setDocno(val+"");
					setMasterdoc_no(Integer.parseInt(request.getAttribute("vocno").toString()));
					setClientid(getClientid());
					setContactnumber(getContactnumber());
					setCpersonid(getCpersonid());
					setDate(date+"");
					setEmpid(getEmpid());
					setEnqdoc_no(getEnqdoc_no());
					setSurveyedby(getSurveyedby());
					setTxtclient(getTxtclient());
					setTxtcontact(getTxtcontact());
					setTxtdesc(getTxtdesc());
					setTxtenquiry(getTxtenquiry());
					setTxtcontractr(getTxtcontractr());
					setMsg("Not Updated");
					returns="fail";
				}

			}

			if(mode.equalsIgnoreCase("view")){

				setDate(date+"");
				setHiddate(date+"");

				returns="success";
			}


			else if(mode.equals("D")){


				java.sql.Date date=com.changeStringtoSqlDate(getDate());

				val=DAO.delete(getMasterdoc_no(),Integer.parseInt(getDocno()),date,getEnqdoc_no(),getClientid(),getEmpid(),
						getTxtdesc(),getTxtenquiry(),sertypelist,sertypedetlist,servlist,sitelist,session,request,mode,
						getFormdetailcode(),getCpersonid(),getSertypeids(),getTxtcontractr());

				if(val>0){
					setDocno(val+"");
					setDate(date+"");
					setMasterdoc_no(Integer.parseInt(request.getAttribute("docNo").toString()));
					setClientid(getClientid());
					setContactnumber(getContactnumber());
					setCpersonid(getCpersonid());
					setDate(date+"");
					setEmpid(getEmpid());
					setEnqdoc_no(getEnqdoc_no());
					setSurveyedby(getSurveyedby());
					setTxtclient(getTxtclient());
					setTxtcontact(getTxtcontact());
					setTxtdesc(getTxtdesc());
					setTxtenquiry(getTxtenquiry());
					setTxtcontractr(getTxtcontractr());
					setMsg("Deleted Successfully");
					returns="success";
				}
				else{
					setDocno(val+"");
					setMasterdoc_no(Integer.parseInt(request.getAttribute("vocno").toString()));
					setClientid(getClientid());
					setContactnumber(getContactnumber());
					setCpersonid(getCpersonid());
					setDate(date+"");
					setEmpid(getEmpid());
					setEnqdoc_no(getEnqdoc_no());
					setSurveyedby(getSurveyedby());
					setTxtclient(getTxtclient());
					setTxtcontact(getTxtcontact());
					setTxtdesc(getTxtdesc());
					setTxtenquiry(getTxtenquiry());
					setTxtcontractr(getTxtcontractr());
					setMsg("Not Deleted");
					returns="fail";
				}

			}

		}
		catch(Exception e){

			e.printStackTrace();
		}
		return returns;

	}



	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		ClsSurveyDetailsBean bean = new ClsSurveyDetailsBean();
		ClsSurveyDetailsDAO DAO= new  ClsSurveyDetailsDAO();
		String dtype=request.getParameter("dtype").toString();
		setUrl(com.getPrintPath(dtype));
		String allbranch=request.getParameter("allbranch")==null?"0":request.getParameter("allbranch");
		String hidheader=request.getParameter("hidheader")==null?"0":request.getParameter("hidheader");
		String docno=request.getParameter("docno").toString();
		String brhid=request.getParameter("brhid").toString();
		String trno=request.getParameter("trno").toString();
		String header=request.getParameter("header").toString();
		String sertypeids=request.getParameter("sertypeids").toString();
		bean=DAO.printMaster(session,docno,brhid,trno,dtype,sertypeids);

		setTxtheader(header);
		setMasterdoc_no(bean.getMasterdoc_no());
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
		setTxtenquiry(bean.getTxtenquiry());
		setTxtrefno(bean.getTxtrefno());
		setLblbranch(bean.getLblbranch());
		setLblcompaddress(bean.getLblcompaddress());
		setLblcompfax(bean.getLblcompfax());
		setLblcomptel(bean.getLblcomptel());
		setLbllocation(bean.getLbllocation());
		setAmountwords(bean.getAmountwords());
		setLblcompname(bean.getLblcompname());
		setSurveyedby(bean.getSurveyedby());
		setLblcheckedby(session.getAttribute("USERNAME").toString().trim());
		setLblfinaldate(bean.getLblfinaldate());
		setTxtcontractr(bean.getTxtcontractr());
		setEnqdoc_no(bean.getEnqdoc_no());
        ArrayList sitelist=bean.getSitelist();
        ArrayList serlist=bean.getSerlist();
        ArrayList list=bean.getList();
        ArrayList trlist=bean.getTermlist();
        
        setSitelist(sitelist);
        setSerlist(serlist);
        setList(list);
        setTermlist(trlist);

		setLblprintname("SURVEY DETAILS");
		
		request.setAttribute("SITELIST", sitelist);
		request.setAttribute("SERLIST", serlist);
		request.setAttribute("LIST", list);
		request.setAttribute("TERMLIST", trlist);
		
		return "print";
	}




}
