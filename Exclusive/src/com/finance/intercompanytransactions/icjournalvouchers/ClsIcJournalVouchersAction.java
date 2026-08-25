package com.finance.intercompanytransactions.icjournalvouchers;

import java.io.IOException;
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

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

@SuppressWarnings("serial")
public class ClsIcJournalVouchersAction extends ActionSupport{

	ClsConnection connDAO = new ClsConnection();

	ClsCommon commonDAO= new ClsCommon();
	ClsIcJournalVouchersDAO icJournalVouchersDAO= new ClsIcJournalVouchersDAO();
	ClsIcJournalVouchersBean icJournalVouchersBean;

	private int txticjournalvouchersdocno;
	private String formdetailcode;
	private String brchName;
	private String mode;
	private String deleted;
	private String msg;
	private String icJournalVouchersDate;
	private String hidicJournalVouchersDate;
	private String txtrefno;
	private String txtdescription;
	private Double txtdrtotal;
	private Double txtcrtotal;
	private int txttrno;
	private String lblformposted;
	
	private String maindate;
	private String hidmaindate;
	
	private String url;
	
	//Journal Vouchers Grid
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
	
	private String lbldate;
	private String lblvoucherno;
	private String lblrefno;
	private String lblnetamount;
	private String lblnetamountwords;
	private String lbldescription;
	private String lbldebittotal;
	private String lblcredittotal;
	private String lblpreparedby;
	private String lblpreparedon;
	private String lblpreparedat;

	//for hide
	private int firstarray;
	private int txtheader;
	
	private Map<String, Object> param=null;

	public int getTxticjournalvouchersdocno() {
		return txticjournalvouchersdocno;
	}

	public void setTxticjournalvouchersdocno(int txticjournalvouchersdocno) {
		this.txticjournalvouchersdocno = txticjournalvouchersdocno;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getBrchName() {
		return brchName;
	}

	public void setBrchName(String brchName) {
		this.brchName = brchName;
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

	public String getIcJournalVouchersDate() {
		return icJournalVouchersDate;
	}

	public void setIcJournalVouchersDate(String icJournalVouchersDate) {
		this.icJournalVouchersDate = icJournalVouchersDate;
	}

	public String getHidicJournalVouchersDate() {
		return hidicJournalVouchersDate;
	}

	public void setHidicJournalVouchersDate(String hidicJournalVouchersDate) {
		this.hidicJournalVouchersDate = hidicJournalVouchersDate;
	}

	public String getTxtrefno() {
		return txtrefno;
	}

	public void setTxtrefno(String txtrefno) {
		this.txtrefno = txtrefno;
	}

	public String getTxtdescription() {
		return txtdescription;
	}

	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}

	public Double getTxtdrtotal() {
		return txtdrtotal;
	}

	public void setTxtdrtotal(Double txtdrtotal) {
		this.txtdrtotal = txtdrtotal;
	}

	public Double getTxtcrtotal() {
		return txtcrtotal;
	}

	public void setTxtcrtotal(Double txtcrtotal) {
		this.txtcrtotal = txtcrtotal;
	}

	public int getTxttrno() {
		return txttrno;
	}

	public void setTxttrno(int txttrno) {
		this.txttrno = txttrno;
	}

	public String getLblformposted() {
		return lblformposted;
	}

	public void setLblformposted(String lblformposted) {
		this.lblformposted = lblformposted;
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

	public String getLbldate() {
		return lbldate;
	}

	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}

	public String getLblvoucherno() {
		return lblvoucherno;
	}

	public void setLblvoucherno(String lblvoucherno) {
		this.lblvoucherno = lblvoucherno;
	}

	public String getLblrefno() {
		return lblrefno;
	}

	public void setLblrefno(String lblrefno) {
		this.lblrefno = lblrefno;
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

	public Map<String, Object> getParam() {
		return param;
	}

	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	java.sql.Date journalVouchersDate;
	java.sql.Date hidjournalVouchersDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		String mode=getMode();
		ClsIcJournalVouchersBean bean = new ClsIcJournalVouchersBean();

		journalVouchersDate = commonDAO.changeStringtoSqlDate(getIcJournalVouchersDate());
		hidjournalVouchersDate = commonDAO.changeStringtoSqlDate(getMaindate());
		
		if(mode.equalsIgnoreCase("A")){
			String mainCompany=session.getAttribute("COMPANYID").toString().trim();
			
			/*IC Journal Voucher Grid*/
			ArrayList<String> icjournalvouchersarray= new ArrayList<String>();
			for(int i=0;i<getGridlength();i++){
				ClsIcJournalVouchersBean icJournalVouchersBean=new ClsIcJournalVouchersBean();
				String temp=requestParams.get("test"+i)[0]+"::"+mainCompany;
				icjournalvouchersarray.add(temp);
			}
			/*IC Journal Voucher Grid Ends*/
			
						int val=icJournalVouchersDAO.insert(journalVouchersDate, getFormdetailcode().concat("-1"), getTxtrefno(), getTxtdescription(), getTxtdrtotal(), getTxtcrtotal(),
								icjournalvouchersarray,session,request);
						if(val>0.0){

							setTxticjournalvouchersdocno(val);
							setHidicJournalVouchersDate(journalVouchersDate.toString());
							setHidmaindate(hidjournalVouchersDate.toString());
							setTxttrno(Integer.parseInt(request.getAttribute("tranno").toString()));
							setData();
							
							setMsg("Successfully Saved");
							return "success";
						}
						else{
							setData();
							setHidicJournalVouchersDate(journalVouchersDate.toString());
							setHidmaindate(hidjournalVouchersDate.toString());
							setMsg("Not Saved");
							return "fail";
						}	
		}
		
		else if(mode.equalsIgnoreCase("EDIT")){
			String mainCompany=session.getAttribute("COMPANYID").toString().trim();
			/*Updating IC Journal Voucher Grid*/
			ArrayList<String> icjournalvouchersarray= new ArrayList<String>();
			for(int i=0;i<getGridlength();i++){
				ClsIcJournalVouchersBean icJournalVouchersBean=new ClsIcJournalVouchersBean();
				String temp=requestParams.get("test"+i)[0]+"::"+mainCompany;
				icjournalvouchersarray.add(temp);
			}
			/*Updating IC Journal Voucher Grid Ends*/
			
			boolean Status=icJournalVouchersDAO.edit(getTxticjournalvouchersdocno(), getFormdetailcode(),journalVouchersDate, getTxtrefno(), getTxtdescription(), getTxttrno(), getTxtdrtotal(), getTxtcrtotal(),icjournalvouchersarray,session);
			if(Status){
				setTxticjournalvouchersdocno(getTxticjournalvouchersdocno());
				setHidicJournalVouchersDate(journalVouchersDate.toString());
				setHidmaindate(hidjournalVouchersDate.toString());
				setTxttrno(getTxttrno());
				setData();
				
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setData();
				setHidicJournalVouchersDate(journalVouchersDate.toString());
				setHidmaindate(hidjournalVouchersDate.toString());
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("E")){

			boolean Status=icJournalVouchersDAO.editMaster(getTxticjournalvouchersdocno(), getFormdetailcode(),journalVouchersDate, getTxtrefno(), getTxtdescription(),getTxttrno(), getTxtdrtotal(), getTxtcrtotal(),session);
			if(Status){
				setTxticjournalvouchersdocno(getTxticjournalvouchersdocno());
				setHidicJournalVouchersDate(journalVouchersDate.toString());
				setHidmaindate(hidjournalVouchersDate.toString());
				setTxttrno(getTxttrno());
				setData();
				
				setMsg("Updated Successfully");
			    return "success";
		}
		else{
			setTxticjournalvouchersdocno(getTxticjournalvouchersdocno());
			setHidicJournalVouchersDate(journalVouchersDate.toString());
			setHidmaindate(hidjournalVouchersDate.toString());
			setTxttrno(getTxttrno());
			setData();
			setMsg("Not Updated");
			return "fail";
		}
	  }
		
		else if(mode.equalsIgnoreCase("D")){
			/*Updating IC Journal Voucher Grid*/
			ArrayList<String> icjournalvouchersarray= new ArrayList<>();
			for(int i=0;i<getGridlength();i++){
				ClsIcJournalVouchersBean icJournalVouchersBean=new ClsIcJournalVouchersBean();
				String temp=requestParams.get("test"+i)[0];
				icjournalvouchersarray.add(temp);
			}
			/*Updating IC Journal Voucher Grid Ends*/
			
			boolean Status=icJournalVouchersDAO.delete(getTxticjournalvouchersdocno(), getFormdetailcode(),getTxttrno(),session);
			if(Status){
				setTxticjournalvouchersdocno(getTxticjournalvouchersdocno());
				setTxttrno(getTxttrno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setData();
				setTxticjournalvouchersdocno(getTxticjournalvouchersdocno());
				setTxttrno(getTxttrno());
				setMsg("Not Deleted");
				return "fail";
			   }
			}
		
		else if(mode.equalsIgnoreCase("View")){
			
			icJournalVouchersBean=icJournalVouchersDAO.getViewDetails(getBrchName(),getTxticjournalvouchersdocno());
			
			setIcJournalVouchersDate(icJournalVouchersBean.getIcJournalVouchersDate());
			setTxtrefno(icJournalVouchersBean.getTxtrefno());
			setTxtdescription(icJournalVouchersBean.getTxtdescription());
			setTxtdrtotal(icJournalVouchersBean.getTxtdrtotal());
			setTxtcrtotal(icJournalVouchersBean.getTxtcrtotal());
			setTxttrno(icJournalVouchersBean.getTxttrno());
			setLblformposted(icJournalVouchersBean.getLblformposted());
			setMaindate(icJournalVouchersBean.getMaindate());
			setFormdetailcode(icJournalVouchersBean.getFormdetailcode());
			
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
		icJournalVouchersBean=icJournalVouchersDAO.getPrint(request,docno,branch,header);
		
		setUrl(commonDAO.getPrintPath("ICJV"));
		setLblcompname(icJournalVouchersBean.getLblcompname());
		setLblcompaddress(icJournalVouchersBean.getLblcompaddress());
		setLblpobox(icJournalVouchersBean.getLblpobox());
		setLblprintname(icJournalVouchersBean.getLblprintname());
		setLblcomptel(icJournalVouchersBean.getLblcomptel());
		setLblcompfax(icJournalVouchersBean.getLblcompfax());
		setLblbranch(icJournalVouchersBean.getLblbranch());
		setLbllocation(icJournalVouchersBean.getLbllocation());
		setLblservicetax(icJournalVouchersBean.getLblservicetax());
		setLblpan(icJournalVouchersBean.getLblpan());
		setLblcstno(icJournalVouchersBean.getLblcstno());
		setLbldate(icJournalVouchersBean.getLbldate());
		setLblvoucherno(icJournalVouchersBean.getLblvoucherno());
		setLblrefno(icJournalVouchersBean.getLblrefno());
		setLblnetamount(icJournalVouchersBean.getLblnetamount());
		setLblnetamountwords(icJournalVouchersBean.getLblnetamountwords());
		setLbldescription(icJournalVouchersBean.getLbldescription());
		setLbldebittotal(icJournalVouchersBean.getLbldebittotal());
		setLblcredittotal(icJournalVouchersBean.getLblcredittotal());
		setLblpreparedby(icJournalVouchersBean.getLblpreparedby());
		setLblpreparedon(icJournalVouchersBean.getLblpreparedon());
		setLblpreparedat(icJournalVouchersBean.getLblpreparedat());
		
		// for hide
		setFirstarray(icJournalVouchersBean.getFirstarray());
		setTxtheader(icJournalVouchersBean.getTxtheader());
	
		if(commonDAO.getPrintPath("ICJV").contains(".jrxml")==true)
		{
			 HttpServletResponse response = ServletActionContext.getResponse();
			
	         Connection conn = null;
	  
			 try {
				 param = new HashMap();
	             conn = connDAO.getMyConnection();
		         Statement stmtICJV = conn.createStatement();
						
				 String sql = "SELECT it.cmpid,ic.dbname FROM intercompany.my_intrcmptrno it left join intercompany.my_intrcomp ic on ic.doc_no=it.cmpid WHERE it.dtype='ICJV' and it.doc_no="+docno+"";
						
				 ResultSet resultSet = stmtICJV.executeQuery (sql);
						
				 int srno=1;
				 String sqlICJournalVoucher="";
				 while(resultSet.next()){
					 String dbname=resultSet.getString("dbname");
						
					 if(srno==1) {
							
							sqlICJournalVoucher+="SELECT CONCAT(cm.compname,' / ',cm.branchname) branch,t.account,t.description accountname,cr.code currency,j.description accdesc,if(j.dramount>0,round(j.dramount*j.id,2),0) debit,if(j.dramount<0,round(j.dramount*j.id,2),0) credit "
									+ "FROM "+dbname+".my_jvtran j left join "+dbname+".my_head t on j.acno=t.doc_no left join intercompany.my_intrcmp ic on j.acno=ic.doc_no left join intercompany.my_intrcomp cm on (j.brhid=cm.brhid and cm.dbname='"+dbname+"') left join "
									+ ""+dbname+".my_costunit c on j.costtype=c.costtype left join "+dbname+".my_curr cr on cr.doc_no=j.curId WHERE j.status<>7 and ic.doc_no is null and j.dtype='ICJV' and j.doc_no='"+docno+"'";
							
					 } else {
							
							sqlICJournalVoucher+=" UNION ALL SELECT CONCAT(cm.compname,' / ',cm.branchname) branch,t.account,t.description accountname,cr.code currency,j.description accdesc,if(j.dramount>0,round(j.dramount*j.id,2),0) debit,if(j.dramount<0,round(j.dramount*j.id,2),0) credit "
									+ "FROM "+dbname+".my_jvtran j left join "+dbname+".my_head t on j.acno=t.doc_no left join intercompany.my_intrcmp ic on j.acno=ic.doc_no left join intercompany.my_intrcomp cm on (j.brhid=cm.brhid and cm.dbname='"+dbname+"') left join "
									+ ""+dbname+".my_costunit c on j.costtype=c.costtype left join "+dbname+".my_curr cr on cr.doc_no=j.curId WHERE j.status<>7 and ic.doc_no is null and j.dtype='ICJV' and j.doc_no='"+docno+"'";
							
					 }
					 srno++;
				 }
	             
	             String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
	             imgpath=imgpath.replace("\\", "\\\\");
	              	
                 param.put("header", new Integer(header));
		         param.put("imgpath", imgpath);
		         param.put("compname", icJournalVouchersBean.getLblcompname());
		         param.put("compaddress", icJournalVouchersBean.getLblcompaddress());
		         param.put("comptel", icJournalVouchersBean.getLblcomptel());
		         param.put("compfax", icJournalVouchersBean.getLblcompfax());
		         param.put("compbranch", icJournalVouchersBean.getLblbranch());
		         param.put("location", icJournalVouchersBean.getLbllocation());
		         param.put("icjournalvouchersql", sqlICJournalVoucher);
		         param.put("printname", icJournalVouchersBean.getLblprintname());  
		         param.put("refno", icJournalVouchersBean.getLblrefno());
		         param.put("vno", icJournalVouchersBean.getLblvoucherno());
		         param.put("descp", icJournalVouchersBean.getLbldescription());
		         param.put("vdate", icJournalVouchersBean.getLbldate());
		         param.put("amtword", icJournalVouchersBean.getLblnetamountwords());
		         param.put("amt", icJournalVouchersBean.getLblnetamount());
		         param.put("debtot", icJournalVouchersBean.getLbldebittotal());
		         param.put("credtot", icJournalVouchersBean.getLblcredittotal());
		         param.put("prepby", icJournalVouchersBean.getLblpreparedby());
		         param.put("prepon", icJournalVouchersBean.getLblpreparedon());
		         param.put("prepat", icJournalVouchersBean.getLblpreparedat());
		         param.put("printby", session.getAttribute("USERNAME"));
		         
		         String path[]=commonDAO.getPrintPath("ICJV").split("icjournalvouchers/");
			     setUrl(path[1]);
		        	 
	             JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(commonDAO.getPrintPath("ICJV")));
	     	 
	     	     JasperReport jasperReport = JasperCompileManager.compileReport(design);
	             generateReportPDF(response, param, jasperReport, conn);
	      
	             } catch (Exception e) {
	                 e.printStackTrace();
	             }
	             finally {
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
	
	public void setData(){
		setFormdetailcode(getFormdetailcode());
		setTxtrefno(getTxtrefno());
		setTxtdescription(getTxtdescription());
		setTxtdrtotal(getTxtdrtotal());
		setTxtcrtotal(getTxtcrtotal());
	}

}

