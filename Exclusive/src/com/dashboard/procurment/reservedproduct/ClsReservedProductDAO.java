package com.dashboard.procurment.reservedproduct;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsReservedProductDAO {
	ClsCommon clscom=new ClsCommon();
	ClsConnection clsconn=new ClsConnection(); 
	public  JSONArray loadGridData(String fromdate,String todate,String rds,String barchval,String contrctid,String clientid,String brandid,String prdid,String cldocno,String type) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="";
		try {

			//System.out.println("=====loadTrafficdaily");
			
			conn = clsconn.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sqlfromdate = null;
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=clscom.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqltodate=clscom.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}
	    	
	    	

			/*if(barchval.equalsIgnoreCase("a"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest+=" and cm.brhid="+barchval;
			}
			*/
			if(!(contrctid.equalsIgnoreCase("")) && !(contrctid.equalsIgnoreCase("0"))){
	       		sqltest+="  and cm.tr_no="+contrctid+" ";
	       	}
			
						
			if(!(cldocno.equalsIgnoreCase("")) && !(cldocno.equalsIgnoreCase("0"))){
	       		sqltest+=" and a.cldocno="+cldocno+" ";
	       	}
			
			if(!(brandid.equalsIgnoreCase("")) && !(brandid.equalsIgnoreCase("0"))){
	       		sqltest+=" and m.brandid="+brandid+" ";
	       	}

			if(!(prdid.equalsIgnoreCase("")) && !(prdid.equalsIgnoreCase("0"))){
	       		sqltest+=" and m.psrno="+prdid+" ";
	       	}
			if(rds.equalsIgnoreCase("AMC")){
				sqltest+=" and cm.dtype='AMC' ";
			}
			 if(rds.equalsIgnoreCase("SJOB")){
					sqltest+=" and cm.dtype='SJOB' ";
				}
				
		String sqldata="SELECT M.PART_NO CODE, M.PRODUCTNAME prdname,B.BRANDNAME brdname,A.CLDOCNO,A.REFNAME clientname,CM.DTYPE, "
				+ "CM.DOC_NO,cm.tr_no,S.SITE,round(RSV_QTY,2) rsrvqty,round(ISSUEQTY,2) isuqty FROM MY_PRDDR P LEFT JOIN MY_MAIN M ON P.PSRNO=M.PSRNO "
				+ "LEFT JOIN MY_BRAND B ON M.BRANDID=B.DOC_NO LEFT JOIN CM_SRVCONTRM CM ON CM.TR_NO=P.TR_NO "
				+ "LEFT JOIN MY_ACBOOK A ON A.CLDOCNO=CM.CLDOCNO AND A.DTYPE='CRM' LEFT JOIN "
				+ "(SELECT GROUP_CONCAT(SITE) SITE,TR_NO FROM CM_SERVSITED GROUP BY TR_NO ) S ON S.TR_NO=CM.TR_NO "
				+ "   where  cm.date between     '"+sqlfromdate+"'  and '"+sqltodate+"' and cm.status!=7 "+sqltest+"  ";
		
		System.out.println("********grid****"+sqldata);
				resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=clscom.convertToJSON(resultSet);
			//			System.out.println("=====RESULTDATA"+RESULTDATA);

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
	
	
	public  JSONArray loadGridExcel(String fromdate,String todate,String rds,String barchval,String contrctid,String clientid,String brandid,String prdid,String cldocno,String type) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="";
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = clsconn.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sqlfromdate = null;
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=clscom.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqltodate=clscom.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}
	    	
	    	
/*
			if(barchval.equalsIgnoreCase("a"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest+=" and cm.brhid="+barchval;
			}*/
			
	     	if(!(contrctid.equalsIgnoreCase("")) && !(contrctid.equalsIgnoreCase("0"))){
	       		sqltest+="  and cm.tr_no="+contrctid+" ";
	       	}
			
						
			if(!(cldocno.equalsIgnoreCase("")) && !(cldocno.equalsIgnoreCase("0"))){
	       		sqltest+=" and a.cldocno="+cldocno+" ";
	       	}
			
			if(!(brandid.equalsIgnoreCase("")) && !(brandid.equalsIgnoreCase("0"))){
	       		sqltest+=" and m.brandid="+brandid+" ";
	       	}

			if(!(prdid.equalsIgnoreCase("")) && !(prdid.equalsIgnoreCase("0"))){
	       		sqltest+=" and m.psrno="+prdid+" ";
	       	}
			if(rds.equalsIgnoreCase("AMC")){
				sqltest+=" and cm.dtype='AMC' ";
			}
			 if(rds.equalsIgnoreCase("SJOB")){
					sqltest+=" and cm.dtype='SJOB' ";
				}
				
		String sqldata="SELECT M.PART_NO CODE, M.PRODUCTNAME as 'Product Name',B.BRANDNAME as 'Brand Name',A.REFNAME as 'Client name',CM.DTYPE as Type , "
				+ "cm.tr_no,S.SITE,round(RSV_QTY,2) as 'Reserv Qty',round(ISSUEQTY,2) as 'Issue Qty' FROM MY_PRDDR P LEFT JOIN MY_MAIN M ON P.PSRNO=M.PSRNO "
				+ "LEFT JOIN MY_BRAND B ON M.BRANDID=B.DOC_NO LEFT JOIN CM_SRVCONTRM CM ON CM.TR_NO=P.TR_NO "
				+ "LEFT JOIN MY_ACBOOK A ON A.CLDOCNO=CM.CLDOCNO AND A.DTYPE='CRM' LEFT JOIN "
				+ "(SELECT GROUP_CONCAT(SITE) SITE,TR_NO FROM CM_SERVSITED GROUP BY TR_NO ) S ON S.TR_NO=CM.TR_NO "
				+ "   where  cm.date between     '"+sqlfromdate+"'  and '"+sqltodate+"' and cm.status!=7 "+sqltest+"  ";
				System.out.println("******gridload*excel*****"+sqldata);
				resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=clscom.convertToEXCEL(resultSet);
			//			System.out.println("=====RESULTDATA"+RESULTDATA);

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

	
	public JSONArray brandFormSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = clsconn.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select doc_no,brand from my_brand where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=clscom.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}


	
	public JSONArray accountDetails(String type,String account,String partyname,String contact,String load) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	    if(!(load.equalsIgnoreCase("1"))){
	    	return RESULTDATA1;
	    }
	
	    try {
	    	    conn = clsconn.getMyConnection();
		        Statement stmtClient = conn.createStatement();
			
	    	    String sql = "";
	    	    String condition="";
            	
				/*if(type.equalsIgnoreCase("AR")){
					condition="and a.dtype='CRM'";
				}
				if(type.equalsIgnoreCase("AP")){
					condition="and a.dtype='VND'";
				}*/
				
	    	    if(!(account.equalsIgnoreCase(""))){
	                sql=sql+" and a.cldocno like '%"+account+"%'";
	            }
	            if(!(partyname.equalsIgnoreCase(""))){
	             sql=sql+" and a.refname like '%"+partyname+"%'";
	            }
	            if(!(contact.equalsIgnoreCase(""))){
	                sql=sql+" and a.per_mob like '%"+contact+"%'";
	            }
	            
				sql = "select a.per_mob,a.cldocno doc_no,t.account,a.refname from my_acbook a left join my_head t on a.acno=t.doc_no "
						+ " where a.dtype='crm' and a.status<>7  "+sql;
				
				ResultSet resultSet1 = stmtClient.executeQuery(sql);
				
				RESULTDATA1=clscom.convertToJSON(resultSet1);
				
				stmtClient.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}

	
	public   JSONArray contractDetailsSearch(HttpSession session,String clientid,String dtype,String refno,String contractno) throws SQLException {


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

		//  System.out.println("8888888888"+clnames); 	
		String brid=session.getAttribute("BRANCHID").toString();
		String sql11="";


		java.sql.Date sqlStartDate=null;

		/*select count(*) as count,if(m.status=1,'HOLD',if(m.status=2,'CLOSED',if(m.status=3,'COMPLETED',if(m.status=4,'STARTED','ENTERED')))) as statuss,status from cm_servplan m group by status;*/

		//enqdate.trim();


		String sqltest="";

		if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
			sql11+=" and a.cldocno in ("+clientid+")";
		}
		if(!(dtype.equals("0") || dtype.equals("") || dtype.equals("undefined")|| dtype.equals("ALL"))){
			sql11=sql11+" and a.dtype='"+dtype+"'";
		}

		if(!(refno.equals("0") || refno.equals("") || refno.equals("undefined"))){
			sql11=sql11+" and a.refno like '%"+refno+"%'";
		}

		if(!(contractno.equals("0") || contractno.equals("") || contractno.equals("undefined"))){
			sql11=sql11+" and a.doc_no='"+contractno+"'";
		}

		Connection conn = null;

		try {
			conn = clsconn.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();
			Statement stmt=conn.createStatement();
			String clssql= ("select a.tr_no,a.doc_no,a.refno from (select tr_no,doc_no,refno,dtype,cldocno,convert(concat(dtype,'-',doc_no),char(50)) as contr from cm_srvcontrm where status<>7 and iser=1 "
					+ ") as a where 1=1 "+sql11+" order by doc_no");

			System.out.println("===clssql=jobb===="+clssql);

			ResultSet resultSet = stmt.executeQuery(clssql);

			RESULTDATA=clscom.convertToJSON(resultSet);
			stmtenq1.close();
			conn.close();
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public JSONArray productSearch(HttpSession session,String brandid,String catid,String subcatid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = clsconn.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql1="";
			//System.out.println("brandid===="+brandid);
			if(!(brandid.equalsIgnoreCase("0") || brandid.equalsIgnoreCase(""))){
				sql1="and b.doc_no in ("+brandid+")";
			}

			String sql2="";
			//System.out.println("brandid===="+brandid);
			if(!(catid.equalsIgnoreCase("0") || catid.equalsIgnoreCase(""))){
				sql2="and c.doc_no in ("+catid+")";
			}

			String sql3="";
			//System.out.println("brandid===="+brandid);
			if(!(subcatid.equalsIgnoreCase("0") || subcatid.equalsIgnoreCase(""))){
				sql3="and s.doc_no in ("+subcatid+")";
			}


			String sql="select m.doc_no,m.part_no prodcode,m.productname prodname,b.brand from my_main m inner join my_brand b on(m.brandid=b.doc_no)"
					+ "inner join my_catm c on(m.catid=c.doc_no) inner join my_scatm s on(m.scatid=s.doc_no)  where m.status=3 "+sql1+" "+sql2+" "+sql3+"";
			//System.out.println("==productSearch==="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=clscom.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}


public JSONArray productSearch(HttpSession session) throws SQLException {


	JSONArray RESULTDATA=new JSONArray();

	Connection conn = null;

	try {
		conn = clsconn.getMyConnection();
		Statement stmt = conn.createStatement();
	 
		String sql="select m.doc_no,m.part_no prodcode,m.productname prodname,b.brand from my_main m inner join my_brand b on(m.brandid=b.doc_no) "
				+ "inner join my_catm c on(m.catid=c.doc_no)  where m.status=3 ";
		System.out.println("==productSearch==="+sql);
		ResultSet resultSet = stmt.executeQuery(sql);
		RESULTDATA=clscom.convertToJSON(resultSet);


	}catch(Exception e){
		e.printStackTrace();

	}finally{
		conn.close();
	}
	return RESULTDATA;
}

public JSONArray assignfrm(HttpSession session,String docno,String group,String id) throws SQLException{
	 
	System.out.println(docno);
			JSONArray RESULTDATA1=new JSONArray();

			Connection conn=null;
			try {
				conn = clsconn.getMyConnection();
				Statement stmt = conn.createStatement();

				String sql = "";
				String sql11 = "";
				if(!(docno.equals("0") || docno.equals("") || docno.equals("undefined"))){
					sql11=sql11+" and m.doc_no like '%"+docno+"%'";
				}
				
				if(!(group.equals("0") || group.equals("") || group.equals("undefined"))){
					sql11=sql11+" and m.grpcode like '%"+group+"%'";
				}
				System.out.println(sql11);
				sql="select grpcode,doc_no  from cm_serteamm m where status=3 "+sql11+" ";


							System.out.println("===sql===="+sql);

				ResultSet resultSet1 = stmt.executeQuery(sql);
				RESULTDATA1=clscom.convertToJSON(resultSet1);

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
