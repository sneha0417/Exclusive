package com.support;


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

  













import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;  
  
@SuppressWarnings("serial")  
public class ClsSupport extends ActionSupport {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
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
    	String code=request.getParameter("compname");
    	String doc=request.getParameter("date");
    	String userfrmid=request.getParameter("userfrmid").trim();
    	String usertoid=request.getParameter("usertoid").trim();
    	
    	
    	String srno="";
    	Connection conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();

		// Statement stmt = conn.createStatement();
		 String strSql2 = "select coalesce(max(asrno)+1,1) as srno from gw_mesngr where userfrm="+userfrmid;
		 //System.out.println("====strSql======="+strSql2);
		 ResultSet rs2 = stmt.executeQuery(strSql2);
		 while(rs2.next ()) {
			 srno=rs2.getString("srno");
//		 	System.out.println("IMGPATH:"+path);
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
		
    	ServletContext context = request.getServletContext();
    	File dir = new File(path+ "/attachment/"+dirname);
   	 	dir.mkdirs();

   	 	try {  
            File f = this.getFile();  
            if(this.getFileFileName().endsWith(".exe")){  
                message="not done";  
                return ERROR;  
            } 

            
            java.util.Date date=new java.util.Date();
            java.sql.Date sd=ClsCommon.getSqlDate(date);
            
            int dotindex=getFileFileName().lastIndexOf(".");
            //System.out.println("===dotindex===="+dotindex);
            
            String efile=getFileFileName().substring(dotindex+1);
            
            //System.out.println("===efile===="+efile);
            
            fname2=fname2+'.'+efile;
            FileInputStream inputStream = new FileInputStream(f);  
            FileOutputStream outputStream = new FileOutputStream(path +"/attachment/"+dirname+"/"+ fname2);
            byte[] buf = new byte[3072];  
            int length = 0;  
            
            while ((length = inputStream.read(buf)) != -1) {
                outputStream.write(buf, 0, length);  
            }  
			conn.setAutoCommit(false);
			String strSql = "insert into gw_mesngr(userfrm, userto, mesg, date,attachpath,udate,asrno) values("+userfrmid+",'"+usertoid+"','"+fname2+"','"+sd+"','"+path +"/attachment/"+code+ "/"+ fname2+"','"+date+"','"+srno+"')";
			//System.out.println("strSql======"+strSql);
			int rs = stmt.executeUpdate(strSql);
			conn.commit();
            inputStream.close();  
            outputStream.flush();  
            stmt.close();
            conn.close();
        
        } catch (Exception e) {  
            e.printStackTrace();  
            message = "!!!!";
            conn.close();
            
        }  
        return SUCCESS;  
    }
    
    public  JSONArray convertToJSON(ResultSet resultSet)
			throws Exception {
			JSONArray jsonArray = new JSONArray();
			
			while (resultSet.next()) {
			int total_rows = resultSet.getMetaData().getColumnCount();
			JSONObject obj = new JSONObject();
			for (int i = 0; i < total_rows; i++) {
				 /*obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), (resultSet.getObject(i + 1)==null) ? "NA" : ((resultSet.getObject(i + 1).equals("0.0000")) ? " " : (resultSet.getObject(i + 1).toString()).replaceAll("[^a-zA-Z0-9_-_._; ]", " ")));*/
				 obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), ((resultSet.getObject(i + 1)==null) ? "NA" : resultSet.getObject(i + 1).toString()));
			}
			jsonArray.add(obj);
			}
			//System.out.println("ConvertTOJson:   "+jsonArray);
			return jsonArray;
			}

    
    
    
    public  JSONArray msghistoryload(String userfrmid,String usertoid) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
		     try {
		       Connection conn = ClsConnection.getMyConnection();
		       Statement cpstmt = conn.createStatement();
		       Statement stmt = conn.createStatement ();
		       String  cpsql="select uf.apath as image,UPPER(uf.user_id) as user,mesg,m.udate as date,attachpath as path,is_read from gw_mesngr m inner join gw_userlist uf on(uf.doc_no=userfrm) inner join gw_userlist ut on(ut.doc_no=userto ) where  ut.doc_no in ('"+userfrmid+"','"+usertoid+"') and    uf.doc_no in ('"+userfrmid+"','"+usertoid+"')   order by m.doc_no desc";
		       
		       //System.out.println("select uf.apath as image,UPPER(uf.user_id) as user,mesg,m.udate as date,attachpath as path,is_read from gw_mesngr m inner join gw_userlist uf on(uf.doc_no=userfrm) inner join gw_userlist ut on(ut.doc_no=userto ) where  ut.doc_no in ('"+userfrmid+"','"+usertoid+"') and    uf.doc_no in ('"+userfrmid+"','"+usertoid+"')   order by m.doc_no desc");
		       
		       ResultSet resultSet = cpstmt.executeQuery(cpsql);
		       RESULTDATA=convertToJSON(resultSet);
		       
		       //Thread.sleep(1000);
		       
		       String updateSql = "update gw_mesngr set is_read=1  where userfrm='"+usertoid+"' ";
		  
		   	int rsupdate = stmt.executeUpdate(updateSql);
		       
		       cpstmt.close();
		       conn.close();
		     }
		     catch(Exception e){
		      e.printStackTrace();
		     }
           return RESULTDATA;
       }
    
    public  JSONArray userSearch(HttpSession session) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn =null;
        Statement stmtVeh =null;
		try {
				 conn = ClsConnection.getMyConnection();
				 stmtVeh = conn.createStatement ();
				 //String currentuser=session.getAttribute("USERID").toString();
				//String sql=""; 
				//ResultSet resultSet ;
				//System.out.println("========="+brnchval);
            	
            		//String sql="select user_id as user,doc_no  from my_user WHERE STATUS=3 and doc_no<>'"+currentuser+"' order by doc_no";
				 //count(*) as msgcount,
				 String sql="select concat(upper(c.comp_code),'  :',upper(u.user_id)) as user,u.doc_no as doc_no,is_read from gw_mesngr m inner join gw_userlist u on(userfrm=u.doc_no)inner join gw_complist c on(c.doc_no=u.comp_id) where is_read=0 and c.comp_id<>'"+session.getAttribute("COMPANYREFID").toString()+"' group by user_id" ;
				 
            	//System.out.println("-userSearch---"+sql);
            		 ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				
            	

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmtVeh.close();
				conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
    
    
    public  JSONArray companyList(HttpSession session) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn =null;
        Statement stmtVeh =null;
		try {
				 conn = ClsConnection.getMyConnection();
				 stmtVeh = conn.createStatement ();
				 //String currentuser=session.getAttribute("USERID").toString();
				//String sql="";
				//ResultSet resultSet ;
				//System.out.println("========="+brnchval);
            	
            		//String sql="select user_id as user,doc_no  from my_user WHERE STATUS=3 and doc_no<>'"+currentuser+"' order by doc_no";
				 //count(*) as msgcount,
				 String sql="select company,comp_id,com_id from (select upper(c.comp_code) as company,doc_no as comp_id,c.comp_id as com_id from  gw_complist c union all select 'SELECT COMPANY ' as company,0 comp_id,0 as com_id) as a  where a.com_id<>'"+session.getAttribute("COMPANYREFID").toString()+"' order by comp_id" ;
				 
            	//System.out.println("----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				
            	

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmtVeh.close();
				conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
    
    public  JSONArray statusList(HttpSession session) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn =null;
        Statement stmtVeh =null;
		try {
				 conn = ClsConnection.getMyConnection();
				 stmtVeh = conn.createStatement ();
				 //String currentuser=session.getAttribute("USERID").toString();
				//String sql="";
				//ResultSet resultSet ;
				//System.out.println("========="+brnchval);
            	
            		//String sql="select user_id as user,doc_no  from my_user WHERE STATUS=3 and doc_no<>'"+currentuser+"' order by doc_no";
				 //count(*) as msgcount,
				 String sql="select id as status_id,sta as status from ((select 1 as id,'Available' as sta) union all (select 2 as id,'Away' as sta)) as a;" ;
				 
            	//System.out.println("----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				
            	

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmtVeh.close();
				conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
    
	
    public  JSONArray userList(HttpSession session,String comp_id) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn =null;
        Statement stmtVeh =null;
		try {
				 conn = ClsConnection.getMyConnection();
				 stmtVeh = conn.createStatement ();
				 //String currentuser=session.getAttribute("USERID").toString();
				//String sql="";
				//ResultSet resultSet ;
				//System.out.println("========="+brnchval);
            	
            		//String sql="select user_id as user,doc_no  from my_user WHERE STATUS=3 and doc_no<>'"+currentuser+"' order by doc_no";
				 //count(*) as msgcount,
				 String sql="select concat(upper(c.comp_code),'  :',upper(u.user_id)) as user,u.doc_no as doc_no,coalesce(is_read,1) as is_read from  gw_userlist u inner join gw_complist c on(c.doc_no=u.comp_id) left join  gw_mesngr m on(m.userfrm=u.doc_no and is_read=0) where c.doc_no='"+comp_id+"' group by user order by c.doc_no" ;
				 
            	//System.out.println("--userList--"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				
            	

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmtVeh.close();
				conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }

    

}
