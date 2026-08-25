package com.dashboard.fixedasset.fixedassetregister;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;

import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsFixedAssetRegisterAction {
	ClsConnection ClsConnection=new ClsConnection();
ClsFixedAssetRegister fixedregDAO=new ClsFixedAssetRegister();
ClsCommon ClsCommon=new ClsCommon();

private Map<String, Object> param = null;
public Map<String, Object> getParam() {
	return param;
}

public void setParam(Map<String, Object> param) {
	this.param = param;
}


	public String printAction() throws ParseException, SQLException{
		System.out.println("inside action");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		
		String fromdate=request.getParameter("fromdate");
		String todate=request.getParameter("todate");
		String branch=request.getParameter("branchval");
		String group=request.getParameter("group");
		String assetNo=request.getParameter("assetno");
		String reportType=request.getParameter("rpttype");
		
		
		java.sql.Date sqlFromDate = null;
	     java.sql.Date sqlToDate = null;
	     Connection con = null;
	     
	     con=ClsConnection.getMyConnection();
			Statement stmtBFAR = con.createStatement();
			
	     
	     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
	              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
	     }
	     
	     if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
	              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
	     }
	     String sql="";
	     String strSql="";
	     
	     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    	 sql+=" and d.brhid="+branch+"";
   	 }
	     
	     if(!((assetNo.equalsIgnoreCase("")) || (assetNo.equalsIgnoreCase("0")))){
	    	   sql=sql+"  and d.asset_no='"+assetNo+"'";
        }
        
	     if(!((group.equalsIgnoreCase("")) || (group.equalsIgnoreCase("0")))){
	    	 	sql=sql+" and d.assetgpid='"+group+"'";
        }
	     
	     if(reportType.equalsIgnoreCase("2")){
	    	 strSql+=" having round(SUM(d.asset_del),2)!=0 or round(SUM(d.depr_del),2)!=0 ";
	    	// strSql+=" having if(sum(d.asset_del)>0,round(sum(d.asset_del),2),0)!=0  or if(sum(d.depr_del)<0,round(sum(d.depr_del)*-1,2),0)!=0";
	     }else if(reportType.equalsIgnoreCase("3")){
	    	strSql+=" having round(SUM(d.asset_add),2)!=0 ";
			//strSql+=" having round(SUM(d.asset_add),2)!=0 or round(SUM(d.depr_add),2)!=0 ";
	    	// strSql+=" having if(sum(d.asset_add)>0,round(sum(d.asset_add),2),0)!=0  or if(sum(d.depr_add)<0,round(sum(d.depr_add)*-1,2),0)!=0";
	     }
	
	     sql = "SELECT m.asset_no,m.assetname,m.assetid,floor(m.age)age,round(m.deprper,2)deprper,date_format(m.purdate,'%d-%m-%Y')purdate,m.brhid,m.assetgp,m.date,m.assetgpid,\r\n" + 
		     		"format(CONVERT(if(m.asset_opn=0,'',if(m.asset_opn<0,m.asset_opn*-1,m.asset_opn)),CHAR(100)),2) assetopn,\r\n" + 
		     		"format(CONVERT(if(m.asset_add=0,'',if(m.asset_add<0,m.asset_add*-1,m.asset_add)),CHAR(100)),2) assetadd,\r\n" + 
		     		"format(CONVERT(if(m.asset_del=0,'',if(m.asset_del<0,m.asset_del*-1,m.asset_del)),CHAR(100)),2) assetdel,\r\n" + 
		     		"format(CONVERT(if(m.assettotal=0,'',if(m.assettotal<0,m.assettotal*-1,m.assettotal)),CHAR(100)),2) assettotal,\r\n" + 
		     		"format(CONVERT(if(m.depr_opn=0,'',if(m.depr_opn<0,m.depr_opn*-1,m.depr_opn)),CHAR(100)),2) depropn,\r\n" + 
		     		"format(CONVERT(if(m.depr_add=0,'',if(m.depr_add<0,m.depr_add*-1,m.depr_add)),CHAR(100)),2) depradd,\r\n" + 
		     		"format(CONVERT(if(m.depr_del=0,'',if(m.depr_del<0,m.depr_del*-1,m.depr_del)),CHAR(100)),2) deprdel,\r\n" + 
		     		"format(CONVERT(if(m.deprtotal=0,'',if(m.deprtotal<0,m.deprtotal*-1,m.deprtotal)),CHAR(100)),2) deprtotal,\r\n" + 
		     		"format(CONVERT(if(m.nettotal=0,'',if(m.nettotal<0,m.nettotal*-1,m.nettotal)),CHAR(100)),2) nettotal,\r\n" + 
		     		"format(CONVERT(if(m.prevyear=0,'',if(m.prevyear<0,m.prevyear*-1,m.prevyear)),CHAR(100)),2) prevyear," +
		     		"CONVERT(if(m.asset_opn=0,'',if(m.asset_opn<0,m.asset_opn*-1,m.asset_opn)),CHAR(100)) assetopnv, " +
                    "CONVERT(if(m.asset_add=0,'',if(m.asset_add<0,m.asset_add*-1,m.asset_add)),CHAR(100)) assetaddv, " +
                    "CONVERT(if(m.asset_del=0,'',if(m.asset_del<0,m.asset_del*-1,m.asset_del)),CHAR(100)) assetdelv, " +
                    "CONVERT(if(m.assettotal=0,'',if(m.assettotal<0,m.assettotal*-1,m.assettotal)),CHAR(100)) assettotalv, " +
                    "CONVERT(if(m.depr_opn=0,'',if(m.depr_opn<0,m.depr_opn*-1,m.depr_opn)),CHAR(100)) depropnv, " +
                    "CONVERT(if(m.depr_add=0,'',if(m.depr_add<0,m.depr_add*-1,m.depr_add)),CHAR(100)) depraddv, " +
                    "CONVERT(if(m.depr_del=0,'',if(m.depr_del<0,m.depr_del*-1,m.depr_del)),CHAR(100)) deprdelv, " +
                    "CONVERT(if(m.deprtotal=0,'',if(m.deprtotal<0,m.deprtotal*-1,m.deprtotal)),CHAR(100)) deprtotalv, " +
                    "CONVERT(if(m.nettotal=0,'',if(m.nettotal<0,m.nettotal*-1,m.nettotal)),CHAR(100)) nettotalv, " +
                    "CONVERT(if(m.prevyear=0,'',if(m.prevyear<0,m.prevyear*-1,m.prevyear)),CHAR(100)) prevyearv FROM (\r\n" + 
		     		"SELECT l.asset_no,l.assetid,l.assetname,l.assetgp,l.age,l.purdate,l.asset_opn,l.asset_add,l.asset_del,\r\n" + 
		     		"(l.asset_opn+l.asset_add+l.asset_del) assettotal,l.depr_opn,l.depr_add,l.depr_del,(l.depr_opn+l.depr_add+l.depr_del)  deprtotal,\r\n" + 
		     		"((l.asset_opn+l.asset_add+l.asset_del)+(l.depr_opn+l.depr_add+l.depr_del)) nettotal,(l.asset_opn+l.depr_opn) prevyear,\r\n" + 
		     		"l.deprper,l.brhid,l.date,l.assetgpid FROM (\r\n" + 
		     		"select d.asset_no,d.date,round(SUM(d.asset_opn),2) asset_opn,round(SUM(d.asset_add),2) asset_add,round(SUM(d.asset_del),2)\r\n" + 
		     		"asset_del,round(SUM(d.depr_opn),2) depr_opn,round(SUM(d.depr_add),2) depr_add,round(SUM(d.depr_del),2) depr_del,\r\n" + 
		     		"d.assetid,d.assetname,d.assetgp,d.purdate,((DATEDIFF('"+sqlToDate+"',d.purdate)/365)*12) age,d.deprper,d.brhid,d.assetgpid from (\r\n" + 
		     		"select a.asset_no,a.date,if(a.date<'"+sqlFromDate+"',a.dramount,0.00) asset_opn,\r\n" + 
		     		"if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' AND a.dramount>0,a.dramount,'') asset_add,\r\n" + 
		     		"if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' AND a.dramount<0,a.dramount,'') asset_del,0.00 depr_opn,\r\n" + 
		     		"0.00 depr_add,0.00 depr_del,v.assetid,v.assetname,v.purdate,v.deprper,a.brhid,g.grp_name assetgp,g.doc_no assetgpid from\r\n" + 
		     		"my_fatran a left join my_fixm v on a.asset_no=v.sr_no left join my_fagrp g on v.assetgp=g.doc_no where a.acno=v.fixastacno\r\n" + 
		     		"UNION ALL\r\n" + 
		     		"select a.asset_no,a.date,0.00 asset_opn,0.00 asset_add,0.00 asset_del,if(a.date<'"+sqlFromDate+"',a.dramount,0.00) depr_opn,\r\n" + 
		     		"if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' AND a.dramount<0,a.dramount,'') depr_add,\r\n" + 
		     		"if(a.date>='"+sqlFromDate+"' and a.date<='"+sqlToDate+"' AND a.dramount>0,a.dramount,'')  depr_del,\r\n" + 
		     		"v.assetid,v.assetname,v.purdate,v.deprper,a.brhid,g.grp_name assetgp,g.doc_no assetgpid from my_fatran a\r\n" + 
		     		"left join my_fixm v on a.asset_no=v.sr_no left join my_fagrp g on v.assetgp=g.doc_no where a.acno=v.accdepacno\r\n" + 
		     		") d\r\n" + 
		     		"left join my_fasaled sd on sd.assetid=d.asset_no left join my_fasalem sm on sm.doc_no=sd.rdocno where coalesce(sm.date,\r\n" + 
		     		"'"+sqlFromDate+"')>='"+sqlFromDate+"' and d.purdate<='"+sqlToDate+"'"+sql+" group by d.asset_no"+strSql+" ) l ) m";
		     
	     	System.out.println("print-sql:"+sql);
			ResultSet resultSet = stmtBFAR.executeQuery(sql);
			String reportFileName = "com/dashboard/fixedasset/fixedassetregister/fixedassetregister.jrxml";
	     
			if(true){
				 System.out.println("insideeeee");
				 ClsConnection conobj=new ClsConnection();
				 
	        	   param = new HashMap();
	        	   
	        	          	   
	        	   
	        	   
	        	   try{
	        		   
	        		   con = conobj.getMyConnection();	
	        		   String imgpath=request.getSession().getServletContext().getRealPath("/icons/city1header.jpg");
	        		   imgpath=imgpath.replace("\\", "\\\\");    
	        		   String imgpathfooter=request.getSession().getServletContext().getRealPath("/icons/city1footer.jpg");
	        		   imgpathfooter=imgpathfooter.replace("\\", "\\\\");    
	        		   param.put("imgheader", imgpath);
	        		   param.put("imgfooter", imgpathfooter);
	        		   param.put("sqlqry", sql);
	        		   
	        		   
	        		   JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/fixedasset/fixedassetregister/fixedassetregister.jrxml"));	      	     	 
    	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
                      generateReportPDF(response, param, jasperReport, con);
	        	   }catch (Exception e) {
				       e.printStackTrace();
				   }
	        	   finally{
	        		   con.close();
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
		
	}		
	
