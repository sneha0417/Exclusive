package com.dashboard.accounts.profitloss;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
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
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.JRXlsExporterParameter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimpleXlsReportConfiguration;
import net.sf.jasperreports.engine.JRExporterParameter;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;
@SuppressWarnings("serial")

public class ClsProfitLossAction extends ActionSupport{
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
    
	ClsProfitLoss profitlossDAO= new ClsProfitLoss();
	ClsProfitLossBean profitlossBean;
	
	//Print
	private String lblcompname;
	private String lblcompaddress;
	private String lblprintname;
	private String lblsubprintname;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	
	private Map<String, Object> param=null;
	
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
	public String getLblsubprintname() {
		return lblsubprintname;
	}
	public void setLblsubprintname(String lblsubprintname) {
		this.lblsubprintname = lblsubprintname;
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
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	
	public String printAction() throws ParseException, SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
				
		String branchval = request.getParameter("branchval");
		String fromdate = request.getParameter("fromdate");
		String todate = request.getParameter("todate");
		
		 java.sql.Date sqlFromDate = null;
	     java.sql.Date sqlToDate = null;
		
	     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
                sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
            }
            if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
                sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
            }
		
		profitlossBean=profitlossDAO.getPrint(request,branchval,fromdate,todate);
		setLblcompname(profitlossBean.getLblcompname());
		setLblcompaddress(profitlossBean.getLblcompaddress());
		setLblprintname(profitlossBean.getLblprintname());
		setLblcomptel(profitlossBean.getLblcomptel());
		setLblcompfax(profitlossBean.getLblcompfax());
		setLblbranch(profitlossBean.getLblbranch());
		setLbllocation(profitlossBean.getLbllocation());
		
		if(ClsCommon.getBIBPrintPath("BPL").contains(".jrxml")==true)
		{
			HttpServletResponse response = ServletActionContext.getResponse();
			
			 Connection conn = null;
			
			 try {
				 param = new HashMap();
			
		      	 conn = ClsConnection.getMyConnection();
             	 String reportFileName = ClsCommon.getBIBPrintPath("BPL");
             	 Statement profitloss =conn.createStatement();
             	 String xlstat=request.getParameter("xlstat")==null?"0":request.getParameter("xlstat").toString();
                 
             	 String Sql=" select gp_desc,head,grphead,account,subchildamt,gp_id,den,groupno,ordno from(select gp_desc,head,grphead,account,subchildamt,gp_id,den,groupno,ordno  from "
             			     +" (select gp_desc,head,grphead,account,CONVERT(if(k.subchildamt=0,'',round(k.subchildamt,2)),CHAR(100)) subchildamt,gp_id,den,groupno,ordno "
             				 +"	from ( select @xlevel:=if(grpLevel is null,0, "
             				 +" if(gp_id is null,1,if(den is null,5,if(groupNo is null,3,if(subac is null,4,6))))) ordno,m.head,m.grphead,m.account,m.gp_desc, "
             				 +"	if(gp_id is not null,gp_id,24) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,if(gp_id is null, " 
             				+"	' NET PROFIT / (LOSS) ',if(den is null,M.GP_DESC,if(groupNo is null,M.HEAD,if(subac is null,m.grpHead,m.account)))) DESCRIPTION, "
             				+"	 @xdramt:=if(gp_id is null,dr*if(grpLevel=1,-1,1),dr*drsign) dr,if(subac is null and groupno is not null,dr,0) mainAmt, " 
             				+"   if(den is not null and groupno is null,dr,0) agrpAmt,if(@xlevel=4,@xdramt,0) grpAmt,if(@xlevel=5,@xdramt,0) netAmt, "
             				+"	 if(@xlevel=3,@xdramt*1,0) childAmt,if(@xlevel=6,@xdramt*1,0) subchildAmt "
             				+"	 from (select a.doc_no subac,m.*,sum(ldramount) dr, "
             				+"	 a.description account,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from (select 1 grplevel,g.gp_id, "
             				+"	 h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,length(h.alevel) alen,g.id drsign "
             				+"	 from my_head h,my_agrp p,gc_agrpd g where grpno=0 and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id>18) m,my_head a, "
             				+"	 (Select acno,sum(ldramount) ldramount from my_jvtran t,my_head h where t.status=3 and t.yrid=0 and t.acno=h.doc_no "
             				+"	 and gr_type>=4 and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and h.gr_type>=4 group by t.acno ) t "
             				+"	 where (m.groupNo=t.acno or left(a.alevel,m.alen+1)=m.alevel) and a.doc_no=t.acno group by grplevel,gp_id,den,groupNo,subac) m, "
             				+"	 (SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k,(SELECT @i:= 0) as i "
             				+"	 where (k.netamt!=0 or k.grpamt!=0 or k.childamt!=0 or k.subchildamt!=0) order by gp_id,den,groupno,ordno) z "
             				+"	union all select  '' gp_desc,'' head,'' grphead,'NET PROFIT/LOSS' account,round(sum(ldramount)*-1,2) as subchildamt,'30' gp_id ,0 den,0 groupno,0 ordno from (Select sum(ldramount) ldramount  "
             				+"	from my_jvtran t,my_head h where t.status=3 and t.yrid=0 and t.acno=h.doc_no "
             				+"	and gr_type>=4 and    t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and h.gr_type>=4 group by t.acno) a "
             				+"	union all select '' gp_desc,'' head,'' grphead,'GROSS PROFIT' account,sum(if(ex.gp_id=20,netamt*-1,netamt)) subchildamt ,20 gp_id,120 den,5080 groupno,ordno from ( "
             				+"	select den,@i:=@i+1 id,k.description,CONVERT(if(k.grpamt=0,'',round(k.grpamt,2)),CHAR(100)) grpamt,CONVERT(if(k.netamt=0,'',round(k.netamt,2)),CHAR(100)) netamt,CONVERT(if(k.childamt=0,'',round(k.childamt,2)),CHAR(100)) childamt,CONVERT(if(k.subchildamt=0,'',round(k.subchildamt,2)),CHAR(100)) subchildamt,k.gp_id,k.gtype,k.ordno,(case when k.ordno=5 then 'null' else k.ordno end ) parentid,k.groupno,k.subac from ( "
             				+"	select gtype, 0 ORDNO,gp_id,0 den,0 groupNo,0 subac,gp_desc description,0 dr, 0 mainamt,0 agrpAmt,0 grpAmt,0 netAmt,0 childAmt,0 subchildAmt from gc_agrpd where gtype in('D') and gp_id>18 "
             				+"	union all select m.gtype,@xlevel:=if(grpLevel is  null,0,if(gp_id is  null,1,if(den is  null,5,if(groupNo is  null,3,if(subac is  null,4,6))))) ordno,if(gp_id is  not null,gp_id,24) gp_id,ifnull(den,0) den,ifnull(groupNo,0) groupNo,ifnull(subac,0) subac,if(gp_id is  null,' NET PROFIT / (LOSS) ',if(den is  null,M.GP_DESC,if(groupNo is null,M.HEAD,if(subac is  null,m.grpHead,m.account)))) DESCRIPTION, @xdramt:=if(gp_id is  null,dr*if(grpLevel=1,-1,1),dr*drsign) dr,if(subac is  null and groupno is not null,dr,0) mainAmt,if(den is  not null and groupno is  null,dr,0) agrpAmt,if(@xlevel=4,@xdramt,0) grpAmt,if(@xlevel=5,@xdramt,0) netAmt,if(@xlevel=3,@xdramt*1,0) childAmt,if(@xlevel=6,@xdramt*1,0) subchildAmt from ( "
             				+"	select a.doc_no subac,m.*,sum(ldramount) dr, a.description account,a.alevel sublevel,left(a.alevel,length(m.alevel)),concat(m.alevel,'.') from ( "
             				+"	select g.gtype,1 grplevel,g.gp_id,h.den,h.doc_no groupNo, g.gp_desc,p.head,h.description grpHead,concat(h.alevel,'.') alevel,length(h.alevel)  alen,g.id drsign from my_head h,my_agrp p,gc_agrpd g where grpno=0  and h.den=p.fi_id and p.gp_pr=g.gp_id and g.gtype='D' and gp_id>18) m,my_head a,(Select acno,sum(ldramount) ldramount from my_jvtran t,my_head h where t.status=3 and t.yrid=0 and t.acno=h.doc_no  and gr_type>=4 and t.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and h.gr_type>=4  group by t.acno ) t where (m.groupNo=t.acno or left(a.alevel,m.alen+1)=m.alevel) and a.doc_no=t.acno group by  grplevel,gp_id,den,groupNo,subac with rollup) m,(SELECT @i:= 0) as i where grplevel is not null order by gp_id,den,ordno) k,(SELECT @i:= 0) as i where (k.netamt!=0 or k.grpamt!=0 or k.childamt!=0 or k.subchildamt!=0) order by gp_id,den,groupno,ordno) ex "
             				+"	where ex.gp_id in (19,20) and ex.gtype='D' and netamt!=0)xx order by gp_id,den,groupno,ordno ";
             	 
             	 
             	 
             	 
             	ResultSet resultSet = profitloss.executeQuery(Sql);
             	System.out.println("queryyyyyyy========"+Sql);
             	 
             	 String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
               	 imgpath=imgpath.replace("\\", "\\\\");
               	 
		         param.put("imgpath", imgpath);
		         param.put("printname", profitlossBean.getLblprintname());
		         param.put("subprintname", profitlossBean.getLblsubprintname());
		         param.put("compname", profitlossBean.getLblcompname());
		         param.put("compaddress", profitlossBean.getLblcompaddress());
		         param.put("comptel", profitlossBean.getLblcomptel());
		         param.put("compfax", profitlossBean.getLblcompfax());
		         param.put("compbranch", profitlossBean.getLblbranch());
		         param.put("location", profitlossBean.getLbllocation());
		         param.put("printname", profitlossBean.getLblprintname()); 
		         param.put("printby", session.getAttribute("USERNAME"));
		        param.put("profitlossqry", Sql);
		        System.out.println("xlstatus===="+xlstat);
		        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(reportFileName));
         	 
                JasperReport jasperReport = JasperCompileManager.compileReport(design);
              //generateReportPDF(response, param, jasperReport, conn);

	     	   	 if(xlstat.equalsIgnoreCase("1"))
	     	   	 { 
	     	    //System.out.println("Creating JasperPrint Object For Excel");
	     	    JasperPrint jasperPrint = JasperFillManager.fillReport (jasperReport,param,conn); 
	     	    byte bytes[] = new byte[20000]; 
	     	    //String result = JasperRunManager.runReportToHtmlFile("./usertemplates/test.jasper" , parameters, conn); 
	     		
	     		JRXlsExporter exporter = new JRXlsExporter(); 
	     	    ByteArrayOutputStream xlsReport = new ByteArrayOutputStream(); 
	     	    
	     	    
	     	    exporter.setParameter(JRXlsExporterParameter.JASPER_PRINT, jasperPrint);
	     	    exporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND,Boolean.TRUE);
	     	    exporter.setParameter(JRXlsExporterParameter.IS_DETECT_CELL_TYPE, Boolean.TRUE); 
	     	    exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,Boolean.TRUE);
	     	    exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS,Boolean.TRUE);
	     	    exporter.setParameter(JRXlsExporterParameter.IS_COLLAPSE_ROW_SPAN,Boolean.TRUE);
	     	    exporter.setParameter(JRXlsExporterParameter.IGNORE_PAGE_MARGINS,Boolean.TRUE);
	     	    exporter.setParameter(JRXlsExporterParameter.OUTPUT_STREAM, xlsReport); 
	     	    exporter.setParameter(JRXlsExporterParameter.MAXIMUM_ROWS_PER_SHEET,30000);
	     	    exporter.setParameter(JRXlsExporterParameter.IS_IMAGE_BORDER_FIX_ENABLED, Boolean.TRUE);
	     	    exporter.setParameter(JRXlsExporterParameter.IS_IGNORE_GRAPHICS, Boolean.FALSE);
	     	    exporter.exportReport(); 
	     	   
	     	   
	     	    String fileName = "InvoiceReport.xls";
	     	    response.setHeader("Content-Disposition", "inline; filename="+ fileName);
	     	    response.setContentType("application/vnd.ms-excel"); 
	     	    //System.out.println("After JasperPrint = 1"); 
	     	    response.setContentLength(xlsReport.size()); 
	     	    //System.out.println("After JasperPrint = 2"); 
	     	    xlsReport.close(); 
	     	    //System.out.println("After JasperPrint = 3"); 
              OutputStream outputStream = response.getOutputStream(); 
	     	    //System.out.println("After JasperPrint = 4"); 
	     	    xlsReport.writeTo(outputStream); 
	     	    outputStream.flush(); 
	     	    //outputStream.close(); 
	     	    //System.out.println("export end");
	     	   	 }
	     	   else
	   {
	     	    generateReportPDF(response, param, jasperReport, conn);
		}           
         
                } catch (Exception e) {
                    e.printStackTrace();
                } finally{
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