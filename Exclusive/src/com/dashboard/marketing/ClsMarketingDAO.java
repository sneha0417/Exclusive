package com.dashboard.marketing;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;


public class ClsMarketingDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray Searchclient(HttpSession session) throws SQLException {

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
	   	        
       
     	Connection conn = null;
        
		try {
	        String brch=session.getAttribute("BRANCHID").toString();
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
			
            		String sql="select refname,cldocno from my_acbook where dtype='CRM' and brhid='"+brch+"' ";
          
            		ResultSet ress= stmtVeh1.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(ress);
            		stmtVeh1.close();
            	conn.close();
		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	public JSONArray enquirylistsearch(String brnchval,String fromdate,String todate,String clientname) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}
     	
     	String sqltest="";
       	if(!(clientname.equalsIgnoreCase(""))){
       		sqltest=sqltest+" and e.name like '%"+clientname+"%'";
       	}
       
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				//String sql="";
				//ResultSet resultSet ;
				//System.out.println("========="+brnchval);
            	if(brnchval.equalsIgnoreCase("a"))
            	{
            		String sql="select e.voc_no,e.brhid, e.doc_no, e.date, e.remarks, e.cldocno, e.name, e.mob, if(e.enqtype=0,'General','Client') type,d.rtype,"
            				+ "	d.frmdate,d.todate,concat(br.brand_name,' ',mo.vtype) brmodel from gl_enqm e left join  gl_enqd d on d.rdocno=e.doc_no   "
            				+ "left join gl_vehmodel mo on mo.doc_no=d.modid "
            				+ "	left join gl_vehbrand br on br.doc_no=d.brdid where e.status=3  and e.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest;
          //  System.out.println("----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     		      
     				
            	}
            	else{				 
            		String sql="select e.voc_no,e.brhid, e.doc_no, e.date, e.remarks, e.cldocno, e.name, e.mob, if(e.enqtype=0,'General','Client') type,d.rtype,"
            				+ "	d.frmdate,d.todate,concat(br.brand_name,' ',mo.vtype) brmodel from gl_enqm e left join  gl_enqd d on d.rdocno=e.doc_no   "
            				+ "left join gl_vehmodel mo on mo.doc_no=d.modid "
            				+ "	left join gl_vehbrand br on br.doc_no=d.brdid where e.status=3   and e.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  and e.brhid='"+brnchval+"' "+sqltest;
            	 //	System.out.println("----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 							
            	}
          
            	conn.close();
		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	public JSONArray enquiryfollowsearch(String brnchval,String fromdate,String todate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

     	Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				//String sql="";
				//ResultSet resultSet ;
				//System.out.println("========="+brnchval);
            	if(brnchval.equalsIgnoreCase("a"))
            	{
            		String sql="select e.voc_no,bv.fdate, e.brhid, e.doc_no, e.date, e.remarks, e.cldocno, e.name, e.mob, if(e.enqtype=0,'General','Client') type,e.enqtype,d.rtype, "
            				+ "d.frmdate,d.todate,concat(br.brand_name,' ',mo.vtype) brmodel from gl_enqm e left join  gl_enqd d on d.rdocno=e.doc_no "
            				+ "left join gl_vehmodel mo on mo.doc_no=d.modid 	left join gl_vehbrand br on br.doc_no=d.brdid "
            				+ "left join (select max(b.doc_no) doc_no,rdocno from gl_benq b group by  rdocno) b on(b.rdocno=e.doc_no) left join "
            				+ "gl_benq bv on b.doc_no=bv.doc_no where e.status=3 and e.clstatus<2 and e.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  ";
            	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            	}
            	else{				 
            		String sql="select  e.voc_no,bv.fdate, e.brhid, e.doc_no, e.date, e.remarks, e.cldocno, e.name, e.mob, if(e.enqtype=0,'General','Client') type,e.enqtype,d.rtype, "
            				+ "d.frmdate,d.todate,concat(br.brand_name,' ',mo.vtype) brmodel from gl_enqm e left join  gl_enqd d on d.rdocno=e.doc_no "
            				+ "left join gl_vehmodel mo on mo.doc_no=d.modid 	left join gl_vehbrand br on br.doc_no=d.brdid "
            				+ "left join (select max(b.doc_no) doc_no,rdocno from gl_benq b group by  rdocno) b on(b.rdocno=e.doc_no) left join "
            				+ "gl_benq bv on b.doc_no=bv.doc_no where e.status=3 and e.clstatus<2 and e.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  and e.brhid='"+brnchval+"'";
            	 	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 				
            	}
            	conn.close();

		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	public JSONArray enqDetails(String rdocno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
			
            		String sql=" select m.date detdate,m.remarks remk,m.fdate,u.user_name user from gl_benq m "
            				+ " inner join my_user u on u.doc_no=m.userid where m.rdocno='"+rdocno+"'  and m.bibpid=15 group by m.doc_no ";

            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				conn.close();
            
            	
          

		}
		
		catch(Exception e){
			conn.close();	
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	public JSONArray quotlistsearch(String brnchval,String fromdate,String todate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        
        
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				//String sql="";
				//ResultSet resultSet ;
				//System.out.println("========="+brnchval);
            	if(brnchval.equalsIgnoreCase("a"))
            	{
            		String sql="select q.voc_no,q.BRANCH, q.DOC_NO, q.DATE,  q.REF_NO, if(q.REF_TYPE='DIR','Direct','Enquiry') type,q.contact_no mob ,q.remarks,d.rtype, "
            				+ "d.frmdate,d.todate,concat(br.brand_name,' ',mo.vtype) brmodel,if(q.REF_TYPE='DIR',a.refname,e.name) name from  "
            				+ "gl_quotm q left join gl_qenq d on d.rdocno=q.doc_no "
            				+ "left join gl_vehmodel mo on mo.doc_no=d.modid  left join gl_vehbrand br on br.doc_no=d.brdid "
            				+ "left join gl_enqm e on e.doc_no=q.ref_no left join my_acbook a on a.cldocno=q.cldocno and a.dtype='CRM'  "
            				+ " where q.status=3 and q.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  ";
            //	System.out.println("----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            	}
            	else{	
            		
            		String sql="select q.voc_no,q.BRANCH, q.DOC_NO, q.DATE,  q.REF_NO, if(q.REF_TYPE='DIR','Direct','Enquiry') type,q.contact_no mob ,q.remarks,d.rtype, "
            				+ "d.frmdate,d.todate,concat(br.brand_name,' ',mo.vtype) brmodel,if(q.REF_TYPE='DIR',a.refname,e.name) name from  "
            				+ "gl_quotm q left join gl_qenq d on d.rdocno=q.doc_no "
            				+ "left join gl_vehmodel mo on mo.doc_no=d.modid  left join gl_vehbrand br on br.doc_no=d.brdid "
            				+ "left join gl_enqm e on e.doc_no=q.ref_no left join my_acbook a on a.cldocno=q.cldocno and a.dtype='CRM'  "
            				+ " where q.status=3  and q.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  and q.BRANCH='"+brnchval+"'";
            		
            	
            	 	//System.out.println("----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 				
            	}
            	conn.close();

		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	public JSONArray quotfollowtsearch(String brnchval,String fromdate,String todate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        
        
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				//String sql="";
				//ResultSet resultSet ;
				//System.out.println("========="+brnchval);
            	if(brnchval.equalsIgnoreCase("a"))
            	{
            		String sql="select q.voc_no,bv.fdate,q.BRANCH, q.DOC_NO, q.DATE,  q.REF_NO, if(q.REF_TYPE='DIR','Direct','Enquiry') type,q.CONTACT_NO mob ,q.remarks,d.rtype,q.REF_TYPE reftype, "
            				+ "d.frmdate,d.todate,concat(br.brand_name,' ',mo.vtype) brmodel,if(q.REF_TYPE='DIR',a.refname,e.name) name from  "
            				+ "gl_quotm q left join gl_qenq d on d.rdocno=q.doc_no "
            				+ "left join gl_vehmodel mo on mo.doc_no=d.modid  left join gl_vehbrand br on br.doc_no=d.brdid "
            				+ "left join gl_enqm e on e.doc_no=q.ref_no left join my_acbook a on a.cldocno=q.cldocno and a.dtype='CRM'  "
            				+ "left join (select max(b.doc_no) doc_no,rdocno from gl_bqot b group by  rdocno) b on(b.rdocno=q.doc_no) left join "
            				+ "gl_bqot bv on b.doc_no=bv.doc_no  where q.status=3  and q.clstatus<2 and q.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  ";
          //	System.out.println("----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            	}
            	else{	
            		
            		String sql="select q.voc_no,bv.fdate,q.BRANCH, q.DOC_NO, q.DATE,  q.REF_NO, if(q.REF_TYPE='DIR','Direct','Enquiry') type,q.CONTACT_NO mob ,q.remarks,d.rtype,q.REF_TYPE reftype, "
            				+ "d.frmdate,d.todate,concat(br.brand_name,' ',mo.vtype) brmodel,if(q.REF_TYPE='DIR',a.refname,e.name) name from  "
            				+ "gl_quotm q left join gl_qenq d on d.rdocno=q.doc_no "
            				+ "left join gl_vehmodel mo on mo.doc_no=d.modid  left join gl_vehbrand br on br.doc_no=d.brdid "
            				+ "left join gl_enqm e on e.doc_no=q.ref_no left join my_acbook a on a.cldocno=q.cldocno and a.dtype='CRM'  "
            				+ "left join (select max(b.doc_no) doc_no,rdocno from gl_bqot b group by  rdocno) b on(b.rdocno=q.doc_no) left join "
            				+ "gl_bqot bv on b.doc_no=bv.doc_no  where q.status=3   and q.clstatus<2 and q.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  and q.BRANCH='"+brnchval+"'";
            		
            	
            	//System.out.println("----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 				
            	}
          
            	conn.close();
		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	public JSONArray qotDetails(String rdocno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
			
            		String sql=" select m.date detdate,m.remarks remk,m.fdate,u.user_name user from gl_bqot m "
            				+ " inner join my_user u on u.doc_no=m.userid where m.rdocno='"+rdocno+"'  and m.bibpid=18 group by m.doc_no ";

            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				conn.close();
            
            	
          

		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	

	

	public JSONArray bookinglistsearch(String brnchval,String fromdate,String todate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        
        
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				//String sql="";
				//ResultSet resultSet ;
				//System.out.println("========="+brnchval);
            	if(brnchval.equalsIgnoreCase("a"))
            	{
            		String sql="select b.voc_no, b.brhid, b.DOC_NO, b.DATE,  b.REFNO, if(b.REFTYPE='DIR','Direct','Quotation')type,b.reftype,"
            				+ "b.CONTACTNO mob ,b.remarks,b.rtype, b.frmdate,b.todate,concat(br.brand_name,' ',mo.vtype) brmodel,"
            				+ "a.refname name from  gl_bookingm b left join gl_vehmodel mo on mo.doc_no=b.modid "
            				+ "  left join gl_vehbrand br on br.doc_no=b.brdid left join gl_quotm q on q.doc_no=b.refno "
            				+ " left join gl_enqm e on e.doc_no=q.ref_no left join my_acbook a on a.cldocno=b.cldocno and a.dtype='CRM'   where b.status=3  "
            				+ "and b.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  ";
            	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            	}
            	else{	
            		String sql="select b.voc_no,b.brhid, b.DOC_NO, b.DATE,  b.REFNO, if(b.REFTYPE='DIR','Direct','Quotation')type,b.reftype,"
            				+ "b.CONTACTNO mob ,b.remarks,b.rtype, b.frmdate,b.todate,concat(br.brand_name,' ',mo.vtype) brmodel,"
            				+ "a.refname name from  gl_bookingm b left join gl_vehmodel mo on mo.doc_no=b.modid "
            				+ "  left join gl_vehbrand br on br.doc_no=b.brdid left join gl_quotm q on q.doc_no=b.refno "
            				+ " left join gl_enqm e on e.doc_no=q.ref_no left join my_acbook a on a.cldocno=b.cldocno and a.dtype='CRM'   "
            				+ " where b.status=3  and b.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"' and  b.brhid='"+brnchval+"' ";
            		
            		
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 				
            	}
            	conn.close();

		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	public JSONArray bookingfollowsearch(String brnchval,String fromdate,String todate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        
        
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				//String sql="";
				//ResultSet resultSet ;
				//System.out.println("========="+brnchval);
            	if(brnchval.equalsIgnoreCase("a"))
            	{
            		String sql="select convert(if(b.delivery=1,round(b.delchg,2),''),char(50)) delchg,b.voc_no,convert(if(b.fleet_no='0','',b.fleet_no),char(20)) fleet_no,b.grpid,b.delivery,b.chuef,bv.fdate,b.cldocno,b.brhid, b.DOC_NO, b.DATE,  b.REFNO, if(b.REFTYPE='DIR','Direct','Quotation') type,b.REFTYPE,"
            				+ "b.CONTACTNO mob ,b.remarks,b.rtype, b.frmdate,b.frmtime,b.todate,concat(br.brand_name,' ',mo.vtype) brmodel,"
            				+ "a.refname name from  gl_bookingm b left join gl_vehmodel mo on mo.doc_no=b.modid "
            				+ "  left join gl_vehbrand br on br.doc_no=b.brdid left join gl_quotm q on q.doc_no=b.refno "
            				+ " left join gl_enqm e on e.doc_no=q.ref_no left join my_acbook a on a.cldocno=b.cldocno and a.dtype='CRM'   "
            				+ "left join (select max(s.doc_no) doc_no,rdocno from gl_bvbr s group by  rdocno) s on(s.rdocno=b.doc_no) left join "
            				+ "gl_bvbr bv on s.doc_no=bv.doc_no where b.status=3 and b.rano<=0 and b.clstatus<2 and b.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  ";
         //  System.out.println("------------11---------"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            	}
            	else{	
            		String sql="select   convert(if(b.delivery=1,round(b.delchg,2),''),char(50)) delchg,b.voc_no,convert(if(b.fleet_no='0','',b.fleet_no),char(20)) fleet_no,b.grpid,b.delivery,b.chuef,bv.fdate,b.brhid, b.DOC_NO, b.DATE,  b.REFNO, if(b.REFTYPE='DIR','Direct','Quotation') type,b.REFTYPE,"
            				+ "b.CONTACTNO mob ,b.remarks,b.rtype, b.frmdate,b.frmtime,b.todate,concat(br.brand_name,' ',mo.vtype) brmodel,"
            				+ "a.refname name from  gl_bookingm b left join gl_vehmodel mo on mo.doc_no=b.modid "
            				+ "  left join gl_vehbrand br on br.doc_no=b.brdid left join gl_quotm q on q.doc_no=b.refno "
            				+ " left join gl_enqm e on e.doc_no=q.ref_no left join my_acbook a on a.cldocno=b.cldocno and a.dtype='CRM'   "
            				+ "left join (select max(s.doc_no) doc_no,rdocno from gl_bvbr s group by  rdocno) s on(s.rdocno=b.doc_no) left join "
            				+ "gl_bvbr bv on s.doc_no=bv.doc_no where b.status=3 and b.rano<=0 and b.clstatus<2 and b.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"' and  b.brhid='"+brnchval+"' ";
            		//System.out.println("---------------------"+sql);
            		 
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 				
            	}
            	conn.close();

		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    } 
    public JSONArray vehSearchbooking(String brid,String group) throws SQLException {
    	  JSONArray RESULTDATA=new JSONArray();

	    	 Connection conn=null;
			try {
				 conn = ClsConnection.getMyConnection();
				
				
					
					Statement stmtVeh8 = conn.createStatement ();
	            	
					String vehsql="select v.doc_no vdocno,v.reg_no,v.fleet_no,v.FLNAME,v.a_loc, "
							+ "	CASE WHEN m.FIN='0.000' THEN 'Level 0/8'  WHEN m.FIN='0.125' THEN 'Level 1/8' WHEN m.FIN='0.250' THEN 'Level 2/8' WHEN m.FIN='0.375' "
							+ "	THEN 'Level 3/8' WHEN m.FIN='0.500' THEN 'Level 4/8' WHEN m.FIN='0.625' THEN 'Level 5/8' "
							+ "	WHEN m.FIN='0.750' THEN 'Level 6/8' WHEN m.FIN='0.875' THEN 'Level 7/8' WHEN m.FIN='1.000' THEN 'Level 8/8' "
							+ "	 END as 'FIN',m.FIN hidfin,m.fleet_no ,m.kmin,c.doc_no,c.color,g.gname,g.doc_no gid from gl_vehmaster v "
							+ "	left join gl_vmove m on v.fleet_no=m.fleet_no  left join my_color c "
							+ " on v.clrid=c.doc_no left join gl_vehgroup g on g.doc_no=v.vgrpid "
							+ "	where v.a_br="+brid+" and ins_exp >=current_date and v.statu <> 7 and   "
							+ "	m.doc_no=(select (max(doc_no)) from gl_vmove where fleet_no=v.fleet_no) and "
							+ " fstatus in ('L','N') and v.status='IN' and v.tran_code='RR' and v.renttype in ('A','R') and v.vgrpid='"+group+"' " ;
			//System.out.println("---------------"+vehsql);
					ResultSet resultSet = stmtVeh8.executeQuery(vehsql);
					
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVeh8.close();
			
				conn.close();
				 return RESULTDATA;
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	    
	
	public JSONArray bookDetails(String rdocno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
			
            		String sql=" select m.date detdate,m.remarks remk,m.fdate,u.user_name user from gl_bvbr m "
            				+ " inner join my_user u on u.doc_no=m.userid where m.rdocno='"+rdocno+"'  and m.bibpid=20 group by m.doc_no ";

            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				conn.close();
            
            	
          

		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public  JSONArray analysisDetails(String fromdate,String todate,String brnchval,String type,String status) throws SQLException {

		
        JSONArray RESULTDATA=new JSONArray();
        
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}
 
     	String sqltest="";
		
     	if(type.equalsIgnoreCase("CEQ"))
     	{
     		
     			if(!brnchval.equalsIgnoreCase("a")){
     				sqltest=" and e.brhid="+brnchval;
     			            }	
        	
         		
     		
     	}
     	
     	
     	else if(type.equalsIgnoreCase("QOT"))
     	{
      		
      			if(!brnchval.equalsIgnoreCase("a")){
      				sqltest=" and q.BRANCH="+brnchval;
      			            }
        		
     		
     		
     	}
     	else if(type.equalsIgnoreCase("BOK"))
     	{
     		
      		
      			if(!brnchval.equalsIgnoreCase("a")){
      				sqltest=" and b.brhid="+brnchval;
      			            }	
        		
     		
     	}
     	
  	if(status.equalsIgnoreCase("PED"))
     	{
		  		if(type.equalsIgnoreCase("CEQ"))
		     	{
		  			sqltest=sqltest+" and e.clstatus=0 ";
		     	}
		
		     	else if(type.equalsIgnoreCase("QOT"))
		     	{
		     		sqltest=sqltest+" and q.clstatus=0 ";
		     	}
		     	else if(type.equalsIgnoreCase("BOK"))
		     	{
		     		
		     		sqltest=sqltest+" and b.rano=0 ";
		     	}
  		
  		
      	}
  	
  	else if(status.equalsIgnoreCase("LIK"))
  	  {
  		
				if(type.equalsIgnoreCase("CEQ"))
		     	{
					sqltest=sqltest+" and e.clstatus<>0 ";
		     	}
		
		     	else if(type.equalsIgnoreCase("QOT"))
		     	{
		     		sqltest=sqltest+" and q.clstatus<>0 ";
		     	}
		     	else if(type.equalsIgnoreCase("BOK"))
		     	{
		     		sqltest=sqltest+" and b.rano>0 ";
		     		
		     	}
		  		
  		
  	   }
	
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				 Statement stmtVeh = conn.createStatement ();
			    	
			     	if(type.equalsIgnoreCase("CEQ"))
			     	{	
            		String sql="select b.branchname,case when e.clstatus=3 then 'Quotation' when e.clstatus=4 then 'Booking' when e.clstatus=5 then 'Rental Agreement' else 'Enquiry' end as 'status' ,e.clstatus, "
            				+ " e.voc_no,e.brhid, e.doc_no, e.date, e.remarks, e.cldocno, e.name, e.mob, if(e.enqtype=0,'General','Client') type from gl_enqm e left join my_brch b on b.doc_no=e.brhid  "
            				+ " where e.status=3   and e.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest;
            		
            	//	System.out.println("--enq----"+sql);
            		
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
           		    RESULTDATA=ClsCommon.convertToJSON(resultSet);
    				stmtVeh.close();
    			
           
			     	}
			     	else if(type.equalsIgnoreCase("QOT"))
			     	{	
			     		String sql="select b.branchname,case when  e.clstatus=4 then 'Booking' when e.clstatus=5 then 'Rental Agreement' else 'Quotation' end as 'status' ,q.clstatus, "
	            				+ " q.voc_no,q.BRANCH,q.remarks, q.DOC_NO, q.DATE,  q.REF_NO, if(q.REF_TYPE='DIR','Quotation','Enquiry') type,q.contact_no mob ,if(q.REF_TYPE='DIR',a.refname,e.name) name "
	            				+ " from  gl_quotm q left join gl_enqm e on e.doc_no=q.ref_no left join my_acbook a on a.cldocno=q.cldocno and a.dtype='CRM'  left join my_brch b on b.doc_no=q.BRANCH  "
	            				+ " where q.status=3 and q.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest;
			     		//System.out.println("--qot---"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
           		    RESULTDATA=ClsCommon.convertToJSON(resultSet);
    				stmtVeh.close();
    			
           
			     	}
            	
			     	
			     	
			     	else if(type.equalsIgnoreCase("BOK"))
			     	{	
			     		String sql="select b1.branchname,if(rano>0,'Rental Agreement','Booking') status,b.voc_no, b.brhid, b.DOC_NO, b.DATE, b.rano clstatus, "
			     				+ " b.REFNO REF_NO, if(b.REFTYPE='DIR','Booking','Quotation')type,b.reftype,b.CONTACTNO mob ,b.remarks,a.refname name  "
			     				+ " from  gl_bookingm b  left join my_brch b1 on b1.doc_no=b.brhid left join my_acbook a  "
			     				+ " on a.cldocno=b.cldocno and a.dtype='CRM'   where b.status=3 and b.DATE  between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest;
			    		//System.out.println("--booking---"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
           		    RESULTDATA=ClsCommon.convertToJSON(resultSet);
    				stmtVeh.close();
    			
           
			     	}
     				conn.close();
            
            	
          

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
}
