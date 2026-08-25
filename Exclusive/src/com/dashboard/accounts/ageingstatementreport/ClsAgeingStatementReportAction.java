package com.dashboard.accounts.ageingstatementreport;

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

public class ClsAgeingStatementReportAction extends ActionSupport{
    
	ClsAgeingStatementReportDAO accountStatementReportDAO= new ClsAgeingStatementReportDAO();
	ClsAgeingStatementReportBean ageingStatementReportBean;
	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	
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
	private String lblaccountno;
	private String lblaccountname;
	private String lblaccountaddress;
	private String lblaccountemail;
	private String lblaccountmobileno;
	private String lblaccountphone;
	private String lblaccountfax;
	private String lblcreditperiodmin;
	private String lblcreditperiodmax;
	private String lblcreditlimit;
	
	private String lblsumnetamount;
	private String lblsumapplied;
	private String lblsumbalance;
	
	private String lblsumoutnetamount;
	private String lblsumoutapplied;
	private String lblsumoutbalance;
	
	private String lblnetamount;
	
	//for hide
	private int firstarray;
	private int secarray;
	
	private Map<String, Object> param = null;
	
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


	public String getLblaccountno() {
		return lblaccountno;
	}


	public void setLblaccountno(String lblaccountno) {
		this.lblaccountno = lblaccountno;
	}


	public String getLblaccountname() {
		return lblaccountname;
	}


	public void setLblaccountname(String lblaccountname) {
		this.lblaccountname = lblaccountname;
	}


	public String getLblaccountaddress() {
		return lblaccountaddress;
	}


	public void setLblaccountaddress(String lblaccountaddress) {
		this.lblaccountaddress = lblaccountaddress;
	}


	public String getLblaccountemail() {
		return lblaccountemail;
	}


	public void setLblaccountemail(String lblaccountemail) {
		this.lblaccountemail = lblaccountemail;
	}


	public String getLblaccountmobileno() {
		return lblaccountmobileno;
	}


	public void setLblaccountmobileno(String lblaccountmobileno) {
		this.lblaccountmobileno = lblaccountmobileno;
	}


	public String getLblaccountphone() {
		return lblaccountphone;
	}


	public void setLblaccountphone(String lblaccountphone) {
		this.lblaccountphone = lblaccountphone;
	}


	public String getLblaccountfax() {
		return lblaccountfax;
	}


	public void setLblaccountfax(String lblaccountfax) {
		this.lblaccountfax = lblaccountfax;
	}


	public String getLblcreditperiodmin() {
		return lblcreditperiodmin;
	}


	public void setLblcreditperiodmin(String lblcreditperiodmin) {
		this.lblcreditperiodmin = lblcreditperiodmin;
	}


	public String getLblcreditperiodmax() {
		return lblcreditperiodmax;
	}


	public void setLblcreditperiodmax(String lblcreditperiodmax) {
		this.lblcreditperiodmax = lblcreditperiodmax;
	}


	public String getLblcreditlimit() {
		return lblcreditlimit;
	}


	public void setLblcreditlimit(String lblcreditlimit) {
		this.lblcreditlimit = lblcreditlimit;
	}


	public String getLblsumnetamount() {
		return lblsumnetamount;
	}


	public void setLblsumnetamount(String lblsumnetamount) {
		this.lblsumnetamount = lblsumnetamount;
	}


	public String getLblsumapplied() {
		return lblsumapplied;
	}


	public void setLblsumapplied(String lblsumapplied) {
		this.lblsumapplied = lblsumapplied;
	}


	public String getLblsumbalance() {
		return lblsumbalance;
	}


	public void setLblsumbalance(String lblsumbalance) {
		this.lblsumbalance = lblsumbalance;
	}


	public String getLblsumoutnetamount() {
		return lblsumoutnetamount;
	}


	public void setLblsumoutnetamount(String lblsumoutnetamount) {
		this.lblsumoutnetamount = lblsumoutnetamount;
	}


	public String getLblsumoutapplied() {
		return lblsumoutapplied;
	}


	public void setLblsumoutapplied(String lblsumoutapplied) {
		this.lblsumoutapplied = lblsumoutapplied;
	}


	public String getLblsumoutbalance() {
		return lblsumoutbalance;
	}


	public void setLblsumoutbalance(String lblsumoutbalance) {
		this.lblsumoutbalance = lblsumoutbalance;
	}


	public String getLblnetamount() {
		return lblnetamount;
	}


	public void setLblnetamount(String lblnetamount) {
		this.lblnetamount = lblnetamount;
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


	public Map<String, Object> getParam() {
		return param;
	}


	public void setParam(Map<String, Object> param) {
		this.param = param;
	}


public void printCustomerConformatnAction()throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();
	HttpSession session=request.getSession();
    Connection conn = null;
    String uptoDate = request.getParameter("uptoDate");
    
	try {
		conn = connDAO.getMyConnection();
       
        param = new HashMap();
		int acno=Integer.parseInt(request.getParameter("acno"));
		
		String reportFileName = "customerConfrm";
  	   
		String signimgpath=request.getSession().getServletContext().getRealPath("/icons/signature.png");
	       signimgpath=signimgpath.replace("\\", "\\\\");
		
		ageingStatementReportBean=accountStatementReportDAO.getCusConfirmPrint(request,acno);
		param.put("refname", ageingStatementReportBean.getRefname());
	        param.put("date", ageingStatementReportBean.getCur_date());
	        param.put("to_address", ageingStatementReportBean.getAddress());
	        param.put("aed_amount", ageingStatementReportBean.getAed_amount());
	        param.put("per_mob", ageingStatementReportBean.getPer_mob());
	        param.put("fax", ageingStatementReportBean.getFax());
	        param.put("upto_date", uptoDate);
	        param.put("imgsignature",signimgpath); 
	        param.put("email",ageingStatementReportBean.getEmail());
	        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/accounts/ageingstatementreport/" + reportFileName + ".jrxml"));
  	        JasperReport jasperReport = JasperCompileManager.compileReport(design);
  	        generateReportPDF(response, param, jasperReport, conn);
			
	}
	catch(Exception e){
		e.printStackTrace();
        conn.close();
	}
	
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
	public void printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpSession session=request.getSession();
	    Connection conn = null;
        java.sql.Date sqlUpToDate = null;
        
		try {
			conn = connDAO.getMyConnection();
	        Statement stmtAgeingStatementReport =conn.createStatement();
	        param = new HashMap();
	        String sqld="",sqld1="",joins="",casestatement="",sqlUnapplyResult="0";
	        
			String atype = request.getParameter("atype");
			int acno=Integer.parseInt(request.getParameter("acno"));
			String branch = request.getParameter("branch");
			String uptoDate = request.getParameter("uptoDate");
			String email = request.getParameter("email");
      	    String print = request.getParameter("print");
      	   
			if(!(uptoDate.equalsIgnoreCase("undefined")) && !(uptoDate.equalsIgnoreCase("")) && !(uptoDate.equalsIgnoreCase("0"))){
				sqlUpToDate = commonDAO.changeStringtoSqlDate(uptoDate);
            }
			
			ageingStatementReportBean=accountStatementReportDAO.getPrint(request,atype,acno,branch,uptoDate);
			String reportFileName = "ageingStatementReportPrint";
			
            String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
            imgpath=imgpath.replace("\\", "\\\\");
    		 
            if(atype.equalsIgnoreCase("AR")){
    			sqld=" and j.id < 0";
    			sqld1=" and j.id > 0";
    		}
    		else if(atype.equalsIgnoreCase("AP")){
    			sqld=" and j.id > 0";
    			sqld1=" and j.id < 0";
    		}
    		joins=commonDAO.getFinanceVocTablesJoins(conn);
    		casestatement=commonDAO.getFinanceVocTablesCase(conn);
    		
    		String sqlUnapply = "select "+casestatement+"a.date,a.transType,a.ref_detail,a.branchname,a.description,round(a.netamount,2) netamount,round(a.applied,2) applied,round(a.balance,2) balance,a.duedys,a.brhid from ("
    					+ "select j.doc_no transNo,coalesce(j.ref_detail,'') ref_detail,j.description,DATE_FORMAT((j.date),'%d-%m-%Y') date,j.dtype transType,round(sum(j.dramount)*j.id,2) netamount,round(coalesce(o.amount,0),2) applied," 
	    				+ "round((sum(dramount) - coalesce(o.amount,0)*id)*j.id,2) balance,j.brhId,b.branchname,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys from my_jvtran j inner join my_head h "
	    				+ "on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.AP_trid where j.date<='"+sqlUpToDate+"' group by tranid) o on "
	    				+ "j.tranid=o.tranid inner join my_brch b on j.brhId=b.doc_no where j.status=3 and h.atype='"+atype+"' and j.acno="+acno+" and j.date<='"+sqlUpToDate+"'"+sqld+" group by j.tranid having balance<>0 order by j.date) a"+joins+"";
					
			ResultSet resultSetUnapply = stmtAgeingStatementReport.executeQuery(sqlUnapply);
    		
    		while(resultSetUnapply.next()){
    			sqlUnapplyResult="1";
    		}
    		
    		if(sqlUnapplyResult.equalsIgnoreCase("0")){
    			sqlUnapply="select null date,null transno,null transType,null ref_detail,null branchname,null description,null netamount,null applied,null balance,null duedys";
    		}
    		
    		String sqlOutStanding = "select "+casestatement+"a.date,a.transType,a.ref_detail,a.branchname,a.description,round(a.netamount,2) netamount,round(a.applied,2) applied,round(a.balance,2) balance,a.duedys,a.brhid from ("
    					+ "select j.doc_no transNo,coalesce(j.ref_detail,'') ref_detail,j.description,DATE_FORMAT((j.date),'%d-%m-%Y') date,j.dtype transType,round(sum(j.dramount)*j.id,2) netamount,round(coalesce(o.amount,0),2) applied," 
	    				+ "round((sum(dramount) - coalesce(o.amount,0)*id)*j.id,2) balance,j.brhId,b.branchname,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys from my_jvtran j inner join my_head h "
	    				+ "on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.trANid where j.date<='"+sqlUpToDate+"' group by AP_trid) o on "
	    				+ "j.tranid=o.ap_trid inner join my_brch b on j.brhId=b.doc_no where j.status=3 and h.atype='"+atype+"' and j.acno="+acno+" and j.date<='"+sqlUpToDate+"'"+sqld1+" group by j.tranid having balance<>0 order by j.date) a"+joins+"";
    		
    		String sqlTotal = "select round(sum(unappliedramount),2) totalunappliedamount,round(sum(unappliedoutamount),2) totalapplied,round(sum(unappliedbalance),2) unappliedbalance,round(sum(applieddramount),2) totaloutamount,"
    				+ "round(sum(appliedoutamount),2) totaloutapplied,round(sum(appliedbalance),2) outstandingbalance,round(coalesce(sum(appliedbalance),0)-coalesce(sum(unappliedbalance),0),2) nettotal from (" +  
    				"select 0 applieddramount,0 appliedoutamount,0 appliedbalance,round(sum(j.dramount)*j.id,2) unappliedramount,"
    				+ "coalesce(o.amount,0) unappliedoutamount,round((sum(dramount) - coalesce(o.amount,0)*id)*j.id,2) unappliedbalance " +
    				" from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount "
    				+ "from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"'" +
    				" group by tranid) o on j.tranid=o.tranid inner join my_brch b on j.brhId=b.doc_no where j.status=3 and h.atype='"+atype+"' and j.acno="+acno+" and j.date<='"+sqlUpToDate+"'"+sqld+" and j.id < 0  group by j.tranid having unappliedbalance<>0 UNION ALL" +
    				" select round(sum(j.dramount)*j.id,2) applieddramount,coalesce(o.amount,0)*id appliedoutamount,round((sum(dramount) - coalesce(o.amount,0)*id)*j.id,2) appliedbalance,0 unappliedramount,0 unappliedoutamount,0 unappliedbalance from my_jvtran j" +
    				" inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.tranid where j.date<='"+sqlUpToDate+"' group by ap_trid) o on j.tranid=o.ap_trid " +
    				" inner join my_brch b on j.brhId=b.doc_no where j.status=3 and h.atype='"+atype+"' and j.acno="+acno+" and j.date<='"+sqlUpToDate+"'"+sqld1+" and j.id > 0 group by j.tranid having appliedbalance<>0) a";
    		
    		ResultSet resultSetTotal = stmtAgeingStatementReport.executeQuery(sqlTotal);
    		
    		while(resultSetTotal.next()){
    			ageingStatementReportBean.setLblsumnetamount(resultSetTotal.getString("totalunappliedamount"));
    			ageingStatementReportBean.setLblsumapplied(resultSetTotal.getString("totalapplied"));
    			ageingStatementReportBean.setLblsumbalance(resultSetTotal.getString("unappliedbalance"));
    			
    			ageingStatementReportBean.setLblsumoutnetamount(resultSetTotal.getString("totaloutamount"));
    			ageingStatementReportBean.setLblsumoutapplied(resultSetTotal.getString("totaloutapplied"));
    			ageingStatementReportBean.setLblsumoutbalance(resultSetTotal.getString("outstandingbalance"));
    			
    			ageingStatementReportBean.setLblnetamount(resultSetTotal.getString("nettotal"));
    		}
    		
    		String unclearedreceiptssql = "",sqlUnclrAccountStatementResult="0";
	       	Double netunclrdebittotal=0.00;Double netunclrcredittotal=0.00;Double netunclramount=0.00;
	       	   
    		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
       			unclearedreceiptssql+=" and m.brhId="+branch+"";
       		}
   		
       		unclearedreceiptssql="select a.*,coalesce(round(@i:=@i+amount,2),0) netamountvalue from (SELECT m.doc_no,DATE_FORMAT((m.date),'%d-%m-%Y') date,m.dtype,m.chqno,DATE_FORMAT((m.chqdt),'%d-%m-%Y') chqdt,m.chqname,CONVERT(if(d.amount>0,round((d.amount*1),2),null),CHAR(100)) debit,"  
       		   		+ "CONVERT(if(d.amount<0,round((d.amount*-1),2),' '),CHAR(100)) credit,d.amount FROM my_unclrchqreceiptm m left join my_unclrchqreceiptd d on m.doc_no=d.rdocno where m.status=3 and m.bpvno=0 and d.acno="+acno+""+unclearedreceiptssql+") a,"
       				+ "(select @i:=0) as i";
       		ResultSet resultSetUnclearAccountStatement = stmtAgeingStatementReport.executeQuery(unclearedreceiptssql);
       		
       		while(resultSetUnclearAccountStatement.next()){
       			sqlUnclrAccountStatementResult="1";
       			netunclrdebittotal=netunclrdebittotal+resultSetUnclearAccountStatement.getDouble("debit");
       			netunclrcredittotal=netunclrcredittotal+resultSetUnclearAccountStatement.getDouble("credit");
       		}
       		
       		netunclramount=netunclrdebittotal-netunclrcredittotal;
       		
       		netunclrdebittotal = commonDAO.Round(netunclrdebittotal, 2);
       		netunclrcredittotal = commonDAO.Round(netunclrcredittotal, 2);
       		netunclramount = commonDAO.Round(netunclramount, 2);
            
            param.put("imgpath", imgpath);
            param.put("compname", ageingStatementReportBean.getLblcompname());
            param.put("compaddress", ageingStatementReportBean.getLblcompaddress());
            param.put("comptel", ageingStatementReportBean.getLblcomptel());
            param.put("compfax", ageingStatementReportBean.getLblcompfax());
            param.put("compbranch", ageingStatementReportBean.getLblbranch());
            param.put("location", ageingStatementReportBean.getLbllocation());
            param.put("printname", ageingStatementReportBean.getLblprintname());
            param.put("subprintname", ageingStatementReportBean.getLblprintname1());
	        param.put("account", ageingStatementReportBean.getLblaccountno()+" - "+ageingStatementReportBean.getLblaccountname());
            param.put("customeraddress", ageingStatementReportBean.getLblaccountaddress());
            param.put("customeremail", ageingStatementReportBean.getLblaccountemail());
            param.put("customermobile", ageingStatementReportBean.getLblaccountmobileno());
            param.put("customerphone", ageingStatementReportBean.getLblaccountphone());
            param.put("customerfax", ageingStatementReportBean.getLblaccountfax());
            param.put("creditperiod", ageingStatementReportBean.getLblcreditperiodmin()+" (Days)");
	        param.put("creditlimit", ageingStatementReportBean.getLblcreditlimit());
	        param.put("ageingstatementunapplysql", sqlUnapply);
	        param.put("unappliedtotalamount", ageingStatementReportBean.getLblsumnetamount());
	        param.put("unappliedtotalapplied", ageingStatementReportBean.getLblsumapplied());
	        param.put("unappliedtotalbalance", ageingStatementReportBean.getLblsumbalance());
	        param.put("ageingstatementoutstandingsql", sqlOutStanding);
	        param.put("outstandingtotalamount", ageingStatementReportBean.getLblsumoutnetamount());
	        param.put("outstandingtotalapplied", ageingStatementReportBean.getLblsumoutapplied());
	        param.put("outstandingtotalbalance", ageingStatementReportBean.getLblsumoutbalance());
	        param.put("nettotalamount", ageingStatementReportBean.getLblnetamount());
		    param.put("unclearedreceiptssql", unclearedreceiptssql);
		    param.put("unclearedreceiptscheck", sqlUnclrAccountStatementResult);
		    param.put("unclrdebittotal", String.valueOf(netunclrdebittotal));
		    param.put("unclrcredittotal", String.valueOf(netunclrcredittotal));
		    param.put("unclrnettotal", String.valueOf(netunclramount));
	        param.put("printby", session.getAttribute("USERNAME"));
	        
	        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/accounts/ageingstatementreport/" + reportFileName + ".jrxml"));
  	        JasperReport jasperReport = JasperCompileManager.compileReport(design);
            generateReportPDF(response, param, jasperReport, conn, email, print, String.valueOf(acno));
			
            stmtAgeingStatementReport.close();
            
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
       	
        	 Statement stmtAgeingStatement1 =conn.createStatement();
       	  
        	 String fileName="",path="", formcode="BAGR",filepath=""; 
        	 
        	 String strSql1 = "select imgPath from my_comp";
        	 ResultSet rs1 = stmtAgeingStatement1.executeQuery(strSql1);
     		
        	 while(rs1.next ()) {
     			path=rs1.getString("imgPath");
     		}

     		DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
   		    java.util.Date date = new java.util.Date();
   		    String currdate=dateFormat.format(date);
   		
     		fileName = "AgeingStatementReport["+ageingStatementReportBean.getLblaccountname()+"]"+currdate+".pdf";
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
			sendmail.SendTomail( saveFile,formcode,email,acno,session.getAttribute("BRANCHID").toString().trim(),session.getAttribute("USERID").toString().trim(),ageingStatementReportBean.getLblaccountname());
			
         }
              
     }
}