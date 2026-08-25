package com.dashboard.projectexecution.estimationpricerequest;

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

public class estimationpricerequestDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cm=new ClsCommon();
	public  JSONArray loadGridData(String fromdate,String todate) throws SQLException {

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
	     	
				
		String sqldata="select est.doc_no,CAST(if(est.ref_type='DIR','DIR',concat(est.ref_type,'-',est.refdocno)) AS CHAR) refdet,ac.refname client,d.tr_no,m.psrno,m.psrno pid,m.psrno prodoc,"
				+ "at.mspecno specid,prd.locid,m.part_no productid,m.productname,round(d.qty,2) qty, "
				+ "u.unit unit,m.munit as unitdocno,bd.brandname,mp.brhid,m.brandid,m.part_no productid,m.productname from cm_estmprdd d  left join cm_prjestm est  on(est.tr_no=d.tr_no) "
				+ "left join my_acbook ac on ac.cldocno=est.cldocno and ac.dtype='crm' "
				+ "left join cm_prjmaster mp  on(mp.tr_no=d.activityid) left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no) "
				+ " left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no)"
				+ " left join (select psrno,brhid,locid,sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty from my_prddin group by psrno,brhid ) prd "
				+ "on prd.psrno=d.psrno and prd.brhid=mp.brhid left join my_unitm u on m.munit=u.doc_no where est.date between '"+sqlfromdate+"' and '"+sqltodate+"' and d.costprice=0 and d.psrno>0";
		
		System.out.println("estprice===="+sqldata);
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
	     	
				
		String sqldata="select cm.doc_no 'Doc No',cm.dtype 'Doc Type',ac.refname 'Client',coalesce(mc.cperson,' ') 'Contact Person',ac.per_mob 'Mobile No',cm.validfrom 'Start Date',"
				+ "cm.validupto 'End Date',round(cm.contractval,2) 'Contract Value', cs.site 'Site',round(cm.legalchrg,2) 'Legal Fees' from cm_srvcontrm cm "
				+ "left join my_crmcontact mc on cm.cpersonid=mc.row_no left join my_acbook ac on cm.cldocno=ac.cldocno left join cm_srvcsited cs on cs.tr_no=cm.tr_no "
				+ " where cm.date between  and cm.status!=7 ";
		
		//System.out.println(sqldata);
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