package com.dashboard.projectexecution.procurementstatus;
 
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
import java.util.Enumeration;
import java.util.Properties;
import java.util.Set;
import java.util.Vector;
import java.util.concurrent.TimeUnit;

public class ClsProcurementStatusDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cmn=new ClsCommon();
	
	
	public JSONArray materialGridLoad(HttpSession session,String branchval,String fromdate,String todate,String clientid,String contrid,String prodid,String brandid,int check) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			Enumeration<String> Enumeration = session.getAttributeNames();
			java.sql.Date froms=null;
			if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
			{
			froms=cmn.changeStringtoSqlDate(fromdate);
			}
			java.sql.Date tos=null;
			if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
			{
			tos=cmn.changeStringtoSqlDate(todate);
			}
			
			String sql11="",sql="";

			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sql11=sql11+" and d.cldocno in ("+clientid+")";
			}
			
			
			if(!(contrid.equals("0") || contrid.equals("") || contrid.equals("undefined"))){
				sql11=sql11+" and d.costdocno in ("+contrid+")";
			}
			
			if(!(prodid.equals("0") || prodid.equals("") || prodid.equals("undefined"))){
				sql11=sql11+" and D.PSRNO in ("+prodid+")";
			}
			
			if(!(brandid.equals("0") || brandid.equals("") || brandid.equals("undefined"))){
				sql11=sql11+" and d.BRD in ("+brandid+")";
				//sql11=sql11+"";
			}
			
			

		/*	sql="SELECT CM.DOC_NO contrno,a.refname client,M.PART_NO productid, M.PRODUCTNAME,B.BRANDNAME,P.QTY  ,COALESCE(PR.QTY,0) purqty,"
					+ "COALESCE(PO.QTY,0) purorder, round((P.QTY - P.RESQTY-P.PURQTY-P.PURORDER),2) remqty,P.ISSUEQTY consissued,(P.QTY-P.ISSUEQTY) consbal,"
					+ "P.RESQTY,COALESCE(P1.STK,0) stkgen,COALESCE(res.stk,0) stkresqty,COALESCE(P1.STK,0)+COALESCE(res.stk,0) stktotal FROM GL_ESTCONFIRM P LEFT JOIN MY_MAIN M ON P.PSRNO=M.PSRNO "
					+ "LEFT JOIN MY_BRAND B ON M.BRANDID=B.DOC_NO LEFT JOIN CM_SRVCONTRM CM ON CM.TR_NO=P.TR_NO "
					+ "LEFT JOIN MY_ACBOOK A ON A.CLDOCNO=CM.CLDOCNO AND A.DTYPE='CRM' "
					+ "LEFT JOIN (SELECT GROUP_CONCAT(SITE) SITE,TR_NO FROM CM_SERVSITED GROUP BY TR_NO ) S ON S.TR_NO=CM.TR_NO "
					+ "LEFT JOIN (SELECT PSRNO,(OP_QTY-OUT_QTY-RSV_QTY-DEL_QTY) STK FROM MY_PRDDIN GROUP BY PSRNO) P1 ON P.PSRNO=P1.PSRNO "
					+ "LEFT JOIN (SELECT COSTCODE,D.PSRNO,SUM(COALESCE(QTY,0)) QTY FROM MY_REQM  M "
					+ "LEFT JOIN MY_REQD D ON M.DOC_NO=D.RDOCNO GROUP BY COSTCODE,PSRNO) PR ON P.COSTDOCNO=PR.COSTCODE AND PR.PSRNO=P.PSRNO "
					+ "LEFT JOIN (SELECT COSTCODE,D.PSRNO,SUM(COALESCE(QTY,0)) QTY FROM MY_ORDM  M "
					+ "LEFT JOIN MY_ORDD D ON M.DOC_NO=D.RDOCNO GROUP BY COSTCODE,PSRNO) PO ON P.COSTDOCNO=PO.COSTCODE AND PO.PSRNO=P.PSRNO "
					+ "LEFT JOIN (SELECT PSRNO,(RSV_QTY-issueQTY) STK FROM MY_PRDDR GROUP BY PSRNO) res ON P.PSRNO=res.PSRNO where 1=1 "+sql11+" ";
		*/


			sql = "SELECT D.*, coalesce(stkqty,0)  stkgen, coalesce(res.stk ,0) resqty, coalesce(gis.qty,0) consissued,  coalesce(d.qty,0)-coalesce(gis.qty,0) consbal, "
					+ " coalesce(req.qty,0)  'purqty' ,  coalesce(ord.qty,0)  'purorder' ,  coalesce(grn.qty,0) +coalesce(piv.qty,0)  'purchaseqty' , d.qty - coalesce(res.stk ,0) - (coalesce(req.qty,0)  + coalesce(ord.qty,0)  +  coalesce(grn.qty,0) +coalesce(piv.qty,0) ) remqty from "
					+ " (SELECT CM.DOC_NO contrno,cm.cldocno,a.refname client,M.PART_NO productid, M.PRODUCTNAME,B.BRANDNAME,sum(P.QTY) qty ,P.COSTDOCNO,P.PSRNO,b.doc_no brd  FROM "
					+ " GL_ESTCONFIRM P LEFT JOIN MY_MAIN M ON P.PSRNO=M.PSRNO LEFT JOIN MY_BRAND B ON M.BRANDID=B.DOC_NO LEFT JOIN CM_SRVCONTRM CM ON CM.TR_NO=P.COSTDOCNO LEFT JOIN MY_ACBOOK A ON A.CLDOCNO=CM.CLDOCNO AND A.DTYPE='CRM' LEFT JOIN (SELECT GROUP_CONCAT(SITE) SITE,TR_NO FROM CM_SERVSITED GROUP BY TR_NO ) S ON S.TR_NO=CM.TR_NO where p.psrno!=0 and costdocno!=0 GROUP BY P.COSTDOCNO,P.PSRNO) D left join (select psrno,brhid,locid,sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty from my_prddin group by psrno) prd  on prd.psrno=d.psrno left join (select sum(qty-out_qty) qty,psrno,costtype,costcode from my_reqm m inner join my_reqd d on m.tr_no=d.tr_no where m.status=3 and costcode!=0 and qty-out_qty!=0 group by psrno,costtype,costcode) req ON req.costtype=4 and req.costcode = d.costdocno and req.psrno=d.psrno left join (select sum(qty-out_qty) qty,psrno,costtype,costcode from my_ordm m inner join my_ordd d on m.tr_no=d.tr_no where m.status=3 and costcode!=0 and qty-out_qty!=0 group by psrno,costtype,costcode) ord ON ord.costtype=4 and ord.costcode = d.costdocno and ord.psrno=d.psrno left join (select sum(qty-out_qty) qty,psrno,costtype,costcode from my_grnm m inner join my_grnd d on m.tr_no=d.tr_no where m.status=3 and costcode!=0 and qty-out_qty!=0 group by psrno,costtype,costcode ) grn ON grn.costtype=4 and grn.costcode = d.costdocno and grn.psrno=d.psrno left join (select sum(qty-out_qty) qty,psrno,costtype,costcode from my_srvm m inner join my_srvd d on m.tr_no=d.tr_no where m.status=3 and costcode!=0 and qty-out_qty!=0 group by psrno,costtype,costcode) piv ON piv.costtype=4 and piv.costcode = d.costdocno and piv.psrno=d.psrno LEFT JOIN (SELECT PSRNO,(RSV_QTY-issueQTY) STK FROM MY_PRDDR GROUP BY PSRNO) res ON d.PSRNO=res.PSRNO  left join (select sum(qty-out_qty) qty,psrno,costtype,COSTDOCNO from my_gism m inner join my_gisd d on m.tr_no=d.tr_no where m.status=3 and COSTDOCNO!=0 and qty-out_qty!=0 group by psrno,costtype,COSTDOCNO) gis ON gis.costtype=4 and gis.COSTDOCNO = d.costdocno and gis.psrno=d.psrno where 1=1 "
					+ sql11;
			 System.out.println("===procurement status===" + sql);
			if (check > 0) {
				ResultSet resultSet1 = stmt.executeQuery(sql);
				RESULTDATA1 = cmn.convertToJSON(resultSet1);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}
	public   JSONArray searchMaster(HttpSession session,String clnames,String contno,String invtype) throws SQLException {


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

		//  System.out.println("8888888888"+clnames); 	
		String brid=session.getAttribute("BRANCHID").toString();



		java.sql.Date sqlStartDate=null;


		//enqdate.trim();
		

		String sqltest="";
		
		if(!(clnames.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.refname like '%"+clnames+"%'";
		}
		if(!(contno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.doc_no='"+contno+"'";
		}

		if(!(invtype.equalsIgnoreCase(""))){

			sqltest=sqltest+" and m.dtype='"+invtype+"'";
		}
		 

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();

			String clssql= ("select  m.doc_no contno,m.doc_no,ac.refname client,m.date,m.dtype contype,m.tr_no,m.cldocno,"
					+ "m.tr_no costid,GROUP_CONCAT(coalesce(st.site,'')) site from cm_srvcontrm m left join cm_srvcsited st on st.tr_no=m.tr_no"
					+ " left join my_acbook ac on(m.cldocno=ac.doc_no and ac.dtype='CRM') "
					+ "where m.status=3 and m.brhid="+brid+" " +sqltest+" group by m.tr_no order by m.doc_no");
			
			System.out.println("===client details====="+clssql);
			
			ResultSet resultSet = stmtenq1.executeQuery(clssql);

			RESULTDATA=cmn.convertToJSON(resultSet);
			stmtenq1.close();
			conn.close();
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		//System.out.println(RESULTDATA);
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






		//System.out.println("name"+clname);

		String sqltest="";

		if(!(clname.equalsIgnoreCase(""))){
			sqltest=sqltest+" and refname like '%"+clname+"%'";
		}
		if(!(mob.equalsIgnoreCase(""))){
			sqltest=sqltest+" and per_mob like '%"+mob+"%'";
		}


		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh1 = conn.createStatement ();

			String clsql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM'  " +sqltest);
			//System.out.println("========"+clsql);
			ResultSet resultSet = stmtVeh1.executeQuery(clsql);

			RESULTDATA=cmn.convertToJSON(resultSet);
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

	public   JSONArray searchProduct(HttpSession session,String prdname,String brandname,String id,String gridunit,String gridprdname) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 
			String sql="";
			int method=0;
			
String sqltest="";
String condtn="";

			if(!(prdname.equalsIgnoreCase(""))&&!(prdname.equalsIgnoreCase("undefined"))&&!(prdname.equalsIgnoreCase("0"))){
				condtn ="  and m.part_no like '%"+prdname+"%' ";
			}
			
			if(!(brandname.equalsIgnoreCase(""))&&!(brandname.equalsIgnoreCase("undefined"))&&!(brandname.equalsIgnoreCase("0"))){
				condtn +="  and brd.brandname like '%"+brandname+"%' ";
			}
			
			if(!(gridprdname.equalsIgnoreCase(""))&&!(gridprdname.equalsIgnoreCase("undefined"))&&!(gridprdname.equalsIgnoreCase("0"))){
				condtn +="  and m.productname like '%"+gridprdname+"%' ";
			}
			
			if(!(gridunit.equalsIgnoreCase(""))&&!(gridunit.equalsIgnoreCase("undefined"))&&!(gridunit.equalsIgnoreCase("0"))){
				condtn +="  and u.unit like '%"+gridunit+"%' ";
			}
			
           String brcid=session.getAttribute("BRANCHID").toString();
			
if(id.equalsIgnoreCase("1")){
			sql="select at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,brd.brandname,m.brandid "
					+ "from my_main m left join my_unitm u on m.munit=u.doc_no left join my_brand brd on brd.doc_no=m.brandid "
					+ "left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) "
					+ "where m.status=3 "+condtn+"  group by m.psrno  order by m.psrno ";

}
					System.out.println("----searchProduct-sql---"+sql);

			ResultSet resultSet = stmt.executeQuery (sql);
			RESULTDATA=cmn.convertToJSON(resultSet);
			stmt.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	
	public   JSONArray searchBrand(HttpSession session,String prdname,String brandname,String id,String gridunit,String gridprdname) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 
			String sql="";
			int method=0;
			
String sqltest="";
String condtn="";

			if(!(prdname.equalsIgnoreCase(""))&&!(prdname.equalsIgnoreCase("undefined"))&&!(prdname.equalsIgnoreCase("0"))){
				condtn ="  and m.part_no like '%"+prdname+"%' ";
			}
			
			if(!(brandname.equalsIgnoreCase(""))&&!(brandname.equalsIgnoreCase("undefined"))&&!(brandname.equalsIgnoreCase("0"))){
				condtn +="  and brd.brandname like '%"+brandname+"%' ";
			}
			
			if(!(gridprdname.equalsIgnoreCase(""))&&!(gridprdname.equalsIgnoreCase("undefined"))&&!(gridprdname.equalsIgnoreCase("0"))){
				condtn +="  and m.productname like '%"+gridprdname+"%' ";
			}
			
			if(!(gridunit.equalsIgnoreCase(""))&&!(gridunit.equalsIgnoreCase("undefined"))&&!(gridunit.equalsIgnoreCase("0"))){
				condtn +="  and u.unit like '%"+gridunit+"%' ";
			}
			
           String brcid=session.getAttribute("BRANCHID").toString();
			
if(id.equalsIgnoreCase("1")){
			sql="select at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,brd.brandname,m.brandid "
					+ "from my_main m left join my_unitm u on m.munit=u.doc_no left join my_brand brd on brd.doc_no=m.brandid "
					+ "left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) "
					+ "where m.status=3 "+condtn+"  group by m.psrno  order by m.psrno ";

}
					System.out.println("----searchProduct-sql---"+sql);

			ResultSet resultSet = stmt.executeQuery (sql);
			RESULTDATA=cmn.convertToJSON(resultSet);
			stmt.close();
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