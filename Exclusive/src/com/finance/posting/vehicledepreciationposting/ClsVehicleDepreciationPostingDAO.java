package com.finance.posting.vehicledepreciationposting;

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

public class ClsVehicleDepreciationPostingDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsVehicleDepreciationPostingBean vehicleDepreciationPostingBean = new ClsVehicleDepreciationPostingBean();
	
	public int insert(String formdetailcode, String branch,Date depreciationDate, double txtdeprtotal, ArrayList<String> vehicledetailsarray, ArrayList<String> journalvouchersarray, 
			HttpSession session,HttpServletRequest request,String mode) throws SQLException {
		Connection conn = null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			int total = 0;
			
			CallableStatement stmtVDP = conn.prepareCall("{CALL vehDepreciationmDML(?,?,?,?,?,?,?,?,?)}");
			
			stmtVDP.registerOutParameter(7, java.sql.Types.INTEGER);
			stmtVDP.registerOutParameter(8, java.sql.Types.INTEGER);
			
			stmtVDP.setDate(1,depreciationDate);
			stmtVDP.setDouble(2,txtdeprtotal);
			stmtVDP.setString(3,formdetailcode);
			stmtVDP.setString(4,company);
			stmtVDP.setString(5,branch);
			stmtVDP.setString(6,userid);
			stmtVDP.setString(9,mode);
			int datas=stmtVDP.executeUpdate();
			if(datas<=0){
				stmtVDP.close();
				conn.close();
				return 0;
			}
			int docno=stmtVDP.getInt("docNo");
			int trno=stmtVDP.getInt("itranNo");
			request.setAttribute("tranno", trno);
			vehicleDepreciationPostingBean.setTxtjvno(docno);
			if (docno > 0) {
				/*Insertion to gc_assettran,my_jvtran*/
				int insertData=insertion(conn, docno, branch, trno, formdetailcode, depreciationDate, vehicledetailsarray, journalvouchersarray, session,mode);
				if(insertData<=0){
					stmtVDP.close();
					conn.close();
					return 0;
				}
				/*Insertion to gc_assettran,my_jvtran Ends*/
					
				String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
				ResultSet resultSet = stmtVDP.executeQuery(sql1);
			    
				 while (resultSet.next()) {
				 total=resultSet.getInt("jvtotal");
				 }
				 
				 if(total == 0){
					conn.commit();
					stmtVDP.close();
					conn.close();
					return docno;
				 }
			}
			
			stmtVDP.close();
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

	
	public JSONArray vehicleDetailsProcessing(String branch,String deprDate) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		
        try {
				conn = connDAO.getMyConnection();
				Statement stmtVDP = conn.createStatement();
		
				java.sql.Date sqlDeprDate = null;
		        
		        if(!(deprDate.equalsIgnoreCase("undefined")) && !(deprDate.equalsIgnoreCase("")) && !(deprDate.equalsIgnoreCase("0"))){
		        	sqlDeprDate = commonDAO.changeStringtoSqlDate(deprDate);
		        }
			    
				/*String sql = "select v.fleet_no,v.flname,v.reg_no,v.prch_dte,round(v.prch_cost,2) prch_cost,round(v.depr,2)depr,coalesce(v.depr_date,v.date) deprdate,sum(round(g.dramount,2)) bookvalue,Convert(coalesce(v.depr_date,v.prch_dte),CHAR(100)) frmdate "
						+ "from gl_vehmaster v left join gc_assettran g on v.fleet_no=g.fleet_no where v.tran_code<>'FS' and v.statu=3 and v.brhid="+branch+" and coalesce(v.depr_date,v.date)<'"+sqlDeprDate+"' group by g.fleet_no having sum(g.dramount)>0";*/
			    
				String sql = "select v.fleet_no,v.flname,v.reg_no,v.prch_dte,round(g.dramount,2) prch_cost,round(v.depr,2)depr,coalesce(v.depr_date,v.date) deprdate,sum(round(g1.dramount,2)) bookvalue,Convert(coalesce(v.depr_date,v.prch_dte),CHAR(100)) frmdate "
						+ "from gl_vehmaster v left join gc_assettran g on v.fleet_no=g.fleet_no and g.acno=(select acno from my_account where codeno='VEH') left join gc_assettran g1 on v.fleet_no=g1.fleet_no where v.fstatus<>'Z' and v.statu=3 and v.brhid="+branch+" and coalesce(v.depr_date,v.PRCH_DTE)<'"+sqlDeprDate+"' group by g1.fleet_no having sum(g1.dramount)>0";
						
				ResultSet resultSet = stmtVDP.executeQuery(sql);

				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtVDP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray vehicleDetailsCalculating(String branch,String day,String deprDate) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		
        try {
				conn = connDAO.getMyConnection();
				Statement stmtVDP = conn.createStatement();
		
				java.sql.Date sqlDeprDate = null;
		        
		        if(!(deprDate.equalsIgnoreCase("undefined")) && !(deprDate.equalsIgnoreCase("")) && !(deprDate.equalsIgnoreCase("0"))){
		        	sqlDeprDate = commonDAO.changeStringtoSqlDate(deprDate);
		        }

				/*String sql = "select v.fleet_no,v.flname,v.reg_no,v.prch_dte,round(v.prch_cost,2) prch_cost,round(v.depr,2)depr,coalesce(v.depr_date,v.date) deprdate,sum(round(g.dramount,2)) bookvalue,Convert(coalesce(v.depr_date,v.prch_dte),char(100)) frmdate,"
						+ "round(((v.prch_cost * v.depr/100)/365)*"+day+",2) depramt,if(round(((v.prch_cost * v.depr/100)/365)*"+day+",2)<sum(round(g.dramount,2)),round(((v.prch_cost * v.depr/100)/365)*"+day+",2),"
						+ "sum(round(g.dramount,2))) depr_amt from gl_vehmaster v left join gc_assettran g on v.fleet_no=g.fleet_no where v.tran_code<>'FS' and v.statu=3 and v.brhid="+branch+" and coalesce(v.depr_date,v.date)<'"+sqlDeprDate+"' group by g.fleet_no having sum(g.dramount)>0";*/
				
				String sql = "select v.fleet_no,v.flname,v.reg_no,v.prch_dte,round(g.dramount,2) prch_cost,round(v.depr,2)depr,coalesce(v.depr_date,v.date) deprdate,sum(round(g1.dramount,2)) bookvalue,"
						+ "Convert(coalesce(v.depr_date,v.prch_dte),char(100)) frmdate,round(((g.dramount * v.depr/100)/365)*(datediff('"+sqlDeprDate+"',coalesce(v.depr_date,v.prch_dte))),2) depramt,if(round(((g.dramount * v.depr/100)/365)*(datediff('"+sqlDeprDate+"',coalesce(v.depr_date,v.prch_dte))),2)<"
						+ "sum(round(g1.dramount,2)),round(((g.dramount * v.depr/100)/365)*(datediff('"+sqlDeprDate+"',coalesce(v.depr_date,v.prch_dte))),2),sum(round(g1.dramount,2))) depr_amt from gl_vehmaster v left join gc_assettran g on v.fleet_no=g.fleet_no "
						+ "and g.acno=(select acno from my_account where codeno='VEH') left join gc_assettran g1 on v.fleet_no=g1.fleet_no where v.fstatus<>'Z' and v.statu=3 and v.brhid="+branch+" and "
						+ "coalesce(v.depr_date,v.PRCH_DTE)<'"+sqlDeprDate+"' group by g1.fleet_no having sum(g1.dramount)>0";
				
				ResultSet resultSet = stmtVDP.executeQuery(sql);

				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtVDP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray vehicleDetailsReloading(String docno,String trno) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtVDP = conn.createStatement();
				
				String sql = "select g.fleet_no,v.flname,v.reg_no,v.prch_dte,round(v.prch_cost,2) prch_cost,round(g.depr,2) depr,g.frmDate frmdate,g.book_value bookvalue,"
						+ "if(g.dramount<0,(round(g.dramount,2))*-1,round(g.dramount,2)) depr_amt from gl_vehmaster v left join gc_assettran g on v.fleet_no=g.fleet_no "
						+ "where g.doc_no="+docno+" and g.tr_no="+trno+"";
		        
				ResultSet resultSet = stmtVDP.executeQuery(sql);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtVDP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }

	public JSONArray accountDetailsGridLoading() throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtVDP = conn.createStatement();
				
				String sql = "select h.doc_no acno,h.account,h.description codeno from my_account a left join my_head h on a.acno=h.doc_no where a.codeno IN('VAD','VDE')";
		        
				ResultSet resultSet = stmtVDP.executeQuery(sql);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtVDP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray accountDetailsGridReloading(String trno) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtVDP = conn.createStatement();
            	
				String sql = "select j.acno,if(j.dramount>0,0,j.dramount*j.id) debit ,if(j.dramount<0,0,j.dramount*j.id) credit,t.account,t.description codeno "
						+ "from my_jvtran j left join my_head t on j.acno=t.doc_no WHERE j.dtype='VDP' and j.tr_no="+trno+"";
            	
				ResultSet resultSet = stmtVDP.executeQuery(sql);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtVDP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray vdpMainSearch(String branch,String partyname,String docNo,String date,String amount) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
           
        java.sql.Date sqlDepriciationDate=null;
           
     try {
	       conn = connDAO.getMyConnection();
	       Statement stmtVDP = conn.createStatement();
	       
	       date.trim();
	        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	        {
	        	sqlDepriciationDate = commonDAO.changeStringtoSqlDate(date);
	        }

	        String sqltest="";
	        
	        if(!(docNo.equalsIgnoreCase(""))){
	            sqltest=sqltest+" and v.doc_no like '%"+docNo+"%'";
	        }
	        if(!(partyname.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and u.user_name like '%"+partyname+"%'";
	        }
	        if(!(amount.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and v.total like '%"+amount+"%'";
	        }
	        if(!(sqlDepriciationDate==null)){
		         sqltest=sqltest+" and v.date='"+sqlDepriciationDate+"'";
		        } 
	        
	       ResultSet resultSet = stmtVDP.executeQuery("select v.date,v.doc_no,v.total,v.tr_no,u.user_name from gl_vehdepr v left join my_user u on v.userid=u.doc_no where v.brhid='"+branch+"' and v.status=3" +sqltest);
	
	       RESULTDATA=commonDAO.convertToJSON(resultSet);
	       
	       stmtVDP.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
 		conn.close();
 	}
       return RESULTDATA;
   }
	
	public ClsVehicleDepreciationPostingBean getPrint(HttpServletRequest request,int docNo,int branch,int header) throws SQLException {
		 ClsVehicleDepreciationPostingBean bean = new ClsVehicleDepreciationPostingBean();
		 Connection conn = null;
		 
		try {
			conn = connDAO.getMyConnection();
			Statement stmtVDP = conn.createStatement();
			
			int trno=0;
			
			String headersql="select if(m.dtype='VDP','Veh. Dep. Posting','  ') vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
					+ "b.cstno from gl_vehdepr m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='VDP' "
					+ "and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSetHead = stmtVDP.executeQuery(headersql);
			
			while(resultSetHead.next()){
				
				bean.setLblcompname(resultSetHead.getString("company"));
				bean.setLblcompaddress(resultSetHead.getString("address"));
				bean.setLblprintname(resultSetHead.getString("vouchername"));
				bean.setLblcomptel(resultSetHead.getString("tel"));
				bean.setLblcompfax(resultSetHead.getString("fax"));
				bean.setLblbranch(resultSetHead.getString("branchname"));
				bean.setLbllocation(resultSetHead.getString("location"));
				bean.setLblcstno(resultSetHead.getString("cstno"));
				bean.setLblpan(resultSetHead.getString("pbno"));
				bean.setLblservicetax(resultSetHead.getString("stcno"));
				bean.setLblpobox(resultSetHead.getString("pbno"));
			}

			ClsAmountToWords c = new ClsAmountToWords();
			
			String sqls="select m.doc_no,DATE_FORMAT(m.date ,'%d-%m-%Y') date,round(m.total,2) deprtotal,m.tr_no,u.user_name from gl_vehdepr m left join my_user u on "
					+ "m.userid=u.doc_no where m.dtype='VDP' and m.brhid="+branch+" and m.doc_no="+docNo+"";
				
			ResultSet resultSets = stmtVDP.executeQuery(sqls);
			
			while(resultSets.next()){
				
				bean.setLblvoucherno(resultSets.getString("doc_no"));
				bean.setLbldate(resultSets.getString("date"));
				bean.setLbldepreciationtotal(resultSets.getString("deprtotal"));
				bean.setLbldebittotal(resultSets.getString("deprtotal"));
				bean.setLblcredittotal(resultSets.getString("deprtotal"));
				bean.setLblnetamount(resultSets.getString("deprtotal"));
				bean.setLblnetamountwords(c.convertAmountToWords(resultSets.getString("deprtotal")));
				bean.setLblpreparedby(resultSets.getString("user_name"));
				trno=resultSets.getInt("tr_no");
			}
			
			bean.setTxtheader(header);
			
			String sql1 = "";

			sql1 = "select j.acno,if(j.dramount>0,round(j.dramount*j.id,2),'  ') debit ,if(j.dramount<0,round(j.dramount*j.id,2),'  ') credit,t.account,t.description codeno "
					+ "from my_jvtran j left join my_head t on j.acno=t.doc_no WHERE j.dtype='VDP' and j.tr_no="+trno+"";
				
			ResultSet resultSet1 = stmtVDP.executeQuery(sql1);
			
			ArrayList<String> printaccounting= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setFirstarray(1);
				String temp="";
				temp=resultSet1.getString("account")+"::"+resultSet1.getString("codeno")+"::"+resultSet1.getString("debit")+"::"+resultSet1.getString("credit");
				printaccounting.add(temp);
			}
			
			request.setAttribute("printaccounting", printaccounting);

			String sql2 = "";
		
			sql2 = "select g.fleet_no,v.flname,v.reg_no,DATE_FORMAT(v.prch_dte ,'%d-%m-%Y') prch_dte,round(v.prch_cost,2) prch_cost,round(g.depr,2) depr,g.frmDate frmdate,g.book_value bookvalue,"
					+ "if(g.dramount<0,(round(g.dramount,2))*-1,round(g.dramount,2)) depr_amt from gl_vehmaster v left join gc_assettran g on v.fleet_no=g.fleet_no "
					+ "where g.doc_no="+docNo+" and g.tr_no="+trno+"";
			
			ResultSet resultSet2 = stmtVDP.executeQuery(sql2);
			
			ArrayList<String> printarray= new ArrayList<String>();
			
			while(resultSet2.next()){
				bean.setSecarray(2); 
				String temp="";
				temp=resultSet2.getString("fleet_no")+"::"+resultSet2.getString("flname")+"::"+resultSet2.getString("reg_no")+"::"+resultSet2.getString("prch_dte")+"::"+resultSet2.getString("prch_cost")+"::"+resultSet2.getString("bookvalue")+"::"+resultSet2.getString("depr")+"::"+resultSet2.getString("depr_amt");
			    printarray.add(temp);
			}

			request.setAttribute("printingarray", printarray);
			
			String sql3 = "select max(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,max(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from gl_vehdepr m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='VDP' and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSet3 = stmtVDP.executeQuery(sql3);
			
			while(resultSet3.next()){
				bean.setLblpreparedon(resultSet3.getString("preparedon"));
				bean.setLblpreparedat(resultSet3.getString("preparedat"));
			}
		
			stmtVDP.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return bean;
	}
	
	public int insertion(Connection conn,int docno,String branch,int trno,String formdetailcode,Date depreciationDate, ArrayList<String> vehicledetailsarray,ArrayList<String> journalvouchersarray,
			 HttpSession session,String mode) throws SQLException{
		
		  try{
				conn.setAutoCommit(false);
				CallableStatement stmtVDP;
				Statement stmtVDP1 = conn.createStatement();
				
				String userid=session.getAttribute("USERID").toString().trim();
				
				/*Vehicle Details Grid and Details Saving*/
				for(int i=0;i< vehicledetailsarray.size();i++){
					String[] vehicledetail=vehicledetailsarray.get(i).split("::");
					if(!vehicledetail[0].trim().equalsIgnoreCase("undefined") && !vehicledetail[0].trim().equalsIgnoreCase("NaN")){
					
					int accountNo=0;
					/*Selecting account no.*/
					String sqls=("select acno from my_account where codeno='VAD'");
					ResultSet resultSets = stmtVDP1.executeQuery(sqls);
					    
					 while (resultSets.next()) {
						 accountNo=resultSets.getInt("acno");
					 }
					 /*Selecting account no. Ends*/
					 
					stmtVDP = conn.prepareCall("{CALL vehDepreciationdDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					/*Insertion to gc_assettran*/
					stmtVDP.setInt(10,trno); 
					stmtVDP.setInt(11,docno);
					stmtVDP.registerOutParameter(12, java.sql.Types.INTEGER);
					
					stmtVDP.setDate(1,depreciationDate); //Date
					stmtVDP.setInt(2,accountNo);  //doc_no of my_head
					stmtVDP.setString(3,(vehicledetail[0].trim().equalsIgnoreCase("undefined") || vehicledetail[0].trim().equalsIgnoreCase("NaN") || vehicledetail[0].trim().isEmpty()?0:vehicledetail[0].trim()).toString()); //fleet_no
					stmtVDP.setString(4,(vehicledetail[1].trim().equalsIgnoreCase("undefined") || vehicledetail[1].trim().equalsIgnoreCase("NaN") || vehicledetail[1].trim().isEmpty()?0:vehicledetail[1].trim()).toString()); //depr_amount
					stmtVDP.setString(5,(vehicledetail[2].trim().equalsIgnoreCase("undefined") || vehicledetail[2].trim().equalsIgnoreCase("NaN") || vehicledetail[2].trim().isEmpty()?0:vehicledetail[2].trim()).toString()); //From Date
					stmtVDP.setString(6,(vehicledetail[3].trim().equalsIgnoreCase("undefined") || vehicledetail[3].trim().equalsIgnoreCase("NaN") || vehicledetail[3].trim().isEmpty()?0:vehicledetail[3].trim()).toString()); //depr_perc
					stmtVDP.setString(7,(vehicledetail[4].trim().equalsIgnoreCase("undefined") || vehicledetail[4].trim().equalsIgnoreCase("NaN") || vehicledetail[4].trim().isEmpty()?0:vehicledetail[4].trim()).toString()); //book_value
					
					stmtVDP.setString(8,formdetailcode);
					stmtVDP.setString(9,branch);
					stmtVDP.setString(13,mode);
					int detail=stmtVDP.executeUpdate();
						if(detail<=0){
							stmtVDP.close();
							conn.close();
							return 0;
						}
     				  }
				    }
				    /*Vehicle Details Grid and Details Saving Ends*/
				
					/*Journal Voucher Grid Saving*/
					for(int i=0;i< journalvouchersarray.size();i++){
					String[] journal=journalvouchersarray.get(i).split("::");
					if(!journal[0].trim().equalsIgnoreCase("undefined") && !journal[0].trim().equalsIgnoreCase("NaN")){
					
					stmtVDP = conn.prepareCall("{CALL vehDeprJournaldDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					/*Insertion to my_jvtran*/
					stmtVDP.setInt(10,docno);
					stmtVDP.setInt(11,trno);
					stmtVDP.setDate(1,depreciationDate); //Date
					stmtVDP.setString(2,"VDP - "+docno);
					stmtVDP.setInt(3,(i+1)); //SR_No
					stmtVDP.setString(4,(journal[0].trim().equalsIgnoreCase("undefined") || journal[0].trim().equalsIgnoreCase("NaN") || journal[0].trim().isEmpty()?0:journal[0].trim()).toString());  //doc_no of my_head
					stmtVDP.setString(5,(journal[1].trim().equalsIgnoreCase("undefined") || journal[1].trim().equalsIgnoreCase("NaN") || journal[1].trim().isEmpty()?0:journal[1].trim()).toString()); //amount
					stmtVDP.setString(6,(journal[2].trim().equalsIgnoreCase("undefined") || journal[2].trim().equalsIgnoreCase("NaN") || journal[2].trim().isEmpty()?0:journal[2].trim()).toString()); //credit -1 & debit 1
					stmtVDP.setString(7,formdetailcode);
					stmtVDP.setString(8,branch);
					stmtVDP.setString(9,userid);
					stmtVDP.setString(12,mode);
					stmtVDP.execute();
						
						if(stmtVDP.getInt("docNo")<=0){
							stmtVDP.close();
							conn.close();
							return 0;
						}
						/*my_jvtran Grid Saving Ends*/
						stmtVDP.close();
					 }
				}	
					
					/*my_costtran Grid Saving*/
					
					/*for(int i=0;i< vehicledetailsarray.size();i++){
						CallableStatement stmtVDP2=null;
						String[] vehicledetails=vehicledetailsarray.get(i).split("::");
						if(!vehicledetails[0].trim().equalsIgnoreCase("undefined") && !vehicledetails[0].trim().equalsIgnoreCase("NaN")){
							
						int accountNo=0,tranid=0;
					    Selecting account no.
						String sqls=("select acno from my_account where codeno='VDE'");
						ResultSet resultSets = stmtVDP1.executeQuery(sqls);
						    
						 while (resultSets.next()) {
							 accountNo=resultSets.getInt("acno");
						 }
						 Selecting account no. Ends
						 
						 Selecting tranid
						 String sql1=("select tranid from my_jvtran where acno="+accountNo+" and tr_no="+trno+"");
						 ResultSet resultSet1 = stmtVDP1.executeQuery(sql1);
						    
						 while (resultSet1.next()) {
							 tranid=resultSet1.getInt("tranid");
						 }
						 Selecting tranid Ends
						
						stmtVDP2 = conn.prepareCall("insert into my_costtran(acno,costtype,amount,sr_no,jobid,tranid,tr_no) values(?,?,?,?,?,?,?)");
						
						stmtVDP2.setInt(1,accountNo); //doc_no of my_head
						stmtVDP2.setInt(2,6);//Cost Type
						stmtVDP2.setString(3,(vehicledetails[1].trim().equalsIgnoreCase("undefined") || vehicledetails[1].trim().equalsIgnoreCase("NaN") || vehicledetails[1].trim().isEmpty()?0:vehicledetails[1].trim()).toString()); //depr_amount
						stmtVDP2.setInt(4,(i+1)); //srNo
						stmtVDP2.setString(5,(vehicledetails[0].trim().equalsIgnoreCase("undefined") || vehicledetails[0].trim().equalsIgnoreCase("NaN") || vehicledetails[0].trim().isEmpty()?0:vehicledetails[0].trim()).toString()); //fleet_no
						stmtVDP2.setInt(6,tranid); //tranId
						stmtVDP2.setInt(7,trno); //trNo
					    int data = stmtVDP2.executeUpdate();
					    if(data<=0){
							stmtVDP2.close();
							conn.close();
							return 0;
						}
					    
					    String sql2 = "update my_jvtran set costtype=7,costcode=9999 where acno="+accountNo+" and tr_no="+trno+"";
				        stmtVDP1.executeUpdate(sql2);
				        
					 }
						stmtVDP2.close();
					}*/
					
					int accountNo=0,tranid=0;
					/*Selecting account no.*/
					String sqls=("select acno from my_account where codeno='VDE'");
					ResultSet resultSets = stmtVDP1.executeQuery(sqls);
					    
					 while (resultSets.next()) {
						 accountNo=resultSets.getInt("acno");
					 }
					 /*Selecting account no. Ends*/
					 
					 /*Selecting tranid*/
					 String sql1=("select tranid from my_jvtran where acno="+accountNo+" and tr_no="+trno+"");
					 ResultSet resultSet1 = stmtVDP1.executeQuery(sql1);
					    
					 while (resultSet1.next()) {
						 tranid=resultSet1.getInt("tranid");
					 }
					 /*Selecting tranid Ends*/
					 
					 String sql2 = "insert into my_costtran(acno, costType, amount, sr_no, tranid, jobId, tr_no) select '"+accountNo+"' acno,'6' costtype,"
							 + "if(dramount<0,dramount*-1,dramount) amount,@i:=@i+1 sr_no,'"+tranid+"' tranid,fleet_no jobid,tr_no from gc_assettran,(SELECT @i:= 0) as i "
							 + "where tr_no="+trno+"";
				     stmtVDP1.executeUpdate(sql2);
				        
				     String sql3 = "update my_jvtran set costtype=7,costcode=9999 where acno="+accountNo+" and tr_no="+trno+"";
				     stmtVDP1.executeUpdate(sql3);
				     
				     stmtVDP1.close();
					
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}
}
