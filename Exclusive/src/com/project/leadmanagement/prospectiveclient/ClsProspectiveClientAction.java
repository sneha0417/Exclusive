package com.project.leadmanagement.prospectiveclient;


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

import org.apache.http.HttpRequest;
import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.common.ClsNumberToWord;
import com.connection.ClsConnection;
import com.ibm.icu.text.DecimalFormat;
import com.project.leadmanagement.prospectiveclient.ClsProspectiveClientBean;
import com.project.leadmanagement.prospectiveclient.ClsProspectiveClientDAO;

public class ClsProspectiveClientAction {

	ClsCommon com=new ClsCommon();
ClsConnection connDAO = new ClsConnection();
	ClsProspectiveClientDAO prosclientDAO= new ClsProspectiveClientDAO();
	ClsProspectiveClientBean prosclientBean;

	private String date;
	private String hiddate;
	
	private String brchName;
	private String clacno;
	private String searchtrno;
	
	
	private String desc;
	private String mode;
	private String msg;
	private String deleted;
	private String formdetailcode;
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
	private String url;
	
	private String txtmob;
	private String txtemail;
	
	
	private int contactGridlength;
	

	private int masterdoc_no;
	
	private int costid;
	private int maintrno;
	private String docno;
	private String txtname;
	private int txtsalid;
	private String txtsalesman;
	
	private String txttelephone;
	private String txtfax;
	
	private String txtarea;
	private String txtareadet;
	private int txtareaid;
	private String txtenqsource;
	private int txtenqsourceid;
	
	private String chkstatus;
	
	
	public String getTxtenqsource() {
		return txtenqsource;
	}
	public void setTxtenqsource(String txtenqsource) {
		this.txtenqsource = txtenqsource;
	}
	public int getTxtenqsourceid() {
		return txtenqsourceid;
	}
	public void setTxtenqsourceid(int txtenqsourceid) {
		this.txtenqsourceid = txtenqsourceid;
	}
	public String getChkstatus() {
		return chkstatus;
	}
	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
	}
	public String getTxttelephone() {
		return txttelephone;
	}
	public void setTxttelephone(String txttelephone) {
		this.txttelephone = txttelephone;
	}
	public String getTxtfax() {
		return txtfax;
	}
	public void setTxtfax(String txtfax) {
		this.txtfax = txtfax;
	}
	public String getTxtarea() {
		return txtarea;
	}
	public void setTxtarea(String txtarea) {
		this.txtarea = txtarea;
	}
	public String getTxtareadet() {
		return txtareadet;
	}
	public void setTxtareadet(String txtareadet) {
		this.txtareadet = txtareadet;
	}
	public int getTxtareaid() {
		return txtareaid;
	}
	public void setTxtareaid(int txtareaid) {
		this.txtareaid = txtareaid;
	}
	
	public String getTxtsalesman() {
		return txtsalesman;
	}
	public void setTxtsalesman(String txtsalesman) {
		this.txtsalesman = txtsalesman;
	}
	public String getTxtname() {
		return txtname;
	}
	public void setTxtname(String txtname) {
		this.txtname = txtname;
	}
	public int getTxtsalid() {
		return txtsalid;
	}
	public void setTxtsalid(int txtsalid) {
		this.txtsalid = txtsalid;
	}

	public int getContactGridlength() {
		return contactGridlength;
	}
	public void setContactGridlength(int contactGridlength) {
		this.contactGridlength = contactGridlength;
	}

	
	public int getCostid() {
		return costid;
	}
	public void setCostid(int costid) {
		this.costid = costid;
	}
	public String getDocno() {
		return docno;
	}
	public void setDocno(String docno) {
		this.docno = docno;
	}
	

	public String getSearchtrno() {
		return searchtrno;
	}
	public void setSearchtrno(String searchtrno) {
		this.searchtrno = searchtrno;
	}


	public int getMaintrno() {
		return maintrno;
	}
	public void setMaintrno(int maintrno) {
		this.maintrno = maintrno;
	}
	public String getClacno() {
		return clacno;
	}
	public void setClacno(String clacno) {
		this.clacno = clacno;
	}
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}
	
	
	
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
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
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
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
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getHiddate() {
		return hiddate;
	}
	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
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
	

	private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	public String saveAction()throws ParseException, SQLException{

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		int val=0;
		ClsProspectiveClientDAO DAO=new ClsProspectiveClientDAO();

		if(mode.equals("A")){

			java.sql.Date date=com.changeStringtoSqlDate(getDate());

			ArrayList<String> cparray= new ArrayList<>();
			for(int i=0;i<getContactGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				cparray.add(temp);
			} 
			val=DAO.insert(date,getTxtname(),getTxtmob(),getTxtemail(),getTxtsalid(),getDesc(),
					getBrchName(),cparray,session,getMode(),getFormdetailcode(),request,getTxttelephone(),
					getTxtfax(),getTxtareaid(),getTxtenqsourceid());
			if(val==-1){

				//setMaintrno(val);
				setDate(date+"");
				setdata();
				setChkstatus("1");
				setMsg("Name Already Exist");
				return "fail";
			}
			else if(val==-2){

				//setMaintrno(val);
				setDate(date+"");
				setdata();
				setChkstatus("1");
				setMsg("Mobile No Already Exist");
				return "fail";
			}
			else if(val==-3){

				//setMaintrno(val);
				setDate(date+"");
				setdata();
				setChkstatus("1");
				setMsg("Telephone No Already Exist");
				return "fail";
			}
			else if(val==-4){

				//setMaintrno(val);
				setDate(date+"");
				setdata();
				setChkstatus("1");
				setMsg("Email id Already Exist");
				return "fail";
			}
			else if(val>0){

				setMaintrno(val);
				setDate(date+"");
				setDocno(request.getAttribute("documentno").toString());
				setdata();
				setChkstatus("0");
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setMaintrno(val);
				setDate(date+"");
				setdata();
				setMsg("Not Saved");
				return "fail";


			}

		}

		else if(mode.equalsIgnoreCase("E")){
			
			java.sql.Date date=com.changeStringtoSqlDate(getDate());

			ArrayList<String> cparray= new ArrayList<>();
			for(int i=0;i<getContactGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				cparray.add(temp);
			}


			int	stat=DAO.edit(getMaintrno(),getDocno(),date,getTxtname(),getTxtmob(),getTxtemail(),
					getTxtsalid(),getDesc(),getBrchName(),cparray,session,getMode(),getFormdetailcode(),
					request,getTxttelephone(),getTxtfax(),getTxtareaid(),getTxtenqsourceid());
			System.out.println("stat="+stat);
			if(stat==-1){

				//setMaintrno(val);
				setDate(date+"");
				setdata();
				setChkstatus("2");
				setMsg("Name Already Exist");
				return "fail";
			}
			else if(stat==-2){

				//setMaintrno(val);
				setDate(date+"");
				setdata();
				setChkstatus("2");
				setMsg("Mobile No Already Exist");
				return "fail";
			}
			else if(stat==-3){

				//setMaintrno(val);
				setDate(date+"");
				setdata();
				setChkstatus("2");
				setMsg("Telephone No Already Exist");
				return "fail";
			}
			else if(stat==-4){

				//setMaintrno(val);
				setDate(date+"");
				setdata();
				setChkstatus("2");
				setMsg("Email id Already Exist");
				return "fail";
			}
			else if(stat>0){

				setMaintrno(stat);
				setDocno(request.getAttribute("documentno").toString());
				setDate(date+"");
				setdata();
				setChkstatus("0");
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setMaintrno(stat);
				setDate(date+"");
				setdata();
				setMsg("Not Updated");
				return "fail";
			}
		}

		else if(mode.equalsIgnoreCase("view")){
		System.out.println("inside view==");
		System.out.println("getBrchName()=="+getBrchName());
		System.out.println("getMaintrno()=="+getMaintrno());
			prosclientBean=prosclientDAO.getViewDetails(session,getMaintrno());
			setDocno(prosclientBean.getDocno());
			setDate(prosclientBean.getDate()+"");
			setTxtname(prosclientBean.getTxtname());
			setTxtmob(prosclientBean.getTxtmob());
			setTxtemail(prosclientBean.getTxtemail());
			setTxtsalesman(prosclientBean.getTxtsalesman());
			setTxtsalid(prosclientBean.getTxtsalid());
			setDesc(prosclientBean.getDesc());
			setMaintrno(prosclientBean.getMaintrno());
			
			setTxtfax(prosclientBean.getTxtfax());
			setTxttelephone(prosclientBean.getTxttelephone());
			setTxtareaid(prosclientBean.getTxtareaid());
			setTxtareadet(prosclientBean.getTxtareadet());
			setTxtarea(prosclientBean.getTxtarea());
			setTxtenqsource(prosclientBean.getTxtenqsource());
			setTxtenqsourceid(prosclientBean.getTxtenqsourceid());
		

			return "success";
		}

		if(mode.equalsIgnoreCase("D")){

			java.sql.Date date=com.changeStringtoSqlDate(getDate());
			
			ArrayList<String> cparray= new ArrayList<>();
			
			int	stat=DAO.edit(getMaintrno(),getDocno(),date,getTxtname(),getTxtmob(),getTxtemail(),
					getTxtsalid(),getDesc(),getBrchName(),cparray,session,getMode(),getFormdetailcode(),
					request,getTxttelephone(),getTxtfax(),getTxtareaid(),getTxtenqsourceid());
			if(stat>0){

				setMaintrno(stat);
				setDocno(request.getAttribute("documentno").toString());
				setDate(date+"");
				setdata();
				setMsg("Deleted Successfully");
				return "success";
			}
			else{
				setMaintrno(stat);
				setDate(date+"");
				setdata();
				setMsg("Not Deleted");
				return "fail";
			}
		}

		
		return "fail";

	}

	public void setdata()
	{
	
		
		setTxtname(getTxtname());
		setTxtmob(getTxtmob());
		setTxtemail(getTxtemail());
		setTxtsalesman(getTxtsalesman());
		setTxtsalid(getTxtsalid());
		setTxtenqsource(getTxtenqsource());
		setTxtenqsourceid(getTxtenqsourceid());
		setDesc(getDesc());
	}
	
	
	
	/*public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		ClsProspectiveClientBean bean = new ClsProspectiveClientBean();
		ClsProspectiveClientDAO DAO= new  ClsProspectiveClientDAO();
		String dtype=request.getParameter("dtype").toString();
		setUrl(com.getPrintPath(dtype));
		String allbranch=request.getParameter("allbranch")==null?"0":request.getParameter("allbranch");
		String hidheader=request.getParameter("hidheader")==null?"0":request.getParameter("hidheader");
		String docno=request.getParameter("docno").toString();
		String brhid=request.getParameter("brhid").toString();
		String trno=request.getParameter("trno").toString();
		String header=request.getParameter("header").toString();
		bean=DAO.printMaster(session,docno,brhid,trno,dtype);
		
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
		setRefno(bean.getRefno());
		setList(bean.getList());
		setTxtcontract(bean.getDocno());
		setLblbranch(bean.getLblbranch());
		setLblcompaddress(bean.getLblcompaddress());
		setLblcompfax(bean.getLblcompfax());
		setLblcomptel(bean.getLblcomptel());
		setLbllocation(bean.getLbllocation());
		setAmountwords(bean.getAmountwords());
		setLblcompname(bean.getLblcompname());
		setLblcheckedby(session.getAttribute("USERNAME").toString().trim());
		setLblfinaldate(bean.getLblfinaldate());
		setLblbranch(bean.getLblbranch());
		setLblcompaddress(bean.getLblcompaddress());
		setLblcompfax(bean.getLblcompfax());
		setLblcomptel(bean.getLblcomptel());
		setLbllocation(bean.getLbllocation());
		setLblcompname(bean.getLblcompname());
		setLblfinaldate(bean.getLblfinaldate());
		setTxtjobrefno(bean.getTxtjobrefno());
		
		setLblprintname("PROFORMA INVOICE");
		setCmbcontracttype(bean.getCmbcontracttype());
		ArrayList sitelist=bean.getSitelist();
		ArrayList serlist=bean.getSerlist();
		ArrayList termlist=bean.getTermlist();
		ArrayList paylist=bean.getPaylist();
		
		setSitelist(sitelist);
		setSerlist(serlist);
		setTermlist(termlist);
		setPaylist(paylist);
		
		request.setAttribute("SITELIST", sitelist);
		request.setAttribute("SERLIST", serlist);
		request.setAttribute("TERMLIST", termlist);
		request.setAttribute("PAYLIST", paylist);
		
if(com.getPrintPath(dtype).contains(".jrxml")==true)
		{
			 HttpServletResponse response = ServletActionContext.getResponse();
	
			   Connection conn = null;
			 try {
				  
					String id=request.getParameter("id")==null?"0":request.getParameter("id");
				
					 param = new HashMap();
			   
			                conn = connDAO.getMyConnection();
			          
				        
				        
				          
				        param.put("txtclient", bean.getTxtclient());		         
				         param.put("clientdeta",bean.getTxtclientdet());
				         param.put("txtmob", bean.getTxtmob());
				         param.put("telno", bean.getTelph());
				         param.put("email", bean.getTxtemail());
				         param.put("date", bean.getDate());
				         
				         param.put("invono", docno);
				         param.put("refno", bean.getRefno());
				         param.put("jobrefno", bean.getTxtjobrefno());
				         param.put("cperson",bean.getCperson());
				         param.put("description", bean.getDesc());
			  
				        param.put("invoqry", bean.getProinvqry());     
				         param.put("printby", session.getAttribute("USERNAME"));
				   
				         double total=0,getcostid=0,totalamt=0;
				          Statement stmt = conn.createStatement ();
				      
							
						
			           JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(com.getPrintPath(dtype)));
		         	 
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
	   
	         
	}*/


	



}
