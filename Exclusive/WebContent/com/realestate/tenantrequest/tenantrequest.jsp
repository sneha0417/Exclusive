<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>
<%@page import="com.realestate.propertyrelated.propertyrelatedmaster.ClsPropertyRelatedMasterDAO"%>
<%
String contextPath=request.getContextPath();
ClsPropertyRelatedMasterDAO DAO= new ClsPropertyRelatedMasterDAO();
%> 

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
    display: inline-flex;
    align-items: center;
    justify-content: center;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

.bicon {
    width: 24px;
    height: 24px;
    border: none;
    background-color: transparent;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: 0;
}
.bicon img {
    max-width: 100%;
    max-height: 100%;
}

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
    
    /* Formatted jqxDateTimeInput heights to match modern UI 24px */
    $("#jqxDate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});     
    $("#rtime").jqxDateTimeInput({ width: '80px', height: 24, formatString:'HH:mm', showCalendarButton: false, theme: 'energyblue'});
    $("#rtime").val(new Date());
    
    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#jqxDate, #rtime").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#jqxDate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);
    
    $('#txttenant').dblclick(function(){
        refsearchContent2('tmainsearch.jsp');
    });     
    $('#txtproperty').dblclick(function(){
        refsearchContent1('pmainsearch.jsp');
    }); 
    
    $('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#refnosearchwindow').jqxWindow('close');  
    
    $('#refnosearchwindow1').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#refnosearchwindow1').jqxWindow('close'); 
    
    $('#vendoracwindow').jqxWindow({ width: '30%', height: '63%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Insurance Type Search' , position: { x: 150, y: 50 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#vendoracwindow').jqxWindow('close');
    
    $('#jobsearchwindow').jqxWindow({ width: '30%', height: '63%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Insurance Type Search' , position: { x: 150, y: 50 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#jobsearchwindow').jqxWindow('close');
    
    $('#sourcesearchwndow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Source Search' ,position: { x: 500, y: 120 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#sourcesearchwndow').jqxWindow('close'); 
    
    $('#txtsource').dblclick(function(){
        $('#sourcesearchwndow').jqxWindow('open');
        sourceinfoSearchContent('searchSource.jsp?', $('#sourcesearchwndow'));  
    });
});      

function getSource(event){
    var x= event.keyCode;
    if(x==114){
        $('#sourcesearchwndow').jqxWindow('open');
        sourceinfoSearchContent('searchSource.jsp?', $('#sourcesearchwndow'));   
    }
}        

function sourceinfoSearchContent(url) {
    $.get(url).done(function (data) {
        $('#sourcesearchwndow').jqxWindow('open');
        $('#sourcesearchwndow').jqxWindow('setContent', data);
    }); 
}

function getvendorac(rowindex){   
    $('#vendoracwindow').jqxWindow('open');
    vendorSearchContent('vendorSearch.jsp?rowindex='+rowindex);     
}

function funClear(){
    $('#txttenantdocno').val('');
    $('#txttenant').val('');
} 

function vendorSearchContent(url) { 
    $.get(url).done(function (data) { 
        $('#vendoracwindow').jqxWindow('setContent', data); 
    }); 
}
    
function getjob(rowindex){   
    $('#jobsearchwindow').jqxWindow('open');
    jobSearchContent('jobSearch.jsp?rowindex='+rowindex);   
} 
                
function jobSearchContent(url) { 
    $.get(url).done(function (data) { 
        $('#jobsearchwindow').jqxWindow('setContent', data); 
    }); 
}
    
function getTenant(event){
    var x= event.keyCode;
    if(x==114){
        refsearchContent1('tmainsearch.jsp');
    }
}

function refsearchContent2(url) {
    $('#refnosearchwindow1').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#refnosearchwindow1').jqxWindow('setContent', data);
    }); 
}   

function getProperty(event){
    var x= event.keyCode;
    if(x==114){
        refsearchContent1('pmainsearch.jsp');
    }
}

function refsearchContent1(url) {
    $('#refnosearchwindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#refnosearchwindow').jqxWindow('setContent', data);
    }); 
}   
    
function getGroup() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var groupItems = items[0].split(",");
            var groupIdItems = items[1].split(",");
            var optionsgroup = '<option value="">--Select--</option>';
            for (var i = 0; i < groupItems.length; i++) {
                optionsgroup += '<option value="' + groupIdItems[i] + '">' + groupItems[i] + '</option>';
            }
            $("select#cmbnation").html(optionsgroup);
            if ($('#hidcmbnation').val() != null) {
                $('#cmbnation').val($('#hidcmbnation').val());
            }
        }
    }
    x.open("GET", "getGroup.jsp", true);
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

function getType() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var typeItems = items[0].split(",");
            var typeIdItems = items[1].split(",");
            var optionstype ;
            for (var i = 0; i < typeItems.length; i++) {
                optionstype += '<option value="' + typeIdItems[i] + '">' + typeItems[i] + '</option>';
            }
            $("select#cmbtype").html(optionstype);
            if ($('#hidcmbtype').val() != null) {
                $('#cmbtype').val($('#hidcmbtype').val());
            }
        }
    }
    x.open("GET", "getType.jsp", true);
    x.send();
}

function getTypeAllowed(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            if(parseInt(items)==1) {
                $('#typeallowed').val(1);
                document.getElementById("lbltypeentity").style.display = 'inline-block';
                document.getElementById("lbltrnnoentity").style.display = 'none';
                $('#cmbtype').attr('hidden', false);
                $('#txtregisteredtrnno').attr('hidden', true);
            } else {
                $('#typeallowed').val(0);
                document.getElementById("lbltypeentity").style.display = 'none';
                document.getElementById("lbltrnnoentity").style.display = 'none';
                $('#cmbtype').attr('hidden', true);
                $('#txtregisteredtrnno').attr('hidden', true);
            }
        }
    }
    x.open("GET", "getTypeAllowed.jsp", true);
    x.send();
}

function getCategoryAccountGroup(a) {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            $('#hidcmbaccgroup').val(items);
            if ($('#hidcmbaccgroup').val() != null || $('#hidcmbaccgroup').val() != "") {
                $('#cmbaccgroup').val($('#hidcmbaccgroup').val());
            }
        }
    }
    x.open("GET", "getCategoryAccountGroup.jsp?category="+a, true);
    x.send();
} 
      
function getCurrencyIds(){
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('####');
            var curidItems=items[0];
            var curcodeItems=items[1];
            var multiItems=items[2];
            var optionscurr = '';
            
            if(curcodeItems.indexOf(",")>=0){
                var currencyid=curidItems.split(",");
                var currencycode=curcodeItems.split(",");
                multiItems.split(",");
           
                for ( var i = 0; i < currencycode.length; i++) {
                   optionscurr += '<option value="' + currencyid[i] + '">' + currencycode[i] + '</option>';
                }
                $("select#cmbcurrency").html(optionscurr);
                if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
                     $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
                } 
            } else {
               optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
                 $("select#cmbcurrency").html(optionscurr);
                 if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
                     $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
                 }
            }
        }
    }
    x.open("GET", "getCurrencyId.jsp",true);
    x.send();
}
   
function getVendorAlreadyExists(vendorname,docno,mode){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            if(parseInt(items)==1){
                 document.getElementById("errormsg").innerText="Vendor Already Exists.";
                 return 0;
             }else{
                $('#cmbaccgroup').attr('disabled', false);
                $("#frmVendorDetails").submit();
             }
        }
    }
    x.open("GET", "getVendorAlreadyExists.jsp?vendorname="+vendorname+"&docno="+docno+"&mode="+mode, true);
    x.send();
}

function getMobileNoAlreadyExists(mobileno,docno,mode){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            if(parseInt(items)==1){
                 $.messager.alert('Message','Mobile No. Already Exists.','warning');
                 return 0;
             }
        }
    }
    x.open("GET", "getMobileNoAlreadyExists.jsp?mobileno="+mobileno+"&docno="+docno+"&mode="+mode, true);
    x.send();
}

function typecheck() {
     if($('#cmbtype').val()=='1'){
         document.getElementById("lbltrnnoentity").style.display = 'inline-block';
         if($('#mode').val()!='view'){
            $('#txtregisteredtrnno').val('');
         }
         $('#txtregisteredtrnno').attr('hidden', false);
     }
     else{
         document.getElementById("lbltrnnoentity").style.display = 'none';
         if($('#mode').val()!='view'){
                $('#txtregisteredtrnno').val('');
         }
         $('#txtregisteredtrnno').attr('hidden', true);
     }
 } 
  
 function funReadOnly(){
     $('#frmTenantRequest input').attr('readonly', true );
     $('#frmTenantRequest select').attr('disabled', true); 
     $('#jqxDate').jqxDateTimeInput({disabled: true});
    
     $('#txtproperty').attr('disabled', true); 
     $('#txttenant').attr('disabled', true); 
}
    
 function funRemoveReadOnly(){
        $('#frmTenantRequest input').attr('readonly', false );
        $('#frmTenantRequest select').attr('disabled', false); 
        $('#jqxDate').jqxDateTimeInput({disabled: false}); 
        $('#vdocno').attr('readonly', true); 
        if ($("#mode").val() == "A") {
            $('#jqxDate').val(new Date()); 
            $("#jqxRequestGrid").jqxGrid('clear');  
        }
        $("#jqxRequestGrid").jqxGrid({disabled : false});
        $('#txtproperty').attr('disabled', false); 
        $('#txttenant').attr('disabled', false); 
        $('#txtrbsmnt').attr('readonly', false);   
        
 }

function funNotify(){   
     docno=document.getElementById("docno").value;
     mode=document.getElementById("mode").value;
    
        var rqrows = $("#jqxRequestGrid").jqxGrid('getrows');
        var rqstlength = 0;
        for (var i = 0; i < rqrows.length; i++) {
            var chks = rqrows[i].job;
            if (typeof (chks) != "undefined" && typeof (chks) != "NaN" && chks != "") {
                newTextBox = $(document.createElement("input"))
                .attr("type","dil")
                        .attr("id", "txtrqst" + rqstlength)
                        .attr("name", "txtrqst" + rqstlength)
                        .attr("hidden","true");
                rqstlength = rqstlength + 1;
                newTextBox.val(rqrows[i].job_docno+"::"+rqrows[i].vendor_acno+"::"+rqrows[i].priority+"::"+rqrows[i].est_cost+"::"+rqrows[i].notify_owner+"::"+rqrows[i].comments+"::"+rqrows[i].doc_no);
                newTextBox.appendTo('form');
            }
        }
        
        $('#txtrequestgridlength').val(rqstlength); 
    return 1;
} 

 function funSearchLoad(){
        changeContent('requestSearch.jsp'); 
     }
    
 function funFocus(){
        $('#jqxDate').jqxDateTimeInput('focus');            
    }

 function setValues(){
     if($('#hidjqxDate').val()){ 
         $("#jqxDate").jqxDateTimeInput('val', $('#hidjqxDate').val());      
      }
     if($('#msg').val()!=""){
           $.messager.alert('Message',$('#msg').val());
          }
     if(document.getElementById("docno").value>0){
         if(document.getElementById("hidchkrbsmnt").value=="1"){                 
                  document.getElementById("txtrbsmnt").checked = true;    
             }
         } 
     funSetlabel();
     editstatus();
      $('#requestDiv').load("requestGrid.jsp?vocno=" + $("#vdocno").val()+"&brhid="+$("#hidbrhid").val()+"&id="+1);              
    }

    function isNumber(evt,id) {
          var iKeyCode = (evt.which) ? evt.which : evt.keyCode
            if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
             {
                 $('#valmsg').html('Enter Numbers Only');
                 $('#validation_modal').modal('show');
                 $("#"+id+"").focus();
                 return false;
                
             }
            
            return true;
        }

    function ValidateNo(event,id) {
        var phoneNo = document.getElementById('txtmobpho');
        if(phoneNo.value.length == 0){
        }
        else if (phoneNo.value.length < 12 || phoneNo.value.length > 12 || phoneNo.value.length == 0) {
             $('#valmsg').html('Enter 12 Digit Mobile Number');
             $('#validation_modal').modal('show');
            return false;
        
        }
        return true;
        }

    function  chkval(){
         if(document.getElementById("txtrbsmnt").checked==true)
             {
             document.getElementById("hidchkrbsmnt").value=1;
             }
         else
             {
             document.getElementById("hidchkrbsmnt").value=0;
             }      
     }

     function editstatus(){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();  
                    
                    if(parseInt(items)>0)
                        {
                         $("#btnEdit").attr('disabled', true );   
                         $('#btnDelete').attr('disabled', true );
                        }
                    else
                        {
                         $("#btnEdit").attr('disabled', false );           
                         $('#btnDelete').attr('disabled', false );
                        }
                    
                } else {  
                }  
            }
            x.open("GET", "getEditStat.jsp?vocno=" + $("#vdocno").val()+"&brhid="+$("#hidbrhid").val(), true); 
            x.send();
        }   
</script>

</head>
<body onload="setValues();editstatus();">
<div id="mainBG" class="homeContent" data-type="background">
    <form id="frmTenantRequest" action="saveTenantrequest" method="post" autocomplete="off">
        <jsp:include page="../../../header.jsp"></jsp:include>
        
        <div class="modern-ui hidden-scrollbar">

            <!-- General Info Panel -->
            <div class="middle-panel">
                <span class="middle-panel-title">General Info</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Doc No</label>
                    <input type="text" id="vdocno" name="vdocno" style="width:120px;" tabindex="-1" value='<s:property value="vdocno"/>' readonly/>
                    <input type="hidden" id="docno" name="docno" value='<s:property value="vdocno"/>' />
                    
                    <label class="lbl-right" style="width:80px; margin-left: 15px;">Date</label>
                    <div style="width: 120px;">
                        <div id="jqxDate" name="jqxDate" value='<s:property value="jqxDate"/>'></div>
                        <input type="hidden" id="hidjqxDate" name="hidjqxDate" value='<s:property value="hidjqxDate"/>' /> 
                        <input type="hidden" id="vocno" name="vocno" tabindex="-1" value='<s:property value="vocno"/>' />
                    </div>

                    <label class="lbl-right" style="width:80px; margin-left: 15px;">Time</label>
                    <div style="width: 80px;">                                
                        <div id="rtime" name="rtime" value='<s:property value="rtime"/>'></div>
                    </div>

                    <div style="display:flex; align-items:center; gap:4px; margin-left:15px;">
                        <input type="checkbox" id="txtrbsmnt" name="txtrbsmnt" onchange="chkval();" value='<s:property value="txtrbsmnt"/>' style="margin:0; width:auto; height:auto!important;"/>
                        <label class="lbl-right" style="margin:0;">Reimbursement</label>
                        <input type="hidden" id="hidchkrbsmnt" name="hidchkrbsmnt" value='<s:property value="hidchkrbsmnt"/>' />
                    </div>
                    
                    <label class="lbl-right" style="width:80px; margin-left: auto;">Source</label>
                    <div class="input-search-container" style="width: 150px;">
                        <input type="text" id="txtsource" name="txtsource" tabindex="-1" value='<s:property value="txtsource"/>' readonly placeholder="Press F3" onkeydown="getSource(event);"/> 
                        <svg class="magnifier-icon" onclick="$('#sourcesearchwndow').jqxWindow('open'); sourceinfoSearchContent('searchSource.jsp?', $('#sourcesearchwndow'));" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="hidden" id="sourceid" name="sourceid" tabindex="-1" value='<s:property value="sourceid"/>' />
                </div>
            </div>

            <!-- Property & Tenant Selection Panel -->
            <div class="middle-panel">
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Property</label>
                    <div class="input-search-container" style="flex:1; max-width:400px;">
                        <input type="text" id="txtproperty" name="txtproperty" placeholder="Press F3" value='<s:property value="txtproperty"/>' onkeydown="getProperty(event);" /> 
                        <svg class="magnifier-icon" onclick="refsearchContent1('pmainsearch.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="hidden" id="txtpropertydocno" name="txtpropertydocno" value='<s:property value="txtpropertydocno"/>' />
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:80px;">Tenant</label>
                    <div class="input-search-container" style="flex:1; max-width:400px;">
                        <input type="text" id="txttenant" name="txttenant" placeholder="Press F3" value='<s:property value="txttenant"/>' onkeydown="getTenant(event);" /> 
                        <svg class="magnifier-icon" onclick="refsearchContent2('tmainsearch.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <button type="button" class="bicon" id="clear" title="clear" onclick="funClear()" style="margin-left: 10px;"> 
                        <img alt="clear" src="<%=contextPath%>/icons/clear.png">
                    </button> 
                    <input type="hidden" id="txttenantdocno" name="txttenantdocno" value='<s:property value="txttenantdocno"/>' />
                </div>
            </div>

            <!-- Request Details Grid Panel -->
            <div class="middle-panel">
                <span class="middle-panel-title">Request Details</span>
                <div id="requestDiv" class="grid-container" style="border:none;">
                    <jsp:include page="requestGrid.jsp"></jsp:include>
                </div>
            </div>

            <!-- Hidden Elements Container -->
            <div style="display:none;">
                <input type="hidden" id="mode" name="mode" /> 
                <input type="hidden" id="hidbrhid" name="hidbrhid" value='<s:property value="hidbrhid"/>'/>    
                <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>' />
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' /> 
                <input type="hidden" id="txtmobilevalidation" name="txtmobilevalidation" value='<s:property value="txtmobilevalidation"/>' /> 
                <input type="hidden" id="typeallowed" name="typeallowed" value='<s:property value="typeallowed"/>' />
                <input type="hidden" id="txtrequestgridlength" name="txtrequestgridlength" value='<s:property value="txtrequestgridlength"/>' />
            </div>
            
        </div>
    </form>  

    <!-- Search Windows -->
    <div id="sourcesearchwndow"><div></div></div>
    <div id="refnosearchwindow1"><div></div></div>
    <div id="refnosearchwindow"><div></div></div>
    <div id="jobsearchwindow"><div></div></div>
    <div id="vendoracwindow"><div></div></div>

</div>
</body>
</html>