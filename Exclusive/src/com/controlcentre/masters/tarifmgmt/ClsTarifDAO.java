
package com.controlcentre.masters.tarifmgmt;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
public class ClsTarifDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	ClsTarifBean tarifbean=new ClsTarifBean();

	public int insert(java.sql.Date sqlStartDate,java.sql.Date fromdate,java.sql.Date todate, String cmbtariftype,String cmbtariffor,String notes,String hidcheck,int hidclient,HttpSession session,
			String mode,String formdetailcode) throws SQLException{
Connection conn=ClsConnection.getMyConnection();
		try{
			int aaa;

			conn.setAutoCommit(false);
			if(hidcheck.equalsIgnoreCase("")){
				hidcheck="0";
			}
			
			CallableStatement stmtTarif = conn.prepareCall("{call tarifDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtTarif.registerOutParameter(11, java.sql.Types.INTEGER);
			stmtTarif.setDate(1,fromdate);
			stmtTarif.setDate(2,todate);
			stmtTarif.setString(3,cmbtariftype);
			stmtTarif.setString(4,notes);
			stmtTarif.setDate(5,sqlStartDate);
			stmtTarif.setString(6,cmbtariffor);
			stmtTarif.setString(7,hidcheck);
			stmtTarif.setInt(8, hidclient);
			stmtTarif.setString(10,session.getAttribute("BRANCHID").toString());
			stmtTarif.setString(9,session.getAttribute("USERID").toString());
			
			stmtTarif.setString(12,mode);
			stmtTarif.setString(13,formdetailcode);

			stmtTarif.executeQuery();
			
			aaa=stmtTarif.getInt("docNo");
		//	System.out.println("no====="+aaa);
			tarifbean.setDocno(aaa);
			if (aaa > 0) {
				
				//System.out.println("Sucess"+tarifbean.getDocno());
				conn.commit();
				stmtTarif.close();
				conn.close();
				return aaa;
			}
			stmtTarif.close();
			conn.close();
		}catch(Exception e){	
			e.printStackTrace();
			conn.close();
			
		}
		return 0;
	}
	

public boolean edit(Date sqlStartDate,Date fromdate,Date todate, String cmbtariftype,String cmbtariffor,String notes,String hidcheck,int hidclient,HttpSession session,
		String mode,int docno,String formdetailcode) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
	try{
		
		conn.setAutoCommit(false);
		//System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
		CallableStatement stmtTarif = conn.prepareCall("{call tarifDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		stmtTarif.setInt(11, docno);
		stmtTarif.setDate(1,fromdate);
		stmtTarif.setDate(2,todate);
		stmtTarif.setString(3,cmbtariftype);
		stmtTarif.setString(4,notes);
		stmtTarif.setDate(5,sqlStartDate);
		stmtTarif.setString(6,cmbtariffor);
		stmtTarif.setString(7,hidcheck);
		stmtTarif.setInt(8, hidclient);
		stmtTarif.setString(10,session.getAttribute("BRANCHID").toString());
		stmtTarif.setString(9,session.getAttribute("USERID").toString());
		
		stmtTarif.setString(12,mode);
		stmtTarif.setString(13,formdetailcode);

		int aa = stmtTarif.executeUpdate();
		//System.out.println("inside DAO1");
		if (aa>0) {
			conn.commit();
			//System.out.println("Sucess");
			stmtTarif.close();
			conn.close();
			return true;
		}

		stmtTarif.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	
	
	return false;
}


public boolean delete(Date sqlStartDate,Date fromdate,Date todate, String cmbtariftype,String cmbtariffor,String notes,String hidcheck,int hidclient,HttpSession session,
		String mode,int docno,String formdetailcode) throws SQLException {
	Connection conn=ClsConnection.getMyConnection();
	try{
		
		conn.setAutoCommit(false);
		//System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
		CallableStatement stmtTarif = conn.prepareCall("{call tarifDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		stmtTarif.setInt(11, docno);
		stmtTarif.setDate(1,fromdate);
		stmtTarif.setDate(2,todate);
		stmtTarif.setString(3,cmbtariftype);
		stmtTarif.setString(4,notes);
		stmtTarif.setDate(5,sqlStartDate);
		stmtTarif.setString(6,cmbtariffor);
		stmtTarif.setString(7,hidcheck);
		stmtTarif.setInt(8, hidclient);
		stmtTarif.setString(10,session.getAttribute("BRANCHID").toString());
		stmtTarif.setString(9,session.getAttribute("USERID").toString());
		
		stmtTarif.setString(12,mode);
		stmtTarif.setString(13,formdetailcode);

		int aa = stmtTarif.executeUpdate();
		if (aa>0) {
//			System.out.println("Sucess");
			conn.commit();
			stmtTarif.close();
			conn.close();
			return true;
		}

		stmtTarif.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	
	
	return false;
}


	public   List<ClsTarifBean> list(int docno,String tempgroup) throws SQLException {
        List<ClsTarifBean> listBean = new ArrayList<ClsTarifBean>();
        Connection conn = ClsConnection.getMyConnection();
		try {
				
				Statement stmtTarif = conn.createStatement ();
            	
				ResultSet resultSet = stmtTarif.executeQuery ("select m1.gid from gl_vehgroup m1 left join gl_tarifd m2 on (m1.gid=m2.gid and m2.doc_no='"+docno+"') where m1.gid not in"+
"(SELECT gid FROM gl_tarifd WHERE doc_no='"+docno+"') and m1.status<>7");

				while (resultSet.next()) {
					
					ClsTarifBean bean = new ClsTarifBean();
	            	bean.setGroup(resultSet.getString("gid"));
					
	            	listBean.add(bean);
	            	
            	//System.out.println(listBean);
				}
				stmtTarif.close();
				conn.close();
				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
//System.out.println("nitin===="+listBean);
        return listBean;
    }
	public  List<ClsTarifBean> list1() throws SQLException {
        List<ClsTarifBean> listBean = new ArrayList<ClsTarifBean>();
//System.out.println("Tarifdao");
Connection conn = ClsConnection.getMyConnection();		
try {
				
				Statement stmtTarif = conn.createStatement ();
            	
				ResultSet resultSet = stmtTarif.executeQuery ("select rentaltype from gl_tlistm where status=1 order by doc_no");

				while (resultSet.next()) {
					
					ClsTarifBean bean = new ClsTarifBean();
	            	bean.setRatedesc(resultSet.getString("rentaltype"));
	            
	            	listBean.add(bean);
	            	
				}
				stmtTarif.close();
				conn.close();
				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
//System.out.println("nitin===="+listBean);
        return listBean;
    }
	public  List<ClsTarifBean> list2() throws SQLException {
        List<ClsTarifBean> listBean = new ArrayList<ClsTarifBean>();
        Connection conn = ClsConnection.getMyConnection();
		try {
				
				Statement stmtTarif = conn.createStatement ();
            	
				ResultSet resultSet = stmtTarif.executeQuery ("select distinct(ratedesc) from gl_ratedesc where status<>7");

				while (resultSet.next()) {
					
					ClsTarifBean bean = new ClsTarifBean();
	            	bean.setRatedesc(resultSet.getString("ratedesc"));
					
	            	listBean.add(bean);
	            	
            	//System.out.println(listBean);
				}
				stmtTarif.close();
				conn.close();
			
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
//System.out.println("nitin===="+listBean);
        return listBean;
    }

public  List<ClsTarifBean> list3() throws SQLException {
    List<ClsTarifBean> listBean = new ArrayList<ClsTarifBean>();
    Connection conn = ClsConnection.getMyConnection();
	try {
			
			Statement stmtTarif = conn.createStatement ();
        	
			ResultSet resultSet = stmtTarif.executeQuery ("select branch,area,tariff from gl_tarifdelivery");

			while (resultSet.next()) {
				
				ClsTarifBean bean = new ClsTarifBean();
            	bean.setBranch(resultSet.getString("branch"));
            	bean.setArea(resultSet.getString("area"));
            	bean.setTariff(resultSet.getString("tariff"));
            	listBean.add(bean);
            	
//        	System.out.println(listBean);
			}
			stmtTarif.close();
			conn.close();
			
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
//System.out.println("nitin===="+listBean);
    return listBean;
}
public  List<ClsTarifBean> list4() throws SQLException {
    List<ClsTarifBean> listBean = new ArrayList<ClsTarifBean>();
    Connection conn = ClsConnection.getMyConnection();
	try {
			
			Statement stmtTarif = conn.createStatement ();
        	
			ResultSet resultSet = stmtTarif.executeQuery ("select distinct level2,level4,level6,level8 from gl_tariffuel where doc_no=1 and branch=1 and gid='A'");

			while (resultSet.next()) {
				
				ClsTarifBean bean = new ClsTarifBean();
            	
            	bean.setQuarter(resultSet.getDouble("level2"));
            	bean.setHalf(resultSet.getDouble("level4"));
            	bean.setTriquarter(resultSet.getDouble("level6"));
            	bean.setFull(resultSet.getDouble("level8"));
            	listBean.add(bean);
        	//System.out.println(listBean);
			}
			stmtTarif.close();

			conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
//System.out.println("nitin===="+listBean);
    return listBean;
}
public  List<ClsTarifBean> listweekday() throws SQLException {
    List<ClsTarifBean> listBean = new ArrayList<ClsTarifBean>();
    Connection conn = ClsConnection.getMyConnection();
	try {
			
			Statement stmtTarif = conn.createStatement ();
        	
			ResultSet resultSet = stmtTarif.executeQuery ("select cdw,pai,exkmrte,rate,gid,cdw1,pai1,oinschg,cswkday,cstime,cewkday,cetime from gl_tarifcondn where ctype='cwkday'");

			while (resultSet.next()) {
				
				ClsTarifBean bean = new ClsTarifBean();
            	bean.setWcdw(resultSet.getDouble("cdw"));
            	bean.setWpai(resultSet.getDouble("pai"));
            	bean.setWexkmrate(resultSet.getDouble("exkmrte"));
            	bean.setWrate(resultSet.getDouble("rate"));
            	bean.setWcdw1(resultSet.getDouble("cdw1"));
            	bean.setWpai1(resultSet.getDouble("pai1"));
            	bean.setWinschg(resultSet.getDouble("oinschg"));
            	bean.setWstartday(resultSet.getString("cswkday"));
            	bean.setWendday(resultSet.getString("cewkday"));
            	bean.setWstarttime(resultSet.getString("cstime"));
            	bean.setWendtime(resultSet.getString("cetime"));
            	
            	listBean.add(bean);
        	//System.out.println(listBean);
			}
			stmtTarif.close();
			conn.close();
			
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
//System.out.println("nitin===="+listBean);
    return listBean;
}

public  List<ClsTarifBean> listfoc() throws SQLException {
    List<ClsTarifBean> listBean = new ArrayList<ClsTarifBean>();
    Connection conn = ClsConnection.getMyConnection();
	try {
			
			Statement stmtTarif = conn.createStatement ();
        	
			ResultSet resultSet = stmtTarif.executeQuery ("select cdw,pai,exkmrte,rate,gid,cdw1,pai1,oinschg,minday,foc from gl_tarifcondn where ctype='cfoc'");

			while (resultSet.next()) {
				
				ClsTarifBean bean = new ClsTarifBean();
            	bean.setFcdw(resultSet.getDouble("cdw"));
            	bean.setFpai(resultSet.getDouble("pai"));
            	bean.setFexkmrate(resultSet.getDouble("exkmrte"));
            	bean.setFrate(resultSet.getDouble("rate"));
            	bean.setFcdw1(resultSet.getDouble("cdw1"));
            	bean.setFpai1(resultSet.getDouble("pai1"));
            	bean.setFinschg(resultSet.getDouble("oinschg"));
            	bean.setMinday(resultSet.getInt("minday"));
            	bean.setFoc(resultSet.getInt("foc"));
            	
            	
            	listBean.add(bean);
        	//System.out.println(listBean);
			}
			stmtTarif.close();
			conn.close();
		
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
//System.out.println("nitin===="+listBean);
    return listBean;
}
public  JSONArray mainSearchList() throws SQLException {
    List<ClsTarifBean> tarifbean = new ArrayList<ClsTarifBean>();
    Connection conn = ClsConnection.getMyConnection();
    JSONArray RESULTDATA=new JSONArray();
	try {
			
			Statement stmtTarif = conn.createStatement ();
        	String strSql="select m2.doc_no clientid,if(m1.tariftype='Corporate',m3.cat_name,m2.refname) clientname,m1.doc_no docno,m1.validfrm fromdate,m1.validto todate,"
        			+ "m1.tariftype,m1.notes,m1.currentdate date,m1.tariffor from gl_tarifm m1 left join my_acbook m2 on (m1.clientid=m2.doc_no and m2.dtype='CRM') "
        			+ "left join my_clcatm m3 on (m1.clientid=m3.doc_no and m3.dtype='CRM') where m1.status<>7";
        	//System.out.println(strSql);
        	ResultSet resultSet = stmtTarif.executeQuery (strSql);
			
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtTarif.close();
			conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	//System.out.println("RESULTDATA=========>"+RESULTDATA);
    return RESULTDATA;
}
public  JSONArray getFocData(String docno,String group) throws SQLException {
    List<ClsTarifBean> tarifbean = new ArrayList<ClsTarifBean>();
    String group2=group.trim();
    JSONArray RESULTDATA=new JSONArray();
    Connection conn = ClsConnection.getMyConnection();
    try {
			
			Statement stmtTarif = conn.createStatement ();
        	String strSql="select cdw,pai,exkmrte,rate,cdw1,pai1,oinschg,minday,foc,gps,babyseater,cooler from gl_tarifcondn where ctype='cfoc' and doc_no='"+docno+"' and gid='"+group2+"'";
        	//System.out.println(strSql);
        	ResultSet resultSet = stmtTarif.executeQuery (strSql);
			
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtTarif.close();
			conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	//System.out.println("RESULTDATA=========>"+RESULTDATA);
    return RESULTDATA;
}
public   List<ClsTarifBean> listGrpComplete() throws SQLException {
    List<ClsTarifBean> listBean = new ArrayList<ClsTarifBean>();
    Connection conn = ClsConnection.getMyConnection();
	try {
			
			Statement stmtTarif = conn.createStatement ();
        	
			ResultSet resultSet = stmtTarif.executeQuery ("select distinct m1.gid from gl_vehgroup m1 left join gl_tarifd m2 on m1.gid=m2.gid and m2.doc_no=1 "
					+ "where  m1.gid in (select gid from gl_tarifd where doc_no=1)");

			while (resultSet.next()) {
				
				ClsTarifBean bean = new ClsTarifBean();
				bean.setGroup1(resultSet.getString("gid"));
            	
            	
            	listBean.add(bean);
        	//System.out.println(listBean);
			}
			stmtTarif.close();
			conn.close();
			
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
//System.out.println("nitin===="+listBean);
    return listBean;
}
public   List<ClsTarifBean> listSearchDelivery() throws SQLException {
    List<ClsTarifBean> listBean = new ArrayList<ClsTarifBean>();
    Connection conn = ClsConnection.getMyConnection();
	try {
			
			Statement stmtTarif = conn.createStatement ();
        	
			ResultSet resultSet = stmtTarif.executeQuery ("select doc_no,area from my_area");

			while (resultSet.next()) {
				
				ClsTarifBean bean = new ClsTarifBean();
				bean.setDeldocno(resultSet.getInt("doc_no"));
				bean.setDelarea(resultSet.getString("area"));
				
            	listBean.add(bean);
        	//System.out.println(listBean);
			}
			stmtTarif.close();
			conn.close();
			
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
//System.out.println("nitin===="+listBean);
    return listBean;
}

public int insert_detail(ArrayList<String> tarifarray,String group,int docno,HttpSession session,String tempstatus,String hidgroupdoc) throws SQLException {
	//System.out.println("Insert Detail"+docno);
	String group2=group.trim();
//	System.out.println(hidgroupdoc+"GID IN DAO");
	
	
	Connection conn = ClsConnection.getMyConnection();
	try {
		
		 
		conn.setAutoCommit(false);
		Statement stmtTarif = conn.createStatement ();
	//System.out.println("Here");

int aaa = 0;
String sql="";
if(tempstatus.equalsIgnoreCase("0")){
	String deletesql="delete from gl_tarifd where doc_no='"+docno+"' and gid='"+hidgroupdoc+"'";
	int deleteval=stmtTarif.executeUpdate(deletesql);
	/*if(deleteval<=0){
		return 0;
	}*/
}

//System.out.println(tarifarray.size());
	for(int i=0;i< tarifarray.size();i++){
		
		String[] tarif=tarifarray.get(i).split("::");
		//System.out.println(tarifarray.get(i));
		///System.out.println(tarif[17]);
			 sql="insert into gl_tarifd(doc_no,branch,cdw,pai,kmrest,exkmrte,rate,gid,renttype,cdw1,pai1,oinschg,chaufchg,chaufexchg,exhrchg,"+
					"disclevel1,disclevel2,disclevel3,gps,babyseater,cooler) values ('"+docno+"','"+session.getAttribute("BRANCHID").toString()+"',"
							+ "'"+(tarif[2].equalsIgnoreCase("undefined") || tarif[2].isEmpty()?0:tarif[2])+"',"
							+ "'"+(tarif[3].equalsIgnoreCase("undefined") || tarif[3].equalsIgnoreCase("")?0:tarif[3])+"',"
							+ "'"+(tarif[15].equalsIgnoreCase("undefined") || tarif[15].equalsIgnoreCase("")?0:tarif[15])+"',"
							+ "'"+(tarif[16].equalsIgnoreCase("undefined") || tarif[16].equalsIgnoreCase("")?0:tarif[16])+"',"
							+ "'"+(tarif[1].equalsIgnoreCase("undefined") || tarif[1].equalsIgnoreCase("")?0:tarif[1])+"',"
							+ "'"+hidgroupdoc+"','"+tarif[0]+"','"+(tarif[4].equalsIgnoreCase("undefined") || tarif[4].equalsIgnoreCase("")?0:tarif[4])+"',"
							+ "'"+(tarif[5].equalsIgnoreCase("undefined") || tarif[5].equalsIgnoreCase("")?0:tarif[5])+"',"
							+ "'"+(tarif[17].equalsIgnoreCase("undefined") || tarif[17].equalsIgnoreCase("")?0:tarif[17])+"',"
							+ "'"+(tarif[10].equalsIgnoreCase("undefined") || tarif[10].equalsIgnoreCase("")?0:tarif[10])+"',"
							+ "'"+(tarif[11].equalsIgnoreCase("undefined") || tarif[11].equalsIgnoreCase("")?0:tarif[11])+"',"
											+ "'"+(tarif[9].equalsIgnoreCase("undefined") || tarif[9].equalsIgnoreCase("")?0:tarif[9])+"',"
													+ "'"+(tarif[12].equalsIgnoreCase("undefined") || tarif[12].equalsIgnoreCase("")?0:tarif[12])+"',"
															+ "'"+(tarif[13].equalsIgnoreCase("undefined") || tarif[13].equalsIgnoreCase("")?0:tarif[13])+"',"
																	+ "'"+(tarif[14].equalsIgnoreCase("undefined") || tarif[14].equalsIgnoreCase("")?0:tarif[14])+"',"
																			+ "'"+(tarif[6].equalsIgnoreCase("undefined") || tarif[6].equalsIgnoreCase("")?0:tarif[6])+"',"
							+ "'"+(tarif[7].equalsIgnoreCase("undefined") || tarif[7].equalsIgnoreCase("")?0:tarif[7])+"',"
									+ "'"+(tarif[8].equalsIgnoreCase("undefined") || tarif[8].equalsIgnoreCase("")?0:tarif[8])+"')";
			
			//System.out.println("Sql------------------------"+sql);
			 aaa = stmtTarif.executeUpdate (sql);
			
			
			if(aaa==0){
				stmtTarif.close();
				conn.close();
				return 0;
			}
		
	}
		
			
		
	if(aaa>0){
		/*Statement stmtdupcheck=conn.createStatement();
		String strcheck="select rowno from gl_tarifexcess where rdocno="+docno+" and gid="+hidgroupdoc;
		ResultSet rscheck=stmtdupcheck.executeQuery(strcheck);
		int val=0;
		if(rscheck.next()){
			val=excessinsert(docno,hidgroupdoc,insurexcess,cdwexcess,scdwexcess,conn,"Edit");
		}
		else{
			val=excessinsert(docno,hidgroupdoc,insurexcess,cdwexcess,scdwexcess,conn,"Insert");
		}

		if(val>0){*/
		conn.commit();
		stmtTarif.close();
		conn.close();
		return aaa;
		
	}
	stmtTarif.close();
	conn.close();
	
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		conn.close();
		return 0;

	}
	return 0;
}
public int excessinsert(int docno,String hidgroupdoc,String insurexcess,String cdwexcess,String scdwexcess,String securityamt) throws SQLException{
	Connection conn=ClsConnection.getMyConnection();
	String str="";
	int val=0;
	String temp="";
	try {
		if(insurexcess.equalsIgnoreCase("")){
			insurexcess="0";
		}
		if(cdwexcess.equalsIgnoreCase("")){
			cdwexcess="0";
		}
		if(scdwexcess.equalsIgnoreCase("")){
			scdwexcess="0";
		}
		if(securityamt.equalsIgnoreCase("")){
			securityamt="0";
		}
		Statement stmtdupcheck=conn.createStatement();
		String strcheck="select rowno from gl_tarifexcess where rdocno="+docno+" and gid="+hidgroupdoc;
		ResultSet rscheck=stmtdupcheck.executeQuery(strcheck);
		if(rscheck.next()){
			temp="Edit";
		}
		else{
			temp="Insert";
		}
		Statement stmt=conn.createStatement();
	
	if(temp.equalsIgnoreCase("Edit")){
		str="update gl_tarifexcess set securityamt="+securityamt+",insurexcess="+insurexcess+",cdwexcess="+cdwexcess+",scdwexcess="+scdwexcess+" where rdocno="+docno+" and gid="+hidgroupdoc+"";
	}
	else if(temp.equalsIgnoreCase("Insert")){
		str="insert into gl_tarifexcess(rdocno,gid,insurexcess,cdwexcess,scdwexcess,securityamt)values("+docno+","+hidgroupdoc+","+insurexcess+","+cdwexcess+","+scdwexcess+","+securityamt+")";
//		System.out.println("Check ExcessInsert:"+str);
	}
	val=stmt.executeUpdate(str);
	
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	conn.close();
	return 0;
	}
	return val;
	
}
public int insert_weekday(ArrayList<String> weekdayarray,String group,int docno,HttpSession session,String tempstatus,String hidgroupdoc) throws ParseException, SQLException {
	//System.out.println("Insert weekday"+docno);
	String group2=group.trim();
	//System.out.println(session.getAttribute("BRANCHID").toString());
	//System.out.println("Hidden Group: "+hidgroupdoc);
	
	Connection conn = ClsConnection.getMyConnection();
	try {
		 
		conn.setAutoCommit(false);
		Statement stmtTarif;
		stmtTarif = conn.createStatement ();
		int aaa=0;
		if(tempstatus.equalsIgnoreCase("0")){
			String deletesql="delete from gl_tarifcondn where doc_no='"+docno+"' and gid='"+hidgroupdoc+"' and ctype='cwkday'";
//			System.out.println("delete============ "+deletesql);
			int deleteval=stmtTarif.executeUpdate(deletesql);
		/*	if(deleteval<=0){
//				System.out.println("delte return");
				return 0;
			}*/
		}
	for(int i=0,j=0;i< weekdayarray.size();i++){
		String[] tarif=weekdayarray.get(i).split("::");
		
			String ctype="cwkday";
			
			if(!(tarif[0].equalsIgnoreCase("undefined")&& tarif[0].isEmpty() && tarif[1].equalsIgnoreCase("undefined")&& tarif[1].isEmpty() && tarif[2].equalsIgnoreCase("undefined")&& tarif[2].isEmpty() && tarif[3].equalsIgnoreCase("undefined")&& tarif[3].isEmpty())){
			j++;
			String sql="insert into gl_tarifcondn(sr_no,doc_no,branch,cdw,kmrest,exkmrte,rate,gid,gps,babyseater,cooler,oinschg,cswkday,cstime,cewkday,cetime,ctype,ulevel1,ulevel2,ulevel3,exdaychg) values("
			+""+j+",'"+docno+"','"+session.getAttribute("BRANCHID").toString()+"','"+(tarif[5].equalsIgnoreCase("undefined") || tarif[5].isEmpty()?0:tarif[5])+"','"+(tarif[9].equalsIgnoreCase("undefined") || tarif[9].isEmpty()?0:tarif[9])+"','"+(tarif[10].equalsIgnoreCase("undefined") || tarif[10].isEmpty()?0:tarif[10])+"','"+(tarif[4].equalsIgnoreCase("undefined") || tarif[4].isEmpty()?0:tarif[4])+"','"+hidgroupdoc+"','"+(tarif[6].equalsIgnoreCase("undefined") || tarif[6].isEmpty()?0:tarif[6])+"','"+(tarif[7].equalsIgnoreCase("undefined") || tarif[7].isEmpty()?0:tarif[7])+"','"+(tarif[8].equalsIgnoreCase("undefined") || tarif[8].isEmpty()?0:tarif[8])+"','"+(tarif[11].equalsIgnoreCase("undefined") || tarif[11].isEmpty()?0:tarif[11])+"','"+(tarif[0].equalsIgnoreCase("undefined") || tarif[0].isEmpty()?0:tarif[0])+"','"+(tarif[1].equalsIgnoreCase("undefined") || tarif[1].isEmpty()?0:tarif[1])+"','"+(tarif[2].equalsIgnoreCase("undefined") || tarif[2].isEmpty()?0:tarif[2])+"','"+(tarif[3].equalsIgnoreCase("undefined") || tarif[3].isEmpty()?0:tarif[3])+"','"+ctype+"','"+(tarif[12].equalsIgnoreCase("undefined") || tarif[12].isEmpty()?0:tarif[12])+"','"+(tarif[13].equalsIgnoreCase("undefined") || tarif[13].isEmpty()?0:tarif[13])+"','"+(tarif[14].equalsIgnoreCase("undefined") || tarif[14].isEmpty()?0:tarif[14])+"','"+(tarif[15].equalsIgnoreCase("undefined") || tarif[15].isEmpty()?0:tarif[15])+"')";
		//System.out.println("Weekday insert:"+sql);
			//System.out.println("Sql"+sql);
		 aaa = stmtTarif.executeUpdate (sql);
		
			}
		if(aaa<=0){
			stmtTarif.close();
			conn.close();
			return 0;
		}
		
		}
		if(aaa>0){
			conn.commit();
			stmtTarif.close();
			conn.close();
			return aaa;
		}
		
	stmtTarif.close();
	conn.close();
	
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		conn.close();
		return 0;

	}
	return 0;
}
public int insert_foc(ArrayList<String> focarray,String group,int docno,HttpSession session,String tempstatus,String hidgroupdoc) throws SQLException {
//	System.out.println("Insert FOC"+docno);
	String group2=group.trim();
	
	int aaa=0;
	Connection  conn = ClsConnection.getMyConnection();
	try {
		
		conn.setAutoCommit(false);
		Statement stmtTarif;
		stmtTarif = conn.createStatement ();
		if(tempstatus.equalsIgnoreCase("0")){
			String deletesql="delete from gl_tarifcondn where doc_no='"+docno+"' and gid='"+hidgroupdoc+"' and ctype='cfoc'";
			int deleteval=stmtTarif.executeUpdate(deletesql);
			/*if(deleteval<=0){
				return 0;
			}*/
		}
	for(int i=0;i< focarray.size();i++){
		String[] tariffoc=focarray.get(i).split("::");
		
			String ctype="cfoc";
			if(!((tariffoc[0].equalsIgnoreCase("undefined"))||( tariffoc[0].isEmpty()))){
			String sql="insert into gl_tarifcondn(doc_no,branch,cdw,kmrest,exkmrte,rate,gid,minday,foc,ctype,gps,babyseater,cooler,oinschg)values"
					+ " ('"+docno+"','"+session.getAttribute("BRANCHID").toString()+"','"+(tariffoc[3].equalsIgnoreCase("undefined") || tariffoc[3].isEmpty()?0:tariffoc[3])+"','"+(tariffoc[7].equalsIgnoreCase("undefined") || tariffoc[7].isEmpty()?0:tariffoc[7])+"','"+(tariffoc[8].equalsIgnoreCase("undefined") || tariffoc[8].isEmpty()?0:tariffoc[8])+"','"+(tariffoc[2].equalsIgnoreCase("undefined") || tariffoc[2].isEmpty()?0:tariffoc[2])+"','"+hidgroupdoc+"','"+(tariffoc[0].equalsIgnoreCase("undefined") || tariffoc[0].isEmpty()?0:tariffoc[0])+"','"+(tariffoc[1].equalsIgnoreCase("undefined") || tariffoc[1].isEmpty()?0:tariffoc[1])+"','"+ctype+"','"+(tariffoc[4].equalsIgnoreCase("undefined") || tariffoc[4].isEmpty()?0:tariffoc[4])+"','"+(tariffoc[5].equalsIgnoreCase("undefined") || tariffoc[5].isEmpty()?0:tariffoc[5])+"','"+(tariffoc[6].equalsIgnoreCase("undefined") || tariffoc[6].isEmpty()?0:tariffoc[6])+"','"+(tariffoc[9].equalsIgnoreCase("undefined") || tariffoc[9].isEmpty()?0:tariffoc[9])+"')";
			
//			System.out.println("Sql"+sql);
			 aaa = stmtTarif.executeUpdate (sql);
			
			}
			if(aaa<=0){
				stmtTarif.close();
				conn.close();
				return 0;
			}
	
			
	}
	if(aaa>0){
		conn.commit();
		stmtTarif.close();
		conn.close();
		return aaa;
	}
	stmtTarif.close();
	conn.close();

	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		conn.close();	
		return 0;

	}
	return 0;
}

public  JSONArray getGroup2(String docno) throws SQLException {
    List<ClsTarifBean> tarifbean = new ArrayList<ClsTarifBean>();
      
    JSONArray RESULTDATA=new JSONArray();
    Connection conn = ClsConnection.getMyConnection();
	try {
			
			Statement stmtTarif = conn.createStatement ();
        	String strSql="select distinct if(m2.gid is null,grp2.gname,grp1.gname) gid,if(m2.gid is null,grp2.doc_no,grp1.doc_no) docno,"+
        			" coalesce(ex.securityamt,0) securityamt,coalesce(ex.insurexcess,0) insurexcess,coalesce(ex.cdwexcess,0) cdwexcess,coalesce(ex.scdwexcess,0) scdwexcess"+
        			" from gl_tarifm m1 left join gl_tarifd m2 on m1.doc_no=m2.doc_no left join gl_tarifcondn m3 on m1.doc_no=m3.doc_no left join"+
        			" gl_tarifexcess ex on ((m1.doc_no=ex.rdocno and m2.gid=ex.gid) or (m1.doc_no=ex.rdocno and m3.gid=ex.gid))"+
        			" left join gl_vehgroup grp1 on m2.gid=grp1.doc_no left join gl_vehgroup grp2 on m3.gid=grp2.doc_no  where m1.doc_no='"+docno+"'";
        	ResultSet resultSet = stmtTarif.executeQuery (strSql);
			
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtTarif.close();
			conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
    return RESULTDATA;
}
public  JSONArray getNewGroup() throws SQLException {
    List<ClsTarifBean> tarifbean = new ArrayList<ClsTarifBean>();
    Connection conn = ClsConnection.getMyConnection();
    JSONArray RESULTDATA=new JSONArray();
	try {
			
			Statement stmtTarif = conn.createStatement ();
        	String strSql="select distinct gname gid,doc_no from gl_vehgroup where status<>7";
//        	System.out.println(strSql);
        	ResultSet resultSet = stmtTarif.executeQuery (strSql);
			
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtTarif.close();
			conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
    return RESULTDATA;
}
public  JSONArray getGroup1(String docno) throws SQLException {
    List<ClsTarifBean> tarifbean = new ArrayList<ClsTarifBean>();
    Connection conn = ClsConnection.getMyConnection();
    JSONArray RESULTDATA=new JSONArray();
	try {
			
			Statement stmtTarif = conn.createStatement ();
        	String strSql= "select grp.gname gid,grp.doc_no from  gl_vehgroup grp where grp.status<>7 and grp.doc_no not in(select distinct if(td.gid is null,"+
        			" if(tc.gid is null,'0',tc.gid),td.gid) gid from gl_tarifm tm left join gl_tarifd td on tm.doc_no=td.doc_no"+
        			" left join gl_tarifcondn tc on tm.doc_no=tc.doc_no where tm.doc_no='"+docno+"')";
        //	System.out.println(strSql);
        	ResultSet resultSet = stmtTarif.executeQuery (strSql);
			
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtTarif.close();
			conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
    return RESULTDATA;
}
public  JSONArray getRegularTarif(String gid,String docno,HttpSession session) throws SQLException {
    List<ClsTarifBean> tarifbean = new ArrayList<ClsTarifBean>();
    JSONArray RESULTDATA=new JSONArray();
    Connection conn = ClsConnection.getMyConnection();
	try {
			
			Statement stmtTarif = conn.createStatement ();
        	String strSql="select m3.rentaltype,m1.cdw,m1.pai,m1.kmrest,m1.exkmrte,m1.rate,m1.gps,m1.babyseater,m1.cooler,m1.disclevel1,m1.disclevel2,m1.disclevel3,m1.cdw1,m1.pai1,m1.oinschg,"+
        			"m1.chaufchg,m1.chaufexchg,m1.exhrchg from gl_tarifm m2 left join gl_tarifd m1 on m2.doc_no=m1.doc_no left join"+
					" gl_tlistm m3 on m1.renttype=m3.rentaltype where m1.gid = '"+gid+"' and m2.doc_no='"+docno+"'";
			ResultSet resultSet = stmtTarif.executeQuery (strSql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtTarif.close();
			conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
    return RESULTDATA;
}
public  JSONArray getNewRegular() throws SQLException {
    List<ClsTarifBean> tarifbean = new ArrayList<ClsTarifBean>();
    Connection conn = ClsConnection.getMyConnection();
    JSONArray RESULTDATA=new JSONArray();
	try {
			
			Statement stmtTarif = conn.createStatement ();
        	String strSql="select rentaltype from gl_tlistm where status=1 limit 4";
			ResultSet resultSet = stmtTarif.executeQuery (strSql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtTarif.close();
			conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
    return RESULTDATA;
}
public  JSONArray getWeekDayTarif(String gid,String docno) throws SQLException {
    List<ClsTarifBean> tarifbean = new ArrayList<ClsTarifBean>();
    JSONArray RESULTDATA=new JSONArray();
    Connection conn = ClsConnection.getMyConnection();
	try {
			
			Statement stmtTarif = conn.createStatement ();
        	String strSql="select cswkday,cstime,cewkday,cetime,rate,cdw,gps,babyseater,cooler,kmrest,exkmrte,oinschg,ulevel1,ulevel2,ulevel3,exdaychg from gl_tarifcondn "+
			 "where doc_no='"+docno+"' and gid='"+gid+"' and ctype='cwkday'";
			ResultSet resultSet = stmtTarif.executeQuery (strSql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtTarif.close();
			conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
    return RESULTDATA;
}
public  JSONArray getFocTarif(String gid,String docno,HttpSession session) throws SQLException {
    List<ClsTarifBean> tarifbean = new ArrayList<ClsTarifBean>();
    JSONArray RESULTDATA=new JSONArray();
    Connection conn = ClsConnection.getMyConnection();
    try {
			
			Statement stmtTarif = conn.createStatement ();
        	String strSql="select cdw,pai,kmrest,exkmrte,rate,minday,foc,oinschg,gps,babyseater,cooler from gl_tarifcondn where ctype='cfoc' and doc_no='"+docno+"' and gid='"+gid+"' and branch='"+session.getAttribute("BRANCHID").toString()+"'";
			ResultSet resultSet = stmtTarif.executeQuery (strSql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtTarif.close();
			conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
    return RESULTDATA;
}
public  JSONArray getFuelTarif(String gid,String docno) throws SQLException {
    List<ClsTarifBean> tarifbean = new ArrayList<ClsTarifBean>();
    JSONArray RESULTDATA=new JSONArray();
    Connection conn = ClsConnection.getMyConnection();
    try {
			
			Statement stmtTarif = conn.createStatement ();
        	String strSql="select distinct level2,level4,level6,level8 from gl_tariffuel where doc_no='"+docno+"' and gid='"+gid+"' and branch=1";
			ResultSet resultSet = stmtTarif.executeQuery (strSql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtTarif.close();
			conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
    return RESULTDATA;
}
public  JSONArray getClient(String tariftype) throws SQLException {
    List<ClsTarifBean> tarifbean = new ArrayList<ClsTarifBean>();
    Connection conn = ClsConnection.getMyConnection();
    JSONArray RESULTDATA=new JSONArray();
	try {
			
			Statement stmtTarif = conn.createStatement ();
        	String strSql="";
        	if(tariftype.equalsIgnoreCase("Client")){
        		strSql="select doc_no,refname from my_acbook where dtype='CRM' and status<>7";
        	}
        	else if(tariftype.equalsIgnoreCase("Corporate")){
        		strSql="select doc_no,cat_name refname from my_clcatm where dtype='CRM' and status<>7";
        	}
        	else{
        		
        	}
        	//System.out.println(strSql);
			ResultSet resultSet = stmtTarif.executeQuery (strSql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtTarif.close();
			conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
    return RESULTDATA;
}



public  ClsTarifBean getPrint(int docno) throws SQLException {
	ClsTarifBean bean = new ClsTarifBean();
	  Connection conn = ClsConnection.getMyConnection();
	 
	 try{
	Statement stmttarif = conn.createStatement ();
	String strSql="select cmp.company,cmp.address,cmp.tel,cmp.fax,br.branchname,tm.doc_no,DATE_FORMAT(tm.validfrm,'%d/%m/%Y') fromdate,DATE_FORMAT(tm.validto,'%d/%m/%Y') todate,tm.tariftype,"+
			" tm.tariffor,coalesce(if(tm.tariftype='Corporate',cat.cat_name,ac.refname),'')clientname from gl_tarifm tm left join my_acbook ac"+
			" on(tm.clientid=ac.doc_no and ac.dtype='CRM') left join my_clcatm cat on (tm.clientid=cat.doc_no and cat.dtype='CRM') left join"+
			" gl_tarifd td on tm.doc_no=td.doc_no left join my_brch br on td.branch=br.doc_no left join my_comp cmp on br.cmpid=cmp.doc_no"+
			" where tm.doc_no="+docno+" group by tm.doc_no";
	ResultSet rsprint=stmttarif.executeQuery(strSql);
	while(rsprint.next()){
		bean.setLblcompname(rsprint.getString("company"));
		bean.setLblcompaddress(rsprint.getString("address"));
		bean.setLblcomptel(rsprint.getString("tel"));
		bean.setLblcompfax(rsprint.getString("fax"));
		bean.setLblbranch(rsprint.getString("branchname"));
		bean.setLbldocno(rsprint.getString("doc_no"));
		bean.setLblfromdate(rsprint.getString("fromdate"));
		bean.setLbltodate(rsprint.getString("todate"));
		bean.setLbltariftype(rsprint.getString("tariftype"));
		bean.setLblclient(rsprint.getString("clientname"));
		
	}
	stmttarif.close();
	conn.close();
	 }
	 catch(Exception e){
		 e.printStackTrace();
		 conn.close();
	 }
	return bean;
}
public  ArrayList<String> getNormalTarifPrint(int docno) throws SQLException {
	ArrayList<String> arr=new ArrayList<String>();
	Connection conn = ClsConnection.getMyConnection();
	try {
		
		Statement stmtinvoice = conn.createStatement ();
		String strSqlnormal="";
	strSqlnormal="select grp.gname,m3.rentaltype,round(m1.rate,2) rate,round(m1.cdw,2) cdw,round(m1.pai,2) pai,round(m1.cdw1,2) cdw1,round(m1.pai1,2)"
			+ " pai1,round(m1.gps,2) gps,round(m1.babyseater,2) babyseater,round(m1.cooler,2)cooler,round(m1.kmrest,0) kmrest,round(m1.exkmrte,2)"
			+ " exkmrte,round(m1.oinschg,2)oinschg,round(m1.exhrchg,2)exhrchg,round(m1.chaufchg,2)chaufchg,round(m1.chaufexchg,2)chaufexchg,"
			+ " m1.disclevel1,m1.disclevel2,m1.disclevel3 from gl_tarifm m2 left join gl_tarifd m1 on m2.doc_no=m1.doc_no left join gl_tlistm m3 "
			+ " on m1.renttype=m3.rentaltype left join gl_vehgroup grp on m1.gid=grp.doc_no where m2.doc_no='"+docno+"'  order by grp.gname,m3.sno";
	
	ResultSet rsnormal=stmtinvoice.executeQuery(strSqlnormal);
	
	String temptype="";
	int i=1;
	while(rsnormal.next()){

			String temp="";
			String tempgroup="";
			/*if(temptype.equalsIgnoreCase("Daily")){
				temptype=temptype+"  ";
			}
			else if(temptype.equalsIgnoreCase("Weekly")){
				temptype=temptype+" ";
			}
			else{
			}*/
			if(temptype.equalsIgnoreCase(rsnormal.getString("gname"))){
				tempgroup="";
			}
			else{
				tempgroup=rsnormal.getString("gname");
			}
			temp=tempgroup+"::"+rsnormal.getString("rentaltype")+"::"+rsnormal.getString("rate")+"::"+rsnormal.getString("cdw")+"::"+
			rsnormal.getString("cdw1")+"::"+rsnormal.getString("gps")+"::"+rsnormal.getString("babyseater")+"::"+rsnormal.getString("cooler")+"::"+
			rsnormal.getString("kmrest")+"::"+rsnormal.getString("exkmrte")+"::"+rsnormal.getString("oinschg")+"::"+rsnormal.getString("exhrchg")+"::"+rsnormal.getString("chaufchg")+"::"+rsnormal.getString("chaufexchg");
			arr.add(temp);
			temptype=rsnormal.getString("gname");
			i++;
			if(i>3){
				i=1;
				temptype="";
			}
//			System.out.println(i);
			/*rsnormal.getString("disclevel1")+"::"+rsnormal.getString("disclevel2")+"::"+rsnormal.getString("disclevel3")*/
}
	stmtinvoice.close();
	conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	// TODO Auto-generated method stub
	return arr;
}
}
