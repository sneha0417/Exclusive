package com.salesandmarketing.Sales.joborder;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
 


import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsJobOrderDAO {

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	
	public JSONArray prdGridReload(HttpSession session,String docno) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {

			if(((docno.equalsIgnoreCase(""))||(docno.equalsIgnoreCase("undefined")))){

				docno="0";
			}

		 
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();  


			String	sql=" select fixing,brandname,clstatus,1 method, stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,qty+balqty totqty, qty,qty as oldqty, "
						+ "  outqty,case when (totqty-outqty)=0 then 0 else (qty+balqty) end as balqty,0 size,part_no, "
				  + "  productid as proid,productid,productname as proname,productname,unit,unitdocno, totwtkg, "
				  + "  kgprice, unitprice, total, discper,  dis, netotal from(select  fixing,brandname,clstatus,stkid,specid,psrno as doc_no, "
				 + "   rdocno,psrno,qtys as totqty, qty,qtys,outqty,(qtys-outqty) as balqty,0 size,part_no,productid, "
				 + "   productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper,  dis, netotal from "
				 + "   ( select if(d.fixing=1,'true','false') fixing,bd.brandname,d.clstatus, d.stockid as stkid,d.specno as specid,d.rdocno,m.doc_no psrno,aa.qty as qty, ii.op_qty "
				 + "   as qtys,ii.outqty,m.part_no,m.part_no productid,m.productname, "
				+ "    u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice,aa.total total,d.disper "
				 + "   discper, aa.discount dis,aa.nettotal netotal from my_joborderm ma left join my_joborderd d on(ma.doc_no=d.rdocno) "
				 + "   left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u on(d.unitid=u.doc_no) "
				  + "  left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno ) left join  my_brand bd on m.brandid=bd.doc_no "
				 + "  left join my_prddin i on (i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno "
				  + "   and ma.brhid=i.brhid) "
				  + "  left join (select sum(qty) qty,sum(total) total,sum(discount) discount,sum(nettotal) nettotal,psrno,rdocno,specno,prdid from my_joborderd where  rdocno in("+docno+") "
				   + " group by  psrno) aa on aa.psrno=i.psrno "
				   + "  left join( select date,sum(op_qty) op_qty,stockid,sum(out_qty+del_qty+rsv_qty) outqty,prdid,psrno,specno,brhid "
				  + "  from my_prddin where 1=1 group by psrno) ii on "
				 + "   (ii.psrno=i.psrno and ii.prdid=i.prdid and ii.specno=i.specno and ma.brhid=ii.brhid) "
				 + "    where m.status=3  and d.rdocno in("+docno+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by i.prdid  order by i.date,i.prdid ) as a ) as b ";
 
				 // System.out.println("======8888888888888888888888888888888==="+sql);

			
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	
	public   JSONArray searchbranch() throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();  

			 

			String sql="select brand,brandname,doc_no from my_sbrand  where status=3";
		 

			ResultSet resultSet = stmt.executeQuery (sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}
	public JSONArray subModelSearch(HttpSession session,String brandid,String modelid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			
			String sql="select convert(doc_no,char(50)) as doc_no,submodel,model from "
					+ "(   select m.doc_no,submodel,model from my_ssubmodel m left join my_smodel mo "
					+ "on(m.modelid=mo.doc_no) where mo.status=3 and m.status=3 and m.modelid="+modelid+""
					+ " and m.brandid="+brandid+" ) as a";
			System.out.println("===subModelSearch===="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}


	public  JSONArray searchMaster(HttpSession session,String docno,String clnames,String clmobs,String Cl_salper) throws SQLException {


	//	System.out.println("==searchMaster===");

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



		String sqltest="";
		if(!(docno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.voc_no like '%"+docno+"%'";
		}

		if(!(clnames.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.refname like '%"+clnames+"%'";
		}
		if(!(clmobs.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.per_mob like '%"+clmobs+"%'";
		}

		if(!(Cl_salper.equalsIgnoreCase(""))){
			sqltest=sqltest+" and sa.sal_name like '%"+Cl_salper+"%'";
		}

		


		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtenq1 = conn.createStatement (); 
		//	doc_no, cldocno, reg_no, yom, brandid, modelid, submodelid, bsizeid, esizeid, csizeid, dtype, sr_no

			String clssql= ("select sa.doc_no saldocno,sa.sal_name,ac.per_mob,m.type,m.doc_no,m.voc_no,br.brandname,mo.modelname,sm.submodel,ach.submodelid,y.yom,ac.refname,trim(ac.address) address,"
					+ " m.cldocno,ach.reg_no regno,ach.brandid brdid,ach.modelid,ach.yom yomid,s1.spec bsize,ach.bsizeid,s2.spec esize,ach.esizeid,s3.spec csize,ach.csizeid from"
					+ " my_joborderm m left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM'"
					+ "  left join my_acvehicle ach on ach.doc_no=m.clrefno  "
					+ " left join my_sbrand br on br.doc_no=ach.brandid left join my_smodel mo on mo.doc_no=ach.modelid "
					+ " left join my_ssubmodel sm on(sm.doc_No=ach.submodelid and sm.modelid=ach.modelid) left join my_suitspec1 s1 on(s1.doc_no=ach.bsizeid)  "
					+ " left join my_suitspec2 s2 on(s2.doc_no=ach.esizeid) left join my_suitspec3 s3 on(s3.doc_no=ach.csizeid)  "
					+ " left join my_syom y on y.doc_no=ach.yom  left join my_salm sa on sa.doc_no=ac.sal_id and ac.dtype='CRM' where  m.status=3 "+sqltest+"");
			//System.out.println("====searchmaster===="+clssql);
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
	public JSONArray vehLoad(HttpSession session,String docno) throws SQLException {


			JSONArray RESULTDATA=new JSONArray();

			Connection conn = null;

			try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement();

	 
				if(docno.equalsIgnoreCase(""))
				{
					docno="0";
				}
				
			 
		String sql=" select 'UPD' forms,s.doc_no, s.cldocno, s.reg_no regno, s.yom yomid,y.yom,b.brandname brand ,s.brandid,m.modelname model, s.modelid,sm.submodel, "
						+ " s.submodelid, s1.spec bsize,s.bsizeid,s2.spec esize, s.esizeid,s3.spec csize, s.csizeid,  s.sr_no "
						+ " from  my_acvehicle s left join my_sbrand b on(b.doc_no=s.brandid) left join my_smodel m on(m.doc_no=s.modelid) "
						+ " left join my_ssubmodel sm on(sm.doc_No=s.submodelid and sm.modelid=s.modelid) left join my_suitspec1 s1 on(s1.doc_no=s.bsizeid)  "
						+ " left join my_suitspec2 s2 on(s2.doc_no=s.esizeid) left join my_suitspec3 s3 on(s3.doc_no=s.csizeid)  "
						+ " left join my_syom y on(y.doc_no=s.yom) where s.cldocno="+docno+" ";
		 
			 	System.out.println("===prdsuitLoad====="+sql);
				ResultSet resultSet = stmt.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);


			}catch(Exception e){
				e.printStackTrace();

			}finally{
				conn.close();
			}
			return RESULTDATA;
		}
		

	
	public   JSONArray searchmodel(String  brandid) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();

			 

			String sql="select modelname,doc_no from my_smodel where status=3 and brandid='"+brandid+"' ";
			 
			ResultSet resultSet = stmt.executeQuery (sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}
	
	
	public   JSONArray searchyom() throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 

			 

			String sql="select doc_no,yom from my_syom where status=3 ;";
			 

			ResultSet resultSet = stmt.executeQuery (sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}
	
	
	
	public   JSONArray searchProduct(HttpSession session ) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 
			 
 
                	
			String	sql="select   bd.brandname,at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) qty,"
    						+ " sum(i.out_qty) outqty,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty,sum(i.op_qty) as totqty,i.stockid as stkid,"
    						+ " '' unitprice  from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no"
    						+ "   inner join my_prddin i "
    						+ "on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+session.getAttribute("BRANCHID").toString()+"'  )  " 
    						+ "where m.status=3 and i.brhid='"+session.getAttribute("BRANCHID").toString()+"'  "
    						+ "group by i.prdid having sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by i.prdid,i.date "; 
			
			ResultSet resultSet = stmt.executeQuery (sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();   	
               
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}



	public int insert(int cldocno, String mode, String formdetailcode,
			ArrayList<String> prodarray, HttpSession session,
			HttpServletRequest request, String regno, int brandid, int modelid,
			int yomid,int typesave,int submodelid,int esizeid,int bsizeid,int csizeid,int refdocno) throws SQLException {

			Connection conn=null;
			int docno=0;
			int itrno=0;
			conn=ClsConnection.getMyConnection();
			Statement  stmt=conn.createStatement();
			Statement  stmt1=conn.createStatement();
			conn.setAutoCommit(false);
		try{
			
			
			String sqlss="select coalesce((max(trno)+1),1)   itrno from  my_trno";

			ResultSet rss1=stmt1.executeQuery(sqlss);
			
			if(rss1.first())
			{
				itrno=rss1.getInt("itrno");
				
				
			}
			
			
			String sqlss1="insert into my_trno(edate,trtype,brhId,USERNO,trno) values(now(),3,'"+session.getAttribute("BRANCHID").toString()+"','"+session.getAttribute("USERID").toString()+"','"+itrno+"')";
			int aa1=stmt.executeUpdate(sqlss1);
			
			if(aa1<=0)
			{
				
				 conn.close();
				 return 0;
			}
		
		String sql="select coalesce((max(doc_no)+1),1)  docno from my_joborderm ";
		
	//	System.out.println("=======dtyuiopsdfioasdfu===sql========="+sql);
		
			ResultSet rss=stmt.executeQuery(sql);
			
			if(rss.first())
			{
				docno=rss.getInt("docno");
				
				
			}
			
			int voc_no=0;
			String sqlsss="select coalesce((max(voc_no)+1),1)  vocno from my_joborderm where brhid='"+session.getAttribute("BRANCHID").toString()+"'  ";
			
			//	System.out.println("=======dtyuiopsdfioasdfu===sql========="+sql);
				
					ResultSet rsss=stmt.executeQuery(sqlsss);
					
					if(rsss.first())
					{
						voc_no=rsss.getInt("vocno");
						
						
					}
					request.setAttribute("vocno", voc_no);
			if(docno<=0)
			{
				
				 conn.close();
				 return 0;
			}
			
			
			
			 
			
			
			

			String sqls="insert into my_joborderm(date,tr_no,voc_no,doc_no,cldocno,type,userid,status,brhid)values(now(),'"+itrno+"','"+voc_no+"','"+docno+"','"+cldocno+"','"+typesave+"','"+session.getAttribute("USERID").toString()+"','3','"+session.getAttribute("BRANCHID").toString()+"') ";
			
/*			
			
			String sqls="insert into my_joborderm(date,tr_no,voc_no,doc_no,cldocno, "
					+ " regno,"
					+ " brdid, modelid, yom,userid,status,brhid)values(now(),'"+itrno+"','"+voc_no+"','"+docno+"','"+cldocno+"','"+regno+"','"+brandid+"','"+modelid+"','"+yomid+"','"+session.getAttribute("USERID").toString()+"','3','"+session.getAttribute("BRANCHID").toString()+"') ";
			System.out.println("=======fghgfghgghghhaskdkajsd asdbasn d===sqls========="+sqls);*/
			
		//	System.out.println("=======fghgfghgghghhaskdkajsd asdbasn d===sqls========="+sqls);
			int aa=stmt.executeUpdate(sqls);
			
			if(aa<=0)
			{
				
				 conn.close();
				 return 0;
			}
			
		//	System.out.println("=====typesave===="+typesave);
			if(typesave==1) // new 
			{
				int sr_no=1;
		     String sqlssq="select count(*)+1 nos from my_acvehicle where cldocno='"+cldocno+"' ";
		     ResultSet rssss=stmt.executeQuery(sqlssq);
		     
		     if(rssss.first())
		     {
		    	 sr_no=rssss.getInt("nos");
		     }
				
				
		     String sqli="insert into my_acvehicle(cldocno, reg_no,  brandid, modelid,yom, submodelid, bsizeid, esizeid, csizeid, sr_no)  "
		     		+ " values('"+cldocno+"','"+regno+"','"+brandid+"','"+modelid+"','"+yomid+"','"+submodelid+"','"+bsizeid+"','"+esizeid+"','"+csizeid+"','"+sr_no+"') ";
		
			//	System.out.println("=====sqli===="+sqli);
		     int bb=stmt.executeUpdate(sqli);
						
						if(bb<=0)
						{
							
							 conn.close();
							 return 0;
						}
						
					     String sqlssq1="select  max(doc_no) doc_no from my_acvehicle where cldocno='"+cldocno+"' ";
					     
					//     System.out.println("=====sqlssq1===="+sqlssq1);
					 
					     ResultSet rssss1=stmt.executeQuery(sqlssq1);
					     
					     if(rssss1.first())
					     {
					    	 refdocno=rssss1.getInt("doc_no");
					     }
									
				
					     
					   //  System.out.println("=====refdocno= in ==="+refdocno);
			}
			 
				
				String upsdatesql="update   my_joborderm  set clrefno='"+refdocno+"' where doc_no="+docno+" ";
				
				System.out.println("=====upsdatesql===="+upsdatesql);
				
				 stmt.executeUpdate(upsdatesql);
		 
				 
				
				
				//System.out.println("=====refdocno===="+refdocno);
				request.setAttribute("refdocno", refdocno);
				
				
			for(int i=0;i< prodarray.size();i++){

				String[] prod=((String) prodarray.get(i)).split("::");
				System.out.println("prod[0]===="+prod[0]);
				if(!((prod[0].trim().equalsIgnoreCase("0"))||(prod[0].trim().equalsIgnoreCase("undefined")))){

					int temp=0;
					int fixing=0;

       String vals=""+(prod[16].trim().equalsIgnoreCase("undefined") || prod[16].trim().equalsIgnoreCase("") || prod[16].trim().equalsIgnoreCase("NaN")|| prod[16].isEmpty()?0:prod[16].trim())+"";
       System.out.println("---vals-asdsadasdasdasdassdas-"+vals);
       if(vals.equalsIgnoreCase("true"))
       {
    	   fixing=1;   
       }
       
/*       String stkid=""+(prod[12].equalsIgnoreCase("undefined") || prod[12].trim().equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"";
       String  rqty=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
            
			String sql3="insert into my_joborderd(tr_No,sr_no,rdocno,stockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal,fixing)VALUES"
					+ " ("+docno+","+(i+1)+",'"+docno+"',"
					+ "'"+stkid+"',"
					+ "'"+(prod[10].trim().equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
					+ "'"+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
					+ "'"+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
					+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
					+ "'"+rqty+"',"
					+ "'"+temp+"',"
					+ "'"+temp+"',"
					+ "'"+temp+"',"
					+ "'"+temp+"',"
					+ "'"+temp+"',"
					+ "'"+temp+"',"
					+ "'"+temp+"','"+fixing+"')";

			System.out.println("branchper--->>>>Sql"+sql3);
			int prodet = stmt.executeUpdate (sql3);
			
			if(prodet<=0)
			{
				 conn.close();
				 return 0;
			}*/

       
       
       
       
   	String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
	String specno=""+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"";
	String stkid=""+(prod[12].equalsIgnoreCase("undefined") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"";						 
	String  rqty=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
	double masterqty=Double.parseDouble(rqty);
       
       
       
   	double delqtys=0;
	double balstkqty=0;
	int psrno=0;
	double ckkqty=0;
	int stockid=0;
	double remstkqty=0;
	double outstkqty=0;
	double stkqty=0;
	double qty=0;
	double detqty=0;
	double focmasterqty=0.0;
	int locidss=0;
	Statement stmtstk=conn.createStatement();

	String stkSql="select locid,stockid,psrno,specno,sum(op_qty) stkqty,sum((op_qty-(rsv_qty+out_qty+del_qty))) balstkqty,"
			+ " (rsv_qty+out_qty+del_qty) out_qty,rsv_qty as qty,date from my_prddin "
			+ "where psrno='"+prdid+"' and specno='"+specno+"' and prdid='"+prdid+"' and brhid="+session.getAttribute("BRANCHID").toString()+" "
			+ "group by stockid,prdid,psrno having sum((op_qty-(rsv_qty+out_qty+del_qty)))>0 order by date,stockid";

	System.out.println("=stkSql======11=======inside insert="+stkSql);

	ResultSet rsstk = stmtstk.executeQuery(stkSql);

	while(rsstk.next()) {


		balstkqty=rsstk.getDouble("balstkqty");
		psrno=rsstk.getInt("psrno");
		outstkqty=rsstk.getDouble("out_qty");
		stockid=rsstk.getInt("stockid");
		stkqty=rsstk.getDouble("stkqty");
		qty=rsstk.getDouble("qty");
		locidss=rsstk.getInt("locid");
		System.out.println("---focmasterqty-----"+focmasterqty);	
		System.out.println("---balstkqty-----"+balstkqty);	
		System.out.println("---out_qty-----"+outstkqty);	
		System.out.println("---stkqty-----"+stkqty);
		System.out.println("---qty-----"+qty);

		focmasterqty=masterqty;
		if(remstkqty>0)
		{

			focmasterqty=remstkqty;
		}
		   ckkqty=focmasterqty;

		if(focmasterqty<=balstkqty)
		{
			
			focmasterqty=focmasterqty+qty;
			
			detqty=masterqty;
			String sqs="update my_prddin set rsv_qty="+focmasterqty+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+"";
			System.out.println("--1---sqls---"+sqs);
			stmt.executeUpdate(sqs);
			//break;
			delqtys=focmasterqty-qty;
			focmasterqty=ckkqty-focmasterqty-qty;

		}
		else if(masterqty>balstkqty)
		{



			if(stkqty>=(masterqty+outstkqty))

			{
				balstkqty=masterqty+qty;	
				remstkqty=stkqty-outstkqty;

				System.out.println("---balstkqty-1---"+balstkqty);
			}
			else
			{
				remstkqty=masterqty-balstkqty;
				balstkqty=stkqty-outstkqty+qty;

				/*System.out.println("---masterqty-2---"+masterqty);
				System.out.println("---outstkqty-2---"+outstkqty);
				System.out.println("---stkqty-2---"+stkqty);
				System.out.println("---remstkqty-2---"+remstkqty);
				System.out.println("---balstkqty--2--"+balstkqty);*/
			}
			detqty=stkqty-outstkqty;

			String sqs="update my_prddin set rsv_qty="+balstkqty+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+"";	
			System.out.println("-2----sqls---"+sqs);

			stmt.executeUpdate(sqs);	
			delqtys=detqty;
			//remstkqty=masterqty-stkqty;



		}
		System.out.println("-delqtys---"+delqtys);
		System.out.println("-detqty---"+detqty);

		double NtWtKG=0.0;
		double KGPrice=0.0;
		double unitprice=0.0;
		double total=0.0;
		double discper=0.0;
		double discount=0.0;
		double netotal=0.0;

		NtWtKG=Double.parseDouble(""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"");
		KGPrice=Double.parseDouble(""+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"");
		unitprice=Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"");
		total=delqtys*unitprice;
	 
		discper=Double.parseDouble(""+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"");
		discount=(total*discper)/100;
		netotal=total-discount;

		/*System.out.println("==NtWtKG===="+NtWtKG);

		 System.out.println("==KGPrice===="+KGPrice);

		 System.out.println("==unitprice===="+unitprice);

		 System.out.println("==total===="+total);

		 System.out.println("==discper===="+discper);

		 System.out.println("==discount===="+discount);

		 System.out.println("==netotal===="+netotal);*/


/*		String sqld="insert into my_sorderd(tr_No,sr_no,rdocno,stockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal)VALUES"
				+ " ("+trno+","+(i+1)+",'"+docno+"',"
				+ "'"+stockid+"',"
				+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
				+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
				+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
				+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
				+ "'"+delqtys+"',"
				+ "'"+NtWtKG+"',"
				+ "'"+KGPrice+"',"
				+ "'"+unitprice+"',"
				+ "'"+total+"',"
				+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
				+ "'"+discount+"',"
				+ "'"+netotal+"')";*/

		String sqld="insert into my_joborderd(tr_No,sr_no,rdocno,stockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal,fixing)VALUES"
				+ " ("+itrno+","+(i+1)+",'"+docno+"',"
				+ "'"+stockid+"',"
				+ "'"+(prod[10].trim().equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
				+ "'"+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
				+ "'"+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
				+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
				+ "'"+delqtys+"',"
				+ "'"+temp+"',"
				+ "'"+temp+"',"
				+ "'"+temp+"',"
				+ "'"+temp+"',"
				+ "'"+temp+"',"
				+ "'"+temp+"',"
				+ "'"+temp+"','"+fixing+"')";

		System.out.println("branchper--->>>>Sql"+sqld);
		int prodets = stmt.executeUpdate (sqld);
		
		if(prodets<=0)
		{
			 conn.close();
			 return 0;
		}
		


		String prodoutsql="insert into my_prddout(sr_no,TR_NO, date,dtype, rdocno,stockid, specid, psrno,rsv_qty,prdid,brhid,locid,unit_price) Values"
				+ " ("+(i+1)+",'"+itrno+"',curdate(),'"+formdetailcode+"',"+docno+","
				+ "'"+stockid+"',"
				+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
				+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
				+ "'"+delqtys+"',"
				+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
				+"'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"','"+locidss+"',0)";

		System.out.println("prodoutsql--->>>>Sql"+prodoutsql);
	int	prodout = stmt.executeUpdate (prodoutsql);

		if(focmasterqty<=0)
		{
			
			System.out.println("--2--");
			break;
		}


	}



       
       
       
       
       
       
       
       
       
       
       
       
				}
			}			
			
		
		  conn.commit();
				}
				catch(Exception e){
					docno=0;
					e.printStackTrace();
				}
				finally{
					conn.close();
				}

				return docno;
	}




	
	public    ClsJobOrderBean getPrint(int docno, HttpServletRequest request) throws SQLException {
		ClsJobOrderBean bean = new ClsJobOrderBean();
		  Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();

				  ClsAmountToWords c = new ClsAmountToWords();
				 
				Statement stmtprint = conn.createStatement ();
 
				String resql=("select m.type,m.doc_no,m.voc_no,br.brandname,mo.modelname,sm.submodel,ach.submodelid,y.yom,ac.refname,trim(ac.address) address,"
					+ " m.cldocno,ach.reg_no regno,ach.brandid brdid,ach.modelid,ach.yom yomid,s1.spec bsize,ach.bsizeid,s2.spec esize,ach.esizeid,s3.spec csize,ach.csizeid from"
					+ " my_joborderm m left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM'"
					+ "  left join my_acvehicle ach on ach.doc_no=m.clrefno  "
					+ " left join my_sbrand br on br.doc_no=ach.brandid left join my_smodel mo on mo.doc_no=ach.modelid "
					+ " left join my_ssubmodel sm on(sm.doc_No=ach.submodelid and sm.modelid=ach.modelid) left join my_suitspec1 s1 on(s1.doc_no=ach.bsizeid)  "
					+ " left join my_suitspec2 s2 on(s2.doc_no=ach.esizeid) left join my_suitspec3 s3 on(s3.doc_no=ach.csizeid)  "
					+ " left join my_syom y on y.doc_no=ach.yom where   m.doc_no='"+docno+"'");
				
				
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
		 
			       while(pintrs.next()){
			    	
 	    	    bean.setLbldoc(pintrs.getInt("voc_no"));
			    	    bean.setCustname(pintrs.getString("refname"));
			    	    bean.setCustaddress(pintrs.getString("address"));
			    	    bean.setLblregno(pintrs.getString("regno"));
			    	    bean.setLblbrand(pintrs.getString("brandname"));
			    	    bean.setLblmodel(pintrs.getString("modelname"));
			    	    bean.setLblsubmodel(pintrs.getString("submodel"));
			    	    
			    	    bean.setLblyom(pintrs.getString("yom"));  
			    	    bean.setLblesize(pintrs.getString("esize"));
			    	    bean.setLblbsize(pintrs.getString("bsize"));
			    	    bean.setLblcsize(pintrs.getString("csize"));
 
			    	   
			    	   
			    	   
 
			    	  
			       }
				

				stmtprint.close();
				
				
				
				 Statement stmt10 = conn.createStatement ();
				    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from my_joborderm r  "
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
				   	 Statement stmtgrid = conn.createStatement();       
				     String temp="";  
				       String	strSqldetail="Select bd.brandname,if(d.fixing=1,'YES','NO') fixing,d.specno specid ,m.part_no productid,m.productname, u.unit,round(sum(d.qty),2) qty    from my_joborderd d "
	       			+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no left join  my_brand bd on m.brandid=bd.doc_no    where d.rdocno='"+docno+"' group by d.prdId";
					
				        
				       
					ResultSet rsdetail=stmtgrid.executeQuery(strSqldetail);
					
					int rowcount=1;
			
					while(rsdetail.next()){
						 
							 
							temp=rowcount+"::"+rsdetail.getString("productid")+"::"+rsdetail.getString("productname")+"::"+rsdetail.getString("brandname")+"::"+
							rsdetail.getString("unit")+"::"+rsdetail.getString("qty")+"::"+rsdetail.getString("fixing") ;
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


	
}





