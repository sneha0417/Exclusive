package com.dashboard.accounts.balancesheet;

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

public class ClsBalanceSheetAction extends ActionSupport{
    
	ClsBalanceSheetDAO balanceSheetDAO= new ClsBalanceSheetDAO();
	ClsBalanceSheetBean balanceSheetBean;
	
	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	
	//Print
	private String lblcompname;
	private String lblcompaddress;
	private String lblmainprintname;
	private String lblprintname;
	private String lblmainprintname1;
	private String lblprintname1;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	private String lblservicetax;
	private String lblpan;
	private String lblcstno;
	
	private String lblassettotal;
	private String lbllaibilitiesandequitytotal;
	private String lblexpensestotal;
	private String lblincometotal;
	private String lblprofitandlossamount;
	private String balancesheetqry;
	
	
	
	public String getBalancesheetqry() {
		return balancesheetqry;
	}

	public void setBalancesheetqry(String balancesheetqry) {
		this.balancesheetqry = balancesheetqry;
	}

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

	public String getLblmainprintname() {
		return lblmainprintname;
	}

	public void setLblmainprintname(String lblmainprintname) {
		this.lblmainprintname = lblmainprintname;
	}

	public String getLblprintname() {
		return lblprintname;
	}

	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}

	public String getLblmainprintname1() {
		return lblmainprintname1;
	}

	public void setLblmainprintname1(String lblmainprintname1) {
		this.lblmainprintname1 = lblmainprintname1;
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

	public String getLblassettotal() {
		return lblassettotal;
	}

	public void setLblassettotal(String lblassettotal) {
		this.lblassettotal = lblassettotal;
	}

	public String getLbllaibilitiesandequitytotal() {
		return lbllaibilitiesandequitytotal;
	}

	public void setLbllaibilitiesandequitytotal(String lbllaibilitiesandequitytotal) {
		this.lbllaibilitiesandequitytotal = lbllaibilitiesandequitytotal;
	}

	public String getLblexpensestotal() {
		return lblexpensestotal;
	}

	public void setLblexpensestotal(String lblexpensestotal) {
		this.lblexpensestotal = lblexpensestotal;
	}

	public String getLblincometotal() {
		return lblincometotal;
	}

	public void setLblincometotal(String lblincometotal) {
		this.lblincometotal = lblincometotal;
	}

	public String getLblprofitandlossamount() {
		return lblprofitandlossamount;
	}

	public void setLblprofitandlossamount(String lblprofitandlossamount) {
		this.lblprofitandlossamount = lblprofitandlossamount;
	}

	public Map<String, Object> getParam() {
		return param;
	}

	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	public void printTFormAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpSession session=request.getSession();
	    Connection conn = null;
	    java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		try {
			conn = connDAO.getMyConnection();
	        Statement stmtBalanceSheet =conn.createStatement();
	        param = new HashMap();
	        String sqlAssetsResult="0",assetTotal="0",sqlLaibilitiesAndEquityResult="0",laibilitiesAndEquityTotal="0",sqlExpensesResult="0",expenseTotal="0",sqlIncomeResult="0",incomeTotal="0",profitAndLossAmount="0";
	        
			String branch = request.getParameter("branch");
			String fromDate = request.getParameter("fromdate");
			String toDate = request.getParameter("todate");
			
			if(!(fromDate.equalsIgnoreCase("undefined")) && !(fromDate.equalsIgnoreCase("")) && !(fromDate.equalsIgnoreCase("0"))){
                sqlFromDate = commonDAO.changeStringtoSqlDate(fromDate);
            }
            if(!(toDate.equalsIgnoreCase("undefined")) && !(toDate.equalsIgnoreCase("")) && !(toDate.equalsIgnoreCase("0"))){
                sqlToDate = commonDAO.changeStringtoSqlDate(toDate);
            }
            
			balanceSheetBean=balanceSheetDAO.getPrintTForm(request,branch,toDate);
			String reportFileName = commonDAO.getBIBPrintPath1("BBS");
			
            String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
            imgpath=imgpath.replace("\\", "\\\\");
    		
    		String sqlAssets = "select d.accountname,CONVERT(format(if(d.acno in (0,9999999),'',round(coalesce(d.amount,0),2)),2),CHAR(1000)) amount,round(if(d.acno=0,@i:=0,@i:=@i+coalesce(d.amount,0)),2) runningtotal,"
    				+ "CONVERT(if(d.acno=9999999,format(round(if(d.acno=0,@i:=0,@i:=@i+coalesce(d.amount,0)),2),2),''),CHAR(1000)) netamount,format(round(@j:=@j+round(coalesce(d.amount,0),2),2),2) nettotal from ( select 0 subac,0 amount,if(g.gp_id<=15,1,if(g.gp_id<=18,2,3)) grplevel,"
    				+ "g.gp_id,if(g.gtype='D',0,9999999) acno,0 account,g.gp_desc accountname,h.den from my_head h,gc_agrpd g where grpno=0 and g.gtype in ('D','G') and gp_id<=12 group by g.gp_desc "
    				+ "UNION ALL select h1.doc_no subac,sum(j.ldramount) amount,a.* from ( select if(g.gp_id<=15,1,if(g.gp_id<=18,2,3)) grplevel,g.gp_id,h.doc_no acno,h.account,p.head accountname,"
    				+ "h.den from my_head h,my_agrp p,gc_agrpd g where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id<=12  group by g.gp_id,h.den order by g.gp_id,h.doc_no) a "
    				+ "left join my_head h1 on a.den=h1.den left join my_jvtran j on h1.doc_no=j.acno where j.status=3  and j.date <= '"+sqlToDate+"' group by a.acno order by grplevel,gp_id,acno,subac) d,(SELECT @i:= 0) as i,(SELECT @j:= 0) as j";
					
			ResultSet resultSetAssets = stmtBalanceSheet.executeQuery(sqlAssets);
    		
    		while(resultSetAssets.next()){
    			sqlAssetsResult="1";
    			assetTotal=resultSetAssets.getString("nettotal");
    		}
    		
    		
    		if(sqlAssetsResult.equalsIgnoreCase("0")){
    			sqlAssets="select null accountname,null amount,null runningtotal,null netamount";
    		}
    		
    		String sqlLaibilitiesAndEquity = "select d.accountname,CONVERT(format(if(d.acno in (0,999997,9999999),'',round(d.amount*-1,2)),2),CHAR(1000)) amount,round(if(d.acno=0,@i:=0,if(d.acno not in (9999999),@i:=@i+coalesce((d.amount*-1),0),@i)),2) runningtotal,"
    				+ "CONVERT(if(d.acno=9999999,format(round(if(d.acno=0,@i:=0,@i:=@i+coalesce((d.amount*-1),0)),2),2),''),CHAR(1000)) netamount,format(round(@j:=@j+round(coalesce((d.amount*-1),0),2),2),2) nettotal from (select 0 subac,0 amount,if(g.gp_id<=15,1,if(g.gp_id<=18,2,3)) grplevel,g.gp_id,if(g.gtype='D',0,9999999) acno,0 account,g.gp_desc accountname,"
    				+ "h.den from my_head h,gc_agrpd g where grpno=0 and g.gtype in ('D','G') and gp_id>=13 and gp_id<=17 and gp_desc!='NET STOCK HOLDERS EQUITY' group by g.gp_desc UNION ALL select subac, sum(amount) amount, grplevel, gp_id, acno, account, accountname, den from ( "
    				+ "select h1.doc_no subac,sum(j.ldramount) amount,a.* from ( "
    				+ "select if(g.gp_id<=15,1,if(g.gp_id<=18,2,3)) grplevel,g.gp_id,h.doc_no acno,h.account,p.head accountname,h.den from my_head h,my_agrp p,gc_agrpd g where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id>=13 and gp_id<=17  "
    				+ "group by g.gp_id,h.den order by g.gp_id,h.doc_no) a left join my_head h1 on a.den=h1.den left join my_jvtran j on h1.doc_no=j.acno where j.status=3 and j.date <= '"+sqlFromDate+"' group by a.acno UNION ALL select h1.doc_no subac,sum(j.ldramount) amount,a.* from ( "
    				+ "select if(g.gp_id<=15,1,if(g.gp_id<=18,2,3)) grplevel,g.gp_id,h.doc_no acno,h.account,p.head accountname,h.den from my_head h,my_agrp p,gc_agrpd g where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id>=13 and gp_id<=17  "
    				+ "group by g.gp_id,h.den order by g.gp_id,h.doc_no) a left join my_head h1 on a.den=h1.den left join my_jvtran j on h1.doc_no=j.acno where j.status=3 and j.date between '"+sqlFromDate+"' and  '"+sqlToDate+"'  and j.yrid=0  group by a.acno) bal group by acno UNION ALL "
    				+ "Select 0 subac,0 amount,2 grplevel,17 gp_id,999997 acno,0 account,'Prior Period PROFIT/(LOSS)' accountname,455 den UNION ALL Select 0 subac,sum(ldramount) amount,2 grplevel,17 gp_id,999998 acno,0 account,'PROFIT/(LOSS) For The Period' accountname,"
    				+ "den from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and t.yrid=0 and  h.gr_type in (4,5) UNION ALL select 0 subac,0 amount,if(g.gp_id<=15,1,if(g.gp_id<=18,2,3)) grplevel,g.gp_id,"
    				+ "if(g.gtype='D',0,9999999) acno,0 account,g.gp_desc accountname,h.den from my_head h,gc_agrpd g where grpno=0 and g.gtype in ('G') and gp_id=17  group by g.gp_desc order by grplevel,gp_id,acno,subac) d,(SELECT @i:= 0) as i,(SELECT @j:= 0) as j";
//    		System.out.println("===liabilty ======"+sqlLaibilitiesAndEquity);
    		ResultSet resultSetLaibilitiesAndEquity = stmtBalanceSheet.executeQuery(sqlLaibilitiesAndEquity);
    		
    		while(resultSetLaibilitiesAndEquity.next()){
    			sqlLaibilitiesAndEquityResult="1";
    			laibilitiesAndEquityTotal=resultSetLaibilitiesAndEquity.getString("nettotal");
    		}
    		
    		if(sqlLaibilitiesAndEquityResult.equalsIgnoreCase("0")){
    			sqlLaibilitiesAndEquity="select null accountname,null amount,null runningtotal,null netamount";
    		}
    		
    		String sqlExpenses = "select d.accountname,CONVERT(format(if(d.acno in (0,9999999),'',round(coalesce(d.amount,0),2)),2),CHAR(1000)) amount,round(if(d.acno=0,@i:=0,@i:=@i+coalesce(d.amount,0)),2) runningtotal,"
    				+ "CONVERT(if(d.acno=9999999,format(round(if(d.acno=0,@i:=0,@i:=@i+coalesce(d.amount,0)),2),2),''),CHAR(1000)) netamount,format(round(@j:=@j+round(coalesce(d.amount,0),2),2),2) nettotal from ( select 0 subac,0 amount,if(g.gp_id<=15,1,if(g.gp_id<=18,2,3)) grplevel,"
    				+ "g.gp_id,if(g.gtype='D',0,9999999) acno,0 account,g.gp_desc accountname,h.den from my_head h,gc_agrpd g where grpno=0 and g.gtype in ('D','G') and gp_id>19 group by g.gp_desc "
    				+ "UNION ALL select h1.doc_no subac,sum(j.ldramount) amount,a.* from ( select if(g.gp_id<=15,1,if(g.gp_id<=18,2,3)) grplevel,g.gp_id,h.doc_no acno,h.account,p.head accountname,"
    				+ "h.den from my_head h,my_agrp p,gc_agrpd g where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id>19  group by g.gp_id,h.den order by g.gp_id,h.doc_no) a "
    				+ "left join my_head h1 on a.den=h1.den left join my_jvtran j on h1.doc_no=j.acno where j.status=3 and j.yrid=0  and j.date between '"+sqlFromDate+"' and '"+sqlToDate+"' group by a.acno order by grplevel,gp_id,acno,subac) d,"
    				+ "(SELECT @i:= 0) as i,(SELECT @j:= 0) as j where d.gp_id in (20,23)";
//    		System.out.println("==== expense ==== "+sqlExpenses);
    		ResultSet resultSetExpenses = stmtBalanceSheet.executeQuery(sqlExpenses);
    		
    		while(resultSetExpenses.next()){
    			sqlExpensesResult="1";
    			
    			expenseTotal=resultSetExpenses.getString("nettotal");
    		}
    		
    		if(sqlExpensesResult.equalsIgnoreCase("0")){
    			sqlExpenses="select null accountname,null amount,null runningtotal,null netamount";
    		}
    		
    		String sqlIncome = "select d.accountname,CONVERT(format(if(d.acno in (0,9999999),'',round(coalesce(d.amount,0),2)),2),CHAR(1000)) amount,round(if(d.acno=0,@i:=0,@i:=@i+coalesce(d.amount,0)),2) runningtotal,"
    				+ "CONVERT(if(d.acno=9999999,format(round(if(d.acno=0,@i:=0,@i:=@i+coalesce(d.amount,0)),2),2),''),CHAR(1000)) netamount,format(round(@j:=@j+round(coalesce(d.amount,0),2),2),2) nettotal from (select 0 subac,0 amount,if(g.gp_id<=15,1,if(g.gp_id<=18,2,3)) grplevel,"
    				+ "g.gp_id,if(g.gtype='D',0,9999999) acno,0 account,g.gp_desc accountname,h.den from my_head h,gc_agrpd g where grpno=0 and g.gtype in ('D','G') and gp_id>18 group by g.gp_desc "
    				+ "UNION ALL select h1.doc_no subac,sum(j.ldramount) amount,a.* from ( select if(g.gp_id<=15,1,if(g.gp_id<=18,2,3)) grplevel,g.gp_id,h.doc_no acno,h.account,p.head accountname,h.den "
    				+ "from my_head h,my_agrp p,gc_agrpd g where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id>18  group by g.gp_id,h.den order by g.gp_id,h.doc_no) a "
    				+ "left join my_head h1 on a.den=h1.den left join my_jvtran j on h1.doc_no=j.acno where j.status=3 and j.yrid=0  and j.date between '"+sqlFromDate+"' and '"+sqlToDate+"'  group by a.acno order by grplevel,gp_id,acno,subac) d,"
    				+ "(SELECT @i:= 0) as i,(SELECT @j:= 0) as j where d.gp_id in (19,22)";
    		
    		ResultSet resultSetIncome = stmtBalanceSheet.executeQuery(sqlIncome);
    		
    		while(resultSetIncome.next()){
    			sqlIncomeResult="1";
    			
    			incomeTotal=resultSetIncome.getString("nettotal");
    		}
    		
    		if(sqlIncomeResult.equalsIgnoreCase("0")){
    			sqlIncome="select null accountname,null amount,null runningtotal,null netamount";
    		}
    		
    		String sqlProfitAndLoss = "select format(round(coalesce(sum(ldramount)*-1,0),2),2) profitlossamount from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and t.yrid=0 and h.gr_type in (4,5)";
    		
    		ResultSet resultSetsqlProfitAndLoss = stmtBalanceSheet.executeQuery(sqlProfitAndLoss);
    		
    		while(resultSetsqlProfitAndLoss.next()){
    			profitAndLossAmount=resultSetsqlProfitAndLoss.getString("profitlossamount");
    		}
            
            param.put("imgpath", imgpath);
            param.put("compname", balanceSheetBean.getLblcompname());
            param.put("compaddress", balanceSheetBean.getLblcompaddress());
            param.put("comptel", balanceSheetBean.getLblcomptel());
            param.put("compfax", balanceSheetBean.getLblcompfax());
            param.put("compbranch", balanceSheetBean.getLblbranch());
            param.put("location", balanceSheetBean.getLbllocation());
            param.put("printname", balanceSheetBean.getLblprintname());
            param.put("subprintname", balanceSheetBean.getLblprintname1());
	        param.put("assetsql", sqlAssets);
	        param.put("laibilitiesandequitysql", sqlLaibilitiesAndEquity);
	        param.put("assettotal", assetTotal);
	        param.put("laibilitiesandequitytotal", laibilitiesAndEquityTotal);
	        param.put("expensessql", sqlExpenses);
	        param.put("incomesql", sqlIncome);
	        param.put("expensestotal", expenseTotal);
	        param.put("incometotal", incomeTotal);
	        param.put("profitandlossamount", profitAndLossAmount);
	        param.put("printby", session.getAttribute("USERNAME"));
	        param.put("fromdate", fromDate);
	        param.put("todate", toDate);
	        
	        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(reportFileName));
  	        JasperReport jasperReport = JasperCompileManager.compileReport(design);
            generateReportPDF(response, param, jasperReport, conn);
			
            stmtBalanceSheet.close();
            
		} catch (Exception e) {
            e.printStackTrace();
            conn.close();
    	} finally{
    		conn.close();
    	}
	}
	
	public String printAction() throws ParseException, SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
				
		String branchval = request.getParameter("branchval");
		String fromdate = request.getParameter("fromdate");
		String todate = request.getParameter("todate");
		
//		System.out.println("dates"+fromdate+todate);
		
		 java.sql.Date sqlFromDate = null;
	     java.sql.Date sqlToDate = null;
		
	     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
                sqlFromDate = commonDAO.changeStringtoSqlDate(fromdate);
            }
            if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
                sqlToDate = commonDAO.changeStringtoSqlDate(todate);
            }
		
		balanceSheetBean=balanceSheetDAO.getPrint(request,branchval,fromdate,todate);
		setLblcompname(balanceSheetBean.getLblcompname());
		setLblcompaddress(balanceSheetBean.getLblcompaddress());
		setLblprintname(balanceSheetBean.getLblprintname());
		setLblcomptel(balanceSheetBean.getLblcomptel());
		setLblcompfax(balanceSheetBean.getLblcompfax());
		setLblbranch(balanceSheetBean.getLblbranch());
		setLbllocation(balanceSheetBean.getLbllocation());
		
		if(commonDAO.getBIBPrintPath("BBS").contains(".jrxml")==true)
		{
			HttpServletResponse response = ServletActionContext.getResponse();
			
			 Connection conn = null;
			
		     
			 try {
				 param = new HashMap();
			
		      	 conn = connDAO.getMyConnection();
             	 String reportFileName = commonDAO.getBIBPrintPath("BBS");
             	 Statement BalanceSheet =conn.createStatement();
             	 
             	 
             	String sqlqry ="select gp_desc,head,grpHead,description,round(dr,2)dr,gp_id,den,groupNo from(select m.gp_desc,m.head,m.grpHead,a.description,m.den, "
               		  + "ldramount*if(gp_id is null,dr*if(gp_id<=15,1,-1),dr*drsign) dr,gp_id,groupNo from(select @xwrk:=0,if(g.gp_id<=15,1,if(g.gp_id<=18,2,3)) grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel, "
               		  + "length(h.alevel) alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g where grpno=0 and h.den=p.fi_id and p.gp_pr=g.gp_id "
               		  + "and g.gtype='D' and gp_id<=17) m  ,my_head a ,(SELECT 139 acno,sum(ldramount) ldramount from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and "
               		  + "t.date<'"+sqlFromDate+" ' and h.gr_type>=4 UNION ALL Select 140 acno,sum(ldramount) ldramount from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and "
               		  +	"gr_type>=4 and t.date between '"+sqlFromDate+" ' and '"+sqlToDate+" ' and h.gr_type>=4 and t.trtype!=1 and t.yrid=0 "
               		  +	"UNION ALL SELECT acno,sum(ldramount) ldramount from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no "
               		  +	"and gr_type<4 and t.date<='"+sqlToDate+" ' and !(t.dtype='YRC' and trtype=1) group by t.acno) t " 
               		  +	"where a.m_s=0 and (m.groupno=t.acno or left(a.alevel,m.alen+1)=m.alevel) and a.doc_no=t.acno "
               		  +	"group by m.grplevel,gp_id,m.den,groupno,a.doc_no union all select '' gp_desc,'' head,'' grpHead,ex.description description,den,ex.netamt dr,gp_id,groupNo from "
               		  +	"(select den,@i:=@i+1 id,k.description,CONVERT(if(k.grpamt=0,'',round(k.grpamt,2)),CHAR(100)) grpamt,CONVERT(if(k.netamt=0,'',round(k.netamt,2)),CHAR(100)) netamt, "
               		  +	"CONVERT(if(k.childamt=0,'',round(k.childamt,2)),CHAR(100)) childamt,CONVERT(if(k.subchildamt=0,'',round(k.subchildamt,2)),CHAR(100)) subchildamt, "
               		  +	"k.gp_id,k.ordno,(case when k.ordno in (5,0,1) then 'null' else k.ordno end ) parentid,k.groupno,k.subac from (select if(gtype='X',6,0) ORDNO, "
               		  +	"gp_id,0 den,0 groupNo, 0 subac,gp_desc description,if(gtype='X',@xwrk,0) dr,0 mainamt,0 agrpAmt,0 grpAmt,if(gtype='X',@xwrk,0) netAmt,0 childAmt, "
               		  +	"0 subchildAmt from gc_agrpd where gtype in('D','X') and gp_id<=17 UNION ALL Select 0 ORDNO,19 gp_id,0 den,0 groupNo, 0 subac,'PROFIT FOR THE PERIOD 01.10.2017 TO 04.11.2018' description,0 dr,0 mainamt,0 agrpAmt,0 grpAmt,sum(ldramount)*-1 netAmt,0 childAmt,0 subchildAmt from my_jvtran t,my_head h "
               		  +	"where t.status=3 and t.acno=h.doc_no and t.date between '"+sqlFromDate+" ' and '"+sqlToDate+" ' and h.gr_type in (4,5)  and t.yrid=0 UNION ALL select @xlevel:=if(grpLevel is null,0,if(gp_id is null,1,if(den is null,5,if(groupNo is null,3,if(subac is null,4,6))))) ordno,if(gp_id is not null,gp_id,if(grpLevel=1,16,if(grpLevel=2,20,19))) gp_id,ifnull(den,0) den, "
               		  +	"ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,if(gp_id is null,if(grpLevel=1,'NET ASSET',' TOTAL EQUITY'),if(den is null, "
               		  +	"M.GP_DESC,if(groupNo is null,M.HEAD,if(subac is null,m.grpHead,m.account)))) DESCRIPTION, @xdramt:=if(gp_id is null,dr*if(grpLevel=1,1,-1),dr*drsign) dr, "
               		  +	"0 mainAmt,0 agrpAmt,if(@xlevel=4,@xdramt*1,0) grpAmt,if(@xlevel=5,@xdramt*1,if(@xlevel=1,@xdramt*1,0)) netAmt,if(@xlevel=3,@xdramt*1,0) childAmt, "
               		  +	"if(@xlevel=6,@xdramt*1,0) subchildAmt from (select a.doc_no subac,m.*,sum(ldramount) dr, @xwrk:=@xwrk+(if(gp_id between 12 and 14 and a.doc_no is not null, "
               		  +	"ldramount,0)) ldr,a.description account,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from (select @xwrk:=0,if(g.gp_id<=15,1, "
               		  +	"if(g.gp_id<=18,2,3)) grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel, "
               		  +	"length(h.alevel) alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g where grpno=0 and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id<=17) m, "
               		  +	"my_head a,(SELECT 139 acno,sum(ldramount) ldramount from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and t.date<'"+sqlFromDate+" ' and h.gr_type>=4 "
               		  +	"UNION ALL Select 140 acno,sum(ldramount) ldramount from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and gr_type>=4 and t.date between '"+sqlFromDate+" ' and '"+sqlToDate+" ' and h.gr_type>=4 and t.trtype!=1  and t.yrid=0"
               		  +	"UNION ALL SELECT acno,sum(ldramount) ldramount from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and gr_type<4 and t.date<='"+sqlToDate+" ' and !(t.dtype='YRC' and trtype=1)  and t.yrid=0 group by t.acno ) t "
               		  +	"where (m.groupNo=t.acno or left(a.alevel,m.alen+1)=m.alevel) and a.doc_no=t.acno group by grplevel,gp_id,den,groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k, "
               		  +	"(SELECT @i:= 0) as i where (k.netamt!=0 or k.grpamt!=0 or k.childamt!=0 or k.subchildamt!=0) order by gp_id,den,groupno,ordno) ex "
               		  +	"where ex.netamt!=0 and gp_id in(14,16,19) union all select '' gp_desc,'' head,'' grpHead,'TOTAL EQUITY' description,den,sum(ex.netamt) dr,30 gp_id,groupNo  from "
               		  +	"(select den,@i:=@i+1 id,k.description,CONVERT(if(k.grpamt=0,'',round(k.grpamt,2)),CHAR(100)) grpamt,CONVERT(if(k.netamt=0,'',round(k.netamt,2)),CHAR(100)) netamt, "
               		  +	"CONVERT(if(k.childamt=0,'',round(k.childamt,2)),CHAR(100)) childamt,CONVERT(if(k.subchildamt=0,'',round(k.subchildamt,2)),CHAR(100)) subchildamt, "
               		  +	"k.gp_id,k.ordno,(case when k.ordno in (5,0,1) then 'null' else k.ordno end ) parentid,k.groupno,k.subac from (select if(gtype='X',6,0) ORDNO, " 
               		  +	"gp_id,0 den,0 groupNo, 0 subac,gp_desc description,if(gtype='X',@xwrk,0) dr,0 mainamt,0 agrpAmt,0 grpAmt,if(gtype='X',@xwrk,0) netAmt,0 childAmt, "
               		  +	"0 subchildAmt from gc_agrpd where gtype in('D','X') and gp_id<=17 UNION ALL Select 0 ORDNO,19 gp_id,0 den,0 groupNo, 0 subac,'PROFIT FOR THE PERIOD 01.10.2017 TO 04.11.2018' description,0 dr,0 mainamt,0 agrpAmt,0 grpAmt,sum(ldramount)*-1 netAmt,0 childAmt,0 subchildAmt from my_jvtran t,my_head h "
               		  +	"where t.status=3 and t.acno=h.doc_no and t.date between '"+sqlFromDate+" ' and '"+sqlToDate+" ' and h.gr_type in (4,5)  and t.yrid=0 UNION ALL select @xlevel:=if(grpLevel is null,0,if(gp_id is null,1,if(den is null,5,if(groupNo is null,3,if(subac is null,4,6))))) ordno,if(gp_id is not null,gp_id,if(grpLevel=1,16,if(grpLevel=2,20,19))) gp_id,ifnull(den,0) den, "
               		  +	"ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,if(gp_id is null,if(grpLevel=1,'NET ASSET',' TOTAL EQUITY'),if(den is null, "
               		  +	"M.GP_DESC,if(groupNo is null,M.HEAD,if(subac is null,m.grpHead,m.account)))) DESCRIPTION, @xdramt:=if(gp_id is null,dr*if(grpLevel=1,1,-1),dr*drsign) dr, "
               		  +	"0 mainAmt,0 agrpAmt,if(@xlevel=4,@xdramt*1,0) grpAmt,if(@xlevel=5,@xdramt*1,if(@xlevel=1,@xdramt*1,0)) netAmt,if(@xlevel=3,@xdramt*1,0) childAmt, "
               		  +	"if(@xlevel=6,@xdramt*1,0) subchildAmt from (select a.doc_no subac,m.*,sum(ldramount) dr, @xwrk:=@xwrk+(if(gp_id between 12 and 14 and a.doc_no is not null, "
               		  +	"ldramount,0)) ldr,a.description account,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from (select @xwrk:=0,if(g.gp_id<=15,1, "
               		  +	"if(g.gp_id<=18,2,3)) grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel, "
               		  +	"length(h.alevel) alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g where grpno=0 and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id<=17) m, "
               		  +	"my_head a,(SELECT 139 acno,sum(ldramount) ldramount from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and t.date<'"+sqlFromDate+" ' and h.gr_type>=4 "
               		  +	"UNION ALL Select 140 acno,sum(ldramount) ldramount from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and gr_type>=4 and t.date between '"+sqlFromDate+" ' and '"+sqlToDate+" ' and h.gr_type>=4 and t.trtype!=1  and t.yrid=0"
               		  +	"UNION ALL SELECT acno,sum(ldramount) ldramount from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and gr_type<4 and t.date<='"+sqlToDate+" ' and !(t.dtype='YRC' and trtype=1) group by t.acno ) t "
               		  +	"where (m.groupNo=t.acno or left(a.alevel,m.alen+1)=m.alevel) and a.doc_no=t.acno group by grplevel,gp_id,den,groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k, "
               		  +	"(SELECT @i:= 0) as i where (k.netamt!=0 or k.grpamt!=0 or k.childamt!=0 or k.subchildamt!=0) order by gp_id,den,groupno,ordno) ex "
               		  +	"where ex.netamt!=0 and gp_id in(17,19) )aa order by gp_id,den,groupNo ";
    					
    			ResultSet resultSet = BalanceSheet.executeQuery(sqlqry);
        		
//    			System.out.println("Print lvl123 sqlqry--->"+sqlqry);
        		while(resultSet.next()){
        			
        		}
             	 
             	 
             	 
                 String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
               	 imgpath=imgpath.replace("\\", "\\\\");
               	 
		         param.put("imgpath", imgpath);
		         param.put("printname", balanceSheetBean.getLblmainprintname());
		         param.put("subprintname", balanceSheetBean.getLblmainprintname1());
		         param.put("compname", balanceSheetBean.getLblcompname());
		         param.put("compaddress", balanceSheetBean.getLblcompaddress());
		         param.put("comptel", balanceSheetBean.getLblcomptel());
		         param.put("compfax", balanceSheetBean.getLblcompfax());
		         param.put("compbranch", balanceSheetBean.getLblbranch());
		         param.put("location", balanceSheetBean.getLbllocation());
		         param.put("printname", balanceSheetBean.getLblprintname()); 
		         param.put("printby", session.getAttribute("USERNAME"));
		         param.put("Fromdate", fromdate);
		         param.put("Todate", todate);
		         param.put("balancesheetqry", sqlqry);
		        
//		         System.out.println("Report File Name-->"+reportFileName);
		        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(reportFileName));
         	 
                JasperReport jasperReport = JasperCompileManager.compileReport(design);
                generateReportPDF(response, param, jasperReport, conn);
                             
          
                 } catch (Exception e) {
                     e.printStackTrace();
                 } finally{
                	 conn.close();
                 }	   	 
		}

		return "print";
	}
	
	///////////////////////////////////Lvl4 Print
	
	
public String print2Action() throws ParseException, SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
				
		String branchval = request.getParameter("branchval");
		String fromdate = request.getParameter("fromdate");
		String todate = request.getParameter("todate");
		
//		System.out.println("dates"+fromdate+todate);
		
		 java.sql.Date sqlFromDate = null;
	     java.sql.Date sqlToDate = null;
		
	     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
                sqlFromDate = commonDAO.changeStringtoSqlDate(fromdate);
            }
            if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
                sqlToDate = commonDAO.changeStringtoSqlDate(todate);
            }
		
		balanceSheetBean=balanceSheetDAO.getPrint(request,branchval,fromdate,todate);
		setLblcompname(balanceSheetBean.getLblcompname());
		setLblcompaddress(balanceSheetBean.getLblcompaddress());
		setLblprintname(balanceSheetBean.getLblprintname());
		setLblcomptel(balanceSheetBean.getLblcomptel());
		setLblcompfax(balanceSheetBean.getLblcompfax());
		setLblbranch(balanceSheetBean.getLblbranch());
		setLbllocation(balanceSheetBean.getLbllocation());
		
		if(commonDAO.getBIBPrintPath("BBS").contains(".jrxml")==true)
		{
			HttpServletResponse response = ServletActionContext.getResponse();
			
			 Connection conn = null;
			
		     
			 try {
				 param = new HashMap();
			
		      	 conn = connDAO.getMyConnection();
             	 String reportFileName = commonDAO.getBIBPrintPath("BBS");
             	 Statement BalanceSheet =conn.createStatement();
             	 
             	 
             	String sqlqry ="select @i:=@i+1 id,k.description,CONVERT(if(k.grpamt=0,'',round(k.grpamt,2)),CHAR(100)) grpamt,CONVERT(if(k.netamt=0,'',round(k.netamt,2)),CHAR(100)) netamt,CONVERT(if(k.childamt=0,'',round(k.childamt,2)),CHAR(100)) childamt,CONVERT(if(k.subchildamt=0,'',round(k.subchildamt,2)),CHAR(100)) subchildamt,k.gp_id,k.ordno,(case when k.ordno in (5,0,1) then 'null' "
				    	  + "else k.ordno end ) parentid,k.groupno,k.subac,case when k.ordno in (5,0,1) then 'Group II' when k.ordno=3 then 'Group I' when k.ordno=4 then 'Main' when k.ordno=6 then k.account else k.ordno end as code from (select if(gtype='X',6,0) ORDNO,gp_id,0 den,0 groupNo, 0 subac,0 account,gp_desc description,if(gtype='X',@xwrk,0) dr,0 mainamt,0 agrpAmt,0 grpAmt,if(gtype='X',@xwrk,0) netAmt,"
				    	  + "0 childAmt,0 subchildAmt from gc_agrpd where gtype in('D','X') and gp_id<=17 UNION ALL Select 0 ORDNO,19 gp_id,0 den,"
				    	  + "0 groupNo, 0 subac,0 account,'PROFIT FOR THE PERIOD "+fromdate+" TO "+todate+"' description,0 dr,0 mainamt,0 agrpAmt,0 grpAmt,sum(ldramount)*-1 netAmt,0 childAmt,0 subchildAmt from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and h.gr_type in (4,5)  and t.yrid=0 UNION ALL select "
				    	  + "@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,gp_id,if(grpLevel=1,16,if(grpLevel=2,20,19))) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,accountno,if(gp_id is  null,if(grpLevel=1,'NET ASSET',' TOTAL EQUITY'),if(den is  null,M.GP_DESC,if(groupNo is  null,M.HEAD,"
				    	  + "if(subac is  null,m.grpHead,m.account)))) DESCRIPTION, @xdramt:=if(gp_id is null,dr*if(grpLevel=1,1,-1),dr*drsign) dr, 0 mainAmt,0 agrpAmt,if(@xlevel=4,@xdramt*1,0) grpAmt,if(@xlevel=5,@xdramt*1,if(@xlevel=1,@xdramt*1,0)) netAmt,if(@xlevel=3,@xdramt*1,0) childAmt,if(@xlevel=6,@xdramt*1,0) subchildAmt from (select a.doc_no subac,m.*,sum(ldramount) dr, @xwrk:=@xwrk+(if(gp_id between "
				    	  + "12 and 14 and a.doc_no is not null,ldramount,0)) ldr,a.description account,a.account accountno,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from (select @xwrk:=0,if(g.gp_id<=15,1,if(g.gp_id<=18,2,3)) grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g "
				    	  + "where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id<=17) m,my_head a,(SELECT 139 acno,139 account,sum(ldramount) ldramount  from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no   and t.date<'"+sqlFromDate+"' and h.gr_type>=4 UNION ALL Select 140 acno,140 account,sum(ldramount) ldramount from my_jvtran t,my_head h where t.status=3 and t.acno=h.doc_no  "
				    	  + "and gr_type>=4  and t.yrid=0 and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and h.gr_type>=4 and t.trtype!=1 UNION ALL SELECT acno,h.account,sum(ldramount) ldramount from my_jvtran t,my_head h  where t.status=3 and t.acno=h.doc_no and gr_type<4 and t.date<='"+sqlToDate+"'  and !(t.dtype='YRC' and trtype=1)  group by t.acno ) t  where (m.groupNo=t.acno "
				    	  + "or left(a.alevel,m.alen+1)=m.alevel) and a.doc_no=t.acno group by  grplevel,gp_id,den,groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k,(SELECT @i:= 0) as i where (k.netamt!=0 or k.grpamt!=0 or k.childamt!=0 or k.subchildamt!=0) order by gp_id,den,groupno,ordno";
    					
    			ResultSet resultSet = BalanceSheet.executeQuery(sqlqry);
        		
//    			System.out.println("Print lvl4 sqlqry--->"+sqlqry);
        		while(resultSet.next()){
        			
        		}
             	 
             	 
             	 
                 String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
               	 imgpath=imgpath.replace("\\", "\\\\");
               	 
		         param.put("imgpath", imgpath);
		         param.put("printname", balanceSheetBean.getLblmainprintname());
		         param.put("subprintname", balanceSheetBean.getLblmainprintname1());
		         param.put("compname", balanceSheetBean.getLblcompname());
		         param.put("compaddress", balanceSheetBean.getLblcompaddress());
		         param.put("comptel", balanceSheetBean.getLblcomptel());
		         param.put("compfax", balanceSheetBean.getLblcompfax());
		         param.put("compbranch", balanceSheetBean.getLblbranch());
		         param.put("location", balanceSheetBean.getLbllocation());
		         param.put("printname", balanceSheetBean.getLblprintname()); 
		         param.put("printby", session.getAttribute("USERNAME"));
		         param.put("Fromdate", fromdate);
		         param.put("Todate", todate);
		         param.put("balancesheetqry", sqlqry);
		        
//		        System.out.println("Report File Name-->"+reportFileName);
		        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/accounts/balancesheet/balancesheetlvl4.jrxml"));
         	 
                JasperReport jasperReport = JasperCompileManager.compileReport(design);
                generateReportPDF(response, param, jasperReport, conn);
                             
          
                 } catch (Exception e) {
                     e.printStackTrace();
                 } finally{
                	 conn.close();
                 }	   	 
		}

		return "print";
	}
	
	
	////////////////////////////////////
	
	 private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException, AddressException, MessagingException {
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