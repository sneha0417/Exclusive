package com.dashboard.aviation.fuelstatus;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsFuelStatusDAO {

	ClsConnection ClsConnection=new ClsConnection();
    ClsCommon cmn=new ClsCommon();
	
    /* fsGrid data loading */
    public  JSONArray loadGridData(String dtype,String sortby,String clientid,String portid,int id) throws SQLException {

    	JSONArray RESULTDATA=new JSONArray();
		java.sql.Date todate=null;

		Connection conn =null;
		Statement stmt =null;
		String sql11="",sql12="";
		if((dtype.equals("ENT"))){
			sql11=sql11+" and d.delstat=0 and d.invoiced=0 and d.cancelstatus=0";
		}
		else if((dtype.equals("DEL"))){
			sql11=sql11+" and d.delstat=1 and d.invoiced=0";
		}
		else if((dtype.equals("INV"))){
			sql11=sql11+" and d.delstat=1 and d.invoiced=1";
		}
		else if((dtype.equals("CAN"))){
			sql11=sql11+" and d.cancelstatus=2";
		}
		else{
			sql11=sql11;
		}
		if(!(sortby.equals("0") || sortby.equals("") || sortby.equals("undefined"))){
			sql12=sql12+" order by "+sortby+" ";
		}
		if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
			sql11=sql11+" and m.cldocno in ("+clientid+")";
		}
		if(!(portid.equals("0") || portid.equals("") || portid.equals("undefined"))){
			sql11=sql11+" and d.portid in ("+portid+")";
		}
		try {
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();

			if(id>0){ 
	
				String sql="select m.voc_no doc_no,m.date,coalesce(ac.RefName,'') client,p.port,p.desc1 region,"
						+ "d.acraft_no,im.ltrqty,im.usgqty,im.sprice,im.amountusd,im.amountaed,d.remarks description from my_port p "
						+ "left join av_fueld d on d.portid=p.doc_no left join av_fuelm m on d.rdocno=m.doc_no "
						+ "left join my_acbook ac on m.cldocno=ac.cldocno left join av_invd im on im.refdocno=d.row_no "
						+ "where m.status=3 "+sql11+" "+sql12+" ";
			    System.out.println("--------+++-------"+sql);	
				ResultSet resultSet = stmt.executeQuery(sql); 
				RESULTDATA=cmn.convertToJSON(resultSet);
			}
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
    
    /* countGrid data loading */
    
    public JSONArray serCountgrid(HttpSession session,String clientid,String portid,int id,String fromdate,String todate) throws SQLException
	{

		JSONArray RESULTDATA=new JSONArray();
		 java.sql.Date sqlFromDate = null;
	        java.sql.Date sqlToDate = null;
		Connection conn =null;
		Statement stmt =null;
		String sql11="";
		if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
			sql11=sql11+" and m.cldocno in ("+clientid+")";
		}
		if(!(portid.equals("0") || portid.equals("") || portid.equals("undefined"))){
			sql11=sql11+" and d.portid in ("+portid+")";
		}
		try {
			if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
				sqlFromDate = cmn.changeStringtoSqlDate(fromdate);
            }
			
			if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
				sqlToDate = cmn.changeStringtoSqlDate(todate);
			}
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
          if(id>0){ 
	
				String sql= "select 'ENTERED' name,count(*) value,'ENT' dtype from av_fuelm m left join av_fueld d on "
						+ "m.doc_no=d.rdocno where m.status=3 and m.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and d.delstat=0 and d.invoiced=0 and d.cancelstatus=0 "+sql11+" UNION ALL select 'DELIVERED' name,"
						+ "count(*) value,'DEL' dtype from av_fuelm m left join av_fueld d on m.doc_no=d.rdocno where m.status=3 and m.date between '"+sqlFromDate+"' and '"+sqlToDate+"' "
						+ "and d.delstat=1 and d.invoiced=0 "+sql11+" UNION ALL select 'INVOICED' name,count(*) value,'INV' dtype from av_fuelm m "
						+ "left join av_fueld d on m.doc_no=d.rdocno where m.status=3 and m.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and d.delstat=1 and d.invoiced=1 "+sql11+" "
						+ "UNION ALL select 'CANCELLED' name,count(*) value,'CAN' dtype from av_fuelm m left join av_fueld d on m.doc_no=d.rdocno where m.status=3 and m.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and d.cancelstatus=2 "+sql11+" UNION ALL "
						+ "select 'ALL' name,count(*) value,'ALL' dtype from av_fuelm m left join av_fueld d on m.doc_no=d.rdocno where m.status=3 and d.rdocno is not null and m.date between '"+sqlFromDate+"' and '"+sqlToDate+"' "+sql11+"";
				//System.out.println("------------++-----------"+sql);
				ResultSet resultSet = stmt.executeQuery(sql);
				RESULTDATA=cmn.convertToJSON(resultSet);
			}
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
    
   
     public JSONArray clientsearch(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select cldocno,coalesce(RefName,'') client from my_acbook ac where status=3";

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=cmn.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}
    public JSONArray portsearch(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select doc_no,port from my_port where status=3";

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=cmn.convertToJSON(resultSet1);

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





