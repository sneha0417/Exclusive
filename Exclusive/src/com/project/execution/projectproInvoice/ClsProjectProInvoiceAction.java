package com.project.execution.projectproInvoice;


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
import com.project.execution.projectInvoice.ClsProjectInvoiceDAO;
import com.project.execution.projectproInvoice.ClsProjectProInvoiceBean;
import com.project.execution.projectproInvoice.ClsProjectProInvoiceDAO;
import com.project.execution.quotation.ClsQuotationBean;
import com.project.execution.quotation.ClsQuotationDAO;


public class ClsProjectProInvoiceAction {

	ClsCommon com=new ClsCommon();
    ClsConnection connDAO = new ClsConnection();
    
	ClsProjectProInvoiceDAO proinvDAO= new ClsProjectProInvoiceDAO();
	ClsProjectProInvoiceBean proinvBean;

	private String date;
	private String hiddate;
	private String refno;
	private String brchName;
	private String clacno;
	private String searchtrno,txtcompany;
	private String txtclient;
	private String txtclientdet;
	private String cmbcontracttype;
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
	private String txttel;
	private String txtmob;
	private String txtemail;
	private String txtjobrefno; 
	private String cltelno;
	
	private int invgridlength;
	private int masterdoc_no;
	private int clientid;
	private int cpersonid;
	private int txtcontract;
	private int costid;
	private int maintrno;
	private int docno;
	
	private String txtlegalamt;
	private String txtseramt;
	private String txtnettotal;
	private String lblcltrnno;
	private String lblbranchtrno,sjobrefno;
	
	
	
	private ArrayList list;
	private ArrayList sitelist;
	private ArrayList serlist;
	private ArrayList termlist;
	private ArrayList paylist;
	private ArrayList seremirateslist;
	private ArrayList paygrid;
	
	
	
	public ArrayList getPaygrid() {
		return paygrid;
	}
	public void setPaygrid(ArrayList paygrid) {
		this.paygrid = paygrid;
	}
	public ArrayList getSeremirateslist() {
		return seremirateslist;
	}
	public void setSeremirateslist(ArrayList seremirateslist) {
		this.seremirateslist = seremirateslist;
	}
	public String getCltelno() {
		return cltelno;
	}
	public void setCltelno(String cltelno) {
		this.cltelno = cltelno;
	}
	public String getLblbranchtrno() {
		return lblbranchtrno;
	}
	public void setLblbranchtrno(String lblbranchtrno) {
		this.lblbranchtrno = lblbranchtrno;
	}
	public String getLblcltrnno() {
		return lblcltrnno;
	}
	public void setLblcltrnno(String lblcltrnno) {
		this.lblcltrnno = lblcltrnno;
	}
	public ArrayList getPaylist() {
		return paylist;
	}
	public void setPaylist(ArrayList paylist) {
		this.paylist = paylist;
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
	public String getTxtjobrefno() {
		return txtjobrefno;
	}
	public void setTxtjobrefno(String txtjobrefno) {
		this.txtjobrefno = txtjobrefno;
	}
	public int getCostid() {
		return costid;
	}
	public void setCostid(int costid) {
		this.costid = costid;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
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
	public String getTxtnettotal() {
		return txtnettotal;
	}
	public void setTxtnettotal(String txtnettotal) {
		this.txtnettotal = txtnettotal;
	}
	public int getTxtcontract() {
		return txtcontract;
	}
	public void setTxtcontract(int txtcontract) {
		this.txtcontract = txtcontract;
	}

	public String getSearchtrno() {
		return searchtrno;
	}
	public void setSearchtrno(String searchtrno) {
		this.searchtrno = searchtrno;
	}


	public String getTxtcompany() {
		return txtcompany;
	}
	public void setTxtcompany(String txtcompany) {
		this.txtcompany = txtcompany;
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
	public String getRefno() {
		return refno;
	}
	public void setRefno(String refno) {
		this.refno = refno;
	}
	public int getInvgridlength() {
		return invgridlength;
	}
	public void setInvgridlength(int invgridlength) {
		this.invgridlength = invgridlength;
	}
	public String getCmbcontracttype() {
		return cmbcontracttype;
	}
	public void setCmbcontracttype(String cmbcontracttype) {
		this.cmbcontracttype = cmbcontracttype;
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
	public ArrayList getList() {
		return list;
	}
	public void setList(ArrayList list) {
		this.list = list;
	}


	private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	
	public String getSjobrefno() {
		return sjobrefno;
	}
	public void setSjobrefno(String sjobrefno) {
		this.sjobrefno = sjobrefno;
	}

	public String saveAction()throws ParseException, SQLException{



		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		String searchtrno=getSearchtrno();

		int val=0;
		Double taxamt=0.0,taxtot=0.0;
		String nontax="0";
		ClsProjectProInvoiceDAO DAO=new ClsProjectProInvoiceDAO();

		if(mode.equals("A")){

			java.sql.Date date=com.changeStringtoSqlDate(getDate());

			ArrayList<String> enqarray= new ArrayList<>();
			for(int i=0;i<getInvgridlength();i++){
				String temp2=requestParams.get("prjinvtest"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();
				enqarray.add(temp2);

			}
			
			ArrayList taxlist=new ArrayList();
			
			double nettotal=Double.parseDouble(getTxtseramt())+Double.parseDouble(getTxtlegalamt());
			
			ClsProjectInvoiceDAO invDAO=new ClsProjectInvoiceDAO();
			taxlist=invDAO.getTax(session,nettotal,date,"0",getClientid());
			
			for(int t=0;t<taxlist.size();t++){

				String[] tmp=((String) taxlist.get(t)).split("::");

				//System.out.println("==tmp===="+tmp.length);

				taxamt=Double.parseDouble(tmp[3]);
				taxtot=taxtot+taxamt;
				//netotal=netotal;
			}
			
			val=DAO.insert(date,getRefno(),getCmbcontracttype(),getTxtcontract(),getTxtclient(),getTxtclientdet(),getDesc(),getBrchName(),getClacno(),getClientid(),getCostid(),enqarray,session,getMode(),getFormdetailcode(),request,getTxtlegalamt(),getTxtseramt(),taxtot,taxlist,nontax);
			if(val>0){

				setMaintrno(val);
				setDate(date+"");
				setdata();
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

			ArrayList<String> enqarray= new ArrayList<>();
			for(int i=0;i<getInvgridlength();i++){
				String temp2=requestParams.get("prjinvtest"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();
				enqarray.add(temp2);

			}

			ArrayList taxlist=new ArrayList();
			
			double nettotal=Double.parseDouble(getTxtseramt())+Double.parseDouble(getTxtlegalamt());
			
			ClsProjectInvoiceDAO invDAO=new ClsProjectInvoiceDAO();
			taxlist=invDAO.getTax(session,nettotal,date,"0",getClientid());
			
			for(int t=0;t<taxlist.size();t++){

				String[] tmp=((String) taxlist.get(t)).split("::");

				//System.out.println("==tmp===="+tmp.length);

				taxamt=Double.parseDouble(tmp[3]);
				taxtot=taxtot+taxamt;
				//netotal=netotal;
			}

			int	stat=DAO.edit(getMaintrno(),date,getRefno(),getCmbcontracttype(),getTxtcontract(),getTxtclient(),getTxtclientdet(),getDesc(),getBrchName(),
					getClacno(),getClientid(),getCostid(),enqarray,session,getMode(),getFormdetailcode(),request,getTxtlegalamt(),getTxtseramt(),taxtot,taxlist,nontax);
			if(stat>0){

				setMaintrno(stat);
				setDate(date+"");
				setdata();
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
			proinvBean=proinvDAO.getViewDetails(session,getMaintrno(),getBrchName());

			setDocno(proinvBean.getDocno());
			setDate(proinvBean.getDate()+"");
			setRefno(proinvBean.getRefno());
			setTxtclient(proinvBean.getTxtclient());
			setTxtclientdet(proinvBean.getTxtclientdet());
			setCmbcontracttype(proinvBean.getCmbcontracttype());
			setDesc(proinvBean.getDesc());

			setTxtcontract(proinvBean.getDocno());
			setMaintrno(proinvBean.getMaintrno());
			setClientid(proinvBean.getClientid());
			setClientid(proinvBean.getClientid());
			setClacno(proinvBean.getClacno());
			setCostid(proinvBean.getCostid());


			return "success";
		}

		return "fail";

	}

	public void setdata()
	{

		setDocno(getTxtcontract());
		setRefno(getRefno());
		setCmbcontracttype(getCmbcontracttype());
		setTxtcontract(getTxtcontract());
		setTxtclient(getTxtclient());
		setTxtclientdet(getTxtclientdet());
		setDesc(getDesc());
	}
	
	
	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		ClsProjectProInvoiceBean bean = new ClsProjectProInvoiceBean();
		ClsProjectProInvoiceDAO DAO= new  ClsProjectProInvoiceDAO();
		String dtype=request.getParameter("dtype").toString();
		
		setUrl(com.getPrintPath(dtype));
		String allbranch=request.getParameter("allbranch")==null?"0":request.getParameter("allbranch");
		String hidheader=request.getParameter("hidheader")==null?"0":request.getParameter("hidheader");
		String docno=request.getParameter("docno").toString();
		String brhid=request.getParameter("brhid").toString();
		String trno=request.getParameter("trno").toString();
		String header=request.getParameter("header").toString();
		String costid=request.getParameter("costid").toString();
		bean=DAO.printMaster(session,docno,brhid,trno,dtype,costid);
		
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
		setCltelno(bean.getCltelno());
		
		setLblcltrnno(bean.getLblcltrnno());
		setLblbranchtrno(bean.getLblbranchtrno());
		
		setLblprintname("PROFORMA INVOICE");
		setCmbcontracttype(bean.getCmbcontracttype());
		ArrayList sitelist=bean.getSitelist();
		ArrayList serlist=bean.getSerlist();
		ArrayList termlist=bean.getTermlist();
		ArrayList paylist=bean.getPaylist();
		ArrayList seremirateslist=bean.getSeremirateslist();
		ArrayList paygrid=bean.getPaygrid();
		
		setSitelist(sitelist);
		setSerlist(serlist);
		setTermlist(termlist);
		setPaylist(paylist);
		setSeremirateslist(seremirateslist);
		setPaygrid(paygrid);
		
		request.setAttribute("SITELIST", sitelist);
		request.setAttribute("SERLIST", serlist);
		request.setAttribute("TERMLIST", termlist);
		request.setAttribute("PAYLIST", paylist);
		request.setAttribute("seremirateslist", seremirateslist);
		request.setAttribute("paygrid", paygrid);
		
if(com.getPrintPath(dtype).contains(".jrxml")==true)
		{
			 HttpServletResponse response = ServletActionContext.getResponse();
	
			   Connection conn = null;
			 try {
				  
					String id=request.getParameter("id")==null?"0":request.getParameter("id");
				
					 param = new HashMap();
			   
			                conn = connDAO.getMyConnection();
			          
			                String imgpath=request.getSession().getServletContext().getRealPath("/icons/fire7header1.jpg");
			               	imgpath=imgpath.replace("\\", "\\\\");
			               	
			                String imgheaderpath=request.getSession().getServletContext().getRealPath("/icons/emiratesheader.jpg");
			                imgheaderpath=imgheaderpath.replace("\\", "\\\\");
			               	
			                String imgfooterpath=request.getSession().getServletContext().getRealPath("/icons/emiratesfooter.jpg");
			                imgfooterpath=imgfooterpath.replace("\\", "\\\\");
				        
				          param.put("imgpath", imgpath);
				          param.put("imgheaderpath", imgheaderpath);
				          param.put("imgfooterpath", imgfooterpath);
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
				         param.put("txtcompany",bean.getLblbranch());
				          
			             param.put("taxamount",bean.getTaxamount());
				         param.put("taxper", bean.getTaxpercent());
				         param.put("nettotal",bean.getNettotal());
				         param.put("vatstatus", bean.getInclusivestat());
				         param.put("tinno", bean.getTinno());
				         param.put("compname", bean.getLblcompname());
				         param.put("sjobrefno", bean.getSjobrefno());
				         //fire 7


			             param.put("srno1", bean.getMxrnomin());
			             param.put("mxrno1", bean.getMxrnomax());
			             param.put("total1", bean.getTotal1());
			             param.put("invoice1", bean.getInvoived());
			             param.put("balance1", bean.getBalance());
			             param.put("docno",bean.getDocno());
			             String contractpay="select @id:=@id+1 as srno,a.* from(select  round(amount,2) as amount, "
			                 + " IF(description IS NULL or description = '', '     ', description) description"
			                 + " from cm_srvcontrpd  where tr_no="+bean.getCostid()+") a,(select @id:=0) r";
			          param.put("contractpayment",contractpay);
			            // System.out.println("contractpay="+contractpay);
			             param.put("sitedetail", bean.getSitedetail());
			             param.put("amountinword", bean.getAmountinword());
				       String invoqry="select if (trtype='AMC',concat('Annual Maintenance Of Fire Protection System',' - ' ,description),concat('Fire Protection System',description))descp, "
			             		+ " '1' as qty,round(atotal,2) unitamount,round(atotal,2) amount,round(atotal,2) total from my_serpvm   where tr_no="+trno+"";
			             param.put("fire7proinvoqry", invoqry);
				           
				   
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
	   
	         
	}
	


	



}
