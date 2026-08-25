package com.dashboard.projectexecution.procurementfollowup;
 
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

public class ClsProcurementFollowupDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cmn=new ClsCommon();
	public   JSONArray accountsDetailsFrom(String date,String accountno, String accountname,String currency,String chk) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
	  
     //   JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        
        
        SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy");
		String dt=sdf.format(new java.util.Date());
		java.sql.Date sqlDate= cmn.changeStringtoSqlDate(dt);
      String sqltest="";
                    /* if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
                     {
                      sqlDate = cmn.changeStringtoSqlDate(date);
                     }*/
                     
                     if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
                         sqltest=sqltest+" and t.account like '%"+accountno+"%'";
                     }
                     if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
                      sqltest=sqltest+" and t.description like '%"+accountname+"%'";
                     }
                     if(!(currency.equalsIgnoreCase("0")) && !(currency.equalsIgnoreCase(""))){
                       sqltest=sqltest+" and c.code like '%"+currency+"%'";
                  }
  try {
     conn = ClsConnection.getMyConnection();
     if(chk.equalsIgnoreCase("1"))
     {
    Statement stmtCPV = conn.createStatement ();
          /*   String sql="select t.doc_no,t.account,t.description,c.code curr from my_head t,"
               + "(select curId from my_brch where doc_no=  '"+branch+"') h,my_curr c,(select (@i:=0)) a where t.m_s=0 and t.atype='GL' "
               + "and c.doc_no=if(t.lApply,h.curId,t.curId) and t.cmpid in(0,'"+company+"') and t.brhid in(0,'"+branch+"') ";*/
   
    String  sql= "select t.doc_no,t.account,t.description,t.curid,c.code currency,a.cldocno,c.type,round(cb.rate,2) rate,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_head t inner join my_acbook a on t.cldocno=a.cldocno and "
            + "a.dtype='VND' and t.atype='AP' left join my_curr c on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
            + "from my_curbook cr where  coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where a.active=1 and t.m_s=0"+sqltest;
             
  // System.out.println("sql===="+sql);
    
            /* String sql=" select (@i:=@i+1) recno,t.doc_no,t.account,t.description,t.curid,c.code currency,c.c_rate rate,a1.cldocno,if(a1.per_mob=0,a1.per_tel,a1.per_mob) mobile from my_head t,my_acbook a1, "
            	        + "my_curr c,(select curId from my_brch where doc_no= '"+branch+"') h, (select (@i:=0)) a where  a1.active=1 and t.m_s=0 and c.doc_no=t.curId "
            	        + "and t.cldocno=a1.cldocno and a1.dtype='VND' and t.atype='AP' and c.doc_no=if(a1.brhId=0 and a1.curId=0,h.curId,if(a1.curId=0,h.curId,a1.curid)) and "
            	        + "a1.cmpid in(0,'"+company+"') and a1.brhid in(0,'"+branch+"')";*/
             
             
          //  System.out.println("==============="+sql); 
    ResultSet resultSet = stmtCPV.executeQuery(sql);
    RESULTDATA=cmn.convertToJSON(resultSet);
    
    stmtCPV.close();
     }
    conn.close();
  }
  catch(Exception e){
   e.printStackTrace();
   conn.close();
  }
        return RESULTDATA;
    }

	
	
	
	public  JSONArray loadGridData(String barchval,String fromdate,String todate) throws SQLException {

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
					if((!(sqlfromdate==null))&&(!(sqltodate==null))){
						sqltest+=" and pq.date between '"+sqlfromdate+"' and '"+sqltodate+"' ";
					}
			
				
			if(barchval.equalsIgnoreCase("a")||barchval.equalsIgnoreCase("0"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest+=" and pq.brhid="+barchval;
			}
		
			String sqldata="select pq.tr_no,pq.doc_no,pq.date,coalesce(ac.refname,'') client,pq.brhid,pq.userid,'VIEW' view,"
					+ "round(pq.material,2) material,round(pq.labour,2) labour,round(pq.machine,2) machine,round(pq.nettotal,2) nettotal,"
					+ "me.menu_name as menuname,me.func path,pq.dtype,ac.doc_no as cldocno,pq.reviseno,pq.ref_type,"
					+ "CONVERT(coalesce(pq.refdocno,''),CHAR(100)) as refdocno,pq.reftrno,trim(ac.address) address,"
					+ "CAST(if(Pq.ref_type='DIR','DIR',concat(Pq.ref_type,'-',Pq.refdocno)) AS CHAR) refdet,"
					+ "sq.doc_no qotno,cm.doc_no contrno,CM.DTYPE contrtype,cm.tr_no contracttrno from cm_srvcontrm cm "
					+ "inner join cm_srvqotm sq on sq.tr_no=cm.reftrno and sq.status=3 "
					+ "inner join gl_enqm eq on eq.doc_no=sq.refdocno and eq.status=3 inner join cm_prjestm Pq on Eq.doc_no=pq.refdocno and pq.status=3 "
					+ "left join my_acbook ac on ac.cldocno=pq.cldocno and ac.dtype='CRM' left join my_menu me on me.doc_type=pq.dtype "
					+ " where  pq.cstatus=1 AND pq.status=3 "+sqltest+" group by pq.tr_no ";
		
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
	

	
public   JSONArray lastpurchaseSearch(HttpSession session,String psrno) throws SQLException {

	JSONArray RESULTDATA=new JSONArray();

	Connection conn = null;

	try {
		conn = ClsConnection.getMyConnection();
		Statement stmt  = conn.createStatement ();  

		
		String pySql=("select  m.date,h.description,h.account,d.qty,d.amount unitprice,d.nettotal/d.qty netunitprice from my_srvm m "
    	+" left join my_head h on h.doc_no=m.acno left join my_srvd d on d.rdocno=m.doc_no where m.status<>7 and d.psrno='"+psrno+"' "
    			+ " and m.brhid='"+session.getAttribute("BRANCHID")+"' order by  m.date desc limit 5  ");
		//System.out.println("======pySql======="+pySql);
		ResultSet resultSet = stmt.executeQuery (pySql);
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

	
	public JSONArray materialGridLoad(HttpSession session,String trno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "",sqltest="";

			
			/*sql="select d.rowno,d.tr_no,m.psrno,m.psrno pid,m.psrno prodoc,at.mspecno specid,prj.brhid,coalesce(prd.locid,0) locid,m.part_no productid,m.productname,d.qty qty,d.costprice amount,d.total total,d.profitper margin,d.nettotal netotal,d.description desc1,"
					+ "u.unit unit,m.munit as unitdocno,jobtype as activity,mp.tr_no activityid,coalesce(prd.stkqty,0) stkqty,"
					+ "round(coalesce((d.qty-d.outqty),0),2) remqty,round(coalesce(if(prd.stkqty>(d.qty-d.outqty),(d.qty-d.outqty),prd.stkqty),0),2) resqty,"
					+ "round(coalesce((d.qty-d.outqty)-if(prd.stkqty>(d.qty-d.outqty),(d.qty-d.outqty),prd.stkqty),0),2) purqty,bd.brandname,"
					+ "d.site,d.sertypeid stypeid,grp.groupname sertype,round(coalesce(od.qty,0),2) purorder from gl_estconfirm d left join cm_prjestm prj on prj.tr_no=d.tr_no "
					+ "left join cm_prjmaster mp  on(mp.tr_no=d.activityid) left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no) "
					+ " left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) "
					+ "left join (select psrno,brhid,locid,sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty from my_prddin group by psrno,brhid ) prd on prd.psrno=d.psrno and prd.brhid=prj.brhid "
					+ "left join my_unitm u on m.munit=u.doc_no left join my_groupvals grp on grp.doc_no=d.sertypeid and grp.grptype='service'"
					+ " left join my_ordm om on d.costdocno=om.costcode left join my_ordd od on om.doc_no=od.rdocno and d.psrno=od.psrno "
					+ "where 1=1 and d.tr_no="+trno+" group by d.rowno";*/

			sql="select d.rowno,d.tr_no,m.psrno,m.psrno pid,m.psrno prodoc,at.mspecno specid,prj.brhid,coalesce(prd.locid,0) locid,m.part_no productid,m.productname,d.qty qty,d.costprice amount,d.total total,d.profitper margin,d.nettotal netotal,d.description desc1,"
					+ "u.unit unit,m.munit as unitdocno,jobtype as activity,mp.tr_no activityid,coalesce(prd.stkqty,0) stkqty,"
					+ "round(coalesce((d.resqty),0),2) resqty,round(coalesce((d.purqty),0),2) purqty,round(coalesce((d.purorder),0),2) purorder,"
					+ "round(coalesce((d.qty-d.resqty-d.purqty-d.purorder),0),2) remqty,bd.brandname,round(coalesce((d.qty-d.resqty-d.purqty-d.purorder),0),2) oldbalqty," 
					+ "d.site,d.sertypeid stypeid,grp.groupname sertype from gl_estconfirm d left join cm_prjestm prj on prj.tr_no=d.tr_no "
					+ "left join cm_prjmaster mp  on(mp.tr_no=d.activityid) left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no) "
					+ " left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) "
					+ "left join (select psrno,brhid,locid,sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty from my_prddin group by psrno,brhid ) prd on prd.psrno=d.psrno and prd.brhid=prj.brhid "
					+ "left join my_unitm u on m.munit=u.doc_no left join my_groupvals grp on grp.doc_no=d.sertypeid and grp.grptype='service'"
					+ " left join my_ordm om on d.costdocno=om.costcode left join my_ordd od on om.doc_no=od.rdocno and d.psrno=od.psrno "
					+ "where 1=1 and d.tr_no="+trno+" group by d.rowno";
			

			System.out.println("===materialGridLoad=procfolosub==="+sql);

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

	public JSONArray serviceSearch(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select groupname stype,codeno,doc_no docno from my_groupvals where grptype='service' and status=3";



			//			System.out.println("===sql===="+sql);

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
	public   JSONArray searchProduct(HttpSession session,String prodsearchtype,String rdoc,String reftype,String clientid,String date) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 
			String sql="";
			int method=0;
			java.sql.Date estdate=null;
String sqltest="";
/*System.out.println(clientid+"=="+date);
			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sqltest=" and x.cldocno in ("+clientid+")";
			}
		*/	

			if(!(date.equals("0") || date.equals("") || date.equals("undefined"))){
				estdate=cmn.changeStringtoSqlDate(date);
				
			}
			
			
           String brcid=session.getAttribute("BRANCHID").toString();
			
			sql="select at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno, "
					+ " round(case when '"+estdate+"' BETWEEN cfr.frmdate and cfr.todate then cfr.ofrprice else m.fixingprice end,2) as amount,"
					+ "brd.brandname,m.brandid from my_main m left join my_unitm u on m.munit=u.doc_no "
					+ "left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) left join my_brand brd on brd.doc_no=m.brandid "
					+ "left join my_clientoffer cfr on cfr.psrno=m.psrno and cfr.cldocno="+clientid+" and '"+estdate+"' BETWEEN cfr.frmdate and cfr.todate "
					+ "where m.status=3 and if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"'  group by m.psrno  order by m.psrno ";

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