package com.dashboard.accounts.ageingstatementmonthly;

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

public class ClsAgeingStatementMonthlyAction extends ActionSupport{
    
	ClsAgeingStatementMonthlyDAO accountStatementMonthlyDAO= new ClsAgeingStatementMonthlyDAO();
	ClsAgeingStatementMonthlyBean ageingStatementMonthlyBean;
	
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
	        Statement stmtAgeingStatementMonthly =conn.createStatement();
	        param = new HashMap();
	        String sqld="",sqld1="",joins="",casestatement="",sqlUnapplyResult="0";
	        
			String atype = request.getParameter("atype");
			int acno=Integer.parseInt(request.getParameter("acno"));
			String branch = request.getParameter("branch");
			String sqlUpToDate = request.getParameter("uptoDate");
			
			ageingStatementMonthlyBean=accountStatementMonthlyDAO.getPrint(request,atype,acno,branch,sqlUpToDate);
			String reportFileName = "ageingStatementMonthlyPrint";
			
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
    		
    		String sqlUnapply = "select b.transno,b.date,b.transType,@m:=@s ref_detail,@s:=convert(b.dates ,char(100)) refno,b.description,b.netamount,b.applied,b.balance,b.brhid,b.monthyear,if(@m!=@s,@i:=balance,coalesce(round(@i:=@i+balance,2),0)) monthwiserunningbalance,"
    				+ "coalesce(round(@r:=@r+balance,2),0) totalrunningbalance from (select "+casestatement+"a.date,a.dates,a.monthyear,a.transType,a.description,round(a.netamount,2) netamount,round(a.applied,2) applied,round(a.balance,2) balance,a.brhid from ("
					+ "select j.doc_no transNo,j.description,DATE_FORMAT((j.date),'%d-%m-%Y') date,DATE_FORMAT((j.date),'%Y%m') dates,DATE_FORMAT((j.date),'%b - %Y') monthyear,j.dtype transType,round(sum(j.dramount)*j.id,2) netamount,round(coalesce(o.amount,0),2) applied," 
    				+ "round((sum(dramount) - coalesce(o.amount,0)*id)*j.id,2) balance,j.brhId from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on "
					+ "j.tranid=o.AP_trid where j.date<='"+sqlUpToDate+"' group by tranid) o on j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' and j.acno="+acno+" and j.date<='"+sqlUpToDate+"'"+sqld+" group by j.tranid having balance<>0 order by j.date) a"+joins+") b,"
					+ "(select @i:=0) as i,(select @m:=0) as m,(select @s:=0) as s,(select @r:=0) as r";
					
    		
			ResultSet resultSetUnapply = stmtAgeingStatementMonthly.executeQuery(sqlUnapply);
    		
    		while(resultSetUnapply.next()){
    			sqlUnapplyResult="1";
    		}
    		
    		if(sqlUnapplyResult.equalsIgnoreCase("0")){
    			sqlUnapply="select null date,null transno,null transType,null description,null netamount,null applied,null balance,null monthyear,null monthwiserunningbalance,null totalrunningbalance";
    		}
    		
    		String sqlOutStanding = "select b.transno,b.date,b.transType,@m:=@s ref_detail,@s:=convert(b.dates ,char(100)) refno,b.description,b.netamount,b.applied,b.balance,b.brhid,b.monthyear,if(@m!=@s,@i:=balance,coalesce(round(@i:=@i+balance,2),0)) monthwiserunningbalance,"
    					+ "coalesce(round(@r:=@r+balance,2),0) totalrunningbalance from (select "+casestatement+"a.date,a.dates,a.monthyear,a.transType,a.description,round(a.netamount,2) netamount,round(a.applied,2) applied,round(a.balance,2) balance,a.brhid from ("
    					+ "select j.doc_no transNo,j.description,DATE_FORMAT((j.date),'%d-%m-%Y') date,DATE_FORMAT((j.date),'%Y%m') dates,DATE_FORMAT((j.date),'%b - %Y') monthyear,j.dtype transType,round(sum(j.dramount)*j.id,2) netamount,round(coalesce(o.amount,0),2) applied," 
	    				+ "round((sum(dramount) - coalesce(o.amount,0)*id)*j.id,2) balance,j.brhId from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on "
    					+ "j.tranid=o.trANid where j.date<='"+sqlUpToDate+"' group by AP_trid) o on j.tranid=o.ap_trid where j.status=3 and h.atype='"+atype+"' and j.acno="+acno+" and j.date<='"+sqlUpToDate+"'"+sqld1+" group by j.tranid having balance<>0 order by j.date) a"+joins+") b,"
    					+ "(select @i:=0) as i,(select @m:=0) as m,(select @s:=0) as s,(select @r:=0) as r";
    					
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
    		
    		ResultSet resultSetTotal = stmtAgeingStatementMonthly.executeQuery(sqlTotal);
    		
    		while(resultSetTotal.next()){
    			ageingStatementMonthlyBean.setLblsumnetamount(resultSetTotal.getString("totalunappliedamount"));
    			ageingStatementMonthlyBean.setLblsumapplied(resultSetTotal.getString("totalapplied"));
    			ageingStatementMonthlyBean.setLblsumbalance(resultSetTotal.getString("unappliedbalance"));
    			
    			ageingStatementMonthlyBean.setLblsumoutnetamount(resultSetTotal.getString("totaloutamount"));
    			ageingStatementMonthlyBean.setLblsumoutapplied(resultSetTotal.getString("totaloutapplied"));
    			ageingStatementMonthlyBean.setLblsumoutbalance(resultSetTotal.getString("outstandingbalance"));
    			
    			ageingStatementMonthlyBean.setLblnetamount(resultSetTotal.getString("nettotal"));
    		}
            
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
	        
	        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/accounts/ageingstatementmonthly/" + reportFileName + ".jrxml"));
  	        JasperReport jasperReport = JasperCompileManager.compileReport(design);
            generateReportPDF(response, param, jasperReport, conn, String.valueOf(acno));
			
            stmtAgeingStatementMonthly.close();
            
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