package com.sales.InventoryTransfer.materialrequest;

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

import net.sf.json.JSONArray;

 





import com.common.ClsCommon;
import com.connection.ClsConnection;
 
 
public class ClsMaterialrequestDAO {     

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	
	
	
	Connection conn=null;
public int insert(Date masterdate, String refno, String purdesc,
		double productTotal, HttpSession session, String mode,
		String formdetailcode, HttpServletRequest request,
		ArrayList<String> masterarray, int txtlocationid, int cldocno,
		int siteid, int type, int itemtype, int itemdocno) throws SQLException {
	 

	
	
	try{
		int docno;
	
		 conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		CallableStatement stmtmr= conn.prepareCall("{call tr_materialrequestDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		stmtmr.registerOutParameter(15, java.sql.Types.INTEGER);
		stmtmr.registerOutParameter(16, java.sql.Types.INTEGER);

		stmtmr.setDate(1,masterdate);
		stmtmr.setString(2,refno);
		stmtmr.setString(3,purdesc);
		stmtmr.setDouble(4,0);
	  	 
		stmtmr.setString(5,session.getAttribute("USERID").toString());
		stmtmr.setString(6,session.getAttribute("BRANCHID").toString());
		stmtmr.setString(7,session.getAttribute("COMPANYID").toString());
		
 
		stmtmr.setString(8,formdetailcode);
		stmtmr.setString(9,mode);
 
		
		stmtmr.setInt(10,txtlocationid);
		
 
		stmtmr.setInt(11,siteid);
		stmtmr.setInt(12,type);
		stmtmr.setInt(13,itemtype);
		stmtmr.setInt(14,itemdocno);
		stmtmr.setInt(17,cldocno);
		
		
		stmtmr.executeQuery();
		docno=stmtmr.getInt("docNo");
 
		int vocno=stmtmr.getInt("vocNo");	
		request.setAttribute("vocno", vocno);
		//System.out.println("====vocno========"+vocno);
	
		if(docno<=0)
		{
			conn.close();
			return 0;
			
		}
		 
		 Statement stmt=conn.createStatement();
		 
		 
			for(int i=0;i< masterarray.size();i++){

				String[] prod=((String) masterarray.get(i)).split("::");
			//	System.out.println("prod[0]===="+prod[0]);
				if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")))){

	 						 
			String  rqty=""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].trim().equalsIgnoreCase("")|| prod[3].isEmpty()?0:prod[3].trim())+"";
			double masterqty=Double.parseDouble(rqty);

 
				String sql="insert into my_mreqd(TR_NO, SR_NO,rdocno,SpecNo, psrno, prdId,  qty , UNITID)VALUES"
						+ " ("+docno+","+(i+1)+",'"+docno+"',"
						+ "'"+(prod[6].equalsIgnoreCase("undefined") || prod[6].equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
						+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
						+ "'"+(prod[1].equalsIgnoreCase("undefined") || prod[1].equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
						+ "'"+masterqty+"',"
			 			+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"')";

				 stmt.executeUpdate(sql);
					
				}
			
		
	 
			
			}
			if(docno>0)
			{
			 	conn.commit();
				stmtmr.close();
				conn.close();
				return docno;
				
			}
			
			}
				
				
 
	
	
	catch (Exception e) {
		conn.close();
		e.printStackTrace();
	}
	
	conn.close();
	return 0;
}


 
 
	
	
public   JSONArray locationsearch(HttpSession session) throws SQLException {

		 
	    
		JSONArray RESULTDATA=new JSONArray();
 
	    Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
		 
				Statement stmtmain = conn.createStatement (); 
				
 
				
	        	String pySql=("select loc_name,doc_no,brhid from my_locm where status=3 and brhid="+session.getAttribute("BRANCHID").toString()+"" );
 
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
				stmtmain.close();
				


			conn.close();
			  return RESULTDATA;
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}


 

public JSONArray sitesearch(HttpSession session,String typedocno,String tr_no) throws SQLException {
    
    JSONArray RESULTDATA=new JSONArray();
          
          Connection conn = null; 
         
        try {
           conn = ClsConnection.getMyConnection();
           ClsCommon ClsCommon=new ClsCommon();
           Statement stmtmain = conn.createStatement();
   
       
            
            String sql="";
            
       
             
              String costgroup="";String sqltest="";
              Statement stmt=conn.createStatement();
              
              String sqls="select costtype,costgroup from my_costunit where costtype='"+typedocno+"' ";

              ResultSet rs=stmt.executeQuery(sqls);
              
              if(rs.next()) {
               costgroup=rs.getString("costgroup");
              }
              
     
                    if(typedocno.equalsIgnoreCase("3") || typedocno.equalsIgnoreCase("4")) {
              
              sql = "select  m.tr_no,s.rowno siteid,s.site from cm_srvcontrm m  "
              		+ "left join cm_srvcsited s on s.tr_no=m.tr_no where m.status=3  and m.dtype='"+costgroup+"' and m.tr_no='"+tr_no+"'  "+sqltest+"   ";
              
              
//              System.out.println("===sql===="+sql);
              
             }
             
             if(typedocno.equalsIgnoreCase("5")) {
              
              sql = "select  m.tr_no ,s.rowno siteid,s.site from cm_cuscallm m  "
              		+ " left join cm_srvcsited s on s.rowno=m.siteid where  m.status in(3)  "+sqltest+" and m.tr_no='"+tr_no+"' ";
//              System.out.println("===sql===="+sql);
              
              }
              
              stmt.close();
             
          
            
         //  System.out.println("SQL ="+sql);
           ResultSet resultSet = stmtmain.executeQuery(sql);
           RESULTDATA=ClsCommon.convertToJSON(resultSet);
              
           stmtmain.close();
           conn.close();
           
         stmtmain.close();
         conn.close();
        } catch(Exception e){
          e.printStackTrace();
          conn.close();
        } finally{
      conn.close();
     }
          return RESULTDATA;
     }


public   JSONArray searchProduct(HttpSession session,String id,
		String prdname,String brandname,String gridunit,String gridprdname,String category, String subcategory) throws SQLException {

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
	   
	   if(!(id.equalsIgnoreCase("1"))){
	  	  return RESULTDATA;
	  	     }
	    String brcid=session.getAttribute("BRANCHID").toString();
	   
	Connection conn = null;
	String condtn="";
	
	if(!(prdname.equalsIgnoreCase(""))&&!(prdname.equalsIgnoreCase("undefined"))&&!(prdname.equalsIgnoreCase("0"))){
		condtn ="  and m.part_no like '%"+prdname+"%' ";
	}
	
	if(!(brandname.equalsIgnoreCase(""))&&!(brandname.equalsIgnoreCase("undefined"))&&!(brandname.equalsIgnoreCase("0"))){
		condtn +="  and bd.brandname like '%"+brandname+"%' ";
	}
	
	gridprdname=gridprdname.replaceAll("@","%");
	if(!(gridprdname.equalsIgnoreCase(""))&&!(gridprdname.equalsIgnoreCase("undefined"))&&!(gridprdname.equalsIgnoreCase("0"))){
		condtn +="  and m.productname like '%"+gridprdname+"%' ";
	}
	
	if(!(gridunit.equalsIgnoreCase(""))&&!(gridunit.equalsIgnoreCase("undefined"))&&!(gridunit.equalsIgnoreCase("0"))){
		condtn +="  and u.unit like '%"+gridunit+"%' ";
	}
	
	if(!(category.equalsIgnoreCase(""))&&!(category.equalsIgnoreCase("undefined"))&&!(category.equalsIgnoreCase("0"))){
		condtn +="  and c.category like '%"+category+"%' ";
	}
	
	if(!(subcategory.equalsIgnoreCase(""))&&!(subcategory.equalsIgnoreCase("undefined"))&&!(subcategory.equalsIgnoreCase("0"))){
		condtn +="  and sc.subcategory like '%"+subcategory+"%' ";
	}

	try {
			 conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement (); 
    	
			int method=0;
			
			String chk="select method  from gl_prdconfig where field_nme='Prosearch'";
			ResultSet rs=stmtVeh.executeQuery(chk); 
			if(rs.next())
			{
				
				method=rs.getInt("method");
			}
			
			
		 
			
			
			String sql="  select  "+method+" method,bd.brandname, at.mspecno as specid, m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join  "
					+ " my_unitm u on m.munit=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
					+ "   left join my_desc de on(de.psrno=m.doc_no)   left join  my_brand bd on m.brandid=bd.doc_no left join my_catm c on c.doc_no=m.catid "
   						   + "left join my_scatm sc on m.scatid=sc.doc_no    where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"' "+condtn+"" ;
		//	System.out.println("---sql----"+sql);
			

 
 
		ResultSet resultSet = stmtVeh.executeQuery (sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtVeh.close();
			conn.close();

	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	//System.out.println(RESULTDATA);
return RESULTDATA;
}














public JSONArray costunitsearch(HttpSession session,String typedocno,String docno,String refnames,String search) throws SQLException {
    
    JSONArray RESULTDATA=new JSONArray();
          
          Connection conn = null; 
         
        try {
           conn = ClsConnection.getMyConnection();
           ClsCommon ClsCommon=new ClsCommon();
           Statement stmtmain = conn.createStatement();
   
           if(search.equalsIgnoreCase("yes")) {
            
            String sql="";
            
            if(typedocno.equalsIgnoreCase("1")) {
             
             sql="select c1.costcode code,c1.doc_no doc_no,c1.description name,coalesce(c2.description,c1.description) namedet,c1.grpno,c2.grpno from "
                + "my_ccentre c1 left join my_ccentre c2 on(c1.doc_no=c2.grpno) where c1.m_s=0";
//            System.out.println("sql1======"+sql);
            } else {
             
              String costgroup="";String sqltest="",sqltest1="";
              Statement stmt=conn.createStatement();
              
              String sqls="select costtype,costgroup from my_costunit where costtype='"+typedocno+"' ";
//              System.out.println("sql2======"+sqls);
              ResultSet rs=stmt.executeQuery(sqls);
              
              if(rs.next()) {
               costgroup=rs.getString("costgroup");
              }
              
             if(!(refnames.equalsIgnoreCase("0")) && !(refnames.equalsIgnoreCase(""))){
               sqltest=sqltest+" and ac.refname like '%"+refnames+"%'";
          }
             
             if(!(docno.equalsIgnoreCase("0")) && !(docno.equalsIgnoreCase(""))){
                 sqltest=sqltest+" and m.doc_no='"+docno+"'";
                 sqltest1=sqltest1+" and m.doc_no='"+docno+"'";
             }
             
                    if(typedocno.equalsIgnoreCase("3") || typedocno.equalsIgnoreCase("4")) {
                    	 if(!(refnames.equalsIgnoreCase("0")) && !(refnames.equalsIgnoreCase(""))){
                             sqltest1=sqltest1+" and s.site like '%"+refnames+"%'";
                        }
              sql = "select m.doc_no,m.tr_no,m.dtype,convert(concat(m.ref_type,' ',m.refdocno),char(100)) prjname,ac.refname customer,m.cldocno,s.rowno siteid,s.site from cm_srvcontrm m left join "
               + "my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' left join cm_srvcsited s on s.tr_no=m.tr_no where m.status=3  and m.dtype='"+costgroup+"'  "+sqltest1+"  group by m.tr_no ";
              
              
            //  System.out.println("===sql3===="+sql);
              
             }
             
             if(typedocno.equalsIgnoreCase("5")) {
              
              sql = "select m.doc_no,m.tr_no,m.dtype,convert(concat(m.contracttype,' ',m.contractno),char(100)) prjname,ac.refname customer,m.cldocno,s.rowno siteid,s.site from cm_cuscallm m left join "
               + "my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' left join cm_srvcsited s on s.rowno=m.siteid where  m.status in(3)  "+sqltest+"";
            //  System.out.println("===sql4===="+sql);
             }
              
              stmt.close();
             
            }
            
         //  System.out.println("SQL ="+sql);
           ResultSet resultSet = stmtmain.executeQuery(sql);
           RESULTDATA=ClsCommon.convertToJSON(resultSet);
              
           stmtmain.close();
           conn.close();
           }
         stmtmain.close();
         conn.close();
        } catch(Exception e){
          e.printStackTrace();
          conn.close();
        } finally{
      conn.close();
     }
          return RESULTDATA;
     }




public JSONArray fleetSearch() throws SQLException {


	JSONArray RESULTDATA=new JSONArray();

	Connection conn = null;

	try {

	 
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement(); 


		String sql="select fleet_no fleetno ,flname fleetname,reg_no regno from gl_vehmaster where cost=0 ";
 
  
		ResultSet resultSet = stmt.executeQuery(sql);
		RESULTDATA=ClsCommon.convertToJSON(resultSet);
	 
	 

	}catch(Exception e){
		e.printStackTrace();

	}finally{
		conn.close();
	}
	return RESULTDATA;
}




public JSONArray prdGridReloads(HttpSession session,String docno,String locationid) throws SQLException {


	JSONArray RESULTDATA=new JSONArray();

	Connection conn = null;

	try {

	 
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();


		String sql="";
	 
		sql="select brandname,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno, qty "
				+ "  ,0 size,part_no,productid as proid,productid, "
				+ "productname as proname,productname,unit,unitdocno  from "
				+ "(select bd.brandname,d.specno as specid,d.rdocno,m.doc_no psrno, d.qty  as qty, "
				+ "m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno from my_mreqm ma left join my_mreqd d on(ma.doc_no=d.rdocno)"
				+ "left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
				+ "left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno )  "
				+ " where m.status=3 and d.rdocno in("+docno+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"'  ) as a  ";
		
		 
		ResultSet resultSet = stmt.executeQuery(sql);
		RESULTDATA=ClsCommon.convertToJSON(resultSet);
	 
	 

	}catch(Exception e){
		e.printStackTrace();

	}finally{
		conn.close();
	}
	return RESULTDATA;
}





public   JSONArray mainsearch(HttpSession session,String docnoss,String types,String datess,String aa,String prjdocnos) throws SQLException {

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
  		if(!(datess.equalsIgnoreCase("undefined"))&&!(datess.equalsIgnoreCase(""))&&!(datess.equalsIgnoreCase("0")))
      	{
      	sqlStartDate = ClsCommon.changeStringtoSqlDate(datess);
      	}
      	
      	
  	    
  		String sqltest="";
  	    
  	   	if((!(docnoss.equalsIgnoreCase(""))) && (!(docnoss.equalsIgnoreCase("NA")))){
      		sqltest=sqltest+" and m.voc_no like '%"+docnoss+"%'";
      	}
      	if((!(types.equalsIgnoreCase(""))) && (!(types.equalsIgnoreCase("NA")))){
      		sqltest=sqltest+" and t.type like '%"+types+"%'  ";
      	}
       String sqlsss2="";
      	if((!(prjdocnos.equalsIgnoreCase(""))) && (!(prjdocnos.equalsIgnoreCase("NA")))){
      		sqlsss2= " and a.costdocno like '%"+prjdocnos+"%'  ";
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
			
			

 
        	String pySql=" select * from ( select u.costgroup,t.type,m.description desc1,m.refno,m.doc_no,m.voc_no,m.date,m.issuetype,m.locid,l.loc_name,"
        			+ "m.costtype,m.siteid,s.site,a.refname,m.cldocno, "
        			+ " case when m.costtype=1 then m.costdocno when m.costtype in(3,4) then co.doc_no "
        			+ " when m.costtype in(5) then cs.doc_no  end as 'costdocno' , "
        			+ " case when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100)) "
        			+ "  when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'prjname' "
        			+ " from my_mreqm m left join my_locm l on l.doc_no=m.locid left join my_issuetype t on t.doc_no=m.issuetype"
        			+ " left join my_costunit u on u.costtype=m.costtype  "
        			+ " left join my_ccentre c on c.costcode=m.costdocno and m.costtype=1 "
        			+ " left join cm_srvcontrm co on co.tr_no=m.costdocno and m.costtype in(3,4) "
        			+ " left join cm_cuscallm cs on cs.tr_no=m.costdocno and m.costtype=5 "
        			+ " left join cm_srvcsited s on s.rowno=m.siteid and m.costtype in(3,4,5) "
        			+ " left join my_acbook a on a.cldocno=m.cldocno and m.costtype in(3,4,5) and a.dtype='CRM' "
        			+ " where m.status=3 and m.brhid='"+brcid+"' "+sqltest+"  ) a where 1=1 "+sqlsss2+" "; ;
        	
        //	System.out.println("=======pySql======="+pySql);
        	
     
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
//	System.out.println(RESULTDATA);
    return RESULTDATA;
}



public   ClsMaterialrequestBean   getViewDetails(int masterdoc_no) throws SQLException {
	
	ClsMaterialrequestBean showBean = new ClsMaterialrequestBean();
	Connection conn=null;
	try { conn = ClsConnection.getMyConnection();
	Statement stmt  = conn.createStatement ();
 

	String sqls=" select m.costdocno costtr_no,m.description,m.refno,m.doc_no,m.voc_no,m.date,m.issuetype,m.locid,l.loc_name,m.costtype,m.siteid,s.site,a.refname,m.cldocno, "
			+ " case when m.costtype=6 then m.costdocno  when m.costtype=1 then m.costdocno when m.costtype in(3,4) then co.doc_no "
 	+ " when m.costtype in(5) then cs.doc_no  end as 'costdocno' , "
	+ " case when m.costtype=6 then mm.flname when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100)) "
	+ "  when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'prjname' "
	+ " from my_mreqm m left join my_locm l on l.doc_no=m.locid left join my_ccentre c on c.costcode=m.costdocno and m.costtype=1 "
    + " left join cm_srvcontrm co on co.tr_no=m.costdocno and m.costtype in(3,4) "
	+ " left join cm_cuscallm cs on cs.tr_no=m.costdocno and m.costtype=5 "
	+ " left join gl_vehmaster mm on mm.fleet_no=m.costdocno and m.costtype=6 "
	+ " left join cm_srvcsited s on s.rowno=m.siteid and m.costtype in(3,4,5) "
	+ " left join my_acbook a on a.cldocno=m.cldocno and m.costtype in(3,4,5) and a.dtype='CRM' "
	+ " where m.status=3 and  m.doc_no='"+masterdoc_no+"'";

	
	//System.out.println("======sqls====="+sqls);
	
	
	ResultSet resultSet = stmt.executeQuery(sqls);    
 
	while (resultSet.next()) {
	
		showBean.setDocno(resultSet.getInt("voc_no"));
			
		showBean.setMasterdate(resultSet.getString("date"));
	 
		showBean.setPurdesc(resultSet.getString("description"));
		 
	 
		showBean.setTxtlocation(resultSet.getString("loc_name"));
		
		showBean.setTxtlocationid(resultSet.getInt("locid"));
	 
 	
		showBean.setRefno(resultSet.getString("refno"));
		 
			 
		showBean.setType(resultSet.getInt("issuetype"));
		showBean.setItemtype(resultSet.getInt("costtype"));
	 	
		showBean.setItemname(resultSet.getString("prjname"));
	 	
		showBean.setItemdocno(resultSet.getInt("costdocno"));
	    
		   
		showBean.setCldocno(resultSet.getInt("cldocno"));
	    
		showBean.setClientname(resultSet.getString("refname"));
	    
		showBean.setSite(resultSet.getString("site"));
		    
		showBean.setSiteid(resultSet.getInt("siteid"));
	    
	    
		showBean.setCosttr_no(resultSet.getInt("costtr_no"));
		 

		
		
	
	}
	 
 
	
	stmt.close();
	conn.close();
	}
	catch(Exception e){
		
	e.printStackTrace();
	conn.close();
	}
	return showBean;
}






public int update(Date masterdate, String refno, String purdesc,
		double productTotal, HttpSession session, String mode,
		String formdetailcode, HttpServletRequest request,
		ArrayList<String> masterarray, int txtlocationid, int cldocno,
		int siteid, int type, int itemtype, int itemdocno,int docno, String updatadata) throws SQLException {
 
	
	
	
	
	try{
		 
		 conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		CallableStatement stmtmr= conn.prepareCall("{call tr_materialrequestDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
 
		stmtmr.setInt(15,docno);
		stmtmr.setInt(16,0);

		stmtmr.setDate(1,masterdate);
		stmtmr.setString(2,refno);
		stmtmr.setString(3,purdesc);
		stmtmr.setDouble(4,0);
	  	 
		stmtmr.setString(5,session.getAttribute("USERID").toString());
		stmtmr.setString(6,session.getAttribute("BRANCHID").toString());
		stmtmr.setString(7,session.getAttribute("COMPANYID").toString());
		
		
	//	System.out.println("-----------"+session.getAttribute("BRANCHID").toString());
		stmtmr.setString(8,formdetailcode);
		stmtmr.setString(9,mode);
 
		
		stmtmr.setInt(10,txtlocationid);
		
 
		stmtmr.setInt(11,siteid);
		stmtmr.setInt(12,type);
		stmtmr.setInt(13,itemtype);
		stmtmr.setInt(14,itemdocno);
		stmtmr.setInt(17,cldocno);
		
		
		stmtmr.executeQuery();
		docno=stmtmr.getInt("docNo");
 
		int vocno=stmtmr.getInt("vocNo");	
		request.setAttribute("vocno", vocno);
	//	System.out.println("====docno========"+docno);
	
		if(docno<=0)
		{
			conn.close();
			return 0;
			
		}
		
		
		if(updatadata.equalsIgnoreCase("Editvalue"))
		{	
				
			
			 Statement stmt=conn.createStatement();
			 
			 
				for(int i=0;i< masterarray.size();i++){
					if(i==0)
					{
						String sqldel="delete from my_mreqd where rdocno='"+docno+"' ";
						stmt.executeUpdate(sqldel);
						
						
					}
					String[] prod=((String) masterarray.get(i)).split("::");
					//System.out.println("prod[0]===="+prod[0]);
					if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")))){

					
						
						
		 					 
				String  rqty=""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].trim().equalsIgnoreCase("")|| prod[3].isEmpty()?0:prod[3].trim())+"";
				double masterqty=Double.parseDouble(rqty);

	 
					String sql="insert into my_mreqd(TR_NO, SR_NO,rdocno,SpecNo, psrno, prdId,  qty , UNITID)VALUES"
							+ " ("+docno+","+(i+1)+",'"+docno+"',"
							+ "'"+(prod[6].equalsIgnoreCase("undefined") || prod[6].equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
							+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
							+ "'"+(prod[1].equalsIgnoreCase("undefined") || prod[1].equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
							+ "'"+masterqty+"',"
				 			+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"')";

					 stmt.executeUpdate(sql);
						
					}
				
			
		 
				
				}
			 
					
	 
	
		}
					if(docno>0)
					{
						conn.commit();
						stmtmr.close();
						conn.close();
						return docno;
						
					}
 
		
			}
	catch (Exception e) {
		conn.close();
		e.printStackTrace();
	}
	
	conn.close();
	return 0;
}




public    ClsMaterialrequestBean getPrint(int docno, HttpServletRequest request) throws SQLException {
			ClsMaterialrequestBean bean = new ClsMaterialrequestBean();
			Connection conn = null;
	try {
			 conn = ClsConnection.getMyConnection();

			 Statement stmt10 = conn.createStatement ();
			 Statement stmtprint=conn.createStatement();
			    String  MRsql=" select a.refname,m.doc_no,A.CLDOCNO,a.contactperson,a.per_mob,if(m.costtype=6, "
			    		+ "	concat(mm.fleet_no,'-',mm.flname),'') flname, "
			    		+ "	m.costdocno costtr_no,m.description as desc1,m.refno,m.doc_no,m.voc_no,DATE_FORMAT(m.date,'%d/%m/%Y') as date,m.issuetype,m.locid, "
			    		+ " l.loc_name,m.costtype,m.siteid,s.site,a.refname,m.cldocno, "
			    		+ " case when m.costtype=6 then concat(cu.costgroup,'-',m.costdocno) "
			    		+ " when m.costtype=1 then concat(cu.costgroup,'-',m.costdocno) when m.costtype in(3,4) "
			    		+ "	then concat(cu.costgroup,'-',co.doc_no)	when m.costtype in(5) then concat(cu.costgroup,'-',cs.doc_no) "
			    		+ "	end as 'costdocno' ,  case when m.costtype=6 then mm.flname "
			    		+ "	when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno), "
			    		+ "	char(100))   when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  "
			    		+ " end as 'prjname'  from my_mreqm m left join my_locm l on l.doc_no=m.locid "
			    		+ " left join my_ccentre c on c.costcode=m.costdocno and m.costtype=1"
			    		+ " left join cm_srvcontrm co on co.tr_no=m.costdocno and m.costtype in(3,4) "
			    		+ " left join cm_cuscallm cs on cs.tr_no=m.costdocno"
			    		+ "	and m.costtype=5  left join gl_vehmaster mm on mm.fleet_no=m.costdocno and m.costtype=6  "
			    		+ "	left join cm_srvcsited s on s.rowno=m.siteid and m.costtype in(3,4,5)  "
			    		+ "	left join my_acbook a on a.cldocno=m.cldocno and m.costtype in(3,4,5)"
			    		+ " and a.dtype='CRM'  left join my_costunit cu on cu.costtype= m.costtype  where m.status=3 and  m.doc_no="+docno+";";
			  

		         ResultSet resultsetcompany = stmt10.executeQuery(MRsql); 
			       
			       while(resultsetcompany.next()){
			    	   
			    	   bean.setRefname(resultsetcompany.getString("refname"));
			    	   bean.setCostdoc(resultsetcompany.getString("costdocno"));

			    	   
			    	   bean.setContperson(resultsetcompany.getString("contactperson"));
			    	   bean.setMob(resultsetcompany.getString("per_mob"));

			    	   bean.setDesc(resultsetcompany.getString("desc1"));
			    	   bean.setDate(resultsetcompany.getString("date"));
			    	   bean.setLoc_name(resultsetcompany.getString("loc_name"));
			    	   bean.setFlname(resultsetcompany.getString("flname"));


			       } 
			       
			       
			       String resql=" select cost.costgroup,iss.type issuetypes,m.costdocno costtr_no,m.description,m.refno,m.doc_no,m.voc_no,m.date,m.issuetype,m.locid, "
				   			+ " l.loc_name,m.costtype,m.siteid,s.site,a.refname,m.cldocno, "
				   			+ " case when m.costtype=6 then m.costdocno  when m.costtype=1 then m.costdocno when m.costtype in(3,4) then co.doc_no "
				   		 	+ " when m.costtype in(5) then cs.doc_no  end as 'costdocno' , "
				   			+ " case when m.costtype=6 then mm.flname when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100)) "
				   			+ " when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'prjname' "
				   			+ " from my_mreqm m left join my_locm l on l.doc_no=m.locid left join my_ccentre c on c.costcode=m.costdocno and m.costtype=1 "
				   		    + " left join cm_srvcontrm co on co.tr_no=m.costdocno and m.costtype in(3,4) "
				   			+ " left join cm_cuscallm cs on cs.tr_no=m.costdocno and m.costtype=5 "
				   			+ " left join gl_vehmaster mm on mm.fleet_no=m.costdocno and m.costtype=6 "
				   			+ " left join cm_srvcsited s on s.rowno=m.siteid and m.costtype in(3,4,5)  left join my_costunit cost on cost.costtype=m.costtype "
				   			+ " left join my_acbook a on a.cldocno=m.cldocno and m.costtype in(3,4,5) and a.dtype='CRM'  left join my_issuetype iss on iss.doc_no=m.issuetype "
				   			+ " where m.status=3 and  m.doc_no='"+docno+"'";

				   			
				   			//System.out.println("=========resql======="+resql);
				   			
				   			ResultSet pintrs = stmtprint.executeQuery(resql);
				   			
				   	 
				   		       while(pintrs.next()){
				   		    	
				   		    	    bean.setLbldocno(pintrs.getString("voc_no"));
				   		    	    bean.setLbldate(pintrs.getString("date"));
				   		    	    bean.setLblrefno(pintrs.getString("refno"));
				   		    	    bean.setLbldesc1(pintrs.getString("description"));
				   		    	    bean.setLbllocation1(pintrs.getString("loc_name"));
				   		    	 
				   		    	    bean.setLbltype(pintrs.getString("issuetypes"));
				    
				   		    	    bean.setLblprjname(pintrs.getString("costgroup")+" - "+pintrs.getString("costdocno")+" - "+pintrs.getString("prjname"));
				   		    	    bean.setLblclname(pintrs.getString("refname"));
				   		    	    bean.setLblsite(pintrs.getString("site"));
				   		    	     
				    
				   		    	    
				   		    	  
				   		       }
				   			

				   			stmtprint.close();
				   			
				   			
				   			
				   			 Statement companystmt10 = conn.createStatement ();
				   			    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from my_mreqm r  "
				   			    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
				   			    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";


				   		         ResultSet resultsetcompanyst10 = companystmt10.executeQuery(companysql); 
				   			       
				   			       while(resultsetcompanyst10.next()){
				   			    	   
				   			    	   bean.setLblbranch(resultsetcompanyst10.getString("branchname"));
				   			    	   bean.setLblcompname(resultsetcompanyst10.getString("company"));
				   			    	  
				   			    	   bean.setLblcompaddress(resultsetcompanyst10.getString("address"));
				   			    	   bean.setLblcomptel(resultsetcompanyst10.getString("tel"));
				   			    	  
				   			    	   bean.setLblcompfax(resultsetcompanyst10.getString("fax"));
				   			    	   bean.setLbllocation(resultsetcompanyst10.getString("location"));
				   			    	  
				   			    	   
				   			    	   
				   			       } 
				   			     stmt10.close();
				   						
				   			     ArrayList<String> arr =new ArrayList<String>();
				   			   	 Statement stmtgrid = conn.createStatement();       
				   			     String temp="";  
 
				   				 
				   	 String	strSqldetail=" select brandname,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno, qty "
				   						+ "  ,0 size,part_no,productid as proid,productid, "
				   						+ "productname as proname,productname,unit,unitdocno  from "
				   						+ "(select bd.brandname,d.specno as specid,d.rdocno,m.doc_no psrno,round(d.qty,2) qty, "
				   						+ "m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno from my_mreqm ma left join my_mreqd d on(ma.doc_no=d.rdocno)"
				   						+ "left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
				   						+ "left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno )  "
				   						+ " where m.status=3 and d.rdocno in("+docno+")    ) as a  ";
				   			       
				   			       
                                         // System.out.println("====strSqldetail======="+strSqldetail);
				   			       
				   			       
				   				ResultSet rsdetail=stmtgrid.executeQuery(strSqldetail);
				   				
				   				int rowcount=1;
				   		
				   				while(rsdetail.next()){
				   					 
				   						 
				   						temp=rowcount+"::"+rsdetail.getString("part_no")+"::"+rsdetail.getString("productname")+"::"+rsdetail.getString("brandname")+"::"+
				   						rsdetail.getString("unit")+"::"+rsdetail.getString("qty") ;
				   						arr.add(temp);
				   						rowcount++;
				   		
				   						 
				   			          }
				   			             
				   				request.setAttribute("details", arr);
				   				stmtgrid.close();
				   				
				   				
				   				
				       
				       
			       
			       
			       conn.close();



					
	}
	catch(Exception e){
		conn.close();
		e.printStackTrace();
	}
	return bean;
	

}

public JSONArray subCategorySearch() throws SQLException {


	JSONArray RESULTDATA=new JSONArray();

	Connection conn = null;

	try {
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();

		String sql="select doc_no,subcategory from my_scatm where status=3";

		ResultSet resultSet = stmt.executeQuery(sql);
		RESULTDATA=ClsCommon.convertToJSON(resultSet);


	}catch(Exception e){
		e.printStackTrace();

	}finally{
		conn.close();
	}
	return RESULTDATA;
}

public JSONArray brandSearch() throws SQLException {


	JSONArray RESULTDATA=new JSONArray();

	Connection conn = null;

	try {
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();

		String sql="select doc_no,brandname from my_brand where status=3";

		ResultSet resultSet = stmt.executeQuery(sql);
		RESULTDATA=ClsCommon.convertToJSON(resultSet);


	}catch(Exception e){
		e.printStackTrace();

	}finally{
		conn.close();
	}
	return RESULTDATA;
}

}
