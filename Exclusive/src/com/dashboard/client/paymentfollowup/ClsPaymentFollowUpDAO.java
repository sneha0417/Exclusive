 package com.dashboard.client.paymentfollowup;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsPaymentFollowUpDAO  {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray paymentFollowUpGridLoading(String branch,String uptodate,String clientaccount,String chkfollowup,String followupdate,String salesperson,String category,String amtrangefrm,String amtrangeto,String clientStatus,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
       
        Connection conn = null;
       
		java.sql.Date sqlUpToDate = null;
        java.sql.Date sqlFollowUpDate = null;
		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				
				if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
					sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
				}
        
				if(!(followupdate.equalsIgnoreCase("undefined")) && !(followupdate.equalsIgnoreCase("")) && !(followupdate.equalsIgnoreCase("0"))){
					sqlFollowUpDate = ClsCommon.changeStringtoSqlDate(followupdate);
				}
				
				if(sqlUpToDate!=null){

			    String sql = "";String sql1 = "";String sql2 = "";String sql3 = "";
				
				if(chkfollowup.equalsIgnoreCase("1")){
					if(!(sqlFollowUpDate==null)){
			        	sql2+=" and bv.fdate<='"+sqlFollowUpDate+"'";
					}
				}
				
				if(!(clientaccount.equalsIgnoreCase("0")) && !(clientaccount.equalsIgnoreCase(""))){
					sql+=" and j.acno="+clientaccount+"";
	            }
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhid="+branch+"";
	    		}
				
				if(!(salesperson.equalsIgnoreCase(""))){
	    			sql3+=" and bk.sal_id="+salesperson+"";
	    		}
				
				if(!(category.equalsIgnoreCase(""))){
	    			sql3+=" and bk.catid="+category+"";
	    		}
				
				if(!(((amtrangefrm.equalsIgnoreCase("")) && (amtrangeto.equalsIgnoreCase(""))) || ((amtrangefrm.equalsIgnoreCase("0")) && (amtrangeto.equalsIgnoreCase("0"))) )){
	    			sql1+=" having balance between "+amtrangefrm+" and "+amtrangeto+"";
	    		}
				
				if(!(clientStatus.equalsIgnoreCase(""))){
					if(clientStatus.equalsIgnoreCase("1")){
						sql3+=" and (bk.rostatus!=0 or bk.lostatus!=0)  and bk.pcase=0";
					}
					else if(clientStatus.equalsIgnoreCase("2")){
						sql3+=" and (bk.rostatus=0 and bk.lostatus=0)  and bk.pcase=0";
					}
					else if(clientStatus.equalsIgnoreCase("3")){
						sql3+=" and (bk.rostatus!=0 or bk.lostatus!=0) and bk.pcase=1";
					}
					else if(clientStatus.equalsIgnoreCase("4")){
						sql3+="  and (bk.rostatus=0 and bk.lostatus=0) and bk.pcase=1";
					}
					else if(clientStatus.equalsIgnoreCase("5")){
						sql3+=" and (bk.rostatus!=0 or bk.lostatus!=0) and bk.pcase=2";
					}
					else if(clientStatus.equalsIgnoreCase("6")){
						sql3+="  and (bk.rostatus=0 and bk.lostatus=0) and bk.pcase=2";
					}
					else if(clientStatus.equalsIgnoreCase("7")){
						sql3+=" and bk.pcase=3";
					}
	    		}
					
				sql = "select CONVERT(coalesce(bv.fdate,''),CHAR(100)) fdate,a.*,bk.cldocno,bk.contactPerson 'contact',if(bk.per_mob is null,bk.com_mob,bk.per_mob) pmob,bk.mail1 email,s.sal_name from ( select ag.name,ag.acno,ag.brhid,ag.doc_no,CONVERT(if(sum(t7+u6)<0,round((sum(t7+u6)*-1),2),''),CHAR(50)) advance,\r\n" + 
					" CONVERT(if(sum(u6<0),round((sum(u6*-1)),2),''),CHAR(50)) unapplied,CONVERT(if(sum(t7+u6)>0,round((sum(t7+u6)),2),''),CHAR(50)) balance,CONVERT(if(sum(t7)>0,round((sum(t7)),2),''),CHAR(50)) netamount,CONVERT(if(sum(l1)>0,round((sum(l1)),2),''),CHAR(50)) level1,\r\n" + 
					" CONVERT(if(sum(l2)>0,round((sum(l2)),2),''),CHAR(50)) level2,CONVERT(if(sum(l3)>0,round((sum(l3)),2),''),CHAR(50)) level3,CONVERT(if(sum(l4)>0,round((sum(l4)),2),''),CHAR(50)) level4,CONVERT(if(sum(l5)>0,round((sum(l5)),2),''),CHAR(50)) level5 from (\r\n" +
					" select d.name,d.acno,d.brhid,d.doc_no,if(d.duedys between 0 and 30 and d.bal>0,round((d.bal),2),0) l1,if(d.duedys between 31 and 60 and d.bal>0,round((d.bal),2),0) l2,if(d.duedys between 61 and 90 and d.bal>0,round((d.bal),2),0) l3,if(d.duedys between 91 and 120 and d.bal>0,\r\n" +
					" round((d.bal),2),0) l4,if(d.duedys >=121 and d.bal>0,round((d.bal),2),0) l5,CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(50)) U6,if(d.bal>0,d.bal,0) t7 from (select j.acno,j.brhid,h.description name,sum(dramount-out_amount) bal,j.tranid, j.doc_no,\n\r" +
					" TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys from my_jvtran j inner join my_head h on j.acno=h.doc_no where j.status=3 and h.atype='AR' and j.yrid=0 and j.date<='"+sqlUpToDate+"' "+sql+" group by tranid having bal<>0) d) ag group by acno"+sql1+") a\r\n" + 
					" left join my_acbook bk on a.acno=bk.acno and bk.status=3 left join my_salm s on bk.sal_id=s.doc_no left join (select max(doc_no) doc_no,rdocno from gl_bcpf group by rdocno) sub on(sub.rdocno=bk.doc_no) left join gl_bcpf bv on sub.doc_no = bv.doc_no and bv.status=3 where 1=1"+sql2+""+sql3+" order by bk.cldocno";
			//	System.out.println("Grid:"+sql);
				ResultSet resultSet = stmtCRM.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				}
				
				stmtCRM.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray paymentFollowUpGridExporting(String branch,String uptodate,String clientaccount,String chkfollowup,String followupdate,String salesperson,String category,String amtrangefrm,String amtrangeto,String clientStatus,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
       
        Connection conn = null;
       
		java.sql.Date sqlUpToDate = null;
        java.sql.Date sqlFollowUpDate = null;
		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				
				if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
					sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
				}
        
				if(!(followupdate.equalsIgnoreCase("undefined")) && !(followupdate.equalsIgnoreCase("")) && !(followupdate.equalsIgnoreCase("0"))){
					sqlFollowUpDate = ClsCommon.changeStringtoSqlDate(followupdate);
				}
				
				if(sqlUpToDate!=null){

			    String sql = "";String sql1 = "";String sql2 = "";String sql3 = "";
				/*
				if(chkfollowup.equalsIgnoreCase("1")){
					if(!(sqlFollowUpDate==null)){
			        	sql2+=" and bv.fdate<='"+sqlFollowUpDate+"'";
					}
				}
				
				if(!(clientaccount.equalsIgnoreCase("0")) && !(clientaccount.equalsIgnoreCase(""))){
					sql+=" and j.acno="+clientaccount+"";
	            }
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhid="+branch+"";
	    		}
				
				if(!(salesperson.equalsIgnoreCase(""))){
	    			sql3+=" and bk.sal_id="+salesperson+"";
	    		}
				
				if(!(category.equalsIgnoreCase(""))){
	    			sql3+=" and bk.catid="+category+"";
	    		}
				
				if(!(((amtrangefrm.equalsIgnoreCase("")) && (amtrangeto.equalsIgnoreCase(""))) || ((amtrangefrm.equalsIgnoreCase("0")) && (amtrangeto.equalsIgnoreCase("0"))) )){
	    			sql1+=" having balance between "+amtrangefrm+" and "+amtrangeto+"";
	    		}
				
				if(!(clientStatus.equalsIgnoreCase(""))){
					if(clientStatus.equalsIgnoreCase("1")){
						sql3+=" and (bk.rostatus!=0 or bk.lostatus!=0)";
					}
					else if(clientStatus.equalsIgnoreCase("2")){
						sql3+=" and (bk.rostatus=0 or bk.lostatus=0)";
					}
					else if(clientStatus.equalsIgnoreCase("3")){
						sql3+=" and (bk.rostatus!=0 or bk.lostatus!=0) and bk.pcase=1";
					}
					else if(clientStatus.equalsIgnoreCase("4")){
						sql3+="  and (bk.rostatus=0 or bk.lostatus=0) and bk.pcase=1";
					}
					else if(clientStatus.equalsIgnoreCase("5")){
						sql3+=" and (bk.rostatus!=0 or bk.lostatus!=0) and bk.pcase=2";
					}
					else if(clientStatus.equalsIgnoreCase("6")){
						sql3+="  and (bk.rostatus=0 or bk.lostatus=0) and bk.pcase=2";
					}
					else if(clientStatus.equalsIgnoreCase("7")){
						sql3+=" and bk.pcase=3";
					}
	    		}
					
				sql = "select a.name 'Account Name',bk.contactPerson 'Contact Person',if(bk.per_mob is null,bk.com_mob,bk.per_mob) 'Mobile No',a.advance 'Advance',a.balance 'Balance',a.unapplied 'Unapplied',a.netamount 'Total',a.level1 'Level 1[0-30]',a.level2 'Level 2[31-60]',a.level3 'Level 3[61-90]',\r\n" +
					" a.level4 'Level 4[91-120]',a.level5 'Level 5[>121]',s.sal_name 'Sales Person',CONVERT(coalesce(bv.fdate,''),CHAR(100)) 'Follow-Up Date' from ( select ag.name,ag.acno,ag.brhid,ag.doc_no,CONVERT(if(sum(t7+u6)<0,round((sum(t7+u6)*-1),2),''),CHAR(50)) advance,\r\n" + 
					" CONVERT(if(sum(u6<0),round((sum(u6*-1)),2),''),CHAR(50)) unapplied,CONVERT(if(sum(t7+u6)>0,round((sum(t7+u6)),2),''),CHAR(50)) balance,CONVERT(if(sum(t7)>0,round((sum(t7)),2),''),CHAR(50)) netamount,CONVERT(if(sum(l1)>0,round((sum(l1)),2),''),CHAR(50)) level1,\r\n" + 
					" CONVERT(if(sum(l2)>0,round((sum(l2)),2),''),CHAR(50)) level2,CONVERT(if(sum(l3)>0,round((sum(l3)),2),''),CHAR(50)) level3,CONVERT(if(sum(l4)>0,round((sum(l4)),2),''),CHAR(50)) level4,CONVERT(if(sum(l5)>0,round((sum(l5)),2),''),CHAR(50)) level5 from (\r\n" +
					" select d.name,d.acno,d.brhid,d.doc_no,if(d.duedys between 0 and 30 and d.bal>0,round((d.bal),2),0) l1,if(d.duedys between 31 and 60 and d.bal>0,round((d.bal),2),0) l2,if(d.duedys between 61 and 90 and d.bal>0,round((d.bal),2),0) l3,if(d.duedys between 91 and 120 and d.bal>0,\r\n" +
					" round((d.bal),2),0) l4,if(d.duedys >=121 and d.bal>0,round((d.bal),2),0) l5,CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(50)) U6,if(d.bal>0,d.bal,0) t7 from (select j.acno,j.brhid,h.description name,sum(dramount-out_amount) bal,j.tranid, j.doc_no,\n\r" +
					" TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys from my_jvtran j inner join my_head h on j.acno=h.doc_no where j.status=3 and h.atype='AR' and j.yrid=0 and j.date<='"+sqlUpToDate+"' "+sql+" group by tranid having bal<>0) d) ag group by acno"+sql1+") a\r\n" + 
					" left join my_acbook bk on a.acno=bk.acno and bk.status=3 left join my_salm s on bk.sal_id=s.doc_no left join (select max(doc_no) doc_no,rdocno from gl_bcpf group by rdocno) sub on(sub.rdocno=bk.doc_no) left join gl_bcpf bv on sub.doc_no = bv.doc_no and bv.status=3 where 1=1"+sql2+""+sql3+"";
				*/
			    
				if(chkfollowup.equalsIgnoreCase("1")){
					if(!(sqlFollowUpDate==null)){
			        	sql2+=" and bv.fdate<='"+sqlFollowUpDate+"'";
					}
				}
				
				if(!(clientaccount.equalsIgnoreCase("0")) && !(clientaccount.equalsIgnoreCase(""))){
					sql+=" and j.acno="+clientaccount+"";
	            }
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhid="+branch+"";
	    		}
				
				if(!(salesperson.equalsIgnoreCase(""))){
	    			sql3+=" and bk.sal_id="+salesperson+"";
	    		}
				
				if(!(category.equalsIgnoreCase(""))){
	    			sql3+=" and bk.catid="+category+"";
	    		}
				
				if(!(((amtrangefrm.equalsIgnoreCase("")) && (amtrangeto.equalsIgnoreCase(""))) || ((amtrangefrm.equalsIgnoreCase("0")) && (amtrangeto.equalsIgnoreCase("0"))) )){
	    			sql1+=" having balance between "+amtrangefrm+" and "+amtrangeto+"";
	    		}
				
				System.out.println("clientStatus ="+clientStatus);
				
				if(!(clientStatus.equalsIgnoreCase(""))){
					if(clientStatus.equalsIgnoreCase("1")){
						sql3+=" and (bk.rostatus!=0 or bk.lostatus!=0)  and bk.pcase=0";
					}
					else if(clientStatus.equalsIgnoreCase("2")){
						sql3+=" and (bk.rostatus=0 and bk.lostatus=0)  and bk.pcase=0";
					}
					else if(clientStatus.equalsIgnoreCase("3")){
						sql3+=" and (bk.rostatus!=0 or bk.lostatus!=0) and bk.pcase=1";
					}
					else if(clientStatus.equalsIgnoreCase("4")){
						sql3+="  and (bk.rostatus=0 and bk.lostatus=0) and bk.pcase=1";
					}
					else if(clientStatus.equalsIgnoreCase("5")){
						sql3+=" and (bk.rostatus!=0 or bk.lostatus!=0) and bk.pcase=2";
					}
					else if(clientStatus.equalsIgnoreCase("6")){
						sql3+="  and (bk.rostatus=0 and bk.lostatus=0) and bk.pcase=2";
					}
					else if(clientStatus.equalsIgnoreCase("7")){
						sql3+=" and bk.pcase=3";
					}
	    		}
					
				sql = "select a.name 'Account Name',bk.contactPerson 'Contact Person',if(bk.per_mob is null,bk.com_mob,bk.per_mob) 'Mobile No',a.advance 'Advance',a.balance 'Balance',a.unapplied 'Unapplied',a.netamount 'Total',a.level1 'Level 1[0-30]',a.level2 'Level 2[31-60]',a.level3 'Level 3[61-90]',\r\n" +
					" a.level4 'Level 4[91-120]',a.level5 'Level 5[>121]',s.sal_name 'Sales Person',CONVERT(coalesce(bv.fdate,''),CHAR(100)) 'Follow-Up Date'  from ( select ag.name,ag.acno,ag.brhid,ag.doc_no,CONVERT(if(sum(t7+u6)<0,round((sum(t7+u6)*-1),2),''),CHAR(50)) advance,\r\n" + 
					" CONVERT(if(sum(u6<0),round((sum(u6*-1)),2),''),CHAR(50)) unapplied,CONVERT(if(sum(t7+u6)>0,round((sum(t7+u6)),2),''),CHAR(50)) balance,CONVERT(if(sum(t7)>0,round((sum(t7)),2),''),CHAR(50)) netamount,CONVERT(if(sum(l1)>0,round((sum(l1)),2),''),CHAR(50)) level1,\r\n" + 
					" CONVERT(if(sum(l2)>0,round((sum(l2)),2),''),CHAR(50)) level2,CONVERT(if(sum(l3)>0,round((sum(l3)),2),''),CHAR(50)) level3,CONVERT(if(sum(l4)>0,round((sum(l4)),2),''),CHAR(50)) level4,CONVERT(if(sum(l5)>0,round((sum(l5)),2),''),CHAR(50)) level5 from (\r\n" +
					" select d.name,d.acno,d.brhid,d.doc_no,if(d.duedys between 0 and 30 and d.bal>0,round((d.bal),2),0) l1,if(d.duedys between 31 and 60 and d.bal>0,round((d.bal),2),0) l2,if(d.duedys between 61 and 90 and d.bal>0,round((d.bal),2),0) l3,if(d.duedys between 91 and 120 and d.bal>0,\r\n" +
					" round((d.bal),2),0) l4,if(d.duedys >=121 and d.bal>0,round((d.bal),2),0) l5,CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(50)) U6,if(d.bal>0,d.bal,0) t7 from (select j.acno,j.brhid,h.description name,sum(dramount-out_amount) bal,j.tranid, j.doc_no,\n\r" +
					" TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys from my_jvtran j inner join my_head h on j.acno=h.doc_no where j.status=3 and h.atype='AR' and j.yrid=0 and j.date<='"+sqlUpToDate+"' "+sql+" group by tranid having bal<>0) d) ag group by acno"+sql1+") a\r\n" + 
					" left join my_acbook bk on a.acno=bk.acno and bk.status=3 left join my_salm s on bk.sal_id=s.doc_no left join (select max(doc_no) doc_no,rdocno from gl_bcpf group by rdocno) sub on(sub.rdocno=bk.doc_no) left join gl_bcpf bv on sub.doc_no = bv.doc_no and bv.status=3 where 1=1"+sql2+""+sql3+" order by bk.cldocno";
			//	System.out.println("Excel:"+sql);
			    
				ResultSet resultSet = stmtCRM.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				
				}
				
				stmtCRM.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray paymentFollowUpDetailGrid(String cldocno,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				
				String sql = "select m.date detdate,m.remarks remk,m.fdate,u.user_id user from gl_bcpf m inner join my_user u on u.doc_no=m.userid where m.rdocno="+cldocno+" "
						+ "and m.bibpid=23 and m.status=3 group by m.doc_no order by m.fdate desc";
				
				ResultSet resultSet = stmtCRM.executeQuery(sql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtCRM.close();
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
		        Statement stmtClient = conn.createStatement();
			
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
				
				ResultSet resultSet1 = stmtClient.executeQuery(sql);
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtClient.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public  ClsPaymentFollowUpBean getPrint(HttpServletRequest request,String atype,int acno,String branch,String uptodate,int level1from,int level1to,int level2from,
			int level2to,int level3from,int level3to,int level4from,int level4to,int level5from) throws SQLException {
			
		ClsPaymentFollowUpBean bean = new ClsPaymentFollowUpBean();

		Connection conn = null;
		
        java.sql.Date sqlUpToDate = null;
        
	try {
		conn = ClsConnection.getMyConnection();
		Statement stmtClient = conn.createStatement();
		String sql = "";
		
		if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
        	sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
        }
		
		sql="select 'Outstanding Statement' vouchername,(DATE_FORMAT('"+sqlUpToDate+"','%D %M  %Y ')) vouchername1,bk.address accountaddress,bk.per_mob accountmob,"
			+ "coalesce(bk.period,0) minperiod,coalesce(bk.period2,0) maxperiod,coalesce(bk.credit,0) creditlimit,j.acno,t.account,t.description,c.company,c.address,"
			+ "c.tel,c.fax,b.branchname,b.pbno,b.stcno,b.cstno,l.loc_name location,cd.code from my_acbook bk left join my_jvtran j on  bk.acno=j.acno  left join my_head t "
		    + "on j.acno=t.doc_no left join my_brch b on j.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no left join my_comp c on b.cmpid=c.doc_no left join my_curr cd "
			+ "on cd.doc_no=j.curId where j.acno="+acno+" and j.yrid=0 and j.status=3 group by acno";
		
		ResultSet resultSet = stmtClient.executeQuery(sql);
		
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
			bean.setLblcreditperiodmin(resultSet.getString("minperiod"));
			bean.setLblcreditperiodmax(resultSet.getString("maxperiod"));
			bean.setLblcreditlimit(resultSet.getString("creditlimit"));
			bean.setLblcurrencycode(resultSet.getString("code"));
		}
		
		stmtClient.close();
		conn.close();
	} catch(Exception e){
		e.printStackTrace();
		conn.close();
	} finally{
		conn.close();
	}
	return bean;
  }
}
