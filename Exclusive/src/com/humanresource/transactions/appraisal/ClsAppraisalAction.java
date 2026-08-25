package com.humanresource.transactions.appraisal;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

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
import com.connection.ClsConnection;
 
	public class ClsAppraisalAction {

	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection connDAO = new ClsConnection();

	private String  masterdate,hidmasterdate,leastpaydate,hidleastpaydate,empid,empname,joindate,hidjoindate,prevappdate,hidprevappdate,deprtment,designation,
    category,desc, mode, deleted ,msg,formdetailcode;
 
	private int hidcmbyear,hidcmbmonth,docno, empdocno,  hidcmbdept, hiddeprtment,hiddesignation,
	hidcategory,change,hidcmbcategory,hidchange,hidcmbdesignation,compensationGridlength,cmbyear,cmbmonth,cmbdept,cmbdesignation,cmbcategory;
	
	private String url,printurl;
	
	private Map<String, Object> param=null;
	
	private String lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname,lblemployeename,lblemployeedepartment,
	lblexistingstatusposition,lblnewstatusposition,lblexistingstatusdepartment,lblnewstatusdepartment,lblexistingstatusgrosssalary,lblnewstatusgrosssalary,
	lbleffectivedate,lblnewstatuscategory;
	
	ClsAppraisalDAO saveDAO= new ClsAppraisalDAO();
	ClsAppraisalBean viewDAO= new ClsAppraisalBean();
	
	public String getMasterdate() {
		return masterdate;
	}
	public void setMasterdate(String masterdate) {
		this.masterdate = masterdate;
	}
	public String getHidmasterdate() {
		return hidmasterdate;
	}
	public void setHidmasterdate(String hidmasterdate) {
		this.hidmasterdate = hidmasterdate;
	}
	public String getLeastpaydate() {
		return leastpaydate;
	}
	public void setLeastpaydate(String leastpaydate) { 
		this.leastpaydate = leastpaydate;
	}
	public String getHidleastpaydate() {
		return hidleastpaydate;
	}
	public void setHidleastpaydate(String hidleastpaydate) {
		this.hidleastpaydate = hidleastpaydate;
	}
	public String getEmpid() {  
		return empid;
	}
	public void setEmpid(String empid) { 
		this.empid = empid;
	}
	public String getEmpname() {
		return empname;
	}
	public void setEmpname(String empname) {
		this.empname = empname;
	}
	public String getJoindate() {
		return joindate;
	}
	public void setJoindate(String joindate) {
		this.joindate = joindate;
	}
	public String getHidjoindate() {
		return hidjoindate;
	}
	public void setHidjoindate(String hidjoindate) {  
		this.hidjoindate = hidjoindate;
	}
	public String getPrevappdate() {
		return prevappdate;
	}
	public void setPrevappdate(String prevappdate) {
		this.prevappdate = prevappdate;
	}
	public String getHidprevappdate() {
		return hidprevappdate;
	}
	public void setHidprevappdate(String hidprevappdate) {    
		this.hidprevappdate = hidprevappdate;
	}
	public String getDeprtment() {  
		return deprtment;
	}
	public void setDeprtment(String deprtment) {
		this.deprtment = deprtment;
	}
	public String getDesignation() {
		return designation;
	}
	public void setDesignation(String designation) {
		this.designation = designation;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getCmbdept() {                        
		return cmbdept;
	}
	public void setCmbdept(int cmbdept) {
		this.cmbdept = cmbdept;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
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
	public int getHidcmbyear() {
		return hidcmbyear;
	}
	public void setHidcmbyear(int hidcmbyear) {      
		this.hidcmbyear = hidcmbyear;
	}
	public int getHidcmbmonth() {
		return hidcmbmonth;
	}
	public void setHidcmbmonth(int hidcmbmonth) {
		this.hidcmbmonth = hidcmbmonth;
	}
	public int getDocno() {   
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public int getEmpdocno() {
		return empdocno;
	}
	public void setEmpdocno(int empdocno) {
		this.empdocno = empdocno;
	}
	public int getHidcmbdept() {
		return hidcmbdept;
	}
	public void setHidcmbdept(int hidcmbdept) {
		this.hidcmbdept = hidcmbdept;
	}
	public int getHiddeprtment() {
		return hiddeprtment;
	}
	public void setHiddeprtment(int hiddeprtment) {
		this.hiddeprtment = hiddeprtment;
	}
	public int getHiddesignation() {
		return hiddesignation;
	}
	public void setHiddesignation(int hiddesignation) {
		this.hiddesignation = hiddesignation;
	}
	public int getHidcategory() {
		return hidcategory;
	}
	public void setHidcategory(int hidcategory) {
		this.hidcategory = hidcategory;
	}
	public int getCmbdesignation() {                  
		return cmbdesignation;
	}
	public void setCmbdesignation(int cmbdesignation) {
		this.cmbdesignation = cmbdesignation;
	}
	public int getCmbcategory() {
		return cmbcategory;
	}
	public void setCmbcategory(int cmbcategory) {
		this.cmbcategory = cmbcategory;
	}
	public int getChange() {
		return change;
	}
	public void setChange(int change) {
		this.change = change;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public int getHidcmbcategory() {
		return hidcmbcategory;
	}
	public void setHidcmbcategory(int hidcmbcategory) {
		this.hidcmbcategory = hidcmbcategory;
	}
	public int getHidchange() {
		return hidchange;
	}
	public void setHidchange(int hidchange) {
		this.hidchange = hidchange;
	}
	public int getCompensationGridlength() {
		return compensationGridlength;
	}
	public void setCompensationGridlength(int compensationGridlength) {
		this.compensationGridlength = compensationGridlength;
	}
	public int getHidcmbdesignation() {
		return hidcmbdesignation;
	}
	public void setHidcmbdesignation(int hidcmbdesignation) {
		this.hidcmbdesignation = hidcmbdesignation;
	}
	public int getCmbyear() {
		return cmbyear;
	}
	public void setCmbyear(int cmbyear) {
		this.cmbyear = cmbyear;
	}
	public int getCmbmonth() {
		return cmbmonth;
	}
	public void setCmbmonth(int cmbmonth) {
		this.cmbmonth = cmbmonth;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getPrinturl() {
		return printurl;
	}
	public void setPrinturl(String printurl) {
		this.printurl = printurl;
	}
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
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
	public String getLblprintname() {
		return lblprintname;
	}
	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}
	public String getLblemployeename() {
		return lblemployeename;
	}
	public void setLblemployeename(String lblemployeename) {
		this.lblemployeename = lblemployeename;
	}
	public String getLblemployeedepartment() {
		return lblemployeedepartment;
	}
	public void setLblemployeedepartment(String lblemployeedepartment) {
		this.lblemployeedepartment = lblemployeedepartment;
	}
	public String getLblexistingstatusposition() {
		return lblexistingstatusposition;
	}
	public void setLblexistingstatusposition(String lblexistingstatusposition) {
		this.lblexistingstatusposition = lblexistingstatusposition;
	}
	public String getLblnewstatusposition() {
		return lblnewstatusposition;
	}
	public void setLblnewstatusposition(String lblnewstatusposition) {
		this.lblnewstatusposition = lblnewstatusposition;
	}
	public String getLblexistingstatusdepartment() {
		return lblexistingstatusdepartment;
	}
	public void setLblexistingstatusdepartment(String lblexistingstatusdepartment) {
		this.lblexistingstatusdepartment = lblexistingstatusdepartment;
	}
	public String getLblnewstatusdepartment() {
		return lblnewstatusdepartment;
	}
	public void setLblnewstatusdepartment(String lblnewstatusdepartment) {
		this.lblnewstatusdepartment = lblnewstatusdepartment;
	}
	public String getLblexistingstatusgrosssalary() {
		return lblexistingstatusgrosssalary;
	}
	public void setLblexistingstatusgrosssalary(String lblexistingstatusgrosssalary) {
		this.lblexistingstatusgrosssalary = lblexistingstatusgrosssalary;
	}
	public String getLblnewstatusgrosssalary() {
		return lblnewstatusgrosssalary;
	}
	public void setLblnewstatusgrosssalary(String lblnewstatusgrosssalary) {
		this.lblnewstatusgrosssalary = lblnewstatusgrosssalary;
	}
	public String getLbleffectivedate() {
		return lbleffectivedate;
	}
	public void setLbleffectivedate(String lbleffectivedate) {
		this.lbleffectivedate = lbleffectivedate;
	}
	public String getLblnewstatuscategory() {
		return lblnewstatuscategory;
	}
	public void setLblnewstatuscategory(String lblnewstatuscategory) {
		this.lblnewstatuscategory = lblnewstatuscategory;
	}
	
	public String saveAction() throws SQLException {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap(); 
		
		if(getMode().equalsIgnoreCase("A")) {
	 
		java.sql.Date masterdate=	ClsCommon.changeStringtoSqlDate(getMasterdate());
		java.sql.Date payroldate=	ClsCommon.changeStringtoSqlDate(getLeastpaydate());
		java.sql.Date joindate=	ClsCommon.changeStringtoSqlDate(getJoindate());
		java.sql.Date appdate=	ClsCommon.changeStringtoSqlDate(getPrevappdate());
		
	 	ArrayList<String> comparray= new ArrayList<>();
		for(int i=0;i<getCompensationGridlength() ;i++){
			String temp1=requestParams.get("test"+i)[0];
			comparray.add(temp1);
		}
	 
		int val=saveDAO.insert(getCmbyear(),getCmbmonth(),masterdate,payroldate,appdate,getEmpdocno(),getHiddeprtment(),getHiddesignation(),getHidcategory(),
					getCmbdept(),getCmbdesignation(),getCmbcategory(),getDesc(),getChange(),getFormdetailcode(),getMode(),request,session,comparray);
			
		if(val>0) {
				
				 setDocno(val);
				 setEmpid(getEmpid());
				 setEmpdocno(getEmpdocno());
				 setEmpname(getEmpname());
				 setHidcmbyear(getCmbyear());
				 setHidcmbmonth(getCmbmonth());
				 setDeprtment(getDeprtment());
				 setHiddeprtment(getHiddeprtment());
				 setDesignation(getDesignation());
				 setHiddesignation(getHiddesignation());        	   
				 setCategory(getCategory());
				 setHidcategory(getHidcategory());
				 setHidchange(getChange());
		         setHidcmbdept(getCmbdept());
		         setHidcmbdesignation(getCmbdesignation());
		         setHidcmbcategory(getCmbcategory());
		         setDesc(getDesc());
		         setHidmasterdate(masterdate.toString());
		         setHidleastpaydate(payroldate.toString());
		         setHidjoindate(joindate.toString());
		         setHidprevappdate(appdate.toString());

		         setMsg("Successfully Saved");
				 return "success";
				
			} else {

				 setEmpid(getEmpid());
				 setEmpdocno(getEmpdocno());
				 setEmpname(getEmpname());
				 setHidcmbyear(getCmbyear());
				 setHidcmbmonth(getCmbmonth());
				 setDeprtment(getDeprtment());
				 setHiddeprtment(getHiddeprtment());
				 setDesignation(getDesignation());
				 setHiddesignation(getHiddesignation());        	   
				 setCategory(getCategory());
				 setHidcategory(getHidcategory());
				 setHidchange(getChange());
		         setHidcmbdept(getCmbdept());
		         setHidcmbdesignation(getCmbdesignation());
		         setHidcmbcategory(getCmbcategory());
		         setDesc(getDesc());
		         setHidmasterdate(masterdate.toString());
		         setHidleastpaydate(payroldate.toString());
		         setHidjoindate(joindate.toString());
		         setHidprevappdate(appdate.toString());
				  
				 setMsg("Not Saved");
				 return "fail";
				
			}
		}
		
		else if(getMode().equalsIgnoreCase("E")) {
	 
			    java.sql.Date masterdate=	ClsCommon.changeStringtoSqlDate(getMasterdate());
				java.sql.Date payroldate=	ClsCommon.changeStringtoSqlDate(getLeastpaydate());
				java.sql.Date joindate=	ClsCommon.changeStringtoSqlDate(getJoindate());
				java.sql.Date appdate=	ClsCommon.changeStringtoSqlDate(getPrevappdate());
				
			 	ArrayList<String> comparray= new ArrayList<>();
				for(int i=0;i<getCompensationGridlength() ;i++){
					String temp1=requestParams.get("test"+i)[0];
					comparray.add(temp1);
				}

				int val=saveDAO.update(getDocno(),getCmbyear(),getCmbmonth(),masterdate,payroldate,appdate,getEmpdocno(),getHiddeprtment(),getHiddesignation(),getHidcategory(),
							getCmbdept(),getCmbdesignation(),getCmbcategory(),getDesc(),getChange(),getFormdetailcode(),getMode(),request,session,comparray);
					
				if(val>0) {
						
						 setDocno(getDocno());
						 setEmpid(getEmpid());
						 setEmpdocno(getEmpdocno());
						 setEmpname(getEmpname());
						 setHidcmbyear(getCmbyear());
						 setHidcmbmonth(getCmbmonth());
						 setDeprtment(getDeprtment());
						 setHiddeprtment(getHiddeprtment());
						 setDesignation(getDesignation());
						 setHiddesignation(getHiddesignation());        	   
						 setCategory(getCategory());
						 setHidcategory(getHidcategory());
						 setHidchange(getChange());
				         setHidcmbdept(getCmbdept());
				         setHidcmbdesignation(getCmbdesignation());
				         setHidcmbcategory(getCmbcategory());
				         setDesc(getDesc());
				         setHidmasterdate(masterdate.toString());
				         setHidleastpaydate(payroldate.toString());
				         setHidjoindate(joindate.toString());
				         setHidprevappdate(appdate.toString());
				         
				         setMsg("Updated Successfully");
				         return "success";
						
					} else {
						 
						 setDocno(getDocno());
						 setEmpid(getEmpid());
						 setEmpdocno(getEmpdocno());
						 setEmpname(getEmpname());
						 setHidcmbyear(getCmbyear());
						 setHidcmbmonth(getCmbmonth());
						 setDeprtment(getDeprtment());
						 setHiddeprtment(getHiddeprtment());
						 setDesignation(getDesignation());
						 setHiddesignation(getHiddesignation());        	   
						 setCategory(getCategory());
						 setHidcategory(getHidcategory());
						 setHidchange(getChange());
				         setHidcmbdept(getCmbdept());
				         setHidcmbdesignation(getCmbdesignation());
				         setHidcmbcategory(getCmbcategory());
				         setDesc(getDesc());
				         setHidmasterdate(masterdate.toString());
				         setHidleastpaydate(payroldate.toString());
				         setHidjoindate(joindate.toString());
				         setHidprevappdate(appdate.toString());
						  
				         setMsg("Not Updated");
				         return "fail";
						
					}
		}
	 	
		else if(getMode().equalsIgnoreCase("D")) {
	 		 
		 	int val=saveDAO.delete(getDocno(),getMode(),getFormdetailcode(),getEmpdocno(),session,request); 
	 		 
			if(val>0) {
				
				 setDocno(getDocno());
				 setEmpid(getEmpid());
				 setEmpdocno(getEmpdocno());
				 setEmpname(getEmpname());
				 setHidcmbyear(getCmbyear());
				 setHidcmbmonth(getCmbmonth());
				 setDeprtment(getDeprtment());
				 setHiddeprtment(getHiddeprtment());
				 setDesignation(getDesignation());
				 setHiddesignation(getHiddesignation());        	   
				 setCategory(getCategory());
				 setHidcategory(getHidcategory());
				 setHidchange(getChange());
		         setHidcmbdept(getCmbdept());
		         setHidcmbdesignation(getCmbdesignation());
		         setHidcmbcategory(getCmbcategory());
		         setDesc(getDesc());

		         setDeleted("DELETED");
				 setMsg("Successfully Deleted");
				 return "success";
				
			} else {
				 
				setDocno(getDocno());
				setEmpid(getEmpid());
				setEmpdocno(getEmpdocno());
			    setEmpname(getEmpname());
			    setHidcmbyear(getCmbyear());
			    setHidcmbmonth(getCmbmonth());
			    setDeprtment(getDeprtment());
			    setHiddeprtment(getHiddeprtment());
			    setDesignation(getDesignation());
			    setHiddesignation(getHiddesignation());        	   
			    setCategory(getCategory());
			    setHidcategory(getHidcategory());
				setHidchange(getChange());
		        setHidcmbdept(getCmbdept());
		        setHidcmbdesignation(getCmbdesignation());
		        setHidcmbcategory(getCmbcategory());
		        setDesc(getDesc());
		         
				setMsg("Not Deleted");
	            return "fail";
			}
		} 
		
	 	else if(getMode().equalsIgnoreCase("view")) {
	 		
			 viewDAO=saveDAO.getViewDetails(getDocno());
	 
			 setDocno(getDocno());
			 setEmpid(viewDAO.getEmpid());
			 setEmpdocno(viewDAO.getEmpdocno());
			 setEmpname(viewDAO.getEmpname());
			 setHidcmbyear(viewDAO.getCmbyear());
			 setHidcmbmonth(viewDAO.getCmbmonth());
			 setDeprtment(viewDAO.getDeprtment());
			 setHiddeprtment(viewDAO.getHiddeprtment());
			 setDesignation(viewDAO.getDesignation());
			 setHiddesignation(viewDAO.getHiddesignation());        	   
			 setCategory(viewDAO.getCategory());
			 setHidcategory(viewDAO.getHidcategory());
			 setHidchange(viewDAO.getChange());
	         setHidcmbdept(viewDAO.getCmbdept());
	         setHidcmbdesignation(viewDAO.getCmbdesignation());
	         setHidcmbcategory(viewDAO.getCmbcategory());
	         setDesc(viewDAO.getDesc());
	         setHidmasterdate(viewDAO.getMasterdate());
	         setHidleastpaydate(viewDAO.getLeastpaydate());
	         setHidjoindate(viewDAO.getJoindate());
	         setHidprevappdate(viewDAO.getPrevappdate());
			
			 return "success";
			
		}
		return "fail";
	}
	
	public void printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
	    HttpServletResponse response = ServletActionContext.getResponse();
	    Connection conn = null;
        
		try {
               
               conn = connDAO.getMyConnection();
               param = new HashMap();
               
               int docno=Integer.parseInt(request.getParameter("docno"));
        	   String branch = request.getParameter("branch");
             
        	   viewDAO=saveDAO.getPrint(request,docno,branch);
	       	   
        	   String reportFileName = ClsCommon.getPrintPath("HSAP");
        	   
        	   String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
               imgpath=imgpath.replace("\\", "\\\\");
              	
			   String imgheaderpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
               imgheaderpath=imgheaderpath.replace("\\", "\\\\");    
	          
               String imgfooterpath=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
               imgfooterpath=imgfooterpath.replace("\\", "\\\\"); 
                
               String createdbysql = "",allowancessql="";
       		
	       	   createdbysql = "select UPPER(coalesce(u.user_name,'')) preparedby,UPPER(coalesce(u1.user_name,'')) verifiedby,UPPER(coalesce(u2.user_name,'')) approvedby from hr_incrm m "
	       			+ "left join my_exdet ext on (m.doc_no=ext.doc_no and m.dtype=ext.dtype and ext.apprstatus=2) left join my_exdet ext1 on (m.doc_no=ext1.doc_no "
	       			+ "and m.dtype=ext1.dtype and ext1.apprstatus=3) left join my_user u on m.userid=u.doc_no left join my_user u1 on ext.userid=u1.doc_no left join "
	       			+ "my_user u2 on ext1.userid=u2.doc_no where m.status=3 and m.dtype='HSAP' and m.brhid="+branch+" and m.doc_no="+docno+"";
					
	       	   allowancessql = "select if(m.refdtype='STD',UPPER(s.desc1),UPPER(a.desc1)) allowance,CONCAT('Dhs. ',if(round((m.revadd-m.revded),2)=0,' ',round((m.revadd-m.revded),2)),'/- per month') amount "
	       			   + "from hr_incrm ma left join hr_incrd m on ma.doc_no=m.rdocno  left join hr_setallowance a on m.awlId=a.doc_no and a.status=3  left join hr_setdeduction s on m.awlId=s.doc_no and "
	       			   + "ma.dtype='HSAP' and ma.status=3 and s.status=3 where m.rdocno="+docno+"";
	       	   
	       	   param.put("imgpath", imgheaderpath);
			   param.put("imgheaderpath", imgheaderpath);
	           param.put("imgfooterpath", imgfooterpath);
	           param.put("compname", viewDAO.getLblcompname());
		       param.put("compaddress", viewDAO.getLblcompaddress()); 
		       param.put("comptel", viewDAO.getLblcomptel());
		       param.put("compfax", viewDAO.getLblcompfax());
		       param.put("compbranch", viewDAO.getLblbranch());
		       param.put("location", viewDAO.getLbllocation());
		       param.put("printname", viewDAO.getLblprintname());
	           param.put("employeename", viewDAO.getLblemployeename());
	           param.put("employeedepartment", viewDAO.getLblemployeedepartment());
	           param.put("existingstatusposition", viewDAO.getLblexistingstatusposition());
	           param.put("newstatusposition", viewDAO.getLblnewstatusposition());
	           param.put("existingstatusdepartment", viewDAO.getLblexistingstatusdepartment());
	           param.put("newstatusdepartment", viewDAO.getLblnewstatusdepartment());
	           param.put("existingstatusgrosssalary", viewDAO.getLblexistingstatusgrosssalary());
	           param.put("newstatusgrosssalary", viewDAO.getLblnewstatusgrosssalary());
	           param.put("effectivedate", viewDAO.getLbleffectivedate());
	           param.put("newstatuscategory", viewDAO.getLblnewstatuscategory());
		       param.put("createdbysql", createdbysql);
		       param.put("allowancessql", allowancessql);
		       param.put("printby", session.getAttribute("USERNAME").toString());
		       
               JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(reportFileName));
     	       JasperReport jasperReport = JasperCompileManager.compileReport(design);
               generateReportPDF(response, param, jasperReport, conn);
      
             } catch (Exception e) {
                 e.printStackTrace();
                 conn.close();
         	} finally{
         		conn.close();
         	}
      	
	 }
	
	  private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException, AddressException {
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
