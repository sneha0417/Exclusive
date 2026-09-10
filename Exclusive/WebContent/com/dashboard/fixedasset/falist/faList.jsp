<jsp:include page="../../../../includes.jsp"></jsp:include>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />

<style type="text/css">
/* ===== MASTER LAYOUT (Modern Flexbox) ===== */
html, body, #mainBG {
    height: 100%;
    margin: 0;
    overflow: hidden;
    background-color: #f4f7f9;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100vh;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* ===== LEFT SIDEBAR ===== */
.sidebar-filters {
    width: 280px; 
    flex: 0 0 280px; 
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100%;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
    z-index: 10;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 15px 25px; 
}

/* Cards */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Tables */
.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.filter-table .label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 85px;
}

/* ===== UNIFORM 24px INPUTS & SELECTS ===== */
input[type="text"], select,
.filter-table input[type="text"],
.filter-table select {
    width: 100%;
    height: 24px;              
    padding: 2px 8px;          
    border: 1px solid #ccd6e0;
    border-radius: 4px;        
    font-size: 12px;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    outline: none;
}

/* Readonly / disabled look */
input[readonly], input:disabled, 
.filter-table input[readonly], .filter-table input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
    cursor: not-allowed;
}

/* jqx date/time containers */
div[id^="periodupto"] {
    width: 100%;
}

/* ===== BUTTONS ===== */
.btn-submit {
    width: 100%;
    height: 30px;            
    padding: 0 12px;         
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 4px;      
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    line-height: 30px;       
    text-align: center;
    transition: background 0.2s;
}

.btn-submit:hover { background: #1d4ed8; }

.action-buttons {
    display: flex;
    gap: 10px;
    margin-top: 15px;
}

/* ===== RIGHT CONTENT AREA ===== */
.main-content-area {
    flex: 1; 
    display: flex;
    flex-direction: column;
    background: #ffffff;
    height: 100%;
    overflow: hidden;
}

.top-toolbar-container {
    width: 100%;
    padding: 10px 15px;
    background: #ffffff;
    border-bottom: 1px solid #e1e8ed;
    box-sizing: border-box;
}

.grid-content-container {
    flex: 1;
    padding: 15px;
    overflow: auto; 
    box-sizing: border-box;
}

/* Fix for jqx widget overrides */
.jqx-widget input, .jqx-widget select {
    height: 24px !important;
    line-height: 24px !important;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:200px;right:600px;'><img src='../../../../icons/31load.gif'/></div>");    
    
    // Updated to 100% width and 24px height
    $("#periodupto").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    $('#assetwindow').jqxWindow({ width: '40%', height: '60%',  maxHeight: '60%' ,maxWidth: '40%' , title: 'Asset Group Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#assetwindow').jqxWindow('close');
      
    $('#assetgrp').dblclick(function(){
        $('#assetwindow').jqxWindow('open');
        $('#assetwindow').jqxWindow('focus');
        assetSearchContent('assetGroupSearch.jsp');
    });
});

function getAssetGroup(event){
    var x = event.keyCode;
    if(x == 114){
        $('#assetwindow').jqxWindow('open');
        $('#assetwindow').jqxWindow('focus');
        assetSearchContent('assetGroupSearch.jsp');
    }
}

function assetSearchContent(url) {
    $.get(url).done(function (data) {
        $('#assetwindow').jqxWindow('setContent', data);
    }); 
}

function funreload(event) {
    var branch = document.getElementById("cmbbranch").value;
    var assetGrp = document.getElementById("hidassetgrp").value;
    
    if (branch) {
        $("#overlay, #PleaseWait").show();
        $("#falistdiv").load("faListGrid.jsp?branch="+branch+"&assetgroup="+assetGrp+'&check=1', function() {
            $("#overlay, #PleaseWait").hide();
        });
    }
}
    
function setValues(){
    if($('#msg').val() != ""){
        $.messager.alert('Message', $('#msg').val());
    }
}

function funExportBtn(){
    JSONToCSVCon(exportdata, 'Fixed Asset List', true);
}

function funClearData() {
    $('#cmbbranch').val('a');
    $('#assetgrp').val('');
    $('#hidassetgrp').val('');
    $('#periodupto').jqxDateTimeInput('setDate', new Date());
    
    // Reset Grid
    $("#falistdiv").html('<jsp:include page="faListGrid.jsp"></jsp:include>');
}
</script>
</head>

<body onload="getBranch();setValues();">
<form id="frmFAList" action="frmFAList" method="post">

<div id="mainBG">
    <div class="master-container">

        <!-- LEFT SIDEBAR -->
        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">

                <!-- Primary Filters Card -->
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Period Upto</td>
                            <td><div id="periodupto"></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Asset Group</td>
                            <td>
                                <input type="text" name="assetgrp" id="assetgrp" readonly placeholder="Press F3 to Search" onKeyDown="getAssetGroup(event);" />
                                <input type="hidden" name="hidassetgrp" id="hidassetgrp">
                            </td>
                        </tr>
                    </table>
                </div>

                <!-- Actions -->
                <div class="action-buttons">
                    <input type="button" class="btn-submit" value="Clear" onclick="funClearData();">
                </div>

                <!-- Hidden Inputs -->
                <div style="display:none;">
                    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                    <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                </div>

            </div>
        </div>

        <!-- MAIN CONTENT AREA -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="falistdiv">
                    <jsp:include page="faListGrid.jsp"></jsp:include>
                </div>
            </div>

        </div>

    </div>
</div>

<!-- JQX Windows -->
<div id="assetwindow">
    <div></div><div></div>
</div>

</form>
</body>
</html>