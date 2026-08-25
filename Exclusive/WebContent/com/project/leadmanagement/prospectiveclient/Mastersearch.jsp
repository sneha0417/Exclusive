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
	  $("#cpdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	}); 

 	function cpsearchload() {
 		
 		var cpdate=document.getElementById("cpdate").value;
 		 var Cl_namess=document.getElementById("Cl_names").value;
 		var salmanss=document.getElementById("salman").value;
 		
 		var msdocno=document.getElementById("msdocno").value; 
 		var Cl_names = Cl_namess.replace(' ', '%20');
 		var salman = salmanss.replace(' ', '%20');
	getdata1(Cl_names,msdocno,salman,cpdate);
 

	}
	function getdata1(Cl_names,msdocno,salman,cpdate){
		

		
		 $("#cpsearchdiv").load('subMastersearch.jsp?Cl_names='+Cl_names+'&msdocno='+msdocno+'&salman='+salman+'&cpdate='+cpdate+'&id='+1);
		
		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr>
   <td>                         
   <table width="100%">
   <tr>
   <td width="12%" align="right">Docno</td>
    <td align="left" width="29%"><input type="text" name="msdocno" id="msdocno"  value='<s:property value="msdocno"/>'></td>
    <td width="10%" align="right" >Name</td>
    <td align="left" width="28%" ><input type="text" name="Cl_names" id="Cl_names"  style="width:90%;" value='<s:property value="Cl_names"/>'></td>
    <td align="right" width="7%" >Date</td>
      <td align="left" width="9%"><div id="cpdate" name="cpdate"  value='<s:property value="cpdate"/>'></td>
      </tr>
        <tr>
        
    <td  align="right" >salesman</td><td colspan="2" ><input type="text" name="salman" id="salman" style="width:80%;" value='<s:property value="salman"/>'>
    </td>
   <td><div align="center">
     <input type="button" name="cpbtnsearch" id="cpbtnsearch" class="myButton" value="Search"  onclick="cpsearchload()">
   </div></td>
   <td>&nbsp;</td>
   
    </tr>
    </table>
    </td>
</tr>

  <tr>
    <td colspan="8" align="right">
    
    <div id="cpsearchdiv">
      
   <jsp:include  page="subMastersearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>