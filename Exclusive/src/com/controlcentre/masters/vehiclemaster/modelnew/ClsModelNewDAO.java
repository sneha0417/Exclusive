package com.controlcentre.masters.vehiclemaster.modelnew;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
public class ClsModelNewDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsModelNewBean modelBean = new ClsModelNewBean();
	public int insert(String model, String brandid, Date sqlStartDate,
			HttpSession session,String mode,String formdetailcode,String cmbvehtype,String cmbdoor,String cmbseat,String cmbluggage,String cmbpassengers,String cmbac) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
			int aaa;
			
			conn.setAutoCommit(false);
			Statement stmtTest=conn.createStatement ();
			String testSql="select vtype from gl_vehmodel where status<>7 and vtype='"+model+"'";
			ResultSet resultSet1 = stmtTest.executeQuery (testSql);
			if(resultSet1.next()){
				stmtTest.close();
				conn.close();
				return -1;
			}
			CallableStatement stmtModel = conn.prepareCall("{call vehModelDML(?,?,?,?,?,?,?,?)}");
			stmtModel.registerOutParameter(6, java.sql.Types.INTEGER);
			stmtModel.setString(1,model);
			stmtModel.setDate(2,sqlStartDate);
			stmtModel.setString(3, brandid);
			stmtModel.setString(4,session.getAttribute("BRANCHID").toString());
			stmtModel.setString(5,session.getAttribute("USERID").toString());
			stmtModel.setString(7,mode);
			stmtModel.setString(8,formdetailcode);
			stmtModel.executeQuery();
			aaa=stmtModel.getInt("docNo");
			Statement stmt=conn.createStatement();
			String strupdate="update gl_vehmodel set seat="+cmbseat+", luggage="+cmbluggage+", doors="+cmbdoor+", passengers="+cmbpassengers+", ac="+cmbac+",vehtypeid="+cmbvehtype+" where doc_no="+aaa;
			int update=stmt.executeUpdate(strupdate);
			if(update<=0){
				return 0;
			}
			modelBean.setDocno(aaa);
			if (aaa > 0) {
				conn.commit();
				return aaa;
			}
		}
		catch(Exception e){	
			e.printStackTrace();	
			conn.close();
		}
		finally{
			conn.close();
		}
		return 0;
	}
	

    public JSONArray list() throws SQLException {
    	JSONArray data=new JSONArray();
    	
        Connection conn = ClsConnection.getMyConnection();
		try {
				Statement stmtBrand = conn.createStatement ();
				ResultSet resultSet = stmtBrand.executeQuery ("select m1.seat,m1.luggage,m1.doors door,m1.passengers,m1.ac,vtype.name vehtype,vtype.doc_no vehtypedocno,m1.vtype,m1.doc_no,m1.brandid,m1.date,m2.brand_name from gl_vehmodel m1 left join gl_vehbrand m2 on m1.brandid=m2.doc_no left join gl_vehtype vtype on m1.vehtypeid=vtype.doc_no where m1.status<>7");
				data=objcommon.convertToJSON(resultSet);
				stmtBrand.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return data;
    }

	public int edit(String model,int docno,Date modeldate,String brandid,String mode, HttpSession session,String formdetailcode,String cmbvehtype,String cmbdoor,String cmbseat,String cmbluggage,String cmbpassengers,String cmbac) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
			conn.setAutoCommit(false);
			Statement stmtTest=conn.createStatement ();
			String testSql="select vtype from gl_vehmodel where status<>7 and vtype='"+model+"' and doc_no<>'"+docno+"'";
			ResultSet resultSet1 = stmtTest.executeQuery (testSql);
			if(resultSet1.next()){
				return -1;
			}
			
			CallableStatement stmtModel = conn.prepareCall("{call vehModelDML(?,?,?,?,?,?,?,?)}");
			stmtModel.setInt(6, docno);
			stmtModel.setString(1,model);
			stmtModel.setDate(2,(Date)modeldate);
			stmtModel.setString(3, brandid);
			stmtModel.setString(4, session.getAttribute("BRANCHID").toString());
			stmtModel.setString(5, session.getAttribute("USERID").toString());
			stmtModel.setString(7, mode);
			stmtModel.setString(8,formdetailcode);
			int aa = stmtModel.executeUpdate();
			String strupdate="update gl_vehmodel set seat="+cmbseat+", luggage="+cmbluggage+", doors="+cmbdoor+", passengers="+cmbpassengers+", ac="+cmbac+",vehtypeid="+cmbvehtype+" where doc_no="+docno;
			int update=stmtTest.executeUpdate(strupdate);
			if(update<=0){
				return 0;
			}
			if (aa>0) {
				conn.commit();
				return aa;
			}
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return 0;
	}


	public int delete(String model,int docno,Date modeldate,String brandid,String mode, HttpSession session,String formdetailcode) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
			
			conn.setAutoCommit(false);
			Statement stmtTest=conn.createStatement ();
			String testsql3="select m.doc_no from gl_vehmodel b inner join gl_vehmaster m on m.vmodid=b.doc_no where b.vtype='"+model+"'";
			ResultSet resultSet3 = stmtTest.executeQuery (testsql3);
			if(resultSet3.next()){
				return -2;
			}
			CallableStatement stmtModel = conn.prepareCall("{call vehModelDML(?,?,?,?,?,?,?,?)}");
			stmtModel.setString(1,model);
			stmtModel.setDate(2,(Date)modeldate);
			stmtModel.setString(3, brandid);
			stmtModel.setString(4, session.getAttribute("BRANCHID").toString());
			stmtModel.setString(5, session.getAttribute("USERID").toString());
			stmtModel.setInt(6, docno);
			stmtModel.setString(7, mode);
			stmtModel.setString(8,formdetailcode);
			int aa = stmtModel.executeUpdate();
			if (aa>0) {
				conn.commit();
				return aa;
			}
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return 0;
	}
}

