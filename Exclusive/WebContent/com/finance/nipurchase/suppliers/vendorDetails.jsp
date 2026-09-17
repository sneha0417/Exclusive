<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
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

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui input[type="email"],
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
.modern-ui input[type="email"]:focus,
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
	     $("#jqxVendorDate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
	     
	     /* force internal alignment AFTER render */
		 setTimeout(function () {
		     $("#jqxVendorDate").find("input").css({
		         "margin-top": "0px",
		         "line-height": "24px",
                 "font-size": "12px", 
                 "font-family": "Arial, sans-serif", 
                 "padding": "0 6px", 
                 "box-sizing":"border-box"
		     });
		     $("#jqxVendorDate").find(".jqx-action-button").css({
		         "top": "0px",
		         "height": "24px"
		     });
		 }, 0);
	  
		 getCurrencyIds();getCategory();getGroup();getTypeAllowed();getType();
	});  
	
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
 				$("select#cmbaccgroup").html(optionsgroup);
 				if ($('#hidcmbaccgroup').val() != null) {
 					$('#cmbaccgroup').val($('#hidcmbaccgroup').val());
 				}
 			} else {
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
 					optionscategory += '<option value="' + categoryIdItems[i] + '">'
 							+ categoryItems[i] + '</option>';
 				}
 				$("select#cmbcategory").html(optionscategory);
 				if ($('#hidcmbcategory').val() != null) {
					$('#cmbcategory').val($('#hidcmbcategory').val());
				}
 			} else {
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
 					optionstype += '<option value="' + typeIdItems[i] + '">'
 							+ typeItems[i] + '</option>';
 				}
 				$("select#cmbtype").html(optionstype);
 				if ($('#hidcmbtype').val() != null) {
 					$('#cmbtype').val($('#hidcmbtype').val());
 				}
 			} else {
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
 			    	document.getElementById("lbltrnnoentity").style.display = 'inline-block';
 			    	$('#cmbtype').attr('hidden', false);
 			    	$('#txtregisteredtrnno').attr('hidden', false);
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
 			} else {
 			}
 		}
 		x.open("GET", "getCategoryAccountGroup.jsp?category="+a, true);
 		x.send();
 	} 
      
	function getCurrencyIds(){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
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
				     
			   }
		
		       else{
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
      
	 function funReadOnly(){
			$('#frmVendorDetails input').attr('readonly', true );
		    $('#frmVendorDetails select').attr('disabled', true); 
			$('#jqxVendorDate').jqxDateTimeInput({disabled: true});
	 }
	 
	 function funRemoveReadOnly(){
		    getCurrencyIds();getTypeAllowed();
		    
			$('#frmVendorDetails input').attr('readonly', false );
			$('#frmVendorDetails select').attr('disabled', false); 
			$('#jqxVendorDate').jqxDateTimeInput({disabled: false});
			$('#txtaccount').attr('readonly', true);
			$('#txtcode').attr('readonly', true);
			$('#cmbaccgroup').attr('disabled', true);
			$('#docno').attr('readonly', true);
			$('#cmbtype').val("1");		$('#hidcmbtype').val("1");		

			if ($("#mode").val() == "A") {
				$('#jqxVendorDate').val(new Date());
			}
	 }
	 function funNotify(){	
		 
		 if(parseInt($('#typeallowed').val())==1) {
			 var taxtype=document.getElementById("cmbtype").value;
			 if(taxtype.trim()==''){
				 document.getElementById("errormsg").innerText="Type is Mandatory.";
				 return 0;
			 }
			 
			 if($('#cmbtype').find('option:selected').text()=='Registered'){
				 var registeredtrnno=document.getElementById("txtregisteredtrnno").value;
				 if(registeredtrnno.trim()==''){
					 document.getElementById("errormsg").innerText="TRN No. is Mandatory for Registered.";
					 return 0;
				 } 
			 }
		 }
		 
		 vendorname=document.getElementById("txtvendorname").value;
		 docno=document.getElementById("docno").value;
		 mode=document.getElementById("mode").value;
		 getVendorAlreadyExists(vendorname,docno,mode);
		} 
	 
	 function funSearchLoad(){
			changeContent('vndMainSearch.jsp'); 
		 }
	 
	 function funFocus()
	    {
	    	$('#jqxVendorDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 function setValues(){
		 getCurrencyIds();
		 
		 if($('#hidjqxVendorDate').val()){
			 $("#jqxVendorDate").jqxDateTimeInput('val', $('#hidjqxVendorDate').val());
		  }
		 
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		 funSetlabel();
		 
		}
	 
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 /* Validations */
	 $(function(){
	        $('#frmVendorDetails').validate({
	                rules: {
	                txtvendorname:"required",
	                cmbcurrency:"required",
	                cmbcategory:"required",
	                cmbaccgroup:"required"
	                 },
	                 messages: {
	                 txtvendorname:" *",
	                 cmbcurrency:" *",
	                 cmbcategory:" *",
	                 cmbaccgroup:" *"
	                 }
	        });});
	 
	 function funExcelBtn(){
		    var url=document.URL;
		    var reurl=url.split("suppliers");
		    top.addTab("VendorList",reurl[0]+"suppliers/vendorList.jsp");
		}
	 
</script>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmVendorDetails" action="saveVendorDetails" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>

    <div class="middle-panel">
        <span class="middle-panel-title">General Info</span>
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 120px;">
                <div id="jqxVendorDate" name="jqxVendorDate" value='<s:property value="jqxVendorDate"/>'></div>
                <input type="hidden" id="hidjqxVendorDate" name="hidjqxVendorDate" value='<s:property value="hidjqxVendorDate"/>'/>
            </div>
            
            <label class="lbl-right" style="width:60px; margin-left: 15px;">Code</label>
            <input type="text" id="txtcode" name="txtcode" style="width:120px;" tabindex="-1" readonly value='<s:property value="txtcode"/>'/>
            
            <label class="lbl-right" style="width:60px; margin-left: 15px;">Name</label>
            <input type="text" id="txtvendorname" name="txtvendorname" style="flex:1; max-width:350px;" value='<s:property value="txtvendorname"/>'/>
            
            <label class="lbl-right" style="width:60px; margin-left: auto;">Doc No.</label>
            <input type="text" id="docno" name="txtvendordocno" style="width:120px;" tabindex="-1" readonly value='<s:property value="txtvendordocno"/>'/>
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Classification</span>
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Currency</label>
            <select id="cmbcurrency" name="cmbcurrency" style="width:120px;" value='<s:property value="cmbcurrency"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left: 15px;">Category</label>
            <select id="cmbcategory" name="cmbcategory" style="width:160px;" onchange="getCategoryAccountGroup(this.value);" value='<s:property value="cmbcategory"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/>
            
            <label class="lbl-right" id="lbltypeentity" style="width:80px; margin-left: 15px;">Type</label>
            <select id="cmbtype" name="cmbtype" style="width:120px;" value='<s:property value="cmbtype"/>'></select>
            <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/>
            
            <label class="lbl-right" id="lbltrnnoentity" style="width:80px; margin-left: 15px;">TRN No.</label>
            <input type="text" id="txtregisteredtrnno" name="txtregisteredtrnno" style="width:150px;" value='<s:property value="txtregisteredtrnno"/>'/>
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Account & Credit Settings</span>
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:100px;">Account Group</label>
            <select id="cmbaccgroup" name="cmbaccgroup" style="width:200px;" value='<s:property value="cmbaccgroup"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbaccgroup" name="hidcmbaccgroup" value='<s:property value="hidcmbaccgroup"/>'/>
            
            <label class="lbl-right" style="width:60px; margin-left: 15px;">Account</label>
            <input type="text" id="txtaccount" name="txtaccount" style="width:120px;" value='<s:property value="txtaccount"/>' tabindex="-1" readonly/>
            
            <label class="lbl-right" style="width:150px; margin-left: auto;">Credit Period Min(Days)</label>
            <input type="text" id="txtcredit_period_min" name="txtcredit_period_min" style="width:60px; text-align: right;" value='<s:property value="txtcredit_period_min"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left: 15px;">Max(Days)</label>
            <input type="text" id="txtcredit_period_max" name="txtcredit_period_max" style="width:60px; text-align: right;" value='<s:property value="txtcredit_period_max"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left: 15px;">Credit Limit</label>
            <input type="text" id="txtcredit_limit" name="txtcredit_limit" style="width:100px; text-align: right;" value='<s:property value="txtcredit_limit"/>'/>
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Contact Details</span>
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Address</label>
            <input type="text" id="txtaddress" name="txtaddress" style="flex:1;" value='<s:property value="txtaddress"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left: 15px;">Address 2</label>
            <input type="text" id="txtaddress1" name="txtaddress1" style="flex:1;" value='<s:property value="txtaddress1"/>'/>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Tel</label>
            <input type="text" id="txttel" name="txttel" style="width:180px;" value='<s:property value="txttel"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left: 15px;">Mob</label>
            <input type="text" id="txtmob" name="txtmob" style="width:180px;" onblur="getMobileNoAlreadyExists(this.value,$('#docno').val(),$('#mode').val());" value='<s:property value="txtmob"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left: auto;">Office No.</label>
            <input type="text" id="txtoffice" name="txtoffice" style="width:180px;" value='<s:property value="txtoffice"/>'/>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Fax</label>
            <input type="text" id="txtfax" name="txtfax" style="width:180px;" value='<s:property value="txtfax"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left: 15px;">Email</label>
            <input type="email" id="txtemail" name="txtemail" style="flex:1; max-width: 470px;" placeholder="someone@example.com" value='<s:property value="txtemail"/>'/>
        </div>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Contact</label>
            <input type="text" id="txtcontact" name="txtcontact" style="width:250px;" value='<s:property value="txtcontact"/>'/>
            
            <label class="lbl-right" style="width:80px; margin-left: 15px;">Extn. No.</label>
            <input type="text" id="txtextno" name="txtextno" style="width:120px;" value='<s:property value="txtextno"/>'/>
        </div>
    </div>

    <!-- Hidden Fields Required by Backend -->
    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
        <input type="hidden" id="txtmobilevalidation" name="txtmobilevalidation" value='<s:property value="txtmobilevalidation"/>'/>
        <input type="hidden" id="typeallowed" name="typeallowed" value='<s:property value="typeallowed"/>'/>
    </div>

</div>
</form>
</div>
</body>
</html>