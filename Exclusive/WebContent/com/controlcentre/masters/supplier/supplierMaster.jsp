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

<script type="text/javascript">
      $(document).ready(function () {
    	  /* Date */
    	  $("#supplierDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    	  $('#areainfowindow').jqxWindow({ width: '55%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    	  $('#areainfowindow').jqxWindow('close');
    	  $('#countryinfowindow').jqxWindow({ width: '20%', height: '40%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Country Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    	  $('#countryinfowindow').jqxWindow('close');
    	  $('#activityinfowindow').jqxWindow({ width: '20%', height: '40%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Activity Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    	  $('#activityinfowindow').jqxWindow('close');
    	  getGroup();
    	  getCategory();
    	  getCurrency();
    	  
    	  $('#txtarea').dblclick(function(){
    		  $('#areainfowindow').jqxWindow('open');
			  areaSearchContent('area.jsp?getarea=0');
			  });
    	  
    	  $('#txtcountry').dblclick(function(){
    		  $('#countryinfowindow').jqxWindow('open');
    		  countrySearchContent('country.jsp'); 
			  });
    	  
    	  
      }); 
      
      function  funReadOnly(){
    	  
    	  
    		$('#frmSupplierMaster input').attr('disabled', true );
    		$('#frmSupplierMaster textarea').attr('disabled', true );
    		$('#frmSupplierMaster select').attr('disabled', true);
    		$('#cpDetailsGrid').jqxGrid({ disabled: true});
    		 $('#mode').attr('disabled', false);
    		 $('#formdetailcode').attr('disabled', false);
    		 $('#docno').attr('disabled', false);
    		 
    		
    	}
      
      function funSearchLoad(){
    		changeContent('masterSearch.jsp', $('#window'));
    	}
      
      function funRemoveReadOnly(){
    	  
    		$('#frmSupplierMaster input').attr('disabled', false );
    		$('#frmSupplierMaster textarea').attr('disabled', false );
    		$('#frmSupplierMaster select').attr('disabled', false);
    		$('#cpDetailsGrid').jqxGrid({ disabled: false});
    		
    		if(document.getElementById("mode").value=='A')
    			{
    			$("#cpDetailsGrid").jqxGrid('clear');
        		$("#cpDetailsGrid").jqxGrid("addrow", null, {});
    		document.getElementById("txtcredit_period_max").value=0.0;
      	    document.getElementById("txtcredit_period_min").value=0.0;
      	    document.getElementById("txtcredit_limit").value=0.0;
    			}
      }
      
      function getareas(event){
       	 var x= event.keyCode;
       	 //alert("x===="+x);
       	 if(x==114){
       	  $('#areainfowindow').jqxWindow('open');
      
                 areaSearchContent('area.jsp?getarea=0');  	 }
        	 else{
        		
       		 }
              	 }
      
    
             	 
 function areaSearchContent(url) {
 	 //alert(url);
      	 $.get(url).done(function (data) {
 			 //alert(data);
 	$('#areainfowindow').jqxWindow('setContent', data);

                    	}); 
          	}
 
 function getcountry(event){
  	 var x= event.keyCode;
  	 if(x==114){
  	  $('#countryinfowindow').jqxWindow('open');
  
     // $('#accountWindow').jqxWindow('focus');
            countrySearchContent('country.jsp');  	 }
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
      	
/* function getactivity(event){
 	 var x= event.keyCode;
 	 if(x==114){
 	  $('#activityinfowindow').jqxWindow('open');
 
    // $('#accountWindow').jqxWindow('focus');
           activitySearchContent('activity.jsp');  	 }
  	 else{
 		 }
        	 }
        	 
function activitySearchContent(url) {
	 //alert(url);
 	 $.get(url).done(function (data) {
			 //alert(data);
	$('#activityinfowindow').jqxWindow('setContent', data);

               	}); 
     	} */
 
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


 
 function funFocus(){
	 document.getElementById("txtsupplier_name").focus();  
	
 }
 
 
 
 function funNotify(){	
	 
		var txtsupplier=document.getElementById("txtsupplier_name").value;
		
		//var acgroup=document.getElementById("cmbacgroup").value;
		
		var currency=document.getElementById("currency").value;
		
		var tin=document.getElementById("txttinno").value;
		
		var cst=document.getElementById("txtcstno").value;
		
		
		if(txtsupplier=="")
		{
		document.getElementById("errormsg").innerText=" Enter Supplier Name";
		return 0;
		}
		/* if(acgroup=="")
		{
		document.getElementById("errormsg").innerText=" Select Account Group";
		return 0;
		} */
		
		if(tin=="")
		{
		document.getElementById("errormsg").innerText=" Enter Tin No";
		return 0;
		}
		
		if(cst=="")
		{
		document.getElementById("errormsg").innerText="Enter Cst";
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
			    
				   
				
		   newTextBox.val(rows[i].cpersion+"::"+rows[i].mobile+" :: "
				   +rows[i].phone+" :: "+rows[i].extn+" :: "+rows[i].email+" :: "+rows[i].area+" :: "+rows[i].areaid+" :: "+rows[i].activity_id+"");
		   
		   newTextBox.appendTo('form'); 
		   
		   len=len+1;
				 }
		   
		   }
		   $('#cpgridlength').val(len);
		   return 1;
		
 }
 
 
 function setValues() {
	  var maindoc=document.getElementById("txtcode").value;
	  if(maindoc>0)
		  {
	 
    var indexVal1 = document.getElementById("txtcode").value;
   
     
    
   $("#cpGridDetails").load('cpGridDetails.jsp?cldocno='+indexVal1);
	  
  
		  }
 		
	  
	   // main
	  // alert($('#hidsupplierDate').val());
	  if($('#hidcmbcurrencyid').val()){
 			$("#currencyid").val($('#hidcmbcurrencyid').val());
 		}
	   
 		if($('#hidsupplierDate').val()){
 			$("#supplierDate").jqxDateTimeInput('val', $('#hidsupplierDate').val());
 		}
		
 		//alert("==hidcmbacgroup==="+$('#hidcmbacgroup').val());
 		
 		if ($('#hidcmbacgroup').val() != null) {
			$('#cmbacgroup').val($('#hidcmbacgroup').val());
		}
  
 	   if($('#msg').val()!=""){
 		   $.messager.alert('Message',$('#msg').val());
 		   
 		  }
 	   
 	 //delvalueChange();
 	/*document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")"; */
 	
 }
 
 function delvalueChange()
 {
 	  
 }
      
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmSupplierMaster" action="suppliermaster" method="post" autocomplete="off">
<%-- <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> --%>

<jsp:include page="../../../../header.jsp"></jsp:include><br/>   
   
<div class='hidden-scrollbar'>
<fieldset>
<table width="100%">
  <tr>
    <td width="4%" align="right">Date</td>
    <td width="6%"><div id="supplierDate" name="supplierDate" value='<s:property value="supplierDate"/>'></div>
    <input type="hidden" id="hidSupplierDate" name="hidSupplierDate" value='<s:property value="hidSupplierDate"/>'/></td>
    <td width="5%" align="right">Code</td>
    <td width="15%"><input type="text" id="txtcode" readonly="true" name="txtcode" style="width:50%;" tabindex="-1" value='<s:property value="txtcode"/>'/></td>
    <td width="5%" align="right">Name</td>
    <td colspan="2"><input type="text" id="txtsupplier_name" name="txtsupplier_name" style="width:100%;" value='<s:property value="txtsupplier_name"/>'/></td>
    <td width="9%" align="right">Currency</td>
    <td width="12%"><select id="currencyid" name="currencyid" value='<s:property value="currencyid"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbcurrencyid" name="hidcmbcurrencyid" value='<s:property value="hidcmbcurrencyid"/>'/></td>
    <td width="5%" align="right">Doc No.</td>
    <td width="14%"><input type="text" id="docno" readonly="true" name="docno" style="width:65%;" tabindex="-1" value='<s:property value="docno"/>'/></td>
  </tr>
  <tr>
     <td align="right"></td>
    <td></td> 
    <td align="right">Category</td>
    <td><select id="cmbcategory" name="cmbcategory" style="width:70%;" value='<s:property value="cmbcategory"/>'>
      <option value="">--Select--</option>
      
      <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/></td>
    <td colspan="2" align="right"></td>
    <td width="13%"></td>
    <td align="right">Account Group</td>
    <td><select id="cmbacgroup" name="cmbacgroup"  style="width:90%;" value='<s:property value="cmbacgroup"/>'>
      <option value="">--Select--</option>
       <input type="hidden" id="hidcmbacgroup" name="hidcmbacgroup" value='<s:property value="hidcmbacgroup"/>'/></td>
    <td align="right">Account</td>
    <td><input type="text" id="txtaccount" readonly="true" name="txtaccount" style="width:65%;" tabindex="-1" value='<s:property value="txtaccount"/>'/></td>
  </tr>
  <tr>
    <td align="right">Tin. No</td>
    <td><input type="text" id="txttinno" name="txttinno" style="width:70%;" value='<s:property value="txttinno"/>'/></td>
    <td align="right">CST No</td>
    <td><input type="text" id="txtcstno" name="txtcstno" style="width:70%;" value='<s:property value="txtcstno"/>'/></td>
    <td colspan="2" align="right">Credit Period-Min(Days)</td>
    <td><input type="text" id="txtcredit_period_min" name="txtcredit_period_min" style="width:70%;text-align: right;" value='<s:property value="txtcredit_period_min"/>'/></td>
    <td width="8%" align="right">Max(Days)</td>
    <td width="19%"><input type="text" id="txtcredit_period_max" name="txtcredit_period_max" style="width:50%;text-align: right;" value='<s:property value="txtcredit_period_max"/>'/></td>
    <td width="9%" align="right">Credit Limit</td>
    <td><input type="text" id="txtcredit_limit" name="txtcredit_limit" style="width:50%;text-align: right;" value='<s:property value="txtcredit_limit"/>'/></td>
  </tr>
</table>
</fieldset>

<table width="100%">
<tr><td width="50%">
<fieldset>
<legend>Communication Details</legend>
<table width="100%">
<tr>
<td width="7%" align="right">Address</td>
<td colspan="3"><input type="text" id="txtaddress" name="txtaddress" style="width:80%;" value='<s:property value="txtaddress"/>'/></td></tr>
<tr>
<td align="right">Extn. No.</td>
<td width="36%"><input type="text" id="txtextnno" name="txtextnno" style="width:80%;" value='<s:property value="txtextnno"/>'/></td>
<td width="7%" align="right">Telephone</td>
<td width="50%"><input type="text" id="txttelephone" name="txttelephone" style="width:62%;" value='<s:property value="txttelephone"/>'/></td></tr>
<tr>
<td  align="right">Mobile</td>
<td><input type="text" id="txtmobile" name="txtmobile" style="width:80%;" value='<s:property value="txtmobile"/>'/></td>
<td align="right">Fax</td>
<td><input type="text" id="txtfax" name="txtfax" style="width:62%;" value='<s:property value="txtfax"/>'/></td>
</tr>
<tr>
<td align="right">Email</td>
<td colspan="3"><input type="text" id="txtemail" name="txtemail" placeholder="someone@example.com" style="width:80%;" value='<s:property value="txtemail"/>'/></td></tr>
<tr>
<td align="right">Web</td>
<td colspan="3"><input type="text" id="txtweb" name="txtweb" style="width:80%;" value='<s:property value="txtweb"/>'/></td></tr>
<tr>
<td align="right">Contact</td>
<td colspan="3"><input type="text" id="txtcontact" name="txtcontact" style="width:80%;" value='<s:property value="txtcontact"/>'/></td>
</tr>
<tr>
<td align="right">Area</td>
<td ><input type="text" id="txtarea" name="txtarea" style="width:60%;" placeholder="press F3 for search" readonly="true" value='<s:property value="txtarea"/>' onKeyDown="getareas(event);"/></td>
 <td colspan="2"><input type="text" id="txtareadet" name="txtareadet" readonly="true" style="width:68%;" value='<s:property value="txtareadet"/>'/></td></tr>
<input type="hidden" id="txtareaid" name="txtareaid"  value='<s:property value="txtareaid"/>'/>
</table>
</fieldset>
</td><td width="50%">
<fieldset>
<legend>Bank Information</legend>
<table width="100%">
<tr>
<td width="12%" align="right">Account No.</td>
<td width="41%"><input type="text" id="txtaccountno"  name="txtaccountno" style="width:90%;" value='<s:property value="txtaccountno"/>'/></td></tr>
<tr>
<td align="right">Bank Name</td>
<td colspan="3"><input type="text" id="txtbankname" name="txtbankname" style="width:91%;" value='<s:property value="txtbankname"/>'/></td></tr>
<tr>
<td align="right">Branch Name</td>
<td colspan="3"><input type="text" id="txtbranchname" name="txtbranchname" style="width:91%;" value='<s:property value="txtbranchname"/>'/></td></tr>
<tr>
<td align="right">Branch Address</td>
<td colspan="3"><input type="text" id="txtbranchaddress" name="txtbranchaddress" style="width:91%;" value='<s:property value="txtbranchaddress"/>'/></td></tr>
<tr>
<td align="right">Swift No.</td>
<td><input type="text" id="txtswiftno" name="txtswiftno" style="width:80%;" value='<s:property value="txtswiftno"/>'/></td>
<td width="8%" align="right">IBAN No.</td>
<td width="39%"><input type="text" id="txtibanno" name="txtibanno" style="width:80%;" value='<s:property value="txtibanno"/>'/></td></tr>
<tr>
<td align="right">City</td>
<td><input type="text" id="txtcity" name="txtcity" style="width:80%;" value='<s:property value="txtcity"/>'/></td>
<td align="right">Country</td>
<td><input type="text" id="txtcountry" name="txtcountry" placeholder="press F3 for search" style="width:80%;" readonly="true" value='<s:property value="txtcountry"/>' onKeyDown="getcountry(event);"/></td></tr>
		<input type="hidden" id="cityid" name="cityid" value='<s:property value="cityid"/>'/>
		<input type="hidden" id="countryid" name="countryid" value='<s:property value="countryid"/>'/>
</table><br/><br/>
</fieldset>
</td></tr></table>

<fieldset>
<legend>Contact Person Details</legend>
<table width="100%" id="cpGridtbl">
<tr><td>
      <div id="cpGridDetails">
  <jsp:include page="cpGridDetails.jsp"></jsp:include></div>
</td>
  </tr>
  <input type="hidden" id="cpgridlength" name="cpgridlength"/>
</table>
</fieldset>
<input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
		<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
		<input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
</div>
</form>
<div id="areainfowindow">
   <div ></div>
   </div>
   <div id="countryinfowindow">
   <div ></div>
   </div>
   <div id="activityinfowindow">
   <div ></div>
   </div>
</div>

</body>
</html>
