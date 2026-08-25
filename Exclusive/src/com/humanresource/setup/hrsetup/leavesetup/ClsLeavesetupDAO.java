package com.humanresource.setup.hrsetup.leavesetup;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsLeavesetupDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	public int insert(int refno, int catid,String mode, String fromcode, HttpSession session, HttpServletRequest request, ArrayList<String> mainarray, ArrayList<String> subarray) throws SQLException {
		 
		Connection conn=null;

		try{
			
				conn=ClsConnection.getMyConnection();
			    conn.setAutoCommit(false);
			    Statement stmt=conn.createStatement();
			
			    String leavid="";
			    for(int i=0;i<1;i++){
				 
			    	String[] mainarraydesc=mainarray.get(i).split("::");
			     
			     
			        leavid=""+(mainarraydesc[0].trim().equalsIgnoreCase("undefined") || mainarraydesc[0].trim().equalsIgnoreCase("NaN")|| mainarraydesc[0].trim().equalsIgnoreCase("")|| mainarraydesc[0].isEmpty()?0:mainarraydesc[0].trim())+"";
			        int rowno=0;
			     
			        String sqls="select rowno from hr_payleavem where levid='"+leavid+"' and rdocno='"+refno+"' ";
			        ResultSet rs=stmt.executeQuery(sqls);
			     
			        if(rs.next()) {
			    	  rowno=rs.getInt("rowno");
			    	 
			    	  String sqlss="delete from hr_payleavem where levid='"+leavid+"' and rdocno='"+refno+"' ";
			    	  stmt.executeUpdate(sqlss);
			    	  
			    	  String sqlsss="delete from hr_payleaved where levid='"+leavid+"' and rdocno='"+refno+"' ";
			    	  stmt.executeUpdate(sqlsss);
			        }
			     
			        int cf=0;int ded=0; 	 
			    
			        if(!(mainarraydesc[0].trim().equalsIgnoreCase("undefined")|| mainarraydesc[0].trim().equalsIgnoreCase("NaN")||mainarraydesc[0].trim().equalsIgnoreCase("")|| mainarraydesc[0].isEmpty())) {

			    	  if(mainarraydesc[1].trim().equalsIgnoreCase("true")) {
			    		  cf=1;	
					  } else {
						  cf=0;
					  }
				    
			    	  if(mainarraydesc[2].trim().equalsIgnoreCase("true")) {
			    		  ded=1;	
					  } else {
						  ded=0;
					  }
			    	  
			    	  if(rowno>0) {
			    		  
			          String sql="INSERT INTO hr_payleavem(rowno,levid,cf,ded,l1,l2,l3,l1ded,l2ded,l3ded,rdocno,status)VALUES"
						      + " ('"+rowno+"','"+(mainarraydesc[0].trim().equalsIgnoreCase("undefined") || mainarraydesc[0].trim().equalsIgnoreCase("NaN")|| mainarraydesc[0].trim().equalsIgnoreCase("")|| mainarraydesc[0].isEmpty()?0:mainarraydesc[0].trim())+"',"
						      + ""+cf+","
						      + ""+ded+","
						      + "'"+(mainarraydesc[3].trim().equalsIgnoreCase("undefined") || mainarraydesc[3].trim().equalsIgnoreCase("NaN")|| mainarraydesc[3].trim().equalsIgnoreCase("")|| mainarraydesc[3].isEmpty()?0:mainarraydesc[3].trim())+"',"
						      + "'"+(mainarraydesc[4].trim().equalsIgnoreCase("undefined") || mainarraydesc[4].trim().equalsIgnoreCase("NaN")|| mainarraydesc[4].trim().equalsIgnoreCase("")|| mainarraydesc[4].isEmpty()?0:mainarraydesc[4].trim())+"',"
						      + "'"+(mainarraydesc[5].trim().equalsIgnoreCase("undefined") || mainarraydesc[5].trim().equalsIgnoreCase("NaN")|| mainarraydesc[5].trim().equalsIgnoreCase("")|| mainarraydesc[5].isEmpty()?0:mainarraydesc[5].trim())+"',"
						      + "'"+(mainarraydesc[6].trim().equalsIgnoreCase("undefined") || mainarraydesc[6].trim().equalsIgnoreCase("NaN")|| mainarraydesc[6].trim().equalsIgnoreCase("")|| mainarraydesc[6].isEmpty()?0:mainarraydesc[6].trim())+"',"
						      + "'"+(mainarraydesc[7].trim().equalsIgnoreCase("undefined") || mainarraydesc[7].trim().equalsIgnoreCase("NaN")|| mainarraydesc[7].trim().equalsIgnoreCase("")|| mainarraydesc[7].isEmpty()?0:mainarraydesc[7].trim())+"',"
						      + "'"+(mainarraydesc[8].trim().equalsIgnoreCase("undefined") || mainarraydesc[8].trim().equalsIgnoreCase("NaN")|| mainarraydesc[8].trim().equalsIgnoreCase("")|| mainarraydesc[8].isEmpty()?0:mainarraydesc[8].trim())+"',"
						      +"'"+refno+"',3)";
			                   
						     int resultSet2 = stmt.executeUpdate(sql);
						     if(resultSet2<=0)
								{
									conn.close();
									return 0;
								}
					   }  else { // row no case 
		           
					  String sql="INSERT INTO hr_payleavem(levid,cf,ded,l1,l2,l3,l1ded,l2ded,l3ded,rdocno,status)VALUES"
						      + " ('"+(mainarraydesc[0].trim().equalsIgnoreCase("undefined") || mainarraydesc[0].trim().equalsIgnoreCase("NaN")|| mainarraydesc[0].trim().equalsIgnoreCase("")|| mainarraydesc[0].isEmpty()?0:mainarraydesc[0].trim())+"',"
						      + ""+cf+","
						      + ""+ded+","
						      + "'"+(mainarraydesc[3].trim().equalsIgnoreCase("undefined") || mainarraydesc[3].trim().equalsIgnoreCase("NaN")|| mainarraydesc[3].trim().equalsIgnoreCase("")|| mainarraydesc[3].isEmpty()?0:mainarraydesc[3].trim())+"',"
						      + "'"+(mainarraydesc[4].trim().equalsIgnoreCase("undefined") || mainarraydesc[4].trim().equalsIgnoreCase("NaN")|| mainarraydesc[4].trim().equalsIgnoreCase("")|| mainarraydesc[4].isEmpty()?0:mainarraydesc[4].trim())+"',"
						      + "'"+(mainarraydesc[5].trim().equalsIgnoreCase("undefined") || mainarraydesc[5].trim().equalsIgnoreCase("NaN")|| mainarraydesc[5].trim().equalsIgnoreCase("")|| mainarraydesc[5].isEmpty()?0:mainarraydesc[5].trim())+"',"
						      + "'"+(mainarraydesc[6].trim().equalsIgnoreCase("undefined") || mainarraydesc[6].trim().equalsIgnoreCase("NaN")|| mainarraydesc[6].trim().equalsIgnoreCase("")|| mainarraydesc[6].isEmpty()?0:mainarraydesc[6].trim())+"',"
						      + "'"+(mainarraydesc[7].trim().equalsIgnoreCase("undefined") || mainarraydesc[7].trim().equalsIgnoreCase("NaN")|| mainarraydesc[7].trim().equalsIgnoreCase("")|| mainarraydesc[7].isEmpty()?0:mainarraydesc[7].trim())+"',"
						      + "'"+(mainarraydesc[8].trim().equalsIgnoreCase("undefined") || mainarraydesc[8].trim().equalsIgnoreCase("NaN")|| mainarraydesc[8].trim().equalsIgnoreCase("")|| mainarraydesc[8].isEmpty()?0:mainarraydesc[8].trim())+"',"
						      +"'"+refno+"',3)";
	                   
				     int resultSet2 = stmt.executeUpdate(sql);
				     if(resultSet2<=0) {
							conn.close();
							return 0;
						}
			        }
	       	}
			      
		    if(Integer.parseInt(leavid)>0) {
			
			for(int j=0;j<subarray.size();j++){
				 
			     String[] subarraysec=subarray.get(j).split("::");
			     
			     if(!(subarraysec[0].trim().equalsIgnoreCase("undefined")|| subarraysec[0].trim().equalsIgnoreCase("NaN")||subarraysec[0].trim().equalsIgnoreCase("")|| subarraysec[0].isEmpty())) {
			    	 
		
			    	 String sql="INSERT INTO hr_payleaved(sr_no, alwid,levid, rdocno,status) VALUES "
					         + " ("+(i+1)+","
					         + "'"+(subarraysec[0].trim().equalsIgnoreCase("undefined") || subarraysec[0].trim().equalsIgnoreCase("NaN")|| subarraysec[0].trim().equalsIgnoreCase("")|| subarraysec[0].isEmpty()?0:subarraysec[0].trim())+"',"
					         +"'"+leavid+"','"+refno+"',3)";

				     int resultSet2 = stmt.executeUpdate(sql);
				     if(resultSet2<=0) {
							conn.close();
							return 0;
						}
			         }
			
			         }
		        }
		     } 
			
			if(Integer.parseInt(leavid)<=0) {
				conn.close();
				return 0;
			}	     
			
			if (Integer.parseInt(leavid) > 0) {
				conn.commit();
				stmt.close();
				conn.close();
	            return Integer.parseInt(leavid);
		    }		
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		}
		return 0;
	}
	
    public JSONArray searchsaveLeaverelode(String docno ) throws SQLException {
    	JSONArray RESULTDATA=new JSONArray();

	    Connection conn=null;
  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();

				String   sql=(" select * from (select  @s:=@s+1 srno,m.levid ldocno,l.desc1 leavetype,'View'  btnsave,if(m.cf=0,'false','true') cf, if(m.ded=0,'false','true') deduct,   convert(if(m.l1=0,'',m.l1),char(20)) l1, convert(if(m.l2=0,'',m.l2),char(20)) l2, convert(if(m.l3=0,'',m.l3),char(20)) l3, convert(if(m.l1ded=0,'',m.l1ded),char(20)) l1ded, convert(if(m.l2ded=0,'',m.l2ded),char(20)) l2ded, convert(if(m.l3ded=0,'',m.l3ded),char(20)) l3ded  from hr_payleavem m\r\n" + 
						" left join hr_setleave l on l.doc_no=m.levid ,(SELECT @s:= 1) AS s where m.status=3 and rdocno='"+docno+"' \r\n" + 
						" union all (select @s:=@s+1 srno,doc_no ldocno,desc1 leavetype,'Apply'\r\n" + 
						" btnsave,'false' cf, 'false' ded, convert('',char(20))  l1,  convert('',char(20))  l2,\r\n" + 
						" convert('',char(20))  l3, convert('',char(20))  l1ded,  convert('',char(20))  l2ded,\r\n" + 
						" convert('',char(20))  l3ded  from hr_setleave where  status=3))   a group by a.ldocno order by  a.srno ; ") ;
	 
				ResultSet resultSet = stmt.executeQuery (sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmt.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	
    public JSONArray searchLeave() throws SQLException {
    	JSONArray RESULTDATA=new JSONArray();

	    Connection conn=null;
  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();
            	
				String   sql=("select doc_no ldocno,desc1 leavetype,'Apply'  btnsave from hr_setleave where status=3");
				
				ResultSet resultSet = stmt.executeQuery (sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);

				stmt.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
 
    public JSONArray searchrefsearch() throws SQLException {
    	JSONArray RESULTDATA=new JSONArray();

	    Connection conn=null;
  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement();
            	
				String  sql= "select m.catid,m.doc_no,m.date,m.valfrmdate,m.revdate,c.desc1 cat,l.desc1 leavdesc,concat('Leave Valid From ',date_format(m.valfrmdate,'%d.%m.%Y')) sowlabel from hr_paycode m "
						+ "left join hr_setpaycat c on m.catid=c.doc_no left join hr_setleave l on l.doc_no=m.annual_id where m.status=3";
				
				ResultSet resultSet = stmt.executeQuery (sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmt.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }

    public JSONArray searchAllowance() throws SQLException {
    	JSONArray RESULTDATA=new JSONArray();

    	Connection conn=null;

    	try {
				conn = ClsConnection.getMyConnection();
				Statement stmt  = conn.createStatement(); 
            	
				String sql="select CONVERT(doc_no,CHAR(50)) allowanceid,desc1 allowance  from hr_setallowance where status=3 and doc_no>=0";
				
				ResultSet resultSet = stmt.executeQuery (sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmt.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	
    public JSONArray searchAllowancerelode(String docno,String levid) throws SQLException {
    	JSONArray RESULTDATA=new JSONArray();

    	Connection conn=null;
  
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmt  = conn.createStatement (); 
 
				String sql="select * from (select CONVERT(e.alwid,CHAR(50))  allowanceid,a.desc1 allowance, '1' ckecked  from\r\n" + 
						"hr_payleaved e left join hr_setallowance a on  e.alwid=a.doc_no where e.status=3 and e.rdocno='"+docno+"' and e.levid='"+levid+"'\r\n" + 
						"union all select CONVERT(doc_no,CHAR(50)) allowanceid,desc1 allowance,'0' ckecked  from hr_setallowance where status=3 and doc_no>=0) a\r\n" + 
						"group by a.allowanceid order by ckecked desc";
				
				ResultSet resultSet = stmt.executeQuery (sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);

				stmt.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	
}
