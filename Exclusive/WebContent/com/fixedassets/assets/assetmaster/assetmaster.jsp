<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
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
     //alert(document.getElementById("deleted").value);
     $("#masterdate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});    
     $("#purchasedate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});  
     $("#warexpdate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});  

     /* force internal alignment AFTER render */
     setTimeout(function () {
         $("#masterdate, #purchasedate, #warexpdate").find("input").css({
             "margin-top": "0px",
             "line-height": "24px",
             "font-size": "12px", 
             "font-family": "Arial, sans-serif", 
             "padding": "0 6px", 
             "box-sizing":"border-box"
         });
         $("#masterdate, #purchasedate, #warexpdate").find(".jqx-action-button").css({
             "top": "0px",
             "height": "24px"
         });
     }, 0);

     $('#accountDetailsWindow').jqxWindow({width: '51%', height: '60%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
     $('#accountDetailsWindow').jqxWindow('close');
    
     $('#fixaccountDetailsWindow').jqxWindow({width: '51%', height: '60%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
     $('#fixaccountDetailsWindow').jqxWindow('close');
    
    // $("#btnEdit").attr('disabled', true );
    
      $('#supplieraccId').dblclick(function(){
             if($('#mode').val()=="A" || $('#mode').val()=="E" )
                  {
                  
                  $('#accountDetailsWindow').jqxWindow('open');
              
                accountSearchContent('accountsDetailsSearch.jsp');
                  }
      }); 
        
      $('#masterdate').on('change', function (event) {
          
          var maindate = $('#masterdate').jqxDateTimeInput('getDate');
           if ($("#mode").val() == "A" || $("#mode").val() == "E") {   
          funDateInPeriod(maindate);
           }
         });
        
      $('#fixedassetaccId').dblclick(function(){
             if($('#mode').val()=="A" || $('#mode').val()=="E" )
                  {
                
                  $('#fixaccountDetailsWindow').jqxWindow('open');
              
                accountSearchContent1('depaccountsDetailsSearch.jsp?value='+1);
                  }
      }); 
      $('#accdepraccId').dblclick(function(){
             if($('#mode').val()=="A" || $('#mode').val()=="E" )
                  {
                  
                  $('#fixaccountDetailsWindow').jqxWindow('open');
              
                accountSearchContent1('depaccountsDetailsSearch.jsp?value='+2);
                  }
      }); 
      $('#depraccId').dblclick(function(){
             if($('#mode').val()=="A" || $('#mode').val()=="E" )
                  {
                  
                  $('#fixaccountDetailsWindow').jqxWindow('open');
              
                accountSearchContent1('depaccountsDetailsSearch.jsp?value='+3);
                  }
      }); 
    
          $('#purchasedate').on('change', function (event) {
                 if ($("#mode").val() == "A" || $("#mode").val() == "E") {   
               var purchsedate=new Date($('#purchasedate').jqxDateTimeInput('getDate'));     // out date
              var masterdate=new Date($('#masterdate').jqxDateTimeInput('getDate')); //del date
              
               if(purchsedate>masterdate){
               document.getElementById("errormsg").innerText="Purchase Date Cannot be Greater Than Document Date";
               $('#purchasedate').jqxDateTimeInput('focus'); 
               return false;
              }   
            
               else{
              
               document.getElementById("errormsg").innerText="";  
               }
              }
        
               });
    
});


function getaccountdetails1(value){
    
      if($('#mode').val()=="A" || $('#mode').val()=="E" )
    {
     var x= event.keyCode;
     if(x==114){
      $('#fixaccountDetailsWindow').jqxWindow('open');
     accountSearchContent1('depaccountsDetailsSearch.jsp?value='+value);    }
     else{
         }
    }
     }  
    
    
function getaccountdetails(event){
    
      if($('#mode').val()=="A" || $('#mode').val()=="E" )
  {
     var x= event.keyCode;
     if(x==114){
      $('#accountDetailsWindow').jqxWindow('open');
    
     accountSearchContent('accountsDetailsSearch.jsp');    }
     else{
         }
  }
     }  
    
    
function accountSearchContent1(url) {

    $.get(url).done(function (data) {

  $('#fixaccountDetailsWindow').jqxWindow('setContent', data);

    }); 
    }
    
function accountSearchContent(url) {

       $.get(url).done(function (data) {

     $('#accountDetailsWindow').jqxWindow('setContent', data);

    }); 
    }

function funReset(){
}


function funReadOnly(){     
    $('#frmassetmastrer input').attr('readonly',true);   
    $('#frmassetmastrer select').attr('disabled',true);  
    $('#warexpdate').jqxDateTimeInput({ disabled: true});
    $('#masterdate').jqxDateTimeInput({ disabled: true});
    $('#purchasedate').jqxDateTimeInput({ disabled: true});
    $('#subgriddis').attr('disabled',true); 
    $('#opening').attr('disabled',true); 
    //subgriddis opening
}
function funRemoveReadOnly(){
    $('#frmassetmastrer input').attr('readonly',false);  
    $('#frmassetmastrer select').attr('disabled',false); 
    $('#subgriddis').attr('disabled',false); 
    $('#opening').attr('disabled',false); 
    $('#accumdepr').attr('disabled',true); 
    $('#docno').attr('readonly',true);  
    $('#warexpdate').jqxDateTimeInput({ disabled: false});
    $('#masterdate').jqxDateTimeInput({ disabled: false});
    $('#purchasedate').jqxDateTimeInput({ disabled: false});
    
    $('#fixedassetaccId').attr('readonly',true);  
    $('#accdepraccId').attr('readonly',true);  
    $('#depraccId').attr('readonly',true);  
    
    $('#fixedassetaccName').attr('readonly',true);  
    $('#accdepraccIdName').attr('readonly',true);  
    $('#accdepraccIdName').attr('readonly',true); 
     // accdepraccId depraccId
    
     $('#supplieraccId').attr('readonly',true);  
     $('#supplieraccName').attr('readonly',true);  
       
    
    if ($("#mode").val() == "A") {
        
        $('#subdetail').hide();
        $('#freespace').show();
        $('#accumdepr').attr('disabled',true); 
        
        
         $('#warexpdate').val(new Date());
         $('#masterdate').val(new Date());
         $('#purchasedate').val(new Date());
         $("#jqxsubdetails").jqxGrid('clear');
        $("#jqxsubdetails").jqxGrid('addrow', null, {});
        $("#jqxsubdetails").jqxGrid('addrow', null, {});
        $("#jqxsubdetails").jqxGrid('addrow', null, {});
        
        document.getElementById("masteredit").value="";
       }
    
    
    if($('#mode').val()=='E')
    {
                if(document.getElementById("openingval").value==1)
                {
                document.getElementById("opening").checked =true;
                $('#accumdepr').attr('disabled',false); 
                $('#accumdepr').attr('readonly',false);
                    
                
                }
            else
                {
                document.getElementById("opening").checked =false;
                $('#accumdepr').attr('disabled',true); 
                
                }
                
                var rows = $('#jqxsubdetails').jqxGrid('getrows');
                 var rowlength= rows.length;
                 if (rowlength == 0) {
                     
                     $("#jqxsubdetails").jqxGrid('addrow', null, {}); 
                     $("#jqxsubdetails").jqxGrid('addrow', null, {}); 
                     $("#jqxsubdetails").jqxGrid('addrow', null, {}); 
                     }  
                 else
                     {
                     $("#jqxsubdetails").jqxGrid('addrow', null, {}); 
                     }
                
            funchkforedit(document.getElementById("srno").value);   
    }
    
    
    if($('#mode').val()=='D')
        {
        
        $('#frmassetmastrer input').attr('readonly',false);  
        $('#frmassetmastrer select').attr('disabled',false); 
        $('#warexpdate').jqxDateTimeInput({ disabled: false});
        $('#masterdate').jqxDateTimeInput({ disabled: false});
        $('#purchasedate').jqxDateTimeInput({ disabled: false});
        $('#accumdepr').attr('disabled',false); 
        
        funchkfordel(document.getElementById("srno").value);    
        funReadOnly();
        exit();
    

    
       }
function funchkfordel(srno)
{


    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();  
            if(parseInt(items)>0)
                {
                $.messager.alert('Message',' Transaction Already Exists','warning');  
return 0;
    
                
                }
            else
                {
                $('#frmassetmastrer').submit(); 
                
                
                }
          
            
            
            
        } else {
            
        }
    }
    x.open("GET", "geteditcasechk.jsp?srno="+document.getElementById("srno").value, true);
    x.send();
    
    }
    


}

function funchkforedit(srno)
    {
    

    
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText.trim();  
                if(parseInt(items)>0)
                    {
                    
                    document.getElementById("masteredit").value="master";
                    
                     //supplieraccId  totalpuchvalue opening accumdepr  fixedassetaccId accdepraccId depraccId
                     $('#supplieraccId').attr('disabled',true); 
                     $('#totalpuchvalue').attr('disabled',true); 
                     $('#opening').attr('disabled',true); 
                     $('#accumdepr').attr('disabled',true); 
                     $('#fixedassetaccId').attr('disabled',true); 
                     $('#accdepraccId').attr('disabled',true); 
                     $('#depraccId').attr('disabled',true); 
                    
                    
                    
                    }
                else
                    {
                    document.getElementById("masteredit").value="do";
                    }
              
                
                
                
            } else {
            }
        }
        x.open("GET", "geteditcasechk.jsp?srno="+srno, true);
        x.send();
    
    
    }


function funNotify(){   
     if(document.getElementById("lifetimeyear").value==0)
     {
        document.getElementById("errormsg").innerText="Life time Year cannot be 0";  
        document.getElementById("lifetimeyear").focus();
        return 0;
     }
     if(document.getElementById("depper").value==0)
     {
        document.getElementById("errormsg").innerText="Depreciation % cannot be 0";     
        document.getElementById("depper").focus();
        return 0;
     }
    var maindate = $('#masterdate').jqxDateTimeInput('getDate');
       var validdate=funDateInPeriod(maindate);
       if(validdate==0){
       return 0; 
       }
               
             var purchsedate=new Date($('#purchasedate').jqxDateTimeInput('getDate'));    
             var masterdate=new Date($('#masterdate').jqxDateTimeInput('getDate')); 
                    
             if(purchsedate>masterdate){
             document.getElementById("errormsg").innerText="Purchase Date Cannot be Greater Than Document Date";
             $('#purchasedate').jqxDateTimeInput('focus'); 
             return false;
                     }   
            
      else {
              document.getElementById("errormsg").innerText="";  
              }
            
        if($('#mode').val()=='E')
            {
            if(document.getElementById("masteredit").value=="master")
                {
            
         $('#supplieraccId').attr('disabled',false); 
         $('#totalpuchvalue').attr('disabled',false); 
         $('#opening').attr('disabled',false); 
         $('#accumdepr').attr('disabled',false); 
         $('#fixedassetaccId').attr('disabled',false); 
         $('#accdepraccId').attr('disabled',false); 
         $('#depraccId').attr('disabled',false); 
                }
            
            else
                {
                
                 if(document.getElementById("supplieraccId").value=="")
                 {
                document.getElementById("errormsg").innerText="Search Supplier Account";  
                document.getElementById("supplieraccId").focus();
                return 0;
                 }
            
                    
             if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0)
             {
            document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
            document.getElementById("totalpuchvalue").focus();
            return 0;
             }
        
        
            
             if(document.getElementById("openingval").value==1)
                {
                
                 if(document.getElementById("accumdepr").value=="" || parseFloat(document.getElementById("accumdepr").value)==0)
                 {
                 document.getElementById("errormsg").innerText="Enter Accumulated Depreciation";  
                 document.getElementById("accumdepr").focus();
                return 0;
                    
                 }
                 var total= document.getElementById("totalpuchvalue").value;
                 var accdepn=document.getElementById("accumdepr").value;
                 if(parseFloat(accdepn)>parseFloat(total))
                    {
                    
                     document.getElementById("errormsg").innerText="Accum.Depreciation Canot More Than Purchase Value";  
                        //document.getElementById("accumdepr").value="";
                    document.getElementById("accumdepr").focus();
                    return 0;
                    
                    
                     } 
                }
            
            
             if(document.getElementById("depper").value=="")
             {
            document.getElementById("errormsg").innerText="Enter Depreciation %";  
            document.getElementById("depper").focus();
            return 0;
             }
        
            
              
            
            
             if(document.getElementById("fixedassetaccId").value=="")
             {
            document.getElementById("errormsg").innerText="Search Fixed Asset Account";  
             document.getElementById("fixedassetaccId").focus();
            return 0;
             }
            
            
             if(document.getElementById("accdepraccId").value=="")
             {
            document.getElementById("errormsg").innerText="Search Accumulated Depreciation Account";  
             document.getElementById("accdepraccId").focus();
            return 0;
             }
             if(document.getElementById("depraccId").value=="")
             {
            document.getElementById("errormsg").innerText="Search Depreciation Account";  
             document.getElementById("depraccId").focus();
            return 0;
             }
            
                
                }
            
            
            
            
            
            
            }
       
    
     //supplieraccId fixedassetaccId
    if($('#mode').val()=='A')
     {
     if(document.getElementById("supplieraccId").value=="")
         {
        document.getElementById("errormsg").innerText="Search Supplier Account";  
        document.getElementById("supplieraccId").focus();
        return 0;
         }
    
            
     if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0)
     {
        document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
        document.getElementById("totalpuchvalue").focus();
        return 0;
     }
 
 
    
     if(document.getElementById("openingval").value==1)
        {
        
         if(document.getElementById("accumdepr").value=="" || parseFloat(document.getElementById("accumdepr").value)==0)
         {
         document.getElementById("errormsg").innerText="Enter Accumulated Depreciation";  
         document.getElementById("accumdepr").focus();
        return 0;
            
         }
        
         var total= document.getElementById("totalpuchvalue").value;
         var accdepn=document.getElementById("accumdepr").value;
         if(parseFloat(accdepn)>parseFloat(total))
            {
            
             document.getElementById("errormsg").innerText="Accum.Depreciation Canot More Than Purchase Value";  
                //document.getElementById("accumdepr").value="";
            document.getElementById("accumdepr").focus();
            return 0;
            
            
             } 
        
        
        }
    
    
 
     if(document.getElementById("depper").value=="")
     {
        document.getElementById("errormsg").innerText="Enter Depreciation %";  
        document.getElementById("depper").focus();
        return 0;
     }
 
    
        
    
     if(document.getElementById("fixedassetaccId").value=="")
     {
        document.getElementById("errormsg").innerText="Search Fixed Asset Account";  
         document.getElementById("fixedassetaccId").focus();
        return 0;
     }
    
    
     if(document.getElementById("accdepraccId").value=="")
     {
        document.getElementById("errormsg").innerText="Search Accumulated Depreciation Account";  
         document.getElementById("accdepraccId").focus();
        return 0;
     }
     if(document.getElementById("depraccId").value=="")
     {
        document.getElementById("errormsg").innerText="Search Depreciation Account";  
         document.getElementById("depraccId").focus();
        return 0;
     }
    
     }
     //supplieraccId fixedassetaccId
    
    
     var rows = $("#jqxsubdetails").jqxGrid('getrows');
        $('#gridval').val(rows.length);
      
       for(var i=0 ; i < rows.length ; i++){
    
        newTextBox = $(document.createElement("input"))
           .attr("type", "dil")
           .attr("id", "paytest"+i)
           .attr("name", "paytest"+i)
           .attr("hidden", "true"); 
    
       newTextBox.val(rows[i].sr_no+"::"+rows[i].desc1+" :: "+rows[i].qty+" :: ");
    
       newTextBox.appendTo('form');
       }
    
    
return 1;
}


function funChkButton() {
    
    //frmEnquiry.submit();
}


function funFocus(){
    
    $('#masterdate').jqxDateTimeInput('focus'); 
    
}

function setValues() {
    
      // main
    if($('#hidmasterdate').val()){
        $("#masterdate").jqxDateTimeInput('val', $('#hidmasterdate').val());
    }
      // purchase
    if($('#hidpurchasedate').val()){
        $("#purchasedate").jqxDateTimeInput('val', $('#hidpurchasedate').val());
    }
      // main
    if($('#hidwarexpdate').val()){
        $("#warexpdate").jqxDateTimeInput('val', $('#hidwarexpdate').val());
    }
    var docnos=document.getElementById("docno").value;
      if(parseInt(docnos)>0)
     {
          if(document.getElementById("subgriddisval").value==1)
            {
        
            $("#subdetail").load("subdetails.jsp?docno="+docnos);
            }
          
     }
      
    if($('#msg').val()!=""){
           $.messager.alert('Message',$('#msg').val());
          }
    
      funSetlabel();  
      funsetdatas();
}

function funsetdatas()
{
    if(document.getElementById("subgriddisval").value==1)
    {
        document.getElementById("subgriddis").checked=true;
        $('#subdetail').show();
        $('#freespace').hide();
    }
    else
        {
        document.getElementById("subgriddis").checked=false;
        $('#subdetail').hide();
        $('#freespace').show();
        }
    
    if(document.getElementById("openingval").value==1)
        {
        document.getElementById("opening").checked =true;
        
        if($('#mode').val()!='view')
            {
        $('#accumdepr').attr('disabled',false); 
        $('#accumdepr').attr('readonly',false);
            }
        
        }
    else
        {
        document.getElementById("opening").checked =false;
        $('#accumdepr').attr('disabled',true); 
        
        }
    
    
    if($('#assetGroupval').val()!=""){
        $("#assetGroup").val($('#assetGroupval').val());
    }
    
    if($('#locationval').val()!=""){
        $("#location").val($('#location').val());
    }
    
    
    
    }


function fundisgrid()
{
                if(document.getElementById("subgriddis").checked == true)
                    {
                    $('#subdetail').show();
                    $('#freespace').hide();
                    
                    document.getElementById("subgriddisval").value=1;
                    
                    }
                else
                    {
                $('#subdetail').hide();
                $('#freespace').show();
                
                document.getElementById("subgriddisval").value=0;
                    }
                
                
                
    
    }
    
    function funopening()
    {
        
        if(document.getElementById("opening").checked == true)
        {
            document.getElementById("openingval").value=1;
            $('#accumdepr').attr('disabled',false);     
            $('#accumdepr').attr('readonly',false); 
        }
        
        else
            {
            document.getElementById("openingval").value=0;
            document.getElementById("accumdepr").value="";
            $('#accumdepr').attr('disabled',true);  
            $('#accumdepr').attr('readonly',false);
            
            }
        
        
        
    }
    
    
    function funSearchLoad(){
        changeContent('mastersearch.jsp', $('#window'));
    }
    
    
    function getAssetgp() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText; 
                items = items.split('***');
                var branchItems = items[0].split(",");
                var branchIdItems = items[1].split(",");
                var optionsbranch = '<option value="">--Select--</option>';
                for (var i = 0; i < branchItems.length; i++) {
                    optionsbranch += '<option value="' + branchIdItems[i] + '">'
                            + branchItems[i] + '</option>';
                }
                $("select#assetGroup").html(optionsbranch);
                
                if ($('#assetGroupval').val() != null) {
                    $('#assetGroup').val($('#assetGroupval').val());
                }
            /*  if($('#assetGroupval').val()!=""){
                    $("#assetGroup").val($('#assetGroupval').val());
                }    */
            
            } else {
            }
        }
        x.open("GET", "getAssetgp.jsp", true);
        x.send();
    }

    function getloc() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText; 
                items = items.split('***');
                var branchItems1 = items[0].split(",");
                var branchIdItems1 = items[1].split(",");
                var optionsbranch1 = '<option value="">--Select--</option>';
                for (var i = 0; i < branchItems1.length; i++) {
                    optionsbranch1 += '<option value="' + branchIdItems1[i] + '">'
                            + branchItems1[i] + '</option>';
                }
                $("select#location").html(optionsbranch1);
                
                if ($('#locationval').val() != null) {
                    $('#location').val($('#locationval').val());
                }
            /*  if($('#assetGroupval').val()!=""){
                    $("#assetGroup").val($('#assetGroupval').val());
                }    */
            
            } else {
            }
        }
        x.open("GET", "getLocatons.jsp", true);
        x.send();
    }

    
    function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
         {
            
            document.getElementById("errormsg").innerText="Enter Numbers Only";  

            return false;
         }
        document.getElementById("errormsg").innerText="";  

        return true;
    }
    
    
    function funcalculatedep()
    {
        
         if ($("#mode").val() == "A" )
             {
         if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0)
         {
        document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
        document.getElementById("lifetimeyear").value="";
        document.getElementById("totalpuchvalue").focus();
        return 0;
         }
         else
         {
         document.getElementById("errormsg").innerText="";
         }
             }
        
        
            if($('#mode').val()=='E')
            {
                if(document.getElementById("masteredit").value=="master")
                    {
                    
                    }
                
                else
                    {
                    
                             if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0)
                             {
                                document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
                                document.getElementById("lifetimeyear").value="";
                                document.getElementById("totalpuchvalue").focus();
                                return 0;
                             }
                             else
                             {
                             document.getElementById("errormsg").innerText="";
                             }
                    
                    }
            
            
            }
        
        
         if ($("#mode").val() == "A" || $("#mode").val() == "E") {   
            
            
            
        var year=document.getElementById("lifetimeyear").value;
        var depval=((1/parseFloat(year))*100);
        
        funRoundAmt(depval,"depper");
         }
        
    }
    
    function funcalcuyear()
    {
        
         if ($("#mode").val() == "A" )
         {
     if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0)
     {
        document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
        document.getElementById("depper").value="";
        document.getElementById("totalpuchvalue").focus();
        return 0;
     }
     else
     {
     document.getElementById("errormsg").innerText="";
     }
 
         }
        
        
        
            if($('#mode').val()=='E')
            {
                if(document.getElementById("masteredit").value=="master")
                    {
                    
                    }
                
                else
                    {
                             
                     if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0)
                     {
                        document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
                        document.getElementById("depper").value="";
                        document.getElementById("totalpuchvalue").focus();
                        return 0;
                     }
                     else
                     {
                     document.getElementById("errormsg").innerText="";
                     }
                    
                    
                    }
                
            }
        
        
        
        
        
        
         if ($("#mode").val() == "A" || $("#mode").val() == "E") {   
                var dep=document.getElementById("depper").value;
                var yearval=(100/parseFloat(dep));
                
                funRoundAmt(yearval,"lifetimeyear");
                
                 }
    }
    function funchktotal()
    {
        
         if ($("#mode").val() == "A" )
         {
             if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0)
             {
                document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
                //document.getElementById("accumdepr").value="";
                document.getElementById("totalpuchvalue").focus();
                return 0;
             }
             else
                 {
                 document.getElementById("errormsg").innerText="";
                 }
            
            var total= document.getElementById("totalpuchvalue").value;
             var accdepn=document.getElementById("accumdepr").value;
             if(parseFloat(accdepn)>parseFloat(total))
                  {
                
                 document.getElementById("errormsg").innerText="Accum.Depreciation Canot More Than Purchase Value";  
                    //document.getElementById("accumdepr").value="";
                document.getElementById("accumdepr").focus();
                return 0;
                
                
                 }
             else
                 {
                 document.getElementById("errormsg").innerText="";
                 }
    
 
         }
        
        
            if($('#mode').val()=='E')
            {
                if(document.getElementById("masteredit").value=="master")
                    {
                
                    }
                else
                    {
                                     if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0)
                                     {
                                        document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
                                        //document.getElementById("accumdepr").value="";
                                        document.getElementById("totalpuchvalue").focus();
                                        return 0;
                                     }
                                     else
                                         {
                                         document.getElementById("errormsg").innerText="";
                                         }
                                    
                    
                        var total= document.getElementById("totalpuchvalue").value;
                         var accdepn=document.getElementById("accumdepr").value;
                         if(parseFloat(accdepn)>parseFloat(total))
                              {
                            
                             document.getElementById("errormsg").innerText="Accum.Depreciation Canot More Than Purchase Value";  
                                //document.getElementById("accumdepr").value="";
                            document.getElementById("accumdepr").focus();
                            return 0;
                            
                            
                             }
                         else
                             {
                             document.getElementById("errormsg").innerText="";
                             }
                    
                    }
            }
        
        
        
        
        
        
        
        

    }
    
    
    
    function funchkaccum()
    {
        
         if ($("#mode").val() == "A" )
         {
            
            
             if(document.getElementById("openingval").value==1)
                {
                
                     if(document.getElementById("accumdepr").value=="" || parseFloat(document.getElementById("accumdepr").value)==0)
                     {
                     document.getElementById("errormsg").innerText="Enter Accumulated Depreciation";  
                     document.getElementById("accumdepr").focus();
                    return 0;
                        
                     }
                    
                     var total= document.getElementById("totalpuchvalue").value;
                     var accdepn=document.getElementById("accumdepr").value;
                     if(parseFloat(accdepn)>parseFloat(total))
                          {
                        
                            document.getElementById("errormsg").innerText="Purchase Value Canot Less Than Accum.Depreciation  ";  
                            //document.getElementById("accumdepr").value="";
                        document.getElementById("totalpuchvalue").focus();
                        return 0;
                        
                        
                         } 
                     else
                         {
                         document.getElementById("errormsg").innerText="";
                         }
 
             }
         }
            
             if($('#mode').val()=='E')
                {
                    if(document.getElementById("masteredit").value=="master")
                        {
                    
                        }
                    else
                        {
                        if(document.getElementById("openingval").value==1)
                        {
                        
                             if(document.getElementById("accumdepr").value=="" || parseFloat(document.getElementById("accumdepr").value)==0)
                             {
                             document.getElementById("errormsg").innerText="Enter Accumulated Depreciation";  
                             document.getElementById("accumdepr").focus();
                            return 0;
                                
                             }
                            
                             var total= document.getElementById("totalpuchvalue").value;
                             var accdepn=document.getElementById("accumdepr").value;
                             if(parseFloat(accdepn)>parseFloat(total))
                                  {
                                
                                    document.getElementById("errormsg").innerText="Purchase Value Canot Less Than Accum.Depreciation  ";  
                                    //document.getElementById("accumdepr").value="";
                                document.getElementById("totalpuchvalue").focus();
                                return 0;
                                
                                
                                 } 
                             else
                                 {
                                 document.getElementById("errormsg").innerText="";
                                 }
        
                     }
                        
                        }
                }
            
        
        
    }
     function funPrintBtn() {
            
            if (($("#mode").val() == "view") && $("#docno").val()!="") {
                var url=document.URL;
                var reurl=url.split("saveAssetmaster");
                $("#docno").prop("disabled", false);  
               var branch=<%=session.getAttribute("BRANCHID").toString()%>
              // alert(branch);
                    
                         var win= window.open(reurl[0]+"printassetmaster?docno="+document.getElementById("docno").value+"&branch="+branch,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                         win.focus();
                     }
                    
            else 
            {
                $.messager.alert('Message','Select a Document....!','warning');
                return;
            }
   }
   
    
    
    
    
    
    
    
     // accumdepr Accum.Depreciation
    

</script>
</head>
<body onload="setValues();getAssetgp();getloc();">
    <div id="mainBG" class="homeContent" data-type="background">
    <form id="frmassetmastrer" action="saveAssetmaster" autocomplete="OFF">
    <jsp:include page="../../../../header.jsp"></jsp:include>
    <div class='modern-ui hidden-scrollbar'>
        
        <!-- Panel 1: General Info -->
        <div class="middle-panel">
            <span class="middle-panel-title">Asset Master</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Date</label>
                <div style="width: 125px;">
                    <div id='masterdate' name='masterdate' value='<s:property value="masterdate"/>'></div>
                    <input type="hidden" id="hidmasterdate" name="hidmasterdate" value='<s:property value="hidmasterdate"/>' />
                </div>
                
                <label class="lbl-right" style="width:80px; margin-left: 15px;">Ref No</label>
                <input type="text" id="refno" name="refno" style="width:150px;" value='<s:property value="refno"/>' />
                
                <label class="lbl-right" style="width:80px; margin-left: auto;">Doc No.</label>
                <input type="text" id="docno" name="docno" style="width:120px;" tabindex="-1" value='<s:property value="docno"/>' readonly/>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Asset Id</label>
                <input type="text" id="assetid" name="assetid" style="width:150px;" value='<s:property value="assetid"/>' />

                <label class="lbl-right" style="width:80px; margin-left: 15px;">Name</label>
                <input name="assetname" type="text" id="assetname" style="flex:1; max-width: 350px;" value='<s:property value="assetname"/>' />
            </div>

            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Remarks</label>
                <input type="text" id="remarks" name="remarks" style="flex:1;" value='<s:property value="remarks"/>' />
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Asset Group</label>
                <select style="width: 200px;" id="assetGroup" name="assetGroup" value='<s:property value="assetGroup"/>'>
                    <option value="">--Select--</option>
                </select> 
                <input type="hidden" name="assetGroupval" id="assetGroupval" value='<s:property value="assetGroupval"/>' />

                <label class="lbl-right" style="width:80px; margin-left: 15px;">Location</label>
                <select style="width: 150px;" id="location" name="location" value='<s:property value="location"/>'>
                    <option value="">--Select--</option>
                </select>
                <input type="hidden" name="locationval" id="locationval" value='<s:property value="locationval"/>' />
            </div>
        </div>
        
        <!-- Flex Container for Purchase & Sub Details -->
        <div style="display: flex; gap: 15px; margin-bottom: 15px;">
            <!-- Left Side: Purchase -->
            <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
                <span class="middle-panel-title">Purchase</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Supplier</label>
                    <div class="input-search-container" style="width: 120px;">
                        <input type="text" id="supplieraccId" placeholder="Press F3" name="supplieraccId" value='<s:property value="supplieraccId"/>' onkeydown="getaccountdetails(event)" />
                        <svg class="magnifier-icon" onclick="if($('#mode').val()=='A' || $('#mode').val()=='E'){ $('#accountDetailsWindow').jqxWindow('open'); accountSearchContent('accountsDetailsSearch.jsp'); }" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input name="supplieraccName" type="text" id="supplieraccName" style="flex:1;" value='<s:property value="supplieraccName"/>' tabindex="-1" readonly />

                    <input name="supaccdocno" type="hidden" id="supaccdocno" value='<s:property value="supaccdocno"/>' />
                    <input name="supcmbcurrency" type="hidden" id="supcmbcurrency" value='<s:property value="supcmbcurrency"/>' /> 
                    <input name="suprate" type="hidden" id="suprate" value='<s:property value="suprate"/>' /> 
                    <input name="suphidcurrencytype" type="hidden" id="suphidcurrencytype" value='<s:property value="suphidcurrencytype"/>' />
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Purchase Ref No</label>
                    <input type="text" id="purchrefno" name="purchrefno" style="width:120px;" value='<s:property value="purchrefno"/>' />
                    
                    <label class="lbl-right" style="width:100px; margin-left: auto;">Purchase Date</label>
                    <div style="width: 120px;">
                        <div id='purchasedate' name='purchasedate' value='<s:property value="purchasedate"/>'></div> 
                        <input type="hidden" id="hidpurchasedate" name="hidpurchasedate" value='<s:property value="hidpurchasedate"/>' />
                    </div>
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">No Of items</label>
                    <input type="text" id="noofitems" name="noofitems" style="width:120px; text-align:right;" value='<s:property value="noofitems"/>' onkeypress="javascript:return isNumber (event);" />
                    
                    <label class="lbl-right" style="width:120px; margin-left: auto;">Total Purchase Value</label>
                    <input name="totalpuchvalue" type="text" id="totalpuchvalue" style="width:120px; text-align: right;" value='<s:property value="totalpuchvalue"/>' onblur="funRoundAmt(this.value,this.id);funchkaccum();" onkeypress="javascript:return isNumber (event);" />
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:100px;">WNTY Exp Date</label>
                    <div style="width: 120px;">
                        <div id='warexpdate' name='warexpdate' value='<s:property value="warexpdate"/>'></div> 
                        <input type="hidden" id="hidwarexpdate" name="hidwarexpdate" value='<s:property value="hidwarexpdate"/>' />
                    </div>
                    
                    <label class="lbl-right" style="width:100px; margin-left: auto;">WNTY DocNo</label>
                    <input type="text" name="wntydocno" id="wntydocno" style="width:120px;" value='<s:property value="wntydocno"/>' />
                </div>
            </div>
            
            <!-- Right Side: Sub Details -->
            <div class="middle-panel" style="flex: 1; margin-bottom: 0; padding-top: 10px;">
                <div class="field-row">
                    <label class="lbl-right" style="display:flex; align-items:center; gap:4px; width:auto;">
                        <input type="checkbox" id="subgriddis" name="subgriddis" onchange="fundisgrid();" style="margin:0; width:auto; height:auto !important; cursor:pointer;"> Sub Details 
                    </label>
                    <input type="hidden" name="subgriddisval" id="subgriddisval" value='<s:property value="subgriddisval"/>' />
                </div>
                
                <div id="subdetail" hidden="true" class="grid-container" style="border:none;">
                    <jsp:include page="subdetails.jsp"></jsp:include>
                </div>
                <div id="freespace" style="height:150px;"></div>
            </div>
        </div>

        <!-- Flex Container for Depreciation & Accounts -->
        <div style="display: flex; gap: 15px; margin-bottom: 15px;">
            <!-- Left Side: Depreciation -->
            <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
                <span class="middle-panel-title">Depreciation</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="display:flex; align-items:center; gap:4px; width:auto;">
                        <input type="checkbox" id="opening" name="opening" onchange="funopening()" style="margin:0; width:auto; height:auto !important; cursor:pointer;"> Opening 
                    </label>
                    <input type="hidden" id="openingval" name="openingval" value='<s:property value="openingval"/>' />
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Accum.Depr</label>
                    <input type="text" id="accumdepr" style="width:120px; text-align: right;" name="accumdepr" value='<s:property value="accumdepr"/>' onblur="funRoundAmt(this.value,this.id);funchktotal();" onkeypress="javascript:return isNumber (event);" />
                    
                    <label class="lbl-right" style="width:100px; margin-left: auto;">Life Time (Year)</label>
                    <input name="lifetimeyear" type="text" id="lifetimeyear" style="width:80px; text-align: right;" value='<s:property value="lifetimeyear"/>' onblur="funRoundAmt(this.value,this.id);funcalculatedep();" onkeypress="javascript:return isNumber (event);" />
                    
                    <label class="lbl-right" style="width:60px; margin-left: 15px;">Depr %</label>
                    <input type="text" id="depper" name="depper" style="width:80px; text-align: right;" value='<s:property value="depper"/>' onblur="funRoundAmt(this.value,this.id);funcalcuyear();" onkeypress="javascript:return isNumber (event);" />
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:100px;">Notes</label>
                    <input type="text" id="depnotes" style="flex:1;" name="depnotes" value='<s:property value="depnotes"/>' />
                </div>
            </div>
            
            <!-- Right Side: Account Linking -->
            <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
                <span class="middle-panel-title">Accounts</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Fixed Asset</label>
                    <div class="input-search-container" style="width: 120px;">
                        <input type="text" id="fixedassetaccId" placeholder="Press F3" name="fixedassetaccId" value='<s:property value="fixedassetaccId"/>' onkeydown="getaccountdetails1(1)" />
                        <svg class="magnifier-icon" onclick="if($('#mode').val()=='A' || $('#mode').val()=='E'){ $('#fixaccountDetailsWindow').jqxWindow('open'); accountSearchContent1('depaccountsDetailsSearch.jsp?value=1'); }" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input name="fixedassetaccName" type="text" id="fixedassetaccName" style="flex:1;" value='<s:property value="fixedassetaccName"/>' tabindex="-1" readonly />
                    <input name="fixaccDocno" type="hidden" id="fixaccDocno" value='<s:property value="fixaccDocno"/>' />
                    <input name="fixaccCurrid" type="hidden" id="fixaccCurrid" value='<s:property value="fixaccCurrid"/>' /> 
                    <input name="fixaccRate" type="hidden" id="fixaccRate" value='<s:property value="fixaccRate"/>' />
                    <input name="fixaccType" type="hidden" id="fixaccType" value='<s:property value="fixaccType"/>' />
                </div>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:100px;">Accu.Depr</label>
                    <div class="input-search-container" style="width: 120px;">
                        <input type="text" id="accdepraccId" placeholder="Press F3" name="accdepraccId" value='<s:property value="accdepraccId"/>' onkeydown="getaccountdetails1(2)" />
                        <svg class="magnifier-icon" onclick="if($('#mode').val()=='A' || $('#mode').val()=='E'){ $('#fixaccountDetailsWindow').jqxWindow('open'); accountSearchContent1('depaccountsDetailsSearch.jsp?value=2'); }" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input name="accdepraccName" type="text" id="accdepraccName" style="flex:1;" value='<s:property value="accdepraccName"/>' tabindex="-1" readonly />
                    <input name="accdepraccDocno" type="hidden" id="accdepraccDocno" value='<s:property value="accdepraccDocno"/>' /> 
                    <input name="accdepraccCurrid" type="hidden" id="accdepraccCurrid" value='<s:property value="accdepraccCurrid"/>' /> 
                    <input name="accdepraccRate" type="hidden" id="accdepraccRate" value='<s:property value="accdepraccRate"/>' /> 
                    <input name="accdepraccType" type="hidden" id="accdepraccType" value='<s:property value="accdepraccType"/>' />
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:100px;">Depreciation</label>
                    <div class="input-search-container" style="width: 120px;">
                        <input type="text" id="depraccId" placeholder="Press F3" name="depraccId" value='<s:property value="depraccId"/>' onkeydown="getaccountdetails1(3)" />
                        <svg class="magnifier-icon" onclick="if($('#mode').val()=='A' || $('#mode').val()=='E'){ $('#fixaccountDetailsWindow').jqxWindow('open'); accountSearchContent1('depaccountsDetailsSearch.jsp?value=3'); }" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input name="depraccName" type="text" id="depraccName" style="flex:1;" value='<s:property value="depraccName"/>' tabindex="-1" readonly />
                    <input name="depracDocno" type="hidden" id="depracDocno" value='<s:property value="depracDocno"/>' />
                    <input name="depracCurrid" type="hidden" id="depracCurrid" value='<s:property value="depracCurrid"/>' /> 
                    <input name="depracRate" type="hidden" id="depracRate" value='<s:property value="depracRate"/>' />
                    <input name="depracType" type="hidden" id="depracType" value='<s:property value="depracType"/>' />
                </div>
            </div>
        </div>

        <!-- Hidden Fields -->
        <div style="display:none;">
            <input type="hidden" id="masteredit" name="masteredit" value='<s:property value="masteredit"/>' />
            <input type="hidden" id="srno" name="srno" value='<s:property value="srno"/>' /> 
            <input type="hidden" id="gridval" name="gridval" value='<s:property value="gridval"/>' />
            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' /> 
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' />
        </div>
        
    </div>
    
    <div id="accountDetailsWindow"><div></div></div>
    <div id="fixaccountDetailsWindow"><div></div></div>
    
</form>
</div>
</body>
</html>