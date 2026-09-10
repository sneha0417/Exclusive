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
    width: 75px;
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
div[id^="uptodate"], div[id^="postingDate"] {
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

/* ===== ANIMATIONS ===== */
.bounce {
    color: #f35626;
    background-image: -webkit-linear-gradient(92deg,#f35626,#feab3a);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    -webkit-animation: hue 60s infinite linear, bounce 2s infinite; 
    text-align: center;
    font-weight: bold;
    font-size: 13px;
    margin: 10px 0 0 0;
}

@-webkit-keyframes bounce {
  0%, 20%, 50%, 80%, 100% { transform: translateX(0); }
  40% { transform: translateX(-30px); }
  60% { transform: translateX(-15px); }
} 

@-webkit-keyframes hue {
  from { -webkit-filter: hue-rotate(0deg); }
  to { -webkit-filter: hue-rotate(-360deg); }
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
    $("#uptodate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"MM.yyyy"});
    $("#postingDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    
    $('#uptodate').focusout(function(){
        getLastPayrollPostedDate();
    });
    
    getLastPayrollPostedDate();
});

function getLastPayrollPostedDate(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('***');
            $('#uptodate').val(items[0]);
            document.getElementById("lbllastposted").innerText = items[1].trim();
        }
    }
    x.open("GET", "getLastPayrollPostedDate.jsp", true);
    x.send();
}

function funClearData(){
    $('#cmbbranch').val('a');
    $('#uptodate').val(new Date());
    $('#postingDate').val(new Date());
    $('#txtremarks').val('');
    $('#txtremarks').attr('placeholder', 'Remarks');
    $('#txtselectedemployees').val('');
    
    disable();
    
    $('#txtdrtotal').val('');
    $('#txtcrtotal').val('');
    
    $("#monthlyPayrollPostingGridID").jqxGrid('clearselection');
    $("#monthlyPayrollTotalGridID").jqxGrid('clear');
    $("#monthlyPayrollPostingGridID").jqxGrid('clear');
    $("#monthlyPayrollPostingGridID").jqxGrid('addrow', null, {});
    $("#monthlyPayrollPostingGridID").jqxGrid({ disabled: true});
    $("#payrollPostingJVGridID").jqxGrid('clear');
    $("#payrollPostingJVGridID").jqxGrid({ disabled: true});
    
    getLastPayrollPostedDate();
    
    document.getElementById("gridlength").value = "";
    document.getElementById("mode").value = "";
    document.getElementById("msg").value = "";
}

function funreload(event){
    var branchval = document.getElementById("cmbbranch").value;
    var uptodate = $('#uptodate').val();
    
    if(uptodate == ''){
        $.messager.alert('Message','Save Payroll and Post.','warning');
        return;
    }
    
    var check = 1;
    $("#monthlyPayrollPostingGridID").jqxGrid('clearselection');
    $("#monthlyPayrollPostingGridID").jqxGrid('clear');
    $("#monthlyPayrollPostingGridID").jqxGrid('addrow', null, {});
    $("#monthlyPayrollPostingGridID").jqxGrid({ disabled: true});
    
    $("#payrollPostingJVGridID").jqxGrid('clear');
    $("#payrollPostingJVGridID").jqxGrid({ disabled: true});
    
    $('#txtdrtotal').val('');
    $('#txtcrtotal').val('');
    $('#postingDate').val(new Date());
    $('#txtremarks').val('');
    $('#txtremarks').attr('placeholder', 'Remarks');
    
    document.getElementById("gridlength").value = "";
    document.getElementById("mode").value = "";
    document.getElementById("msg").value = "";
    
    $('#txtselectedemployees').val('');
    $('#btnpost').attr("disabled", true);
    $('#postingDate').jqxDateTimeInput({ disabled: true});
    
    $("#overlay, #PleaseWait").show();
    
    $("#monthlypayrollTotalDiv").load("monthlyPayrollTotalGrid.jsp?branchval="+branchval+'&uptodate=01.'+uptodate+'&check='+check);
}

function disable(){
    $('#postingDate').jqxDateTimeInput({ disabled: true});
    $('#txtremarks').attr("readonly",true);
    $('#btnpost').attr("disabled",true);
    $("#monthlyPayrollPostingGridID").jqxGrid({ disabled: true});
    $("#payrollPostingJVGridID").jqxGrid({ disabled: true});
}

function funCalculate(){
    var rows = $('#monthlyPayrollPostingGridID').jqxGrid('getrows');
    if(rows.length == 1 && (rows[0].netsalary == "undefined" || rows[0].netsalary == null || rows[0].netsalary == "")){
        $.messager.alert('Message','Select Payroll to be Posted & Calculate.','warning');
        return 0;
    } 
    
    var rowsJV = $('#payrollPostingJVGridID').jqxGrid('getrows');
    var rowlength = rowsJV.length;
    if(rowlength != 0){
        $.messager.alert('Message','Already calculated.Submit Again. ','warning');
        return 0;
    } else {
        $("#payrollPostingJVGridID").jqxGrid('clear');
        $('#txtselectedemployees').val('');
    } 
    
    $("#overlay, #PleaseWait").show();
    
    var rowsPosting = $("#monthlyPayrollPostingGridID").jqxGrid('getrows');
    if(rowsPosting.length == 1 && (rowsPosting[0].netsalary == "undefined" || rowsPosting[0].netsalary == null || rowsPosting[0].netsalary == "")){
        return false;
    }
    
    var selectedrows = $("#monthlyPayrollPostingGridID").jqxGrid('selectedrowindexes');
    selectedrows = selectedrows.sort(function(a,b){return a - b});
    
    if(selectedrows.length == 0){
        $("#overlay, #PleaseWait").hide();
        $.messager.alert('Warning','Select Items to be Calculated.');
        return false;
    }
    
    var i = 0; var tempempdocnos = "", tempempcatids = "";
    $('#gridlength').val(selectedrows.length);
    var j = 0; var k = 0;
    
    for (i = 0; i < rowsPosting.length; i++) {
        if(selectedrows[j] == i){
            if(k == 1){
                tempempdocnos = tempempdocnos + "," + rowsPosting[i].employeedocno;
                tempempcatids = tempempcatids + "," + rowsPosting[i].empcatid;
            } else {
                tempempdocnos = rowsPosting[i].employeedocno;
                tempempcatids = rowsPosting[i].empcatid;
                k = 1;
            }
            j++; 
        }
    }
    
    $('#txtselectedemployees').val(tempempdocnos);
    $('#txtcategoryids').val(tempempcatids);
    var checked = 1;
    
    $("#payrollPostingJVGridID").jqxGrid('clear');
    $("#payrollPostingJVGridID").jqxGrid({ disabled: false});
    
    $('#postingDate').jqxDateTimeInput({ disabled: false});
    $('#txtremarks').attr("readonly", false);
    $('#btnpost').attr("disabled", false);
    
    $("#JVTDiv").load("monthlyJVGrid.jsp?branchval="+$('#cmbbranch').val()+'&uptodate=01.'+$('#uptodate').val()+'&category='+$('#txtcategoryids').val()+'&employees='+$('#txtselectedemployees').val()+'&postdate='+$('#postingDate').val()+'&checked='+checked);
}

function funPost(event){
    funNotify();
}

function funNotify() {  
    $.messager.confirm('Confirm', 'Do you want to Post?', function(r){
        if (r){
            /* Journal Voucher Grid Saving */
            var rows = $("#payrollPostingJVGridID").jqxGrid('getrows');
            var length = 0;
            for(var i=0; i < rows.length; i++){
                var chk = rows[i].docno;
                if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
                    newTextBox = $(document.createElement("input"))
                        .attr("type", "text")
                        .attr("id", "test"+length)
                        .attr("name", "test"+length)
                        .attr("hidden", "true");
                    length = length + 1;
                    
                    var amount, baseamount, id;
                    if((rows[i].credit != null) && (rows[i].credit != 'undefined') && (rows[i].credit != 'NaN') && (rows[i].credit != "") && (rows[i].credit != 0)){
                         amount = rows[i].credit * -1;
                         baseamount = rows[i].baseamount * -1;
                         id = -1;
                    }
                    if((rows[i].debit != null) && (rows[i].debit != 'undefined') && (rows[i].debit != 'NaN') && (rows[i].debit != "") && (rows[i].debit != 0)){
                         amount = rows[i].debit;
                         baseamount = rows[i].baseamount;
                         id = 1;
                    }
                    
                    newTextBox.val(rows[i].docno+"::"+rows[i].description+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+baseamount+"::"+amount+":: 0::"+id+":: "+rows[i].costtype+":: "+rows[i].costcode);
                    newTextBox.appendTo('form');
                }
            }
            $('#gridlength').val(length);
            /* Journal Voucher Grid Saving Ends */
            
            document.getElementById("mode").value = 'A';
            $("#overlay, #PleaseWait").show();
            document.getElementById("frmDashboardMonthlyPayrollPosting").submit();
        }
    });
    return 1;
} 

function setValues(){
    if($('#hiduptodate').val()){
        $("#uptodate").jqxDateTimeInput('val', $('#hiduptodate').val());
    }
    if($('#hidpostingDate').val()){
        $("#postingDate").jqxDateTimeInput('val', $('#hidpostingDate').val());
    }
  
    if($('#msg').val() != ""){
        $.messager.alert('Message', $('#msg').val());
        getLastPayrollPostedDate();
        funreload(event);
        disable(); 
    }
}
</script>
</head>
<body onload="getBranch();disable();setValues();">
<form id="frmDashboardMonthlyPayrollPosting" action="saveDashboardMonthlyPayrollPosting" method="post">

<div id="mainBG">
    <div class="master-container">

        <!-- LEFT SIDEBAR -->
        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">

                <!-- Payroll Period Card -->
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Up To</td>
                            <td>
                                <div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div>
                                <input type="hidden" id="hiduptodate" name="hiduptodate" readonly="readonly" value='<s:property value="hiduptodate"/>'/>
                            </td>
                        </tr>
                    </table>
                    
                    <!-- Last Posted Bounce Animation -->
                    <p class="bounce">
                        <label id="lbllastposted" name="lbllastposted"><s:property value="lbllastposted"/></label>
                    </p>
                </div>

                <!-- Monthly Payroll Total Grid Container -->
                <div class="filter-card" style="padding: 10px;">
                    <div id="monthlypayrollTotalDiv">
                        <jsp:include page="monthlyPayrollTotalGrid.jsp"></jsp:include>
                    </div>
                </div>

                <!-- Posting Details Card -->
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Posting</td>
                            <td>
                                <div id="postingDate" name="postingDate" value='<s:property value="postingDate"/>'></div>
                                <input type="hidden" id="hidpostingDate" name="hidpostingDate" readonly="readonly" value='<s:property value="hidpostingDate"/>'/>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Remarks</td>
                            <td>
                                <input type="text" id="txtremarks" name="txtremarks" placeholder="Remarks" value='<s:property value="txtremarks"/>'/>
                            </td>
                        </tr>
                    </table>
                </div>

                <!-- Actions -->
                <div class="action-buttons">
                    <button type="button" class="btn-success" id="btnpost" name="btnpost" onclick="funPost(event);">Post</button>
                    <input type="button" class="btn-submit" name="clear" id="clear" value="Clear" onclick="funClearData();">
                </div>

                <!-- Hidden Inputs -->
                <div style="display:none;">
                    <input type="hidden" id="txtselectedemployees" name="txtselectedemployees" value='<s:property value="txtselectedemployees"/>'/>
                    <input type="hidden" id="txtcategoryids" name="txtcategoryids" value='<s:property value="txtcategoryids"/>'/>
                    <input type="hidden" id="txtdrtotal" name="txtdrtotal" value='<s:property value="txtdrtotal"/>'/>
                    <input type="hidden" id="txtcrtotal" name="txtcrtotal" value='<s:property value="txtcrtotal"/>'/>
                    <input type="hidden" id="gridlength" name="gridlength" />
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
                
                <div id="monthlyPayrollPostingDiv">
                    <jsp:include page="monthlyPayrollPostingGrid.jsp"></jsp:include>
                </div>
                
                <div id="JVTDiv">
                    <jsp:include page="monthlyJVGrid.jsp"></jsp:include>
                </div>

            </div>

        </div>

    </div>
</div>

</form>
</body>
</html>