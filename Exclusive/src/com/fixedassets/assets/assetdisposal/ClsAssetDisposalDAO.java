package com.fixedassets.assets.assetdisposal;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.fixedassets.assets.assetdisposal.*;;

public class ClsAssetDisposalDAO {
	
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	ClsAssetDisposalBean assetbean=new ClsAssetDisposalBean();
	
	public  JSONArray assetgriddata(String branch,String docno) throws SQLException {
		
		System.out.println("branch====="+branch);
		
	    Connection conn =null;
	    JSONArray RESULTDATA=new JSONArray();
		try {
				conn=ClsConnection.getMyConnection();
				Statement stmtmovement = conn.createStatement ();
				if(!(branch.equalsIgnoreCase(""))){
	        	String strSql="select saled.sr_no,saled.assetid assetno,saled.salesprice,saled.dep_posted,saled.pvalue pur_value,saled.acdep acc_dep,"+
	        			" saled.curdep cur_dep,saled.netbook,saled.netval net_pl,fix.assetid,fix.assetname from my_fasaled saled left join my_fixm fix"+
	        			" on saled.assetid=fix.sr_no left join my_fasalem sale on saled.rdocno=sale.doc_no where saled.rdocno="+docno+" and sale.brhid="+branch;

	        	System.out.println("strSql====="+strSql);
				ResultSet resultSet = stmtmovement.executeQuery (strSql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				}
				stmtmovement.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
//		System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	
	public  JSONArray getSearchData(String docno,String date,String client,String cmbtype,String acno,String mobile,String branch) throws SQLException {
	    Connection conn = null;
	    JSONArray RESULTDATA=new JSONArray();
		try {
			conn=ClsConnection.getMyConnection();
			java.sql.Date sqldate=null;
			String sqltest="";
			if(!(date.equalsIgnoreCase(""))){
				sqldate=ClsCommon.changeStringtoSqlDate(date);
			}
			if(!(docno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and sale.doc_no like '%"+docno+"%'";
			}
			if(!(cmbtype.equalsIgnoreCase(""))){
				sqltest=sqltest+" and sale.type='"+cmbtype+"'";
			}
			if(!(acno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and sale.acno like '%"+acno+"%'";
			}
			if(sqldate!=null){
				sqltest=sqltest+" and sale.date='"+sqldate+"'";
				
			}
			if(!(client.equalsIgnoreCase(""))){
				sqltest=sqltest+" and ac.refname like '%"+client+"%'";
			}
			if(!(mobile.equalsIgnoreCase(""))){
				sqltest=sqltest+" and ac.per_mob like '%"+mobile+"%'";
			}
			
				Statement stmtmovement = conn.createStatement();
				if(!(branch.equalsIgnoreCase("0"))){
	        	String strSql="select sale.doc_no,sale.voc_no,sale.date,sale.acno,if(sale.type='S','Sale','Total Loss') typename,sale.type,sale.description,sale.trno,ac.refname,ac.address,ac.per_mob,ac.mail1,sale.cldocno,sale.brhid from my_fasalem sale left join"+
		        				" my_head head on sale.acno=head.doc_no left join my_acbook ac on (sale.cldocno=ac.cldocno and ac.dtype='CRM') where sale.status<>7 and sale.acno=0 and sale.brhid='"+branch+"'"+sqltest;
	        	System.out.println(strSql);
				ResultSet resultSet = stmtmovement.executeQuery (strSql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtmovement.close();
				conn.close();
				return RESULTDATA;
				}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
//		System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	public  JSONArray assetSearch(String branch) throws SQLException {
	    Connection conn =null;
	    JSONArray RESULTDATA=new JSONArray();
		try {
			conn=ClsConnection.getMyConnection();
			
			Statement stmtmovement = conn.createStatement();
	        	String strSql="select assetid,assetname,sr_no assetno from my_fixm where  status=3 and brhid="+branch+" and sr_no not in"+
	        			" (select assetid from my_fasaled where salestatus=1)";
			
//	        	System.out.println(strSql);
				ResultSet resultSet = stmtmovement.executeQuery (strSql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtmovement.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
//		System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
	
	
	
	public  JSONArray clientSearch(String searchdate,String name,String docno,String acno,String mobile) throws SQLException {
	    Connection conn = null;
	    JSONArray RESULTDATA=new JSONArray();
		try {
			conn=ClsConnection.getMyConnection();
			java.sql.Date sqldate=null;
			String sqltest="";
			if(!(searchdate.equalsIgnoreCase(""))){
				sqldate=ClsCommon.changeStringtoSqlDate(searchdate);
			}
			if(!(docno.equalsIgnoreCase("") || docno.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and cldocno like '%"+docno+"%'";
			}
			if(sqldate!=null){
				sqltest=sqltest+" and date='"+sqldate+"'";
				
			}
			if(!(name.equalsIgnoreCase("") || name.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and refname like '%"+name+"%'";
			}
			if(!(acno.equalsIgnoreCase("") || acno.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and acno like '%"+acno+"%'";
			}
			if(!(mobile.equalsIgnoreCase("") || mobile.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and per_mob like '%"+mobile+"%'";
			}
				Statement stmtmovement = conn.createStatement();
	        	String strSql="select cldocno,refname,address,per_mob,acno,mail1 from my_acbook where dtype='CRM' and status<>7"+sqltest;
	        	System.out.println(strSql);
				ResultSet resultSet = stmtmovement.executeQuery (strSql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtmovement.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
//		System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}



	public ClsAssetDisposalBean insert(Date sqlStartDate, String cmbtype,
			String description, HttpSession session, String mode,
			ArrayList<String> assetarray, String formdetailcode,
			String clientacno, String client, String days, String brchName,
			HttpServletRequest request) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			int docno1=0,trno=0,vocno=0;
			
			conn.setAutoCommit(false);	
			CallableStatement stmtasset = conn.prepareCall("{call assetInvDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtasset.registerOutParameter(7, java.sql.Types.INTEGER);
			stmtasset.registerOutParameter(8, java.sql.Types.INTEGER);
			stmtasset.registerOutParameter(12, java.sql.Types.INTEGER);
			stmtasset.setDate(1,sqlStartDate);
			stmtasset.setString(2,clientacno);
			stmtasset.setString(3, cmbtype);
			stmtasset.setString(4, description);
			stmtasset.setString(5,session.getAttribute("USERID").toString());
			stmtasset.setString(6,brchName);
			stmtasset.setString(9,mode);
			stmtasset.setString(10,formdetailcode);
			stmtasset.setString(11,client);
			
			stmtasset.executeQuery();
			docno1=stmtasset.getInt("docNo");
			trno=stmtasset.getInt("trNo1");
			vocno=stmtasset.getInt("vocno");
			request.setAttribute("VOCNO", vocno);
			System.out.println("Docno:"+docno1+"/////Trno:"+trno+"/////Vocno:"+vocno);
			if (docno1 > 0) {
				assetbean.setTrno(trno);
//				System.out.println("no====="+docno1);
				assetbean.setDocno(docno1);
//				System.out.println("Success"+assetbean.getDocno());
//				System.out.println("Action Arrray length"+assetarray.size());
				int j=insertdet(assetarray,docno1,trno,conn,sqlStartDate,clientacno,mode,formdetailcode,session,client,days,brchName);
				
					if(j>0){
						conn.commit();
						stmtasset.close();
						conn.close();
						return assetbean;
					}
					else{
						assetbean.setDocno(0);
						stmtasset.close();
						conn.close();
						return assetbean;
					}
						
					}
			stmtasset.close();
				conn.close();
				
			
		
		}catch(Exception e){	
		e.printStackTrace();	
		conn.close();
		}
		finally{
			conn.close();
		}
		return assetbean;
	}



	private int insertdet(ArrayList<String> assetarray, int docno1, int trno,
			Connection conn, Date sqlStartDate,String clientacno, String mode,
			String formdetailcode, HttpSession session,String client,
			String days, String brchName) throws SQLException {
		// TODO Auto-generated method stub
		Statement stmtasset;
		int val=0;
		try{
		stmtasset = conn.createStatement ();
//		System.out.println(assetarray.size());
		for(int i=0;i< assetarray.size();i++){
			String[] asset=assetarray.get(i).split("::");
//			System.out.println("Here");
			String sql="insert into my_fasaled(trno,rdocno,sr_no,assetid,salesprice,dep_posted,pvalue,acdep,curdep,netval,salestatus,netbook)values('"+trno+"','"+docno1+"','"+(i+1)+"',"+
			"'"+(asset[0].equalsIgnoreCase("undefined") || asset[0].isEmpty()?0:asset[0])+"','"+(asset[2].equalsIgnoreCase("undefined") || asset[2].isEmpty()?0:asset[2])+"',"+
			"'"+ClsCommon.changetstmptoSqlDate((asset[3].equalsIgnoreCase("undefined") || asset[3].isEmpty()?0:asset[3]).toString())+"','"+(asset[4].equalsIgnoreCase("undefined") || asset[4].isEmpty()?0:asset[4])+"',"+
			"'"+(asset[5].equalsIgnoreCase("undefined") || asset[5].isEmpty()?0:asset[5])+"','"+(asset[6].equalsIgnoreCase("undefined") || asset[6].isEmpty()?0:asset[6])+"',"+
			"'"+(asset[7].equalsIgnoreCase("undefined") || asset[7].isEmpty()?0:asset[7])+"',1,'"+(asset[8].equalsIgnoreCase("undefined") || asset[8].isEmpty()?0:asset[8])+"')";
				
			System.out.println("Sql"+sql);
			 val = stmtasset.executeUpdate (sql);
			 System.out.println("Detail insert Value: "+val);
			if(val<=0){
				conn.close();
				return 0;
			}	
			if(val>0){
				CallableStatement stmtDisposalJv = conn.prepareCall("{call assetJvDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtDisposalJv.setString(1,(asset[0].equalsIgnoreCase("undefined") || asset[0].isEmpty()?0:asset[0]).toString());
				stmtDisposalJv.setDate(2,sqlStartDate);
				stmtDisposalJv.setDate(3,ClsCommon.changetstmptoSqlDate((asset[3].equalsIgnoreCase("undefined") || asset[3].isEmpty()?0:asset[3]).toString()));
				stmtDisposalJv.setString(4, (asset[4].equalsIgnoreCase("undefined") || asset[4].isEmpty()?0:asset[4]).toString());
				stmtDisposalJv.setString(5,(asset[5].equalsIgnoreCase("undefined") || asset[5].isEmpty()?0:asset[5]).toString());
				stmtDisposalJv.setString(6,(asset[6].equalsIgnoreCase("undefined") || asset[6].isEmpty()?0:asset[6]).toString());
				stmtDisposalJv.setString(7,(asset[2].equalsIgnoreCase("undefined") || asset[2].isEmpty()?0:asset[2]).toString());
				stmtDisposalJv.setString(8,(asset[7].equalsIgnoreCase("undefined") || asset[7].isEmpty()?0:asset[7]).toString());
				stmtDisposalJv.setString(9,clientacno);
				stmtDisposalJv.setString(10,mode);
				stmtDisposalJv.setString(11,formdetailcode);
				stmtDisposalJv.setString(12,session.getAttribute("USERID").toString());
				stmtDisposalJv.setString(13,brchName);
				stmtDisposalJv.setString(14,session.getAttribute("CURRENCYID").toString());
				stmtDisposalJv.setString(15,client);
				stmtDisposalJv.setInt(16,docno1);
				stmtDisposalJv.setInt(17,trno);
				stmtDisposalJv.setString(18,"0");
				System.out.println("Statement:"+stmtDisposalJv);
				int jvval=stmtDisposalJv.executeUpdate();
				System.out.println("Detail Jv value: "+jvval);
				/*if(jvval<=0){
					return 0;
				}*/
			}
			
		}
		return val;
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	
	return 0;
	// TODO Auto-generated method stub
	
}



	public boolean edit(Date sqlStartDate, String cmbtype, String description,
			HttpSession session, String mode, int docno, int trno,
			ArrayList<String> assetarray, String formdetailcode,
			String clientacno, String client, String brchName) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtasset = conn.prepareCall("{call assetInvDML(?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmtasset.setInt(7,docno);
			stmtasset.setInt(8, trno);
			stmtasset.setInt(12, 0);
			stmtasset.setDate(1,sqlStartDate);
			stmtasset.setString(2,"0");
			stmtasset.setString(3, cmbtype);
			stmtasset.setString(4, description);
			stmtasset.setString(5,session.getAttribute("USERID").toString());
			stmtasset.setString(6,brchName);
			stmtasset.setString(9,mode);
			stmtasset.setString(10,formdetailcode);
			stmtasset.setString(11,client);
			int aa = stmtasset.executeUpdate();
			
//			System.out.println("inside DAO1");
			if (aa>0) {
				System.out.println("Success");
				Statement stmtDisp= conn.createStatement ();
				int i=stmtDisp.executeUpdate("delete from my_fasaled where rdocno='"+docno+"' and trno='"+trno+"'");
				
				if(i>0){
					int z=stmtDisp.executeUpdate("delete from my_fatran where doc_no='"+docno+"' and tr_no='"+trno+"' and ttype='"+formdetailcode+"'");
					if(z>0){
						int x=stmtDisp.executeUpdate("delete from my_jvtran where tr_no='"+trno+"'");
						if(x>0){
							int j=insertdet(assetarray, docno, trno, conn,sqlStartDate,"0",mode,formdetailcode,session,"0",null,brchName);
							if(j>0){

								conn.commit();
								stmtasset.close();
								conn.close();
								return true;
								
							}	
						}
							
					}
					
				}
			}
			stmtasset.close();
			conn.close();
		}catch(Exception e){
		e.printStackTrace();	
		conn.close();
		}
		finally{
			conn.close();
		}
		return false;
	}



	public boolean delete(Date sqlStartDate, String cmbtype,
			String description, HttpSession session, String mode, int docno,
			int trno, String formdetailcode, String clientacno, String brchName) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtDisposal = conn.prepareCall("{call assetInvDML(?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmtDisposal.setInt(7,docno);
			stmtDisposal.setInt(8, trno);
			stmtDisposal.setInt(12, 0);
			stmtDisposal.setDate(1,sqlStartDate);
			stmtDisposal.setString(2,clientacno);
			stmtDisposal.setString(3, cmbtype);
			stmtDisposal.setString(4, description);
			stmtDisposal.setString(5,brchName);
			stmtDisposal.setString(6,session.getAttribute("USERID").toString());
			stmtDisposal.setString(9,mode);
			stmtDisposal.setString(10,formdetailcode);
			stmtDisposal.setString(11,null);
			int aa = stmtDisposal.executeUpdate();
			
			//System.out.println("Master Delete value: "+aa);
			if (aa>0) {
				Statement stmtAsset=conn.createStatement();
				int i=stmtAsset.executeUpdate("delete from my_fatran where doc_no="+docno+" and tr_no="+trno+"");
				//System.out.println("fatran Delete value: "+aa);
				if(i>0){
					int j=stmtAsset.executeUpdate("update my_jvtran set status=7 where tr_no="+trno);
					//System.out.println("jvtran Delete value: "+j);
					if(j>0){
						int x=stmtAsset.executeUpdate("update my_fasaled set salestatus=0 where rdocno="+docno);
						if(x>0){
							conn.commit();
							return true;	
						}
						
					}
				}
//				System.out.println("Success");
				
			}
			stmtDisposal.close();
			conn.close();
			return false;
			
		}catch(Exception e){
		e.printStackTrace();	
		conn.close();
		}
		finally{
			conn.close();
		}
		return false;
	}
public   ClsAssetDisposalBean getPrint(String docno) throws SQLException {
		// TODO Auto-generated method stub
	ClsAssetDisposalBean bean=new ClsAssetDisposalBean();
		Connection conn=null;
		String currency="";
		try{
			conn=ClsConnection.getMyConnection();
			ClsAmountToWords obj=new ClsAmountToWords();
			Statement stmt=conn.createStatement();
			String strsql="select br.branchname,lc.loc_name,br.address branchaddress,br.tel brtel,br.fax brfax,comp.company,sale.doc_no,sale.voc_no,DATE_FORMAT(sale.date,'%d/%m/%Y') "+
			" date,sale.cldocno,coalesce(ac.refname,'') refname,coalesce(ac.address,'') addr1,coalesce(ac.address2,'') addr2,coalesce(ac.com_mob,'') mob,coalesce(ac.per_mob,'') phone,"
			+ "if(sale.type='S','Sale','Loss') type,sale.description,cur.code cur,DATE_FORMAT(CURDATE(),'%d/%m/%Y') finaldate,ms.user_name from my_fasalem sale left join my_acbook ac on "+
			" (sale.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on (sale.brhid=br.doc_no) left join my_comp comp on (br.cmpid=comp.doc_no) left join my_curr cur on comp.curid=cur.doc_no"
			+ " inner join my_locm l on l.brhid=br.doc_no inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=br.doc_no) "
			+ "left join datalog dl on sale.doc_no=dl.doc_no and dl.dtype='ASI' left join my_user ms on ms.doc_no=dl.userid where  sale.doc_no="+docno;
			ResultSet rssale=stmt.executeQuery(strsql);
			while(rssale.next()){
				bean.setLbldocno(rssale.getString("voc_no"));
				bean.setLblclientcode(rssale.getString("cldocno"));
				bean.setLblclientname(rssale.getString("refname"));
				bean.setLbltype(rssale.getString("type"));
				bean.setLbldesc(rssale.getString("description"));
				bean.setLbldate(rssale.getString("date"));
				bean.setLblbranch(rssale.getString("branchname"));
				bean.setLblcompfax(rssale.getString("brfax"));
				bean.setLblcomptel(rssale.getString("brtel"));
				bean.setLblcompname(rssale.getString("company"));
				bean.setLblcompaddress(rssale.getString("branchaddress"));
				
				
				bean.setLbllocation(rssale.getString("loc_name"));
				bean.setLbladdress1(rssale.getString("addr1"));
				bean.setLbladdress2(rssale.getString("addr2"));
				bean.setLblmobile(rssale.getString("mob"));
				bean.setLblphone(rssale.getString("phone"));
				bean.setLblcheckedby(rssale.getString("user_name"));
				bean.setLblfinaldate(rssale.getString("finaldate"));
				currency=rssale.getString("cur");
			}
			
			

	//		ArrayList<Double> totalarray=new ArrayList<>();

			String strtotal="select round(sum(coalesce(saled.salesprice,0)),2) total from my_fasaled saled where saled.rdocno="+docno;
			ResultSet rstotal=stmt.executeQuery(strtotal);

			while(rstotal.next()){
		//		totalarray.add(rstotal.getDouble("total"));
				
				bean.setLbltotal(rstotal.getString("total"));
			//	bean.setLblamountwords(currency+" "+obj.convertNumberToWords(Double.parseDouble(rstotal.getString("total")))+" only");
			String amountwords=obj.convertAmountToWords(rstotal.getString("total"));
				bean.setLblamountwords(currency+" "+amountwords+"");
			}
			
			
			
		}
		catch(Exception e){
			e.printStackTrace();
			
		}
		finally{
			conn.close();
		}
		return bean;
	}
	public   ArrayList<String> getAssetSaleInvPrint(String docno) throws SQLException {
		// TODO Auto-generated method stub
		ArrayList<String> invprint=new ArrayList<>();
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			String strSql="select saled.sr_no,saled.assetid assetno,saled.salesprice,saled.dep_posted,saled.pvalue pur_value,saled.acdep acc_dep,"+
		            " saled.curdep cur_dep,saled.netbook,saled.netval net_pl,fix.assetid,fix.assetname from my_fasaled saled left join my_fixm fix"+
		            " on saled.assetid=fix.sr_no left join my_fasalem sale on saled.rdocno=sale.doc_no where saled.rdocno="+docno+"";
			
			ResultSet rsprint=stmt.executeQuery(strSql);
			String temp="";
			int i=0;
			while(rsprint.next()){
				temp=rsprint.getString("sr_no")+"::"+rsprint.getString("assetid")+"::"+rsprint.getString("assetname")+"::"+rsprint.getString("dep_posted")+"::"+rsprint.getString("pur_value")+"::"+rsprint.getString("acc_dep")+"::"+rsprint.getString("cur_dep")+"::"+rsprint.getString("netbook")+"::"+rsprint.getString("net_pl");
				invprint.add(temp);
				i++;
			}
			
						
			return invprint;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return invprint;
	}

}
