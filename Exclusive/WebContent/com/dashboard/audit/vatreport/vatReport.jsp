<jsp:include page="../../../../includes.jsp"></jsp:include>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i) - VAT Report</title>
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
    width: 80px;
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

input[readonly], input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
}

/* jqx date/time containers */
div[id^="fromdate"], div[id^="todate"] {
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

/* ===== GRID CARDS & SUMMARY BAR ===== */
.grid-section {
    background: #fff;
    border: 1px solid #e1e8ed;
    border-radius: 8px;
    margin-bottom: 20px;
    box-shadow: 0 1px 3px rgba(0,0,0,.03);
    overflow: hidden;
}

.grid-header {
    background: #f8fafc;
    padding: 12px 15px;
    border-bottom: 1px solid #e1e8ed;
    font-size: 14px;
    font-weight: 600;
    color: #334155;
}

.grid-body {
    padding: 15px;
}

.summary-bar {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    padding: 15px 20px;
    background: #f8fafc;
    border: 1px solid #e1e8ed;
    border-radius: 8px;
    margin-bottom: 20px;
}

.summary-bar label {
    font-weight: 600;
    font-size: 14px;
    color: #334155;
    margin-right: 15px;
}

.summary-bar input {
    width: 150px;
    font-size: 14px;
    font-weight: bold;
    text-align: right;
    color: #0f172a;
    background-color: #fff !important;
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
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    
    // Updated to 100% width and 24px height
    $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    var curfromdate = $('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate = new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
    
    $('#nettotal, #totalinput, #totaloutput').val("0");
});

function funreload(event) {
    var fromdate = $('#fromdate').jqxDateTimeInput('val');
    var todate = $('#todate').jqxDateTimeInput('val');
    
    $("#overlay, #PleaseWait").show();
    $('#nettotal, #totalinput, #totaloutput').val("0");
    
    var nettotal = parseFloat($('#nettotal').val());
    var branch = $('#cmbbranch').val();
    funRoundAmt(nettotal, "nettotal");
    
    $("#vatoutputdiv").load("vatOutputGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1&branch="+branch);
    $("#vatinputdiv").load("vatInputGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id=1&branch="+branch);
}

function setValues(){
    if($('#msg').val() != ""){
        $.messager.alert('Message', $('#msg').val());
    }
}
    
function funExportBtn(){
    JSONToCSVCon(vatinputdata, 'VAT Input Report', true);
    JSONToCSVCon(vatoutputdata, 'VAT Output Report', true);
}
    
function funClearData(){
    $('input[type=text], [type=hidden]').not('#mode, #msg').val('');
    $('select').find('option').prop("selected", false);
    
    $('#fromdate').jqxDateTimeInput('setDate', new Date());
    $('#todate').jqxDateTimeInput('setDate', new Date());
    
    var curfromdate = $('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate = new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
    
    $('#nettotal, #totalinput, #totaloutput').val("0");
}
</script>
</head>

<body onload="setValues();getBranch();">
<form id="frmReplaceList" method="post">

<div id="mainBG">
    <div class="master-container">

        <!-- LEFT SIDEBAR -->
        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">

                <!-- Dates Filter Card -->
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">From Date</td>
                            <td><div id="fromdate"></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">To Date</td>
                            <td><div id="todate"></div></td>
                        </tr>
                    </table>
                </div>

                <!-- Actions -->
                <div class="action-buttons">
                    <!-- Restored the clear button that was previously commented out -->
                    <input type="button" name="btnclear" id="btnclear" value="Clear" class="btn-submit" onclick="funClearData();">
                </div>

                <!-- Hidden Inputs -->
                <div style="display:none;">
                    <input type="hidden" name="totalinput" id="totalinput" value='<s:property value="totalinput"/>'>
                    <input type="hidden" name="totaloutput" id="totaloutput" value='<s:property value="totaloutput"/>'>
                    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                    <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                    <input type="hidden" name="printdocno" id="printdocno" value='<s:property value="printdocno"/>'>
                </div>

            </div>
        </div>

        <!-- MAIN CONTENT AREA -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                
                <!-- Output Tax Section -->
                <div class="grid-section">
                    <div class="grid-header">Output Tax</div>
                    <div class="grid-body" id="vatoutputdiv">
                        <jsp:include page="vatOutputGrid.jsp"></jsp:include>
                    </div>
                </div>

                <!-- Input Tax Section -->
                <div class="grid-section">
                    <div class="grid-header">Input Tax</div>
                    <div class="grid-body" id="vatinputdiv">
                        <jsp:include page="vatInputGrid.jsp"></jsp:include>
                    </div>
                </div>

                <!-- Net Total Summary Bar -->
                <div class="summary-bar">
                    <label>Net Total</label>
                    <input type="text" name="nettotal" id="nettotal" value='<s:property value="nettotal"/>' readonly 
                           onKeyPress="javascript:return isNumber(event, id)" 
                           onBlur="funRoundAmt(value, id);">
                </div>

            </div>

        </div>
    </div>
</div>

<!-- JQX Windows -->
<div id="clientsearchwindow">
    <div></div>
</div>
<div id="agmtnowindow">
    <div></div>
</div>

</form>
</body>
</html>