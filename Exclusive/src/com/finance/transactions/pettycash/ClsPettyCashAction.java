package com.finance.transactions.pettycash;

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
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import java.sql.Connection;
import java.sql.Statement;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsPettyCashAction extends ActionSupport{

	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsPettyCashDAO pettyCashDAO= new ClsPettyCashDAO();
	ClsPettyCashBean pettyCashBean;

	private int txtpettycashdocno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String jqxPettyCashDate;
	private String hidjqxPettyCashDate;
	private String txtrefno;
	private int txtdocno;
	private String txtaccid;
	private String txtaccname;
	private String cmbcurrency;
	private String hidcmbcurrency;
	private double txtrate;
	private double txtamount;
	private double txtbaseamount;
	private String txtdescription;
	private int txttrno;
	private int txttranid;
	private String hidcurrencytype;
	
	private String maindate;
	private String hidmaindate;
	
	private String url;
		
	//Petty Cash Grid
	private int gridlength;
	
	//Print
	private String lblmainname;
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
	private String lblcomptrn;
	private String lblname;
	private String lblvoucherno;
	private String lbldescription;
	private String lbldate;
	private String lblnetamount;
	private String lblnetamountwords;
	private String lbldebittotal;
	private String lblcredittotal;
	private String lblpreparedby;
	private String lblpreparedon;
	private String lblpreparedat;
	private String brchName;
	//for hide
	private int firstarray;
	private int txtheader;

	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
		}
	public int getTxtpettycashdocno() {
		return txtpettycashdocno;
	}

	public void setTxtpettycashdocno(int txtpettycashdocno) {
		this.txtpettycashdocno = txtpettycashdocno;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
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

	public String getJqxPettyCashDate() {
		return jqxPettyCashDate;
	}

	public void setJqxPettyCashDate(String jqxPettyCashDate) {
		this.jqxPettyCashDate = jqxPettyCashDate;
	}

	public String getHidjqxPettyCashDate() {
		return hidjqxPettyCashDate;
	}

	public void setHidjqxPettyCashDate(String hidjqxPettyCashDate) {
		this.hidjqxPettyCashDate = hidjqxPettyCashDate;
	}

	public String getTxtrefno() {
		return txtrefno;
	}

	public void setTxtrefno(String txtrefno) {
		this.txtrefno = txtrefno;
	}

	public int getTxtdocno() {
		return txtdocno;
	}

	public void setTxtdocno(int txtdocno) {
		this.txtdocno = txtdocno;
	}

	public String getTxtaccid() {
		return txtaccid;
	}

	public void setTxtaccid(String txtaccid) {
		this.txtaccid = txtaccid;
	}

	public String getTxtaccname() {
		return txtaccname;
	}

	public void setTxtaccname(String txtaccname) {
		this.txtaccname = txtaccname;
	}

	public String getCmbcurrency() {
		return cmbcurrency;
	}

	public void setCmbcurrency(String cmbcurrency) {
		this.cmbcurrency = cmbcurrency;
	}

	public String getHidcmbcurrency() {
		return hidcmbcurrency;
	}

	public void setHidcmbcurrency(String hidcmbcurrency) {
		this.hidcmbcurrency = hidcmbcurrency;
	}

	public double getTxtrate() {
		return txtrate;
	}

	public void setTxtrate(double txtrate) {
		this.txtrate = txtrate;
	}

	public double getTxtamount() {
		return txtamount;
	}

	public void setTxtamount(double txtamount) {
		this.txtamount = txtamount;
	}

	public double getTxtbaseamount() {
		return txtbaseamount;
	}

	public void setTxtbaseamount(double txtbaseamount) {
		this.txtbaseamount = txtbaseamount;
	}

	public String getTxtdescription() {
		return txtdescription;
	}

	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}

	public int getTxttrno() {
		return txttrno;
	}

	public void setTxttrno(int txttrno) {
		this.txttrno = txttrno;
	}

	public int getTxttranid() {
		return txttranid;
	}

	public void setTxttranid(int txttranid) {
		this.txttranid = txttranid;
	}

	public String getHidcurrencytype() {
		return hidcurrencytype;
	}

	public void setHidcurrencytype(String hidcurrencytype) {
		this.hidcurrencytype = hidcurrencytype;
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

	public String getLblmainname() {
		return lblmainname;
	}

	public void setLblmainname(String lblmainname) {
		this.lblmainname = lblmainname;
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

	public String getLblcomptrn() {
			return lblcomptrn;
		}
		public void setLblcomptrn(String lblcomptrn) {
			this.lblcomptrn = lblcomptrn;
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

	public String getLblname() {
		return lblname;
	}

	public void setLblname(String lblname) {
		this.lblname = lblname;
	}

	public String getLblvoucherno() {
		return lblvoucherno;
	}

	public void setLblvoucherno(String lblvoucherno) {
		this.lblvoucherno = lblvoucherno;
	}

	public String getLbldescription() {
		return lbldescription;
	}

	public void setLbldescription(String lbldescription) {
		this.lbldescription = lbldescription;
	}

	public String getLbldate() {
		return lbldate;
	}

	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
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

private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	java.sql.Date pettyCashDate;
	java.sql.Date hidpettyCashDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		session.setAttribute("BRANCHID", getBrchName());
		//System.out.println(getBrchName());
		String mode=getMode();
		ClsPettyCashBean bean = new ClsPettyCashBean();
		pettyCashDate = commonDAO.changeStringtoSqlDate(getJqxPettyCashDate());
		hidpettyCashDate = commonDAO.changeStringtoSqlDate(getMaindate());
		
		if(mode.equalsIgnoreCase("A")){
			/*Petty Cash Grid Saving*/
			ArrayList pettycasharray= new ArrayList();
			
			pettycasharray.add(getTxtdocno()+"::"+getCmbcurrency()+"::"+getTxtrate()+"::false::"+getTxtamount()*-1+"::"+getTxtdescription()+"::"+getTxtbaseamount()*-1+"::0::0::0");
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				pettycasharray.add(temp);
			}
			/*Petty Cash Grid Saving Ends*/
			
						int val=pettyCashDAO.insert(pettyCashDate,getFormdetailcode(),getTxtrefno(),getTxtrate(),getTxtamount(),getTxtdescription(),pettycasharray,session,request,mode);
						if(val>0.0){
							
							setTxtpettycashdocno(val);
							setTxttrno(Integer.parseInt(request.getAttribute("tranno").toString()));
							setData();
							
							setMsg("Successfully Saved");
							return "success";
						}
						else{
							setData();
							setMsg("Not Saved");
							return "fail";
						}	
		}
		
		else if(mode.equalsIgnoreCase("EDIT")){
			/*Updating Petty Cash Grid*/
			ArrayList pettycasharray= new ArrayList();
			
			pettycasharray.add(getTxtdocno()+"::"+getCmbcurrency()+"::"+getTxtrate()+"::false::"+getTxtamount()*-1+"::"+getTxtdescription()+"::"+getTxtbaseamount()*-1+"::0::0::0");
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				pettycasharray.add(temp);
			}
			/*Updating Petty Cash Grid Ends*/
					
			boolean Status=pettyCashDAO.edit(getTxtpettycashdocno(),getFormdetailcode(),pettyCashDate,getTxtrefno(),getTxtdescription(),getTxtrate(),getTxtamount(),getTxtdocno(),getTxttrno(),pettycasharray,session,mode);
			if(Status){

				setTxtpettycashdocno(getTxtpettycashdocno());
				setTxttrno(getTxttrno());
				setData();
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setTxtpettycashdocno(getTxtpettycashdocno());
				setTxttrno(getTxttrno());
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("E")){

			boolean Status=pettyCashDAO.editMaster(getTxtpettycashdocno(),getFormdetailcode(),pettyCashDate,getTxtrefno(),getTxtdescription(),getTxtrate(),getTxtamount(),getTxtdocno(),getTxttrno(),session);
			if(Status){

				setTxtpettycashdocno(getTxtpettycashdocno());
				setTxttrno(getTxttrno());
				setData();
				
				setMsg("Updated Successfully");
			    return "success";
		}
		else{
			setTxtpettycashdocno(getTxtpettycashdocno());
			setTxttrno(getTxttrno());
			setData();
			setMsg("Not Updated");
			return "fail";
		}
	  }
		
		else if(mode.equalsIgnoreCase("D")){
					
			boolean Status=pettyCashDAO.delete(getTxtpettycashdocno(),getTxttrno(),getFormdetailcode(),session);
			if(Status){
				
				setTxtpettycashdocno(getTxtpettycashdocno());
				setTxttrno(getTxttrno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setData();
				setMsg("Not Deleted");
				return "fail";
			   }
			}
		
		else if(mode.equalsIgnoreCase("View")){
	
			String branch=null;
			pettyCashBean=pettyCashDAO.getViewDetails(session,getTxtpettycashdocno());
			
			setJqxPettyCashDate(pettyCashBean.getJqxPettyCashDate());
			setTxtrefno(pettyCashBean.getTxtrefno());
			
			setTxtdocno(pettyCashBean.getTxtdocno());
			setTxtaccid(pettyCashBean.getTxtaccid());
			setTxtaccname(pettyCashBean.getTxtaccname());
			setHidcmbcurrency(pettyCashBean.getHidcmbcurrency());
			setHidcurrencytype(pettyCashBean.getHidcurrencytype());
			setTxtrate(pettyCashBean.getTxtrate());
			setTxtamount(pettyCashBean.getTxtamount());
			setTxtbaseamount(pettyCashBean.getTxtbaseamount());
			setTxtdescription(pettyCashBean.getTxtdescription());
			setTxttranid(pettyCashBean.getTxttranid());
			setTxttrno(pettyCashBean.getTxttrno());
			setMaindate(pettyCashBean.getMaindate());
			setFormdetailcode(pettyCashBean.getFormdetailcode());
			
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
		pettyCashBean=pettyCashDAO.getPrint(request,docno,branch,header);
		
		setLblmainname("Paid From");
		setUrl(commonDAO.getPrintPath("PC"));
		setLblcomptrn(pettyCashBean.getLblcomptrn());
		setLblcompname(pettyCashBean.getLblcompname());
		setLblcompaddress(pettyCashBean.getLblcompaddress());
		setLblpobox(pettyCashBean.getLblpobox());
		setLblprintname(pettyCashBean.getLblprintname());
		setLblcomptel(pettyCashBean.getLblcomptel());
		setLblcompfax(pettyCashBean.getLblcompfax());
		setLblbranch(pettyCashBean.getLblbranch());
		setLbllocation(pettyCashBean.getLbllocation());
		setLblservicetax(pettyCashBean.getLblservicetax());
		setLblpan(pettyCashBean.getLblpan());
		setLblcstno(pettyCashBean.getLblcstno());
		setLblname(pettyCashBean.getLblname());
		setLblvoucherno(pettyCashBean.getLblvoucherno());
		setLbldescription(pettyCashBean.getLbldescription());
		setLbldate(pettyCashBean.getLbldate());
		setLblnetamount(pettyCashBean.getLblnetamount());
		setLblnetamountwords(pettyCashBean.getLblnetamountwords());
		setLbldebittotal(pettyCashBean.getLbldebittotal());
		setLblcredittotal(pettyCashBean.getLblcredittotal());
		setLblpreparedby(pettyCashBean.getLblpreparedby());
		setLblpreparedon(pettyCashBean.getLblpreparedon());
		setLblpreparedat(pettyCashBean.getLblpreparedat());
		
		// for hide
		setFirstarray(pettyCashBean.getFirstarray());
		setTxtheader(pettyCashBean.getTxtheader());
		
		if(commonDAO.getPrintPath("PC").contains(".jrxml")==true)
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
	                param.put("header", new Integer(header));
			         param.put("imgpath", imgpath);
			         param.put("imgpathfooter", imgpathfooter);
			         
			         param.put("compname", pettyCashBean.getLblcompname());
			         param.put("compaddress", pettyCashBean.getLblcompaddress());
			        
			         param.put("comptel", pettyCashBean.getLblcomptel());
			         param.put("compfax", pettyCashBean.getLblcompfax());
			         param.put("compbranch", pettyCashBean.getLblbranch());
			         param.put("location", pettyCashBean.getLbllocation());
	            
	        	 param.put("doc", new Integer(docno));
		         param.put("brch", new Integer(branch));
		        
		         param.put("printname", pettyCashBean.getLblprintname());  
		         param.put("name", pettyCashBean.getLblname());
		         param.put("vno", pettyCashBean.getLblvoucherno());
		         param.put("descp", pettyCashBean.getLbldescription());
		         param.put("vdate", pettyCashBean.getLbldate());
		         param.put("amtword", pettyCashBean.getLblnetamountwords());
		         param.put("amt", pettyCashBean.getLblnetamount());
		         
		         param.put("debtot", pettyCashBean.getLbldebittotal());
		         param.put("credtot", pettyCashBean.getLblcredittotal());
		         
		         
		         param.put("prepby", pettyCashBean.getLblpreparedby());
		         param.put("prepon", pettyCashBean.getLblpreparedon());
		         param.put("prepat", pettyCashBean.getLblpreparedat());
		         
		         param.put("printby", session.getAttribute("USERNAME"));
		        String path[]=commonDAO.getPrintPath("PC").split("pettycash/");
		        setUrl(path[1]);
		        
	             JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(commonDAO.getPrintPath("PC")));
         	 
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

		public JSONArray searchDetails(HttpSession session,String partyname,String docNo,String date,String amount,String check){
			  JSONArray cellarray = new JSONArray();
			  		  JSONObject cellobj = null;
			  try {
				cellarray= pettyCashDAO.pcMainSearch(session, partyname, docNo, date, amount, check);
		
			  } catch (SQLException e) {
				  e.printStackTrace();
				  }
			return cellarray;
		}
		
		public void setData() {
			
			setHidjqxPettyCashDate(pettyCashDate.toString());
			setHidmaindate(hidpettyCashDate.toString());
			setTxtrefno(getTxtrefno());
			
			setTxtdocno(getTxtdocno());
			setTxtaccid(getTxtaccid());
			setTxtaccname(getTxtaccname());
			setHidcmbcurrency(getCmbcurrency());
			setHidcurrencytype(getHidcurrencytype());
			setTxtrate(getTxtrate());
			setTxtamount(getTxtamount());
			setTxtbaseamount(getTxtbaseamount());
			setTxtdescription(getTxtdescription());
		
			setFormdetailcode(getFormdetailcode());
		}


/*public void jasperprintAction() throws ParseException, SQLException{
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
		    HttpServletResponse response = ServletActionContext.getResponse();
			
			int docno=Integer.parseInt(request.getParameter("docno"));
			int header=Integer.parseInt(request.getParameter("header"));
			int branch=Integer.parseInt(request.getParameter("branch"));
			pettyCashBean=pettyCashDAO.getPrint(request,docno,branch,header);
			String reportFileName = "pettycashprint";
		
			 param = new HashMap();
	  Connection conn = null;
			 try {
		       
	             	 conn = connDAO.getMyConnection();
	             	Statement stmtPC = conn.createStatement();
	            
	             	String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
	               	imgpath=imgpath.replace("\\", "\\\\");
	              	
	                param.put("header", new Integer(header));
			         param.put("imgpath", imgpath);
			         
			         param.put("compname", pettyCashBean.getLblcompname());
			         param.put("compaddress", pettyCashBean.getLblcompaddress());
			        
			         param.put("comptel", pettyCashBean.getLblcomptel());
			         param.put("compfax", pettyCashBean.getLblcompfax());
			         param.put("compbranch", pettyCashBean.getLblbranch());
			         param.put("location", pettyCashBean.getLbllocation());
	            
	        	 param.put("doc", new Integer(docno));
		         param.put("brch", new Integer(branch));
		        
		         param.put("printname", pettyCashBean.getLblprintname());  
		         param.put("name", pettyCashBean.getLblname());
		         param.put("vno", pettyCashBean.getLblvoucherno());
		         param.put("descp", pettyCashBean.getLbldescription());
		         param.put("vdate", pettyCashBean.getLbldate());
		         param.put("amtword", pettyCashBean.getLblnetamountwords());
		         param.put("amt", pettyCashBean.getLblnetamount());
		         
		         param.put("debtot", pettyCashBean.getLbldebittotal());
		         param.put("credtot", pettyCashBean.getLblcredittotal());
		         
		         
		         param.put("prepby", pettyCashBean.getLblpreparedby());
		         param.put("prepon", pettyCashBean.getLblpreparedon());
		         param.put("prepat", pettyCashBean.getLblpreparedat());
		         
		         param.put("printby", session.getAttribute("USERNAME"));
		         
		        	 
	                              JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/finance/transactions/pettycash/" + reportFileName + ".jrxml"));
         	 
         	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
                           generateReportPDF(response, param, jasperReport, conn);
                     
          
                 } catch (Exception e) {
  
                     e.printStackTrace();
  
                 }
	            	 
	           finally{
				conn.close();
			}	   	 
	      	
					}
*/		
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

