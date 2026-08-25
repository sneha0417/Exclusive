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
  
  
  function  closewin()
  {
		 $('#importwindow').jqxWindow('close');  
		 document.getElementById("rrefno").value="";
		 
		 document.getElementById("reqmasterdocno").value="";
		 
		 
  }
  
  function  relodedatas()
  {
	  
	  if (document.getElementById('pro').checked) {
	  
		  
		  var chk="req";
		  
		  var from="pro";
		  
		  
		  $("#sevdesc").load("serviecgrid.jsp?reqdoc="+ document.getElementById("reqmasterdocno").value+"&chk="+chk+"&from="+from);
		  
		 
 
	  }
	  
	  else
		  {
		  
           var chk="req";
		  
		  var from="entry";
		  
		  $("#sevdesc").load("serviecgrid.jsp?reqdoc="+ document.getElementById("reqmasterdocno").value+"&chk="+chk+"&from="+from);
		  
		  }
	  
	  
	  
		 $('#importwindow').jqxWindow('close');  
		 
  }
  
  </script>
  
  

<body bgcolor="#E0ECF8">
<div id=search>

<fieldset>
<br>

<table width="100%">
<tr>
<td width="20%" align="center">&nbsp;</td>
<td width="30%" align="center"><input type="radio" name="chk"   id="pro" value="product" ><label  ><font size="2">Product Wise</font></label> 
</td><td width="30%" align="center"><input type="radio"  checked="checked" name="chk" id="entry" value="entry" ><label  ><font size="2">Entry Wise</font></label> </td>

<td width="20%" align="center">&nbsp;</td>
</tr>
</table>

</fieldset>
<br>
<br>


<table width="100%">
<tr>
<td width="20%" align="center">&nbsp;</td>
<td width="30%" align="center"><input type="button" name="searchss" id="searchss" class="myButton"  value="Ok"  onclick="relodedatas()">
</td><td width="30%" align="center"><input type="button" name="searchss" id="searchss" class="myButton"  value="Close"  onclick="closewin()"></td>

<td width="20%" align="center">&nbsp;</td>

</tr>
</table>
<br>
<br>
 <br>
  </div>
</body>
</html>