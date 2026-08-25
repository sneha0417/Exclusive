package com.dashboard.accounts.currentageingstatement;

 import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsCurrentAgeingDAO  { 
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray currentAgeing(String branch,String uptodate,String atype,String accdocno, String salesperson,String category,String level1from, String level1to, String level2from, String level2to,
			String level3from, String level3to,String level4from, String level4to,String level5from,String check) throws SQLException {
       
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
        
        java.sql.Date sqlUpToDate = null;
        if(!(check.equalsIgnoreCase("1")))
        {
        	return RESULTDATA;
        }
        
        if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
              sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
        }
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCurrentAgeing = conn.createStatement();
				
				if(sqlUpToDate!=null){
				
				String sql = "",sql1="";
					
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

				if(atype.equalsIgnoreCase("AR")){
					
					/*sql = "select ag.acno,ag.brhid,name,ag.contact,ag.pmob,CONVERT(if(sum(t7+u6)<0,round((sum(t7+u6)*-1),2),''),CHAR(50)) advance,CONVERT(if(sum(u6<0),round((sum(u6*-1)),2),''),CHAR(50)) unapplied,"
							+ "CONVERT(if(sum(t7+u6)>0,round((sum(t7+u6)),2),''),CHAR(50)) balance,"
							+ "CONVERT(if(sum(t7)>0,round((sum(t7)),2),''),CHAR(50)) netamount,CONVERT(if(sum(l1)>0,round((sum(l1)),2),''),CHAR(50)) level1,"
							+ "CONVERT(if(sum(l2)>0,round((sum(l2)),2),''),CHAR(50)) level2,CONVERT(if(sum(l3)>0,round((sum(l3)),2),''),CHAR(50)) level3,CONVERT(if(sum(l4)>0,round((sum(l4)),2),''),CHAR(50)) level4,"
							+ "CONVERT(if(sum(l5)>0,round((sum(l5)),2),''),CHAR(50)) level5 from (select d.name,d.mob,d.contact,d.pmob,d.acno,d.brhid,d.doc_no,if(d.duedys between "+level1from+" and "+level1to+" and d.bal>0,round((d.bal),2),0) l1,"
							+ "if(d.duedys between "+level2from+" and "+level2to+" and d.bal>0,round((d.bal),2),0) l2,if(d.duedys between "+level3from+" and "+level3to+" and d.bal>0,round((d.bal),2),0) l3,"
							+ " if(d.duedys between "+level4from+" and "+level4to+" and d.bal>0,round((d.bal),2),0) l4,"
							+ "if(d.duedys >="+level5from+" and d.bal>0,round((d.bal),2),0) l5,CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(50)) U6,if(d.bal>0,d.bal,0) t7 from (select j.acno,j.brhid,h.description name,bk.com_mob mob,bk.per_mob pmob,"
							+ "bk.contactPerson contact,sum(dramount-out_amount) bal, j.tranid, j.doc_no,"
							+ "TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys from my_jvtran j inner join "
							+ "my_brch b on j.brhId=b.doc_no inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "
							+ " and bk.dtype='CRM' where j.status=3 and h.atype='AR' and j.yrid=0 and j.date<='"+sqlUpToDate+"' "+sql+" group by tranid having bal<>0) d) ag group by acno";*/
				    
					sql = "select a.*,bk.contactPerson 'contact',if(bk.per_mob is null,bk.com_mob,if(bk.per_mob='NA',bk.com_mob,if(bk.per_mob=' ',bk.com_mob,bk.per_mob))) pmob,s.sal_name from (select ag.account,ag.name,ag.acno,ag.brhid,CONVERT(if(sum(t7+u6)<0,round((sum(t7+u6)*-1),2),''),CHAR(50)) advance,\r\n" + 
							"CONVERT(if(sum(u6<0),round((sum(u6*-1)),2),''),CHAR(50)) unapplied,\r\n" + 
							"CONVERT(if(sum(t7+u6)>0,round((sum(t7+u6)),2),''),CHAR(50)) balance,\r\n" + 
							"CONVERT(if(sum(t7)>0,round((sum(t7)),2),''),CHAR(50)) netamount,\r\n" + 
							"CONVERT(if(sum(l1)>0,round((sum(l1)),2),''),CHAR(50)) level1,\r\n" + 
							"CONVERT(if(sum(l2)>0,round((sum(l2)),2),''),CHAR(50)) level2,\r\n" + 
							"CONVERT(if(sum(l3)>0,round((sum(l3)),2),''),CHAR(50)) level3,\r\n" + 
							"CONVERT(if(sum(l4)>0,round((sum(l4)),2),''),CHAR(50)) level4,\r\n" + 
							"CONVERT(if(sum(l5)>0,round((sum(l5)),2),''),CHAR(50)) level5 from\r\n" + 
							"(select d.account,d.name,d.acno,d.brhid,d.doc_no,if(d.duedys between "+level1from+" and "+level1to+" and d.bal>0,round((d.bal),2),0) l1,\r\n" + 
							"if(d.duedys between "+level2from+" and "+level2to+" and d.bal>0,round((d.bal),2),0) l2,if(d.duedys between "+level3from+" and "+level3to+" and d.bal>0,round((d.bal),2),0) l3,\r\n" + 
							"if(d.duedys between "+level4from+" and "+level4to+" and d.bal>0,round((d.bal),2),0) l4,if(d.duedys >="+level5from+" and d.bal>0,round((d.bal),2),0) l5,\r\n" + 
							"CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(50)) U6,if(d.bal>0,d.bal,0) t7 from\r\n" + 
							"(select j.acno,j.brhid,h.account,h.description name,sum(dramount-out_amount) bal,\r\n" + 
							"j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys from my_jvtran j\r\n" + 
							" inner join my_head h on j.acno=h.doc_no\r\n" + 
							" where j.status=3 and\r\n" + 
							" h.atype='AR' and j.date<='"+sqlUpToDate+"'"+sql+" group by tranid having bal<>0) d) ag group by acno) a\r\n" + 
							"left join my_acbook bk on a.acno=bk.acno and bk.status=3 left join my_salm s on bk.sal_id=s.doc_no where 1=1"+sql1+"";
							
				}
				else if(atype.equalsIgnoreCase("AP")){
					/*sql="select ag.acno,ag.brhid,name,ag.contact,ag.pmob,CONVERT(if(sum(t7+u6)>0,round((sum(t7+u6)),2),''),CHAR(50)) advance,\r\n" + 
							  "CONVERT(if(sum(u6>0),round((sum(u6)),2),''),CHAR(50)) unapplied,\r\n" + 
							  "CONVERT(if(sum(t7+u6)<0,round((sum(t7+u6)*-1),2),''),CHAR(50)) balance,\r\n" + 
							  "CONVERT(if(sum(t7)<0,round((sum(t7)*-1),2),''),CHAR(50)) netamount,\r\n" + 
							  "CONVERT(if(sum(l1)<0,round((sum(l1)*-1),2),''),CHAR(50)) level1,CONVERT(if(sum(l2)<0,round((sum(l2)*-1),2),''),CHAR(50)) level2,\r\n" + 
							  "CONVERT(if(sum(l3)<0,round((sum(l3)*-1),2),''),CHAR(50)) level3,CONVERT(if(sum(l4)<0,round((sum(l4)*-1),2),''),CHAR(50)) level4,\r\n" + 
							  "CONVERT(if(sum(l5)<0,round((sum(l5)*-1),2),''),CHAR(50)) level5 from\r\n" + 
							  "(select d.name,d.mob,d.contact,d.pmob,d.acno,d.brhid,\r\n" + 
							  "d.doc_no,if(d.duedys between "+level1from+" and "+level1to+" and d.bal<0,round((d.bal),2),0) l1,\r\n" + 
							  "if(d.duedys between "+level2from+" and "+level2to+" and d.bal<0,round((d.bal),2),0) l2,if(d.duedys between  "+level3from+" and "+level3to+" and d.bal<0,round((d.bal),2),0) l3,\r\n" + 
							  "if(d.duedys between "+level4from+" and "+level4to+" and d.bal<0,round((d.bal),2),0) l4,if(d.duedys >="+level5from+" and d.bal<0,round((d.bal),2),0) l5,\r\n" + 
							  "CONVERT(if(d.bal>0,round((d.bal),2),''),CHAR(50)) U6,if(d.bal<0,d.bal,0) t7 from (\r\n" + 
							  "select j.acno,j.brhid,h.description name,\r\n" + 
							  "bk.com_mob mob,bk.per_mob pmob,bk.contactPerson contact,sum(dramount-out_amount) bal, j.tranid, j.doc_no,\r\n" + 
							  "TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys from my_jvtran j inner join\r\n" + 
							  "my_brch b on j.brhId=b.doc_no inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no\r\n" + 
							  "inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno  and bk.dtype='VND' where\r\n" + 
							  "j.status=3 and h.atype='AP' and j.yrid=0 and j.date<='"+sqlUpToDate+"' "+sql+"  group by tranid having bal<>0) d) ag group by acno";*/
							  
					sql = "select a.*,bk.contactPerson 'contact',if(bk.per_mob is null,bk.com_mob,if(bk.per_mob='NA',bk.com_mob,if(bk.per_mob=' ',bk.com_mob,bk.per_mob))) pmob,s.sal_name from (select ag.account,ag.name,ag.acno,ag.brhid,CONVERT(if(sum(t7+u6)>0,round((sum(t7+u6)),2),''),CHAR(50)) advance,\r\n" + 
							"CONVERT(if(sum(u6>0),round((sum(u6)),2),''),CHAR(50)) unapplied,\r\n" + 
							"CONVERT(if(sum(t7+u6)<0,round((sum(t7+u6))*-1,2),''),CHAR(50)) balance,\r\n" + 
							"CONVERT(if(sum(t7)<0,round((sum(t7)*-1),2),''),CHAR(50)) netamount,\r\n" + 
							"CONVERT(if(sum(l1)<0,round((sum(l1)*-1),2),''),CHAR(50)) level1,\r\n" + 
							"CONVERT(if(sum(l2)<0,round((sum(l2)*-1),2),''),CHAR(50)) level2,\r\n" + 
							"CONVERT(if(sum(l3)<0,round((sum(l3)*-1),2),''),CHAR(50)) level3,\r\n" + 
							"CONVERT(if(sum(l4)<0,round((sum(l4)*-1),2),''),CHAR(50)) level4,\r\n" + 
							"CONVERT(if(sum(l5)<0,round((sum(l5)*-1),2),''),CHAR(50)) level5 from\r\n" + 
							"(select d.account,d.name,d.acno,d.brhid,d.doc_no,if(d.duedys between "+level1from+" and "+level1to+" and d.bal<0,round((d.bal),2),0) l1,\r\n" + 
							"if(d.duedys between "+level2from+" and "+level2to+" and d.bal<0,round((d.bal),2),0) l2,if(d.duedys between "+level3from+" and "+level3to+" and d.bal<0,round((d.bal),2),0) l3,\r\n" + 
							"if(d.duedys between "+level4from+" and "+level4to+" and d.bal<0,round((d.bal),2),0) l4,if(d.duedys >="+level5from+" and d.bal<0,round((d.bal),2),0) l5,\r\n" + 
							"CONVERT(if(d.bal>0,round((d.bal),2),''),CHAR(50)) U6,if(d.bal<0,d.bal,0) t7 from\r\n" + 
							"(select j.acno,j.brhid,h.account,h.description name,sum(dramount-out_amount) bal,\r\n" + 
							"j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys from my_jvtran j\r\n" + 
							" inner join my_head h on j.acno=h.doc_no\r\n" + 
							" where j.status=3 and\r\n" + 
							" h.atype='AP' and j.date<='"+sqlUpToDate+"'"+sql+" group by tranid having bal<>0) d) ag group by acno) a\r\n" + 
							"left join my_acbook bk on a.acno=bk.acno and bk.status=3 left join my_salm s on bk.sal_id=s.doc_no where 1=1"+sql1+"";
					
				  }
				System.out.println("=======sql "+sql);
				ResultSet resultSet = stmtCurrentAgeing.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				}
				stmtCurrentAgeing.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray currentAgeingExcelExport(String branch,String uptodate,String atype,String accdocno, String salesperson,String category,String level1from, String level1to, String level2from, String level2to,
			String level3from, String level3to,String level4from, String level4to,String level5from,String check) throws SQLException {
       
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
        
        java.sql.Date sqlUpToDate = null;
        if(!(check.equalsIgnoreCase("1")))
        {
        	return RESULTDATA;
        }
        if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
              sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
        }
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCurrentAgeing = conn.createStatement();
				
				if(sqlUpToDate!=null){
				
				String sql = "",sql1="";
					
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

				if(atype.equalsIgnoreCase("AR")){
					
					sql = "select a.account 'Account',a.name 'Account Name',bk.contactPerson 'Contact Person',if(bk.per_mob is null,bk.com_mob,if(bk.per_mob='NA',bk.com_mob,if(bk.per_mob=' ',bk.com_mob,bk.per_mob))) 'Mobile No',a.advance 'Advance',a.balance 'Balance',a.unapplied 'Unapplied',\r\n" +
							" a.netamount 'Total',a.level1 'Level 1',a.level2 'Level 2',a.level3 'Level 3',a.level4 'Level 4',a.level5 'Level 5',s.sal_name 'Sales Person' from (select ag.account,ag.name,ag.acno,ag.brhid,CONVERT(if(sum(t7+u6)<0,round((sum(t7+u6)*-1),2),''),CHAR(50)) advance,\r\n" + 
							" CONVERT(if(sum(u6<0),round((sum(u6*-1)),2),''),CHAR(50)) unapplied,CONVERT(if(sum(t7+u6)>0,round((sum(t7+u6)),2),''),CHAR(50)) balance,CONVERT(if(sum(t7)>0,round((sum(t7)),2),''),CHAR(50)) netamount,CONVERT(if(sum(l1)>0,round((sum(l1)),2),''),CHAR(50)) level1,\r\n" +
							" CONVERT(if(sum(l2)>0,round((sum(l2)),2),''),CHAR(50)) level2,CONVERT(if(sum(l3)>0,round((sum(l3)),2),''),CHAR(50)) level3,CONVERT(if(sum(l4)>0,round((sum(l4)),2),''),CHAR(50)) level4,CONVERT(if(sum(l5)>0,round((sum(l5)),2),''),CHAR(50)) level5 from\r\n" + 
							" (select d.account,d.name,d.acno,d.brhid,d.doc_no,if(d.duedys between "+level1from+" and "+level1to+" and d.bal>0,round((d.bal),2),0) l1,if(d.duedys between "+level2from+" and "+level2to+" and d.bal>0,round((d.bal),2),0) l2,if(d.duedys between "+level3from+" and "+level3to+" and d.bal>0,round((d.bal),2),0) l3,\r\n" + 
							" if(d.duedys between "+level4from+" and "+level4to+" and d.bal>0,round((d.bal),2),0) l4,if(d.duedys >="+level5from+" and d.bal>0,round((d.bal),2),0) l5,CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(50)) U6,if(d.bal>0,d.bal,0) t7 from\r\n" + 
							" (select j.acno,j.brhid,h.account,h.description name,sum(dramount-out_amount) bal,j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys from my_jvtran j\r\n" + 
							" inner join my_head h on j.acno=h.doc_no  where j.status=3 and h.atype='AR' and j.date<='"+sqlUpToDate+"'"+sql+" group by tranid having bal<>0) d) ag group by acno) a\r\n" + 
							" left join my_acbook bk on a.acno=bk.acno and bk.status=3 left join my_salm s on bk.sal_id=s.doc_no where 1=1"+sql1+"";
							
				}
				else if(atype.equalsIgnoreCase("AP")){

					sql = "select a.account 'Account',a.name 'Account Name',bk.contactPerson 'Contact Person',if(bk.per_mob is null,bk.com_mob,if(bk.per_mob='NA',bk.com_mob,if(bk.per_mob=' ',bk.com_mob,bk.per_mob))) 'Mobile No',a.advance 'Advance',a.balance 'Balance',a.unapplied 'Unapplied',\r\n" +
							" a.netamount 'Total',a.level1 'Level 1',a.level2 'Level 2',a.level3 'Level 3',a.level4 'Level 4',a.level5 'Level 5',s.sal_name 'Sales Person' from (select ag.account,ag.name,ag.acno,ag.brhid,CONVERT(if(sum(t7+u6)>0,round((sum(t7+u6)),2),''),CHAR(50)) advance,\r\n" + 
							" CONVERT(if(sum(u6>0),round((sum(u6)),2),''),CHAR(50)) unapplied,CONVERT(if(sum(t7+u6)<0,round((sum(t7+u6))*-1,2),''),CHAR(50)) balance,CONVERT(if(sum(t7)<0,round((sum(t7)*-1),2),''),CHAR(50)) netamount,CONVERT(if(sum(l1)<0,round((sum(l1)*-1),2),''),CHAR(50)) level1,\r\n" + 
							" CONVERT(if(sum(l2)<0,round((sum(l2)*-1),2),''),CHAR(50)) level2,CONVERT(if(sum(l3)<0,round((sum(l3)*-1),2),''),CHAR(50)) level3,CONVERT(if(sum(l4)<0,round((sum(l4)*-1),2),''),CHAR(50)) level4,CONVERT(if(sum(l5)<0,round((sum(l5)*-1),2),''),CHAR(50)) level5 from\r\n" + 
							" (select d.account,d.name,d.acno,d.brhid,d.doc_no,if(d.duedys between "+level1from+" and "+level1to+" and d.bal<0,round((d.bal),2),0) l1,if(d.duedys between "+level2from+" and "+level2to+" and d.bal<0,round((d.bal),2),0) l2,if(d.duedys between "+level3from+" and "+level3to+" and d.bal<0,round((d.bal),2),0) l3,\r\n" + 
							" if(d.duedys between "+level4from+" and "+level4to+" and d.bal<0,round((d.bal),2),0) l4,if(d.duedys >="+level5from+" and d.bal<0,round((d.bal),2),0) l5,CONVERT(if(d.bal>0,round((d.bal),2),''),CHAR(50)) U6,if(d.bal<0,d.bal,0) t7 from\r\n" + 
							" (select j.acno,j.brhid,h.account,h.description name,sum(dramount-out_amount) bal,j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys from my_jvtran j\r\n" + 
							" inner join my_head h on j.acno=h.doc_no where j.status=3 and h.atype='AP' and j.date<='"+sqlUpToDate+"'"+sql+" group by tranid having bal<>0) d) ag group by acno) a\r\n" + 
							" left join my_acbook bk on a.acno=bk.acno and bk.status=3 left join my_salm s on bk.sal_id=s.doc_no where 1=1"+sql1+"";
					
				  }
				
				ResultSet resultSet = stmtCurrentAgeing.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				
				}
				stmtCurrentAgeing.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public  JSONArray accountDetails(String type,String account,String partyname,String contact) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtCurrentAgeing1 = conn.createStatement();
			
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
				
				ResultSet resultSet1 = stmtCurrentAgeing1.executeQuery(sql);
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtCurrentAgeing1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public     ClsCurrentAgeingBean getPrint(String branch,String uptodate,String atype,String accdocno, String salesperson,String category,String level1from, String level1to, String level2from, String level2to,
			String level3from, String level3to,String level4from, String level4to,String level5from,String check) throws SQLException {
		ClsCurrentAgeingBean bean = new ClsCurrentAgeingBean();
		  Connection conn = null;
		  java.sql.Date sqlUpToDate = null;
		  if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
              sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
        }
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCurrentAgeing = conn.createStatement();
				
				if(sqlUpToDate!=null){
				
				String sql = "",sql1="";
					
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

				if(atype.equalsIgnoreCase("AR")){
					
					/*sql = "select ag.acno,ag.brhid,name,ag.contact,ag.pmob,CONVERT(if(sum(t7+u6)<0,round((sum(t7+u6)*-1),2),''),CHAR(50)) advance,CONVERT(if(sum(u6<0),round((sum(u6*-1)),2),''),CHAR(50)) unapplied,"
							+ "CONVERT(if(sum(t7+u6)>0,round((sum(t7+u6)),2),''),CHAR(50)) balance,"
							+ "CONVERT(if(sum(t7)>0,round((sum(t7)),2),''),CHAR(50)) netamount,CONVERT(if(sum(l1)>0,round((sum(l1)),2),''),CHAR(50)) level1,"
							+ "CONVERT(if(sum(l2)>0,round((sum(l2)),2),''),CHAR(50)) level2,CONVERT(if(sum(l3)>0,round((sum(l3)),2),''),CHAR(50)) level3,CONVERT(if(sum(l4)>0,round((sum(l4)),2),''),CHAR(50)) level4,"
							+ "CONVERT(if(sum(l5)>0,round((sum(l5)),2),''),CHAR(50)) level5 from (select d.name,d.mob,d.contact,d.pmob,d.acno,d.brhid,d.doc_no,if(d.duedys between "+level1from+" and "+level1to+" and d.bal>0,round((d.bal),2),0) l1,"
							+ "if(d.duedys between "+level2from+" and "+level2to+" and d.bal>0,round((d.bal),2),0) l2,if(d.duedys between "+level3from+" and "+level3to+" and d.bal>0,round((d.bal),2),0) l3,"
							+ " if(d.duedys between "+level4from+" and "+level4to+" and d.bal>0,round((d.bal),2),0) l4,"
							+ "if(d.duedys >="+level5from+" and d.bal>0,round((d.bal),2),0) l5,CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(50)) U6,if(d.bal>0,d.bal,0) t7 from (select j.acno,j.brhid,h.description name,bk.com_mob mob,bk.per_mob pmob,"
							+ "bk.contactPerson contact,sum(dramount-out_amount) bal, j.tranid, j.doc_no,"
							+ "TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys from my_jvtran j inner join "
							+ "my_brch b on j.brhId=b.doc_no inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "
							+ " and bk.dtype='CRM' where j.status=3 and h.atype='AR' and j.yrid=0 and j.date<='"+sqlUpToDate+"' "+sql+" group by tranid having bal<>0) d) ag group by acno";*/
				    
					sql = "select @i:=@i+1 as srno,b.*from(select a.*,bk.contactPerson 'contact',if(bk.per_mob is null,bk.com_mob,if(bk.per_mob='NA',bk.com_mob,if(bk.per_mob=' ',bk.com_mob,bk.per_mob))) pmob,s.sal_name from (select ag.account,ag.name,ag.acno,ag.brhid,if(sum(t7+u6)<0,round((sum(t7+u6)*-1),2),0) advance,\r\n" + 
							"if(sum(u6<0),round((sum(u6*-1)),2),0) unapplied,\r\n" + 
							"if(sum(t7+u6)>0,round((sum(t7+u6)),2),0) balance,\r\n" + 
							"if(sum(t7)>0,round((sum(t7)),2),0) netamount,\r\n" + 
							"if(sum(l1)>0,round((sum(l1)),2),0) level1,\r\n" + 
							"if(sum(l2)>0,round((sum(l2)),2),0) level2,\r\n" + 
							"if(sum(l3)>0,round((sum(l3)),2),0) level3,\r\n" + 
							"if(sum(l4)>0,round((sum(l4)),2),0) level4,\r\n" + 
							"if(sum(l5)>0,round((sum(l5)),2),0) level5 from\r\n" + 
							"(select d.account,d.name,d.acno,d.brhid,d.doc_no,if(d.duedys between "+level1from+" and "+level1to+" and d.bal>0,round((d.bal),2),0) l1,\r\n" + 
							"if(d.duedys between "+level2from+" and "+level2to+" and d.bal>0,round((d.bal),2),0) l2,if(d.duedys between "+level3from+" and "+level3to+" and d.bal>0,round((d.bal),2),0) l3,\r\n" + 
							"if(d.duedys between "+level4from+" and "+level4to+" and d.bal>0,round((d.bal),2),0) l4,if(d.duedys >="+level5from+" and d.bal>0,round((d.bal),2),0) l5,\r\n" + 
							"CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(50)) U6,if(d.bal>0,d.bal,0) t7 from\r\n" + 
							"(select j.acno,j.brhid,h.account,h.description name,sum(dramount-out_amount) bal,\r\n" + 
							"j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys from my_jvtran j\r\n" + 
							" inner join my_head h on j.acno=h.doc_no\r\n" + 
							" where j.status=3 and\r\n" + 
							" h.atype='AR' and j.date<='"+sqlUpToDate+"'"+sql+" group by tranid having bal<>0) d) ag group by acno) a\r\n" + 
							"left join my_acbook bk on a.acno=bk.acno and bk.status=3 left join my_salm s on bk.sal_id=s.doc_no where 1=1"+sql1+") b,(select @i:=0) r";
							
				}
				else if(atype.equalsIgnoreCase("AP")){
					/*sql="select ag.acno,ag.brhid,name,ag.contact,ag.pmob,CONVERT(if(sum(t7+u6)>0,round((sum(t7+u6)),2),''),CHAR(50)) advance,\r\n" + 
							  "CONVERT(if(sum(u6>0),round((sum(u6)),2),''),CHAR(50)) unapplied,\r\n" + 
							  "CONVERT(if(sum(t7+u6)<0,round((sum(t7+u6)*-1),2),''),CHAR(50)) balance,\r\n" + 
							  "CONVERT(if(sum(t7)<0,round((sum(t7)*-1),2),''),CHAR(50)) netamount,\r\n" + 
							  "CONVERT(if(sum(l1)<0,round((sum(l1)*-1),2),''),CHAR(50)) level1,CONVERT(if(sum(l2)<0,round((sum(l2)*-1),2),''),CHAR(50)) level2,\r\n" + 
							  "CONVERT(if(sum(l3)<0,round((sum(l3)*-1),2),''),CHAR(50)) level3,CONVERT(if(sum(l4)<0,round((sum(l4)*-1),2),''),CHAR(50)) level4,\r\n" + 
							  "CONVERT(if(sum(l5)<0,round((sum(l5)*-1),2),''),CHAR(50)) level5 from\r\n" + 
							  "(select d.name,d.mob,d.contact,d.pmob,d.acno,d.brhid,\r\n" + 
							  "d.doc_no,if(d.duedys between "+level1from+" and "+level1to+" and d.bal<0,round((d.bal),2),0) l1,\r\n" + 
							  "if(d.duedys between "+level2from+" and "+level2to+" and d.bal<0,round((d.bal),2),0) l2,if(d.duedys between  "+level3from+" and "+level3to+" and d.bal<0,round((d.bal),2),0) l3,\r\n" + 
							  "if(d.duedys between "+level4from+" and "+level4to+" and d.bal<0,round((d.bal),2),0) l4,if(d.duedys >="+level5from+" and d.bal<0,round((d.bal),2),0) l5,\r\n" + 
							  "format(if(d.bal>0,round((d.bal),2),''),CHAR(50)) U6,if(d.bal<0,d.bal,0) t7 from (\r\n" + 
							  "select j.acno,j.brhid,h.description name,\r\n" + 
							  "bk.com_mob mob,bk.per_mob pmob,bk.contactPerson contact,sum(dramount-out_amount) bal, j.tranid, j.doc_no,\r\n" + 
							  "TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys from my_jvtran j inner join\r\n" + 
							  "my_brch b on j.brhId=b.doc_no inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no\r\n" + 
							  "inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno  and bk.dtype='VND' where\r\n" + 
							  "j.status=3 and h.atype='AP' and j.yrid=0 and j.date<='"+sqlUpToDate+"' "+sql+"  group by tranid having bal<>0) d) ag group by acno";*/
							  
					sql = "select @i:=@i+1 as srno,b.*from(select a.*,bk.contactPerson 'contact',if(bk.per_mob is null,bk.com_mob,if(bk.per_mob='NA',bk.com_mob,if(bk.per_mob=' ',bk.com_mob,bk.per_mob))) pmob,s.sal_name from (select ag.account,ag.name,ag.acno,ag.brhid,if(sum(t7+u6)>0,round((sum(t7+u6)),2),0) advance,\r\n" + 
							"if(sum(u6>0),round((sum(u6)),2),0) unapplied,\r\n" + 
							"if(sum(t7+u6)<0,round((sum(t7+u6))*-1,2),0) balance,\r\n" + 
							"if(sum(t7)<0,round((sum(t7)*-1),2),0) netamount,\r\n" + 
							"if(sum(l1)<0,round((sum(l1)*-1),2),0) level1,\r\n" + 
							"if(sum(l2)<0,round((sum(l2)*-1),2),0) level2,\r\n" + 
							"if(sum(l3)<0,round((sum(l3)*-1),2),0) level3,\r\n" + 
							"if(sum(l4)<0,round((sum(l4)*-1),2),0) level4,\r\n" + 
							"if(sum(l5)<0,round((sum(l5)*-1),2),0) level5 from\r\n" + 
							"(select d.account,d.name,d.acno,d.brhid,d.doc_no,if(d.duedys between "+level1from+" and "+level1to+" and d.bal<0,round((d.bal),2),0) l1,\r\n" + 
							"if(d.duedys between "+level2from+" and "+level2to+" and d.bal<0,round((d.bal),2),0) l2,if(d.duedys between "+level3from+" and "+level3to+" and d.bal<0,round((d.bal),2),0) l3,\r\n" + 
							"if(d.duedys between "+level4from+" and "+level4to+" and d.bal<0,round((d.bal),2),0) l4,if(d.duedys >="+level5from+" and d.bal<0,round((d.bal),2),0) l5,\r\n" + 
							"CONVERT(if(d.bal>0,round((d.bal),2),''),CHAR(50)) U6,if(d.bal<0,d.bal,0) t7 from\r\n" + 
							"(select j.acno,j.brhid,h.account,h.description name,sum(dramount-out_amount) bal,\r\n" + 
							"j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys from my_jvtran j\r\n" + 
							" inner join my_head h on j.acno=h.doc_no\r\n" + 
							" where j.status=3 and\r\n" + 
							" h.atype='AP' and j.date<='"+sqlUpToDate+"'"+sql+" group by tranid having bal<>0) d) ag group by acno) a\r\n" + 
							"left join my_acbook bk on a.acno=bk.acno and bk.status=3 left join my_salm s on bk.sal_id=s.doc_no where 1=1"+sql1+") b,(select @i:=0) r";
					
				  }
				
				
				System.out.println("=======sqlp "+sql);
				bean.setPqry(sql);
				
				String compqry="select c.company,c.address,c.tel,c.fax,b.branchname from my_brch b   left join my_comp c on b.doc_no=c.comp_id where c.comp_id=1";
				Statement stmt=conn.createStatement();
				ResultSet rs=stmt.executeQuery(compqry);
				while(rs.next()){
					bean.setLblcompname(rs.getString("company"));
					bean.setLblcompfax(rs.getString("fax"));
					bean.setLblcompaddress(rs.getString("address"));
					bean.setLblcomptel(rs.getString("tel"));
					bean.setLblbranch(rs.getString("branchname"));
					
				}
				
				}
				stmtCurrentAgeing.close();
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
