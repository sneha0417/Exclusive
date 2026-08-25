package com.humanresource.setup.preinduction;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.connection.*;
import com.common.*;

import net.sf.json.JSONArray;

public class ClspreinductionDAO {

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public  JSONArray searchMaster(HttpSession session,String gds,String msdocno,String des,String mmdate) throws SQLException {


 

		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}

	 
		String brid=session.getAttribute("BRANCHID").toString();



		java.sql.Date sqlStartDate=null;


		if(!(mmdate.equalsIgnoreCase("undefined"))&&!(mmdate.equalsIgnoreCase(""))&&!(mmdate.equalsIgnoreCase("0")))
		{
			sqlStartDate = ClsCommon.changeStringtoSqlDate(mmdate);
		}

		String sqltest="";
		if(!(msdocno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.voc_no like '%"+msdocno+"%'";
		}

		if(!(gds.equalsIgnoreCase(""))){
			sqltest=sqltest+" and g.desc1 like '%"+gds+"%'";
		}

		if(!(des.equalsIgnoreCase(""))){
			sqltest=sqltest+" and d.desc1 like '%"+des+"%'";
		}
		 

		if(!(sqlStartDate==null)){
			sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
		} 



		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();

			String clssql= ("select m.doc_no, m.date, m.refno, m.desc1, m.voc_no, m.designation, m.noof_pos, m.grade, m.sal_frm, "
					+ " m.sal_to, m.rep_to,d.desc1 des,g.desc1 grd,r.desc1 rep   from hr_designprem m "
					+ " left join hr_setdesig d on d.doc_no=m.designation left join hr_designgrade g on g.doc_no=m.grade "
					+ " left join hr_setdesig r on r.doc_no=m.rep_to where m.status=3 "+sqltest+"");
			System.out.println("====searchmaster===="+clssql);
			ResultSet resultSet = stmtenq1.executeQuery(clssql);

			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtenq1.close();
			conn.close();
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	
	public JSONArray loadtermssearch1(String doc_no) throws SQLException {
    	JSONArray RESULTDATA=new JSONArray();

	    Connection conn=null;
  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDES = conn.createStatement ();
            	
				String  sql=("select  rowno rownoss,  terms header from hr_designpretermsm where rdocno='"+doc_no+"'");
				
				ResultSet resultSet = stmtDES.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);

				stmtDES.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	
	
	public JSONArray loadtermssearch2(String doc_no) throws SQLException {
    	JSONArray RESULTDATA=new JSONArray();

	    Connection conn=null;
  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDES = conn.createStatement ();
            	
				String  sql=("select rowno, rdocno, terms desc1, refno from hr_designpretermsd where refno='"+doc_no+"'");
				
				ResultSet resultSet = stmtDES.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);

				stmtDES.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	

	
	public JSONArray search1() throws SQLException {
    	JSONArray RESULTDATA=new JSONArray();

	    Connection conn=null;
  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDES = conn.createStatement ();
            	
				String  sql=("select  doc_no designation1,desc1 designation2 from hr_setdesig where status=3");
				
				ResultSet resultSet = stmtDES.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);

				stmtDES.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	
	
	public JSONArray loadsearch1(String docno) throws SQLException {
    	JSONArray RESULTDATA=new JSONArray();

	    Connection conn=null;
  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDES = conn.createStatement ();    
		 
				String  sql=("select  q.doc_no qualdoc,q.desc1 qual,m.remarks from hr_designprequal m left join hr_designqual q on q.doc_no=m.qual where rdocno='"+docno+"'");
				
				

				
				ResultSet resultSet = stmtDES.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);

				stmtDES.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	public JSONArray loadsearch2(String docno) throws SQLException {
    	JSONArray RESULTDATA=new JSONArray();

	    Connection conn=null;
  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDES = conn.createStatement ();
			 
				String  sql=("select     exp expin, noof_yrs noof, mandatory mnd from hr_designpreexp where rdocno='"+docno+"'");
				
				ResultSet resultSet = stmtDES.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);

				stmtDES.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	public JSONArray loadsearch3(String docno) throws SQLException {
    	JSONArray RESULTDATA=new JSONArray();

	    Connection conn=null;
  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDES = conn.createStatement ();
            
			 
				String  sql=("select  inter_det desc1 from hr_designpreinter where rdocno='"+docno+"'");
				
				ResultSet resultSet = stmtDES.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);

				stmtDES.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	
	
	public int insert1(Date masterdate,   HttpSession session,
			HttpServletRequest request, String mode, int masterdoc_no,
			String refno, String desc1, int designationid, int noofpos,
			int gradeid, int fromsal, int tosal, int reportid,String frmcode,int docnos,
			ArrayList<String> descarray1, ArrayList<String> descarray2, ArrayList<String> descarray3) throws SQLException {
		
		
		
		Connection conn=null;

		try{
			
				conn=ClsConnection.getMyConnection(); 
 
				
				CallableStatement stmt = conn.prepareCall("{CALL HR_preinductionDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

				if(mode.equalsIgnoreCase("A"))
				{
					stmt.registerOutParameter(7, java.sql.Types.INTEGER);
					stmt.registerOutParameter(15, java.sql.Types.INTEGER);
				}
				
				else
				{
					stmt.setInt(7, masterdoc_no);
					stmt.setInt(15, docnos);
				}
				
		 
				stmt.setDate(1,masterdate);
				stmt.setString(2,refno);
                stmt.setString(3,desc1);
                stmt.setString(4,session.getAttribute("USERID").toString().trim());
				stmt.setString(5,session.getAttribute("BRANCHID").toString().trim());
				stmt.setString(6,frmcode);
				stmt.setInt(8,designationid);
				stmt.setInt(9,noofpos);
				stmt.setInt(10,gradeid);
				stmt.setInt(11,fromsal);
				stmt.setInt(12,tosal);
				stmt.setInt(13,reportid);
				stmt.setString(14,mode);
		 
				stmt.executeQuery();
				masterdoc_no=stmt.getInt("docNo"); 
				int vocno=stmt.getInt("vocNo");	
				request.setAttribute("vocno", vocno);
					
				if(masterdoc_no<=0){
					conn.close();
					return 0;
				}	     
					
				 if(mode.equalsIgnoreCase("E"))
				 {
					 
					 String sqlas1="delete from hr_designprequal where rdocno="+masterdoc_no+"";
					 stmt.executeUpdate(sqlas1);
					 String sqlas11="delete from hr_designpreexp where rdocno="+masterdoc_no+"";
					 stmt.executeUpdate(sqlas11);
					 String sqlas111="delete from hr_designpreinter where rdocno="+masterdoc_no+"";
					 stmt.executeUpdate(sqlas111);
					 
				 }
				
				 if(mode.equalsIgnoreCase("E") ||mode.equalsIgnoreCase("A"))
				 {
					 for(int i=0;i< descarray1.size();i++){
					 String[] arr1=descarray1.get(i).split("::");
					  
					 if(!(arr1[0].trim().equalsIgnoreCase("undefined")|| arr1[0].trim().equalsIgnoreCase("NaN")||arr1[0].trim().equalsIgnoreCase("")|| arr1[0].isEmpty()))
					 {
		
		    		 String sql="INSERT INTO hr_designprequal(qual,remarks,rdocno)VALUES("
		    				  + "'"+(arr1[0].trim().equalsIgnoreCase("undefined") || arr1[0].trim().equalsIgnoreCase("NaN")|| arr1[0].trim().equalsIgnoreCase("")|| arr1[0].isEmpty()?0:arr1[0].trim())+"',"
						       + "'"+(arr1[1].trim().equalsIgnoreCase("undefined") || arr1[1].trim().equalsIgnoreCase("NaN")|| arr1[1].trim().equalsIgnoreCase("")|| arr1[1].isEmpty()?0:arr1[1].trim())+"',"
						       +"'"+masterdoc_no+"')";
		    		 
		    		 System.out.println("========sql======1==="+sql);
		    		 
				     int resultSet2 = stmt.executeUpdate(sql);
				     
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
				     
				     
					 }
					}
				for(int i=0;i< descarray2.size();i++){              
					 String[] arr1=descarray2.get(i).split("::");
					  
			    if(!(arr1[0].trim().equalsIgnoreCase("undefined")|| arr1[0].trim().equalsIgnoreCase("NaN")||arr1[0].trim().equalsIgnoreCase("")|| arr1[0].isEmpty()))
			     {
		
		    		 String sql="INSERT INTO hr_designpreexp(exp, noof_yrs, mandatory ,rdocno)VALUES("
		    				  + "'"+(arr1[0].trim().equalsIgnoreCase("undefined") || arr1[0].trim().equalsIgnoreCase("NaN")|| arr1[0].trim().equalsIgnoreCase("")|| arr1[0].isEmpty()?0:arr1[0].trim())+"',"
						       + "'"+(arr1[1].trim().equalsIgnoreCase("undefined") || arr1[1].trim().equalsIgnoreCase("NaN")|| arr1[1].trim().equalsIgnoreCase("")|| arr1[1].isEmpty()?0:arr1[1].trim())+"',"
						     + "'"+(arr1[2].trim().equalsIgnoreCase("undefined") || arr1[2].trim().equalsIgnoreCase("NaN")||arr1[2].trim().equalsIgnoreCase("")|| arr1[2].isEmpty()?0:arr1[2].trim())+"',"
						       +"'"+masterdoc_no+"')";
		    		 System.out.println("========sql====2====="+sql);
		    		 
				     int resultSet2 = stmt.executeUpdate(sql);
				     
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
				     
				     
			     }
				}
				
				for(int i=0;i< descarray3.size();i++){              
					 String[] arr1=descarray3.get(i).split("::");
					  
			    if(!(arr1[0].trim().equalsIgnoreCase("undefined")|| arr1[0].trim().equalsIgnoreCase("NaN")||arr1[0].trim().equalsIgnoreCase("")|| arr1[0].isEmpty()))
			     {
		
		    		 String sql="INSERT INTO hr_designpreinter(inter_det,rdocno)VALUES("
		    				  + "'"+(arr1[0].trim().equalsIgnoreCase("undefined") || arr1[0].trim().equalsIgnoreCase("NaN")|| arr1[0].trim().equalsIgnoreCase("")|| arr1[0].isEmpty()?0:arr1[0].trim())+"',"
						       +"'"+masterdoc_no+"')";
		    		 System.out.println("========sql====3====="+sql);
				     int resultSet2 = stmt.executeUpdate(sql);
				     
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
				     
				     
			            }
				      }
				 }
				 
				
				if (masterdoc_no > 0) {
					stmt.close();
				 
					conn.close();
					return masterdoc_no;
				}		
		} catch (Exception e) {
			conn.close();
			e.printStackTrace();
		}
		return 0;
	}
	
	
	
}
