 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<script type="text/javascript">
	
	$(document).ready(function () {}); 

 	function loadSearch() {
 		
 		var vndname=document.getElementById("txtvendorsname").value;
 		var vndaccno=document.getElementById("txtaccnt").value;
 		//alert(vndaccno);
 		var vndmob=document.getElementById("txtmobile").value;
 		var vndtel=document.getElementById("txttelephone").value;
       
 		getdata(vndname,vndaccno,vndmob,vndtel);
	}
	function getdata(vndname,vndaccno,vndmob,vndtel){
		
		 $("#refreshdiv").load('vndMainSearchGrid.jsp?vndname='+vndname.replace(/ /g, "%20")+'&vndaccno='+vndaccno+'&vndmob='+vndmob+'&vndtel='+vndtel+'&id=1');
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="6%" align="right">Name</td>
    <td colspan="4"><input type="text" name="txtvendorsname" id="txtvendorsname" style="width:80%" value='<s:property value="txtvendorsname"/>'></td>
    <td width="24%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">A/C No.</td>
    <td width="21%"><input type="text" name="txtaccnt" id="txtaccnt" value='<s:property value="txtaccnt"/>'></td>
    <td width="7%" align="right">Mob No.</td>
    <td width="36%"><input type="text" name="txtmobile" id="txtmobile" value='<s:property value="txtmobile"/>'></td>
    <td width="6%" align="right">Tel No.</td>
    <td><input type="text" name="txttelephone" id="txttelephone" value='<s:property value="txttelephone"/>'></td>
  </tr>
  <tr>
    <td colspan="6"><div id="refreshdiv"><jsp:include  page="vndMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>