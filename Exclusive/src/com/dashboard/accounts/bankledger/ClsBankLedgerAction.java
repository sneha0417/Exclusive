package com.dashboard.accounts.bankledger;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
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
import com.mailwithpdf.SendEmailAction;
import com.opensymphony.xwork2.ActionSupport;
@SuppressWarnings("serial")

public class ClsBankLedgerAction extends ActionSupport{
    
	ClsBankLedgerDAO bankLedgerDAO= new ClsBankLedgerDAO();
	ClsBankLedgerBean bankLedgerBean;
	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	
	private double txtnetamount;
	
	//Print
	private String lblcompname;
	private String lblcompaddress;
	private String lblprintname;
	private String lblprintname1;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	private String lblservicetax;
	private String lblpan;
	private String lblcstno;
	private String lblcomptel2;
	private String lblcompwebsite;
	private String lblcompemail;
	
	private String accountno;
	private String accountname;
	private String creditperiodmin;
	private String creditperiodmax;
	private String creditlimit;
	private String date;
	private String type;
	private String docno;
	private String description;
	private String debit;
	private String credit;
	private String lblnetdebitamount;
	private String lblnetcreditamount;
	private String lblnetamount;
	private String lblnetsecurityamount;
	
	private Map<String, Object> param = null;
	
	public double getTxtnetamount() {
		return txtnetamount;
	}
	public void setTxtnetamount(double txtnetamount) {
		this.txtnetamount = txtnetamount;
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
	public String getLblprintname1() {
		return lblprintname1;
	}
	public void setLblprintname1(String lblprintname1) {
		this.lblprintname1 = lblprintname1;
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
	public String getLblcomptel2() {
		return lblcomptel2;
	}
	public void setLblcomptel2(String lblcomptel2) {
		this.lblcomptel2 = lblcomptel2;
	}
	public String getLblcompwebsite() {
		return lblcompwebsite;
	}
	public void setLblcompwebsite(String lblcompwebsite) {
		this.lblcompwebsite = lblcompwebsite;
	}
	public String getLblcompemail() {
		return lblcompemail;
	}
	public void setLblcompemail(String lblcompemail) {
		this.lblcompemail = lblcompemail;
	}
	public String getAccountno() {
		return accountno;
	}
	public void setAccountno(String accountno) {
		this.accountno = accountno;
	}
	public String getAccountname() {
		return accountname;
	}
	public void setAccountname(String accountname) {
		this.accountname = accountname;
	}
	public String getCreditperiodmin() {
		return creditperiodmin;
	}
	public void setCreditperiodmin(String creditperiodmin) {
		this.creditperiodmin = creditperiodmin;
	}
	public String getCreditperiodmax() {
		return creditperiodmax;
	}
	public void setCreditperiodmax(String creditperiodmax) {
		this.creditperiodmax = creditperiodmax;
	}
	public String getCreditlimit() {
		return creditlimit;
	}
	public void setCreditlimit(String creditlimit) {
		this.creditlimit = creditlimit;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getDocno() {
		return docno;
	}
	public void setDocno(String docno) {
		this.docno = docno;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getDebit() {
		return debit;
	}
	public void setDebit(String debit) {
		this.debit = debit;
	}
	public String getCredit() {
		return credit;
	}
	public void setCredit(String credit) {
		this.credit = credit;
	}
	public String getLblnetdebitamount() {
		return lblnetdebitamount;
	}
	public void setLblnetdebitamount(String lblnetdebitamount) {
		this.lblnetdebitamount = lblnetdebitamount;
	}
	public String getLblnetcreditamount() {
		return lblnetcreditamount;
	}
	public void setLblnetcreditamount(String lblnetcreditamount) {
		this.lblnetcreditamount = lblnetcreditamount;
	}
	public String getLblnetamount() {
		return lblnetamount;
	}
	public void setLblnetamount(String lblnetamount) {
		this.lblnetamount = lblnetamount;
	}
	public String getLblnetsecurityamount() {
		return lblnetsecurityamount;
	}
	public void setLblnetsecurityamount(String lblnetsecurityamount) {
		this.lblnetsecurityamount = lblnetsecurityamount;
	}
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	
	public String saveAction() throws ParseException, SQLException{
		return accountname;
	}
	
	public void printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
	    HttpServletResponse response = ServletActionContext.getResponse();
	    Connection conn = null;
	    java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		try {
               
               conn = connDAO.getMyConnection();
               Statement stmtAccountStatement =conn.createStatement();
               param = new HashMap();
               String joins="";String casestatement="",sqlBankLedgerResult="0";
               
               int acno=Integer.parseInt(request.getParameter("acno"));
        	   String branch = request.getParameter("branch");
        	   String fromDate = request.getParameter("fromDate");
        	   String toDate = request.getParameter("toDate");
        	   String email = request.getParameter("email");
        	   String print = request.getParameter("print");
        	   
               if(!(fromDate.equalsIgnoreCase("undefined")) && !(fromDate.equalsIgnoreCase("")) && !(fromDate.equalsIgnoreCase("0"))){
                   sqlFromDate = commonDAO.changeStringtoSqlDate(fromDate);
               }
               if(!(toDate.equalsIgnoreCase("undefined")) && !(toDate.equalsIgnoreCase("")) && !(toDate.equalsIgnoreCase("0"))){
                   sqlToDate = commonDAO.changeStringtoSqlDate(toDate);
               }
             
        	   bankLedgerBean=bankLedgerDAO.getPrint(request,acno,branch,fromDate,toDate);
        		
               String reportFileName = "bankLedgerPrint";
               String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
               imgpath=imgpath.replace("\\", "\\\\");
                
               String bankledgersql = "";
       		
	       	   if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	       		   bankledgersql+=" and t.brhId="+branch+"";
	       	   }
	       		
	       	   joins=commonDAO.getFinanceVocTablesJoins(conn);
	       	   casestatement=commonDAO.getFinanceVocTablesCase(conn);
	       		
	       	   bankledgersql = "select "+casestatement+"DATE_FORMAT((a.trdate),'%d-%m-%Y') trdate,a.transtype,b.branchname,a.account,a.accountname,a.description,a.debit,a.credit,coalesce(round(@i:=@i+ldramount,2),0) netamountvalue,"
	       			+ "round(a.debit,2) netdebittotal,round((a.credit),2) netcredittotal,round((a.debit+(a.credit)*-1),2) nettotal  from ("
	       			+ "select t.brhid,transno,date(t.trdate) trdate,transtype,t.tr_des description,CONVERT(if(ldramount>0,round((ldramount*1),2),' '),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),' '),CHAR(50)) credit,"
	       			+ "ldramount,h.account,h.description accountname from my_head h inner join (select 0 brhid,DATE_SUB('"+sqlFromDate+"',INTERVAL 1 DAY) trdate,'OPN' ref_detail,'OPENING BALANCE' tr_des,t.acno,0 srno,0 tr_no, 1 curId, sum(t.dramount) dramount,"  
	       			+ "sum(t.ldramount) ldramount, 1 rate,0 transNo,'OPN' transType from my_jvtran t where t.status=3 and t.yrid=0 and t.date<'"+sqlFromDate+"' and t.acno="+acno+""+bankledgersql+" UNION ALL "
	       			+ "select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,t.tr_no,t.curId, (t.dramount*-1) dramount ,(t.ldramount*-1) ldramount,t.rate,t.doc_no transNo,"
	       			+ "t.dtype transType from my_jvtran t where t.tr_no in (select tr_no from my_jvtran where status=3 and date between '"+sqlFromDate+"' and '"+sqlToDate+"' and acno="+acno+" and yrid=0) and t.acno not in (select "+acno+" doc_no UNION ALL select doc_no from my_intr)) t on "
	       			+ "h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by trdate,acno,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid"+joins+",(select @i:=0) as i";
	       			
	       		ResultSet resultSetAccountStatement = stmtAccountStatement.executeQuery(bankledgersql);
	       		Double netdebittotal=0.00;Double netcredittotal=0.00;Double netamount=0.00;
	       		while(resultSetAccountStatement.next()){
	       			sqlBankLedgerResult="1";
	       			netdebittotal=netdebittotal+resultSetAccountStatement.getDouble("netdebittotal");
	       			netcredittotal=netcredittotal+resultSetAccountStatement.getDouble("netcredittotal");
	       			netamount=netamount+resultSetAccountStatement.getDouble("nettotal");
	       		}
	       		
	       		netdebittotal = commonDAO.Round(netdebittotal, 2);
	       		netcredittotal = commonDAO.Round(netcredittotal, 2);
	       		netamount = commonDAO.Round(netamount, 2);
               
	           param.put("imgpath", imgpath);
	           param.put("compname", bankLedgerBean.getLblcompname());
	           param.put("compaddress", bankLedgerBean.getLblcompaddress());
	           param.put("comptel", bankLedgerBean.getLblcomptel());
	           param.put("compfax", bankLedgerBean.getLblcompfax());
	           param.put("compbranch", bankLedgerBean.getLblbranch());
	           param.put("location", bankLedgerBean.getLbllocation());
	           param.put("printname", bankLedgerBean.getLblprintname());
	           param.put("subprintname", bankLedgerBean.getLblprintname1());
	           param.put("account", bankLedgerBean.getAccountno()+" - "+bankLedgerBean.getAccountname());
		       param.put("bankledgersql", bankledgersql);
		       param.put("bankledgercheck", sqlBankLedgerResult);
		       param.put("debittotal", String.valueOf(netdebittotal));
		       param.put("credittotal", String.valueOf(netcredittotal));
		       param.put("nettotal", String.valueOf(netamount));
		       param.put("printby", session.getAttribute("USERNAME"));
	        	 
               JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/accounts/bankledger/" + reportFileName + ".jrxml"));
     	       JasperReport jasperReport = JasperCompileManager.compileReport(design);
               generateReportPDF(response, param, jasperReport, conn, email, print, String.valueOf(acno));
      
             } catch (Exception e) {
                 e.printStackTrace();
                 conn.close();
         	} finally{
         		conn.close();
         	}
      	
	 }
	
	  private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn, String email, String print, String acno)throws JRException, NamingException, SQLException, IOException, AddressException, MessagingException {
  		  byte[] bytes = null;
          bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
          resp.reset();
          resp.resetBuffer();
          
          resp.setContentType("application/pdf");
          resp.setContentLength(bytes.length);
          ServletOutputStream ouputStream = resp.getOutputStream();
          
          if(print.equalsIgnoreCase("1")) {
          
	          ouputStream.write(bytes, 0, bytes.length);
	          ouputStream.flush();
	          ouputStream.close();
          } else {
        	
        	 Statement stmtAccountStatement1 =conn.createStatement();
        	  
        	String fileName="",path="", formcode="BBL",filepath=""; 
        	String strSql1 = "select imgPath from my_comp";

      		ResultSet rs1 = stmtAccountStatement1.executeQuery(strSql1);
      		while(rs1.next ()) {
      			path=rs1.getString("imgPath");
      		}

      		DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
    		java.util.Date date = new java.util.Date();
    		String currdate=dateFormat.format(date);
    		
      		fileName = "BankLedger["+bankLedgerBean.getAccountno()+"]"+currdate+".pdf";
      		filepath=path+ "/attachment/"+formcode+"/"+fileName;

      		File dir = new File(path+ "/attachment/"+formcode);
      		dir.mkdirs();
      		
      		FileOutputStream fos = new FileOutputStream(filepath);
        	fos.write(bytes);
        	fos.flush();
        	fos.close();
        	
        	File saveFile=new File(filepath);
			SendEmailAction sendmail= new SendEmailAction();
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
			sendmail.SendTomail( saveFile,formcode,email,acno,session.getAttribute("BRANCHID").toString().trim(),session.getAttribute("USERID").toString().trim(),bankLedgerBean.getAccountno());
			
          }
               
      }
}