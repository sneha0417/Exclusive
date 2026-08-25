package com.finance.transactions.multiplecashpurchase;

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
public class ClsmultipleCashPurchaseAction extends ActionSupport{

	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsmultipleCashPurchaseDAO multipleCashPurchaseDAO= new ClsmultipleCashPurchaseDAO();
	ClsmultipleCashPurchaseBean multipleCashPurchaseBean;

	private int txtpettycashdocno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String jqxmcpdate;
	private String hidjqxmcpdate;
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
	private String vendor;
	private String vendorid;
	private String tinno;
	private String invno;
	private String jqxinvdate;
	//private String invdate;
	
	
	private String taxamt;
	private String total1;
	private String tax;
	
	
	private String maindate;
	private String hidmaindate;
	
	private String url;
		
	//MCP Grid
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

	//for hide
	private int firstarray;
	private int txtheader;
	private int rowno;
	private String srvtaxper;
	
	
	
	

	public int getRowno() {
		return rowno;
	}

	public void setRowno(int rowno) {
		this.rowno = rowno;
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

	public String getJqxmcpdate() {
		return jqxmcpdate;
	}

	public void setJqxmcpdate(String jqxmcpdate) {
		this.jqxmcpdate = jqxmcpdate;
	}

	public String getHidjqxmcpdate() {
		return hidjqxmcpdate;
	}

	public void setHidjqxmcpdate(String hidjqxmcpdate) {
		this.hidjqxmcpdate = hidjqxmcpdate;
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
	
	
    public String getVendor() {
		return vendor;
	}

	public void setVendor(String vendor) {
		this.vendor = vendor;
	}

	public String getTinno() {
		return tinno;
	}

	public void setTinno(String tinno) {
		this.tinno = tinno;
	}

	public String getTaxamt() {
		return taxamt;
	}

	public void setTaxamt(String taxamt) {
		this.taxamt = taxamt;
	}

	public String getTotal1() {
		return total1;
	}

	public void setTotal1(String total1) {
		this.total1 = total1;
	}

	public String getTax() {
		return tax;
	}

	public void setTax(String tax) {
		this.tax = tax;
	}


    public String getInvno() {
		return invno;
	}

	public void setInvno(String invno) {
		this.invno = invno;
	}

	public String getJqxinvdate() {
		return jqxinvdate;
	}

	public void setJqxinvdate(String jqxinvdate) {
		this.jqxinvdate = jqxinvdate;
	}

	
    


/*    public String getInvdate() {
		return invdate;
	}

	public void setInvdate(String invdate) {
		this.invdate = invdate;
	}*/

	public String getVendorid() {
		return vendorid;
	}

	public void setVendorid(String vendorid) {
		this.vendorid = vendorid;
	}
	
	public String getSrvtaxper() {
		return srvtaxper;
	}

	public void setSrvtaxper(String srvtaxper) {
		this.srvtaxper = srvtaxper;
	}




private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	
	java.sql.Date invdate;
	
	java.sql.Date mcpdate;
	
	java.sql.Date hidmcpdate;
	
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsmultipleCashPurchaseBean bean = new ClsmultipleCashPurchaseBean();
//		System.out.println("mcpdate-->"+getJqxmcpdate());
		//System.out.println("invdate-->"+getJqxinvdate());
		 mcpdate = commonDAO.changeStringtoSqlDate(getJqxmcpdate());
//		System.out.println("mcpdate1-->"+mcpdate);
		//invdate = commonDAO.changeStringtoSqlDate(getJqxinvdate());
	     hidmcpdate = commonDAO.changeStringtoSqlDate(getMaindate());
		
		if(mode.equalsIgnoreCase("A")){
			/*Multiple Cash Purchase Grid Saving*/
			ArrayList mcparray= new ArrayList();
			
			mcparray.add(getTxtdocno()+"::"+getCmbcurrency()+"::"+getTxtrate()+"::false::"+getTxtamount()*1+"::"+getTxtdescription()+"::"+getTxtbaseamount()*1+"::0::0::0::0::0::0::"+getJqxmcpdate()+"::0::"+getTxtamount()+"::0::0::0::0::0");
			   
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
//				System.out.println("temp length-->"+temp);
				mcparray.add(temp);
//				System.out.println("mcparray length-->"+mcparray);
			}
			/*Multiple Cash Purchase Grid Saving Ends*/
			
						int val=multipleCashPurchaseDAO.insert(mcpdate,getFormdetailcode(),getTxtrefno(),getTxtrate(),getTxtamount(),getTxtdescription(),mcparray,session,request,mode,getVendorid(),getTinno(),getInvno(),invdate,getTaxamt(),getTotal1(),getTxtdocno());
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
//			System.out.println("in edit1");
			/*Updating Multiple cash Grid*/
			ArrayList mcparray= new ArrayList();
			
			mcparray.add(getTxtdocno()+"::"+getCmbcurrency()+"::"+getTxtrate()+"::false::"+getTxtamount()*1+"::"+getTxtdescription()+"::"+getTxtbaseamount()*1+"::0::0::0::0::0::0::"+getJqxmcpdate()+"::0::"+getTxtamount()+"::0::0::0::0::0");
			
			for(int i=0;i<getGridlength();i++){  
				String temp=requestParams.get("test"+i)[0];
//				System.out.println("temp length-->"+temp);
				mcparray.add(temp);
			}
//			System.out.println("in edit2");
			/*Updating Multiple Cash Grid Ends*/
					
			boolean Status=multipleCashPurchaseDAO.edit(getTxtpettycashdocno(),getFormdetailcode(),mcpdate,getTxtrefno(),getTxtdescription(),getTxtrate(),getTxtamount(),getTxtdocno(),getTxttrno(),mcparray,session,mode,getVendor(),getTinno(),getInvno(),invdate,getTaxamt(),getTotal1());
//			System.out.println("in edit3"+Status);    
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
//			System.out.println("in edit1");
			/*Updating Petty Cash Grid*/
			ArrayList mcparray= new ArrayList();
//			System.out.println("amount ========= "+getTxtamount());
			mcparray.add(getTxtdocno()+"::"+getCmbcurrency()+"::"+getTxtrate()+"::false::"+getTxtamount()*1+"::"+getTxtdescription()+"::"+getTxtbaseamount()*1+"::0::0::0::0::0::0::"+getJqxmcpdate()+"::0::"+getTxtamount()+"::0::0::0::0::0");
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
//				System.out.println("temp length-->"+temp);
				mcparray.add(temp);
			}
//			System.out.println("in edit2");
			/*Updating Petty Cash Grid End*/
		
			boolean Status=multipleCashPurchaseDAO.editMaster(getTxtpettycashdocno(),getFormdetailcode(),mcpdate,getTxtrefno(),getTxtdescription(),getTxtrate(),getTxtamount(),mcparray,session,getMode(),getVendorid(),getInvno(),getTinno(),invdate,getTxttrno(),getTxtdocno(),getTaxamt(),getTotal1(),getTxtdocno());
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
					
			boolean Status=multipleCashPurchaseDAO.delete(getTxtpettycashdocno(),getTxttrno(),getFormdetailcode(),session);
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
			multipleCashPurchaseBean=multipleCashPurchaseDAO.getViewDetails(session,getTxtpettycashdocno());
			
			setJqxmcpdate(multipleCashPurchaseBean.getJqxmcpdate());
			setTxtrefno(multipleCashPurchaseBean.getTxtrefno());
			
			setTxtdocno(multipleCashPurchaseBean.getTxtdocno());
			setTxtaccid(multipleCashPurchaseBean.getTxtaccid());
			setTxtaccname(multipleCashPurchaseBean.getTxtaccname());
			setHidcmbcurrency(multipleCashPurchaseBean.getHidcmbcurrency());
			setHidcurrencytype(multipleCashPurchaseBean.getHidcurrencytype());
			setTxtrate(multipleCashPurchaseBean.getTxtrate());
			setTxtamount(multipleCashPurchaseBean.getTxtamount());
			setSrvtaxper(multipleCashPurchaseBean.getSrvtaxper());
			setTxtbaseamount(multipleCashPurchaseBean.getTxtbaseamount());
			setTxtdescription(multipleCashPurchaseBean.getTxtdescription());
			setTxttranid(multipleCashPurchaseBean.getTxttranid());
			setTxttrno(multipleCashPurchaseBean.getTxttrno());
			setMaindate(multipleCashPurchaseBean.getMaindate());
			setFormdetailcode(multipleCashPurchaseBean.getFormdetailcode());
			
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
		multipleCashPurchaseBean=multipleCashPurchaseDAO.getPrint(request,docno,branch,header);
		
		setLblmainname("Paid From");
		setUrl(commonDAO.getPrintPath("MCP"));
		setLblcomptrn(multipleCashPurchaseBean.getLblcomptrn());
		setLblcompname(multipleCashPurchaseBean.getLblcompname());
		setLblcompaddress(multipleCashPurchaseBean.getLblcompaddress());
		setLblpobox(multipleCashPurchaseBean.getLblpobox());
		setLblprintname(multipleCashPurchaseBean.getLblprintname());
		setLblcomptel(multipleCashPurchaseBean.getLblcomptel());
		setLblcompfax(multipleCashPurchaseBean.getLblcompfax());
		setLblbranch(multipleCashPurchaseBean.getLblbranch());
		setLbllocation(multipleCashPurchaseBean.getLbllocation());
		setLblservicetax(multipleCashPurchaseBean.getLblservicetax());
		setLblpan(multipleCashPurchaseBean.getLblpan());
		setLblcstno(multipleCashPurchaseBean.getLblcstno());
		setLblname(multipleCashPurchaseBean.getLblname());
		setLblvoucherno(multipleCashPurchaseBean.getLblvoucherno());
		setLbldescription(multipleCashPurchaseBean.getLbldescription());
		setLbldate(multipleCashPurchaseBean.getLbldate());
		setLblnetamount(multipleCashPurchaseBean.getLblnetamount());
		setLblnetamountwords(multipleCashPurchaseBean.getLblnetamountwords());
		setLbldebittotal(multipleCashPurchaseBean.getLbldebittotal());
		setLblcredittotal(multipleCashPurchaseBean.getLblcredittotal());
		setLblpreparedby(multipleCashPurchaseBean.getLblpreparedby());
		setLblpreparedon(multipleCashPurchaseBean.getLblpreparedon());
		setLblpreparedat(multipleCashPurchaseBean.getLblpreparedat());
		
		// for hide
		setFirstarray(multipleCashPurchaseBean.getFirstarray());
		setTxtheader(multipleCashPurchaseBean.getTxtheader());
		
		if(commonDAO.getPrintPath("MCP").contains(".jrxml")==true)
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
			         
			         param.put("compname", multipleCashPurchaseBean.getLblcompname());
			         param.put("compaddress", multipleCashPurchaseBean.getLblcompaddress());
			        
			         param.put("comptel", multipleCashPurchaseBean.getLblcomptel());
			         param.put("compfax", multipleCashPurchaseBean.getLblcompfax());
			         param.put("compbranch", multipleCashPurchaseBean.getLblbranch());
			         param.put("location", multipleCashPurchaseBean.getLbllocation());
	            
	        	 param.put("doc", new Integer(docno));
		         param.put("brch", new Integer(branch));
		        
		         param.put("printname", multipleCashPurchaseBean.getLblprintname());  
		         param.put("name", multipleCashPurchaseBean.getLblname());
		         param.put("vno", multipleCashPurchaseBean.getLblvoucherno());
		         param.put("descp", multipleCashPurchaseBean.getLbldescription());
		         param.put("vdate", multipleCashPurchaseBean.getLbldate());
		         param.put("amtword", multipleCashPurchaseBean.getLblnetamountwords());
		         param.put("amt", multipleCashPurchaseBean.getLblnetamount());
		         
		         param.put("debtot", multipleCashPurchaseBean.getLbldebittotal());
		         param.put("credtot", multipleCashPurchaseBean.getLblcredittotal());
		         
		         
		         param.put("prepby", multipleCashPurchaseBean.getLblpreparedby());
		         param.put("prepon", multipleCashPurchaseBean.getLblpreparedon());
		         param.put("prepat", multipleCashPurchaseBean.getLblpreparedat());
		         
		         param.put("printby", session.getAttribute("USERNAME"));
		        String path[]=commonDAO.getPrintPath("MCP").split("multiplecashpurchase/");
		        setUrl(path[1]);
		        
	             JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(commonDAO.getPrintPath("MCP")));
         	 
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
				cellarray= multipleCashPurchaseDAO.mcpMainSearch(session, partyname, docNo, date, amount, check);
		
			  } catch (SQLException e) {
				  e.printStackTrace();
				  }
			return cellarray;
		}
		
		public void setData() {
			
			setHidjqxmcpdate(mcpdate.toString());
			setHidmaindate(hidmcpdate.toString());
			setTxtrefno(getTxtrefno());
			
			setTxtdocno(getTxtdocno());
			setTxtaccid(getTxtaccid());
			setTxtaccname(getTxtaccname());
			setHidcmbcurrency(getCmbcurrency());
			setHidcurrencytype(getHidcurrencytype());
			setTxtrate(getTxtrate());
			setSrvtaxper(getSrvtaxper());
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
			multipleCashPurchaseBean=multipleCashPurchaseDAO.getPrint(request,docno,branch,header);
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
			         
			         param.put("compname", multipleCashPurchaseBean.getLblcompname());
			         param.put("compaddress", multipleCashPurchaseBean.getLblcompaddress());
			        
			         param.put("comptel", multipleCashPurchaseBean.getLblcomptel());
			         param.put("compfax", multipleCashPurchaseBean.getLblcompfax());
			         param.put("compbranch", multipleCashPurchaseBean.getLblbranch());
			         param.put("location", multipleCashPurchaseBean.getLbllocation());
	            
	        	 param.put("doc", new Integer(docno));
		         param.put("brch", new Integer(branch));
		        
		         param.put("printname", multipleCashPurchaseBean.getLblprintname());  
		         param.put("name", multipleCashPurchaseBean.getLblname());
		         param.put("vno", multipleCashPurchaseBean.getLblvoucherno());
		         param.put("descp", multipleCashPurchaseBean.getLbldescription());
		         param.put("vdate", multipleCashPurchaseBean.getLbldate());
		         param.put("amtword", multipleCashPurchaseBean.getLblnetamountwords());
		         param.put("amt", multipleCashPurchaseBean.getLblnetamount());
		         
		         param.put("debtot", multipleCashPurchaseBean.getLbldebittotal());
		         param.put("credtot", multipleCashPurchaseBean.getLblcredittotal());
		         
		         
		         param.put("prepby", multipleCashPurchaseBean.getLblpreparedby());
		         param.put("prepon", multipleCashPurchaseBean.getLblpreparedon());
		         param.put("prepat", multipleCashPurchaseBean.getLblpreparedat());
		         
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

