package com.email;

 import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

    import javax.servlet.http.HttpSession;

    import net.sf.json.JSONArray;

    import com.common.ClsCommon;
import com.connection.ClsConnection;
public class ClsEmailDAO  { 
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public  JSONArray dtypeSearch(HttpSession session) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
       
		try {
				Connection conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				//String sql="";
				//ResultSet resultSet ;
				//System.out.println("========="+brnchval);
            	
            		String sql="select distinct(dtype) as dtype from my_acbook  union all( select 'USER' as dtype from my_user limit 1); ";
            	//System.out.println("----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				conn.close();
            	

		}
		catch(Exception e){
			
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	public  JSONArray addressbook(HttpSession session,String name,String dtype) throws SQLException {

		System.out.println("inside addressbook");
        
		
		JSONArray RESULTDATA=new JSONArray();
           /*Enumeration<String> Enumeration = session.getAttributeNames();
           int a=0;
           while(Enumeration.hasMoreElements()){
            if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
             a=1;
            }
           }
           if(a==0){
         return RESULTDATA;
            }
             
           String brid=session.getAttribute("BRANCHID").toString();*/
       
        java.sql.Date sqlStartDate=null;
       
        
         /*dob.trim();
        if(!(dob.equalsIgnoreCase("undefined"))&&!(dob.equalsIgnoreCase(""))&&!(dob.equalsIgnoreCase("0")))
        {
        sqlStartDate = ClsCommon.changeStringtoSqlDate(dob);
        }*/
        
        
        String sqltest="";
        
        /*if(!(clientid.equalsIgnoreCase(""))){
            sqltest=sqltest+" and c.doc_no like '%"+clientid+"%'";
        }*/
        if(!(dtype.equalsIgnoreCase(""))){
         sqltest=sqltest+" and a.dtype like '%"+dtype+"%'";
        }
        if(!(name.equalsIgnoreCase(""))){
         sqltest=sqltest+"  and a.name like '%"+name+"%'";
        }
        /*if(!(lcno.equalsIgnoreCase(""))){
         sqltest=sqltest+" and d.dlno like '%"+lcno+"%'";
        }
        if(!(nation.equalsIgnoreCase(""))){
         sqltest=sqltest+" and d.nation like '%"+nation+"%'";
        }
         if(!(sqlStartDate==null)){
         sqltest=sqltest+" and d.dob='"+sqlStartDate+"'";
        } */
           
     try {
       Connection conn = ClsConnection.getMyConnection();
       Statement stmt = conn.createStatement ();
       
       String sql="select e_mail,dtype,name from ( select coalesce(mail1,mail2) as e_mail,dtype,refname as name from my_acbook  union all select email as e_mail,'USER' as dtype,user_name as name from my_user) as a "
       		+ "where 1=1 "+sqltest+"";
       
       ResultSet resultSet = stmt.executeQuery(sql);
       
       System.out.println("==sql===sql====sql===="+sql);
       
       /*ResultSet resultSet = stmtCRM.executeQuery("select c.doc_no clientid,trim(c.RefName) refname,trim(d.DLNO) dlno,d.dob,c.com_mob,c.tel,c.address,d.nation from my_acbook c left join "
          		+ "gl_drdetails d on d.cldocno=c.doc_no and d.dtype=c.dtype where status <> 7 and c.dtype='CRM' and c.brhId="+brid+"" +sqltest);
*/
       RESULTDATA=ClsCommon.convertToJSON(resultSet);
       stmt.close();
       conn.close();
     }
     catch(Exception e){
      e.printStackTrace();
     }
     
           return RESULTDATA;
       }

	
		    
}
