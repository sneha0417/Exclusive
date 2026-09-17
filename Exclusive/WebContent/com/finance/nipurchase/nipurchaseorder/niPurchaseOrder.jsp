<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
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

/* Error label styling */
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
    
     /* Date */  
    $("#nipurchaseorderdate").jqxDateTimeInput({  width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    $("#deliverydate").jqxDateTimeInput({  width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    
    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#nipurchaseorderdate, #deliverydate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#nipurchaseorderdate, #deliverydate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);
    
    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#accountSearchwindow').jqxWindow('close');
      
      
    $('#typesearchwindow').jqxWindow({
        width : '25%',
        height : '58%',
        maxHeight : '70%',
        maxWidth : '45%',
        title : ' Search',
        position : {
            x : 700,
            y : 87
        },
        theme : 'energyblue',
        showCloseButton : true,
        keyboardCloseKey : 27
    });
    $('#typesearchwindow').jqxWindow('close');
    
    
    $('#txtproducttype').dblclick(function(){
        typeFormSearchContent('typeFormSearchGrid.jsp'); 
    }); 
    
    $('#puraccid').dblclick(function(){
        if($('#mode').val()!= "view") {
            $('#accountSearchwindow').jqxWindow('open');
            accountSearchContent('accountsDetailsFromGrid.jsp?');
        }
    });   
    
  
});

function getaccountdetails(event){
     var x= event.keyCode;
    if($('#mode').val()!="view") {
     if(x==114){
      $('#accountSearchwindow').jqxWindow('open');
      accountSearchContent('accountsDetailsFromGrid.jsp?');    }
     else{
         }
        }
     }  

function accountSearchContent(url) {
          $.get(url).done(function (data) {
        $('#accountSearchwindow').jqxWindow('setContent', data);
    }); 
}

function typeFormSearchContent(url) {
    $('#typesearchwindow').jqxWindow('open');
    $.get(url).done(function(data) {
        $('#typesearchwindow').jqxWindow('setContent', data);
        $('#typesearchwindow').jqxWindow('bringToFront');
    });
}

function getProdType(event){
     var x= event.keyCode;
     if(x==114){
         typeFormSearchContent('typeFormSearchGrid.jsp');    }
     else{
         }
}

function funReset(){
    //$('#frmNipurchaseOrder')[0].reset(); 
}

function funReadOnly(){
    $('#frmNipurchaseOrder input').attr('readonly', true );
    $('#frmNipurchaseOrder select').attr('disabled', true );
    $('#nipurchaseorderdate').jqxDateTimeInput({ disabled: true});
    $('#deliverydate').jqxDateTimeInput({ disabled: true});
    $("#descdetailsGrid").jqxGrid({ disabled: true});
    $('#cmbcurr').attr('disabled', true);
    $('#acctype').attr('disabled', true);
    $('#txtproducttype').attr('disabled', true);
}

function funRemoveReadOnly(){
     funinterstate();
    $('#frmNipurchaseOrder input').attr('readonly', false );
    $('#txtproducttype').attr('readonly', true);
    $('#frmNipurchaseOrder select').attr('disabled', false );
    $('#currate').attr('readonly', true);
    $('#puraccid').attr('readonly', true);
    $('#puraccname').attr('readonly', true);
      
    $('#nipurchaseorderdate').jqxDateTimeInput({ disabled: false});
    $('#deliverydate').jqxDateTimeInput({ disabled: false});

    $('#cmbcurr').attr('disabled', false);
    $('#acctype').attr('disabled', false);
    
    $('#docno').attr('readonly', true);
    $("#descdetailsGrid").jqxGrid({ disabled: false});

    if ($("#mode").val() == "A") {
        $('#nipurchaseorderdate').val(new Date());
        $('#deliverydate').val(new Date());
         $("#descdetailsGrid").jqxGrid('clear');
            $("#descdetailsGrid").jqxGrid('addrow', null, {});
             $('#txtproducttype').attr('disabled', true);
              document.getElementById("validates").value=0;
   }
    
      if($('#mode').val()=='E')
       {
       $("#descdetailsGrid").jqxGrid('addrow', null, {});
       }
    getCurrencyIds();
}

function funFocus(){
    $('#nipurchaseorderdate').jqxDateTimeInput('focus');            
}

function funNotify(){   
    var purid= document.getElementById("puraccid").value;

    if(purid=="")
        {
         document.getElementById("errormsg").innerText=" Select An Account";
         return 0;
           }
    else
           {
           document.getElementById("errormsg").innerText="";
           }
           
    if(parseInt(document.getElementById("validates").value)==1)
        {
        var txtproducttype= document.getElementById('txtproducttype').value;
         if(txtproducttype=="")
         {
             document.getElementById("errormsg").innerText=" Bill Type Is Required "; 
             document.getElementById('txtproducttype').focus();
             return 0;
         }
        }
       
    var refval= document.getElementById("nettotal").value;

    if(refval=="")
        {
         document.getElementById("errormsg").innerText="Net Amount Empty";
         return 0;
           }
    else
           {
           document.getElementById("errormsg").innerText="";
           }

         var rows = $("#descdetailsGrid").jqxGrid('getrows');
        $('#descgridlenght').val(rows.length);
       for(var i=0 ; i < rows.length ; i++){
        newTextBox = $(document.createElement("input"))
           .attr("type", "dil")
           .attr("id", "desctest"+i)
           .attr("name", "desctest"+i)
           .attr("hidden", "true"); 
       
       newTextBox.val(rows[i].srno+"::"+rows[i].qty+" :: "+rows[i].description+" :: "
               +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].nuprice+" :: "+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].taxamount+"::");
    
       newTextBox.appendTo('form');
       }   
    
    return 1;
} 

function funChkButton() {}

function funSearchLoad(){
    changeContent('mainsearch.jsp'); 
}

function getCurrencyIds(){
       var x=new XMLHttpRequest();
       x.onreadystatechange=function(){
       if (x.readyState==4 && x.status==200)
        {
          items= x.responseText;
         
          items=items.trim().split('####');
               var curidItems=items[0];
               var curcodeItems=items[1];
               var currateItems=items[2];
               var multiItems=items[3];
               var optionscurr = '';
               
               if(curcodeItems.indexOf(",")>=0){
                   curidItems=curidItems.split(",");
                curcodeItems=curcodeItems.split(",");
                currateItems=currateItems.split(",");
               
                for ( var i = 0; i < curcodeItems.length; i++) {
               optionscurr += '<option value="' + curidItems[i] + '">' + curcodeItems[i] + '</option>';
               }
                $("select#cmbcurr").html(optionscurr);
                funRoundRate(currateItems,"currate");
            }
       
              else
          {
               optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
               $("select#cmbcurr").html(optionscurr);
               
           
              funRoundRate(currateItems,"currate");
          
          
              $('#currate').attr('readonly', true);
           
          }
        }
           }
       x.open("GET","getCurrencyId.jsp?date="+document.getElementById("nipurchaseorderdate").value ,true);
        x.send();
            
          
        }
       
       function getRatevalue(angel)
       {
       var x=new XMLHttpRequest();
       x.onreadystatechange=function(){
       if (x.readyState==4 && x.status==200)
        {
          var items= x.responseText;
          
          
        /*      $('#currate').val(items) ; */
             funRoundRate(items,"currate"); 
            }
              else
          {
          }
           }
       x.open("GET","getRateTo.jsp?curr="+a,true);
        x.send();
            
          
        }
       
       
       function combochange()
       {
           if($('#cmbcurrval').val()!="")
              {
              
              
              $('#cmbcurr').val($('#cmbcurrval').val());
              }
           if($('#acctypeval').val()!="")
              {
              
              
              $('#acctype').val($('#acctypeval').val());
              }
            
       }

       function setValues() {
            if($('#hidnipurchaseorderdate').val()){
                $("#nipurchaseorderdate").jqxDateTimeInput('val', $('#hidnipurchaseorderdate').val());
            }
            
            if($('#hiddeliverydate').val()){
                $("#deliverydate").jqxDateTimeInput('val', $('#hiddeliverydate').val());
            }
            var dis=document.getElementById("masterdoc_no").value;
            if(dis>0)
                {     
             var indexval1 = document.getElementById("masterdoc_no").value;   
                
                            
                        
                         $("#descdetail").load("descgridDetails.jsp?nipurdoc="+indexval1);
                        
                 } 

                 if($('#msg').val()!=""){
                   $.messager.alert('Message',$('#msg').val());
                  } 
                
            combochange();
            document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
            funSetlabel();
        } 
        
       function funPrintBtn(){
           if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
          
           var url=document.URL;

        var reurl=url.split("saveActionNipurOrder");
        
        $("#docno").prop("disabled", false);                
        var brhid=<%= session.getAttribute("BRANCHID").toString()%>
            var dtype=$('#formdetailcode').val();
            
  
    var win= window.open(reurl[0]+"printniphOrder?docno="+document.getElementById("masterdoc_no").value+"&brhid="+brhid+"&dtype="+dtype,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
     
    win.focus();
           } 
          
           else {
                      $.messager.alert('Message','Select a Document....!','warning');
                      return false;
                     }
            
        }
        
    $(function(){
        $('#frmNipurchaseOrder').validate({
                rules: { 
              
                    delterms:{maxlength:200},
                    purdesc:{maxlength:200},
                    payterms:{maxlength:200},
                    puraccid:{required:true}
                 },
                 messages: {
                     delterms: {maxlength:"  Max 200 chars"},
                     purdesc: {maxlength:"  Max 200 chars"},
                     payterms: {maxlength:"  Max 200 chars"},
                     puraccid: {required:" *"}
                 }
        });});
</script>
</head>
<body onLoad="getCurrencyIds();setValues();funinterstate();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmNipurchaseOrder" action="saveActionNipurOrder" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" />  

<div class='modern-ui hidden-scrollbar'>

    <div class="middle-panel">
        <span class="middle-panel-title">General Info</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="nipurchaseorderdate" name="nipurchaseorderdate" value='<s:property value="nipurchaseorderdate"/>'></div>
                <input type="hidden" name="hidnipurchaseorderdate" id="hidnipurchaseorderdate" value='<s:property value="hidnipurchaseorderdate"/>'>
            </div>
            
            <label class="lbl-right" style="width:80px; margin-left: 15px;">Ref No</label>
            <input type="text" name="refno" id="refno" style="width:140px;" value='<s:property value="refno"/>'>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
            <input type="text" name="docno" id="docno" style="width:120px;" tabindex="-1" value='<s:property value="docno"/>' readonly="readonly">
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Vendor Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Vendor</label>
            <input type="hidden" name="acctype" id="acctype" value='<s:property value="acctype"/>'>
            
            <div class="input-search-container" style="width: 120px;">
                <input type="text" name="puraccid" id="puraccid" placeholder="Press F3" value='<s:property value="puraccid"/>' onKeyDown="getaccountdetails(event);" />
                <svg class="magnifier-icon" onclick="if($('#mode').val()!='view') { $('#accountSearchwindow').jqxWindow('open'); accountSearchContent('accountsDetailsFromGrid.jsp?'); }" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <input type="text" id="puraccname" name="puraccname" style="flex:1; max-width:350px;" value='<s:property value="puraccname"/>' tabindex="-1" readonly>
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Curr</label>
            <select name="cmbcurr" id="cmbcurr" style="width:100px;" value='<s:property value="cmbcurr"/>' onload="getRatevalue(this.value);">
                <option value="-1">--Select--</option>
            </select>
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Rate</label>
            <input type="text" name="currate" id="currate" style="width:100px; text-align:right;" value='<s:property value="currate"/>'>
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Terms & Description</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Del Date</label>
            <div style="width: 125px;">
                <div id="deliverydate" name="deliverydate" value='<s:property value="deliverydate"/>'></div>
                <input type="hidden" name="hiddeliverydate" id="hiddeliverydate" value='<s:property value="hiddeliverydate"/>'>
            </div>
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">Del Terms</label>
            <input type="text" name="delterms" id="delterms" style="flex:1;" value='<s:property value="delterms"/>'>
            
            <label class="lbl-right" id="billtype" style="width:80px; margin-left:15px;">Bill Type</label>
            <div class="input-search-container" style="width: 140px;">
                <input type="text" id="txtproducttype" name="txtproducttype" placeholder="Press F3" onKeyDown="getProdType(event);" value='<s:property value="txtproducttype"/>' /> 
                <svg class="magnifier-icon" onclick="typeFormSearchContent('typeFormSearchGrid.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Pay Terms</label>
            <input type="text" name="payterms" id="payterms" style="flex:1;" value='<s:property value="payterms"/>'>
        </div>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Description</label>
            <input type="text" name="purdesc" id="purdesc" style="flex:1;" value='<s:property value="purdesc"/>'>
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Details</span>
        <div id="descdetail" class="grid-container">
            <jsp:include page="descgridDetails.jsp"></jsp:include>
        </div>
    </div>

    <div style="display:none;">
        <input type="hidden" id="masterdoc_no" name="masterdoc_no"  value='<s:property value="masterdoc_no"/>'/>
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
        <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>   
        <input type="hidden" id="nettotal" name="nettotal"  value='<s:property value="nettotal"/>'/>   
        <input type="hidden" id="descgridlenght" name="descgridlenght"  value='<s:property value="descgridlenght"/>'/>    
        <input type="hidden" id="cmbcurrval" name="cmbcurrval"  value='<s:property value="cmbcurrval"/>'/>    
        <input type="hidden" id="acctypeval" name="acctypeval"  value='<s:property value="acctypeval"/>'/>  
        <input type="hidden" id="accdocno" name="accdocno"  value='<s:property value="accdocno"/>'/>    
        <input type="hidden" id="validates" name="validates"  value='<s:property value="validates"/>'/> 
        <input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
        <input type="hidden" id="taxpers" name="taxpers"  value='<s:property value="taxpers"/>'/>
        <input type="hidden" id="taxaccount" name="taxaccount"  value='<s:property value="taxaccount"/>'/>
        <input type="hidden" id="hideproducttype" name="hideproducttype"  value='<s:property value="hideproducttype"/>'/>
    </div>

</div>
</form>

<div id="accountSearchwindow"><div></div></div>
<div id="typesearchwindow"><div></div></div>

</div>
</body>
