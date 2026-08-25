<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<%
	String contextPath = request.getContextPath();
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>

<script type="text/javascript">
     
	$(document).ready(function () { 		
	  	 /* Date */
	  	  $('#nationalityWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Nation Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    	  $('#nationalityWindow').jqxWindow('close');
	 	  $("#jqxDate").jqxDateTimeInput({ width: '80%', height: '23px', formatString:"dd.MM.yyyy"});
	 	  $("#jqxBirthDate").jqxDateTimeInput({ width: '45%', height: '23px', formatString:"dd.MM.yyyy"});
	 	  $("#jqxexpiryDate").jqxDateTimeInput({ width: '80%', height: '23px', formatString:"dd.MM.yyyy"});
		  getCurrencyIds();getCategory();getGroup();getTypeAllowed();getType(); 
		  $('#txtnationality').dblclick(function(){
	  	  	     $('#nationalityWindow').jqxWindow('open');	  	   
	  	 		 bdcSearchContent('nationsearchGrid.jsp?'); 	         
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
  				$("select#cmbnation").html(optionsgroup);
  				if ($('#hidcmbnation').val() != null) {
  					$('#cmbnation').val($('#hidcmbnation').val());
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
  			    	document.getElementById("lbltrnnoentity").style.display = 'none';
  			    	$('#cmbtype').attr('hidden', false);
  			    	$('#txtregisteredtrnno').attr('hidden', true);
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
	
	function typecheck() {
		 if($('#cmbtype').val()=='1'){
			 document.getElementById("lbltrnnoentity").style.display = 'inline-block';
			 if($('#mode').val()!='view'){
			 	$('#txtregisteredtrnno').val('');
			 }
		     $('#txtregisteredtrnno').attr('hidden', false);
		 }
		 else{
			 document.getElementById("lbltrnnoentity").style.display = 'none';
			 if($('#mode').val()!='view'){
				 	$('#txtregisteredtrnno').val('');
			 }
		     $('#txtregisteredtrnno').attr('hidden', true);
		 }
	 } 
      
	 function funReadOnly(){
			$('#frmPropertyOwner input').attr('readonly', true );
		    $('#frmPropertyOwner select').attr('disabled', true); 
			$('#jqxDate').jqxDateTimeInput({disabled: true});
			
			$('#jqxBirthDate').jqxDateTimeInput({disabled: true});
			$('#jqxexpiryDate').jqxDateTimeInput({disabled: true});				
			 
	 }
	 
	 function funRemoveReadOnly(){
		   /*  getCurrencyIds();getTypeAllowed(); */
		    
			$('#frmPropertyOwner input').attr('readonly', false );
			$('#frmPropertyOwner select').attr('disabled', false); 
			$('#jqxDate').jqxDateTimeInput({disabled: false});
			$('#jqxBirthDate').jqxDateTimeInput({disabled: false});
			$('#jqxexpiryDate').jqxDateTimeInput({disabled: false});
			
			$('#txtaccount').attr('readonly', true);
			$('#txtcode').attr('readonly', true);
			$('#cmbaccgroup').attr('disabled', true);
			$('#docno').attr('readonly', true);
			$('#txtOwnerId').attr('readonly', true);
			
			if ($("#mode").val() == "A") {
				$('#jqxDate').val(new Date());				
				$('#jqxBirthDate').val(new Date());
				$('#jqxexpiryDate').val(new Date());
				
				$("#jqxaccGrid").jqxGrid('clear'); 
				
				$('#lblowneraccount').hide();
			}
	 }
	 function funNotify(){	
		  var tel1=$('#txttelepho').val();		
		  if(tel1 !="")
		  {
			 if(!tel1.match(/^\d+$/))
			  {		  
				 document.getElementById("errormsg").innerText="Enter Numbers only in Telephone1.";
				 return 0;
		      }
		   }
			 
			 var tel2=$('#txttelepho2').val();		
			 if(tel2 !="")
			 {
				 if(!tel2.match(/^\d+$/))
				  {		  
					 document.getElementById("errormsg").innerText="Enter Numbers only in Telephone2.";
					 return 0;
			      }
			  }
			 
			 var mob1=$('#txtmobpho').val();		
			 if(mob1 !="")
			 {
				 if(!mob1.match(/^\d+$/))
				  {		  
					 document.getElementById("errormsg").innerText="Enter Numbers only in Mobile1.";
					 return 0;
			      }
			  }
			 
			 var mob2=$('#txtmobpho2').val();	
			 if(mob2 !="")
			 {	 
				 if(!mob2.match(/^\d+$/))
				  {		  
					 document.getElementById("errormsg").innerText="Enter Numbers only in Mobile2.";
					 return 0;
			      }
			  }
		 
		/*  if(parseInt($('#typeallowed').val())==1) {
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
		 
		 vendorname=document.getElementById("txtvendorname").value; */
		 
		      /*   var phoneNo = document.getElementById('txtmobpho');
		        if(phoneNo.value.length == 0){
		        }
		        else if (phoneNo.value.length < 12 || phoneNo.value.length > 12 || phoneNo.value.length == 0) {
		        	 $.messager.alert('Warning','Enter 12 Digit Mobile Number');
		            return false;
		        } */

		        // spl ins grid
		        var rows1 = $("#jqxsplGrid").jqxGrid('getrows');
				var splinslen = 0;
				for (var i = 0; i < rows1.length; i++) {	
					  var desc=rows1[i].desc1;
					  if (typeof (desc) != "undefined" && typeof (desc) != "NaN" && desc != "") {  
								newTextBox = $(document.createElement("input"))
								.attr("type","dil")
										.attr("id", "splins" + splinslen)
										.attr("name", "splins" + splinslen)
										.attr("hidden","true");
								splinslen = splinslen + 1;
								newTextBox.val(rows1[i].rowno+"::"+rows1[i].desc1);   
								newTextBox.appendTo('form');
					}				
				}  
				$('#splgridlength').val(splinslen);   
		        // set acc grid into a textbox 		 
				var accrows = $("#jqxaccGrid").jqxGrid('getrows');
				var acclength = 0;
				var no_of_ticks=0;	
				for (var i = 0; i < accrows.length; i++) {	
					var defaultacc=0;
					var chks = accrows[i].chk;
					var bname=accrows[i].bankname;
					  if (typeof (bname) != "undefined" && typeof (bname) != "NaN" && bname != "") {  
						  //alert(chks);
							if (chks) { 
								no_of_ticks=no_of_ticks+1;
								defaultacc=1;
							} 
								newTextBox = $(document.createElement("input"))
								.attr("type","dil")
										.attr("id", "txtaccdet" + acclength)
										.attr("name", "txtaccdet" + acclength)
										.attr("hidden","true");
								acclength = acclength + 1;
								//						0					1						2							3							4						5							6						7							8					9					 10
								newTextBox.val(accrows[i].doc_no+"::"+accrows[i].bankname+"::"+accrows[i].accnumber+"::"+accrows[i].accname+"::"+accrows[i].bankaddress+"::"+accrows[i].countryid+"::"+accrows[i].currencyid+"::"+accrows[i].swiftcode+"::"+accrows[i].iban+"::"+accrows[i].remarks+"::"+defaultacc);
								newTextBox.appendTo('form');
					}				
				} 
				//alert(newTextBox.val());
				if(accrows>0)
				{
					if(no_of_ticks>1)
					{
						 document.getElementById("errormsg").innerText="Select Only one account as default.";
						 no_of_ticks=0;
						 return 0;	
					}
					if(no_of_ticks==0)
					{
						 document.getElementById("errormsg").innerText="Select atleast one account as default.";
						 no_of_ticks=0;
						 return 0;	
					}
				}
				$('#accgridlength').val(acclength); 
				// set acc grid into a textbox
		       
		 docno=document.getElementById("docno").value;
		 mode=document.getElementById("mode").value;
		return 1;
		} 
	 
	 function funSearchLoad(){
			changeContent('pownerMainSearch.jsp'); 
		 }
	 
	 function funFocus()
	    {
	    	$('#jqxDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 function setValues(){
		 $("#formdetail").val("Property Owner");
	     $("#formdetailcode").val("RPRO");
	     $("#formdet").html("Property Owner(RPRO)");
		 window.parent.formCode.value="RPRO";
		 window.parent.formName.value="Property Owner"; 
		 
		 getCurrencyIds();
		 if($('#hidjqxDate').val()){ 
			 $("#jqxDate").jqxDateTimeInput('val', $('#hidjqxDate').val());
		  }
		 if($('#hidjqxBirthDate').val()){
			 $("#jqxBirthDate").jqxDateTimeInput('val', $('#hidjqxBirthDate').val());
		  }
		 if($('#hidjqxexpiryDate').val()){
			 $("#jqxexpiryDate").jqxDateTimeInput('val', $('#hidjqxexpiryDate').val());
		  }
		 
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
		  }
		 
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		 
		 $("#accgriddiv").load("accountGrid.jsp?docno="+$("#docno").val());
		 $("#splinsdiv").load("splinstructionGrid.jsp?docno="+$("#docno").val()+"&id="+1);                          
		 
		 var acno=$('#hidowneraccount').val();
		 
		 if(acno!="")
		 {
			 $('#divownerac').show();
			 $('#lblowneraccount').text("Owner Account Number: " + acno);
		 }
		 funSetlabel();
		  
		}
	 
	/*  function funChkButton() {
			/* funReset(); */
	//	} 
	 
	 /* Validations */
	 /* $(function(){
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
	        });}); */
	 
	/*  function funExcelBtn(){
		    var url=document.URL;
		    var reurl=url.split("suppliers");
		    top.addTab("VendorList",reurl[0]+"suppliers/vendorList.jsp");
		} */
		function isNumber(evt,id) {
			//Function to restrict characters and enter number only
				  var iKeyCode = (evt.which) ? evt.which : evt.keyCode
			        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
			         {
			        	 $.messager.alert('Warning','Enter Numbers Only');			         
			             $("#"+id+"").focus();
			             return false;			            
			         }
			        
			        return true;
			    }
	function getBDcenter(event)	{
			var x= event.keyCode;
		    if(x==114){
		     bdcSearchContent('nationsearchGrid.jsp');
		    }
		    else{
		     }
		}
		function bdcSearchContent(url) {
		    $('#nationalityWindow').jqxWindow('open');
		 $.get(url).done(function (data) {
		 $('#nationalityWindow').jqxWindow('setContent', data);
		 $('#nationalityWindow').jqxWindow('bringToFront');
		}); 
		 
		}
		function ValidateNo(event,id) {
	        var phoneNo = document.getElementById(id);
	        if(phoneNo.value.length == 0){
	        }
	        else if (phoneNo.value.length < 12 || phoneNo.value.length > 12 || phoneNo.value.length == 0) {
	        	 //$.messager.alert('Warning','Enter 12 Digit Mobile Number');
	        	  $('#valmsg').html('Enter 12 Digit Mobile Number');
	        	 $('#validation_modal').modal('show');
	            return false;
	        
	        }
	        return true;
	        }
		
		
		function getCountry() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					var countryId  = items[0].split(":");
					var country = items[1].split(":");
					var optionscard = '<option value="">--Select--</option>';
					for (var i = 0; i < country.length; i++) {
						optionscard += '<option value="' + countryId[i] + '">'
								+ country[i] + '</option>';
					}
					$("select#cmbbankcountry").html(optionscard);
				/* 	if ($('#hidcmbcountry').val() != null) {
						$('#cmbcountry').val($('#hidcmbcountry').val());
					} */
				} else {
				}
			};
			x.open("GET", "getCountry.jsp", true);
			x.send();
		}  
		
		
	function funAddtoGrid() 
	{			
		var rowid=$('#gridrowindex').val();
		
		if( typeof (rowid) != "undefined" && typeof (rowid) != "NaN" && rowid != "")
		{ 
			$('#jqxaccGrid').jqxGrid('setcellvalue',  rowid, "bankname", document.getElementById("txtbankname").value);
			$('#jqxaccGrid').jqxGrid('setcellvalue',  rowid, "accnumber", document.getElementById("txtaccountno").value);
			$('#jqxaccGrid').jqxGrid('setcellvalue',  rowid, "accname", document.getElementById("txtaccountname").value);
			$('#jqxaccGrid').jqxGrid('setcellvalue',  rowid, "bankaddress", document.getElementById("txtbankaddress").value);
			$('#jqxaccGrid').jqxGrid('setcellvalue',  rowid, "countryid", document.getElementById("cmbbankcountry").value);			
			$('#jqxaccGrid').jqxGrid('setcellvalue',  rowid, "currencyid", document.getElementById("cmbcurrency").value);
			$('#jqxaccGrid').jqxGrid('setcellvalue',  rowid, "swiftcode", document.getElementById("txtbankswift").value);
			$('#jqxaccGrid').jqxGrid('setcellvalue',  rowid, "iban", document.getElementById("txtbankiban").value);
			$('#jqxaccGrid').jqxGrid('setcellvalue',  rowid, "remarks", document.getElementById("txtbankremarks").value);
			$('#jqxaccGrid').jqxGrid('setcellvalue',  rowid, "doc_no", document.getElementById("accdocno").value);
			$('#jqxaccGrid').jqxGrid('setcellvalue',  rowid, "chk", document.getElementById("defaultacc").value);
			$('#jqxaccGrid').jqxGrid('setcellvalue',  rowid, "currency",$("#cmbcurrency option:selected").text());
			$('#jqxaccGrid').jqxGrid('setcellvalue',  rowid, "country", $("#cmbbankcountry option:selected").text());
		}
		else
		{
			 var bname = $('#txtbankname').val();
			 var ano=$('#txtaccountno').val();
			 var aname = $('#txtaccountname').val();
			 var baddr=$('#txtbankaddress').val();
			 var bcountryid = $('#cmbbankcountry').val();
			 var bcountry=$("#cmbbankcountry option:selected").text();
			 var currencyid=$('#cmbcurrency').val();
			 var currency=$("#cmbcurrency option:selected").text();
			 var swiftcode = $('#txtbankswift').val();
			 var iban=$('#txtbankiban').val();
			 var remark = $('#txtbankremarks').val(); 
			 var doc=$('#accdocno').val(); 
            
			 var data = {
            	 doc_no:doc,
                 bankname: bname,
                 accnumber:ano,
                 accname:aname,
                 bankaddress:baddr,
                 countryid:bcountryid,
                 country:bcountry,
                 currencyid:currencyid,
                 currency:currency,
                 swiftcode:swiftcode,
                 iban:iban,
                 remarks:remark,
                 chk:false
             };
             
             $("#jqxaccGrid").jqxGrid('addrow', null, data);
		 }
		    
       clearinput();
            
	 }
	
		function clearinput()
		{
			  $('#txtbankname').val('');
			  $('#txtaccountno').val('');
			  $('#txtaccountname').val('');
			  $('#txtbankaddress').val('');
			  $('#cmbbankcountry').val('');
			  $('#cmbcurrency').val(''); 
			  $('#txtbankswift').val('');
			  $('#txtbankiban').val('');
			  $('#txtbankremarks').val(''); 
		}
		
		/* $('#txttelepho').on('paste, blur', function ()
		{
			alert();
		
		}); */
</script>

<style>
.hidden-scrollbar {
	overflow: auto;
	height: 530px;
}

#btnaddtoGrid {
	background: #00c4ff;
	border: none;
	padding: 5px;
	width: 47px;
	color: #fff;
	height: 25px;
}
</style>

</head>
<body onload="setValues();getCountry();">
	<div id="mainBG" class="homeContent" data-type="background">
		<form id="frmPropertyOwner" action="savePropertyOwner" method="post"
			autocomplete="off">
			<jsp:include page="../../../header.jsp"></jsp:include><br />
			<div class='hidden-scrollbar'>
				<div class="clearfix"></div>
				<div class="container-fluid">

					<!-- margin: 5px; box-shadow: 1px 2px 7px 0px #ccc; -->
					<div class="row"> 
					<div class="col-md-3" id="divownerac" style="display:none;">
					<label id="lblowneraccount"  style="color:green;"></label> 
					
					</div>
					</div>
					<div class="row" style="padding: 1em 0px; border: #ccc;">
					 
						<div class="col-md-3">
							<div class="col-md-4">Doc No</div>
							<div class="col-md-8">
								<input type="text" id="docno" name="docno"
									style="text-align: right" tabindex="-1"
									value='<s:property value="docno"/>' />
							</div>
						</div>

						<div class="col-md-3">
							<div class="col-md-4">Owner ID</div>
							<div class="col-md-8">
								<input type="text" id="txtOwnerId" name="txtOwnerId"
									readonly="readonly" style="width: 100%;" tabindex="-1"
									value='<s:property value="docno"/>' />
							</div>
						</div>

						<div class="col-md-3">
							<div class="col-md-5">Ejari No</div>
							<div class="col-md-7">
								<input type="text" id="txtejarino" name="txtejarino"
									style="width: 100%;" value='<s:property value="txtejarino"/>' />
							</div>
						</div>

						<div class="col-md-3">
							<div class="col-md-3">Date</div>
							<div class="col-md-9">
								<div id="jqxDate" name="jqxDate"
									style="height: 23px !important;"
									value='<s:property value="jqxDate"/>'></div>
								<input type="hidden" id="hidjqxDate" name="hidjqxDate"
									value='<s:property value="hidjqxDate"/>' /> <input
									type="hidden" id="vocno" name="vocno" style="width: 50%;"
									tabindex="-1" value='<s:property value="vocno"/>' />
							</div>
						</div>
					</div>

					<div class="row">
						<ul class="nav nav-tabs" style="background: #d9edf7;">
							<li class="active"><a data-toggle="tab" href="#home">Owner
									Details</a></li>
							<li><a data-toggle="tab" href="#menu1">Passport Details</a></li>
							<li><a data-toggle="tab" href="#menu2">Account Details</a></li>
							<li><a data-toggle="tab" href="#menu3">Special Instruction</a></li>        
						</ul>

						<div class="tab-content">
							<div id="home" class="tab-pane fade in active">
								<div class="row" style="padding: 0.5em;">
									<div class="col-md-7">
										<div class="col-md-2">Primary Owner</div>
										<div class="col-md-10">
											<input type="text" id="txtprimeowner" name="txtprimeowner"
												required style="width: 100%;"
												value='<s:property value="txtprimeowner"/>' />
										</div>
									</div>
									<div class="col-md-5">
										<div class="col-md-3">Co Owner 1</div>
										<div class="col-md-9">
											<input type="text" id="txtcoowner1" name="txtcoowner1"
												style="width: 100%;"
												value='<s:property value="txtcoowner1"/>' />
										</div>
									</div>

								</div>

								<div class="row" style="padding: 0.5em;">
									<div class="col-md-7">
										<div class="col-md-2">Alias Name</div>
										<div class="col-md-10">
											<input type="text" id="txtaliasname" name="txtaliasname"
												style="width: 100%;"
												value='<s:property value="txtaliasname"/>' />
										</div>
									</div>
									<div class="col-md-5">
										<div class="col-md-3">Co Owner 2</div>
										<div class="col-md-9">
											<input type="text" id="txtcoowner2" name="txtcoowner2"
												style="width: 100%;"
												value='<s:property value="txtcoowner2"/>' />
										</div>
									</div>

								</div>
								<div class="row" style="padding: 0.5em;">
									<div class=col-md-12>
										<div class="col-md-1">Special Instruction</div>
										<div class="col-md-11" style="padding-left: 31px;">
											<input type="text" id="txtspecialinstructions"
												name="txtspecialinstructions" style="width: 100%;"
												value='<s:property value="txtspecialinstructions"/>' />
										</div>
									</div>
								</div>

								<div class="panel panel-default" style="font-size: 1em;">
									<div class="panel-heading">Personal Details</div>
									<div class="panel-body">
										<div class="row" style="padding: 0.5em;">
											<div class="col-md-4">
												<div class="col-md-3">DOB</div>
												<div class="col-md-9">
													<div id="jqxBirthDate" name="jqxBirthDate"
														style="width: 100%;"
														value='<s:property value="jqxBirthDate"/>'></div>
													<input type="hidden" id="hidjqxBirthDate"
														name="hidjqxBirthDate"
														value='<s:property value="hidjqxBirthDate"/>' />
												</div>
											</div>
											<div class="col-md-8">
												<div class="col-md-1">Address1</div>
												<div class="col-md-11">
													<input type="text" id="txtaddress" name="txtaddress"
														style="width: 100%;"
														value='<s:property value="txtaddress"/>' />
												</div>
											</div>

										</div>
										<div class="row" style="padding: 0.5em;">
											<div class="col-md-4">
												<div class="col-md-3">Telephone1</div>
												<div class="col-md-9">
													<input type="text" id="txttelepho" name="txttelepho" maxlength="15" 
														onkeypress="javascript:return isNumber (event,id)"
														style="width: 100%;"
														value='<s:property value="txttelepho"/>' />
												</div>
											</div>
											<div class="col-md-8">
												<div class="col-md-1">Address2</div>
												<div class="col-md-11">
													<input type="text" id="txtaddress2" name="txtaddress2"
														style="width: 100%;"
														value='<s:property value="txtaddress2"/>' />
												</div>
											</div>
										</div>
										<div class="row" style="padding: 0.5em;">
											<div class="col-md-4">
												<div class="col-md-3">Telephone2</div>
												<div class="col-md-9">
													<input type="text" id="txttelepho2" name="txttelepho2" maxlength="15"
														onkeypress="javascript:return isNumber (event,id)"
														style="width: 100%;"
														value='<s:property value="txttelepho2"/>' />
												</div>
											</div>
											<div class="col-md-4">
												<div class="col-md-2">Mobile1</div>
												<div class="col-md-10">
													<input type="text" id="txtmobpho" name="txtmobpho" maxlength="15"
													onkeypress="javascript:return isNumber (event,id)" style="width: 100%;"
														value='<s:property value="txtmobpho"/>' />
												</div>
											</div>
											<div class="col-md-4">
												<div class="col-md-2">Mobile2</div>
												<div class="col-md-10">
													<input type="text" id="txtmobpho2" name="txtmobpho2" maxlength="15"
														onkeypress="javascript:return isNumber (event,id)" style="width: 100%;"
														value='<s:property value="txtmobpho2"/>' />
												</div>
											</div>
										</div>
										<div class="row" style="padding: 0.5em;">
											<div class="col-md-4">
												<div class="col-md-3">Email1</div>
												<div class="col-md-9">
													<input type="email" id="txtemail" name="txtemail"
														style="width: 100%;"
														value='<s:property value="txtemail"/>' />
												</div>
											</div>
											<div class="col-md-4">
												<div class="col-md-2">Email2</div>
												<div class="col-md-10">
													<input type="email" id="txtemail2" name="txtemail2"
														style="width: 100%;"
														value='<s:property value="txtemail2"/>' />
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

							<!-- first menu content -->
							<div id="menu1" class="tab-pane fade">
								<div class="row" style="padding: 0.5em;">
									<div class="col-md-5">
										<div class="col-md-3">Passport Number</div>
										<div class="col-md-5">
											<input type="text" id="txtpassport" name="txtpassport"
												style="width: 100%;"
												value='<s:property value="txtpassport"/>' />
										</div>
									</div>
									<div class="col-md-5">
										<div class="col-md-3">Place Of Issue</div>
										<div class="col-md-5">
											<input type="text" id="txtissuedplace" name="txtissuedplace"
												style="width: 100%;"
												value='<s:property value="txtissuedplace"/>' />
										</div>
									</div>
								</div>
								<div class="row" style="padding: 0.5em;">
									<div class="col-md-5">
										<div class="col-md-3">Expiry Date</div>
										<div class="col-md-5">
											<div id="jqxexpiryDate" name="jqxexpiryDate"
												style="width: 65%;"
												value='<s:property value="jqxexpiryDate"/>'></div>
											<input type="hidden" id="hidjqxexpiryDate"
												name="hidjqxexpiryDate"
												value='<s:property value="hidjqxexpiryDate"/>' />
										</div>
									</div>
									<div class="col-md-5">
										<div class="col-md-3">Nationality</div>
										<div class="col-md-5">
											<input type="text" id="txtnationality" name="txtnationality"
												style="width: 100%;" placeholder="Press F3 to Search"
												onkeydown="getBDcenter(event)"
												value='<s:property value="txtnationality"/>' />&nbsp;&nbsp;
											<input type="hidden" id="natid" name="natid"
												value='<s:property value="natid"/>' />
										</div>
									</div>
								</div>
							</div>
							<div id="menu2" class="tab-pane fade">
								<div class="row" style="padding: 0.2em">
									<div class="col-md-4">
										<div class="col-md-4">Bank Name</div>
										<div class="col-md-8" style="padding-left: 22px;">
											<input type="text" id="txtbankname" name="txtbankname"
												style="width: 100%;"
												value='<s:property value="txtbankname"/>' />
										</div>
									</div>
									<div class="col-md-4">
										<div class="col-md-3">Account No.</div>
										<div class="col-md-9">
											<input type="text" id="txtaccountno" name="txtaccountno"
												style="width: 100%;"
												value='<s:property value="txtaccountno"/>' />
										</div>
									</div>
									<div class="col-md-4">
										<div class="col-md-3">Account Name</div>
										<div class="col-md-8">
											<input type="text" id="txtaccountname" name="txtaccountname"
												style="width: 100%;"
												value='<s:property value="txtaccountname"/>' />
										</div>
									</div>
								</div>
								<div class="row" style="padding: 0.2em">
									<div class="col-md-8">
										<div class="col-md-2">Bank Address</div>
										<div class="col-md-10" style="padding-left: 16px;">
											<input type="text" id="txtbankaddress" name="txtbankaddress"
												style="width: 100%;"
												value='<s:property value="txtbankaddress"/>' />
										</div>
									</div>
									<div class="col-md-4">
										<div class="col-md-3">Country</div>
										<div class="col-md-8">
											<%-- <input type="text" id="txtbankcountry" name="txtbankcountry"
												style="width: 100%;"
												value='<s:property value="txtbankcountry"/>' /> --%>

											<select id="cmbbankcountry" name="cmbbankcountry"
												style="width: 100%;"></select>
										</div>
									</div>
								</div>
								<div class="row" style="padding: 0.2em">
									<div class="col-md-4">
										<div class="col-md-4">Preferred currency</div>
										<div class="col-md-8" style="padding-left: 18px;">
											<select id="cmbcurrency" name="cmbcurrency"
												style="height: 23px; padding: 0"
												value='<s:property value="cmbcurrency"/>'>
												<option value="">--Select--</option>
											</select> <input type="hidden" id="hidcmbcurrency"
												name="hidcmbcurrency"
												value='<s:property value="hidcmbcurrency"/>' />
										</div>
									</div>
									<div class="col-md-4">
										<div class="col-md-3">Swift code</div>
										<div class="col-md-9">
											<input type="text" id="txtbankswift" name="txtbankswift"
												style="width: 100%;"
												value='<s:property value="txtbankswift"/>' />
										</div>
									</div>
									<div class="col-md-4">
										<div class="col-md-3">IBAN</div>
										<div class="col-md-8">
											<input type="text" id="txtbankiban" name="txtbankiban"
												style="width: 100%;"
												value='<s:property value="txtbankiban"/>' />
										</div>
									</div>
								</div>
								<div class="row" style="padding: 0.2em">
									<div class="col-md-8">
										<div class="col-md-2">Remarks</div>
										<div class="col-md-10">
											<input type="text" id="txtbankremarks" name="txtbankremarks"
												style="width: 100%;"
												value='<s:property value="txtbankremarks"/>' />
										</div>
									</div>
									<div class="col-md-4">
										<div class="col-md-3">
											<input type="button" id="btnaddtoGrid"
												onclick="funAddtoGrid();" class="btnaddgrid" value="Add">
										</div>
									</div>
									<input type="hidden" id="accdocno" name="accdocno"
										value='<s:property value="accdocno"/>' /> <input
										type="hidden" id="defaultacc" name="defaultacc"
										value='<s:property value="defaultacc"/>' />
								</div>
								<div class="row" style="padding: 0.5em">
									<div id="accgriddiv" style="padding: 1em">
										<jsp:include page="accountGrid.jsp"></jsp:include><br />
									</div>
								</div>
							</div>
							
							<div id="menu3" class="tab-pane fade">
								<div class="row" style="padding: 0.5em">
									<div id="splinsdiv" style="padding: 1em">
										<jsp:include page="splinstructionGrid.jsp"></jsp:include><br />
									</div>
								</div>
							</div>    
							
						</div>
					</div>
				</div>
				<input type="hidden" id="mode" name="mode" /> <input type="hidden"
					id="deleted" name="deleted" value='<s:property value="deleted"/>' />
				<input type="hidden" id="msg" name="msg"
					value='<s:property value="msg"/>' /> <input type="hidden"
					id="txtmobilevalidation" name="txtmobilevalidation"
					value='<s:property value="txtmobilevalidation"/>' /> <input
					type="hidden" id="typeallowed" name="typeallowed"
					value='<s:property value="typeallowed"/>' /> <input type="hidden"
					id="gridrowindex" name="gridrowindex"
					value='<s:property value="gridrowindex"/>' />      
					<input type="hidden" id="splgridlength" name="splgridlength" value='<s:property value="splgridlength"/>' />
					<input type="hidden" id="accgridlength" name="accgridlength" value='<s:property value="accgridlength"/>' />
					<input type="hidden" id="hidowneraccount" name="hidowneraccount" value='<s:property value="hidowneraccount"/>' />
			</div>
		</form>
		<div id="nationalityWindow">
			<div></div>
		</div>
	</div>
</body>
</html>