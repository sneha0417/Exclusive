package com.aviation.pricemanagement;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.cargo.enquiry.ClscargoEnquiryBean;
import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsPriceManagementDAO {
	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();

	Connection conn;
	
	public int insert(Date masterdate, Date validfrom, Date validupto,String dtype, int cldocno, int currid,String pnotes, int psrno, 
			String mode,HttpSession session,HttpServletRequest request,ArrayList<String> masterarray) throws SQLException {		// TODO Auto-generated method stub
		try{
			int docno;
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtestm= conn.prepareCall("{call av_pricemanagementDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtestm.registerOutParameter(14, java.sql.Types.INTEGER);
			stmtestm.setInt(15, java.sql.Types.INTEGER);
			stmtestm.setDate(1,masterdate);
			stmtestm.setInt(2,Integer.parseInt(session.getAttribute("USERID").toString()));
			stmtestm.setInt(3,Integer.parseInt(session.getAttribute("BRANCHID").toString()));
		   	stmtestm.setInt(4,Integer.parseInt(session.getAttribute("COMPANYID").toString()));
			stmtestm.setInt(5,cldocno);
			stmtestm.setDate(6,validfrom);
			stmtestm.setDate(7,validupto);
			stmtestm.setString(8,dtype);
			stmtestm.setString(9,pnotes);
			stmtestm.setInt(10,psrno);
			stmtestm.setInt(11,currid);
			stmtestm.setString(12,"APM");
			stmtestm.setString(13,mode);
			
			stmtestm.executeQuery();
			docno=stmtestm.getInt("docNo");
			int vocno=stmtestm.getInt("vocNo");	
			request.setAttribute("vocno", vocno);
			if(docno<=0){
				conn.close();
				return 0;
			}
			
			System.out.println("--arraysize-----"+masterarray.size());
			for(int i=0;i< masterarray.size();i++){
			    String[] detmasterarrays=masterarray.get(i).split("::");
			    if(!(detmasterarrays[0].trim().equalsIgnoreCase("undefined")|| detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("null")||detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()))
			    {
			    	String sql="INSERT INTO av_fuelpriced(RDOCNO, SR_NO, PORTID, UNIT, price, tax, itax)VALUES"
						       + " ("+(docno)+","
							   + "'"+(i+1)+"',"
						       + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"',"
						       + "'"+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"',"
						       + "'"+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"',"
						       + "'"+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"',"
						       + "'"+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")||detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"' )";
				     int resultSet2 = stmtestm.executeUpdate(sql);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}
			     }
			 }
			if (docno > 0){
				conn.commit();
				stmtestm.close();
				conn.close();
				return docno;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return 0;
	}	
	public boolean edit(int docno,Date masterdate, Date validfrom, Date validupto,String dtype, int cldocno, int currid,String pnotes, int psrno, 
			String mode,HttpSession session,HttpServletRequest request,ArrayList<String> masterarray) throws SQLException {		// TODO Auto-generated method stub
		try{
			conn=ClsConnection.getMyConnection();
			
			conn.setAutoCommit(false);
			CallableStatement stmtestm= conn.prepareCall("{call av_pricemanagementDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtestm.setDate(1,masterdate);
			stmtestm.setInt(2,Integer.parseInt(session.getAttribute("USERID").toString()));
			stmtestm.setInt(3,Integer.parseInt(session.getAttribute("BRANCHID").toString()));
		   	stmtestm.setInt(4,Integer.parseInt(session.getAttribute("COMPANYID").toString()));
			stmtestm.setInt(5,cldocno);
			stmtestm.setDate(6,validfrom);
			stmtestm.setDate(7,validupto);
			stmtestm.setString(8,dtype);
			stmtestm.setString(9,pnotes);
			stmtestm.setInt(10, psrno);
			stmtestm.setInt(11,currid);
			stmtestm.setString(12, "APM");
			stmtestm.setString(13,mode);
			stmtestm.setInt(14,docno);
			stmtestm.setInt(15,0);
			System.out.println(stmtestm.toString());
			int aaa=stmtestm.executeUpdate();
			docno=stmtestm.getInt("docNo");
			
			int vocno=stmtestm.getInt("vocNo");	
			request.setAttribute("vocno", vocno);
			if(aaa<=0)
			{
				conn.close();
				return false;
			}
			
			for(int i=0;i< masterarray.size();i++){
				if(i==0){
					String delsqls="delete from av_fuelpriced where rdocno='"+docno+"' ";
					stmtestm.executeUpdate(delsqls);
				}
		    	
			    String[] detmasterarrays=masterarray.get(i).split("::");
			     
			    if(!(detmasterarrays[0].trim().equalsIgnoreCase("undefined")|| detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("null")||detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()))
			    {
			    	String sql="INSERT INTO av_fuelpriced(RDOCNO, SR_NO, PORTID, UNIT, price, tax, itax)VALUES"
						       + " ("+(docno)+","
							   + "'"+(i+1)+"',"
						       + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"',"
						       + "'"+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"',"
						       + "'"+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"',"
						       + "'"+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"',"
						       + "'"+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")||detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"' )";
						      
				     int resultSet2 = stmtestm.executeUpdate(sql);
				     if(resultSet2<=0)
						{
							conn.close();
							return false;
						}
				 
			     }
			     }
			if(docno>0){
				conn.commit();
				conn.close();
				return true;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return false;
	}
	
	public boolean delete(int docno,HttpSession session,String mode) throws SQLException {

		try{
			conn=ClsConnection.getMyConnection();

			CallableStatement stmtestm= conn.prepareCall("{call estimationDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtestm.setDate(1,null);
			stmtestm.setInt(2,Integer.parseInt(session.getAttribute("USERID").toString()));
			stmtestm.setInt(3,Integer.parseInt(session.getAttribute("BRANCHID").toString()));
		   	stmtestm.setInt(4,Integer.parseInt(session.getAttribute("COMPANYID").toString()));
		   	stmtestm.setInt(5,0);
			stmtestm.setDate(6,null);
			stmtestm.setDate(7,null);
			stmtestm.setString(8,null);
			stmtestm.setString(9,null);
			stmtestm.setString(10, null);
			stmtestm.setInt(11,0);
			stmtestm.setString(12, "APM");
			stmtestm.setString(13,mode);
			stmtestm.setInt(14,docno);
			stmtestm.setInt(15,0);

			int aaa=stmtestm.executeUpdate();
			if (aaa > 0) {
				stmtestm.close();
				conn.close();
				return true;
			}
			else{
				conn.close();
				return false;
			}
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return false;
	}
	
	public ClsPriceManagementBean getViewDetails(int docno, HttpSession session) throws SQLException {
		// TODO Auto-generated method stub
		ClsPriceManagementBean bean = new ClsPriceManagementBean();
		Connection conn=null;
		try { conn = ClsConnection.getMyConnection();
		Statement stmt  = conn.createStatement ();
		
		
		String sqls="select m.doc_no,m.voc_no,m.date,m.dtype,ac.cldocno,ac.refname,mn.psrno,mn.part_no,mn.productname,"
				+ " c.code currency,c.c_rate currate,m.currid,m.validfrm,m.validupto,m.pnotes"
				+ " from av_fuelpricem m left join av_fuelpriced d on m.doc_no=d.rdocno left join my_main mn on m.psrno=mn.psrno"
				+ " left join my_acbook ac on ac.cldocno=m.cldocno and ac.Dtype=if(m.dtype='S','CRM','VND') left join my_curr c on m.currid=c.doc_no"
				+ " where M.DOC_NO="+docno ;
		
		System.out.println("======sqls===="+sqls);
		
		ResultSet resultSet = stmt.executeQuery(sqls);
		while (resultSet.next()) {
			bean.setDocno(resultSet.getInt("voc_no"));
			bean.setMasterdoc_no(resultSet.getInt("doc_no"));
			bean.setMasterdate(resultSet.getString("date"));
			bean.setCmbtype(resultSet.getString("dtype"));
			bean.setPuraccid(Integer.parseInt(resultSet.getString("cldocno")));
			bean.setPuraccname(resultSet.getString("refname"));
			bean.setHidpsrno(Integer.parseInt(resultSet.getString("psrno")));
			bean.setPart_no(resultSet.getString("part_no"));
			bean.setPname(resultSet.getString("productname"));
			bean.setTxtcurrency(resultSet.getString("currency"));
			bean.setCurrate(resultSet.getString("currate"));
			bean.setCurrid(Integer.parseInt(resultSet.getString("currid")));
			bean.setFromdate(resultSet.getString("validfrm"));
			bean.setTodate(resultSet.getString("validupto"));
			bean.setDesc1(resultSet.getString("pnotes"));
		}
		stmt.close();
		conn.close();
		}
		catch(Exception e){
			
		e.printStackTrace();
		conn.close();
		}
		return bean;
	}
	
public   JSONArray accountsDetailsFrom(String date,String accountno, String accountname,String currency,String type,String chk) throws SQLException {
	JSONArray RESULTDATA=new JSONArray();
	Connection conn = null;
     java.sql.Date sqlDate=null;
     date.trim();
     String sqltest="";
     if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
     {
      sqlDate = ClsCommon.changeStringtoSqlDate(date);
     }
     
     if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
         sqltest=sqltest+" and t.account like '%"+accountno+"%'";
     }
     if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
      sqltest=sqltest+" and t.description like '%"+accountname+"%'";
     }
     if(!(currency.equalsIgnoreCase("0")) && !(currency.equalsIgnoreCase(""))){
       sqltest=sqltest+" and c.code like '%"+currency+"%'";
     }
  try {
     conn = ClsConnection.getMyConnection();
     if(chk.equalsIgnoreCase("1"))
     {
    	 
    	 if(type.equalsIgnoreCase("S"))
    	 {
    		 type="CRM"; 
    	 }
    	 else
    	 {
    		 type="VND"; 
    	 }
    	 
    	 
    	 
    	 Statement stmtCPV = conn.createStatement ();
    	 String  sql= "select t.doc_no,t.account,t.description,t.curid,c.code currency,a.cldocno,c.type,round(cb.rate,2) rate,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_head t inner join my_acbook a on t.doc_no=a.acno and "
            + "a.dtype='"+type+"' left join my_curr c on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
            + "from my_curbook cr where  coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where a.active=1 and t.m_s=0"+sqltest;
    	 System.out.println("==sql=="+sql);
    	 ResultSet resultSet = stmtCPV.executeQuery(sql);
    	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
    	 stmtCPV.close();
     }
    conn.close();
  }
  catch(Exception e){
   e.printStackTrace();
   conn.close();
  }
        return RESULTDATA;
    }
	public JSONArray productSearch(HttpSession session,String name,String code,String docnos,String load) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		if(!load.equalsIgnoreCase("yes"))
		{
			return RESULTDATA;
		}
		String sqltest="";
		if(!(docnos.equalsIgnoreCase("") )){
			sqltest=sqltest+" and  m.doc_no like '%"+docnos+"%'";
		}
		
		if(!(code.equalsIgnoreCase(""))){
			sqltest=sqltest+" and part_no like '%"+code+"%'";
		}
		if(!(name.equalsIgnoreCase(""))){
			sqltest=sqltest+" and productname like '%"+name+"%'";
		}
		
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
		 
			String sql="select m.psrno,m.doc_no,m.part_no productcode,m.productname from my_main m   where m.status=3 ";
			System.out.println("==productSearch==="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	public JSONArray currencySearch() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtCRM = conn.createStatement();
			ResultSet resultSet = stmtCRM.executeQuery ("select doc_no curid,code currency,round(c_rate,2) rate from my_curr where status=3");
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
	public JSONArray taxDataLoad(String price,String rdocno,String dat) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtCRM = conn.createStatement();
			String sql="select t.taxid,t.rdocno,m.tax,m.desc1 taxname,'usc' as curr,t.perc percentage,t.amount from av_taxdet t "
			+" left join av_taxm m on t.taxid=m.doc_no where m.status=3 and t.rdocno="+rdocno+" and t.ttype="+dat+" " ;
			System.out.println("taxgridsql====="+sql);
			ResultSet resultSet = stmtCRM.executeQuery (sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
	public   JSONArray maingridreload(String doc) throws SQLException {
		 
		JSONArray RESULTDATA=new JSONArray();
	    Connection conn = null;
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();  
	        	String pySql="select d.idno doc_no,d.portid,p.port,p.desc1 region,d.unit unitid,u.unit,d.price,d.tax,d.itax"
	        			+ " from av_fuelpricem m left join av_fuelpriced d on m.doc_no=d.rdocno left join my_port p on d.portid=p.doc_no"
	        			+ " left join my_unitm u on d.unit=u.doc_no where rdocno="+doc;
				
	        	System.out.println("pySql----"+pySql);
	        	ResultSet resultSet = stmt.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
				stmt.close();
				conn.close();
		} 
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}
	
	public JSONArray unitSearch() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtCRM = conn.createStatement();
			ResultSet resultSet = stmtCRM.executeQuery ("select doc_no,unit from my_unitm where status=3");
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
	public JSONArray taxSearch() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtCRM = conn.createStatement();
			ResultSet resultSet = stmtCRM.executeQuery ("select doc_no,tax,desc1 from av_taxm where status=3");
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
	
	public   JSONArray searchPort() throws SQLException {


	   	 JSONArray RESULTDATA=new JSONArray();
	   	 
	    	Connection conn = null;
	    
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh1 = conn.createStatement ();
	            	
					String clsql= ("select doc_no,port,desc1 portname,country region from my_port where status=3");
					
					System.out.println("========"+clsql);
					ResultSet resultSet = stmtVeh1.executeQuery(clsql);
					
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVeh1.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	
	public   JSONArray mainsearch(HttpSession session,String docno,String type,String clientname,String date,String aa,String product,String note) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
	    Enumeration<String> Enumeration = session.getAttributeNames();
	    int a=0;
	    while(Enumeration.hasMoreElements()){
	     if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
	      a=1;
	     }
	    }
	    if(a==0){
	    	return RESULTDATA;
	    }
	    String brcid=session.getAttribute("BRANCHID").toString();
	    java.sql.Date  sqlStartDate = null;
	    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
	      	sqlStartDate = ClsCommon.changeStringtoSqlDate(date);
	    }
	    String sqltest="";
	  	    
	  	   	if((!(docno.equalsIgnoreCase(""))) && (!(docno.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and m.voc_no like '%"+docno+"%'";
	      	}
	      	if((!(type.equalsIgnoreCase(""))) && (!(type.equalsIgnoreCase("NA")))){
	      		//sqltest=sqltest+" and m.dtype like '%"+type+"%'  ";
	     
	       	sqltest=sqltest+" and m.dtype like '%"+type+"%'  ";
      		
	       	  
	      		
	      	}
	      	if((!(clientname.equalsIgnoreCase(""))) && (!(clientname.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and ac.refname like '%"+clientname+"%'";
	      	}
	      	if((!(note.equalsIgnoreCase(""))) && (!(note.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and m.pnotes like '%"+note+"%'";
	      	}
	      	if((!(product.equalsIgnoreCase(""))) && (!(product.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and mn.productname like '%"+product+"%'";
	      	}
	      	if(!(sqlStartDate==null)){
	      		sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
	      	}
	    
	    Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			if(aa.equalsIgnoreCase("yes"))
			{	
				Statement stmtmain = conn.createStatement ();
	        	String pySql=("select m.doc_no,m.voc_no,m.date,if(m.dtype='S','Sales','Purchase') dtype,ac.cldocno,ac.refname,mn.psrno,mn.part_no,mn.productname,c.code currency,c.c_rate currate,m.currid,m.validfrm,m.validupto,m.pnotes"
	        			+ " from av_fuelpricem m left join my_main mn on m.psrno=mn.psrno"
	        			+ " left join my_acbook ac on ac.cldocno=m.cldocno and ac.Dtype=if(m.dtype='S','CRM','VND') left join my_curr c on m.currid=c.doc_no"
	        			+ " where m.status=3 "+sqltest+" ");
	        	//System.out.println("--searchsql--"+pySql);
				ResultSet resultSet = stmtmain.executeQuery(pySql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
				stmtmain.close();
			}
			conn.close();
			return RESULTDATA;
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	    return RESULTDATA;
	}
}
