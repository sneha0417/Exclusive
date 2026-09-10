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
    width: 70px;
}

/* ===== UNIFORM 24px INPUTS, SELECTS, AND TEXTAREAS ===== */
input[type="text"], select, textarea,
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
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

textarea {
    height: 80px;
    resize: none;
    padding: 8px;
}

/* Readonly / disabled look */
input[readonly], input:disabled, select:disabled, textarea[readonly],
.filter-table input[readonly], .filter-table input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
    cursor: not-allowed;
}

/* jqx date/time containers */
div[id^="uptodate"], div[id^="date"], div[id^="expiryDate"] {
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
    background: #10b981;
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
.btn-success:disabled { background: #6ee7b7; cursor: not-allowed; }

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
    display: flex;
    flex-direction: column;
    gap: 20px;
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
    $("#date").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    $("#expiryDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
});

function getProcess() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            
            var srno  = items[0].split(",");
            var process = items[1].split(",");
            var optionsbranch = '<option value="" selected>-- Select -- </option>';
            for (var i = 0; i < process.length; i++) {
                optionsbranch += '<option value="' + srno[i].trim() + '">' + process[i] + '</option>';
            }
            $("select#cmbprocess").html(optionsbranch);
        }
    }
    x.open("GET","getProcess.jsp", true);
    x.send();
}

function funClearData(){
    $('#cmbbranch').val('a');
    $('#uptodate').val(new Date());
    $('#clientinfo').val('');
    $('#cmbprocess').val('');
    $('#date').val(new Date());
    $('#txtremarks').val('');
    $('#expiryDate').val(new Date());
    $('#txtcldocno').val('');
    $('#txtdriver').val('');
    $('#txtbranch').val('');
    $('#txtdocument').val('');
    
    disable();
    
    $("#documentExpiry").jqxGrid('clear');
    $("#documentExpiry").jqxGrid('addrow', null, {});
    $("#documentDetailsGrid").jqxGrid('clear');
    $("#documentDetailsGrid").jqxGrid('addrow', null, {});
}
    
function funreload(event){
    var branchval = document.getElementById("cmbbranch").value;
    var uptodate = $('#uptodate').val();

    $('#cmbprocess').val('');
    $('#date').val(new Date());
    $('#expiryDate').val(new Date());
    $('#txtbranch').val('');
    $('#txtcldocno').val('');
    $('#txtremarks').val('');
    $('#txtdriver').val('');
    $('#txtdocument').val('');
    
    $('#btnupdate').attr("disabled", true);
    $('#cmbprocess').attr("disabled", true);
    $('#date').jqxDateTimeInput({ disabled: true});
    
    $("#documentDetailsGrid").jqxGrid('clear');
    $("#documentDetailsGrid").jqxGrid('addrow', null, {});
    
    $("#overlay, #PleaseWait").show();
    
    $("#documentExpiryDiv").load("documentExpiryGrid.jsp?branchval="+branchval+'&uptodate='+uptodate);
}

function disable(){
    $('#date').jqxDateTimeInput({ disabled: true});
    $('#cmbprocess').attr("disabled", true);
    $('#txtremarks').attr("readonly", true);
    $('#btnupdate').attr("disabled", true);
}
    
function funUpdate(event){
    var process = $('#cmbprocess').val();
    var date =  $('#date').val();
    var branchid = $('#txtbranch').val();
    var cldocno = $('#txtcldocno').val();
    var expirydate = $('#expiryDate').val();
    var remarks = $('#txtremarks').val();
    var driversrno = $('#txtdriver').val();
    var document = $('#txtdocument').val();
    
    if(process == ''){
        $.messager.alert('Message','Choose a Process.','warning');
        return 0;
    }

    if(remarks == ''){
        $.messager.alert('Message','Please Enter Remarks.','warning');   
        return 0;
    }
    
    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
        if(r == false) {
            return false; 
        } else {
            saveGridData(process, date, branchid, cldocno, expirydate, remarks, driversrno, document);  
        }
    });
}
    
function saveGridData(process, date, branchid, cldocno, expirydate, remarks, driversrno, document){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function(){
        if (x.readyState == 4 && x.status == 200){
            var items = x.responseText;
            
            $('#cmbprocess').val('');
            $('#date').val(new Date());
            $('#txtbranch').val('');
            $('#txtcldocno').val('');
            $('#expiryDate').val(new Date());
            $('#txtremarks').val('');
            $('#txtdriver').val('');
            $('#txtdocument').val('');
            
            $.messager.alert('Message', '  Record Successfully Updated ', function(r){});
            funreload(event); 
            disable();
            $('#clientinfo').val('');
        }
    }
    x.open("GET","saveData.jsp?process="+process+"&date="+date+"&branchid="+branchid+"&cldocno="+cldocno+"&expirydate="+expirydate+"&remarks="+remarks+"&driversrno="+driversrno+"&document="+document, true);
    x.send();
}
    
function funExportBtn(){
    if(parseInt(window.parent.chkexportdata.value) == "1") {
        JSONToCSVCon(data, 'DocumentExpiry', true);
    } else {
        $("#documentExpiry").jqxGrid('exportdata', 'xls', 'DocumentExpiry');
    }
}
</script>
</head>

<body onload="getBranch();getProcess();disable();">
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

                <!-- Client Info Card -->
                <div class="filter-card">
                    <textarea id="clientinfo" name="clientinfo" readonly="readonly" placeholder="Client Info..."><s:property value="clientinfo"></s:property></textarea>
                </div>

                <!-- Update Process Card -->
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Process</td>
                            <td><select name="cmbprocess" id="cmbprocess" value='<s:property value="cmbprocess"/>'></select></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Date</td>
                            <td><div id="date" name="date" value='<s:property value="date"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Remarks</td>
                            <td><input type="text" id="txtremarks" name="txtremarks" value='<s:property value="txtremarks"/>'/></td>
                        </tr>
                    </table>
                </div>

                <!-- Actions -->
                <div class="action-buttons">
                    <button type="button" id="btnupdate" class="btn-success" onclick="funUpdate(event);">Update</button>
                    <input type="button" class="btn-submit" name="clear" id="clear" value="Clear" onclick="funClearData();">
                </div>

                <!-- Hidden Inputs -->
                <div style="display:none;">
                    <div id='expiryDate' name='expiryDate' value='<s:property value="expiryDate"/>'></div>
                    <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>
                    <input type="hidden" id="txtdriver" name="txtdriver" value='<s:property value="txtdriver"/>'/>
                    <input type="hidden" id="txtbranch" name="txtbranch" value='<s:property value="txtbranch"/>'/>
                    <input type="hidden" id="txtdocument" name="txtdocument" value='<s:property value="txtdocument"/>'/>
                </div>

            </div>
        </div>

        <!-- MAIN CONTENT AREA -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="documentExpiryDiv">
                    <jsp:include page="documentExpiryGrid.jsp"></jsp:include>
                </div>
                <div id="detailDiv">
                    <jsp:include page="detailGrid.jsp"></jsp:include>
                </div>
            </div>

        </div>

    </div>
</div>
</body>
</html>