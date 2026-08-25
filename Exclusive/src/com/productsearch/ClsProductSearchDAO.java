package com.productsearch;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.http.HttpSession;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import net.sf.json.JSONArray;
public class ClsProductSearchDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	public  JSONArray mainSrearch(HttpSession session,String name,String code,String brand,String cat,String subcat,String docnos,String load) throws SQLException { 
		JSONArray RESULTDATA=new JSONArray();
		if(!load.equalsIgnoreCase("yes"))
		{
			return RESULTDATA;
		}
		String sqltest="";
		if(!(docnos.equalsIgnoreCase("") )){
			sqltest=sqltest+" and  m.doc_no like '%"+docnos+"%'";
		}
		
		if(!(code.equalsIgnoreCase(""))){
			sqltest=sqltest+" and part_no like '%"+code+"%'";
		}
		System.out.println("=====name=="+name);
		if(!(name.equalsIgnoreCase(""))){
			sqltest=sqltest+" and productname like '%"+name+"%'";
		}
		if(!(brand.equalsIgnoreCase(""))){
			sqltest=sqltest+" and b.brand like '%"+brand+"%'";
		}
		if(!(cat.equalsIgnoreCase(""))){
			sqltest=sqltest+" and c.category like '%"+cat+"%' ";
		}
		if(!(subcat.equalsIgnoreCase(""))){
			sqltest=sqltest+" and s.subcategory like '%"+subcat+"%'";
		}
		Connection conn=null;  
			try {
					conn = ClsConnection.getMyConnection();
					Statement stmt = conn.createStatement ();
					String str1Sql=("select m.doc_no docno,part_no as productcode,productname ,b.brandname brand,c.category,s.subcategory "
							+ "from my_main m left join my_ptype t on(m.typeid=t.doc_no) left join "
							+ "my_brand b on(m.brandid=b.doc_no) left join my_catm c on(m.catid=c.doc_no)"
							+ " left join my_scatm s on(m.scatid=s.doc_no) left join my_unitm u "
							+ "on(m.munit=u.doc_no) left join my_dept d on(m.deptid=d.doc_no) where m.status=3 " +sqltest+"    order by m.doc_no");
					ResultSet resultSet = stmt.executeQuery (str1Sql); 
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmt.close();
					conn.close();
				}
				catch(Exception e){
					e.printStackTrace();
					conn.close();
				}
		return RESULTDATA;
	}
}
