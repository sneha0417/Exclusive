package com.dashboard.accounts.ageingstatementduedate;

 import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAgeingStatementDueDateDAO  { 
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray ageingStatement(String branch,String uptodate,String atype,String accdocno, String salesperson,String category,String level1from, String level1to, String level2from, String level2to,
			String level3from, String level3to,String level4from, String level4to,String level5from,String check) throws SQLException {
       
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
        
        java.sql.Date sqlUpToDate = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtAgeingStatement = conn.createStatement();
				String sql = "",sql1="",sqld = "",sqld1 = "",select="";

				if(check.equalsIgnoreCase("1")){
					
				if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
		              sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
		        }
				
				if(atype.equalsIgnoreCase("AR")){
					sqld=" and j.id < 0";
					sqld1=" and j.id > 0";
					
					/*select ="select name,ag.contact,ag.pmob,CONVERT(if(sum(t7+u6)<0,round((sum(t7+u6)*-1),2),''),CHAR(50)) 'advance',"
						+ "CONVERT(if(sum(t7+u6)>0,round((sum(t7+u6)),2),''),CHAR(50)) 'balance',CONVERT(if(sum(u6<0),round((sum(u6*-1)),2),''),CHAR(50)) 'unapplied', "  
						+ "CONVERT(if(sum(t7)>0,round((sum(t7)),2),''),CHAR(50)) 'netamount',CONVERT(if(sum(l0)>0,round((sum(l0)),2),''),CHAR(50)) level0,"
						+ "CONVERT(if(sum(l1)>0,round((sum(l1)),2),''),CHAR(50)) 'level1',CONVERT(if(sum(l2)>0,round((sum(l2)),2),''),CHAR(50)) 'level2',"
						+ "CONVERT(if(sum(l3)>0,round((sum(l3)),2),''),CHAR(50)) 'level3',CONVERT(if(sum(l4)>0,round((sum(l4)),2),''),CHAR(50)) 'level4',"
						+ "CONVERT(if(sum(l5)>0,round((sum(l5)),2),''),CHAR(50)) 'level5',ag.acno,ag.brhid from (select d.name,d.mob,d.contact,d.pmob,d.acno,d.brhid,"
						+ "d.doc_no,if(d.duedys<0 and d.bal>0,round((d.bal),2),0) l0,if(d.duedys between "+level1from+" and "+level1to+" and d.bal>0,round((d.bal),2),0) l1,"
						+ "if(d.duedys between "+level2from+" and "+level2to+" and d.bal>0,round((d.bal),2),0) l2,if(d.duedys between "+level3from+" "
						+ "and "+level3to+" and d.bal>0,round((d.bal),2),0) l3,if(d.duedys between "+level4from+" and "+level4to+" and d.bal>0,round((d.bal),2),0) l4,"
						+ "if(d.duedys >="+level5from+" and d.bal>0,round((d.bal),2),0) l5,CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(10)) U6,if(d.bal>0,d.bal,0) t7 from ";*/
					
					select ="select a.*,if(bk.per_mob is null,bk.com_mob,if(bk.per_mob='NA',bk.com_mob,if(bk.per_mob=' ',bk.com_mob,bk.per_mob))) pmob,bk.contactPerson contact,s.sal_name from ("
						 + "select name,CONVERT(if(sum(t7+u6)<0,round((sum(t7+u6)*-1),2),''),CHAR(50)) 'advance',CONVERT(if(sum(t7+u6)>0,round((sum(t7+u6)),2),''),CHAR(50)) 'balance',"
						 + "CONVERT(if(sum(u6<0),round((sum(u6*-1)),2),''),CHAR(50)) 'unapplied',CONVERT(if(sum(t7)>0,round((sum(t7)),2),''),CHAR(50)) 'netamount',CONVERT(if(sum(l0)>0,round((sum(l0)),2),''),CHAR(50)) 'level0',"
						 + "CONVERT(if(sum(l1)>0,round((sum(l1)),2),''),CHAR(50)) 'level1',CONVERT(if(sum(l2)>0,round((sum(l2)),2),''),CHAR(50)) 'level2',CONVERT(if(sum(l3)>0,round((sum(l3)),2),''),CHAR(50)) 'level3',"  
						 + "CONVERT(if(sum(l4)>0,round((sum(l4)),2),''),CHAR(50)) 'level4',CONVERT(if(sum(l5)>0,round((sum(l5)),2),''),CHAR(50)) 'level5',ag.acno,ag.brhid from (select d.name,d.acno,d.brhid,"
						 + "d.doc_no,if(d.duedys<0 and d.bal>0,round((d.bal),2),0) l0,if(d.duedys between "+level1from+" and "+level1to+" and d.bal>0,round((d.bal),2),0) l1,if(d.duedys between "+level2from+" and "+level2to+" and d.bal>0,"  
						 + "round((d.bal),2),0) l2,if(d.duedys between "+level3from+" and "+level3to+" and d.bal>0,round((d.bal),2),0) l3,if(d.duedys between "+level4from+" and "+level4to+" and d.bal>0,round((d.bal),2),0) l4,"
						 + "if(d.duedys >="+level5from+" and d.bal>0,round((d.bal),2),0) l5,CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(50)) U6,if(d.bal>0,d.bal,0) t7 from ";
					
				}
				else if(atype.equalsIgnoreCase("AP")){
					sqld=" and j.id > 0";
					sqld1=" and j.id < 0";
					
					/*select ="select name,ag.contact,ag.pmob,CONVERT(if(sum(t7+u6)>0,round((sum(t7+u6)),2),''),CHAR(50)) 'advance',"
							+ "CONVERT(if(sum(t7+u6)<0,round((sum(t7+u6)*-1),2),''),CHAR(50)) 'balance',CONVERT(if(sum(u6>0),round((sum(u6)),2),''),CHAR(50)) 'unapplied',"
							+ "CONVERT(if(sum(t7)<0,round((sum(t7)*-1),2),''),CHAR(50)) 'netamount',CONVERT(if(sum(l0)<0,round((sum(l0)),2),''),CHAR(50)) level0,"
							+ "CONVERT(if(sum(l1)<0,round((sum(l1)*-1),2),''),CHAR(50)) 'level1',CONVERT(if(sum(l2)<0,round((sum(l2)*-1),2),''),CHAR(50)) 'level2',"
							+ "CONVERT(if(sum(l3)<0,round((sum(l3)*-1),2),''),CHAR(50)) 'level3',CONVERT(if(sum(l4)<0,round((sum(l4)*-1),2),''),CHAR(50)) 'level4',"
							+ "CONVERT(if(sum(l5)<0,round((sum(l5)*-1),2),''),CHAR(50)) 'level5',ag.acno,ag.brhid from (select d.name,d.mob,d.contact,d.pmob,d.acno,d.brhid,d.doc_no,if(d.duedys<0 and d.bal<0,round((d.bal),2),0) l0,if(d.duedys between "+level1from+" and "+level1to+"  "
							+ "and d.bal<0,round((d.bal),2),0) l1,if(d.duedys between "+level2from+" and "+level2to+"  and d.bal<0,round((d.bal),2),0) l2,if(d.duedys "
							+ "between "+level3from+" and "+level3to+"  and d.bal<0,round((d.bal),2),0) l3,if(d.duedys between "+level4from+" and "+level4to+" and d.bal<0,"
							+ "round((d.bal),2),0) l4,if(d.duedys >="+level5from+"  and d.bal<0,round((d.bal),2),0) l5,CONVERT(if(d.bal>0,round((d.bal),2),''),CHAR(10)) U6,"
							+ "if(d.bal<0,d.bal,0) t7 from ";*/
					
					select ="select a.*,if(bk.per_mob is null,bk.com_mob,if(bk.per_mob='NA',bk.com_mob,if(bk.per_mob=' ',bk.com_mob,bk.per_mob))) pmob,bk.contactPerson contact,s.sal_name from ("
						   + "select name,CONVERT(if(sum(t7+u6)>0,round((sum(t7+u6)),2),''),CHAR(50)) 'advance',CONVERT(if(sum(t7+u6)<0,round((sum(t7+u6)*-1),2),''),CHAR(50)) 'balance',"
						   + "CONVERT(if(sum(u6>0),round((sum(u6)),2),''),CHAR(50)) 'unapplied',CONVERT(if(sum(t7)<0,round((sum(t7)*-1),2),''),CHAR(50)) 'netamount',CONVERT(if(sum(l0)<0,round((sum(l0)),2),''),CHAR(50)) level0,"
						   + "CONVERT(if(sum(l1)<0,round((sum(l1)*-1),2),''),CHAR(50)) 'level1',CONVERT(if(sum(l2)<0,round((sum(l2)*-1),2),''),CHAR(50)) 'level2',CONVERT(if(sum(l3)<0,round((sum(l3)*-1),2),''),CHAR(50)) 'level3'," 
						   + "CONVERT(if(sum(l4)<0,round((sum(l4)*-1),2),''),CHAR(50)) 'level4',CONVERT(if(sum(l5)<0,round((sum(l5)*-1),2),''),CHAR(50)) 'level5',ag.acno,ag.brhid from (select d.name,d.acno,"
						   + "d.brhid,d.doc_no,if(d.duedys<0 and d.bal<0,round((d.bal),2),0) l0,if(d.duedys between "+level1from+" and "+level1to+" and d.bal<0,round((d.bal),2),0) l1,if(d.duedys between "+level2from+" and "+level2to+" and d.bal<0,"  
						   + "round((d.bal),2),0) l2,if(d.duedys between "+level3from+" and "+level3to+" and d.bal<0,round((d.bal),2),0) l3,if(d.duedys between "+level4from+" and "+level4to+" and d.bal<0,round((d.bal),2),0) l4,"
						   + "if(d.duedys >="+level5from+" and d.bal<0,round((d.bal),2),0) l5,CONVERT(if(d.bal>0,round((d.bal),2),''),CHAR(50)) U6,if(d.bal<0,d.bal,0) t7 from ";		
				}
				
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhId="+branch+"";
	    		}

				if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
					sql+=" and j.acno="+accdocno+"";
	            }
				
				if(!(salesperson.equalsIgnoreCase(""))){
	    			sql1+=" and bk.sal_id="+salesperson+"";
	    		}
				
				if(!(category.equalsIgnoreCase(""))){
	    			sql1+=" and bk.catid="+category+"";
	    		}
				
				/*sql = "select ag.acno,ag.brhid,name,ag.contact,ag.pmob,CONVERT(if(sum(t7+u6)<0,round((sum(t7+u6)*-1),2),''),CHAR(50)) advance,CONVERT(if(sum(t7+u6)>0,round((sum(t7+u6)),2),''),CHAR(50)) balance,"
					+ "CONVERT(if(sum(u6<0),round((sum(u6*-1)),2),''),CHAR(50)) unapplied,CONVERT(if(sum(t7)>0,round((sum(t7)),2),''),CHAR(50)) netamount,CONVERT(if(sum(l0)>0,round((sum(l0)),2),''),CHAR(50)) level0,"
					+ "CONVERT(if(sum(l1)>0,round((sum(l1)),2),''),CHAR(50)) level1,CONVERT(if(sum(l2)>0,round((sum(l2)),2),''),CHAR(50)) level2,CONVERT(if(sum(l3)>0,round((sum(l3)),2),''),CHAR(50)) level3,"
					+ "CONVERT(if(sum(l4)>0,round((sum(l4)),2),''),CHAR(50)) level4,CONVERT(if(sum(l5)>0,round((sum(l5)),2),''),CHAR(50)) level5 from (select d.name,d.mob,d.contact,d.pmob,d.acno,d.brhid,d.doc_no,"
					+ "if(d.duedys <0 and d.bal>0,round((d.bal),2),0) l0,if(d.duedys between "+level1from+" and "+level1to+" and d.bal>0,round((d.bal),2),0) l1,if(d.duedys between "+level2from+" and "+level2to+" and d.bal>0,round((d.bal),2),0) l2,if(d.duedys "
					+ "between "+level3from+" and "+level3to+" and d.bal>0,round((d.bal),2),0) l3,if(d.duedys between "+level4from+" and "+level4to+" and d.bal>0,round((d.bal),2),0) l4,if(d.duedys >"+level5from+" and d.bal>0,round((d.bal),2),0) l5,CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(10)) U6,"
					+ "if(d.bal>0,d.bal,0) t7 from (select j.acno,j.brhid,h.description name,bk.com_mob mob,bk.per_mob pmob,bk.contactPerson contact,sum(dramount-out_amount) bal,j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(j.duedate as datetime),"
					+ "cast('"+sqlUpToDate+"' as datetime)) duedys from my_jvtran j inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c "
					+ "on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno and bk.dtype='CRM' where j.status=3 and h.atype='"+atype+"' and j.duedate<='"+sqlUpToDate+"' "+sql+" group by tranid having bal<>0) d) ag group by acno";*/
				
				/*sql = select+" (select j.acno,j.brhid,h.description name,bk.com_mob mob,bk.per_mob pmob,bk.contactPerson contact,sum(dramount) - coalesce(o.amount,0)*id bal, j.tranid, j.doc_no,"
						+ "TIMESTAMPDIFF(Day,cast(j.duedate as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys from my_jvtran j inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc "
						+ "on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno  "+condition+" "
						+ "left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.tranid where j.duedate<='"+sqlUpToDate+"' group by ap_trid ) o "
						+ "on j.tranid=o.ap_trid where j.status=3 and h.atype='"+atype+"' and j.duedate<='"+sqlUpToDate+"' "+sql+""+sqld1+" group by j.tranid having bal<>0 union all select j.acno,j.brhid,"
						+ "h.description name,bk.com_mob mob,bk.per_mob pmob,bk.contactPerson contact,sum(dramount)- coalesce(o.amount,0)*id bal, j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(j.duedate as datetime),"
						+ "cast('"+sqlUpToDate+"' as datetime)) duedys from my_jvtran j inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no "
						+ "inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno  "+condition+" left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o "
						+ "inner join my_jvtran j on j.tranid=o.ap_trid where j.duedate<='"+sqlUpToDate+"' group by tranid) o on j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' and j.duedate<='"+sqlUpToDate+"' "
						+ ""+sql+""+sqld+" group by j.tranid having bal<>0) d) ag group by acno";*/
				
				
				sql = select+" (select j.acno,j.brhid,h.description name,sum(dramount) - coalesce(o.amount,0)*id bal, j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(coalesce(j.duedate,j.date) as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys " 
					+ "from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.tranid where "  
					+ "j.date<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' "+sql+""+sqld1+" group by j.tranid having bal<>0 "  
					+ " union all select j.acno,j.brhid,h.description name,sum(dramount)- coalesce(o.amount,0)*id bal, j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(coalesce(j.duedate,j.date) as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys "  
					+ " from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"' "  
					+ " group by tranid) o on j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"'"+sql+""+sqld+" group by j.tranid having bal<>0) d) ag group by acno ) a  left join my_acbook bk on a.acno=bk.acno " 
					+ " and bk.status=3 left join my_salm s on bk.sal_id=s.doc_no where 1=1 "+sql1;
				
				ResultSet resultSet = stmtAgeingStatement.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				}
				stmtAgeingStatement.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray accountDetails(String type,String account,String partyname,String contact) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtAgeingStatement1 = conn.createStatement();
			
	    	    String sql = "";
	    	    String condition="";
            	
				if(type.equalsIgnoreCase("AR")){
					condition="and a.dtype='CRM'";
				}
				if(type.equalsIgnoreCase("AP")){
					condition="and a.dtype='VND'";
				}
				
	    	    if(!(account.equalsIgnoreCase(""))){
	                sql=sql+" and t.doc_no like '%"+account+"%'";
	            }
	            if(!(partyname.equalsIgnoreCase(""))){
	             sql=sql+" and t.description like '%"+partyname+"%'";
	            }
	            if(!(contact.equalsIgnoreCase(""))){
	                sql=sql+" and a.per_mob like '%"+contact+"%'";
	            }
	            
				sql = "select a.per_mob,t.doc_no,t.account,t.description,c.code curr from my_acbook a left join my_head t on a.acno=t.doc_no "
						+ ""+condition+" left join my_curr c on t.curid=c.doc_no where t.atype='"+type+"' and a.status<>7 and t.m_s=0"+sql;
				
				ResultSet resultSet1 = stmtAgeingStatement1.executeQuery(sql);
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtAgeingStatement1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public  ClsAgeingStatementDueDateBean getPrint(HttpServletRequest request,String atype,int acno,String branch,String uptodate,int level1from,int level1to,int level2from,
			int level2to,int level3from,int level3to,int level4from,int level4to,int level5from) throws SQLException {
		
		ClsAgeingStatementDueDateBean bean = new ClsAgeingStatementDueDateBean();

		Connection conn = null;
		
        java.sql.Date sqlUpToDate = null;
        
	try {
		
		conn = ClsConnection.getMyConnection();
		Statement stmtAgeingDueDate = conn.createStatement();
		String sql="",sqld="",sqld1="",select="",joins="",casestatement="";
		
        if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
        	sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
        }
        
        if(atype.equalsIgnoreCase("AR")){
			sqld=" and j.id < 0";
			sqld1=" and j.id > 0";
			
			select ="select CONVERT(if(sum(t7)>0,round((sum(t7)),2),'  '),CHAR(50)) netamount,CONVERT(if(sum(l0)>0,round((sum(l0)),2),'  '),CHAR(50)) level0,"
					+ "CONVERT(if(sum(l1)>0,round((sum(l1)),2),'  '),CHAR(50)) level1,CONVERT(if(sum(l2)>0,round((sum(l2)),2),'  '),CHAR(50)) level2,"
					+ "CONVERT(if(sum(l3)>0,round((sum(l3)),2),'  '),CHAR(50)) level3,CONVERT(if(sum(l4)>0,round((sum(l4)),2),'  '),CHAR(50)) level4,"
					+ "CONVERT(if(sum(l5)>0,round((sum(l5)),2),'  '),CHAR(50)) level5 from ("
					+ "select d.acno,d.brhid,d.doc_no,if(d.duedys<0 and d.bal>0,round((d.bal),2),0) l0,if(d.duedys between "+level1from+" and "+level1to+" and d.bal>0,round((d.bal),2),0) l1,"
					+ "if(d.duedys between "+level2from+" and "+level2to+" and d.bal>0,round((d.bal),2),0) l2,if(d.duedys between "+level3from+" and "+level3to+" and d.bal>0,"
					+ "round((d.bal),2),0) l3,if(d.duedys between "+level4from+" and "+level4to+" and d.bal>0,round((d.bal),2),0) l4,if(d.duedys >="+level5from+" "
					+ "and d.bal>0,round((d.bal),2),0) l5,CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(10)) U6,if(d.bal>0,d.bal,0) t7 from ";
			
		}
		else if(atype.equalsIgnoreCase("AP")){
			sqld=" and j.id > 0";
			sqld1=" and j.id < 0";
			
			select ="select CONVERT(if(sum(t7)<0,round((sum(t7)*-1),2),'  '),CHAR(50)) netamount,CONVERT(if(sum(l0)<0,round((sum(l0)),2),'  '),CHAR(50)) level0,"
					+ "CONVERT(if(sum(l1)<0,round((sum(l1)*-1),2),'  '),CHAR(50)) level1,CONVERT(if(sum(l2)<0,round((sum(l2)*-1),2),'  '),CHAR(50)) level2,"
					+ "CONVERT(if(sum(l3)<0,round((sum(l3)*-1),2),'  '),CHAR(50)) level3,CONVERT(if(sum(l4)<0,round((sum(l4)*-1),2),'  '),CHAR(50)) level4,"
					+ "CONVERT(if(sum(l5)<0,round((sum(l5)*-1),2),'  '),CHAR(50)) level5 from ("
					+ "select d.acno,d.brhid,d.doc_no,if(d.duedys<0 and d.bal<0,round((d.bal),2),0) l0,if(d.duedys between "+level1from+" and "+level1to+" and d.bal<0,round((d.bal),2),0) l1,"
					+ "if(d.duedys between "+level2from+" and "+level2to+"  and d.bal<0,round((d.bal),2),0) l2,if(d.duedys between "+level3from+" and "+level3to+"  and "
					+ "d.bal<0,round((d.bal),2),0) l3,if(d.duedys between "+level4from+" and "+level4to+"  and d.bal<0,round((d.bal),2),0) l4,if(d.duedys >="+level5from+"  "
					+ "and d.bal<0,round((d.bal),2),0) l5,CONVERT(if(d.bal>0,round((d.bal),2),''),CHAR(10)) U6,if(d.bal<0,d.bal,0) t7 from ";
		}
		
		sql="select 'Outstanding Statement' vouchername,(DATE_FORMAT('"+sqlUpToDate+"','%D %M  %Y ')) vouchername1,bk.address accountaddress,bk.per_mob accountmob,j.acno,t.account,"
			+ "t.description,c.company,c.address,c.tel,c.fax,b.branchname,b.pbno,b.stcno,b.cstno,l.loc_name location,cd.code from my_acbook bk left join my_jvtran j on  bk.acno=j.acno  left join "
			+ "my_head t on j.acno=t.doc_no left join my_brch b on j.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no left join my_comp c on b.cmpid=c.doc_no left join "
			+ "my_curr cd on cd.doc_no=j.curId where j.acno="+acno+" group by acno";
		
		ResultSet resultSet = stmtAgeingDueDate.executeQuery(sql);
		
		while(resultSet.next()){
			bean.setLblcompname(resultSet.getString("company"));
			bean.setLblcompaddress(resultSet.getString("address"));
			bean.setLblprintname(resultSet.getString("vouchername"));
			bean.setLblprintname1(resultSet.getString("vouchername1"));
			bean.setLblcomptel(resultSet.getString("tel"));
			bean.setLblcompfax(resultSet.getString("fax"));
			bean.setLblbranch(resultSet.getString("branchname"));
			bean.setLbllocation(resultSet.getString("location"));
			bean.setLblcstno(resultSet.getString("cstno"));
			bean.setLblpan(resultSet.getString("pbno"));
			bean.setLblservicetax(resultSet.getString("stcno"));
			
			bean.setLblaccountname(resultSet.getString("description"));
			bean.setLblaccountaddress(resultSet.getString("accountaddress"));
			bean.setLblaccountmobileno(resultSet.getString("accountmob"));
			bean.setLblcurrencycode(resultSet.getString("code"));
		}
		
		String sql1 = "";
		
		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
			sql1+=" and j.brhId="+branch+"";
		}
		
		/*sql1 = "select if(d.bal>0,round(d.bal,2),'  ') netamount,if(d.duedys <0 and d.bal>0,round((d.bal),2),'  ') level0,if(d.duedys between 0 and 30 and d.bal>0,round((d.bal),2),'  ') level1,if(d.duedys between 31 and 60 and d.bal>0,round((d.bal),2),'  ') level2,"
				+ "if(d.duedys between 61 and 90 and d.bal>0,round((d.bal),2),'  ') level3,if(d.duedys between 91 and 120 and d.bal>0,round((d.bal),2),'  ') level4,if(d.duedys > 121 and d.bal>0,round((d.bal),2),'  ') level5 "
				+ "from (select j.doc_no,j.ref_detail,j.description,DATE_FORMAT((j.date),'%d-%m-%Y') date,j.dtype,round((sum(j.dramount)),2) totalamount,round((sum(j.out_amount)),2) totalapplied,round((sum(j.dramount-j.out_amount)),2) bal,"
				+ "bk.refname name,bk.per_mob pmob,TIMESTAMPDIFF(Day,cast(j.duedate as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys from my_jvtran j inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc on "
				+ "b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno and bk.dtype='CRM' where h.atype='AR' and j.duedate<='"+sqlUpToDate+"' "
				+ "and j.acno="+acno+" and (j.dramount-j.out_amount)!=0) d";*/
		
		/*sql1 = select+" (select j.acno,j.brhid,sum(dramount) - coalesce(o.amount,0)*id bal, j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(j.duedate as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys "
			    + "from my_jvtran j inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no "
			    + "left join my_acbook bk on h.cldocno=bk.cldocno  "+condition+" left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.tranid "
			    + "where j.duedate<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid where j.status=3 and h.atype='"+atype+"' and j.duedate<='"+sqlUpToDate+"' and j.acno="+acno+""+sql1+""+sqld1+" group by j.tranid having "
			    + "bal<>0 union all select j.acno,j.brhid,sum(dramount)- coalesce(o.amount,0)*id bal, j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(j.duedate as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys "
			    + "from my_jvtran j inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join "
			    + "my_acbook bk on h.cldocno=bk.cldocno  "+condition+" left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where "
			    + "j.duedate<='"+sqlUpToDate+"' group by tranid) o on j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' and j.duedate<='"+sqlUpToDate+"' and j.acno="+acno+""+sql1+""+sqld+" group by j.tranid having bal<>0) d) ag "
			    + "group by acno";*/
				
		sql1 = select +"(select j.acno,j.brhid,h.description name,sum(dramount) - coalesce(o.amount,0)*id bal, j.tranid, j.doc_no,\r\n" + 
				"TIMESTAMPDIFF(Day,cast(coalesce(j.duedate,j.date) as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys from my_jvtran j inner join my_head h on\r\n" + 
				"j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on\r\n" + 
				"j.tranid=o.tranid where j.date<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid where j.status=3 and h.atype='"+atype+"'\r\n" + 
				"and j.date<='"+sqlUpToDate+"' and j.acno="+acno+""+sql1+""+sqld1+" group by j.tranid having bal<>0 union all select j.acno,j.brhid,h.description name,\r\n" + 
				"sum(dramount)- coalesce(o.amount,0)*id bal, j.tranid, j.doc_no,\r\n" + 
				"TIMESTAMPDIFF(Day,cast(coalesce(j.duedate,j.date) as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys from my_jvtran j inner join my_head h on\r\n" + 
				"j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on\r\n" + 
				"j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"' group by tranid) o on j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' and\r\n" + 
				"j.date<='"+sqlUpToDate+"' and j.acno="+acno+""+sql1+""+sqld+" group by j.tranid having bal<>0) d) ag group by acno";
		
		ResultSet resultSet1 = stmtAgeingDueDate.executeQuery(sql1);
		
		ArrayList<String> printarray= new ArrayList<String>();
		
		while(resultSet1.next()){
			if(!(resultSet1.getString("netamount").equalsIgnoreCase("  "))){
				bean.setThirdarray(3);
			}
			String temp="";
			temp=resultSet1.getString("netamount")+"::"+resultSet1.getString("level0")+"::"+resultSet1.getString("level1")+"::"+resultSet1.getString("level2")+"::"+resultSet1.getString("level3")+"::"+resultSet1.getString("level4")+"::"+resultSet1.getString("level5");
		    printarray.add(temp);
		}
		
		request.setAttribute("printingarray", printarray);
		
		joins=ClsCommon.getFinanceVocTablesJoins(conn);
		casestatement=ClsCommon.getFinanceVocTablesCase(conn);
		
		String sql2 = "";
		
		sql2 = "select "+casestatement+"a.* from (select j.doc_no transNo,coalesce(j.ref_detail,'') ref_detail,j.description,DATE_FORMAT(coalesce(j.duedate,j.date),'%d-%m-%Y') date,j.dtype transType,round(sum(j.dramount)*j.id,2) netamount,round(coalesce(o.amount,' '),2) applied," +
				" round((sum(dramount) - coalesce(o.amount,0)*id)*j.id,2) balance,b.branchname,TIMESTAMPDIFF(Day,cast(coalesce(j.duedate,j.date) as datetime),"
				+ "cast('"+sqlUpToDate+"' as datetime)) duedys,j.brhid from my_jvtran j inner join my_head h on j.acno=h.doc_no left join "
				+ "(select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.AP_trid " +
				" where j.date<='"+sqlUpToDate+"' group by tranid) o on j.tranid=o.tranid inner join my_brch b on j.brhId=b.doc_no where j.status=3 and h.atype='"+atype+"' and j.acno="+acno+" and j.date<='"+sqlUpToDate+"'"+sqld+" group by j.tranid having balance<>0 order by j.date) a"+joins+"";
		
		ResultSet resultSet2 = stmtAgeingDueDate.executeQuery(sql2);
		
		ArrayList<String> printunappliedarray= new ArrayList<String>();
		
		while(resultSet2.next()){
			bean.setFirstarray(1);
			String temp1="";
			temp1=resultSet2.getString("date")+"::"+resultSet2.getString("transtype")+"::"+resultSet2.getString("transno")+"::"+resultSet2.getString("ref_detail")+"::"+resultSet2.getString("description")+"::"+resultSet2.getString("netamount")+"::"+resultSet2.getString("applied")+"::"+resultSet2.getString("balance")+"::"+resultSet2.getString("duedys");
			printunappliedarray.add(temp1);
		}
		request.setAttribute("printunapplyarray", printunappliedarray);
		
		String sql3 = "";
		
		sql3 = "select "+casestatement+"a.* from (select j.doc_no transNo,coalesce(j.ref_detail,'') ref_detail,j.description,DATE_FORMAT(coalesce(j.duedate,j.date),'%d-%m-%Y') date,j.dtype transType,round(sum(j.dramount)*j.id,2) netamount,round(coalesce(o.amount,' '),2) applied," +
				" round((sum(dramount) - coalesce(o.amount,0)*id)*j.id,2) balance,b.branchname,TIMESTAMPDIFF(Day,cast(coalesce(j.duedate,j.date) as datetime),"
				+ "cast('"+sqlUpToDate+"' as datetime)) duedys,j.brhid from my_jvtran j inner join my_head h on j.acno=h.doc_no left join "
				+ "(select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.trANid " +
				" where j.date<='"+sqlUpToDate+"' group by AP_trid) o on j.tranid=o.ap_trid inner join my_brch b on j.brhId=b.doc_no where j.status=3 and h.atype='"+atype+"' and j.acno="+acno+" and j.date<='"+sqlUpToDate+"'"+sqld1+" group by j.tranid having balance<>0 order by j.date) a"+joins+"";
		
		ResultSet resultSet3 = stmtAgeingDueDate.executeQuery(sql3);
		
		ArrayList<String> printoutstandingarray= new ArrayList<String>();
		
		while(resultSet3.next()){
			bean.setSecarray(2);
			String temp2="";
			temp2=resultSet3.getString("date")+"::"+resultSet3.getString("transtype")+"::"+resultSet3.getString("transno")+"::"+resultSet3.getString("ref_detail")+"::"+resultSet3.getString("description")+"::"+resultSet3.getString("netamount")+"::"+resultSet3.getString("applied")+"::"+resultSet3.getString("balance")+"::"+resultSet3.getString("duedys");
			printoutstandingarray.add(temp2);
		}
		request.setAttribute("printoutstandingsarray", printoutstandingarray);
		
		String sql4 = "";
		
		/*sql4 = "select a.totalunappliedamount,a.totalapplied,a.unappliedbalance,b.totaloutamount,b.totaloutapplied,b.outstandingbalance,"
			+ "(coalesce(b.outstandingbalance,0)+coalesce(a.unappliedbalance,0)) nettotal from ((select round((sum(j.dramount)),2) totalunappliedamount,round((sum(o.amount)),2) totalapplied,"
			+ "round((sum(dramount) - sum(coalesce(o.amount,0))*id),2) unappliedbalance from my_jvtran j left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from "
			+ "my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"' group by tranid ) o on j.tranid=o.tranid where j.date<='"+sqlUpToDate+"' "
			+ "and j.acno="+acno+" and j.status=3 and j.id<0 order by j.date) a,(select round((sum(j.dramount)),2) totaloutamount,round((sum(o.amount)),2) totaloutapplied,"
			+ "round((sum(dramount) - sum(coalesce(o.amount,0))*id),2) outstandingbalance from my_jvtran j left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from "
			+ "my_outd o inner join my_jvtran j on j.tranid=o.tranid where j.date<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"' "
			+ "and j.acno="+acno+" and j.status=3 and j.id>0 order by j.date) b)";*/
			
		sql4 = "select round(sum(unappliedramount),2) totalunappliedamount,round(sum(unappliedoutamount),2) totalapplied,round(sum(unappliedbalance),2) unappliedbalance,round(sum(applieddramount),2) totaloutamount,"
				+ "round(sum(appliedoutamount),2) totaloutapplied,round(sum(appliedbalance),2) outstandingbalance,round(coalesce(sum(unappliedbalance),0)-coalesce(sum(appliedbalance),0),2) nettotal from (" +  
				"select 0 applieddramount,0 appliedoutamount,0 appliedbalance,round(sum(j.dramount)*j.id,2) unappliedramount,"
				+ "coalesce(o.amount,0) unappliedoutamount,round((sum(dramount) - coalesce(o.amount,0)*id)*j.id,2) unappliedbalance " +
				" from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount "
				+ "from my_outd o inner join my_jvtran j on j.tranid=o.tranid where j.date<='"+sqlUpToDate+"'" +
				" group by tranid) o on j.tranid=o.tranid inner join my_brch b on j.brhId=b.doc_no where j.status=3 and h.atype='"+atype+"' and j.acno="+acno+" and j.date<='"+sqlUpToDate+"'"+sqld+" group by j.tranid having unappliedbalance<>0 UNION ALL" +
				" select round(sum(j.dramount)*j.id,2) applieddramount,coalesce(o.amount,0)*id appliedoutamount,round((sum(dramount) - coalesce(o.amount,0)*id)*j.id,2) appliedbalance,0 unappliedramount,0 unappliedoutamount,0 unappliedbalance from my_jvtran j" +
				" inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"' group by tranid) o on j.tranid=o.ap_trid " +
				" inner join my_brch b on j.brhId=b.doc_no where j.status=3 and h.atype='"+atype+"' and j.acno="+acno+" and j.date<='"+sqlUpToDate+"'"+sqld1+" group by j.tranid having appliedbalance<>0) a";
				
		ResultSet resultSet4 = stmtAgeingDueDate.executeQuery(sql4);
		
		while(resultSet4.next()){
			bean.setLblsumnetamount(resultSet4.getString("totalunappliedamount"));
			bean.setLblsumapplied(resultSet4.getString("totalapplied"));
			bean.setLblsumbalance(resultSet4.getString("unappliedbalance"));
			
			bean.setLblsumoutnetamount(resultSet4.getString("totaloutamount"));
			bean.setLblsumoutapplied(resultSet4.getString("totaloutapplied"));
			bean.setLblsumoutbalance(resultSet4.getString("outstandingbalance"));
			
			bean.setLblnetamount(resultSet4.getString("nettotal"));
		}
		
		stmtAgeingDueDate.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}finally{
		conn.close();
	}
	return bean;
  }
	
}
