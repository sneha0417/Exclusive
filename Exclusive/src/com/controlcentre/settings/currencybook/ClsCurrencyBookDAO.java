package com.controlcentre.settings.currencybook;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsCurrencyBookDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	ClsCurrencyBookBean currencyBookBean = new ClsCurrencyBookBean();
	 
	public int insert(String formdetailcode, Date currencyBookDate, ArrayList<String> currencyarray, HttpSession session, String mode) 
			throws SQLException {
		
		Connection conn = null;
		
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtCUR1 = conn.createStatement();
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			int data = 0;
			
			CallableStatement stmtCUR=null;
			
			/*Currency Grid Saving*/
			for(int i=0;i< currencyarray.size();i++){
			String[] currency=currencyarray.get(i).split("::");
			if(!currency[0].equalsIgnoreCase("undefined") && !currency[0].equalsIgnoreCase("NaN")){
				
				int curId=0;
				
				String frmdate="";
				
				String sql="select max(frmDate) frmdate from my_curbook where curid='"+currency[0].trim()+"'";
				ResultSet resultSet = stmtCUR1.executeQuery(sql);	
			    
				while (resultSet.next()) {
					frmdate=resultSet.getString("frmdate");
				}	
				
				String sql1="select * from my_curbook where curid='"+currency[0].trim()+"' and rate='"+currency[1].trim()+"' and type='"+currency[2].trim()+"' and refcurid='"+currency[4].trim()+"' and frmDate='"+frmdate+"'";
				ResultSet resultSet1 = stmtCUR1.executeQuery(sql1);	
			    
				while (resultSet1.next()) {
					curId=1;
				}	
				
				if(curId==0){
					
				String sql2="update my_curbook set toDate='"+currencyBookDate+"' where curId="+(currency[0].trim().equalsIgnoreCase("undefined") || currency[0].trim().equalsIgnoreCase("NaN") || currency[0].trim().equalsIgnoreCase("") ||currency[0].trim().isEmpty()?0:currency[0].trim()).toString()+" "
						+ "and frmDate='"+frmdate+"'";
				int data2 = stmtCUR1.executeUpdate(sql2);
						if(data2<=0){
							stmtCUR1.close();
							conn.close();
							return 0;
						}
							
				stmtCUR = conn.prepareCall("insert into my_curbook(curId,frmDate,Rate,type,description,refCurId,ref_row) values(?,?,?,?,?,?,?)");
				
				stmtCUR.setString(1,(currency[0].trim().equalsIgnoreCase("undefined") || currency[0].trim().equalsIgnoreCase("NaN") || currency[0].trim().equalsIgnoreCase("") ||currency[0].trim().isEmpty()?0:currency[0].trim()).toString());
				stmtCUR.setDate(2,currencyBookDate);
				stmtCUR.setString(3,(currency[1].trim().equalsIgnoreCase("undefined") || currency[1].trim().equalsIgnoreCase("NaN") || currency[1].trim().equalsIgnoreCase("") ||currency[1].trim().isEmpty()?0:currency[1].trim()).toString());
				stmtCUR.setString(4,(currency[2].trim().equalsIgnoreCase("undefined") || currency[2].trim().equalsIgnoreCase("NaN") || currency[2].trim().equalsIgnoreCase("") ||currency[2].trim().isEmpty()?0:currency[2].trim()).toString());
				stmtCUR.setString(5,(currency[3].trim().equalsIgnoreCase("undefined") || currency[3].trim().equalsIgnoreCase("NaN") || currency[3].trim().equalsIgnoreCase("") ||currency[3].trim().isEmpty()?0:currency[3].trim()).toString());
				stmtCUR.setString(6,(currency[4].trim().equalsIgnoreCase("undefined") || currency[4].trim().equalsIgnoreCase("NaN") || currency[4].trim().equalsIgnoreCase("") ||currency[4].trim().isEmpty()?0:currency[4].trim()).toString());
				stmtCUR.setInt(7,(i+1));
			    data = stmtCUR.executeUpdate();
			    
			    if(data<=0){
					stmtCUR.close();
					conn.close();
					return 0;
				  }
			   }
			 }
		    }
			
			/*Inserting into datalog*/
			String sqls=("insert into datalog (brhId, dtype, edate, userId, ENTRY) values ('"+branch+"','"+formdetailcode+"',now(),'"+userid+"','A')");
			int datas = stmtCUR1.executeUpdate(sqls);
			/*Inserting into datalog Ends*/
			
			conn.commit();
			stmtCUR1.close();
			conn.close();
			return 1;
			
	 }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }finally{
		 conn.close();
	 }
	}
	
	public  JSONArray currencySearchGrid() throws SQLException {
        List<ClsCurrencyBookBean> currencySearchGridBean = new ArrayList<ClsCurrencyBookBean>();

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        		
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtOPN = conn.createStatement();
            	
				ResultSet resultSet = stmtOPN.executeQuery ("select c_name,code,country,doc_no curid from my_curr where status<>7");

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtOPN.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public  JSONArray currencyBookGridLoading(HttpSession session) throws SQLException {
        List<ClsCurrencyBookBean> currencyBookGridLoadingBean = new ArrayList<ClsCurrencyBookBean>();

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        		
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCUR = conn.createStatement();
            	
				ResultSet resultSet = stmtCUR.executeQuery ("select a.curid,a.rate c_rate,a.type,a.description,c.code,(select c.code from my_brch b left join my_curr c on b.curid=c.doc_no where "
						+ "b.cmpid='"+session.getAttribute("COMPANYID")+"' and b.mainbranch=1) basecode from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid from "
						+ "my_curbook cb group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) inner join my_curr c on a.curid=c.doc_no");

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtCUR.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }	
}
