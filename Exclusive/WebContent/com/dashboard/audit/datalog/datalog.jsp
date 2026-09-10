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

/* Readonly / disabled look */
input[readonly], input:disabled, 
.filter-table input[readonly], .filter-table input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
    cursor: not-allowed;
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

/* Fix for jqx widget overrides */
.jqx-widget input, .jqx-widget select {
    height: 24px !important;
    line-height: 24px !important;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
    $("#btnExcel").click(function() {
        JSONToCSVCon(exceldata, 'Datalog Report', true);
    });

    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    
    $('#vehdetaildiv').hide();
    
    // Updated to 100% width and 24px height to match new design
    $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    $('#userwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'User Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
    $('#userwindow').jqxWindow('close');
    $('#formwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Form Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
    $('#formwindow').jqxWindow('close');
    
    var curfromdate = $('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate = new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
   
    $('#user').dblclick(function(){
        userSearchContent('userSearchGrid.jsp');
    });

    $('#form').dblclick(function(){
        formSearchContent('formSearchGrid.jsp');
    });
});

function getUser(event){
    var x = event.keyCode;
    if(x == 114){
        userSearchContent('userSearchGrid.jsp');
    }
}

function getForm(event){
    var x = event.keyCode;
    if(x == 114){
        formSearchContent('formSearchGrid.jsp');
    }
}
    
function userSearchContent(url) {
    $('#userwindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#userwindow').jqxWindow('setContent', data);
        $('#userwindow').jqxWindow('bringToFront');
    }); 
}

function formSearchContent(url) {
    $('#formwindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#formwindow').jqxWindow('setContent', data);
        $('#formwindow').jqxWindow('bringToFront');
    }); 
}

function funreload(event) {
    if(document.getElementById("cmbbranch").value == ""){
        $.messager.alert('Warning','Please Select Branch');
        return false;
    }
    
    var dateval = funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
    if(dateval == 1){
         var branch = document.getElementById("cmbbranch").value;
         var fromdate = $('#fromdate').jqxDateTimeInput('val');
         var todate = $('#todate').jqxDateTimeInput('val');
         var hidform = document.getElementById("hidform").value;
         var hiduser = document.getElementById("hiduser").value;
         
         $("#overlay, #PleaseWait").show();
         $("#logdiv").load("datalogGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&id=1&hidform="+hidform+"&hiduser="+hiduser);     
    }
}
    
function setValues(){
    if($('#msg').val() != ""){
        $.messager.alert('Message',$('#msg').val());
        $("#overlay, #PleaseWait").hide();
    }
}
    
function funClearData(){
    $('input[type=text],[type=hidden]').val('');
    $('#fromdate').jqxDateTimeInput('setDate',new Date());
    $('#todate').jqxDateTimeInput('setDate',new Date());
    
    var curfromdate = $('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate = new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);   
}
</script>
</head>

<body onload="getBranch();setValues();">
<form id="frmCostUpdate" method="post" action="saveCostUpdate">

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

                <!-- Form & User Filter Card -->
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Form Name</td>
                            <td>
                                <input type="text" id="form" name="form" placeholder="Press F3 to Search" readonly onkeydown="getForm(event);">
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">User</td>
                            <td>
                                <input type="text" id="user" name="user" placeholder="Press F3 to Search" readonly onkeydown="getUser(event);">
                            </td>
                        </tr>
                    </table>
                </div>

                <!-- Actions -->
                <div class="action-buttons">
                    <input type="button" id="btnclear" name="btnclear" value="Clear" class="btn-submit" onclick="funClearData();">
                </div>

                <!-- Hidden Inputs -->
                <div style="display:none;">
                    <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
                    <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
                    <input type="hidden" id="hiduser" name="hiduser">
                    <input type="hidden" id="hidform" name="hidform">
                </div>

            </div>
        </div>

        <!-- MAIN CONTENT AREA -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="logdiv">
                    <jsp:include page="datalogGrid.jsp"></jsp:include>
                </div>
            </div>

        </div>

    </div>
</div>

<!-- JQX Windows -->
<div id="userwindow">
    <div></div><div></div>
</div>
<div id="formwindow">
    <div></div><div></div>
</div>

</form>
</body>
</html>