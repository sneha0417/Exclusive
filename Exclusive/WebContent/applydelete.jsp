<%@page import="org.omg.CORBA.portable.ValueInputStream"%>
<%@page import="java.util.ArrayList"%>
<%@page import ="com.connection.ClsConnection"%>
<%@page import ="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="java.util.Iterator" %>
<%@page import="java.util.ArrayList" %>
<%

	
	
 	Connection conn=null,connms=null;


	try{
		ClsConnection objconn= new ClsConnection();
		conn=objconn.getMyConnection();
		conn.setAutoCommit(false);


		ArrayList<String> altranid= new ArrayList<String>();
		ArrayList<String> alaptrid= new ArrayList<String>();
		int aptrid=0,tranid=0,acno=10569;
		double tranamt=0.0,aptranamt=0.0,apoutamt=0.0,upamt=0.0;
		String updateString="",insString="";
		Statement stmtaptran=null,stmtupd=null,stmtins=null;
		ResultSet rsaptran =null;
		String sqlselect="select tranid,(dramount-out_amount)*id amt from my_jvtran where status=3 and acno="+acno+" and dramount-out_amount < 0;";
		System.out.println("values 1======"+sqlselect);
		Statement stmtrecpt= conn.createStatement();
		ResultSet rsselect = stmtrecpt.executeQuery(sqlselect);
		while(rsselect.next()){
			upamt=0.0;
				// altranid.add(rsselect.getString("tranid")+"::"+rsselect.getString("amt"));
				tranid=rsselect.getInt("tranid");
				tranamt=rsselect.getDouble("amt");
		
				String sqlaptran=" select tranid,dramount-out_amount amt  from my_jvtran where status=3 and acno="+acno+" and dramount-out_amount > 0 ; ";
				System.out.println("values 2====== "+sqlaptran);
				stmtaptran = conn.createStatement();
				rsaptran = stmtaptran.executeQuery(sqlaptran);
				while(rsaptran.next()){
					aptrid=rsaptran.getInt("tranid");
					aptranamt=rsaptran.getDouble("amt");
					if(aptranamt>tranamt){
						upamt=tranamt;	
					}
					else{
						upamt=aptranamt;
					}
					updateString="update my_jvtran set out_amount=(out_amount*id+"+upamt+")* id  where tranid  in ("+aptrid+","+tranid+")";
					System.out.println("values 3====== "+updateString);
					stmtupd=conn.createStatement();
					stmtupd.execute(updateString);
					upamt=upamt<0.0?upamt*-1:upamt;
					insString=" insert into my_outd(TRANID, AMOUNT, AP_TRID, AR) values ("+tranid+","+upamt+","+aptrid+" , "+acno+")" ;
					System.out.println("values 4====== "+insString);
					stmtins=conn.createStatement();
					stmtins.execute(insString);
					tranamt=tranamt-upamt;
					if(tranamt==0){
							System.out.println("==== break === ");
							break;
						}
				}
		}
	
		conn.commit();
	}
	catch(Exception e){
		e.printStackTrace();	
	}
	finally{
		conn.close();
	}
%>