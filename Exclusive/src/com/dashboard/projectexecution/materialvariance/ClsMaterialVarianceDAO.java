package com.dashboard.projectexecution.materialvariance;

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
import java.util.Enumeration;
import java.util.Properties;
import java.util.Set;
import java.util.Vector;
import java.util.concurrent.TimeUnit;

public class ClsMaterialVarianceDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cm=new ClsCommon();
	public JSONArray materialGridLoad(HttpSession session,String trno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "",sqltest="";

			/*if(!(aid.equalsIgnoreCase("undefined"))&&!(aid.equalsIgnoreCase(""))&&!(aid.equalsIgnoreCase("0"))){

				if (aid.trim().endsWith(",")) {
					aid = aid.trim().substring(0,aid.length() - 1);
				}
				sqltest=sqltest+" and d.activityid in("+aid+")";
			}*/

			sql="select d.rowno,d.tr_no,m.psrno,m.psrno pid,m.psrno prodoc,at.mspecno specid,mp.brhid,prd.locid,m.part_no productid,m.productname,d.qty qty,d.costprice amount,d.total total,d.profitper margin,d.nettotal netotal,d.description desc1,"
					+ "u.unit unit,m.munit as unitdocno,jobtype as activity,mp.tr_no activityid,round(d.outqty,2) isqty,"
					
					+ "round((d.qty-d.outqty),2) difqty,bd.brandname from cm_estmprdd d  "
					+ "left join cm_prjmaster mp  on(mp.tr_no=d.activityid) left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no) "
					+ " left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) "
					+ "left join (select psrno,brhid,locid,sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty from my_prddin group by psrno,brhid ) prd on prd.psrno=d.psrno and prd.brhid=mp.brhid "
					+ "left join my_unitm u on m.munit=u.doc_no  where 1=1 "+sqltest+" and d.tr_no="+trno+"";


			System.out.println("===materialGridLoad===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=cm.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}

	
	public JSONArray searchProject(HttpSession session,String clname,String doc) throws SQLException {


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
			sqltest=sqltest+" and ac.refname like '%"+clname+"%'";
		}
		if(!(doc.equalsIgnoreCase(""))){
			sqltest=sqltest+" and cm.doc_no="+doc+" ";
		}


		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh1 = conn.createStatement ();

			String clsql= ("select pq.tr_no trno,cm.doc_no docno,ac.refname from cm_srvcontrm cm inner join cm_srvqotm sq on sq.tr_no=cm.reftrno and sq.status=3 "
					+ "inner join gl_enqm eq on eq.doc_no=sq.refdocno and eq.status=3"
					+ " inner join cm_prjestm Pq on Eq.doc_no=pq.refdocno and pq.status=3 "
					+ "left join my_acbook ac on ac.cldocno=pq.cldocno and ac.dtype='CRM' "
					+ "where cm.ref_type='SQOT' and sq.ref_type='ENQ' and pq.ref_type='ENQ' and cm.dtype='SJOB' "
					+ "and cm.status=3 and pq.cstatus=1" +sqltest);
			//System.out.println("========"+clsql);
			ResultSet resultSet = stmtVeh1.executeQuery(clsql);

			RESULTDATA=cm.convertToJSON(resultSet);
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


}