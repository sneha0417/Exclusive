package com.dashboard.analysis.leadAnalysis;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.itextpdf.text.log.SysoCounter;

import net.sf.json.JSONArray;

public class ClsLeadAnalysisDAO {
	
	ClsCommon com=new ClsCommon();
	ClsConnection conobj=new ClsConnection();
	
	public JSONArray salmData(HttpSession session,String val) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql = "";
			if((!(val.equalsIgnoreCase("0")))&&(!(val.equalsIgnoreCase("")))){
				if(val.equalsIgnoreCase("salm"))
				{
					sql="select  coalesce(sal_name,'') stat,doc_no doc from my_salm where status=3";	
				}
				else if(val.equalsIgnoreCase("status"))
				{
					sql="select '1' as doc,'Cold' as stat union all select '2' as doc,'Warm' as stat union all select '3' as doc,'Hot' as stat";
				}
				else if(val.equalsIgnoreCase("type"))
				{
					sql="select '1' as doc,'Converted' as stat union all select '2' as doc,'Not Converted' as stat";
				}
			}
			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}
	
	public JSONArray getStatusCount(String fromdate,String todate,String barchval,String filterval,String groupval,String docarray) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
			Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="";
		String sqldata="";
	
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sdate = null;
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sdate=com.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date edate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		edate=com.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}
			if(!barchval.equalsIgnoreCase("a"))
        	{
				sqltest+=" and brhid="+barchval;
        	}
			
			if((!(groupval.equalsIgnoreCase("0")))&&(!(groupval.equalsIgnoreCase("")))){
				 
					 if(groupval.equalsIgnoreCase("salm") )
				{
					if(filterval.equalsIgnoreCase("salm") && !(docarray.equalsIgnoreCase(""))){
						sqltest+=" and pm.sal_id in("+docarray+")";
					}
					else if(filterval.equalsIgnoreCase("status") && !(docarray.equalsIgnoreCase(""))){
						
							sqltest+=" and pm.priorstatus in("+docarray+")";
					}
					else if(filterval.equalsIgnoreCase("type") && !(docarray.equalsIgnoreCase(""))){
						if(docarray.equalsIgnoreCase("1")){
							sqltest+=" and pm.clientacid>0";
						}
						else if(docarray.equalsIgnoreCase("2")){
							sqltest+=" and pm.clientacid=0";
						}
						else{
							sqltest+="";
						}
						
					}
					sqldata="select sm.sal_name stat,count(pm.sal_id) val,pm.sal_id doc from cm_prosclientm pm "
							+ "left join my_salm sm on sm.doc_no=pm.sal_id and sm.status=3 where pm.status=3 and pm.date between '"+sdate+"' and '"+edate+"' "+sqltest+" group by pm.sal_id";	
				}
				else if(groupval.equalsIgnoreCase("status"))
				{
					if(filterval.equalsIgnoreCase("salm") && !(docarray.equalsIgnoreCase(""))){
						sqltest+=" and pm.sal_id in("+docarray+")";
					}
					else if(filterval.equalsIgnoreCase("status") && !(docarray.equalsIgnoreCase(""))){
						
							sqltest+=" and pm.priorstatus in("+docarray+")";
					}
					else if(filterval.equalsIgnoreCase("type") && !(docarray.equalsIgnoreCase(""))){
						if(docarray.equalsIgnoreCase("1")){
							sqltest+=" and pm.clientacid>0";
						}
						else if(docarray.equalsIgnoreCase("2")){
							sqltest+=" and pm.clientacid=0";
						}
						else{
							sqltest+="";
						}
						
					}
					
					sqldata="select if(pm.priorstatus=1,'COLD',if(pm.priorstatus=2,'WARM','HOT')) stat,count(pm.priorstatus) val,pm.priorstatus doc from cm_prosclientm pm "
							+ "where pm.status=3 and pm.date between '"+sdate+"' and '"+edate+"' "+sqltest+" group by pm.priorstatus";	
				}
				else if(groupval.equalsIgnoreCase("type"))
				{
					if(filterval.equalsIgnoreCase("salm") && !(docarray.equalsIgnoreCase("")) ){
						
						sqltest+=" and pm.sal_id in("+docarray+") ";
					}
					else if(filterval.equalsIgnoreCase("status") && !(docarray.equalsIgnoreCase("")) ){
						
							sqltest+=" and pm.priorstatus in("+docarray+") ";
					}
					else if(filterval.equalsIgnoreCase("type") && !(docarray.equalsIgnoreCase("")) ){
						if(docarray.equalsIgnoreCase("1")){
							sqltest+=" and pm.clientacid>0";
						}
						else if(docarray.equalsIgnoreCase("2")){
							sqltest+=" and pm.clientacid=0";
						}
						else{
							sqltest+="";
						}
					}
					
					sqldata="select if(pm.clientacid=0,'NOT CONVERTED','CONVERTED') stat,count(pm.priorstatus) val,if(pm.clientacid=0,'2','1') doc from cm_prosclientm pm "
							+ "where pm.status=3 and pm.date between '"+sdate+"' and '"+edate+"' "+sqltest+"   group by pm.clientacid";	
				}
				}
			
		System.out.println("====sqldata=="+sqldata);
			resultSet = stmt.executeQuery (sqldata);
			RESULTDATA=com.convertToJSON(resultSet);
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
	
	public  JSONArray loadGridData(String fromdate,String todate,String barchval,String filterval,String groupval,String docarray,String docs) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="";
		String sqldata="";
	
        java.sql.Date sqlFollowUpDate = null;
        java.sql.Date sdate = null;
        java.sql.Date edate = null;
     //   System.out.println("barchval="+barchval+"fromdate=-"+fromdate+"todate"+todate);
		try {

			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();
			
					if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
						sdate = com.changeStringtoSqlDate(fromdate);
					}
					if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
						edate = com.changeStringtoSqlDate(todate);
					}
					
			if(barchval.equalsIgnoreCase("a")||barchval.equalsIgnoreCase("0"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest+=" and m.brhid="+barchval;
			}
		
			
			if((!(groupval.equalsIgnoreCase("0")))&&(!(groupval.equalsIgnoreCase("")))){
				 
				 if(groupval.equalsIgnoreCase("salm") )
			{
				if(filterval.equalsIgnoreCase("salm") && !(docarray.equalsIgnoreCase(""))){
					sqltest+=" and pm.sal_id in("+docarray+")";
				}
				else if(filterval.equalsIgnoreCase("status") && !(docarray.equalsIgnoreCase(""))){
					
						sqltest+=" and pm.priorstatus in("+docarray+")";
				}
				else if(filterval.equalsIgnoreCase("type") && !(docarray.equalsIgnoreCase(""))){
					if(docarray.equalsIgnoreCase("1")){
						sqltest+=" and pm.clientacid>0";
					}
					else if(docarray.equalsIgnoreCase("2")){
						sqltest+=" and pm.clientacid=0";
					}
					else{
						sqltest+="";
					}
					
				}
				sqldata="select pm.brhid brhid,pm.userid userid,s.sal_name salesman,pm.tr_no,pm.DOC_NO,pm.name,pm.tel mob_no,pm.email,pm.DATE,pm.description desc1,"
						+ "if(pm.priorstatus=1,'Cold',if(pm.priorstatus=2,'Warm','Hot')) leadstatus,pm.dtype,if(pm.clientacid=0,'NOT CONVERTED','CONVERTED') cltype from cm_prosclientm pm left join my_salm s on pm.sal_id=s.doc_no "
						+ "where pm.status=3 and pm.sal_id="+docs+" and pm.date between '"+sdate+"' and '"+edate+"' "+sqltest+" ";	
			}
			else if(groupval.equalsIgnoreCase("status"))
			{
				if(filterval.equalsIgnoreCase("salm") && !(docarray.equalsIgnoreCase(""))){
					sqltest+=" and pm.sal_id in("+docarray+")";
				}
				else if(filterval.equalsIgnoreCase("status") && !(docarray.equalsIgnoreCase(""))){
					
						sqltest+=" and pm.priorstatus in("+docarray+")";
				}
				else if(filterval.equalsIgnoreCase("type") && !(docarray.equalsIgnoreCase(""))){
					if(docarray.equalsIgnoreCase("1")){
						sqltest+=" and pm.clientacid>0";
					}
					else if(docarray.equalsIgnoreCase("2")){
						sqltest+=" and pm.clientacid=0";
					}
					else{
						sqltest+="";
					}
					
				}
				
				sqldata="select pm.brhid brhid,pm.userid userid,s.sal_name salesman,pm.tr_no,pm.DOC_NO,pm.name,pm.tel mob_no,pm.email,pm.DATE,pm.description desc1,"
						+ "if(pm.priorstatus=1,'Cold',if(pm.priorstatus=2,'Warm','Hot')) leadstatus,pm.dtype,if(pm.clientacid=0,'NOT CONVERTED','CONVERTED') cltype from cm_prosclientm pm left join my_salm s on pm.sal_id=s.doc_no "
						+ "where pm.status=3 and pm.priorstatus="+docs+" and pm.date between '"+sdate+"' and '"+edate+"' "+sqltest+" ";	
			}
			else if(groupval.equalsIgnoreCase("type"))
			{
				if(filterval.equalsIgnoreCase("salm") && !(docarray.equalsIgnoreCase("")) ){
					
					sqltest+=" and pm.sal_id in("+docarray+") ";
				}
				else if(filterval.equalsIgnoreCase("status") && !(docarray.equalsIgnoreCase("")) ){
					
						sqltest+=" and pm.priorstatus in("+docarray+") ";
				}
				else if(filterval.equalsIgnoreCase("type") && !(docarray.equalsIgnoreCase("")) ){
					if(docarray.equalsIgnoreCase("1")){
						sqltest+=" and pm.clientacid>0";
					}
					else if(docarray.equalsIgnoreCase("2")){
						sqltest+=" and pm.clientacid=0";
					}
					else{
						sqltest+="";
					}
				}
				
				sqldata="select pm.brhid brhid,pm.userid userid,s.sal_name salesman,pm.tr_no,pm.DOC_NO,pm.name,pm.tel mob_no,pm.email,pm.DATE,pm.description desc1,"
						+ "if(pm.priorstatus=1,'Cold',if(pm.priorstatus=2,'Warm','Hot')) leadstatus,pm.dtype,if(pm.clientacid=0,'NOT CONVERTED','CONVERTED') cltype from cm_prosclientm pm left join my_salm s on pm.sal_id=s.doc_no "
						+ "where pm.status=3 and if("+docs+"=1,pm.clientacid>0,pm.clientacid=0) and pm.date between '"+sdate+"' and '"+edate+"' "+sqltest+"  ";	
			}
			}

			
			System.out.println("=amcf==="+sqldata+"end");
					
		
				resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=com.convertToJSON(resultSet);
				//	System.out.println("=====RESULTDATA"+RESULTDATA);
			
			
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

}
