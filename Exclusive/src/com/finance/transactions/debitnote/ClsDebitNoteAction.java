package com.finance.transactions.debitnote;

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
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsDebitNoteAction extends ActionSupport{
	
	ClsCommon commonDAO= new ClsCommon();
	ClsDebitNoteDAO debitNoteDAO= new ClsDebitNoteDAO();
	ClsDebitNoteBean debitNoteBean;

	private int txtdebitnotedocno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String jqxDebitNoteDate;
	private String hidjqxDebitNoteDate;
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
	private String currentdate;
    private String url; 
	 
	 
	

	public String getCurrentdate() {
		return currentdate;
	}

	public void setCurrentdate(String currentdate) {
		this.currentdate = currentdate;
	}

	private String lblclienttrno;
	

	//Debit-Note Grid
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
	private String lblcustmobno;
	private String lblcustphno;
	private String lblcustaddress;
	private String lblcustcodeno;
	
	public String getLblcustmobno() {
		return lblcustmobno;
	}

	public void setLblcustmobno(String lblcustmobno) {
		this.lblcustmobno = lblcustmobno;
	}

	public String getLblcustphno() {
		return lblcustphno;
	}

	public void setLblcustphno(String lblcustphno) {
		this.lblcustphno = lblcustphno;
	}

	public String getLblcustaddress() {
		return lblcustaddress;
	}

	public void setLblcustaddress(String lblcustaddress) {
		this.lblcustaddress = lblcustaddress;
	}

	public String getLblcustcodeno() {
		return lblcustcodeno;
	}

	public void setLblcustcodeno(String lblcustcodeno) {
		this.lblcustcodeno = lblcustcodeno;
	}

	private String lblcreditordebit;
	private String lbldocumentno;
	private String lbldate;
	private String lblaccountname;
	private String lbldescription;
	private String lbldebittotal;
	private String lblcredittotal;
	private String lblnetamount;
	private String lblnetamountwords;
	private String lblpreparedby;
	private String lblpreparedon;
	private String lblpreparedat;

	//for hide
	private int firstarray;
	private int txtheader;
	private String brchName;
	
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
		}
	
	public String getLblclienttrno() {
		return lblclienttrno;
	}

	public void setLblclienttrno(String lblclienttrno) {
		this.lblclienttrno = lblclienttrno;
	}

	public int getTxtdebitnotedocno() {
		return txtdebitnotedocno;
	}

	public void setTxtdebitnotedocno(int txtdebitnotedocno) {
		this.txtdebitnotedocno = txtdebitnotedocno;
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

	public String getJqxDebitNoteDate() {
		return jqxDebitNoteDate;
	}

	public void setJqxDebitNoteDate(String jqxDebitNoteDate) {
		this.jqxDebitNoteDate = jqxDebitNoteDate;
	}

	public String getHidjqxDebitNoteDate() {
		return hidjqxDebitNoteDate;
	}

	public void setHidjqxDebitNoteDate(String hidjqxDebitNoteDate) {
		this.hidjqxDebitNoteDate = hidjqxDebitNoteDate;
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

	public String getLblcomptrn() {
		return lblcomptrn;
	}

	public void setLblcomptrn(String lblcomptrn) {
		this.lblcomptrn = lblcomptrn;
	}
	
	public String getLblcreditordebit() {
		return lblcreditordebit;
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

	java.sql.Date debitNoteDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		session.setAttribute("BRANCHID", getBrchName());
		//System.out.println(getBrchName());
		String mode=getMode();
		ClsDebitNoteBean bean = new ClsDebitNoteBean();
		String rtype="0";
		int rdocno=0;
		
		debitNoteDate = commonDAO.changeStringtoSqlDate(getJqxDebitNoteDate());
		
		if(mode.equalsIgnoreCase("A")){
			/*Debit-Note Grid Saving*/
			ArrayList debitnotearray= new ArrayList();
			//debitnotearray.add(getTxtdocno()+"::"+getCmbcurrency()+"::"+getTxtrate()+"::false::"+getTxtamount()+"::"+getTxtdescription()+"::"+getTxtbaseamount());
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				debitnotearray.add(temp);
			}
			/*Debit-Note Grid Saving Ends*/
						int val=debitNoteDAO.insert(debitNoteDate,getFormdetailcode(),getTxtrefno(),getTxtrate(),getTxtdescription(),getTxtdocno(),getCmbcurrency(),getTxtamount(),getTxtdrtotal(),rtype,rdocno,debitnotearray,session,request,mode);
						if(val>0.0){
							
							setTxtdebitnotedocno(val);
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
			/*Updating Credit-Note Grid*/
			ArrayList debitnotearray= new ArrayList();
			//debitnotearray.add(getTxtdocno()+"::"+getCmbcurrency()+"::"+getTxtrate()+"::false::"+getTxtamount()+"::"+getTxtdescription()+"::"+getTxtbaseamount());
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				debitnotearray.add(temp);
			}
			/*Updating Credit-Note Grid Ends*/
			
			boolean Status=debitNoteDAO.edit(getTxtdebitnotedocno(),getFormdetailcode(),debitNoteDate,getTxtrefno(),getTxtdescription(),getCmbcurrency(),getTxtamount(),getTxtbaseamount(), getTxtrate(),getTxtdrtotal(),getTxtdocno(),getTxttrno(),getTxtdrtotal(),rtype,rdocno,debitnotearray,session,mode);
			if(Status){
				setTxtdebitnotedocno(getTxtdebitnotedocno());
				setTxttrno(getTxttrno());
				setData();
				
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setTxtdebitnotedocno(getTxtdebitnotedocno());
				setTxttrno(getTxttrno());
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("E")){

			boolean Status=debitNoteDAO.editMaster(getTxtdebitnotedocno(),getFormdetailcode(),debitNoteDate,getTxtrefno(),getTxtdescription(),getTxtrate(),getTxtdrtotal(),getTxtdocno(),getTxttrno(),session);
			if(Status){
				
				setTxtdebitnotedocno(getTxtdebitnotedocno());
				setTxttrno(getTxttrno());
				setData();
				
				setMsg("Updated Successfully");
			    return "success";
		}
		else{
			setTxtdebitnotedocno(getTxtdebitnotedocno());
			setTxttrno(getTxttrno());
			setData();
			setMsg("Not Updated");
			return "fail";
		}
	  }
		
		
		else if(mode.equalsIgnoreCase("D")){
			
			boolean Status=debitNoteDAO.delete(getTxtdebitnotedocno(),getTxtdocno(),getFormdetailcode(),getTxttrno(),session);
			if(Status){
				
				setTxtdebitnotedocno(getTxtdebitnotedocno());
				setTxttrno(getTxttrno());
				setData();
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setTxtdebitnotedocno(getTxtdebitnotedocno());
				setTxttrno(getTxttrno());
				setData();
				setMsg("Not Deleted");
				return "fail";
			   }
			}
		
		else if(mode.equalsIgnoreCase("View")){
	
			String branch=null;
			debitNoteBean=debitNoteDAO.getViewDetails(session,getTxtdebitnotedocno());
			
			setJqxDebitNoteDate(debitNoteBean.getJqxDebitNoteDate());
			setTxtrefno(debitNoteBean.getTxtrefno());
			
			setTxtdocno(debitNoteBean.getTxtdocno());
			setTxttrno(debitNoteBean.getTxttrno());
			setHidcmbtype(debitNoteBean.getCmbtype());
			setTxtaccid(debitNoteBean.getTxtaccid());
			setTxtaccname(debitNoteBean.getTxtaccname());
			setHidcmbcurrency(debitNoteBean.getHidcmbcurrency());
			setHidcurrencytype(debitNoteBean.getHidcurrencytype());
			setTxtrate(debitNoteBean.getTxtrate());
			setTxtamount(debitNoteBean.getTxtamount());
			setTxtbaseamount(debitNoteBean.getTxtbaseamount());
			setTxtdescription(debitNoteBean.getTxtdescription());

			setTxtdrtotal(debitNoteBean.getTxtdrtotal());
			setTxtcrtotal(debitNoteBean.getTxtdrtotal());
			setFormdetailcode(debitNoteBean.getFormdetailcode());
			
			return "success";
		}
		return "fail";
     }
	
	public String printAction() throws ParseException, SQLException,Exception{
		System.out.println("Action");
		HttpServletRequest request=ServletActionContext.getRequest();
	    HttpServletResponse response = ServletActionContext.getResponse();
	    HttpSession session=request.getSession();
		int docno=Integer.parseInt(request.getParameter("docno"));
		int header=Integer.parseInt(request.getParameter("header"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		debitNoteBean=debitNoteDAO.getPrint(request,docno,branch,header);
		
		setLblcreditordebit("Debited");
		setUrl(commonDAO.getPrintPath("DNO"));
		setLblclienttrno(debitNoteBean.getLblclienttrno());
		setLblcompname(debitNoteBean.getLblcompname());
		setLblcompaddress(debitNoteBean.getLblcompaddress());
		setLblpobox(debitNoteBean.getLblpobox());
		setLblprintname(debitNoteBean.getLblprintname());
		setLblcomptel(debitNoteBean.getLblcomptel());
		setLblcompfax(debitNoteBean.getLblcompfax());
		setLblbranch(debitNoteBean.getLblbranch());
		setLbllocation(debitNoteBean.getLbllocation());
		setLblservicetax(debitNoteBean.getLblservicetax());
		setLblpan(debitNoteBean.getLblpan());
		setLblcstno(debitNoteBean.getLblcstno());
		setLblcomptrn(debitNoteBean.getLblcomptrn());
		setLbldocumentno(debitNoteBean.getLbldocumentno());
		setLbldate(debitNoteBean.getLbldate());
		setLblaccountname(debitNoteBean.getLblaccountname());
		setLbldescription(debitNoteBean.getLbldescription());
		setLblnetamount(debitNoteBean.getLblnetamount());
		setLblnetamountwords(debitNoteBean.getLblnetamountwords());
		setLbldebittotal(debitNoteBean.getLbldebittotal());
		setLblcredittotal(debitNoteBean.getLblcredittotal());
		setLblpreparedby(debitNoteBean.getLblpreparedby());
		setLblpreparedon(debitNoteBean.getLblpreparedon());
		setLblpreparedat(debitNoteBean.getLblpreparedat());
		setLblcustaddress(debitNoteBean.getLblcustaddress());
		setLblcustcodeno(debitNoteBean.getLblcustcodeno());
		setLblcustmobno(debitNoteBean.getLblcustmobno());
		setLblcustphno(debitNoteBean.getLblcustphno());
		setCurrentdate(debitNoteBean.getCurrentdate());
		setTxtrefno(debitNoteBean.getTxtrefno());
		System.out.println("total========="+debitNoteBean.getLblcredittotal()+debitNoteBean.getLbldebittotal());
		
		// for hide
		setFirstarray(debitNoteBean.getFirstarray());
		setTxtheader(debitNoteBean.getTxtheader());
	
	
		
		if(commonDAO.getPrintPath("DNO").contains(".jrxml")==true){
			
		   param = new HashMap();
		   ClsConnection conobj=new ClsConnection();
       	   Connection conn = null;
       	          	   
       	 //  String reportFileName = "WorkshopInvoice";
       	   
       	   try{
       		   
       		conn = conobj.getMyConnection();	
       		
       		
       		
       		
       		   String imgpathheader=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
       		   imgpathheader=imgpathheader.replace("\\", "\\\\");    
       		   
       		 String imgpathfooter=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
     		   imgpathfooter=imgpathfooter.replace("\\", "\\\\");    
     		   
       		   param.put("client", debitNoteBean.getLblaccountname());
       		   param.put("trno", debitNoteBean.getLblclienttrno());
       		   param.put("description", debitNoteBean.getLbldescription());
       		   param.put("amtinwords", debitNoteBean.getLblnetamountwords());
       		   param.put("vocno", debitNoteBean.getLbldocumentno());
       		   param.put("vocdate", debitNoteBean.getLbldate());
       		   param.put("amount", debitNoteBean.getLblnetamount());
       		   param.put("branch", branch);
       		   param.put("docno", docno);
       		   param.put("imgheader", imgpathheader);
       		   param.put("imgfooter", imgpathfooter);
       		   param.put("header_stat", header);
       		   param.put("crtotal", debitNoteBean.getLblcredittotal());
       		   param.put("drtotal", debitNoteBean.getLbldebittotal());
       		   param.put("refno", debitNoteBean.getTxtrefno());
       		System.out.println("total=========inside jrxml"+debitNoteBean.getLblcredittotal()+debitNoteBean.getLbldebittotal());
       		   
       		   JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/finance/transactions/debitnote/TaxDebitNote.jrxml"));	      	     	 
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
				cellarray= debitNoteDAO.dnoMainSearch(session,docNo,date,accId,accName,amount,description,check);
		
			  } catch (SQLException e) {
				  e.printStackTrace();
				  }
			return cellarray;
		}
		
		public void setData(){
			
			setHidjqxDebitNoteDate(debitNoteDate.toString());
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
}

