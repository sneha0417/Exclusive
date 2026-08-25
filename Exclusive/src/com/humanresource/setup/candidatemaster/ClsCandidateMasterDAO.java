package com.humanresource.setup.candidatemaster;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.humanresource.setup.employeemaster.ClsEmployeeMasterBean;

import net.sf.json.JSONArray;

public class ClsCandidateMasterDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public int insert(String cnddate,String refno,String cndname,String gender,String cnddob,String nationid,String qualificationid,String expyear,String postapplied,String designationid,String remarks,ArrayList<String> cvarray,HttpSession session,HttpServletRequest request,String mode) throws SQLException{
		
		Connection conn = null;

		java.sql.Date sqlcnddate=null;
		java.sql.Date sqlcnddob=null;
		
 		try{
 			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtCDMS = conn.createStatement();
			
			String company=session.getAttribute("COMPANYID").toString().trim();
 			String branch=session.getAttribute("BRANCHID").toString().trim();
 			String currency=session.getAttribute("CURRENCYID").toString().trim();
 			String userid=session.getAttribute("USERID").toString().trim();
 			
 			qualificationid=qualificationid.trim().equalsIgnoreCase("undefined") || qualificationid.trim().equalsIgnoreCase("NaN") || qualificationid.trim().equalsIgnoreCase("") ||qualificationid.trim().isEmpty()?null:qualificationid.trim();
 			designationid=designationid.trim().equalsIgnoreCase("undefined") || designationid.trim().equalsIgnoreCase("NaN") || designationid.trim().equalsIgnoreCase("") ||designationid.trim().isEmpty()?null:designationid.trim();
 			nationid=nationid.trim().equalsIgnoreCase("undefined") || nationid.trim().equalsIgnoreCase("NaN") || nationid.trim().equalsIgnoreCase("") ||nationid.trim().isEmpty()?null:nationid.trim();
 			expyear=expyear.trim().equalsIgnoreCase("undefined") || expyear.trim().equalsIgnoreCase("NaN") || expyear.trim().equalsIgnoreCase("") ||expyear.trim().isEmpty()?null:expyear.trim();
 			
 			sqlcnddate = ClsCommon.changeStringtoSqlDate(cnddate);
 			sqlcnddob = ClsCommon.changeStringtoSqlDate(cnddob);
 			
			int docno;
			
			CallableStatement stmtCDM = conn.prepareCall("{CALL HR_candidateMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtCDM.registerOutParameter(17, java.sql.Types.INTEGER);
			stmtCDM.setDate(1,sqlcnddate);
			stmtCDM.setString(2,refno);
			stmtCDM.setString(3,cndname);
			stmtCDM.setString(4, gender);
			stmtCDM.setDate(5,sqlcnddob);
			stmtCDM.setString(6, nationid);
			stmtCDM.setString(7, qualificationid);
			stmtCDM.setString(8, expyear);
			stmtCDM.setString(9, postapplied);
			stmtCDM.setString(10, designationid);
			stmtCDM.setString(11, remarks);
			stmtCDM.setString(12, branch);
			stmtCDM.setString(13, company);
			stmtCDM.setString(14, userid);
			stmtCDM.setString(15, "CDM");
			stmtCDM.setString(16, mode);
			stmtCDM.executeQuery();
			docno=stmtCDM.getInt("docNo");
			
			//System.out.println("--- "+docno);
			if (docno <= 0) {
				stmtCDM.close();
				conn.close();
				return docno;
			}else{
				int data=0;
				for(int i=0;i< cvarray.size();i++){
					CallableStatement stmtCDM1=null;
					String[] cvanalyse=cvarray.get(i).split("::");
						if(!cvanalyse[0].equalsIgnoreCase("undefined") && !cvanalyse[0].equalsIgnoreCase("NaN")){
							
							stmtCDM1 = conn.prepareCall("INSERT INTO hr_candidated(rdocno, srno, questions, remarks, grade, status) VALUES(?,?,?,?,?,?)");
							
							//System.out.println(docno);
							stmtCDM1.setInt(1,docno); //doc_no
							stmtCDM1.setInt(2,i+1);
							stmtCDM1.setString(3,(cvanalyse[0].trim().equalsIgnoreCase("undefined") || cvanalyse[0].trim().equalsIgnoreCase("NaN") || cvanalyse[0].trim().equalsIgnoreCase("") ||cvanalyse[0].trim().isEmpty()?0:cvanalyse[0].trim()).toString()); //questions
							stmtCDM1.setString(4,(cvanalyse[1].trim().equalsIgnoreCase("undefined") || cvanalyse[1].trim().equalsIgnoreCase("NaN") || cvanalyse[1].trim().equalsIgnoreCase("") ||cvanalyse[1].trim().isEmpty()?0:cvanalyse[1].trim()).toString()); //remarks
							stmtCDM1.setString(5,(cvanalyse[2].trim().equalsIgnoreCase("undefined") || cvanalyse[2].trim().equalsIgnoreCase("NaN") || cvanalyse[2].trim().equalsIgnoreCase("") ||cvanalyse[2].trim().isEmpty()?0:cvanalyse[2].trim()).toString()); //grade
							stmtCDM1.setInt(6,3);
							data = stmtCDM1.executeUpdate();
							
							if(data<=0){
								stmtCDM1.close();
								conn.close();
								return 0;
							}
							
						}
						
					}
					conn.commit();
					stmtCDM.close();
					stmtCDMS.close();
					return docno;
			}
			
			
 		}catch(Exception e){
 			e.printStackTrace();
 			return 0;
 		}finally{
 			conn.close();
 		}
	}
	
	public int edit(int docno,String cnddate,String refno,String cndname,String gender,String cnddob,String nationid,String qualificationid,String expyear,String postapplied,String designationid,String remarks,ArrayList<String> cvarray,HttpSession session,HttpServletRequest request,String mode) throws SQLException{
		
		Connection conn = null;

		java.sql.Date sqlcnddate=null;
		java.sql.Date sqlcnddob=null;
		//System.out.println("edit val "+docno+" docno"+docno);
		
 		try{
 			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtCDMS = conn.createStatement();
			
			String company=session.getAttribute("COMPANYID").toString().trim();
 			String branch=session.getAttribute("BRANCHID").toString().trim();
 			String currency=session.getAttribute("CURRENCYID").toString().trim();
 			String userid=session.getAttribute("USERID").toString().trim();
 			
 			qualificationid=qualificationid.trim().equalsIgnoreCase("undefined") || qualificationid.trim().equalsIgnoreCase("NaN") || qualificationid.trim().equalsIgnoreCase("") ||qualificationid.trim().isEmpty()?null:qualificationid.trim();
 			designationid=designationid.trim().equalsIgnoreCase("undefined") || designationid.trim().equalsIgnoreCase("NaN") || designationid.trim().equalsIgnoreCase("") ||designationid.trim().isEmpty()?null:designationid.trim();
 			nationid=nationid.trim().equalsIgnoreCase("undefined") || nationid.trim().equalsIgnoreCase("NaN") || nationid.trim().equalsIgnoreCase("") ||nationid.trim().isEmpty()?null:nationid.trim();
 			expyear=expyear.trim().equalsIgnoreCase("undefined") || expyear.trim().equalsIgnoreCase("NaN") || expyear.trim().equalsIgnoreCase("") ||expyear.trim().isEmpty()?null:expyear.trim();
 			
 			
 			sqlcnddate = ClsCommon.changeStringtoSqlDate(cnddate);
 			sqlcnddob = ClsCommon.changeStringtoSqlDate(cnddob);
 			
			
			CallableStatement stmtCDM = conn.prepareCall("{CALL HR_candidateMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtCDM.setInt(17, docno);
			stmtCDM.setDate(1,sqlcnddate);
			stmtCDM.setString(2,refno);
			stmtCDM.setString(3,cndname);
			stmtCDM.setString(4, gender);
			stmtCDM.setDate(5,sqlcnddob);
			stmtCDM.setString(6, nationid);
			stmtCDM.setString(7, qualificationid);
			stmtCDM.setString(8, expyear);
			stmtCDM.setString(9, postapplied);
			stmtCDM.setString(10, designationid);
			stmtCDM.setString(11, remarks);
			stmtCDM.setString(12, branch);
			stmtCDM.setString(13, company);
			stmtCDM.setString(14, userid);
			stmtCDM.setString(15, "CDM");
			stmtCDM.setString(16, mode);
			stmtCDM.executeQuery();
			docno=stmtCDM.getInt("docNo");
			
			//System.out.println("edit val "+docno+" docno"+docno);
			if (docno <= 0) {
				stmtCDM.close();
				conn.close();
				return docno;
			}else{
				int data=0;
				
				String sql1="DELETE FROM hr_candidated WHERE rdocno="+docno+"";
				//System.out.println(sql1);
				
				stmtCDMS.executeUpdate (sql1);
				
				for(int i=0;i< cvarray.size();i++){
					CallableStatement stmtCDM1=null;
					String[] cvanalyse=cvarray.get(i).split("::");
						if(!cvanalyse[0].equalsIgnoreCase("undefined") && !cvanalyse[0].equalsIgnoreCase("NaN")){
							
							stmtCDM1 = conn.prepareCall("INSERT INTO hr_candidated(rdocno, srno, questions, remarks, grade, status) VALUES(?,?,?,?,?,?)");
							
							stmtCDM1.setInt(1,docno); //doc_no
							stmtCDM1.setInt(2,i+1);
							stmtCDM1.setString(3,(cvanalyse[0].trim().equalsIgnoreCase("undefined") || cvanalyse[0].trim().equalsIgnoreCase("NaN") || cvanalyse[0].trim().equalsIgnoreCase("") ||cvanalyse[0].trim().isEmpty()?0:cvanalyse[0].trim()).toString()); //questions
							stmtCDM1.setString(4,(cvanalyse[1].trim().equalsIgnoreCase("undefined") || cvanalyse[1].trim().equalsIgnoreCase("NaN") || cvanalyse[1].trim().equalsIgnoreCase("") ||cvanalyse[1].trim().isEmpty()?0:cvanalyse[1].trim()).toString()); //remarks
							stmtCDM1.setString(5,(cvanalyse[2].trim().equalsIgnoreCase("undefined") || cvanalyse[2].trim().equalsIgnoreCase("NaN") || cvanalyse[2].trim().equalsIgnoreCase("") ||cvanalyse[2].trim().isEmpty()?0:cvanalyse[2].trim()).toString()); //grade
							stmtCDM1.setInt(6,3);
							data = stmtCDM1.executeUpdate();
							
							if(data<=0){
								stmtCDM1.close();
								conn.close();
								return 0;
							}
							
						}
						
					}
					conn.commit();
					stmtCDM.close();
					stmtCDMS.close();
					return docno;
			}
			
			
 		}catch(Exception e){
 			e.printStackTrace();
 			return 0;
 		}finally{
 			conn.close();
 		}
	}
	
	public int delete(HttpSession session,HttpServletRequest request,String mode,int docno) throws SQLException{
		Connection conn = null;
		java.sql.Date sqlcnddate=null;
		java.sql.Date sqlcnddob=null;

 		try{
 			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtCDMS = conn.createStatement();
			
			String company=session.getAttribute("COMPANYID").toString().trim();
 			String branch=session.getAttribute("BRANCHID").toString().trim();
 			String currency=session.getAttribute("CURRENCYID").toString().trim();
 			String userid=session.getAttribute("USERID").toString().trim();
			
			CallableStatement stmtCDM = conn.prepareCall("{CALL HR_candidateMasterDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtCDM.setInt(17, docno);
			stmtCDM.setDate(1,sqlcnddate);
			stmtCDM.setString(2,"");
			stmtCDM.setString(3,"");
			stmtCDM.setString(4, "");
			stmtCDM.setDate(5,sqlcnddob);
			stmtCDM.setString(6, "");
			stmtCDM.setString(7, "");
			stmtCDM.setString(8, "");
			stmtCDM.setString(9, "");
			stmtCDM.setString(10, "");
			stmtCDM.setString(11, "");
			stmtCDM.setString(12, branch);
			stmtCDM.setString(13, company);
			stmtCDM.setString(14, userid);
			stmtCDM.setString(15, "CDM");
			stmtCDM.setString(16, mode);
			stmtCDM.executeQuery();
			docno=stmtCDM.getInt("docNo");
			
			if (docno <= 0) {
				stmtCDM.close();
				conn.close();
				return docno;
			}
			conn.commit();
			stmtCDM.close();
			stmtCDMS.close();
			return docno;
			
 		}catch(Exception e){
 			e.printStackTrace();
 			return 0;
 		}finally{
 			conn.close();
 		}
	}
	
	public  ClsCandidateMasterBean getViewDetails(int docNo) throws SQLException {
		
		ClsCandidateMasterBean bean = new ClsCandidateMasterBean();
		
		Connection conn = null;
		
		try {
		
			conn = ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtCDM = conn.createStatement();

			String sql= ("SELECT  m.nationId,m.qualificationId,m.doc_no,m.date, coalesce(m.refNo,'') refNo, m.name, m.Gender, m.dob, coalesce(m.experience,'') experience, coalesce(m.postapplied,'') postapplied, m.designationId,coalesce(d.desc1,'') designation,"
						+"	coalesce(m.remarks,'') remarks,coalesce(q.desc1,'') qualification,coalesce(n.nation,'') nation FROM hr_candidatem m left join my_natm n on m.nationId=n.doc_no"
						+"	left join hr_designqual q on m.qualificationId=q.doc_no left join hr_setdesig d on m.designationId=d.doc_no where m.status=3 and m.doc_no="+docNo+"");
			
			ResultSet resultSet = stmtCDM.executeQuery(sql);
						
			while (resultSet.next()) {
					bean.setHidnationid(resultSet.getString("nationId"));
					bean.setHidqualificationid(resultSet.getString("qualificationId"));
					bean.setHidcnddate(resultSet.getString("date"));
					bean.setHidcmbgender(resultSet.getString("Gender"));
					bean.setHidcnddob(resultSet.getString("dob"));
					bean.setDocno(resultSet.getInt("doc_no"));
					bean.setTxtcndname(resultSet.getString("name"));
					bean.setTxtexpyear(resultSet.getString("experience"));
					bean.setTxtnationality(resultSet.getString("nation"));
					bean.setTxtqualification(resultSet.getString("qualification"));
					bean.setTxtpostapplied(resultSet.getString("postapplied"));
					bean.setTxtrefno(resultSet.getString("refNo"));
					bean.setTxtremarks(resultSet.getString("remarks"));
					bean.setTxtdesignation(resultSet.getString("designationId"));
					bean.setTxtdesignation(resultSet.getString("designation"));
				}
				stmtCDM.close();
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				conn.close();
			}
		return bean;
	}
	
	public JSONArray nationsSearch() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtEMP = conn.createStatement();
            	
				ResultSet resultSet = stmtEMP.executeQuery ("SELECT doc_no,nation FROM my_natm order by nation");

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtEMP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray getQualificationData() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtEMP = conn.createStatement();
            	
				ResultSet resultSet = stmtEMP.executeQuery ("select *from hr_designqual where status=3 order by desc1;");

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtEMP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray getDesignationData() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtEMP = conn.createStatement();
            	
				ResultSet resultSet = stmtEMP.executeQuery ("select *from hr_setdesig where status=3 order by desc1;");

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtEMP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray cvGridReloading(String docno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCDM = conn.createStatement();
				
				System.out.println("select doc_no, rdocno, srno, questions, remarks, grade from hr_candidated where rdocno="+docno);
				ResultSet resultSet = stmtCDM.executeQuery ("select doc_no, rdocno, srno, questions, remarks, grade from hr_candidated where rdocno="+docno);
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtCDM.close();
				conn.close();

		}catch(Exception e){
			conn.close();
			e.printStackTrace();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray candidateMainSearch(HttpSession session,String cdmname,String cdmdocno,String cdmrefno,String cdmdob) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
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
    
	     java.sql.Date sqlcdmdob=null;
	     cdmdob.trim();
	     if(!(cdmdob.equalsIgnoreCase("undefined"))&&!(cdmdob.equalsIgnoreCase(""))&&!(cdmdob.equalsIgnoreCase("0")))
	     {
	    	 sqlcdmdob = ClsCommon.changeStringtoSqlDate(cdmdob);
	     }
	     
	     String sqltest="";
	     if(!(cdmname.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and m.name like '%"+cdmname+"%'";
	     }
	     if(!(cdmdocno.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and m.doc_no like '%"+cdmdocno+"%'";
	     }
	     if(!(cdmrefno.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and m.refno like '%"+cdmrefno+"%'";
	     }
	     if(!(sqlcdmdob==null)){
	        	sqltest=sqltest+" and m.dob='"+sqlcdmdob+"'";
	        }
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCDM = conn.createStatement();

				ResultSet resultSet = stmtCDM.executeQuery ("select doc_no,name,dob,refno from hr_candidatem m where status=3 "+sqltest);
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtCDM.close();
				conn.close();

		}catch(Exception e){
			conn.close();
			e.printStackTrace();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
}
