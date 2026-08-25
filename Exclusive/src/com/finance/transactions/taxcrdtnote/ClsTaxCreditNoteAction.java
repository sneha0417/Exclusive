package com.finance.transactions.taxcrdtnote;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
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
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.finance.transactions.creditnote.ClsCreditNoteBean;
import com.finance.transactions.creditnote.ClsCreditNoteDAO;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsTaxCreditNoteAction extends ActionSupport{
	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsTaxCreditNoteDAO creditNoteDAO= new ClsTaxCreditNoteDAO();
	ClsTaxCreditNoteBean creditNoteBean;

	private int txtcreditnotedocno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String jqxCreditNoteDate;
	private String hidjqxCreditNoteDate;
	private String txtrefno;
	private int txtdocno;
	private int txttrno;
	private String cmbtype;
	private String hidcmbtype;
	private String txtaccid;
	private String txtaccname;
	private String cmbcurrency;
	private String hidcmbcurrency;
	private double txtrate;
	private double txtamount;
	private double txtbaseamount;
	private String txtdescription;
	private double txtdrtotal;
	private double txtcrtotal;
	private String hidcurrencytype;
    private String url;
    private String lblcustaddress;
    private String taxaccount;	 
	
	public String getLblcustaddress() {
		return lblcustaddress;
	}

	public void setLblcustaddress(String lblcustaddress) {
		this.lblcustaddress = lblcustaddress;
	}


	//Credit-Note Grid
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
	private String lblcomptrn;
	
	private String lblcreditordebit;
	private String lbldocumentno;
	private String lbldate;
	private String lblaccountname;
	private String lbldescription;
	private String lblnetamount;
	private String lblnetamountwords;
	private String lblvehicleinfo;
	private String lblagreement;
	private String lblclienttrno;
	private String lblinvoiceno;
	private String lbldebittotal;
	private String lblcredittotal;
	private String lblpreparedby;
	private String lblpreparedon;
	private String lblpreparedat;
	private String refno;
	private String brchName; 
	
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


	//for hide
	private int firstarray;
	private int txtheader;
		
	public int getTxtcreditnotedocno() {
		return txtcreditnotedocno;
	}

	public void setTxtcreditnotedocno(int txtcreditnotedocno) {
		this.txtcreditnotedocno = txtcreditnotedocno;
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

	public String getJqxCreditNoteDate() {
		return jqxCreditNoteDate;
	}

	public void setJqxCreditNoteDate(String jqxCreditNoteDate) {
		this.jqxCreditNoteDate = jqxCreditNoteDate;
	}

	public String getHidjqxCreditNoteDate() {
		return hidjqxCreditNoteDate;
	}

	public void setHidjqxCreditNoteDate(String hidjqxCreditNoteDate) {
		this.hidjqxCreditNoteDate = hidjqxCreditNoteDate;
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

	public int getTxttrno() {
		return txttrno;
	}

	public void setTxttrno(int txttrno) {
		this.txttrno = txttrno;
	}

	public void setTxtdocno(int txtdocno) {
		this.txtdocno = txtdocno;
	}

	public String getCmbtype() {
		return cmbtype;
	}

	public void setCmbtype(String cmbtype) {
		this.cmbtype = cmbtype;
	}

	public String getHidcmbtype() {
		return hidcmbtype;
	}

	public void setHidcmbtype(String hidcmbtype) {
		this.hidcmbtype = hidcmbtype;
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

	public String getHidcurrencytype() {
		return hidcurrencytype;
	}

	public void setHidcurrencytype(String hidcurrencytype) {
		this.hidcurrencytype = hidcurrencytype;
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

	public String getLblcreditordebit() {
		return lblcreditordebit;
	}

	public String getLblcomptrn() {
		return lblcomptrn;
	}

	public void setLblcomptrn(String lblcomptrn) {
		this.lblcomptrn = lblcomptrn;
	}
	
	public void setLblcreditordebit(String lblcreditordebit) {
		this.lblcreditordebit = lblcreditordebit;
	}

	public String getLbldocumentno() {
		return lbldocumentno;
	}

	public void setLbldocumentno(String lbldocumentno) {
		this.lbldocumentno = lbldocumentno;
	}

	public String getLbldate() {
		return lbldate;
	}

	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}

	public String getLblaccountname() {
		return lblaccountname;
	}

	public void setLblaccountname(String lblaccountname) {
		this.lblaccountname = lblaccountname;
	}

	public String getLbldescription() {
		return lbldescription;
	}

	public void setLbldescription(String lbldescription) {
		this.lbldescription = lbldescription;
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

	public String getLblvehicleinfo() {
		return lblvehicleinfo;
	}

	public void setLblvehicleinfo(String lblvehicleinfo) {
		this.lblvehicleinfo = lblvehicleinfo;
	}

	public String getLblagreement() {
		return lblagreement;
	}

	public void setLblagreement(String lblagreement) {
		this.lblagreement = lblagreement;
	}
	
	public String getLblclienttrno() {
		return lblclienttrno;
	}

	public void setLblclienttrno(String lblclienttrno) {
		this.lblclienttrno = lblclienttrno;
	}

	public String getLblinvoiceno() {
		return lblinvoiceno;
	}

	public void setLblinvoiceno(String lblinvoiceno) {
		this.lblinvoiceno = lblinvoiceno;
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

	private Map<String, Object> param = null;
	public Map<String, Object> getParam() {
				return param;
			}

			public void setParam(Map<String, Object> param) {
				this.param = param;
			}
	Connection conn;
	java.sql.Date creditNoteDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		session.setAttribute("BRANCHID", getBrchName());
		//System.out.println(getBrchName());
		String mode=getMode();
		ClsTaxCreditNoteBean bean = new ClsTaxCreditNoteBean();
		String rtype="0";
		int rdocno=0;
		
		creditNoteDate = commonDAO.changeStringtoSqlDate(getJqxCreditNoteDate());
		if(mode.equalsIgnoreCase("A")){
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			
			/*Credit-Note Grid Saving*/
			ArrayList creditnotearray= new ArrayList();
			//creditnotearray.add(getTxtdocno()+"::"+getCmbcurrency()+"::"+getTxtrate()+"::false::"+getTxtamount()+"::"+getTxtdescription()+"::"+getTxtbaseamount());
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				creditnotearray.add(temp);
			}
			
			/*Credit-Note Grid Saving Ends*/
						int val=creditNoteDAO.insert(conn,creditNoteDate,getFormdetailcode(),getTxtrefno(),getTxtrate(),getTxtdescription(),getTxtdocno(),getCmbcurrency(),getTxtamount(),getTxtdrtotal(),rtype,rdocno,creditnotearray,session,request,mode);
						if(val>0.0){
							
							setTxtcreditnotedocno(val);
							setTxttrno(Integer.parseInt(request.getAttribute("tranno").toString()));
							setData();
							conn.commit();
							conn.close();
							setMsg("Successfully Saved");
							return "success";
						}
						else{
							setData();
							conn.close();
							setMsg("Not Saved");
							return "fail";
						}	
		}
		
		else if(mode.equalsIgnoreCase("EDIT")){
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			
			/*Updating Credit-Note Grid*/
			ArrayList creditnotearray= new ArrayList();
			//creditnotearray.add(getTxtdocno()+"::"+getCmbcurrency()+"::"+getTxtrate()+"::false::"+getTxtamount()+"::"+getTxtdescription()+"::"+getTxtbaseamount());
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				creditnotearray.add(temp);
			}
			/*Updating Credit-Note Grid Ends*/
			
			boolean Status=creditNoteDAO.edit(conn,getTxtcreditnotedocno(),getFormdetailcode(),creditNoteDate,getTxtrefno(),getTxtdescription(),getCmbcurrency(),getTxtamount(),getTxtbaseamount(), getTxtrate(),getTxtdrtotal(),getTxtdocno(),getTxttrno(),getTxtdrtotal(),rtype,rdocno,creditnotearray,session, mode);
			if(Status){
				
				setTxtcreditnotedocno(getTxtcreditnotedocno());
				setTxttrno(getTxttrno());
				setData();
				conn.commit();
				conn.close();
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setTxtcreditnotedocno(getTxtcreditnotedocno());
				setTxttrno(getTxttrno());
				setData();
				conn.close();
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("E")){
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			boolean Status=creditNoteDAO.editMaster(conn,getTxtcreditnotedocno(),getFormdetailcode(),creditNoteDate,getTxtrefno(),getTxtdescription(),getTxtrate(),getTxtdrtotal(),getTxtdocno(),getTxttrno(),session);
			if(Status){
				setTxtcreditnotedocno(getTxtcreditnotedocno());
				setTxttrno(getTxttrno());
				setData();
				conn.commit();
				conn.close();
				setMsg("Updated Successfully");
			    return "success";
		}
		else{
			setTxtcreditnotedocno(getTxtcreditnotedocno());
			setTxttrno(getTxttrno());
			setData();
			conn.close();
			setMsg("Not Updated");
			return "fail";
		}
	  }
		
		
		else if(mode.equalsIgnoreCase("D")){
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			boolean Status=creditNoteDAO.delete(conn,getTxtcreditnotedocno(),getTxtdocno(),getFormdetailcode(),getTxttrno(),session);
			if(Status){
				setTxtcreditnotedocno(getTxtcreditnotedocno());
				setTxttrno(getTxttrno());
				setData();
				conn.commit();
				conn.close();
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setTxtcreditnotedocno(getTxtcreditnotedocno());
				setTxttrno(getTxttrno());
				setData();
				conn.close();
				setMsg("Not Deleted");
				return "fail";
			   }
			}
		
		else if(mode.equalsIgnoreCase("View")){
	
			String branch=null;
			creditNoteBean=creditNoteDAO.getViewDetails(session,getTxtcreditnotedocno());
			
			setJqxCreditNoteDate(creditNoteBean.getJqxCreditNoteDate());
			setTxtrefno(creditNoteBean.getTxtrefno());
			
			setTxtdocno(creditNoteBean.getTxtdocno());
			setTxttrno(creditNoteBean.getTxttrno());
			setHidcmbtype(creditNoteBean.getCmbtype());
			setTxtaccid(creditNoteBean.getTxtaccid());
			setTxtaccname(creditNoteBean.getTxtaccname());
			setHidcmbcurrency(creditNoteBean.getHidcmbcurrency());
			setHidcurrencytype(creditNoteBean.getHidcurrencytype());
			setTxtrate(creditNoteBean.getTxtrate());
			setTxtamount(creditNoteBean.getTxtamount());
			setTxtbaseamount(creditNoteBean.getTxtbaseamount());
			setTxtdescription(creditNoteBean.getTxtdescription());

			setTxtdrtotal(creditNoteBean.getTxtdrtotal());
			setTxtcrtotal(creditNoteBean.getTxtdrtotal());
			setFormdetailcode(creditNoteBean.getFormdetailcode());
			setTaxaccount(creditNoteBean.getTaxaccount());
			return "success";
		}
		return "fail";
     }
	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		 HttpServletResponse response = ServletActionContext.getResponse();
		HttpSession session=request.getSession();
		int docno=Integer.parseInt(request.getParameter("docno"));
		int header=Integer.parseInt(request.getParameter("header"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		creditNoteBean=creditNoteDAO.getPrint(request,docno,branch,header);
		
		setLblcreditordebit("Credited");
		setUrl(commonDAO.getPrintPath("TCN"));
		setLblcompname(creditNoteBean.getLblcompname());
		setLblcompaddress(creditNoteBean.getLblcompaddress());
		setLblpobox(creditNoteBean.getLblpobox());
		setLblprintname(creditNoteBean.getLblprintname());
		setLblcomptel(creditNoteBean.getLblcomptel());
		setLblcompfax(creditNoteBean.getLblcompfax());
		setLblbranch(creditNoteBean.getLblbranch());
		setLbllocation(creditNoteBean.getLbllocation());
		setLblservicetax(creditNoteBean.getLblservicetax());
		setLblpan(creditNoteBean.getLblpan());
		setLblcstno(creditNoteBean.getLblcstno());
		setLblcomptrn(creditNoteBean.getLblcomptrn());
		setLblaccountname(creditNoteBean.getLblaccountname());
		setLbldocumentno(creditNoteBean.getLbldocumentno());
		setLbldate(creditNoteBean.getLbldate());
		setLbldescription(creditNoteBean.getLbldescription());
		setLblnetamount(creditNoteBean.getLblnetamount());
		setLblnetamountwords(creditNoteBean.getLblnetamountwords());
		setLblvehicleinfo(creditNoteBean.getLblvehicleinfo());
		setLblagreement(creditNoteBean.getLblagreement());
		setLblclienttrno(creditNoteBean.getLblclienttrno());
		setLblinvoiceno(creditNoteBean.getLblinvoiceno());
		setLbldebittotal(creditNoteBean.getLbldebittotal());
		setLblcredittotal(creditNoteBean.getLblcredittotal());
		setLblpreparedby(creditNoteBean.getLblpreparedby());
		setLblpreparedon(creditNoteBean.getLblpreparedon());
		setLblpreparedat(creditNoteBean.getLblpreparedat());
		setRefno(creditNoteBean.getRefno());
		setLblcustaddress(creditNoteBean.getLblcustaddress());
		// for hide
		setFirstarray(creditNoteBean.getFirstarray());
		setTxtheader(creditNoteBean.getTxtheader());
	
		if(commonDAO.getPrintPath("TCN").contains(".jrxml")==true){
			System.out.println("inside jrxml"); 
		   param = new HashMap();
		   ClsConnection conobj=new ClsConnection();
       	   Connection conn = null;
       	          	   
       	 //  String reportFileName = "WorkshopInvoice";
       	   
       	   try{
       		   
       		conn = conobj.getMyConnection();	
       		
       	 String headerimge11=request.getSession().getServletContext().getRealPath("/icons/IGLOGO.jpg");
         headerimge11=headerimge11.replace("\\", "\\\\");
       		
       		
       		   String imgpathheader=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
       		   imgpathheader=imgpathheader.replace("\\", "\\\\");    
       		   
       		 String imgpathfooter=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
     		   imgpathfooter=imgpathfooter.replace("\\", "\\\\");    
     		   
       		   param.put("client", creditNoteBean.getLblaccountname());
       		   param.put("trno", creditNoteBean.getLblclienttrno());
       		   param.put("description", creditNoteBean.getLbldescription());
       		   param.put("amtinwords", creditNoteBean.getLblnetamountwords());
       		   param.put("vocno", creditNoteBean.getLbldocumentno());
       		   param.put("vocdate", creditNoteBean.getLbldate());
       		   param.put("amount", creditNoteBean.getLblnetamount());
       		   param.put("branch", branch);
       		   param.put("docno", docno);
       		   param.put("imgheader", imgpathheader);
       		   param.put("imgfooter", imgpathfooter);
       		   param.put("header_stat", header);
       		   param.put("crtotal", creditNoteBean.getLblcredittotal());
       		   param.put("drtotal", creditNoteBean.getLbldebittotal());
       		   param.put("refno", creditNoteBean.getRefno());
       		   param.put("tinno", creditNoteBean.getLblcomptrn());
       		 param.put("cmpname", "Exclusive Links Leasing and Property Management");
       		 param.put("cmplogo", headerimge11);
       		//System.out.println("total=========inside jrxml"+creditNoteBean.getLblcredittotal()+creditNoteBean.getLbldebittotal());
       		   
       		   JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/finance/transactions/taxcrdtnote/"+getUrl()));	
         	
	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
                  generateReportPDF(response, param, jasperReport, conn);
       	   }catch (Exception e) {
			       e.printStackTrace();
			   }
       	   finally{
       		   conn.close();
       	   }
		 }
	
	 return "print";
}

private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException,Exception {
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
	
	

		public JSONArray searchDetails(HttpSession session,String docNo,String date,String accId,String accName,String amount,String description,String check){
			  JSONArray cellarray = new JSONArray();
			  		  JSONObject cellobj = null;
			  try {
				cellarray= creditNoteDAO.cnoMainSearch(session,docNo,date,accId,accName,amount,description,check);
		
			  } catch (SQLException e) {
				  e.printStackTrace();
				  }
			return cellarray;
		}
		
		public void setData(){
			
			setHidjqxCreditNoteDate(creditNoteDate.toString());
			setTxtrefno(getTxtrefno());
			
			setTxtdocno(getTxtdocno());
			setTxttrno(getTxttrno());
			setTxtaccid(getTxtaccid());
			setHidcmbtype(getCmbtype());
			setTxtaccname(getTxtaccname());
			setHidcmbcurrency(getCmbcurrency());
			setHidcurrencytype(getHidcurrencytype());
			setTxtrate(getTxtrate());
			setTxtamount(getTxtamount());
			setTxtbaseamount(getTxtbaseamount());
			setTxtdescription(getTxtdescription());
			
			setTxtdrtotal(getTxtdrtotal());
			setTxtcrtotal(getTxtdrtotal());
			setFormdetailcode(getFormdetailcode());
		}

		public String getTaxaccount() {
			return taxaccount;
		}

		public void setTaxaccount(String taxaccount) {
			this.taxaccount = taxaccount;
		}
}
