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
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;  

  










import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;  
  
@SuppressWarnings("serial")  
/* Removed Session for CARFARE CALL REGISTER DETAILING*/

public class ClsAttachmasterServiceDB extends ActionSupport {
	ClsConnection ClsConnection=new ClsConnection();
	
	private File file;  
    private String fileFileName;  
    private String fileFileContentType;  
    private String formdetailcode,frmnames,formnames;
    
    public String getFormnames() {
		return formnames;
	}

	public void setFormnames(String formnames) {
		this.formnames = formnames;
	}

	public String getFrmnames() {
		return frmnames;
	}

	public void setFrmnames(String frmnames) {
		this.frmnames = frmnames;
	}
	private String docno;
    
 
    public String getDocno() {
		return docno;
	}

	public void setDocno(String docno) {
		this.docno = docno;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
 public String txtdesc,reftype;
 
 
	public String getTxtdesc() {
	return txtdesc;
}

public void setTxtdesc(String txtdesc) {
	this.txtdesc = txtdesc;
}

 
 
	public String getReftype() {
	return reftype;
}

public void setReftype(String reftype) {
	this.reftype = reftype;
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
  public String brchid,msgs;
  
  
    public String getMsgs() {
	return msgs;
}

public void setMsgs(String msgs) {
	this.msgs = msgs;
}

	public String getBrchid() {
	return brchid;
}

public void setBrchid(String brchid) {
	this.brchid = brchid;
}

	@SuppressWarnings("deprecation")  
    public String executes() throws Exception { 
    	HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
   	String code=getFormdetailcode();
    	String doc=getDocno();
    	String desc= getTxtdesc();
    	String reftypid=getReftype();
    	
   	String branchids=getBrchid().trim().equalsIgnoreCase("")?"1":getBrchid();
   	
   	setFrmnames(getFormnames());
   	
	/*	String code="PO";
    	String doc="1";
    	String desc="noushad";
    	String reftypid="1";
    	
    	String branchids="1";*/
   	Connection conn =null;
	try { 
    	String srno="";
    	  conn = ClsConnection.getMyConnection();
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
		String strSql1 = "select imgPath from my_comp where doc_no=1";

		ResultSet rs1 = stmt1.executeQuery(strSql1);
		while(rs1.next ()) {
			path=rs1.getString("imgPath");
		}
		
    	ServletContext context = request.getServletContext();
    	File dir = new File(path+ "/attachment/"+dirname);
   	 	dir.mkdirs();
   	 	
            File f = this.getFile();  
            if(this.getFileFileName().endsWith(".exe")){  
                message="not done";  
                return "fail";  
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
			CallableStatement stmtAttach = conn.prepareCall("{CALL fileAttach(?,?,?,?,?,?,?,?,?)}");
			
			stmtAttach.registerOutParameter(9, java.sql.Types.INTEGER);
			stmtAttach.setString(1,code);
			stmtAttach.setString(2,doc);
			stmtAttach.setString(3,"1");
			stmtAttach.setString(4,"CLIENT");
			stmtAttach.setString(5,path+"\\attachment\\"+dirname+"\\"+ fname);
			stmtAttach.setString(6,fname);
			stmtAttach.setString(7,desc);
			stmtAttach.setString(8,reftypid);
			stmtAttach.executeQuery();
			int no=stmtAttach.getInt("srNo");
			if(no>0){
				conn.commit();
			}
			if(no<0){
				 conn.close();
				 setMsgs("Failed To Upload");
				  return "fail";
            }
			
            inputStream.close();  
            outputStream.flush();  
            this.setMessage(path+fname);
            stmt.close();
            stmtAttach.close();
            conn.close();
        
        } catch (Exception e) {  
            e.printStackTrace();  
          
         	 setMsgs("Failed To Upload");
         	 System.out.println("================Failed To Upload===============");
            conn.close();
            return "fail";
            
        }  
   	 	
   	 	
   	 setMsgs("Successfully Uploaded ");
     return "success";
        
    }
    
    public  JSONArray reGridload(String docno,String dtype) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        ClsCommon clcom=new ClsCommon();
		     try {
		       Connection conn = ClsConnection.getMyConnection();
		       Statement cpstmt = conn.createStatement();
		        String  cpsql="select sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no="+docno+" and a.dtype='"+dtype+"' order by sr_no";
		       
		       
		      System.out.println("====cpsql===="+cpsql);
		       
		       ResultSet resultSet = cpstmt.executeQuery(cpsql);
		       RESULTDATA=clcom.convertToJSON(resultSet);
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
		       
//		       Thread.sleep(10000);
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
 
/*package com.common;
import java.io.File;
import org.apache.commons.io.FileUtils;
import java.io.IOException; 

import com.opensymphony.xwork2.ActionSupport;

public class ClsAttach extends ActionSupport{
   private File myFile;
   private String myFileContentType;
   private String myFileFileName;
   private String destPath;

   public String execute()
   {
       Copy file to a safe location 
      destPath = "C:/apache-tomcat-6.0.33/work/";

      try{
     	 System.out.println("Src File name: " + myFile);
     	 System.out.println("Dst File name: " + myFileFileName);
     	    	 
     	 File destFile  = new File(destPath, myFileFileName);
    	 FileUtils.copyFile(myFile, destFile);
  
      }catch(IOException e){
         e.printStackTrace();
         return ERROR;
      }

      return SUCCESS;
   }
   public File getMyFile() {
      return myFile;
   }
   public void setMyFile(File myFile) {
      this.myFile = myFile;
   }
   public String getMyFileContentType() {
      return myFileContentType;
   }
   public void setMyFileContentType(String myFileContentType) {
      this.myFileContentType = myFileContentType;
   }
   public String getMyFileFileName() {
      return myFileFileName;
   }
   public void setMyFileFileName(String myFileFileName) {
      this.myFileFileName = myFileFileName;
   }
}*/