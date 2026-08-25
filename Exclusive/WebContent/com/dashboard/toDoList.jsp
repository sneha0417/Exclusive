<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<link rel="stylesheet" href="toDoStyle.css" />
<title>GatewayERP(i)</title>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>

<style>
.icon {
	width: 2em;
	height: 1.2em;
	border: none;
	background-color: #FFF8B3;
}
</style>
<script type="text/javascript">
function funNext(){
   	 $("#toDoListDiv").prop("hidden", true); 
   	 $("#toAddNewDiv").prop("hidden", false);
   	 $("#btnNext").hide();$("#btnHide").hide();
   	 $("#btnPrevious").show();$("#btnRemove").show();
   	 $("#docno").val('');$("#txttitle").val('');$('#jqxDate').val(new Date());
   	 $("#cmbpriority").val('');$("#hidcmbpriority").val('');$("#txtdescription").val('');
}

function funDelete(){
	if(!($("#docno").val()=="")){
		$("#mode").val("D");
		$('#frmToDoList').submit();
	}
	
	var indexVal = document.getElementById("docno").value;
	if(indexVal>0){
    	$("#toAddDoListDiv").load("addedListGrid.jsp");
	}
	
  	 $("#docno").val('');$("#txttitle").val('');$('#jqxDate').val(new Date());
  	 $("#cmbpriority").val('');$("#hidcmbpriority").val('');$("#txtdescription").val('');
}

function funClear(){
	$("#docno").val('');$("#txttitle").val('');$('#jqxDate').val(new Date());
 	$("#cmbpriority").val('');$("#hidcmbpriority").val('');$("#txtdescription").val('');
}
</script>
</head>
<body bgcolor="white" style="font-size:10px;">
<div id="mainBG" class="homeContent" data-type="background">

<div style="background-color:#FFF8B3;">

<table width="100%">
  <tr>
    <td align="left"><button type="button" class="icon" id="btnPrevious" title="Back" onclick="funPrevious();">
							<img alt="Back" src="<%=contextPath%>/icons/left_new.png">
						</button></td>
    <td class="toDoHead" align="center"><label onclick="funClear();">To Do List</label></td>
    <td align="right"><button type="button" class="icon" id="btnHide" title="Hide">
							<img alt="Hide" src="<%=contextPath%>/icons/icon-up.png">
						</button></td>
	<td align="right"><button type="button" class="icon" id="btnRemove" title="Delete" onclick="funDelete();">
							<img alt="Delete" src="<%=contextPath%>/icons/delete_new.png">
						</button></td>
    <td align="right"><button type="button" class="icon" id="btnNext" title="Next" onclick="funNext();">
							<img alt="Next" src="<%=contextPath%>/icons/right_new.png">
						</button></td>
  </tr>
</table>
<div id="toDoListDiv"><jsp:include page="toDoListGrid.jsp"></jsp:include></div>
<div id="toAddNewDiv" hidden="true"><jsp:include page="toAddDoList.jsp"></jsp:include></div>
</div>
</div>
</body>
</html>