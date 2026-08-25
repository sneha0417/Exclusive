package com.controlcentre.settings.approvalmaster;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.controlcentre.settings.approvalmaster.ClsApprovalMasterBean;
import com.connection.ClsConnection;
public class ClsApprovalMasterDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

ClsApprovalMasterBean approvalmasterBean=new ClsApprovalMasterBean();
Connection conn;
public int insert(String doctype,ArrayList<String> tempuserrole,String templevel,HttpSession session,String mode,String formcode) throws SQLException {
try{
	int docno;
	 conn=ClsConnection.getMyConnection();
	 conn.setAutoCommit(false);
	CallableStatement stmtApprovalMaster = conn.prepareCall("{call apprMasterDML(?,?,?,?,?,?)}");

	stmtApprovalMaster.registerOutParameter(5, java.sql.Types.INTEGER);
	stmtApprovalMaster.setString(1,doctype);
	stmtApprovalMaster.setString(2,session.getAttribute("USERID").toString());
	stmtApprovalMaster.setString(3,session.getAttribute("BRANCHID").toString());
	stmtApprovalMaster.setString(4,formcode);
	stmtApprovalMaster.setString(6,mode);
	stmtApprovalMaster.executeQuery();
	docno=stmtApprovalMaster.getInt("docNo");
	
	
	if(docno<0)
	{
		conn.close();
		return 0;
	}
	
	if (docno > 0) {
		for (int i = 0; i < tempuserrole.size(); i++) {
			

			CallableStatement stmtApprovalMaster1 = conn.prepareCall("{call apprexdocDML(?,?,?,?,?,?,?,?)}");
			
		//	System.out.println("----------"+tempuserrole.get(i));
			
			stmtApprovalMaster1.setString(1,doctype);
			stmtApprovalMaster1.setString(2,session.getAttribute("BRANCHID").toString());
			stmtApprovalMaster1.setString(3,tempuserrole.get(i).split("::")[0]);
			stmtApprovalMaster1.setString(4,tempuserrole.get(i).split("::")[1]);
			stmtApprovalMaster1.setString(5,tempuserrole.get(i).split("::")[2]);
			stmtApprovalMaster1.setString(6,tempuserrole.get(i).split("::")[3].trim()==""?"0":tempuserrole.get(i).split("::")[3]);
			stmtApprovalMaster1.setInt(7,docno);
			stmtApprovalMaster1.setString(8,mode);
			stmtApprovalMaster1.executeQuery();
			//System.out.println(tempuserrole.get(i));
		}
		if (docno > 0) {
			conn.commit();
			stmtApprovalMaster.close();

			conn.close();
		return docno;
		}
		
		}
	
}catch(Exception e){	
	e.printStackTrace();
conn.close();
}
return 0;
}

public boolean edit(int docno, String doctype,ArrayList<String> tempuserrole,String templevel,HttpSession session,String mode,String formcode) throws SQLException
{
	try
    {
		 conn=ClsConnection.getMyConnection();
		 conn.setAutoCommit(false);
			CallableStatement stmtApprovalMaster = conn.prepareCall("{call apprMasterDML(?,?,?,?,?,?)}");
		   
			stmtApprovalMaster.setString(1,doctype);
			stmtApprovalMaster.setString(2,session.getAttribute("USERID").toString());
			stmtApprovalMaster.setString(3,session.getAttribute("BRANCHID").toString());
			stmtApprovalMaster.setString(4,formcode);
			 stmtApprovalMaster.setInt(5,docno);
			stmtApprovalMaster.setString(6,"E");
		int bbb=stmtApprovalMaster.executeUpdate();
		 
		if(bbb<=0)
		{
			conn.close();
			return false;
		}
		Statement st=conn.createStatement();
		String sqls="delete from my_exdoc where apprid='"+docno+"'";
	
		st.executeUpdate(sqls);
		
		    
			for (int i = 0; i < tempuserrole.size(); i++) {
				
				CallableStatement stmtApprovalMaster1 = conn.prepareCall("{call apprexdocDML(?,?,?,?,?,?,?,?)}");
				stmtApprovalMaster1.setString(1, doctype);
				stmtApprovalMaster1.setString(2,session.getAttribute("BRANCHID").toString());
				stmtApprovalMaster1.setString(3,tempuserrole.get(i).split("::")[0]);
				stmtApprovalMaster1.setString(4,tempuserrole.get(i).split("::")[1]);
				stmtApprovalMaster1.setString(5,tempuserrole.get(i).split("::")[2]);
				stmtApprovalMaster1.setString(6,tempuserrole.get(i).split("::")[3]==""?"0":tempuserrole.get(i).split("::")[3]);
				stmtApprovalMaster1.setInt(7,docno);
				stmtApprovalMaster1.setString(8,"E");
			   
			   stmtApprovalMaster1.executeUpdate();
				//System.out.println(tempuserrole.get(i));
			}
			
			if(bbb>0)
			{
			System.out.println("Success");
			conn.commit();
			conn.close();
			return true;	
			}
	}catch(Exception e){
		e.printStackTrace();
	conn.close();
	}
	
	
	return false;
}
public boolean delete(String doctype,HttpSession session,String mode,int docno,String formcode) throws SQLException {
	//System.out.println("----docno------"+docno);
try{
	 conn=ClsConnection.getMyConnection();

	
		CallableStatement stmtApprovalMaster = conn.prepareCall("{call apprMasterDML(?,?,?,?,?,?)}");
		stmtApprovalMaster.setString(1,doctype);
		stmtApprovalMaster.setString(2,session.getAttribute("USERID").toString());
		stmtApprovalMaster.setString(3,session.getAttribute("BRANCHID").toString());
		stmtApprovalMaster.setString(4,formcode);
		stmtApprovalMaster.setInt(5,docno);
		stmtApprovalMaster.setString(6,"D");
	
	
	
		int aaa=stmtApprovalMaster.executeUpdate();
	
	if (aaa>0) {
		
		stmtApprovalMaster.close();
		conn.close();
//		System.out.println("Success");
		return true;
	}
		
}catch(Exception e){
	e.printStackTrace();
	conn.close();
}


return false;
}


public  JSONArray doctypesearch(HttpSession session) throws SQLException {
	 JSONArray RESULTDATA = new JSONArray();
	 Connection conn = null;
	 String strsql=session.getAttribute("BRANCHID").toString();
		try {
			 
				 conn = ClsConnection.getMyConnection();
			Statement stmtUser =conn.createStatement();            	
			////String resql=("SELECT m1.menu_name,m1.doc_type,m1.exebag FROM my_menu m1 where exebag=1 and m1.doc_type not in (select a1.dtype from my_apprmaster a1 where status=3)");
			
			String resql="SELECT m1.menu_name,m1.doc_type,m1.exebag FROM my_menu m1 where m1.Gate='E' and  m1.doc_type!='' and m1.doc_type not in (select a1.dtype from my_apprmaster a1 where status=3 and a1.brhid='"+strsql+"')";
			
			System.out.println("resql------------"+resql);
	
			ResultSet resultSet = stmtUser.executeQuery(resql); 
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtUser.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
      return RESULTDATA;
  }


public  JSONArray searchDetails(HttpSession session) throws SQLException {
	 JSONArray RESULTDATA = new JSONArray();
	 Connection conn = null;
	 String strsql=session.getAttribute("BRANCHID").toString();
		try {
			 
				 conn = ClsConnection.getMyConnection();
			Statement stmtUser =conn.createStatement();            	
			String resql=("select a1.doc_no,a1.dtype,a1.status, m1.MENU_NAME,m1.doc_type from my_apprmaster as a1  "
					+ " left join my_menu as m1 on a1.dtype=m1.doc_type where  a1.status=3  and a1.brhid='"+strsql+"' Group by a1.doc_no ");
			System.out.println("resql"+resql);
	
			ResultSet resultSet = stmtUser.executeQuery(resql); 
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtUser.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
     return RESULTDATA;
 }
public  JSONArray usersearchDetails(String txtuserdoc) throws SQLException {
	 JSONArray RESULTDATA = new JSONArray();
	 Connection conn = null;
		try {
			 
				 conn = ClsConnection.getMyConnection();
			Statement stmtUser =conn.createStatement();            	
			String resql=("select doc_no,user_id,user_name,role_id from my_user where status=3 and doc_no not in("+txtuserdoc+")");
//			System.out.println("resql"+resql);
	
			ResultSet resultSet = stmtUser.executeQuery(resql); 
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtUser.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
    return RESULTDATA;
}

public  ClsApprovalMasterBean getDetails(int docno) throws SQLException {
ClsApprovalMasterBean bean=new ClsApprovalMasterBean();
Connection conn=null;
try {
  conn = ClsConnection.getMyConnection();
Statement stmtCPV0 = conn.createStatement ();





ArrayList<String> arr= new ArrayList<String>();
String strSql=("select u.doc_no,u.user_id,u.user_name,u.role_id,e.doc_no,e.exebedit,e.minapprls  from my_user u  "
		+ " inner join my_exdoc e on e.userid=u.doc_no where apprid='"+docno+"' and  apprlevel=3 order by e.doc_no;");
ResultSet rs=stmtCPV0.executeQuery(strSql);


int mm=0;
while(rs.next())
{
	if(mm==0)
	{
	bean.setTxtfinal_minapproval(rs.getString("minapprls"));
	bean.setChckfinalmodify(rs.getString("exebedit"));
	}
	arr.add(rs.getString("doc_no")+"::"+rs.getString("user_id")+"::"+rs.getString("user_name"));
	
	mm=1;
}

for(int i=0;i< arr.size();i++){
	
	if(i==0)
	{
	
		bean.setTxtfinal_userdoc1(arr.get(i).split("::")[0]);
		bean.setTxtfinal_user1(arr.get(i).split("::")[1]);
		bean.setTxtfinal_userfull1(arr.get(i).split("::")[2]);
		
	}
	if(i==1)
	{

		bean.setTxtfinal_userdoc2(arr.get(i).split("::")[0]);
		bean.setTxtfinal_user2(arr.get(i).split("::")[1]);
		bean.setTxtfinal_userfull2(arr.get(i).split("::")[2]);	
	}
	if(i==2)
	{

		bean.setTxtfinal_userdoc3(arr.get(i).split("::")[0]);
		bean.setTxtfinal_user3(arr.get(i).split("::")[1]);
		bean.setTxtfinal_userfull3(arr.get(i).split("::")[2]);
	}
	
	if(i==3)
	{

		bean.setTxtfinal_userdoc4(arr.get(i).split("::")[0]);
		bean.setTxtfinal_user4(arr.get(i).split("::")[1]);
		bean.setTxtfinal_userfull4(arr.get(i).split("::")[2]);
	}
	if(i==4)
	{

		bean.setTxtfinal_userdoc5(arr.get(i).split("::")[0]);
		bean.setTxtfinal_user5(arr.get(i).split("::")[1]);
		bean.setTxtfinal_userfull5(arr.get(i).split("::")[2]);
	}
	
/*   String aa= arr.get(i).split("::")[0];
   String bb= arr.get(i).split("::")[1];
   String cc= arr.get(i).split("::")[2];
   
   System.out.println("----aa------"+aa);
   System.out.println("----bb------"+bb);
   System.out.println("----cc------"+cc);*/
   
	
        }

ArrayList<String> arrsec= new ArrayList<String>();
String strSql1=("select u.doc_no,u.user_id,u.user_name,u.role_id,e.doc_no,e.exebedit,e.minapprls  from my_user u  "
		+ " inner join my_exdoc e on e.userid=u.doc_no where apprid='"+docno+"' and  apprlevel=2 order by e.doc_no;");
ResultSet rs1=stmtCPV0.executeQuery(strSql1);    

int ss=0;
while(rs1.next())
{
	if(ss==0)
	{
		bean.setTxtsecond_minapproval(rs1.getString("minapprls"));
	bean.setChcksecondmodify(rs1.getString("exebedit"));
	}
	arrsec.add(rs1.getString("doc_no")+"::"+rs1.getString("user_id")+"::"+rs1.getString("user_name"));
	ss=1;
	
}


for(int i=0;i< arrsec.size();i++){
	
	if(i==0)
	{
	
		bean.setTxtsecond_userdoc1(arrsec.get(i).split("::")[0]);
		bean.setTxtsecond_user1(arrsec.get(i).split("::")[1]);
		bean.setTxtsecond_userfull1(arrsec.get(i).split("::")[2]);
		
	}
	if(i==1)
	{

		bean.setTxtsecond_userdoc2(arrsec.get(i).split("::")[0]);
		bean.setTxtsecond_user2(arrsec.get(i).split("::")[1]);
		bean.setTxtsecond_userfull2(arrsec.get(i).split("::")[2]);	
	}
	if(i==2)
	{

		bean.setTxtsecond_userdoc3(arrsec.get(i).split("::")[0]);
		bean.setTxtsecond_user3(arrsec.get(i).split("::")[1]);
		bean.setTxtsecond_userfull3(arrsec.get(i).split("::")[2]);
	}
	
	if(i==3)
	{

		bean.setTxtsecond_userdoc4(arrsec.get(i).split("::")[0]);
		bean.setTxtsecond_user4(arrsec.get(i).split("::")[1]);
		bean.setTxtsecond_userfull4(arrsec.get(i).split("::")[2]);
	}
	if(i==4)
	{

		bean.setTxtsecond_userdoc5(arrsec.get(i).split("::")[0]);
		bean.setTxtsecond_user5(arrsec.get(i).split("::")[1]);
		bean.setTxtsecond_userfull5(arrsec.get(i).split("::")[2]);
	}
	
	
	
	
}

ArrayList<String> arrfirst= new ArrayList<String>();
String strSqls1=("select u.doc_no,u.user_id,u.user_name,u.role_id,e.doc_no,e.exebedit,e.minapprls  from my_user u  "
		+ " inner join my_exdoc e on e.userid=u.doc_no where apprid='"+docno+"' and  apprlevel=1 order by e.doc_no;");
ResultSet rs2=stmtCPV0.executeQuery(strSqls1);  
int hh=0;
while(rs2.next())
{
	if(hh==0)
	{
		bean.setTxtfirst_minapproval(rs2.getString("minapprls"));
	bean.setChckfirstmodify(rs2.getString("exebedit"));
	}
	arrfirst.add(rs2.getString("doc_no")+"::"+rs2.getString("user_id")+"::"+rs2.getString("user_name"));
	hh=1;
	
}


for(int i=0;i< arrfirst.size();i++){
	
	if(i==0)
	{
	
		bean.setTxtfirst_userdoc1(arrfirst.get(i).split("::")[0]);
		bean.setTxtfirst_user1(arrfirst.get(i).split("::")[1]);
		bean.setTxtfirst_userfull1(arrfirst.get(i).split("::")[2]);
		
	}
	if(i==1)
	{

		bean.setTxtfirst_userdoc2(arrfirst.get(i).split("::")[0]);
		bean.setTxtfirst_user2(arrfirst.get(i).split("::")[1]);
		bean.setTxtfirst_userfull2(arrfirst.get(i).split("::")[2]);	
	}
	if(i==2)
	{

		bean.setTxtfirst_userdoc3(arrfirst.get(i).split("::")[0]);
		bean.setTxtfirst_user3(arrfirst.get(i).split("::")[1]);
		bean.setTxtfirst_userfull3(arrfirst.get(i).split("::")[2]);
	}
	
	if(i==3)
	{

		bean.setTxtfirst_userdoc4(arrfirst.get(i).split("::")[0]);
		bean.setTxtfirst_user4(arrfirst.get(i).split("::")[1]);
		bean.setTxtfirst_userfull4(arrfirst.get(i).split("::")[2]);
	}
	if(i==4)
	{

		bean.setTxtfirst_userdoc5(arrfirst.get(i).split("::")[0]);
		bean.setTxtfirst_user5(arrfirst.get(i).split("::")[1]);
		bean.setTxtfirst_userfull5(arrfirst.get(i).split("::")[2]);
	}
}

stmtCPV0.close();
conn.close();
return bean;
}
catch(Exception e)
{
	e.printStackTrace();
	conn.close();
}

	return bean;
}



/*public  List<ClsApprovalMasterBean> list() throws SQLException {
List<ClsApprovalMasterBean> listBean = new ArrayList<ClsApprovalMasterBean>();

try {
		Connection conn = ClsConnection.getMyConnection();
		Statement stmtApprovalMaster = conn.createStatement ();
    	
		ResultSet resultSet = stmtApprovalMaster.executeQuery ("select a1.doc_no,a1.dtype,a1.status, m1.MENU_NAME,m1.doc_type from my_apprmaster as a1 left join my_menu as m1 on a1.dtype=m1.doc_type where  a1.status<>7 Group by a1.doc_no ");

		while (resultSet.next()) {
			
			ClsApprovalMasterBean bean = new ClsApprovalMasterBean();
        	bean.setDocno(resultSet.getInt("doc_no"));
			bean.setDoctype(resultSet.getString("dtype"));
			bean.setMenu_name(resultSet.getString("menu_name"));
			listBean.add(bean);
		}
}
catch(Exception e){
	e.printStackTrace();
}
return listBean;
}*/

/*public  List<ClsApprovalMasterBean> list1() throws SQLException {
List<ClsApprovalMasterBean> listBean1 = new ArrayList<ClsApprovalMasterBean>();

try {
		Connection conn = ClsConnection.getMyConnection();
		Statement stmtApprovalMaster = conn.createStatement ();
    	
		ResultSet resultSet = stmtApprovalMaster.executeQuery ("select doc_no,user_id,user_name,role_id from my_user");

		while (resultSet.next()) {
			
			ClsApprovalMasterBean bean = new ClsApprovalMasterBean();
        	bean.setDocno(resultSet.getInt("doc_no"));
			bean.setUserid(resultSet.getString("user_id"));
			bean.setUsername(resultSet.getString("user_name"));
			
			listBean1.add(bean);

		}
}
catch(Exception e){
	e.printStackTrace();
}

return listBean1;
}*/
/*public  List<ClsApprovalMasterBean> list2() throws SQLException {
List<ClsApprovalMasterBean> listBean2 = new ArrayList<ClsApprovalMasterBean>();

try {
		Connection conn = ClsConnection.getMyConnection();
		Statement stmtApprovalMaster = conn.createStatement ();
    	
		ResultSet resultSet = stmtApprovalMaster.executeQuery ("SELECT m1.menu_name,m1.doc_type,m1.exebag FROM my_menu m1 where exebag=1 and m1.doc_type not in (select a1.dtype from my_apprmaster a1 where status=3)");

		while (resultSet.next()) {
			
			ClsApprovalMasterBean bean = new ClsApprovalMasterBean();
        	bean.setDoc_type(resultSet.getString("doc_type"));
			bean.setMenu_name(resultSet.getString("menu_name"));
			
			
			listBean2.add(bean);

		}
}
catch(Exception e){
	e.printStackTrace();
}

return listBean2;
}
*/
}

