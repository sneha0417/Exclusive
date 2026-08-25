package com.dashboard.projectexecution.invoiceProcessing;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
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
import com.common.ClsNumberToWord;
import com.connection.ClsConnection;
import com.ibm.icu.text.DecimalFormat;
import com.mailwithpdf.SendEmailAction;
import com.project.execution.projectInvoice.ClsProjectInvoiceDAO;
public class ClsInvoiceProcessingAction {

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon common =new ClsCommon();

	ClsProjectInvoiceDAO DAO= new ClsProjectInvoiceDAO();


	private int invgridlength;
	private String mode;
	private String formcode;
	private String clientid;
	private String msg;
	private String detail;
	private String detailname;
	private String todate;
	private String invdate;
	private String ptype;
	private String txtdesc;
	private String txtnotes;
	private String hiddeninterstate;
	private String countdtype;
	public String getCountdtype() {
		return countdtype;
	}
	public void setCountdtype(String countdtype) {
		this.countdtype = countdtype;
	}
	public String getHiddeninterstate() {
		return hiddeninterstate;
	}
	public void setHiddeninterstate(String hiddeninterstate) {
		this.hiddeninterstate = hiddeninterstate;
	}
	
	public String getTxtnotes() {
		return txtnotes;
	}
	public void setTxtnotes(String txtnotes) {
		this.txtnotes = txtnotes;
	}
	public String getTxtdesc() {
		return txtdesc;
	}
	public void setTxtdesc(String txtdesc) {
		this.txtdesc = txtdesc;
	}
	public String getPtype() {
		return ptype;
	}
	public void setPtype(String ptype) {
		this.ptype = ptype;
	}
	public int getInvgridlength() {
		return invgridlength;
	}
	public void setInvgridlength(int invgridlength) {
		this.invgridlength = invgridlength;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getFormcode() {
		return formcode;
	}
	public void setFormcode(String formcode) {
		this.formcode = formcode;
	}
	public String getClientid() {
		return clientid;
	}
	public void setClientid(String clientid) {
		this.clientid = clientid;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public String getDetailname() {
		return detailname;
	}
	public void setDetailname(String detailname) {
		this.detailname = detailname;
	}
	public String getTodate() {
		return todate;
	}
	public void setTodate(String todate) {
		this.todate = todate;
	}
	public String getInvdate() {
		return invdate;
	}
	public void setInvdate(String invdate) {
		this.invdate = invdate;
	}
private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	public String saveInvAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();

		Map<String, String[]> requestParams = request.getParameterMap();

		//			System.out.println("==inside saveInvAction");

		session.getAttribute("BranchName");
		Connection conn =null;
		String retunrns="";
		String invno="";

		int docNo=0,vocno=0,tr_no=0,doc_no=0,clientid=0,cpersonid=0,costid=0,contractno=0;
		String dtype="",refdtype="",otype="",client="",contrtype="",refno="",clientdet="",desc="",branchid="0",clacno="0",
				legalamt="0.0",seramt="0.0",exptotal="0.0",nettotal="0.0",mode="",pdid="0",ptype="",schid="0",inctax="0",nontax="0";
		double contramt=0.0,legalfee=0.0,tobeinvamt=0.0,dueamt=0.0,netamount=0.0,expamt=0.0,legamt=0.0,netotal=0.0,taxamt=0.0,taxtot=0.0;

		ArrayList<String> enqarray= new ArrayList();
		ArrayList<String> exparray = new ArrayList();

		java.sql.Date sqldate,duedate,sdate,edate;


		try{

			ArrayList invoiceList = new ArrayList();
			ArrayList retList = new ArrayList();
			ArrayList taxlist = new ArrayList();
			int val=0;

			java.sql.Date date=common.changeStringtoSqlDate(getInvdate());

			for(int i=0;i<getInvgridlength();i++){

				String temp=requestParams.get("pinv"+i)[0];		
				invoiceList.add(temp);
			}
System.out.println("invoiceList==="+invoiceList);
			if(getPtype().equalsIgnoreCase("1")){
				for(int j=0;j<invoiceList.size();j++){

					String[] surveydet=((String) invoiceList.get(j)).split("::");
					 taxtot=0.0;

					if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
					{


						costid=(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:Integer.parseInt(surveydet[0].trim()));

						contractno=(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:Integer.parseInt(surveydet[1].trim()));

						contrtype=(String) (surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?"0":surveydet[2].trim().toString());

						//duedate=(Date) (surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:common.changetstmptoSqlDate(surveydet[3].toString().trim()));

						contramt=(surveydet[5].trim().equalsIgnoreCase("undefined") || surveydet[5].trim().equalsIgnoreCase("NaN")|| surveydet[5].trim().equalsIgnoreCase("")|| surveydet[5].isEmpty()?0:Double.parseDouble(surveydet[5].trim().toString()));

						exptotal=(surveydet[6].trim().equalsIgnoreCase("undefined") || surveydet[6].trim().equalsIgnoreCase("NaN")|| surveydet[6].trim().equalsIgnoreCase("")|| surveydet[6].isEmpty()?"0":surveydet[6].trim().toString());

						seramt=(surveydet[7].trim().equalsIgnoreCase("undefined") || surveydet[7].trim().equalsIgnoreCase("NaN")|| surveydet[7].trim().equalsIgnoreCase("")|| surveydet[7].isEmpty()?"0":surveydet[7].trim().toString());

						legalamt=(String) (surveydet[9].trim().equalsIgnoreCase("undefined") || surveydet[9].trim().equalsIgnoreCase("NaN")|| surveydet[9].trim().equalsIgnoreCase("")|| surveydet[9].isEmpty()?"0":surveydet[9].trim().toString());

						client=(String) (surveydet[10].trim().equalsIgnoreCase("undefined") || surveydet[10].trim().equalsIgnoreCase("NaN")|| surveydet[10].trim().equalsIgnoreCase("")|| surveydet[10].isEmpty()?"0":surveydet[10].trim().toString());

						clacno=(String) (surveydet[11].trim().equalsIgnoreCase("undefined") || surveydet[11].trim().equalsIgnoreCase("NaN")|| surveydet[11].trim().equalsIgnoreCase("")|| surveydet[11].isEmpty()?"0":surveydet[11].trim());

						//sdate= (Date) (surveydet[11].trim().equalsIgnoreCase("undefined") || surveydet[11].trim().equalsIgnoreCase("NaN")|| surveydet[11].trim().equalsIgnoreCase("")|| surveydet[11].isEmpty()?0:common.changetstmptoSqlDate(surveydet[11].toString().trim()));

						//edate= (Date) (surveydet[12].trim().equalsIgnoreCase("undefined") || surveydet[12].trim().equalsIgnoreCase("NaN")|| surveydet[12].trim().equalsIgnoreCase("")|| surveydet[12].isEmpty()?0:common.changetstmptoSqlDate(surveydet[12].toString().trim()));

						clientid=(surveydet[15].trim().equalsIgnoreCase("undefined") || surveydet[15].trim().equalsIgnoreCase("NaN")|| surveydet[15].trim().equalsIgnoreCase("")|| surveydet[15].isEmpty()?0:Integer.parseInt(surveydet[15].trim()));

						refno=(String) (surveydet[16].trim().equalsIgnoreCase("undefined") || surveydet[16].trim().equalsIgnoreCase("NaN")|| surveydet[16].trim().equalsIgnoreCase("")|| surveydet[16].isEmpty()?" ":surveydet[16].trim());

						branchid=(surveydet[14].trim().equalsIgnoreCase("undefined") || surveydet[14].trim().equalsIgnoreCase("NaN")|| surveydet[14].trim().equalsIgnoreCase("")|| surveydet[14].isEmpty()?"0":surveydet[14].trim());

						pdid=(String) (surveydet[17].trim().equalsIgnoreCase("undefined") || surveydet[17].trim().equalsIgnoreCase("NaN")|| surveydet[17].trim().equalsIgnoreCase("")|| surveydet[17].isEmpty()?" ":surveydet[17].trim());

						ptype=(String) (surveydet[18].trim().equalsIgnoreCase("undefined") || surveydet[18].trim().equalsIgnoreCase("NaN")|| surveydet[18].trim().equalsIgnoreCase("")|| surveydet[18].isEmpty()?" ":surveydet[18].trim());

						inctax=(String) (surveydet[19].trim().equalsIgnoreCase("undefined") || surveydet[19].trim().equalsIgnoreCase("NaN")|| surveydet[19].trim().equalsIgnoreCase("")|| surveydet[19].isEmpty()?" ":surveydet[19].trim());
						nontax=(String) (surveydet[20].trim().equalsIgnoreCase("undefined") || surveydet[20].trim().equalsIgnoreCase("NaN")|| surveydet[20].trim().equalsIgnoreCase("")|| surveydet[20].isEmpty()?" ":surveydet[20].trim());

						mode="A";
						dtype="PJIV";

						//netamount=Double.parseDouble(exptotal)+Double.parseDouble(seramt)+Double.parseDouble(legalamt);
						if(j>0)
						{
							exptotal="0";
						}
						
						netamount=Double.parseDouble(seramt)+Double.parseDouble(legalamt)+Double.parseDouble(exptotal);

						if(inctax.equalsIgnoreCase("0")){
							taxlist=DAO.getTax(session,netamount,date,getHiddeninterstate(),clientid);

						}
						else if((inctax.equalsIgnoreCase("1"))){
							taxlist=DAO.getinclusiveTax(session,netamount,date,getHiddeninterstate(),clientid);
						}

						//taxlist=DAO.getTax(session,netamount,date);

						for(int t=0;t<taxlist.size();t++){

							String[] tmp=((String) taxlist.get(t)).split("::");

							taxamt=Double.parseDouble(tmp[3]);
							taxtot=taxtot+taxamt;

						}
						System.out.println("======== "+exptotal);
						 val=DAO.insert(date,refno,contrtype,contractno,client,clientdet,getTxtdesc(),branchid,clacno,clientid,
								costid,enqarray,exparray,session,mode,dtype,request,
								legalamt,seramt,exptotal,inctax,pdid,getTxtnotes(),ptype,taxtot,taxlist,nontax);

						

					}
					retList.add(contrtype+":"+contractno);

				}

			}
			else if(getPtype().equalsIgnoreCase("2")){


				for(int j=0;j<invoiceList.size();j++){

					String[] surveydet=((String) invoiceList.get(j)).split("::");

					if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
					{


						costid=(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:Integer.parseInt(surveydet[0].trim()));

						contractno=(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:Integer.parseInt(surveydet[1].trim()));

						contrtype=(String) (surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?"0":surveydet[2].trim().toString());

						//duedate=(Date) (surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:common.changetstmptoSqlDate(surveydet[3].toString().trim()));

						contramt=(surveydet[5].trim().equalsIgnoreCase("undefined") || surveydet[5].trim().equalsIgnoreCase("NaN")|| surveydet[5].trim().equalsIgnoreCase("")|| surveydet[5].isEmpty()?0:Double.parseDouble(surveydet[5].trim().toString()));

						exptotal=(surveydet[6].trim().equalsIgnoreCase("undefined") || surveydet[6].trim().equalsIgnoreCase("NaN")|| surveydet[6].trim().equalsIgnoreCase("")|| surveydet[6].isEmpty()?"0":surveydet[6].trim().toString());

						seramt=(surveydet[7].trim().equalsIgnoreCase("undefined") || surveydet[7].trim().equalsIgnoreCase("NaN")|| surveydet[7].trim().equalsIgnoreCase("")|| surveydet[7].isEmpty()?"0":surveydet[7].trim().toString());

						legalamt=(String) (surveydet[9].trim().equalsIgnoreCase("undefined") || surveydet[9].trim().equalsIgnoreCase("NaN")|| surveydet[9].trim().equalsIgnoreCase("")|| surveydet[9].isEmpty()?"0":surveydet[9].trim().toString());

						client=(String) (surveydet[10].trim().equalsIgnoreCase("undefined") || surveydet[10].trim().equalsIgnoreCase("NaN")|| surveydet[10].trim().equalsIgnoreCase("")|| surveydet[10].isEmpty()?"0":surveydet[10].trim().toString());

						clacno=(String) (surveydet[11].trim().equalsIgnoreCase("undefined") || surveydet[11].trim().equalsIgnoreCase("NaN")|| surveydet[11].trim().equalsIgnoreCase("")|| surveydet[11].isEmpty()?"0":surveydet[11].trim());

						//sdate= (Date) (surveydet[11].trim().equalsIgnoreCase("undefined") || surveydet[11].trim().equalsIgnoreCase("NaN")|| surveydet[11].trim().equalsIgnoreCase("")|| surveydet[11].isEmpty()?0:common.changetstmptoSqlDate(surveydet[11].toString().trim()));

						//edate= (Date) (surveydet[12].trim().equalsIgnoreCase("undefined") || surveydet[12].trim().equalsIgnoreCase("NaN")|| surveydet[12].trim().equalsIgnoreCase("")|| surveydet[12].isEmpty()?0:common.changetstmptoSqlDate(surveydet[12].toString().trim()));

						clientid=(surveydet[15].trim().equalsIgnoreCase("undefined") || surveydet[15].trim().equalsIgnoreCase("NaN")|| surveydet[15].trim().equalsIgnoreCase("")|| surveydet[15].isEmpty()?0:Integer.parseInt(surveydet[15].trim()));

						refno=(String) (surveydet[16].trim().equalsIgnoreCase("undefined") || surveydet[16].trim().equalsIgnoreCase("NaN")|| surveydet[16].trim().equalsIgnoreCase("")|| surveydet[16].isEmpty()?" ":surveydet[16].trim());

						branchid=(surveydet[14].trim().equalsIgnoreCase("undefined") || surveydet[14].trim().equalsIgnoreCase("NaN")|| surveydet[14].trim().equalsIgnoreCase("")|| surveydet[14].isEmpty()?"0":surveydet[14].trim());

						pdid=(String) (surveydet[17].trim().equalsIgnoreCase("undefined") || surveydet[17].trim().equalsIgnoreCase("NaN")|| surveydet[17].trim().equalsIgnoreCase("")|| surveydet[17].isEmpty()?" ":surveydet[17].trim());

						ptype=(String) (surveydet[18].trim().equalsIgnoreCase("undefined") || surveydet[18].trim().equalsIgnoreCase("NaN")|| surveydet[18].trim().equalsIgnoreCase("")|| surveydet[18].isEmpty()?" ":surveydet[18].trim());

						inctax=(String) (surveydet[19].trim().equalsIgnoreCase("undefined") || surveydet[19].trim().equalsIgnoreCase("NaN")|| surveydet[19].trim().equalsIgnoreCase("")|| surveydet[19].isEmpty()?" ":surveydet[19].trim());
						nontax=(String) (surveydet[20].trim().equalsIgnoreCase("undefined") || surveydet[20].trim().equalsIgnoreCase("NaN")|| surveydet[20].trim().equalsIgnoreCase("")|| surveydet[20].isEmpty()?" ":surveydet[20].trim());
						mode="A";
						dtype="PJIV";

						dueamt=dueamt+Double.parseDouble(seramt);
						expamt=expamt+Double.parseDouble(exptotal);
						legamt=legamt+Double.parseDouble(legalamt);

						schid=schid+","+pdid;

						netamount=Double.parseDouble(exptotal)+Double.parseDouble(seramt)+Double.parseDouble(legalamt);

						netotal=netotal+netamount;


						nettotal=netamount+"";


					}



				}
				if(nontax.equalsIgnoreCase("1")){

				if(inctax.equalsIgnoreCase("0")){
					taxlist=DAO.getTax(session,netotal,date,getHiddeninterstate(),clientid);

				}
				else if((inctax.equalsIgnoreCase("1"))){
					taxlist=DAO.getinclusiveTax(session,netotal,date,getHiddeninterstate(),clientid);
				}

			//	taxlist=DAO.getTax(session,netotal,date);

//				System.out.println("==netamount===taxlist.size()="+netamount+taxlist.size());

				for(int t=0;t<taxlist.size();t++){

					String[] tmp=((String) taxlist.get(t)).split("::");

//					System.out.println("==tmp===="+tmp.length);

					taxamt=Double.parseDouble(tmp[3]);
					taxtot=taxtot+taxamt;
					netotal=netotal;
				}
				}
				nettotal=netotal+"";
				seramt=dueamt+"";
				exptotal=expamt+"";
				legalamt=legamt+"";


				if (schid.trim().endsWith(",")) {
					pdid = schid.trim().substring(0,schid.length() - 1);
				}

				//				System.out.println("===schid====="+pdid);

				 val=DAO.insert(date,refno,contrtype,contractno,client,clientdet,getTxtdesc(),branchid,clacno,clientid,
						costid,enqarray,exparray,session,mode,dtype,request,
						legalamt,seramt,exptotal,inctax,schid,getTxtnotes(),ptype,taxtot,taxlist,nontax);

				retList.add(contrtype+":"+contractno);

			}

			if(val>0){

				for(int i=0;i<retList.size();i++){

					if(retList.size()==1){
						invno=retList.get(i).toString();
					}
					else{
						invno=retList.get(i)+","+invno;
					}



				}

				if (invno.trim().endsWith(",")) {
					invno = invno.trim().substring(0,invno.length() - 1);
				}



				setDetail("Project Execution");
				setTxtdesc("");
				setTxtnotes("");
				setCountdtype(getCountdtype());
				setDetailname("Service Invoice Processing");
				setMsg("Invoice No: "+request.getAttribute("docno")+" Successfully Generated");
				retunrns="success";
			}
			else if(val<=0){
				setDetail("Project Execution");
				setCountdtype(getCountdtype());
				setDetailname("Service Invoice Processing");
				setMsg("Invoice Not Generated");
				retunrns="fail";
			}

		}
		catch(Exception e){
			e.printStackTrace();
		}

		return retunrns;

	}
	
	//invoiceprocessing print
	
	public void printActionJasper() throws ParseException, SQLException{
		
		System.out.println("Inside invoice print==");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
	    HttpServletResponse response = ServletActionContext.getResponse();
	 
		String dtype=request.getParameter("dtype")==null?"":request.getParameter("dtype");
		String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
		String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");
		String amount=request.getParameter("amount")==null?"0":request.getParameter("amount");
		String invdate=request.getParameter("invdate")==null?"":request.getParameter("invdate");
		String trno=request.getParameter("trno")==null?"":request.getParameter("trno");
		String sitenew=request.getParameter("site")==null?"":request.getParameter("site");
	ArrayList<String> al=new ArrayList();
	Set st=new HashSet();
	String site="";
		
		String sitearr[]=sitenew.split("::");
		for(int i=1;i<sitearr.length;i++)
		{
			al.add(sitearr[i]);
		}
		for(int i=0;i<al.size();i++)
		{
			st.add(al.get(i));
		}
		
		if(st.size()>1)
		{
			site="";
		}
		else{
			String sitess[]=sitearr[1].split(",");
			site=sitess[0];
		}
		Double totalamt=Double.parseDouble(amount);
		String reportFileName = "HVLInvoicePrint";
		 param = new HashMap();
		 Connection conn = null;
		 try {
	          
             	 conn = ClsConnection.getMyConnection();
             	Statement stmt = conn.createStatement();
             	String clientname="";
             	String clientaddress="";
             	String tinno="";
        	 
        	 String detailsql="select coalesce(refname,'') client,coalesce(address,'') as details,coalesce(tinno,'') as tinno from my_acbook "
        	 		+ "where cldocno='"+cldocno+"' and dtype='CRM' and status=3  ";
        	 ResultSet  clintdet=stmt.executeQuery(detailsql);
				while(clintdet.next()){
					clientname=clintdet.getString("client");
					clientaddress=clintdet.getString("details");
					tinno=clintdet.getString("tinno");
				}
				 param.put("printname", "INVOICE");
				 String taxqry="select @i:=@i+1 srno,a.* from (select 'Pest control charges - Billed'as particular,'' as qty,'' as rate,'' as per,round("+amount+",2) as Amt "
							+ "union all "
							+"select '' as particular ,'' as qty,'' as rate,'' as per,'' as Amt ) a,(select @i:=0)r ";
				 ClsNumberToWord ClsNumberToWord=new ClsNumberToWord();
					String amuntwrd=ClsNumberToWord.convertNumberToWords(totalamt);
					DecimalFormat df = new DecimalFormat("#.00"); 
					
					param.put("amntword", amuntwrd);
					param.put("netAmount",df.format(totalamt)+"");
					param.put("taxqry", taxqry);
					param.put("customer", clientname);		         
					param.put("address",clientaddress);
					param.put("tinno", tinno);
					param.put("site", site);
					param.put("invodate", invdate);
					param.put("invonohvl",dtype+"-"+docno);
                       JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/projectexecution/invoiceprocessing/" + reportFileName + ".jrxml"));
     	 
     	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
                       generateReportPDF(response, param, jasperReport, conn);
                 
      
             } catch (Exception e) {

                 e.printStackTrace();

             }
		 finally{
				conn.close();
			}	 
         
				}
	
	  private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException, AddressException, MessagingException {
		  
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
