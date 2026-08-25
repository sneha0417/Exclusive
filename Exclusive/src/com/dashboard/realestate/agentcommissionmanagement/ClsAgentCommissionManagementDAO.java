package com.dashboard.realestate.agentcommissionmanagement;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsAgentCommissionManagementDAO {   
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon =new ClsCommon();
	
	public JSONArray getMgmtData(String todate,String id) throws SQLException {
		JSONArray data=new JSONArray();
	    if(!id.equalsIgnoreCase("1")){
	    	return data;
	    }
	    String sqltest="";
	    java.sql.Date sqltodate = null;
	    int acno=0; 	
     	Connection conn = null;    
		try {      
			conn = objconn.getMyConnection();
			Statement stm = conn.createStatement (); 
			if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
	     		sqltodate=objcommon.changeStringtoSqlDate(todate);
	     		sqltest+=" and inv.date<='"+sqltodate+"'";
	        }
			String str="SELECT coalesce(acno,0) acno FROM MY_ACCOUNT WHERE CODENO='AGENTCOMMISSIONACNO'";
			ResultSet rs = stm.executeQuery(str);     
			while(rs.next()){
				acno=rs.getInt("acno");                 
			}
			String sql="select convert(coalesce(concat(jvt2.dTYPE,'-',jvt2.doc_no),''),char(20)) allocated, (select doc_no from my_jvtran jv where jv.tr_no=pg.jvtrno limit 1) jvdocno,coalesce(pg.commpercent,0) commpercent,astatus statusid,pg.jvtrno,"
					+ "inv.brhid,inv.doc_no,pg.rowno,inv.date,inv.voc_no invno,s.acc_no acno,s.sal_name agent,coalesce(d.nettotal,0) saleval,reftype,inv.property propname,inv.owner ownername,"
					+ "coalesce(pg.claimval,0) claimamt,coalesce(pg.commvalue,0) commval,inv.desc1 remarks,if(astatus=1,'Claimed',if(astatus=2,'Approve','')) status,coalesce(inv.netamount,0) netamount "
					+ "from rl_prinvm inv inner join rl_prinvagent pg on pg.rdocno=inv.doc_no  left join rl_prinvd d on inv.doc_no=d.rdocno and d.acno  in (1143, 5606 , 5605 , 5381, 5609) "
					+ "left join my_salesman s on sal_type='sla' and s.doc_no=pg.sal_id "
					+ "left join my_jvtran jvt on jvt.tr_no=inv.tr_no and jvt.acno=inv.acno left join my_outd od on jvt.TRANID=od.ap_trid "
					+ "left join my_jvtran jvt2 on jvt2.tranid=od.TRANID where pg.confirm=0 and commvalue!=0 and inv.status=3 "+sqltest+"";
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
	
	public JSONArray loadjvGrid(String agentacno,String id,String commval,String claimval) throws SQLException {
		JSONArray data=new JSONArray();    
	    if(!id.equalsIgnoreCase("1")){
	    	return data;
	    }
	    int cushionacno=0,expacno=0; 	
     	Connection conn = null;
     	Double expval=0.0;
		try {
			conn = objconn.getMyConnection();
			Statement stm = conn.createStatement (); 
			expval=Double.parseDouble(commval)-Double.parseDouble(claimval);
			String str="select (SELECT coalesce(acno,0) acno FROM MY_ACCOUNT WHERE CODENO='AGENTCOMMISSIONACNO') cushacno,(select coalesce(acno,0) acno from my_account where codeno='COMEXP') expacno";
			ResultSet rs = stm.executeQuery(str);     
			while(rs.next()){
				cushionacno=rs.getInt("cushacno");   
				expacno=rs.getInt("expacno");       
			}
			String sql="select a.* from(select '"+cushionacno+"' account,(select description from my_head where doc_no='"+cushionacno+"') accountname,0 credit,"+commval+" debit,if("+commval+"<0,("+commval+")*-1,"+commval+") baseamt,1 id union all select '"+agentacno+"' account,(select description from my_head where doc_no='"+agentacno+"') accountname,"+claimval+" credit,0 debit,if("+claimval+">0,("+claimval+")*-1,"+claimval+") baseamt,-1 id union all select '"+expacno+"' account,(select description from my_head where doc_no='"+expacno+"') accountname,if("+expval+">=0,"+expval+",0) credit,if("+expval+"<0,("+expval+")*-1,0) debit,if("+expval+">=0,("+expval+")*-1,("+expval+")*-1) baseamt,if("+expval+">=0,-1,1)  id)a where baseamt!=0";
			//System.out.println("jv Query:--->>>  "+sql);	   
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

}
