package com.connection;
import java.sql. *;
import java.util.logging.*;

import javax.naming. *;
import javax.sql.*;

public class ClsConnection {
	Statement stmt=null;
	
	public  Connection getMyConnection()
	{
		Connection conn=null;
		try {  
            Context ctx = new InitialContext();  
            DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/carrental");  
            conn = ds.getConnection();  
          
        }    
        catch (NamingException ex) {  
            Logger.getLogger(ClsConnection.class.getName()).log(Level.SEVERE, null, ex);  
        }  
        catch (SQLException sqle) {  
            sqle.printStackTrace();  
        }  
		// System.out.println("----conn---"+conn);
        return conn;  
	}

	public String execute ()
	{
		try{
				Connection conn = getMyConnection();
				Statement stmt = conn.createStatement();
				String strSql = "select * from my_menu limit 5";
				ResultSet rs = stmt.executeQuery (strSql);
				while (rs.next ()) {
				//System.out.println (rs.getString ("MENU_NAME"));
				}
				conn.close ();
				stmt.close ();
		}
		catch(Exception e){
				e.printStackTrace();
		}
		return "success";
	}

}
