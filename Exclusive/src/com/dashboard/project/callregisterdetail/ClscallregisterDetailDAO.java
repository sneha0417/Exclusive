package com.dashboard.project.callregisterdetail;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClscallregisterDetailDAO{

	ClsConnection conobj= new ClsConnection();
	ClsCommon com=new ClsCommon();  
	public JSONArray estCenterdata(String fromdate,String todate,String branch,String complid,String userid,String ctype) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        
     	String sqltest="";
        java.sql.Date sqlfromdate = null;
        java.sql.Date sqltodate = null;
    	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=com.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

       
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=com.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}
     	
       
     	if(!(complid.equals("0") || complid.equals("") || complid.equals("undefined"))){
     		sqltest+=" and cd.cmplId="+complid+"";
		}
     	if(!(userid.equals("0") || userid.equals("") || userid.equals("undefined"))){
     		sqltest+=" and cus.userid="+userid+"";
		}
     	if(!(ctype.equals("0") || ctype.equals("") || ctype.equals("undefined"))){
     		if(ctype.equalsIgnoreCase("OPN"))
     		{
     			sqltest+=" and cus.clstatus!=3";
     		}
     		else if(ctype.equalsIgnoreCase("CLS"))
     		{
     			sqltest+=" and cus.clstatus=3";
     		}
     		
		}
       	if(branch.equalsIgnoreCase("a")||branch.equalsIgnoreCase("0"))
    	{
			sqltest+="";
    	}
		else
		{
			sqltest+=" and cus.brhid="+branch;
		}
       
     	Connection conn = null;
     	
		Statement stmtVeh =null;
		ResultSet resultSet=null;
        
		try {
			
				 conn = conobj.getMyConnection();
				 stmtVeh = conn.createStatement ();
				String sql="select st.site,cus.doc_no docno,DATE_FORMAT(cus.entrydate,'%d-%m-%Y:%H:%m') date,us.user_name user,ac.refname,concat(DATE_FORMAT(ser.plannedon,'%d-%m-%Y'),':',if(ser.pltime=0,'00:00',ser.pltime)) pldate,gvd.groupname sertype,"
						+ "coalesce(m.grpcode,'') as asgngrp,coalesce(em.name,'') as emp,gv.groupname compl,"
						+ " CAST(CONCAT(TIMESTAMPDIFF(day,cus.entrydate, NOW()) , ':',MOD( TIMESTAMPDIFF(hour,cus.entrydate, NOW()), 24), ':',"
						+ "MOD( TIMESTAMPDIFF(minute,cus.entrydate, NOW()), 60)) AS CHAR) duration from cm_cuscallm cus "
						+ "left join cm_srvcsited st on cus.siteid=st.rowno "
						+ "left join cm_servplan ser on ser.reftrno=cus.tr_no and ser.dtype='CREG' left join my_user us on cus.userid=us.doc_no "
						+ "left join my_acbook ac on ac.cldocno=cus.cldocno and ac.dtype='CRM' left join cm_cuscalld cd on cus.tr_no=cd.tr_no "
						+ "left join my_groupvals gv on cd.cmplId=gv.doc_no left join my_groupvals gvd on cd.servid=gvd.doc_no "
						+ "left join cm_serteamm m on(ser.empgroupid=m.doc_no) left join cm_serteamd md on(md.rdocno=m.doc_no and ser.empid=md.empid)"
						+ " left join hr_empm em on(md.empid=em.doc_no) where DATE_FORMAT(cus.entrydate,'%Y-%m-%d') between '"+sqlfromdate+"'  and '"+sqltodate+"' "+sqltest+" and cus.status=3  group by cus.doc_no";
            		
          System.out.println("--estimationcenter=--"+sql);
            		resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=com.convertToJSON(resultSet);
     			
		}
		catch(Exception e){
			conn.close();
		}
		finally{
			stmtVeh.close();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	public JSONArray enquirylistExcel(String fromdate,String todate,String branch,String complid,String userid,String ctype) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        
     	String sqltest="";
        java.sql.Date sqlfromdate = null;
        java.sql.Date sqltodate = null;
    	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=com.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

       
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=com.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}
     	
       
     	if(!(complid.equals("0") || complid.equals("") || complid.equals("undefined"))){
     		sqltest+=" and cd.cmplId="+complid+"";
		}
     	if(!(userid.equals("0") || userid.equals("") || userid.equals("undefined"))){
     		sqltest+=" and cus.userid="+userid+"";
		}
     	if(!(ctype.equals("0") || ctype.equals("") || ctype.equals("undefined"))){
     		if(ctype.equalsIgnoreCase("OPN"))
     		{
     			sqltest+=" and cus.clstatus!=3";
     		}
     		else if(ctype.equalsIgnoreCase("CLS"))
     		{
     			sqltest+=" and cus.clstatus=3";
     		}
     		
		}
       	if(branch.equalsIgnoreCase("a")||branch.equalsIgnoreCase("0"))
    	{
			sqltest+="";
    	}
		else
		{
			sqltest+=" and cus.brhid="+branch;
		}
       
     	Connection conn = null;
     	
		Statement stmtVeh =null;
		ResultSet resultSet=null;
        
		try {
			
				 conn = conobj.getMyConnection();
				 stmtVeh = conn.createStatement ();
				String sql="select cus.doc_no 'DOC NO',DATE_FORMAT(cus.entrydate,'%d-%m-%Y:%H:%m') 'DATE',us.user_name 'USER',ac.refname 'CLIENT',gvd.groupname 'SERVICE TYPE', st.site 'SITE',gv.groupname 'COMPLAINT',concat(DATE_FORMAT(ser.plannedon,'%d-%m-%Y'),':',if(ser.pltime=0,'00:00',ser.pltime)) 'PLANNED ON',"
						+ "coalesce(m.grpcode,'') 'ASSIGN GROUP',coalesce(em.name,'') 'EMPLOYEE',"
						+ " CAST(CONCAT(TIMESTAMPDIFF(day,cus.entrydate, NOW()) , ':',MOD( TIMESTAMPDIFF(hour,cus.entrydate, NOW()), 24), ':',"
						+ "MOD( TIMESTAMPDIFF(minute,cus.entrydate, NOW()), 60)) AS CHAR) 'DURATION' from cm_cuscallm cus "
						+ "left join cm_srvcsited st on cus.siteid=st.rowno "
						+ "left join cm_servplan ser on ser.reftrno=cus.tr_no and ser.dtype='CREG' left join my_user us on cus.userid=us.doc_no "
						+ "left join my_acbook ac on ac.cldocno=cus.cldocno and ac.dtype='CRM' left join cm_cuscalld cd on cus.tr_no=cd.tr_no "
						+ "left join my_groupvals gv on cd.cmplId=gv.doc_no left join my_groupvals gvd on cd.servid=gvd.doc_no "
						+ "left join cm_serteamm m on(ser.empgroupid=m.doc_no) left join cm_serteamd md on(md.rdocno=m.doc_no and ser.empid=md.empid)"
						+ " left join hr_empm em on(md.empid=em.doc_no) where DATE_FORMAT(cus.entrydate,'%Y-%m-%d') between '"+sqlfromdate+"'  and '"+sqltodate+"' "+sqltest+" and cus.status=3  group by cus.doc_no";
            		
          System.out.println("--estimationcenterexcel=--"+sql);
            		resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=com.convertToEXCEL(resultSet);
     			
		}
		catch(Exception e){
			conn.close();
		}
		finally{
			stmtVeh.close();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }


	public JSONArray searchcomplaint(HttpSession session) throws SQLException {


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


		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmtVeh1 = conn.createStatement ();

			String clsql= ("select doc_no,groupname from my_groupvals where grptype='complaints' and status=3");

			ResultSet resultSet = stmtVeh1.executeQuery(clsql);

			RESULTDATA=com.convertToJSON(resultSet);
			stmtVeh1.close();
			conn.close();
		
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	

	public JSONArray userSearch(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select doc_no docno,user_name username from my_user where status=3 and block=0";

//			System.out.println("===getassign===="+sql);

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

	

}
