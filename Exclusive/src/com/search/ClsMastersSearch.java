package com.search;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.connection.ClsConnection;
public class ClsMastersSearch {
	ClsConnection conobj=new ClsConnection();
	
	public  JSONArray dealerMSearch() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
		try {
				Connection conn = conobj.getMyConnection();
				Statement stmt = conn.createStatement ();
            	
				ResultSet resultSet = stmt.executeQuery ("select name,doc_no from my_vendorm where status<>7");

				RESULTDATA=convertToJSON(resultSet);
				System.out.println("============"+RESULTDATA);
				stmt.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
        return RESULTDATA;
	}
	public  JSONArray financierMSearch() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
		try {
				Connection conn = conobj.getMyConnection();
				Statement stmt = conn.createStatement ();
            	
				ResultSet resultSet = stmt.executeQuery ("select fname,doc_no from gl_vehfin where status<>7");

				RESULTDATA=convertToJSON(resultSet);
				stmt.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
        return RESULTDATA;
	}
	public  JSONArray insuranceMSearch() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
		try {
				Connection conn = conobj.getMyConnection();
				Statement stmt = conn.createStatement ();
            	
				ResultSet resultSet = stmt.executeQuery ("select inname,doc_no from gl_vehin where status<>7");

				RESULTDATA=convertToJSON(resultSet);
				stmt.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
        return RESULTDATA;
	}
	public static JSONArray convertToJSON(ResultSet resultSet)
    			throws Exception {
    			JSONArray jsonArray = new JSONArray();
    			while (resultSet.next()) {
    			int total_rows = resultSet.getMetaData().getColumnCount();
    			JSONObject obj = new JSONObject();
    			for (int i = 0; i < total_rows; i++) {
    				obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), ((resultSet.getObject(i + 1)==null) ? "NA" : resultSet.getObject(i + 1).toString()));
    			}
    			jsonArray.add(obj);
    			}
    			return jsonArray;
    			}
	}
	
