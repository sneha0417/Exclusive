package com.dashboard.projectexecution.engineeringconfirmation;
 
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

public class ClsEngineeringConfirmationDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cmn=new ClsCommon();
	Statement stmt =null;
	String sql="";
	int val=0;
	public int insert(java.sql.Date date,String trdocno,String remark,String brchid,String userid,String process,ArrayList<String> matlist,String contractno){

		Connection conn=null;
		
		int docNo=Integer.parseInt(trdocno);

		try{
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			 conn.setAutoCommit(false);
			if(docNo>0){
				
				if(process.equalsIgnoreCase("3")) //Confirm
				{
				
				 sql="insert into gl_bengc( date, rtrno, fdate, remarks, bibpid, brhid, userid, status) values(now(),"+trdocno+",'"+date+"','"+remark+"',"+process+","+brchid+","+userid+",7)";
				 val= stmt.executeUpdate(sql);
				 
				 sql="update cm_prjestm set cstatus=1 where TR_NO="+trdocno+" ";
				
				 val= stmt.executeUpdate(sql);		 
				}
				 
				 sql="delete from gl_estconfirm where TR_NO="+trdocno+" ";
				 val= stmt.executeUpdate(sql);	

				for(int i=0;i< matlist.size();i++){


					String[] arrayDet=((String) matlist.get(i)).split("::");

					//					System.out.println("====material activity=="+arrayDet[9]);

					if((!(arrayDet[11].trim().equalsIgnoreCase("undefined")|| arrayDet[11].trim().equalsIgnoreCase("NaN")||arrayDet[11].trim().equalsIgnoreCase("")|| arrayDet[11].isEmpty()))
							|| (!(arrayDet[0].trim().equalsIgnoreCase("undefined")|| arrayDet[0].trim().equalsIgnoreCase("NaN")||arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()))
							|| (!(arrayDet[2].trim().equalsIgnoreCase("undefined")|| arrayDet[2].trim().equalsIgnoreCase("NaN")||arrayDet[2].trim().equalsIgnoreCase("")|| arrayDet[2].isEmpty())))
					{

						System.out.println("+iii==="+i);			

						String sql="INSERT INTO gl_estconfirm(tr_no, SR_NO,Description, psrno, prdId,UNITID, qty, costPrice,  total, profitPer,activityid, NetTotal,site,sertypeid,sitesrno,costdocno) values "
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
								+ " "+contractno+")";

						//						System.out.println("==matlist==="+sql);

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

	public  JSONArray loadGridData(String barchval,String chkfollowup,String followupdate,String fromdate,String todate,String id) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }

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
		
			if(chkfollowup.equalsIgnoreCase("1")){
						if(!(followupdate.equalsIgnoreCase("undefined")) && !(followupdate.equalsIgnoreCase("")) && !(followupdate.equalsIgnoreCase("0"))){
								sqlFollowUpDate = cmn.changeStringtoSqlDate(followupdate);
						}
						if(!(sqlFollowUpDate==null)){
							sqltest+=" and bv.fdate<='"+sqlFollowUpDate+"' ";
						}
						
			}			
			else{
					if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
						sqlfromdate = cmn.changeStringtoSqlDate(fromdate);
					}
					if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
						sqltodate = cmn.changeStringtoSqlDate(todate);
					}
					if((!(sqlfromdate==null))&&(!(sqltodate==null))){
						sqltest+=" and pq.date between '"+sqlfromdate+"' and '"+sqltodate+"' ";
					}
			}	
				
			if(barchval.equalsIgnoreCase("a")||barchval.equalsIgnoreCase("0"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest+=" and pq.brhid="+barchval;
			}
			
			String valueOfConfig="";
			String configDays = "select method from gl_config where field_nme='srvcProformaEngConfirmation'";
			ResultSet resultSetConfig = stmt.executeQuery(configDays);
			
			while(resultSetConfig.next()){
				valueOfConfig=resultSetConfig.getString("method");
			}
			
			if(valueOfConfig.equalsIgnoreCase("1")){
				sqltest+=" and cm.pstatus!=1 ";
			}
				
			/*String sqldata="select pq.tr_no,pq.doc_no,DATE_FORMAT(pq.date,'%d.%m.%Y') date,coalesce(ac.refname,'') client,bv.fdate,pq.brhid,pq.userid,'VIEW' view,"
					+ "round(pq.material,2) material,round(pq.labour,2) labour,round(pq.machine,2) machine,round(pq.nettotal,2) nettotal,"
					+ "me.menu_name as menuname,me.func path,pq.dtype,ac.doc_no as cldocno,pq.reviseno,pq.ref_type,"
					+ "CONVERT(coalesce(pq.refdocno,''),CHAR(100)) as refdocno,pq.reftrno,trim(ac.address) address,"
					+ "CAST(if(Pq.ref_type='DIR','DIR',concat(Pq.ref_type,'-',Pq.refdocno)) AS CHAR) refdet,"
					+ "if(ecm.tr_no>0,'1','0') ecmno,cm.doc_no contrno,sq.doc_no qotno,coalesce(eq.doc_no) enqmtrno,coalesce(eq.surtrno) surtrno,"
					+ "cm.tr_no contracttrno,cm.dtype doctype  from cm_srvcontrm cm "
					+ "inner join cm_srvqotm sq on sq.tr_no=cm.reftrno and sq.status=3 "
					+ "inner join gl_enqm eq on eq.doc_no=sq.refdocno and eq.status=3 inner join cm_prjestm Pq on Eq.doc_no=pq.refdocno and pq.status=3 "
					+ "left join my_acbook ac on ac.cldocno=pq.cldocno and ac.dtype='CRM' left join my_menu me on me.doc_type=pq.dtype "
					+ "left join (select max(doc_no) doc_no,rtrno from gl_bengc where status=3 group by rtrno) sub on(sub.rtrno=pq.tr_no) "
					+ "left join gl_bengc bv on sub.doc_no = bv.doc_no left join gl_estconfirm ecm on ecm.tr_no=pq.tr_no"
					+ " where  cm.ref_type='SQOT' and cm.dtype='SJOB' and sq.ref_type='ENQ' and pq.ref_type='ENQ' and cm.status=3 and pq.cstatus=0 "+sqltest+" group by pq.tr_no order by bv.fdate DESC";*/
			
			String sqldata="select pq.tr_no,pq.doc_no,DATE_FORMAT(pq.date,'%d.%m.%Y') date,coalesce(ac.refname,'') client,bv.fdate,pq.brhid,pq.userid,'VIEW' view,"
					+ "round(pq.material,2) material,round(pq.labour,2) labour,round(pq.machine,2) machine,round(pq.nettotal,2) nettotal,"
					+ "me.menu_name as menuname,me.func path,pq.dtype,ac.doc_no as cldocno,pq.reviseno,pq.ref_type,"
					+ "CONVERT(coalesce(pq.refdocno,''),CHAR(100)) as refdocno,pq.reftrno,trim(ac.address) address,"
					+ "CAST(if(Pq.ref_type='DIR','DIR',concat(Pq.ref_type,'-',Pq.refdocno)) AS CHAR) refdet,"
					+ "if(ecm.tr_no>0,'1','0') ecmno,cm.doc_no contrno,sq.doc_no qotno,coalesce(eq.doc_no) enqmtrno,coalesce(eq.surtrno) surtrno,"
					+ "cm.tr_no contracttrno,cm.dtype doctype  from cm_srvcontrm cm inner join cm_srvqotm sq on sq.tr_no=cm.reftrno and sq.status=3 "
					+ "left join gl_enqm eq on eq.doc_no=sq.refdocno and sq.ref_type='ENQ' and eq.status=3 left join cm_srvdetm sm on sm.TR_no=sq.refdocno and sQ.ref_type='SRVE' "
					+ "left join cm_prjestm Pq on ((Eq.voc_no=pq.refdocno and Eq.brhid=pq.brhid and pq.ref_type ='ENQ') or (SM.DOC_NO=pq.refdocno and pq.ref_type ='SRVE')) and pq.status=3 "
					+ "left join my_acbook ac on ac.cldocno=pq.cldocno and ac.dtype='CRM' left join my_menu me on me.doc_type=pq.dtype left join (select max(doc_no) doc_no,rtrno from gl_bengc "
					+ "where status=3 group by rtrno) sub on(sub.rtrno=pq.tr_no) left join gl_bengc bv on sub.doc_no = bv.doc_no left join gl_estconfirm ecm on ecm.tr_no=pq.tr_no "
					+ "where cm.ref_type='SQOT' and cm.dtype='SJOB' and sq.ref_type IN ('ENQ','SRVE') and pq.ref_type IN ('ENQ','SRVE') AND cm.STATUS=3 and cm.jbaction in (0,4) and pq.cstatus=0 "+sqltest+" group by pq.tr_no order by bv.fdate DESC";
		
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
	
	public  JSONArray loadGridDataexcel(String barchval,String chkfollowup,String followupdate,String fromdate,String todate,String id) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }

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
		
			if(chkfollowup.equalsIgnoreCase("1")){
						if(!(followupdate.equalsIgnoreCase("undefined")) && !(followupdate.equalsIgnoreCase("")) && !(followupdate.equalsIgnoreCase("0"))){
								sqlFollowUpDate = cmn.changeStringtoSqlDate(followupdate);
						}
						if(!(sqlFollowUpDate==null)){
							sqltest+=" and bv.fdate<='"+sqlFollowUpDate+"' ";
						}
						
			}			
			else{
					if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
						sqlfromdate = cmn.changeStringtoSqlDate(fromdate);
					}
					if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
						sqltodate = cmn.changeStringtoSqlDate(todate);
					}
					if((!(sqlfromdate==null))&&(!(sqltodate==null))){
						sqltest+=" and pq.date between '"+sqlfromdate+"' and '"+sqltodate+"' ";
					}
			}	
				
			if(barchval.equalsIgnoreCase("a")||barchval.equalsIgnoreCase("0"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest+=" and pq.brhid="+barchval;
			}
			
			String valueOfConfig="";
			String configDays = "select method from gl_config where field_nme='srvcProformaEngConfirmation'";
			ResultSet resultSetConfig = stmt.executeQuery(configDays);
			
			while(resultSetConfig.next()){
				valueOfConfig=resultSetConfig.getString("method");
			}
			
			if(valueOfConfig.equalsIgnoreCase("1")){
				sqltest+=" and cm.pstatus!=1 ";
			}
				
			/*String sqldata="select pq.tr_no,pq.doc_no,DATE_FORMAT(pq.date,'%d.%m.%Y') date,coalesce(ac.refname,'') client,bv.fdate,pq.brhid,pq.userid,'VIEW' view,"
					+ "round(pq.material,2) material,round(pq.labour,2) labour,round(pq.machine,2) machine,round(pq.nettotal,2) nettotal,"
					+ "me.menu_name as menuname,me.func path,pq.dtype,ac.doc_no as cldocno,pq.reviseno,pq.ref_type,"
					+ "CONVERT(coalesce(pq.refdocno,''),CHAR(100)) as refdocno,pq.reftrno,trim(ac.address) address,"
					+ "CAST(if(Pq.ref_type='DIR','DIR',concat(Pq.ref_type,'-',Pq.refdocno)) AS CHAR) refdet,"
					+ "if(ecm.tr_no>0,'1','0') ecmno,cm.doc_no contrno,sq.doc_no qotno,coalesce(eq.doc_no) enqmtrno,coalesce(eq.surtrno) surtrno,"
					+ "cm.tr_no contracttrno,cm.dtype doctype  from cm_srvcontrm cm "
					+ "inner join cm_srvqotm sq on sq.tr_no=cm.reftrno and sq.status=3 "
					+ "inner join gl_enqm eq on eq.doc_no=sq.refdocno and eq.status=3 inner join cm_prjestm Pq on Eq.doc_no=pq.refdocno and pq.status=3 "
					+ "left join my_acbook ac on ac.cldocno=pq.cldocno and ac.dtype='CRM' left join my_menu me on me.doc_type=pq.dtype "
					+ "left join (select max(doc_no) doc_no,rtrno from gl_bengc where status=3 group by rtrno) sub on(sub.rtrno=pq.tr_no) "
					+ "left join gl_bengc bv on sub.doc_no = bv.doc_no left join gl_estconfirm ecm on ecm.tr_no=pq.tr_no"
					+ " where  cm.ref_type='SQOT' and cm.dtype='SJOB' and sq.ref_type='ENQ' and pq.ref_type='ENQ' and cm.status=3 and pq.cstatus=0 "+sqltest+" group by pq.tr_no order by bv.fdate DESC";*/
			
			String sqldata="select pq.doc_no 'Doc No',cm.dtype 'Doc Type',CAST(if(Pq.ref_type='DIR','DIR',concat(Pq.ref_type,'-',Pq.refdocno)) AS CHAR) 'Ref Details',DATE_FORMAT(pq.date,'%d.%m.%Y') 'Date',"
					+ "sq.doc_no 'Quotation No',cm.doc_no 'Contract No',coalesce(ac.refname,'') 'Client',bv.fdate 'FollowUp Date' from cm_srvcontrm cm inner join cm_srvqotm sq on sq.tr_no=cm.reftrno and sq.status=3 "
					+ "left join gl_enqm eq on eq.doc_no=sq.refdocno and sq.ref_type='ENQ' and eq.status=3 left join cm_srvdetm sm on sm.TR_no=sq.refdocno and sQ.ref_type='SRVE' "
					+ "left join cm_prjestm Pq on ((Eq.voc_no=pq.refdocno and Eq.brhid=pq.brhid and pq.ref_type ='ENQ') or (SM.DOC_NO=pq.refdocno and pq.ref_type ='SRVE')) and pq.status=3 "
					+ "left join my_acbook ac on ac.cldocno=pq.cldocno and ac.dtype='CRM' left join my_menu me on me.doc_type=pq.dtype left join (select max(doc_no) doc_no,rtrno from gl_bengc "
					+ "where status=3 group by rtrno) sub on(sub.rtrno=pq.tr_no) left join gl_bengc bv on sub.doc_no = bv.doc_no left join gl_estconfirm ecm on ecm.tr_no=pq.tr_no "
					+ "where cm.ref_type='SQOT' and cm.dtype='SJOB' and sq.ref_type IN ('ENQ','SRVE') and pq.ref_type IN ('ENQ','SRVE') AND cm.STATUS=3 and cm.jbaction in (0,4) and pq.cstatus=0 "+sqltest+" group by pq.tr_no order by bv.fdate DESC";
		
			System.out.println("=enqconfirm==="+sqldata);
					
		
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
	
	/*public  JSONArray loadGridDataexcel(String barchval,String chkfollowup,String followupdate,String fromdate,String todate,String id) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }

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
		
			if(chkfollowup.equalsIgnoreCase("1")){
						if(!(followupdate.equalsIgnoreCase("undefined")) && !(followupdate.equalsIgnoreCase("")) && !(followupdate.equalsIgnoreCase("0"))){
								sqlFollowUpDate = cmn.changeStringtoSqlDate(followupdate);
						}
						if(!(sqlFollowUpDate==null)){
							sqltest+=" and bv.fdate<='"+sqlFollowUpDate+"' ";
						}
						
			}			
			else{
					if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
						sqlfromdate = cmn.changeStringtoSqlDate(fromdate);
					}
					if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
						sqltodate = cmn.changeStringtoSqlDate(todate);
					}
					if((!(sqlfromdate==null))&&(!(sqltodate==null))){
						sqltest+=" and pq.date between '"+sqlfromdate+"' and '"+sqltodate+"' ";
					}
			}	
				
			if(barchval.equalsIgnoreCase("a")||barchval.equalsIgnoreCase("0"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest+=" and pq.brhid="+barchval;
			}
			
			String sqldata="select pq.tr_no,pq.doc_no,DATE_FORMAT(pq.date,'%d.%m.%Y') date,coalesce(ac.refname,'') client,bv.fdate,pq.brhid,pq.userid,'VIEW' view,"
					+ "round(pq.material,2) material,round(pq.labour,2) labour,round(pq.machine,2) machine,round(pq.nettotal,2) nettotal,"
					+ "me.menu_name as menuname,me.func path,pq.dtype,ac.doc_no as cldocno,pq.reviseno,pq.ref_type,"
					+ "CONVERT(coalesce(pq.refdocno,''),CHAR(100)) as refdocno,pq.reftrno,trim(ac.address) address,"
					+ "CAST(if(Pq.ref_type='DIR','DIR',concat(Pq.ref_type,'-',Pq.refdocno)) AS CHAR) refdet,"
					+ "if(ecm.tr_no>0,'1','0') ecmno,cm.doc_no contrno,sq.doc_no qotno,coalesce(eq.doc_no) enqmtrno,coalesce(eq.surtrno) surtrno,"
					+ "cm.tr_no contracttrno,cm.dtype doctype  from cm_srvcontrm cm "
					+ "inner join cm_srvqotm sq on sq.tr_no=cm.reftrno and sq.status=3 "
					+ "inner join gl_enqm eq on eq.doc_no=sq.refdocno and eq.status=3 inner join cm_prjestm Pq on Eq.doc_no=pq.refdocno and pq.status=3 "
					+ "left join my_acbook ac on ac.cldocno=pq.cldocno and ac.dtype='CRM' left join my_menu me on me.doc_type=pq.dtype "
					+ "left join (select max(doc_no) doc_no,rtrno from gl_bengc where status=3 group by rtrno) sub on(sub.rtrno=pq.tr_no) "
					+ "left join gl_bengc bv on sub.doc_no = bv.doc_no left join gl_estconfirm ecm on ecm.tr_no=pq.tr_no"
					+ " where  cm.ref_type='SQOT' and cm.dtype='SJOB' and sq.ref_type='ENQ' and pq.ref_type='ENQ' and cm.status=3 and pq.cstatus=0 "+sqltest+" group by pq.tr_no order by bv.fdate DESC";
			
			String sqldata="select pq.tr_no,pq.doc_no Doc_No,cm.dtype Doctype ,pq.ref_type Ref_detail,DATE_FORMAT(pq.date,'%d.%m.%Y') Date,sq.doc_no Quotation_No,cm.doc_no Contract_No,coalesce(ac.refname,'') Client,bv.fdate Followup_date "
					+ " from cm_srvcontrm cm inner join cm_srvqotm sq on sq.tr_no=cm.reftrno and sq.status=3 "
					+ "left join gl_enqm eq on eq.doc_no=sq.refdocno and sq.ref_type='ENQ' and eq.status=3 left join cm_srvdetm sm on sm.TR_no=sq.refdocno and sQ.ref_type='SRVE' "
					+ "left join cm_prjestm Pq on ((Eq.doc_no=pq.refdocno and pq.ref_type ='ENQ') or (SM.DOC_NO=pq.refdocno and pq.ref_type ='SRVE')) and pq.status=3 "
					+ "left join my_acbook ac on ac.cldocno=pq.cldocno and ac.dtype='CRM' left join my_menu me on me.doc_type=pq.dtype left join (select max(doc_no) doc_no,rtrno from gl_bengc "
					+ "where status=3 group by rtrno) sub on(sub.rtrno=pq.tr_no) left join gl_bengc bv on sub.doc_no = bv.doc_no left join gl_estconfirm ecm on ecm.tr_no=pq.tr_no "
					+ "where cm.ref_type='SQOT' and cm.dtype='SJOB' and sq.ref_type IN ('ENQ','SRVE') and pq.ref_type IN ('ENQ','SRVE') AND cm.STATUS=3 and pq.cstatus=0 "+sqltest+" group by pq.tr_no order by bv.fdate DESC";
		
			//System.out.println("=enqconfirm==="+sqldata);
					
		
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
	}*/
	
	
	public  JSONArray loadSubGridData(String trdocno,String id) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
     if(!id.equalsIgnoreCase("1")){
    	return  RESULTDATA;
    	 
     }

		Connection conn = null;

		try {

			//System.out.println("=====loadTrafficdaily");
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();   
		 	
		
				
			String sqldata = "select m.date detdate,u.user_id user,m.fdate fdate,remarks remk from "
					+ " gl_bengc m left join  my_user u on u.doc_no=m.userid where m.rtrno="+trdocno+" and m.status=3;";
		
			System.out.println("1234"+sqldata);
			ResultSet resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cmn.convertToJSON(resultSet);
			//			System.out.println("=====RESULTDATA"+RESULTDATA);
			
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			
			conn.close();
		}
		return RESULTDATA;
	}
		
	public JSONArray materialGridReLoad(HttpSession session,String trno,String ecmno,String id) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA1;
        }
		Connection conn=null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "",sqltest="";

if(ecmno.equalsIgnoreCase("1"))
{
	sql="select d.rowno,d.tr_no,m.psrno,m.psrno pid,m.psrno prodoc,at.mspecno specid,prj.brhid,prd.locid,m.part_no productid,m.productname,d.qty qty,d.costprice amount,d.total total,d.profitper margin,d.nettotal,d.description desc1,"
			+ "u.unit unit,m.munit as unitdocno,jobtype as activity,mp.tr_no activityid,prd.stkqty,"
			+ "if(prd.stkqty>d.qty,d.qty,prd.stkqty) resqty,d.qty-if(prd.stkqty>d.qty,d.qty,prd.stkqty) purqty,"
			+ "bd.brandname,d.site,d.sertypeid stypeid,grp.groupname sertype,coalesce(d.sitesrno,0) sitesrno,m.productname product,m.productname proname,bd.brandname brand"
			+ " from gl_estconfirm d  "
			+ " left join cm_prjestm prj on prj.tr_no=d.tr_no left join cm_prjmaster mp  on(mp.tr_no=d.activityid) left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no) "
			+ " left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) "
			+ "left join (select psrno,brhid,locid,sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty from my_prddin group by psrno,brhid ) prd on prd.psrno=d.psrno and prd.brhid=prj.brhid "
			+ "left join my_unitm u on m.munit=u.doc_no left join my_groupvals grp on grp.doc_no=d.sertypeid and grp.grptype='service' where 1=1  and d.tr_no="+trno+"";
}
else if(ecmno.equalsIgnoreCase("0")){
			sql="select d.rowno,d.tr_no,m.psrno,m.psrno pid,m.psrno prodoc,at.mspecno specid,prj.brhid,prd.locid,m.part_no productid,m.productname,d.qty qty,d.costprice amount,d.total total,d.profitper margin,d.nettotal,d.description desc1,"
					+ "u.unit unit,m.munit as unitdocno,jobtype as activity,mp.tr_no activityid,prd.stkqty,"
					+ "if(prd.stkqty>d.qty,d.qty,prd.stkqty) resqty,d.qty-if(prd.stkqty>d.qty,d.qty,prd.stkqty) purqty,bd.brandname,d.site,d.sertypeid stypeid,"
					+ "grp.groupname sertype,coalesce(d.sitesrno,0) sitesrno,m.productname product,m.productname proname,bd.brandname brand from cm_estmprdd d  "
					+ " left join cm_prjestm prj on prj.tr_no=d.tr_no left join cm_prjmaster mp  on(mp.tr_no=d.activityid) left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no) "
					+ " left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) "
					+ "left join (select psrno,brhid,locid,sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty from my_prddin group by psrno,brhid ) prd on prd.psrno=d.psrno and prd.brhid=prj.brhid "
					+ "left join my_unitm u on m.munit=u.doc_no left join my_groupvals grp on grp.doc_no=d.sertypeid and grp.grptype='service' where 1=1  and d.tr_no="+trno+"";

}
			System.out.println("===engconfProductGrid===="+sql);

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
	
	public JSONArray materialGridReLoadexcel(HttpSession session,String trno,String ecmno,String id) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA1;
        }
		Connection conn=null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "",sqltest="";

if(ecmno.equalsIgnoreCase("1"))
{
	sql="select d.site 'Site',grp.groupname 'Service Type',d.description 'Description',m.productname 'Product',bd.brandname 'Brand Name',u.unit 'Unit',d.qty 'Quantity',d.costprice 'Amount' from gl_estconfirm d  "
			+ " left join cm_prjestm prj on prj.tr_no=d.tr_no left join cm_prjmaster mp  on(mp.tr_no=d.activityid) left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no) "
			+ " left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) "
			+ "left join (select psrno,brhid,locid,sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty from my_prddin group by psrno,brhid ) prd on prd.psrno=d.psrno and prd.brhid=prj.brhid "
			+ "left join my_unitm u on m.munit=u.doc_no left join my_groupvals grp on grp.doc_no=d.sertypeid and grp.grptype='service' where 1=1  and d.tr_no="+trno+"";
}
else if(ecmno.equalsIgnoreCase("0")){
			sql="select d.site 'Site',grp.groupname 'Service Type',d.description 'Description',m.productname 'Product',bd.brandname 'Brand Name',u.unit 'Unit',d.qty 'Quantity',d.costprice 'Amount' from cm_estmprdd d  "
					+ " left join cm_prjestm prj on prj.tr_no=d.tr_no left join cm_prjmaster mp  on(mp.tr_no=d.activityid) left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no) "
					+ " left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) "
					+ "left join (select psrno,brhid,locid,sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty from my_prddin group by psrno,brhid ) prd on prd.psrno=d.psrno and prd.brhid=prj.brhid "
					+ "left join my_unitm u on m.munit=u.doc_no left join my_groupvals grp on grp.doc_no=d.sertypeid and grp.grptype='service' where 1=1  and d.tr_no="+trno+"";

}
			System.out.println("===engconfProductGrid===="+sql);

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
	
	
	/*public JSONArray materialGridReLoadexcel(HttpSession session,String trno,String ecmno,String id) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA1;
        }
		Connection conn=null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "",sqltest="";

if(ecmno.equalsIgnoreCase("1"))
{
	sql="select d.rowno,d.site Site,d.tr_no,m.psrno,m.psrno pid,m.psrno prodoc,at.mspecno specid,prj.brhid,prd.locid,m.part_no productid,m.productname,d.qty qty,d.costprice amount,d.total total,d.profitper margin,d.nettotal,d.description desc1,"
			+ "u.unit unit,m.munit as unitdocno,jobtype as activity,mp.tr_no activityid,prd.stkqty,"
			+ "if(prd.stkqty>d.qty,d.qty,prd.stkqty) resqty,d.qty-if(prd.stkqty>d.qty,d.qty,prd.stkqty) purqty,"
			+ "bd.brandname,d.site,d.sertypeid stypeid,grp.groupname sertype,coalesce(d.sitesrno,0) sitesrno,m.productname product,m.productname proname,bd.brandname brand"
			+ " from gl_estconfirm d  "
			+ " left join cm_prjestm prj on prj.tr_no=d.tr_no left join cm_prjmaster mp  on(mp.tr_no=d.activityid) left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no) "
			+ " left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) "
			+ "left join (select psrno,brhid,locid,sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty from my_prddin group by psrno,brhid ) prd on prd.psrno=d.psrno and prd.brhid=prj.brhid "
			+ "left join my_unitm u on m.munit=u.doc_no left join my_groupvals grp on grp.doc_no=d.sertypeid and grp.grptype='service' where 1=1  and d.tr_no="+trno+"";
}
else if(ecmno.equalsIgnoreCase("0")){
			sql="select d.rowno,d.site Site,grp.groupname Service_type,d.description Description,m.productname Product_Name,bd.brandname Brand,u.unit Unit,d.qty Quantity,d.costprice Amount"
					+" from cm_estmprdd d  "
					+ " left join cm_prjestm prj on prj.tr_no=d.tr_no left join cm_prjmaster mp  on(mp.tr_no=d.activityid) left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no) "
					+ " left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) "
					+ "left join (select psrno,brhid,locid,sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty from my_prddin group by psrno,brhid ) prd on prd.psrno=d.psrno and prd.brhid=prj.brhid "
					+ "left join my_unitm u on m.munit=u.doc_no left join my_groupvals grp on grp.doc_no=d.sertypeid and grp.grptype='service' where 1=1  and d.tr_no="+trno+"";

}
			System.out.println("===engconfProductGrid===="+sql);

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
	}*/
	
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