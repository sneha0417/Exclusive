<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>

<%	
ClsConnection ClsConnection=new ClsConnection();

	Connection conn = null;
	
	try{

		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String formdetail=request.getParameter("formdetail");
		String docno=request.getParameter("docno");
		
/*		String strSql = "select p.add1,(case when (case when doc.exebedit=1 then coalesce(doc.exebedit,0) else coalesce(ex.apprStatus,0) end)=0 then p.edit else (case when doc.exebedit=1 then coalesce(doc.exebedit,0) else P.EDIT end) end) as edit,(case when coalesce(ex.apprStatus,0)=0 then p.del else 0 end) as del,p.print,p.attach,p.excel,p.email,p.costing,p.terms,ex.apprStatus from  my_powr p left join my_user u on u.role_id=p.roleid  left join my_menu m on(m.menu_name=p.menu_name) left join my_exdet ex on(ex.dtype=m.doc_type and u.doc_no=ex.userid and ex.doc_no='"+docno+"') left join my_exdoc doc on(doc.dtype=m.doc_type and u.doc_no=doc.userid) where p.menu_name='"+formdetail+"' and u.doc_no='"+session.getAttribute("USERID").toString()+"'"; */

		/* String strSql = "select p.add1,if(apm.dtype is null,p.edit, if(ex.doc_no is null and eb.doc_no is null , p.edit ,  if(eb.userid is not null and doc.exebedit=1, p.edit ,if(ex1.doc_no is not null , p.edit , 0 )))) as edit,(case when coalesce(ex.apprStatus,0)=0 then p.del else 0 end) as del,p.print,p.attach,p.excel,p.email,p.costing,p.terms,coalesce(ex.apprStatus,0) apprStatus from my_powr p left join my_user u on u.role_id=p.roleid left join my_menu m on (m.menu_name=p.menu_name) left join my_apprmaster apm on(apm.dtype=m.doc_type) left join my_exdoc doc on (doc.dtype = m.doc_type and u.doc_no=doc.userid) left join my_exdet ex  on  (ex.dtype  = m.doc_type and ex.doc_no='"+docno+"') left join my_exeb eb  on  (eb.dtype  = m.doc_type   and u.doc_no=eb.userid and eb.doc_no='"+docno+"')  left join my_exdet ex1  on  (ex1.dtype  = m.doc_type and ex1.doc_no='"+docno+"'  and ex1.apprstatus=2 )where p.menu_name='"+formdetail+"' and u.doc_no='"+session.getAttribute("USERID").toString()+"'"; 
		 */
		 
			// String strSql = "select p.add1,(case when (case when doc.exebedit=1 then coalesce(doc.exebedit,0) else coalesce(ex.apprStatus,0) end)=0 then p.edit else (case when doc.exebedit=1 then coalesce(doc.exebedit,0) else 0 end) end) as edit,(case when coalesce(ex.apprStatus,0)=0 then p.del else 0 end) as del,p.print,p.attach,p.excel,p.email,p.costing,p.terms,ex.apprStatus from  my_powr p left join my_user u on u.role_id=p.roleid  left join my_menu m on(m.menu_name=p.menu_name) left join my_exdet ex on(ex.dtype=m.doc_type and u.doc_no=ex.userid and ex.doc_no='"+docno+"') left join my_exdoc doc on(doc.dtype=m.doc_type and u.doc_no=doc.userid) where replace(p.menu_name , ' ','')=replace('"+formdetail+"', ' ','') and u.doc_no='"+session.getAttribute("USERID").toString()+"'";
		 
	//	 String strSql = "select p.add1,if(apm.dtype is null,p.edit, if(ex.doc_no is null and eb.doc_no is null , p.edit ,  if(eb.userid is not null and doc.exebedit=1, p.edit ,if(ex1.doc_no is not null , p.edit , 0 )))) as edit,(case when coalesce(ex.apprStatus,0)=0 then p.del else 0 end) as del,p.print,p.attach,p.excel,p.email,p.costing,p.terms,coalesce(ex.apprStatus,0) apprStatus from my_powr p left join my_user u on u.role_id=p.roleid left join my_menu m on (m.menu_name=p.menu_name) left join my_apprmaster apm on(apm.dtype=m.doc_type) left join my_exdoc doc on (doc.dtype = m.doc_type and u.doc_no=doc.userid) left join my_exdet ex  on  (ex.dtype  = m.doc_type and ex.doc_no='"+docno+"') left join my_exeb eb  on  (eb.dtype  = m.doc_type   and u.doc_no=eb.userid and eb.doc_no='"+docno+"')  left join my_exdet ex1  on  (ex1.dtype  = m.doc_type and ex1.doc_no='"+docno+"'  and ex1.apprstatus=2 )where replace(p.menu_name , ' ','')=replace('"+formdetail+"', ' ','')  and u.doc_no='"+session.getAttribute("USERID").toString()+"'"; 
		 
		  String strSql = "select p.add1,if(apm.dtype is null,p.edit, if(ex.doc_no is null and eb.doc_no is null , p.edit ,  if(eb.userid is not null and doc.exebedit=1, p.edit ,if(ex1.doc_no is not null , p.edit , 0 )))) as edit,(case when coalesce(ex.apprStatus,0)=0 then p.del else 0 end) as del,p.print,p.attach,p.excel,p.email,p.costing,p.terms,coalesce(ex.apprStatus,0) apprStatus from my_powr p left join my_user u on u.role_id=p.roleid left join my_menu m on (m.menu_name=p.menu_name) left join my_apprmaster apm on(apm.dtype=m.doc_type) left join my_exdoc doc on (doc.dtype = m.doc_type and u.doc_no=doc.userid) left join my_exdet ex  on  (ex.dtype  = m.doc_type and ex.doc_no='"+docno+"' and ex.brhid="+session.getAttribute("BRANCHID").toString()+") left join my_exeb eb  on  (eb.dtype  = m.doc_type   and u.doc_no=eb.userid and eb.doc_no='"+docno+"'  and eb.brhid="+session.getAttribute("BRANCHID").toString()+")  left join my_exdet ex1  on  (ex1.dtype  = m.doc_type and ex1.doc_no='"+docno+"'  and ex1.apprstatus=2  and ex1.brhid="+session.getAttribute("BRANCHID").toString()+" )where replace(p.menu_name , ' ','')=replace('"+formdetail+"', ' ','')  and u.doc_no='"+session.getAttribute("USERID").toString()+"'"; 
		 ResultSet rs = stmt.executeQuery(strSql);
		 System.out.println("=chkmenubuttons======== "+strSql);
		int addval=0;
		int editval=0;
		int delval=0;
		int printval=0;
		int attachval=0;
		int excelval=0;
		int email=0;
		int costingval=0;
		int terms=0;
        int other=0;
		
		while(rs.next()) {
            other=1;
			addval=rs.getInt("add1");
			editval=rs.getInt("edit");
			delval=rs.getInt("del");
			printval=rs.getInt("print");
			attachval=rs.getInt("attach");
			excelval=rs.getInt("excel");
			email=rs.getInt("email");
			costingval=rs.getInt("costing");
			terms=rs.getInt("terms");			
		} 
		System.out.println(addval+"##"+editval+"##"+delval+"##"+printval+"##"+attachval+"##"+excelval+"##"+email+"##"+costingval+"##"+terms+"##"+other);
		response.getWriter().write(addval+"##"+editval+"##"+delval+"##"+printval+"##"+attachval+"##"+excelval+"##"+email+"##"+costingval+"##"+terms+"##"+other);
		stmt.close();
		conn.close();
	} catch(Exception e) {
	 	e.printStackTrace();
	 	conn.close();
	} finally {
		conn.close();
	}
  %>
  