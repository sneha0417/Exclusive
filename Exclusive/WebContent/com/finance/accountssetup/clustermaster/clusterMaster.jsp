<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script> 

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
          $("#clusterDate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
          
          /* force internal alignment AFTER render */
          setTimeout(function () {
              $("#clusterDate").find("input").css({
                  "margin-top": "0px",
                  "line-height": "24px",
                  "font-size": "12px", 
                  "font-family": "Arial, sans-serif", 
                  "padding": "0 6px", 
                  "box-sizing":"border-box"
              });
              $("#clusterDate").find(".jqx-action-button").css({
                  "top": "0px",
                  "height": "24px"
              });
          }, 0);
          
          /* Searching Window */
         $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
         $('#accountDetailsWindow').jqxWindow('close');
        
        // $('#nationalityWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Nation Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
        // $('#nationalityWindow').jqxWindow('close');
        
         <%-- $('#txtempaccount').dblclick(function(){
              accountSearchContent(<%=contextPath+"/"%>+"com/humanresource/setup/accountsDetailsSearch.jsp");
          });
        
        $('#txtempnationality').dblclick(function(){
            nationalitySearchContent("nationSearchGrid.jsp");
          }); --%>
        
    //    getDesignation();getDepartment();getPayrollCategory();getSalesAgent();
      }); 
      
      function accountSearchContent(url) {
            $('#accountDetailsWindow').jqxWindow('open');
            $.get(url).done(function (data) {
            $('#accountDetailsWindow').jqxWindow('setContent', data);
            $('#accountDetailsWindow').jqxWindow('bringToFront');
        }); 
        }
      
      function nationalitySearchContent(url) {
            $('#nationalityWindow').jqxWindow('open');
            $.get(url).done(function (data) {
            $('#nationalityWindow').jqxWindow('setContent', data);
            $('#nationalityWindow').jqxWindow('bringToFront');
        }); 
        }
      
      function getDesignation() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    items = items.split('####');
                    var designationItems = items[0].split(",");
                    var designationIdItems = items[1].split(",");
                    var optionsdesignation = '<option value="">--Select--</option>';
                    for (var i = 0; i < designationItems.length; i++) {
                        optionsdesignation += '<option value="' + designationIdItems[i] + '">'
                                + designationItems[i] + '</option>';
                    }
                    $("select#cmbempdesignation").html(optionsdesignation);
                    if ($('#hidcmbempdesignation').val() != null) {
                        $('#cmbempdesignation').val($('#hidcmbempdesignation').val());
                    }
                } else {
                }
            }
            x.open("GET", "getDesignation.jsp", true);
            x.send();
        }
      
      function getDepartment() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    items = items.split('####');
                    var departmentItems = items[0].split(",");
                    var departmentIdItems = items[1].split(",");
                    var optionsdepartment = '<option value="">--Select--</option>';
                    for (var i = 0; i < departmentItems.length; i++) {
                        optionsdepartment += '<option value="' + departmentIdItems[i] + '">'
                                + departmentItems[i] + '</option>';
                    }
                    $("select#cmbempdepartment").html(optionsdepartment);
                    if ($('#hidcmbempdepartment').val() != null) {
                        $('#cmbempdepartment').val($('#hidcmbempdepartment').val());
                    }
                } else {
                }
            }
            x.open("GET", "getDepartment.jsp", true);
            x.send();
        }
      
      function getPayrollCategory() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var payrollcategoryItems = items[0].split(",");
                var payrollcategoryIdItems = items[1].split(",");
                var optionspayrollcategory = '<option value="">--Select--</option>';
                for (var i = 0; i < payrollcategoryItems.length; i++) {
                    optionspayrollcategory += '<option value="' + payrollcategoryIdItems[i] + '">'
                            + payrollcategoryItems[i] + '</option>';
                }
                $("select#cmbpayrollcategory").html(optionspayrollcategory);
                if ($('#hidcmbpayrollcategory').val() != null) {
                    $('#cmbpayrollcategory').val($('#hidcmbpayrollcategory').val());
                }
            } else {
            }
        }
        x.open("GET", "getPayrollCategory.jsp", true);
        x.send();
    }
      
      function getSalesAgent() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var salesAgentItems = items[0].split(",");
                var salesAgentIdItems = items[1].split(",");
                var optionssalesagent = '<option value="">--Select--</option>';
                for (var i = 0; i < salesAgentItems.length; i++) {
                    optionssalesagent += '<option value="' + salesAgentIdItems[i] + '">'
                            + salesAgentItems[i] + '</option>';
                }
                $("select#cmbempagentid").html(optionssalesagent);
                if ($('#hidcmbempagentid').val() != null) {
                    $('#cmbempagentid').val($('#hidcmbempagentid').val());
                }
            } else {
            }
        }
        x.open("GET", "getSalesAgent.jsp", true);
        x.send();
    }
      
      function getEmpAccount(event){
          var x= event.keyCode;
          if(x==114){
              accountSearchContent(<%=contextPath+"/"%>+"com/humanresource/setup/accountsDetailsSearch.jsp");
          }
          else{}
          }
      
      $(function(){
        $('#frmClusterMaster').validate({
                rules: {
                txtclustername:"required"
                 },
                 messages: {
                 txtclustername:" *"
                 }
        });});
    
     function funReadOnly(){
            $('#frmClusterMaster input').attr('readonly', true );
            $('#frmClusterMaster select').attr('disabled', true);
            $('#clusterDate').jqxDateTimeInput({disabled: true});
            
            $("#clusterGridID").jqxGrid({ disabled: true});
     }
    
     function funRemoveReadOnly(){
            $('#frmClusterMaster input').attr('readonly', false );
            $('#frmClusterMaster select').attr('disabled', false);
            $('#clusterDate').jqxDateTimeInput({disabled: false});
            $('#docno').attr('readonly', true);
            
            $("#clusterGridID").jqxGrid({ disabled: false});
            
            if ($("#mode").val() == "A") {
                     $('#clusterDate').val(new Date());
                    
                     $("#clusterGridID").jqxGrid('clear'); 
                     $("#clusterGridID").jqxGrid('addrow', null, {});
            }
            
            if ($("#mode").val() == "E") {
                     $("#clusterGridID").jqxGrid('addrow', null, {});
            }
     }
     function funNotify(){  
         /* Validation */
        
        
        
        // document.getElementById("errormsg").innerText="";        
         /* Validation Ends*/
        
         var rows = $("#clusterGridID").jqxGrid('getrows');
         var length=0;
             for(var i=0 ; i < rows.length ; i++){
                var chk=rows[i].doc_no;
                if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
                    length=length+1;
                    newTextBox = $(document.createElement("input"))
                    .attr("type", "dil")
                    .attr("id", "test"+i)
                    .attr("name", "test"+i)
                    .attr("hidden", "true");
            
                    newTextBox.val(rows[i].doc_no);
                    newTextBox.appendTo('form');
             }
            }
         $('#gridlength').val(length);
        
        return 1;       
        } 
    
     function funSearchLoad(){
             changeContent('clmMainSearch.jsp');  
         }
    
     function funFocus(){
        $('#clusterDate').jqxDateTimeInput('focus');            
    }
    
     function setValues(){
        
             if($('#hidclusterDate').val()){
                 $("#clusterDate").jqxDateTimeInput('val', $('#hidclusterDate').val());
              }
            
             if($('#msg').val()!=""){
                   $.messager.alert('Message',$('#msg').val());
                  }
            
             document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
             funSetlabel();
            
             var indexVal = document.getElementById("docno").value;
             if(indexVal> 0){
                 $("#clusterMasterDiv").load("clusterMasterGrid.jsp?docno="+indexVal+"&mode="+$('#mode').val());
             }  
        }
    
     function funChkButton() {
            /* funReset(); */
        }
    
</script>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmClusterMaster" action="saveClusterMaster" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>

    <!-- Panel 1: General Info -->
    <div class="middle-panel">
        <span class="middle-panel-title">General Info</span>
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="clusterDate" name="clusterDate" value='<s:property value="clusterDate"/>'></div>
                <input type="hidden" id="hidclusterDate" name="hidclusterDate" value='<s:property value="hidclusterDate"/>'/>
            </div>
            
            <label class="lbl-right" style="width:60px; margin-left: 15px;">Name</label>
            <input type="text" id="txtclustername" name="txtclustername" placeholder="Name" style="flex:1; max-width: 350px;" value='<s:property value="txtclustername"/>'/>
            
            <label class="lbl-right" style="width:60px; margin-left: auto;">Doc No</label>
            <input type="text" id="docno" name="txtclmmasterdocno" style="width:120px;" tabindex="-1" readonly value='<s:property value="txtclmmasterdocno"/>'/>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Description</label>
            <input type="text" id="txtdescription" name="txtdescription" placeholder="Description" style="flex:1;" value='<s:property value="txtdescription"/>'/>
        </div>
    </div>

    <!-- Panel 2: Cluster Details -->
    <div class="middle-panel">
        <span class="middle-panel-title">Cluster Details</span>
        <div id="clusterMasterDiv" class="grid-container">
            <jsp:include page="clusterMasterGrid.jsp"></jsp:include>
        </div>
    </div>

    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>
        <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
    </div>

</div>
</form>

<div id="accountDetailsWindow"><div></div><div></div></div>  

</div>
</body>
</html>