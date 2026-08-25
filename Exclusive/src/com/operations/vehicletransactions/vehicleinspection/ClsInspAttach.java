package com.operations.vehicletransactions.vehicleinspection;


import java.io.File;  
import java.io.FileInputStream;  
import java.io.FileOutputStream;  
  
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;  

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;  
  
@SuppressWarnings("serial")  
public class ClsInspAttach extends ActionSupport {

	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	private File file;  
    private String fileFileName;  
    private String fileFileContentType;  
    private String formdetailcode;
    
    
    public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	private String message = "";  
      
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
  
    @SuppressWarnings("deprecation")  
    @Override  
    public String execute() throws Exception { 
    	
    	HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
//		System.out.println(" = =========== "+requestParams);
		//session.getAttribute("Code")==null?"Default":session.getAttribute("Code").toString();
    	String code=request.getParameter("formdetailcode");
    	String doc=request.getParameter("doc");
    	String srno=request.getParameter("srno");
    	String fname=code+'-'+doc+'-'+srno;
    	String fname2=fname;
//    	System.out.println("CODE==="+code);
	//	System.out.println("Code"+getFormdetailcode());
		String dirname =getFormdetailcode()==null?"Default":getFormdetailcode();
//    	System.out.println(dirname);
    	String path ="";
    	Connection conn = objconn.getMyConnection();
		Statement stmt = conn.createStatement ();
		String strSql = "select imgPath from my_comp where doc_no="+session.getAttribute("COMPANYID");
//		System.out.println(strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		String path1="";
		while(rs.next ()) {
			path1=rs.getString("imgPath");
//			System.out.println("IMGPATH:"+path);
		}
		path=path1.replace("\\", "/");
    	ServletContext context = ((HttpSession) request).getServletContext();
    	//String path = context.getRealPath("/");
    	
    	File dir = new File(path+ "/attachment/"+dirname);
   	 	dir.mkdirs();
        //
   	 	
//        System.out.println("path==============="+path);
        try {  
            File f = this.getFile();  
            //System.out.println("FILE==="+getFileFileName());
            if(this.getFileFileName().endsWith(".exe")){  
                message="not done";  
                return ERROR;  
            } 
          /*  String aa[]=getFileFileName().split(".");
//            System.out.println(aa);*/
            int dotindex=getFileFileName().lastIndexOf(".");
            String efile=getFileFileName().substring(dotindex+1);
//            System.out.println("EEEE"+efile);
            fname=fname+'.'+efile;
            FileInputStream inputStream = new FileInputStream(f);  
            
            FileOutputStream outputStream = new FileOutputStream(path + "/attachment/"+dirname+ "/"+ fname);
//            System.out.println("path==============="+path+"========="+outputStream);
            byte[] buf = new byte[1024];  
            int length = 0;  
            while ((length = inputStream.read(buf)) != -1) {  
                outputStream.write(buf, 0, length);  
            }  
            Statement stmtupdate=conn.createStatement();
            String strupdate="update gl_vinspd set attach='"+fname+"',path='"+path + "/attachment/"+dirname+ "/"+ fname+"' where rdocno="+doc+" and rowno="+srno ;
           /* String strinsert="insert into my_fileattach(dtype,doc_no,brhid,sr_no,imgno,date,user,path)values('"+code+"',"+doc+",'"+session.getAttribute("BRANCHID").toString()+"',"+
            			" "+srno+",'"+fname2+"',CURDATE(),'"+session.getAttribute("USERID").toString()+"','"+path + "/attachment/"+dirname+ "/"+ fname+"')";
//            System.out.println("Insert Attach"+strinsert);*/
            int val=stmtupdate.executeUpdate(strupdate);
           /*val=stmtupdate.executeUpdate(strinsert);*/
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
        finally{
        	conn.close();
        }
        return SUCCESS;  
    }  
}
