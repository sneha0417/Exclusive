package com.dashboard.realestate.deferredsalesincome;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsDeferredSalesIncomeDAO {   
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon =new ClsCommon();
	
	public   JSONArray summaryData(String fromdate,String todate,String id) throws SQLException {
		JSONArray data=new JSONArray();
	    if(!id.equalsIgnoreCase("1")){
	    	return data;
	    }
	    String sqltest="";
	    java.sql.Date sqlfromdate = null;
	    java.sql.Date sqltodate = null;
	    int acno=0; 	
     	Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			Statement stm = conn.createStatement (); 
			if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
	     		sqltest+=" and inv.date>='"+sqlfromdate+"'";
	        }
			if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
	     		sqltodate=objcommon.changeStringtoSqlDate(todate);
	     		sqltest+=" and inv.date<='"+sqltodate+"'";
	        }
			String str="SELECT coalesce(acno,0) acno FROM MY_ACCOUNT WHERE CODENO='DEFERREDSALESACNO'";
			ResultSet rs = stm.executeQuery(str);     
			while(rs.next()){
				acno=rs.getInt("acno");                 
			}
			String sql="select ivd.rowno,inv.brhid,inv.doc_no,inv.date,inv.voc_no invno,coalesce(inv.rentsalevalue,0) saleval,reftype,inv.property propname,inv.owner ownername,inv.desc1 remarks,coalesce(inv.netamount,0) netamount,coalesce(ivd.nettaxamount,0) amount from rl_prinvm inv left join rl_prinvd ivd on ivd.rdocno=inv.doc_no where inv.status=3 and ivd.jvtrno=0 and ivd.acno='"+acno+"' "+sqltest+"";
			//System.out.println("gmt Query:--->>>  "+sql);   	
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
	public   JSONArray detailData(String fromdate,String todate,String id) throws SQLException {
		JSONArray data=new JSONArray();
	    if(!id.equalsIgnoreCase("1")){
	    	return data;
	    }
	    String sqltest="";
	    java.sql.Date sqltodate = null;
	    java.sql.Date sqlfromdate = null;
	    int acno=0; 	
     	Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			Statement stm = conn.createStatement (); 
			if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
	     		sqltest+=" and inv.date>='"+sqlfromdate+"'";
	        }
			if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
	     		sqltodate=objcommon.changeStringtoSqlDate(todate);
	     		sqltest+=" and inv.date<='"+sqltodate+"'";
	        }
			String str="SELECT coalesce(acno,0) acno FROM MY_ACCOUNT WHERE CODENO='DEFERREDSALESACNO'";
			ResultSet rs = stm.executeQuery(str);     
			while(rs.next()){
				acno=rs.getInt("acno");                 
			}
			String sql="select inv.brhid,inv.doc_no,inv.date,inv.voc_no invno,coalesce(inv.rentsalevalue,0) saleval,reftype,inv.property propname,inv.owner ownername,inv.desc1 remarks,coalesce(inv.netamount,0) netamount,coalesce(ivd.nettaxamount,0) amount from rl_prinvm inv left join rl_prinvd ivd on ivd.rdocno=inv.doc_no where inv.status=3 and ivd.jvtrno!=0  and ivd.acno='"+acno+"'  "+sqltest+"";
			System.out.println("gmt Query:--->>>  "+sql);   	
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
	public   JSONArray loadjvGrid(String acno,String id,String value) throws SQLException {
		JSONArray data=new JSONArray();    
	    if(!id.equalsIgnoreCase("1")){
	    	return data;
	    }
	    int dsacno=0; 	
     	Connection conn = null;   
     	Double amount=0.0;
		try {
			conn = objconn.getMyConnection();
			Statement stm = conn.createStatement (); 
			String str="SELECT coalesce(acno,0) acno FROM MY_ACCOUNT WHERE CODENO='DEFERREDSALESACNO'";
			ResultSet rs = stm.executeQuery(str);     
			while(rs.next()){
				dsacno=rs.getInt("acno");   
			}
			amount=Double.parseDouble(value);      
			String sql="select a.* from(select '"+dsacno+"' account,(select description from my_head where doc_no='"+dsacno+"') accountname,0 credit,"+amount+" debit,if("+amount+"<0,("+amount+")*-1,"+amount+") baseamt,1 id union all select '"+acno+"' account,(select description from my_head where doc_no='"+acno+"') accountname,"+amount+" credit,0 debit,if("+amount+">0,("+amount+")*-1,"+amount+") baseamt,-1 id)a where baseamt!=0";
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
	public   JSONArray searchaccount() throws SQLException {
		JSONArray data=new JSONArray();
     	Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			Statement stm = conn.createStatement (); 
			String sql="select description,doc_no from my_head where den=110 and m_s=0";
			//System.out.println("gmt Query:--->>>  "+sql);   	
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
