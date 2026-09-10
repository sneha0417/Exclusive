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
    width: 60px;
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

.btn-danger {
    width: 100%;
    height: 30px;            
    padding: 0 12px;         
    background: #ef4444; /* Red color for removal/destructive action */
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
.btn-danger:hover { background: #dc2626; }

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
    $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    
    var curfromdate = $('#fromdate').jqxDateTimeInput('getDate');
    var oneyeardate = new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
    var oneyearbackdate = new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
    $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
});      

function funClearInfo(){   
    $('#cmbbranch').val('a');
    $('#fromdate').val(new Date());
    $('#todate').val(new Date());
    
    var curfromdate = $('#fromdate').jqxDateTimeInput('getDate');
    var oneyeardate = new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
    var oneyearbackdate = new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
    $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
    
    $("#leaveRequestDetailsGridID").jqxGrid('clear');
    $("#leaveRequestDetailsGridID").jqxGrid('addrow', null, {});
}

function funreload(event){
    var branchval = $('#cmbbranch').val(); 
    var fromdate = $('#fromdate').val();
    var todate = $('#todate').val();
    
    $("#overlay, #PleaseWait").show();        
    $("#leaveRequestDetailsDiv").load("leaveRemovalGrid.jsp?rpttype=3&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&check=1');
}

function funExportBtn(){
    if(parseInt(window.parent.chkexportdata.value) == "1") {    
        JSONToCSVCon(data, 'LeaveRequestDetails', true);
    } else {
        $("#leaveRequestDetailsGridID").jqxGrid('exportdata', 'xls', 'LeaveRequestDetails');
    }
}

function funConfirm() {
    var empdocno = $("#hidempdocno").val();
    var branchid = $('#cmbbranch').val(); 
    var fromdate = $('#hidfromdate').val();     
    var todate = $('#hidtodate').val(); 
    
    var x = new XMLHttpRequest();
    x.onreadystatechange = function(){
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            if(parseInt(items) > 0){
                $.messager.alert('Message', 'Salary processed, cannot remove leaves ', function(r){});
                return false;   
            } else {
                funRemove();        
            } 
        }
    }
        
    x.open("GET","validate.jsp?empdocno="+empdocno+"&fromdate="+fromdate+"&todate="+todate+"&branchid="+branchid, true);              
    x.send();  
}

function funRemove() {
    var docno = $("#hiddocno").val();
    var empdocno = $("#hidempdocno").val();
    
    if(docno == ""){     
        $("#overlay, #PleaseWait").hide();
        $.messager.alert('Warning','Please select a document!!!');   
        return false;
    }

    $.messager.confirm('Confirm', 'Do you want to remove ?', function(r){   
        if (r){
            var branchid = $('#cmbbranch').val();
            $("#overlay, #PleaseWait").show();
            saveGridData(docno, empdocno, branchid);
        }
    });  
}

function saveGridData(docno, empdocno, branchid){              
    var x = new XMLHttpRequest();
    x.onreadystatechange = function(){
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            if(parseInt(items) > 0){
                $('#cmbbranch').val('a');
                $('#hiddocno').val('');
                $('#hidempdocno').val('');
                $.messager.alert('Message', '  Leave Removed ', function(r){});
                funreload(event);
            } else {
                $.messager.alert('Message', '  Leave Not Removed ', function(r){});
                $("#overlay, #PleaseWait").hide();
            } 
        }
    }
        
    x.open("GET","saveData.jsp?selecteddocs="+docno+"&selectedempid="+empdocno+"&branchid="+branchid, true);          
    x.send();
}
</script>
</head>
<body onload="getBranch();">
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

                <!-- Actions -->
                <div class="action-buttons">
                    <button type="button" id="btnConfirm" class="btn-danger" onclick="funConfirm();">Remove</button>
                    <input type="button" class="btn-submit" name="clear" id="clear" value="Clear" onclick="funClearInfo();">
                </div>

                <!-- Hidden Inputs -->
                <div style="display:none;">
                    <input type="hidden" id="hiddocno" name="hiddocno"/>
                    <input type="hidden" id="hidempdocno" name="hidempdocno"/>
                    <input type="hidden" id="hidfromdate" name="hidfromdate"/>
                    <input type="hidden" id="hidtodate" name="hidtodate"/>  
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
                    <jsp:include page="leaveRemovalGrid.jsp"></jsp:include>
                </div>
            </div>

        </div>

    </div>
</div>
</body>
</html>