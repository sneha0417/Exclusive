package com.dashboard.accounts.accountsstatementperiod;

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
import java.util.ArrayList;
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
import com.common.ClsEncrypt;
import com.connection.ClsConnection;
import com.mailwithpdf.EmailProcess;
import com.mailwithpdf.SendEmailAction;  
import com.opensymphony.xwork2.ActionSupport;
@SuppressWarnings("serial")

public class ClsAccountsStatementPeriodAction extends ActionSupport{
    
	ClsAccountsStatementPeriodDAO accountStatementDAO= new ClsAccountsStatementPeriodDAO();
	ClsAccountsStatementPeriodBean accountStatementBean;
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
	private String accountaddress;
	private String accountemail;
	private String accountmobile;
	private String accountphone;
	private String accountfax;
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
	public String getAccountaddress() {
		return accountaddress;
	}
	public void setAccountaddress(String accountaddress) {
		this.accountaddress = accountaddress;
	}
	public String getAccountemail() {
		return accountemail;
	}
	public void setAccountemail(String accountemail) {
		this.accountemail = accountemail;
	}
	public String getAccountmobile() {
		return accountmobile;
	}
	public void setAccountmobile(String accountmobile) {
		this.accountmobile = accountmobile;
	}
	public String getAccountphone() {
		return accountphone;
	}
	public void setAccountphone(String accountphone) {
		this.accountphone = accountphone;
	}
	public String getAccountfax() {
		return accountfax;
	}
	public void setAccountfax(String accountfax) {
		this.accountfax = accountfax;
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
	
	public void printAction(Connection conn,String branch,String fromDate,String toDate,String chckopn,String print,String acnoarray) throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();        
		HttpSession session=request.getSession();
	    HttpServletResponse response = ServletActionContext.getResponse();
	    //Connection conn = null;
	    Statement stmtas1= null;
	    ResultSet resultSet1 = null;
	    String bccemail="";  
	    java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        String printtype="A";
		try {
               
               //conn = connDAO.getMyConnection();    
               Statement stmtAccountStatement =conn.createStatement();       
                stmtas1 =conn.createStatement();
               param = new HashMap();
               
               String sqltst="select h.description name,o.email mail1,m.acno from  rl_propertryowner o left join rl_propertymaster m on o.doc_no=m.owid left join my_head h on m.acno=h.doc_no where m.acno in("+acnoarray.substring(0, acnoarray.length()-1)+")";
	       		//System.out.println("sqltst--->>>"+sqltst);
                 resultSet1 = stmtas1.executeQuery(sqltst);
	       		while(resultSet1.next()){       
	       			int acno=resultSet1.getInt("acno");
	       			String email=resultSet1.getString("mail1");  
	       			String acnames=resultSet1.getString("name");  
               String joins="";String casestatement="",sqlAccountStatementResult="0",sqlSecurityResult="0";
              /* int acno=Integer.parseInt(request.getParameter("acno"));
        	   String branch = request.getParameter("branch");
        	   String fromDate = request.getParameter("fromDate");
        	   String toDate = request.getParameter("toDate");
        	   String chckopn = request.getParameter("chckopn");
        	   String email = request.getParameter("email");
        	   String print = request.getParameter("print");*/    
        	   
               if(!(fromDate.equalsIgnoreCase("undefined")) && !(fromDate.equalsIgnoreCase("")) && !(fromDate.equalsIgnoreCase("0"))){
                   sqlFromDate = commonDAO.changeStringtoSqlDate(fromDate);
               }
               if(!(toDate.equalsIgnoreCase("undefined")) && !(toDate.equalsIgnoreCase("")) && !(toDate.equalsIgnoreCase("0"))){
                   sqlToDate = commonDAO.changeStringtoSqlDate(toDate);
               }
                 
        	   accountStatementBean=accountStatementDAO.getPrint(conn,request,acno,branch,fromDate,toDate);   
        	 
        	   String printPathSql="select CONCAT('AS',atype) dtype from my_head where doc_no="+acno+"";
        	   ResultSet resultSetPrintPath = stmtAccountStatement.executeQuery(printPathSql);
	       	   String printPathDtype="BIB",unClrChqShow="0",unClrChqShow2="0";
	       	   while(resultSetPrintPath.next()){
	       			printPathDtype=resultSetPrintPath.getString("dtype");
	       		}
	       	   
	       	   if(printPathDtype.equalsIgnoreCase("ASAR")) {
		       	   String unclrChqView="select coalesce(value,0) value from gl_bibd where dtype='ASAR'";
	     	       ResultSet resultSetUnclrChq = stmtAccountStatement.executeQuery(unclrChqView);
		       	   while(resultSetUnclrChq.next()){
		       		   unClrChqShow=resultSetUnclrChq.getString("value");
		       		}
	       	   }
	       	   
        	   String reportFileName = commonDAO.getBIBPrintPath(printPathDtype);
        	   System.out.println("printpath"+reportFileName);
        	   
               /*String reportFileName = "accountStatementTypeHeaderFooterPrint";*/
               String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
               imgpath=imgpath.replace("\\", "\\\\");
			   
			   String imgheaderpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
               imgheaderpath=imgheaderpath.replace("\\", "\\\\");    
	          
               String imgfooterpath=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
               imgfooterpath=imgfooterpath.replace("\\", "\\\\"); 
                
               String accountstatementsql = "",openingsql="";
       		
	       	   if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	       		   accountstatementsql+=" and t.brhId="+branch+"";
	       	   }
	       		
	       	   joins=commonDAO.getFinanceVocTablesJoins(conn);
	       	   casestatement=commonDAO.getFinanceVocTablesCase(conn);
	       		
	       	   if(chckopn.equalsIgnoreCase("1")){
	       		
	       		   openingsql = " union all select t.brhid,DATE_ADD('"+sqlFromDate+"',INTERVAL -1 DAY) trdate,'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,1,0 transNo,'OPN' transType from my_jvtran t "
	       				   + "where t.status=3 and ((t.trtype=1 and t.date <= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+accountstatementsql+" and t.acno= "+acno+" group by t.acno,t.curId";
	       		   
	       	   }
	       	   
				accountstatementsql = "select b.cldocno, b.refname, b.dt, b.trdate, b.transno, b.transtype, b.branch,b.branchname,b.ref_detail,b.description,b.debit,b.credit,b.nettotal,b.netdebittotal,b.netcredittotal,if(b.netamountvalue<0,CONCAT(format((b.netamountvalue*-1),2),' Cr'),"
	       			+ "CONCAT(format(b.netamountvalue,2),' Dr')) netamountvalue from (select a.cldocno, a.refname, a.dt, a.trdate, a.transno, a.transtype, a.branch,a.branchname, a.ref_detail, if(a.description='0','',a.description) description, format(a.debit,2) debit, format(a.credit,2) credit,"
	       			+ "format(round(@l:=@l+a.nettotalamount,2),2) nettotal,format(round(@j:=@j+round(a.debit,2),2),2) netdebittotal,format(round(@k:=@k+round((a.credit),2),2),2) netcredittotal,coalesce(round(@i:=@i+nettotalamount,2),0) netamountvalue from ( "
	       			+ "select a.cldocno,ac.refname,a.trdate dt,DATE_FORMAT((a.trdate),'%d-%m-%Y') trdate,"+casestatement+"a.transtype,b.branch,b.branchname,a.ref_detail,a.description,a.debit,a.credit,format(round((a.debit+(a.credit)*-1),2),2) nettotal,round((a.debit+(a.credit)*-1),2) nettotalamount  from ("
	       			+ "select h.cldocno,t.acno,t.brhid,transno,date(t.trdate) trdate,transtype,t.ref_detail,t.tr_des description,CONVERT(if(ldramount>0,round((ldramount*1),2),' '),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),' '),CHAR(50)) credit,"
	       			+ "ldramount from my_head h inner join (select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,"
	       			+ "t.dtype transType from my_jvtran t where  t.status=3 and date between '"+sqlFromDate+"' and '"+sqlToDate+"' and trtype!=1 "+accountstatementsql+" and t.acno="+acno+" and t.yrid=0"+openingsql+")t on h.doc_no=t.acno left join my_curr c on "
	       			+ "c.doc_no=t.curId order by acno,trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid left join my_acbook ac on (ac.acno=a.acno and ac.dtype='CRM')"+joins+" order by dt,TRANSNO) a,(select @i:=0) as i,(select @j:=0) as j,(select @k:=0) as k,(select @l:=0) as l) b";
				
				//System.out.println("a/c====="+accountstatementsql);
				ResultSet resultSetAccountStatement = stmtAccountStatement.executeQuery(accountstatementsql);
	       		
				String netdebittotal="0",netcredittotal="0",netamount="0";
	       		while(resultSetAccountStatement.next()){
	       			sqlAccountStatementResult="1";
	       			netdebittotal=resultSetAccountStatement.getString("netdebittotal");
	       			netcredittotal=resultSetAccountStatement.getString("netcredittotal");
	       			netamount=resultSetAccountStatement.getString("nettotal");
	       		}
				
	       		String securitysql = "";
	       		
	       		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	       			securitysql+=" and j.brhId="+branch+"";
	       		}
	       		
	       		securitysql = "select DATE_FORMAT((j.date),'%d-%m-%Y') date,j.dtype,j.doc_no,CONVERT(if(j.rtype='0','',if(rtype='RAG',concat(rtype,' - ',r.voc_no),concat(rtype,' - ',l.voc_no))),CHAR(50)) aggvocno,"  
	       			 + "j.description,CONVERT(if(secamount1<0,round(secamount1*-1,2),0),CHAR(100)) securityamount,coalesce(round(@i:=@i+secamount1,2),0) netsecurityamount,b.branchname from  ( "  
	       			 + "select sum(secamount) secamount1,a.* from ( select date,dtype,doc_no,sum(dramount) as secamount,rdocno,rtype,brhid,description  from my_jvtran where acno=(select t.doc_no from my_account ac "
	       			 + "inner join my_head t on ac.acno=t.doc_no where ac.codeno='RSECURITY') and status=3 and rdocno is not null group by rdocno,rtype) a group by rdocno,rtype) j left join gl_ragmt r on j.rdocno=r.doc_no "
	       			 + "and j.rtype='RAG' left join gl_lagmt l on j.rdocno=l.doc_no and j.rtype='LAG' left join my_acbook c on (c.doc_no=r.cldocno or c.doc_no=l.cldocno) and c.dtype='CRM' left join my_brch b on b.doc_no=j.brhid,(select @i:=0) as i "  
	       			 + "where secamount!=0 and j.date<='"+sqlToDate+"' and c.acno="+acno+""+securitysql+" order by rdocno,rtype";  
	       		 // j.date>='"+sqlFromDate+"'  and 
	       		
	       		//System.out.println("==== securitysql == "+securitysql);
	       	   ResultSet resultSetSecurity = stmtAccountStatement.executeQuery(securitysql);
	       	   Double netsecurityamount=0.00;
	       	   while(resultSetSecurity.next()){
	       		    sqlSecurityResult="1";
	       			netsecurityamount=netsecurityamount+resultSetSecurity.getDouble("securityamount");
	       	   }
	       	   
	       	   netsecurityamount = commonDAO.Round(netsecurityamount, 2);
	       	
	       	   String unclearedreceiptssql = "",sqlUnclrAccountStatementResult="0";
	       	   Double netunclrdebittotal=0.00;Double netunclrcredittotal=0.00;Double netunclramount=0.00;
	       	   
	       	   if(unClrChqShow.equalsIgnoreCase("1.00000")){
		       		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		       			unclearedreceiptssql+=" and m.brhId="+branch+"";
		       		}
		       		unclearedreceiptssql="select a.*,coalesce(round(@i:=@i+amount,2),0) netamountvalue from (SELECT m.doc_no,DATE_FORMAT((m.date),'%d-%m-%Y') date,"
		       				+ " m.dtype,m.chqno,DATE_FORMAT((m.chqdt),'%d-%m-%Y') chqdt,m.chqname,CONVERT(if(d.amount>0,round((d.amount*1),2),null),CHAR(100)) debit,"  
		       		   		+ " CONVERT(if(d.amount<0,round((d.amount*-1),2),' '),CHAR(100)) credit,d.amount FROM my_unclrchqreceiptm m "
		       		   		+ " left join my_unclrchqreceiptd d on (m.doc_no=d.rdocno and m.brhid=d.brhid) where m.status=3 and m.bpvno=0 and m.chqdt>='"+sqlFromDate+"'  and m.chqdt<='"+sqlToDate+"' and d.acno="+acno+""+unclearedreceiptssql+") a,"
		       				+ "(select @i:=0) as i";
		       		System.out.println("==unclearedreceiptssql=="+unclearedreceiptssql);
		       		ResultSet resultSetUnclearAccountStatement = stmtAccountStatement.executeQuery(unclearedreceiptssql);
		       		
		       		while(resultSetUnclearAccountStatement.next()){
		       			sqlUnclrAccountStatementResult="1";
		       			netunclrdebittotal=netunclrdebittotal+resultSetUnclearAccountStatement.getDouble("debit");
		       			netunclrcredittotal=netunclrcredittotal+resultSetUnclearAccountStatement.getDouble("credit");
		       		}
		       		
		       		netunclramount=netunclrdebittotal-netunclrcredittotal;
		       		
		       		netunclrdebittotal = commonDAO.Round(netunclrdebittotal, 2);
		       		netunclrcredittotal = commonDAO.Round(netunclrcredittotal, 2);
		       		netunclramount = commonDAO.Round(netunclramount, 2);
	       	   }
	       	if(unClrChqShow2.equalsIgnoreCase("2.00000") || unClrChqShow.equalsIgnoreCase("2.00000")){
//	       		System.out.println("====aaaa=="+unClrChqShow2);
	       		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	       			unclearedreceiptssql+=" and m.brhId="+branch+"";
	       		}
       		
	       		unclearedreceiptssql="select a.*,coalesce(round(@i:=@i+amount,2),0) netamountvalue from (SELECT m.doc_no,DATE_FORMAT((m.date),'%d-%m-%Y') date,"
	       			+ " m.dtype,m.chqno,DATE_FORMAT((m.chqdt),'%d-%m-%Y') chqdt,m.chqname,CONVERT(if(d.amount>0,round((d.amount*1),2),null),CHAR(100)) debit,"
	       			+" CONVERT(if(d.amount<0,round((d.amount*-1),2),0.00),CHAR(100)) credit,d.amount FROM my_chqbm m "
					+" left join my_chqbd d on (m.tr_no=d.tr_no and m.brhid=d.brhid) left join my_chqdet d1 on m.tr_no=d1.tr_no "
					+" where m.status=3 and d1.pdc=1 and d1.status='E' and m.date<='"+sqlToDate+"' and d.acno = "+acno+" "+unclearedreceiptssql+" ) a, (select @i:=0) as i order by date ";
//	       		System.out.println("===sqllaaa=="+unclearedreceiptssql);
	       		ResultSet resultSetUnclearAccountStatement = stmtAccountStatement.executeQuery(unclearedreceiptssql);
	       		
	       		while(resultSetUnclearAccountStatement.next()){
	       			sqlUnclrAccountStatementResult="1";
	       			netunclrdebittotal=netunclrdebittotal+resultSetUnclearAccountStatement.getDouble("debit");
	       			netunclrcredittotal=netunclrcredittotal+resultSetUnclearAccountStatement.getDouble("credit");
	       		}
	       		
	       		netunclramount=netunclrdebittotal-netunclrcredittotal;

	       		netunclrdebittotal = commonDAO.Round(netunclrdebittotal, 2);
	       		netunclrcredittotal = commonDAO.Round(netunclrcredittotal, 2);
	       		netunclramount = commonDAO.Round(netunclramount, 2);
	       	}
	       	
	       	  String detailsql="";
	       	  		
	           param.put("imgpath", imgpath);
			   param.put("imgheaderpath", imgheaderpath);
	           param.put("imgfooterpath", imgfooterpath);
	           param.put("compname", accountStatementBean.getLblcompname());
	           param.put("compaddress", accountStatementBean.getLblcompaddress());
	           param.put("comptel", accountStatementBean.getLblcomptel());
	           param.put("compfax", accountStatementBean.getLblcompfax());
	           param.put("compbranch", accountStatementBean.getLblbranch());
	           param.put("location", accountStatementBean.getLbllocation());
	           param.put("printname", accountStatementBean.getLblprintname());
	           param.put("subprintname", accountStatementBean.getLblprintname1());
	           param.put("account", accountStatementBean.getAccountno()+" - "+accountStatementBean.getAccountname());
	           param.put("customeraddress", accountStatementBean.getAccountaddress());
	           param.put("customeremail", accountStatementBean.getAccountemail());
	           param.put("customermobile", accountStatementBean.getAccountmobile());
	           param.put("customerphone", accountStatementBean.getAccountphone());
	           param.put("customerfax", accountStatementBean.getAccountfax());
	           param.put("creditperiod", accountStatementBean.getCreditperiodmin()+" (Days)");
		       param.put("creditlimit", accountStatementBean.getCreditlimit());
		       param.put("accountstatementsql", accountstatementsql);
		       param.put("accountstatementcheck", sqlAccountStatementResult);
		       param.put("securitysql", securitysql);
		       param.put("securitycheck", sqlSecurityResult);
		       
		       param.put("unclearedreceiptssql", unclearedreceiptssql);
		       param.put("unclearedreceiptscheck", sqlUnclrAccountStatementResult);
		       
		       param.put("debittotal", netdebittotal);
		       param.put("credittotal", netcredittotal);
		       param.put("nettotal", netamount);
		       param.put("netsecurityamount", String.valueOf(netsecurityamount));
		      
		       param.put("unclrdebittotal", String.valueOf(netunclrdebittotal));
		       param.put("unclrcredittotal", String.valueOf(netunclrcredittotal));
		       param.put("unclrnettotal", String.valueOf(netunclramount));
		       
		       param.put("printby", session.getAttribute("USERNAME"));
		      
		           JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(reportFileName));
		           JasperReport jasperReport = JasperCompileManager.compileReport(design);
		           //generateReportEmail(param, jasperReport, conn, email, bccemail, bccemail, print, session, docno, acnames, fromDate, toDate, printtype);    
		           printAction2(param, jasperReport, conn, branch, fromDate, toDate, chckopn, print, acno, email, acnames,printtype);   
		           email="";
		           acnames="";
		      }
             } catch (Exception e) {
                 e.printStackTrace();
                 conn.close();
         	} finally{
         		param=null;
         		System.out.println("IN FINALLY");
         		resultSet1.close(); 
         		stmtas1.close();    
         		//conn.close();    
         	}
      	
	 }
	public void printAction2(Map parameters1, JasperReport jasperReport1, Connection conn,String branch,String fromDate,String toDate,String chckopn,String print,int acno,String email,String acnames,String printtype1) throws ParseException, SQLException{   
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpSession session=request.getSession();
	    //Connection conn = null;
        java.sql.Date sqlUpToDate = null;
        String printtype="O";
		try {
			//conn = connDAO.getMyConnection();
	        Statement stmtAgeingStatement =conn.createStatement();
	        Statement stmtas =conn.createStatement();
	        param = new HashMap();
	        String sqld="",sqld1="",select="",joins="",casestatement="",sqlUnapplyResult="0";
	        String bccemail="";  
			String atype = "AP";
			int level1from=0;
			int level1to=30;
			int level2from=31;
			int level2to=60;
			int level3from=61;
			int level3to=90;
			int level4from=91;
			int level4to=120;
			int level5from=121;
			String uptoDate = toDate;   
      	   
			if(!(uptoDate.equalsIgnoreCase("undefined")) && !(uptoDate.equalsIgnoreCase("")) && !(uptoDate.equalsIgnoreCase("0"))){
				sqlUpToDate = commonDAO.changeStringtoSqlDate(uptoDate);
            }      
			accountStatementBean=accountStatementDAO.getPrint(conn,request,atype,acno,branch,uptoDate,level1from,level1to,level2from,level2to,level3from,level3to,level4from,level4to,level5from);
			
			String reportFileName = commonDAO.getBIBPrintPath("BAGS");   
			
			
			//System.out.println("===========reportFileName======="+reportFileName);
			
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
    			accountStatementBean.setLblsumnetamount(resultSetTotal.getString("totalunappliedamount"));
    			accountStatementBean.setLblsumapplied(resultSetTotal.getString("totalapplied"));
    			accountStatementBean.setLblsumbalance(resultSetTotal.getString("unappliedbalance"));
    			
    			accountStatementBean.setLblsumoutnetamount(resultSetTotal.getString("totaloutamount"));
    			accountStatementBean.setLblsumoutapplied(resultSetTotal.getString("totaloutapplied"));
    			accountStatementBean.setLblsumoutbalance(resultSetTotal.getString("outstandingbalance"));
    			
    			accountStatementBean.setLblnetamount(resultSetTotal.getString("nettotal"));
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
            param.put("compname", accountStatementBean.getLblcompname());
            param.put("compaddress", accountStatementBean.getLblcompaddress());
            param.put("comptel", accountStatementBean.getLblcomptel());
            param.put("compfax", accountStatementBean.getLblcompfax());
            param.put("compbranch", accountStatementBean.getLblbranch());
            param.put("location", accountStatementBean.getLbllocation());
            param.put("printname", accountStatementBean.getLblprintname());
            param.put("subprintname", accountStatementBean.getLblprintname1());
            
            if(reportFileName.contains("ageingStatementAlfahimPrint.jrxml")){
            	param.put("account", accountStatementBean.getLblaccountno()+" - "+accountStatementBean.getLblaccountname());
            } else {
            	param.put("account", accountStatementBean.getLblaccountname()+" - "+accountStatementBean.getLblaccountaddress()+" - "+accountStatementBean.getLblaccountmobileno());            	
            }
            param.put("customeraddress", accountStatementBean.getLblaccountaddress());
            param.put("customeremail", accountStatementBean.getLblaccountemail());
            param.put("customermobile", accountStatementBean.getLblaccountmobileno());
            param.put("customerphone", accountStatementBean.getLblaccountphone());
            param.put("customerfax", accountStatementBean.getLblaccountfax());
            param.put("creditperiod", accountStatementBean.getLblcreditperiodmin()+" (Days)");
	        param.put("creditlimit", accountStatementBean.getLblcreditlimit());
	        
	        param.put("currency", accountStatementBean.getLblcurrencycode());
	        param.put("ageingstatementunapplysql", sqlUnapply);
	        param.put("unappliedtotalamount", accountStatementBean.getLblsumnetamount());
	        param.put("unappliedtotalapplied", accountStatementBean.getLblsumapplied());
	        param.put("unappliedtotalbalance", accountStatementBean.getLblsumbalance());
	        param.put("ageingstatementoutstandingsql", sqlOutStanding);
	        param.put("outstandingtotalamount", accountStatementBean.getLblsumoutnetamount());    
	        param.put("outstandingtotalapplied", accountStatementBean.getLblsumoutapplied());
	        param.put("outstandingtotalbalance", accountStatementBean.getLblsumoutbalance());
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
	        param.put("nettotalamount", accountStatementBean.getLblnetamount());      
	        param.put("printby", session.getAttribute("USERNAME"));
	        param.put("debit", netunclrdebittotalnew);
	        param.put("credit", netunclrcredittotalnew);
	        param.put("nettotal", netunclramountnew);
	        
	        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(reportFileName));
  	        JasperReport jasperReport = JasperCompileManager.compileReport(design);
  	        generateReportEmail(param, jasperReport, conn,parameters1, jasperReport1, email, bccemail, bccemail, print, session, docno, acnames, fromDate, toDate, printtype,printtype1);    
            stmtAgeingStatement.close();
            
		} catch (Exception e) {
            e.printStackTrace();
            conn.close();
    	} finally{
    		//conn.close();
    	}
	}
	private void generateReportEmail(Map parameters, JasperReport jasperReport, Connection conn,Map parameters1, JasperReport jasperReport1, String remail, String ccemail,String bccemail, String print,HttpSession session,String docno,String acnames,String fromdate,String todate,String printtype,String printtype1)throws JRException, NamingException, SQLException, IOException, AddressException, MessagingException {
		System.out.println("generateReportEmail");
		byte[] bytes = null;
	    bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
	    byte[] bytes1 = null;
	    bytes1 = JasperRunManager.runReportToPdf(jasperReport1,parameters1,conn);     
	    EmailProcess ep=new EmailProcess();   
		Statement stmtrr=conn.createStatement();   
		  
		String fileName="",path="", formcode="ASP",filepath="",fnames="",fileName1="",filepath1=""; 
		String host="", port="", userName="", password="", recipient="",subject="", message="",docnos="1";
		String strSql1 = "select imgPath from my_comp";

		ResultSet rs1 = stmtrr.executeQuery(strSql1);
		while(rs1.next ()) {
			path=rs1.getString("imgPath");
		}
		subject="E-Statement "+acnames+" period "+fromdate+" - "+todate;
		message="Dear "+acnames+", your detailed account statement is attached hereto for your reference.";

		String strSql3 = "select email,mailpass,smtpserver,smtphostport from my_user where doc_no='"+session.getAttribute("USERID").toString()+"'";    
		//System.out.println("sql--->>>"+strSql3);   
		ResultSet rs3 = stmtrr.executeQuery(strSql3);
		while(rs3.next ()) {   
			userName=rs3.getString("email");    
			port=rs3.getString("smtphostport");
			host=rs3.getString("smtpserver");
			password=ClsEncrypt.getInstance().decrypt(rs3.getString("mailpass"));
		}
			  
		DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
		java.util.Date date = new java.util.Date();
		String currdate=dateFormat.format(date);
        
		fileName1 = "AccountStatement"+currdate+".pdf";   
		filepath1=path+ "/Attachment/"+formcode+"/"+fileName1;

		File dir1 = new File(path+ "/attachment/"+formcode); 
		dir1.mkdirs();
		    
		FileOutputStream fos1 = new FileOutputStream(filepath1);
	    fos1.write(bytes1);
	    fos1.flush();
	    fos1.close();
	
   	    File saveFile1=new File(filepath1);
   	    
   	    fileName = "OutstandingStatement"+currdate+".pdf";   
		filepath=path+ "/Attachment/"+formcode+"/"+fileName;

		File dir = new File(path+ "/attachment/"+formcode); 
		dir.mkdirs();
		    
		FileOutputStream fos = new FileOutputStream(filepath);
	    fos.write(bytes);
	    fos.flush();
	    fos.close();
	
	    File saveFile=new File(filepath);   
		SendEmailAction sendmail= new SendEmailAction();   
		//String[] remails=remail.split(",");      
		   
			try {               
				//ep.sendEmailwithpdfBCCMultiple(host, port, userName, password,remail, ccemail,bccemail,subject, message, saveFile, saveFile1,docnos);
				//ep.sendEmailwithMultiplepdfNoAuth(host, port, userName, remail, subject, message, saveFile, saveFile1,docnos);   
				ep.sendEmailwithMultiplepdfBCC(host, port, userName, password,remail, ccemail,bccemail,subject, message, saveFile, saveFile1, docnos);
			} catch (javax.mail.MessagingException e) {              
				// TODO Auto-generated catch block
				conn.close();
				e.printStackTrace();      
			} finally{
				System.out.println("IN FINALLY 2");
				//conn.close();       
         	}   
       
}
}