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
    	  $("#clientDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    	  
    	  $('#areainfowindow').jqxWindow({ width: '55%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    	  $('#areainfowindow').jqxWindow('close');
    	  $('#countryinfowindow').jqxWindow({ width: '20%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Country Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    	  $('#countryinfowindow').jqxWindow('close');
    	  $('#activityinfowindow').jqxWindow({ width: '20%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Activity Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    	  $('#activityinfowindow').jqxWindow('close');
    	  $('#Salesagentinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'SalesMan Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
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
			//alert("======"+$('#hidcmbacgroup').val());
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
			//alert("=========="+$('#hidcmbcategory').val());
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
			//$('#txtmobilevalidation').val(0);
			return true;
		}
		else{
			document.getElementById("errormsg").innerText="Invalid Mobile Number";
			//$('#txtmobilevalidation').val(1);
			return false;
		}
	    } 
	   return true;
}
 
 function validateEmail($email) {
	  var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
	  if(emailReg.test( $email )){
		  document.getElementById("errormsg").innerText="";
			//$('#txtmobilevalidation').val(0);
			return true;
		}
		else{
			document.getElementById("errormsg").innerText="Email Address Not Valid";
			//$('#txtmobilevalidation').val(1);
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
		//alert(check+"==="+$("#clintvld").val());  
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
 	/*document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")"; */
 	
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
               //alert(url);
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

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();getinterservconfig();getclintvldconfig();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmClientMaster" action="clientmaster" method="post" autocomplete="off">

<%-- <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> --%>

<jsp:include page="../../../../header.jsp"></jsp:include><br/>   
   
<div class='hidden-scrollbar'>
<fieldset>
<table width="100%" >
  <tr>
    <td width="4%" align="right">Date</td>
    <td width="6%"><div id="clientDate" name="clientDate" value='<s:property value="clientDate"/>'></div>
    <input type="hidden" id="hidClientDate" name="hidClientDate" value='<s:property value="hidClientDate"/>'/></td>
    <td width="5%" align="right">Code</td>
    <td width="15%"><input type="text" id="txtcode" readonly name="txtcode" style="width:50%;" tabindex="-1" value='<s:property value="txtcode"/>'/></td>
    <td width="5%" align="right">Name</td>
    <td colspan="2"><input type="text" id="txtclient_name" name="txtclient_name" style="width:130%;" value='<s:property value="txtclient_name"/>'/></td>
    <td width="5%" align="right">Currency</td>
    <td width="12%"><select id="currencyid" name="currencyid" value='<s:property value="currencyid"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbcurrencyid" name="hidcmbcurrencyid" value='<s:property value="hidcmbcurrencyid"/>'/></td>
    <td width="5%" align="right">Doc No.</td>
    <td width="14%"><input type="text" id="docno" readonly name="docno" style="width:65%;" tabindex="-1" value='<s:property value="docno"/>'/></td>
  </tr>
  <tr>
    <td width="4%" align="right">Category</td>
    <td  width="6%"><select id="cmbcategory" name="cmbcategory" style="width:100%;" onchange="getCategoryAccountGroup(this.value);" value='<s:property value="cmbcategory"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/></td>
   
    <td align="right" width="5%">Account Group</td>
    <td width="15%"><select id="cmbacgroup" name="cmbacgroup"  style="width:90%;" value='<s:property value="cmbacgroup"/>'>
      <option value="">--Select--</option></select>
       <input type="hidden" id="hidcmbacgroup" name="hidcmbacgroup" value='<s:property value="hidcmbacgroup"/>'/></td>
       <td align="right" width="5%">Sales Man</td>
    <td colspan="2"><input type="text" id="txtsalman" name="txtsalman" style="width:130%;"  value='<s:property value="txtsalman"/>' onKeyDown=" getsalesAgent(event);"/></td>
       
    <td align="right">Account</td>
    <td><input type="text" id="txtaccount" readonly name="txtaccount" style="width:65%;" tabindex="-1" value='<s:property value="txtaccount"/>'/></td>
  </tr>
  <tr>
    <td align="right">TRN No</td>
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
<tr>
  <td colspan="2" align="center">Taxable Entity <input type="checkbox" name="chknontax" id="chknontax" onchange="taxableentitycheck();" value='<s:property value="chknontax" />' onclick="$(this).attr('value', this.checked ? 1 : 0);">
  <input type="hidden" id="hidchknontax" name="hidchknontax" value='<s:property value="hidchknontax"/>'/></td>
   <td colspan="2" align="center">
   <span id="interid">Inter State Service<input type="checkbox" name="chkinterserv" id="chkinterserv" onchange="interstateservicecheck();" value='<s:property value="chkinterserv" />' onclick="$(this).attr('value', this.checked ? 1 : 0);"></span>
    <input type="hidden" id="hidchkinterserv" name="hidchkinterserv" value='<s:property value="hidchkinterserv"/>'/></td></tr>
</table>
</fieldset>

<fieldset id="fsAdditionalInformation">
<legend>Additional Information</legend>
<table width="70%">
<tr>
<td width="10%" align="right">Finanical name</td>
<td ><input type="text" id="txtfinname" name="txtfinname" style="width:91%;" value='<s:property value="txtfinname"/>'/></td>
<td width="40%" align="right">Finanical Address</td>
<td colspan="5"><input type="text" id="txtfinaddress" name="txtfinaddress" style="width:220%;" value='<s:property value="txtfinaddress"/>'/></td>
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
<td><input type="text" id="txtmobile" name="txtmobile" style="width:80%;" onblur="mobileValid(this.value);" placeholder="mobile number with country code" value='<s:property value="txtmobile"/>'/></td>
<td align="right">Fax</td>
<td><input type="text" id="txtfax" name="txtfax" style="width:62%;" value='<s:property value="txtfax"/>'/></td>
</tr>
<tr>
<td align="right">Email</td>
<td colspan="3"><input type="text" id="txtemail" name="txtemail" placeholder="someone@example.com" onblur="validateEmail(this.value);" style="width:80%;" value='<s:property value="txtemail"/>'/></td></tr>
<tr>
<td align="right">Web</td>
<td colspan="3"><input type="text" id="txtweb" name="txtweb" style="width:80%;" value='<s:property value="txtweb"/>'/></td></tr>
<tr>
<td align="right">Contact</td>
<td colspan="3"><input type="text" id="txtcontact" name="txtcontact" style="width:80%;" value='<s:property value="txtcontact"/>'/></td>
</tr>
 <tr>
<td align="right">Area</td>
<td ><input type="text" id="txtarea" name="txtarea" style="width:60%;" readonly placeholder="press F3 to search" value='<s:property value="txtarea"/>' onKeyDown=" getareas(event);"/></td>
 <td colspan="2"><input type="text" id="txtareadet" name="txtareadet" readonly style="width:68%;" value='<s:property value="txtareadet"/>'/>
 <input type="hidden" id="txtareaid" name="txtareaid"  value='<s:property value="txtareaid"/>'/></td></tr> 
</table>
</fieldset>
</td><td width="50%">
<fieldset>
<legend>Bank Information</legend>
<table width="100%">
<tr>
<td width="12%" align="right">Account No.</td>
<td width="41%"><input type="text" id="txtaccountno"  name="txtaccountno" style="width:90%;" value='<s:property value="txtaccountno"/>'/></td>
</tr>
<tr>
<td align="right">Bank Name</td>
<td colspan="3"><input type="text" id="txtbankname" name="txtbankname" style="width:91%;" value='<s:property value="txtbankname"/>'/></td>
</tr>
<tr>
<td align="right">Branch Name</td>
<td colspan="3"><input type="text" id="txtbranchname" name="txtbranchname" style="width:91%;" value='<s:property value="txtbranchname"/>'/></td>
</tr>
<tr>
<td align="right">Branch Address</td>
<td colspan="3"><input type="text" id="txtbranchaddress" name="txtbranchaddress" style="width:91%;" value='<s:property value="txtbranchaddress"/>'/></td>
</tr>
<tr>
<td align="right">Swift No.</td>
<td><input type="text" id="txtswiftno" name="txtswiftno" style="width:80%;" value='<s:property value="txtswiftno"/>'/></td>
<td width="8%" align="right">IBAN No.</td>
<td width="39%"><input type="text" id="txtibanno" name="txtibanno" style="width:80%;" value='<s:property value="txtibanno"/>'/></td>
</tr>
<tr>
<td align="right">City</td>
<td><input type="text" id="txtcity" name="txtcity" style="width:80%;" value='<s:property value="txtcity"/>'/></td>
<td align="right">Country</td>
<td><input type="text" id="txtcountry" name="txtcountry" style="width:80%;" placeholder="press F3 to search" value='<s:property value="txtcountry"/>' readonly="true" onKeyDown="getcountry(event);"/></td>
</tr>
</table><br/><br/>
</fieldset>
</td></tr></table>

<fieldset>
<legend>Contact Person Details</legend>
<table width="100%" id="cpGridtbl">
<tr><td><div id="cpGridDetails"><jsp:include page="cpGridDetails.jsp"></jsp:include></div></td></tr>
</table>
</fieldset>

<fieldset>
<legend>Documents Details</legend>
<table width="100%" id="docGridtbl">
<tr><td><div id="documentsDiv"><jsp:include page="documentsGrid.jsp"></jsp:include></div></td></tr>
</table>
</fieldset>
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
   <div id="Salesagentinfowindow">
   <div ></div>
   </div>
</div>

</body>
</html>
