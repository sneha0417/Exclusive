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
	getPropertyType();

	function getPropertyType() { 
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var prtypeIdItems  = items[0].split(",");
				var prtypeItems = items[1].split(",");
				
				var prtypeoptions='<option value=""> select</option>';
				for (var i = 0; i < prtypeItems.length; i++) {
					prtypeoptions += '<option value="' + prtypeIdItems[i].trim() + '">'
							+ prtypeItems[i] + '</option>';
				}
				$("select#cmbsearchptype").html(prtypeoptions);
				    
			} else {
			}  
		}
		x.open("GET","getPropertyType.jsp",true);   
		x.send();
	} 
	$(document).ready(function () { 
	    
		   /* Date */ 	
	   // $("#datess11").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy",value:null}); 
		   
	});   
		   
 	function loadSearchs1() {  
 		var unitno=document.getElementById("unitnoss").value;
 		var dno=document.getElementById("docnosss").value;
 		var owname=document.getElementById("ownerr").value.replace(' ', '%20');
 		var paddress=document.getElementById("paddress").value.replace(' ', '%20');
 	    var prtype=document.getElementById("cmbsearchptype").value;
 		 
		var aa="yes";
		 getdata(dno,owname,paddress,prtype,aa,unitno);
  
	}
	function getdata(dno,owname,paddress,prtype,aa,unitno){   
		 
		$("#refreshdivs11").load('Subsearch.jsp?dno='+dno+'&owname='+owname+'&prtype='+prtype+'&aa='+aa+'&paddress='+paddress+'&unitno='+unitno);

		}

	</script>
<body bgcolor="#E0ECF8" onload="getPropertyType();">
<div id=search>
<table width="100%" >
  <tr >
   <td>
   <table width="100%" >
	   <tr>
	    <td align="right" width="6%">Doc No</td> 
	    <td align="left" width="20%"><input type="text" name="docnosss" id="docnosss"  style="width:100%;" value='<s:property value="docnosss"/>'></td>
	    <td align="right" width="6%">Unit No</td> 
	    <td align="left" width="20%"><input type="text" name="unitnoss" id="unitnoss"  style="width:100%;" value='<s:property value="unitnoss"/>'></td>
	    <td align="right" width="4%">Owner</td>
	    <td align="left"  width="50%"><input type="text" name="ownerr" id="ownerr" style="width:100%;"  value='<s:property value="owner"/>'></td>
	     </tr>
	    </table>
	    </td>
	    </tr>
   
        <tr> 
        <td>
        <table>
        <tr>
        <td align="right"  width="6%">Property</td>
        <td align="left"  width="34%"><input type="text" name="paddress" style="width:100%;" id="paddress" value='<s:property value="paddress"/>'></td> 
      <td align="right" width="4%">Type</td>
     <td  width="20%"><select id="cmbsearchptype" name="cmbsearchptype" value='<s:property value="cmbsearchptype"/>' style="width: 100%;"></select>
		</td>
		 <td  width="20%"><input type="button" name="searchs" id="searchs1" class="myButton" value="Search"  onclick="loadSearchs1()">
    </tr>
   
    </table>
  </td>
</tr>
  <tr>
    <td>    
     <div id="refreshdivs11">      
   <jsp:include  page="Subsearch.jsp"></jsp:include>     
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>  