package com.dashboard.marketing.quotationdetail;

import java.sql.Connection;
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

public class ClsQuotationDetailDAO {
	ClsCommon com=new ClsCommon();
	ClsConnection conobj=new ClsConnection();
	 
	public int edit(ArrayList<String> servlist,ArrayList<String> matlist,ArrayList<String> sitelist,String meterialtrno,String quotationtrno,HttpSession session,
			HttpServletRequest request,String reftype,String qutNetTot,String btnval,String discount,String nettotal,String clientid,java.sql.Date quotdate, 
			String remarks,int chkrev,String scopegroupchanged) throws SQLException{

		Connection conn=null;
		try{
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			
			int cldocno=0,config=0,cltax=0;
			String clientupdate="",inter="0";
			
			if(btnval.equalsIgnoreCase("SQ"))
			{
			Double disc=discount=="" || discount==null || discount.equalsIgnoreCase("")?0.0:Double.parseDouble(discount);
			Double net=nettotal=="" || nettotal==null || nettotal.equalsIgnoreCase("")?0.0:Double.parseDouble(nettotal);
			Double tot=net+disc;
			Double nettotaltax=0.00,taxper=0.00,taxamt=0.00;
			int revision_val=0;
			String update_rev_sql="";
			String delete_rev_sql="";
			cldocno=clientid=="" || clientid==null || clientid.equalsIgnoreCase("")|| clientid.equalsIgnoreCase("undefined")?0:Integer.parseInt(clientid);
			String remark=remarks=="" || remarks==null || remarks.equalsIgnoreCase("")|| remarks.equalsIgnoreCase("undefined")?"":remarks;
			if(cldocno>0)
			
			{
				clientupdate="cldocno="+cldocno+",";
			}
			
			String consql="select method from gl_config where field_nme='tax'";
			ResultSet rsconfg = stmt.executeQuery(consql);

			while (rsconfg.next()) {
				config=rsconfg.getInt("method");
			}
			
			String clsql="select nontax from my_acbook where dtype='CRM' and cldocno=(select cldocno from cm_srvqotm where tr_no="+quotationtrno+")";
			ResultSet rscltax = stmt.executeQuery(clsql);

			while (rscltax.next()) {
				cltax=rscltax.getInt("nontax");
			}
			
			nettotaltax=Double.parseDouble(nettotal);
			
			if(config>0 && cltax==1){
				String upsql="";
				if(inter.equalsIgnoreCase("1")) //inter-state_IGST
				{
					upsql=" select t.tax_code,t.acno,t.value,cstper per,("+nettotal+"*t.cstper)/100 as taxamt,t.doc_no docno "
							+" from  gl_taxsubmaster t where   fromdate<='"+quotdate+"' and todate>='"+quotdate+"' and status=3 and type=2 and cstper>0" ;
				}
				else{
					upsql=" select t.tax_code,t.acno,t.value,per,("+nettotal+"*t.per)/100 as taxamt,t.doc_no docno "
						+" from  gl_taxsubmaster t where   fromdate<='"+quotdate+"' and todate>='"+quotdate+"' and status=3 and type=2 and per>0" ;
				}
				//System.out.println("===exclusivetax====="+upsql);

				ResultSet resultSet = stmt.executeQuery(upsql);

				while (resultSet.next()) {
					taxper+=resultSet.getDouble("per");
					taxamt+=resultSet.getDouble("taxamt");
				}
				
				nettotaltax=Double.parseDouble(nettotal)+taxamt;
				
			}
			
			String rivisionsql="select (max(revision_no)+1) revision from cm_srvqotm where tr_no="+quotationtrno+" ";
			ResultSet mavRev=stmt.executeQuery(rivisionsql);
			while(mavRev.next()){
				revision_val=Integer.parseInt(mavRev.getString("revision"));
			}

			if(chkrev==1)
			{
				update_rev_sql="update cm_srvqotm set "+clientupdate+" date='"+quotdate+"',revision_no='"+revision_val+"', amount="+tot+",total="+nettotal+",netamount="+nettotaltax+",taxPer="+taxper+",tax="+taxamt+",discount="+discount+", disPer=round(("+discount+"/"+tot+")*100,2) where tr_no="+quotationtrno+" " ;
				
				request.setAttribute("revisionnoval", revision_val);
			}
			else{
				revision_val=revision_val-1;
				update_rev_sql="update cm_srvqotm set "+clientupdate+"  date='"+quotdate+"',amount="+tot+",total="+nettotal+",netamount="+nettotaltax+",taxPer="+taxper+",tax="+taxamt+",discount="+discount+", disPer=round(("+discount+"/"+tot+")*100,2) where tr_no="+quotationtrno+" " ;
				request.setAttribute("revisionnoval", revision_val);
				delete_rev_sql="delete from cm_srvqotd where  tr_no="+quotationtrno+" and revision_no="+revision_val+" ";
				stmt.executeUpdate(delete_rev_sql);
			}

			//System.out.println("update_rev_sql==="+update_rev_sql);
			stmt.executeUpdate(update_rev_sql);
			String sql1 = "";
			int siteid=0;
			
			for(int i=0;i< sitelist.size();i++){

				String[] surveydet=((String) sitelist.get(i)).split("::");
			
				if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
				{
					int rowno=0;

					rowno=(Integer) (surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:Integer.parseInt(surveydet[2].trim()));

					if(rowno>0){
						
						String sql="update cm_servsited set site='"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
								+ "areaId='"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',revision_no='"+revision_val+"' where dtype='SQOT' and sr_no='"+(i+1)+"' and tr_no='"+quotationtrno+"'";

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}
						
					} else {
						
						String sql="INSERT INTO cm_servsited(sr_no,refrowno, site, areaId, amount,revision_no,dtype,tr_no)VALUES ("+(i+1)+",0,"
								+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
								+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
								+ "0,'"+revision_val+"','SQOT','"+quotationtrno+"')";

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}
						
					}

				}

			}

			for(int i=0;i< servlist.size();i++){

				String[] surveydet=((String) servlist.get(i)).split("::");

				if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
				{		

					siteid=(Integer) (surveydet[6].trim().equalsIgnoreCase("undefined") || surveydet[6].trim().equalsIgnoreCase("NaN")|| surveydet[6].trim().equalsIgnoreCase("")|| surveydet[6].isEmpty()?0:Integer.parseInt(surveydet[6].trim()));

					sql1="select rowno from cm_servsited where tr_no="+quotationtrno+" and sr_no="+siteid+"";
					ResultSet resultSet1 = stmt.executeQuery(sql1);
					
					while(resultSet1.next()){
						siteid=resultSet1.getInt("rowno");
					}

					String sql="INSERT INTO cm_srvqotd(sr_no,servId,Equips, qty, Amount,total,description,unitid,psrno,scopeid,scopeamount,stdprice,lbrchg,scopestdcost,sitesrno,tr_no,revision_no)VALUES"
							+ " ("+(i+1)+","
							+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
							+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
							+ "'"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim())+"',"
							+ "'"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:surveydet[3].trim())+"',"
							+ "'"+(surveydet[4].trim().equalsIgnoreCase("undefined") || surveydet[4].trim().equalsIgnoreCase("NaN")|| surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()?0:surveydet[4].trim())+"',"
							+ "'"+(surveydet[5].trim().equalsIgnoreCase("undefined") || surveydet[5].trim().equalsIgnoreCase("NaN")|| surveydet[5].trim().equalsIgnoreCase("")|| surveydet[5].isEmpty()?"":surveydet[5].trim())+"',"
							+ "'"+(surveydet[7].trim().equalsIgnoreCase("undefined") || surveydet[7].trim().equalsIgnoreCase("NaN")|| surveydet[7].trim().equalsIgnoreCase("")|| surveydet[7].isEmpty()?0:surveydet[7].trim())+"',"
							+ "'"+(surveydet[8].trim().equalsIgnoreCase("undefined") || surveydet[8].trim().equalsIgnoreCase("NaN")|| surveydet[8].trim().equalsIgnoreCase("")|| surveydet[8].isEmpty()?0:surveydet[8].trim())+"',"
							+ "'"+(surveydet[9].trim().equalsIgnoreCase("undefined") || surveydet[9].trim().equalsIgnoreCase("NaN")|| surveydet[9].trim().equalsIgnoreCase("")|| surveydet[9].isEmpty()?0:surveydet[9].trim())+"',"
							+ "'"+(surveydet[10].trim().equalsIgnoreCase("undefined") || surveydet[10].trim().equalsIgnoreCase("NaN")|| surveydet[10].trim().equalsIgnoreCase("")|| surveydet[10].isEmpty()?0:surveydet[10].trim())+"',"
							+ "'"+(surveydet[11].trim().equalsIgnoreCase("undefined") || surveydet[11].trim().equalsIgnoreCase("NaN")|| surveydet[11].trim().equalsIgnoreCase("")|| surveydet[11].isEmpty()?0:surveydet[11].trim())+"',"
							+ "'"+(surveydet[12].trim().equalsIgnoreCase("undefined") || surveydet[12].trim().equalsIgnoreCase("NaN")|| surveydet[12].trim().equalsIgnoreCase("")|| surveydet[12].isEmpty()?0:surveydet[12].trim())+"',"
							+ "'"+(surveydet[13].trim().equalsIgnoreCase("undefined") || surveydet[13].trim().equalsIgnoreCase("NaN")|| surveydet[13].trim().equalsIgnoreCase("")|| surveydet[13].isEmpty()?0:surveydet[13].trim())+"',"
							+ " "+siteid+","
							+" '"+quotationtrno+"' ,"
							+ " '"+revision_val+"')";



										//	System.out.println("====sql====="+sql);

					int resultSet2 = stmt.executeUpdate (sql);
					if(resultSet2<=0)
					{
						conn.close();
						return 0;
					}	

				}

			}
			
			String insrev="INSERT INTO cm_srvqotrev(date, rtrno, remarks, cldocno, revision_no) VALUES(NOW(),"+quotationtrno+",'"+remark+"',"+cldocno+",'"+revision_val+"')" ;
			int rsrev=stmt.executeUpdate(insrev);
			if(rsrev<=0)
			{
				conn.close();
				return 0;
			}	
			}
			else if(btnval.equalsIgnoreCase("SE"))
			{
				//System.out.println("btnval===="+btnval);
			//System.out.println("meterialtrno"+meterialtrno);
		if(reftype.equalsIgnoreCase("ENQ") || reftype.equalsIgnoreCase("SRVE") ){	
			int matTrno=Integer.parseInt(meterialtrno);
			if(matTrno>0){ ///it isbased on enquiry not direct
				//System.out.println("matTrno"+matTrno);
				String delsql="delete from cm_estmprdd where tr_no="+meterialtrno+" ;";
				stmt.executeUpdate(delsql);	
				for(int i=0;i< matlist.size();i++){
					String[] arrayDet=((String) matlist.get(i)).split("::");
					//System.out.println("====material activity=="+arrayDet[9]);
					if((!(arrayDet[12].trim().equalsIgnoreCase("undefined")|| arrayDet[12].trim().equalsIgnoreCase("NaN")||arrayDet[12].trim().equalsIgnoreCase("")|| arrayDet[12].isEmpty()))
						|| (!(arrayDet[0].trim().equalsIgnoreCase("undefined")|| arrayDet[0].trim().equalsIgnoreCase("NaN")||arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()))
						|| (!(arrayDet[1].trim().equalsIgnoreCase("undefined")|| arrayDet[1].trim().equalsIgnoreCase("NaN")||arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty())))
					{
					//SpecNo					

						/*String sql="INSERT INTO cm_estmprdd(tr_no, SR_NO,Description, psrno, prdId,UNITID, qty, costPrice,  total, profitPer,activityid, NetTotal,site,sertypeid,sitesrno)VALUES"
							+ " ("+meterialtrno+","
							+ " "+(i+1)+","
							+ "'"+(arrayDet[0].trim().equalsIgnoreCase("undefined") || arrayDet[0].trim().equalsIgnoreCase("NaN")|| arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()?"":arrayDet[0].trim())+"',"
							+ "'"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?0:arrayDet[1].trim())+"',"
							+ "'"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?0:arrayDet[1].trim())+"',"
							+ "'"+(arrayDet[3].trim().equalsIgnoreCase("undefined") || arrayDet[3].trim().equalsIgnoreCase("NaN")|| arrayDet[3].trim().equalsIgnoreCase("")|| arrayDet[3].isEmpty()?0:arrayDet[3].trim())+"',"
							+ "'"+(arrayDet[4].trim().equalsIgnoreCase("undefined") || arrayDet[4].trim().equalsIgnoreCase("NaN")|| arrayDet[4].trim().equalsIgnoreCase("")|| arrayDet[4].isEmpty()?0:arrayDet[4].trim())+"',"
							+ "'"+(arrayDet[5].trim().equalsIgnoreCase("undefined") || arrayDet[5].trim().equalsIgnoreCase("NaN")|| arrayDet[5].trim().equalsIgnoreCase("")|| arrayDet[5].isEmpty()?0:arrayDet[5].trim())+"',"
							+ "'"+(arrayDet[6].trim().equalsIgnoreCase("undefined") || arrayDet[6].trim().equalsIgnoreCase("NaN")|| arrayDet[6].trim().equalsIgnoreCase("")|| arrayDet[6].isEmpty()?0:arrayDet[6].trim())+"',"
							+ "'"+(arrayDet[7].trim().equalsIgnoreCase("undefined") || arrayDet[7].trim().equalsIgnoreCase("NaN")|| arrayDet[7].trim().equalsIgnoreCase("")|| arrayDet[7].isEmpty()?0:arrayDet[7].trim())+"',"
							+ "'"+(arrayDet[9].trim().equalsIgnoreCase("undefined") || arrayDet[9].trim().equalsIgnoreCase("NaN")|| arrayDet[9].trim().equalsIgnoreCase("")|| arrayDet[9].isEmpty()?0:arrayDet[9].trim())+"',"
							+ "'"+(arrayDet[8].trim().equalsIgnoreCase("undefined") || arrayDet[8].trim().equalsIgnoreCase("NaN")|| arrayDet[8].trim().equalsIgnoreCase("")|| arrayDet[8].isEmpty()?0:arrayDet[8].trim())+"',"
							+ "'"+(arrayDet[10].trim().equalsIgnoreCase("undefined") || arrayDet[10].trim().equalsIgnoreCase("NaN")|| arrayDet[10].trim().equalsIgnoreCase("")|| arrayDet[10].isEmpty()?"":arrayDet[10].trim())+"',"
							+ "'"+(arrayDet[11].trim().equalsIgnoreCase("undefined") || arrayDet[11].trim().equalsIgnoreCase("NaN")|| arrayDet[11].trim().equalsIgnoreCase("")|| arrayDet[11].isEmpty()?0:arrayDet[11].trim())+"',"
							+ "'"+(arrayDet[12].trim().equalsIgnoreCase("undefined") || arrayDet[12].trim().equalsIgnoreCase("NaN")|| arrayDet[12].trim().equalsIgnoreCase("")|| arrayDet[12].isEmpty()?0:arrayDet[12].trim())+"')";*/
					
						
						String sql="INSERT INTO cm_estmprdd(tr_no, SR_NO,Description, psrno, prdId,UNITID, qty, costPrice,  total, profitPer,activityid, NetTotal,site,sertypeid,sitesrno,marginper,scopeid,scopeamount,stdprice,lbrchg,scopestdcost) VALUES"
								+ " ("+meterialtrno+","
								+ " "+(i+1)+","
								+ "'"+(arrayDet[0].trim().equalsIgnoreCase("undefined") || arrayDet[0].trim().equalsIgnoreCase("NaN")|| arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()?"":arrayDet[0].trim())+"',"
								+ "'"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?0:arrayDet[1].trim())+"',"
								+ "'"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?0:arrayDet[1].trim())+"',"
								+ "'"+(arrayDet[3].trim().equalsIgnoreCase("undefined") || arrayDet[3].trim().equalsIgnoreCase("NaN")|| arrayDet[3].trim().equalsIgnoreCase("")|| arrayDet[3].isEmpty()?0:arrayDet[3].trim())+"',"
								+ "'"+(arrayDet[4].trim().equalsIgnoreCase("undefined") || arrayDet[4].trim().equalsIgnoreCase("NaN")|| arrayDet[4].trim().equalsIgnoreCase("")|| arrayDet[4].isEmpty()?0:arrayDet[4].trim())+"',"
								+ "'"+(arrayDet[5].trim().equalsIgnoreCase("undefined") || arrayDet[5].trim().equalsIgnoreCase("NaN")|| arrayDet[5].trim().equalsIgnoreCase("")|| arrayDet[5].isEmpty()?0:arrayDet[5].trim())+"',"
								+ "'"+(arrayDet[6].trim().equalsIgnoreCase("undefined") || arrayDet[6].trim().equalsIgnoreCase("NaN")|| arrayDet[6].trim().equalsIgnoreCase("")|| arrayDet[6].isEmpty()?0:arrayDet[6].trim())+"',"
								+ "'"+(arrayDet[7].trim().equalsIgnoreCase("undefined") || arrayDet[7].trim().equalsIgnoreCase("NaN")|| arrayDet[7].trim().equalsIgnoreCase("")|| arrayDet[7].isEmpty()?0:arrayDet[7].trim())+"',"
								+ "'"+(arrayDet[9].trim().equalsIgnoreCase("undefined") || arrayDet[9].trim().equalsIgnoreCase("NaN")|| arrayDet[9].trim().equalsIgnoreCase("")|| arrayDet[9].isEmpty()?0:arrayDet[9].trim())+"',"
								+ "'"+(arrayDet[8].trim().equalsIgnoreCase("undefined") || arrayDet[8].trim().equalsIgnoreCase("NaN")|| arrayDet[8].trim().equalsIgnoreCase("")|| arrayDet[8].isEmpty()?0:arrayDet[8].trim())+"',"
								+ "'"+(arrayDet[10].trim().equalsIgnoreCase("undefined") || arrayDet[10].trim().equalsIgnoreCase("NaN")|| arrayDet[10].trim().equalsIgnoreCase("")|| arrayDet[10].isEmpty()?"":arrayDet[10].trim())+"',"
								+ "'"+(arrayDet[11].trim().equalsIgnoreCase("undefined") || arrayDet[11].trim().equalsIgnoreCase("NaN")|| arrayDet[11].trim().equalsIgnoreCase("")|| arrayDet[11].isEmpty()?0:arrayDet[11].trim())+"',"
								+ "'"+(arrayDet[12].trim().equalsIgnoreCase("undefined") || arrayDet[12].trim().equalsIgnoreCase("NaN")|| arrayDet[12].trim().equalsIgnoreCase("")|| arrayDet[12].isEmpty()?0:arrayDet[12].trim())+"',"
								+ "'"+(arrayDet[13].trim().equalsIgnoreCase("undefined") || arrayDet[13].trim().equalsIgnoreCase("NaN")|| arrayDet[13].trim().equalsIgnoreCase("")|| arrayDet[13].isEmpty()?0:arrayDet[13].trim())+"',"
								+ "'"+(arrayDet[14].trim().equalsIgnoreCase("undefined") || arrayDet[14].trim().equalsIgnoreCase("NaN")|| arrayDet[14].trim().equalsIgnoreCase("")|| arrayDet[14].isEmpty()?0:arrayDet[14].trim())+"',"
								+ "'"+(arrayDet[15].trim().equalsIgnoreCase("undefined") || arrayDet[15].trim().equalsIgnoreCase("NaN")|| arrayDet[15].trim().equalsIgnoreCase("")|| arrayDet[15].isEmpty()?0:arrayDet[15].trim())+"',"
								+ "'"+(arrayDet[16].trim().equalsIgnoreCase("undefined") || arrayDet[16].trim().equalsIgnoreCase("NaN")|| arrayDet[16].trim().equalsIgnoreCase("")|| arrayDet[16].isEmpty()?0:arrayDet[16].trim())+"',"
								+ "'"+(arrayDet[17].trim().equalsIgnoreCase("undefined") || arrayDet[17].trim().equalsIgnoreCase("NaN")|| arrayDet[17].trim().equalsIgnoreCase("")|| arrayDet[17].isEmpty()?0:arrayDet[17].trim())+"',"
								+ "'"+(arrayDet[18].trim().equalsIgnoreCase("undefined") || arrayDet[18].trim().equalsIgnoreCase("NaN")|| arrayDet[18].trim().equalsIgnoreCase("")|| arrayDet[18].isEmpty()?0:arrayDet[18].trim())+"')";
						
						System.out.println("==matlist==="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}
						//conn.commit();

					}

				}//for
			} //if
		}//if	
		
				if(scopegroupchanged.equalsIgnoreCase("1")){
					
					String sql1="update cm_prjestm set scopegrpid=6 where status=3 and scopegrpid=1 and tr_no="+meterialtrno+"";
					int resultSet2 = stmt.executeUpdate(sql1);
					if(resultSet2<=0)
					{
						conn.close();
						return 0;
					}
					
				}
			
			}
			conn.commit();
			
		

		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
finally{
	conn.close();
}


		return Integer.parseInt(quotationtrno);

	}
	
	
	
	
	public JSONArray searchMaster(HttpSession session,String fromdate,String todate,String msdocno,String Cl_names,String sereftype,String surdate,String cntrtype,int id)throws SQLException {

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
		java.sql.Date sqlfdate=null;
		java.sql.Date sqltdate=null;

		java.sql.Date sqlStartDate=null;

		if(id<=0){
			return RESULTDATA;
		}

		String sqltest="";
		String str1Sql="";
		if(!(surdate.equalsIgnoreCase("undefined"))&&!(surdate.equalsIgnoreCase(""))&&!(surdate.equalsIgnoreCase("0")))
		{
			sqlStartDate = com.changeStringtoSqlDate(surdate);
			sqltest=sqltest+" and m.date<="+sqlStartDate+"";
		}
		if(!(msdocno.equalsIgnoreCase("undefined"))&&!(msdocno.equalsIgnoreCase(""))&&!(msdocno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and m.doc_no like '%"+msdocno+"%'";
		}
		if(!(Cl_names.equalsIgnoreCase("undefined"))&&!(Cl_names.equalsIgnoreCase(""))&&!(Cl_names.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and ac.refname like '%"+Cl_names+"%'";
		}
		if(!(sereftype.equalsIgnoreCase("undefined"))&&!(sereftype.equalsIgnoreCase(""))&&!(sereftype.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and m.ref_type like '%"+sereftype+"%'";
		}
		if(!(cntrtype.equalsIgnoreCase("undefined"))&&!(cntrtype.equalsIgnoreCase(""))&&!(cntrtype.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and m.cntr_type like '%"+cntrtype+"%'";
		}

		try {
				conn = conobj.getMyConnection();
				Statement stmtenq1 = conn.createStatement ();
				if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))){
					sqlfdate=com.changeStringtoSqlDate(fromdate);
				}
				if(!todate.equalsIgnoreCase("undefined")&&!todate.equalsIgnoreCase("")){
					sqltdate=com.changeStringtoSqlDate(todate);
				}
				
				
				str1Sql=("select m.revision_no,est.brhid,DATE_FORMAT(est.date,'%d-%m-%Y') estdate,est.cldocno,est.tr_no est_trno,m.TR_NO tr_no,m.DOC_NO doc_no, m.DATE date,m.dtype,m.ref_type reftype,refname,"
						+ " m.cntr_type,ac.refname as name,coalesce(est.contrmode,m.cntr_type) contrmode,coalesce(est.scopegrpid,0) scopegrpid,round(coalesce(m.netamount,0),2) netamount,round(coalesce(m.discount,0),2) discount,"
						+ "coalesce(m.refdocno,0) enqno,coalesce(enq.surtrno,0) surtrno "
						+ " from  cm_srvqotm m  left join gl_enqm enq on enq.doc_no=m.refdocno and M.ref_type='ENQ' left join CM_SRVDETM srv on srv.tr_no=M.refdocno  and M.ref_type='SRVE'  "
						+ " left join cm_prjestm est on  ((est.tr_no=enq.esttrno and EST.ref_type='enq') or (est.reftrno=srv.tr_no  and est.ref_type='srvE')) and m.ref_type=est.ref_type    left join my_acbook ac "
						+ " on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_crmcontact cn on(cn.cldocno=m.cpersonid "
						+ " and cn.row_no=m.cpersonid) left join my_salm sm on(sm.doc_no=m.sal_id) where m.status!=7 and m.cntrtrno=0 and m.date between '"+sqlfdate+"' and '"+sqltdate+"' "+sqltest+" group by m.tr_no ");

			System.out.println("===qotstr1Sql===="+str1Sql);

				ResultSet resultSet = stmtenq1.executeQuery(str1Sql);

				RESULTDATA=com.convertToJSON(resultSet);
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

	
	public JSONArray serviceEstLoad(HttpSession session,int enqno,String reftype) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			String brhid=session.getAttribute("BRANCHID").toString();

			sql="select d.site,d.sitesrno siteid,d.sertypeid stypeid,grp.groupname stype,concat(d.description,' ',m.part_no) proname,u.unit,concat(d.description,' ',m.part_no) product,"
				+ "d.unitid,d.qty,round(coalesce(d.nettotal/d.qty,0),2) amount,d.nettotal total,coalesce(d.description,'') desc1,d.psrno,d.scopeid,d.scopeamount,d.stdprice,d.lbrchg,"
				+ "d.scopestdcost,sp.scode scope from cm_estmprdd d left join cm_prjestm pm on pm.tr_no=d.tr_no left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no) "
				+ "left join my_unitm u on d.unitid=u.doc_no left join my_groupvals grp on grp.doc_no=d.sertypeid and grp.grptype='service' left join my_scope sp on sp.doc_no=d.scopeid "
				+ "where pm.reftrno='"+enqno+"' and pm.ref_type='"+reftype+"'";  

			//System.out.println("===serviceEstLoad===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}
	 public JSONArray sitegridSearch(String reftrno,int loadid,String reftype) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
if(reftype.equalsIgnoreCase("ENQ"))
{
			if(loadid==3)
			{
				sql="select site,sr_no sitesrno from gl_enqsited where rdocno='"+reftrno+"'";
				
			}
			else if(loadid==4)
			{
				sql="select site,sr_no sitesrno from cm_surveysid where rdocno='"+reftrno+"'";
			}	
}
else if(reftype.equalsIgnoreCase("SRVE"))
{
				sql="select site,sr_no sitesrno from cm_srvcsited where tr_no='"+reftrno+"'";
			
}

			//			System.out.println("===sql===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}

	public JSONArray quotGridLoad(HttpSession session,String doc_no,String revision) throws SQLException{

//System.out.println(doc_no);
		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			/*sql="select s.site,s.sr_no siteid,groupname stype,g.doc_no stypeid, d.description desc1, Equips item, qty, d.Amount, d.total,u.unit as unit,"
					+ "unitid,m.netamount,m.discount from "
					+ " cm_srvqotd d left join cm_srvqotm m on d.tr_no=m.tr_no left join my_groupvals g on(d.servid=g.doc_no and grptype='service') left join cm_servsited s on(s.rowno=d.sitesrno) left join my_unitm u on(u.doc_no=d.unitid)" 
					+" where d.tr_no="+doc_no+" and d.revision_no="+revision+"";
*/
			sql="select site,s.sr_no siteid,groupname stype,g.doc_no stypeid, d.description desc1, Equips proname, qty, d.Amount, total,u.unit as unit,unitid,d.revision_no,d.psrno, "
					+ "Equips product,d.scopeid,d.scopeamount,d.stdprice,d.lbrchg,d.scopestdcost,sp.scode scope from "
					+ "cm_srvqotd d left join my_groupvals g on(d.servid=g.doc_no and grptype='service') left join cm_servsited s on(s.rowno=d.sitesrno) "
					+ "left join my_unitm u on(u.doc_no=d.unitid) left join my_scope sp on sp.doc_no=d.scopeid where d.tr_no='"+doc_no+"' and d.revision_no='"+revision+"'";

			//System.out.println("===quotGridLoad===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}
	public JSONArray searchClient(HttpSession session,String clname,String mob,int id) throws SQLException {


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


		String sqltest="";

		if(!(clname.equalsIgnoreCase("undefined"))&&!(clname.equalsIgnoreCase(""))&&!(clname.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and refname like '%"+clname+"%'";
		}
		if(!(mob.equalsIgnoreCase("undefined"))&&!(mob.equalsIgnoreCase(""))&&!(mob.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and per_mob like '%"+mob+"%'";
		}


		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmtVeh1 = conn.createStatement ();

			if(id>0){
			String clsql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM'  " +sqltest);

			ResultSet resultSet = stmtVeh1.executeQuery(clsql);

			RESULTDATA=com.convertToJSON(resultSet);
			stmtVeh1.close();
			conn.close();
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public JSONArray unitSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select doc_no,unit,unit_desc from my_unitm where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=com.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray scopeSearch(HttpSession session,String scopegroup) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
        String sqltest="";
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();
			if(!(scopegroup.equals("0") || scopegroup.equals("") || scopegroup.equals("undefined"))){
				sqltest=" and groupid='"+scopegroup+"'";
			}
			String sql="select doc_no,scode,sname,product from my_scope where status=3 "+sqltest+"";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=com.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	
	public JSONArray quotSubGridLoad(HttpSession session,String trno) throws SQLException{

		//System.out.println(doc_no);
				JSONArray RESULTDATA1=new JSONArray();

				Connection conn=null;
				try {
					conn = conobj.getMyConnection();
					Statement stmt = conn.createStatement();

					String sql = "";

					/*sql="SELECT d.description desc1,m.part_no productid,m.productname, d.rowno,d.tr_no,d.qty qty,d.costprice amount, "
							+ "d.total total,d.profitper margin,d.nettotal,m.psrno,m.psrno pid,m.psrno prodoc,m.part_no productid,m.productname, "
							+ "d.unitid as unitdocno,at.mspecno specid,mp.brhid,mp.tr_no activityid, "
							+ "prd.locid,prd.stkqty,if(prd.stkqty>d.qty,d.qty,prd.stkqty) resqty,d.qty-if(prd.stkqty>d.qty,d.qty,prd.stkqty) purqty, "
							+ "u.unit unit,grp.groupname sertype,jobtype as activity , bd.brandname,d.site,d.sertypeid stypeid,d.sitesrno,m.productname product,m.productname proname,bd.brandname brand "
							+ "FROM cm_estmprdd d left join cm_prjestm est on est.tr_no=d.tr_no "
							+ "left join gl_enqm enq on enq.doc_no=est.refdocno left join cm_srvqotm qot on qot.tr_no=enq.qottrno "
							+ "left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no) "
							+ "left join my_prodattrib at on(at.mpsrno=m.doc_no) "
							+ "left join cm_prjmaster mp  on(mp.tr_no=d.activityid) "
							+ "left join (select psrno,brhid,locid,sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty from my_prddin group by psrno,brhid ) "
							+ "prd on prd.psrno=d.psrno and prd.brhid=mp.brhid "
							+ "left join my_unitm u on d.unitid=u.doc_no "
							+ "left join my_groupvals grp on grp.doc_no=d.sertypeid and grp.grptype='service' "
							+ "left join  my_brand bd on m.brandid=bd.doc_no "
							+ " where qot.tr_no="+trno+"; ";*/
					
					sql="SELECT d.rowno,d.tr_no,m.psrno,m.psrno pid,m.psrno prodoc,at.mspecno specid,est.brhid,m.part_no productid,m.productname,d.qty qty,d.costprice amount,"
							+ "d.total total,d.profitper margin,d.nettotal,d.description desc1,d.scopeid,d.stdprice,d.scopeamount,sp.scode scope,coalesce(sp.product,1) scopeproduct,"
							+ "d.lbrchg,d.scopestdcost,d.unitid as unitdocno,0 activityid,bd.brandname,d.site,d.sertypeid stypeid,grp.groupname sertype,m.stdprice,d.marginper,m.productname proname,"
							+ "m.productname product,u.unit unit,bd.brandname brand,d.sitesrno "
							+ "FROM cm_estmprdd d left join cm_prjestm est on est.tr_no=d.tr_no left join gl_enqm enq on enq.doc_no=est.reftrno left join CM_SRVDETM srv on srv.tr_no=est.reftrno left join cm_srvqotm qot on ((qot.tr_no=enq.qottrno  and qot.ref_type='enq') or (qot.refdocno=srv.tr_no  and qot.ref_type='SRVE'))  and qot.ref_type=est.ref_type  "
							+ "left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no) left join my_scope sp on sp.doc_no=d.scopeid left join my_prodattrib at on(at.mpsrno=m.doc_no) "
							+ "left join my_unitm u on d.unitid=u.doc_no left join my_groupvals grp on grp.doc_no=d.sertypeid and grp.grptype='service' left join  my_brand bd on m.brandid=bd.doc_no "
							+ " where qot.tr_no="+trno+"";

//					 System.out.println("===quotSubGridLoad===="+sql);

					ResultSet resultSet1 = stmt.executeQuery(sql);
					RESULTDATA1=com.convertToJSON(resultSet1);

				}
				catch(Exception e){
					e.printStackTrace();
				}
				finally{
					conn.close();
				}


				return RESULTDATA1;
			}
	
	public JSONArray quotSubScopeGroupChangeGridLoad(HttpSession session,String trno,String scopegroup) throws SQLException{

		//System.out.println(doc_no);
				JSONArray RESULTDATA1=new JSONArray();

				Connection conn=null;
				try {
					conn = conobj.getMyConnection();
					Statement stmt = conn.createStatement();

					String sql = "";

					sql="SELECT d.rowno,d.tr_no,m.psrno,m.psrno pid,m.psrno prodoc,at.mspecno specid,est.brhid,m.part_no productid,m.productname,d.qty qty,"
							+ "if(coalesce(sp.product,1)=1,coalesce(m.fixingprice ,0),0) amount,((d.qty*if(coalesce(sp.product,1)=1,coalesce(m.fixingprice ,0),0))+(d.qty*coalesce(spr.fprice,0))) total,"
							+ "d.profitper margin,(((d.qty*if(coalesce(sp.product,1)=1,coalesce(m.fixingprice ,0),0))+(d.qty*coalesce(spr.fprice,0)))+(coalesce(d.profitper,0))) nettotal,d.description desc1,"
							+ "6 scopeid,if(coalesce(sp.product,1)=1,m.stdprice,0) stdprice,coalesce(spr.fprice,0) scopeamount,sp.scode scope,coalesce(sp.product,1) scopeproduct,coalesce(m.lbrchg,0) lbrchg,"
							+ "coalesce(spr.stdcost,0) scopestdcost,d.unitid as unitdocno,0 activityid,bd.brandname,d.site,d.sertypeid stypeid,grp.groupname sertype,m.stdprice,d.marginper,m.productname proname,"
							+ "m.productname product,u.unit unit,bd.brandname brand,d.sitesrno FROM cm_estmprdd d left join cm_prjestm est on est.tr_no=d.tr_no "
							+ "left join gl_enqm enq on enq.doc_no=est.refdocno left join cm_srvqotm qot on qot.tr_no=enq.qottrno "
							+ "left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no) left join my_scope sp on sp.doc_no=6 "
							+ "left join my_scopepr spr on spr.psrno=m.psrno and scpid=6 left join my_prodattrib at on(at.mpsrno=m.doc_no) "
							+ "left join my_unitm u on d.unitid=u.doc_no "
							+ "left join my_groupvals grp on grp.doc_no=d.sertypeid and grp.grptype='service' "
							+ "left join  my_brand bd on m.brandid=bd.doc_no "
							+ " where qot.tr_no="+trno+"";

					//System.out.println("===quotSubScopeGroupChangeGridLoad===="+sql);

					ResultSet resultSet1 = stmt.executeQuery(sql);
					RESULTDATA1=com.convertToJSON(resultSet1);

				}
				catch(Exception e){
					e.printStackTrace();
				}
				finally{
					conn.close();
				}


				return RESULTDATA1;
			}

	public JSONArray searchProduct(HttpSession session,String clientid,String date,String brcid,String prdname,String brandname,String id,String gridunit,String gridprdname,String scopeid,String servicetypeid) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		
		if(!(id.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
		
		Connection conn = null;

		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement (); 
			String sql="";
			int method=0;
			java.sql.Date estdate=null;
			String sqltest="";
/*System.out.println(clientid+"=="+date);
			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sqltest=" and x.cldocno in ("+clientid+")";
			}
		*/	

			if(!(date.equals("0") || date.equals("") || date.equals("undefined"))){
				estdate=com.changeStringtoSqlDate(date);
				
			}


			String condtn="";
			
			if(!(prdname.equalsIgnoreCase(""))&&!(prdname.equalsIgnoreCase("undefined"))&&!(prdname.equalsIgnoreCase("0"))){
				condtn ="  and m.part_no like '%"+prdname+"%' ";
			}
			
			if(!(brandname.equalsIgnoreCase(""))&&!(brandname.equalsIgnoreCase("undefined"))&&!(brandname.equalsIgnoreCase("0"))){
				condtn +="  and brd.brandname like '%"+brandname+"%' ";
			}
			
			gridprdname=gridprdname.replaceAll("@","%");
			if(!(gridprdname.equalsIgnoreCase(""))&&!(gridprdname.equalsIgnoreCase("undefined"))&&!(gridprdname.equalsIgnoreCase("0"))){
				condtn +="  and m.productname like '%"+gridprdname+"%' ";
			}
			
			if(!(gridunit.equalsIgnoreCase(""))&&!(gridunit.equalsIgnoreCase("undefined"))&&!(gridunit.equalsIgnoreCase("0"))){
				condtn +="  and u.unit like '%"+gridunit+"%' ";
			}
			
           String strSql = "select method from gl_config where field_nme='srvcPreSalesScope'";
   		   ResultSet rs = stmt.executeQuery(strSql);
   		
   		   String srvcPreSalesScope="";
   		   while(rs.next()) {
   			   srvcPreSalesScope=rs.getString("method");
   		   } 
   		   
   		   String strSql1 = "select method from gl_config where field_nme='srvcProductBranchAvailability'";
		   ResultSet rs1 = stmt.executeQuery(strSql1);
		
		   String srvcProductBranchAvailability="";
		   while(rs1.next()) {
			   srvcProductBranchAvailability=rs1.getString("method");
		   } 
   		
   		   if(srvcPreSalesScope.equalsIgnoreCase("1")) {
   			   
   			   if(!(servicetypeid.equalsIgnoreCase(""))&&!(servicetypeid.equalsIgnoreCase("undefined"))&&!(servicetypeid.equalsIgnoreCase("0"))){
   				   condtn +="  and c.link in (0,"+servicetypeid+") ";
   			   } else {
   				   condtn +="  and c.link in (0) ";
   			   }
   			   
   			   if(srvcProductBranchAvailability.equalsIgnoreCase("1")) {
   			
   				   sql="select at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,coalesce(m.fixingprice ,0) amount, "
   						   + "coalesce(m.lbrchg,0) lbrchg,brd.brandname,m.brandid,m.stdprice, coalesce(spr.fprice,0) scopefprice , coalesce(spr.stdcost,0) scopestdcost "
   						   + "from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) "
   						   + "left join my_brand brd on brd.doc_no=m.brandid left join my_scopepr spr on spr.psrno=m.psrno and scpid="+scopeid+" left join my_catm c on c.doc_no=m.catid "
   						   + "where m.status=3 "+condtn+" and if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"' group by m.psrno  order by m.psrno";
   			   } else {
   			   
   				   sql="select at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,coalesce(m.fixingprice ,0) amount, "
   						   + "coalesce(m.lbrchg,0) lbrchg,brd.brandname,m.brandid,m.stdprice, coalesce(spr.fprice,0) scopefprice , coalesce(spr.stdcost,0) scopestdcost "
   						   + "from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) "
   						   + "left join my_brand brd on brd.doc_no=m.brandid left join my_scopepr spr on spr.psrno=m.psrno and scpid="+scopeid+" left join my_catm c on c.doc_no=m.catid "
   						   + "where m.status=3 "+condtn+"  group by m.psrno  order by m.psrno";
   			   }
   		   } else {
   			   
   			   if(srvcProductBranchAvailability.equalsIgnoreCase("1")) {
   				   
   					sql="select at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno, "
   							+ " round(case when '"+estdate+"' BETWEEN cfr.frmdate and cfr.todate then cfr.ofrprice else m.fixingprice end,2) as amount,"
   							+ "brd.brandname,m.brandid,m.stdprice from my_main m left join my_unitm u on m.munit=u.doc_no "
   							+ "left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) left join my_brand brd on brd.doc_no=m.brandid "
   							+ "left join my_clientoffer cfr on cfr.psrno=m.psrno and cfr.cldocno="+clientid+" and '"+estdate+"' BETWEEN cfr.frmdate and cfr.todate "
   							+ "where m.status=3  "+condtn+" and if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"'  group by m.psrno  order by m.psrno ";
   					
   			   } else {
   				   
   				   sql="select at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno, "
							+ " round(case when '"+estdate+"' BETWEEN cfr.frmdate and cfr.todate then cfr.ofrprice else m.fixingprice end,2) as amount,"
							+ "brd.brandname,m.brandid,m.stdprice from my_main m left join my_unitm u on m.munit=u.doc_no "
							+ "left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_brand brd on brd.doc_no=m.brandid "
							+ "left join my_clientoffer cfr on cfr.psrno=m.psrno and cfr.cldocno="+clientid+" and '"+estdate+"' BETWEEN cfr.frmdate and cfr.todate "
							+ "where m.status=3  "+condtn+"  group by m.psrno  order by m.psrno ";
   				
   			   }
   		   }

			/*sql="select at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno "
					+ "from my_main m left join my_unitm u on m.munit=u.doc_no "
					+ "left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) "
					+ "where m.status=3 and de.brhid='"+session.getAttribute("BRANCHID").toString()+"'  group by m.psrno  order by m.psrno ";*/


//					System.out.println("----searchProduct-sql---"+sql);

			ResultSet resultSet = stmt.executeQuery (sql);
			RESULTDATA=com.convertToJSON(resultSet);
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
	
	public   JSONArray searchProductqot(HttpSession session,String prodsearchtype,String rdoc,String reftype,String clientid,String date,
			String prdname,String brandname,String id,String gridunit,String gridprdname,String scopeid,String servicetypeid) throws SQLException {

			JSONArray RESULTDATA=new JSONArray();
			
			if(!(id.equalsIgnoreCase("1"))){
				return RESULTDATA;
			}
			
			Connection conn = null;

			try {
				conn = conobj.getMyConnection();
				Statement stmt = conn.createStatement (); 
				String sql="";
				int method=0;
				java.sql.Date estdate=null;
				String sqltest="";
	/*System.out.println(clientid+"=="+date);
				if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
					sqltest=" and x.cldocno in ("+clientid+")";
				}
			*/	

				if(!(date.equals("0") || date.equals("") || date.equals("undefined"))){
					estdate=com.changeStringtoSqlDate(date);
					
				}


				String condtn="";
				String brcid=session.getAttribute("BRANCHID").toString();
				
				if(!(prdname.equalsIgnoreCase(""))&&!(prdname.equalsIgnoreCase("undefined"))&&!(prdname.equalsIgnoreCase("0"))){
					condtn ="  and m.part_no like '%"+prdname+"%' ";
				}
				
				if(!(brandname.equalsIgnoreCase(""))&&!(brandname.equalsIgnoreCase("undefined"))&&!(brandname.equalsIgnoreCase("0"))){
					condtn +="  and brd.brandname like '%"+brandname+"%' ";
				}
				
				gridprdname=gridprdname.replaceAll("@","%");
				if(!(gridprdname.equalsIgnoreCase(""))&&!(gridprdname.equalsIgnoreCase("undefined"))&&!(gridprdname.equalsIgnoreCase("0"))){
					condtn +="  and m.productname like '%"+gridprdname+"%' ";
				}
				
				if(!(gridunit.equalsIgnoreCase(""))&&!(gridunit.equalsIgnoreCase("undefined"))&&!(gridunit.equalsIgnoreCase("0"))){
					condtn +="  and u.unit like '%"+gridunit+"%' ";
				}
				
	           String strSql = "select method from gl_config where field_nme='srvcPreSalesScope'";
	   		   ResultSet rs = stmt.executeQuery(strSql);
	   		
	   		   String srvcPreSalesScope="";
	   		   while(rs.next()) {
	   			   srvcPreSalesScope=rs.getString("method");
	   		   } 
	   		   
	   		   String strSql1 = "select method from gl_config where field_nme='srvcProductBranchAvailability'";
			   ResultSet rs1 = stmt.executeQuery(strSql1);
			
			   String srvcProductBranchAvailability="";
			   while(rs1.next()) {
				   srvcProductBranchAvailability=rs1.getString("method");
			   } 
	   		
	   		   if(srvcPreSalesScope.equalsIgnoreCase("1")) {
	   			   
	   			   if(!(servicetypeid.equalsIgnoreCase(""))&&!(servicetypeid.equalsIgnoreCase("undefined"))&&!(servicetypeid.equalsIgnoreCase("0"))){
	   				   condtn +="  and c.link in (0,"+servicetypeid+") ";
	   			   } else {
	   				   condtn +="  and c.link in (0) ";
	   			   }
	   			   
	   			   if(srvcProductBranchAvailability.equalsIgnoreCase("1")) {
	   			
	   				   sql="select at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,coalesce(m.fixingprice ,0) amount, "
	   						   + "coalesce(m.lbrchg,0) lbrchg,brd.brandname,m.brandid,m.stdprice, coalesce(spr.fprice,0) scopefprice , coalesce(spr.stdcost,0) scopestdcost "
	   						   + "from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) "
	   						   + "left join my_brand brd on brd.doc_no=m.brandid left join my_scopepr spr on spr.psrno=m.psrno and scpid="+scopeid+" left join my_catm c on c.doc_no=m.catid "
	   						   + "where m.status=3 "+condtn+" and if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"' group by m.psrno  order by m.psrno";
	   			   } else {
	   			   
	   				   sql="select at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,coalesce(m.fixingprice ,0) amount, "
	   						   + "coalesce(m.lbrchg,0) lbrchg,brd.brandname,m.brandid,m.stdprice, coalesce(spr.fprice,0) scopefprice , coalesce(spr.stdcost,0) scopestdcost "
	   						   + "from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) "
	   						   + "left join my_brand brd on brd.doc_no=m.brandid left join my_scopepr spr on spr.psrno=m.psrno and scpid="+scopeid+" left join my_catm c on c.doc_no=m.catid "
	   						   + "where m.status=3 "+condtn+"  group by m.psrno  order by m.psrno";
	   			   }
	   		   } else {
	   			   
	   			   if(srvcProductBranchAvailability.equalsIgnoreCase("1")) {
	   				   
	   					sql="select at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno, "
	   							+ " round(case when '"+estdate+"' BETWEEN cfr.frmdate and cfr.todate then cfr.ofrprice else m.fixingprice end,2) as amount,"
	   							+ "brd.brandname,m.brandid,m.stdprice from my_main m left join my_unitm u on m.munit=u.doc_no "
	   							+ "left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) left join my_brand brd on brd.doc_no=m.brandid "
	   							+ "left join my_clientoffer cfr on cfr.psrno=m.psrno and cfr.cldocno="+clientid+" and '"+estdate+"' BETWEEN cfr.frmdate and cfr.todate "
	   							+ "where m.status=3  "+condtn+" and if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"'  group by m.psrno  order by m.psrno ";
	   					
	   			   } else {
	   				   
	   				   sql="select at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno, "
								+ " round(case when '"+estdate+"' BETWEEN cfr.frmdate and cfr.todate then cfr.ofrprice else m.fixingprice end,2) as amount,"
								+ "brd.brandname,m.brandid,m.stdprice from my_main m left join my_unitm u on m.munit=u.doc_no "
								+ "left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_brand brd on brd.doc_no=m.brandid "
								+ "left join my_clientoffer cfr on cfr.psrno=m.psrno and cfr.cldocno="+clientid+" and '"+estdate+"' BETWEEN cfr.frmdate and cfr.todate "
								+ "where m.status=3  "+condtn+"  group by m.psrno  order by m.psrno ";
	   				
	   			   }
	   		   }

				/*sql="select at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno "
						+ "from my_main m left join my_unitm u on m.munit=u.doc_no "
						+ "left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) "
						+ "where m.status=3 and de.brhid='"+session.getAttribute("BRANCHID").toString()+"'  group by m.psrno  order by m.psrno ";*/


					//	System.out.println("----searchProduct-sql---"+sql);

				ResultSet resultSet = stmt.executeQuery (sql);
				RESULTDATA=com.convertToJSON(resultSet);
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
		
	public JSONArray siteSearch(HttpSession session,String trno) throws SQLException{

//System.out.println("trno"+trno);
		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select  site,rowno refrowno from  cm_servsited d  where tr_no="+trno+" ";



				//	System.out.println("===sql===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}
	

	public JSONArray serviceType(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select groupname stype,codeno,doc_no docno from my_groupvals where grptype='service' and status=3";



			//			System.out.println("===sql===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}

	public JSONArray serviceSearch(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select groupname stype,codeno,doc_no docno from my_groupvals where grptype='service' and status=3";



			//			System.out.println("===sql===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}

	public JSONArray siteGridLoad(HttpSession session,String doc_no) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			String brhid=session.getAttribute("BRANCHID").toString();

			/*sql="select  groupname area,g.doc_no areaid,site,d.rowno  from  cm_servsited  d left join my_groupvals g on(d.areaid=g.doc_no and grptype='area') "
					+ " where tr_no='"+doc_no+"'";*/   

			sql="select  groupname area,g.doc_no areaid,site,d.rowno  from  cm_servsited  d left join my_groupvals g on(d.areaid=g.grpno and grptype='area') "
					+ " where tr_no='"+doc_no+"'";
			//System.out.println("===sql==siteGridLoad=="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}
	
	public JSONArray areaSearch(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select groupname area,codeno,doc_no areadocno from my_groupvals where grptype='area' and status=3";


			//			System.out.println("===sql===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

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
