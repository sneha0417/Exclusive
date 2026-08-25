package com.realestate.tenancycontract;

import java.text.ParseException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import org.apache.struts2.ServletActionContext;

import com.connection.ClsConnection;
import com.common.ClsCommon;
import com.common.ClsAmountToWords;
import com.common.ClsNumberToWord;

public class ClsTenancyContractAction
{
    ClsCommon ClsCommon;
    ClsConnection ClsConnection;
    ClsTenancyContractBean bean;
    ClsTenancyContractDAO dao;
    private String lblcreatedby,lblpostedby,lblmgtype,lblmanage;
    private String renewalstatus,contractdocno;
    private String cmbcommvattype,commvatamount,cmbmgmtvattype,mgmtvatamount,mgmtnettotal,holdingsecurity,hidcmbmgmtvattype,hidcmbcommvattype,chktenancychequeowner,hidchkvatdistributed;
    private String formdetailcode;
    private String mode,lblcltrno,lbladdress,lbltinno;
    private String deleted;
    private String msg,gridqry;
    private String tenancyContractDate;
    private String hidtenancyContractDate;
    private String txttenant;
    private String txtproperty;
   
	private String periodFromDate;
    private String hidperiodFromDate;
    private String periodToDate;
    private String hidPeriodToDate;
    private int masterdoc_no;
    private int cmbtenancytype;
    private int hidcmbtenancytype;
    private int docno;
    private int txttenantdocno;
    private int txtpropertydocno;
    private int cmbcontractperiod;
    private int hidcmbcontractperiod;
    private int txtcontractperiod;
    private int txtnotificationperiod;
    private int termgridlength;
    private int agentgridlength;
    private int paymentgridlength;
    private int mngfeegridlen;
    private String lbldate;
    private String lblcontractno;
    private String lbllandlord;
    private String lbltenant;
    private String lblperiodtenancy;
    private String lblsubjecttenancy;
    private String lblpurposetenancy;
    private String lblfrom;
    private String lblto;
    private String lblrent;
    private String lblrentwords;
    private String lblpayterm;
    private String lblarea;
    private String lblcontactno;
    private String lblpremisesno;
    private String lbldewano;
    private String lblplotno;
    private String lblpassportexp;
    private String lblvisaexp;
    private String lbltradelicenseexp;
    private String lblsecurity;
    private String url;
    private String tenantdet;
    private String propertydet;
    String txtcommisionperc;
    String txtcommisionval;
    String txtnettotal;
    String txtmanagementperc;
    String txtmanagementval;
    String txtadminfeeowner;
    String txtownertotal;
    String txtnumofcheque;
    String txtmngfeeinstmnt;
    
    public ClsTenancyContractAction() {
        ClsCommon = new ClsCommon();
        ClsConnection = new ClsConnection();
        bean = new ClsTenancyContractBean();
        dao = new ClsTenancyContractDAO();
    }
    
    
    public String getLblmanage() {
		return lblmanage;
	}


	public void setLblmanage(String lblmanage) {
		this.lblmanage = lblmanage;
	}


	public String getLblcreatedby() {
		return lblcreatedby;
	}


	public void setLblcreatedby(String lblcreatedby) {
		this.lblcreatedby = lblcreatedby;
	}


	public String getLblpostedby() {
		return lblpostedby;
	}


	public void setLblpostedby(String lblpostedby) {
		this.lblpostedby = lblpostedby;
	}
    public String getRenewalstatus() {
		return renewalstatus;
	}


	public void setRenewalstatus(String renewalstatus) {
		this.renewalstatus = renewalstatus;
	}


	public String getContractdocno() {
		return contractdocno;
	}


	public void setContractdocno(String contractdocno) {
		this.contractdocno = contractdocno;
	}
    public String getHidchkvatdistributed() {
		return hidchkvatdistributed;
	}


	public void setHidchkvatdistributed(String hidchkvatdistributed) {
		this.hidchkvatdistributed = hidchkvatdistributed;
	}


	public String getChktenancychequeowner() {
		return chktenancychequeowner;
	}


	public void setChktenancychequeowner(String chktenancychequeowner) {
		this.chktenancychequeowner = chktenancychequeowner;
	}


	public String getHidcmbmgmtvattype() {
		return hidcmbmgmtvattype;
	}


	public void setHidcmbmgmtvattype(String hidcmbmgmtvattype) {
		this.hidcmbmgmtvattype = hidcmbmgmtvattype;
	}


	public String getHidcmbcommvattype() {
		return hidcmbcommvattype;
	}


	public void setHidcmbcommvattype(String hidcmbcommvattype) {
		this.hidcmbcommvattype = hidcmbcommvattype;
	}


	public String getCmbcommvattype() {
		return cmbcommvattype;
	}


	public void setCmbcommvattype(String cmbcommvattype) {
		this.cmbcommvattype = cmbcommvattype;
	}


	public String getCommvatamount() {
		return commvatamount;
	}


	public void setCommvatamount(String commvatamount) {
		this.commvatamount = commvatamount;
	}


	public String getCmbmgmtvattype() {
		return cmbmgmtvattype;
	}


	public void setCmbmgmtvattype(String cmbmgmtvattype) {
		this.cmbmgmtvattype = cmbmgmtvattype;
	}


	public String getMgmtvatamount() {
		return mgmtvatamount;
	}


	public void setMgmtvatamount(String mgmtvatamount) {
		this.mgmtvatamount = mgmtvatamount;
	}


	public String getMgmtnettotal() {
		return mgmtnettotal;
	}


	public void setMgmtnettotal(String mgmtnettotal) {
		this.mgmtnettotal = mgmtnettotal;
	}


	public String getHoldingsecurity() {
		return holdingsecurity;
	}


	public void setHoldingsecurity(String holdingsecurity) {
		this.holdingsecurity = holdingsecurity;
	}


	public int getMngfeegridlen() {
        return this.mngfeegridlen;
    }
    
    public void setMngfeegridlen( int mngfeegridlen) {
        this.mngfeegridlen = mngfeegridlen;
    }
    
    public String getLbldate() {
        return this.lbldate;
    }
    
    public void setLbldate( String lbldate) {
        this.lbldate = lbldate;
    }
    
    public String getLblcontractno() {
        return this.lblcontractno;
    }
    
    public void setLblcontractno( String lblcontractno) {
        this.lblcontractno = lblcontractno;
    }
    
    public String getLbllandlord() {
        return this.lbllandlord;
    }
    
    public void setLbllandlord( String lbllandlord) {
        this.lbllandlord = lbllandlord;
    }
    
    public String getLbltenant() {
        return this.lbltenant;
    }
    
    public void setLbltenant( String lbltenant) {
        this.lbltenant = lbltenant;
    }
    
    public String getLblperiodtenancy() {
        return this.lblperiodtenancy;
    }
    
    public void setLblperiodtenancy( String lblperiodtenancy) {
        this.lblperiodtenancy = lblperiodtenancy;
    }
    
    public String getLblsubjecttenancy() {
        return this.lblsubjecttenancy;
    }
    
    public void setLblsubjecttenancy( String lblsubjecttenancy) {
        this.lblsubjecttenancy = lblsubjecttenancy;
    }
    
    public String getLblpurposetenancy() {
        return this.lblpurposetenancy;
    }
    
    public void setLblpurposetenancy( String lblpurposetenancy) {
        this.lblpurposetenancy = lblpurposetenancy;
    }
    
    public String getLblfrom() {
        return this.lblfrom;
    }
    
    public void setLblfrom( String lblfrom) {
        this.lblfrom = lblfrom;
    }
    
    public String getLblto() {
        return this.lblto;
    }
    
    public void setLblto( String lblto) {
        this.lblto = lblto;
    }
    
    public String getLblrent() {
        return this.lblrent;
    }
    
    public void setLblrent( String lblrent) {
        this.lblrent = lblrent;
    }
    
    public String getLblrentwords() {
        return this.lblrentwords;
    }
    
    public void setLblrentwords( String lblrentwords) {
        this.lblrentwords = lblrentwords;
    }
    
    public String getLblpayterm() {
        return this.lblpayterm;
    }
    
    public void setLblpayterm( String lblpayterm) {
        this.lblpayterm = lblpayterm;
    }
    
    public String getLblarea() {
        return this.lblarea;
    }
    
    public void setLblarea( String lblarea) {
        this.lblarea = lblarea;
    }
    
    public String getLblcontactno() {
        return this.lblcontactno;
    }
    
    public void setLblcontactno( String lblcontactno) {
        this.lblcontactno = lblcontactno;
    }
    
    public String getLblpremisesno() {
        return this.lblpremisesno;
    }
    
    public void setLblpremisesno( String lblpremisesno) {
        this.lblpremisesno = lblpremisesno;
    }
    
    public String getLbldewano() {
        return this.lbldewano;
    }
    
    public void setLbldewano( String lbldewano) {
        this.lbldewano = lbldewano;
    }
    
    public String getLblplotno() {
        return this.lblplotno;
    }
    
    public void setLblplotno( String lblplotno) {
        this.lblplotno = lblplotno;
    }
    
    public String getLblpassportexp() {
        return this.lblpassportexp;
    }
    
    public void setLblpassportexp( String lblpassportexp) {
        this.lblpassportexp = lblpassportexp;
    }
    
    public String getLblvisaexp() {
        return this.lblvisaexp;
    }
    
    public void setLblvisaexp( String lblvisaexp) {
        this.lblvisaexp = lblvisaexp;
    }
    
    public String getLbltradelicenseexp() {
        return this.lbltradelicenseexp;
    }
    
    public void setLbltradelicenseexp( String lbltradelicenseexp) {
        this.lbltradelicenseexp = lbltradelicenseexp;
    }
    
    public String getLblsecurity() {
        return this.lblsecurity;
    }
    
    public void setLblsecurity( String lblsecurity) {
        this.lblsecurity = lblsecurity;
    }
    
    public String getUrl() {
        return this.url;
    }
    
    public void setUrl( String url) {
        this.url = url;
    }
    
    public int getTermgridlength() {
        return this.termgridlength;
    }
    
    public void setTermgridlength( int termgridlength) {
        this.termgridlength = termgridlength;
    }
    
    public int getAgentgridlength() {
        return this.agentgridlength;
    }
    
    public void setAgentgridlength( int agentgridlength) {
        this.agentgridlength = agentgridlength;
    }
    
    public int getPaymentgridlength() {
        return this.paymentgridlength;
    }
    
    public void setPaymentgridlength( int paymentgridlength) {
        this.paymentgridlength = paymentgridlength;
    }
    
    public String getFormdetailcode() {
        return this.formdetailcode;
    }
    
    public void setFormdetailcode( String formdetailcode) {
        this.formdetailcode = formdetailcode;
    }
    
    public String getMode() {
        return this.mode;
    }
    
    public void setMode( String mode) {
        this.mode = mode;
    }
    
    public String getDeleted() {
        return this.deleted;
    }
    
    public void setDeleted( String deleted) {
        this.deleted = deleted;
    }
    
    public String getMsg() {
        return this.msg;
    }
    
    public void setMsg( String msg) {
        this.msg = msg;
    }
    
    public String getTenancyContractDate() {
        return this.tenancyContractDate;
    }
    
    public void setTenancyContractDate( String tenancyContractDate) {
        this.tenancyContractDate = tenancyContractDate;
    }
    
    public String getHidtenancyContractDate() {
        return this.hidtenancyContractDate;
    }
    
    public void setHidtenancyContractDate( String hidtenancyContractDate) {
        this.hidtenancyContractDate = hidtenancyContractDate;
    }
    
    public String getTxttenant() {
        return this.txttenant;
    }
    
    public void setTxttenant( String txttenant) {
        this.txttenant = txttenant;
    }
    
    public String getTxtproperty() {
        return this.txtproperty;
    }
    
    public void setTxtproperty( String txtproperty) {
        this.txtproperty = txtproperty;
    }
    
    public String getPeriodFromDate() {
        return this.periodFromDate;
    }
    
    public void setPeriodFromDate( String periodFromDate) {
        this.periodFromDate = periodFromDate;
    }
    
    public String getHidperiodFromDate() {
        return this.hidperiodFromDate;
    }
    
    public void setHidperiodFromDate( String hidperiodFromDate) {
        this.hidperiodFromDate = hidperiodFromDate;
    }
    
    public String getPeriodToDate() {
        return this.periodToDate;
    }
    
    public void setPeriodToDate( String periodToDate) {
        this.periodToDate = periodToDate;
    }
    
    public String getHidPeriodToDate() {
        return this.hidPeriodToDate;
    }
    
    public void setHidPeriodToDate( String hidPeriodToDate) {
        this.hidPeriodToDate = hidPeriodToDate;
    }
    
    public int getMasterdoc_no() {
        return this.masterdoc_no;
    }
    
    public void setMasterdoc_no( int masterdoc_no) {
        this.masterdoc_no = masterdoc_no;
    }
    
    public int getCmbtenancytype() {
        return this.cmbtenancytype;
    }
    
    public void setCmbtenancytype( int cmbtenancytype) {
        this.cmbtenancytype = cmbtenancytype;
    }
    
    public int getHidcmbtenancytype() {
        return this.hidcmbtenancytype;
    }
    
    public void setHidcmbtenancytype( int hidcmbtenancytype) {
        this.hidcmbtenancytype = hidcmbtenancytype;
    }
    
    public int getDocno() {
        return this.docno;
    }
    
    public void setDocno( int docno) {
        this.docno = docno;
    }
    
    public int getTxttenantdocno() {
        return this.txttenantdocno;
    }
    
    public void setTxttenantdocno( int txttenantdocno) {
        this.txttenantdocno = txttenantdocno;
    }
    
    public int getTxtpropertydocno() {
        return this.txtpropertydocno;
    }
    
    public void setTxtpropertydocno( int txtpropertydocno) {
        this.txtpropertydocno = txtpropertydocno;
    }
    
    public int getCmbcontractperiod() {
        return this.cmbcontractperiod;
    }
    
    public void setCmbcontractperiod( int cmbcontractperiod) {
        this.cmbcontractperiod = cmbcontractperiod;
    }
    
    public int getHidcmbcontractperiod() {
        return this.hidcmbcontractperiod;
    }
    
    public void setHidcmbcontractperiod( int hidcmbcontractperiod) {
        this.hidcmbcontractperiod = hidcmbcontractperiod;
    }
    
    public int getTxtcontractperiod() {
        return this.txtcontractperiod;
    }
    
    public void setTxtcontractperiod( int txtcontractperiod) {
        this.txtcontractperiod = txtcontractperiod;
    }
    
    public int getTxtnotificationperiod() {
        return this.txtnotificationperiod;
    }
    
    public void setTxtnotificationperiod( int txtnotificationperiod) {
        this.txtnotificationperiod = txtnotificationperiod;
    }
    
    public String getTenantdet() {
        return this.tenantdet;
    }
    
    public void setTenantdet( String tenantdet) {
        this.tenantdet = tenantdet;
    }
    
    public String getPropertydet() {
        return this.propertydet;
    }
    
    public void setPropertydet( String propertydet) {
        this.propertydet = propertydet;
    }
    
    public String getTxtmngfeeinstmnt() {
        return this.txtmngfeeinstmnt;
    }
    
    public void setTxtmngfeeinstmnt( String txtmngfeeinstmnt) {
        this.txtmngfeeinstmnt = txtmngfeeinstmnt;
    }
    
    public String getTxtcommisionperc() {
        return this.txtcommisionperc;
    }
    
    public void setTxtcommisionperc( String txtcommisionperc) {
        this.txtcommisionperc = txtcommisionperc;
    }
    
    public String getTxtcommisionval() {
        return this.txtcommisionval;
    }
    
    public void setTxtcommisionval( String txtcommisionval) {
        this.txtcommisionval = txtcommisionval;
    }
    
    public String getTxtnettotal() {
        return this.txtnettotal;
    }
    
    public void setTxtnettotal( String txtnettotal) {
        this.txtnettotal = txtnettotal;
    }
    
    public String getTxtmanagementperc() {
        return this.txtmanagementperc;
    }
    
    public void setTxtmanagementperc( String txtmanagementperc) {
        this.txtmanagementperc = txtmanagementperc;
    }
    
    public String getTxtmanagementval() {
        return this.txtmanagementval;
    }
    
    public void setTxtmanagementval( String txtmanagementval) {
        this.txtmanagementval = txtmanagementval;
    }
    
    public String getTxtadminfeeowner() {
        return this.txtadminfeeowner;
    }
    
    public void setTxtadminfeeowner( String txtadminfeeowner) {
        this.txtadminfeeowner = txtadminfeeowner;
    }
    
    public String getTxtownertotal() {
        return this.txtownertotal;
    }
    
    public void setTxtownertotal( String txtownertotal) {
        this.txtownertotal = txtownertotal;
    }
    
    public String getTxtnumofcheque() {
        return this.txtnumofcheque;
    }
    
    public void setTxtnumofcheque( String txtnumofcheque) {
        this.txtnumofcheque = txtnumofcheque;
    }
    
    public String getGridqry() {
		return gridqry;
	}


	public void setGridqry(String gridqry) {
		this.gridqry = gridqry;
	}
	
	 public String getLblcltrno() {
			return lblcltrno;
		}


		public void setLblcltrno(String lblcltrno) {
			this.lblcltrno = lblcltrno;
		}


		public String getLbladdress() {
			return lbladdress;
		}


		public void setLbladdress(String lbladdress) {
			this.lbladdress = lbladdress;
		}


		public String getLbltinno() {
			return lbltinno;
		}


		public void setLbltinno(String lbltinno) {
			this.lbltinno = lbltinno;
		}

		public String getLblmgtype() {
			return lblmgtype;
		}

		public void setLblmgtype(String lblmgtype) {
			this.lblmgtype = lblmgtype;
		}
    public void setValues(int docno,int vocno,java.sql.Date sqldate,java.sql.Date sqlfromdate,java.sql.Date sqltodate,HttpSession session) throws SQLException{
    	setHidcmbcommvattype(getCmbcommvattype());
    	setCommvatamount(getCommvatamount());
    	setHidcmbmgmtvattype(getCmbmgmtvattype());
    	setMgmtvatamount(getMgmtvatamount());
    	setMgmtnettotal(getMgmtnettotal());
    	setHoldingsecurity(getHoldingsecurity());
    	setChktenancychequeowner(getChktenancychequeowner());
    	setMasterdoc_no(docno);
    	setDocno(vocno);
    	setHidcmbtenancytype(getCmbtenancytype());
        setHidcmbcontractperiod(getCmbcontractperiod());
        setHidchkvatdistributed(getHidchkvatdistributed());
        if(sqldate!=null){
        	setTenancyContractDate(sqldate.toString());
        }
        if(sqlfromdate!=null){
        	setPeriodFromDate(sqlfromdate.toString());
        }
        if(sqltodate!=null){
        	setPeriodToDate(sqltodate.toString());
        }
        ClsTenancyContractBean temps = new ClsTenancyContractBean();
        temps = dao.getData(docno, session);
        setTenantdet(temps.getTenantdet());
        setLblmanage(temps.getLblmanage());
        //System.out.println("tenant details:"+getTenantdet());
        setPropertydet(temps.getPropertydet());
        setLblcreatedby(temps.getLblcreatedby());
        setLblpostedby(temps.getLblpostedby());
        setHidcmbcommvattype(getCmbcommvattype());
    }
    
    public String saveAction1() throws Exception {
         HttpServletRequest request = ServletActionContext.getRequest();
         HttpSession session = request.getSession();
         Map<String, String[]> requestParams = (Map<String, String[]>)request.getParameterMap();
         ClsTenancyContractDAO ClsTenancyContractDAO = new ClsTenancyContractDAO();
         String reqdocno=request.getParameter("docno")==null?"":request.getParameter("docno");
         if(reqdocno!=null && !reqdocno.trim().equalsIgnoreCase("") && !reqdocno.trim().equalsIgnoreCase("undefined") && !reqdocno.trim().equalsIgnoreCase("0")) {
        	String reqmode=request.getParameter("mode")==null?"":request.getParameter("mode");
        	if(reqmode.trim().equalsIgnoreCase("view")) {
        		String reqbrhid=request.getParameter("reqbrhid")==null?"":request.getParameter("reqbrhid");
        		if(reqbrhid!=null && !reqbrhid.trim().equalsIgnoreCase("") && !reqbrhid.trim().equalsIgnoreCase("undefined") && !reqbrhid.trim().equalsIgnoreCase("0")) {
        			session.setAttribute("BRANCHID", reqbrhid);
        		}
        		setMode(reqmode);
        	}
         }
        if (!getMode().equalsIgnoreCase("view")) {
            ArrayList<String> termarr = null;
            ArrayList<String> agentarr = null;
            ArrayList<String> paymentarr = null;
            ArrayList<String> mngfeearr = null;
            if (getMode().equalsIgnoreCase("A") || getMode().equalsIgnoreCase("E")) {
                termarr = new ArrayList<String>();
                agentarr = new ArrayList<String>();
                paymentarr = new ArrayList<String>();
                mngfeearr = new ArrayList<String>();
                for (int i = 0; i < getTermgridlength(); ++i) {
                     String temp = requestParams.get("term" + i)[0];
                    termarr.add(temp);
                }
                for (int i = 0; i < getAgentgridlength(); ++i) {
                     String temp = requestParams.get("agent" + i)[0];
                    agentarr.add(temp);
                }
                for (int i = 0; i < getPaymentgridlength(); ++i) {
                     String temp = requestParams.get("payment" + i)[0];
                    paymentarr.add(temp);
                }
                for (int i = 0; i < getMngfeegridlen(); ++i) {
                     String temp = requestParams.get("mngfee" + i)[0];
                    mngfeearr.add(temp);
                }
            }
             java.sql.Date masterdate = null;
             java.sql.Date fromdate = null;
             java.sql.Date todate = null;
             if(getTenancyContractDate().contains("/")){
            	 setTenancyContractDate(getTenancyContractDate().replace("/", "."));
             }
             if(getPeriodFromDate().contains("/")){
            	 setPeriodFromDate(getPeriodFromDate().replace("/", "."));
             }
             if(getPeriodToDate().contains("/")){
            	 setPeriodToDate(getPeriodToDate().replace("/", "."));
             }
             if(getTenancyContractDate()!=null && !getTenancyContractDate().equalsIgnoreCase("")){
            	 masterdate=ClsCommon.changeStringtoSqlDate(getTenancyContractDate());
             }
             if(getPeriodFromDate()!=null && !getPeriodFromDate().equalsIgnoreCase("")){
            	 fromdate=ClsCommon.changeStringtoSqlDate(getPeriodFromDate());
             }
             if(getPeriodToDate()!=null && !getPeriodToDate().equalsIgnoreCase("")){
            	 todate=ClsCommon.changeStringtoSqlDate(getPeriodToDate());
             }
             int value = ClsTenancyContractDAO.savemaster(masterdate, getMasterdoc_no(), getMode(), getCmbtenancytype(), 
            		getTxttenantdocno(), getTxtpropertydocno(), getCmbcontractperiod(), getTxtcontractperiod(), fromdate, 
            		todate, getTxtnotificationperiod(), session, request, getFormdetailcode(), termarr, agentarr, paymentarr, 
            		getTxtcommisionperc(), getTxtcommisionval(), getTxtnettotal(), getTxtmanagementperc(), 
            		getTxtmanagementval(), getTxtadminfeeowner(), getTxtownertotal(), getTxtnumofcheque(), mngfeearr, 
            		getTxtmngfeeinstmnt(),getCmbcommvattype(),getCommvatamount(),getCmbmgmtvattype(),getMgmtvatamount(),getMgmtnettotal(),
            		getHoldingsecurity(),getHidchkvatdistributed(),getRenewalstatus(),getContractdocno());
            System.out.println("tenantsaved= " + value);
            if (getMode().equalsIgnoreCase("A")) {
                if (value > 0) {
                	int vdocno = (int)request.getAttribute("vocno");
                	setValues(value,vdocno,masterdate,fromdate,todate,session);
                    setMsg("Successfully Saved");
                    return "success";
                }
                setValues(value,0,masterdate,fromdate,todate,session);
                setMsg("Not Saved");
                return "fail";
            }
            else if (getMode().equalsIgnoreCase("E")) {
                if (value > 0) {
                	setValues(getMasterdoc_no(),getDocno(),masterdate,fromdate,todate,session);
                    setMsg("Updated Successfully");
                    return "success";
                }
                setValues(getMasterdoc_no(),getDocno(),masterdate,fromdate,todate,session);
                setMsg("Not Updated");
                return "fail";
            }
            else if (getMode().equalsIgnoreCase("D")) {
                if (value > 0) {
                	setValues(getMasterdoc_no(),getDocno(),masterdate,fromdate,todate,session);
                    setDeleted("DELETED");
                    setMsg("Successfully Deleted");
                    return "success";
                }
                setValues(getMasterdoc_no(),getDocno(),masterdate,fromdate,todate,session);
                setMsg("Not Deleted");
                setDeleted("");
                return "fail";
            }
        }
        else if (getMode().equalsIgnoreCase("view")) {
            ClsTenancyContractBean temps2 = new ClsTenancyContractBean();
            String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
            if(!docno.equalsIgnoreCase("") && !docno.equalsIgnoreCase("0")){
            	setDocno(Integer.parseInt(docno));
            }
            temps2 = ClsTenancyContractDAO.getData(getDocno(), session);
            setLblcreatedby(temps2.getLblcreatedby());
            setLblpostedby(temps2.getLblpostedby());
            setHidchkvatdistributed(temps2.getHidchkvatdistributed());
            setHidcmbcommvattype(temps2.getHidcmbcommvattype());
            setCommvatamount(temps2.getCommvatamount());
            setHidcmbmgmtvattype(temps2.getHidcmbmgmtvattype());
            setMgmtvatamount(temps2.getMgmtvatamount());
            setMgmtnettotal(temps2.getMgmtnettotal());
            setHoldingsecurity(temps2.getHoldingsecurity());
            setDocno(getDocno());
            setMasterdoc_no(temps2.getMasterdoc_no());
            setTenancyContractDate(temps2.getTenancyContractDate());
            setTxttenant(temps2.getTxttenant());
            setTxttenantdocno(temps2.getTxttenantdocno());
            setTxtproperty(temps2.getTxtproperty());
            setTxtpropertydocno(temps2.getTxtpropertydocno());
            setHidcmbtenancytype(temps2.getHidcmbtenancytype());
            setHidcmbcontractperiod(temps2.getHidcmbcontractperiod());
            setPeriodFromDate(temps2.getPeriodFromDate());
            setPeriodToDate(temps2.getPeriodToDate());
            setTxtnotificationperiod(temps2.getTxtnotificationperiod());
            setTxtcontractperiod(temps2.getTxtcontractperiod());
            setTenantdet(temps2.getTenantdet());
            setLblmanage(temps2.getLblmanage());
            setPropertydet(temps2.getPropertydet());
            setTxtcommisionperc(temps2.getTxtcommisionperc());
            setTxtcommisionval(temps2.getTxtcommisionval());
            setTxtnettotal(temps2.getTxtnettotal());
            setTxtmanagementperc(temps2.getTxtmanagementperc());
            setTxtmanagementval(temps2.getTxtmanagementval());
            setTxtadminfeeowner(temps2.getTxtadminfeeowner());
            setTxtownertotal(temps2.getTxtownertotal());
            setTxtnumofcheque(temps2.getTxtnumofcheque());
            setTxtmngfeeinstmnt(temps2.getTxtmngfeeinstmnt());
            setChktenancychequeowner(temps2.getChktenancychequeowner());
            return "success";
        }
        return "fail";
    }
    
    public String printAction() throws ParseException, SQLException {
    	HttpServletRequest request = ServletActionContext.getRequest();
        HttpSession session = request.getSession();
        int doc = Integer.parseInt(request.getParameter("docno"));
        int print = Integer.parseInt(request.getParameter("print"));
        String dtype = request.getParameter("dtype");
       bean = dao.getPrint(doc, request, session, print);
       setMasterdoc_no(bean.getMasterdoc_no());
       
       
       if(print==1) {
    	   setUrl("com/realestate/tenancycontract/tenancyCtrtProformaRcptPrintWhiteStar.jrxml"); 
       }
       if(print==2) {
    	//   setUrl("com/realestate/tenancycontract/tenancyCtrtProformaInvPrintWhiteStar.jrxml");
    	   setUrl(ClsCommon.getPrintPath(dtype));
    	   
       }
       //System.out.println("====== "+getUrl());
       setLbldate(bean.getLbldate());
       setLblcontractno(bean.getLblcontractno());
       setLbllandlord(bean.getLbllandlord());
       setLbltenant(bean.getLbltenant());
       setLblperiodtenancy(bean.getLblperiodtenancy());
       setLblpurposetenancy(bean.getLblpurposetenancy());
       setLblsubjecttenancy(bean.getLblsubjecttenancy());
       setLblfrom(bean.getLblfrom());
       setLblto(bean.getLblto());
       setLblrent(bean.getLblrent());
       setLblrentwords(bean.getLblrentwords());
       setLblcontactno(bean.getLblcontactno());
       setLblpremisesno(bean.getLblpremisesno());
       setLbldewano(bean.getLbldewano());
       setLblplotno(bean.getLblplotno());
       setLblarea(bean.getLblarea());
       setLblpassportexp(bean.getLblpassportexp());
       setLblvisaexp(bean.getLblvisaexp());
       setLbltradelicenseexp(bean.getLbltradelicenseexp());
       setLblsecurity(bean.getLblsecurity());
       setGridqry(bean.getGridqry());
       setLblcltrno(bean.getLblcltrno());
       setLbladdress(bean.getLbladdress());
       setLbltinno(bean.getLbltinno());
       setLblmgtype(bean.getLblmgtype());
       String imgpath=request.getSession().getServletContext().getRealPath("/icons/IGLOGO1.jpg");
		 imgpath=imgpath.replace("\\", "\\\\");
	   String headerimge11=request.getSession().getServletContext().getRealPath("/icons/IGLOGO.jpg");
         headerimge11=headerimge11.replace("\\", "\\\\");
       if(getUrl().contains(".jrxml")==true){
   		HttpServletResponse response = ServletActionContext.getResponse();
   	    
   		HashMap<String,String> param = new HashMap<String,String>();
   		Connection conn = null;
   		String reportFileName = "CreditInvoice";
   	
   		conn = ClsConnection.getMyConnection();
   		try {    
                        param.put("docs", doc+"");  
               
                        Statement stmtprint = conn.createStatement();
                       // ClsAmountToWords awdao=new ClsAmountToWords();
                        String curId="1";
   			String invqry="select @i:=@i+1 rws,a.* from(select m.description,case when d.taxtype='Inclusive' then round(d.amount-d.taxvalue,2) else round(d.amount,2) end amount,if(d.taxvalue>0,5,0) taxrate,round(d.taxvalue,2) vatamt,round(d.nettotal,2) nettotal from rl_tncterms d  left join rl_terms_contract m on d.idno=m.idno where d.rdocno='"+docno+"')a,(select @i:=0)c";
   		 Double gridtotal=0.00;
         String sql2="select round(sum(nettotal),2)net from rl_tncterms where rdocno='"+docno+"'";
        // System.out.println("sql2-"+sql2);
        
         String griddtotal="";
         ResultSet resultSet3 = stmtprint.executeQuery(sql2);
         while (resultSet3.next()) {
         	gridtotal+=resultSet3.getDouble("net");
         	griddtotal=resultSet3.getString("net");
         }
         String strgetcommission="select round(case when tnc.commissionvattype='Inclusive' then tnc.commisionamt else tnc.commisionamt+tnc.commissionvatvalue end,2) commtotal from rl_tncm tnc where status=3 and doc_no="+docno;
        // System.out.println("strgetcommission-"+strgetcommission);
         ResultSet rsgetcommission=stmtprint.executeQuery(strgetcommission);
       
         while(rsgetcommission.next()){
         	gridtotal+=rsgetcommission.getDouble("commtotal"); 
        	griddtotal=rsgetcommission.getString("commtotal");
         }
         ClsAmountToWords awdao=new ClsAmountToWords();  
         ClsNumberToWord awdas=new ClsNumberToWord();
        // System.out.println("gridtotal-"+gridtotal+"-number to words"+awdao.convertAmountToWordsWithCurr(String.format("%.2f", gridtotal),curId));
        bean.setLblrentwords(awdao.convertAmountToWordsWithCurr(String.format("%.2f", gridtotal),curId));
         //wordamount= awdao.convertAmountToWordsWithCurr(String.valueOf(nettotaltaxadd),curId);
         //nettotaltok 
        //System.out.println("totalbefovatamt==="+roundvalue);
        // param.put("amountinwordsTo",amtwords);
   			//param.put("docno", getDocno());
   			 //param.put("printname", getLblprintnameakamal());
         param.put("amountinwordsObj",awdao+"");
   			 param.put("amountinwords", bean.getLblrentwords());  
   			 param.put("from", bean.getLblfrom()); 
   			 param.put("to", bean.getLblto());
   			 param.put("tenant", bean.getLbltenant());
   			 param.put("address", bean.getLbladdress());    
   			 param.put("cltrno", bean.getLblcltrno());
   			 param.put("invno", bean.getLblcontractno());
   			 param.put("invdate", bean.getLbldate());
   			 param.put("trno", bean.getLbltinno());
   			 param.put("invqrry", bean.getGridqry());
   			 param.put("propname", bean.getLblpropname());
   	if(getLblmgtype().equalsIgnoreCase("1")){ 
       	  param.put("cmpname", "Exclusive Links Leasing and Property Management");
       	  param.put("cmplogo", headerimge11);
       	  param.put("bdetail1", "All cheques payable to: Exclusive Links Leasing And Property Management");
   		  param.put("bdetail2", "Account Name :Exclusive Links Leasing and Property Management");
   		  param.put("bdetail3", "Account No : 1015110813701");
   		  param.put("bdetail4", "IBAN : AE270260001015110813701 Swift Code : EBILAEAD");
   		  param.put("bdetail5", "Bank : Emirates NBD , SATWA BRANCH ,P.O. BOX: 777 ,DUBAI, UAE");
   		  param.put("invqrry2", bean.getGridqry());
      }else{
	   	  param.put("cmpname", "Exclusive Links Real Estate Brokers");
		  param.put("cmplogo", imgpath);
		  param.put("bdetail1", "All cheques payable to: EXCLUSIVE LINKS REAL ESTATE BROKERS");
	   	  param.put("bdetail2", "Account Name :EXCLUSIVE LINKS REAL ESTATE BROKERS");
	   	  param.put("bdetail3", "Account Number: 101 3470043 01");
	   	  param.put("bdetail4", "IBAN Number: AE850260001011347004301 Swift Code : EBILAEAD");
	   	  param.put("bdetail5", "Bank : EMIRATES NBD ,JUMEIRAH BRANCH ,P.O. BOX 11909 , DUBAI, UAE");
	   	  param.put("invqrry2", bean.getGridqry2());
     }
   			
   	System.out.println("getUrl---"+getUrl());
       ClsCommon com=new ClsCommon();
		 //System.out.println("In INVOICE PRINT JRXML");   
		JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(getUrl()));
		 JasperReport jasperReport = JasperCompileManager.compileReport(design);
		 generateReportPDF(response, param, jasperReport, conn);
		 conn.close();
   		}
   		catch(Exception e){
  			 conn.close();
  			 e.printStackTrace();
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