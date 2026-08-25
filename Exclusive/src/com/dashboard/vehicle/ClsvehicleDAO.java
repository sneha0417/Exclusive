package com.dashboard.vehicle;

 import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

    import net.sf.json.JSONArray;

    import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.dashboard.ClsDashBoardBean;

public class ClsvehicleDAO  { 
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray searchVehDeatails(String brnchval) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
       
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				//String sql="";
				//ResultSet resultSet ;
				//System.out.println("========="+brnchval);
            	if(brnchval.equalsIgnoreCase("a"))
            	{
            		//String sql="select ST.ST_DESC,count(*) VALUE,VEH.tran_code from gl_vehmaster VEH LEFT JOIN GL_STATUS ST ON  (VEH.tran_code=ST.STATUS) where VEH.statu=3  and VEH.fstatus<>'Z' GROUP BY VEH.tran_code ";
           
            		String sql="select * from (select ST.ST_DESC,convert(count(*),char(10)) VALUE,VEH.tran_code from gl_vehmaster VEH  	LEFT JOIN GL_STATUS ST ON\r\n" + 
            				"   (VEH.tran_code=ST.STATUS) where VEH.statu=3	and VEH.fstatus<>'Z' GROUP BY VEH.tran_code) aa\r\n" + 
            				" 	union all (select 'All' ST_DESC, convert('',char(10)) VALUE,'KK' tran_code) ";
            		
//            			System.out.println("----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            	}
            	else{				 
            		/*String sql= ("select ST.ST_DESC,count(*) VALUE,VEH.tran_code from gl_vehmaster VEH "
					+ "LEFT JOIN GL_STATUS ST ON(VEH.tran_code=ST.STATUS)  where VEH.a_br='"+brnchval+"' and  VEH.statu=3  and VEH.fstatus<>'Z' GROUP BY VEH.tran_code ");*/
            		String sql="select * from (select ST.ST_DESC,convert(count(*),char(10)) VALUE,VEH.tran_code from gl_vehmaster VEH  	LEFT JOIN GL_STATUS ST ON\r\n" + 
            				"   (VEH.tran_code=ST.STATUS) where VEH.statu=3	and VEH.fstatus<>'Z' and VEH.a_br='"+brnchval+"' GROUP BY VEH.tran_code) aa\r\n" + 
            				" 	union all (select 'All' ST_DESC,  convert('',char(10)) VALUE,'KK' tran_code)";
            		
            	/*	String sql="select * from (select 'All' ST_DESC,  count(*) VALUE,'' from gl_vehmaster where statu=3 and fstatus<>'Z' and a_br='"+brnchval+"') aa   "
            				+ "	union all (select ST.ST_DESC,count(*) VALUE,VEH.tran_code from gl_vehmaster VEH  "
            				+ "	LEFT JOIN GL_STATUS ST ON  (VEH.tran_code=ST.STATUS) where VEH.statu=3	and VEH.fstatus<>'Z' and VEH.a_br='"+brnchval+"' GROUP BY VEH.tran_code) ";

            		*/
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
	
	public JSONArray searchAviveh(String tran,String chkdatails,String brch) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection(); 
				Statement stmtVeh1 = conn.createStatement ();
				
				String sqlbrch="",sql="";
				if(!brch.equalsIgnoreCase("a")){
					sqlbrch=" and m.a_br='"+brch+"' ";
				            }
				
			
				if(tran.equalsIgnoreCase("IN")){
					sql= " left  join   (select max(doc_no) maxd,fleet_no from gl_vmove group by fleet_no) a "
							+ " on vm.doc_no=a.maxd and vm.fleet_no=a.fleet_no ";
								
				}
				else{
					sql= " inner join (select max(doc_no) maxd,fleet_no from gl_vmove group by fleet_no) a "
							+ " on vm.doc_no=a.maxd and vm.fleet_no=a.fleet_no ";
							
				}
				
			
			if(chkdatails.equalsIgnoreCase("search"))	// this used for detail search
			{
				
				String sqldata=("select g1.name grname,convert((SELECT DATEDIFF(m.ins_exp,curdate())),char(20)) AS days, "
						+ " CASE  WHEN vm.emp_type='CRM' THEN (select refname from my_acbook where cldocno=vm.emp_id and dtype='CRM')   "
        	 		   + " WHEN vm.emp_type='DRV' THEN (select sal_name from my_salesman where doc_no=vm.emp_id and sal_type='DRV') "
        	 		    + " WHEN vm.emp_type='STF' THEN (select sal_name from my_salesman where doc_no=vm.emp_id and sal_type='STF')   END as 'empname'   "
        	 		    + " ,vm.doc_no,vm.emp_type empid,br.branchname,m.FLEET_NO,m.FLNAME,m.REG_NO,vm.kmin CUR_KM,m.SRVC_KM+m.lst_srv SRVC_KM,y.YOM,m.renttype renttype, "
						+ "  CASE WHEN vm.fin='0.000' THEN 'Level 0/8' WHEN vm.fin='0.125' THEN 'Level 1/8' WHEN vm.fin='0.250'  "
						+ "    THEN 'Level 2/8' WHEN vm.fin='0.375'  THEN 'Level 3/8' WHEN vm.fin='0.500' THEN 'Level 4/8' "
						+ "     WHEN vm.fin='0.625' THEN 'Level 5/8'  WHEN vm.fin='0.750' THEN 'Level 6/8' WHEN vm.fin='0.875' "
						+ "  THEN 'Level 7/8' WHEN vm.fin='1.000' THEN 'Level 8/8'   END as 'C_FUEL', "
						+ " l.LOC_NAME,g.gname,c.color,b.brand_name from gl_vehmaster m left join my_locm l on l.doc_no=m.A_LOC "
						+ " left join gl_vehgroup g on g.doc_no=m.VGRPID  left join my_color c on(m.clrid=c.doc_no) "
						+ " left join gl_vehbrand b on(m.brdid=b.doc_no) left join my_brch br on br.doc_no=m.a_br "
						+ " left join gl_yom y on y.doc_no=m.yom "
						+"   left join gl_vmove vm on vm.fleet_no=m.fleet_no "+sql					
						+ "    left join gl_nrm nr on nr.doc_no=vm.rdocno and vm.rdtype='MOV'  and m.tran_code like 'G%'  "
                        + "         left join gl_garrage g1 on g1.doc_no=nr.garageid "
						+ "  where  m.tran_code='"+tran+"' and m.statu=3 and m.fstatus<>'Z' " +sqlbrch);
				
			//	System.out.println("------1-------"+sqldata);

			ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtVeh1.close();
				
			}
			else
			{
				
				String sqldata=("select g1.name grname,convert((SELECT DATEDIFF(m.ins_exp,curdate())),char(20)) AS days,br.branchname,m.FLEET_NO,m.FLNAME,m.REG_NO,m.SRVC_KM+m.lst_srv SRVC_KM,y.YOM,m.renttype renttype,  "
						+ "  coalesce(vm.kmin,vm.kmout ) CUR_KM ,CASE WHEN\r\n" + 
						" coalesce(vm.fin,vm.fout)='0.000' THEN\r\n" + 
						" 'Level 0/8' WHEN coalesce(vm.fin,vm.fout)='0.125' THEN 'Level 1/8' WHEN coalesce(vm.fin,vm.fout)='0.250'      THEN 'Level 2/8'\r\n" + 
						" WHEN coalesce(vm.fin,vm.fout)='0.375'  THEN\r\n" + 
						" 'Level 3/8' WHEN coalesce(vm.fin,vm.fout)='0.500' THEN 'Level 4/8'      WHEN coalesce(vm.fin,vm.fout)='0.625' THEN 'Level 5/8'  WHEN coalesce(vm.fin,vm.fout)='0.750' THEN\r\n" + 
						" 'Level 6/8' WHEN coalesce(vm.fin,vm.fout)='0.875'   THEN 'Level 7/8' WHEN coalesce(vm.fin,vm.fout)='1.000' THEN 'Level 8/8'  END as 'C_FUEL',l.LOC_NAME,g.gname,c.color,b.brand_name"
						+ " from gl_vehmaster m left join my_locm l on l.doc_no=m.A_LOC  left join gl_vehgroup g on g.doc_no=m.VGRPID "
						+ " left join my_color c on(m.clrid=c.doc_no) 	left join gl_vehbrand b on(m.brdid=b.doc_no) left join my_brch br on br.doc_no=m.a_br "
						+ " left join gl_yom y on y.doc_no=m.yom "
						+ "   left join gl_vmove vm on vm.fleet_no=m.fleet_no "+sql
						+ "    left join gl_nrm nr on nr.doc_no=vm.rdocno and vm.rdtype='MOV'  and m.tran_code like 'G%'  "
						+ "         left join gl_garrage g1 on g1.doc_no=nr.garageid "
						+ " where  m.tran_code='"+tran+"' and m.statu=3 and m.fstatus<>'Z' "+sqlbrch);
 			//	System.out.println("------2-------"+sqldata);
				ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtVeh1.close();
		//System.out.println("------2-------"+sqldata);
			}
				
				
				
				
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
	
	
 
	
	public JSONArray searchAvivehexcel(String tran,String chkdatails,String brch) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection(); 
				Statement stmtVeh1 = conn.createStatement ();
				
				String sqlbrch="",sql="";
				if(!brch.equalsIgnoreCase("a")){
					sqlbrch=" and m.a_br='"+brch+"' ";
				            }
				
			
				if(tran.equalsIgnoreCase("IN")){
					sql= " left  join   (select max(doc_no) maxd,fleet_no from gl_vmove group by fleet_no) a "
							+ " on vm.doc_no=a.maxd and vm.fleet_no=a.fleet_no ";
								
				}
				else{
					sql= " inner join (select max(doc_no) maxd,fleet_no from gl_vmove group by fleet_no) a "
							+ " on vm.doc_no=a.maxd and vm.fleet_no=a.fleet_no ";
							
				}
				
			
			if(chkdatails.equalsIgnoreCase("search"))	// this used for detail search
			{
				
 
				
				
				String sqldata="	select br.branchname 'Avial.Br',l.LOC_NAME ,m.FLEET_NO 'Fleet',m.FLNAME 'Fleet Name',vm.emp_type 'Type',"
						+ " CASE  WHEN vm.emp_type='CRM' THEN (select refname from my_acbook where cldocno=vm.emp_id and dtype='CRM')   \r\n" + 
						 " WHEN vm.emp_type='DRV' THEN (select sal_name from my_salesman where doc_no=vm.emp_id and sal_type='DRV') \r\n" + 
						" WHEN vm.emp_type='STF' THEN (select sal_name from my_salesman where doc_no=vm.emp_id and sal_type='STF')   END as 'User Name'   \r\n" + 
						" ,\r\n" + 
						"	g.gname 'Group',c.Color,m.REG_NO,y.YOM,\r\n" + 
						"	  coalesce(vm.kmin,vm.kmout ) CUR_KM ,\r\n" + 
						"	  m.SRVC_KM+m.lst_srv 'Due Serv. KM',CASE WHEN\r\n" + 
						"	 coalesce(vm.fin,vm.fout)='0.000' THEN\r\n" + 
						"	 'Level 0/8' WHEN coalesce(vm.fin,vm.fout)='0.125' THEN 'Level 1/8' WHEN coalesce(vm.fin,vm.fout)='0.250'      THEN 'Level 2/8'\r\n" + 
						"	 WHEN coalesce(vm.fin,vm.fout)='0.375'  THEN\r\n" + 
						"	 'Level 3/8' WHEN coalesce(vm.fin,vm.fout)='0.500' THEN 'Level 4/8'      WHEN coalesce(vm.fin,vm.fout)='0.625' THEN 'Level 5/8'  WHEN coalesce(vm.fin,vm.fout)='0.750' THEN\r\n" + 
						"	 'Level 6/8' WHEN coalesce(vm.fin,vm.fout)='0.875'   THEN 'Level 7/8' WHEN coalesce(vm.fin,vm.fout)='1.000' THEN 'Level 8/8'\r\n" + 
						"	 END as 'C_FUEL',m.renttype  from gl_vehmaster m left join my_locm l on l.doc_no=m.A_LOC\r\n" + 
						"	  left join gl_vehgroup g on g.doc_no=m.VGRPID  left join my_color c on(m.clrid=c.doc_no) 	left join gl_vehbrand b\r\n" + 
						"	   on(m.brdid=b.doc_no) left join my_brch br on br.doc_no=m.a_br  left join gl_yom y on y.doc_no=m.yom\r\n" + 
						"	     left join gl_vmove vm on vm.fleet_no=m.fleet_no   "+sql+"    "
								+ "left join gl_nrm nr on nr.doc_no=vm.rdocno and vm.rdtype='MOV'  and m.tran_code like 'G%'\r\n" + 
						"	          left join gl_garrage g1 on g1.doc_no=nr.garageid  where  m.tran_code='"+tran+"' and m.statu=3 and m.fstatus<>'Z' " +sqlbrch;
				
				
 		//	System.out.println("------1-------"+sqldata);

			ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtVeh1.close();
				
			}
			else
			{
				

				
				
				String sqldata="	select br.branchname 'Avial.Br',l.LOC_NAME,m.FLEET_NO 'Fleet',m.FLNAME 'Fleet Name',\r\n" + 
						"	g.gname 'Group',c.Color,m.REG_NO,y.YOM,\r\n" + 
						"	  coalesce(vm.kmin,vm.kmout ) CUR_KM ,\r\n" + 
						"	  m.SRVC_KM+m.lst_srv 'Due Serv. KM',CASE WHEN\r\n" + 
						"	 coalesce(vm.fin,vm.fout)='0.000' THEN\r\n" + 
						"	 'Level 0/8' WHEN coalesce(vm.fin,vm.fout)='0.125' THEN 'Level 1/8' WHEN coalesce(vm.fin,vm.fout)='0.250'      THEN 'Level 2/8'\r\n" + 
						"	 WHEN coalesce(vm.fin,vm.fout)='0.375'  THEN\r\n" + 
						"	 'Level 3/8' WHEN coalesce(vm.fin,vm.fout)='0.500' THEN 'Level 4/8'      WHEN coalesce(vm.fin,vm.fout)='0.625' THEN 'Level 5/8'  WHEN coalesce(vm.fin,vm.fout)='0.750' THEN\r\n" + 
						"	 'Level 6/8' WHEN coalesce(vm.fin,vm.fout)='0.875'   THEN 'Level 7/8' WHEN coalesce(vm.fin,vm.fout)='1.000' THEN 'Level 8/8'\r\n" + 
						"	 END as 'C_FUEL',m.renttype  from gl_vehmaster m left join my_locm l on l.doc_no=m.A_LOC\r\n" + 
						"	  left join gl_vehgroup g on g.doc_no=m.VGRPID  left join my_color c on(m.clrid=c.doc_no) 	left join gl_vehbrand b\r\n" + 
						"	   on(m.brdid=b.doc_no) left join my_brch br on br.doc_no=m.a_br  left join gl_yom y on y.doc_no=m.yom\r\n" + 
						"	     left join gl_vmove vm on vm.fleet_no=m.fleet_no   "+sql+"    "
								+ "left join gl_nrm nr on nr.doc_no=vm.rdocno and vm.rdtype='MOV'  and m.tran_code like 'G%'\r\n" + 
						"	          left join gl_garrage g1 on g1.doc_no=nr.garageid  where  m.tran_code='"+tran+"' and m.statu=3 and m.fstatus<>'Z' " +sqlbrch;
				
				
				
 			//	System.out.println("------2-------"+sqldata);
				ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				stmtVeh1.close();
		//System.out.println("------2-------"+sqldata);
			}
				
				
				
				
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
	
	
	
	
	
	
	public JSONArray alldetailsSearchs(String cmbbranch,String chkdatails) throws SQLException { 

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement (); 
            
				if(chkdatails.equalsIgnoreCase("chk"))
				{
					
					
					String sqlbrch="";
					if(!cmbbranch.equalsIgnoreCase("a")){
						sqlbrch=" and m.a_br="+cmbbranch;
					            }
					
				
					//mov.
					String sqldata=" select  m.FLEET_NO 'Fleet NO ',a.AUTHname 'Authority', p.code_name 'Plate Code', m.REG_NO 'Reg_NO',m.FLNAME 'Fleet Name',\r\n" + 
							"g.gname 'Tariff Group',b.brand_name Brand,mo.vtype Model,s.st_desc Type,CASE WHEN movs.rdtype='RAG' THEN r.voc_no WHEN  movs.rdtype='LAG'\r\n" + 
							" THEN ll.voc_no else movs.rdocno  END as\r\n" + 
							"   'RDocno',CASE  WHEN movs.emp_type='CRM' THEN (select refname from my_acbook where cldocno=movs.emp_id and dtype='CRM')\r\n" + 
							"   WHEN movs.emp_type='DRV' THEN (select sal_name from my_salesman where doc_no=movs.emp_id and sal_type='DRV')\r\n" + 
							"    WHEN movs.emp_type='STF' THEN (select sal_name from my_salesman where doc_no=movs.emp_id and sal_type='STF')   END as 'Description',\r\n" + 
							"    y.YOM,c.Color ,convert(if(movs.status='OUT',round(movs.kmout),if(movs.status='IN',round(movs.kmin),m.cur_km)),char(40)) Currentkm,m.REG_DATE, m.INS_EXP,\r\n" + 
							"	m.PRCH_COST 'Purchase Cost',m.ADD1 'Additional Cost',m.tval 'Total cost' ,m.depr 'Depreciation %' , PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM curdate()),\r\n" + 
							"	EXTRACT( YEAR_MONTH FROM movs.din)) 'Age(months)', m.salik_tag 'Salik Tag'\r\n" + 
						 	"   from gl_vehmaster m left join gl_vehin i on(i.doc_no=m.INS_COMP) left join my_locm l on l.doc_no=m.a_loc left join\r\n" + 
							"   gl_yom y on y.doc_no=m.yom  left join my_brch brch on(brch.doc_no=m.a_br) left join gl_vehfin f on (m.finId=f.doc_no)\r\n" + 
							"   left join gl_vehauth a on (a.doc_no=m.authid)   left join gl_vehplate p on(p.doc_no=m.pltid) left join gl_vehgroup g\r\n" + 
							"   on g.doc_no=m.vgrpid left join gl_vehbrand b on b.doc_no=m.brdid left join gl_vehmodel mo on mo.doc_no=m.vmodid\r\n" + 
							"   left join my_vendorm v on v.doc_no=m.dlrid left join my_brch brch1 on(brch1.doc_no=m.brhid) left join my_color c\r\n" + 
							"   on(c.doc_no=m.clrid) "+
							"   left join gl_vmove movs on movs.fleet_no=m.fleet_no "
							+ " inner  join   (select max(doc_no) maxd,fleet_no from gl_vmove group by fleet_no) a "
							+ " on movs.doc_no=a.maxd and movs.fleet_no=a.fleet_no "
							+ "   left join gl_status s on m.tran_code=s.status\r\n" + 
							"   left join gl_ragmt r on  r.doc_no=movs.rdocno and movs.rdtype='RAG'\r\n" + 
							"   left join gl_lagmt ll on ll.doc_no=movs.rdocno and movs.rdtype='LAG'\r\n" + 
							"   where m.statu=3  and m.fstatus<>'Z'";

//System.out.println("======excel  ===== "+sqldata);
				ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				}
				stmtVeh1.close();
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
	
	
	
	
	
	
	
	
	public JSONArray alldetailsSearch(String cmbbranch,String chkdatails) throws SQLException { 

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement (); 
            
				if(chkdatails.equalsIgnoreCase("chk"))
				{
					
					
					String sqlbrch="";
					if(!cmbbranch.equalsIgnoreCase("a")){
						sqlbrch=" and m.a_br="+cmbbranch;
					            }
				
					String sqldata=" select  CASE  WHEN movs.emp_type='CRM' THEN (select refname from my_acbook where cldocno=movs.emp_id and dtype='CRM')\r\n" + 
							"   WHEN movs.emp_type='DRV' THEN (select sal_name from my_salesman where doc_no=movs.emp_id and sal_type='DRV')\r\n" + 
							"    WHEN movs.emp_type='STF' THEN (select sal_name from my_salesman where doc_no=movs.emp_id and sal_type='STF')   END as 'empname',\r\n" + 
							"    CASE WHEN movs.rdtype='RAG' THEN r.voc_no WHEN  movs.rdtype='LAG' THEN ll.voc_no else movs.rdocno  END as\r\n" + 
							"   'rdocno' ,s.st_desc,convert(if(movs.status='OUT',round(movs.kmout),if(movs.status='IN',round(movs.kmin),m.cur_km)),char(40)) currentkm,\r\n" + 
							" m.salik_tag,PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM curdate()),EXTRACT( YEAR_MONTH FROM movs.din)) age,\r\n" + 
							" m.DOC_NO,m.DATE,m.REG_NO,m.FLEET_NO,m.FLNAME,m.PRCH_INV,m.PRCH_DTE prch_dte,m.PRCH_COST,m.INST_AMT,m.INT_AMT,m.DN_PAY,\r\n" + 
							" i.inname INS_COMP, m.INS_AMT,m.PRMYM_PERC,m.PRMYM,m.INS_EXP,m.REL_DATE,m.REG_EXP,m.DEPR,m.ENG_NO,m.CH_NO,l.loc_name A_LOC,\r\n" + 
							" m.STATUS,  m.SRVC_KM+m.lst_srv SRVC_KM,m.SRVC_DTE,m.LST_SRV,m.WAR,m.WAR_KM,m.CUR_KM,\r\n" + 
							" m.ITYPE,m.ADD1,m.TVAL,m.VIN,m.C_FUEL,m.TRAN_CODE, y.YOM,m.REG_DATE,m.LPO,m.SALIK_TAG,m.PUR_TYPE,m.NO_INST,m.FSTATUS,\r\n" + 
							"  brch.branchname A_BR,m.WAR_PRD,m.CURR_VALUE,m.CATEGORY,m.renttype,m.dtype,m.comp_id,m.tcno,m.branded,\r\n" + 
							"  f.fname finname,a.AUTHname, p.code_name PLTname ,g.gname VGRPname,b.brand_name BRDname,mo.vtype VMODname,v.name\r\n" + 
							"  DLRname,brch1.branchname  BRHname,m.COSTID costname, c.color CLRname,m.WAREND,m.STATU,m.FUELTYPE,m.TCAP,m.cost,m.accdepr\r\n" + 
							"   from gl_vehmaster m left join gl_vehin i on(i.doc_no=m.INS_COMP) left join my_locm l on l.doc_no=m.a_loc left join\r\n" + 
							"   gl_yom y on y.doc_no=m.yom  left join my_brch brch on(brch.doc_no=m.a_br) left join gl_vehfin f on (m.finId=f.doc_no)\r\n" + 
							"   left join gl_vehauth a on (a.doc_no=m.authid)   left join gl_vehplate p on(p.doc_no=m.pltid) left join gl_vehgroup g\r\n" + 
							"   on g.doc_no=m.vgrpid left join gl_vehbrand b on b.doc_no=m.brdid left join gl_vehmodel mo on mo.doc_no=m.vmodid\r\n" + 
							"   left join my_vendorm v on v.doc_no=m.dlrid left join my_brch brch1 on(brch1.doc_no=m.brhid) left join my_color c\r\n" + 
							"   on(c.doc_no=m.clrid)  \r\n" + 
							"   left join gl_vmove movs on movs.fleet_no=m.fleet_no "
							+ " inner  join   (select max(doc_no) maxd,fleet_no from gl_vmove group by fleet_no) a "
							+ " on movs.doc_no=a.maxd and movs.fleet_no=a.fleet_no "+ 
							"   left join gl_status s on m.tran_code=s.status\r\n" + 
							"   left join gl_ragmt r on  r.doc_no=movs.rdocno and movs.rdtype='RAG'\r\n" + 
							"   left join gl_lagmt ll on ll.doc_no=movs.rdocno and movs.rdtype='LAG'\r\n" + 
							"   where m.statu=3  and m.fstatus<>'Z'";
					
					/**
					 * slow query vmove 2 connection removed 
					 * purchase date taken instead of release date 
					String sqldata=" select  CASE  WHEN movs.emp_type='CRM' THEN (select refname from my_acbook where cldocno=movs.emp_id and dtype='CRM')\r\n" + 
							"   WHEN movs.emp_type='DRV' THEN (select sal_name from my_salesman where doc_no=movs.emp_id and sal_type='DRV')\r\n" + 
							"    WHEN movs.emp_type='STF' THEN (select sal_name from my_salesman where doc_no=movs.emp_id and sal_type='STF')   END as 'empname',\r\n" + 
							"    CASE WHEN movs.rdtype='RAG' THEN r.voc_no WHEN  movs.rdtype='LAG' THEN ll.voc_no else movs.rdocno  END as\r\n" + 
							"   'rdocno' ,s.st_desc,convert(if(mov.status='OUT',round(mov.kmout),if(mov.status='IN',round(mov.kmin),m.cur_km)),char(40)) currentkm,\r\n" + 
							" m.salik_tag,PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM curdate()),EXTRACT( YEAR_MONTH FROM vv.din)) age,\r\n" + 
							" m.DOC_NO,m.DATE,m.REG_NO,m.FLEET_NO,m.FLNAME,m.PRCH_INV,m.PRCH_DTE prch_dte,m.PRCH_COST,m.INST_AMT,m.INT_AMT,m.DN_PAY,\r\n" + 
							" i.inname INS_COMP, m.INS_AMT,m.PRMYM_PERC,m.PRMYM,m.INS_EXP,m.REL_DATE,m.REG_EXP,m.DEPR,m.ENG_NO,m.CH_NO,l.loc_name A_LOC,\r\n" + 
							" m.STATUS,  m.SRVC_KM+m.lst_srv SRVC_KM,m.SRVC_DTE,m.LST_SRV,m.WAR,m.WAR_KM,m.CUR_KM,\r\n" + 
							" m.ITYPE,m.ADD1,m.TVAL,m.VIN,m.C_FUEL,m.TRAN_CODE, y.YOM,m.REG_DATE,m.LPO,m.SALIK_TAG,m.PUR_TYPE,m.NO_INST,m.FSTATUS,\r\n" + 
							"  brch.branchname A_BR,m.WAR_PRD,m.CURR_VALUE,m.CATEGORY,m.renttype,m.dtype,m.comp_id,m.tcno,m.branded,\r\n" + 
							"  f.fname finname,a.AUTHname, p.code_name PLTname ,g.gname VGRPname,b.brand_name BRDname,mo.vtype VMODname,v.name\r\n" + 
							"  DLRname,brch1.branchname  BRHname,m.COSTID costname, c.color CLRname,m.WAREND,m.STATU,m.FUELTYPE,m.TCAP,m.cost,m.accdepr\r\n" + 
							"   from gl_vehmaster m left join gl_vehin i on(i.doc_no=m.INS_COMP) left join my_locm l on l.doc_no=m.a_loc left join\r\n" + 
							"   gl_yom y on y.doc_no=m.yom  left join my_brch brch on(brch.doc_no=m.a_br) left join gl_vehfin f on (m.finId=f.doc_no)\r\n" + 
							"   left join gl_vehauth a on (a.doc_no=m.authid)   left join gl_vehplate p on(p.doc_no=m.pltid) left join gl_vehgroup g\r\n" + 
							"   on g.doc_no=m.vgrpid left join gl_vehbrand b on b.doc_no=m.brdid left join gl_vehmodel mo on mo.doc_no=m.vmodid\r\n" + 
							"   left join my_vendorm v on v.doc_no=m.dlrid left join my_brch brch1 on(brch1.doc_no=m.brhid) left join my_color c\r\n" + 
							"   on(c.doc_no=m.clrid)  left join gl_vmove vv on (vv.fleet_no=m.fleet_no and vv.rdtype='VEH' and vv.trancode='RR'\r\n" + 
							"   and vv.status='IN')   left join gl_vmove mov on mov.fleet_no=m.fleet_no and\r\n" + 
							"   mov.doc_no=(select max(doc_no) from gl_vmove where fleet_no=m.fleet_no)\r\n" + 
							" left join gl_vmove movs on movs.fleet_no=m.fleet_no  and movs.status='OUT' and\r\n" + 
							"   movs.doc_no=(select max(doc_no) from gl_vmove where fleet_no=m.fleet_no and status='OUT')\r\n" + 
							"   left join gl_status s on m.tran_code=s.status\r\n" + 
							"   left join gl_ragmt r on  r.doc_no=movs.rdocno and movs.rdtype='RAG'\r\n" + 
							"   left join gl_lagmt ll on ll.doc_no=movs.rdocno and movs.rdtype='LAG'\r\n" + 
							"   where m.statu=3  and m.fstatus<>'Z'";
					*/
			//System.out.println("--------sqldata-----"+sqldata);
/*			String sqldata=("\r\n" + 
					" select  CASE  WHEN movs.emp_type='CRM' THEN (select refname from my_acbook where cldocno=movs.emp_id and dtype='CRM')\r\n" + 
					"   WHEN movs.emp_type='DRV' THEN (select sal_name from my_salesman where doc_no=movs.emp_id and sal_type='DRV')\r\n" + 
					"    WHEN movs.emp_type='STF' THEN (select sal_name from my_salesman where doc_no=movs.emp_id and sal_type='STF')   END as 'empname',\r\n" + 
					"    CASE WHEN movs.rdtype='RAG' THEN r.voc_no WHEN  movs.rdtype='LAG' THEN ll.voc_no else movs.rdocno  END as\r\n" + 
					"   'rdocno' ,s.st_desc,convert(if(mov.status='OUT',round(mov.kmout),if(mov.status='IN',round(mov.kmin),m.cur_km)),char(40)) currentkm,\r\n" + 
					" m.salik_tag,PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM curdate()),EXTRACT( YEAR_MONTH FROM vv.din)) age,\r\n" + 
					" m.DOC_NO,m.DATE,m.REG_NO,m.FLEET_NO,m.FLNAME,m.PRCH_INV,m.PRCH_DTE prch_dte,m.PRCH_COST,m.INST_AMT,m.INT_AMT,m.DN_PAY,\r\n" + 
					" i.inname INS_COMP, m.INS_AMT,m.PRMYM_PERC,m.PRMYM,m.INS_EXP,m.REL_DATE,m.REG_EXP,m.DEPR,m.ENG_NO,m.CH_NO,l.loc_name A_LOC,\r\n" + 
					" m.STATUS,  m.SRVC_KM+m.lst_srv SRVC_KM,m.SRVC_DTE,m.LST_SRV,m.WAR,m.WAR_KM,m.CUR_KM,\r\n" + 
					" m.ITYPE,m.ADD1,m.TVAL,m.VIN,m.C_FUEL,m.TRAN_CODE, y.YOM,m.REG_DATE,m.LPO,m.SALIK_TAG,m.PUR_TYPE,m.NO_INST,m.FSTATUS,\r\n" + 
					"  brch.branchname A_BR,m.WAR_PRD,m.CURR_VALUE,m.CATEGORY,m.renttype,m.dtype,m.comp_id,m.tcno,m.branded,\r\n" + 
					"  f.fname finname,a.AUTHname, p.code_name PLTname ,g.gname VGRPname,b.brand_name BRDname,mo.vtype VMODname,v.name\r\n" + 
					"  DLRname,brch1.branchname  BRHname,m.COSTID costname, c.color CLRname,m.WAREND,m.STATU,m.FUELTYPE,m.TCAP,m.cost,m.accdepr\r\n" + 
					"   from gl_vehmaster m left join gl_vehin i on(i.doc_no=m.INS_COMP) left join my_locm l on l.doc_no=m.a_loc left join\r\n" + 
					"   gl_yom y on y.doc_no=m.yom  left join my_brch brch on(brch.doc_no=m.a_br) left join gl_vehfin f on (m.finId=f.doc_no)\r\n" + 
					"   left join gl_vehauth a on (a.doc_no=m.authid)   left join gl_vehplate p on(p.doc_no=m.pltid) left join gl_vehgroup g\r\n" + 
					"   on g.doc_no=m.vgrpid left join gl_vehbrand b on b.doc_no=m.brdid left join gl_vehmodel mo on mo.doc_no=m.vmodid\r\n" + 
					"   left join my_vendorm v on v.doc_no=m.dlrid left join my_brch brch1 on(brch1.doc_no=m.brhid) left join my_color c\r\n" + 
					"   on(c.doc_no=m.clrid)  left join gl_vmove vv on (vv.fleet_no=m.fleet_no and vv.rdtype='VEH' and vv.trancode='RR'\r\n" + 
					"   and vv.status='IN')   left join gl_vmove mov on mov.fleet_no=m.fleet_no and\r\n" + 
					"   mov.doc_no=(select max(doc_no) from gl_vmove where fleet_no=m.fleet_no)\r\n" + 
					" left join gl_vmove movs on movs.fleet_no=m.fleet_no  and m.status='OUT' and\r\n" + 
					"   movs.doc_no=(select max(doc_no) from gl_vmove where fleet_no=m.fleet_no )\r\n" + 
					"   left join gl_status s on m.tran_code=s.status\r\n" + 
					"   left join gl_ragmt r on  r.doc_no=movs.rdocno and movs.rdtype='RAG'\r\n" + 
					"   left join gl_lagmt ll on ll.doc_no=movs.rdocno and movs.rdtype='LAG'\r\n" + 
					"   where m.statu=3  and m.fstatus<>'Z' "+sqlbrch);*/
 
//		System.out.println("--------sqldata-----"+sqldata);
				ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				}
				stmtVeh1.close();
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
	
	public  JSONArray firstchart() throws SQLException {
      
        
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmt6 = conn.createStatement ();
            	
				String Sql= ("select round(if(cc.tran_code='RA',aa.val,bb.val)/(aa.val+bb.val) *100,2) per,cc.tran_code from "
						+ " (select count(*) val,tran_code from gl_vehmaster vm  where vm.tran_code='RA' and vm.statu=3 )aa, "
						+ "(select count(*) val,tran_code from gl_vehmaster vm  where  vm.tran_code='LA' and vm.statu=3 )bb,"
						+ "(select 'SS' val, tran_code from gl_vehmaster vm  where vm.tran_code in ('RA','LA')  and vm.statu=3 group by vm.tran_code) cc ;");
				ResultSet resultSet6 = stmt6.executeQuery(Sql);
				
				//System.out.println("---1-----"+Sql);
				
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet6);
				
				stmt6.close();
				conn.close();
				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	public  JSONArray Secondchart() throws SQLException {
      
        
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt6 = conn.createStatement ();
        	
			String Sql= ("select round(if(cc.tran_code='UR',aa.val,bb.val)/(aa.val+bb.val) *100,2) per,cc.tran_code from "
					+ " (select count(*) val,tran_code from gl_vehmaster vm  where vm.tran_code='UR' and vm.statu=3 )aa, "
					+ "(select count(*) val,tran_code from gl_vehmaster vm  where  vm.tran_code='RR' and vm.statu=3  )bb,"
					+ "(select 'SS' val, tran_code from gl_vehmaster vm  where vm.tran_code in ('UR','RR') and vm.statu=3 group by vm.tran_code order by  tran_code desc) cc where 1=1 order by  tran_code desc");
			ResultSet resultSet6 = stmt6.executeQuery(Sql);
			
			//System.out.println("-----2---"+Sql);
			
			
			RESULTDATA=ClsCommon.convertToJSON(resultSet6);
			
			stmt6.close();
			conn.close();
				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	public  JSONArray Thirdchart() throws SQLException {
      
        
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt6 = conn.createStatement ();
        	
			String Sql= ("select case when dd.tran_code='GA' then round(aa.val/(aa.val+bb.val+cc.val) *100,2) when dd.tran_code='GM' then "
					+ " round(bb.val/(aa.val+bb.val+cc.val) *100,2) when dd.tran_code='GS' then round(cc.val/(aa.val+bb.val+cc.val) *100,2) end as per, "
					+ "dd.tran_code from (select count(*) val,tran_code from gl_vehmaster vm  where vm.tran_code='GA' and vm.statu=3 )aa, "
					+ "(select count(*) val,tran_code from gl_vehmaster vm  where  vm.tran_code='GM' and vm.statu=3 )bb, "
					+ "(select count(*) val,tran_code from gl_vehmaster vm  where  vm.tran_code='GS'  and vm.statu=3 )cc, "
					+ " (select 'SS' val, tran_code from gl_vehmaster vm  where vm.tran_code in ('GA','GM','GS') and vm.statu=3 group by vm.tran_code ) dd ;");
			ResultSet resultSet6 = stmt6.executeQuery(Sql);
			
			//System.out.println("-----3---"+Sql);
			
			
			RESULTDATA=ClsCommon.convertToJSON(resultSet6);
			
			stmt6.close();
			conn.close();
				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	public  JSONArray Fourthchart() throws SQLException {
      
        
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt6 = conn.createStatement ();
        	
			String Sql= ("select case when hh.tran_codes='On Hire' then round(aa.val/(aa.val+bb.val+cc.val+dd.val) *100,2)  when hh.tran_codes='Available' "
					+ " then round(bb.val/(aa.val+bb.val+cc.val+dd.val) *100,2) when hh.tran_codes='Garage' then round(cc.val/(aa.val+bb.val+cc.val+dd.val) *100,2) when hh. "
					+ " tran_codes='Other' then round(dd.val/(aa.val+bb.val+cc.val+dd.val) *100,2) end as per, "
					+ " case when hh.tran_codes='On Hire' then 'On Hire'  when hh.tran_codes='Available' then 'Available' "
					+ " when hh.tran_codes='Garage' then 'Garage' when hh.tran_codes='Other' then 'Other' end as tran_code from "
					+ "(select count(*) val,'On Hire' tran_codes from gl_vehmaster vm  where vm.tran_code in('LA','RA')  and vm.statu=3  )aa, "
					+ "(select count(*) val,'Available' tran_codes from gl_vehmaster vm  where  vm.tran_code in('RR','UR') and vm.statu=3 )bb, "
					+ "(select count(*) val,'Garage' tran_codes from gl_vehmaster vm  where  vm.tran_code in ('GA','GM','GS') and vm.statu=3  )cc, "
					+ "(select count(*) val,'Other' tran_codes from gl_vehmaster vm  where  vm.tran_code not in ('RA','LA','UR','RR','GA','GM','GS' ) "
					+ "and vm.statu=3 and fstatus in ('L','I')  )dd, ( Select hh.tran_codes from(select count(*) val,'On Hire' tran_codes from gl_vehmaster vm  where vm.tran_code in('LA','RA') "
					+ "  and vm.statu=3 union select count(*) val,'Available' tran_codes from gl_vehmaster vm  where vm.tran_code in ('RR','UR')  and vm.statu=3 "
					+ "union select count(*) val,'Garage' tran_codes from gl_vehmaster vm  where vm.tran_code in ('GA','GM','GS')   and vm.statu=3 union "
					+ " select count(*) val,'Other' tran_codes from gl_vehmaster vm  where vm.tran_code not in ('RA','LA','UR','RR','GA','GM','GS' ) and fstatus in ('L','I')   and vm.statu=3) hh) hh ");
			ResultSet resultSet6 = stmt6.executeQuery(Sql);
			
			//System.out.println("-----4---"+Sql);
			
			
			RESULTDATA=ClsCommon.convertToJSON(resultSet6);
			
			stmt6.close();
			conn.close();
				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	public JSONArray searchReadyToRent(String brch) throws SQLException { 

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection(); 
				Statement stmtVeh1 = conn.createStatement ();
				String sqlbrch="";
			if(!brch.equalsIgnoreCase("a")){
				sqlbrch=" and m.a_br="+brch;
			            }
				
            	
			
			String sqldata=("select convert(coalesce(rr.ofleet_no,'0'),char(30)) ofleet_no,convert((SELECT DATEDIFF(m.ins_exp,curdate())),char(20)) AS days,m.doc_no,m.a_br branchid,m.VGRPID groupid,br.branchname,m.FLEET_NO,m.FLNAME,m.REG_NO,v.kmin,m.SRVC_KM+m.lst_srv SRVC_KM,y.YOM,m.renttype renttype,    "
					+ "CASE WHEN v.fin='0.000' THEN 'Level 0/8' WHEN v.fin='0.125' THEN 'Level 1/8' WHEN v.fin='0.250'  "
					+ "THEN 'Level 2/8' WHEN v.fin='0.375' 	THEN 'Level 3/8' WHEN v.fin='0.500' THEN 'Level 4/8' WHEN v.fin='0.625' THEN 'Level 5/8'  "
					+ "WHEN v.fin='0.750' THEN 'Level 6/8' WHEN v.fin='0.875' THEN 'Level 7/8' WHEN v.fin='1.000' THEN 'Level 8/8'  "
					+ "END as 'fin',l.LOC_NAME,g.gname,c.color,b.brand_name, round(TIMESTAMPDIFF(hour,cast(concat(din,' ',tin)as datetime),cast(now() as datetime))/24,2) idealdys   "
					+ "from gl_vehmaster m "
					+ " inner join gl_vmove v on v.fleet_no=m.fleet_no and m.tran_code='RR' "
					+ " inner  join   (select max(doc_no) maxd,fleet_no from gl_vmove group by fleet_no) a "
					+ " on v.doc_no=a.maxd and v.fleet_no=a.fleet_no "
					+ "	left join my_locm l on l.doc_no=m.A_LOC  left join gl_vehgroup g on g.doc_no=m.VGRPID  "
					+ "	left join my_color c on(m.clrid=c.doc_no)  left join gl_vehbrand b on(m.brdid=b.doc_no) left join my_brch br on br.doc_no=m.a_br  "
					+ "  left join gl_ragmt rr on rr.ofleet_no=m.fleet_no and rr.clstatus=0 and rr.status=3 "
					+ "	left join gl_yom y on y.doc_no=m.yom  where m.statu=3  "+sqlbrch+" "); 
			
              System.out.println("sql"+sqldata);
			
				ResultSet resultSet = stmtVeh1.executeQuery(sqldata);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtVeh1.close();
				conn.close();
				 return RESULTDATA;

		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	public JSONArray vehicleListSearch(String chk) throws SQLException { 

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
            	if(chk.equalsIgnoreCase("load"))
            	{
			String sqldata=("select s.st_desc,convert(if(mov.status='OUT',round(mov.kmout),if(mov.status='IN',round(mov.kmin),m.cur_km)),char(40)) currentkm, "
						+ "m.salik_tag,PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM curdate()),EXTRACT( YEAR_MONTH FROM m.prch_dte)) age, "
						+ "m.DOC_NO,m.DATE,m.REG_NO,m.FLEET_NO,m.FLNAME,m.PRCH_INV,m.PRCH_DTE prch_dte,m.PRCH_COST,m.INST_AMT,m.INT_AMT,m.DN_PAY,i.inname INS_COMP, "
						+ "m.INS_AMT,m.PRMYM_PERC,m.PRMYM,m.INS_EXP,m.REL_DATE,m.REG_EXP,m.DEPR,m.ENG_NO,m.CH_NO,l.loc_name A_LOC,m.STATUS, "
						+ " m.SRVC_KM+m.lst_srv SRVC_KM,m.SRVC_DTE,m.LST_SRV,m.WAR,m.WAR_KM,m.CUR_KM,m.ITYPE,m.ADD1,m.TVAL,m.VIN,m.C_FUEL,m.TRAN_CODE,"
						+ " y.YOM,m.REG_DATE,m.LPO,m.SALIK_TAG,m.PUR_TYPE,m.NO_INST,m.FSTATUS, "
						+ "brch.branchname A_BR,m.WAR_PRD,m.CURR_VALUE,m.CATEGORY,m.renttype,m.dtype,m.comp_id,m.tcno,m.branded,f.fname finname,a.AUTHname, "
						+ "p.code_name PLTname ,g.gname VGRPname,b.brand_name BRDname,mo.vtype VMODname,v.name DLRname,brch1.branchname  BRHname,m.COSTID costname, "
						+ "c.color CLRname,m.WAREND,m.STATU,m.FUELTYPE,m.TCAP,m.cost,m.accdepr from gl_vehmaster m "
						+ "left join gl_vehin i on(i.doc_no=m.INS_COMP) left join my_locm l on l.doc_no=m.a_loc left join gl_yom y on y.doc_no=m.yom "
						+ " left join my_brch brch on(brch.doc_no=m.a_br) left join gl_vehfin f on (m.finId=f.doc_no) left join gl_vehauth a on (a.doc_no=m.authid)  "
						+ " left join gl_vehplate p on(p.doc_no=m.pltid) left join gl_vehgroup g on g.doc_no=m.vgrpid left join gl_vehbrand b on b.doc_no=m.brdid "
						+ "left join gl_vehmodel mo on mo.doc_no=m.vmodid left join my_vendorm v on v.doc_no=m.dlrid left join my_brch brch1 on(brch1.doc_no=m.brhid) "
						+ "left join my_color c on(c.doc_no=m.clrid)  "
						+ " left join gl_vmove mov on mov.fleet_no=m.fleet_no "
						+ " inner  join   (select max(doc_no) maxd,fleet_no from gl_vmove group by fleet_no) a "
						+ " on mov.doc_no=a.maxd and mov.fleet_no=a.fleet_no "
						+ "  left join gl_status s on m.tran_code=s.status  where m.statu=3  and m.fstatus<>'Z' ");
				
//System.out.println("----------sqldata---------"+sqldata);
				
		
				ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
            	}
				stmtVeh1.close();
				conn.close();
				 return RESULTDATA;

		}
		catch(Exception e){
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	public JSONArray vehicleexcelListSearch(String chk) throws SQLException { 

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
			
	
				if(chk.equalsIgnoreCase("load"))
            	{
				
				String sqldata="select m.FLEET_NO,a.AUTHname Authority,m.REG_NO,p.code_name Plate_Code ,m.FLNAME Fleet_Name,m.eng_no 'Engine No',m.ch_no 'Chassis No',g.gname Tariff_Group,b.brand_name Brand,"
						+ " mo.vtype Model,s.st_desc Trancode,y.YOM,c.color Color,convert(if(mov.status='OUT',round(mov.kmout),if(mov.status='IN',round(mov.kmin),m.cur_km)),char(40)) Current_KM, "
						+ "m.REG_EXP,m.INS_EXP,m.PRCH_COST 'Purchase Cost',m.ADD1 'Additional Cost',m.TVAL 'Total Cost',m.DEPR 'Depreciation(%)', "
						+ " PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM curdate()),EXTRACT( YEAR_MONTH FROM m.prch_dte)) 'Age(months)',m.salik_tag Salik_Tag,m.tcno 'Traffic Tcno' "
						+ " from gl_vehmaster m "
						+ "left join gl_vehin i on(i.doc_no=m.INS_COMP) left join my_locm l on l.doc_no=m.a_loc left join gl_yom y on y.doc_no=m.yom "
						+ " left join my_brch brch on(brch.doc_no=m.a_br) left join gl_vehfin f on (m.finId=f.doc_no) left join gl_vehauth a on (a.doc_no=m.authid)  "
						+ " left join gl_vehplate p on(p.doc_no=m.pltid) left join gl_vehgroup g on g.doc_no=m.vgrpid left join gl_vehbrand b on b.doc_no=m.brdid "
						+ "left join gl_vehmodel mo on mo.doc_no=m.vmodid left join my_vendorm v on v.doc_no=m.dlrid left join my_brch brch1 on(brch1.doc_no=m.brhid) "
						+ "left join my_color c on(c.doc_no=m.clrid)  "
						+ "   left join gl_vmove mov on mov.fleet_no=m.fleet_no "
						+ " inner  join   (select max(doc_no) maxd,fleet_no from gl_vmove group by fleet_no) a "
						+ " on mov.doc_no=a.maxd and mov.fleet_no=a.fleet_no "
						+ "  left join gl_status s on m.tran_code=s.status  where m.statu=3  and m.fstatus<>'Z' ";
				
			//	System.out.println("sqldata--------"+sqldata);
				
		
				ResultSet resultSet = stmtVeh1.executeQuery(sqldata);
				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
            	}
				//System.out.println("============"+RESULTDATA);
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
	
	public JSONArray vehicleDetailsSearch() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection(); 
				Statement stmtVeh1 = conn.createStatement ();
            	
				String sqldata=("select m.DOC_NO,m.DATE,m.REG_NO,m.FLEET_NO,m.FLNAME,m.PRCH_INV,m.PRCH_DTE prch_dte,m.PRCH_COST,m.INST_AMT,m.INT_AMT,m.DN_PAY,i.inname INS_COMP "
						+ ",m.PNO,m.INS_AMT,m.PRMYM_PERC,m.PRMYM,m.INS_EXP,m.REL_DATE,m.REG_EXP,m.DEPR,m.ENG_NO,m.CH_NO,l.loc_name A_LOC,m.STATUS, "
						+ " m.SRVC_KM+m.lst_srv SRVC_KM,m.SRVC_DTE,m.LST_SRV,m.WAR,m.WAR_KM,m.CUR_KM,m.ITYPE,m.ADD1,m.TVAL,m.VIN,m.C_FUEL,m.TRAN_CODE,"
						+ " y.YOM,m.REG_DATE,m.LPO,m.SALIK_TAG,m.PUR_TYPE,m.NO_INST,m.FSTATUS, "
						+ "brch.branchname A_BR,m.WAR_PRD,m. CURR_VALUE,m.CATEGORY,m.renttype,m.dtype,m.comp_id,m.tcno,m.branded,f.fname finname,a.AUTHname, "
						+ "p.code_name PLTname ,g.gname VGRPname,b.brand_name BRDname,mo.vtype VMODname,v.name DLRname,brch1.branchname  BRHname,m.COSTID costname, "
						+ "c.color CLRname,m.WAREND,m.STATU,m.FUELTYPE,m.TCAP,m.cost,m.accdepr from gl_vehmaster m "
						+ "left join gl_vehin i on(i.doc_no=m.INS_COMP) left join my_locm l on l.doc_no=m.a_loc left join gl_yom y on y.doc_no=m.yom "
						+ " left join my_brch brch on(brch.doc_no=m.a_br) left join gl_vehfin f on (m.finId=f.doc_no) left join gl_vehauth a on (a.doc_no=m.authid)  "
						+ " left join gl_vehplate p on(p.doc_no=m.pltid) left join gl_vehgroup g on g.doc_no=m.vgrpid left join gl_vehbrand b on b.doc_no=m.brdid "
						+ "left join gl_vehmodel mo on mo.doc_no=m.vmodid left join my_vendorm v on v.doc_no=m.dlrid left join my_brch brch1 on(brch1.doc_no=m.brhid) "
						+ "left join my_color c on(c.doc_no=m.clrid) where m.statu=3");
		
				ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtVeh1.close();
				conn.close();
				 return RESULTDATA;

		}
		catch(Exception e){
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	public JSONArray regexpirysearch(String branch,String expdate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlStartDate = null;
     	if(!(expdate.equalsIgnoreCase("undefined"))&&!(expdate.equalsIgnoreCase(""))&&!(expdate.equalsIgnoreCase("0")))
     	{
     		sqlStartDate=ClsCommon.changeStringtoSqlDate(expdate);
     		
     	}
     	else{
     
     	}

     	Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
			    if(branch.equalsIgnoreCase("a"))
		    	{
		        	String sqlexp=("select 'Attach' attachbtn,m.doc_no docno,m.brhid,m.fleet_no,m.flname,m.reg_no,m.reg_exp,m.reg_date,g.gname,c.color,b.brand_name,mo.vtype model,'Edit' btnsave "
							+ "	from gl_vehmaster m left join my_locm l on l.doc_no=m.A_LOC  left join gl_vehgroup g on g.doc_no=m.VGRPID "
							+ " left join my_color c on(m.clrid=c.doc_no) 	left join gl_vehbrand b on(m.brdid=b.doc_no) "
							+ " left join gl_vehmodel mo on mo.doc_no=m.vmodid where m.statu=3 and fstatus in ('L','N') and  m.reg_exp<='"+sqlStartDate+"' " );
			//System.out.println("sqlexp  "+sqlexp);
					ResultSet resultSet = stmtVeh1.executeQuery (sqlexp);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtVeh1.close();
		
		    	}
		    	else{				 
		    		String sqlexp=("select 'Attach' attachbtn,m.doc_no docno,m.brhid,m.fleet_no,m.flname,m.reg_no,m.reg_exp,m.reg_date,g.gname,c.color,b.brand_name,mo.vtype model,'Edit' btnsave  "
							+ "	from gl_vehmaster m left join my_locm l on l.doc_no=m.A_LOC  left join gl_vehgroup g on g.doc_no=m.VGRPID "
							+ " left join my_color c on(m.clrid=c.doc_no) 	left join gl_vehbrand b on(m.brdid=b.doc_no) "
							+ " left join gl_vehmodel mo on mo.doc_no=m.vmodid where m.statu=3 and fstatus in ('L','N') and  m.brhid='"+branch+"' and m.reg_exp<='"+sqlStartDate+"' " );
			//System.out.println("sqlexp  "+sqlexp);
					ResultSet resultSet = stmtVeh1.executeQuery (sqlexp);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtVeh1.close();
				
		    	}
				conn.close();
				 return RESULTDATA;

		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	public JSONArray insuexpirysearch(String branch,String expdate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();

  // System.out.println("========    "+expdate);
       // java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(expdate);
        
        java.sql.Date sqlStartDate = null;
     	if(!(expdate.equalsIgnoreCase("undefined"))&&!(expdate.equalsIgnoreCase(""))&&!(expdate.equalsIgnoreCase("0")))
     	{
     		sqlStartDate=ClsCommon.changeStringtoSqlDate(expdate);
     		
     	}
     	else{
     
     	}
        
    
        Connection conn = null;
   	
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
			    if(branch.equalsIgnoreCase("a"))
		    	{
		        	String sqlexp=("select 'Attach' attachbtn,m.doc_no docno,m.brhid, m.fleet_no,m.flname,m.reg_no,if(m.tran_code='FS',null,m.reg_date) reg_date,if(m.tran_code='FS',null,m.ins_exp) ins_exp,m.ins_amt,g.gname,c.color,b.brand_name,mo.vtype model,'Edit' btnsave"
		        			+ "	from gl_vehmaster m left join my_locm l on l.doc_no=m.A_LOC  left join gl_vehgroup g on g.doc_no=m.VGRPID "
		        			+ "	left join my_color c on(m.clrid=c.doc_no) 	left join gl_vehbrand b on(m.brdid=b.doc_no) "
		        			+ " left join gl_vehmodel mo on mo.doc_no=m.vmodid left join gl_vehin i on(i.doc_no=m.ins_comp) where m.statu=3 and fstatus in ('L','N') and  m.ins_exp<='"+sqlStartDate+"' " );
		//	System.out.println("sqlexp  "+sqlexp);
					ResultSet resultSet = stmtVeh1.executeQuery (sqlexp);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtVeh1.close();
					
		    	}
		    	else{				 
		    		String sqlexp=("select 'Attach' attachbtn,m.doc_no docno,m.brhid, m.fleet_no,m.flname,m.reg_no,if(m.tran_code='FS',null,m.reg_date) reg_date,if(m.tran_code='FS',null,m.ins_exp) ins_exp,m.ins_amt,g.gname,c.color,b.brand_name,mo.vtype model,'Edit' btnsave"
		        			+ "	from gl_vehmaster m left join my_locm l on l.doc_no=m.A_LOC  left join gl_vehgroup g on g.doc_no=m.VGRPID "
		        			+ "	left join my_color c on(m.clrid=c.doc_no) 	left join gl_vehbrand b on(m.brdid=b.doc_no) "
		        			+ " left join gl_vehmodel mo on mo.doc_no=m.vmodid left join gl_vehin i on(i.doc_no=m.ins_comp) where m.statu=3 and fstatus in ('L','N') and  m.brhid='"+branch+"' and m.ins_exp<='"+sqlStartDate+"' " );
		//	System.out.println("sqlexp  "+sqlexp);
					ResultSet resultSet = stmtVeh1.executeQuery (sqlexp);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtVeh1.close();
					
		    	}
			    conn.close();
				 return RESULTDATA;

		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	public JSONArray searchinsuCompany() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
       
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
		
            		String sql="select inname,doc_no from gl_vehin  where status<>7; ";
            	//System.out.println("----"+sql);
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
	public JSONArray vehmovementSearch(String fleetno,String fromdate,String todate,String ready) throws SQLException {

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
		
         if(ready.equalsIgnoreCase("ready"))
         {
        	 
        	 
        	 String sql="select CASE  WHEN v.rdtype='RAG' THEN r.voc_no WHEN  rdtype='LAG' THEN l.voc_no else v.rdocno  END as  'rdocno'  , "
        	 		+ " v.fleet_no,vm.reg_no,if(v.rdtype='','',v.rdtype) rdtype,coalesce(vm.flname,'') flname ,coalesce(v.status,'') status, "
						+ "coalesce(s.st_desc,'') trancode,CONVERT(coalesce(v.obrhid,''),char(15)) obrhid,CONVERT(coalesce(v.dout,''),char(20)) dout,coalesce(v.tout,'') tout,CONVERT(coalesce(round(v.kmout),''),char(30)) kmout, "
						+ "CASE  WHEN coalesce(v.fout,'')='' THEN '' WHEN v.fout='0.000' THEN 'Level 0/8'  WHEN v.fout='0.125' THEN 'Level 1/8' WHEN v.fout='0.250'  "
						+ "THEN 'Level 2/8' WHEN v.fout='0.375'   	THEN 'Level 3/8' WHEN v.fout='0.500' THEN 'Level 4/8' WHEN v.fout='0.625' THEN 'Level 5/8' "
						+ "	WHEN v.fout='0.750' THEN 'Level 6/8'   WHEN v.fout='0.875' THEN 'Level 7/8' WHEN v.fout='1.000' THEN 'Level 8/8' "
						+ "   END as 'Fout' ,CONVERT(coalesce(v.ibrhid,''),char(15)) ibrhid,CONVERT(coalesce(v.din,''),char(15)) din,coalesce(v.tin,'') tin,CONVERT(coalesce(round(kmin),''),char(30)) kmin, "
						+ "   CASE  WHEN coalesce(v.fin,'')='' THEN '' WHEN v.fin='0.000' THEN 'Level 0/8'  WHEN v.fin='0.125' "
						+ "   THEN 'Level 1/8' WHEN v.fin='0.250' THEN 'Level 2/8' WHEN v.fin='0.375' 	THEN 'Level 3/8' WHEN v.fin='0.500' "
						+ "   THEN 'Level 4/8' WHEN v.fin='0.625' THEN 'Level 5/8' WHEN v.fin='0.750'  THEN 'Level 6/8' WHEN v.fin='0.875' "
						+ "   THEN 'Level 7/8' WHEN v.fin='1.000' THEN 'Level 8/8' END as 'FIN'  from gl_vmove v left join gl_status s "
						+ "   on(v.trancode=s.status) left join gl_vehmaster vm on (vm.fleet_no=v.fleet_no  and vm.statu=3) "
						+ " left join gl_ragmt r on  r.doc_no=v.rdocno and v.rdtype='RAG' "
									+ " left join gl_lagmt l on l.doc_no=v.rdocno and v.rdtype='LAG' "
						+ "where v.fleet_no='"+fleetno+"'  ORDER BY v.doc_no DESC   limit 15;";
     //  System.out.println("----111111------"+sql);
         		ResultSet resultSet = stmtVeh.executeQuery(sql);
         		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
  				stmtVeh.close();
  			//	 return RESULTDATA;
        	 
        	 
         }
				
         else
         {
        	 
      	 String sqltest="";
 	    	
      	int val=0;
        	 
        	String testsql="select count(*) val from gl_vmove v  where v.fleet_no='"+fleetno+"' and  v.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
        	
    		ResultSet res1 = stmtVeh.executeQuery(testsql);
    		 
    		if(res1.next())
    		{
    			
    			 val=(res1.getInt("val"));
    			
    		}
    		 
    		if(val>0)
    			{
     	    		sqltest=sqltest+" and  v.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"' order by v.doc_no desc ;";
    			
    		     }
    		
    		
    		else
    		{
    			sqltest=sqltest+" order by v.doc_no desc limit 15; ";
    		}
    		
 
				String sql="select  CASE  WHEN v.rdtype='RAG' THEN r.voc_no WHEN  rdtype='LAG' THEN l.voc_no else v.rdocno  END as  'rdocno' "
						+ ", CASE  WHEN v.emp_type='CRM' THEN (select refname from my_acbook where cldocno=v.emp_id and dtype='CRM')   "
        	 		   + " WHEN v.emp_type='DRV' THEN (select sal_name from my_salesman where doc_no=v.emp_id and sal_type='DRV') "
        	 		    + " WHEN v.emp_type='STF' THEN (select sal_name from my_salesman where doc_no=v.emp_id and sal_type='STF')   END as 'empname' , v.fleet_no,vm.reg_no,if(v.rdtype='','',v.rdtype) rdtype, "
        	 		    + " coalesce(vm.flname,'') flname ,coalesce(v.status,'') status, "
						+ "coalesce(s.st_desc,'') trancode,CONVERT(coalesce(v.obrhid,''),char(15)) obrhid,CONVERT(coalesce(v.dout,''),char(20)) dout,coalesce(v.tout,'') tout,CONVERT(coalesce(round(v.kmout),''),char(30)) kmout, "
						+ " CASE  WHEN coalesce(v.fout,'')='' THEN '' WHEN v.fout='0.000' THEN 'Level 0/8'  WHEN v.fout='0.125' THEN 'Level 1/8' WHEN v.fout='0.250'  "
						+ "THEN 'Level 2/8' WHEN v.fout='0.375'   	THEN 'Level 3/8' WHEN v.fout='0.500' THEN 'Level 4/8' WHEN v.fout='0.625' THEN 'Level 5/8' "
						+ "	WHEN v.fout='0.750' THEN 'Level 6/8'   WHEN v.fout='0.875' THEN 'Level 7/8' WHEN v.fout='1.000' THEN 'Level 8/8' "
						+ "   END as 'Fout' ,CONVERT(coalesce(v.ibrhid,''),char(15)) ibrhid,CONVERT(coalesce(v.din,''),char(15)) din,coalesce(v.tin,'') tin,CONVERT(coalesce(round(kmin),''),char(30)) kmin, "
						+ "   CASE  WHEN coalesce(v.fin,'')='' THEN '' WHEN v.fin='0.000' THEN 'Level 0/8'  WHEN v.fin='0.125' "
						+ "   THEN 'Level 1/8' WHEN v.fin='0.250' THEN 'Level 2/8' WHEN v.fin='0.375' 	THEN 'Level 3/8' WHEN v.fin='0.500' "
						+ "   THEN 'Level 4/8' WHEN v.fin='0.625' THEN 'Level 5/8' WHEN v.fin='0.750'  THEN 'Level 6/8' WHEN v.fin='0.875' "
						+ "   THEN 'Level 7/8' WHEN v.fin='1.000' THEN 'Level 8/8' END as 'FIN'  from gl_vmove v left join gl_status s "
						+ "   on(v.trancode=s.status) left join gl_ragmt r on  r.doc_no=v.rdocno and v.rdtype='RAG' "
						+ " left join gl_lagmt l on l.doc_no=v.rdocno and v.rdtype='LAG' left join gl_vehmaster vm on (vm.fleet_no=v.fleet_no and vm.statu=3) "
						+ "where v.fleet_no='"+fleetno+"' "+sqltest;
			//	System.out.println("------------"+sql);
        	
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
	public JSONArray fleetseachmove() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
		
            	/*	String sql="select m.fleet_no,m.flname,m.reg_no,convert(concat(' Fleet ',m.FLEET_NO,'  ',m.FLNAME,'  ',REG_NO,   ' . ', au.authname,'  ',pl.code_name,' . ', 'YOM  ',y.YOM,'   ',c.color, ' . ','Salik Tag   ', "
            				+ "m.SALIK_TAG,' . ',   'Exp ',' ','Reg : ',m.REG_EXP,'  ' ,'Ins :' ,m.INS_EXP,' . ', 'Insured at  ' , i.inname,' . ', "
            				+ " 'Last Service  ', 'Date : ',m.SRVC_DTE,' ',' KM :',m.SRVC_KM,' . ', 'Warranty ', 'Date :' ,m.WAR,'  ',   'KM :', m.WAR_KM,' . ',  "
            				+ " 'Engine NO  ' ,m.ENG_NO,' . ','Chassis NO ', m.CH_NO),char(1000)) vehinfo  from gl_vehmaster m left join gl_vehgroup g on g.doc_no=m.VGRPID "
            				+ "  left join my_color c on(m.clrid=c.doc_no)   left join gl_yom y on y.doc_no=m.yom "
            				+ "   left join gl_vehauth au on au.doc_no=m.authid  left join  gl_vehplate pl "
            				+ " on pl.doc_no=m.pltid left join gl_vehin i on i.doc_no=m.ins_comp where m.statu=3";*/
				
			String sql="select pl.code_name,m.fleet_no,m.flname,m.reg_no,convert(concat(' Fleet ',coalesce(m.FLEET_NO,''),'  ',coalesce(m.FLNAME,''),'  ',coalesce(REG_NO,''),   ' * ', au.authname,'  ', "
					+ " coalesce(pl.code_name,''),' * ', 'YOM  ',coalesce(y.YOM,''),'   ',coalesce(c.color,''), ' * ','Salik Tag   ',coalesce(m.SALIK_TAG,''),' * ',   'Exp ',' ','Reg : ',coalesce(m.REG_EXP,''),'  ' , "
					+ "'Ins :' ,coalesce(m.INS_EXP,''),' * ', 'Insured at  ' ,coalesce(i.inname,''),' * ',    'Last Service  ', 'Date : ',coalesce(m.SRVC_DTE,''),' ',' KM :',coalesce(m.SRVC_KM,''),' * ' , "
					+ " 'Warranty ', 'Date :' ,coalesce(m.WAR,''),'     ',   'KM :',coalesce(m.WAR_KM,''),' * ',   'Engine NO  ' ,coalesce(m.ENG_NO,''),' * ','Chassis NO ',coalesce(m.CH_NO,'')),char(1000)) vehinfo  "
					+ "      from gl_vehmaster m left join gl_vehgroup g on g.doc_no=m.VGRPID   left join my_color c on(m.clrid=c.doc_no)    left join gl_yom y on y.doc_no=m.yom   "
					+ "  left join gl_vehauth au on au.doc_no=m.authid  left join  gl_vehplate pl  on pl.doc_no=m.pltid left join gl_vehin i on i.doc_no=m.ins_comp where m.statu=3  order by  m.fleet_no";
				
            		//System.out.println(""+sql);
            		
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
	public JSONArray tariffSearch(String groupname,String docval,String branch) throws SQLException {


	  	 JSONArray RESULTDATA=new JSONArray();
	  	   
	  	Connection conn = null;
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh6 = conn.createStatement ();
					String tasql= ("select m1.doc_no,m1.cdw,m1.pai,m1.kmrest,m1.exkmrte,m1.rate,m1.cdw1,m1.pai1,m1.gps,m1.babyseater, "
							+ "m1.cooler,m1.oinschg,m1.chaufchg,m1.chaufexchg,m1.exhrchg,m1.gid,m2.rentaltype from gl_tarifm m "
							+ " inner join gl_tarifd m1 on m.doc_no=m1.doc_no right join gl_tlistm m2 on m1.renttype=m2.rentaltype where m.doc_no='"+docval+"'  "
							+ " and m1.gid='"+groupname+"' and  m2.Status=1 order by m2.doc_no;");
				//	System.out.println("---tasql-------"+tasql);
					
					ResultSet resultSet = stmtVeh6.executeQuery(tasql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVeh6.close();
					conn.close();
			}
			catch(Exception e){
				conn.close();
			}
	       return RESULTDATA;
	   }   
	
	public JSONArray searchmasterTariff(String brnchval,String group) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				//String sql="";
				//ResultSet resultSet ;
				//System.out.println("========="+brnchval);
          
            		String sql="select if(m.tariftype='CORPORATE',concat(m.tariftype,' ',ca.cat_name),m.tariftype) tariftype,m.doc_no from gl_tarifm m left join gl_tarifd m1  "
            				+ "on m.doc_no=m1.doc_no   left join my_clcatm ca on ca.doc_no=m.clientid  "
            				+ " where current_date between M.validfrm and M.validto AND m1.gid='"+group+"'  and m.status<>7 "
            				+ "    group by m.doc_no;";
            
            	//	System.out.println("----sql---"+sql);
            		
            		
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
	public JSONArray searchrentstatus(String brch) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection(); 
				Statement stmtVeh1 = conn.createStatement ();
				String sqlbrch="";
			if(!brch.equalsIgnoreCase("a")){
				sqlbrch=" and m.a_br="+brch;
			}
				
            	
			
			String sqldata=("select m.doc_no,m.a_br branchid,m.VGRPID groupid,br.branchname,m.FLEET_NO,m.FLNAME,m.REG_NO,v.kmin,m.SRVC_KM+m.lst_srv SRVC_KM,y.YOM,m.renttype renttype,    "
					+ "CASE WHEN v.fin='0.000' THEN 'Level 0/8' WHEN v.fin='0.125' THEN 'Level 1/8' WHEN v.fin='0.250'  "
					+ "THEN 'Level 2/8' WHEN v.fin='0.375' 	THEN 'Level 3/8' WHEN v.fin='0.500' THEN 'Level 4/8' WHEN v.fin='0.625' THEN 'Level 5/8'  "
					+ "WHEN v.fin='0.750' THEN 'Level 6/8' WHEN v.fin='0.875' THEN 'Level 7/8' WHEN v.fin='1.000' THEN 'Level 8/8'  "
					+ "END as 'fin',l.LOC_NAME,g.gname,c.color,b.brand_name, round(TIMESTAMPDIFF(hour,cast(concat(din,' ',tin)as datetime),cast(now() as datetime))/24,2) idealdys   "
					+ " from gl_vehmaster m "
					+ " left join gl_vmove v on v.fleet_no=m.fleet_no and m.tran_code='RR' "
					+ " inner  join   (select max(doc_no) maxd,fleet_no from gl_vmove group by fleet_no) a "
					+ " on v.doc_no=a.maxd and v.fleet_no=a.fleet_no "
					+ "	left join my_locm l on l.doc_no=m.A_LOC  left join gl_vehgroup g on g.doc_no=m.VGRPID  "
					+ "	left join my_color c on(m.clrid=c.doc_no)  left join gl_vehbrand b on(m.brdid=b.doc_no) left join my_brch br on br.doc_no=m.a_br  "
					+ "	left join gl_yom y on y.doc_no=m.yom  where m.statu=3  "+sqlbrch+" "); 
			
			
		//	System.out.println("---sqldata-----"+sqldata);

			
				ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtVeh1.close();
				conn.close();
				 return RESULTDATA;

		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	public JSONArray nonmovement(String branch,String expdate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlStartDate = null;
     	if(!(expdate.equalsIgnoreCase("undefined"))&&!(expdate.equalsIgnoreCase(""))&&!(expdate.equalsIgnoreCase("0")))
     	{
     		sqlStartDate=ClsCommon.changeStringtoSqlDate(expdate);
     		
     	}
     	else{
     
     	}

     	Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
			    if(branch.equalsIgnoreCase("a"))
		    	{
		        	String sqlexp=("select n.doc_no,br.branchname,v.dout,v.tout,round(v.kmout) kmout,CASE WHEN v.fout='0.000' THEN 'Level 0/8' WHEN v.fout='0.125' "
		        			+ "THEN 'Level 1/8' WHEN v.fout='0.250'THEN 'Level 2/8' WHEN v.fout='0.375' 	THEN 'Level 3/8' WHEN v.fout='0.500' "
		        			+ " THEN 'Level 4/8' WHEN v.fout='0.625' THEN 'Level 5/8'  WHEN v.fout='0.750' THEN 'Level 6/8' WHEN v.fout='0.875' "
		        			+ " THEN 'Level 7/8' WHEN v.fout='1.000' THEN 'Level 8/8' END as 'fout', coalesce(s.st_desc,'') movetype, "
		        			+ "if(n.drid=0,st.sal_name,dr.sal_name) drorstaff,if(n.delivery=0,'NO','YES') delivery , "
		        			+ " if(n.collection=0,'NO','YES') collection,round(TIMESTAMPDIFF(hour,cast(concat(v.dout,' ',v.tout) as datetime),cast(now() as datetime))/24,2) idealdays  "
		        			+ "from gl_nrm n left join my_brch br  on br.doc_no=n.brhid "
		        			+ "left join gl_vmove v on v.rdocno=n.doc_no and v.rdtype='MOV' left join gl_status s   on(v.trancode=s.status)  "
		        			+ "left join my_salesman dr on dr.doc_no=n.drid and dr.sal_type='DRV' "
		        			+ "left join my_salesman st on st.doc_no=n.staffid and st.sal_type='STF'  where n.clstatus=0 and n.status=3 and   n.date<='"+sqlStartDate+"' " );
		//System.out.println("-------"+sqlexp);
					ResultSet resultSet = stmtVeh1.executeQuery (sqlexp);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtVeh1.close();
					
		    	}
		    	else{	
		    		
		    		String sqlexp=("select n.doc_no,br.branchname,v.dout,v.tout,round(v.kmout) kmout,CASE WHEN v.fout='0.000' THEN 'Level 0/8' WHEN v.fout='0.125' "
		        			+ "THEN 'Level 1/8' WHEN v.fout='0.250'THEN 'Level 2/8' WHEN v.fout='0.375' 	THEN 'Level 3/8' WHEN v.fout='0.500' "
		        			+ " THEN 'Level 4/8' WHEN v.fout='0.625' THEN 'Level 5/8'  WHEN v.fout='0.750' THEN 'Level 6/8' WHEN v.fout='0.875' "
		        			+ " THEN 'Level 7/8' WHEN v.fout='1.000' THEN 'Level 8/8' END as 'fout', coalesce(s.st_desc,'') movetype, "
		        			+ " if(n.drid=0,st.sal_name,dr.sal_name) drorstaff,if(n.delivery=0,'NO','YES') delivery , "
		        			+ " if(n.collection=0,'NO','YES') collection,round(TIMESTAMPDIFF(hour,cast(concat(v.dout,' ',v.tout) as datetime),cast(now() as datetime))/24,2) idealdays "
		        			+ " from gl_nrm n left join my_brch br  on br.doc_no=n.brhid "
		        			+ "left join gl_vmove v on v.rdocno=n.doc_no and v.rdtype='MOV' left join gl_status s   on(v.trancode=s.status)  "
		        			+ "left join my_salesman dr on dr.doc_no=n.drid and dr.sal_type='DRV' "
		        			+ "left join my_salesman st on st.doc_no=n.staffid and st.sal_type='STF'   "
		        			+ "where n.clstatus=0 and n.status=3 and n.brhid='"+branch+"' and   n.date<='"+sqlStartDate+"' " );
	
					ResultSet resultSet = stmtVeh1.executeQuery (sqlexp);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtVeh1.close();
					
					
		    	}
				
			    conn.close();
				
		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
}
