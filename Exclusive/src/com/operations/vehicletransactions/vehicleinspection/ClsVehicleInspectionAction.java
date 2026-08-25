package com.operations.vehicletransactions.vehicleinspection;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;

public class ClsVehicleInspectionAction extends ActionSupport{
	ClsVehicleInspectionDAO inspectionDAO=new ClsVehicleInspectionDAO();
	ClsVehicleInspectionBean bean;
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	private int docno;
	private String refvoucherno;
	private String brchName;
	private String date;
	private String hiddate;
	private String cmbtype;
	private String hidcmbtype;
	private String cmbreftype;
	private String hidcmbreftype;
	private int rdocno;
	private String amount;
	private String accdate;
	private String hidaccdate;
	private String prcs;
	private String collectdate;
	private String hidcollectdate;
	private String accplace;
	private String accfines;
	private String cmbclaim;
	private String hidcmbclaim;
	private String msg;
	private String mode;
	private String deleted;
	private String formdetail;
	private String formdetailcode;
	private String hidaccidents;
	private String accremarks;
	private String rfleet;
	private int damagegridlength;
	private int maintenancegridlength;
	private int existdamagegridlength;
	private String time;
	private String hidtime;
	private String cmbagmtbranch;
	private String hidcmbagmtbranch;
	private String regno;
	private String client;
	
	public String getRegno() {
		return regno;
	}
	public void setRegno(String regno) {
		this.regno = regno;
	}
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public String getCmbagmtbranch() {
		return cmbagmtbranch;
	}
	public void setCmbagmtbranch(String cmbagmtbranch) {
		this.cmbagmtbranch = cmbagmtbranch;
	}
	public String getHidcmbagmtbranch() {
		return hidcmbagmtbranch;
	}
	public void setHidcmbagmtbranch(String hidcmbagmtbranch) {
		this.hidcmbagmtbranch = hidcmbagmtbranch;
	}


	//Save File 
	private File file;  
    private String fileFileName;  
    private String fileFileContentType;  
	private String message = ""; 
	
	//Print
	
	private String lblcompname;
	private String lblcompaddress;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
    private String lbldocno;
    private String lbldate;
    private String lbltime;
    private String lbltype;
    private String lblreftype;
    private String lblreffleetno;
    private String lblrefdocno;
    private String lblaccdate;
    private String lblprcs;
    private String lblcoldate;
    private String lblplace;
    private String lblfines;
    private String lblclaim;
    private String lblremarks;
    private String lblamount;
    private String lblaccident;
    private String lblprintname;
    private String lblhidexisting;
    private String lblhidnew;
    private String lblurl;


    
  public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}
public String getRefvoucherno() {
		return refvoucherno;
	}
	public void setRefvoucherno(String refvoucherno) {
		this.refvoucherno = refvoucherno;
	}
public String getLblurl() {
		return lblurl;
	}
	public void setLblurl(String lblurl) {
		this.lblurl = lblurl;
	}
	public String getLblhidexisting() {
		return lblhidexisting;
	}
	public void setLblhidexisting(String lblhidexisting) {
		this.lblhidexisting = lblhidexisting;
	}
	public String getLblhidnew() {
		return lblhidnew;
	}
	public void setLblhidnew(String lblhidnew) {
		this.lblhidnew = lblhidnew;
	}
    public String getLblprintname() {
		return lblprintname;
	}
	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}
	public String getLblaccident() {
		return lblaccident;
	}
	public void setLblaccident(String lblaccident) {
		this.lblaccident = lblaccident;
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
	public String getLbldocno() {
		return lbldocno;
	}
	public void setLbldocno(String lbldocno) {
		this.lbldocno = lbldocno;
	}
	public String getLbldate() {
		return lbldate;
	}
	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}
	public String getLbltime() {
		return lbltime;
	}
	public void setLbltime(String lbltime) {
		this.lbltime = lbltime;
	}
	public String getLbltype() {
		return lbltype;
	}
	public void setLbltype(String lbltype) {
		this.lbltype = lbltype;
	}
	public String getLblreftype() {
		return lblreftype;
	}
	public void setLblreftype(String lblreftype) {
		this.lblreftype = lblreftype;
	}
	public String getLblreffleetno() {
		return lblreffleetno;
	}
	public void setLblreffleetno(String lblreffleetno) {
		this.lblreffleetno = lblreffleetno;
	}
	public String getLblrefdocno() {
		return lblrefdocno;
	}
	public void setLblrefdocno(String lblrefdocno) {
		this.lblrefdocno = lblrefdocno;
	}
	public String getLblaccdate() {
		return lblaccdate;
	}
	public void setLblaccdate(String lblaccdate) {
		this.lblaccdate = lblaccdate;
	}
	public String getLblprcs() {
		return lblprcs;
	}
	public void setLblprcs(String lblprcs) {
		this.lblprcs = lblprcs;
	}
	public String getLblcoldate() {
		return lblcoldate;
	}
	public void setLblcoldate(String lblcoldate) {
		this.lblcoldate = lblcoldate;
	}
	public String getLblplace() {
		return lblplace;
	}
	public void setLblplace(String lblplace) {
		this.lblplace = lblplace;
	}
	public String getLblfines() {
		return lblfines;
	}
	public void setLblfines(String lblfines) {
		this.lblfines = lblfines;
	}
	public String getLblclaim() {
		return lblclaim;
	}
	public void setLblclaim(String lblclaim) {
		this.lblclaim = lblclaim;
	}
	public String getLblremarks() {
		return lblremarks;
	}
	public void setLblremarks(String lblremarks) {
		this.lblremarks = lblremarks;
	}
	public String getLblamount() {
		return lblamount;
	}
	public void setLblamount(String lblamount) {
		this.lblamount = lblamount;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public File getFile() {
		return file;
	}
	public void setFile(File file) {
		this.file = file;
	}
	public String getFileFileName() {
		return fileFileName;
	}
	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}
	public String getFileFileContentType() {
		return fileFileContentType;
	}
	public void setFileFileContentType(String fileFileContentType) {
		this.fileFileContentType = fileFileContentType;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getHidtime() {
		return hidtime;
	}
	public void setHidtime(String hidtime) {
		this.hidtime = hidtime;
	}
	public int getExistdamagegridlength() {
		return existdamagegridlength;
	}
	public void setExistdamagegridlength(int existdamagegridlength) {
		this.existdamagegridlength = existdamagegridlength;
	}
	public int getDamagegridlength() {
		return damagegridlength;
	}
	public void setDamagegridlength(int damagegridlength) {
		this.damagegridlength = damagegridlength;
	}
	public int getMaintenancegridlength() {
		return maintenancegridlength;
	}
	public void setMaintenancegridlength(int maintenancegridlength) {
		this.maintenancegridlength = maintenancegridlength;
	}
	public String getRfleet() {
		return rfleet;
	}
	public void setRfleet(String rfleet) {
		this.rfleet = rfleet;
	}
	public String getAccremarks() {
		return accremarks;
	}
	public void setAccremarks(String accremarks) {
		this.accremarks = accremarks;
	}
	public String getHidaccidents() {
		return hidaccidents;
	}
	public void setHidaccidents(String hidaccidents) {
		this.hidaccidents = hidaccidents;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getHiddate() {
		return hiddate;
	}
	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
	}
	public String getCmbtype() {
		return cmbtype;
	}
	public void setCmbtype(String cmbtype) {
		this.cmbtype = cmbtype;
	}
	public String getHidcmbtype() {
		return hidcmbtype;
	}
	public void setHidcmbtype(String hidcmbtype) {
		this.hidcmbtype = hidcmbtype;
	}
	public String getCmbreftype() {
		return cmbreftype;
	}
	public void setCmbreftype(String cmbreftype) {
		this.cmbreftype = cmbreftype;
	}
	public String getHidcmbreftype() {
		return hidcmbreftype;
	}
	public void setHidcmbreftype(String hidcmbreftype) {
		this.hidcmbreftype = hidcmbreftype;
	}
	public int getRdocno() {
		return rdocno;
	}
	public void setRdocno(int rdocno) {
		this.rdocno = rdocno;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	public String getAccdate() {
		return accdate;
	}
	public void setAccdate(String accdate) {
		this.accdate = accdate;
	}
	public String getHidaccdate() {
		return hidaccdate;
	}
	public void setHidaccdate(String hidaccdate) {
		this.hidaccdate = hidaccdate;
	}
	public String getPrcs() {
		return prcs;
	}
	public void setPrcs(String prcs) {
		this.prcs = prcs;
	}
	public String getCollectdate() {
		return collectdate;
	}
	public void setCollectdate(String collectdate) {
		this.collectdate = collectdate;
	}
	public String getHidcollectdate() {
		return hidcollectdate;
	}
	public void setHidcollectdate(String hidcollectdate) {
		this.hidcollectdate = hidcollectdate;
	}
	public String getAccplace() {
		return accplace;
	}
	public void setAccplace(String accplace) {
		this.accplace = accplace;
	}
	public String getAccfines() {
		return accfines;
	}
	public void setAccfines(String accfines) {
		this.accfines = accfines;
	}
	public String getCmbclaim() {
		return cmbclaim;
	}
	public void setCmbclaim(String cmbclaim) {
		this.cmbclaim = cmbclaim;
	}
	public String getHidcmbclaim() {
		return hidcmbclaim;
	}
	public void setHidcmbclaim(String hidcmbclaim) {
		this.hidcmbclaim = hidcmbclaim;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
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
	public String getFormdetail() {
		return formdetail;
	}
	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		//System.out.println("hhhhhhhhhhhhhhhhheeeeeeeeeee"+getMode()+","+getModeldate());
		Map<String, String[]> requestParams = request.getParameterMap();
		session.getAttribute("BranchName");
//		System.out.println("sessoin"+session.getAttribute("BRANCHSELECTED"));
//		System.out.println("sessoin"+session.getAttribute("COMPANYNAME"));
		//System.out.println("request==="+request.getAttribute("BranchName"));
		
		String mode=getMode();
		ClsVehicleInspectionBean bean=new ClsVehicleInspectionBean();
		java.sql.Date date = null;
		java.sql.Date accdate=null ;
		java.sql.Date collectdate=null;
		
	if((mode.equalsIgnoreCase("A"))||mode.equalsIgnoreCase("D")){
		date = objcommon.changeStringtoSqlDate(getDate());
		if(getAccdate()!=null){
			accdate = objcommon.changeStringtoSqlDate(getAccdate());	
		}
		if(getCollectdate()!=null){
			collectdate = objcommon.changeStringtoSqlDate(getCollectdate());	
		}
		
		
	}
		
		if(mode.equalsIgnoreCase("A")){
//			System.out.println("Insert Mode");
			ArrayList<String> damagearray= new ArrayList<>();
			ArrayList<String> maintenancearray= new ArrayList<>();
			ArrayList<String> existdamagearray= new ArrayList<>();
			for(int i=0;i<getDamagegridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				damagearray.add(temp);
//				System.out.println(damagearray.get(i));
			}
			for(int i=0;i<getMaintenancegridlength();i++){
				String temp=requestParams.get("testmaint"+i)[0];
				maintenancearray.add(temp);
				//System.out.println(damagearray.get(i));
			}
			for(int i=0;i<getExistdamagegridlength();i++){
				String temp=requestParams.get("testexistdamage"+i)[0];
				existdamagearray.add(temp);
				//System.out.println(damagearray.get(i));
			}
//			System.out.println("Inside Action Mode A");
						int val=inspectionDAO.insert(date,getCmbtype(),getCmbreftype(),getRdocno(),accdate,getPrcs(),collectdate,getAccplace()==null?"":getAccplace(),getAccfines()==null?"0":getAccfines(),
								getCmbclaim()==null?"0":getCmbclaim(),getAmount()==null?"0":getAmount(),getFormdetailcode(),getHidaccidents(),getAccremarks(),
										session,getMode(),getRfleet(),damagearray,maintenancearray,existdamagearray,getTime(),getRefvoucherno(),getBrchName(),getCmbagmtbranch());
						if(val>0.0){
//							System.out.println(val);
							setHidcmbagmtbranch(getCmbagmtbranch());
							setHiddate(date.toString());
							setHidcmbtype(getCmbtype());
							setHidcmbreftype(getCmbreftype());
							setRdocno(getRdocno());
							setHidaccidents(getHidaccidents());
							if(getHidaccidents().equalsIgnoreCase("1")){
								setHidaccdate(accdate.toString());
								setPrcs(getPrcs());
								setHidcollectdate(collectdate.toString());
								setAccplace(getAccplace());
								setAccfines(getAccfines());
								setHidcmbclaim(getCmbclaim());
								setAmount(getAmount());	
								setAccremarks(getAccremarks());
							}
							
							setRfleet(getRfleet());
							setMode(getMode());
							setHidtime(getTime());
							setDocno(val);
							setRefvoucherno(getRefvoucherno());
							setClient(getClient());
							setRegno(getRegno());
							setMsg("Successfully Saved");

							return "success";
						}
						else{
							setHidcmbagmtbranch(getCmbagmtbranch());
							setHiddate(date.toString());
							setHidcmbtype(getCmbtype());
							setHidcmbreftype(getCmbreftype());
							setRdocno(getRdocno());
							setHidaccidents(getHidaccidents());
							if(getHidaccidents().equalsIgnoreCase("1")){
								setHidaccdate(accdate.toString());
								setPrcs(getPrcs());
								setHidcollectdate(collectdate.toString());
								setAccplace(getAccplace());
								setAccfines(getAccfines());
								setHidcmbclaim(getCmbclaim());
								setAmount(getAmount());	
								setAccremarks(getAccremarks());
							}
							setRfleet(getRfleet());
							setMode(getMode());
							setDocno(val);
							setClient(getClient());
							setRegno(getRegno());
							setMsg("Not Saved");

							return "fail";
						}	
		}
else if(mode.equalsIgnoreCase("View")){
			
	        bean=inspectionDAO.getViewDetails(getDocno());
			setHidcmbagmtbranch(bean.getHidcmbagmtbranch());
			setDate(bean.getDate());
			setHidcmbtype(bean.getHidcmbtype());
			setHidcmbreftype(bean.getHidcmbreftype());
			setRdocno(bean.getRdocno());
			setAccdate(bean.getAccdate());
			setPrcs(bean.getPrcs());
			setCollectdate(bean.getCollectdate());
			setAccplace(bean.getAccplace());
			setAccfines(bean.getAccfines());
			setHidcmbclaim(bean.getHidcmbclaim());
			setAmount(bean.getAmount());
			setHidaccidents(bean.getHidaccidents());
			setAccremarks(bean.getAccremarks());
			setRfleet(bean.getRfleet());
			setClient(bean.getClient());
			setRegno(bean.getRegno());
			return "success";
		}
		else if(mode.equalsIgnoreCase("D")){
//			System.out.println("Delete Mode");
			boolean value=inspectionDAO.delete(date,getCmbtype(),getCmbreftype(),getRdocno(),accdate,getPrcs(),collectdate,getAccplace(),getAccfines(),
					getCmbclaim(),getAmount(),getFormdetailcode(),getHidaccidents(),getAccremarks(),session,getMode(),getRfleet(),getDocno(),getTime());
		if(value){
			setHidcmbagmtbranch(getCmbagmtbranch());
			if(date!=null){
				setHiddate(date.toString());	
			}
			
			setHidcmbtype(getCmbtype());
			setHidcmbreftype(getCmbreftype());
			setRdocno(getRdocno());
			if(accdate!=null){
				setHidaccdate(accdate.toString());	
			}
			
			setPrcs(getPrcs());
			if(collectdate!=null){
				setHidcollectdate(collectdate.toString());	
			}
			
			setAccplace(getAccplace());
			setAccfines(getAccfines());
			setHidcmbclaim(getCmbclaim());
			setAmount(getAmount());
			setHidaccidents(getHidaccidents());
			setAccremarks(getAccremarks());
			setRfleet(getRfleet());
			setMode(getMode());
			setDocno(getDocno());
			setHidtime(getTime());
			setClient(getClient());
							setRegno(getRegno());
			setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
			
		}
		else{
			setHidcmbagmtbranch(getCmbagmtbranch());
			setHiddate(date.toString());
			setHidcmbtype(getCmbtype());
			setHidcmbreftype(getCmbreftype());
			setRdocno(getRdocno());
			setHidaccdate(accdate.toString());
			setPrcs(getPrcs());
			setHidcollectdate(collectdate.toString());
			setAccplace(getAccplace());
			setAccfines(getAccfines());
			setHidcmbclaim(getCmbclaim());
			setAmount(getAmount());
			setHidaccidents(getHidaccidents());
			setAccremarks(getAccremarks());
			setRfleet(getRfleet());
			setMode(getMode());
			setDocno(getDocno());
			setClient(getClient());
							setRegno(getRegno());
			setMsg("Not Deleted");
			return "fail";

		}
		}
	
		return "fail";
	}
	  public String saveFile() throws Exception { 
	    	
	    	HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
			Map<String, String[]> requestParams = request.getParameterMap();
//			System.out.println(" = =========== "+requestParams);
			//session.getAttribute("Code")==null?"Default":session.getAttribute("Code").toString();
	    	String code=request.getParameter("formdetailcode");
	    	String doc=request.getParameter("doc");
	    	String srno=request.getParameter("srno");
	    	String fname=code+'-'+doc+'-'+srno;
	    	String fname2=fname;
//	    	System.out.println("CODE==="+code);
		//	System.out.println("Code"+getFormdetailcode());
			String dirname =getFormdetailcode()==null?"Default":getFormdetailcode();
//	    	System.out.println(dirname);
	    	String path ="";
	    	Connection conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement ();
			String strSql = "select imgPath from my_comp where doc_no="+session.getAttribute("COMPANYID");
//			System.out.println(strSql);
			ResultSet rs = stmt.executeQuery(strSql);
			String path1="";
			while(rs.next ()) {
				path1=rs.getString("imgPath");
//				System.out.println("IMGPATH:"+path);
			}
			path=path1.replace("\\", "/");
	    	ServletContext context = ((HttpSession) request).getServletContext();
	    	//String path = context.getRealPath("/");
	    	
	    	File dir = new File(path+ "/attachment/"+dirname);
	   	 	dir.mkdirs();
	        //
	   	 	
//	        System.out.println("path==============="+path);
	        try {  
	            File f = this.getFile();
//	            System.out.println("File///////////"+getFile());
//	            System.out.println("FILE==="+getFileFileName());
	            if(this.getFileFileName().endsWith(".exe")){  
	                message="not done";  
	                return ERROR;  
	            } 
	          /*  String aa[]=getFileFileName().split(".");
	            System.out.println(aa);*/
	            int dotindex=getFileFileName().lastIndexOf(".");
	            String efile=getFileFileName().substring(dotindex+1);
//	            System.out.println("EEEE"+efile);
	            fname=fname+'.'+efile;
	            FileInputStream inputStream = new FileInputStream(f);  
	            
	            FileOutputStream outputStream = new FileOutputStream(path + "/attachment/"+dirname+ "/"+ fname);
//	            System.out.println("path==============="+path+"========="+outputStream);
	            byte[] buf = new byte[1024];  
	            int length = 0;  
	            while ((length = inputStream.read(buf)) != -1) {  
	                outputStream.write(buf, 0, length);  
	            }  
	            Statement stmtupdate=conn.createStatement();
	            String strupdate="update gl_vinspd set attach='"+fname+"',path='"+path + "/attachment/"+dirname+ "/"+ fname+"' where rdocno="+doc+" and srno="+srno ;
	            int val=stmtupdate.executeUpdate(strupdate);
	            if(val<=0){
	            	return ERROR;
	            }
	            inputStream.close();  
	            outputStream.flush();  
	            this.setMessage(path+fname);
	            stmt.close();
	            stmtupdate.close();
	            conn.close();
	        } catch (Exception e) {  
	            e.printStackTrace();  
	            message = "!!!!";
	            conn.close();
	            
	        }  
	        return SUCCESS;  
	    }
	  
	  
	  public String printAction() throws ParseException, SQLException{
//			System.out.println("Inside print Action");
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
			String fleetno=request.getParameter("fleetno");
			bean=inspectionDAO.getPrint(getDocno());
			setLblcompname(bean.getLblcompname());
			setLblcompaddress(bean.getLblcompaddress());
			setLblcompfax(bean.getLblcompfax());
			setLblcomptel(bean.getLblcomptel());
			setLblbranch(bean.getLblbranch());
			setLbldocno(bean.getLbldocno());
			setLbldate(bean.getLbldate());
			setLbltime(bean.getLbltime());
			setLbltype(bean.getLbltype());
			setLblreftype(bean.getLblreftype());
			setLblrefdocno(bean.getLblrefdocno());
			setLblreffleetno(bean.getLblreffleetno());
			setLblaccident(bean.getLblaccident());
			setLblaccdate(bean.getLblaccdate());
			setLblprcs(bean.getLblprcs());
			setLblcoldate(bean.getLblcoldate());
			setLblplace(bean.getLblplace());
			setLblfines(bean.getLblfines());
			setLblclaim(bean.getLblclaim());
			setLblcoldate(bean.getLblcoldate());
			setLblremarks(bean.getLblremarks());
			setLblamount(bean.getLblamount());
			setLblprintname("Vehicle Inspection");
			ArrayList<String> existingdamageprint=inspectionDAO.getExistingDamagePrint(getDocno(),fleetno);
			request.setAttribute("EXISTINGDAMAGEPRINT", existingdamageprint);
				if(existingdamageprint.size()>0){
				setLblhidexisting("1");
			}
			else{
				setLblhidexisting("0");
			}
			ArrayList<String> newdamageprint=inspectionDAO.getNewDamagePrint(getDocno(),fleetno);
			request.setAttribute("NEWDAMAGEPRINT", newdamageprint);
			if(newdamageprint.size()>0){
				setLblhidnew("1");
			}
			else{
				setLblhidnew("0");
			}
			ArrayList<String> damagepics=inspectionDAO.getNewDamagePrintPics(getDocno(),fleetno,request.getParameter("lblurl"));
			request.setAttribute("NEWDAMAGEPRINTPICS", damagepics);
			return "print";
		}
	
}
	
		
	

