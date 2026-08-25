package com.dashboard.accounts.currentageingstatementmonthly;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
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
import com.opensymphony.xwork2.ActionSupport;
@SuppressWarnings("serial")

public class ClsCurrentAgeingStatementMonthlyAction extends ActionSupport{
    
	ClsCurrentAgeingStatementMonthlyDAO currentAgeingStatementMonthly= new ClsCurrentAgeingStatementMonthlyDAO();
	ClsCurrentAgeingStatementMonthlyBean ageingStatementMonthlyBean;
	
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
	
	private String lblsumnetamount;
	private String lblsumapplied;
	private String lblsumbalance;
	
	private String lblsumoutnetamount;
	private String lblsumoutapplied;
	private String lblsumoutbalance;
	
	private String lblnetamount;
	
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
        
		try {
			conn = connDAO.getMyConnection();
	        Statement stmtCurrentAgeingStatementMonthly =conn.createStatement();
	        param = new HashMap();
	        String sqld="",sqld1="",joins="",casestatement="",sqlOutStandingResult="0";
	        
			String atype = request.getParameter("atype");
			int acno=Integer.parseInt(request.getParameter("acno"));
			String branch = request.getParameter("branch");
			/*String sqlUpToDate = request.getParameter("uptoDate");*/
			String sqlUpToDate = request.getParameter("uptoDate");
			String pathname =request.getParameter("pathname");
			
			java.sql.Date sqlDate=null;
//			 sqlDate=commonDAO.changeStringtoSqlDate(sqlUpToDate);
			
			System.out.println("pathname..."+pathname);
			
			
			ageingStatementMonthlyBean=currentAgeingStatementMonthly.getPrint(request,atype,acno,branch,sqlUpToDate);
			/*String reportFileName = "currentAgeingStatementMonthlyPrint";*/
			//String reportFileName = "currentAgeingStatementMonthWisePrint";
			
			String reportFileName="";
			
			if(pathname==null)
			{
				
				reportFileName = "com/dashboard/accounts/currentageingstatementmonthly/currentAgeingStatementMonthWisePrint.jrxml";
				System.out.println(reportFileName);
			}
			else
			{
				
	            reportFileName="com/dashboard/accounts/currentageingstatement/currentAgeingStatementMonthWisePrintCar.jrxml";
				System.out.println(reportFileName);
			}
			
//				 reportFileName = "currentAgeingStatementMonthWisePrint";
			
				
		
            String imgpath=request.getSession().getServletContext().getRealPath("/icons/city1header.jpg");
            imgpath=imgpath.replace("\\", "\\\\");
    		 
            if(atype.equalsIgnoreCase("AR")){
    			sqld=" and j.dramount < 0";
    			sqld1=" and j.dramount > 0";
    		}
    		else if(atype.equalsIgnoreCase("AP")){
    			sqld=" and j.dramount > 0";
    			sqld1=" and j.dramount < 0";
    		}
            
    		joins=commonDAO.getFinanceVocTablesJoins(conn);
    		casestatement=commonDAO.getFinanceVocTablesCase(conn);
    		
    		/*String sqlOutStanding = "select b.transno,b.date,b.transType,@m:=@s ref_detail,@s:=convert(b.dates ,char(100)) refno,b.description,b.netamount,b.applied,b.balance,b.brhid,b.monthyear,if(@m!=@s,@i:=balance,coalesce(round(@i:=@i+balance,2),0)) monthwiserunningbalance,"
					+ "coalesce(round(@r:=@r+balance,2),0) totalrunningbalance from (select "+casestatement+"a.date,a.dates,a.monthyear,a.transType,a.description,round(a.netamount,2) netamount,round(a.applied,2) applied,round(a.balance,2) balance,a.brhid from ("
					+ "select j.doc_no transNo,j.description,DATE_FORMAT((coalesce(j.duedate,j.date)),'%d-%m-%Y') date,DATE_FORMAT((coalesce(j.duedate,j.date)),'%Y%m') dates,DATE_FORMAT((coalesce(j.duedate,j.date)),'%b - %Y') monthyear,j.dtype transType,round(j.dramount*j.id,2) netamount,round(j.out_amount*j.id,2) applied,"
					+ "round((j.dramount-j.out_amount)*j.id,2) balance,j.brhid from my_jvtran j inner join my_head h on j.acno=h.doc_no where h.atype='"+atype+"' and coalesce(j.duedate,j.date)<='"+sqlUpToDate+"' and j.acno="+acno+""+sqld1+" and (j.dramount-j.out_amount)!=0 and j.status=3 "
					+ "and j.yrid=0 order by coalesce(j.duedate,j.date)) a"+joins+") b,(select @i:=0) as i,(select @m:=0) as m,(select @s:=0) as s,(select @r:=0) as r";*/
	
			/*String sqlOutStanding = "select b.transno,b.date,b.transType,b.description,b.netamount,b.applied,b.balance,CONVERT(CONCAT(b.monthyear,' - ',c.monthbalance,'                             .'),CHAR(1000)) monthnetbalance,coalesce(round(@i:=@i+balance,2),0) totalrunningbalance,"
					+ "b.brhid from (select "+casestatement+"a.date,a.monthyear,a.transType,a.description,round(a.netamount,2) netamount,round(a.applied,2) applied,round(a.balance,2) balance,a.brhid from ( select j.doc_no transNo,j.description,DATE_FORMAT((coalesce(j.duedate,j.date)),'%d-%m-%Y') date,"
					+ "DATE_FORMAT((coalesce(j.duedate,j.date)),'%b - %Y') monthyear,j.dtype transType,round(j.dramount*j.id,2) netamount,round(j.out_amount*j.id,2) applied,round((j.dramount-j.out_amount)*j.id,2) balance,j.brhid from my_jvtran j inner join my_head h on j.acno=h.doc_no inner join "
					+ "my_curr c on j.curId=c.doc_no where h.atype='"+atype+"' and coalesce(j.duedate,j.date)<='"+sqlUpToDate+"' and j.acno="+acno+""+sqld1+" and (j.dramount-j.out_amount)!=0 and j.status=3 and j.yrid=0 order by coalesce(j.duedate,j.date),j.doc_no) a"+joins+") b left join ( "
					+ "select DATE_FORMAT((coalesce(j.duedate,j.date)),'%b - %Y') monthyear,round(sum((j.dramount-j.out_amount)*j.id),2) monthbalance from my_jvtran j inner join my_head h on j.acno=h.doc_no where h.atype='"+atype+"' and coalesce(j.duedate,j.date)<='"+sqlUpToDate+"' "
					+ "and j.acno="+acno+""+sqld1+" and (j.dramount-j.out_amount)!=0 and j.status=3 and j.yrid=0 group by DATE_FORMAT((coalesce(j.duedate,j.date)),'%b - %Y')) c on b.monthyear=c.monthyear,(select @i:=0) as i";*/
    		
    		/*String sqlOutStanding = "select b.transno,if(b.date='01-01-1900',null,b.date) date,b.transType,b.description,b.netamount,b.applied,b.balance,CONVERT(CONCAT(b.monthyear,' - ',c.monthbalance,'                             .'),CHAR(1000)) monthnetbalance,coalesce(round(@i:=@i+balance,2),0) totalrunningbalance,"
					+ "b.brhid from (select "+casestatement+"a.date,a.monthyear,a.transType,a.description,round(a.netamount,2) netamount,round(a.applied,2) applied,round(a.balance,2) balance,a.brhid from ( select j.doc_no transNo,j.description,if(j.dtype='INV',DATE_FORMAT((coalesce(j.duedate,j.date)),'%d-%m-%Y'),DATE_FORMAT('1900-01-01','%d-%m-%Y')) date,"
					+ "if(j.dtype='INV',DATE_FORMAT((coalesce(j.duedate,j.date)),'%b - %Y'),DATE_FORMAT('1900-01-01','%b - %Y')) monthyear,j.dtype transType,round(j.dramount*j.id,2) netamount,round(j.out_amount*j.id,2) applied,round((j.dramount-j.out_amount)*j.id,2) balance,j.brhid from my_jvtran j inner join my_head h on j.acno=h.doc_no inner join "
					+ "my_curr c on j.curId=c.doc_no where h.atype='"+atype+"' and if(j.dtype='INV',coalesce(j.duedate,j.date),'1900-01-01')<='"+sqlUpToDate+"' and j.acno="+acno+""+sqld1+" and (j.dramount-j.out_amount)!=0 and j.status=3 and j.yrid=0 order by if(j.dtype='INV',coalesce(j.duedate,j.date),'1900-01-01'),j.doc_no) a"+joins+") b left join ( "
					+ "select if(j.dtype='INV',DATE_FORMAT((coalesce(j.duedate,j.date)),'%b - %Y'),j.date'1900-01-01','%b - %Y')) monthyear,round(sum((j.dramount-j.out_amount)*j.id),2) monthbalance from my_jvtran j inner join my_head h on j.acno=h.doc_no where h.atype='"+atype+"' and if(j.dtype='INV',coalesce(j.duedate,j.date),'1900-01-01')<='"+sqlUpToDate+"' "
					+ "and j.acno="+acno+""+sqld1+" and (j.dramount-j.out_amount)!=0 and j.status=3 and j.yrid=0 group by if(j.dtype='INV',DATE_FORMAT((coalesce(j.duedate,j.date)),'%b - %Y'),DATE_FORMAT('1900-01-01','%b - %Y'))) c on b.monthyear=c.monthyear,(select @i:=0) as i";*/
    		
    		/*String sqlOutStanding = "select b.transno,b.date,b.transType,b.description,b.netamount,b.applied,b.balance,CONVERT(CONCAT(b.monthyear,' - ',c.monthbalance,'                             .'),CHAR(1000)) monthnetbalance,coalesce(round(@i:=@i+balance,2),0) totalrunningbalance,"
					+ "b.brhid from (select "+casestatement+"a.date,a.monthyear,a.transType,a.description,round(a.netamount,2) netamount,round(a.applied,2) applied,round(a.balance,2) balance,a.brhid from ( select j.doc_no transNo,j.description,if(j.dtype='INV',DATE_FORMAT((coalesce(j.duedate,j.date)),'%d-%m-%Y'),DATE_FORMAT(j.date,'%d-%m-%Y')) date,"
					+ "if(j.dtype='INV',DATE_FORMAT((coalesce(j.duedate,j.date)),'%b - %Y'),DATE_FORMAT(j.date,'%b - %Y')) monthyear,j.dtype transType,round(j.dramount*j.id,2) netamount,round(j.out_amount*j.id,2) applied,round((j.dramount-j.out_amount)*j.id,2) balance,j.brhid from my_jvtran j inner join my_head h on j.acno=h.doc_no inner join "
					+ "my_curr c on j.curId=c.doc_no where h.atype='"+atype+"' and if(j.dtype='INV',coalesce(j.duedate,j.date),j.date)<='"+sqlUpToDate+"' and j.acno="+acno+""+sqld1+" and (j.dramount-j.out_amount)!=0 and j.status=3 and j.yrid=0 order by if(j.dtype='INV',coalesce(j.duedate,j.date),j.date),j.doc_no) a"+joins+") b left join ( "
					+ "select if(j.dtype='INV',DATE_FORMAT((coalesce(j.duedate,j.date)),'%b - %Y'),DATE_FORMAT(j.date,'%b - %Y')) monthyear,round(sum((j.dramount-j.out_amount)*j.id),2) monthbalance from my_jvtran j inner join my_head h on j.acno=h.doc_no where h.atype='"+atype+"' and if(j.dtype='INV',coalesce(j.duedate,j.date),j.date)<='"+sqlUpToDate+"' "
					+ "and j.acno="+acno+""+sqld1+" and (j.dramount-j.out_amount)!=0 and j.status=3 and j.yrid=0 group by if(j.dtype='INV',DATE_FORMAT((coalesce(j.duedate,j.date)),'%b - %Y'),DATE_FORMAT(j.date,'%b - %Y'))) c on b.monthyear=c.monthyear,(select @i:=0) as i";
    		*/
    		String sqlOutStanding = "select b.transno,b.date,b.transType,b.description,b.netamount,b.applied,b.balance,CONVERT(CONCAT(b.monthyear,' - ',c.monthbalance,'                             .'),CHAR(1000)) monthnetbalance,coalesce(round(@i:=@i+balance,2),0) totalrunningbalance,"
					+ "b.brhid from (select "+casestatement+"a.date,a.monthyear,a.transType,a.description,round(a.netamount,2) netamount,round(a.applied,2) applied,round(a.balance,2) balance,a.brhid from ( select j.doc_no transNo,j.description,if(j.dtype='INV',DATE_FORMAT((coalesce(j.duedate,j.date)),'%d-%m-%Y'),DATE_FORMAT(j.date,'%d-%m-%Y')) date,"
					+ "if(j.dtype='INV',DATE_FORMAT((coalesce(j.duedate,j.date)),'%b - %Y'),DATE_FORMAT(j.date,'%b - %Y')) monthyear,j.dtype transType,round(j.dramount*j.id,2) netamount,round(j.out_amount*j.id,2) applied,round((j.dramount-j.out_amount)*j.id,2) balance,j.brhid from my_jvtran j inner join my_head h on j.acno=h.doc_no inner join "
					+ "my_curr c on j.curId=c.doc_no where h.atype='"+atype+"' and if(j.dtype='INV',coalesce(j.duedate,j.date),j.date)<=DATE_FORMAT('"+sqlUpToDate+"','%Y-%M-%d') and j.acno="+acno+""+sqld1+" and (j.dramount-j.out_amount)!=0 and j.status=3 and j.yrid=0 order by if(j.dtype='INV',coalesce(j.duedate,j.date),j.date),j.doc_no) a"+joins+") b left join ( "
					+ "select if(j.dtype='INV',DATE_FORMAT((coalesce(j.duedate,j.date)),'%b - %Y'),DATE_FORMAT(j.date,'%b - %Y')) monthyear,round(sum((j.dramount-j.out_amount)*j.id),2) monthbalance from my_jvtran j inner join my_head h on j.acno=h.doc_no where h.atype='"+atype+"' and if(j.dtype='INV',coalesce(j.duedate,j.date),j.date)<=DATE_FORMAT('"+sqlUpToDate+"','%Y-%M-%d')"
					+ "and j.acno="+acno+""+sqld1+" and (j.dramount-j.out_amount)!=0 and j.status=3 and j.yrid=0 group by if(j.dtype='INV',DATE_FORMAT((coalesce(j.duedate,j.date)),'%b - %Y'),DATE_FORMAT(j.date,'%b - %Y'))) c on b.monthyear=c.monthyear,(select @i:=0) as i";
    		
    		System.out.println("sqlOutStanding"+sqlOutStanding);
			ResultSet resultSetOutStanding = stmtCurrentAgeingStatementMonthly.executeQuery(sqlOutStanding);
    		
    		while(resultSetOutStanding.next()){
    			sqlOutStandingResult="1";
    		}
    		
    		/*if(sqlOutStandingResult.equalsIgnoreCase("0")){
    			sqlOutStanding="select null transno, null date, null transType, null description, null netamount, null applied, null balance, null monthnetbalance, null totalrunningbalance,null brhid";
    		}*/
    		
    		/*String sqlUnapply ="select b.transno,b.date,b.transType,@m:=@s ref_detail,@s:=convert(b.dates ,char(100)) refno,b.description,b.netamount,b.applied,b.balance,b.brhid,b.monthyear,if(@m!=@s,@i:=balance,coalesce(round(@i:=@i+balance,2),0)) monthwiserunningbalance,"
					+ "coalesce(round(@r:=@r+balance,2),0) totalrunningbalance from (select "+casestatement+"a.date,a.dates,a.monthyear,a.transType,a.description,round(a.netamount,2) netamount,round(a.applied,2) applied,round(a.balance,2) balance,a.brhid from ("
					+ "select j.doc_no transNo,j.description,DATE_FORMAT((coalesce(j.duedate,j.date)),'%d-%m-%Y') date,DATE_FORMAT((coalesce(j.duedate,j.date)),'%Y%m') dates,DATE_FORMAT((coalesce(j.duedate,j.date)),'%b - %Y') monthyear,j.dtype transType,round(j.dramount*j.id,2) netamount,round(j.out_amount*j.id,2) applied,"
					+ "round((j.dramount-j.out_amount)*j.id,2) balance,j.brhid from my_jvtran j inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no where h.atype='"+atype+"' and coalesce(j.duedate,j.date)<='"+sqlUpToDate+"' and j.acno="+acno+""+sqld+" and "
					+ "(j.dramount-j.out_amount)!=0 and j.status=3  and j.yrid=0 order by coalesce(j.duedate,j.date)) a"+joins+") b,(select @i:=0) as i,(select @m:=0) as m,(select @s:=0) as s,(select @r:=0) as r";*/
	
    		/*String sqlUnapply ="select b.transno,b.date,b.transType,b.description,b.netamount,b.applied,b.balance,CONVERT(CONCAT(b.monthyear,' - ',c.monthbalance,'                             .'),CHAR(1000)) monthnetbalance,coalesce(round(@i:=@i+balance,2),0) totalrunningbalance,"
					+ "b.brhid from (select "+casestatement+"a.date,a.monthyear,a.transType,a.description,round(a.netamount,2) netamount,round(a.applied,2) applied,round(a.balance,2) balance,a.brhid from ( select j.doc_no transNo,j.description,DATE_FORMAT((coalesce(j.duedate,j.date)),'%d-%m-%Y') date,"
					+ "DATE_FORMAT((coalesce(j.duedate,j.date)),'%b - %Y') monthyear,j.dtype transType,round(j.dramount*j.id,2) netamount,round(j.out_amount*j.id,2) applied,round((j.dramount-j.out_amount)*j.id,2) balance,j.brhid from my_jvtran j inner join my_head h on j.acno=h.doc_no inner join "
					+ "my_curr c on j.curId=c.doc_no where h.atype='"+atype+"' and coalesce(j.duedate,j.date)<='"+sqlUpToDate+"' and j.acno="+acno+""+sqld+" and (j.dramount-j.out_amount)!=0 and j.status=3  and j.yrid=0 order by coalesce(j.duedate,j.date),j.doc_no) a"+joins+") b left join ( "
					+ "select DATE_FORMAT((coalesce(j.duedate,j.date)),'%b - %Y') monthyear,round(sum((j.dramount-j.out_amount)*j.id),2) monthbalance from my_jvtran j inner join my_head h on j.acno=h.doc_no where h.atype='"+atype+"' and coalesce(j.duedate,j.date)<='"+sqlUpToDate+"' "
					+ "and j.acno="+acno+""+sqld+" and (j.dramount-j.out_amount)!=0 and j.status=3 and j.yrid=0 group by DATE_FORMAT((coalesce(j.duedate,j.date)),'%b - %Y')) c on b.monthyear=c.monthyear,(select @i:=0) as i";
   */
    		String sqlUnapply ="select b.transno,b.date,b.transType,b.description,b.netamount,b.applied,b.balance,CONVERT(CONCAT(b.monthyear,' - ',c.monthbalance,'                             .'),CHAR(1000)) monthnetbalance,coalesce(round(@i:=@i+balance,2),0) totalrunningbalance,"
					+ "b.brhid from (select "+casestatement+"a.date,a.monthyear,a.transType,a.description,round(a.netamount,2) netamount,round(a.applied,2) applied,round(a.balance,2) balance,a.brhid from ( select j.doc_no transNo,j.description,DATE_FORMAT((coalesce(j.duedate,j.date)),'%d-%m-%Y') date,"
					+ "DATE_FORMAT((coalesce(j.duedate,j.date)),'%b - %Y') monthyear,j.dtype transType,round(j.dramount*j.id,2) netamount,round(j.out_amount*j.id,2) applied,round((j.dramount-j.out_amount)*j.id,2) balance,j.brhid from my_jvtran j inner join my_head h on j.acno=h.doc_no inner join "
					+ "my_curr c on j.curId=c.doc_no where h.atype='"+atype+"' and j.acno="+acno+""+sqld+" and (j.dramount-j.out_amount)!=0 and j.status=3  and j.yrid=0 order by coalesce(j.duedate,j.date),j.doc_no) a"+joins+") b left join ( "
					+ "select DATE_FORMAT((coalesce(j.duedate,j.date)),'%b - %Y') monthyear,round(sum((j.dramount-j.out_amount)*j.id),2) monthbalance from my_jvtran j inner join my_head h on j.acno=h.doc_no where h.atype='"+atype+"'  "
					+ "and j.acno="+acno+""+sqld+" and (j.dramount-j.out_amount)!=0 and j.status=3 and j.yrid=0 group by DATE_FORMAT((coalesce(j.duedate,j.date)),'%b - %Y')) c on b.monthyear=c.monthyear,(select @i:=0) as i";
//    		and coalesce(j.duedate,j.date)<=DATE_FORMAT('"+sqlUpToDate+"','%Y-%M-%d') 
//    		and coalesce(j.duedate,j.date)<=DATE_FORMAT('"+sqlUpToDate+"','%Y-%M-%d')
    		System.out.println("sqlUnapply"+sqlUnapply);
    					
    		/*String sqlTotal = "select coalesce(a.totalunappliedamount*a.id,0) totalunappliedamount,coalesce(a.totalapplied*a.id,0) totalapplied,coalesce(a.unappliedbalance*a.id,0) unappliedbalance,"
  				  + "coalesce(b.totaloutamount*b.id,0) totaloutamount,coalesce(b.totaloutapplied*b.id,0) totaloutapplied,coalesce(b.outstandingbalance*b.id,0) outstandingbalance,"
  				  + "format((coalesce(b.outstandingbalance,0)+coalesce(a.unappliedbalance,0)),2) nettotal from ((select j.id,round((sum(j.dramount)),2) totalunappliedamount,round((sum(j.out_amount)),2) totalapplied,"
  				  + "round((sum(j.dramount-j.out_amount)),2) unappliedbalance from my_jvtran j where j.status=3 and coalesce(j.duedate,j.date)<='"+sqlUpToDate+"' and j.acno="+acno+""+sqld+" and (j.dramount-j.out_amount)!=0  "
  				  + "and j.yrid=0 order by coalesce(j.duedate,j.date),j.doc_no) a,(select j.id,round((sum(j.dramount)),2) totaloutamount,round((sum(j.out_amount)),2) totaloutapplied,round((sum(j.dramount-j.out_amount)),2) outstandingbalance "
  				  + "from my_jvtran j where j.status=3 and coalesce(j.duedate,j.date)<='"+sqlUpToDate+"' and j.acno="+acno+""+sqld1+" and (j.dramount-j.out_amount)!=0  and j.yrid=0 order by coalesce(j.duedate,j.date),j.doc_no) b)";
    		*/
    		String sqlTotal = "select coalesce(a.totalunappliedamount*a.id,0) totalunappliedamount,coalesce(a.totalapplied*a.id,0) totalapplied,coalesce(a.unappliedbalance*a.id,0) unappliedbalance,"
    				  + "coalesce(b.totaloutamount*b.id,0) totaloutamount,coalesce(b.totaloutapplied*b.id,0) totaloutapplied,coalesce(b.outstandingbalance*b.id,0) outstandingbalance,"
    				  + "format((coalesce(b.outstandingbalance,0)+coalesce(a.unappliedbalance,0)),2) nettotal from ((select j.id,round((sum(j.dramount)),2) totalunappliedamount,round((sum(j.out_amount)),2) totalapplied,"
    				  + "round((sum(j.dramount-j.out_amount)),2) unappliedbalance from my_jvtran j where j.status=3  and j.acno="+acno+""+sqld+" and (j.dramount-j.out_amount)!=0  "
    				  + "and j.yrid=0 order by coalesce(j.duedate,j.date),j.doc_no) a,(select j.id,round((sum(j.dramount)),2) totaloutamount,round((sum(j.out_amount)),2) totaloutapplied,round((sum(j.dramount-j.out_amount)),2) outstandingbalance "
    				  + "from my_jvtran j where j.status=3 and j.acno="+acno+""+sqld1+" and (j.dramount-j.out_amount)!=0  and j.yrid=0 order by coalesce(j.duedate,j.date),j.doc_no) b)";
//    		and coalesce(j.duedate,j.date)<=DATE_FORMAT('"+sqlUpToDate+"','%Y-%M-%d')
//    		and coalesce(j.duedate,j.date)<=DATE_FORMAT('"+sqlUpToDate+"','%Y-%M-%d') 
    		System.out.println("sqlTotal--"+sqlTotal);
    		ResultSet resultSetTotal = stmtCurrentAgeingStatementMonthly.executeQuery(sqlTotal);
    		
    		while(resultSetTotal.next()){
    			ageingStatementMonthlyBean.setLblsumnetamount(resultSetTotal.getString("totalunappliedamount"));
    			ageingStatementMonthlyBean.setLblsumapplied(resultSetTotal.getString("totalapplied"));
    			ageingStatementMonthlyBean.setLblsumbalance(resultSetTotal.getString("unappliedbalance"));
    			
    			ageingStatementMonthlyBean.setLblsumoutnetamount(resultSetTotal.getString("totaloutamount"));
    			ageingStatementMonthlyBean.setLblsumoutapplied(resultSetTotal.getString("totaloutapplied"));
    			ageingStatementMonthlyBean.setLblsumoutbalance(resultSetTotal.getString("outstandingbalance"));
    			
    			ageingStatementMonthlyBean.setLblnetamount(resultSetTotal.getString("nettotal"));
    		}
    		if(commonDAO.getBIBPrintPath("BIC").contains(".jrxml")==true)
			{
    			reportFileName=commonDAO.getBIBPrintPath("BIC");
            param.put("imgpath", imgpath);
            param.put("compname", ageingStatementMonthlyBean.getLblcompname());
            param.put("compaddress", ageingStatementMonthlyBean.getLblcompaddress());
            param.put("comptel", ageingStatementMonthlyBean.getLblcomptel());
            param.put("compfax", ageingStatementMonthlyBean.getLblcompfax());
            param.put("compbranch", ageingStatementMonthlyBean.getLblbranch());
            param.put("location", ageingStatementMonthlyBean.getLbllocation());
            param.put("printname", ageingStatementMonthlyBean.getLblprintname());
            param.put("subprintname", ageingStatementMonthlyBean.getLblprintname1());
	        param.put("account", ageingStatementMonthlyBean.getLblaccountno()+" - "+ageingStatementMonthlyBean.getLblaccountname());
            param.put("customeraddress", ageingStatementMonthlyBean.getLblaccountaddress());
            param.put("customeremail", ageingStatementMonthlyBean.getLblaccountemail());
            param.put("customermobile", ageingStatementMonthlyBean.getLblaccountmobileno());
            param.put("customerphone", ageingStatementMonthlyBean.getLblaccountphone());
            param.put("customerfax", ageingStatementMonthlyBean.getLblaccountfax());
	        param.put("ageingstatementunapplysql", sqlUnapply);
	        param.put("unappliedtotalamount", ageingStatementMonthlyBean.getLblsumnetamount());
	        param.put("unappliedtotalapplied", ageingStatementMonthlyBean.getLblsumapplied());
	        param.put("unappliedtotalbalance", ageingStatementMonthlyBean.getLblsumbalance());
	        param.put("ageingstatementoutstandingsql", sqlOutStanding);
	        param.put("outstandingtotalamount", ageingStatementMonthlyBean.getLblsumoutnetamount());
	        param.put("outstandingtotalapplied", ageingStatementMonthlyBean.getLblsumoutapplied());
	        param.put("outstandingtotalbalance", ageingStatementMonthlyBean.getLblsumoutbalance());
	        param.put("nettotalamount", ageingStatementMonthlyBean.getLblnetamount());
	        param.put("printby", session.getAttribute("USERNAME"));
	        
	        /*JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/accounts/currentageingstatementmonthly/" + reportFileName + ".jrxml"));*/
	        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath( reportFileName ));
	        JasperReport jasperReport = JasperCompileManager.compileReport(design);
            generateReportPDF(response, param, jasperReport, conn, String.valueOf(acno));
			
            stmtCurrentAgeingStatementMonthly.close();
			} 
		} catch (Exception e) {
            e.printStackTrace();
            conn.close();
    	} finally{
    		conn.close();
    	}
	}
	
	 private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn, String acno)throws JRException, NamingException, SQLException, IOException, AddressException, MessagingException {
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