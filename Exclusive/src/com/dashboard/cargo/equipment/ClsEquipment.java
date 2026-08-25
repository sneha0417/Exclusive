package com.dashboard.cargo.equipment;

	import java.sql.Connection;
	import java.sql.ResultSet;
	import java.sql.SQLException;
	import java.sql.Statement;

	import javax.servlet.http.HttpSession;

	import com.common.ClsCommon;
	import com.connection.ClsConnection;

	import net.sf.json.JSONArray;

	public class ClsEquipment {
		ClsCommon commonDAO = new ClsCommon();
		ClsConnection connDAO = new ClsConnection();
		Connection conn = null;
		
		public JSONArray gridDataLoad() throws SQLException {
			 JSONArray RESULTDATA=new JSONArray();
		        Connection conn = null;
		        
			try {
				conn = connDAO.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				String sqltest="";
			    java.sql.Date  sqlDate = null;
			  	   	//cr_srvtype
			      	String sql="select m.brhid,em.voc_no enqno,d.doc_no,m.jobno,m.cldocno,ac.refname client,d.billing,"
			      			+ " av.refname vendor,sc.refno,sl.sal_name salesman,m.remarks desc1,ed.pol,ed.pod,d.qty,"
			      			+ " ed.modeid,ed.smodeid,ed.shipid,md.modename mode,sm.submode smode,sp.shipment,sv.srvtype "
			      			+ " from cr_qotm m left join cr_qotd d on m.doc_no=d.rdocno left join cr_enqm em on m.rrefno=em.doc_no and m.reftype='ENQ' "
			      			+ " left join cr_enqd ed on em.doc_no=ed.rdocno left join my_acbook ac on m.cldocno=ac.cldocno and ac.dtype='CRM' "
			      			+ " left join my_acbook av on d.vndid=av.cldocno and av.dtype='VND' left join my_salesman sl on ac.sal_id=sl.doc_no"
			      			+ " left join cr_mode md on md.doc_no=ed.modeid left join cr_smode sm on sm.doc_no=ed.modeid "
			      			+ " left join cr_srvtype sv on d.typeid=sv.doc_no left join cr_shipment sp on sp.doc_no=ed.shipid"
			      			+ " left join cm_srvcontrm sc on sc.tr_no=m.jobno where m.jobno>0 and d.agtype=0 and d.pstatus=0 group by d.doc_no";
					System.out.println("--enqrysql--"+sql);
			      	ResultSet resultSet = stmtCRM.executeQuery (sql);
					RESULTDATA=commonDAO.convertToJSON(resultSet);
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
		public JSONArray staffSearch() throws SQLException {
	        JSONArray RESULTDATA=new JSONArray();
	        Connection conn = null;
	        
			try {
				conn = connDAO.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				ResultSet resultSet = stmtCRM.executeQuery ("select doc_no,sal_name,sal_type from my_salesman where sal_type='STF' and status=3");
				RESULTDATA=commonDAO.convertToJSON(resultSet);
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
		public JSONArray equipmentSearch(HttpSession session,String flname,String fleetno,String regno,String check) throws SQLException{
			JSONArray RESULTDATA=new JSONArray();
			if(!(check.equalsIgnoreCase("1"))) {
	        	return RESULTDATA;
	        }
			
			Connection conn =null;
	        
			try {
				conn=connDAO.getMyConnection();
				Statement stmt = conn.createStatement ();
				String sqltest="";
				System.out.println("regno"+regno);
				
				if(!(flname.equalsIgnoreCase("") || flname.equalsIgnoreCase("0"))){
					sqltest+=" and flname like '%"+flname+"%'";
				}
				if(!(fleetno.equalsIgnoreCase("") || fleetno.equalsIgnoreCase("0"))){
					sqltest+=" and fleetno like '%"+fleetno+"%'";
				}
				if(!(regno.equalsIgnoreCase("") || regno.equalsIgnoreCase("0"))){
					sqltest+=" and reg_no like '%"+regno+"%'";
				}
				String sqlqry= "select FLNAME flname,FLEET_NO fleetno,REG_NO reg_no,track_id trackid from gl_vehmaster where statu='3'"+sqltest+""  ;
				ResultSet resultSet = stmt.executeQuery(sqlqry);
			    //System.out.println("sqlqry"+sqlqry);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmt.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
			finally{
				conn.close();
			}
		
		return RESULTDATA;
		}
	}
