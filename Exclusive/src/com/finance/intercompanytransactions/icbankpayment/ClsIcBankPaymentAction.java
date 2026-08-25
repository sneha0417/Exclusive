package com.finance.intercompanytransactions.icbankpayment;

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
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsIcBankPaymentAction extends ActionSupport{

	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	
	ClsIcBankPaymentDAO icBankPaymentDAO= new ClsIcBankPaymentDAO();
	ClsIcBankPaymentBean icBankPaymentBean;

	private int txticbankpaymentdocno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String icBankPaymentDate;
	private String hidicBankPaymentDate;
	private String txtrefno;
	private int txtfromdocno;
	private String txtfromaccid;
	private String txtfromaccname;
	private String cmbfromcurrency;
	private String hidcmbfromcurrency;
	private String hidfromcurrencytype;
	private double txtfromrate;
	private double txtfromamount;
	private double txtfrombaseamount;
	private String txtchequename;
	private String txtchequeno;
	private String jqxChequeDate;
	private String hidjqxChequeDate;
	private String txtdescription;
	private String txtpaymentreceivedfrom;
	private int txttotrno;
	private int txttotranid;
	
	private double txtdrtotal;
	private double txtcrtotal;
	
	private String maindate;
	private String hidmaindate;
	
	private String url;
	
	//IC Cash Payment Grid
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
	private String lblnetamount;
	private String lblnetamountwords;
	private String lbldebittotal;
	private String lblcredittotal;
	private String lblchqno;
	private String lblchqdate;
	private String lblpreparedby;
	private String lblpreparedon;
	private String lblpreparedat;
	
	//for hide
	private int firstarray;
	private int secarray;
	private int txtheader;
	
	private Map<String, Object> param=null;
	
	public int getTxticbankpaymentdocno() {
		return txticbankpaymentdocno;
	}
	public void setTxticbankpaymentdocno(int txticbankpaymentdocno) {
		this.txticbankpaymentdocno = txticbankpaymentdocno;
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
	public String getIcBankPaymentDate() {
		return icBankPaymentDate;
	}
	public void setIcBankPaymentDate(String icBankPaymentDate) {
		this.icBankPaymentDate = icBankPaymentDate;
	}
	public String getHidicBankPaymentDate() {
		return hidicBankPaymentDate;
	}
	public void setHidicBankPaymentDate(String hidicBankPaymentDate) {
		this.hidicBankPaymentDate = hidicBankPaymentDate;
	}
	public String getTxtrefno() {
		return txtrefno;
	}
	public void setTxtrefno(String txtrefno) {
		this.txtrefno = txtrefno;
	}
	public int getTxtfromdocno() {
		return txtfromdocno;
	}
	public void setTxtfromdocno(int txtfromdocno) {
		this.txtfromdocno = txtfromdocno;
	}
	public String getTxtfromaccid() {
		return txtfromaccid;
	}
	public void setTxtfromaccid(String txtfromaccid) {
		this.txtfromaccid = txtfromaccid;
	}
	public String getTxtfromaccname() {
		return txtfromaccname;
	}
	public void setTxtfromaccname(String txtfromaccname) {
		this.txtfromaccname = txtfromaccname;
	}
	public String getCmbfromcurrency() {
		return cmbfromcurrency;
	}
	public void setCmbfromcurrency(String cmbfromcurrency) {
		this.cmbfromcurrency = cmbfromcurrency;
	}
	public String getHidcmbfromcurrency() {
		return hidcmbfromcurrency;
	}
	public void setHidcmbfromcurrency(String hidcmbfromcurrency) {
		this.hidcmbfromcurrency = hidcmbfromcurrency;
	}
	public String getHidfromcurrencytype() {
		return hidfromcurrencytype;
	}
	public void setHidfromcurrencytype(String hidfromcurrencytype) {
		this.hidfromcurrencytype = hidfromcurrencytype;
	}
	public double getTxtfromrate() {
		return txtfromrate;
	}
	public void setTxtfromrate(double txtfromrate) {
		this.txtfromrate = txtfromrate;
	}
	public double getTxtfromamount() {
		return txtfromamount;
	}
	public void setTxtfromamount(double txtfromamount) {
		this.txtfromamount = txtfromamount;
	}
	public double getTxtfrombaseamount() {
		return txtfrombaseamount;
	}
	public void setTxtfrombaseamount(double txtfrombaseamount) {
		this.txtfrombaseamount = txtfrombaseamount;
	}
	public String getTxtchequename() {
		return txtchequename;
	}
	public void setTxtchequename(String txtchequename) {
		this.txtchequename = txtchequename;
	}
	public String getTxtchequeno() {
		return txtchequeno;
	}
	public void setTxtchequeno(String txtchequeno) {
		this.txtchequeno = txtchequeno;
	}
	public String getJqxChequeDate() {
		return jqxChequeDate;
	}
	public void setJqxChequeDate(String jqxChequeDate) {
		this.jqxChequeDate = jqxChequeDate;
	}
	public String getHidjqxChequeDate() {
		return hidjqxChequeDate;
	}
	public void setHidjqxChequeDate(String hidjqxChequeDate) {
		this.hidjqxChequeDate = hidjqxChequeDate;
	}
	public String getTxtdescription() {
		return txtdescription;
	}
	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}
	public String getTxtpaymentreceivedfrom() {
		return txtpaymentreceivedfrom;
	}
	public void setTxtpaymentreceivedfrom(String txtpaymentreceivedfrom) {
		this.txtpaymentreceivedfrom = txtpaymentreceivedfrom;
	}
	public int getTxttotrno() {
		return txttotrno;
	}
	public void setTxttotrno(int txttotrno) {
		this.txttotrno = txttotrno;
	}
	public int getTxttotranid() {
		return txttotranid;
	}
	public void setTxttotranid(int txttotranid) {
		this.txttotranid = txttotranid;
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
	public String getLblchqno() {
		return lblchqno;
	}
	public void setLblchqno(String lblchqno) {
		this.lblchqno = lblchqno;
	}
	public String getLblchqdate() {
		return lblchqdate;
	}
	public void setLblchqdate(String lblchqdate) {
		this.lblchqdate = lblchqdate;
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
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	java.sql.Date icBankPaymentsDate;
	java.sql.Date hidicBankPaymentsDate;
	java.sql.Date chequeDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsIcBankPaymentBean bean = new ClsIcBankPaymentBean();
		icBankPaymentsDate = commonDAO.changeStringtoSqlDate(getIcBankPaymentDate());
		hidicBankPaymentsDate = commonDAO.changeStringtoSqlDate(getMaindate());
		chequeDate = commonDAO.changeStringtoSqlDate(getJqxChequeDate());
		
		if(mode.equalsIgnoreCase("A")){
			Connection conn = connDAO.getMyConnection();
			Statement stmtICBP = conn.createStatement();
			
			/*IC Bank Payment Grid Saving*/
			ArrayList<String> icbankpaymentarray= new ArrayList<String>();
			String mainBranch=session.getAttribute("BRANCHID").toString().trim();
			String mainCompany=session.getAttribute("COMPANYID").toString().trim();
			int interMainCompanyId=0;
			
			String sql="SELECT doc_no FROM intercompany.my_intrcomp WHERE cmpid='"+mainCompany+"' and brhid='"+mainBranch+"'";
			ResultSet resultSet = stmtICBP.executeQuery(sql);
			while (resultSet.next()) {
				interMainCompanyId = resultSet.getInt("doc_no");
			}
			
			icbankpaymentarray.add(getTxtfromdocno()+"::"+getCmbfromcurrency()+"::"+getTxtfromrate()+"::false::"+getTxtfromamount()*-1+"::"+getTxtdescription()+"::"+getTxtfrombaseamount()*-1+"::0::0::0:: "+"::"+mainBranch+"::"+interMainCompanyId+"::"+interMainCompanyId);
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0]+"::"+interMainCompanyId;
				icbankpaymentarray.add(temp);
			}
			/*IC Bank Payment Grid Saving Ends*/
			
						int val=icBankPaymentDAO.insert(icBankPaymentsDate,getFormdetailcode(),getTxtrefno(),getTxtfromrate(),chequeDate,getTxtchequeno(),getTxtchequename(),getTxtdescription(),getTxtpaymentreceivedfrom(),getTxtdrtotal(),icbankpaymentarray,session,request,mode);
						if(val>0.0){
							setTxticbankpaymentdocno(val);
							setTxttotrno(Integer.parseInt(request.getAttribute("tranno").toString()));
							setHidjqxChequeDate(chequeDate.toString());
							setData();
							
							setMsg("Successfully Saved");
							return "success";
						}
						else{
							setData();
							setHidjqxChequeDate(chequeDate.toString());
							setMsg("Not Saved");
							return "fail";
						}	
		}
		
		else if(mode.equalsIgnoreCase("EDIT")){
			Connection conn = connDAO.getMyConnection();
			Statement stmtICBP = conn.createStatement();
			
			/* Updating IC Bank Payment Grid*/
			ArrayList<String> icbankpaymentarray= new ArrayList<String>();
			String mainBranch=session.getAttribute("BRANCHID").toString().trim();
			String mainCompany=session.getAttribute("COMPANYID").toString().trim();
			int interMainCompanyId=0;
			
			String sql="SELECT doc_no FROM intercompany.my_intrcomp WHERE cmpid='"+mainCompany+"' and brhid='"+mainBranch+"'";
			ResultSet resultSet = stmtICBP.executeQuery(sql);
			while (resultSet.next()) {
				interMainCompanyId = resultSet.getInt("doc_no");
			}
			
			icbankpaymentarray.add(getTxtfromdocno()+"::"+getCmbfromcurrency()+"::"+getTxtfromrate()+"::false::"+getTxtfromamount()*-1+"::"+getTxtdescription()+"::"+getTxtfrombaseamount()*-1+"::0::0::0:: "+"::"+mainBranch+"::"+interMainCompanyId+"::"+interMainCompanyId);
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0]+"::"+interMainCompanyId;
				icbankpaymentarray.add(temp);
			}
			/* Updating IC Bank Payment Grid Ends*/
			
			boolean Status=icBankPaymentDAO.edit(getTxticbankpaymentdocno(),getFormdetailcode(),icBankPaymentsDate,getTxtrefno(),getTxtdescription(),getTxtfromrate(),chequeDate,getTxtchequeno(),getTxtchequename(),getTxtpaymentreceivedfrom(),getTxtdrtotal(),getTxttotrno(),icbankpaymentarray,session,mode);
			if(Status){
				setTxticbankpaymentdocno(getTxticbankpaymentdocno());
				setTxttotrno(getTxttotrno());
				setHidjqxChequeDate(chequeDate.toString());
				setData();
				
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setTxticbankpaymentdocno(getTxticbankpaymentdocno());
				setTxttotrno(getTxttotrno());
				setHidjqxChequeDate(chequeDate.toString());
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("E")){

			boolean Status=icBankPaymentDAO.editMaster(getTxticbankpaymentdocno(),getFormdetailcode(),icBankPaymentsDate,getTxtrefno(),getTxtdescription(),getTxtfromrate(),chequeDate,getTxtchequeno(),getTxtchequename(),getTxtpaymentreceivedfrom(),getTxtdrtotal(),getTxttotrno(),session);
			if(Status){
				setTxticbankpaymentdocno(getTxticbankpaymentdocno());
				setTxttotrno(getTxttotrno());
				setHidjqxChequeDate(chequeDate.toString());
				setData();
				
				setMsg("Updated Successfully");
			    return "success";
		}
		else{
			setTxticbankpaymentdocno(getTxticbankpaymentdocno());
			setTxttotrno(getTxttotrno());
			setHidjqxChequeDate(chequeDate.toString());
			setData();
			setMsg("Not Updated");
			return "fail";
		}
	  }
		
		
		else if(mode.equalsIgnoreCase("D")){
			
			boolean Status=icBankPaymentDAO.delete(getTxticbankpaymentdocno(),getFormdetailcode(),getTxttotrno(),session);
			if(Status){
				setTxticbankpaymentdocno(getTxticbankpaymentdocno());
				setTxttotrno(getTxttotrno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setTxticbankpaymentdocno(getTxticbankpaymentdocno());
				setTxttotrno(getTxttotrno());
				setData();
				setMsg("Not Deleted");
				return "fail";
			   }
			}
		
		else if(mode.equalsIgnoreCase("View")){
	
			String branch=null;
			icBankPaymentBean=icBankPaymentDAO.getViewDetails(session,getTxticbankpaymentdocno());
			
			setIcBankPaymentDate(icBankPaymentBean.getIcBankPaymentDate());
			setTxtrefno(icBankPaymentBean.getTxtrefno());
			
			setTxtfromdocno(icBankPaymentBean.getTxtfromdocno());
			setTxtfromaccid(icBankPaymentBean.getTxtfromaccid());
			setTxtfromaccname(icBankPaymentBean.getTxtfromaccname());
			setHidcmbfromcurrency(icBankPaymentBean.getHidcmbfromcurrency());
			setHidfromcurrencytype(icBankPaymentBean.getHidfromcurrencytype());
			setTxtfromrate(icBankPaymentBean.getTxtfromrate());
			setTxtfromamount(icBankPaymentBean.getTxtfromamount());
			setTxtfrombaseamount(icBankPaymentBean.getTxtfrombaseamount());
			setTxtchequename(icBankPaymentBean.getTxtchequename());
			setTxtchequeno(icBankPaymentBean.getTxtchequeno());
			setJqxChequeDate(icBankPaymentBean.getJqxChequeDate());
			setTxtdescription(icBankPaymentBean.getTxtdescription());
			setTxtpaymentreceivedfrom(icBankPaymentBean.getTxtpaymentreceivedfrom());
			
			setTxttotranid(icBankPaymentBean.getTxttotranid());
			setTxttotrno(icBankPaymentBean.getTxttotrno());
			
			setTxtdrtotal(icBankPaymentBean.getTxtdrtotal());
			setTxtcrtotal(icBankPaymentBean.getTxtcrtotal());
			setMaindate(icBankPaymentBean.getMaindate());
			setFormdetailcode(icBankPaymentBean.getFormdetailcode());
			
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
		icBankPaymentBean=icBankPaymentDAO.getPrint(request,docno,branch,header);
		
		setLblmainname("Paid To");
		setUrl(commonDAO.getPrintPath("ICBP"));
		setLblcompname(icBankPaymentBean.getLblcompname());
		setLblcompaddress(icBankPaymentBean.getLblcompaddress());
		setLblpobox(icBankPaymentBean.getLblpobox());
		setLblprintname(icBankPaymentBean.getLblprintname());
		setLblcomptel(icBankPaymentBean.getLblcomptel());
		setLblcompfax(icBankPaymentBean.getLblcompfax());
		setLblbranch(icBankPaymentBean.getLblbranch());
		setLbllocation(icBankPaymentBean.getLbllocation());
		setLblservicetax(icBankPaymentBean.getLblservicetax());
		setLblpan(icBankPaymentBean.getLblpan());
		setLblcstno(icBankPaymentBean.getLblcstno());
		setLblname(icBankPaymentBean.getLblname());
		setLblvoucherno(icBankPaymentBean.getLblvoucherno());
		setLbldescription(icBankPaymentBean.getLbldescription());
		setLbldate(icBankPaymentBean.getLbldate());
		setLblnetamount(icBankPaymentBean.getLblnetamount());
		setLblnetamountwords(icBankPaymentBean.getLblnetamountwords());
		setLbldebittotal(icBankPaymentBean.getLbldebittotal());
		setLblcredittotal(icBankPaymentBean.getLblcredittotal());
		setLblpreparedby(icBankPaymentBean.getLblpreparedby());
		setLblpreparedon(icBankPaymentBean.getLblpreparedon());
		setLblpreparedat(icBankPaymentBean.getLblpreparedat());
		
		// for hide
		setFirstarray(icBankPaymentBean.getFirstarray());
		setSecarray(icBankPaymentBean.getSecarray());
		setTxtheader(icBankPaymentBean.getTxtheader());
		
		if(commonDAO.getPrintPath("ICBP").contains(".jrxml")==true)
		{
			HttpServletResponse response = ServletActionContext.getResponse();
			
			Connection conn = null;
			
			try {
				 param = new HashMap();
			
			     conn = connDAO.getMyConnection();
	             Statement stmtPC = conn.createStatement();
					
				 String sql = "select d.brhid,ic.dbname FROM my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no left join intercompany.my_intrcomp ic on ic.doc_no=d.brhid WHERE "
							+ "m.dtype='ICBP' and m.brhId="+branch+" and m.doc_no="+docno+" and d.SR_NO>0";
					
					ResultSet resultSet = stmtPC.executeQuery (sql);
					
					int srno=1;
					String sqlICBankPayment="";
					while(resultSet.next()){
						String dbname=resultSet.getString("dbname");
						
						if(srno==1) {
							sqlICBankPayment+="SELECT CONCAT(ic.compname,' / ',ic.branchname) compbranch,t.account,t.description accountname,c.code currency,d.description accdesc,if(d.amount>0,round((d.amount*1),2),'  ') debit,if(d.amount<0,round((d.amount*-1),2),' ') credit "
										+ "FROM my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no left join "+dbname+".my_costunit f on d.costtype=f.costtype left join "+dbname+".my_head t on d.acno=t.doc_no left join "+dbname+".my_curr c on c.doc_no=d.curId left join "
										+ "intercompany.my_intrcomp ic on ic.doc_no=d.brhid WHERE m.dtype='ICBP' and m.brhId="+branch+" and m.doc_no="+docno+" and d.SR_NO="+srno+"";
						} else {
							sqlICBankPayment+=" UNION ALL SELECT CONCAT(ic.compname,' / ',ic.branchname) compbranch,t.account,t.description accountname,c.code currency,d.description accdesc,if(d.amount>0,round((d.amount*1),2),'  ') debit,if(d.amount<0,round((d.amount*-1),2),' ') credit "
										+ "FROM my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no left join "+dbname+".my_costunit f on d.costtype=f.costtype left join "+dbname+".my_head t on d.acno=t.doc_no left join "+dbname+".my_curr c on c.doc_no=d.curId left join "
										+ "intercompany.my_intrcomp ic on ic.doc_no=d.brhid WHERE m.dtype='ICBP' and m.brhId="+branch+" and m.doc_no="+docno+" and d.SR_NO="+srno+"";
						}
						srno++;
					}
					
	             String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
	             imgpath=imgpath.replace("\\", "\\\\");
	              	
	             param.put("header", new Integer(header));
			     param.put("imgpath", imgpath);
			     param.put("compname", icBankPaymentBean.getLblcompname());
			     param.put("compaddress", icBankPaymentBean.getLblcompaddress());
			     param.put("comptel", icBankPaymentBean.getLblcomptel());
			     param.put("compfax", icBankPaymentBean.getLblcompfax());
			     param.put("compbranch", icBankPaymentBean.getLblbranch());
			     param.put("location", icBankPaymentBean.getLbllocation());
			     param.put("icbankpaymentsql", sqlICBankPayment);
		         param.put("printname", icBankPaymentBean.getLblprintname());  
		         param.put("name", icBankPaymentBean.getLblname());
		         param.put("vno", icBankPaymentBean.getLblvoucherno());
		         param.put("descp", icBankPaymentBean.getLbldescription());
		         param.put("vdate", icBankPaymentBean.getLbldate());
		         param.put("vchqno", icBankPaymentBean.getLblchqno());
		         param.put("vchqdate", icBankPaymentBean.getLblchqdate());
		         param.put("amtword", icBankPaymentBean.getLblnetamountwords());
		         param.put("amt", icBankPaymentBean.getLblnetamount());
		         param.put("debtot", icBankPaymentBean.getLbldebittotal());
		         param.put("credtot", icBankPaymentBean.getLblcredittotal());
		         param.put("prepby", icBankPaymentBean.getLblpreparedby());
		         param.put("prepon", icBankPaymentBean.getLblpreparedon());
		         param.put("prepat", icBankPaymentBean.getLblpreparedat());
		         param.put("printby", session.getAttribute("USERNAME"));
		         
		         String path[]=commonDAO.getPrintPath("ICBP").split("icbankpayment/");
		         setUrl(path[1]);
		        
	             JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(commonDAO.getPrintPath("ICBP")));
         	 
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
		public JSONArray searchDetails( HttpSession session,String partyname,String docNo,String date,String amount,String check){
			  JSONArray cellarray = new JSONArray();
			  		  JSONObject cellobj = null;
			  		  
			  try {
				  cellarray= icBankPaymentDAO.icbpMainSearch(session,partyname,docNo,date,amount,check);
		
			  } catch (SQLException e) {
				  e.printStackTrace();
				  }
			return cellarray;
		}
		
		public void setData() {
			
			setHidicBankPaymentDate(icBankPaymentsDate.toString());
			setHidmaindate(hidicBankPaymentsDate.toString());
			setTxtrefno(getTxtrefno());
			
			setTxtfromdocno(getTxtfromdocno());
			setTxtfromaccid(getTxtfromaccid());
			setTxtfromaccname(getTxtfromaccname());
			setHidcmbfromcurrency(getCmbfromcurrency());
			setHidfromcurrencytype(getHidfromcurrencytype());
			setTxtfromrate(getTxtfromrate());
			setTxtfromamount(getTxtfromamount());
			setTxtfrombaseamount(getTxtfrombaseamount());
			setTxtchequename(getTxtchequename());
			setTxtchequeno(getTxtchequeno());
			setTxtdescription(getTxtdescription());
			setTxtpaymentreceivedfrom(getTxtpaymentreceivedfrom());
			
			setTxtdrtotal(getTxtdrtotal());
			setTxtcrtotal(getTxtdrtotal());
			setFormdetailcode(getFormdetailcode());
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

