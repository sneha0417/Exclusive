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

<script type="text/javascript">
     
	$(document).ready(function () {
	  	 /* Date */
	 	 $("#jqxVendorDate").jqxDateTimeInput({ width: '80%', height: '15px', formatString:"dd.MM.yyyy"});
	  
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
	                cmbaccgroup:"required",
	                //txtmob: {"required":true,digits:true,maxlength:12,minlength:12},
	                 
	                 },
	                 messages: {
	                 txtvendorname:" *",
	                 cmbcurrency:" *",
	                 cmbcategory:" *",
	                 cmbaccgroup:" *",
	                 //txtmob: {required:" *",digits:" Invalid Mobile Number",maxlength:" Maximum 12 Digits",minlength:" Please Enter 12 Digits"},
	                 }
	        });});
	 
	 function funExcelBtn(){
		    var url=document.URL;
		    var reurl=url.split("suppliers");
		    top.addTab("VendorList",reurl[0]+"suppliers/vendorList.jsp");
		}
	 
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmVendorDetails" action="saveVendorDetails" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>
   
<div class='hidden-scrollbar'>
<fieldset>
<table width="100%">
  <tr>
    <td width="5%" align="right">Date</td>
    <td width="15%"><div id="jqxVendorDate" name="jqxVendorDate" value='<s:property value="jqxVendorDate"/>'></div>
    <input type="hidden" id="hidjqxVendorDate" name="hidjqxVendorDate" value='<s:property value="hidjqxVendorDate"/>'/></td>
    <td width="7%" align="right">Code</td>
    <td width="20%"><input type="text" id="txtcode" name="txtcode" style="width:60%;" tabindex="-1" value='<s:property value="txtcode"/>'/></td>
    <td width="5%" align="right">Name</td>
    <td width="25%"><input type="text" id="txtvendorname" name="txtvendorname" style="width:100%;" value='<s:property value="txtvendorname"/>'/></td>
    <td width="6%" align="right">Doc No</td>
    <td width="17%"><input type="text" id="docno" name="txtvendordocno" style="width:75%;" tabindex="-1" value='<s:property value="txtvendordocno"/>'/></td>
  </tr>
  <tr>
    <td align="right">Currency</td>
    <td><select id="cmbcurrency" name="cmbcurrency" style="width:60%;" value='<s:property value="cmbcurrency"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/></td>
    <td align="right">Category</td>
    <td><select id="cmbcategory" name="cmbcategory" style="width:100%;" onchange="getCategoryAccountGroup(this.value);" value='<s:property value="cmbcategory"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/></td>
    <td align="right"><label id="lbltypeentity">Type</label></td>
    <td><select id="cmbtype" name="cmbtype" style="width:70%;" value='<s:property value="cmbtype"/>'>
      </select>
      <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/></td>
    <td align="right"><label id="lbltrnnoentity">TRN No.</label></td>
    <td><input type="text" id="txtregisteredtrnno" name="txtregisteredtrnno" style="width:75%;" value='<s:property value="txtregisteredtrnno"/>'/></td>
  </tr>
</table>
</fieldset><br/>

<fieldset>
<table width="100%">
  <tr>
    <td width="6%" align="right">Account Group</td>
    <td width="26%"><select id="cmbaccgroup" name="cmbaccgroup"  style="width:80%;" value='<s:property value="cmbaccgroup"/>'>
      <option value="">--Select--</option></select>
       <input type="hidden" id="hidcmbaccgroup" name="hidcmbaccgroup" value='<s:property value="hidcmbaccgroup"/>'/></td>
    <td width="5%" align="right">Account</td>
    <td width="14%"><input type="text" id="txtaccount" name="txtaccount" style="width:70%;" value='<s:property value="txtaccount"/>' tabindex="-1"/></td>
    <td width="10%" align="right">Credit Period-Min(Days)</td>
    <td width="10%"><input type="text" id="txtcredit_period_min" name="txtcredit_period_min" style="width:50%;text-align: right;" value='<s:property value="txtcredit_period_min"/>'/></td>
    <td width="7%" align="right">Max(Days)</td>
    <td width="8%"><input type="text" id="txtcredit_period_max" name="txtcredit_period_max" style="width:50%;text-align: right;" value='<s:property value="txtcredit_period_max"/>'/></td>
    <td width="6%" align="right">Credit Limit</td>
    <td width="10%"><input type="text" id="txtcredit_limit" name="txtcredit_limit" style="width:50%;text-align: right;" value='<s:property value="txtcredit_limit"/>'/></td>
  </tr>
</table>
</fieldset><br/>

<fieldset>
<table width="100%">
  <tr>
    <td width="9%" align="right">Address</td>
    <td width="27%"><input type="text" id="txtaddress" name="txtaddress" style="width:90%;" value='<s:property value="txtaddress"/>'/></td>
    <td width="6%" align="right">Address 2</td>
    <td colspan="3"><input type="text" id="txtaddress1" name="txtaddress1" style="width:40%;" value='<s:property value="txtaddress1"/>'/></td>
  </tr>
  <tr>
    <td align="right">Tel</td>
    <td><input type="text" id="txttel" name="txttel" style="width:40%;" value='<s:property value="txttel"/>'/></td>
    <td align="right">Mob</td>
    <td width="28%"><input type="text" id="txtmob" name="txtmob" style="width:40%;" onblur="getMobileNoAlreadyExists(this.value,$('#docno').val(),$('#mode').val());" value='<s:property value="txtmob"/>'/></td>
    <td width="4%" align="right">Office No.</td>
    <td width="26%"><input type="text" id="txtoffice" name="txtoffice" style="width:40%;" value='<s:property value="txtoffice"/>'/></td>
  </tr>
  <tr>
    <td align="right">Fax</td>
    <td><input type="text" id="txtfax" name="txtfax" style="width:40%;" value='<s:property value="txtfax"/>'/></td>
    <td align="right">Email</td>
    <td colspan="3"><input type="email" id="txtemail" name="txtemail" style="width:40%;" placeholder="someone@example.com" value='<s:property value="txtemail"/>'/></td>
  </tr>
  <tr>
    <td align="right">Contact Person</td>
    <td><input type="text" id="txtcontact" name="txtcontact" style="width:60%;" value='<s:property value="txtcontact"/>'/></td>
    <td align="right">Extn. No.</td>
    <td colspan="3"><input type="text" id="txtextno" name="txtextno" style="width:20%;" value='<s:property value="txtextno"/>'/></td>
  </tr>
</table>
</fieldset>
<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="txtmobilevalidation" name="txtmobilevalidation" value='<s:property value="txtmobilevalidation"/>'/>
<input type="hidden" id="typeallowed" name="typeallowed" value='<s:property value="typeallowed"/>'/>
</div>
</form>
</div>
</body>
</html>