<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<% String contextPath=request.getContextPath(); %>

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
          /* Date */
          $("#clientDate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
          
          setTimeout(function () {
              $("#clientDate").find("input").css({
                  "margin-top": "0px",
                  "line-height": "24px",
                  "font-size": "12px", 
                  "font-family": "Arial, sans-serif", 
                  "padding": "0 6px", 
                  "box-sizing":"border-box"
              });
              $("#clientDate").find(".jqx-action-button").css({
                  "top": "0px",
                  "height": "24px"
              });
          }, 0);
          
          $('#areainfowindow').jqxWindow({ width: '55%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
          $('#areainfowindow').jqxWindow('close');
          $('#countryinfowindow').jqxWindow({ width: '20%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Country Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
          $('#countryinfowindow').jqxWindow('close');
          $('#activityinfowindow').jqxWindow({ width: '20%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Activity Search' , position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
          $('#activityinfowindow').jqxWindow('close');
          $('#Salesagentinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'SalesMan Search' ,position: { x: 200, y: 120 }, theme: 'energyblue', keyboardCloseKey: 27});
          $('#Salesagentinfowindow').jqxWindow('close');
          
          getGroup();getCategory();getCurrency();getAdditionalInformationAllowed();
          
          $('#txtarea').dblclick(function(){
              $('#areainfowindow').jqxWindow('open');
              areaSearchContent('area.jsp?getarea=0');
              });
          
          $('#txtsalman').dblclick(function(){
              $('#Salesagentinfowindow').jqxWindow('open');
              salesagentSearchContent('SearchSalesman.jsp?', $('#Salesagentinfowindow'));
              });
          
          $('#txtcountry').dblclick(function(){
              $('#countryinfowindow').jqxWindow('open');
              countrySearchContent('country.jsp'); 
              });
      }); 
      
      function getAdditionalInformationAllowed(){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    $('#additionalinformationallowed').val(items);
                    
                  if(parseInt(items)==1){
                    $('#fsAdditionalInformation').show();
                        
                    } else {
                        $('#fsAdditionalInformation').hide();
                    }
            }
            }
            x.open("GET", "getAdditionalInformationAllowed.jsp", true);
            x.send();
    }
      
      function  funReadOnly(){
            $('#frmClientMaster input').attr('disabled', true );             
            $('#frmClientMaster textarea').attr('disabled', true );
            $('#frmClientMaster select').attr('disabled', true);
            $('#cpDetailsGrid').jqxGrid({ disabled: true});
            $('#documentsGridID').jqxGrid({ disabled: true});
            
            $('#mode').attr('disabled', false);
            $('#formdetailcode').attr('disabled', false);
            $('#docno').attr('disabled', false);
        }
      
      function funRemoveReadOnly(){
            getAdditionalInformationAllowed();
          
            $('#frmClientMaster input').attr('disabled', false );
            $('#frmClientMaster textarea').attr('disabled', false );
            $('#frmClientMaster select').attr('disabled', false);
            $('#cpDetailsGrid').jqxGrid({ disabled: false});
            $('#documentsGridID').jqxGrid({ disabled: false});
            $('#txtsalman').attr('readonly',true);
            //$("#cpGridDetails").load('cpGridDetails.jsp?cldocno=0');
            if(document.getElementById("mode").value=='A'){
                document.getElementById("chknontax").checked=true;
                document.getElementById("chkinterserv").checked = false;
                
                document.getElementById("txtcontact").value="NA";
                
                $('#hidchknontax').val(1);
                $('#hidchkinterserv').val(0);
                $("#cpDetailsGrid").jqxGrid('clear');
                $("#cpDetailsGrid").jqxGrid("addrow", null, {});
                $("#documentsGridID").jqxGrid('clear'); 
                $("#documentsGridID").jqxGrid('addrow', null, {});
                document.getElementById("txtcredit_period_max").value=0.0;
                document.getElementById("txtcredit_period_min").value=0.0;
                document.getElementById("txtcredit_limit").value=0.0;
                
                $("#documentsDiv").load("documentsGrid.jsp?mode="+$("#mode").val());
            }
            if ($("#mode").val() == "E") {
                 $("#documentsGridID").jqxGrid('addrow', null, {});
                 
                 var indexVal = document.getElementById("docno").value;
                 if(indexVal> 0){
                    $("#documentsDiv").load("documentsGrid.jsp?docno="+indexVal+"&mode="+$("#mode").val());
                 }
            }
            getclintvldconfig();
      }
      
      function funSearchLoad(){
        changeContent('masterSearch.jsp', $('#window'));
      }
      
      function getareas(event){
         var x= event.keyCode;
         if(x==114){
                $('#areainfowindow').jqxWindow('open');
                areaSearchContent('area.jsp?getarea=0');    
                
         } else{}
      }
                 
     function areaSearchContent(url) {
             $.get(url).done(function (data) {
             $('#areainfowindow').jqxWindow('setContent', data);
             }); 
     }
 
 function getcountry(event){
     var x= event.keyCode;
     if(x==114){
      $('#countryinfowindow').jqxWindow('open');
            countrySearchContent('country.jsp');     }
     else{
         }
             }

            
function countrySearchContent(url) {
     $.get(url).done(function (data) {
    $('#countryinfowindow').jqxWindow('setContent', data);

                    }); 
        }
        
 function getCurrency()
    {
            
            
        var x=new XMLHttpRequest();
        var items,currIdItems,mcloseItems,currCodeItems;
        x.onreadystatechange=function(){
            if (x.readyState==4 && x.status==200)
                {
                    items= x.responseText;
                    items=items.split('####');
                    currIdItems=items[0].split(",");
                    currCodeItems=items[1].split(",");
                    
                    var optionscurr = '';  
                    for ( var i = 0; i < currCodeItems.length; i++) {
                               optionscurr += '<option value="' + currIdItems[i] + '">' + currCodeItems[i] + '</option>';
                        }
                    $("select#currencyid").html(optionscurr);
                    window.parent.monthclosed.value=mcloseItems;
                    
                }
            else
                {
                }
            
            if($('#hidcmbcurrencyid').val()){
                $("#currencyid").val($('#hidcmbcurrencyid').val());
            }
        }
        x.open("GET","getCurrency.jsp",true);
        x.send();
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
                    optionsgroup += '<option value="' + groupIdItems[i] + '">'
                            + groupItems[i] + '</option>';
                }
                $("select#cmbacgroup").html(optionsgroup);
                
            } else {
            }
            if ($('#hidcmbacgroup').val() != null) {
                $('#cmbacgroup').val($('#hidcmbacgroup').val());
            }
        }
        x.open("GET", "getGroup.jsp", true);
        x.send();
    }
 
 function getCategoryAccountGroup(a) {
    
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText.trim();
                $('#hidcmbacgroup').val(items);
                
                if ($('#hidcmbgroup1').val() != null || $('#hidcmbacgroup').val() != "") {
                    $('#cmbacgroup').val($('#hidcmbacgroup').val());
                }
            } else {
            }
        }
        x.open("GET", "getCategoryAccountGroup.jsp?category="+a, true);
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
                    optionscategory += '<option value="' + categoryIdItems[i] + '">'
                            + categoryItems[i] + '</option>';
                }
                $("select#cmbcategory").html(optionscategory);
                
            } else {
            }
            if ($('#hidcmbcategory').val() != null) {
                $('#cmbcategory').val($('#hidcmbcategory').val());
            }
        }
        x.open("GET", "getCategory.jsp", true);
        x.send();
    }


 
 function funFocus(){
     document.getElementById("txtclient_name").focus();  
 }
 
 function taxableentitycheck() {
     if(document.getElementById("chknontax").checked){
             document.getElementById("hidchknontax").value = 1;
     }
     else{
         document.getElementById("hidchknontax").value = 0;
     }
 }
 
 function interstateservicecheck() {
     if(document.getElementById("chkinterserv").checked){
             document.getElementById("hidchkinterserv").value = 1;
     }
     else{
         document.getElementById("hidchkinterserv").value = 0;
     }
 }
 
 function mobileValid(value){
       if(value!=""){ 
        var phoneno = /^\d{12}$/;  
        if(value.match(phoneno)){
            document.getElementById("errormsg").innerText="";
            return true;
        }
        else{
            document.getElementById("errormsg").innerText="Invalid Mobile Number";
            return false;
        }
        } 
       return true;
}
 
 function validateEmail($email) {
      var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
      if(emailReg.test( $email )){
          document.getElementById("errormsg").innerText="";
            return true;
        }
        else{
            document.getElementById("errormsg").innerText="Email Address Not Valid";
            return false;
        }
      return true;
    }
 
 
 function vaildMail(emailaddress){
     if( !validateEmail(emailaddress)) 
     { 
         document.getElementById("errormsg").innerText="Email Address Not Valid";
         return false;
        
     }
     else{
         document.getElementById("errormsg").innerText="";
     }
     return true;
 }
 
 
 
 
 function funNotify(){  

        var txtclient=document.getElementById("txtclient_name").value;
        var currency=document.getElementById("currencyid").value;
        var tin=document.getElementById("txttinno").value;
        var cst=document.getElementById("txtcstno").value;
        var check=$("#clintvld").val();
        if(txtclient=="")
        {
        document.getElementById("errormsg").innerText=" Enter Client Name";
        document.getElementById("txtclient_name").focus();  
        return 0;
        }
        if(check=="1"){  
        var txtaddress=document.getElementById("txtaddress").value;
        if(txtaddress=="")
        {
        document.getElementById("errormsg").innerText=" Enter Address";
        document.getElementById("txtaddress").focus();
        return 0;
        }
        var txtmobile=document.getElementById("txtmobile").value;
        if(txtmobile=="")
        {
        document.getElementById("errormsg").innerText=" Enter Mobile";
        document.getElementById("txtmobile").focus();
        return 0;
        }
        }
          
        
        
        if(!mobileValid($("#txtmobile").val())){
             return 0;
         }
        if(!validateEmail($("#txtemail").val())){
             return 0;
         }

        var rows = $("#cpDetailsGrid").jqxGrid('getrows');
        var len=0;
        for(var i=0;i<rows.length;i++){
            var cpersion= $.trim(rows[i].cpersion);
            if(cpersion.trim()!="" && typeof(cpersion)!="undefined" && typeof(cpersion)!="NaN" )
                {
                newTextBox = $(document.createElement("input"))
                       .attr("type", "dil")
                       .attr("id", "test"+len)
                       .attr("name", "test"+len)
                       .attr("hidden", "true");
           newTextBox.val(rows[i].cpersion+"::"+rows[i].mobile+" :: "+rows[i].phone+" :: "+rows[i].extn+" :: "
                    +rows[i].email+" :: "+rows[i].area+" :: "+rows[i].areaid+" :: "+rows[i].activity_id+"");
           newTextBox.appendTo('form'); 
           len=len+1;
                 }
           }
           $('#cpgridlength').val(len);
           
           var rows = $("#documentsGridID").jqxGrid('getrows');
             var documentslength=0,j=0;
                 for(var i=0 ; i < rows.length ; i++){
                    var chkng=rows[i].documentno;
                    if(chkng!="" && typeof(chkng)!="undefined" && typeof(chkng)!="NaN" ){  
                        documentslength=documentslength+1;
                        newTextBox = $(document.createElement("input"))
                        .attr("type", "dil")
                        .attr("id", "txtdocuments"+j)
                        .attr("name", "txtdocuments"+j)   
                        .attr("hidden", "true");
                        var issueDate = $('#documentsGridID').jqxGrid('getcelltext', i, 'issue_date');
                        var expDate = $('#documentsGridID').jqxGrid('getcelltext', i, 'exp_date');
                        newTextBox.val(rows[i].documentid+" :: "+issueDate+" :: "+expDate+":: "+rows[i].place_of_issue+":: "+
                                0+":: "+rows[i].remarks+":: "+rows[i].documentno);
                        newTextBox.appendTo('form');
                        j++;
                    }
                 }
             $('#documentsgridlength').val(documentslength);
             return 1;
 }
 
 
 function setValues() {
     
     document.getElementById("formdetail").value="Client";
     document.getElementById("formdetailcode").value="CRM";
     document.getElementById("formdet").innerText="Client(CRM)";
     window.parent.formCode.value="CRM";
     window.parent.formName.value="Client"; 
    
     if(document.getElementById("hidchknontax").value==1){
             document.getElementById("chknontax").checked = true;
     }
     else if(document.getElementById("hidchknontax").value==0){
        document.getElementById("chknontax").checked = false;
     }
    
     if(document.getElementById("hidchkinterserv").value==1){
         document.getElementById("chkinterserv").checked = true;
     }
     else if(document.getElementById("hidchkinterserv").value==0){
        document.getElementById("chkinterserv").checked = false;
     }
    
      var maindoc=document.getElementById("txtcode").value;
      if(maindoc>0) {
        var indexVal1 = document.getElementById("txtcode").value;
        $("#cpGridDetails").load('cpGridDetails.jsp?cldocno='+indexVal1);
      }
      
        if(!($('#hidcmbcurrencyid').val()=="")){
            $("#currencyid").val($('#hidcmbcurrencyid').val());
        }
        
  
       if($('#msg').val()!=""){
           $.messager.alert('Message',$('#msg').val());
           
          }
       
     delvalueChange();
    var indexVal = document.getElementById("docno").value;
     if(indexVal> 0){
         $("#documentsDiv").load("documentsGrid.jsp?docno="+indexVal);
     }
 }
 
 function delvalueChange()
 {

      
 }
 
 
 function getsalesAgent(event){
         var x= event.keyCode;
         if(x==114){
          $('#Salesagentinfowindow').jqxWindow('open');
     
       
      salesagentSearchContent('SearchSalesman.jsp?', $('#Salesagentinfowindow')); }
         else{
             }
         }

  function salesagentSearchContent(url) {
                 $.get(url).done(function (data) {
        //alert(data);
               $('#Salesagentinfowindow').jqxWindow('setContent', data);

        }); 
   }

     function getinterservconfig(){
    
        $("#interid").hide();
            var x=new XMLHttpRequest();
            x.onreadystatechange=function(){
            if (x.readyState==4 && x.status==200)
                {
                    var res= x.responseText;
                    
                    if(res>0){
                        
                         $("#interid").show();
                          }
                    }
                   else
                  {}
             }
              x.open("GET",'interservconfig.jsp',true);
             x.send();
            
           }   
           
      function getclintvldconfig(){
            var x=new XMLHttpRequest();
            x.onreadystatechange=function(){
            if (x.readyState==4 && x.status==200)
                {
                    var res= x.responseText;
                    if(res>0){
                         $("#clintvld").val("1");
                          }else{
                     $("#clintvld").val("0");  
                    }
                }
                   else
                  {}
             }
              x.open("GET",'clintvldconfig.jsp',true);
             x.send();
            
           }   
</script>

</head>
<body onload="setValues();getinterservconfig();getclintvldconfig();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmClientMaster" action="clientmaster" method="post" autocomplete="off">

<jsp:include page="../../../../header.jsp"></jsp:include>
   
<div class='modern-ui hidden-scrollbar'>
    
    <div class="middle-panel">
        <span class="middle-panel-title">General Info</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 120px;">
                <div id="clientDate" name="clientDate" value='<s:property value="clientDate"/>'></div>
                <input type="hidden" id="hidClientDate" name="hidClientDate" value='<s:property value="hidClientDate"/>'/>
            </div>
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Code</label>
            <input type="text" id="txtcode" readonly name="txtcode" style="width:80px;" tabindex="-1" value='<s:property value="txtcode"/>'/>
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Name</label>
            <input type="text" id="txtclient_name" name="txtclient_name" style="flex:1; max-width:350px;" value='<s:property value="txtclient_name"/>'/>
            
            <label class="lbl-right" style="width:60px; margin-left:auto;">Currency</label>
            <select id="currencyid" name="currencyid" style="width:100px;" value='<s:property value="currencyid"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbcurrencyid" name="hidcmbcurrencyid" value='<s:property value="hidcmbcurrencyid"/>'/>
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Doc No.</label>
            <input type="text" id="docno" readonly name="docno" style="width:100px;" tabindex="-1" value='<s:property value="docno"/>'/>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Category</label>
            <select id="cmbcategory" name="cmbcategory" style="width:120px;" onchange="getCategoryAccountGroup(this.value);" value='<s:property value="cmbcategory"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">Acc Group</label>
            <select id="cmbacgroup" name="cmbacgroup" style="width:150px;" value='<s:property value="cmbacgroup"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbacgroup" name="hidcmbacgroup" value='<s:property value="hidcmbacgroup"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">Sales Man</label>
            <div class="input-search-container" style="flex:1; max-width:250px;">
                <input type="text" id="txtsalman" name="txtsalman" placeholder="Press F3" value='<s:property value="txtsalman"/>' onKeyDown=" getsalesAgent(event);"/>
                <svg class="magnifier-icon" onclick="$('#Salesagentinfowindow').jqxWindow('open'); salesagentSearchContent('SearchSalesman.jsp?', $('#Salesagentinfowindow'));" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <label class="lbl-right" style="width:60px; margin-left:auto;">Account</label>
            <input type="text" id="txtaccount" readonly name="txtaccount" style="width:100px;" tabindex="-1" value='<s:property value="txtaccount"/>'/>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">TRN No</label>
            <input type="text" id="txttinno" name="txttinno" style="width:150px;" value='<s:property value="txttinno"/>'/>
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">CST No</label>
            <input type="text" id="txtcstno" name="txtcstno" style="width:150px;" value='<s:property value="txtcstno"/>'/>
            
            <label class="lbl-right" style="width:150px; margin-left:auto;">Credit Period Min(Days)</label>
            <input type="text" id="txtcredit_period_min" name="txtcredit_period_min" style="width:60px; text-align: right;" value='<s:property value="txtcredit_period_min"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">Max(Days)</label>
            <input type="text" id="txtcredit_period_max" name="txtcredit_period_max" style="width:60px; text-align: right;" value='<s:property value="txtcredit_period_max"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">Credit Limit</label>
            <input type="text" id="txtcredit_limit" name="txtcredit_limit" style="width:100px; text-align: right;" value='<s:property value="txtcredit_limit"/>'/>
        </div>
        
        <div class="field-row" style="margin-bottom:0;">
            <label style="display:flex; align-items:center; gap:4px; font-weight:bold; font-size:12px; cursor:pointer;">
                <input type="checkbox" name="chknontax" id="chknontax" onchange="taxableentitycheck();" value='<s:property value="chknontax" />' onclick="$(this).attr('value', this.checked ? 1 : 0);" style="margin:0; width:auto; height:auto!important;">
                Taxable Entity
            </label>
            <input type="hidden" id="hidchknontax" name="hidchknontax" value='<s:property value="hidchknontax"/>'/>
            
            <span id="interid" style="margin-left: 15px;">
                <label style="display:flex; align-items:center; gap:4px; font-weight:bold; font-size:12px; cursor:pointer;">
                    <input type="checkbox" name="chkinterserv" id="chkinterserv" onchange="interstateservicecheck();" value='<s:property value="chkinterserv" />' onclick="$(this).attr('value', this.checked ? 1 : 0);" style="margin:0; width:auto; height:auto!important;">
                    Inter State Service
                </label>
            </span>
            <input type="hidden" id="hidchkinterserv" name="hidchkinterserv" value='<s:property value="hidchkinterserv"/>'/>
        </div>
    </div>

    <!-- Additional Information -->
    <div class="middle-panel" id="fsAdditionalInformation">
        <span class="middle-panel-title">Additional Information</span>
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:100px;">Financial Name</label>
            <input type="text" id="txtfinname" name="txtfinname" style="width:250px;" value='<s:property value="txtfinname"/>'/>
            
            <label class="lbl-right" style="width:120px; margin-left:15px;">Financial Address</label>
            <input type="text" id="txtfinaddress" name="txtfinaddress" style="flex:1;" value='<s:property value="txtfinaddress"/>'/>
        </div>
    </div>

    <!-- Split layout for Communication & Bank Info -->
    <div style="display:flex; gap:15px;">
        <!-- Communication Details -->
        <div class="middle-panel" style="flex:1;">
            <span class="middle-panel-title">Communication Details</span>
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Address</label>
                <input type="text" id="txtaddress" name="txtaddress" style="flex:1;" value='<s:property value="txtaddress"/>'/>
            </div>
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Extn. No.</label>
                <input type="text" id="txtextnno" name="txtextnno" style="width:100px;" value='<s:property value="txtextnno"/>'/>
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Telephone</label>
                <input type="text" id="txttelephone" name="txttelephone" style="width:150px;" value='<s:property value="txttelephone"/>'/>
            </div>
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Mobile</label>
                <input type="text" id="txtmobile" name="txtmobile" style="flex:1; max-width:200px;" onblur="mobileValid(this.value);" placeholder="Mobile number with country code" value='<s:property value="txtmobile"/>'/>
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Fax</label>
                <input type="text" id="txtfax" name="txtfax" style="width:150px;" value='<s:property value="txtfax"/>'/>
            </div>
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Email</label>
                <input type="text" id="txtemail" name="txtemail" placeholder="someone@example.com" onblur="validateEmail(this.value);" style="flex:1;" value='<s:property value="txtemail"/>'/>
            </div>
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Web</label>
                <input type="text" id="txtweb" name="txtweb" style="flex:1;" value='<s:property value="txtweb"/>'/>
            </div>
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Contact</label>
                <input type="text" id="txtcontact" name="txtcontact" style="flex:1;" value='<s:property value="txtcontact"/>'/>
            </div>
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Area</label>
                <div class="input-search-container" style="flex:1; max-width:180px;">
                    <input type="text" id="txtarea" name="txtarea" readonly placeholder="Press F3" value='<s:property value="txtarea"/>' onKeyDown="getareas(event);"/>
                    <svg class="magnifier-icon" onclick="$('#areainfowindow').jqxWindow('open'); areaSearchContent('area.jsp?getarea=0');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                <input type="text" id="txtareadet" name="txtareadet" readonly style="flex:1; margin-left:15px;" value='<s:property value="txtareadet"/>'/>
                <input type="hidden" id="txtareaid" name="txtareaid" value='<s:property value="txtareaid"/>'/>
            </div>
        </div>
        
        <!-- Bank Information -->
        <div class="middle-panel" style="flex:1;">
            <span class="middle-panel-title">Bank Information</span>
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Account No.</label>
                <input type="text" id="txtaccountno" name="txtaccountno" style="flex:1;" value='<s:property value="txtaccountno"/>'/>
            </div>
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Bank Name</label>
                <input type="text" id="txtbankname" name="txtbankname" style="flex:1;" value='<s:property value="txtbankname"/>'/>
            </div>
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Branch Name</label>
                <input type="text" id="txtbranchname" name="txtbranchname" style="flex:1;" value='<s:property value="txtbranchname"/>'/>
            </div>
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Branch Address</label>
                <input type="text" id="txtbranchaddress" name="txtbranchaddress" style="flex:1;" value='<s:property value="txtbranchaddress"/>'/>
            </div>
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Swift No.</label>
                <input type="text" id="txtswiftno" name="txtswiftno" style="flex:1;" value='<s:property value="txtswiftno"/>'/>
                
                <label class="lbl-right" style="width:80px; margin-left:15px;">IBAN No.</label>
                <input type="text" id="txtibanno" name="txtibanno" style="flex:1;" value='<s:property value="txtibanno"/>'/>
            </div>
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:100px;">City</label>
                <input type="text" id="txtcity" name="txtcity" style="flex:1;" value='<s:property value="txtcity"/>'/>
                
                <label class="lbl-right" style="width:80px; margin-left:15px;">Country</label>
                <div class="input-search-container" style="flex:1;">
                    <input type="text" id="txtcountry" name="txtcountry" placeholder="Press F3" value='<s:property value="txtcountry"/>' readonly="true" onKeyDown="getcountry(event);"/>
                    <svg class="magnifier-icon" onclick="$('#countryinfowindow').jqxWindow('open'); countrySearchContent('country.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
            </div>
        </div>
    </div>

    <!-- Contact Person Details Grid -->
    <div class="middle-panel">
        <span class="middle-panel-title">Contact Person Details</span>
        <div id="cpGridDetails" class="grid-container" style="border:none;">
            <jsp:include page="cpGridDetails.jsp"></jsp:include>
        </div>
    </div>

    <!-- Documents Details Grid -->
    <div class="middle-panel">
        <span class="middle-panel-title">Documents Details</span>
        <div id="documentsDiv" class="grid-container" style="border:none;">
            <jsp:include page="documentsGrid.jsp"></jsp:include>
        </div>
    </div>
    
    <!-- Hidden Fields Container -->
    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
        <input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
        <input type="hidden" id="cpgridlength" name="cpgridlength"/>
        <input type="hidden" id="cityid" name="cityid" value='<s:property value="cityid"/>'/>
        <input type="hidden" id="countryid" name="countryid" value='<s:property value="countryid"/>'/>
        <input type="hidden" id="salid" name="salid" value='<s:property value="salid"/>'/>
        <input type="hidden" id="additionalinformationallowed" name="additionalinformationallowed"  value='<s:property value="additionalinformationallowed"/>'/>
        <input type="hidden" id="documentsgridlength" name="documentsgridlength" value='<s:property value="documentsgridlength"/>'/>
        <input type="hidden" id="clintvld" name="clintvld" value='<s:property value="clintvld"/>'/>
    </div>
    
</div>
</form>

<!-- Modal Windows -->
<div id="areainfowindow"><div></div></div>
<div id="countryinfowindow"><div></div></div>
<div id="activityinfowindow"><div></div></div>
<div id="Salesagentinfowindow"><div></div></div>

</div>

</body>
</html>