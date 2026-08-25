package com.dashboard.realestate.agentcommissionlist;         

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsAgentCommissionListDAO {   
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon =new ClsCommon();
	
	
	public   JSONArray getMgmtData(String fromdate,String todate,String id,String salid) throws SQLException {
		JSONArray data=new JSONArray();
	    if(!id.equalsIgnoreCase("1")){
	    	return data;
	    }
	    String sqltest="";  
	    java.sql.Date sqltodate = null;
	    java.sql.Date sqlfromdate = null;
	    int commacno=0,commexacno=0;        	
     	Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			Statement stm = conn.createStatement (); 
			if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
	     		sqltodate=objcommon.changeStringtoSqlDate(todate);
	        }
			if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);    
	        }
			if(!(salid.equalsIgnoreCase("undefined"))&&!(salid.equalsIgnoreCase(""))&&!(salid.equalsIgnoreCase("0"))){
				sqltest=" and a.salid='"+salid+"'";           
	        }
			String str="select (select coalesce(acno,0) from my_account where codeno='COMMISSION ACCOUNT') commacno, (select coalesce(acno,0) from my_account where codeno='COMEXP') commexacno";
			ResultSet rs = stm.executeQuery(str);                
			while(rs.next()){
				commacno=rs.getInt("commacno");
				commexacno=rs.getInt("commexacno");
			}  

			String sql="select * from(select h.description,s.doc_no salid,inv.doc_no,inv.brhid,inv.voc_no invno,'PRIV' reftype, inv.date,coalesce(a.refname,'') tenant,cast(coalesce(inv.property,'') as char(200)) propname,cnt,coalesce(d.total,0) total,commpercent,coalesce(d.nettotal,0) saleval,coalesce(inv.netamount,0) netamount,coalesce(pg.commvalue,0) commval,coalesce(pg.claimval,0) claimamt,s.acc_no acno,s.sal_name agent,if(astatus=1,'Claimed',if(astatus=2,'Approve','')) status from rl_prinvm inv left join rl_prinvagent pg on pg.rdocno=inv.doc_no left join my_salesman s on sal_type='sla' and s.doc_no=pg.sal_id left join my_acbook a on a.acno=inv.acno and a.dtype='crm' left join rl_prinvd d on inv.doc_no=d.rdocno and d.acno  in (1143, 5606 , 5605 , 5381, 5609) left join my_head h on d.acno=h.doc_no  left join (select count(*) cnt,rdocno from rl_prinvagent group by rdocno) ta1 on ta1.rdocno=inv.doc_no where coalesce(pg.commvalue,0)!=0 and inv.date<='"+sqltodate+"' and inv.date>='"+sqlfromdate+"' and inv.status=3 union all select '',s.doc_no salid,m.doc_no,m.brhid,m.voc_no,'TNC' reftype,m.date,a.refname,p.accname,(ta1.cnt) person,d.amount,(cper) per,0,0,ta.camount agentcomm,0,s.acc_no acno,s.sal_name agent,'' from rl_tncm m inner join (select doc_no,sum(if(acno='"+commacno+"',dramount*id,0)) amount,sum(if(acno='"+commexacno+"',dramount*id,0)) agentcomm from my_jvtran where date<='"+sqltodate+"' and date>='"+sqlfromdate+"' and dtype='tnc' group by doc_no having coalesce(agentcomm,0)!=0) d on m.doc_no=d.doc_no left join rl_propertymaster p on m.prtype=p.doc_no left join my_acbook a on a.cldocno=m.cldocno and a.dtype='crm' left join rl_tncagent ta on ta.rdocno=m.doc_no left join (select count(*) cnt,rdocno from rl_tncagent group by rdocno) ta1 on ta1.rdocno=m.doc_no left join my_salesman s on sal_type='sla' and s.doc_no=ta.sal_id where  m.status=3 ) a where 1=1 "+sqltest+" order by a.date";
			System.out.println("list Query:--->>>  "+sql);	     
            ResultSet resultSet = stm.executeQuery(sql);       
            data=objcommon.convertToJSON(resultSet);
            conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();           
		}
		finally{
			conn.close();
		}
		// System.out.println(data);
        return data;
    }	
	
    public   JSONArray getSummaryData(String fromdate,String todate,String id,String salid) throws SQLException {
		JSONArray data=new JSONArray();
	    if(!id.equalsIgnoreCase("1")){
	    	return data;  
	    }
	    String sqltest="";  
	    java.sql.Date sqltodate = null;
	    java.sql.Date sqlfromdate = null;
	    int comacno=0,comexacno=0;              	
     	Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			Statement stm = conn.createStatement (); 
			if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
	     		sqltodate=objcommon.changeStringtoSqlDate(todate);
	        }
			if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);    
	        }
			if(!(salid.equalsIgnoreCase("undefined"))&&!(salid.equalsIgnoreCase(""))&&!(salid.equalsIgnoreCase("0"))){
				sqltest=" and z.salid='"+salid+"'";           
	        }
			String str="select (select coalesce(acno,0) from my_account where codeno='COMMISSION ACCOUNT') commacno, (select coalesce(acno,0) from my_account where codeno='COMEXP') commexacno";
			ResultSet rs = stm.executeQuery(str);                
			while(rs.next()){
				comacno=rs.getInt("commacno");
				comexacno=rs.getInt("commexacno");
			}  
			String mainsql="select brhid,doc_no,invno, dtype type, date_format(date,'%d.%m.%Y') date, tenant, propname property, cnt shared, round(total,2) total, round(commpercent,2) commper, round(commval,2) commval, agent,doc_no salid,coalesce(team,'') team from(select inv.brhid,inv.doc_no,inv.voc_no invno,'PRIV' dtype, inv.date,coalesce(a.refname,'') tenant,cast(coalesce(inv.property,'') as char(200)) propname,cnt,coalesce(d.total,0) total,commpercent,coalesce(pg.commvalue,0) commval,s.acc_no acno,s.sal_name agent,s.doc_no salid,s.team from rl_prinvm inv left join rl_prinvagent pg on pg.rdocno=inv.doc_no left join my_salesman s on sal_type='sla' and s.doc_no=pg.sal_id left join my_acbook a on a.acno=inv.acno and a.dtype='crm' left join rl_prinvd d on inv.doc_no=d.rdocno and d.acno='"+comacno+"' left join (select count(*) cnt,rdocno from rl_prinvagent group by rdocno) ta1 on ta1.rdocno=inv.doc_no where pg.confirm=1 and inv.date<='"+sqltodate+"' and inv.date>='"+sqlfromdate+"' and inv.status=3 union all select m.brhid,m.doc_no,m.voc_no,'TNC' dtype,m.date,a.refname,p.accname,(ta1.cnt) person,d.amount,(cper) per,ta.camount agentcomm,s.acc_no acno,s.sal_name agent,s.doc_no salid,s.team from rl_tncm m inner join (select doc_no,sum(if(acno='"+comacno+"',dramount*id,0)) amount,sum(if(acno='"+comexacno+"',dramount*id,0)) agentcomm from my_jvtran where date<='"+sqltodate+"' and date>='"+sqlfromdate+"' and dtype='tnc' group by doc_no having coalesce(agentcomm,0)!=0) d on m.doc_no=d.doc_no left join rl_propertymaster p on m.prtype=p.doc_no left join my_acbook a on a.cldocno=m.cldocno and a.dtype='crm' left join rl_tncagent ta on ta.rdocno=m.doc_no left join (select count(*) cnt,rdocno from rl_tncagent group by rdocno) ta1 on ta1.rdocno=m.doc_no left join my_salesman s on sal_type='sla' and s.doc_no=ta.sal_id where m.status=3 ) z where 1=1 "+sqltest+" order by z.date";
			System.out.println("mainsql:--->>>  "+mainsql);	     
            ResultSet resultSet = stm.executeQuery(mainsql);       
            data=objcommon.convertToJSON(resultSet);
            conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();           
		}
		finally{
			conn.close();
		}
		// System.out.println(data);
        return data;
    }
}
