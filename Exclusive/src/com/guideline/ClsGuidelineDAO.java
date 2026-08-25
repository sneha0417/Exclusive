package com.guideline;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;


public class ClsGuidelineDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public  JSONArray menuLoad(HttpSession session) throws SQLException{
		
		JSONArray RESULTDATA=new JSONArray();
   	    Enumeration<String> Enumeration = session.getAttributeNames();
   	    int a=0;
    	
   	    Connection conn = null;
   	    
  			try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement();
            	
				/*String sql= ("select a.doc_type as doc_type,a.menu_name as menu_name,a.menu_id as menu_id,m.ref_no as ref_no from ((select doc_type,menu_name,mno as menu_id from my_menu where mno not in (select pmenu from my_menu) and gate='E' )union all (select d.description as doc_type,m.description as menu_name,CONVERT(coalesce(d.doc_No,''),char(15)) as menu_id from gl_bibm m inner join gl_bibd d on(m.doc_no=d.rdocno) where m.status=1 and d.status=1 order by d.rdocno, d.srno)) as a left join my_guidline m on(a.doc_type=m.doc_type)" );*/
				
				String sql= ("select a.doc_type as doc_type,a.menu_name as menu_name,a.menu_id as menu_id,m.ref_no as ref_no from ((select doc_type,menu_name,mno as menu_id "
						+ "from my_menu where mno not in (select pmenu from my_menu) and gate='E' ) union all (select d.description as doc_type,m.description as menu_name,"
						+ "CONVERT(coalesce(d.doc_No,''),char(15)) as menu_id from gl_bibm m inner join gl_bibd d on(m.doc_no=d.rdocno) where m.status=1 and d.status=1 "
						+ "order by d.rdocno, d.srno)) as a left join my_guidline m "
						+ "on(a.doc_type=m.doc_type)");
				
				ResultSet resultSet = stmt.executeQuery(sql) ;
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmt.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
	}
	
	public  JSONArray descLoad(String doctype) throws SQLException{
		
		JSONArray RESULTDATA=new JSONArray();
   	    int a=0;
    	
   	    Connection conn = null;
        
  			try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement();
            	
				String sql= ("SELECT gdesc as description  FROM my_guidlinedet m where doc_type='"+doctype+"' and det_type='desc'" );

				ResultSet resultSet = stmt.executeQuery(sql) ;
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmt.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
	}
	
	public  JSONArray fieldLoad(String doctype) throws SQLException{
		JSONArray RESULTDATA=new JSONArray();
   	    int a=0;
    	
   	    Connection conn = null; 
        
  			try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement();
            	
				String sql= ("SELECT field_name as fieldname,gdesc as description  FROM my_guidlinedet m where doc_type='"+doctype+"' and det_type='fdesc'" );

				ResultSet resultSet = stmt.executeQuery(sql) ;
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmt.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
	}
	
	public  JSONArray noteLoad(String doctype) throws SQLException{
		JSONArray RESULTDATA=new JSONArray();
   	    int a=0;
    	
   	    Connection conn = null;
        
  			try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement();
            	
				String sql= ("SELECT gdesc as notes  FROM my_guidlinedet m where doc_type='"+doctype+"' and det_type='notes'" );

				ResultSet resultSet = stmt.executeQuery(sql) ;
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmt.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
	}
	
	public  JSONArray mandotryGridLoad(int statusid,String type) throws SQLException{
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
		
   	    int a=0;
    	int typeid=0;
   	    if(type.equals("IENQ")){
   	    	typeid=1;
   	    }
   	    if(type.equals("IJCE")){
   		   typeid=2;
   	    }
        
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
        	
			String sql= ("select  mandatory,description,srno from is_pgline where status_id="+statusid+" and status<>7 and type_id="+typeid+"" );

			ResultSet resultSet = stmt.executeQuery(sql) ;
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			
			stmt.close();
			conn.close();
	   }catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
	}
	
	public int insert(String refno,String menuid,java.sql.Date sqlDate,String doc_type, String menu_name ,ArrayList descgrid, ArrayList fieldgrid,ArrayList notegrid) throws SQLException{
		
		Connection conn=null;
		CallableStatement stmt=null;
		
		int  result=0;
		int resultSetd=0;
		int resultSetf=0;
		int resultSetn=0;
		
		try{
			
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
		
			
			stmt = conn.prepareCall("{CALL  MguideLineDML(?,?,?,?,?)}");
			stmt.registerOutParameter(4, java.sql.Types.INTEGER);
			stmt.setString(1,doc_type);
			stmt.setString(2,menu_name);
			stmt.setDate(3,sqlDate);
			stmt.setString(5,refno);
			stmt.executeQuery();
			
			 int resultm=1;
		   if(resultm>0)
		   {
			   for(int i=0;i< descgrid.size() ;i++){
					  String[] descgridarray=((String) descgrid.get(i)).split("::");
					  
					   String tclsql="";
					   int j=1;
					   tclsql="INSERT INTO my_guidlinedet(det_type, doc_type,date,status, gdesc) values('desc','"+doc_type+"','"+sqlDate+"',3,"
								  + "'"+(descgridarray[0].trim().equalsIgnoreCase("undefined")||descgridarray[0]==null  || descgridarray[0].trim().equalsIgnoreCase("") || descgridarray[0].trim().equalsIgnoreCase("NaN")|| descgridarray[0].isEmpty()?0:descgridarray[0].trim())+"')";
	
								  resultSetd = stmt.executeUpdate (tclsql);
								  j=j+1;
								  if(resultSetd<=0)
								     {
									  result=0;
								    	 return 0; 
								     }
								  result=1;
					   
			   }
		   }
		   
		   if(resultm>0)
		   {
			   for(int i=0;i< fieldgrid.size() ;i++){
					  String[] fieldgridarray=((String) fieldgrid.get(i)).split("::");
					  
					   String tclsql="";
					   int j=1;
					   
					   
					   
					   tclsql="INSERT INTO my_guidlinedet( det_type, doc_type,date,status ,field_name, gdesc) values('fdesc','"+doc_type+"','"+sqlDate+"',3,"
							   + "'"+(fieldgridarray[0].trim().equalsIgnoreCase("undefined")||fieldgridarray[0]==null  || fieldgridarray[0].trim().equalsIgnoreCase("") || fieldgridarray[0].trim().equalsIgnoreCase("NaN")|| fieldgridarray[0].isEmpty()?"":fieldgridarray[0].trim())+"',"
							   + "'"+(fieldgridarray[1].trim().equalsIgnoreCase("undefined")||fieldgridarray[1]==null  || fieldgridarray[1].trim().equalsIgnoreCase("") || fieldgridarray[1].trim().equalsIgnoreCase("NaN")|| fieldgridarray[1].isEmpty()?0:fieldgridarray[1].trim())+"')";
	
								  
								  resultSetf = stmt.executeUpdate (tclsql);
								  j=j+1;
								  if(resultSetf<=0)
								     {
									  result=0;
								    	 return 0; 
								     }
								  result=1;
					   
			   }
		   }
		   
		   if(resultm>0)
		   {
			   for(int i=0;i< notegrid.size() ;i++){
					  String[] notesgridarray=((String) notegrid.get(i)).split("::");
					 
					   String tclsql="";
					   int j=1;
					   tclsql="INSERT INTO my_guidlinedet( det_type, doc_type,date,status,gdesc) values('notes','"+doc_type+"','"+sqlDate+"',3,"
							   + "'"+(notesgridarray[0].trim().equalsIgnoreCase("undefined")||notesgridarray[0]==null  || notesgridarray[0].trim().equalsIgnoreCase("") || notesgridarray[0].trim().equalsIgnoreCase("NaN")|| notesgridarray[0].isEmpty()?0:notesgridarray[0].trim())+"')";
								  
								  resultSetn = stmt.executeUpdate (tclsql);
								  j=j+1;
								  if(resultSetn<=0)
								     {
									  result=0;
								    	 return 0; 
								     }
								  result=1;
					   
			   }
		   }
		   
		   if(resultm>0)
		   {
		   
		   conn.commit();
		  
		   }
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			 stmt.close();
			 conn.close();
		}
		return result;
	}
	
	public  ClsGuidelineBean getPrint(HttpServletRequest request,String formCode) throws SQLException {
		ClsGuidelineBean bean = new ClsGuidelineBean();
		
		Connection conn = null;
		
	try {
		
		conn = ClsConnection.getMyConnection();
		Statement stmtGuideline = conn.createStatement();
		
		String sqls="";
		
		sqls="select ref_no from my_guidline where doc_type='"+formCode+"'";
		
		ResultSet resultSets = stmtGuideline.executeQuery(sqls);
		
		while(resultSets.next()){
			bean.setLblrefno(resultSets.getString("ref_no"));
		}
		
		String sql = "";
		
		sql="select gdesc from my_guidlinedet where det_type='desc' and status=3 and doc_type='"+formCode+"'";
			
		ResultSet resultSet = stmtGuideline.executeQuery(sql);
		
		ArrayList<String> guidearray= new ArrayList<String>();
		
		while(resultSet.next()){

			String temp="";
			temp=resultSet.getString("gdesc");
			guidearray.add(temp);
		}
		request.setAttribute("guidelinesarray", guidearray);
		
		
		String sql1 = "";
		
		sql1="select field_name,gdesc from my_guidlinedet where det_type='fdesc' and status=3 and doc_type='"+formCode+"'";
		
		ResultSet resultSet1 = stmtGuideline.executeQuery(sql1);
		
		ArrayList<String> howworksarray= new ArrayList<String>();
		
		while(resultSet1.next()){

			String temp1="";
			temp1=resultSet1.getString("field_name")+"::"+resultSet1.getString("gdesc");
		    howworksarray.add(temp1);
		}
		request.setAttribute("howitworkarray", howworksarray);
		
		String sql2 = "";
		
		sql2="select gdesc from my_guidlinedet where det_type='notes' and status=3 and doc_type='"+formCode+"'";

		ResultSet resultSet2 = stmtGuideline.executeQuery(sql2);
		
		ArrayList<String> notearray= new ArrayList<String>();
		
		while(resultSet2.next()){

			String temp2="";
			temp2=resultSet2.getString("gdesc");
			notearray.add(temp2);
		}
		request.setAttribute("notesarray", notearray);
		
		stmtGuideline.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}finally{
		conn.close();
	}
	return bean;
 }
	
	public  ClsGuidelineBean getPrintDashBoard(HttpServletRequest request,String formDetailName) throws SQLException {
		ClsGuidelineBean bean = new ClsGuidelineBean();
		Connection conn = null;
	try {
		
		conn = ClsConnection.getMyConnection();
		Statement stmtGuideline = conn.createStatement();
		
		String sqls="";
		
		sqls="select ref_no from my_guidline where doc_type='"+formDetailName+"'";
		
		ResultSet resultSets = stmtGuideline.executeQuery(sqls);
		
		while(resultSets.next()){
			bean.setLblrefno(resultSets.getString("ref_no"));
		}
		
		String sql = "";
		
		sql="select gdesc from my_guidlinedet where det_type='desc' and status=3 and doc_type='"+formDetailName+"'";
			
		ResultSet resultSet = stmtGuideline.executeQuery(sql);
		
		ArrayList<String> guidearray= new ArrayList<String>();
		
		while(resultSet.next()){

			String temp="";
			temp=resultSet.getString("gdesc");
			guidearray.add(temp);
		}
		request.setAttribute("guidelinesarray", guidearray);
		
		
		String sql1 = "";
		
		sql1="select field_name,gdesc from my_guidlinedet where det_type='fdesc' and status=3 and doc_type='"+formDetailName+"'";
		
		ResultSet resultSet1 = stmtGuideline.executeQuery(sql1);
		
		ArrayList<String> howworksarray= new ArrayList<String>();
		
		while(resultSet1.next()){

			String temp1="";
			temp1=resultSet1.getString("field_name")+"::"+resultSet1.getString("gdesc");
		    howworksarray.add(temp1);
		}
		request.setAttribute("howitworkarray", howworksarray);
		
		String sql2 = "";
		
		sql2="select gdesc from my_guidlinedet where det_type='notes' and status=3 and doc_type='"+formDetailName+"'";

		ResultSet resultSet2 = stmtGuideline.executeQuery(sql2);
		
		ArrayList<String> notearray= new ArrayList<String>();
		
		while(resultSet2.next()){

			String temp2="";
			temp2=resultSet2.getString("gdesc");
			notearray.add(temp2);
		}
		request.setAttribute("notesarray", notearray);
		
		stmtGuideline.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}finally{
		conn.close();
	}
	return bean;
}


	 
	

}
