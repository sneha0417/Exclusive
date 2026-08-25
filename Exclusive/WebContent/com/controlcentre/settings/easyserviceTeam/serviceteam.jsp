<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
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
</style>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript">
	
	$(document).ready(function() {
  	  $("#date").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" }); 
	});
	function funReadOnly() {
		 $('#frmServiceteam input').attr('readonly', true);
		 $('#frmServiceteam input').attr('disabled', true);
		 $('#date').jqxDateTimeInput({ disabled: true});
		 $('#docno').attr('disabled', false);
		 $("#serviceteamGrid").jqxGrid('disabled',true);
	}  
	function funRemoveReadOnly() {
		$('#frmServiceteam input').attr('readonly', false);
		$('#frmServiceteam input').attr('disabled', false);
		$('#docno').attr('readonly', true);
		 $('#date').jqxDateTimeInput({ disabled: false}); 
		 $("#serviceteamGrid").jqxGrid('disabled',false);  
		 if ($("#mode").val() == "A") {
			 $('#date').val(new Date());
		     $("#serviceteamGrid").jqxGrid('clear');
		    $("#serviceteamGrid").jqxGrid('addrow', null, {});
		   }
		 if($('#mode').val()=='E'){
         	$("#serviceteamGrid").jqxGrid('addrow', null, {});
         }   
		 
	}
	
	function setValues() {
	}

	 function funFocus()
	    {
	    	document.getElementById("date").focus();
	    		
	    }
	        
	     function funNotify(){
	     }
	        
	  function funSearchLoad(){
		}

</script>
 </head>
<body onLoad="setValues();">
	
	<br/> 
	<div id="mainBG" class="homeContent" data-type="background"> 
	  <form id="frmServiceteam" action="saveServiceteam" method="post" autocomplete="off">
		<jsp:include page="../../../../header.jsp" />
<table width="100%">
  <tr>
    <td width="9%" align="right">Date</td>
    <td width="14%"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
    <td width="15%" align="right">Doc No</td>
    <td width="14%"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>'></td>
   
  </tr>
 <td align="right">Code</td>
    <td><input type="text" name="txtcode" id="txtcode" value='<s:property value="txtcode"/>'></td>
  	<td width="21%">&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="3"><input type="text" id="txtdesc" name="txtdesc"  style="width:84%;" value='<s:property value="txtdesc"/>'></td>
    <td>&nbsp;</td>
     </tr>
  <tr>
    <td colspan="6" ><div id="searviceteamdiv"><jsp:include page="serviceteamGrid.jsp"></jsp:include></div></td>
    <td width="2%">
    <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
      <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
      <input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
      <input type="hidden" id="ismultiemp" name="ismultiemp"  value='<s:property value="ismultiemp"/>'/>
      <input type="hidden" id="serteamgridlen" name="serteamgridlen"  value='<s:property value="serteamgridlen"/>'/>
    </td>   
  </tr>
</table>
<div id="employeeDetailsWindow">
   <div></div>
</div>
</form>
</div>
</body>
</html>