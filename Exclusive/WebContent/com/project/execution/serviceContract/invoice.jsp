<%@ taglib prefix="s" uri="/struts-tags" %>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<style>
form label.error {
color:red;
  font-weight:bold;

}
.hidden-scrollbar {
    overflow: auto;
    
    height: 550px;
}
</style>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript">

$(document).ready(function() {
	  $("#date").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
	  	  
});


function funFocus()
{
	//document.getElementById("txtenquiry").focus();
		
}

function funReadOnly(){
	
	
	
}

function funRemoveReadOnly(){
	
	
	
}




function funNotify(){
	
	
	
		return 1;
} 



	function setValues(){
		
		
		
	}
	
	function funSearchLoad(){
		 changeContent('Mastersearch.jsp'); 
	} 
	
</script>
</head>

<body onLoad="setValues();">
<br/> 
	<div id="mainBG" class="homeContent" data-type="background"> 
	
	  <form id="frmservicecontract" action="saveServicecontract" method="post" autocomplete="off">
		<jsp:include page="../../../../header.jsp" />
        <br>
		<div class='hidden-scrollbar'>

<body>
<fieldset>
<table width="100%">
  <tr>
    <td align="right">Date</td>
    <td><div id="date" name="date" value='<s:property value="date"/>'></div></td>
    <td align="right">Ref No</td>
    <td><input type="text" name="refno" id="refno" value='<s:property value="refno"/>'></td>
    <td align="right">Doc No</td>
    <td><input type="text" name="docno" id="docno" value='<s:property value="docno"/>'></td>
  </tr>
  <tr>
    <td align="right">Contract Type</td>
    <td><select name="cmbcontracttype" id="cmbcontracttype">
    <option value="">--Select--</option>
    <option value="AMC">AMC</option>
    <option value="SJOB">SJOB</option>
    </select>
    </td>
    <td align="right">Contract No</td>
    <td><input type="text" name="contractno" id="contractno" value='<s:property value="contractno"/>'></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Client</td>
    <td colspan="3"><input type="text" name="client" id="client" value='<s:property value="client"/>'>
    <input type="text" name="clientdetails" id="clientdetails" value='<s:property value="clientdetails"/>'>
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Site</td>
    <td><input type="text" name="site" id="site" value='<s:property value="site"/>'></td>
    <td align="right">Status</td>
    <td><select name="cmbcontracttype2" id="cmbcontracttype2">
      <option value="">--Select--</option>
      <option value="Completed">Completed</option>
      <option value="Closed">Closed</option>
      <option value="Pending">Pending</option>
    </select></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="3"><input type="text" name="desc" id="desc" value='<s:property value="desc"/>'></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
 </tr> 
</fieldset>
<tr>
    <td>
    <fieldset><legend></legend>
    <div id="serdiv"><jsp:include page="serviceGrid.jsp"></jsp:include></div>
     </fieldset></td>
    
 <tr>
 <td>
    <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
    <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
    <input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
    </td>
   </tr>

</div>

</form>
</div>     
</body>
</html>
