package com.dashboard.project.callregisterstatus;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.sun.org.apache.bcel.internal.generic.DCONST;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Properties;
import java.util.Set;
import java.util.Vector;
import java.util.concurrent.TimeUnit;

public class callregisterstatusDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cm=new ClsCommon();
	public  JSONArray loadGridData(String fromdate,String todate,String rds,String barchval) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="";
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sqlfromdate = null;
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=cm.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqltodate=cm.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}
//System.out.println(rds);
			if(barchval.equalsIgnoreCase("a"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest+=" and cc.brhid="+barchval;
			}
			
			if(rds.equalsIgnoreCase("EN")){
				sqltest+=" and cc.clstatus=0  ";
			}
			 if(rds.equalsIgnoreCase("HO")){
					sqltest+=" and  cc.clstatus=1 ";
				}
			 if(rds.equalsIgnoreCase("CL")){
					sqltest+=" and  cc.clstatus=2 ";
				}
				 if(rds.equalsIgnoreCase("CO")){
						sqltest+=" and  cc.clstatus=3 ";
					}
				 if(rds.equalsIgnoreCase("ST")){
						sqltest+=" and  cc.clstatus=4 ";
					}
				
		String sqldata="select cc.doc_no,cc.dtype,ac.codeno custid,ac.refname cname,cc.calledby cbname,cc.calledbymob cbmobno,"
				+ "cc.contracttype ctype,cm.doc_no cno,cs.site,cc.remarks descp,me.menu_name as menuname,me.func path,cc.brhid branch,'VIEW' view,'ATTACH' attach from cm_cuscallm cc left join my_acbook ac on cc.cldocno=ac.cldocno LEFT JOIN CM_SRVCONTRM CM ON CM.TR_NO=CC.contractno and cm.dtype=cc.contracttype "
				+ "left Join cm_srvcsited cs on cs.rowno=cc.siteid left join my_menu me on(me.doc_type=cc.dtype) where cc.date between '"+sqlfromdate+"'  and '"+sqltodate+"' and cc.status!=7 "+sqltest+" group by cc.tr_no ";
		
		System.out.println(sqldata);
				resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cm.convertToJSON(resultSet);
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
	
	
	public JSONArray getStatusCount(String fromdate,String todate,String barchval) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
			Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="";
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sdate = null;
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sdate=cm.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date edate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		edate=cm.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}
			if(!barchval.equalsIgnoreCase("a"))
        	{
				sqltest+=" and brhid="+barchval;
        	}
			
			
			String sqldata="select count(*) val,'Entered' stat,'EN' rds from cm_cuscallm where clstatus=0 "
					+ "and date between '"+sdate+"' and '"+edate+"' and status!=7 "+sqltest+" "
					+ "union select count(*) val,'Hold' stat,'HO' rds from cm_cuscallm where  clstatus=1 "
					+ "and date between '"+sdate+"' and '"+edate+"' and status!=7 "+sqltest+" union "
					+ "select count(*) val,'Closed' stat,'CL' rds from cm_cuscallm where clstatus=2 and date between '"+sdate+"' and '"+edate+"' and status!=7  "+sqltest+" "
					+ "union select count(*) val,'Completed' stat,'CO' rds from cm_cuscallm where clstatus=3 "
					+ "and date between '"+sdate+"' and '"+edate+"' and status!=7 "+sqltest+" union select count(*) val,'Started' stat,'ST' rds from cm_cuscallm "
					+ "where clstatus=4 and date between '"+sdate+"' and '"+edate+"' and status!=7 "+sqltest+" ";
		System.out.println("==count=="+sqldata);
			resultSet = stmt.executeQuery (sqldata);
			RESULTDATA=cm.convertToJSON(resultSet);
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
	
	public  JSONArray loadGridExcel(String fromdate,String todate,String rds,String barchval) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="";
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sqlfromdate = null;
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=cm.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqltodate=cm.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}
//System.out.println(rds);
			if(barchval.equalsIgnoreCase("a"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest+=" and cc.brhid="+barchval;
			}
			
			if(rds.equalsIgnoreCase("EN")){
				sqltest+=" and cc.clstatus=0  ";
			}
			 if(rds.equalsIgnoreCase("HO")){
					sqltest+=" and  cc.clstatus=1 ";
				}
			 if(rds.equalsIgnoreCase("CL")){
					sqltest+=" and  cc.clstatus=2 ";
				}
				 if(rds.equalsIgnoreCase("CO")){
						sqltest+=" and  cc.clstatus=3 ";
					}
				 if(rds.equalsIgnoreCase("ST")){
						sqltest+=" and  cc.clstatus=4 ";
					}
				
		String sqldata="select cc.doc_no 'Doc No',cc.dtype 'Doc Type',ac.codeno 'Customer Id',ac.refname 'Name',cc.calledby 'Called By Name',cc.calledbymob 'Called By Mob',"
				+ "cc.contracttype 'Contract Type',cm.doc_no 'Contract No',cs.site 'Site',cc.remarks 'Description' from cm_cuscallm cc left join my_acbook ac on cc.cldocno=ac.cldocno LEFT JOIN CM_SRVCONTRM CM ON CM.TR_NO=CC.contractno and cm.dtype=cc.contracttype "
				+ "left Join cm_srvcsited cs on cs.rowno=cc.siteid where cc.date between '"+sqlfromdate+"'  and '"+sqltodate+"' and cc.status!=7 "+sqltest+" group by cc.tr_no ";
		
		System.out.println(sqldata);
				resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cm.convertToEXCEL(resultSet);
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
	
	

}