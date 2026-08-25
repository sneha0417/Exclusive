package com.dashboard.accounts.ageingstatementnew;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAgeingStatementDAO  { 
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray ageingStatement(String branch,String uptodate,String atype,String accdocno, String salesperson,String category,String clientStatus,String level1from, String level1to, String level2from, String level2to,
			String level3from, String level3to,String level4from, String level4to,String level5from,String check) throws SQLException {
       
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
        
        java.sql.Date sqlUpToDate = null;
         
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtAgeingStatement = conn.createStatement();
				
				if(check.equalsIgnoreCase("1")){
				
				 if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
					sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
				 }
				 
				String sql = "",sqld = "",sqld1 = "",select="" , sql1="",sqltest="";
				
				if(atype.equalsIgnoreCase("AR")){
					sqld=" and j.id < 0";
					sqld1=" and j.id > 0";
					sqltest="and dramount<0";
					
					/*select ="select name 'account_name',ag.contact 'contact_person',ag.pmob 'mobile_no',CONVERT(if(sum(t7+u6)<0,round((sum(t7+u6)*-1),2),''),CHAR(50)) 'advance',"
						+ "CONVERT(if(sum(t7+u6)>0,round((sum(t7+u6)),2),''),CHAR(50)) 'balance',CONVERT(if(sum(u6<0),round((sum(u6*-1)),2),''),CHAR(50)) 'unapplied', "  
						+ "CONVERT(if(sum(t7)>0,round((sum(t7)),2),''),CHAR(50)) 'total',CONVERT(if(sum(l1)>0,round((sum(l1)),2),''),CHAR(50)) 'level_1',"
						+ "CONVERT(if(sum(l2)>0,round((sum(l2)),2),''),CHAR(50)) 'level_2',CONVERT(if(sum(l3)>0,round((sum(l3)),2),''),CHAR(50)) 'level_3',"  
						+ "CONVERT(if(sum(l4)>0,round((sum(l4)),2),''),CHAR(50)) 'level_4',CONVERT(if(sum(l5)>0,round((sum(l5)),2),''),CHAR(50)) 'level_5',ag.acno 'account',"
						+ "ag.brhid 'branch_id' from (select d.name,d.mob,d.contact,d.pmob,d.acno,d.brhid,d.doc_no,if(d.duedys between "+level1from+" and "+level1to+" "
						+ "and d.bal>0,round((d.bal),2),0) l1,if(d.duedys between "+level2from+" and "+level2to+" and d.bal>0,round((d.bal),2),0) l2,if(d.duedys between "+level3from+" "
						+ "and "+level3to+" and d.bal>0,round((d.bal),2),0) l3,if(d.duedys between "+level4from+" and "+level4to+" and d.bal>0,round((d.bal),2),0) l4,"
						+ "if(d.duedys >="+level5from+" and d.bal>0,round((d.bal),2),0) l5,CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(10)) U6,if(d.bal>0,d.bal,0) t7 from ";*/
						
					select ="select f.pdcamount,g.subrcpt,a.*,bk.period2 creditperiod,bk.credit creditlimit,bk.mail1 email,if(bk.per_mob is null,bk.com_mob,if(bk.per_mob='NA',bk.com_mob,if(bk.per_mob=' ',bk.com_mob,bk.per_mob))) mobile_no,bk.contactPerson contact_person,s.sal_name from (select name 'account_name',CONVERT(if(sum(t7+u6)<0,round((sum(t7+u6)*-1),2),''),CHAR(50)) 'advance',\r\n" + 
							"CONVERT(if(sum(t7+u6)>0,round((sum(t7+u6)),2),''),CHAR(50)) 'balance',CONVERT(if(sum(u6<0),round((sum(u6*-1)),2),''),CHAR(50)) 'unapplied',\r\n" + 
							"CONVERT(if(sum(t7)>0,round((sum(t7)),2),''),CHAR(50)) 'total',CONVERT(if(sum(l1)>0,round((sum(l1)),2),''),CHAR(50)) 'level_1',\r\n" + 
							"CONVERT(if(sum(l2)>0,round((sum(l2)),2),''),CHAR(50)) 'level_2',CONVERT(if(sum(l3)>0,round((sum(l3)),2),''),CHAR(50)) 'level_3',\r\n" + 
							"CONVERT(if(sum(l4)>0,round((sum(l4)),2),''),CHAR(50)) 'level_4',CONVERT(if(sum(l5)>0,round((sum(l5)),2),''),CHAR(50)) 'level_5',\r\n" + 
							"ag.acno 'account',ag.brhid 'branch_id' from (select d.name,d.acno,d.brhid,d.doc_no,\r\n" + 
							"if(d.duedys between "+level1from+" and "+level1to+" and d.bal>0,round((d.bal),2),0) l1,if(d.duedys between "+level2from+" and "+level2to+" and d.bal>0,\r\n" + 
							"round((d.bal),2),0) l2,if(d.duedys between "+level3from+" and "+level3to+" and d.bal>0,round((d.bal),2),0) l3,if(d.duedys between "+level4from+" and "+level4to+" and d.bal>0,\r\n" + 
							"round((d.bal),2),0) l4,if(d.duedys >="+level5from+" and d.bal>0,round((d.bal),2),0) l5,CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(50)) U6,\r\n" + 
							"if(d.bal>0,d.bal,0) t7 from ";
				}
				else if(atype.equalsIgnoreCase("AP")){
					sqld=" and j.id > 0";
					sqld1=" and j.id < 0";
					sqltest="and dramount>0";
					
					/*select ="select name 'account_name',ag.contact 'contact_person',ag.pmob 'mobile_no',CONVERT(if(sum(t7+u6)>0,round((sum(t7+u6)),2),''),CHAR(50)) 'advance',"
							+ "CONVERT(if(sum(t7+u6)<0,round((sum(t7+u6)*-1),2),''),CHAR(50)) 'balance',CONVERT(if(sum(u6>0),round((sum(u6)),2),''),CHAR(50)) 'unapplied',"
							+ "CONVERT(if(sum(t7)<0,round((sum(t7)*-1),2),''),CHAR(50)) 'total',CONVERT(if(sum(l1)<0,round((sum(l1)*-1),2),''),CHAR(50)) 'level_1',"  
							+ "CONVERT(if(sum(l2)<0,round((sum(l2)*-1),2),''),CHAR(50)) 'level_2',CONVERT(if(sum(l3)<0,round((sum(l3)*-1),2),''),CHAR(50)) 'level_3',"  
							+ "CONVERT(if(sum(l4)<0,round((sum(l4)*-1),2),''),CHAR(50)) 'level_4',CONVERT(if(sum(l5)<0,round((sum(l5)*-1),2),''),CHAR(50)) 'level_5',ag.acno 'account'," 
							+ "ag.brhid 'branch_id' from (select d.name,d.mob,d.contact,d.pmob,d.acno,d.brhid,d.doc_no,if(d.duedys between "+level1from+" and "+level1to+"  "
							+ "and d.bal<0,round((d.bal),2),0) l1,if(d.duedys between "+level2from+" and "+level2to+"  and d.bal<0,round((d.bal),2),0) l2,if(d.duedys between "+level3from+" "
							+ "and "+level3to+"  and d.bal<0,round((d.bal),2),0) l3,if(d.duedys between "+level4from+" and "+level4to+"  and d.bal<0,round((d.bal),2),0) l4,"  
							+ "if(d.duedys >="+level5from+"  and d.bal<0,round((d.bal),2),0) l5,CONVERT(if(d.bal>0,round((d.bal),2),''),CHAR(10)) U6,if(d.bal<0,d.bal,0) t7 from ";*/
							
					select ="select f.pdcamount,g.subrcpt,a.*,bk.period2 creditperiod,bk.credit creditlimit,bk.mail1 email,if(bk.per_mob is null,bk.com_mob,if(bk.per_mob='NA',bk.com_mob,if(bk.per_mob=' ',bk.com_mob,bk.per_mob))) mobile_no,bk.contactPerson contact_person,s.sal_name from (select name 'account_name',CONVERT(if(sum(t7+u6)>0,round((sum(t7+u6)),2),''),CHAR(50)) 'advance',\r\n" + 
							"CONVERT(if(sum(t7+u6)<0,round((sum(t7+u6)*-1),2),''),CHAR(50)) 'balance',CONVERT(if(sum(u6>0),round((sum(u6)),2),''),CHAR(50)) 'unapplied',\r\n" + 
							"CONVERT(if(sum(t7)<0,round((sum(t7)*-1),2),''),CHAR(50)) 'total',CONVERT(if(sum(l1)<0,round((sum(l1)*-1),2),''),CHAR(50)) 'level_1',\r\n" + 
							"CONVERT(if(sum(l2)<0,round((sum(l2)*-1),2),''),CHAR(50)) 'level_2',CONVERT(if(sum(l3)<0,round((sum(l3)*-1),2),''),CHAR(50)) 'level_3',\r\n" + 
							"CONVERT(if(sum(l4)<0,round((sum(l4)*-1),2),''),CHAR(50)) 'level_4',CONVERT(if(sum(l5)<0,round((sum(l5)*-1),2),''),CHAR(50)) 'level_5',\r\n" + 
							"ag.acno 'account',ag.brhid 'branch_id' from (select d.name,d.acno,d.brhid,d.doc_no,\r\n" + 
							"if(d.duedys between "+level1from+" and "+level1to+" and d.bal<0,round((d.bal),2),0) l1,if(d.duedys between "+level2from+" and "+level2to+" and d.bal<0,\r\n" + 
							"round((d.bal),2),0) l2,if(d.duedys between "+level3from+" and "+level3to+" and d.bal<0,round((d.bal),2),0) l3,if(d.duedys between "+level4from+" and "+level4to+" and d.bal<0,\r\n" + 
							"round((d.bal),2),0) l4,if(d.duedys >="+level5from+" and d.bal<0,round((d.bal),2),0) l5,CONVERT(if(d.bal>0,round((d.bal),2),''),CHAR(50)) U6,\r\n" + 
							"if(d.bal<0,d.bal,0) t7 from ";		
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
				
				if(!(clientStatus.equalsIgnoreCase(""))){
					if(clientStatus.equalsIgnoreCase("0")){
						sql1+=" and bk.pcase=0";
					}
					else if(clientStatus.equalsIgnoreCase("1")){
						sql1+=" and bk.pcase=1";
					}
					else if(clientStatus.equalsIgnoreCase("2")){
						sql1+=" and bk.pcase=2";
					}
					else if(clientStatus.equalsIgnoreCase("3")){
						sql1+=" and bk.pcase=3";
					}
	    		}
				
				/*sql = select+" (select j.acno,j.brhid,h.description name,bk.com_mob mob,bk.per_mob pmob,bk.contactPerson contact,sum(dramount) - coalesce(o.amount,0)*id bal, j.tranid, j.doc_no,"
						+ "TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys from my_jvtran j inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc "
						+ "on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno  "+condition+" "
						+ "left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.tranid where j.date<='"+sqlUpToDate+"' group by ap_trid ) o "
						+ "on j.tranid=o.ap_trid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' "+sql+""+sqld1+" group by j.tranid having bal<>0 union all select j.acno,j.brhid,"
						+ "h.description name,bk.com_mob mob,bk.per_mob pmob,bk.contactPerson contact,sum(dramount)- coalesce(o.amount,0)*id bal, j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(j.date as datetime),"
						+ "cast('"+sqlUpToDate+"' as datetime)) duedys from my_jvtran j inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no "
						+ "inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno  "+condition+" left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o "
						+ "inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"' group by tranid) o on j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' "
						+ ""+sql+""+sqld+" group by j.tranid having bal<>0) d) ag group by acno";*/
					
				sql = select+" (select j.acno,j.brhid,h.description name,sum(dramount) - coalesce(o.amount,0)*id bal, j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys\r\n" + 
						"from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.tranid where\r\n" + 
						"j.date<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' "+sql+""+sqld1+" group by j.tranid having bal<>0 \r\n" + 
						" union all select j.acno,j.brhid,h.description name,sum(dramount)- coalesce(o.amount,0)*id bal, j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys\r\n" + 
						" from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"'\r\n" + 
						" group by tranid) o on j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"'"+sql+""+sqld+" group by j.tranid having bal<>0) d) ag group by acno ) a "+
					    " left join (select SUM(j.DRAMOUNT)pdcAmount,j.TR_NO,j.acno  from MY_JVTRAN J INNER JOIN my_CHQDET C ON J.TR_NO=C.TR_NO WHERE C.PDC=1  AND C.STATUS='E' AND J.STATUS=3  "+sql+" group by j.acno )f on f.acno=a.account "+
					    " left join (select sum(dramount) subrcpt,j.acno from my_jvtran j where date>'"+sqlUpToDate+"' "+sqltest+" "+sql+" group by j.acno)g on g.acno=a.account  left join my_acbook bk on a.account=bk.acno\r\n" +
						" and bk.status=3 left join my_salm s on bk.sal_id=s.doc_no where 1=1 "+sql1;
				System.out.println("ageing===== "+sql);
				ResultSet resultSet = stmtAgeingStatement.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				}
				
				stmtAgeingStatement.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray accountDetails(String type,String account,String partyname,String contact,String check) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	  if(!(check.equalsIgnoreCase("1"))){
		  return RESULTDATA1;
	  }
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
	            
				sql = "select a.per_mob,a.mail1 email,t.doc_no,t.account,t.description,c.code curr from my_acbook a left join my_head t on a.acno=t.doc_no "
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
	
	public  ClsAgeingStatementBean getPrint(HttpServletRequest request,String atype,int acno,String branch,String uptodate,int level1from,int level1to,int level2from,
			int level2to,int level3from,int level3to,int level4from,int level4to,int level5from) throws SQLException {
			
		ClsAgeingStatementBean bean = new ClsAgeingStatementBean();

		Connection conn = null;
		
        java.sql.Date sqlUpToDate = null;
        
	try {
		conn = ClsConnection.getMyConnection();
		Statement stmtAgeingStatement = conn.createStatement();
		
		if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
        	sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
        }
		
		String headersql="select 'Outstanding Statement' vouchername,(DATE_FORMAT('"+sqlUpToDate+"','%D %M  %Y ')) vouchername1,c.company,c.address,c.tel,c.fax,lc.loc_name "
				+ "location,b.branchname,b.pbno,b.stcno,b.cstno from my_acbook bk inner join my_jvtran j on bk.acno=j.acno inner join my_brch b on j.brhid=b.doc_no inner join "
				+ "my_comp c on bk.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by "
				+ "brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where j.acno="+acno+" group by j.acno";
				System.out.println("===== "+headersql);
				ResultSet resultSetHead = stmtAgeingStatement.executeQuery(headersql);
				
				while(resultSetHead.next()){
					bean.setLblcompname(resultSetHead.getString("company"));
					bean.setLblcompaddress(resultSetHead.getString("address"));
					bean.setLblprintname(resultSetHead.getString("vouchername"));
					bean.setLblprintname1(resultSetHead.getString("vouchername1"));
					bean.setLblcomptel(resultSetHead.getString("tel"));
					bean.setLblcompfax(resultSetHead.getString("fax"));
					bean.setLblbranch(resultSetHead.getString("branchname"));
					bean.setLbllocation(resultSetHead.getString("location"));
					bean.setLblcstno(resultSetHead.getString("cstno"));
					bean.setLblpan(resultSetHead.getString("pbno"));
					bean.setLblservicetax(resultSetHead.getString("stcno"));
				}
				
		String sql="select j.acno,coalesce(t.account,'') account,coalesce(t.description,'') description,coalesce(a.period,0) minperiod,coalesce(a.period2,0) maxperiod,coalesce(a.credit,0) creditlimit,coalesce(a.address,'') customeraddress,coalesce(a.mail1,'') customeremail,"
				+ "coalesce(a.per_mob,'') customermobile,coalesce(a.per_tel,'') customertel,coalesce(a.fax1,'') customerfax,cd.code from my_jvtran j left join my_head t on j.acno=t.doc_no left join my_acbook a on a.acno=t.doc_no left join my_curr cd on cd.doc_no=j.curId where "
				+ "j.acno="+acno+" group by acno";
		
		ResultSet resultSet = stmtAgeingStatement.executeQuery(sql);
		
		while(resultSet.next()){
						
			bean.setLblaccountno(resultSet.getString("account"));
			bean.setLblaccountname(resultSet.getString("description"));
			bean.setLblaccountaddress(resultSet.getString("customeraddress"));
			bean.setLblaccountemail(resultSet.getString("customeremail"));
			bean.setLblaccountmobileno(resultSet.getString("customermobile"));
			bean.setLblaccountphone(resultSet.getString("customertel"));
			bean.setLblaccountfax(resultSet.getString("customerfax"));
			bean.setLblcreditperiodmin(resultSet.getString("minperiod"));
			bean.setLblcreditperiodmax(resultSet.getString("maxperiod"));
			bean.setLblcreditlimit(resultSet.getString("creditlimit"));
			bean.setLblcurrencycode(resultSet.getString("code"));
		}
		
		stmtAgeingStatement.close();
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
