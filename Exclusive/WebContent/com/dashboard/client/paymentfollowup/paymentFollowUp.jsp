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

/* Range inputs specifically */
.range-container {
    display: flex;
    align-items: center;
    gap: 5px;
}
.range-container input {
    width: 50%;
    text-align: right;
}

/* Readonly / disabled look */
input[readonly], input:disabled, select:disabled,
.filter-table input[readonly], .filter-table input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
    cursor: not-allowed;
}

/* Checkbox label styling */
.checkbox-inline {
    margin: 0 4px 0 0;
    vertical-align: middle;
}

/* jqx date/time containers */
div[id^="uptodate"], div[id^="followupdate"], div[id^="date"] {
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
.btn-submit:disabled { background: #93c5fd; cursor: not-allowed; }

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

.btn-secondary {
    width: 100%;
    height: 30px;            
    padding: 0 12px;         
    background: #64748b;
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
.btn-secondary:hover { background: #475569; }

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

<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/resample.js"></script> 

<script type="text/javascript">
$(document).ready(function () {
    // Updated to 100% width and 24px height
    $("#uptodate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    $("#followupdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    $("#date").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#accountDetailsWindow').jqxWindow('close');
    
    $('#uptodate').jqxDateTimeInput({disabled: true});
    
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    
    $('#txtclientaccount').dblclick(function(){
        accountsSearchContent('clientAccountDetailsSearch.jsp');
    });
    $('#txtcalculation').val(0);
});

function accountsSearchContent(url) {
    $('#accountDetailsWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#accountDetailsWindow').jqxWindow('setContent', data);
        $('#accountDetailsWindow').jqxWindow('bringToFront');
    }); 
}

function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
        $.messager.alert('Message',' Enter Numbers Only ','warning');    
        return false;
    }
    return true;
}

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

function getSalesPerson() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var salesagentItems = items[0].split(",");
            var salesagentIdItems = items[1].split(",");
            var optionssalesagent = '<option value="">--Select--</option>';
            for (var i = 0; i < salesagentItems.length; i++) {
                optionssalesagent += '<option value="' + salesagentIdItems[i] + '">' + salesagentItems[i] + '</option>';
            }
            $("select#cmbsalesperson").html(optionssalesagent);
            if ($('#hidcmbsalesperson').val() != null) {
                $('#cmbsalesperson').val($('#hidcmbsalesperson').val());
            }
        }
    }
    x.open("GET", "getSalesPerson.jsp", true);
    x.send();
}

function getCategory() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var categoryItems = items[0].split(",");
            var categoryIdItems = items[1].split(",");
            var optionscategory = '<option value="">--Select--</option>';
            for (var i = 0; i < categoryItems.length; i++) {
                optionscategory += '<option value="' + categoryIdItems[i] + '">' + categoryItems[i] + '</option>';
            }
            $("select#cmbcategory").html(optionscategory);
            if ($('#hidcmbcategory').val() != null) {
                $('#cmbcategory').val($('#hidcmbcategory').val());
            }
        }
    }
    x.open("GET", "getCategory.jsp", true);
    x.send();
}

function getClientAccount(event){
    var x = event.keyCode;
    if(x == 114){
        accountsSearchContent('clientAccountDetailsSearch.jsp');
    }
}
   
function disable(){
    $('#date').jqxDateTimeInput({ disabled: true});
    $('#cmbprocess').attr("disabled",true);
    $('#txtremarks').attr("readonly",true);
    $('#btnupdate').attr("disabled",true);
    $("#followUpDetailsGrid").jqxGrid('clear');
    $("#followUpDetailsGrid").jqxGrid("addrow", null, {}); 
    $("#followUpDetailsGrid").jqxGrid({ disabled: true});
}

function followupcheck(){
    if(document.getElementById("chckfollowup").checked){
        document.getElementById("hidchckfollowup").value = 1;
        $('#followupdate').jqxDateTimeInput({ disabled: false});
    } else {
        document.getElementById("hidchckfollowup").value = 0;
        $('#followupdate').jqxDateTimeInput({ disabled: true});
    }
}

function funCalculate(){
    $("#overlay, #PleaseWait").show();
    $('#txtcalculation').val(1);
    $('#paymentFollowUp').jqxGrid('showcolumn', 'current');
    $('#paymentFollowUp').jqxGrid('showcolumn', 'salik');
    $('#paymentFollowUp').jqxGrid('showcolumn', 'traffic');   
    paymentFollowUpGriGridReload();
}

function paymentFollowUpGriGridReload(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function(){
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            var arrayitems = items.split(",");
            var rows = $('#paymentFollowUp').jqxGrid('getrows');
            
            for(var i=0; i<rows.length; i++){
                for(var j=0; j<arrayitems.length; j++){
                    var temp = arrayitems[j].split("###");
                    if(rows[i].cldocno == temp[0]){
                        $('#paymentFollowUp').jqxGrid('setcellvalue', i, "current", temp[3]);
                        $('#paymentFollowUp').jqxGrid('setcellvalue', i, "salik", temp[1]);
                        $('#paymentFollowUp').jqxGrid('setcellvalue', i, "traffic", temp[2]);
                    }
                    if(i == rows.length-1){
                        $("#overlay, #PleaseWait").hide();
                    }   
                }
            }
        }
    }
    x.open("GET","paymentGridReload.jsp",true);
    x.send();   
}

function funreload(event){
    var branchval = document.getElementById("cmbbranch").value;
    var uptodate = $('#uptodate').val();
    var clientaccount = $('#txtclientaccountdocno').val();
    var chkfollowup = $('#hidchckfollowup').val();
    var followupdate = $('#followupdate').val();
    var salesperson = $('#cmbsalesperson').val();
    var category = $('#cmbcategory').val();
    var amtrangefrm = $('#txtamtrangefrom').val();
    var amtrangeto = $('#txtamtrangeto').val();
    
    $("#overlay, #PleaseWait").show();
    
    $("#paymentFollowUpDiv").load("paymentFollowUpGrid.jsp?clientaccount="+clientaccount+'&branchval='+branchval+'&uptodate='+uptodate+'&chkfollowup='+chkfollowup+'&followupdate='+followupdate+'&salesperson='+salesperson+'&category='+category+'&amtrangefrm='+amtrangefrm+'&amtrangeto='+amtrangeto+'&clientstatus=0&check=1');
}

function funUpdate(event){
    var process = $('#cmbprocess').val();
    var processname = $("#cmbprocess option:selected").text().trim();
    var date =  $('#date').val();
    var branchid = $('#txtbranch').val();
    var remarks = $('#txtremarks').val();
    var docno = $('#txtdocno').val();
    var accountno = $('#txtacountno').val();
    var cldocno = $('#txtcldocno').val();
    
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
            saveGridData(process, processname, date, branchid, docno, accountno, remarks, cldocno);  
        }
    });
}

function funOutStandingStatement(){
    var accno = $('#txtacountno').val();
    
    if(accno == ''){
        $.messager.alert('Message','Please Choose a Client.','warning');
        return 0;
    }
    
    if ($("#txtacountno").val() != "") {
        var url = document.URL;
        var reurl = url.split("paymentFollowUp.jsp");
        $("#txtacountno").prop("disabled", false);
        
        var win = window.open(reurl[0]+"printOutstandingsStatement?atype=AR&acno="+document.getElementById("txtacountno").value+'&level1from=0&level1to=30&level2from=31&level2to=60&level3from=61&level3to=90&level4from=91&level4to=120&level5from=121&branch='+document.getElementById("cmbbranch").value+'&uptoDate='+$("#uptodate").val()+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        win.focus();
    } else {
        $.messager.alert('Message','Account is Mandatory.','warning');
        return;
    }
}

function funSendingEmail() {  
    var email = document.getElementById("txtclientaccountemail").value;
    var res; var part1; var part2; var dotsplt;
    if(email.indexOf("@") >= 0) {
        res = email.split('@');
        part1 = res[0];
        part2 = res[1];
        dotsplt = part2.split('.');
    }
    
    if ($("#txtacountno").val().trim() == "" || typeof($("#txtacountno").val().trim()) == "undefined" || typeof($("#txtacountno").val().trim()) == "NaN") {
        $('#txtacountno').val('');
        $.messager.alert('Message','Please Choose a Client/Supplier.','warning');
        return;
    } else if(email.trim() == "" || typeof(email.trim()) == "undefined" || typeof(email.trim()) == "NaN") {
        $.messager.alert('Message','Email is not Configured Properly.','warning');
        return;
    } else if(email.indexOf("@") < 0) {
        $.messager.alert('Message','Email is not Configured Properly.','warning');
        return;
    } else if(email.split('@').length != 2) {
        $.messager.alert('Message','Email is not Configured Properly.','warning');
        return;
    } else if(part1.length == 0) {
        $.messager.alert('Message','Email is not Configured Properly.','warning');
        return;
    } else if(part1.split(" ").length > 2) {
        $.messager.alert('Message','Email is not Configured Properly.','warning');
        return;
    } else if(part2.split(".").length < 2) {
        $.messager.alert('Message','Email is not Configured Properly.','warning');
        return;
    } else if(dotsplt[0].length == 0 ) {
        $.messager.alert('Message','Email is not Configured Properly.','warning');
        return;
    } else if(dotsplt[1].length < 2 || dotsplt[1].length > 4) {
        $.messager.alert('Message','Email is not Configured Properly.','warning');
        return;
    } else {
        $("#overlay, #PleaseWait").show();
        
        $.ajaxFileUpload({              
            url: 'printOutstandingsStatement.action?acno='+document.getElementById("txtacountno").value+'&atype=AR&level1from=0&level1to=30&level2from=31&level2to=60&level3from=61&level3to=90&level4from=91&level4to=120&level5from=121&branch='+document.getElementById("txtbranch").value+'&uptoDate='+$("#uptodate").val()+'&email='+$('#txtclientaccountemail').val()+'&print=0',  
            secureuri:false,
            fileElementId:'file',
            dataType: 'string',
            success: function (data, status) {  
                if(status == 'success'){
                    $("#overlay, #PleaseWait").hide();
                    $.messager.alert('Message','E-Mail Send Successfully');
                }
                if(status == 'error'){
                     $("#overlay, #PleaseWait").hide();
                     $.messager.alert('Message','E-Mail Sending failed');
                }
                
                $("#testImg").attr("src",data.message);
                if(typeof(data.error) != 'undefined') {  
                    if(data.error != '') {  
                        alert(data.error);  
                    } else {  
                        alert(data.message);  
                    }  
                }  
            },  
            error: function (data, status, e) {  
                alert(e);  
            }  
        }); 
        return false;
    } 
}
    
function saveGridData(process, processname, date, branchid, docno, accountno, remarks, cldocno){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function(){
        if (x.readyState == 4 && x.status == 200){
            var items = x.responseText;
            
            $('#cmbprocess').val('');
            $('#date').val(new Date());
            $('#txtbranch').val('');
            $('#txtremarks').val('');
            $('#txtdocno').val('');
            $('#txtacountno').val('');
            $('#txtcldocno').val('');
            $('#txtclientaccount').val('');
            $('#txtclientname').val('');
            $('#txtclientaccountdocno').val('');
            
            if (document.getElementById("txtclientaccount").value == "") {
                $('#txtclientaccount').attr('placeholder', 'Press F3 to Search'); 
            }
            
            $.messager.alert('Message', '  Record Successfully Updated ', function(r){});
            disable();
        }
    }
        
    x.open("GET","saveData.jsp?process="+process+"&processname="+processname+"&date="+date+"&branchid="+branchid+"&docno="+docno+"&accountno="+accountno+"&remarks="+remarks+"&cldocno="+cldocno,true);
    x.send();
}

function funExportBtn(){
    if(parseInt(window.parent.chkexportdata.value) == "1") {
        JSONToCSVCon(dataExcelExport, 'PaymentFollowUp', true);
    } else {
        $("#paymentFollowUp").jqxGrid('exportdata', 'xls', 'PaymentFollowUp');
    }
}
</script>
</head>

<body onload="getBranch();getProcess();disable();getSalesPerson();getCategory();followupcheck();">
<div id="mainBG">
    <div class="master-container">

        <!-- LEFT SIDEBAR -->
        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">

                <!-- Client & Dates Filter Card -->
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Up To</td> 
                            <td><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td>
                        </tr> 
                        <tr>
                            <td class="label-cell">Client</td>
                            <td>
                                <input type="text" id="txtclientaccount" name="txtclientaccount" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtclientaccount"/>' onkeydown="getClientAccount(event);"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell"></td>
                            <td>
                                <input type="text" id="txtclientname" name="txtclientname" readonly="readonly" value='<s:property value="txtclientname"/>'/>
                                <input type="hidden" id="txtclientaccountdocno" name="txtclientaccountdocno" value='<s:property value="txtclientaccountdocno"/>'/>
                                <input type="hidden" id="txtclientaccountemail" name="txtclientaccountemail" value='<s:property value="txtclientaccountemail"/>'/>
                            </td>
                        </tr>
                    </table>
                </div>

                <!-- Attributes Filter Card -->
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">
                                <label for="chckfollowup" style="cursor:pointer; display:flex; align-items:center; justify-content:flex-end;">
                                    <input type="checkbox" id="chckfollowup" name="chckfollowup" class="checkbox-inline" value="" onchange="followupcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /> 
                                    FollowUp
                                </label>
                                <input type="hidden" id="hidchckfollowup" name="hidchckfollowup" value='<s:property value="hidchckfollowup"/>'/>
                            </td>
                            <td><div id="followupdate" name="followupdate" value='<s:property value="followupdate"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Sales Person</td>
                            <td>
                                <select id="cmbsalesperson" name="cmbsalesperson" value='<s:property value="cmbsalesperson"/>'>
                                    <option value="">--Select--</option>
                                </select>
                                <input type="hidden" id="hidcmbsalesperson" name="hidcmbsalesperson" value='<s:property value="hidcmbsalesperson"/>'/>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Category</td>
                            <td>
                                <select id="cmbcategory" name="cmbcategory" value='<s:property value="cmbcategory"/>'>
                                    <option value="">--Select--</option>
                                </select>
                                <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Amount</td>
                            <td>
                                <div class="range-container">
                                    <input type="text" id="txtamtrangefrom" name="txtamtrangefrom" onkeypress="javascript:return isNumber(event)" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txtamtrangefrom"/>'/>
                                    <span>-</span>
                                    <input type="text" id="txtamtrangeto" name="txtamtrangeto" onkeypress="javascript:return isNumber(event)" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txtamtrangeto"/>'/>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>

                <!-- Update Details Filter Card -->
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
                    <button type="button" id="btnIndividual" class="btn-secondary" onclick="funOutStandingStatement();">Outstanding Statement</button>
                </div>

                <!-- Hidden Inputs for Form submission and JS logic -->
                <div style="display:none;">
                    <input type="hidden" id="txtacountno" name="txtacountno" value='<s:property value="txtacountno"/>'/>
                    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
                    <input type="hidden" id="txtbranch" name="txtbranch" value='<s:property value="txtbranch"/>'/>
                    <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>
                    <input type="hidden" id="txtcalculation" name="txtcalculation" value='<s:property value="txtcalculation"/>'/>
                </div>

            </div>
        </div>

        <!-- MAIN CONTENT AREA -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="paymentFollowUpDiv">
                    <jsp:include page="paymentFollowUpGrid.jsp"></jsp:include>
                </div>
                <div id="detailDiv">
                    <jsp:include page="detailGrid.jsp"></jsp:include>
                </div>
            </div>

        </div>

    </div>
</div>

<!-- JQX Windows -->
<div id="accountDetailsWindow">
    <div></div><div></div>
</div>

</body>
</html>