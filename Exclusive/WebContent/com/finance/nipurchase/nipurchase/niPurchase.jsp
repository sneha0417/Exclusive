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
    $("#nipurchasedate").jqxDateTimeInput({  width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    $("#deliverydate").jqxDateTimeInput({  width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    $("#invDate").jqxDateTimeInput({  width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
    
    /* force internal alignment AFTER render */
    setTimeout(function () {
        $("#nipurchasedate, #deliverydate, #invDate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#nipurchasedate, #deliverydate, #invDate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);

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
    
    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 100, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#accountSearchwindow').jqxWindow('close');
    
    $('#accounttypeSearchwindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '75%' ,maxWidth: '70%' , title: 'Account Search' ,position: { x: 500, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#accounttypeSearchwindow').jqxWindow('close');
    
    $('#costtpesearchwndow').jqxWindow({ width: '35%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Cost Type Search' ,position: { x: 700, y:60 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#costtpesearchwndow').jqxWindow('close');   
    
    $('#costcodesearchwndow').jqxWindow({ width: '35%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Cost code Search' ,position: { x: 800, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#costcodesearchwndow').jqxWindow('close');  
    
    $('#refnosearchwindow').jqxWindow({ width: '50%', height: '59%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Ref No Search' ,position: { x: 450, y: 40 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#refnosearchwindow').jqxWindow('close');  
    
    $('#nipurchslnosearch').jqxWindow({ width: '50%', height: '59%',  maxHeight: '62%' ,maxWidth: '60%' , title: ' Search' ,position: { x: 200, y: 60}, theme: 'energyblue', keyboardCloseKey: 27});
    $('#nipurchslnosearch').jqxWindow('close');
    
    $('#txtproducttype').dblclick(function(){
        typeFormSearchContent('typeFormSearchGrid.jsp'); 
    }); 
    
    $('#refno').dblclick(function(){
        if($('#mode').val()!= "view") {
            $('#refnosearchwindow').jqxWindow('open');
            refnoSearchContent('ordermainsearch.jsp?');
        }
    }); 
    
     $('#nipuraccid').dblclick(function(){
        if($('#mode').val()!= "view") {
            $('#accountSearchwindow').jqxWindow('open');
            accountSearchContent('accountsDetailsFromGrid.jsp?dtype='+$('#acctype').val());
        } 
  });   
});

function typeFormSearchContent(url) {
     document.getElementById("errormsg").innerText="";
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
         
function getrefnosearch(event){
     var x= event.keyCode;
        if($('#mode').val()!= "view") {
             if(x==114){
              $('#refnosearchwindow').jqxWindow('open');
              refnoSearchContent('ordermainsearch.jsp?');   }
             else{
                 }
        }
     }  
     
function refnoSearchContent(url) {
         $.get(url).done(function (data) {
             $('#refnosearchwindow').jqxWindow('open');
        $('#refnosearchwindow').jqxWindow('setContent', data);
    }); 
    } 
    
 function costcodeSearchContent(url) {
         $.get(url).done(function (data) {
             $('#costcodesearchwndow').jqxWindow('open');
        $('#costcodesearchwndow').jqxWindow('setContent', data);
    }); 
    }  

    function costSearchContent(url) {
             $.get(url).done(function (data) {
                 $('#costtpesearchwndow').jqxWindow('open');
            $('#costtpesearchwndow').jqxWindow('setContent', data);
        }); 
        } 
        
    function CashSearchContent(url) {
             $.get(url).done(function (data) {
                 $('#accounttypeSearchwindow').jqxWindow('open');
            $('#accounttypeSearchwindow').jqxWindow('setContent', data);
        }); 
        } 
        
    function getaccountdetails(event){
         var x= event.keyCode;
        if($('#mode').val()!= "view") {
             if(x==114){
              $('#accountSearchwindow').jqxWindow('open');
             accountSearchContent('accountsDetailsFromGrid.jsp?dtype='+$('#acctype').val());   }
             else{
                 }
          } 
         }  
         
          function accountSearchContent(url) {
              $.get(url).done(function (data) {
            $('#accountSearchwindow').jqxWindow('setContent', data);
        }); 
            }
            
          function nipurhsaeslnocontent(url) {
                   $.get(url).done(function (data) {
               $('#nipurchslnosearch').jqxWindow('open');
                     $('#nipurchslnosearch').jqxWindow('setContent', data);
                }); 
                } 
  
  function funFocus(){
      $('#nipurchasedate').jqxDateTimeInput('focus');         
    }
    
    function funNotify(){   
    var purid= document.getElementById("nipuraccid").value;

    if(purid=="")
        {
         document.getElementById("errormsg").innerText=" Select An Account";
         document.getElementById("nipuraccid").focus();
         return 0;
           }
    else
           {
           document.getElementById("errormsg").innerText="";
           } 

    var invno= document.getElementById("invno").value;
        if(invno=="")
            {
             document.getElementById("errormsg").innerText=" Enter Inv NO";
             document.getElementById("invno").focus();
             return 0;
               }
        else
               {
               document.getElementById("errormsg").innerText="";
               } 

         var refval= document.getElementById("nettotal").value;
         if(refval=="")
            {
             document.getElementById("errormsg").innerText="Net Total Empty";
             return 0;
               }
        else
               {
               document.getElementById("errormsg").innerText="";
               }

    var nipurchasedate = $('#nipurchasedate').jqxDateTimeInput('getDate');
    var validdate=funDateInPeriod(nipurchasedate);
    if(validdate==0){
    return 0;   
    }
            
             var txtproducttype= document.getElementById('txtproducttype').value;
             if(txtproducttype=="")
             {
                 var aa=0;
                    var selectedrows=$("#nidescdetailsGrid").jqxGrid('getrows');    
                      for(var i=0 ; i < selectedrows.length ; i++){
                          var tax=$("#nidescdetailsGrid").jqxGrid('getcellvalue',selectedrows[i],'taxper');
                          if(parseFloat(tax)>0.0){
                              $.messager.alert('Message','Select A Bill Type','warning'); 
                              return 0;
                          }
                      }
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
            
            var rows=$('#nidescdetailsGrid').jqxGrid('getrows');
             var aa=0;
             for(var i=0;i<(rows.length);i++){
               var chk=$('#nidescdetailsGrid').jqxGrid('getcellvalue',i,'headdoc');
               var qty=$('#nidescdetailsGrid').jqxGrid('getcellvalue',i,'qty');
               
               if(parseFloat(qty)>0)
               {
                  if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != "" && chk != "0"){
                     aa=1;
                  }
                  else 
                      {
                      aa=0;
                      }
               }
             }
                
             if(parseInt(aa)==0) {
                 document.getElementById("errormsg").innerText=" Please Select Account";
                 return false;
             } 
            
        if( document.getElementById("nireftype").value=="NPO")
            {
          var refno= document.getElementById('refno').value;
             if(refno=="")
             {
                 document.getElementById("errormsg").innerText=" Select Ref NO";  
                 document.getElementById('refno').focus();
                 return 0;
             }
             else
                 {
                 document.getElementById("errormsg").innerText="";
                 }
            }

             var rows = $("#nidescdetailsGrid").jqxGrid('getrows');
                $('#nidescdetailslenght').val(rows.length);
               for(var i=0 ; i < rows.length ; i++){
                newTextBox = $(document.createElement("input"))
                   .attr("type", "dil")
                   .attr("id", "desctest"+i)
                   .attr("name", "desctest"+i)
                    .attr("hidden", "true"); 
               
               newTextBox.val(rows[i].srno+"::"+rows[i].qty+" :: "+rows[i].description+" :: "
                       +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].nuprice+" :: "
                       +rows[i].costtype+" :: "+rows[i].costcode+" :: "+rows[i].remarks+" :: "+rows[i].headdoc+" :: "+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].taxamount+"::"+"::"+rows[i].rowno+"::");
            
               newTextBox.appendTo('form');
               }   
               
                var x =new XMLHttpRequest();
                x.onreadystatechange=function()
                {
                if(x.readyState==4 && x.status==200)    
                {
                    var items=x.responseText;
                    var chk=items.trim();
                    
                if(parseInt(chk)==1)
                    {
                    document.getElementById("errormsg").innerText="Inv No "+document.getElementById("invno").value+" Already Exists ";  
                    document.getElementById("invno").focus();
                    return 0;
                    }
                else
                    {
                     document.getElementById("errormsg").innerText="";
                     document.getElementById("frmNipurchase").submit();
                    }
                }
                }
                x.open("GET","checkinvno.jsp?invno="+document.getElementById("invno").value+'&masterdocno='+document.getElementById("masterdoc_no").value+'&accdocno='+document.getElementById("accdocno").value);
                x.send();   
        } 

        function funchkinv()
        {
        var x =new XMLHttpRequest();
        x.onreadystatechange=function()
        {
        if(x.readyState==4 && x.status==200)    
        {
            var items=x.responseText;
            var chk=items.trim();
        if(parseInt(chk)==1)
            {
            document.getElementById("errormsg").innerText="Inv No "+document.getElementById("invno").value+" Already Exists ";  
            document.getElementById("invno").focus();
            return 0;
            }
        else
            {
             document.getElementById("errormsg").innerText="";
             return 1;
            }
        }
        }
        x.open("GET","checkinvno.jsp?invno="+document.getElementById("invno").value+'&masterdocno='+document.getElementById("masterdoc_no").value+'&accdocno='+document.getElementById("accdocno").value);
        x.send();
        }
        
           function funchkforedit()
            {
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim();  
                        if(parseInt(items)>0)
                            {
                             $("#btnEdit").attr('disabled', true );
                             $("#btnDelete").attr('disabled', true ); 
                            }
                        else
                            {
                            }
                    } else {
                    }
                }
                x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
                x.send();   
            }
            
        function funChkButton() {
            //frmEnquiry.submit();
        }

        function funSearchLoad(){
             changeContent('nipurchaseMastersearch.jsp'); 
        }

            function funReset(){
                //$('#frmNipurchase')[0].reset(); 
            }
            function funReadOnly(){
                $('#frmNipurchase input').attr('readonly', true );
                $('#frmNipurchase select').attr('disabled', true );
                 $('#nipurchasedate').jqxDateTimeInput({ disabled: true});
                 $('#deliverydate').jqxDateTimeInput({ disabled: true});
                 $('#invDate').jqxDateTimeInput({ disabled: true});
                 $('#interstate').attr('disabled', true);
                 $('#nireftype').attr('disabled', true);
                  $('#cmbcurr').attr('disabled', true);
                 $('#acctype').attr('disabled', true);
                 $('#refno').attr('disabled', true);
                   $('#refslno').attr('disabled', true);
                    $("#nidescdetailsGrid").jqxGrid({ disabled: true});
                     $('#txtproducttype').attr('disabled', true);
                   combochange();
                      getCurrencyIds();
            }
            
            function funRemoveReadOnly(){
                  funinterstate();
                $('#frmNipurchase input').attr('readonly', false );
                $('#frmNipurchase select').attr('disabled', false );
                 $('#nipurchasedate').jqxDateTimeInput({ disabled: false});
                 $('#deliverydate').jqxDateTimeInput({ disabled: false});
                 $('#invDate').jqxDateTimeInput({ disabled: false});
                 $('#interstate').attr('disabled', false);
                 $('#txtproducttype').attr('readonly', true);
                 $('#nireftype').attr('disabled', false);
                  $('#cmbcurr').attr('disabled', false);
                 $('#acctype').attr('disabled', false);;
                $('#docno').attr('readonly', true);
                 $('#currate').attr('readonly', true);
                  $('#nipuraccid').attr('readonly', true);
                  $('#puraccname').attr('readonly', true);
                  $('#refno').attr('disabled', true);
                   $('#refslno').attr('disabled', true);
                      $('#refno').attr('readonly', true);
                      $('#refslno').attr('readonly', true);
            
                    $("#nidescdetailsGrid").jqxGrid({ disabled: false});
                    if ($("#mode").val() == "A") {
                        $('#nipurchasedate').val(new Date());
                        $('#deliverydate').val(new Date());
                         $("#nidescdetailsGrid").jqxGrid('clear');
                            $("#nidescdetailsGrid").jqxGrid('addrow', null, {});
                            $('#txtproducttype').attr('disabled', true);
                            document.getElementById("validates").value=0;
                            getCurrencyIds();
                   }
                if ($("#mode").val() == "E") {
                    getCurrencyIds();
                  if($('#reftypeval').val()=="NPO")
                      {
                      $('#refno').attr('disabled', false);
                       $('#refslno').attr('disabled', false);
                  $('#refno').attr('readonly', true);
                   $('#refslno').attr('readonly', true);
                      }
                   }
                if($('#mode').val()=='A'){
                    $('#cmbbilltype').val('1');
                }
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
                            
                            if ($('#cmbcurrval').val() != null && $('#cmbcurrval').val() != "") {
                                 $('#cmbcurr').val($('#cmbcurrval').val()) ;
                                getRatevalue1($('#cmbcurrval').val(),$('#nipurchasedate').val());
                             } 
                        }
                           else
                      {
                           optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
                           $("select#cmbcurr").html(optionscurr);
                          funRoundRate(currateItems,"currate");
                          
                          if ($('#cmbcurrval').val() != null && $('#cmbcurrval').val() != "") {
                                 $('#cmbcurr').val($('#cmbcurrval').val()) ;
                                getRatevalue1($('#cmbcurrval').val(),$('#nipurchasedate').val());
                             } 
                          $('#currate').attr('readonly', true);
                       
                      }
                    }
                       }
                   x.open("GET","getCurrencyId.jsp?date="+document.getElementById("nipurchasedate").value ,true);
                    x.send();
                    }
                   
                   function getRatevalue1(angel,date)
                   {
                   var x=new XMLHttpRequest();
                   x.onreadystatechange=function(){
                   if (x.readyState==4 && x.status==200)
                    {
                      var items= x.responseText;
                         funRoundRate(items,"currate");  
                        }
                          else
                      {
                      }
                       }
                   x.open("GET","getRateFrom.jsp?curr="+angel+"&date="+date,true);
                    x.send();
                    }
                   
                   function funrefdisslno()
                   {
                         $("#nidescdetailsGrid").jqxGrid('clear');
                            $("#nidescdetailsGrid").jqxGrid('addrow', null, {});
                        
                       if($('#nireftype').val()=="NPO") 
                          {
                           $('#refno').attr('disabled', false);
                           $('#refslno').attr('disabled', false);
                          } 
                       else
                           {
                           $('#refno').val(" ");
                           $('#refslno').val(" ");
                           $('#refno').attr('disabled', true);
                           $('#refslno').attr('disabled', true);
                           }
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
                       if($('#reftypeval').val()!="")
                          {
                          $('#nireftype').val($('#reftypeval').val());
                          
                          if($('#reftypeval').val()=="NPO")
                              {
                              $('#refno').attr('disabled', false);
                               $('#refslno').attr('disabled', false);
                          $('#refno').attr('readonly', true);
                           $('#refslno').attr('readonly', true);
                              }
                          }
                   }
    
                   function setValues() {
                       combochange();
                       getCurrencyIds();
                      
                       if($('#hidnipurchasedate').val()){
                            $("#nipurchasedate").jqxDateTimeInput('val', $('#hidnipurchasedate').val());
                        }
                        
                        if($('#hiddeliverydate').val()){
                            $("#deliverydate").jqxDateTimeInput('val', $('#hiddeliverydate').val());
                        }
                        
                        if($('#hidinvDate').val()){
                            $("#invDate").jqxDateTimeInput('val', $('#hidinvDate').val());
                        }
                        var interstate=document.getElementById("hidinterstate").value;
                        
                        if(interstate>0){
                            document.getElementById("interstate").checked=true;
                        }
                        else{
                            document.getElementById("interstate").checked=false;
                        }
                        
                        if($('#hidcmbbilltype').val!=""){
                            $("#cmbbilltype").val($('#hidcmbbilltype').val());
                        }
                        
                        var dis=document.getElementById("masterdoc_no").value;
                        if(dis>0)
                            {     
                            funchkforedit();
                         var indexval1 = document.getElementById("masterdoc_no").value;   
                                 $("#nipurdetails").load("descgridDetails.jsp?nipurdoc="+indexval1);
                             } 
            
                         if($('#msg').val()!=""){
                           $.messager.alert('Message',$('#msg').val());
                          } 
                         document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
                    }
                   
                   function funPrintBtn(){
                       if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
                      
                       var url=document.URL;

                        var reurl=url.split("saveActionNipurchase");
                        
                        $("#docno").prop("disabled", false);                
                        var dtype=$('#formdetailcode').val();
                         var brhid=<%= session.getAttribute("BRANCHID").toString()%>
                  
                var win= window.open(reurl[0]+"printniphs?docno="+document.getElementById("masterdoc_no").value+"&dtype="+dtype+"&brhid="+brhid,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
                     
                win.focus();
                       } 
                      
                       else {
                              $.messager.alert('Message','Select a Document....!','warning');
                              return false;
                             }
                        
                    }
                           
</script>
</head>
<body onLoad="getCurrencyIds();setValues();funinterstate();" >


<div id="mainBG" class="homeContent" data-type="background">
<form id="frmNipurchase" action="saveActionNipurchase" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" />    

<div class='modern-ui hidden-scrollbar'>

    <div class="middle-panel">
        <span class="middle-panel-title">General Info</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 120px;">
                <div id="nipurchasedate" name="nipurchasedate" value='<s:property value="nipurchasedate"/>'></div>
                <input type="hidden" name="hidnipurchasedate" id="hidnipurchasedate" value='<s:property value="hidnipurchasedate"/>'>
            </div>

            <label class="lbl-right" style="width:80px; margin-left: 15px;">Ref Type</label>
            <select name="nireftype" id="nireftype" style="width:100px;" value='<s:property value="nireftype"/>' onchange="funrefdisslno()">
                <option value="DIR">DIR</option>
                <option value="NPO">NPO</option>
            </select>

            <label class="lbl-right" style="width:80px; margin-left: 15px;">Ref No</label>
            <div class="input-search-container" style="width: 140px;">
                <input type="text" name="refno" id="refno" placeholder="Press F3" value='<s:property value="refno"/>' onKeyDown="getrefnosearch(event);">
                <svg class="magnifier-icon" onclick="if($('#mode').val()!='view'){ $('#refnosearchwindow').jqxWindow('open'); refnoSearchContent('ordermainsearch.jsp?'); }" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <label class="lbl-right" style="width:60px; margin-left: auto;">Doc No</label>
            <input type="text" name="docno" id="docno" style="width:100px;" tabindex="-1" value='<s:property value="docno"/>' readonly="readonly">
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Inv No</label>
            <input type="text" id="invno" name="invno" style="width:120px;" onblur="funchkinv();" value='<s:property value="invno"/>'>

            <label class="lbl-right" style="width:80px; margin-left: 15px;">Inv Date</label>
            <div style="width: 120px;">
                <div id="invDate" name="invDate" value='<s:property value="invDate"/>'></div>
                <input type="hidden" id="hidinvDate" name="hidinvDate" value='<s:property value="hidinvDate"/>'>
            </div>

            <label class="lbl-right" style="width:80px; margin-left: 15px;">Type</label>
            <select name="cmbbilltype" id="cmbbilltype" style="width:100px;" value='<s:property value="cmbbilltype"/>'>
                <option value="1">ST</option>
                <option value="2">RCM</option>
            </select>
            <input type="hidden" id="hidcmbbilltype" name="hidcmbbilltype" value='<s:property value="hidcmbbilltype"/>'/>

            <label class="lbl-right" id="billtype" style="width:80px; margin-left: 15px;">Bill Type</label>
            <div class="input-search-container" style="width: 140px;">
                <input type="text" id="txtproducttype" name="txtproducttype" placeholder="Press F3" onKeyDown="getProdType(event);" value='<s:property value="txtproducttype"/>' /> 
                <svg class="magnifier-icon" onclick="typeFormSearchContent('typeFormSearchGrid.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Vendor Details</span>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Vendor</label>
            <input type="hidden" name="acctype" id="acctype" value='<s:property value="acctype"/>'>
            
            <div class="input-search-container" style="width: 120px;">
                <input type="text" name="nipuraccid" id="nipuraccid" value='<s:property value="nipuraccid"/>' placeholder="Press F3" onKeyDown="getaccountdetails(event);" >  
                <svg class="magnifier-icon" onclick="if($('#mode').val()!='view'){ $('#accountSearchwindow').jqxWindow('open'); accountSearchContent('accountsDetailsFromGrid.jsp?dtype='+$('#acctype').val()); }" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <input type="text" id="puraccname" name="puraccname" value='<s:property value="puraccname"/>' style="flex:1; max-width:300px;" tabindex="-1" readonly>
            
            <label class="lbl-right" style="width:60px; margin-left: 15px;">Curr</label>
            <select name="cmbcurr" id="cmbcurr" style="width:100px;" value='<s:property value="cmbcurr"/>' onchange="getRatevalue1(this.value,$('#nipurchasedate').val());">
                <option value="-1">--Select--</option>
            </select>   

            <label class="lbl-right" style="width:60px; margin-left: 15px;">Rate</label>
            <input type="text" style="width:100px; text-align:right;" name="currate" id="currate" value='<s:property value="currate"/>'>
            <input type="hidden" name="refslno" id="refslno" value='<s:property value="refslno"/>' >  
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Terms & Description</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Del Date</label>
            <div style="width: 120px;">
                <div id="deliverydate" name="deliverydate" value='<s:property value="deliverydate"/>'></div>
                <input type="hidden" name="hiddeliverydate" id="hiddeliverydate" value='<s:property value="hiddeliverydate"/>'>
            </div>
            
            <div id="interdiv" hidden="true" style="margin-left: 15px; display:flex; align-items:center;">
                <input type="checkbox" name="interstate" id="interstate" value='<s:property value="interstate"/>' onclick="$(this).attr('value', this.checked ? 1 : 0);" style="margin:0;">
                <span style="margin-left:4px; font-size:12px; font-weight:bold; color:#444;">Interstate</span>
            </div>
            
            <label class="lbl-right" style="width:80px; margin-left: 15px;">Del Terms</label>
            <input type="text" name="delterms" id="delterms" style="flex:1;" value='<s:property value="delterms"/>'>
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
        <div id="nipurdetails" class="grid-container">
            <jsp:include page="descgridDetails.jsp"></jsp:include>
        </div>
    </div>

    <div style="display:none;">
        <input type="hidden" id="masterdoc_no" name="masterdoc_no"  value='<s:property value="masterdoc_no"/>'/>
        <input type="hidden" id="ordermasterdoc_no" name="ordermasterdoc_no"  value='<s:property value="ordermasterdoc_no"/>'/>
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
        <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>   
        <input type="hidden" id="nettotal" name="nettotal"  value='<s:property value="nettotal"/>'/>
        <input type="hidden" id="rowval" name="rowval"  value='<s:property value="rowval"/>'/>   
        <input type="hidden" id="accdocno" name="accdocno"  value='<s:property value="accdocno"/>'/>  
        <input type="hidden" id="descgridlenght" name="descgridlenght"  value='<s:property value="descgridlenght"/>'/>    
        <input type="hidden" id="cmbcurrval" name="cmbcurrval"  value='<s:property value="cmbcurrval"/>'/>    
        <input type="hidden" id="acctypeval" name="acctypeval"  value='<s:property value="acctypeval"/>'/>  
        <input type="hidden" id="reftypeval" name="reftypeval"  value='<s:property value="reftypeval"/>'/>  
        <input type="hidden" id="validates" name="validates"  value='<s:property value="validates"/>'/> 
        <input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
        <input type="hidden" id="acctypegrid" name="acctypegrid"  value='<s:property value="acctypegrid"/>'/>
        <input type="hidden" id="nidescdetailslenght" name="nidescdetailslenght"  value='<s:property value="nidescdetailslenght"/>'/>  
        <input type="hidden" id="costgropename" name="costgropename"  value='<s:property value="costgropename"/>'/>
        <input type="hidden" id="tarannumber" name="tarannumber"  value='<s:property value="tarannumber"/>'/>
        <input type="hidden" id="hidinterstate" name="hidinterstate"  value='<s:property value="hidinterstate"/>'/>
        <input type="hidden" id="taxpers" name="taxpers"  value='<s:property value="taxpers"/>'/>
        <input type="hidden" id="taxaccount" name="taxaccount"  value='<s:property value="taxaccount"/>'/>
        <input type="hidden" id="hideproducttype" name="hideproducttype"  value='<s:property value="hideproducttype"/>'/>
    </div>

</div>
</form>
  
<div id="accountSearchwindow"><div></div></div>
<div id="accounttypeSearchwindow"><div></div></div>
<div id="costtpesearchwndow"><div></div></div>
<div id="costcodesearchwndow"><div></div></div> 
<div id="refnosearchwindow"><div></div></div> 
<div id=nipurchslnosearch><div></div></div> 
<div id="typesearchwindow"><div></div></div>
    
</div>
</body>
</html>