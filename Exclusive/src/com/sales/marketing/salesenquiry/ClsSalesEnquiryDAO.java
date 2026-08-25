package com.sales.marketing.salesenquiry;

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
import com.procurement.purchase.purchaserequest.ClsPurchaserequestBean;

public class ClsSalesEnquiryDAO {

	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();
	public   JSONArray searchProduct(HttpSession session) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement (); 
			  String brchid=session.getAttribute("BRANCHID").toString();
			
				int superseding=0;
				String chk1="select method  from gl_prdconfig where field_nme='superseding'";
				ResultSet rs1=stmtVeh.executeQuery(chk1); 
				if(rs1.next())
				{
					
					superseding=rs1.getInt("method");
				}
					
				if(superseding==1)
				{
				 
					String	sql=" select s.part_no,m.* from( select bd.brandname,at.mspecno as specid,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join my_unitm u on m.munit=u.doc_no  "
							  + " left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no)  "
							  + " where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brchid+",de.brhid)='"+brchid+"' ) "
							  + "  m left join  my_prdsuperseding s  on s.psrno=m.psrno  where   s.discontinued=0   order by s.psrno,s.priority  "  	;
					
						ResultSet resultSet = stmtVeh.executeQuery (sql);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
						stmtVeh.close();
						
				}
				else
				{
			String	sql=" select bd.brandname,at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join my_unitm u on m.munit=u.doc_no  "
					  + " left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no)  "
					  + " where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brchid+",de.brhid)='"+brchid+"' ";

		//	String sql="select m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join my_unitm u on m.munit=u.doc_no where m.status=3 ";
			// System.out.println("-----fleetsql---"+fleetsql);

			ResultSet resultSet = stmtVeh.executeQuery (sql);
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
	
	
	public   JSONArray searcharrayProduct() throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement (); 


			String sql="select bd.brandname,m.part_no,m.doc_no,m.productname,at.mspecno as specid from my_main m left join my_unitm u on m.munit=u.doc_no "
					+ "left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) where m.status=3";
			// System.out.println("-----fleetsql---"+fleetsql);

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
	
	public   String searcharrayProduct1() throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		ArrayList list = new ArrayList();
		String cellarray1 = "";  
		Connection conn = null;
		
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement (); 


			String sql="select m.part_no from my_main m left join my_unitm u on m.munit=u.doc_no where m.status=3";
			// System.out.println("-----fleetsql---"+fleetsql);

			ResultSet resultSet = stmtVeh.executeQuery (sql);
			while(resultSet.next()){
				//list.add(resultSet.getString("m.part_no"));
				cellarray1+=resultSet.getString("part_no")+",";
			}
			
			cellarray1=cellarray1.substring(0, cellarray1.length()-1);
		}
		catch(Exception e){
			e.printStackTrace();
			
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return cellarray1;
	}

	


	public int insert(String mob,String email,java.sql.Date date,int clientid,String clientName,String refno,
			String cmbcurr,String currate,String delterms, String payterms,String txtdesc,String mode,
			String formcode,ArrayList proGridlen,HttpSession session,HttpServletRequest request, ArrayList<String> shiparray,int shipdocno, int salid) throws SQLException{

		//System.out.println("====proGridlen===="+proGridlen);

		Connection conn=null;
		int sedocno=0;
		conn=ClsConnection.getMyConnection();


		try{

			conn.setAutoCommit(false);

			CallableStatement stmt = conn.prepareCall("{CALL saleEnqDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

//			System.out.println("CALL saleEnqDML("+date+",'"+clientName+"','"+refno+"',"+clientid+","+Integer.parseInt(cmbcurr)+","+Double.parseDouble(currate)+""
					//+ ",'"+delterms+"','"+payterms+"','"+txtdesc+"','"+mode+"','"+formcode+"','"+session.getAttribute("USERID").toString()+"','"+session.getAttribute("BRANCHID").toString()+"','"+session.getAttribute("COMPANYID").toString()+"',@sedocno)");

			stmt.registerOutParameter(18, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(17, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			stmt.setString(2,clientName);
			stmt.setString(3,refno);
			stmt.setInt(4, clientid);
			stmt.setInt(5, Integer.parseInt(cmbcurr));
			stmt.setDouble(6, Double.parseDouble(currate));
			stmt.setString(7, delterms);
			stmt.setString(8, payterms);
			stmt.setString(9, txtdesc);
			stmt.setString(10, mode);
			stmt.setString(11, formcode);
			stmt.setString(12, session.getAttribute("USERID").toString());
			stmt.setString(13, session.getAttribute("BRANCHID").toString());
			stmt.setString(14, session.getAttribute("COMPANYID").toString());
			stmt.setString(15, mob);
			stmt.setString(16, email);
			int val = stmt.executeUpdate();
			sedocno=stmt.getInt("sedocno");
			int vocno=stmt.getInt("vdocNo");	
			request.setAttribute("vdocNo", vocno);

	 
			if (sedocno > 0) {
				
				
				String sqls="update my_cusenqm set sal_id="+salid+" where doc_no='"+sedocno+"' ";
				
				System.out.println("----sqls-"+sqls);
				stmt.executeUpdate(sqls);
				
				
				
				
				
				int prodet=0;
				
				//System.out.println("=====cfghuiuyghui========"+proGridlen.size());
				
				for(int i=0;i< proGridlen.size();i++){
					String[] prod=((String) proGridlen.get(i)).split("::");
					
					//System.out.println("=======prod[2]=========="+prod[2]);
					
					if(!((prod[2].trim().equalsIgnoreCase("0"))||(prod[2].trim().equalsIgnoreCase("undefined")))){
					   
						
							String prsros=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
						    String unitids=""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].trim().equalsIgnoreCase("")|| prod[3].isEmpty()?0:prod[3].trim())+"";
						    String specno=""+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].trim().equalsIgnoreCase("")|| prod[4].isEmpty()?0:prod[4].trim())+"";
						         
						     double fr=1;
						     String slss=" select fr from my_unit where psrno="+prsros+" and unit='"+unitids+"' ";
						     
						    // System.out.println("====slss==="+slss);
						     ResultSet rv1=stmt.executeQuery(slss);
						     if(rv1.next())
						     {
						    	 fr=rv1.getDouble("fr"); 
						     }
		    	 
						
						

						String sql="insert into my_cusenqd (sr_no,rdocno, psrno, prdId, qty, UNITID,brhid,fr,specno)VALUES"
								+ " ("+(i+1)+" ,'"+sedocno+"',"
								+ "'"+(prod[2].equalsIgnoreCase("undefined") || prod[2].equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
								+ "'"+(prod[2].equalsIgnoreCase("undefined") || prod[2].equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
								+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
								+ "'"+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"',"
								+ "'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"',"+fr+","+specno+")";



						//System.out.println("branchper--->>>>Sql"+sql);
						prodet = stmt.executeUpdate (sql);
					}

				}
				
				
				
				
				for(int i=0;i< shiparray.size();i++){


					String[] shiparrays=((String) shiparray.get(i)).split("::");

			 

					 if(!(shiparrays[1].trim().equalsIgnoreCase("undefined")|| shiparrays[1].trim().equalsIgnoreCase("NaN")||shiparrays[1].trim().equalsIgnoreCase("")|| shiparrays[1].isEmpty()))
				     {


						String shipsql="insert into my_deldetaild (rdocno,shipdetid,refdocno,desc1,refno,date,brhid,status,dtype)VALUES"
								+ " ('"+sedocno+"','"+shipdocno+"',"
								+ "'"+(shiparrays[0].trim().equalsIgnoreCase("undefined") || shiparrays[0].trim().equalsIgnoreCase("") || shiparrays[0].trim().equalsIgnoreCase("NaN")|| shiparrays[0].isEmpty()?0:shiparrays[0].trim())+"',"
								+ "'"+(shiparrays[1].trim().equalsIgnoreCase("undefined") || shiparrays[1].trim().equalsIgnoreCase("") || shiparrays[1].trim().equalsIgnoreCase("NaN")|| shiparrays[1].isEmpty()?0:shiparrays[1].trim())+"',"
								+ "'"+(shiparrays[2].trim().equalsIgnoreCase("undefined") || shiparrays[2].trim().equalsIgnoreCase("") || shiparrays[2].trim().equalsIgnoreCase("NaN")|| shiparrays[2].isEmpty()?0:shiparrays[2].trim())+"',"
								+ "'"+(shiparrays[3].trim().equalsIgnoreCase("undefined") || shiparrays[3].trim().equalsIgnoreCase("") || shiparrays[3].trim().equalsIgnoreCase("NaN")|| shiparrays[3].isEmpty()?0:ClsCommon.changetstmptoSqlDate(shiparrays[3].trim()))+"',"
							   + "'"+session.getAttribute("BRANCHID").toString()+"',"
								+ "'3',"
								+ "'"+formcode+"')";


					//	System.out.println("termsdet--->>>>Sql"+termsql);
					int	retdoc = stmt.executeUpdate(shipsql);
						
						 if(retdoc<=0)
							{
								conn.close();
								return 0;
								
							}

					}
				}
				
				
				String updatesql="update my_cusenqm set shipdetid='"+shipdocno+"' where doc_no='"+sedocno+"' ";
				
				stmt.executeUpdate (updatesql);
				
			
			}



			conn.commit();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return sedocno;
	}


	public int update(int sedocno,int vocno,String mob,String email,java.sql.Date date,int clientid,String clientName,String refno,String cmbcurr,
			String currate,String delterms, String payterms,String txtdesc,String mode,String formcode,ArrayList proGridlen,HttpSession session, 
			HttpServletRequest request,String updatadata,ArrayList<String> shiparray,int shipdocno,int salid) throws SQLException{

//		System.out.println("====sedocno===="+sedocno+"==vocno==="+vocno);

		Connection conn=null;

		conn=ClsConnection.getMyConnection();


		try{

			conn.setAutoCommit(false);

			CallableStatement stmt = conn.prepareCall("{CALL saleEnqDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			System.out.println("CALL saleEnqDML("+date+",'"+clientName+"','"+refno+"',"+clientid+","+Integer.parseInt(cmbcurr)+","+Double.parseDouble(currate)+""
				+ ",'"+delterms+"','"+payterms+"','"+txtdesc+"','"+mode+"','"+formcode+"','"+session.getAttribute("USERID").toString()+"','"+session.getAttribute("BRANCHID").toString()+"','"+session.getAttribute("COMPANYID").toString()+"',@sedocno)");

			//stmt.registerOutParameter(17, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			stmt.setString(2,clientName);
			stmt.setString(3,refno);
			stmt.setInt(4, clientid);
			stmt.setInt(5, Integer.parseInt(cmbcurr));
			stmt.setDouble(6, Double.parseDouble(currate));
			stmt.setString(7, delterms);
			stmt.setString(8, payterms);
			stmt.setString(9, txtdesc);
			stmt.setString(10, mode);
			stmt.setString(11, formcode);
			stmt.setString(12, session.getAttribute("USERID").toString());
			stmt.setString(13, session.getAttribute("BRANCHID").toString());
			stmt.setString(14, session.getAttribute("COMPANYID").toString());
			stmt.setString(15, mob);
			stmt.setString(16, email);
			stmt.setInt(17, sedocno);
			stmt.setInt(18, vocno);
			int val = stmt.executeUpdate();
			sedocno=stmt.getInt("sedocno");
			 vocno=stmt.getInt("vdocNo");	
			request.setAttribute("vdocNo", vocno);

			if (sedocno > 0) {
				
			//	System.out.println("===updatadata===="+updatadata);
				
				
	String sqls="update my_cusenqm set sal_id="+salid+" where doc_no='"+sedocno+"' ";
				
			//	System.out.println("----sqls-"+sqls);
				stmt.executeUpdate(sqls);
				
				if(updatadata.equalsIgnoreCase("Editvalue"))
				{
					
					
					
				
						int prodet=0;
						for(int i=0;i< proGridlen.size();i++){
							String[] prod=((String) proGridlen.get(i)).split("::");
							if(!((prod[2].trim().equalsIgnoreCase("0"))||(prod[2].trim().equalsIgnoreCase("undefined")))){
		
								
								if(i==0)
								{
									 String dql31="delete from my_cusenqd where rdocno='"+sedocno+"'";
									 
									// System.out.println("------dql31---"+dql31);
									 
						    	 	  stmt.executeUpdate(dql31);	
						    	 	  
						    	 	 String deltermssqls="delete from my_deldetaild where rdocno='"+sedocno+"' and  dtype='"+formcode+"'  ";
						    	 	stmt.executeUpdate(deltermssqls);
								}
								
								
								
								String prsros=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
							    String unitids=""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].trim().equalsIgnoreCase("")|| prod[3].isEmpty()?0:prod[3].trim())+"";
							    String specno=""+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].trim().equalsIgnoreCase("")|| prod[4].isEmpty()?0:prod[4].trim())+"";
								    
							     double fr=1;
							     String slss=" select fr from my_unit where psrno="+prsros+" and unit='"+unitids+"' ";
							     
							//     System.out.println("====slss==="+slss);
							     ResultSet rv1=stmt.executeQuery(slss);
							     if(rv1.next())
							     {
							    	 fr=rv1.getDouble("fr"); 
							     }
			    	 
							
								
		
								String sql="insert into my_cusenqd (sr_no,rdocno, psrno, prdId, qty,UNITID,brhid,fr,specno)VALUES"
										+ " ("+(i+1)+",'"+sedocno+"',"
										+ "'"+(prod[2].equalsIgnoreCase("undefined") || prod[2].equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
										+ "'"+(prod[2].equalsIgnoreCase("undefined") || prod[2].equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
										+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
										+ "'"+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"',"
										+ "'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"',"+fr+","+specno+")";
		
		
		
						//		System.out.println("branchper--->>>>Sql"+sql);
								prodet = stmt.executeUpdate (sql);
							}
		
						}
						
						
						
						
						
						
						for(int i=0;i< shiparray.size();i++){


							String[] shiparrays=((String) shiparray.get(i)).split("::");

					 

							 if(!(shiparrays[1].trim().equalsIgnoreCase("undefined")|| shiparrays[1].trim().equalsIgnoreCase("NaN")||shiparrays[1].trim().equalsIgnoreCase("")|| shiparrays[1].isEmpty()))
						     {


								String shipsql="insert into my_deldetaild (rdocno,shipdetid,refdocno,desc1,refno,date,brhid,status,dtype)VALUES"
										+ " ('"+sedocno+"','"+shipdocno+"',"
										+ "'"+(shiparrays[0].trim().equalsIgnoreCase("undefined") || shiparrays[0].trim().equalsIgnoreCase("") || shiparrays[0].trim().equalsIgnoreCase("NaN")|| shiparrays[0].isEmpty()?0:shiparrays[0].trim())+"',"
										+ "'"+(shiparrays[1].trim().equalsIgnoreCase("undefined") || shiparrays[1].trim().equalsIgnoreCase("") || shiparrays[1].trim().equalsIgnoreCase("NaN")|| shiparrays[1].isEmpty()?0:shiparrays[1].trim())+"',"
										+ "'"+(shiparrays[2].trim().equalsIgnoreCase("undefined") || shiparrays[2].trim().equalsIgnoreCase("") || shiparrays[2].trim().equalsIgnoreCase("NaN")|| shiparrays[2].isEmpty()?0:shiparrays[2].trim())+"',"
										+ "'"+(shiparrays[3].trim().equalsIgnoreCase("undefined") || shiparrays[3].trim().equalsIgnoreCase("") || shiparrays[3].trim().equalsIgnoreCase("NaN")|| shiparrays[3].isEmpty()?0:ClsCommon.changetstmptoSqlDate(shiparrays[3].trim()))+"',"
									   + "'"+session.getAttribute("BRANCHID").toString()+"',"
										+ "'3',"
										+ "'"+formcode+"')";


							//	System.out.println("termsdet--->>>>Sql"+termsql);
							int	retdoc = stmt.executeUpdate(shipsql);
								
								 if(retdoc<=0)
									{
										conn.close();
										return 0;
										
									}

							}
						}
						
						
						String updatesql="update my_cusenqm set shipdetid='"+shipdocno+"' where doc_no='"+sedocno+"' ";
						
						stmt.executeUpdate (updatesql);
						
						
						
						
						
						
			}


			}
				if(sedocno>0)
				{
					conn.commit();		
					return sedocno;
				}
		}
		catch(Exception e){
			e.printStackTrace();
			
		}
		finally{
			conn.close();
		}


		return sedocno;
	}


	public int delete(int sedocno,int vocno,String mob,String email,java.sql.Date date,int clientid,String clientName,String refno,String cmbcurr,String currate,String delterms, String payterms,String txtdesc,String mode,String formcode,HttpSession session,HttpServletRequest request) throws SQLException{

		//System.out.println("====proGridlen===="+proGridlen);

		Connection conn=null;

		conn=ClsConnection.getMyConnection();


		try{

			conn.setAutoCommit(false);

			CallableStatement stmt = conn.prepareCall("{CALL saleEnqDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

//			System.out.println("CALL saleEnqDML("+date+",'"+clientName+"','"+refno+"',"+clientid+","+Integer.parseInt(cmbcurr)+","+Double.parseDouble(currate)+""
					//+ ",'"+delterms+"','"+payterms+"','"+txtdesc+"','"+mode+"','"+formcode+"','"+session.getAttribute("USERID").toString()+"','"+session.getAttribute("BRANCHID").toString()+"','"+session.getAttribute("COMPANYID").toString()+"',@sedocno)");

			//stmt.registerOutParameter(17, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			stmt.setString(2,clientName);
			stmt.setString(3,refno);
			stmt.setInt(4, clientid);
			stmt.setInt(5, Integer.parseInt(cmbcurr));
			stmt.setDouble(6, Double.parseDouble(currate));
			stmt.setString(7, delterms);
			stmt.setString(8, payterms);
			stmt.setString(9, txtdesc);
			stmt.setString(10, mode);
			stmt.setString(11, formcode);
			stmt.setString(12, session.getAttribute("USERID").toString());
			stmt.setString(13, session.getAttribute("BRANCHID").toString());
			stmt.setString(14, session.getAttribute("COMPANYID").toString());
			stmt.setString(15, mob);
			stmt.setString(16, email);
			stmt.setInt(17, sedocno);
			stmt.setInt(18, vocno);
			int val = stmt.executeUpdate();
			sedocno=stmt.getInt("sedocno");


			if (sedocno > 0) {
				conn.commit();
			}
		}




		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return sedocno;
	}





	public  JSONArray searchMaster(HttpSession session,String msdocno,String clnames,String mobno,String enqdate,String enqtype,String Cl_clientsale1) throws SQLException {


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



		java.sql.Date sqlStartDate=null;


		//enqdate.trim();
		if(!(enqdate.equalsIgnoreCase("undefined"))&&!(enqdate.equalsIgnoreCase(""))&&!(enqdate.equalsIgnoreCase("0")))
		{
			sqlStartDate = ClsCommon.changeStringtoSqlDate(enqdate);
		}






		String sqltest="";
		if(!(msdocno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.voc_no like '%"+msdocno+"%'";
		}


		if(!(enqtype.equalsIgnoreCase(""))){
			String enqtypeval="";
			if(enqtype.equalsIgnoreCase("general"))
			{
				enqtypeval="1";
			}
			else if(enqtype.equalsIgnoreCase("client"))
			{
				enqtypeval="0";
			}
			else
			{
			}

			sqltest=sqltest+" and cltype like '%"+enqtypeval+"%'";
		}

		if(!(clnames.equalsIgnoreCase(""))){

			if(enqtype.equalsIgnoreCase("general"))
			{
				sqltest=sqltest+" and coalesce(clientname,refname) like '%"+clnames+"%'";
			}
			else if(enqtype.equalsIgnoreCase("client"))
			{
				sqltest=sqltest+" and coalesce(refname,clientname) like '%"+clnames+"%'";
			}
		}

		if(!(mobno.equalsIgnoreCase(""))){

			if(enqtype.equalsIgnoreCase("general"))
			{
				sqltest=sqltest+" and coalesce(m.mob,ac.com_mob) like '%"+mobno+"%'";
			}
			else if(enqtype.equalsIgnoreCase("client"))
			{
				sqltest=sqltest+" and coalesce(ac.com_mob,m.mob) like '%"+mobno+"%'";
			}

		}

		if(!(Cl_clientsale1.equalsIgnoreCase(""))){

			 
				sqltest=sqltest+" and sa.sal_name like '%"+Cl_clientsale1+"%'";
			 
			 

		}




		if(!(sqlStartDate==null)){
			sqltest=sqltest+" and date='"+sqlStartDate+"'";
		} 



		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();  

			String clssql= ("select  m.sal_id,sa.sal_name,m.shipdetid,ac1.refname clname, sh.claddress, sh.contactperson, sh.tel telno, sh.mob mobno , sh.email emailid, sh.fax faxno,"
					+ "  m.voc_no,m.DOC_NO, m.DATE, "
					+ "  coalesce(if(m.clientid<=0,m.clientname,ac.refname),0) name,coalesce(if(m.clientid<=0,'',ac.address),0)"
					+ " cladd, coalesce(if(m.clientid<=0,ac.doc_no,m.clientid),0) cldocno, m.mob, m.email, cltype, payterms, delterms,"
					+ " description from my_cusenqm m left join my_acbook ac on(m.clientid=ac.doc_no and ac.dtype='CRM')"
					+ "  left join my_shipdetails sh on sh.doc_no=m.shipdetid  and sh.type>0 "
					+ " left join my_acbook ac1 on(sh.cldocno=ac1.doc_no and ac1.dtype='CRM' and sh.type>0)"
					+ " left join my_salm sa on sa.doc_no=m.sal_id  "
					+ "  where m.status<>7 and m.brhid="+brid+" " +sqltest);
			//System.out.println("========"+clssql);
			ResultSet resultSet = stmtenq1.executeQuery(clssql);

			RESULTDATA=ClsCommon.convertToJSON(resultSet);
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



	public JSONArray searchClient(HttpSession session,String clname,String mob,String Cl_clientsale) throws SQLException {

//		System.out.println("==searchClient====");

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


		String brid=session.getAttribute("BRANCHID").toString();






		//System.out.println("name"+clname);

		String sqltest="";

		if(!(clname.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.refname like '%"+clname+"%'";
		}
		if(!(mob.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.per_mob like '%"+mob+"%'";
		}
		
		if(!(Cl_clientsale.equalsIgnoreCase(""))){
			sqltest=sqltest+" and sa.sal_name like '%"+Cl_clientsale+"%'";
		}
		


		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh1 = conn.createStatement (); 

			String clsql= ("select sa.doc_no saldocno,sa.sal_name,ac.per_tel pertel,ac.cldocno,ac.refname,trim(ac.address) address,ac.per_mob,trim(ac.mail1) mail1"
					+ "  from my_acbook ac  left join my_salm sa on sa.doc_no=ac.sal_id where  ac.dtype='CRM'  " +sqltest);
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
	
	public   JSONArray searchunit(String mode,String psrno) throws SQLException {
 
		JSONArray RESULTDATA=new JSONArray();
	    
	    
	    Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
	        	String pySql=("   select u.unit doc_no,u.fr,m.unit from my_unit u left join my_unitm m on m.doc_no=u.unit where psrno='"+psrno+"';   ");
 
	        	System.out.println("=====pySql========"+pySql);
	        	
				ResultSet resultSet = stmtVeh1.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
				stmtVeh1.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}	
	
	public JSONArray prdGridLoad(HttpSession session,String docno) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select bd.brandname,m.doc_no psrno,m.doc_no as prodoc,qty,size,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.specno specid from  my_cusenqd d  left join my_main m on(d.psrno=m.doc_no)  "
					+ " left join  my_brand bd on m.brandid=bd.doc_no left join  my_unitm u on(d.unitid=u.doc_no) where d.rdocno='"+docno+"'";
			System.out.println("===prdbranchLoad====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}


	 public     ClsSalesEnquiryBean getPrint(int docno, HttpServletRequest request) throws SQLException {
		 ClsSalesEnquiryBean bean = new ClsSalesEnquiryBean();
		  Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtprint = conn.createStatement ();
	        	
				String resql=("select m.date,m.mob,m.email,m.doc_no,m.voc_no,if(m.cltype=0,a.refname,m.clientname) client,if(m.cltype=0,'Client','General') type,payterms, delterms, description "
						+ "  from my_cusenqm m left join my_acbook a on a.cldocno=m.clientid and m.dtype='CEQ' where m.doc_no='"+docno+"'");
				
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
		 
			       while(pintrs.next()){
			    	 
			    	//   getLblclient getLblclientaddress getLblmob getLblemail setDocvals getLbldate getLbltypep
			    	   
			    	    bean.setDocvals(pintrs.getString("voc_no"));
			    	    bean.setLbldate(pintrs.getString("date"));
			    	    bean.setLblclient(pintrs.getString("client"));
			    	    bean.setLblmob(pintrs.getString("mob"));
			    	    bean.setLblemail(pintrs.getString("email"));
			    	    
			    	    
			    	    bean.setLbldelterms(pintrs.getString("delterms"));
			    	    bean.setLblpaytrems(pintrs.getString("payterms"));
			    	    bean.setLbldesc1(pintrs.getString("description"));
			    	    
			    	    bean.setLbltypep(pintrs.getString("type")); 
			    	  
			    	  
			       }
				

				stmtprint.close();
				
				
				
				 Statement stmt10 = conn.createStatement ();
				    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from my_cusenqm r  "
				    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
				    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";


			         ResultSet resultsetcompany = stmt10.executeQuery(companysql); 
				       
				       while(resultsetcompany.next()){
				    	   
				    	   bean.setLblbranch(resultsetcompany.getString("branchname"));
				    	   bean.setLblcompname(resultsetcompany.getString("company"));
				    	  
				    	   bean.setLblcompaddress(resultsetcompany.getString("address"));
				    	 
				    	   bean.setLblcomptel(resultsetcompany.getString("tel"));
				    	  
				    	   bean.setLblcompfax(resultsetcompany.getString("fax"));
				    	   bean.setLbllocation(resultsetcompany.getString("location"));
				    	  
				    	 
				    	   
				       } 
				       stmt10.close();
				       
				       ArrayList<String> arr =new ArrayList<String>();
				   	Statement stmtgrid = conn.createStatement ();       
				     String temp="";  
				       String	strSqldetail="Select d.specno specid ,m.part_no productid,m.productname, u.unit,round(d.qty,2) qty  from my_cusenqd d"
	        			+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no    where rdocno='"+docno+"'";
					
			
					ResultSet rsdetail=stmtgrid.executeQuery(strSqldetail);
					
					int rowcount=1;
			
					while(rsdetail.next()){

							 
							 
							temp=rowcount+"::"+rsdetail.getString("productid")+"::"+rsdetail.getString("productname")+"::"+rsdetail.getString("unit")+"::"+rsdetail.getString("qty") ;

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
	 
		public   JSONArray deldetailsSearch() throws SQLException {

			JSONArray RESULTDATA=new JSONArray();

			Connection conn = null;

			try {
				conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement (); 


				String sql="select doc_no,desc1 from  my_deldetailm where status=3; ";
				// System.out.println("-----sql---"+sql);

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
		
		public   JSONArray reloadshipSearch(HttpSession session,String masterdocno,String formcode) throws SQLException {

			JSONArray RESULTDATA=new JSONArray();

			Connection conn = null;

			try {
				conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement (); 


				String sql="select   refdocno doc_nos, desc1, refno, date from  my_deldetaild where status=3 and rdocno='"+masterdocno+"' and dtype='"+formcode+"' ";
			  System.out.println("-----sql---"+sql);

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
		

		public JSONArray shipsearchFrom(String clname,String mob) throws SQLException {


			JSONArray RESULTDATA=new JSONArray();  

			Connection conn = null;

			try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement();     
				String sqltest="";

				if(!(clname.equalsIgnoreCase(""))){
					sqltest=sqltest+" and if(m.type=0,m.clname,ac.refname) like '%"+clname+"%'";
				}
				if(!(mob.equalsIgnoreCase(""))){
					sqltest=sqltest+" and m.mob like '%"+mob+"%'";
				}

		 
				String sql=" select m.doc_no,m.type,m.cldocno,if(m.type=0,m.clname,ac.refname) clname, m.claddress,m.contactperson, m.tel, "
						+ " m.mob, m.email, m.fax from my_shipdetails m  left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM'  "
						+ " where  m.status=3 and m.type>0  " +sqltest;
	 
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

