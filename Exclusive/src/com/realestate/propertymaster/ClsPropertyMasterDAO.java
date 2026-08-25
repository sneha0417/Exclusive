package com.realestate.propertymaster;

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

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.finance.nipurchase.suppliers.ClsVendorDetailsDAO;

import net.sf.json.JSONArray;

public class ClsPropertyMasterDAO {

	ClsConnection conobj = new ClsConnection();

	ClsConnection ClsConnection = new ClsConnection();
	ClsPropertyMasterBean temp = new ClsPropertyMasterBean();
	ClsVendorDetailsDAO vendorDetailsDAO = new ClsVendorDetailsDAO();
	ClsCommon ClsCommon = new ClsCommon();
	ClsCommon com = new ClsCommon();

	public JSONArray Load(HttpSession session) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "select a.doc_no as areadocno,a.area as area,c.city_name as city_name,ac.country_name as country_name,r.reg_name as region_name, "
					+ " m.doc_no, m.name, m.plno,   m.date from rl_buildingm m "
					+ " left join    my_area a on m.area=a.doc_no inner join my_acity c on(a.city_id=c.doc_no) "
					+ " left join my_acountry ac on(ac.doc_no=c.country_id) "
					+ "left join my_aregion r on(r.doc_no=ac.reg_id)where m.status=3 ";
System.out.println("sql--->>>"+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);

			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray areaSearch(HttpSession session) throws SQLException {
		JSONArray RESULTDATA = new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a = 0;
		while (Enumeration.hasMoreElements()) {
			if (Enumeration.nextElement().equalsIgnoreCase("BRANCHID")) {
				a = 1;
			}
		}
		if (a == 0) {
			return RESULTDATA;
		}
		String brcid = session.getAttribute("BRANCHID").toString();

		Connection conn = null;
		Statement stmt = null;
		ResultSet resultSet = null;

		try {
			conn = conobj.getMyConnection();
			stmt = conn.createStatement();

			String sql = ("select a.doc_no as areadocno,a.area as area,c.city_name as city_name,ac.country_name as country_name,r.reg_name as region_name from my_area a inner join my_acity c on(a.city_id=c.doc_no) inner join my_acountry ac on(ac.doc_no=c.country_id) inner join my_aregion r on(r.doc_no=ac.reg_id) where a.status=3 and c.status=3 and ac.status=3 and r.status=3");
			resultSet = stmt.executeQuery(sql);
			RESULTDATA = com.convertToJSON(resultSet);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resultSet.close();
			stmt.close();
			conn.close();
		}
		// System.out.println(RESULTDATA);
		return RESULTDATA;

	}
	
	public JSONArray searchsalesman() throws SQLException {

		  System.out.println("salesman search==");

		JSONArray RESULTDATA = new JSONArray();

		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement s = conn.createStatement();

			String smSql = ("SELECT doc_no,sal_name,mob_no FROM my_salm where status=3 ");

			ResultSet resultSet = s.executeQuery(smSql);

			RESULTDATA = ClsCommon.convertToJSON(resultSet);
			s.close();
			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		}
		finally {
			conn.close();
		}
		// System.out.println(RESULTDATA);
		return RESULTDATA;
	}


	public JSONArray searchptypr() throws SQLException {

		JSONArray RESULTDATA = new JSONArray();

		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh1 = conn.createStatement();

			String pySql = ("select  prtype,doc_no FROM rl_propertytype where status=3 ");

			// System.out.println("=====pySql========"+pySql);

			ResultSet resultSet = stmtVeh1.executeQuery(pySql);

			RESULTDATA = ClsCommon.convertToJSON(resultSet);
			stmtVeh1.close();
			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		}
		finally {
			conn.close();
		}
		// System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public JSONArray searchunitm(String docno) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();

		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh1 = conn.createStatement();

			String pySql = (" SELECT u.doc_no, u.date, u.prtype prtypeid,p.prtype, unittype  from rl_unittype u left join "
					+ " rl_propertytype p on p.doc_no=u.prtype where u.status=3 and  p.doc_no='"
					+ docno + "' ");

			System.out.println("=====pySql========" + pySql);

			ResultSet resultSet = stmtVeh1.executeQuery(pySql);

			RESULTDATA = ClsCommon.convertToJSON(resultSet);
			stmtVeh1.close();
			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		}
		finally {
			conn.close();
		}
		// System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public JSONArray omainsearch(HttpSession session, String docnoss,
			String own, String address, String datess, String aa,
			String descriptions, String mob) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();

		if (!aa.equalsIgnoreCase("yes")) {
			return RESULTDATA;
		}

		if (!aa.equalsIgnoreCase("yes")) {
			return RESULTDATA;
		}

		java.sql.Date sqlStartDate = null;
		if (!(datess.equalsIgnoreCase("undefined"))
				&& !(datess.equalsIgnoreCase(""))
				&& !(datess.equalsIgnoreCase("0"))) {
			sqlStartDate = ClsCommon.changeStringtoSqlDate(datess);
		}

		String sqltest = "";

		if ((!(docnoss.equalsIgnoreCase("")))
				&& (!(docnoss.equalsIgnoreCase("NA")))) {
			sqltest = sqltest + " and  voc_no like '%" + docnoss + "%'";
		}
		if ((!(own.equalsIgnoreCase(""))) && (!(own.equalsIgnoreCase("NA")))) {
			sqltest = sqltest + " and primary_owner like '%" + own + "%'  ";
		}
		if ((!(address.equalsIgnoreCase("")))
				&& (!(address.equalsIgnoreCase("NA")))) {
			sqltest = sqltest + " and address like '%" + address + "%'";
		}

		if ((!(descriptions.equalsIgnoreCase("")))
				&& (!(descriptions.equalsIgnoreCase("NA")))) {
			sqltest = sqltest + " and remarks like '%" + descriptions + "%'";
		}

		if ((!(mob.equalsIgnoreCase(""))) && (!(mob.equalsIgnoreCase("NA")))) {
			sqltest = sqltest + "  and a.costcode like '%" + mob + "%'";
		}

		if (!(sqlStartDate == null)) {
			sqltest = sqltest + " and date='" + sqlStartDate + "'";
		}

		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			if (aa.equalsIgnoreCase("yes")) {

				Statement stmtmain = conn.createStatement();

				String pySql = (" select primary_owner owner,doc_no ,voc_no,date,mobile,remarks,status,address,acno  from rl_propertryowner where status<>7     "
						+ sqltest + " ");

				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA = ClsCommon.convertToJSON(resultSet);
				stmtmain.close();

			}
			conn.close();
			return RESULTDATA;
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		}
		finally {
			conn.close();
		}
		// System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public JSONArray materearch(HttpSession session, String docnoss, String own, String paddr, String ptype,  String aa,String unitno) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();

		if (!aa.equalsIgnoreCase("yes")) {
			return RESULTDATA;
		}
		
		String sqltest = "";

		if ((!(docnoss.equalsIgnoreCase("")))
				&& (!(docnoss.equalsIgnoreCase("NA")))) {
			sqltest = sqltest + " and  m.voc_no like '%" + docnoss + "%'";
		}
		if ((!(own.equalsIgnoreCase(""))) && (!(own.equalsIgnoreCase("NA")))) {
			sqltest = sqltest + " and o.primary_owner like '%" + own + "%'  ";
		}
		if ((!(paddr.equalsIgnoreCase("")))
				&& (!(paddr.equalsIgnoreCase("NA")))) {
			sqltest = sqltest + " and m.accname like '%" + paddr + "%'";
		}


		if  ((!(ptype.equalsIgnoreCase("")))
				&& (!(ptype.equalsIgnoreCase("NA"))))  {
			sqltest = sqltest + " and m.ptype='" + ptype + "'";
		}
		if ((!(unitno.equalsIgnoreCase(""))) && (!(unitno.equalsIgnoreCase("0")))) {
			sqltest = sqltest + " and  m.unitno='"+unitno+"'";        
		}
		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			if (aa.equalsIgnoreCase("yes")) {

				Statement stmtmain = conn.createStatement();  

				String pySql = (" select  coalesce(m.unitno,'') unitno,coalesce(m.optid,'') optid,m.doc_no, m.voc_no,m.accname address,  o.primary_owner  owner,m.propertyfor ,pt.code ptype "
						+ " from rl_propertymaster m left join rl_propertryowner o on o.doc_no=m.owid left join rl_propertytype pt on pt.doc_no= m.ptype  where m.status=3  "
					 
						+ sqltest + " ");

				System.out.println("property search sql=" +pySql);
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA = ClsCommon.convertToJSON(resultSet);
				stmtmain.close();

			}
			conn.close();
			return RESULTDATA;
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		}
		finally {
			conn.close();
		}
		// System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public int savemaster(Date masterdate, int docno, String mode, int ownerid,
			int cmbtranstype, String txtoptID, String cmbptype,
			String hidchkpfor, int hidchkmanagedproperty, String txtaddress1,
			String txtaddress2, String txtaccname, String txtlandmark,
			int txtareaid, String propertydesc, int hidpropertytype,
			int cmbcontactperson, String txtcontactnumber, int arm,
			int roomsno, String txtfor, String txtspecialnotes,
			int hidunittypeid, String unitno, int unitofid, int parking,
			String parkingno, String bayno, String txtarea1, String txtyard,
			String txtbuilduparea, String txtpropertyviews,
			String electricwaterno, String gasconnectionno,
			String acconnectionno, String premisesno, int hidcmbrtainerfund,
			String txtmaintainerfund, String txtdevelopername,
			String txtdevaddress1, String txtdevaddress2, String txtdevph,
			String txtdevfax, String txtcontactname, String txtcontactmobile,
			String txtdevbankname, String txtdevaccno,
			String txtdevbankaddress, String txtdevbankph,
			String txtdevbankfax, int cmbcountry, String txtchequeownersname,
			String txtrentalvaluefrom, String txtrentalvalueto,
			String txtnewrent, String txtrntcmsnperc, String txtexpsaleval,
			String txtmgtfeeperc, String txtadminfee, String txtsnagfee,
			String txtothers, Date hidwarratydate, String hidrdoinstype,
			String hidrdoinsasper, String txttermsnotes, int hidcmbOwCommision,
			String txtOwCommisionPerc, String txtOwCommisionAmt,
			int hidcmbOwTransferfee, String txtTransferfeePerc,
			String txttrnsnetselAmt, int hidcmbBuyerCommision,
			String txtBuyerCommisionPerc, String txtBuyerCommisionAmt,
			int hidcmbBuyerTransferfee, String txtBuyerTransferfeePerc,
			String txtBuyerTransferfeeAmt, String txtnetsalepriceow,
			String txtownervalueafterded, String txttotalselprice,
			String txtmodifiedby, Date modified_date,
			String txtmodifiedcomments, ArrayList<String> splinstructionarray,
			ArrayList<String> accessarray,ArrayList<String> furniturearray,int no_of_rooms,int no_of_bath,Date insdate,String pforS,String pforR,String pforHC,  HttpSession session,
			HttpServletRequest request, String formdetailcode, String contractfor,String ownername)     
			throws SQLException {

		Connection conn = null;
/*		System.out.println("contact person id : ---"  + cmbcontactperson);*/
		try {
			conn = ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			Statement st =conn.createStatement();
			String currency = session.getAttribute("CURRENCYID").toString().trim();  
			String propid="0";
			CallableStatement s = conn.prepareCall("{CALL rl_propertymasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
 
			if(mode.equalsIgnoreCase("E")){
            	String syssql2="select if(ptype!='"+cmbptype+"',(select concat(year('"+masterdate+"'),'000',coalesce((SUBSTRING(max(propid), 8)+1),1)) propId from rl_propertymaster where ptype='"+cmbptype+"'),if(year(date)!=year('"+masterdate+"'),(select concat(year('"+masterdate+"'),'000',coalesce((SUBSTRING(propid, 8)),1)) propId from rl_propertymaster where ptype='"+cmbptype+"' and doc_no='"+docno+"'),(select propid from rl_propertymaster where doc_no='"+docno+"')))  propId from rl_propertymaster where doc_no='"+docno+"';";
            	System.out.println("syssql2--------->>>"+syssql2);
            	ResultSet sys2rs = st.executeQuery(syssql2);              
            	while(sys2rs.next()){
            		propid= sys2rs.getString("propId");              
            	}
             }    
			System.out.println("mode--------->>>"+mode);  
			if (mode.equalsIgnoreCase("A")) {
				s.registerOutParameter(94, java.sql.Types.INTEGER);

			} else {
				s.setInt(94, docno);
			}

			s.setDate(1, masterdate);
			s.setInt(2, ownerid);
			s.setString(3, "");
			s.setInt(4, cmbtranstype);
			s.setString(5, session.getAttribute("BRANCHID").toString());
			s.setString(6, session.getAttribute("USERID").toString());
			s.setString(7, session.getAttribute("COMPANYID").toString());
			s.setString(8, txtoptID);
			s.setString(9, cmbptype);
			s.setString(10, hidchkpfor);
			s.setInt(11, hidchkmanagedproperty);
			s.setString(12, txtaddress1);
			s.setString(13, txtaddress2);
			s.setString(14, txtaccname);
			s.setString(15, txtlandmark);
			s.setInt(16, txtareaid);
			s.setString(17, propertydesc);
			s.setInt(18, hidpropertytype);
			s.setInt(19, cmbcontactperson);
			s.setString(20, txtcontactnumber);
			s.setInt(21, arm);
			s.setInt(22, roomsno);
			s.setString(23, txtfor);
			s.setString(24, txtspecialnotes);
			s.setInt(25, hidunittypeid);
			s.setString(26, unitno);
			System.out.println("unit of "+hidunittypeid);
			s.setInt(27, unitofid);
			s.setInt(28, parking);
			s.setString(29, parkingno);
			s.setString(30, bayno);
			s.setString(31, txtarea1);
			s.setString(32, txtyard);
			s.setString(33, txtbuilduparea);
			s.setString(34, txtpropertyviews);
			s.setString(35, electricwaterno);
			s.setString(36, gasconnectionno);
			s.setString(37, acconnectionno);
			s.setString(38, premisesno);
			s.setInt(39, hidcmbrtainerfund);
			s.setString(40, txtmaintainerfund);
			s.setString(41, txtdevelopername);
			s.setString(42, txtdevaddress1);
			s.setString(43, txtdevaddress2);
			s.setString(44, txtdevph);
			s.setString(45, txtdevfax);
			s.setString(46, txtcontactname);
			s.setString(47, txtcontactmobile);
			s.setString(48, txtdevbankname);
			s.setString(49, txtdevaccno);
			s.setString(50, txtdevbankaddress);
			s.setString(51, txtdevbankph);
			s.setString(52, txtdevbankfax);
			s.setInt(53, cmbcountry);
			s.setString(54, txtchequeownersname);
			s.setString(55, txtrentalvaluefrom);
			s.setString(56, txtrentalvalueto);
			s.setString(57, txtnewrent);
			s.setString(58, txtrntcmsnperc);
			s.setString(59, txtexpsaleval);
			s.setString(60, txtmgtfeeperc);
			s.setString(61, txtadminfee);
			s.setString(62, txtsnagfee);
			s.setString(63, txtothers);
			s.setDate(64, hidwarratydate);
			System.out.println(hidrdoinstype+" ============ "+hidrdoinsasper);
			s.setString(65, hidrdoinstype==null?"Q":hidrdoinstype);
			s.setString(66, hidrdoinsasper==null?"T":hidrdoinsasper);
			s.setString(67, txttermsnotes);
			s.setInt(68, hidcmbOwCommision);
			s.setString(69, txtOwCommisionPerc);
			s.setString(70, txtOwCommisionAmt);
			s.setInt(71, hidcmbOwTransferfee);
			s.setString(72, txtTransferfeePerc);
			s.setString(73, txttrnsnetselAmt);
			s.setInt(74, hidcmbBuyerCommision);
			s.setString(75, txtBuyerCommisionPerc);
			s.setString(76, txtBuyerCommisionAmt);
			s.setInt(77, hidcmbBuyerTransferfee);
			s.setString(78, txtBuyerTransferfeePerc);
			s.setString(79, txtBuyerTransferfeeAmt);
			s.setString(80, txtnetsalepriceow);
			s.setString(81, txtownervalueafterded);
			s.setString(82, txttotalselprice);
			s.setString(83, txtmodifiedby);
			s.setDate(84, modified_date);
			s.setString(85, txtmodifiedcomments);
			s.setString(86, mode);
			s.setString(87, formdetailcode);			
			s.setInt(88, no_of_rooms);
			s.setInt(89, no_of_bath);
			s.setDate(90, insdate);
			
			s.setString(91, pforS);
			s.setString(92, pforR);
			s.setString(93, pforHC);
			s.setString(95, contractfor);    

			int val = s.executeUpdate();
			docno = s.getInt("docNo");
			System.out.println("val--------->>>"+val);
			if(mode.equalsIgnoreCase("D")){
				conn.commit();
				conn.close();
				return val;
			}
            if(mode.equalsIgnoreCase("A")){
            	String syssql1="select concat(year('"+masterdate+"'),'000',coalesce((SUBSTRING(max(propid), 8)+1),1)) propId from rl_propertymaster where ptype='"+cmbptype+"'";
            	System.out.println("syssql1--------->>>"+syssql1);
            	ResultSet sysrs = st.executeQuery(syssql1);            
            	while(sysrs.next()){
            		propid= sysrs.getString("propId");            
            	}     
            }
            String syssql3="update rl_propertymaster set propid='"+propid+"' where doc_no='"+docno+"'";  
            System.out.println("syssql3--------->>>"+syssql3);
            int sysval = st.executeUpdate(syssql3);                    
            
            String qry="select h.description accname,h.account accountno from my_head h left join rl_propertymaster m on m.mrf_acno=h.doc_no where m.doc_no="+docno;
			ResultSet rst = st.executeQuery(qry);
			if (rst.first()) {
				request.setAttribute("accountno", rst.getInt("accountno"));
				request.setAttribute("accname", rst.getString("accname"));
			}
			
			Statement st1 = conn.createStatement(); 
			String qry1="select concat(t.prtype,m.propid) propid,o.acno from rl_propertymaster m left join rl_propertytype t on t.doc_no=m.ptype left join rl_propertryowner o  on o.doc_no=m.owid where m.doc_no="+docno;
			ResultSet rst1 = st1.executeQuery(qry1);  
			if (rst1.first()) {
				request.setAttribute("sysgenid", rst1.getString("propid"));
				request.setAttribute("owacno", rst1.getString("acno"));
			}
			
			System.out.println("propertymaster docno =" + docno);

			if (val > 0 && docno > 0) {

				/* Special Instruction Grid Saving */
				for (int j = 0; j < splinstructionarray.size(); j++) {
					String[] spl = splinstructionarray.get(j).split("::");
					if (!spl[0].trim().equalsIgnoreCase("undefined")
							&& !spl[0].trim().equalsIgnoreCase("NaN")) {

						CallableStatement s1 = conn.prepareCall("{CALL rl_specialinstructionsDML(?,?,?,?)}");
						 
						s1.setInt(1, docno);
						s1.setString(
								2,
								(spl[0].trim().equalsIgnoreCase("undefined")
										|| spl[0].trim()
												.equalsIgnoreCase("NaN")
										|| spl[0].trim().isEmpty() ? 0 : spl[0]
										.trim()).toString()); // spl instruction
						int spid = Integer.parseInt(spl[1].equalsIgnoreCase("")
								|| spl[1].equalsIgnoreCase("undefined")
								|| spl[1] == null ? "0" : spl[1]);
						s1.setInt(3, spid); // spid
						s1.setString(4, mode);
						int splinschk = s1.executeUpdate();
						
						System.out.println("spl instruction  query="+s1);
						
						System.out.println("spl instruction check ="+splinschk);
						if (splinschk <= 0) {
							s1.close();
							return 0;
						}
						s1.close();
					}
				}
				/* Special Instruction Grid Saving Ends */
				 	
				/* Access Grid Saving */
				for (int j = 0; j < accessarray.size(); j++) {
				 
					String[] acc = accessarray.get(j).split("::");
					if (!acc[1].trim().equalsIgnoreCase("undefined")
							&& !acc[1].trim().equalsIgnoreCase("NaN")) {

						CallableStatement s2 = conn.prepareCall("{CALL rl_acccessDML(?,?,?,?,?,?)}");
						 
						s2.setInt(1, docno);
						int acid = Integer.parseInt(acc[0].equalsIgnoreCase("")
								|| acc[0].equalsIgnoreCase("undefined")
								|| acc[0] == null ? "0" : acc[0]);
						s2.setInt(2, acid); // access id
						
						s2.setString(
								3,
								(acc[1].trim().equalsIgnoreCase("undefined")
										|| acc[1].trim()
												.equalsIgnoreCase("NaN")
										|| acc[1].trim().isEmpty() ? 0 : acc[1]
										.trim()).toString()); // type of key
						
						s2.setString(
								4,
								(acc[2].trim().equalsIgnoreCase("undefined")
										|| acc[2].trim()
												.equalsIgnoreCase("NaN")
										|| acc[2].trim().isEmpty() ? 0 : acc[2]
										.trim()).toString()); // identity
						s2.setString(
								5,
								(acc[3].trim().equalsIgnoreCase("undefined")
										|| acc[3].trim()
												.equalsIgnoreCase("NaN")
										|| acc[3].trim().isEmpty() ? 0 : acc[3]
										.trim()).toString()); // noof keys
						s2.setString(6, mode);
						int accchk = s2.executeUpdate();
						System.out.println("accgridsave=="+accchk);
						if (accchk <= 0) {
							s2.close();
							return 0;
						}
						s2.close();
					}
				}
				/* Access Grid Saving Ends */
				
				/* selected furniture Grid Saving */
				/*for (int j = 0; j <furniturearray.size(); j++) {
					String[] fur = furniturearray.get(j).split("::");
					if (!fur[1].trim().equalsIgnoreCase("undefined")
							&& !fur[1].trim().equalsIgnoreCase("NaN")) {

						CallableStatement s3 = c
								.prepareCall("{CALL rl_proomfurnfixDML(?,?,?,?)}");
						s3.setInt(1, docno);
						int rid=Integer.parseInt(fur[1].equalsIgnoreCase("")
								|| fur[1].equalsIgnoreCase("undefined")
								|| fur[1] == null ? "0" : fur[1]);
						s3.setInt(2, rid);	
						int furid = Integer.parseInt(fur[0].equalsIgnoreCase("")
								|| fur[0].equalsIgnoreCase("undefined")
								|| fur[0] == null ? "0" : fur[0]);
						s3.setInt(3, furid);  
						s3.setString(4, mode);
						int furchk = s3.executeUpdate();
						if (furchk <= 0) {
							s3.close();
							return 0;
						}
						s3.close();
					}
				}*/
				/*selected furniture  Grid Saving Ends */
				
                int insval=0;
				if (mode.equalsIgnoreCase("A")) {
                        
					String inssql1="insert into re_proomfurnfix( pdoc_no, rdoc_no, furnfixdoc_no) SELECT '"+docno+"',rdoc_no,f.doc_no FROM re_mfurnfix f where ftype=0 and rdoc_no in (1,2,3,4,5,6) and "+hidchkmanagedproperty+"=1 and "+hidunittypeid+" in (3,11,14,19,26) order by rdoc_no,ftype,sr_no";
					insval=s.executeUpdate(inssql1);             
					//System.out.println(insval+"<<<---inssql1--->>>"+inssql1);
					
					String inssql2="insert into re_proomfurnfix( pdoc_no, rdoc_no, furnfixdoc_no) SELECT '"+docno+"',rdoc_no,f.doc_no FROM re_mfurnfix f where ftype=0 and rdoc_no in (1,2,3,4,5,6,7,8) and "+hidchkmanagedproperty+"=1 and "+hidunittypeid+" in (6,20,29) order by rdoc_no,ftype,sr_no";
					insval=s.executeUpdate(inssql2);
					//System.out.println(insval+"<<<---inssql2--->>>"+inssql2);
					
					String inssql3="insert into re_proomfurnfix( pdoc_no, rdoc_no, furnfixdoc_no) SELECT '"+docno+"',rdoc_no,f.doc_no FROM re_mfurnfix f where ftype=0 and rdoc_no in (1,2,3,4,5,6,7,8,9,10,15) and "+hidchkmanagedproperty+"=1 and "+hidunittypeid+" in (1,15,21,25) order by rdoc_no,ftype,sr_no";
					insval=s.executeUpdate(inssql3);
					//System.out.println(insval+"<<<---inssql3--->>>"+inssql3);
					
					String inssql4="insert into re_proomfurnfix( pdoc_no, rdoc_no, furnfixdoc_no) SELECT '"+docno+"',rdoc_no,f.doc_no FROM re_mfurnfix f where ftype=0 and rdoc_no in (1,2,3,4,5,6,7,8,9,10,11,12,15) and "+hidchkmanagedproperty+"=1 and "+hidunittypeid+" in (9,16,22,30) order by rdoc_no,ftype,sr_no";
					insval=s.executeUpdate(inssql4);
					//System.out.println(insval+"<<<---inssql4--->>>"+inssql4);
					
					String inssql5="insert into re_proomfurnfix( pdoc_no, rdoc_no, furnfixdoc_no) SELECT '"+docno+"',rdoc_no,f.doc_no FROM re_mfurnfix f where ftype=0 and rdoc_no in (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15) and "+hidchkmanagedproperty+"=1 and "+hidunittypeid+" in (5,17,18,27) order by rdoc_no,ftype,sr_no";
					insval=s.executeUpdate(inssql5);
					//System.out.println(insval+"<<<---inssql5--->>>"+inssql5);
					
					String inssql6="insert into re_proomfurnfix( pdoc_no, rdoc_no, furnfixdoc_no) SELECT '"+docno+"',rdoc_no,f.doc_no FROM re_mfurnfix f where ftype=0 and rdoc_no in (1,2,3,5,15) and "+hidchkmanagedproperty+"=1 and "+hidunittypeid+" in (7,10,28) order by rdoc_no,ftype,sr_no";
					insval=s.executeUpdate(inssql6);   
					//System.out.println(insval+"<<<---inssql6--->>>"+inssql6);         
					
					String sql = "select voc_no from rl_propertymaster where doc_no="
							+ docno + " ";
					ResultSet rs = s.executeQuery(sql);
					if (rs.first()) {

						request.setAttribute("vocno", rs.getInt("voc_no"));
					}
				}
					if (mode.equalsIgnoreCase("A")) {
					int catm = 1;
					int accgrp = 0;

					String sqls = "select doc_no,acc_group accgrp  from my_clcatm where status=3 and dtype='VND' and tenant=1 "
							+ " union all select doc_no,acc_group  accgrp  from my_clcatm where status=3 and dtype='VND'  limit 1 ";

					ResultSet rss = s.executeQuery(sqls);
					if (rss.first()) {
						catm = rss.getInt("doc_no");
						accgrp = rss.getInt("accgrp");
					}
					//System.out.println("IN...........................DJ");   
                    String strvals="";  
                    
					int vals = insert(masterdate, "VND",txtaccname, "" + currency, "" + catm, "" + 1,"" + 0, "" + accgrp, "" + 0, 0, 0, 0, ownername, txtaddress1,strvals, strvals, strvals, "" + 0, strvals,strvals, "" + 0, session, request,conn);
					//System.out.println("vals..........................."+vals);
					String acno = request.getAttribute("acno").toString();  
					
					request.setAttribute("acno", acno);             
					String sqls1 = "update rl_propertymaster set acno='" + acno
							+ "' where doc_no='" + docno + "' ";
					s.executeUpdate(sqls1);

					if (vals > 0) {
						conn.commit();  
						s.close();
						conn.close();
						return docno;  
					} 
				   }
					if(mode.equalsIgnoreCase("E")){
						String inssql="select doc_no from re_proomfurnfix where pdoc_no='"+docno+"'";
						ResultSet rsins=s.executeQuery(inssql);             
						//System.out.println(insval+"<<<---inssql--->>>"+inssql);	    
						if(rsins.next()){
							
						}else{  
							String inssql1="insert into re_proomfurnfix( pdoc_no, rdoc_no, furnfixdoc_no) SELECT '"+docno+"',rdoc_no,f.doc_no FROM re_mfurnfix f where ftype=0 and rdoc_no in (1,2,3,4,5,6) and "+hidchkmanagedproperty+"=1 and "+hidunittypeid+" in (3,11,14,19,26) order by rdoc_no,ftype,sr_no";
							insval=s.executeUpdate(inssql1);             
							//System.out.println(insval+"<<<---inssql1--->>>"+inssql1);
							
							String inssql2="insert into re_proomfurnfix( pdoc_no, rdoc_no, furnfixdoc_no) SELECT '"+docno+"',rdoc_no,f.doc_no FROM re_mfurnfix f where ftype=0 and rdoc_no in (1,2,3,4,5,6,7,8) and "+hidchkmanagedproperty+"=1 and "+hidunittypeid+" in (6,20,29) order by rdoc_no,ftype,sr_no";
							insval=s.executeUpdate(inssql2);
							//System.out.println(insval+"<<<---inssql2--->>>"+inssql2);
							
							String inssql3="insert into re_proomfurnfix( pdoc_no, rdoc_no, furnfixdoc_no) SELECT '"+docno+"',rdoc_no,f.doc_no FROM re_mfurnfix f where ftype=0 and rdoc_no in (1,2,3,4,5,6,7,8,9,10,15) and "+hidchkmanagedproperty+"=1 and "+hidunittypeid+" in (1,15,21,25) order by rdoc_no,ftype,sr_no";
							insval=s.executeUpdate(inssql3);
							//System.out.println(insval+"<<<---inssql3--->>>"+inssql3);
							
							String inssql4="insert into re_proomfurnfix( pdoc_no, rdoc_no, furnfixdoc_no) SELECT '"+docno+"',rdoc_no,f.doc_no FROM re_mfurnfix f where ftype=0 and rdoc_no in (1,2,3,4,5,6,7,8,9,10,11,12,15) and "+hidchkmanagedproperty+"=1 and "+hidunittypeid+" in (9,16,22,30) order by rdoc_no,ftype,sr_no";
							insval=s.executeUpdate(inssql4);
							//System.out.println(insval+"<<<---inssql4--->>>"+inssql4);
							
							String inssql5="insert into re_proomfurnfix( pdoc_no, rdoc_no, furnfixdoc_no) SELECT '"+docno+"',rdoc_no,f.doc_no FROM re_mfurnfix f where ftype=0 and rdoc_no in (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15) and "+hidchkmanagedproperty+"=1 and "+hidunittypeid+" in (5,17,18,27) order by rdoc_no,ftype,sr_no";
							insval=s.executeUpdate(inssql5);
							//System.out.println(insval+"<<<---inssql5--->>>"+inssql5);
							
							String inssql6="insert into re_proomfurnfix( pdoc_no, rdoc_no, furnfixdoc_no) SELECT '"+docno+"',rdoc_no,f.doc_no FROM re_mfurnfix f where ftype=0 and rdoc_no in (1,2,3,5,15) and "+hidchkmanagedproperty+"=1 and "+hidunittypeid+" in (7,10,28) order by rdoc_no,ftype,sr_no";
							insval=s.executeUpdate(inssql6);   
							//System.out.println(insval+"<<<---inssql6--->>>"+inssql6);    
						}
						
					int catm = 1;
					int accgrp = 0;

					String sqls = "select doc_no,acc_group accgrp  from my_clcatm where status=3 and dtype='VND' and tenant=1 "
							+ " union all select doc_no,acc_group  accgrp  from my_clcatm where status=3 and dtype='VND'  limit 1 ";

					ResultSet rss = s.executeQuery(sqls);
					if (rss.first()) {
						catm = rss.getInt("doc_no");
						accgrp = rss.getInt("accgrp");
					}

					int cldocno = 0;
					int acno = 0;

					String sqlss = "select cldocno,acno from my_acbook where dtype='VND' and acno=(select acno from rl_propertymaster where doc_no="
							+ docno + ") ";

					ResultSet rsss = s.executeQuery(sqlss);  
					if (rsss.first()) {
						cldocno = rsss.getInt("cldocno");
						acno = rsss.getInt("acno");
					}

					int vals = edit(cldocno, "VND", masterdate,
							txtaccname, "" + currency, "" + catm, "" + 1, "" + 0,
							"" + accgrp, "" + acno, 0, 0, 0, "", "", "",
							"", "", "" + 0, "", "", "" + 0,
							session,conn);

					if (vals > 0) {    
						conn.commit();
						s.close();
						conn.close();
						return docno;
					} 
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		}
		finally {
			conn.close();    
		}
		return 0;
	}

	/*
	 * public ClsPropertyMasterBean getData(int docno) throws SQLException {
	 * 
	 * Connection conn=null; try {
	 * 
	 * 
	 * conn = ClsConnection.getMyConnection(); Statement
	 * stmt=conn.createStatement();
	 * 
	 * String sqls=
	 * "select   m.owid,o.primary_owner  owner, m.date, m.name, m.ttype,t.transtype, m.mgprpty, m.address, m.landmark, m.area areaid,aa.area, m.desc1, "
	 * +
	 * "  m.prtype,pt.prtype pname, m.prunit,ut.unittype, m.add_room, m.no_ofroom, m.prfor, m.unitno, m.unitof,bm.name bname, m.parking, "
	 * +
	 * "  m.parking_no, m.bay_no, m.area_sq, m.buildup_area, m.yard, m.elec_water, m.gas_con, m.ac_con, m.pre_no "
	 * +
	 * " from rl_propertymaster m left join rl_propertryowner o on o.doc_no=m.owid "
	 * +
	 * " left join rl_transtype t on t.doc_no=m.ttype left join rl_propertytype pt on pt.doc_no=m.prtype "
	 * + " left   join rl_unittype ut on ut.doc_no=m.prunit  " +
	 * " left  join my_area aa on aa.doc_no=m.area  left   join rl_buildingm bm on bm.doc_no=m.unitof "
	 * + "where m.status=3 and m.doc_no="+docno+" " ; ResultSet
	 * rss=stmt.executeQuery(sqls); if(rss.first()) {
	 * 
	 * temp.setHiddate(rss.getString("date"));
	 * temp.setOwner(rss.getString("owner"));
	 * temp.setOwnerid(rss.getInt("owid"));
	 * temp.setPropertyname(rss.getString("name"));
	 * temp.setPropertytype(rss.getString("transtype"));
	 * temp.setHidpropertytype(rss.getInt("ttype"));
	 * temp.setHidchkmanagedproperty(rss.getInt("mgprpty"));
	 * temp.setPropertyaddress(rss.getString("address"));
	 * temp.setLandmark(rss.getString("landmark"));
	 * 
	 * temp.setTxtareaid(rss.getInt("areaid"));
	 * temp.setTxtarea(rss.getString("area"));
	 * temp.setPropertyaddress(rss.getString("desc1"));
	 * temp.setPropertytype(rss.getString("pname"));
	 * temp.setHidpropertytype(rss.getInt("prtype"));
	 * 
	 * temp.setUnittype(rss.getString("unittype"));
	 * temp.setHidunittype(rss.getInt("prunit"));
	 * 
	 * temp.setHidarm(rss.getInt("add_room"));
	 * 
	 * temp.setRoomsno(rss.getInt("no_ofroom"));
	 * 
	 * 
	 * temp.setTxtfor(rss.getString("prfor"));
	 * 
	 * temp.setUnitno(rss.getString("unitno"));
	 * 
	 * temp.setUnitofid(rss.getInt("unitof"));
	 * temp.setUnitof(rss.getString("bname"));
	 * 
	 * temp.setParking(rss.getInt("parking"));
	 * 
	 * temp.setParkingno(rss.getString("parking_no"));
	 * 
	 * temp.setBayno(rss.getString("bay_no"));
	 * temp.setTxtareasqft(rss.getString("area_sq"));
	 * temp.setBuilduparea(rss.getString("buildup_area"));
	 * temp.setYard(rss.getString("yard"));
	 * temp.setElectricwaterno(rss.getString("elec_water"));
	 * temp.setGasconnectionno(rss.getString("gas_con"));
	 * 
	 * temp.setAcconnectionno(rss.getString("ac_con"));
	 * temp.setPremisesno(rss.getString("pre_no"));
	 * 
	 * 
	 * 
	 * }
	 * 
	 * 
	 * 
	 * } catch(Exception e) { e.printStackTrace(); conn.close(); }
	 * 
	 * 
	 * 
	 * 
	 * 
	 * return temp; }
	 */
	public JSONArray AccessLoadByPropertyID(HttpSession session, int docno)
			throws SQLException {

		JSONArray RESULTDATA = new JSONArray();
		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql = "SELECT acid,doc_no, sr_no, Acsutility, AcsNo, Aqty FROM re_access where doc_no="
					+ docno;
			System.out.println("accessgrid sql"+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray SpecialInstructionsLoadByPropertyID(HttpSession session,
			int docno) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();
		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql = "select doc_no, sr_no, sp_inst, chk,sp_id as spinsid from re_spinstruct where doc_no="
					+ docno;
			System.out.println("sql====="+sql);  
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray furnitureLoadByPropertyRoomID(HttpSession session, int pdocno,int rdocno) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();
		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql = "SELECT r.doc_no,r.rdoc_no,r.fdesc1,if(p.doc_no>0,true,false) chk,if(ftype=0,'Inspection','Furnitures') dtype  FROM re_mfurnfix r left join re_proomfurnfix p on r.doc_no=p.furnfixdoc_no and p.pdoc_no="+pdocno+" and p.rdoc_no="+rdocno+" where r.rdoc_no="+rdocno+" order by ftype,sr_no";						 
						  
			
			System.out.println("furniture query=" +sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray furnitureLoadByRoomID(HttpSession session, int docno)
			throws SQLException {
		
		System.out.println("room id="+docno);
		JSONArray RESULTDATA = new JSONArray();
		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql = "SELECT * FROM re_mfurnfix  where ftype=1 and rdoc_no="+ docno+" order by ftype,sr_no";
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
		return RESULTDATA;
	}
	public int insert(Date vendorDate, String formdetailcode, String txtvendorname,String cmbcurrency, String cmbcategory, String cmbtype, String txtregisteredtrnno,
			String cmbaccgroup, String txtaccount, int txtcredit_period_min,int txtcredit_period_max, int txtcredit_limit, String txtaddress, String txtaddress1, 
			String txttel, String txtmob, String txtoffice,String txtfax, String txtemail, String txtcontact, String txtextno, HttpSession session, 
			HttpServletRequest request,Connection conn) throws SQLException {
		
		
		try{
				//conn=ClsConnection.getMyConnection();
				//conn.setAutoCommit(false);
				
				String company=session.getAttribute("COMPANYID").toString().trim();  
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String currency=session.getAttribute("CURRENCYID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				 System.out.println("IN...VND");
				CallableStatement stmtVND = conn.prepareCall("{CALL vendorDetailsDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

				stmtVND.registerOutParameter(25, java.sql.Types.INTEGER);
				stmtVND.registerOutParameter(26, java.sql.Types.INTEGER);
				stmtVND.setDate(1,vendorDate);
				stmtVND.setString(2,txtvendorname);
				stmtVND.setString(3,cmbcurrency);
				stmtVND.setString(4,cmbcategory);
				stmtVND.setString(5,cmbtype);
				stmtVND.setString(6,txtregisteredtrnno);
				
				stmtVND.setString(7,cmbaccgroup);
				stmtVND.setInt(8,txtcredit_period_min);
				stmtVND.setInt(9,txtcredit_period_max);
				stmtVND.setInt(10,txtcredit_limit);

				stmtVND.setString(11,txtaddress);
				stmtVND.setString(12,txtaddress1);
				stmtVND.setString(13,txttel);
				stmtVND.setString(14,txtmob);
				stmtVND.setString(15,txtoffice);
				stmtVND.setString(16,txtfax);
				stmtVND.setString(17,txtemail);
				stmtVND.setString(18,txtcontact);
				stmtVND.setString(19,txtextno);
				
				stmtVND.setString(20,formdetailcode);
				stmtVND.setString(21,currency);
				stmtVND.setString(22,branch);
				stmtVND.setString(23,company);
				stmtVND.setString(24,userid);
				stmtVND.setString(27,"A");
				int val=stmtVND.executeUpdate();
				System.out.println("val------------>>>"+val);
				int docno=stmtVND.getInt("docNo");
				int accountno=stmtVND.getInt("documentNo");
				request.setAttribute("acno", accountno);
				
				//vendorDetailsBean.setTxtvendordocno(docno);
				if (docno>0 && accountno>0) {
					
					
					
					
					
					
					stmtVND.close();
					//conn.close();
					return docno;
				}
				
				stmtVND.close();
				//conn.close();
			 }catch(Exception e){
				 	e.printStackTrace();
				 	//conn.close();
				 	return 0;
			 }finally{
				 //conn.close();
			 }
		return 0;
	}
	public int edit(int txtvendordocno, String formdetailcode, Date vendorDate,String txtvendorname, String cmbcurrency, String cmbcategory, String cmbtype, 
			String txtregisteredtrnno, String cmbaccgroup, String txtaccount, int txtcredit_period_min,int txtcredit_period_max, int txtcredit_limit, 
			String txtaddress, String txtaddress1, String txttel, String txtmob, String txtoffice,String txtfax, String txtemail, String txtcontact, String txtextno,
			HttpSession session,Connection conn) throws SQLException {
		
			//Connection conn = null;
		
		    try{
		    		//conn=connDAO.getMyConnection();
					///conn.setAutoCommit(false);
				
			    	String company=session.getAttribute("COMPANYID").toString().trim();
		 			String branch=session.getAttribute("BRANCHID").toString().trim();
		 			String currency=session.getAttribute("CURRENCYID").toString().trim();
		 			String userid=session.getAttribute("USERID").toString().trim();
				
					CallableStatement stmtVND = conn.prepareCall("{CALL vendorDetailsDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");		

					stmtVND.setInt(25,txtvendordocno);
					stmtVND.setString(26,txtaccount);
					stmtVND.setDate(1,vendorDate);
					stmtVND.setString(2,txtvendorname);
					stmtVND.setString(3,cmbcurrency);
					stmtVND.setString(4,cmbcategory);
					stmtVND.setString(5,cmbtype);
					stmtVND.setString(6,txtregisteredtrnno);
					
					stmtVND.setString(7,cmbaccgroup);
					stmtVND.setInt(8,txtcredit_period_min);
					stmtVND.setInt(9,txtcredit_period_max);
					stmtVND.setInt(10,txtcredit_limit);

					stmtVND.setString(11,txtaddress);
					stmtVND.setString(12,txtaddress1);
					stmtVND.setString(13,txttel);
					stmtVND.setString(14,txtmob);
					stmtVND.setString(15,txtoffice);
					stmtVND.setString(16,txtfax);
					stmtVND.setString(17,txtemail);
					stmtVND.setString(18,txtcontact);
					stmtVND.setString(19,txtextno);
					
					stmtVND.setString(20,formdetailcode);
					stmtVND.setString(21,currency);
					stmtVND.setString(22,branch);
					stmtVND.setString(23,company);
					stmtVND.setString(24,userid);
					stmtVND.setString(27,"E");
					stmtVND.executeQuery();
					int docno=stmtVND.getInt("docNo");
					int accountno=stmtVND.getInt("documentNo");
					
					//vendorDetailsBean.setTxtvendordocno(docno);
					if (docno > 0 && accountno > 0) {
						
						//conn.commit();
						stmtVND.close();
						//conn.close();
						return 1;
					}
					stmtVND.close();
					//conn.close();
			 }catch(Exception e){
				 	e.printStackTrace();
				 	//conn.close();
				 	return 0;
			 }finally{
				 //conn.close();
			 }
		return 0;
	}

}
