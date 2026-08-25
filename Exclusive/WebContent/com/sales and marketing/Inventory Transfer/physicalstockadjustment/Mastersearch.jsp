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
	  $("#qotdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	}); 

 	function qotloadSearch1() {
 		
 		var qotdate=document.getElementById("qotdate").value;
 		 var desc=document.getElementById("desc").value;
 
 		var msdocno=document.getElementById("msdocno").value; 
 		var descs = desc.replace(/ /g, "%20");
 
  
 		
	getdata1(descs,msdocno,qotdate);
 

	}
	function getdata1(descs,msdocno,qotdate){
		

		
		 $("#refreshdivmas").load('subMastersearch.jsp?descs='+descs+'&msdocno='+msdocno+'&qotdate='+qotdate);
		
		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%"  >
  <tr>
   <td>                         
   <table  width="100%" >
   <tr>
   <td align="right" width="10%">Doc No</td>
    <td align="left" width="10%"><input type="text" name="msdocno" id="msdocno"  value='<s:property value="msdocno"/>'></td>
    <td align="right" >Description</td>
    <td align="left" width="70%" ><input type="text" name="desc" id="desc"  style="width:96.5%;" value='<s:property value="desc"/>'></td>
      
      </tr>
        <tr>
        <td align="right">Date </td>
    <td align="left" ><div id="qotdate" name="qotdate"  value='<s:property value="qotdate"/>'></div>
    </td><td align="center" colspan="2">
   <input type="button" name="qotbtnrasearch" id="qotbtnrasearch" class="myButton" value="Search"  onclick="qotloadSearch1()"></td>
    <tr>
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