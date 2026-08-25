package com.finance.intercompanytransactions.icpettycash;

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
import java.sql.ResultSet;
import java.sql.Statement;

import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsIcPettyCashAction extends ActionSupport{

	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	
	ClsIcPettyCashDAO icPettyCashDAO= new ClsIcPettyCashDAO();
	ClsIcPettyCashBean icPettyCashBean;

	private int txticpettycashdocno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String icPettyCashDate;
	private String hidicPettyCashDate;
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
		
	//Ic Petty Cash Grid
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

	private Map<String, Object> param=null;
	
	public int getTxticpettycashdocno() {
		return txticpettycashdocno;
	}
	public void setTxticpettycashdocno(int txticpettycashdocno) {
		this.txticpettycashdocno = txticpettycashdocno;
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
	public String getIcPettyCashDate() {
		return icPettyCashDate;
	}
	public void setIcPettyCashDate(String icPettyCashDate) {
		this.icPettyCashDate = icPettyCashDate;
	}
	public String getHidicPettyCashDate() {
		return hidicPettyCashDate;
	}
	public void setHidicPettyCashDate(String hidicPettyCashDate) {
		this.hidicPettyCashDate = hidicPettyCashDate;
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
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	java.sql.Date interCompanyPettyCashDate;
	java.sql.Date hidicpettyCashDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsIcPettyCashBean bean = new ClsIcPettyCashBean();
		interCompanyPettyCashDate = commonDAO.changeStringtoSqlDate(getIcPettyCashDate());
		hidicpettyCashDate = commonDAO.changeStringtoSqlDate(getMaindate());
		
		if(mode.equalsIgnoreCase("A")){
			Connection conn = connDAO.getMyConnection();
			Statement stmtPC = conn.createStatement();
			
			ArrayList<String> icpettycasharray= new ArrayList<String>();
			String mainBranch=session.getAttribute("BRANCHID").toString().trim();
			String mainCompany=session.getAttribute("COMPANYID").toString().trim();
			int interMainCompanyId=0;
			
			/*IC Petty Cash Grid Saving*/
			String sql="SELECT doc_no FROM intercompany.my_intrcomp WHERE cmpid='"+mainCompany+"' and brhid='"+mainBranch+"'";
			ResultSet resultSet = stmtPC.executeQuery(sql);
			while (resultSet.next()) {
				interMainCompanyId = resultSet.getInt("doc_no");
			}
			 
			icpettycasharray.add(getTxtdocno()+"::"+getCmbcurrency()+"::"+getTxtrate()+"::false::"+getTxtamount()*-1+"::"+getTxtdescription()+"::"+getTxtbaseamount()*-1+"::0::0::0:: "+"::"+mainBranch+"::"+interMainCompanyId+"::"+interMainCompanyId);
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0]+"::"+interMainCompanyId;
				icpettycasharray.add(temp);
			}
			/*IC Petty Cash Grid Saving Ends*/
			
						int val=icPettyCashDAO.insert(interCompanyPettyCashDate,getFormdetailcode(),getTxtrefno(),getTxtrate(),getTxtamount(),getTxtdescription(),icpettycasharray,session,request,mode);
						if(val>0.0){
							
							setTxticpettycashdocno(val);
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
			Connection conn = connDAO.getMyConnection();
			Statement stmtPC = conn.createStatement();
			
			ArrayList<String> icpettycasharray= new ArrayList<String>();
			String mainBranch=session.getAttribute("BRANCHID").toString().trim();
			String mainCompany=session.getAttribute("COMPANYID").toString().trim();
			int interMainCompanyId=0;
			
			/*IC Petty Cash Grid Saving*/
			String sql="SELECT doc_no FROM intercompany.my_intrcomp WHERE cmpid='"+mainCompany+"' and brhid='"+mainBranch+"'";
			ResultSet resultSet = stmtPC.executeQuery(sql);
			while (resultSet.next()) {
				interMainCompanyId = resultSet.getInt("doc_no");
			}
			 
			icpettycasharray.add(getTxtdocno()+"::"+getCmbcurrency()+"::"+getTxtrate()+"::false::"+getTxtamount()*-1+"::"+getTxtdescription()+"::"+getTxtbaseamount()*-1+"::0::0::0:: "+"::"+mainBranch+"::"+interMainCompanyId+"::"+interMainCompanyId);
			
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0]+"::"+interMainCompanyId;
				icpettycasharray.add(temp);
			}
			/*Updating IC Petty Cash Grid Ends*/
					
			boolean Status=icPettyCashDAO.edit(getTxticpettycashdocno(),getFormdetailcode(),interCompanyPettyCashDate,getTxtrefno(),getTxtdescription(),getTxtrate(),getTxtamount(),getTxtdocno(),getTxttrno(),icpettycasharray,session,mode);
			if(Status){

				setTxticpettycashdocno(getTxticpettycashdocno());
				setTxttrno(getTxttrno());
				setData();
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setTxticpettycashdocno(getTxticpettycashdocno());
				setTxttrno(getTxttrno());
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("E")){

			boolean Status=icPettyCashDAO.editMaster(getTxticpettycashdocno(),getFormdetailcode(),interCompanyPettyCashDate,getTxtrefno(),getTxtdescription(),getTxtrate(),getTxtamount(),getTxtdocno(),getTxttrno(),session);
			if(Status){

				setTxticpettycashdocno(getTxticpettycashdocno());
				setTxttrno(getTxttrno());
				setData();
				
				setMsg("Updated Successfully");
			    return "success";
		}
		else{
			setTxticpettycashdocno(getTxticpettycashdocno());
			setTxttrno(getTxttrno());
			setData();
			setMsg("Not Updated");
			return "fail";
		}
	  }
		
		else if(mode.equalsIgnoreCase("D")){
					
			boolean Status=icPettyCashDAO.delete(getTxticpettycashdocno(),getTxttrno(),getFormdetailcode(),session);
			if(Status){
				
				setTxticpettycashdocno(getTxticpettycashdocno());
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
			icPettyCashBean=icPettyCashDAO.getViewDetails(session,getTxticpettycashdocno());
			
			setIcPettyCashDate(icPettyCashBean.getIcPettyCashDate());
			setTxtrefno(icPettyCashBean.getTxtrefno());
			
			setTxtdocno(icPettyCashBean.getTxtdocno());
			setTxtaccid(icPettyCashBean.getTxtaccid());
			setTxtaccname(icPettyCashBean.getTxtaccname());
			setHidcmbcurrency(icPettyCashBean.getHidcmbcurrency());
			setHidcurrencytype(icPettyCashBean.getHidcurrencytype());
			setTxtrate(icPettyCashBean.getTxtrate());
			setTxtamount(icPettyCashBean.getTxtamount());
			setTxtbaseamount(icPettyCashBean.getTxtbaseamount());
			setTxtdescription(icPettyCashBean.getTxtdescription());
			setTxttranid(icPettyCashBean.getTxttranid());
			setTxttrno(icPettyCashBean.getTxttrno());
			setMaindate(icPettyCashBean.getMaindate());
			setFormdetailcode(icPettyCashBean.getFormdetailcode());
			
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
		icPettyCashBean=icPettyCashDAO.getPrint(request,docno,branch,header);
		
		setLblmainname("Paid From");
		setUrl(commonDAO.getPrintPath("ICPC"));
		
		setLblcompname(icPettyCashBean.getLblcompname());
		setLblcompaddress(icPettyCashBean.getLblcompaddress());
		setLblpobox(icPettyCashBean.getLblpobox());
		setLblprintname(icPettyCashBean.getLblprintname());
		setLblcomptel(icPettyCashBean.getLblcomptel());
		setLblcompfax(icPettyCashBean.getLblcompfax());
		setLblbranch(icPettyCashBean.getLblbranch());
		setLbllocation(icPettyCashBean.getLbllocation());
		setLblservicetax(icPettyCashBean.getLblservicetax());
		setLblpan(icPettyCashBean.getLblpan());
		setLblcstno(icPettyCashBean.getLblcstno());
		setLblname(icPettyCashBean.getLblname());
		setLblvoucherno(icPettyCashBean.getLblvoucherno());
		setLbldescription(icPettyCashBean.getLbldescription());
		setLbldate(icPettyCashBean.getLbldate());
		setLblnetamount(icPettyCashBean.getLblnetamount());
		setLblnetamountwords(icPettyCashBean.getLblnetamountwords());
		setLbldebittotal(icPettyCashBean.getLbldebittotal());
		setLblcredittotal(icPettyCashBean.getLblcredittotal());
		setLblpreparedby(icPettyCashBean.getLblpreparedby());
		setLblpreparedon(icPettyCashBean.getLblpreparedon());
		setLblpreparedat(icPettyCashBean.getLblpreparedat());
		
		// for hide
		setFirstarray(icPettyCashBean.getFirstarray());
		setTxtheader(icPettyCashBean.getTxtheader());
		
		if(commonDAO.getPrintPath("ICPC").contains(".jrxml")==true)
		{
			HttpServletResponse response = ServletActionContext.getResponse();
			
			Connection conn = null;
			
			try {
				 param = new HashMap();
			
			     conn = connDAO.getMyConnection();
	             Statement stmtPC = conn.createStatement();
					
				 String sql = "select d.brhid,ic.dbname FROM my_cashbm m left join my_cashbd d on m.tr_no=d.tr_no left join intercompany.my_intrcomp ic on ic.doc_no=d.brhid WHERE "
							+ "m.dtype='ICPC' and m.brhId="+branch+" and m.doc_no="+docno+" and d.SR_NO>0";
					
					ResultSet resultSet = stmtPC.executeQuery (sql);
					
					int srno=1;
					String sqlICPettyCash="";
					while(resultSet.next()){
						String dbname=resultSet.getString("dbname");
						
						if(srno==1) {
							sqlICPettyCash+="SELECT CONCAT(ic.compname,' / ',ic.branchname) compbranch,t.account,t.description accountname,c.code currency,d.description accdesc,if(d.amount>0,round((d.amount*1),2),'  ') debit,if(d.amount<0,round((d.amount*-1),2),' ') credit "
										+ "FROM my_cashbm m left join my_cashbd d on m.tr_no=d.tr_no left join "+dbname+".my_costunit f on d.costtype=f.costtype left join "+dbname+".my_head t on d.acno=t.doc_no left join "+dbname+".my_curr c on c.doc_no=d.curId left join "
										+ "intercompany.my_intrcomp ic on ic.doc_no=d.brhid WHERE m.dtype='ICPC' and m.brhId="+branch+" and m.doc_no="+docno+" and d.SR_NO="+srno+"";
						} else {
							sqlICPettyCash+=" UNION ALL SELECT CONCAT(ic.compname,' / ',ic.branchname) compbranch,t.account,t.description accountname,c.code currency,d.description accdesc,if(d.amount>0,round((d.amount*1),2),'  ') debit,if(d.amount<0,round((d.amount*-1),2),' ') credit "
										+ "FROM my_cashbm m left join my_cashbd d on m.tr_no=d.tr_no left join "+dbname+".my_costunit f on d.costtype=f.costtype left join "+dbname+".my_head t on d.acno=t.doc_no left join "+dbname+".my_curr c on c.doc_no=d.curId left join "
										+ "intercompany.my_intrcomp ic on ic.doc_no=d.brhid WHERE m.dtype='ICPC' and m.brhId="+branch+" and m.doc_no="+docno+" and d.SR_NO="+srno+"";
						}
						srno++;
					}
					
	             String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
	             imgpath=imgpath.replace("\\", "\\\\");
	              	
	             param.put("header", new Integer(header));
			     param.put("imgpath", imgpath);
			         
			     param.put("compname", icPettyCashBean.getLblcompname());
			     param.put("compaddress", icPettyCashBean.getLblcompaddress());
			        
			     param.put("comptel", icPettyCashBean.getLblcomptel());
			     param.put("compfax", icPettyCashBean.getLblcompfax());
			     param.put("compbranch", icPettyCashBean.getLblbranch());
			     param.put("location", icPettyCashBean.getLbllocation());
	            
			     param.put("icpettycashsql", sqlICPettyCash);
		        
		         param.put("printname", icPettyCashBean.getLblprintname());  
		         param.put("name", icPettyCashBean.getLblname());
		         param.put("vno", icPettyCashBean.getLblvoucherno());
		         param.put("descp", icPettyCashBean.getLbldescription());
		         param.put("vdate", icPettyCashBean.getLbldate());
		         param.put("amtword", icPettyCashBean.getLblnetamountwords());
		         param.put("amt", icPettyCashBean.getLblnetamount());
		         
		         param.put("debtot", icPettyCashBean.getLbldebittotal());
		         param.put("credtot", icPettyCashBean.getLblcredittotal());
		         
		         
		         param.put("prepby", icPettyCashBean.getLblpreparedby());
		         param.put("prepon", icPettyCashBean.getLblpreparedon());
		         param.put("prepat", icPettyCashBean.getLblpreparedat());
		         
		         param.put("printby", session.getAttribute("USERNAME"));
		         
		         String path[]=commonDAO.getPrintPath("ICPC").split("icpettycash/");
		         setUrl(path[1]);
		        
	             JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(commonDAO.getPrintPath("ICPC")));
         	 
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
				cellarray= icPettyCashDAO.icpcMainSearch(session, partyname, docNo, date, amount, check);
		
			  } catch (SQLException e) {
				  e.printStackTrace();
				  }
			return cellarray;
		}
		
		public void setData() {
			
			setHidicPettyCashDate(interCompanyPettyCashDate.toString());
			setHidmaindate(hidicpettyCashDate.toString());
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

