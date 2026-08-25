package com.dashboard.analysis.callregisteranalysis;
	import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

	import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

	import com.common.ClsCommon;
import com.connection.ClsConnection;
	
	public class ClscallregisterAnalysisDAO {

		ClsConnection ClsConnection=new ClsConnection();

		ClsCommon ClsCommon=new ClsCommon();
		
		public JSONArray searchClient(HttpSession session,String clname,String mob,int id) throws SQLException {


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


			String sqltest="";

			if(!(clname.equalsIgnoreCase("undefined"))&&!(clname.equalsIgnoreCase(""))&&!(clname.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and refname like '%"+clname+"%'";
			}
			if(!(mob.equalsIgnoreCase("undefined"))&&!(mob.equalsIgnoreCase(""))&&!(mob.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and per_mob like '%"+mob+"%'";
			}


			Connection conn = null;
			try {
				conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();

				if(id>0){
					String clsql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM'  " +sqltest);

					ResultSet resultSet = stmtVeh1.executeQuery(clsql);

					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVeh1.close();
					conn.close();
				}
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
			return RESULTDATA;
		}
		public JSONArray summgridload(String barchval,String fromdate,String todate,String clientid,String vehno,String type,String repeat,String summtype) throws SQLException {
			JSONArray RESULTDATA=new JSONArray();
			
			Connection conn = null;
			
			java.sql.Date sqlFromDate = null;
	        java.sql.Date sqlToDate = null;
	        String sqltest="",sqltest1="";
	        
			  try {
				    conn = ClsConnection.getMyConnection();
				    Statement stmtCollection = conn.createStatement();
				    
				    if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
			              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
			        }
			        
				    if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
			              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
			        }
			        
				    String sql = "";
				    
				    if(!((barchval.equalsIgnoreCase("a")) || (barchval.equalsIgnoreCase("NA")))){
				    	sqltest+=" and m.brhid="+barchval+"";
		    		}
				    if(!(clientid.equalsIgnoreCase("undefined"))&&!(clientid.equalsIgnoreCase(""))&&!(clientid.equalsIgnoreCase("0"))){
						sqltest=sqltest+" and ac.cldocno like '%"+clientid+"%'";
					}
				    
					if(!(vehno.equalsIgnoreCase("undefined"))&&!(vehno.equalsIgnoreCase(""))&&!(vehno.equalsIgnoreCase("0"))){
						sqltest=sqltest+" and m.regno like '%"+vehno+"%'";
					}
					
					if(type.equalsIgnoreCase("1")){
				    	sqltest=sqltest+" and c.doc_no like '%"+type+"%'";
				    }
				    else if(type.equalsIgnoreCase("2")){
				    	sqltest=sqltest+" and c.doc_no like '%"+type+"%'";
				    }
				    else if(type.equalsIgnoreCase("3")){
				    	sqltest=sqltest+" and c.doc_no like '%"+type+"%'";
				    	
				    }
				    else if(type.equalsIgnoreCase("4")){
				    	sqltest=sqltest+" and c.doc_no like '%"+type+"%'";
				    }
				    else if(type.equalsIgnoreCase("5")){
				    	sqltest=sqltest+" and c.doc_no like '%"+type+"%'";
				    }
				    else if(type.equalsIgnoreCase("6")){
				    	sqltest=sqltest+" and c.doc_no like '%"+type+"%'";
				    }
				    else{
				    	
				    }
					if(repeat.equalsIgnoreCase("ALL")){
				    	sqltest=sqltest+" and 1=1";
				    }
				    else if(repeat.equalsIgnoreCase("1")){
				    	sqltest=sqltest+" and repeated=1";
				    }
				    else{
				    	sqltest=sqltest+" and repeated=0";
				    }
					if(summtype.equalsIgnoreCase("docno")){
				    	sqltest1+=",m.doc_no";
				    }
				    else{
				    	
				    }
				    sql = "SELECT M.TR_NO,M.BRHID,M.DOC_NO cregno,M.DATE,U.USER_NAME user,C.NAME type,M.REMARKS,IF(REPEATED=1,'YES','NO') REPEATED,REGNO vehicle,AC.REFNAME client,CALLEDBY callby,CALLEDBYMOB mob,"
							+ " IF(MIN(A.ENTRYDATE) IS NULL AND MAX(A.ENTRYDATE) IS NULL ,0,TIMESTAMPDIFF(MINUTE,COALESCE(MIN(A.ENTRYDATE),M.DATE),COALESCE(MAX(A.ENTRYDATE),NOW()))) tottime, IF(TIMESTAMPDIFF(MINUTE,COALESCE(MIN(A.ENTRYDATE),M.DATE),COALESCE(MAX(A.ENTRYDATE),NOW()))-SUM(COALESCE(OVERDUE,0))<0 ,0, TIMESTAMPDIFF(MINUTE,COALESCE(MIN(A.ENTRYDATE),M.DATE),COALESCE(MAX(A.ENTRYDATE),NOW()))-SUM(COALESCE(OVERDUE,0))) OVERDUE "
							+ " FROM CM_CUSCALLM M LEFT JOIN cm_srvassign A ON M.TR_NO=A.REFDOCNO "
							+ " LEFT JOIN MY_USER U ON U.DOC_NO=M.USERID LEFT JOIN cm_cuscalltype C ON C.DOC_NO=M.CALLTYPE "
							+ " LEFT JOIN MY_ACBOOK AC ON AC.DOC_NO=M.CLDOCNO AND AC.DTYPE='CRM' "
							+ " LEFT JOIN cm_cuscallstatus C1 ON C1.SRNO=A.STATUSID   WHERE 1=1 "+sqltest+" and m.DATE between '"+sqlFromDate+"' and  '"+sqlToDate+"' GROUP BY M.TR_NO "+sqltest1+"";
				    System.out.println("sumgrid"+sql);
				    ResultSet resultSet = stmtCollection.executeQuery(sql);
				                
				    RESULTDATA=ClsCommon.convertToJSON(resultSet);
				    
				    stmtCollection.close();
				    conn.close();
			  }catch(Exception e){
				  e.printStackTrace();
				  conn.close();
			  }finally{
				  conn.close();
			  }
			  return RESULTDATA;
			}
		
		public JSONArray sumgridloadexcel(String barchval,String fromdate,String todate,String clientid,String vehno,String type,String repeat,String summtype) throws SQLException {
			JSONArray RESULTDATA=new JSONArray();
			
			Connection conn = null;
			
			java.sql.Date sqlFromDate = null;
	        java.sql.Date sqlToDate = null;
	        String sqltest="",sqltest1="";
	        
			  try {
				    conn = ClsConnection.getMyConnection();
				    Statement stmtCollection = conn.createStatement();
				    
				    if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
			              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
			        }
			        
				    if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
			              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
			        }
			        
				    String sql = "";
				    
				    if(!((barchval.equalsIgnoreCase("a")) || (barchval.equalsIgnoreCase("NA")))){
				    	sqltest+=" and m.brhid="+barchval+"";
		    		}
				    if(!(clientid.equalsIgnoreCase("undefined"))&&!(clientid.equalsIgnoreCase(""))&&!(clientid.equalsIgnoreCase("0"))){
						sqltest=sqltest+" and ac.cldocno like '%"+clientid+"%'";
					}
				    
					if(!(vehno.equalsIgnoreCase("undefined"))&&!(vehno.equalsIgnoreCase(""))&&!(vehno.equalsIgnoreCase("0"))){
						sqltest=sqltest+" and m.regno like '%"+vehno+"%'";
					}
					
					if(type.equalsIgnoreCase("1")){
				    	sqltest=sqltest+" and c.doc_no like '%"+type+"%'";
				    }
				    else if(type.equalsIgnoreCase("2")){
				    	sqltest=sqltest+" and c.doc_no like '%"+type+"%'";
				    }
				    else if(type.equalsIgnoreCase("3")){
				    	sqltest=sqltest+" and c.doc_no like '%"+type+"%'";
				    	
				    }
				    else if(type.equalsIgnoreCase("4")){
				    	sqltest=sqltest+" and c.doc_no like '%"+type+"%'";
				    }
				    else if(type.equalsIgnoreCase("5")){
				    	sqltest=sqltest+" and c.doc_no like '%"+type+"%'";
				    }
				    else if(type.equalsIgnoreCase("6")){
				    	sqltest=sqltest+" and c.doc_no like '%"+type+"%'";
				    }
				    
					if(repeat.equalsIgnoreCase("ALL")){
				    	sqltest=sqltest+" and 1=1";
				    }
				    else if(repeat.equalsIgnoreCase("1")){
				    	sqltest=sqltest+" and repeated=1";
				    }
				    else{
				    	sqltest=sqltest+" and repeated=0";
				    }
					
					if(summtype.equalsIgnoreCase("docno")){
				    	sqltest1+=" ,m.doc_no";
				    }
				    else{
				    	
				    }
				    sql = "SELECT M.DOC_NO cregno,M.DATE,U.USER_NAME user,C.NAME type,M.REMARKS,IF(REPEATED=1,'YES','NO') REPEATED,REGNO vehicle,AC.REFNAME client,CALLEDBY callby,CALLEDBYMOB mob,"
							+ " IF(MIN(A.ENTRYDATE) IS NULL AND MAX(A.ENTRYDATE) IS NULL ,0,TIMESTAMPDIFF(MINUTE,COALESCE(MIN(A.ENTRYDATE),M.DATE),COALESCE(MAX(A.ENTRYDATE),NOW()))) tottime, IF(TIMESTAMPDIFF(MINUTE,COALESCE(MIN(A.ENTRYDATE),M.DATE),COALESCE(MAX(A.ENTRYDATE),NOW()))-SUM(COALESCE(OVERDUE,0))<0 ,0, TIMESTAMPDIFF(MINUTE,COALESCE(MIN(A.ENTRYDATE),M.DATE),COALESCE(MAX(A.ENTRYDATE),NOW()))-SUM(COALESCE(OVERDUE,0))) OVERDUE "
							+ " FROM CM_CUSCALLM M LEFT JOIN cm_srvassign A ON M.TR_NO=A.REFDOCNO "
							+ " LEFT JOIN MY_USER U ON U.DOC_NO=M.USERID LEFT JOIN cm_cuscalltype C ON C.DOC_NO=M.CALLTYPE "
							+ " LEFT JOIN MY_ACBOOK AC ON AC.DOC_NO=M.CLDOCNO AND AC.DTYPE='CRM' "
							+ " LEFT JOIN cm_cuscallstatus C1 ON C1.SRNO=A.STATUSID   WHERE 1=1 "+sqltest+" and m.DATE between '"+sqlFromDate+"' and  '"+sqlToDate+"' GROUP BY M.TR_NO "+sqltest1+"";
				   // System.out.println("sumgrid"+sql);
				    ResultSet resultSet = stmtCollection.executeQuery(sql);
				                
				    RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				    
				    stmtCollection.close();
				    conn.close();
			  }catch(Exception e){
				  e.printStackTrace();
				  conn.close();
			  }finally{
				  conn.close();
			  }
			  return RESULTDATA;
			}
		
		public  JSONArray loadSubGridData(String docno,String brhid) throws SQLException {

			JSONArray RESULTDATA=new JSONArray();


			Connection conn = null;
			Statement stmt =null;
			ResultSet resultSet=null;
			try {

				//System.out.println("=====loadTrafficdaily");
				conn = ClsConnection.getMyConnection();
				stmt = conn.createStatement ();
				
					
				String sqldata = " select sm.grpcode empgroupid,he.name empid,ast.name as assignstatus,sa.entrydate,sa.description "
						+ " from cm_srvassign sa left join cm_cuscallstatus ast on ast.srno=sa.statusid "
						+ " left join cm_serteamm sm on sm.doc_no=sa.empGroupId left join cm_serteamd sd on sd.empid =sa.empid "
						+ " left join hr_empm he on sd.empid=he.doc_no where sa.refdocno="+docno+" and sa.brhid="+brhid+" group by sa.tr_no order by sa.entrydate ";
			
	     		   System.out.println("docno====*******"+sqldata);
					resultSet= stmt.executeQuery (sqldata);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				//			System.out.println("=====RESULTDATA"+RESULTDATA);

			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				stmt.close();
				conn.close();
			}
			return RESULTDATA;
		}
		
		public JSONArray detgridload(String barchval,String fromdate,String todate,String clientid,String vehno,String type,String repeat,String summtype) throws SQLException {
			JSONArray RESULTDATA=new JSONArray();
			
			Connection conn = null;
			
			java.sql.Date sqlFromDate = null;
	        java.sql.Date sqlToDate = null;
	        String sqltest="",sqltest1="";
			  try {
				    conn = ClsConnection.getMyConnection();
				    Statement stmtCollection = conn.createStatement();
				    
				    if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
			              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
			        }
			        
				    if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
			              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
			        }
			        
				    String sql = "";
				    
				    if(!((barchval.equalsIgnoreCase("a")) || (barchval.equalsIgnoreCase("NA")))){
				    	sqltest+=" and m.brhid="+barchval+"";
		    		}
				    if(!(clientid.equalsIgnoreCase("undefined"))&&!(clientid.equalsIgnoreCase(""))&&!(clientid.equalsIgnoreCase("0"))){
						sqltest=sqltest+" and ac.cldocno like '%"+clientid+"%'";
					}
					if(!(vehno.equalsIgnoreCase("undefined"))&&!(vehno.equalsIgnoreCase(""))&&!(vehno.equalsIgnoreCase("0"))){
						sqltest=sqltest+" and m.regno like '%"+vehno+"%'";
					}
				    if(type.equalsIgnoreCase("1")){
				    	sqltest=sqltest+" and c.doc_no like '%"+type+"%'";
				    }
				    else if(type.equalsIgnoreCase("2")){
				    	sqltest=sqltest+" and c.doc_no like '%"+type+"%'";
				    }
				    else if(type.equalsIgnoreCase("3")){
				    	sqltest=sqltest+" and c.doc_no like '%"+type+"%'";
				    	
				    }
				    else if(type.equalsIgnoreCase("4")){
				    	sqltest=sqltest+" and c.doc_no like '%"+type+"%'";
				    }
				    else if(type.equalsIgnoreCase("5")){
				    	sqltest=sqltest+" and c.doc_no like '%"+type+"%'";
				    }
				    else if(type.equalsIgnoreCase("6")){
				    	sqltest=sqltest+" and c.doc_no like '%"+type+"%'";
				    }
				    if(repeat.equalsIgnoreCase("ALL")){
				    	sqltest=sqltest+" and 1=1";
				    }
				    else if(repeat.equalsIgnoreCase("1")){
				    	sqltest=sqltest+" and repeated=1";
				    }
				    else{
				    	sqltest=sqltest+" and repeated=0";
				    }
				    
				     
				    sql = "SELECT M.TR_NO,M.BRHID,M.DOC_NO cregno,M.DATE,U.USER_NAME user,C.NAME type,M.REMARKS,IF(REPEATED=1,'YES','NO') REPEATED,REGNO vehicle,AC.REFNAME client,CALLEDBY callby,CALLEDBYMOB mob,C1.NAME status,SM.GRPCODE groupname,EMP.NAME member, "
							+ " TIMESTAMPDIFF(MINUTE,COALESCE(A.ENTRYDATE,M.DATE),COALESCE(CLOSETIME,NOW())) tottime,"
							+ " IF((TIMESTAMPDIFF(MINUTE,COALESCE(A.ENTRYDATE,M.DATE),COALESCE(CLOSETIME,NOW()))-COALESCE(OVERDUE,0)<0),0,"
							+ " TIMESTAMPDIFF(MINUTE,COALESCE(A.ENTRYDATE,M.DATE),COALESCE(CLOSETIME,NOW()))-COALESCE(OVERDUE,0)) OVERDUE "
							+ " FROM CM_CUSCALLM M LEFT JOIN cm_srvassign A ON M.TR_NO=A.REFDOCNO "
							+ " LEFT JOIN MY_USER U ON U.DOC_NO=M.USERID LEFT JOIN cm_cuscalltype C ON C.DOC_NO=M.CALLTYPE "
							+ " LEFT JOIN MY_ACBOOK AC ON AC.DOC_NO=M.CLDOCNO AND AC.DTYPE='CRM' "
							+ " LEFT JOIN cm_cuscallstatus C1 ON C1.SRNO=A.STATUSID    LEFT JOIN cm_serteamm SM ON SM.DOC_NO=A.EMPGROUPID "
							+ " LEFT JOIN HR_EMPM EMP ON EMP.DOC_NO=A.EMPID WHERE 1=1 "+sqltest+" and m.DATE between '"+sqlFromDate+"' and  '"+sqlToDate+"'" ;
				    System.out.println("det======"+sql);
				    ResultSet resultSet = stmtCollection.executeQuery(sql);
				                
				    RESULTDATA=ClsCommon.convertToJSON(resultSet);
				    
				    stmtCollection.close();
				    conn.close();
			  }catch(Exception e){
				  e.printStackTrace();
				  conn.close();
			  }finally{
				  conn.close();
			  }
			  return RESULTDATA;
			}
		
		public JSONArray detgridloadexcel(String barchval,String fromdate,String todate,String clientid,String vehno,String type,String repeat) throws SQLException {
			JSONArray RESULTDATA=new JSONArray();
			
			Connection conn = null;
			
			java.sql.Date sqlFromDate = null;
	        java.sql.Date sqlToDate = null;
	        String sqltest="";
			  try {
				    conn = ClsConnection.getMyConnection();
				    Statement stmtCollection = conn.createStatement();
				    
				    if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
			              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
			        }
			        
				    if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
			              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
			        }
			        
				    String sql = "";
				    
				    if(!((barchval.equalsIgnoreCase("a")) || (barchval.equalsIgnoreCase("NA")))){
				    	sqltest+=" and m.brhid="+barchval+"";
		    		}
				    if(!(clientid.equalsIgnoreCase("undefined"))&&!(clientid.equalsIgnoreCase(""))&&!(clientid.equalsIgnoreCase("0"))){
						sqltest=sqltest+" and ac.cldocno like '%"+clientid+"%'";
					}
					if(!(vehno.equalsIgnoreCase("undefined"))&&!(vehno.equalsIgnoreCase(""))&&!(vehno.equalsIgnoreCase("0"))){
						sqltest=sqltest+" and m.regno like '%"+vehno+"%'";
					}
				    if(type.equalsIgnoreCase("1")){
				    	sqltest=sqltest+" and c.doc_no like '%"+type+"%'";
				    }
				    else if(type.equalsIgnoreCase("2")){
				    	sqltest=sqltest+" and c.doc_no like '%"+type+"%'";
				    }
				    else if(type.equalsIgnoreCase("3")){
				    	sqltest=sqltest+" and c.doc_no like '%"+type+"%'";
				    	
				    }
				    else if(type.equalsIgnoreCase("4")){
				    	sqltest=sqltest+" and c.doc_no like '%"+type+"%'";
				    }
				    else if(type.equalsIgnoreCase("5")){
				    	sqltest=sqltest+" and c.doc_no like '%"+type+"%'";
				    }
				    else if(type.equalsIgnoreCase("6")){
				    	sqltest=sqltest+" and c.doc_no like '%"+type+"%'";
				    }
				    
				    if(repeat.equalsIgnoreCase("1")){
				    	sqltest=sqltest+" and repeated=1";
				    }
				    else{
				    	sqltest=sqltest+" and repeated=0";
				    }
				    
				    sql = "SELECT M.DOC_NO cregno,M.DATE,U.USER_NAME user,C.NAME type,M.REMARKS,IF(REPEATED=1,'YES','NO') REPEATED,REGNO vehicle,AC.REFNAME client,CALLEDBY callby,CALLEDBYMOB mob,C1.NAME groupname,EMP.NAME member, "
							+ " TIMESTAMPDIFF(MINUTE,COALESCE(A.ENTRYDATE,M.DATE),COALESCE(CLOSETIME,NOW())) tottime,"
							+ " IF((TIMESTAMPDIFF(MINUTE,COALESCE(A.ENTRYDATE,M.DATE),COALESCE(CLOSETIME,NOW()))-COALESCE(OVERDUE,0)<0),0,"
							+ " TIMESTAMPDIFF(MINUTE,COALESCE(A.ENTRYDATE,M.DATE),COALESCE(CLOSETIME,NOW()))-COALESCE(OVERDUE,0)) OVERDUE "
							+ " FROM CM_CUSCALLM M LEFT JOIN cm_srvassign A ON M.TR_NO=A.REFDOCNO "
							+ " LEFT JOIN MY_USER U ON U.DOC_NO=M.USERID LEFT JOIN cm_cuscalltype C ON C.DOC_NO=M.CALLTYPE "
							+ " LEFT JOIN MY_ACBOOK AC ON AC.DOC_NO=M.CLDOCNO AND AC.DTYPE='CRM' "
							+ " LEFT JOIN cm_cuscallstatus C1 ON C1.SRNO=A.STATUSID    LEFT JOIN cm_serteamm SM ON SM.DOC_NO=A.EMPGROUPID "
							+ " LEFT JOIN HR_EMPM EMP ON EMP.DOC_NO=A.EMPID WHERE 1=1 "+sqltest+" and m.DATE between '"+sqlFromDate+"' and  '"+sqlToDate+"'";
				    //System.out.println("det"+sql);
				    ResultSet resultSet = stmtCollection.executeQuery(sql);
				                
				    RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				    
				    stmtCollection.close();
				    conn.close();
			  }catch(Exception e){
				  e.printStackTrace();
				  conn.close();
			  }finally{
				  conn.close();
			  }
			  return RESULTDATA;
			}
		
		public JSONArray sumtypeload(String barchval,String fromdate,String todate,String clientid,String vehno,String type,String repeat,String summtype) throws SQLException {
			JSONArray RESULTDATA=new JSONArray();
			
			Connection conn = null;
			
			java.sql.Date sqlFromDate = null;
	        java.sql.Date sqlToDate = null;
	        String sqltest="",sqltest1="",sqltest2="";
	        
			  try {
				    conn = ClsConnection.getMyConnection();
				    Statement stmtCollection = conn.createStatement();
				    
				    if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
			              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
			        }
			        
				    if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
			              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
			        }
			        
				    String sql1 = "";
				    
				    if(!((barchval.equalsIgnoreCase("a")) || (barchval.equalsIgnoreCase("NA")))){
				    	sqltest+=" and m.brhid="+barchval+"";
		    		}
				    if(!(clientid.equalsIgnoreCase("undefined"))&&!(clientid.equalsIgnoreCase(""))&&!(clientid.equalsIgnoreCase("0"))){
						sqltest=sqltest+" and ac.cldocno like '%"+clientid+"%'";
					}
				    
					if(!(vehno.equalsIgnoreCase("undefined"))&&!(vehno.equalsIgnoreCase(""))&&!(vehno.equalsIgnoreCase("0"))){
						sqltest=sqltest+" and m.regno like '%"+vehno+"%'";
					}
					
					if(type.equalsIgnoreCase("1")){
				    	sqltest=sqltest+" and c.doc_no like '%"+type+"%'";
				    }
				    else if(type.equalsIgnoreCase("2")){
				    	sqltest=sqltest+" and c.doc_no like '%"+type+"%'";
				    }
				    else if(type.equalsIgnoreCase("3")){
				    	sqltest=sqltest+" and c.doc_no like '%"+type+"%'";
				    	
				    }
				    else if(type.equalsIgnoreCase("4")){
				    	sqltest+=" and c.doc_no like '%"+type+"%'";
				    }
				    else if(type.equalsIgnoreCase("5")){
				    	sqltest+=" and c.doc_no like '%"+type+"%'";
				    }
				    else if(type.equalsIgnoreCase("6")){
				    	sqltest+=" and c.doc_no like '%"+type+"%'";
				    }
				    else{
				    	
				    }
					 if(repeat.equalsIgnoreCase("ALL")){
					    	sqltest+=sqltest+" and 1=1";
					    }
					    else if(repeat.equalsIgnoreCase("1")){
					    	sqltest+=" and repeated=1";
					    }
					    else{
					    	sqltest+=" and repeated=0";
					    }
					    
					
					if(summtype.equalsIgnoreCase("client")){
						sqltest1+=" client,";
						sqltest2+=" group by client";
					}
					else if(summtype.equalsIgnoreCase("type")){
						sqltest1+=" type,";
						sqltest2+=" group by type";
					}
					
					else{
					}

					
					
//					sql1 = "select "+sqltest1+" sum(tottime) tottime,sum(overdue) overdue,count(*) count from"
//				    		+ "(SELECT M.TR_NO,M.BRHID,M.DOC_NO cregno,M.DATE,U.USER_NAME user,C.NAME type,"
//				    		+ "M.REMARKS,IF(REPEATED=1,'YES','NO') REPEATED,REGNO vehicle,AC.REFNAME client,"
//				    		+ "CALLEDBY callby,CALLEDBYMOB mob, IF(MIN(A.ENTRYDATE) IS NULL AND MAX(A.ENTRYDATE) IS NULL ,"
//				    		+ "0,TIMESTAMPDIFF(MINUTE,COALESCE(MIN(A.ENTRYDATE),M.DATE),COALESCE(MAX(A.ENTRYDATE),NOW()))) "
//				    		+ "tottime, IF(TIMESTAMPDIFF(MINUTE,COALESCE(MIN(A.ENTRYDATE),M.DATE),COALESCE(MAX(A.ENTRYDATE),"
//				    		+ "NOW()))-SUM(COALESCE(OVERDUE,0))<0 ,0, TIMESTAMPDIFF(MINUTE,COALESCE(MIN(A.ENTRYDATE),M.DATE),"
//				    		+ "COALESCE(MAX(A.ENTRYDATE),NOW()))-SUM(COALESCE(OVERDUE,0))) OVERDUE  FROM CM_CUSCALLM M LEFT JOIN"
//				    		+ " cm_srvassign A ON M.TR_NO=A.REFDOCNO  LEFT JOIN MY_USER U ON U.DOC_NO=M.USERID LEFT JOIN cm_cuscalltype C"
//				    		+ " ON C.DOC_NO=M.CALLTYPE  LEFT JOIN MY_ACBOOK AC ON AC.DOC_NO=M.CLDOCNO AND AC.DTYPE='CRM'  "
//				    		+ "LEFT JOIN cm_cuscallstatus C1 ON C1.SRNO=A.STATUSID WHERE 1=1  "+sqltest+" and m.DATE between '"+sqlFromDate+"' and  '"+sqlToDate+"' GROUP BY M.TR_NO) a "+sqltest2+"";
				    
					sql1="select "+sqltest1+" sum(tottime) tottime,sum(overdue) overdue,count(*) count from"
							+ "(SELECT M.TR_NO,M.BRHID,M.DOC_NO cregno,M.DATE,U.USER_NAME user,C.NAME type,M.REMARKS,IF(REPEATED=1,'YES','NO') REPEATED,REGNO vehicle,AC.REFNAME client,CALLEDBY callby,CALLEDBYMOB mob,C1.NAME status,SM.GRPCODE groupname,EMP.NAME member,  TIMESTAMPDIFF(MINUTE,COALESCE(A.ENTRYDATE,M.DATE),COALESCE(CLOSETIME,NOW())) tottime, IF((TIMESTAMPDIFF(MINUTE,COALESCE(A.ENTRYDATE,M.DATE),COALESCE(CLOSETIME,NOW()))-COALESCE(OVERDUE,0)<0),0, TIMESTAMPDIFF(MINUTE,COALESCE(A.ENTRYDATE,M.DATE),COALESCE(CLOSETIME,NOW()))-COALESCE(OVERDUE,0)) OVERDUE  FROM CM_CUSCALLM M LEFT JOIN cm_srvassign A ON M.TR_NO=A.REFDOCNO  LEFT JOIN MY_USER U ON U.DOC_NO=M.USERID LEFT JOIN cm_cuscalltype C ON C.DOC_NO=M.CALLTYPE  LEFT JOIN MY_ACBOOK AC ON AC.DOC_NO=M.CLDOCNO AND AC.DTYPE='CRM'  LEFT JOIN cm_cuscallstatus C1 ON C1.SRNO=A.STATUSID   LEFT JOIN cm_serteamm SM ON SM.DOC_NO=A.EMPGROUPID  "
							+ "LEFT JOIN HR_EMPM EMP ON EMP.DOC_NO=A.EMPID WHERE 1=1  "+sqltest+" and m.DATE between '"+sqlFromDate+"' and  '"+sqlToDate+"') a "+sqltest2+"";
					
					System.out.println("sumtype1"+sql1);
					
				    ResultSet resultSet = stmtCollection.executeQuery(sql1);
				                
				    RESULTDATA=ClsCommon.convertToJSON(resultSet);
				    
				    stmtCollection.close();
				    conn.close();
			  }catch(Exception e){
				  e.printStackTrace();
				  conn.close();
			  }finally{
				  conn.close();
			  }
			  return RESULTDATA;
			}
		
		public JSONArray clientgridload(String client) throws SQLException {
			JSONArray RESULTDATA=new JSONArray();
			
			Connection conn = null;
			
//			java.sql.Date sqlFromDate = null;
//	        java.sql.Date sqlToDate = null;
	        String sqltest="";
	        
			  try {
				    conn = ClsConnection.getMyConnection();
				    Statement stmtCollection = conn.createStatement();
				    
				    
				    String sql1 = "";
				    					
					sql1 = "SELECT M.DOC_NO ,M.DATE,U.USER_NAME user,C.NAME type,M.REMARKS,IF(REPEATED=1,'YES','NO') REPEATED,REGNO vehicle,AC.REFNAME client,CALLEDBY callby,CALLEDBYMOB mob,"
							+ " TIMESTAMPDIFF(MINUTE,MIN(COALESCE(A.ENTRYDATE,M.DATE)),MAX(COALESCE(A.ENTRYDATE,NOW()))) tottime,"
							+ " IF(TIMESTAMPDIFF(MINUTE,MIN(COALESCE(A.ENTRYDATE,M.DATE)),MAX(COALESCE(A.ENTRYDATE,NOW())))-SUM(COALESCE(OVERDUE,0))<0 ,0,"
							+ " TIMESTAMPDIFF(MINUTE,MIN(COALESCE(A.ENTRYDATE,M.DATE)),MAX(COALESCE(A.ENTRYDATE,NOW())))) OVERDUE"
							+ " FROM CM_CUSCALLM M LEFT JOIN cm_srvassign A ON M.TR_NO=A.REFDOCNO "
							+ " LEFT JOIN MY_USER U ON U.DOC_NO=M.USERID LEFT JOIN cm_cuscalltype C ON C.DOC_NO=M.CALLTYPE "
							+ " LEFT JOIN MY_ACBOOK AC ON AC.DOC_NO=M.CLDOCNO AND AC.DTYPE='CRM' "
							+ " LEFT JOIN cm_cuscallstatus C1 ON C1.SRNO=A.STATUSID   WHERE 1=1 and ac.refname='"+client+"'  GROUP BY M.TR_NO";
				    System.out.println("sumclientpop"+sql1);
					
				    ResultSet resultSet = stmtCollection.executeQuery(sql1);
				                
				    RESULTDATA=ClsCommon.convertToJSON(resultSet);
				    
				    stmtCollection.close();
				    conn.close();
			  }catch(Exception e){
				  e.printStackTrace();
				  conn.close();
			  }finally{
				  conn.close();
			  }
			  return RESULTDATA;
			}
		public JSONArray typegridload(String type) throws SQLException {
			JSONArray RESULTDATA=new JSONArray();
			
			Connection conn = null;
			
//			java.sql.Date sqlFromDate = null;
//	        java.sql.Date sqlToDate = null;
	        String sqltest="";
	        
			  try {
				    conn = ClsConnection.getMyConnection();
				    Statement stmtCollection = conn.createStatement();
				    
				    
				    String sql1 = "";
				    					
					sql1 = "SELECT M.DOC_NO ,M.DATE,U.USER_NAME user,C.NAME type,M.REMARKS,IF(REPEATED=1,'YES','NO') REPEATED,REGNO vehicle,AC.REFNAME client,CALLEDBY callby,CALLEDBYMOB mob,"
							+ " TIMESTAMPDIFF(MINUTE,MIN(COALESCE(A.ENTRYDATE,M.DATE)),MAX(COALESCE(A.ENTRYDATE,NOW()))) tottime,"
							+ " IF(TIMESTAMPDIFF(MINUTE,MIN(COALESCE(A.ENTRYDATE,M.DATE)),MAX(COALESCE(A.ENTRYDATE,NOW())))-SUM(COALESCE(OVERDUE,0))<0 ,0,"
							+ " TIMESTAMPDIFF(MINUTE,MIN(COALESCE(A.ENTRYDATE,M.DATE)),MAX(COALESCE(A.ENTRYDATE,NOW())))) OVERDUE"
							+ " FROM CM_CUSCALLM M LEFT JOIN cm_srvassign A ON M.TR_NO=A.REFDOCNO "
							+ " LEFT JOIN MY_USER U ON U.DOC_NO=M.USERID LEFT JOIN cm_cuscalltype C ON C.DOC_NO=M.CALLTYPE "
							+ " LEFT JOIN MY_ACBOOK AC ON AC.DOC_NO=M.CLDOCNO AND AC.DTYPE='CRM' "
							+ " LEFT JOIN cm_cuscallstatus C1 ON C1.SRNO=A.STATUSID  WHERE 1=1 and c.name='"+type+"'  GROUP BY M.TR_NO";
				    
					System.out.println("sumtypepop"+sql1);
					
				    ResultSet resultSet = stmtCollection.executeQuery(sql1);
				                
				    RESULTDATA=ClsCommon.convertToJSON(resultSet);
				    
				    stmtCollection.close();
				    conn.close();
			  }catch(Exception e){
				  e.printStackTrace();
				  conn.close();
			  }finally{
				  conn.close();
			  }
			  return RESULTDATA;
			}
		public  JSONArray VehSearch() throws SQLException {

			JSONArray RESULTDATA=new JSONArray();


			Connection conn=null;
			try {
				conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();

				String salsql="select doc_no,regno from cm_cuscallm where  status<>7 ";

				ResultSet resultSet = stmtVeh.executeQuery(salsql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtVeh.close();
				conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
			return RESULTDATA;
		}

		
	}