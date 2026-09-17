<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<s:head/>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
}

.modern-ui form label.error {
    color: red;
    font-weight: bold;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

/* Search Icon Wrapper */
.modern-ui .input-search-container {
    position: relative;
    display: flex;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
}
.modern-ui .magnifier-icon {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.modern-ui .magnifier-icon:hover { color: #2563eb; }

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 150px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }
</style>


<script type="text/javascript">

$(document).ready(function () {
    $('#clientwindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '53%' ,maxWidth: '50%' , title: 'Client Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#clientwindow').jqxWindow('close');
    $('#assetwindow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '58%' ,maxWidth: '50%' , title: 'Asset Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#assetwindow').jqxWindow('close');
       
    $("#date").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    $("#fromdate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    $("#todate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    
    setTimeout(function () {
        $("#date, #fromdate, #todate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#date, #fromdate, #todate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);
    
    $('#client').dblclick(function(){
        $('#clientwindow').jqxWindow('open');
        $('#clientwindow').jqxWindow('focus');
        clientSearchContent('masterClientSearch.jsp');
    });
});

function getClient(event){
     var x= event.keyCode;
     if(x==114){
         $('#clientwindow').jqxWindow('open');
         $('#clientwindow').jqxWindow('focus');
         clientSearchContent('masterClientSearch.jsp');
     }
}

function funSearchLoad(){
     changeContent('mainSearch.jsp', $('#window')); 
}

function clientSearchContent(url) {
      $.get(url).done(function (data) {
    $('#clientwindow').jqxWindow('setContent', data);
}); 
}

function assetSearchContent(url) {
      $.get(url).done(function (data) {
    $('#assetwindow').jqxWindow('setContent', data);
}); 
}

function detailSearchContent(url) {
      $.get(url).done(function (data) {
    $('#detailwindow').jqxWindow('setContent', data);
}); 
}

function funChkButton(){
    
}

function funReadOnly(){
     $('#date').jqxDateTimeInput({ disabled: true}); 
     $('#assetInvoiceGrid').jqxGrid({ disabled: true}); 
        $('#frmAssetInvoice input').attr('readonly', true );
         $('#frmAssetInvoice select').attr('disabled', true );
         $('#frmAssetInvoice textarea').attr('readonly', true );
         $('#btncalculate').prop('disabled',true);
}

function funRemoveReadOnly(){
     $('#date').jqxDateTimeInput({ disabled: false});
     $('#assetInvoiceGrid').jqxGrid({ disabled: false}); 
        $('#frmAssetInvoice input').attr('readonly', false );
         $('#frmAssetInvoice select').attr('disabled', false );
         $('#frmAssetInvoice textarea').attr('readonly', false );
         $('#btncalculate').prop('disabled',false);
         $('#client').prop('readonly',true);
         $('#clientname').prop('readonly',true);
         $('#docno').prop('readonly',true);
         $('#vocno').prop('readonly',true);
         if(document.getElementById("mode").value=='A'){
             $("#assetInvoiceGrid").jqxGrid('clear');
             $("#assetInvoiceGrid").jqxGrid('addrow', null, {});
         }
}

function funFocus(){
    document.getElementById("client").focus();
}

function setValues(){
    funSetlabel();
    
     if($('#msg').val()!=""){
           $.messager.alert('Message',$('#msg').val());
          }
     if ($('#hidcmbtype').val() != null) {
            $('#cmbtype').val($('#hidcmbtype').val());
        }
     document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";

    if(document.getElementById("docno").value!=""){
        document.getElementById("brchName").disabled=false;
        $('#assetInvoicediv').load('assetInvoiceGrid.jsp?docno='+document.getElementById("docno").value+'&branch='+document.getElementById("hidbranch").value+'&id=1');
    }
}

function funNotify(){
    if(document.getElementById("cmbtype").value==""){
        document.getElementById("errormsg").innerText="";
        document.getElementById("errormsg").innerText="Type is Mandatory";
        document.getElementById("cmbtype").focus();
        return 0;
    }
    var rows = $("#assetInvoiceGrid").jqxGrid('getrows');
    if(!((rows[0].assetno=="undefined") || (rows[0].assetno==null) || (rows[0].assetno==""))){
    
        var rowlength=0;
        for(var i=0 ; i < rows.length ; i++){
        
            newTextBox = $(document.createElement("input"))
            .attr("type", "dil")
            .attr("id", "test"+i)
            .attr("name", "test"+i)
            .attr("hidden", "true");
            if(rows[i].assetno!="" && rows[i].assetno!="undefined" && rows[i].assetno!=null){
                
        newTextBox.val(rows[i].assetno+"::"+rows[i].assetname+"::"+rows[i].salesprice+"::"+rows[i].dep_posted+"::"+rows[i].pur_value+"::"+rows[i].acc_dep+"::"+rows[i].cur_dep+"::"+rows[i].net_pl+"::"+rows[i].netbook);
        
        newTextBox.appendTo('form');
        rowlength++;
            }
        }
        
        $('#gridlength').val(rowlength);
    }
 return 1;  
}

function funCalculate(){
    var date=$('#date').jqxDateTimeInput('val');
    var rows=$('#assetInvoiceGrid').jqxGrid('getrows');
    var temp=0;
    for(var i=0;i<rows.length;i++){
        var asset=$("#assetInvoiceGrid").jqxGrid('getcellvalue',i,'assetid');
        var assetno=$("#assetInvoiceGrid").jqxGrid('getcellvalue',i,'assetno');
        temp=1;
        document.getElementById("errormsg").innerText="";
        if(asset=="" || asset=="undefined"){
            document.getElementById("errormsg").innerText="";
            document.getElementById("errormsg").innerText="Asset is Mandatory";
            $('#assetInvoiceGrid').jqxGrid('selectcell', i, 'assetid');
            return false;
        }
        var salesprice=$("#assetInvoiceGrid").jqxGrid('getcellvalue',i,'salesprice');
        if(salesprice=="" || salesprice=="undefined"){
            document.getElementById("errormsg").innerText="";
            document.getElementById("errormsg").innerText="Sales Price is Mandatory";
            $('#assetInvoiceGrid').jqxGrid('selectcell', i, 'salesprice');
            return false;
        }
        
        if(document.getElementById("errormsg").innerText=="" && asset!="" && asset!="undefined" && asset!=null){
            getCalData(assetno,salesprice,i,date);
        }
            
    }
    if(temp==0){
        document.getElementById("errormsg").innerText="";
        document.getElementById("errormsg").innerText="Please Select Asset";
        return false;
    }
}

function getCalData(asset,salesprice,row,date){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items=items.split("::");
            
            $('#assetInvoiceGrid').jqxGrid('setcellvalue', row, 'dep_posted',items[0]); 
            $('#assetInvoiceGrid').jqxGrid('setcellvalue', row, 'pur_value',items[1]);
            $('#assetInvoiceGrid').jqxGrid('setcellvalue', row, 'acc_dep',items[2]);
            $('#assetInvoiceGrid').jqxGrid('setcellvalue', row, 'cur_dep',items[3]);
            $('#assetInvoiceGrid').jqxGrid('setcellvalue', row, 'net_pl',items[4]);
            $('#assetInvoiceGrid').jqxGrid('setcellvalue', row, 'netbook',items[5]);
            document.getElementById("days").value=items[3];
        } else {
        }
    }
    x.open("GET", "getCalData.jsp?asset="+asset+"&salesprice="+salesprice+"&date="+date, true);
    x.send();
}

function funPrintBtn() {
       if(document.getElementById("docno").value=='' || document.getElementById("docno").value=='0'){
         $.messager.alert('Warning','Select a Document');
         return false;
    }
     var url=document.URL;
         var reurl=url.split("com/");  
         var win= window.open(reurl[0]+"com/fixedassets/assets/assetssalesinvoice/printAssetsInvoice.action?docno="+document.getElementById("docno").value+"&trno="+document.getElementById("trno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
         win.focus();      
     }

</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmAssetSalesInvoice" action="saveActionAssetSalesInvoice" autocomplete="off" >

    <jsp:include page="../../../../header.jsp" />

    <div class="modern-ui hidden-scrollbar">

        <!-- Panel 1: General Info -->
        <div class="middle-panel">
            <span class="middle-panel-title">General Info</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Date</label>
                <div style="width: 125px;">
                    <div id="date" name="date" value='<s:property value="date"/>'></div>
                </div>

                <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
                <input type="text" name="vocno" id="vocno" style="width:120px;" value='<s:property value="vocno"/>' tabindex="-1" readonly>
            </div>

            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Client</label>
                <div class="input-search-container" style="width: 125px;">
                    <input type="text" name="client" id="client" value='<s:property value="client"/>' readonly placeholder="Press F3" onkeydown="getClient(event);">
                    <svg class="magnifier-icon" onclick="$('#clientwindow').jqxWindow('open'); $('#clientwindow').jqxWindow('focus'); clientSearchContent('masterClientSearch.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                <input type="text" name="clientname" id="clientname" style="flex:1; max-width:350px;" value='<s:property value="clientname"/>' readonly>
            </div>

            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Description</label>
                <input type="text" name="description" id="description" style="flex:1;" value='<s:property value="description"/>'>

                <label class="lbl-right" style="width:80px; margin-left: 15px;">Type</label>
                <select name="cmbtype" id="cmbtype" style="width:150px;">
                    <option value="">--Select--</option>
                    <option value="S">Sale</option>
                    <option value="L">Total Loss</option>
                </select>

                <button class="myButton" type="button" name="btncalculate" id="btncalculate" onclick="funCalculate();" style="margin-left:15px;">Calculate</button>
            </div>
        </div>

        <!-- Panel 2: Invoice Details Grid -->
        <div class="middle-panel">
            <span class="middle-panel-title">Asset Invoice Details</span>
            <div id="assetInvoicediv" class="grid-container">
                <jsp:include page="assetInvoiceGrid.jsp"></jsp:include>
            </div>
        </div>

        <!-- Hidden Inputs for Backend Logic -->
        <div style="display:none;">
            <div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div>
            <div id="todate" name="todate" value='<s:property value="todate"/>'></div>
            <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
            <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
            <input type="hidden" name="hiddate" id="hiddate" value='<s:property value="hiddate"/>'>
            <input type="hidden" name="hidcmbtype" id="hidcmbtype" value='<s:property value="hidcmbtype"/>'>
            <input type="hidden" name="trno" id="trno" value='<s:property value="trno"/>'> 
            <input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
            <input type="hidden" name="clientacno" id="clientacno" value='<s:property value="clientacno"/>'>
            <input type="hidden" name="hidbranch" id="hidbranch" value='<s:property value="hidbranch"/>'>
            <input type="hidden" name="days" id="days" value='<s:property value="days"/>'>
            <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>' tabindex="-1" readonly>
        </div>

    </div>
</form>

<div id="clientwindow"><div></div></div>
<div id="assetwindow"><div></div></div>

</div>
</body>
</html>