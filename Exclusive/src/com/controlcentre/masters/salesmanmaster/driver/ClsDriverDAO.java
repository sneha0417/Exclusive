package com.controlcentre.masters.salesmanmaster.driver;

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

public class ClsDriverDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();


	ClsDriverBean driverBean=new ClsDriverBean();
	Connection conn;
	
	public int insert( String code, String name,Date sqlStartDate,String txtaccno,String licenseno,String authority,HttpSession session,String mode,ArrayList<String> driverarray,String mail,String formdetailcode,int external) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			int docno;
			
			CallableStatement stmtDriver = conn.prepareCall("{call driverDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			String[] driver = null;
			
			String licenceno=null;
			String mobileno=null;
			String issuedfrm=null;
			java.sql.Date licexp=null;
			
			if(driverarray.size()>0){
				for(int i=0;i< driverarray.size();i++){
					driver=driverarray.get(i).split("::");
				}
				issuedfrm=(driver[7].equalsIgnoreCase("undefined") || driver[7].isEmpty()?"0":driver[7]).toString();
				mobileno=(driver[2].equalsIgnoreCase("undefined") || driver[2].isEmpty()?"0":driver[2]).toString();
				licenceno=(driver[5].equalsIgnoreCase("undefined") || driver[5].isEmpty()?"0":driver[5]).toString();
				licexp=(driver[8].trim().equalsIgnoreCase("undefined") || driver[8].trim().equalsIgnoreCase("NaN") || driver[8].trim().equalsIgnoreCase("") ||  driver[8].equalsIgnoreCase("Invalid Date") || driver[8].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(driver[8].trim()));
		     }
			
			stmtDriver.registerOutParameter(8, java.sql.Types.INTEGER);
			stmtDriver.setString(1,code);
			stmtDriver.setString(2,name);
			stmtDriver.setDate(3, sqlStartDate);
			stmtDriver.setString(4, txtaccno);
			stmtDriver.setString(5,formdetailcode);
			stmtDriver.setString(6,session.getAttribute("USERID").toString());
			stmtDriver.setString(7,session.getAttribute("BRANCHID").toString());
			stmtDriver.setString(12, issuedfrm);
			stmtDriver.setString(9,mode);
			stmtDriver.setString(10, mobileno);
			stmtDriver.setString(11, mail);
			stmtDriver.setString(13, licenceno);
			stmtDriver.setDate(14, licexp);

			stmtDriver.setInt(15, external);

			stmtDriver.executeQuery();
			
			docno=stmtDriver.getInt("docNo");
			driverBean.setDocno(docno);
			if (docno > 0) {

				/*Driver Grid Saving*/
				for(int i=0;i< driverarray.size();i++){
				String[] client=driverarray.get(i).split("::");
				if(!client[0].equalsIgnoreCase("undefined") && !client[0].equalsIgnoreCase("NaN")){
					
				java.sql.Date dob=(client[0].trim().equalsIgnoreCase("undefined") || client[0].trim().equalsIgnoreCase("NaN") || client[0].trim().equalsIgnoreCase("") ||client[0].equalsIgnoreCase("Invalid Date") ||  client[0].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(client[0].trim()));
				java.sql.Date passexp=(client[4].trim().equalsIgnoreCase("undefined") || client[4].trim().equalsIgnoreCase("NaN") || client[4].trim().equalsIgnoreCase("") ||client[4].equalsIgnoreCase("Invalid Date") ||  client[4].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(client[4].trim()));
				java.sql.Date issdate=(client[6].trim().equalsIgnoreCase("undefined") || client[6].trim().equalsIgnoreCase("NaN") || client[6].trim().equalsIgnoreCase("") ||client[6].equalsIgnoreCase("Invalid Date") ||  client[6].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(client[6].trim()));
				java.sql.Date led=(client[8].trim().equalsIgnoreCase("undefined") || client[8].trim().equalsIgnoreCase("NaN") || client[8].trim().equalsIgnoreCase("") ||client[8].equalsIgnoreCase("Invalid Date") || client[8].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(client[8].trim()));
				java.sql.Date visaexp=(client[11].trim().equalsIgnoreCase("undefined") || client[11].trim().equalsIgnoreCase("NaN") || client[11].trim().equalsIgnoreCase("") ||client[11].equalsIgnoreCase("Invalid Date") ||  client[11].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(client[11].trim()));
				
				stmtDriver = conn.prepareCall("INSERT INTO gl_drdetails(name,dob,nation,mobno,passport_no,pass_exp,dlno,issdate,issfrm,led,ltype,visano,visa_exp,sr_no,dtype,branch,cldocno,doc_no) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				
				stmtDriver.setString(1,name);
				stmtDriver.setDate(2,dob);
				stmtDriver.setString(3,(client[1].trim().equalsIgnoreCase("undefined") || client[1].trim().equalsIgnoreCase("NaN") || client[1].trim().equalsIgnoreCase("") ||client[1].trim().isEmpty()?0:client[1].trim()).toString());
				stmtDriver.setString(4,(client[2].trim().equalsIgnoreCase("undefined") || client[2].trim().equalsIgnoreCase("NaN") || client[2].trim().equalsIgnoreCase("") ||client[2].trim().isEmpty()?0:client[2].trim()).toString());
				stmtDriver.setString(5,(client[3].trim().equalsIgnoreCase("undefined") || client[3].trim().equalsIgnoreCase("NaN") || client[3].trim().equalsIgnoreCase("") ||client[3].trim().isEmpty()?0:client[3].trim()).toString());
				stmtDriver.setDate(6,passexp);
				stmtDriver.setString(7,(client[5].trim().equalsIgnoreCase("undefined") || client[5].trim().equalsIgnoreCase("NaN") || client[5].trim().equalsIgnoreCase("") ||client[5].trim().isEmpty()?0:client[5].trim()).toString());
				stmtDriver.setDate(8,issdate);
				stmtDriver.setString(9,(client[7].trim().equalsIgnoreCase("undefined") || client[7].trim().equalsIgnoreCase("NaN") || client[7].trim().equalsIgnoreCase("") ||client[7].trim().isEmpty()?0:client[7].trim()).toString());
				stmtDriver.setDate(10,led);
				stmtDriver.setString(11,(client[9].trim().equalsIgnoreCase("undefined") || client[9].trim().equalsIgnoreCase("NaN") || client[9].trim().equalsIgnoreCase("") ||client[9].trim().isEmpty()?0:client[9].trim()).toString());
				stmtDriver.setString(12,(client[10].trim().equalsIgnoreCase("undefined") || client[10].trim().equalsIgnoreCase("NaN") || client[10].trim().equalsIgnoreCase("") ||client[10].trim().isEmpty()?0:client[10].trim()).toString());
				stmtDriver.setDate(13,visaexp);
				stmtDriver.setInt(14,(i+1));
				stmtDriver.setString(15,formdetailcode);
				stmtDriver.setString(16,session.getAttribute("BRANCHID").toString());
				stmtDriver.setInt(17,0);
				stmtDriver.setInt(18,docno);
				int drvval = stmtDriver.executeUpdate();
					if(drvval<0){
						stmtDriver.close();
						conn.close();
						return 0;
					}
				  }
				}
				conn.commit();
				stmtDriver.close();
				conn.close();
				return docno;
			}
			else if (docno == -1){
				stmtDriver.close();
				conn.close();
				return docno;
			}
			else if (docno == -2){
				stmtDriver.close();
				conn.close();
				return docno;
			}
			else if (docno == -3){
				stmtDriver.close();
				conn.close();
				return docno;
			}
			
		  stmtDriver.close();
		  conn.close();
		}catch(Exception e){	
			 e.printStackTrace();
			 conn.close();
			 return 0;	
		}finally{
			conn.close();
		}
		return 0;
	}

	public int edit(String code, String name,Date sqlStartDate,String txtaccno,String licenseno,String authority,HttpSession session,String mode,int docno,ArrayList<String> driverarray,String mail,String formdetailcode,int external) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtDriver = conn.prepareCall("{call driverDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			String[] driver = null;
			
			String licenceno=null;
			String mobileno=null;
			String issuedfrm=null;
			java.sql.Date licexp=null;
			
			if(driverarray.size()>0){
				for(int i=0;i< driverarray.size();i++){
					driver=driverarray.get(i).split("::");
				}
				issuedfrm=(driver[7].equalsIgnoreCase("undefined") || driver[7].isEmpty()?"0":driver[7]).toString();
				mobileno=(driver[2].equalsIgnoreCase("undefined") || driver[2].isEmpty()?"0":driver[2]).toString();
				licenceno=(driver[5].equalsIgnoreCase("undefined") || driver[5].isEmpty()?"0":driver[5]).toString();
				licexp=(driver[8].trim().equalsIgnoreCase("undefined") || driver[8].trim().equalsIgnoreCase("NaN") || driver[8].trim().equalsIgnoreCase("") ||  driver[8].equalsIgnoreCase("Invalid Date") || driver[8].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(driver[8].trim()));
		     }
			
			stmtDriver.setInt(8, docno);
			stmtDriver.setString(1,code);
			stmtDriver.setString(2,name);
			stmtDriver.setDate(3, sqlStartDate);
			stmtDriver.setString(4, txtaccno);
			stmtDriver.setString(5,formdetailcode);
			stmtDriver.setString(6,session.getAttribute("USERID").toString());
			stmtDriver.setString(7,session.getAttribute("BRANCHID").toString());
			stmtDriver.setString(12, issuedfrm);
			stmtDriver.setString(9,mode);
			stmtDriver.setString(10, mobileno);
			stmtDriver.setString(11, mail);
			stmtDriver.setString(13, licenceno);
			stmtDriver.setDate(14, licexp);

			stmtDriver.setInt(15, external);

			int data = stmtDriver.executeUpdate();
			int documentNo=stmtDriver.getInt("docNo");
			if (data>0) {

				/*Driver Grid Saving*/
				for(int i=0;i< driverarray.size();i++){
				String[] client=driverarray.get(i).split("::");
				if(!client[0].equalsIgnoreCase("undefined") && !client[0].equalsIgnoreCase("NaN")){
					
				java.sql.Date dob=(client[0].trim().equalsIgnoreCase("undefined") || client[0].trim().equalsIgnoreCase("NaN") || client[0].trim().equalsIgnoreCase("") ||client[0].equalsIgnoreCase("Invalid Date") ||  client[0].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(client[0].trim()));
				java.sql.Date passexp=(client[4].trim().equalsIgnoreCase("undefined") || client[4].trim().equalsIgnoreCase("NaN") || client[4].trim().equalsIgnoreCase("") ||client[4].equalsIgnoreCase("Invalid Date") ||  client[4].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(client[4].trim()));
				java.sql.Date issdate=(client[6].trim().equalsIgnoreCase("undefined") || client[6].trim().equalsIgnoreCase("NaN") || client[6].trim().equalsIgnoreCase("") ||client[6].equalsIgnoreCase("Invalid Date") ||  client[6].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(client[6].trim()));
				java.sql.Date led=(client[8].trim().equalsIgnoreCase("undefined") || client[8].trim().equalsIgnoreCase("NaN") || client[8].trim().equalsIgnoreCase("") ||client[8].equalsIgnoreCase("Invalid Date") || client[8].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(client[8].trim()));
				java.sql.Date visaexp=(client[11].trim().equalsIgnoreCase("undefined") || client[11].trim().equalsIgnoreCase("NaN") || client[11].trim().equalsIgnoreCase("") ||client[11].equalsIgnoreCase("Invalid Date") ||  client[11].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(client[11].trim()));
				
			int datas = 0 ;
			
			if(!client[12].equalsIgnoreCase("undefined") && !client[12].equalsIgnoreCase("NaN")){
			 
				stmtDriver = conn.prepareCall("update gl_drdetails set branch=?,name=?,dob=?,nation=?,mobno=?,passport_no=?,pass_exp=?,dlno=?,issdate=?,issfrm=?,led=?,ltype=?,visano=?,visa_exp=? where dtype=? and  doc_no=?");
				
				stmtDriver.setString(1,session.getAttribute("BRANCHID").toString());
				stmtDriver.setString(2,name);
				stmtDriver.setDate(3,dob);
				stmtDriver.setString(4,(client[1].equalsIgnoreCase("undefined") || client[1].isEmpty()?0:client[1]).toString());
				stmtDriver.setString(5,(client[2].equalsIgnoreCase("undefined") || client[2].isEmpty()?0:client[2]).toString());
				stmtDriver.setString(6,(client[3].equalsIgnoreCase("undefined") || client[3].isEmpty()?0:client[3]).toString());
				stmtDriver.setDate(7,passexp);
				stmtDriver.setString(8,(client[5].equalsIgnoreCase("undefined") || client[5].isEmpty()?0:client[5]).toString());
				stmtDriver.setDate(9,issdate);
				stmtDriver.setString(10,(client[7].equalsIgnoreCase("undefined") || client[7].isEmpty()?0:client[7]).toString());
				stmtDriver.setDate(11,led);
				stmtDriver.setString(12,(client[9].equalsIgnoreCase("undefined") || client[9].isEmpty()?0:client[9]).toString());
				stmtDriver.setString(13,(client[10].equalsIgnoreCase("undefined") || client[10].isEmpty()?0:client[10]).toString());
				stmtDriver.setDate(14,visaexp);
				stmtDriver.setString(15,formdetailcode);
				stmtDriver.setInt(16,docno);
				datas = stmtDriver.executeUpdate();
			}
			else{
				
				stmtDriver = conn.prepareCall("INSERT INTO gl_drdetails(name,dob,nation,mobno,passport_no,pass_exp,dlno,issdate,issfrm,led,ltype,visano,visa_exp,sr_no,dtype,branch,cldocno,doc_no) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				
				stmtDriver.setString(1,name);
				stmtDriver.setDate(2,dob);
				stmtDriver.setString(3,(client[1].trim().equalsIgnoreCase("undefined") || client[1].trim().equalsIgnoreCase("NaN") || client[1].trim().equalsIgnoreCase("") ||client[1].trim().isEmpty()?0:client[1].trim()).toString());
				stmtDriver.setString(4,(client[2].trim().equalsIgnoreCase("undefined") || client[2].trim().equalsIgnoreCase("NaN") || client[2].trim().equalsIgnoreCase("") ||client[2].trim().isEmpty()?0:client[2].trim()).toString());
				stmtDriver.setString(5,(client[3].trim().equalsIgnoreCase("undefined") || client[3].trim().equalsIgnoreCase("NaN") || client[3].trim().equalsIgnoreCase("") ||client[3].trim().isEmpty()?0:client[3].trim()).toString());
				stmtDriver.setDate(6,passexp);
				stmtDriver.setString(7,(client[5].trim().equalsIgnoreCase("undefined") || client[5].trim().equalsIgnoreCase("NaN") || client[5].trim().equalsIgnoreCase("") ||client[5].trim().isEmpty()?0:client[5].trim()).toString());
				stmtDriver.setDate(8,issdate);
				stmtDriver.setString(9,(client[7].trim().equalsIgnoreCase("undefined") || client[7].trim().equalsIgnoreCase("NaN") || client[7].trim().equalsIgnoreCase("") ||client[7].trim().isEmpty()?0:client[7].trim()).toString());
				stmtDriver.setDate(10,led);
				stmtDriver.setString(11,(client[9].trim().equalsIgnoreCase("undefined") || client[9].trim().equalsIgnoreCase("NaN") || client[9].trim().equalsIgnoreCase("") ||client[9].trim().isEmpty()?0:client[9].trim()).toString());
				stmtDriver.setString(12,(client[10].trim().equalsIgnoreCase("undefined") || client[10].trim().equalsIgnoreCase("NaN") || client[10].trim().equalsIgnoreCase("") ||client[10].trim().isEmpty()?0:client[10].trim()).toString());
				stmtDriver.setDate(13,visaexp);
				stmtDriver.setInt(14,(i+1));
				stmtDriver.setString(15,formdetailcode);
				stmtDriver.setString(16,session.getAttribute("BRANCHID").toString());
				stmtDriver.setInt(17,0);
				stmtDriver.setInt(18,docno);
				datas = stmtDriver.executeUpdate();
			}
					if(datas<=0){
						stmtDriver.close();
						conn.close();
						return 0;	
						}
					  }
					}
					conn.commit();
					stmtDriver.close();
					conn.close();
					return 1;
			}
			else if (documentNo == -1){
				stmtDriver.close();
				conn.close();
				return documentNo;
			}
			else if (documentNo == -2){
				stmtDriver.close();
				conn.close();
				return documentNo;
			}
			else if (documentNo == -3){
				stmtDriver.close();
				conn.close();
				return documentNo;
			}
			stmtDriver.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
			return 0;
		}finally{
			conn.close();
		}
		return 0;
	}


	public boolean delete(String code, String name,Date sqlStartDate,String txtaccno,String licenseno,String authority,HttpSession session,String mode,int docno,String mail,String formdetailcode,int external) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtDriver = conn.prepareCall("{call driverDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmtDriver.setInt(8, docno);
			stmtDriver.setString(1,code);
			stmtDriver.setString(2,name);
			stmtDriver.setDate(3, sqlStartDate);
			stmtDriver.setString(4, txtaccno);
			stmtDriver.setString(5,formdetailcode);
			stmtDriver.setString(6,session.getAttribute("USERID").toString());
			stmtDriver.setString(7,session.getAttribute("BRANCHID").toString());
			stmtDriver.setString(12, "0");
			stmtDriver.setString(9,mode);
			stmtDriver.setString(10, "0");
			stmtDriver.setString(11, mail);
			stmtDriver.setString(13, "0");
			stmtDriver.setDate(14, null);
			stmtDriver.setInt(15, external);
			stmtDriver.executeUpdate();
			int documentNo=stmtDriver.getInt("docNo");
			if (documentNo > 0) {
				conn.commit();
				stmtDriver.close();
				return true;
			}	
			stmtDriver.close();
		    conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
			return false;
		}finally{
			conn.close();
		}
		return false;
	}
	
	public  JSONArray nationSearch() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement();
            	
				ResultSet resultSet = stmt.executeQuery ("select nation from my_natm");

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmt.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public  JSONArray getDriverGrid(String docno,String dtype) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();
            	
				String strsql="SELECT dr_id,name,dob,DATE_FORMAT(dob,'%d.%m.%Y') AS hiddob,nation nation1,mobno,passport_no,pass_exp,DATE_FORMAT(pass_exp,'%d.%m.%Y') AS hidpassexp,"
						+ "dlno,issdate,DATE_FORMAT(issdate,'%d.%m.%Y') AS hidissdate,issfrm,led,DATE_FORMAT(led,'%d.%m.%Y') AS hidled,ltype,visano,visa_exp,DATE_FORMAT(visa_exp,'%d.%m.%Y') AS hidvisaexp "
						+ "FROM gl_drdetails where doc_no='"+docno+"' and dtype='"+dtype+"'";

            	ResultSet resultSet = stmt.executeQuery (strsql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmt.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }

	public  JSONArray stateGridSearch() throws SQLException {
        List<ClsDriverBean> stateGridSearchBean = new ArrayList<ClsDriverBean>();

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCRM = conn.createStatement ();
            	
				ResultSet resultSet = stmtCRM.executeQuery ("select state from my_uaestatesm order by state");

				RESULTDATA=ClsCommon.convertToJSON(resultSet);

		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public  List<ClsDriverBean> list() throws SQLException {
	    List<ClsDriverBean> listBean = new ArrayList<ClsDriverBean>();
	    Connection conn = null;
	    
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDriver = conn.createStatement();
	        	
				ResultSet resultSet = stmtDriver.executeQuery ("select m1.sal_code,m1.sal_name,m1.doc_no,m2.account acc_no,m2.doc_no acdoc,m1.date,coalesce(m1.mail,' ') mail,m1.authority,m2.description,m1.external from "+
						" my_salesman m1 left join my_head m2 on m1.acc_no=m2.doc_no where m1.status<>7 and m1.sal_type='DRV'");

				while (resultSet.next()) {
					
					ClsDriverBean bean = new ClsDriverBean();
	            	bean.setDocno(resultSet.getInt("doc_no"));
					bean.setName(resultSet.getString("sal_name"));
					bean.setCode(resultSet.getString("sal_code"));
					bean.setDriverdate(resultSet.getDate("date"));
					bean.setTxtaccno(resultSet.getString("acc_no"));
					bean.setMail(resultSet.getString("mail"));
					bean.setTxtaccname(resultSet.getString("description"));
					bean.setAuthority(resultSet.getString("authority"));
					bean.setHidacno(resultSet.getString("acdoc"));

					bean.setExternal(resultSet.getInt("external"));

	            	listBean.add(bean);
				}
				stmtDriver.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return listBean;
	}
}
