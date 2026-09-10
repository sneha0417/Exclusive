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

.btn-success {
    width: 100%;
    height: 30px;            
    padding: 0 12px;         
    background: #10b981; /* Green color for positive confirmation action */
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
.btn-success:hover { background: #059669; }

.action-buttons {
    display: flex;
    flex-direction: column;
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
    $("#uptodate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    /* Searching Window */
    $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#employeeDetailsWindow').jqxWindow('close');
    
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    
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

function saveGridData(selecteddocs, selectedempid, uptodate, branchid){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function(){
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            if(parseInt(items) > 0){
                $('#cmbbranch').val('a');
                $('#uptodate').val(new Date());
                $('#txtselecteddocs').val('');
                $('#txtselectedempid').val('');
                $('#cmbdepartment').val('');
                $('#cmbdesignation').val('');
                $('#cmbcategory').val('');
                $('#txtemployeeid').val('');
                $('#txtemployeename').val('');
                $('#txtemployeedocno').val('');
                
                if (document.getElementById("txtemployeeid").value == "") {
                    $('#txtemployeeid').attr('placeholder', 'Press F3 to Search'); 
                    $('#txtemployeename').attr('placeholder', 'Employee Name');
                }
                
                $.messager.alert('Message', '  Leave Confirmed ', function(r){});
                funreload(event);
            } else {
                $.messager.alert('Message', '  Leave Not Confirmed ', function(r){});
                $("#overlay, #PleaseWait").hide();
            } 
        }
    }
    x.open("GET","saveData.jsp?selecteddocs="+selecteddocs+"&selectedempid="+selectedempid+"&uptodate="+uptodate+"&branchid="+branchid, true);
    x.send();
}

function funConfirm() {
    var temp1 = "", tempempid1 = "";
    var rows = $("#leaveAcceptanceDetailsGridID").jqxGrid('getrows');
    if(rows.length == 1 && (rows[0].docno == "undefined" || rows[0].docno == null || rows[0].docno == "")){
        return false;
    }
    
    var selectedrows = $("#leaveAcceptanceDetailsGridID").jqxGrid('selectedrowindexes');
    selectedrows = selectedrows.sort(function(a,b){return a - b});
    
    if(selectedrows.length == 0){
        $("#overlay, #PleaseWait").hide();
        $.messager.alert('Warning','Select Leaves to be Confirmed.');
        return false;
    }
    
    var i=0; var j=0; var k=0; var temp="", tempempid="";
    for (i = 0; i < rows.length; i++) {
        if(selectedrows[j] == i){
            if(k == 0){
                temp = rows[i].docno;
                tempempid = rows[i].empdocno;
                k = 1;
            } else {
                temp = temp + "::" + rows[i].docno;
                tempempid = tempempid + "," + rows[i].empdocno;
            }
            temp1 = temp + "::";
            tempempid1 = tempempid + ",";
            j++; 
        }
    }
    
    $('#txtselecteddocs').val(temp1);
    $('#txtselectedempid').val(tempempid1);
    
    $.messager.confirm('Confirm', 'Do you want to Confirm ?', function(r){
        if (r){
            var selecteddocs = $('#txtselecteddocs').val();
            var selectedempid = $('#txtselectedempid').val();
            var uptodate = $('#uptodate').val();
            var branchid = $('#cmbbranch').val();
            
            $("#overlay, #PleaseWait").show();
            saveGridData(selecteddocs, selectedempid, uptodate, branchid);
        }
    });  
}

function funClearInfo(){
    $('#cmbbranch').val('a');
    $('#uptodate').val(new Date());
    $('#cmbdepartment').val('');
    $('#cmbdesignation').val('');
    $('#cmbcategory').val('');
    $('#txtemployeeid').val('');
    $('#txtemployeename').val('');
    $('#txtemployeedocno').val('');
    
    $("#leaveAcceptanceDetailsGridID").jqxGrid('clear');
    $("#leaveAcceptanceDetailsGridID").jqxGrid('addrow', null, {});
    
    if (document.getElementById("txtemployeeid").value == "") {
        $('#txtemployeeid').attr('placeholder', 'Press F3 to Search'); 
        $('#txtemployeename').attr('placeholder', 'Employee Name');
    }
}

function funreload(event){
    var branchval = $('#cmbbranch').val(); 
    var uptodate = $('#uptodate').val();
    var department = $('#cmbdepartment').val();
    var designation = $('#cmbdesignation').val();
    var category = $('#cmbcategory').val();
    var employee = $('#txtemployeedocno').val();
    
    $("#overlay, #PleaseWait").show();
    $('#txtselecteddocs').val('');
    $('#txtselectedempid').val('');
    
    $("#leaveAcceptanceDiv").load("leaveAcceptanceGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&department='+department+'&designation='+designation+'&category='+category+'&employee='+employee+'&check=1');
}

function funExportBtn(){
    if(parseInt(window.parent.chkexportdata.value) == "1") {
        JSONToCSVCon(data, 'LeaveAcceptanceDetails', true);
    } else {
        $("#leaveAcceptanceDetailsGridID").jqxGrid('exportdata', 'xls', 'LeaveAcceptanceDetails');
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

                <!-- Date Filter Card -->
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Up To</td>
                            <td><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td>
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

                <!-- Actions -->
                <div class="action-buttons">
                    <button type="button" id="btnConfirm" class="btn-success" onclick="funConfirm();">Confirm</button>
                    <input type="button" class="btn-submit" name="clear" id="clear" value="Clear" onclick="funClearInfo();">
                </div>

                <!-- Hidden Inputs -->
                <div style="display:none;">
                    <input type="hidden" name="txtselecteddocs" id="txtselecteddocs" value='<s:property value="txtselecteddocs"/>'>
                    <input type="hidden" name="txtselectedempid" id="txtselectedempid" value='<s:property value="txtselectedempid"/>'>
                </div>

            </div>
        </div>

        <!-- MAIN CONTENT AREA -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="leaveAcceptanceDiv">
                    <jsp:include page="leaveAcceptanceGrid.jsp"></jsp:include>
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