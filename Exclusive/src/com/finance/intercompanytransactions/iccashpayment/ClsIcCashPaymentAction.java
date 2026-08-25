package com.finance.intercompanytransactions.iccashpayment;

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
public class ClsIcCashPaymentAction extends ActionSupport{

	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	
	ClsIcCashPaymentDAO icCashPaymentDAO= new ClsIcCashPaymentDAO();
	ClsIcCashPaymentBean icCashPaymentBean;

	private int txticcashpaymentdocno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String icCashPaymentDate;
	private String hidicCashPaymentDate;
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
	private String lblpreparedby;
	private String lblpreparedon;
	private String lblpreparedat;
	
	//for hide
	private int firstarray;
	private int secarray;
	private int txtheader;
	
	private Map<String, Object> param=null;

	public int getTxticcashpaymentdocno() {
		return txticcashpaymentdocno;
	}
	public void setTxticcashpaymentdocno(int txticcashpaymentdocno) {
		this.txticcashpaymentdocno = txticcashpaymentdocno;
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
	public String getIcCashPaymentDate() {
		return icCashPaymentDate;
	}
	public void setIcCashPaymentDate(String icCashPaymentDate) {
		this.icCashPaymentDate = icCashPaymentDate;
	}
	public String getHidicCashPaymentDate() {
		return hidicCashPaymentDate;
	}
	public void setHidicCashPaymentDate(String hidicCashPaymentDate) {
		this.hidicCashPaymentDate = hidicCashPaymentDate;
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

	java.sql.Date icCashPaymentsDate;
	java.sql.Date hidicCashPaymentsDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsIcCashPaymentBean bean = new ClsIcCashPaymentBean();
		icCashPaymentsDate = commonDAO.changeStringtoSqlDate(getIcCashPaymentDate());
		hidicCashPaymentsDate = commonDAO.changeStringtoSqlDate(getMaindate());
		
		if(mode.equalsIgnoreCase("A")){
			Connection conn = connDAO.getMyConnection();
			Statement stmtICCP = conn.createStatement();
			
			/*IC Cash Payment Grid Saving*/
			ArrayList<String> iccashpaymentarray= new ArrayList<String>();
			String mainBranch=session.getAttribute("BRANCHID").toString().trim();
			String mainCompany=session.getAttribute("COMPANYID").toString().trim();
			int interMainCompanyId=0;
			
			String sql="SELECT doc_no FROM intercompany.my_intrcomp WHERE cmpid='"+mainCompany+"' and brhid='"+mainBranch+"'";
			ResultSet resultSet = stmtICCP.executeQuery(sql);
			while (resultSet.next()) {
				interMainCompanyId = resultSet.getInt("doc_no");
			}
			
			iccashpaymentarray.add(getTxtfromdocno()+"::"+getCmbfromcurrency()+"::"+getTxtfromrate()+"::false::"+getTxtfromamount()*-1+"::"+getTxtdescription()+"::"+getTxtfrombaseamount()*-1+"::0::0::0:: "+"::"+mainBranch+"::"+interMainCompanyId+"::"+interMainCompanyId);
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0]+"::"+interMainCompanyId;
				iccashpaymentarray.add(temp);
			}
			/*IC Cash Payment Grid Saving Ends*/
			
						int val=icCashPaymentDAO.insert(icCashPaymentsDate,getFormdetailcode(),getTxtrefno(),getTxtfromrate(),getTxtdescription(),getTxtpaymentreceivedfrom(),getTxtdrtotal(),iccashpaymentarray,session,request,mode);
						if(val>0.0){
							setTxticcashpaymentdocno(val);
							setTxttotrno(Integer.parseInt(request.getAttribute("tranno").toString()));
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
			Connection conn = connDAO.getMyConnection();
			Statement stmtICCP = conn.createStatement();
			
			/* Updating IC Cash Payment Grid*/
			ArrayList<String> iccashpaymentarray= new ArrayList<String>();
			String mainBranch=session.getAttribute("BRANCHID").toString().trim();
			String mainCompany=session.getAttribute("COMPANYID").toString().trim();
			int interMainCompanyId=0;
			
			String sql="SELECT doc_no FROM intercompany.my_intrcomp WHERE cmpid='"+mainCompany+"' and brhid='"+mainBranch+"'";
			ResultSet resultSet = stmtICCP.executeQuery(sql);
			while (resultSet.next()) {
				interMainCompanyId = resultSet.getInt("doc_no");
			}
			
			iccashpaymentarray.add(getTxtfromdocno()+"::"+getCmbfromcurrency()+"::"+getTxtfromrate()+"::false::"+getTxtfromamount()*-1+"::"+getTxtdescription()+"::"+getTxtfrombaseamount()*-1+"::0::0::0:: "+"::"+mainBranch+"::"+interMainCompanyId+"::"+interMainCompanyId);
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0]+"::"+interMainCompanyId;
				iccashpaymentarray.add(temp);
			}
			/* Updating IC Cash Payment Grid Ends*/
			
			boolean Status=icCashPaymentDAO.edit(getTxticcashpaymentdocno(),getFormdetailcode(),icCashPaymentsDate,getTxtrefno(),getTxtdescription(),getTxtfromrate(),getTxtpaymentreceivedfrom(),getTxtdrtotal(),getTxttotrno(),iccashpaymentarray,session,mode);
			if(Status){
				setTxticcashpaymentdocno(getTxticcashpaymentdocno());
				setTxttotrno(getTxttotrno());
				setData();
				
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setTxticcashpaymentdocno(getTxticcashpaymentdocno());
				setTxttotrno(getTxttotrno());
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("E")){

			boolean Status=icCashPaymentDAO.editMaster(getTxticcashpaymentdocno(),getFormdetailcode(),icCashPaymentsDate,getTxtrefno(),getTxtdescription(),getTxtfromrate(),getTxtpaymentreceivedfrom(),getTxtdrtotal(),getTxttotrno(),session);
			if(Status){
				setTxticcashpaymentdocno(getTxticcashpaymentdocno());
				setTxttotrno(getTxttotrno());
				setData();
				
				setMsg("Updated Successfully");
			    return "success";
		}
		else{
			setTxticcashpaymentdocno(getTxticcashpaymentdocno());
			setTxttotrno(getTxttotrno());
			setData();
			setMsg("Not Updated");
			return "fail";
		}
	  }
		
		
		else if(mode.equalsIgnoreCase("D")){
			
			boolean Status=icCashPaymentDAO.delete(getTxticcashpaymentdocno(),getFormdetailcode(),getTxttotrno(),session);
			if(Status){
				setTxticcashpaymentdocno(getTxticcashpaymentdocno());
				setTxttotrno(getTxttotrno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setTxticcashpaymentdocno(getTxticcashpaymentdocno());
				setTxttotrno(getTxttotrno());
				setData();
				setMsg("Not Deleted");
				return "fail";
			   }
			}
		
		else if(mode.equalsIgnoreCase("View")){
	
			String branch=null;
			icCashPaymentBean=icCashPaymentDAO.getViewDetails(session,getTxticcashpaymentdocno());
			
			setIcCashPaymentDate(icCashPaymentBean.getIcCashPaymentDate());
			setTxtrefno(icCashPaymentBean.getTxtrefno());
			
			setTxtfromdocno(icCashPaymentBean.getTxtfromdocno());
			setTxtfromaccid(icCashPaymentBean.getTxtfromaccid());
			setTxtfromaccname(icCashPaymentBean.getTxtfromaccname());
			setHidcmbfromcurrency(icCashPaymentBean.getHidcmbfromcurrency());
			setHidfromcurrencytype(icCashPaymentBean.getHidfromcurrencytype());
			setTxtfromrate(icCashPaymentBean.getTxtfromrate());
			setTxtfromamount(icCashPaymentBean.getTxtfromamount());
			setTxtfrombaseamount(icCashPaymentBean.getTxtfrombaseamount());
			setTxtdescription(icCashPaymentBean.getTxtdescription());
			setTxtpaymentreceivedfrom(icCashPaymentBean.getTxtpaymentreceivedfrom());
			
			setTxttotranid(icCashPaymentBean.getTxttotranid());
			setTxttotrno(icCashPaymentBean.getTxttotrno());
			
			setTxtdrtotal(icCashPaymentBean.getTxtdrtotal());
			setTxtcrtotal(icCashPaymentBean.getTxtcrtotal());
			setMaindate(icCashPaymentBean.getMaindate());
			setFormdetailcode(icCashPaymentBean.getFormdetailcode());
			
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
		icCashPaymentBean=icCashPaymentDAO.getPrint(request,docno,branch,header);
		
		setLblmainname("Paid To");
		setUrl(commonDAO.getPrintPath("ICCP"));
		setLblcompname(icCashPaymentBean.getLblcompname());
		setLblcompaddress(icCashPaymentBean.getLblcompaddress());
		setLblpobox(icCashPaymentBean.getLblpobox());
		setLblprintname(icCashPaymentBean.getLblprintname());
		setLblcomptel(icCashPaymentBean.getLblcomptel());
		setLblcompfax(icCashPaymentBean.getLblcompfax());
		setLblbranch(icCashPaymentBean.getLblbranch());
		setLbllocation(icCashPaymentBean.getLbllocation());
		setLblservicetax(icCashPaymentBean.getLblservicetax());
		setLblpan(icCashPaymentBean.getLblpan());
		setLblcstno(icCashPaymentBean.getLblcstno());
		setLblname(icCashPaymentBean.getLblname());
		setLblvoucherno(icCashPaymentBean.getLblvoucherno());
		setLbldescription(icCashPaymentBean.getLbldescription());
		setLbldate(icCashPaymentBean.getLbldate());
		setLblnetamount(icCashPaymentBean.getLblnetamount());
		setLblnetamountwords(icCashPaymentBean.getLblnetamountwords());
		setLbldebittotal(icCashPaymentBean.getLbldebittotal());
		setLblcredittotal(icCashPaymentBean.getLblcredittotal());
		setLblpreparedby(icCashPaymentBean.getLblpreparedby());
		setLblpreparedon(icCashPaymentBean.getLblpreparedon());
		setLblpreparedat(icCashPaymentBean.getLblpreparedat());
		
		// for hide
		setFirstarray(icCashPaymentBean.getFirstarray());
		setSecarray(icCashPaymentBean.getSecarray());
		setTxtheader(icCashPaymentBean.getTxtheader());
		
		if(commonDAO.getPrintPath("ICCP").contains(".jrxml")==true)
		{
			HttpServletResponse response = ServletActionContext.getResponse();
			
			Connection conn = null;
			
			try {
				 param = new HashMap();
			
			     conn = connDAO.getMyConnection();
	             Statement stmtPC = conn.createStatement();
					
				 String sql = "select d.brhid,ic.dbname FROM my_cashbm m left join my_cashbd d on m.tr_no=d.tr_no left join intercompany.my_intrcomp ic on ic.doc_no=d.brhid WHERE "
							+ "m.dtype='ICCP' and m.brhId="+branch+" and m.doc_no="+docno+" and d.SR_NO>0";
					
					ResultSet resultSet = stmtPC.executeQuery (sql);
					
					int srno=1;
					String sqlICCashReceipt="";
					while(resultSet.next()){
						String dbname=resultSet.getString("dbname");
						
						if(srno==1) {
							sqlICCashReceipt+="SELECT CONCAT(ic.compname,' / ',ic.branchname) compbranch,t.account,t.description accountname,c.code currency,d.description accdesc,if(d.amount>0,round((d.amount*1),2),'  ') debit,if(d.amount<0,round((d.amount*-1),2),' ') credit "
										+ "FROM my_cashbm m left join my_cashbd d on m.tr_no=d.tr_no left join "+dbname+".my_costunit f on d.costtype=f.costtype left join "+dbname+".my_head t on d.acno=t.doc_no left join "+dbname+".my_curr c on c.doc_no=d.curId left join "
										+ "intercompany.my_intrcomp ic on ic.doc_no=d.brhid WHERE m.dtype='ICCP' and m.brhId="+branch+" and m.doc_no="+docno+" and d.SR_NO="+srno+"";
						} else {
							sqlICCashReceipt+=" UNION ALL SELECT CONCAT(ic.compname,' / ',ic.branchname) compbranch,t.account,t.description accountname,c.code currency,d.description accdesc,if(d.amount>0,round((d.amount*1),2),'  ') debit,if(d.amount<0,round((d.amount*-1),2),' ') credit "
										+ "FROM my_cashbm m left join my_cashbd d on m.tr_no=d.tr_no left join "+dbname+".my_costunit f on d.costtype=f.costtype left join "+dbname+".my_head t on d.acno=t.doc_no left join "+dbname+".my_curr c on c.doc_no=d.curId left join "
										+ "intercompany.my_intrcomp ic on ic.doc_no=d.brhid WHERE m.dtype='ICCP' and m.brhId="+branch+" and m.doc_no="+docno+" and d.SR_NO="+srno+"";
						}
						srno++;
					}
					
	             String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
	             imgpath=imgpath.replace("\\", "\\\\");
	              	
	             param.put("header", new Integer(header));
			     param.put("imgpath", imgpath);
			         
			     param.put("compname", icCashPaymentBean.getLblcompname());
			     param.put("compaddress", icCashPaymentBean.getLblcompaddress());
			        
			     param.put("comptel", icCashPaymentBean.getLblcomptel());
			     param.put("compfax", icCashPaymentBean.getLblcompfax());
			     param.put("compbranch", icCashPaymentBean.getLblbranch());
			     param.put("location", icCashPaymentBean.getLbllocation());
	            
			     param.put("iccashreceiptsql", sqlICCashReceipt);
		        
		         param.put("printname", icCashPaymentBean.getLblprintname());  
		         param.put("name", icCashPaymentBean.getLblname());
		         param.put("vno", icCashPaymentBean.getLblvoucherno());
		         param.put("descp", icCashPaymentBean.getLbldescription());
		         param.put("vdate", icCashPaymentBean.getLbldate());
		         param.put("amtword", icCashPaymentBean.getLblnetamountwords());
		         param.put("amt", icCashPaymentBean.getLblnetamount());
		         
		         param.put("debtot", icCashPaymentBean.getLbldebittotal());
		         param.put("credtot", icCashPaymentBean.getLblcredittotal());
		         
		         
		         param.put("prepby", icCashPaymentBean.getLblpreparedby());
		         param.put("prepon", icCashPaymentBean.getLblpreparedon());
		         param.put("prepat", icCashPaymentBean.getLblpreparedat());
		         
		         param.put("printby", session.getAttribute("USERNAME"));
		         
		         String path[]=commonDAO.getPrintPath("ICCP").split("iccashpayment/");
		         setUrl(path[1]);
		        
	             JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(commonDAO.getPrintPath("ICCP")));
         	 
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
				  cellarray= icCashPaymentDAO.iccpMainSearch(session,partyname,docNo,date,amount,check);
		
			  } catch (SQLException e) {
				  e.printStackTrace();
				  }
			return cellarray;
		}
		
		public void setData() {
			
			setHidicCashPaymentDate(icCashPaymentsDate.toString());
			setHidmaindate(hidicCashPaymentsDate.toString());
			setTxtrefno(getTxtrefno());
			
			setTxtfromdocno(getTxtfromdocno());
			setTxtfromaccid(getTxtfromaccid());
			setTxtfromaccname(getTxtfromaccname());
			setHidcmbfromcurrency(getCmbfromcurrency());
			setHidfromcurrencytype(getHidfromcurrencytype());
			setTxtfromrate(getTxtfromrate());
			setTxtfromamount(getTxtfromamount());
			setTxtfrombaseamount(getTxtfrombaseamount());
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

