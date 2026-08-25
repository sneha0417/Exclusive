package com.dashboard.client.paymentfollowup;

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

public class ClsPaymentFollowUpAction extends ActionSupport{
    
	ClsPaymentFollowUpDAO paymentFollowUpDAO= new ClsPaymentFollowUpDAO();
	ClsPaymentFollowUpBean paymentFollowUpBean;
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
	private String lblaccountname;
	private String lblaccountaddress;
	private String lblaccountmobileno;
	private String lblcreditperiodmin;
	private String lblcreditperiodmax;
	private String lblcreditlimit;
	private String lblcurrencycode;
	
	private String lblsumnetamount;
	private String lblsumapplied;
	private String lblsumbalance;
	
	private String lblsumoutnetamount;
	private String lblsumoutapplied;
	private String lblsumoutbalance;
	
	private String lblnetsecurityamount;
	private String lblnetamount;
	
	private Map<String, Object> param = null;
	
	//for hide
	private int firstarray;
	private int secarray;
	private int thirdarray;
	private int fourtharray;
	
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

	public String getLblaccountmobileno() {
		return lblaccountmobileno;
	}

	public void setLblaccountmobileno(String lblaccountmobileno) {
		this.lblaccountmobileno = lblaccountmobileno;
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

	public String getLblcurrencycode() {
		return lblcurrencycode;
	}

	public void setLblcurrencycode(String lblcurrencycode) {
		this.lblcurrencycode = lblcurrencycode;
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
	
	public String getLblnetsecurityamount() {
		return lblnetsecurityamount;
	}

	public void setLblnetsecurityamount(String lblnetsecurityamount) {
		this.lblnetsecurityamount = lblnetsecurityamount;
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

	public int getThirdarray() {
		return thirdarray;
	}

	public void setThirdarray(int thirdarray) {
		this.thirdarray = thirdarray;
	}

	public int getFourtharray() {
		return fourtharray;
	}

	public void setFourtharray(int fourtharray) {
		this.fourtharray = fourtharray;
	}
	
	public String saveAction() throws ParseException, SQLException{
		return lblaccountname;
	}
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	public void printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpSession session=request.getSession();
	    Connection conn = null;
        java.sql.Date sqlUpToDate = null;
        
		try {
			conn = connDAO.getMyConnection();
	        Statement stmtClient =conn.createStatement();
	        param = new HashMap();
	        String sqld="",sqld1="",condition="",joins="",casestatement="",sqlUnapplyResult="0",sqlOutStandingResult="0",sqlAgeingResult="0",sqlSecurityResult="0";
	        
			String atype = request.getParameter("atype");
			int acno=Integer.parseInt(request.getParameter("acno"));
			int level1from=Integer.parseInt(request.getParameter("level1from"));
			int level1to=Integer.parseInt(request.getParameter("level1to"));
			int level2from=Integer.parseInt(request.getParameter("level2from"));
			int level2to=Integer.parseInt(request.getParameter("level2to"));
			int level3from=Integer.parseInt(request.getParameter("level3from"));
			int level3to=Integer.parseInt(request.getParameter("level3to"));
			int level4from=Integer.parseInt(request.getParameter("level4from"));
			int level4to=Integer.parseInt(request.getParameter("level4to"));
			int level5from=Integer.parseInt(request.getParameter("level5from"));
			String branch = request.getParameter("branch");
			String uptoDate = request.getParameter("uptoDate");
			String email = request.getParameter("email");
      	    String print = request.getParameter("print");
      	   
			if(!(uptoDate.equalsIgnoreCase("undefined")) && !(uptoDate.equalsIgnoreCase("")) && !(uptoDate.equalsIgnoreCase("0"))){
				sqlUpToDate = commonDAO.changeStringtoSqlDate(uptoDate);
            }
			
			paymentFollowUpBean=paymentFollowUpDAO.getPrint(request,atype,acno,branch,uptoDate,level1from,level1to,level2from,level2to,level3from,level3to,level4from,level4to,level5from);
			
			String reportFileName = "individualAgeingStatementPrint";
            String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
            imgpath=imgpath.replace("\\", "\\\\");
            
            if(atype.equalsIgnoreCase("AR")){
    			condition=" and bk.dtype='CRM'";
    			sqld=" and j.dramount < 0";
    			sqld1=" and j.dramount > 0";
    		}
    		else if(atype.equalsIgnoreCase("AP")){
    			condition=" and bk.dtype='VND'";
    			sqld=" and j.dramount > 0";
    			sqld1=" and j.dramount < 0";
    		}
            
            String sqlAgeing = "";
    		
    		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    			sqlAgeing+=" and j.brhId="+branch+"";
    		}	
    		 
    		sqlAgeing = "select CONVERT(if(sum(t7)>0,round((sum(t7)),2),'  '),CHAR(50)) netamount,CONVERT(if(sum(l1)>0,round((sum(l1)),2),'  '),CHAR(50)) level1,CONVERT(if(sum(l2)>0,round((sum(l2)),2),'  '),CHAR(50)) level2,\r\n" + 
    		 		" CONVERT(if(sum(l3)>0,round((sum(l3)),2),'  '),CHAR(50)) level3,CONVERT(if(sum(l4)>0,round((sum(l4)),2),'  '),CHAR(50)) level4,CONVERT(if(sum(l5)>0,round((sum(l5)),2),'  '),CHAR(50)) level5 from\r\n" + 
    		 		" (select d.name,d.acno,d.brhid,d.doc_no,if(d.duedys between "+level1from+" and "+level1to+" and d.bal>0,round((d.bal),2),0) l1,\r\n" + 
    		 		" if(d.duedys between "+level2from+" and "+level2to+" and d.bal>0,round((d.bal),2),0) l2,if(d.duedys between "+level3from+" and "+level3to+" and d.bal>0,round((d.bal),2),0) l3,\r\n" + 
    		 		" if(d.duedys between "+level4from+" and "+level4to+" and d.bal>0,round((d.bal),2),0) l4,if(d.duedys >= "+level5from+" and d.bal>0,round((d.bal),2),0) l5,\r\n" + 
    		 		" CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(50)) U6,if(d.bal>0,d.bal,0) t7 from (select j.acno,j.brhid,h.description name,sum(dramount-out_amount) bal,\r\n" + 
    		 		" j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys from my_jvtran j inner join my_head h on j.acno=h.doc_no\r\n" + 
    		 		" where j.status=3 and h.atype='"+atype+"' and j.acno="+acno+""+sqlAgeing+" and j.yrid=0 and j.date<='"+sqlUpToDate+"' group by tranid having bal<>0) d) ag group by acno";
    		
    		ResultSet resultSetAgeing = stmtClient.executeQuery(sqlAgeing);
    		
    		while(resultSetAgeing.next()){
    			sqlAgeingResult="1";
    		}
    		
    		joins=commonDAO.getFinanceVocTablesJoins(conn);
    		casestatement=commonDAO.getFinanceVocTablesCase(conn);
    		
    		String sqlUnapply ="select "+casestatement+"a.* from (select j.doc_no transNo,j.ref_detail,j.description,DATE_FORMAT((j.date),'%d-%m-%Y') date,j.dtype transType,"
				+ "round(j.dramount*j.id,2) netamount,round(j.out_amount*j.id,2) applied,round((j.dramount-j.out_amount)*j.id,2) balance,b.branchname,bk.refname name,bk.per_mob pmob,"
				+ "TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys,j.brhid from my_jvtran j inner join my_brch b on j.brhId=b.doc_no "
				+ "inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk "
				+ "on h.cldocno=bk.cldocno"+condition+" where h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' and j.acno="+acno+""+sqld+" and (j.dramount-j.out_amount)!=0 and j.status=3  and j.yrid=0 "
				+ "order by j.date) a"+joins+"";
    	
    		ResultSet resultSetUnapply = stmtClient.executeQuery(sqlUnapply);
    		
    		while(resultSetUnapply.next()){
    			sqlUnapplyResult="1";
    		}
    		
    		String sqlOutStanding = "select "+casestatement+"a.* from (select j.doc_no transNo,j.ref_detail,j.description,DATE_FORMAT((j.date),'%d-%m-%Y') date,j.dtype transType,"
				+ "round(j.dramount*j.id,2) netamount,round(j.out_amount*j.id,2) applied,round((j.dramount-j.out_amount)*j.id,2) balance,b.branchname,bk.refname name,bk.per_mob pmob,"
				+ "TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys,j.brhid from my_jvtran j inner join my_brch b on j.brhId=b.doc_no "
				+ "inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk "
				+ "on h.cldocno=bk.cldocno"+condition+" where h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' and j.acno="+acno+""+sqld1+" and (j.dramount-j.out_amount)!=0 and j.status=3  and j.yrid=0 "
				+ "order by j.date) a"+joins+"";
    		
    		ResultSet resultSetOutStanding = stmtClient.executeQuery(sqlOutStanding);
    		
    		while(resultSetOutStanding.next()){
    			sqlOutStandingResult="1";
    		}
    		
    		String sqlSecurity = "";
    		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    			sqlSecurity+=" and j.brhId="+branch+"";
    		}
    		
    		sqlSecurity = "select DATE_FORMAT((j.date),'%d-%m-%Y') date,j.dtype,j.doc_no,CONVERT(if(j.rtype='0','',if(rtype='RAG',concat(rtype,' - ',r.voc_no),concat(rtype,' - ',l.voc_no))),CHAR(50)) aggvocno,"  
    			 + "j.description,CONVERT(if(secamount1<0,round(secamount1*-1,2),' '),CHAR(100)) securityamount,coalesce(round(@i:=@i+secamount1,2),0) netsecurityamount,b.branchname from  ( "  
    			 + "select sum(secamount) secamount1,a.* from ( select date,dtype,doc_no,sum(dramount) as secamount,rdocno,rtype,brhid,description  from my_jvtran where acno=(select t.doc_no from my_account ac "
    			 + "inner join my_head t on ac.acno=t.doc_no where ac.codeno='RSECURITY') and status=3 and rdocno is not null group by rdocno,rtype) a group by rdocno,rtype) j left join gl_ragmt r on j.rdocno=r.doc_no "
    			 + "and j.rtype='RAG' left join gl_lagmt l on j.rdocno=l.doc_no and j.rtype='LAG' left join my_acbook c on (c.doc_no=r.cldocno or c.doc_no=l.cldocno) and c.dtype='CRM' left join my_brch b on b.doc_no=j.brhid,(select @i:=0) as i "  
    			 + "where secamount!=0 and j.date<='"+sqlUpToDate+"' and c.acno="+acno+""+sqlSecurity+" order by rdocno,rtype"; 
    		
    		ResultSet resultSetSecurity = stmtClient.executeQuery(sqlSecurity);
    		Double netsecurityamount=0.00;
    		while(resultSetSecurity.next()){
    			sqlSecurityResult="1";
    			netsecurityamount=netsecurityamount+resultSetSecurity.getDouble("securityamount");
    		}
    		netsecurityamount = commonDAO.Round(netsecurityamount, 2);
    		paymentFollowUpBean.setLblnetsecurityamount(String.valueOf(netsecurityamount));
    		
    		String sqlTotal = "select coalesce(a.totalunappliedamount*a.id,0) totalunappliedamount,coalesce(a.totalapplied*a.id,0) totalapplied,coalesce(a.unappliedbalance*a.id,0) unappliedbalance,"
    				  + "coalesce(b.totaloutamount*b.id,0) totaloutamount,coalesce(b.totaloutapplied*b.id,0) totaloutapplied,coalesce(b.outstandingbalance*b.id,0) outstandingbalance,"
    				  + "(coalesce(b.outstandingbalance,0)+coalesce(a.unappliedbalance,0)) nettotal from ((select j.id,round((sum(j.dramount)),2) totalunappliedamount,round((sum(j.out_amount)),2) totalapplied,"
    				  + "round((sum(j.dramount-j.out_amount)),2) unappliedbalance from my_jvtran j where j.status=3 and j.date<='"+sqlUpToDate+"' and j.acno="+acno+""+sqld+" and (j.dramount-j.out_amount)!=0  "
    				  + "and j.yrid=0 order by j.date) a,(select j.id,round((sum(j.dramount)),2) totaloutamount,round((sum(j.out_amount)),2) totaloutapplied,round((sum(j.dramount-j.out_amount)),2) outstandingbalance "
    				  + "from my_jvtran j where j.status=3 and j.date<='"+sqlUpToDate+"' and j.acno="+acno+""+sqld1+" and (j.dramount-j.out_amount)!=0  and j.yrid=0 order by j.date) b)";
    		
    		ResultSet resultSetTotal = stmtClient.executeQuery(sqlTotal);
    		
    		while(resultSetTotal.next()){
    			paymentFollowUpBean.setLblsumnetamount(resultSetTotal.getString("totalunappliedamount"));
    			paymentFollowUpBean.setLblsumapplied(resultSetTotal.getString("totalapplied"));
    			paymentFollowUpBean.setLblsumbalance(resultSetTotal.getString("unappliedbalance"));
    			
    			paymentFollowUpBean.setLblsumoutnetamount(resultSetTotal.getString("totaloutamount"));
    			paymentFollowUpBean.setLblsumoutapplied(resultSetTotal.getString("totaloutapplied"));
    			paymentFollowUpBean.setLblsumoutbalance(resultSetTotal.getString("outstandingbalance"));
    			
    			paymentFollowUpBean.setLblnetamount(resultSetTotal.getString("nettotal"));
    			
    		}
            
            param.put("imgpath", imgpath);
            param.put("compname", paymentFollowUpBean.getLblcompname());
            param.put("compaddress", paymentFollowUpBean.getLblcompaddress());
            param.put("comptel", paymentFollowUpBean.getLblcomptel());
            param.put("compfax", paymentFollowUpBean.getLblcompfax());
            param.put("compbranch", paymentFollowUpBean.getLblbranch());
            param.put("location", paymentFollowUpBean.getLbllocation());
            param.put("printname", paymentFollowUpBean.getLblprintname());
            param.put("subprintname", paymentFollowUpBean.getLblprintname1());
            param.put("account", paymentFollowUpBean.getLblaccountname()+" - "+paymentFollowUpBean.getLblaccountaddress()+" - "+paymentFollowUpBean.getLblaccountmobileno());
            param.put("creditperiod", paymentFollowUpBean.getLblcreditperiodmin()+" Days");
	        param.put("creditlimit", paymentFollowUpBean.getLblcreditlimit());
	        param.put("currency", paymentFollowUpBean.getLblcurrencycode());
	        param.put("currentageingstatementunapplysql", sqlUnapply);
	        param.put("currentageingstatementunapplycheck", sqlUnapplyResult);
	        param.put("unappliedtotalamount", paymentFollowUpBean.getLblsumnetamount());
	        param.put("unappliedtotalapplied", paymentFollowUpBean.getLblsumapplied());
	        param.put("unappliedtotalbalance", paymentFollowUpBean.getLblsumbalance());
	        param.put("currentageingstatementoutstandingsql", sqlOutStanding);
	        param.put("currentageingstatementoutstandingcheck", sqlOutStandingResult);
	        param.put("outstandingtotalamount", paymentFollowUpBean.getLblsumoutnetamount());
	        param.put("outstandingtotalapplied", paymentFollowUpBean.getLblsumoutapplied());
	        param.put("outstandingtotalbalance", paymentFollowUpBean.getLblsumoutbalance());
	        param.put("currentageingstatementsummarysql", sqlAgeing);
	        param.put("currentageingstatementsummarycheck", sqlAgeingResult);
	        param.put("level1", level1from+" - "+level1to);
	        param.put("level2", level2from+" - "+level2to);
	        param.put("level3", level3from+" - "+level3to);
	        param.put("level4", level4from+" - "+level4to);
	        param.put("level5", ">="+level5from+" days");
	        param.put("currentageingstatementsecuritysql", sqlSecurity);
	        param.put("currentageingstatementsecuritycheck", sqlSecurityResult);
	        param.put("netsecurityamount", paymentFollowUpBean.getLblnetsecurityamount());
	        param.put("nettotalamount", paymentFollowUpBean.getLblnetamount());
	        param.put("printby", session.getAttribute("USERNAME"));
	        
	        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/client/paymentfollowup/" + reportFileName + ".jrxml"));
  	        JasperReport jasperReport = JasperCompileManager.compileReport(design);
            generateReportPDF(response, param, jasperReport, conn, String.valueOf(acno), email, print);
			
            stmtClient.close();
            
		} catch (Exception e) {
            e.printStackTrace();
            conn.close();
    	} finally{
    		conn.close();
    	}
	}
	
	 private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn, String acno, String email, String print)throws JRException, NamingException, SQLException, IOException, AddressException, MessagingException {
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
       	  
        	 String fileName="",path="", formcode="BCPF",filepath=""; 
        	 
        	 String strSql1 = "select imgPath from my_comp";
        	 ResultSet rs1 = stmtAgeingStatement1.executeQuery(strSql1);
     		
        	 while(rs1.next ()) {
     			path=rs1.getString("imgPath");
     		}

     		DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
   		    java.util.Date date = new java.util.Date();
   		    String currdate=dateFormat.format(date);
   		
     		fileName = "IndividualAgeingStatement[Account_DocNo"+acno+"]"+currdate+".pdf";
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
			//sendmail.SendTomail(saveFile,formcode,email);
			sendmail.SendTomail( saveFile,formcode,email,acno,session.getAttribute("BRANCHID").toString().trim(),session.getAttribute("USERID").toString().trim(),paymentFollowUpBean.getLblaccountname());
			
         }        
     }
	
}