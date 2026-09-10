<% String contextPath=request.getContextPath();%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
 
<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 150px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }
</style>

<script type="text/javascript">

$(document).ready(function () { 
	$('#btnSearch').attr('disabled', true);
	
	/* Formatted jqxDateTimeInput height to match modern UI 24px */
	$("#ptmdate").jqxDateTimeInput({width : '120px', height : 24, formatString : "dd.MM.yyyy", theme: 'energyblue'});
	
	/* Force internal alignment AFTER render */
    setTimeout(function () {
        $("#ptmdate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#ptmdate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);
	
    document.getElementById("formdet").innerText="Property Type(PTM)";
    document.getElementById("formdetail").value="Property Type";
    document.getElementById("formdetailcode").value="PTM";
    window.parent.formCode.value="PTM";
    window.parent.formName.value="Property Type";
    		
});
	
function funFocus(){
}
	
function funReadOnly() {
	$('#frmptm input').attr('readonly', true);
	$('#ptmdate').jqxDateTimeInput({ disabled: true}); 
}
	
function funRemoveReadOnly() {
	$('#frmptm input').attr('readonly', false);
	$('#ptmdate').jqxDateTimeInput({ disabled: false}); 
	$('#docno').attr('readonly', true);
}
	
function setValues() {
	if($('#ptmdate').val()){
		$("#ptmdate").jqxDateTimeInput('val', $('#ptmdate').val());
	}
	if($('#msg').val()!=""){
		$.messager.alert('Message',$('#msg').val());
	}
}
	  
function funNotify(){
	if(document.getElementById("pcode").value==''){
		document.getElementById("errormsg").innerText="Code is Mandatory.";
		return false;
	}
	
	if(document.getElementById("ptmtype").value==''){
		document.getElementById("errormsg").innerText="Property type is Mandatory.";
		return false;
	}
	
	document.getElementById("errormsg").innerText="";
	return 1;
}
	
function funChkButton() {
	/* funReset(); */
}
	  
</script>
</head>

<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmptm" action="saveP1" method="post" autocomplete="off" >
	<jsp:include page="../../../../header.jsp" />
	
	<div class="modern-ui hidden-scrollbar">

        <div class="middle-panel">
            <span class="middle-panel-title">Property Type</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Date</label>
                <div style="width: 120px;">
                    <div id="ptmdate" name="ptmdate" value='<s:property value="ptmdate"/>'></div>
                </div>
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
                <input type="text" id="docno" name="docno" style="width:120px;" value='<s:property value="docno"/>' readonly tabindex="-1">
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Code</label>
                <input type="text" name="pcode" id="pcode" style="width:120px;" value='<s:property value="pcode"/>' >
                
                <label class="lbl-right" style="width:80px; margin-left: 15px;">Name</label>
                <input type="text" name="ptmtype" id="ptmtype" style="flex:1; max-width:350px;" value='<s:property value="ptmtype"/>' >
            </div>
        </div>

        <div class="middle-panel">
            <span class="middle-panel-title">Type List</span>
            <div id="grpgrid" class="grid-container">
                <jsp:include page="typeGrid.jsp"></jsp:include>
            </div> 
        </div>

        <!-- Hidden inputs container -->
        <div style="display:none;">
            <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>' /> 
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' />
            <input type="hidden" name="hidfgmdate" id="hidfgmdate" value='<s:property value="hidfgmdate"/>'/>
        </div>

    </div>
</form>
</div>
</body>
</html>