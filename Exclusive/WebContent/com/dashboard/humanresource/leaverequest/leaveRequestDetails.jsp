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
    font-size: 13px;
    font-weight: 600;
    color: #334155;
    margin-bottom: 12px;
    border-bottom: 1px solid #e1e8ed;
    padding-bottom: 6px;
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

/* Radio Group */
.radio-group {
    display: flex;
    flex-direction: column;
    gap: 10px;
    font-size: 13px;
    color: #334155;
}

.radio-group label {
    cursor: pointer;
    display: flex;
    align-items: center;
}

.radio-group input[type="radio"] {
    margin: 0 8px 0 0;
    cursor: pointer;
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
    // Updated to 100% width and 24px height
    $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    /* Searching Window */
    $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#employeeDetailsWindow').jqxWindow('close');
    
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    
    var curfromdate = $('#fromdate').jqxDateTimeInput('getDate');
    var oneyeardate = new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
    var oneyearbackdate = new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
    $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
     
    document.getElementById("rdall").checked = true;
     
    $('#txtemployeeid').dblclick(function(){
        employeeSearchContent("employeeDetailsSearch.jsp");
    });
});
    
function employeeSearchContent(url) {
    $('#employeeDetailsWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#employeeDetailsWindow').jqxWindow('setContent', data);
        $('#employeeDetailsWindow').jqxWindow('bringToFront');
    }); 
}
    
function getDepartment() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var departmentItems = items[0].split(",");
            var departmentIdItems = items[1].split(",");
            var optionsdepartments = '<option value="">--Select--</option>';
            for (var i = 0; i < departmentItems.length; i++) {
                optionsdepartments += '<option value="' + departmentIdItems[i] + '">' + departmentItems[i] + '</option>';
            }
            $("select#cmbdepartment").html(optionsdepartments);
        }
    }
    x.open("GET", "getDepartment.jsp", true);
    x.send();
}
    
function getDesignation() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var designationItems = items[0].split(",");
            var designationIdItems = items[1].split(",");
            var optionsdesignation = '<option value="">--Select--</option>';
            for (var i = 0; i < designationItems.length; i++) {
                optionsdesignation += '<option value="' + designationIdItems[i] + '">' + designationItems[i] + '</option>';
            }
            $("select#cmbdesignation").html(optionsdesignation);
        }
    }
    x.open("GET", "getDesignation.jsp", true);
    x.send();
}
    
function getCategory() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var payrollcategoryItems = items[0].split(",");
            var payrollcategoryIdItems = items[1].split(",");
            var optionspayrollcategory = '<option value="">--Select--</option>';
            for (var i = 0; i < payrollcategoryItems.length; i++) {
                optionspayrollcategory += '<option value="' + payrollcategoryIdItems[i] + '">' + payrollcategoryItems[i] + '</option>';
            }
            $("select#cmbcategory").html(optionspayrollcategory);
        }
    }
    x.open("GET", "getCategory.jsp", true);
    x.send();
}
    
function getEmployeeId(event){
    var x = event.keyCode;
    if(x == 114){
        employeeSearchContent("employeeDetailsSearch.jsp");
    }
}

function funClearInfo(){
    $('#cmbbranch').val('a');
    $('#fromdate').val(new Date());
    $('#todate').val(new Date());
    
    var curfromdate = $('#fromdate').jqxDateTimeInput('getDate');
    var oneyeardate = new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
    var oneyearbackdate = new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
    $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
    
    $('#txtemployeeid').val('');
    $('#txtemployeename').val('');
    $('#txtemployeedocno').val('');
    
    $('#cmbdepartment').val('');
    $('#cmbdesignation').val('');
    $('#cmbcategory').val('');
    
    document.getElementById("rdall").checked = true;
    
    $("#leaveRequestDetailsGridID").jqxGrid('clear');
    $("#leaveRequestDetailsGridID").jqxGrid('addrow', null, {});
    
    if (document.getElementById("txtemployeeid").value == "") {
        $('#txtemployeeid').attr('placeholder', 'Press F3 to Search'); 
        $('#txtemployeename').attr('placeholder', 'Employee Name');
    }
}
    
function funreload(event){
    var branchval = $('#cmbbranch').val(); 
    var fromdate = $('#fromdate').val();
    var todate = $('#todate').val();
    var department = $('#cmbdepartment').val();
    var designation = $('#cmbdesignation').val();
    var category = $('#cmbcategory').val();
    var employee = $('#txtemployeedocno').val();
    
    $("#overlay, #PleaseWait").show();
    
    if(document.getElementById("rdpending").checked == true){
        $("#leaveRequestDetailsDiv").load("leaveRequestDetailsGrid.jsp?rpttype=2&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&department='+department+'&designation='+designation+'&category='+category+'&employee='+employee+'&check=1');
    } else if(document.getElementById("rdapproved").checked == true){
        $("#leaveRequestDetailsDiv").load("leaveRequestDetailsGrid.jsp?rpttype=3&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&department='+department+'&designation='+designation+'&category='+category+'&employee='+employee+'&check=1');
    } else{
        $("#leaveRequestDetailsDiv").load("leaveRequestDetailsGrid.jsp?rpttype=1&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&department='+department+'&designation='+designation+'&category='+category+'&employee='+employee+'&check=1');
    }
}
    
function funExportBtn(){
    if(parseInt(window.parent.chkexportdata.value) == "1") {
        JSONToCSVCon(data, 'LeaveRequestDetails', true);
    } else {
        $("#leaveRequestDetailsGridID").jqxGrid('exportdata', 'xls', 'LeaveRequestDetails');
    }
}
</script>
</head>

<body onload="getBranch();getDepartment();getDesignation();getCategory();">
<div id="mainBG">
    <div class="master-container">

        <!-- LEFT SIDEBAR -->
        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">

                <!-- Dates Filter Card -->
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">From</td>
                            <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">To</td>
                            <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
                        </tr>
                    </table>
                </div>

                <!-- Attributes Filter Card -->
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Department</td>
                            <td>
                                <select id="cmbdepartment" name="cmbdepartment" value='<s:property value="cmbdepartment"/>'></select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Designation</td>
                            <td>
                                <select id="cmbdesignation" name="cmbdesignation" value='<s:property value="cmbdesignation"/>'></select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Category</td>
                            <td>
                                <select id="cmbcategory" name="cmbcategory" value='<s:property value="cmbcategory"/>'></select>
                            </td>
                        </tr>
                    </table>
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

                <!-- Report Type Card -->
                <div class="filter-card">
                    <div class="filter-card-title">Report Type</div>
                    <div class="radio-group">
                        <label>
                            <input type="radio" id="rdall" name="rdo" value="rdall"> All
                        </label>
                        <label>
                            <input type="radio" id="rdpending" name="rdo" value="rdpending"> Pending
                        </label>
                        <label>
                            <input type="radio" id="rdapproved" name="rdo" value="rdapproved"> Approved
                        </label>
                    </div>
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
                <div id="leaveRequestDetailsDiv">
                    <jsp:include page="leaveRequestDetailsGrid.jsp"></jsp:include>
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