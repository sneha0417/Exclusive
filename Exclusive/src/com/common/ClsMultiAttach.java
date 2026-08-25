package com.common;

import java.io.File;  
import java.io.FileInputStream;  
import java.io.FileOutputStream;  
  
import java.net.InetAddress;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;  

import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;  
  
@SuppressWarnings("serial")  
public class ClsMultiAttach extends ActionSupport {
	ClsConnection ClsConnection=new ClsConnection();

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
  
      
    @Override  
    public String execute() throws Exception { 
    	HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
    	String code=request.getParameter("formCode");
    	String doc=request.getParameter("doc_no");
    	String desc=request.getParameter("descpt");
    	String reftypid=request.getParameter("reftypid");
    	String branchids=request.getParameter("branchids");
    	String drid=request.getParameter("drid");
    	
    	String srno="";
    	Connection conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		String strSql = "select coalesce(max(sr_no)+1,1) srno from my_fileattach where doc_no="+doc+" and dtype='"+code+"'";
		
		ResultSet rs = stmt.executeQuery(strSql);
		while(rs.next()) {
			srno=rs.getString("srno");
		}
		
    	String fname=code+'-'+doc+'-'+srno;
    	String fname2=fname;

    	String dirname =code==null?"Default":code;
    	String path ="";
		Statement stmt1 = conn.createStatement();
		
		String strSql1 = "select imgPath from my_comp where doc_no="+session.getAttribute("COMPANYID");
		ResultSet rs1 = stmt1.executeQuery(strSql1);

		while(rs1.next ()) {
			path=rs1.getString("imgPath");
		}
		
//    	ServletContext context = request.getServletContext();
    	File dir = new File(path+ "/attachment/"+dirname);
   	 	dir.mkdirs();

   	 	try {  
            File f = this.getFile();  
            if(this.getFileFileName().endsWith(".exe")){  
                message="not done";  
                return ERROR;  
            } 

            int dotindex=getFileFileName().lastIndexOf(".");
            String efile=getFileFileName().substring(dotindex+1);
            fname=fname+'.'+efile;
            FileInputStream inputStream = new FileInputStream(f);  
            FileOutputStream outputStream = new FileOutputStream(path +"/attachment/"+dirname+"/"+ fname);
            byte[] buf = new byte[3072];  
            int length = 0;  
            
            while ((length = inputStream.read(buf)) != -1) {
                outputStream.write(buf, 0, length);  
            }  
			conn.setAutoCommit(false);
			CallableStatement stmtAttach = conn.prepareCall("{CALL fileMultiAttach(?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtAttach.registerOutParameter(10, java.sql.Types.INTEGER);
			stmtAttach.registerOutParameter(11, java.sql.Types.INTEGER);
			
			stmtAttach.setString(1,code);
			stmtAttach.setString(2,doc);
			stmtAttach.setString(3,session.getAttribute("BRANCHID")==null?branchids:session.getAttribute("BRANCHID").toString());
			stmtAttach.setString(4,session.getAttribute("USERNAME").toString());
			stmtAttach.setString(5,path+"\\attachment\\"+dirname+"\\"+ fname);
			stmtAttach.setString(6,fname);
			stmtAttach.setString(7,desc);
			stmtAttach.setString(8,reftypid);
			stmtAttach.setString(9,drid);
			stmtAttach.executeQuery();
			int no=stmtAttach.getInt("srNo");
			if(no<0){
            	return ERROR;
            }
			if(no>0){
				conn.commit();
			}
			
            inputStream.close();  
            outputStream.flush();  
            this.setMessage(path+fname);
            stmt.close();
            stmtAttach.close();
            conn.close();
        
        } catch (Exception e) {  
            e.printStackTrace();  
            message = "!!!!";
            conn.close();
            
        }
        return SUCCESS;  
    }
    
    public  JSONArray reGridload(String docno,String drId, String dtype) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        ClsCommon ClsCommon=new ClsCommon();
		     try {
		       Connection conn = ClsConnection.getMyConnection();
		       Statement cpstmt = conn.createStatement();
		        
		        String cpsql="select a.doc_no sr_no,a.dtype extension,a.description,a.attach filename,replace(replace(replace(path,'\\\\',';'),' ','%20'),'#','%23') path,coalesce(at.type_name,'') as type "
		        		+ "from gl_drattachdet a left join my_attach_type at on(at.doc_no=a.ref_id) where a.status=3 and a.rdocno="+docno+" and a.dr_id="+drId+" and a.dtype='"+dtype+"' "
		        		+ "order by a.doc_no";
		       
		        System.out.println("==cpsql=="+cpsql);
		       ResultSet resultSet = cpstmt.executeQuery(cpsql);
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
		       cpstmt.close();
		       conn.close();
		     }
		     catch(Exception e){
		      e.printStackTrace();
		     }
           return RESULTDATA;
       }
    
    public  JSONObject reload(String docno) throws SQLException {
        JSONObject obj = new JSONObject();
        String data="";
		     try {
		    	 Connection conn = ClsConnection.getMyConnection();
		         Statement cpstmt = conn.createStatement();
		       
		         String  cpsql="select sr_no,dtype extension,descpt description,filename,replace(path,'\\\\',';') path from my_fileattach where status = 3 and doc_no="+docno+" order by sr_no desc limit 1 ";
		       
		       ResultSet resultSet = cpstmt.executeQuery(cpsql);
		       while (resultSet.next()) {
					int total_rows = resultSet.getMetaData().getColumnCount();
					for (int i = 0; i < total_rows; i++) {
						obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), ((resultSet.getObject(i + 1)==null) ? "NA" : resultSet.getObject(i + 1).toString()));
					}

					}
		       data=obj.toString();
		       cpstmt.close();
		       conn.close();
		     }
		     catch(Exception e){
		      e.printStackTrace();
		     }
           return obj;
       }
}
