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

.filter-card-title {
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
    margin-bottom: 10px;
    border-bottom: 1px solid #e1e8ed;
    padding-bottom: 5px;
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
    width: 70px;
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

/* Radio Group */
.radio-group {
    display: flex;
    gap: 20px;
    align-items: center;
    font-size: 13px;
    color: #334155;
}

.radio-group input[type="radio"] {
    margin: 0 5px 0 0;
    vertical-align: middle;
    cursor: pointer;
}

.radio-group label {
    cursor: pointer;
}

/* jqx date/time containers */
div[id^="uptodate"] {
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
    $("#branchlabel").hide();
    $("#branchdiv").hide();
    
    // Updated to 100% width and 24px height
    $("#uptodate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    /* Searching Window */
    $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#employeeDetailsWindow').jqxWindow('close');
    
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    
    $('#txtemployeeid').dblclick(function(){
        employeeSearchContent("employeeDetailsSearch.jsp");
    });
    
    document.getElementById("rdactive").checked = true;
});
    
function employeeSearchContent(url) {
    $('#employeeDetailsWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#employeeDetailsWindow').jqxWindow('setContent', data);
        $('#employeeDetailsWindow').jqxWindow('bringToFront');
    }); 
}
    
function funExportBtn(){
    JSONToCSVCon(dataExcelExport, 'SeverancePay', true);
} 
    
function getEmployeeId(event){
    var x = event.keyCode;
    if(x == 114){
        employeeSearchContent("employeeDetailsSearch.jsp");
    }
}

function funreload(event){
    var branchval = document.getElementById("cmbbranch").value;
    var uptodate = $('#uptodate').val();
    var employeedocno = $('#txtemployeedocno').val();
    var check = 1;
    
    $("#overlay, #PleaseWait").show();
    
    if(document.getElementById("rdactive").checked == true){
        $("#severancePayDiv").load("severancePayGrid.jsp?rpttype=1&branchval="+branchval+'&uptodate='+uptodate+'&employeedocno='+employeedocno+'&check='+check);
    } else {
        $("#severancePayDiv").load("severancePayGrid.jsp?rpttype=0&branchval="+branchval+'&uptodate='+uptodate+'&employeedocno='+employeedocno+'&check='+check);
    }
}
    
function funClearInfo(){
    $('#cmbbranch').val('a');
    $('#uptodate').val(new Date());
    
    $('#txtemployeeid').val('');
    $('#txtemployeename').val('');
    $('#txtemployeedocno').val('');
    
    document.getElementById("rdactive").checked = true;
    
    $("#severancePayGridID").jqxGrid('clear');
    $("#severancePayGridID").jqxGrid('addrow', null, {});
    
    if (document.getElementById("txtemployeeid").value == "") {
        $('#txtemployeeid').attr('placeholder', 'Press F3 to Search'); 
        $('#txtemployeename').attr('placeholder', 'Employee Name');
    }
}
</script>
</head>

<body onload="getBranch();">
<div id="mainBG">
    <div class="master-container">

        <!-- LEFT SIDEBAR -->
        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">

                <!-- Date Filter Card -->
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">UpTo</td>
                            <td><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td>
                        </tr>
                    </table>
                </div>

                <!-- Report Type Card -->
                <div class="filter-card">
                    <div class="filter-card-title">Report Type</div>
                    <div class="radio-group">
                        <label>
                            <input type="radio" id="rdactive" name="rdo" value="rdactive"> Active
                        </label>
                        <label>
                            <input type="radio" id="rdinactive" name="rdo" value="rdinactive"> Inactive
                        </label>
                    </div>
                </div>

                <!-- Employee Filter Card -->
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Employee</td>
                            <td>
                                <input type="text" id="txtemployeeid" name="txtemployeeid" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtemployeeid"/>' onkeydown="getEmployeeId(event);"/>
                                <input type="hidden" id="txtemployeedocno" name="txtemployeedocno" value='<s:property value="txtemployeedocno"/>'/>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell"></td>
                            <td>
                                <input type="text" id="txtemployeename" name="txtemployeename" readonly="readonly" placeholder="Employee Name" tabindex="-1" value='<s:property value="txtemployeename"/>'/>
                            </td>
                        </tr>
                    </table>
                </div>

                <!-- Actions -->
                <div class="action-buttons">
                    <input type="button" class="btn-submit" name="clear" id="clear" value="Clear" onclick="funClearInfo();">
                </div>

            </div>
        </div>

        <!-- MAIN CONTENT AREA -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="severancePayDiv">
                    <jsp:include page="severancePayGrid.jsp"></jsp:include>
                </div>
            </div>

        </div>

    </div>
</div>

<!-- JQX Windows -->
<div id="employeeDetailsWindow">
    <div></div>
</div>

</body>
</html>