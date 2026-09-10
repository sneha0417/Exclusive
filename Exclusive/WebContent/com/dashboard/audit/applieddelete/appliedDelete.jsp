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

/* ===== UNIFORM 24px INPUTS, SELECTS, TEXTAREA ===== */
input[type="text"], select,
.filter-table input[type="text"],
.filter-table select, textarea {
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
input[readonly], input:disabled, textarea[readonly], select:disabled,
.filter-table input[readonly], .filter-table input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
    cursor: not-allowed;
}

/* jqx date/time containers */
div[id^="date"] {
    width: 100%;
}

/* ===== BUTTONS ===== */
.btn-danger {
    width: 100%;
    height: 30px;            
    padding: 0 12px;         
    background: #ef4444; /* Red color for delete action */
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
.btn-danger:disabled { background: #fca5a5; cursor: not-allowed; }

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

/* ===== GRID CARDS ===== */
.grid-section {
    background: #fff;
    border: 1px solid #e1e8ed;
    border-radius: 8px;
    margin-bottom: 20px;
    box-shadow: 0 1px 3px rgba(0,0,0,.03);
    overflow: hidden;
}

.grid-body {
    padding: 15px;
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
    $("#date").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#accountDetailsWindow').jqxWindow('close');
    
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
     
    $('#date').jqxDateTimeInput({disabled: true});
    $('#txtreason').attr("readonly", true);
    $('#btndelete').attr("disabled", true);
    $("#appliedDetailsGrid").jqxGrid({ disabled: true}); 
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

function funreload(event){
    var branchval = document.getElementById("cmbbranch").value;
    var atype = $('#cmbtype').val();
    var accountno = $('#txtdocno').val();
    
    $('#date').val(new Date());
    $('#txtreason').val('');
    $('#txttrno').val('');
    $('#txtoutamount').val('');
    $('#txtdtype').val('');
    $('#txtbranchid').val('');
    $('#applyinfo').val(' ');
    
    $("#appliedDetailsGrid").jqxGrid({ disabled: true});
    $("#appliedDetailsGrid").jqxGrid('clear'); 
    $('#date').jqxDateTimeInput({disabled: true});
    $('#txtreason').attr("readonly",true);
    $('#btndelete').attr("disabled",true);
         
    if(accountno == ''){
        $.messager.alert('Message','Account is Mandatory.','warning');
        return 0;
    }
   
    $("#overlay, #PleaseWait").show();
    $("#appliedDiv").load("appliedGrid.jsp?branchval="+branchval+'&atype='+atype+'&accountno='+accountno);
}

function funDelete(event){
    var trno = $('#txttrno').val();
    var accountno = $('#txtdocno').val();
    var outamount = $('#txtoutamount').val();
    var dtype = $('#txtdtype').val();
    var branchid = $('#txtbranchid').val();
    var date = $('#date').val();
    var reason = $('#txtreason').val();
    
    if(reason == ''){
        $.messager.alert('Message','Please Enter the Reason.','warning');
        return 0;
    }
    
    $.messager.confirm('Message', 'Do you want to delete?', function(r){
        if(r == false) {
            return false; 
        } else {
            saveGridData(trno,accountno,outamount,dtype,branchid,date,reason); 
        }
    });
}
    
function saveGridData(trno,accountno,outamount,dtype,branchid,date,reason){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function(){
        if (x.readyState == 4 && x.status == 200){
            var items = x.responseText;
            $('#txttrno').val(' ');
            $('#txtoutamount').val(' ');
            $('#txtdtype').val(' ');
            $('#txtbranchid').val(' ');
            $('#date').val(new Date());
            $('#txtreason').val(' ');
            $('#applyinfo').val(' ');
            
            $.messager.alert('Message', '  Record Successfully Deleted ', function(r){
            });
            funreload(event); 
        }
    }
        
    x.open("GET","saveData.jsp?trno="+trno+"&accountno="+accountno+"&outamount="+outamount+"&dtype="+dtype+"&branchid="+branchid+"&date="+date+"&reason="+reason,true);
    x.send();
}

function clearAccountInfo(){
    $('#txtdocno').val('');
    $('#txtaccid').val('');
    $('#txtaccname').val('');
    $('#txttrno').val(' ');
    $('#txtoutamount').val(' ');
    $('#txtdtype').val(' ');
    $('#txtbranchid').val(' ');
    $('#date').val(new Date());
    $('#txtreason').val(' ');
    $('#applyinfo').val(' ');
    
    $("#appliedDetailsGrid").jqxGrid({ disabled: true});
    $("#appliedDetailsGrid").jqxGrid('clear'); 
    $("#appliedDelete").jqxGrid('clear');
    
    $('#date').jqxDateTimeInput({disabled: true});
    $('#txtreason').attr("readonly",true);
    $('#btndelete').attr("disabled",true);
    
    if (document.getElementById("txtaccid").value == "") {
        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
    }
}

function getAccTypeFrom(event){
    var x = event.keyCode;
    if(x == 114){
        accountsSearchContent('accountsDetailsSearch.jsp');
    }
}

function funSearchdblclick(){
    $('#txtaccid').dblclick(function(){
        accountsSearchContent('accountsDetailsSearch.jsp');
    });
}
</script>
</head>

<body onload="getBranch();">
<div id="mainBG">
    <div class="master-container">

        <!-- LEFT SIDEBAR -->
        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">

                <!-- Account Selection Card -->
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Type</td>
                            <td>
                                <select id="cmbtype" name="cmbtype" onchange="clearAccountInfo();" value='<s:property value="cmbtype"/>'>
                                    <option value="AR">AR</option>
                                    <option value="AP">AP</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Account</td>
                            <td>
                                <input type="text" id="txtaccid" name="txtaccid" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' ondblclick="funSearchdblclick();" onkeydown="getAccTypeFrom(event);"/>
                            </td>
                        </tr> 
                        <tr>
                            <td class="label-cell"></td>
                            <td>
                                <input type="text" id="txtaccname" name="txtaccname" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1"/>
                                <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
                            </td>
                        </tr> 
                    </table>
                </div>

                <!-- Application Info Card -->
                <div class="filter-card">
                    <textarea id="applyinfo" name="applyinfo" readonly="readonly" placeholder="Application Info..."><s:property value="applyinfo" ></s:property></textarea>
                </div>

                <!-- Deletion Action Card -->
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Date</td>
                            <td><div id="date" name="date" value='<s:property value="date"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Reason</td>
                            <td><input type="text" id="txtreason" name="txtreason" value='<s:property value="txtreason"/>'/></td>
                        </tr>
                    </table>
                </div>

                <!-- Actions -->
                <div class="action-buttons">
                    <button type="button" id="btndelete" name="btndelete" class="btn-danger" onclick="funDelete(event);">Delete</button>
                </div>

                <!-- Hidden Inputs -->
                <div style="display:none;">
                    <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
                    <input type="hidden" id="txtoutamount" name="txtoutamount" value='<s:property value="txtoutamount"/>'/>
                    <input type="hidden" id="txtdtype" name="txtdtype" value='<s:property value="txtdtype"/>'/>
                    <input type="hidden" id="txtbranchid" name="txtbranchid" value='<s:property value="txtbranchid"/>'/>
                </div>

            </div>
        </div>

        <!-- MAIN CONTENT AREA -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                
                <!-- Applied Grid Section -->
                <div class="grid-section">
                    <div class="grid-body" id="appliedDiv">
                        <jsp:include page="appliedGrid.jsp"></jsp:include>
                    </div>
                </div>

                <!-- Detail Grid Section -->
                <div class="grid-section">
                    <div class="grid-body" id="detailDiv">
                        <jsp:include page="appliedDetailGrid.jsp"></jsp:include>
                    </div>
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