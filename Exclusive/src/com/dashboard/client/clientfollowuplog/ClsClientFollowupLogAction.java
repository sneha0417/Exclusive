package com.dashboard.client.clientfollowuplog;

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
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsClientFollowupLogAction extends ActionSupport{

	ClsClientFollowupLogDAO clientfollowupDAO= new ClsClientFollowupLogDAO();
	ClsCommon common=new ClsCommon();
	ClsClientFollowupLogBean clientfollowupBean;
	
	//Print
	private String lblcompname;
	private String lblcompaddress;
	private String lblprintname;
	private String lblprintname1;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}

	public void setParam(Map<String, Object> param) {
		this.param = param;
	}


	private String lblname;
	public String getLblname() {
		return lblname;
	}

	public void setLblname(String lblname) {
		this.lblname = lblname;
	}

	public String getLblacno() {
		return lblacno;
	}

	public void setLblacno(String lblacno) {
		this.lblacno = lblacno;
	}

	public String getLbladdress() {
		return lbladdress;
	}

	public void setLbladdress(String lbladdress) {
		this.lbladdress = lbladdress;
	}

	public String getLblmobno() {
		return lblmobno;
	}

	public void setLblmobno(String lblmobno) {
		this.lblmobno = lblmobno;
	}

	public String getLblcodeno() {
		return lblcodeno;
	}

	public void setLblcodeno(String lblcodeno) {
		this.lblcodeno = lblcodeno;
	}

	public int getFirstarray() {
		return firstarray;
	}

	public void setFirstarray(int firstarray) {
		this.firstarray = firstarray;
	}


	private String lblacno;
	private String lbladdress;
	private String lblmobno;
	private String lblcodeno;
	
	//for hide
	private int firstarray;
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


	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		int cldocno=Integer.parseInt(request.getParameter("cldocno"));
		String fromdate=request.getParameter("fromdate");
		String todate=request.getParameter("todate");
		clientfollowupBean=clientfollowupDAO.getPrint(request,cldocno,fromdate,todate);
		setLblcompname(clientfollowupBean.getLblcompname());
		setLblcompaddress(clientfollowupBean.getLblcompaddress());
		setLblprintname(clientfollowupBean.getLblprintname());
		setLblprintname1(clientfollowupBean.getLblprintname1());
		setLblcomptel(clientfollowupBean.getLblcomptel());
		setLblcompfax(clientfollowupBean.getLblcompfax());
		setLblbranch(clientfollowupBean.getLblbranch());
		setLbllocation(clientfollowupBean.getLbllocation());
		setLblname(clientfollowupBean.getLblname());
		setLblacno(clientfollowupBean.getLblacno());
		setLbladdress(clientfollowupBean.getLbladdress());
		setLblmobno(clientfollowupBean.getLblmobno());
		setLblcodeno(clientfollowupBean.getLblcodeno());
		
		setFirstarray(clientfollowupBean.getFirstarray());
		System.out.println("---------inside Action ---------"+common.getBIBPrintPath("BCFL"));
		if(common.getBIBPrintPath("BCFL").contains(".jrxml")==true)
		{
			
		System.out.println("---------inside jrxml ---------");
			HttpServletResponse response = ServletActionContext.getResponse();
			
			//setUrl(ClsCommon.getPrintPath(dtype));
			String reportFileName = common.getBIBPrintPath("BCFL");
			System.out.println("report"+reportFileName);
			
			
			
			param = new HashMap();
			Connection conn=null;
		 
			
			 ClsConnection conobj=new ClsConnection();
			 conn = conobj.getMyConnection();
			 Statement stmtquery=conn.createStatement();
			 
			 try{
				 String sqlquery="select DATE_FORMAT(bp.date,'%d-%m-%Y') date,  bp.acno, bp.remarks comnt,DATE_FORMAT(fdate,'%d-%m-%Y')  folupdate, process,b.branchname,mu.user_name usern from gl_bcpf bp\r\n" + 
							"left join my_acbook a on a.acno=bp.acno\r\n" + 
							" left join  gl_bibp p on bp.bibpid=p.rowno\r\n" + 
							"  left join  my_brch b on b.doc_no=bp.brhid "
							+ "left join  my_user mu on mu.doc_no=bp.userid where   bp.rdocno='"+cldocno+"' ";
				
//				 String sqlquery="select DATE_FORMAT(bp.date,'%d-%m-%Y') date,  bp.acno, bp.remarks comnt,DATE_FORMAT(fdate,'%d-%m-%Y')  folupdate, process,b.branchname,mu.user_name usern from gl_bcpf bp\r\n" + 
//							"left join my_acbook a on a.acno=bp.acno\r\n" + 
//							" left join  gl_bibp p on bp.bibpid=p.rowno\r\n" + 
//							"  left join  my_brch b on b.doc_no=bp.brhid "
//							+ "left join  my_user mu on mu.doc_no=bp.userid where  bp.rdocno='"+cldocno+"' ";
//bp.date between  '"+fromdate+"' and  '"+todate+"' and
				 
				 
				 System.out.println("qeury====="+sqlquery);
				 
				
				 String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
		            imgpath=imgpath.replace("\\", "\\\\");
		            String imgpathfooter=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
		            imgpathfooter=imgpathfooter.replace("\\", "\\\\");
		            
				 param.put("name",clientfollowupBean.getLblcompname());
				 param.put("address",clientfollowupBean.getLblcompaddress());
				 param.put("codeno",clientfollowupBean.getLblcodeno());
				 param.put("acno", clientfollowupBean.getLblacno());
				 param.put("mobileno", clientfollowupBean.getLblmobno());
				 param.put("imgheader", imgpath);
				 param.put("imgfooter", imgpathfooter);
				 param.put("clientfollowuplogsql", sqlquery);
				 
				 
				 JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/client/clientfollowuplog/"+reportFileName));
		            
		          JasperReport jasperReport = JasperCompileManager.compileReport(design);
		          
		          generateReportPDF(response, param, jasperReport, conn);
		            
			 }
			 catch (Exception e) {

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

