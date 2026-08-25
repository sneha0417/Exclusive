package com.controlcentre.settings.termsnconditions;

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

public class ClsTermsAndConditionsDAO {

	ClsTermsAndConditionsBean termsNConditionBean = new ClsTermsAndConditionsBean();
	Connection conn;
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	public int insert(Date date, String mode,ArrayList  headarray, ArrayList  footarray, String hdoctype, String fdoctype,
			int headerid,HttpSession session) throws SQLException {

		int headdesc=0,footdesc=0,docno=0;
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String branch=session.getAttribute("BRANCHID").toString().trim();
		//	String userid=session.getAttribute("USERID").toString().trim();
		//	String company=session.getAttribute("COMPANYID").toString().trim();


			conn.setAutoCommit(false);
			
			
		 
			
if(fdoctype==null || fdoctype.equalsIgnoreCase(""))
{
			for(int i=0;i< headarray.size();i++){
				String[] headarr=((String) headarray.get(i)).split("::");
				
				   System.out.println("---headarr[0]--"+headarr[0]);
				if(!((headarr[0].trim().equalsIgnoreCase("0"))|| (headarr[0].trim().equalsIgnoreCase("undefined")))){

					
					
					String desc=""+(headarr[0].trim().equalsIgnoreCase("undefined") || headarr[0].trim().equalsIgnoreCase("NaN")||headarr[0].trim().equalsIgnoreCase("")|| headarr[0].isEmpty()?0:headarr[0].trim())+"";
					
					String docnos=""+(headarr[1].trim().equalsIgnoreCase("undefined") || headarr[1].trim().equalsIgnoreCase("NaN")||headarr[1].trim().equalsIgnoreCase("")|| headarr[1].isEmpty()?0:headarr[1].trim())+"";
					
					String mand=""+(headarr[2].equalsIgnoreCase("undefined") || headarr[2].equalsIgnoreCase("") || headarr[2].trim().equalsIgnoreCase("NaN")|| headarr[2].isEmpty()?0:headarr[2].trim())+"";
					
					String priono=""+(headarr[3].equalsIgnoreCase("undefined") || headarr[3].equalsIgnoreCase("") || headarr[3].trim().equalsIgnoreCase("NaN")|| headarr[3].isEmpty()?0:headarr[3].trim())+"";
					
					
					int voc_no=Integer.parseInt(docnos);
					
					if(voc_no>0)
					{
						
						String sqlss="update my_termsm set termsheader='"+desc+"',mand="+mand+",priority="+priono+" where dtype='"+hdoctype+"' and voc_no="+voc_no+" ";
						stmt.executeUpdate(sqlss);
					}
					else
					{
							String dsql="select coalesce(max(voc_no)+1,1) as docno from my_termsm";
		
							ResultSet resultSet = stmt.executeQuery(dsql);
		
							if(resultSet.next()){
								docno=resultSet.getInt("docno");
							}
							
							/*if(i==0)
							{
								String sqls="delete from  my_termsm where dtype='"+hdoctype+"' and status=3 ";
								stmt.executeUpdate(sqls);
							}*/
		     
							String sql="INSERT INTO my_termsm( voc_no,dtype, termsheader,mand,priority,date, status, brhid)VALUES"
									+ " ("+docno+",'"+hdoctype+"',"
									+ "'"+(headarr[0].equalsIgnoreCase("undefined") || headarr[0].equalsIgnoreCase("") || headarr[0].trim().equalsIgnoreCase("NaN")|| headarr[0].isEmpty()?0:headarr[0].trim())+"',"
									+ "'"+(headarr[2].equalsIgnoreCase("undefined") || headarr[2].equalsIgnoreCase("") || headarr[2].trim().equalsIgnoreCase("NaN")|| headarr[2].isEmpty()?0:headarr[2].trim())+"',"
									+ "'"+(headarr[3].equalsIgnoreCase("undefined") || headarr[3].equalsIgnoreCase("") || headarr[3].trim().equalsIgnoreCase("NaN")|| headarr[3].isEmpty()?0:headarr[3].trim())+"',"
									+ "now(),3,'"+branch+"')";
		
		
						//	System.out.println("headarr--->>>>Sql"+sql);
							headdesc = stmt.executeUpdate (sql);
							
							
			/*		
							String docnos=""+(headarr[1].trim().equalsIgnoreCase("undefined") || headarr[1].trim().equalsIgnoreCase("NaN")||headarr[1].trim().equalsIgnoreCase("")|| headarr[1].isEmpty()?0:headarr[1].trim())+"";
							String sqlsss="update my_termsd set rdocno="+docno+"   where rdocno='"+docnos+"' and dtype='"+hdoctype+"'";
							
							//System.out.println("--sqlsss---"+sqlsss);
							stmt.executeUpdate(sqlsss);*/
					
				}
				
			 
				
				} 
 
			}

}
else
{
			for(int i=0;i< footarray.size();i++){
				String[] footarr=((String) footarray.get(i)).split("::");
				
				if(i==0)
				{
					String sqls="delete from  my_termsd where rdocno='"+headerid+"' and status=3 ";
					stmt.executeUpdate(sqls);
				}
				
				if(!((footarr[0].trim().equalsIgnoreCase("0"))||(footarr[0].trim().equalsIgnoreCase("undefined")))){


					String sql="insert into my_termsd( rdocno, termsfooter,mand,priority, status, dtype) values"
							+ " ("+headerid+","
							+ "'"+(footarr[0].equalsIgnoreCase("undefined") || footarr[0].equalsIgnoreCase("") || footarr[0].trim().equalsIgnoreCase("NaN")|| footarr[0].isEmpty()?0:footarr[0].trim())+"',"
							+ "'"+(footarr[1].equalsIgnoreCase("undefined") || footarr[1].equalsIgnoreCase("") || footarr[1].trim().equalsIgnoreCase("NaN")|| footarr[1].isEmpty()?0:footarr[1].trim())+"',"
							+ "'"+(footarr[2].equalsIgnoreCase("undefined") || footarr[2].equalsIgnoreCase("") || footarr[2].trim().equalsIgnoreCase("NaN")|| footarr[2].isEmpty()?0:footarr[2].trim())+"',"
							+ "3,'"+fdoctype+"')";


					//System.out.println("footarr--->>>>Sql"+sql);
					footdesc = stmt.executeUpdate (sql);
				}

			}
}
			conn.commit();
			headdesc=1;
		}
		catch(Exception e){
			headdesc=0;
			e.printStackTrace();
		 
		}
		finally
		{
			conn.close();
		}

		return headdesc;
	}

	public  JSONArray dtypeGridDetails(HttpSession session) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		Connection  conn=null;
		try {
			 conn = ClsConnection.getMyConnection();
			Statement stmtITAC = conn.createStatement ();
			String sql="select doc_type dtype,menu_name description from my_menu where gate='E' and pmenu!=0 and mno not in (select pmenu from my_menu)";
			ResultSet resultSet = stmtITAC.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);

			stmtITAC.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			 
		}
		finally
		{
			conn.close();
		}
		return RESULTDATA;
	}

	public  JSONArray headerSearchGridDetails(HttpSession session,String dtype) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		try { conn = ClsConnection.getMyConnection();
			Statement stmtITAC = conn.createStatement ();
			String sql="select doc_no voc_no,dtype,termsheader as description,mand,priority priono from my_termsm where dtype='"+dtype+"' and status=3 ";

		//	System.out.println("==headerSearchGridDetails==="+sql);

			ResultSet resultSet = stmtITAC.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);

			stmtITAC.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			 
		}
		finally
		{
			conn.close();
		}
		return RESULTDATA;
	}

	public   JSONArray headerDtypeDetails(String dtype,HttpSession session) throws SQLException {
		List<ClsTermsAndConditionsBean> headerGridDetailsBean = new ArrayList<ClsTermsAndConditionsBean>();
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		try { conn = ClsConnection.getMyConnection();
			Statement stmtITAC = conn.createStatement ();

			ResultSet resultSet = stmtITAC.executeQuery("SELECT 'Delete' btnsave,doc_no,voc_no,termsheader as header,mand,priority priono FROM my_termsm where  status=3 and dtype='"+dtype+"' and dtype!='' ");

			RESULTDATA=ClsCommon.convertToJSON(resultSet);

			stmtITAC.close();
			conn.close();
		}
		catch(Exception e){
			
			
			e.printStackTrace();
			 
		}
		finally
		{
			conn.close();
		}
		return RESULTDATA;
	}

	public   JSONArray footerDtypeDetails(String dtype,HttpSession session,String doc_no) throws SQLException {
		List<ClsTermsAndConditionsBean> footerGridDetailsBean = new ArrayList<ClsTermsAndConditionsBean>();
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		try {
			  conn = ClsConnection.getMyConnection();
			Statement stmtITAC = conn.createStatement();

			ResultSet resultSet = stmtITAC.executeQuery ("select 'Delete' btnsave,doc_no,termsfooter footer,dtype,mand,priority priono from my_termsd where rdocno='"+doc_no+"' and dtype='"+dtype+"' and status=3 ");
 
			RESULTDATA=ClsCommon.convertToJSON(resultSet);

			stmtITAC.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			 
		}finally
		{
			conn.close();
		}
		return RESULTDATA;
	}
}
