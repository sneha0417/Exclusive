package com.dashboard.accounts.ageingstatement;

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

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.mailwithpdf.SendEmailAction;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")

public class ClsAgeingStatementAction extends ActionSupport{
    
	ClsAgeingStatementDAO ageingStatementDAO= new ClsAgeingStatementDAO();
	ClsAgeingStatementBean ageingStatementBean;
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
	private String lbllevel1from;
	private String lbllevel1to;
	private String lbllevel2from;
	private String lbllevel2to;
	private String lbllevel3from;
	private String lbllevel3to;
	private String lbllevel4from;
	private String lbllevel4to;
	private String lbllevel5from;
	
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

	public String getLbllevel1from() {
		return lbllevel1from;
	}

	public void setLbllevel1from(String lbllevel1from) {
		this.lbllevel1from = lbllevel1from;
	}

	public String getLbllevel1to() {
		return lbllevel1to;
	}

	public void setLbllevel1to(String lbllevel1to) {
		this.lbllevel1to = lbllevel1to;
	}

	public String getLbllevel2from() {
		return lbllevel2from;
	}

	public void setLbllevel2from(String lbllevel2from) {
		this.lbllevel2from = lbllevel2from;
	}

	public String getLbllevel2to() {
		return lbllevel2to;
	}

	public void setLbllevel2to(String lbllevel2to) {
		this.lbllevel2to = lbllevel2to;
	}

	public String getLbllevel3from() {
		return lbllevel3from;
	}

	public void setLbllevel3from(String lbllevel3from) {
		this.lbllevel3from = lbllevel3from;
	}

	public String getLbllevel3to() {
		return lbllevel3to;
	}

	public void setLbllevel3to(String lbllevel3to) {
		this.lbllevel3to = lbllevel3to;
	}

	public String getLbllevel4from() {
		return lbllevel4from;
	}

	public void setLbllevel4from(String lbllevel4from) {
		this.lbllevel4from = lbllevel4from;
	}

	public String getLbllevel4to() {
		return lbllevel4to;
	}

	public void setLbllevel4to(String lbllevel4to) {
		this.lbllevel4to = lbllevel4to;
	}

	public String getLbllevel5from() {
		return lbllevel5from;
	}

	public void setLbllevel5from(String lbllevel5from) {
		this.lbllevel5from = lbllevel5from;
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
        java.sql.Date sqlUpToDate = null;
        
		try {
			conn = connDAO.getMyConnection();
	        Statement stmtAgeingStatement =conn.createStatement();
	        param = new HashMap();
	        String sqld="",sqld1="",select="",joins="",casestatement="",sqlUnapplyResult="0";
	        
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
			
			ageingStatementBean=ageingStatementDAO.getPrint(request,atype,acno,branch,uptoDate,level1from,level1to,level2from,level2to,level3from,level3to,level4from,level4to,level5from);
			
			String reportFileName = commonDAO.getBIBPrintPath("BAGS");
			
			
			System.out.println("===========reportFileName======="+reportFileName);
			
            String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
            imgpath=imgpath.replace("\\", "\\\\");
            
            String imgpathfooter=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
            imgpathfooter=imgpathfooter.replace("\\", "\\\\");
            
            if(atype.equalsIgnoreCase("AR")){
    			sqld=" and j.id < 0";
    			sqld1=" and j.id > 0";
    			
    			select ="select CONVERT(if(sum(t7)>0,round((sum(t7)),2),'  '),CHAR(50)) netamount,CONVERT(if(sum(l1)>0,round((sum(l1)),2),'  '),CHAR(50)) level1,"
    					+ "CONVERT(if(sum(l2)>0,round((sum(l2)),2),'  '),CHAR(50)) level2,CONVERT(if(sum(l3)>0,round((sum(l3)),2),'  '),CHAR(50)) level3,"  
    					+ "CONVERT(if(sum(l4)>0,round((sum(l4)),2),'  '),CHAR(50)) level4,CONVERT(if(sum(l5)>0,round((sum(l5)),2),'  '),CHAR(50)) level5 from ("
    					+ "select d.acno,d.brhid,d.doc_no,if(d.duedys between "+level1from+" and "+level1to+" and d.bal>0,round((d.bal),2),0) l1,if(d.duedys between "
    					+ ""+level2from+" and "+level2to+" and d.bal>0,round((d.bal),2),0) l2,if(d.duedys between "+level3from+" and "+level3to+" and d.bal>0,"
    					+ "round((d.bal),2),0) l3,if(d.duedys between "+level4from+" and "+level4to+" and d.bal>0,round((d.bal),2),0) l4,if(d.duedys >="+level5from+" "
    					+ "and d.bal>0,round((d.bal),2),0) l5,CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(10)) U6,if(d.bal>0,d.bal,0) t7 from ";
    		}
    		else if(atype.equalsIgnoreCase("AP")){
    			sqld=" and j.id > 0";
    			sqld1=" and j.id < 0";
    			
    			select ="select CONVERT(if(sum(t7)<0,round((sum(t7)*-1),2),'  '),CHAR(50)) netamount,CONVERT(if(sum(l1)<0,round((sum(l1)*-1),2),'  '),CHAR(50)) level1,"  
    					+ "CONVERT(if(sum(l2)<0,round((sum(l2)*-1),2),'  '),CHAR(50)) level2,CONVERT(if(sum(l3)<0,round((sum(l3)*-1),2),'  '),CHAR(50)) level3,"  
    					+ "CONVERT(if(sum(l4)<0,round((sum(l4)*-1),2),'  '),CHAR(50)) level4,CONVERT(if(sum(l5)<0,round((sum(l5)*-1),2),'  '),CHAR(50)) level5 from ("
    					+ "select d.acno,d.brhid,d.doc_no,if(d.duedys between "+level1from+" and "+level1to+" and d.bal<0,round((d.bal),2),0) l1,"
    					+ "if(d.duedys between "+level2from+" and "+level2to+"  and d.bal<0,round((d.bal),2),0) l2,if(d.duedys between "+level3from+" and "+level3to+"  and "
    					+ "d.bal<0,round((d.bal),2),0) l3,if(d.duedys between "+level4from+" and "+level4to+"  and d.bal<0,round((d.bal),2),0) l4,if(d.duedys >="+level5from+"  "
    					+ "and d.bal<0,round((d.bal),2),0) l5,CONVERT(if(d.bal>0,round((d.bal),2),''),CHAR(10)) U6,if(d.bal<0,d.bal,0) t7 from ";
    		}
            
            String sqlAgeing = "";
    		
    		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    			sqlAgeing+=" and j.brhId="+branch+"";
    		}
    				
    		sqlAgeing = select+" (select j.acno,j.brhid,h.description name,sum(dramount) - coalesce(o.amount,0)*id bal, j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys\r\n" + 
    					"from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.tranid where\r\n" + 
    					"j.date<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' and j.acno="+acno+""+sqlAgeing+""+sqld1+" group by j.tranid having bal<>0 \r\n" + 
    					" union all select j.acno,j.brhid,h.description name,sum(dramount)- coalesce(o.amount,0)*id bal, j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys\r\n" + 
    					" from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"'\r\n" + 
    					" group by tranid) o on j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' and j.acno="+acno+""+sqlAgeing+""+sqld+" group by j.tranid having bal<>0) d) ag group by acno";	
    		 
    		joins=commonDAO.getFinanceVocTablesJoins(conn);
    		casestatement=commonDAO.getFinanceVocTablesCase(conn);
    		
    		String sqlUnapply = "select "+casestatement+"a.date,a.transType,a.ref_detail,a.branchname,a.description,round(a.netamount,2) netamount,round(a.applied,2) applied,round(a.balance,2) balance,a.duedys,a.brhid from ("
    					+ "select j.doc_no transNo,coalesce(j.ref_detail,'') ref_detail,j.description,DATE_FORMAT((j.date),'%d-%m-%Y') date,j.dtype transType,round(sum(j.dramount)*j.id,2) netamount,round(coalesce(o.amount,0),2) applied," 
	    				+ "round((sum(dramount) - coalesce(o.amount,0)*id)*j.id,2) balance,b.branchname,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys,j.brhid from my_jvtran j inner join my_head h "
	    				+ "on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.AP_trid where j.date<='"+sqlUpToDate+"' group by tranid) o on "
	    				+ "j.tranid=o.tranid inner join my_brch b on j.brhId=b.doc_no where j.status=3 and h.atype='"+atype+"' and j.acno="+acno+" and j.date<='"+sqlUpToDate+"'"+sqld+" group by j.tranid having balance<>0 order by j.date) a"+joins+"";
					
			ResultSet resultSetUnapply = stmtAgeingStatement.executeQuery(sqlUnapply);
    		
    		while(resultSetUnapply.next()){
    			sqlUnapplyResult="1";
    		}
    		
    		if(sqlUnapplyResult.equalsIgnoreCase("0")){
    			sqlUnapply="select null date,null transno,null transType,null ref_detail,null branchname,null description,null netamount,null applied,null balance,null duedys";
    		}
    		
    		String sqlOutStanding = "select "+casestatement+"a.date,a.transType,a.ref_detail,a.branchname,a.description,round(a.netamount,2) netamount,round(a.applied,2) applied,round(a.balance,2) balance,a.duedys,a.brhid from ("
    					+ "select j.doc_no transNo,coalesce(j.ref_detail,'') ref_detail,j.description,DATE_FORMAT((j.date),'%d-%m-%Y') date,j.dtype transType,round(sum(j.dramount)*j.id,2) netamount,round(coalesce(o.amount,0),2) applied," 
	    				+ "round((sum(dramount) - coalesce(o.amount,0)*id)*j.id,2) balance,b.branchname,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys,j.brhid from my_jvtran j inner join my_head h "
	    				+ "on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.trANid where j.date<='"+sqlUpToDate+"' group by AP_trid) o on "
	    				+ "j.tranid=o.ap_trid inner join my_brch b on j.brhId=b.doc_no where j.status=3 and h.atype='"+atype+"' and j.acno="+acno+" and j.date<='"+sqlUpToDate+"'"+sqld1+" group by j.tranid having balance<>0 order by j.date) a"+joins+"";
    		
    		String sqlTotal = "select round(sum(unappliedramount),2) totalunappliedamount,round(sum(unappliedoutamount),2) totalapplied,round(sum(unappliedbalance),2) unappliedbalance,round(sum(applieddramount),2) totaloutamount,"
    				+ "round(sum(appliedoutamount),2) totaloutapplied,round(sum(appliedbalance),2) outstandingbalance,round(coalesce(sum(appliedbalance),0)-coalesce(sum(unappliedbalance),0),2) nettotal from (" +  
    				"select 0 applieddramount,0 appliedoutamount,0 appliedbalance,round(sum(j.dramount)*j.id,2) unappliedramount,"
    				+ "coalesce(o.amount,0) unappliedoutamount,round((sum(dramount) - coalesce(o.amount,0)*id)*j.id,2) unappliedbalance " +
    				" from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount "
    				+ "from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"'" +
    				" group by tranid) o on j.tranid=o.tranid inner join my_brch b on j.brhId=b.doc_no where j.status=3 and h.atype='"+atype+"' and j.acno="+acno+" and j.date<='"+sqlUpToDate+"'"+sqld+" group by j.tranid having unappliedbalance<>0 UNION ALL" +
    				" select round(sum(j.dramount)*j.id,2) applieddramount,coalesce(o.amount,0)*id appliedoutamount,round((sum(dramount) - coalesce(o.amount,0)*id)*j.id,2) appliedbalance,0 unappliedramount,0 unappliedoutamount,0 unappliedbalance from my_jvtran j" +
    				" inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.tranid where j.date<='"+sqlUpToDate+"' group by ap_trid) o on j.tranid=o.ap_trid " +
    				" inner join my_brch b on j.brhId=b.doc_no where j.status=3 and h.atype='"+atype+"' and j.acno="+acno+" and j.date<='"+sqlUpToDate+"'"+sqld1+" group by j.tranid having appliedbalance<>0) a";
    				
    		ResultSet resultSetTotal = stmtAgeingStatement.executeQuery(sqlTotal);
    		
    		while(resultSetTotal.next()){
    			ageingStatementBean.setLblsumnetamount(resultSetTotal.getString("totalunappliedamount"));
    			ageingStatementBean.setLblsumapplied(resultSetTotal.getString("totalapplied"));
    			ageingStatementBean.setLblsumbalance(resultSetTotal.getString("unappliedbalance"));
    			
    			ageingStatementBean.setLblsumoutnetamount(resultSetTotal.getString("totaloutamount"));
    			ageingStatementBean.setLblsumoutapplied(resultSetTotal.getString("totaloutapplied"));
    			ageingStatementBean.setLblsumoutbalance(resultSetTotal.getString("outstandingbalance"));
    			
    			ageingStatementBean.setLblnetamount(resultSetTotal.getString("nettotal"));
    		}
            
    		String unclearedreceiptssql = "",sqlUnclrAccountStatementResult="0";
	       	Double netunclrdebittotal=0.00;Double netunclrcredittotal=0.00;Double netunclramount=0.00;
	       	   
    		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
       			unclearedreceiptssql+=" and m.brhId="+branch+"";
       		}
   		
       		unclearedreceiptssql="select a.*,coalesce(round(@i:=@i+amount,2),0) netamountvalue from (SELECT m.doc_no,DATE_FORMAT((m.date),'%d-%m-%Y') date,m.dtype,m.chqno,DATE_FORMAT((m.chqdt),'%d-%m-%Y') chqdt,m.chqname,CONVERT(if(d.amount>0,round((d.amount*1),2),null),CHAR(100)) debit,"  
       		   		+ "CONVERT(if(d.amount<0,round((d.amount*-1),2),' '),CHAR(100)) credit,d.amount FROM my_unclrchqreceiptm m left join my_unclrchqreceiptd d on m.doc_no=d.rdocno where m.status=3 and m.bpvno=0 and d.acno="+acno+""+unclearedreceiptssql+") a,"
       				+ "(select @i:=0) as i";
       		
       		ResultSet resultSetUnclearAgeingStatement = stmtAgeingStatement.executeQuery(unclearedreceiptssql);
       	//	System.out.println("uncleadred cheque"+unclearedreceiptssql);
       		while(resultSetUnclearAgeingStatement.next()){
       			sqlUnclrAccountStatementResult="1";
       			netunclrdebittotal=netunclrdebittotal+resultSetUnclearAgeingStatement.getDouble("debit");
       			netunclrcredittotal=netunclrcredittotal+resultSetUnclearAgeingStatement.getDouble("credit");
       		}
       		
       		netunclramount=netunclrdebittotal-netunclrcredittotal;
       		
       		netunclrdebittotal = commonDAO.Round(netunclrdebittotal, 2);
       		netunclrcredittotal = commonDAO.Round(netunclrcredittotal, 2);
       		netunclramount = commonDAO.Round(netunclramount, 2);
       		
       		String unclearedreceiptssql2 = "",sqlUnclrAccountStatementResult2="0";
       		Double netunclrdebittotalnew=0.00;Double netunclrcredittotalnew=0.00;Double netunclramountnew=0.00;
       		
       		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
       			unclearedreceiptssql2+=" and m.brhId="+branch+"";
       		}
   		
       		unclearedreceiptssql2="select a.*,coalesce(round(@i:=@i+amount,2),0) netamountvalue from (SELECT m.doc_no,DATE_FORMAT((m.date),'%d-%m-%Y') date,"
       			+ " m.dtype,m.chqno,DATE_FORMAT((m.chqdt),'%d-%m-%Y') chqdt,m.chqname,CONVERT(if(d.amount>0,round((d.amount*1),2),null),CHAR(100)) debit,"
       			+" CONVERT(if(d.amount<0,round((d.amount*-1),2),0.00),CHAR(100)) credit,d.amount FROM my_chqbm m "
				+" left join my_chqbd d on (m.tr_no=d.tr_no and m.brhid=d.brhid) left join my_chqdet d1 on m.tr_no=d1.tr_no "
				+" where m.status=3 and d1.pdc=1 and d1.status='E' and m.date<='"+uptoDate+"' and d.acno = "+acno+" "+unclearedreceiptssql2+" ) a, (select @i:=0) as i order by date ";
   		//System.out.println("===sqllaaa=="+unclearedreceiptssql2);
       		ResultSet resultSetUnclearAccountStatement = stmtAgeingStatement.executeQuery(unclearedreceiptssql2);
       		
       		while(resultSetUnclearAccountStatement.next()){
       			sqlUnclrAccountStatementResult2="1";
       			netunclrdebittotalnew=netunclrdebittotalnew+resultSetUnclearAccountStatement.getDouble("debit");
       			netunclrcredittotalnew=netunclrcredittotalnew+resultSetUnclearAccountStatement.getDouble("credit");
       		}
       		
       		netunclramountnew=netunclrdebittotalnew-netunclrcredittotalnew;

       		netunclrdebittotalnew = commonDAO.Round(netunclrdebittotalnew, 2);
       		netunclrcredittotalnew = commonDAO.Round(netunclrcredittotalnew, 2);
       		netunclramountnew = commonDAO.Round(netunclramountnew, 2);
       	
       		System.out.println("amount:"+netunclrdebittotalnew+netunclrcredittotalnew+netunclramountnew);
            param.put("imgpath", imgpath);
            param.put("imgpathfooter",imgpathfooter);
            param.put("compname", ageingStatementBean.getLblcompname());
            param.put("compaddress", ageingStatementBean.getLblcompaddress());
            param.put("comptel", ageingStatementBean.getLblcomptel());
            param.put("compfax", ageingStatementBean.getLblcompfax());
            param.put("compbranch", ageingStatementBean.getLblbranch());
            param.put("location", ageingStatementBean.getLbllocation());
            param.put("printname", ageingStatementBean.getLblprintname());
            param.put("subprintname", ageingStatementBean.getLblprintname1());
            
            if(reportFileName.contains("ageingStatementAlfahimPrint.jrxml")){
            	param.put("account", ageingStatementBean.getLblaccountno()+" - "+ageingStatementBean.getLblaccountname());
            } else {
            	param.put("account", ageingStatementBean.getLblaccountname()+" - "+ageingStatementBean.getLblaccountaddress()+" - "+ageingStatementBean.getLblaccountmobileno());            	
            }
            param.put("customeraddress", ageingStatementBean.getLblaccountaddress());
            param.put("customeremail", ageingStatementBean.getLblaccountemail());
            param.put("customermobile", ageingStatementBean.getLblaccountmobileno());
            param.put("customerphone", ageingStatementBean.getLblaccountphone());
            param.put("customerfax", ageingStatementBean.getLblaccountfax());
            param.put("creditperiod", ageingStatementBean.getLblcreditperiodmin()+" (Days)");
	        param.put("creditlimit", ageingStatementBean.getLblcreditlimit());
	        
	        param.put("currency", ageingStatementBean.getLblcurrencycode());
	        param.put("ageingstatementunapplysql", sqlUnapply);
	        param.put("unappliedtotalamount", ageingStatementBean.getLblsumnetamount());
	        param.put("unappliedtotalapplied", ageingStatementBean.getLblsumapplied());
	        param.put("unappliedtotalbalance", ageingStatementBean.getLblsumbalance());
	        param.put("ageingstatementoutstandingsql", sqlOutStanding);
	        param.put("outstandingtotalamount", ageingStatementBean.getLblsumoutnetamount());
	        param.put("outstandingtotalapplied", ageingStatementBean.getLblsumoutapplied());
	        param.put("outstandingtotalbalance", ageingStatementBean.getLblsumoutbalance());
	        param.put("ageingstatementsummarysql", sqlAgeing);
	        param.put("level1", level1from+" - "+level1to);
	        param.put("level2", level2from+" - "+level2to);
	        param.put("level3", level3from+" - "+level3to);
	        param.put("level4", level4from+" - "+level4to);
	        param.put("level5", ">="+level5from+" days");
	        param.put("unclearedreceiptssql", unclearedreceiptssql);
	        param.put("unclearedreceiptssqlnew", unclearedreceiptssql2);
		    param.put("unclearedreceiptscheck", sqlUnclrAccountStatementResult);
		    param.put("unclrdebittotal", String.valueOf(netunclrdebittotal));
		    param.put("unclrcredittotal", String.valueOf(netunclrcredittotal));
		    param.put("unclrnettotal", String.valueOf(netunclramount));
	        param.put("nettotalamount", ageingStatementBean.getLblnetamount());
	        param.put("printby", session.getAttribute("USERNAME"));
	        param.put("debit", netunclrdebittotalnew);
	        param.put("credit", netunclrcredittotalnew);
	        param.put("nettotal", netunclramountnew);
	        
	        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(reportFileName));
  	        JasperReport jasperReport = JasperCompileManager.compileReport(design);
            generateReportPDF(response, param, jasperReport, conn, email, print, String.valueOf(acno));
			
            stmtAgeingStatement.close();
            
		} catch (Exception e) {
            e.printStackTrace();
            conn.close();
    	} finally{
    		conn.close();
    	}
	}
	
	public void printAction1() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpSession session=request.getSession();
	    Connection conn = null;
        java.sql.Date sqlUpToDate = null;
        
		try {
			conn = connDAO.getMyConnection();
	        Statement stmtAgeingStatement =conn.createStatement();
	        param = new HashMap();
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
			String balance=request.getParameter("balance")==null?"0.0":request.getParameter("balance")==""?"0.0":request.getParameter("balance").toString(); 
      	    String branch = request.getParameter("branch");
			String uptoDate = request.getParameter("uptoDate");
			
			ClsAmountToWords amt=new ClsAmountToWords();
		//	System.out.println("bale======="+balance);
			String amtwrds=amt.convertAmountToWords(balance);
		//	System.out.println("amt+======="+amtwrds);
			if(!(uptoDate.equalsIgnoreCase("undefined")) && !(uptoDate.equalsIgnoreCase("")) && !(uptoDate.equalsIgnoreCase("0"))){
				sqlUpToDate = commonDAO.changeStringtoSqlDate(uptoDate);
            }
			
			ageingStatementBean=ageingStatementDAO.getPrint(request,atype,acno,branch,uptoDate,level1from,level1to,level2from,level2to,level3from,level3to,level4from,level4to,level5from);
						
			String reportFileName = "com/dashboard/accounts/ageingstatement/auditletter.jrxml";
			
			
		//	System.out.println("===========reportFileName======="+reportFileName);
			
            String imgpath=request.getSession().getServletContext().getRealPath("/icons/compheader.jpg");
            imgpath=imgpath.replace("\\", "\\\\");
            
            String imgpathfooter=request.getSession().getServletContext().getRealPath("/icons/compfooter.jpg");
            imgpathfooter=imgpathfooter.replace("\\", "\\\\");
            
         
            param.put("imgpath", imgpath);
            param.put("imgpathfooter",imgpathfooter);
            param.put("compname", ageingStatementBean.getLblcompname());
            param.put("address", ageingStatementBean.getLblaccountaddress());
            param.put("customermobile", ageingStatementBean.getLblaccountmobileno());
            param.put("customertel", ageingStatementBean.getLblaccountphone());
            param.put("customerfax", ageingStatementBean.getLblaccountfax());
            param.put("uptodate", uptoDate);
            param.put("clientname",ageingStatementBean.getLblaccountname());
            param.put("amount", balance);
            param.put("amtinwrds",amtwrds);
            
            
            
            System.out.println("ageing"+ageingStatementBean.getLblaccountaddress()+":"+ageingStatementBean.getLblaccountemail()+":"+ageingStatementBean.getLblaccountmobileno()+":"+ageingStatementBean.getLblaccountphone()+":"+ageingStatementBean.getLblaccountfax()+":"+ageingStatementBean.getLblnetamount());
            
	        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(reportFileName));
  	        JasperReport jasperReport = JasperCompileManager.compileReport(design);
  	      generateReportPDFaudit(response, param, jasperReport, conn);
			
            stmtAgeingStatement.close();
            
		} catch (Exception e) {
            e.printStackTrace();
            conn.close();
    	} finally{
    		conn.close();
    	}
	}
	
	private void generateReportPDFaudit (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException {
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
       	  
        	 String fileName="",path="", formcode="BAGE",filepath=""; 
        	 
        	 String strSql1 = "select imgPath from my_comp";
        	 ResultSet rs1 = stmtAgeingStatement1.executeQuery(strSql1);
     		
        	 while(rs1.next ()) {
     			path=rs1.getString("imgPath");
     		}

     		DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
   		    java.util.Date date = new java.util.Date();
   		    String currdate=dateFormat.format(date);
   		
     		fileName = "AgeingStatement["+ageingStatementBean.getLblaccountname()+"]"+currdate+".pdf";
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
			sendmail.SendTomail( saveFile,formcode,email,acno,session.getAttribute("BRANCHID").toString().trim(),session.getAttribute("USERID").toString().trim(),ageingStatementBean.getLblaccountname());
			
         }
              
     }
}