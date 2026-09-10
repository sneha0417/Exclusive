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

/* Readonly / disabled look */
input[readonly], input:disabled, select:disabled,
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

/* Flex layout for side-by-side inputs (like Select + Hidden Day Input) */
.type-flex-container {
    display: flex;
    gap: 8px;
    align-items: center;
}

/* Fix for jqx widget overrides */
.jqx-widget input, .jqx-widget select {
    height: 24px !important;
    line-height: 24px !important;
}
</style>

<script type="text/javascript">
    var selectedBox = null;
    
    $(document).ready(function () {
        // Updated to 100% width and 24px height for new layout
        $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
        $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
        
        $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
        $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
         
        var curfromdate = $('#fromdate').jqxDateTimeInput('getDate');
        var oneyeardate = new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
        var oneyearbackdate = new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
        $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
         
        $('#cmbchoose').val('4');
        $('#txtnoofdays').attr('readonly', true).val('');
        
        $("#overlay, #PleaseWait").show();
    });
    
    function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
            $.messager.alert('Message',' Enter Numbers Only ','warning');    
            return false;
        }
        return true;
    }
    
    function getGridColumnCalculation(fromdate, todate, frequencytype, noofdays){
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('***');
                var frequencyType = items[0];
                var difference = items[1];
                var columns = items[2];
                  
                if(parseInt(columns) == 1) {
                    $.messager.alert('Message','Period is too Long, Limit Reached.','warning');
                    return;
                } else {
                    var branchval = document.getElementById("cmbbranch").value;
                    var check = 1;
                    $("#overlay, #PleaseWait").show();
                    $("#analysisDiv").load("accountAnalysisGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&frequencytype='+frequencytype+'&noofdays='+noofdays+'&check='+check);
                }
            }
        }
        x.open("GET", "getGridColumnCalculation.jsp?fromdate="+fromdate+"&todate="+todate+"&frequencytype="+frequencytype+"&noofdays="+noofdays, true);
        x.send();
    }

    function noOfDays(){
        // Handled dynamic revealing of the input if custom days (value '1') is chosen
        if($('#cmbchoose').val() == 1){
            $('#txtnoofdays').attr('readonly', false);
            $('#txtnoofdays').val('0');            
            $('#txtnoofdays').attr('type', 'text');
        } else {
            $('#txtnoofdays').attr('readonly', true);
            $('#txtnoofdays').val('');
            $('#txtnoofdays').attr('type', 'hidden');
        }
    }
    
    function funreload(event){
        var fromdate = $('#fromdate').val();
        var todate = $('#todate').val();
        var frequencytype = $('#cmbchoose').val();
        var noofdays = $('#txtnoofdays').val();
        
        if(fromdate == todate) {
            $.messager.alert('Message','Not a Valid Period, From Date & To Date are Same.','warning');
            return;
        }
        
        getGridColumnCalculation(fromdate, todate, frequencytype, noofdays);
    }
    
    function funClearInfo(){
        $('#cmbbranch').val('a');
        
        $('#fromdate').val(new Date());
        var curfromdate = $('#fromdate').jqxDateTimeInput('getDate');
        var oneyeardate = new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
        var oneyearbackdate = new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
        $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
         
        $('#todate').val(new Date());
        
        $('#cmbchoose').val('4');
        $('#txtnoofdays').val('');
        $('#txtnoofdays').attr('readonly', true);
        $('#txtnoofdays').attr('type', 'hidden');
    }
        
    function funExportBtn(){
        if(parseInt(window.parent.chkexportdata.value) == "1") {
            JSONToCSVCon(data, 'AccountAnalysis', true);
        } else {
            $("#analysisGrid").jqxTreeGrid('exportData', 'xls');
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

                <!-- Dates Filter Card -->
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Period</td>
                            <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                        </tr> 
                        <tr>
                            <td class="label-cell">To</td>
                            <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
                        </tr> 
                    </table>
                </div>

                <!-- Type & Days Filter Card -->
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Type</td>
                            <td>
                                <div class="type-flex-container">
                                    <select id="cmbchoose" name="cmbchoose" onchange="noOfDays();" value='<s:property value="cmbchoose"/>'>
                                        <option value="2">Monthly</option>
                                        <option value="3">Quarterly</option>
                                        <option value="4">Yearly</option>
                                        <option value="1">Custom Days</option>
                                    </select>
                                    
                                    <!-- Hidden by default, reveals based on noOfDays() logic -->
                                    <input type="hidden" id="txtnoofdays" name="txtnoofdays" placeholder="Days" onkeypress="javascript:return isNumber(event)" value='<s:property value="txtnoofdays"/>'/>
                                </div>
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
                <div id="analysisDiv">
                    <jsp:include page="accountAnalysisGrid.jsp"></jsp:include>
                </div>
            </div>

        </div>
    </div>
</div>
</body>
</html>