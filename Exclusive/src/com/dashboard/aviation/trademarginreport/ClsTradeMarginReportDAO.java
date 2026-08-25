package com.dashboard.aviation.trademarginreport;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsTradeMarginReportDAO {

	ClsConnection ClsConnection=new ClsConnection();
    ClsCommon cmn=new ClsCommon();
	
    /* tmrGrid data loading */
	   public  JSONArray loadGridData(String sortby,String clientid,String portid,String datefilter,String vendorid,String fromdate,String todate,int id) throws SQLException {

	    	JSONArray RESULTDATA=new JSONArray();

			Connection conn =null;
			Statement stmt =null;
			java.sql.Date sqlFromDate = null;
			java.sql.Date sqlToDate = null;
			
			if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
				sqlFromDate = cmn.changeStringtoSqlDate(fromdate);
            }
			if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
				sqlToDate = cmn.changeStringtoSqlDate(todate);
			}
			
			String sql11="",sql12="";
			if(!(sortby.equals("0") || sortby.equals("") || sortby.equals("undefined"))){
				sql12=sql12+" order by "+sortby+" ";
			}
			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sql11=sql11+" and ac1.cldocno in ("+clientid+")";
			}
			if(!(portid.equals("0") || portid.equals("") || portid.equals("undefined"))){
				sql11=sql11+" and d.portid in ("+portid+")";
			}
			if(!(vendorid.equals("0") || vendorid.equals("") || vendorid.equals("undefined"))){
				sql11=sql11+" and (ac.cldocno in ("+vendorid+") and ac.dtype='VND') ";
			}
			if(sqlFromDate!=null){
				if(datefilter.equalsIgnoreCase("invdate")){
					sql11=sql11+" and m.date>='"+sqlFromDate+"'";
				} else {
					sql11=sql11+" and fm.date>='"+sqlFromDate+"'";
				}
			}
			if(sqlToDate!=null){
				if(datefilter.equalsIgnoreCase("invdate")){
					sql11=sql11+" and m.date<='"+sqlToDate+"'";
				} else {
					sql11=sql11+" and fm.date<='"+sqlToDate+"'";
				}
			}
			
		try {
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();

			if(id>0){ 
	
				String sql="select fm.doc_no delno,m.voc_no invno,fd.delnoteno dno,m.date invdate,fm.date fueldate,"
						+ "coalesce(ac1.RefName,'') client,coalesce(ac.RefName,'') vendor,p.port port,d.sprice sales,"
						+ "d.pprice purc,d.usgqty qty,d.amountusd sval,d.amountusdp pval,convert(coalesce(d.sprice-d.pprice,''),"
						+ "char(100)) usc,convert(coalesce(d.amountusd-d.amountusdp,''),char(100)) total,"
						+ "convert(coalesce(((d.amountusd-d.amountusdp)/d.amountusd)*100,''),char(100)) perc from my_port p "
						+ "left join av_invd d on d.portid=p.doc_no left join av_invm m on d.rdocno=m.doc_no "
						+ "left join av_fuelm fm on d.rdocno=fm.doc_no left join av_fueld fd on fd.rdocno=fm.doc_no "
						+ "left join my_acbook ac1 on m.client_id=ac1.cldocno left join my_acbook ac on m.vndacno=ac.acno "
						+ "where m.status=3 and fm.status=3 "+sql11+" "+sql12+"";
				//System.out.println("==============sql========="+sql);
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
	   /* Excel tmrGrid data loading */
	   public  JSONArray exloadGridData(String sortby,String clientid,String portid,String datefilter,String vendorid,String fromdate,String todate,int id) throws SQLException {

	    	JSONArray RESULTDATA=new JSONArray();

			Connection conn =null;
			Statement stmt =null;
			java.sql.Date sqlFromDate = null;
			java.sql.Date sqlToDate = null;
			
			if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
				sqlFromDate = cmn.changeStringtoSqlDate(fromdate);
            }
			if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
				sqlToDate = cmn.changeStringtoSqlDate(todate);
			}
			
			String sql11="",sql12="";
			if(!(sortby.equals("0") || sortby.equals("") || sortby.equals("undefined"))){
				sql12=sql12+" order by "+sortby+" ";
			}
			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sql11=sql11+" and ac1.cldocno in ("+clientid+")";
			}
			if(!(portid.equals("0") || portid.equals("") || portid.equals("undefined"))){
				sql11=sql11+" and d.portid in ("+portid+")";
			}
			if(!(vendorid.equals("0") || vendorid.equals("") || vendorid.equals("undefined"))){
				sql11=sql11+" and (ac.cldocno in ("+vendorid+") and ac.dtype='VND') ";
			}
			if(sqlFromDate!=null){
				if(datefilter.equalsIgnoreCase("invdate")){
					sql11=sql11+" and m.date>='"+sqlFromDate+"'";
				} else {
					sql11=sql11+" and fm.date>='"+sqlFromDate+"'";
				}
			}
			if(sqlToDate!=null){
				if(datefilter.equalsIgnoreCase("invdate")){
					sql11=sql11+" and m.date<='"+sqlToDate+"'";
				} else {
					sql11=sql11+" and fm.date<='"+sqlToDate+"'";
				}
			}
			
		try {
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();

			if(id>0){ 
	
				String sql="select fm.doc_no DELNO,m.voc_no INVNO,fd.delnoteno DNO,m.date INVDATE,fm.date FUELDATE,"
						+ "coalesce(ac1.RefName,'') CLIENT,coalesce(ac.RefName,'') VENDOR,p.port PORT,d.sprice SALES,"
						+ "d.pprice PURCHASE,d.usgqty QTY,d.amountusd 'SELLING VALUE',d.amountusdp 'PURCHASE VALUE',convert(coalesce(d.sprice-d.pprice,''),"
						+ "char(100)) 'USC/USG',convert(coalesce(d.amountusd-d.amountusdp,''),char(100)) TOTAL,"
						+ "convert(coalesce(((d.amountusd-d.amountusdp)/d.amountusd)*100,''),char(100)) PERC from my_port p "
						+ "left join av_invd d on d.portid=p.doc_no left join av_invm m on d.rdocno=m.doc_no "
						+ "left join av_fuelm fm on d.rdocno=fm.doc_no left join av_fueld fd on fd.rdocno=fm.doc_no "
						+ "left join my_acbook ac1 on m.client_id=ac1.cldocno left join my_acbook ac on m.vndacno=ac.acno "
						+ "where m.status=3 and fm.status=3 "+sql11+" "+sql12+"";
				//System.out.println("==============sql========="+sql);
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
    
	public JSONArray vendorsearch(HttpSession session) throws SQLException{

		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select cldocno,coalesce(RefName,'') vendor from my_acbook where dtype='VND' and status=3";

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





