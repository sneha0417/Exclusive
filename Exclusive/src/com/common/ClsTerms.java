package com.common;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.mysql.jdbc.PreparedStatement;

import org.apache.struts2.ServletActionContext;

public class ClsTerms {

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon com=new ClsCommon();

	private int termsgridlen;
	private String formdetailcode;
	private int rdocno;


	public int getTermsgridlen() {
		return termsgridlen;
	}


	public void setTermsgridlen(int termsgridlen) {
		this.termsgridlen = termsgridlen;
	}


	public String getFormdetailcode() {
		return formdetailcode;
	}


	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public int getRdocno() {
		return rdocno;
	}


	public void setRdocno(int rdocno) {
		this.rdocno = rdocno;
	}


	public   JSONArray termsSearch(HttpSession session,String dtype) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 


			String sql="select doc_no,voc_no,dtype,termsheader as header from my_termsm where status=3 and dtype='"+dtype+"'  order by priority ";
			System.out.println("-----fleetsql---"+sql);

			ResultSet resultSet = stmt.executeQuery (sql);
			RESULTDATA=convertToJSON(resultSet);
			stmt.close();
			conn.close();

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


	public   JSONArray condtnSearch(HttpSession session,String dtype,String tdocno,String cond) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 



			if(!(cond.trim().equalsIgnoreCase("undefined")||cond.trim().equalsIgnoreCase("NaN")||cond.trim().equalsIgnoreCase("")|| cond.isEmpty()))
			{

				if (cond.trim().endsWith(",")) {
					cond = cond.trim().substring(0,cond.length() - 1);
				}

			}
			else{
				cond="0";
			}


			String sql="select doc_no, rdocno, replace(termsfooter,',','') as termsfooter from my_termsd "
					+ "where  dtype='"+dtype+"' and rdocno="+tdocno+" and doc_no not in("+cond+") and status=3 order by priority";

			System.out.println("-----condtnSearch---"+sql);

			ResultSet resultSet = stmt.executeQuery (sql);
			RESULTDATA=convertToJSON(resultSet);
			stmt.close();
			conn.close();

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




	public JSONArray termsGridLoad(HttpSession session,String dtype) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select m.doc_no,m.voc_no,m.dtype,termsheader terms, replace(termsfooter,',','') conditions from MY_termsm m  "
					+ "left join my_termsd d on(m.voc_no=d.rdocno) where m.status=3 and d.status=3 and m.mand=1 "
					+ " and d.mand=1 and m.dtype='"+dtype+"' order by m.priority,d.priority";
			//System.out.println("===termsGridLoad====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray termsGridReLoad(HttpSession session,String dtype,String qotdoc,String brhid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select m.voc_no,m.dtype,termsheader terms, replace(conditions,',','') conditions,tr.priorno from my_trterms tr left join my_termsm m "
					+ "on(tr.termsid=m.voc_no) where  tr.dtype='"+dtype+"' and tr.rdocno="+qotdoc+" and tr.brhid='"+brhid+"' order by tr.priorno";
			System.out.println("===termsGridReLoad====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}


	public String saveTerms(){

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String returns="";
		int val=0;
		int delval=0;

		try{

			ArrayList termslist=new ArrayList();

	
			
			String list=request.getParameter("list")==null?"0":request.getParameter("list");

			String docno=request.getParameter("docno").toString();

			String dtype=request.getParameter("dtype").toString();

			String brhid=request.getParameter("brhid").toString();

			System.out.println("==docno==="+docno+"==dtype=="+dtype+"==brhid=="+brhid);

			String test[]=list.split(",");


			for(int i=0;i<test.length;i++){
				//System.out.println("-----aa-----"+aa[i]);
				String test1[]=test[i].split("::");

				String temp="";
				for(int j=0;j<test1.length;j++){ 

					if(!(test1[j].trim().equalsIgnoreCase("undefined")|| test1[j].trim().equalsIgnoreCase("NaN")||test1[j].trim().equalsIgnoreCase("")|| test1[j].isEmpty()))
					{

						temp=temp+test1[j]+"::";

					}

				}
				termslist.add(temp);


			} 

			delval=delete(dtype, docno, session, request, brhid);

			val=insert(termslist,dtype,docno,session,request,brhid);


			if(val>0){
				returns="success";
			}
			if(val<0){
				returns="fail";
			}



		}
		catch(Exception e){
			e.printStackTrace();
		}

		return returns;


	}
	
	/*public String saveTerms(){

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String returns="";
		int val=0;
		int delval=0;

		try{

			ArrayList termslist=new ArrayList();

			if(val>0){
				returns="success";
			}
			
			String list=request.getParameter("list")==null?"0":request.getParameter("list");

			String docno=request.getParameter("docno").toString();

			String dtype=request.getParameter("dtype").toString();

			String brhid=request.getParameter("brhid").toString();


			ArrayList taxlist=new ArrayList();

			for(int i=0;i<getInvgridlength();i++){
				String temp2=requestParams.get("terms"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();
				termslist.add(temp2);

			}
			
			

			delval=delete(dtype, docno, session, request, brhid);

			val=insert(termslist,dtype,docno,session,request,brhid);


			if(val>0){
				returns="success";
			}
			if(val<0){
				returns="fail";
			}



		}
		catch(Exception e){
			e.printStackTrace();
		}

		return returns;


	}*/

	public int insert(ArrayList termslist,String formcode,String docno,HttpSession session,HttpServletRequest request,String brhid) throws SQLException{


		Connection conn=null;
		int rdocno=0;
		int resultSet3=0;

		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);

			//rdocno=Integer.parseInt(docno);

			for(int i=0;i< termslist.size();i++){


				String[] terms=((String) termslist.get(i)).split("::");

				if(!((terms[0].equalsIgnoreCase("0"))||(terms[0].equalsIgnoreCase("undefined")))){


					String termsql="insert into my_trterms(rdocno, termsid, conditions,priorno, status,brhid, dtype)VALUES"
							+ " ('"+docno+"',"
							+ "'"+(terms[0].equalsIgnoreCase("undefined") || terms[0].equalsIgnoreCase("") || terms[0].trim().equalsIgnoreCase("NaN")|| terms[0].isEmpty()?0:terms[0].trim())+"',"
							+ "'"+(terms[2].equalsIgnoreCase("undefined") || terms[2].equalsIgnoreCase("") || terms[2].trim().equalsIgnoreCase("NaN")|| terms[2].isEmpty()?0:terms[2].trim())+"',"
							+ "'"+(terms[3].equalsIgnoreCase("undefined") || terms[3].equalsIgnoreCase("") || terms[3].trim().equalsIgnoreCase("NaN")|| terms[3].isEmpty()?0:terms[3].trim())+"',"
							+ "'3',"
							+ "'"+brhid+"',"
							+ "'"+formcode+"')";

					java.sql.PreparedStatement stmt =conn.prepareStatement(termsql);


					System.out.println("termsdet--->>>>Sql"+termsql);

					resultSet3 = stmt.executeUpdate ();


					if(resultSet3>0){
						conn.commit();
					}

					if(resultSet3<=0)
					{
						conn.close();
						return 0;
					}
				}
			}


		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return resultSet3;

	}


	public int delete(String formcode,String docno,HttpSession session,HttpServletRequest request,String brhid) throws SQLException{


		Connection conn=null;
		int rdocno=0;
		int resultSet=0;

		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);

			String termsql="delete from my_trterms where rdocno='"+docno+"' and brhid='"+brhid+"' and dtype='"+formcode+"'";


			java.sql.PreparedStatement stmt =conn.prepareStatement(termsql);

			resultSet = stmt.executeUpdate ();
			
			System.out.println("==resultSet==="+resultSet);
			
			System.out.println("==termsql==="+termsql);
			
			if(resultSet>0){
				conn.commit();
			}

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return resultSet;

	}


	public  JSONArray convertToJSON(ResultSet resultSet)
			throws Exception {
		JSONArray jsonArray = new JSONArray();
		while (resultSet.next()) {
			int total_rows = resultSet.getMetaData().getColumnCount();
			JSONObject obj = new JSONObject();
			for (int i = 0; i < total_rows; i++) {
				obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), (resultSet.getObject(i + 1)==null) ? "NA" : ((resultSet.getObject(i + 1).equals("0.0000")) ? " " : (resultSet.getObject(i + 1).toString()).replaceAll("[^a-zA-Z0-9_-_._; ]", " ")));
				//obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), ((resultSet.getObject(i + 1)==null) ? "" : resultSet.getObject(i + 1).toString().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ")));
				//	obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), ((resultSet.getObject(i + 1)==null) ? "" : resultSet.getObject(i + 1).toString().replaceAll("[^\\w\\s\\-_]", "")));

			}
			jsonArray.add(obj);
		}
		//System.out.println("ConvertTOJson:   "+jsonArray);
		return jsonArray;
	}



}
