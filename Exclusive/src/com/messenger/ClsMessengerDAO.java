package com.messenger;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsMessengerDAO {
	
	
	
	
	public  JSONArray userSearch(HttpSession session) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        ClsConnection ClsConnection=new ClsConnection();

        ClsCommon ClsCommon=new ClsCommon();

        Connection conn =null;
        Statement stmtVeh =null;
		try {
				 conn = ClsConnection.getMyConnection();
				 stmtVeh = conn.createStatement ();
				 String currentuser=session.getAttribute("USERID").toString();
				//String sql="";
				//ResultSet resultSet ;
				//System.out.println("========="+brnchval);
            	
            		String sql="select user_id as user,doc_no  from my_user WHERE STATUS=3 and doc_no<>'"+currentuser+"' order by doc_no";
            //	System.out.println("----"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				conn.close();
            	

		}
		catch(Exception e){
			
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	

}
