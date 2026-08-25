package com.project.leadmanagement.activityreport;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsActivityReportDAO {

	ClsConnection connDAO = new ClsConnection();
	ClsCommon commonDAO= new ClsCommon();
	ClsActivityReportBean activityReportBean = new ClsActivityReportBean();
	Connection conn = null;
	
	public int insert(String formdetailcode,Date activityReportDate,String txthighlight,ArrayList<String> activityreportarray,HttpSession session,String mode) throws SQLException {
	
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtEAR1 = conn.createStatement();
			
			String branch = session.getAttribute("BRANCHID").toString();
			String userid = session.getAttribute("USERID").toString();
			String method="0",methodvalue="0";
			int docno;
			
			String sqlConfig="select method,round(coalesce(value,0),0) value from gl_config where field_nme='srvcActivityDateRestriction'";
		    ResultSet resultSetConfig = stmtEAR1.executeQuery(sqlConfig);
		   
		    while (resultSetConfig.next()) {
		        method=resultSetConfig.getString("method");
		        methodvalue=resultSetConfig.getString("value");
		    }
		    
		    if(method.equalsIgnoreCase("1")) {
		    	
			    String sqls="select DATEDIFF(now(), '"+activityReportDate+"') activitydatecheck";
			    ResultSet resultSet1 = stmtEAR1.executeQuery(sqls);
			   
			    while (resultSet1.next()) {
			    	if((resultSet1.getInt("activitydatecheck")<0) || (resultSet1.getInt("activitydatecheck")>Integer.parseInt(methodvalue))) {
			    		return -1;
			    	}
			    }
		    }
		    
			CallableStatement stmtEAR = conn.prepareCall("{CALL Sr_activityReportmDML(?,?,?,?,?,?,?)}");
			
			stmtEAR.registerOutParameter(6, java.sql.Types.INTEGER);
			stmtEAR.setDate(1,activityReportDate);
			stmtEAR.setString(2,txthighlight);
			stmtEAR.setString(3,formdetailcode);
			stmtEAR.setString(4,branch);
			stmtEAR.setString(5,userid);
			stmtEAR.setString(7,mode);
			stmtEAR.executeQuery();
			docno=stmtEAR.getInt("docNo");
			
			activityReportBean.setTxtactivityreportdocno(docno);
			if (docno > 0) {
				
				/*Insertion to cm_activityreportd*/
				int insertData=insertion(conn, docno, formdetailcode, activityreportarray, session, mode);
				if(insertData<=0){
					stmtEAR.close();
					conn.close();
					return 0;
				}
				/*Insertion to cm_activityreportd Ends*/
				
				conn.commit();
				stmtEAR.close();
				conn.close();
				return docno;
			}
		 stmtEAR.close();
		 conn.close();
		} catch(Exception e){	
		   e.printStackTrace();
		   conn.close();
		} finally{
			conn.close();
		}
		return 0;
	}
	
	public boolean editMaster(String formdetailcode, int txtactivityreportdocno, HttpSession session, String mode) throws SQLException {
		
		Connection conn = null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtEAR = conn.createStatement();
			
		    String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			
			/*Updating cm_activityreportm*/
            String sql=("update cm_activityreportm set confirmed=1 where doc_no="+txtactivityreportdocno);
            int data = stmtEAR.executeUpdate(sql);
			if(data<=0){
				stmtEAR.close();
				conn.close();
				return false;
			}
			/*Updating cm_activityreportm Ends*/
			
			/*Inserting into datalog*/
			String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtactivityreportdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
			int datas = stmtEAR.executeUpdate(sqls);
			/*Inserting into datalog Ends*/
			
			conn.commit();
			stmtEAR.close();
			conn.close();
			return true;			
    } catch(Exception e){	
	 	e.printStackTrace();
	 	conn.close();
	 	return false;
     } finally{
			conn.close();
		}
	}
	
	public int edit(String formdetailcode, int txtactivityreportdocno, Date activityReportDate, String txthighlight, ArrayList<String> activityreportarray, HttpSession session, String mode) throws SQLException {
		
		try{
		     conn=connDAO.getMyConnection();
		     conn.setAutoCommit(false);
		     Statement stmtEAR1 = conn.createStatement();
		    
			 String branch = session.getAttribute("BRANCHID").toString();
			 String userid = session.getAttribute("USERID").toString();
			
			 String method="0",methodvalue="0";
				
			 String sqlConfig="select method,round(coalesce(value,0),0) value from gl_config where field_nme='srvcActivityDateRestriction'";
		     ResultSet resultSetConfig = stmtEAR1.executeQuery(sqlConfig);
		   
		     while (resultSetConfig.next()) {
		        method=resultSetConfig.getString("method");
		        methodvalue=resultSetConfig.getString("value");
		     }
		    
		     if(method.equalsIgnoreCase("1")) {
		    	
			    String sqls="select DATEDIFF(now(), '"+activityReportDate+"') activitydatecheck";
			    ResultSet resultSet1 = stmtEAR1.executeQuery(sqls);
			   
			    while (resultSet1.next()) {
			    	if((resultSet1.getInt("activitydatecheck")<0) || (resultSet1.getInt("activitydatecheck")>Integer.parseInt(methodvalue))) {
			    		return -1;
			    	}
			    }
		     }
			   
		     CallableStatement stmtEAR = conn.prepareCall("{CALL Sr_activityReportmDML(?,?,?,?,?,?,?)}");
				
		     stmtEAR.setInt(6, txtactivityreportdocno);
			 stmtEAR.setDate(1,activityReportDate);
			 stmtEAR.setString(2,txthighlight);
			 stmtEAR.setString(3,formdetailcode);
			 stmtEAR.setString(4,branch);
			 stmtEAR.setString(5,userid);
			 stmtEAR.setString(7,mode);
			 stmtEAR.executeQuery();
			 int docno=stmtEAR.getInt("docNo");
			
			 activityReportBean.setTxtactivityreportdocno(docno);
			if (docno > 0) {
				
				String sql1=("DELETE FROM cm_activityreportd WHERE rdocno="+docno);
				int data2 = stmtEAR1.executeUpdate(sql1);
				 
				/*Insertion to cm_activityreportd*/
				int insertData=insertion(conn, docno, formdetailcode, activityreportarray, session, mode);
				if(insertData<=0){
					stmtEAR.close();
					conn.close();
					return 0;
				}
				/*Insertion to cm_activityreportd Ends*/
				
				conn.commit();
				stmtEAR.close();
				conn.close();
				return 1;
		    }
		stmtEAR.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}finally{
		conn.close();
	}
		return 0;
	}

	public boolean delete(int txtactivityreportdocno, String formdetailcode, HttpSession session, String mode) throws SQLException {
		
		try{
			conn=connDAO.getMyConnection();
			String branch = session.getAttribute("BRANCHID").toString();
			String userid = session.getAttribute("USERID").toString();
			
			CallableStatement stmtEAR = conn.prepareCall("{CALL Sr_activityReportmDML(?,?,?,?,?,?,?)}");
			
			stmtEAR.setInt(6, txtactivityreportdocno);
			stmtEAR.setDate(1,null);
			stmtEAR.setString(2,null);
			stmtEAR.setString(3,formdetailcode);
			stmtEAR.setString(4,branch);
			stmtEAR.setString(5,userid);
			stmtEAR.setString(7,mode);
			stmtEAR.executeQuery();
			int docno=stmtEAR.getInt("docNo");
			
			activityReportBean.setTxtactivityreportdocno(docno);
			if (docno > 0) {
				stmtEAR.close();
				conn.close();
				return true;
			}
		  stmtEAR.close();
		  conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return false;
	}
	
	public JSONArray activityGridReloading(HttpSession session,String docNo,String check) throws SQLException {
	      JSONArray RESULTDATA=new JSONArray();
	      
	      if(!(check.equalsIgnoreCase("1"))){
	      	return RESULTDATA;
	      }
	      
	      Connection conn = null;
	      
	      Enumeration<String> Enumeration = session.getAttributeNames();
	      int a=0;
	      while(Enumeration.hasMoreElements()){
	      	if(Enumeration.nextElement().equalsIgnoreCase("USERID")){
	      		a=1;
	      	}
	      }
	      if(a==0){
	  		return RESULTDATA;
	      	}
	      String userid = session.getAttribute("USERID").toString();
	      
			try {
					conn = connDAO.getMyConnection();
					Statement stmtEAR = conn.createStatement();
				
					ResultSet resultSet = stmtEAR.executeQuery ("select d.intime,d.outtime,d.hrs,d.actualhrs,if(d.clnew>0,true,false) clnew,d.cldocno,d.client,d.jobtype,d.jobno,d.notes,d.followupdate,d.followupnotes "
							+ "from cm_activityreportm m left join cm_activityreportd d on m.doc_no=d.rdocno where m.status=3 and d.status=3 and m.userid="+userid+" and m.doc_no="+docNo+"");
	              
					RESULTDATA=commonDAO.convertToJSON(resultSet);
					
					stmtEAR.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
			return RESULTDATA;
	  }
	
	public JSONArray searchClient(HttpSession session,String clname,String mob) throws SQLException {

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

		Connection conn = null;

		try {
			conn = connDAO.getMyConnection();
			Statement stmtEAR = conn.createStatement ();

			String sqltest="";

			if(!(clname.equalsIgnoreCase(""))){
				sqltest=sqltest+" and refname like '%"+clname+"%'";
			}
			if(!(mob.equalsIgnoreCase(""))){
				sqltest=sqltest+" and per_mob like '%"+mob+"%'";
			}
			
			String clsql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM'  " +sqltest);
			ResultSet resultSet = stmtEAR.executeQuery(clsql);

			RESULTDATA=commonDAO.convertToJSON(resultSet);
			stmtEAR.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray jobSearchGridLoading(HttpSession session,String typedocno,String refnames,String check,String dtype,String cldocno) throws SQLException {
	    
  	  JSONArray RESULTDATA=new JSONArray();
        
  	  if(!(check.equalsIgnoreCase("1"))) {
  		  return RESULTDATA;
  	  }
        Connection conn = null; 
       
      try {
         conn = connDAO.getMyConnection();
         Statement stmtEAR = conn.createStatement();

         String sql="";
         String sqltest="";
         
         if(!refnames.equalsIgnoreCase("") && !refnames.equalsIgnoreCase("0")){
      	   sqltest+=" and ac.refname like '%"+refnames+"%' ";
         }
         
         if(!typedocno.equalsIgnoreCase("") && !typedocno.equalsIgnoreCase("0")){
      	   sqltest+=" and m.doc_no like '%"+typedocno+"%' ";
         }
      	   
         if(dtype.contains("AMC") || dtype.contains("SJOB")) {
        	 
        	 sql = "select m.doc_no,m.tr_no,m.dtype,convert(concat(m.ref_type,' ',m.refdocno),char(100)) prjname, "
        			 + "ac.refname customer,m.cldocno from cm_srvcontrm m left join my_acbook ac on ac.cldocno=m.cldocno "
        			 + "and ac.dtype='CRM' where m.status=3 and m.JBAction in (0,4) and m.dtype='"+dtype+"' and m.cldocno="+cldocno+" "+sqltest+"";           
         
         } else if(dtype.contains("QOT")) {
        	 
        	 sql = "select m.doc_no,m.tr_no,ac.refname customer,CONVERT(CONCAT(m.cntr_type,' - ',m.cntrtrno),CHAR(100)) prjname,m.cldocno from "
        			 + "cm_srvqotm m left join my_acbook ac on (m.cldocno=ac.doc_no and ac.dtype='CRM') where m.status=3 and m.cldocno="+cldocno+""+sqltest+" ";
        	 
         }
         
         ResultSet resultSet = stmtEAR.executeQuery(sql);
         RESULTDATA=commonDAO.convertToJSON(resultSet);
            
       stmtEAR.close();
       conn.close();
      } catch(Exception e){
        e.printStackTrace();
        conn.close();
      } finally{
    	  conn.close();
   }
        return RESULTDATA;
   }
	
	public JSONArray earMainSearch(HttpSession session,String highlight,String docNo,String date,String status,String check) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
        Connection conn = null;
           
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
        
         String branch=session.getAttribute("BRANCHID").toString();
           
     try {
	        conn = connDAO.getMyConnection();
	        Statement stmtEAR = conn.createStatement();
	        	
        	java.sql.Date sqlActivityDate=null;
            
            date.trim();
            if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))) {
            	sqlActivityDate = commonDAO.changeStringtoSqlDate(date);
            }
            
	        String sqltest="";
	        
	        if(!(docNo.equalsIgnoreCase(""))){
	            sqltest=sqltest+" and doc_no like '%"+docNo+"%'";
	        }
	        
	        if(!(highlight.equalsIgnoreCase(""))){
	        	sqltest=sqltest+" and highlight like '%"+highlight+"%'";
	        }
	        
	        if(!(status.equalsIgnoreCase(""))){
	        	
	        	if(status.contains("To be Submitted")){
	        		status="0";
	        	} else {
	        		status="1";
	        	}
	        	sqltest=sqltest+" and confirmed="+status+"";
	        }
	        
	        if(!(sqlActivityDate==null)){
		         sqltest=sqltest+" and date='"+sqlActivityDate+"'";
		    } 
	        
	       ResultSet resultSet = stmtEAR.executeQuery("select doc_no,date,highlight,CASE WHEN confirmed=0 THEN 'TO BE SUBMITTED' WHEN confirmed=1 THEN 'SUBMITTED' ELSE '' END AS fromstatus from cm_activityreportm where status<>7" +sqltest);
	
	       RESULTDATA=commonDAO.convertToJSON(resultSet);
	        
	       stmtEAR.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
 		conn.close();
 	}
       return RESULTDATA;
   }
	
	public ClsActivityReportBean getViewDetails(HttpSession session,int docNo) throws SQLException {
		
		ClsActivityReportBean activityReportBean = new ClsActivityReportBean();
		
		Connection conn = null;
		
		try {
		
			conn = connDAO.getMyConnection();
			Statement stmtEAR = conn.createStatement();
			
			String branch = session.getAttribute("BRANCHID").toString();
			
			ResultSet resultSet = stmtEAR.executeQuery ("select m.date,m.highlight,CASE WHEN m.confirmed=0 THEN 'TO BE SUBMITTED' WHEN m.confirmed=1 THEN 'SUBMITTED' ELSE '' END AS fromstatus,"
					+ "u.user_name formusername from cm_activityreportm m left join my_user u on m.userid=u.doc_no where m.status=3 and m.brhid="+branch+" and m.doc_no="+docNo+"");
	
			while (resultSet.next()) {
					activityReportBean.setTxtactivityreportdocno(docNo);
					activityReportBean.setActivityDate(resultSet.getDate("date").toString());
					activityReportBean.setTxthighlight(resultSet.getString("highlight"));
					activityReportBean.setLblformstatus(resultSet.getString("fromstatus"));
					activityReportBean.setLblformusername(resultSet.getString("formusername"));
	
			    }
			stmtEAR.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return activityReportBean;
		}
	
	private int insertion(Connection conn, int docno, String formdetailcode, ArrayList<String> activityreportarray, HttpSession session, String mode) throws SQLException{
		
		try {
			CallableStatement stmtEAR2;
			
			/*Activity Report Grid and Details Saving*/
			for(int i=0;i< activityreportarray.size();i++){
				String[] activity=activityreportarray.get(i).split("::");
				if(!activity[0].trim().equalsIgnoreCase("undefined") && !activity[0].trim().equalsIgnoreCase("NaN")){
				
				java.sql.Date sqlFollowupDate=(activity[10].trim().equalsIgnoreCase("undefined") || activity[10].trim().equalsIgnoreCase("NaN") || activity[10].trim().equalsIgnoreCase("NA") || activity[10].trim().equalsIgnoreCase("") ||  activity[10].trim().isEmpty()?null:commonDAO.changeStringtoSqlDate(activity[10].trim()));
					
				stmtEAR2 = conn.prepareCall("{CALL Sr_activityReportdDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				/*Insertion to cm_activityreportd*/
				stmtEAR2.registerOutParameter(14, java.sql.Types.INTEGER);
				stmtEAR2.setString(1,(activity[0].trim().equalsIgnoreCase("undefined") || activity[0].trim().equalsIgnoreCase("NaN") || activity[0].trim().isEmpty()?"00:00":activity[0].trim()).toString());  //intime
				stmtEAR2.setString(2,(activity[1].trim().equalsIgnoreCase("undefined") || activity[1].trim().equalsIgnoreCase("NaN") || activity[1].trim().isEmpty()?"00:00":activity[1].trim()).toString()); //outtime
				stmtEAR2.setString(3,(activity[2].trim().equalsIgnoreCase("undefined") || activity[2].trim().equalsIgnoreCase("NaN") || activity[2].trim().equals(0) || activity[2].trim().isEmpty()?"00:00":activity[2].trim()).toString()); //hrs
				stmtEAR2.setString(4,(activity[3].trim().equalsIgnoreCase("undefined") || activity[3].trim().equalsIgnoreCase("NaN") || activity[3].trim().equalsIgnoreCase("") || activity[3].trim().equals(0) || activity[3].trim().isEmpty()?"0":activity[3].trim()).toString()); //actualhrs
				stmtEAR2.setString(5,(activity[4].trim().equalsIgnoreCase("undefined") || activity[4].trim().equalsIgnoreCase("NaN") || activity[4].trim().isEmpty()?"0":activity[4].trim()).toString()); //clnew 
				stmtEAR2.setString(6,(activity[5].trim().equalsIgnoreCase("undefined") || activity[5].trim().equalsIgnoreCase("NaN") || activity[5].trim().equalsIgnoreCase("") || activity[5].trim().isEmpty()?"0":activity[5].trim()).toString()); //cldocno
				stmtEAR2.setString(7,(activity[6].trim().equalsIgnoreCase("undefined") || activity[6].trim().equalsIgnoreCase("NaN") || activity[6].trim().isEmpty()?"":activity[6].trim()).toString()); //Client 
				stmtEAR2.setString(8,(activity[7].trim().equalsIgnoreCase("undefined") || activity[7].trim().equalsIgnoreCase("NaN") || activity[7].trim().isEmpty()?"":activity[7].trim()).toString());  //Jobtype
				stmtEAR2.setString(9,(activity[8].trim().equalsIgnoreCase("undefined") || activity[8].trim().equalsIgnoreCase("NaN") || activity[8].trim().equalsIgnoreCase("") || activity[8].trim().equalsIgnoreCase("0") || activity[8].trim().isEmpty()?"0":activity[8].trim()).toString()); //Jobno
				stmtEAR2.setString(10,(activity[9].trim().equalsIgnoreCase("undefined") || activity[9].trim().equalsIgnoreCase("NaN") || activity[9].trim().equalsIgnoreCase("") || activity[9].trim().equalsIgnoreCase("0") || activity[9].trim().isEmpty()?"":activity[9].trim()).toString()); //Notes
				stmtEAR2.setDate(11,sqlFollowupDate); //FollowupDate
				stmtEAR2.setString(12,(activity[11].trim().equalsIgnoreCase("undefined") || activity[11].trim().equalsIgnoreCase("NaN") || activity[11].trim().equalsIgnoreCase("") || activity[11].trim().equalsIgnoreCase("0") || activity[11].trim().isEmpty()?"":activity[11].trim()).toString()); //Follow Up Notes
				stmtEAR2.setInt(13,docno);
				stmtEAR2.setString(15,mode);
				int detail=stmtEAR2.executeUpdate();
					if(detail<=0){
						stmtEAR2.close();
						conn.close();
						return 0;
					}
			     }
			   }
			   /*Activity Report Grid and Details Saving Ends*/
		
			}catch(Exception e){	
			 	e.printStackTrace();
			 	conn.close();
			 	return 0;
		  }
		return 1;
	}

}
