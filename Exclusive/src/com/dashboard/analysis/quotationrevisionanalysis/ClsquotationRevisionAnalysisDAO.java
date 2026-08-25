package com.dashboard.analysis.quotationrevisionanalysis;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsquotationRevisionAnalysisDAO {

	ClsConnection conobj= new ClsConnection();
	ClsCommon com=new ClsCommon();

	public JSONArray qotrevisiondata(String fromdate,String todate,String branch,String clientid) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        
     	String sqltest="";
        java.sql.Date sqlfromdate = null;
        java.sql.Date sqltodate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=com.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=com.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}
       
       	if(!(clientid.equalsIgnoreCase(""))){
       		sqltest+=" and qm.cldocno= "+clientid+" ";
       	}
       	    	
       	if(branch.equalsIgnoreCase("a")||branch.equalsIgnoreCase("0"))
    	{
			sqltest+="";
    	}
		else
		{
			sqltest+=" and qm.brhid="+branch;
		}
       
     	Connection conn = null;
     	
		Statement stmtVeh =null;
		ResultSet resultSet=null;
        
		try {
				 conn = conobj.getMyConnection();
				 stmtVeh = conn.createStatement ();
				
            		String sql="select qm.tr_no,qm.doc_no,ac.refname client,qm.cldocno,round(coalesce(la.total,0),2) rev0,round(coalesce(lb.total,0),2) rev1,"
            				+ "round(coalesce(lc.total,0),2) rev2,round(coalesce(ld.total,0),2) rev3,round(coalesce(le.total,0),2) rev4,round(coalesce(lf.total,0),2) rev5,"
            				+ "round(coalesce(lg.total,0),2) rev6,round(coalesce(lh.total,0),2) rev7 "
            				+ "from cm_srvqotm qm left join cm_srvqotd qd on qd.tr_no=qm.tr_no left join my_acbook ac on ac.cldocno=qm.cldocno and ac.dtype='crm' "
            				+ "left join (select tr_no,revision_no rev,sum(total) total from cm_srvqotd where revision_no=0 group by tr_no,revision_no ) la on qd.tr_no=la.tr_no "
            				+ "left join (select tr_no,revision_no rev,sum(total) total from cm_srvqotd where revision_no=1 group by tr_no,revision_no ) lb on qd.tr_no=lb.tr_no "
            				+ "left join (select tr_no,revision_no rev,sum(total) total from cm_srvqotd where revision_no=2 group by tr_no,revision_no ) lc on qd.tr_no=lc.tr_no "
            				+ "left join (select tr_no,revision_no rev,sum(total) total from cm_srvqotd where revision_no=3 group by tr_no,revision_no ) ld on qd.tr_no=ld.tr_no "
            				+ "left join (select tr_no,revision_no rev,sum(total) total from cm_srvqotd where revision_no=4 group by tr_no,revision_no ) le on qd.tr_no=le.tr_no "
            				+ "left join (select tr_no,revision_no rev,sum(total) total from cm_srvqotd where revision_no=5 group by tr_no,revision_no ) lf on qd.tr_no=lf.tr_no "
            				+ "left join (select tr_no,revision_no rev,sum(total) total from cm_srvqotd where revision_no=6 group by tr_no,revision_no ) lg on qd.tr_no=lg.tr_no "
            				+ "left join (select tr_no,revision_no rev,sum(total) total from cm_srvqotd where revision_no=7 group by tr_no,revision_no ) lh on qd.tr_no=lh.tr_no "
            				+ "where qm.status!=7 and qm.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+" group by qm.tr_no ";
          System.out.println("--qotrevisionanlysis=--"+sql);
            		resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=com.convertToJSON(resultSet);
     			
		}
		catch(Exception e){
			conn.close();
		}
		finally{
			stmtVeh.close();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }

	public JSONArray quotGridLoad(HttpSession session,String doc_no) throws SQLException{

		//System.out.println(doc_no);
				JSONArray RESULTDATA1=new JSONArray();

				Connection conn=null;
				try {
					conn = conobj.getMyConnection();
					Statement stmt = conn.createStatement();

					String sql = "";

					sql="select CAST(concat('Revision-',d.revision_no) AS CHAR) revision,site,s.sr_no siteid,groupname stype,g.doc_no stypeid, d.description desc1, Equips item, qty, d.Amount, total,u.unit as unit,unitid from "
							+ " cm_srvqotd d left join my_groupvals g on(d.servid=g.doc_no and grptype='service') left join cm_servsited s on(s.rowno=d.sitesrno) left join my_unitm u on(u.doc_no=d.unitid)" 
							+" where d.tr_no="+doc_no+"";

							System.out.println("===quotGridLoad===="+sql);

					ResultSet resultSet1 = stmt.executeQuery(sql);
					RESULTDATA1=com.convertToJSON(resultSet1);

				}
				catch(Exception e){
					e.printStackTrace();
				}
				finally{
					conn.close();
				}


				return RESULTDATA1;
			}
	
	public JSONArray siteGridLoad(HttpSession session,String trno,int check) throws SQLException{

				JSONArray RESULTDATA1=new JSONArray();
				System.out.println("check="+check);
				if(check!=1){
		        	return RESULTDATA1;
		        }
				
				Connection conn=null;
				try {
					conn = conobj.getMyConnection();
					Statement stmt = conn.createStatement();

					String sql = "";

					sql="select  d.site,CAST(concat('Revision-',d.revision_no) AS CHAR) revision,d.amount,g.groupname area from cm_servsited  d left join my_groupvals g on "
							+ "(d.areaid=g.doc_no and grptype='area') where tr_no='"+trno+"'";

							System.out.println("===siteGridLoad===="+sql);

					ResultSet resultSet1 = stmt.executeQuery(sql);
					RESULTDATA1=com.convertToJSON(resultSet1);

				}
				catch(Exception e){
					e.printStackTrace();
				}
				finally{
					conn.close();
				}


				return RESULTDATA1;
			}
	
	public JSONArray revisionGridLoad(HttpSession session,String trno,int check) throws SQLException{

		JSONArray RESULTDATA1=new JSONArray();
		System.out.println("check="+check);
		if(check!=1){
        	return RESULTDATA1;
        }
		
		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select CAST(concat('Revision-',revision_no) AS CHAR) revision,date,remarks from cm_srvqotrev where rtrno='"+trno+"'";

					System.out.println("===revisionGridLoad===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}

	public JSONArray searchClient(HttpSession session,String clname,String mob,int id) throws SQLException {


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


		String sqltest="";

		if(!(clname.equalsIgnoreCase("undefined"))&&!(clname.equalsIgnoreCase(""))&&!(clname.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and refname like '%"+clname+"%'";
		}
		if(!(mob.equalsIgnoreCase("undefined"))&&!(mob.equalsIgnoreCase(""))&&!(mob.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and per_mob like '%"+mob+"%'";
		}


		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmtVeh1 = conn.createStatement ();

			if(id>0){
			String clsql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM'  " +sqltest);

			ResultSet resultSet = stmtVeh1.executeQuery(clsql);

			RESULTDATA=com.convertToJSON(resultSet);
			stmtVeh1.close();
			conn.close();
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

		

}
