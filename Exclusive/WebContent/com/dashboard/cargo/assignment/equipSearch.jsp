  <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript">
	
	
	function loadSearch() {
		
			var fleetno=document.getElementById("fleetno").value;
			var flname=document.getElementById("flname").value;
			var regno=document.getElementById("regno").value;
			var check = 1;
	
			getAccountDetails(fleetno,flname,regno,check);
	}
		
	function getAccountDetails(fleetno,flname,regno,check){

		 $("#refreshAccountDetailsDiv").load("equipGrid.jsp?fleetno="+fleetno+'&flname='+flname+'&regno='+regno+'&check='+check);
	}

</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="10%" align="right"><label style="font-size:9px;">FLEETNO</label></td>
    <td width="30%"><input type="text" name="fleetno" id="fleetno" style="height:20px;width:50%;"value='<s:property value="fleetno"/>'></td>
    <td width="10%" align="right"><label style="font-size:9px;">FLNAME</label></td>
    <td width="27%"><input type="text" name="flname" id="flname" style="height:20px;width:70%;" value='<s:property value="flname"/>'>
    </tr> 
<tr>
    <td width="10%" align="right"><label style="font-size:9px;">REG.NO</label></td>
    <td width="30%"><input type="text" name="regno" id="regno" style="height:20px;width:50%;"value='<s:property value="regno"/>'></td>
  
<%--     <input type="hidden" name="txtsearchtype" id="txtsearchtype" value='<s:property value="txtsearchtype"/>'></td> --%>
<!--     <td width="23%" rowspan="2" align="center"><input type="button" name="btnAccountSearch" id="btnAccountSearch" class="myButton" value="Search"  onclick="loadAccountSearch();"></td> -->
<!--    </tr> -->
<!--  <tr> -->
<!--     <td align="right" ><label style="font-size:9px;"> Account Name</label></td> -->
<%--     <td colspan="3"><input type="text" name="txtaccountsname" id="txtaccountsname" style="height:20px;width:100%;" value='<s:property value="txtaccountsname"/>'></td> --%>
<!--   </tr> -->
<td colspan="2" align="center"><input type="button" name="btnrasearch" id="btnrasearch" class="myButton" style=" height:20; " value="Search"  onclick="loadSearch();"></td>
    
  <tr>
    <td colspan="5"><div id="refreshAccountDetailsDiv"><jsp:include page="equipGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>