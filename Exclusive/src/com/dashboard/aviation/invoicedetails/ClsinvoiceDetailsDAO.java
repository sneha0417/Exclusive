package com.dashboard.aviation.invoicedetails;
	import java.sql.Connection;
	import java.sql.ResultSet;
	import java.sql.SQLException;
	import java.sql.Statement;
	import javax.servlet.http.HttpSession;

	import net.sf.json.JSONArray;

	import com.common.ClsCommon;
	import com.connection.ClsConnection;

	public class ClsinvoiceDetailsDAO {

		ClsConnection ClsConnection=new ClsConnection();
	    ClsCommon cmn=new ClsCommon();
		
	    /* fsGrid data loading */
	    public  JSONArray loadGridData(String sortby,String fromdate,String todate,String clientid,String portid,int id) throws SQLException {

	    	JSONArray RESULTDATA=new JSONArray();
			java.sql.Date sqlFromDate=null;
			java.sql.Date sqlToDate=null;
			Connection conn =null;
			Statement stmt =null;
			String sql11="",sql12="";
			if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
			    sqlFromDate = cmn.changeStringtoSqlDate(fromdate);
			            }
			   
			   if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
			    sqlToDate = cmn.changeStringtoSqlDate(todate);
			   }
			if(!(sortby.equals("0") || sortby.equals("") || sortby.equals("undefined"))){
				sql12=sql12+" order by "+sortby+" ";
			}
			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sql11=sql11+" and m.client_id in ("+clientid+")";
			}
			if(!(portid.equals("0") || portid.equals("") || portid.equals("undefined"))){
				sql11=sql11+" and d.portid in ("+portid+")";
			}
			try {
				conn = ClsConnection.getMyConnection();
				stmt = conn.createStatement ();

				if(id>0){ 
		
					String sql="select m.voc_no doc_no,m.date,coalesce(ac.RefName,'') client,p.port,p.desc1 region,d.acraft_no,im.ltrqty,im.usgqty,im.sprice,im.amountusd,im.amountaed "
							+ " from av_invm m  left join av_invd im on im.rdocno=m.doc_no left join av_fueld d on im.refdocno=d.row_no "
							+ " left join my_port p on d.portid=p.doc_no  left join my_acbook ac on m.client_id=ac.cldocno  AND AC.DTYPE='CRM' "
							+ " where m.status=3 and m.date between '"+sqlFromDate+"' and '"+sqlToDate+"' "+sql11+" "+sql12+" ";		
					
					System.out.println("----sql---"+sql);
					ResultSet resultSet = stmt.executeQuery(sql);
					RESULTDATA=cmn.convertToJSON(resultSet);
				}
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				stmt.close();
				conn.close();
			}
			return RESULTDATA;
		
		}
	    
	  
	   
	     public JSONArray clientsearch(HttpSession session) throws SQLException{


			JSONArray RESULTDATA1=new JSONArray();

			Connection conn=null;
			try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement();

				String sql = "";

				sql="select cldocno,coalesce(RefName,'') client from my_acbook ac where status=3";

				ResultSet resultSet1 = stmt.executeQuery(sql);
				RESULTDATA1=cmn.convertToJSON(resultSet1);

			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();
			}


			return RESULTDATA1;
		}
	    public JSONArray portsearch(HttpSession session) throws SQLException{


			JSONArray RESULTDATA1=new JSONArray();

			Connection conn=null;
			try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement();

				String sql = "";

				sql="select doc_no,port from my_port where status=3";

				ResultSet resultSet1 = stmt.executeQuery(sql);
				RESULTDATA1=cmn.convertToJSON(resultSet1);

			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();
			}


			return RESULTDATA1;
		}


	}






