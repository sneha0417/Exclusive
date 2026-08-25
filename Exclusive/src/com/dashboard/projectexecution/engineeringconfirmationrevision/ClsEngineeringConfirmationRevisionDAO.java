package com.dashboard.projectexecution.engineeringconfirmationrevision;
 
import java.sql.CallableStatement;
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

public class ClsEngineeringConfirmationRevisionDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cmn=new ClsCommon();
	Statement stmt =null;
	String sql="";
	int val=0;
	public int insert(String trdocno,String brchid,String userid,ArrayList<String> matlist,String contractno) throws SQLException{

		Connection conn=null;
		
		int docNo=Integer.parseInt(trdocno);
String sqlrevsel="";
int maxrev;
conn = ClsConnection.getMyConnection();
		try{
			
			Statement stmt = conn.createStatement();
			 conn.setAutoCommit(false);
			if(docNo>0){
				maxrev=0;
				sqlrevsel="select coalesce(max(revno),-1) maxrev from gl_estconfirmrev where tr_no="+docNo+"";
				ResultSet rstrno = stmt.executeQuery(sqlrevsel);
				while(rstrno.next()) {
					
					maxrev=rstrno.getInt("maxrev");
				}
				
				System.out.println("maxrev==="+maxrev);
				if(maxrev==(-1))
				{
					maxrev=0;
				}
				else{
					maxrev=maxrev+1;
				}
				String sqlins="insert into gl_estconfirmrev(tr_no,  ROWNO, SR_NO, psrno, prdId, qty, fr, UNITID, SpecNo, prcId, BQty, idleHrs,"
						+ "lblHrs, rateHr, lblQty, durHrs, costPrice, Totalcost, stockId, total, profitPer, NetTotal, sellprice, Description,"
						+ " activityid,resqty, purqty,outqty, outtrno, site, sertypeid, sitesrno, marginper, costdocno, purorder, issueqty,revno)"
						+ "(select tr_no,  ROWNO, SR_NO, psrno, prdId, qty, fr, UNITID, SpecNo, prcId, BQty, idleHrs,lblHrs, rateHr, lblQty, durHrs,"
						+ " costPrice, Totalcost, stockId, total, profitPer, NetTotal, sellprice, Description, activityid,resqty, purqty, outqty,"
						+ " outtrno, site, sertypeid, sitesrno, marginper, costdocno, purorder, issueqty,"+maxrev+" from gl_estconfirm where tr_no="+docNo+");";
				
				int resultrev = stmt.executeUpdate (sqlins);
				if(resultrev<=0)
				{
					conn.close();
					return 0;
				}
				
				String delrowno="";
				for(int i=0;i< matlist.size();i++){


					String[] arrayDetdel=((String) matlist.get(i)).split("::");

					//					System.out.println("====material activity=="+arrayDetdel[9]);

					if((!(arrayDetdel[11].trim().equalsIgnoreCase("undefined")|| arrayDetdel[11].trim().equalsIgnoreCase("NaN")||arrayDetdel[11].trim().equalsIgnoreCase("")|| arrayDetdel[11].isEmpty()))
							|| (!(arrayDetdel[0].trim().equalsIgnoreCase("undefined")|| arrayDetdel[0].trim().equalsIgnoreCase("NaN")||arrayDetdel[0].trim().equalsIgnoreCase("")|| arrayDetdel[0].isEmpty()))
							|| (!(arrayDetdel[2].trim().equalsIgnoreCase("undefined")|| arrayDetdel[2].trim().equalsIgnoreCase("NaN")||arrayDetdel[2].trim().equalsIgnoreCase("")|| arrayDetdel[2].isEmpty())))
					{
					//rowno
						if(!(arrayDetdel[14].trim().equalsIgnoreCase("undefined")|| arrayDetdel[14].trim().equalsIgnoreCase("NaN")||arrayDetdel[14].trim().equalsIgnoreCase("")|| arrayDetdel[14].isEmpty()))
						{
							delrowno=delrowno+arrayDetdel[14].trim()+",";
						}
					}
					
				}
				delrowno = delrowno.trim().substring(0, delrowno.length() - 1);
				
				System.out.println("delrowno==="+delrowno);
				
				String delpyt="delete from gl_estconfirm where tr_no="+docNo+" and rowno not in("+delrowno+")";
				System.out.println("delpyt==="+delpyt);
				int delval=stmt.executeUpdate (delpyt);
				
								
				String sql="";	
				System.out.println("matlist.size()==="+matlist.size());	
				for(int i=0;i< matlist.size();i++){

					System.out.println("+iii==="+i);	
					String[] arrayDet=((String) matlist.get(i)).split("::");

					//					System.out.println("====material activity=="+arrayDet[9]);

					if((!(arrayDet[11].trim().equalsIgnoreCase("undefined")|| arrayDet[11].trim().equalsIgnoreCase("NaN")||arrayDet[11].trim().equalsIgnoreCase("")|| arrayDet[11].isEmpty()))
							|| (!(arrayDet[0].trim().equalsIgnoreCase("undefined")|| arrayDet[0].trim().equalsIgnoreCase("NaN")||arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()))
							|| (!(arrayDet[2].trim().equalsIgnoreCase("undefined")|| arrayDet[2].trim().equalsIgnoreCase("NaN")||arrayDet[2].trim().equalsIgnoreCase("")|| arrayDet[2].isEmpty())))
					{

						System.out.println("arrayDet[13].trim()==="+arrayDet[13].trim());			
						if(!(arrayDet[14].trim().equalsIgnoreCase("undefined")|| arrayDet[14].trim().equalsIgnoreCase("NaN")||arrayDet[14].trim().equalsIgnoreCase("")|| arrayDet[14].isEmpty()))
						{
							sql="update gl_estconfirm set "
									+ "SR_NO="+(i+1)+","
									+ "Description='"+(arrayDet[0].trim().equalsIgnoreCase("undefined") || arrayDet[0].trim().equalsIgnoreCase("NaN")|| arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()?"":arrayDet[0].trim())+"' ,"
									+ " psrno='"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?0:arrayDet[1].trim())+"',"
									+ " prdId='"+(arrayDet[2].trim().equalsIgnoreCase("undefined") || arrayDet[2].trim().equalsIgnoreCase("NaN")|| arrayDet[2].trim().equalsIgnoreCase("")|| arrayDet[2].isEmpty()?0:arrayDet[2].trim())+"',"
									+ "UNITID='"+(arrayDet[3].trim().equalsIgnoreCase("undefined") || arrayDet[3].trim().equalsIgnoreCase("NaN")|| arrayDet[3].trim().equalsIgnoreCase("")|| arrayDet[3].isEmpty()?0:arrayDet[3].trim())+"',"
									+ " qty=qty+"+(arrayDet[13].trim().equalsIgnoreCase("undefined") || arrayDet[13].trim().equalsIgnoreCase("NaN")|| arrayDet[13].trim().equalsIgnoreCase("")|| arrayDet[13].isEmpty()?0:arrayDet[13].trim())+","
									+ " costPrice='"+(arrayDet[5].trim().equalsIgnoreCase("undefined") || arrayDet[5].trim().equalsIgnoreCase("NaN")|| arrayDet[5].trim().equalsIgnoreCase("")|| arrayDet[5].isEmpty()?0:arrayDet[5].trim())+"',"
									+ "  total='"+(arrayDet[6].trim().equalsIgnoreCase("undefined") || arrayDet[6].trim().equalsIgnoreCase("NaN")|| arrayDet[6].trim().equalsIgnoreCase("")|| arrayDet[6].isEmpty()?0:arrayDet[6].trim())+"',"
									+ " profitPer='"+(arrayDet[7].trim().equalsIgnoreCase("undefined") || arrayDet[7].trim().equalsIgnoreCase("NaN")|| arrayDet[7].trim().equalsIgnoreCase("")|| arrayDet[7].isEmpty()?0:arrayDet[7].trim())+"',"
									+ "activityid='"+(arrayDet[9].trim().equalsIgnoreCase("undefined") || arrayDet[9].trim().equalsIgnoreCase("NaN")|| arrayDet[9].trim().equalsIgnoreCase("")|| arrayDet[9].isEmpty()?0:arrayDet[9].trim())+"',"
									+ " NetTotal='"+(arrayDet[8].trim().equalsIgnoreCase("undefined") || arrayDet[8].trim().equalsIgnoreCase("NaN")|| arrayDet[8].trim().equalsIgnoreCase("")|| arrayDet[8].isEmpty()?0:arrayDet[8].trim())+"',"
									+ "site='"+(arrayDet[10].trim().equalsIgnoreCase("undefined") || arrayDet[10].trim().equalsIgnoreCase("NaN")|| arrayDet[10].trim().equalsIgnoreCase("")|| arrayDet[10].isEmpty()?"":arrayDet[10].trim())+"',"
									+ "sertypeid='"+(arrayDet[11].trim().equalsIgnoreCase("undefined") || arrayDet[11].trim().equalsIgnoreCase("NaN")|| arrayDet[11].trim().equalsIgnoreCase("")|| arrayDet[11].isEmpty()?0:arrayDet[11].trim())+"',"
									+ "sitesrno='"+(arrayDet[12].trim().equalsIgnoreCase("undefined") || arrayDet[12].trim().equalsIgnoreCase("NaN")|| arrayDet[12].trim().equalsIgnoreCase("")|| arrayDet[12].isEmpty()?0:arrayDet[12].trim())+"',"
									+ "newqty='"+(arrayDet[13].trim().equalsIgnoreCase("undefined") || arrayDet[13].trim().equalsIgnoreCase("NaN")|| arrayDet[13].trim().equalsIgnoreCase("")|| arrayDet[13].isEmpty()?0:arrayDet[13].trim())+"',"
									+ "costdocno="+contractno+" where tr_no="+docNo+" and rowno='"+arrayDet[14].trim()+"' ";
						}
						else{
						sql="INSERT INTO gl_estconfirm(tr_no, SR_NO,Description, psrno, prdId,UNITID, qty, costPrice,  total, profitPer,activityid, NetTotal,site,sertypeid,sitesrno,newqty,costdocno) values "
								+ " ("+docNo+","
								+ " "+(i+1)+","
								+ "'"+(arrayDet[0].trim().equalsIgnoreCase("undefined") || arrayDet[0].trim().equalsIgnoreCase("NaN")|| arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()?"":arrayDet[0].trim())+"',"
								+ "'"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?0:arrayDet[1].trim())+"',"
								+ "'"+(arrayDet[2].trim().equalsIgnoreCase("undefined") || arrayDet[2].trim().equalsIgnoreCase("NaN")|| arrayDet[2].trim().equalsIgnoreCase("")|| arrayDet[2].isEmpty()?0:arrayDet[2].trim())+"',"
								+ "'"+(arrayDet[3].trim().equalsIgnoreCase("undefined") || arrayDet[3].trim().equalsIgnoreCase("NaN")|| arrayDet[3].trim().equalsIgnoreCase("")|| arrayDet[3].isEmpty()?0:arrayDet[3].trim())+"',"
								+ "'"+(arrayDet[4].trim().equalsIgnoreCase("undefined") || arrayDet[4].trim().equalsIgnoreCase("NaN")|| arrayDet[4].trim().equalsIgnoreCase("")|| arrayDet[4].isEmpty()?0:arrayDet[4].trim())+"',"
								+ "'"+(arrayDet[5].trim().equalsIgnoreCase("undefined") || arrayDet[5].trim().equalsIgnoreCase("NaN")|| arrayDet[5].trim().equalsIgnoreCase("")|| arrayDet[5].isEmpty()?0:arrayDet[5].trim())+"',"
								+ "'"+(arrayDet[6].trim().equalsIgnoreCase("undefined") || arrayDet[6].trim().equalsIgnoreCase("NaN")|| arrayDet[6].trim().equalsIgnoreCase("")|| arrayDet[6].isEmpty()?0:arrayDet[6].trim())+"',"
								+ "'"+(arrayDet[7].trim().equalsIgnoreCase("undefined") || arrayDet[7].trim().equalsIgnoreCase("NaN")|| arrayDet[7].trim().equalsIgnoreCase("")|| arrayDet[7].isEmpty()?0:arrayDet[7].trim())+"',"
								+ "'"+(arrayDet[9].trim().equalsIgnoreCase("undefined") || arrayDet[9].trim().equalsIgnoreCase("NaN")|| arrayDet[9].trim().equalsIgnoreCase("")|| arrayDet[9].isEmpty()?0:arrayDet[9].trim())+"',"
								+ "'"+(arrayDet[8].trim().equalsIgnoreCase("undefined") || arrayDet[8].trim().equalsIgnoreCase("NaN")|| arrayDet[8].trim().equalsIgnoreCase("")|| arrayDet[8].isEmpty()?0:arrayDet[8].trim())+"',"
								+ "'"+(arrayDet[10].trim().equalsIgnoreCase("undefined") || arrayDet[10].trim().equalsIgnoreCase("NaN")|| arrayDet[10].trim().equalsIgnoreCase("")|| arrayDet[10].isEmpty()?"":arrayDet[10].trim())+"',"
								+ "'"+(arrayDet[11].trim().equalsIgnoreCase("undefined") || arrayDet[11].trim().equalsIgnoreCase("NaN")|| arrayDet[11].trim().equalsIgnoreCase("")|| arrayDet[11].isEmpty()?0:arrayDet[11].trim())+"',"
								+ "'"+(arrayDet[12].trim().equalsIgnoreCase("undefined") || arrayDet[12].trim().equalsIgnoreCase("NaN")|| arrayDet[12].trim().equalsIgnoreCase("")|| arrayDet[12].isEmpty()?0:arrayDet[12].trim())+"',"
								+ "'"+(arrayDet[13].trim().equalsIgnoreCase("undefined") || arrayDet[13].trim().equalsIgnoreCase("NaN")|| arrayDet[13].trim().equalsIgnoreCase("")|| arrayDet[13].isEmpty()?0:arrayDet[13].trim())+"',"
								+ " "+contractno+")";

						}
										System.out.println("==matlisttttttt==="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}
						

					}

				}

			

				conn.commit();
			}


		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}



		return docNo;

	}
	
	
	
	
	
	 public JSONArray sitegridSearch(String reftrno,int loadid,String reftype) throws SQLException{


			JSONArray RESULTDATA1=new JSONArray();

			Connection conn=null;
			try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement();

				String sql = "";
	if(reftype.equalsIgnoreCase("ENQ"))
	{
				 if(loadid==4)
				{
					sql="select site,sr_no sitesrno from cm_srvcsited where tr_no='"+reftrno+"'";
				}	
	}
	
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
			
			String sqldata="select pq.tr_no,pq.doc_no,DATE_FORMAT(pq.date,'%d.%m.%Y') date,coalesce(ac.refname,'') client,pq.brhid,pq.userid,'VIEW' view,"
					+ "round(pq.material,2) material,round(pq.labour,2) labour,round(pq.machine,2) machine,round(pq.nettotal,2) nettotal,"
					+ "me.menu_name as menuname,me.func path,pq.dtype,ac.doc_no as cldocno,pq.reviseno,pq.ref_type,"
					+ "CONVERT(coalesce(pq.refdocno,''),CHAR(100)) as refdocno,pq.reftrno,trim(ac.address) address,"
					+ "CAST(if(Pq.ref_type='DIR','DIR',concat(Pq.ref_type,'-',Pq.refdocno)) AS CHAR) refdet,"
					+ "if(ecm.tr_no>0,'1','0') ecmno,cm.doc_no contrno,sq.doc_no qotno,coalesce(eq.doc_no) enqmtrno,coalesce(eq.surtrno) surtrno,cm.tr_no contracttrno  from cm_srvcontrm cm "
					+ "inner join cm_srvqotm sq on sq.tr_no=cm.reftrno and sq.status=3 "
					+ "inner join gl_enqm eq on eq.doc_no=sq.refdocno and eq.status=3 inner join cm_prjestm Pq on Eq.doc_no=pq.refdocno and pq.status=3 "
					+ "left join my_acbook ac on ac.cldocno=pq.cldocno and ac.dtype='CRM' left join my_menu me on me.doc_type=pq.dtype "
					+ " left join gl_estconfirm ecm on ecm.tr_no=pq.tr_no"
					+ " where  cm.ref_type='SQOT' and cm.dtype='SJOB' and sq.ref_type='ENQ' and pq.ref_type='ENQ' and cm.status=3 and pq.cstatus=1 "+sqltest+" group by pq.tr_no ";
		
			System.out.println("=enqconfirm==="+sqldata);
					
		
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
	

	
	
	public  JSONArray loadGridExcel(String barchval,String fromdate,String todate) throws SQLException {

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
			
			String sqldata="select @id:=@id+1 'Sl No',a.* from (select pq.doc_no 'Doc No',CAST(if(Pq.ref_type='DIR','DIR',"
					+ "concat(Pq.ref_type,'-',Pq.refdocno)) AS CHAR) 'Ref Details',DATE_FORMAT(pq.date,'%d.%m.%Y') 'Date',"
					+ "sq.doc_no 'Quotation No.',cm.doc_no 'Contract No.',coalesce(ac.refname,'') 'Client Name', "
					+ "round(pq.nettotal,2) 'Net Total' from cm_srvcontrm cm "
					+ "inner join cm_srvqotm sq on sq.tr_no=cm.reftrno and sq.status=3 "
					+ "inner join gl_enqm eq on eq.doc_no=sq.refdocno and eq.status=3 "
					+ "inner join cm_prjestm Pq on Eq.doc_no=pq.refdocno and pq.status=3 "
					+ "left join my_acbook ac on ac.cldocno=pq.cldocno and ac.dtype='CRM'"
					+ " left join my_menu me on me.doc_type=pq.dtype "
					+ "left join gl_estconfirm ecm on ecm.tr_no=pq.tr_no "
					+ "where  cm.ref_type='SQOT' and cm.dtype='SJOB' and sq.ref_type='ENQ' and pq.ref_type='ENQ' "
					+ "and cm.status=3 and pq.cstatus=1 "+sqltest+" group by pq.tr_no) a,(select @id:=0) r";
		
			System.out.println("=enqconfirm Excel==="+sqldata);
					
		
				resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cmn.convertToEXCEL(resultSet);
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
	public JSONArray materialGridReLoad(HttpSession session,String trno,String ecmno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "",sqltest="";

if(ecmno.equalsIgnoreCase("1"))
{
	sql="select d.rowno,d.tr_no,m.psrno,m.psrno pid,m.psrno prodoc,at.mspecno specid,prj.brhid,prd.locid,m.part_no productid,m.productname,d.qty qty,d.costprice amount,d.total total,d.profitper margin,d.nettotal,d.description desc1,"
			+ "u.unit unit,m.munit as unitdocno,jobtype as activity,mp.tr_no activityid,prd.stkqty,"
			+ "if(prd.stkqty>d.qty,d.qty,prd.stkqty) resqty,d.qty-if(prd.stkqty>d.qty,d.qty,prd.stkqty) purqty,bd.brandname,d.site,d.sertypeid stypeid,grp.groupname sertype,coalesce(d.sitesrno,0) sitesrno,"
			+ "round(coalesce((d.qty-d.resqty-d.purqty-d.purorder),0),2) balqty,round(0) as newqty,m.productname product,m.productname proname,bd.brandname brand from gl_estconfirm d  "
			+ " left join cm_prjestm prj on prj.tr_no=d.tr_no left join cm_prjmaster mp  on(mp.tr_no=d.activityid) left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no) "
			+ " left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) "
			+ "left join (select psrno,brhid,locid,sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty from my_prddin group by psrno,brhid ) prd on prd.psrno=d.psrno and prd.brhid=prj.brhid "
			+ "left join my_unitm u on m.munit=u.doc_no left join my_groupvals grp on grp.doc_no=d.sertypeid and grp.grptype='service' where 1=1  and d.tr_no='"+trno+"'";
}

			System.out.println("===engconfProductGrid Excel===="+sql);

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
	public JSONArray materialGridExcel(HttpSession session,String trno,String ecmno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "",sqltest="";

if(ecmno.equalsIgnoreCase("1"))
{
	sql="select d.site 'Site',grp.groupname 'Service Type',d.description 'Description',m.productname 'Product',bd.brandname 'Brand',"
			+ "u.unit 'Unit',d.qty 'Quantity',round(0) as 'Variant Quantity',d.costprice 'Amount' from gl_estconfirm d  "
			+ " left join cm_prjestm prj on prj.tr_no=d.tr_no left join cm_prjmaster mp  on(mp.tr_no=d.activityid) "
			+ "left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
			+ "left join my_prodattrib at on(at.mpsrno=m.doc_no) "
			+ "left join (select psrno,brhid,locid,sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty from my_prddin "
			+ "group by psrno,brhid ) prd on prd.psrno=d.psrno and prd.brhid=prj.brhid "
			+ "left join my_unitm u on m.munit=u.doc_no "
			+ "left join my_groupvals grp on grp.doc_no=d.sertypeid and grp.grptype='service' "
			+ "where 1=1  and d.tr_no='"+trno+"'";
}

			System.out.println("===engconfProductGrid Excel===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=cmn.convertToEXCEL(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}
	public   JSONArray searchProduct(HttpSession session,String prodsearchtype,String rdoc,String reftype,String clientid,String date,String prdname,String brandname,String id,String gridunit,String gridprdname) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 
			String sql="";
			int method=0;
			java.sql.Date estdate=null;
String sqltest="";
String condtn="";
/*System.out.println(clientid+"=="+date);
			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sqltest=" and x.cldocno in ("+clientid+")";
			}
		*/	

			if(!(date.equals("0") || date.equals("") || date.equals("undefined"))){
				estdate=cmn.changeStringtoSqlDate(date);
				
			}
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
			
			sql="select at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno, "
					+ " round(case when '"+estdate+"' BETWEEN cfr.frmdate and cfr.todate then cfr.ofrprice else m.fixingprice end,2) as amount,"
					+ "brd.brandname,m.brandid from my_main m left join my_unitm u on m.munit=u.doc_no "
					+ "left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) left join my_brand brd on brd.doc_no=m.brandid "
					+ "left join my_clientoffer cfr on cfr.psrno=m.psrno and cfr.cldocno="+clientid+" and '"+estdate+"' BETWEEN cfr.frmdate and cfr.todate "
					+ "where m.status=3 "+condtn+" and if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"'  group by m.psrno  order by m.psrno ";


			/*sql="select at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno "
					+ "from my_main m left join my_unitm u on m.munit=u.doc_no "
					+ "left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) "
					+ "where m.status=3 and de.brhid='"+session.getAttribute("BRANCHID").toString()+"'  group by m.psrno  order by m.psrno ";*/


//					System.out.println("----searchProduct-sql---"+sql);

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

}