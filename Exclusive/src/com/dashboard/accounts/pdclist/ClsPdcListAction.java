package com.dashboard.accounts.pdclist;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

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
public class ClsPdcListAction {
	
	
	
	private Map<String, Object> param=null;
	private String url;
	
	
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	
	public String printAction() throws ParseException, SQLException{
		
		  HttpServletRequest request=ServletActionContext.getRequest();
		  HttpServletResponse response=ServletActionContext.getResponse();
		  HttpSession session=request.getSession();
		  ClsCommon common=new ClsCommon();
		  	
		   String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate");
		   String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate");
		   String branch = request.getParameter("branchval")==null?"NA":request.getParameter("branchval");
		   String criteria = request.getParameter("criteria")==null?"0":request.getParameter("criteria");
		   String reporttype = request.getParameter("reporttype")==null?"0":request.getParameter("reporttype");
		   String code = request.getParameter("code")==null?"0":request.getParameter("code");
		   String distribution = request.getParameter("distribution")==null?"0":request.getParameter("distribution");
		   String group = request.getParameter("group")==null?"0":request.getParameter("group");
		   String accType = request.getParameter("acctype")==null?"0":request.getParameter("acctype");
		   String accId = request.getParameter("accno")==null?"0":request.getParameter("accno");
		   String unclrPosted = request.getParameter("unclrposted")==null?"0":request.getParameter("unclrposted");
		   String check = request.getParameter("check")==null?"0":request.getParameter("check");
			
		 /*System.out.println("looooooooooooooogo="+logo);*/
		 ClsPdcList DAO=new ClsPdcList();
		 ClsPdcListBean printbean= new ClsPdcListBean();
		 
		 printbean=DAO.getPrint(branch, reporttype, fromDate, toDate, criteria, code, accType, accId, unclrPosted, check);
		 
		 setUrl("pdcList.jrxml");
		 
         if(true)
				{				   
      	   ClsConnection conobj=new ClsConnection();
      	   param = new HashMap();
      	   Connection conn = null;
      	   conn = conobj.getMyConnection();	        	   
      	   String reportFileName = "PDC List";
      	   try {
      		   
      		   String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
      		   imgpath=imgpath.replace("\\", "\\\\");    
      		   param.put("imgpath", imgpath);
      		   param.put("pdcqry", printbean.getPdcqry());
      		  // System.out.println("print qry----------------"+printbean.getPdcqry());
      		   param.put("printname","PDC LIST");
	      	   param.put("fromdate",fromDate);
	      	   param.put("todate",toDate);
	      	   param.put("compname", printbean.getCompname());
	      	   param.put("compaddress", printbean.getCompadd());
	      	   param.put("comptel", printbean.getTel());
	      	   param.put("compfax", printbean.getFax());
	      	   param.put("compbranch", printbean.getBranch());
      		   
      		   //param.put("complogo", pintbean.getLblcompname());
      		   
      		   JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/accounts/pdclist/pdcList.jrxml"));	      	     	 
	           JasperReport jasperReport = JasperCompileManager.compileReport(design);
               generateReportPDF(response, param, jasperReport, conn);
      	   } catch (Exception e) {

			       e.printStackTrace();

			   }
						 
      	   finally{
      		   conn.close();
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
