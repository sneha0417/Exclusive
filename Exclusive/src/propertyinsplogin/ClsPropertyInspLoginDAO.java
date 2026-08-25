package propertyinsplogin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.sql.*;
import java.util.ArrayList;
import java.util.Map;

import com.common.ClsCommon;
import com.common.ClsEncrypt;
import com.connection.ClsConnection;
import com.login.ClsLogin;

public class ClsPropertyInspLoginDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsLogin objlogin=new ClsLogin();
	public boolean userLogin(String username, String password,
			HttpSession session, HttpServletRequest request) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			System.out.println("Inside Property Inspection Login DAO");
			int userid=0;
			String loginusername="";
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			ClsEncrypt objencrypt=new ClsEncrypt();
			String str="select doc_no,user_id userid,user_name username from my_user where user_id='"+username+"' and pass='"+objencrypt.encrypt(password)+"' and status=3";
			ResultSet rs=stmt.executeQuery(str);
			while(rs.next()){
				userid=rs.getInt("doc_no");
				loginusername=rs.getString("username");
			}
			
			String ip = objlogin.getRemortIP(request);
			String mac = objlogin.getMACAddress(ip);
			
			Map<String, String> env = System.getenv();
		    String xuser=env.get("USERNAME");
		    String xcomp=env.get("COMPUTERNAME");
			
		    if(userid>0){
		    	session.setAttribute("BRANCHID","1");
		    	session.setAttribute("USERID",userid);
		    	session.setAttribute("COMPANYID","1");
		    	session.setAttribute("USERNAME",loginusername);
				String strlog = "insert into gc_propinsplog (userid,username,WIN_USER,win_cmp,WIN_MAC,DATE_IN) values ("+userid+",'"+loginusername+"','"+xuser+"','"+xcomp+"','"+mac+"',now())";
				int loginsert=stmt.executeUpdate(strlog);
				if(loginsert<=0){
					System.out.println("Log Insert Query:"+strlog);
					System.out.println("Log Insert Error");
					conn.close();
					return false;
				}
				else{
					conn.commit();
					return true;
				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return false;
	}
	
	public ClsPropertyInspLoginBean getPrint(int docno,
			HttpServletRequest request, HttpSession session, Connection conn) throws SQLException {
		// TODO Auto-generated method stub
		ClsPropertyInspLoginBean bean=new ClsPropertyInspLoginBean();
		try{
			Statement stmt=conn.createStatement();
			String strsql="select date_format(m.inspdate,'%d.%m.%Y %h:%m %a')inspdate,m.insptype,m.chkopt1,m.chkopt2,m.chkopt3,m.chkopt4,coalesce(m.repairdet,'')repdet,coalesce(m.tenantsign,'') as tenantsig,if(m.insptype='Hand Over',1,0) as coladd,coalesce(m.signature,'') as signature,if(m.insptype='Hand Back',1,0)cmnt,po.primary_owner as owner,prop.accname lblproperty,ac.refname lbltenant,usr.user_name lblinspector,m.doc_no lbldocno, date_format(m.inspdate,'%d.%m.%Y') lblinspdate, group_concat(comments) as summary from rl_propinspm m "
					+ "left join rl_propertymaster prop on m.propdocno=prop.doc_no left  join rl_tncm tnc on m.tncdocno=tnc.doc_no "
					+ "left  join rl_propertryowner po on prop.owid=po.doc_no  left join my_acbook ac on (tnc.cldocno=ac.cldocno and ac.dtype='CRM') left join my_user  usr on m.userid=usr.doc_no left join rl_propinspd d on m.doc_no=d.rdocno and comments!='' "
					+ "where m.status=3 and m.doc_no="+docno;
			
			System.out.println("mainqryinsp======="+strsql);
			
			ResultSet rsprint=stmt.executeQuery(strsql);
			while(rsprint.next()){
				bean.setLbldate(rsprint.getString("lblinspdate"));
				bean.setLbldocno(rsprint.getString("lbldocno"));
				bean.setLblinspector(rsprint.getString("lblinspector"));
				bean.setLblproperty(rsprint.getString("lblproperty"));
				bean.setLbltenant(rsprint.getString("lbltenant"));
				bean.setLblinsptype(rsprint.getString("cmnt"));
				bean.setLblowner(rsprint.getString("owner"));
				bean.setLblsign(rsprint.getString("signature"));
				bean.setLblsumm(rsprint.getString("summary"));
				bean.setLblcoladd(rsprint.getString("coladd"));
				bean.setLbltenantsig(rsprint.getString("tenantsig"));
				bean.setLblchkop1(rsprint.getString("chkopt1"));
				bean.setLblchkop2(rsprint.getString("chkopt2"));
				bean.setLblchkop3(rsprint.getString("chkopt3"));
				bean.setLblchkop4(rsprint.getString("chkopt4"));
				bean.setLblrepdet(rsprint.getString("repdet"));
				bean.setLblinspectype(rsprint.getString("insptype"));
				bean.setLblsigdate(rsprint.getString("inspdate"));
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
		}
		return bean;
	}
	public String getHandOverData(int furndocno,int roomdocno,int propdocno,Connection conn){
		String data="";
		try{
			Statement stmt=conn.createStatement();
			String strhandoverdata="select coalesce(d.comments,'') comments from rl_propinspm m left join rl_propinspd d on (m.doc_no=d.rdocno) where "+
			" m.propdocno="+propdocno+" and d.furndocno="+furndocno+" and d.roomdocno="+roomdocno+" and m.insptype='Hand Over'";
			ResultSet rshandoverdata=stmt.executeQuery(strhandoverdata);
			while(rshandoverdata.next()){
				data=rshandoverdata.getString("comments");
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return data;
	}
	public String getKeyHandOverData(int keydocno,int propdocno,Connection conn){
		String data="";
		try{
			Statement stmt=conn.createStatement();
			String strhandoverdata="select coalesce(d.comments,'') comments from rl_propinspm m left join rl_propkeys d on (m.doc_no=d.rdocno) where "+
			" m.propdocno="+propdocno+" and d.keydocno="+keydocno+" and m.insptype='Hand Over'";
			ResultSet rshandoverdata=stmt.executeQuery(strhandoverdata);
			while(rshandoverdata.next()){
				data=rshandoverdata.getString("comments");
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return data;
	}
	
	public   ArrayList<String[]> getInspectionPrintPicsNew(int docno, Connection conn) throws SQLException {
		// TODO Auto-generated method stub
		
		ArrayList<String[]> picarray=new ArrayList<String[]>();
		
		try {
			conn=objconn.getMyConnection();
			Statement stmtnew=conn.createStatement();
			String strnew="select coalesce(concat(mr.rdesc1,' - ',coalesce(r.fdesc1,'General',r.fdesc1)),'General') imgdesc,a.path from my_fileattach a left join rl_propinspattach p on p.attachdocno=a.rowno "
                          + "left join re_mfurnfix r on r.doc_no=p.furndocno left join re_mroom mr on mr.doc_no=p.roomdocno where a.dtype='BPI' and a.doc_no="+docno+"";
			System.out.println("printpics========"+strnew);
			ResultSet rsexist=stmtnew.executeQuery(strnew);
			
			while(rsexist.next()){
				//System.out.println("loop========1");
				int i=0;
				String[] temp=new String[1];
				if(!rsexist.getString("path").equalsIgnoreCase("")){
					
					temp[i]=rsexist.getString("path")+"##"+rsexist.getString("imgdesc");
					//System.out.println("temp========"+temp);
					picarray.add(temp);
				}else{
					
				}
			}
			//System.out.println("picarray========"+picarray);
			stmtnew.close();
			
			return picarray;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
			return null;
		}
		finally{
			conn.close();
		}
	}
}
