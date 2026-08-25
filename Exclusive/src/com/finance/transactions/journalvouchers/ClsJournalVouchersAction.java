package com.finance.transactions.journalvouchers;

import java.io.IOException;
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
import com.opensymphony.xwork2.ActionSupport;

import java.sql.Connection;
import java.sql.Statement;

@SuppressWarnings("serial")
public class ClsJournalVouchersAction extends ActionSupport{

	ClsConnection connDAO = new ClsConnection();

	ClsCommon commonDAO= new ClsCommon();
	ClsJournalVouchersDAO journalVouchersDAO= new ClsJournalVouchersDAO();
	ClsJournalVouchersBean journalVouchersBean;

	private int txtjournalvouchersdocno;
	private String formdetailcode;
	private String brchName;
	private String mode;
	private String deleted;
	private String msg;
	private String jqxJournalVouchersDate;
	private String hidjqxJournalVouchersDate;
	private String txtrefno;
	private String txtdescription;
	private Double txtdrtotal;
	private Double txtcrtotal;
	private int txttrno;
	private String lblformposted;
	
	private String maindate;
	private String hidmaindate;
	
	private String url;
	
	//Journal Vouchers Grid
	private int gridlength;
	
	//Print
	private String lblcompname;
	private String lblcompaddress;
	private String lblpobox;
	private String lblprintname;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	private String lblservicetax;
	private String lblpan;
	private String lblcstno;
	
	private String lbldate;
	private String lblvoucherno;
	private String lblrefno;
	private String lblnetamount;
	private String lblnetamountwords;
	private String lbldescription;
	private String lbldebittotal;
	private String lblcredittotal;
	private String lblpreparedby;
	private String lblpreparedon;
	private String lblpreparedat;

	//for hide
	private int firstarray;
	private int txtheader;
	
private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	
	public int getTxtjournalvouchersdocno() {
		return txtjournalvouchersdocno;
	}
	public void setTxtjournalvouchersdocno(int txtjournalvouchersdocno) {
		this.txtjournalvouchersdocno = txtjournalvouchersdocno;
	}
	public String getFormdetailcode() {
		 return formdetailcode;
    }
	public void setFormdetailcode(String formdetailcode) {
	     this.formdetailcode = formdetailcode;
	}
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getJqxJournalVouchersDate() {
		return jqxJournalVouchersDate;
	}
	public void setJqxJournalVouchersDate(String jqxJournalVouchersDate) {
		this.jqxJournalVouchersDate = jqxJournalVouchersDate;
	}
	public String getHidjqxJournalVouchersDate() {
		return hidjqxJournalVouchersDate;
	}
	public void setHidjqxJournalVouchersDate(String hidjqxJournalVouchersDate) {
		this.hidjqxJournalVouchersDate = hidjqxJournalVouchersDate;
	}
	public String getTxtrefno() {
		return txtrefno;
	}
	public void setTxtrefno(String txtrefno) {
		this.txtrefno = txtrefno;
	}
	public String getTxtdescription() {
		return txtdescription;
	}
	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}
	public Double getTxtdrtotal() {
		return txtdrtotal;
	}
	public void setTxtdrtotal(Double txtdrtotal) {
		this.txtdrtotal = txtdrtotal;
	}
	public Double getTxtcrtotal() {
		return txtcrtotal;
	}
	public void setTxtcrtotal(Double txtcrtotal) {
		this.txtcrtotal = txtcrtotal;
	}
	public int getTxttrno() {
		return txttrno;
	}
	public void setTxttrno(int txttrno) {
		this.txttrno = txttrno;
	}
	public String getLblformposted() {
		return lblformposted;
	}
	public void setLblformposted(String lblformposted) {
		this.lblformposted = lblformposted;
	}
	public String getMaindate() {
		return maindate;
	}
	public void setMaindate(String maindate) {
		this.maindate = maindate;
	}
	public String getHidmaindate() {
		return hidmaindate;
	}
	public void setHidmaindate(String hidmaindate) {
		this.hidmaindate = hidmaindate;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
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
	public String getLblpobox() {
		return lblpobox;
	}
	public void setLblpobox(String lblpobox) {
		this.lblpobox = lblpobox;
	}
	public String getLblprintname() {
		return lblprintname;
	}
	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
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
	public String getLbldate() {
		return lbldate;
	}
	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}
	public String getLblvoucherno() {
		return lblvoucherno;
	}
	public void setLblvoucherno(String lblvoucherno) {
		this.lblvoucherno = lblvoucherno;
	}
	public String getLblrefno() {
		return lblrefno;
	}
	public void setLblrefno(String lblrefno) {
		this.lblrefno = lblrefno;
	}
	public String getLblnetamount() {
		return lblnetamount;
	}
	public void setLblnetamount(String lblnetamount) {
		this.lblnetamount = lblnetamount;
	}
	public String getLblnetamountwords() {
		return lblnetamountwords;
	}
	public void setLblnetamountwords(String lblnetamountwords) {
		this.lblnetamountwords = lblnetamountwords;
	}
	public String getLbldescription() {
		return lbldescription;
	}
	public void setLbldescription(String lbldescription) {
		this.lbldescription = lbldescription;
	}
	public String getLbldebittotal() {
		return lbldebittotal;
	}
	public void setLbldebittotal(String lbldebittotal) {
		this.lbldebittotal = lbldebittotal;
	}
	public String getLblcredittotal() {
		return lblcredittotal;
	}
	public void setLblcredittotal(String lblcredittotal) {
		this.lblcredittotal = lblcredittotal;
	}
	public String getLblpreparedby() {
		return lblpreparedby;
	}
	public void setLblpreparedby(String lblpreparedby) {
		this.lblpreparedby = lblpreparedby;
	}
	public String getLblpreparedon() {
		return lblpreparedon;
	}
	public void setLblpreparedon(String lblpreparedon) {
		this.lblpreparedon = lblpreparedon;
	}
	public String getLblpreparedat() {
		return lblpreparedat;
	}
	public void setLblpreparedat(String lblpreparedat) {
		this.lblpreparedat = lblpreparedat;
	}
	public int getFirstarray() {
		return firstarray;
	}
	public void setFirstarray(int firstarray) {
		this.firstarray = firstarray;
	}
	public int getTxtheader() {
		return txtheader;
	}
	public void setTxtheader(int txtheader) {
		this.txtheader = txtheader;
	}

	java.sql.Date journalVouchersDate;
	java.sql.Date hidjournalVouchersDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		session.setAttribute("BRANCHID", getBrchName());
		//System.out.println(getBrchName());
		String mode=getMode();
		ClsJournalVouchersBean bean = new ClsJournalVouchersBean();

		journalVouchersDate = commonDAO.changeStringtoSqlDate(getJqxJournalVouchersDate());
		hidjournalVouchersDate = commonDAO.changeStringtoSqlDate(getMaindate());
		
		if(mode.equalsIgnoreCase("A")){
			
			/*Journal Voucher Grid*/
			ArrayList<String> journalvouchersarray= new ArrayList<>();
			for(int i=0;i<getGridlength();i++){
				ClsJournalVouchersBean journalvouchersbean=new ClsJournalVouchersBean();
				String temp=requestParams.get("test"+i)[0];
				journalvouchersarray.add(temp);
			}
			/*Journal Voucher Grid Ends*/
			
						int val=journalVouchersDAO.insert(journalVouchersDate, getFormdetailcode().concat("-1"), getTxtrefno(), getTxtdescription(), getTxtdrtotal(), getTxtcrtotal(),
								journalvouchersarray,session,request);
						if(val>0.0){

							setTxtjournalvouchersdocno(val);
							setHidjqxJournalVouchersDate(journalVouchersDate.toString());
							setHidmaindate(hidjournalVouchersDate.toString());
							setTxttrno(Integer.parseInt(request.getAttribute("tranno").toString()));
							setData();
							
							setMsg("Successfully Saved");
							return "success";
						}
						else{
							setData();
							setHidjqxJournalVouchersDate(journalVouchersDate.toString());
							setHidmaindate(hidjournalVouchersDate.toString());
							setMsg("Not Saved");
							return "fail";
						}	
		}
		
		else if(mode.equalsIgnoreCase("EDIT")){
			/*Updating Journal Voucher Grid*/
			ArrayList<String> journalvouchersarray= new ArrayList<>();
			for(int i=0;i<getGridlength();i++){
				ClsJournalVouchersBean journalvouchersbean=new ClsJournalVouchersBean();
				String temp=requestParams.get("test"+i)[0];
				journalvouchersarray.add(temp);
			}
			/*Updating Journal Voucher Grid Ends*/
			
			boolean Status=journalVouchersDAO.edit(getTxtjournalvouchersdocno(), getFormdetailcode(),journalVouchersDate, getTxtrefno(), getTxtdescription(), getTxttrno(), getTxtdrtotal(), getTxtcrtotal(),journalvouchersarray,session);
			if(Status){
				setTxtjournalvouchersdocno(getTxtjournalvouchersdocno());
				setHidjqxJournalVouchersDate(journalVouchersDate.toString());
				setHidmaindate(hidjournalVouchersDate.toString());
				setTxttrno(getTxttrno());
				setData();
				
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setData();
				setHidjqxJournalVouchersDate(journalVouchersDate.toString());
				setHidmaindate(hidjournalVouchersDate.toString());
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("E")){

			boolean Status=journalVouchersDAO.editMaster(getTxtjournalvouchersdocno(), getFormdetailcode(),journalVouchersDate, getTxtrefno(), getTxtdescription(),getTxttrno(), getTxtdrtotal(), getTxtcrtotal(),session);
			if(Status){
				setTxtjournalvouchersdocno(getTxtjournalvouchersdocno());
				setHidjqxJournalVouchersDate(journalVouchersDate.toString());
				setHidmaindate(hidjournalVouchersDate.toString());
				setTxttrno(getTxttrno());
				setData();
				
				setMsg("Updated Successfully");
			    return "success";
		}
		else{
			setTxtjournalvouchersdocno(getTxtjournalvouchersdocno());
			setHidjqxJournalVouchersDate(journalVouchersDate.toString());
			setHidmaindate(hidjournalVouchersDate.toString());
			setTxttrno(getTxttrno());
			setData();
			setMsg("Not Updated");
			return "fail";
		}
	  }
		
		else if(mode.equalsIgnoreCase("D")){
			/*Updating Journal Voucher Grid*/
			ArrayList<String> journalvouchersarray= new ArrayList<>();
			for(int i=0;i<getGridlength();i++){
				ClsJournalVouchersBean journalvouchersbean=new ClsJournalVouchersBean();
				String temp=requestParams.get("test"+i)[0];
				journalvouchersarray.add(temp);
			}
			/*Updating Journal Voucher Grid Ends*/
			
			boolean Status=journalVouchersDAO.delete(getTxtjournalvouchersdocno(), getFormdetailcode(),getTxttrno(),session);
			if(Status){
				setTxtjournalvouchersdocno(getTxtjournalvouchersdocno());
				setTxttrno(getTxttrno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setData();
				setTxtjournalvouchersdocno(getTxtjournalvouchersdocno());
				setTxttrno(getTxttrno());
				setMsg("Not Deleted");
				return "fail";
			   }
			}
		
		else if(mode.equalsIgnoreCase("View")){
			
			journalVouchersBean=journalVouchersDAO.getViewDetails(getBrchName(),getTxtjournalvouchersdocno());
			
			setJqxJournalVouchersDate(journalVouchersBean.getJqxJournalVouchersDate());
			setTxtrefno(journalVouchersBean.getTxtrefno());
			setTxtdescription(journalVouchersBean.getTxtdescription());
			setTxtdrtotal(journalVouchersBean.getTxtdrtotal());
			setTxtcrtotal(journalVouchersBean.getTxtcrtotal());
			setTxttrno(journalVouchersBean.getTxttrno());
			setLblformposted(journalVouchersBean.getLblformposted());
			setMaindate(journalVouchersBean.getMaindate());
			setFormdetailcode(journalVouchersBean.getFormdetailcode());
			
			return "success";
		}
		return "fail";
   }
	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		int docno=Integer.parseInt(request.getParameter("docno"));
		int header=Integer.parseInt(request.getParameter("header"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		journalVouchersBean=journalVouchersDAO.getPrint(request,docno,branch,header);
		//System.out.println("docno--"+docno);
		
		setUrl(commonDAO.getPrintPath("JVT"));
		setLblcompname(journalVouchersBean.getLblcompname());
		setLblcompaddress(journalVouchersBean.getLblcompaddress());
		setLblpobox(journalVouchersBean.getLblpobox());
		setLblprintname(journalVouchersBean.getLblprintname());
		setLblcomptel(journalVouchersBean.getLblcomptel());
		setLblcompfax(journalVouchersBean.getLblcompfax());
		setLblbranch(journalVouchersBean.getLblbranch());
		setLbllocation(journalVouchersBean.getLbllocation());
		setLblservicetax(journalVouchersBean.getLblservicetax());
		setLblpan(journalVouchersBean.getLblpan());
		setLblcstno(journalVouchersBean.getLblcstno());
		setLbldate(journalVouchersBean.getLbldate());
		setLblvoucherno(journalVouchersBean.getLblvoucherno());
		setLblrefno(journalVouchersBean.getLblrefno());
		setLblnetamount(journalVouchersBean.getLblnetamount());
		setLblnetamountwords(journalVouchersBean.getLblnetamountwords());
		setLbldescription(journalVouchersBean.getLbldescription());
		setLbldebittotal(journalVouchersBean.getLbldebittotal());
		setLblcredittotal(journalVouchersBean.getLblcredittotal());
		setLblpreparedby(journalVouchersBean.getLblpreparedby());
		setLblpreparedon(journalVouchersBean.getLblpreparedon());
		setLblpreparedat(journalVouchersBean.getLblpreparedat());
		
		// for hide
		setFirstarray(journalVouchersBean.getFirstarray());
		setTxtheader(journalVouchersBean.getTxtheader());
	
		if(commonDAO.getPrintPath("JVT").contains(".jrxml")==true)
		{
			HttpServletResponse response = ServletActionContext.getResponse();
			
	  Connection conn = null;
			 try {
				 param = new HashMap();
	             	 conn = connDAO.getMyConnection();
	             	Statement stmtPC = conn.createStatement();
	             
	             	String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
	               	imgpath=imgpath.replace("\\", "\\\\");
	               	
	               	String imgpathfooter=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
	               	imgpathfooter=imgpathfooter.replace("\\", "\\\\");
	              	
	               	if(branch==1)
			          {
			        	  String imgpath1=request.getSession().getServletContext().getRealPath("/icons/IGLOGO.jpg");
				        	 imgpath1=imgpath1.replace("\\", "\\\\");
				        	 param.put("cmplogo", imgpath1);
			          }
			          else if(branch==2)
			          {
			        	  String imgpath3=request.getSession().getServletContext().getRealPath("/icons/IGLOGO1.jpg");
				        	 imgpath3=imgpath3.replace("\\", "\\\\");
				        	 param.put("cmplogo", imgpath3);
			          }
			           else if(branch==3)
			          {
			        	  String imgpath3=request.getSession().getServletContext().getRealPath("/icons/IGLOGO3.jpg");
				        	 imgpath3=imgpath3.replace("\\", "\\\\");
				        	 param.put("cmplogo", imgpath3);
			          }
			          if(branch==4)
			          {
			        	  String imgpath3=request.getSession().getServletContext().getRealPath("/icons/IGLOGO4.jpg");
				        	 imgpath3=imgpath3.replace("\\", "\\\\");
				        	 param.put("cmplogo", imgpath3);
			          }
	                param.put("header", new Integer(header));
			         param.put("imgpath", imgpath);
			         param.put("imgpathfooter", imgpathfooter);
			         
			         param.put("compname", journalVouchersBean.getLblcompname());
			         param.put("compaddress", journalVouchersBean.getLblcompaddress());
			        
			         param.put("comptel", journalVouchersBean.getLblcomptel());
			         param.put("compfax", journalVouchersBean.getLblcompfax());
			         param.put("compbranch", journalVouchersBean.getLblbranch());
			         param.put("location", journalVouchersBean.getLbllocation());
	             
	        	 param.put("doc", new Integer(docno));
		         param.put("brch", new Integer(branch));
		       // System.out.println("doc--"+docno);
		         param.put("printname", journalVouchersBean.getLblprintname());  
		         param.put("refno", journalVouchersBean.getLblrefno());
		         param.put("vno", journalVouchersBean.getLblvoucherno());
		         param.put("descp", journalVouchersBean.getLbldescription());
		         param.put("vdate", journalVouchersBean.getLbldate());
		         param.put("amtword", journalVouchersBean.getLblnetamountwords());
		         param.put("amt", journalVouchersBean.getLblnetamount());
		         
		         param.put("debtot", journalVouchersBean.getLbldebittotal());
		         param.put("credtot", journalVouchersBean.getLblcredittotal());
		         
		         
		         param.put("prepby", journalVouchersBean.getLblpreparedby());
		         param.put("prepon", journalVouchersBean.getLblpreparedon());
		         param.put("prepat", journalVouchersBean.getLblpreparedat());
		         
		         param.put("printby", session.getAttribute("USERNAME"));
		         String path[]=commonDAO.getPrintPath("JVT").split("journalvouchers/");
			        setUrl(path[1]);
		        	 
	           JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(commonDAO.getPrintPath("JVT")));
	     	 
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
	
	public void setData(){
		setFormdetailcode(getFormdetailcode());
		setTxtrefno(getTxtrefno());
		setTxtdescription(getTxtdescription());
		setTxtdrtotal(getTxtdrtotal());
		setTxtcrtotal(getTxtcrtotal());
	}
/*
public void jasperprintAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
	    HttpServletResponse response = ServletActionContext.getResponse();
		
		int docno=Integer.parseInt(request.getParameter("docno"));
		int header=Integer.parseInt(request.getParameter("header"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		journalVouchersBean=journalVouchersDAO.getPrint(request,docno,branch,header);
		
		String reportFileName = "journalvoucherprint";
		 param = new HashMap();
  Connection conn = null;
		 try {
	       
             	 conn = connDAO.getMyConnection();
             	Statement stmtPC = conn.createStatement();
             
             	String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
               	imgpath=imgpath.replace("\\", "\\\\");
              	
                param.put("header", new Integer(header));
		         param.put("imgpath", imgpath);
		         
		         param.put("compname", journalVouchersBean.getLblcompname());
		         param.put("compaddress", journalVouchersBean.getLblcompaddress());
		        
		         param.put("comptel", journalVouchersBean.getLblcomptel());
		         param.put("compfax", journalVouchersBean.getLblcompfax());
		         param.put("compbranch", journalVouchersBean.getLblbranch());
		         param.put("location", journalVouchersBean.getLbllocation());
             
        	 param.put("doc", new Integer(docno));
	         param.put("brch", new Integer(branch));
	        
	         param.put("printname", journalVouchersBean.getLblprintname());  
	         param.put("refno", journalVouchersBean.getLblrefno());
	         param.put("vno", journalVouchersBean.getLblvoucherno());
	         param.put("descp", journalVouchersBean.getLbldescription());
	         param.put("vdate", journalVouchersBean.getLbldate());
	         param.put("amtword", journalVouchersBean.getLblnetamountwords());
	         param.put("amt", journalVouchersBean.getLblnetamount());
	         
	         param.put("debtot", journalVouchersBean.getLbldebittotal());
	         param.put("credtot", journalVouchersBean.getLblcredittotal());
	         
	         
	         param.put("prepby", journalVouchersBean.getLblpreparedby());
	         param.put("prepon", journalVouchersBean.getLblpreparedon());
	         param.put("prepat", journalVouchersBean.getLblpreparedat());
	         
	         param.put("printby", session.getAttribute("USERNAME"));
	         
	        	 
                              JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/finance/transactions/journalvouchers/" + reportFileName + ".jrxml"));
     	 
     	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
                       generateReportPDF(response, param, jasperReport, conn);
                 
      
             } catch (Exception e) {

                 e.printStackTrace();

             }
            	 finally{
				conn.close();
			}	  
            	 
      	
				} */
	
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

