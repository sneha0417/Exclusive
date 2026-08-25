package com.finance.accountssetup.accountsMaster;

import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;


public class ClsAccMasterDAO {

	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO =new ClsConnection();
	
	Connection conn;
	public int insert(Date date_accountmaster,String accountGroup,String category,String acccategory, String accountcode,String accountName,String accountgpName, String branchone,String branchtwo,String Interbranch,String mode, HttpSession session,
			String Formdetailcode, HttpServletRequest request, int crid, double rates,String categorys) throws SQLException {

		try{
			int docno;
			 conn=connDAO.getMyConnection();
			 conn.setAutoCommit(false);
	/*		Statement stmtAccMaster1 = conn.createStatement ();
			String sql = "";
			
			if(accountcode.trim().equalsIgnoreCase("")){
				sql=" and account=(select max(doc_no)+1 from my_head)";
			}
			else{
				sql=" and account="+accountcode;
			}
			
			String sql1="select doc_no from my_head where 1=1 "+sql;
			
		
		
			ResultSet resultSet1 = stmtAccMaster1.executeQuery (sql1);
			
			while (resultSet1.next()) {
		
							 return -1;
				
		     }*/
			CallableStatement stmtAccMaster = conn.prepareCall("{CALL accMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtAccMaster.registerOutParameter(2, java.sql.Types.INTEGER);
		/*	if(accountcode.equalsIgnoreCase(""))
			{
				System.out.println("0000000");
			stmtAccMaster.registerOutParameter(4,java.sql.Types.VARCHAR);
			}
			else
			{
				System.out.println("1111111");*/
				//stmtAccMaster.setString(4,accountcode);	
			/*}*/
			stmtAccMaster.setDate(1,date_accountmaster);
			stmtAccMaster.setString(3,accountGroup);
			stmtAccMaster.setString(4,accountcode);	
			stmtAccMaster.setString(5,accountName);
			stmtAccMaster.setString(6,accountgpName);
			stmtAccMaster.setString(7,branchone);
			stmtAccMaster.setString(8,branchtwo);
			stmtAccMaster.setString(9,session.getAttribute("BRANCHID").toString());
			stmtAccMaster.setString(10,session.getAttribute("USERID").toString());
			stmtAccMaster.setString(11,session.getAttribute("CURRENCYID").toString());
			stmtAccMaster.setString(12,category);
			stmtAccMaster.setString(13,acccategory);
			stmtAccMaster.setString(14,Interbranch);
			stmtAccMaster.setString(15,Formdetailcode);
			stmtAccMaster.setString(16,mode);
           
			stmtAccMaster.executeUpdate();
			docno=stmtAccMaster.getInt("docNo");
			
			
			Statement stmtAccMaster1 = conn.createStatement ();
			String sql1 = "";
			
			String acc="";
			 sql1="select account from my_head where doc_no="+docno;
			
			ResultSet resultSet1 = stmtAccMaster1.executeQuery (sql1);
			
			while (resultSet1.next()) {
		
				 acc=(resultSet1.getString("account"));	
				
		     }
			
			
				request.setAttribute("accountcode",acc);
				
				if (docno > 0) {
					 
					
					
					if(categorys.equalsIgnoreCase("transaction"))
					{
						Statement stmtAccMaster2 = conn.createStatement ();	
						
						String sqlsss="update my_head set curid='"+crid+"',rate='"+rates+"' where  doc_no="+docno; 
						stmtAccMaster2.executeUpdate(sqlsss);
						
					}
				}
				
			
			if (docno > 0) {
				
				
				
				
				
				 conn.commit();
				 stmtAccMaster1.close();
					stmtAccMaster.close();
					conn.close();
				return docno;
			}
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return 0;
	}
	


	public int edit(int docno,Date date_accountmaster,String accountGroup,String category,String acccategory,
			String accountcode,String accountName,String accountgpName, String branchone,String branchtwo,String 
			Interbranch,String mode, HttpSession session,String Formdetailcode,HttpServletRequest request, int crid, double rates,String categorys) throws SQLException
	{
		try{
			 conn=connDAO.getMyConnection();
			 conn.setAutoCommit(false);
			/*Statement stmtAccMaster1 = conn.createStatement ();
			String sql = "";
			*/
		/*	if(accountcode.trim().equalsIgnoreCase("")){
				sql=" and account="+docno+" and   doc_no!="+docno+"";
			}
			else{
				sql=" and account ="+accountcode+" and   doc_no!="+docno+"";
			}
			
			String sql1="select doc_no from my_head where 1=1 "+sql;
			ResultSet resultSet1 = stmtAccMaster1.executeQuery (sql1);
			
			while (resultSet1.next()) {
		
							 return -1;
				          
		     }*/
			CallableStatement stmtAccMaster = conn.prepareCall("{CALL accMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtAccMaster.setDate(1,date_accountmaster);
			stmtAccMaster.setInt(2, docno);
			stmtAccMaster.setString(3,accountGroup);
			stmtAccMaster.setString(4,accountcode);
			stmtAccMaster.setString(5,accountName);
			stmtAccMaster.setString(6,accountgpName);
			stmtAccMaster.setString(7,branchone);
			stmtAccMaster.setString(8,branchtwo);
			stmtAccMaster.setString(9,session.getAttribute("BRANCHID").toString());
			stmtAccMaster.setString(10,session.getAttribute("USERID").toString());
			stmtAccMaster.setString(11,session.getAttribute("CURRENCYID").toString());
			stmtAccMaster.setString(12,category);
			stmtAccMaster.setString(13,acccategory);
			stmtAccMaster.setString(14,Interbranch);
			stmtAccMaster.setString(15,Formdetailcode);
			stmtAccMaster.setString(16,"E");
			stmtAccMaster.executeUpdate();
			 docno=stmtAccMaster.getInt("docNo");
			 
//			    String sql=" ";
//				ResultSet resultSet = stmtAccMaster1.executeQuery (sql);
				
				Statement stmtAccMaster12 = conn.createStatement ();
				String sql1 = "";
				
				String acc="";
				 sql1="select account from my_head where doc_no="+docno;
				
				ResultSet resultSet12 = stmtAccMaster12.executeQuery (sql1);
				
				while (resultSet12.next()) {
			
					 acc=(resultSet12.getString("account"));	
					
			     }
				
				
					request.setAttribute("accountcode",acc);
					
					
					
					if (docno > 0) {
						 
						
						
						if(categorys.equalsIgnoreCase("transaction"))
						{
							Statement stmtAccMaster2 = conn.createStatement ();	
							
							String sqlsss="update my_head set curid='"+crid+"',rate='"+rates+"' where  doc_no="+docno; 
							stmtAccMaster2.executeUpdate(sqlsss);
							
						}
					}
			
			if (docno > 0) {
				 conn.commit();
				 stmtAccMaster12.close();
					stmtAccMaster.close();
					conn.close();
				System.out.println("Sucess");
				return 1;
			}
		}catch(Exception e){
			conn.close();	
		}
		
		return 0;
	}

	public boolean delete(int docno,int delchk, HttpSession session,String Formdetailcode) throws SQLException {
		try{
			 conn=connDAO.getMyConnection();
			 conn.setAutoCommit(false);
			Statement stmtAccMaster16 = conn.createStatement ();
							if(delchk==1||delchk==2)
							{
							String sql="select grpno from my_head ";
							ResultSet resultSet = stmtAccMaster16.executeQuery (sql);
							while (resultSet.next()) {
								 int data = (resultSet.getInt("grpno"));
								 if(docno==data)
								 {
									 return false;
								 }
								}
						     }
								if(delchk==3)
								{
								String sql="select acno from my_jvtran where acno="+docno+" ";
								ResultSet resultSet = stmtAccMaster16.executeQuery (sql);
								while (resultSet.next()) {
									 int data = (resultSet.getInt("acno"));
									 if(docno==data)
									 {
										 return false;
									 }
									}
				
								}
						CallableStatement stmtAccMaster = conn.prepareCall("{CALL accMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						stmtAccMaster.setDate(1,null);
						stmtAccMaster.setInt(2, docno);
						stmtAccMaster.setString(3,null);
						stmtAccMaster.setString(4,null);
						stmtAccMaster.setString(5,null);
						stmtAccMaster.setString(6,null);
						stmtAccMaster.setString(7,null);
						stmtAccMaster.setString(8,null);
						stmtAccMaster.setString(9,session.getAttribute("BRANCHID").toString());
						stmtAccMaster.setString(10,session.getAttribute("USERID").toString());
						stmtAccMaster.setString(11,session.getAttribute("CURRENCYID").toString());
						stmtAccMaster.setString(12,null);
						stmtAccMaster.setString(13,null);
						stmtAccMaster.setString(14,null);
						stmtAccMaster.setString(15,Formdetailcode);
						stmtAccMaster.setString(16,"D");
						stmtAccMaster.executeUpdate();
						 docno=stmtAccMaster.getInt("docNo");
						//brandBean.setDocno(aaa);
						
						if (docno > 0) {
							 conn.commit();
								stmtAccMaster.close();
								conn.close();
							System.out.println("Sucess");
							return true;
						}	
					}catch(Exception e){
						conn.close();
					}						
				System.out.println("not deleted");
				return false;
						
			         	
				}
		

	
		
		
	
	
	
	
	public   JSONArray searchDetails() throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn = null;
		 try {
			  conn = connDAO.getMyConnection();
			 Statement stmtAC = conn.createStatement (); 

			 String sql="select h.rate,h.curid,r.code curr, h.Description,h.den,h.doc_no docno,h.date,h.account,if(h.m_s=1,'M','D')as md,h.m_s,h.alevel,h.grpno,a.FI_ID,"
			 		+ "a.head,b.br1,b.br2,b.doc_no from my_head as h inner join  my_agrp as a on (FI_ID=den) left join my_intr as b on  h.doc_no=b.doc_no"
			 		+ " left join my_curr r on r.doc_no=h.curid where h.dtype='GEN' ";

			 ResultSet resultSet = stmtAC.executeQuery (sql);

			 RESULTDATA=commonDAO.convertToJSON(resultSet);

			 stmtAC.close();
			 conn.close();

			// System.out.println("result data ===== "+RESULTDATA);
		 }
		 catch(Exception e){
			 conn.close();
			 e.printStackTrace();
		 }

		 return RESULTDATA;
  
}
	
	
	

/*	public  List<ClsAccMasterBean> list() throws SQLException {
		List<ClsAccMasterBean> listBean = new ArrayList<ClsAccMasterBean>();
		
		try {
			
				Connection conn = ClsConnection.getMyConnection();
				Statement stmtaccMaster = conn.createStatement ();
		    	String sql="select h.Description,h.den,h.doc_no docno,h.date,h.account,if(h.m_s=1,'M','D')as md,h.m_s,h.alevel,h.grpno,a.FI_ID,a.head,b.br1,b.br2,b.doc_no from my_head as h inner join  my_agrp as a on (FI_ID=den) left join my_intr as b on  h.doc_no=b.doc_no ";
		    	
		    	ResultSet resultSet = stmtaccMaster.executeQuery (sql);
			
				while (resultSet.next()) {
					
					ClsAccMasterBean bean = new ClsAccMasterBean();
		        	bean.setDocno(resultSet.getInt("docno"));
		        	bean.setMd(resultSet.getString("md"));
					bean.setDate(resultSet.getString("date"));
					bean.setDescription(resultSet.getString("description"));
					bean.setHead(resultSet.getString("head"));
					bean.setAccount(resultSet.getString("account"));
					bean.setM_s(resultSet.getString("m_s"));
					bean.setAlevel(resultSet.getString("alevel"));
					bean.setGrpno(resultSet.getString("grpno"));
					bean.setBrchone(resultSet.getString("br1"));
					bean.setBrchtwo(resultSet.getString("br2"));
					bean.setDen(resultSet.getString("den"));
					listBean.add(bean);
			
				
				}
				stmtaccMaster.close();
				conn.close();
		}
		
		catch(Exception e){
			e.printStackTrace();
		}

		return listBean;
		}*/

	 public   JSONArray getChartOfAC(String chk) throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 try {
			  conn = connDAO.getMyConnection();
			 Statement stmtAC = conn.createStatement ();
if(chk.equalsIgnoreCase("load"))
{
			 String sqlnew="select (select  description from my_head where doc_no=m.grpNo) group_name,m.grpNo,m.description,m.account,d.gp_id,p.fi_id,m.alevel,m.m_s,p.head,d.gp_desc "
			 		+ " from my_head m inner join my_agrp p on m.den=p.fi_id "
			 		+ "inner join gc_agrpd d on d.gp_id= p.gp_pr  and d.gtype='D'  where  m_s=0  "
			 		+ "order by  d.gp_id,p.fi_id,m.alevel ";
//System.out.println("----sqlnew---"+sqlnew);
			 ResultSet resultSet = stmtAC.executeQuery (sqlnew);

			 RESULTDATA=commonDAO.convertToJSON(resultSet);
}
			 stmtAC.close();
			 conn.close();

			// System.out.println("result data ===== "+RESULTDATA);
		 }
		 catch(Exception e){
			
			 e.printStackTrace();
			 conn.close();
		 }

		 return RESULTDATA;
   
 }
	 
	 
	 public   JSONArray getcurr() throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 try {
			  conn = connDAO.getMyConnection();
			 Statement stmtAC = conn.createStatement ();
 			 String sqlnew="select code,c_rate rate,doc_no from my_curr where status=3 ";
//System.out.println("----sqlnew---"+sqlnew);
			 ResultSet resultSet = stmtAC.executeQuery (sqlnew);

			 RESULTDATA=commonDAO.convertToJSON(resultSet);
 
			 stmtAC.close();
			 conn.close();

			// System.out.println("result data ===== "+RESULTDATA);
		 }
		 catch(Exception e){
			
			 e.printStackTrace();
			 conn.close();
		 }

		 return RESULTDATA;
   
 }
	 
	 
	
	 public   JSONArray getChartOfACExcel(String chk) throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		 
	//	 System.out.println("-----------------");
		 
		 try {
			 
			  conn = connDAO.getMyConnection();
			  Statement stmtAC = conn.createStatement ();
			  if(chk.equalsIgnoreCase("load"))
			  {
				 
			 

			 String sqlnew="select d.gp_desc 'Group Name',p.head 'Group Head',(select  description from my_head where doc_no=m.grpNo) 'Main Head',m.account 'Account',m.description 'Description' "
			 		+ " from my_head m inner join my_agrp p on m.den=p.fi_id "
			 		+ "inner join gc_agrpd d on d.gp_id= p.gp_pr  and d.gtype='D'  where  m_s=0  "
			 		+ "order by  d.gp_id,p.fi_id,m.alevel ";

			 ResultSet resultSet = stmtAC.executeQuery (sqlnew);

			 RESULTDATA=commonDAO.convertToEXCEL(resultSet);
			  }
			 stmtAC.close();
			 conn.close();

			// System.out.println("result data ===== "+RESULTDATA);
		 }
		 catch(Exception e){
			
			 e.printStackTrace();
			 conn.close();
		 }

		 return RESULTDATA;
   
 }
}

