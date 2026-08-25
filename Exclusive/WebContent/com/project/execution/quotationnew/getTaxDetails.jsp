<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon"%>
<%	
	Connection conn = null;

	try{
		ClsConnection connDAO = new ClsConnection();
		ClsCommon commonDAO=new ClsCommon();
		
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		java.sql.Date sqlDate=null;

		String netamount=request.getParameter("netamount")==""?"0":request.getParameter("netamount");
		String date=request.getParameter("date");
		String inter=request.getParameter("inter")==""?"0":request.getParameter("inter");
		String cldocno=request.getParameter("cldocno")==""?"0":request.getParameter("cldocno");
		
		if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
        {
     	   sqlDate = commonDAO.changeStringtoSqlDate(date);
        }
		
		int taxconfig=0,cltax=0;
		String taxper="0",taxamount="0";
		double taxper1=0.00,taxamount1=0.00;
		
		String consql="select method from gl_config where field_nme='tax'";
		ResultSet rsconfg = stmt.executeQuery(consql);

		while (rsconfg.next()) {
			taxconfig=rsconfg.getInt("method");
		}
		
		String clsql="select nontax from my_acbook where dtype='CRM' and cldocno='"+cldocno+"'";
		ResultSet rscltax = stmt.executeQuery(clsql);

		while (rscltax.next()) {
			cltax=rscltax.getInt("nontax");
		}
		
		if(taxconfig>0 && cltax==1){
			
			String upsql="";
			
			if(inter.equalsIgnoreCase("1")) //inter-state_IGST
			{
				upsql=" select t.tax_code,t.acno,t.value,cstper per,("+netamount+"*t.cstper)/100 as taxamt,t.doc_no docno "
						+" from  gl_taxsubmaster t where   fromdate<='"+sqlDate+"' and todate>='"+sqlDate+"' and status=3 and type=2 and cstper>0" ;
			}
			else{
				upsql=" select t.tax_code,t.acno,t.value,per,("+netamount+"*t.per)/100 as taxamt,t.doc_no docno "
					+" from  gl_taxsubmaster t where   fromdate<='"+sqlDate+"' and todate>='"+sqlDate+"' and status=3 and type=2 and per>0" ;
			}

			ResultSet resultSet = stmt.executeQuery(upsql);

			while (resultSet.next()) {

				taxper1+=resultSet.getDouble("per");
				taxamount1+=resultSet.getDouble("taxamt");
				
			}

		}
		
		taxper=String.valueOf(taxper1);
		taxamount=String.valueOf(taxamount1);
		
		response.getWriter().write(taxper+"####"+taxamount);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  