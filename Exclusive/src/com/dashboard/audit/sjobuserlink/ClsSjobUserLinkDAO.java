package com.dashboard.audit.sjobuserlink;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsSjobUserLinkDAO {


	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray detailsgrid(String check) throws SQLException {
		Connection conn=null;
		JSONArray RESULTDATA1=new JSONArray();
		if(!check.equalsIgnoreCase("1")){
			return RESULTDATA1;
		}
//System.out.println("1in");
		try {
			String sql = null;
			String condition="";
			String sql1 = "";
			/*Date frmsqldate=ClsCommon.changeStringtoSqlDate(frmdate);
			Date tosqldate=ClsCommon.changeStringtoSqlDate(todate);

			if(!((doc_no.equalsIgnoreCase("")) || (doc_no.equalsIgnoreCase("0")))){
				sql1=sql1+" and d.doc_no="+doc_no+"";
			}
			if(!((dtype.equalsIgnoreCase("")) || (dtype.equalsIgnoreCase("0")))){
				sql1=sql1+" and d.dtype='"+dtype+"'";
			}*/

			conn = ClsConnection.getMyConnection();
			Statement stmtMAD = conn.createStatement();

			/*sql = "select DATE_FORMAT(d.apprDate, '%d/%m/%y') as adate,d.doc_no,d.userid,d.brhid,u.user_name,b.branchname,d.dtype,d.remarks,apprlevel,if(d.apprStatus=5,'Forwarded ',if(d.apprStatus=3,'Approved',if(d.apprStatus=2,'Returned ',if(d.apprStatus=4,'Rejected ',if(d.apprStatus=1,'Submitted ',' Send'))))) apprtype,d.apprstatus from my_exdet d left join my_brch "
						+ "b on(d.brhid=b.doc_no) left join my_user u on(d.userid=u.doc_no) left join my_exeopt o on (o.doc_no=d.apprstatus) where 1=1 "+sql1+" and DATE_FORMAT(d.apprDate, '%Y-%m-%d')>='"+frmsqldate+"' and DATE_FORMAT(d.apprDate, '%Y-%m-%d')<='"+tosqldate+"' group by doc_no,apprlevel having max(apprlevel)" ;
			 */


			sql="select u.user_name username,r.user_role userrole,s.jtype jobtype,'Save' save from my_user u left join my_urole r on u.role_id=r.doc_no left join cm_sjobuserlink s on s.userid=u.doc_no left join cm_sjobtype j on j.rowno=s.jobtype  where u.status<>7";	
			//System.out.println("000===grid sql===="+sql);
			ResultSet resultSet1 = stmtMAD.executeQuery(sql);
			RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
		//	System.out.println("rr=="+resultSet1+"resul="+RESULTDATA1);

		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA1;
	}


	public JSONArray dtypeSearch() throws SQLException {
		Connection conn=null;
		JSONArray RESULTDATA1=new JSONArray();

		try {


			conn = ClsConnection.getMyConnection();
			Statement stmtMAD = conn.createStatement();

			String sql = "select distinct dtype from my_exdoc";


			ResultSet resultSet1 = stmtMAD.executeQuery(sql);
			RESULTDATA1=ClsCommon.convertToJSON(resultSet1);

			stmtMAD.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA1;
	}

	public JSONArray docSearch() throws SQLException {
		Connection conn=null;
		JSONArray RESULTDATA1=new JSONArray();

		try {


			conn = ClsConnection.getMyConnection();
			Statement stmtMAD = conn.createStatement();

			String sql = "select process jobtype,rowno from cm_sjobtype";


			ResultSet resultSet1 = stmtMAD.executeQuery(sql);
			RESULTDATA1=ClsCommon.convertToJSON(resultSet1);

			stmtMAD.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA1;
	}

	public String removeApproveAction() throws Exception { 
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();


	//	System.out.println(" inside removeApproveAction");

		String docno=request.getParameter("docno").trim();
		String dtype=request.getParameter("dtype").trim();
		String brchid=request.getParameter("brchid").trim();
		String reason=request.getParameter("reason").trim();


		//System.out.println("==docno==="+docno+"===dtype=="+dtype+"==userid==="+userid+"==brchid===="+brchid+"==desc===="+desc);
		Connection conn = ClsConnection.getMyConnection();
		Statement stmt1 =null;
		Statement stmt2 =null;
		Statement stmt3 =null;
		Statement stmt5 =null;
		try { 

			stmt1 =conn.createStatement();
			String mtblnme="",subuser="";
			int approvalcount=0;
			String sql="";
			
			String transtype="";
			String strsql="select msttable,transtype  from win_tbldet where trtype='"+dtype+"'";

			ResultSet rs1 = stmt1.executeQuery(strsql);

			while(rs1.next()) {

				mtblnme=rs1.getString("msttable");
				transtype=rs1.getString("transtype");
			}


			conn.setAutoCommit(false);
			CallableStatement stmt = conn.prepareCall("{CALL removeApprovalDML(?,?,?,?,?,?)}");

			//System.out.println("CALL removeApprovalDML('"+dtype+"',"+docno+","+brchid+",'"+reason+"'");	

			stmt.registerOutParameter(6, java.sql.Types.INTEGER);
			stmt.setString(1,dtype);
			stmt.setInt(2,Integer.parseInt(docno));
			stmt.setInt(3,Integer.parseInt(brchid));
			stmt.setString(4,reason);
			stmt.setString(5,session.getAttribute("USERID").toString());
			stmt.executeQuery(); 

			int no=stmt.getInt("srNo");


			String strsql5="update "+mtblnme+" set status=0 where dtype='"+dtype+"' and "+transtype+"="+Integer.parseInt(docno)+" and brhid="+Integer.parseInt(brchid)+"";
			
	//		System.out.println("===strsql5=="+strsql5);
			
			stmt5=conn.createStatement();
			int val2=stmt5.executeUpdate(strsql5);

			if((no>0) &&(val2>0)){

			 conn.commit();
			}


		} catch (Exception e) {  
			e.printStackTrace();
			

		} 
		finally{
			conn.close();
		}
		return "SUCCESS";  
	}
}
