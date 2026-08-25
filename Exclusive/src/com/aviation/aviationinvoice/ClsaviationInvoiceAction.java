package com.aviation.aviationinvoice;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.common.*;
import com.connection.ClsConnection;

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

public class ClsaviationInvoiceAction {
	ClsCommon ClsCommon =new ClsCommon();
	
	ClsaviationInvoiceDAO savedata=new ClsaviationInvoiceDAO();
	ClsaviationInvoiceDAO saveObj=new ClsaviationInvoiceDAO();
	ClsaviationInvoiceBean viewObj=new ClsaviationInvoiceBean();
	ClsaviationInvoiceBean avbean;
	ClsConnection ClsConnection=new ClsConnection();
   
	private String masterdate, hidmasterdate, fromdate, hidfromdate ,todate ,hidtodate, part_no, pname,puraccname,msg,mode,desc1,formdetailcode,duedate, hidduedatee,deleted;
	private int  docno,psrno,puraccid, masterdoc_no,   account, descgridlenght ;
	private double usdrate;
   
	private String date,ddate,name,address,telno,trn,invno;
	private Map<String, Object> param=null;
	public Map<String, Object> getParam() {
		return param;
	}

	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getDdate() {
		return ddate;
	}

	public void setDdate(String ddate) {
		this.ddate = ddate;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getTelno() {
		return telno;
	}

	public void setTelno(String telno) {
		this.telno = telno;
	}

	public String getTrn() {
		return trn;
	}

	public void setTrn(String trn) {
		this.trn = trn;
	}

	public String getInvno() {
		return invno;
	}

	public void setInvno(String invno) {
		this.invno = invno;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getMasterdate() {
		return masterdate;
	}

	public void setMasterdate(String masterdate) {
		this.masterdate = masterdate;
	}

	public String getHidmasterdate() {
		return hidmasterdate;
	}

	public void setHidmasterdate(String hidmasterdate) {
		this.hidmasterdate = hidmasterdate;
	}

	public String getFromdate() {
		return fromdate;
	}

	public void setFromdate(String fromdate) {
		this.fromdate = fromdate;
	}

	public String getHidfromdate() {
		return hidfromdate;
	}

	public void setHidfromdate(String hidfromdate) {
		this.hidfromdate = hidfromdate;
	}

	public String getTodate() {
		return todate;
	}

	public void setTodate(String todate) {
		this.todate = todate;
	}

	public String getHidtodate() {
		return hidtodate;
	}

	public void setHidtodate(String hidtodate) {
		this.hidtodate = hidtodate;
	}

	public String getPart_no() {
		return part_no;
	}

	public void setPart_no(String part_no) {
		this.part_no = part_no;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getPuraccname() {
		return puraccname;
	}

	public void setPuraccname(String puraccname) {
		this.puraccname = puraccname;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

 
	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getDesc1() {
		return desc1;
	}

	public void setDesc1(String desc1) {
		this.desc1 = desc1;
	}

	public String getDuedate() {
		return duedate;
	}

	public void setDuedate(String duedate) {
		this.duedate = duedate;
	}

	public String getHidduedatee() {
		return hidduedatee;
	}

	public void setHidduedatee(String hidduedatee) {
		this.hidduedatee = hidduedatee;
	}

 

	public double getUsdrate() {
		return usdrate;
	}

	public void setUsdrate(double usdrate) {
		this.usdrate = usdrate;
	}
	
	
	
	public ClsCommon getClsCommon() {
		return ClsCommon;
	}

	public void setClsCommon(ClsCommon clsCommon) {
		ClsCommon = clsCommon;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public int getPsrno() {
		return psrno;
	}

	public void setPsrno(int psrno) {
		this.psrno = psrno;
	}

	public int getPuraccid() {
		return puraccid;
	}

	public void setPuraccid(int puraccid) {
		this.puraccid = puraccid;
	}

	public int getMasterdoc_no() {
		return masterdoc_no;
	}

	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}

	public int getAccount() {
		return account;
	}

	public void setAccount(int account) {
		this.account = account;
	}

	public int getDescgridlenght() {
		return descgridlenght;
	}

	public void setDescgridlenght(int descgridlenght) {
		this.descgridlenght = descgridlenght;
	}
	
  public String savedata() throws ParseException, SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		String mode=getMode();

 

	if(mode.equalsIgnoreCase("A")){
	java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getMasterdate());
	java.sql.Date fromdate = ClsCommon.changeStringtoSqlDate(getFromdate());
	java.sql.Date todate = ClsCommon.changeStringtoSqlDate(getTodate());
	java.sql.Date duedate = ClsCommon.changeStringtoSqlDate(getDuedate());
	 
	ArrayList<String> descarray= new ArrayList<>();
	for(int i=0;i<getDescgridlenght();i++){
		
	 
		String temp2=requestParams.get("reqtest"+i)[0];
	 

		descarray.add(temp2);
		 
	}



	int val=savedata.insert(masterdate,fromdate,todate,duedate,getPsrno(),getPuraccid(),getFormdetailcode(),getDesc1(),getUsdrate(),descarray,session,request);
	int vdocno=(int) request.getAttribute("vocno");
	if(val>0)
	{
		setDocno(vdocno);
		setMasterdoc_no(val);
		setHidmasterdate(masterdate.toString());
		setHidfromdate(fromdate.toString());
		setHidtodate(todate.toString());
		setHidduedatee(duedate.toString());
		
		//
		setAccount(getAccount());
		setPart_no(getPart_no());
		setPname(getPname());
		setPuraccid(getPuraccid());
		setPuraccname(getPuraccname());
		setPsrno(getPsrno());
		
		setDesc1(getDesc1());
		setUsdrate(getUsdrate());
		
		 
		 
		
		
		 
		setMsg("Successfully Saved");
		return "success";
		
	}
	else
	{
		
		setHidmasterdate(masterdate.toString());
		setHidfromdate(fromdate.toString());
		setHidtodate(todate.toString());
		setHidduedatee(duedate.toString());
		
		setAccount(getAccount());
		setPart_no(getPart_no());
		setPname(getPname());
		setPuraccid(getPuraccid());
		setPuraccname(getPuraccname());
		setPsrno(getPsrno());
		
		setDesc1(getDesc1());
		setUsdrate(getUsdrate());
		 
		
		setMsg("Not Saved");
		return "fail";
		
	}


	}
	
	else if(mode.equalsIgnoreCase("view")){
		
	viewObj=saveObj.getViewDetails(getMasterdoc_no(),session);
		
		
	 
	 setHidmasterdate(viewObj.getHidmasterdate()); 
	 setHidfromdate(viewObj.getHidfromdate());
	 setHidtodate(viewObj.getHidtodate());
	 setHidduedatee(viewObj.getHidduedatee());
	 setAccount(viewObj.getAccount());
	 setPart_no(viewObj.getPart_no());
	 setPname(viewObj.getPname());
	 setPsrno(viewObj.getPsrno());
	 setPuraccid(viewObj.getPuraccid());
	 setPuraccname(viewObj.getPuraccname());
	 setDesc1(viewObj.getDesc1());
	setDocno(getDocno());
	setUsdrate(viewObj.getUsdrate());
  setMasterdoc_no(getMasterdoc_no());
 
		
 
				
		
         return "success";
	}
	
	else if(mode.equalsIgnoreCase("E")){
	java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getMasterdate());
	java.sql.Date fromdate = ClsCommon.changeStringtoSqlDate(getFromdate());
	java.sql.Date todate = ClsCommon.changeStringtoSqlDate(getTodate());
	java.sql.Date duedate = ClsCommon.changeStringtoSqlDate(getDuedate());
	 
	ArrayList<String> descarray= new ArrayList<>();
	for(int i=0;i<getDescgridlenght();i++){
		
	 
		String temp2=requestParams.get("reqtest"+i)[0];
	 

		descarray.add(temp2);
		 
	}



	int val=savedata.update(masterdate,fromdate,todate,duedate,getPsrno(),getPuraccid(),getFormdetailcode(),getDesc1(),getUsdrate(),descarray,session,request,getMasterdoc_no());
	 
	if(val>0)
	{
		setDocno(getDocno());
		setMasterdoc_no(getMasterdoc_no());
		setHidmasterdate(masterdate.toString());
		setHidfromdate(fromdate.toString());
		setHidtodate(todate.toString());
		setHidduedatee(duedate.toString());
		
		//
		setAccount(getAccount());
		setPart_no(getPart_no());
		setPname(getPname());
		setPuraccid(getPuraccid());
		setPuraccname(getPuraccname());
		setPsrno(getPsrno());
		
		setDesc1(getDesc1());
		setUsdrate(getUsdrate());
		
		 
		 
		setMsg("Updated Successfully");
		return "success";
		
	}
	else
	{
		
		setHidmasterdate(masterdate.toString());
		setHidfromdate(fromdate.toString());
		setHidtodate(todate.toString());
		setHidduedatee(duedate.toString());
		
		setAccount(getAccount());
		setPart_no(getPart_no());
		setPname(getPname());
		setPuraccid(getPuraccid());
		setPuraccname(getPuraccname());
		setPsrno(getPsrno());
		
		setDesc1(getDesc1());
		setUsdrate(getUsdrate());
		 
		setMsg("Not Updated");
		return "fail";
		
	}


	}
	
	
	else if(mode.equalsIgnoreCase("D")){
	 


	int val=savedata.delete(getMasterdoc_no(),session,getFormdetailcode());
	 
	if(val>0)
	{
		setDocno(getDocno());
		setMasterdoc_no(getMasterdoc_no());
		 
		//
		setAccount(getAccount());
		setPart_no(getPart_no());
		setPname(getPname());
		setPuraccid(getPuraccid());
		setPuraccname(getPuraccname());
		setPsrno(getPsrno());
		setDesc1(getDesc1());
		setUsdrate(getUsdrate());
		   setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
	}
	else
	{
		setAccount(getAccount());
		setPart_no(getPart_no());
		setPname(getPname());
		setPuraccid(getPuraccid());
		setPuraccname(getPuraccname());
		setPsrno(getPsrno());
		
		setDesc1(getDesc1());
		setUsdrate(getUsdrate());
		 
		
		 setMsg("Not Deleted");
         return "fail";
	}
	}
		return "fail";
	}
	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		int docno=Integer.parseInt(request.getParameter("docno"));
		int header=Integer.parseInt(request.getParameter("header"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		
	    HttpServletResponse response = ServletActionContext.getResponse();
			
			 param = new HashMap();
             Connection conn = null;
             
			 try {
		          
				String invoicesql1="",invoicesql="";
	             	 conn = ClsConnection.getMyConnection();
	             	Statement stmt=conn.createStatement();
	               // String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
	                
	                 invoicesql1="select concat(year(m.date),'/',m.voc_no) invno,ac.refname name,ac.address,ac.tinno trn,ac.com_mob telno,CONVERT(DATE_FORMAT(m.date , '%d-%m-%Y'),CHAR(100)) date,CONVERT(DATE_FORMAT(m.ddate , '%d-%m-%Y'),CHAR(100)) ddate from av_invm m left join my_acbook ac on ac.cldocno=m.client_id where dtype='CRM' and m.doc_no="+docno+" and branch="+branch+"";
	                 System.out.println("invoicesql1 ="+invoicesql1);
	                 ResultSet resultSet = stmt.executeQuery (invoicesql1);

	                 String date="",ddate="",name="",address="",trn="",telno="",invno="";
	                 
	            	while (resultSet.next()) {
	            		date = resultSet.getString("date");
	            		ddate = resultSet.getString("ddate");
	            		name=resultSet.getString("name");
	            		address=resultSet.getString("address");
	            		trn=resultSet.getString("trn");
	            		telno=resultSet.getString("telno");
	            		invno=resultSet.getString("invno");
	            	}
	                //imgpath=imgpath.replace("\\", "\\\\");    
		            // param.put("imghedderpath", imgpath);
		          
		            //String imgpath2=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
		        	//imgpath2=imgpath2.replace("\\", "\\\\");    
		            //param.put("imgfooterpath", imgpath2);
	            	invoicesql="select @i:=@i+1 slno,a.* from (select date_format(d.DATE,'%d-%m-%Y')dateoff,m1.voc_no docno,d.operator,dd.ac_type,dd.acraft_no,p.port,d.FLEET_NO flno,d.ltrqty qpl, d.usgqty qpg,d.sprice,d.amountusd,d.amountaed from av_invd   d left  join av_fuelm  m1 on m1.doc_no=d.doc_no left join av_fueld dd on m1.doc_no=dd.rdocno left join my_acbook aa on aa.cldocno=m1.vndid and aa.dtype='VND' left join my_port p on d.portid=p.doc_no where d.rdocno='"+docno+"' group by d.rowno) a,(SELECT @i:= 0) as i";
	            	//System.out.println("invoicesql ="+invoicesql);
	               	 param.put("header", new Integer(header));
			         //param.put("imgpath", imgpath);

			         param.put("name", name);
			         param.put("address", address);
			         param.put("telno", telno);
			         param.put("invno", invno);
			         param.put("trn", trn);
			         param.put("date", date);
		             param.put("ddate", ddate);  
		         
		             param.put("printby", session.getAttribute("USERNAME").toString());
		             param.put("invoicesql",invoicesql);
		           String imgpath=request.getSession().getServletContext().getRealPath("/icons/aviation_header.png");
			        	imgpath=imgpath.replace("\\", "\\\\");    
			            param.put("img", imgpath);
		     	   
		             //System.out.println("Path ="+ClsCommon.getPrintPath("INV"));
		                   JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(ClsCommon.getPrintPath("INV")));
	     	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
	                       generateReportPDF(response, param, jasperReport, conn);
	      
	             } catch (Exception e) {

	                 e.printStackTrace();
	             }
	            	 
	            finally{
			conn.close();
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
}
