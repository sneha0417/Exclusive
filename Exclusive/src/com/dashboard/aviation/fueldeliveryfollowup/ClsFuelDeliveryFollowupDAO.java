package com.dashboard.aviation.fueldeliveryfollowup;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsFuelDeliveryFollowupDAO {

	ClsConnection ClsConnection=new ClsConnection();
    ClsCommon cmn=new ClsCommon();
	
    /* orderlistgrid data loading */
    public  JSONArray loadGridData(String check,String fromdate,String todate) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		   java.sql.Date sqlFromDate = null;
	        java.sql.Date sqlToDate = null;
		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		
		try {
			if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
				sqlFromDate = cmn.changeStringtoSqlDate(fromdate);
            }
			
			if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
				sqlToDate = cmn.changeStringtoSqlDate(todate);
			}
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			
			String sqldata="select m.doc_no,m.voc_no,d.row_no,coalesce(ac.RefName,'') client,coalesce(vnd.refname,'') vendor,m.date,"
					+ "coalesce(ma.productname,'') product,d.ac_type,d.acraft_no,d.fleet_no flight_no,d.operator,d.eta,d.etd,d.tzone,d.qty,"
					+ "p.port,p.desc1,u.unit from my_port p left join av_fueld d on d.portid=p.doc_no left join my_unitm u"
					+ " on u.doc_no=d.unit left join av_fuelm m on d.rdocno=m.doc_no left join my_main ma on ma.psrno=d.psrno "
					+ "left join my_acbook ac on m.cldocno=ac.cldocno and ac.dtype='CRM' left join my_acbook vnd on m.vndid=vnd.cldocno "
					+ "and vnd.dtype='VND' where m.status=3 and m.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and d.cancelstatus=0 and d.delstat=0";
			
			resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cmn.convertToJSON(resultSet);
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
    /* excel data loading */
    
    public  JSONArray excelData(String check,String fromdate,String todate) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		   java.sql.Date sqlFromDate = null;
	        java.sql.Date sqlToDate = null;
		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		
		try {
			if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
				sqlFromDate = cmn.changeStringtoSqlDate(fromdate);
            }
			
			if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
				sqlToDate = cmn.changeStringtoSqlDate(todate);
			}
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
		
			String sqldata="select m.voc_no 'VOC. NO.',coalesce(ac.RefName,'') CLIENT,coalesce(vnd.refname,'') VENDOR,DATE_FORMAT(m.date,'%d-%m-%Y') DATE,"
					+ "coalesce(ma.productname,'') PRODUCT,d.ac_type 'ACC. TYPE',d.acraft_no 'AIR CRAFT NO.',d.fleet_no 'FLIGHT NO.',coalesce(d.operator,'') OPERATOR,d.eta ETA,d.etd ETD,d.tzone 'TIME ZONE',d.qty QUANTITY,"
					+ "p.port PORT,u.unit UNIT,coalesce(p.desc1,'') DESCRIPTION from my_port p left join av_fueld d on d.portid=p.doc_no left join my_unitm u"
					+ " on u.doc_no=d.unit left join av_fuelm m on d.rdocno=m.doc_no left join my_main ma on ma.psrno=d.psrno "
					+ "left join my_acbook ac on m.cldocno=ac.cldocno and ac.dtype='CRM' left join my_acbook vnd on m.vndid=vnd.cldocno "
					+ "and vnd.dtype='VND' where m.status=3 and m.date between '"+sqlFromDate+"' and '"+sqlToDate+"' and d.cancelstatus=0 and d.delstat=0";
			
			resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cmn.convertToEXCEL(resultSet);
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





