package propertyinsplogin;

import java.io.IOException;
import java.sql.Connection;
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

public class ClsPropertyInspLoginAction extends ActionSupport{
	ClsPropertyInspLoginDAO dao=new ClsPropertyInspLoginDAO();
	
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
	
	public String saveAction()throws ParseException, SQLException{

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
//		System.out.println("====== "+getUsername()+"==="+getPassword()+"===="+mode);
		ClsPropertyInspLoginDAO dao=new ClsPropertyInspLoginDAO();
		if(mode.equalsIgnoreCase("A")){
			boolean status=dao.userLogin(getUsername(),getPassword(),session,request);
			if(status){
				return "success";
			}
			else{
				return "fail";
			}
		}
		
		return "fail";
	}
	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		int docno=Integer.parseInt(request.getParameter("docno"));
		String dtype=request.getParameter("dtype");
		ClsPropertyInspLoginBean bean=new ClsPropertyInspLoginBean();
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
			System.out.println("headerimage==="+headerimage);
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
			System.out.println("Grid Query:"+gridqry);
			param.put("gridqry",gridqry);
			String reportFileName = "Property Inspection";
			ArrayList<String[]> insppics=dao.getInspectionPrintPicsNew(docno,conn);
	         int picslistsize=insppics.size();
	         System.out.println(insppics+"===="+picslistsize);
	         if(picslistsize<=500){
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
	        		 if(i>100 && i<=120){
	        			 param.put("imgband7","1"); 
	        		 }
	        		 if(i>120 && i<=140){
	        			 param.put("imgband8","1"); 
	        		 }
	        		 if(i>140 && i<=160){
	        			 param.put("imgband9","1"); 
	        		 }
	        		 if(i>160 && i<=180){
	        			 param.put("imgband10","1"); 
	        		 }
	        		 if(i>180 && i<=200){
	        			 param.put("imgband11","1"); 
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
        			 param.put("imgband2","0"); 
        			 param.put("imgband3","0"); 
        			 param.put("imgband4","0");
        			 param.put("imgband5","0");
        			 param.put("imgband6","0");
        			 param.put("imgband7","0");
        			 param.put("imgband8","0");
        			 param.put("imgband9","0");
        			 param.put("imgband10","0");
        			 param.put("imgband11","0");
	        	 }
	        	 /*for(int i=0;i<20;i++){
	        		 int j=0;
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
		         } */
	         }
			JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("propertyinspection/property222.jrxml"));
			
			JasperReport jasperReport = JasperCompileManager.compileReport(design);
			generateReportPDF(response, param, jasperReport, conn);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
 	   	return "print";
	}
	
	private void generateReportPDF(HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException {
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
