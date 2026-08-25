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

<style type="text/css">
.toDoHead{
    color: blue;
	/*background-color: #ECF8E0; */
	width: 100%;
	/* height: 28px; */
	font-family: Myriad Pro;
	font-weight: bold;
	font-size: 14px;
}

.styled-button-5 {
	background-color: #ed8223;
	color: #fff;
	font-family: 'Helvetica Neue',sans-serif;
	font-size: 14px/* 18px */;
	line-height: 24px/* 30px */;
	border-radius: 16px/* 20px */;
	-webkit-border-radius: 16px/* 20px */;
	-moz-border-radius: 16px/* 20px */;
	border: 0;
	text-shadow: #C17C3A 0 -1px 0;
	width: 120px;
	height: 28px/* 32px */
}         
</style>

<script type="text/javascript">
$(document).ready(function() {
	 $("#jqxDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
});

function funPrevious(){
 	 $("#toAddNewDiv").prop("hidden", true);
 	 $("#toDoListDiv").prop("hidden", false);
 	 $("#btnPrevious").hide();$("#btnRemove").hide();
 	 $("#btnNext").show();$("#btnHide").show();
}

function funAddToList(){
	if($("#docno").val()==""){
		$("#mode").val("A");
		$('#frmToDoList').submit();
	}
	
	if(!($("#docno").val()=="")){
		$("#mode").val("E");
		$('#frmToDoList').submit();
	}
	
	var indexVal = document.getElementById("docno").value;
	if(indexVal>0){
    	$("#toAddDoListDiv").load("addedListGrid.jsp");
	}
}
</script>
</head>
<body style="background-color:#FFF8B3;font-size:10px;"> 
<!-- <div id="mainBG" class="homeContent" data-type="background" > -->
<form id="frmToDoList" action="saveToDoList" method="post" autocomplete="off">
<div style="background-color:#FFF8B3;">
<table width="100%">
  <tr>
    <td width="7%" align="right" class="detail">Title</td>
    <td colspan="3"><input type="text" id="txttitle" name="txttitle"  style="width:90%;" value='<s:property value="txttitle"/>'/></td>
  </tr>
  <tr>
    <td align="right" class="detail">Date</td>
    <td width="24%"><div id="jqxDate" name="jqxDate" value='<s:property value="jqxDate"/>'></div>
    <input type="hidden" id="hidjqxDate" name="hidjqxDate" value='<s:property value="hidjqxDate"/>'/></td>
    <td width="43%" align="right" class="detail">Priority</td>
    <td width="26%"><select id="cmbpriority" name="cmbpriority" value='<s:property value="cmbpriority"/>'>
    <option value="None">None</option><option value="HIGH">High</option><option value="LOW">Low</option></select>
    <input type="hidden" id="hidcmbpriority" name="hidcmbpriority" value='<s:property value="hidcmbpriority"/>'/></td>
  </tr>
  <tr>
    <td align="right" class="detail">Description</td>
    <td colspan="3"><input type="text" id="txtdescription" name="txtdescription"  style="width:90%;" value='<s:property value="txtdescription"/>'/></td>
  </tr>
  <tr>
    <td colspan="4" align="center"><input type="button" class="styled-button-5" onclick="funAddToList();" value="Add To List" /></td>
  </tr>
</table><br/>
<div id="toAddDoListDiv"><jsp:include page="addedListGrid.jsp"></jsp:include></div>

<input type="hidden" id="docno" name="txttododocno" value='<s:property value="txttododocno"/>'/>
<input type="hidden" id="mode" name="mode"/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>

</div>
<!-- </div> -->
</form>
</body>
</html>