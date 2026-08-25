package com.dashboard.realestate.propinspanalysis;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.mail.internet.AddressException;
import javax.mail.internet.MimeBodyPart;
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

import org.apache.commons.codec.binary.Base64;
import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.common.ClsEncrypt;
import com.connection.ClsConnection;
import com.mailwithpdf.EmailProcess;
import com.opensymphony.xwork2.ActionSupport;
import com.sun.xml.internal.messaging.saaj.packaging.mime.MessagingException;

public class ClsPropInspAnalysisAction extends ActionSupport{
	ClsPropInspAnalysisDAO dao=new ClsPropInspAnalysisDAO();     
	
	private String username,password,mode,msg,docno;
	private Map<String, Object> param=null;
	
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getDocno() {
		return docno;
	}
	public void setDocno(String docno) {
		this.docno = docno;
	}
	     
	public int printAction(int docno,String doctype,String dtype,String userid) throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		ClsPropInspAnalysisBean bean=new ClsPropInspAnalysisBean();     
		Connection conn=null;
		try {
			ClsConnection objconn=new ClsConnection();
			conn=objconn.getMyConnection();
			bean=dao.getPrint(docno,request,session,conn);     
			//setUrl(objcommon.getPrintPath(dtype)); 
			
			HttpServletResponse response = ServletActionContext.getResponse();
			param = new HashMap();
			param.put("property",bean.getLblproperty());
			param.put("tenant",bean.getLbltenant());
			param.put("inspector",bean.getLblinspector());
			param.put("docno",bean.getLbldocno());
			param.put("date",bean.getLbldate());
			param.put("showclm",bean.getLblinsptype());
			param.put("owner",bean.getLblowner());
			param.put("coladd",bean.getLblcoladd());
			param.put("opt1",bean.getLblchkop1());
			param.put("opt2",bean.getLblchkop2());
			param.put("opt3",bean.getLblchkop3());
			param.put("opt4",bean.getLblchkop4());
			param.put("repdetail",bean.getLblrepdet());
			param.put("inspectype",bean.getLblinspectype());
			param.put("sigdate",bean.getLblsigdate());
			if(bean.getLblsign()!=null){
				param.put("sigimg",bean.getLblsign().replace("\\", "\\\\"));
			}
			if(bean.getLbltenantsig()!=null){
				param.put("tenantsig",bean.getLbltenantsig().replace("\\", "\\\\"));
			}
			param.put("summ",bean.getLblsumm());
			String headerimage=request.getSession().getServletContext().getRealPath("/icons/IGLOGO1.jpg");
			headerimage=headerimage.replace("\\", "\\\\");
			//System.out.println("headerimage==="+headerimage);
			param.put("imgheader",headerimage);
			String chk="";
			
			String gridqry="select  coalesce(room.rdesc1,'') roomtype,coalesce(furn.fdesc1,'') detail,if(insp.code='G',1,0) tickg,if(insp.code='F',1,0) tickf,"
			+"if(insp.code='M',1,0) tickm,if(insp.code='B',1,0) tickb,if(insp.code='S',1,0) ticks,if(insp.code='D',1,0) tickd,if(insp.code='N',1,0) tickn,"
			+"coalesce(HOd.comments,'') hocmnts,coalesce(d.comments,'') comments "
			+"from rl_propinspm m left join rl_propinspd d on m.doc_no=d.rdocno "
			+"left join rl_propinspM HO on HO.TNCDOCNO=M.TNCDOCNO AND HO.INSPTYPE='Hand Over' "
			+"left join rl_propinspd HOD on HO.doc_no=HOd.rdocno AND D.ROOMDOCNO=HOD.ROOMDOCNO AND D.FURNDOCNO=HOD.FURNDOCNO "
			+"left join re_mroom room on d.roomdocno=room.doc_no "
			+"left join re_mfurnfix furn on d.furndocno=furn.doc_no left join rl_insptype insp on d.inspstatus=insp.doc_no "
			+"where m.doc_no="+docno+" order by furn.rdoc_no,furn.sr_no";
			//System.out.println("Grid Query:"+gridqry);
			param.put("gridqry",gridqry);
			String reportFileName = "Property Inspection";
			ArrayList<String[]> insppics=dao.getInspectionPrintPicsNew(docno,conn);        
	         int picslistsize=insppics.size();
	         //System.out.println(insppics+"===="+picslistsize);
	         if(picslistsize<=100){
	        	 for(int i=0;i<picslistsize;i++){
	        		 int j=0;
	        		 if(i<=20){
	        			 param.put("imgband1","1"); 
	        			 
	        		 }
	        		/* if(i>16 && i<=20){
	        			 param.put("imgband11","1"); 
	        			 
	        		 }*/
	        		 if(i>20 && i<=36){
	        			 param.put("imgband2","1"); 
	        			 
	        		 }
	        		 if(i>36 && i<=52){
	        			 param.put("imgband3","1"); 
	        			
	        		 }
	        		 if(i>52 && i<=68){
	        			 param.put("imgband4","1");
	        			
	        		 }
	        		 if(i>68 && i<=84){
	        			 param.put("imgband5","1"); 
	        		 }
	        		 if(i>84 && i<=100){
	        			 param.put("imgband6","1"); 
	        		 }
	        		 String[] temp=insppics.get(i);
	        		 String[] tot=temp[j].split("##");
	        		 String pth=tot[0];
	        		 String desc=tot[1];
	        		 if(pth!=null){
	        		 pth=pth.replace("\\", "\\\\");
	        		 }
	        		 //System.out.println("loc==="+i+"===path==="+pth+"====desc==="+desc);
		        	param.put("refimg"+(i+1),pth);
		        	param.put("refimgtxt"+(i+1),desc);
		         } 
	         }else{
	        	 if(picslistsize <=0){
	        		 param.put("imgband1","0"); 
	        		 param.put("imgband11","0"); 
        			 param.put("imgband2","0"); 
        			 param.put("imgband3","0"); 
        			 param.put("imgband4","0");
        			 param.put("imgband5","0"); 
	        	 }
	         }
			JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("propertyinspection/property222.jrxml"));
			
			JasperReport jasperReport = JasperCompileManager.compileReport(design);
			generateReportPDF(response, param, jasperReport, conn, docno, doctype, userid);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
 	   	return 1;                    
	}
	private void generateReportPDF(HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn,int docno,String dtype,String username)throws JRException, NamingException, SQLException, IOException {
	byte[] bytes = null;       
    bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
	Statement stmtrr=conn.createStatement();
	  
	String fileName="",path="", formcode=dtype,filepath="";    
	String strSql1 = "select imgPath from my_comp";
	int val=0;         
		ResultSet rs1 = stmtrr.executeQuery(strSql1);
		while(rs1.next ()) {
			path=rs1.getString("imgPath");
		}
			  
		DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
		java.util.Date date = new java.util.Date();
		String currdate=dateFormat.format(date);
		
		fileName = "Inspection Analysis"+currdate+".pdf";    
		filepath=path+ "/Attachment/"+formcode+"/"+fileName;

		File dir = new File(path+ "/attachment/"+formcode); 
		dir.mkdirs();
		    
		FileOutputStream fos = new FileOutputStream(filepath);
	    fos.write(bytes);
	    fos.flush();
	    fos.close();
	
   	    File saveFile=new File(filepath);
   	    
   	    //String inputpath=path+ "\\attachment\\"+formcode+"\\"+fileName; 
   	    //System.out.println("path--->>>"+inputpath);   
   	    if (saveFile != null) {   
   	    	String strsql1="delete from my_fileattach where doc_no='"+docno+"' and dtype='"+dtype+"'";       
		    val=stmtrr.executeUpdate(strsql1); 
   	    	/*String strsql="insert into my_fileattach(dtype,doc_no,brhid,sr_no,date,user,path,filename) values('"+dtype+"','"+docno+"',1,1,now(),'"+username+"','"+inputpath+"','"+fileName+"')";  
			System.out.println("strsql======="+strsql);  
		    val=stmtrr.executeUpdate(strsql);*/ 
		    String desc="";
		    int refid=0;
		    CallableStatement stmtAttach = conn.prepareCall("{CALL fileAttach(?,?,?,?,?,?,?,?,?)}");
				
		    stmtAttach.registerOutParameter(9, java.sql.Types.INTEGER);
			
			stmtAttach.setString(1,dtype);
			stmtAttach.setString(2,docno+"");
			stmtAttach.setString(3,"1");
			stmtAttach.setString(4,username);
			stmtAttach.setString(5,path+"\\attachment\\"+formcode+"\\"+ fileName);
			stmtAttach.setString(6,fileName);
			stmtAttach.setString(7,desc);
			stmtAttach.setInt(8,refid);       
			stmtAttach.executeQuery();
			val=stmtAttach.getInt("srNo");            
		    
        }
  }  
}
