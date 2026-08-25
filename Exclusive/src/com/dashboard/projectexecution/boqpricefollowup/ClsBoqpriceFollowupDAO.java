package com.dashboard.projectexecution.boqpricefollowup;
 
import java.sql.Connection;
import java.sql.Date;
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

public class ClsBoqpriceFollowupDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cmn=new ClsCommon();
	public  JSONArray loadGridData(String fromdate,String todate) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="";
        java.sql.Date sqlFollowUpDate = null;
        java.sql.Date sqlfromdate = null;
        java.sql.Date sqltodate = null;
       // System.out.println("barchval="+barchval+"followupdate="+followupdate+"fromdate=-"+fromdate+"todate"+todate);
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
		
					if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
						sqlfromdate = cmn.changeStringtoSqlDate(fromdate);
					}
					if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
						sqltodate = cmn.changeStringtoSqlDate(todate);
					}
					
					
					String sqldata="select est.doc_no,CAST(if(est.ref_type='DIR','DIR',concat(est.ref_type,'-',est.refdocno)) AS CHAR) refdet,ac.refname client,d.tr_no,m.psrno,m.psrno pid,m.psrno prodoc,"
							+ "at.mspecno specid,prd.locid,m.part_no productid,m.productname,round(d.qty,2) qty, "
							+ "u.unit unit,m.munit as unitdocno,bd.brandname,mp.brhid,m.brandid,m.part_no productid,"
							+ "m.productname,round(m.stdprice,2) stdprice,round(m.sellprice,2) sellprice,d.rowno from cm_estmprdd d  left join cm_prjestm est  on(est.tr_no=d.tr_no) "
							+ "left join my_acbook ac on ac.cldocno=est.cldocno and ac.dtype='crm' "
							+ "left join cm_prjmaster mp  on(mp.tr_no=d.activityid) left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no) "
							+ " left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no)"
							+ " left join (select psrno,brhid,locid,sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty from my_prddin group by psrno,brhid ) prd "
							+ "on prd.psrno=d.psrno and prd.brhid=mp.brhid left join my_unitm u on m.munit=u.doc_no where est.date between '"+sqlfromdate+"' and '"+sqltodate+"' and d.costprice=0 and d.psrno>0";
					
		
			System.out.println("=PROCFOLLOWUP==="+sqldata);
					
		
				resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cmn.convertToJSON(resultSet);
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
	

	
	public  JSONArray loadSubGridData(String trdocno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();   
		 	
		
				
			String sqldata = "select m.date detdate,u.user_id user,m.fdate fdate,remarks remk from "
					+ " gl_bengc m left join  my_user u on u.doc_no=m.userid where m.rtrno="+trdocno+" and m.status=3;";
		
		//System.out.println(sqldata);
				resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cmn.convertToJSON(resultSet);
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
	
	public JSONArray BoQSubGridLoad(HttpSession session,String psrno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "",sqltest="";

			
			sql="select rq.voc_no,rq.date,ac.refname,m.part_no productid,m.productname,bd.brandname,u.unit,pd.qty,round(pd.amount,2) amount,pd.total,"
				+ "pd.disper discper,pd.discount,round(pd.nettotal,2) nettotal from my_prfqd pd left join my_prfqm rq on rq.doc_no=pd.rdocno "
				+ "left join my_main m on m.doc_no=pd.prdId left join  my_brand bd on m.brandid=bd.doc_no left join my_unitm u on pd.unitid=u.doc_no "
				+ "left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_acbook ac on ac.cldocno=rq.cldocno and ac.dtype='VND' "
				+ "where pd.psrno="+psrno+"";


			System.out.println("===BoQSubGridLoad===="+sql);

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