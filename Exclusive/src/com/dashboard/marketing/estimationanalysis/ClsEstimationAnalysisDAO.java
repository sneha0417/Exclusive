package com.dashboard.marketing.estimationanalysis;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsEstimationAnalysisDAO  { 
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray estimationAnalysisGridLoading (String branchval, String fromDate, String toDate, String clientdocno, String estimationtrno, String reftype, String referencedocno, String check) throws SQLException{

		JSONArray RESULTDATA1=new JSONArray();

		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA1;
		}
		
		Connection conn=null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			java.sql.Date sqlFromDate=null;
			java.sql.Date sqlToDate=null;

			if(!(fromDate.equalsIgnoreCase("undefined"))&&!(fromDate.equalsIgnoreCase(""))&&!(fromDate.equalsIgnoreCase("0"))){
				sqlFromDate = ClsCommon.changeStringtoSqlDate(fromDate);
			}
			
			if(!(toDate.equalsIgnoreCase("undefined"))&&!(toDate.equalsIgnoreCase(""))&&!(toDate.equalsIgnoreCase("0"))){
				sqlToDate = ClsCommon.changeStringtoSqlDate(toDate);
			}
			String sql1="";
			
			 if(!((clientdocno.equalsIgnoreCase("")) || (clientdocno.equalsIgnoreCase("0")))){
	              sql1=sql1+" and ma.cldocno='"+clientdocno+"'";
	         }
			 
			 if(!((estimationtrno.equalsIgnoreCase("")) || (estimationtrno.equalsIgnoreCase("0")))){
	              sql1=sql1+" and ma.tr_no='"+estimationtrno+"'";
	         }
			 
			 if(!((reftype.equalsIgnoreCase("")) || (reftype.equalsIgnoreCase("0")))){
	              sql1=sql1+" and ma.ref_type='"+reftype+"'";
	         }
			 
			 if(!((referencedocno.equalsIgnoreCase("")) || (referencedocno.equalsIgnoreCase("0")))){
	              sql1=sql1+" and ma.reftrno='"+referencedocno+"'";
	         }
			
			String sql="select ma.doc_no,CONVERT(CONCAT(ma.ref_type,' - ',ma.refdocno),CHAR(100)) reference,d.site,grp.groupname sertype,d.description desc1,sp.scode scope,m.productname product,bd.brandname,u.unit,d.qty,"
					+ "round(d.scopestdcost,2) scopestdcost,round(d.scopeamount,2) scopeamount,round(coalesce((d.scopeamount*d.qty),0),2) scopetotal,round(coalesce((d.scopeamount*d.qty)-(d.scopestdcost*d.qty),0),2) scopeprofitamt,"
					+ "round(coalesce(((((d.scopeamount*d.qty)-(d.scopestdcost*d.qty))/(d.scopeamount*d.qty))*100),0),2)  scopeprofitperc,round(d.stdprice,2) stdprice,round(d.costprice,2) amount,round(coalesce((d.costprice*d.qty),0),2) producttotal,"
					+ "round(coalesce((d.costprice*d.qty)-(d.stdprice*d.qty),0),2) profitproductamount,round(coalesce(((((d.costprice*d.qty)-(d.stdprice*d.qty))/(d.costprice*d.qty))*100),0),2)  productprofitperc,d.marginper,d.profitper margin,"
					+ "round(coalesce((d.scopestdcost*d.qty)+(d.stdprice*d.qty),0),2) totalcost,round(coalesce((d.scopeamount*d.qty),0)+coalesce((d.costprice*d.qty),0)+coalesce(d.profitper,0),2) totalestimated,"
					+ "round(coalesce((d.scopeamount*d.qty)-(d.scopestdcost*d.qty),0)+coalesce((d.costprice*d.qty)-(d.stdprice*d.qty),0)+coalesce(d.profitper,0),2) totalprofitamt,"
					+ "round(coalesce((coalesce((d.scopestdcost*d.qty)+(d.stdprice*d.qty),0)/(coalesce((d.scopeamount*d.qty),0)+coalesce((d.costprice*d.qty),0)+coalesce(d.profitper,0)))*100,0),2) totalprofitperc from "
					+ "cm_prjestm ma left join cm_estmprdd d  on ma.tr_no=d.tr_no left join cm_prjmaster mp  on(mp.tr_no=d.activityid) left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no) left join my_scope sp on sp.doc_no=d.scopeid  left join  "
					+ "my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on (at.mpsrno=m.doc_no) left join (select psrno,brhid,locid,sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty from my_prddin "
					+ "group by psrno,brhid ) prd on prd.psrno=d.psrno and prd.brhid=mp.brhid left join my_unitm u on d.unitid=u.doc_no left join my_groupvals grp on grp.doc_no=d.sertypeid and grp.grptype='service' "
					+ "where ma.status=3 and ma.date>='"+sqlFromDate+"' and ma.date<='"+sqlToDate+"'"+sql1+"";


			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=ClsCommon.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA1;
	}
	
	public JSONArray estimationAnalysisExcelExport(String branchval, String fromDate, String toDate, String clientdocno, String estimationtrno, String reftype, String referencedocno, String check) throws SQLException{

		JSONArray RESULTDATA1=new JSONArray();

		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA1;
		}
		
		Connection conn=null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			java.sql.Date sqlFromDate=null;
			java.sql.Date sqlToDate=null;

			if(!(fromDate.equalsIgnoreCase("undefined"))&&!(fromDate.equalsIgnoreCase(""))&&!(fromDate.equalsIgnoreCase("0"))){
				sqlFromDate = ClsCommon.changeStringtoSqlDate(fromDate);
			}
			
			if(!(toDate.equalsIgnoreCase("undefined"))&&!(toDate.equalsIgnoreCase(""))&&!(toDate.equalsIgnoreCase("0"))){
				sqlToDate = ClsCommon.changeStringtoSqlDate(toDate);
			}
			String sql1="";
			
			 if(!((clientdocno.equalsIgnoreCase("")) || (clientdocno.equalsIgnoreCase("0")))){
	              sql1=sql1+" and ma.cldocno='"+clientdocno+"'";
	         }
			 
			 if(!((estimationtrno.equalsIgnoreCase("")) || (estimationtrno.equalsIgnoreCase("0")))){
	              sql1=sql1+" and ma.tr_no='"+estimationtrno+"'";
	         }
			 
			 if(!((reftype.equalsIgnoreCase("")) || (reftype.equalsIgnoreCase("0")))){
	              sql1=sql1+" and ma.ref_type='"+reftype+"'";
	         }
			 
			 if(!((referencedocno.equalsIgnoreCase("")) || (referencedocno.equalsIgnoreCase("0")))){
	              sql1=sql1+" and ma.reftrno='"+referencedocno+"'";
	         }
			
			String sql="select ma.doc_no 'Doc No',CONVERT(CONCAT(ma.ref_type,' - ',ma.refdocno),CHAR(100)) 'Reference',d.site 'Site',grp.groupname 'Service Type',d.description 'Description',sp.scode 'Scope',m.productname 'Product',bd.brandname 'Brand',u.unit 'Unit',d.qty 'Quantity',"
					+ "round(d.scopestdcost,2) 'Scope Cost',round(d.scopeamount,2) 'Scope Estimated',round(coalesce((d.scopeamount*d.qty),0),2) 'Scope Total',round(coalesce((d.scopeamount*d.qty)-(d.scopestdcost*d.qty),0),2) 'Scope Profit',"
					+ "round(coalesce(((((d.scopeamount*d.qty)-(d.scopestdcost*d.qty))/(d.scopeamount*d.qty))*100),0),2)  'Scope Profit Percentage',round(d.stdprice,2) 'Product Cost',round(d.costprice,2) 'Product Estimated',round(coalesce((d.costprice*d.qty),0),2) 'Product Total',"
					+ "round(coalesce((d.costprice*d.qty)-(d.stdprice*d.qty),0),2) 'Product Profit',round(coalesce(((((d.costprice*d.qty)-(d.stdprice*d.qty))/(d.costprice*d.qty))*100),0),2)  'Product Profit Percentage',d.marginper 'Margin Percentage',d.profitper 'Margin',"
					+ "round(coalesce((d.scopestdcost*d.qty)+(d.stdprice*d.qty),0),2) 'Total Cost',round(coalesce((d.scopeamount*d.qty),0)+coalesce((d.costprice*d.qty),0)+coalesce(d.profitper,0),2) 'Total Estimated',"
					+ "round(coalesce((d.scopeamount*d.qty)-(d.scopestdcost*d.qty),0)+coalesce((d.costprice*d.qty)-(d.stdprice*d.qty),0)+coalesce(d.profitper,0),2) 'Total Profit',"
					+ "round(coalesce((coalesce((d.scopestdcost*d.qty)+(d.stdprice*d.qty),0)/(coalesce((d.scopeamount*d.qty),0)+coalesce((d.costprice*d.qty),0)+coalesce(d.profitper,0)))*100,0),2) 'Total Profit Percentage' from "
					+ "cm_prjestm ma left join cm_estmprdd d  on ma.tr_no=d.tr_no left join cm_prjmaster mp  on(mp.tr_no=d.activityid) left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no) left join my_scope sp on sp.doc_no=d.scopeid  left join  "
					+ "my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on (at.mpsrno=m.doc_no) left join (select psrno,brhid,locid,sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty from my_prddin "
					+ "group by psrno,brhid ) prd on prd.psrno=d.psrno and prd.brhid=mp.brhid left join my_unitm u on d.unitid=u.doc_no left join my_groupvals grp on grp.doc_no=d.sertypeid and grp.grptype='service' "
					+ "where ma.status=3 and ma.date>='"+sqlFromDate+"' and ma.date<='"+sqlToDate+"'"+sql1+"";


			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=ClsCommon.convertToEXCEL(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA1;
	}
		
	public JSONArray clientDetails(String partyname,String contact,String chk) throws SQLException {
	    Connection conn=null;
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    String sql = null;
	    	    String sql1 = "";
	    	    
	            if(!((partyname.equalsIgnoreCase("")) || (partyname.equalsIgnoreCase("0")))){
	             sql1=sql1+" and refname like '%"+partyname+"%'";
	            }
	            if(!((contact.equalsIgnoreCase("")) || (contact.equalsIgnoreCase("0")))){
	                sql1=sql1+" and per_mob like '%"+contact+"%'";
	            }
	            
				conn = ClsConnection.getMyConnection();
				Statement stmtJESTAnalysis = conn.createStatement();
				
				sql = "select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM' and status=3"+sql1;
				
				if(chk.equalsIgnoreCase("1")){
					ResultSet resultSet1 = stmtJESTAnalysis.executeQuery(sql);
					RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				}
				else{
					stmtJESTAnalysis.close();
					conn.close();
					return RESULTDATA1;
				}
				stmtJESTAnalysis.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}

	public JSONArray estimationDetailsSearchGridLoading(HttpSession session,String msdocno,String Cl_namess,String dates,String reftype,int id,String refno) throws SQLException {


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

		java.sql.Date sqlDate=null;

		if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0"))){
			sqlDate = ClsCommon.changeStringtoSqlDate(dates);
		}


		Connection conn = null;
		ResultSet resultSet =null;
		try {

			conn = ClsConnection.getMyConnection();
			Statement stmtJESTAnalysis = conn.createStatement ();

			String sqltest="";

			if(!(msdocno.equalsIgnoreCase("undefined"))&&!(msdocno.equalsIgnoreCase(""))&&!(msdocno.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and m.doc_no like '%"+msdocno+"%'";
			}
			if(!(Cl_namess.equalsIgnoreCase("undefined"))&&!(Cl_namess.equalsIgnoreCase(""))&&!(Cl_namess.equalsIgnoreCase("0"))){

				sqltest=sqltest+" and ac.refname like '%"+Cl_namess+"%'";
			}
			
			if(!(sqlDate==null)){
				 sqltest=sqltest+" and m.date="+sqlDate+"";
			}
			 
			if(!(reftype.equalsIgnoreCase("undefined"))&&!(reftype.equalsIgnoreCase(""))&&!(reftype.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and m.ref_type like '%"+reftype+"%'";
			}
			if(!(refno.equalsIgnoreCase("undefined"))&&!(refno.equalsIgnoreCase(""))&&!(refno.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and m.refdocno like '%"+refno+"%'";
			}
			
			String str1Sql="select m.doc_no,m.tr_no,ac.refname as client,ac.doc_no as cldocno,m.date,m.reviseno,m.ref_type,CONVERT(coalesce(m.refdocno,''),CHAR(100)) as refdocno,"
					+ "material, labour, machine, netTotal,m.reftrno,trim(ac.address) address,coalesce(enq.esttrno,0) esttrno,coalesce(enq.qottrno,0) qottrno,coalesce(esq.surtrno,0) surtrno from  cm_prjestm m "
					+ " left join gl_enqm enq on m.tr_no=enq.esttrno left join gl_enqm esq on m.reftrno=esq.doc_no left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') where m.status=3 "+sqltest+"";

			if(id>0){
				resultSet = stmtJESTAnalysis.executeQuery(str1Sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
			}


			stmtJESTAnalysis.close();
			conn.close();
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}

		return RESULTDATA;
	}
	
	public JSONArray referenceDetailsSearchGridLoading(HttpSession session,String msdocno,String Cl_names,String Cl_mobno,String enqdate,String clientid,int id,String reftypes) throws SQLException {

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
		
		Connection conn =null;
		Statement stmtJESTAnalysis = null;
		try {
			conn = ClsConnection.getMyConnection();
			stmtJESTAnalysis = conn.createStatement ();
			java.sql.Date sqlStartDate=null;

			if(!(enqdate.equalsIgnoreCase("undefined"))&&!(enqdate.equalsIgnoreCase(""))&&!(enqdate.equalsIgnoreCase("0"))){
				sqlStartDate = ClsCommon.changeStringtoSqlDate(enqdate);
			}
			
			String sqltest="";

			if(!(msdocno.equalsIgnoreCase("undefined"))&&!(msdocno.equalsIgnoreCase(""))&&!(msdocno.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and m.doc_no like '%"+msdocno+"%'";
			}
			
			if(!(clientid.equalsIgnoreCase("undefined"))&&!(clientid.equalsIgnoreCase(""))&&!(clientid.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and m.cldocno="+clientid+"";
			}
			
			if(!(Cl_names.equalsIgnoreCase("undefined"))&&!(Cl_names.equalsIgnoreCase(""))&&!(Cl_names.equalsIgnoreCase("0"))){

				sqltest=sqltest+" and ac.refname like '%"+Cl_names+"%'";
			}
			
			if(!(sqlStartDate==null)){
				 sqltest=sqltest+" and m.date="+sqlStartDate+"";
			}
			
			if(!(Cl_mobno.equalsIgnoreCase("undefined"))&&!(Cl_mobno.equalsIgnoreCase(""))&&!(Cl_mobno.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and ac.com_mob like '%"+Cl_mobno+"%'";
			}
			
			if(id>0){
				
				String str1Sql=("SELECT m.tr_no doc_no,m.doc_no voc_no,m.date,m.refdocno,m.reftrno,if(m.cldocno>0,ac.refname,'') as name,coalesce(ac.doc_no,0) as clientid,"
						 + "if(m.cldocno>0,concat(coalesce(ac.address,''),',',coalesce(ac.com_mob,'') ,',',coalesce(ac.mail1,'') ),'') as details,"
						 + "if(m.cldocno>0,ac.com_mob,'') contmob FROM cm_prjestm m left join my_acbook ac on (m.cldocno=ac.doc_no and ac.dtype='CRM') where m.status=3 "
						 + "and m.ref_type='"+reftypes+"'"+sqltest+"");
				
				ResultSet resultSet = stmtJESTAnalysis.executeQuery (str1Sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtJESTAnalysis.close();
				conn.close();
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmtJESTAnalysis.close();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	
}
