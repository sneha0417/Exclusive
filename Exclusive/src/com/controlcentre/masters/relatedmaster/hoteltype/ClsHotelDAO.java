package com.controlcentre.masters.relatedmaster.hoteltype;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsHotelDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();
	ClsHotelBean checkinBean = new ClsHotelBean();
	Connection conn;
	
	public int insert( String name,String areaid,String lattitude,String longitude,ArrayList<String> beniarray,String loc,String vendid, HttpSession session,String mode,String formdetailcode,int infmin,int infmax,int childmin,int childmax,int teenmin,int teenmax,String rating) throws SQLException {
		try{
//			System.out.println("DAO");
//			System.out.println(mode);
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			int docno;
			
			CallableStatement stmtServiceType = conn.prepareCall("{call hotelDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmtServiceType.registerOutParameter(8, java.sql.Types.INTEGER);
			stmtServiceType.setString(1, name);
			stmtServiceType.setString(2, areaid);
			stmtServiceType.setString(3, lattitude);
			stmtServiceType.setString(4, longitude);
			stmtServiceType.setString(5, loc);
			stmtServiceType.setString(6,session.getAttribute("BRANCHID").toString());
			stmtServiceType.setString(7,session.getAttribute("USERID").toString());
			stmtServiceType.setString(9,mode);
			stmtServiceType.setString(10, formdetailcode);
			stmtServiceType.setString(11, vendid);
			stmtServiceType.setInt(12, infmin);
			stmtServiceType.setInt(13, infmax);
			stmtServiceType.setInt(14, childmin);
			stmtServiceType.setInt(15, childmax);
			stmtServiceType.setInt(16, teenmin);
			stmtServiceType.setInt(17, teenmax);
			stmtServiceType.setString(18, rating);
			stmtServiceType.executeUpdate();

			docno=stmtServiceType.getInt("docNo");
//			System.out.println("docno==="+docno);
			if(docno<=0) {
				conn.close();
				return 0;
			}
			//System.out.println("in"+beniarray.size());
			for(int i=0;i< beniarray.size();i++){
			     String[] beniarraysec=beniarray.get(i).split("::");
			     
			     
			     if(!(beniarraysec[0].trim().equalsIgnoreCase("undefined")|| beniarraysec[0].trim().equalsIgnoreCase("NaN")||beniarraysec[0].trim().equalsIgnoreCase("")|| beniarraysec[0].isEmpty())) {
			    	 
			    	String sql="INSERT INTO tr_hoteld(rtypeid,name,adult,child,extrabed,roomsize,adultonly,maxcount,rdocno)VALUES"
			    	   + "('"+(beniarraysec[0].trim().equalsIgnoreCase("undefined") || beniarraysec[0].trim().equalsIgnoreCase("NaN")|| beniarraysec[0].trim().equalsIgnoreCase("")|| beniarraysec[0].isEmpty()?0:beniarraysec[0].trim())+"',"
			    	   +"'"+(beniarraysec[1].trim().equalsIgnoreCase("undefined") || beniarraysec[1].trim().equalsIgnoreCase("NaN")|| beniarraysec[1].trim().equalsIgnoreCase("")|| beniarraysec[1].isEmpty()?0:beniarraysec[1].trim())+"',"
			    	   +"'"+(beniarraysec[2].trim().equalsIgnoreCase("undefined") || beniarraysec[2].trim().equalsIgnoreCase("NaN")|| beniarraysec[2].trim().equalsIgnoreCase("")|| beniarraysec[2].isEmpty()?0:beniarraysec[2].trim())+"',"
				       +"'"+(beniarraysec[3].trim().equalsIgnoreCase("undefined") || beniarraysec[3].trim().equalsIgnoreCase("NaN")|| beniarraysec[3].trim().equalsIgnoreCase("")|| beniarraysec[3].isEmpty()?0:beniarraysec[3].trim())+"',"
				       +"'"+(beniarraysec[4].trim().equalsIgnoreCase("undefined") || beniarraysec[4].trim().equalsIgnoreCase("NaN")|| beniarraysec[4].trim().equalsIgnoreCase("")|| beniarraysec[4].isEmpty()?0:beniarraysec[4].trim())+"',"
			    	   +"'"+(beniarraysec[6].trim().equalsIgnoreCase("undefined") || beniarraysec[6].trim().equalsIgnoreCase("NaN")|| beniarraysec[6].trim().equalsIgnoreCase("")|| beniarraysec[6].isEmpty()?0.0:Double.parseDouble(beniarraysec[6].trim()))+"',"
				       +"'"+(beniarraysec[7].trim().equalsIgnoreCase("undefined") || beniarraysec[7].trim().equalsIgnoreCase("NaN")|| beniarraysec[7].trim().equalsIgnoreCase("")|| beniarraysec[7].isEmpty()?0:Integer.parseInt(beniarraysec[7].trim()))+"',"
			    	   +"'"+(beniarraysec[8].trim().equalsIgnoreCase("undefined") || beniarraysec[8].trim().equalsIgnoreCase("NaN")|| beniarraysec[8].trim().equalsIgnoreCase("")|| beniarraysec[8].isEmpty()?0:Integer.parseInt(beniarraysec[8].trim()))+"',"
				       +"'"+docno+"')" ;
			    	//System.out.println("insertsave=="+sql);
				     int resultSet2 = stmtServiceType.executeUpdate(sql);
				 	//System.out.println("resultSet2==="+resultSet2);
				     if(resultSet2<=0) {
							conn.close();
							return 0;
						}
			     }
			     
			
			}
			
			if (docno > 0) {
				
				conn.commit();
				stmtServiceType.close();
				conn.close();
				return docno;
			}
			else if (docno == -1){
				stmtServiceType.close();
				conn.close();
				return docno;
			}
			stmtServiceType.close();
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

	public int edit( String name,String areaid,String lattitude,String longitude,ArrayList<String> beniarray,String loc,String vendid,HttpSession session,String mode,int docno,String formdetailcode,int infmin,int infmax,int childmin,int childmax,int teenmin,int teenmax,String rating) throws SQLException {
	
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			//System.out.println("vendid========"+vendid);
			CallableStatement stmtServiceType = conn.prepareCall("{call hotelDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmtServiceType.setInt(8, docno);
			stmtServiceType.setString(1,name);
			stmtServiceType.setString(2, areaid);
			stmtServiceType.setString(3, lattitude);
			stmtServiceType.setString(4, longitude);
			stmtServiceType.setString(5, loc);
			stmtServiceType.setString(6,session.getAttribute("BRANCHID").toString());
			stmtServiceType.setString(7,session.getAttribute("USERID").toString());
			stmtServiceType.setString(9,"E");
			stmtServiceType.setString(10, formdetailcode);
			stmtServiceType.setString(11, vendid);
			stmtServiceType.setInt(12, infmin);
			stmtServiceType.setInt(13, infmax);
			stmtServiceType.setInt(14, childmin);
			stmtServiceType.setInt(15, childmax);
			stmtServiceType.setInt(16, teenmin);
			stmtServiceType.setInt(17, teenmax);
			stmtServiceType.setString(18, rating);
			stmtServiceType.executeUpdate();

			//System.out.println(mode);
			
			int documentNo=stmtServiceType.getInt("docNo");
			
			if(documentNo<=0) {
		    	conn.close();
		    	return 0;
		    }
			
			
			   for(int i=0;i< beniarray.size();i++){
				
			     String[] beniarraysec=beniarray.get(i).split("::");
			     String chk=(beniarraysec[5].trim().equalsIgnoreCase("undefined")|| beniarraysec[5].trim().equalsIgnoreCase("NaN")||beniarraysec[5].trim().equalsIgnoreCase("")|| beniarraysec[5].isEmpty()?0:beniarraysec[5].trim()).toString();
			    
			     /*String tst=(beniarraysec[6].trim().equalsIgnoreCase("undefined")|| beniarraysec[6].trim().equalsIgnoreCase("NaN")||beniarraysec[6].trim().equalsIgnoreCase("")|| beniarraysec[6].isEmpty()?"false":beniarraysec[6].trim()).toString();*/
			     /* String delsql4="select rtypeid from tr_hoteld where rdocno="+documentNo+" and rtypeid in("+chk+")" ;
					//System.out.println(delsql4);
					stmtServiceType.executeUpdate(delsql4);*/
			     int chks=Integer.parseInt(chk);
			     if(chks>0){
			    	// System.out.println("inupdate==");
			    	 
			    	 String sqls="update tr_hoteld set rtypeid='"+(beniarraysec[0].trim().equalsIgnoreCase("undefined") || beniarraysec[0].trim().equalsIgnoreCase("NaN")|| beniarraysec[0].trim().equalsIgnoreCase("")|| beniarraysec[0].isEmpty()?0:beniarraysec[0].trim())+"',name='"+(beniarraysec[1].trim().equalsIgnoreCase("undefined") || beniarraysec[1].trim().equalsIgnoreCase("NaN")|| beniarraysec[1].trim().equalsIgnoreCase("")|| beniarraysec[1].isEmpty()?0:beniarraysec[1].trim())+"',adult='"+(beniarraysec[2].trim().equalsIgnoreCase("undefined") || beniarraysec[2].trim().equalsIgnoreCase("NaN")|| beniarraysec[2].trim().equalsIgnoreCase("")|| beniarraysec[2].isEmpty()?0:beniarraysec[2].trim())+"',"
			    	 		+ "child='"+(beniarraysec[3].trim().equalsIgnoreCase("undefined") || beniarraysec[3].trim().equalsIgnoreCase("NaN")|| beniarraysec[3].trim().equalsIgnoreCase("")|| beniarraysec[3].isEmpty()?0:beniarraysec[3].trim())+"',extrabed='"+(beniarraysec[4].trim().equalsIgnoreCase("undefined") || beniarraysec[4].trim().equalsIgnoreCase("NaN")|| beniarraysec[4].trim().equalsIgnoreCase("")|| beniarraysec[4].isEmpty()?0:beniarraysec[4].trim())+"',"
			    	 		+ "roomsize='"+(beniarraysec[6].trim().equalsIgnoreCase("undefined") || beniarraysec[6].trim().equalsIgnoreCase("NaN")|| beniarraysec[6].trim().equalsIgnoreCase("")|| beniarraysec[6].isEmpty()?0.0:Double.parseDouble(beniarraysec[6].trim()))+"',adultonly='"+(beniarraysec[7].trim().equalsIgnoreCase("undefined") || beniarraysec[7].trim().equalsIgnoreCase("NaN")|| beniarraysec[7].trim().equalsIgnoreCase("")|| beniarraysec[7].isEmpty()?0:Integer.parseInt(beniarraysec[7].trim()))+"',"
			    	 		+ "maxcount='"+(beniarraysec[8].trim().equalsIgnoreCase("undefined") || beniarraysec[8].trim().equalsIgnoreCase("NaN")|| beniarraysec[8].trim().equalsIgnoreCase("")|| beniarraysec[8].isEmpty()?0:Integer.parseInt(beniarraysec[8].trim()))+"' where rdocno="+documentNo+" and srno="+chks+"";
			    	 //System.out.println("inupdate=="+sqls);
		     
				     int resultSet2 = stmtServiceType.executeUpdate(sqls);
				     if(resultSet2<=0) {
							conn.close();
							return 0;
						}
			    	
			     }else{
			    	
			    	// System.out.println("ininsert==");	
			    	 
			     String sql="INSERT INTO tr_hoteld(rtypeid,name,adult,child,extrabed,roomsize,adultonly,maxcount,rdocno)VALUES " 
					       + "('"+(beniarraysec[0].trim().equalsIgnoreCase("undefined") || beniarraysec[0].trim().equalsIgnoreCase("NaN")|| beniarraysec[0].trim().equalsIgnoreCase("")|| beniarraysec[0].isEmpty()?0:beniarraysec[0].trim())+"',"
					       +"'"+(beniarraysec[1].trim().equalsIgnoreCase("undefined") || beniarraysec[1].trim().equalsIgnoreCase("NaN")|| beniarraysec[1].trim().equalsIgnoreCase("")|| beniarraysec[1].isEmpty()?0:beniarraysec[1].trim())+"',"
				    	   +"'"+(beniarraysec[2].trim().equalsIgnoreCase("undefined") || beniarraysec[2].trim().equalsIgnoreCase("NaN")|| beniarraysec[2].trim().equalsIgnoreCase("")|| beniarraysec[2].isEmpty()?0:beniarraysec[2].trim())+"',"
					       +"'"+(beniarraysec[3].trim().equalsIgnoreCase("undefined") || beniarraysec[3].trim().equalsIgnoreCase("NaN")|| beniarraysec[3].trim().equalsIgnoreCase("")|| beniarraysec[3].isEmpty()?0:beniarraysec[3].trim())+"',"
					       +"'"+(beniarraysec[4].trim().equalsIgnoreCase("undefined") || beniarraysec[4].trim().equalsIgnoreCase("NaN")|| beniarraysec[4].trim().equalsIgnoreCase("")|| beniarraysec[4].isEmpty()?0:beniarraysec[4].trim())+"',"
					       +"'"+(beniarraysec[6].trim().equalsIgnoreCase("undefined") || beniarraysec[6].trim().equalsIgnoreCase("NaN")|| beniarraysec[6].trim().equalsIgnoreCase("")|| beniarraysec[6].isEmpty()?0.0:Double.parseDouble(beniarraysec[6].trim()))+"',"
				           +"'"+(beniarraysec[7].trim().equalsIgnoreCase("undefined") || beniarraysec[7].trim().equalsIgnoreCase("NaN")|| beniarraysec[7].trim().equalsIgnoreCase("")|| beniarraysec[7].isEmpty()?0:Integer.parseInt(beniarraysec[7].trim()))+"',"
			    	       +"'"+(beniarraysec[8].trim().equalsIgnoreCase("undefined") || beniarraysec[8].trim().equalsIgnoreCase("NaN")|| beniarraysec[8].trim().equalsIgnoreCase("")|| beniarraysec[8].isEmpty()?0:Integer.parseInt(beniarraysec[8].trim()))+"',"
					       +"'"+documentNo+"')";
			     //System.out.println("update=="+sql);
					     int resultSet2 = stmtServiceType.executeUpdate(sql);
					     if(resultSet2<=0) {
								conn.close();
								return 0;
							}
				      
			    	 
			    	 
			     }
			}
			
			if (documentNo > 0) {
				
				conn.commit();
				stmtServiceType.close();
				conn.close();
				return 1;
			}
			else if (documentNo == -1){
				stmtServiceType.close();
				conn.close();
				return documentNo;
			}
			
			
			
			stmtServiceType.close();
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


	public boolean delete( String name,String areaid,String lattitude,String longitude,ArrayList<String> beninarray,String loc,String vendid,HttpSession session,String mode,int docno,String formdetailcode,int infmin,int infmax,int childmin,int childmax,int teenmin,int teenmax,String rating) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtServiceType = conn.prepareCall("{call hotelDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		
			stmtServiceType.setInt(8, docno);
			stmtServiceType.setString(1,name);
			stmtServiceType.setString(2, areaid);
			stmtServiceType.setString(3, lattitude);
			stmtServiceType.setString(4, longitude);
			stmtServiceType.setString(5, loc);
			stmtServiceType.setString(6,session.getAttribute("BRANCHID").toString());
			stmtServiceType.setString(7,session.getAttribute("USERID").toString());
			stmtServiceType.setString(9,"D");
			stmtServiceType.setString(10, formdetailcode);
			stmtServiceType.setString(11, vendid);
			stmtServiceType.setInt(12, infmin);
			stmtServiceType.setInt(13, infmax);
			stmtServiceType.setInt(14, childmin);
			stmtServiceType.setInt(15, childmax);
			stmtServiceType.setInt(16, teenmin);
			stmtServiceType.setInt(17, teenmax);
			stmtServiceType.setString(18, rating);
			stmtServiceType.executeUpdate();

			int documentNo=stmtServiceType.getInt("docNo");
			if (documentNo > 0) {
				conn.commit();
				stmtServiceType.close();
				return true;
			}	
			stmtServiceType.close();
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

/*	public  List<ClsHotelBean> list() throws SQLException {
	    List<ClsHotelBean> listBean = new ArrayList<ClsHotelBean>();
	    Connection conn = null;
	    
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtSalesAgent = conn.createStatement();
	        	
				ResultSet resultSet = stmtSalesAgent.executeQuery ("select m.doc_no, m.name, m.areaid,a.area, m.location, m.latitude, m.longitude "+
				" from tr_hotel m left join my_area a on a.doc_no=m.areaid where m.status<>7 ");

				while (resultSet.next()) {
					
					ClsHotelBean bean = new ClsHotelBean();
	            	bean.setDocno(resultSet.getInt("doc_no"));
					bean.setName(resultSet.getString("name"));
					bean.setTxtarea(resultSet.getString("area"));
					bean.setTxtareaid(resultSet.getString("areaid"));
					bean.setLocation(resultSet.getString("location"));
					bean.setLatitude(resultSet.getString("latitude"));
					bean.setLongitude(resultSet.getString("longitude"));
					
					listBean.add(bean);
				}
				stmtSalesAgent.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return listBean;
	}
	*/
	 public  JSONArray hotelsearch() throws SQLException {
	        //System.out.println("in hotel search");
		    JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn = null;

	        try {
					conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement();
	            	String sql="select m.infmin,m.infmax,m.childmin,m.childmax,m.teenmin,m.teenmax,m.rating,m.doc_no, m.name, m.areaid,a.area, m.location, m.latitude lat, m.longitude,ac.refname vendor,m.vendorid vendid "+
								" from tr_hotel m left join tr_hoteld d on d.rdocno=m.doc_no left join my_area a on a.doc_no=m.areaid "
								+ " left join my_acbook ac on ac.doc_no=m.vendorid and dtype='VND' where m.status<>7 group by m.doc_no";
//	            	System.out.println(sql);
					ResultSet resultSet = stmtVeh.executeQuery (sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtVeh.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
	public JSONArray vendorSearch(HttpSession session) throws SQLException
	{

		JSONArray RESULTDATA=new JSONArray();

		Connection conn =null;
		Statement stmt =null;
		try {
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();


			String sql= "select ma.cldocno vendorid,ma.refname vendor from my_acbook ma where ma.status=3 and ma.dtype='VND'";
			//System.out.println("Vendor search--------------"+sql);
			ResultSet resultSet = stmt.executeQuery(sql) ;
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		//	System.out.println(RESULTDATA);
		return RESULTDATA;

	}
	
	public  JSONArray getHotelGrid(String docno,String id) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }
        Connection conn = null;
		try {
				conn=ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
				String sqldata="";
				//System.out.println("****"+docno);
            	 /*sqldata="select d.srno,d.name,d.adult,d.child,d.extrabed,'Attach' btnattach,wt.doc_no rtypeid,wt.name roomtype,wt.remarks category,if(d.srno is null,0,1)  val from tr_roomtype wt  left join tr_hoteld d on d.rtypeid=wt.doc_no  and d.rdocno="+docno+"  where wt.status=3";*/
				sqldata="select d.roomsize,d.maxcount,d.adultonly,d.srno,d.name,d.adult,d.child,d.extrabed,'Attach' btnattach,wt.doc_no rtypeid,wt.name roomtype,wt.remarks category from tr_hoteld d left join tr_roomtype wt on d.rtypeid=wt.doc_no  and d.rdocno="+docno+"  where wt.status=3" ;
				
            	System.out.println("hotel=="+sqldata);
				ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtVeh1.close();
				conn.close();
				 return RESULTDATA;

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	public  JSONArray roomDetails() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				conn=ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
            	String sqldata="select wt.doc_no,concat(wt.name,' ',wt.remarks)name,wt.remarks  from tr_roomtype wt where status=3";
            	//System.out.println("room=="+sqldata);
				ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtVeh1.close();
				conn.close();
				 return RESULTDATA;

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	public  JSONArray searchRoom() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				conn=ClsConnection.getMyConnection();
				Statement stmtVeh3 = conn.createStatement ();
            	String sqldata="select wt.doc_no,wt.name,wt.remarks from tr_roomtype wt where status=3";
            	System.out.println("cat=="+sqldata);
				ResultSet resultSet = stmtVeh3.executeQuery (sqldata);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtVeh3.close();
				conn.close();
				 return RESULTDATA;

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	public   JSONArray areaSearch(HttpSession session) throws SQLException
	{

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
		Connection conn =null;
		Statement stmt  =null;
		ResultSet resultSet =null;

		try {
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();

			String sql= ("select a.doc_no as areadocno,a.area as area,c.city_name as city_name,ac.country_name as country_name,r.reg_name as region_name from my_area a inner join my_acity c on(a.city_id=c.doc_no) inner join my_acountry ac on(ac.doc_no=c.country_id) inner join my_aregion r on(r.doc_no=ac.reg_id) where a.status=3 and c.status=3 and ac.status=3 and r.status=3" );
			resultSet = stmt.executeQuery(sql) ;
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			resultSet.close();
			stmt.close();
			conn.close();


		}
		return RESULTDATA;

	}
	
	
   }
