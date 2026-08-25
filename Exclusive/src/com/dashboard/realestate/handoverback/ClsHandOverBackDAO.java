package com.dashboard.realestate.handoverback;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsHandOverBackDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon =new ClsCommon();	
	
	public JSONArray getPropertyData(String hand,String id) throws SQLException {     
		JSONArray RESULTDATA=new JSONArray();
		System.out.println("====propData==="+id);
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn = null;
		java.sql.Date sqltodate=null;
		java.sql.Date sqlfromdate=null;
		/*sqluptodate=ClsCommon.changeStringtoSqlDate(uptodate);*/
		
		try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmt = conn.createStatement();
			 String sqltst="",sqltst1="",sqltst2="";
			 if(!(hand.equalsIgnoreCase("undefined"))&&!(hand.equalsIgnoreCase(""))&&!(hand.equalsIgnoreCase("0"))){
				 if(hand.equalsIgnoreCase("1")){
				 sqltst="and m.clstatus=0 and old.doc_no is null and m.handover=0 and mgprpty=1 ";
				 sqltst1=" left join my_user u on m.handoveruser=u.doc_no left join rl_tncm old on old.renewaldocno=m.doc_no ";
				 }
				 if(hand.equalsIgnoreCase("2")){
					 sqltst="and renewalstatus=2 and clstatus=0  and renewaldocno=0  and m.handback=0 and mgprpty=1 ";
					 sqltst1="left join my_user u on m.handbackuser=u.doc_no ";
					 }
				}
			/* if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
				 sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
				}
			 if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
				 sqltodate=ClsCommon.changeStringtoSqlDate(todate);   
				}*/
			 String strsql="select unitno unitno1,u.user_name uname,m.doc_no,m.voc_no,m.date,a.refname,convert(pm.accname,char(60)) as pname,m.Period_from as fromdate, m.Period_to as todate,po.primary_owner as owner from rl_tncm  m "
			 		+ " left join rl_propertymaster pm on pm.doc_no=m.prtype left join rl_propertryowner po on po.doc_no=pm.owid "
			 		+ " left join my_acbook a on a.acno=m.acno "+sqltst1+" where m.status=3 "+sqltst+" order by m.doc_no;";
			 System.out.println("handgrid---->>>"+strsql);    			 
			 /**/
			ResultSet resultSet = stmt.executeQuery(strsql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray getPropertyDataExcel(String hand,String id) throws SQLException {     
		JSONArray RESULTDATA=new JSONArray();
		System.out.println("====propData==="+id);
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn = null;
		java.sql.Date sqltodate=null;
		java.sql.Date sqlfromdate=null;
		/*sqluptodate=ClsCommon.changeStringtoSqlDate(uptodate);*/
		
		try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmt = conn.createStatement();
			 String sqltst="",sqltst1="";
			 if(!(hand.equalsIgnoreCase("undefined"))&&!(hand.equalsIgnoreCase(""))&&!(hand.equalsIgnoreCase("0"))){
				 if(hand.equalsIgnoreCase("1")){
				 sqltst="and m.clstatus=0";
				 sqltst1="left join my_user u on m.handoveruser=u.doc_no";
				 }
				 if(hand.equalsIgnoreCase("2")){
					 sqltst="and renewalstatus=2 and clstatus=0";
					 sqltst1="left join my_user u on m.handbackuser=u.doc_no";
					 }
				}
			/* if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
				 sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
				}
			 if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
				 sqltodate=ClsCommon.changeStringtoSqlDate(todate);   
				}*/
			 String strsql="select m.voc_no as 'Contract No',m.date as 'Date',a.refname as 'Tenant',convert(pm.accname,char(60)) as 'Property',po.primary_owner as 'Owner',m.Period_from as 'From Date', m.Period_to as 'To Date',u.user_name as 'Assigned User' from rl_tncm  m "
			 		+ " left join rl_propertymaster pm on pm.doc_no=m.prtype left join rl_propertryowner po on po.doc_no=pm.owid "
			 		+ " left join my_acbook a on a.acno=m.acno "+sqltst1+" where m.status=3 "+sqltst+" order by m.doc_no;";
			 System.out.println("handgrid---->>>"+strsql);    			 
			 /**/
			ResultSet resultSet = stmt.executeQuery(strsql);
			RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
}
