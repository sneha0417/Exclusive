 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<% String fromdate=request.getParameter("fromdate");
 	String todate=request.getParameter("todate"); %>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>   
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>
 
	<script type="text/javascript">
	 var fromdate='<%=fromdate%>';
	 var todate='<%=todate%>';
	$(document).ready(function () {
	//  $("#surdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	}); 

 	function qotloadSearch1() {
 		
 	//	var surdate=document.getElementById("surdate").value;
 		var surdate=0;
 		 var Cl_namess=document.getElementById("Cl_names").value;
 		var sereftype=document.getElementById("sereftype").value;
 		var msdocno=document.getElementById("msdocno").value; 
 		var Cl_names = Cl_namess.replace(' ','%20');
 		var cntrtype=document.getElementById("cntrtype").value;
 		
 		
	getdata1(Cl_names,msdocno,surdate,cntrtype,sereftype);
 

	}
	function getdata1(Cl_names,msdocno,surdate,cntrtype,sereftype){
		
		var id=1;
		
		 $("#refreshdivmas").load('subMastersearch.jsp?Cl_names='+Cl_names+'&msdocno='+msdocno+'&sereftype='+sereftype+'&surdate='+surdate+'&cntrtype='+cntrtype+'&id='+id+'&fromdate='+fromdate+'&todate='+todate);
		
		}
	
	

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%"  >
  <tr>
   <td>                         
   <table >
   <tr>
   <td align="right"><label style="font:10px Tahoma;">Docno</label></td>
    <td align="left" width="2%"><input type="text" name="msdocno" id="msdocno" style="height:20px;"  value='<s:property value="msdocno"/>'></td>
    <td align="right" ><label style="font:10px Tahoma;">Client</label></td>
    <td align="left" width="45%" ><input type="text" name="Cl_names" id="Cl_names"  style="width:96.5%;height:20px;" value='<s:property value="Cl_names"/>'></td>
    <td align="right" ><label style="font:10px Tahoma;">Ref.Type</label></td>
      <td align="left" width="28%"><select id="sereftype" name="sereftype"  style="width:100%;"  value='<s:property value="sereftype"/>'>
      <option value=""></option>
      <option value="DIR">DIR</option>
      <option value="ENQ">ENQ</option>
      </select></td>
      </tr>
        <tr>
        <td width="15%"><label style="font:10px Tahoma;">Contract Type</label></td>
    <td align="left" width="5%"><select id="cntrtype" name="cntrtype"  style="width:100%;"  value='<s:property value="cntrtype"/>'>
    <option value=""></option>
      <option value="AMC">AMC</option>
      <option value="SJOB">SJOB</option>
      </select></td>
   <%--  <td width="10%" align="right">
    <label style="font:10px Tahoma;">Date</label></td><td width="4%"><div id="surdate" name="surdate"  value='<s:property value="surdate"/>'></div></td> --%>
   <td>&nbsp;</td>
   
   <td><input type="button" name="qotbtnrasearch" id="qotbtnrasearch" class="myButton" value="Search"  onclick="qotloadSearch1()"></td>
    </tr>
    
         
    </table>
    </td>
</tr>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdivmas">
      
   <jsp:include  page="subMastersearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>