package com.controlcentre.settings.servicesettings;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.controlcentre.settings.activity.ClsActivityBean;

public class ClsServiceSettingDAO {
	
	ClsConnection conobj= new ClsConnection();
	ClsCommon com= new ClsCommon();
	
	public int insert(java.sql.Date date,String txtcategory,String txtcode,String txtname,String txtdesc,HttpSession session,HttpServletRequest request,String mode) throws SQLException{
		
		int docno=0;
		Connection conn=null;
		try{
			 conn=conobj.getMyConnection();
			CallableStatement stmt = conn.prepareCall("{CALL SerSettingDML(?,?,?,?,?,?,?,?,?)}");
			stmt.registerOutParameter(9,java.sql.Types.INTEGER);
			stmt.setDate(1,date);	
			stmt.setString(2,txtcategory);
			stmt.setString(3,txtcode.toUpperCase());
			stmt.setString(4,txtname.toUpperCase());
			stmt.setString(5,txtdesc);
			stmt.setString(6,session.getAttribute("BRANCHID").toString());
			stmt.setString(7,session.getAttribute("USERID").toString());
			stmt.setString(8,mode);
			
			int val = stmt.executeUpdate();
			docno=stmt.getInt("docNo");
			
			
			stmt.close();
			conn.close();
			return docno;
			
		}catch(Exception e){	
			e.printStackTrace();
			conn.close();
			}
		finally{
			conn.close();
		}
		
		
		
		return 0;
		
	}
	
public int edit(int docno,java.sql.Date date,String txtcategory,String txtcode,String txtname,String txtdesc,HttpSession session,HttpServletRequest request,String mode) throws SQLException{
		
			Connection conn=null;
		try{
			 conn=conobj.getMyConnection();
			CallableStatement stmt = conn.prepareCall("{CALL SerSettingDML(?,?,?,?,?,?,?,?,?)}");
			
			stmt.setDate(1,date);	
			stmt.setString(2,txtcategory);
			stmt.setString(3,txtcode.toUpperCase());
			stmt.setString(4,txtname.toUpperCase());
			stmt.setString(5,txtdesc);
			stmt.setString(6,session.getAttribute("BRANCHID").toString());
			stmt.setString(7,session.getAttribute("USERID").toString());
			stmt.setString(8,mode);
			stmt.setInt(9,docno);
			
			int val = stmt.executeUpdate();
			docno=stmt.getInt("docNo");
			
			
			stmt.close();
			conn.close();
			return docno;
			
		}catch(Exception e){	
			e.printStackTrace();
			conn.close();
			}
		finally{
			conn.close();
		}
		
		
		return 0;
		
	}

public int delete(int docno,java.sql.Date date,String txtcategory,String txtcode,String txtname,String txtdesc,HttpSession session,HttpServletRequest request,String mode) throws SQLException{
	
	Connection conn=null;
try{
	 conn=conobj.getMyConnection();
	CallableStatement stmt = conn.prepareCall("{CALL SerSettingDML(?,?,?,?,?,?,?,?,?)}");
	
	stmt.setDate(1,date);	
	stmt.setString(2,txtcategory);
	stmt.setString(3,txtcode.toUpperCase());
	stmt.setString(4,txtname.toUpperCase());
	stmt.setString(5,txtdesc);
	stmt.setString(6,session.getAttribute("BRANCHID").toString());
	stmt.setString(7,session.getAttribute("USERID").toString());
	stmt.setString(8,mode);
	stmt.setInt(9,docno);
	
	int val = stmt.executeUpdate();
	docno=stmt.getInt("docNo");
	
	
	stmt.close();
	conn.close();
	return docno;
	
}catch(Exception e){	
	e.printStackTrace();
	conn.close();
	}
finally{
	conn.close();
}


return 0;

}

	
	
	public  JSONArray settingList(HttpSession session,String doctype) throws SQLException {
		 JSONArray RESULTDATA = new JSONArray();
		 Connection conn=null;
			try {
				conn = conobj.getMyConnection();
				String sqltest="";
				if(!(doctype.equalsIgnoreCase("") && doctype.equalsIgnoreCase("0") && doctype.equalsIgnoreCase("null"))){
					sqltest="and grptype="+doctype+"";
				}
				
				 
					 
				    Statement stmtactivity =conn.createStatement();            	
					ResultSet resultSet = stmtactivity.executeQuery ("select DOC_NO doc_no, groupName, DESCRIPTION,grptype dtype, CODENO, date from my_groupvals where status=3 "+sqltest+"");
					System.out.println("select DOC_NO doc_no, groupName, DESCRIPTION,grptype dtype, CODENO, date from my_groupvals where status=3 "+sqltest+"");
					RESULTDATA=com.convertToJSON(resultSet);
					
					
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
	
	
public int insertCm(java.sql.Date date,String txtcategory,String txtcode,String txtname,String txtdesc,HttpSession session,HttpServletRequest request,String mode) throws SQLException{
		
		int docno=0;
		Connection conn=null;
		try{
			 conn=conobj.getMyConnection();
			CallableStatement stmt = conn.prepareCall("{CALL SerCmDML(?,?,?,?,?,?,?,?,?)}");
			stmt.registerOutParameter(9,java.sql.Types.INTEGER);
			stmt.setDate(1,date);	
			stmt.setString(2,txtcategory);
			stmt.setString(3,txtcode.toUpperCase());
			stmt.setString(4,txtname.toUpperCase());
			stmt.setString(5,txtdesc);
			stmt.setString(6,session.getAttribute("BRANCHID").toString());
			stmt.setString(7,session.getAttribute("USERID").toString());
			stmt.setString(8,mode);
			
			int val = stmt.executeUpdate();
			docno=stmt.getInt("docNo");
			
			
			stmt.close();
			conn.close();
			return docno;
			
		}catch(Exception e){	
			e.printStackTrace();
			conn.close();
			}
		finally{
			conn.close();
		}
		return 0;
	
}


public int editCm(int docno,java.sql.Date date,String txtcategory,String txtcode,String txtname,String txtdesc,HttpSession session,HttpServletRequest request,String mode) throws SQLException{
	
	Connection conn=null;
try{
	 conn=conobj.getMyConnection();
	CallableStatement stmt = conn.prepareCall("{CALL SerCmDML(?,?,?,?,?,?,?,?,?)}");
	
	stmt.setDate(1,date);	
	stmt.setString(2,txtcategory);
	stmt.setString(3,txtcode.toUpperCase());
	stmt.setString(4,txtname.toUpperCase());
	stmt.setString(5,txtdesc);
	stmt.setString(6,session.getAttribute("BRANCHID").toString());
	stmt.setString(7,session.getAttribute("USERID").toString());
	stmt.setString(8,mode);
	stmt.setInt(9,docno);
	
	int val = stmt.executeUpdate();
	docno=stmt.getInt("docNo");
	
	
	stmt.close();
	conn.close();
	return docno;
	
}catch(Exception e){	
	e.printStackTrace();
	conn.close();
	}
finally{
	conn.close();
}


return 0;

}


public int deleteCm(int docno,java.sql.Date date,String txtcategory,String txtcode,String txtname,String txtdesc,HttpSession session,HttpServletRequest request,String mode) throws SQLException{
	
	Connection conn=null;
try{
	 conn=conobj.getMyConnection();
	CallableStatement stmt = conn.prepareCall("{CALL SerCmDML(?,?,?,?,?,?,?,?,?)}");
	
	stmt.setDate(1,date);	
	stmt.setString(2,txtcategory);
	stmt.setString(3,txtcode.toUpperCase());
	stmt.setString(4,txtname.toUpperCase());
	stmt.setString(5,txtdesc);
	stmt.setString(6,session.getAttribute("BRANCHID").toString());
	stmt.setString(7,session.getAttribute("USERID").toString());
	stmt.setString(8,mode);
	stmt.setInt(9,docno);
	
	int val = stmt.executeUpdate();
	docno=stmt.getInt("docNo");
	
	
	stmt.close();
	conn.close();
	return docno;
	
}catch(Exception e){	
	e.printStackTrace();
	conn.close();
	}
finally{
	conn.close();
}


return 0;

}


public  JSONArray cmList(HttpSession session,String doctype) throws SQLException {
	 JSONArray RESULTDATA = new JSONArray();
	 Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			String sqltest="";
			if(!(doctype.equalsIgnoreCase("") && doctype.equalsIgnoreCase("0") && doctype.equalsIgnoreCase("null"))){
				sqltest="and dtype="+doctype+"";
			}
			
			
				 
			   Statement stmtactivity =conn.createStatement();            	
				ResultSet resultSet = stmtactivity.executeQuery ("select DOC_NO doc_no,name groupName,rate DESCRIPTION,if(dtype='lcm','Labour Charge','Equipment charge') dtype,code CODENO, date,dtype hdtype from cm_chrgm where status=3 "+sqltest+"");
				System.out.println("select DOC_NO doc_no,name groupName,rate DESCRIPTION,dtype dtype,code CODENO, date from cm_chrgm where status=3 "+sqltest+"");
				RESULTDATA=com.convertToJSON(resultSet);
				
				
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
       return RESULTDATA;
   }




}
