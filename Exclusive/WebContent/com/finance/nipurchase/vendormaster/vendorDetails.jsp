
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
	 	 $('#srvtypserchwindow').jqxWindow({ width: '40%', height: '60%',  maxHeight: '90%' ,maxWidth: '90%' ,title: 'Service Type Search' , position: { x: 150, y: 50 }, keyboardCloseKey: 27});
			$('#srvtypserchwindow').jqxWindow('close');
			 $('#activityinfowindow').jqxWindow({ width: '20%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Activity Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
				$('#activityinfowindow').jqxWindow('close');
				$('#areainfowindow').jqxWindow({ width: '55%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		    	  $('#areainfowindow').jqxWindow('close');
		    	   $('#countryinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Country Search' , position: { x: 200, y: 120 }, keyboardCloseKey: 27});
 		 $('#countryinfowindow').jqxWindow('close');
		 getCurrencyIds();getCategory();getGroup();getType();
		 $('#txtcountryname').dblclick(function(){
    		  $('#countryinfowindow').jqxWindow('open');
    		  countrySearchContent('countryinfo.jsp'); 
			  });
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
  					//$("#frmVendorMasterDetails").submit();
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
			$('#frmVendorMasterDetails input').attr('readonly', true );
		    $('#frmVendorMasterDetails select').attr('disabled', true); 
			$('#jqxVendorDate').jqxDateTimeInput({disabled: true});
	 }
	 function funRemoveReadOnly(){
		    getCurrencyIds();
		    
		    $("#jqxService").jqxGrid({ disabled: false});
		    
			$('#frmVendorMasterDetails input').attr('readonly', false );
			$('#frmVendorMasterDetails select').attr('disabled', false); 
			$('#cpDetailsGrid').jqxGrid({ disabled: false});
			$('#jqxVendorDate').jqxDateTimeInput({disabled: false});
			$('#txtaccount').attr('readonly', true);
			$('#txtcode').attr('readonly', true);
			$('#cmbaccgroup').attr('disabled', false);
			$('#docno').attr('readonly', true);
			
			if ($("#mode").val() == "A") {
				$("#cpDetailsGrid").jqxGrid('clear');
	    		$("#cpDetailsGrid").jqxGrid("addrow", null, {});
				$('#jqxVendorDate').val(new Date());
				$("#jqxService").jqxGrid('clear');
				$("#jqxService").jqxGrid('addrow', null, {});
			}
			
	 }
	 function funNotify(){	
		 vendorname=document.getElementById("txtvendorname").value;
		 docno=document.getElementById("docno").value;
		 mode=document.getElementById("mode").value;
		  /*cat=document.getElementById("cmbcategory").value;*/
		   
		    /*$('#cmbaccgroup').attr('disabled', false);*/
		   var rows = $("#jqxService").jqxGrid('getrows');
	  		  var length=0;
			  for(var i=0 ; i < rows.length ; i++){
				    var chk=rows[i].servid;
				    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
	  					newTextBox = $(document.createElement("input"))
	  				    .attr("type", "dil")
	  				    .attr("id", "ventest"+length)
	  				    .attr("name", "ventest"+length)
	  				    .attr("hidden", "true");
	  					length=length+1;
	  					
	  				newTextBox.val(rows[i].servid+":: "+rows[i].availability+":: "+rows[i].paymenttype+" ::");
	  				newTextBox.appendTo('form');
	  				}
			      }
			      
			      $('#vendorgridlenght').val(length);
			      getVendorAlreadyExists(vendorname,docno,mode);
			      
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
					    
						   
						
					newTextBox.val(rows[i].cpersion+"::"+rows[i].mobile+" :: "+rows[i].phone+" :: "+rows[i].extn+" :: "+rows[i].email+" :: "+rows[i].areaid+" :: "+rows[i].activity_id+" :: "+rows[i].row_no);    
				   
					newTextBox.appendTo('form'); 
				   //alert(newTextBox.val());      
				   len=len+1;
						 }
				   
				   }
				   $('#cpgridlength').val(len);
				   return 1;
		 // return 1;
		} 
		
		
	 
	 function funSearchLoad(){
			changeContent('vndMainSearch.jsp'); 
		 }
	 
	 function funFocus()
	    {
	    	$('#jqxVendorDate').jqxDateTimeInput('focus'); 	    		
	    }
	    
	function getCountryDetails(event){
 	 var x= event.keyCode;
 	 if(x==114){
 	  $('#countryinfowindow').jqxWindow('open');
 
    
 	 countrySearchContent('countryinfo.jsp');    }
 	 else{
 		 }
 	 }
 	 
 	 function countrySearchContent(url) {
	 //alert(url);
  	 $.get(url).done(function (data) {
			 //alert(data);
	$('#countryinfowindow').jqxWindow('setContent', data);

                	}); 
      	}
	 
	 function setValues(){
		 $("#jqxService").jqxGrid({ disabled: true});
		 getCurrencyIds();
		 
		 if($('#hidjqxVendorDate').val()){
			 $("#jqxVendorDate").jqxDateTimeInput('val', $('#hidjqxVendorDate').val());
		  }
		 
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 var maindoc=document.getElementById("txtcode").value;
		  if(maindoc>0) {
			    var indexVal1 = document.getElementById("txtcode").value;
			    $("#cpGridtbl").load("cpGridDetails.jsp?cldocno="+indexVal1);
			    $("#vendordiv").load("vendorGrid.jsp?docno="+indexVal1);
			    if ($('#hidcmbcommmode').val() != null && $('#hidcmbcommmode').val() != "") {
			       		 $('#cmbcommmode').val($('#hidcmbcommmode').val()) ;
			     }
			  }
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		 funSetlabel();
		}
	 
	 function funChkButton() {
			/* funReset(); */
		}
	 function srvTypSerchContent(url) {
	    	
	    	
	    	//alert(url);
	    		 $.get(url).done(function (data) {
	    			 //alert(data);
	    	$('#srvtypserchwindow').jqxWindow('setContent', data);

	    	            	}); 
	    	  	}
		  
	 /* Validations */
	 $(function(){
	        $('#frmVendorMasterDetails').validate({
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
		    var reurl=url.split("vendormaster");
		    top.addTab("VendorList",reurl[0]+"vendormaster/vendorList.jsp");
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
	 function typecheck() {
		 if($('#cmbtype').val()=='1'){
			 $('#vndtax').val('1');
		 }
		 else{
			 $('#vndtax').val('0');
		 }
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
<form id="frmVendorMasterDetails" action="saveVendorMasterDetails" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>
   
<div class='hidden-scrollbar'>
<%-- <fieldset>
<table width="100%">
  <tr>
    <td width="3%" align="right">Date</td>
    <td width="10%"><div id="jqxVendorDate" name="jqxVendorDate" value='<s:property value="jqxVendorDate"/>'></div>
    <input type="hidden" id="hidjqxVendorDate" name="hidjqxVendorDate" value='<s:property value="hidjqxVendorDate"/>'/></td>
    <td width="4%" align="right">Code</td>
    <td width="4%"><input type="text" id="txtcode" name="txtcode" style="width:100%;" tabindex="-1" value='<s:property value="txtcode"/>'/></td>
    <td width="4%" align="right">Name</td>
    <td width="26%"><input type="text" id="txtvendorname" name="txtvendorname" style="width:100%;" value='<s:property value="txtvendorname"/>'/></td>
    <td width="6%" align="right">Currency</td>
    <td width="6%"><select id="cmbcurrency" name="cmbcurrency" style="width:80%;" value='<s:property value="cmbcurrency"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/></td>
    <td width="4%" align="right">Category</td>
    <td width="14%"><select id="cmbcategory" name="cmbcategory" style="width:100%;" onchange="getCategoryAccountGroup(this.value);" value='<s:property value="cmbcategory"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/></td>
    <td width="5%" align="right">Doc No</td>
    <td width="14%"><input type="text" id="docno" name="txtvendordocno" style="width:75%;" tabindex="-1" value='<s:property value="txtvendordocno"/>'/></td>
  </tr>
</table>
</fieldset><br/> --%>
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
    <td><select id="cmbtype" name="cmbtype" style="width:70%;" onchange="typecheck();" value='<s:property value="cmbtype"/>'>
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
    <td width="28%"><input type="text" id="txtextno" name="txtextno" style="width:20%;" value='<s:property value="txtextno"/>'/></td>
    <td width="9%" align="right">Comm. Mode</td>
    <td width="28%"><select id="cmbcommmode" name="cmbcommmode" style="width:40%;" value='<s:property value="cmbcommmode"/>'>  
      <option value="">--Select--</option><option value="1">E-Mail</option><option value="2">Whatsapp</option><option value="3">E-mail & Whatsapp</option></select>  
      <input type="hidden" id="hidcmbcommmode" name="hidcmbcommmode" value='<s:property value="hidcmbcommmode"/>'/></td>   
  </tr>
</table>
</fieldset>
<fieldset>
<legend>Bank Information</legend>
<table width="100%">
<tr>
 <td width="9%" align="right">Account. No.</td>
 <td><input type="text" id="txtaccountno" name="txtaccountno" style="width:20%;" value='<s:property value="txtaccountno"/>'/></td>
 <td width="4%" align="right">Swift No</td>
 <td><input type="text" id="txtswiftno" name="txtswiftno" style="width:30%;" value='<s:property value="txtswiftno"/>'/></td>
</tr>
<tr>
 <td align="right">Bank Name</td>
 <td><input type="text" id="txtbankname" name="txtbankname" style="width:40%;" value='<s:property value="txtbankname"/>'/></td>
  <td width="4%" align="right">City</td>
 <td><input type="text" id="txtcity" name="txtcity" style="width:30%;" value='<s:property value="txtcity"/>'/></td>
 
</tr>
<tr>
 <td align="right">Branch Name</td>
 <td><input type="text" id="txtbranchname" name="txtbranchname" style="width:50%;" value='<s:property value="txtbranchname"/>'/></td>
 <td width="4%" align="right">IBAN No</td>
 <td><input type="text" id="txtibanno" name="txtibanno" style="width:30%;" value='<s:property value="txtibanno"/>'/></td>
</tr>
<tr>
 <td  width="9%" align="right">Branch Address</td>
 <td><input type="text" id="txtbranchaddress" name="txtbranchaddress" style="width:60%;" value='<s:property value="txtbranchaddress"/>'/></td>
 <td width="4%" align="right">Country</td>
    <td> 
      <input type="text" name="txtcountryname" id="txtcountryname" value='<s:property value="txtcountryname"/>' placeholder="Press F3 To Search"  style="width:30%;" onKeyDown="getCountryDetails(event);" >  
      <input type="hidden" id="txtcdocno" name="txtcdocno" value='<s:property value="txtcdocno"/>'  style="width:77.5%;"></td>
</tr>
<tr>

 
</tr>
<tr>
  </tr>
  
</table>
</fieldset>
<fieldset>
<table width="100%">
<tr><td>
<div id="vendordiv">
<jsp:include page="vendorGrid.jsp"></jsp:include></div>
</td>
  </tr>
</table>
</fieldset>
<fieldset>
<legend>Contact Person Details</legend>
<table width="100%">
<tr><td>
     <div id="cpGridtbl"> 
  <jsp:include page="cpGridDetails.jsp"></jsp:include></div>
</td>
  </tr>
  
</table>
</fieldset>
<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="masterdoc" name="masterdoc" />
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="vendorgridlenght" name="vendorgridlenght" />
<input type="hidden" id="vndtax" name="vndtax"  value='<s:property value="vndtax"/>'/>
<input type="hidden" id="txtmobilevalidation" name="txtmobilevalidation" value='<s:property value="txtmobilevalidation"/>'/>
<input type="hidden" id="cpgridlength" name="cpgridlength"/>
<input type="hidden" id="hidetest" name="hidetest"  value='<s:property value="hidetest"/>'/>
</div>
</form>
 <div id="srvtypserchwindow">
   <div ></div>
</div>
<div id="activityinfowindow">
   <div ></div>
   </div>
  <div id="areainfowindow">
   <div ></div>
   </div>
   <div id="countryinfowindow">
   <div ></div>
   </div>
</div>
</body>
</html>