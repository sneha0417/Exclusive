<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<style type="text/css">
.icon {
	width: 2.5em;
	height: 2em;
	border: none;
	background-color: #E0ECF8;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		function myFunc(){
	        var input = $("#txtdescription").val();
	        $("#txtdescriptions").text(input);
	    }       
	    myFunc();

	    //either this
	    $('#txtdescription').keyup(function(){
	        $('#txtdescriptions').html($(this).val());
	    });

	    //or this
	    $('#txtdescription').keyup(function(){
	        myFunc();
	    });

	    //and this for good measure
	    $('#txtdescription').change(function(){
	        myFunc(); //or direct assignment $('#txtHere').html($(this).val());
	    });
		
	});
	
</script>
</head>
<body style="background-color:#E0ECF8;font-size:10px;"> 
<div style="background-color:#E0ECF8;">
<table width="100%">
  <tr>
    <td width="8%" align="right">Description</td>
    <td width="74%"><input type="text" id="txtdescription" name="txtdescription"  style="width:100%;" value='<s:property value="txtdescription"/>'/></td>
    <td width="6%" align="right"><button type="button" class="icon" id="btnSaveChanges" title="Save" onclick="funSaveDetails(event);">
							<img alt="Delete" src="<%=contextPath%>/icons/save_new.png">
						</button></td>
    <td width="12%" align="right"><button type="button" class="icon" id="btnRemove" title="Delete" onclick="funDeleteDocu(event);">
							<img alt="Delete" src="<%=contextPath%>/icons/delete_new.png">
						</button></td>
  </tr>
  <tr>
    <td colspan="4"><textarea id="txtdescriptions" name="txtdescriptions" rows="5" style="width:100%;resize: none;font-size:16px;" readonly="readonly"><s:property value="txtdescriptions"/></textarea></td>
  </tr>
</table>
</div>
</body>
</html>