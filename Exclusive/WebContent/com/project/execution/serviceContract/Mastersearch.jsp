 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>   
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>

	<script type="text/javascript">
	$(document).ready(function () {
	  $("#surdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	}); 

 	function qotloadSearch1() {
 		
 		var surdate=document.getElementById("surdate").value;
 		 var Cl_namess=document.getElementById("Cl_names").value;
 		 
 		var cl_area=document.getElementById("cl_area").value;
 		var cl_site=document.getElementById("cl_site").value;
 		
 		var sereftype=document.getElementById("sereftype").value;
 		var msdocno=document.getElementById("msdocno").value; 
 		var Cl_names = Cl_namess.replace(' ','%20');
 		var dtype=document.getElementById("formdetailcode").value; 
 		
	getdata1(Cl_names,msdocno,sereftype,surdate,dtype,cl_area,cl_site);
 

	}
	function getdata1(Cl_names,msdocno,sereftype,surdate,dtype,cl_area,cl_site){
		var id=1;
		 $("#refreshdivmas").load('subMastersearch.jsp?Cl_names='+Cl_names+'&msdocno='+msdocno+'&sereftype='+sereftype+'&surdate='+surdate+'&dtype='+dtype+'&id='+id+'&cl_area='+cl_area+'&cl_site='+cl_site);
		
		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr>
   <td>                         
   <table width="100%">
   <tr>
   <td width="4%" align="right">Docno</td>
    <td align="left" width="14%"><input type="text" name="msdocno" id="msdocno"  value='<s:property value="msdocno"/>'></td>
    <td width="4%" align="right" >Client</td>
    <td align="left" width="55%" ><input type="text" name="Cl_names" id="Cl_names"  style="width:96.5%;" value='<s:property value="Cl_names"/>'></td>
    <td width="7%" align="right" >Ref.Type</td>
      <td align="left" width="8%"><select id="sereftype" name="sereftype"  style="width:130%;" onchange="refChange();" value='<s:property value="sereftype"/>'>
      <option value=""></option>
      <option value="DIR">DIR</option>
      <option value="SQOT">SQOT</option>
      <option value="ENQ">ENQ</option>
      </select></td>
      </tr>
        <tr>
        <td>Date </td>
    <td align="left" ><div id="surdate" name="surdate"  value='<s:property value="surdate"/>'></div>
    <td colspan="4"><label>Site</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="cl_site" id="cl_site"  value='<s:property value="cl_site"/>'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label>Area</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="cl_area" id="cl_area"  value='<s:property value="cl_area"/>'>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="qotbtnrasearch" id="qotbtnrasearch" class="myButton" value="Search"  onclick="qotloadSearch1()"></td>
    <td width="8%" >&nbsp;</td>
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