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
input[readonly], input:disabled, select:disabled,
.filter-table input[readonly], .filter-table input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
    cursor: not-allowed;
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
    background: #10b981; /* Green color for Save action */
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
    
function getPayrollCategory() {
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
            $("select#cmbempcategory").html(optionspayrollcategory);
        }
    }
    x.open("GET", "getPayrollCategory.jsp", true);
    x.send();
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
    
function getEmployeeId(event){
    var x = event.keyCode;
    if(x == 114){
        employeeSearchContent("employeeDetailsSearch.jsp");
    }
}

function funClearInfo(){
    $('#cmbbranch').val('a');
    $('#txtemployeeid').val('');
    $('#txtemployeename').val('');
    $('#txtemployeedocno').val('');
    $('#txtemployeeids').val('');
    $('#cmbempcategory').val('');
    $('#cmbdepartment').val('');
    $('#msg').val('');
    $('#mode').val('');
    $('#gridlength').val('');
    
    $("#openingDetailsGridID").jqxGrid('clear');
    $("#openingDetailsGridID").jqxGrid('addrow', null, {});
    
    if (document.getElementById("txtemployeedocno").value == "") {
        $('#txtemployeeid').attr('placeholder', 'Press F3 to Search'); 
        $('#txtemployeename').attr('placeholder', 'Employee Name');
    }
}
    
function funreload(event){
    var branchval = document.getElementById("cmbbranch").value;
    var category = $('#cmbempcategory').val();
    var department = $('#cmbdepartment').val();
    var employee = $('#txtemployeedocno').val();
    
    $('#txtemployeeids').val('');
    $('#msg').val('');
    $('#mode').val('');
    $('#gridlength').val('');
    
    $("#overlay, #PleaseWait").show();
    
    $("#openingBalanceDetailsDiv").load("openingBalanceGrid.jsp?category="+category+'&department='+department+'&employee='+employee+'&check=1');
}
    
function funNotify(){   
    var employeeids = $('#txtemployeeids').val();
    if(employeeids.trim() == ''){
         $.messager.alert('Message','Change Opening For Some Employee(s) Before Saving.','warning');
         return;
    }
    
    $.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
        if (r){
            /* Opening Balance Grid Saving */
            var rows = $("#openingDetailsGridID").jqxGrid('getrows');
            var length = 0;
            for(var i=0; i < rows.length; i++){
                var chk = rows[i].tobesaved;
                if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
                    newTextBox = $(document.createElement("input"))
                        .attr("type", "text")
                        .attr("id", "test"+length)
                        .attr("name", "test"+length)
                        .attr("hidden", "true");
                    length = length + 1;
                        
                    newTextBox.val(rows[i].empdocno+"::"+rows[i].empacno+":: "+rows[i].terminationbenefits+":: "+rows[i].leavesalary+":: "+rows[i].travels);
                    newTextBox.appendTo('form');
                }
            }
            $('#gridlength').val(length);
            /* Opening Balance Grid Saving Ends */
            
            document.getElementById("mode").value = 'A';
            $("#overlay, #PleaseWait").show();
            document.getElementById("frmDashboardOpening").submit();
        }
    });
    return 1;
}
    
function setValues(){
    if($('#msg').val() != ""){
        $.messager.alert('Message', $('#msg').val());
        funreload(event);
    }
}
    
function funExportBtn(){
    JSONToCSVCon(data, 'OpeningBalance', true);
} 
</script>
</head>

<body onload="getBranch();setValues();getPayrollCategory();getDepartment();">
<form id="frmDashboardOpening" action="saveDashboardOpening" method="post">

<div id="mainBG">
    <div class="master-container">

        <!-- LEFT SIDEBAR -->
        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">

                <!-- Categories & Departments Card -->
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Category</td>
                            <td>
                                <select id="cmbempcategory" name="cmbempcategory" value='<s:property value="cmbempcategory"/>'></select>
                                <input type="hidden" id="hidcmbempcategory" name="hidcmbempcategory" value='<s:property value="hidcmbempcategory"/>'/>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Department</td>
                            <td>
                                <select id="cmbdepartment" name="cmbdepartment" value='<s:property value="cmbdepartment"/>'></select>
                                <input type="hidden" id="hidcmbdepartment" name="hidcmbdepartment" value='<s:property value="hidcmbdepartment"/>'/>
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
                    <input type="button" class="btn-success" id="btnSaveOpening" name="btnSaveOpening" value="Save" onclick="funNotify();">
                    <input type="button" class="btn-submit" name="clear" id="clear" value="Clear" onclick="funClearInfo();">
                </div>

                <!-- Hidden Inputs for form submission logic -->
                <div style="display:none;">
                    <input type="hidden" id="txtemployeeids" name="txtemployeeids" value='<s:property value="txtemployeeids"/>'/>
                    <input type="hidden" id="gridlength" name="gridlength" value='<s:property value="gridlength"/>'/>
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
                <div id="openingBalanceDetailsDiv">
                    <jsp:include page="openingBalanceGrid.jsp"></jsp:include>
                </div>
            </div>

        </div>

    </div>
</div>

<!-- JQX Windows -->
<div id="employeeDetailsWindow">
    <div></div>
</div>

</form>
</body>
</html>