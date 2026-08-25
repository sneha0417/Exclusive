package com.dashboard.procurment.stockLedger;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

public class ClsStockLedgerAction {

	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	
	private Map<String, Object> param = null;
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
        java.sql.Date sqlfromDate = null;
        java.sql.Date sqlToDate = null;
        String fromdate=request.getParameter("fromdate");
        String todate=request.getParameter("todate");
         
       /* if(!fromdate.equalsIgnoreCase("")){
        	sqlfromDate=commonDAO.changeStringtoSqlDate(fromdate);
        }
        if(!todate.equalsIgnoreCase("")){
        	sqlToDate=commonDAO.changeStringtoSqlDate(todate);
        }*/
        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
        	sqlfromDate=commonDAO.changeStringtoSqlDate(fromdate);
     		
     	}
        if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
        	sqlToDate=commonDAO.changeStringtoSqlDate(todate);
     		
     	}
        System.out.println("date==="+sqlfromDate+"::"+sqlToDate);
		try {
			conn = connDAO.getMyConnection();
			Statement stmt = conn.createStatement ();
	       
	        param = new HashMap();
	      
	        String strpendingdelivery="SELECT count(*) rowcount,M.VOC_NO,date_format(M.DATE,'%d-%m-%Y')date,M1.PART_NO,M1.PRODUCTNAME,D.QTY-D.OUT_QTY QTY FROM MY_DELM M LEFT JOIN MY_DELD D ON M.TR_NO=D.TR_NO "
                                   +" LEFT JOIN my_main M1 ON D.PSRNO=M1.PSRNO WHERE M.STATUS=3 AND D.QTY-D.OUT_QTY!=0 and "
                                   +" M.DATE BETWEEN '"+sqlfromDate+"' AND '"+sqlToDate+"'";
	        
	        System.out.println("qryyyy111"+strpendingdelivery);
	        int pendingdelivery=0;
	        ResultSet rs=stmt.executeQuery(strpendingdelivery);
	        
	        while(rs.next())
	        {
	        	pendingdelivery=rs.getInt("rowcount");
	        }
	        System.out.println("pendingdeliveryyy"+pendingdelivery);
	        String strpurchaseinvoice="select count(*)rowcountss,G.VOC_NO GRNNO,date_format(P.DATE,'%d-%m-%Y')GRNDATE,M.VOC_NO PIVNO,DATE_FORMAT(M.DATE,'%d-%m-%Y') PIVDATE,ROUND((op_qty*cost_price),2) AMOUNT from my_prddin P "
                                      +" INNER JOIN MY_GRNM G ON P.TR_NO=G.TR_NO INNER JOIN MY_SRVM M ON P.INVNO=M.DOC_NO "
                                      +" where  P.dtype in ('grn','piv' ) AND P.DATE<='"+sqlToDate+"' AND M.DATE>'"+sqlToDate+"'";
	        System.out.println("qryyyy"+strpurchaseinvoice);
	        int purchaseinvoice=0;
	        ResultSet rs1=stmt.executeQuery(strpurchaseinvoice);
	        
	        while(rs1.next())
	        {
	        	purchaseinvoice=rs1.getInt("rowcountss");
	        }
	        System.out.println("purchaseee"+purchaseinvoice);
	        String imgpathheader=request.getSession().getServletContext().getRealPath("/icons/cityheader.png");
            imgpathheader=imgpathheader.replace("\\", "\\\\");
            
            String imgpathfooter=request.getSession().getServletContext().getRealPath("/icons/cityfooter.jpg");
            imgpathfooter=imgpathfooter.replace("\\", "\\\\");
	        
            param.put("pendingdelivery", pendingdelivery);
            param.put("purchaseinvoice", purchaseinvoice);
	        param.put("imgheader", imgpathheader);
	        param.put("imgfooter", imgpathfooter);
	        param.put("fromdate", sqlfromDate);
	        param.put("todate", sqlToDate);
       	
	        
	        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/procurment/stockLedger/stockledger.jrxml"));
  	        JasperReport jasperReport = JasperCompileManager.compileReport(design);
            generateReportPDF(response, param, jasperReport, conn);
			
            
		} catch (Exception e) {
            e.printStackTrace();
            conn.close();
    	} finally{
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
			ouputStream.close();
			ouputStream.flush();

}



}

	
	
	
	
	

